# Braiins Farm Proxy (SV2) – unofficial add-on

## Setup
1. Open the **Configuration** tab and set `web_password`.
2. Start the add-on and check the **Log** tab. You should see
   `Web interface protected by password on port 8080`.
3. Open `http://<HOME-ASSISTANT-IP>:8080` and log in as `admin`.
4. In each miner, set **both the main and the fallback pool** to
   `stratum+tcp://<HOME-ASSISTANT-IP>:3333`, with your usual `account.worker` user name.
   A fallback pool that points straight at a pool bypasses the proxy.
5. Check the **Miners** page of the web interface.

Give your Home Assistant a fixed IP (DHCP reservation), otherwise your miners lose their pool when it changes.

## Notes
- The miner → proxy hop is Stratum V1 in clear text, inside your LAN. The protection applies between the proxy and the pool.
- Port 3333 has no authentication (that is how Stratum works). Keep it on a trusted LAN and never forward it to the Internet.
- The web interface uses HTTP basic auth over plain HTTP: the password travels unencrypted inside your LAN.
- Configuration and history are stored in the add-on's `/data` and are kept across restarts and updates.
