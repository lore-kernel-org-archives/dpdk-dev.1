Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D43C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 11:12:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3D3A4060B;
	Fri, 27 Jun 2025 13:12:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D501A4026B
 for <dev@dpdk.org>; Fri, 27 Jun 2025 13:12:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B850C46A73; Fri, 27 Jun 2025 13:12:31 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1733] Clarification Requested: Port Down Behavior
 When Trust Mode is Disabled in IAVF Driver
Date: Fri, 27 Jun 2025 11:12:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: gownivalla.susmitha@wipro.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1733-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17510227510.FdbBAc64.949921
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


--17510227510.FdbBAc64.949921
Date: Fri, 27 Jun 2025 13:12:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1733

            Bug ID: 1733
           Summary: Clarification Requested: Port Down Behavior When Trust
                    Mode is Disabled in IAVF Driver
           Product: DPDK
           Version: 24.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: gownivalla.susmitha@wipro.com
  Target Milestone: ---

Hello DPDK Community,

I am currently working with the Intel IAVF driver in a DPDK environment and
have observed that when trust mode is set to off on a Virtual Function (VF),
the corresponding port goes down.

Despite reviewing available documentation and recent DPDK commits, I have n=
ot
found any official references explaining whether this behavior is:

    1. An intended feature related to security or resource management,
    2. A known limitation or side effect when disabling trust mode, or
    3. A bug that may be addressed in future releases.

Additionally, I have looked for changes or bug reports related to the funct=
ion
iavf_dev_alarm_handler or port link state management triggered by trust mode
changes but could not find relevant details.

Could anyone from the community or the DPDK development team please clarify:

    1. Is the port going down when trust mode is disabled a documented and
expected behavior? If so, is there an official reference or documentation
available?
    2. Are there any workarounds or best practices recommended when using t=
rust
mode in production environments?
    3. If this is a known issue or bug, is there a timeline for a fix?

Any insights or pointers to relevant code changes, documentation, or
discussions would be greatly appreciated.

Thank you in advance for your help!

Regards,
Susmitha

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17510227510.FdbBAc64.949921
Date: Fri, 27 Jun 2025 13:12:31 +0200
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
   title=3D"UNCONFIRMED - Clarification Requested: Port Down Behavior When =
Trust Mode is Disabled in IAVF Driver"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1733">1733</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Clarification Requested: Port Down Behavior When Trust Mode i=
s Disabled in IAVF Driver
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
          <td>x86
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
          <td>major
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
          <td>gownivalla.susmitha&#64;wipro.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hello DPDK Community,

I am currently working with the Intel IAVF driver in a DPDK environment and
have observed that when trust mode is set to off on a Virtual Function (VF),
the corresponding port goes down.

Despite reviewing available documentation and recent DPDK commits, I have n=
ot
found any official references explaining whether this behavior is:

    1. An intended feature related to security or resource management,
    2. A known limitation or side effect when disabling trust mode, or
    3. A bug that may be addressed in future releases.

Additionally, I have looked for changes or bug reports related to the funct=
ion
iavf_dev_alarm_handler or port link state management triggered by trust mode
changes but could not find relevant details.

Could anyone from the community or the DPDK development team please clarify:

    1. Is the port going down when trust mode is disabled a documented and
expected behavior? If so, is there an official reference or documentation
available?
    2. Are there any workarounds or best practices recommended when using t=
rust
mode in production environments?
    3. If this is a known issue or bug, is there a timeline for a fix?

Any insights or pointers to relevant code changes, documentation, or
discussions would be greatly appreciated.

Thank you in advance for your help!

Regards,
Susmitha
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
?id=3D1733">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17510227510.FdbBAc64.949921--
