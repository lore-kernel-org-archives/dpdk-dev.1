Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EABDC54FDF
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 07:12:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7636840279;
	Thu, 30 Jul 2026 09:12:44 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BFB0940272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 09:12:42 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A585F4B986; Thu, 30 Jul 2026 09:12:42 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1974] [dpdk24.11.7-rc1] DPDK build failed with clang
 on Ubuntu26.04
Date: Thu, 30 Jul 2026 07:12:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 24.11
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
Message-ID: <bug-1974-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1974

            Bug ID: 1974
           Summary: [dpdk24.11.7-rc1] DPDK build failed with clang on
                    Ubuntu26.04
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: daxuex.gao@intel.com
  Target Milestone: ---

[Environment]
DPDK version:=20
 commit e06a047b5b00c97462ddc8208d7f152c6766b378 (HEAD, tag: v24.11.7-rc1,
origin/24.11)
OS: Ubuntu26.04/7.0.0-14-generic
Compiler: clang version 21.1.8

[Test Setup]
# build cmd:=20
CC=3Dclang meson --werror -Dlibdir=3Dlib -Dexamples=3Dall --default-library=
=3Dstatic
x86_64-native-linuxapp-clang
ninja -C x86_64-native-linuxapp-clang/

[Output]
ninja: Entering directory `x86_64-native-linuxapp-clang/'
[2926/3392] Compiling C object app/dpdk-test-bbdev.p/test-bbdev_test_bbdev.=
c.o
FAILED: app/dpdk-test-bbdev.p/test-bbdev_test_bbdev.c.o
clang -Iapp/dpdk-test-bbdev.p -Iapp -I../app -Ilib/bbdev -I../lib/bbdev -I.
-I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include
-Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include
-I../lib/eal/x86/include -I../kernel/linux -Ilib/eal/common -I../lib/eal/co=
mmon
-Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log
-Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/mbuf
-I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring
-Idrivers/bus/vdev -I../drivers/bus/vdev -Idrivers/baseband/fpga_lte_fec
-I../drivers/baseband/fpga_lte_fec -Ilib/pci -I../lib/pci -Idrivers/bus/pci
-I../drivers/bus/pci -I../drivers/bus/pci/linux
-Idrivers/baseband/fpga_5gnr_fec -I../drivers/baseband/fpga_5gnr_fec
-Idrivers/baseband/acc -I../drivers/baseband/acc -Idrivers/baseband/la12xx
-I../drivers/baseband/la12xx -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BI=
TS=3D64
-Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -include rte_config.h
-Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs
-Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes
-Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE
-march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -MD -MQ
app/dpdk-test-bbdev.p/test-bbdev_test_bbdev.c.o -MF
app/dpdk-test-bbdev.p/test-bbdev_test_bbdev.c.o.d -o
app/dpdk-test-bbdev.p/test-bbdev_test_bbdev.c.o -c
../app/test-bbdev/test_bbdev.c
../app/test-bbdev/test_bbdev.c:819:4: error: format specifies type 'unsigned
char' but the argument has type 'uint16_t' (aka 'unsigned short')
[-Werror,-Wformat]
  816 |         TEST_ASSERT(dev1->data->dev_id < RTE_BBDEV_MAX_DEVS,
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  817 |                         "Failed test rte_bbdev_allocate: "
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  818 |                         "invalid dev_id %" PRIu8 ", max number of
devices %d ",
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  819 |                         dev1->data->dev_id, RTE_BBDEV_MAX_DEVS);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../app/test-bbdev/main.h:30:37: note: expanded from macro 'TEST_ASSERT'
   30 |                                 msg "\n", __func__, __LINE__,
##__VA_ARGS__); \
      |                                 ~~~=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
^~~~~~~~~~~
1 error generated.
[2937/3392] Compiling C object
app/dpdk-test-bbdev.p/test-bbdev_test_bbdev_perf.c.o
ninja: build stopped: subcommand failed.

[Expected Result]
Build Passed

This issue was discovered on the new Ubuntu 26 OS.
No issues were encountered when running version v24.11.7-rc1 on Ubuntu 24.0=
4.
Ubuntu 24.04 environment:
  Ubuntu 24.04.3 LTS/Linux 6.8.0-41-generic
  Compiler: clang 18.1.3

--=20
You are receiving this mail because:
You are the assignee for the bug.=
