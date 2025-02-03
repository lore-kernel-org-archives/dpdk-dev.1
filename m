Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190F8C0218A
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:21:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5146240287;
	Mon,  3 Feb 2025 05:21:57 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AFAC840264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:21:56 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9362C4617D; Mon,  3 Feb 2025 05:21:56 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1629] Packets are not sent by the 1 GbE/10 GbE
 SR-IOV driver when the source MAC is not the MAC assigned to the VF NIC
Date: Mon, 03 Feb 2025 04:21:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
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
X-Bugzilla-Changed-Fields: bug_status resolution cc
Message-ID: <bug-1629-3-2RkAf4fl8Y@http.bugs.dpdk.org/>
In-Reply-To: <bug-1629-3@http.bugs.dpdk.org/>
References: <bug-1629-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17385565161.FCDbcdEba.2164413
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


--17385565161.FCDbcdEba.2164413
Date: Mon, 3 Feb 2025 05:21:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1629

Stephen Hemminger (stephen@networkplumber.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |WONTFIX
                 CC|                            |stephen@networkplumber.org

--- Comment #1 from Stephen Hemminger (stephen@networkplumber.org) ---
In recent kernels, the spoofing check is controllable on a per-interface ba=
sis
via ip link parameter (spoofchk).

This is already documented on the vf_offload page:

https://doc.dpdk.org/dts/test_plans/vf_offload_test_plan.html

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17385565161.FCDbcdEba.2164413
Date: Mon, 3 Feb 2025 05:21:56 +0100
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
   title=3D"RESOLVED WONTFIX - Packets are not sent by the 1 GbE/10 GbE SR-=
IOV driver when the source MAC is not the MAC assigned to the VF NIC"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1629">bug 1629</a>
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
           <td>stephen&#64;networkplumber.org
           </td>
         </tr></table>
      <p>
        <div class=3D"bz_comment_block">
            <b class=3D"bz_comment_head"><a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - Packets are not sent by the 1 GbE/10 GbE SR-=
IOV driver when the source MAC is not the MAC assigned to the VF NIC"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1629#c1">Comment # 1</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED WONTFIX - Packets are not sent by the 1 GbE/10 GbE SR-=
IOV driver when the source MAC is not the MAC assigned to the VF NIC"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1629">bug 1629</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
stephen&#64;networkplumber.org" title=3D"Stephen Hemminger (stephen&#64;net=
workplumber.org)"> <span class=3D"fn">Stephen Hemminger</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">In recent kernels, the spoofing ch=
eck is controllable on a per-interface basis
via ip link parameter (spoofchk).

This is already documented on the vf_offload page:

<a href=3D"https://doc.dpdk.org/dts/test_plans/vf_offload_test_plan.html">h=
ttps://doc.dpdk.org/dts/test_plans/vf_offload_test_plan.html</a>
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
?id=3D1629#c1">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17385565161.FCDbcdEba.2164413--
