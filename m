Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B9C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 17:02:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A20B40647;
	Thu,  3 Sep 2026 19:02:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 76646427BA
 for <dev@dpdk.org>; Thu,  3 Sep 2026 19:02:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788454931; x=1819990931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RJNh79J3ghvrEbn9/EAEhHksglPloKWX4yzlx18tcRE=;
 b=J88Cj+mx2f+RGh3Sm/PXiTpql6BDH82I/jP4F1qeji2dj72mJlqT58gO
 +RVKlUaYSMVqJ0wLv8tUkkcgrsFoiwNxn/cQ2q2CSDG4dHyVlTUbaDU2Q
 yXR8UU9CCNOKH0cqpc2U6BrZMQSqKILHYX+qfweXivsq9AckJuDEfBI4H
 uKJgvLwGrnAQLONcFEkS8dh46WTFkjQ/XoBNPcVq6CNu10keukhRb/yjr
 MNmvrj3Nt02vcoPV401X8675oQFdnQrkimhr8updLXah9Ayw5yLmyQndS
 jDCA1ubek4rkH41R0ESzS4bIB/8OfoWjNKhHlfjgNBdKOhHBgVzznZYGk w==;
X-CSE-ConnectionGUID: ck/5gWIyQMyIUGUDcUgtlg==
X-CSE-MsgGUID: Lbn2/CpFSpe6yMkPn1x1vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100463003"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="100463003"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 10:01:54 -0700
X-CSE-ConnectionGUID: 9Aghh0BrRVOhZurAzUu2Tg==
X-CSE-MsgGUID: gC3h8bNPT86gcRUmZ3TyXA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2026 10:01:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 07/13] net/intel: use function callback for lldp
Date: Thu,  3 Sep 2026 18:01:36 +0100
Message-ID: <20260903170140.360477-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903170140.360477-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
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
---
 drivers/net/intel/common/tx_vec_x86.h         | 42 +++++++++++--------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 16 +++++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 17 +++++---
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/net/intel/common/tx_vec_x86.h b/drivers/net/intel/common/tx_vec_x86.h
index b65bc9fc78..f769765cba 100644
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
@@ -228,7 +234,7 @@ ci_vtx_avx2(volatile struct ci_tx_desc *txdp,
 static __rte_always_inline void
 ci_vtx1_ctx_avx2(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
-		enum ci_l2tag_pos qinq_outer_pos, bool ptype_lldp_enabled)
+		enum ci_l2tag_pos qinq_outer_pos, ci_tx_ctx_lldp_fn lldp_check)
 {
 	uint64_t high_ctx_qw = CI_TX_DESC_DTYPE_CTX;
 	uint64_t low_ctx_qw = 0;
@@ -247,8 +253,8 @@ ci_vtx1_ctx_avx2(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
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
@@ -266,7 +272,7 @@ static __rte_always_inline void
 ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags,
 		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
-		bool ptype_lldp_enabled)
+		ci_tx_ctx_lldp_fn lldp_check)
 {
 	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags  << CI_TXD_QW1_CMD_S));
 
@@ -300,8 +306,8 @@ ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 			}
 		}
-		if (IAVF_CHECK_TX_LLDP(pkt[1], ptype_lldp_enabled))
-			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+		if (lldp_check != NULL)
+			hi_ctx_qw1 = lldp_check(pkt[1], hi_ctx_qw1);
 
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
@@ -318,8 +324,8 @@ ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 			}
 		}
-		if (IAVF_CHECK_TX_LLDP(pkt[0], ptype_lldp_enabled))
-			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+		if (lldp_check != NULL)
+			hi_ctx_qw0 = lldp_check(pkt[0], hi_ctx_qw0);
 
 		if (offload) {
 			ci_tx_vec_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
@@ -338,7 +344,7 @@ ci_vtx_ctx_avx2(volatile struct ci_tx_desc *txdp,
 
 	if (nb_pkts)
 		ci_vtx1_ctx_avx2(txdp, *pkt, flags, offload,
-				single_vlan_pos, qinq_outer_pos, ptype_lldp_enabled);
+				single_vlan_pos, qinq_outer_pos, lldp_check);
 }
 
 #endif /* __AVX2__ */
@@ -398,7 +404,7 @@ ci_vtx_avx512(volatile struct ci_tx_desc *txdp,
 static __rte_always_inline void
 ci_vtx1_ctx_avx512(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
-		enum ci_l2tag_pos qinq_outer_pos, bool lldp_enabled)
+		enum ci_l2tag_pos qinq_outer_pos, ci_tx_ctx_lldp_fn lldp_check)
 {
 	uint64_t high_ctx_qw = CI_TX_DESC_DTYPE_CTX;
 	uint64_t low_ctx_qw = 0;
@@ -417,8 +423,8 @@ ci_vtx1_ctx_avx512(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
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
@@ -437,7 +443,7 @@ static __rte_always_inline void
 ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
 		bool offload, enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
-		bool lldp_enabled)
+		ci_tx_ctx_lldp_fn lldp_check)
 {
 	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
@@ -469,8 +475,8 @@ ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 			}
 		}
-		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_enabled))
-			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+		if (lldp_check != NULL)
+			hi_ctx_qw1 = lldp_check(pkt[1], hi_ctx_qw1);
 
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
@@ -487,8 +493,8 @@ ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci << CI_TXD_CTX_QW0_L2TAG2_S;
 			}
 		}
-		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_enabled))
-			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
+		if (lldp_check != NULL)
+			hi_ctx_qw0 = lldp_check(pkt[0], hi_ctx_qw0);
 
 		if (offload) {
 			ci_tx_vec_offload(pkt[1], &hi_data_qw1, single_vlan_pos, qinq_outer_pos);
@@ -505,7 +511,7 @@ ci_vtx_ctx_avx512(volatile struct ci_tx_desc *txdp,
 
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

