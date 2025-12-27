import os
from dotenv import load_dotenv
from fastapi import Header, HTTPException

def verify_api_key(x_api_key: str = Header(...)):
    load_dotenv()
    SECRET_KEY = os.getenv("API_KEY")

    if x_api_key != SECRET_KEY:
        raise HTTPException(status_code=401, detail="Unauthorized")