from fastapi import APIRouter, Depends

from src.api.auth import verify_api_key
from src.handlers.commands_handler import commands_status_handler, computer_status_handler, execute_command_handler, power_off_handler
from src.models.command_request import CommandRequest
from src.models.status_request import StatusRequest

router = APIRouter()

@router.post("/commands/status", dependencies=[Depends(verify_api_key)])
def commands_status(req: StatusRequest):
    return commands_status_handler(req)

@router.post("/commands/execute", dependencies=[Depends(verify_api_key)])
def execute_command(req: CommandRequest):
    return execute_command_handler(req)

@router.post("/computer/power/off", dependencies=[Depends(verify_api_key)])
def power_off():
    return power_off_handler()

@router.get("/computer/status", dependencies=[Depends(verify_api_key)])
def computer_status():
    return computer_status_handler()