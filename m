Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A183FF532D0
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 03:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0DB740649;
	Tue, 24 Mar 2026 04:48:27 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EFA09402DC
 for <dev@dpdk.org>; Tue, 24 Mar 2026 04:48:25 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHXrkq526857 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:48:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 lP6LNR3k8YQdk/0q6cgsZrOAdQ3Q1kCV7Hhy68cmJw=; b=b5JwIGWl0IYs8T6zt
 6wmwejHbjATfwy0Nq3v4wXirvrpkVida2FcYK+mRJvvEX0E/JJ+tmoTehh3rwsxF
 Q4k9mVpKSJdkwlsKImdAvFTNLkAhI+LFBAa50sJOrLwNJ5D58QWEutOqewieIIVB
 sgQGtiVCAYPVZFMCPHB4xIO1axaAuwKVF43A1raWHSqTwQPvLH4ktmBnMG4jgDQD
 Mwbqt5c1X6dw41Up+YOqTU38qCHde1N9pLvzt3LHfTxnJH50QtF4LKEzBYTdd7t+
 V6euTbl4c4J+QxBlmtu9jbkv6scAb7dyTCjwiTNl4duUJOpqCHfGEj63uac62Pq1
 fWzfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d1rpjnd2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:48:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Mar 2026 20:48:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 23 Mar 2026 20:48:24 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.42])
 by maili.marvell.com (Postfix) with ESMTP id BFA055B6922;
 Mon, 23 Mar 2026 20:48:22 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>
Subject: [PATCH 1/2] crypto/cnxk: add ZUC256 v2 support for cn20k
Date: Tue, 24 Mar 2026 09:18:18 +0530
Message-ID: <20260324034819.1010198-2-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324034819.1010198-1-nkaithakadan@marvell.com>
References: <20260324034819.1010198-1-nkaithakadan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5qSVVQ_X2yN9FIlyybKn0_HzlZq75NZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAyOSBTYWx0ZWRfX6cwpLElLBaaZ
 1XQvxRtsGTVbSY7ObCL6NZRTbORgHHYEkS5b8otY2qRUgmHi+hP2VnDS3qodJoyLgnhdXOpSkb2
 gXOqUKlj2tgLNRMb5eK05y9Y8oSdStOS2xDCMwmocZ398VHCxIw7Qhv+O+aaUnR3tBQyp3Lq136
 YkCxIN0u5ymnW0Sivgyi8fzH5D0iamp8uZRp7XBm/wSawcX+o54QZ/X1Xldgtiv/2rG4UI54HgX
 GbBRbxDtkSMBxYeMfZCsAphSr/bJ0+lOVlmGfXhSfecOJopVkI1N6XH1oRJ4q3KjqrQrZwN3tEM
 UjvNfzX+w89wDX3fyMJs8HR7ISNhF9spGLFfn++qhAlwIBskGYgzMk4B/Y6H9j7UxxJSGR2xmYl
 2AQLRMn45/Xh/kYTQY1+ShWUieNzn9nxB/4PtNUUEiYZcG4A5X7l/OstBDXTpPWutHkDkBQZEBx
 i0NHvgGQKHlOC4oDGvQ==
X-Authority-Analysis: v=2.4 cv=Ed7FgfmC c=1 sm=1 tr=0 ts=69c20988 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=XHYWXplByCRcvef3p8IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5qSVVQ_X2yN9FIlyybKn0_HzlZq75NZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
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

From: Tejasree Kondoj <ktejasree@marvell.com>

Adding ZUC256 v2 cipher only support in
CN20K PMD.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/roc_se.c                      | 14 +++++++++++---
 drivers/common/cnxk/roc_se.h                      |  2 ++
 drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c | 15 +++++++++------
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c          | 10 ++++++++--
 drivers/crypto/cnxk/cnxk_se.h                     |  7 +++++--
 5 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/common/cnxk/roc_se.c b/drivers/common/cnxk/roc_se.c
index f71832ff3a..bdb42567c7 100644
--- a/drivers/common/cnxk/roc_se.c
+++ b/drivers/common/cnxk/roc_se.c
@@ -25,6 +25,9 @@ static uint8_t zuc_key256_mac16[16] = {0x23, 0x2f, 0x25, 0x2a, 0x6d, 0x40,
 				       0x40, 0x40, 0x40, 0x40, 0x40, 0x40,
 				       0x40, 0x52, 0x10, 0x30};
 
+static uint8_t zuc_key256_v2[16] = {0x64, 0x43, 0x7b, 0x2a, 0x11, 0x05, 0x51, 0x42,
+				    0x1a, 0x31, 0x18, 0x66, 0x14, 0x2e, 0x01, 0x5c};
+
 static inline void
 cpt_snow3g_key_gen(const uint8_t *ck, uint32_t *keyx)
 {
@@ -93,7 +96,8 @@ cpt_ciph_type_set(roc_se_cipher_type type, struct roc_se_ctx *ctx, uint16_t key_
 			 * ZUC 256 is not supported with older microcode
 			 * where pdcp_iv_offset is 16
 			 */
-			if (chained_op || (ctx->pdcp_iv_offset == 16)) {
+			if ((chained_op ||
+			     (!roc_model_is_cn20k() && (ctx->pdcp_iv_offset == 16)))) {
 				plt_err("ZUC 256 is not supported with chained operations");
 				return -1;
 			}
@@ -318,7 +322,8 @@ roc_se_auth_key_set(struct roc_se_ctx *se_ctx, roc_se_auth_type type, const uint
 				 * ZUC 256 is not supported with older microcode
 				 * where pdcp_iv_offset is 16
 				 */
-				if (chained_op || (se_ctx->pdcp_iv_offset == 16)) {
+				if ((chained_op ||
+				     (!roc_model_is_cn20k() && (se_ctx->pdcp_iv_offset == 16)))) {
 					plt_err("ZUC 256 is not supported with chained operations");
 					return -1;
 				}
@@ -552,7 +557,10 @@ roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type, const ui
 		memcpy(pctx->st.ci_key, key, key_len);
 		if (key_len == 32) {
 			roc_se_zuc_bytes_swap(pctx->st.ci_key, key_len);
-			memcpy(pctx->st.ci_zuc_const, zuc_key256, 16);
+			if (roc_model_is_cn20k())
+				memcpy(pctx->st.ci_zuc_const, zuc_key256_v2, 16);
+			else
+				memcpy(pctx->st.ci_zuc_const, zuc_key256, 16);
 		} else
 			memcpy(pctx->st.ci_zuc_const, zuc_key128, 32);
 		se_ctx->pdcp_ci_alg = ROC_SE_PDCP_ALG_TYPE_ZUC;
diff --git a/drivers/common/cnxk/roc_se.h b/drivers/common/cnxk/roc_se.h
index 9afcda8ba4..03a6eabfd3 100644
--- a/drivers/common/cnxk/roc_se.h
+++ b/drivers/common/cnxk/roc_se.h
@@ -355,6 +355,7 @@ struct roc_se_ctx {
 	uint64_t eia2 : 1;
 	/* auth_iv_offset passed to PDCP_CHAIN opcode based on FVC bit */
 	uint8_t pdcp_iv_offset;
+	uint8_t pdcp_iv_len;
 	union cpt_inst_w4 template_w4;
 	uint8_t *auth_key;
 } __plt_aligned(ROC_ALIGN);
@@ -374,6 +375,7 @@ struct roc_se_fc_params {
 	uint8_t cipher_iv_len;
 	uint8_t auth_iv_len;
 	uint8_t pdcp_iv_offset;
+	uint8_t pdcp_iv_len;
 
 	struct roc_se_buf_ptr aad_buf;
 	struct roc_se_buf_ptr mac_buf;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index d2747878d3..5c1542909e 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -1908,7 +1908,7 @@ cpt_caps_add(struct rte_cryptodev_capabilities cnxk_caps[], int *cur_pos,
 }
 
 static void
-cn10k_crypto_caps_update(struct rte_cryptodev_capabilities cnxk_caps[])
+cn10k_20k_crypto_caps_update(struct rte_cryptodev_capabilities cnxk_caps[])
 {
 
 	struct rte_cryptodev_capabilities *caps;
@@ -1921,7 +1921,10 @@ cn10k_crypto_caps_update(struct rte_cryptodev_capabilities cnxk_caps[])
 
 			caps->sym.cipher.key_size.max = 32;
 			caps->sym.cipher.key_size.increment = 16;
-			caps->sym.cipher.iv_size.max = 25;
+			if (roc_model_is_cn20k())
+				caps->sym.cipher.iv_size.max = 16;
+			else
+				caps->sym.cipher.iv_size.max = 25;
 			caps->sym.cipher.iv_size.increment = 1;
 		}
 
@@ -1946,8 +1949,8 @@ cn9k_crypto_caps_add(struct rte_cryptodev_capabilities cnxk_caps[], int *cur_pos
 }
 
 static void
-cn10k_crypto_caps_add(struct rte_cryptodev_capabilities cnxk_caps[],
-		     union cpt_eng_caps *hw_caps, int *cur_pos)
+cn10k_20k_crypto_caps_add(struct rte_cryptodev_capabilities cnxk_caps[],
+			  union cpt_eng_caps *hw_caps, int *cur_pos)
 {
 	if (hw_caps[CPT_ENG_TYPE_SE].sg_ver2) {
 		CPT_CAPS_ADD(cnxk_caps, cur_pos, hw_caps, sm3);
@@ -1980,13 +1983,13 @@ crypto_caps_populate(struct rte_cryptodev_capabilities cnxk_caps[],
 		cn9k_crypto_caps_add(cnxk_caps, &cur_pos);
 
 	if (roc_model_is_cn10k() || roc_model_is_cn20k())
-		cn10k_crypto_caps_add(cnxk_caps, hw_caps, &cur_pos);
+		cn10k_20k_crypto_caps_add(cnxk_caps, hw_caps, &cur_pos);
 
 	cpt_caps_add(cnxk_caps, &cur_pos, caps_null, RTE_DIM(caps_null));
 	cpt_caps_add(cnxk_caps, &cur_pos, caps_end, RTE_DIM(caps_end));
 
 	if (roc_model_is_cn10k() || roc_model_is_cn20k())
-		cn10k_crypto_caps_update(cnxk_caps);
+		cn10k_20k_crypto_caps_update(cnxk_caps);
 }
 
 const struct rte_cryptodev_capabilities *
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 370f311dd3..b431b78005 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -632,10 +632,16 @@ cnxk_sess_fill(struct roc_cpt *roc_cpt, struct rte_crypto_sym_xform *xform,
 	struct rte_crypto_sym_xform *a_xfrm = NULL;
 	bool ciph_then_auth = false;
 
-	if (roc_cpt->hw_caps[CPT_ENG_TYPE_SE].pdcp_chain_zuc256)
+	if (roc_model_is_cn20k()) {
+		sess->roc_se_ctx->pdcp_iv_len = 40;
+		sess->roc_se_ctx->pdcp_iv_offset = 16;
+	} else if (roc_cpt->hw_caps[CPT_ENG_TYPE_SE].pdcp_chain_zuc256) {
 		sess->roc_se_ctx->pdcp_iv_offset = 24;
-	else
+		sess->roc_se_ctx->pdcp_iv_len = 48;
+	} else {
 		sess->roc_se_ctx->pdcp_iv_offset = 16;
+		sess->roc_se_ctx->pdcp_iv_len = 32;
+	}
 
 	if (xform == NULL)
 		return -EINVAL;
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 7a0624ca28..db25fd90d8 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -1537,7 +1537,7 @@ cpt_pdcp_chain_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 	const uint8_t *auth_iv = NULL, *cipher_iv = NULL;
 	uint8_t pdcp_iv_off = params->pdcp_iv_offset;
 	uint32_t off_ctrl_len = ROC_SE_OFF_CTRL_LEN;
-	const int iv_len = pdcp_iv_off * 2;
+	const int iv_len = params->pdcp_iv_len;
 	uint8_t pdcp_ci_alg, pdcp_auth_alg;
 	union cpt_inst_w4 cpt_inst_w4;
 	struct roc_se_ctx *se_ctx;
@@ -1667,9 +1667,9 @@ cpt_pdcp_alg_prep(uint32_t req_flags, uint64_t d_offs, uint64_t d_lens,
 	 * So iv_len reserved is 32B for cipher and auth IVs with old microcode
 	 * and 48B with new microcode.
 	 */
-	const int iv_len = params->pdcp_iv_offset * 2;
 	uint32_t off_ctrl_len = ROC_SE_OFF_CTRL_LEN;
 	struct roc_se_ctx *se_ctx = params->ctx;
+	const int iv_len = params->pdcp_iv_len;
 	uint32_t encr_data_len, auth_data_len;
 	const int flags = se_ctx->zsk_flags;
 	uint32_t encr_offset, auth_offset;
@@ -3039,6 +3039,7 @@ fill_pdcp_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	fc_params.iv_buf = NULL;
 	fc_params.auth_iv_buf = NULL;
 	fc_params.pdcp_iv_offset = sess->roc_se_ctx->pdcp_iv_offset;
+	fc_params.pdcp_iv_len = sess->roc_se_ctx->pdcp_iv_len;
 
 	if (likely(sess->iv_length))
 		fc_params.iv_buf = rte_crypto_op_ctod_offset(cop, uint8_t *, sess->iv_offset);
@@ -3134,6 +3135,7 @@ fill_pdcp_chain_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 	fc_params.iv_buf = NULL;
 	fc_params.auth_iv_buf = NULL;
 	fc_params.pdcp_iv_offset = sess->roc_se_ctx->pdcp_iv_offset;
+	fc_params.pdcp_iv_len = sess->roc_se_ctx->pdcp_iv_len;
 
 	m_src = sym_op->m_src;
 	m_dst = sym_op->m_dst;
@@ -3347,6 +3349,7 @@ fill_digest_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		params.auth_iv_buf =
 			rte_crypto_op_ctod_offset(cop, uint8_t *, sess->auth_iv_offset);
 		params.pdcp_iv_offset = sess->roc_se_ctx->pdcp_iv_offset;
+		params.pdcp_iv_len = sess->roc_se_ctx->pdcp_iv_len;
 		if (sess->zsk_flag == ROC_SE_K_F9) {
 			uint32_t length_in_bits, num_bytes;
 			uint8_t *src, direction = 0;
-- 
2.34.1

