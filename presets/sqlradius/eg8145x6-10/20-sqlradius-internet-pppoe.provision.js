/*
 * SQLRadius -> GenieACS dynamic Internet provisioning template
 *
 * NOT bound to an automatic preset.
 *
 * Expected args:
 *   args.username
 *   args.password
 *   args.vlan
 */

const now = Date.now();

if (!args || !args.username || !args.password || args.vlan == null) {
  throw new Error("Missing SQLRadius PPPoE arguments");
}

const internet = declare(
  "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.*.WANPPPConnection.[X_HW_SERVICELIST:INTERNET]",
  {path: now}
);

if (!internet.size) {
  throw new Error("No Huawei INTERNET WANPPPConnection found");
}

const base = internet[0].path;

declare(base + ".Username", null, {value: String(args.username)});
declare(base + ".Password", null, {value: String(args.password)});
declare(base + ".X_HW_VLAN", null, {value: Number(args.vlan)});
declare(base + ".X_HW_SERVICELIST", null, {value: "INTERNET"});
declare(base + ".Enable", null, {value: true});
declare(base + ".ConnectionType", null, {value: "IP_Routed"});
declare(base + ".NATEnabled", null, {value: true});

log("SQLRadius PPPoE provisioning completed for " + base);
