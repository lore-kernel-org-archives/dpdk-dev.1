Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B7C108E1F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 12:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DB41402D4;
	Thu, 19 Mar 2026 13:00:05 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C7D244025D
 for <dev@dpdk.org>; Thu, 19 Mar 2026 13:00:03 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AB50C4AD46; Thu, 19 Mar 2026 13:00:03 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1904] [dpdk-26.03]
 lib/librte_pipeline.a.p/pipeline_rte_table_action.c.o build failure with gcc
 13.3 on Ubuntu24.04.4/linux kernel 6.8.0-106-generic
Date: Thu, 19 Mar 2026 12:00:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.03
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
Message-ID: <bug-1904-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1904

            Bug ID: 1904
           Summary: [dpdk-26.03]
                    lib/librte_pipeline.a.p/pipeline_rte_table_action.c.o
                    build failure with gcc 13.3 on Ubuntu24.04.4/linux
                    kernel 6.8.0-106-generic
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

[DPDK 26.03RC2]
commit ea0f94fe520b6931af3fea295796921c2da607f1 (tag: v26.03-rc2)
Author: Thomas Monjalon <thomas@monjalon.net>
Date:   Tue Mar 17 18:08:49 2026 +0100

    version: 26.03-rc2

    Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

[Env info]
cpu: Intel(R) Xeon(R) Platinum 8468H  CPU @ 2.1GHz
os/kernel: Ubuntu 24.04.4 LTS/6.8.0-106-generic
gcc version 13.3.0

[Reproduced steps]:

1, Build dpdk

rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson setup -Dlibdir=3Dlib --default-library=3Dstatic
x86_64-native-linuxapp-gcc -Dmax_lcores=3D192
ninja -C x86_64-native-linuxapp-gcc

[Error logs]
[1787/3694] Compiling C object
lib/librte_pipeline.a.p/pipeline_rte_table_action.c.o
FAILED: lib/librte_pipeline.a.p/pipeline_rte_table_action.c.o
gcc -Ilib/librte_pipeline.a.p -Ilib -I../lib -Ilib/pipeline -I../lib/pipeli=
ne
-Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config
-Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include
-I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include
-I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib=
/log
-I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/teleme=
try
-Ilib/argparse -I../lib/argparse -Ilib/port -I../lib/port -Ilib/ethdev
-I../lib/ethdev -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempo=
ol
-I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter
-Ilib/sched -I../lib/sched -Ilib/ip_frag -I../lib/ip_frag -Ilib/hash
-I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/cryptodev -I../lib/cryptodev
-Ilib/eventdev -I../lib/eventdev -Ilib/timer -I../lib/timer -Ilib/dmadev
-I../lib/dmadev -Ilib/table -I../lib/table -Ilib/lpm -I../lib/lpm -Ilib/acl
-I../lib/acl -Ilib/ipsec -I../lib/ipsec -Ilib/security -I../lib/security
-I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include
-I/usr/include/libnl3 -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64=
 -Wall
-Winvalid-pch -Wextra -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual
-Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs
-Wold-style-definition -Wpointer-arith -Wshadow -Wsign-compare
-Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned
-Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm
-DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-vla
-DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.pipeline -MD -MQ
lib/librte_pipeline.a.p/pipeline_rte_table_action.c.o -MF
lib/librte_pipeline.a.p/pipeline_rte_table_action.c.o.d -o
lib/librte_pipeline.a.p/pipeline_rte_table_action.c.o -c
../lib/pipeline/rte_table_action.c
gcc: fatal error: Killed signal terminated program cc1
compilation terminated.
[1980/3694] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx5_flow_hw.c.o
ninja: build stopped: subcommand failed.
root@dpdk-yingya-spr1:~/dpdk#


[Bad commit] N
dpdk25.11 also build fail

--=20
You are receiving this mail because:
You are the assignee for the bug.=
