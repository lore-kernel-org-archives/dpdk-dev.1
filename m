Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B0C021AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 08:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 491F94111C;
	Wed, 19 Feb 2025 08:58:17 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id E210640E4D
 for <dev@dpdk.org>; Wed, 19 Feb 2025 08:58:04 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 4920AA3250; Wed, 19 Feb 2025 15:58:04 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v13 28/28] net/rnp: support Rx/Tx burst mode info
Date: Wed, 19 Feb 2025 15:57:29 +0800
Message-Id: <1739951849-67601-29-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
References: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
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

add platform method for get rx/tx burst function select
by upload func name.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_ethdev.c |  2 ++
 drivers/net/rnp/rnp_rxtx.c   | 58 ++++++++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h   |  6 ++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index e2d4224297..8f019869d4 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1489,6 +1489,8 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.tx_queue_release             = rnp_dev_tx_queue_release,
 	.rxq_info_get                 = rnp_rx_queue_info_get,
 	.txq_info_get                 = rnp_tx_queue_info_get,
+	.rx_burst_mode_get            = rnp_rx_burst_mode_get,
+	.tx_burst_mode_get            = rnp_tx_burst_mode_get,
 	/* rss impl */
 	.reta_update                  = rnp_dev_rss_reta_update,
 	.reta_query                   = rnp_dev_rss_reta_query,
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index d5281a75a6..0112a07d1a 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1758,3 +1758,61 @@ rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	qinfo->conf.tx_thresh.hthresh = txq->pburst;
 	qinfo->conf.offloads = txq->tx_offloads;
 }
+
+static const struct {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+} rnp_rx_burst_infos[] = {
+	{ rnp_scattered_rx,		"Scalar Scattered" },
+	{ rnp_recv_pkts,		"Scalar" },
+};
+
+static const struct {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+} rnp_tx_burst_infos[] = {
+	{ rnp_xmit_simple,		"Scalar Simple" },
+	{ rnp_multiseg_xmit_pkts,	"Scalar" },
+};
+
+int
+rnp_rx_burst_mode_get(struct rte_eth_dev *dev,
+		      __rte_unused uint16_t queue_id,
+		      struct rte_eth_burst_mode *mode)
+{
+	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
+	int ret = -EINVAL;
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(rnp_rx_burst_infos); ++i) {
+		if (pkt_burst == rnp_rx_burst_infos[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+					rnp_rx_burst_infos[i].info);
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int
+rnp_tx_burst_mode_get(struct rte_eth_dev *dev,
+		      __rte_unused uint16_t queue_id,
+		      struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
+	int ret = -EINVAL;
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(rnp_tx_burst_infos); ++i) {
+		if (pkt_burst == rnp_tx_burst_infos[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+					rnp_tx_burst_infos[i].info);
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index dc4a8ea9dd..8639f0892d 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -152,5 +152,11 @@ void rnp_rx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_rxq_info *qinfo);
 void rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 			   struct rte_eth_txq_info *qinfo);
+int rnp_rx_burst_mode_get(struct rte_eth_dev *dev,
+			  __rte_unused uint16_t queue_id,
+			  struct rte_eth_burst_mode *mode);
+int rnp_tx_burst_mode_get(struct rte_eth_dev *dev,
+			  __rte_unused uint16_t queue_id,
+			  struct rte_eth_burst_mode *mode);
 
 #endif /* _RNP_RXTX_H_ */
-- 
2.25.1

