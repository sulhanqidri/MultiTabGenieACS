# Huawei EG8145X6-10 — SQLRadius Preset

## Verified model

- Manufacturer: Huawei Technologies Co., Ltd
- OUI: 00259E
- Product Class / Model: EG8145X6-10
- Hardware: 343D.A
- Firmware: V5R023C00S247

## Verified WAN layout

Management / TR-069:
- WANDevice.1.WANConnectionDevice.1.WANIPConnection.1
- Service TR069
- VLAN 100
- IP_Routed
- NAT false

Internet:
- WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1
- Service INTERNET
- VLAN 200
- IP_Routed
- NAT true
- Connected

Other bridge:
- WANDevice.1.WANConnectionDevice.3.WANIPConnection.1
- Service OTHER
- VLAN 0
- IP_Bridged

## Preset strategy

1. 10-sqlradius-model-baseline.preset.json identifies EG8145X6-10 CPEs.
2. sqlradius-eg8145x6-10-baseline.js refreshes inventory and adds only a model classification tag.
3. 20-sqlradius-internet-pppoe.provision.js is a dynamic provisioning template and is NOT attached to an automatic preset.

The dynamic template expects args.username, args.password, and args.vlan.

It locates the existing INTERNET PPPoE connection by X_HW_SERVICELIST=INTERNET instead of assuming WANConnectionDevice.2.

Changing Username, Password, or VLAN on the active Internet WAN can interrupt the customer session. SQLRadius should invoke this only as an explicit provisioning action.
