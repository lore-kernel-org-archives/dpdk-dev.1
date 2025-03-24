Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D74C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 12:48:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A4C540DD0;
	Mon, 24 Mar 2025 13:47:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 96D6940B9C
 for <dev@dpdk.org>; Mon, 24 Mar 2025 13:47:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742820467; x=1774356467;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IezZ8GucZrmDNYQHK52j65rACybAkYTFvbaPX/5RYLQ=;
 b=jMi5TKztVyqzPvHiKKHExwZdtY1ysuiXDqJAcMqMIOY0qc5IzcK4ThI8
 HtCPOFE+Vb+099uslawYh21h+kD/P9wfecZmZvjT8yuYxkmo4XS1e5U0P
 0vch6u/5SNPJDOOOF/FgbTaSWDGbH+D0JeMfHo5gvwaSo2FcQFilUCSJm
 cm7/yCWzftAdulFTfnquEo7olHwCVh4R4c4kVOqN0gnWbBnuwO2QkOpRU
 xAvOrLloKicfB81iBzUCjU/ukQ9K8wnX+gOxV+gsKdHNLf4C1++Ej7Aii
 X04SlHQVVZJjgTSIf8dAlwvyiOm4fAj9jt63rjxWRCQASvV6y4Gsd1fJ3 Q==;
X-CSE-ConnectionGUID: udD47gqGSW2b75w4LmEUbQ==
X-CSE-MsgGUID: wwMygzi3SNuCj5+/sMaOGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="55396299"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="55396299"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 05:47:47 -0700
X-CSE-ConnectionGUID: +LypG3oMREOwVPrHsoolYg==
X-CSE-MsgGUID: b4Znl5aFTgONAteBHJrxhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="128213563"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa003.fm.intel.com with ESMTP; 24 Mar 2025 05:47:44 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v3 3/4] net/intel: use common Tx entry structure
Date: Mon, 24 Mar 2025 18:19:07 +0530
Message-Id: <20250324124908.1282692-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324124908.1282692-1-shaiq.wani@intel.com>
References: <20250324124001.1282624-2-shaiq.wani@intel.com>
 <20250324124908.1282692-1-shaiq.wani@intel.com>
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
---
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  1 +
 drivers/net/intel/cpfl/cpfl_rxtx.h            |  1 +
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 16 +++++------
 drivers/net/intel/idpf/idpf_common_rxtx.h     | 11 +-------
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 25 ++++++-----------
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 28 ++++++-------------
 drivers/net/intel/idpf/idpf_ethdev.c          |  1 +
 drivers/net/intel/idpf/idpf_rxtx.c            |  2 +-
 drivers/net/intel/idpf/idpf_rxtx.h            |  1 +
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  1 +
 drivers/net/intel/idpf/meson.build            |  2 +-
 12 files changed, 34 insertions(+), 56 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 2f071082e1..c94010bc51 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -18,6 +18,7 @@
 #include "cpfl_rxtx.h"
 #include "cpfl_flow.h"
 #include "cpfl_rules.h"
+#include "../common/tx.h"
 
 #define CPFL_REPRESENTOR	"representor"
 #define CPFL_TX_SINGLE_Q	"tx_single"
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.h b/drivers/net/intel/cpfl/cpfl_rxtx.h
index 314a233e6d..52cdecac88 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.h
@@ -7,6 +7,7 @@
 
 #include <idpf_common_rxtx.h>
 #include "cpfl_ethdev.h"
+#include "../common/tx.h"
 
 /* In QLEN must be whole number of 32 descriptors. */
 #define CPFL_ALIGN_RING_DESC	32
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
index f1e555b5f8..874b5cd5f3 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
@@ -10,6 +10,7 @@
 
 #include "cpfl_ethdev.h"
 #include "cpfl_rxtx.h"
+#include "../common/tx.h"
 
 #define CPFL_SCALAR_PATH		0
 #define CPFL_VECTOR_PATH		1
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 648b082924..deaa579391 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -210,7 +210,7 @@ idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
 void
 idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	uint32_t i, size;
 	uint16_t prev;
 
@@ -266,7 +266,7 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
 void
 idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	uint32_t i, size;
 	uint16_t prev;
 
@@ -755,7 +755,7 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	struct ci_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
@@ -863,9 +863,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
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
@@ -1305,7 +1305,7 @@ static inline int
 idpf_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	struct idpf_tx_entry *sw_ring = txq->sw_ring;
+	struct ci_tx_entry *sw_ring = txq->sw_ring;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
@@ -1349,8 +1349,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct idpf_base_tx_desc *txd;
 	volatile struct idpf_base_tx_desc *txr;
 	union idpf_tx_offload tx_offload = {0};
-	struct idpf_tx_entry *txe, *txn;
-	struct idpf_tx_entry *sw_ring;
+	struct ci_tx_entry *txe, *txn;
+	struct ci_tx_entry *sw_ring;
 	struct ci_tx_queue *txq;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index f65dc01cc2..fc68dddc90 100644
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
 /* Offload features */
 union idpf_tx_offload {
 	uint64_t data;
@@ -166,10 +161,6 @@ union idpf_tx_offload {
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
index 5e4e738ffa..bce0257804 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -478,20 +478,11 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
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
 idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -499,7 +490,7 @@ idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
 	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
 
 	/* check DD bits on threshold descriptor */
-	if ((txq->sw_ring[txq->tx_next_dd].qw1 &
+	if ((txq->idpf_tx_ring[txq->tx_next_dd].qw1 &
 			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
 			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
@@ -509,7 +500,7 @@ idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
 	 /* first buffer to free from S/W ring is at index
 	  * tx_next_dd - (tx_rs_thresh-1)
 	  */
-	txep = &txq->sw_ring[txq->tx_next_dd - (n - 1)];
+	txep = &txq->sw_ring_vec[txq->tx_next_dd - (n - 1)];
 	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
 	if (likely(m)) {
 		free[0] = m;
@@ -621,7 +612,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
-	struct idpf_tx_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
@@ -638,13 +629,13 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 	tx_id = txq->tx_tail;
 	txdp = &txq->idpf_tx_ring[tx_id];
-	txep = &txq->sw_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		idpf_tx_backlog_entry(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
 		tx_pkts += (n - 1);
@@ -659,10 +650,10 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 		/* avoid reach the end of ring */
 		txdp = &txq->idpf_tx_ring[tx_id];
-		txep = &txq->sw_ring[tx_id];
+		txep = &txq->sw_ring_vec[tx_id];
 	}
 
-	idpf_tx_backlog_entry(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index f6c8e8ba52..715be52046 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -998,7 +998,7 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 static __rte_always_inline int
 idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -1111,16 +1111,6 @@ idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
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
@@ -1195,7 +1185,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 {
 	struct ci_tx_queue *txq = tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
@@ -1220,7 +1210,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		tx_backlog_entry_avx512(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
 		tx_pkts += (n - 1);
@@ -1239,7 +1229,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 		txep += tx_id;
 	}
 
-	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
@@ -1323,7 +1313,7 @@ idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
 static __rte_always_inline int
 idpf_tx_splitq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -1498,7 +1488,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txdp;
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
@@ -1521,7 +1511,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		tx_backlog_entry_avx512(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_splitq_vtx(txdp, tx_pkts, n - 1, cmd_dtype);
 		tx_pkts += (n - 1);
@@ -1540,7 +1530,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 		txep += tx_id;
 	}
 
-	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_splitq_vtx(txdp, tx_pkts, nb_commit, cmd_dtype);
 
@@ -1596,7 +1586,7 @@ idpf_tx_release_mbufs_avx512(struct ci_tx_queue *txq)
 {
 	unsigned int i;
 	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
-	struct idpf_tx_vec_entry *swr = (void *)txq->sw_ring;
+	struct ci_tx_entry_vec *swr = (void *)txq->sw_ring;
 
 	if (txq->sw_ring == NULL || txq->nb_tx_free == max_desc)
 		return;
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index e722f4d3e8..90720909bf 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -13,6 +13,7 @@
 
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
+#include "../common/tx.h"
 
 #define IDPF_TX_SINGLE_Q	"tx_single"
 #define IDPF_RX_SINGLE_Q	"rx_single"
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index fcf13696d1..16503ca7af 100644
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
index 597d4472d2..f97a9a6fce 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -10,6 +10,7 @@
 
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
+#include "../common/tx.h"
 
 #define IDPF_SCALAR_PATH		0
 #define IDPF_VECTOR_PATH		1
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 4b272d02b1..296c9cec45 100644
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

