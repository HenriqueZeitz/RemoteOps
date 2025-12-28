import os
import platform
import subprocess

import src.domain.services_state as services
from config import COMMANDS_DIR, SHUTDOWN_DELAY
from src.models.status_request import StatusRequest
from src.models.command_request import CommandRequest
from src.infra.process_utils import is_process_running
from src.domain.commands_registry import get_command_definition

def run_command(script_path):
    system = platform.system().lower()
    if system == "windows":
        return subprocess.run(["cmd", "/c", script_path], check=True)
    else:
        return subprocess.run(["bash", script_path], check=True)

def execute_command_handler(req: CommandRequest):
    command_def = get_command_definition(req.command)
    if not command_def:
        return {
            "status": "error",
            "message": "Command not registered"
        }
    
    system = platform.system().lower()
    ext = ".bat" if system == "windows" else ".sh"
    script_path = os.path.join(COMMANDS_DIR, f"{req.command}{ext}")

    if not os.path.exists(script_path):
        return {
            "status": "error",
            "message": "Command not found"
        }
    
    try:
        run_command(script_path)
        return {
            "status": "success",
            "data": {
                "command": req.command,
            },
        }
    except subprocess.CalledProcessError as e:
        return {
            "status": "error",
            "message": f"Command execution failed: {str(e)}",
        }

def commands_status_handler(req: StatusRequest):
    response = {}

    for command in req.commands:
        command_def = get_command_definition(command)
        if not command_def:
            response[command] = "unknown"
            continue

        process_name = command_def.get("process_name")
        if not process_name:
            response[command] = "unknown"
            continue

        running = is_process_running(process_name)
        response[command] = "running" if running else "stopped"
    
    return {
        "status": "success",
        "data": response,
    }

def power_off_handler():
    if services.any_service_running():
        return {
            "status": "blocked",
            "message": "services are still running",
        }

    try:
        if platform.system().lower() == "windows":
            subprocess.Popen(["shutdown", "/s", "/f", "/t", str(int(SHUTDOWN_DELAY))])
        else:
            subprocess.Popen(["shutdown", "-h", f"+{int(SHUTDOWN_DELAY)//60}"])
    except Exception:
        pass

    return {
        "status": "shutting_down",
        "data": {
            "delay_seconds": SHUTDOWN_DELAY,
        },
    }

def health_check_handler():
    return {
        "status": "ok",
    }