Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5E2C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 13:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36D58402CA;
	Mon, 12 May 2025 15:58:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 340EA402C9
 for <dev@dpdk.org>; Mon, 12 May 2025 15:58:56 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C0ZrjQ029110
 for <dev@dpdk.org>; Mon, 12 May 2025 06:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 bjbd9QgPOvV+EyZ19TTSXBPfHv711aeSvAaSHBLb+4=; b=ENVI10HA9Lq8Hq7mz
 y4EMMphaFrNpWlKKK/I6nAwlPozLCJ1Mf/PL6Eeib7Hsfo6qFcCRIROVfyNELg5x
 3Le0MZMEaV7TrAz/uAOAoQPLTuJG7nC+gVeFPEnw3ocM41vzKUyamZYgWnurxVSF
 xdrRPMvigKyTvq1vqXRbCEXb1N2Om3kCb1fv/XK4HZaobSHuG5jjdVzW2/j/d/MB
 F56a87Bt3aER8CI9lFaZv9AdX02J3w1ADBEBSF0GWHcx6O1vD5op6x/FXaCPI1in
 MWr7fM77IulNl5DKcAgjeft71HPGNByKcHDzVG099XFeyr0Ahmf2e9oD+JADDeD/
 ztUxQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46k5trs69y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 12 May 2025 06:58:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 May 2025 06:58:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 May 2025 06:58:53 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 690E43F7095;
 Mon, 12 May 2025 06:58:49 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, "Nithin
 Dabilpuram" <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v2] cnxk: use stdatomic API
Date: Mon, 12 May 2025 19:28:46 +0530
Message-ID: <20250512135847.3804-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327111120.1641-1-pbhagavatula@marvell.com>
References: <20250327111120.1641-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=6821fe9f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=TZseKGC6XJzgppv9ztUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: hNPJmrX1cdVC3sN-k1-2th-UzZ1aio7D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NSBTYWx0ZWRfX5Q7QK2tpP4Xy
 PyDDqRVVpaMSs5Z9sVObl2rtix/72u9qSdZhjsyQ5AeEKPFCsBwIj5PZxDngnCc4EAbzmdEno88
 QDd1cHbpz8ANOi9AQ3q+A2LqiwwC+EOwtfTRp9n81xqtmD8A3U1TcYTtK3y1OfkwMogYEUfW+xm
 xGYyqyJDH3PQ+zTA8IjBGarm2GRy3m08IduHfByzykKbBKewlGmwL+Tfq8o7zTwdLVyvAQ5mT9V
 eUZJc3AQgN5DU79gvzhawYXAk7vmKO7xIpfkMhWHLMmLGvc5E445cGfBcDkCnTd8VArXBOMVgIc
 bL9KK1FzMtiXQjnHmugJk3ma53XcKIZQmQ1qZI840RoqR4w3jctzECbzbIpiUsIxivgwJWYWwkT
 1fTwwy93gYxs0aDJN1Vy5eApPGfA5B5112Z+OY9OjRkWnwmrj9T8aeq0OoCH7hIhIU2BqZiA
X-Proofpoint-ORIG-GUID: hNPJmrX1cdVC3sN-k1-2th-UzZ1aio7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Replace GCC inbuilt atomic functions with rte_atomic_xxx API.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 68 +++++++++++++----------
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c  | 25 +++++----
 drivers/net/cnxk/cn10k_ethdev.c           |  6 +-
 drivers/net/cnxk/cn10k_rxtx.h             |  8 +--
 drivers/net/cnxk/cn10k_tx.h               | 48 +++++++++-------
 drivers/net/cnxk/cn20k_ethdev.c           |  6 +-
 drivers/net/cnxk/cn20k_rxtx.h             |  8 +--
 drivers/net/cnxk/cn20k_tx.h               | 45 ++++++++-------
 drivers/net/cnxk/cn9k_ethdev.c            |  2 +-
 drivers/net/cnxk/cn9k_ethdev.h            |  2 +-
 drivers/net/cnxk/cn9k_tx.h                |  7 ++-
 drivers/net/cnxk/cnxk_ethdev_dp.h         |  2 +-
 12 files changed, 125 insertions(+), 102 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 851e6f0a88..fa8c4ebb01 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -293,7 +293,8 @@ cn10k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 	}
 
 	inst[0].res_addr = (uint64_t)&infl_req->res;
-	__atomic_store_n(&infl_req->res.u64[0], res.u64[0], __ATOMIC_RELAXED);
+	rte_atomic_store_explicit((uint64_t __rte_atomic *)&infl_req->res.u64[0], res.u64[0],
+				  rte_memory_order_relaxed);
 	infl_req->cop = op;
 
 	inst[0].w7.u64 = w7;
@@ -333,11 +334,11 @@ cn10k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops,
 	struct cpt_inflight_req *infl_req;
 	uint64_t head, lmt_base, io_addr;
 	uint16_t nb_allowed, count = 0;
+	uint64_t __rte_atomic *fc_addr;
 	struct cnxk_cpt_qp *qp = qptr;
 	struct pending_queue *pend_q;
 	struct cpt_inst_s *inst;
 	union cpt_fc_write_s fc;
-	uint64_t *fc_addr;
 	uint16_t lmt_id;
 	int ret, i;
 
@@ -354,7 +355,7 @@ cn10k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops,
 
 	lmt_base = qp->lmtline.lmt_base;
 	io_addr = qp->lmtline.io_addr;
-	fc_addr = qp->lmtline.fc_addr;
+	fc_addr = (uint64_t __rte_atomic *)qp->lmtline.fc_addr;
 
 	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
 
@@ -362,7 +363,7 @@ cn10k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops,
 	inst = (struct cpt_inst_s *)lmt_base;
 
 again:
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		i = 0;
 		goto pend_q_commit;
@@ -393,7 +394,7 @@ cn10k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops,
 	}
 
 pend_q_commit:
-	rte_atomic_thread_fence(__ATOMIC_RELEASE);
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	pend_q->head = head;
 	pend_q->time_out = rte_get_timer_cycles() +
@@ -542,7 +543,8 @@ cn10k_cpt_vec_inst_fill(struct vec_request *vec_req, struct cpt_inst_s *inst,
 	infl_req->qp = qp;
 
 	inst->res_addr = (uint64_t)&infl_req->res;
-	__atomic_store_n(&infl_req->res.u64[0], res.u64[0], __ATOMIC_RELAXED);
+	rte_atomic_store_explicit((uint64_t __rte_atomic *)&infl_req->res.u64[0], res.u64[0],
+				  rte_memory_order_relaxed);
 
 	inst->w0.u64 = 0;
 	inst->w2.u64 = vec_req->w2;
@@ -564,10 +566,10 @@ static inline void
 cn10k_cpt_vec_submit(struct vec_request vec_tbl[], uint16_t vec_tbl_len, struct cnxk_cpt_qp *qp)
 {
 	uint64_t lmt_base, lmt_id, io_addr;
+	uint64_t __rte_atomic *fc_addr;
 	union cpt_fc_write_s fc;
 	struct cpt_inst_s *inst;
 	uint16_t burst_size;
-	uint64_t *fc_addr;
 	int i;
 
 	if (vec_tbl_len == 0)
@@ -584,7 +586,7 @@ cn10k_cpt_vec_submit(struct vec_request vec_tbl[], uint16_t vec_tbl_len, struct
 
 	lmt_base = qp->lmtline.lmt_base;
 	io_addr = qp->lmtline.io_addr;
-	fc_addr = qp->lmtline.fc_addr;
+	fc_addr = (uint64_t __rte_atomic *)qp->lmtline.fc_addr;
 	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
 	inst = (struct cpt_inst_s *)lmt_base;
 
@@ -594,7 +596,7 @@ cn10k_cpt_vec_submit(struct vec_request vec_tbl[], uint16_t vec_tbl_len, struct
 		cn10k_cpt_vec_inst_fill(&vec_tbl[i], &inst[i], qp, vec_tbl[0].w7);
 
 	do {
-		fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+		fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 		if (likely(fc.s.qsize < fc_thresh))
 			break;
 		if (unlikely(rte_get_timer_cycles() > timeout))
@@ -619,18 +621,18 @@ ca_lmtst_vec_submit(struct ops_burst *burst, struct vec_request vec_tbl[], uint1
 	uint16_t lmt_id, len = *vec_tbl_len;
 	struct cpt_inst_s *inst, *inst_base;
 	struct cpt_inflight_req *infl_req;
+	uint64_t __rte_atomic *fc_addr;
 	struct rte_event_vector *vec;
 	uint64_t lmt_base, io_addr;
 	union cpt_fc_write_s fc;
 	struct cnxk_cpt_qp *qp;
-	uint64_t *fc_addr;
 	int ret, i, vi;
 
 	qp = burst->qp;
 
 	lmt_base = qp->lmtline.lmt_base;
 	io_addr = qp->lmtline.io_addr;
-	fc_addr = qp->lmtline.fc_addr;
+	fc_addr = (uint64_t __rte_atomic *)qp->lmtline.fc_addr;
 
 	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
 
@@ -645,7 +647,7 @@ ca_lmtst_vec_submit(struct ops_burst *burst, struct vec_request vec_tbl[], uint1
 #endif
 
 	/* Perform fc check before putting packets into vectors */
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		rte_errno = EAGAIN;
 		return 0;
@@ -738,10 +740,10 @@ ca_lmtst_burst_submit(struct ops_burst *burst, const bool is_sg_ver2)
 	struct cpt_inflight_req *infl_reqs[CN10K_CPT_PKTS_PER_LOOP];
 	struct cpt_inst_s *inst, *inst_base;
 	struct cpt_inflight_req *infl_req;
+	uint64_t __rte_atomic *fc_addr;
 	uint64_t lmt_base, io_addr;
 	union cpt_fc_write_s fc;
 	struct cnxk_cpt_qp *qp;
-	uint64_t *fc_addr;
 	uint16_t lmt_id;
 	int ret, i, j;
 
@@ -749,7 +751,7 @@ ca_lmtst_burst_submit(struct ops_burst *burst, const bool is_sg_ver2)
 
 	lmt_base = qp->lmtline.lmt_base;
 	io_addr = qp->lmtline.io_addr;
-	fc_addr = qp->lmtline.fc_addr;
+	fc_addr = (uint64_t __rte_atomic *)qp->lmtline.fc_addr;
 
 	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
 
@@ -790,7 +792,7 @@ ca_lmtst_burst_submit(struct ops_burst *burst, const bool is_sg_ver2)
 		inst->w3.u64 = CNXK_CPT_INST_W3(1, infl_req);
 	}
 
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		rte_errno = EAGAIN;
 		for (j = 0; j < i; j++) {
@@ -1241,7 +1243,8 @@ cn10k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 	cop = infl_req->cop;
 	qp = infl_req->qp;
 
-	res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+	res.u64[0] = rte_atomic_load_explicit((uint64_t __rte_atomic *)&infl_req->res.u64[0],
+					      rte_memory_order_relaxed);
 
 	cn10k_cpt_dequeue_post_process(qp, infl_req->cop, infl_req, &res.cn10k);
 
@@ -1272,7 +1275,8 @@ cn10k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 	req_mp = qp->ca.req_mp;
 
 #ifdef CNXK_CRYPTODEV_DEBUG
-	res.u64[0] = __atomic_load_n(&vec_infl_req->res.u64[0], __ATOMIC_RELAXED);
+	res.u64[0] = rte_atomic_load_explicit((uint64_t __rte_atomic *)&vec_infl_req->res.u64[0],
+					      rte_memory_order_relaxed);
 	PLT_ASSERT(res.cn10k.compcode == CPT_COMP_GOOD);
 	PLT_ASSERT(res.cn10k.uc_compcode == 0);
 #endif
@@ -1281,7 +1285,8 @@ cn10k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 		infl_req = vec->ptrs[i];
 		cop = infl_req->cop;
 
-		res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+		res.u64[0] = rte_atomic_load_explicit(
+			(uint64_t __rte_atomic *)&infl_req->res.u64[0], rte_memory_order_relaxed);
 		cn10k_cpt_dequeue_post_process(qp, cop, infl_req, &res.cn10k);
 
 		vec->ptrs[i] = cop;
@@ -1321,8 +1326,8 @@ cn10k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	for (i = 0; i < nb_ops; i++) {
 		infl_req = &pend_q->req_queue[pq_tail];
 
-		res.u64[0] = __atomic_load_n(&infl_req->res.u64[0],
-					     __ATOMIC_RELAXED);
+		res.u64[0] = rte_atomic_load_explicit(
+			(uint64_t __rte_atomic *)&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 		if (unlikely(res.cn10k.compcode == CPT_COMP_NOT_DONE)) {
 			if (unlikely(rte_get_timer_cycles() >
@@ -1576,7 +1581,8 @@ cn10k_cpt_raw_fill_inst(struct cnxk_iov *iov, struct cnxk_cpt_qp *qp,
 		return 0;
 
 	inst[0].res_addr = (uint64_t)&infl_req->res;
-	__atomic_store_n(&infl_req->res.u64[0], res.u64[0], __ATOMIC_RELAXED);
+	rte_atomic_store_explicit((uint64_t __rte_atomic *)&infl_req->res.u64[0], res.u64[0],
+				  rte_memory_order_relaxed);
 	infl_req->opaque = opaque;
 
 	inst[0].w7.u64 = sess->cpt_inst_w7;
@@ -1594,11 +1600,11 @@ cn10k_cpt_raw_enqueue_burst(void *qpair, uint8_t *drv_ctx, struct rte_crypto_sym
 	uint64_t lmt_base, io_addr, head;
 	struct cnxk_cpt_qp *qp = qpair;
 	struct cnxk_sym_dp_ctx *dp_ctx;
+	uint64_t __rte_atomic *fc_addr;
 	struct pending_queue *pend_q;
 	uint32_t count = 0, index;
 	union cpt_fc_write_s fc;
 	struct cpt_inst_s *inst;
-	uint64_t *fc_addr;
 	int ret, i;
 
 	pend_q = &qp->pend_q;
@@ -1613,7 +1619,7 @@ cn10k_cpt_raw_enqueue_burst(void *qpair, uint8_t *drv_ctx, struct rte_crypto_sym
 
 	lmt_base = qp->lmtline.lmt_base;
 	io_addr = qp->lmtline.io_addr;
-	fc_addr = qp->lmtline.fc_addr;
+	fc_addr = (uint64_t __rte_atomic *)qp->lmtline.fc_addr;
 
 	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
 
@@ -1622,7 +1628,7 @@ cn10k_cpt_raw_enqueue_burst(void *qpair, uint8_t *drv_ctx, struct rte_crypto_sym
 
 	dp_ctx = (struct cnxk_sym_dp_ctx *)drv_ctx;
 again:
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		i = 0;
 		goto pend_q_commit;
@@ -1697,11 +1703,11 @@ cn10k_cpt_raw_enqueue(void *qpair, uint8_t *drv_ctx, struct rte_crypto_vec *data
 	uint64_t lmt_base, io_addr, head;
 	struct cnxk_cpt_qp *qp = qpair;
 	struct cnxk_sym_dp_ctx *dp_ctx;
+	uint64_t __rte_atomic *fc_addr;
 	uint16_t lmt_id, nb_allowed;
 	struct cpt_inst_s *inst;
 	union cpt_fc_write_s fc;
 	struct cnxk_iov iov;
-	uint64_t *fc_addr;
 	int ret, i = 1;
 
 	struct pending_queue *pend_q = &qp->pend_q;
@@ -1718,12 +1724,12 @@ cn10k_cpt_raw_enqueue(void *qpair, uint8_t *drv_ctx, struct rte_crypto_vec *data
 
 	lmt_base = qp->lmtline.lmt_base;
 	io_addr = qp->lmtline.io_addr;
-	fc_addr = qp->lmtline.fc_addr;
+	fc_addr = (uint64_t __rte_atomic *)qp->lmtline.fc_addr;
 
 	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
 	inst = (struct cpt_inst_s *)lmt_base;
 
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh))
 		return -1;
 
@@ -1826,7 +1832,8 @@ cn10k_cpt_sym_raw_dequeue_burst(void *qptr, uint8_t *drv_ctx,
 		is_op_success = 0;
 		infl_req = &pend_q->req_queue[pq_tail];
 
-		res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+		res.u64[0] = rte_atomic_load_explicit(
+			(uint64_t __rte_atomic *)&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 		if (unlikely(res.cn10k.compcode == CPT_COMP_NOT_DONE)) {
 			if (unlikely(rte_get_timer_cycles() > pend_q->time_out)) {
@@ -1871,9 +1878,9 @@ cn10k_cpt_sym_raw_dequeue(void *qptr, uint8_t *drv_ctx, int *dequeue_status,
 	struct cpt_inflight_req *infl_req;
 	struct cnxk_cpt_qp *qp = qptr;
 	struct pending_queue *pend_q;
-	uint64_t pq_tail;
 	union cpt_res_s res;
 	void *opaque = NULL;
+	uint64_t pq_tail;
 
 	pend_q = &qp->pend_q;
 
@@ -1887,7 +1894,8 @@ cn10k_cpt_sym_raw_dequeue(void *qptr, uint8_t *drv_ctx, int *dequeue_status,
 
 	infl_req = &pend_q->req_queue[pq_tail];
 
-	res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+	res.u64[0] = rte_atomic_load_explicit((uint64_t __rte_atomic *)&infl_req->res.u64[0],
+					      rte_memory_order_relaxed);
 
 	if (unlikely(res.cn10k.compcode == CPT_COMP_NOT_DONE)) {
 		if (unlikely(rte_get_timer_cycles() > pend_q->time_out)) {
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index ee35ed1eba..69e15a862f 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -195,12 +195,12 @@ cn9k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 		infl_req_1->op_flags = 0;
 		infl_req_2->op_flags = 0;
 
-		__atomic_store_n(&infl_req_1->res.u64[0], res.u64[0],
-				 __ATOMIC_RELAXED);
+		rte_atomic_store_explicit((uint64_t __rte_atomic *)&infl_req_1->res.u64[0],
+					  res.u64[0], rte_memory_order_relaxed);
 		inst[0].res_addr = (uint64_t)&infl_req_1->res;
 
-		__atomic_store_n(&infl_req_2->res.u64[0], res.u64[0],
-				 __ATOMIC_RELAXED);
+		rte_atomic_store_explicit((uint64_t __rte_atomic *)&infl_req_2->res.u64[0],
+					  res.u64[0], rte_memory_order_relaxed);
 		inst[1].res_addr = (uint64_t)&infl_req_2->res;
 
 		ret = cn9k_cpt_inst_prep(qp, op_1, infl_req_1, &inst[0]);
@@ -224,7 +224,7 @@ cn9k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 		count += 2;
 	}
 
-	rte_atomic_thread_fence(__ATOMIC_RELEASE);
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	pend_q->head = head;
 	pend_q->time_out = rte_get_timer_cycles() +
@@ -346,10 +346,10 @@ uint16_t
 cn9k_cpt_crypto_adapter_enqueue(uintptr_t base, struct rte_crypto_op *op)
 {
 	struct cpt_inflight_req *infl_req;
+	uint64_t __rte_atomic *fc_addr;
 	union cpt_fc_write_s fc;
 	struct cnxk_cpt_qp *qp;
 	struct cpt_inst_s inst;
-	uint64_t *fc_addr;
 	int ret;
 
 	ret = cn9k_ca_meta_info_extract(op, &qp, &inst);
@@ -383,11 +383,11 @@ cn9k_cpt_crypto_adapter_enqueue(uintptr_t base, struct rte_crypto_op *op)
 	inst.res_addr = (uint64_t)&infl_req->res;
 	inst.w3.u64 = CNXK_CPT_INST_W3(1, infl_req);
 
-	fc_addr = qp->lmtline.fc_addr;
+	fc_addr = (uint64_t __rte_atomic *)qp->lmtline.fc_addr;
 
 	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
 
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		rte_mempool_put(qp->ca.req_mp, infl_req);
 		rte_errno = EAGAIN;
@@ -607,7 +607,8 @@ cn9k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 	cop = infl_req->cop;
 	qp = infl_req->qp;
 
-	res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+	res.u64[0] = rte_atomic_load_explicit((uint64_t __rte_atomic *)&infl_req->res.u64[0],
+					      rte_memory_order_relaxed);
 
 	cn9k_cpt_dequeue_post_process(qp, infl_req->cop, infl_req, &res.cn9k);
 
@@ -638,13 +639,13 @@ cn9k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	nb_ops = RTE_MIN(nb_ops, infl_cnt);
 
 	/* Ensure infl_cnt isn't read before data lands */
-	rte_atomic_thread_fence(__ATOMIC_ACQUIRE);
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	for (i = 0; i < nb_ops; i++) {
 		infl_req = &pend_q->req_queue[pq_tail];
 
-		res.u64[0] = __atomic_load_n(&infl_req->res.u64[0],
-					     __ATOMIC_RELAXED);
+		res.u64[0] = rte_atomic_load_explicit(
+			(uint64_t __rte_atomic *)&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 		if (unlikely(res.cn9k.compcode == CPT_COMP_NOT_DONE)) {
 			if (unlikely(rte_get_timer_cycles() >
diff --git a/drivers/net/cnxk/cn10k_ethdev.c b/drivers/net/cnxk/cn10k_ethdev.c
index e491854cb2..9c1621dbfa 100644
--- a/drivers/net/cnxk/cn10k_ethdev.c
+++ b/drivers/net/cnxk/cn10k_ethdev.c
@@ -256,9 +256,9 @@ cn10k_nix_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 		inl_lf = dev->outb.lf_base + crypto_qid;
 
 		txq->cpt_io_addr = inl_lf->io_addr;
-		txq->cpt_fc = inl_lf->fc_addr;
-		txq->cpt_fc_sw = (int32_t *)((uintptr_t)dev->outb.fc_sw_mem +
-					     crypto_qid * RTE_CACHE_LINE_SIZE);
+		txq->cpt_fc = (uint64_t __rte_atomic *)inl_lf->fc_addr;
+		txq->cpt_fc_sw = (int32_t __rte_atomic *)((uintptr_t)dev->outb.fc_sw_mem +
+							  crypto_qid * RTE_CACHE_LINE_SIZE);
 
 		txq->cpt_desc = inl_lf->nb_desc * 0.7;
 		txq->sa_base = (uint64_t)dev->outb.sa_base;
diff --git a/drivers/net/cnxk/cn10k_rxtx.h b/drivers/net/cnxk/cn10k_rxtx.h
index 53a6fbd60d..c18e9c8c0e 100644
--- a/drivers/net/cnxk/cn10k_rxtx.h
+++ b/drivers/net/cnxk/cn10k_rxtx.h
@@ -47,8 +47,8 @@
 
 struct cn10k_eth_txq {
 	uint64_t send_hdr_w0;
-	int64_t fc_cache_pkts;
-	uint64_t *fc_mem;
+	int64_t __rte_atomic fc_cache_pkts;
+	uint64_t __rte_atomic *fc_mem;
 	uintptr_t lmt_base;
 	rte_iova_t io_addr;
 	uint16_t sqes_per_sqb_log2;
@@ -56,9 +56,9 @@ struct cn10k_eth_txq {
 	uint8_t flag;
 	rte_iova_t cpt_io_addr;
 	uint64_t sa_base;
-	uint64_t *cpt_fc;
+	uint64_t __rte_atomic *cpt_fc;
 	uint16_t cpt_desc;
-	int32_t *cpt_fc_sw;
+	int32_t __rte_atomic *cpt_fc_sw;
 	uint64_t lso_tun_fmt;
 	uint64_t ts_mem;
 	uint64_t mark_flag : 8;
diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index 809fafb2f7..be9e020ac5 100644
--- a/drivers/net/cnxk/cn10k_tx.h
+++ b/drivers/net/cnxk/cn10k_tx.h
@@ -50,22 +50,24 @@
 
 #define NIX_XMIT_FC_OR_RETURN_MTS(txq, pkts)                                                       \
 	do {                                                                                       \
-		int64_t *fc_cache = &(txq)->fc_cache_pkts;                                         \
+		int64_t __rte_atomic *fc_cache = &(txq)->fc_cache_pkts;                            \
 		uint8_t retry_count = 8;                                                           \
 		int64_t val, newval;                                                               \
 	retry:                                                                                     \
 		/* Reduce the cached count */                                                      \
-		val = (int64_t)__atomic_fetch_sub(fc_cache, pkts, __ATOMIC_RELAXED);               \
+		val = (int64_t)rte_atomic_fetch_sub_explicit(fc_cache, pkts,                       \
+							     rte_memory_order_relaxed);            \
 		val -= pkts;                                                                       \
 		/* Cached value is low, Update the fc_cache_pkts */                                \
 		if (unlikely(val < 0)) {                                                           \
 			/* Multiply with sqe_per_sqb to express in pkts */                         \
-			newval = txq->nb_sqb_bufs_adj - __atomic_load_n(txq->fc_mem,               \
-									__ATOMIC_RELAXED);         \
+			newval = txq->nb_sqb_bufs_adj -                                            \
+				 rte_atomic_load_explicit(txq->fc_mem, rte_memory_order_relaxed);  \
 			newval = (newval << (txq)->sqes_per_sqb_log2) - newval;                    \
 			newval -= pkts;                                                            \
-			if (!__atomic_compare_exchange_n(fc_cache, &val, newval, false,            \
-							 __ATOMIC_RELAXED, __ATOMIC_RELAXED)) {    \
+			if (!rte_atomic_compare_exchange_strong_explicit(                          \
+				    fc_cache, &val, newval, rte_memory_order_relaxed,              \
+				    rte_memory_order_relaxed)) {                                   \
 				if (retry_count) {                                                 \
 					retry_count--;                                             \
 					goto retry;                                                \
@@ -164,10 +166,11 @@ cn10k_nix_vwqe_wait_fc(struct cn10k_eth_txq *txq, uint16_t req)
 		     : "memory");
 #else
 	RTE_SET_USED(pkts);
-	while (__atomic_load_n(&txq->fc_cache_pkts, __ATOMIC_RELAXED) < 0)
+	while (rte_atomic_load_explicit(&txq->fc_cache_pkts, rte_memory_order_relaxed) < 0)
 		;
 #endif
-	cached = __atomic_fetch_sub(&txq->fc_cache_pkts, req, __ATOMIC_ACQUIRE) - req;
+	cached = rte_atomic_fetch_sub_explicit(&txq->fc_cache_pkts, req, rte_memory_order_acquire) -
+		 req;
 	/* Check if there is enough space, else update and retry. */
 	if (cached >= 0)
 		return;
@@ -200,14 +203,15 @@ cn10k_nix_vwqe_wait_fc(struct cn10k_eth_txq *txq, uint16_t req)
 		     : "memory");
 #else
 	do {
-		refill = (txq->nb_sqb_bufs_adj - __atomic_load_n(txq->fc_mem, __ATOMIC_RELAXED));
+		refill = (txq->nb_sqb_bufs_adj -
+			  rte_atomic_load_explicit(txq->fc_mem, rte_memory_order_relaxed));
 		refill = (refill << txq->sqes_per_sqb_log2) - refill;
 		refill -= req;
 	} while (refill < 0);
 #endif
-	if (!__atomic_compare_exchange(&txq->fc_cache_pkts, &cached, &refill,
-				  0, __ATOMIC_RELEASE,
-				  __ATOMIC_RELAXED))
+	if (!rte_atomic_compare_exchange_strong_explicit(&txq->fc_cache_pkts, &cached, refill,
+							 rte_memory_order_release,
+							 rte_memory_order_relaxed))
 		goto retry;
 }
 
@@ -365,7 +369,7 @@ cn10k_nix_sec_fc_wait_one(struct cn10k_eth_txq *txq)
 		     : "memory");
 #else
 	RTE_SET_USED(fc);
-	while (nb_desc <= __atomic_load_n(txq->cpt_fc, __ATOMIC_RELAXED))
+	while (nb_desc <= rte_atomic_load_explicit(txq->cpt_fc, rte_memory_order_relaxed))
 		;
 #endif
 }
@@ -374,8 +378,8 @@ static __rte_always_inline void
 cn10k_nix_sec_fc_wait(struct cn10k_eth_txq *txq, uint16_t nb_pkts)
 {
 	int32_t nb_desc, val, newval;
-	int32_t *fc_sw;
-	uint64_t *fc;
+	int32_t __rte_atomic *fc_sw;
+	uint64_t __rte_atomic *fc;
 
 	/* Check if there is any CPT instruction to submit */
 	if (!nb_pkts)
@@ -397,11 +401,11 @@ cn10k_nix_sec_fc_wait(struct cn10k_eth_txq *txq, uint16_t nb_pkts)
 		     : "memory");
 #else
 	/* Wait for primary core to refill FC. */
-	while (__atomic_load_n(fc_sw, __ATOMIC_RELAXED) < 0)
+	while (rte_atomic_load_explicit(fc_sw, rte_memory_order_relaxed) < 0)
 		;
 #endif
 
-	val = __atomic_fetch_sub(fc_sw, nb_pkts, __ATOMIC_ACQUIRE) - nb_pkts;
+	val = rte_atomic_fetch_sub_explicit(fc_sw, nb_pkts, rte_memory_order_acquire) - nb_pkts;
 	if (likely(val >= 0))
 		return;
 
@@ -427,15 +431,16 @@ cn10k_nix_sec_fc_wait(struct cn10k_eth_txq *txq, uint16_t nb_pkts)
 		     : "memory");
 #else
 	while (true) {
-		newval = nb_desc - __atomic_load_n(fc, __ATOMIC_RELAXED);
+		newval = nb_desc - rte_atomic_load_explicit(fc, rte_memory_order_relaxed);
 		newval -= nb_pkts;
 		if (newval >= 0)
 			break;
 	}
 #endif
 
-	if (!__atomic_compare_exchange_n(fc_sw, &val, newval, false, __ATOMIC_RELEASE,
-					 __ATOMIC_RELAXED))
+	if (!rte_atomic_compare_exchange_strong_explicit(fc_sw, &val, newval,
+							 rte_memory_order_release,
+							 rte_memory_order_relaxed))
 		goto again;
 }
 
@@ -763,7 +768,8 @@ cn10k_nix_prefree_seg(struct rte_mbuf *m, struct rte_mbuf **extm, struct cn10k_e
 			m->next = prev;
 			txq->tx_compl.ptr[sqe_id] = m;
 		} else {
-			sqe_id = __atomic_fetch_add(&txq->tx_compl.sqe_id, 1, __ATOMIC_RELAXED);
+			sqe_id = rte_atomic_fetch_add_explicit(&txq->tx_compl.sqe_id, 1,
+							       rte_memory_order_relaxed);
 			send_hdr->w0.pnc = 1;
 			send_hdr->w1.sqe_id = sqe_id &
 				txq->tx_compl.nb_desc_mask;
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 740fdb7f76..97e3a8d557 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -248,9 +248,9 @@ cn20k_nix_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid, uint16_t nb_
 		inl_lf = dev->outb.lf_base + crypto_qid;
 
 		txq->cpt_io_addr = inl_lf->io_addr;
-		txq->cpt_fc = inl_lf->fc_addr;
-		txq->cpt_fc_sw = (int32_t *)((uintptr_t)dev->outb.fc_sw_mem +
-					     crypto_qid * RTE_CACHE_LINE_SIZE);
+		txq->cpt_fc = (uint64_t __rte_atomic *)inl_lf->fc_addr;
+		txq->cpt_fc_sw = (int32_t __rte_atomic *)((uintptr_t)dev->outb.fc_sw_mem +
+							  crypto_qid * RTE_CACHE_LINE_SIZE);
 
 		txq->cpt_desc = inl_lf->nb_desc * 0.7;
 		txq->sa_base = (uint64_t)dev->outb.sa_base;
diff --git a/drivers/net/cnxk/cn20k_rxtx.h b/drivers/net/cnxk/cn20k_rxtx.h
index f23c16ec07..10da42680f 100644
--- a/drivers/net/cnxk/cn20k_rxtx.h
+++ b/drivers/net/cnxk/cn20k_rxtx.h
@@ -47,8 +47,8 @@
 
 struct cn20k_eth_txq {
 	uint64_t send_hdr_w0;
-	int64_t fc_cache_pkts;
-	uint64_t *fc_mem;
+	int64_t __rte_atomic fc_cache_pkts;
+	uint64_t __rte_atomic *fc_mem;
 	uintptr_t lmt_base;
 	rte_iova_t io_addr;
 	uint16_t sqes_per_sqb_log2;
@@ -56,9 +56,9 @@ struct cn20k_eth_txq {
 	uint8_t flag;
 	rte_iova_t cpt_io_addr;
 	uint64_t sa_base;
-	uint64_t *cpt_fc;
+	uint64_t __rte_atomic *cpt_fc;
 	uint16_t cpt_desc;
-	int32_t *cpt_fc_sw;
+	int32_t __rte_atomic *cpt_fc_sw;
 	uint64_t lso_tun_fmt;
 	uint64_t ts_mem;
 	uint64_t mark_flag : 8;
diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index c419778970..3fb2e1f4e1 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -48,22 +48,24 @@
 
 #define NIX_XMIT_FC_OR_RETURN_MTS(txq, pkts)                                                       \
 	do {                                                                                       \
-		int64_t *fc_cache = &(txq)->fc_cache_pkts;                                         \
+		int64_t __rte_atomic *fc_cache = &(txq)->fc_cache_pkts;                            \
 		uint8_t retry_count = 8;                                                           \
 		int64_t val, newval;                                                               \
 	retry:                                                                                     \
 		/* Reduce the cached count */                                                      \
-		val = (int64_t)__atomic_fetch_sub(fc_cache, pkts, __ATOMIC_RELAXED);               \
+		val = (int64_t)rte_atomic_fetch_sub_explicit(fc_cache, pkts,                       \
+							     rte_memory_order_relaxed);            \
 		val -= pkts;                                                                       \
 		/* Cached value is low, Update the fc_cache_pkts */                                \
 		if (unlikely(val < 0)) {                                                           \
 			/* Multiply with sqe_per_sqb to express in pkts */                         \
 			newval = txq->nb_sqb_bufs_adj -                                            \
-				 __atomic_load_n(txq->fc_mem, __ATOMIC_RELAXED);                   \
+				 rte_atomic_load_explicit(txq->fc_mem, rte_memory_order_relaxed);  \
 			newval = (newval << (txq)->sqes_per_sqb_log2) - newval;                    \
 			newval -= pkts;                                                            \
-			if (!__atomic_compare_exchange_n(fc_cache, &val, newval, false,            \
-							 __ATOMIC_RELAXED, __ATOMIC_RELAXED)) {    \
+			if (!rte_atomic_compare_exchange_strong_explicit(                          \
+				    fc_cache, &val, newval, rte_memory_order_relaxed,              \
+				    rte_memory_order_relaxed)) {                                   \
 				if (retry_count) {                                                 \
 					retry_count--;                                             \
 					goto retry;                                                \
@@ -162,10 +164,11 @@ cn20k_nix_vwqe_wait_fc(struct cn20k_eth_txq *txq, uint16_t req)
 		     : "memory");
 #else
 	RTE_SET_USED(pkts);
-	while (__atomic_load_n(&txq->fc_cache_pkts, __ATOMIC_RELAXED) < 0)
+	while (rte_atomic_load_explicit(&txq->fc_cache_pkts, rte_memory_order_relaxed) < 0)
 		;
 #endif
-	cached = __atomic_fetch_sub(&txq->fc_cache_pkts, req, __ATOMIC_ACQUIRE) - req;
+	cached = rte_atomic_fetch_sub_explicit(&txq->fc_cache_pkts, req, rte_memory_order_acquire) -
+		 req;
 	/* Check if there is enough space, else update and retry. */
 	if (cached >= 0)
 		return;
@@ -198,13 +201,15 @@ cn20k_nix_vwqe_wait_fc(struct cn20k_eth_txq *txq, uint16_t req)
 		     : "memory");
 #else
 	do {
-		refill = (txq->nb_sqb_bufs_adj - __atomic_load_n(txq->fc_mem, __ATOMIC_RELAXED));
+		refill = (txq->nb_sqb_bufs_adj -
+			  rte_atomic_load_explicit(txq->fc_mem, rte_memory_order_relaxed));
 		refill = (refill << txq->sqes_per_sqb_log2) - refill;
 		refill -= req;
 	} while (refill < 0);
 #endif
-	if (!__atomic_compare_exchange(&txq->fc_cache_pkts, &cached, &refill, 0, __ATOMIC_RELEASE,
-				       __ATOMIC_RELAXED))
+	if (!rte_atomic_compare_exchange_strong_explicit(&txq->fc_cache_pkts, &cached, refill,
+							 rte_memory_order_release,
+							 rte_memory_order_relaxed))
 		goto retry;
 }
 
@@ -354,7 +359,7 @@ cn20k_nix_sec_fc_wait_one(struct cn20k_eth_txq *txq)
 		     : "memory");
 #else
 	RTE_SET_USED(fc);
-	while (nb_desc <= __atomic_load_n(txq->cpt_fc, __ATOMIC_RELAXED))
+	while (nb_desc <= rte_atomic_load_explicit(txq->cpt_fc, rte_memory_order_relaxed))
 		;
 #endif
 }
@@ -363,8 +368,8 @@ static __rte_always_inline void
 cn20k_nix_sec_fc_wait(struct cn20k_eth_txq *txq, uint16_t nb_pkts)
 {
 	int32_t nb_desc, val, newval;
-	int32_t *fc_sw;
-	uint64_t *fc;
+	int32_t __rte_atomic *fc_sw;
+	uint64_t __rte_atomic *fc;
 
 	/* Check if there is any CPT instruction to submit */
 	if (!nb_pkts)
@@ -386,11 +391,11 @@ cn20k_nix_sec_fc_wait(struct cn20k_eth_txq *txq, uint16_t nb_pkts)
 		     : "memory");
 #else
 	/* Wait for primary core to refill FC. */
-	while (__atomic_load_n(fc_sw, __ATOMIC_RELAXED) < 0)
+	while (rte_atomic_load_explicit(fc_sw, rte_memory_order_relaxed) < 0)
 		;
 #endif
 
-	val = __atomic_fetch_sub(fc_sw, nb_pkts, __ATOMIC_ACQUIRE) - nb_pkts;
+	val = rte_atomic_fetch_sub_explicit(fc_sw, nb_pkts, rte_memory_order_acquire) - nb_pkts;
 	if (likely(val >= 0))
 		return;
 
@@ -416,15 +421,16 @@ cn20k_nix_sec_fc_wait(struct cn20k_eth_txq *txq, uint16_t nb_pkts)
 		     : "memory");
 #else
 	while (true) {
-		newval = nb_desc - __atomic_load_n(fc, __ATOMIC_RELAXED);
+		newval = nb_desc - rte_atomic_load_explicit(fc, rte_memory_order_relaxed);
 		newval -= nb_pkts;
 		if (newval >= 0)
 			break;
 	}
 #endif
 
-	if (!__atomic_compare_exchange_n(fc_sw, &val, newval, false, __ATOMIC_RELEASE,
-					 __ATOMIC_RELAXED))
+	if (!rte_atomic_compare_exchange_strong_explicit(fc_sw, &val, newval,
+							 rte_memory_order_release,
+							 rte_memory_order_relaxed))
 		goto again;
 }
 
@@ -747,7 +753,8 @@ cn20k_nix_prefree_seg(struct rte_mbuf *m, struct rte_mbuf **extm, struct cn20k_e
 			m->next = prev;
 			txq->tx_compl.ptr[sqe_id] = m;
 		} else {
-			sqe_id = __atomic_fetch_add(&txq->tx_compl.sqe_id, 1, __ATOMIC_RELAXED);
+			sqe_id = rte_atomic_fetch_add_explicit(&txq->tx_compl.sqe_id, 1,
+							       rte_memory_order_relaxed);
 			send_hdr->w0.pnc = 1;
 			send_hdr->w1.sqe_id = sqe_id & txq->tx_compl.nb_desc_mask;
 			txq->tx_compl.ptr[send_hdr->w1.sqe_id] = m;
diff --git a/drivers/net/cnxk/cn9k_ethdev.c b/drivers/net/cnxk/cn9k_ethdev.c
index c419593a23..5f67e8a6ba 100644
--- a/drivers/net/cnxk/cn9k_ethdev.c
+++ b/drivers/net/cnxk/cn9k_ethdev.c
@@ -251,7 +251,7 @@ cn9k_nix_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 		inl_lf = dev->outb.lf_base + crypto_qid;
 
 		txq->cpt_io_addr = inl_lf->io_addr;
-		txq->cpt_fc = inl_lf->fc_addr;
+		txq->cpt_fc = (uint64_t __rte_atomic *)inl_lf->fc_addr;
 		txq->cpt_desc = inl_lf->nb_desc * 0.7;
 		txq->sa_base = (uint64_t)dev->outb.sa_base;
 		txq->sa_base |= eth_dev->data->port_id;
diff --git a/drivers/net/cnxk/cn9k_ethdev.h b/drivers/net/cnxk/cn9k_ethdev.h
index c267c11c46..59ed69acda 100644
--- a/drivers/net/cnxk/cn9k_ethdev.h
+++ b/drivers/net/cnxk/cn9k_ethdev.h
@@ -20,7 +20,7 @@ struct cn9k_eth_txq {
 	int16_t nb_sqb_bufs_adj;
 	rte_iova_t cpt_io_addr;
 	uint64_t sa_base;
-	uint64_t *cpt_fc;
+	uint64_t __rte_atomic *cpt_fc;
 	uint16_t cpt_desc;
 	uint64_t mark_flag : 8;
 	uint64_t mark_fmt : 48;
diff --git a/drivers/net/cnxk/cn9k_tx.h b/drivers/net/cnxk/cn9k_tx.h
index 902a17860c..14594b6311 100644
--- a/drivers/net/cnxk/cn9k_tx.h
+++ b/drivers/net/cnxk/cn9k_tx.h
@@ -112,7 +112,8 @@ cn9k_nix_prefree_seg(struct rte_mbuf *m, struct rte_mbuf **extm, struct cn9k_eth
 			m->next = prev;
 			txq->tx_compl.ptr[sqe_id] = m;
 		} else {
-			sqe_id = __atomic_fetch_add(&txq->tx_compl.sqe_id, 1, __ATOMIC_RELAXED);
+			sqe_id = rte_atomic_fetch_add_explicit(&txq->tx_compl.sqe_id, 1,
+							       rte_memory_order_relaxed);
 			send_hdr->w0.pnc = 1;
 			send_hdr->w1.sqe_id = sqe_id &
 				txq->tx_compl.nb_desc_mask;
@@ -597,9 +598,9 @@ static __rte_always_inline void
 cn9k_nix_sec_fc_wait_one(const struct cn9k_eth_txq *txq)
 {
 	uint64_t nb_desc = txq->cpt_desc;
-	uint64_t *fc = txq->cpt_fc;
+	uint64_t __rte_atomic *fc = txq->cpt_fc;
 
-	while (nb_desc <= __atomic_load_n(fc, __ATOMIC_RELAXED))
+	while (nb_desc <= rte_atomic_load_explicit(fc, rte_memory_order_relaxed))
 		;
 }
 
diff --git a/drivers/net/cnxk/cnxk_ethdev_dp.h b/drivers/net/cnxk/cnxk_ethdev_dp.h
index b5836b491e..cd31a36936 100644
--- a/drivers/net/cnxk/cnxk_ethdev_dp.h
+++ b/drivers/net/cnxk/cnxk_ethdev_dp.h
@@ -74,7 +74,7 @@ struct cnxk_eth_txq_comp {
 	uint32_t qmask;
 	uint32_t nb_desc_mask;
 	uint32_t available;
-	uint32_t sqe_id;
+	uint32_t __rte_atomic sqe_id;
 	bool ena;
 	struct rte_mbuf **ptr;
 	rte_spinlock_t ext_buf_lock;
-- 
2.43.0

