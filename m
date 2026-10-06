Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA5CCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C18F40ED8;
	Tue,  6 Oct 2026 04:31:16 +0200 (CEST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mails.dpdk.org (Postfix) with ESMTP id 858A340ED8
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:15 +0200 (CEST)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso1409099a12.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253875; x=1791858675; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a6NjSZ0w3O5lpsBmFkk2GRPerWXhNcXkp9jGaUFD8Zo=;
 b=KHFn5vCCL1i/vrOz9LOMwzDAPJbu/WhTEIjudXPM434Oi1U6pYym5AHkHc4pkte6js
 H+CeG0vLHVg8uK4zG0tZy6Ak1FrSLBjN4KyWtfUm61geupcgkguVtuZ5kEC2S96ElRdp
 SeUKCcBkm1Q3OnDTw2m9Ms5Wcr8xyzRthhd1X6zuz9MwJ2F150F22JNCsLjpHNlXkkvE
 E45Laj+2whRGtNCzqzIcSJL0Oq5mcDs357UsQURN0uOCJLX47WtheYCXtP7AYTUyP6BW
 FAC4Y34LRK/4AdeWY0ODJB0qa5iC+ltKi78PEZHfilcZeM5sXaiR6T47pfTy3UiE+XC7
 8ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253875; x=1791858675;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a6NjSZ0w3O5lpsBmFkk2GRPerWXhNcXkp9jGaUFD8Zo=;
 b=WDigQ40pH3q2Poi/5cX0sxXWwuPNxbHxLX/xR826Tx60GVVNq/qkYJfxtpS+fhtyvX
 E9zma72lZjlj3gS7xY55xHrIIL/Vj0moKXXRv6ZsmW1XEhEd3G5G45GxHNonwm8Kfxt+
 7fbpJrU9gU4fJ7QH8uR6T3mxI2AmSp5WZYyM/hHP++RhezIIlp46HoSPAK3oNFzBMaL+
 fmD4c4X/3NbmVgbM1N7brXnuXJa2KyRCVYs8teP0+cvkS/5KlFVM81FykDFRQ2Otm2gb
 oZEcG/oYKZEPU8Of7gdW7EXDa7pr0FCKaMvzfZ00Jph192AAfM5QVGcbd6JJRauIaIwH
 s/0w==
X-Gm-Message-State: AFuF++ma8UKezXLYA2scUy5D/fJ7GCzLDE6pK8vU+F3ZBajQ4tfJ6D8v
 3r7UMKfZNiGFMBmruREAKa+wRD7U6fqyUWJqAOeHUReUKK41xLYJvqJh1HVBqE2dAEVU1pnbMde
 EWDqzQ3ERIJfM+Q==
X-Received: from pgme3-n1.prod.google.com
 ([2002:a05:6a02:6c83:10b0:cc7:58af:e212])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:ed0d:b0:3de:5a00:e248 with SMTP id
 adf61e73a8af0-3e0bd479eccmr12127723637.76.1791253874380; 
 Mon, 05 Oct 2026 19:31:14 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:46 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-11-joshwash@google.com>
Subject: [PATCH v4 10/15] net/cxgbe: use common division round up macro
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
Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
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
2.56.0.rc1.315.gc6ed9934b7-goog

