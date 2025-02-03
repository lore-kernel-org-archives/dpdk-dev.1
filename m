Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D986EC0218F
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 02:44:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C7F9400EF;
	Mon,  3 Feb 2025 03:44:34 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id EE6AE400D7
 for <dev@dpdk.org>; Mon,  3 Feb 2025 03:44:32 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E736E4617B; Mon,  3 Feb 2025 03:44:32 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1630] SR-IOV drivers do not fully implement the
 rte_ethdev API
Date: Mon, 03 Feb 2025 02:44:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nandinipersad361@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1630-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17385506720.F0D1ce0.2110029
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


--17385506720.F0D1ce0.2110029
Date: Mon, 3 Feb 2025 03:44:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1630

            Bug ID: 1630
           Summary: SR-IOV drivers do not fully implement the rte_ethdev
                    API
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: nandinipersad361@gmail.com
  Target Milestone: ---

The SR-IOV drivers only supports the following rte_ethdev API functions:

rte_eth_dev_configure()

rte_eth_tx_queue_setup()

rte_eth_rx_queue_setup()

rte_eth_dev_info_get()

rte_eth_dev_start()

rte_eth_tx_burst()

rte_eth_rx_burst()

rte_eth_dev_stop()

rte_eth_stats_get()

rte_eth_stats_reset()

rte_eth_link_get()

rte_eth_link_get_no_wait()

Implication:
Calling an unsupported function will result in an application error.

Resolution/Workaround:
Do not use other rte_ethdev API functions in applications that use the SR-I=
OV
drivers.

Affected Environment/Platform:
All.

Driver/Module:
VF Poll Mode Driver (PMD).

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17385506720.F0D1ce0.2110029
Date: Mon, 3 Feb 2025 03:44:32 +0100
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
   title=3D"UNCONFIRMED - SR-IOV drivers do not fully implement the rte_eth=
dev API"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1630">1630</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>SR-IOV drivers do not fully implement the rte_ethdev API
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
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
          <td>nandinipersad361&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">The SR-IOV drivers only supports t=
he following rte_ethdev API functions:

rte_eth_dev_configure()

rte_eth_tx_queue_setup()

rte_eth_rx_queue_setup()

rte_eth_dev_info_get()

rte_eth_dev_start()

rte_eth_tx_burst()

rte_eth_rx_burst()

rte_eth_dev_stop()

rte_eth_stats_get()

rte_eth_stats_reset()

rte_eth_link_get()

rte_eth_link_get_no_wait()

Implication:
Calling an unsupported function will result in an application error.

Resolution/Workaround:
Do not use other rte_ethdev API functions in applications that use the SR-I=
OV
drivers.

Affected Environment/Platform:
All.

Driver/Module:
VF Poll Mode Driver (PMD).
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
?id=3D1630">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17385506720.F0D1ce0.2110029--
