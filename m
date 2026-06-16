Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB2CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 01:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E046140285;
	Tue, 16 Jun 2026 03:33:25 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E69404013F
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:33:24 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C983C4B6A2; Tue, 16 Jun 2026 03:33:24 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1956] [dpdk-26.07-rc1] ice_buffer_split: testpmd
 start failed when set multiple mbuf-size
Date: Tue, 16 Jun 2026 01:33:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 26.07
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
Message-ID: <bug-1956-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1956

            Bug ID: 1956
           Summary: [dpdk-26.07-rc1] ice_buffer_split: testpmd start
                    failed when set multiple mbuf-size
           Product: DPDK
           Version: 26.07
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
dpdk-25.11.0-rc1: 39b54f2dcf44ad1f91eabc7080cd5dea763607fd
OS: openEuler24.03/6.6.0-145.0.4.135.oe2403sp3.x86_64
Compiler: gcc version 12.3.1 (openEuler 12.3.1-105.oe2403sp3) (GCC)
NIC hardware: CVL,Intel Corporation Ethernet Controller E810-C for SFP
[8086:1593] (rev 02)

NIC firmware:
driver: vfio-pci
kdriver: ice-2.6.4
fw: 5.00 0x80021c11 1.4002.0
ddp: ice os default 1.3.59.0

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Compile DPDK
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Dlibdir=3Dlib -Dc_args=3D'-DRTE_ETHDEV_DEBUG_RX=3D1'
--default-library=3Dstatic x86_64-native-linuxapp-gcc=20
ninja -C x86_64-native-linuxapp-gcc -j 72

2. bind port to vfio-pci
./usertools/dpdk-devbind.py -b vfio-pci 0000:18:00.0 0000:18:00.1

3. start testpmd
./x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-2 -n 4 -a 0000:18:00.0 -a
0000:18:00.1 --force-max-simd-bitwidth=3D64 -- -i --mbuf-size=3D2048,2048


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
Configuring Port 0 (socket 0)
ETHDEV: No Rx segmentation offload configured
Fail to configure port 0 rx queues
Start ports failed=20

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
testpmd started successfully and the buff split is working fine

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 0be0ad196b52ab4fab88a51de35a2a4c83b21362
Author: Gregory Etelson <getelson@nvidia.com>
Date:   Sat Jun 6 01:33:43 2026 +0200

    app/testpmd: support selective Rx

    Add support for selective Rx using existing rxpkts and mbuf-size
    command line parameters.

    When a segment is specified with rxpkts and a matching 0 mbuf-size
    on PMDs supporting selective Rx,
    testpmd set the mempool of the segment to NULL,
    meaning the segment won't be received.

    Example usage to receive only Ethernet header and 64 bytes at offset 12=
8:

      --rxpkts=3D14,114,64,0 --mbuf-size=3D256,0,256,0

    This creates segments:
    - [0-13]: 14 bytes with mempool (received)
    - [14-127]: 114 bytes with NULL mempool (discarded)
    - [128-191]: 64 bytes with mempool (received)
    - [192-max]: remaining bytes with NULL mempool (discarded)

    If the first segment has no mempool,
    there will be no mempool created with the index 0.
    That's why the lookup of the first mempool is now achieved
    in the new function mbuf_pool_find_first(socket)
    instead of mbuf_pool_find(socket, index 0)

    Note: RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT is required for this feature
    and is checked at ethdev API level.
    This check is removed from testpmd to allow negative testing of the API.

    Signed-off-by: Gregory Etelson <getelson@nvidia.com>
    Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

 app/test-pmd/cmdline.c                      |  2 +-
 app/test-pmd/parameters.c                   |  5 ++-
 app/test-pmd/testpmd.c                      | 48 +++++++++++++++++--------=
----
 app/test-pmd/testpmd.h                      | 16 ++++++++++
 doc/guides/testpmd_app_ug/run_app.rst       | 16 ++++++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  3 +-
 6 files changed, 66 insertions, 24 deletions

--=20
You are receiving this mail because:
You are the assignee for the bug.=
