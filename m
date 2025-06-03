Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38647C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:52:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D90540B9F;
	Tue,  3 Jun 2025 13:51:07 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 03AFD40A77
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:51:04 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553AJGr3020925
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:51:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 jP1zJ2wize+hq3EoOiHRjryvNeJbRGso2iUqamWh10=; b=OzQ3lHKhYDWBAurzT
 Pc01pT9uHjCahmO/SgLkJ3w7GUNy9uMAP80EMZlbqNbUcUnEPwnuaWqFGcx0IBDl
 4NNXYl4s3xZoDREtwf1Qx/AD7TNCe7N6Y7IzueRAvvldpvDUcSFXIUp8jcpWFXbD
 GXde/QXVu0/BN3+C218byOkkfab0Gyus+Yg7cpYC6H30ZZGL81SOWOYjOi3ruXeM
 xs76N4NyTchsPu+9pJVN3s6GSSeQ9dWJHPKyecVta424cSwmtl3aWUfORIH+Zl72
 F7Lihpqa8d17g9Nv+ssG0uJwwSXHJ2K76wM7mCDZs+x6VgI2KPubJxw45EKHUJsF
 6dOhg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471y6rg4q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:51:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:51:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:51:01 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 77C6A5B6921;
 Tue,  3 Jun 2025 04:50:59 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 14/25] crypto/cnxk: add security datapath
Date: Tue, 3 Jun 2025 17:20:15 +0530
Message-ID: <20250603115026.2664706-15-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Xpf6OUF9 c=1 sm=1 tr=0 ts=683ee1a6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=onbpyaOX_tx6xXp-YHAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: hWDRG_tCuRQE0GwQG3JD7g1DTwrRMSCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX/MhOENduYsvI
 lY29L803cwS65gtTgoxLULGD7vNX7dBb+MDak9Tsukl5Mtb+oXZ9MAwtMZqGRVcQ9Km61rzo3Wv
 lskKU3hGH8fKEfQwfz+8iQrx9E3updeRCO9UBylbMmamu3IeJpQhp+Z9A4QP6eD4KHCcUFY/qe2
 1v06CTG47GxJVZ3GvxH00Gz10nA3foYCeD5ZPSCTP53Lo7/DvX2yZoFUB6wEAFukdj2hZCp/8+J
 KDBuxK6mivnwMKc6Rm1uB0Uu0vM0YoYIKMsEWSf8NC/wc+DOU0yE7tvY29+L7Qw4zq7PJ+Xz+iz
 uwfas4qp1z7gIwx2JgjhflXb8/+3JY3hc9FPsgdJBxsx1KTwnpGcLY9K8koEHOIq9U4o55u1zgX
 nwJcROOuDmRlWkAC4M/zIEpq7Y0uOv5NXsJ5bNPKd1UTddJW0M5VxJVg461WkUrqcixbZy+w
X-Proofpoint-ORIG-GUID: hWDRG_tCuRQE0GwQG3JD7g1DTwrRMSCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

Add support for enqueue and dequeue of rte_security for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 108 +++++++++++-
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h  | 199 ++++++++++++++++++++++
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  |   2 +
 drivers/crypto/cnxk/cnxk_ipsec.h          |   1 +
 4 files changed, 307 insertions(+), 3 deletions(-)
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 2e5c6d2dc5..328679bd07 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -12,6 +12,8 @@
 
 #include "cn20k_cryptodev.h"
 #include "cn20k_cryptodev_ops.h"
+#include "cn20k_cryptodev_sec.h"
+#include "cn20k_ipsec_la_ops.h"
 #include "cnxk_ae.h"
 #include "cnxk_cryptodev.h"
 #include "cnxk_cryptodev_ops.h"
@@ -61,10 +63,43 @@ cn20k_cpt_sym_temp_sess_create(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op)
 	return NULL;
 }
 
+static __rte_always_inline int __rte_hot
+cpt_sec_ipsec_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
+			struct cn20k_sec_session *sess, struct cpt_inst_s *inst,
+			struct cpt_inflight_req *infl_req)
+{
+	struct rte_crypto_sym_op *sym_op = op->sym;
+	int ret;
+
+	if (unlikely(sym_op->m_dst && sym_op->m_dst != sym_op->m_src)) {
+		plt_dp_err("Out of place is not supported");
+		return -ENOTSUP;
+	}
+
+	if (sess->ipsec.is_outbound)
+		ret = process_outb_sa(&qp->lf, op, sess, &qp->meta_info, infl_req, inst);
+	else
+		ret = process_inb_sa(op, sess, inst, &qp->meta_info, infl_req);
+
+	return ret;
+}
+
+static __rte_always_inline int __rte_hot
+cpt_sec_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op, struct cn20k_sec_session *sess,
+		  struct cpt_inst_s *inst, struct cpt_inflight_req *infl_req)
+{
+
+	if (sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
+		return cpt_sec_ipsec_inst_fill(qp, op, sess, &inst[0], infl_req);
+
+	return 0;
+}
+
 static inline int
 cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct cpt_inst_s inst[],
 		    struct cpt_inflight_req *infl_req)
 {
+	struct cn20k_sec_session *sec_sess;
 	struct rte_crypto_asym_op *asym_op;
 	struct rte_crypto_sym_op *sym_op;
 	struct cnxk_ae_sess *ae_sess;
@@ -86,7 +121,13 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 	sym_op = op->sym;
 
 	if (op->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
-		if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+		if (op->sess_type == RTE_CRYPTO_OP_SECURITY_SESSION) {
+			sec_sess = (struct cn20k_sec_session *)sym_op->session;
+			ret = cpt_sec_inst_fill(qp, op, sec_sess, &inst[0], infl_req);
+			if (unlikely(ret))
+				return 0;
+			w7 = sec_sess->inst.w7;
+		} else if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 			sess = (struct cnxk_se_sess *)(sym_op->session);
 			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], true);
 			if (unlikely(ret))
@@ -226,6 +267,52 @@ cn20k_cpt_enqueue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	return count + i;
 }
 
+static inline void
+cn20k_cpt_ipsec_post_process(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res)
+{
+	struct rte_mbuf *mbuf = cop->sym->m_src;
+	const uint16_t m_len = res->rlen;
+
+	switch (res->uc_compcode) {
+	case ROC_IE_OW_UCC_SUCCESS_PKT_IP_BADCSUM:
+		mbuf->ol_flags &= ~RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
+		break;
+	case ROC_IE_OW_UCC_SUCCESS_PKT_L4_GOODCSUM:
+		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+		break;
+	case ROC_IE_OW_UCC_SUCCESS_PKT_L4_BADCSUM:
+		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+		break;
+	case ROC_IE_OW_UCC_SUCCESS_PKT_IP_GOODCSUM:
+		break;
+	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_FIRST:
+	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_AGAIN:
+		cop->aux_flags = RTE_CRYPTO_OP_AUX_FLAGS_IPSEC_SOFT_EXPIRY;
+		break;
+	default:
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		cop->aux_flags = res->uc_compcode;
+		return;
+	}
+
+	if (mbuf->next == NULL)
+		mbuf->data_len = m_len;
+
+	mbuf->pkt_len = m_len;
+}
+
+static inline void
+cn20k_cpt_sec_post_process(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res)
+{
+	struct rte_crypto_sym_op *sym_op = cop->sym;
+	struct cn20k_sec_session *sess;
+
+	sess = sym_op->session;
+	if (sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
+		cn20k_cpt_ipsec_post_process(cop, res);
+}
+
 static inline void
 cn20k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop,
 			       struct cpt_inflight_req *infl_req, struct cpt_cn20k_res_s *res)
@@ -235,8 +322,23 @@ cn20k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 
 	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
 
-	if (cop->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC &&
-	    cop->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
+	if (cop->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC &&
+	    cop->sess_type == RTE_CRYPTO_OP_SECURITY_SESSION) {
+		if (likely(compcode == CPT_COMP_GOOD || compcode == CPT_COMP_WARN)) {
+			/* Success with additional info */
+			cn20k_cpt_sec_post_process(cop, res);
+		} else {
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			plt_dp_info("HW completion code 0x%x", res->compcode);
+			if (compcode == CPT_COMP_GOOD) {
+				plt_dp_info("Request failed with microcode error");
+				plt_dp_info("MC completion code 0x%x", uc_compcode);
+			}
+		}
+
+		return;
+	} else if (cop->type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC &&
+		   cop->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 		struct cnxk_ae_sess *sess;
 
 		sess = (struct cnxk_ae_sess *)cop->asym->session;
diff --git a/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
new file mode 100644
index 0000000000..eff51bd794
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef __CN20K_IPSEC_LA_OPS_H__
+#define __CN20K_IPSEC_LA_OPS_H__
+
+#include <rte_crypto_sym.h>
+#include <rte_security.h>
+
+#include "roc_ie.h"
+
+#include "cn20k_cryptodev.h"
+#include "cn20k_ipsec.h"
+#include "cnxk_cryptodev.h"
+#include "cnxk_cryptodev_ops.h"
+#include "cnxk_sg.h"
+
+static inline void
+ipsec_po_sa_iv_set(struct cn20k_sec_session *sess, struct rte_crypto_op *cop)
+{
+	uint64_t *iv = &sess->sa.out_sa.iv.u64[0];
+	uint64_t *tmp_iv;
+
+	memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset), 16);
+	tmp_iv = (uint64_t *)iv;
+	*tmp_iv = rte_be_to_cpu_64(*tmp_iv);
+
+	tmp_iv = (uint64_t *)(iv + 1);
+	*tmp_iv = rte_be_to_cpu_64(*tmp_iv);
+}
+
+static inline void
+ipsec_po_sa_aes_gcm_iv_set(struct cn20k_sec_session *sess, struct rte_crypto_op *cop)
+{
+	uint8_t *iv = &sess->sa.out_sa.iv.s.iv_dbg1[0];
+	uint32_t *tmp_iv;
+
+	memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset), 4);
+	tmp_iv = (uint32_t *)iv;
+	*tmp_iv = rte_be_to_cpu_32(*tmp_iv);
+
+	iv = &sess->sa.out_sa.iv.s.iv_dbg2[0];
+	memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset + 4), 4);
+	tmp_iv = (uint32_t *)iv;
+	*tmp_iv = rte_be_to_cpu_32(*tmp_iv);
+}
+
+static __rte_always_inline int
+process_outb_sa(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn20k_sec_session *sess,
+		struct cpt_qp_meta_info *m_info, struct cpt_inflight_req *infl_req,
+		struct cpt_inst_s *inst)
+{
+	struct rte_crypto_sym_op *sym_op = cop->sym;
+	struct rte_mbuf *m_src = sym_op->m_src;
+	uint64_t inst_w4_u64 = sess->inst.w4;
+	uint64_t dptr;
+
+	RTE_SET_USED(lf);
+
+#ifdef LA_IPSEC_DEBUG
+	if (sess->sa.out_sa.w2.s.iv_src == ROC_IE_OW_SA_IV_SRC_FROM_SA) {
+		if (sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
+		    sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
+		    sess->sa.out_sa.w2.s.auth_type == ROC_IE_SA_AUTH_AES_GMAC)
+			ipsec_po_sa_aes_gcm_iv_set(sess, cop);
+		else
+			ipsec_po_sa_iv_set(sess, cop);
+	}
+
+	/* Trigger CTX reload to fetch new data from DRAM */
+	roc_cpt_lf_ctx_reload(lf, &sess->sa.out_sa);
+	rte_delay_ms(1);
+#endif
+	const uint64_t ol_flags = m_src->ol_flags;
+
+	inst_w4_u64 &= ~(((uint64_t)(!!(ol_flags & RTE_MBUF_F_TX_IP_CKSUM)) << 33) |
+			 ((uint64_t)(!!(ol_flags & RTE_MBUF_F_TX_L4_MASK)) << 32));
+
+	if (likely(m_src->next == NULL)) {
+		if (unlikely(rte_pktmbuf_tailroom(m_src) < sess->max_extended_len)) {
+			plt_dp_err("Not enough tail room");
+			return -ENOMEM;
+		}
+
+		/* Prepare CPT instruction */
+		inst->w4.u64 = inst_w4_u64 | rte_pktmbuf_pkt_len(m_src);
+		dptr = rte_pktmbuf_mtod(m_src, uint64_t);
+		inst->dptr = dptr;
+	} else {
+		struct roc_sg2list_comp *scatter_comp, *gather_comp;
+		union cpt_inst_w5 cpt_inst_w5;
+		union cpt_inst_w6 cpt_inst_w6;
+		struct rte_mbuf *last_seg;
+		uint32_t g_size_bytes;
+		void *m_data;
+		int i;
+
+		last_seg = rte_pktmbuf_lastseg(m_src);
+
+		if (unlikely(rte_pktmbuf_tailroom(last_seg) < sess->max_extended_len)) {
+			plt_dp_err("Not enough tail room (required: %d, available: %d)",
+				   sess->max_extended_len, rte_pktmbuf_tailroom(last_seg));
+			return -ENOMEM;
+		}
+
+		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
+		if (unlikely(m_data == NULL)) {
+			plt_dp_err("Error allocating meta buffer for request");
+			return -ENOMEM;
+		}
+
+		/* Input Gather List */
+		i = 0;
+		gather_comp = (struct roc_sg2list_comp *)((uint8_t *)m_data);
+
+		i = fill_sg2_comp_from_pkt(gather_comp, i, m_src);
+
+		cpt_inst_w5.s.gather_sz = ((i + 2) / 3);
+		g_size_bytes = ((i + 2) / 3) * sizeof(struct roc_sg2list_comp);
+
+		/* Output Scatter List */
+		last_seg->data_len += sess->max_extended_len;
+
+		i = 0;
+		scatter_comp = (struct roc_sg2list_comp *)((uint8_t *)gather_comp + g_size_bytes);
+
+		i = fill_sg2_comp_from_pkt(scatter_comp, i, m_src);
+
+		cpt_inst_w6.s.scatter_sz = ((i + 2) / 3);
+
+		cpt_inst_w5.s.dptr = (uint64_t)gather_comp;
+		cpt_inst_w6.s.rptr = (uint64_t)scatter_comp;
+
+		inst->w5.u64 = cpt_inst_w5.u64;
+		inst->w6.u64 = cpt_inst_w6.u64;
+		inst->w4.u64 = sess->inst.w4 | rte_pktmbuf_pkt_len(m_src);
+		inst->w4.s.opcode_major &= (~(ROC_IE_OW_INPLACE_BIT));
+	}
+
+	return 0;
+}
+
+static __rte_always_inline int
+process_inb_sa(struct rte_crypto_op *cop, struct cn20k_sec_session *sess, struct cpt_inst_s *inst,
+	       struct cpt_qp_meta_info *m_info, struct cpt_inflight_req *infl_req)
+{
+	struct rte_crypto_sym_op *sym_op = cop->sym;
+	struct rte_mbuf *m_src = sym_op->m_src;
+	uint64_t dptr;
+
+	if (likely(m_src->next == NULL)) {
+		/* Prepare CPT instruction */
+		inst->w4.u64 = sess->inst.w4 | rte_pktmbuf_pkt_len(m_src);
+		dptr = rte_pktmbuf_mtod(m_src, uint64_t);
+		inst->dptr = dptr;
+		m_src->ol_flags |= (uint64_t)sess->ipsec.ip_csum;
+	} else {
+		struct roc_sg2list_comp *scatter_comp, *gather_comp;
+		union cpt_inst_w5 cpt_inst_w5;
+		union cpt_inst_w6 cpt_inst_w6;
+		uint32_t g_size_bytes;
+		void *m_data;
+		int i;
+
+		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
+		if (unlikely(m_data == NULL)) {
+			plt_dp_err("Error allocating meta buffer for request");
+			return -ENOMEM;
+		}
+
+		/* Input Gather List */
+		i = 0;
+		gather_comp = (struct roc_sg2list_comp *)((uint8_t *)m_data);
+
+		i = fill_sg2_comp_from_pkt(gather_comp, i, m_src);
+
+		cpt_inst_w5.s.gather_sz = ((i + 2) / 3);
+		g_size_bytes = ((i + 2) / 3) * sizeof(struct roc_sg2list_comp);
+
+		/* Output Scatter List */
+		i = 0;
+		scatter_comp = (struct roc_sg2list_comp *)((uint8_t *)gather_comp + g_size_bytes);
+		i = fill_sg2_comp_from_pkt(scatter_comp, i, m_src);
+
+		cpt_inst_w6.s.scatter_sz = ((i + 2) / 3);
+
+		cpt_inst_w5.s.dptr = (uint64_t)gather_comp;
+		cpt_inst_w6.s.rptr = (uint64_t)scatter_comp;
+
+		inst->w5.u64 = cpt_inst_w5.u64;
+		inst->w6.u64 = cpt_inst_w6.u64;
+		inst->w4.u64 = sess->inst.w4 | rte_pktmbuf_pkt_len(m_src);
+		inst->w4.s.opcode_major &= (~(ROC_IE_OW_INPLACE_BIT));
+	}
+	return 0;
+}
+
+#endif /* __CN20K_IPSEC_LA_OPS_H__ */
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index b4020f96c1..982fbe991f 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -31,6 +31,8 @@
 
 #include "cn10k_cryptodev_ops.h"
 #include "cn10k_cryptodev_sec.h"
+#include "cn20k_cryptodev_ops.h"
+#include "cn20k_cryptodev_sec.h"
 #include "cn9k_cryptodev_ops.h"
 #include "cn9k_ipsec.h"
 
diff --git a/drivers/crypto/cnxk/cnxk_ipsec.h b/drivers/crypto/cnxk/cnxk_ipsec.h
index 42f8e64009..5f65c34380 100644
--- a/drivers/crypto/cnxk/cnxk_ipsec.h
+++ b/drivers/crypto/cnxk/cnxk_ipsec.h
@@ -10,6 +10,7 @@
 #include "roc_cpt.h"
 #include "roc_ie_on.h"
 #include "roc_ie_ot.h"
+#include "roc_ie_ow.h"
 #include "roc_model.h"
 
 extern struct rte_security_ops cnxk_sec_ops;
-- 
2.25.1

