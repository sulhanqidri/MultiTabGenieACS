#!/usr/bin/env bash
set -euo pipefail

NBI_URL="${NBI_URL:-http://127.0.0.1:7557}"
CURL=(curl -sS -f --retry 3 --retry-delay 1)

put_provision() {
  local name="$1"
  local script="$2"
  echo "Installing provision: $name"
  "${CURL[@]}" -X PUT "${NBI_URL}/provisions/${name}" \
    -H 'Content-Type: text/plain; charset=utf-8' \
    --data-binary @- <<<"$script" >/dev/null
}

put_preset() {
  local name="$1"
  local json="$2"
  echo "Installing preset: $name"
  "${CURL[@]}" -X PUT "${NBI_URL}/presets/${name}" \
    -H 'Content-Type: application/json' \
    --data-binary "$json" >/dev/null
}

# Test-only scope. This preset matches exactly one CPE.
TEST_DEVICE_ID="${TEST_DEVICE_ID:-00259E-EG8145X6-10-48575443C31563B1}"

put_provision "sqlradius_test_eg8145x6" '
const now = Date.now();

declare("Tags.sqlradius-test", null, {value: true});
declare("Tags.sqlradius-managed", null, {value: true});

let serial = declare("DeviceID.SerialNumber", {value: now});
let model = declare("DeviceID.ProductClass", {value: now});
let manufacturer = declare("DeviceID.Manufacturer", {value: now});
let oui = declare("DeviceID.OUI", {value: now});

log("SQLRadius test CPE: manufacturer=" + (manufacturer.size ? manufacturer.value[0] : "") +
    " oui=" + (oui.size ? oui.value[0] : "") +
    " productClass=" + (model.size ? model.value[0] : "") +
    " serial=" + (serial.size ? serial.value[0] : ""));

let piEnable = declare("InternetGatewayDevice.ManagementServer.PeriodicInformEnable", {value: now});
if (piEnable.size) {
  declare("InternetGatewayDevice.ManagementServer.PeriodicInformEnable", null, {value: true});
}

let piInterval = declare("InternetGatewayDevice.ManagementServer.PeriodicInformInterval", {value: now});
if (piInterval.size) {
  declare("InternetGatewayDevice.ManagementServer.PeriodicInformInterval", null, {value: 300});
}

let sw = declare("InternetGatewayDevice.DeviceInfo.SoftwareVersion", {value: now});
if (sw.size) {
  log("SQLRadius test CPE software=" + sw.value[0]);
}

let hw = declare("InternetGatewayDevice.DeviceInfo.HardwareVersion", {value: now});
if (hw.size) {
  log("SQLRadius test CPE hardware=" + hw.value[0]);
}

let provCode = declare("InternetGatewayDevice.DeviceInfo.ProvisioningCode", {value: now});
if (provCode.size) {
  log("SQLRadius test CPE provisioningCode=" + provCode.value[0]);
}
'

put_preset "sqlradius-test-01-eg8145x6-10" "{
  \"weight\": 0,
  \"precondition\": \"{\\\"_id\\\": \\\"${TEST_DEVICE_ID}\\\"}\",
  \"configurations\": [
    {
      \"type\": \"provision\",
      \"name\": \"sqlradius_test_eg8145x6\"
    }
  ]
}"

echo
echo "GenieACS SQLRadius test preset installed."
echo "NBI: ${NBI_URL}"
echo "Target device: ${TEST_DEVICE_ID}"
echo
echo "No WAN/PPPoE, Wi-Fi, VLAN, firmware, reboot, or factory-reset changes are performed."
