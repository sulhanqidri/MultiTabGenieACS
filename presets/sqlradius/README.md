# GenieACS SQLRadius Preset Baseline

This directory contains a vendor-neutral GenieACS baseline for later SQLRadius integration.

## Scope

- Tag managed CPEs with `sqlradius-managed`
- Keep Periodic Inform enabled at 300 seconds where the CPE exposes the standard TR-069 parameter
- Refresh identity/inventory data without forcing a full data-model discovery on every inform
- Keep vendor/ONT-specific configuration out of the baseline

## Why this is intentionally conservative

GenieACS presets/provisions should be idempotent and should converge to a stable state. Vendor-specific parameters are not applied until a real CPE data model has been inspected.

The baseline does not change WAN/PPPoE, Wi-Fi SSID/password, VLAN, firmware, reboot, or factory-reset state.

## Install

Run:

    cd presets/sqlradius
    chmod +x install.sh
    sudo ./install.sh

By default the script targets:

    http://127.0.0.1:7557

Override with:

    NBI_URL=http://127.0.0.1:7557 sudo ./install.sh

After installation verify:

    curl -sS "$NBI_URL/presets/"
    curl -sS "$NBI_URL/provisions/"

## SQLRadius integration contract

SQLRadius will later use GenieACS NBI as the device-management source:

- Device identity: `DeviceID.ID`, `DeviceID.SerialNumber`, `DeviceID.ProductClass`, `DeviceID.OUI`, `DeviceID.Manufacturer`
- Managed scope: tag `sqlradius-managed`
- Device control: GenieACS NBI tasks
- Tenant association: owned by SQLRadius, not encoded into vendor-specific CPE parameters

Tenant tags can be added later using a controlled naming scheme such as:

    tenant:<tenant-id>

Do not expose the NBI port publicly without an authentication and network-access control layer.
