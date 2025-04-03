Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB756C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 11:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCD3440DD7;
	Thu,  3 Apr 2025 13:23:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id BA1D440B97
 for <dev@dpdk.org>; Thu,  3 Apr 2025 13:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743679407; x=1775215407;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FeSQAnFPacjIurpM7+dKiOzo4Vg0T8OxRQylQRuG0Uk=;
 b=HwRDDd55X7DRwmAwqCGxAthMZFL56EXq/KlEQ2JzF3bBTYgWBTnfnkQe
 7CeHEPYkjxfUiKL0PWDzIeq43gZcA9A7s2MtZ+eh/o3WMbspNuFOXosKa
 fPfNpHo8vPsH/OySBpl2QFEOYJBRBxr3QbTCUOoG9lQ3kBSMJaVXZPjjL
 9ZZojTfYbPUum1uQC64n81CQAX0fsJHcXQkSmkGJZSxvlCq03QD7KvWAP
 cbsdDlzih6OSG78M6q1HNrFBgoe/s9XNMdkxo1mX4soaIeEl9ufe6e78e
 B6fOa/Ib7oRqizh6d/7irDoe3lJmw/xTYClgAxJi+ImEDlnGzYcVoXav9 g==;
X-CSE-ConnectionGUID: FHq+KuxnQ0uq0ppgLd/wLA==
X-CSE-MsgGUID: wzqki59nT1qa59HUTnJM0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45257319"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="45257319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2025 04:23:26 -0700
X-CSE-ConnectionGUID: TP2Vbb/1TNyNLtcnT8JG1g==
X-CSE-MsgGUID: gZNjqJnLRIqxuBjrq5nXkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="127833252"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa009.fm.intel.com with ESMTP; 03 Apr 2025 04:23:25 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v6 3/4] net/intel: use common Tx queue structure
Date: Thu,  3 Apr 2025 16:54:28 +0530
Message-Id: <20250403112429.2741138-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403112429.2741138-1-shaiq.wani@intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250403112429.2741138-1-shaiq.wani@intel.com>
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
 drivers/net/intel/common/tx.h                 | 18 ++++++
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |  2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 24 ++++----
 drivers/net/intel/cpfl/cpfl_rxtx.h            |  3 +-
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  2 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 20 +++----
 drivers/net/intel/idpf/idpf_common_rxtx.h     | 57 +++----------------
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 10 ++--
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 20 +++----
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  2 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.h |  2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |  2 +-
 drivers/net/intel/idpf/idpf_rxtx.c            | 21 ++++---
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  4 +-
 15 files changed, 83 insertions(+), 107 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index d9cf4474fc..9694b0fc06 100644
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
+			const struct idpf_txq_ops *idpf_ops;
+			struct ci_tx_queue *complq;
+			void **txqs;   /*only valid for split queue mode*/
+			bool q_started;   /* if tx queue has been started */
+			/* only valid for split queue mode */
+			uint32_t tx_start_qid;
+			uint16_t sw_nb_desc;
+			uint16_t sw_tail;
+#define IDPF_TX_CTYPE_NUM	8
+			uint16_t ctype[IDPF_TX_CTYPE_NUM];
+			uint8_t expected_gen_id;
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
index 6b7e7c5087..20a9042f3a 100644
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
+				sizeof(*cq),
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
index caf02295a3..f1e555b5f8 100644
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
index 4086714ae1..7cf3379ff5 100644
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
 	struct ci_tx_entry *txe;
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
 	struct ci_tx_entry *txe;
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
 	struct ci_tx_entry *txe;
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
 	struct ci_tx_entry *sw_ring;
@@ -1302,7 +1302,7 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline int
-idpf_xmit_cleanup(struct idpf_tx_queue *txq)
+idpf_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
 	struct ci_tx_entry *sw_ring = txq->sw_ring;
@@ -1351,7 +1351,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	union idpf_tx_offload tx_offload = {0};
 	struct ci_tx_entry *txe, *txn;
 	struct ci_tx_entry *sw_ring;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
 	uint64_t buf_dma_addr;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 30f9e9398d..fc68dddc90 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -149,49 +149,6 @@ struct idpf_rx_queue {
 	uint32_t hw_register_set;
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
-	struct ci_tx_entry *sw_ring;		/* address array of SW ring */
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
@@ -215,7 +172,7 @@ struct idpf_rxq_ops {
 };
 
 struct idpf_txq_ops {
-	void (*release_mbufs)(struct idpf_tx_queue *txq);
+	void (*release_mbufs)(struct ci_tx_queue *txq);
 };
 
 extern int idpf_timestamp_dynfield_offset;
@@ -229,7 +186,7 @@ int idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 __rte_internal
 void idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq);
 __rte_internal
-void idpf_qc_txq_mbufs_release(struct idpf_tx_queue *txq);
+void idpf_qc_txq_mbufs_release(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq);
 __rte_internal
@@ -239,11 +196,11 @@ void idpf_qc_split_rx_queue_reset(struct idpf_rx_queue *rxq);
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
@@ -274,9 +231,9 @@ int idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq);
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
index 40da70a6aa..83797ce13e 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -480,7 +480,7 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
 }
 
 static __rte_always_inline int
-idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
+idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry *txep;
 	uint32_t n;
@@ -610,7 +610,7 @@ static inline uint16_t
 idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 				       uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -629,7 +629,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 	tx_id = txq->tx_tail;
 	txdp = &txq->idpf_tx_ring[tx_id];
-	txep = (struct ci_tx_entry_vec *)&txq->sw_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
@@ -650,7 +650,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 		/* avoid reach the end of ring */
 		txdp = &txq->idpf_tx_ring[tx_id];
-		txep = (struct ci_tx_entry_vec *)&txq->sw_ring[tx_id];
+		txep = &txq->sw_ring_vec[tx_id];
 	}
 
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
@@ -678,7 +678,7 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts)
 {
 	uint16_t nb_tx = 0;
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index eccdcd43ff..715be52046 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -996,7 +996,7 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static __rte_always_inline int
-idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry_vec *txep;
 	uint32_t n;
@@ -1183,7 +1183,7 @@ static __rte_always_inline uint16_t
 idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					 uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = tx_queue;
+	struct ci_tx_queue *txq = tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -1254,7 +1254,7 @@ idpf_singleq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts)
 {
 	uint16_t nb_tx = 0;
-	struct idpf_tx_queue *txq = tx_queue;
+	struct ci_tx_queue *txq = tx_queue;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
@@ -1279,10 +1279,10 @@ idpf_dp_singleq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
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
 
@@ -1311,7 +1311,7 @@ idpf_splitq_scan_cq_ring(struct idpf_tx_queue *cq)
 }
 
 static __rte_always_inline int
-idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_splitq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry_vec *txep;
 	uint32_t n;
@@ -1486,7 +1486,7 @@ static __rte_always_inline uint16_t
 idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -1550,7 +1550,7 @@ static __rte_always_inline uint16_t
 idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 				     uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	uint16_t nb_tx = 0;
 
 	while (nb_pkts) {
@@ -1582,7 +1582,7 @@ idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 static inline void
-idpf_tx_release_mbufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_release_mbufs_avx512(struct ci_tx_queue *txq)
 {
 	unsigned int i;
 	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
@@ -1610,7 +1610,7 @@ static const struct idpf_txq_ops avx512_tx_vec_ops = {
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
index 62685d3b7e..90720909bf 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -710,7 +710,7 @@ static int
 idpf_start_queues(struct rte_eth_dev *dev)
 {
 	struct idpf_rx_queue *rxq;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int err = 0;
 	int i;
 
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index d67526c0fa..bf190b02ee 100644
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
+				sizeof(*cq),
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
@@ -629,8 +629,7 @@ int
 idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
-	struct idpf_tx_queue *txq =
-		dev->data->tx_queues[tx_queue_id];
+	struct ci_tx_queue *txq = dev->data->tx_queues[tx_queue_id];
 	int err = 0;
 
 	err = idpf_vc_txq_config(vport, txq);
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
 
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index bb9cbf5c02..e444addf85 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -50,7 +50,7 @@ idpf_rx_vec_queue_default(struct idpf_rx_queue *rxq)
 }
 
 static inline int
-idpf_tx_vec_queue_default(struct idpf_tx_queue *txq)
+idpf_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
 	if (txq == NULL)
 		return IDPF_SCALAR_PATH;
@@ -104,7 +104,7 @@ static inline int
 idpf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 {
 	int i;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int ret = 0;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
-- 
2.34.1

