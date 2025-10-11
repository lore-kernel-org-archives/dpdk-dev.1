Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B402ACCD185
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Oct 2025 02:53:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 901D84021E;
	Sat, 11 Oct 2025 04:53:08 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DC7E14003C
 for <dev@dpdk.org>; Sat, 11 Oct 2025 04:53:06 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B999B48906; Sat, 11 Oct 2025 04:53:06 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1799] [dpdk-25.11-rc0]
 ipv4_reassembly/test_send_2K_frames_split_in_4_and_1K_maxflows: Cannot
 configure device:
Date: Sat, 11 Oct 2025 02:53:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daxuex.gao@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1799-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1799

            Bug ID: 1799
           Summary: [dpdk-25.11-rc0]
                    ipv4_reassembly/test_send_2K_frames_split_in_4_and_1K_
                    maxflows: Cannot configure device:
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: daxuex.gao@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 25.11.0-rc0: 2b403dd8fb
OS: Ubuntu Fedora Linux 42/Linux 6.14.0-63.fc42.x86_64
Compiler: gcc version 15.2.1
Hardware platform: Intel(R) Xeon(R) Platinum 8490H
NIC hardware: Intel Corporation Ethernet Controller XXV710 for 25GbE SFP28
[8086:158b]
NIC firmware:=20
 driver: vfio-pci
 kdriver: 2.28.10
 firmware-version: 9.55 0x8000fe4c 1.3862.0


Test Setup
Steps to reproduce
List the steps to reproduce the issue.

1.dut:
# dpdk-devbind.py -b vfio-pci  0000:1f:00.0 0000:1f:00.1
# ./x86_64-native-linuxapp-gcc/examples/dpdk-ip_reassembly  -l 1 -n 4 -a
0000:1f:00.0 -a 0000:1f:00.1  --file-prefix=3Ddpdk_380038_20251011153916   =
   --=20
-p 0x1 --maxflows=3D1024 --flowttl=3D10s

2.Show the output from the previous commands.
# ./x86_64-native-linuxapp-gcc/examples/dpdk-ip_reassembly  -l 1 -n 4 -a
0000:1f:00.0 -a 0000:1f:00.1  --file-prefix=3Ddpdk_380038_20251011153916   =
   --=20
-p 0x1 --maxflows=3D1024 --flowttl=3D10s
EAL: Detected CPU lcores: 240
EAL: Detected NUMA nodes: 4
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/dpdk_380038_20251011153916/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: 1024 hugepages of size 2097152 reserved, but no mounted hugetlbfs found
for that size
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
IP_RSMBL: Creating LPM table on socket 0
IP_RSMBL: Creating LPM6 table on socket 0
IPFRAG: rte_ip_frag_table_create: allocated of 8388736 bytes at socket 0
Initializing port 0 ... Port 0 modified RSS hash function based on hardware
support,requested:0xa38c configured:0x228c
ETHDEV: id=3D0 offload clash, MULTI_SEGS vs MBUF_FAST_FREE

EAL: Error - exiting with code: 1
Cannot configure device: err=3D-22, port=3D0


Expected Result
# ./x86_64-native-linuxapp-gcc/examples/dpdk-ip_reassembly  -l 1 -n 4 -a
0000:1f:00.0 -a 0000:1f:00.1  --file-prefix=3Ddpdk_380038_20251011153916   =
   --=20
-p 0x1 --maxflows=3D1024 --flowttl=3D10s
EAL: Detected CPU lcores: 240
EAL: Detected NUMA nodes: 4
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/dpdk_380038_20251011153916/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: 1024 hugepages of size 2097152 reserved, but no mounted hugetlbfs found
for that size
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
IP_RSMBL: Creating LPM table on socket 0
IP_RSMBL: Creating LPM6 table on socket 0
IPFRAG: rte_ip_frag_table_create: allocated of 8388736 bytes at socket 0
Initializing port 0 ... Port 0 modified RSS hash function based on hardware
support,requested:0xa38c configured:0x228c
 Address:3C:FD:FE:CF:33:74
txq=3D1,0,0

Skipping disabled port 1

IP_RSMBL: Socket 0: adding route 100.10.0.0/16 (port 0)
IP_RSMBL: Socket 0: adding route 100.20.0.0/16 (port 1)
IP_RSMBL: Socket 0: adding route 100.30.0.0/16 (port 2)
IP_RSMBL: Socket 0: adding route 100.40.0.0/16 (port 3)
IP_RSMBL: Socket 0: adding route 100.50.0.0/16 (port 4)
IP_RSMBL: Socket 0: adding route 100.60.0.0/16 (port 5)
IP_RSMBL: Socket 0: adding route 100.70.0.0/16 (port 6)
IP_RSMBL: Socket 0: adding route 100.80.0.0/16 (port 7)
IP_RSMBL: Socket 0: adding route 0101:0101:0101:0101:0101:0101:0101:0101/48
(port 0)
IP_RSMBL: Socket 0: adding route 0201:0101:0101:0101:0101:0101:0101:0101/48
(port 1)
IP_RSMBL: Socket 0: adding route 0301:0101:0101:0101:0101:0101:0101:0101/48
(port 2)
IP_RSMBL: Socket 0: adding route 0401:0101:0101:0101:0101:0101:0101:0101/48
(port 3)
IP_RSMBL: Socket 0: adding route 0501:0101:0101:0101:0101:0101:0101:0101/48
(port 4)
IP_RSMBL: Socket 0: adding route 0601:0101:0101:0101:0101:0101:0101:0101/48
(port 5)
IP_RSMBL: Socket 0: adding route 0701:0101:0101:0101:0101:0101:0101:0101/48
(port 6)

Checking link status
done
Port 0 Link up at 10 Gbps FDX Autoneg
IP_RSMBL: entering main loop on lcore 1
IP_RSMBL:  -- lcoreid=3D1 portid=3D0
^C -- lcoreid=3D1 portid=3D0 frag tbl stat:


Regression
Is this issue a regression: (Y/N)Y

Bad commit:
commit fdb840367cf0d6abeb17b05623679b8d1ea4c902
Author: Morten Br=C3=B8rup <mb@smartsharesystems.com>
Date:   Sun Aug 3 19:42:18 2025 +0000

    ethdev: reject conflicting Tx offload configurations

    When an ethdev port is configured for fast mbuf release, the driver can
    use a Tx burst function relying on the fast mbuf release preconditions.
    Thus, also configuring this port or a queue on the port for transmitting
    segmented packets is prohibited.
    Checks for these conflicting configurations have been added to the ethd=
ev
    library, so the drivers don't have to implement them.

    Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
    Acked-by: Bruce Richardson <bruce.richardson@intel.com>
    Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
    Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

lib/ethdev/rte_ethdev.c | 37 +++++++++++++++++++++++++++++++++++++
1 file changed, 37 insertions(+)

--=20
You are receiving this mail because:
You are the assignee for the bug.=
