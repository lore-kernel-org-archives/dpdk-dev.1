Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CB1C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 23:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1236A4028D;
	Wed, 18 Jun 2025 01:06:52 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0A48740279
 for <dev@dpdk.org>; Wed, 18 Jun 2025 01:06:51 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id F264E469E0; Wed, 18 Jun 2025 01:06:50 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1726] possible overrun bugs in soring found with LTO
Date: Tue, 17 Jun 2025 23:06:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: unspecified
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
Message-ID: <bug-1726-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17502016100.6E3ba9Fe.2594744
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


--17502016100.6E3ba9Fe.2594744
Date: Wed, 18 Jun 2025 01:06:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1726

            Bug ID: 1726
           Summary: possible overrun bugs in soring found with LTO
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Enabling LTO in build allows compiler to detect more bugs such as out of bo=
unds
references inside libraries. Several warnings in soring

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
      |

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17502016100.6E3ba9Fe.2594744
Date: Wed, 18 Jun 2025 01:06:50 +0200
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
   title=3D"UNCONFIRMED - possible overrun bugs in soring found with LTO"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1726">1726</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>possible overrun bugs in soring found with LTO
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
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
          <td>other
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Enabling LTO in build allows compi=
ler to detect more bugs such as out of bounds
references inside libraries. Several warnings in soring

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
      |
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
?id=3D1726">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17502016100.6E3ba9Fe.2594744--
