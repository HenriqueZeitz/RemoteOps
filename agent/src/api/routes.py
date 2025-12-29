from fastapi import APIRouter, Depends

from src.api.auth import verify_bearer_token
from src.handlers.commands_handler import commands_status_handler, execute_command_handler, health_check_handler, power_off_handler
from src.models.command_request import CommandRequest
from src.models.status_request import StatusRequest

router = APIRouter()

@router.post("/commands/status", dependencies=[Depends(verify_bearer_token)])
def commands_status(req: StatusRequest):
    return commands_status_handler(req)

@router.post("/commands/execute", dependencies=[Depends(verify_bearer_token)])
def execute_command(req: CommandRequest):
    return execute_command_handler(req)

@router.post("/computer/power/off", dependencies=[Depends(verify_bearer_token)])
def power_off():
    return power_off_handler()

@router.get("/health", dependencies=[Depends(verify_bearer_token)])
def health_check():
    return health_check_handler()