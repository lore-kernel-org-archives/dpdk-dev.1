Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A262DCA0EC4
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 21:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 883CF4013F;
	Mon, 11 Aug 2025 23:30:06 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 12EDF400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 23:30:05 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0720746D02; Mon, 11 Aug 2025 23:30:05 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1768] net/mlx5: get_mtu returns 1500 on startup
 instead of kernel driver MTU
Date: Mon, 11 Aug 2025 21:30:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: brian90013@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1768-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17549478040.db3DB2cC.3272312
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
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


--17549478040.db3DB2cC.3272312
Date: Mon, 11 Aug 2025 23:30:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1768

            Bug ID: 1768
           Summary: net/mlx5: get_mtu returns 1500 on startup instead of
                    kernel driver MTU
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: brian90013@gmail.com
  Target Milestone: ---

Hello,

I observe this issue with both DPDK 24.11 and 25.07 on Debian 12 with DOCA
3.0.0 and a ConnectX-5 NIC. My code calls rte_eth_dev_get_mtu() to determine
the existing MTU value of the kernel driver before initializing DPDK. Then =
it
sets rte_eth_conf.rxmode.mtu equal to the returned value and calls
rte_eth_dev_configure(). This way DPDK uses the same MTU as the kernel driv=
er.

However, when running this code I observe the initial rte_eth_dev_get_mtu()
call always returns 1500B. I have tried setting kernel MTUs of 800, 3000, 4=
000,
and 9000B. I added tracing to lib/ethdev and drivers/net/mlx5 and believe t=
he
issue is because while mlx5 determines and stores the current MTU, that val=
ue
is not propagated back to the ethdev structure.


My attempt at a timeline:
* mlx5_dev_spawn() sets priv->mtu =3D RTE_ETHER_MTU (1500)
* mlx5_dev_spawn() sets eth_dev =3D rte_eth_dev_allocate()
* rte_eth_dev_allocate() sets eth_dev->data->mtu =3D RTE_ETHER_MTU (1500)
* mlx5_dev_spawn() gets actual MTU calling mlx5_get_mtu(&priv->mtu)
#### eth_dev->data->mtu doesn't get updated ####
* I call rte_eth_dev_get_mtu() which returns 1500


For testing, I tried this patch to set the rte_eth_dev_data.mtu field equal=
 to
the value returned from mlx5_get_mtu(). With this change, my code works as
expected. I hope something like this can be merged to allow cooperation bet=
ween
the kernel and DPDK drivers. Thank you for your time and your work on mlx5!


--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1594,6 +1594,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
        }
        DRV_LOG(DEBUG, "port %u MTU is %u", eth_dev->data->port_id,
                priv->mtu);
+       ethdev->data->mtu =3D priv->mtu;
        /* Initialize burst functions to prevent crashes before link-up. */
        eth_dev->rx_pkt_burst =3D rte_eth_pkt_burst_dummy;
        eth_dev->tx_pkt_burst =3D rte_eth_pkt_burst_dummy;

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17549478040.db3DB2cC.3272312
Date: Mon, 11 Aug 2025 23:30:04 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - net/mlx5: get_mtu returns 1500 on startup instead=
 of kernel driver MTU"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1768">1768</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>net/mlx5: get_mtu returns 1500 on startup instead of kernel d=
river MTU
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
          <td>brian90013&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hello,

I observe this issue with both DPDK 24.11 and 25.07 on Debian 12 with DOCA
3.0.0 and a ConnectX-5 NIC. My code calls rte_eth_dev_get_mtu() to determine
the existing MTU value of the kernel driver before initializing DPDK. Then =
it
sets rte_eth_conf.rxmode.mtu equal to the returned value and calls
rte_eth_dev_configure(). This way DPDK uses the same MTU as the kernel driv=
er.

However, when running this code I observe the initial rte_eth_dev_get_mtu()
call always returns 1500B. I have tried setting kernel MTUs of 800, 3000, 4=
000,
and 9000B. I added tracing to lib/ethdev and drivers/net/mlx5 and believe t=
he
issue is because while mlx5 determines and stores the current MTU, that val=
ue
is not propagated back to the ethdev structure.


My attempt at a timeline:
* mlx5_dev_spawn() sets priv-&gt;mtu =3D RTE_ETHER_MTU (1500)
* mlx5_dev_spawn() sets eth_dev =3D rte_eth_dev_allocate()
* rte_eth_dev_allocate() sets eth_dev-&gt;data-&gt;mtu =3D RTE_ETHER_MTU (1=
500)
* mlx5_dev_spawn() gets actual MTU calling mlx5_get_mtu(&amp;priv-&gt;mtu)
#### eth_dev-&gt;data-&gt;mtu doesn't get updated ####
* I call rte_eth_dev_get_mtu() which returns 1500


For testing, I tried this patch to set the rte_eth_dev_data.mtu field equal=
 to
the value returned from mlx5_get_mtu(). With this change, my code works as
expected. I hope something like this can be merged to allow cooperation bet=
ween
the kernel and DPDK drivers. Thank you for your time and your work on mlx5!


--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
&#64;&#64; -1594,6 +1594,7 &#64;&#64; mlx5_dev_spawn(struct rte_device *dpd=
k_dev,
        }
        DRV_LOG(DEBUG, &quot;port %u MTU is %u&quot;, eth_dev-&gt;data-&gt;=
port_id,
                priv-&gt;mtu);
+       ethdev-&gt;data-&gt;mtu =3D priv-&gt;mtu;
        /* Initialize burst functions to prevent crashes before link-up. */
        eth_dev-&gt;rx_pkt_burst =3D rte_eth_pkt_burst_dummy;
        eth_dev-&gt;tx_pkt_burst =3D rte_eth_pkt_burst_dummy;
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
?id=3D1768">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17549478040.db3DB2cC.3272312--
