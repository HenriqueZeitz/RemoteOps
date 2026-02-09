import os
from pathlib import Path
from dotenv import load_dotenv

base_dir = Path(__file__).resolve().parent.parent
dotenv_path = os.path.join(base_dir, ".env")

load_dotenv(dotenv_path=dotenv_path)

AGENT_TOKEN = os.getenv("AGENT_TOKEN", "")
AGENT_MAC = os.getenv("AGENT_MAC", "")
AGENT_IP = os.getenv("AGENT_IP", "")
AGENT_BASE_URL = f"http://{AGENT_IP}:9000"

API_KEY = os.getenv("API_KEY", "")

DISCORD_BOT_URL = os.getenv("DISCORD_BOT_URL", "")