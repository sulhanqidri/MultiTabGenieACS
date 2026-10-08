# EG8145X6-10 SQLRadius lifecycle

## Automatic

These operations are safe for a model-wide preset:

- identify the model
- refresh inventory
- refresh Internet WAN status
- refresh device health
- add a model classification tag

## Explicit SQLRadius actions

These must be invoked by an approved SQLRadius transaction:

- set PPPoE username
- set PPPoE password
- set Internet VLAN
- enable/disable Internet WAN
- change Wi-Fi SSID
- change Wi-Fi password

## High-risk actions

Keep these behind explicit maintenance/admin workflows:

- firmware upgrade
- reboot
- factory reset
- configuration-file download

The rule is simple: a normal Inform must never unexpectedly rewrite a customer's service configuration.
