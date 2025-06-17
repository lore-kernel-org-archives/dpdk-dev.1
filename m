Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE4C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 10:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8111040E2D;
	Tue, 17 Jun 2025 12:58:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 14A7240609
 for <dev@dpdk.org>; Tue, 17 Jun 2025 12:58:28 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H9FoCH031732
 for <dev@dpdk.org>; Tue, 17 Jun 2025 03:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=+0ynC6hkAqi149qB4UF1qAF
 r/qw4Xl38c78I+dZneF0=; b=FMaZvcNbUb5gBzFSFqqUcBi+FnNgXtMg4sDK7jk
 ub3oHElbgn239sCcvfGBUhf/qNYjdQzjvRX3iN7ZqUh6Gx7E2V/E82rT/WBsZPIR
 CvDmpNJSKQ/iFOxQTe2R9OrorKwojFRzGwmC8Odgl9mXO7rvGjHyiM4uQFo0RdfQ
 4UFa7ATTMQTeS5SgzOXB3ioxfp5hRz8rujD30rqkUE51Vc/qGRIsnxsypVEraVi7
 bVzhq3YWq6zmByhjRtqjDwOn3MSTZ6b80TKmG+Rbsrpdimv4yeXChvruifZ5PV6f
 xqPdUGJf4Cfx664CEg37dZuo9nXSqfWtm0M+4XLIE63Z89Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b5jcr5nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 17 Jun 2025 03:58:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 03:58:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 03:58:27 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id BCCE262676B;
 Tue, 17 Jun 2025 03:58:24 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>
Subject: [PATCH] crypto/cnxk: add crypto adapter for cn20k
Date: Tue, 17 Jun 2025 10:58:23 +0000
Message-ID: <20250617105823.105906-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=YaK95xRf c=1 sm=1 tr=0 ts=68514a53 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=q0dj6y5YAAAA:8 a=TFNM7SZaCu4IQicpeOEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Q7RaSUWP1pO7HXdsjIRs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA4OCBTYWx0ZWRfXwhsRkQafdugB
 Eq7hITzLFKA8gua4zXdf2UKdJPEkM0JGIzF4xovmXq7wLJQruRXRQvxLXncUYySXdmesnaCaGOc
 umwod/E1lM0XJrOzbS/OTQ9qBy9sW8lzSALrleW6M+Dj8hPT6fggJSanUokxFQcaHotZULu0EUk
 dCT/yF7mns8i/c6lpFi7Yrf9vFUeZ7Z8WPUTRktfJr8DylWNjpNvDXQ2LIu8Q6EX52xXdlU00gm
 hUnVA6xlpKkR03DIpOvjmGlVn2JMJkNRWWqEYr+ABvjozgvQIlNS6UQMTYkY+GOaEleIVDjmruJ
 DuL1txFkDvgHCRQYBOnTLAmEC4OZQTcqC1wZBLMAYyQaSA8TXh/00fzMEwOHJQsxO8TaLo8w2iY
 FboHmqdbtDzWVnOR5PaniKwzOQ8H1Na6pYoGVZLzHy1zCj8Yw7h1QahMxPrtZZ4URh6U526P
X-Proofpoint-GUID: hODC3VR_bP-FojmteseOJcXANdJhnG83
X-Proofpoint-ORIG-GUID: hODC3VR_bP-FojmteseOJcXANdJhnG83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_04,2025-06-13_01,2025-03-28_01
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

Add crypto adapter support for CN20K crypto PMD.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 .../crypto/cnxk/cn20k_cryptodev_event_dp.h    |  14 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 585 +++++++++++++++++-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h     |   4 +
 drivers/event/cnxk/cn20k_eventdev.c           |  69 +++
 drivers/event/cnxk/cn20k_worker.h             |   7 +-
 5 files changed, 666 insertions(+), 13 deletions(-)
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_event_dp.h

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_event_dp.h b/drivers/crypto/cnxk/cn20k_cryptodev_event_dp.h
new file mode 100644
index 0000000000..3e8784ba88
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_event_dp.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef _CN20K_CRYPTODEV_EVENT_DP_H_
+#define _CN20K_CRYPTODEV_EVENT_DP_H_
+
+__rte_internal
+uintptr_t cn20k_cpt_crypto_adapter_dequeue(uintptr_t get_work1);
+
+__rte_internal
+uintptr_t cn20k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1);
+
+#endif /* _CN20K_CRYPTODEV_EVENT_DP_H_ */
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index ba586d79e8..b0f1e33daf 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -9,34 +9,47 @@
 #include <rte_hexdump.h>
 #include <rte_vect.h>
 
+#include "hw/nix.h"
+#include "hw/npa.h"
+#include "hw/tim.h"
 #include "roc_cpt.h"
 #include "roc_idev.h"
+#include "roc_mbox.h"
+#include "roc_sso.h"
+#include "roc_sso_dp.h"
+#include "roc_tim.h"
 
 #include "cn20k_cryptodev.h"
+#include "cn20k_cryptodev_event_dp.h"
 #include "cn20k_cryptodev_ops.h"
 #include "cn20k_cryptodev_sec.h"
+#include "cn20k_eventdev.h"
 #include "cn20k_ipsec_la_ops.h"
 #include "cn20k_tls_ops.h"
 #include "cnxk_ae.h"
 #include "cnxk_cryptodev.h"
 #include "cnxk_cryptodev_ops.h"
+#include "cnxk_eventdev.h"
 #include "cnxk_se.h"
 
 #include "rte_pmd_cnxk_crypto.h"
 
-static int
-cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, void *sess,
-				      enum rte_crypto_op_type op_type,
-				      enum rte_crypto_op_sess_type sess_type, void *mdata)
-{
-	(void)dev;
-	(void)sess;
-	(void)op_type;
-	(void)sess_type;
-	(void)mdata;
+/* Holds information required to send crypto operations in one burst */
+struct ops_burst {
+	struct rte_crypto_op *op[CN20K_CPT_PKTS_PER_LOOP];
+	uint64_t w2[CN20K_CPT_PKTS_PER_LOOP];
+	struct cn20k_sso_hws *ws;
+	struct cnxk_cpt_qp *qp;
+	uint16_t nb_ops;
+};
 
-	return 0;
-}
+/* Holds information required to send vector of operations */
+struct vec_request {
+	struct cpt_inflight_req *req;
+	struct rte_event_vector *vec;
+	union cpt_inst_w7 w7;
+	uint64_t w2;
+};
 
 static inline struct cnxk_se_sess *
 cn20k_cpt_sym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
@@ -284,6 +297,485 @@ cn20k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
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
+		} else
+			return -EINVAL;
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
@@ -593,6 +1085,75 @@ cn20k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 	}
 }
 
+uintptr_t
+cn20k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
+{
+	struct cpt_inflight_req *infl_req;
+	struct rte_crypto_op *cop;
+	struct cnxk_cpt_qp *qp;
+	union cpt_res_s res;
+
+	infl_req = (struct cpt_inflight_req *)(get_work1);
+	cop = infl_req->cop;
+	qp = infl_req->qp;
+
+	res.u64[0] = rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]),
+					      rte_memory_order_relaxed);
+
+	cn20k_cpt_dequeue_post_process(qp, infl_req->cop, infl_req, &res.cn20k);
+
+	if (unlikely(infl_req->op_flags & CPT_OP_FLAGS_METABUF))
+		rte_mempool_put(qp->meta_info.pool, infl_req->mdata);
+
+	rte_mempool_put(qp->ca.req_mp, infl_req);
+	return (uintptr_t)cop;
+}
+
+uintptr_t
+cn20k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
+{
+	struct cpt_inflight_req *infl_req, *vec_infl_req;
+	struct rte_mempool *meta_mp, *req_mp;
+	struct rte_event_vector *vec;
+	struct rte_crypto_op *cop;
+	struct cnxk_cpt_qp *qp;
+	union cpt_res_s res;
+	int i;
+
+	vec_infl_req = (struct cpt_inflight_req *)(get_work1);
+
+	vec = vec_infl_req->vec;
+	qp = vec_infl_req->qp;
+	meta_mp = qp->meta_info.pool;
+	req_mp = qp->ca.req_mp;
+
+#ifdef CNXK_CRYPTODEV_DEBUG
+	res.u64[0] = rte_atomic_load_explicit((RTE_ATOMIC(uint64_t) *)(&vec_infl_req->res.u64[0]),
+					      rte_memory_order_relaxed);
+	PLT_ASSERT(res.cn20k.compcode == CPT_COMP_GOOD);
+	PLT_ASSERT(res.cn20k.uc_compcode == 0);
+#endif
+
+	for (i = 0; i < vec->nb_elem; i++) {
+		infl_req = vec->ptrs[i];
+		cop = infl_req->cop;
+
+		res.u64[0] = rte_atomic_load_explicit(
+			(RTE_ATOMIC(uint64_t) *)(&infl_req->res.u64[0]), rte_memory_order_relaxed);
+		cn20k_cpt_dequeue_post_process(qp, cop, infl_req, &res.cn20k);
+
+		vec->ptrs[i] = cop;
+		if (unlikely(infl_req->op_flags & CPT_OP_FLAGS_METABUF))
+			rte_mempool_put(meta_mp, infl_req->mdata);
+
+		rte_mempool_put(req_mp, infl_req);
+	}
+
+	rte_mempool_put(req_mp, vec_infl_req);
+
+	return (uintptr_t)vec;
+}
+
 static uint16_t
 cn20k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 {
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
index 752ca588e0..56f814a142 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -33,6 +33,10 @@ uint16_t __rte_hot cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf
 __rte_internal
 int cn20k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable);
 
+__rte_internal
+uint16_t __rte_hot cn20k_cpt_crypto_adapter_enqueue(void *ws, struct rte_event ev[],
+						    uint16_t nb_events);
+
 static __rte_always_inline void __rte_hot
 cn20k_cpt_lmtst_dual_submit(uint64_t *io_addr, const uint16_t lmt_id, int *i)
 {
diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index 0688cf97e5..7d003ae2fc 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -4,6 +4,7 @@
 
 #include "roc_api.h"
 
+#include "cn20k_cryptodev_ops.h"
 #include "cn20k_ethdev.h"
 #include "cn20k_eventdev.h"
 #include "cn20k_tx_worker.h"
@@ -346,6 +347,7 @@ cn20k_sso_fp_fns_set(struct rte_eventdev *event_dev)
 	event_dev->enqueue_new_burst = cn20k_sso_hws_enq_new_burst;
 	event_dev->enqueue_forward_burst = cn20k_sso_hws_enq_fwd_burst;
 
+	event_dev->ca_enqueue = cn20k_cpt_crypto_adapter_enqueue;
 	event_dev->profile_switch = cn20k_sso_hws_profile_switch;
 	event_dev->preschedule_modify = cn20k_sso_hws_preschedule_modify;
 	event_dev->preschedule = cn20k_sso_hws_preschedule;
@@ -1037,6 +1039,48 @@ cn20k_sso_tx_adapter_queue_del(uint8_t id, const struct rte_eventdev *event_dev,
 	return cn20k_sso_updt_tx_adptr_data(event_dev);
 }
 
+static int
+cn20k_crypto_adapter_caps_get(const struct rte_eventdev *event_dev,
+			      const struct rte_cryptodev *cdev, uint32_t *caps)
+{
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn20k", ENOTSUP);
+	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn20k", ENOTSUP);
+
+	*caps = RTE_EVENT_CRYPTO_ADAPTER_CAP_INTERNAL_PORT_OP_FWD |
+		RTE_EVENT_CRYPTO_ADAPTER_CAP_SESSION_PRIVATE_DATA |
+		RTE_EVENT_CRYPTO_ADAPTER_CAP_EVENT_VECTOR;
+
+	return 0;
+}
+
+static int
+cn20k_crypto_adapter_qp_add(const struct rte_eventdev *event_dev, const struct rte_cryptodev *cdev,
+			    int32_t queue_pair_id,
+			    const struct rte_event_crypto_adapter_queue_conf *conf)
+{
+	int ret;
+
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn20k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn20k", EINVAL);
+
+	cn20k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
+
+	ret = cnxk_crypto_adapter_qp_add(event_dev, cdev, queue_pair_id, conf);
+	cn20k_sso_set_priv_mem(event_dev, NULL);
+
+	return ret;
+}
+
+static int
+cn20k_crypto_adapter_qp_del(const struct rte_eventdev *event_dev, const struct rte_cryptodev *cdev,
+			    int32_t queue_pair_id)
+{
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn20k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn20k", EINVAL);
+
+	return cnxk_crypto_adapter_qp_del(cdev, queue_pair_id);
+}
+
 static int
 cn20k_tim_caps_get(const struct rte_eventdev *evdev, uint64_t flags, uint32_t *caps,
 		   const struct event_timer_adapter_ops **ops)
@@ -1044,6 +1088,26 @@ cn20k_tim_caps_get(const struct rte_eventdev *evdev, uint64_t flags, uint32_t *c
 	return cnxk_tim_caps_get(evdev, flags, caps, ops, cn20k_sso_set_priv_mem);
 }
 
+static int
+cn20k_crypto_adapter_vec_limits(const struct rte_eventdev *event_dev,
+				const struct rte_cryptodev *cdev,
+				struct rte_event_crypto_adapter_vector_limits *limits)
+{
+	CNXK_VALID_DEV_OR_ERR_RET(event_dev->dev, "event_cn20k", EINVAL);
+	CNXK_VALID_DEV_OR_ERR_RET(cdev->device, "crypto_cn20k", EINVAL);
+
+	limits->log2_sz = false;
+	limits->min_sz = 0;
+	limits->max_sz = UINT16_MAX;
+	/* Unused timeout, in software implementation we aggregate all crypto
+	 * operations passed to the enqueue function
+	 */
+	limits->min_timeout_ns = 0;
+	limits->max_timeout_ns = 0;
+
+	return 0;
+}
+
 static struct eventdev_ops cn20k_sso_dev_ops = {
 	.dev_infos_get = cn20k_sso_info_get,
 	.dev_configure = cn20k_sso_dev_configure,
@@ -1081,6 +1145,11 @@ static struct eventdev_ops cn20k_sso_dev_ops = {
 
 	.timer_adapter_caps_get = cn20k_tim_caps_get,
 
+	.crypto_adapter_caps_get = cn20k_crypto_adapter_caps_get,
+	.crypto_adapter_queue_pair_add = cn20k_crypto_adapter_qp_add,
+	.crypto_adapter_queue_pair_del = cn20k_crypto_adapter_qp_del,
+	.crypto_adapter_vector_limits_get = cn20k_crypto_adapter_vec_limits,
+
 	.xstats_get = cnxk_sso_xstats_get,
 	.xstats_reset = cnxk_sso_xstats_reset,
 	.xstats_get_names = cnxk_sso_xstats_get_names,
diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_worker.h
index 6ed1f78a86..27cd4d5479 100644
--- a/drivers/event/cnxk/cn20k_worker.h
+++ b/drivers/event/cnxk/cn20k_worker.h
@@ -8,6 +8,7 @@
 #include <rte_event_timer_adapter.h>
 #include <rte_eventdev.h>
 
+#include "cn20k_cryptodev_event_dp.h"
 #include "cn20k_eventdev.h"
 #include "cn20k_rx.h"
 #include "cnxk_worker.h"
@@ -166,7 +167,11 @@ cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32
 
 	u64[0] = (u64[0] & (0x3ull << 32)) << 6 | (u64[0] & (0x3FFull << 36)) << 4 |
 		 (u64[0] & 0xffffffff);
-	if (CNXK_EVENT_TYPE_FROM_TAG(u64[0]) == RTE_EVENT_TYPE_ETHDEV) {
+	if (CNXK_EVENT_TYPE_FROM_TAG(u64[0]) == RTE_EVENT_TYPE_CRYPTODEV) {
+		u64[1] = cn20k_cpt_crypto_adapter_dequeue(u64[1]);
+	} else if (CNXK_EVENT_TYPE_FROM_TAG(u64[0]) == RTE_EVENT_TYPE_CRYPTODEV_VECTOR) {
+		u64[1] = cn20k_cpt_crypto_adapter_vector_dequeue(u64[1]);
+	} else if (CNXK_EVENT_TYPE_FROM_TAG(u64[0]) == RTE_EVENT_TYPE_ETHDEV) {
 		uint8_t port = CNXK_SUB_EVENT_FROM_TAG(u64[0]);
 		uintptr_t cpth = 0;
 		uint64_t mbuf;
-- 
2.48.1

