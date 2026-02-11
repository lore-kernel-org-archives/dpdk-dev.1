Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD35ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:14:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 379EF406A2;
	Wed, 11 Feb 2026 19:13:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id EC42F40A80
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833616; x=1802369616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zDntfWk4xxWzCwipHajuW3mpFGwPo16V7LL2jRJ5ogw=;
 b=SrBLElO/xcH/rkSWL+iShF1nO//5Z+/nFbLmrwC8naMDfGjN6WTf67Ja
 YyayjxbH5xvdD65PhavmTFU6wjEC3oAY9YIv/JfayrlNmtRpJ5iYtFHGU
 czSjclk214sC2M8g06nwHMDuvzH9dmt7F2k4K/fqKoUleBNSzqHJDI25h
 Rq4jVyodkLEtSKwksVBbXtVQ3umuOhaZ8ICMXugy8OGSBGcDRuPm8KH4l
 C9EGpUqTdYWg4bX9swjoBnfY20m8G/DMC1/37LTderojnQQJ+KvIdUeN2
 Mv9e+yxZp1EnAXE+heZvs3O8CrFAluugS1l15e5kTpeomhKygQ0J0bt2G Q==;
X-CSE-ConnectionGUID: E/jjxwsSQLaWb/WsG4hYBg==
X-CSE-MsgGUID: fu49iDKFQiafH1avLleIEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834659"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:35 -0800
X-CSE-ConnectionGUID: jtFNopI2T9Sm8NxPJV2RMQ==
X-CSE-MsgGUID: Ne7vKbvKQF+4o1Aq1hsWGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986276"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:34 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v5 05/35] net/intel: consolidate definitions for Tx desc fields
Date: Wed, 11 Feb 2026 18:12:34 +0000
Message-ID: <20260211181309.2838042-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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

The offsets of the various fields within the Tx descriptors are common
for i40e, iavf, ice and idpf, so put a single set of defines in tx.h and
use those throughout all drivers.

NOTE: there was a small difference in mask of CMD field between drivers
depending on whether reserved fields or not were included. Those can be
ignored as those bits are unused in the drivers for which they are
reserved.

Similarly, the various flag fields, such as End-of-packet (EOP) and
Report-status (RS) are the same, as are offload definitions so
consolidate them.

Original definitions are in base code, and are left in place because of
that, but are unused.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx.h                 |  60 ++++++++
 drivers/net/intel/common/tx_scalar.h          |   6 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  24 +--
 drivers/net/intel/i40e/i40e_rxtx.c            |  92 ++++++------
 drivers/net/intel/i40e/i40e_rxtx.h            |  17 +--
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  11 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  22 ++-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  38 ++---
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  11 +-
 drivers/net/intel/iavf/iavf_rxtx.c            |  68 +++++----
 drivers/net/intel/iavf/iavf_rxtx.h            |  20 +--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  41 ++----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  80 ++++------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  34 ++---
 drivers/net/intel/ice/ice_dcf_ethdev.c        |   2 +-
 drivers/net/intel/ice/ice_rxtx.c              | 137 ++++++++----------
 drivers/net/intel/ice/ice_rxtx.h              |  15 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  41 ++----
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  39 ++---
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  41 +++---
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  22 +--
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 --
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  41 ++----
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  41 ++----
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   4 +-
 26 files changed, 409 insertions(+), 514 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 558c861df0..091f220f1c 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -10,6 +10,66 @@
 #include <rte_ethdev.h>
 #include <rte_vect.h>
 
+/* Common TX Descriptor QW1 Field Definitions */
+#define CI_TXD_QW1_DTYPE_S      0
+#define CI_TXD_QW1_DTYPE_M      (0xFUL << CI_TXD_QW1_DTYPE_S)
+#define CI_TXD_QW1_CMD_S        4
+#define CI_TXD_QW1_CMD_M        (0xFFFUL << CI_TXD_QW1_CMD_S)
+#define CI_TXD_QW1_OFFSET_S     16
+#define CI_TXD_QW1_OFFSET_M     (0x3FFFFULL << CI_TXD_QW1_OFFSET_S)
+#define CI_TXD_QW1_TX_BUF_SZ_S  34
+#define CI_TXD_QW1_TX_BUF_SZ_M  (0x3FFFULL << CI_TXD_QW1_TX_BUF_SZ_S)
+#define CI_TXD_QW1_L2TAG1_S     48
+#define CI_TXD_QW1_L2TAG1_M     (0xFFFFULL << CI_TXD_QW1_L2TAG1_S)
+
+/* Common Descriptor Types */
+#define CI_TX_DESC_DTYPE_DATA           0x0
+#define CI_TX_DESC_DTYPE_CTX            0x1
+#define CI_TX_DESC_DTYPE_DESC_DONE      0xF
+
+/* Common TX Descriptor Command Flags */
+#define CI_TX_DESC_CMD_EOP              0x0001
+#define CI_TX_DESC_CMD_RS               0x0002
+#define CI_TX_DESC_CMD_ICRC             0x0004
+#define CI_TX_DESC_CMD_IL2TAG1          0x0008
+#define CI_TX_DESC_CMD_DUMMY            0x0010
+#define CI_TX_DESC_CMD_IIPT_IPV6        0x0020
+#define CI_TX_DESC_CMD_IIPT_IPV4        0x0040
+#define CI_TX_DESC_CMD_IIPT_IPV4_CSUM   0x0060
+#define CI_TX_DESC_CMD_L4T_EOFT_TCP     0x0100
+#define CI_TX_DESC_CMD_L4T_EOFT_SCTP    0x0200
+#define CI_TX_DESC_CMD_L4T_EOFT_UDP     0x0300
+
+/* Common TX Context Descriptor Commands */
+#define CI_TX_CTX_DESC_TSO              0x01
+#define CI_TX_CTX_DESC_TSYN             0x02
+#define CI_TX_CTX_DESC_IL2TAG2          0x04
+
+/* Common TX Descriptor Length Field Shifts */
+#define CI_TX_DESC_LEN_MACLEN_S         0  /* 7 BITS */
+#define CI_TX_DESC_LEN_IPLEN_S          7  /* 7 BITS */
+#define CI_TX_DESC_LEN_L4_LEN_S         14 /* 4 BITS */
+
+/* Common maximum data per TX descriptor */
+#define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >> CI_TXD_QW1_TX_BUF_SZ_S)
+
+/**
+ * Common TX offload union for Intel drivers.
+ * Supports both basic offloads (l2_len, l3_len, l4_len, tso_segsz) and
+ * extended offloads (outer_l2_len, outer_l3_len) for tunneling support.
+ */
+union ci_tx_offload {
+	uint64_t data;
+	struct {
+		uint64_t l2_len:7;        /**< L2 (MAC) Header Length. */
+		uint64_t l3_len:9;        /**< L3 (IP) Header Length. */
+		uint64_t l4_len:8;        /**< L4 Header Length. */
+		uint64_t tso_segsz:16;    /**< TCP TSO segment size */
+		uint64_t outer_l2_len:8;  /**< outer L2 Header Length */
+		uint64_t outer_l3_len:16; /**< outer L3 Header Length */
+	};
+};
+
 /*
  * Structure of a 16-byte Tx descriptor common across i40e, ice, iavf and idpf drivers
  */
diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 181629d856..6f2024273b 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -33,10 +33,10 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
 	if (desc_to_clean_to >= nb_tx_desc)
 		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
 
-	/* Check if descriptor is done - all drivers use 0xF as done value in bits 3:0 */
+	/* Check if descriptor is done */
 	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-	if ((txd[desc_to_clean_to].cmd_type_offset_bsz & rte_cpu_to_le_64(0x0FUL)) !=
-			rte_cpu_to_le_64(0x0FUL))
+	if ((txd[desc_to_clean_to].cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 		return -1;
 
 	/* Figure out how many descriptors will be cleaned */
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 8a01aec0e2..3b099d5a9e 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -916,11 +916,11 @@ i40e_build_ctob(uint32_t td_cmd,
 		unsigned int size,
 		uint32_t td_tag)
 {
-	return rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DATA |
-			((uint64_t)td_cmd  << I40E_TXD_QW1_CMD_SHIFT) |
-			((uint64_t)td_offset << I40E_TXD_QW1_OFFSET_SHIFT) |
-			((uint64_t)size  << I40E_TXD_QW1_TX_BUF_SZ_SHIFT) |
-			((uint64_t)td_tag  << I40E_TXD_QW1_L2TAG1_SHIFT));
+	return rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+			((uint64_t)td_cmd  << CI_TXD_QW1_CMD_S) |
+			((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+			((uint64_t)size  << CI_TXD_QW1_TX_BUF_SZ_S) |
+			((uint64_t)td_tag  << CI_TXD_QW1_L2TAG1_S));
 }
 
 /*
@@ -1384,8 +1384,8 @@ i40e_find_available_buffer(struct rte_eth_dev *dev)
 
 		do {
 			if ((tmp_txdp->cmd_type_offset_bsz &
-					rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) ==
-					rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
+					rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) ==
+					rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 				fdir_info->txq_available_buf_count++;
 			else
 				break;
@@ -1710,9 +1710,9 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 	txdp = &txq->ci_tx_ring[txq->tx_tail + 1];
 	txdp->buffer_addr = rte_cpu_to_le_64(pf->fdir.dma_addr[txq->tx_tail >> 1]);
 
-	td_cmd = I40E_TX_DESC_CMD_EOP |
-		 I40E_TX_DESC_CMD_RS  |
-		 I40E_TX_DESC_CMD_DUMMY;
+	td_cmd = CI_TX_DESC_CMD_EOP |
+		 CI_TX_DESC_CMD_RS  |
+		 CI_TX_DESC_CMD_DUMMY;
 
 	txdp->cmd_type_offset_bsz =
 		i40e_build_ctob(td_cmd, 0, I40E_FDIR_PKT_LEN, 0);
@@ -1731,8 +1731,8 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 	if (wait_status) {
 		for (i = 0; i < I40E_FDIR_MAX_WAIT_US; i++) {
 			if ((txdp->cmd_type_offset_bsz &
-					rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) ==
-					rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
+					rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) ==
+					rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 				break;
 			rte_delay_us(1);
 		}
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2760e76e99..f96c5c7f1e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -45,7 +45,7 @@
 /* Base address of the HW descriptor ring should be 128B aligned. */
 #define I40E_RING_BASE_ALIGN	128
 
-#define I40E_TXD_CMD (I40E_TX_DESC_CMD_EOP | I40E_TX_DESC_CMD_RS)
+#define I40E_TXD_CMD (CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_RS)
 
 #ifdef RTE_LIBRTE_IEEE1588
 #define I40E_TX_IEEE1588_TMST RTE_MBUF_F_TX_IEEE1588_TMST
@@ -260,7 +260,7 @@ i40e_rxd_build_fdir(volatile union ci_rx_desc *rxdp, struct rte_mbuf *mb)
 
 static inline void
 i40e_parse_tunneling_params(uint64_t ol_flags,
-			    union i40e_tx_offload tx_offload,
+			    union ci_tx_offload tx_offload,
 			    uint32_t *cd_tunneling)
 {
 	/* EIPT: External (outer) IP header type */
@@ -319,51 +319,51 @@ static inline void
 i40e_txd_enable_checksum(uint64_t ol_flags,
 			uint32_t *td_cmd,
 			uint32_t *td_offset,
-			union i40e_tx_offload tx_offload)
+			union ci_tx_offload tx_offload)
 {
 	/* Set MACLEN */
 	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
 		*td_offset |= (tx_offload.l2_len >> 1)
-			<< I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
+			<< CI_TX_DESC_LEN_MACLEN_S;
 
 	/* Enable L3 checksum offloads */
 	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4_CSUM;
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
 		*td_offset |= (tx_offload.l3_len >> 2)
-				<< I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
+				<< CI_TX_DESC_LEN_IPLEN_S;
 	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV4;
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
 		*td_offset |= (tx_offload.l3_len >> 2)
-				<< I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
+				<< CI_TX_DESC_LEN_IPLEN_S;
 	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
-		*td_cmd |= I40E_TX_DESC_CMD_IIPT_IPV6;
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
 		*td_offset |= (tx_offload.l3_len >> 2)
-				<< I40E_TX_DESC_LENGTH_IPLEN_SHIFT;
+				<< CI_TX_DESC_LEN_IPLEN_S;
 	}
 
 	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_TCP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
 		*td_offset |= (tx_offload.l4_len >> 2)
-			<< I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+			<< CI_TX_DESC_LEN_L4_LEN_S;
 		return;
 	}
 
 	/* Enable L4 checksum offloads */
 	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
 	case RTE_MBUF_F_TX_TCP_CKSUM:
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_TCP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
 		*td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-				I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+				CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_SCTP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
 		*td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-				I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+				CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case RTE_MBUF_F_TX_UDP_CKSUM:
-		*td_cmd |= I40E_TX_DESC_CMD_L4T_EOFT_UDP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
 		*td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-				I40E_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+				CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	default:
 		break;
@@ -377,11 +377,11 @@ i40e_build_ctob(uint32_t td_cmd,
 		unsigned int size,
 		uint32_t td_tag)
 {
-	return rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DATA |
-			((uint64_t)td_cmd  << I40E_TXD_QW1_CMD_SHIFT) |
-			((uint64_t)td_offset << I40E_TXD_QW1_OFFSET_SHIFT) |
-			((uint64_t)size  << I40E_TXD_QW1_TX_BUF_SZ_SHIFT) |
-			((uint64_t)td_tag  << I40E_TXD_QW1_L2TAG1_SHIFT));
+	return rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+			((uint64_t)td_cmd  << CI_TXD_QW1_CMD_S) |
+			((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+			((uint64_t)size  << CI_TXD_QW1_TX_BUF_SZ_S) |
+			((uint64_t)td_tag  << CI_TXD_QW1_L2TAG1_S));
 }
 
 static inline int
@@ -1004,7 +1004,7 @@ i40e_calc_context_desc(uint64_t flags)
 
 /* set i40e TSO context descriptor */
 static inline uint64_t
-i40e_set_tso_ctx(struct rte_mbuf *mbuf, union i40e_tx_offload tx_offload)
+i40e_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 {
 	uint64_t ctx_desc = 0;
 	uint32_t cd_cmd, hdr_len, cd_tso_len;
@@ -1029,9 +1029,6 @@ i40e_set_tso_ctx(struct rte_mbuf *mbuf, union i40e_tx_offload tx_offload)
 	return ctx_desc;
 }
 
-/* HW requires that Tx buffer size ranges from 1B up to (16K-1)B. */
-#define I40E_MAX_DATA_PER_TXD \
-	(I40E_TXD_QW1_TX_BUF_SZ_MASK >> I40E_TXD_QW1_TX_BUF_SZ_SHIFT)
 /* Calculate the number of TX descriptors needed for each pkt */
 static inline uint16_t
 i40e_calc_pkt_desc(struct rte_mbuf *tx_pkt)
@@ -1040,7 +1037,7 @@ i40e_calc_pkt_desc(struct rte_mbuf *tx_pkt)
 	uint16_t count = 0;
 
 	while (txd != NULL) {
-		count += DIV_ROUND_UP(txd->data_len, I40E_MAX_DATA_PER_TXD);
+		count += DIV_ROUND_UP(txd->data_len, CI_MAX_DATA_PER_TXD);
 		txd = txd->next;
 	}
 
@@ -1069,7 +1066,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t tx_last;
 	uint16_t slen;
 	uint64_t buf_dma_addr;
-	union i40e_tx_offload tx_offload = {0};
+	union ci_tx_offload tx_offload = {0};
 
 	txq = tx_queue;
 	sw_ring = txq->sw_ring;
@@ -1138,18 +1135,18 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Descriptor based VLAN insertion */
 		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
-			td_cmd |= I40E_TX_DESC_CMD_IL2TAG1;
+			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 			td_tag = tx_pkt->vlan_tci;
 		}
 
 		/* Always enable CRC offload insertion */
-		td_cmd |= I40E_TX_DESC_CMD_ICRC;
+		td_cmd |= CI_TX_DESC_CMD_ICRC;
 
 		/* Fill in tunneling parameters if necessary */
 		cd_tunneling_params = 0;
 		if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 			td_offset |= (tx_offload.outer_l2_len >> 1)
-					<< I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
+					<< CI_TX_DESC_LEN_MACLEN_S;
 			i40e_parse_tunneling_params(ol_flags, tx_offload,
 						    &cd_tunneling_params);
 		}
@@ -1229,16 +1226,16 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			buf_dma_addr = rte_mbuf_data_iova(m_seg);
 
 			while ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) &&
-				unlikely(slen > I40E_MAX_DATA_PER_TXD)) {
+				unlikely(slen > CI_MAX_DATA_PER_TXD)) {
 				txd->buffer_addr =
 					rte_cpu_to_le_64(buf_dma_addr);
 				txd->cmd_type_offset_bsz =
 					i40e_build_ctob(td_cmd,
-					td_offset, I40E_MAX_DATA_PER_TXD,
+					td_offset, CI_MAX_DATA_PER_TXD,
 					td_tag);
 
-				buf_dma_addr += I40E_MAX_DATA_PER_TXD;
-				slen -= I40E_MAX_DATA_PER_TXD;
+				buf_dma_addr += CI_MAX_DATA_PER_TXD;
+				slen -= CI_MAX_DATA_PER_TXD;
 
 				txe->last_id = tx_last;
 				tx_id = txe->next_id;
@@ -1265,7 +1262,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		} while (m_seg != NULL);
 
 		/* The last packet data descriptor needs End Of Packet (EOP) */
-		td_cmd |= I40E_TX_DESC_CMD_EOP;
+		td_cmd |= CI_TX_DESC_CMD_EOP;
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
@@ -1275,15 +1272,14 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				   "%4u (port=%d queue=%d)",
 				   tx_last, txq->port_id, txq->queue_id);
 
-			td_cmd |= I40E_TX_DESC_CMD_RS;
+			td_cmd |= CI_TX_DESC_CMD_RS;
 
 			/* Update txq RS bit counters */
 			txq->nb_tx_used = 0;
 		}
 
 		txd->cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
-					I40E_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S);
 	}
 
 end_of_tx:
@@ -1309,8 +1305,8 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 	const uint16_t m = tx_rs_thresh % I40E_TX_MAX_FREE_BUF_SZ;
 
 	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
-			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
+			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
 
 	txep = &txq->sw_ring[txq->tx_next_dd - (tx_rs_thresh - 1)];
@@ -1441,8 +1437,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
 		i40e_tx_fill_hw_ring(txq, tx_pkts, n);
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
-						I40E_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 		txq->tx_tail = 0;
 	}
@@ -1454,8 +1449,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	/* Determine if RS bit needs to be set */
 	if (txq->tx_tail > txq->tx_next_rs) {
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
-						I40E_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 		if (txq->tx_next_rs >= txq->nb_tx_desc)
@@ -2383,9 +2377,9 @@ i40e_dev_tx_descriptor_status(void *tx_queue, uint16_t offset)
 	}
 
 	status = &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
-	mask = rte_le_to_cpu_64(I40E_TXD_QW1_DTYPE_MASK);
+	mask = rte_le_to_cpu_64(CI_TXD_QW1_DTYPE_M);
 	expect = rte_cpu_to_le_64(
-		I40E_TX_DESC_DTYPE_DESC_DONE << I40E_TXD_QW1_DTYPE_SHIFT);
+		CI_TX_DESC_DTYPE_DESC_DONE << CI_TXD_QW1_DTYPE_S);
 	if ((*status & mask) == expect)
 		return RTE_ETH_TX_DESC_DONE;
 
@@ -2883,7 +2877,7 @@ i40e_reset_tx_queue(struct ci_tx_queue *txq)
 		volatile struct ci_tx_desc *txd = &txq->ci_tx_ring[i];
 
 		txd->cmd_type_offset_bsz =
-			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
 		txe[prev].next_id = i;
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index ed173d8f17..307ffa3049 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -47,8 +47,8 @@
 #define I40E_RX_DESC_EXT_STATUS_FLEXBL_MASK   0x03
 #define I40E_RX_DESC_EXT_STATUS_FLEXBL_FLEX   0x01
 
-#define I40E_TD_CMD (I40E_TX_DESC_CMD_ICRC |\
-		     I40E_TX_DESC_CMD_EOP)
+#define I40E_TD_CMD (CI_TX_DESC_CMD_ICRC |\
+		     CI_TX_DESC_CMD_EOP)
 
 enum i40e_header_split_mode {
 	i40e_header_split_none = 0,
@@ -110,19 +110,6 @@ enum i40e_header_split_mode {
 
 #define I40E_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
 
-/** Offload features */
-union i40e_tx_offload {
-	uint64_t data;
-	struct {
-		uint64_t l2_len:7; /**< L2 (MAC) Header Length. */
-		uint64_t l3_len:9; /**< L3 (IP) Header Length. */
-		uint64_t l4_len:8; /**< L4 Header Length. */
-		uint64_t tso_segsz:16; /**< TCP TSO segment size */
-		uint64_t outer_l2_len:8; /**< outer L2 Header Length */
-		uint64_t outer_l3_len:16; /**< outer L3 Header Length */
-	};
-};
-
 int i40e_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int i40e_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int i40e_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 81e9e2bc0b..4c36748d94 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -449,9 +449,9 @@ static inline void
 vtx1(volatile struct ci_tx_desc *txdp,
 	struct rte_mbuf *pkt, uint64_t flags)
 {
-	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
-		((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT) |
-		((uint64_t)pkt->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 
 	__vector unsigned long descriptor = (__vector unsigned long){
 		pkt->buf_iova + pkt->data_off, high_qw};
@@ -477,7 +477,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = I40E_TX_DESC_CMD_RS | I40E_TD_CMD;
+	uint64_t rs = CI_TX_DESC_CMD_RS | I40E_TD_CMD;
 	int i;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
@@ -520,8 +520,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
-						I40E_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index f054bd41bf..502a1842c6 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -684,9 +684,9 @@ static inline void
 vtx1(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf *pkt, uint64_t flags)
 {
-	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT) |
-			((uint64_t)pkt->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+			((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 				pkt->buf_iova + pkt->data_off);
@@ -697,8 +697,7 @@ static inline void
 vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
-	const uint64_t hi_qw_tmpl = (I40E_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT));
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
@@ -709,13 +708,13 @@ vtx(volatile struct ci_tx_desc *txdp,
 	/* do two at a time while possible, in bursts */
 	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
 		uint64_t hi_qw3 = hi_qw_tmpl |
-				((uint64_t)pkt[3]->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT);
+				((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		uint64_t hi_qw2 = hi_qw_tmpl |
-				((uint64_t)pkt[2]->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT);
+				((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		uint64_t hi_qw1 = hi_qw_tmpl |
-				((uint64_t)pkt[1]->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT);
+				((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		uint64_t hi_qw0 = hi_qw_tmpl |
-				((uint64_t)pkt[0]->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT);
+				((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 
 		__m256i desc2_3 = _mm256_set_epi64x(
 				hi_qw3, pkt[3]->buf_iova + pkt[3]->data_off,
@@ -743,7 +742,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = I40E_TX_DESC_CMD_RS | I40E_TD_CMD;
+	uint64_t rs = CI_TX_DESC_CMD_RS | I40E_TD_CMD;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, i40e_tx_desc_done, false);
@@ -785,8 +784,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
-						I40E_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index 9a967faeee..d48ff9f51e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -752,9 +752,9 @@ i40e_recv_scattered_pkts_vec_avx512(void *rx_queue,
 static inline void
 vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt, uint64_t flags)
 {
-	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
-		((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT) |
-		((uint64_t)pkt->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 				pkt->buf_iova + pkt->data_off);
@@ -765,26 +765,17 @@ static inline void
 vtx(volatile struct ci_tx_desc *txdp,
 	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
-	const uint64_t hi_qw_tmpl = (I40E_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT));
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len <<
-			 I40E_TXD_QW1_TX_BUF_SZ_SHIFT);
-		uint64_t hi_qw2 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len <<
-			 I40E_TXD_QW1_TX_BUF_SZ_SHIFT);
-		uint64_t hi_qw1 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len <<
-			 I40E_TXD_QW1_TX_BUF_SZ_SHIFT);
-		uint64_t hi_qw0 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len <<
-			 I40E_TXD_QW1_TX_BUF_SZ_SHIFT);
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 
 		__m512i desc0_3 =
 			_mm512_set_epi64
@@ -811,7 +802,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = I40E_TX_DESC_CMD_RS | I40E_TD_CMD;
+	uint64_t rs = CI_TX_DESC_CMD_RS | I40E_TD_CMD;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, i40e_tx_desc_done, false);
@@ -854,8 +845,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
-						I40E_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index 1fd7fc75bf..292a39501e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -16,8 +16,8 @@ static inline int
 i40e_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
 	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) ==
-				rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 }
 
 static inline void
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index 0b95152232..be4c64942e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -600,9 +600,9 @@ static inline void
 vtx1(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf *pkt, uint64_t flags)
 {
-	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT) |
-			((uint64_t)pkt->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+			((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 
 	uint64x2_t descriptor = {pkt->buf_iova + pkt->data_off, high_qw};
 	vst1q_u64(RTE_CAST_PTR(uint64_t *, txdp), descriptor);
@@ -627,7 +627,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = I40E_TX_DESC_CMD_RS | I40E_TD_CMD;
+	uint64_t rs = CI_TX_DESC_CMD_RS | I40E_TD_CMD;
 	int i;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
@@ -669,8 +669,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
-						I40E_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 560abfc1ef..947b6c24d2 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -274,7 +274,7 @@ reset_tx_queue(struct ci_tx_queue *txq)
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
 		txq->ci_tx_ring[i].cmd_type_offset_bsz =
-			rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
 		txe[prev].next_id = i;
@@ -2351,12 +2351,12 @@ iavf_fill_ctx_desc_cmd_field(volatile uint64_t *field, struct rte_mbuf *m,
 
 	/* TSO enabled */
 	if (m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
-		cmd = IAVF_TX_CTX_DESC_TSO << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+		cmd = CI_TX_CTX_DESC_TSO << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
 	if ((m->ol_flags & RTE_MBUF_F_TX_VLAN &&
 			vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) ||
 			m->ol_flags & RTE_MBUF_F_TX_QINQ) {
-		cmd |= IAVF_TX_CTX_DESC_IL2TAG2
+		cmd |= CI_TX_CTX_DESC_IL2TAG2
 			<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
 	}
 
@@ -2577,20 +2577,20 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
 	uint64_t offset = 0;
 	uint64_t l2tag1 = 0;
 
-	*qw1 = IAVF_TX_DESC_DTYPE_DATA;
+	*qw1 = CI_TX_DESC_DTYPE_DATA;
 
-	command = (uint64_t)IAVF_TX_DESC_CMD_ICRC;
+	command = (uint64_t)CI_TX_DESC_CMD_ICRC;
 
 	/* Descriptor based VLAN insertion */
 	if ((vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) &&
 			m->ol_flags & RTE_MBUF_F_TX_VLAN) {
-		command |= (uint64_t)IAVF_TX_DESC_CMD_IL2TAG1;
+		command |= (uint64_t)CI_TX_DESC_CMD_IL2TAG1;
 		l2tag1 |= m->vlan_tci;
 	}
 
 	/* Descriptor based QinQ insertion. vlan_flag specifies outer tag location. */
 	if (m->ol_flags & RTE_MBUF_F_TX_QINQ) {
-		command |= (uint64_t)IAVF_TX_DESC_CMD_IL2TAG1;
+		command |= (uint64_t)CI_TX_DESC_CMD_IL2TAG1;
 		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci_outer :
 									m->vlan_tci;
 	}
@@ -2603,32 +2603,32 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
 	if (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK &&
 			!(m->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD))
 		offset |= (m->outer_l2_len >> 1)
-			<< IAVF_TX_DESC_LENGTH_MACLEN_SHIFT;
+			<< CI_TX_DESC_LEN_MACLEN_S;
 	else
 		offset |= (m->l2_len >> 1)
-			<< IAVF_TX_DESC_LENGTH_MACLEN_SHIFT;
+			<< CI_TX_DESC_LEN_MACLEN_S;
 
 	/* Enable L3 checksum offloading inner */
 	if (m->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
 		if (m->ol_flags & RTE_MBUF_F_TX_IPV4) {
-			command |= IAVF_TX_DESC_CMD_IIPT_IPV4_CSUM;
-			offset |= (m->l3_len >> 2) << IAVF_TX_DESC_LENGTH_IPLEN_SHIFT;
+			command |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
+			offset |= (m->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
 		}
 	} else if (m->ol_flags & RTE_MBUF_F_TX_IPV4) {
-		command |= IAVF_TX_DESC_CMD_IIPT_IPV4;
-		offset |= (m->l3_len >> 2) << IAVF_TX_DESC_LENGTH_IPLEN_SHIFT;
+		command |= CI_TX_DESC_CMD_IIPT_IPV4;
+		offset |= (m->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
 	} else if (m->ol_flags & RTE_MBUF_F_TX_IPV6) {
-		command |= IAVF_TX_DESC_CMD_IIPT_IPV6;
-		offset |= (m->l3_len >> 2) << IAVF_TX_DESC_LENGTH_IPLEN_SHIFT;
+		command |= CI_TX_DESC_CMD_IIPT_IPV6;
+		offset |= (m->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
 	}
 
 	if (m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
 		if (m->ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			command |= IAVF_TX_DESC_CMD_L4T_EOFT_TCP;
+			command |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
 		else
-			command |= IAVF_TX_DESC_CMD_L4T_EOFT_UDP;
+			command |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
 		offset |= (m->l4_len >> 2) <<
-			      IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+			      CI_TX_DESC_LEN_L4_LEN_S;
 
 		*qw1 = rte_cpu_to_le_64((((uint64_t)command <<
 			IAVF_TXD_DATA_QW1_CMD_SHIFT) & IAVF_TXD_DATA_QW1_CMD_MASK) |
@@ -2642,19 +2642,19 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
 	/* Enable L4 checksum offloads */
 	switch (m->ol_flags & RTE_MBUF_F_TX_L4_MASK) {
 	case RTE_MBUF_F_TX_TCP_CKSUM:
-		command |= IAVF_TX_DESC_CMD_L4T_EOFT_TCP;
+		command |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
 		offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-				IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+				CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		command |= IAVF_TX_DESC_CMD_L4T_EOFT_SCTP;
+		command |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
 		offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-				IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+				CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case RTE_MBUF_F_TX_UDP_CKSUM:
-		command |= IAVF_TX_DESC_CMD_L4T_EOFT_UDP;
+		command |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
 		offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-				IAVF_TX_DESC_LENGTH_L4_FC_LEN_SHIFT;
+				CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	}
 
@@ -2674,8 +2674,7 @@ iavf_calc_pkt_desc(struct rte_mbuf *tx_pkt)
 	uint16_t count = 0;
 
 	while (txd != NULL) {
-		count += (txd->data_len + IAVF_MAX_DATA_PER_TXD - 1) /
-			IAVF_MAX_DATA_PER_TXD;
+		count += (txd->data_len + CI_MAX_DATA_PER_TXD - 1) / CI_MAX_DATA_PER_TXD;
 		txd = txd->next;
 	}
 
@@ -2881,14 +2880,14 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			buf_dma_addr = rte_mbuf_data_iova(mb_seg);
 			while ((mb_seg->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
 					RTE_MBUF_F_TX_UDP_SEG)) &&
-					unlikely(slen > IAVF_MAX_DATA_PER_TXD)) {
+					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
 				iavf_fill_data_desc(ddesc, ddesc_template,
-					IAVF_MAX_DATA_PER_TXD, buf_dma_addr);
+					CI_MAX_DATA_PER_TXD, buf_dma_addr);
 
 				IAVF_DUMP_TX_DESC(txq, ddesc, desc_idx);
 
-				buf_dma_addr += IAVF_MAX_DATA_PER_TXD;
-				slen -= IAVF_MAX_DATA_PER_TXD;
+				buf_dma_addr += CI_MAX_DATA_PER_TXD;
+				slen -= CI_MAX_DATA_PER_TXD;
 
 				txe->last_id = desc_idx_last;
 				desc_idx = txe->next_id;
@@ -2909,7 +2908,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		} while (mb_seg);
 
 		/* The last packet data descriptor needs End Of Packet (EOP) */
-		ddesc_cmd = IAVF_TX_DESC_CMD_EOP;
+		ddesc_cmd = CI_TX_DESC_CMD_EOP;
 
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_desc_required);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_desc_required);
@@ -2919,7 +2918,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				   "%4u (port=%d queue=%d)",
 				   desc_idx_last, txq->port_id, txq->queue_id);
 
-			ddesc_cmd |= IAVF_TX_DESC_CMD_RS;
+			ddesc_cmd |= CI_TX_DESC_CMD_RS;
 
 			/* Update txq RS bit counters */
 			txq->nb_tx_used = 0;
@@ -4423,9 +4422,8 @@ iavf_dev_tx_desc_status(void *tx_queue, uint16_t offset)
 	}
 
 	status = &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
-	mask = rte_le_to_cpu_64(IAVF_TXD_QW1_DTYPE_MASK);
-	expect = rte_cpu_to_le_64(
-		 IAVF_TX_DESC_DTYPE_DESC_DONE << IAVF_TXD_QW1_DTYPE_SHIFT);
+	mask = rte_le_to_cpu_64(CI_TXD_QW1_DTYPE_M);
+	expect = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE << CI_TXD_QW1_DTYPE_S);
 	if ((*status & mask) == expect)
 		return RTE_ETH_TX_DESC_DONE;
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index dd6d884fc1..395d97b4ee 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -162,10 +162,6 @@
 #define IAVF_TX_OFFLOAD_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ IAVF_TX_OFFLOAD_MASK)
 
-/* HW requires that TX buffer size ranges from 1B up to (16K-1)B. */
-#define IAVF_MAX_DATA_PER_TXD \
-	(IAVF_TXD_QW1_TX_BUF_SZ_MASK >> IAVF_TXD_QW1_TX_BUF_SZ_SHIFT)
-
 #define IAVF_TX_LLDP_DYNFIELD "intel_pmd_dynfield_tx_lldp"
 #define IAVF_CHECK_TX_LLDP(m) \
 	((rte_pmd_iavf_tx_lldp_dynfield_offset > 0) && \
@@ -195,18 +191,6 @@ struct iavf_rx_queue_stats {
 	struct iavf_ipsec_crypto_stats ipsec_crypto;
 };
 
-/* Offload features */
-union iavf_tx_offload {
-	uint64_t data;
-	struct {
-		uint64_t l2_len:7; /* L2 (MAC) Header Length. */
-		uint64_t l3_len:9; /* L3 (IP) Header Length. */
-		uint64_t l4_len:8; /* L4 Header Length. */
-		uint64_t tso_segsz:16; /* TCP TSO segment size */
-		/* uint64_t unused : 24; */
-	};
-};
-
 /* Rx Flex Descriptor
  * RxDID Profile ID 16-21
  * Flex-field 0: RSS hash lower 16-bits
@@ -409,7 +393,7 @@ enum iavf_rx_flex_desc_ipsec_crypto_status {
 
 
 #define IAVF_TXD_DATA_QW1_DTYPE_SHIFT	(0)
-#define IAVF_TXD_DATA_QW1_DTYPE_MASK	(0xFUL << IAVF_TXD_QW1_DTYPE_SHIFT)
+#define IAVF_TXD_DATA_QW1_DTYPE_MASK	(0xFUL << CI_TXD_QW1_DTYPE_S)
 
 #define IAVF_TXD_DATA_QW1_CMD_SHIFT	(4)
 #define IAVF_TXD_DATA_QW1_CMD_MASK	(0x3FFUL << IAVF_TXD_DATA_QW1_CMD_SHIFT)
@@ -686,7 +670,7 @@ void iavf_dump_tx_descriptor(const struct ci_tx_queue *txq,
 		rte_le_to_cpu_64(tx_desc->cmd_type_offset_bsz &
 			rte_cpu_to_le_64(IAVF_TXD_DATA_QW1_DTYPE_MASK));
 	switch (type) {
-	case IAVF_TX_DESC_DTYPE_DATA:
+	case CI_TX_DESC_DTYPE_DATA:
 		name = "Tx_data_desc";
 		break;
 	case IAVF_TX_DESC_DTYPE_CONTEXT:
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 89ce841b9e..cea4ee9863 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1633,10 +1633,9 @@ static __rte_always_inline void
 iavf_vtx1(volatile struct ci_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags, bool offload, uint8_t vlan_flag)
 {
-	uint64_t high_qw =
-		(IAVF_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
-		 ((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 	if (offload)
 		iavf_txd_enable_offload(pkt, &high_qw, vlan_flag);
 
@@ -1649,8 +1648,7 @@ static __rte_always_inline void
 iavf_vtx(volatile struct ci_tx_desc *txdp,
 	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload, uint8_t vlan_flag)
 {
-	const uint64_t hi_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
@@ -1660,28 +1658,20 @@ iavf_vtx(volatile struct ci_tx_desc *txdp,
 
 	/* do two at a time while possible, in bursts */
 	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len <<
-			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
 			iavf_txd_enable_offload(pkt[3], &hi_qw3, vlan_flag);
-		uint64_t hi_qw2 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len <<
-			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
 			iavf_txd_enable_offload(pkt[2], &hi_qw2, vlan_flag);
-		uint64_t hi_qw1 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len <<
-			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
 			iavf_txd_enable_offload(pkt[1], &hi_qw1, vlan_flag);
-		uint64_t hi_qw0 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len <<
-			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
 			iavf_txd_enable_offload(pkt[0], &hi_qw0, vlan_flag);
 
@@ -1717,8 +1707,8 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
-	uint64_t flags = IAVF_TX_DESC_CMD_EOP | IAVF_TX_DESC_CMD_ICRC;
-	uint64_t rs = IAVF_TX_DESC_CMD_RS | flags;
+	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false);
@@ -1761,8 +1751,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
-					 IAVF_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index ad1b0b90cd..01477fd501 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1844,10 +1844,9 @@ iavf_vtx1(volatile struct ci_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags,
 	  bool offload, uint8_t vlan_flag)
 {
-	uint64_t high_qw =
-		(IAVF_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
-		 ((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 	if (offload)
 		iavf_txd_enable_offload(pkt, &high_qw, vlan_flag);
 
@@ -1863,8 +1862,7 @@ iavf_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
 		bool offload, uint8_t vlan_flag)
 {
-	const uint64_t hi_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
@@ -1874,22 +1872,14 @@ iavf_vtx(volatile struct ci_tx_desc *txdp,
 
 	/* do 4 at a time while possible, in bursts */
 	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len <<
-			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
-		uint64_t hi_qw2 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len <<
-			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
-		uint64_t hi_qw1 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len <<
-			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
-		uint64_t hi_qw0 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len <<
-			 IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload) {
 			iavf_txd_enable_offload(pkt[3], &hi_qw3, vlan_flag);
 			iavf_txd_enable_offload(pkt[2], &hi_qw2, vlan_flag);
@@ -2093,9 +2083,9 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 	if (IAVF_CHECK_TX_LLDP(pkt))
 		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 			<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
-	uint64_t high_data_qw = (IAVF_TX_DESC_DTYPE_DATA |
-				((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
-				((uint64_t)pkt->data_len << IAVF_TXD_QW1_TX_BUF_SZ_SHIFT));
+	uint64_t high_data_qw = (CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+				((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 	if (offload)
 		iavf_txd_enable_offload(pkt, &high_data_qw, vlan_flag);
 
@@ -2110,8 +2100,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
 		bool offload, uint8_t vlan_flag)
 {
-	uint64_t hi_data_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
-					((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
+	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
@@ -2128,11 +2117,9 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 		uint64_t hi_data_qw0 = 0;
 
 		hi_data_qw1 = hi_data_qw_tmpl |
-				((uint64_t)pkt[1]->data_len <<
-					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+				((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		hi_data_qw0 = hi_data_qw_tmpl |
-				((uint64_t)pkt[0]->data_len <<
-					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
+				((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
@@ -2140,13 +2127,11 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 					(uint64_t)pkt[1]->vlan_tci :
 					(uint64_t)pkt[1]->vlan_tci_outer;
-				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
-						IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				hi_ctx_qw1 |= CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
 					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				hi_ctx_qw1 |=
-					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw1 |=
 					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			}
@@ -2154,7 +2139,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 #endif
 		if (IAVF_CHECK_TX_LLDP(pkt[1]))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
-				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				<< CI_TXD_QW1_CMD_S;
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
@@ -2162,21 +2147,18 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 					(uint64_t)pkt[0]->vlan_tci :
 					(uint64_t)pkt[0]->vlan_tci_outer;
-				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
-						IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
 					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				hi_ctx_qw0 |=
-					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S;
 				low_ctx_qw0 |=
 					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			}
 		}
 #endif
 		if (IAVF_CHECK_TX_LLDP(pkt[0]))
-			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
-				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
 
 		if (offload) {
 			iavf_txd_enable_offload(pkt[1], &hi_data_qw1, vlan_flag);
@@ -2207,8 +2189,8 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
-	uint64_t flags = IAVF_TX_DESC_CMD_EOP | IAVF_TX_DESC_CMD_ICRC;
-	uint64_t rs = IAVF_TX_DESC_CMD_RS | flags;
+	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false);
@@ -2253,8 +2235,7 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
-					 IAVF_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
@@ -2275,8 +2256,8 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, nb_mbuf, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
-	uint64_t flags = IAVF_TX_DESC_CMD_EOP | IAVF_TX_DESC_CMD_ICRC;
-	uint64_t rs = IAVF_TX_DESC_CMD_RS | flags;
+	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
@@ -2321,8 +2302,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
-					 IAVF_TXD_QW1_CMD_SHIFT);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 1832b76f89..1538a44892 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -15,8 +15,8 @@ static inline int
 iavf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
 	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(IAVF_TXD_QW1_DTYPE_MASK)) ==
-				rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 }
 
 static inline void
@@ -147,26 +147,26 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 	/* Set MACLEN */
 	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
 		td_offset |= (tx_pkt->outer_l2_len >> 1)
-			<< IAVF_TX_DESC_LENGTH_MACLEN_SHIFT;
+			<< CI_TX_DESC_LEN_MACLEN_S;
 	else
 		td_offset |= (tx_pkt->l2_len >> 1)
-			<< IAVF_TX_DESC_LENGTH_MACLEN_SHIFT;
+			<< CI_TX_DESC_LEN_MACLEN_S;
 
 	/* Enable L3 checksum offloads */
 	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
 		if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-			td_cmd |= IAVF_TX_DESC_CMD_IIPT_IPV4_CSUM;
+			td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
 			td_offset |= (tx_pkt->l3_len >> 2) <<
-				     IAVF_TX_DESC_LENGTH_IPLEN_SHIFT;
+				     CI_TX_DESC_LEN_IPLEN_S;
 		}
 	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-		td_cmd |= IAVF_TX_DESC_CMD_IIPT_IPV4;
+		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
 		td_offset |= (tx_pkt->l3_len >> 2) <<
-			     IAVF_TX_DESC_LENGTH_IPLEN_SHIFT;
+			     CI_TX_DESC_LEN_IPLEN_S;
 	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
-		td_cmd |= IAVF_TX_DESC_CMD_IIPT_IPV6;
+		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
 		td_offset |= (tx_pkt->l3_len >> 2) <<
-			     IAVF_TX_DESC_LENGTH_IPLEN_SHIFT;
+			     CI_TX_DESC_LEN_IPLEN_S;
 	}
 
 	/* Enable L4 checksum offloads */
@@ -190,7 +190,7 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 		break;
 	}
 
-	*txd_hi |= ((uint64_t)td_offset) << IAVF_TXD_QW1_OFFSET_SHIFT;
+	*txd_hi |= ((uint64_t)td_offset) << CI_TXD_QW1_OFFSET_S;
 #endif
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
@@ -198,17 +198,15 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
 		/* vlan_flag specifies outer tag location for QinQ. */
 		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
-			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
-					IAVF_TXD_QW1_L2TAG1_SHIFT);
+			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer << CI_TXD_QW1_L2TAG1_S);
 		else
-			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
-					IAVF_TXD_QW1_L2TAG1_SHIFT);
+			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
 	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
-		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
-		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT);
+		td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
+		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
 	}
 #endif
 
-	*txd_hi |= ((uint64_t)td_cmd) << IAVF_TXD_QW1_CMD_SHIFT;
+	*txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
 }
 #endif
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 5f537b4c12..4ceecc15c6 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -406,7 +406,7 @@ reset_tx_queue(struct ci_tx_queue *txq)
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
 		txq->ci_tx_ring[i].cmd_type_offset_bsz =
-			rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
 		txe[prev].next_id = i;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 7a33e1e980..52bbf95967 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1124,7 +1124,7 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
 		volatile struct ci_tx_desc *txd = &txq->ci_tx_ring[i];
 
 		txd->cmd_type_offset_bsz =
-			rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
 		txe[prev].next_id = i;
@@ -2556,9 +2556,8 @@ ice_tx_descriptor_status(void *tx_queue, uint16_t offset)
 	}
 
 	status = &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
-	mask = rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M);
-	expect = rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE <<
-				  ICE_TXD_QW1_DTYPE_S);
+	mask = rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M);
+	expect = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE << CI_TXD_QW1_DTYPE_S);
 	if ((*status & mask) == expect)
 		return RTE_ETH_TX_DESC_DONE;
 
@@ -2904,7 +2903,7 @@ ice_recv_pkts(void *rx_queue,
 
 static inline void
 ice_parse_tunneling_params(uint64_t ol_flags,
-			    union ice_tx_offload tx_offload,
+			    union ci_tx_offload tx_offload,
 			    uint32_t *cd_tunneling)
 {
 	/* EIPT: External (outer) IP header type */
@@ -2965,58 +2964,58 @@ static inline void
 ice_txd_enable_checksum(uint64_t ol_flags,
 			uint32_t *td_cmd,
 			uint32_t *td_offset,
-			union ice_tx_offload tx_offload)
+			union ci_tx_offload tx_offload)
 {
 	/* Set MACLEN */
 	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
 		*td_offset |= (tx_offload.l2_len >> 1)
-			<< ICE_TX_DESC_LEN_MACLEN_S;
+			<< CI_TX_DESC_LEN_MACLEN_S;
 
 	/* Enable L3 checksum offloads */
 	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-		*td_cmd |= ICE_TX_DESC_CMD_IIPT_IPV4_CSUM;
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
 		*td_offset |= (tx_offload.l3_len >> 2) <<
-			ICE_TX_DESC_LEN_IPLEN_S;
+			CI_TX_DESC_LEN_IPLEN_S;
 	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-		*td_cmd |= ICE_TX_DESC_CMD_IIPT_IPV4;
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
 		*td_offset |= (tx_offload.l3_len >> 2) <<
-			ICE_TX_DESC_LEN_IPLEN_S;
+			CI_TX_DESC_LEN_IPLEN_S;
 	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
-		*td_cmd |= ICE_TX_DESC_CMD_IIPT_IPV6;
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
 		*td_offset |= (tx_offload.l3_len >> 2) <<
-			ICE_TX_DESC_LEN_IPLEN_S;
+			CI_TX_DESC_LEN_IPLEN_S;
 	}
 
 	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
-		*td_cmd |= ICE_TX_DESC_CMD_L4T_EOFT_TCP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
 		*td_offset |= (tx_offload.l4_len >> 2) <<
-			      ICE_TX_DESC_LEN_L4_LEN_S;
+			      CI_TX_DESC_LEN_L4_LEN_S;
 		return;
 	}
 
 	if (ol_flags & RTE_MBUF_F_TX_UDP_SEG) {
-		*td_cmd |= ICE_TX_DESC_CMD_L4T_EOFT_UDP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
 		*td_offset |= (tx_offload.l4_len >> 2) <<
-			      ICE_TX_DESC_LEN_L4_LEN_S;
+			      CI_TX_DESC_LEN_L4_LEN_S;
 		return;
 	}
 
 	/* Enable L4 checksum offloads */
 	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
 	case RTE_MBUF_F_TX_TCP_CKSUM:
-		*td_cmd |= ICE_TX_DESC_CMD_L4T_EOFT_TCP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
 		*td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-			      ICE_TX_DESC_LEN_L4_LEN_S;
+			      CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		*td_cmd |= ICE_TX_DESC_CMD_L4T_EOFT_SCTP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
 		*td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-			      ICE_TX_DESC_LEN_L4_LEN_S;
+			      CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case RTE_MBUF_F_TX_UDP_CKSUM:
-		*td_cmd |= ICE_TX_DESC_CMD_L4T_EOFT_UDP;
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
 		*td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-			      ICE_TX_DESC_LEN_L4_LEN_S;
+			      CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	default:
 		break;
@@ -3030,11 +3029,11 @@ ice_build_ctob(uint32_t td_cmd,
 	       uint16_t size,
 	       uint32_t td_tag)
 {
-	return rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DATA |
-				((uint64_t)td_cmd << ICE_TXD_QW1_CMD_S) |
-				((uint64_t)td_offset << ICE_TXD_QW1_OFFSET_S) |
-				((uint64_t)size << ICE_TXD_QW1_TX_BUF_SZ_S) |
-				((uint64_t)td_tag << ICE_TXD_QW1_L2TAG1_S));
+	return rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
+				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+				((uint64_t)size << CI_TXD_QW1_TX_BUF_SZ_S) |
+				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
 }
 
 /* Check if the context descriptor is needed for TX offloading */
@@ -3053,7 +3052,7 @@ ice_calc_context_desc(uint64_t flags)
 
 /* set ice TSO context descriptor */
 static inline uint64_t
-ice_set_tso_ctx(struct rte_mbuf *mbuf, union ice_tx_offload tx_offload)
+ice_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 {
 	uint64_t ctx_desc = 0;
 	uint32_t cd_cmd, hdr_len, cd_tso_len;
@@ -3067,18 +3066,15 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union ice_tx_offload tx_offload)
 	hdr_len += (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
 		   tx_offload.outer_l2_len + tx_offload.outer_l3_len : 0;
 
-	cd_cmd = ICE_TX_CTX_DESC_TSO;
+	cd_cmd = CI_TX_CTX_DESC_TSO;
 	cd_tso_len = mbuf->pkt_len - hdr_len;
-	ctx_desc |= ((uint64_t)cd_cmd << ICE_TXD_CTX_QW1_CMD_S) |
+	ctx_desc |= ((uint64_t)cd_cmd << CI_TXD_QW1_CMD_S) |
 		    ((uint64_t)cd_tso_len << ICE_TXD_CTX_QW1_TSO_LEN_S) |
 		    ((uint64_t)mbuf->tso_segsz << ICE_TXD_CTX_QW1_MSS_S);
 
 	return ctx_desc;
 }
 
-/* HW requires that TX buffer size ranges from 1B up to (16K-1)B. */
-#define ICE_MAX_DATA_PER_TXD \
-	(ICE_TXD_QW1_TX_BUF_SZ_M >> ICE_TXD_QW1_TX_BUF_SZ_S)
 /* Calculate the number of TX descriptors needed for each pkt */
 static inline uint16_t
 ice_calc_pkt_desc(struct rte_mbuf *tx_pkt)
@@ -3087,7 +3083,7 @@ ice_calc_pkt_desc(struct rte_mbuf *tx_pkt)
 	uint16_t count = 0;
 
 	while (txd != NULL) {
-		count += DIV_ROUND_UP(txd->data_len, ICE_MAX_DATA_PER_TXD);
+		count += DIV_ROUND_UP(txd->data_len, CI_MAX_DATA_PER_TXD);
 		txd = txd->next;
 	}
 
@@ -3117,7 +3113,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t slen;
 	uint64_t buf_dma_addr;
 	uint64_t ol_flags;
-	union ice_tx_offload tx_offload = {0};
+	union ci_tx_offload tx_offload = {0};
 
 	txq = tx_queue;
 	sw_ring = txq->sw_ring;
@@ -3185,7 +3181,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Descriptor based VLAN insertion */
 		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
-			td_cmd |= ICE_TX_DESC_CMD_IL2TAG1;
+			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 			td_tag = tx_pkt->vlan_tci;
 		}
 
@@ -3193,7 +3189,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		cd_tunneling_params = 0;
 		if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 			td_offset |= (tx_offload.outer_l2_len >> 1)
-				<< ICE_TX_DESC_LEN_MACLEN_S;
+				<< CI_TX_DESC_LEN_MACLEN_S;
 			ice_parse_tunneling_params(ol_flags, tx_offload,
 						   &cd_tunneling_params);
 		}
@@ -3223,8 +3219,8 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 					ice_set_tso_ctx(tx_pkt, tx_offload);
 			else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
 				cd_type_cmd_tso_mss |=
-					((uint64_t)ICE_TX_CTX_DESC_TSYN <<
-					ICE_TXD_CTX_QW1_CMD_S) |
+					((uint64_t)CI_TX_CTX_DESC_TSYN <<
+					CI_TXD_QW1_CMD_S) |
 					 (((uint64_t)txq->ice_vsi->adapter->ptp_tx_index <<
 					 ICE_TXD_CTX_QW1_TSYN_S) & ICE_TXD_CTX_QW1_TSYN_M);
 
@@ -3235,8 +3231,8 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 				cd_l2tag2 = tx_pkt->vlan_tci_outer;
 				cd_type_cmd_tso_mss |=
-					((uint64_t)ICE_TX_CTX_DESC_IL2TAG2 <<
-					 ICE_TXD_CTX_QW1_CMD_S);
+					((uint64_t)CI_TX_CTX_DESC_IL2TAG2 <<
+					 CI_TXD_QW1_CMD_S);
 			}
 			ctx_txd->l2tag2 = rte_cpu_to_le_16(cd_l2tag2);
 			ctx_txd->qw1 =
@@ -3261,18 +3257,16 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			buf_dma_addr = rte_mbuf_data_iova(m_seg);
 
 			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) &&
-				unlikely(slen > ICE_MAX_DATA_PER_TXD)) {
+					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
 				txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-				txd->cmd_type_offset_bsz =
-				rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DATA |
-				((uint64_t)td_cmd << ICE_TXD_QW1_CMD_S) |
-				((uint64_t)td_offset << ICE_TXD_QW1_OFFSET_S) |
-				((uint64_t)ICE_MAX_DATA_PER_TXD <<
-				 ICE_TXD_QW1_TX_BUF_SZ_S) |
-				((uint64_t)td_tag << ICE_TXD_QW1_L2TAG1_S));
+				txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+					((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
+					((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+					((uint64_t)CI_MAX_DATA_PER_TXD << CI_TXD_QW1_TX_BUF_SZ_S) |
+					((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
 
-				buf_dma_addr += ICE_MAX_DATA_PER_TXD;
-				slen -= ICE_MAX_DATA_PER_TXD;
+				buf_dma_addr += CI_MAX_DATA_PER_TXD;
+				slen -= CI_MAX_DATA_PER_TXD;
 
 				txe->last_id = tx_last;
 				tx_id = txe->next_id;
@@ -3282,12 +3276,11 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			}
 
 			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-			txd->cmd_type_offset_bsz =
-				rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DATA |
-				((uint64_t)td_cmd << ICE_TXD_QW1_CMD_S) |
-				((uint64_t)td_offset << ICE_TXD_QW1_OFFSET_S) |
-				((uint64_t)slen << ICE_TXD_QW1_TX_BUF_SZ_S) |
-				((uint64_t)td_tag << ICE_TXD_QW1_L2TAG1_S));
+			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
+				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+				((uint64_t)slen << CI_TXD_QW1_TX_BUF_SZ_S) |
+				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
@@ -3296,7 +3289,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		} while (m_seg);
 
 		/* fill the last descriptor with End of Packet (EOP) bit */
-		td_cmd |= ICE_TX_DESC_CMD_EOP;
+		td_cmd |= CI_TX_DESC_CMD_EOP;
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
@@ -3307,14 +3300,13 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				   "%4u (port=%d queue=%d)",
 				   tx_last, txq->port_id, txq->queue_id);
 
-			td_cmd |= ICE_TX_DESC_CMD_RS;
+			td_cmd |= CI_TX_DESC_CMD_RS;
 
 			/* Update txq RS bit counters */
 			txq->nb_tx_used = 0;
 		}
 		txd->cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
-					 ICE_TXD_QW1_CMD_S);
+			rte_cpu_to_le_64(((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S);
 
 		if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
 			uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt,
@@ -3361,8 +3353,8 @@ ice_tx_free_bufs(struct ci_tx_queue *txq)
 	uint16_t i;
 
 	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
-	     rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M)) !=
-	    rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE))
+	     rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+	    rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
 
 	txep = &txq->sw_ring[txq->tx_next_dd - (txq->tx_rs_thresh - 1)];
@@ -3598,8 +3590,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
 		ice_tx_fill_hw_ring(txq, tx_pkts, n);
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS) <<
-					 ICE_TXD_QW1_CMD_S);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 		txq->tx_tail = 0;
 	}
@@ -3611,8 +3602,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	/* Determine if RS bit needs to be set */
 	if (txq->tx_tail > txq->tx_next_rs) {
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS) <<
-					 ICE_TXD_QW1_CMD_S);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 		if (txq->tx_next_rs >= txq->nb_tx_desc)
@@ -4843,9 +4833,9 @@ ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc)
 
 	txdp = &txq->ci_tx_ring[txq->tx_tail + 1];
 	txdp->buffer_addr = rte_cpu_to_le_64(pf->fdir.dma_addr);
-	td_cmd = ICE_TX_DESC_CMD_EOP |
-		ICE_TX_DESC_CMD_RS  |
-		ICE_TX_DESC_CMD_DUMMY;
+	td_cmd = CI_TX_DESC_CMD_EOP |
+		CI_TX_DESC_CMD_RS  |
+		CI_TX_DESC_CMD_DUMMY;
 
 	txdp->cmd_type_offset_bsz =
 		ice_build_ctob(td_cmd, 0, ICE_FDIR_PKT_LEN, 0);
@@ -4856,9 +4846,8 @@ ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc)
 	/* Update the tx tail register */
 	ICE_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
 	for (i = 0; i < ICE_FDIR_MAX_WAIT_US; i++) {
-		if ((txdp->cmd_type_offset_bsz &
-		     rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M)) ==
-		    rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE))
+		if ((txdp->cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) ==
+		    rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 			break;
 		rte_delay_us(1);
 	}
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index c524e9f756..cd5fa93d1c 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -46,7 +46,7 @@
 
 #define ICE_SUPPORT_CHAIN_NUM 5
 
-#define ICE_TD_CMD                      ICE_TX_DESC_CMD_EOP
+#define ICE_TD_CMD                      CI_TX_DESC_CMD_EOP
 
 #define ICE_VPMD_RX_BURST            CI_VPMD_RX_BURST
 #define ICE_VPMD_TX_BURST            32
@@ -169,19 +169,6 @@ struct ice_txtime {
 	const struct rte_memzone *ts_mz;
 };
 
-/* Offload features */
-union ice_tx_offload {
-	uint64_t data;
-	struct {
-		uint64_t l2_len:7; /* L2 (MAC) Header Length. */
-		uint64_t l3_len:9; /* L3 (IP) Header Length. */
-		uint64_t l4_len:8; /* L4 Header Length. */
-		uint64_t tso_segsz:16; /* TCP TSO segment size */
-		uint64_t outer_l2_len:8; /* outer L2 Header Length */
-		uint64_t outer_l3_len:16; /* outer L3 Header Length */
-	};
-};
-
 /* Rx Flex Descriptor for Comms Package Profile
  * RxDID Profile ID 22 (swap Hash and FlowID)
  * Flex-field 0: Flow ID lower 16-bits
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 0a1df0b2f6..2922671158 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -777,10 +777,9 @@ static __rte_always_inline void
 ice_vtx1(volatile struct ci_tx_desc *txdp,
 	 struct rte_mbuf *pkt, uint64_t flags, bool offload)
 {
-	uint64_t high_qw =
-		(ICE_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags  << ICE_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << ICE_TXD_QW1_TX_BUF_SZ_S));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 	if (offload)
 		ice_txd_enable_offload(pkt, &high_qw);
 
@@ -792,8 +791,7 @@ static __rte_always_inline void
 ice_vtx(volatile struct ci_tx_desc *txdp,
 	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload)
 {
-	const uint64_t hi_qw_tmpl = (ICE_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << ICE_TXD_QW1_CMD_S));
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
@@ -801,30 +799,22 @@ ice_vtx(volatile struct ci_tx_desc *txdp,
 		nb_pkts--, txdp++, pkt++;
 	}
 
-	/* do two at a time while possible, in bursts */
+	/* do four at a time while possible, in bursts */
 	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len <<
-			 ICE_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
 			ice_txd_enable_offload(pkt[3], &hi_qw3);
-		uint64_t hi_qw2 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len <<
-			 ICE_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
 			ice_txd_enable_offload(pkt[2], &hi_qw2);
-		uint64_t hi_qw1 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len <<
-			 ICE_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
 			ice_txd_enable_offload(pkt[1], &hi_qw1);
-		uint64_t hi_qw0 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len <<
-			 ICE_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (offload)
 			ice_txd_enable_offload(pkt[0], &hi_qw0);
 
@@ -856,7 +846,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = ICE_TD_CMD;
-	uint64_t rs = ICE_TX_DESC_CMD_RS | ICE_TD_CMD;
+	uint64_t rs = CI_TX_DESC_CMD_RS | ICE_TD_CMD;
 
 	/* cross rx_thresh boundary is not allowed */
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
@@ -901,8 +891,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS) <<
-					 ICE_TXD_QW1_CMD_S);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index d42f41461f..e64b6e227b 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -850,10 +850,9 @@ static __rte_always_inline void
 ice_vtx1(volatile struct ci_tx_desc *txdp,
 	 struct rte_mbuf *pkt, uint64_t flags, bool do_offload)
 {
-	uint64_t high_qw =
-		(ICE_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags  << ICE_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << ICE_TXD_QW1_TX_BUF_SZ_S));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 
 	if (do_offload)
 		ice_txd_enable_offload(pkt, &high_qw);
@@ -866,32 +865,23 @@ static __rte_always_inline void
 ice_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
 	uint16_t nb_pkts,  uint64_t flags, bool do_offload)
 {
-	const uint64_t hi_qw_tmpl = (ICE_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << ICE_TXD_QW1_CMD_S));
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len <<
-			 ICE_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (do_offload)
 			ice_txd_enable_offload(pkt[3], &hi_qw3);
-		uint64_t hi_qw2 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len <<
-			 ICE_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (do_offload)
 			ice_txd_enable_offload(pkt[2], &hi_qw2);
-		uint64_t hi_qw1 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len <<
-			 ICE_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (do_offload)
 			ice_txd_enable_offload(pkt[1], &hi_qw1);
-		uint64_t hi_qw0 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len <<
-			 ICE_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 		if (do_offload)
 			ice_txd_enable_offload(pkt[0], &hi_qw0);
 
@@ -920,7 +910,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = ICE_TD_CMD;
-	uint64_t rs = ICE_TX_DESC_CMD_RS | ICE_TD_CMD;
+	uint64_t rs = CI_TX_DESC_CMD_RS | ICE_TD_CMD;
 
 	/* cross rx_thresh boundary is not allowed */
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
@@ -966,8 +956,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS) <<
-					 ICE_TXD_QW1_CMD_S);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 8ba591e403..1d83a087cc 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -12,8 +12,8 @@ static inline int
 ice_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
 	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M)) ==
-				rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 }
 
 static inline void
@@ -124,53 +124,52 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
 	/* Tx Checksum Offload */
 	/* SET MACLEN */
 	td_offset |= (tx_pkt->l2_len >> 1) <<
-		ICE_TX_DESC_LEN_MACLEN_S;
+		CI_TX_DESC_LEN_MACLEN_S;
 
 	/* Enable L3 checksum offload */
 	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-		td_cmd |= ICE_TX_DESC_CMD_IIPT_IPV4_CSUM;
+		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
 		td_offset |= (tx_pkt->l3_len >> 2) <<
-			ICE_TX_DESC_LEN_IPLEN_S;
+			CI_TX_DESC_LEN_IPLEN_S;
 	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-		td_cmd |= ICE_TX_DESC_CMD_IIPT_IPV4;
+		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
 		td_offset |= (tx_pkt->l3_len >> 2) <<
-			ICE_TX_DESC_LEN_IPLEN_S;
+			CI_TX_DESC_LEN_IPLEN_S;
 	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
-		td_cmd |= ICE_TX_DESC_CMD_IIPT_IPV6;
+		td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
 		td_offset |= (tx_pkt->l3_len >> 2) <<
-			ICE_TX_DESC_LEN_IPLEN_S;
+			CI_TX_DESC_LEN_IPLEN_S;
 	}
 
 	/* Enable L4 checksum offloads */
 	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
 	case RTE_MBUF_F_TX_TCP_CKSUM:
-		td_cmd |= ICE_TX_DESC_CMD_L4T_EOFT_TCP;
+		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
 		td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-			ICE_TX_DESC_LEN_L4_LEN_S;
+			CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		td_cmd |= ICE_TX_DESC_CMD_L4T_EOFT_SCTP;
+		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
 		td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-			ICE_TX_DESC_LEN_L4_LEN_S;
+			CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	case RTE_MBUF_F_TX_UDP_CKSUM:
-		td_cmd |= ICE_TX_DESC_CMD_L4T_EOFT_UDP;
+		td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
 		td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-			ICE_TX_DESC_LEN_L4_LEN_S;
+			CI_TX_DESC_LEN_L4_LEN_S;
 		break;
 	default:
 		break;
 	}
 
-	*txd_hi |= ((uint64_t)td_offset) << ICE_TXD_QW1_OFFSET_S;
+	*txd_hi |= ((uint64_t)td_offset) << CI_TXD_QW1_OFFSET_S;
 
-	/* Tx VLAN insertion Offload */
+	/* Tx VLAN/QINQ insertion Offload */
 	if (ol_flags & RTE_MBUF_F_TX_VLAN) {
-		td_cmd |= ICE_TX_DESC_CMD_IL2TAG1;
-		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
-				ICE_TXD_QW1_L2TAG1_S);
+		td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
+		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << CI_TXD_QW1_L2TAG1_S);
 	}
 
-	*txd_hi |= ((uint64_t)td_cmd) << ICE_TXD_QW1_CMD_S;
+	*txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
 }
 #endif
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 23666539ab..587871b54a 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -271,7 +271,7 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
 		txq->ci_tx_ring[i].cmd_type_offset_bsz =
-			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
 		txe[prev].next_id = i;
@@ -849,7 +849,7 @@ idpf_calc_context_desc(uint64_t flags)
  */
 static inline void
 idpf_set_splitq_tso_ctx(struct rte_mbuf *mbuf,
-			union idpf_tx_offload tx_offload,
+			union ci_tx_offload tx_offload,
 			volatile union idpf_flex_tx_ctx_desc *ctx_desc)
 {
 	uint16_t cmd_dtype;
@@ -887,7 +887,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct idpf_flex_tx_sched_desc *txr;
 	volatile struct idpf_flex_tx_sched_desc *txd;
 	struct ci_tx_entry *sw_ring;
-	union idpf_tx_offload tx_offload = {0};
+	union ci_tx_offload tx_offload = {0};
 	struct ci_tx_entry *txe, *txn;
 	uint16_t nb_used, tx_id, sw_id;
 	struct rte_mbuf *tx_pkt;
@@ -1334,7 +1334,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 {
 	volatile struct ci_tx_desc *txd;
 	volatile struct ci_tx_desc *txr;
-	union idpf_tx_offload tx_offload = {0};
+	union ci_tx_offload tx_offload = {0};
 	struct ci_tx_entry *txe, *txn;
 	struct ci_tx_entry *sw_ring;
 	struct ci_tx_queue *txq;
@@ -1452,10 +1452,10 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			slen = m_seg->data_len;
 			buf_dma_addr = rte_mbuf_data_iova(m_seg);
 			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DATA |
-				((uint64_t)td_cmd  << IDPF_TXD_QW1_CMD_S) |
-				((uint64_t)td_offset << IDPF_TXD_QW1_OFFSET_S) |
-				((uint64_t)slen << IDPF_TXD_QW1_TX_BUF_SZ_S));
+			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)td_cmd  << CI_TXD_QW1_CMD_S) |
+				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+				((uint64_t)slen << CI_TXD_QW1_TX_BUF_SZ_S));
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
@@ -1464,7 +1464,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		} while (m_seg);
 
 		/* The last packet data descriptor needs End Of Packet (EOP) */
-		td_cmd |= IDPF_TX_DESC_CMD_EOP;
+		td_cmd |= CI_TX_DESC_CMD_EOP;
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
@@ -1473,13 +1473,13 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       "%4u (port=%d queue=%d)",
 			       tx_last, txq->port_id, txq->queue_id);
 
-			td_cmd |= IDPF_TX_DESC_CMD_RS;
+			td_cmd |= CI_TX_DESC_CMD_RS;
 
 			/* Update txq RS bit counters */
 			txq->nb_tx_used = 0;
 		}
 
-		txd->cmd_type_offset_bsz |= rte_cpu_to_le_16(td_cmd << IDPF_TXD_QW1_CMD_S);
+		txd->cmd_type_offset_bsz |= rte_cpu_to_le_16(td_cmd << CI_TXD_QW1_CMD_S);
 	}
 
 end_of_tx:
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 2f2fa153b2..b88a87402d 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -169,18 +169,6 @@ struct idpf_rx_queue {
 	uint32_t hw_register_set;
 };
 
-/* Offload features */
-union idpf_tx_offload {
-	uint64_t data;
-	struct {
-		uint64_t l2_len:7; /* L2 (MAC) Header Length. */
-		uint64_t l3_len:9; /* L3 (IP) Header Length. */
-		uint64_t l4_len:8; /* L4 Header Length. */
-		uint64_t tso_segsz:16; /* TCP TSO segment size */
-		/* uint64_t unused : 24; */
-	};
-};
-
 union idpf_tx_desc {
 	struct ci_tx_desc *tx_ring;
 	struct idpf_flex_tx_sched_desc *desc_ring;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 04efee3722..411b171b97 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -486,10 +486,9 @@ static inline void
 idpf_singleq_vtx1(volatile struct ci_tx_desc *txdp,
 		  struct rte_mbuf *pkt, uint64_t flags)
 {
-	uint64_t high_qw =
-		(IDPF_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags  << IDPF_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 				pkt->buf_iova + pkt->data_off);
@@ -500,8 +499,7 @@ static inline void
 idpf_singleq_vtx(volatile struct ci_tx_desc *txdp,
 		 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
-	const uint64_t hi_qw_tmpl = (IDPF_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << IDPF_TXD_QW1_CMD_S));
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
@@ -511,22 +509,14 @@ idpf_singleq_vtx(volatile struct ci_tx_desc *txdp,
 
 	/* do two at a time while possible, in bursts */
 	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len <<
-			 IDPF_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw2 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len <<
-			 IDPF_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw1 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len <<
-			 IDPF_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw0 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len <<
-			 IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 
 		__m256i desc2_3 =
 			_mm256_set_epi64x
@@ -559,8 +549,8 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
-	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
+	uint64_t flags = CI_TX_DESC_CMD_EOP;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
 
 	/* cross rx_thresh boundary is not allowed */
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
@@ -605,8 +595,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
-					 IDPF_TXD_QW1_CMD_S);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index d5e5a2ca5f..49ace35615 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1003,10 +1003,9 @@ static __rte_always_inline void
 idpf_singleq_vtx1(volatile struct ci_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags)
 {
-	uint64_t high_qw =
-		(IDPF_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags  << IDPF_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S));
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
 
 	__m128i descriptor = _mm_set_epi64x(high_qw,
 					    pkt->buf_iova + pkt->data_off);
@@ -1019,8 +1018,7 @@ static __rte_always_inline void
 idpf_singleq_vtx(volatile struct ci_tx_desc *txdp,
 	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
 {
-	const uint64_t hi_qw_tmpl = (IDPF_TX_DESC_DTYPE_DATA  |
-			((uint64_t)flags  << IDPF_TXD_QW1_CMD_S));
+	const uint64_t hi_qw_tmpl = (CI_TX_DESC_DTYPE_DATA  | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
@@ -1030,22 +1028,14 @@ idpf_singleq_vtx(volatile struct ci_tx_desc *txdp,
 
 	/* do 4 at a time while possible, in bursts */
 	for (; nb_pkts > 3; txdp += 4, pkt += 4, nb_pkts -= 4) {
-		uint64_t hi_qw3 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[3]->data_len <<
-			 IDPF_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw2 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[2]->data_len <<
-			 IDPF_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw1 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[1]->data_len <<
-			 IDPF_TXD_QW1_TX_BUF_SZ_S);
-		uint64_t hi_qw0 =
-			hi_qw_tmpl |
-			((uint64_t)pkt[0]->data_len <<
-			 IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
 
 		__m512i desc0_3 =
 			_mm512_set_epi64
@@ -1075,8 +1065,8 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 	volatile struct ci_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
-	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
+	uint64_t flags = CI_TX_DESC_CMD_EOP;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
 
 	/* cross rx_thresh boundary is not allowed */
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
@@ -1124,8 +1114,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 	tx_id = (uint16_t)(tx_id + nb_commit);
 	if (tx_id > txq->tx_next_rs) {
 		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
-					 IDPF_TXD_QW1_CMD_S);
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs =
 			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index b5e8574667..a43d8f78e2 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -32,8 +32,8 @@ idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 		return 1;
 
 	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
-				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
+			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
 }
 
 static inline int
-- 
2.51.0

