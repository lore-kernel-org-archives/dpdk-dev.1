Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F77C021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 07:45:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15D9A40E17;
	Wed, 26 Feb 2025 08:43:03 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 1319640DCA
 for <dev@dpdk.org>; Wed, 26 Feb 2025 08:42:55 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 649BB54B9DE; Wed, 26 Feb 2025 15:42:54 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v16 28/29] net/rnp: support Rx/Tx burst mode info
Date: Wed, 26 Feb 2025 15:42:15 +0800
Message-Id: <1740555736-19894-29-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
References: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
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
 doc/guides/nics/rnp.rst      |  2 ++
 drivers/net/rnp/rnp_ethdev.c |  2 ++
 drivers/net/rnp/rnp_rxtx.c   | 58 ++++++++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h   |  6 ++++
 4 files changed, 68 insertions(+)

diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index c3e8d514d9..e9f96c4eb0 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -114,8 +114,10 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_allmulticast_get``
 * ``rte_eth_rx_queue_setup``
 * ``rte_eth_rx_queue_info_get``
+* ``rte_eth_rx_burst_mode_get``
 * ``rte_eth_tx_queue_setup``
 * ``rte_eth_tx_queue_info_get``
+* ``rte_eth_tx_burst_mode_get``
 * ``rte_eth_link_get``
 * ``rte_eth_link_get_nowait``
 * ``rte_eth_stats_get``
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 84ff746ecd..227dc8e4ca 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1481,11 +1481,13 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.rx_queue_stop                = rnp_rx_queue_stop,
 	.rx_queue_start               = rnp_rx_queue_start,
 	.rxq_info_get                 = rnp_rx_queue_info_get,
+	.rx_burst_mode_get            = rnp_rx_burst_mode_get,
 	.tx_queue_setup               = rnp_tx_queue_setup,
 	.tx_queue_release             = rnp_dev_tx_queue_release,
 	.tx_queue_stop                = rnp_tx_queue_stop,
 	.tx_queue_start               = rnp_tx_queue_start,
 	.txq_info_get                 = rnp_tx_queue_info_get,
+	.tx_burst_mode_get            = rnp_tx_burst_mode_get,
 	/* rss impl */
 	.reta_update                  = rnp_dev_rss_reta_update,
 	.reta_query                   = rnp_dev_rss_reta_query,
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index d58b0412ce..da08728198 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1762,3 +1762,61 @@ rnp_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
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

