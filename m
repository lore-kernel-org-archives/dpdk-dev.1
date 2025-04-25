Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E6C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 22:47:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A73F4026A;
	Sat, 26 Apr 2025 00:47:30 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6A7534025E
 for <dev@dpdk.org>; Sat, 26 Apr 2025 00:47:29 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4DA0046637; Sat, 26 Apr 2025 00:47:29 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1700] BPF callback wait is not MP safe
Date: Fri, 25 Apr 2025 22:47:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
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
Message-ID: <bug-1700-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17456212490.aC61FB9c2.1307451
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


--17456212490.aC61FB9c2.1307451
Date: Sat, 26 Apr 2025 00:47:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1700

            Bug ID: 1700
           Summary: BPF callback wait is not MP safe
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The mechanism implemented in bpf_pkt.c is like an open coded version of
seqlock.
There is an inherit race because:

If the CPU running the callback doesn't reach the before the count
is executed, it can rance with the CPU doing destroy.

CPU 1:                                CPU 2:
bpf_eth_unload()
    bc =3D bpf_eth_cbh_find()
                                      bpf_rx_callback_vm (or
bpf_rx_callback_jit)
    rte_eth_remove_rx_callback()
    bpf_eth_cbi_unload(bc)
        bpf_eth_cbi_wait(bc)

at this point bc->inuse =3D=3D 0 because call back not started
but is going to be used by CPU 2. And calling rte_bpf_destroy
will lead to use after free.

There is no good way to fix this without using RCU.

Also, the code should be consistently using C11 atomic not barriers.
Not sure if anyone ever uses this code anyway!

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17456212490.aC61FB9c2.1307451
Date: Sat, 26 Apr 2025 00:47:29 +0200
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
   title=3D"UNCONFIRMED - BPF callback wait is not MP safe"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1700">1700</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>BPF callback wait is not MP safe
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
          <td>minor
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
          <pre class=3D"bz_comment_text">The mechanism implemented in bpf_p=
kt.c is like an open coded version of
seqlock.
There is an inherit race because:

If the CPU running the callback doesn't reach the before the count
is executed, it can rance with the CPU doing destroy.

CPU 1:                                CPU 2:
bpf_eth_unload()
    bc =3D bpf_eth_cbh_find()
                                      bpf_rx_callback_vm (or
bpf_rx_callback_jit)
    rte_eth_remove_rx_callback()
    bpf_eth_cbi_unload(bc)
        bpf_eth_cbi_wait(bc)

at this point bc-&gt;inuse =3D=3D 0 because call back not started
but is going to be used by CPU 2. And calling rte_bpf_destroy
will lead to use after free.

There is no good way to fix this without using RCU.

Also, the code should be consistently using C11 atomic not barriers.
Not sure if anyone ever uses this code anyway!
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
?id=3D1700">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17456212490.aC61FB9c2.1307451--
