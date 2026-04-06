Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A7FE9D835
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 04:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 270C74026D;
	Mon,  6 Apr 2026 06:46:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id CC72440265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 06:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775450787; x=1806986787;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nSCIDWl5Ewk0N6G0PCFV1SF0rXeCPRfgsrpKLI2cAeg=;
 b=lgzfgdHAxogKqylgjvhkFLqP93RZko6TgbCFIwigYeoo8w68TmwHKzN8
 oCrZnH+1peGf+mymga45RRkT+UTbvBBiSXc614qzcjyK2OjcutliCW0cD
 t2O5J0BXX1L7VSnR+yxGKSQCmdoVGUxOZgMmwK/VL99xoC2NCPA+Vn02B
 ckR1sc6AN15ZB6atv/OGqjucrcWiyMEWsed9CxDRYKzY6FFXSMNEL1Ggx
 aVnS+yXuVCVcCSekS+9W+oEZ74CAbJrlpkHCw6+wcAeg+KDfAkpOrvxOS
 HIAEM653b96TYryGqrPBbrwA1NEVCmEFPc/kGJkl2DHRN3hr+mzr7fH5c Q==;
X-CSE-ConnectionGUID: Q37Wx5/jTEGEi+dDlMzgPw==
X-CSE-MsgGUID: QaITmD26Qfy9QFhOkZ3gEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="76123355"
X-IronPort-AV: E=Sophos;i="6.23,162,1770624000"; d="scan'208";a="76123355"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2026 21:46:26 -0700
X-CSE-ConnectionGUID: BojzSehRQOi8n2jVD0Va/g==
X-CSE-MsgGUID: 3ih0NYx7RKOaORZ2EzcAjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,162,1770624000"; d="scan'208";a="232645561"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa005.fm.intel.com with ESMTP; 05 Apr 2026 21:46:24 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/intel: introduce a dedicated idpf complq struct
Date: Mon,  6 Apr 2026 10:11:25 +0530
Message-ID: <20260406044125.3170558-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
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

The IDPF split-queue completion queue was using ci_tx_queue, a structure
designed for TX descriptor queues, wasting ~96 bytes per completion
queue. Additionally, the CQ-only fields (compl_ring, txqs, tx_start_qid,
expected_gen_id) bloated ci_tx_queue for every other Intel driver that
shares it.

Introduce struct idpf_complq with exactly the fields needed by the
completion queue. This brings the CQ allocation down from ~150 bytes
to ~48 bytes.

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/common/tx.h                    | 11 +++--------
 drivers/net/intel/cpfl/cpfl_ethdev.h             |  2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c               | 11 ++++++-----
 drivers/net/intel/idpf/idpf_common_rxtx.c        |  4 ++--
 drivers/net/intel/idpf/idpf_common_rxtx.h        | 16 +++++++++++++++-
 drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   |  4 ++--
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  4 ++--
 drivers/net/intel/idpf/idpf_rxtx.c               |  2 +-
 8 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 283bd58d5d..9da9366046 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -114,6 +114,7 @@ struct ci_tx_desc {
 
 /* forward declaration of the common intel (ci) queue structure */
 struct ci_tx_queue;
+struct idpf_complq;
 
 /**
  * Structure associated with each descriptor of the TX ring of a TX queue.
@@ -209,18 +210,12 @@ struct ci_tx_queue {
 			uint8_t vf_ctx_initialized; /**< VF context descriptors initialized */
 		};
 		struct { /* idpf specific values */
-				volatile union {
-						struct idpf_flex_tx_sched_desc *desc_ring;
-						struct idpf_splitq_tx_compl_desc *compl_ring;
-				};
-				struct ci_tx_queue *complq;
-				void **txqs;   /*only valid for split queue mode*/
-				uint32_t tx_start_qid;
+				struct idpf_flex_tx_sched_desc *desc_ring;
+				struct idpf_complq *complq;
 				uint32_t latch_idx; /* Tx timestamp latch index */
 				uint16_t sw_nb_desc;
 				uint16_t sw_tail;
 				uint16_t rs_compl_count;
-				uint8_t expected_gen_id;
 		};
 	};
 };
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index e05a0901d5..d26b2bb0dc 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -188,7 +188,7 @@ struct cpfl_vport {
 	uint16_t nb_p2p_txq;
 
 	struct idpf_rx_queue *p2p_rx_bufq;
-	struct ci_tx_queue *p2p_tx_complq;
+	struct idpf_complq *p2p_tx_complq;
 	bool p2p_manual_bind;
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index ad622b267d..e7e370a208 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -27,7 +27,7 @@ cpfl_tx_hairpin_descq_reset(struct ci_tx_queue *txq)
 }
 
 static inline void
-cpfl_tx_hairpin_complq_reset(struct ci_tx_queue *cq)
+cpfl_tx_hairpin_complq_reset(struct idpf_complq *cq)
 {
 	uint32_t i, size;
 
@@ -483,7 +483,7 @@ cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
 	const struct rte_memzone *mz;
-	struct ci_tx_queue *cq;
+	struct idpf_complq *cq;
 	int ret;
 
 	cq = rte_zmalloc_socket("cpfl splitq cq",
@@ -813,7 +813,8 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct cpfl_txq_hairpin_info *hairpin_info;
 	struct idpf_hw *hw = &adapter_base->hw;
 	struct cpfl_tx_queue *cpfl_txq;
-	struct ci_tx_queue *txq, *cq;
+	struct ci_tx_queue *txq;
+	struct idpf_complq *cq;
 	const struct rte_memzone *mz;
 	uint32_t ring_size;
 	uint16_t peer_port, peer_q;
@@ -894,7 +895,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 				  logic_qid, cpfl_vport->p2p_q_chunks_info->tx_qtail_spacing);
 	if (cpfl_vport->p2p_tx_complq == NULL) {
 		cq = rte_zmalloc_socket("cpfl hairpin cq",
-					sizeof(struct ci_tx_queue),
+					sizeof(struct idpf_complq),
 					RTE_CACHE_LINE_SIZE,
 					dev->device->numa_node);
 		if (!cq) {
@@ -996,7 +997,7 @@ cpfl_hairpin_rxq_config(struct idpf_vport *vport, struct cpfl_rx_queue *cpfl_rxq
 int
 cpfl_hairpin_tx_complq_config(struct cpfl_vport *cpfl_vport)
 {
-	struct ci_tx_queue *tx_complq = cpfl_vport->p2p_tx_complq;
+	struct idpf_complq *tx_complq = cpfl_vport->p2p_tx_complq;
 	struct virtchnl2_txq_info txq_info;
 
 	memset(&txq_info, 0, sizeof(txq_info));
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index f73716e57c..f69ae8b5f0 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -237,7 +237,7 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
 void
-idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
+idpf_qc_split_tx_complq_reset(struct idpf_complq *cq)
 {
 	uint32_t i, size;
 
@@ -782,7 +782,7 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline void
-idpf_split_tx_free(struct ci_tx_queue *cq)
+idpf_split_tx_free(struct idpf_complq *cq)
 {
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index f512700d5f..b2d33287df 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -181,6 +181,20 @@ struct idpf_rxq_ops {
 	void (*release_mbufs)(struct idpf_rx_queue *rxq);
 };
 
+/* Dedicated completion queue structure for IDPF split queue model. */
+struct idpf_complq {
+	volatile struct idpf_splitq_tx_compl_desc *compl_ring;
+	void **txqs;
+	rte_iova_t tx_ring_dma;
+	const struct rte_memzone *mz;
+	uint32_t tx_start_qid;
+	uint16_t nb_tx_desc;
+	uint16_t tx_tail;
+	uint16_t queue_id;
+	uint16_t port_id;
+	uint8_t expected_gen_id;
+};
+
 extern int idpf_timestamp_dynfield_offset;
 extern uint64_t idpf_timestamp_dynflag;
 
@@ -202,7 +216,7 @@ void idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq);
 __rte_internal
 void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
 __rte_internal
-void idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq);
+void idpf_qc_split_tx_complq_reset(struct idpf_complq *cq);
 __rte_internal
 void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
 __rte_internal
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index db7728afad..3fb2efdb56 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -781,9 +781,9 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 static __rte_always_inline void
-idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
+idpf_splitq_scan_cq_ring(struct idpf_complq *cq)
 {
-	struct idpf_splitq_tx_compl_desc *compl_ring;
+	volatile struct idpf_splitq_tx_compl_desc *compl_ring;
 	struct ci_tx_queue *txq;
 	uint16_t genid, txq_qid, cq_qid, i;
 	uint8_t ctype;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 9af275cd9d..8db4c64106 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1101,9 +1101,9 @@ idpf_dp_singleq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 static __rte_always_inline void
-idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
+idpf_splitq_scan_cq_ring(struct idpf_complq *cq)
 {
-	struct idpf_splitq_tx_compl_desc *compl_ring;
+	volatile struct idpf_splitq_tx_compl_desc *compl_ring;
 	struct ci_tx_queue *txq;
 	uint16_t genid, txq_qid, cq_qid, i;
 	uint8_t ctype;
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index b316c77b62..31005ce210 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -360,7 +360,7 @@ idpf_tx_complq_setup(struct rte_eth_dev *dev, struct ci_tx_queue *txq,
 {
 	struct idpf_vport *vport = dev->data->dev_private;
 	const struct rte_memzone *mz;
-	struct ci_tx_queue *cq;
+	struct idpf_complq *cq;
 	int ret;
 
 	cq = rte_zmalloc_socket("idpf splitq cq",
-- 
2.43.0

