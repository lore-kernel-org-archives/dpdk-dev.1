Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157DAC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:39:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56C924279E;
	Mon,  9 Jun 2025 17:38:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 70C2E42799
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483485; x=1781019485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fv0D3bnitWr6JsPlQH8ExnM9PO2C0SCuj6C+dQXxbSA=;
 b=dlMx5AbQV/Nl+fHa+8NxyGQRNk7sgFJUz3UtIPKisNO8av+rPqD466WG
 BWTSgRjmeepK9rHeU76FdAxC4BI1mMl+MGqHeEJr/BTb4zqawssz/8zal
 vqrGZ7Qr2V+sy7jNUyLf401wRKmcQtUSiTEsrval0c53EDLvsost8eb07
 YDO+mO2z5o/8l5CPTcDQiYBGIj/lhnmoAUeyNZo1zRPQlT7rKIa0JntWF
 lZTheIUGgkeMaawYSp90GoE/HphWgAWuPTe+U6+V7MIAV0D6NArhXeNLq
 Yjzarpw04QhVKK5omPmCW1FDE6/TKAHkFgU36LOeIT9rXzLdcgh/clb4F g==;
X-CSE-ConnectionGUID: 7a4ksUXXTXKt0GczwACG8w==
X-CSE-MsgGUID: tuCyxJKTSyyyY12/zymaZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012176"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012176"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:38:04 -0700
X-CSE-ConnectionGUID: mEHW9GrHSfujIeFp5PjkfA==
X-CSE-MsgGUID: vdhR7Es3RROk39U6C0wPPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419633"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:38:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v6 11/33] net/ixgbe: remove unnecessary platform checks
Date: Mon,  9 Jun 2025 16:37:09 +0100
Message-ID: <303054ab51d9a1a14adc851d59657f97bb695e9e.1749483382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
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

Some of the things that are only used by vector drivers is guarded by
platform define checks, but there is actually no real reason to have those
checks, because this code won't run anyway. Remove all of the unnecessary
platform checks, and provide function stubs where necessary to make
compilation work.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Add this patch

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 26 +++++++++++++-------------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h |  4 ----
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 8fbb795097..0777f70a4b 100644
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
 		} else {
 			dev->tx_pkt_burst = ixgbe_xmit_pkts_simple;
@@ -3112,11 +3110,8 @@ ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ixgbe_rx_queue *rxq)
 
 	rxq->pkt_first_seg = NULL;
 	rxq->pkt_last_seg = NULL;
-
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	rxq->rxrearm_start = 0;
 	rxq->rxrearm_nb = 0;
-#endif
 }
 
 static int
@@ -3408,11 +3403,9 @@ ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 	if (unlikely(offset >= rxq->nb_rx_desc))
 		return -EINVAL;
 
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	if (rxq->vector_rx)
 		nb_hold = rxq->rxrearm_nb;
 	else
-#endif
 		nb_hold = rxq->nb_rx_hold;
 	if (offset >= rxq->nb_rx_desc - nb_hold)
 		return RTE_ETH_RX_DESC_UNAVAIL;
@@ -5050,10 +5043,8 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
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
@@ -5082,9 +5073,7 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
 				    "burst size no less than %d (port=%d).",
 			     RTE_IXGBE_DESCS_PER_LOOP,
 			     dev->data->port_id);
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 		dev->recycle_rx_descriptors_refill = ixgbe_recycle_rx_descriptors_refill_vec;
-#endif
 		dev->rx_pkt_burst = ixgbe_recv_pkts_vec;
 	} else if (adapter->rx_bulk_alloc_allowed) {
 		PMD_INIT_LOG(DEBUG, "Rx Burst Bulk Alloc Preconditions are "
@@ -5872,10 +5861,8 @@ ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	recycle_rxq_info->receive_tail = &rxq->rx_tail;
 
 	if (adapter->rx_vec_allowed) {
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 		recycle_rxq_info->refill_requirement = RTE_IXGBE_RXQ_REARM_THRESH;
 		recycle_rxq_info->refill_head = &rxq->rxrearm_start;
-#endif
 	} else {
 		recycle_rxq_info->refill_requirement = rxq->rx_free_thresh;
 		recycle_rxq_info->refill_head = &rxq->rx_free_trigger;
@@ -6251,6 +6238,19 @@ ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev __rte_unused *dev)
 	return -1;
 }
 
+void
+ixgbe_recycle_rx_descriptors_refill_vec(void __rte_unused * rx_queue,
+		uint16_t __rte_unused nb_mbufs)
+{
+}
+
+uint16_t
+ixgbe_recycle_tx_mbufs_reuse_vec(void __rte_unused * tx_queue,
+	struct rte_eth_recycle_rxq_info __rte_unused * recycle_rxq_info)
+{
+	return 0;
+}
+
 uint16_t
 ixgbe_recv_pkts_vec(
 	void __rte_unused *rx_queue,
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
-- 
2.47.1

