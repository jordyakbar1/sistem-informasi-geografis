from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordRequestForm
from jose import jwt
import psycopg2
from pydantic import BaseModel

app = FastAPI()

# ================= CORS =================
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ================= DATABASE =================
conn = psycopg2.connect(
    host="localhost",
    database="sig_prak5",
    user="postgres",
    password="micinijo"
)

# ================= AUTH =================
SECRET_KEY = "SECRET123"
ALGORITHM = "HS256"

fake_user = {
    "username": "admin",
    "password": "123"
}

def authenticate_user(username, password):
    return username == fake_user["username"] and password == fake_user["password"]

def create_token(data: dict):
    return jwt.encode(data, SECRET_KEY, algorithm=ALGORITHM)

# ================= LOGIN =================
@app.post("/token")
def login(form_data: OAuth2PasswordRequestForm = Depends()):
    if not authenticate_user(form_data.username, form_data.password):
        raise HTTPException(status_code=401, detail="Login gagal")

    token = create_token({"sub": form_data.username})
    return {"access_token": token, "token_type": "bearer"}

# ================= MODEL =================
class Halte(BaseModel):
    nama: str
    jenis: str
    lat: float
    lon: float

# ================= GEOJSON =================
@app.get("/geojson")
def get_geojson():
    cur = conn.cursor()
    cur.execute("SELECT id, nama, jenis, ST_X(geom), ST_Y(geom) FROM halte")
    rows = cur.fetchall()

    features = []
    for row in rows:
        features.append({
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [row[3], row[4]]
            },
            "properties": {
                "id": row[0],
                "nama": row[1],
                "jenis": row[2]
            }
        })

    return {"type": "FeatureCollection", "features": features}

# ================= INSERT =================
@app.post("/halte")
def add_halte(data: Halte):
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO halte (nama, jenis, geom)
        VALUES (%s, %s, ST_SetSRID(ST_MakePoint(%s, %s), 4326))
    """, (data.nama, data.jenis, data.lon, data.lat))

    conn.commit()
    return {"message": "berhasil"}

# ================= DELETE =================
@app.delete("/halte/{id}")
def delete_halte(id: int):
    cur = conn.cursor()
    cur.execute("DELETE FROM halte WHERE id = %s", (id,))
    conn.commit()

    return {"message": "dihapus"}
