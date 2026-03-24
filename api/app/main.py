from fastapi import FastAPI
import os
import psycopg2
import redis

app = FastAPI()

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "postgres"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("DB_NAME", "nac"),
        user=os.getenv("DB_USER", "nacuser"),
        password=os.getenv("DB_PASSWORD", "nacpass"),
    )

def get_redis():
    return redis.Redis(
        host=os.getenv("REDIS_HOST", "redis"),
        port=int(os.getenv("REDIS_PORT", "6379")),
        decode_responses=True
    )

@app.get("/")
def root():
    return {"status": "ok"}

@app.get("/users")
def users():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT username, attribute, value FROM radcheck")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return {"users": rows}

@app.get("/sessions/active")
def active_sessions():
    r = get_redis()
    keys = r.keys("session:*")
    data = {k: r.get(k) for k in keys}
    return {"active_sessions": data}

@app.post("/auth")
def auth():
    return {"reply": "ok"}

@app.post("/authorize")
def authorize():
    return {
        "Tunnel-Type": "VLAN",
        "Tunnel-Medium-Type": "IEEE-802",
        "Tunnel-Private-Group-Id": "20"
    }

@app.post("/accounting")
def accounting():
    return {"status": "accounting received"}
