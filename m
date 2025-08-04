Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D17C87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 11:15:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38AC340676;
	Mon,  4 Aug 2025 13:15:01 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5BEBC4025D
 for <dev@dpdk.org>; Mon,  4 Aug 2025 13:14:59 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4147C46CA9; Mon,  4 Aug 2025 13:14:59 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1763] Enabling debug traces changes the behaviour
 of VRB1 driver
Date: Mon, 04 Aug 2025 11:14:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: faust1002@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1763-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17543060990.eC4b86DD.1511795
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


--17543060990.eC4b86DD.1511795
Date: Mon, 4 Aug 2025 13:14:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1763

            Bug ID: 1763
           Summary: Enabling debug traces changes the behaviour of VRB1
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
          Reporter: faust1002@gmail.com
  Target Milestone: ---

Created attachment 325
  --> https://bugs.dpdk.org/attachment.cgi?id=3D325&action=3Dedit
Code snippet

Hello,
When DPDK is compiled with RTE_LIBRTE_BBDEV_DEBUG macro on (rte_vrb_pmd.c),
desc->req.sdone_enable might not be set. However, then the macro is disable=
d,
that bit will be always set. In other words, when the macro dedicated for
debuging is enabled, then driver behaves differently. This is definitely no=
t a
good programming practise.
Kind regards

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17543060990.eC4b86DD.1511795
Date: Mon, 4 Aug 2025 13:14:59 +0200
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
   title=3D"UNCONFIRMED - Enabling debug traces changes the behaviour of VR=
B1 driver"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1763">1763</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Enabling debug traces changes the behaviour of VRB1 driver
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
          <td>faust1002&#64;gmail.com
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
=3D"attachment.cgi?id=3D325" name=3D"attach_325" title=3D"Code snippet">att=
achment 325</a> <a href=3D"attachment.cgi?id=3D325&amp;action=3Dedit" title=
=3D"Code snippet">[details]</a></span>
Code snippet

Hello,
When DPDK is compiled with RTE_LIBRTE_BBDEV_DEBUG macro on (rte_vrb_pmd.c),
desc-&gt;req.sdone_enable might not be set. However, then the macro is disa=
bled,
that bit will be always set. In other words, when the macro dedicated for
debuging is enabled, then driver behaves differently. This is definitely no=
t a
good programming practise.
Kind regards
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
?id=3D1763">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17543060990.eC4b86DD.1511795--
