Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089D5C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B7F142E5B;
	Thu, 13 Aug 2026 19:23:09 +0200 (CEST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mails.dpdk.org (Postfix) with ESMTP id AA0E242E60
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:08 +0200 (CEST)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso1299192b3a.3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641788; x=1787246588; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K1SUewbUKkCfg3g2uAIGnCMc9JTInR7VKiWSM0l9h44=;
 b=UzT/x85ibnY7j3yj/eciD9qvIwhO3u4KGwbRyhxEpVC5JIvRr+vmDle5xRJTT8h2ZZ
 6/fNZMQsqhaRX65vD2LODZXJNIZ6j0f/YOje1hj5m4tJudWc13YqbS9S+gYdxDqz4Tyk
 DMN+iFRa/oTyhGJ2vFuP4xjR109m4dBaJvGj+I0o5QLsYYkToSfzsJEvs0O6n6LoMax3
 mK7geKizR3A6E0J75BWNWFIa1rIaRWPzpbP2oEzJMIlJmzXd3ZHLtxQGFAuXWqyZpuE8
 6/rXWGujEOA2ZJUxmyLoZfGRC7JnOTmdd+mhyieAQPwefNRSNxPs7Qbot/eTak621WAv
 VKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641788; x=1787246588;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K1SUewbUKkCfg3g2uAIGnCMc9JTInR7VKiWSM0l9h44=;
 b=NzlbZERvoXn7yBxgpM7XbAsoIubw5HhB2CXcnO9hAvjhjox51c4o3QEb5tu6h7/HE3
 Q8JViBU099qVeVmQjEZQRhPoB/+IHUh/ZW/UVClaHKSGzse3Cw5oI9yu+OK/2r2HKvCA
 pBQOWGOIyS+xy/GaPUB0t0D/ISDB7Lct/JpebbEkyuoWPTkWwxmtyakTVUSuVx3qowae
 ctHbkmt8TVyan0SBlb/HMiqgFNvoB/J1R5Y4HRtoV6EE/wq0MBe/b/1JqFUONX1XGDnZ
 FrcelLBTa44RvT6iV8pgOJGIH5nkPPl44BRe7m+/4P6pjrfwMlqYsE2HMaxYNK/6maoh
 k8Xg==
X-Gm-Message-State: AOJu0YzVAMcj3QMo0hzufAiz7E9GO3b7WmuftGVA0ZnuhCh4mGbh1TSh
 owxtJptnfxCpEcMqhTboonrzJ3Otlubrsia3qYjyX2t0tghdmzoGFxHwVfwxPsMikt7a2dvDEW+
 h62ec1Z0O75dVoQ==
X-Received: from pfej18.prod.google.com ([2002:aa7:8d12:0:b0:846:5d01:2319])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:7482:b0:84f:d7e4:3453 with SMTP id
 d2e1a72fcca58-84fd7e45b33mr2335213b3a.38.1786641787590; 
 Thu, 13 Aug 2026 10:23:07 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:35 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-11-joshwash@google.com>
Subject: [PATCH v2 10/14] net/cxgbe: use common division round up macro
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
 drivers/net/cxgbe/base/t4_hw.c   |  4 ++--
 drivers/net/cxgbe/base/t4vf_hw.c | 10 +++++-----
 drivers/net/cxgbe/cxgbe_compat.h |  3 +--
 drivers/net/cxgbe/cxgbe_filter.c |  6 +++---
 drivers/net/cxgbe/cxgbe_ofld.h   |  4 ++--
 drivers/net/cxgbe/sge.c          | 14 +++++++-------
 6 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/cxgbe/base/t4_hw.c b/drivers/net/cxgbe/base/t4_hw.c
index d02da39b84..944e173da2 100644
--- a/drivers/net/cxgbe/base/t4_hw.c
+++ b/drivers/net/cxgbe/base/t4_hw.c
@@ -2630,8 +2630,8 @@ static int t4_get_exprom_version(struct adapter *adapter, u32 *vers)
 		unsigned char hdr_arr[16];      /* must start with 0x55aa */
 		unsigned char hdr_ver[4];       /* Expansion ROM version */
 	} *hdr;
-	u32 exprom_header_buf[DIV_ROUND_UP(sizeof(struct exprom_header),
-					   sizeof(u32))];
+	u32 exprom_header_buf[RTE_DIV_ROUND_UP(sizeof(struct exprom_header),
+					       sizeof(u32))];
 	int ret;
 
 	ret = t4_read_flash(adapter, FLASH_EXP_ROM_START,
diff --git a/drivers/net/cxgbe/base/t4vf_hw.c b/drivers/net/cxgbe/base/t4vf_hw.c
index 573ccb1b05..561e4a91a4 100644
--- a/drivers/net/cxgbe/base/t4vf_hw.c
+++ b/drivers/net/cxgbe/base/t4vf_hw.c
@@ -362,8 +362,8 @@ int t4vf_query_params(struct adapter *adapter, unsigned int nparams,
 	cmd.op_to_vfn = cpu_to_be32(V_FW_CMD_OP(FW_PARAMS_CMD) |
 				    F_FW_CMD_REQUEST |
 				    F_FW_CMD_READ);
-	len16 = DIV_ROUND_UP(offsetof(struct fw_params_cmd,
-			     param[nparams]), 16);
+	len16 = RTE_DIV_ROUND_UP(offsetof(struct fw_params_cmd,
+					  param[nparams]), 16);
 	cmd.retval_len16 = cpu_to_be32(V_FW_CMD_LEN16(len16));
 	for (i = 0, p = &cmd.param[0]; i < nparams; i++, p++)
 		p->mnem = cpu_to_be32(*params++);
@@ -458,8 +458,8 @@ int t4vf_set_params(struct adapter *adapter, unsigned int nparams,
 	cmd.op_to_vfn = cpu_to_be32(V_FW_CMD_OP(FW_PARAMS_CMD) |
 				    F_FW_CMD_REQUEST |
 				    F_FW_CMD_WRITE);
-	len16 = DIV_ROUND_UP(offsetof(struct fw_params_cmd,
-			     param[nparams]), 16);
+	len16 = RTE_DIV_ROUND_UP(offsetof(struct fw_params_cmd,
+					  param[nparams]), 16);
 	cmd.retval_len16 = cpu_to_be32(V_FW_CMD_LEN16(len16));
 	for (i = 0, p = &cmd.param[0]; i < nparams; i++, p++) {
 		p->mnem = cpu_to_be32(*params++);
@@ -626,7 +626,7 @@ static int t4vf_get_port_stats_fw(struct adapter *adapter, int pidx,
 		struct fw_vi_stats_cmd cmd, rpl;
 		size_t len = (offsetof(struct fw_vi_stats_cmd, u) +
 			      sizeof(struct fw_vi_stats_ctl));
-		size_t len16 = DIV_ROUND_UP(len, 16);
+		size_t len16 = RTE_DIV_ROUND_UP(len, 16);
 		int ret;
 
 		memset(&cmd, 0, sizeof(cmd));
diff --git a/drivers/net/cxgbe/cxgbe_compat.h b/drivers/net/cxgbe/cxgbe_compat.h
index e74d476f6d..14ebe914eb 100644
--- a/drivers/net/cxgbe/cxgbe_compat.h
+++ b/drivers/net/cxgbe/cxgbe_compat.h
@@ -166,11 +166,10 @@ typedef uint64_t  dma_addr_t;
 typedef char *caddr_t;
 #endif
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 static inline uint8_t hweight32(uint32_t word32)
 {
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
2.55.0.691.gc56d675ccc-goog

