Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F22C02190
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C43640A82;
	Mon,  3 Feb 2025 05:18:44 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 950C340A7F
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:18:42 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8FBB04617C; Mon,  3 Feb 2025 05:18:42 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/examples Bug 1628] Multi-process sample app requires exact
 memory mapping
Date: Mon, 03 Feb 2025 04:18:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WONTFIX
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution cc bug_status
Message-ID: <bug-1628-3-MIqfgb97Ho@http.bugs.dpdk.org/>
In-Reply-To: <bug-1628-3@http.bugs.dpdk.org/>
References: <bug-1628-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17385563220.5f7F.2162175
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


--17385563220.5f7F.2162175
Date: Mon, 3 Feb 2025 05:18:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1628

Stephen Hemminger (stephen@networkplumber.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |WONTFIX
                 CC|                            |stephen@networkplumber.org
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from Stephen Hemminger (stephen@networkplumber.org) ---
See documentation already describes this problem in detail, this is not a b=
ug
but a documented limitation.

See 23.3 here:
https://doc.dpdk.org/guides-1.8/prog_guide/multi_proc_support.html

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17385563220.5f7F.2162175
Date: Mon, 3 Feb 2025 05:18:42 +0100
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
   title=3D"RESOLVED WONTFIX - Multi-process sample app requires exact memo=
ry mapping"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1628">bug 1628</a>
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
           <td>WONTFIX
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
   title=3D"RESOLVED WONTFIX - Multi-process sample app requires exact memo=
ry mapping"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1628#c1">Comment # 1</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - Multi-process sample app requires exact memo=
ry mapping"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1628">bug 1628</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
stephen&#64;networkplumber.org" title=3D"Stephen Hemminger (stephen&#64;net=
workplumber.org)"> <span class=3D"fn">Stephen Hemminger</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">See documentation already describe=
s this problem in detail, this is not a bug
but a documented limitation.

See 23.3 here:
<a href=3D"https://doc.dpdk.org/guides-1.8/prog_guide/multi_proc_support.ht=
ml">https://doc.dpdk.org/guides-1.8/prog_guide/multi_proc_support.html</a>
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
?id=3D1628#c1">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17385563220.5f7F.2162175--
