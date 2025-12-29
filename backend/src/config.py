import os
from dotenv import load_dotenv

load_dotenv()

AGENT_BASE_URL = os.getenv("AGENT_BASE_URL", "http://localhost:8001")
AGENT_TOKEN = os.getenv("AGENT_TOKEN", "")