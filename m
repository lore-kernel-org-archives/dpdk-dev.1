Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F920C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93422406B7;
	Fri, 30 May 2025 15:57:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id D8B0640656
 for <dev@dpdk.org>; Fri, 30 May 2025 15:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613472; x=1780149472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cc3WB2fCHmBr6RPFKWqY7P52XScSPfjukMxv/iTDMOw=;
 b=DwH7ddmGoGH/Xm2V9ZhYH4cEarleRrskFslHNjCCGhNBxQXkQg6c1JXG
 4A4WeHUIRkQiBLcrR2XYvfeuC5qVI6tgANfNQFxHu5m2eGAlTWfCxlP0E
 KgFClz8HUM77GvV1EtNQ5MRls3pUbypQ/iQMzJLSQ98OPR2N82pVW4nBN
 bvE/nz1MalwzlMfigCenBZvQNXHoyQcnzM9SwjOry2trnvvHqLAykMZkN
 goV2NGuIztp1XT1Aiy1zRx0VyLB/fPkAx8wfATJNGvIIrz0wRgZ9kp1nP
 mWhQAmJGmUlOYJN3f7ZK2/oUycv2MzJF+LizLCE81qO9xhDdghHq3maQQ w==;
X-CSE-ConnectionGUID: ZvD/ju7dTlKQooGAYartyg==
X-CSE-MsgGUID: wAtDbR1OTEi4LABWNZC2Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809375"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809375"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:57:51 -0700
X-CSE-ConnectionGUID: rqPiIhkTTruSjcwsmqDhrA==
X-CSE-MsgGUID: EgnsOgikRGO6sWP+rfflHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887440"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:57:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 09/25] net/ixgbe: simplify vector PMD compilation
Date: Fri, 30 May 2025 14:57:05 +0100
Message-ID: <8c721805cbf413ef8fd3272698f5c650420fa2eb.1748612803.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
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

Currently, there's a bunch of vector PMD-related stuff that's being
compiled based on what architecture the code is being compiled for.

Simplify it by removing necessary #ifdef's and have it so that vector PMD
compilation is controlled in one place - using a compile flag from the
build file.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 27 +++++++++++++++------------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h |  4 ----
 drivers/net/intel/ixgbe/meson.build  |  2 ++
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index f75821029d..f5fd50584a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2678,9 +2678,7 @@ ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 				(rte_eal_process_type() != RTE_PROC_PRIMARY ||
 					ixgbe_txq_vec_setup(txq) == 0)) {
 			PMD_INIT_LOG(DEBUG, "Vector tx enabled.");
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 			dev->recycle_tx_mbufs_reuse = ixgbe_recycle_tx_mbufs_reuse_vec;
-#endif
 			dev->tx_pkt_burst = ixgbe_xmit_pkts_vec;
 		} else
 		dev->tx_pkt_burst = ixgbe_xmit_pkts_simple;
@@ -5049,10 +5047,8 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
 			PMD_INIT_LOG(DEBUG, "Using Vector Scattered Rx "
 					    "callback (port=%d).",
 				     dev->data->port_id);
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 			dev->recycle_rx_descriptors_refill =
 				ixgbe_recycle_rx_descriptors_refill_vec;
-#endif
 			dev->rx_pkt_burst = ixgbe_recv_scattered_pkts_vec;
 		} else if (adapter->rx_bulk_alloc_allowed) {
 			PMD_INIT_LOG(DEBUG, "Using a Scattered with bulk "
@@ -5081,9 +5077,7 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
 				    "burst size no less than %d (port=%d).",
 			     RTE_IXGBE_DESCS_PER_LOOP,
 			     dev->data->port_id);
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 		dev->recycle_rx_descriptors_refill = ixgbe_recycle_rx_descriptors_refill_vec;
-#endif
 		dev->rx_pkt_burst = ixgbe_recv_pkts_vec;
 	} else if (adapter->rx_bulk_alloc_allowed) {
 		PMD_INIT_LOG(DEBUG, "Rx Burst Bulk Alloc Preconditions are "
@@ -5871,10 +5865,8 @@ ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	recycle_rxq_info->receive_tail = &rxq->rx_tail;
 
 	if (adapter->rx_vec_allowed) {
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 		recycle_rxq_info->refill_requirement = RTE_IXGBE_RXQ_REARM_THRESH;
 		recycle_rxq_info->refill_head = &rxq->rxrearm_start;
-#endif
 	} else {
 		recycle_rxq_info->refill_requirement = rxq->rx_free_thresh;
 		recycle_rxq_info->refill_head = &rxq->rx_free_trigger;
@@ -6239,11 +6231,9 @@ ixgbe_config_rss_filter(struct rte_eth_dev *dev,
 	return 0;
 }
 
-/* Stubs needed for linkage when RTE_ARCH_PPC_64, RTE_ARCH_RISCV or
- * RTE_ARCH_LOONGARCH is set.
+/* Stubs needed for linkage when vectorized PMD isn't supported.
  */
-#if defined(RTE_ARCH_PPC_64) || defined(RTE_ARCH_RISCV) || \
-	defined(RTE_ARCH_LOONGARCH)
+#ifndef IXGBE_VPMD_SUPPORTED
 int
 ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev __rte_unused *dev)
 {
@@ -6268,6 +6258,12 @@ ixgbe_recv_scattered_pkts_vec(
 	return 0;
 }
 
+void
+ixgbe_recycle_rx_descriptors_refill_vec(void __rte_unused * rx_queue,
+		uint16_t __rte_unused nb_mbufs)
+{
+}
+
 int
 ixgbe_rxq_vec_setup(struct ixgbe_rx_queue __rte_unused *rxq)
 {
@@ -6282,6 +6278,13 @@ ixgbe_xmit_fixed_burst_vec(void __rte_unused *tx_queue,
 	return 0;
 }
 
+uint16_t
+ixgbe_recycle_tx_mbufs_reuse_vec(void __rte_unused * tx_queue,
+		struct rte_eth_recycle_rxq_info __rte_unused * recycle_rxq_info)
+{
+	return 0;
+}
+
 int
 ixgbe_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
 {
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index c86714804f..bcd5db87e8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -35,10 +35,8 @@
 
 #define RTE_IXGBE_DESCS_PER_LOOP    4
 
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 #define RTE_IXGBE_RXQ_REARM_THRESH      32
 #define RTE_IXGBE_MAX_RX_BURST          RTE_IXGBE_RXQ_REARM_THRESH
-#endif
 
 #define RX_RING_SZ ((IXGBE_MAX_RING_DESC + RTE_PMD_IXGBE_RX_MAX_BURST) * \
 		    sizeof(union ixgbe_adv_rx_desc))
@@ -102,10 +100,8 @@ struct ixgbe_rx_queue {
 	uint8_t            using_ipsec;
 	/**< indicates that IPsec RX feature is in use */
 #endif
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 	uint16_t            rxrearm_nb;     /**< number of remaining to be re-armed */
 	uint16_t            rxrearm_start;  /**< the idx we start the re-arming from */
-#endif
 	uint16_t            rx_free_thresh; /**< max free RX desc to hold. */
 	uint16_t            queue_id; /**< RX queue index. */
 	uint16_t            reg_idx;  /**< RX queue register index. */
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index d1122bb9cd..8adb1567d1 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -26,9 +26,11 @@ deps += ['hash', 'security']
 if arch_subdir == 'x86'
     sources += files('ixgbe_rxtx_vec_sse.c')
     sources += files('ixgbe_recycle_mbufs_vec_common.c')
+    cflags += ['-DIXGBE_VPMD_SUPPORTED']
 elif arch_subdir == 'arm'
     sources += files('ixgbe_rxtx_vec_neon.c')
     sources += files('ixgbe_recycle_mbufs_vec_common.c')
+    cflags += ['-DIXGBE_VPMD_SUPPORTED']
 endif
 
 headers = files('rte_pmd_ixgbe.h')
-- 
2.47.1

