from pydantic import BaseModel

class CommandRequest(BaseModel):
    command: str
    start_command: bool