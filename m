Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76199C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:39:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83E00427BD;
	Mon,  9 Jun 2025 17:38:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 38502415D7
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483491; x=1781019491;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vq1wX5uxxhomOCJ2NVMr0Uw+zyNs1ZaxfAYybeXuPG4=;
 b=lwhv/1ks666KSxRdBSZ7v9jpgrYE4a6Ay3xv51WlVHq8/+zl7JBThX3j
 PkOrp2OzwFptQi0cb/mViGeuK9y3vbFhy+NEVsWJ/sYrcKpPrptdzu/JC
 wTpGJB0Ha1rCDPuXRzry5VveEBQHFpsIUg6GfFUevzjmjZifOFhE3wJRP
 A0LA/L2U5PIogUryDdnL+zUuX9F3NjuwBnuMLGLSHwjI7qTA3WFCtkX7o
 PnzaHx03c9kQUFo480jqNG0Abm4iRx1P/tyPaXwcz3Y1GYku1lMaMxrKO
 eJQ9RlX/aunHIfuUFf3vpWDpJjtOwk5OQFg4iNY5fvLVdtsq2FRyYf8JJ g==;
X-CSE-ConnectionGUID: ByegHVawSTitvrv+xCJ7iA==
X-CSE-MsgGUID: HtBrfb52RyG3nnm33VsfLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012191"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012191"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:38:10 -0700
X-CSE-ConnectionGUID: gIV5k/K6SVqfifuk9W9DNQ==
X-CSE-MsgGUID: 6I9s1iwGTTGYTtr9Db/Zng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419666"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:38:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v6 15/33] net/ixgbe: move vector Rx/Tx code to vec common
Date: Mon,  9 Jun 2025 16:37:13 +0100
Message-ID: <de9ff52c23d2d4d42d58b9f0c6ed8754a545e9bc.1749483382.git.anatoly.burakov@intel.com>
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

There is no reason why bits and pieces of vectorized code should be
defined in `ixgbe_rxtx.c`, so move them to the vec common file.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Add this patch

 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 41 ++++---------------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  6 +--
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   | 31 ++++++++++++++
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |  4 ++
 4 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 79b3d4b71f..ace21396f8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -91,7 +91,6 @@
 
 /* forward-declare some functions */
 static int ixgbe_is_vf(struct rte_eth_dev *dev);
-static int ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec);
 
 /*********************************************************************
  *
@@ -361,37 +360,6 @@ ixgbe_xmit_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
-static uint16_t
-ixgbe_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
-		    uint16_t nb_pkts)
-{
-	uint16_t nb_tx = 0;
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-
-	/* we might check first packet's mempool */
-	if (unlikely(nb_pkts == 0))
-		return nb_pkts;
-
-	/* check if we need to initialize default context descriptor */
-	if (unlikely(!txq->vf_ctx_initialized) &&
-			ixgbe_write_default_ctx_desc(txq, tx_pkts[0]->pool, true))
-		return 0;
-
-	while (nb_pkts) {
-		uint16_t ret, num;
-
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-		ret = ixgbe_xmit_fixed_burst_vec(tx_queue, &tx_pkts[nb_tx],
-						 num);
-		nb_tx += ret;
-		nb_pkts -= ret;
-		if (ret < num)
-			break;
-	}
-
-	return nb_tx;
-}
-
 static inline void
 ixgbe_set_xmit_ctx(struct ci_tx_queue *txq,
 		volatile struct ixgbe_adv_tx_context_desc *ctx_txd,
@@ -2376,7 +2344,7 @@ ixgbe_recv_pkts_lro_bulk_alloc(void *rx_queue, struct rte_mbuf **rx_pkts,
  *
  **********************************************************************/
 
-static inline int
+int
 ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec)
 {
 	volatile struct ixgbe_adv_tx_context_desc *ctx_txd;
@@ -6280,6 +6248,13 @@ ixgbe_rxq_vec_setup(struct ixgbe_rx_queue __rte_unused *rxq)
 	return -1;
 }
 
+uint16_t
+ixgbe_xmit_pkts_vec(void __rte_unused * tx_queue, struct rte_mbuf __rte_unused * *tx_pkts,
+		__rte_unused uint16_t nb_pkts)
+{
+	return 0;
+}
+
 uint16_t
 ixgbe_xmit_fixed_burst_vec(void __rte_unused *tx_queue,
 		struct rte_mbuf __rte_unused **tx_pkts,
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index cd0015be9c..6fcc5ee1e6 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -221,21 +221,19 @@ int ixgbe_rx_burst_mode_get(struct rte_eth_dev *dev,
 		uint16_t queue_id, struct rte_eth_burst_mode *mode);
 
 int ixgbe_check_supported_loopback_mode(struct rte_eth_dev *dev);
-uint16_t ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-		uint16_t nb_pkts);
-uint16_t ixgbe_recv_scattered_pkts_vec(void *rx_queue,
-		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 int ixgbe_dev_tx_done_cleanup(void *tx_queue, uint32_t free_cnt);
 
 extern const uint32_t ptype_table[IXGBE_PACKET_TYPE_MAX];
 extern const uint32_t ptype_table_tn[IXGBE_PACKET_TYPE_TN_MAX];
 
+int ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec);
 uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
 void ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs);
 
 uint16_t ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 				    uint16_t nb_pkts);
+int ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec);
 
 uint64_t ixgbe_get_tx_port_offloads(struct rte_eth_dev *dev);
 uint64_t ixgbe_get_rx_queue_offloads(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index be422ee238..cf6d3e4914 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -139,6 +139,37 @@ ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 #endif
 }
 
+uint16_t
+ixgbe_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
+			uint16_t nb_pkts)
+{
+	uint16_t nb_tx = 0;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+
+	/* we might check first packet's mempool */
+	if (unlikely(nb_pkts == 0))
+		return nb_pkts;
+
+	/* check if we need to initialize default context descriptor */
+	if (unlikely(!txq->vf_ctx_initialized) &&
+			ixgbe_write_default_ctx_desc(txq, tx_pkts[0]->pool, true))
+		return 0;
+
+	while (nb_pkts) {
+		uint16_t ret, num;
+
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
+		ret = ixgbe_xmit_fixed_burst_vec(tx_queue, &tx_pkts[nb_tx],
+							num);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
 void
 ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
 {
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index d5a051e024..4678a5dfd9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -17,6 +17,10 @@ int ixgbe_txq_vec_setup(struct ci_tx_queue *txq);
 void ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq);
 void ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq);
 void ixgbe_tx_free_swring_vec(struct ci_tx_queue *txq);
+uint16_t ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t ixgbe_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t ixgbe_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 void ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs);
 uint16_t ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
-- 
2.47.1

