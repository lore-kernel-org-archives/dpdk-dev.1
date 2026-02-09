Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B692E7E0CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:45:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C2C14065F;
	Mon,  9 Feb 2026 17:45:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D208C40655
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:45:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655545; x=1802191545;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oXUASbCRiwHsyfR0Tfi737ZGqffUnywg8UU3nLIPWGs=;
 b=Aa5n7KqiSGyI3lweFB/0PZY5dOV5zHfU5nUvP0/3iH7bFX3tf5U2kr/v
 ddYnIZjoRIp3eNSMJ3sUyGo+Tbqx91OtlfXiyyUvOIvcWhuY3XkonqPFK
 6zlijMJL3ki3ShRx/jTehvG9L2TUdhDV3opCNn0rcpTUMdUNBqFozCDTi
 n/DNcy+tOlTWpzY3EJkowDwinXpgRHEhDATPzg14SdWJ5R5AFRTJyDHoJ
 G8B5LLJfRybExVea2yHDfd9qbmf6C7yJXXZ48U/ohlmeuuKm8ZrrWZL4V
 HLcP9Yie7aalwwUMGxPmpKN36DBNuxGRU1oSqU/+MY6g5gi9uJWBwH2Gr w==;
X-CSE-ConnectionGUID: znz44IlVQSO6NinNQ09wmA==
X-CSE-MsgGUID: PtFVWKxkS36jUD3OuCDLrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663390"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663390"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:45:44 -0800
X-CSE-ConnectionGUID: BwThQ6hUQpCesGrvSjg+nQ==
X-CSE-MsgGUID: c8QJH0eVQXiBM9MZynnp8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789046"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:45:43 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v4 01/35] net/intel: create common Tx descriptor structure
Date: Mon,  9 Feb 2026 16:44:59 +0000
Message-ID: <20260209164538.1428499-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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

The Tx descriptors used by the i40e, iavf, ice and idpf drivers are all
identical 16-byte descriptors, so define a common struct for them. Since
original struct definitions are in base code, leave them in place, but
only use the new structs in DPDK code.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h                 | 16 ++++++---
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  2 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  4 +--
 drivers/net/intel/i40e/i40e_rxtx.c            | 26 +++++++-------
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  6 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  6 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  6 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  6 ++--
 drivers/net/intel/iavf/iavf_rxtx.c            | 16 ++++-----
 drivers/net/intel/iavf/iavf_rxtx.h            |  2 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  6 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 12 +++----
 drivers/net/intel/ice/ice_dcf_ethdev.c        |  2 +-
 drivers/net/intel/ice/ice_rxtx.c              | 36 +++++++++----------
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  6 ++--
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  6 ++--
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 20 +++++------
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  2 +-
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  8 ++---
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  8 ++---
 drivers/net/intel/idpf/idpf_rxtx.c            |  2 +-
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  2 +-
 22 files changed, 104 insertions(+), 96 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index e295d83e3a..d7561a2bbb 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -10,6 +10,14 @@
 #include <rte_ethdev.h>
 #include <rte_vect.h>
 
+/*
+ * Structure of a 16-byte Tx descriptor common across i40e, ice, iavf and idpf drivers
+ */
+struct ci_tx_desc {
+	uint64_t buffer_addr; /* Address of descriptor's data buf */
+	uint64_t cmd_type_offset_bsz;
+};
+
 /* forward declaration of the common intel (ci) queue structure */
 struct ci_tx_queue;
 
@@ -33,10 +41,10 @@ typedef void (*ice_tx_release_mbufs_t)(struct ci_tx_queue *txq);
 
 struct ci_tx_queue {
 	union { /* TX ring virtual address */
-		volatile struct i40e_tx_desc *i40e_tx_ring;
-		volatile struct iavf_tx_desc *iavf_tx_ring;
-		volatile struct ice_tx_desc *ice_tx_ring;
-		volatile struct idpf_base_tx_desc *idpf_tx_ring;
+		volatile struct ci_tx_desc *i40e_tx_ring;
+		volatile struct ci_tx_desc *iavf_tx_ring;
+		volatile struct ci_tx_desc *ice_tx_ring;
+		volatile struct ci_tx_desc *idpf_tx_ring;
 		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
 	};
 	volatile uint8_t *qtx_tail;               /* register address of tail */
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index d0438b5da0..78bc3e9b49 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -131,7 +131,7 @@ cpfl_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 			ring_size = RTE_ALIGN(len * sizeof(struct idpf_flex_tx_sched_desc),
 					      CPFL_DMA_MEM_ALIGN);
 		else
-			ring_size = RTE_ALIGN(len * sizeof(struct idpf_base_tx_desc),
+			ring_size = RTE_ALIGN(len * sizeof(struct ci_tx_desc),
 					      CPFL_DMA_MEM_ALIGN);
 		memcpy(ring_name, "cpfl Tx ring", sizeof("cpfl Tx ring"));
 		break;
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 55d18c5d4a..605df73c9e 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -1377,7 +1377,7 @@ i40e_find_available_buffer(struct rte_eth_dev *dev)
 	 */
 	if (fdir_info->txq_available_buf_count <= 0) {
 		uint16_t tmp_tail;
-		volatile struct i40e_tx_desc *tmp_txdp;
+		volatile struct ci_tx_desc *tmp_txdp;
 
 		tmp_tail = txq->tx_tail;
 		tmp_txdp = &txq->i40e_tx_ring[tmp_tail + 1];
@@ -1628,7 +1628,7 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 	struct ci_tx_queue *txq = pf->fdir.txq;
 	struct ci_rx_queue *rxq = pf->fdir.rxq;
 	const struct i40e_fdir_action *fdir_action = &filter->action;
-	volatile struct i40e_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	volatile struct i40e_filter_program_desc *fdirdp;
 	uint32_t td_cmd;
 	uint16_t vsi_id;
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 1c3586778c..92d49ccb79 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -388,7 +388,7 @@ static inline int
 i40e_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	volatile struct i40e_tx_desc *txd = txq->i40e_tx_ring;
+	volatile struct ci_tx_desc *txd = txq->i40e_tx_ring;
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
@@ -1092,8 +1092,8 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct ci_tx_queue *txq;
 	struct ci_tx_entry *sw_ring;
 	struct ci_tx_entry *txe, *txn;
-	volatile struct i40e_tx_desc *txd;
-	volatile struct i40e_tx_desc *txr;
+	volatile struct ci_tx_desc *txd;
+	volatile struct ci_tx_desc *txr;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
 	uint32_t cd_tunneling_params;
@@ -1398,7 +1398,7 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 
 /* Populate 4 descriptors with data from 4 mbufs */
 static inline void
-tx4(volatile struct i40e_tx_desc *txdp, struct rte_mbuf **pkts)
+tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
 {
 	uint64_t dma_addr;
 	uint32_t i;
@@ -1414,7 +1414,7 @@ tx4(volatile struct i40e_tx_desc *txdp, struct rte_mbuf **pkts)
 
 /* Populate 1 descriptor with data from 1 mbuf */
 static inline void
-tx1(volatile struct i40e_tx_desc *txdp, struct rte_mbuf **pkts)
+tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
 {
 	uint64_t dma_addr;
 
@@ -1431,7 +1431,7 @@ i40e_tx_fill_hw_ring(struct ci_tx_queue *txq,
 		     struct rte_mbuf **pkts,
 		     uint16_t nb_pkts)
 {
-	volatile struct i40e_tx_desc *txdp = &txq->i40e_tx_ring[txq->tx_tail];
+	volatile struct ci_tx_desc *txdp = &txq->i40e_tx_ring[txq->tx_tail];
 	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
 	const int N_PER_LOOP = 4;
 	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
@@ -1459,7 +1459,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts)
 {
-	volatile struct i40e_tx_desc *txr = txq->i40e_tx_ring;
+	volatile struct ci_tx_desc *txr = txq->i40e_tx_ring;
 	uint16_t n = 0;
 
 	/**
@@ -2616,7 +2616,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate TX hardware ring descriptors. */
-	ring_size = sizeof(struct i40e_tx_desc) * I40E_MAX_RING_DESC;
+	ring_size = sizeof(struct ci_tx_desc) * I40E_MAX_RING_DESC;
 	ring_size = RTE_ALIGN(ring_size, I40E_DMA_MEM_ALIGN);
 	tz = rte_eth_dma_zone_reserve(dev, "i40e_tx_ring", queue_idx,
 			      ring_size, I40E_RING_BASE_ALIGN, socket_id);
@@ -2640,7 +2640,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
 	txq->tx_ring_dma = tz->iova;
-	txq->i40e_tx_ring = (struct i40e_tx_desc *)tz->addr;
+	txq->i40e_tx_ring = (struct ci_tx_desc *)tz->addr;
 
 	/* Allocate software ring */
 	txq->sw_ring =
@@ -2913,13 +2913,13 @@ i40e_reset_tx_queue(struct ci_tx_queue *txq)
 	}
 
 	txe = txq->sw_ring;
-	size = sizeof(struct i40e_tx_desc) * txq->nb_tx_desc;
+	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->i40e_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		volatile struct i40e_tx_desc *txd = &txq->i40e_tx_ring[i];
+		volatile struct ci_tx_desc *txd = &txq->i40e_tx_ring[i];
 
 		txd->cmd_type_offset_bsz =
 			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE);
@@ -3221,7 +3221,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
 	}
 
 	/* Allocate TX hardware ring descriptors. */
-	ring_size = sizeof(struct i40e_tx_desc) * I40E_FDIR_NUM_TX_DESC;
+	ring_size = sizeof(struct ci_tx_desc) * I40E_FDIR_NUM_TX_DESC;
 	ring_size = RTE_ALIGN(ring_size, I40E_DMA_MEM_ALIGN);
 
 	tz = rte_eth_dma_zone_reserve(dev, "fdir_tx_ring",
@@ -3240,7 +3240,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
 	txq->i40e_vsi = pf->fdir.fdir_vsi;
 
 	txq->tx_ring_dma = tz->iova;
-	txq->i40e_tx_ring = (struct i40e_tx_desc *)tz->addr;
+	txq->i40e_tx_ring = (struct ci_tx_desc *)tz->addr;
 
 	/*
 	 * don't need to allocate software ring and reset for the fdir
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index bbb6d907cf..ef5b252898 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -446,7 +446,7 @@ i40e_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline void
-vtx1(volatile struct i40e_tx_desc *txdp,
+vtx1(volatile struct ci_tx_desc *txdp,
 	struct rte_mbuf *pkt, uint64_t flags)
 {
 	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
@@ -459,7 +459,7 @@ vtx1(volatile struct i40e_tx_desc *txdp,
 }
 
 static inline void
-vtx(volatile struct i40e_tx_desc *txdp,
+vtx(volatile struct ci_tx_desc *txdp,
 	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
 	int i;
@@ -473,7 +473,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct i40e_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = I40E_TD_CMD;
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index 4e398b3140..137c1f9765 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -681,7 +681,7 @@ i40e_recv_scattered_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 
 static inline void
-vtx1(volatile struct i40e_tx_desc *txdp,
+vtx1(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf *pkt, uint64_t flags)
 {
 	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
@@ -694,7 +694,7 @@ vtx1(volatile struct i40e_tx_desc *txdp,
 }
 
 static inline void
-vtx(volatile struct i40e_tx_desc *txdp,
+vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
 	const uint64_t hi_qw_tmpl = (I40E_TX_DESC_DTYPE_DATA |
@@ -739,7 +739,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct i40e_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = I40E_TD_CMD;
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index 571987d27a..6971488750 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -750,7 +750,7 @@ i40e_recv_scattered_pkts_vec_avx512(void *rx_queue,
 }
 
 static inline void
-vtx1(volatile struct i40e_tx_desc *txdp, struct rte_mbuf *pkt, uint64_t flags)
+vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt, uint64_t flags)
 {
 	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
 		((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT) |
@@ -762,7 +762,7 @@ vtx1(volatile struct i40e_tx_desc *txdp, struct rte_mbuf *pkt, uint64_t flags)
 }
 
 static inline void
-vtx(volatile struct i40e_tx_desc *txdp,
+vtx(volatile struct ci_tx_desc *txdp,
 	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
 	const uint64_t hi_qw_tmpl = (I40E_TX_DESC_DTYPE_DATA |
@@ -807,7 +807,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct i40e_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = I40E_TD_CMD;
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index b5be0c1b59..6404b70c56 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -597,7 +597,7 @@ i40e_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static inline void
-vtx1(volatile struct i40e_tx_desc *txdp,
+vtx1(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf *pkt, uint64_t flags)
 {
 	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
@@ -609,7 +609,7 @@ vtx1(volatile struct i40e_tx_desc *txdp,
 }
 
 static inline void
-vtx(volatile struct i40e_tx_desc *txdp, struct rte_mbuf **pkt,
+vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
 		uint16_t nb_pkts,  uint64_t flags)
 {
 	int i;
@@ -623,7 +623,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 	struct rte_mbuf **__rte_restrict tx_pkts, uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct i40e_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = I40E_TD_CMD;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4b763627bc..e4421a9932 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -267,7 +267,7 @@ reset_tx_queue(struct ci_tx_queue *txq)
 	}
 
 	txe = txq->sw_ring;
-	size = sizeof(struct iavf_tx_desc) * txq->nb_tx_desc;
+	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->iavf_tx_ring)[i] = 0;
 
@@ -827,7 +827,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate TX hardware ring descriptors. */
-	ring_size = sizeof(struct iavf_tx_desc) * IAVF_MAX_RING_DESC;
+	ring_size = sizeof(struct ci_tx_desc) * IAVF_MAX_RING_DESC;
 	ring_size = RTE_ALIGN(ring_size, IAVF_DMA_MEM_ALIGN);
 	mz = rte_eth_dma_zone_reserve(dev, "iavf_tx_ring", queue_idx,
 				      ring_size, IAVF_RING_BASE_ALIGN,
@@ -839,7 +839,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 	txq->tx_ring_dma = mz->iova;
-	txq->iavf_tx_ring = (struct iavf_tx_desc *)mz->addr;
+	txq->iavf_tx_ring = (struct ci_tx_desc *)mz->addr;
 
 	txq->mz = mz;
 	reset_tx_queue(txq);
@@ -2333,7 +2333,7 @@ iavf_xmit_cleanup(struct ci_tx_queue *txq)
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
 
-	volatile struct iavf_tx_desc *txd = txq->iavf_tx_ring;
+	volatile struct ci_tx_desc *txd = txq->iavf_tx_ring;
 
 	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
 	if (desc_to_clean_to >= nb_tx_desc)
@@ -2723,7 +2723,7 @@ iavf_calc_pkt_desc(struct rte_mbuf *tx_pkt)
 }
 
 static inline void
-iavf_fill_data_desc(volatile struct iavf_tx_desc *desc,
+iavf_fill_data_desc(volatile struct ci_tx_desc *desc,
 	uint64_t desc_template,	uint16_t buffsz,
 	uint64_t buffer_addr)
 {
@@ -2756,7 +2756,7 @@ uint16_t
 iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = tx_queue;
-	volatile struct iavf_tx_desc *txr = txq->iavf_tx_ring;
+	volatile struct ci_tx_desc *txr = txq->iavf_tx_ring;
 	struct ci_tx_entry *txe_ring = txq->sw_ring;
 	struct ci_tx_entry *txe, *txn;
 	struct rte_mbuf *mb, *mb_seg;
@@ -2774,7 +2774,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	txe = &txe_ring[desc_idx];
 
 	for (idx = 0; idx < nb_pkts; idx++) {
-		volatile struct iavf_tx_desc *ddesc;
+		volatile struct ci_tx_desc *ddesc;
 		struct iavf_ipsec_crypto_pkt_metadata *ipsec_md;
 
 		uint16_t nb_desc_ctx, nb_desc_ipsec;
@@ -2895,7 +2895,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		mb_seg = mb;
 
 		do {
-			ddesc = (volatile struct iavf_tx_desc *)
+			ddesc = (volatile struct ci_tx_desc *)
 					&txr[desc_idx];
 
 			txn = &txe_ring[txe->next_id];
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index e1f78dcde0..dd6d884fc1 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -678,7 +678,7 @@ void iavf_dump_tx_descriptor(const struct ci_tx_queue *txq,
 			    const volatile void *desc, uint16_t tx_id)
 {
 	const char *name;
-	const volatile struct iavf_tx_desc *tx_desc = desc;
+	const volatile struct ci_tx_desc *tx_desc = desc;
 	enum iavf_tx_desc_dtype_value type;
 
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index e29958e0bc..5b62d51cf7 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1630,7 +1630,7 @@ iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload(void *rx_queue,
 
 
 static __rte_always_inline void
-iavf_vtx1(volatile struct iavf_tx_desc *txdp,
+iavf_vtx1(volatile struct ci_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags, bool offload, uint8_t vlan_flag)
 {
 	uint64_t high_qw =
@@ -1646,7 +1646,7 @@ iavf_vtx1(volatile struct iavf_tx_desc *txdp,
 }
 
 static __rte_always_inline void
-iavf_vtx(volatile struct iavf_tx_desc *txdp,
+iavf_vtx(volatile struct ci_tx_desc *txdp,
 	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload, uint8_t vlan_flag)
 {
 	const uint64_t hi_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
@@ -1713,7 +1713,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts, bool offload)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct iavf_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 7c0907b7cf..d79d96c7b7 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1840,7 +1840,7 @@ tx_backlog_entry_avx512(struct ci_tx_entry_vec *txep,
 }
 
 static __rte_always_inline void
-iavf_vtx1(volatile struct iavf_tx_desc *txdp,
+iavf_vtx1(volatile struct ci_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags,
 	  bool offload, uint8_t vlan_flag)
 {
@@ -1859,7 +1859,7 @@ iavf_vtx1(volatile struct iavf_tx_desc *txdp,
 #define IAVF_TX_LEN_MASK 0xAA
 #define IAVF_TX_OFF_MASK 0x55
 static __rte_always_inline void
-iavf_vtx(volatile struct iavf_tx_desc *txdp,
+iavf_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
 		bool offload, uint8_t vlan_flag)
 {
@@ -2068,7 +2068,7 @@ iavf_fill_ctx_desc_tunnelling_field(volatile uint64_t *qw0,
 }
 
 static __rte_always_inline void
-ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
+ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		uint64_t flags, bool offload, uint8_t vlan_flag)
 {
 	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
@@ -2106,7 +2106,7 @@ ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
 }
 
 static __rte_always_inline void
-ctx_vtx(volatile struct iavf_tx_desc *txdp,
+ctx_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
 		bool offload, uint8_t vlan_flag)
 {
@@ -2203,7 +2203,7 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts, bool offload)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct iavf_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
@@ -2271,7 +2271,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts, bool offload)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct iavf_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, nb_mbuf, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 81da5a4656..ab1d499cef 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -399,7 +399,7 @@ reset_tx_queue(struct ci_tx_queue *txq)
 	}
 
 	txe = txq->sw_ring;
-	size = sizeof(struct ice_tx_desc) * txq->nb_tx_desc;
+	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->ice_tx_ring)[i] = 0;
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index f3bc79423d..74b80e7df3 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1115,13 +1115,13 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
 	}
 
 	txe = txq->sw_ring;
-	size = sizeof(struct ice_tx_desc) * txq->nb_tx_desc;
+	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->ice_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		volatile struct ice_tx_desc *txd = &txq->ice_tx_ring[i];
+		volatile struct ci_tx_desc *txd = &txq->ice_tx_ring[i];
 
 		txd->cmd_type_offset_bsz =
 			rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE);
@@ -1623,7 +1623,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate TX hardware ring descriptors. */
-	ring_size = sizeof(struct ice_tx_desc) * ICE_MAX_NUM_DESC_BY_MAC(hw);
+	ring_size = sizeof(struct ci_tx_desc) * ICE_MAX_NUM_DESC_BY_MAC(hw);
 	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
 	tz = rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
 				      ring_size, ICE_RING_BASE_ALIGN,
@@ -2619,7 +2619,7 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
 	}
 
 	/* Allocate TX hardware ring descriptors. */
-	ring_size = sizeof(struct ice_tx_desc) * ICE_FDIR_NUM_TX_DESC;
+	ring_size = sizeof(struct ci_tx_desc) * ICE_FDIR_NUM_TX_DESC;
 	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
 
 	tz = rte_eth_dma_zone_reserve(dev, "fdir_tx_ring",
@@ -2638,7 +2638,7 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
 	txq->ice_vsi = pf->fdir.fdir_vsi;
 
 	txq->tx_ring_dma = tz->iova;
-	txq->ice_tx_ring = (struct ice_tx_desc *)tz->addr;
+	txq->ice_tx_ring = (struct ci_tx_desc *)tz->addr;
 	/*
 	 * don't need to allocate software ring and reset for the fdir
 	 * program queue just set the queue has been configured.
@@ -3027,7 +3027,7 @@ static inline int
 ice_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	volatile struct ice_tx_desc *txd = txq->ice_tx_ring;
+	volatile struct ci_tx_desc *txd = txq->ice_tx_ring;
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
@@ -3148,8 +3148,8 @@ uint16_t
 ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq;
-	volatile struct ice_tx_desc *ice_tx_ring;
-	volatile struct ice_tx_desc *txd;
+	volatile struct ci_tx_desc *ice_tx_ring;
+	volatile struct ci_tx_desc *txd;
 	struct ci_tx_entry *sw_ring;
 	struct ci_tx_entry *txe, *txn;
 	struct rte_mbuf *tx_pkt;
@@ -3312,7 +3312,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) &&
 				unlikely(slen > ICE_MAX_DATA_PER_TXD)) {
-				txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+				txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
 				txd->cmd_type_offset_bsz =
 				rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DATA |
 				((uint64_t)td_cmd << ICE_TXD_QW1_CMD_S) |
@@ -3331,7 +3331,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				txn = &sw_ring[txe->next_id];
 			}
 
-			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
 			txd->cmd_type_offset_bsz =
 				rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DATA |
 				((uint64_t)td_cmd << ICE_TXD_QW1_CMD_S) |
@@ -3563,14 +3563,14 @@ ice_tx_done_cleanup(void *txq, uint32_t free_cnt)
 
 /* Populate 4 descriptors with data from 4 mbufs */
 static inline void
-tx4(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkts)
+tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
 {
 	uint64_t dma_addr;
 	uint32_t i;
 
 	for (i = 0; i < 4; i++, txdp++, pkts++) {
 		dma_addr = rte_mbuf_data_iova(*pkts);
-		txdp->buf_addr = rte_cpu_to_le_64(dma_addr);
+		txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
 		txdp->cmd_type_offset_bsz =
 			ice_build_ctob((uint32_t)ICE_TD_CMD, 0,
 				       (*pkts)->data_len, 0);
@@ -3579,12 +3579,12 @@ tx4(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkts)
 
 /* Populate 1 descriptor with data from 1 mbuf */
 static inline void
-tx1(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkts)
+tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
 {
 	uint64_t dma_addr;
 
 	dma_addr = rte_mbuf_data_iova(*pkts);
-	txdp->buf_addr = rte_cpu_to_le_64(dma_addr);
+	txdp->buffer_addr = rte_cpu_to_le_64(dma_addr);
 	txdp->cmd_type_offset_bsz =
 		ice_build_ctob((uint32_t)ICE_TD_CMD, 0,
 			       (*pkts)->data_len, 0);
@@ -3594,7 +3594,7 @@ static inline void
 ice_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 		    uint16_t nb_pkts)
 {
-	volatile struct ice_tx_desc *txdp = &txq->ice_tx_ring[txq->tx_tail];
+	volatile struct ci_tx_desc *txdp = &txq->ice_tx_ring[txq->tx_tail];
 	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
 	const int N_PER_LOOP = 4;
 	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
@@ -3627,7 +3627,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts)
 {
-	volatile struct ice_tx_desc *txr = txq->ice_tx_ring;
+	volatile struct ci_tx_desc *txr = txq->ice_tx_ring;
 	uint16_t n = 0;
 
 	/**
@@ -4882,7 +4882,7 @@ ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc)
 	struct ci_tx_queue *txq = pf->fdir.txq;
 	struct ci_rx_queue *rxq = pf->fdir.rxq;
 	volatile struct ice_fltr_desc *fdirdp;
-	volatile struct ice_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	uint32_t td_cmd;
 	uint16_t i;
 
@@ -4892,7 +4892,7 @@ ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc)
 	fdirdp->dtype_cmd_vsi_fdid = fdir_desc->dtype_cmd_vsi_fdid;
 
 	txdp = &txq->ice_tx_ring[txq->tx_tail + 1];
-	txdp->buf_addr = rte_cpu_to_le_64(pf->fdir.dma_addr);
+	txdp->buffer_addr = rte_cpu_to_le_64(pf->fdir.dma_addr);
 	td_cmd = ICE_TX_DESC_CMD_EOP |
 		ICE_TX_DESC_CMD_RS  |
 		ICE_TX_DESC_CMD_DUMMY;
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 0ba1d557ca..bef7bb00ba 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -774,7 +774,7 @@ ice_recv_scattered_pkts_vec_avx2_offload(void *rx_queue,
 }
 
 static __rte_always_inline void
-ice_vtx1(volatile struct ice_tx_desc *txdp,
+ice_vtx1(volatile struct ci_tx_desc *txdp,
 	 struct rte_mbuf *pkt, uint64_t flags, bool offload)
 {
 	uint64_t high_qw =
@@ -789,7 +789,7 @@ ice_vtx1(volatile struct ice_tx_desc *txdp,
 }
 
 static __rte_always_inline void
-ice_vtx(volatile struct ice_tx_desc *txdp,
+ice_vtx(volatile struct ci_tx_desc *txdp,
 	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload)
 {
 	const uint64_t hi_qw_tmpl = (ICE_TX_DESC_DTYPE_DATA |
@@ -852,7 +852,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts, bool offload)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ice_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = ICE_TD_CMD;
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 7c6fe82072..1f6bf5fc8e 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -847,7 +847,7 @@ ice_recv_scattered_pkts_vec_avx512_offload(void *rx_queue,
 }
 
 static __rte_always_inline void
-ice_vtx1(volatile struct ice_tx_desc *txdp,
+ice_vtx1(volatile struct ci_tx_desc *txdp,
 	 struct rte_mbuf *pkt, uint64_t flags, bool do_offload)
 {
 	uint64_t high_qw =
@@ -863,7 +863,7 @@ ice_vtx1(volatile struct ice_tx_desc *txdp,
 }
 
 static __rte_always_inline void
-ice_vtx(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkt,
+ice_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
 	uint16_t nb_pkts,  uint64_t flags, bool do_offload)
 {
 	const uint64_t hi_qw_tmpl = (ICE_TX_DESC_DTYPE_DATA |
@@ -916,7 +916,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts, bool do_offload)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ice_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = ICE_TD_CMD;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 797ee515dd..be3c1ef216 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -264,13 +264,13 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 	}
 
 	txe = txq->sw_ring;
-	size = sizeof(struct idpf_base_tx_desc) * txq->nb_tx_desc;
+	size = sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->idpf_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		txq->idpf_tx_ring[i].qw1 =
+		txq->idpf_tx_ring[i].cmd_type_offset_bsz =
 			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
@@ -1335,14 +1335,14 @@ idpf_xmit_cleanup(struct ci_tx_queue *txq)
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
 
-	volatile struct idpf_base_tx_desc *txd = txq->idpf_tx_ring;
+	volatile struct ci_tx_desc *txd = txq->idpf_tx_ring;
 
 	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
 	if (desc_to_clean_to >= nb_tx_desc)
 		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
 
 	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-	if ((txd[desc_to_clean_to].qw1 &
+	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
 	     rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
 	    rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE)) {
 		TX_LOG(DEBUG, "TX descriptor %4u is not done "
@@ -1358,7 +1358,7 @@ idpf_xmit_cleanup(struct ci_tx_queue *txq)
 		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
 					    last_desc_cleaned);
 
-	txd[desc_to_clean_to].qw1 = 0;
+	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
 
 	txq->last_desc_cleaned = desc_to_clean_to;
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
@@ -1372,8 +1372,8 @@ uint16_t
 idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
 {
-	volatile struct idpf_base_tx_desc *txd;
-	volatile struct idpf_base_tx_desc *txr;
+	volatile struct ci_tx_desc *txd;
+	volatile struct ci_tx_desc *txr;
 	union idpf_tx_offload tx_offload = {0};
 	struct ci_tx_entry *txe, *txn;
 	struct ci_tx_entry *sw_ring;
@@ -1491,8 +1491,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			/* Setup TX Descriptor */
 			slen = m_seg->data_len;
 			buf_dma_addr = rte_mbuf_data_iova(m_seg);
-			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
-			txd->qw1 = rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DATA |
+			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
+			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DATA |
 				((uint64_t)td_cmd  << IDPF_TXD_QW1_CMD_S) |
 				((uint64_t)td_offset << IDPF_TXD_QW1_OFFSET_S) |
 				((uint64_t)slen << IDPF_TXD_QW1_TX_BUF_SZ_S));
@@ -1519,7 +1519,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			txq->nb_tx_used = 0;
 		}
 
-		txd->qw1 |= rte_cpu_to_le_16(td_cmd << IDPF_TXD_QW1_CMD_S);
+		txd->cmd_type_offset_bsz |= rte_cpu_to_le_16(td_cmd << IDPF_TXD_QW1_CMD_S);
 	}
 
 end_of_tx:
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 7c6ff5d047..2f2fa153b2 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -182,7 +182,7 @@ union idpf_tx_offload {
 };
 
 union idpf_tx_desc {
-	struct idpf_base_tx_desc *tx_ring;
+	struct ci_tx_desc *tx_ring;
 	struct idpf_flex_tx_sched_desc *desc_ring;
 	struct idpf_splitq_tx_compl_desc *compl_ring;
 };
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 21c8f79254..5f5d538dcb 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -483,7 +483,7 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
 }
 
 static inline void
-idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
+idpf_singleq_vtx1(volatile struct ci_tx_desc *txdp,
 		  struct rte_mbuf *pkt, uint64_t flags)
 {
 	uint64_t high_qw =
@@ -497,7 +497,7 @@ idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
 }
 
 static inline void
-idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
+idpf_singleq_vtx(volatile struct ci_tx_desc *txdp,
 		 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
 	const uint64_t hi_qw_tmpl = (IDPF_TX_DESC_DTYPE_DATA |
@@ -556,7 +556,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 				       uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct idpf_base_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
@@ -604,7 +604,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->idpf_tx_ring[txq->tx_next_rs].qw1 |=
+		txq->idpf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
 					 IDPF_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index bc2cadd738..c1ec3d1222 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1000,7 +1000,7 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 }
 
 static __rte_always_inline void
-idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
+idpf_singleq_vtx1(volatile struct ci_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags)
 {
 	uint64_t high_qw =
@@ -1016,7 +1016,7 @@ idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
 #define IDPF_TX_LEN_MASK 0xAA
 #define IDPF_TX_OFF_MASK 0x55
 static __rte_always_inline void
-idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
+idpf_singleq_vtx(volatile struct ci_tx_desc *txdp,
 	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
 	const uint64_t hi_qw_tmpl = (IDPF_TX_DESC_DTYPE_DATA  |
@@ -1072,7 +1072,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 					 uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = tx_queue;
-	volatile struct idpf_base_tx_desc *txdp;
+	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
@@ -1123,7 +1123,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
-		txq->idpf_tx_ring[txq->tx_next_rs].qw1 |=
+		txq->idpf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
 					 IDPF_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index cee454244f..8aa44585fe 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -72,7 +72,7 @@ idpf_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 			ring_size = RTE_ALIGN(len * sizeof(struct idpf_flex_tx_sched_desc),
 					      IDPF_DMA_MEM_ALIGN);
 		else
-			ring_size = RTE_ALIGN(len * sizeof(struct idpf_base_tx_desc),
+			ring_size = RTE_ALIGN(len * sizeof(struct ci_tx_desc),
 					      IDPF_DMA_MEM_ALIGN);
 		rte_memcpy(ring_name, "idpf Tx ring", sizeof("idpf Tx ring"));
 		break;
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index 425f0792a1..4702061484 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -31,7 +31,7 @@ idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 	if (txq->complq != NULL)
 		return 1;
 
-	return (txq->idpf_tx_ring[idx].qw1 &
+	return (txq->idpf_tx_ring[idx].cmd_type_offset_bsz &
 			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
 				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
 }
-- 
2.51.0

