# app/main.py
import os
import asyncio
from fastapi import FastAPI
from aiokafka import AIOKafkaProducer, AIOKafkaConsumer

BOOTSTRAP = os.getenv("KAFKA_BOOTSTRAP_SERVERS", "kafka:9092")
DEFAULT_TOPIC = "test-topic"

app = FastAPI()
producer: AIOKafkaProducer | None = None
consumer_task: asyncio.Task | None = None

async def start_producer():
    global producer
    producer = AIOKafkaProducer(bootstrap_servers=BOOTSTRAP)
    await producer.start()

async def stop_producer():
    global producer
    if producer:
        await producer.stop()

async def consume_loop(topic: str):
    consumer = AIOKafkaConsumer(
        topic,
        bootstrap_servers=BOOTSTRAP,
        group_id="fastapi-group",
        auto_offset_reset="earliest",
        enable_auto_commit=True,
    )
    await consumer.start()
    try:
        async for msg in consumer:
            print(f"[CONSUMED] {msg.topic}:{msg.partition}@{msg.offset} -> {msg.value.decode('utf-8')}")
    finally:
        await consumer.stop()

@app.on_event("startup")
async def on_startup():
    await start_producer()
    
    await asyncio.sleep(1)
    global consumer_task
    consumer_task = asyncio.create_task(consume_loop(DEFAULT_TOPIC))

@app.on_event("shutdown")
async def on_shutdown():
    await stop_producer()
    if consumer_task:
        consumer_task.cancel()

@app.get("/")
async def root():
    return {"status": "ok"}

@app.post("/produce")
async def produce(message: str, topic: str = DEFAULT_TOPIC):
    assert producer is not None, "Producer not ready"
    await producer.send_and_wait(topic, message.encode("utf-8"))
    return {"status": "sent", "topic": topic, "message": message}