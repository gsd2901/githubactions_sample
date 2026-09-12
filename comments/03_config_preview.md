### NAAC configuration render preview

| Field | Value |
|---|---|
| Workflow | 8b2571e5-b711-48ca-81db-1cd56b87867a |
| Change | CHG0031026 |
| VLAN ID | 240 |
| Location | Noida |
| Scope | Production deploy targets |

**Device configuration**

**DE999-PROD-SW-03**

vlan 240
name WEB_SERVER_BUILD_240
!

interface Ethernet1/1
switchport trunk allowed vlan add 240

interface Ethernet1/4
switchport trunk allowed vlan add 240

!
interface Vlan240
no shutdown
ip address 10.100.140.2/24
ip router ospf 1 area 0.0.0.0

hsrp 240
preempt

priority 110

ip 10.100.140.1

**DE999-PROD-SW-04**

vlan 240
name WEB_SERVER_BUILD_240
!

interface Ethernet1/4
switchport trunk allowed vlan add 240

!
interface Vlan240
no shutdown
ip address 10.100.140.3/24
ip router ospf 1 area 0.0.0.0

hsrp 240
preempt

ip 10.100.140.1

**DE999-PROD-SW-05**

vlan 240
name WEB_SERVER_BUILD_240
!

interface Ethernet1
switchport trunk allowed vlan add 240

interface Ethernet2
switchport trunk allowed vlan add 240


**DE999-PROD-SW-06**

vlan 240
name WEB_SERVER_BUILD_240
!

interface Ethernet1
switchport trunk allowed vlan add 240

interface Ethernet2
switchport trunk allowed vlan add 240

