Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F4C282DE
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 00:58:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE3794025D;
	Fri, 14 Mar 2025 01:58:37 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 890D54025A
 for <dev@dpdk.org>; Fri, 14 Mar 2025 01:58:36 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 64D40463A3; Fri, 14 Mar 2025 01:58:36 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1675] Shutting down the link on broadcom bnxt
 BCM57508 100GbE doesn't shutdown link on peer side
Date: Fri, 14 Mar 2025 00:58:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 21.08
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: saurin.suthar@trellix.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1675-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17419139160.E5b0aF76.3060566
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


--17419139160.E5b0aF76.3060566
Date: Fri, 14 Mar 2025 01:58:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1675

            Bug ID: 1675
           Summary: Shutting down the link on broadcom bnxt BCM57508
                    100GbE doesn't shutdown link on peer side
           Product: DPDK
           Version: 21.08
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: saurin.suthar@trellix.com
  Target Milestone: ---

We are using BCM57508 100GbE 2-port NIC AOC-A100G-B2CM
https://www.supermicro.com/en/products/accessories/addon/AOC-A100G-b2CM.php

Running alma linux 5.15.133 kernel with dpdk v21.08. Both 100G ports are
working normal and able to tx/rx. But when I bring the link down using
"ifconfig ethx down" the link status shows it is down. But on that interfac=
e,
packets are still coming, also peer side link is not going down. Is there a
patch available for this? If I bring the link down from peer side, link goes
down on my machine side.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17419139160.E5b0aF76.3060566
Date: Fri, 14 Mar 2025 01:58:36 +0100
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
   title=3D"UNCONFIRMED - Shutting down the link on broadcom bnxt BCM57508 =
100GbE doesn't shutdown link on peer side"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1675">1675</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Shutting down the link on broadcom bnxt BCM57508 100GbE doesn=
't shutdown link on peer side
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>21.08
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
          <td>saurin.suthar&#64;trellix.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">We are using BCM57508 100GbE 2-por=
t NIC AOC-A100G-B2CM
<a href=3D"https://www.supermicro.com/en/products/accessories/addon/AOC-A10=
0G-b2CM.php">https://www.supermicro.com/en/products/accessories/addon/AOC-A=
100G-b2CM.php</a>

Running alma linux 5.15.133 kernel with dpdk v21.08. Both 100G ports are
working normal and able to tx/rx. But when I bring the link down using
&quot;ifconfig ethx down&quot; the link status shows it is down. But on tha=
t interface,
packets are still coming, also peer side link is not going down. Is there a
patch available for this? If I bring the link down from peer side, link goes
down on my machine side.
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
?id=3D1675">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17419139160.E5b0aF76.3060566--
