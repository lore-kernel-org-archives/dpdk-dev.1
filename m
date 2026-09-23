Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80242C982FE
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5B8642ECF;
	Wed, 23 Sep 2026 03:08:05 +0200 (CEST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mails.dpdk.org (Postfix) with ESMTP id B78C942EC5
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:08:02 +0200 (CEST)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso320650a12.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125682; x=1790730482; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kvxx+Sdl9VZE4M7vShLsgK+5x2EP1wHObdqbcffWyFk=;
 b=j8mO2dx+wme7mFq85UJDem+cEG5gu/cS082dVfwHZWS0y5/MPqKvv9s7VCJIjgq6Da
 R7nkGAdB8PMLxx1og1KkAqD1rkGZE0hWDFm9fwRbCywNx0iu19Gsx2Ere7g1BUAbs/ZU
 BiHsPxJarDBhSOm9JoCI0jxGfxIHJRlHVrhnqn9Gpp1WGQOIVE2SWCSP6r31PnRhFBYj
 xdG4VQCPz7D2EUQ1jz+lJvGjKVG8mEm1pDCUg88Rz1G59SUMZx1gPnjpz4qyi9R0iHhu
 bnXXsrz0NzNXEDIldxwnU2Xd1f9+M6HxL9aAHGCI0nP1ad429RPC8Y5XYHNSAng9ocg0
 p9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125682; x=1790730482;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kvxx+Sdl9VZE4M7vShLsgK+5x2EP1wHObdqbcffWyFk=;
 b=agMyuUbxCQtKi/TBqR9A0S5C4LMb/w+mlVSOv2ihOjj6Pby1OCmmXMGmR5Rv067ov5
 nvK4vBVCtGuhqNx60LW1BR2iGwcg3e0J1mAuyxDAhZWPcdvBtj1ghiRamGFfcbd4koMF
 QzHJmcPTrKX1uDDO96WI1aQdCGwTQ1RVIdCG6G+VerALohbGZxRT1g3c1oYyb7AKUhXX
 U5P3rWgE8TZfLrw9E6BkGraHDrs6ioktX29fTggCfnK2t0UOZ5THpIR+rDYRKhEmK14g
 W1Z5ggyxejFnSXC68HRLgmE1Zc9SSJS58DTybHvoB8IfAReSqg95rsWVKmn5aqCrPPF2
 GQaw==
X-Gm-Message-State: AFuF++nTaCmPBu3iU2279VO6deFbCJW+Rf5mPx/tkB4stZN8VQ3/UuDq
 WZngtl9GSvsKol5k0HlCSNVN0bE9s5Fxzp992uJKVA9f/MQNBgtrdBF2V7B3bIA+WfbEqHzYdwV
 NLiazDFwZGClVjA==
X-Received: from pgvz26.prod.google.com ([2002:a65:665a:0:b0:cc4:2728:8938])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d489:b0:3dd:d91d:e2bf with SMTP id
 adf61e73a8af0-3ddf830c17emr972913637.73.1790125681647; 
 Tue, 22 Sep 2026 18:08:01 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:33 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-11-joshwash@google.com>
Subject: [PATCH v3 10/16] net/cxgbe: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v3:
  - Leave call sites in base/ alone and map DIV_ROUND_UP to
    RTE_DIV_ROUND_UP in cxgbe_compat.h.
---
 drivers/net/cxgbe/cxgbe_compat.h |  2 +-
 drivers/net/cxgbe/cxgbe_filter.c |  6 +++---
 drivers/net/cxgbe/cxgbe_ofld.h   |  4 ++--
 drivers/net/cxgbe/sge.c          | 14 +++++++-------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/cxgbe/cxgbe_compat.h b/drivers/net/cxgbe/cxgbe_compat.h
index e74d476f6d..8c03a07fde 100644
--- a/drivers/net/cxgbe/cxgbe_compat.h
+++ b/drivers/net/cxgbe/cxgbe_compat.h
@@ -166,7 +166,7 @@ typedef uint64_t  dma_addr_t;
 typedef char *caddr_t;
 #endif
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+#define DIV_ROUND_UP(n, d) RTE_DIV_ROUND_UP(n, d)
 #define DELAY(x) rte_delay_us(x)
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
diff --git a/drivers/net/cxgbe/cxgbe_filter.c b/drivers/net/cxgbe/cxgbe_filter.c
index 5a7efe7a73..83f86a747a 100644
--- a/drivers/net/cxgbe/cxgbe_filter.c
+++ b/drivers/net/cxgbe/cxgbe_filter.c
@@ -219,7 +219,7 @@ static inline void mk_set_tcb_field_ulp(struct filter_entry *f,
 
 	txpkt->cmd_dest = cpu_to_be32(V_ULPTX_CMD(ULP_TX_PKT) |
 				      V_ULP_TXPKT_DEST(0));
-	txpkt->len = cpu_to_be32(DIV_ROUND_UP(sizeof(*req), 16));
+	txpkt->len = cpu_to_be32(RTE_DIV_ROUND_UP(sizeof(*req), 16));
 	sc->cmd_more = cpu_to_be32(V_ULPTX_CMD(ULP_TX_SC_IMM));
 	sc->len = cpu_to_be32(sizeof(*req) - sizeof(struct work_request_hdr));
 	OPCODE_TID(req) = cpu_to_be32(MK_OPCODE_TID(CPL_SET_TCB_FIELD, f->tid));
@@ -371,7 +371,7 @@ static void mk_abort_req_ulp(struct cpl_abort_req *abort_req,
 
 	txpkt->cmd_dest = cpu_to_be32(V_ULPTX_CMD(ULP_TX_PKT) |
 				      V_ULP_TXPKT_DEST(0));
-	txpkt->len = cpu_to_be32(DIV_ROUND_UP(sizeof(*abort_req), 16));
+	txpkt->len = cpu_to_be32(RTE_DIV_ROUND_UP(sizeof(*abort_req), 16));
 	sc->cmd_more = cpu_to_be32(V_ULPTX_CMD(ULP_TX_SC_IMM));
 	sc->len = cpu_to_be32(sizeof(*abort_req) -
 			      sizeof(struct work_request_hdr));
@@ -395,7 +395,7 @@ static void mk_abort_rpl_ulp(struct cpl_abort_rpl *abort_rpl,
 
 	txpkt->cmd_dest = cpu_to_be32(V_ULPTX_CMD(ULP_TX_PKT) |
 				      V_ULP_TXPKT_DEST(0));
-	txpkt->len = cpu_to_be32(DIV_ROUND_UP(sizeof(*abort_rpl), 16));
+	txpkt->len = cpu_to_be32(RTE_DIV_ROUND_UP(sizeof(*abort_rpl), 16));
 	sc->cmd_more = cpu_to_be32(V_ULPTX_CMD(ULP_TX_SC_IMM));
 	sc->len = cpu_to_be32(sizeof(*abort_rpl) -
 			      sizeof(struct work_request_hdr));
diff --git a/drivers/net/cxgbe/cxgbe_ofld.h b/drivers/net/cxgbe/cxgbe_ofld.h
index fd1e7d8002..ef56eef426 100644
--- a/drivers/net/cxgbe/cxgbe_ofld.h
+++ b/drivers/net/cxgbe/cxgbe_ofld.h
@@ -14,7 +14,7 @@
 	(w)->wr.wr_hi = cpu_to_be32(V_FW_WR_OP(FW_TP_WR) | \
 				V_FW_WR_IMMDLEN(sizeof(*w) - sizeof(w->wr))); \
 	(w)->wr.wr_mid = cpu_to_be32( \
-				V_FW_WR_LEN16(DIV_ROUND_UP(sizeof(*w), 16)) | \
+				V_FW_WR_LEN16(RTE_DIV_ROUND_UP(sizeof(*w), 16)) | \
 				V_FW_WR_FLOWID(tid)); \
 	(w)->wr.wr_lo = cpu_to_be64(0); \
 } while (0)
@@ -27,7 +27,7 @@
 #define INIT_ULPTX_WR(w, wrlen, atomic, tid) do { \
 	(w)->wr.wr_hi = cpu_to_be32(V_FW_WR_OP(FW_ULPTX_WR) | \
 				    V_FW_WR_ATOMIC(atomic)); \
-	(w)->wr.wr_mid = cpu_to_be32(V_FW_WR_LEN16(DIV_ROUND_UP(wrlen, 16)) | \
+	(w)->wr.wr_mid = cpu_to_be32(V_FW_WR_LEN16(RTE_DIV_ROUND_UP(wrlen, 16)) | \
 				     V_FW_WR_FLOWID(tid)); \
 	(w)->wr.wr_lo = cpu_to_be64(0); \
 } while (0)
diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c
index e9d45f24c4..eb25d80e33 100644
--- a/drivers/net/cxgbe/sge.c
+++ b/drivers/net/cxgbe/sge.c
@@ -459,7 +459,7 @@ static inline unsigned int sgl_len(unsigned int n)
  */
 static inline unsigned int flits_to_desc(unsigned int n)
 {
-	return DIV_ROUND_UP(n, 8);
+	return RTE_DIV_ROUND_UP(n, 8);
 }
 
 /**
@@ -505,7 +505,7 @@ static inline unsigned int calc_tx_flits(const struct rte_mbuf *m,
 
 	hdrlen = is_eth_imm(m);
 	if (hdrlen)
-		return DIV_ROUND_UP(m->pkt_len + hdrlen, sizeof(__be64));
+		return RTE_DIV_ROUND_UP(m->pkt_len + hdrlen, sizeof(__be64));
 
 	/*
 	 * Otherwise, we're going to have to construct a Scatter gather list
@@ -779,7 +779,7 @@ static inline void ship_tx_pkt_coalesce_wr(struct adapter *adap,
 	wr = (void *)&q->desc[q->pidx];
 	vmwr = (void *)&q->desc[q->pidx];
 
-	wr_mid = V_FW_WR_LEN16(DIV_ROUND_UP(q->coalesce.flits, 2));
+	wr_mid = V_FW_WR_LEN16(RTE_DIV_ROUND_UP(q->coalesce.flits, 2));
 	ndesc = flits_to_desc(q->coalesce.flits);
 	wr->equiq_to_len16 = htonl(wr_mid);
 	wr->plen = cpu_to_be16(q->coalesce.len);
@@ -866,7 +866,7 @@ static inline int should_tx_packet_coalesce(struct sge_eth_txq *txq,
 
 	/* If coalescing is on, the mbuf is added to a pkts WR */
 	if (q->coalesce.idx) {
-		ndesc = DIV_ROUND_UP(q->coalesce.flits + flits, 8);
+		ndesc = RTE_DIV_ROUND_UP(q->coalesce.flits + flits, 8);
 		credits = txq_avail(q) - ndesc;
 
 		if (unlikely(wraps_around(q, ndesc)))
@@ -950,7 +950,7 @@ static inline int tx_do_packet_coalesce(struct sge_eth_txq *txq,
 		mc->cmd_dest = htonl(V_ULPTX_CMD(4) | V_ULP_TXPKT_DEST(0) |
 				     V_ULP_TXPKT_FID(adap->sge.fw_evtq.cntxt_id) |
 				     F_ULP_TXPKT_RO);
-		mc->len = htonl(DIV_ROUND_UP(flits, 2));
+		mc->len = htonl(RTE_DIV_ROUND_UP(flits, 2));
 		sc_imm = (struct ulptx_idata *)(mc + 1);
 		sc_imm->cmd_more = htonl(V_ULPTX_CMD(ULP_TX_SC_IMM) |
 					 F_ULP_TX_SC_MORE);
@@ -1116,7 +1116,7 @@ int t4_eth_xmit(struct sge_eth_txq *txq, struct rte_mbuf *mbuf,
 		goto out_free;
 	}
 
-	wr_mid = V_FW_WR_LEN16(DIV_ROUND_UP(flits, 2));
+	wr_mid = V_FW_WR_LEN16(RTE_DIV_ROUND_UP(flits, 2));
 	if (Q_IDXDIFF(&txq->q, equeidx)  >= 64) {
 		txq->q.equeidx = txq->q.pidx;
 		wr_mid |= F_FW_WR_EQUEQ;
@@ -1322,7 +1322,7 @@ static int ctrl_xmit(struct sge_ctrl_txq *q, struct rte_mbuf *mbuf)
 	}
 
 	reclaim_completed_tx_imm(&q->q);
-	ndesc = DIV_ROUND_UP(mbuf->pkt_len, sizeof(struct tx_desc));
+	ndesc = RTE_DIV_ROUND_UP(mbuf->pkt_len, sizeof(struct tx_desc));
 	t4_os_lock(&q->ctrlq_lock);
 
 	q->full = txq_avail(&q->q) < ndesc ? 1 : 0;
-- 
2.55.0.1082.g2b9226bbc0-goog

