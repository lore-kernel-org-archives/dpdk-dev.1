Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E6DFD9E26
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 02:00:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 181DD406BC;
	Fri, 27 Feb 2026 02:59:51 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4D15A4066B;
 Fri, 27 Feb 2026 02:59:44 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id A8D0920B6F03; Thu, 26 Feb 2026 17:59:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8D0920B6F03
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v5 5/7] net/mana: fix fast-path ops setup in secondary process
Date: Thu, 26 Feb 2026 17:59:25 -0800
Message-ID: <20260227015928.14338-6-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260227015928.14338-1-longli@microsoft.com>
References: <20260227015928.14338-1-longli@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On hotplug, the secondary process is not able to set rte_eth_fp_ops
because the primary process has not finished setting up the device
for datapath.

Fix this by properly setting up rte_eth_fp_ops in the secondary
process when the primary requests to start datapath. Set both
rxq.data and txq.data to point to the device's RX/TX queue arrays,
enabling the fast-path operations to access queues correctly.

Also update rte_eth_fp_ops burst function pointers in the STOP_RXTX
handler. Without this, the secondary's rte_eth_fp_ops retains stale
burst function pointers after stop, since rte_eth_fp_ops is
process-local and eth_dev_fp_ops_reset() in rte_eth_dev_stop() only
affects the primary.

Without this fix, the secondary process cannot transmit or receive
packets because the fast-path queue data pointers are NULL.

Fixes: 62724d1a3981 ("net/mana: start/stop device")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c
index 5467d385ce..72417fc0c7 100644
--- a/drivers/net/mana/mp.c
+++ b/drivers/net/mana/mp.c
@@ -145,6 +145,11 @@ mana_mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 		dev->tx_pkt_burst = mana_tx_burst;
 		dev->rx_pkt_burst = mana_rx_burst;
 
+		rte_eth_fp_ops[param->port_id].rx_pkt_burst = mana_rx_burst;
+		rte_eth_fp_ops[param->port_id].tx_pkt_burst = mana_tx_burst;
+		rte_eth_fp_ops[param->port_id].rxq.data = dev->data->rx_queues;
+		rte_eth_fp_ops[param->port_id].txq.data = dev->data->tx_queues;
+
 		rte_mb();
 
 		res->result = 0;
@@ -154,6 +159,9 @@ mana_mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 	case MANA_MP_REQ_STOP_RXTX:
 		DRV_LOG(INFO, "Port %u stopping datapath", dev->data->port_id);
 
+		rte_eth_fp_ops[param->port_id].rx_pkt_burst = mana_rx_burst_removed;
+		rte_eth_fp_ops[param->port_id].tx_pkt_burst = mana_tx_burst_removed;
+
 		dev->tx_pkt_burst = mana_tx_burst_removed;
 		dev->rx_pkt_burst = mana_rx_burst_removed;
 
-- 
2.43.0

