Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7B5D2F327
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:15:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED5740659;
	Tue, 13 Jan 2026 16:15:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7A5494042F
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317318; x=1799853318;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q9uNNsoGiZ/pEZoRGSlLypcDA5qlMc2S7SK2SL4ViFs=;
 b=QCGkQ3HFUmlZr2ROBdbZ85XW/rGGG+mt9OHCzAyiImXH38XMDErjTv8y
 p1jydeN8kNWaqoRo23WLt6mWX4COw9D65cv09fzyCLO5ok30ck9zD5GmF
 EjesJWx8F6wXYWHfrK7EvyKnNaPLaOj8caQSP7O4yGudvTQwtnCnHPryG
 BMQZDfqkIlcSpO38ZvwuwwadVRJnJ5PMEDWxeu1rFkrFR+RAf06L8ix6G
 ySjwxuL+5zzWEL36v2LoDnxYdwQmZtsjnEEr0OmQvmZPGQ9E+//GjCUVu
 8R5GC+JB115RG4Fi59ALV0cG+R1hHxsz9ZhoLKgWmeWAK4T4TVMQY7TU8 Q==;
X-CSE-ConnectionGUID: xutHSdrWRgW+69SCjF/a0Q==
X-CSE-MsgGUID: +9Ff+8xXQr2VS3Y4HyvYtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969127"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969127"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:17 -0800
X-CSE-ConnectionGUID: pu73VWIjQM27dxMVJJzHNQ==
X-CSE-MsgGUID: RIAFVBcOQdq3KwLLJAQHog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556540"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:16 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v2 02/36] net/intel: use common Tx ring structure
Date: Tue, 13 Jan 2026 15:14:26 +0000
Message-ID: <20260113151505.1871271-3-bruce.richardson@intel.com>
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

Rather than having separate per-driver ring pointers in a union, since
we now have a common descriptor type, we can merge all but the ixgbe
pointer into one value.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h                 |  5 +--
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  2 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  6 ++--
 drivers/net/intel/i40e/i40e_rxtx.c            | 22 ++++++------
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  6 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  6 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  6 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |  2 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  6 ++--
 drivers/net/intel/iavf/iavf_rxtx.c            | 14 ++++----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  6 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 12 +++----
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |  4 +--
 drivers/net/intel/ice/ice_rxtx.c              | 34 +++++++++----------
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  6 ++--
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  6 ++--
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  2 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  8 ++---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  6 ++--
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  6 ++--
 drivers/net/intel/idpf/idpf_rxtx.c            |  2 +-
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  2 +-
 23 files changed, 84 insertions(+), 87 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 722f87a70c..a9ff3bebd5 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -41,10 +41,7 @@ typedef void (*ice_tx_release_mbufs_t)(struct ci_tx_queue *txq);
 
 struct ci_tx_queue {
 	union { /* TX ring virtual address */
-		volatile struct ci_tx_desc *i40e_tx_ring;
-		volatile struct ci_tx_desc *iavf_tx_ring;
-		volatile struct ci_tx_desc *ice_tx_ring;
-		volatile struct ci_tx_desc *idpf_tx_ring;
+		volatile struct ci_tx_desc *ci_tx_ring;
 		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
 	};
 	volatile uint8_t *qtx_tail;               /* register address of tail */
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 57c6f6e736..a3127e7c97 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -594,7 +594,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	if (!is_splitq) {
-		txq->idpf_tx_ring = mz->addr;
+		txq->ci_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 605df73c9e..8a01aec0e2 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1380,7 +1380,7 @@ i40e_find_available_buffer(struct rte_eth_dev *dev)
 		volatile struct ci_tx_desc *tmp_txdp;
 
 		tmp_tail = txq->tx_tail;
-		tmp_txdp = &txq->i40e_tx_ring[tmp_tail + 1];
+		tmp_txdp = &txq->ci_tx_ring[tmp_tail + 1];
 
 		do {
 			if ((tmp_txdp->cmd_type_offset_bsz &
@@ -1637,7 +1637,7 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 
 	PMD_DRV_LOG(INFO, "filling filter programming descriptor.");
 	fdirdp = (volatile struct i40e_filter_program_desc *)
-				(&txq->i40e_tx_ring[txq->tx_tail]);
+				(&txq->ci_tx_ring[txq->tx_tail]);
 
 	fdirdp->qindex_flex_ptype_vsi =
 			rte_cpu_to_le_32((fdir_action->rx_queue <<
@@ -1707,7 +1707,7 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 	fdirdp->fd_id = rte_cpu_to_le_32(filter->soft_id);
 
 	PMD_DRV_LOG(INFO, "filling transmit descriptor.");
-	txdp = &txq->i40e_tx_ring[txq->tx_tail + 1];
+	txdp = &txq->ci_tx_ring[txq->tx_tail + 1];
 	txdp->buffer_addr = rte_cpu_to_le_64(pf->fdir.dma_addr[txq->tx_tail >> 1]);
 
 	td_cmd = I40E_TX_DESC_CMD_EOP |
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 8600ef3e3a..51e9c1a1f0 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -388,7 +388,7 @@ static inline int
 i40e_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	volatile struct ci_tx_desc *txd = txq->i40e_tx_ring;
+	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
@@ -1112,7 +1112,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	txq = tx_queue;
 	sw_ring = txq->sw_ring;
-	txr = txq->i40e_tx_ring;
+	txr = txq->ci_tx_ring;
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
 
@@ -1347,7 +1347,7 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, I40E_TX_MAX_FREE_BUF_SZ);
 	const uint16_t m = tx_rs_thresh % I40E_TX_MAX_FREE_BUF_SZ;
 
-	if ((txq->i40e_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
+	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
 			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
 			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
@@ -1426,7 +1426,7 @@ i40e_tx_fill_hw_ring(struct ci_tx_queue *txq,
 		     struct rte_mbuf **pkts,
 		     uint16_t nb_pkts)
 {
-	volatile struct ci_tx_desc *txdp = &txq->i40e_tx_ring[txq->tx_tail];
+	volatile struct ci_tx_desc *txdp = &txq->ci_tx_ring[txq->tx_tail];
 	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
 	const int N_PER_LOOP = 4;
 	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
@@ -1454,7 +1454,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts)
 {
-	volatile struct ci_tx_desc *txr = txq->i40e_tx_ring;
+	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
 	uint16_t n = 0;
 
 	/**
@@ -2406,7 +2406,7 @@ i40e_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
 			desc -= txq->nb_tx_desc;
 	}
 
-	status = &txq->i40e_tx_ring[desc].cmd_type_offset_bsz;
+	status = &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
 	mask = rte_le_to_cpu_64(I40E_TXD_QW1_DTYPE_MASK);
 	expect = rte_cpu_to_le_64(
 		I40E_TX_DESC_DTYPE_DESC_DONE << I40E_TXD_QW1_DTYPE_SHIFT);
@@ -2603,7 +2603,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* Allocate TX hardware ring descriptors. */
 	ring_size = sizeof(struct ci_tx_desc) * I40E_MAX_RING_DESC;
 	ring_size = RTE_ALIGN(ring_size, I40E_DMA_MEM_ALIGN);
-	tz = rte_eth_dma_zone_reserve(dev, "i40e_tx_ring", queue_idx,
+	tz = rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
 			      ring_size, I40E_RING_BASE_ALIGN, socket_id);
 	if (!tz) {
 		i40e_tx_queue_release(txq);
@@ -2623,7 +2623,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
 	txq->tx_ring_dma = tz->iova;
-	txq->i40e_tx_ring = (struct ci_tx_desc *)tz->addr;
+	txq->ci_tx_ring = (struct ci_tx_desc *)tz->addr;
 
 	/* Allocate software ring */
 	txq->sw_ring =
@@ -2898,11 +2898,11 @@ i40e_reset_tx_queue(struct ci_tx_queue *txq)
 	txe = txq->sw_ring;
 	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
-		((volatile char *)txq->i40e_tx_ring)[i] = 0;
+		((volatile char *)txq->ci_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		volatile struct ci_tx_desc *txd = &txq->i40e_tx_ring[i];
+		volatile struct ci_tx_desc *txd = &txq->ci_tx_ring[i];
 
 		txd->cmd_type_offset_bsz =
 			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE);
@@ -3223,7 +3223,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
 	txq->i40e_vsi = pf->fdir.fdir_vsi;
 
 	txq->tx_ring_dma = tz->iova;
-	txq->i40e_tx_ring = (struct ci_tx_desc *)tz->addr;
+	txq->ci_tx_ring = (struct ci_tx_desc *)tz->addr;
 
 	/*
 	 * don't need to allocate software ring and reset for the fdir
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index ef5b252898..81e9e2bc0b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -489,7 +489,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->i40e_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
@@ -509,7 +509,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->i40e_tx_ring[tx_id];
+		txdp = &txq->ci_tx_ring[tx_id];
 		txep = &txq->sw_ring_vec[tx_id];
 	}
 
@@ -519,7 +519,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
 						I40E_TXD_QW1_CMD_SHIFT);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index 137c1f9765..f054bd41bf 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -753,7 +753,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->i40e_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
@@ -774,7 +774,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->i40e_tx_ring[tx_id];
+		txdp = &txq->ci_tx_ring[tx_id];
 		txep = &txq->sw_ring_vec[tx_id];
 	}
 
@@ -784,7 +784,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
 						I40E_TXD_QW1_CMD_SHIFT);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index 6971488750..9a967faeee 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -821,7 +821,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->i40e_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = (void *)txq->sw_ring;
 	txep += tx_id;
 
@@ -843,7 +843,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = txq->i40e_tx_ring;
+		txdp = txq->ci_tx_ring;
 		txep = (void *)txq->sw_ring;
 	}
 
@@ -853,7 +853,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
 						I40E_TXD_QW1_CMD_SHIFT);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index 14651f2f06..1fd7fc75bf 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -15,7 +15,7 @@
 static inline int
 i40e_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
-	return (txq->i40e_tx_ring[idx].cmd_type_offset_bsz &
+	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
 			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) ==
 				rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE);
 }
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index 6404b70c56..0b95152232 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -638,7 +638,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->i40e_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
@@ -658,7 +658,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->i40e_tx_ring[tx_id];
+		txdp = &txq->ci_tx_ring[tx_id];
 		txep = &txq->sw_ring_vec[tx_id];
 	}
 
@@ -668,7 +668,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
 						I40E_TXD_QW1_CMD_SHIFT);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 2057bf6d8d..ea4aaf08a3 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -283,11 +283,11 @@ reset_tx_queue(struct ci_tx_queue *txq)
 	txe = txq->sw_ring;
 	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
-		((volatile char *)txq->iavf_tx_ring)[i] = 0;
+		((volatile char *)txq->ci_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		txq->iavf_tx_ring[i].cmd_type_offset_bsz =
+		txq->ci_tx_ring[i].cmd_type_offset_bsz =
 			rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
@@ -834,7 +834,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/* Allocate TX hardware ring descriptors. */
 	ring_size = sizeof(struct ci_tx_desc) * IAVF_MAX_RING_DESC;
 	ring_size = RTE_ALIGN(ring_size, IAVF_DMA_MEM_ALIGN);
-	mz = rte_eth_dma_zone_reserve(dev, "iavf_tx_ring", queue_idx,
+	mz = rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
 				      ring_size, IAVF_RING_BASE_ALIGN,
 				      socket_id);
 	if (!mz) {
@@ -844,7 +844,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 	txq->tx_ring_dma = mz->iova;
-	txq->iavf_tx_ring = (struct ci_tx_desc *)mz->addr;
+	txq->ci_tx_ring = (struct ci_tx_desc *)mz->addr;
 
 	txq->mz = mz;
 	reset_tx_queue(txq);
@@ -2338,7 +2338,7 @@ iavf_xmit_cleanup(struct ci_tx_queue *txq)
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
 
-	volatile struct ci_tx_desc *txd = txq->iavf_tx_ring;
+	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
 
 	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
 	if (desc_to_clean_to >= nb_tx_desc)
@@ -2761,7 +2761,7 @@ uint16_t
 iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = tx_queue;
-	volatile struct ci_tx_desc *txr = txq->iavf_tx_ring;
+	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
 	struct ci_tx_entry *txe_ring = txq->sw_ring;
 	struct ci_tx_entry *txe, *txn;
 	struct rte_mbuf *mb, *mb_seg;
@@ -4467,7 +4467,7 @@ iavf_dev_tx_desc_status(void *tx_queue, uint16_t offset)
 			desc -= txq->nb_tx_desc;
 	}
 
-	status = &txq->iavf_tx_ring[desc].cmd_type_offset_bsz;
+	status = &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
 	mask = rte_le_to_cpu_64(IAVF_TXD_QW1_DTYPE_MASK);
 	expect = rte_cpu_to_le_64(
 		 IAVF_TX_DESC_DTYPE_DESC_DONE << IAVF_TXD_QW1_DTYPE_SHIFT);
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 5b62d51cf7..89ce841b9e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1729,7 +1729,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_commit = nb_pkts;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->iavf_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
@@ -1750,7 +1750,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->iavf_tx_ring[tx_id];
+		txdp = &txq->ci_tx_ring[tx_id];
 		txep = &txq->sw_ring_vec[tx_id];
 	}
 
@@ -1760,7 +1760,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->iavf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
 					 IAVF_TXD_QW1_CMD_SHIFT);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index d79d96c7b7..ad1b0b90cd 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2219,7 +2219,7 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_commit = nb_pkts;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->iavf_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = (void *)txq->sw_ring;
 	txep += tx_id;
 
@@ -2241,7 +2241,7 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->iavf_tx_ring[tx_id];
+		txdp = &txq->ci_tx_ring[tx_id];
 		txep = (void *)txq->sw_ring;
 		txep += tx_id;
 	}
@@ -2252,7 +2252,7 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->iavf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
 					 IAVF_TXD_QW1_CMD_SHIFT);
 		txq->tx_next_rs =
@@ -2288,7 +2288,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	nb_pkts = nb_commit >> 1;
 	tx_id = txq->tx_tail;
-	txdp = &txq->iavf_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = (void *)txq->sw_ring;
 	txep += (tx_id >> 1);
 
@@ -2309,7 +2309,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 		tx_id = 0;
 		/* avoid reach the end of ring */
-		txdp = txq->iavf_tx_ring;
+		txdp = txq->ci_tx_ring;
 		txep = (void *)txq->sw_ring;
 	}
 
@@ -2320,7 +2320,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
-		txq->iavf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
 					 IAVF_TXD_QW1_CMD_SHIFT);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index f1ea57034f..1832b76f89 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -14,7 +14,7 @@
 static inline int
 iavf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
-	return (txq->iavf_tx_ring[idx].cmd_type_offset_bsz &
+	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
 			rte_cpu_to_le_64(IAVF_TXD_QW1_DTYPE_MASK)) ==
 				rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
 }
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index ab1d499cef..5f537b4c12 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -401,11 +401,11 @@ reset_tx_queue(struct ci_tx_queue *txq)
 	txe = txq->sw_ring;
 	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
-		((volatile char *)txq->ice_tx_ring)[i] = 0;
+		((volatile char *)txq->ci_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		txq->ice_tx_ring[i].cmd_type_offset_bsz =
+		txq->ci_tx_ring[i].cmd_type_offset_bsz =
 			rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index e431346b84..b1e67c2c67 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1117,11 +1117,11 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
 	txe = txq->sw_ring;
 	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
-		((volatile char *)txq->ice_tx_ring)[i] = 0;
+		((volatile char *)txq->ci_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		volatile struct ci_tx_desc *txd = &txq->ice_tx_ring[i];
+		volatile struct ci_tx_desc *txd = &txq->ci_tx_ring[i];
 
 		txd->cmd_type_offset_bsz =
 			rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE);
@@ -1615,7 +1615,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 	/* Allocate TX hardware ring descriptors. */
 	ring_size = sizeof(struct ci_tx_desc) * ICE_MAX_NUM_DESC_BY_MAC(hw);
 	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
-	tz = rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
+	tz = rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
 				      ring_size, ICE_RING_BASE_ALIGN,
 				      socket_id);
 	if (!tz) {
@@ -1637,7 +1637,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
 	txq->tx_ring_dma = tz->iova;
-	txq->ice_tx_ring = tz->addr;
+	txq->ci_tx_ring = tz->addr;
 
 	/* Allocate software ring */
 	txq->sw_ring =
@@ -2543,7 +2543,7 @@ ice_tx_descriptor_status(void *tx_queue, uint16_t offset)
 			desc -= txq->nb_tx_desc;
 	}
 
-	status = &txq->ice_tx_ring[desc].cmd_type_offset_bsz;
+	status = &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
 	mask = rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M);
 	expect = rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE <<
 				  ICE_TXD_QW1_DTYPE_S);
@@ -2626,7 +2626,7 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
 	txq->ice_vsi = pf->fdir.fdir_vsi;
 
 	txq->tx_ring_dma = tz->iova;
-	txq->ice_tx_ring = (struct ci_tx_desc *)tz->addr;
+	txq->ci_tx_ring = (struct ci_tx_desc *)tz->addr;
 	/*
 	 * don't need to allocate software ring and reset for the fdir
 	 * program queue just set the queue has been configured.
@@ -3015,7 +3015,7 @@ static inline int
 ice_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	volatile struct ci_tx_desc *txd = txq->ice_tx_ring;
+	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
@@ -3136,7 +3136,7 @@ uint16_t
 ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq;
-	volatile struct ci_tx_desc *ice_tx_ring;
+	volatile struct ci_tx_desc *ci_tx_ring;
 	volatile struct ci_tx_desc *txd;
 	struct ci_tx_entry *sw_ring;
 	struct ci_tx_entry *txe, *txn;
@@ -3159,7 +3159,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	txq = tx_queue;
 	sw_ring = txq->sw_ring;
-	ice_tx_ring = txq->ice_tx_ring;
+	ci_tx_ring = txq->ci_tx_ring;
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
 
@@ -3245,7 +3245,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			/* Setup TX context descriptor if required */
 			volatile struct ice_tx_ctx_desc *ctx_txd =
 				(volatile struct ice_tx_ctx_desc *)
-					&ice_tx_ring[tx_id];
+					&ci_tx_ring[tx_id];
 			uint16_t cd_l2tag2 = 0;
 			uint64_t cd_type_cmd_tso_mss = ICE_TX_DESC_DTYPE_CTX;
 
@@ -3287,7 +3287,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		m_seg = tx_pkt;
 
 		do {
-			txd = &ice_tx_ring[tx_id];
+			txd = &ci_tx_ring[tx_id];
 			txn = &sw_ring[txe->next_id];
 
 			if (txe->mbuf)
@@ -3315,7 +3315,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				txe->last_id = tx_last;
 				tx_id = txe->next_id;
 				txe = txn;
-				txd = &ice_tx_ring[tx_id];
+				txd = &ci_tx_ring[tx_id];
 				txn = &sw_ring[txe->next_id];
 			}
 
@@ -3398,7 +3398,7 @@ ice_tx_free_bufs(struct ci_tx_queue *txq)
 	struct ci_tx_entry *txep;
 	uint16_t i;
 
-	if ((txq->ice_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
+	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
 	     rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M)) !=
 	    rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
@@ -3577,7 +3577,7 @@ static inline void
 ice_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 		    uint16_t nb_pkts)
 {
-	volatile struct ci_tx_desc *txdp = &txq->ice_tx_ring[txq->tx_tail];
+	volatile struct ci_tx_desc *txdp = &txq->ci_tx_ring[txq->tx_tail];
 	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
 	const int N_PER_LOOP = 4;
 	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
@@ -3610,7 +3610,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts)
 {
-	volatile struct ci_tx_desc *txr = txq->ice_tx_ring;
+	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
 	uint16_t n = 0;
 
 	/**
@@ -4870,11 +4870,11 @@ ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc)
 	uint16_t i;
 
 	fdirdp = (volatile struct ice_fltr_desc *)
-		(&txq->ice_tx_ring[txq->tx_tail]);
+		(&txq->ci_tx_ring[txq->tx_tail]);
 	fdirdp->qidx_compq_space_stat = fdir_desc->qidx_compq_space_stat;
 	fdirdp->dtype_cmd_vsi_fdid = fdir_desc->dtype_cmd_vsi_fdid;
 
-	txdp = &txq->ice_tx_ring[txq->tx_tail + 1];
+	txdp = &txq->ci_tx_ring[txq->tx_tail + 1];
 	txdp->buffer_addr = rte_cpu_to_le_64(pf->fdir.dma_addr);
 	td_cmd = ICE_TX_DESC_CMD_EOP |
 		ICE_TX_DESC_CMD_RS  |
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index bef7bb00ba..0a1df0b2f6 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -869,7 +869,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->ice_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
@@ -890,7 +890,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->ice_tx_ring[tx_id];
+		txdp = &txq->ci_tx_ring[tx_id];
 		txep = &txq->sw_ring_vec[tx_id];
 	}
 
@@ -900,7 +900,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->ice_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS) <<
 					 ICE_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 1f6bf5fc8e..d42f41461f 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -933,7 +933,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->ice_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = (void *)txq->sw_ring;
 	txep += tx_id;
 
@@ -955,7 +955,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = txq->ice_tx_ring;
+		txdp = txq->ci_tx_ring;
 		txep = (void *)txq->sw_ring;
 	}
 
@@ -965,7 +965,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->ice_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS) <<
 					 ICE_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index ff46a8fb49..8ba591e403 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -11,7 +11,7 @@
 static inline int
 ice_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
-	return (txq->ice_tx_ring[idx].cmd_type_offset_bsz &
+	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
 			rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M)) ==
 				rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE);
 }
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index be3c1ef216..51074bda3a 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -266,11 +266,11 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 	txe = txq->sw_ring;
 	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
-		((volatile char *)txq->idpf_tx_ring)[i] = 0;
+		((volatile char *)txq->ci_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		txq->idpf_tx_ring[i].cmd_type_offset_bsz =
+		txq->ci_tx_ring[i].cmd_type_offset_bsz =
 			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
@@ -1335,7 +1335,7 @@ idpf_xmit_cleanup(struct ci_tx_queue *txq)
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
 
-	volatile struct ci_tx_desc *txd = txq->idpf_tx_ring;
+	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
 
 	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
 	if (desc_to_clean_to >= nb_tx_desc)
@@ -1398,7 +1398,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return nb_tx;
 
 	sw_ring = txq->sw_ring;
-	txr = txq->idpf_tx_ring;
+	txr = txq->ci_tx_ring;
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 5f5d538dcb..04efee3722 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -573,7 +573,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->idpf_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
@@ -594,7 +594,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->idpf_tx_ring[tx_id];
+		txdp = &txq->ci_tx_ring[tx_id];
 		txep = &txq->sw_ring_vec[tx_id];
 	}
 
@@ -604,7 +604,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->idpf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
 					 IDPF_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index c1ec3d1222..d5e5a2ca5f 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1090,7 +1090,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->idpf_tx_ring[tx_id];
+	txdp = &txq->ci_tx_ring[tx_id];
 	txep = (void *)txq->sw_ring;
 	txep += tx_id;
 
@@ -1112,7 +1112,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->idpf_tx_ring[tx_id];
+		txdp = &txq->ci_tx_ring[tx_id];
 		txep = (void *)txq->sw_ring;
 		txep += tx_id;
 	}
@@ -1123,7 +1123,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->idpf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
 					 IDPF_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 9b63e44341..e974eb44b0 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -469,7 +469,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	if (!is_splitq) {
-		txq->idpf_tx_ring = mz->addr;
+		txq->ci_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index 4702061484..b5e8574667 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -31,7 +31,7 @@ idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 	if (txq->complq != NULL)
 		return 1;
 
-	return (txq->idpf_tx_ring[idx].cmd_type_offset_bsz &
+	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
 			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
 				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
 }
-- 
2.51.0

