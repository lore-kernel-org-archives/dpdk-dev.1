Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5150C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 11:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A97FE40B9D;
	Wed, 28 May 2025 13:51:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3E0AA40279
 for <dev@dpdk.org>; Wed, 28 May 2025 13:51:41 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SBFCcj025707
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 ZhiU5JM673a160GDgmCX+ZjB4ZnRldceliRbamdJno=; b=Me9t7NuLK6WV+fGwl
 08mH5RIcizOimx6Ez5zU292VgtPSY+3YIBUhtHtuiIDitiuX/PlOOiBFNeiZ3Ok6
 nhk7AXoL/VQ08wUGGJxAVHdLMlHkP07nTotzqm0BOYB3MwA3iSRpjVNyy7W8rcjA
 +WaKZrmzHURc7+Lj0OaLi4f8xLXhD9Mo0rF7Q9b4xsOMo3D27utvfrpm+yE5Dnol
 47L89pExcyQRPFjy5f/peqe23etA3YENi1jP7G1lFuyzI5a+4ZbkM6OBWEpRWXBS
 cPTVUdag7Z+LSCufGOQFDsm60GbMKHDSAkRMqM5q0ShyMeEODqe7GEEnEFbjqDdO
 su/bQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46x1e301mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 04:51:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 04:51:39 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 988713F7060;
 Wed, 28 May 2025 04:51:34 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 2/7] common/cnxk: set CQ drop and backpressure threshold
Date: Wed, 28 May 2025 17:21:17 +0530
Message-ID: <20250528115122.24052-2-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528115122.24052-1-rbhansali@marvell.com>
References: <20250528115122.24052-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: P3N0MypbnSDDB_8AJgavD1cXJdxyHzRd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNCBTYWx0ZWRfX2Zh9ah08ZjLJ
 ldgjRWJIG5nNvLGAu45zzASoOX7+f3RXRo5QJ7pSxd7V2n4dPExz1wZJGCPwSBV6A4Qaj7BHAqG
 78o9Ge7WnSBhnBSmHYmGMHalt2TpBnwcOtpNkJm+tETprW/tGajLCPt3wSKi4j1llhgbY0rAHTh
 iN8Z3pF8ad/xc2L5NBFBnRIZnokBduI4Ad3SF4QnFaacf3MnOHb1BHVOffdmRwbqNrDQl2bXW+p
 CafE/yVglwTpo0u7gH3HFRHX8ECMQApuXZuWT104hD06+vPh2hGOKn+6p2bVe/p4tw6l0uIRT9w
 9elpidiTCyM3WjYzIlu8IfiJja95c0P/piLMyRfx/J9z9k0T5VS0JjmwhS746vYgaxozX2nrLRB
 JtBAWxejxfsCpJCT3KlO0UTfWdRNrhzxHhfGs7AqnY7AcLxmQ9ikFrw8fpctRW8vFWeDoMrG
X-Proofpoint-GUID: P3N0MypbnSDDB_8AJgavD1cXJdxyHzRd
X-Authority-Analysis: v=2.4 cv=baVrUPPB c=1 sm=1 tr=0 ts=6836f8cc cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=62nf8py8lASbXsaL7-YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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

In case of force_tail_drop is enabled, a different set of
CQ drop and backpressure threshold will be configured
to avoid CQ FULL interrupts.
Also, drop thresholds are optimized for security packets.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix.h       |  4 ++++
 drivers/common/cnxk/roc_nix_fc.c    | 10 +++++----
 drivers/common/cnxk/roc_nix_priv.h  | 14 +++++++++---
 drivers/common/cnxk/roc_nix_queue.c | 35 ++++++++++++++++++++++-------
 4 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 1e543d8f11..75b414a32a 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -189,6 +189,7 @@ struct roc_nix_fc_cfg {
 			uint32_t rq;
 			uint16_t tc;
 			uint16_t cq_drop;
+			uint16_t cq_bp;
 			bool enable;
 		} cq_cfg;
 
@@ -196,6 +197,7 @@ struct roc_nix_fc_cfg {
 			uint32_t rq;
 			uint16_t tc;
 			uint16_t cq_drop;
+			uint16_t cq_bp;
 			uint64_t pool;
 			uint64_t spb_pool;
 			uint64_t pool_drop_pct;
@@ -371,6 +373,7 @@ struct roc_nix_cq {
 	uint8_t stash_thresh;
 	/* End of Input parameters */
 	uint16_t drop_thresh;
+	uint16_t bp_thresh;
 	struct roc_nix *roc_nix;
 	uintptr_t door;
 	int64_t *status;
@@ -483,6 +486,7 @@ struct roc_nix {
 	uint32_t root_sched_weight;
 	uint16_t inb_cfg_param1;
 	uint16_t inb_cfg_param2;
+	bool force_tail_drop;
 	/* End of input parameters */
 	/* LMT line base for "Per Core Tx LMT line" mode*/
 	uintptr_t lmt_base;
diff --git a/drivers/common/cnxk/roc_nix_fc.c b/drivers/common/cnxk/roc_nix_fc.c
index 3e162ede8e..e35c993f96 100644
--- a/drivers/common/cnxk/roc_nix_fc.c
+++ b/drivers/common/cnxk/roc_nix_fc.c
@@ -157,7 +157,8 @@ nix_fc_cq_config_get(struct roc_nix *roc_nix, struct roc_nix_fc_cfg *fc_cfg)
 	if (rc)
 		goto exit;
 
-	fc_cfg->cq_cfg.cq_drop = rsp->cq.bp;
+	fc_cfg->cq_cfg.cq_drop = rsp->cq.drop;
+	fc_cfg->cq_cfg.cq_bp = rsp->cq.bp;
 	fc_cfg->cq_cfg.enable = rsp->cq.bp_ena;
 	fc_cfg->type = ROC_NIX_FC_CQ_CFG;
 
@@ -288,7 +289,7 @@ nix_fc_cq_config_set(struct roc_nix *roc_nix, struct roc_nix_fc_cfg *fc_cfg)
 		if (fc_cfg->cq_cfg.enable) {
 			aq->cq.bpid = nix->bpid[fc_cfg->cq_cfg.tc];
 			aq->cq_mask.bpid = ~(aq->cq_mask.bpid);
-			aq->cq.bp = fc_cfg->cq_cfg.cq_drop;
+			aq->cq.bp = fc_cfg->cq_cfg.cq_bp;
 			aq->cq_mask.bp = ~(aq->cq_mask.bp);
 		}
 
@@ -310,7 +311,7 @@ nix_fc_cq_config_set(struct roc_nix *roc_nix, struct roc_nix_fc_cfg *fc_cfg)
 		if (fc_cfg->cq_cfg.enable) {
 			aq->cq.bpid = nix->bpid[fc_cfg->cq_cfg.tc];
 			aq->cq_mask.bpid = ~(aq->cq_mask.bpid);
-			aq->cq.bp = fc_cfg->cq_cfg.cq_drop;
+			aq->cq.bp = fc_cfg->cq_cfg.cq_bp;
 			aq->cq_mask.bp = ~(aq->cq_mask.bp);
 		}
 
@@ -332,7 +333,7 @@ nix_fc_cq_config_set(struct roc_nix *roc_nix, struct roc_nix_fc_cfg *fc_cfg)
 		if (fc_cfg->cq_cfg.enable) {
 			aq->cq.bpid = nix->bpid[fc_cfg->cq_cfg.tc];
 			aq->cq_mask.bpid = ~(aq->cq_mask.bpid);
-			aq->cq.bp = fc_cfg->cq_cfg.cq_drop;
+			aq->cq.bp = fc_cfg->cq_cfg.cq_bp;
 			aq->cq_mask.bp = ~(aq->cq_mask.bp);
 		}
 
@@ -389,6 +390,7 @@ nix_fc_rq_config_set(struct roc_nix *roc_nix, struct roc_nix_fc_cfg *fc_cfg)
 	tmp.cq_cfg.rq = fc_cfg->rq_cfg.rq;
 	tmp.cq_cfg.tc = fc_cfg->rq_cfg.tc;
 	tmp.cq_cfg.cq_drop = fc_cfg->rq_cfg.cq_drop;
+	tmp.cq_cfg.cq_bp = fc_cfg->rq_cfg.cq_bp;
 	tmp.cq_cfg.enable = fc_cfg->rq_cfg.enable;
 
 	rc = nix_fc_cq_config_set(roc_nix, &tmp);
diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index 09a55e43ce..dc3450a3d4 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -15,10 +15,18 @@
 #define NIX_SQB_PREFETCH     ((uint16_t)1)
 
 /* Apply BP/DROP when CQ is 95% full */
-#define NIX_CQ_THRESH_LEVEL	(5 * 256 / 100)
-#define NIX_CQ_SEC_THRESH_LEVEL (25 * 256 / 100)
+#define NIX_CQ_THRESH_LEVEL	   (5 * 256 / 100)
+#define NIX_CQ_SEC_BP_THRESH_LEVEL (25 * 256 / 100)
+
+/* Applicable when force_tail_drop is enabled */
+#define NIX_CQ_THRESH_LEVEL_REF1	(50 * 256 / 100)
+#define NIX_CQ_SEC_THRESH_LEVEL_REF1	(20 * 256 / 100)
+#define NIX_CQ_BP_THRESH_LEVEL_REF1	(60 * 256 / 100)
+#define NIX_CQ_SEC_BP_THRESH_LEVEL_REF1 (50 * 256 / 100)
+#define NIX_CQ_LBP_THRESH_FRAC_REF1	(80 * 16 / 100)
+
 /* Apply LBP at 75% of actual BP */
-#define NIX_CQ_LPB_THRESH_FRAC	(75 * 16 / 100)
+#define NIX_CQ_LBP_THRESH_FRAC	(75 * 16 / 100)
 #define NIX_CQ_FULL_ERRATA_SKID (1024ull * 256)
 #define NIX_RQ_AURA_BP_THRESH(percent, limit, shift) ((((limit) * (percent)) / 100) >> (shift))
 
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index 39bd051c94..84a736e3bb 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -954,7 +954,8 @@ roc_nix_rq_init(struct roc_nix *roc_nix, struct roc_nix_rq *rq, bool ena)
 	rq->tc = ROC_NIX_PFC_CLASS_INVALID;
 
 	/* Enable XQE/CQ drop on cn10k to count pkt drops only when inline is disabled */
-	if (roc_model_is_cn10k() && !roc_nix_inl_inb_is_enabled(roc_nix))
+	if (roc_model_is_cn10k() &&
+	    (roc_nix->force_tail_drop || !roc_nix_inl_inb_is_enabled(roc_nix)))
 		rq->xqe_drop_ena = true;
 
 	if (is_cn9k)
@@ -1150,9 +1151,9 @@ roc_nix_cn20k_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 			cq_ctx->lbpid_low = cpt_lbpid & 0x7;
 			cq_ctx->lbpid_med = (cpt_lbpid >> 3) & 0x7;
 			cq_ctx->lbpid_high = (cpt_lbpid >> 6) & 0x7;
-			cq_ctx->lbp_frac = NIX_CQ_LPB_THRESH_FRAC;
+			cq_ctx->lbp_frac = NIX_CQ_LBP_THRESH_FRAC;
 		}
-		drop_thresh = NIX_CQ_SEC_THRESH_LEVEL;
+		drop_thresh = NIX_CQ_SEC_BP_THRESH_LEVEL;
 	}
 
 	/* Many to one reduction */
@@ -1178,6 +1179,7 @@ roc_nix_cn20k_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 			cq_ctx->drop_ena = 1;
 		}
 	}
+	cq->bp_thresh = cq->drop_thresh;
 	cq_ctx->bp = cq->drop_thresh;
 
 	if (roc_feature_nix_has_cqe_stash()) {
@@ -1206,9 +1208,11 @@ roc_nix_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct mbox *mbox = (&nix->dev)->mbox;
 	volatile struct nix_cq_ctx_s *cq_ctx = NULL;
-	uint16_t drop_thresh = NIX_CQ_THRESH_LEVEL;
 	uint16_t cpt_lbpid = nix->cpt_lbpid;
 	enum nix_q_size qsize;
+	bool force_tail_drop;
+	uint16_t drop_thresh;
+	uint16_t bp_thresh;
 	size_t desc_sz;
 	int rc;
 
@@ -1262,6 +1266,8 @@ roc_nix_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 		cq_ctx = &aq->cq;
 	}
 
+	force_tail_drop = roc_nix->force_tail_drop;
+
 	cq_ctx->ena = 1;
 	cq_ctx->caching = 1;
 	cq_ctx->qsize = qsize;
@@ -1269,6 +1275,9 @@ roc_nix_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 	cq_ctx->avg_level = 0xff;
 	cq_ctx->cq_err_int_ena = BIT(NIX_CQERRINT_CQE_FAULT);
 	cq_ctx->cq_err_int_ena |= BIT(NIX_CQERRINT_DOOR_ERR);
+	drop_thresh = force_tail_drop ? NIX_CQ_THRESH_LEVEL_REF1 : NIX_CQ_THRESH_LEVEL;
+	bp_thresh = force_tail_drop ? NIX_CQ_BP_THRESH_LEVEL_REF1 : drop_thresh;
+
 	if (roc_feature_nix_has_late_bp() && roc_nix_inl_inb_is_enabled(roc_nix)) {
 		cq_ctx->cq_err_int_ena |= BIT(NIX_CQERRINT_CPT_DROP);
 		cq_ctx->cpt_drop_err_en = 1;
@@ -1278,9 +1287,16 @@ roc_nix_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 			cq_ctx->lbpid_low = cpt_lbpid & 0x7;
 			cq_ctx->lbpid_med = (cpt_lbpid >> 3) & 0x7;
 			cq_ctx->lbpid_high = (cpt_lbpid >> 6) & 0x7;
-			cq_ctx->lbp_frac = NIX_CQ_LPB_THRESH_FRAC;
+			cq_ctx->lbp_frac = force_tail_drop ? NIX_CQ_LBP_THRESH_FRAC_REF1 :
+							     NIX_CQ_LBP_THRESH_FRAC;
 		}
-		drop_thresh = NIX_CQ_SEC_THRESH_LEVEL;
+
+		/* CQ drop is disabled by default when inline device in use and
+		 * force_tail_drop disabled, so will not configure drop threshold.
+		 */
+		drop_thresh = force_tail_drop ? NIX_CQ_SEC_THRESH_LEVEL_REF1 : 0;
+		bp_thresh = force_tail_drop ? NIX_CQ_SEC_BP_THRESH_LEVEL_REF1 :
+					      NIX_CQ_SEC_BP_THRESH_LEVEL;
 	}
 
 	/* Many to one reduction */
@@ -1296,17 +1312,20 @@ roc_nix_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq *cq)
 		cq_ctx->drop = min_rx_drop;
 		cq_ctx->drop_ena = 1;
 		cq->drop_thresh = min_rx_drop;
+		bp_thresh = min_rx_drop;
+		cq->bp_thresh = bp_thresh;
 	} else {
 		cq->drop_thresh = drop_thresh;
+		cq->bp_thresh = bp_thresh;
 		/* Drop processing or red drop cannot be enabled due to
 		 * due to packets coming for second pass from CPT.
 		 */
-		if (!roc_nix_inl_inb_is_enabled(roc_nix)) {
+		if (!roc_nix_inl_inb_is_enabled(roc_nix) || force_tail_drop) {
 			cq_ctx->drop = cq->drop_thresh;
 			cq_ctx->drop_ena = 1;
 		}
 	}
-	cq_ctx->bp = cq->drop_thresh;
+	cq_ctx->bp = bp_thresh;
 
 	if (roc_feature_nix_has_cqe_stash()) {
 		if (cq_ctx->caching) {
-- 
2.25.1

