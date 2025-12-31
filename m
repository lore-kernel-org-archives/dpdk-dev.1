Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C92BEEB565
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 18:25:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 799A2402A0;
	Wed, 31 Dec 2025 19:25:36 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CB0B340267
 for <dev@dpdk.org>; Wed, 31 Dec 2025 19:25:34 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AF3CC4714B; Wed, 31 Dec 2025 19:25:34 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1864] soring: build errors with LTO
Date: Wed, 31 Dec 2025 18:25:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.11
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
Message-ID: <bug-1864-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1864

            Bug ID: 1864
           Summary: soring: build errors with LTO
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Doing release build type with LTO causes more inlining which detects more
errors.

In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 128 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 160 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 192 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 224 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 256 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 288 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 320 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 352 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 384 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 416 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 448 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:279:3,
    inlined from =E2=80=98soring_dequeue=E2=80=99 at ../lib/ring/soring.c:3=
15:3,
    inlined from =E2=80=98rte_soring_dequeue_bulk=E2=80=99 at ../lib/ring/s=
oring.c:552:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:181:14:
../lib/ring/rte_ring_elem_pvt.h:250:25: warning: writing 32 bytes into a re=
gion
of size 0 [-Wstringop-overflow=3D]
  250 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:157:18: note: at offset 480 into destination obje=
ct
=E2=80=98dequeued_objs=E2=80=99 of size 128
  157 |         uint32_t dequeued_objs[32];

--=20
You are receiving this mail because:
You are the assignee for the bug.=
