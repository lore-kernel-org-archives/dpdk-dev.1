Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8865C36005
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 09:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EC654066F;
	Mon, 28 Apr 2025 11:22:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E142640657
 for <dev@dpdk.org>; Mon, 28 Apr 2025 11:22:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745832128; x=1777368128;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Jco8pGZ66/+Ml9mzUg9xWogK7Uac+JIevLPG1wOtVCo=;
 b=AY/WrZjs7Y1Dh6txr79wDRt9ejS9XqeKJZ8A34yYNl8GWb4YUjFNYPxO
 QKgkB8HIGsvqowYExPCTnS7Hug6cIV/1Q61mlkvuiaezw1eXmLxZHprj+
 tH3xfgQXXzYTAo40srnXTdi8oOlctj9CIG24ebhNJMJCDSO1GiRIc/wqW
 e+hw0EX2X6wx+DBeZfQjdRo7IAVWksYe+XSVu1oM4mGHwqK7Dnl6COwIO
 bX7rgugM388NQfOLmU/l0Xt/i5j1tSk1tcmyANFrGlGJLzKDXO/QnN32z
 mSMD5bj9VuG0k1NfBFA8yauGI4dVjTvItgMMH6YNuwadVSBo2MWWjC1qC w==;
X-CSE-ConnectionGUID: SyoNCU48Ti2LgWAONQz0Ug==
X-CSE-MsgGUID: HbosI3ltS3iAM35HV+sdRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47300837"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="47300837"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 02:20:38 -0700
X-CSE-ConnectionGUID: PfB8M/0VRHCrNwcUUhFi0g==
X-CSE-MsgGUID: Ae4KOlC5RsSEtsNpIF88BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="133352899"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa006.fm.intel.com with ESMTP; 28 Apr 2025 02:20:37 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v8 2/4] net/intel: use common Tx entry structure
Date: Mon, 28 Apr 2025 14:51:33 +0530
Message-Id: <20250428092135.1058532-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428092135.1058532-1-shaiq.wani@intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250428092135.1058532-1-shaiq.wani@intel.com>
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

Used the common Tx entry structure and common Tx mbuf ring replenish fn
in place of idpf-specific structure and function.
The vector driver code paths (AVX2, AVX512) use the smaller SW
ring structure.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  2 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 16 +++++------
 drivers/net/intel/idpf/idpf_common_rxtx.h     | 13 ++-------
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 21 ++++----------
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 28 ++++++-------------
 drivers/net/intel/idpf/idpf_ethdev.c          |  1 +
 drivers/net/intel/idpf/idpf_rxtx.c            |  2 +-
 drivers/net/intel/idpf/idpf_rxtx.h            |  1 +
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  1 +
 9 files changed, 30 insertions(+), 55 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 8eed8f16d5..6b7e7c5087 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -589,7 +589,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->mz = mz;
 
 	txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
-					  sizeof(struct idpf_tx_entry) * len,
+					  sizeof(struct ci_tx_entry) * len,
 					  RTE_CACHE_LINE_SIZE, socket_id);
 	if (txq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index f0e8d099ef..a008431bcf 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -220,7 +220,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_descq_reset)
 void
 idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
 {
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	uint32_t i, size;
 	uint16_t prev;
 
@@ -278,7 +278,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_tx_queue_reset)
 void
 idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
 {
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	uint32_t i, size;
 	uint16_t prev;
 
@@ -773,7 +773,7 @@ idpf_split_tx_free(struct idpf_tx_queue *cq)
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	struct idpf_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
@@ -882,9 +882,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
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
@@ -1326,7 +1326,7 @@ static inline int
 idpf_xmit_cleanup(struct idpf_tx_queue *txq)
 {
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	struct idpf_tx_entry *sw_ring = txq->sw_ring;
+	struct ci_tx_entry *sw_ring = txq->sw_ring;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
@@ -1371,8 +1371,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct idpf_base_tx_desc *txd;
 	volatile struct idpf_base_tx_desc *txr;
 	union idpf_tx_offload tx_offload = {0};
-	struct idpf_tx_entry *txe, *txn;
-	struct idpf_tx_entry *sw_ring;
+	struct ci_tx_entry *txe, *txn;
+	struct ci_tx_entry *sw_ring;
 	struct idpf_tx_queue *txq;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 84c05cfaac..30f9e9398d 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -10,6 +10,7 @@
 #include <rte_mbuf_core.h>
 
 #include "idpf_common_device.h"
+#include "../common/tx.h"
 
 #define IDPF_RX_MAX_BURST		32
 
@@ -148,12 +149,6 @@ struct idpf_rx_queue {
 	uint32_t hw_register_set;
 };
 
-struct idpf_tx_entry {
-	struct rte_mbuf *mbuf;
-	uint16_t next_id;
-	uint16_t last_id;
-};
-
 /* Structure associated with each TX queue. */
 struct idpf_tx_queue {
 	const struct rte_memzone *mz;		/* memzone for Tx ring */
@@ -163,7 +158,7 @@ struct idpf_tx_queue {
 		struct idpf_splitq_tx_compl_desc *compl_ring;
 	};
 	rte_iova_t tx_ring_dma;		/* Tx ring DMA address */
-	struct idpf_tx_entry *sw_ring;		/* address array of SW ring */
+	struct ci_tx_entry *sw_ring;		/* address array of SW ring */
 
 	uint16_t nb_tx_desc;		/* ring length */
 	uint16_t tx_tail;		/* current value of tail */
@@ -209,10 +204,6 @@ union idpf_tx_offload {
 	};
 };
 
-struct idpf_tx_vec_entry {
-	struct rte_mbuf *mbuf;
-};
-
 union idpf_tx_desc {
 	struct idpf_base_tx_desc *tx_ring;
 	struct idpf_flex_tx_sched_desc *desc_ring;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 6b7e1df9cd..8481e3b6bb 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -480,20 +480,11 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
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
 
 static __rte_always_inline int
 idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
 {
-	struct idpf_tx_entry *txep;
+	struct ci_tx_entry *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -623,7 +614,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 {
 	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
-	struct idpf_tx_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
@@ -640,13 +631,13 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 	tx_id = txq->tx_tail;
 	txdp = &txq->idpf_tx_ring[tx_id];
-	txep = &txq->sw_ring[tx_id];
+	txep = (struct ci_tx_entry_vec *)&txq->sw_ring[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		idpf_tx_backlog_entry(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
 		tx_pkts += (n - 1);
@@ -661,10 +652,10 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 		/* avoid reach the end of ring */
 		txdp = &txq->idpf_tx_ring[tx_id];
-		txep = &txq->sw_ring[tx_id];
+		txep = (struct ci_tx_entry_vec *)&txq->sw_ring[tx_id];
 	}
 
-	idpf_tx_backlog_entry(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index e0a0f1a8a7..4c65386f42 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1001,7 +1001,7 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 static __rte_always_inline int
 idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
 {
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -1114,16 +1114,6 @@ idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
 	return txq->tx_rs_thresh;
 }
 
-static __rte_always_inline void
-tx_backlog_entry_avx512(struct idpf_tx_vec_entry *txep,
-			struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
-{
-	int i;
-
-	for (i = 0; i < (int)nb_pkts; ++i)
-		txep[i].mbuf = tx_pkts[i];
-}
-
 static __rte_always_inline void
 idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags)
@@ -1198,7 +1188,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 {
 	struct idpf_tx_queue *txq = tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
@@ -1223,7 +1213,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		tx_backlog_entry_avx512(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
 		tx_pkts += (n - 1);
@@ -1242,7 +1232,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 		txep += tx_id;
 	}
 
-	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
@@ -1327,7 +1317,7 @@ idpf_splitq_scan_cq_ring(struct idpf_tx_queue *cq)
 static __rte_always_inline int
 idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
 {
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -1502,7 +1492,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 {
 	struct idpf_tx_queue *txq = (struct idpf_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txdp;
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
@@ -1525,7 +1515,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		tx_backlog_entry_avx512(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_splitq_vtx(txdp, tx_pkts, n - 1, cmd_dtype);
 		tx_pkts += (n - 1);
@@ -1544,7 +1534,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 		txep += tx_id;
 	}
 
-	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_splitq_vtx(txdp, tx_pkts, nb_commit, cmd_dtype);
 
@@ -1601,7 +1591,7 @@ idpf_tx_release_mbufs_avx512(struct idpf_tx_queue *txq)
 {
 	unsigned int i;
 	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
-	struct idpf_tx_vec_entry *swr = (void *)txq->sw_ring;
+	struct ci_tx_entry_vec *swr = (void *)txq->sw_ring;
 
 	if (txq->sw_ring == NULL || txq->nb_tx_free == max_desc)
 		return;
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 7718167096..62685d3b7e 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -13,6 +13,7 @@
 
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
+#include "../common/tx.h"
 
 #define IDPF_TX_SINGLE_Q	"tx_single"
 #define IDPF_RX_SINGLE_Q	"rx_single"
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 95b112c95c..d67526c0fa 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -462,7 +462,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->mz = mz;
 
 	txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
-					  sizeof(struct idpf_tx_entry) * len,
+					  sizeof(struct ci_tx_entry) * len,
 					  RTE_CACHE_LINE_SIZE, socket_id);
 	if (txq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
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
index 608cab30f3..bb9cbf5c02 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -10,6 +10,7 @@
 
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
+#include "../common/rx.h"
 
 #define IDPF_SCALAR_PATH		0
 #define IDPF_VECTOR_PATH		1
-- 
2.34.1

