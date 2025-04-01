Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907BCC36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 13:53:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65B7C402C8;
	Tue,  1 Apr 2025 15:53:52 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7B75740275
 for <dev@dpdk.org>; Tue,  1 Apr 2025 15:53:51 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 5AE17464DC; Tue,  1 Apr 2025 15:53:51 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1686] [dpdk-22.11.8RC1]
 unit_tests_cryptodev_func/cryptodev_aesni_gcm_autotest: test
 failing-Segmentation fault
Date: Tue, 01 Apr 2025 13:53:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luca.boccassi@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-1686-3-Gbah6TpoGh@http.bugs.dpdk.org/>
In-Reply-To: <bug-1686-3@http.bugs.dpdk.org/>
References: <bug-1686-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17435156311.a44fA296.833541
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


--17435156311.a44fA296.833541
Date: Tue, 1 Apr 2025 15:53:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1686

Luca Boccassi (luca.boccassi@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
                 CC|                            |luca.boccassi@gmail.com
         Resolution|---                         |FIXED

--- Comment #1 from Luca Boccassi (luca.boccassi@gmail.com) ---
Fixed in stable/22.11

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17435156311.a44fA296.833541
Date: Tue, 1 Apr 2025 15:53:51 +0200
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
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:luca.bocc=
assi&#64;gmail.com" title=3D"Luca Boccassi (luca.boccassi&#64;gmail.com)"> =
<span class=3D"fn">Luca Boccassi</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - [dpdk-22.11.8RC1] unit_tests_cryptodev_func/cr=
yptodev_aesni_gcm_autotest: test failing-Segmentation fault"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1686">bug 1686</a>
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
           <td style=3D"text-align:right;">CC</td>
           <td>
               &nbsp;
           </td>
           <td>luca.boccassi&#64;gmail.com
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
   title=3D"RESOLVED FIXED - [dpdk-22.11.8RC1] unit_tests_cryptodev_func/cr=
yptodev_aesni_gcm_autotest: test failing-Segmentation fault"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1686#c1">Comment # 1</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - [dpdk-22.11.8RC1] unit_tests_cryptodev_func/cr=
yptodev_aesni_gcm_autotest: test failing-Segmentation fault"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1686">bug 1686</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
luca.boccassi&#64;gmail.com" title=3D"Luca Boccassi (luca.boccassi&#64;gmai=
l.com)"> <span class=3D"fn">Luca Boccassi</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">Fixed in stable/22.11
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
?id=3D1686#c1">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17435156311.a44fA296.833541--
