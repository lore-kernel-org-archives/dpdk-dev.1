Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C68C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 14:01:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB93540E0C;
	Tue,  4 Feb 2025 15:01:16 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id F008C40E0C
 for <dev@dpdk.org>; Tue,  4 Feb 2025 15:01:14 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E83C94618F; Tue,  4 Feb 2025 15:01:14 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1660] The softnic test suite should test more of the
 softnic vdev feature set
Date: Tue, 04 Feb 2025 14:01:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Luca.Vizzarro@arm.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 dependson target_milestone
Message-ID: <bug-1660-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17386776740.15826A.3182934
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


--17386776740.15826A.3182934
Date: Tue, 4 Feb 2025 15:01:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1660

            Bug ID: 1660
           Summary: The softnic test suite should test more of the softnic
                    vdev feature set
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: Luca.Vizzarro@arm.com
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
        Depends on: 1659
  Target Milestone: ---

The current softnic test suite only tests a basic scenario for forwarding. =
The
softnic doc page indicates multiple scenarios and more features:
https://doc.dpdk.org/guides/nics/softnic.html

This should be investigated as it may be a candidate for testing.


Referenced Bugs:

https://bugs.dpdk.org/show_bug.cgi?id=3D1659
[Bug 1659] Softnic should be implemented as a proper VirtualDevice
--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17386776740.15826A.3182934
Date: Tue, 4 Feb 2025 15:01:14 +0100
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
   title=3D"UNCONFIRMED - The softnic test suite should test more of the so=
ftnic vdev feature set"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1660">1660</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>The softnic test suite should test more of the softnic vdev f=
eature set
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
          <td>DTS
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>Luca.Vizzarro&#64;arm.com
          </td>
        </tr>

        <tr>
          <th>CC</th>
          <td>juraj.linkes&#64;pantheon.tech, probb&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>Depends on</th>
          <td>1659
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">The current softnic test suite onl=
y tests a basic scenario for forwarding. The
softnic doc page indicates multiple scenarios and more features:
<a href=3D"https://doc.dpdk.org/guides/nics/softnic.html">https://doc.dpdk.=
org/guides/nics/softnic.html</a>

This should be investigated as it may be a candidate for testing.
          </pre>
        </div>
      </p>

        <div id=3D"referenced">
          <hr style=3D"border: 1px dashed #969696">
          <b>Referenced Bugs:</b>
          <ul>
              <li>
                [<a class=3D"bz_bug_link           bz_status_UNCONFIRMED " =
  title=3D"UNCONFIRMED - Softnic should be implemented as a proper VirtualD=
evice"   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1659">Bug 1659</a>=
] Softnic should be implemented as a proper VirtualDevice
              </li>
          </ul>
        </div>
        <br>

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
?id=3D1660">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17386776740.15826A.3182934--
