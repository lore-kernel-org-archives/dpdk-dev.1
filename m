Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62DAC36014
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 22:33:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7717402E1;
	Tue,  1 Apr 2025 00:33:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2C9F5402B1
 for <dev@dpdk.org>; Tue,  1 Apr 2025 00:33:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3F3CA464D1; Tue,  1 Apr 2025 00:33:30 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 183] Problem using cloned rte_mbuf buffers with KNI
 interface
Date: Mon, 31 Mar 2025 22:33:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 18.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WONTFIX
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-183-3-vqnPe6qZln@http.bugs.dpdk.org/>
In-Reply-To: <bug-183-3@http.bugs.dpdk.org/>
References: <bug-183-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17434604100.93812.524998
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


--17434604100.93812.524998
Date: Tue, 1 Apr 2025 00:33:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D183

Stephen Hemminger (stephen@networkplumber.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|CONFIRMED                   |RESOLVED
                 CC|                            |stephen@networkplumber.org
         Resolution|---                         |WONTFIX

--- Comment #8 from Stephen Hemminger (stephen@networkplumber.org) ---
KNI is no longer supported, will not be fixed.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17434604100.93812.524998
Date: Tue, 1 Apr 2025 00:33:30 +0200
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
   title=3D"RESOLVED WONTFIX - Problem using cloned rte_mbuf buffers with K=
NI interface"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D183">bug 183</a>
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
           <td>CONFIRMED
           </td>
           <td>RESOLVED
           </td>
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
           <td>WONTFIX
           </td>
         </tr></table>
      <p>
        <div class=3D"bz_comment_block">
            <b class=3D"bz_comment_head"><a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - Problem using cloned rte_mbuf buffers with K=
NI interface"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D183#c8">Comment # 8</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - Problem using cloned rte_mbuf buffers with K=
NI interface"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D183">bug 183</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
stephen&#64;networkplumber.org" title=3D"Stephen Hemminger (stephen&#64;net=
workplumber.org)"> <span class=3D"fn">Stephen Hemminger</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">KNI is no longer supported, will n=
ot be fixed.
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
?id=3D183#c8">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17434604100.93812.524998--
