Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78387ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E72F9410D2;
	Wed, 11 Feb 2026 19:14:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5764E40ECF
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833645; x=1802369645;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5GhcrJCuzFfJxGxpNb94bhGzKDYWMXYe9NzR3Ogs9z0=;
 b=jV+/s6s7eEtiu5ve3K2sDUSdgSnnyZpzbWO8wF8KynDLtqhD9G4ila3r
 5Y9+vzpVbaZnvcTtERd28rH982/OJV7p8Xow315GAfr28vRQfM0YyLHZh
 cWtS5T7XgGfliGZOzE9O7MPdGxlYQDxzxANynjJWKFdNyZ96MHVYFIXj+
 4L90Uo1ea2g8Je2BnviX+zqm7M6jpxI7WWOYcc/EYvQnuGS1IjvFNFwSS
 /0sRRQdbCy3TSe0WqkiyjIr1ZF1Vh8xAnuM6KQohPO5UPwPAYDNUkjNCc
 515a0vkED4cixiN++I8R47tGQmYEaQkoANb1qYX9c8KaBt1Z1/FJUR37C g==;
X-CSE-ConnectionGUID: mNZUSP/XSP6O/7TY+ZZVXg==
X-CSE-MsgGUID: LC7cBkp3S+yRmsn7FuJ+0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834700"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:14:05 -0800
X-CSE-ConnectionGUID: yoxzTMSdRMmXst6S9A6/0Q==
X-CSE-MsgGUID: 5uRdy+UXRfqSNF5glcFNFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986395"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:14:04 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 29/35] net/intel: complete merging simple Tx paths
Date: Wed, 11 Feb 2026 18:12:58 +0000
Message-ID: <20260211181309.2838042-30-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 87 ++++++++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c   | 74 +----------------------
 drivers/net/intel/ice/ice_rxtx.c     | 74 +----------------------
 3 files changed, 89 insertions(+), 146 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index a85be8bbb7..ca25a2fc9d 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
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
  *
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 6b8d9fd70e..bedc78b9ff 100644
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
index a3a94033bf..2b82a16422 100644
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

