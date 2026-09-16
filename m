Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E1C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2209F42ED7;
	Wed, 16 Sep 2026 12:36:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A136E42D83
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789555000; x=1821091000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=COc7Nxz60UgdRIbfmIf/BBpi8W3BEkdtMqwKsG0Sn+s=;
 b=ASRt6JXb+WLfi+aeqLMZoyFmUcz9I3irmlss5IjwriDNkLluQG8q+T3M
 0lATJd5WRGmRNhvljZRF4kmNZxrhDZZvzq8OER288H5tYtnbSMrcN5oMw
 cCJZkFd2ou+xaIvHC13YyjJMbIOZKZGwVrwn/na+tm7EUTUwZLBIbUdTQ
 Fyd7oAIj8qXBO/TLgUJgMO2nngf8G/MKfXEeuNmm3lMQUAX8hKYkQcGsy
 SeoW328I166CGMvvJ1MzwfljohrfTwUDkAHFR1hZ9PlbwITeZKYjLyIOe
 jITMBR4j6JmZgJqmjh4pvY/nnq9SrJJTSOZcaUkm0sTasWeGXea9ydr1d w==;
X-CSE-ConnectionGUID: a7AE7yhnSvuNBMIMxUxixw==
X-CSE-MsgGUID: vJy1goKnSKON56MN7x4RmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867633"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867633"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:40 -0700
X-CSE-ConnectionGUID: NqsBZ8neRZOku3pT/Nauqw==
X-CSE-MsgGUID: BiNH1Xk5QZup9ogSrpiEtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528265"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:38 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 10/15] net/intel: move vector Tx paths to common
Date: Wed, 16 Sep 2026 11:36:17 +0100
Message-ID: <20260916103622.319874-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916103622.319874-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260916103622.319874-1-bruce.richardson@intel.com>
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

The main loops for vector Tx, both avx2 and avx512 are almost identical
across a couple of drivers, so move the iavf copies to common for later
reuse by other drivers.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h                 |  10 ++
 drivers/net/intel/common/tx_vec_x86.h         | 128 ++++++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  75 +---------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  77 +----------
 4 files changed, 148 insertions(+), 142 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index c8fadee712..630df8cb19 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -9,6 +9,8 @@
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <rte_vect.h>
+#include <rte_io.h>
+#include <rte_byteorder.h>
 
 /* Common TX Descriptor QW1 Field Definitions */
 #define CI_TXD_QW1_DTYPE_S      0
@@ -273,6 +275,14 @@ ci_tx_backlog_entry_vec(struct ci_tx_entry_vec *txep, struct rte_mbuf **tx_pkts,
 		txep[i].mbuf = tx_pkts[i];
 }
 
+
+/* Write the Tx tail register, byte-swapped for hardware regardless of host endianness. */
+static __rte_always_inline void
+ci_tx_qtx_tail_write(struct ci_tx_queue *txq, uint16_t tx_id)
+{
+	rte_write32_wc(rte_cpu_to_le_32((uint32_t)tx_id), txq->qtx_tail);
+}
+
 #define IETH_VPMD_TX_MAX_FREE_BUF 64
 
 typedef int (*ci_desc_done_fn)(struct ci_tx_queue *txq, uint16_t idx);
diff --git a/drivers/net/intel/common/tx_vec_x86.h b/drivers/net/intel/common/tx_vec_x86.h
index 56efe1d1ec..946dcc1f2e 100644
--- a/drivers/net/intel/common/tx_vec_x86.h
+++ b/drivers/net/intel/common/tx_vec_x86.h
@@ -345,6 +345,69 @@ ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 				single_vlan_pos, qinq_outer_pos, lldp_check);
 }
 
+static __rte_always_inline uint16_t
+ci_xmit_fixed_burst_vec_avx2(struct ci_tx_queue *txq, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts, bool offload,
+		enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
+{
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, tx_id;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, ci_tx_desc_done_simple, false);
+
+	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
+	if (unlikely(nb_pkts == 0))
+		return 0;
+	nb_commit = nb_pkts;
+
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
+
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+	if (nb_commit >= n) {
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
+
+		ci_vtx_avx2(txdp, tx_pkts, n - 1, flags, offload, single_vlan_pos, qinq_outer_pos);
+		tx_pkts += (n - 1);
+		txdp += (n - 1);
+
+		ci_vtx1(txdp, *tx_pkts++, rs, offload, single_vlan_pos, qinq_outer_pos);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+
+		tx_id = 0;
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+
+		/* avoid reach the end of ring */
+		txdp = &txq->ci_tx_ring[tx_id];
+		txep = &txq->sw_ring_vec[tx_id];
+	}
+
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
+
+	ci_vtx_avx2(txdp, tx_pkts, nb_commit, flags, offload, single_vlan_pos, qinq_outer_pos);
+
+	tx_id = (uint16_t)(tx_id + nb_commit);
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs = (uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+
+	ci_tx_qtx_tail_write(txq, tx_id);
+
+	return nb_pkts;
+}
+
 #endif /* __AVX2__ */
 
 #ifdef __AVX512VL__
@@ -512,6 +575,71 @@ ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 					single_vlan_pos, qinq_outer_pos, lldp_check);
 }
 
+static __rte_always_inline uint16_t
+ci_xmit_fixed_burst_vec_avx512(struct ci_tx_queue *txq, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts, bool offload,
+		enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos)
+{
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, tx_id;
+	/* bit2 is reserved and must be set to 1 according to Spec */
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, ci_tx_desc_done_simple, false);
+
+	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
+	if (unlikely(nb_pkts == 0))
+		return 0;
+	nb_commit = nb_pkts;
+
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
+
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+	if (nb_commit >= n) {
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
+
+		ci_vtx_avx512(txdp, tx_pkts, n - 1, flags, offload,
+				single_vlan_pos, qinq_outer_pos);
+		tx_pkts += (n - 1);
+		txdp += (n - 1);
+
+		ci_vtx1(txdp, *tx_pkts++, rs, offload, single_vlan_pos, qinq_outer_pos);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+
+		tx_id = 0;
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+
+		/* avoid reach the end of ring */
+		txdp = &txq->ci_tx_ring[tx_id];
+		txep = &txq->sw_ring_vec[tx_id];
+	}
+
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
+
+	ci_vtx_avx512(txdp, tx_pkts, nb_commit, flags, offload, single_vlan_pos, qinq_outer_pos);
+
+	tx_id = (uint16_t)(tx_id + nb_commit);
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs = (uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+
+	ci_tx_qtx_tail_write(txq, tx_id);
+
+	return nb_pkts;
+}
+
 #endif /* __AVX512VL__ */
 
 #endif /* _COMMON_INTEL_TX_VEC_X86_H_ */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 813611015d..1289581038 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1617,74 +1617,6 @@ iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload(void *rx_queue,
 }
 
 
-static __rte_always_inline uint16_t
-iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
-			       uint16_t nb_pkts, bool offload)
-{
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ci_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, tx_id;
-	/* bit2 is reserved and must be set to 1 according to Spec */
-	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
-	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
-	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
-	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
-			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
-
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false);
-
-	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	if (unlikely(nb_pkts == 0))
-		return 0;
-	nb_commit = nb_pkts;
-
-	tx_id = txq->tx_tail;
-	txdp = &txq->ci_tx_ring[tx_id];
-	txep = &txq->sw_ring_vec[tx_id];
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-	if (nb_commit >= n) {
-		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
-
-		ci_vtx_avx2(txdp, tx_pkts, n - 1, flags, offload, vlan_pos, vlan_pos);
-		tx_pkts += (n - 1);
-		txdp += (n - 1);
-
-		ci_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		tx_id = 0;
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-
-		/* avoid reach the end of ring */
-		txdp = &txq->ci_tx_ring[tx_id];
-		txep = &txq->sw_ring_vec[tx_id];
-	}
-
-	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
-
-	ci_vtx_avx2(txdp, tx_pkts, nb_commit, flags, offload, vlan_pos, vlan_pos);
-
-	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->tx_next_rs) {
-		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	IAVF_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
 static __rte_always_inline uint64_t
 iavf_tx_ctx_lldp_check(struct rte_mbuf *pkt, uint64_t high_ctx_qw)
 {
@@ -1809,14 +1741,17 @@ iavf_xmit_pkts_vec_avx2_common(void *tx_queue, struct rte_mbuf **tx_pkts,
 {
 	uint16_t nb_tx = 0;
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
+	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
 
 		/* cross rs_thresh boundary is not allowed */
 		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-		ret = iavf_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_tx],
-						     num, offload);
+		ret = ci_xmit_fixed_burst_vec_avx2(txq, &tx_pkts[nb_tx], num,
+				offload, vlan_pos, vlan_pos);
 		nb_tx += ret;
 		nb_pkts -= ret;
 		if (ret < num)
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index fe00416660..9f773f226b 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1830,76 +1830,6 @@ tx_backlog_entry_avx512(struct ci_tx_entry_vec *txep,
 #define IAVF_TX_LEN_MASK 0xAA
 #define IAVF_TX_OFF_MASK 0x55
 
-static __rte_always_inline uint16_t
-iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
-				 uint16_t nb_pkts, bool offload)
-{
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ci_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, tx_id;
-	/* bit2 is reserved and must be set to 1 according to Spec */
-	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
-	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
-	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
-	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
-			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
-
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, false);
-
-	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	if (unlikely(nb_pkts == 0))
-		return 0;
-	nb_commit = nb_pkts;
-
-	tx_id = txq->tx_tail;
-	txdp = &txq->ci_tx_ring[tx_id];
-	txep = (void *)txq->sw_ring;
-	txep += tx_id;
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-	if (nb_commit >= n) {
-		tx_backlog_entry_avx512(txep, tx_pkts, n);
-
-		ci_vtx_avx512(txdp, tx_pkts, n - 1, flags, offload, vlan_pos, vlan_pos);
-		tx_pkts += (n - 1);
-		txdp += (n - 1);
-
-		ci_vtx1(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		tx_id = 0;
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-
-		/* avoid reach the end of ring */
-		txdp = &txq->ci_tx_ring[tx_id];
-		txep = (void *)txq->sw_ring;
-		txep += tx_id;
-	}
-
-	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
-
-	ci_vtx_avx512(txdp, tx_pkts, nb_commit, flags, offload, vlan_pos, vlan_pos);
-
-	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->tx_next_rs) {
-		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	IAVF_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
 static __rte_always_inline uint64_t
 iavf_tx_ctx_lldp_check(struct rte_mbuf *pkt, uint64_t high_ctx_qw)
 {
@@ -1985,14 +1915,17 @@ iavf_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 {
 	uint16_t nb_tx = 0;
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
+	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
 
 		/* cross rs_thresh boundary is not allowed */
 		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-		ret = iavf_xmit_fixed_burst_vec_avx512(tx_queue, &tx_pkts[nb_tx],
-						       num, offload);
+		ret = ci_xmit_fixed_burst_vec_avx512(txq, &tx_pkts[nb_tx], num,
+				offload, vlan_pos, vlan_pos);
 		nb_tx += ret;
 		nb_pkts -= ret;
 		if (ret < num)
-- 
2.53.0

