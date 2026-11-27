# Braiins Farm Proxy – Home Assistant add-on (unofficial)

[Português](README.pt-BR.md)

Runs the [Braiins Farm Proxy](https://academy.braiins.com/farm-proxy/sv2-proxy/) on Home Assistant OS.
Your miners connect to the proxy on your LAN; the proxy talks to Braiins Pool over **Stratum V2**
(encrypted and authenticated), instead of the unencrypted Stratum V1 that makes
[hashrate hijacking](https://braiins.com/blog/bitcoin-hashrate-hijacking-unencrypted-stratum-v1) possible.

> **Unofficial.** This project is not made, endorsed or supported by Braiins. "Braiins" is a trademark of its owner.
> The proxy binary is **not** included in this repository: it is downloaded from `downloads.braiins.com`
> when the add-on is built, and its SHA-256 is verified against the value pinned in the `Dockerfile`.
> Check Braiins' own terms for the proxy before using it.

## Status
- Tested on a Raspberry Pi 5 running Home Assistant OS (aarch64) with a Bitaxe.
- `amd64` is built the same way but **untested**.
- Bundled Braiins Farm Proxy version: 0.1.1.

## Install
[![Add this repository to your Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbrunokutacho%2Fbraiins-farm-proxy-ha-addon)

Click the button above (it opens your own Home Assistant), confirm, and then install
**Braiins Farm Proxy (SV2)** from the Add-on Store.

Or do it by hand: **Settings → Add-ons** (called **Apps** in recent versions) **→ Add-on Store → ⋮ → Repositories**,
add `https://github.com/brunokutacho/braiins-farm-proxy-ha-addon`, and install the add-on. The first build takes a few minutes, because it happens on your device.

Then set `web_password` in the **Configuration** tab, start the add-on, and follow [the documentation](braiins_sv2_proxy/DOCS.md).

## How it works
- `braiins-proxy run` has no password option, and requests from loopback are not asked for one.
  So the proxy's web interface listens on `127.0.0.1:8081` inside the container only, and **nginx** publishes it on port 8080 with basic auth.
  If `web_password` is empty, the web interface is not exposed at all.
- Miners connect to port 3333.
- The proxy runs as an unprivileged user; its configuration lives in the add-on's `/data`.

## Security notes
- Miner → proxy is Stratum V1 in clear text on your LAN. Keep the proxy on a trusted network and do not forward port 3333 to the Internet.
- Port 3333 has no authentication. Remove any direct pool from your miners' fallback settings, or the proxy can be bypassed.
- The web interface uses basic auth over plain HTTP.

## Updating the Braiins Farm Proxy version
Run `scripts/bump-braiins.sh <version>`, review the diff, bump `version` in
`braiins_sv2_proxy/config.yaml` and add a line to the changelog.
The script reads the checksums from the same server as the binary, so they only protect against corrupted downloads:
compare them with the values on <https://downloads.braiins.com/braiins-proxy/> before publishing.

## Troubleshooting
Check the add-on's **Log** tab. If it is empty, find the container with `docker ps | grep braiins` and run `docker logs <name>`.
Open an issue with the log output, your hardware and the miner model.

## Contributing
Contributions are welcome: bug reports, testing on other hardware and miners, documentation, translations and code.
Read [CONTRIBUTING.md](CONTRIBUTING.md) first. Security issues: see [SECURITY.md](SECURITY.md).
By taking part you agree to the [code of conduct](CODE_OF_CONDUCT.md).

Maintainer: [Bruno Kutacho](https://github.com/brunokutacho).

## License
MIT for the files in this repository (see [LICENSE](LICENSE)). It does not cover Braiins Farm Proxy.
