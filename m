Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E38C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 03:40:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77AA240287;
	Thu,  3 Jul 2025 05:40:43 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DB51740285
 for <dev@dpdk.org>; Thu,  3 Jul 2025 05:40:41 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id BA2A946AE0; Thu,  3 Jul 2025 05:40:41 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1737] [dpdk-25.07] [CNV]
 ice_dcf_checksum_offload/checksum_offload_vlan_tunnel_enable: the udp_gtpu
 packet will affect the hardware checksum of other udp packets
Date: Thu, 03 Jul 2025 03:40:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: songx.jiale@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1737-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17515140410.5ba2.913421
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org


--17515140410.5ba2.913421
Date: Thu, 3 Jul 2025 05:40:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1737

            Bug ID: 1737
           Summary: [dpdk-25.07] [CNV]
                    ice_dcf_checksum_offload/checksum_offload_vlan_tunnel_
                    enable: the udp_gtpu packet will affect the hardware
                    checksum of other udp packets
           Product: DPDK
           Version: 25.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: songx.jiale@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 5f37ee9c859f3ce08ca4364f1d8c0e70ec33ac83 version: 25.03.0-rc2
OS: Ubuntu24.04.1 LTS (Noble Numbat)/6.8.0-41-generic
Compiler:  gcc version 13.2.0
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz
NIC hardware: Intel Corporation Ethernet Controller E830-CC for QSFP
[8086:12d2][8086:1593])
NIC firmware:=20
  driver: vfio-pci
  kdriver: ice-1.17.8
  firmware-version: 1.00 0x800161b7 1.3832.0
  pkg: ice comms 1.3.53.0
scapy:2.4.4

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. reload ice
rmmod ice && modprobe ice
2. create 1 vf and set vf echo 1 >
/sys/bus/pci/devices/0000\:af\:00.0/sriov_numvfs
ip link set ens802f0np0 vf 0 trust on
ip link set ens802f0np0 vf 0 spoofchk off
modprobe vfio && modprobe vfio-pci
./usertools/dpdk-devbind.py -b vfio-pci 0000:af:01.0
3. start testpmd x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-2 -n 4 -a
0000:af:01.0,cap=3Ddcf  -- -i --enable-rx-cksum
4. set testpmd
set verbose 1
set fwd csum
set promisc 0 on
port stop all
csum set ip hw 0
csum set udp hw 0
csum set tcp hw 0
csum set sctp hw 0
csum set outer-ip hw 0
csum set outer-udp hw 0
csum parse-tunnel on 0
rx_vxlan_port add 4789 0
port start all
start

5. tcpdump captures packets forwarded by testpmd
tcpdump -ei enp5s0 -Q in -w 1.pcap

6. scapy send packets=20
p=3D[
Ether(dst=3D'00:11:22:33:44:55',
src=3D'52:00:00:00:00:00')/Dot1Q(vlan=3D100)/IPv6(src=3D'::1')/UDP(dport=3D=
2152)/GTP_U_Header(gtp_type=3D255,
teid=3D1193046)/IP(src=3D'10.0.0.1')/UDP(sport=3D29999,
dport=3D30000)/Raw(load=3Db'\xce\xfd\xe9\x04\xde\xa9V<\xb6*;J\x12\xb1\xde\x=
00\x1d`a\x03^\xc1\xb5\x07\xad\xc4\xad>\x996sXt\x82^\xe3\xbb\xf4K\x10";J^\xa=
6T\xc2\x8b\xe8@\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'),
Ether(dst=3D'00:11:22:33:44:55',
src=3D'52:00:00:00:00:00')/Dot1Q(vlan=3D100)/IP(src=3D'10.0.0.1')/UDP(sport=
=3D4789,
dport=3D4789)/VXLAN()/Ether()/IP(src=3D'10.0.0.1')/UDP(sport=3D29999,
dport=3D30000)/Raw(load=3Db'\xce\xfd\xe9\x04\xde\xa9V<\xb6*;J\x12\xb1\xde\x=
00\x1d`a\x03^\xc1\xb5\x07\xad\xc4\xad>\x996sXt\x82^\xe3\xbb\xf4K\x10";J^\xa=
6T\xc2\x8b\xe8@\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'),
Ether(dst=3D'00:11:22:33:44:55',
src=3D'52:00:00:00:00:00')/Dot1Q(vlan=3D100)/IP(src=3D'10.0.0.1')/UDP()/Raw=
(load=3Db'\xce\xfd\xe9\x04\xde\xa9V<\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1\=
xb5\x07\xad\xc4\xad>\x996sXt\x82^\xe3\xbb\xf4K\x10";J^\xa6T\xc2\x8b\xe8@\xf=
d\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'),
]
sendp(p, iface=3D'enp5s0', count=3D1)

7. ^C exit tcpdump and scapy or wireshark parsing data packets
pkt=3Drdpcap('1.pcap')


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
The outer UDP checksum for p[1] and p[2] is incorrect.

>>> p[0]
<Ether  dst=3D02:00:00:00:00:00 src=3Db6:90:6c:aa:47:dc type=3Dn_802_1Q |<D=
ot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv6 |<IPv6  version=3D6 tc=3D0 fl=3D0 pl=
en=3D108 nh=3DUDP
hlim=3D64 src=3D::1 dst=3D::1 |<UDP  sport=3D2152 dport=3D2152 len=3D108 ch=
ksum=3D0x11dd
|<GTP_U_Header  version=3D1 PT=3D1 reserved=3D0 E=3D0 S=3D0 PN=3D0 gtp_type=
=3Dg_pdu length=3D92
teid=3D1193046 |<IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D92 id=3D1 flags=3D=
 frag=3D0 ttl=3D64
proto=3Dudp chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.1 |<UDP  sport=3D2=
9999
dport=3D30000 len=3D72 chksum=3D0x9280 |<Raw=20
load=3D'\xce\xfd\xe9\x04\xde\xa9V<\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1\xb=
5\x07\xad\xc4\xad>\x996sXt\x82^\xe3\xbb\xf4K\x10";J^\xa6T\xc2\x8b\xe8@\xfd\=
xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'
|>>>>>>>>

>>> p[1]
<Ether  dst=3D02:00:00:00:00:00 src=3Db6:90:6c:aa:47:dc type=3Dn_802_1Q |<D=
ot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv4 |<IP  version=3D4 ihl=3D5 tos=3D0x0 =
len=3D142 id=3D1
flags=3D frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0xf15c src=3D10.0.17.221 ds=
t=3D127.0.0.1
|<UDP  sport=3D4789 dport=3D4789 len=3D122 chksum=3D0x0 |<VXLAN=20
flags=3DNextProtocol+Instance reserved0=3D0 NextProtocol=3DEthernet vni=3D0=
x0
reserved2=3D0x0 |<Ether  dst=3Dff:ff:ff:ff:ff:ff src=3D00:00:00:00:00:00 ty=
pe=3DIPv4
|<IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D92 id=3D1 flags=3D frag=3D0 ttl=
=3D64 proto=3Dudp
chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.1 |<UDP  sport=3D29999 dport=
=3D30000 len=3D72
chksum=3D0x9280 |<Raw=20
load=3D'\xce\xfd\xe9\x04\xde\xa9V<\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1\xb=
5\x07\xad\xc4\xad>\x996sXt\x82^\xe3\xbb\xf4K\x10";J^\xa6T\xc2\x8b\xe8@\xfd\=
xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'
|>>>>>>>>>

>>> p[2]
<Ether  dst=3D02:00:00:00:00:00 src=3D02:82:14:0b:94:11 type=3Dn_802_1Q |<D=
ot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv4 |<IP  version=3D4 ihl=3D5 tos=3D0x0 =
len=3D92 id=3D1 flags=3D
frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.=
1 |<UDP=20
sport=3Ddomain dport=3Ddomain len=3D72 chksum=3D0xc5e6 |<DNS  id=3D52989 qr=
=3D1 opcode=3D13
aa=3D0 tc=3D0 rd=3D1 ra=3D0 z=3D0 ad=3D0 cd=3D0 rcode=3Dnot-implemented qdc=
ount=3D57001
ancount=3D22076 nscount=3D46634 arcount=3D15178 qd=3D'' an=3D'' ns=3D'' ar=
=3D'' |<Raw=20
load=3D'\x12\xb1\xde\x00\x1d`a\x03^\xc1\xb5\x07\xad\xc4\xad>\x996sXt\x82^\x=
e3\xbb\xf4K\x10";J^\xa6T\xc2\x8b\xe8@\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xaf=
h0\xb8'
|>>>>>>


Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
p[1] outer udp checksum is 0xc5e6, p[2] outer udp checksum is 0x7c76

>>> p[0]
<Ether  dst=3D02:00:00:00:00:00 src=3D02:82:14:0b:94:11 type=3Dn_802_1Q |<D=
ot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv6 |<IPv6  version=3D6 tc=3D0 fl=3D0 pl=
en=3D108 nh=3DUDP
hlim=3D64 src=3D::1 dst=3D::1 |<UDP  sport=3D2152 dport=3D2152 len=3D108 ch=
ksum=3D0x11dd
|<GTP_U_Header  version=3D1 PT=3D1 reserved=3D0 E=3D0 S=3D0 PN=3D0 gtp_type=
=3Dg_pdu length=3D92
teid=3D1193046 |<IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D92 id=3D1 flags=3D=
 frag=3D0 ttl=3D64
proto=3Dudp chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.1 |<UDP  sport=3D2=
9999
dport=3D30000 len=3D72 chksum=3D0x9280 |<Raw=20
load=3D'\xce\xfd\xe9\x04\xde\xa9V<\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1\xb=
5\x07\xad\xc4\xad>\x996sXt\x82^\xe3\xbb\xf4K\x10";J^\xa6T\xc2\x8b\xe8@\xfd\=
xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'
|>>>>>>>>

>>> p[1]
<Ether  dst=3D02:00:00:00:00:00 src=3D02:82:14:0b:94:11 type=3Dn_802_1Q |<D=
ot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv4 |<IP  version=3D4 ihl=3D5 tos=3D0x0 =
len=3D142 id=3D1
flags=3D frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0xf15c src=3D10.0.0.1 dst=
=3D127.0.0.1 |<UDP=20
sport=3D4789 dport=3D4789 len=3D122 chksum=3D0xc5e6 |<VXLAN=20
flags=3DNextProtocol+Instance reserved0=3D0 NextProtocol=3DEthernet vni=3D0=
x0
reserved2=3D0x0 |<Ether  dst=3Dff:ff:ff:ff:ff:ff src=3D00:00:00:00:00:00 ty=
pe=3DIPv4
|<IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D92 id=3D1 flags=3D frag=3D0 ttl=
=3D64 proto=3Dudp
chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.1 |<UDP  sport=3D29999 dport=
=3D30000 len=3D72
chksum=3D0x9280 |<Raw=20
load=3D'\xce\xfd\xe9\x04\xde\xa9V<\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1\xb=
5\x07\xad\xc4\xad>\x996sXt\x82^\xe3\xbb\xf4K\x10";J^\xa6T\xc2\x8b\xe8@\xfd\=
xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'
|>>>>>>>>>

>>> p[2]
<Ether  dst=3D02:00:00:00:00:00 src=3D02:82:14:0b:94:11 type=3Dn_802_1Q |<D=
ot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv4 |<IP  version=3D4 ihl=3D5 tos=3D0x0 =
len=3D92 id=3D1 flags=3D
frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.=
1 |<UDP=20
sport=3Ddomain dport=3Ddomain len=3D72 chksum=3D0x7c76 |<DNS  id=3D52989 qr=
=3D1 opcode=3D13
aa=3D0 tc=3D0 rd=3D1 ra=3D0 z=3D0 ad=3D0 cd=3D0 rcode=3Dnot-implemented qdc=
ount=3D57001
ancount=3D22076 nscount=3D46634 arcount=3D15178 qd=3D'' an=3D'' ns=3D'' ar=
=3D'' |<Raw=20
load=3D'\x12\xb1\xde\x00\x1d`a\x03^\xc1\xb5\x07\xad\xc4\xad>\x996sXt\x82^\x=
e3\xbb\xf4K\x10";J^\xa6T\xc2\x8b\xe8@\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xaf=
h0\xb8'
|>>>>>>


bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit b1f3a7a8c375fbb66be48aed078222686d16fdb5
Author: Dengdui Huang <huangdengdui@huawei.com>
Date:   Tue Jun 3 20:06:22 2025 +0800

    net: fix GTP packet parsing

    After parsing the GTP packet header, the next protocol type should
    be converted from RTE_GTP_TYPE_IPV4/IPV6 to RTE_ETHER_TYPE_IPV4/IPV6.
    Otherwise, the next protocol cannot be parsed.

    Bugzilla ID: 1672
    Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
    Cc: stable@dpdk.org

    Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
    Acked-by: Jie Hai <haijie1@huawei.com>

 lib/net/rte_net.c | 8 +++++++-
 1 file changed, 7 insertions, 1 deletion

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17515140410.5ba2.913421
Date: Thu, 3 Jul 2025 05:40:41 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - [dpdk-25.07] [CNV] ice_dcf_checksum_offload/check=
sum_offload_vlan_tunnel_enable: the udp_gtpu packet will affect the hardwar=
e checksum of other udp packets"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1737">1737</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.07] [CNV] ice_dcf_checksum_offload/checksum_offload_=
vlan_tunnel_enable: the udp_gtpu packet will affect the hardware checksum o=
f other udp packets
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.03
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>x86
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>testpmd
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>songx.jiale&#64;intel.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 5f37ee9c859f3ce08ca4364f1d8c0e70ec33ac83 version: 25.03.0-rc2
OS: Ubuntu24.04.1 LTS (Noble Numbat)/6.8.0-41-generic
Compiler:  gcc version 13.2.0
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU &#64; 2.30GHz
NIC hardware: Intel Corporation Ethernet Controller E830-CC for QSFP
[8086:12d2][8086:1593])
NIC firmware:=20
  driver: vfio-pci
  kdriver: ice-1.17.8
  firmware-version: 1.00 0x800161b7 1.3832.0
  pkg: ice comms 1.3.53.0
scapy:2.4.4

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. reload ice
rmmod ice &amp;&amp; modprobe ice
2. create 1 vf and set vf echo 1 &gt;
/sys/bus/pci/devices/0000\:af\:00.0/sriov_numvfs
ip link set ens802f0np0 vf 0 trust on
ip link set ens802f0np0 vf 0 spoofchk off
modprobe vfio &amp;&amp; modprobe vfio-pci
./usertools/dpdk-devbind.py -b vfio-pci 0000:af:01.0
3. start testpmd x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-2 -n 4 -a
0000:af:01.0,cap=3Ddcf  -- -i --enable-rx-cksum
4. set testpmd
set verbose 1
set fwd csum
set promisc 0 on
port stop all
csum set ip hw 0
csum set udp hw 0
csum set tcp hw 0
csum set sctp hw 0
csum set outer-ip hw 0
csum set outer-udp hw 0
csum parse-tunnel on 0
rx_vxlan_port add 4789 0
port start all
start

5. tcpdump captures packets forwarded by testpmd
tcpdump -ei enp5s0 -Q in -w 1.pcap

6. scapy send packets=20
p=3D[
Ether(dst=3D'00:11:22:33:44:55',
src=3D'52:00:00:00:00:00')/Dot1Q(vlan=3D100)/IPv6(src=3D'::1')/UDP(dport=3D=
2152)/GTP_U_Header(gtp_type=3D255,
teid=3D1193046)/IP(src=3D'10.0.0.1')/UDP(sport=3D29999,
dport=3D30000)/Raw(load=3Db'\xce\xfd\xe9\x04\xde\xa9V&lt;\xb6*;J\x12\xb1\xd=
e\x00\x1d`a\x03^\xc1\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82^\xe3\xbb\xf4K\x10&=
quot;;J^\xa6T\xc2\x8b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'=
),
Ether(dst=3D'00:11:22:33:44:55',
src=3D'52:00:00:00:00:00')/Dot1Q(vlan=3D100)/IP(src=3D'10.0.0.1')/UDP(sport=
=3D4789,
dport=3D4789)/VXLAN()/Ether()/IP(src=3D'10.0.0.1')/UDP(sport=3D29999,
dport=3D30000)/Raw(load=3Db'\xce\xfd\xe9\x04\xde\xa9V&lt;\xb6*;J\x12\xb1\xd=
e\x00\x1d`a\x03^\xc1\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82^\xe3\xbb\xf4K\x10&=
quot;;J^\xa6T\xc2\x8b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'=
),
Ether(dst=3D'00:11:22:33:44:55',
src=3D'52:00:00:00:00:00')/Dot1Q(vlan=3D100)/IP(src=3D'10.0.0.1')/UDP()/Raw=
(load=3Db'\xce\xfd\xe9\x04\xde\xa9V&lt;\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\x=
c1\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82^\xe3\xbb\xf4K\x10&quot;;J^\xa6T\xc2\=
x8b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'),
]
sendp(p, iface=3D'enp5s0', count=3D1)

7. ^C exit tcpdump and scapy or wireshark parsing data packets
pkt=3Drdpcap('1.pcap')


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
The outer UDP checksum for p[1] and p[2] is incorrect.

<span class=3D"quote">&gt;&gt;&gt; p[0]</span >
&lt;Ether  dst=3D02:00:00:00:00:00 src=3Db6:90:6c:aa:47:dc type=3Dn_802_1Q =
|&lt;Dot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv6 |&lt;IPv6  version=3D6 tc=3D0 fl=3D0=
 plen=3D108 nh=3DUDP
hlim=3D64 src=3D::1 dst=3D::1 |&lt;UDP  sport=3D2152 dport=3D2152 len=3D108=
 chksum=3D0x11dd
|&lt;GTP_U_Header  version=3D1 PT=3D1 reserved=3D0 E=3D0 S=3D0 PN=3D0 gtp_t=
ype=3Dg_pdu length=3D92
teid=3D1193046 |&lt;IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D92 id=3D1 flags=
=3D frag=3D0 ttl=3D64
proto=3Dudp chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.1 |&lt;UDP  sport=
=3D29999
dport=3D30000 len=3D72 chksum=3D0x9280 |&lt;Raw=20
load=3D'\xce\xfd\xe9\x04\xde\xa9V&lt;\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1=
\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82^\xe3\xbb\xf4K\x10&quot;;J^\xa6T\xc2\x8=
b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'
|&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;

<span class=3D"quote">&gt;&gt;&gt; p[1]</span >
&lt;Ether  dst=3D02:00:00:00:00:00 src=3Db6:90:6c:aa:47:dc type=3Dn_802_1Q =
|&lt;Dot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv4 |&lt;IP  version=3D4 ihl=3D5 tos=3D0=
x0 len=3D142 id=3D1
flags=3D frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0xf15c src=3D10.0.17.221 ds=
t=3D127.0.0.1
|&lt;UDP  sport=3D4789 dport=3D4789 len=3D122 chksum=3D0x0 |&lt;VXLAN=20
flags=3DNextProtocol+Instance reserved0=3D0 NextProtocol=3DEthernet vni=3D0=
x0
reserved2=3D0x0 |&lt;Ether  dst=3Dff:ff:ff:ff:ff:ff src=3D00:00:00:00:00:00=
 type=3DIPv4
|&lt;IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D92 id=3D1 flags=3D frag=3D0 tt=
l=3D64 proto=3Dudp
chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.1 |&lt;UDP  sport=3D29999 dpor=
t=3D30000 len=3D72
chksum=3D0x9280 |&lt;Raw=20
load=3D'\xce\xfd\xe9\x04\xde\xa9V&lt;\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1=
\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82^\xe3\xbb\xf4K\x10&quot;;J^\xa6T\xc2\x8=
b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'
|&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;

<span class=3D"quote">&gt;&gt;&gt; p[2]</span >
&lt;Ether  dst=3D02:00:00:00:00:00 src=3D02:82:14:0b:94:11 type=3Dn_802_1Q =
|&lt;Dot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv4 |&lt;IP  version=3D4 ihl=3D5 tos=3D0=
x0 len=3D92 id=3D1 flags=3D
frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.=
1 |&lt;UDP=20
sport=3Ddomain dport=3Ddomain len=3D72 chksum=3D0xc5e6 |&lt;DNS  id=3D52989=
 qr=3D1 opcode=3D13
aa=3D0 tc=3D0 rd=3D1 ra=3D0 z=3D0 ad=3D0 cd=3D0 rcode=3Dnot-implemented qdc=
ount=3D57001
ancount=3D22076 nscount=3D46634 arcount=3D15178 qd=3D'' an=3D'' ns=3D'' ar=
=3D'' |&lt;Raw=20
load=3D'\x12\xb1\xde\x00\x1d`a\x03^\xc1\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82=
^\xe3\xbb\xf4K\x10&quot;;J^\xa6T\xc2\x8b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\=
xcb\xcb`\xafh0\xb8'
|&gt;&gt;&gt;&gt;&gt;&gt;


Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
p[1] outer udp checksum is 0xc5e6, p[2] outer udp checksum is 0x7c76

<span class=3D"quote">&gt;&gt;&gt; p[0]</span >
&lt;Ether  dst=3D02:00:00:00:00:00 src=3D02:82:14:0b:94:11 type=3Dn_802_1Q =
|&lt;Dot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv6 |&lt;IPv6  version=3D6 tc=3D0 fl=3D0=
 plen=3D108 nh=3DUDP
hlim=3D64 src=3D::1 dst=3D::1 |&lt;UDP  sport=3D2152 dport=3D2152 len=3D108=
 chksum=3D0x11dd
|&lt;GTP_U_Header  version=3D1 PT=3D1 reserved=3D0 E=3D0 S=3D0 PN=3D0 gtp_t=
ype=3Dg_pdu length=3D92
teid=3D1193046 |&lt;IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D92 id=3D1 flags=
=3D frag=3D0 ttl=3D64
proto=3Dudp chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.1 |&lt;UDP  sport=
=3D29999
dport=3D30000 len=3D72 chksum=3D0x9280 |&lt;Raw=20
load=3D'\xce\xfd\xe9\x04\xde\xa9V&lt;\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1=
\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82^\xe3\xbb\xf4K\x10&quot;;J^\xa6T\xc2\x8=
b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'
|&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;

<span class=3D"quote">&gt;&gt;&gt; p[1]</span >
&lt;Ether  dst=3D02:00:00:00:00:00 src=3D02:82:14:0b:94:11 type=3Dn_802_1Q =
|&lt;Dot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv4 |&lt;IP  version=3D4 ihl=3D5 tos=3D0=
x0 len=3D142 id=3D1
flags=3D frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0xf15c src=3D10.0.0.1 dst=
=3D127.0.0.1 |&lt;UDP=20
sport=3D4789 dport=3D4789 len=3D122 chksum=3D0xc5e6 |&lt;VXLAN=20
flags=3DNextProtocol+Instance reserved0=3D0 NextProtocol=3DEthernet vni=3D0=
x0
reserved2=3D0x0 |&lt;Ether  dst=3Dff:ff:ff:ff:ff:ff src=3D00:00:00:00:00:00=
 type=3DIPv4
|&lt;IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D92 id=3D1 flags=3D frag=3D0 tt=
l=3D64 proto=3Dudp
chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.1 |&lt;UDP  sport=3D29999 dpor=
t=3D30000 len=3D72
chksum=3D0x9280 |&lt;Raw=20
load=3D'\xce\xfd\xe9\x04\xde\xa9V&lt;\xb6*;J\x12\xb1\xde\x00\x1d`a\x03^\xc1=
\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82^\xe3\xbb\xf4K\x10&quot;;J^\xa6T\xc2\x8=
b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\xcb\xcb`\xafh0\xb8'
|&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;

<span class=3D"quote">&gt;&gt;&gt; p[2]</span >
&lt;Ether  dst=3D02:00:00:00:00:00 src=3D02:82:14:0b:94:11 type=3Dn_802_1Q =
|&lt;Dot1Q=20
prio=3D0 id=3D0 vlan=3D100 type=3DIPv4 |&lt;IP  version=3D4 ihl=3D5 tos=3D0=
x0 len=3D92 id=3D1 flags=3D
frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0xf18e src=3D10.0.0.1 dst=3D127.0.0.=
1 |&lt;UDP=20
sport=3Ddomain dport=3Ddomain len=3D72 chksum=3D0x7c76 |&lt;DNS  id=3D52989=
 qr=3D1 opcode=3D13
aa=3D0 tc=3D0 rd=3D1 ra=3D0 z=3D0 ad=3D0 cd=3D0 rcode=3Dnot-implemented qdc=
ount=3D57001
ancount=3D22076 nscount=3D46634 arcount=3D15178 qd=3D'' an=3D'' ns=3D'' ar=
=3D'' |&lt;Raw=20
load=3D'\x12\xb1\xde\x00\x1d`a\x03^\xc1\xb5\x07\xad\xc4\xad&gt;\x996sXt\x82=
^\xe3\xbb\xf4K\x10&quot;;J^\xa6T\xc2\x8b\xe8&#64;\xfd\xee\xa8\x07\x9eC\xa8\=
xcb\xcb`\xafh0\xb8'
|&gt;&gt;&gt;&gt;&gt;&gt;


bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit b1f3a7a8c375fbb66be48aed078222686d16fdb5
Author: Dengdui Huang &lt;<a href=3D"mailto:huangdengdui&#64;huawei.com">hu=
angdengdui&#64;huawei.com</a>&gt;
Date:   Tue Jun 3 20:06:22 2025 +0800

    net: fix GTP packet parsing

    After parsing the GTP packet header, the next protocol type should
    be converted from RTE_GTP_TYPE_IPV4/IPV6 to RTE_ETHER_TYPE_IPV4/IPV6.
    Otherwise, the next protocol cannot be parsed.

    Bugzilla ID: 1672
    Fixes: 64ed7f854cf4 (&quot;net: add tunnel packet type parsing&quot;)
    Cc: <a href=3D"mailto:stable&#64;dpdk.org">stable&#64;dpdk.org</a>

    Signed-off-by: Dengdui Huang &lt;<a href=3D"mailto:huangdengdui&#64;hua=
wei.com">huangdengdui&#64;huawei.com</a>&gt;
    Acked-by: Jie Hai &lt;<a href=3D"mailto:haijie1&#64;huawei.com">haijie1=
&#64;huawei.com</a>&gt;

 lib/net/rte_net.c | 8 +++++++-
 1 file changed, 7 insertions, 1 deletion
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1737">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17515140410.5ba2.913421--
