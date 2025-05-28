Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0469BC3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 21:20:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32C4A40DFB;
	Wed, 28 May 2025 23:20:14 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2FD8C4003C
 for <dev@dpdk.org>; Wed, 28 May 2025 23:20:13 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 23D5846813; Wed, 28 May 2025 23:20:13 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1715] Enabling tracepoints in dpdk-test causes app
 to exit immediately without running any tests
Date: Wed, 28 May 2025 21:20:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: drc@linux.ibm.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1715-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17484672120.0062.3422140
Content-Transfer-Encoding: 7bit
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


--17484672120.0062.3422140
Date: Wed, 28 May 2025 23:20:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1715

            Bug ID: 1715
           Summary: Enabling tracepoints in dpdk-test causes app to exit
                    immediately without running any tests
           Product: DPDK
           Version: 25.03
          Hardware: POWER
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: drc@linux.ibm.com
  Target Milestone: ---

While attempting to create a custom tracepoint I discovered that enabling a=
ny
tracepoints in the dpdk-test app cause if to exit (exit code 255) without
running any tests.  Here's an example on a ppc64le system:


> $ ~/src/dpdk/build/app/test/dpdk-test -l 2-127 --no-pci --no-huge
> --trace=3Dlib.mempool.create
> EAL: Detected CPU lcores: 128
> EAL: Detected NUMA nodes: 2
> EAL: Static memory layout is selected, amount of reserved memory can be
> adjusted with -m or --socket-mem
> EAL: Detected static linkage of DPDK
> EAL: Multi-process socket /run/user/1000/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'VA'
> EAL: Trace dir: /home/drc/dpdk-traces/rte-2025-05-28-PM-05-10-59


The resulting trace looks like this:


> $ babeltrace2 ~/dpdk-traces/rte-2025-05-28-PM-05-10-59
> 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
> bt_lib_assert_cond_failed@lib/assert-cond.c:64 Babeltrace 2 library
> precondition not satisfied.
> 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
> bt_lib_assert_cond_failed@lib/assert-cond.c:65
> ------------------------------------------------------------------------
> 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
> bt_lib_assert_cond_failed@lib/assert-cond.c:66 Condition ID:
> `pre:message-packet-beginning-create-with-default-clock-snapshot:without-=
default-clock-snapshot`.
> 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
> bt_lib_assert_cond_failed@lib/assert-cond.c:68 Function:
> bt_message_packet_beginning_create_with_default_clock_snapshot().
> 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
> bt_lib_assert_cond_failed@lib/assert-cond.c:69
> ------------------------------------------------------------------------
> 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
> bt_lib_assert_cond_failed@lib/assert-cond.c:70 Error is:
> 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
> bt_lib_assert_cond_failed@lib/assert-cond.c:72 Unexpected stream class
> configuration when creating a packet beginning or end message: no default
> clock snapshot is needed, but one was provided: stream-addr=3D0x476bcfb0,
> stream-id=3D0,
> stream-name=3D"/home/drc/dpdk-traces/rte-2025-05-28-PM-05-10-59/channel0_=
0",
> stream-stream-class-addr=3D0x47aae210, stream-stream-class-id=3D0,
> stream-trace-class-addr=3D0x47aae0d0, stream-trace-addr=3D0x474f0800,
> stream-trace-name=3D"", stream-packet-pool-size=3D0, stream-packet-pool-c=
ap=3D0,
> sc-addr=3D0x47aae210, sc-id=3D0, sc-is-frozen=3D0, sc-event-class-count=
=3D532,
> sc-packet-context-fc-addr=3D0x47aae5b0, sc-event-common-context-fc-addr=
=3D(nil),
> sc-assigns-auto-ec-id=3D0, sc-assigns-auto-stream-id=3D0, sc-supports-pac=
kets=3D1,
> sc-packets-have-begin-default-cs=3D0, sc-packets-have-end-default-cs=3D0,
> sc-supports-discarded-events=3D0, sc-discarded-events-have-default-cs=3D0,
> sc-supports-discarded-packets=3D0, sc-discarded-packets-have-default-cs=
=3D0,
> sc-trace-class-addr=3D0x47aae0d0, sc-pcf-pool-size=3D0, sc-pcf-pool-cap=
=3D0,
> with-cs=3D1, cs-val=3D0
> 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
> bt_lib_assert_cond_failed@lib/assert-cond.c:75 Aborting...
[1]    484540 abort (core dumped)  babeltrace2
~/dpdk-traces/rte-2025-05-28-PM-05-10-59

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17484672120.0062.3422140
Date: Wed, 28 May 2025 23:20:12 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - Enabling tracepoints in dpdk-test causes app to e=
xit immediately without running any tests"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1715">1715</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Enabling tracepoints in dpdk-test causes app to exit immediat=
ely without running any tests
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.03
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>POWER
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
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
          <td>drc&#64;linux.ibm.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">While attempting to create a custo=
m tracepoint I discovered that enabling any
tracepoints in the dpdk-test app cause if to exit (exit code 255) without
running any tests.  Here's an example on a ppc64le system:


<span class=3D"quote">&gt; $ ~/src/dpdk/build/app/test/dpdk-test -l 2-127 -=
-no-pci --no-huge
&gt; --trace=3Dlib.mempool.create
&gt; EAL: Detected CPU lcores: 128
&gt; EAL: Detected NUMA nodes: 2
&gt; EAL: Static memory layout is selected, amount of reserved memory can be
&gt; adjusted with -m or --socket-mem
&gt; EAL: Detected static linkage of DPDK
&gt; EAL: Multi-process socket /run/user/1000/dpdk/rte/mp_socket
&gt; EAL: Selected IOVA mode 'VA'
&gt; EAL: Trace dir: /home/drc/dpdk-traces/rte-2025-05-28-PM-05-10-59</span=
 >


The resulting trace looks like this:


<span class=3D"quote">&gt; $ babeltrace2 ~/dpdk-traces/rte-2025-05-28-PM-05=
-10-59
&gt; 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
&gt; bt_lib_assert_cond_failed&#64;lib/assert-cond.c:64 Babeltrace 2 library
&gt; precondition not satisfied.
&gt; 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
&gt; bt_lib_assert_cond_failed&#64;lib/assert-cond.c:65
&gt; ----------------------------------------------------------------------=
--
&gt; 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
&gt; bt_lib_assert_cond_failed&#64;lib/assert-cond.c:66 Condition ID:
&gt; `pre:message-packet-beginning-create-with-default-clock-snapshot:witho=
ut-default-clock-snapshot`.
&gt; 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
&gt; bt_lib_assert_cond_failed&#64;lib/assert-cond.c:68 Function:
&gt; bt_message_packet_beginning_create_with_default_clock_snapshot().
&gt; 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
&gt; bt_lib_assert_cond_failed&#64;lib/assert-cond.c:69
&gt; ----------------------------------------------------------------------=
--
&gt; 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
&gt; bt_lib_assert_cond_failed&#64;lib/assert-cond.c:70 Error is:
&gt; 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
&gt; bt_lib_assert_cond_failed&#64;lib/assert-cond.c:72 Unexpected stream c=
lass
&gt; configuration when creating a packet beginning or end message: no defa=
ult
&gt; clock snapshot is needed, but one was provided: stream-addr=3D0x476bcf=
b0,
&gt; stream-id=3D0,
&gt; stream-name=3D&quot;/home/drc/dpdk-traces/rte-2025-05-28-PM-05-10-59/c=
hannel0_0&quot;,
&gt; stream-stream-class-addr=3D0x47aae210, stream-stream-class-id=3D0,
&gt; stream-trace-class-addr=3D0x47aae0d0, stream-trace-addr=3D0x474f0800,
&gt; stream-trace-name=3D&quot;&quot;, stream-packet-pool-size=3D0, stream-=
packet-pool-cap=3D0,
&gt; sc-addr=3D0x47aae210, sc-id=3D0, sc-is-frozen=3D0, sc-event-class-coun=
t=3D532,
&gt; sc-packet-context-fc-addr=3D0x47aae5b0, sc-event-common-context-fc-add=
r=3D(nil),
&gt; sc-assigns-auto-ec-id=3D0, sc-assigns-auto-stream-id=3D0, sc-supports-=
packets=3D1,
&gt; sc-packets-have-begin-default-cs=3D0, sc-packets-have-end-default-cs=
=3D0,
&gt; sc-supports-discarded-events=3D0, sc-discarded-events-have-default-cs=
=3D0,
&gt; sc-supports-discarded-packets=3D0, sc-discarded-packets-have-default-c=
s=3D0,
&gt; sc-trace-class-addr=3D0x47aae0d0, sc-pcf-pool-size=3D0, sc-pcf-pool-ca=
p=3D0,
&gt; with-cs=3D1, cs-val=3D0
&gt; 05-28 17:13:00.352 484540 484540 F LIB/ASSERT-COND
&gt; bt_lib_assert_cond_failed&#64;lib/assert-cond.c:75 Aborting...</span >
[1]    484540 abort (core dumped)  babeltrace2
~/dpdk-traces/rte-2025-05-28-PM-05-10-59
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
?id=3D1715">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17484672120.0062.3422140--
