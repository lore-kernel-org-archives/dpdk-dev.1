Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052BBC0218A
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:29:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5330E40287;
	Mon,  3 Feb 2025 05:29:22 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B7AD240264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:29:20 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B1DA04617C; Mon,  3 Feb 2025 05:29:20 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1653] PHY link up fails when rebinding i40e NICs to
 kernel driver
Date: Mon, 03 Feb 2025 04:29:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
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
Message-ID: <bug-1653-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17385569600.785504.2168410
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


--17385569600.785504.2168410
Date: Mon, 3 Feb 2025 05:29:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1653

            Bug ID: 1653
           Summary: PHY link up fails when rebinding i40e NICs to kernel
                    driver
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: nandinipersad361@gmail.com
  Target Milestone: ---

Some kernel drivers are not able to handle the link status correctly after =
DPDK
application sets the PHY to link down.

Implication:
The link status can=E2=80=99t be set to =E2=80=9Cup=E2=80=9D after the NIC =
is rebound to the kernel
driver. Before a DPDK application quits it will invoke the function
i40e_dev_stop() which will sets the PHY to link down. Some kernel drivers m=
ay
not be able to handle the link status correctly after it retakes control of=
 the
device. This is a known PHY link configuration issue in the i40e kernel dri=
ver.
The fix has been addressed in the 2.7.4 rc version. So if the i40e kernel
driver is < 2.7.4 and doesn=E2=80=99t have the fix backported it will encou=
nter this
issue.

Resolution/Workaround:
First try to remove and reinsert the i40e kernel driver. If that fails rebo=
ot
the system.

Affected Environment/Platform:
All.

Driver/Module:
Poll Mode Driver (PMD).

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17385569600.785504.2168410
Date: Mon, 3 Feb 2025 05:29:20 +0100
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
   title=3D"UNCONFIRMED - PHY link up fails when rebinding i40e NICs to ker=
nel driver"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1653">1653</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>PHY link up fails when rebinding i40e NICs to kernel driver
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
          <td>ethdev
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
          <pre class=3D"bz_comment_text">Some kernel drivers are not able t=
o handle the link status correctly after DPDK
application sets the PHY to link down.

Implication:
The link status can=E2=80=99t be set to =E2=80=9Cup=E2=80=9D after the NIC =
is rebound to the kernel
driver. Before a DPDK application quits it will invoke the function
i40e_dev_stop() which will sets the PHY to link down. Some kernel drivers m=
ay
not be able to handle the link status correctly after it retakes control of=
 the
device. This is a known PHY link configuration issue in the i40e kernel dri=
ver.
The fix has been addressed in the 2.7.4 rc version. So if the i40e kernel
driver is &lt; 2.7.4 and doesn=E2=80=99t have the fix backported it will en=
counter this
issue.

Resolution/Workaround:
First try to remove and reinsert the i40e kernel driver. If that fails rebo=
ot
the system.

Affected Environment/Platform:
All.

Driver/Module:
Poll Mode Driver (PMD).
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
?id=3D1653">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17385569600.785504.2168410--
