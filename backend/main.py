from fastapi import FastAPI
from src.api.routes import router, public_router
from src.config import DISCORD_WEBHOOK_URL
from hz_utils import init_global_logging
import logging


init_global_logging(app_name="RemoteOps", webhook_url=DISCORD_WEBHOOK_URL)

logger = logging.getLogger(__name__)

logger.info("🚀 Raspberry Online via Docker!")

app = FastAPI(
    title="RemoteOps Backend",
    version="1.0.0",
)

app.include_router(public_router)
app.include_router(router)