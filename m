Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F3CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 446EC4042C;
	Thu, 21 Aug 2025 06:53:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9E7A840684
 for <dev@dpdk.org>; Thu, 21 Aug 2025 06:53:43 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0oEYE008392
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
 c+40yLB2HXzW3DKv042CmO20aj2FIORD9xvxRfWX68=; b=XPabXL/5QiXUu7ldw
 gmwYKCCh/7/2qWH2yaU4eJ6yJftHQgffMpMgQ7kTX8++eknfs+QwrWECt8EgRNIe
 HyR/MOitkS1sdowjS0Onb24KqyrNTcbaaolJze4zhhlguZ3QlQtC+iYWs5PQKDQg
 Svkiyn9XLh15OoixWbZQw7tirvbEpQ0kzQW7A2SKr7WNMAIo0oDAI5kBGGlgw6KD
 h9prsjUWBAP5M3/++dTIJjh480nnGLLLcZj/r1AntgQ0TfA4L5uErzFQUOgh7Kyw
 QVnvdOYG3AXwRxjGGht8YF058+i3A2d1lOK1wRLDVXCaX1VBzmKAmtxTPLnA1CFq
 mxO5w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nhhr9q3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 21:53:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 21:53:46 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 34FAE3F708F;
 Wed, 20 Aug 2025 21:53:36 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 8/8] crypto/cnxk: support custom metadata with CN20K
Date: Thu, 21 Aug 2025 10:23:00 +0530
Message-ID: <20250821045300.3787899-9-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821045300.3787899-1-ktejasree@marvell.com>
References: <20250821045300.3787899-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfX+3kqcMO4iQTb
 kApTzEgE0rgpCiph8cpkrCH/DIZcUM8146PQUGk/ddwZuvgCyFBf6+tA7HKzXXYZUiOLv30N8K2
 DkAMCU1bepvXmvYRJ3fI07l4xKISP5CGL1MwwHvwVTUDllOAhglNoUerWGUaScawjK87Cq/B8Xh
 NLSsuk2miIiIgTqAQ/t/x9T6HmJXFhOIZjFf4NfbBQsEV6N1vdU55sN25vw4DbS8kTka8Awtn7/
 apcD5FtygDylDIwqfAci2EesbmcVLt+UEuUheB6CB1nl/nkv/fQfMkwiXVYpkFRZkN9sdsm8223
 952UvdknrSKnTrLWNsBH9uegNffnq3hpWxk8BUQe9youdlJdm2Ln5EP9IgLjeVkbqASjJXpa/aA
 ooiSsAOIII7Y2kF3omRhNAVAaJ5Lm4zMU7Pyzo4gbNpTjzjhSN9JsAC8xUlrCKEV8p8haMJP
X-Proofpoint-ORIG-GUID: FE9K3sZ1KRvzNABMKBAfCPPNDfUHG4Vl
X-Authority-Analysis: v=2.4 cv=L/REg+T8 c=1 sm=1 tr=0 ts=68a6a656 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=MnyV-gVpyxzKC2GTMGMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: FE9K3sZ1KRvzNABMKBAfCPPNDfUHG4Vl
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

Adding support for custom metadata in CN20K PMD.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/hw/cpt.h              | 14 +++-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c |  4 +
 drivers/crypto/cnxk/cnxk_se.h             | 94 +++++++++++++++--------
 3 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/drivers/common/cnxk/hw/cpt.h b/drivers/common/cnxk/hw/cpt.h
index e542f3a3d4..4079221676 100644
--- a/drivers/common/cnxk/hw/cpt.h
+++ b/drivers/common/cnxk/hw/cpt.h
@@ -247,7 +247,13 @@ struct cpt_inst_s {
 			uint64_t nixtxl : 3;
 			uint64_t doneint : 1;
 			uint64_t nixtx_addr : 60;
-		} s;
+		} cn10k;
+		struct {
+			uint64_t nixtxl : 3;
+			uint64_t doneint : 1;
+			uint64_t rsvd : 58;
+			uint64_t pkt_ctl : 2;
+		} cn20k;
 		struct {
 			uint64_t nixtxl : 3;
 			uint64_t doneint : 1;
@@ -260,7 +266,11 @@ struct cpt_inst_s {
 		uint64_t u64;
 	} w0;
 
-	uint64_t res_addr;
+	struct {
+		uint64_t res_addr : 59;
+		uint64_t meta_sz : 4;
+		uint64_t cq_ena : 1;
+	};
 
 	union cpt_inst_w2 {
 		struct {
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 30194db4ad..b696c28081 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -196,6 +196,10 @@ cn20k_cpt_fill_inst(struct cnxk_cpt_qp *qp, struct rte_crypto_op *ops[], struct
 	inst[0].w2.u64 = 0;
 	inst[0].w3.u64 = 0;
 
+	inst[0].meta_sz = 0;
+	inst[0].cq_ena = 0;
+	inst[0].res_addr = 0;
+
 	sym_op = op->sym;
 
 	if (op->type == RTE_CRYPTO_OP_TYPE_SYMMETRIC) {
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 3631b95e8c..7a0624ca28 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -17,6 +17,9 @@
 #define DST_IOV_SIZE                                                                               \
 	(sizeof(struct roc_se_iov_ptr) + (sizeof(struct roc_se_buf_ptr) * ROC_MAX_SG_CNT))
 
+#define META_PKT_CTL_ENABLE 1
+#define META_SIZE_DIVISOR   32
+
 enum cpt_dp_thread_type {
 	CPT_DP_THREAD_TYPE_FC_CHAIN = 0x1,
 	CPT_DP_THREAD_TYPE_FC_AEAD,
@@ -1526,7 +1529,8 @@ cpt_dec_hmac_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens,
 static __rte_always_inline int
 cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 			struct roc_se_fc_params *params, struct cpt_inst_s *inst,
-			const bool is_sg_ver2, const bool use_metadata)
+			struct cpt_inflight_req *infl_req, const bool is_sg_ver2,
+			const bool use_metadata)
 {
 	uint32_t encr_data_len, auth_data_len, aad_len, passthr_len, pad_len, hdr_len;
 	uint32_t encr_offset, auth_offset, iv_offset = 0;
@@ -1611,19 +1615,23 @@ cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 		dm_vaddr = params->bufs[0].vaddr;
 
 		/* Use Direct mode */
+		if (use_metadata) {
+			inst->w0.cn20k.pkt_ctl = META_PKT_CTL_ENABLE;
+			inst->meta_sz = META_LEN / META_SIZE_DIVISOR;
 
-		offset_vaddr = PLT_PTR_SUB(dm_vaddr, off_ctrl_len + hdr_len);
-		*offset_vaddr = offset_ctrl;
-
-		/* DPTR */
-		inst->dptr = (uint64_t)offset_vaddr;
-		/* RPTR should just exclude offset control word */
-		if (use_metadata)
-			inst->rptr = (uint64_t)dm_vaddr - pad_len;
-		else
+			offset_vaddr = PLT_PTR_CAST(infl_req->meta);
+			inst->dptr = (uint64_t)dm_vaddr - pad_len;
+			inst->rptr = inst->dptr;
+			cpt_inst_w4.s.dlen = inputlen - iv_len;
+		} else {
+			offset_vaddr = PLT_PTR_SUB(dm_vaddr, off_ctrl_len + hdr_len);
+			inst->dptr = (uint64_t)offset_vaddr;
+			/* RPTR should just exclude offset control word */
 			inst->rptr = (uint64_t)PLT_PTR_SUB(dm_vaddr, hdr_len);
+			cpt_inst_w4.s.dlen = inputlen + off_ctrl_len;
+		}
 
-		cpt_inst_w4.s.dlen = inputlen + off_ctrl_len;
+		*offset_vaddr = offset_ctrl;
 
 		iv_d = ((uint8_t *)offset_vaddr + off_ctrl_len);
 		pdcp_iv_copy(iv_d, cipher_iv, pdcp_ci_alg, false);
@@ -1649,8 +1657,8 @@ cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 
 static __rte_always_inline int
 cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
-		  struct roc_se_fc_params *params, struct cpt_inst_s *inst, const bool is_sg_ver2,
-		  const bool use_metadata)
+		  struct roc_se_fc_params *params, struct cpt_inst_s *inst,
+		  struct cpt_inflight_req *infl_req, const bool is_sg_ver2, const bool use_metadata)
 {
 	/*
 	 * pdcp_iv_offset is auth_iv_offset wrt cipher_iv_offset which is
@@ -1666,9 +1674,11 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 	const int flags = se_ctx->zsk_flags;
 	uint32_t encr_offset, auth_offset;
 	union cpt_inst_w4 cpt_inst_w4;
+	uint32_t passthrough_len = 0;
 	int32_t inputlen, outputlen;
 	uint64_t *offset_vaddr;
 	uint8_t pdcp_alg_type;
+	uint32_t pad_len = 0;
 	uint32_t mac_len = 0;
 	uint64_t offset_ctrl;
 	bool pack_iv = false;
@@ -1703,8 +1713,10 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 		}
 
 		if (use_metadata) {
-			inputlen = iv_len + auth_offset + auth_data_len;
-			outputlen = mac_len;
+			passthrough_len = RTE_ALIGN_CEIL(auth_offset, 8);
+			pad_len = passthrough_len - auth_offset;
+			inputlen = pad_len + iv_len + auth_offset + auth_data_len;
+			outputlen = pad_len + mac_len;
 		} else {
 			/* consider iv len */
 			auth_offset += iv_len;
@@ -1735,7 +1747,9 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 		encr_offset = encr_offset / 8;
 
 		if (use_metadata) {
-			outputlen = encr_offset + (RTE_ALIGN(encr_data_len, 8) / 8);
+			passthrough_len = RTE_ALIGN_CEIL(encr_offset, 8);
+			pad_len = passthrough_len - encr_offset;
+			outputlen = pad_len + encr_offset + (RTE_ALIGN(encr_data_len, 8) / 8);
 			inputlen = iv_len + outputlen;
 		} else {
 			/* consider iv len */
@@ -1767,22 +1781,35 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 	 */
 	if (likely((req_flags & ROC_SE_SINGLE_BUF_INPLACE) &&
 		   (req_flags & ROC_SE_SINGLE_BUF_HEADROOM))) {
+
 		void *dm_vaddr = params->bufs[0].vaddr;
 
 		/* Use Direct mode */
-
 		cpt_inst_w4.s.opcode_major = ROC_SE_MAJOR_OP_PDCP_CHAIN;
-		offset_vaddr = (uint64_t *)((uint8_t *)dm_vaddr - off_ctrl_len - iv_len);
 
-		/* DPTR */
-		inst->dptr = (uint64_t)offset_vaddr;
-		/* RPTR should just exclude offset control word */
-		if (use_metadata)
-			inst->rptr = (uint64_t)dm_vaddr;
-		else
+		if (use_metadata) {
+			inst->w0.cn20k.pkt_ctl = META_PKT_CTL_ENABLE;
+			inst->meta_sz = META_LEN / META_SIZE_DIVISOR;
+
+			offset_vaddr = PLT_PTR_CAST(infl_req->meta);
+			offset_ctrl = rte_cpu_to_be_64((uint64_t)(passthrough_len));
+			*offset_vaddr = offset_ctrl;
+
+			inst->dptr = (uint64_t)dm_vaddr - pad_len;
+			inst->rptr = inst->dptr;
+
+			cpt_inst_w4.s.dlen = inputlen - iv_len + pad_len;
+		} else {
+
+			offset_vaddr = (uint64_t *)((uint8_t *)dm_vaddr - off_ctrl_len - iv_len);
+
+			/* DPTR */
+			inst->dptr = (uint64_t)offset_vaddr;
+			/* RPTR should just exclude offset control word */
 			inst->rptr = (uint64_t)dm_vaddr - iv_len;
 
-		cpt_inst_w4.s.dlen = inputlen + off_ctrl_len;
+			cpt_inst_w4.s.dlen = inputlen + off_ctrl_len;
+		}
 
 		uint8_t *iv_d = ((uint8_t *)offset_vaddr + off_ctrl_len);
 		pdcp_iv_copy(iv_d, iv_s, pdcp_alg_type, pack_iv);
@@ -1950,7 +1977,8 @@ cpt_kasumi_dec_prep(uint64_t d_offs, uint64_t d_lens, struct roc_se_fc_params *p
 static __rte_always_inline int
 cpt_fc_enc_hmac_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens,
 		     struct roc_se_fc_params *fc_params, struct cpt_inst_s *inst,
-		     const bool is_sg_ver2, const bool use_metadata)
+		     struct cpt_inflight_req *infl_req, const bool is_sg_ver2,
+		     const bool use_metadata)
 {
 	struct roc_se_ctx *ctx = fc_params->ctx;
 	uint8_t fc_type;
@@ -1961,8 +1989,8 @@ cpt_fc_enc_hmac_prep(uint32_t flags, uint64_t d_offs, uint64_t d_lens,
 	if (likely(fc_type == ROC_SE_FC_GEN)) {
 		ret = cpt_enc_hmac_prep(flags, d_offs, d_lens, fc_params, inst, is_sg_ver2);
 	} else if (fc_type == ROC_SE_PDCP) {
-		ret = cpt_pdcp_alg_prep(flags, d_offs, d_lens, fc_params, inst, is_sg_ver2,
-					use_metadata);
+		ret = cpt_pdcp_alg_prep(flags, d_offs, d_lens, fc_params, inst, infl_req,
+					is_sg_ver2, use_metadata);
 	} else if (fc_type == ROC_SE_KASUMI) {
 		ret = cpt_kasumi_enc_prep(flags, d_offs, d_lens, fc_params, inst, is_sg_ver2);
 	} else if (fc_type == ROC_SE_HASH_HMAC) {
@@ -3062,7 +3090,8 @@ fill_pdcp_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		}
 	}
 
-	ret = cpt_pdcp_alg_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2, use_metadata);
+	ret = cpt_pdcp_alg_prep(flags, d_offs, d_lens, &fc_params, inst, infl_req, is_sg_ver2,
+				use_metadata);
 	if (unlikely(ret)) {
 		plt_dp_err("Could not prepare instruction");
 		goto free_mdata_and_exit;
@@ -3195,7 +3224,7 @@ fill_pdcp_chain_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	}
 
 	/* Finally prepare the instruction */
-	ret = cpt_pdcp_chain_alg_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2,
+	ret = cpt_pdcp_chain_alg_prep(flags, d_offs, d_lens, &fc_params, inst, infl_req, is_sg_ver2,
 				      use_metadata);
 	if (unlikely(ret)) {
 		plt_dp_err("Could not prepare instruction");
@@ -3406,7 +3435,8 @@ fill_digest_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		goto free_mdata_and_exit;
 	}
 
-	ret = cpt_fc_enc_hmac_prep(flags, d_offs, d_lens, &params, inst, is_sg_ver2, use_metadata);
+	ret = cpt_fc_enc_hmac_prep(flags, d_offs, d_lens, &params, inst, infl_req, is_sg_ver2,
+				   use_metadata);
 
 	if (ret)
 		goto free_mdata_and_exit;
@@ -3758,7 +3788,7 @@ fill_raw_digest_params(struct cnxk_iov *iov, struct cnxk_se_sess *sess,
 	fc_params.meta_buf.vaddr = (uint8_t *)mdata + space;
 	fc_params.meta_buf.size -= space;
 
-	ret = cpt_fc_enc_hmac_prep(flags, d_offs, d_lens, &fc_params, inst, is_sg_ver2,
+	ret = cpt_fc_enc_hmac_prep(flags, d_offs, d_lens, &fc_params, inst, infl_req, is_sg_ver2,
 				   use_metadata);
 	if (ret)
 		goto free_mdata_and_exit;
-- 
2.25.1

