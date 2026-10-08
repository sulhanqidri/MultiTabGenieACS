const now = Date.now();

const id = declare("DeviceID.ID", {value: now});
log("SQLRadius discovery test: " + (id.size ? id.value[0] : "unknown"));

// Identity
declare("DeviceID.Manufacturer", {value: now});
declare("DeviceID.OUI", {value: now});
declare("DeviceID.ProductClass", {value: now});
declare("DeviceID.SerialNumber", {value: now});

// Device information
declare("InternetGatewayDevice.DeviceInfo.Manufacturer", {value: now});
declare("InternetGatewayDevice.DeviceInfo.HardwareVersion", {value: now});
declare("InternetGatewayDevice.DeviceInfo.SoftwareVersion", {value: now});
declare("InternetGatewayDevice.DeviceInfo.ProductClass", {value: now});
declare("InternetGatewayDevice.DeviceInfo.SerialNumber", {value: now});
declare("InternetGatewayDevice.DeviceInfo.ProvisioningCode", {value: now});
declare("InternetGatewayDevice.DeviceInfo.UpTime", {value: now});

// Management / TR-069
declare("InternetGatewayDevice.ManagementServer.ConnectionRequestURL", {value: now});
declare("InternetGatewayDevice.ManagementServer.PeriodicInformEnable", {value: now});
declare("InternetGatewayDevice.ManagementServer.PeriodicInformInterval", {value: now});
declare("InternetGatewayDevice.ManagementServer.ConnectionRequestUsername", {value: now});

// Discover WAN/LAN object instances without changing configuration.
declare("InternetGatewayDevice.WANDevice.*", {path: now});
declare("InternetGatewayDevice.WANDevice.*.WANConnectionDevice.*", {path: now});
declare("InternetGatewayDevice.LANDevice.*", {path: now});
