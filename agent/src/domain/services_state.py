from src.infra.process_utils import is_process_running
from src.domain.commands_registry import load_commands_registry

def is_command_running(command) -> bool:
    registry = load_commands_registry()
    
    command_def = registry.get(command)
    if not command_def:
        return False
    
    process_name = command_def.get("process_name")
    if not process_name:
        return False
    
    return is_process_running(process_name)