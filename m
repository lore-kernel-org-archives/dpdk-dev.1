Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E2BC02195
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 15:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF9E940265;
	Mon,  3 Feb 2025 16:05:50 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B514B40264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 16:05:49 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7D2CE46185; Mon,  3 Feb 2025 16:05:49 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1600] Add test case/suite context parameters, e.g.
 required cores
Date: Mon, 03 Feb 2025 15:05:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: Luca.Vizzarro@arm.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution cc bug_status
Message-ID: <bug-1600-3-Rb7Dz6yMfW@http.bugs.dpdk.org/>
In-Reply-To: <bug-1600-3@http.bugs.dpdk.org/>
References: <bug-1600-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17385951491.40F1F.2500197
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


--17385951491.40F1F.2500197
Date: Mon, 3 Feb 2025 16:05:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1600

Luca Vizzarro (Luca.Vizzarro@arm.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |DUPLICATE
                 CC|                            |Luca.Vizzarro@arm.com
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from Luca Vizzarro (Luca.Vizzarro@arm.com) ---
Duplicate of https://bugs.dpdk.org/show_bug.cgi?id=3D1461

*** This bug has been marked as a duplicate of bug 1461 ***

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17385951491.40F1F.2500197
Date: Mon, 3 Feb 2025 16:05:49 +0100
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
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:Luca.Vizz=
arro&#64;arm.com" title=3D"Luca Vizzarro (Luca.Vizzarro&#64;arm.com)"> <spa=
n class=3D"fn">Luca Vizzarro</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED DUPLICATE - Add test case/suite context parameters, e.=
g. required cores"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1600">bug 1600</a>
          <br>
             <table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=
=3D"bz_diff_table">
          <tr>
            <th>What</th>
            <th>Removed</th>
            <th>Added</th>
          </tr>

         <tr>
           <td style=3D"text-align:right;">Resolution</td>
           <td>---
           </td>
           <td>DUPLICATE
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right;">CC</td>
           <td>
               &nbsp;
           </td>
           <td>Luca.Vizzarro&#64;arm.com
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
   title=3D"RESOLVED DUPLICATE - Add test case/suite context parameters, e.=
g. required cores"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1600#c1">Comment # 1</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED DUPLICATE - Add test case/suite context parameters, e.=
g. required cores"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1600">bug 1600</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
Luca.Vizzarro&#64;arm.com" title=3D"Luca Vizzarro (Luca.Vizzarro&#64;arm.co=
m)"> <span class=3D"fn">Luca Vizzarro</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">Duplicate of <a class=3D"bz_bug_li=
nk           bz_status_UNCONFIRMED "   title=3D"UNCONFIRMED - Apply test ca=
ses core filters through decorators"   href=3D"show_bug.cgi?id=3D1461">http=
s://bugs.dpdk.org/show_bug.cgi?id=3D1461</a>

*** This bug has been marked as a duplicate of <a class=3D"bz_bug_link     =
      bz_status_UNCONFIRMED "   title=3D"UNCONFIRMED - Apply test cases cor=
e filters through decorators"   href=3D"show_bug.cgi?id=3D1461">bug 1461</a=
> ***
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
?id=3D1600#c1">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17385951491.40F1F.2500197--
