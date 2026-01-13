Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F9D2F327
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89B0640687;
	Tue, 13 Jan 2026 16:15:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5959E4067C
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317325; x=1799853325;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4avqm5H+qdn5G14ADL6Uj4kswXd6DsDE8ocXnhJCNXs=;
 b=Ip7e+HMmr4Gs3IQ5luijB1mN9wBsUwC0yjaJKZ79TMl0kGrrGQPyITJx
 2vgFhnlKdKXFhlrSJ9ELEK1nzotfpBkcsB1zIjIxEjjqioJ9BQHvW+TIT
 D7Whazaka/xf23aJZEYTSb0ZmCCH3rap/5nD/nEwrR+mlfm94f8jGpZjc
 LTGb3N2RNq503qvat8Fi1o0/ELR9dTocd+eztgS5Ert2Bomd356aU1S0d
 QJC7vqQTP4iCIJMHa/wriwpOchANIiao8czQH3JAJtTzdEzaESddBdqUA
 coDhTAlhyqimCjeewbDbe8oY3XYrpHOZYZJBN+Wx3zjhIgXfG64Dp56HO w==;
X-CSE-ConnectionGUID: SshjK9rkSaSXPmiq3e7RJg==
X-CSE-MsgGUID: MaSYyKfJSgmwDyKePjm/pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969143"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969143"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:23 -0800
X-CSE-ConnectionGUID: sf1Jr3OKTjKD+GVZtEGnWw==
X-CSE-MsgGUID: 5srSBGmnQ1mCkZPr2uZpug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556559"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:22 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v2 06/36] net/intel: add common fn to calculate needed
 descriptors
Date: Tue, 13 Jan 2026 15:14:30 +0000
Message-ID: <20260113151505.1871271-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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

Multiple drivers used the same logic to calculate how many Tx data
descriptors were needed. Move that calculation to common code. In the
process of updating drivers, fix idpf driver calculation for the TSO
case.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h  | 21 +++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c        | 18 +-----------------
 drivers/net/intel/iavf/iavf_rxtx.c        | 17 +----------------
 drivers/net/intel/ice/ice_rxtx.c          | 18 +-----------------
 drivers/net/intel/idpf/idpf_common_rxtx.c | 21 +++++++++++++++++----
 5 files changed, 41 insertions(+), 54 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index c79210d084..f894cea616 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -64,4 +64,25 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
 	return 0;
 }
 
+static inline uint16_t
+ci_div_roundup16(uint16_t x, uint16_t y)
+{
+	return (uint16_t)((x + y - 1) / y);
+}
+
+/* Calculate the number of TX descriptors needed for each pkt */
+static inline uint16_t
+ci_calc_pkt_desc(const struct rte_mbuf *tx_pkt)
+{
+	uint16_t count = 0;
+
+	while (tx_pkt != NULL) {
+		count += ci_div_roundup16(tx_pkt->data_len, CI_MAX_DATA_PER_TXD);
+		tx_pkt = tx_pkt->next;
+	}
+
+	return count;
+}
+
+
 #endif /* _COMMON_INTEL_TX_SCALAR_FNS_H_ */
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 701129eba3..6598450d8a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1029,21 +1029,6 @@ i40e_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 	return ctx_desc;
 }
 
-/* Calculate the number of TX descriptors needed for each pkt */
-static inline uint16_t
-i40e_calc_pkt_desc(struct rte_mbuf *tx_pkt)
-{
-	struct rte_mbuf *txd = tx_pkt;
-	uint16_t count = 0;
-
-	while (txd != NULL) {
-		count += DIV_ROUND_UP(txd->data_len, CI_MAX_DATA_PER_TXD);
-		txd = txd->next;
-	}
-
-	return count;
-}
-
 uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -1106,8 +1091,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * per tx desc.
 		 */
 		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			nb_used = (uint16_t)(i40e_calc_pkt_desc(tx_pkt) +
-					     nb_ctx);
+			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx);
 		else
 			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
 		tx_last = (uint16_t)(tx_id + nb_used - 1);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 0bf15aae5e..dc4c64d169 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2671,21 +2671,6 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
 		((uint64_t)l2tag1 << IAVF_TXD_DATA_QW1_L2TAG1_SHIFT));
 }
 
-/* Calculate the number of TX descriptors needed for each pkt */
-static inline uint16_t
-iavf_calc_pkt_desc(struct rte_mbuf *tx_pkt)
-{
-	struct rte_mbuf *txd = tx_pkt;
-	uint16_t count = 0;
-
-	while (txd != NULL) {
-		count += (txd->data_len + CI_MAX_DATA_PER_TXD - 1) / CI_MAX_DATA_PER_TXD;
-		txd = txd->next;
-	}
-
-	return count;
-}
-
 static inline void
 iavf_fill_data_desc(volatile struct ci_tx_desc *desc,
 	uint64_t desc_template,	uint16_t buffsz,
@@ -2771,7 +2756,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * per tx desc.
 		 */
 		if (mb->ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			nb_desc_required = iavf_calc_pkt_desc(mb) + nb_desc_ctx + nb_desc_ipsec;
+			nb_desc_required = ci_calc_pkt_desc(mb) + nb_desc_ctx + nb_desc_ipsec;
 		else
 			nb_desc_required = nb_desc_data + nb_desc_ctx + nb_desc_ipsec;
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index b5395a803f..6599e4d57f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3063,21 +3063,6 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 	return ctx_desc;
 }
 
-/* Calculate the number of TX descriptors needed for each pkt */
-static inline uint16_t
-ice_calc_pkt_desc(struct rte_mbuf *tx_pkt)
-{
-	struct rte_mbuf *txd = tx_pkt;
-	uint16_t count = 0;
-
-	while (txd != NULL) {
-		count += DIV_ROUND_UP(txd->data_len, CI_MAX_DATA_PER_TXD);
-		txd = txd->next;
-	}
-
-	return count;
-}
-
 uint16_t
 ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -3140,8 +3125,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * per tx desc.
 		 */
 		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
-			nb_used = (uint16_t)(ice_calc_pkt_desc(tx_pkt) +
-					     nb_ctx);
+			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx);
 		else
 			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
 		tx_last = (uint16_t)(tx_id + nb_used - 1);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 587871b54a..11d6848430 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -934,7 +934,16 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		tx_offload.tso_segsz = tx_pkt->tso_segsz;
 		/* Calculate the number of context descriptors needed. */
 		nb_ctx = idpf_calc_context_desc(ol_flags);
-		nb_used = tx_pkt->nb_segs + nb_ctx;
+
+		/* Calculate the number of TX descriptors needed for
+		 * each packet. For TSO packets, use ci_calc_pkt_desc as
+		 * the mbuf data size might exceed max data size that hw allows
+		 * per tx desc.
+		 */
+		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+			nb_used = ci_calc_pkt_desc(tx_pkt) + nb_ctx;
+		else
+			nb_used = tx_pkt->nb_segs + nb_ctx;
 
 		if (ol_flags & IDPF_TX_CKSUM_OFFLOAD_MASK)
 			cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
@@ -1382,10 +1391,14 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		nb_ctx = idpf_calc_context_desc(ol_flags);
 
 		/* The number of descriptors that must be allocated for
-		 * a packet equals to the number of the segments of that
-		 * packet plus 1 context descriptor if needed.
+		 * a packet. For TSO packets, use ci_calc_pkt_desc as
+		 * the mbuf data size might exceed max data size that hw allows
+		 * per tx desc.
 		 */
-		nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
+		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx);
+		else
+			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
 		tx_last = (uint16_t)(tx_id + nb_used - 1);
 
 		/* Circular ring */
-- 
2.51.0

