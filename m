Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01215C7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E466C406BB;
	Wed, 18 Jun 2025 08:21:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3BC66406BA
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:21:50 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HM2X5a011031
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:21:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=1APsdY+RYQMtEttTRJ6zhEP
 WGdQJhlTCkMTFsYjW4lQ=; b=Zqiq/RrQ7odwdComwmpoJy0eHFllP4EBl2tvBWJ
 t1pYKX1PdTSuPh+Qr6tjLdSOfnkyfEKleDzDYYP5Z0S7wBpDulOegpsObRPgM7QL
 EAdjbY+pHJ0CS08nu/LDYt5lrIwlmA+xtci2lBCRG4UWH/ITlmRW7quQJkCklmLl
 Pyqz/6rRo8Nbm/Li+2WegGdW02Oh+Vvn2LwwlfuXa9LWAmdvPP7IuQoVUAw24O1x
 LAfH2xJtuO6rBJhjWAY26EHweZV4jQRvEUsoD5Ok/3nnp6BSGflfEvlJluPEq4pt
 6UFyY93INKZn9tgA/Nk4T9/m7DGpHQ8TcBYavB4kRihgRxA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bgt9gtdq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:21:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 23:21:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 23:21:38 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id C51F53F7043;
 Tue, 17 Jun 2025 23:21:36 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>
Subject: [PATCH] crypto/cnxk: add sessionless asym cn20k support
Date: Wed, 18 Jun 2025 06:21:35 +0000
Message-ID: <20250618062135.489158-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IrYecK/g c=1 sm=1 tr=0 ts=68525afd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=q0dj6y5YAAAA:8 a=KFF26ixJs_39P98NOnIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Q7RaSUWP1pO7HXdsjIRs:22
X-Proofpoint-GUID: Tfxrz8hNb03DlngPj8ghZAwV2rI0uuKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1MyBTYWx0ZWRfX6ePHuAnQR3gL
 DApclf1oRmB/ltPHD3xmEGSUSKlLCSYpqO7HbeNPugbV6+PL1cb7SKI6uczTCfrfIO+kdjjwB+a
 sURmdbj0vXWp7FO5mOFMjVJam+mE38CEkFiqf2Y43Ap5tO6hCBVfcyn0lyoi7phHkUxS0FHBqGC
 NIY7CbF4Nrq8iB/o4V7M6FhHDgrIL7/vf605jMYrGxi602NvafY0D6p1USmAJjL9ssr6FJKS9Ew
 t8bBJoHUTEwFYUpPfE2jReHiLvWLR+0BRag63MXCa0svFgBEq6P6fR1aua/0R0f8XeM8kO2WuYK
 GAoVdX1OctsltB9gsckmgJLKq0fzRCZoQEsddQeTHGZW5JJkrvV+Qm2gvUluxUBVyZTgZzrXuOQ
 STUeB/i8t2E2LLYbMAdzXArNEZPfr001mJHl6aLM+z2IbNd10yvQEo/EKNTV99h020GLHL/q
X-Proofpoint-ORIG-GUID: Tfxrz8hNb03DlngPj8ghZAwV2rI0uuKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
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

Add support for sessionless asymmetric operations for cn20k.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 doc/guides/cryptodevs/features/cn20k.ini  |   1 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 566 +++++++++++++++++++++-
 2 files changed, 564 insertions(+), 3 deletions(-)

diff --git a/doc/guides/cryptodevs/features/cn20k.ini b/doc/guides/cryptodevs/features/cn20k.ini
index 76553d190e..ff00a8a107 100644
--- a/doc/guides/cryptodevs/features/cn20k.ini
+++ b/doc/guides/cryptodevs/features/cn20k.ini
@@ -17,6 +17,7 @@ Symmetric sessionless  = Y
 RSA PRIV OP KEY EXP    = Y
 RSA PRIV OP KEY QT     = Y
 Digest encrypted       = Y
+Asymmetric sessionless = Y
 Sym raw data path API  = Y
 Inner checksum         = Y
 Rx inject              = Y
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index ba586d79e8..2d152c86e7 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -66,6 +66,55 @@ cn20k_cpt_sym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
 	return NULL;
 }
 
+static inline struct cnxk_ae_sess *
+cn20k_cpt_asym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
+{
+	struct rte_crypto_asym_op *asym_op = op->asym;
+	struct roc_cpt *roc_cpt = qp->lf.roc_cpt;
+	struct rte_cryptodev_asym_session *sess;
+	struct cnxk_ae_sess *priv;
+	struct cnxk_cpt_vf *vf;
+	union cpt_inst_w7 w7;
+	struct hw_ctx_s *hwc;
+
+	/* Create temporary session */
+	if (rte_mempool_get(qp->sess_mp, (void **)&sess) < 0)
+		return NULL;
+
+	priv = (struct cnxk_ae_sess *)sess;
+	if (cnxk_ae_fill_session_parameters(priv, asym_op->xform))
+		goto sess_put;
+
+	priv->lf = &qp->lf;
+
+	if (roc_errata_cpt_hang_on_mixed_ctx_val()) {
+		hwc = &priv->hw_ctx;
+		hwc->w0.s.aop_valid = 1;
+		hwc->w0.s.ctx_hdr_size = 0;
+		hwc->w0.s.ctx_size = 1;
+		hwc->w0.s.ctx_push_size = 1;
+
+		w7.s.ctx_val = 1;
+		w7.s.cptr = (uint64_t)hwc;
+	}
+
+	w7.u64 = 0;
+	w7.s.egrp = roc_cpt->eng_grp[CPT_ENG_TYPE_AE];
+
+	vf = container_of(roc_cpt, struct cnxk_cpt_vf, cpt);
+	priv->cpt_inst_w7 = w7.u64;
+	priv->cnxk_fpm_iova = vf->cnxk_fpm_iova;
+	priv->ec_grp = vf->ec_grp;
+
+	asym_op->session = sess;
+
+	return priv;
+
+sess_put:
+	rte_mempool_put(qp->sess_mp, sess);
+	return NULL;
+}
+
 static __rte_always_inline int __rte_hot
 cpt_sec_ipsec_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 			struct cn20k_sec_session *sess, struct cpt_inst_s *inst,
@@ -165,7 +214,6 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 			w7 = sess->cpt_inst_w7;
 		}
 	} else if (op->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
-
 		if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 			asym_op = op->asym;
 			ae_sess = (struct cnxk_ae_sess *)asym_op->session;
@@ -174,9 +222,22 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 				return 0;
 			w7 = ae_sess->cpt_inst_w7;
 		} else {
-			plt_dp_err("Not supported Asym op without session");
-			return 0;
+			ae_sess = cn20k_cpt_asym_temp_sess_create(qp, op);
+			if (unlikely(ae_sess == NULL)) {
+				plt_dp_err("Could not create temp session");
+				return 0;
+			}
+
+			ret = cnxk_ae_enqueue(qp, op, infl_req, &inst[0], ae_sess);
+			if (unlikely(ret)) {
+				cnxk_ae_session_clear(NULL,
+						      (struct rte_cryptodev_asym_session *)ae_sess);
+				rte_mempool_put(qp->sess_mp, ae_sess);
+				return 0;
+			}
+			w7 = ae_sess->cpt_inst_w7;
 		}
+
 	} else {
 		plt_dp_err("Unsupported op type");
 		return 0;
@@ -284,6 +345,500 @@ cn20k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	return count + i;
 }
 
+static int
+cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, void *sess,
+				      enum rte_crypto_op_type op_type,
+				      enum rte_crypto_op_sess_type sess_type, void *mdata)
+{
+	union rte_event_crypto_metadata *ec_mdata = mdata;
+	struct rte_event *rsp_info;
+	struct cnxk_cpt_qp *qp;
+	uint64_t w2, tag_type;
+	uint8_t cdev_id;
+	int16_t qp_id;
+
+	/* Get queue pair */
+	cdev_id = ec_mdata->request_info.cdev_id;
+	qp_id = ec_mdata->request_info.queue_pair_id;
+	qp = rte_cryptodevs[cdev_id].data->queue_pairs[qp_id];
+
+	if (!qp->ca.enabled)
+		return -EINVAL;
+
+	/* Prepare w2 */
+	tag_type = qp->ca.vector_sz ? RTE_EVENT_TYPE_CRYPTODEV_VECTOR : RTE_EVENT_TYPE_CRYPTODEV;
+	rsp_info = &ec_mdata->response_info;
+	w2 = CNXK_CPT_INST_W2((tag_type << 28) | (rsp_info->sub_event_type << 20) |
+				      rsp_info->flow_id,
+			      rsp_info->sched_type, rsp_info->queue_id, 0);
+
+	/* Set meta according to session type */
+	if (op_type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+		if (sess_type == RTE_CRYPTO_OP_SECURITY_SESSION) {
+			struct cn20k_sec_session *sec_sess = (struct cn20k_sec_session *)sess;
+
+			sec_sess->qp = qp;
+			sec_sess->inst.w2 = w2;
+		} else if (sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+			struct cnxk_se_sess *priv;
+
+			priv = (struct cnxk_se_sess *)sess;
+			priv->qp = qp;
+			priv->cpt_inst_w2 = w2;
+		} else
+			return -EINVAL;
+	} else if (op_type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+		if (sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+			struct cnxk_ae_sess *priv;
+
+			priv = (struct cnxk_ae_sess *)sess;
+			priv->qp = qp;
+			priv->cpt_inst_w2 = w2;
+		} else
+			return -EINVAL;
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int
+cn20k_ca_meta_info_extract(struct rte_crypto_op *op, struct cnxk_cpt_qp **qp, uint64_t *w2)
+{
+	if (op->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+		if (op->sess_type == RTE_CRYPTO_OP_SECURITY_SESSION) {
+			struct cn20k_sec_session *sec_sess;
+
+			sec_sess = (struct cn20k_sec_session *)op->sym->session;
+
+			*qp = sec_sess->qp;
+			*w2 = sec_sess->inst.w2;
+		} else if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+			struct cnxk_se_sess *priv;
+
+			priv = (struct cnxk_se_sess *)op->sym->session;
+			*qp = priv->qp;
+			*w2 = priv->cpt_inst_w2;
+		} else {
+			union rte_event_crypto_metadata *ec_mdata;
+			struct rte_event *rsp_info;
+			uint8_t cdev_id;
+			uint16_t qp_id;
+
+			if (unlikely(op->private_data_offset == 0))
+				return -EINVAL;
+			ec_mdata = (union rte_event_crypto_metadata *)((uint8_t *)op +
+								       op->private_data_offset);
+			rsp_info = &ec_mdata->response_info;
+			cdev_id = ec_mdata->request_info.cdev_id;
+			qp_id = ec_mdata->request_info.queue_pair_id;
+			*qp = rte_cryptodevs[cdev_id].data->queue_pairs[qp_id];
+			*w2 = CNXK_CPT_INST_W2((RTE_EVENT_TYPE_CRYPTODEV << 28) | rsp_info->flow_id,
+					       rsp_info->sched_type, rsp_info->queue_id, 0);
+		}
+	} else if (op->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+		if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+			struct cnxk_ae_sess *priv;
+
+			priv = (struct cnxk_ae_sess *)op->asym->session;
+			*qp = priv->qp;
+			*w2 = priv->cpt_inst_w2;
+		} else {
+			union rte_event_crypto_metadata *ec_mdata;
+			struct rte_event *rsp_info;
+			uint8_t cdev_id;
+			uint16_t qp_id;
+
+			if (unlikely(op->private_data_offset == 0))
+				return -EINVAL;
+			ec_mdata = (union rte_event_crypto_metadata *)((uint8_t *)op +
+								       op->private_data_offset);
+			rsp_info = &ec_mdata->response_info;
+			cdev_id = ec_mdata->request_info.cdev_id;
+			qp_id = ec_mdata->request_info.queue_pair_id;
+			*qp = rte_cryptodevs[cdev_id].data->queue_pairs[qp_id];
+			*w2 = CNXK_CPT_INST_W2((RTE_EVENT_TYPE_CRYPTODEV << 28) | rsp_info->flow_id,
+					       rsp_info->sched_type, rsp_info->queue_id, 0);
+		}
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void
+cn20k_cpt_vec_inst_fill(struct vec_request *vec_req, struct cpt_inst_s *inst,
+			struct cnxk_cpt_qp *qp, union cpt_inst_w7 w7)
+{
+	const union cpt_res_s res = {.cn20k.compcode = CPT_COMP_NOT_DONE};
+	struct cpt_inflight_req *infl_req = vec_req->req;
+
+	const union cpt_inst_w4 w4 = {
+		.s.opcode_major = ROC_SE_MAJOR_OP_MISC,
+		.s.opcode_minor = ROC_SE_MISC_MINOR_OP_PASSTHROUGH,
+		.s.param1 = 1,
+		.s.param2 = 1,
+		.s.dlen = 0,
+	};
+
+	w7.s.egrp = ROC_CPT_DFLT_ENG_GRP_SE;
+
+	infl_req->vec = vec_req->vec;
+	infl_req->qp = qp;
+
+	inst->res_addr = (uint64_t)&infl_req->res;
+	rte_atomic_store_explicit((RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), res.u64[0],
+				  rte_memory_order_relaxed);
+
+	inst->w0.u64 = 0;
+	inst->w2.u64 = vec_req->w2;
+	inst->w3.u64 = CNXK_CPT_INST_W3(1, infl_req);
+	inst->w4.u64 = w4.u64;
+	inst->w5.u64 = 0;
+	inst->w6.u64 = 0;
+	inst->w7.u64 = w7.u64;
+}
+
+static void
+cn20k_cpt_vec_pkt_submission_timeout_handle(void)
+{
+	plt_dp_err("Vector packet submission timedout");
+	abort();
+}
+
+static inline void
+cn20k_cpt_vec_submit(struct vec_request vec_tbl[], uint16_t vec_tbl_len, struct cnxk_cpt_qp *qp)
+{
+	uint64_t lmt_base, lmt_id, io_addr;
+	union cpt_fc_write_s fc;
+	struct cpt_inst_s *inst;
+	uint16_t burst_size;
+	uint64_t *fc_addr;
+	int i;
+
+	if (vec_tbl_len == 0)
+		return;
+
+	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
+	/*
+	 * Use 10 mins timeout for the poll. It is not possible to recover from partial submission
+	 * of vector packet. Actual packets for processing are submitted to CPT prior to this
+	 * routine. Hence, any failure for submission of vector packet would indicate an
+	 * unrecoverable error for the application.
+	 */
+	const uint64_t timeout = rte_get_timer_cycles() + 10 * 60 * rte_get_timer_hz();
+
+	lmt_base = qp->lmtline.lmt_base;
+	io_addr = qp->lmtline.io_addr;
+	fc_addr = qp->lmtline.fc_addr;
+	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
+	inst = (struct cpt_inst_s *)lmt_base;
+
+again:
+	burst_size = RTE_MIN(CN20K_PKTS_PER_STEORL, vec_tbl_len);
+	for (i = 0; i < burst_size; i++)
+		cn20k_cpt_vec_inst_fill(&vec_tbl[i], &inst[i], qp, vec_tbl[0].w7);
+
+	do {
+		fc.u64[0] = rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)fc_addr,
+						     rte_memory_order_relaxed);
+		if (likely(fc.s.qsize < fc_thresh))
+			break;
+		if (unlikely(rte_get_timer_cycles() > timeout))
+			cn20k_cpt_vec_pkt_submission_timeout_handle();
+	} while (true);
+
+	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
+
+	vec_tbl_len -= i;
+
+	if (vec_tbl_len > 0) {
+		vec_tbl += i;
+		goto again;
+	}
+}
+
+static inline int
+ca_lmtst_vec_submit(struct ops_burst *burst, struct vec_request vec_tbl[], uint16_t *vec_tbl_len)
+{
+	struct cpt_inflight_req *infl_reqs[CN20K_CPT_PKTS_PER_LOOP];
+	uint16_t lmt_id, len = *vec_tbl_len;
+	struct cpt_inst_s *inst, *inst_base;
+	struct cpt_inflight_req *infl_req;
+	struct rte_event_vector *vec;
+	uint64_t lmt_base, io_addr;
+	union cpt_fc_write_s fc;
+	struct cnxk_cpt_qp *qp;
+	uint64_t *fc_addr;
+	int ret, i, vi;
+
+	qp = burst->qp;
+
+	lmt_base = qp->lmtline.lmt_base;
+	io_addr = qp->lmtline.io_addr;
+	fc_addr = qp->lmtline.fc_addr;
+
+	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
+
+	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
+	inst_base = (struct cpt_inst_s *)lmt_base;
+
+#ifdef CNXK_CRYPTODEV_DEBUG
+	if (unlikely(!qp->ca.enabled)) {
+		rte_errno = EINVAL;
+		return 0;
+	}
+#endif
+
+	/* Perform fc check before putting packets into vectors */
+	fc.u64[0] =
+		rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)fc_addr, rte_memory_order_relaxed);
+	if (unlikely(fc.s.qsize > fc_thresh)) {
+		rte_errno = EAGAIN;
+		return 0;
+	}
+
+	if (unlikely(rte_mempool_get_bulk(qp->ca.req_mp, (void **)infl_reqs, burst->nb_ops))) {
+		rte_errno = ENOMEM;
+		return 0;
+	}
+
+	for (i = 0; i < burst->nb_ops; i++) {
+		inst = &inst_base[i];
+		infl_req = infl_reqs[i];
+		infl_req->op_flags = 0;
+
+		ret = cn20k_cpt_fill_inst(qp, &burst->op[i], inst, infl_req);
+		if (unlikely(ret != 1)) {
+			plt_cpt_dbg("Could not process op: %p", burst->op[i]);
+			if (i != 0)
+				goto submit;
+			else
+				goto put;
+		}
+
+		infl_req->res.cn20k.compcode = CPT_COMP_NOT_DONE;
+		infl_req->qp = qp;
+		inst->w3.u64 = 0x1;
+
+		/* Lookup for existing vector by w2 */
+		for (vi = len - 1; vi >= 0; vi--) {
+			if (vec_tbl[vi].w2 != burst->w2[i])
+				continue;
+			vec = vec_tbl[vi].vec;
+			if (unlikely(vec->nb_elem == qp->ca.vector_sz))
+				continue;
+			vec->ptrs[vec->nb_elem++] = infl_req;
+			goto next_op; /* continue outer loop */
+		}
+
+		/* No available vectors found, allocate a new one */
+		if (unlikely(rte_mempool_get(qp->ca.vector_mp, (void **)&vec_tbl[len].vec))) {
+			rte_errno = ENOMEM;
+			if (i != 0)
+				goto submit;
+			else
+				goto put;
+		}
+		/* Also preallocate in-flight request, that will be used to
+		 * submit misc passthrough instruction
+		 */
+		if (unlikely(rte_mempool_get(qp->ca.req_mp, (void **)&vec_tbl[len].req))) {
+			rte_mempool_put(qp->ca.vector_mp, vec_tbl[len].vec);
+			rte_errno = ENOMEM;
+			if (i != 0)
+				goto submit;
+			else
+				goto put;
+		}
+		vec_tbl[len].w2 = burst->w2[i];
+		vec_tbl[len].vec->ptrs[0] = infl_req;
+		vec_tbl[len].vec->nb_elem = 1;
+		len++;
+
+next_op:;
+	}
+
+	/* Submit operations in burst */
+submit:
+	if (CNXK_TT_FROM_TAG(burst->ws->gw_rdata) == SSO_TT_ORDERED)
+		roc_sso_hws_head_wait(burst->ws->base);
+
+	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
+
+	/* Store w7 of last successfully filled instruction */
+	inst = &inst_base[2 * (i - 1)];
+	vec_tbl[0].w7 = inst->w7;
+
+put:
+	if (i != burst->nb_ops)
+		rte_mempool_put_bulk(qp->ca.req_mp, (void *)&infl_reqs[i], burst->nb_ops - i);
+
+	*vec_tbl_len = len;
+
+	return i;
+}
+
+static inline uint16_t
+ca_lmtst_burst_submit(struct ops_burst *burst)
+{
+	struct cpt_inflight_req *infl_reqs[CN20K_CPT_PKTS_PER_LOOP];
+	struct cpt_inst_s *inst, *inst_base;
+	struct cpt_inflight_req *infl_req;
+	uint64_t lmt_base, io_addr;
+	union cpt_fc_write_s fc;
+	struct cnxk_cpt_qp *qp;
+	uint64_t *fc_addr;
+	uint16_t lmt_id;
+	int ret, i, j;
+
+	qp = burst->qp;
+
+	lmt_base = qp->lmtline.lmt_base;
+	io_addr = qp->lmtline.io_addr;
+	fc_addr = qp->lmtline.fc_addr;
+
+	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
+
+	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
+	inst_base = (struct cpt_inst_s *)lmt_base;
+
+#ifdef CNXK_CRYPTODEV_DEBUG
+	if (unlikely(!qp->ca.enabled)) {
+		rte_errno = EINVAL;
+		return 0;
+	}
+#endif
+
+	if (unlikely(rte_mempool_get_bulk(qp->ca.req_mp, (void **)infl_reqs, burst->nb_ops))) {
+		rte_errno = ENOMEM;
+		return 0;
+	}
+
+	for (i = 0; i < burst->nb_ops; i++) {
+		inst = &inst_base[i];
+		infl_req = infl_reqs[i];
+		infl_req->op_flags = 0;
+
+		ret = cn20k_cpt_fill_inst(qp, &burst->op[i], inst, infl_req);
+		if (unlikely(ret != 1)) {
+			plt_dp_dbg("Could not process op: %p", burst->op[i]);
+			if (i != 0)
+				goto submit;
+			else
+				goto put;
+		}
+
+		infl_req->res.cn20k.compcode = CPT_COMP_NOT_DONE;
+		infl_req->qp = qp;
+		inst->w0.u64 = 0;
+		inst->res_addr = (uint64_t)&infl_req->res;
+		inst->w2.u64 = burst->w2[i];
+		inst->w3.u64 = CNXK_CPT_INST_W3(1, infl_req);
+	}
+
+	fc.u64[0] =
+		rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)fc_addr, rte_memory_order_relaxed);
+	if (unlikely(fc.s.qsize > fc_thresh)) {
+		rte_errno = EAGAIN;
+		for (j = 0; j < i; j++) {
+			infl_req = infl_reqs[j];
+			if (unlikely(infl_req->op_flags & CPT_OP_FLAGS_METABUF))
+				rte_mempool_put(qp->meta_info.pool, infl_req->mdata);
+		}
+		i = 0;
+		goto put;
+	}
+
+submit:
+	if (CNXK_TT_FROM_TAG(burst->ws->gw_rdata) == SSO_TT_ORDERED)
+		roc_sso_hws_head_wait(burst->ws->base);
+
+	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
+
+put:
+	if (unlikely(i != burst->nb_ops))
+		rte_mempool_put_bulk(qp->ca.req_mp, (void *)&infl_reqs[i], burst->nb_ops - i);
+
+	return i;
+}
+
+uint16_t __rte_hot
+cn20k_cpt_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
+{
+	uint16_t submitted, count = 0, vec_tbl_len = 0;
+	struct vec_request vec_tbl[nb_events];
+	struct rte_crypto_op *op;
+	struct ops_burst burst;
+	struct cnxk_cpt_qp *qp;
+	bool is_vector = false;
+	uint64_t w2;
+	int ret, i;
+
+	burst.ws = ws;
+	burst.qp = NULL;
+	burst.nb_ops = 0;
+
+	for (i = 0; i < nb_events; i++) {
+		op = ev[i].event_ptr;
+		ret = cn20k_ca_meta_info_extract(op, &qp, &w2);
+		if (unlikely(ret)) {
+			rte_errno = EINVAL;
+			goto vec_submit;
+		}
+
+		/* Queue pair change check */
+		if (qp != burst.qp) {
+			if (burst.nb_ops) {
+				if (is_vector) {
+					submitted =
+						ca_lmtst_vec_submit(&burst, vec_tbl, &vec_tbl_len);
+					/*
+					 * Vector submission is required on qp change, but not in
+					 * other cases, since we could send several vectors per
+					 * lmtst instruction only for same qp
+					 */
+					cn20k_cpt_vec_submit(vec_tbl, vec_tbl_len, burst.qp);
+					vec_tbl_len = 0;
+				} else {
+					submitted = ca_lmtst_burst_submit(&burst);
+				}
+				count += submitted;
+				if (unlikely(submitted != burst.nb_ops))
+					goto vec_submit;
+				burst.nb_ops = 0;
+			}
+			is_vector = qp->ca.vector_sz;
+			burst.qp = qp;
+		}
+		burst.w2[burst.nb_ops] = w2;
+		burst.op[burst.nb_ops] = op;
+
+		/* Max nb_ops per burst check */
+		if (++burst.nb_ops == CN20K_CPT_PKTS_PER_LOOP) {
+			if (is_vector)
+				submitted = ca_lmtst_vec_submit(&burst, vec_tbl, &vec_tbl_len);
+			else
+				submitted = ca_lmtst_burst_submit(&burst);
+			count += submitted;
+			if (unlikely(submitted != burst.nb_ops))
+				goto vec_submit;
+			burst.nb_ops = 0;
+		}
+	}
+	/* Submit the rest of crypto operations */
+	if (burst.nb_ops) {
+		if (is_vector)
+			count += ca_lmtst_vec_submit(&burst, vec_tbl, &vec_tbl_len);
+		else
+			count += ca_lmtst_burst_submit(&burst);
+	}
+
+vec_submit:
+	cn20k_cpt_vec_submit(vec_tbl, vec_tbl_len, burst.qp);
+	return count;
+}
+
 static inline void
 cn20k_cpt_ipsec_post_process(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res)
 {
@@ -590,6 +1145,11 @@ cn20k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 			rte_mempool_put(qp->sess_mp, cop->sym->session);
 			cop->sym->session = NULL;
 		}
+		if (cop->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+			cnxk_ae_session_clear(NULL, cop->asym->session);
+			rte_mempool_put(qp->sess_mp, cop->asym->session);
+			cop->asym->session = NULL;
+		}
 	}
 }
 
-- 
2.48.1

