const now = Date.now();

// Model baseline only: inventory refresh + classification tag.
// No WAN, VLAN, Wi-Fi, reboot, firmware, or factory-reset changes.
declare("Tags.sqlradius-model-eg8145x6-10", null, {value: true});

declare("DeviceID.Manufacturer", {value: now});
declare("DeviceID.OUI", {value: now});
declare("DeviceID.ProductClass", {value: now});
declare("DeviceID.SerialNumber", {value: now});

declare("InternetGatewayDevice.DeviceInfo.Manufacturer", {value: now});
declare("InternetGatewayDevice.DeviceInfo.HardwareVersion", {value: now});
declare("InternetGatewayDevice.DeviceInfo.ModelName", {value: now});
declare("InternetGatewayDevice.DeviceInfo.SoftwareVersion", {value: now});
declare("InternetGatewayDevice.DeviceInfo.ProvisioningCode", {value: now});
declare("InternetGatewayDevice.DeviceInfo.UpTime", {value: now});

declare("InternetGatewayDevice.ManagementServer.ConnectionRequestURL", {value: now});
declare("InternetGatewayDevice.ManagementServer.PeriodicInformEnable", {value: now});
declare("InternetGatewayDevice.ManagementServer.PeriodicInformInterval", {value: now});
