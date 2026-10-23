Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB96606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 06:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29F1E402D8;
	Fri, 23 Oct 2026 08:36:01 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 56C1740268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 08:35:59 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 402974D286; Fri, 23 Oct 2026 08:35:59 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 2071] [dpdk-26.11]vswitch_sample_cbdma: No
 response at all when quitting vhost-user with CTRL+C
Date: Fri, 23 Oct 2026 06:35:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yux.jiang@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2071-3@https.bugs.dpdk.org/>
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
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2071

            Bug ID: 2071
           Summary: [dpdk-26.11]vswitch_sample_cbdma: No response at all
                    when quitting vhost-user with CTRL+C
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

---------------------------------------------------------------------------=
-----
DPDK version: dpdk 9a45341f18 (HEAD -> main, tag: v26.11-rc1, origin/main,
origin/HEAD) version: 26.11-rc1
Other software versions: QEMU emulator version 11.1.2
OS: Ubuntu26.04.1 LTS/7.0.0-38-generic
Compiler: gcc version 13.3.0
Hardware platform: Intel(R) Xeon(R) Platinum 8468H
---------------------------------------------------------------------------=
-----
Test Setup
Steps to reproduce

1. Use the following command to build DPDK:
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson setup -Dlibdir=3Dlib -Dexamples=3Dvhost --default-library=3D=
static=20
x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2. Bind NIC and CBDMA device:

usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:cc:00.0 0000:cc:00=
.1
./usertools/dpdk-devbind.py --status-dev dma
./usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:80:01.0 0000:80:=
01.1
0000:80:01.2 0000:80:01.3

3, Launch vhost-user and virito-user0 and virtio-uer1

vhost-user:  rm -rf vhost-net*
vhost-user:  x86_64-native-linuxapp-gcc/examples/dpdk-vhost  -l 40-41 -n 4 =
 -a
0000:cc:00.0 -a 0000:80:01.0 -a 0000:80:01.1 -a 0000:80:01.2 -a 0000:80:01.=
3 --
-p 0x1 --mergeable 1 --vm2vm 1 --stats 1 --socket-file ./vhost-net0
--socket-file ./vhost-net1 --dmas
[txd0@0000:80:01.0,rxd0@0000:80:01.1,txd1@0000:80:01.2,rxd1@0000:80:01.3]
--total-num-mbufs 600000 --client

virtio-user0: x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 42-43 -n 4=20
--file-prefix=3Dvirtio-user0 --no-pci=20=20
--vdev=3Dnet_virtio_user0,mac=3D00:11:22:33:44:10,path=3D./vhost-net0,queue=
s=3D1,server=3D1,mrg_rxbuf=3D1,in_order=3D0,packed_vq=3D1
-- -i --rxq=3D1 --txq=3D1 --txd=3D1024 --rxd=3D1024 --nb-cores=3D1

virtio-user1: x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 44-45 -n 4=20
--file-prefix=3Dvirtio-user1 --no-pci=20=20
--vdev=3Dnet_virtio_user0,mac=3D00:11:22:33:44:11,path=3D./vhost-net1,queue=
s=3D1,server=3D1,mrg_rxbuf=3D1,in_order=3D1,vectorized=3D1
-- -i --rxq=3D1 --txq=3D1 --txd=3D1024 --rxd=3D1024 --nb-cores=3D1

4, quit vhost-user with CTRL+C, no response at all

vhost-user: ^C

---------------------------------------------------------------------------=
-----
Expected Result:

quit successfully

---------------------------------------------------------------------------=
-----
Is this issue a regression: (Y/N) Y

Version the regression was introduced:=20

commit 5ffa8fafcbd370779391d418beef0235f8f0840b
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Mon Sep 7 10:03:24 2026 -0700

    examples/vhost: make signal handler safe

    The SIGINT handler unregistered the vhost drivers and called exit(),
    neither of which is async-signal-safe.

    Set a flag, let switch_worker() return, and unregister the drivers in
    main() after joining the lcores.

    Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
    Acked-by: Bruce Richardson <bruce.richardson@intel.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
