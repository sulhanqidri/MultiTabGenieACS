/*
 * Manual SQLRadius Wi-Fi provisioning template.
 *
 * NOT attached to an automatic preset.
 *
 * args:
 *   args.band   -> "2.4g" or "5g"
 *   args.ssid
 *   args.password
 */

if (!args || !args.band || !args.ssid || !args.password) {
  throw new Error("Missing Wi-Fi arguments");
}

let index;

if (String(args.band).toLowerCase() === "2.4g") {
  index = 1;
} else if (String(args.band).toLowerCase() === "5g") {
  index = 5;
} else {
  throw new Error("Unsupported Wi-Fi band");
}

const base = "InternetGatewayDevice.LANDevice.1.WLANConfiguration." + index;

declare(base + ".Enable", null, {value: true});
declare(base + ".SSID", null, {value: String(args.ssid)});
declare(base + ".KeyPassphrase", null, {value: String(args.password)});
declare(base + ".SSIDAdvertisementEnabled", null, {value: true});
