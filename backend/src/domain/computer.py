import re
import socket

from src.config import AGENT_MAC

def computer_wol():
    mac_address = AGENT_MAC
    if not re.match(r"^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$", mac_address):
        raise ValueError("Invalid MAC address format")
    
    mac_bytes = bytes.fromhex(mac_address.replace(":", "").replace("-", ""))

    magic_packet = b'\xff' * 6 + mac_bytes * 16

    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        sock.sendto(magic_packet, ("255.255.255.255", 9))