from fastapi import FastAPI
from src.api.routes import router, public_router
from src.infra.logging.setup import setup_logging
import logging

setup_logging()

logger = logging.getLogger(__name__)

logger.info("🚀 Raspberry Online via Docker!")

app = FastAPI(
    title="RemoteOps Backend",
    version="1.0.0",
)

app.include_router(public_router)
app.include_router(router)