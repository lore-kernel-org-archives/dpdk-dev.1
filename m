Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E8606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 18:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81E4640A89;
	Mon, 19 Oct 2026 20:35:15 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A91B640A6D
 for <dev@dpdk.org>; Mon, 19 Oct 2026 20:34:59 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E238200023;
 Mon, 19 Oct 2026 20:34:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A02F200003;
 Mon, 19 Oct 2026 20:34:59 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 079DC18000B1;
 Tue, 20 Oct 2026 02:34:57 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v13-S2 10/10] net/dpaa2: rename Rx queue flags
Date: Tue, 20 Oct 2026 00:04:43 +0530
Message-ID: <20261019183443.176790-11-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
References: <20261016070339.3011744-1-prashant.gupta_3@nxp.com>
 <20261019183443.176790-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Rename the Rx-side device flags to a consistent DPAA2_RX_*_FLAG naming:
DPAAX_RX_ERROR_QUEUE_FLAG becomes DPAA2_RX_ERROR_QUEUE_FLAG and
DPAA2_DATA_STASHING_OFF becomes DPAA2_RX_DATA_STASHING_OFF_FLAG.

This is a mechanical rename with no functional change.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 10 +++++-----
 drivers/net/dpaa2/dpaa2_ethdev.h |  4 ++--
 drivers/net/dpaa2/dpaa2_rxtx.c   |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 72b37a988d..6afd641709 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -551,7 +551,7 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 			goto fail;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) {
 		priv->rx_err_vq = rte_zmalloc("dpni_rx_err",
 			sizeof(struct dpaa2_queue), 0);
 		if (!priv->rx_err_vq) {
@@ -1042,7 +1042,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		options |= DPNI_QUEUE_OPT_FLC;
 		cfg.flc.stash_control = true;
 		dpaa2_flc_stashing_clear_all(&cfg.flc.value);
-		if (priv->flags & DPAA2_DATA_STASHING_OFF) {
+		if (priv->flags & DPAA2_RX_DATA_STASHING_OFF_FLAG) {
 			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
 				&cfg.flc.value);
 			dpaa2_q->data_stashing_off = 1;
@@ -1522,7 +1522,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		dpaa2_q->fqid = qid.fqid;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) {
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
 				     DPNI_QUEUE_RX_ERR, 0, 0, &cfg, &qid);
 		if (ret) {
@@ -3476,7 +3476,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_DATA_STASHING) ||
 	    getenv("DPAA2_DATA_STASHING_OFF")) {
-		priv->flags |= DPAA2_DATA_STASHING_OFF;
+		priv->flags |= DPAA2_RX_DATA_STASHING_OFF_FLAG;
 		DPAA2_PMD_INFO("Data stashing disabled");
 	}
 
@@ -3580,7 +3580,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_ERROR_QUEUE)) {
-		priv->flags |= DPAAX_RX_ERROR_QUEUE_FLAG;
+		priv->flags |= DPAA2_RX_ERROR_QUEUE_FLAG;
 		DPAA2_PMD_INFO("Enable error queue");
 	}
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index b48c0d7cf2..12af00cc3c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -98,9 +98,9 @@
 #define DPAA2_TX_DYNAMIC_CONF_ENABLE	RTE_BIT32(9)
 
 /* Disable data stashing (prefetch of packet data into CPU cache) */
-#define DPAA2_DATA_STASHING_OFF		RTE_BIT32(10)
+#define DPAA2_RX_DATA_STASHING_OFF_FLAG		RTE_BIT32(10)
 
-#define DPAAX_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
+#define DPAA2_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
 
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index c2c581f69b..df3eefc134 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -829,7 +829,7 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 	if (!by_channel) {
 		struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
-		if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+		if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
 			dump_err_pkts(priv->rx_err_vq);
 	}
 
@@ -1094,7 +1094,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
-	if (!by_channel && unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+	if (!by_channel && unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
 		dump_err_pkts(priv->rx_err_vq);
 
 	if (by_channel) {
-- 
2.43.0

