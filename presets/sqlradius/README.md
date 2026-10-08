# GenieACS SQLRadius Preset — EG8145X6-10 Test

This is a **strict single-device test preset** for:

    00259E-EG8145X6-10-48575443C31563B1

It is intentionally not a production-wide preset.

## What it does

- Adds `sqlradius-test`
- Adds `sqlradius-managed`
- Reads the device identity
- Reads the Huawei legacy `InternetGatewayDevice` management-server parameters
- Enables Periodic Inform if exposed
- Sets Periodic Inform Interval to 300 seconds if exposed
- Logs firmware, hardware and provisioning-code values if exposed

## What it does NOT do

- No WAN/PPPoE configuration
- No VLAN change
- No Wi-Fi SSID/password change
- No firmware upgrade
- No reboot
- No factory reset

The device model is Huawei EG8145X6-10 and examples for this model use the legacy `InternetGatewayDevice` data model. GenieACS supports matching a preset by a MongoDB-style precondition and running a Provision script for the matching CPE. citeturn969052search0turn179860search0

## Install

    cd presets/sqlradius
    chmod +x install.sh
    NBI_URL=http://127.0.0.1:7557 ./install.sh

The target can be overridden without editing the script:

    TEST_DEVICE_ID='00259E-EG8145X6-10-48575443C31563B1' \
    NBI_URL=http://127.0.0.1:7557 ./install.sh

## Verify preset

    curl -sS 'http://127.0.0.1:7557/presets/sqlradius-test-01-eg8145x6-10'

## Verify device

Use the exact ID as a query parameter. Be careful with URL encoding because GenieACS device IDs can contain characters that require encoding. citeturn969052search0

    curl -sS --get 'http://127.0.0.1:7557/devices/' \
      --data-urlencode 'query={"_id":"00259E-EG8145X6-10-48575443C31563B1"}' \
      --data-urlencode 'projection=_id,_tags,DeviceID,InternetGatewayDevice.ManagementServer,InternetGatewayDevice.DeviceInfo'

## Next phase

After this exact device is stable, we will create the reusable Huawei/EG8145X6-10 model preset and then connect SQLRadius tenant/customer data to the GenieACS NBI.
