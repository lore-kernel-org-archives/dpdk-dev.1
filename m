Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA520C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:52:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F6A14029E;
	Wed, 12 Mar 2025 16:52:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0DD9940265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:52:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741794724; x=1773330724;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8MiMvX72K8qSWp5FaQyPs/yEmlhW3C06gUqrn0io1n4=;
 b=lN11VtR3DXomh5eOFUKDgUJsT+R5IkOw/84Hi2xJKFWiJ+nzeAj3wjlm
 iNZKbCl7F16bKaU4T/r2DK/AVQqSgP1NAPoFbUXmZFkhgm9REWYN6C55Y
 hmeGPayHNMM/nKh5SD/M96eiahm5AKay8oOMo2L7jlWUvrbKBH4xbttK3
 qiKzC6f8TmsoMvBFUMNCDnHfPJPdzEwY4dX/9AtAKq0To2w6EAD6ynw2b
 9dM+JjsMZwZ1h7fKwGZbffxPMywpynrPI3qvS5jn8aIilkTNrVajxytoH
 jYix8F4E5hIuTfofxjvOPHi+OlRG0l+y0NqMceTL+h3pgjNWZrC64MyzE w==;
X-CSE-ConnectionGUID: 0OtAwtjvQSObXCkskc5GZw==
X-CSE-MsgGUID: AnzkDLP0RcS5fSfgRjyKKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42758298"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="42758298"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 08:52:03 -0700
X-CSE-ConnectionGUID: nm1xmf8TTXyO6v+c+cVbpQ==
X-CSE-MsgGUID: 1wQxEBwmSWOuR4MJKCIsWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="120906218"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 12 Mar 2025 08:52:01 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/intel: using common functions in idpf driver
Date: Wed, 12 Mar 2025 21:23:51 +0530
Message-Id: <20250312155351.409879-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
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

reworked the drivers to use the common functions and structures
from drivers/net/intel/common.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/common/tx.h                 |  21 +++-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   1 +
 drivers/net/intel/cpfl/cpfl_ethdev.h          |   2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  66 +++++------
 drivers/net/intel/cpfl/cpfl_rxtx.h            |   3 +-
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |   7 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 108 ++++++++---------
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  65 ++--------
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 112 +++++-------------
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 104 ++++++++--------
 drivers/net/intel/idpf/idpf_common_virtchnl.c |   8 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.h |   2 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |  46 +++----
 drivers/net/intel/idpf/idpf_rxtx.h            |   1 +
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  17 ++-
 drivers/net/intel/idpf/meson.build            |   2 +-
 17 files changed, 248 insertions(+), 320 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index d9cf4474fc..532adb4fd1 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -36,6 +36,7 @@ struct ci_tx_queue {
 		volatile struct iavf_tx_desc *iavf_tx_ring;
 		volatile struct ice_tx_desc *ice_tx_ring;
 		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
+		volatile struct idpf_base_tx_desc *idpf_tx_ring;
 	};
 	volatile uint8_t *qtx_tail;               /* register address of tail */
 	union {
@@ -51,7 +52,7 @@ struct ci_tx_queue {
 	uint16_t nb_tx_free;
 	/* Start freeing TX buffers if there are less free descriptors than
 	 * this value.
-	 */
+	*/
 	uint16_t tx_free_thresh;
 	/* Number of TX descriptors to use before RS bit is set. */
 	uint16_t tx_rs_thresh;
@@ -98,6 +99,24 @@ struct ci_tx_queue {
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
+			/* only valid for split queue mode */
+			uint16_t sw_nb_desc;
+			uint16_t sw_tail;
+			void **txqs;
+			uint32_t tx_start_qid;
+			uint8_t expected_gen_id;
+			struct ci_tx_queue *complq;
+#define IDPF_TX_CTYPE_NUM	8
+			uint16_t ctype[IDPF_TX_CTYPE_NUM];
+
+		};
 	};
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 1817221652..c67ccf6b53 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -18,6 +18,7 @@
 #include "cpfl_rxtx.h"
 #include "cpfl_flow.h"
 #include "cpfl_rules.h"
+#include "../common/tx.h"
 
 #define CPFL_REPRESENTOR	"representor"
 #define CPFL_TX_SINGLE_Q	"tx_single"
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
index 47351ca102..d7b5a660b5 100644
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
 
@@ -249,7 +249,7 @@ cpfl_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 	idpf_qc_split_rx_bufq_reset(bufq);
 	bufq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_buf_qtail_start +
 			 queue_idx * vport->chunks_info.rx_buf_qtail_spacing);
-	bufq->ops = &def_rxq_ops;
+	bufq->idpf_ops = &def_rxq_ops;
 	bufq->q_set = true;
 
 	if (bufq_id == IDPF_RX_SPLIT_BUFQ1_ID) {
@@ -310,7 +310,7 @@ cpfl_rx_queue_release(void *rxq)
 	}
 
 	/* Single queue */
-	q->ops->release_mbufs(q);
+	q->idpf_ops->release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(cpfl_rxq);
@@ -320,7 +320,7 @@ static void
 cpfl_tx_queue_release(void *txq)
 {
 	struct cpfl_tx_queue *cpfl_txq = txq;
-	struct idpf_tx_queue *q = NULL;
+	struct ci_tx_queue *q = NULL;
 
 	if (cpfl_txq == NULL)
 		return;
@@ -332,7 +332,7 @@ cpfl_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
-	q->ops->release_mbufs(q);
+	q->idpf_ops->release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(cpfl_txq);
@@ -426,7 +426,7 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		idpf_qc_single_rx_queue_reset(rxq);
 		rxq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_qtail_start +
 				queue_idx * vport->chunks_info.rx_qtail_spacing);
-		rxq->ops = &def_rxq_ops;
+		rxq->idpf_ops = &def_rxq_ops;
 	} else {
 		idpf_qc_split_rx_descq_reset(rxq);
 
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
@@ -501,7 +501,7 @@ cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
 		ret = -ENOMEM;
 		goto err_mz_reserve;
 	}
-	cq->tx_ring_phys_addr = mz->iova;
+	cq->tx_ring_dma = mz->iova;
 	cq->compl_ring = mz->addr;
 	cq->mz = mz;
 	idpf_qc_split_tx_complq_reset(cq);
@@ -528,7 +528,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct cpfl_tx_queue *cpfl_txq;
 	struct idpf_hw *hw = &base->hw;
 	const struct rte_memzone *mz;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	uint64_t offloads;
 	uint16_t len;
 	bool is_splitq;
@@ -565,8 +565,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	is_splitq = !!(vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT);
 
 	txq->nb_tx_desc = nb_desc;
-	txq->rs_thresh = tx_rs_thresh;
-	txq->free_thresh = tx_free_thresh;
+	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
 	txq->port_id = dev->data->port_id;
 	txq->offloads = cpfl_tx_offload_convert(offloads);
@@ -585,11 +585,11 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		ret = -ENOMEM;
 		goto err_mz_reserve;
 	}
-	txq->tx_ring_phys_addr = mz->iova;
+	txq->tx_ring_dma = mz->iova;
 	txq->mz = mz;
 
 	txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
-					  sizeof(struct idpf_tx_entry) * len,
+					  sizeof(struct ci_tx_entry) * len,
 					  RTE_CACHE_LINE_SIZE, socket_id);
 	if (txq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
@@ -598,7 +598,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	if (!is_splitq) {
-		txq->tx_ring = mz->addr;
+		txq->idpf_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
@@ -613,7 +613,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	txq->qtx_tail = hw->hw_addr + (vport->chunks_info.tx_qtail_start +
 			queue_idx * vport->chunks_info.tx_qtail_spacing);
-	txq->ops = &def_txq_ops;
+	txq->idpf_ops = &def_txq_ops;
 	cpfl_vport->nb_data_txq++;
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = cpfl_txq;
@@ -663,7 +663,7 @@ cpfl_rx_hairpin_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *bufq,
 	bufq->rx_buf_len = CPFL_P2P_MBUF_SIZE - RTE_PKTMBUF_HEADROOM;
 
 	bufq->q_set = true;
-	bufq->ops = &def_rxq_ops;
+	bufq->idpf_ops = &def_rxq_ops;
 
 	return 0;
 }
@@ -789,7 +789,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct cpfl_txq_hairpin_info *hairpin_info;
 	struct idpf_hw *hw = &adapter_base->hw;
 	struct cpfl_tx_queue *cpfl_txq;
-	struct idpf_tx_queue *txq, *cq;
+	struct ci_tx_queue *txq, *cq;
 	const struct rte_memzone *mz;
 	uint32_t ring_size;
 	uint16_t peer_port, peer_q;
@@ -860,7 +860,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		goto err_txq_mz_rsv;
 	}
 
-	txq->tx_ring_phys_addr = mz->iova;
+	txq->tx_ring_dma = mz->iova;
 	txq->desc_ring = mz->addr;
 	txq->mz = mz;
 
@@ -868,11 +868,11 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->qtx_tail = hw->hw_addr +
 		cpfl_hw_qtail_get(cpfl_vport->p2p_q_chunks_info->tx_qtail_start,
 				  logic_qid, cpfl_vport->p2p_q_chunks_info->tx_qtail_spacing);
-	txq->ops = &def_txq_ops;
+	txq->idpf_ops = &def_txq_ops;
 
 	if (cpfl_vport->p2p_tx_complq == NULL) {
 		cq = rte_zmalloc_socket("cpfl hairpin cq",
-					sizeof(struct idpf_tx_queue),
+					sizeof(struct ci_tx_queue),
 					RTE_CACHE_LINE_SIZE,
 					dev->device->numa_node);
 		if (!cq) {
@@ -898,7 +898,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			ret = -ENOMEM;
 			goto err_cq_mz_rsv;
 		}
-		cq->tx_ring_phys_addr = mz->iova;
+		cq->tx_ring_dma = mz->iova;
 		cq->compl_ring = mz->addr;
 		cq->mz = mz;
 
@@ -974,12 +974,12 @@ cpfl_hairpin_rxq_config(struct idpf_vport *vport, struct cpfl_rx_queue *cpfl_rxq
 int
 cpfl_hairpin_tx_complq_config(struct cpfl_vport *cpfl_vport)
 {
-	struct idpf_tx_queue *tx_complq = cpfl_vport->p2p_tx_complq;
+	struct ci_tx_queue *tx_complq = cpfl_vport->p2p_tx_complq;
 	struct virtchnl2_txq_info txq_info;
 
 	memset(&txq_info, 0, sizeof(txq_info));
 
-	txq_info.dma_ring_addr = tx_complq->tx_ring_phys_addr;
+	txq_info.dma_ring_addr = tx_complq->tx_ring_dma;
 	txq_info.type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
 	txq_info.queue_id = tx_complq->queue_id;
 	txq_info.ring_len = tx_complq->nb_tx_desc;
@@ -993,12 +993,12 @@ cpfl_hairpin_tx_complq_config(struct cpfl_vport *cpfl_vport)
 int
 cpfl_hairpin_txq_config(struct idpf_vport *vport, struct cpfl_tx_queue *cpfl_txq)
 {
-	struct idpf_tx_queue *txq = &cpfl_txq->base;
+	struct ci_tx_queue *txq = &cpfl_txq->base;
 	struct virtchnl2_txq_info txq_info;
 
 	memset(&txq_info, 0, sizeof(txq_info));
 
-	txq_info.dma_ring_addr = txq->tx_ring_phys_addr;
+	txq_info.dma_ring_addr = txq->tx_ring_dma;
 	txq_info.type = VIRTCHNL2_QUEUE_TYPE_TX;
 	txq_info.queue_id = txq->queue_id;
 	txq_info.ring_len = txq->nb_tx_desc;
@@ -1296,12 +1296,12 @@ cpfl_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	rxq = &cpfl_rxq->base;
 	rxq->q_started = false;
 	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-		rxq->ops->release_mbufs(rxq);
+		rxq->idpf_ops->release_mbufs(rxq);
 		idpf_qc_single_rx_queue_reset(rxq);
 	} else {
-		rxq->bufq1->ops->release_mbufs(rxq->bufq1);
+		rxq->bufq1->idpf_ops->release_mbufs(rxq->bufq1);
 		if (rxq->bufq2)
-			rxq->bufq2->ops->release_mbufs(rxq->bufq2);
+			rxq->bufq2->idpf_ops->release_mbufs(rxq->bufq2);
 		if (cpfl_rxq->hairpin_info.hairpin_q) {
 			cpfl_rx_hairpin_descq_reset(rxq);
 			cpfl_rx_hairpin_bufq_reset(rxq->bufq1);
@@ -1321,7 +1321,7 @@ cpfl_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
 	struct cpfl_tx_queue *cpfl_txq;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int err;
 
 	if (tx_queue_id >= dev->data->nb_tx_queues)
@@ -1344,7 +1344,7 @@ cpfl_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	txq = &cpfl_txq->base;
 	txq->q_started = false;
-	txq->ops->release_mbufs(txq);
+	txq->idpf_ops->release_mbufs(txq);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
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
index 5b98f86932..874b5cd5f3 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
@@ -10,6 +10,7 @@
 
 #include "cpfl_ethdev.h"
 #include "cpfl_rxtx.h"
+#include "../common/tx.h"
 
 #define CPFL_SCALAR_PATH		0
 #define CPFL_VECTOR_PATH		1
@@ -49,13 +50,13 @@ cpfl_rx_vec_queue_default(struct idpf_rx_queue *rxq)
 }
 
 static inline int
-cpfl_tx_vec_queue_default(struct idpf_tx_queue *txq)
+cpfl_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
 	if (txq == NULL)
 		return CPFL_SCALAR_PATH;
 
-	if (txq->rs_thresh < IDPF_VPMD_TX_MAX_BURST ||
-	    (txq->rs_thresh & 3) != 0)
+	if (txq->tx_rs_thresh < IDPF_VPMD_TX_MAX_BURST ||
+	    (txq->tx_rs_thresh & 3) != 0)
 		return CPFL_SCALAR_PATH;
 
 	if ((txq->offloads & CPFL_TX_NO_VECTOR_FLAGS) != 0)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 7171e27b8d..7cf3379ff5 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -90,7 +90,7 @@ idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq)
 }
 
 void
-idpf_qc_txq_mbufs_release(struct idpf_tx_queue *txq)
+idpf_qc_txq_mbufs_release(struct ci_tx_queue *txq)
 {
 	uint16_t nb_desc, i;
 
@@ -208,9 +208,9 @@ idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
 }
 
 void
-idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
+idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	uint32_t i, size;
 	uint16_t prev;
 
@@ -233,20 +233,20 @@ idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
 	}
 
 	txq->tx_tail = 0;
-	txq->nb_used = 0;
+	txq->nb_tx_used = 0;
 
 	/* Use this as next to clean for split desc queue */
 	txq->last_desc_cleaned = 0;
 	txq->sw_tail = 0;
-	txq->nb_free = txq->nb_tx_desc - 1;
+	txq->nb_tx_free = txq->nb_tx_desc - 1;
 
 	memset(txq->ctype, 0, sizeof(txq->ctype));
-	txq->next_dd = txq->rs_thresh - 1;
-	txq->next_rs = txq->rs_thresh - 1;
+	txq->tx_next_dd = txq->tx_rs_thresh - 1;
+	txq->tx_next_rs = txq->tx_rs_thresh - 1;
 }
 
 void
-idpf_qc_split_tx_complq_reset(struct idpf_tx_queue *cq)
+idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
 {
 	uint32_t i, size;
 
@@ -264,9 +264,9 @@ idpf_qc_split_tx_complq_reset(struct idpf_tx_queue *cq)
 }
 
 void
-idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
+idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	uint32_t i, size;
 	uint16_t prev;
 
@@ -278,11 +278,11 @@ idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
 	txe = txq->sw_ring;
 	size = sizeof(struct idpf_base_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
-		((volatile char *)txq->tx_ring)[i] = 0;
+		((volatile char *)txq->idpf_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		txq->tx_ring[i].qw1 =
+		txq->idpf_tx_ring[i].qw1 =
 			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
@@ -291,13 +291,13 @@ idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
 	}
 
 	txq->tx_tail = 0;
-	txq->nb_used = 0;
+	txq->nb_tx_used = 0;
 
 	txq->last_desc_cleaned = txq->nb_tx_desc - 1;
-	txq->nb_free = txq->nb_tx_desc - 1;
+	txq->nb_tx_free = txq->nb_tx_desc - 1;
 
-	txq->next_dd = txq->rs_thresh - 1;
-	txq->next_rs = txq->rs_thresh - 1;
+	txq->tx_next_dd = txq->tx_rs_thresh - 1;
+	txq->tx_next_rs = txq->tx_rs_thresh - 1;
 }
 
 void
@@ -310,11 +310,11 @@ idpf_qc_rx_queue_release(void *rxq)
 
 	/* Split queue */
 	if (!q->adapter->is_rx_singleq) {
-		q->bufq1->ops->release_mbufs(q->bufq1);
+		q->bufq1->idpf_ops->release_mbufs(q->bufq1);
 		rte_free(q->bufq1->sw_ring);
 		rte_memzone_free(q->bufq1->mz);
 		rte_free(q->bufq1);
-		q->bufq2->ops->release_mbufs(q->bufq2);
+		q->bufq2->idpf_ops->release_mbufs(q->bufq2);
 		rte_free(q->bufq2->sw_ring);
 		rte_memzone_free(q->bufq2->mz);
 		rte_free(q->bufq2);
@@ -324,7 +324,7 @@ idpf_qc_rx_queue_release(void *rxq)
 	}
 
 	/* Single queue */
-	q->ops->release_mbufs(q);
+	q->idpf_ops->release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(q);
@@ -333,7 +333,7 @@ idpf_qc_rx_queue_release(void *rxq)
 void
 idpf_qc_tx_queue_release(void *txq)
 {
-	struct idpf_tx_queue *q = txq;
+	struct ci_tx_queue *q = txq;
 
 	if (q == NULL)
 		return;
@@ -343,7 +343,7 @@ idpf_qc_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
-	q->ops->release_mbufs(q);
+	q->idpf_ops->release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(q);
@@ -750,13 +750,13 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline void
-idpf_split_tx_free(struct idpf_tx_queue *cq)
+idpf_split_tx_free(struct ci_tx_queue *cq)
 {
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
-	struct idpf_tx_entry *txe;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_entry *txe;
+	struct ci_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
 	uint8_t ctype;
@@ -789,7 +789,7 @@ idpf_split_tx_free(struct idpf_tx_queue *cq)
 				q_head;
 		else
 			nb_desc_clean = q_head - txq->last_desc_cleaned;
-		txq->nb_free += nb_desc_clean;
+		txq->nb_tx_free += nb_desc_clean;
 		txq->last_desc_cleaned = q_head;
 		break;
 	case IDPF_TXD_COMPLT_RS:
@@ -860,12 +860,12 @@ uint16_t
 idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txr;
 	volatile struct idpf_flex_tx_sched_desc *txd;
-	struct idpf_tx_entry *sw_ring;
+	struct ci_tx_entry *sw_ring;
 	union idpf_tx_offload tx_offload = {0};
-	struct idpf_tx_entry *txe, *txn;
+	struct ci_tx_entry *txe, *txn;
 	uint16_t nb_used, tx_id, sw_id;
 	struct rte_mbuf *tx_pkt;
 	uint16_t nb_to_clean;
@@ -886,7 +886,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = tx_pkts[nb_tx];
 
-		if (txq->nb_free <= txq->free_thresh) {
+		if (txq->nb_tx_free <= txq->tx_free_thresh) {
 			/* TODO: Need to refine
 			 * 1. free and clean: Better to decide a clean destination instead of
 			 * loop times. And don't free mbuf when RS got immediately, free when
@@ -895,12 +895,12 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 * 2. out-of-order rewrite back haven't be supported, SW head and HW head
 			 * need to be separated.
 			 **/
-			nb_to_clean = 2 * txq->rs_thresh;
+			nb_to_clean = 2 * txq->tx_rs_thresh;
 			while (nb_to_clean--)
 				idpf_split_tx_free(txq->complq);
 		}
 
-		if (txq->nb_free < tx_pkt->nb_segs)
+		if (txq->nb_tx_free < tx_pkt->nb_segs)
 			break;
 
 		cmd_dtype = 0;
@@ -953,13 +953,13 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
 
-		txq->nb_free = (uint16_t)(txq->nb_free - nb_used);
-		txq->nb_used = (uint16_t)(txq->nb_used + nb_used);
+		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
+		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 
-		if (txq->nb_used >= 32) {
+		if (txq->nb_tx_used >= 32) {
 			txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_RE;
 			/* Update txq RE bit counters */
-			txq->nb_used = 0;
+			txq->nb_tx_used = 0;
 		}
 	}
 
@@ -1302,17 +1302,17 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline int
-idpf_xmit_cleanup(struct idpf_tx_queue *txq)
+idpf_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	struct idpf_tx_entry *sw_ring = txq->sw_ring;
+	struct ci_tx_entry *sw_ring = txq->sw_ring;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
 
-	volatile struct idpf_base_tx_desc *txd = txq->tx_ring;
+	volatile struct idpf_base_tx_desc *txd = txq->idpf_tx_ring;
 
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->rs_thresh);
+	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
 	if (desc_to_clean_to >= nb_tx_desc)
 		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
 
@@ -1336,7 +1336,7 @@ idpf_xmit_cleanup(struct idpf_tx_queue *txq)
 	txd[desc_to_clean_to].qw1 = 0;
 
 	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_free = (uint16_t)(txq->nb_free + nb_tx_to_clean);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
 
 	return 0;
 }
@@ -1349,9 +1349,9 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct idpf_base_tx_desc *txd;
 	volatile struct idpf_base_tx_desc *txr;
 	union idpf_tx_offload tx_offload = {0};
-	struct idpf_tx_entry *txe, *txn;
-	struct idpf_tx_entry *sw_ring;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_entry *txe, *txn;
+	struct ci_tx_entry *sw_ring;
+	struct ci_tx_queue *txq;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
 	uint64_t buf_dma_addr;
@@ -1372,12 +1372,12 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return nb_tx;
 
 	sw_ring = txq->sw_ring;
-	txr = txq->tx_ring;
+	txr = txq->idpf_tx_ring;
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
 
 	/* Check if the descriptor ring needs to be cleaned. */
-	if (txq->nb_free < txq->free_thresh)
+	if (txq->nb_tx_free < txq->tx_free_thresh)
 		(void)idpf_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
@@ -1410,14 +1410,14 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		       " tx_first=%u tx_last=%u",
 		       txq->port_id, txq->queue_id, tx_id, tx_last);
 
-		if (nb_used > txq->nb_free) {
+		if (nb_used > txq->nb_tx_free) {
 			if (idpf_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
 					return 0;
 				goto end_of_tx;
 			}
-			if (unlikely(nb_used > txq->rs_thresh)) {
-				while (nb_used > txq->nb_free) {
+			if (unlikely(nb_used > txq->tx_rs_thresh)) {
+				while (nb_used > txq->nb_tx_free) {
 					if (idpf_xmit_cleanup(txq) != 0) {
 						if (nb_tx == 0)
 							return 0;
@@ -1479,10 +1479,10 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		/* The last packet data descriptor needs End Of Packet (EOP) */
 		td_cmd |= IDPF_TX_DESC_CMD_EOP;
-		txq->nb_used = (uint16_t)(txq->nb_used + nb_used);
-		txq->nb_free = (uint16_t)(txq->nb_free - nb_used);
+		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
+		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-		if (txq->nb_used >= txq->rs_thresh) {
+		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
 			TX_LOG(DEBUG, "Setting RS bit on TXD id="
 			       "%4u (port=%d queue=%d)",
 			       tx_last, txq->port_id, txq->queue_id);
@@ -1490,7 +1490,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			td_cmd |= IDPF_TX_DESC_CMD_RS;
 
 			/* Update txq RS bit counters */
-			txq->nb_used = 0;
+			txq->nb_tx_used = 0;
 		}
 
 		txd->qw1 |= rte_cpu_to_le_16(td_cmd << IDPF_TXD_QW1_CMD_S);
@@ -1613,13 +1613,13 @@ idpf_rxq_vec_setup_default(struct idpf_rx_queue *rxq)
 int __rte_cold
 idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq)
 {
-	rxq->ops = &def_rx_ops_vec;
+	rxq->idpf_ops = &def_rx_ops_vec;
 	return idpf_rxq_vec_setup_default(rxq);
 }
 
 int __rte_cold
 idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rxq)
 {
-	rxq->bufq2->ops = &def_rx_ops_vec;
+	rxq->bufq2->idpf_ops = &def_rx_ops_vec;
 	return idpf_rxq_vec_setup_default(rxq->bufq2);
 }
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index e19e1878f3..3a2e7ab556 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -10,6 +10,7 @@
 #include <rte_mbuf_core.h>
 
 #include "idpf_common_device.h"
+#include "../common/tx.h"
 
 #define IDPF_RX_MAX_BURST		32
 
@@ -135,7 +136,7 @@ struct idpf_rx_queue {
 	bool q_set;             /* if rx queue has been configured */
 	bool q_started;         /* if rx queue has been started */
 	bool rx_deferred_start; /* don't start this queue in dev start */
-	const struct idpf_rxq_ops *ops;
+	const struct idpf_rxq_ops *idpf_ops;
 
 	struct idpf_rx_stats rx_stats;
 
@@ -148,54 +149,6 @@ struct idpf_rx_queue {
 	uint32_t hw_register_set;
 };
 
-struct idpf_tx_entry {
-	struct rte_mbuf *mbuf;
-	uint16_t next_id;
-	uint16_t last_id;
-};
-
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
@@ -223,7 +176,7 @@ struct idpf_rxq_ops {
 };
 
 struct idpf_txq_ops {
-	void (*release_mbufs)(struct idpf_tx_queue *txq);
+	void (*release_mbufs)(struct ci_tx_queue *txq);
 };
 
 extern int idpf_timestamp_dynfield_offset;
@@ -237,7 +190,7 @@ int idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 __rte_internal
 void idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq);
 __rte_internal
-void idpf_qc_txq_mbufs_release(struct idpf_tx_queue *txq);
+void idpf_qc_txq_mbufs_release(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq);
 __rte_internal
@@ -247,11 +200,11 @@ void idpf_qc_split_rx_queue_reset(struct idpf_rx_queue *rxq);
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
@@ -282,9 +235,9 @@ int idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq);
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
index 43a95466ae..4fd06cd05b 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -473,78 +473,12 @@ _idpf_singleq_recv_raw_pkts_vec_avx2(struct idpf_rx_queue *rxq, struct rte_mbuf
  * Notice:
  * - nb_pkts < IDPF_DESCS_PER_LOOP, just return no packet
  */
+
 uint16_t
 idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
 }
-static __rte_always_inline void
-idpf_tx_backlog_entry(struct idpf_tx_entry *txep,
-		     struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
-{
-	int i;
-
-	for (i = 0; i < (int)nb_pkts; ++i)
-		txep[i].mbuf = tx_pkts[i];
-}
-
-static __rte_always_inline int
-idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
-{
-	struct idpf_tx_entry *txep;
-	uint32_t n;
-	uint32_t i;
-	int nb_free = 0;
-	struct rte_mbuf *m;
-	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->rs_thresh);
-
-	/* check DD bits on threshold descriptor */
-	if ((txq->tx_ring[txq->next_dd].qw1 &
-			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
-			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
-		return 0;
-
-	n = txq->rs_thresh;
-
-	 /* first buffer to free from S/W ring is at index
-	  * next_dd - (rs_thresh-1)
-	  */
-	txep = &txq->sw_ring[txq->next_dd - (n - 1)];
-	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
-	if (likely(m)) {
-		free[0] = m;
-		nb_free = 1;
-		for (i = 1; i < n; i++) {
-			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-			if (likely(m)) {
-				if (likely(m->pool == free[0]->pool)) {
-					free[nb_free++] = m;
-				} else {
-					rte_mempool_put_bulk(free[0]->pool,
-							     (void *)free,
-							     nb_free);
-					free[0] = m;
-					nb_free = 1;
-				}
-			}
-		}
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
-	} else {
-		for (i = 1; i < n; i++) {
-			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-			if (m)
-				rte_mempool_put(m->pool, m);
-		}
-	}
-
-	/* buffers were freed, update counters */
-	txq->nb_free = (uint16_t)(txq->nb_free + txq->rs_thresh);
-	txq->next_dd = (uint16_t)(txq->next_dd + txq->rs_thresh);
-	if (txq->next_dd >= txq->nb_tx_desc)
-		txq->next_dd = (uint16_t)(txq->rs_thresh - 1);
-
-	return txq->rs_thresh;
-}
 
 static inline void
 idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
@@ -615,36 +549,44 @@ idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
 	}
 }
 
+static inline int
+idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
+{
+	return (txq->idpf_tx_ring[idx].qw1 &
+			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
+}
+
 static inline uint16_t
 idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 				       uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
-	struct idpf_tx_entry *txep;
+	struct ci_tx_entry *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
 
 	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
-	if (txq->nb_free < txq->free_thresh)
-		idpf_singleq_tx_free_bufs_vec(txq);
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
 
-	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
+	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->tx_ring[tx_id];
+	txdp = &txq->idpf_tx_ring[tx_id];
 	txep = &txq->sw_ring[tx_id];
 
-	txq->nb_free = (uint16_t)(txq->nb_free - nb_pkts);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		idpf_tx_backlog_entry(txep, tx_pkts, n);
+		ci_tx_backlog_entry(txep, tx_pkts, n);
 
 		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
 		tx_pkts += (n - 1);
@@ -655,24 +597,24 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 		nb_commit = (uint16_t)(nb_commit - n);
 
 		tx_id = 0;
-		txq->next_rs = (uint16_t)(txq->rs_thresh - 1);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->tx_ring[tx_id];
+		txdp = &txq->idpf_tx_ring[tx_id];
 		txep = &txq->sw_ring[tx_id];
 	}
 
-	idpf_tx_backlog_entry(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry(txep, tx_pkts, nb_commit);
 
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->next_rs) {
-		txq->tx_ring[txq->next_rs].qw1 |=
+	if (tx_id > txq->tx_next_rs) {
+		txq->idpf_tx_ring[txq->tx_next_rs].qw1 |=
 			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
 					 IDPF_TXD_QW1_CMD_S);
-		txq->next_rs =
-			(uint16_t)(txq->next_rs + txq->rs_thresh);
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
 
 	txq->tx_tail = tx_id;
@@ -687,12 +629,12 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts)
 {
 	uint16_t nb_tx = 0;
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
 
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 		ret = idpf_singleq_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_tx],
 						    num);
 		nb_tx += ret;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index b630d1fcd9..f6c8e8ba52 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -996,28 +996,28 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static __rte_always_inline int
-idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_vec_entry *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
 	struct rte_mbuf *m;
-	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->rs_thresh);
+	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
 
 	/* check DD bits on threshold descriptor */
-	if ((txq->tx_ring[txq->next_dd].qw1 &
+	if ((txq->idpf_tx_ring[txq->tx_next_dd].qw1 &
 			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
 			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
 
-	n = txq->rs_thresh;
+	n = txq->tx_rs_thresh;
 
 	 /* first buffer to free from S/W ring is at index
 	  * tx_next_dd - (tx_rs_thresh-1)
 	  */
 	txep = (void *)txq->sw_ring;
-	txep += txq->next_dd - (n - 1);
+	txep += txq->tx_next_dd - (n - 1);
 
 	if (txq->offloads & IDPF_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) == 0) {
 		struct rte_mempool *mp = txep[0].mbuf->pool;
@@ -1103,12 +1103,12 @@ idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
 
 done:
 	/* buffers were freed, update counters */
-	txq->nb_free = (uint16_t)(txq->nb_free + txq->rs_thresh);
-	txq->next_dd = (uint16_t)(txq->next_dd + txq->rs_thresh);
-	if (txq->next_dd >= txq->nb_tx_desc)
-		txq->next_dd = (uint16_t)(txq->rs_thresh - 1);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
+	if (txq->tx_next_dd >= txq->nb_tx_desc)
+		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
 
-	return txq->rs_thresh;
+	return txq->tx_rs_thresh;
 }
 
 static __rte_always_inline void
@@ -1193,7 +1193,7 @@ static __rte_always_inline uint16_t
 idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					 uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = tx_queue;
+	struct ci_tx_queue *txq = tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
 	struct idpf_tx_vec_entry *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -1201,22 +1201,22 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
 
 	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
-	if (txq->nb_free < txq->free_thresh)
+	if (txq->nb_tx_free < txq->tx_free_thresh)
 		idpf_tx_singleq_free_bufs_avx512(txq);
 
-	nb_pkts = (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
+	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	nb_commit = nb_pkts;
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->tx_ring[tx_id];
+	txdp = &txq->idpf_tx_ring[tx_id];
 	txep = (void *)txq->sw_ring;
 	txep += tx_id;
 
-	txq->nb_free = (uint16_t)(txq->nb_free - nb_pkts);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
@@ -1231,10 +1231,10 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 		nb_commit = (uint16_t)(nb_commit - n);
 
 		tx_id = 0;
-		txq->next_rs = (uint16_t)(txq->rs_thresh - 1);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->tx_ring[tx_id];
+		txdp = &txq->idpf_tx_ring[tx_id];
 		txep = (void *)txq->sw_ring;
 		txep += tx_id;
 	}
@@ -1244,12 +1244,12 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->next_rs) {
-		txq->tx_ring[txq->next_rs].qw1 |=
+	if (tx_id > txq->tx_next_rs) {
+		txq->idpf_tx_ring[txq->tx_next_rs].qw1 |=
 			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
 					 IDPF_TXD_QW1_CMD_S);
-		txq->next_rs =
-			(uint16_t)(txq->next_rs + txq->rs_thresh);
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
 
 	txq->tx_tail = tx_id;
@@ -1264,12 +1264,12 @@ idpf_singleq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts)
 {
 	uint16_t nb_tx = 0;
-	struct idpf_tx_queue *txq = tx_queue;
+	struct ci_tx_queue *txq = tx_queue;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
 
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 		ret = idpf_singleq_xmit_fixed_burst_vec_avx512(tx_queue, &tx_pkts[nb_tx],
 						       num);
 		nb_tx += ret;
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
 
@@ -1321,22 +1321,22 @@ idpf_splitq_scan_cq_ring(struct idpf_tx_queue *cq)
 }
 
 static __rte_always_inline int
-idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_splitq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
 	struct idpf_tx_vec_entry *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
 	struct rte_mbuf *m;
-	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->rs_thresh);
+	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
 
-	n = txq->rs_thresh;
+	n = txq->tx_rs_thresh;
 
 	 /* first buffer to free from S/W ring is at index
 	  * tx_next_dd - (tx_rs_thresh-1)
 	  */
 	txep = (void *)txq->sw_ring;
-	txep += txq->next_dd - (n - 1);
+	txep += txq->tx_next_dd - (n - 1);
 
 	if (txq->offloads & IDPF_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) == 0) {
 		struct rte_mempool *mp = txep[0].mbuf->pool;
@@ -1415,13 +1415,13 @@ idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
 
 done:
 	/* buffers were freed, update counters */
-	txq->nb_free = (uint16_t)(txq->nb_free + txq->rs_thresh);
-	txq->next_dd = (uint16_t)(txq->next_dd + txq->rs_thresh);
-	if (txq->next_dd >= txq->nb_tx_desc)
-		txq->next_dd = (uint16_t)(txq->rs_thresh - 1);
-	txq->ctype[IDPF_TXD_COMPLT_RS] -= txq->rs_thresh;
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
+	if (txq->tx_next_dd >= txq->nb_tx_desc)
+		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
+	txq->ctype[IDPF_TXD_COMPLT_RS] -= txq->tx_rs_thresh;
 
-	return txq->rs_thresh;
+	return txq->tx_rs_thresh;
 }
 
 #define IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S	48
@@ -1496,7 +1496,7 @@ static __rte_always_inline uint16_t
 idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txdp;
 	struct idpf_tx_vec_entry *txep;
 	uint16_t n, nb_commit, tx_id;
@@ -1506,9 +1506,9 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 	tx_id = txq->tx_tail;
 
 	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
-	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
+	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
@@ -1517,7 +1517,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 	txep = (void *)txq->sw_ring;
 	txep += tx_id;
 
-	txq->nb_free = (uint16_t)(txq->nb_free - nb_pkts);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
@@ -1532,7 +1532,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 		nb_commit = (uint16_t)(nb_commit - n);
 
 		tx_id = 0;
-		txq->next_rs = (uint16_t)(txq->rs_thresh - 1);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
 		txdp = &txq->desc_ring[tx_id];
@@ -1545,9 +1545,9 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 	idpf_splitq_vtx(txdp, tx_pkts, nb_commit, cmd_dtype);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->next_rs)
-		txq->next_rs =
-			(uint16_t)(txq->next_rs + txq->rs_thresh);
+	if (tx_id > txq->tx_next_rs)
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 
 	txq->tx_tail = tx_id;
 
@@ -1560,7 +1560,7 @@ static __rte_always_inline uint16_t
 idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 				     uint16_t nb_pkts)
 {
-	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	uint16_t nb_tx = 0;
 
 	while (nb_pkts) {
@@ -1568,10 +1568,10 @@ idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		idpf_splitq_scan_cq_ring(txq->complq);
 
-		if (txq->ctype[IDPF_TXD_COMPLT_RS] > txq->free_thresh)
+		if (txq->ctype[IDPF_TXD_COMPLT_RS] > txq->tx_free_thresh)
 			idpf_tx_splitq_free_bufs_avx512(txq);
 
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 		ret = idpf_splitq_xmit_fixed_burst_vec_avx512(tx_queue,
 							      &tx_pkts[nb_tx],
 							      num);
@@ -1592,16 +1592,16 @@ idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 static inline void
-idpf_tx_release_mbufs_avx512(struct idpf_tx_queue *txq)
+idpf_tx_release_mbufs_avx512(struct ci_tx_queue *txq)
 {
 	unsigned int i;
 	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
 	struct idpf_tx_vec_entry *swr = (void *)txq->sw_ring;
 
-	if (txq->sw_ring == NULL || txq->nb_free == max_desc)
+	if (txq->sw_ring == NULL || txq->nb_tx_free == max_desc)
 		return;
 
-	i = txq->next_dd - txq->rs_thresh + 1;
+	i = txq->tx_next_dd - txq->tx_rs_thresh + 1;
 	if (txq->tx_tail < i) {
 		for (; i < txq->nb_tx_desc; i++) {
 			rte_pktmbuf_free_seg(swr[i].mbuf);
@@ -1620,11 +1620,11 @@ static const struct idpf_txq_ops avx512_tx_vec_ops = {
 };
 
 int __rte_cold
-idpf_qc_tx_vec_avx512_setup(struct idpf_tx_queue *txq)
+idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
 {
 	if (!txq)
 		return 0;
 
-	txq->ops = &avx512_tx_vec_ops;
+	txq->idpf_ops = &avx512_tx_vec_ops;
 	return 0;
 }
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index 0ae1d55d79..0580a1819a 100644
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
@@ -1101,7 +1101,7 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
 
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		txq_info = &vc_txqs->qinfo[0];
-		txq_info->dma_ring_addr = txq->tx_ring_phys_addr;
+		txq_info->dma_ring_addr = txq->tx_ring_dma;
 		txq_info->type = VIRTCHNL2_QUEUE_TYPE_TX;
 		txq_info->queue_id = txq->queue_id;
 		txq_info->model = VIRTCHNL2_QUEUE_MODEL_SINGLE;
@@ -1110,7 +1110,7 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
 	} else {
 		/* txq info */
 		txq_info = &vc_txqs->qinfo[0];
-		txq_info->dma_ring_addr = txq->tx_ring_phys_addr;
+		txq_info->dma_ring_addr = txq->tx_ring_dma;
 		txq_info->type = VIRTCHNL2_QUEUE_TYPE_TX;
 		txq_info->queue_id = txq->queue_id;
 		txq_info->model = VIRTCHNL2_QUEUE_MODEL_SPLIT;
@@ -1121,7 +1121,7 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
 
 		/* tx completion queue info */
 		txq_info = &vc_txqs->qinfo[1];
-		txq_info->dma_ring_addr = txq->complq->tx_ring_phys_addr;
+		txq_info->dma_ring_addr = txq->complq->tx_ring_dma;
 		txq_info->type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
 		txq_info->queue_id = txq->complq->queue_id;
 		txq_info->model = VIRTCHNL2_QUEUE_MODEL_SPLIT;
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
index 0c3ecd2765..57cc9b2618 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -187,7 +187,7 @@ idpf_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 	idpf_qc_split_rx_bufq_reset(bufq);
 	bufq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_buf_qtail_start +
 			 queue_idx * vport->chunks_info.rx_buf_qtail_spacing);
-	bufq->ops = &def_rxq_ops;
+	bufq->idpf_ops = &def_rxq_ops;
 	bufq->q_set = true;
 
 	if (bufq_id == IDPF_RX_SPLIT_BUFQ1_ID) {
@@ -305,7 +305,7 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		idpf_qc_single_rx_queue_reset(rxq);
 		rxq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_qtail_start +
 				queue_idx * vport->chunks_info.rx_qtail_spacing);
-		rxq->ops = &def_rxq_ops;
+		rxq->idpf_ops = &def_rxq_ops;
 	} else {
 		idpf_qc_split_rx_descq_reset(rxq);
 
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
@@ -378,7 +378,7 @@ idpf_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
 		ret = -ENOMEM;
 		goto err_mz_reserve;
 	}
-	cq->tx_ring_phys_addr = mz->iova;
+	cq->tx_ring_dma = mz->iova;
 	cq->compl_ring = mz->addr;
 	cq->mz = mz;
 	idpf_qc_split_tx_complq_reset(cq);
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
@@ -438,8 +438,8 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	is_splitq = !!(vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT);
 
 	txq->nb_tx_desc = nb_desc;
-	txq->rs_thresh = tx_rs_thresh;
-	txq->free_thresh = tx_free_thresh;
+	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
 	txq->port_id = dev->data->port_id;
 	txq->offloads = idpf_tx_offload_convert(offloads);
@@ -458,11 +458,11 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		ret = -ENOMEM;
 		goto err_mz_reserve;
 	}
-	txq->tx_ring_phys_addr = mz->iova;
+	txq->tx_ring_dma = mz->iova;
 	txq->mz = mz;
 
 	txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
-					  sizeof(struct idpf_tx_entry) * len,
+					  sizeof(struct ci_tx_entry) * len,
 					  RTE_CACHE_LINE_SIZE, socket_id);
 	if (txq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
@@ -471,7 +471,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	if (!is_splitq) {
-		txq->tx_ring = mz->addr;
+		txq->idpf_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
@@ -486,7 +486,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	txq->qtx_tail = hw->hw_addr + (vport->chunks_info.tx_qtail_start +
 			queue_idx * vport->chunks_info.tx_qtail_spacing);
-	txq->ops = &def_txq_ops;
+	txq->idpf_ops = &def_txq_ops;
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = txq;
 
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
 
@@ -682,11 +682,11 @@ idpf_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	rxq = dev->data->rx_queues[rx_queue_id];
 	rxq->q_started = false;
 	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-		rxq->ops->release_mbufs(rxq);
+		rxq->idpf_ops->release_mbufs(rxq);
 		idpf_qc_single_rx_queue_reset(rxq);
 	} else {
-		rxq->bufq1->ops->release_mbufs(rxq->bufq1);
-		rxq->bufq2->ops->release_mbufs(rxq->bufq2);
+		rxq->bufq1->idpf_ops->release_mbufs(rxq->bufq1);
+		rxq->bufq2->idpf_ops->release_mbufs(rxq->bufq2);
 		idpf_qc_split_rx_queue_reset(rxq);
 	}
 	dev->data->rx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
@@ -698,7 +698,7 @@ int
 idpf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int err;
 
 	if (tx_queue_id >= dev->data->nb_tx_queues)
@@ -714,7 +714,7 @@ idpf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	txq = dev->data->tx_queues[tx_queue_id];
 	txq->q_started = false;
-	txq->ops->release_mbufs(txq);
+	txq->idpf_ops->release_mbufs(txq);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
@@ -742,7 +742,7 @@ void
 idpf_stop_queues(struct rte_eth_dev *dev)
 {
 	struct idpf_rx_queue *rxq;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int i;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -880,7 +880,7 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
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
index 002c1e6948..2446951553 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -10,6 +10,7 @@
 
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
+#include "../common/rx.h"
 
 #define IDPF_SCALAR_PATH		0
 #define IDPF_VECTOR_PATH		1
@@ -49,13 +50,13 @@ idpf_rx_vec_queue_default(struct idpf_rx_queue *rxq)
 }
 
 static inline int
-idpf_tx_vec_queue_default(struct idpf_tx_queue *txq)
+idpf_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
 	if (txq == NULL)
 		return IDPF_SCALAR_PATH;
 
-	if (txq->rs_thresh < IDPF_VPMD_TX_MAX_BURST ||
-	    (txq->rs_thresh & 3) != 0)
+	if (txq->tx_rs_thresh < IDPF_VPMD_TX_MAX_BURST ||
+	    (txq->tx_rs_thresh & 3) != 0)
 		return IDPF_SCALAR_PATH;
 
 	if ((txq->offloads & IDPF_TX_NO_VECTOR_FLAGS) != 0)
@@ -99,11 +100,19 @@ idpf_rx_vec_dev_check_default(struct rte_eth_dev *dev)
 	return IDPF_VECTOR_PATH;
 }
 
+static inline int
+idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
+{
+	return (txq->idpf_tx_ring[idx].qw1 &
+			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
+}
+
 static inline int
 idpf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 {
 	int i;
-	struct idpf_tx_queue *txq;
+	struct ci_tx_queue *txq;
 	int ret = 0;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 802b13035b..4b8d4a8c08 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -37,7 +37,7 @@ if arch_subdir == 'x86' and dpdk_conf.get('RTE_IOVA_IN_MBUF') == 1
         endif
         idpf_common_avx512_lib = static_library('idpf_common_avx512_lib',
                 'idpf_common_rxtx_avx512.c',
-                dependencies: static_rte_mbuf,
+                dependencies: [static_rte_mbuf,static_rte_ethdev],
                 include_directories: includes,
                 c_args: avx512_args)
         objs += idpf_common_avx512_lib.extract_objects('idpf_common_rxtx_avx512.c')
-- 
2.34.1

