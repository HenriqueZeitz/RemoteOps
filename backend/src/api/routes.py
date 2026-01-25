from fastapi import APIRouter, Depends

from src.domain.computer import computer_wol, is_computer_online
from src.models.status_request import StatusRequest
from src.api.auth import verify_bearer_token
from src.clients.agent_client import agent_execute, check_agent_health, check_commands_status, computer_shutdown
from src.models.command_request import CommandRequest


router = APIRouter(dependencies=[Depends(verify_bearer_token)])

@router.get("/health")
def health():
    return {"status": "ok"}

@router.get("/agent/health")
def computer_health():
    return check_agent_health()

@router.get("/computer/online")
def computer_online():
    return {
        "status": "online" if is_computer_online() else "offline"
    }

@router.post("/commands/status")
def commands_status(req: StatusRequest):
    return check_commands_status(req)

@router.post("/commands/execute")
def execute(req: CommandRequest):
    return agent_execute(req)

@router.post("/computer/power/on")
def power_on_computer():
    return computer_wol()

@router.post("/computer/power/off")
def power_off_computer():
    return computer_shutdown()