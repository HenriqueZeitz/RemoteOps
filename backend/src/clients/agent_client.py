import requests
from src.config import AGENT_BASE_URL, AGENT_TOKEN
import logging

logger = logging.getLogger(__name__)

HEADERS = {
    "Authorization": f"Bearer {AGENT_TOKEN}",
}

def check_agent_health():
    try:
        resp = requests.get(f"{AGENT_BASE_URL}/health", headers=HEADERS, timeout=3)
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        logger.error(f"Falha ao checar o health do agent: {e}")


def agent_execute(req):
    try:
        resp = requests.post(
            f"{AGENT_BASE_URL}/commands/execute",
            json=req.dict(),
            headers=HEADERS,
            timeout=10,
        )
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        logger.error(f"O agent falhou ao executar um comando: {e}")

def check_commands_status(req):
    try:
        resp = requests.post(
            f"{AGENT_BASE_URL}/commands/status",
            json=req.dict(),
            headers=HEADERS,
            timeout=5,
        )
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        logger.error(f"O agent falhou ao checar o status dos comandos: {e}")

def computer_shutdown():
    try:
        resp = requests.post(
            f"{AGENT_BASE_URL}/computer/power/off",
            headers=HEADERS,
            timeout=5,
        )
        resp.raise_for_status()
        logger.info("O computador foi desligado remotamente com sucesso.")
        return resp.json()
    except Exception as e:
        logger.error(f"Falha ao solicitar o desligamento da máquina pelo agent: {e}")