Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A19CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 16:24:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08C3240647;
	Fri, 29 Aug 2025 18:24:23 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 11A6640616
 for <dev@dpdk.org>; Fri, 29 Aug 2025 18:24:22 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id DF8BF46DFF; Fri, 29 Aug 2025 18:24:21 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1783] crash in rollback_expand_heap
Date: Fri, 29 Aug 2025 16:24:21 +0000
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
Message-ID: <bug-1783-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17564846610.a9bF.1330237
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


--17564846610.a9bF.1330237
Date: Fri, 29 Aug 2025 18:24:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1783

            Bug ID: 1783
           Summary: crash in rollback_expand_heap
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

We are observing a crash in rollback_expand_heap(). Below is the backtrace

Program terminated with signal 11, Segmentation fault.
#0  0x000000000088ebc4 in malloc_elem_init (elem=3Delem@entry=3D0x310024a00=
000,
heap=3D0x30ffffffdac0, msl=3D0x30ffffff9090,
    size=3D18446744073709510528, orig_elem=3D0x310024600000, orig_size=3D20=
97152,
dirty=3Dfalse)
    at ../esbc_gnu_src/lib/eal/common/malloc_elem.c:128
128     ../esbc_gnu_src/lib/eal/common/malloc_elem.c: No such file or
directory.
(gdb) bt
#0  0x000000000088ebc4 in malloc_elem_init (elem=3Delem@entry=3D0x310024a00=
000,
heap=3D0x30ffffffdac0, msl=3D0x30ffffff9090,
    size=3D18446744073709510528, orig_elem=3D0x310024600000, orig_size=3D20=
97152,
dirty=3Dfalse)
    at ../esbc_gnu_src/lib/eal/common/malloc_elem.c:128
#1  0x000000000088ec6b in split_elem (elem=3Delem@entry=3D0x310024600000,
split_pt=3Dsplit_pt@entry=3D0x310024a00000)
    at ../esbc_gnu_src/lib/eal/common/malloc_elem.c:297
#2  0x000000000088f2db in malloc_elem_hide_region () at
../esbc_gnu_src/lib/eal/common/malloc_elem.c:627
#3  0x000000000088fb6b in rollback_expand_heap (ms=3D0x2a5e278, n_segs=3D1,
elem=3D0x310024600000, map_addr=3D0x310024800000,
    map_len=3D2097152) at ../esbc_gnu_src/lib/eal/common/malloc_heap.c:285
#4  0x000000000089145b in handle_sync_response () at
../esbc_gnu_src/lib/eal/common/malloc_mp.c:506
#5  0x0000000000888110 in trigger_async_action (sr=3D0x13c7e400) at
../esbc_gnu_src/lib/eal/common/eal_common_proc.c:504
#6  0x0000000000898763 in eal_alarm_callback (arg=3D<optimized out>) at
../esbc_gnu_src/lib/eal/linux/eal_alarm.c:105
#7  0x000000000089ad5c in eal_intr_process_interrupts (nfds=3D<optimized ou=
t>,
events=3D<optimized out>)
    at ../esbc_gnu_src/lib/eal/linux/eal_interrupts.c:1017
#8  eal_intr_handle_interrupts (totalfds=3D<optimized out>, pfd=3D18) at
../esbc_gnu_src/lib/eal/linux/eal_interrupts.c:1091
#9  eal_intr_thread_main () at
../esbc_gnu_src/lib/eal/linux/eal_interrupts.c:1163

can you let us know if this is an know issue?

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17564846610.a9bF.1330237
Date: Fri, 29 Aug 2025 18:24:21 +0200
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
   title=3D"UNCONFIRMED - crash in rollback_expand_heap"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1783">1783</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>crash in rollback_expand_heap
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

We are observing a crash in rollback_expand_heap(). Below is the backtrace

Program terminated with signal 11, Segmentation fault.
#0  0x000000000088ebc4 in malloc_elem_init (elem=3Delem&#64;entry=3D0x31002=
4a00000,
heap=3D0x30ffffffdac0, msl=3D0x30ffffff9090,
    size=3D18446744073709510528, orig_elem=3D0x310024600000, orig_size=3D20=
97152,
dirty=3Dfalse)
    at ../esbc_gnu_src/lib/eal/common/malloc_elem.c:128
128     ../esbc_gnu_src/lib/eal/common/malloc_elem.c: No such file or
directory.
(gdb) bt
#0  0x000000000088ebc4 in malloc_elem_init (elem=3Delem&#64;entry=3D0x31002=
4a00000,
heap=3D0x30ffffffdac0, msl=3D0x30ffffff9090,
    size=3D18446744073709510528, orig_elem=3D0x310024600000, orig_size=3D20=
97152,
dirty=3Dfalse)
    at ../esbc_gnu_src/lib/eal/common/malloc_elem.c:128
#1  0x000000000088ec6b in split_elem (elem=3Delem&#64;entry=3D0x31002460000=
0,
split_pt=3Dsplit_pt&#64;entry=3D0x310024a00000)
    at ../esbc_gnu_src/lib/eal/common/malloc_elem.c:297
#2  0x000000000088f2db in malloc_elem_hide_region () at
../esbc_gnu_src/lib/eal/common/malloc_elem.c:627
#3  0x000000000088fb6b in rollback_expand_heap (ms=3D0x2a5e278, n_segs=3D1,
elem=3D0x310024600000, map_addr=3D0x310024800000,
    map_len=3D2097152) at ../esbc_gnu_src/lib/eal/common/malloc_heap.c:285
#4  0x000000000089145b in handle_sync_response () at
../esbc_gnu_src/lib/eal/common/malloc_mp.c:506
#5  0x0000000000888110 in trigger_async_action (sr=3D0x13c7e400) at
../esbc_gnu_src/lib/eal/common/eal_common_proc.c:504
#6  0x0000000000898763 in eal_alarm_callback (arg=3D&lt;optimized out&gt;) =
at
../esbc_gnu_src/lib/eal/linux/eal_alarm.c:105
#7  0x000000000089ad5c in eal_intr_process_interrupts (nfds=3D&lt;optimized=
 out&gt;,
events=3D&lt;optimized out&gt;)
    at ../esbc_gnu_src/lib/eal/linux/eal_interrupts.c:1017
#8  eal_intr_handle_interrupts (totalfds=3D&lt;optimized out&gt;, pfd=3D18)=
 at
../esbc_gnu_src/lib/eal/linux/eal_interrupts.c:1091
#9  eal_intr_thread_main () at
../esbc_gnu_src/lib/eal/linux/eal_interrupts.c:1163

can you let us know if this is an know issue?
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
?id=3D1783">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17564846610.a9bF.1330237--
