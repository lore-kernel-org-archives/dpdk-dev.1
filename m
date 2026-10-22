Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE773606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 09:27:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE3F340264;
	Thu, 22 Oct 2026 11:27:43 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4000E4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 11:27:42 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 306F44CEF8; Thu, 22 Oct 2026 11:27:42 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2069] [dpdk 26.11-rc1]
 multiprocess/test_multiprocess_symmetric_mp_packet second process coredump
Date: Thu, 22 Oct 2026 09:27:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.11
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
Message-ID: <bug-2069-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2069

            Bug ID: 2069
           Summary: [dpdk 26.11-rc1]
                    multiprocess/test_multiprocess_symmetric_mp_packet
                    second process coredump
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: daxuex.gao@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 26.11.0-rc1(9a45341f18a1a)
OS: Fedora Linux 44 (Forty Four)/Linux 7.2.5-200.fc44.x86_64
Compiler: gcc version 16.2.1
Hardware platform: Intel(R) Xeon(R) Platinum 8490H
NIC hardware: Ethernet Controller E810-C for QSFP 1592 [8086:1592 (rev 02)]
NIC firmware: 5.01 0x80021f8b 1.4031.0
NIC driver: ice-2.7.4
DDP package:  ice comms 1.3.63.0

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1.Build dpdk=20
CC=3Dgcc meson -Dlibdir=3Dlib
-Dexamples=3D'multi_process/client_server_mp/mp_server,multi_process/client=
_server_mp/mp_client,multi_process/simple_mp,multi_process/symmetric_mp'
--default-library=3Dstatic x86_64-native-linuxapp-gcc -Dmax_lcores=3D240
ninja -C x86_64-native-linuxapp-gcc/

2.Start testpmd
dpdk-devbind.py --force --bind=3Dvfio-pci 0000:45:00.0 -a 0000:47:00.0
x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 2 -n 4 -a 0000:45:=
00.0
-a 0000:47:00.0  --file-prefix=3Ddpdk_6818_20261022163537     --proc-type=
=3Dauto --
-p 0x3 --num-procs=3D2 --proc-id=3D1

x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 2 -n 4 -a 0000:45:=
00.0
-a 0000:47:00.0  --file-prefix=3Ddpdk_6818_20261022163537     --proc-type=
=3Dauto --
-p 0x3 --num-procs=3D2 --proc-id=3D1

After stopping the first testpmd process, the second process generated a co=
re
dump:
Error result:
Segmentation fault         (core dumped)
x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 2 -n 4 -a 0000:45:=
00.0
-a 0000:47:00.0 --file-prefix=3Ddpdk_6818_20261022163537 --proc-type=3Dauto=
 -- -p
0x3 --num-procs=3D2 --proc-id=3D1

Expected Result:
The first testpmd process exits, but the second testpmd process does not ex=
it
automatically.
# x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 2 -n 4 -a
0000:45:00.0 -a 0000:47:00.0  --file-prefix=3Ddpdk_6818_20261022163537=20=
=20=20=20
--proc-type=3Dauto -- -p=20

^CPort 0: RX - 0, TX - 0, Drop - 0
Port 1: RX - 0, TX - 0, Drop - 0

# x86_64-native-linuxapp-gcc/examples/dpdk-symmetric_mp -l 2 -n 4 -a
0000:45:00.0 -a 0000:47:00.0  --file-prefix=3Ddpdk_6818_20261022163537=20=
=20=20=20
--proc-type=3Dauto -- -p=20

^CPort 0: RX - 0, TX - 0, Drop - 0
Port 1: RX - 0, TX - 0, Drop - 0

Regression
Is this issue a regression: N

Bad commit:
commit 9a0b3c409db1963a92d0a91868b1e45254845a8c
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Mon Sep 7 10:03:22 2026 -0700

    examples/symmetric_mp: do not print or exit in handler
    The SIGINT and SIGTERM handler called printf() and exit() which are
    not async-signal-safe.
    Set a flag, let the forwarding loops return, and print the stats from
    main() after joining the lcores.
    Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
    Acked-by: Bruce Richardson <bruce.richardson@intel.com>

examples/multi_process/symmetric_mp/main.c | 24 ++++++++++++++++++------

--=20
You are receiving this mail because:
You are the assignee for the bug.=
