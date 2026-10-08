# EG8145X6-10 — SQLRadius Discovery Preset

Target device:

    00259E-EG8145X6-10-48575443C31563B1

The URL/log representation may display the hyphen in the device ID as %2D. The preset uses the decoded device ID.

## Purpose

This is the first integration-stage preset and is intentionally read-only.

It collects identity, device information, TR-069 management information, and WAN/LAN object instances.

It does NOT change Periodic Inform, Connection Request credentials, WAN/PPPoE, VLAN, Wi-Fi, firmware, reboot, or factory-reset state.

## Files

- sqlradius-test-eg8145x6-discovery.js — Provision script
- sqlradius-test-eg8145x6-discovery.preset.json — exact-device preset

## Next step

After the device model is visible, inspect the actual WAN path before creating any PPPoE/VLAN preset.
