Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD65C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5813640E39;
	Thu, 20 Aug 2026 07:26:23 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id C78AE40E39
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:20 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d560775ca2so13921655ad.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203580;
 x=1787808380; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m5DsNOoPGK0YQgkZarHzZ+sDTxJFMGyQUhWlndMIv8g=;
 b=Mh+y/qyTb+yP2Z4NNMNVrwm9PbWUBlbP0UYToIjN5X/0EGaYJwhFiUCs0SVLRkt/gM
 FiGC2vgkPlOFuTq3ju+w7r8t0BkkS/gCwxwiDj5XQvj58F9mXPGVtulVeLte1rES9FTs
 VOJVKG4UaUzgFB2eN3kiia8hSH59dkOPnXwfrouK0tXDpKscCW8Dz/KTgmqiV1SEcvtP
 hM969C/kRvle0CSWwonKCh40tVkeafvXwJ2ayMpz2MIt/I21ihjD+u2/2GHKXIhLu0GG
 i5yULVVQbHvjAG/WojXVfylS4uVSGsyoSbI8/BMWT+GffASu9mM7VyuZEADaLIXxiAGo
 TLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203580; x=1787808380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m5DsNOoPGK0YQgkZarHzZ+sDTxJFMGyQUhWlndMIv8g=;
 b=ep9avqY6v5GjsIvjYN82CWcz6lE74D2VkP6AqkMeW0o4BkTCsDTf5N9bFrvv5o6K9T
 YqNQfMnFal0KPqrXxgCHDlHgNpLCsrakgLY7ac3prSwDjnmbfJB//Iz2UcOXYWnA3LHA
 Cqq6fcYmoJoTm4TEHds9mOZboQ0BmPikrqABcvIW+b1+VVHrb8yVVcE4AikS2uevibwZ
 gVwm2VvHmQx6lUtzPoGi5wjX3i9Q2vN5xPrUGNjw12ujvsEtvsuEVWA6iWIPIr1GiQw5
 2SxZjc42ZIGYvqVEDX2t7dz02pWpF3drKFYvBPDoA24IS7Avw/W634Ef8ItO43XYKLiU
 cPgg==
X-Gm-Message-State: AOJu0YxJoo2DzCwBSBPp/LsbwaV/YmB9GTdzsxJhgoFhIpkGUVHBl46E
 TBKd0HFlbJ3Rcz1u9Io8nDNm+YFdsrP55WsXsptDAXYswcLJb58SUwBLU+1N3tPdeAgUsY2sC/V
 e+lAP
X-Gm-Gg: AR+sD12KUZ5mjLM/YTT7QTnZhaYaw3d+K2Bmh2xQhuSoXiApnKNv0/xJKsABO7PTeb6
 xH111fMrXC83WRwFtr3xKgsZvm7nikAVDovgDJNXPDHFhVBLOU0rRoEPwMJNFlsh+IL2mz+vJhE
 JXMtf6bk1+NcCeUP/k9kOWOIN68oOC5KlM65BfK8Eu1KFcIDnxLwCTL4wA6CCsmajNCIdsMMAvH
 MJE9cuT7moPy2eLv8hBlABNcp9VMMLg9Opat54leOZ//CaQ8F+1Et+UYNgN2bER06pCVqU73HIw
 azPsdhJe8gu12rYD17s/ieYWiLFlr3+m+fjay1rr3pWDOwlIiaWEG5Linubn6qiDpSLEK0UlfKi
 QtTdi19f4P7ciF/0hMX3U/t17/b898pI27rWYb6/kpwOO8vpJZ1TxY9j0XZxkgZsRrNYgxBfDS0
 UmiuiJr4ZHb5cgF5neCE00WQhCG1t0+pAxo07StOc3Qu9Whp/UGPGfalxt7sKV0nOU+tNbRCAdD
 DbnMTMSBgs0seT/bS1C0aIbWqv1pZU/jmDTvg==
X-Received: by 2002:a17:902:e94c:b0:2d5:d9c2:bbe0 with SMTP id
 d9443c01a7336-2d5fd621427mr188086035ad.4.1787203579564; 
 Wed, 19 Aug 2026 22:26:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Kai Ji <kai.ji@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Subject: [PATCH 54/61] drivers/*/qat: use memcpy for fixed size data
Date: Wed, 19 Aug 2026 22:12:44 -0700
Message-ID: <20260820052251.1453273-55-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

