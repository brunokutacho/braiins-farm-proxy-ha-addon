# Security policy

This add-on sits between your miners and your pool, so security reports are taken seriously.

## Reporting a vulnerability
Please do **not** open a public issue. Use GitHub's **Report a vulnerability** button in the
**Security** tab of this repository (private vulnerability reporting).
Include what you found, how to reproduce it and which version is affected.

## Scope
- In scope: the files in this repository (Dockerfile, `run.sh`, nginx configuration, scripts, workflow).
- Out of scope: vulnerabilities in Braiins Farm Proxy itself. Report those to Braiins.

## Known limitations (documented, not vulnerabilities)
- Miner → proxy traffic is Stratum V1 in clear text inside your LAN.
- Port 3333 has no authentication.
- The web interface uses HTTP basic auth over plain HTTP.
