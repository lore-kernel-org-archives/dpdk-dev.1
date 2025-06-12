Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C963CC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:13:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D40814278B;
	Thu, 12 Jun 2025 13:12:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B98794275A
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726739; x=1781262739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4L235uJPuEV4nHW42nFCZ4UE0H7mvvksDbtLvrEjYvg=;
 b=SPGd/5XpMV3NA71AMv6KqaofqMw6S9GRu8M8+A0ChnoOmjWkz6z+bIgA
 CQ2umjc0GjJsVc+6p5qM5zKNqB49HhqPZcZQiVkjjBjsWrT3e3MSiiRD/
 EXuDEP1uvloebj5s5UF6uwulW1qeoC55+JEhJxWFQc8cVczn8mKobdypa
 o4I5RodgledjDzIST0KWai18u3OBFENUwrm9Lt04kb8IeW6PfLpzL4BaG
 woLMvGYdOB8xr8LJ86VQ7rf8GAmTZO2iEWV+IDmKoWf1DnrpdXnyFiTay
 P23YY06DBlsrN3nqDYZASmlcOl8gQJHm0N8UvZO6W9fY3PW52wslwkhR6 Q==;
X-CSE-ConnectionGUID: 4wXFVbpWTuSY0qTJdNAj6w==
X-CSE-MsgGUID: plmH5jmlRUiWNTBsMUc1Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177558"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177558"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:18 -0700
X-CSE-ConnectionGUID: VUdrzcXGRAWrwgx/xvn35w==
X-CSE-MsgGUID: dRqLBc7cTFeHma/HeCizqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371347"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 14/33] net/ixgbe: refactor vector common code
Date: Thu, 12 Jun 2025 12:11:20 +0100
Message-ID: <d8d970bb8dfd817da2c556f11e0dcd3ac16a8780.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
References: 
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

Each vector driver provides its own Rx queue setup etc. functions, but
actually they're entirely identical, and can be merged. Rename the
`ixgbe_recycle_mbufs_vec_common.c` to `ixgbe_rxtx_vec_common.c` and move
all common code there from each respective vector driver.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Add this patch

 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   2 +
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |   4 -
 ...s_vec_common.c => ixgbe_rxtx_vec_common.c} | 137 +++++++++++++++++-
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   | 127 ++--------------
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  42 ------
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  42 ------
 drivers/net/intel/ixgbe/meson.build           |   4 +-
 7 files changed, 148 insertions(+), 210 deletions(-)
 rename drivers/net/intel/ixgbe/{ixgbe_recycle_mbufs_vec_common.c => ixgbe_rxtx_vec_common.c} (56%)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0b949c3cfc..79b3d4b71f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -52,6 +52,8 @@
 #include "base/ixgbe_common.h"
 #include "ixgbe_rxtx.h"
 
+#include "ixgbe_rxtx_vec_common.h"
+
 #ifdef RTE_LIBRTE_IEEE1588
 #define IXGBE_TX_IEEE1588_TMST RTE_MBUF_F_TX_IEEE1588_TMST
 #else
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index bcd5db87e8..cd0015be9c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -225,9 +225,6 @@ uint16_t ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
 uint16_t ixgbe_recv_scattered_pkts_vec(void *rx_queue,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
-int ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev);
-int ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq);
-void ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq);
 int ixgbe_dev_tx_done_cleanup(void *tx_queue, uint32_t free_cnt);
 
 extern const uint32_t ptype_table[IXGBE_PACKET_TYPE_MAX];
@@ -239,7 +236,6 @@ void ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs);
 
 uint16_t ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 				    uint16_t nb_pkts);
-int ixgbe_txq_vec_setup(struct ci_tx_queue *txq);
 
 uint64_t ixgbe_get_tx_port_offloads(struct rte_eth_dev *dev);
 uint64_t ixgbe_get_rx_queue_offloads(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
similarity index 56%
rename from drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
rename to drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index 2ab7abbf4e..be422ee238 100644
--- a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -1,12 +1,143 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (c) 2023 Arm Limited.
+ * Copyright (c) 2025 Intel Corporation
  */
 
-#include <stdint.h>
-#include <ethdev_driver.h>
+#include <inttypes.h>
+#include <rte_common.h>
+#include <rte_malloc.h>
 
-#include "ixgbe_ethdev.h"
 #include "ixgbe_rxtx.h"
+#include "ixgbe_rxtx_vec_common.h"
+
+void __rte_cold
+ixgbe_tx_free_swring_vec(struct ci_tx_queue *txq)
+{
+	if (txq == NULL)
+		return;
+
+	if (txq->sw_ring != NULL) {
+		rte_free(txq->sw_ring_vec - 1);
+		txq->sw_ring_vec = NULL;
+	}
+}
+
+void __rte_cold
+ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq)
+{
+	static const union ixgbe_adv_tx_desc zeroed_desc = { { 0 } };
+	struct ci_tx_entry_vec *txe = txq->sw_ring_vec;
+	uint16_t i;
+
+	/* Zero out HW ring memory */
+	for (i = 0; i < txq->nb_tx_desc; i++)
+		txq->ixgbe_tx_ring[i] = zeroed_desc;
+
+	/* Initialize SW ring entries */
+	for (i = 0; i < txq->nb_tx_desc; i++) {
+		volatile union ixgbe_adv_tx_desc *txd = &txq->ixgbe_tx_ring[i];
+
+		txd->wb.status = IXGBE_TXD_STAT_DD;
+		txe[i].mbuf = NULL;
+	}
+
+	txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
+	txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+
+	txq->tx_tail = 0;
+	txq->nb_tx_used = 0;
+	/*
+	 * Always allow 1 descriptor to be un-allocated to avoid
+	 * a H/W race condition
+	 */
+	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
+	txq->ctx_curr = 0;
+	memset(txq->ctx_cache, 0, IXGBE_CTX_NUM * sizeof(struct ixgbe_advctx_info));
+
+	/* for PF, we do not need to initialize the context descriptor */
+	if (!txq->is_vf)
+		txq->vf_ctx_initialized = 1;
+}
+
+void __rte_cold
+ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
+{
+	unsigned int i;
+
+	if (rxq->sw_ring == NULL || rxq->rxrearm_nb >= rxq->nb_rx_desc)
+		return;
+
+	/* free all mbufs that are valid in the ring */
+	if (rxq->rxrearm_nb == 0) {
+		for (i = 0; i < rxq->nb_rx_desc; i++) {
+			if (rxq->sw_ring[i].mbuf != NULL)
+				rte_pktmbuf_free_seg(rxq->sw_ring[i].mbuf);
+		}
+	} else {
+		for (i = rxq->rx_tail;
+		     i != rxq->rxrearm_start;
+		     i = (i + 1) % rxq->nb_rx_desc) {
+			if (rxq->sw_ring[i].mbuf != NULL)
+				rte_pktmbuf_free_seg(rxq->sw_ring[i].mbuf);
+		}
+	}
+
+	rxq->rxrearm_nb = rxq->nb_rx_desc;
+
+	/* set all entries to NULL */
+	memset(rxq->sw_ring, 0, sizeof(rxq->sw_ring[0]) * rxq->nb_rx_desc);
+}
+
+int __rte_cold
+ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq)
+{
+	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
+	return 0;
+}
+
+static const struct ixgbe_txq_ops vec_txq_ops = {
+	.free_swring = ixgbe_tx_free_swring_vec,
+	.reset = ixgbe_reset_tx_queue_vec,
+};
+
+int __rte_cold
+ixgbe_txq_vec_setup(struct ci_tx_queue *txq)
+{
+	if (txq->sw_ring_vec == NULL)
+		return -1;
+
+	/* leave the first one for overflow */
+	txq->sw_ring_vec = txq->sw_ring_vec + 1;
+	txq->ops = &vec_txq_ops;
+	txq->vector_tx = 1;
+
+	return 0;
+}
+
+int __rte_cold
+ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
+{
+#ifndef RTE_LIBRTE_IEEE1588
+	struct rte_eth_fdir_conf *fconf = IXGBE_DEV_FDIR_CONF(dev);
+
+	/* no fdir support */
+	if (fconf->mode != RTE_FDIR_MODE_NONE)
+		return -1;
+
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		if (!rxq)
+			continue;
+		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
+			return -1;
+	}
+	return 0;
+#else
+	RTE_SET_USED(dev);
+	return -1;
+#endif
+}
 
 void
 ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index 9e1abf4449..d5a051e024 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -11,6 +11,16 @@
 #include "ixgbe_ethdev.h"
 #include "ixgbe_rxtx.h"
 
+int ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev);
+int ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq);
+int ixgbe_txq_vec_setup(struct ci_tx_queue *txq);
+void ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq);
+void ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq);
+void ixgbe_tx_free_swring_vec(struct ci_tx_queue *txq);
+void ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs);
+uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
+		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
+
 static __rte_always_inline int
 ixgbe_tx_free_bufs_vec(struct ci_tx_queue *txq)
 {
@@ -68,121 +78,4 @@ ixgbe_tx_free_bufs_vec(struct ci_tx_queue *txq)
 	return txq->tx_rs_thresh;
 }
 
-static inline void
-_ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
-{
-	unsigned int i;
-
-	if (rxq->sw_ring == NULL || rxq->rxrearm_nb >= rxq->nb_rx_desc)
-		return;
-
-	/* free all mbufs that are valid in the ring */
-	if (rxq->rxrearm_nb == 0) {
-		for (i = 0; i < rxq->nb_rx_desc; i++) {
-			if (rxq->sw_ring[i].mbuf != NULL)
-				rte_pktmbuf_free_seg(rxq->sw_ring[i].mbuf);
-		}
-	} else {
-		for (i = rxq->rx_tail;
-		     i != rxq->rxrearm_start;
-		     i = (i + 1) % rxq->nb_rx_desc) {
-			if (rxq->sw_ring[i].mbuf != NULL)
-				rte_pktmbuf_free_seg(rxq->sw_ring[i].mbuf);
-		}
-	}
-
-	rxq->rxrearm_nb = rxq->nb_rx_desc;
-
-	/* set all entries to NULL */
-	memset(rxq->sw_ring, 0, sizeof(rxq->sw_ring[0]) * rxq->nb_rx_desc);
-}
-
-static inline void
-_ixgbe_tx_free_swring_vec(struct ci_tx_queue *txq)
-{
-	if (txq == NULL)
-		return;
-
-	if (txq->sw_ring != NULL) {
-		rte_free(txq->sw_ring_vec - 1);
-		txq->sw_ring_vec = NULL;
-	}
-}
-
-static inline void
-_ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq)
-{
-	static const union ixgbe_adv_tx_desc zeroed_desc = { { 0 } };
-	struct ci_tx_entry_vec *txe = txq->sw_ring_vec;
-	uint16_t i;
-
-	/* Zero out HW ring memory */
-	for (i = 0; i < txq->nb_tx_desc; i++)
-		txq->ixgbe_tx_ring[i] = zeroed_desc;
-
-	/* Initialize SW ring entries */
-	for (i = 0; i < txq->nb_tx_desc; i++) {
-		volatile union ixgbe_adv_tx_desc *txd = &txq->ixgbe_tx_ring[i];
-
-		txd->wb.status = IXGBE_TXD_STAT_DD;
-		txe[i].mbuf = NULL;
-	}
-
-	txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
-	txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-
-	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
-	/*
-	 * Always allow 1 descriptor to be un-allocated to avoid
-	 * a H/W race condition
-	 */
-	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
-	txq->ctx_curr = 0;
-	memset(txq->ctx_cache, 0, IXGBE_CTX_NUM * sizeof(struct ixgbe_advctx_info));
-
-	/* for PF, we do not need to initialize the context descriptor */
-	if (!txq->is_vf)
-		txq->vf_ctx_initialized = 1;
-}
-
-static inline int
-ixgbe_txq_vec_setup_default(struct ci_tx_queue *txq,
-			    const struct ixgbe_txq_ops *txq_ops)
-{
-	if (txq->sw_ring_vec == NULL)
-		return -1;
-
-	/* leave the first one for overflow */
-	txq->sw_ring_vec = txq->sw_ring_vec + 1;
-	txq->ops = txq_ops;
-	txq->vector_tx = 1;
-
-	return 0;
-}
-
-static inline int
-ixgbe_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
-{
-#ifndef RTE_LIBRTE_IEEE1588
-	struct rte_eth_fdir_conf *fconf = IXGBE_DEV_FDIR_CONF(dev);
-
-	/* no fdir support */
-	if (fconf->mode != RTE_FDIR_MODE_NONE)
-		return -1;
-
-	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
-		if (!rxq)
-			continue;
-		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
-			return -1;
-	}
-	return 0;
-#else
-	RTE_SET_USED(dev);
-	return -1;
-#endif
-}
 #endif
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index 3a0b2909a7..ba213ccc67 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -632,45 +632,3 @@ ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	return nb_pkts;
 }
-
-void __rte_cold
-ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
-{
-	_ixgbe_rx_queue_release_mbufs_vec(rxq);
-}
-
-static void __rte_cold
-ixgbe_tx_free_swring(struct ci_tx_queue *txq)
-{
-	_ixgbe_tx_free_swring_vec(txq);
-}
-
-static void __rte_cold
-ixgbe_reset_tx_queue(struct ci_tx_queue *txq)
-{
-	_ixgbe_reset_tx_queue_vec(txq);
-}
-
-static const struct ixgbe_txq_ops vec_txq_ops = {
-	.free_swring = ixgbe_tx_free_swring,
-	.reset = ixgbe_reset_tx_queue,
-};
-
-int __rte_cold
-ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq)
-{
-	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
-	return 0;
-}
-
-int __rte_cold
-ixgbe_txq_vec_setup(struct ci_tx_queue *txq)
-{
-	return ixgbe_txq_vec_setup_default(txq, &vec_txq_ops);
-}
-
-int __rte_cold
-ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
-{
-	return ixgbe_rx_vec_dev_conf_condition_check_default(dev);
-}
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index 1e063bb243..e1516a943d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -753,45 +753,3 @@ ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	return nb_pkts;
 }
-
-void __rte_cold
-ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
-{
-	_ixgbe_rx_queue_release_mbufs_vec(rxq);
-}
-
-static void __rte_cold
-ixgbe_tx_free_swring(struct ci_tx_queue *txq)
-{
-	_ixgbe_tx_free_swring_vec(txq);
-}
-
-static void __rte_cold
-ixgbe_reset_tx_queue(struct ci_tx_queue *txq)
-{
-	_ixgbe_reset_tx_queue_vec(txq);
-}
-
-static const struct ixgbe_txq_ops vec_txq_ops = {
-	.free_swring = ixgbe_tx_free_swring,
-	.reset = ixgbe_reset_tx_queue,
-};
-
-int __rte_cold
-ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq)
-{
-	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
-	return 0;
-}
-
-int __rte_cold
-ixgbe_txq_vec_setup(struct ci_tx_queue *txq)
-{
-	return ixgbe_txq_vec_setup_default(txq, &vec_txq_ops);
-}
-
-int __rte_cold
-ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
-{
-	return ixgbe_rx_vec_dev_conf_condition_check_default(dev);
-}
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index d1122bb9cd..e6f0fd135e 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -24,11 +24,11 @@ testpmd_sources = files('ixgbe_testpmd.c')
 deps += ['hash', 'security']
 
 if arch_subdir == 'x86'
+    sources += files('ixgbe_rxtx_vec_common.c')
     sources += files('ixgbe_rxtx_vec_sse.c')
-    sources += files('ixgbe_recycle_mbufs_vec_common.c')
 elif arch_subdir == 'arm'
+    sources += files('ixgbe_rxtx_vec_common.c')
     sources += files('ixgbe_rxtx_vec_neon.c')
-    sources += files('ixgbe_recycle_mbufs_vec_common.c')
 endif
 
 headers = files('rte_pmd_ixgbe.h')
-- 
2.47.1

