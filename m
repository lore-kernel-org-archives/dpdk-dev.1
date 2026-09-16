Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F7FC88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2928142EC5;
	Wed, 16 Sep 2026 12:36:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B23DD42E95
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789554997; x=1821090997;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V/iXeK3UdQbdhLS8VqdOd4n2kX4FC7Y64MG4NOPSMxs=;
 b=kAG60SwXusZsQGi5tu34Tj33mtar191OUKkKmXuLgcilA3LgZuUn4oUt
 a37cLsXHTrsjtJ0fRtZrT12jVZtJMDKyjiMPu3gt9JsJSzXtUG4ars2O7
 Dczj1NePuKFM9zpYbE0Ku2lgA38bgff9cEw5TsGMi94P0z7ssYKU2OxEs
 E5M+OEW6npxzcdRAUIumRSjt10+O3z6WfxftaUpAgDcpTOuf+gTQdPrPb
 80bTQSlng/vd4bRwbL0ksAH4PMEGuAs+p3LK7tPechmCrfbekKg3OU91o
 peuE6MCgjN6Fj/9byQ2UsNB/fd3DIjJoTk4ZawUu1UviTmdDSZk6Yv+nl A==;
X-CSE-ConnectionGUID: e5y+8yCZTrKLgnRS9B4JKw==
X-CSE-MsgGUID: jATNiKlkSX+CERyNN2jYjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867630"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867630"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:36 -0700
X-CSE-ConnectionGUID: EicV7I2SR+6/X38ruF2k6w==
X-CSE-MsgGUID: TvLaqudSSmKkBi2V7gT0TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528179"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 07/15] net/intel: use function callback for lldp
Date: Wed, 16 Sep 2026 11:36:14 +0100
Message-ID: <20260916103622.319874-8-bruce.richardson@intel.com>
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

Limit LLDP support for iavf drivers for now, by using a callback to
handle its processing. Drivers not supporting this pass a NULL pointer
and the compiler will optimize away the branches. For iavf, the compiler
can inline the subfunction directly as it's known at compile-time.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx_vec_x86.h         | 42 +++++++++++--------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 16 +++++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 17 +++++---
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/net/intel/common/tx_vec_x86.h b/drivers/net/intel/common/tx_vec_x86.h
index 36e855eb26..0c6c60a21e 100644
--- a/drivers/net/intel/common/tx_vec_x86.h
+++ b/drivers/net/intel/common/tx_vec_x86.h
@@ -11,6 +11,12 @@
 
 #include "tx.h"
 
+/* Optional per-driver LLDP switch-uplink check for ctx descriptors.
+ * Takes the ctx-desc high qword and returns it with the LLDP bit applied
+ * if appropriate. NULL disables the check.
+ */
+typedef uint64_t (*ci_tx_ctx_lldp_fn)(struct rte_mbuf *pkt, uint64_t high_ctx_qw);
+
 static __rte_always_inline void
 ci_fill_ctx_desc_tunneling(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 {
@@ -226,7 +232,7 @@ ci_vtx_avx2(volatile struct ci_tx_desc *txdp,
 static __rte_always_inline void
 ci_vtx1_ctx_avx2(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
-		enum ci_l2tag_pos qinq_outer_pos, bool ptype_lldp_enabled)
+		enum ci_l2tag_pos qinq_outer_pos, ci_tx_ctx_lldp_fn lldp_check)
 {
 	uint64_t high_ctx_qw = CI_TX_DESC_DTYPE_CTX;
 	uint64_t low_ctx_qw = 0;
@@ -245,8 +251,8 @@ ci_vtx1_ctx_avx2(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 			low_ctx_qw |= (uint64_t)pkt->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 		}
 	}
-	if (IAVF_CHECK_TX_LLDP(pkt, ptype_lldp_enabled))
-		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+	if (lldp_check != NULL)
+		high_ctx_qw = lldp_check(pkt, high_ctx_qw);
 	uint64_t high_data_qw = (CI_TX_DESC_DTYPE_DATA |
 			((uint64_t)flags  << CI_TXD_QW1_CMD_S) |
 			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
@@ -264,7 +270,7 @@ static __rte_always_inline void
 ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags,
 		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
-		bool ptype_lldp_enabled)
+		ci_tx_ctx_lldp_fn lldp_check)
 {
 	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags  << CI_TXD_QW1_CMD_S));
 
@@ -298,8 +304,8 @@ ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 			}
 		}
-		if (IAVF_CHECK_TX_LLDP(pkt[1], ptype_lldp_enabled))
-			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+		if (lldp_check != NULL)
+			hi_ctx_qw1 = lldp_check(pkt[1], hi_ctx_qw1);
 
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
@@ -316,8 +322,8 @@ ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 			}
 		}
-		if (IAVF_CHECK_TX_LLDP(pkt[0], ptype_lldp_enabled))
-			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+		if (lldp_check != NULL)
+			hi_ctx_qw0 = lldp_check(pkt[0], hi_ctx_qw0);
 
 		if (offload) {
 			ci_tx_vec_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
@@ -336,7 +342,7 @@ ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 
 	if (nb_pkts)
 		ci_vtx1_ctx_avx2(txdp, *pkt, flags, offload,
-				single_vlan_pos, qinq_outer_pos, ptype_lldp_enabled);
+				single_vlan_pos, qinq_outer_pos, lldp_check);
 }
 
 #endif /* __AVX2__ */
@@ -396,7 +402,7 @@ ci_vtx_avx512(volatile struct ci_tx_desc *txdp,
 static __rte_always_inline void
 ci_vtx1_ctx_avx512(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
-		enum ci_l2tag_pos qinq_outer_pos, bool lldp_enabled)
+		enum ci_l2tag_pos qinq_outer_pos, ci_tx_ctx_lldp_fn lldp_check)
 {
 	uint64_t high_ctx_qw = CI_TX_DESC_DTYPE_CTX;
 	uint64_t low_ctx_qw = 0;
@@ -415,8 +421,8 @@ ci_vtx1_ctx_avx512(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 			low_ctx_qw |= (uint64_t)pkt->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 		}
 	}
-	if (IAVF_CHECK_TX_LLDP(pkt, lldp_enabled))
-		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+	if (lldp_check != NULL)
+		high_ctx_qw = lldp_check(pkt, high_ctx_qw);
 	uint64_t high_data_qw = (CI_TX_DESC_DTYPE_DATA |
 			((uint64_t)flags << CI_TXD_QW1_CMD_S) |
 			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
@@ -435,7 +441,7 @@ static __rte_always_inline void
 ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
 		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
-		bool lldp_enabled)
+		ci_tx_ctx_lldp_fn lldp_check)
 {
 	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
@@ -467,8 +473,8 @@ ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 			}
 		}
-		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_enabled))
-			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+		if (lldp_check != NULL)
+			hi_ctx_qw1 = lldp_check(pkt[1], hi_ctx_qw1);
 
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
@@ -485,8 +491,8 @@ ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 			}
 		}
-		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_enabled))
-			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+		if (lldp_check != NULL)
+			hi_ctx_qw0 = lldp_check(pkt[0], hi_ctx_qw0);
 
 		if (offload) {
 			ci_tx_vec_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
@@ -503,7 +509,7 @@ ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 
 	if (nb_pkts)
 		ci_vtx1_ctx_avx512(txdp, *pkt, flags, offload,
-				single_vlan_pos, qinq_outer_pos, lldp_enabled);
+					single_vlan_pos, qinq_outer_pos, lldp_check);
 }
 
 #endif /* __AVX512VL__ */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 1d0492edd9..813611015d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1685,6 +1685,14 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_pkts;
 }
 
+static __rte_always_inline uint64_t
+iavf_tx_ctx_lldp_check(struct rte_mbuf *pkt, uint64_t high_ctx_qw)
+{
+	if (IAVF_CHECK_TX_LLDP(pkt, true))
+		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+	return high_ctx_qw;
+}
+
 static __rte_always_inline uint16_t
 iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts, bool offload)
@@ -1696,7 +1704,7 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t flags = IAVF_TX_DESC_CMD_EOP | IAVF_TX_DESC_CMD_ICRC;
 	uint64_t rs = IAVF_TX_DESC_CMD_RS | flags;
-	bool lldp_enabled = txq->lldp_enabled;
+	ci_tx_ctx_lldp_fn lldp_check = txq->lldp_enabled ? iavf_tx_ctx_lldp_check : NULL;
 	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
 	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
 			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
@@ -1723,10 +1731,10 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
 
 		ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf - 1, flags, offload,
-				vlan_pos, vlan_pos, lldp_enabled);
+				vlan_pos, vlan_pos, lldp_check);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ci_vtx1_ctx_avx2(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_enabled);
+		ci_vtx1_ctx_avx2(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_check);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -1740,7 +1748,7 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
 
-	ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
+	ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_check);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 0c738e4882..fe00416660 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1900,6 +1900,14 @@ iavf_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_pkts;
 }
 
+static __rte_always_inline uint64_t
+iavf_tx_ctx_lldp_check(struct rte_mbuf *pkt, uint64_t high_ctx_qw)
+{
+	if (IAVF_CHECK_TX_LLDP(pkt, true))
+		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+	return high_ctx_qw;
+}
+
 static __rte_always_inline uint16_t
 iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts, bool offload)
@@ -1911,7 +1919,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
 	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
-	bool lldp_enabled = txq->lldp_enabled;
+	ci_tx_ctx_lldp_fn lldp_check = txq->lldp_enabled ? iavf_tx_ctx_lldp_check : NULL;
 	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
 	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
 			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
@@ -1938,11 +1946,10 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
 		ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf - 1, flags, offload,
-				vlan_pos, vlan_pos, lldp_enabled);
+				vlan_pos, vlan_pos, lldp_check);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ci_vtx1_ctx_avx512(txdp, *tx_pkts++, rs, offload,
-				vlan_pos, vlan_pos, lldp_enabled);
+		ci_vtx1_ctx_avx512(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_check);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -1956,7 +1963,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-	ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_enabled);
+	ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_check);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
-- 
2.53.0

