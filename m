Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38158CCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71C6740430;
	Mon, 19 Oct 2026 15:36:40 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id EA0D240297
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:36:39 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C56A64D373; Mon, 19 Oct 2026 15:36:39 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2061] [Debug][aarch64] test_stack_perf fails to build
 with GCC 13 due to memcpy overread/overflow warning
Date: Mon, 19 Oct 2026 13:36:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alialnu@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2061-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2061

            Bug ID: 2061
           Summary: [Debug][aarch64] test_stack_perf fails to build with
                    GCC 13 due to memcpy overread/overflow warning
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: alialnu@nvidia.com
  Target Milestone: ---

$ meson --werror --buildtype=3Ddebug build && ninja -C build

[..]
[3428/3451] Compiling C object app/dpdk-test.p/test_test_tailq.c.o
[3429/3451] Compiling C object
app/dpdk-test.p/test_test_security_inline_macsec.c.o
[3430/3451] Compiling C object app/dpdk-test.p/test_test_stack_perf.c.o
FAILED: app/dpdk-test.p/test_test_stack_perf.c.o=20
[..]
In file included from ../../root/dpdk/lib/eal/arm/include/rte_memcpy.h:9,
                 from ../../root/dpdk/lib/stack/rte_stack_pile.h:8,
                 from ../../root/dpdk/lib/stack/rte_stack.h:152,
                 from ../../root/dpdk/app/test/test_stack_perf.c:12:
In function '__rte_stack_pile_push',
    inlined from 'rte_stack_push' at
../../root/dpdk/lib/stack/rte_stack.h:179:10,
    inlined from 'test_single_push_pop' at
../../root/dpdk/app/test/test_stack_perf.c:261:3:
../../root/dpdk/lib/eal/arm/include/rte_memcpy_64.h:365:33: error: 'memcpy'
reading 256 bytes from a region of size 8 [-Werror=3Dstringop-overread]
  365 | #define rte_memcpy(d, s, n)     memcpy((d), (s), (n))
      |                                 ^~~~~~~~~~~~~~~~~~~~~
../../root/dpdk/lib/stack/rte_stack_pile.h:160:17: note: in expansion of ma=
cro
'rte_memcpy'
  160 |                 rte_memcpy(((struct rte_stack_pile_bulk_elem
*)tmp)->objs,
      |                 ^~~~~~~~~~
../../root/dpdk/app/test/test_stack_perf.c: In function 'test_single_push_p=
op':
../../root/dpdk/app/test/test_stack_perf.c:255:15: note: source object 'obj=
' of
size 8
  255 |         void *obj =3D NULL;
      |               ^~~
In function '__rte_stack_pile_bulk_pop_elems',
    inlined from '__rte_stack_pile_pop' at
../../root/dpdk/lib/stack/rte_stack_pile.h:274:15,
    inlined from 'rte_stack_pop' at
../../root/dpdk/lib/stack/rte_stack.h:205:10,
    inlined from 'test_single_push_pop' at
../../root/dpdk/app/test/test_stack_perf.c:262:3:
../../root/dpdk/lib/eal/arm/include/rte_memcpy_64.h:365:33: error: 'memcpy'
writing 256 bytes into a region of size 8 overflows the destination
[-Werror=3Dstringop-overflow=3D]
  365 | #define rte_memcpy(d, s, n)     memcpy((d), (s), (n))
      |                                 ^~~~~~~~~~~~~~~~~~~~~
../../root/dpdk/lib/stack/rte_stack_pile.h:75:25: note: in expansion of mac=
ro
'rte_memcpy'
   75 |                         rte_memcpy(&obj_table[i *
RTE_STACK_PILE_BULK_SIZE],
      |                         ^~~~~~~~~~
../../root/dpdk/app/test/test_stack_perf.c: In function 'test_single_push_p=
op':
../../root/dpdk/app/test/test_stack_perf.c:255:15: note: destination object
'obj' of size 8
  255 |         void *obj =3D NULL;
      |               ^~~
cc1: all warnings being treated as errors
[..]
ninja: build stopped: subcommand failed.

git-bisect points to ee0822a0ef41 ("stack: introduce pile")

Meson: 1.3.2
OS: Ubuntu 24.04.4 LTS
Compiler: gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0

--=20
You are receiving this mail because:
You are the assignee for the bug.=
