Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23823CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB78E402C9;
	Mon, 27 Oct 2025 17:32:22 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 04BCF4028B
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:32:21 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D8758489EF; Mon, 27 Oct 2025 17:32:20 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1814] dmadev build fails if debug enabled
Date: Mon, 27 Oct 2025 16:32:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1814-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1814

            Bug ID: 1814
           Summary: dmadev build fails if debug enabled
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

I do test build with all the XXX_DEBUG options enabled.
If RTE_DMADEV_DEBUG is enabled, then build fails here:

FAILED: lib/librte_dmadev.a.p/dmadev_rte_dmadev_trace_points.c.o=20
cc -Ilib/librte_dmadev.a.p -Ilib -I../lib -Ilib/dmadev -I../lib/dmadev
-Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config
-Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include
-I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include
-I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib=
/log
-I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/teleme=
try
-Ilib/argparse -I../lib/argparse -I/usr/include/x86_64-linux-gnu
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra
-std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat
-Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers
-fzero-init-padding-bits=3Dall -D_GNU_SOURCE -DRTE_ENABLE_ASSERT
-DRTE_LIBRTE_ETHDEV_DEBUG=3D1 -DRTE_LIBRTE_IPFRAG_TBL_STAT
-DRTE_LIBRTE_MEMPOOL_STATS -DRTE_LIBRTE_MEMPOOL_DEBUG -DRTE_DMADEV_DEBUG
-DRTE_EVENTDEV_DEBUG -DRTE_POWER_DEBUG -DRTE_TIMER_DEBUG -DRTE_VHOST_DEBUG
-DRTE_SCHED_DEBUG -DRTE_SORING_DEBUG -DRTE_MALLOC_DEBUG -DRTE_MBUF_DEBUG
-DRTE_MBUF_HISTORY_DEBUG -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_A=
PI
-DALLOW_INTERNAL_API -Wno-format-truncation
-DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.dmadev -MD -MQ
lib/librte_dmadev.a.p/dmadev_rte_dmadev_trace_points.c.o -MF
lib/librte_dmadev.a.p/dmadev_rte_dmadev_trace_points.c.o.d -o
lib/librte_dmadev.a.p/dmadev_rte_dmadev_trace_points.c.o -c
../lib/dmadev/rte_dmadev_trace_points.c
In file included from ../lib/dmadev/rte_dmadev_trace.h:16,
                 from ../lib/dmadev/rte_dmadev_trace_points.c:8:
../lib/dmadev/rte_dmadev.h: In function =E2=80=98rte_dma_copy=E2=80=99:
../lib/dmadev/rte_dmadev.h:1183:25: error: =E2=80=98EINVAL=E2=80=99 undecla=
red (first use in
this function)
 1183 |                 return -EINVAL;
      |                         ^~~~~~
../lib/dmadev/rte_dmadev.h:1183:25: note: each undeclared identifier is
reported only once for each function it appears in
../lib/dmadev/rte_dmadev.h:1185:25: error: =E2=80=98ENOTSUP=E2=80=99 undecl=
ared (first use in
this function)
 1185 |                 return -ENOTSUP;
      |                         ^~~~~~~
../lib/dmadev/rte_dmadev.h: In function =E2=80=98rte_dma_copy_sg=E2=80=99:
../lib/dmadev/rte_dmadev.h:1235:25: error: =E2=80=98EINVAL=E2=80=99 undecla=
red (first use in
this function)
 1235 |                 return -EINVAL;
      |                         ^~~~~~
../lib/dmadev/rte_dmadev.h:1237:25: error: =E2=80=98ENOTSUP=E2=80=99 undecl=
ared (first use in
this function)
 1237 |                 return -ENOTSUP;
      |                         ^~~~~~~
../lib/dmadev/rte_dmadev.h: In function =E2=80=98rte_dma_fill=E2=80=99:
../lib/dmadev/rte_dmadev.h:1282:25: error: =E2=80=98EINVAL=E2=80=99 undecla=
red (first use in
this function)
 1282 |                 return -EINVAL;
      |                         ^~~~~~
../lib/dmadev/rte_dmadev.h:1284:25: error: =E2=80=98ENOTSUP=E2=80=99 undecl=
ared (first use in
this function)
 1284 |                 return -ENOTSUP;
      |                         ^~~~~~~
../lib/dmadev/rte_dmadev.h: In function =E2=80=98rte_dma_submit=E2=80=99:
../lib/dmadev/rte_dmadev.h:1315:25: error: =E2=80=98EINVAL=E2=80=99 undecla=
red (first use in
this function)
 1315 |                 return -EINVAL;
      |                         ^~~~~~
../lib/dmadev/rte_dmadev.h:1317:25: error: =E2=80=98ENOTSUP=E2=80=99 undecl=
ared (first use in
this function)
 1317 |                 return -ENOTSUP;
      |                         ^~~~~~~
ninja: build stopped: subcommand failed.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
