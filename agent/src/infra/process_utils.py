import subprocess

def is_process_running(process_name: str) -> bool:
    try:
        # TODO: Implementar suporte para Linux (ps aux | grep process_name)
        result = subprocess.check_output(
            ["tasklist"],
            text=True,
            creationflags=subprocess.CREATE_NO_WINDOW
        )
        return process_name.lower() in result.lower()
    except Exception:
        return False