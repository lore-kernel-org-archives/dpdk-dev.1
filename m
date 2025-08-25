Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4645CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 07:05:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B57E402E7;
	Mon, 25 Aug 2025 09:05:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 247D8402CE
 for <dev@dpdk.org>; Mon, 25 Aug 2025 09:05:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1D8FF46DC8; Mon, 25 Aug 2025 09:05:31 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1772] [23.11] net/hns3 fails to build with clang 20
 and C11 stdatomic enabled
Date: Mon, 25 Aug 2025 07:05:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xuemingl@nvidia.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-1772-3-48OsedHZjh@https.bugs.dpdk.org/>
In-Reply-To: <bug-1772-3@https.bugs.dpdk.org/>
References: <bug-1772-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17561055300.34AcF1751.1044006
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


--17561055300.34AcF1751.1044006
Date: Mon, 25 Aug 2025 09:05:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1772

xuemingl@nvidia.com (xuemingl@nvidia.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |DUPLICATE
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #2 from xuemingl@nvidia.com (xuemingl@nvidia.com) ---
The support of higher C standard has be included in main branch, the 23.11
can't support it. Please refer to https://bugs.dpdk.org/show_bug.cgi?id=3D1=
771

*** This bug has been marked as a duplicate of bug 1771 ***

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17561055300.34AcF1751.1044006
Date: Mon, 25 Aug 2025 09:05:30 +0200
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
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:xuemingl&=
#64;nvidia.com" title=3D"xuemingl&#64;nvidia.com (xuemingl&#64;nvidia.com)"=
> <span class=3D"fn">xuemingl&#64;nvidia.com</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED DUPLICATE - [23.11] net/hns3 fails to build with clang=
 20 and C11 stdatomic enabled"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1772">bug 1772</a>
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
   title=3D"RESOLVED DUPLICATE - [23.11] net/hns3 fails to build with clang=
 20 and C11 stdatomic enabled"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1772#c2">Comment # 2</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED DUPLICATE - [23.11] net/hns3 fails to build with clang=
 20 and C11 stdatomic enabled"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1772">bug 1772</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
xuemingl&#64;nvidia.com" title=3D"xuemingl&#64;nvidia.com (xuemingl&#64;nvi=
dia.com)"> <span class=3D"fn">xuemingl&#64;nvidia.com</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">The support of higher C standard h=
as be included in main branch, the 23.11
can't support it. Please refer to <a class=3D"bz_bug_link           bz_stat=
us_RESOLVED  bz_closed"   title=3D"RESOLVED WONTFIX - [dpdk 23.11.5-rc1] dr=
ivers/net/cxgbe meson build failed on Fedora42 with gcc15.0.1"   href=3D"sh=
ow_bug.cgi?id=3D1771">https://bugs.dpdk.org/show_bug.cgi?id=3D1771</a>

*** This bug has been marked as a duplicate of <a class=3D"bz_bug_link     =
      bz_status_RESOLVED  bz_closed"   title=3D"RESOLVED WONTFIX - [dpdk 23=
.11.5-rc1] drivers/net/cxgbe meson build failed on Fedora42 with gcc15.0.1"=
   href=3D"show_bug.cgi?id=3D1771">bug 1771</a> ***
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
?id=3D1772#c2">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17561055300.34AcF1751.1044006--
