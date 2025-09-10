Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75272CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 06:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DD12402C4;
	Wed, 10 Sep 2025 08:10:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 21A6540270
 for <dev@dpdk.org>; Wed, 10 Sep 2025 08:10:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1C23B46EBA; Wed, 10 Sep 2025 08:10:31 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/examples Bug 1785] [dpdk-25.11.0-rc0]ipv4_reassembly: start
 examples/dpdk-ip_reassembly fail
Date: Wed, 10 Sep 2025 06:10:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yex.chen@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1785-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17574846300.acD04.1281907
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


--17574846300.acD04.1281907
Date: Wed, 10 Sep 2025 08:10:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1785

            Bug ID: 1785
           Summary: [dpdk-25.11.0-rc0]ipv4_reassembly: start
                    examples/dpdk-ip_reassembly fail
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: examples
          Assignee: dev@dpdk.org
          Reporter: yex.chen@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 9fe9c0b231c8da5435bfccb1963121b4277f961c version: dpdk25.07-r=
c3
OS: Fedora42/6.14.5-300.fc42.x86_64
Compiler: gcc version 15.2.1 20250808
Hardware platform: Intel(R) Xeon(R) Gold 6252N CPU @ 2.30GHz
NIC hardware: Intel Corporation Ethernet Controller X710 for 10GbE SFP+ (rev
01)
NIC firmware:=20
  driver: vfio-pci
  kdriver: i40e-2.28.7
  firmware-version: 9.54 0x8000fb3f 1.3800.0


Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.Build dpdk and examples=3Dip_reassembly
CC=3Dgcc meson -Denable_kmods=3DFalse -Dlibdir=3Dlib -Dexamples=3Dip_reasse=
mbly
--default-library=3Dstatic x86_64-native-linuxapp-gcc -Dmax_lcores=3D160
ninja -C x86_64-native-linuxapp-gcc

2.Start dpdk-ip_reassembly
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:31:00.0 0000:31:00=
.1
./x86_64-native-linuxapp-gcc/examples/dpdk-ip_reassembly  -l 1 -n 4 -a
0000:31:00.0 -a 0000:31:00.1  --file-prefix=3Ddpdk_513316_20250910130931=20=
=20=20=20
--force-max-simd-bitwidth=3D64   --  -p 0x1 --maxflows=3D1024 --flowttl=3D3s


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
EAL: Detected CPU lcores: 160
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/dpdk_513316_20250910130931/mp_socket
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


Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
EAL: Detected CPU lcores: 160
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/dpdk_513316_20250910130931/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: 1024 hugepages of size 2097152 reserved, but no mounted hugetlbfs found
for that size
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
I40E_DRIVER: i40e_GLQF_reg_init(): i40e device 0000:31:00.0 changed global
register [0x002689a0]. original: 0x00000021, new: 0x00000029=20
IP_RSMBL: Creating LPM table on socket 0
IP_RSMBL: Creating LPM6 table on socket 0
IPFRAG: rte_ip_frag_table_create: allocated of 8388736 bytes at socket 0
Initializing port 0 ... Port 0 modified RSS hash function based on hardware
support,requested:0xa38c configured:0x228c
 Address:3C:FD:FE:C0:E1:D8
txq=3D1,0,0=20

Skipping disabled port 1
......
Checking link status
done
Port 0 Link up at 25 Gbps FDX Autoneg
IP_RSMBL: entering main loop on lcore 1
IP_RSMBL:  -- lcoreid=3D1 portid=3D0


bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17574846300.acD04.1281907
Date: Wed, 10 Sep 2025 08:10:30 +0200
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
   title=3D"UNCONFIRMED - [dpdk-25.11.0-rc0]ipv4_reassembly: start examples=
/dpdk-ip_reassembly fail"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1785">1785</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.11.0-rc0]ipv4_reassembly: start examples/dpdk-ip_rea=
ssembly fail
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.07
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
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
          <td>examples
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>yex.chen&#64;intel.com
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
DPDK version: 9fe9c0b231c8da5435bfccb1963121b4277f961c version: dpdk25.07-r=
c3
OS: Fedora42/6.14.5-300.fc42.x86_64
Compiler: gcc version 15.2.1 20250808
Hardware platform: Intel(R) Xeon(R) Gold 6252N CPU &#64; 2.30GHz
NIC hardware: Intel Corporation Ethernet Controller X710 for 10GbE SFP+ (rev
01)
NIC firmware:=20
  driver: vfio-pci
  kdriver: i40e-2.28.7
  firmware-version: 9.54 0x8000fb3f 1.3800.0


Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.Build dpdk and examples=3Dip_reassembly
CC=3Dgcc meson -Denable_kmods=3DFalse -Dlibdir=3Dlib -Dexamples=3Dip_reasse=
mbly
--default-library=3Dstatic x86_64-native-linuxapp-gcc -Dmax_lcores=3D160
ninja -C x86_64-native-linuxapp-gcc

2.Start dpdk-ip_reassembly
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:31:00.0 0000:31:00=
.1
./x86_64-native-linuxapp-gcc/examples/dpdk-ip_reassembly  -l 1 -n 4 -a
0000:31:00.0 -a 0000:31:00.1  --file-prefix=3Ddpdk_513316_20250910130931=20=
=20=20=20
--force-max-simd-bitwidth=3D64   --  -p 0x1 --maxflows=3D1024 --flowttl=3D3s


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
EAL: Detected CPU lcores: 160
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/dpdk_513316_20250910130931/mp_socket
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


Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
EAL: Detected CPU lcores: 160
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/dpdk_513316_20250910130931/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: 1024 hugepages of size 2097152 reserved, but no mounted hugetlbfs found
for that size
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
I40E_DRIVER: i40e_GLQF_reg_init(): i40e device 0000:31:00.0 changed global
register [0x002689a0]. original: 0x00000021, new: 0x00000029=20
IP_RSMBL: Creating LPM table on socket 0
IP_RSMBL: Creating LPM6 table on socket 0
IPFRAG: rte_ip_frag_table_create: allocated of 8388736 bytes at socket 0
Initializing port 0 ... Port 0 modified RSS hash function based on hardware
support,requested:0xa38c configured:0x228c
 Address:3C:FD:FE:C0:E1:D8
txq=3D1,0,0=20

Skipping disabled port 1
......
Checking link status
done
Port 0 Link up at 25 Gbps FDX Autoneg
IP_RSMBL: entering main loop on lcore 1
IP_RSMBL:  -- lcoreid=3D1 portid=3D0


bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit fdb840367cf0d6abeb17b05623679b8d1ea4c902
Author: Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb&#64;smartsharesystems.c=
om">mb&#64;smartsharesystems.com</a>&gt;
Date:   Sun Aug 3 19:42:18 2025 +0000

    ethdev: reject conflicting Tx offload configurations

    When an ethdev port is configured for fast mbuf release, the driver can
    use a Tx burst function relying on the fast mbuf release preconditions.
    Thus, also configuring this port or a queue on the port for transmitting
    segmented packets is prohibited.
    Checks for these conflicting configurations have been added to the ethd=
ev
    library, so the drivers don't have to implement them.

    Signed-off-by: Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb&#64;smartsha=
resystems.com">mb&#64;smartsharesystems.com</a>&gt;
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
?id=3D1785">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17574846300.acD04.1281907--
