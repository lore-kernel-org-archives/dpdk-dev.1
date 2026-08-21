Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE94BC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 596BA40EA5;
	Fri, 21 Aug 2026 21:31:36 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id BD9D8410D5
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:33 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so1844078b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340693;
 x=1787945493; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m5DsNOoPGK0YQgkZarHzZ+sDTxJFMGyQUhWlndMIv8g=;
 b=z6LJxO3RQJZ6/rFVE9QIxkCk0hOCEh9r0B4dSp8NPdtvnjlWfyOnRWTnxuPdQNbXaq
 q4N4v7XOlVYAdV7X46rMdaBQbofE9UV9Tx+nag76FWMdCah+tAuuKTbsYgJeW83e7JWg
 2EhHD0yfIh71eBOadv2bSiLVGWlwMGFShLJrlBt9xF5LCmkxNSPUYJYHFjMt20m6XR/T
 0T9CTdgP2hJjktb3U+Nn8CXtBEUr8SJYceyWffhdSqhI/pV6gPhGyOY42GsuvTe0XNQq
 F0qSg+TV/dfnFM9P5IBL3CBYjTO/Z6sVO1ow3E3SOnWzL8Icd1J5baO2RHjm1rShg11l
 VJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340693; x=1787945493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m5DsNOoPGK0YQgkZarHzZ+sDTxJFMGyQUhWlndMIv8g=;
 b=KJYzP4OVcNQp0xhINrUbKzy4l+f2cLdPA/pETDnqds/JrD1JM507e7D2bBgSZQa/C5
 WFfO1u1ZZ92h5IH2Gjf0mCq9zPNJaVbgbfagrm1aorVq1S7DUaDzHI2wLx55kz9GmpYI
 tU5pMx0mOItLG7LwFkXifcQrDu01kTQZaDBhD1mvsNgmGorqoP63y9AavfZVCUrE6bPN
 uDjwqqTzaWnV3fVo+/Lh1kKKmq8gRFNt6mN24Kv0uvXhigm85cyMFh87UcYvpjBAKycC
 4rHhN+4TWFWk+oRa+vk2UVEtMk1m2xshjJewcQFiZP0q1ihaDPJ4RLdnZsqtUC93faoq
 E3Cg==
X-Gm-Message-State: AFuF++nAI/xRBlVKn32BYlObERvMpwGPR/oRpbG7OAkkB3EW6ZTl1HaI
 hqqHUG5u3iQsx0s2mjpb9te0PyZfttJFDAKUoxCZ6llmNts505mNnZKWkIzn1+3XUOkaViRVkFH
 s0fcQ2lo=
X-Gm-Gg: AR+sD12OvQZyXmNfDtEIbtMbU4bibn35bfh1GOW3Uf6oERryVdZlNkf+PYcZk8T5aPk
 sgm9Ro0c43TFBIdK4790nenGuauZDRW06dJ3hyxQlTOD3u+7Xtvta+mJeQZPIHbC3Jk0y+5S/bb
 V6UGG42h1k0MtaZ3CKeOZQ53dOO6YHAMXQwmtovZiZwExrboau9MbrMiRvlI8BQ/yets2ztb0/L
 o7pl0R7OY9R02sKVsZgMEnIb8VHRTXlNueBi9GweWbpZ+X7A6IW8bhkvDiljrgFEZ6yeTLO6sl3
 IjOXxLjbHJc1CUA9RzIwj01s2E1BIp2eS5zFg0kvI6GxOErFqUa/dXNGsIXStsTSj5e7Cprl9HG
 zAYHAOsxf3KZArn1E0YXzP5/4tp79qJ9ZUMjepwWKhDxuKdE3mBxe1v6MSNC6XEsNPFSgxC9gpu
 2vD1MnB0tht3KjvO2YhCSn/cU0LMhc4oUB/xQMmOUxTnfKq/+jwNOdWRZH0SLAm9+3Za4GrlbAM
 Jl6oR3kU05EYVZnqkJ3qR/VfAc=
X-Received: by 2002:a05:6a21:482:b0:3bf:9bd9:cf60 with SMTP id
 adf61e73a8af0-3cd14d30051mr20249719637.6.1787340691518; 
 Fri, 21 Aug 2026 12:31:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Kai Ji <kai.ji@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Subject: [PATCH v2 61/68] drivers/*/qat: use memcpy for fixed size data
Date: Fri, 21 Aug 2026 12:24:56 -0700
Message-ID: <20260821192646.146382-62-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/qat/qat_qp.c          | 10 ++++-----
 drivers/compress/qat/qat_comp.c      |  8 +++----
 drivers/crypto/qat/qat_sym_session.c | 33 ++++++++++++++--------------
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/common/qat/qat_qp.c b/drivers/common/qat/qat_qp.c
index fe28cb160d..6ea4548bba 100644
--- a/drivers/common/qat/qat_qp.c
+++ b/drivers/common/qat/qat_qp.c
@@ -871,9 +871,8 @@ qat_cq_get_fw_cipher_crc_cap(struct qat_qp *qp)
 		return -EINVAL;
 	}
 
-	rte_memcpy(src_data_addr,
-			cipher_crc_cap_check_plaintext,
-			sizeof(cipher_crc_cap_check_plaintext));
+	memcpy(src_data_addr, cipher_crc_cap_check_plaintext,
+	       sizeof(cipher_crc_cap_check_plaintext));
 
 	phy_src_addr = rte_mem_virt2iova(src_data_addr);
 	if (phy_src_addr == 0 || phy_src_addr == RTE_BAD_IOVA) {
@@ -892,9 +891,8 @@ qat_cq_get_fw_cipher_crc_cap(struct qat_qp *qp)
 	auth_param = (void *)((uint8_t *)cipher_param +
 			ICP_QAT_FW_HASH_REQUEST_PARAMETERS_OFFSET);
 
-	rte_memcpy(cipher_param->u.cipher_IV_array,
-			cipher_crc_cap_check_iv,
-			sizeof(cipher_crc_cap_check_iv));
+	memcpy(cipher_param->u.cipher_IV_array, cipher_crc_cap_check_iv,
+	       sizeof(cipher_crc_cap_check_iv));
 
 	cipher_param->cipher_offset = cipher_crc_cap_check_cipher_offset;
 	cipher_param->cipher_length =
diff --git a/drivers/compress/qat/qat_comp.c b/drivers/compress/qat/qat_comp.c
index 559948a46a..5bcbefe395 100644
--- a/drivers/compress/qat/qat_comp.c
+++ b/drivers/compress/qat/qat_comp.c
@@ -375,7 +375,7 @@ qat_comp_build_multiple_requests(void *in_op, struct qat_qp *qp,
 	QAT_DP_LOG(DEBUG, "op %p, parent_cookie %p", op, parent_cookie);
 
 	/* copy original op to the local variable for restoring later */
-	rte_memcpy(&op_backup, op, sizeof(op_backup));
+	memcpy(&op_backup, op, sizeof(op_backup));
 
 	parent_cookie->nb_child_responses = 0;
 	parent_cookie->nb_children = 0;
@@ -401,7 +401,7 @@ qat_comp_build_multiple_requests(void *in_op, struct qat_qp *qp,
 	}
 
 	/* prepare local dst mbuf */
-	rte_memcpy(&dst_mbuf, op->m_dst, sizeof(dst_mbuf));
+	memcpy(&dst_mbuf, op->m_dst, sizeof(dst_mbuf));
 	rte_pktmbuf_reset(&dst_mbuf);
 	dst_mbuf.buf_len = dst_data_size;
 	dst_mbuf.data_len = dst_data_size;
@@ -457,7 +457,7 @@ qat_comp_build_multiple_requests(void *in_op, struct qat_qp *qp,
 		if (ret < 0) {
 			QAT_DP_LOG(WARNING, "Failed to build child descriptor");
 			/* restore op and clear cookie */
-			rte_memcpy(op, &op_backup, sizeof(op_backup));
+			memcpy(op, &op_backup, sizeof(op_backup));
 			parent_cookie->split_op = 0;
 			parent_cookie->nb_children = 0;
 			return ret;
@@ -468,7 +468,7 @@ qat_comp_build_multiple_requests(void *in_op, struct qat_qp *qp,
 	}
 
 	/* restore backed up original op */
-	rte_memcpy(op, &op_backup, sizeof(op_backup));
+	memcpy(op, &op_backup, sizeof(op_backup));
 
 	if (nb_descr != num_descriptors_built)
 		QAT_DP_LOG(ERR, "split op. expected %d, built %d",
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index d89c20cad6..1197537545 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -1585,8 +1585,8 @@ static int qat_sym_do_precomputes_ipsec_mb(enum icp_qat_hw_auth_algo hash_alg,
 
 		uint8_t *input = in;
 		uint8_t *out = p_state_buf;
-		rte_memcpy(input, qat_aes_xcbc_key_seed,
-				ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ);
+		memcpy(input, qat_aes_xcbc_key_seed,
+		       ICP_QAT_HW_AES_XCBC_MAC_STATE2_SZ);
 		for (i = 0; i < HASH_XCBC_PRECOMP_KEY_NUM; i++) {
 			if (aes_ipsecmb_job(input, out, m, auth_key, auth_keylen)) {
 				memset(input -
@@ -2101,8 +2101,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 	cdesc->cd_cur_ptr += sizeof(struct icp_qat_hw_auth_setup);
 	switch (cdesc->qat_hash_alg) {
 	case ICP_QAT_HW_AUTH_ALGO_SM3:
-		rte_memcpy(cdesc->cd_cur_ptr, sm3InitialState,
-				sizeof(sm3InitialState));
+		memcpy(cdesc->cd_cur_ptr, sm3InitialState,
+		       sizeof(sm3InitialState));
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
 		state2_size = ICP_QAT_HW_SM3_STATE2_SZ;
@@ -2113,9 +2113,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		hash_2->auth_config.config =
 			ICP_QAT_HW_AUTH_CONFIG_BUILD(ICP_QAT_HW_AUTH_MODE2,
 				cdesc->qat_hash_alg, digestsize);
-		rte_memcpy(cdesc->cd_cur_ptr + state1_size + state2_size +
-			sizeof(*hash_2), sm3InitialState,
-			sizeof(sm3InitialState));
+		memcpy(cdesc->cd_cur_ptr + state1_size + state2_size + sizeof(*hash_2),
+		       sm3InitialState, sizeof(sm3InitialState));
 		hash_cd_ctrl->inner_state1_sz = state1_size;
 		hash_cd_ctrl->inner_state2_sz  = state2_size;
 		hash_cd_ctrl->inner_state2_offset =
@@ -2154,8 +2153,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 	case ICP_QAT_HW_AUTH_ALGO_SHA1:
 		if (cdesc->auth_mode == ICP_QAT_HW_AUTH_MODE0) {
 			/* Plain SHA-1 */
-			rte_memcpy(cdesc->cd_cur_ptr, sha1InitialState,
-					sizeof(sha1InitialState));
+			memcpy(cdesc->cd_cur_ptr, sha1InitialState,
+			       sizeof(sha1InitialState));
 			state1_size = qat_hash_get_state1_size(
 					cdesc->qat_hash_alg);
 			break;
@@ -2174,8 +2173,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 	case ICP_QAT_HW_AUTH_ALGO_SHA224:
 		if (cdesc->auth_mode == ICP_QAT_HW_AUTH_MODE0) {
 			/* Plain SHA-224 */
-			rte_memcpy(cdesc->cd_cur_ptr, sha224InitialState,
-					sizeof(sha224InitialState));
+			memcpy(cdesc->cd_cur_ptr, sha224InitialState,
+			       sizeof(sha224InitialState));
 			state1_size = qat_hash_get_state1_size(
 					cdesc->qat_hash_alg);
 			break;
@@ -2193,8 +2192,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 	case ICP_QAT_HW_AUTH_ALGO_SHA256:
 		if (cdesc->auth_mode == ICP_QAT_HW_AUTH_MODE0) {
 			/* Plain SHA-256 */
-			rte_memcpy(cdesc->cd_cur_ptr, sha256InitialState,
-					sizeof(sha256InitialState));
+			memcpy(cdesc->cd_cur_ptr, sha256InitialState,
+			       sizeof(sha256InitialState));
 			state1_size = qat_hash_get_state1_size(
 					cdesc->qat_hash_alg);
 			break;
@@ -2212,8 +2211,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 	case ICP_QAT_HW_AUTH_ALGO_SHA384:
 		if (cdesc->auth_mode == ICP_QAT_HW_AUTH_MODE0) {
 			/* Plain SHA-384 */
-			rte_memcpy(cdesc->cd_cur_ptr, sha384InitialState,
-					sizeof(sha384InitialState));
+			memcpy(cdesc->cd_cur_ptr, sha384InitialState,
+			       sizeof(sha384InitialState));
 			state1_size = qat_hash_get_state1_size(
 					cdesc->qat_hash_alg);
 			break;
@@ -2231,8 +2230,8 @@ static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 	case ICP_QAT_HW_AUTH_ALGO_SHA512:
 		if (cdesc->auth_mode == ICP_QAT_HW_AUTH_MODE0) {
 			/* Plain SHA-512 */
-			rte_memcpy(cdesc->cd_cur_ptr, sha512InitialState,
-					sizeof(sha512InitialState));
+			memcpy(cdesc->cd_cur_ptr, sha512InitialState,
+			       sizeof(sha512InitialState));
 			state1_size = qat_hash_get_state1_size(
 					cdesc->qat_hash_alg);
 			break;
-- 
2.53.0

