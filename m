Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903F3CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 20:42:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85295402BD;
	Thu, 21 Aug 2025 22:42:35 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id A3FA4402B1
 for <dev@dpdk.org>; Thu, 21 Aug 2025 22:42:33 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9653546D8E; Thu, 21 Aug 2025 22:42:33 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1781] Output buffer errors during testpmd execution
Date: Thu, 21 Aug 2025 20:42:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dmarx@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1781-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17558089530.Ed5300.2398552
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


--17558089530.Ed5300.2398552
Date: Thu, 21 Aug 2025 22:42:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1781

            Bug ID: 1781
           Summary: Output buffer errors during testpmd execution
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: dmarx@iol.unh.edu
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
  Target Milestone: ---

In some of the checksum_offload output logs, there are errors where the out=
put
buffer is expected to contain "testpmd>", but instead it gets filled with s=
sh
connection details from stdout:

TimeoutError
2025/08/21 05:22:47 - test_case - dts.dell-r6515-2-cx5.TestPmdShell - DEBUG=
 -
Prompt (testpmd>) was not found in output from command before timeout.
2025/08/21 05:22:47 - test_case - dts.dell-r6515-2-cx5.TestPmdShell - DEBUG=
 -
Got output: Last login: Thu Aug 21 05:22:25 2025 from 172.18.0.58

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17558089530.Ed5300.2398552
Date: Thu, 21 Aug 2025 22:42:33 +0200
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
   title=3D"UNCONFIRMED - Output buffer errors during testpmd execution"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1781">1781</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Output buffer errors during testpmd execution
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
          <td>dmarx&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>CC</th>
          <td>juraj.linkes&#64;pantheon.tech, probb&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">In some of the checksum_offload ou=
tput logs, there are errors where the output
buffer is expected to contain &quot;testpmd&gt;&quot;, but instead it gets =
filled with ssh
connection details from stdout:

TimeoutError
2025/08/21 05:22:47 - test_case - dts.dell-r6515-2-cx5.TestPmdShell - DEBUG=
 -
Prompt (testpmd&gt;) was not found in output from command before timeout.
2025/08/21 05:22:47 - test_case - dts.dell-r6515-2-cx5.TestPmdShell - DEBUG=
 -
Got output: Last login: Thu Aug 21 05:22:25 2025 from 172.18.0.58
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
?id=3D1781">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17558089530.Ed5300.2398552--
