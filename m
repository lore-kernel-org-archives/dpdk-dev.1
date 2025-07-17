Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B0C83F22
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 13:50:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCD214013F;
	Thu, 17 Jul 2025 15:50:18 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 771C0400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 15:50:17 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6ED2E46B9E; Thu, 17 Jul 2025 15:50:17 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1373] Make docstrings less verbose, or reduce repeats
Date: Thu, 17 Jul 2025 13:50:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: probb@iol.unh.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-1373-3-xMBZ1J7HXb@https.bugs.dpdk.org/>
In-Reply-To: <bug-1373-3@https.bugs.dpdk.org/>
References: <bug-1373-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17527602170.9B7af587E.583348
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


--17527602170.9B7af587E.583348
Date: Thu, 17 Jul 2025 15:50:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1373

Patrick Robb (probb@iol.unh.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |FIXED

--- Comment #1 from Patrick Robb (probb@iol.unh.edu) ---
Done.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17527602170.9B7af587E.583348
Date: Thu, 17 Jul 2025 15:50:17 +0200
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
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:probb&#64=
;iol.unh.edu" title=3D"Patrick Robb (probb&#64;iol.unh.edu)"> <span class=
=3D"fn">Patrick Robb</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - Make docstrings less verbose, or reduce repeat=
s"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1373">bug 1373</a>
          <br>
             <table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=
=3D"bz_diff_table">
          <tr>
            <th>What</th>
            <th>Removed</th>
            <th>Added</th>
          </tr>

         <tr>
           <td style=3D"text-align:right;">Status</td>
           <td>UNCONFIRMED
           </td>
           <td>RESOLVED
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right;">Resolution</td>
           <td>---
           </td>
           <td>FIXED
           </td>
         </tr></table>
      <p>
        <div class=3D"bz_comment_block">
            <b class=3D"bz_comment_head"><a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - Make docstrings less verbose, or reduce repeat=
s"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1373#c1">Comment # 1</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - Make docstrings less verbose, or reduce repeat=
s"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1373">bug 1373</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
probb&#64;iol.unh.edu" title=3D"Patrick Robb (probb&#64;iol.unh.edu)"> <spa=
n class=3D"fn">Patrick Robb</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">Done.
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
?id=3D1373#c1">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17527602170.9B7af587E.583348--
