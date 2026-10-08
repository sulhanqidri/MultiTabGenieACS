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

put_provision "sqlradius_tag_managed" '
declare("Tags.sqlradius-managed", null, {value: true});
'

put_provision "sqlradius_periodic_inform" '
const now = Date.now();
const enableValue = true;
const intervalValue = 300;

let deviceEnable = declare("Device.ManagementServer.PeriodicInformEnable", {value: now});
if (deviceEnable.size) {
  declare("Device.ManagementServer.PeriodicInformEnable", null, {value: enableValue});
  let deviceInterval = declare("Device.ManagementServer.PeriodicInformInterval", {value: now});
  if (deviceInterval.size) {
    declare("Device.ManagementServer.PeriodicInformInterval", null, {value: intervalValue});
  }
}

let igdEnable = declare("InternetGatewayDevice.ManagementServer.PeriodicInformEnable", {value: now});
if (igdEnable.size) {
  declare("InternetGatewayDevice.ManagementServer.PeriodicInformEnable", null, {value: enableValue});
  let igdInterval = declare("InternetGatewayDevice.ManagementServer.PeriodicInformInterval", {value: now});
  if (igdInterval.size) {
    declare("InternetGatewayDevice.ManagementServer.PeriodicInformInterval", null, {value: intervalValue});
  }
}
'

put_provision "sqlradius_inventory" '
const refresh = Date.now() - (24 * 60 * 60 * 1000);

declare("DeviceID.Manufacturer", {value: refresh});
declare("DeviceID.OUI", {value: refresh});
declare("DeviceID.ProductClass", {value: refresh});
declare("DeviceID.SerialNumber", {value: refresh});

declare("Device.DeviceInfo.Manufacturer", {value: refresh});
declare("Device.DeviceInfo.HardwareVersion", {value: refresh});
declare("Device.DeviceInfo.ProductClass", {value: refresh});
declare("Device.DeviceInfo.SerialNumber", {value: refresh});
declare("Device.DeviceInfo.SoftwareVersion", {value: refresh});

declare("InternetGatewayDevice.DeviceInfo.Manufacturer", {value: refresh});
declare("InternetGatewayDevice.DeviceInfo.HardwareVersion", {value: refresh});
declare("InternetGatewayDevice.DeviceInfo.ProductClass", {value: refresh});
declare("InternetGatewayDevice.DeviceInfo.SerialNumber", {value: refresh});
declare("InternetGatewayDevice.DeviceInfo.SoftwareVersion", {value: refresh});
'

put_preset "sqlradius-01-managed-tag" '{
  "weight": 0,
  "configurations": [
    {
      "type": "provision",
      "name": "sqlradius_tag_managed"
    }
  ]
}'

put_preset "sqlradius-10-periodic-inform" '{
  "weight": 10,
  "precondition": "{\"_tags\": \"sqlradius-managed\"}",
  "configurations": [
    {
      "type": "provision",
      "name": "sqlradius_periodic_inform"
    }
  ]
}'

put_preset "sqlradius-20-inventory" '{
  "weight": 20,
  "precondition": "{\"_tags\": \"sqlradius-managed\"}",
  "configurations": [
    {
      "type": "provision",
      "name": "sqlradius_inventory"
    }
  ]
}'

echo
echo "GenieACS SQLRadius preset baseline installed."
echo "NBI: ${NBI_URL}"
echo "Next: register one real ONT, inspect its data model, then add vendor/model-specific presets."
