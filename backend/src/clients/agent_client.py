import requests
from src.config import AGENT_BASE_URL, AGENT_TOKEN

HEADERS = {
    "Authorization": f"Bearer {AGENT_TOKEN}",
}

def check_agent_health():
    resp = requests.get(f"{AGENT_BASE_URL}/health", headers=HEADERS, timeout=3)
    resp.raise_for_status()
    return resp.json()

def agent_execute(req):
    resp = requests.post(
        f"{AGENT_BASE_URL}/commands/execute",
        json=req.dict(),
        headers=HEADERS,
        timeout=10,
    )
    resp.raise_for_status()
    return resp.json()

def check_commands_status(req):
    resp = requests.post(
        f"{AGENT_BASE_URL}/commands/status",
        json=req.dict(),
        headers=HEADERS,
        timeout=5,
    )
    resp.raise_for_status()
    return resp.json()

def computer_shutdown():
    resp = requests.post(
        f"{AGENT_BASE_URL}/computer/power/off",
        headers=HEADERS,
        timeout=5,
    )
    resp.raise_for_status()
    return resp.json()