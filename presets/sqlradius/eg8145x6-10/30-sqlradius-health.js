const now = Date.now();

const internet = declare(
  "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.*.WANPPPConnection.[X_HW_SERVICELIST:INTERNET]",
  {value: now}
);

if (internet.size) {
  log("SQLRadius health: WAN=" + internet[0].path);
  declare(internet[0].path + ".ConnectionStatus", {value: now});
  declare(internet[0].path + ".ExternalIPAddress", {value: now});
  declare(internet[0].path + ".Username", {value: now});
  declare(internet[0].path + ".X_HW_VLAN", {value: now});
  declare(internet[0].path + ".X_HW_SERVICELIST", {value: now});
  declare(internet[0].path + ".TransportType", {value: now});
}

declare("InternetGatewayDevice.DeviceInfo.UpTime", {value: now});
declare("InternetGatewayDevice.DeviceInfo.SoftwareVersion", {value: now});
declare("InternetGatewayDevice.DeviceInfo.HardwareVersion", {value: now});
declare("InternetGatewayDevice.DeviceInfo.ProcessStatus.CPUUsage", {value: now});
declare("InternetGatewayDevice.DeviceInfo.MemoryStatus.Free", {value: now});
declare("InternetGatewayDevice.DeviceInfo.MemoryStatus.Total", {value: now});
