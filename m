Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A720D2D0E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 12:31:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 802A34028C;
	Tue, 13 Jan 2026 13:31:30 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 64B5F40276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 13:31:28 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4D12F46FCC; Tue, 13 Jan 2026 13:31:28 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1867] mlx5: enabling internal VF-to-VF communication
 causes performance to drop significantly
Date: Tue, 13 Jan 2026 12:31:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 25.11
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
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1867-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1867

            Bug ID: 1867
           Summary: mlx5: enabling internal VF-to-VF communication causes
                    performance to drop significantly
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: robin@jarry.cc
                CC: rasland@nvidia.com
  Target Milestone: ---

SUMMARY
=3D=3D=3D=3D=3D=3D=3D

Enabling internal VF-to-VF communication causes performance to drop
significantly.

Here is a visual representation of the topology:

+---------------------------------------------------------------------+
|                                 dut                                 |
|                                                                     |
| +---------------+         +-------------+         +---------------+ |
| |    testpmd    |         |   testpmd   |         |    testpmd    | |
| |   "outer 0"   |         |   "inner"   |         |   "outer 1"   | |
| +--+---------+--+         +--+-------+--+         +--+---------+--+ |
|    |         |               |       |               |         |    |
|    |         |       ,-------'       `-------.       |         |    |
|    |         |       |                       |       |         |    |
| +--+--+   +--+--+ +--+--+                 +--+--+ +--+--+   +--+--+ |
| | vf0 |   | vf1 | | vf2 |                 | vf2 | | vf1 |   | vf0 | |
| +--+--+   +--+--+ +--+--+                 +--+--+ +--+--+   +--+--+ |
|    |         |       |                       |       |         |    |
|    |         |       |                       |       |         |    |
| +--+---------|-------|--+                 +--|-------|---------+--+ |
| |            `-------'  |                 |  `-------'            | |
| |          pf0          |                 |          pf1          | |
| +-----------+-----------+                 +-----------+-----------+ |
|             |                                         |             |
+-------------|-----------------------------------------|-------------+
              |                                         |
+-------------|-----------------------------------------|-------------+
|             |                 switch                  |             |
+-------------|-----------------------------------------|-------------+
              |                                         |
+-------------|-----------------------------------------|-------------+
|             |                                         |             |
| +-----------+------------+                +-----------+-----------+ |
| |          pf0           |                |          pf1          | |
| +-----------+------------+                +-----------+-----------+ |
|             |                                         |             |
| +-----------+-----------------------------------------+-----------+ |
| |                                                                 | |
| |                               trex                              | |
| |                                                                 | |
| +-----------------------------------------------------------------+ |
|                                                                     |
|                                 tgen                                |
+---------------------------------------------------------------------+

Important notes:

* Promisc mode is *disabled* on all ports.
* Traffic is sent from trex with VF0 mac addresses as ethernet destination.
* The switch does *not* flood anything.

Observations:

* When the tgen emits at 1M pkt/s per side, every packet is properly forwar=
ded
to both "outer" testpmds.
* When emitting at 10M pkt/s per side, only ~6.8M pkt/s are received by the
"outer" testpmds on VF0.
* When emitting at 37.5M pkt/s (25G line rate), only ~1.5M pkt/s are receiv=
ed
by the "outer" testpmds on VF0.
* ethtool stats on PF interfaces reflect the actual transmission rate of the
traffic generator (rx_packets_phy) but only a portion of these are relayed =
to
VF0.

With this simpler setup:

+--------------------------+
|               dut        |
|                          |
| +--------------+         |
| |   testpmd    |         |
| +--+-------+---+         |
|    |       |             |
|    |       |             |
|    |       |             |
| +--+--+ +--+--+          |
| | vf0 | | vf1 |          |
| +--+--+ +--+--+          |
|    |       |             |
|    |       |             |
| +--|-------|-----+       |
| |  \      /      |       |
| |   \    /   pf0 |       |
| +----\  /--------+       |
|       ||                 |
+-------||-----------------+
        ||
+-------||---------------------------------+
|       ||                                 |
|       |\--------------------------\      |
|       |          switch           |      |
|       |                           |      |
+-------|---------------------------|------+
        |                           |
+-------|---------------------------|------+
|       |                           |      |
| +-----+-----+                +----+----+ |
| |    pf0    |                |   pf1   | |
| +-----+-----+                +----+----+ |
|       |                           |      |
| +-----+---------------------------+----+ |
| |                                      | |
| |                  trex                | |
| |                                      | |
| +--------------------------------------+ |
|                                          |
|                    tgen                  |
+------------------------------------------+

The maximum line rate of the port can be achieved (37.5M pkt/s total, 18.75M
pkt/s per side).

SOFTWARE
=3D=3D=3D=3D=3D=3D=3D=3D

~/dpdk# git describe=20
v25.11-4-gcd60dcd503b9

~# cat /proc/cmdline
BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.16.7-100.fc41.x86_64 ... \
        intel_iommu=3Don iommu=3Dpt default_hugepagesz=3D1GB hugepagesz=3D1G
hugepages=3D32 \
        skew_tick=3D1 tsc=3Dreliable rcupdate.rcu_normal_after_boot=3D1 noh=
z=3Don \
        isolcpus=3D10-19,30-39 nohz_full=3D10-19,30-39 rcu_nocbs=3D10-19,30=
-39 \
        tuned.non_isolcpus=3D3ff003ff intel_pstate=3Dpassive nosoftlockup

libibverbs.so.1.14.51.0
libmlx5.so.1.24.51.0

HARDWARE
=3D=3D=3D=3D=3D=3D=3D=3D

CPU Model name:                          Intel(R) Xeon(R) Silver 4316 CPU @
2.30GHz

SLOT          DRIVER     IFNAME        MAC                LINK/STATE  SPEED=
=20=20
DEVICE
0000:18:00.0  mlx5_core  enp24s0f0np0  b8:3f:d2:fa:53:86  1/up        25Gb/=
s=20
MT2894 Family [ConnectX-6 Lx]
0000:18:00.1  mlx5_core  enp24s0f1np1  b8:3f:d2:fa:53:87  1/up        25Gb/=
s=20
MT2894 Family [ConnectX-6 Lx]
0000:18:00.2  mlx5_core  enp24s0f0v0   02:aa:aa:aa:aa:00  1/up        25Gb/=
s=20
ConnectX Family mlx5Gen Virtual Function
0000:18:00.3  mlx5_core  enp24s0f0v1   02:aa:aa:aa:aa:01  1/up        25Gb/=
s=20
ConnectX Family mlx5Gen Virtual Function
0000:18:00.4  mlx5_core  enp24s0f0v2   02:aa:aa:aa:aa:02  1/up        25Gb/=
s=20
ConnectX Family mlx5Gen Virtual Function
0000:18:08.2  mlx5_core  enp24s0f1v0   02:cc:cc:cc:cc:00  1/up        25Gb/=
s=20
ConnectX Family mlx5Gen Virtual Function
0000:18:08.3  mlx5_core  enp24s0f1v1   02:cc:cc:cc:cc:01  1/up        25Gb/=
s=20
ConnectX Family mlx5Gen Virtual Function
0000:18:08.4  mlx5_core  enp24s0f1v2   02:cc:cc:cc:cc:02  1/up        25Gb/=
s=20
ConnectX Family mlx5Gen Virtual Function

~# ethtool -i enp24s0f0np0
driver: mlx5_core
version: 6.16.7-100.fc41.x86_64
firmware-version: 26.41.1000 (MT_0000000532)
expansion-rom-version:
bus-info: 0000:18:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

~# ethtool -i enp24s0f1np1
driver: mlx5_core
version: 6.16.7-100.fc41.x86_64
firmware-version: 26.41.1000 (MT_0000000532)
expansion-rom-version:
bus-info: 0000:18:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

VF CONFIGURATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+ pf0=3Denp24s0f0np0
+ pf1=3Denp24s0f1np1

+++ readlink -ve /sys/class/net/enp24s0f0np0/device
++ basename /sys/devices/pci0000:17/0000:17:02.0/0000:18:00.0
+ pci=3D0000:18:00.0
+ devlink dev eswitch set pci/0000:18:00.0 mode legacy
+ echo 1
+ tee /sys/class/net/enp24s0f0np0/device/sriov_drivers_autoprobe
1
+ echo 3
+ tee /sys/class/net/enp24s0f0np0/device/sriov_numvfs
3

+ ip link set enp24s0f0np0 vf 0 mac 02:aa:aa:aa:aa:00
+ ip link set enp24s0f0np0 vf 1 mac 02:aa:aa:aa:aa:01
+ ip link set enp24s0f0np0 vf 2 mac 02:aa:aa:aa:aa:02
+ ip link set enp24s0f0v0 address 02:aa:aa:aa:aa:00
+ ip link set enp24s0f0v0 up
+ ip link set enp24s0f0v1 address 02:aa:aa:aa:aa:01
+ ip link set enp24s0f0v1 up
+ ip link set enp24s0f0v2 address 02:aa:aa:aa:aa:02
+ ip link set enp24s0f0v2 up

+++ readlink -ve /sys/class/net/enp24s0f0np0/device/virtfn0
++ basename /sys/devices/pci0000:17/0000:17:02.0/0000:18:00.2
+ vf00_pci=3D0000:18:00.2
+++ readlink -ve /sys/class/net/enp24s0f0np0/device/virtfn1
++ basename /sys/devices/pci0000:17/0000:17:02.0/0000:18:00.3
+ vf01_pci=3D0000:18:00.3
+++ readlink -ve /sys/class/net/enp24s0f0np0/device/virtfn2
++ basename /sys/devices/pci0000:17/0000:17:02.0/0000:18:00.4
+ vf02_pci=3D0000:18:00.4

+++ readlink -ve /sys/class/net/enp24s0f1np1/device
++ basename /sys/devices/pci0000:17/0000:17:02.0/0000:18:00.1
+ pci=3D0000:18:00.1
+ devlink dev eswitch set pci/0000:18:00.1 mode legacy
+ echo 1
+ tee /sys/class/net/enp24s0f1np1/device/sriov_drivers_autoprobe
1
+ echo 3
+ tee /sys/class/net/enp24s0f1np1/device/sriov_numvfs
3

+++ readlink -ve /sys/class/net/enp24s0f1np1/device/virtfn0
++ basename /sys/devices/pci0000:17/0000:17:02.0/0000:18:08.2
+ vf10_pci=3D0000:18:08.2
+++ readlink -ve /sys/class/net/enp24s0f1np1/device/virtfn1
++ basename /sys/devices/pci0000:17/0000:17:02.0/0000:18:08.3
+ vf11_pci=3D0000:18:08.3
+++ readlink -ve /sys/class/net/enp24s0f1np1/device/virtfn2
++ basename /sys/devices/pci0000:17/0000:17:02.0/0000:18:08.4
+ vf12_pci=3D0000:18:08.4

+ ip link set enp24s0f1np1 vf 0 mac 02:cc:cc:cc:cc:00
+ ip link set enp24s0f1np1 vf 1 mac 02:cc:cc:cc:cc:01
+ ip link set enp24s0f1np1 vf 2 mac 02:cc:cc:cc:cc:02
+ ip link set enp24s0f1v0 address 02:cc:cc:cc:cc:00
+ ip link set enp24s0f1v0 up
+ ip link set enp24s0f1v1 address 02:cc:cc:cc:cc:01
+ ip link set enp24s0f1v1 up
+ ip link set enp24s0f1v2 address 02:cc:cc:cc:cc:02
+ ip link set enp24s0f1v2 up

TESTPMD COMMANDS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

~# cat ./testpmd
set promisc all off

RUNTIME_DIRECTORY=3D/tmp/outer0 dpdk-testpmd -n 4 -l 0,12,32,13,33 -a
0000:18:00.2 -a 0000:18:00.3  -- \
        --nb-cores 4 --rxq=3D4 --txq=3D4 --rxd=3D2048 --txd=3D2048 --forwar=
d-mode=3Dmac
-i \
        --eth-peer=3D0,30:3e:a7:0b:f2:54 --eth-peer=3D1,02:aa:aa:aa:aa:02 \
        --rss-udp --auto-start --cmdline-file=3D./testpmd --record-burst-st=
ats

RUNTIME_DIRECTORY=3D/tmp/inner dpdk-testpmd -n 4 -l 0,14,34,15,35 -a 0000:1=
8:00.4
-a 0000:18:08.4 -- \
        --nb-cores 4 --rxq=3D4 --txq=3D4 --rxd=3D2048 --txd=3D2048 --forwar=
d-mode=3Dmac
-i \
        --eth-peer=3D0,02:aa:aa:aa:aa:01 --eth-peer=3D1,02:cc:cc:cc:cc:01 \
        --rss-udp --auto-start --cmdline-file=3D./testpmd --record-burst-st=
ats

RUNTIME_DIRECTORY=3D/tmp/outer1 dpdk-testpmd -n 4 -l 0,10,30,11,31 -a
0000:18:08.2 -a 0000:18:08.3 -- \
        --nb-cores 4 --rxq=3D4 --txq=3D4 --rxd=3D2048 --txd=3D2048 --forwar=
d-mode=3Dmac
-i \
        --eth-peer=3D0,30:3e:a7:0b:f2:55 --eth-peer=3D1,02:cc:cc:cc:cc:02 \
        --rss-udp --auto-start --cmdline-file=3D./testpmd --record-burst-st=
ats

--=20
You are receiving this mail because:
You are the assignee for the bug.=
