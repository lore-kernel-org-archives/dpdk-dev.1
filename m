Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F04BC282D0
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 12:03:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2519240156;
	Tue,  4 Mar 2025 13:03:57 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0A04440041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 13:03:56 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D4DF54633D; Tue,  4 Mar 2025 13:03:55 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1667] Can't configure DPDK poller in busy loop to fix
 drops
Date: Tue, 04 Mar 2025 12:03:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fgiordano@riverbed.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1667-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17410898350.0d540d6.3916976
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


--17410898350.0d540d6.3916976
Date: Tue, 4 Mar 2025 13:03:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1667

            Bug ID: 1667
           Summary: Can't configure DPDK poller in busy loop to fix drops
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: fgiordano@riverbed.com
  Target Milestone: ---

I have an application where I configure multiple NICs with different PMDs a=
nd
then I have a simple poller thread that copies packets out of the descripto=
rs
of configured NICs to dedicated rte_rings (one for each port) using
rte_eth_rx_burst. Other threads will then get packets out of the rings and
process packets on a per-port basis.

This poller is configured to run in realtime mode, with high priority on a
dedicated/isolated CPU. It works well and for example on an Intel X710 it c=
an
process 10Gbps/1.8Mpps.

However, sometimes (like 3-4 times a day), the poller can't keep up and dro=
ps a
few packets. I have a sleep in my current configuration so I tried to remov=
e it
and have the poller run in busy loop (since it runs in its own cpu and cpu
usage is not a problem). But if I do so, it starts dropping packets like cr=
azy.
That's counter intuitive to me and I would like to know why that happens.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17410898350.0d540d6.3916976
Date: Tue, 4 Mar 2025 13:03:55 +0100
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
   title=3D"UNCONFIRMED - Can't configure DPDK poller in busy loop to fix d=
rops"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1667">1667</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Can't configure DPDK poller in busy loop to fix drops
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
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>core
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>fgiordano&#64;riverbed.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">I have an application where I conf=
igure multiple NICs with different PMDs and
then I have a simple poller thread that copies packets out of the descripto=
rs
of configured NICs to dedicated rte_rings (one for each port) using
rte_eth_rx_burst. Other threads will then get packets out of the rings and
process packets on a per-port basis.

This poller is configured to run in realtime mode, with high priority on a
dedicated/isolated CPU. It works well and for example on an Intel X710 it c=
an
process 10Gbps/1.8Mpps.

However, sometimes (like 3-4 times a day), the poller can't keep up and dro=
ps a
few packets. I have a sleep in my current configuration so I tried to remov=
e it
and have the poller run in busy loop (since it runs in its own cpu and cpu
usage is not a problem). But if I do so, it starts dropping packets like cr=
azy.
That's counter intuitive to me and I would like to know why that happens.
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
?id=3D1667">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17410898350.0d540d6.3916976--
