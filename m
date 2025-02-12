Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A6C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 18:51:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0266742D55;
	Wed, 12 Feb 2025 19:51:41 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AB452400D5
 for <dev@dpdk.org>; Wed, 12 Feb 2025 19:51:39 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A178B46207; Wed, 12 Feb 2025 19:51:39 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1633] Kernel crash on IGB port unbinding
Date: Wed, 12 Feb 2025 18:51:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ktraynor@redhat.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WONTFIX
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution cc
Message-ID: <bug-1633-3-lJ4fgq2zJU@http.bugs.dpdk.org/>
In-Reply-To: <bug-1633-3@http.bugs.dpdk.org/>
References: <bug-1633-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17393862991.4E8c1Bfe2.211627
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


--17393862991.4E8c1Bfe2.211627
Date: Wed, 12 Feb 2025 19:51:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1633

Kevin Traynor (ktraynor@redhat.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |WONTFIX
                 CC|                            |ktraynor@redhat.com

--- Comment #2 from Kevin Traynor (ktraynor@redhat.com) ---
F14 is EoL since 2011

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17393862991.4E8c1Bfe2.211627
Date: Wed, 12 Feb 2025 19:51:39 +0100
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
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:ktraynor&=
#64;redhat.com" title=3D"Kevin Traynor (ktraynor&#64;redhat.com)"> <span cl=
ass=3D"fn">Kevin Traynor</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - Kernel crash on IGB port unbinding"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1633">bug 1633</a>
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
           <td>WONTFIX
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right;">CC</td>
           <td>
               &nbsp;
           </td>
           <td>ktraynor&#64;redhat.com
           </td>
         </tr></table>
      <p>
        <div class=3D"bz_comment_block">
            <b class=3D"bz_comment_head"><a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - Kernel crash on IGB port unbinding"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1633#c2">Comment # 2</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - Kernel crash on IGB port unbinding"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1633">bug 1633</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
ktraynor&#64;redhat.com" title=3D"Kevin Traynor (ktraynor&#64;redhat.com)">=
 <span class=3D"fn">Kevin Traynor</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">F14 is EoL since 2011
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
?id=3D1633#c2">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17393862991.4E8c1Bfe2.211627--
