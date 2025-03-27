Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A9C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 16:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89F2440E49;
	Thu, 27 Mar 2025 17:03:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 60E2540E37
 for <dev@dpdk.org>; Thu, 27 Mar 2025 17:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743091403; x=1774627403;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rdRFzrugNQ0JHJlmFJ8iE/Lc8ApYQp7EhDBcUx1Jzas=;
 b=Ay/5sKfdP69WHeu5AixaktlTSqW+RqQen0HxNit+6KAeBxT6u8NmzT/F
 STk6/3ng7gyUQCC8jF0DzIg6RJKIm+cFG7xVjO+zUtZZEtuASqlLsg1m+
 rUGel7Fxd9MbbWzLSbjfxi/B0ayfqmce3+hBmxrOm0SEW8LsfRPBEfvpv
 NTzL+ZEi/HaE1CQ8Y9LhgP+JgT5Zzlg9mOuvrkDdAP31r0KN1rexg8L2i
 qGeduRWSGV/SutKZkSD9ajT2DACck3Va4lKYBi4w+8bCjZwBur09EZJ3g
 erV+tIqofVkhNeav1Fv6li/Z8ura+m2HBLHLUTL+N66RpJR327mookkgo g==;
X-CSE-ConnectionGUID: hshmDEBlSriSGvR+dQY38w==
X-CSE-MsgGUID: GZxQO/zORvyUU8aumolmoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61825762"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="61825762"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:03:21 -0700
X-CSE-ConnectionGUID: o7IwHw/iTD+5D06dU9flIQ==
X-CSE-MsgGUID: 3bP1QXCyQ2OKFlWw9Dp/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125412047"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2025 09:03:20 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 2/4] net/intel: use common Tx queue structure
Date: Thu, 27 Mar 2025 21:34:35 +0530
Message-Id: <20250327160437.2296127-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327160437.2296127-1-shaiq.wani@intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
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
over to using the common Tx queue structure

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/common/tx.h                 | 20 +++++++
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |  2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 26 ++++-----
 drivers/net/intel/cpfl/cpfl_rxtx.h            |  3 +-
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  3 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 36 ++++++------
 drivers/net/intel/idpf/idpf_common_rxtx.h     | 58 +++----------------
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 12 ++--
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 21 +++----
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  2 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.h |  2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |  3 +-
 drivers/net/intel/idpf/idpf_rxtx.c            | 21 ++++---
 drivers/net/intel/idpf/idpf_rxtx.h            |  1 +
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  5 +-
 16 files changed, 101 insertions(+), 117 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index d9cf4474fc..af32f4deda 100644
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
@@ -98,6 +99,25 @@ struct ci_tx_queue {
 			uint8_t wthresh;   /**< Write-back threshold reg. */
 			uint8_t using_ipsec;  /**< indicates that IPsec TX feature is in use */
 		};
+		struct { /* idpf specific values */
+			volatile union {
+				struct idpf_flex_tx_sched_desc *desc_ring;
+				struct idpf_splitq_tx_compl_desc *compl_ring;
+			};
+			const struct idpf_txq_ops *idpf_ops;
+			struct ci_tx_queue *complq;
+			void **txqs;   /*only valid for split queue mode*/
+			bool q_started;   /* if tx queue has been started */
+
+			/* only valid for split queue mode */
+			uint32_t tx_start_qid;
+			uint16_t sw_nb_desc;
+			uint16_t sw_tail;
+#define IDPF_TX_CTYPE_NUM	8
+			uint16_t ctype[IDPF_TX_CTYPE_NUM];
+			uint8_t expected_gen_id;
+
+		};
 	};
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 1817221652..c94010bc51 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -18,6 +18,7 @@
 #include "cpfl_rxtx.h"
 #include "cpfl_flow.h"
 #include "cpfl_rules.h"
+#include "../common/tx.h"
 
 #define CPFL_REPRESENTOR	"representor"
 #define CPFL_TX_SINGLE_Q	"tx_single"
@@ -1167,7 +1168,7 @@ cpfl_hairpin_get_peer_ports(struct rte_eth_dev *dev, uint16_t *peer_ports,
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
index 8eed8f16d5..d7b5a660b5 100644
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
index aacd087b56..52cdecac88 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.h
@@ -7,6 +7,7 @@
 
 #include <idpf_common_rxtx.h>
 #include "cpfl_ethdev.h"
+#include "../common/tx.h"
 
 /* In QLEN must be whole number of 32 descriptors. */
 #define CPFL_ALIGN_RING_DESC	32
@@ -70,7 +71,7 @@ struct cpfl_txq_hairpin_info {
 };
 
 struct cpfl_tx_queue {
-	struct idpf_tx_queue base;
+	struct ci_tx_queue base;
 	struct cpfl_txq_hairpin_info hairpin_info;
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
index caf02295a3..874b5cd5f3 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
@@ -10,6 +10,7 @@
 
 #include "cpfl_ethdev.h"
 #include "cpfl_rxtx.h"
+#include "../common/tx.h"
 
 #define CPFL_SCALAR_PATH		0
 #define CPFL_VECTOR_PATH		1
@@ -49,7 +50,7 @@ cpfl_rx_vec_queue_default(struct idpf_rx_queue *rxq)
 }
 
 static inline int
-cpfl_tx_vec_queue_default(struct idpf_tx_queue *txq)
+cpfl_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
 	if (txq == NULL)
 		return CPFL_SCALAR_PATH;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index df16aa3f06..48fc3ef7ae 100644
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
@@ -223,7 +223,7 @@ idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->desc_ring)[i] = 0;
 
-	txe = txq->sw_ring;
+	txe = (struct idpf_tx_entry *)txq->sw_ring;
 	prev = (uint16_t)(txq->sw_nb_desc - 1);
 	for (i = 0; i < txq->sw_nb_desc; i++) {
 		txe[i].mbuf = NULL;
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
@@ -275,7 +275,7 @@ idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
 		return;
 	}
 
-	txe = txq->sw_ring;
+	txe = (struct idpf_tx_entry *)txq->sw_ring;
 	size = sizeof(struct idpf_base_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->idpf_tx_ring)[i] = 0;
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
@@ -794,7 +794,7 @@ idpf_split_tx_free(struct idpf_tx_queue *cq)
 		break;
 	case IDPF_TXD_COMPLT_RS:
 		/* q_head indicates sw_id when ctype is 2 */
-		txe = &txq->sw_ring[q_head];
+		txe = (struct idpf_tx_entry *)&txq->sw_ring[q_head];
 		if (txe->mbuf != NULL) {
 			rte_pktmbuf_free_seg(txe->mbuf);
 			txe->mbuf = NULL;
@@ -860,7 +860,7 @@ uint16_t
 idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txr;
 	volatile struct idpf_flex_tx_sched_desc *txd;
 	struct idpf_tx_entry *sw_ring;
@@ -874,11 +874,11 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint8_t cmd_dtype;
 	uint16_t nb_ctx;
 
-	if (unlikely(txq == NULL) || unlikely(!txq->q_started))
+	if (unlikely(txq == NULL))
 		return nb_tx;
 
 	txr = txq->desc_ring;
-	sw_ring = txq->sw_ring;
+	sw_ring = (struct idpf_tx_entry *)txq->sw_ring;
 	tx_id = txq->tx_tail;
 	sw_id = txq->sw_tail;
 	txe = &sw_ring[sw_id];
@@ -1302,10 +1302,10 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline int
-idpf_xmit_cleanup(struct idpf_tx_queue *txq)
+idpf_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	struct idpf_tx_entry *sw_ring = txq->sw_ring;
+	struct idpf_tx_entry *sw_ring = (struct idpf_tx_entry *)txq->sw_ring;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
@@ -1351,7 +1351,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	union idpf_tx_offload tx_offload = {0};
 	struct idpf_tx_entry *txe, *txn;
 	struct idpf_tx_entry *sw_ring;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
 	uint64_t buf_dma_addr;
@@ -1368,10 +1368,10 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_tx = 0;
 	txq = tx_queue;
 
-	if (unlikely(txq == NULL) || unlikely(!txq->q_started))
+	if (unlikely(txq == NULL))
 		return nb_tx;
 
-	sw_ring = txq->sw_ring;
+	sw_ring = (struct idpf_tx_entry *)txq->sw_ring;
 	txr = txq->idpf_tx_ring;
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 84c05cfaac..1a64b6615c 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -10,6 +10,7 @@
 #include <rte_mbuf_core.h>
 
 #include "idpf_common_device.h"
+#include "../common/tx.h"
 
 #define IDPF_RX_MAX_BURST		32
 
@@ -154,49 +155,6 @@ struct idpf_tx_entry {
 	uint16_t last_id;
 };
 
-/* Structure associated with each TX queue. */
-struct idpf_tx_queue {
-	const struct rte_memzone *mz;		/* memzone for Tx ring */
-	volatile struct idpf_base_tx_desc *idpf_tx_ring;	/* Tx ring virtual address */
-	volatile union {
-		struct idpf_flex_tx_sched_desc *desc_ring;
-		struct idpf_splitq_tx_compl_desc *compl_ring;
-	};
-	rte_iova_t tx_ring_dma;		/* Tx ring DMA address */
-	struct idpf_tx_entry *sw_ring;		/* address array of SW ring */
-
-	uint16_t nb_tx_desc;		/* ring length */
-	uint16_t tx_tail;		/* current value of tail */
-	volatile uint8_t *qtx_tail;	/* register address of tail */
-	/* number of used desc since RS bit set */
-	uint16_t nb_tx_used;
-	uint16_t nb_tx_free;
-	uint16_t last_desc_cleaned;	/* last desc have been cleaned*/
-	uint16_t tx_free_thresh;
-
-	uint16_t tx_rs_thresh;
-
-	uint16_t port_id;
-	uint16_t queue_id;
-	uint64_t offloads;
-	uint16_t tx_next_dd;	/* next to set RS, for VPMD */
-	uint16_t tx_next_rs;	/* next to check DD,  for VPMD */
-
-	bool q_set;		/* if tx queue has been configured */
-	bool q_started;		/* if tx queue has been started */
-	bool tx_deferred_start; /* don't start this queue in dev start */
-	const struct idpf_txq_ops *idpf_ops;
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
@@ -224,7 +182,7 @@ struct idpf_rxq_ops {
 };
 
 struct idpf_txq_ops {
-	void (*release_mbufs)(struct idpf_tx_queue *txq);
+	void (*release_mbufs)(struct ci_tx_queue *txq);
 };
 
 extern int idpf_timestamp_dynfield_offset;
@@ -238,7 +196,7 @@ int idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 __rte_internal
 void idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq);
 __rte_internal
-void idpf_qc_txq_mbufs_release(struct idpf_tx_queue *txq);
+void idpf_qc_txq_mbufs_release(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq);
 __rte_internal
@@ -248,11 +206,11 @@ void idpf_qc_split_rx_queue_reset(struct idpf_rx_queue *rxq);
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
@@ -283,9 +241,9 @@ int idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq);
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
index ba97003779..26b24106d0 100644
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
@@ -509,7 +509,7 @@ idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
 	 /* first buffer to free from S/W ring is at index
 	  * tx_next_dd - (tx_rs_thresh-1)
 	  */
-	txep = &txq->sw_ring[txq->tx_next_dd - (n - 1)];
+	txep = (struct idpf_tx_entry *)&txq->sw_ring[txq->tx_next_dd - (n - 1)];
 	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
 	if (likely(m)) {
 		free[0] = m;
@@ -619,7 +619,7 @@ static inline uint16_t
 idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 				       uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
 	struct idpf_tx_entry *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -638,7 +638,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 	tx_id = txq->tx_tail;
 	txdp = &txq->idpf_tx_ring[tx_id];
-	txep = &txq->sw_ring[tx_id];
+	txep = (struct idpf_tx_entry *)&txq->sw_ring[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
@@ -659,7 +659,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 		/* avoid reach the end of ring */
 		txdp = &txq->idpf_tx_ring[tx_id];
-		txep = &txq->sw_ring[tx_id];
+		txep = (struct idpf_tx_entry *)&txq->sw_ring[tx_id];
 	}
 
 	idpf_tx_backlog_entry(txep, tx_pkts, nb_commit);
@@ -687,7 +687,7 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts)
 {
 	uint16_t nb_tx = 0;
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index d2f82ab3f5..a41b5f33af 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -6,6 +6,7 @@
 #include "idpf_common_device.h"
 #include "idpf_common_rxtx.h"
 
+
 #define IDPF_DESCS_PER_LOOP_AVX 8
 #define PKTLEN_SHIFT 10
 
@@ -996,7 +997,7 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static __rte_always_inline int
-idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_vec_entry *txep;
 	uint32_t n;
@@ -1193,7 +1194,7 @@ static __rte_always_inline uint16_t
 idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					 uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = tx_queue;
+	struct ci_tx_queue *txq = tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
 	struct idpf_tx_vec_entry *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -1264,7 +1265,7 @@ idpf_singleq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts)
 {
 	uint16_t nb_tx = 0;
-	struct idpf_tx_queue *txq = tx_queue;
+	struct ci_tx_queue *txq = tx_queue;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
@@ -1289,10 +1290,10 @@ idpf_dp_singleq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
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
 
@@ -1321,7 +1322,7 @@ idpf_splitq_scan_cq_ring(struct idpf_tx_queue *cq)
 }
 
 static __rte_always_inline int
-idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_splitq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_vec_entry *txep;
 	uint32_t n;
@@ -1496,7 +1497,7 @@ static __rte_always_inline uint16_t
 idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txdp;
 	struct idpf_tx_vec_entry *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -1560,7 +1561,7 @@ static __rte_always_inline uint16_t
 idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 				     uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	uint16_t nb_tx = 0;
 
 	while (nb_pkts) {
@@ -1592,7 +1593,7 @@ idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 static inline void
-idpf_tx_release_mbufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_release_mbufs_avx512(struct ci_tx_queue *txq)
 {
 	unsigned int i;
 	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
@@ -1620,7 +1621,7 @@ static const struct idpf_txq_ops avx512_tx_vec_ops = {
 };
 
 int __rte_cold
-idpf_qc_tx_vec_avx512_setup(struct idpf_tx_queue *txq)
+idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
 {
 	if (!txq)
 		return 0;
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index af81680825..0580a1819a 100644
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
index 7718167096..90720909bf 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -13,6 +13,7 @@
 
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
+#include "../common/tx.h"
 
 #define IDPF_TX_SINGLE_Q	"tx_single"
 #define IDPF_RX_SINGLE_Q	"rx_single"
@@ -709,7 +710,7 @@ static int
 idpf_start_queues(struct rte_eth_dev *dev)
 {
 	struct idpf_rx_queue *rxq;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int err = 0;
 	int i;
 
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 95b112c95c..4d8cfa56ac 100644
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
@@ -742,7 +741,7 @@ void
 idpf_stop_queues(struct rte_eth_dev *dev)
 {
 	struct idpf_rx_queue *rxq;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int i;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -880,7 +879,7 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	struct idpf_vport *vport = dev->data->dev_private;
 #ifdef RTE_ARCH_X86
 #ifdef CC_AVX512_SUPPORT
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int i;
 #endif /* CC_AVX512_SUPPORT */
 
diff --git a/drivers/net/intel/idpf/idpf_rxtx.h b/drivers/net/intel/idpf/idpf_rxtx.h
index 41a7495083..b456b8705d 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_rxtx.h
@@ -7,6 +7,7 @@
 
 #include <idpf_common_rxtx.h>
 #include "idpf_ethdev.h"
+#include "../common/tx.h"
 
 /* In QLEN must be whole number of 32 descriptors. */
 #define IDPF_ALIGN_RING_DESC	32
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index 608cab30f3..e444addf85 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -10,6 +10,7 @@
 
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
+#include "../common/rx.h"
 
 #define IDPF_SCALAR_PATH		0
 #define IDPF_VECTOR_PATH		1
@@ -49,7 +50,7 @@ idpf_rx_vec_queue_default(struct idpf_rx_queue *rxq)
 }
 
 static inline int
-idpf_tx_vec_queue_default(struct idpf_tx_queue *txq)
+idpf_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
 	if (txq == NULL)
 		return IDPF_SCALAR_PATH;
@@ -103,7 +104,7 @@ static inline int
 idpf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 {
 	int i;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int ret = 0;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
-- 
2.34.1

