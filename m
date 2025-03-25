Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A1C35FFC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 04:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E692040E17;
	Tue, 25 Mar 2025 05:25:41 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id EA89A40B9C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 05:25:40 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id CD72A46471; Tue, 25 Mar 2025 05:25:40 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1682] [dpdk-25.03]
 vhost_virtio_fuzzing/tso_forward_pkt: testpmd cannot exit normally when test
 fuzz
Date: Tue, 25 Mar 2025 04:25:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: songx.jiale@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-1682-3-9ja32OGWxY@http.bugs.dpdk.org/>
In-Reply-To: <bug-1682-3@http.bugs.dpdk.org/>
References: <bug-1682-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17428767400.5fcBA8541.244301
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


--17428767400.5fcBA8541.244301
Date: Tue, 25 Mar 2025 05:25:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1682

Jiale Song (songx.jiale@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |FIXED

--- Comment #4 from Jiale Song (songx.jiale@intel.com) ---
The issue no longer reproduced in the DPDK 25.03 release version.
fix patch: https://patchwork.dpdk.org/project/dpdk/list/?series=3D34907

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17428767400.5fcBA8541.244301
Date: Tue, 25 Mar 2025 05:25:40 +0100
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
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:songx.jia=
le&#64;intel.com" title=3D"Jiale Song (songx.jiale&#64;intel.com)"> <span c=
lass=3D"fn">Jiale Song</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - [dpdk-25.03] vhost_virtio_fuzzing/tso_forward_=
pkt: testpmd cannot exit normally when test fuzz"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1682">bug 1682</a>
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
   title=3D"RESOLVED FIXED - [dpdk-25.03] vhost_virtio_fuzzing/tso_forward_=
pkt: testpmd cannot exit normally when test fuzz"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1682#c4">Comment # 4</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - [dpdk-25.03] vhost_virtio_fuzzing/tso_forward_=
pkt: testpmd cannot exit normally when test fuzz"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1682">bug 1682</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
songx.jiale&#64;intel.com" title=3D"Jiale Song (songx.jiale&#64;intel.com)"=
> <span class=3D"fn">Jiale Song</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">The issue no longer reproduced in =
the DPDK 25.03 release version.
fix patch: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D34907">https://patchwork.dpdk.org/project/dpdk/list/?series=3D34907</a>
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
?id=3D1682#c4">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17428767400.5fcBA8541.244301--
