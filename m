Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E6C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:24:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D39140E26;
	Thu, 27 Mar 2025 15:24:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 74F1040E1D
 for <dev@dpdk.org>; Thu, 27 Mar 2025 15:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743085462; x=1774621462;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Y5zs8gcLaC3FtdKF/pAldTD9Uwn5WvBNybRJxQePVzc=;
 b=ZWk76LfH8tsagpPpme50j8oET2mTnLIe9WKXaVlV8D8P6s+/o40Flfh2
 0L0stDXZVmeDvpjIbemalHWNQPgwxvNYJR65I//kLN2qAUiWM+hCwCDc/
 LFreqFVoeAqZOEr9H/MB6k4YFACJAMsW+E+w56to33jRM3d+RV0yJUkV4
 bJMjmLsRzdkXMOhQo4MTjloDGwbyztp0GOP3Ym0XXs9Ah6oYu5k+VQKZq
 yluiqguf79iuJmBoKompPC5z2F1TXIWgjFvCYOzaKniZabcQDWP2ttJPX
 y6qO07NtDY60sBOu7+eRnfavzvKpGBY3x4mAAXSFoB4cVPB2WkhC3TMR/ g==;
X-CSE-ConnectionGUID: fiFG1fDTQ8OVQzdf61/Nsg==
X-CSE-MsgGUID: AhEcK8TiTxq9/+/y1KifGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54620739"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="54620739"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:24:22 -0700
X-CSE-ConnectionGUID: GJCWkYWsRbWih7lChcOPWA==
X-CSE-MsgGUID: 6xgtyuVMSQKuUVM+68X+ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125171311"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa006.jf.intel.com with ESMTP; 27 Mar 2025 07:24:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 3/3] net/ixgbe: support MDD on VF Tx path
Date: Thu, 27 Mar 2025 14:24:13 +0000
Message-ID: <0791f39f60b4d0c9b14146e90ab69ac565f0e65e.1743085431.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743085431.git.anatoly.burakov@intel.com>
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

According to datasheet for 82599 and similar NICs, the Tx path must set
CC (Check Context) bit in the descriptor in cases when Tx switching is
enabled in the PF. In case of using VF functions, the fact that it is a
VF function implies that Tx switching is enabled, and thus the CC bit
must always be set for all packet descriptors in the VF Tx path.

However, even though it is specified in the datasheet that this should be
the case, it was never checked in hardware, and not setting this bit did
not cause any problems, so VF Tx have not been setting this bit since the
beginning of ixgbe PMD. In later hardware revisions (X550 onwards), a
hardware feature called MDD (malicious driver detection) was introduced,
which, when enabled, will (among other things) check if CC bit is set,
and will stop the Tx queue when it is not. As of this writing, this
feature is not enabled by default on most configurations, but it may be
enabled on some, and may be enabled by default in the future.

To ensure DPDK ixgbe VF driver works across all possible configurations,
this patch enables setting the CC bit across all VF Tx paths (simple,
offload, and vectorized), as well as ensures that the VF driver will set
up relevant context descriptor (as setting CC bit implies a valid context
descriptor must be set up prior to using the Tx path) whenever the VF
driver is being used.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx.h                 |   2 +
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 133 ++++++++++++++++--
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |   4 +
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |   6 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |   6 +-
 5 files changed, 136 insertions(+), 15 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index d9cf4474fc..3b862536f6 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -97,6 +97,8 @@ struct ci_tx_queue {
 			uint8_t hthresh;   /**< Host threshold register. */
 			uint8_t wthresh;   /**< Write-back threshold reg. */
 			uint8_t using_ipsec;  /**< indicates that IPsec TX feature is in use */
+			uint8_t is_vf;   /**< indicates that this is a VF queue */
+			uint8_t vf_ctx_initialized; /**< VF context descriptors initialized */
 		};
 	};
 };
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index b216e0612a..a643f30910 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -89,6 +89,7 @@
 
 /* forward-declare some functions */
 static int ixgbe_is_vf(struct rte_eth_dev *dev);
+static int ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec);
 
 /*********************************************************************
  *
@@ -151,7 +152,8 @@ ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 
 /* Populate 4 descriptors with data from 4 mbufs */
 static inline void
-tx4(volatile union ixgbe_adv_tx_desc *txdp, struct rte_mbuf **pkts)
+tx4(volatile union ixgbe_adv_tx_desc *txdp, struct rte_mbuf **pkts,
+		const uint32_t olinfo_flags)
 {
 	uint64_t buf_dma_addr;
 	uint32_t pkt_len;
@@ -168,7 +170,8 @@ tx4(volatile union ixgbe_adv_tx_desc *txdp, struct rte_mbuf **pkts)
 			rte_cpu_to_le_32((uint32_t)DCMD_DTYP_FLAGS | pkt_len);
 
 		txdp->read.olinfo_status =
-			rte_cpu_to_le_32(pkt_len << IXGBE_ADVTXD_PAYLEN_SHIFT);
+			rte_cpu_to_le_32(pkt_len << IXGBE_ADVTXD_PAYLEN_SHIFT) |
+				olinfo_flags;
 
 		rte_prefetch0(&(*pkts)->pool);
 	}
@@ -176,7 +179,8 @@ tx4(volatile union ixgbe_adv_tx_desc *txdp, struct rte_mbuf **pkts)
 
 /* Populate 1 descriptor with data from 1 mbuf */
 static inline void
-tx1(volatile union ixgbe_adv_tx_desc *txdp, struct rte_mbuf **pkts)
+tx1(volatile union ixgbe_adv_tx_desc *txdp, struct rte_mbuf **pkts,
+		const uint32_t olinfo_flags)
 {
 	uint64_t buf_dma_addr;
 	uint32_t pkt_len;
@@ -189,7 +193,8 @@ tx1(volatile union ixgbe_adv_tx_desc *txdp, struct rte_mbuf **pkts)
 	txdp->read.cmd_type_len =
 			rte_cpu_to_le_32((uint32_t)DCMD_DTYP_FLAGS | pkt_len);
 	txdp->read.olinfo_status =
-			rte_cpu_to_le_32(pkt_len << IXGBE_ADVTXD_PAYLEN_SHIFT);
+			rte_cpu_to_le_32(pkt_len << IXGBE_ADVTXD_PAYLEN_SHIFT) |
+				olinfo_flags;
 	rte_prefetch0(&(*pkts)->pool);
 }
 
@@ -205,6 +210,8 @@ ixgbe_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
 	const int N_PER_LOOP = 4;
 	const int N_PER_LOOP_MASK = N_PER_LOOP-1;
+	/* for VF queues, need to set CC bit. context idx is always 0. */
+	const uint32_t olinfo_flags = txq->is_vf ? IXGBE_ADVTXD_CC : 0;
 	int mainpart, leftover;
 	int i, j;
 
@@ -219,13 +226,13 @@ ixgbe_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 		for (j = 0; j < N_PER_LOOP; ++j) {
 			(txep + i + j)->mbuf = *(pkts + i + j);
 		}
-		tx4(txdp + i, pkts + i);
+		tx4(txdp + i, pkts + i, olinfo_flags);
 	}
 
 	if (unlikely(leftover > 0)) {
 		for (i = 0; i < leftover; ++i) {
 			(txep + mainpart + i)->mbuf = *(pkts + mainpart + i);
-			tx1(txdp + mainpart + i, pkts + mainpart + i);
+			tx1(txdp + mainpart + i, pkts + mainpart + i, olinfo_flags);
 		}
 	}
 }
@@ -320,8 +327,18 @@ uint16_t
 ixgbe_xmit_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts,
 		       uint16_t nb_pkts)
 {
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	uint16_t nb_tx;
 
+	/* we might check first packet's mempool */
+	if (unlikely(nb_pkts == 0))
+		return nb_pkts;
+
+	/* check if we need to initialize default context descriptor */
+	if (unlikely(!txq->vf_ctx_initialized) &&
+			ixgbe_write_default_ctx_desc(txq, tx_pkts[0]->pool, false))
+		return 0;
+
 	/* Try to transmit at least chunks of TX_MAX_BURST pkts */
 	if (likely(nb_pkts <= RTE_PMD_IXGBE_TX_MAX_BURST))
 		return tx_xmit_pkts(tx_queue, tx_pkts, nb_pkts);
@@ -349,6 +366,15 @@ ixgbe_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint16_t nb_tx = 0;
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
+	/* we might check first packet's mempool */
+	if (unlikely(nb_pkts == 0))
+		return nb_pkts;
+
+	/* check if we need to initialize default context descriptor */
+	if (unlikely(!txq->vf_ctx_initialized) &&
+			ixgbe_write_default_ctx_desc(txq, tx_pkts[0]->pool, true))
+		return 0;
+
 	while (nb_pkts) {
 		uint16_t ret, num;
 
@@ -707,6 +733,14 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			/* Only allocate context descriptor if required*/
 			new_ctx = (ctx == IXGBE_CTX_NUM);
 			ctx = txq->ctx_curr;
+		} else if (txq->is_vf) {
+			/* create default context descriptor for VF */
+			tx_offload.l2_len = RTE_ETHER_HDR_LEN;
+			/* If new context need be built or reuse the exist ctx. */
+			ctx = what_advctx_update(txq, 0, tx_offload);
+			/* Only allocate context descriptor if required */
+			new_ctx = (ctx == IXGBE_CTX_NUM);
+			ctx = txq->ctx_curr;
 		}
 
 		/*
@@ -831,7 +865,7 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 #endif
 
 		olinfo_status = 0;
-		if (tx_ol_req) {
+		if (tx_ol_req || new_ctx) {
 
 			if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
 				/* when TSO is on, paylen in descriptor is the
@@ -877,7 +911,11 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			olinfo_status |= tx_desc_cksum_flags_to_olinfo(ol_flags);
 			olinfo_status |= ctx << IXGBE_ADVTXD_IDX_SHIFT;
 		}
-
+		/* for VF, always set CC bit and set valid ctx */
+		if (txq->is_vf) {
+			olinfo_status |= IXGBE_ADVTXD_CC;
+			olinfo_status |= ctx << IXGBE_ADVTXD_IDX_SHIFT;
+		}
 		olinfo_status |= (pkt_len << IXGBE_ADVTXD_PAYLEN_SHIFT);
 #ifdef RTE_LIB_SECURITY
 		if (use_ipsec)
@@ -2337,6 +2375,49 @@ ixgbe_recv_pkts_lro_bulk_alloc(void *rx_queue, struct rte_mbuf **rx_pkts,
  *
  **********************************************************************/
 
+static inline int
+ixgbe_write_default_ctx_desc(struct ci_tx_queue *txq, struct rte_mempool *mp, bool vec)
+{
+	volatile struct ixgbe_adv_tx_context_desc *ctx_txd;
+	struct rte_mbuf *dummy;
+	uint32_t vlan_macip_lens, type_tucmd_mlhl;
+
+	/* allocate a dummy mbuf from tx pool to make sure it can be freed later */
+	dummy = rte_pktmbuf_alloc(mp);
+	if (dummy == NULL) {
+		PMD_INIT_LOG(ERR, "Failed to allocate dummy mbuf for VF context descriptor");
+		return -1;
+	}
+
+	/* take first buffer in the ring and make it a context descriptor */
+	ctx_txd = (volatile struct ixgbe_adv_tx_context_desc *)&txq->ixgbe_tx_ring[txq->tx_tail];
+
+	/* populate default context descriptor for VF */
+	vlan_macip_lens = RTE_ETHER_HDR_LEN << IXGBE_ADVTXD_MACLEN_SHIFT;
+	type_tucmd_mlhl = IXGBE_ADVTXD_TUCMD_L4T_RSV |
+			IXGBE_ADVTXD_DTYP_CTXT | IXGBE_ADVTXD_DCMD_DEXT;
+	ctx_txd->vlan_macip_lens = rte_cpu_to_le_32(vlan_macip_lens);
+	ctx_txd->type_tucmd_mlhl = rte_cpu_to_le_32(type_tucmd_mlhl);
+
+	/* update SW ring */
+	if (vec) {
+		struct ci_tx_entry_vec *txve;
+		txve = &txq->sw_ring_vec[txq->tx_tail];
+		txve->mbuf = dummy;
+	} else {
+		struct ci_tx_entry *txe;
+		txe = &txq->sw_ring[txq->tx_tail];
+		txe->mbuf = dummy;
+	}
+	txq->nb_tx_free--;
+	txq->tx_tail++;
+
+	/* never come back until queue reset */
+	txq->vf_ctx_initialized = 1;
+
+	return 0;
+}
+
 static int
 ixgbe_tx_done_cleanup_full(struct ci_tx_queue *txq, uint32_t free_cnt)
 {
@@ -2510,7 +2591,34 @@ ixgbe_reset_tx_queue(struct ci_tx_queue *txq)
 	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
 	txq->ctx_curr = 0;
-	memset(txq->ctx_cache, 0, IXGBE_CTX_NUM * sizeof(struct ixgbe_advctx_info));
+	/*
+	 * When doing Tx on a VF queue, we need to set CC bit and specify a
+	 * valid context descriptor regardless of whether we are using any
+	 * offloads.
+	 *
+	 * For simple/vector Tx paths, a default context descriptor will always
+	 * be created on Tx start, so we do not need any special handling here.
+	 * However, for full offload path, we will be dynamically switching
+	 * between two context descriptors (and create new ones when necessary)
+	 * based on what kind of offloads are enabled for each packet, so we
+	 * need to prepare the offload cache accordingly.
+	 *
+	 * In case of VF, because we might be transmitting packets with and
+	 * without offloads (both of which require context descriptors), we need
+	 * to distinguish between "packet with no offloads" and "packet with no
+	 * offloads but we've already created a context for it" cases. This
+	 * works fine on switchover from having filled offload context cache
+	 * previously as no-offload case won't match previously created context,
+	 * but to make this work in cases where no previous packets had offloads
+	 * (such as on Tx start), we poison the offload cache, so that
+	 * no-offload packet also triggers creation of new context descriptor
+	 * due to offload cache mismatch.
+	 */
+	memset(txq->ctx_cache, 0xFF, IXGBE_CTX_NUM * sizeof(struct ixgbe_advctx_info));
+
+	/* for PF, we do not need to initialize the context descriptor */
+	if (!txq->is_vf)
+		txq->vf_ctx_initialized = 1;
 }
 
 static const struct ixgbe_txq_ops def_txq_ops = {
@@ -2769,10 +2877,13 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Modification to set VFTDT for virtual function if vf is detected
 	 */
-	if (ixgbe_is_vf(dev))
+	if (ixgbe_is_vf(dev)) {
+		/* mark this queue as VF, because VF needs special Tx behavior */
+		txq->is_vf = 1;
 		txq->qtx_tail = IXGBE_PCI_REG_ADDR(hw, IXGBE_VFTDT(queue_idx));
-	else
+	} else {
 		txq->qtx_tail = IXGBE_PCI_REG_ADDR(hw, IXGBE_TDT(txq->reg_idx));
+	}
 
 	txq->tx_ring_dma = tz->iova;
 	txq->ixgbe_tx_ring = (union ixgbe_adv_tx_desc *)tz->addr;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index 3768e99039..018010820f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -141,6 +141,10 @@ _ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq)
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
 	txq->ctx_curr = 0;
 	memset(txq->ctx_cache, 0, IXGBE_CTX_NUM * sizeof(struct ixgbe_advctx_info));
+
+	/* for PF, we do not need to initialize the context descriptor */
+	if (!txq->is_vf)
+		txq->vf_ctx_initialized = 1;
 }
 
 static inline int
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index 93e2949660..9ccd8eba25 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -573,8 +573,10 @@ ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile union ixgbe_adv_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = DCMD_DTYP_FLAGS;
-	uint64_t rs = IXGBE_ADVTXD_DCMD_RS | DCMD_DTYP_FLAGS;
+	/* for VF, we need to set CC bit */
+	const uint64_t cc = txq->is_vf ? (uint64_t)IXGBE_ADVTXD_CC << 32ULL : 0;
+	uint64_t flags = DCMD_DTYP_FLAGS | cc;
+	uint64_t rs = IXGBE_ADVTXD_DCMD_RS | DCMD_DTYP_FLAGS | cc;
 	int i;
 
 	/* cross rx_thresh boundary is not allowed */
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index 9fc3447257..e125f52cc5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -693,8 +693,10 @@ ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile union ixgbe_adv_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = DCMD_DTYP_FLAGS;
-	uint64_t rs = IXGBE_ADVTXD_DCMD_RS|DCMD_DTYP_FLAGS;
+	/* for VF, we need to set CC bit */
+	const uint64_t cc = txq->is_vf ? (uint64_t)IXGBE_ADVTXD_CC << 32ULL : 0;
+	uint64_t flags = DCMD_DTYP_FLAGS | cc;
+	uint64_t rs = IXGBE_ADVTXD_DCMD_RS | DCMD_DTYP_FLAGS | cc;
 	int i;
 
 	/* cross rx_thresh boundary is not allowed */
-- 
2.47.1

