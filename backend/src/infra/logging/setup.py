import logging
from logging import Formatter
from src.infra.logging.discord_handler import DiscordHandler
from src.config import DISCORD_BOT_URL

def setup_logging():
    root_logger = logging.getLogger()
    root_logger.setLevel(logging.DEBUG)

    logging.getLogger("urllib3").setLevel(logging.WARNING)
    logging.getLogger("requests").setLevel(logging.WARNING)

    if root_logger.handlers:
        return
    
    formatter = Formatter(
        "%(message)s"
    )

    console_handler = logging.StreamHandler()
    console_handler.setFormatter(formatter)
    root_logger.addHandler(console_handler)

    if DISCORD_BOT_URL:
        discord_handler = DiscordHandler()
        discord_handler.setLevel(logging.DEBUG)
        discord_handler.setFormatter(formatter)
        root_logger.addHandler(discord_handler)