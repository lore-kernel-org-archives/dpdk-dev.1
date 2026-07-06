Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A432C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 09:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4B52402C3;
	Mon,  6 Jul 2026 11:17:27 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0B18C4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 11:17:27 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id DA2194B819; Mon,  6 Jul 2026 11:17:26 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1964] [dpdk26.07-rc2] DPDK build failed with
 EXTRA_CFLAGS='-O1' on Ubuntu26.04
Date: Mon, 06 Jul 2026 09:17:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.07
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
Message-ID: <bug-1964-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1964

            Bug ID: 1964
           Summary: [dpdk26.07-rc2] DPDK build failed with
                    EXTRA_CFLAGS=3D'-O1' on Ubuntu26.04
           Product: DPDK
           Version: 26.07
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
commit f77bc8767a952cf833fc9c85d6b5b8d77d39a5da (HEAD -> main, tag: v26.07-=
rc2,
origin/main, origin/HEAD)
OS: Ubuntu26.04/7.0.0-14-generic
Compiler: gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0

[Test Setup]
# build cmd:=20
CC=3Dgcc meson --optimization=3D1 --werror  -Dlibdir=3Dlib  --default-libra=
ry=3Dstatic
x86_64-native-linuxapp-gcc=20
ninja -C x86_64-native-linuxapp-gcc

[Output]
# ninja -C x86_64-native-linuxapp-gcc
ninja: Entering directory `x86_64-native-linuxapp-gcc'
[1683/3722] Compiling C object
drivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_fdir.c.o
FAILED: drivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_fdir.c.o
gcc -Idrivers/libtmp_rte_net_hinic3.a.p -Idrivers -I../drivers
-Idrivers/net/hinic3 -I../drivers/net/hinic3 -Idrivers/net/hinic3/base
-I../drivers/net/hinic3/base -Idrivers/net/hinic3/htn_adapt
-I../drivers/net/hinic3/htn_adapt -Idrivers/net/hinic3/stn_adapt
-I../drivers/net/hinic3/stn_adapt -Ilib/ethdev -I../lib/ethdev -Ilib/eal/co=
mmon
-I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include
-Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal
-I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metr=
ics
-I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse
-I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mem=
pool
-I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter
-Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci
-I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra
-Werror -std=3Dc11 -O1 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated
-Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers
-fzero-init-padding-bits=3Dall -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm
-DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
-Wno-address-of-packed-member -DHW_CONVERT_ENDIAN -DRTE_COMPONENT_CLASS=3Dp=
md_net
-DRTE_COMPONENT_NAME=3Dhinic3 -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.hinic3 -M=
D -MQ
drivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_fdir.c.o -MF
drivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_fdir.c.o.d -o
drivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_fdir.c.o -c
../drivers/net/hinic3/hinic3_fdir.c
../drivers/net/hinic3/hinic3_fdir.c: In function
=E2=80=98hinic3_enable_rxq_fdir_filter=E2=80=99:
../drivers/net/hinic3/hinic3_fdir.c:1278:13: error: =E2=80=98ret=E2=80=99 m=
ay be used
uninitialized [-Werror=3Dmaybe-uninitialized]
 1278 |         int ret;
      |             ^~~
cc1: all warnings being treated as errors
[1694/3722] Compiling C object
drivers/libtmp_rte_net_hinic3.a.p/net_hinic3_hinic3_ethdev.c.o
ninja: build stopped: subcommand failed.

[Expected Result]
Build Passed

[Regression]
Is this issue a regression: (Y/N)N

[First bad commit]
commit 1c963e5976a812771a4f3329e340ff9f9bef4406 (HEAD)
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Tue Jun 9 08:53:30 2026 -0700

    tailq: fix name truncation

    The tailq name is defined as 32 bytes, but name would be
    silently truncated at 31 bytes. The function strlcpy() size
    already accounts for the NUL character at the end.

    Bugzilla ID: 1954
    Fixes: f9acaf84e923 ("replace snprintf with strlcpy without adding extra
include")
    Cc: stable@dpdk.org

    Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
    Acked-by: Chengwen Feng <fengchengwen@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
