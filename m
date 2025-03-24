Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC8C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 12:38:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA24140A77;
	Mon, 24 Mar 2025 13:38:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0B8BF402DA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 13:38:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742819922; x=1774355922;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kpABy/ULxxOXG4GedjYz/5GaoDt2D++t0xafzd9J4mU=;
 b=l5R+QIlzQs++kRZ5O7Tm6wdAKrtcqVWrOqNel3e2f8uswYymvxVK1R5i
 qeWVglG7GOgCOpjVpJOsKIQ7s9eBja47RI/iRWWsXJb45wTotN0xGeQww
 YrYkj3RZzy6uQSB7YH2nv2eqUpeAhE86iMaTNkmOQ41poHznjZvpaL34N
 CFM1RSP6+z2oz3x0c12o1S6LUBJYJ34g++mbcqbnf8tAnvVDGQ9CxANXR
 KcdAmteFylsF+5gP2m7IRNpUpl+eCCDA6Jw+Mds5YW+v7lmE6kKDo49n+
 svJYid5lNgoOUQFfnlCh1JGEWuBihNizl1/g8kGge2+SER5bvs1hYVi7s Q==;
X-CSE-ConnectionGUID: +QNZmYS/Q3C4j0I+nUthDw==
X-CSE-MsgGUID: UUMQRz58RBOTeFS1KKOPAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="54227007"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="54227007"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 05:38:41 -0700
X-CSE-ConnectionGUID: ZBLCjMQUQfeAj+XeLRY4cA==
X-CSE-MsgGUID: CRvZ0eY3SzOCp4MK+lUlQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="154943689"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa002.jf.intel.com with ESMTP; 24 Mar 2025 05:38:39 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2 1/4] net/intel: use common Tx queue structure
Date: Mon, 24 Mar 2025 18:09:58 +0530
Message-Id: <20250324124001.1282624-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324124001.1282624-1-shaiq.wani@intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250324124001.1282624-1-shaiq.wani@intel.com>
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

Merge in additional fields used by the idpf driver and then convert it
over to using the common Tx queue structure.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/common/tx.h                 | 18 ++++++
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  2 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |  2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 26 ++++-----
 drivers/net/intel/cpfl/cpfl_rxtx.h            |  2 +-
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  2 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 24 ++++----
 drivers/net/intel/idpf/idpf_common_rxtx.h     | 56 +++----------------
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  6 +-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 20 +++----
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  2 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.h |  2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |  2 +-
 drivers/net/intel/idpf/idpf_rxtx.c            | 22 ++++----
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  4 +-
 15 files changed, 82 insertions(+), 108 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index d9cf4474fc..49722026de 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -35,6 +35,7 @@ struct ci_tx_queue {
 		volatile struct i40e_tx_desc *i40e_tx_ring;
 		volatile struct iavf_tx_desc *iavf_tx_ring;
 		volatile struct ice_tx_desc *ice_tx_ring;
+		volatile struct idpf_base_tx_desc *idpf_tx_ring;
 		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
 	};
 	volatile uint8_t *qtx_tail;               /* register address of tail */
@@ -98,6 +99,23 @@ struct ci_tx_queue {
 			uint8_t wthresh;   /**< Write-back threshold reg. */
 			uint8_t using_ipsec;  /**< indicates that IPsec TX feature is in use */
 		};
+		struct { /* idpf specific values */
+			volatile union {
+				struct idpf_flex_tx_sched_desc *desc_ring;
+				struct idpf_splitq_tx_compl_desc *compl_ring;
+			};
+			bool q_started;
+			const struct idpf_txq_ops *idpf_ops;
+			struct ci_tx_queue *complq;
+			/* only valid for split queue mode */
+			void **txqs;
+			uint32_t tx_start_qid;
+			uint16_t sw_nb_desc;
+			uint16_t sw_tail;
+			uint8_t expected_gen_id;
+#define IDPF_TX_CTYPE_NUM	8
+			uint16_t ctype[IDPF_TX_CTYPE_NUM];
+		};
 	};
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 1817221652..2f071082e1 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1167,7 +1167,7 @@ cpfl_hairpin_get_peer_ports(struct rte_eth_dev *dev, uint16_t *peer_ports,
 {
 	struct cpfl_vport *cpfl_vport =
 		(struct cpfl_vport *)dev->data->dev_private;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	struct idpf_rx_queue *rxq;
 	struct cpfl_tx_queue *cpfl_txq;
 	struct cpfl_rx_queue *cpfl_rxq;
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index 9a38a69194..d4e1176ab1 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -174,7 +174,7 @@ struct cpfl_vport {
 	uint16_t nb_p2p_txq;
 
 	struct idpf_rx_queue *p2p_rx_bufq;
-	struct idpf_tx_queue *p2p_tx_complq;
+	struct ci_tx_queue *p2p_tx_complq;
 	bool p2p_manual_bind;
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 47351ca102..cf4320df0c 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -11,7 +11,7 @@
 #include "cpfl_rxtx_vec_common.h"
 
 static inline void
-cpfl_tx_hairpin_descq_reset(struct idpf_tx_queue *txq)
+cpfl_tx_hairpin_descq_reset(struct ci_tx_queue *txq)
 {
 	uint32_t i, size;
 
@@ -26,7 +26,7 @@ cpfl_tx_hairpin_descq_reset(struct idpf_tx_queue *txq)
 }
 
 static inline void
-cpfl_tx_hairpin_complq_reset(struct idpf_tx_queue *cq)
+cpfl_tx_hairpin_complq_reset(struct ci_tx_queue *cq)
 {
 	uint32_t i, size;
 
@@ -320,7 +320,7 @@ static void
 cpfl_tx_queue_release(void *txq)
 {
 	struct cpfl_tx_queue *cpfl_txq = txq;
-	struct idpf_tx_queue *q = NULL;
+	struct ci_tx_queue *q = NULL;
 
 	if (cpfl_txq == NULL)
 		return;
@@ -468,18 +468,18 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 }
 
 static int
-cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
+cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 		     uint16_t queue_idx, uint16_t nb_desc,
 		     unsigned int socket_id)
 {
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
 	const struct rte_memzone *mz;
-	struct idpf_tx_queue *cq;
+	struct ci_tx_queue *cq;
 	int ret;
 
 	cq = rte_zmalloc_socket("cpfl splitq cq",
-				sizeof(struct idpf_tx_queue),
+				sizeof(struct ci_tx_queue),
 				RTE_CACHE_LINE_SIZE,
 				socket_id);
 	if (cq == NULL) {
@@ -528,7 +528,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct cpfl_tx_queue *cpfl_txq;
 	struct idpf_hw *hw = &base->hw;
 	const struct rte_memzone *mz;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	uint64_t offloads;
 	uint16_t len;
 	bool is_splitq;
@@ -589,7 +589,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->mz = mz;
 
 	txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
-					  sizeof(struct idpf_tx_entry) * len,
+					  sizeof(struct ci_tx_entry) * len,
 					  RTE_CACHE_LINE_SIZE, socket_id);
 	if (txq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
@@ -789,7 +789,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct cpfl_txq_hairpin_info *hairpin_info;
 	struct idpf_hw *hw = &adapter_base->hw;
 	struct cpfl_tx_queue *cpfl_txq;
-	struct idpf_tx_queue *txq, *cq;
+	struct ci_tx_queue *txq, *cq;
 	const struct rte_memzone *mz;
 	uint32_t ring_size;
 	uint16_t peer_port, peer_q;
@@ -872,7 +872,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	if (cpfl_vport->p2p_tx_complq == NULL) {
 		cq = rte_zmalloc_socket("cpfl hairpin cq",
-					sizeof(struct idpf_tx_queue),
+					sizeof(struct ci_tx_queue),
 					RTE_CACHE_LINE_SIZE,
 					dev->device->numa_node);
 		if (!cq) {
@@ -974,7 +974,7 @@ cpfl_hairpin_rxq_config(struct idpf_vport *vport, struct cpfl_rx_queue *cpfl_rxq
 int
 cpfl_hairpin_tx_complq_config(struct cpfl_vport *cpfl_vport)
 {
-	struct idpf_tx_queue *tx_complq = cpfl_vport->p2p_tx_complq;
+	struct ci_tx_queue *tx_complq = cpfl_vport->p2p_tx_complq;
 	struct virtchnl2_txq_info txq_info;
 
 	memset(&txq_info, 0, sizeof(txq_info));
@@ -993,7 +993,7 @@ cpfl_hairpin_tx_complq_config(struct cpfl_vport *cpfl_vport)
 int
 cpfl_hairpin_txq_config(struct idpf_vport *vport, struct cpfl_tx_queue *cpfl_txq)
 {
-	struct idpf_tx_queue *txq = &cpfl_txq->base;
+	struct ci_tx_queue *txq = &cpfl_txq->base;
 	struct virtchnl2_txq_info txq_info;
 
 	memset(&txq_info, 0, sizeof(txq_info));
@@ -1321,7 +1321,7 @@ cpfl_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
 	struct cpfl_tx_queue *cpfl_txq;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int err;
 
 	if (tx_queue_id >= dev->data->nb_tx_queues)
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.h b/drivers/net/intel/cpfl/cpfl_rxtx.h
index aacd087b56..314a233e6d 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.h
@@ -70,7 +70,7 @@ struct cpfl_txq_hairpin_info {
 };
 
 struct cpfl_tx_queue {
-	struct idpf_tx_queue base;
+	struct ci_tx_queue base;
 	struct cpfl_txq_hairpin_info hairpin_info;
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
index 5b98f86932..eb730ea377 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
@@ -49,7 +49,7 @@ cpfl_rx_vec_queue_default(struct idpf_rx_queue *rxq)
 }
 
 static inline int
-cpfl_tx_vec_queue_default(struct idpf_tx_queue *txq)
+cpfl_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
 	if (txq == NULL)
 		return CPFL_SCALAR_PATH;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 7171e27b8d..3e8f24ac38 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -90,7 +90,7 @@ idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq)
 }
 
 void
-idpf_qc_txq_mbufs_release(struct idpf_tx_queue *txq)
+idpf_qc_txq_mbufs_release(struct ci_tx_queue *txq)
 {
 	uint16_t nb_desc, i;
 
@@ -208,7 +208,7 @@ idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
 }
 
 void
-idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
+idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_entry *txe;
 	uint32_t i, size;
@@ -246,7 +246,7 @@ idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
 }
 
 void
-idpf_qc_split_tx_complq_reset(struct idpf_tx_queue *cq)
+idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
 {
 	uint32_t i, size;
 
@@ -264,7 +264,7 @@ idpf_qc_split_tx_complq_reset(struct idpf_tx_queue *cq)
 }
 
 void
-idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
+idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_entry *txe;
 	uint32_t i, size;
@@ -333,7 +333,7 @@ idpf_qc_rx_queue_release(void *rxq)
 void
 idpf_qc_tx_queue_release(void *txq)
 {
-	struct idpf_tx_queue *q = txq;
+	struct ci_tx_queue *q = txq;
 
 	if (q == NULL)
 		return;
@@ -750,13 +750,13 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline void
-idpf_split_tx_free(struct idpf_tx_queue *cq)
+idpf_split_tx_free(struct ci_tx_queue *cq)
 {
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
 	struct idpf_tx_entry *txe;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
 	uint8_t ctype;
@@ -860,7 +860,7 @@ uint16_t
 idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txr;
 	volatile struct idpf_flex_tx_sched_desc *txd;
 	struct idpf_tx_entry *sw_ring;
@@ -874,7 +874,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint8_t cmd_dtype;
 	uint16_t nb_ctx;
 
-	if (unlikely(txq == NULL) || unlikely(!txq->q_started))
+	if (unlikely(txq == NULL))
 		return nb_tx;
 
 	txr = txq->desc_ring;
@@ -1302,7 +1302,7 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline int
-idpf_xmit_cleanup(struct idpf_tx_queue *txq)
+idpf_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
 	struct idpf_tx_entry *sw_ring = txq->sw_ring;
@@ -1351,7 +1351,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	union idpf_tx_offload tx_offload = {0};
 	struct idpf_tx_entry *txe, *txn;
 	struct idpf_tx_entry *sw_ring;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
 	uint64_t buf_dma_addr;
@@ -1368,7 +1368,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_tx = 0;
 	txq = tx_queue;
 
-	if (unlikely(txq == NULL) || unlikely(!txq->q_started))
+	if (unlikely(txq == NULL))
 		return nb_tx;
 
 	sw_ring = txq->sw_ring;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index e19e1878f3..ea94acf9f9 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -154,48 +154,6 @@ struct idpf_tx_entry {
 	uint16_t last_id;
 };
 
-/* Structure associated with each TX queue. */
-struct idpf_tx_queue {
-	const struct rte_memzone *mz;		/* memzone for Tx ring */
-	volatile struct idpf_base_tx_desc *tx_ring;	/* Tx ring virtual address */
-	volatile union {
-		struct idpf_flex_tx_sched_desc *desc_ring;
-		struct idpf_splitq_tx_compl_desc *compl_ring;
-	};
-	uint64_t tx_ring_phys_addr;		/* Tx ring DMA address */
-	struct idpf_tx_entry *sw_ring;		/* address array of SW ring */
-
-	uint16_t nb_tx_desc;		/* ring length */
-	uint16_t tx_tail;		/* current value of tail */
-	volatile uint8_t *qtx_tail;	/* register address of tail */
-	/* number of used desc since RS bit set */
-	uint16_t nb_used;
-	uint16_t nb_free;
-	uint16_t last_desc_cleaned;	/* last desc have been cleaned*/
-	uint16_t free_thresh;
-	uint16_t rs_thresh;
-
-	uint16_t port_id;
-	uint16_t queue_id;
-	uint64_t offloads;
-	uint16_t next_dd;	/* next to set RS, for VPMD */
-	uint16_t next_rs;	/* next to check DD,  for VPMD */
-
-	bool q_set;		/* if tx queue has been configured */
-	bool q_started;		/* if tx queue has been started */
-	bool tx_deferred_start; /* don't start this queue in dev start */
-	const struct idpf_txq_ops *ops;
-
-	/* only valid for split queue mode */
-	uint16_t sw_nb_desc;
-	uint16_t sw_tail;
-	void **txqs;
-	uint32_t tx_start_qid;
-	uint8_t expected_gen_id;
-	struct idpf_tx_queue *complq;
-	uint16_t ctype[IDPF_TX_CTYPE_NUM];
-};
-
 /* Offload features */
 union idpf_tx_offload {
 	uint64_t data;
@@ -223,7 +181,7 @@ struct idpf_rxq_ops {
 };
 
 struct idpf_txq_ops {
-	void (*release_mbufs)(struct idpf_tx_queue *txq);
+	void (*release_mbufs)(struct ci_tx_queue *txq);
 };
 
 extern int idpf_timestamp_dynfield_offset;
@@ -237,7 +195,7 @@ int idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 __rte_internal
 void idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq);
 __rte_internal
-void idpf_qc_txq_mbufs_release(struct idpf_tx_queue *txq);
+void idpf_qc_txq_mbufs_release(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq);
 __rte_internal
@@ -247,11 +205,11 @@ void idpf_qc_split_rx_queue_reset(struct idpf_rx_queue *rxq);
 __rte_internal
 void idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq);
 __rte_internal
-void idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq);
+void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
 __rte_internal
-void idpf_qc_split_tx_complq_reset(struct idpf_tx_queue *cq);
+void idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq);
 __rte_internal
-void idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq);
+void idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_rx_queue_release(void *rxq);
 __rte_internal
@@ -282,9 +240,9 @@ int idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq);
 __rte_internal
 int idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rxq);
 __rte_internal
-int idpf_qc_tx_vec_avx512_setup(struct idpf_tx_queue *txq);
+int idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq);
 __rte_internal
-int idpf_qc_tx_vec_avx512_setup(struct idpf_tx_queue *txq);
+int idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq);
 __rte_internal
 uint16_t idpf_dp_singleq_recv_pkts_avx512(void *rx_queue,
 					  struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 43a95466ae..948b95e79f 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -489,7 +489,7 @@ idpf_tx_backlog_entry(struct idpf_tx_entry *txep,
 }
 
 static __rte_always_inline int
-idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
+idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_entry *txep;
 	uint32_t n;
@@ -619,7 +619,7 @@ static inline uint16_t
 idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 				       uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
 	struct idpf_tx_entry *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -687,7 +687,7 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts)
 {
 	uint16_t nb_tx = 0;
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index b630d1fcd9..f215583edf 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -996,7 +996,7 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static __rte_always_inline int
-idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_vec_entry *txep;
 	uint32_t n;
@@ -1193,7 +1193,7 @@ static __rte_always_inline uint16_t
 idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					 uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = tx_queue;
+	struct ci_tx_queue *txq = tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
 	struct idpf_tx_vec_entry *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -1264,7 +1264,7 @@ idpf_singleq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts)
 {
 	uint16_t nb_tx = 0;
-	struct idpf_tx_queue *txq = tx_queue;
+	struct ci_tx_queue *txq = tx_queue;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
@@ -1289,10 +1289,10 @@ idpf_dp_singleq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 static __rte_always_inline void
-idpf_splitq_scan_cq_ring(struct idpf_tx_queue *cq)
+idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
 {
 	struct idpf_splitq_tx_compl_desc *compl_ring;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	uint16_t genid, txq_qid, cq_qid, i;
 	uint8_t ctype;
 
@@ -1321,7 +1321,7 @@ idpf_splitq_scan_cq_ring(struct idpf_tx_queue *cq)
 }
 
 static __rte_always_inline int
-idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_splitq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_vec_entry *txep;
 	uint32_t n;
@@ -1496,7 +1496,7 @@ static __rte_always_inline uint16_t
 idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txdp;
 	struct idpf_tx_vec_entry *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -1560,7 +1560,7 @@ static __rte_always_inline uint16_t
 idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 				     uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	uint16_t nb_tx = 0;
 
 	while (nb_pkts) {
@@ -1592,7 +1592,7 @@ idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 static inline void
-idpf_tx_release_mbufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_release_mbufs_avx512(struct ci_tx_queue *txq)
 {
 	unsigned int i;
 	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
@@ -1620,7 +1620,7 @@ static const struct idpf_txq_ops avx512_tx_vec_ops = {
 };
 
 int __rte_cold
-idpf_qc_tx_vec_avx512_setup(struct idpf_tx_queue *txq)
+idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
 {
 	if (!txq)
 		return 0;
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index 0ae1d55d79..11394d28b7 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -1074,7 +1074,7 @@ int idpf_vc_rxq_config_by_info(struct idpf_vport *vport, struct virtchnl2_rxq_in
 }
 
 int
-idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
+idpf_vc_txq_config(struct idpf_vport *vport, struct ci_tx_queue *txq)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	struct virtchnl2_config_tx_queues *vc_txqs = NULL;
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.h b/drivers/net/intel/idpf/idpf_common_virtchnl.h
index d6555978d5..68cba9111c 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.h
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.h
@@ -50,7 +50,7 @@ int idpf_vc_one_msg_read(struct idpf_adapter *adapter, uint32_t ops,
 __rte_internal
 int idpf_vc_rxq_config(struct idpf_vport *vport, struct idpf_rx_queue *rxq);
 __rte_internal
-int idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq);
+int idpf_vc_txq_config(struct idpf_vport *vport, struct ci_tx_queue *txq);
 __rte_internal
 int idpf_vc_stats_query(struct idpf_vport *vport,
 			struct virtchnl2_vport_stats **pstats);
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 7718167096..e722f4d3e8 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -709,7 +709,7 @@ static int
 idpf_start_queues(struct rte_eth_dev *dev)
 {
 	struct idpf_rx_queue *rxq;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int err = 0;
 	int i;
 
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 0c3ecd2765..ed02cf5bcb 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -346,17 +346,17 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 }
 
 static int
-idpf_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
+idpf_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 		     uint16_t queue_idx, uint16_t nb_desc,
 		     unsigned int socket_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
 	const struct rte_memzone *mz;
-	struct idpf_tx_queue *cq;
+	struct ci_tx_queue *cq;
 	int ret;
 
 	cq = rte_zmalloc_socket("idpf splitq cq",
-				sizeof(struct idpf_tx_queue),
+				sizeof(struct ci_tx_queue),
 				RTE_CACHE_LINE_SIZE,
 				socket_id);
 	if (cq == NULL) {
@@ -403,7 +403,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	uint16_t tx_rs_thresh, tx_free_thresh;
 	struct idpf_hw *hw = &adapter->hw;
 	const struct rte_memzone *mz;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	uint64_t offloads;
 	uint16_t len;
 	bool is_splitq;
@@ -426,7 +426,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	/* Allocate the TX queue data structure. */
 	txq = rte_zmalloc_socket("idpf txq",
-				 sizeof(struct idpf_tx_queue),
+				 sizeof(struct ci_tx_queue),
 				 RTE_CACHE_LINE_SIZE,
 				 socket_id);
 	if (txq == NULL) {
@@ -612,7 +612,7 @@ idpf_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 int
 idpf_tx_queue_init(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 
 	if (tx_queue_id >= dev->data->nb_tx_queues)
 		return -EINVAL;
@@ -629,7 +629,7 @@ int
 idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
-	struct idpf_tx_queue *txq =
+	struct ci_tx_queue *txq =
 		dev->data->tx_queues[tx_queue_id];
 	int err = 0;
 
@@ -653,7 +653,6 @@ idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		PMD_DRV_LOG(ERR, "Failed to switch TX queue %u on",
 			    tx_queue_id);
 	} else {
-		txq->q_started = true;
 		dev->data->tx_queue_state[tx_queue_id] =
 			RTE_ETH_QUEUE_STATE_STARTED;
 	}
@@ -698,7 +697,7 @@ int
 idpf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int err;
 
 	if (tx_queue_id >= dev->data->nb_tx_queues)
@@ -713,7 +712,6 @@ idpf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	}
 
 	txq = dev->data->tx_queues[tx_queue_id];
-	txq->q_started = false;
 	txq->ops->release_mbufs(txq);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		idpf_qc_single_tx_queue_reset(txq);
@@ -742,7 +740,7 @@ void
 idpf_stop_queues(struct rte_eth_dev *dev)
 {
 	struct idpf_rx_queue *rxq;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int i;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -880,7 +878,7 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	struct idpf_vport *vport = dev->data->dev_private;
 #ifdef RTE_ARCH_X86
 #ifdef CC_AVX512_SUPPORT
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int i;
 #endif /* CC_AVX512_SUPPORT */
 
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index 002c1e6948..979e7f38bb 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -49,7 +49,7 @@ idpf_rx_vec_queue_default(struct idpf_rx_queue *rxq)
 }
 
 static inline int
-idpf_tx_vec_queue_default(struct idpf_tx_queue *txq)
+idpf_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
 	if (txq == NULL)
 		return IDPF_SCALAR_PATH;
@@ -103,7 +103,7 @@ static inline int
 idpf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 {
 	int i;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int ret = 0;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
-- 
2.34.1

