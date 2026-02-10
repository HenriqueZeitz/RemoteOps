import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
COMMANDS_DIR = os.path.join(BASE_DIR, "commands")
DISCORD_WEBHOOK_URL = os.getenv("DISCORD_WEBHOOK_URL", "")
SHUTDOWN_DELAY = 2