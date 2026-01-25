from fastapi import APIRouter, Depends

from src.api.auth import verify_bearer_token
from src.handlers.commands_handler import commands_status_handler, execute_command_handler, health_check_handler, power_off_handler
from src.models.command_request import CommandRequest
from src.models.status_request import StatusRequest

router = APIRouter(dependencies=[Depends(verify_bearer_token)])

@router.post("/commands/status")
def commands_status(req: StatusRequest):
    return commands_status_handler(req)

@router.post("/commands/execute")
def execute_command(req: CommandRequest):
    return execute_command_handler(req)

@router.post("/computer/power/off")
def power_off():
    return power_off_handler()

@router.get("/health")
def health_check():
    return health_check_handler()