from fastapi import APIRouter, Depends

from src.models.status_request import StatusRequest
from src.api.auth import verify_bearer_token
from src.clients.agent_client import agent_execute, check_agent_health, check_commands_status
from src.models.command_request import CommandRequest


router = APIRouter()

@router.get("/health", dependencies=[Depends(verify_bearer_token)])
def health():
    return {"status": "ok"}

@router.get("/agent/health", dependencies=[Depends(verify_bearer_token)])
def computer_health():
    return check_agent_health()

@router.post("/commands/execute", dependencies=[Depends(verify_bearer_token)])
def execute(req: CommandRequest):
    return agent_execute(req)

@router.post("/commands/status", dependencies=[Depends(verify_bearer_token)])
def commands_status(req: StatusRequest):
    return check_commands_status(req)