from fastapi import FastAPI
from src.api.routes import router


app = FastAPI(
    title="RemoteOps Backend",
    version="1.0.0",
)

app.include_router(router)