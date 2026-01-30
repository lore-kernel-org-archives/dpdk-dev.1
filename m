Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD96E6BF01
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:45:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90A1240E36;
	Fri, 30 Jan 2026 12:43:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7BF3140661
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773378; x=1801309378;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XXIRW2AHSo4i24UrW8fdnHJdupy5A1WUECjbmrG7BW4=;
 b=P/O00drpuM1gU3qX0xwjp8h6fdN6CTMbzU87IY0QmWbW/KgdFGyPjWm7
 DyhFguRTvoghRxSnK1Y6Zi6nRCTG1pXFO8WaJOQM0rRtjXCqeyLEYLB01
 j2MpLcXEcXTQQ5b0eHyKP0k9R7qoILLNNGaTDYyiBnAl4HFyrpOwkJYxf
 1ujFOt/xbBhFwkdmGsKRy6rYENhnku2yofupvrlyCZsiGx36V/5yUWyj3
 7G6ENEWCxa1ZiRu6KIqXS8TNzEi2mhsFRmZvuExKOh9JZKRym7iSciC6i
 YrbQryiMY/3C1FkIiob5xzy8u8AdKrITsVqPM0vtM4KYhCGSBtmmDAt+Z g==;
X-CSE-ConnectionGUID: He8YV5YwTJy4qoxalgnm0w==
X-CSE-MsgGUID: t1MKcunlSg+biUpvTRX4MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392339"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392339"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:57 -0800
X-CSE-ConnectionGUID: wbFqImmwQnuu4HKr5pBcLQ==
X-CSE-MsgGUID: 5H8UfYSwRp+4YRFEJxiO9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190579"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:56 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 31/36] net/intel: complete merging simple Tx paths
Date: Fri, 30 Jan 2026 11:41:58 +0000
Message-ID: <20260130114207.1126032-32-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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

Complete the deduplication/merger of the ice and i40e Tx simple scalar
paths.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 87 ++++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c       | 74 +-------------------
 drivers/net/intel/ice/ice_rxtx.c         | 74 +-------------------
 3 files changed, 89 insertions(+), 146 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 185fcdfa72..5c4f09c197 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -130,6 +130,93 @@ ci_tx_free_bufs(struct ci_tx_queue *txq)
 	return rs_thresh;
 }
 
+/* Simple burst transmit for descriptor-based simple Tx path
+ *
+ * Transmits a burst of packets by filling hardware descriptors with mbuf
+ * data. Handles ring wrap-around and RS bit management. Performs descriptor
+ * cleanup when tx_free_thresh is reached.
+ *
+ * Returns: number of packets transmitted
+ */
+static inline uint16_t
+ci_xmit_burst_simple(struct ci_tx_queue *txq,
+		     struct rte_mbuf **tx_pkts,
+		     uint16_t nb_pkts)
+{
+	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
+	uint16_t n = 0;
+
+	/**
+	 * Begin scanning the H/W ring for done descriptors when the number
+	 * of available descriptors drops below tx_free_thresh. For each done
+	 * descriptor, free the associated buffer.
+	 */
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs(txq);
+
+	/* Use available descriptor only */
+	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
+	if (unlikely(!nb_pkts))
+		return 0;
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
+	if ((txq->tx_tail + nb_pkts) > txq->nb_tx_desc) {
+		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
+		ci_tx_fill_hw_ring(txq, tx_pkts, n);
+		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) <<
+					  CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+		txq->tx_tail = 0;
+	}
+
+	/* Fill hardware descriptor ring with mbuf data */
+	ci_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
+	txq->tx_tail = (uint16_t)(txq->tx_tail + (nb_pkts - n));
+
+	/* Determine if RS bit needs to be set */
+	if (txq->tx_tail > txq->tx_next_rs) {
+		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) <<
+					  CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+		if (txq->tx_next_rs >= txq->nb_tx_desc)
+			txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+	}
+
+	if (txq->tx_tail >= txq->nb_tx_desc)
+		txq->tx_tail = 0;
+
+	/* Update the tx tail register */
+	rte_write32_wc((uint32_t)txq->tx_tail, txq->qtx_tail);
+
+	return nb_pkts;
+}
+
+static __rte_always_inline uint16_t
+ci_xmit_pkts_simple(struct ci_tx_queue *txq,
+		     struct rte_mbuf **tx_pkts,
+		     uint16_t nb_pkts)
+{
+	uint16_t nb_tx = 0;
+
+	if (likely(nb_pkts <= CI_TX_MAX_BURST))
+		return ci_xmit_burst_simple(txq, tx_pkts, nb_pkts);
+
+	while (nb_pkts) {
+		uint16_t ret, num = RTE_MIN(nb_pkts, CI_TX_MAX_BURST);
+
+		ret = ci_xmit_burst_simple(txq, &tx_pkts[nb_tx], num);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
 /*
  * Common transmit descriptor cleanup function for Intel drivers.
  * Used by ice, i40e, iavf, and idpf drivers.
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 395808ff7c..b286e89b1b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1010,84 +1010,12 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			get_context_desc, NULL, NULL);
 }
 
-static inline uint16_t
-tx_xmit_pkts(struct ci_tx_queue *txq,
-	     struct rte_mbuf **tx_pkts,
-	     uint16_t nb_pkts)
-{
-	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
-	uint16_t n = 0;
-
-	/**
-	 * Begin scanning the H/W ring for done descriptors when the number
-	 * of available descriptors drops below tx_free_thresh. For each done
-	 * descriptor, free the associated buffer.
-	 */
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs(txq);
-
-	/* Use available descriptor only */
-	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	if (unlikely(!nb_pkts))
-		return 0;
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-	if ((txq->tx_tail + nb_pkts) > txq->nb_tx_desc) {
-		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
-		ci_tx_fill_hw_ring(txq, tx_pkts, n);
-		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-		txq->tx_tail = 0;
-	}
-
-	/* Fill hardware descriptor ring with mbuf data */
-	ci_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
-	txq->tx_tail = (uint16_t)(txq->tx_tail + (nb_pkts - n));
-
-	/* Determine if RS bit needs to be set */
-	if (txq->tx_tail > txq->tx_next_rs) {
-		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-		if (txq->tx_next_rs >= txq->nb_tx_desc)
-			txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-	}
-
-	if (txq->tx_tail >= txq->nb_tx_desc)
-		txq->tx_tail = 0;
-
-	/* Update the tx tail register */
-	I40E_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
 static uint16_t
 i40e_xmit_pkts_simple(void *tx_queue,
 		      struct rte_mbuf **tx_pkts,
 		      uint16_t nb_pkts)
 {
-	uint16_t nb_tx = 0;
-
-	if (likely(nb_pkts <= CI_TX_MAX_BURST))
-		return tx_xmit_pkts((struct ci_tx_queue *)tx_queue,
-						tx_pkts, nb_pkts);
-
-	while (nb_pkts) {
-		uint16_t ret, num = (uint16_t)RTE_MIN(nb_pkts,
-						CI_TX_MAX_BURST);
-
-		ret = tx_xmit_pkts((struct ci_tx_queue *)tx_queue,
-						&tx_pkts[nb_tx], num);
-		nb_tx = (uint16_t)(nb_tx + ret);
-		nb_pkts = (uint16_t)(nb_pkts - ret);
-		if (ret < num)
-			break;
-	}
-
-	return nb_tx;
+	return ci_xmit_pkts_simple(tx_queue, tx_pkts, nb_pkts);
 }
 
 #ifndef RTE_ARCH_X86
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c1477f3e87..eae57a08fc 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3245,84 +3245,12 @@ ice_tx_done_cleanup(void *txq, uint32_t free_cnt)
 		return ice_tx_done_cleanup_full(q, free_cnt);
 }
 
-static inline uint16_t
-tx_xmit_pkts(struct ci_tx_queue *txq,
-	     struct rte_mbuf **tx_pkts,
-	     uint16_t nb_pkts)
-{
-	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
-	uint16_t n = 0;
-
-	/**
-	 * Begin scanning the H/W ring for done descriptors when the number
-	 * of available descriptors drops below tx_free_thresh. For each done
-	 * descriptor, free the associated buffer.
-	 */
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs(txq);
-
-	/* Use available descriptor only */
-	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	if (unlikely(!nb_pkts))
-		return 0;
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-	if ((txq->tx_tail + nb_pkts) > txq->nb_tx_desc) {
-		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
-		ci_tx_fill_hw_ring(txq, tx_pkts, n);
-		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-		txq->tx_tail = 0;
-	}
-
-	/* Fill hardware descriptor ring with mbuf data */
-	ci_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
-	txq->tx_tail = (uint16_t)(txq->tx_tail + (nb_pkts - n));
-
-	/* Determine if RS bit needs to be set */
-	if (txq->tx_tail > txq->tx_next_rs) {
-		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-		if (txq->tx_next_rs >= txq->nb_tx_desc)
-			txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-	}
-
-	if (txq->tx_tail >= txq->nb_tx_desc)
-		txq->tx_tail = 0;
-
-	/* Update the tx tail register */
-	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
 static uint16_t
 ice_xmit_pkts_simple(void *tx_queue,
 		     struct rte_mbuf **tx_pkts,
 		     uint16_t nb_pkts)
 {
-	uint16_t nb_tx = 0;
-
-	if (likely(nb_pkts <= CI_TX_MAX_BURST))
-		return tx_xmit_pkts((struct ci_tx_queue *)tx_queue,
-				    tx_pkts, nb_pkts);
-
-	while (nb_pkts) {
-		uint16_t ret, num = (uint16_t)RTE_MIN(nb_pkts,
-						      CI_TX_MAX_BURST);
-
-		ret = tx_xmit_pkts((struct ci_tx_queue *)tx_queue,
-				   &tx_pkts[nb_tx], num);
-		nb_tx = (uint16_t)(nb_tx + ret);
-		nb_pkts = (uint16_t)(nb_pkts - ret);
-		if (ret < num)
-			break;
-	}
-
-	return nb_tx;
+	return ci_xmit_pkts_simple(tx_queue, tx_pkts, nb_pkts);
 }
 
 static const struct ci_rx_path_info ice_rx_path_infos[] = {
-- 
2.51.0

