Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D6C5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:27:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57A7340E2A;
	Fri,  7 Aug 2026 13:26:44 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 797144027E
 for <dev@dpdk.org>; Fri,  7 Aug 2026 13:26:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 61C451A0124;
 Fri,  7 Aug 2026 13:26:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 29F8E1A011E;
 Fri,  7 Aug 2026 13:26:31 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A82EC1800088;
 Fri,  7 Aug 2026 19:26:30 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 14/14] net/enetc4: add WRR Tx scheduler devarg for VF rings
Date: Fri,  7 Aug 2026 16:56:23 +0530
Message-Id: <20260807112623.1402493-15-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807112623.1402493-1-g.singh@nxp.com>
References: <20260807070241.1151161-1-g.singh@nxp.com>
 <20260807112623.1402493-1-g.singh@nxp.com>
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
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/base/enetc_hw.h      |  5 ++
 drivers/net/enetc/enetc.h              |  1 +
 drivers/net/enetc/enetc4_ethdev.c      | 97 ++++++++++++++++++++------
 4 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d69888aafb..3ea34523fe 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -73,6 +73,7 @@ New Features
   * Added SI-based port VLAN insertion (Tx) and removal (Rx) for ENETC4 PF and VF.
   * Updated ENETC4 VF link status reporting to use bitmask encoding.
   * Added TX PAUSE support for the ENETC4 VF via RX congestion mode.
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
index 8aaf8a7eb1..e0943d093a 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -134,6 +134,7 @@ struct enetc_eth_hw {
 	uint32_t vsi_timeout; /* VSI-PSI message wait timeout (iterations) */
 	uint32_t vsi_delay;   /* VSI-PSI message wait delay (us) */
 	uint32_t *txq_prior;  /* per-queue TX priority (TBMR priority bits) */
+	uint32_t *txq_wrr;    /* per-queue TX WRR weight pre-shifted for TBMR[WRR] */
 	uint8_t nc_mode;      /* 1 = non-cacheable BD memory, use _nc ops */
 	uint8_t rxq_intr_en;  /* 1 = per-queue Rx MSI-X interrupts enabled */
 	/* 1 = legacy PF-to-VF link message layout (4-bit speed / 4-bit cookie),
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 2355522515..e490ecaf4c 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -28,22 +28,26 @@ static uint64_t dev_tx_offloads_sup =
 	RTE_ETH_TX_OFFLOAD_UDP_TSO;
 
 #define ENETC4_TXQ_PRIORITIES	"enetc4_txq_prior"
+#define ENETC4_TXQ_WRR		"enetc4_txq_wrr"
 #define ENETC4_NC_MEMORY	"nc"
 
+
 static int
 parse_txq_prior(const char *key __rte_unused, const char *value, void *opaque)
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
-		return -ENOMEM;
+		return -1;
 
-	hw->txq_prior = calloc(hw->max_tx_queues, sizeof(uint32_t));
+	rte_free(hw->txq_prior);
+	hw->txq_prior = rte_zmalloc(NULL, hw->max_tx_queues * sizeof(uint32_t), 0);
 	if (!hw->txq_prior) {
 		free(input_str);
 		return -ENOMEM;
@@ -51,7 +55,46 @@ parse_txq_prior(const char *key __rte_unused, const char *value, void *opaque)
 
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
+		return -1;
+
+	rte_free(hw->txq_wrr);
+	hw->txq_wrr = rte_zmalloc(NULL,
+			hw->max_tx_queues * sizeof(uint32_t), 0);
+	if (!hw->txq_wrr) {
+		free(input_str);
+		return -1;
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
 
@@ -97,6 +140,13 @@ enetc4_get_devargs(struct rte_eth_dev *dev, const char *key)
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
@@ -109,19 +159,6 @@ enetc4_get_devargs(struct rte_eth_dev *dev, const char *key)
 	return 0;
 }
 
-/* Supported Rx offloads */
-static uint64_t dev_rx_offloads_sup =
-	RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
-	RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
-	RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
-	RTE_ETH_RX_OFFLOAD_SCATTER;
-
-/* Supported Tx offloads */
-static uint64_t dev_tx_offloads_sup =
-	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
-	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
-	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
-	RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 static int
 enetc4_dev_start(struct rte_eth_dev *dev)
@@ -458,7 +495,9 @@ enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 
 		/* apply TX queue priority if configured */
 		if (priv->hw.txq_prior)
-			tx_en |= priv->hw.txq_prior[tx_ring->index];
+			tx_data |= priv->hw.txq_prior[tx_ring->index];
+		if (priv->hw.txq_wrr)
+			tx_data |= priv->hw.txq_wrr[tx_ring->index];
 		/* enable ring */
 		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index,
 			       ENETC_TBMR, tx_en);
@@ -613,7 +652,6 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	struct enetc_eth_adapter *adapter =
 			ENETC_DEV_PRIVATE(data->dev_private);
 	uint64_t rx_offloads = data->dev_conf.rxmode.offloads;
-	uint32_t rx_enable;
 	uint32_t rsc_size;
 	bool keep_crc;
 	bool rsc_enable;
@@ -869,7 +907,10 @@ enetc4_dev_close(struct rte_eth_dev *dev)
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
 
@@ -1020,6 +1061,11 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
 		enetc4_rxbdr_wr(enetc_hw, i, ENETC_TBMR, ENETC_BMR_RESET);
 
+	hw->nc_mode = 0;
+	enetc4_get_devargs(dev, ENETC4_TXQ_PRIORITIES);
+	enetc4_get_devargs(dev, ENETC4_TXQ_WRR);
+	enetc4_get_devargs(dev, ENETC4_NC_MEMORY);
+
 	if (dev->data->nb_rx_queues <= 1)
 		return 0;
 
@@ -1142,7 +1188,13 @@ enetc4_tx_queue_start(struct rte_eth_dev *dev, uint16_t qidx)
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
@@ -1457,5 +1509,6 @@ RTE_PMD_REGISTER_PCI_TABLE(net_enetc4, pci_id_enetc4_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_enetc4, "* vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_enetc4,
 			      ENETC4_TXQ_PRIORITIES "=<string> "
+			      ENETC4_TXQ_WRR "=<string> "
 			      ENETC4_NC_MEMORY "=<int>");
 RTE_LOG_REGISTER_DEFAULT(enetc4_logtype_pmd, NOTICE);
-- 
2.25.1

