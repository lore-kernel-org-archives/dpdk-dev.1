Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07835C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C66E406B7;
	Fri, 23 May 2025 15:51:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7EADE400D7
 for <dev@dpdk.org>; Fri, 23 May 2025 15:51:56 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9rRDj017080
 for <dev@dpdk.org>; Fri, 23 May 2025 06:51:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 b6sYVKhbGQqynll66zQuZvUdDIBXzPdTjG1Bm+2cwk=; b=JIAsOrOhHHdCdb6IZ
 ndRyHpxSpN62lZo1gQjgCwFJpW9c1jzZO0uKDUUr2Y8Qdv4EBLs792T/71R0MfTL
 Q8isLqt4/zOX6NLzuktakwTHzFu+6/HN/2xcvWIlEQdqrylhEwjAV+Fxg/rxDTks
 +VNrjcMxrU8HmkBj9nCnPez3ZrG2UjIwybe+1jnGZGufNa4qhsge0MJ789Bmx/g4
 psZOJI8zcXmKR6M8yzkAGDErN6H76hHcnA/ug9KZr4F5Lw1yIYRyBfehgmrfIQIZ
 g/QF59tJofD245dqPs5EWoilF3k1o94neOXoaNItM9PCie4lAaj4q0VxOHNrVxXo
 WzWHA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tmgp8spw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:51:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:54 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 2DBF03F704F;
 Fri, 23 May 2025 06:51:50 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 12/40] crypto/cnxk: add enqueue function support
Date: Fri, 23 May 2025 19:20:43 +0530
Message-ID: <20250523135111.2178408-13-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0SPYHMHb1cBp4nXW1z8cq3I2pr1nZqjp
X-Proofpoint-ORIG-GUID: 0SPYHMHb1cBp4nXW1z8cq3I2pr1nZqjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXxIyoWI8iDxEv
 yrMMMs5FMLruzfdCHZwTdRXGupF32a62XUUynZ+gGYkCChvDUhW/j1qOMcGdYJJlSEf46W+sxa/
 znVFdlFzg+YCjJONlbWrzRqXpGqsx2xc81+sGxmSm/+qE4rOwtq7BShpON6r5o3Sl7uPVnaT1RN
 l1DqLjj5HPY4gKOcKaj+V+gOMcgtbLO65FL5xfFu3OVboA6tdDkdapqbtDOLbSfaA26p6tEtqnY
 5UqTgJnkf8F2SJl+s0QDk1VKjOoOxYhC/KAVUMz8zOOnCqTRwTCp/dwtCKbDqQ/fJSB1MH+UMg1
 EDexvnAxYgSZkKXtpeJXjC1QvXTpsfjaycueETp82xGnAWdWBNm3gsHtEuqIjGvcF3YtwGelJYx
 LP8Z1Gko2krvgOLlucYvPwhjmR2Z0GbcUz5jG4VIV4iMlqv7wUW/jKb70qWeMc3rK/XKxEPD
X-Authority-Analysis: v=2.4 cv=KYPSsRYD c=1 sm=1 tr=0 ts=68307d7b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=FvBXgo9mQ-onvgMoz1IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

Add cryptodev enqueue function support for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev.c     |   2 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 193 +++++++++++++++++++++-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h |   2 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h  |  11 +-
 4 files changed, 195 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev.c b/drivers/crypto/cnxk/cn20k_cryptodev.c
index 0845c1e20d..4c70c15ca9 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev.c
@@ -92,7 +92,7 @@ cn20k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_
 	dev->feature_flags = cnxk_cpt_default_ff_get();
 
 	dev->qp_depth_used = cnxk_cpt_qp_depth_used;
-	cn20k_cpt_set_enqdeq_fns(dev, vf);
+	cn20k_cpt_set_enqdeq_fns(dev);
 
 	rte_cryptodev_pmd_probing_finish(dev);
 
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index e3bea9aaf6..c59a6dab59 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -10,6 +10,7 @@
 
 #include "cn20k_cryptodev.h"
 #include "cn20k_cryptodev_ops.h"
+#include "cnxk_ae.h"
 #include "cnxk_cryptodev.h"
 #include "cnxk_cryptodev_ops.h"
 #include "cnxk_se.h"
@@ -30,14 +31,196 @@ cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, vo
 	return 0;
 }
 
+static inline struct cnxk_se_sess *
+cn20k_cpt_sym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
+{
+	struct rte_crypto_sym_op *sym_op = op->sym;
+	struct rte_cryptodev_sym_session *sess;
+	struct cnxk_se_sess *priv;
+	int ret;
+
+	/* Create temporary session */
+	if (rte_mempool_get(qp->sess_mp, (void **)&sess) < 0)
+		return NULL;
+
+	ret = sym_session_configure(qp->lf.roc_cpt, sym_op->xform, sess, true);
+	if (ret) {
+		rte_mempool_put(qp->sess_mp, (void *)sess);
+		goto sess_put;
+	}
+
+	priv = (void *)sess;
+	sym_op->session = sess;
+
+	return priv;
+
+sess_put:
+	rte_mempool_put(qp->sess_mp, sess);
+	return NULL;
+}
+
+static inline int
+cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct cpt_inst_s inst[],
+		    struct cpt_inflight_req *infl_req)
+{
+	struct rte_crypto_asym_op *asym_op;
+	struct rte_crypto_sym_op *sym_op;
+	struct cnxk_ae_sess *ae_sess;
+	struct cnxk_se_sess *sess;
+	struct rte_crypto_op *op;
+	uint64_t w7;
+	int ret;
+
+	const union cpt_res_s res = {
+		.cn20k.compcode = CPT_COMP_NOT_DONE,
+	};
+
+	op = ops[0];
+
+	inst[0].w0.u64 = 0;
+	inst[0].w2.u64 = 0;
+	inst[0].w3.u64 = 0;
+
+	sym_op = op->sym;
+
+	if (op->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+		if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+			sess = (struct cnxk_se_sess *)(sym_op->session);
+			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], true);
+			if (unlikely(ret))
+				return 0;
+			w7 = sess->cpt_inst_w7;
+		} else {
+			sess = cn20k_cpt_sym_temp_sess_create(qp, op);
+			if (unlikely(sess == NULL)) {
+				plt_dp_err("Could not create temp session");
+				return 0;
+			}
+
+			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], true);
+			if (unlikely(ret)) {
+				sym_session_clear(op->sym->session, true);
+				rte_mempool_put(qp->sess_mp, op->sym->session);
+				return 0;
+			}
+			w7 = sess->cpt_inst_w7;
+		}
+	} else if (op->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+
+		if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+			asym_op = op->asym;
+			ae_sess = (struct cnxk_ae_sess *)asym_op->session;
+			ret = cnxk_ae_enqueue(qp, op, infl_req, &inst[0], ae_sess);
+			if (unlikely(ret))
+				return 0;
+			w7 = ae_sess->cpt_inst_w7;
+		} else {
+			plt_dp_err("Not supported Asym op without session");
+			return 0;
+		}
+	} else {
+		plt_dp_err("Unsupported op type");
+		return 0;
+	}
+
+	inst[0].res_addr = (uint64_t)&infl_req->res;
+	rte_atomic_store_explicit(&infl_req->res.u64[0], res.u64[0], rte_memory_order_relaxed);
+	infl_req->cop = op;
+
+	inst[0].w7.u64 = w7;
+
+#ifdef CPT_INST_DEBUG_ENABLE
+	infl_req->dptr = (uint8_t *)inst[0].dptr;
+	infl_req->rptr = (uint8_t *)inst[0].rptr;
+	infl_req->scatter_sz = inst[0].w6.s.scatter_sz;
+	infl_req->opcode_major = inst[0].w4.s.opcode_major;
+
+	rte_hexdump(rte_log_get_stream(), "cptr", (void *)(uint64_t)inst[0].w7.s.cptr, 128);
+	plt_err("major opcode:%d", inst[0].w4.s.opcode_major);
+	plt_err("minor opcode:%d", inst[0].w4.s.opcode_minor);
+	plt_err("param1:%d", inst[0].w4.s.param1);
+	plt_err("param2:%d", inst[0].w4.s.param2);
+	plt_err("dlen:%d", inst[0].w4.s.dlen);
+
+	cpt_request_data_sgv2_mode_dump((void *)inst[0].dptr, 1, inst[0].w5.s.gather_sz);
+	cpt_request_data_sgv2_mode_dump((void *)inst[0].rptr, 0, inst[0].w6.s.scatter_sz);
+#endif
+
+	return 1;
+}
+
 static uint16_t
 cn20k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 {
-	(void)qptr;
-	(void)ops;
-	(void)nb_ops;
+	struct cpt_inflight_req *infl_req;
+	uint64_t head, lmt_base, io_addr;
+	uint16_t nb_allowed, count = 0;
+	struct cnxk_cpt_qp *qp = qptr;
+	struct pending_queue *pend_q;
+	struct cpt_inst_s *inst;
+	union cpt_fc_write_s fc;
+	uint64_t *fc_addr;
+	uint16_t lmt_id;
+	int ret, i;
 
-	return 0;
+	pend_q = &qp->pend_q;
+
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
+again:
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
+	if (unlikely(fc.s.qsize > fc_thresh)) {
+		i = 0;
+		goto pend_q_commit;
+	}
+
+	for (i = 0; i < RTE_MIN(CN20K_CPT_PKTS_PER_LOOP, nb_ops); i++) {
+		infl_req = &pend_q->req_queue[head];
+		infl_req->op_flags = 0;
+
+		ret = cn20k_cpt_fill_inst(qp, ops + i, &inst[i], infl_req);
+		if (unlikely(ret != 1)) {
+			plt_dp_err("Could not process op: %p", ops + i);
+			if (i == 0)
+				goto pend_q_commit;
+			break;
+		}
+
+		pending_queue_advance(&head, pq_mask);
+	}
+
+	cn20k_cpt_lmtst_dual_submit(&io_addr, lmt_id, &i);
+
+	if (nb_ops - i > 0 && i == CN20K_CPT_PKTS_PER_LOOP) {
+		nb_ops -= CN20K_CPT_PKTS_PER_LOOP;
+		ops += CN20K_CPT_PKTS_PER_LOOP;
+		count += CN20K_CPT_PKTS_PER_LOOP;
+		goto again;
+	}
+
+pend_q_commit:
+	rte_atomic_thread_fence(rte_memory_order_release);
+
+	pend_q->head = head;
+	pend_q->time_out = rte_get_timer_cycles() + DEFAULT_COMMAND_TIMEOUT * rte_get_timer_hz();
+
+	return count + i;
 }
 
 static uint16_t
@@ -51,7 +234,7 @@ cn20k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 }
 
 void
-cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev, struct cnxk_cpt_vf *vf)
+cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev)
 {
 	dev->enqueue_burst = cn20k_cpt_enqueue_burst;
 	dev->dequeue_burst = cn20k_cpt_dequeue_burst;
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
index 3e2ad1e2df..bdd6f71022 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -23,7 +23,7 @@
 
 extern struct rte_cryptodev_ops cn20k_cpt_ops;
 
-void cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev, struct cnxk_cpt_vf *vf);
+void cn20k_cpt_set_enqdeq_fns(struct rte_cryptodev *dev);
 
 static __rte_always_inline void __rte_hot
 cn20k_cpt_lmtst_dual_submit(uint64_t *io_addr, const uint16_t lmt_id, int *i)
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 54d32abc9c..6ad52ec13e 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -32,14 +32,13 @@
 
 #define MOD_INC(i, l) ((i) == (l - 1) ? (i) = 0 : (i)++)
 
-#define CN10K_CPT_PKTS_PER_LOOP	  64
+#define CN10K_CPT_PKTS_PER_LOOP 64
+#define CN20K_CPT_PKTS_PER_LOOP 64
 
 /* Macros to form words in CPT instruction */
-#define CNXK_CPT_INST_W2(tag, tt, grp, rvu_pf_func)                            \
-	((tag) | ((uint64_t)(tt) << 32) | ((uint64_t)(grp) << 34) |            \
-	 ((uint64_t)(rvu_pf_func) << 48))
-#define CNXK_CPT_INST_W3(qord, wqe_ptr)                                        \
-	(qord | ((uintptr_t)(wqe_ptr) >> 3) << 3)
+#define CNXK_CPT_INST_W2(tag, tt, grp, rvu_pf_func)                                                \
+	((tag) | ((uint64_t)(tt) << 32) | ((uint64_t)(grp) << 34) | ((uint64_t)(rvu_pf_func) << 48))
+#define CNXK_CPT_INST_W3(qord, wqe_ptr) (qord | ((uintptr_t)(wqe_ptr) >> 3) << 3)
 
 struct cpt_qp_meta_info {
 	struct rte_mempool *pool;
-- 
2.25.1

