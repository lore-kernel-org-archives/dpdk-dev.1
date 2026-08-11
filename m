Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F4C5B574
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 07:49:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDD3242794;
	Tue, 11 Aug 2026 09:48:03 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id B7BDE40ED3
 for <dev@dpdk.org>; Tue, 11 Aug 2026 09:47:50 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E85220018B;
 Tue, 11 Aug 2026 09:47:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68EC3200194;
 Tue, 11 Aug 2026 09:47:50 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E99D318000B6;
 Tue, 11 Aug 2026 15:47:49 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v7 14/14] net/enetc4: add WRR Tx scheduler devarg for VF rings
Date: Tue, 11 Aug 2026 13:17:45 +0530
Message-Id: <20260811074745.3655334-15-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811074745.3655334-1-g.singh@nxp.com>
References: <20260811074032.3646324-1-g.singh@nxp.com>
 <20260811074745.3655334-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add enetc4_txq_wrr devarg to configure per-ring WRR weights in the
NETC LEAF-level Tx scheduler (TBaMR register, bits [6:4]).

The NETC Tx scheduler has three levels:
  - ROOT (port/TC): strict priority + CBS (PF/port space)
  - MID  (SI/VSI):  WBFS shaping (PF space)
  - LEAF (Tx BDR):  strict priority + frame-based WRR (VF/SI space)

TBaMR is in the VF own SI space, so no Linux PF involvement is
needed for PRIO or WRR configuration.

Changes:
- enetc_hw.h: add ENETC_TBMR_WRR_MASK, ENETC_TBMR_WRR(n) macros for
  TBaMR bits [6:4], and ENETC_TBMR_PRIO_MASK for bits [2:0]
- enetc.h: add txq_wrr pointer to enetc_eth_hw struct
- enetc4_ethdev.c: add parse_txq_wrr() and wire ENETC4_TXQ_WRR devarg
  through enetc4_get_devargs() and enetc4_dev_configure(); apply WRR
  bits in enetc4_tx_queue_setup() and enetc4_tx_queue_start()

Usage:
  # strict priority: ring 0 highest
  -a 0002:00:12.0,enetc4_txq_prior="3|2|1"

  # WRR 2:4:1 on same-priority rings
  -a 0002:00:12.0,enetc4_txq_prior="1|1|1",enetc4_txq_wrr="2|4|1"

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/enetc4.rst             | 12 ++++
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/base/enetc_hw.h      |  5 ++
 drivers/net/enetc/enetc.h              |  1 +
 drivers/net/enetc/enetc4_ethdev.c      | 88 +++++++++++++++++++++-----
 5 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index 262e2fe703..7399a416d3 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -166,6 +166,18 @@ PF/Common devargs
 
     dpdk-testpmd -a 0000:00:00.0,enetc4_txq_prior=1|2|3 -- -i
 
+``enetc4_txq_wrr``
+  Set per-queue WRR weight for the LEAF-level Tx scheduler (TBaMR bits [6:4]).
+  The value is a ``|``-separated list of WRR weights, one per Tx queue.
+  Meaningful only when the corresponding queues share the same strict-priority
+  level via ``enetc4_txq_prior``; queues with different priorities are
+  scheduled strictly regardless of their WRR weight.
+  Values beyond the maximum supported Tx queue count are discarded.
+
+  Usage example (WRR 2:4:1 on three equal-priority rings)::
+
+    dpdk-testpmd -a 0000:00:00.0,enetc4_txq_prior="1|1|1",enetc4_txq_wrr="2|4|1" -- -i
+
 ``nc``
   Select non-cacheable Rx/Tx ops (BD rings mapped as non-cacheable memory).
   Set to ``1`` to use non-cacheable descriptor ring operations.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index f287390db7..2be5357af3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -75,6 +75,7 @@ New Features
   * Added SI-based port VLAN insertion (Tx) and removal (Rx) for ENETC4 PF and VF.
   * Updated ENETC4 VF link status reporting to use bitmask encoding.
   * Added Tx PAUSE support for the ENETC4 VF via Rx congestion mode.
+  * Added WRR Tx scheduler devarg (``enetc4_txq_wrr``) for ENETC4 VF ring weights.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 33d075fe59..5a71f01db9 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -86,6 +86,11 @@ enum enetc_bdr_type {TX, RX};
 
 #define ENETC_RTBLENR_LEN(n)		((n) & ~0x7)
 #define ENETC_TBMR_EN			BIT(31)
+/* TBaMR[WRR] bits [6:4]: weight for same-priority ring arbitration (0=1x .. 7=8x). */
+#define ENETC_TBMR_WRR_MASK		GENMASK(6, 4)
+#define ENETC_TBMR_WRR(n)		((((n) - 1) & 0x7) << 4)
+/* TBaMR[PRIO] bits [2:0]: strict priority (0=lowest, 7=highest). */
+#define ENETC_TBMR_PRIO_MASK		GENMASK(2, 0)
 
 /* Port regs, offset: 1_0000h */
 #define ENETC_PORT_BASE			0x10000
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 7f67b2a0b3..f6a69b3cf7 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -135,6 +135,7 @@ struct enetc_eth_hw {
 	uint32_t vsi_timeout; /* VSI-PSI message wait timeout (iterations) */
 	uint32_t vsi_delay;   /* VSI-PSI message wait delay (us) */
 	uint32_t *txq_prior;  /* per-queue TX priority (TBMR priority bits) */
+	uint32_t *txq_wrr;    /* per-queue TX WRR weight pre-shifted for TBMR[WRR] */
 	uint8_t nc_mode;      /* 1 = non-cacheable BD memory, use _nc ops */
 	uint8_t rxq_intr_en;  /* 1 = per-queue Rx MSI-X interrupts enabled */
 	/* 1 = legacy PF-to-VF link message layout (4-bit speed / 4-bit cookie),
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index df22ad0c7b..82420aeeb7 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -30,6 +30,7 @@ static uint64_t dev_tx_offloads_sup =
 	RTE_ETH_TX_OFFLOAD_UDP_TSO;
 
 #define ENETC4_TXQ_PRIORITIES	"enetc4_txq_prior"
+#define ENETC4_TXQ_WRR		"enetc4_txq_wrr"
 #define ENETC4_NC_MEMORY	"nc"
 
 static int
@@ -37,15 +38,17 @@ parse_txq_prior(const char *key __rte_unused, const char *value, void *opaque)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)opaque;
 	struct enetc_eth_hw *hw =
-		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	char *input_str = strdup(value);
+				ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	char *input_str;
 	char *str;
 	uint32_t i = 0;
 
+	input_str = strdup(value);
 	if (!input_str)
 		return -ENOMEM;
 
-	hw->txq_prior = calloc(hw->max_tx_queues, sizeof(uint32_t));
+	rte_free(hw->txq_prior);
+	hw->txq_prior = rte_zmalloc(NULL, hw->max_tx_queues * sizeof(uint32_t), 0);
 	if (!hw->txq_prior) {
 		free(input_str);
 		return -ENOMEM;
@@ -53,7 +56,46 @@ parse_txq_prior(const char *key __rte_unused, const char *value, void *opaque)
 
 	str = strtok(input_str, "|");
 	while (str != NULL && i < hw->max_tx_queues) {
-		hw->txq_prior[i++] = (uint32_t)atoi(str);
+		hw->txq_prior[i++] = atoi(str) & ENETC_TBMR_PRIO_MASK;
+		str = strtok(NULL, "|");
+	}
+
+	free(input_str);
+	return 0;
+}
+
+/* Parse enetc4_txq_wrr="w0|w1|..." devarg; weight 1..8 per ring. */
+static int parse_txq_wrr(const char *key __rte_unused, const char *value,
+			  void *opaque)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)opaque;
+	struct enetc_eth_hw *hw =
+			ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	char *input_str;
+	char *str;
+	uint32_t i = 0;
+	int w;
+
+	input_str = strdup(value);
+	if (!input_str)
+		return -ENOMEM;
+
+	rte_free(hw->txq_wrr);
+	hw->txq_wrr = rte_zmalloc(NULL,
+			hw->max_tx_queues * sizeof(uint32_t), 0);
+	if (!hw->txq_wrr) {
+		free(input_str);
+		return -ENOMEM;
+	}
+
+	str = strtok(input_str, "|");
+	while (str != NULL && i < hw->max_tx_queues) {
+		w = atoi(str);
+		if (w < 1)
+			w = 1;
+		if (w > 8)
+			w = 8;
+		hw->txq_wrr[i++] = ENETC_TBMR_WRR(w);
 		str = strtok(NULL, "|");
 	}
 
@@ -99,6 +141,13 @@ enetc4_get_devargs(struct rte_eth_dev *dev, const char *key)
 			return 0;
 		}
 	}
+	if (!strcmp(key, ENETC4_TXQ_WRR)) {
+		if (rte_kvargs_process(kvlist, key,
+				       parse_txq_wrr, (void *)dev) < 0) {
+			rte_kvargs_free(kvlist);
+			return 0;
+		}
+	}
 	if (!strcmp(key, ENETC4_NC_MEMORY)) {
 		if (rte_kvargs_process(kvlist, key,
 				       parse_nc, (void *)dev) < 0) {
@@ -450,7 +499,9 @@ enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 
 		/* apply TX queue priority if configured */
 		if (priv->hw.txq_prior)
-			tx_en |= priv->hw.txq_prior[tx_ring->index];
+			tx_data |= priv->hw.txq_prior[tx_ring->index];
+		if (priv->hw.txq_wrr)
+			tx_data |= priv->hw.txq_wrr[tx_ring->index];
 		/* enable ring */
 		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index,
 			       ENETC_TBMR, tx_en);
@@ -873,7 +924,10 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 		dev->data->tx_queues[i] = NULL;
 	}
 	dev->data->nb_tx_queues = 0;
-
+	rte_free(hw->txq_prior);
+	hw->txq_prior = NULL;
+	rte_free(hw->txq_wrr);
+	hw->txq_wrr = NULL;
 	if (rte_eal_iova_mode() == RTE_IOVA_PA)
 		dpaax_iova_table_depopulate();
 
@@ -1024,6 +1078,11 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		enetc4_rxbdr_wr(enetc_hw, i, ENETC_TBMR, ENETC_BMR_RESET);
 
+	hw->nc_mode = 0;
+	enetc4_get_devargs(dev, ENETC4_TXQ_PRIORITIES);
+	enetc4_get_devargs(dev, ENETC4_TXQ_WRR);
+	enetc4_get_devargs(dev, ENETC4_NC_MEMORY);
+
 	if (dev->data->nb_rx_queues <= 1)
 		return 0;
 
@@ -1147,7 +1206,13 @@ enetc4_tx_queue_start(struct rte_eth_dev *dev, uint16_t qidx)
 	if (dev->data->tx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STOPPED) {
 		tx_data = enetc4_txbdr_rd(&priv->hw.hw, tx_ring->index,
 					 ENETC_TBMR);
-		tx_data = tx_data | ENETC_TBMR_EN;
+		/* Clear scheduler bits before applying fresh devarg values. */
+		tx_data &= ~(ENETC_TBMR_PRIO_MASK | ENETC_TBMR_WRR_MASK);
+		tx_data |= ENETC_TBMR_EN;
+		if (priv->hw.txq_prior)
+			tx_data |= priv->hw.txq_prior[tx_ring->index];
+		if (priv->hw.txq_wrr)
+			tx_data |= priv->hw.txq_wrr[tx_ring->index];
 		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index, ENETC_TBMR,
 			       tx_data);
 		dev->data->tx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STARTED;
@@ -1422,16 +1487,8 @@ enetc4_dev_init(struct rte_eth_dev *eth_dev)
 static int
 enetc4_dev_uninit(struct rte_eth_dev *eth_dev)
 {
-	struct enetc_eth_hw *hw =
-		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
-
 	PMD_INIT_FUNC_TRACE();
 
-	if (hw->txq_prior) {
-		free(hw->txq_prior);
-		hw->txq_prior = NULL;
-	}
-
 	return enetc4_dev_close(eth_dev);
 }
 
@@ -1462,5 +1519,6 @@ RTE_PMD_REGISTER_PCI_TABLE(net_enetc4, pci_id_enetc4_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_enetc4, "* vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_enetc4,
 			      ENETC4_TXQ_PRIORITIES "=<string> "
+			      ENETC4_TXQ_WRR "=<string> "
 			      ENETC4_NC_MEMORY "=<int>");
 RTE_LOG_REGISTER_DEFAULT(enetc4_logtype_pmd, NOTICE);
-- 
2.25.1

