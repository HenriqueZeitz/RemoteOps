import os
from dotenv import load_dotenv
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from fastapi import Depends, HTTPException, status

load_dotenv()
SECRET_KEY = os.getenv("API_KEY")

security = HTTPBearer()

def verify_bearer_token(credentials: HTTPAuthorizationCredentials = Depends(security)):
    token = credentials.credentials
    if token != SECRET_KEY:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Unauthorized"
        )

# def verify_bearer_token(authorization: str = Header(...)):
#     if not authorization.startswith("Bearer "):
#         raise HTTPException(
#             status_code=401,
#             detail="Invalid authorization scheme"
#         )
    
#     token = authorization.replace("Bearer ", "", 1)

#     if token != SECRET_KEY:
#         raise HTTPException(
#             status_code=401, 
#             detail="Unauthorized"
#         )