Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49CBCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 10:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E364C40A6E;
	Wed,  1 Oct 2025 12:38:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A76B6406B6
 for <dev@dpdk.org>; Wed,  1 Oct 2025 12:38:52 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UNUVHW026738
 for <dev@dpdk.org>; Wed, 1 Oct 2025 03:38:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=hIYAkOShO6UXv9G/jMc26vg
 hxG1Mq5QnaecfaVMX3qE=; b=GuM67Z/VfyFzijIY8ULzcxjBiqV38eCjGK3e48A
 qWpLfkUvNdQARvBYT6xrYkNziTbbQhL9EyZadNXZm7fCsP6MSHuUhoYdiomJN+A1
 b31l6BNhZLRvfcfKnd0E2s44ZndeIS5ZZUy0Dsa5KjW/8kSPxw+EuZRgUBdX3LpV
 IxeOMijekB9965zLpnkgEmtNTCfAMUj5CZByepjQEl3OXJojLAGEmghZhzXBhLQ4
 bRwCyGdOadwS7CQTywqPfZFCvx3hqmV7j5z/JFzD3CCxW74OF9ysHgiLh9Cz9/v4
 6VlIEvzUod7CpVmoOdOp2xuvaXTAarMGt2K1Y1IdWZPB/7g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49grx0shv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 01 Oct 2025 03:38:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Oct 2025 03:38:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Oct 2025 03:38:59 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 1EE793F704B;
 Wed,  1 Oct 2025 03:38:47 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH] crypto/cnxk: add packet vector support
Date: Wed, 1 Oct 2025 16:08:46 +0530
Message-ID: <20251001103846.1130824-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDIxMyBTYWx0ZWRfX2PLF43YUOh8p
 SpaX3rfaujoNfTnc2J2iuNfjszaCAd5uMORPX+9PaowRn9d3Fe4jc+3XDd5x85izYY280wxtAp+
 V+bynEje3jjWAsF+2uS0L/ZPbNWeka1UVCObNnhP4Ea8u02b+54TJAQUOAU/kURFlLgsbZBnT+o
 z1nMgVvDopx8/qzbN089BzUgo+Yug/mMf+SLelpMYdAKvUbJ7U67A4Fkat6hzcAzBLC8dhW0EnG
 2n40DMQxXKYMpLjdz+K9LxUvQlZY8Fxw2nEYjrwjZtIZg2vVexEW9eJnA2SuoI8URz46HTImmdw
 VynqVbhcbGMSFazdbGD+qrp8E5LJ193Sha0wiTQHKqZ28oicSWgylsz29owRMksSwiBmBddltE/
 0PsICIz/cZMFtgymlorhZ9dQgH3Gog==
X-Proofpoint-GUID: P_2x4DUaMzTe2MMLWDZ1MYPoWAI9kpa2
X-Proofpoint-ORIG-GUID: P_2x4DUaMzTe2MMLWDZ1MYPoWAI9kpa2
X-Authority-Analysis: v=2.4 cv=QtZTHFyd c=1 sm=1 tr=0 ts=68dd04bb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=nka6wksMZ3YfvZGzzEoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_03,2025-09-29_04,2025-03-28_01
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

From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Add packet vector support in cn20k crypto adapter.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 319 ++++------------------
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h |   1 +
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h  |   6 +
 drivers/event/cnxk/cn20k_worker.h         |   3 +
 drivers/event/cnxk/cnxk_eventdev_adptr.c  |   9 +-
 5 files changed, 68 insertions(+), 270 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 6ef7c5bb22..8e4ee4f594 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -364,11 +364,15 @@ cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, vo
 				      enum rte_crypto_op_sess_type sess_type, void *mdata)
 {
 	union rte_event_crypto_metadata *ec_mdata = mdata;
+	uint32_t tag_mask = 0, stag_mask;
+	struct roc_sso_agq_data data;
 	struct rte_event *rsp_info;
 	struct cnxk_cpt_qp *qp;
 	uint64_t w2, tag_type;
 	uint8_t cdev_id;
 	int16_t qp_id;
+	uint32_t agq;
+	int rc;
 
 	/* Get queue pair */
 	cdev_id = ec_mdata->request_info.cdev_id;
@@ -378,12 +382,40 @@ cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, vo
 	if (!qp->ca.enabled)
 		return -EINVAL;
 
-	/* Prepare w2 */
-	tag_type = qp->ca.vector_sz ? RTE_EVENT_TYPE_CRYPTODEV_VECTOR : RTE_EVENT_TYPE_CRYPTODEV;
-	rsp_info = &ec_mdata->response_info;
-	w2 = CNXK_CPT_INST_W2((tag_type << 28) | (rsp_info->sub_event_type << 20) |
-				      rsp_info->flow_id,
-			      rsp_info->sched_type, rsp_info->queue_id, 0);
+	if (qp->ca.vector_sz) {
+		tag_mask |= ec_mdata->response_info.flow_id;
+		stag_mask = tag_mask;
+		tag_mask |= RTE_EVENT_TYPE_CRYPTODEV_VECTOR << 28;
+		stag_mask |= RTE_EVENT_TYPE_CRYPTODEV << 28;
+
+		memset(&data, 0, sizeof(struct roc_sso_agq_data));
+		data.tag = tag_mask;
+		data.tt = ec_mdata->response_info.sched_type;
+		data.stag = stag_mask >> 20;
+		data.vwqe_aura = roc_npa_aura_handle_to_aura(qp->ca.vector_mp->pool_id);
+		data.vwqe_max_sz_exp = rte_log2_u32(qp->ca.vector_sz);
+		data.vwqe_wait_tmo = qp->ca.vector_timeout_ns / ((SSO_AGGR_DEF_TMO + 1) * 100);
+		data.xqe_type = 0;
+		agq = UINT32_MAX;
+
+		rc = roc_sso_hwgrp_agq_alloc(&qp->evdev->sso, ec_mdata->response_info.queue_id,
+					     &data, &agq);
+		if (rc < 0) {
+			plt_err("Failed to allocate aggregator queue");
+			return rc;
+		}
+
+		/* Prepare w2 */
+		rsp_info = &ec_mdata->response_info;
+		w2 = CNXK_CPT_INST_W2(agq, SSO_TT_AGG, rsp_info->queue_id, 0);
+	} else {
+		/* Prepare w2 */
+		tag_type = RTE_EVENT_TYPE_CRYPTODEV;
+		rsp_info = &ec_mdata->response_info;
+		w2 = CNXK_CPT_INST_W2((tag_type << 28) | (rsp_info->sub_event_type << 20) |
+					      rsp_info->flow_id,
+				      rsp_info->sched_type, rsp_info->queue_id, 0);
+	}
 
 	/* Set meta according to session type */
 	if (op_type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
@@ -479,219 +511,6 @@ cn20k_ca_meta_info_extract(struct rte_crypto_op *op, struct cnxk_cpt_qp **qp, ui
 	return 0;
 }
 
-static inline void
-cn20k_cpt_vec_inst_fill(struct vec_request *vec_req, struct cpt_inst_s *inst,
-			struct cnxk_cpt_qp *qp, union cpt_inst_w7 w7)
-{
-	const union cpt_res_s res = {.cn20k.compcode = CPT_COMP_NOT_DONE};
-	struct cpt_inflight_req *infl_req = vec_req->req;
-
-	const union cpt_inst_w4 w4 = {
-		.s.opcode_major = ROC_SE_MAJOR_OP_MISC,
-		.s.opcode_minor = ROC_SE_MISC_MINOR_OP_PASSTHROUGH,
-		.s.param1 = 1,
-		.s.param2 = 1,
-		.s.dlen = 0,
-	};
-
-	w7.s.egrp = ROC_CPT_DFLT_ENG_GRP_SE;
-
-	infl_req->vec = vec_req->vec;
-	infl_req->qp = qp;
-
-	inst->res_addr = (uint64_t)&infl_req->res;
-	rte_atomic_store_explicit((RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), res.u64[0],
-				  rte_memory_order_relaxed);
-
-	inst->w0.u64 = 0;
-	inst->w2.u64 = vec_req->w2;
-	inst->w3.u64 = CNXK_CPT_INST_W3(1, infl_req);
-	inst->w4.u64 = w4.u64;
-	inst->w5.u64 = 0;
-	inst->w6.u64 = 0;
-	inst->w7.u64 = w7.u64;
-}
-
-static void
-cn20k_cpt_vec_pkt_submission_timeout_handle(void)
-{
-	plt_dp_err("Vector packet submission timedout");
-	abort();
-}
-
-static inline void
-cn20k_cpt_vec_submit(struct vec_request vec_tbl[], uint16_t vec_tbl_len, struct cnxk_cpt_qp *qp)
-{
-	uint64_t lmt_base, lmt_id, io_addr;
-	union cpt_fc_write_s fc;
-	struct cpt_inst_s *inst;
-	uint16_t burst_size;
-	uint64_t *fc_addr;
-	int i;
-
-	if (vec_tbl_len == 0)
-		return;
-
-	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
-	/*
-	 * Use 10 mins timeout for the poll. It is not possible to recover from partial submission
-	 * of vector packet. Actual packets for processing are submitted to CPT prior to this
-	 * routine. Hence, any failure for submission of vector packet would indicate an
-	 * unrecoverable error for the application.
-	 */
-	const uint64_t timeout = rte_get_timer_cycles() + 10 * 60 * rte_get_timer_hz();
-
-	lmt_base = qp->lmtline.lmt_base;
-	io_addr = qp->lmtline.io_addr;
-	fc_addr = qp->lmtline.fc_addr;
-	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
-	inst = (struct cpt_inst_s *)lmt_base;
-
-again:
-	burst_size = RTE_MIN(CN20K_PKTS_PER_STEORL, vec_tbl_len);
-	for (i = 0; i < burst_size; i++)
-		cn20k_cpt_vec_inst_fill(&vec_tbl[i], &inst[i], qp, vec_tbl[0].w7);
-
-	do {
-		fc.u64[0] = rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)fc_addr,
-						     rte_memory_order_relaxed);
-		if (likely(fc.s.qsize < fc_thresh))
-			break;
-		if (unlikely(rte_get_timer_cycles() > timeout))
-			cn20k_cpt_vec_pkt_submission_timeout_handle();
-	} while (true);
-
-	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
-
-	vec_tbl_len -= i;
-
-	if (vec_tbl_len > 0) {
-		vec_tbl += i;
-		goto again;
-	}
-}
-
-static inline int
-ca_lmtst_vec_submit(struct ops_burst *burst, struct vec_request vec_tbl[], uint16_t *vec_tbl_len)
-{
-	struct cpt_inflight_req *infl_reqs[CN20K_CPT_PKTS_PER_LOOP];
-	uint16_t lmt_id, len = *vec_tbl_len;
-	struct cpt_inst_s *inst, *inst_base;
-	struct cpt_inflight_req *infl_req;
-	struct rte_event_vector *vec;
-	uint64_t lmt_base, io_addr;
-	union cpt_fc_write_s fc;
-	struct cnxk_cpt_qp *qp;
-	uint64_t *fc_addr;
-	int ret, i, vi;
-
-	qp = burst->qp;
-
-	lmt_base = qp->lmtline.lmt_base;
-	io_addr = qp->lmtline.io_addr;
-	fc_addr = qp->lmtline.fc_addr;
-
-	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
-
-	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
-	inst_base = (struct cpt_inst_s *)lmt_base;
-
-#ifdef CNXK_CRYPTODEV_DEBUG
-	if (unlikely(!qp->ca.enabled)) {
-		rte_errno = EINVAL;
-		return 0;
-	}
-#endif
-
-	/* Perform fc check before putting packets into vectors */
-	fc.u64[0] =
-		rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)fc_addr, rte_memory_order_relaxed);
-	if (unlikely(fc.s.qsize > fc_thresh)) {
-		rte_errno = EAGAIN;
-		return 0;
-	}
-
-	if (unlikely(rte_mempool_get_bulk(qp->ca.req_mp, (void **)infl_reqs, burst->nb_ops))) {
-		rte_errno = ENOMEM;
-		return 0;
-	}
-
-	for (i = 0; i < burst->nb_ops; i++) {
-		inst = &inst_base[i];
-		infl_req = infl_reqs[i];
-		infl_req->op_flags = 0;
-
-		ret = cn20k_cpt_fill_inst(qp, &burst->op[i], inst, infl_req);
-		if (unlikely(ret != 1)) {
-			plt_cpt_dbg("Could not process op: %p", burst->op[i]);
-			if (i != 0)
-				goto submit;
-			else
-				goto put;
-		}
-
-		infl_req->res.cn20k.compcode = CPT_COMP_NOT_DONE;
-		infl_req->qp = qp;
-		inst->w3.u64 = 0x1;
-
-		/* Lookup for existing vector by w2 */
-		for (vi = len - 1; vi >= 0; vi--) {
-			if (vec_tbl[vi].w2 != burst->w2[i])
-				continue;
-			vec = vec_tbl[vi].vec;
-			if (unlikely(vec->nb_elem == qp->ca.vector_sz))
-				continue;
-			vec->ptrs[vec->nb_elem++] = infl_req;
-			goto next_op; /* continue outer loop */
-		}
-
-		/* No available vectors found, allocate a new one */
-		if (unlikely(rte_mempool_get(qp->ca.vector_mp, (void **)&vec_tbl[len].vec))) {
-			rte_errno = ENOMEM;
-			if (i != 0)
-				goto submit;
-			else
-				goto put;
-		}
-		/* Also preallocate in-flight request, that will be used to
-		 * submit misc passthrough instruction
-		 */
-		if (unlikely(rte_mempool_get(qp->ca.req_mp, (void **)&vec_tbl[len].req))) {
-			rte_mempool_put(qp->ca.vector_mp, vec_tbl[len].vec);
-			rte_errno = ENOMEM;
-			if (i != 0)
-				goto submit;
-			else
-				goto put;
-		}
-		vec_tbl[len].w2 = burst->w2[i];
-		vec_tbl[len].vec->ptrs[0] = infl_req;
-		vec_tbl[len].vec->nb_elem = 1;
-		len++;
-
-next_op:;
-	}
-
-	/* Submit operations in burst */
-submit:
-	if (CNXK_TT_FROM_TAG(burst->ws->gw_rdata) == SSO_TT_ORDERED)
-		roc_sso_hws_head_wait(burst->ws->base);
-
-	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
-
-	/* Store w7 of last successfully filled instruction */
-	inst = &inst_base[2 * (i - 1)];
-	vec_tbl[0].w7 = inst->w7;
-
-put:
-	if (i != burst->nb_ops)
-		rte_mempool_put_bulk(qp->ca.req_mp, (void *)&infl_reqs[i], burst->nb_ops - i);
-
-	*vec_tbl_len = len;
-
-	return i;
-}
-
 static inline uint16_t
 ca_lmtst_burst_submit(struct ops_burst *burst)
 {
@@ -780,12 +599,10 @@ RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cpt_crypto_adapter_enqueue)
 uint16_t __rte_hot
 cn20k_cpt_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
-	uint16_t submitted, count = 0, vec_tbl_len = 0;
-	struct vec_request vec_tbl[nb_events];
+	uint16_t submitted, count = 0;
 	struct rte_crypto_op *op;
 	struct ops_burst burst;
 	struct cnxk_cpt_qp *qp;
-	bool is_vector = false;
 	uint64_t w2;
 	int ret, i;
 
@@ -798,31 +615,18 @@ cn20k_cpt_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_ev
 		ret = cn20k_ca_meta_info_extract(op, &qp, &w2);
 		if (unlikely(ret)) {
 			rte_errno = EINVAL;
-			goto vec_submit;
+			goto exit;
 		}
 
 		/* Queue pair change check */
 		if (qp != burst.qp) {
 			if (burst.nb_ops) {
-				if (is_vector) {
-					submitted =
-						ca_lmtst_vec_submit(&burst, vec_tbl, &vec_tbl_len);
-					/*
-					 * Vector submission is required on qp change, but not in
-					 * other cases, since we could send several vectors per
-					 * lmtst instruction only for same qp
-					 */
-					cn20k_cpt_vec_submit(vec_tbl, vec_tbl_len, burst.qp);
-					vec_tbl_len = 0;
-				} else {
-					submitted = ca_lmtst_burst_submit(&burst);
-				}
+				submitted = ca_lmtst_burst_submit(&burst);
 				count += submitted;
 				if (unlikely(submitted != burst.nb_ops))
-					goto vec_submit;
+					goto exit;
 				burst.nb_ops = 0;
 			}
-			is_vector = qp->ca.vector_sz;
 			burst.qp = qp;
 		}
 		burst.w2[burst.nb_ops] = w2;
@@ -830,26 +634,18 @@ cn20k_cpt_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_ev
 
 		/* Max nb_ops per burst check */
 		if (++burst.nb_ops == CN20K_CPT_PKTS_PER_LOOP) {
-			if (is_vector)
-				submitted = ca_lmtst_vec_submit(&burst, vec_tbl, &vec_tbl_len);
-			else
-				submitted = ca_lmtst_burst_submit(&burst);
+			submitted = ca_lmtst_burst_submit(&burst);
 			count += submitted;
 			if (unlikely(submitted != burst.nb_ops))
-				goto vec_submit;
+				goto exit;
 			burst.nb_ops = 0;
 		}
 	}
 	/* Submit the rest of crypto operations */
-	if (burst.nb_ops) {
-		if (is_vector)
-			count += ca_lmtst_vec_submit(&burst, vec_tbl, &vec_tbl_len);
-		else
-			count += ca_lmtst_burst_submit(&burst);
-	}
+	if (burst.nb_ops)
+		count += ca_lmtst_burst_submit(&burst);
 
-vec_submit:
-	cn20k_cpt_vec_submit(vec_tbl, vec_tbl_len, burst.qp);
+exit:
 	return count;
 }
 
@@ -1196,31 +992,22 @@ RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cpt_crypto_adapter_vector_dequeue)
 uintptr_t
 cn20k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 {
-	struct cpt_inflight_req *infl_req, *vec_infl_req;
 	struct rte_mempool *meta_mp, *req_mp;
+	struct cpt_inflight_req *infl_req;
 	struct rte_event_vector *vec;
 	struct rte_crypto_op *cop;
 	struct cnxk_cpt_qp *qp;
 	union cpt_res_s res;
 	int i;
 
-	vec_infl_req = (struct cpt_inflight_req *)(get_work1);
-
-	vec = vec_infl_req->vec;
-	qp = vec_infl_req->qp;
-	meta_mp = qp->meta_info.pool;
-	req_mp = qp->ca.req_mp;
-
-#ifdef CNXK_CRYPTODEV_DEBUG
-	res.u64[0] = rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)(&vec_infl_req->res.u64[0]),
-					      rte_memory_order_relaxed);
-	PLT_ASSERT(res.cn20k.compcode == CPT_COMP_GOOD);
-	PLT_ASSERT(res.cn20k.uc_compcode == 0);
-#endif
+	vec = (struct rte_event_vector *)(get_work1);
 
 	for (i = 0; i < vec->nb_elem; i++) {
 		infl_req = vec->ptrs[i];
 		cop = infl_req->cop;
+		qp = infl_req->qp;
+		meta_mp = qp->meta_info.pool;
+		req_mp = qp->ca.req_mp;
 
 		res.u64[0] = rte_atomic_load_explicit(
 			(RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), rte_memory_order_relaxed);
@@ -1233,8 +1020,6 @@ cn20k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 		rte_mempool_put(req_mp, infl_req);
 	}
 
-	rte_mempool_put(req_mp, vec_infl_req);
-
 	return (uintptr_t)vec;
 }
 
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
index 56f814a142..ffcdb5a96b 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -17,6 +17,7 @@
 #endif
 
 #include "cnxk_cryptodev.h"
+#include "roc_npa.h"
 
 #define CN20K_PKTS_PER_STEORL	  32
 #define CN20K_LMTLINES_PER_STEORL 16
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 17d39aa34f..c6648bec89 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -97,6 +97,11 @@ struct crypto_adpter_info {
 	/** Maximum number of cops to combine into single vector */
 	struct rte_mempool *vector_mp;
 	/** Pool for allocating rte_event_vector */
+	uint64_t vector_timeout_ns;
+	/*
+	 * Maximum number of nanoseconds to wait for aggregating
+	 * crypto operations.
+	 */
 };
 
 struct cnxk_cpt_qp {
@@ -112,6 +117,7 @@ struct cnxk_cpt_qp {
 	/**< Crypto adapter related info */
 	struct rte_mempool *sess_mp;
 	/**< Session mempool */
+	struct cnxk_sso_evdev *evdev;
 };
 
 int cnxk_cpt_asym_get_mlen(void);
diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_worker.h
index 27cd4d5479..df0abd9202 100644
--- a/drivers/event/cnxk/cn20k_worker.h
+++ b/drivers/event/cnxk/cn20k_worker.h
@@ -170,6 +170,9 @@ cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32
 	if (CNXK_EVENT_TYPE_FROM_TAG(u64[0]) == RTE_EVENT_TYPE_CRYPTODEV) {
 		u64[1] = cn20k_cpt_crypto_adapter_dequeue(u64[1]);
 	} else if (CNXK_EVENT_TYPE_FROM_TAG(u64[0]) == RTE_EVENT_TYPE_CRYPTODEV_VECTOR) {
+		__uint128_t vwqe_hdr = *(__uint128_t *)u64[1];
+		vwqe_hdr = ((vwqe_hdr >> 64) & 0xFFF) | BIT_ULL(31) | ((vwqe_hdr & 0xFFFF) << 48);
+		*(uint64_t *)u64[1] = (uint64_t)vwqe_hdr;
 		u64[1] = cn20k_cpt_crypto_adapter_vector_dequeue(u64[1]);
 	} else if (CNXK_EVENT_TYPE_FROM_TAG(u64[0]) == RTE_EVENT_TYPE_ETHDEV) {
 		uint8_t port = CNXK_SUB_EVENT_FROM_TAG(u64[0]);
diff --git a/drivers/event/cnxk/cnxk_eventdev_adptr.c b/drivers/event/cnxk/cnxk_eventdev_adptr.c
index 80f770ee8d..d9d06d3aca 100644
--- a/drivers/event/cnxk/cnxk_eventdev_adptr.c
+++ b/drivers/event/cnxk/cnxk_eventdev_adptr.c
@@ -639,7 +639,8 @@ cnxk_sso_tx_adapter_free(uint8_t id __rte_unused,
 }
 
 static int
-crypto_adapter_qp_setup(const struct rte_cryptodev *cdev, struct cnxk_cpt_qp *qp,
+crypto_adapter_qp_setup(struct cnxk_sso_evdev *evdev, const struct rte_cryptodev *cdev,
+			struct cnxk_cpt_qp *qp,
 			const struct rte_event_crypto_adapter_queue_conf *conf)
 {
 	char name[RTE_MEMPOOL_NAMESIZE];
@@ -662,6 +663,7 @@ crypto_adapter_qp_setup(const struct rte_cryptodev *cdev, struct cnxk_cpt_qp *qp
 		return -ENOSPC;
 	}
 
+	qp->evdev = evdev;
 	qp->lmtline.fc_thresh -= nb_desc_min;
 
 	snprintf(name, RTE_MEMPOOL_NAMESIZE, "cnxk_ca_req_%u:%u", cdev->data->dev_id, qp->lf.lf_id);
@@ -676,6 +678,7 @@ crypto_adapter_qp_setup(const struct rte_cryptodev *cdev, struct cnxk_cpt_qp *qp
 	if (conf != NULL) {
 		qp->ca.vector_sz = conf->vector_sz;
 		qp->ca.vector_mp = conf->vector_mp;
+		qp->ca.vector_timeout_ns = conf->vector_timeout_ns;
 	}
 	qp->ca.enabled = true;
 
@@ -697,7 +700,7 @@ cnxk_crypto_adapter_qp_add(const struct rte_eventdev *event_dev, const struct rt
 
 		for (qp_id = 0; qp_id < cdev->data->nb_queue_pairs; qp_id++) {
 			qp = cdev->data->queue_pairs[qp_id];
-			ret = crypto_adapter_qp_setup(cdev, qp, conf);
+			ret = crypto_adapter_qp_setup(sso_evdev, cdev, qp, conf);
 			if (ret) {
 				cnxk_crypto_adapter_qp_del(cdev, -1);
 				return ret;
@@ -706,7 +709,7 @@ cnxk_crypto_adapter_qp_add(const struct rte_eventdev *event_dev, const struct rt
 		}
 	} else {
 		qp = cdev->data->queue_pairs[queue_pair_id];
-		ret = crypto_adapter_qp_setup(cdev, qp, conf);
+		ret = crypto_adapter_qp_setup(sso_evdev, cdev, qp, conf);
 		if (ret)
 			return ret;
 		adptr_xae_cnt = qp->ca.req_mp->size;
-- 
2.25.1

