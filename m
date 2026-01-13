Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F5CD2F32E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:20:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA42040E50;
	Tue, 13 Jan 2026 16:15:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A5C7840E45
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317357; x=1799853357;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MEQfgH7ovrSFhHhThkVzyK9qX7SQ52knPUtZXI3Pt0o=;
 b=G+x6nfOdlPcjX4jwwQPuwOCm0RxgVraWeSzIkwf/raW+hIDIQConA5TX
 9FcnLVA3DlfbvALe4kmHfzdWxjWbQEJg7AgcuBU/DOWp6PSLGjd9eQPrn
 E4jRByfugQTBuqYMdGpNgstG0pvd8h/uImsiiarwg/g5Ugld8syVafYLA
 o/xcsoTT+L6SOwqHwLNEtfCattgBn5kHwJkQfOyaiRNVyNTGw80kMEdpv
 jsmPEGjUUCCmyxjAw/mKaz0uNksapiNRzukhsFg9YMaI0SAImLfldKSCH
 xXI4ehtqutlW9mgQgDdop/4a8G7ghjsfhw13xU8fLfZ3DS2slhWpa3eCo A==;
X-CSE-ConnectionGUID: KWYbfYBDQ7SbIAfj5ZAALw==
X-CSE-MsgGUID: 98z1tsoOSiS+KBHBoaVMww==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969240"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969240"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:56 -0800
X-CSE-ConnectionGUID: 7BXvTwb3TPGdKd+OelAOTA==
X-CSE-MsgGUID: b0V8VPgXSlSGUHbtsUYhvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556686"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:55 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v2 34/36] net/intel: use vector SW ring entry for simple path
Date: Tue, 13 Jan 2026 15:14:58 +0000
Message-ID: <20260113151505.1871271-35-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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

The simple scalar Tx path does not need to use the full sw_entry
structure that the full Tx path uses, so rename the flag for "vector_tx"
to instead be "use_vec_entry" since its sole purpose is to flag the use
of the smaller tx_entry_vec structure. Then set this flag for the simple
Tx path, giving us a perf boost.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h                    |  6 ++++--
 drivers/net/intel/common/tx_scalar_fns.h         | 14 +++++++-------
 drivers/net/intel/cpfl/cpfl_rxtx.c               |  4 ++--
 drivers/net/intel/i40e/i40e_rxtx.c               |  2 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c      |  2 +-
 drivers/net/intel/ice/ice_rxtx.c                 |  2 +-
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c  |  2 +-
 8 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 753e3a2e9e..44270bf3e6 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -160,7 +160,7 @@ struct ci_tx_queue {
 	rte_iova_t tx_ring_dma;        /* TX ring DMA address */
 	bool tx_deferred_start; /* don't start this queue in dev start */
 	bool q_set;             /* indicate if tx queue has been configured */
-	bool vector_tx;         /* port is using vector TX */
+	bool use_vec_entry;     /* use sw_ring_vec (true for vector and simple paths) */
 	union {                  /* the VSI this queue belongs to */
 		struct i40e_vsi *i40e_vsi;
 		struct iavf_vsi *iavf_vsi;
@@ -343,7 +343,8 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
 	if (unlikely(!txq || !txq->sw_ring))
 		return;
 
-	if (!txq->vector_tx) {
+	if (!txq->use_vec_entry) {
+		/* Regular scalar path uses sw_ring with ci_tx_entry */
 		for (uint16_t i = 0; i < txq->nb_tx_desc; i++) {
 			if (txq->sw_ring[i].mbuf != NULL) {
 				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
@@ -354,6 +355,7 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
 	}
 
 	/**
+	 *  Vector and simple paths use sw_ring_vec (ci_tx_entry_vec).
 	 *  vPMD tx will not set sw_ring's mbuf to NULL after free,
 	 *  so determining buffers to free is a little more complex.
 	 */
diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index f85ca741a9..b284b80cbe 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -56,7 +56,7 @@ ci_tx_fill_hw_ring_simple(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pk
 static __rte_always_inline int
 ci_tx_free_bufs(struct ci_tx_queue *txq)
 {
-	struct ci_tx_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t tx_rs_thresh = txq->tx_rs_thresh;
 	uint16_t i = 0, j = 0;
 	struct rte_mbuf *free[CI_TX_MAX_FREE_BUF_SZ];
@@ -68,7 +68,7 @@ ci_tx_free_bufs(struct ci_tx_queue *txq)
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
 
-	txep = &txq->sw_ring[txq->tx_next_dd - (tx_rs_thresh - 1)];
+	txep = &txq->sw_ring_vec[txq->tx_next_dd - (tx_rs_thresh - 1)];
 
 	for (i = 0; i < tx_rs_thresh; i++)
 		rte_prefetch0((txep + i)->mbuf);
@@ -122,7 +122,7 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 {
 	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
 	volatile struct ci_tx_desc *txdp;
-	struct ci_tx_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t tx_id;
 	uint16_t n = 0;
 
@@ -141,7 +141,7 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 
 	tx_id = txq->tx_tail;
 	txdp = &txr[tx_id];
-	txep = &txq->sw_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
@@ -149,7 +149,7 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 		n = (uint16_t)(txq->nb_tx_desc - tx_id);
 
 		/* Store mbufs in backlog */
-		ci_tx_backlog_entry(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		/* Write descriptors to HW ring */
 		ci_tx_fill_hw_ring_simple(txdp, tx_pkts, n);
@@ -161,11 +161,11 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 
 		tx_id = 0;
 		txdp = &txr[tx_id];
-		txep = &txq->sw_ring[tx_id];
+		txep = &txq->sw_ring_vec[tx_id];
 	}
 
 	/* Store remaining mbufs in backlog */
-	ci_tx_backlog_entry(txep, tx_pkts + n, (uint16_t)(nb_pkts - n));
+	ci_tx_backlog_entry_vec(txep, tx_pkts + n, (uint16_t)(nb_pkts - n));
 
 	/* Write remaining descriptors to HW ring */
 	ci_tx_fill_hw_ring_simple(txdp, tx_pkts + n, (uint16_t)(nb_pkts - n));
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index a3127e7c97..6d8798a60f 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -328,7 +328,7 @@ cpfl_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
-	ci_txq_release_all_mbufs(q, q->vector_tx);
+	ci_txq_release_all_mbufs(q, q->use_vec_entry);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(cpfl_txq);
@@ -1335,7 +1335,7 @@ cpfl_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	}
 
 	txq = &cpfl_txq->base;
-	ci_txq_release_all_mbufs(txq, txq->vector_tx);
+	ci_txq_release_all_mbufs(txq, txq->use_vec_entry);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index ac53554234..185e45fb9a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1453,7 +1453,7 @@ i40e_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		PMD_DRV_LOG(WARNING, "TX queue %u is deferred start",
 			    tx_queue_id);
 
-	txq->vector_tx = ad->tx_vec_allowed;
+	txq->use_vec_entry = ad->tx_vec_allowed || ad->tx_simple_allowed;
 
 	/*
 	 * tx_queue_id is queue id application refers to, while
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index cea4ee9863..374c713a94 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1803,7 +1803,7 @@ iavf_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 int __rte_cold
 iavf_txq_vec_setup(struct ci_tx_queue *txq)
 {
-	txq->vector_tx = true;
+	txq->use_vec_entry = true;
 	return 0;
 }
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index ed82a84dc5..06f7e85c12 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -882,7 +882,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		}
 
 	/* record what kind of descriptor cleanup we need on teardown */
-	txq->vector_tx = ad->tx_vec_allowed;
+	txq->use_vec_entry = ad->tx_vec_allowed || ad->tx_simple_allowed;
 
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
 		struct ice_aqc_set_txtime_qgrp *ts_elem;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 49ace35615..666ad1a4dd 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1365,6 +1365,6 @@ idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
 	if (!txq)
 		return 0;
 
-	txq->vector_tx = true;
+	txq->use_vec_entry = true;
 	return 0;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index 63c7cb50d3..c42b8fc96b 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -111,7 +111,7 @@ ixgbe_txq_vec_setup(struct ci_tx_queue *txq)
 	/* leave the first one for overflow */
 	txq->sw_ring_vec = txq->sw_ring_vec + 1;
 	txq->ops = &vec_txq_ops;
-	txq->vector_tx = 1;
+	txq->use_vec_entry = true;
 
 	return 0;
 }
-- 
2.51.0

