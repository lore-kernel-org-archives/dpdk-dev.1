Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D8C0218A
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E578C40287;
	Mon,  3 Feb 2025 05:35:39 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2B7AF40264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:35:38 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1F9294617C; Mon,  3 Feb 2025 05:35:38 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1657] Unsuitable IOVA mode may be picked as the default
Date: Mon, 03 Feb 2025 04:35:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 18.11
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
Message-ID: <bug-1657-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17385573370.Bf7bb61.2171393
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


--17385573370.Bf7bb61.2171393
Date: Mon, 3 Feb 2025 05:35:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1657

            Bug ID: 1657
           Summary: Unsuitable IOVA mode may be picked as the default
           Product: DPDK
           Version: 18.11
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: nandinipersad361@gmail.com
  Target Milestone: ---

Not all kernel drivers and not all devices support all IOVA modes. EAL will
attempt to pick a reasonable default based on a number of factors, but there
may be cases where the default may be unsuitable (for example, hotplugging
devices using igb_uio driver while having picked IOVA as VA mode on EAL
initialization).

Implication
Some devices (hotplugged or otherwise) may not work due to incompatible IOVA
mode being automatically picked by EAL.

Resolution/Workaround:
It is possible to force EAL to pick a particular IOVA mode by using the
=E2=80=93iova-mode command-line parameter. If conflicting requirements are =
present
(such as one device requiring IOVA as PA and one requiring IOVA as VA mode),
there is no workaround.

Affected Environment/Platform:
Linux.

Driver/Module:
ALL.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17385573370.Bf7bb61.2171393
Date: Mon, 3 Feb 2025 05:35:37 +0100
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
   title=3D"UNCONFIRMED - Unsuitable IOVA mode may be picked as the default"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1657">1657</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Unsuitable IOVA mode may be picked as the default
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>18.11
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
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
          <pre class=3D"bz_comment_text">Not all kernel drivers and not all=
 devices support all IOVA modes. EAL will
attempt to pick a reasonable default based on a number of factors, but there
may be cases where the default may be unsuitable (for example, hotplugging
devices using igb_uio driver while having picked IOVA as VA mode on EAL
initialization).

Implication
Some devices (hotplugged or otherwise) may not work due to incompatible IOVA
mode being automatically picked by EAL.

Resolution/Workaround:
It is possible to force EAL to pick a particular IOVA mode by using the
=E2=80=93iova-mode command-line parameter. If conflicting requirements are =
present
(such as one device requiring IOVA as PA and one requiring IOVA as VA mode),
there is no workaround.

Affected Environment/Platform:
Linux.

Driver/Module:
ALL.
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
?id=3D1657">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17385573370.Bf7bb61.2171393--
