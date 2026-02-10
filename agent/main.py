import logging
from fastapi import FastAPI
from src.api.routes import router, router_public
from config import DISCORD_WEBHOOK_URL
from hz_utils import init_global_logging

init_global_logging(app_name="RemoteOps", webhook_url=DISCORD_WEBHOOK_URL)

logger = logging.getLogger(__name__)
logger.info("🚀 Agent online!")

app = FastAPI(title="RemoteOps Agent", version="1.0.0")
app.include_router(router_public)
app.include_router(router)