Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8A9C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:05:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B65640E1F;
	Tue, 27 May 2025 13:03:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E38DD40E20
 for <dev@dpdk.org>; Tue, 27 May 2025 13:03:04 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNhNiG022968
 for <dev@dpdk.org>; Tue, 27 May 2025 04:03:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 jlY2+gN11alDaUk0dJZ0jLGnCJhkqLU5kTN1ZxVSGU=; b=VyYq5Ezh6Fj8r1uDg
 DZjUoDhfTdxoWhiW1S0HLY3szXewMwxPJvdAU3T4yeNOVpkFN63I+NUOatRRnZMh
 5RO+O9rzHdIpkxCZmqPlMZO9dTwLAY0zRFZIBphv4kGmsl7scfhyVLy4VFqE0gcB
 pZ2rf/BoljX80UJyGVJI1maQ04sOopmXeSs+zU8iCNajzNby9PQEUUHRsx/kyT6j
 iHHJoGZuC9s8LXucXnEw5QH9jvrgRVBasew/H0Mgmb4xq/9hdxvFzrTxAh5X+/jl
 NtQFZkZPIgjVD4zp7hZ8CtVmZscmPnFLkc2wUw0ZF7+KKl06geUNkIV75Kz9EMGJ
 OXb/A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21293sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:03:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:03:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:03:02 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 12FA03F7061;
 Tue, 27 May 2025 04:03:00 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 23/25] crypto/cnxk: support raw API for cn20k
Date: Tue, 27 May 2025 16:32:03 +0530
Message-ID: <20250527110205.2300800-24-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=68359be8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ajUY5YtjlP-3_GQMfEQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 8M8nGIs1f1oKX1bWUMtU33hzWgXPIR1k
X-Proofpoint-ORIG-GUID: 8M8nGIs1f1oKX1bWUMtU33hzWgXPIR1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX+UnefOsATCjQ
 9CWFXKHHf5RGlt/tCvyDho7eICUYMuTvexFNmJ8MFafALZOHiOMo/vuW+GEP7aF2lF9PcWbShYV
 N2pwpoqIw+OABeWIzaRkhvOlxnkkhkO6M7Of8bVgDsFlbIVpxwpRvnXnMqvQNI6i2WVcIjNJcil
 spaBOYTsczOaGAh9ucBEpyMOJiB/91uowbc5wr3+vUCYV2iCY8aSVhX+QK2ecKzR4ZDVNHD5M8w
 EGTDwWFrS160UpJXOUC3r2itRlY56ERtgCOLKnh7rOiCtY2cR/PMTCaeNINs+q7qFqvKbChACEV
 QTcJ5eBcEHiiHGF1GKv8FjC4OlkfYUbtwZ16vFuJxKT2/pX2j2h3Ut9NfTSNCseWEaFOGUHH8Yl
 5yHkNsVIRDrye2Uw2naSufNW+FkyMzXpgpEEHVmpO1TaD9bl+Kj+x/HpK7ncTFo+UJ3mNjf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add raw API support for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 388 +++++++++++++++++++++-
 1 file changed, 381 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 2e94cdffe0..867725d94a 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -666,10 +666,356 @@ cn20k_cpt_dev_info_get(struct rte_cryptodev *dev, struct rte_cryptodev_info *inf
 	}
 }
 
+static inline int
+cn20k_cpt_raw_fill_inst(struct cnxk_iov *iov, struct cnxk_cpt_qp *qp,
+			struct cnxk_sym_dp_ctx *dp_ctx, struct cpt_inst_s inst[],
+			struct cpt_inflight_req *infl_req, void *opaque)
+{
+	struct cnxk_se_sess *sess;
+	int ret;
+
+	const union cpt_res_s res = {
+		.cn20k.compcode = CPT_COMP_NOT_DONE,
+	};
+
+	inst[0].w0.u64 = 0;
+	inst[0].w2.u64 = 0;
+	inst[0].w3.u64 = 0;
+
+	sess = dp_ctx->sess;
+
+	switch (sess->dp_thr_type) {
+	case CPT_DP_THREAD_TYPE_PT:
+		ret = fill_raw_passthrough_params(iov, inst);
+		break;
+	case CPT_DP_THREAD_TYPE_FC_CHAIN:
+		ret = fill_raw_fc_params(iov, sess, &qp->meta_info, infl_req, &inst[0], false,
+					 false, true);
+		break;
+	case CPT_DP_THREAD_TYPE_FC_AEAD:
+		ret = fill_raw_fc_params(iov, sess, &qp->meta_info, infl_req, &inst[0], false, true,
+					 true);
+		break;
+	case CPT_DP_THREAD_AUTH_ONLY:
+		ret = fill_raw_digest_params(iov, sess, &qp->meta_info, infl_req, &inst[0], true);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (unlikely(ret))
+		return 0;
+
+	inst[0].res_addr = (uint64_t)&infl_req->res;
+	rte_atomic_store_explicit((RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), res.u64[0],
+			rte_memory_order_relaxed);
+	infl_req->opaque = opaque;
+
+	inst[0].w7.u64 = sess->cpt_inst_w7;
+
+	return 1;
+}
+
+static uint32_t
+cn20k_cpt_raw_enqueue_burst(void *qpair, uint8_t *drv_ctx, struct rte_crypto_sym_vec *vec,
+			    union rte_crypto_sym_ofs ofs, void *user_data[], int *enqueue_status)
+{
+	uint16_t lmt_id, nb_allowed, nb_ops = vec->num;
+	struct cpt_inflight_req *infl_req;
+	uint64_t lmt_base, io_addr, head;
+	struct cnxk_cpt_qp *qp = qpair;
+	struct cnxk_sym_dp_ctx *dp_ctx;
+	struct pending_queue *pend_q;
+	uint32_t count = 0, index;
+	union cpt_fc_write_s fc;
+	struct cpt_inst_s *inst;
+	uint64_t *fc_addr;
+	int ret, i;
+
+	pend_q = &qp->pend_q;
+	const uint64_t pq_mask = pend_q->pq_mask;
+
+	head = pend_q->head;
+	nb_allowed = pending_queue_free_cnt(head, pend_q->tail, pq_mask);
+	nb_ops = RTE_MIN(nb_ops, nb_allowed);
+
+	if (unlikely(nb_ops == 0))
+		return 0;
+
+	lmt_base = qp->lmtline.lmt_base;
+	io_addr = qp->lmtline.io_addr;
+	fc_addr = qp->lmtline.fc_addr;
+
+	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
+
+	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
+	inst = (struct cpt_inst_s *)lmt_base;
+
+	dp_ctx = (struct cnxk_sym_dp_ctx *)drv_ctx;
+again:
+	fc.u64[0] =
+		rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)fc_addr, rte_memory_order_relaxed);
+	if (unlikely(fc.s.qsize > fc_thresh)) {
+		i = 0;
+		goto pend_q_commit;
+	}
+
+	for (i = 0; i < RTE_MIN(CN20K_CPT_PKTS_PER_LOOP, nb_ops); i++) {
+		struct cnxk_iov iov;
+
+		index = count + i;
+		infl_req = &pend_q->req_queue[head];
+		infl_req->op_flags = 0;
+
+		cnxk_raw_burst_to_iov(vec, &ofs, index, &iov);
+		ret = cn20k_cpt_raw_fill_inst(&iov, qp, dp_ctx, &inst[i], infl_req,
+					      user_data[index]);
+		if (unlikely(ret != 1)) {
+			plt_dp_err("Could not process vec: %d", index);
+			if (i == 0 && count == 0)
+				return -1;
+			else if (i == 0)
+				goto pend_q_commit;
+			else
+				break;
+		}
+		pending_queue_advance(&head, pq_mask);
+	}
+
+	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
+
+	if (nb_ops - i > 0 && i == CN20K_CPT_PKTS_PER_LOOP) {
+		nb_ops -= i;
+		count += i;
+		goto again;
+	}
+
+pend_q_commit:
+	rte_atomic_thread_fence(rte_memory_order_release);
+
+	pend_q->head = head;
+	pend_q->time_out = rte_get_timer_cycles() + DEFAULT_COMMAND_TIMEOUT * rte_get_timer_hz();
+
+	*enqueue_status = 1;
+	return count + i;
+}
+
+static int
+cn20k_cpt_raw_enqueue(void *qpair, uint8_t *drv_ctx, struct rte_crypto_vec *data_vec,
+		      uint16_t n_data_vecs, union rte_crypto_sym_ofs ofs,
+		      struct rte_crypto_va_iova_ptr *iv, struct rte_crypto_va_iova_ptr *digest,
+		      struct rte_crypto_va_iova_ptr *aad_or_auth_iv, void *user_data)
+{
+	struct cpt_inflight_req *infl_req;
+	uint64_t lmt_base, io_addr, head;
+	struct cnxk_cpt_qp *qp = qpair;
+	struct cnxk_sym_dp_ctx *dp_ctx;
+	uint16_t lmt_id, nb_allowed;
+	struct cpt_inst_s *inst;
+	union cpt_fc_write_s fc;
+	struct cnxk_iov iov;
+	uint64_t *fc_addr;
+	int ret, i = 1;
+
+	struct pending_queue *pend_q = &qp->pend_q;
+	const uint64_t pq_mask = pend_q->pq_mask;
+	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
+
+	head = pend_q->head;
+	nb_allowed = pending_queue_free_cnt(head, pend_q->tail, pq_mask);
+
+	if (unlikely(nb_allowed == 0))
+		return -1;
+
+	cnxk_raw_to_iov(data_vec, n_data_vecs, &ofs, iv, digest, aad_or_auth_iv, &iov);
+
+	lmt_base = qp->lmtline.lmt_base;
+	io_addr = qp->lmtline.io_addr;
+	fc_addr = qp->lmtline.fc_addr;
+
+	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
+	inst = (struct cpt_inst_s *)lmt_base;
+
+	fc.u64[0] =
+		rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)fc_addr, rte_memory_order_relaxed);
+	if (unlikely(fc.s.qsize > fc_thresh))
+		return -1;
+
+	dp_ctx = (struct cnxk_sym_dp_ctx *)drv_ctx;
+	infl_req = &pend_q->req_queue[head];
+	infl_req->op_flags = 0;
+
+	ret = cn20k_cpt_raw_fill_inst(&iov, qp, dp_ctx, &inst[0], infl_req, user_data);
+	if (unlikely(ret != 1)) {
+		plt_dp_err("Could not process vec");
+		return -1;
+	}
+
+	pending_queue_advance(&head, pq_mask);
+
+	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
+
+	pend_q->head = head;
+	pend_q->time_out = rte_get_timer_cycles() + DEFAULT_COMMAND_TIMEOUT * rte_get_timer_hz();
+
+	return 1;
+}
+
+static inline int
+cn20k_cpt_raw_dequeue_post_process(struct cpt_cn20k_res_s *res)
+{
+	const uint8_t uc_compcode = res->uc_compcode;
+	const uint8_t compcode = res->compcode;
+	int ret = 1;
+
+	if (likely(compcode == CPT_COMP_GOOD)) {
+		if (unlikely(uc_compcode))
+			plt_dp_info("Request failed with microcode error: 0x%x", res->uc_compcode);
+		else
+			ret = 0;
+	}
+
+	return ret;
+}
+
+static uint32_t
+cn20k_cpt_sym_raw_dequeue_burst(void *qptr, uint8_t *drv_ctx,
+				rte_cryptodev_raw_get_dequeue_count_t get_dequeue_count,
+				uint32_t max_nb_to_dequeue,
+				rte_cryptodev_raw_post_dequeue_t post_dequeue, void **out_user_data,
+				uint8_t is_user_data_array, uint32_t *n_success,
+				int *dequeue_status)
+{
+	struct cpt_inflight_req *infl_req;
+	struct cnxk_cpt_qp *qp = qptr;
+	struct pending_queue *pend_q;
+	uint64_t infl_cnt, pq_tail;
+	union cpt_res_s res;
+	int is_op_success;
+	uint16_t nb_ops;
+	void *opaque;
+	int i = 0;
+
+	pend_q = &qp->pend_q;
+
+	const uint64_t pq_mask = pend_q->pq_mask;
+
+	RTE_SET_USED(drv_ctx);
+	pq_tail = pend_q->tail;
+	infl_cnt = pending_queue_infl_cnt(pend_q->head, pq_tail, pq_mask);
+
+	/* Ensure infl_cnt isn't read before data lands */
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+
+	infl_req = &pend_q->req_queue[pq_tail];
+
+	opaque = infl_req->opaque;
+	if (get_dequeue_count)
+		nb_ops = get_dequeue_count(opaque);
+	else
+		nb_ops = max_nb_to_dequeue;
+	nb_ops = RTE_MIN(nb_ops, infl_cnt);
+
+	for (i = 0; i < nb_ops; i++) {
+		is_op_success = 0;
+		infl_req = &pend_q->req_queue[pq_tail];
+
+		res.u64[0] = rte_atomic_load_explicit(
+			(RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), rte_memory_order_relaxed);
+
+		if (unlikely(res.cn20k.compcode == CPT_COMP_NOT_DONE)) {
+			if (unlikely(rte_get_timer_cycles() > pend_q->time_out)) {
+				plt_err("Request timed out");
+				cnxk_cpt_dump_on_err(qp);
+				pend_q->time_out = rte_get_timer_cycles() +
+						   DEFAULT_COMMAND_TIMEOUT * rte_get_timer_hz();
+			}
+			break;
+		}
+
+		pending_queue_advance(&pq_tail, pq_mask);
+
+		if (!cn20k_cpt_raw_dequeue_post_process(&res.cn20k)) {
+			is_op_success = 1;
+			*n_success += 1;
+		}
+
+		if (is_user_data_array) {
+			out_user_data[i] = infl_req->opaque;
+			post_dequeue(out_user_data[i], i, is_op_success);
+		} else {
+			if (i == 0)
+				out_user_data[0] = opaque;
+			post_dequeue(out_user_data[0], i, is_op_success);
+		}
+
+		if (unlikely(infl_req->op_flags & CPT_OP_FLAGS_METABUF))
+			rte_mempool_put(qp->meta_info.pool, infl_req->mdata);
+	}
+
+	pend_q->tail = pq_tail;
+	*dequeue_status = 1;
+
+	return i;
+}
+
+static void *
+cn20k_cpt_sym_raw_dequeue(void *qptr, uint8_t *drv_ctx, int *dequeue_status,
+			  enum rte_crypto_op_status *op_status)
+{
+	struct cpt_inflight_req *infl_req;
+	struct cnxk_cpt_qp *qp = qptr;
+	struct pending_queue *pend_q;
+	uint64_t pq_tail;
+	union cpt_res_s res;
+	void *opaque = NULL;
+
+	pend_q = &qp->pend_q;
+
+	const uint64_t pq_mask = pend_q->pq_mask;
+
+	RTE_SET_USED(drv_ctx);
+
+	pq_tail = pend_q->tail;
+
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+
+	infl_req = &pend_q->req_queue[pq_tail];
+
+	res.u64[0] = rte_atomic_load_explicit(
+			(RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), rte_memory_order_relaxed);
+
+	if (unlikely(res.cn20k.compcode == CPT_COMP_NOT_DONE)) {
+		if (unlikely(rte_get_timer_cycles() > pend_q->time_out)) {
+			plt_err("Request timed out");
+			cnxk_cpt_dump_on_err(qp);
+			pend_q->time_out = rte_get_timer_cycles() +
+					   DEFAULT_COMMAND_TIMEOUT * rte_get_timer_hz();
+		}
+		goto exit;
+	}
+
+	pending_queue_advance(&pq_tail, pq_mask);
+
+	opaque = infl_req->opaque;
+
+	if (!cn20k_cpt_raw_dequeue_post_process(&res.cn20k))
+		*op_status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+	else
+		*op_status = RTE_CRYPTO_OP_STATUS_ERROR;
+
+	if (unlikely(infl_req->op_flags & CPT_OP_FLAGS_METABUF))
+		rte_mempool_put(qp->meta_info.pool, infl_req->mdata);
+
+	*dequeue_status = 1;
+exit:
+	return opaque;
+}
+
 static int
 cn20k_sym_get_raw_dp_ctx_size(struct rte_cryptodev *dev __rte_unused)
 {
-	return 0;
+	return sizeof(struct cnxk_sym_dp_ctx);
 }
 
 static int
@@ -678,12 +1024,40 @@ cn20k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 			       enum rte_crypto_op_sess_type sess_type,
 			       union rte_cryptodev_session_ctx session_ctx, uint8_t is_update)
 {
-	(void)dev;
-	(void)qp_id;
-	(void)raw_dp_ctx;
-	(void)sess_type;
-	(void)session_ctx;
-	(void)is_update;
+	struct cnxk_se_sess *sess = (struct cnxk_se_sess *)session_ctx.crypto_sess;
+	struct cnxk_sym_dp_ctx *dp_ctx;
+
+	if (sess_type != RTE_CRYPTO_OP_WITH_SESSION)
+		return -ENOTSUP;
+
+	if (sess == NULL)
+		return -EINVAL;
+
+	if ((sess->dp_thr_type == CPT_DP_THREAD_TYPE_PDCP) ||
+	    (sess->dp_thr_type == CPT_DP_THREAD_TYPE_PDCP_CHAIN) ||
+	    (sess->dp_thr_type == CPT_DP_THREAD_TYPE_KASUMI) ||
+	    (sess->dp_thr_type == CPT_DP_THREAD_TYPE_SM))
+		return -ENOTSUP;
+
+	if ((sess->dp_thr_type == CPT_DP_THREAD_AUTH_ONLY) &&
+	    ((sess->roc_se_ctx.fc_type == ROC_SE_KASUMI) ||
+	     (sess->roc_se_ctx.fc_type == ROC_SE_PDCP)))
+		return -ENOTSUP;
+
+	if (sess->roc_se_ctx.hash_type == ROC_SE_SHA1_TYPE)
+		return -ENOTSUP;
+
+	dp_ctx = (struct cnxk_sym_dp_ctx *)raw_dp_ctx->drv_ctx_data;
+	dp_ctx->sess = sess;
+
+	if (!is_update) {
+		raw_dp_ctx->qp_data = (struct cnxk_cpt_qp *)dev->data->queue_pairs[qp_id];
+		raw_dp_ctx->dequeue = cn20k_cpt_sym_raw_dequeue;
+		raw_dp_ctx->dequeue_burst = cn20k_cpt_sym_raw_dequeue_burst;
+		raw_dp_ctx->enqueue = cn20k_cpt_raw_enqueue;
+		raw_dp_ctx->enqueue_burst = cn20k_cpt_raw_enqueue_burst;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

