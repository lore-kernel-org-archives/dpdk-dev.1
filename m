Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53EED116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 16:29:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7095A40268;
	Mon,  1 Dec 2025 17:29:23 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0337E4021F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 17:29:21 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id CDFC048BFC; Mon,  1 Dec 2025 17:29:21 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1846] [mlx5] adding a vlan filter offload causes
 packets to be steered towards the kernel
Date: Mon, 01 Dec 2025 16:29:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: robin@jarry.cc
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1846-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: http://bugs.dpdk.org/
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1846

            Bug ID: 1846
           Summary: [mlx5] adding a vlan filter offload causes packets to
                    be steered towards the kernel
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: robin@jarry.cc
  Target Milestone: ---

When VLAN filter offload is enabled and a VLAN filter is configured on a VF,
unicast packets are no longer received by the DPDK driver. Packets go direc=
tly
to the kernel netdev. Note: when promisc is enabled, packets are received
again.

Hardware config
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

SLOT          DRIVER     IFNAME        MAC                LINK/STATE  SPEED=
=20=20
DEVICE
0000:18:00.0  mlx5_core  enp24s0f0np0  b8:3f:d2:fa:53:86  1/up        25Gb/=
s=20
MT2894 Family [ConnectX-6 Lx]
0000:18:00.2  mlx5_core  enp24s0f0v0   02:aa:aa:aa:aa:00  1/up        25Gb/=
s=20
ConnectX Family mlx5Gen Virtual Function

~# cat /sys/class/net/enp24s0f0np0/device/sriov_numvfs
1

~# devlink dev eswitch show pci/0000:18:00.0
pci/0000:18:00.0: mode legacy inline-mode none encap-mode basic

~# ip link show enp24s0f0np0
6: enp24s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state =
UP
mode DEFAULT group default qlen 1000
    link/ether b8:3f:d2:fa:53:86 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether 02:aa:aa:aa:aa:00 brd ff:ff:ff:ff:ff:ff, spoof chec=
king
off, link-state auto, trust on, query_rss off

~# ip link show enp24s0f0v0
12: enp24s0f0v0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state =
UP
mode DEFAULT group default qlen 1000
    link/ether 02:aa:aa:aa:aa:00 brd ff:ff:ff:ff:ff:ff

How to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

~# tcpdump -ltpnnei enp24s0f0v0 | sed 's/^/[kernel enp24s0f0v0] /' &

~# dpdk-testpmd -l 0,1 -a 0000:18:00.2 -- --forward-mode=3Drxonly -i
--enable-hw-vlan-filter
EAL: Detected CPU lcores: 40
EAL: Detected NUMA nodes: 1
EAL: Detected shared linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: Probe PCI driver: mlx5_pci (15b3:101e) device: 0000:18:00.2 (socket 0)
TELEMETRY: No legacy callbacks, legacy socket not created
Set rxonly packet forwarding mode
Interactive-mode selected
testpmd: Flow tunnel offload support might be limited or unavailable on por=
t 0
testpmd: create a new mbuf pool <mb_pool_0>: n=3D155456, size=3D2176, socke=
t=3D0
testpmd: preferred mempool ops selected: ring_mp_mc

Warning! port-topology=3Dpaired and odd forward ports number, the last port=
 will
pair with itself.

Configuring Port 0 (socket 0)
Port 0: 02:AA:AA:AA:AA:00
Checking link statuses...
Done

testpmd> set verbose 1
Change verbose level from 0 to 1

testpmd> set promisc all off

testpmd> start
rxonly packet forwarding - ports=3D1 - cores=3D1 - streams=3D1 - NUMA suppo=
rt
enabled, MP allocation mode: native
Logical Core 18 (socket 0) forwards packets on 1 streams:
  RX P=3D0/Q=3D0 (socket 0) -> TX P=3D0/Q=3D0 (socket 0) peer=3D02:00:00:00=
:00:00

port 0/queue 0: received 1 packets
  src=3D2C:4C:15:07:98:70 - dst=3D01:80:C2:00:00:0E - pool=3Dmb_pool_0 - ty=
pe=3D0x88cc
- length=3D457 - nb_segs=3D1 - hw ptype: L2_ETHER  - sw ptype: L2_ETHER  -
l2_len=3D14 - Receive queue=3D0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_UNKNOWN RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN
RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN
  rxonly packet forwarding packets/burst=3D32
  nb forwarding cores=3D1 - nb forwarding ports=3D1
  port 0: RX queue number: 1 Tx queue number: 1
    Rx offloads=3D0x200 Tx offloads=3D0x10000
    RX queue: 0
      RX desc=3D256 - RX free threshold=3D64
      RX threshold registers: pthresh=3D0 hthresh=3D0  wthresh=3D0
      RX Offloads=3D0x200
    TX queue: 0
      TX desc=3D256 - TX free threshold=3D0
      TX threshold registers: pthresh=3D0 hthresh=3D0  wthresh=3D0
      TX offloads=3D0x10000 - TX RS bit threshold=3D0

<send 3 unicast packets towards 02:AA:AA:AA:AA:00>

port 0/queue 0: received 1 packets
  src=3DB4:45:06:FD:4A:66 - dst=3D02:AA:AA:AA:AA:00 - pool=3Dmb_pool_0 - ty=
pe=3D0x0800
- length=3D77 - nb_segs=3D1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP=
  - sw
ptype: L2_ETHER L3_IPV4 L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 - =
Receive
queue=3D0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN
port 0/queue 0: received 1 packets
  src=3DB4:45:06:FD:4A:66 - dst=3D02:AA:AA:AA:AA:00 - pool=3Dmb_pool_0 - ty=
pe=3D0x0800
- length=3D77 - nb_segs=3D1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP=
  - sw
ptype: L2_ETHER L3_IPV4 L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 - =
Receive
queue=3D0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN
port 0/queue 0: received 1 packets
  src=3DB4:45:06:FD:4A:66 - dst=3D02:AA:AA:AA:AA:00 - pool=3Dmb_pool_0 - ty=
pe=3D0x0800
- length=3D77 - nb_segs=3D1 - hw ptype: L2_ETHER L3_IPV4_EXT_UNKNOWN L4_UDP=
  - sw
ptype: L2_ETHER L3_IPV4 L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 - =
Receive
queue=3D0x0
  ol_flags: RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN

<packets are received by testpmd>

testpmd> rx_vlan add 42 0

<send the same 3 unicast packets towards 02:aa:aa:aa:aa:00>

[kernel enp24s0f0v0] b4:45:06:fd:4a:66 > 02:aa:aa:aa:aa:00, ethertype IPv4
(0x0800), length 77: 172.16.0.2.53 > 172.16.0.1.53: 27755 updateM [b2&3=3D0=
x6664]
[29547a] [27244q] [26212n] [27238au] [|domain]
[kernel enp24s0f0v0] b4:45:06:fd:4a:66 > 02:aa:aa:aa:aa:00, ethertype IPv4
(0x0800), length 77: 172.16.0.2.53 > 172.16.0.1.53: 27755 updateM [b2&3=3D0=
x6664]
[29547a] [27244q] [26212n] [27238au] [|domain]
[kernel enp24s0f0v0] b4:45:06:fd:4a:66 > 02:aa:aa:aa:aa:00, ethertype IPv4
(0x0800), length 77: 172.16.0.2.53 > 172.16.0.1.53: 27755 updateM [b2&3=3D0=
x6664]
[29547a] [27244q] [26212n] [27238au] [|domain]

<packets are now received by the kernel>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
