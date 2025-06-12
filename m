Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAC5C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:13:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53D9842791;
	Thu, 12 Jun 2025 13:12:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 561D441143
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726740; x=1781262740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vq1wX5uxxhomOCJ2NVMr0Uw+zyNs1ZaxfAYybeXuPG4=;
 b=FlluniPLE6lKGyjffzbz7AT4eoNs/LhK4J396lfvZ1yH7Z9TlRyuhXae
 LhiLOWDAt16Qt7TzbnUJ6sA44MgtFkTWGvblNEXSY+4AmAHq4oBmmbfQA
 3azFgH17Wul6nCfW4FKTjINwt2TY6mpLQZW6FOPMmk0UZtp1vj/IWD2zs
 s8ptKjP8H7wk6c6I/lunrqhC/6SZLOl55EToGsQV/l9NP1ohAj6KTf+d6
 Z0k8T86q6M7iYfqnl26rk4NHgE2SrLxnfxsfW7PX4OXJoc1aot867xTho
 zkA9ezI7KsIGHFJPWOGcJAdxseIyoBUoWUAcZObm1xuJUGJRRYvkUqNg9 w==;
X-CSE-ConnectionGUID: x6mz7FeyTiWiSYw+OD1fLQ==
X-CSE-MsgGUID: lAI/FApcSzu89SJ9k57b5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177560"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177560"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:19 -0700
X-CSE-ConnectionGUID: DzEt7R0oSEexoV/zmQqDfw==
X-CSE-MsgGUID: AQvJuflmSaqtAiM4JO/pLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371350"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 15/33] net/ixgbe: move vector Rx/Tx code to vec common
Date: Thu, 12 Jun 2025 12:11:21 +0100
Message-ID: <69727a884205ebb9b0f476534d09dd940e38d561.1749726639.git.anatoly.burakov@intel.com>
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

