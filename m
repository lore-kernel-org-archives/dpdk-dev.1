Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0ECCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:53:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1C8040656;
	Thu, 21 Aug 2025 06:53:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3F9474042C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 06:53:31 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0q2H7030611
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 5SCL2C0Y+EZJRQUBJ+FrZDgeYPFL10ncUvkrCjTyxc=; b=X4WHJAAzb6vzACM5s
 RbefLmARiV31sx247ZGRzvK/7uZuuq8uTr1AzoRfEy+zEDRa7lfdoarr9sJsvzaa
 F6WHE5uI95PjNdAMeJZNsq28owJM/1wv9f0NUXWAQgocRfta8ohTZycPR7f5pwNs
 KEkR9Z7+zwPHBtbZx8C7UoSPHErHG0xAr8W8FpfU24pExqD0t3Y1JY753AJYfnmV
 FUR7PEHQxoVN4I7BG7ifcTR4d+oQTIhWA0ZSsw+t++nqR/PNvRZ6TTUVvyqFfL69
 jp6PcbRgvnLZJb2oz7/h742JwRi5AKCcgt/SxjUc4sCVd0Fheua/5SoxyhTBptX9
 uXFow==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nr2m8hq8-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:53:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 21:53:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 21:53:33 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 150E33F708F;
 Wed, 20 Aug 2025 21:53:24 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 5/8] crypto/cnxk: align cptr to 256B in cn20k
Date: Thu, 21 Aug 2025 10:22:57 +0530
Message-ID: <20250821045300.3787899-6-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821045300.3787899-1-ktejasree@marvell.com>
References: <20250821045300.3787899-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfX5Cp9SxJVThQt
 6SVMU2piXt5ujodHvf5wHpfyPMzncWcOuQehgYPz8FY9RWjh1ta6Jzch1CCg/KC1dOwuDeZhtL7
 D2YntCDYWO0Lb7sr3aYAPG8B1scaXCAEmmCUx5CWvId42XLqRcVuJJGGG/MJGZhdNzc89JWG5Bc
 50BS4wJlnpAhyJ4bt5UGsFFPPQRgJ+rtVEssI61PPM/EI/Gy3Lzu1AJtFyGNQ+BcssX40AZBFSm
 kti+DKYp3VJzdgU0h7ArkA8Xe/85JkEQ8ZOA5tIPvOu7Yp+yROaSTYKwvX1To8YUnTAXfQFoOEp
 HX1dRt3mA8pcovBzWtvgvlbiCLDw42uRfoZUP5wdiEBY3YrVna4mD+uFTUqx1sJMwr/m+B7KPCQ
 9eLMNf1s/nfQfIhxu7zpyHLqlD0wKF+cfVPGyj3hX5fMTRcbJGzQoLjhV5a72dEzv6Wl50A4
X-Proofpoint-GUID: xmNEoKswHgdytuojuDHQoytC39yaRL_g
X-Proofpoint-ORIG-GUID: xmNEoKswHgdytuojuDHQoytC39yaRL_g
X-Authority-Analysis: v=2.4 cv=LOc/gJW9 c=1 sm=1 tr=0 ts=68a6a64a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=AzLkfqTRQaXPGXN5cqkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Change the alignment of cptr to 256 bytes from
128 bytes in cn20k.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/common/cnxk/roc_cpt.h             |   4 +
 drivers/common/cnxk/roc_se.h              |  37 +++----
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c |   8 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c |   8 +-
 drivers/crypto/cnxk/cn20k_ipsec.c         |  74 +++++++++----
 drivers/crypto/cnxk/cn20k_ipsec.h         |  15 ++-
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h  |  41 +++++---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c  |  61 ++++++++---
 drivers/crypto/cnxk/cnxk_se.h             | 121 ++++++++++++++++------
 9 files changed, 253 insertions(+), 116 deletions(-)

diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index aa30f46f04..37bca8d183 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -129,6 +129,10 @@
 	(PLT_ALIGN_CEIL(ROC_AR_WIN_SIZE_MAX, BITS_PER_LONG_LONG) /             \
 	 BITS_PER_LONG_LONG)
 
+/* ROC CPTR Cache */
+#define ROC_CPTR_CACHE_LINE_SZ 256
+#define ROC_CPTR_ALIGN	       ROC_CPTR_CACHE_LINE_SZ
+
 enum {
 	ROC_CPT_REVISION_ID_83XX = 0,
 	ROC_CPT_REVISION_ID_96XX_B0 = 1,
diff --git a/drivers/common/cnxk/roc_se.h b/drivers/common/cnxk/roc_se.h
index f2c4056169..9afcda8ba4 100644
--- a/drivers/common/cnxk/roc_se.h
+++ b/drivers/common/cnxk/roc_se.h
@@ -314,24 +314,6 @@ struct roc_se_iov_ptr {
 #define ROC_SE_PDCP_CHAIN_CTX_KEY_IV 1
 
 struct roc_se_ctx {
-	/* Below fields are accessed by sw */
-	uint64_t enc_cipher : 8;
-	uint64_t hash_type : 8;
-	uint64_t mac_len : 8;
-	uint64_t auth_key_len : 16;
-	uint64_t fc_type : 4;
-	uint64_t hmac : 1;
-	uint64_t zsk_flags : 3;
-	uint64_t k_ecb : 1;
-	uint64_t pdcp_ci_alg : 2;
-	uint64_t pdcp_auth_alg : 2;
-	uint64_t ciph_then_auth : 1;
-	uint64_t auth_then_ciph : 1;
-	uint64_t eia2 : 1;
-	/* auth_iv_offset passed to PDCP_CHAIN opcode based on FVC bit */
-	uint8_t pdcp_iv_offset;
-	union cpt_inst_w4 template_w4;
-	uint8_t *auth_key;
 	/* Below fields are accessed by hardware */
 	struct se_ctx_s {
 		/* Word0 */
@@ -356,6 +338,25 @@ struct roc_se_ctx {
 			struct roc_se_sm_context sm_ctx;
 		};
 	} se_ctx __plt_aligned(ROC_ALIGN);
+
+	/* Below fields are accessed by sw */
+	uint64_t enc_cipher : 8;
+	uint64_t hash_type : 8;
+	uint64_t mac_len : 8;
+	uint64_t auth_key_len : 16;
+	uint64_t fc_type : 4;
+	uint64_t hmac : 1;
+	uint64_t zsk_flags : 3;
+	uint64_t k_ecb : 1;
+	uint64_t pdcp_ci_alg : 2;
+	uint64_t pdcp_auth_alg : 2;
+	uint64_t ciph_then_auth : 1;
+	uint64_t auth_then_ciph : 1;
+	uint64_t eia2 : 1;
+	/* auth_iv_offset passed to PDCP_CHAIN opcode based on FVC bit */
+	uint8_t pdcp_iv_offset;
+	union cpt_inst_w4 template_w4;
+	uint8_t *auth_key;
 } __plt_aligned(ROC_ALIGN);
 
 struct roc_se_fc_params {
diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 31ec88c7d6..17edf636da 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -1928,7 +1928,7 @@ cn10k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 	if (sess_type != RTE_CRYPTO_OP_WITH_SESSION)
 		return -ENOTSUP;
 
-	if (sess == NULL)
+	if (sess == NULL || sess->roc_se_ctx == NULL)
 		return -EINVAL;
 
 	if ((sess->dp_thr_type == CPT_DP_THREAD_TYPE_PDCP) ||
@@ -1938,11 +1938,11 @@ cn10k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 		return -ENOTSUP;
 
 	if ((sess->dp_thr_type == CPT_DP_THREAD_AUTH_ONLY) &&
-	    ((sess->roc_se_ctx.fc_type == ROC_SE_KASUMI) ||
-	     (sess->roc_se_ctx.fc_type == ROC_SE_PDCP)))
+	    ((sess->roc_se_ctx->fc_type == ROC_SE_KASUMI) ||
+	     (sess->roc_se_ctx->fc_type == ROC_SE_PDCP)))
 		return -ENOTSUP;
 
-	if (sess->roc_se_ctx.hash_type == ROC_SE_SHA1_TYPE)
+	if (sess->roc_se_ctx->hash_type == ROC_SE_SHA1_TYPE)
 		return -ENOTSUP;
 
 	dp_ctx = (struct cnxk_sym_dp_ctx *)raw_dp_ctx->drv_ctx_data;
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 6ef7c5bb22..86d02ba5ca 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -1675,7 +1675,7 @@ cn20k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 	if (sess_type != RTE_CRYPTO_OP_WITH_SESSION)
 		return -ENOTSUP;
 
-	if (sess == NULL)
+	if (sess == NULL || sess->roc_se_ctx == NULL)
 		return -EINVAL;
 
 	if ((sess->dp_thr_type == CPT_DP_THREAD_TYPE_PDCP) ||
@@ -1685,11 +1685,11 @@ cn20k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 		return -ENOTSUP;
 
 	if ((sess->dp_thr_type == CPT_DP_THREAD_AUTH_ONLY) &&
-	    ((sess->roc_se_ctx.fc_type == ROC_SE_KASUMI) ||
-	     (sess->roc_se_ctx.fc_type == ROC_SE_PDCP)))
+	    ((sess->roc_se_ctx->fc_type == ROC_SE_KASUMI) ||
+	     (sess->roc_se_ctx->fc_type == ROC_SE_PDCP)))
 		return -ENOTSUP;
 
-	if (sess->roc_se_ctx.hash_type == ROC_SE_SHA1_TYPE)
+	if (sess->roc_se_ctx->hash_type == ROC_SE_SHA1_TYPE)
 		return -ENOTSUP;
 
 	dp_ctx = (struct cnxk_sym_dp_ctx *)raw_dp_ctx->drv_ctx_data;
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index 0bca863492..785bee02d4 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -35,20 +35,27 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	int ret = 0;
 
 	sa = &sec_sess->sa;
-	out_sa = &sa->out_sa;
+
+	out_sa = rte_zmalloc("cn20k_cpt", sizeof(struct roc_ow_ipsec_outb_sa), ROC_CPTR_ALIGN);
+	if (out_sa == NULL) {
+		plt_err("Couldn't allocate memory for outbound SA");
+		return -ENOMEM;
+	}
+	sa->out_sa = out_sa;
 
 	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
 	sa_dptr = plt_zmalloc(sizeof(struct roc_ow_ipsec_outb_sa), 8);
 	if (sa_dptr == NULL) {
 		plt_err("Could not allocate memory for SA dptr");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto sa_cptr_free;
 	}
 
 	/* Translate security parameters to SA */
 	ret = cnxk_ow_ipsec_outb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm, roc_cpt->ctx_ilen);
 	if (ret) {
 		plt_err("Could not fill outbound session parameters");
-		goto sa_dptr_free;
+		goto sa_free;
 	}
 
 	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, out_sa);
@@ -72,7 +79,7 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	if (ipsec_xfrm->options.iv_gen_disable != 0) {
 		plt_err("Application provided IV not supported");
 		ret = -ENOTSUP;
-		goto sa_dptr_free;
+		goto sa_free;
 	}
 #endif
 
@@ -81,7 +88,7 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	/* Get Rlen calculation data */
 	ret = cnxk_ipsec_outb_rlens_get(&rlens, ipsec_xfrm, crypto_xfrm);
 	if (ret)
-		goto sa_dptr_free;
+		goto sa_free;
 
 	sec_sess->max_extended_len = rlens.max_extended_len;
 
@@ -128,21 +135,26 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	ret = roc_cpt_ctx_write(lf, sa_dptr, out_sa, sizeof(struct roc_ow_ipsec_outb_sa));
 	if (ret) {
 		plt_err("Could not write outbound session to hardware");
-		goto sa_dptr_free;
+		goto sa_free;
 	}
 
 	/* Trigger CTX flush so that data is written back to DRAM */
 	ret = roc_cpt_lf_ctx_flush(lf, out_sa, false);
 	if (ret == -EFAULT) {
 		plt_err("Could not flush outbound session");
-		goto sa_dptr_free;
+		goto sa_free;
 	}
 
 	sec_sess->proto = RTE_SECURITY_PROTOCOL_IPSEC;
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-sa_dptr_free:
+sa_free:
 	plt_free(sa_dptr);
+sa_cptr_free:
+	if (ret != 0) {
+		rte_free(out_sa);
+		out_sa = NULL;
+	}
 
 	return ret;
 }
@@ -161,20 +173,27 @@ cn20k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	int ret = 0;
 
 	sa = &sec_sess->sa;
-	in_sa = &sa->in_sa;
+
+	in_sa = rte_zmalloc("cn20k_cpt", sizeof(struct roc_ow_ipsec_inb_sa), ROC_CPTR_ALIGN);
+	if (in_sa == NULL) {
+		plt_err("Couldn't allocate memory for inbound SA");
+		return -ENOMEM;
+	}
+	sa->in_sa = in_sa;
 
 	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
 	sa_dptr = plt_zmalloc(sizeof(struct roc_ow_ipsec_inb_sa), 8);
 	if (sa_dptr == NULL) {
 		plt_err("Could not allocate memory for SA dptr");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto sa_cptr_free;
 	}
 
 	/* Translate security parameters to SA */
 	ret = cnxk_ow_ipsec_inb_sa_fill(sa_dptr, ipsec_xfrm, crypto_xfrm, roc_cpt->ctx_ilen);
 	if (ret) {
 		plt_err("Could not fill inbound session parameters");
-		goto sa_dptr_free;
+		goto sa_free;
 	}
 
 	sec_sess->ipsec.is_outbound = 0;
@@ -231,21 +250,26 @@ cn20k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	ret = roc_cpt_ctx_write(lf, sa_dptr, in_sa, sizeof(struct roc_ow_ipsec_inb_sa));
 	if (ret) {
 		plt_err("Could not write inbound session to hardware");
-		goto sa_dptr_free;
+		goto sa_free;
 	}
 
 	/* Trigger CTX flush so that data is written back to DRAM */
 	ret = roc_cpt_lf_ctx_flush(lf, in_sa, true);
 	if (ret == -EFAULT) {
 		plt_err("Could not flush inbound session");
-		goto sa_dptr_free;
+		goto sa_free;
 	}
 
 	sec_sess->proto = RTE_SECURITY_PROTOCOL_IPSEC;
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-sa_dptr_free:
+sa_free:
 	plt_free(sa_dptr);
+sa_cptr_free:
+	if (ret != 0) {
+		rte_free(in_sa);
+		in_sa = NULL;
+	}
 
 	return ret;
 }
@@ -286,8 +310,11 @@ cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session
 
 	sa = &sess->sa;
 
+	if (sa->sa_ptr == NULL)
+		return -EINVAL;
+
 	/* Trigger CTX flush to write dirty data back to DRAM */
-	roc_cpt_lf_ctx_flush(lf, &sa->in_sa, false);
+	roc_cpt_lf_ctx_flush(lf, sa->in_sa, false);
 
 	ret = -1;
 
@@ -296,7 +323,7 @@ cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session
 		if (sa_dptr != NULL) {
 			roc_ow_ipsec_outb_sa_init(sa_dptr);
 
-			ret = roc_cpt_ctx_write(lf, sa_dptr, &sa->out_sa,
+			ret = roc_cpt_ctx_write(lf, sa_dptr, sa->out_sa,
 						sizeof(struct roc_ow_ipsec_outb_sa));
 		}
 	} else {
@@ -304,7 +331,7 @@ cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session
 		if (sa_dptr != NULL) {
 			roc_ow_ipsec_inb_sa_init(sa_dptr);
 
-			ret = roc_cpt_ctx_write(lf, sa_dptr, &sa->in_sa,
+			ret = roc_cpt_ctx_write(lf, sa_dptr, sa->in_sa,
 						sizeof(struct roc_ow_ipsec_inb_sa));
 		}
 	}
@@ -317,15 +344,17 @@ cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session
 		/* Wait for 1 ms so that flush is complete */
 		rte_delay_ms(1);
 
-		w2 = (union roc_ow_ipsec_sa_word2 *)&sa->in_sa.w2;
+		w2 = (union roc_ow_ipsec_sa_word2 *)&sa->in_sa->w2;
 		w2->s.valid = 0;
 
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
 		/* Trigger CTX reload to fetch new data from DRAM */
-		roc_cpt_lf_ctx_reload(lf, &sa->in_sa);
+		roc_cpt_lf_ctx_reload(lf, sa->in_sa);
 	}
 
+	rte_free(sa->sa_ptr);
+
 	return 0;
 }
 
@@ -340,13 +369,16 @@ cn20k_ipsec_stats_get(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess,
 	stats->protocol = RTE_SECURITY_PROTOCOL_IPSEC;
 	sa = &sess->sa;
 
+	if (sa->sa_ptr == NULL)
+		return -EINVAL;
+
 	if (sess->ipsec.is_outbound) {
-		out_sa = &sa->out_sa;
+		out_sa = sa->out_sa;
 		roc_cpt_lf_ctx_flush(&qp->lf, out_sa, false);
 		stats->ipsec.opackets = out_sa->ctx.mib_pkts;
 		stats->ipsec.obytes = out_sa->ctx.mib_octs;
 	} else {
-		in_sa = &sa->in_sa;
+		in_sa = sa->in_sa;
 		roc_cpt_lf_ctx_flush(&qp->lf, in_sa, false);
 		stats->ipsec.ipackets = in_sa->ctx.mib_pkts;
 		stats->ipsec.ibytes = in_sa->ctx.mib_octs;
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.h b/drivers/crypto/cnxk/cn20k_ipsec.h
index 202d52405d..069142fbc6 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.h
+++ b/drivers/crypto/cnxk/cn20k_ipsec.h
@@ -18,13 +18,18 @@
 /* Forward declaration */
 struct cn20k_sec_session;
 
-struct __rte_aligned(ROC_ALIGN) cn20k_ipsec_sa
+struct __rte_aligned(ROC_CPTR_ALIGN) cn20k_ipsec_sa
 {
 	union {
-		/** Inbound SA */
-		struct roc_ow_ipsec_inb_sa in_sa;
-		/** Outbound SA */
-		struct roc_ow_ipsec_outb_sa out_sa;
+		void *sa_ptr;
+		struct {
+			union {
+				/** Inbound SA */
+				struct roc_ow_ipsec_inb_sa *in_sa;
+				/** Outbound SA */
+				struct roc_ow_ipsec_outb_sa *out_sa;
+			};
+		};
 	};
 };
 
diff --git a/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
index 2f860c1855..10afa666e0 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
+++ b/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
@@ -19,9 +19,12 @@
 static inline void
 ipsec_po_sa_iv_set(struct cn20k_sec_session *sess, struct rte_crypto_op *cop)
 {
-	uint64_t *iv = &sess->sa.out_sa.iv.u64[0];
-	uint64_t *tmp_iv;
+	uint64_t *iv, *tmp_iv;
 
+	if (sess->sa.out_sa == NULL)
+		return;
+
+	iv = &sess->sa.out_sa->iv.u64[0];
 	memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset), 16);
 	tmp_iv = (uint64_t *)iv;
 	*tmp_iv = rte_be_to_cpu_64(*tmp_iv);
@@ -33,14 +36,18 @@ ipsec_po_sa_iv_set(struct cn20k_sec_session *sess, struct rte_crypto_op *cop)
 static inline void
 ipsec_po_sa_aes_8b_iv_set(struct cn20k_sec_session *sess, struct rte_crypto_op *cop)
 {
-	uint8_t *iv = &sess->sa.out_sa.iv.s.iv_dbg1[0];
+	uint8_t *iv;
 	uint32_t *tmp_iv;
 
+	if (sess->sa.out_sa == NULL)
+		return;
+
+	iv = &sess->sa.out_sa->iv.s.iv_dbg1[0];
 	memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset), 4);
 	tmp_iv = (uint32_t *)iv;
 	*tmp_iv = rte_be_to_cpu_32(*tmp_iv);
 
-	iv = &sess->sa.out_sa.iv.s.iv_dbg2[0];
+	iv = &sess->sa.out_sa->iv.s.iv_dbg2[0];
 	memcpy(iv, rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset + 4), 4);
 	tmp_iv = (uint32_t *)iv;
 	*tmp_iv = rte_be_to_cpu_32(*tmp_iv);
@@ -59,19 +66,21 @@ process_outb_sa(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn20k_s
 	RTE_SET_USED(lf);
 
 #ifdef LA_IPSEC_DEBUG
-	if (sess->sa.out_sa.w2.s.iv_src == ROC_IE_OW_SA_IV_SRC_FROM_SA) {
-		if (sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
-		    sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
-		    sess->sa.out_sa.w2.s.auth_type == ROC_IE_SA_AUTH_AES_GMAC ||
-		    sess->sa.out_sa.w2.s.enc_type == ROC_IE_SA_ENC_AES_CTR)
-			ipsec_po_sa_aes_8b_iv_set(sess, cop);
-		else
-			ipsec_po_sa_iv_set(sess, cop);
-	}
+	if (sess->sa.out_sa) {
+		if (sess->sa.out_sa->w2.s.iv_src == ROC_IE_OW_SA_IV_SRC_FROM_SA) {
+			if (sess->sa.out_sa->w2.s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
+			    sess->sa.out_sa->w2.s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
+			    sess->sa.out_sa->w2.s.auth_type == ROC_IE_SA_AUTH_AES_GMAC ||
+			    sess->sa.out_sa->w2.s.enc_type == ROC_IE_SA_ENC_AES_CTR)
+				ipsec_po_sa_aes_8b_iv_set(sess, cop);
+			else
+				ipsec_po_sa_iv_set(sess, cop);
+		}
 
-	/* Trigger CTX reload to fetch new data from DRAM */
-	roc_cpt_lf_ctx_reload(lf, &sess->sa.out_sa);
-	rte_delay_ms(1);
+		/* Trigger CTX reload to fetch new data from DRAM */
+		roc_cpt_lf_ctx_reload(lf, sess->sa.out_sa);
+		rte_delay_ms(1);
+	}
 #endif
 	const uint64_t ol_flags = m_src->ol_flags;
 
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 8bc7b2c345..7dc4c684cc 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -600,9 +600,9 @@ cnxk_sess_fill(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xform,
 	bool ciph_then_auth = false;
 
 	if (roc_cpt->hw_caps[CPT_ENG_TYPE_SE].pdcp_chain_zuc256)
-		sess->roc_se_ctx.pdcp_iv_offset = 24;
+		sess->roc_se_ctx->pdcp_iv_offset = 24;
 	else
-		sess->roc_se_ctx.pdcp_iv_offset = 16;
+		sess->roc_se_ctx->pdcp_iv_offset = 16;
 
 	if (xform == NULL)
 		return -EINVAL;
@@ -706,7 +706,7 @@ cnxk_sess_fill(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xform,
 				return -ENOTSUP;
 			}
 		}
-		sess->roc_se_ctx.ciph_then_auth = 1;
+		sess->roc_se_ctx->ciph_then_auth = 1;
 		sess->chained_op = 1;
 		if (fill_sess_cipher(c_xfrm, sess))
 			return -ENOTSUP;
@@ -742,7 +742,7 @@ cnxk_sess_fill(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xform,
 		}
 	}
 
-	sess->roc_se_ctx.auth_then_ciph = 1;
+	sess->roc_se_ctx->auth_then_ciph = 1;
 	sess->chained_op = 1;
 	if (fill_sess_auth(a_xfrm, sess))
 		return -ENOTSUP;
@@ -757,7 +757,12 @@ cnxk_cpt_inst_w7_get(struct cnxk_se_sess *sess, struct roc_cpt *roc_cpt)
 {
 	union cpt_inst_w7 inst_w7;
 
-	inst_w7.s.cptr = (uint64_t)&sess->roc_se_ctx.se_ctx;
+	if (sess->roc_se_ctx == NULL) {
+		plt_err("Invalid se context");
+		return 0;
+	}
+
+	inst_w7.s.cptr = (uint64_t)&sess->roc_se_ctx->se_ctx;
 
 	if (hw_ctx_cache_enable())
 		inst_w7.s.ctx_val = 1;
@@ -787,6 +792,13 @@ sym_session_configure(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xfor
 	if (is_session_less)
 		memset(sess_priv, 0, sizeof(struct cnxk_se_sess));
 
+	sess_priv->roc_se_ctx =
+		rte_zmalloc("roc_se_ctx", sizeof(struct roc_se_ctx), ROC_CPTR_ALIGN);
+	if (sess_priv->roc_se_ctx == NULL) {
+		plt_err("Couldn't allocate memory for se context");
+		return -ENOMEM;
+	}
+
 	ret = cnxk_sess_fill(roc_cpt, xform, sess_priv);
 	if (ret)
 		goto priv_put;
@@ -796,7 +808,7 @@ sym_session_configure(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xfor
 	if (sess_priv->passthrough)
 		thr_type = CPT_DP_THREAD_TYPE_PT;
 	else if (sess_priv->cpt_op & ROC_SE_OP_CIPHER_MASK) {
-		switch (sess_priv->roc_se_ctx.fc_type) {
+		switch (sess_priv->roc_se_ctx->fc_type) {
 		case ROC_SE_FC_GEN:
 			if (sess_priv->aes_gcm || sess_priv->aes_ccm || sess_priv->chacha_poly)
 				thr_type = CPT_DP_THREAD_TYPE_FC_AEAD;
@@ -826,12 +838,12 @@ sym_session_configure(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xfor
 
 	sess_priv->dp_thr_type = thr_type;
 
-	if ((sess_priv->roc_se_ctx.fc_type == ROC_SE_HASH_HMAC) &&
+	if ((sess_priv->roc_se_ctx->fc_type == ROC_SE_HASH_HMAC) &&
 	    cpt_mac_len_verify(&xform->auth)) {
 		plt_dp_err("MAC length is not supported");
-		if (sess_priv->roc_se_ctx.auth_key != NULL) {
-			plt_free(sess_priv->roc_se_ctx.auth_key);
-			sess_priv->roc_se_ctx.auth_key = NULL;
+		if (sess_priv->roc_se_ctx->auth_key != NULL) {
+			plt_free(sess_priv->roc_se_ctx->auth_key);
+			sess_priv->roc_se_ctx->auth_key = NULL;
 		}
 
 		ret = -ENOTSUP;
@@ -841,14 +853,18 @@ sym_session_configure(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xfor
 	sess_priv->cpt_inst_w7 = cnxk_cpt_inst_w7_get(sess_priv, roc_cpt);
 
 	if (hw_ctx_cache_enable())
-		roc_se_ctx_init(&sess_priv->roc_se_ctx);
+		roc_se_ctx_init(sess_priv->roc_se_ctx);
 
-	if (sess_priv->roc_se_ctx.se_ctx.w0.s.ctx_size < roc_cpt->ctx_ilen)
-		sess_priv->roc_se_ctx.se_ctx.w0.s.ctx_size = roc_cpt->ctx_ilen;
+	if (sess_priv->roc_se_ctx->se_ctx.w0.s.ctx_size < roc_cpt->ctx_ilen)
+		sess_priv->roc_se_ctx->se_ctx.w0.s.ctx_size = roc_cpt->ctx_ilen;
 
 	return 0;
 
 priv_put:
+	if (sess_priv->roc_se_ctx != NULL) {
+		rte_free(sess_priv->roc_se_ctx);
+		sess_priv->roc_se_ctx = NULL;
+	}
 	return ret;
 }
 
@@ -868,12 +884,19 @@ sym_session_clear(struct rte_cryptodev_sym_session *sess, bool is_session_less)
 {
 	struct cnxk_se_sess *sess_priv = (struct cnxk_se_sess *)sess;
 
+	if (sess_priv->roc_se_ctx == NULL)
+		return;
+
 	/* Trigger CTX flush + invalidate to remove from CTX_CACHE */
 	if (hw_ctx_cache_enable())
-		roc_cpt_lf_ctx_flush(sess_priv->lf, &sess_priv->roc_se_ctx.se_ctx, true);
+		roc_cpt_lf_ctx_flush(sess_priv->lf, &sess_priv->roc_se_ctx->se_ctx, true);
 
-	if (sess_priv->roc_se_ctx.auth_key != NULL)
-		plt_free(sess_priv->roc_se_ctx.auth_key);
+	if (sess_priv->roc_se_ctx->auth_key != NULL)
+		plt_free(sess_priv->roc_se_ctx->auth_key);
+
+	/* Free the allocated roc_se_ctx memory */
+	rte_free(sess_priv->roc_se_ctx);
+	sess_priv->roc_se_ctx = NULL;
 
 	if (is_session_less)
 		memset(sess_priv, 0, cnxk_cpt_sym_session_get_size(NULL));
@@ -1178,7 +1201,11 @@ rte_pmd_cnxk_crypto_cptr_get(struct rte_pmd_cnxk_crypto_sess *rte_sess)
 
 	if (rte_sess->sess_type == RTE_CRYPTO_OP_WITH_SESSION) {
 		struct cnxk_se_sess *se_sess = PLT_PTR_CAST(rte_sess->crypto_sym_sess);
-		return PLT_PTR_CAST(&se_sess->roc_se_ctx.se_ctx);
+		if (se_sess->roc_se_ctx == NULL) {
+			plt_err("Invalid roc_se_ctx pointer");
+			return NULL;
+		}
+		return PLT_PTR_CAST(&se_sess->roc_se_ctx->se_ctx);
 	}
 
 	if (rte_sess->sess_type == RTE_CRYPTO_OP_SECURITY_SESSION) {
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 649e38c495..1838140727 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -65,7 +65,7 @@ struct __rte_aligned(ROC_ALIGN) cnxk_se_sess {
 	uint64_t cpt_inst_w7;
 	uint64_t cpt_inst_w2;
 	struct cnxk_cpt_qp *qp;
-	struct roc_se_ctx roc_se_ctx;
+	struct roc_se_ctx *roc_se_ctx;
 	struct roc_cpt_lf *lf;
 };
 
@@ -1945,6 +1945,11 @@ fill_sess_aead(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 	uint32_t cipher_key_len = 0;
 	aead_form = &xform->aead;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	if (aead_form->op == RTE_CRYPTO_AEAD_OP_ENCRYPT) {
 		sess->cpt_op |= ROC_SE_OP_CIPHER_ENCRYPT;
 		sess->cpt_op |= ROC_SE_OP_AUTH_GENERATE;
@@ -2007,34 +2012,39 @@ fill_sess_aead(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		}
 	}
 
-	if (unlikely(roc_se_ciph_key_set(&sess->roc_se_ctx, enc_type, aead_form->key.data,
+	if (unlikely(roc_se_ciph_key_set(sess->roc_se_ctx, enc_type, aead_form->key.data,
 					 aead_form->key.length)))
 		return -1;
 
-	if (unlikely(roc_se_auth_key_set(&sess->roc_se_ctx, auth_type, NULL, 0,
+	if (unlikely(roc_se_auth_key_set(sess->roc_se_ctx, auth_type, NULL, 0,
 					 aead_form->digest_length)))
 		return -1;
 
 	if (enc_type == ROC_SE_CHACHA20)
-		sess->roc_se_ctx.template_w4.s.opcode_minor |= BIT(5);
+		sess->roc_se_ctx->template_w4.s.opcode_minor |= BIT(5);
 	return 0;
 }
 
 static __rte_always_inline int
 fill_sm_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 {
-	struct roc_se_sm_context *sm_ctx = &sess->roc_se_ctx.se_ctx.sm_ctx;
+	struct roc_se_sm_context *sm_ctx = &sess->roc_se_ctx->se_ctx.sm_ctx;
 	struct rte_crypto_cipher_xform *c_form;
 	roc_sm_cipher_type enc_type = 0;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	c_form = &xform->cipher;
 
 	if (c_form->op == RTE_CRYPTO_CIPHER_OP_ENCRYPT) {
 		sess->cpt_op |= ROC_SE_OP_CIPHER_ENCRYPT;
-		sess->roc_se_ctx.template_w4.s.opcode_minor = ROC_SE_FC_MINOR_OP_ENCRYPT;
+		sess->roc_se_ctx->template_w4.s.opcode_minor = ROC_SE_FC_MINOR_OP_ENCRYPT;
 	} else if (c_form->op == RTE_CRYPTO_CIPHER_OP_DECRYPT) {
 		sess->cpt_op |= ROC_SE_OP_CIPHER_DECRYPT;
-		sess->roc_se_ctx.template_w4.s.opcode_minor = ROC_SE_FC_MINOR_OP_DECRYPT;
+		sess->roc_se_ctx->template_w4.s.opcode_minor = ROC_SE_FC_MINOR_OP_DECRYPT;
 	} else {
 		plt_dp_err("Unknown cipher operation");
 		return -1;
@@ -2075,9 +2085,9 @@ fill_sm_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *ses
 	sess->aes_ctr = 0;
 	sess->is_null = 0;
 	sess->is_sm4 = 1;
-	sess->roc_se_ctx.fc_type = ROC_SE_SM;
+	sess->roc_se_ctx->fc_type = ROC_SE_SM;
 
-	sess->roc_se_ctx.template_w4.s.opcode_major = ROC_SE_MAJOR_OP_SM;
+	sess->roc_se_ctx->template_w4.s.opcode_major = ROC_SE_MAJOR_OP_SM;
 
 	memcpy(sm_ctx->encr_key, c_form->key.data, ROC_SE_SM4_KEY_LEN);
 	sm_ctx->enc_cipher = enc_type;
@@ -2093,6 +2103,11 @@ fill_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 	roc_se_cipher_type enc_type = 0; /* NULL Cipher type */
 	uint32_t cipher_key_len = 0;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	c_form = &xform->cipher;
 
 	if ((c_form->algo == RTE_CRYPTO_CIPHER_SM4_CBC) ||
@@ -2109,7 +2124,7 @@ fill_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		if (xform->next != NULL &&
 		    xform->next->type == RTE_CRYPTO_SYM_XFORM_AUTH) {
 			/* Perform decryption followed by auth verify */
-			sess->roc_se_ctx.template_w4.s.opcode_minor =
+			sess->roc_se_ctx->template_w4.s.opcode_minor =
 				ROC_SE_FC_MINOR_OP_HMAC_FIRST;
 		}
 	} else {
@@ -2180,13 +2195,13 @@ fill_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		break;
 	case RTE_CRYPTO_CIPHER_AES_DOCSISBPI:
 		/* Set DOCSIS flag */
-		sess->roc_se_ctx.template_w4.s.opcode_minor |= ROC_SE_FC_MINOR_OP_DOCSIS;
+		sess->roc_se_ctx->template_w4.s.opcode_minor |= ROC_SE_FC_MINOR_OP_DOCSIS;
 		enc_type = ROC_SE_AES_DOCSISBPI;
 		cipher_key_len = 16;
 		break;
 	case RTE_CRYPTO_CIPHER_DES_DOCSISBPI:
 		/* Set DOCSIS flag */
-		sess->roc_se_ctx.template_w4.s.opcode_minor |= ROC_SE_FC_MINOR_OP_DOCSIS;
+		sess->roc_se_ctx->template_w4.s.opcode_minor |= ROC_SE_FC_MINOR_OP_DOCSIS;
 		enc_type = ROC_SE_DES_DOCSISBPI;
 		cipher_key_len = 8;
 		break;
@@ -2207,7 +2222,7 @@ fill_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		return -1;
 	}
 
-	if (zsk_flag && sess->roc_se_ctx.ciph_then_auth) {
+	if (zsk_flag && sess->roc_se_ctx->ciph_then_auth) {
 		struct rte_crypto_auth_xform *a_form;
 		a_form = &xform->next->auth;
 		if (c_form->op != RTE_CRYPTO_CIPHER_OP_DECRYPT &&
@@ -2239,7 +2254,7 @@ fill_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 			return -1;
 		}
 
-	if (unlikely(roc_se_ciph_key_set(&sess->roc_se_ctx, enc_type, c_form->key.data,
+	if (unlikely(roc_se_ciph_key_set(sess->roc_se_ctx, enc_type, c_form->key.data,
 					 c_form->key.length)))
 		return -1;
 
@@ -2254,6 +2269,11 @@ fill_sess_auth(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 	roc_se_auth_type auth_type = 0; /* NULL Auth type */
 	uint8_t is_sm3 = 0;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	if (xform->auth.algo == RTE_CRYPTO_AUTH_AES_GMAC)
 		return fill_sess_gmac(xform, sess);
 
@@ -2261,8 +2281,7 @@ fill_sess_auth(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 	    xform->next->type == RTE_CRYPTO_SYM_XFORM_CIPHER &&
 	    xform->next->cipher.op == RTE_CRYPTO_CIPHER_OP_ENCRYPT) {
 		/* Perform auth followed by encryption */
-		sess->roc_se_ctx.template_w4.s.opcode_minor =
-			ROC_SE_FC_MINOR_OP_HMAC_FIRST;
+		sess->roc_se_ctx->template_w4.s.opcode_minor = ROC_SE_FC_MINOR_OP_HMAC_FIRST;
 	}
 
 	a_form = &xform->auth;
@@ -2377,7 +2396,7 @@ fill_sess_auth(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		return -1;
 	}
 
-	if (zsk_flag && sess->roc_se_ctx.auth_then_ciph) {
+	if (zsk_flag && sess->roc_se_ctx->auth_then_ciph) {
 		struct rte_crypto_cipher_xform *c_form;
 		if (xform->next != NULL) {
 			c_form = &xform->next->cipher;
@@ -2401,7 +2420,7 @@ fill_sess_auth(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		sess->auth_iv_offset = a_form->iv.offset;
 		sess->auth_iv_length = a_form->iv.length;
 	}
-	if (unlikely(roc_se_auth_key_set(&sess->roc_se_ctx, auth_type, a_form->key.data,
+	if (unlikely(roc_se_auth_key_set(sess->roc_se_ctx, auth_type, a_form->key.data,
 					 a_form->key.length, a_form->digest_length)))
 		return -1;
 
@@ -2415,6 +2434,11 @@ fill_sess_gmac(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 	roc_se_cipher_type enc_type = 0; /* NULL Cipher type */
 	roc_se_auth_type auth_type = 0;	 /* NULL Auth type */
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	a_form = &xform->auth;
 
 	if (a_form->op == RTE_CRYPTO_AUTH_OP_GENERATE)
@@ -2454,11 +2478,11 @@ fill_sess_gmac(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		return -1;
 	}
 
-	if (unlikely(roc_se_ciph_key_set(&sess->roc_se_ctx, enc_type, a_form->key.data,
+	if (unlikely(roc_se_ciph_key_set(sess->roc_se_ctx, enc_type, a_form->key.data,
 					 a_form->key.length)))
 		return -1;
 
-	if (unlikely(roc_se_auth_key_set(&sess->roc_se_ctx, auth_type, NULL, 0,
+	if (unlikely(roc_se_auth_key_set(sess->roc_se_ctx, auth_type, NULL, 0,
 					 a_form->digest_length)))
 		return -1;
 
@@ -2586,6 +2610,11 @@ fill_sm_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	uint32_t ci_data_length = sym_op->cipher.data.length;
 	uint32_t ci_data_offset = sym_op->cipher.data.offset;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	fc_params.cipher_iv_len = sess->iv_length;
 	fc_params.auth_iv_len = 0;
 	fc_params.auth_iv_buf = NULL;
@@ -2607,7 +2636,7 @@ fill_sm_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	d_lens = ci_data_length;
 	d_lens = (d_lens << 32);
 
-	fc_params.ctx = &sess->roc_se_ctx;
+	fc_params.ctx = sess->roc_se_ctx;
 
 	if (m_dst == NULL) {
 		fc_params.dst_iov = fc_params.src_iov = (void *)src;
@@ -2685,6 +2714,11 @@ fill_fc_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	uint32_t iv_buf[4];
 	int ret;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	fc_params.cipher_iv_len = sess->iv_length;
 	fc_params.auth_iv_len = 0;
 	fc_params.auth_iv_buf = NULL;
@@ -2762,7 +2796,7 @@ fill_fc_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		uint32_t ci_data_offset = sym_op->cipher.data.offset;
 		uint32_t a_data_length = sym_op->auth.data.length;
 		uint32_t a_data_offset = sym_op->auth.data.offset;
-		struct roc_se_ctx *ctx = &sess->roc_se_ctx;
+		struct roc_se_ctx *ctx = sess->roc_se_ctx;
 
 		const uint8_t op_minor = ctx->template_w4.s.opcode_minor;
 
@@ -2795,7 +2829,7 @@ fill_fc_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 			}
 		}
 	}
-	fc_params.ctx = &sess->roc_se_ctx;
+	fc_params.ctx = sess->roc_se_ctx;
 
 	if (!(sess->auth_first) && unlikely(sess->is_null || sess->cpt_op == ROC_SE_OP_DECODE))
 		inplace = 0;
@@ -2925,13 +2959,18 @@ fill_pdcp_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	uint32_t flags = 0;
 	int ret;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	/* Cipher only */
 
 	fc_params.cipher_iv_len = sess->iv_length;
 	fc_params.auth_iv_len = 0;
 	fc_params.iv_buf = NULL;
 	fc_params.auth_iv_buf = NULL;
-	fc_params.pdcp_iv_offset = sess->roc_se_ctx.pdcp_iv_offset;
+	fc_params.pdcp_iv_offset = sess->roc_se_ctx->pdcp_iv_offset;
 
 	if (likely(sess->iv_length))
 		fc_params.iv_buf = rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset);
@@ -2945,7 +2984,7 @@ fill_pdcp_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	d_offs = (uint64_t)c_data_off << 16;
 	d_lens = (uint64_t)c_data_len << 32;
 
-	fc_params.ctx = &sess->roc_se_ctx;
+	fc_params.ctx = sess->roc_se_ctx;
 
 	if (likely(m_dst == NULL || m_src == m_dst)) {
 		fc_params.dst_iov = fc_params.src_iov = (void *)src;
@@ -3016,11 +3055,16 @@ fill_pdcp_chain_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	void *mdata;
 	int ret;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	fc_params.cipher_iv_len = sess->iv_length;
 	fc_params.auth_iv_len = sess->auth_iv_length;
 	fc_params.iv_buf = NULL;
 	fc_params.auth_iv_buf = NULL;
-	fc_params.pdcp_iv_offset = sess->roc_se_ctx.pdcp_iv_offset;
+	fc_params.pdcp_iv_offset = sess->roc_se_ctx->pdcp_iv_offset;
 
 	m_src = sym_op->m_src;
 	m_dst = sym_op->m_dst;
@@ -3071,7 +3115,7 @@ fill_pdcp_chain_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 					ci_data_length, true);
 	}
 
-	fc_params.ctx = &sess->roc_se_ctx;
+	fc_params.ctx = sess->roc_se_ctx;
 
 	if (likely((m_dst == NULL || m_dst == m_src)) && inplace) {
 		fc_params.dst_iov = fc_params.src_iov = (void *)src;
@@ -3201,6 +3245,11 @@ fill_digest_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	uint8_t iv_buf[16];
 	int ret;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	memset(&params, 0, sizeof(struct roc_se_fc_params));
 
 	m_src = sym_op->m_src;
@@ -3227,7 +3276,7 @@ fill_digest_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		params.auth_iv_len = sess->auth_iv_length;
 		params.auth_iv_buf =
 			rte_crypto_op_ctod_offset(cop, uint8_t *, sess->auth_iv_offset);
-		params.pdcp_iv_offset = sess->roc_se_ctx.pdcp_iv_offset;
+		params.pdcp_iv_offset = sess->roc_se_ctx->pdcp_iv_offset;
 		if (sess->zsk_flag == ROC_SE_K_F9) {
 			uint32_t length_in_bits, num_bytes;
 			uint8_t *src, direction = 0;
@@ -3257,7 +3306,7 @@ fill_digest_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 
 	d_lens = sym_op->auth.data.length;
 
-	params.ctx = &sess->roc_se_ctx;
+	params.ctx = sess->roc_se_ctx;
 
 	if (auth_op == ROC_SE_OP_AUTH_GENERATE) {
 		if (sym_op->auth.digest.data) {
@@ -3497,8 +3546,13 @@ fill_raw_fc_params(struct cnxk_iov *iov, struct cnxk_se_sess *sess, struct cpt_q
 	uint32_t iv_buf[4];
 	int ret;
 
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
+
 	fc_params.cipher_iv_len = sess->iv_length;
-	fc_params.ctx = &sess->roc_se_ctx;
+	fc_params.ctx = sess->roc_se_ctx;
 	fc_params.auth_iv_buf = NULL;
 	fc_params.auth_iv_len = 0;
 	fc_params.mac_buf.size = 0;
@@ -3618,7 +3672,12 @@ fill_raw_digest_params(struct cnxk_iov *iov, struct cnxk_se_sess *sess,
 
 	memset(&fc_params, 0, sizeof(struct roc_se_fc_params));
 	fc_params.cipher_iv_len = sess->iv_length;
-	fc_params.ctx = &sess->roc_se_ctx;
+	fc_params.ctx = sess->roc_se_ctx;
+
+	if (unlikely(sess->roc_se_ctx == NULL)) {
+		plt_dp_err("Session crypto context is NULL");
+		return -EINVAL;
+	}
 
 	mdata = alloc_op_meta(&fc_params.meta_buf, m_info->mlen, m_info->pool, infl_req);
 	if (mdata == NULL) {
-- 
2.25.1

