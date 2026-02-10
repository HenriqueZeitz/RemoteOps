import logging
import json
import os
from config import COMMANDS_DIR

logger = logging.getLogger(__name__)

_REGISTRY_CACHE = None

def load_commands_registry():
    global _REGISTRY_CACHE

    if _REGISTRY_CACHE is not None:
        return _REGISTRY_CACHE
    
    registry_path = os.path.join(COMMANDS_DIR, "commands_registry.json")
    if not os.path.exists(registry_path):
        logger.critical("Arquivo de registro de comandos não encontrado: %s", registry_path)
        raise RuntimeError("Arquivo de registro de comandos não encontrado")
    
    with open(registry_path, "r", encoding="utf-8") as f:
        _REGISTRY_CACHE = json.load(f)
    return _REGISTRY_CACHE

def get_command_definition(command):
    registry = load_commands_registry()
    return registry.get(command)
