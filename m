Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350A9C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:14:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 263D740F16;
	Thu, 12 Jun 2025 13:12:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8E578427E8
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726756; x=1781262756;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=sNVq4A2Yz0u67uHy1NmYD2yCjmBj/rRAVFpxJV/8q2I=;
 b=P8aNwaI/2eWtjf5QCCg/kaJJ5nFUSoN+77WZljRWCEM7OSnuKKYFIO4A
 k9oMdsQvuw+iJGJ1hF0Cx8rIZBBTazjihfA3A7duCXzmKFB+drNqMxMYK
 B0U4YtKx6ew7IRzYjEoneIJFa9mjzTph7JOo3+cxxFVg5ol+X77J4KEC8
 fOtREVs93c34jSflj11B1S7VSpbD3YhtA09KJVxBKjvMkcddnjG5GhjNQ
 FgQ1irzHZSYakvI+cqq4mBErPXXkuJqiQxbUATBUIDXFpt5a2rRsUtdAl
 Z/9ekRG/ZB/YGYjc+GzFtiU47zAcT24YOLY0QgE5a3U+NBUsqi0tN5tZN g==;
X-CSE-ConnectionGUID: iz30wH6hSdGDDELeWLmvTw==
X-CSE-MsgGUID: kLCgU0esQqq4oDPLmClBjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177590"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177590"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:36 -0700
X-CSE-ConnectionGUID: JxS67fHCQEq0SXbwKvj//w==
X-CSE-MsgGUID: JqDSvSlsRT+TFm2WtqU1Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371386"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v7 24/33] net/i40e: use the common Rx queue structure
Date: Thu, 12 Jun 2025 12:11:30 +0100
Message-ID: <ca9c3945b8651578c0f8e78d869377c965bc35d7.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
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

Make the i40e driver use the new common Rx queue structure.

The i40e driver supports 16-byte and 32-byte Rx descriptor formats, which
is shared by other drivers. To have fewer driver-specific definitions in
common structures, add a header file defining shared descriptor formats,
and switch between 16-byte and 32-byte formats by way of the existing
RTE_NET_INTEL_USE_16BYTE_DESC define.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Fix compilation issues for AltiVec

 drivers/net/intel/common/desc.h               |  89 ++++++++++++
 drivers/net/intel/common/rx.h                 |  15 ++
 drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   4 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  16 +--
 .../i40e/i40e_recycle_mbufs_vec_common.c      |   6 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 134 +++++++++---------
 drivers/net/intel/i40e/i40e_rxtx.h            |  74 ++--------
 drivers/net/intel/i40e/i40e_rxtx_common_avx.h |   6 +-
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  20 +--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  14 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  14 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  24 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  24 ++--
 15 files changed, 248 insertions(+), 200 deletions(-)
 create mode 100644 drivers/net/intel/common/desc.h

diff --git a/drivers/net/intel/common/desc.h b/drivers/net/intel/common/desc.h
new file mode 100644
index 0000000000..f9e7f27991
--- /dev/null
+++ b/drivers/net/intel/common/desc.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+ #ifndef _COMMON_INTEL_DESC_H_
+ #define _COMMON_INTEL_DESC_H_
+
+#include <rte_byteorder.h>
+
+/* HW desc structures, both 16-byte and 32-byte types are supported */
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
+union ci_rx_desc {
+	struct {
+		rte_le64_t pkt_addr; /* Packet buffer address */
+		rte_le64_t hdr_addr; /* Header buffer address */
+	} read;
+	struct {
+		struct {
+			struct {
+				union {
+					rte_le16_t mirroring_status;
+					rte_le16_t fcoe_ctx_id;
+				} mirr_fcoe;
+				rte_le16_t l2tag1;
+			} lo_dword;
+			union {
+				rte_le32_t rss; /* RSS Hash */
+				rte_le32_t fd_id; /* Flow director filter id */
+				rte_le32_t fcoe_param; /* FCoE DDP Context id */
+			} hi_dword;
+		} qword0;
+		struct {
+			/* ext status/error/pktype/length */
+			rte_le64_t status_error_len;
+		} qword1;
+	} wb;  /* writeback */
+};
+#else
+union ci_rx_desc {
+	struct {
+		rte_le64_t  pkt_addr; /* Packet buffer address */
+		rte_le64_t  hdr_addr; /* Header buffer address */
+			/* bit 0 of hdr_buffer_addr is DD bit */
+		rte_le64_t  rsvd1;
+		rte_le64_t  rsvd2;
+	} read;
+	struct {
+		struct {
+			struct {
+				union {
+					rte_le16_t mirroring_status;
+					rte_le16_t fcoe_ctx_id;
+				} mirr_fcoe;
+				rte_le16_t l2tag1;
+			} lo_dword;
+			union {
+				rte_le32_t rss; /* RSS Hash */
+				rte_le32_t fcoe_param; /* FCoE DDP Context id */
+				/* Flow director filter id in case of
+				 * Programming status desc WB
+				 */
+				rte_le32_t fd_id;
+			} hi_dword;
+		} qword0;
+		struct {
+			/* status/error/pktype/length */
+			rte_le64_t status_error_len;
+		} qword1;
+		struct {
+			rte_le16_t ext_status; /* extended status */
+			rte_le16_t rsvd;
+			rte_le16_t l2tag2_1;
+			rte_le16_t l2tag2_2;
+		} qword2;
+		struct {
+			union {
+				rte_le32_t flex_bytes_lo;
+				rte_le32_t pe_status;
+			} lo_dword;
+			union {
+				rte_le32_t flex_bytes_hi;
+				rte_le32_t fd_id;
+			} hi_dword;
+		} qword3;
+	} wb;  /* writeback */
+};
+#endif
+
+#endif /* _COMMON_INTEL_DESC_H_ */
diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index b60ca24dfb..98e85406cf 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -10,6 +10,8 @@
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 
+#include "desc.h"
+
 #define CI_RX_MAX_BURST 32
 
 struct ci_rx_queue;
@@ -29,6 +31,7 @@ struct ci_rx_queue {
 	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
 	union { /* RX ring virtual address */
 		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
+		volatile union ci_rx_desc *rx_ring;
 	};
 	volatile uint8_t *qrx_tail;   /**< register address of tail */
 	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
@@ -50,14 +53,22 @@ struct ci_rx_queue {
 	uint16_t queue_id; /**< RX queue index. */
 	uint16_t port_id;  /**< Device port identifier. */
 	uint16_t reg_idx;  /**< RX queue register index. */
+	uint16_t rx_buf_len; /* The packet buffer size */
+	uint16_t rx_hdr_len; /* The header buffer size */
+	uint16_t max_pkt_len; /* Maximum packet length */
 	uint8_t crc_len;  /**< 0 if CRC stripped, 4 otherwise. */
+	bool q_set; /**< indicate if rx queue has been configured */
 	bool rx_deferred_start; /**< queue is not started on dev start. */
+	bool fdir_enabled; /* 0 if FDIR disabled, 1 when enabled */
 	bool vector_rx; /**< indicates that vector RX is in use */
 	bool drop_en;  /**< if 1, drop packets if no descriptors are available. */
 	uint64_t mbuf_initializer; /**< value to init mbufs */
 	uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
 	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
 	struct rte_mbuf fake_mbuf;
+	union { /* the VSI this queue belongs to */
+		struct i40e_vsi *i40e_vsi;
+	};
 	const struct rte_memzone *mz;
 	union {
 		struct { /* ixgbe specific values */
@@ -70,6 +81,10 @@ struct ci_rx_queue {
 			/** UDP frames with a 0 checksum can be marked as checksum errors. */
 			uint8_t rx_udp_csum_zero_err;
 		};
+		struct { /* i40e specific values */
+			uint8_t hs_mode; /**< Header Split mode */
+			uint8_t dcb_tc; /**< Traffic class of rx queue */
+		};
 	};
 };
 
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 90eba3419f..e0a865845b 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -6609,7 +6609,7 @@ i40e_dev_rx_init(struct i40e_pf *pf)
 	struct rte_eth_dev_data *data = pf->dev_data;
 	int ret = I40E_SUCCESS;
 	uint16_t i;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	i40e_pf_config_rss(pf);
 	for (i = 0; i < data->nb_rx_queues; i++) {
@@ -8974,7 +8974,7 @@ i40e_pf_calc_configured_queues_num(struct i40e_pf *pf)
 {
 	struct rte_eth_dev_data *data = pf->dev_data;
 	int i, num;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	num = 0;
 	for (i = 0; i < pf->lan_nb_qps; i++) {
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index ccc8732d7d..44864292d0 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -333,7 +333,7 @@ struct i40e_vsi_list {
 	struct i40e_vsi *vsi;
 };
 
-struct i40e_rx_queue;
+struct ci_rx_queue;
 struct ci_tx_queue;
 
 /* Bandwidth limit information */
@@ -739,7 +739,7 @@ struct i40e_fdir_info {
 	struct i40e_vsi *fdir_vsi;     /* pointer to fdir VSI structure */
 	uint16_t match_counter_index;  /* Statistic counter index used for fdir*/
 	struct ci_tx_queue *txq;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	void *prg_pkt[I40E_FDIR_PRG_PKT_CNT];     /* memory for fdir program packet */
 	uint64_t dma_addr[I40E_FDIR_PRG_PKT_CNT]; /* physic address of packet memory*/
 	/*
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 734218b67d..a891819f47 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -100,9 +100,9 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 				  bool add, bool wait_status);
 
 static int
-i40e_fdir_rx_queue_init(struct i40e_rx_queue *rxq)
+i40e_fdir_rx_queue_init(struct ci_rx_queue *rxq)
 {
-	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->vsi);
+	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->i40e_vsi);
 	struct i40e_hmc_obj_rxq rx_ctx;
 	int err = I40E_SUCCESS;
 
@@ -139,7 +139,7 @@ i40e_fdir_rx_queue_init(struct i40e_rx_queue *rxq)
 		return err;
 	}
 	rxq->qrx_tail = hw->hw_addr +
-		I40E_QRX_TAIL(rxq->vsi->base_queue);
+		I40E_QRX_TAIL(rxq->i40e_vsi->base_queue);
 
 	rte_wmb();
 	/* Init the RX tail register. */
@@ -382,7 +382,7 @@ i40e_fdir_rx_proc_enable(struct rte_eth_dev *dev, bool on)
 	int32_t i;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct i40e_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
 		rxq->fdir_enabled = on;
@@ -929,9 +929,9 @@ i40e_build_ctob(uint32_t td_cmd,
  * tx queue
  */
 static inline int
-i40e_check_fdir_programming_status(struct i40e_rx_queue *rxq)
+i40e_check_fdir_programming_status(struct ci_rx_queue *rxq)
 {
-	volatile union i40e_rx_desc *rxdp;
+	volatile union ci_rx_desc *rxdp;
 	uint64_t qword1;
 	uint32_t rx_status;
 	uint32_t len, id;
@@ -987,7 +987,7 @@ i40e_check_fdir_programming_status(struct i40e_rx_queue *rxq)
 }
 
 static inline void
-i40e_fdir_programming_status_cleanup(struct i40e_rx_queue *rxq)
+i40e_fdir_programming_status_cleanup(struct ci_rx_queue *rxq)
 {
 	uint16_t retry_count = 0;
 
@@ -1627,7 +1627,7 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 				  bool add, bool wait_status)
 {
 	struct ci_tx_queue *txq = pf->fdir.txq;
-	struct i40e_rx_queue *rxq = pf->fdir.rxq;
+	struct ci_rx_queue *rxq = pf->fdir.rxq;
 	const struct i40e_fdir_action *fdir_action = &filter->action;
 	volatile struct i40e_tx_desc *txdp;
 	volatile struct i40e_filter_program_desc *fdirdp;
diff --git a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
index 2875c578af..20d9fd7b22 100644
--- a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
@@ -13,9 +13,9 @@
 void
 i40e_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
-	struct i40e_rx_entry *rxep;
-	volatile union i40e_rx_desc *rxdp;
+	struct ci_rx_queue *rxq = rx_queue;
+	struct ci_rx_entry *rxep;
+	volatile union ci_rx_desc *rxdp;
 	uint16_t rx_id;
 	uint64_t paddr;
 	uint64_t dma_addr;
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2e61076378..0b06130fe5 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -94,8 +94,8 @@ i40e_monitor_callback(const uint64_t value,
 int
 i40e_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
-	volatile union i40e_rx_desc *rxdp;
+	struct ci_rx_queue *rxq = rx_queue;
+	volatile union ci_rx_desc *rxdp;
 	uint16_t desc;
 
 	desc = rxq->rx_tail;
@@ -113,7 +113,7 @@ i40e_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 }
 
 static inline void
-i40e_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union i40e_rx_desc *rxdp)
+i40e_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union ci_rx_desc *rxdp)
 {
 	if (rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len) &
 		(1 << I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) {
@@ -214,7 +214,7 @@ i40e_get_iee15888_flags(struct rte_mbuf *mb, uint64_t qword)
 #endif
 
 static inline uint64_t
-i40e_rxd_build_fdir(volatile union i40e_rx_desc *rxdp, struct rte_mbuf *mb)
+i40e_rxd_build_fdir(volatile union ci_rx_desc *rxdp, struct rte_mbuf *mb)
 {
 	uint64_t flags = 0;
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
@@ -416,9 +416,9 @@ i40e_xmit_cleanup(struct ci_tx_queue *txq)
 
 static inline int
 #ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
-check_rx_burst_bulk_alloc_preconditions(struct i40e_rx_queue *rxq)
+check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
 #else
-check_rx_burst_bulk_alloc_preconditions(__rte_unused struct i40e_rx_queue *rxq)
+check_rx_burst_bulk_alloc_preconditions(__rte_unused struct ci_rx_queue *rxq)
 #endif
 {
 	int ret = 0;
@@ -456,10 +456,10 @@ check_rx_burst_bulk_alloc_preconditions(__rte_unused struct i40e_rx_queue *rxq)
 #error "PMD I40E: I40E_LOOK_AHEAD must be 8\n"
 #endif
 static inline int
-i40e_rx_scan_hw_ring(struct i40e_rx_queue *rxq)
+i40e_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 {
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t pkt_len;
 	uint64_t qword1;
@@ -467,7 +467,7 @@ i40e_rx_scan_hw_ring(struct i40e_rx_queue *rxq)
 	int32_t s[I40E_LOOK_AHEAD], var, nb_dd;
 	int32_t i, j, nb_rx = 0;
 	uint64_t pkt_flags;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	rxdp = &rxq->rx_ring[rxq->rx_tail];
 	rxep = &rxq->sw_ring[rxq->rx_tail];
@@ -558,7 +558,7 @@ i40e_rx_scan_hw_ring(struct i40e_rx_queue *rxq)
 }
 
 static inline uint16_t
-i40e_rx_fill_from_stage(struct i40e_rx_queue *rxq,
+i40e_rx_fill_from_stage(struct ci_rx_queue *rxq,
 			struct rte_mbuf **rx_pkts,
 			uint16_t nb_pkts)
 {
@@ -577,10 +577,10 @@ i40e_rx_fill_from_stage(struct i40e_rx_queue *rxq,
 }
 
 static inline int
-i40e_rx_alloc_bufs(struct i40e_rx_queue *rxq)
+i40e_rx_alloc_bufs(struct ci_rx_queue *rxq)
 {
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t alloc_idx, i;
 	uint64_t dma_addr;
@@ -629,7 +629,7 @@ i40e_rx_alloc_bufs(struct i40e_rx_queue *rxq)
 static inline uint16_t
 rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = (struct i40e_rx_queue *)rx_queue;
+	struct ci_rx_queue *rxq = (struct ci_rx_queue *)rx_queue;
 	struct rte_eth_dev *dev;
 	uint16_t nb_rx = 0;
 
@@ -648,7 +648,7 @@ rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		if (i40e_rx_alloc_bufs(rxq) != 0) {
 			uint16_t i, j;
 
-			dev = I40E_VSI_TO_ETH_DEV(rxq->vsi);
+			dev = I40E_VSI_TO_ETH_DEV(rxq->i40e_vsi);
 			dev->data->rx_mbuf_alloc_failed +=
 				rxq->rx_free_thresh;
 
@@ -707,12 +707,12 @@ i40e_recv_pkts_bulk_alloc(void __rte_unused *rx_queue,
 uint16_t
 i40e_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq;
-	volatile union i40e_rx_desc *rx_ring;
-	volatile union i40e_rx_desc *rxdp;
-	union i40e_rx_desc rxd;
-	struct i40e_rx_entry *sw_ring;
-	struct i40e_rx_entry *rxe;
+	struct ci_rx_queue *rxq;
+	volatile union ci_rx_desc *rx_ring;
+	volatile union ci_rx_desc *rxdp;
+	union ci_rx_desc rxd;
+	struct ci_rx_entry *sw_ring;
+	struct ci_rx_entry *rxe;
 	struct rte_eth_dev *dev;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
@@ -731,7 +731,7 @@ i40e_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	rx_id = rxq->rx_tail;
 	rx_ring = rxq->rx_ring;
 	sw_ring = rxq->sw_ring;
-	ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -745,7 +745,7 @@ i40e_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 		nmb = rte_mbuf_raw_alloc(rxq->mp);
 		if (unlikely(!nmb)) {
-			dev = I40E_VSI_TO_ETH_DEV(rxq->vsi);
+			dev = I40E_VSI_TO_ETH_DEV(rxq->i40e_vsi);
 			dev->data->rx_mbuf_alloc_failed++;
 			break;
 		}
@@ -837,12 +837,12 @@ i40e_recv_scattered_pkts(void *rx_queue,
 			 struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
-	volatile union i40e_rx_desc *rx_ring = rxq->rx_ring;
-	volatile union i40e_rx_desc *rxdp;
-	union i40e_rx_desc rxd;
-	struct i40e_rx_entry *sw_ring = rxq->sw_ring;
-	struct i40e_rx_entry *rxe;
+	struct ci_rx_queue *rxq = rx_queue;
+	volatile union ci_rx_desc *rx_ring = rxq->rx_ring;
+	volatile union ci_rx_desc *rxdp;
+	union ci_rx_desc rxd;
+	struct ci_rx_entry *sw_ring = rxq->sw_ring;
+	struct ci_rx_entry *rxe;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *nmb, *rxm;
@@ -853,7 +853,7 @@ i40e_recv_scattered_pkts(void *rx_queue,
 	uint64_t qword1;
 	uint64_t dma_addr;
 	uint64_t pkt_flags;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -867,7 +867,7 @@ i40e_recv_scattered_pkts(void *rx_queue,
 
 		nmb = rte_mbuf_raw_alloc(rxq->mp);
 		if (unlikely(!nmb)) {
-			dev = I40E_VSI_TO_ETH_DEV(rxq->vsi);
+			dev = I40E_VSI_TO_ETH_DEV(rxq->i40e_vsi);
 			dev->data->rx_mbuf_alloc_failed++;
 			break;
 		}
@@ -1798,7 +1798,7 @@ i40e_get_queue_offset_by_qindex(struct i40e_pf *pf, uint16_t queue_idx)
 int
 i40e_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
@@ -1841,7 +1841,7 @@ i40e_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 int
 i40e_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
@@ -2004,7 +2004,7 @@ i40e_dev_first_queue(uint16_t idx, void **queues, int num)
 
 static int
 i40e_dev_rx_queue_setup_runtime(struct rte_eth_dev *dev,
-				struct i40e_rx_queue *rxq)
+				struct ci_rx_queue *rxq)
 {
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
@@ -2081,7 +2081,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct i40e_vsi *vsi;
 	struct i40e_pf *pf = NULL;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	const struct rte_memzone *rz;
 	uint32_t ring_size;
 	uint16_t len, i;
@@ -2116,7 +2116,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate the rx queue data structure */
 	rxq = rte_zmalloc_socket("i40e rx queue",
-				 sizeof(struct i40e_rx_queue),
+				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
 				 socket_id);
 	if (!rxq) {
@@ -2135,7 +2135,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	else
 		rxq->crc_len = 0;
 	rxq->drop_en = rx_conf->rx_drop_en;
-	rxq->vsi = vsi;
+	rxq->i40e_vsi = vsi;
 	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
 	rxq->offloads = offloads;
 
@@ -2148,7 +2148,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	len += I40E_RX_MAX_BURST;
 
-	ring_size = RTE_ALIGN(len * sizeof(union i40e_rx_desc),
+	ring_size = RTE_ALIGN(len * sizeof(union ci_rx_desc),
 			      I40E_DMA_MEM_ALIGN);
 
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
@@ -2164,14 +2164,14 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	memset(rz->addr, 0, ring_size);
 
 	rxq->rx_ring_phys_addr = rz->iova;
-	rxq->rx_ring = (union i40e_rx_desc *)rz->addr;
+	rxq->rx_ring = (union ci_rx_desc *)rz->addr;
 
 	len = (uint16_t)(nb_desc + I40E_RX_MAX_BURST);
 
 	/* Allocate the software ring. */
 	rxq->sw_ring =
 		rte_zmalloc_socket("i40e rx sw ring",
-				   sizeof(struct i40e_rx_entry) * len,
+				   sizeof(struct ci_rx_entry) * len,
 				   RTE_CACHE_LINE_SIZE,
 				   socket_id);
 	if (!rxq->sw_ring) {
@@ -2242,7 +2242,7 @@ i40e_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 void
 i40e_rx_queue_release(void *rxq)
 {
-	struct i40e_rx_queue *q = (struct i40e_rx_queue *)rxq;
+	struct ci_rx_queue *q = (struct ci_rx_queue *)rxq;
 
 	if (!q) {
 		PMD_DRV_LOG(DEBUG, "Pointer to rxq is NULL");
@@ -2259,8 +2259,8 @@ uint32_t
 i40e_dev_rx_queue_count(void *rx_queue)
 {
 #define I40E_RXQ_SCAN_INTERVAL 4
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_queue *rxq;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_queue *rxq;
 	uint16_t desc = 0;
 
 	rxq = rx_queue;
@@ -2287,7 +2287,7 @@ i40e_dev_rx_queue_count(void *rx_queue)
 int
 i40e_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	volatile uint64_t *status;
 	uint64_t mask;
 	uint32_t desc;
@@ -2628,7 +2628,7 @@ i40e_memzone_reserve(const char *name, uint32_t len, int socket_id)
 }
 
 void
-i40e_rx_queue_release_mbufs(struct i40e_rx_queue *rxq)
+i40e_rx_queue_release_mbufs(struct ci_rx_queue *rxq)
 {
 	uint16_t i;
 
@@ -2663,7 +2663,7 @@ i40e_rx_queue_release_mbufs(struct i40e_rx_queue *rxq)
 }
 
 void
-i40e_reset_rx_queue(struct i40e_rx_queue *rxq)
+i40e_reset_rx_queue(struct ci_rx_queue *rxq)
 {
 	unsigned i;
 	uint16_t len;
@@ -2680,7 +2680,7 @@ i40e_reset_rx_queue(struct i40e_rx_queue *rxq)
 #endif /* RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC */
 		len = rxq->nb_rx_desc;
 
-	for (i = 0; i < len * sizeof(union i40e_rx_desc); i++)
+	for (i = 0; i < len * sizeof(union ci_rx_desc); i++)
 		((volatile char *)rxq->rx_ring)[i] = 0;
 
 	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
@@ -2898,14 +2898,14 @@ i40e_tx_queue_init(struct ci_tx_queue *txq)
 }
 
 int
-i40e_alloc_rx_queue_mbufs(struct i40e_rx_queue *rxq)
+i40e_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq)
 {
-	struct i40e_rx_entry *rxe = rxq->sw_ring;
+	struct ci_rx_entry *rxe = rxq->sw_ring;
 	uint64_t dma_addr;
 	uint16_t i;
 
 	for (i = 0; i < rxq->nb_rx_desc; i++) {
-		volatile union i40e_rx_desc *rxd;
+		volatile union ci_rx_desc *rxd;
 		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mp);
 
 		if (unlikely(!mbuf)) {
@@ -2941,10 +2941,10 @@ i40e_alloc_rx_queue_mbufs(struct i40e_rx_queue *rxq)
  * and maximum packet length.
  */
 static int
-i40e_rx_queue_config(struct i40e_rx_queue *rxq)
+i40e_rx_queue_config(struct ci_rx_queue *rxq)
 {
-	struct i40e_pf *pf = I40E_VSI_TO_PF(rxq->vsi);
-	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->vsi);
+	struct i40e_pf *pf = I40E_VSI_TO_PF(rxq->i40e_vsi);
+	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->i40e_vsi);
 	struct rte_eth_dev_data *data = pf->dev_data;
 	uint16_t buf_size;
 
@@ -2988,11 +2988,11 @@ i40e_rx_queue_config(struct i40e_rx_queue *rxq)
 
 /* Init the RX queue in hardware */
 int
-i40e_rx_queue_init(struct i40e_rx_queue *rxq)
+i40e_rx_queue_init(struct ci_rx_queue *rxq)
 {
 	int err = I40E_SUCCESS;
-	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->vsi);
-	struct rte_eth_dev_data *dev_data = I40E_VSI_TO_DEV_DATA(rxq->vsi);
+	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->i40e_vsi);
+	struct rte_eth_dev_data *dev_data = I40E_VSI_TO_DEV_DATA(rxq->i40e_vsi);
 	uint16_t pf_q = rxq->reg_idx;
 	uint16_t buf_size;
 	struct i40e_hmc_obj_rxq rx_ctx;
@@ -3166,7 +3166,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
 enum i40e_status_code
 i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	const struct rte_memzone *rz = NULL;
 	uint32_t ring_size;
 	struct rte_eth_dev *dev;
@@ -3180,7 +3180,7 @@ i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 
 	/* Allocate the RX queue data structure. */
 	rxq = rte_zmalloc_socket("i40e fdir rx queue",
-				  sizeof(struct i40e_rx_queue),
+				  sizeof(struct ci_rx_queue),
 				  RTE_CACHE_LINE_SIZE,
 				  SOCKET_ID_ANY);
 	if (!rxq) {
@@ -3190,7 +3190,7 @@ i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 	}
 
 	/* Allocate RX hardware ring descriptors. */
-	ring_size = sizeof(union i40e_rx_desc) * I40E_FDIR_NUM_RX_DESC;
+	ring_size = sizeof(union ci_rx_desc) * I40E_FDIR_NUM_RX_DESC;
 	ring_size = RTE_ALIGN(ring_size, I40E_DMA_MEM_ALIGN);
 
 	rz = rte_eth_dma_zone_reserve(dev, "fdir_rx_ring",
@@ -3206,11 +3206,11 @@ i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 	rxq->nb_rx_desc = I40E_FDIR_NUM_RX_DESC;
 	rxq->queue_id = I40E_FDIR_QUEUE_ID;
 	rxq->reg_idx = pf->fdir.fdir_vsi->base_queue;
-	rxq->vsi = pf->fdir.fdir_vsi;
+	rxq->i40e_vsi = pf->fdir.fdir_vsi;
 
 	rxq->rx_ring_phys_addr = rz->iova;
-	memset(rz->addr, 0, I40E_FDIR_NUM_RX_DESC * sizeof(union i40e_rx_desc));
-	rxq->rx_ring = (union i40e_rx_desc *)rz->addr;
+	memset(rz->addr, 0, I40E_FDIR_NUM_RX_DESC * sizeof(union ci_rx_desc));
+	rxq->rx_ring = (union ci_rx_desc *)rz->addr;
 
 	/*
 	 * Don't need to allocate software ring and reset for the fdir
@@ -3226,7 +3226,7 @@ void
 i40e_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_rxq_info *qinfo)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	rxq = dev->data->rx_queues[queue_id];
 
@@ -3264,7 +3264,7 @@ void
 i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 
@@ -3335,7 +3335,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 		}
 		if (ad->rx_vec_allowed) {
 			for (i = 0; i < dev->data->nb_rx_queues; i++) {
-				struct i40e_rx_queue *rxq =
+				struct ci_rx_queue *rxq =
 					dev->data->rx_queues[i];
 
 				if (rxq && i40e_rxq_vec_setup(rxq)) {
@@ -3438,7 +3438,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 			 dev->rx_pkt_burst == i40e_recv_pkts_vec_avx2);
 
 		for (i = 0; i < dev->data->nb_rx_queues; i++) {
-			struct i40e_rx_queue *rxq = dev->data->rx_queues[i];
+			struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 
 			if (rxq)
 				rxq->vector_rx = vector_rx;
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 3dca32b1ba..05c41d473e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -6,8 +6,9 @@
 #define _I40E_RXTX_H_
 
 #include "../common/tx.h"
+#include "../common/rx.h"
 
-#define I40E_RX_MAX_BURST 32
+#define I40E_RX_MAX_BURST CI_RX_MAX_BURST
 #define I40E_TX_MAX_BURST 32
 
 #define I40E_VPMD_RX_BURST            32
@@ -66,63 +67,6 @@ enum i40e_header_split_mode {
 			       I40E_HEADER_SPLIT_UDP_TCP | \
 			       I40E_HEADER_SPLIT_SCTP)
 
-/* HW desc structure, both 16-byte and 32-byte types are supported */
-#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
-#define i40e_rx_desc i40e_16byte_rx_desc
-#else
-#define i40e_rx_desc i40e_32byte_rx_desc
-#endif
-
-struct i40e_rx_entry {
-	struct rte_mbuf *mbuf;
-};
-
-/*
- * Structure associated with each RX queue.
- */
-struct i40e_rx_queue {
-	struct rte_mempool *mp; /**< mbuf pool to populate RX ring */
-	volatile union i40e_rx_desc *rx_ring;/**< RX ring virtual address */
-	uint64_t rx_ring_phys_addr; /**< RX ring DMA address */
-	struct i40e_rx_entry *sw_ring; /**< address of RX soft ring */
-	uint16_t nb_rx_desc; /**< number of RX descriptors */
-	uint16_t rx_free_thresh; /**< max free RX desc to hold */
-	uint16_t rx_tail; /**< current value of tail */
-	uint16_t nb_rx_hold; /**< number of held free RX desc */
-	struct rte_mbuf *pkt_first_seg; /**< first segment of current packet */
-	struct rte_mbuf *pkt_last_seg; /**< last segment of current packet */
-	struct rte_mbuf fake_mbuf; /**< dummy mbuf */
-#ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
-	uint16_t rx_nb_avail; /**< number of staged packets ready */
-	uint16_t rx_next_avail; /**< index of next staged packets */
-	uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
-	struct rte_mbuf *rx_stage[I40E_RX_MAX_BURST * 2];
-#endif
-
-	uint16_t rxrearm_nb;	/**< number of remaining to be re-armed */
-	uint16_t rxrearm_start;	/**< the idx we start the re-arming from */
-	uint64_t mbuf_initializer; /**< value to init mbufs */
-
-	uint16_t port_id; /**< device port ID */
-	uint8_t crc_len; /**< 0 if CRC stripped, 4 otherwise */
-	uint8_t fdir_enabled; /**< 0 if FDIR disabled, 1 when enabled */
-	uint16_t queue_id; /**< RX queue index */
-	uint16_t reg_idx; /**< RX queue register index */
-	uint8_t drop_en; /**< if not 0, set register bit */
-	volatile uint8_t *qrx_tail; /**< register address of tail */
-	struct i40e_vsi *vsi; /**< the VSI this queue belongs to */
-	uint16_t rx_buf_len; /* The packet buffer size */
-	uint16_t rx_hdr_len; /* The header buffer size */
-	uint16_t max_pkt_len; /* Maximum packet length */
-	uint8_t hs_mode; /* Header Split mode */
-	bool q_set; /**< indicate if rx queue has been configured */
-	bool rx_deferred_start; /**< don't start this queue in dev start */
-	uint16_t vector_rx; /**<flag indicate the usage of vPMD for rx */
-	uint8_t dcb_tc;         /**< Traffic class of rx queue */
-	uint64_t offloads; /**< Rx offload flags of RTE_ETH_RX_OFFLOAD_* */
-	const struct rte_memzone *mz;
-};
-
 /** Offload features */
 union i40e_tx_offload {
 	uint64_t data;
@@ -171,16 +115,16 @@ uint16_t i40e_simple_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 uint16_t i40e_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		uint16_t nb_pkts);
 int i40e_tx_queue_init(struct ci_tx_queue *txq);
-int i40e_rx_queue_init(struct i40e_rx_queue *rxq);
+int i40e_rx_queue_init(struct ci_rx_queue *rxq);
 void i40e_free_tx_resources(struct ci_tx_queue *txq);
-void i40e_free_rx_resources(struct i40e_rx_queue *rxq);
+void i40e_free_rx_resources(struct ci_rx_queue *rxq);
 void i40e_dev_clear_queues(struct rte_eth_dev *dev);
 void i40e_dev_free_queues(struct rte_eth_dev *dev);
-void i40e_reset_rx_queue(struct i40e_rx_queue *rxq);
+void i40e_reset_rx_queue(struct ci_rx_queue *rxq);
 void i40e_reset_tx_queue(struct ci_tx_queue *txq);
 int i40e_tx_done_cleanup(void *txq, uint32_t free_cnt);
-int i40e_alloc_rx_queue_mbufs(struct i40e_rx_queue *rxq);
-void i40e_rx_queue_release_mbufs(struct i40e_rx_queue *rxq);
+int i40e_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq);
+void i40e_rx_queue_release_mbufs(struct ci_rx_queue *rxq);
 
 uint32_t i40e_dev_rx_queue_count(void *rx_queue);
 int i40e_dev_rx_descriptor_status(void *rx_queue, uint16_t offset);
@@ -196,9 +140,9 @@ uint16_t i40e_recv_scattered_pkts_vec(void *rx_queue,
 				      struct rte_mbuf **rx_pkts,
 				      uint16_t nb_pkts);
 int i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev);
-int i40e_rxq_vec_setup(struct i40e_rx_queue *rxq);
+int i40e_rxq_vec_setup(struct ci_rx_queue *rxq);
 int i40e_txq_vec_setup(struct ci_tx_queue *txq);
-void i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq);
+void i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
 uint16_t i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 				   uint16_t nb_pkts);
 void i40e_set_rx_function(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
index 8fc7cd5bd4..97cf5226f6 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
@@ -13,12 +13,12 @@
 
 #ifdef __AVX2__
 static __rte_always_inline void
-i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
+i40e_rxq_rearm_common(struct ci_rx_queue *rxq, __rte_unused bool avx512)
 {
 	int i;
 	uint16_t rx_id;
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 
 	rxdp = rxq->rx_ring + rxq->rxrearm_start;
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 568891cfb2..a914ef20f4 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -16,13 +16,13 @@
 #include <rte_altivec.h>
 
 static inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
-	volatile union i40e_rx_desc *rxdp;
+	volatile union ci_rx_desc *rxdp;
 
-	struct i40e_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 
 	__vector unsigned long hdr_room = (__vector unsigned long){
@@ -195,16 +195,16 @@ desc_to_ptype_v(__vector unsigned long descs[4], struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a I40E_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *sw_ring;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
 	__vector unsigned char shuf_msk;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	__vector unsigned short crc_adjust = (__vector unsigned short){
 		0, 0,         /* ignore pkt_type field */
@@ -465,7 +465,7 @@ static uint16_t
 i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -611,13 +611,13 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 void __rte_cold
-i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
+i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	_i40e_rx_queue_release_mbufs_vec(rxq);
 }
 
 int __rte_cold
-i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
+i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index a13dd9bc78..fee2a6e670 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -16,7 +16,7 @@
 #include <rte_vect.h>
 
 static __rte_always_inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	i40e_rxq_rearm_common(rxq, false);
 }
@@ -29,7 +29,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
  * desc_idx: required to select the correct shift at compile time
  */
 static inline __m256i
-desc_fdir_processing_32b(volatile union i40e_rx_desc *rxdp,
+desc_fdir_processing_32b(volatile union ci_rx_desc *rxdp,
 			 struct rte_mbuf **rx_pkts,
 			 const uint32_t pkt_idx,
 			 const uint32_t desc_idx)
@@ -105,14 +105,14 @@ desc_fdir_processing_32b(volatile union i40e_rx_desc *rxdp,
 
 /* Force inline as some compilers will not inline by default. */
 static __rte_always_inline uint16_t
-_recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts, uint8_t *split_packet)
 {
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	struct i40e_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union i40e_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union ci_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
 	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
 	rte_prefetch0(rxdp);
 
@@ -623,7 +623,7 @@ static uint16_t
 i40e_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index f0320a221c..e609b7c411 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -16,7 +16,7 @@
 #include <rte_vect.h>
 
 static __rte_always_inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	i40e_rxq_rearm_common(rxq, true);
 }
@@ -29,7 +29,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
  * desc_idx: required to select the correct shift at compile time
  */
 static inline __m256i
-desc_fdir_processing_32b(volatile union i40e_rx_desc *rxdp,
+desc_fdir_processing_32b(volatile union ci_rx_desc *rxdp,
 			 struct rte_mbuf **rx_pkts,
 			 const uint32_t pkt_idx,
 			 const uint32_t desc_idx)
@@ -106,14 +106,14 @@ desc_fdir_processing_32b(volatile union i40e_rx_desc *rxdp,
 
 /* Force inline as some compilers will not inline by default. */
 static __rte_always_inline uint16_t
-_recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			  uint16_t nb_pkts, uint8_t *split_packet)
 {
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	struct i40e_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union i40e_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union ci_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
 
 	rte_prefetch0(rxdp);
 
@@ -691,7 +691,7 @@ i40e_recv_scattered_burst_vec_avx512(void *rx_queue,
 				     struct rte_mbuf **rx_pkts,
 				     uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index ba72df8e13..d19b9e4bf4 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -21,7 +21,7 @@ i40e_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 }
 
 static inline void
-_i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
+_i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	const unsigned mask = rxq->nb_rx_desc - 1;
 	unsigned i;
@@ -68,7 +68,7 @@ i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 	 */
 	ad->rx_vec_allowed = true;
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct i40e_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
 		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads)) {
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index 955382652c..02ba03c290 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -17,12 +17,12 @@
 #include "i40e_rxtx_vec_common.h"
 
 static inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	uint64x2_t dma_addr0, dma_addr1;
 	uint64x2_t zero = vdupq_n_u64(0);
@@ -80,7 +80,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 /* NEON version of FDIR mark extraction for 4 32B descriptors at a time */
 static inline uint32x4_t
-descs_to_fdir_32b(volatile union i40e_rx_desc *rxdp, struct rte_mbuf **rx_pkt)
+descs_to_fdir_32b(volatile union ci_rx_desc *rxdp, struct rte_mbuf **rx_pkt)
 {
 	/* 32B descriptors: Load 2nd half of descriptors for FDIR ID data */
 	uint64x2_t desc0_qw23, desc1_qw23, desc2_qw23, desc3_qw23;
@@ -203,7 +203,7 @@ descs_to_fdir_16b(uint32x4_t fltstat, uint64x2_t descs[4], struct rte_mbuf **rx_
 #endif
 
 static inline void
-desc_to_olflags_v(struct i40e_rx_queue *rxq, volatile union i40e_rx_desc *rxdp,
+desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union ci_rx_desc *rxdp,
 		  uint64x2_t descs[4], struct rte_mbuf **rx_pkts)
 {
 	uint32x4_t vlan0, vlan1, rss, l3_l4e;
@@ -332,15 +332,15 @@ desc_to_ptype_v(uint64x2_t descs[4], struct rte_mbuf **__rte_restrict rx_pkts,
  * - floor align nb_pkts to a I40E_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
+_recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		   struct rte_mbuf **__rte_restrict rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *sw_ring;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	/* mask to shuffle from desc. to mbuf */
 	uint8x16_t shuf_msk = {
@@ -591,7 +591,7 @@ i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
 
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -737,13 +737,13 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 }
 
 void __rte_cold
-i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
+i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	_i40e_rx_queue_release_mbufs_vec(rxq);
 }
 
 int __rte_cold
-i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
+i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index 7e7f4c0895..6bafd96797 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -15,12 +15,12 @@
 #include <rte_vect.h>
 
 static inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 			RTE_PKTMBUF_HEADROOM);
@@ -89,7 +89,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 /* SSE version of FDIR mark extraction for 4 32B descriptors at a time */
 static inline __m128i
-descs_to_fdir_32b(volatile union i40e_rx_desc *rxdp, struct rte_mbuf **rx_pkt)
+descs_to_fdir_32b(volatile union ci_rx_desc *rxdp, struct rte_mbuf **rx_pkt)
 {
 	/* 32B descriptors: Load 2nd half of descriptors for FDIR ID data */
 	__m128i desc0_qw23, desc1_qw23, desc2_qw23, desc3_qw23;
@@ -207,7 +207,7 @@ descs_to_fdir_16b(__m128i fltstat, __m128i descs[4], struct rte_mbuf **rx_pkt)
 #endif
 
 static inline void
-desc_to_olflags_v(struct i40e_rx_queue *rxq, volatile union i40e_rx_desc *rxdp,
+desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union ci_rx_desc *rxdp,
 		  __m128i descs[4], struct rte_mbuf **rx_pkts)
 {
 	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
@@ -347,16 +347,16 @@ desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a I40E_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
-	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *sw_ring;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
 	__m128i shuf_msk;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	__m128i crc_adjust = _mm_set_epi16(
 				0, 0, 0,    /* ignore non-length fields */
@@ -609,7 +609,7 @@ i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
 
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -755,13 +755,13 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 void __rte_cold
-i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
+i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	_i40e_rx_queue_release_mbufs_vec(rxq);
 }
 
 int __rte_cold
-i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
+i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
-- 
2.47.1

