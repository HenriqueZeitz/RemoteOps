from typing import List
from pydantic import BaseModel

class StatusRequest(BaseModel):
    commands: List[str]