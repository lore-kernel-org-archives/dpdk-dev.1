Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA97E98DFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 07:58:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 374EF4066E;
	Mon, 23 Feb 2026 08:58:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5145D40150;
 Sat, 21 Feb 2026 03:45:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id C99B620B6F03; Fri, 20 Feb 2026 18:45:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C99B620B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771641948;
 bh=5RBm0nhVkH2eH5gBQn6cJaM2XG/uz3Z7o7NNfY5px28=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ru+ELQCmaJrwtq5Go8NPznbtnLnSDqHrCK2ad+A5JtRDNwj82ujIdhZPPOEFhoWwF
 oWQzq2mOxx5BuYHqv666LI6DmZU9Ntud1Y277wEkVXEw2PtIS+SRkGYKFL6X+bHbSE
 pkIa6+p6AxtTJ3gCstuBkhTkCqAZOiVY5ApmpVrQ=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v2 8/8] net/mlx4: fix fast-path ops setup in secondary process
Date: Fri, 20 Feb 2026 18:45:27 -0800
Message-ID: <20260221024540.659098-8-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260221024540.659098-1-longli@linux.microsoft.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:57:51 +0100
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

From: Long Li <longli@microsoft.com>

The secondary process MLX4_MP_REQ_START_RXTX handler sets
dev->rx_pkt_burst and dev->tx_pkt_burst, but does not update
rte_eth_fp_ops[].rxq.data and txq.data. Since rte_eth_rx_burst()
uses rte_eth_fp_ops (which is process-local), the secondary
retains stale queue data pointers after VF hot-add, causing a
segfault.

Similarly, the MLX4_MP_REQ_STOP_RXTX handler sets dev burst
functions to dummy but does not update rte_eth_fp_ops burst
pointers, leaving the secondary calling into freed resources.

Fix by updating rte_eth_fp_ops rxq.data and txq.data in the
START_RXTX handler, and rte_eth_fp_ops burst function pointers
in the STOP_RXTX handler.

Fixes: 080d8bc15905 ("net/mlx4: sync stop/start with secondary process")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mlx4/mlx4_mp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mlx4/mlx4_mp.c b/drivers/net/mlx4/mlx4_mp.c
index 534cb31151..00ecadee79 100644
--- a/drivers/net/mlx4/mlx4_mp.c
+++ b/drivers/net/mlx4/mlx4_mp.c
@@ -149,6 +149,8 @@ mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 		}
 #endif
 		close(mp_msg->fds[0]);
+		rte_eth_fp_ops[param->port_id].rxq.data = dev->data->rx_queues;
+		rte_eth_fp_ops[param->port_id].txq.data = dev->data->tx_queues;
 		rte_mb();
 		mp_init_msg(dev, &mp_res, param->type);
 		res->result = 0;
@@ -158,6 +160,8 @@ mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 		INFO("port %u stopping datapath", dev->data->port_id);
 		dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
 		dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
+		rte_eth_fp_ops[param->port_id].rx_pkt_burst = rte_eth_pkt_burst_dummy;
+		rte_eth_fp_ops[param->port_id].tx_pkt_burst = rte_eth_pkt_burst_dummy;
 		rte_mb();
 		mp_init_msg(dev, &mp_res, param->type);
 		res->result = 0;
-- 
2.43.0

