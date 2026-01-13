Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE33D2F327
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BA2940A67;
	Tue, 13 Jan 2026 16:15:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 81D2040696
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317328; x=1799853328;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SJhPcX42rbwjJdh48tebi/4mPXWwrX90wd4VSBX0DNw=;
 b=MLHtOD502JwLuYorf0bgdJ/sD03kHXxUarA9qRGWzqn9Oj+/Gj02pN7N
 adORwJ6HQtANvGf7BN+rIR0cvu83HXyaTuRyGI68SZ+PJPWm91W8iW2+k
 c/ektp3c90HK4SxEQrsMdZ3sPpDFarOc1wRQrlLZyBoqXl19RP0EQSSxn
 OawxAcSx8d7m54cYgm5RNS4LJeoy1JJ0P/EXqDVgcD5NN2VxwEaDCfweZ
 1Ldy5ZAJ5uj79BVkyK9hKlB5bAwRfNZRVtBwJRmsh1bdIS51pOIJFAdWc
 CgqHEFCPF3yavHWdTd2ppYFKYZ75uTTZo8CHgtXP1YlV9BWpWd6AoZm9T Q==;
X-CSE-ConnectionGUID: qmX9cqmwSsW3gWRZT7TGkw==
X-CSE-MsgGUID: 9oecWcBATmWra2cx+7fWQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969158"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969158"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:27 -0800
X-CSE-ConnectionGUID: RnpGmOWgSviYr7CqiB23pA==
X-CSE-MsgGUID: CArTk7jBS8ueZJCrI/kDSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556575"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:26 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v2 09/36] net/idpf: refactor context descriptor handling
Date: Tue, 13 Jan 2026 15:14:33 +0000
Message-ID: <20260113151505.1871271-10-bruce.richardson@intel.com>
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

move all context descriptor handling to a single function, as with the
ice driver.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.c | 61 +++++++++++------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 11d6848430..9219ad9047 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -845,37 +845,36 @@ idpf_calc_context_desc(uint64_t flags)
 	return 0;
 }
 
-/* set TSO context descriptor
+/* set TSO context descriptor, returns 0 if no context needed, 1 if context set
  */
-static inline void
-idpf_set_splitq_tso_ctx(struct rte_mbuf *mbuf,
+static inline uint16_t
+idpf_set_tso_ctx(uint64_t ol_flags, struct rte_mbuf *mbuf,
 			union ci_tx_offload tx_offload,
-			volatile union idpf_flex_tx_ctx_desc *ctx_desc)
+			uint64_t *qw0, uint64_t *qw1)
 {
-	uint16_t cmd_dtype;
+	uint16_t cmd_dtype = IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX | IDPF_TX_FLEX_CTX_DESC_CMD_TSO;
+	uint16_t tso_segsz = mbuf->tso_segsz;
 	uint32_t tso_len;
 	uint8_t hdr_len;
 
+	if (idpf_calc_context_desc(ol_flags) == 0)
+		return 0;
+
+	/* TSO context descriptor setup */
 	if (tx_offload.l4_len == 0) {
 		TX_LOG(DEBUG, "L4 length set to 0");
-		return;
+		return 0;
 	}
 
-	hdr_len = tx_offload.l2_len +
-		tx_offload.l3_len +
-		tx_offload.l4_len;
-	cmd_dtype = IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX |
-		IDPF_TX_FLEX_CTX_DESC_CMD_TSO;
+	hdr_len = tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len;
 	tso_len = mbuf->pkt_len - hdr_len;
 
-	ctx_desc->tso.qw1.cmd_dtype = rte_cpu_to_le_16(cmd_dtype);
-	ctx_desc->tso.qw0.hdr_len = hdr_len;
-	ctx_desc->tso.qw0.mss_rt =
-		rte_cpu_to_le_16((uint16_t)mbuf->tso_segsz &
-				 IDPF_TXD_FLEX_CTX_MSS_RT_M);
-	ctx_desc->tso.qw0.flex_tlen =
-		rte_cpu_to_le_32(tso_len &
-				 IDPF_TXD_FLEX_CTX_MSS_RT_M);
+	*qw0 = rte_cpu_to_le_32(tso_len & IDPF_TXD_FLEX_CTX_MSS_RT_M) |
+	       ((uint64_t)rte_cpu_to_le_16(tso_segsz & IDPF_TXD_FLEX_CTX_MSS_RT_M) << 32) |
+	       ((uint64_t)hdr_len << 48);
+	*qw1 = rte_cpu_to_le_16(cmd_dtype);
+
+	return 1;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts)
@@ -933,7 +932,8 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		tx_offload.l4_len = tx_pkt->l4_len;
 		tx_offload.tso_segsz = tx_pkt->tso_segsz;
 		/* Calculate the number of context descriptors needed. */
-		nb_ctx = idpf_calc_context_desc(ol_flags);
+		uint64_t cd_qw0, cd_qw1;
+		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, tx_offload, &cd_qw0, &cd_qw1);
 
 		/* Calculate the number of TX descriptors needed for
 		 * each packet. For TSO packets, use ci_calc_pkt_desc as
@@ -950,12 +950,10 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		/* context descriptor */
 		if (nb_ctx != 0) {
-			volatile union idpf_flex_tx_ctx_desc *ctx_desc =
-				(volatile union idpf_flex_tx_ctx_desc *)&txr[tx_id];
+			uint64_t *ctx_desc = RTE_CAST_PTR(uint64_t *, &txr[tx_id]);
 
-			if ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) != 0)
-				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
-							ctx_desc);
+			ctx_desc[0] = cd_qw0;
+			ctx_desc[1] = cd_qw1;
 
 			tx_id++;
 			if (tx_id == txq->nb_tx_desc)
@@ -1388,7 +1386,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		tx_offload.l4_len = tx_pkt->l4_len;
 		tx_offload.tso_segsz = tx_pkt->tso_segsz;
 		/* Calculate the number of context descriptors needed. */
-		nb_ctx = idpf_calc_context_desc(ol_flags);
+		uint64_t cd_qw0, cd_qw1;
+		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, tx_offload, &cd_qw0, &cd_qw1);
 
 		/* The number of descriptors that must be allocated for
 		 * a packet. For TSO packets, use ci_calc_pkt_desc as
@@ -1431,9 +1430,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		if (nb_ctx != 0) {
 			/* Setup TX context descriptor if required */
-			volatile union idpf_flex_tx_ctx_desc *ctx_txd =
-				(volatile union idpf_flex_tx_ctx_desc *)
-				&txr[tx_id];
+			uint64_t *ctx_txd = RTE_CAST_PTR(uint64_t *, &txr[tx_id]);
 
 			txn = &sw_ring[txe->next_id];
 			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
@@ -1442,10 +1439,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				txe->mbuf = NULL;
 			}
 
-			/* TSO enabled */
-			if ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) != 0)
-				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
-							ctx_txd);
+			ctx_txd[0] = cd_qw0;
+			ctx_txd[1] = cd_qw1;
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
-- 
2.51.0

