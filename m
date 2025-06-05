Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EFEC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 14:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CF7240281;
	Thu,  5 Jun 2025 16:05:52 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C102940150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 16:05:50 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id BB7E44688E; Thu,  5 Jun 2025 16:05:50 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1719] mlx5 PMD returns incorrect max_mtu and
 max_rx_pktlen from rte_eth_dev_info_get()
Date: Thu, 05 Jun 2025 14:05:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dsosnowski@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1719-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17491323500.F5Ae0e.1207551
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


--17491323500.F5Ae0e.1207551
Date: Thu, 5 Jun 2025 16:05:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1719

            Bug ID: 1719
           Summary: mlx5 PMD returns incorrect max_mtu and max_rx_pktlen
                    from rte_eth_dev_info_get()
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: dsosnowski@nvidia.com
  Target Milestone: ---

mlx5 PMD returns incorrect values for max_mtu and max_rx_pktlen from
rte_eth_dev_info_get(). To be specific:

- max_mtu is set to UINT16_MAX - set statically in rte_eth_dev_info_get()
implementation as a fallback; it is never updated based on device's
capabilities in mlx5 PMD implementation=20
- max_rx_pktlen is set to 65536 - incorrect value; should be read based on
device's capabilities

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17491323500.F5Ae0e.1207551
Date: Thu, 5 Jun 2025 16:05:50 +0200
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
   title=3D"UNCONFIRMED - mlx5 PMD returns incorrect max_mtu and max_rx_pkt=
len from rte_eth_dev_info_get()"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1719">1719</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>mlx5 PMD returns incorrect max_mtu and max_rx_pktlen from rte=
_eth_dev_info_get()
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
          <td>dsosnowski&#64;nvidia.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">mlx5 PMD returns incorrect values =
for max_mtu and max_rx_pktlen from
rte_eth_dev_info_get(). To be specific:

- max_mtu is set to UINT16_MAX - set statically in rte_eth_dev_info_get()
implementation as a fallback; it is never updated based on device's
capabilities in mlx5 PMD implementation=20
- max_rx_pktlen is set to 65536 - incorrect value; should be read based on
device's capabilities
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
?id=3D1719">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17491323500.F5Ae0e.1207551--
