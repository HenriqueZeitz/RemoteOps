import os
from dotenv import load_dotenv
from fastapi import Header, HTTPException

load_dotenv()
SECRET_KEY = os.getenv("API_KEY")

def verify_bearer_token(authorization: str = Header(...)):
    if not authorization.startswith("Bearer "):
        raise HTTPException(
            status_code=401,
            detail="Invalid authorization scheme"
        )
    
    token = authorization.replace("Bearer ", "", 1)

    if token != SECRET_KEY:
        raise HTTPException(
            status_code=401, 
            detail="Unauthorized"
        )