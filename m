Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DA7C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 16:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6221242DCB;
	Wed, 21 May 2025 18:44:31 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DA38F42DB0
 for <dev@dpdk.org>; Wed, 21 May 2025 18:44:29 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C0FFE467B2; Wed, 21 May 2025 18:44:29 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1536] net/tap: crash in tap pmd when using more
 than RTE_MP_MAX_FD_NUM rx queues
Date: Wed, 21 May 2025 16:44:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc resolution bug_status
Message-ID: <bug-1536-3-On97FtpBMV@http.bugs.dpdk.org/>
In-Reply-To: <bug-1536-3@http.bugs.dpdk.org/>
References: <bug-1536-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17478458691.0D55c.2345444
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


--17478458691.0D55c.2345444
Date: Wed, 21 May 2025 18:44:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1536

Stephen Hemminger (stephen@networkplumber.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |stephen@networkplumber.org
         Resolution|---                         |FIXED
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from Stephen Hemminger (stephen@networkplumber.org) ---
This was addressed in 24.11 by increasing the size of RTE_MP_MAX_FD_NUM to =
the
kernel limit (253)

See:


commit 5ff00bbc04d8338108241b083b7a6238208cfbc6
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Thu Sep 5 09:20:18 2024 -0700

    ipc: increase file descriptor maximum number

    The TAP and XDP driver both are limited to only 8 queues because of the
    small limit imposed by EAL.
    Increase the limit now, since this release allows changing ABI.

    Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
    Acked-by: Chengwen Feng <fengchengwen@huawei.com>
    Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
    Acked-by: Ferruh Yigit <ferruh.yigit@amd.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17478458691.0D55c.2345444
Date: Wed, 21 May 2025 18:44:29 +0200
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
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:stephen&#=
64;networkplumber.org" title=3D"Stephen Hemminger (stephen&#64;networkplumb=
er.org)"> <span class=3D"fn">Stephen Hemminger</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - net/tap: crash in tap pmd when using more than=
 RTE_MP_MAX_FD_NUM rx queues"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1536">bug 1536</a>
          <br>
             <table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=
=3D"bz_diff_table">
          <tr>
            <th>What</th>
            <th>Removed</th>
            <th>Added</th>
          </tr>

         <tr>
           <td style=3D"text-align:right;">CC</td>
           <td>
               &nbsp;
           </td>
           <td>stephen&#64;networkplumber.org
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right;">Resolution</td>
           <td>---
           </td>
           <td>FIXED
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right;">Status</td>
           <td>UNCONFIRMED
           </td>
           <td>RESOLVED
           </td>
         </tr></table>
      <p>
        <div class=3D"bz_comment_block">
            <b class=3D"bz_comment_head"><a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - net/tap: crash in tap pmd when using more than=
 RTE_MP_MAX_FD_NUM rx queues"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1536#c1">Comment # 1</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - net/tap: crash in tap pmd when using more than=
 RTE_MP_MAX_FD_NUM rx queues"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1536">bug 1536</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
stephen&#64;networkplumber.org" title=3D"Stephen Hemminger (stephen&#64;net=
workplumber.org)"> <span class=3D"fn">Stephen Hemminger</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">This was addressed in 24.11 by inc=
reasing the size of RTE_MP_MAX_FD_NUM to the
kernel limit (253)

See:


commit 5ff00bbc04d8338108241b083b7a6238208cfbc6
Author: Stephen Hemminger &lt;<a href=3D"mailto:stephen&#64;networkplumber.=
org">stephen&#64;networkplumber.org</a>&gt;
Date:   Thu Sep 5 09:20:18 2024 -0700

    ipc: increase file descriptor maximum number

    The TAP and XDP driver both are limited to only 8 queues because of the
    small limit imposed by EAL.
    Increase the limit now, since this release allows changing ABI.

    Signed-off-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen&#64;netw=
orkplumber.org">stephen&#64;networkplumber.org</a>&gt;
    Acked-by: Chengwen Feng &lt;<a href=3D"mailto:fengchengwen&#64;huawei.c=
om">fengchengwen&#64;huawei.com</a>&gt;
    Acked-by: Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb&#64;smartsharesys=
tems.com">mb&#64;smartsharesystems.com</a>&gt;
    Acked-by: Ferruh Yigit &lt;<a href=3D"mailto:ferruh.yigit&#64;amd.com">=
ferruh.yigit&#64;amd.com</a>&gt;
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
?id=3D1536#c1">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17478458691.0D55c.2345444--
