import logging
import requests
from src.config import DISCORD_BOT_URL

class DiscordHandler(logging.Handler):
    def emit(self, record):
        log_config = {
            "CRITICAL": {"color": 15158332, "emoji": "💀", "avatar": "https://cdn-icons-png.flaticon.com/512/753/753345.png" },
            "ERROR": {"color": 15158332, "emoji": "❌", "avatar": "https://cdn-icons-png.flaticon.com/512/564/564619.png"},
            "WARNING": {"color": 16770660, "emoji": "⚠️", "avatar": "https://cdn-icons-png.flaticon.com/512/595/595067.png"},
            "INFO": {"color": 3066993, "emoji": "✅", "avatar": "https://cdn-icons-png.flaticon.com/512/190/190411.png"},
            "DEBUG": {"color": 3447003, "emoji": "🔍", "avatar": "https://cdn-icons-png.flaticon.com/512/10329/10329881.png"},
        }

        config = log_config.get(record.levelname, log_config["INFO"])

        payload = {
            "username": f"RemoteOps - {record.levelname}",
            "avatar_url": config["avatar"],
            "embeds": [
                {
                    "title": f"{config['emoji']} - {record.levelname}",
                    "description": self.format(record),
                    "color": config["color"],
                    "footer": {
                        "text": f"Origem: {record.pathname}:{record.lineno}"
                    }
                }
            ]
        }

        try:
            requests.post(DISCORD_BOT_URL, json=payload, timeout=5)
        except Exception as e:
            print(f"Failed to send log to Discord: {e}")
            pass