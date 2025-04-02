Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEFEC36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 352774029A;
	Thu,  3 Apr 2025 01:55:36 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1FB864014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:55:35 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id F1911464EB; Thu,  3 Apr 2025 01:55:34 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1688] [24.11] random application crash in
 failsafe_rx_burst_fast
Date: Wed, 02 Apr 2025 23:55:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: kanikamago@microsoft.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1688-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17436381340.Ab56E7A.1547965
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


--17436381340.Ab56E7A.1547965
Date: Thu, 3 Apr 2025 01:55:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1688

            Bug ID: 1688
           Summary: [24.11] random application crash in
                    failsafe_rx_burst_fast
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: kanikamago@microsoft.com
  Target Milestone: ---

Created attachment 307
  --> https://bugs.dpdk.org/attachment.cgi?id=3D307&action=3Dedit
Coredump of application crash

we recently upgraded our packet processing application from 20.11 to 24.11 =
LTS
dpdk version. The change when rolled to canary is causing nodes to crash
randomly. The crash is not recurring i.e. when node is recovered the
application starts and runs.

Host OS - Windows
Guest OS - Linux (Mariner), application running here
Linkage - DPDK statically compiled into app
Crash callstack - Attached as Image
NIC - Mellanox ConnectX-3-pro
Application params - -a $PCI --vdev=3Dnet_vdev_netvsc0,iface=3D$IFNAME=20
Secondary application - None

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17436381340.Ab56E7A.1547965
Date: Thu, 3 Apr 2025 01:55:34 +0200
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
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - [24.11] random application crash in failsafe_rx_b=
urst_fast"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1688">1688</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[24.11] random application crash in failsafe_rx_burst_fast
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.11
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>major
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>kanikamago&#64;microsoft.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D307" name=3D"attach_307" title=3D"Coredump of appli=
cation crash">attachment 307</a> <a href=3D"attachment.cgi?id=3D307&amp;act=
ion=3Dedit" title=3D"Coredump of application crash">[details]</a></span>
Coredump of application crash

we recently upgraded our packet processing application from 20.11 to 24.11 =
LTS
dpdk version. The change when rolled to canary is causing nodes to crash
randomly. The crash is not recurring i.e. when node is recovered the
application starts and runs.

Host OS - Windows
Guest OS - Linux (Mariner), application running here
Linkage - DPDK statically compiled into app
Crash callstack - Attached as Image
NIC - Mellanox ConnectX-3-pro
Application params - -a $PCI --vdev=3Dnet_vdev_netvsc0,iface=3D$IFNAME=20
Secondary application - None
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
?id=3D1688">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17436381340.Ab56E7A.1547965--
