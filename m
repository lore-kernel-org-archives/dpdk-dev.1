Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D20C36010
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 11:11:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DC8B40A7F;
	Thu, 27 Mar 2025 12:11:31 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 91B0340A79
 for <dev@dpdk.org>; Thu, 27 Mar 2025 12:11:28 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R76qtQ008146
 for <dev@dpdk.org>; Thu, 27 Mar 2025 04:11:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=YQFg3eWax3F698M9cFBES5l
 hFeguhIYx5j1x/EVkmxI=; b=UDSrtClKl//53ocA+PoUvS1j2jlOzYUnMv33gb3
 86L3B/428wF6LOvryfoSoRZGKIUXImIMPmsnJfDoofVprBIYxC1yQ3KFP9vvj4u6
 jSRsjm2cj9zG101SHqyKtlbhaSfQa4UsYdG0KsFuWadXeGkDQZizt79+VBPe+3Ix
 eADUbCTxRatZJjz7TGS/f38zCHoY7Q9ko07Ho02Y61WrhsQmoEFyiG1DSQafOxCK
 ZEJ9VYs8z4iF0Pi3UJjul/2kbQxkkdALsxypqYJ44OxSASmp8kFebl4PJJDAmwY7
 C0SIuzhTmX1pEg0tENzZfS1Te9faldOrFccl4vOdup8+MKg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45n20agg9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 27 Mar 2025 04:11:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Mar 2025 04:11:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Mar 2025 04:11:26 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 3D8993F707F;
 Thu, 27 Mar 2025 04:11:23 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, "Nithin
 Dabilpuram" <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] cnxk: use stdatomic API
Date: Thu, 27 Mar 2025 16:41:20 +0530
Message-ID: <20250327111120.1641-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5FCyQiZuwAkEKWeHE-KrlJ-n9hFSN2Qa
X-Proofpoint-ORIG-GUID: 5FCyQiZuwAkEKWeHE-KrlJ-n9hFSN2Qa
X-Authority-Analysis: v=2.4 cv=UtRjN/wB c=1 sm=1 tr=0 ts=67e5325f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=lUobqt4Twj8pGbyGuNwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
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
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 36 ++++++++++---------
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c  | 20 +++++------
 drivers/net/cnxk/cn10k_tx.h               | 42 +++++++++++++----------
 drivers/net/cnxk/cn20k_tx.h               | 39 ++++++++++++---------
 drivers/net/cnxk/cn9k_tx.h                |  5 +--
 5 files changed, 79 insertions(+), 63 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index dbebc5aef1..fe28c7529d 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -292,7 +292,7 @@ cn10k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 	}
 
 	inst[0].res_addr = (uint64_t)&infl_req->res;
-	__atomic_store_n(&infl_req->res.u64[0], res.u64[0], __ATOMIC_RELAXED);
+	rte_atomic_store_explicit(&infl_req->res.u64[0], res.u64[0], rte_memory_order_relaxed);
 	infl_req->cop = op;
 
 	inst[0].w7.u64 = w7;
@@ -361,7 +361,7 @@ cn10k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops,
 	inst = (struct cpt_inst_s *)lmt_base;
 
 again:
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		i = 0;
 		goto pend_q_commit;
@@ -392,7 +392,7 @@ cn10k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops,
 	}
 
 pend_q_commit:
-	rte_atomic_thread_fence(__ATOMIC_RELEASE);
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	pend_q->head = head;
 	pend_q->time_out = rte_get_timer_cycles() +
@@ -541,7 +541,7 @@ cn10k_cpt_vec_inst_fill(struct vec_request *vec_req, struct cpt_inst_s *inst,
 	infl_req->qp = qp;
 
 	inst->res_addr = (uint64_t)&infl_req->res;
-	__atomic_store_n(&infl_req->res.u64[0], res.u64[0], __ATOMIC_RELAXED);
+	rte_atomic_store_explicit(&infl_req->res.u64[0], res.u64[0], rte_memory_order_relaxed);
 
 	inst->w0.u64 = 0;
 	inst->w2.u64 = vec_req->w2;
@@ -593,7 +593,7 @@ cn10k_cpt_vec_submit(struct vec_request vec_tbl[], uint16_t vec_tbl_len, struct
 		cn10k_cpt_vec_inst_fill(&vec_tbl[i], &inst[i], qp, vec_tbl[0].w7);
 
 	do {
-		fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+		fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 		if (likely(fc.s.qsize < fc_thresh))
 			break;
 		if (unlikely(rte_get_timer_cycles() > timeout))
@@ -644,7 +644,7 @@ ca_lmtst_vec_submit(struct ops_burst *burst, struct vec_request vec_tbl[], uint1
 #endif
 
 	/* Perform fc check before putting packets into vectors */
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		rte_errno = EAGAIN;
 		return 0;
@@ -789,7 +789,7 @@ ca_lmtst_burst_submit(struct ops_burst *burst, const bool is_sg_ver2)
 		inst->w3.u64 = CNXK_CPT_INST_W3(1, infl_req);
 	}
 
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		rte_errno = EAGAIN;
 		for (j = 0; j < i; j++) {
@@ -1237,7 +1237,7 @@ cn10k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 	cop = infl_req->cop;
 	qp = infl_req->qp;
 
-	res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+	res.u64[0] = rte_atomic_load_explicit(&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 	cn10k_cpt_dequeue_post_process(qp, infl_req->cop, infl_req, &res.cn10k);
 
@@ -1267,7 +1267,7 @@ cn10k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 	req_mp = qp->ca.req_mp;
 
 #ifdef CNXK_CRYPTODEV_DEBUG
-	res.u64[0] = __atomic_load_n(&vec_infl_req->res.u64[0], __ATOMIC_RELAXED);
+	res.u64[0] = rte_atomic_load_explicit(&vec_infl_req->res.u64[0], rte_memory_order_relaxed);
 	PLT_ASSERT(res.cn10k.compcode == CPT_COMP_GOOD);
 	PLT_ASSERT(res.cn10k.uc_compcode == 0);
 #endif
@@ -1276,7 +1276,8 @@ cn10k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 		infl_req = vec->ptrs[i];
 		cop = infl_req->cop;
 
-		res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+		res.u64[0] =
+			rte_atomic_load_explicit(&infl_req->res.u64[0], rte_memory_order_relaxed);
 		cn10k_cpt_dequeue_post_process(qp, cop, infl_req, &res.cn10k);
 
 		vec->ptrs[i] = cop;
@@ -1316,8 +1317,8 @@ cn10k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	for (i = 0; i < nb_ops; i++) {
 		infl_req = &pend_q->req_queue[pq_tail];
 
-		res.u64[0] = __atomic_load_n(&infl_req->res.u64[0],
-					     __ATOMIC_RELAXED);
+		res.u64[0] =
+			rte_atomic_load_explicit(&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 		if (unlikely(res.cn10k.compcode == CPT_COMP_NOT_DONE)) {
 			if (unlikely(rte_get_timer_cycles() >
@@ -1569,7 +1570,7 @@ cn10k_cpt_raw_fill_inst(struct cnxk_iov *iov, struct cnxk_cpt_qp *qp,
 		return 0;
 
 	inst[0].res_addr = (uint64_t)&infl_req->res;
-	__atomic_store_n(&infl_req->res.u64[0], res.u64[0], __ATOMIC_RELAXED);
+	rte_atomic_store_explicit(&infl_req->res.u64[0], res.u64[0], rte_memory_order_relaxed);
 	infl_req->opaque = opaque;
 
 	inst[0].w7.u64 = sess->cpt_inst_w7;
@@ -1615,7 +1616,7 @@ cn10k_cpt_raw_enqueue_burst(void *qpair, uint8_t *drv_ctx, struct rte_crypto_sym
 
 	dp_ctx = (struct cnxk_sym_dp_ctx *)drv_ctx;
 again:
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		i = 0;
 		goto pend_q_commit;
@@ -1716,7 +1717,7 @@ cn10k_cpt_raw_enqueue(void *qpair, uint8_t *drv_ctx, struct rte_crypto_vec *data
 	ROC_LMT_BASE_ID_GET(lmt_base, lmt_id);
 	inst = (struct cpt_inst_s *)lmt_base;
 
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh))
 		return -1;
 
@@ -1819,7 +1820,8 @@ cn10k_cpt_sym_raw_dequeue_burst(void *qptr, uint8_t *drv_ctx,
 		is_op_success = 0;
 		infl_req = &pend_q->req_queue[pq_tail];
 
-		res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+		res.u64[0] =
+			rte_atomic_load_explicit(&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 		if (unlikely(res.cn10k.compcode == CPT_COMP_NOT_DONE)) {
 			if (unlikely(rte_get_timer_cycles() > pend_q->time_out)) {
@@ -1880,7 +1882,7 @@ cn10k_cpt_sym_raw_dequeue(void *qptr, uint8_t *drv_ctx, int *dequeue_status,
 
 	infl_req = &pend_q->req_queue[pq_tail];
 
-	res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+	res.u64[0] = rte_atomic_load_explicit(&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 	if (unlikely(res.cn10k.compcode == CPT_COMP_NOT_DONE)) {
 		if (unlikely(rte_get_timer_cycles() > pend_q->time_out)) {
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index 2b1bd70c6d..e55f5690a3 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -194,12 +194,12 @@ cn9k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 		infl_req_1->op_flags = 0;
 		infl_req_2->op_flags = 0;
 
-		__atomic_store_n(&infl_req_1->res.u64[0], res.u64[0],
-				 __ATOMIC_RELAXED);
+		rte_atomic_store_explicit(&infl_req_1->res.u64[0], res.u64[0],
+					  rte_memory_order_relaxed);
 		inst[0].res_addr = (uint64_t)&infl_req_1->res;
 
-		__atomic_store_n(&infl_req_2->res.u64[0], res.u64[0],
-				 __ATOMIC_RELAXED);
+		rte_atomic_store_explicit(&infl_req_2->res.u64[0], res.u64[0],
+					  rte_memory_order_relaxed);
 		inst[1].res_addr = (uint64_t)&infl_req_2->res;
 
 		ret = cn9k_cpt_inst_prep(qp, op_1, infl_req_1, &inst[0]);
@@ -223,7 +223,7 @@ cn9k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 		count += 2;
 	}
 
-	rte_atomic_thread_fence(__ATOMIC_RELEASE);
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	pend_q->head = head;
 	pend_q->time_out = rte_get_timer_cycles() +
@@ -385,7 +385,7 @@ cn9k_cpt_crypto_adapter_enqueue(uintptr_t base, struct rte_crypto_op *op)
 
 	const uint32_t fc_thresh = qp->lmtline.fc_thresh;
 
-	fc.u64[0] = __atomic_load_n(fc_addr, __ATOMIC_RELAXED);
+	fc.u64[0] = rte_atomic_load_explicit(fc_addr, rte_memory_order_relaxed);
 	if (unlikely(fc.s.qsize > fc_thresh)) {
 		rte_mempool_put(qp->ca.req_mp, infl_req);
 		rte_errno = EAGAIN;
@@ -604,7 +604,7 @@ cn9k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 	cop = infl_req->cop;
 	qp = infl_req->qp;
 
-	res.u64[0] = __atomic_load_n(&infl_req->res.u64[0], __ATOMIC_RELAXED);
+	res.u64[0] = rte_atomic_load_explicit(&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 	cn9k_cpt_dequeue_post_process(qp, infl_req->cop, infl_req, &res.cn9k);
 
@@ -635,13 +635,13 @@ cn9k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	nb_ops = RTE_MIN(nb_ops, infl_cnt);
 
 	/* Ensure infl_cnt isn't read before data lands */
-	rte_atomic_thread_fence(__ATOMIC_ACQUIRE);
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	for (i = 0; i < nb_ops; i++) {
 		infl_req = &pend_q->req_queue[pq_tail];
 
-		res.u64[0] = __atomic_load_n(&infl_req->res.u64[0],
-					     __ATOMIC_RELAXED);
+		res.u64[0] =
+			rte_atomic_load_explicit(&infl_req->res.u64[0], rte_memory_order_relaxed);
 
 		if (unlikely(res.cn9k.compcode == CPT_COMP_NOT_DONE)) {
 			if (unlikely(rte_get_timer_cycles() >
diff --git a/drivers/net/cnxk/cn10k_tx.h b/drivers/net/cnxk/cn10k_tx.h
index 809fafb2f7..f6dc69983c 100644
--- a/drivers/net/cnxk/cn10k_tx.h
+++ b/drivers/net/cnxk/cn10k_tx.h
@@ -55,17 +55,19 @@
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
diff --git a/drivers/net/cnxk/cn20k_tx.h b/drivers/net/cnxk/cn20k_tx.h
index c419778970..8c3cb05e7d 100644
--- a/drivers/net/cnxk/cn20k_tx.h
+++ b/drivers/net/cnxk/cn20k_tx.h
@@ -53,17 +53,19 @@
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
diff --git a/drivers/net/cnxk/cn9k_tx.h b/drivers/net/cnxk/cn9k_tx.h
index 902a17860c..af7a5bdfe9 100644
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
@@ -599,7 +600,7 @@ cn9k_nix_sec_fc_wait_one(const struct cn9k_eth_txq *txq)
 	uint64_t nb_desc = txq->cpt_desc;
 	uint64_t *fc = txq->cpt_fc;
 
-	while (nb_desc <= __atomic_load_n(fc, __ATOMIC_RELAXED))
+	while (nb_desc <= rte_atomic_load_explicit(fc, rte_memory_order_relaxed))
 		;
 }
 
-- 
2.43.0

