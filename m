Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E36BC54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:54:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC07240E2B;
	Fri, 23 May 2025 15:52:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 12901406B8
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:30 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8SK006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 tX8YAWGG+p0HzEsulwgw+JKZJN79yNCj1Xs7QPxOng=; b=A+53zcRPYXgCVlEkL
 jHDW7DLFNWck/XK8f4/QGhHh+l2r9Y9A+biN2LUPZNNm+QtE8fq9B8pSEDqUcqIO
 Q0mccu6apN/vnMkoaqOpJpeI8bgUCDtITJ9IiCjmBLvM2MbmNhb0pMI13m7mPsV6
 VCLRJJ0GUlGUHKrP9Jp2/Rqn8hKwFro4UwlXP3imQoplwG2AgqdNuDU+6SWfnhTy
 MK8Zq98Dbx25Y66urHfC073Yogk4OreaUHkzwGjYGLL32o0+HENnIQgpKxhYpuo7
 f8CelzrmjZha5XdBR9ExqaBGruuEpSXak5/WyxuHSGncvVXLdpdtklIltg26n3HI
 00gUA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-12
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:57 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 96F2D3F704F;
 Fri, 23 May 2025 06:51:54 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 13/40] crypto/cnxk: add cryptodev dequeue support for cn20k
Date: Fri, 23 May 2025 19:20:44 +0530
Message-ID: <20250523135111.2178408-14-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX+3yANH63A7OB
 XFpns09n9Dpnu7yXZMt42yG1i2sF2lfPtFvDTF3QfakiM0rAJBfvOSR7cq8TJApw6u7CSfaV8E7
 8S71PJDGPxQn8H3AI3WEI7c5Ae2lqE0Al1Mu3QhxFKNhdHoUgOs5V6daX2b6M1fmQ8Y23ObCRYg
 nB5kFuUrSHpw1dWcEjZPjUcK5hGkoxIxFDfQN14bwLu2ytwFGE3DRgcL/dfbbWGEI84efRpnwJb
 naVSt89UvTD0Lx62yXPzBFNe1fxWOmSfoUpmIrhOCVXrdR/P+zIwW3LojjbwVbtOFxlBJq6467k
 GG44GK35mEKjENJl4qZpMtIKTn0eTmfGpQJ62JzRfBg2AVaKRQggr1+KNwaHw6OJHLbRKnypfVs
 3JuTDaxyCstuQDAHXSGBNEhxoapYMe+ZmfSUWdVldnR1pl9xsnm3ay80JGu8qXK4DCPZhpbc
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d9e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ZtNhUn4JJ_VNKK7vbDYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Rv9bA-bgwHM7YHO257dtRPYxy0Vs3uRT
X-Proofpoint-ORIG-GUID: Rv9bA-bgwHM7YHO257dtRPYxy0Vs3uRT
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

Add dequeue support in cryptodev for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 141 +++++++++++++++++++++-
 1 file changed, 137 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index c59a6dab59..dbfaa2322a 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -223,14 +223,147 @@ cn20k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	return count + i;
 }
 
+static inline void
+cn20k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop,
+			       struct cpt_inflight_req *infl_req, struct cpt_cn20k_res_s *res)
+{
+	const uint8_t uc_compcode = res->uc_compcode;
+	const uint8_t compcode = res->compcode;
+
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+
+	if (cop->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC &&
+	    cop->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+		struct cnxk_ae_sess *sess;
+
+		sess = (struct cnxk_ae_sess *)cop->asym->session;
+		if (sess->xfrm_type == RTE_CRYPTO_ASYM_XFORM_ECDH &&
+		    cop->asym->ecdh.ke_type == RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY) {
+			if (likely(compcode == CPT_COMP_GOOD)) {
+				if (uc_compcode == ROC_AE_ERR_ECC_POINT_NOT_ON_CURVE) {
+					cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+					return;
+				} else if (uc_compcode == ROC_AE_ERR_ECC_PAI) {
+					cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+					return;
+				}
+			}
+		}
+	}
+
+	if (likely(compcode == CPT_COMP_GOOD)) {
+#ifdef CPT_INST_DEBUG_ENABLE
+		cpt_request_data_sgv2_mode_dump(infl_req->rptr, 0, infl_req->scatter_sz);
+#endif
+
+		if (unlikely(uc_compcode)) {
+			if (uc_compcode == ROC_SE_ERR_GC_ICV_MISCOMPARE)
+				cop->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
+			else
+				cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+
+			plt_dp_info("Request failed with microcode error");
+			plt_dp_info("MC completion code 0x%x", res->uc_compcode);
+			cop->aux_flags = uc_compcode;
+			goto temp_sess_free;
+		}
+
+		if (cop->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+			/* Verify authentication data if required */
+			if (unlikely(infl_req->op_flags & CPT_OP_FLAGS_AUTH_VERIFY)) {
+				uintptr_t *rsp = infl_req->mdata;
+
+				compl_auth_verify(cop, (uint8_t *)rsp[0], rsp[1]);
+			}
+		} else if (cop->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
+			struct rte_crypto_asym_op *op = cop->asym;
+			uintptr_t *mdata = infl_req->mdata;
+			struct cnxk_ae_sess *sess = (struct cnxk_ae_sess *)op->session;
+
+			cnxk_ae_post_process(cop, sess, (uint8_t *)mdata[0]);
+		}
+	} else {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		plt_dp_info("HW completion code 0x%x", res->compcode);
+
+		switch (compcode) {
+		case CPT_COMP_INSTERR:
+			plt_dp_err("Request failed with instruction error");
+			break;
+		case CPT_COMP_FAULT:
+			plt_dp_err("Request failed with DMA fault");
+			break;
+		case CPT_COMP_HWERR:
+			plt_dp_err("Request failed with hardware error");
+			break;
+		default:
+			plt_dp_err("Request failed with unknown completion code");
+		}
+	}
+
+temp_sess_free:
+	if (unlikely(cop->sess_type == RTE_CRYPTO_OP_SESSIONLESS)) {
+		if (cop->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
+			sym_session_clear(cop->sym->session, true);
+			rte_mempool_put(qp->sess_mp, cop->sym->session);
+			cop->sym->session = NULL;
+		}
+	}
+}
+
 static uint16_t
 cn20k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 {
-	(void)qptr;
-	(void)ops;
-	(void)nb_ops;
+	struct cpt_inflight_req *infl_req;
+	struct cnxk_cpt_qp *qp = qptr;
+	struct pending_queue *pend_q;
+	uint64_t infl_cnt, pq_tail;
+	struct rte_crypto_op *cop;
+	union cpt_res_s res;
+	int i;
 
-	return 0;
+	pend_q = &qp->pend_q;
+
+	const uint64_t pq_mask = pend_q->pq_mask;
+
+	pq_tail = pend_q->tail;
+	infl_cnt = pending_queue_infl_cnt(pend_q->head, pq_tail, pq_mask);
+	nb_ops = RTE_MIN(nb_ops, infl_cnt);
+
+	/* Ensure infl_cnt isn't read before data lands */
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+
+	for (i = 0; i < nb_ops; i++) {
+		infl_req = &pend_q->req_queue[pq_tail];
+
+		res.u64[0] =
+			rte_atomic_load_explicit(&infl_req->res.u64[0], rte_memory_order_relaxed);
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
+		cop = infl_req->cop;
+
+		ops[i] = cop;
+
+		cn20k_cpt_dequeue_post_process(qp, cop, infl_req, &res.cn20k);
+
+		if (unlikely(infl_req->op_flags & CPT_OP_FLAGS_METABUF))
+			rte_mempool_put(qp->meta_info.pool, infl_req->mdata);
+	}
+
+	pend_q->tail = pq_tail;
+
+	return i;
 }
 
 void
-- 
2.25.1

