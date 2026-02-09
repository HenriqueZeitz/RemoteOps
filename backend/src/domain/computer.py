import re
import socket
import logging

from src.config import AGENT_MAC, AGENT_IP
from src.infra.ping_utils import ping_host

logger = logging.getLogger(__name__)

def computer_wol():
    try:
        mac_address = AGENT_MAC
        if not re.match(r"^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$", mac_address):
            raise ValueError("Invalid MAC address format")
        
        mac_bytes = bytes.fromhex(mac_address.replace(":", "").replace("-", ""))

        magic_packet = b'\xff' * 6 + mac_bytes * 16

        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
            sock.sendto(magic_packet, ("255.255.255.255", 9))
        
        logger.info(f"Computador ligado via magic packet")
        return {
            "success": True,
            "message": "Magic packet sent successfully."
        }
    except Exception as e:
        logger.error(f"Falha ao ligar a máquina via WOL: {e}")
        return {
            "success": False,
            "message": f"Failed to send packet: {str(e)}"
        }

def is_computer_online():
    try:
        if not AGENT_IP:
            return False
        return ping_host(AGENT_IP)
    except Exception as e:
        logger.error(f"Falha ao testar o status do computador: {e}")