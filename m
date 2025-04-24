Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A9C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 09:46:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F226840156;
	Thu, 24 Apr 2025 11:46:04 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AEF7D400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 11:46:03 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8392A4661D; Thu, 24 Apr 2025 11:46:03 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/examples Bug 1698] rte_eth_rx_burst causes segmentation fault
 when encountered in a Secondary process
Date: Thu, 24 Apr 2025 09:46:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: reuben.koshy@vvdntech.in
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1698-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17454879630.73FcBe.3987226
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


--17454879630.73FcBe.3987226
Date: Thu, 24 Apr 2025 11:46:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1698

            Bug ID: 1698
           Summary: rte_eth_rx_burst causes segmentation fault when
                    encountered in a Secondary process
           Product: DPDK
           Version: 23.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: examples
          Assignee: dev@dpdk.org
          Reporter: reuben.koshy@vvdntech.in
  Target Milestone: ---

Created attachment 311
  --> https://bugs.dpdk.org/attachment.cgi?id=3D311&action=3Dedit
This is the screenshot of the log that appears when the secondary process=20
tries to execute tx_burst

I took a copy of the simple_mp main program from multi_process within the D=
PDK
examples and modified it by adding bonding and allowing it to send dummy
packets.=20

Two bonds are created, both are under the Active backup mode. This is done =
by
the primary process.=20

Once the bonds are created, configured and started, the transmisssion of du=
mmy
packets starts. When tx_burst is run for the primary process, the transmiss=
ion
of packets occur without any issue.=20

However, when the tx_burst is encountered during the Secondary process with=
 the
primary process running in another terminal, a segmentation error occurs.

DPDK Version : 23.11

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17454879630.73FcBe.3987226
Date: Thu, 24 Apr 2025 11:46:03 +0200
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
   title=3D"UNCONFIRMED - rte_eth_rx_burst causes segmentation fault when e=
ncountered in a Secondary process"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1698">1698</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>rte_eth_rx_burst causes segmentation fault when encountered i=
n a Secondary process
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>23.11
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
          <td>critical
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
          <td>reuben.koshy&#64;vvdntech.in
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D311" name=3D"attach_311" title=3D"This is the scree=
nshot of the log that appears when the secondary process  tries to execute =
tx_burst">attachment 311</a> <a href=3D"attachment.cgi?id=3D311&amp;action=
=3Dedit" title=3D"This is the screenshot of the log that appears when the s=
econdary process  tries to execute tx_burst">[details]</a></span>
This is the screenshot of the log that appears when the secondary process=20
tries to execute tx_burst

I took a copy of the simple_mp main program from multi_process within the D=
PDK
examples and modified it by adding bonding and allowing it to send dummy
packets.=20

Two bonds are created, both are under the Active backup mode. This is done =
by
the primary process.=20

Once the bonds are created, configured and started, the transmisssion of du=
mmy
packets starts. When tx_burst is run for the primary process, the transmiss=
ion
of packets occur without any issue.=20

However, when the tx_burst is encountered during the Secondary process with=
 the
primary process running in another terminal, a segmentation error occurs.

DPDK Version : 23.11
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
?id=3D1698">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17454879630.73FcBe.3987226--
