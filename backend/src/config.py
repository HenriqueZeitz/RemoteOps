import os
from dotenv import load_dotenv

load_dotenv()

AGENT_IP = os.getenv("AGENT_IP", "")
AGENT_TOKEN = os.getenv("AGENT_TOKEN", "")
AGENT_MAC = os.getenv("AGENT_MAC", "")
AGENT_BASE_URL = "http://{AGENT_IP}:8001"
