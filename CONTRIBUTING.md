# Contributing

Thanks for helping! This is a small, security-minded project: contributions of any size are welcome,
from fixing a typo to adding a feature.

## Report a problem
Open an issue using the **Bug report** template. Before pasting logs, screenshots or configuration,
**remove personal data**: account and worker names, IP addresses, passwords, pool keys.
Problems with Braiins Farm Proxy itself (not with this packaging) belong to Braiins.

## Propose a change
1. Fork the repository and create a branch.
2. Make one focused change per pull request.
3. Test it on a real Home Assistant (see below) and say in the pull request what hardware you used.
4. If behavior changes: bump `version` in `braiins_sv2_proxy/config.yaml` and add a line to `braiins_sv2_proxy/CHANGELOG.md`.
5. Open the pull request and fill in the checklist.

## Test locally
1. Copy the `braiins_sv2_proxy` folder to the `/addons` folder of your Home Assistant.
2. Reload the Add-on Store (⋮ → Check for updates). The add-on shows up under **Local add-ons**.
3. Install it, set `web_password`, start it, and check the **Log** tab.
4. Point one miner at `<home-assistant-ip>:3333` and check the **Miners** page.

If you installed the add-on from this repository too, stop and uninstall one of them first: they use the same ports.

## Ground rules
- **No Braiins binaries in the repository.** The proxy is downloaded at build time and verified by SHA-256.
- To move to a new Braiins release, run `bash scripts/bump-braiins.sh <version>` and compare the checksums
  with the ones published at <https://downloads.braiins.com/braiins-proxy/> before opening the pull request.
- Keep the web interface protected: never publish it without a password.
- No personal data in code, examples or docs. Use placeholders such as `<home-assistant-ip>` and `account.worker`.
- Keep the add-on simple: prefer fewer options and safe defaults.

## Ideas where help is welcome
- Prebuilt container images, so installation does not need a build on the device.
- Testing on `amd64` and other hardware, and reports of which miners work.
- Optional generated password shown in the log, instead of requiring `web_password`.
- Home Assistant ingress support for the web interface.
- Icon and logo (without using Braiins' trademarks), more translations.

By contributing you agree that your contribution is licensed under the MIT license of this repository.
