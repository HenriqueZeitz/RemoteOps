import os
import platform
import subprocess
import psutil

import src.domain.services_state as services
from config import COMMANDS_DIR, SHUTDOWN_DELAY
from src.models.status_request import StatusRequest
from src.models.command_request import CommandRequest
from src.infra.process_utils import is_process_running
from src.domain.commands_registry import get_command_definition
from src.infra.logger import logger

def run_command(command, dir):
    system = platform.system().lower()
    ext = ".bat" if system == "windows" else ".sh"
    script_path = os.path.join(COMMANDS_DIR, f"{command}{ext}")

    if system == "windows":
        return subprocess.Popen(["cmd", "/c", script_path], cwd=dir, shell=True)
    else:
        return subprocess.Popen(["bash", script_path], cwd=dir, start_new_session=True)

def stop_windows_process(command_def):
    for proc in psutil.process_iter(['name', 'cwd']):
        if proc.info['name'] == command_def["process_name"]:
            if command_def["dir"] in proc.info['cwd']:
                logger.info(f"Effective stop command")
                proc.kill()

def stop_linux_process(command_def):
    for proc in psutil.process_iter(['pid', 'name', 'cmdline']):
        if command_def['process_name'].lower() in proc.info['name'].lower():
            proc.terminate()
            return True

def stop_command(command_def):
    logger.info(f"Stoping command: {command_def}", extra={"COMMAND_DEF": command_def})
    system = platform.system().lower()
    if system == "windows":
        stop_windows_process(command_def)
    else:
        stop_linux_process(command_def)

def execute_command_handler(req: CommandRequest):
    command_def = get_command_definition(req.command)
    if not command_def:
        return {
            "status": "error",
            "message": "Command not registered"
        }
    try:
        if req.start_command:
            run_command(command_def["start"], command_def["dir"])
            return {
                "status": "success",
                "data": {
                    "command": req.command
                }
            }
        else:
            stop_command(command_def)
            return {
                "status": "success",
                "data": {
                    "command": req.command
                }
            }
    except Exception as e:
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
            "message": "commands are still running",
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