Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C1FCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:39:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD16C402DC;
	Mon,  1 Sep 2025 09:39:05 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B01694028B
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:39:04 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9BECF46E38; Mon,  1 Sep 2025 09:39:04 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1784] crash is seen while reserving the memory in
 rte_memzone_reserve
Date: Mon, 01 Sep 2025 07:39:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: malve.vinay.kumar@oracle.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1784-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17567123440.aE0dFd.346105
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


--17567123440.aE0dFd.346105
Date: Mon, 1 Sep 2025 09:39:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1784

            Bug ID: 1784
           Summary: crash is seen while reserving the memory in
                    rte_memzone_reserve
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: malve.vinay.kumar@oracle.com
  Target Milestone: ---

Hi,
While the application is reserving the memory for the stats table, we see a
crash.
Below is the BT

Program terminated with signal 11, Segmentation fault.
#0  0x0000000002b35f81 in elem_start_pt (elem=3Delem@entry=3D0x311032000000,
size=3Dsize@entry=3D34754368, align=3Dalign@entry=3D64,
    bound=3Dbound@entry=3D0, contig=3Dcontig@entry=3Dfalse) at
../esbc_gnu_src/lib/eal/common/malloc_elem.c:222
222     ../esbc_gnu_src/lib/eal/common/malloc_elem.c: No such file or
directory.
(gdb) bt
#0  0x0000000002b35f81 in elem_start_pt (elem=3Delem@entry=3D0x311032000000,
size=3Dsize@entry=3D34754368, align=3Dalign@entry=3D64,
    bound=3Dbound@entry=3D0, contig=3Dcontig@entry=3Dfalse) at
../esbc_gnu_src/lib/eal/common/malloc_elem.c:222
#1  0x0000000002b363cd in malloc_elem_can_hold (elem=3Delem@entry=3D0x31103=
2000000,
size=3Dsize@entry=3D34754368,
    align=3Dalign@entry=3D64, bound=3Dbound@entry=3D0, contig=3Dcontig@entr=
y=3Dfalse) at
../esbc_gnu_src/lib/eal/common/malloc_elem.c:283
#2  0x0000000002b36c7b in find_suitable_element
(heap=3Dheap@entry=3D0x30ffffffdb80, size=3Dsize@entry=3D34754368,
    flags=3Dflags@entry=3D0, align=3Dalign@entry=3D64, bound=3Dbound@entry=
=3D0,
contig=3Dcontig@entry=3Dfalse)
    at ../esbc_gnu_src/lib/eal/common/malloc_heap.c:160
#3  0x0000000002b36d2f in heap_alloc (heap=3Dheap@entry=3D0x30ffffffdb80,
size=3Dsize@entry=3D34754368, flags=3Dflags@entry=3D0,
    align=3Dalign@entry=3D64, bound=3Dbound@entry=3D0, contig=3Dcontig@entr=
y=3Dfalse) at
../esbc_gnu_src/lib/eal/common/malloc_heap.c:244
#4  0x0000000002b37950 in malloc_heap_alloc_on_heap_id () at
../esbc_gnu_src/lib/eal/common/malloc_heap.c:680
#5  0x0000000002b37abb in malloc_heap_alloc (size=3Dsize@entry=3D34754368,
socket_arg=3D<optimized out>, flags=3Dflags@entry=3D0,
    align=3Dalign@entry=3D64, bound=3Dbound@entry=3D0, contig=3D<optimized =
out>) at
../esbc_gnu_src/lib/eal/common/malloc_heap.c:755
#6  0x0000000002b2bef2 in memzone_reserve_aligned_thread_unsafe (bound=3D0,
align=3D64, flags=3D0, socket_id=3D<optimized out>,
    len=3D34754368, name=3D0x4320efc4 "UsdpStatsTable/21") at
../esbc_gnu_src/lib/eal/common/eal_common_memzone.c:205
#7  rte_memzone_reserve_thread_safe () at
../esbc_gnu_src/lib/eal/common/eal_common_memzone.c:256
#8  0x0000000002b2c15e in rte_memzone_reserve (name=3Dname@entry=3D0x4320ef=
c4
"UsdpStatsTable/21", len=3Dlen@entry=3D34754352,
    socket_id=3D<optimized out>, flags=3Dflags@entry=3D0) at
../esbc_gnu_src/lib/eal/common/eal_common_memzone.c:300


Thanks,
Vinay.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17567123440.aE0dFd.346105
Date: Mon, 1 Sep 2025 09:39:04 +0200
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
   title=3D"UNCONFIRMED - crash is seen while reserving the memory in rte_m=
emzone_reserve"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1784">1784</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>crash is seen while reserving the memory in rte_memzone_reser=
ve
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.11
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
          <td>core
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>malve.vinay.kumar&#64;oracle.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hi,
While the application is reserving the memory for the stats table, we see a
crash.
Below is the BT

Program terminated with signal 11, Segmentation fault.
#0  0x0000000002b35f81 in elem_start_pt (elem=3Delem&#64;entry=3D0x31103200=
0000,
size=3Dsize&#64;entry=3D34754368, align=3Dalign&#64;entry=3D64,
    bound=3Dbound&#64;entry=3D0, contig=3Dcontig&#64;entry=3Dfalse) at
../esbc_gnu_src/lib/eal/common/malloc_elem.c:222
222     ../esbc_gnu_src/lib/eal/common/malloc_elem.c: No such file or
directory.
(gdb) bt
#0  0x0000000002b35f81 in elem_start_pt (elem=3Delem&#64;entry=3D0x31103200=
0000,
size=3Dsize&#64;entry=3D34754368, align=3Dalign&#64;entry=3D64,
    bound=3Dbound&#64;entry=3D0, contig=3Dcontig&#64;entry=3Dfalse) at
../esbc_gnu_src/lib/eal/common/malloc_elem.c:222
#1  0x0000000002b363cd in malloc_elem_can_hold (elem=3Delem&#64;entry=3D0x3=
11032000000,
size=3Dsize&#64;entry=3D34754368,
    align=3Dalign&#64;entry=3D64, bound=3Dbound&#64;entry=3D0, contig=3Dcon=
tig&#64;entry=3Dfalse) at
../esbc_gnu_src/lib/eal/common/malloc_elem.c:283
#2  0x0000000002b36c7b in find_suitable_element
(heap=3Dheap&#64;entry=3D0x30ffffffdb80, size=3Dsize&#64;entry=3D34754368,
    flags=3Dflags&#64;entry=3D0, align=3Dalign&#64;entry=3D64, bound=3Dboun=
d&#64;entry=3D0,
contig=3Dcontig&#64;entry=3Dfalse)
    at ../esbc_gnu_src/lib/eal/common/malloc_heap.c:160
#3  0x0000000002b36d2f in heap_alloc (heap=3Dheap&#64;entry=3D0x30ffffffdb8=
0,
size=3Dsize&#64;entry=3D34754368, flags=3Dflags&#64;entry=3D0,
    align=3Dalign&#64;entry=3D64, bound=3Dbound&#64;entry=3D0, contig=3Dcon=
tig&#64;entry=3Dfalse) at
../esbc_gnu_src/lib/eal/common/malloc_heap.c:244
#4  0x0000000002b37950 in malloc_heap_alloc_on_heap_id () at
../esbc_gnu_src/lib/eal/common/malloc_heap.c:680
#5  0x0000000002b37abb in malloc_heap_alloc (size=3Dsize&#64;entry=3D347543=
68,
socket_arg=3D&lt;optimized out&gt;, flags=3Dflags&#64;entry=3D0,
    align=3Dalign&#64;entry=3D64, bound=3Dbound&#64;entry=3D0, contig=3D&lt=
;optimized out&gt;) at
../esbc_gnu_src/lib/eal/common/malloc_heap.c:755
#6  0x0000000002b2bef2 in memzone_reserve_aligned_thread_unsafe (bound=3D0,
align=3D64, flags=3D0, socket_id=3D&lt;optimized out&gt;,
    len=3D34754368, name=3D0x4320efc4 &quot;UsdpStatsTable/21&quot;) at
../esbc_gnu_src/lib/eal/common/eal_common_memzone.c:205
#7  rte_memzone_reserve_thread_safe () at
../esbc_gnu_src/lib/eal/common/eal_common_memzone.c:256
#8  0x0000000002b2c15e in rte_memzone_reserve (name=3Dname&#64;entry=3D0x43=
20efc4
&quot;UsdpStatsTable/21&quot;, len=3Dlen&#64;entry=3D34754352,
    socket_id=3D&lt;optimized out&gt;, flags=3Dflags&#64;entry=3D0) at
../esbc_gnu_src/lib/eal/common/eal_common_memzone.c:300


Thanks,
Vinay.
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
?id=3D1784">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17567123440.aE0dFd.346105--
