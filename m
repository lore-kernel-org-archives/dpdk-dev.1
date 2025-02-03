Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38053C0218F
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 03:04:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 634C14060F;
	Mon,  3 Feb 2025 04:04:45 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CEAA5400EF
 for <dev@dpdk.org>; Mon,  3 Feb 2025 04:04:41 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C21B34617C; Mon,  3 Feb 2025 04:04:41 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: =?UTF-8?B?W0RQREsvZXhhbXBsZXMgQnVnIDE2MzddIEludGVswq4gUXVpY2tB?=
 =?UTF-8?B?c3Npc3QgVGVjaG5vbG9neSBzYW1wbGUgYXBwbGljYXRpb24gZG9lcyBub3Qg?=
 =?UTF-8?B?d29yayBvbiBhIDMyLWJpdCBPUyBvbiBTaHVtd2F5?=
Date: Mon, 03 Feb 2025 03:04:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nandinipersad361@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1637-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17385518810.deE8.2121660
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


--17385518810.deE8.2121660
Date: Mon, 3 Feb 2025 04:04:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1637

            Bug ID: 1637
           Summary: Intel=C2=AE QuickAssist Technology sample application d=
oes
                    not work on a 32-bit OS on Shumway
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: examples
          Assignee: dev@dpdk.org
          Reporter: nandinipersad361@gmail.com
  Target Milestone: ---

The Intel=C2=AE Communications Chipset 89xx Series device does not fully su=
pport
NUMA on a 32-bit OS. Consequently, the sample application cannot work prope=
rly
on Shumway, since it requires NUMA on both nodes.

Implication:
The sample application cannot work in 32-bit mode with emulated NUMA, on
multi-socket boards.

Resolution/Workaround:
There is no workaround available.

Affected Environment/Platform:
Shumway

Driver/Module:
All.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17385518810.deE8.2121660
Date: Mon, 3 Feb 2025 04:04:41 +0100
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
   title=3D"UNCONFIRMED - Intel=C2=AE QuickAssist Technology sample applica=
tion does not work on a 32-bit OS on Shumway"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1637">1637</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Intel=C2=AE QuickAssist Technology sample application does no=
t work on a 32-bit OS on Shumway
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
          <td>examples
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>nandinipersad361&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">The Intel=C2=AE Communications Chi=
pset 89xx Series device does not fully support
NUMA on a 32-bit OS. Consequently, the sample application cannot work prope=
rly
on Shumway, since it requires NUMA on both nodes.

Implication:
The sample application cannot work in 32-bit mode with emulated NUMA, on
multi-socket boards.

Resolution/Workaround:
There is no workaround available.

Affected Environment/Platform:
Shumway

Driver/Module:
All.
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
?id=3D1637">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17385518810.deE8.2121660--
