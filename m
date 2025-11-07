Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D13ECCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:49:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C5E240A7A;
	Fri,  7 Nov 2025 11:48:40 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E492A406FF
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:38 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A73U1MY1335551 for <dev@dpdk.org>; Fri, 7 Nov 2025 02:48:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 twIs58iqtK6bo+oovz7zsjfqXFbbkVEke13Z9DHJBQ=; b=XBCM6ZWKeu2MzfZnh
 jOuOyDxA2PZCGgdkZTZKAe30b4KugBJp2/nKbVanhnhYC11mDfsa7ZmKJHqMbrrN
 ZORjFIPALjHhntrTInMVPjjobKhn9cuVIsmAHOpLFE09AZu6VS/KMPmLjXI5Rm/8
 F558EjRwpsA728HrK4zVnhcnpV2cr9sgktmtpkjnfFixJdztU/SI/wVCO0Rw3Lry
 89Qsu4noGwXQXyY+hT1OXHieMoIaYEZ0405EcCsbSDpx71wsMWYDi+1D17y/8Lg2
 xzaz3fobezi+ei8jb7hOu7ZUf5lqrt4SUyl+d0JS0B8WtzSu6vzGsI4Ycf0S2Ned
 qQK3g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a98wkh9rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 07 Nov 2025 02:48:37 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:48:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:48:37 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id D702E3F70C9;
 Fri,  7 Nov 2025 02:48:29 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v4 13/23] common/cnxk: add support for SQ resize
Date: Fri, 7 Nov 2025 16:17:37 +0530
Message-ID: <20251107104747.1131008-13-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RNKFcTxcNdN75urUL7rEE8IXmvmu5akX
X-Proofpoint-GUID: RNKFcTxcNdN75urUL7rEE8IXmvmu5akX
X-Authority-Analysis: v=2.4 cv=WY8BqkhX c=1 sm=1 tr=0 ts=690dce85 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=BIG-wxp43RnHP4roqUMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX6lROtl4NV8rJ
 KFn+q/Le+J5d3rBKAD7NR/zStd+DnGVg5hhCV29IlDaEsScP9R+I2HcyWPe4Yl+QqA8TsbOJouO
 CtaOnIttGg0MXFoB90CtE2fUk6049BtwG5gTvrkkOlW+jIkbUnWjrzLnp6nREY4WdMKi0TNmrMs
 Quc/SFpC3AR+qRwK+8YfdtBhsqbvFx/m6Ht2ptb7OZiJoFJ5fokoD2+f3D2s4YEDkIyDR683LrH
 NiLOPksVUbrbBTzYbgeHHF9i8FlsH3Cg1qElt1G4Fe8z8DBkfsTra7SUC3zZ5SV+IflULsEeMIF
 p9TnX1gbwc1q1Ww2EyAFoREnGt0lvk2R1UszxaN32uyc3ysmdjA5/JFoG+/rLLvr4CABmCQMzGv
 Y5XoB+sqEGpd54/BJGfd9PBsGDxzqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

Add support for SQ resize by making SQB mem allocated
in chunks of SQB size.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_nix.h                 |   3 +
 drivers/common/cnxk/roc_nix_queue.c           | 389 ++++++++++++++++--
 .../common/cnxk/roc_platform_base_symbols.c   |   1 +
 3 files changed, 366 insertions(+), 27 deletions(-)

diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 274ece68a9..41a8576fca 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -399,6 +399,7 @@ struct roc_nix_sq {
 	bool cq_ena;
 	uint8_t fc_hyst_bits;
 	/* End of Input parameters */
+	uint16_t sqes_per_sqb;
 	uint16_t sqes_per_sqb_log2;
 	struct roc_nix *roc_nix;
 	uint64_t aura_handle;
@@ -495,6 +496,7 @@ struct roc_nix {
 	uint16_t inb_cfg_param2;
 	bool force_tail_drop;
 	bool dis_xqe_drop;
+	bool sq_resize_ena;
 	/* End of input parameters */
 	/* LMT line base for "Per Core Tx LMT line" mode*/
 	uintptr_t lmt_base;
@@ -993,6 +995,7 @@ int __roc_api roc_nix_sq_ena_dis(struct roc_nix_sq *sq, bool enable);
 void __roc_api roc_nix_sq_head_tail_get(struct roc_nix *roc_nix, uint16_t qid,
 					uint32_t *head, uint32_t *tail);
 int __roc_api roc_nix_sq_cnt_update(struct roc_nix_sq *sq, bool enable);
+int __roc_api roc_nix_sq_resize(struct roc_nix_sq *sq, uint32_t nb_desc);
 
 /* PTP */
 int __roc_api roc_nix_ptp_rx_ena_dis(struct roc_nix *roc_nix, int enable);
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index 1de6e51c5e..2c7fce1067 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -1430,42 +1430,77 @@ roc_nix_cq_fini(struct roc_nix_cq *cq)
 	return 0;
 }
 
-static int
-sqb_pool_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
+static uint16_t
+sqes_per_sqb_calc(uint16_t sqb_size, enum roc_nix_sq_max_sqe_sz max_sqe_sz)
 {
-	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
-	uint16_t sqes_per_sqb, count, nb_sqb_bufs, thr;
-	struct npa_pool_s pool;
-	struct npa_aura_s aura;
-	uint64_t blk_sz;
-	uint64_t iova;
-	int rc;
+	uint16_t sqes_per_sqb;
 
-	blk_sz = nix->sqb_size;
-	if (sq->max_sqe_sz == roc_nix_maxsqesz_w16)
-		sqes_per_sqb = (blk_sz / 8) / 16;
+	if (max_sqe_sz == roc_nix_maxsqesz_w16)
+		sqes_per_sqb = (sqb_size / 8) / 16;
 	else
-		sqes_per_sqb = (blk_sz / 8) / 8;
+		sqes_per_sqb = (sqb_size / 8) / 8;
 
 	/* Reserve One SQE in each SQB to hold pointer for next SQB */
 	sqes_per_sqb -= 1;
+	return sqes_per_sqb;
+}
+
+static uint16_t
+sq_desc_to_sqb(struct nix *nix, uint16_t sqes_per_sqb, uint32_t nb_desc)
+{
+	struct roc_nix *roc_nix = nix_priv_to_roc_nix(nix);
+	uint16_t nb_sqb_bufs;
+
+	nb_desc = PLT_MAX(512U, nb_desc);
+	nb_sqb_bufs = PLT_DIV_CEIL(nb_desc, sqes_per_sqb);
 
-	sq->nb_desc = PLT_MAX(512U, sq->nb_desc);
-	nb_sqb_bufs = PLT_DIV_CEIL(sq->nb_desc, sqes_per_sqb);
-	thr = PLT_DIV_CEIL((nb_sqb_bufs * ROC_NIX_SQB_THRESH), 100);
 	nb_sqb_bufs += NIX_SQB_PREFETCH;
 	/* Clamp up the SQB count */
 	nb_sqb_bufs = PLT_MAX(NIX_DEF_SQB, nb_sqb_bufs);
 	nb_sqb_bufs = PLT_MIN(roc_nix->max_sqb_count, (uint16_t)nb_sqb_bufs);
 
-	sq->nb_sqb_bufs = nb_sqb_bufs;
-	sq->sqes_per_sqb_log2 = (uint16_t)plt_log2_u32(sqes_per_sqb);
-	sq->nb_sqb_bufs_adj = nb_sqb_bufs;
+	return nb_sqb_bufs;
+}
 
+static uint16_t
+sqb_slack_adjust(struct nix *nix, uint16_t nb_sqb_bufs, bool sq_cnt_ena)
+{
+	struct roc_nix *roc_nix = nix_priv_to_roc_nix(nix);
+	uint16_t thr;
+
+	thr = PLT_DIV_CEIL((nb_sqb_bufs * ROC_NIX_SQB_THRESH), 100);
 	if (roc_nix->sqb_slack)
 		nb_sqb_bufs += roc_nix->sqb_slack;
-	else if (!sq->sq_cnt_ptr)
+	else if (!sq_cnt_ena)
 		nb_sqb_bufs += PLT_MAX((int)thr, (int)ROC_NIX_SQB_SLACK_DFLT);
+	return nb_sqb_bufs;
+}
+
+static int
+sqb_pool_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	uint16_t sqes_per_sqb, count, nb_sqb_bufs;
+	struct npa_pool_s pool;
+	struct npa_aura_s aura;
+	uint64_t blk_sz;
+	uint64_t iova;
+	int rc;
+
+	blk_sz = nix->sqb_size;
+	sqes_per_sqb = sqes_per_sqb_calc(blk_sz, sq->max_sqe_sz);
+
+	/* Translate desc count to SQB count */
+	nb_sqb_bufs = sq_desc_to_sqb(nix, sqes_per_sqb, sq->nb_desc);
+
+	sq->sqes_per_sqb = sqes_per_sqb;
+	sq->sqes_per_sqb_log2 = (uint16_t)plt_log2_u32(sqes_per_sqb);
+	sq->nb_sqb_bufs_adj = nb_sqb_bufs;
+	sq->nb_sqb_bufs = nb_sqb_bufs;
+
+	/* Add slack to SQB's */
+	nb_sqb_bufs = sqb_slack_adjust(nix, nb_sqb_bufs, !!sq->sq_cnt_ptr);
+
 	/* Explicitly set nat_align alone as by default pool is with both
 	 * nat_align and buf_offset = 1 which we don't want for SQB.
 	 */
@@ -1520,6 +1555,96 @@ sqb_pool_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 	return rc;
 }
 
+static int
+sqb_pool_dyn_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	uint16_t count, nb_sqb_bufs;
+	uint16_t max_sqb_count;
+	struct npa_pool_s pool;
+	struct npa_aura_s aura;
+	uint16_t sqes_per_sqb;
+	uint64_t blk_sz;
+	uint64_t iova;
+	int rc;
+
+	blk_sz = nix->sqb_size;
+	sqes_per_sqb = sqes_per_sqb_calc(blk_sz, sq->max_sqe_sz);
+
+	/* Translate desc count to SQB count */
+	nb_sqb_bufs = sq_desc_to_sqb(nix, sqes_per_sqb, sq->nb_desc);
+
+	sq->sqes_per_sqb_log2 = (uint16_t)plt_log2_u32(sqes_per_sqb);
+	sq->sqes_per_sqb = sqes_per_sqb;
+	sq->nb_sqb_bufs_adj = nb_sqb_bufs;
+	sq->nb_sqb_bufs = nb_sqb_bufs;
+
+	/* Add slack to SQB's */
+	nb_sqb_bufs = sqb_slack_adjust(nix, nb_sqb_bufs, !!sq->sq_cnt_ptr);
+
+	/* Explicitly set nat_align alone as by default pool is with both
+	 * nat_align and buf_offset = 1 which we don't want for SQB.
+	 */
+	memset(&pool, 0, sizeof(struct npa_pool_s));
+	pool.nat_align = 0;
+
+	memset(&aura, 0, sizeof(aura));
+	if (!sq->sq_cnt_ptr)
+		aura.fc_ena = 1;
+	if (roc_model_is_cn9k() || roc_errata_npa_has_no_fc_stype_ststp())
+		aura.fc_stype = 0x0; /* STF */
+	else
+		aura.fc_stype = 0x3; /* STSTP */
+	aura.fc_addr = (uint64_t)sq->fc;
+	aura.fc_hyst_bits = sq->fc_hyst_bits & 0xF;
+	max_sqb_count = sqb_slack_adjust(nix, roc_nix->max_sqb_count, false);
+	rc = roc_npa_pool_create(&sq->aura_handle, blk_sz, max_sqb_count, &aura, &pool, 0);
+	if (rc)
+		goto fail;
+
+	roc_npa_buf_type_update(sq->aura_handle, ROC_NPA_BUF_TYPE_SQB, 1);
+	roc_npa_aura_op_cnt_set(sq->aura_handle, 0, nb_sqb_bufs);
+
+	/* Fill the initial buffers */
+	for (count = 0; count < nb_sqb_bufs; count++) {
+		iova = (uint64_t)plt_zmalloc(blk_sz, ROC_ALIGN);
+		if (!iova) {
+			rc = -ENOMEM;
+			goto nomem;
+		}
+		plt_io_wmb();
+
+		roc_npa_aura_op_free(sq->aura_handle, 0, iova);
+	}
+
+	if (roc_npa_aura_op_available_wait(sq->aura_handle, nb_sqb_bufs, 0) != nb_sqb_bufs) {
+		plt_err("Failed to free all pointers to the pool");
+		rc = NIX_ERR_NO_MEM;
+		goto npa_fail;
+	}
+
+	/* Update aura count */
+	roc_npa_aura_limit_modify(sq->aura_handle, nb_sqb_bufs);
+	roc_npa_pool_op_range_set(sq->aura_handle, 0, UINT64_MAX);
+	sq->aura_sqb_bufs = nb_sqb_bufs;
+
+	return rc;
+npa_fail:
+nomem:
+	while (count) {
+		iova = roc_npa_aura_op_alloc(sq->aura_handle, 0);
+		if (!iova)
+			break;
+		plt_free((uint64_t *)iova);
+		count--;
+	}
+	if (count)
+		plt_err("Failed to recover %u SQB's", count);
+	roc_npa_pool_destroy(sq->aura_handle);
+fail:
+	return rc;
+}
+
 static int
 sq_cn9k_init(struct nix *nix, struct roc_nix_sq *sq, uint32_t rr_quantum,
 	     uint16_t smq)
@@ -1768,10 +1893,10 @@ sq_cn10k_fini(struct nix *nix, struct roc_nix_sq *sq)
 		return rc;
 	}
 
-	if (aq->sq.smq_pend)
+	if (rsp->sq.smq_pend)
 		plt_err("SQ has pending SQE's");
 
-	count = aq->sq.sqb_count;
+	count = rsp->sq.sqb_count;
 	sqes_per_sqb = 1 << sq->sqes_per_sqb_log2;
 	/* Free SQB's that are used */
 	sqb_buf = (void *)rsp->sq.head_sqb;
@@ -1939,6 +2064,7 @@ int
 roc_nix_sq_init(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	bool sq_resize_ena = roc_nix->sq_resize_ena;
 	struct mbox *m_box = (&nix->dev)->mbox;
 	uint16_t qid, smq = UINT16_MAX;
 	uint32_t rr_quantum = 0;
@@ -1964,7 +2090,10 @@ roc_nix_sq_init(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 		goto fail;
 	}
 
-	rc = sqb_pool_populate(roc_nix, sq);
+	if (sq_resize_ena)
+		rc = sqb_pool_dyn_populate(roc_nix, sq);
+	else
+		rc = sqb_pool_populate(roc_nix, sq);
 	if (rc)
 		goto nomem;
 
@@ -2014,19 +2143,38 @@ roc_nix_sq_init(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 	return rc;
 }
 
+static void
+nix_sqb_mem_dyn_free(uint64_t aura_handle, uint16_t count)
+{
+	uint64_t iova;
+
+	/* Recover SQB's and free them back */
+	while (count) {
+		iova = roc_npa_aura_op_alloc(aura_handle, 0);
+		if (!iova)
+			break;
+		plt_free((uint64_t *)iova);
+		count--;
+	}
+	if (count)
+		plt_err("Failed to recover %u SQB's", count);
+}
+
 int
 roc_nix_sq_fini(struct roc_nix_sq *sq)
 {
-	struct nix *nix;
-	struct mbox *mbox;
+	struct roc_nix *roc_nix = sq->roc_nix;
+	bool sq_resize_ena = roc_nix->sq_resize_ena;
 	struct ndc_sync_op *ndc_req;
+	struct mbox *mbox;
+	struct nix *nix;
 	uint16_t qid;
 	int rc = 0;
 
 	if (sq == NULL)
 		return NIX_ERR_PARAM;
 
-	nix = roc_nix_to_nix_priv(sq->roc_nix);
+	nix = roc_nix_to_nix_priv(roc_nix);
 	mbox = (&nix->dev)->mbox;
 
 	qid = sq->qid;
@@ -2058,14 +2206,201 @@ roc_nix_sq_fini(struct roc_nix_sq *sq)
 	 * for aura drain to succeed.
 	 */
 	roc_npa_aura_limit_modify(sq->aura_handle, sq->aura_sqb_bufs);
+
+	if (sq_resize_ena)
+		nix_sqb_mem_dyn_free(sq->aura_handle, sq->aura_sqb_bufs);
+
 	rc |= roc_npa_pool_destroy(sq->aura_handle);
 	plt_free(sq->fc);
-	plt_free(sq->sqe_mem);
+	if (!sq_resize_ena)
+		plt_free(sq->sqe_mem);
 	nix->sqs[qid] = NULL;
 
 	return rc;
 }
 
+static int
+sqb_aura_dyn_expand(struct roc_nix_sq *sq, uint16_t count)
+{
+	struct nix *nix = roc_nix_to_nix_priv(sq->roc_nix);
+	uint64_t *sqbs = NULL;
+	uint16_t blk_sz;
+	int i;
+
+	blk_sz = nix->sqb_size;
+	sqbs = calloc(1, count * sizeof(uint64_t *));
+	if (!sqbs)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		sqbs[i] = (uint64_t)plt_zmalloc(blk_sz, ROC_ALIGN);
+		if (!sqbs[i])
+			break;
+	}
+
+	if (i != count) {
+		i = i - 1;
+		for (; i >= 0; i--)
+			plt_free((void *)sqbs[i]);
+		free(sqbs);
+		return -ENOMEM;
+	}
+
+	plt_io_wmb();
+
+	/* Add new buffers to sqb aura */
+	for (i = 0; i < count; i++)
+		roc_npa_aura_op_free(sq->aura_handle, 0, sqbs[i]);
+	free(sqbs);
+
+	/* Adjust SQ info */
+	sq->nb_sqb_bufs += count;
+	sq->nb_sqb_bufs_adj += count;
+	sq->aura_sqb_bufs += count;
+	return 0;
+}
+
+static int
+sqb_aura_dyn_contract(struct roc_nix_sq *sq, uint16_t count)
+{
+	struct nix *nix = roc_nix_to_nix_priv(sq->roc_nix);
+	struct dev *dev = &nix->dev;
+	struct ndc_sync_op *ndc_req;
+	uint64_t *sqbs = NULL;
+	struct mbox *mbox;
+	uint64_t timeout; /* 10's of usec */
+	uint64_t cycles;
+	int i, rc;
+
+	mbox = dev->mbox;
+	/* Sync NDC-NIX-TX for LF */
+	ndc_req = mbox_alloc_msg_ndc_sync_op(mbox_get(mbox));
+	if (ndc_req == NULL) {
+		mbox_put(mbox);
+		return -EFAULT;
+	}
+
+	ndc_req->nix_lf_tx_sync = 1;
+	rc = mbox_process(mbox);
+	if (rc) {
+		mbox_put(mbox);
+		return rc;
+	}
+	mbox_put(mbox);
+
+	/* Wait for enough time based on shaper min rate */
+	timeout = (sq->nb_desc * roc_nix_max_pkt_len(sq->roc_nix) * 8 * 1E5);
+	/* Wait for worst case scenario of this SQ being last priority
+	 * and so have to wait for all other SQ's drain out by their own.
+	 */
+	timeout = timeout * nix->nb_tx_queues;
+	timeout = timeout / nix->tm_rate_min;
+	if (!timeout)
+		timeout = 10000;
+	cycles = (timeout * 10 * plt_tsc_hz()) / (uint64_t)1E6;
+	cycles += plt_tsc_cycles();
+
+	sqbs = calloc(1, count * sizeof(uint64_t *));
+	if (!sqbs)
+		return -ENOMEM;
+
+	i = 0;
+	while (i < count && plt_tsc_cycles() < cycles) {
+		sqbs[i] = roc_npa_aura_op_alloc(sq->aura_handle, 0);
+		if (sqbs[i])
+			i++;
+		else
+			plt_delay_us(1);
+	}
+
+	if (i != count) {
+		plt_warn("SQ %u busy, unable to recover %u SQB's(%u desc)", sq->qid, count,
+			 count * sq->sqes_per_sqb);
+
+		/* Restore the SQB aura state and return */
+		i--;
+		for (; i >= 0; i--)
+			roc_npa_aura_op_free(sq->aura_handle, 0, sqbs[i]);
+		free(sqbs);
+		return -EAGAIN;
+	}
+
+	/* Extracted necessary SQB's, on free them */
+	for (i = 0; i < count; i++)
+		plt_free((void *)sqbs[i]);
+	free(sqbs);
+
+	/* Adjust SQ info */
+	sq->nb_sqb_bufs -= count;
+	sq->nb_sqb_bufs_adj -= count;
+	sq->aura_sqb_bufs -= count;
+	return 0;
+}
+
+int
+roc_nix_sq_resize(struct roc_nix_sq *sq, uint32_t nb_desc)
+{
+	struct roc_nix *roc_nix = sq->roc_nix;
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	uint16_t aura_sqb_bufs, nb_sqb_bufs, sqes_per_sqb;
+	int64_t *regaddr;
+	uint64_t wdata;
+	uint16_t diff;
+	int rc;
+
+	if (!roc_nix->sq_resize_ena)
+		return -ENOTSUP;
+
+	sqes_per_sqb = sq->sqes_per_sqb;
+
+	/* Calculate new nb_sqb_bufs */
+	nb_sqb_bufs = sq_desc_to_sqb(nix, sqes_per_sqb, nb_desc);
+	aura_sqb_bufs = sqb_slack_adjust(nix, nb_sqb_bufs, !!sq->sq_cnt_ptr);
+
+	if (aura_sqb_bufs == sq->aura_sqb_bufs)
+		return 0;
+
+	/* Issue atomic op to make sure all inflight LMTST's are complete
+	 * assuming no new submissions will take place.
+	 */
+	wdata = ((uint64_t)sq->qid) << 32;
+	regaddr = (int64_t *)(nix->base + NIX_LF_SQ_OP_STATUS);
+	roc_atomic64_add_nosync(wdata, regaddr);
+
+	/* Expand or Contract SQB aura */
+	if (aura_sqb_bufs > sq->aura_sqb_bufs) {
+		/* Increase the limit */
+		roc_npa_aura_limit_modify(sq->aura_handle, aura_sqb_bufs);
+		diff = aura_sqb_bufs - sq->aura_sqb_bufs;
+		roc_npa_aura_op_cnt_set(sq->aura_handle, 1, diff);
+
+		rc = sqb_aura_dyn_expand(sq, diff);
+	} else {
+		diff = sq->aura_sqb_bufs - aura_sqb_bufs;
+		rc = sqb_aura_dyn_contract(sq, diff);
+
+		/* Decrease the limit */
+		if (!rc) {
+			roc_npa_aura_limit_modify(sq->aura_handle, aura_sqb_bufs);
+			roc_npa_aura_op_cnt_set(sq->aura_handle, 1, -(int64_t)diff);
+		}
+	}
+
+	plt_io_wmb();
+	if (!rc) {
+		sq->nb_desc = nb_desc;
+		if (sq->sq_cnt_ptr)
+			plt_atomic_store_explicit((uint64_t __plt_atomic *)sq->sq_cnt_ptr, nb_desc,
+						  plt_memory_order_release);
+		*(uint64_t *)sq->fc = roc_npa_aura_op_cnt_get(sq->aura_handle);
+	} else {
+		roc_npa_aura_limit_modify(sq->aura_handle, sq->aura_sqb_bufs);
+	}
+
+	plt_io_wmb();
+	return rc;
+}
+
 void
 roc_nix_cq_head_tail_get(struct roc_nix *roc_nix, uint16_t qid, uint32_t *head,
 			 uint32_t *tail)
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 1034c74300..9f5ff28760 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -351,6 +351,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_fini)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_init)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_fini)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_resize)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_fini)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_head_tail_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_head_tail_get)
-- 
2.34.1

