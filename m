Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41FBCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:53:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA1564066C;
	Thu, 21 Aug 2025 06:53:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 00D7E40687
 for <dev@dpdk.org>; Thu, 21 Aug 2025 06:53:38 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0oOQX016741
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 1aYPoUUtSNN1nphmREXW6fpkpNoitoX7eiFq2nS0gQ=; b=PvJdGiAKrYt4T7EAl
 1V95EeP4N3TyBneShQMVAYTpW7SaQDG56dawE9Gxw7xkHZbjMRlAhiaAMtktPozu
 AmCIrcQH9BVKmG9W4Z8pUsMqNeLDPiuiLjDcoMixWTlDRb6dUytxUTkXwlgpXLdn
 m+RtjbVV0gDt/jVv5yJf/dJTe9jGiUux5BJuNpUxUuIoaQMO1HeSMAOCdZnNAcRD
 CxUfArtVtR1xHnEp//0OPzkrKOKuEj8xlW8HI0dyvhqVDJr5sWtZ2pxZ2WMy5Aof
 IW6bdCzP/WASmWXkwgxE9aP7Kyzu+yurX/ZlFJss8Gpkvi0skg1REDAUQQRBlBgR
 s/CkA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nr3g0j18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 21:53:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 21:53:41 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 1FE443F708F;
 Wed, 20 Aug 2025 21:53:32 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 7/8] crypto/cnxk: align PDCP API with latest firmware
Date: Thu, 21 Aug 2025 10:22:59 +0530
Message-ID: <20250821045300.3787899-8-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821045300.3787899-1-ktejasree@marvell.com>
References: <20250821045300.3787899-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=St/JKPO0 c=1 sm=1 tr=0 ts=68a6a652 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=tqdUxWZY34tbixR_JWEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 2SZXgfznN80-ahYxjy1BQpJc_pbGjgSP
X-Proofpoint-ORIG-GUID: 2SZXgfznN80-ahYxjy1BQpJc_pbGjgSP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfXyTDun/oPJqUA
 XPDgk9l8w3yu7bddr579YQ2r3zG7kAeQA2DnskN0JtU8akK4xqA3CWX22W1P2O7QKjkjL4ktB2Z
 /0f3nsPYoF1PDktsJy2MnIB8PX2dGlDl05S8hiuLoBkmbXVummRu59fumPvGQ2PIyiP9qmrt9pB
 3/ApL1r5Q/6a3nqp1M1fmukTgJKMWVkCb4J3btN6VQMfRqDfJQAnKiL0an7qE9qX/GgcWT3uTXb
 ejA0+LdtRgkDya1hpXDDcuJPPlzxuuO8hP60Orxrp7im5vBrxL5pEh8Iq947B58hPaOOlh37hBZ
 seA+/wyIZUv1RKUnomAfpN9vWSVh+gYg4Rg6hJ+2aF4sgaCOpKwwsHyiHO6mNfBjVIpytXqVZ3V
 1YpC2kPqLgT9rfQkzn6ISxsELmKUXxzRfeYXshHcSi0kRuw9FJpFSmum6J8xks4p3+uQLZcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
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

Aligning PDCP API with latest firmware.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c |   8 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c |   8 +-
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c  |   4 +-
 drivers/crypto/cnxk/cnxk_se.h             | 171 ++++++++++++++--------
 4 files changed, 121 insertions(+), 70 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 17edf636da..d6b95a14aa 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -206,7 +206,8 @@ cn10k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 			w7 = sec_sess->inst.w7;
 		} else if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 			sess = (struct cnxk_se_sess *)(sym_op->session);
-			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], is_sg_ver2);
+			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], is_sg_ver2,
+						false);
 			if (unlikely(ret))
 				return 0;
 			w7 = sess->cpt_inst_w7;
@@ -217,7 +218,8 @@ cn10k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 				return 0;
 			}
 
-			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], is_sg_ver2);
+			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], is_sg_ver2,
+						false);
 			if (unlikely(ret)) {
 				sym_session_clear(op->sym->session, true);
 				rte_mempool_put(qp->sess_mp, op->sym->session);
@@ -1557,7 +1559,7 @@ cn10k_cpt_raw_fill_inst(struct cnxk_iov *iov, struct cnxk_cpt_qp *qp,
 		break;
 	case CPT_DP_THREAD_AUTH_ONLY:
 		ret = fill_raw_digest_params(iov, sess, &qp->meta_info, infl_req, &inst[0],
-					     is_sg_ver2);
+					     is_sg_ver2, false);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 86d02ba5ca..30194db4ad 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -207,7 +207,7 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 			w7 = sec_sess->inst.w7;
 		} else if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 			sess = (struct cnxk_se_sess *)(sym_op->session);
-			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], true);
+			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], true, true);
 			if (unlikely(ret))
 				return 0;
 			w7 = sess->cpt_inst_w7;
@@ -218,7 +218,7 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 				return 0;
 			}
 
-			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], true);
+			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, &inst[0], true, true);
 			if (unlikely(ret)) {
 				sym_session_clear(op->sym->session, true);
 				rte_mempool_put(qp->sess_mp, op->sym->session);
@@ -278,6 +278,7 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 
 	cnxk_cpt_request_data_sgv2_mode_dump((void *)inst[0].dptr, 1, inst[0].w5.s.gather_sz);
 	cnxk_cpt_request_data_sgv2_mode_dump((void *)inst[0].rptr, 0, inst[0].w6.s.scatter_sz);
+
 #endif
 
 	return 1;
@@ -1342,7 +1343,8 @@ cn20k_cpt_raw_fill_inst(struct cnxk_iov *iov, struct cnxk_cpt_qp *qp,
 					 true);
 		break;
 	case CPT_DP_THREAD_AUTH_ONLY:
-		ret = fill_raw_digest_params(iov, sess, &qp->meta_info, infl_req, &inst[0], true);
+		ret = fill_raw_digest_params(iov, sess, &qp->meta_info, infl_req, &inst[0], true,
+					     true);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index c94e9e0f92..5551e40cb0 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -117,7 +117,7 @@ cn9k_cpt_inst_prep(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 		if (op->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 			sym_op = op->sym;
 			sess = (struct cnxk_se_sess *)sym_op->session;
-			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, inst, false);
+			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, inst, false, false);
 			inst->w7.u64 = sess->cpt_inst_w7;
 		} else if (op->sess_type == RTE_CRYPTO_OP_SECURITY_SESSION)
 			ret = cn9k_cpt_sec_inst_fill(qp, op, infl_req, inst);
@@ -128,7 +128,7 @@ cn9k_cpt_inst_prep(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op,
 				return -1;
 			}
 
-			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, inst, false);
+			ret = cpt_sym_inst_fill(qp, op, sess, infl_req, inst, false, false);
 			if (unlikely(ret)) {
 				sym_session_clear(op->sym->session, true);
 				rte_mempool_put(qp->sess_mp, op->sym->session);
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 1838140727..3631b95e8c 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -459,7 +459,7 @@ static __rte_always_inline int
 sg2_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t offset_ctrl,
 	      const uint8_t *iv_s, int iv_len, const bool pack_iv, uint8_t pdcp_alg_type,
 	      int32_t inputlen, int32_t outputlen, uint32_t passthrough_len, uint32_t req_flags,
-	      int pdcp_flag, int decrypt)
+	      int pdcp_flag, int decrypt, uint32_t off_ctrl_len, const bool use_metadata)
 {
 	struct roc_sg2list_comp *gather_comp, *scatter_comp;
 	void *m_vaddr = params->meta_buf.vaddr;
@@ -488,17 +488,17 @@ sg2_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t
 	/* save space for iv */
 	offset_vaddr = m_vaddr;
 
-	m_vaddr = (uint8_t *)m_vaddr + ROC_SE_OFF_CTRL_LEN + RTE_ALIGN_CEIL(iv_len, 8);
+	m_vaddr = (uint8_t *)m_vaddr + off_ctrl_len + RTE_ALIGN_CEIL(iv_len, 8);
 
 	inst->w4.s.opcode_major |= (uint64_t)ROC_DMA_MODE_SG;
 
 	/* This is DPTR len in case of SG mode */
-	inst->w4.s.dlen = inputlen + ROC_SE_OFF_CTRL_LEN;
+	inst->w4.s.dlen = inputlen + off_ctrl_len;
 
 	/* iv offset is 0 */
 	*offset_vaddr = offset_ctrl;
 
-	iv_d = ((uint8_t *)offset_vaddr + ROC_SE_OFF_CTRL_LEN);
+	iv_d = ((uint8_t *)offset_vaddr + off_ctrl_len);
 	if (pdcp_flag) {
 		if (likely(iv_len)) {
 			if (zsk_flags == 0x1)
@@ -524,7 +524,7 @@ sg2_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t
 
 	/* Offset control word followed by iv */
 
-	i = fill_sg2_comp(gather_comp, i, (uint64_t)offset_vaddr, ROC_SE_OFF_CTRL_LEN + iv_len);
+	i = fill_sg2_comp(gather_comp, i, (uint64_t)offset_vaddr, off_ctrl_len + iv_len);
 
 	/* Add input data */
 	if (decrypt && (req_flags & ROC_SE_VALID_MAC_BUF)) {
@@ -585,14 +585,15 @@ sg2_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t
 		iv_len = 0;
 	}
 
-	if (iv_len) {
-		i = fill_sg2_comp(scatter_comp, i, (uint64_t)offset_vaddr + ROC_SE_OFF_CTRL_LEN,
-				  iv_len);
+	if ((!use_metadata) && iv_len) {
+		i = fill_sg2_comp(scatter_comp, i, (uint64_t)offset_vaddr + off_ctrl_len, iv_len);
 	}
 
 	/* Add output data */
 	if ((!decrypt) && (req_flags & ROC_SE_VALID_MAC_BUF)) {
-		size = outputlen - iv_len - mac_len;
+		size = outputlen - mac_len;
+		if (!use_metadata)
+			size -= iv_len;
 		if (size) {
 
 			uint32_t aad_offset = aad_len ? passthrough_len : 0;
@@ -617,7 +618,9 @@ sg2_inst_prep(struct roc_se_fc_params *params, struct cpt_inst_s *inst, uint64_t
 			i = fill_sg2_comp_from_buf(scatter_comp, i, &params->mac_buf);
 	} else {
 		/* Output including mac */
-		size = outputlen - iv_len;
+		size = outputlen;
+		if (!use_metadata)
+			size -= iv_len;
 		if (size) {
 			uint32_t aad_offset = aad_len ? passthrough_len : 0;
 
@@ -992,7 +995,8 @@ pdcp_chain_sg2_prep(struct roc_se_fc_params *params, struct roc_se_ctx *cpt_ctx,
 		    struct cpt_inst_s *inst, union cpt_inst_w4 w4, int32_t inputlen,
 		    uint8_t hdr_len, uint64_t offset_ctrl, uint32_t req_flags,
 		    const uint8_t *cipher_iv, const uint8_t *auth_iv, const bool pack_iv,
-		    const uint8_t pdcp_ci_alg, const uint8_t pdcp_auth_alg)
+		    const uint8_t pdcp_ci_alg, const uint8_t pdcp_auth_alg, uint32_t pad_len,
+		    uint32_t off_ctrl_len, const bool use_metadata)
 {
 	struct roc_sg2list_comp *gather_comp, *scatter_comp;
 	void *m_vaddr = params->meta_buf.vaddr;
@@ -1009,10 +1013,10 @@ pdcp_chain_sg2_prep(struct roc_se_fc_params *params, struct roc_se_ctx *cpt_ctx,
 	/* save space for IV */
 	offset_vaddr = m_vaddr;
 
-	m_vaddr = PLT_PTR_ADD(m_vaddr, ROC_SE_OFF_CTRL_LEN + RTE_ALIGN_CEIL(hdr_len, 8));
+	m_vaddr = PLT_PTR_ADD(m_vaddr, off_ctrl_len + RTE_ALIGN_CEIL(hdr_len, 8));
 
 	w4.s.opcode_major |= (uint64_t)ROC_DMA_MODE_SG;
-	w4.s.dlen = inputlen + ROC_SE_OFF_CTRL_LEN;
+	w4.s.dlen = inputlen + off_ctrl_len;
 
 	gather_comp = m_vaddr;
 
@@ -1022,14 +1026,14 @@ pdcp_chain_sg2_prep(struct roc_se_fc_params *params, struct roc_se_ctx *cpt_ctx,
 	/* Offset control word followed by IV */
 	*(uint64_t *)offset_vaddr = offset_ctrl;
 
-	i = fill_sg2_comp(gather_comp, i, (uint64_t)offset_vaddr, ROC_SE_OFF_CTRL_LEN + hdr_len);
+	i = fill_sg2_comp(gather_comp, i, (uint64_t)offset_vaddr, off_ctrl_len + hdr_len);
 
 	/* Cipher IV */
-	iv_d = ((uint8_t *)offset_vaddr + ROC_SE_OFF_CTRL_LEN);
+	iv_d = ((uint8_t *)offset_vaddr + off_ctrl_len);
 	pdcp_iv_copy(iv_d, cipher_iv, pdcp_ci_alg, pack_iv);
 
 	/* Auth IV */
-	iv_d = ((uint8_t *)offset_vaddr + ROC_SE_OFF_CTRL_LEN + params->pdcp_iv_offset);
+	iv_d = ((uint8_t *)offset_vaddr + off_ctrl_len + params->pdcp_iv_offset);
 	pdcp_iv_copy(iv_d, auth_iv, pdcp_auth_alg, pack_iv);
 
 	/* input data */
@@ -1052,8 +1056,13 @@ pdcp_chain_sg2_prep(struct roc_se_fc_params *params, struct roc_se_ctx *cpt_ctx,
 	i = 0;
 	scatter_comp = PLT_PTR_ADD(gather_comp, g_size_bytes);
 
-	if ((hdr_len))
-		i = fill_sg2_comp(scatter_comp, i, (uint64_t)(offset_vaddr) + ROC_SE_OFF_CTRL_LEN,
+	if (use_metadata && pad_len)
+		/* Add padding */
+		i = fill_sg2_comp(scatter_comp, i, (uint64_t)(offset_vaddr) + off_ctrl_len,
+				  pad_len);
+
+	if ((!use_metadata) && hdr_len)
+		i = fill_sg2_comp(scatter_comp, i, (uint64_t)(offset_vaddr) + off_ctrl_len,
 				  hdr_len);
 
 	/* Add output data */
@@ -1171,7 +1180,7 @@ cpt_sm_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens, struct roc_se_fc_p
 		if (is_sg_ver2)
 			ret = sg2_inst_prep(fc_params, inst, offset_ctrl, src, iv_len + pad_len, 0,
 					    0, inputlen, outputlen, passthrough_len, flags, 0,
-					    decrypt);
+					    decrypt, ROC_SE_OFF_CTRL_LEN, false);
 		else
 			ret = sg_inst_prep(fc_params, inst, offset_ctrl, src, iv_len + pad_len, 0,
 					   0, inputlen, outputlen, passthrough_len, flags, 0,
@@ -1341,7 +1350,8 @@ cpt_enc_hmac_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens,
 
 		if (is_sg_ver2)
 			ret = sg2_inst_prep(fc_params, inst, offset_ctrl, src, iv_len, 0, 0,
-					    inputlen, outputlen, passthrough_len, flags, 0, 0);
+					    inputlen, outputlen, passthrough_len, flags, 0, 0,
+					    ROC_SE_OFF_CTRL_LEN, false);
 		else
 			ret = sg_inst_prep(fc_params, inst, offset_ctrl, src, iv_len, 0, 0,
 					   inputlen, outputlen, passthrough_len, flags, 0, 0);
@@ -1499,7 +1509,8 @@ cpt_dec_hmac_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens,
 
 		if (is_sg_ver2)
 			ret = sg2_inst_prep(fc_params, inst, offset_ctrl, src, iv_len, 0, 0,
-					    inputlen, outputlen, passthrough_len, flags, 0, 1);
+					    inputlen, outputlen, passthrough_len, flags, 0, 1,
+					    ROC_SE_OFF_CTRL_LEN, false);
 		else
 			ret = sg_inst_prep(fc_params, inst, offset_ctrl, src, iv_len, 0, 0,
 					   inputlen, outputlen, passthrough_len, flags, 0, 1);
@@ -1515,12 +1526,13 @@ cpt_dec_hmac_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens,
 static __rte_always_inline int
 cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 			struct roc_se_fc_params *params, struct cpt_inst_s *inst,
-			const bool is_sg_ver2)
+			const bool is_sg_ver2, const bool use_metadata)
 {
 	uint32_t encr_data_len, auth_data_len, aad_len, passthr_len, pad_len, hdr_len;
 	uint32_t encr_offset, auth_offset, iv_offset = 0;
 	const uint8_t *auth_iv = NULL, *cipher_iv = NULL;
 	uint8_t pdcp_iv_off = params->pdcp_iv_offset;
+	uint32_t off_ctrl_len = ROC_SE_OFF_CTRL_LEN;
 	const int iv_len = pdcp_iv_off * 2;
 	uint8_t pdcp_ci_alg, pdcp_auth_alg;
 	union cpt_inst_w4 cpt_inst_w4;
@@ -1550,8 +1562,10 @@ cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 	auth_data_len = ROC_SE_AUTH_DLEN(d_lens);
 	auth_data_len -= aad_len;
 
-	encr_offset += iv_len;
-	auth_offset = encr_offset - aad_len;
+	if (!use_metadata) {
+		encr_offset += iv_len;
+		auth_offset = encr_offset - aad_len;
+	}
 	passthr_len = RTE_ALIGN_CEIL(auth_offset, 8);
 
 	if (unlikely((aad_len >> 16) || (passthr_len >> 8))) {
@@ -1582,10 +1596,15 @@ cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 		inputlen = encr_data_len;
 
 	inputlen += (encr_offset + pad_len);
+	if (use_metadata)
+		inputlen += iv_len;
 
 	offset_ctrl = rte_cpu_to_be_64(((uint64_t)(aad_len) << 16) | ((uint64_t)(iv_offset) << 8) |
 				       ((uint64_t)(passthr_len)));
 
+	if (use_metadata)
+		off_ctrl_len *= 2;
+
 	if (likely(((req_flags & ROC_SE_SINGLE_BUF_INPLACE)) &&
 		   ((req_flags & ROC_SE_SINGLE_BUF_HEADROOM)))) {
 
@@ -1593,20 +1612,23 @@ cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 
 		/* Use Direct mode */
 
-		offset_vaddr = PLT_PTR_SUB(dm_vaddr, ROC_SE_OFF_CTRL_LEN + hdr_len);
+		offset_vaddr = PLT_PTR_SUB(dm_vaddr, off_ctrl_len + hdr_len);
 		*offset_vaddr = offset_ctrl;
 
 		/* DPTR */
 		inst->dptr = (uint64_t)offset_vaddr;
 		/* RPTR should just exclude offset control word */
-		inst->rptr = (uint64_t)PLT_PTR_SUB(dm_vaddr, hdr_len);
+		if (use_metadata)
+			inst->rptr = (uint64_t)dm_vaddr - pad_len;
+		else
+			inst->rptr = (uint64_t)PLT_PTR_SUB(dm_vaddr, hdr_len);
 
-		cpt_inst_w4.s.dlen = inputlen + ROC_SE_OFF_CTRL_LEN;
+		cpt_inst_w4.s.dlen = inputlen + off_ctrl_len;
 
-		iv_d = ((uint8_t *)offset_vaddr + ROC_SE_OFF_CTRL_LEN);
+		iv_d = ((uint8_t *)offset_vaddr + off_ctrl_len);
 		pdcp_iv_copy(iv_d, cipher_iv, pdcp_ci_alg, false);
 
-		iv_d = ((uint8_t *)offset_vaddr + ROC_SE_OFF_CTRL_LEN + pdcp_iv_off);
+		iv_d = ((uint8_t *)offset_vaddr + off_ctrl_len + pdcp_iv_off);
 		pdcp_iv_copy(iv_d, auth_iv, pdcp_auth_alg, false);
 
 		inst->w4.u64 = cpt_inst_w4.u64;
@@ -1616,7 +1638,8 @@ cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 		if (is_sg_ver2)
 			return pdcp_chain_sg2_prep(params, se_ctx, inst, cpt_inst_w4, inputlen,
 						   hdr_len, offset_ctrl, req_flags, cipher_iv,
-						   auth_iv, false, pdcp_ci_alg, pdcp_auth_alg);
+						   auth_iv, false, pdcp_ci_alg, pdcp_auth_alg,
+						   pad_len, off_ctrl_len, use_metadata);
 		else
 			return pdcp_chain_sg1_prep(params, se_ctx, inst, cpt_inst_w4, inputlen,
 						   hdr_len, offset_ctrl, req_flags, cipher_iv,
@@ -1626,7 +1649,8 @@ cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 
 static __rte_always_inline int
 cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
-		  struct roc_se_fc_params *params, struct cpt_inst_s *inst, const bool is_sg_ver2)
+		  struct roc_se_fc_params *params, struct cpt_inst_s *inst, const bool is_sg_ver2,
+		  const bool use_metadata)
 {
 	/*
 	 * pdcp_iv_offset is auth_iv_offset wrt cipher_iv_offset which is
@@ -1636,6 +1660,7 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 	 * and 48B with new microcode.
 	 */
 	const int iv_len = params->pdcp_iv_offset * 2;
+	uint32_t off_ctrl_len = ROC_SE_OFF_CTRL_LEN;
 	struct roc_se_ctx *se_ctx = params->ctx;
 	uint32_t encr_data_len, auth_data_len;
 	const int flags = se_ctx->zsk_flags;
@@ -1653,6 +1678,8 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 	mac_len = se_ctx->mac_len;
 
 	cpt_inst_w4.u64 = se_ctx->template_w4.u64;
+	if (use_metadata)
+		off_ctrl_len *= 2;
 
 	if (flags == 0x1) {
 		cpt_inst_w4.s.opcode_minor = 1;
@@ -1675,11 +1702,15 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 			auth_data_len = RTE_ALIGN(auth_data_len, 8) / 8;
 		}
 
-		/* consider iv len */
-		auth_offset += iv_len;
-
-		inputlen = auth_offset + auth_data_len;
-		outputlen = iv_len + mac_len;
+		if (use_metadata) {
+			inputlen = iv_len + auth_offset + auth_data_len;
+			outputlen = mac_len;
+		} else {
+			/* consider iv len */
+			auth_offset += iv_len;
+			inputlen = auth_offset + auth_data_len;
+			outputlen = iv_len + mac_len;
+		}
 
 		offset_ctrl = rte_cpu_to_be_64((uint64_t)auth_offset);
 		cpt_inst_w4.s.param1 = auth_data_len;
@@ -1703,11 +1734,15 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 		encr_offset = ROC_SE_ENCR_OFFSET(d_offs);
 		encr_offset = encr_offset / 8;
 
-		/* consider iv len */
-		encr_offset += iv_len;
-
-		inputlen = encr_offset + (RTE_ALIGN(encr_data_len, 8) / 8);
-		outputlen = inputlen;
+		if (use_metadata) {
+			outputlen = encr_offset + (RTE_ALIGN(encr_data_len, 8) / 8);
+			inputlen = iv_len + outputlen;
+		} else {
+			/* consider iv len */
+			encr_offset += iv_len;
+			inputlen = encr_offset + (RTE_ALIGN(encr_data_len, 8) / 8);
+			outputlen = inputlen;
+		}
 
 		/* iv offset is 0 */
 		offset_ctrl = rte_cpu_to_be_64((uint64_t)encr_offset);
@@ -1737,16 +1772,19 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 		/* Use Direct mode */
 
 		cpt_inst_w4.s.opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
-		offset_vaddr = (uint64_t *)((uint8_t *)dm_vaddr - ROC_SE_OFF_CTRL_LEN - iv_len);
+		offset_vaddr = (uint64_t *)((uint8_t *)dm_vaddr - off_ctrl_len - iv_len);
 
 		/* DPTR */
 		inst->dptr = (uint64_t)offset_vaddr;
 		/* RPTR should just exclude offset control word */
-		inst->rptr = (uint64_t)dm_vaddr - iv_len;
+		if (use_metadata)
+			inst->rptr = (uint64_t)dm_vaddr;
+		else
+			inst->rptr = (uint64_t)dm_vaddr - iv_len;
 
-		cpt_inst_w4.s.dlen = inputlen + ROC_SE_OFF_CTRL_LEN;
+		cpt_inst_w4.s.dlen = inputlen + off_ctrl_len;
 
-		uint8_t *iv_d = ((uint8_t *)offset_vaddr + ROC_SE_OFF_CTRL_LEN);
+		uint8_t *iv_d = ((uint8_t *)offset_vaddr + off_ctrl_len);
 		pdcp_iv_copy(iv_d, iv_s, pdcp_alg_type, pack_iv);
 
 		*offset_vaddr = offset_ctrl;
@@ -1756,7 +1794,8 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 		inst->w4.u64 = cpt_inst_w4.u64;
 		if (is_sg_ver2)
 			ret = sg2_inst_prep(params, inst, offset_ctrl, iv_s, iv_len, pack_iv,
-					    pdcp_alg_type, inputlen, outputlen, 0, req_flags, 1, 0);
+					    pdcp_alg_type, inputlen, outputlen, 0, req_flags, 1, 0,
+					    off_ctrl_len, use_metadata);
 		else
 			ret = sg_inst_prep(params, inst, offset_ctrl, iv_s, iv_len, pack_iv,
 					   pdcp_alg_type, inputlen, outputlen, 0, req_flags, 1, 0);
@@ -1840,7 +1879,7 @@ cpt_kasumi_enc_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 
 	if (is_sg_ver2)
 		sg2_inst_prep(params, inst, offset_ctrl, iv_s, iv_len, 0, 0, inputlen, outputlen, 0,
-			      req_flags, 0, 0);
+			      req_flags, 0, 0, ROC_SE_OFF_CTRL_LEN, false);
 	else
 		sg_inst_prep(params, inst, offset_ctrl, iv_s, iv_len, 0, 0, inputlen, outputlen, 0,
 			     req_flags, 0, 0);
@@ -1900,7 +1939,7 @@ cpt_kasumi_dec_prep(uint64_t d_offs, uint64_t d_lens, struct roc_se_fc_params *p
 
 	if (is_sg_ver2)
 		sg2_inst_prep(params, inst, offset_ctrl, params->iv_buf, iv_len, 0, 0, inputlen,
-			      outputlen, 0, 0, 0, 1);
+			      outputlen, 0, 0, 0, 1, ROC_SE_OFF_CTRL_LEN, false);
 	else
 		sg_inst_prep(params, inst, offset_ctrl, params->iv_buf, iv_len, 0, 0, inputlen,
 			     outputlen, 0, 0, 0, 1);
@@ -1911,7 +1950,7 @@ cpt_kasumi_dec_prep(uint64_t d_offs, uint64_t d_lens, struct roc_se_fc_params *p
 static __rte_always_inline int
 cpt_fc_enc_hmac_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens,
 		     struct roc_se_fc_params *fc_params, struct cpt_inst_s *inst,
-		     const bool is_sg_ver2)
+		     const bool is_sg_ver2, const bool use_metadata)
 {
 	struct roc_se_ctx *ctx = fc_params->ctx;
 	uint8_t fc_type;
@@ -1922,7 +1961,8 @@ cpt_fc_enc_hmac_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens,
 	if (likely(fc_type == ROC_SE_FC_GEN)) {
 		ret = cpt_enc_hmac_prep(flags, d_offs, d_lens, fc_params, inst, is_sg_ver2);
 	} else if (fc_type == ROC_SE_PDCP) {
-		ret = cpt_pdcp_alg_prep(flags, d_offs, d_lens, fc_params, inst, is_sg_ver2);
+		ret = cpt_pdcp_alg_prep(flags, d_offs, d_lens, fc_params, inst, is_sg_ver2,
+					use_metadata);
 	} else if (fc_type == ROC_SE_KASUMI) {
 		ret = cpt_kasumi_enc_prep(flags, d_offs, d_lens, fc_params, inst, is_sg_ver2);
 	} else if (fc_type == ROC_SE_HASH_HMAC) {
@@ -2946,7 +2986,7 @@ fill_passthrough_params(struct rte_crypto_op *cop, struct cpt_inst_s *inst)
 static __rte_always_inline int
 fill_pdcp_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		 struct cpt_qp_meta_info *m_info, struct cpt_inflight_req *infl_req,
-		 struct cpt_inst_s *inst, const bool is_sg_ver2)
+		 struct cpt_inst_s *inst, const bool is_sg_ver2, const bool use_metadata)
 {
 	struct rte_crypto_sym_op *sym_op = cop->sym;
 	struct roc_se_fc_params fc_params;
@@ -3022,7 +3062,7 @@ fill_pdcp_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		}
 	}
 
-	ret = cpt_pdcp_alg_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2);
+	ret = cpt_pdcp_alg_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2, use_metadata);
 	if (unlikely(ret)) {
 		plt_dp_err("Could not prepare instruction");
 		goto free_mdata_and_exit;
@@ -3040,7 +3080,7 @@ fill_pdcp_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 static __rte_always_inline int
 fill_pdcp_chain_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		       struct cpt_qp_meta_info *m_info, struct cpt_inflight_req *infl_req,
-		       struct cpt_inst_s *inst, const bool is_sg_ver2)
+		       struct cpt_inst_s *inst, const bool is_sg_ver2, const bool use_metadata)
 {
 	uint32_t ci_data_length, ci_data_offset, a_data_length, a_data_offset;
 	struct rte_crypto_sym_op *sym_op = cop->sym;
@@ -3155,7 +3195,8 @@ fill_pdcp_chain_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	}
 
 	/* Finally prepare the instruction */
-	ret = cpt_pdcp_chain_alg_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2);
+	ret = cpt_pdcp_chain_alg_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2,
+				      use_metadata);
 	if (unlikely(ret)) {
 		plt_dp_err("Could not prepare instruction");
 		goto free_mdata_and_exit;
@@ -3229,7 +3270,7 @@ find_kasumif9_direction_and_length(uint8_t *src, uint32_t counter_num_bytes,
 static __rte_always_inline int
 fill_digest_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		   struct cpt_qp_meta_info *m_info, struct cpt_inflight_req *infl_req,
-		   struct cpt_inst_s *inst, const bool is_sg_ver2)
+		   struct cpt_inst_s *inst, const bool is_sg_ver2, const bool use_metadata)
 {
 	uint32_t space = 0;
 	struct rte_crypto_sym_op *sym_op = cop->sym;
@@ -3365,7 +3406,8 @@ fill_digest_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		goto free_mdata_and_exit;
 	}
 
-	ret = cpt_fc_enc_hmac_prep(flags, d_offs, d_lens, &params, inst, is_sg_ver2);
+	ret = cpt_fc_enc_hmac_prep(flags, d_offs, d_lens, &params, inst, is_sg_ver2, use_metadata);
+
 	if (ret)
 		goto free_mdata_and_exit;
 
@@ -3380,7 +3422,8 @@ fill_digest_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 
 static __rte_always_inline int __rte_hot
 cpt_sym_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op, struct cnxk_se_sess *sess,
-		  struct cpt_inflight_req *infl_req, struct cpt_inst_s *inst, const bool is_sg_ver2)
+		  struct cpt_inflight_req *infl_req, struct cpt_inst_s *inst, const bool is_sg_ver2,
+		  const bool use_metadata)
 {
 	enum cpt_dp_thread_type dp_thr_type;
 	int ret;
@@ -3399,7 +3442,8 @@ cpt_sym_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op, struct cnxk_
 		ret = fill_passthrough_params(op, inst);
 		break;
 	case CPT_DP_THREAD_TYPE_PDCP:
-		ret = fill_pdcp_params(op, sess, &qp->meta_info, infl_req, inst, is_sg_ver2);
+		ret = fill_pdcp_params(op, sess, &qp->meta_info, infl_req, inst, is_sg_ver2,
+				       use_metadata);
 		break;
 	case CPT_DP_THREAD_TYPE_FC_CHAIN:
 		ret = fill_fc_params(op, sess, &qp->meta_info, infl_req, inst, false, false,
@@ -3410,7 +3454,8 @@ cpt_sym_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op, struct cnxk_
 				     is_sg_ver2);
 		break;
 	case CPT_DP_THREAD_TYPE_PDCP_CHAIN:
-		ret = fill_pdcp_chain_params(op, sess, &qp->meta_info, infl_req, inst, is_sg_ver2);
+		ret = fill_pdcp_chain_params(op, sess, &qp->meta_info, infl_req, inst, is_sg_ver2,
+					     use_metadata);
 		break;
 	case CPT_DP_THREAD_TYPE_KASUMI:
 		ret = fill_fc_params(op, sess, &qp->meta_info, infl_req, inst, true, false,
@@ -3421,7 +3466,8 @@ cpt_sym_inst_fill(struct cnxk_cpt_qp *qp, struct rte_crypto_op *op, struct cnxk_
 		break;
 
 	case CPT_DP_THREAD_AUTH_ONLY:
-		ret = fill_digest_params(op, sess, &qp->meta_info, infl_req, inst, is_sg_ver2);
+		ret = fill_digest_params(op, sess, &qp->meta_info, infl_req, inst, is_sg_ver2,
+					 use_metadata);
 		break;
 	default:
 		ret = -EINVAL;
@@ -3658,7 +3704,7 @@ fill_raw_fc_params(struct cnxk_iov *iov, struct cnxk_se_sess *sess, struct cpt_q
 static __rte_always_inline int
 fill_raw_digest_params(struct cnxk_iov *iov, struct cnxk_se_sess *sess,
 		       struct cpt_qp_meta_info *m_info, struct cpt_inflight_req *infl_req,
-		       struct cpt_inst_s *inst, const bool is_sg_ver2)
+		       struct cpt_inst_s *inst, const bool is_sg_ver2, const bool use_metadata)
 {
 	uint16_t auth_op = sess->cpt_op & ROC_SE_OP_AUTH_MASK;
 	struct roc_se_fc_params fc_params;
@@ -3712,7 +3758,8 @@ fill_raw_digest_params(struct cnxk_iov *iov, struct cnxk_se_sess *sess,
 	fc_params.meta_buf.vaddr = (uint8_t *)mdata + space;
 	fc_params.meta_buf.size -= space;
 
-	ret = cpt_fc_enc_hmac_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2);
+	ret = cpt_fc_enc_hmac_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2,
+				   use_metadata);
 	if (ret)
 		goto free_mdata_and_exit;
 
-- 
2.25.1

