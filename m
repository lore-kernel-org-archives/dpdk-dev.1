Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B9FC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:54:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 170CF40E45;
	Fri, 23 May 2025 15:52:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CC96640E26
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:35 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8ST006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 PSQQAyr4uP1PtpBhp28uY3Y4iVT6l517fMRkWKdnV0=; b=kKc9r0myfMQGX0WOI
 QG6oCA7c6OplZhKZbhTMFn0o19elWGBvr9dRojp79JLzYnlItEhhXsgPC8tpeCQz
 MEjonSoijCnWoMpUwGttpWQOxXvLKzVdnY8lfXp2M2mozH74zhI8cF+c9nuGghlc
 h3WH1p3HArwlIQ4Bh0RjHijnggPS7KjR/56+DZyro6aQ/xaE6uFtcGcpiaD0vZA9
 uvpvNn2QNp1fRbe25AeKVylQvz+EHJ8RsvCRdM0PDq/SyS76fthSgy8VYZXYc8hW
 X85tN46KPpFLKl34wGox0ssG/VgcnCFEsqzedqywmY89ZqwD5ibTnYeh2McO2xPL
 dcmYQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-17
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:33 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 0AE4E3F7041;
 Fri, 23 May 2025 06:52:30 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 24/40] crypto/cnxk: add tls read session creation
Date: Fri, 23 May 2025 19:20:55 +0530
Message-ID: <20250523135111.2178408-25-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX938ogJFtgq/G
 6yChRW1hhLzy22+S5LcmgWWhaY/h35KvLMus0sQyj1APXz6gsLY5ujPyHt1WHhHiAbg5X81nWtA
 26cEnn/Oin7XaVX9Ywr8og3437RC13OerwStohA4bmCLtOu8YI3VHr2BpNGw+QkPe1VgInIgU5S
 VhV953V+w9gslnZ/v9WhZmMRqRpNjmb0ct/+dUbu2B6duyWcqctoPL19JPfZ330LF+Lq3KsA/ri
 T7V/MOY2ryNMGvy8CFgFoeZqNul/MuckerABGn1053FOr2Fp7J1t/TuP9XlzZjwYeQWgFj3HlSZ
 MLGKbydYZBJq+wnrC6JfVwkCZ97M2ilElsrB7OKvzXQm5yupesgcuKODoRRzYoZS3Yh1srp2iAl
 lGEIAgG0VlVmfEAcV8qsk/Ow+uG7xcEwmHMhxmKSR/Mix3WJNb0iRWkhlDFD2iZ3ftpaSeHb
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307da2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=fkTePHzwXqYjciSdbjQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 3YZpc4bfUmJwfk6VVIsBqzG-IoN5vjwi
X-Proofpoint-ORIG-GUID: 3YZpc4bfUmJwfk6VVIsBqzG-IoN5vjwi
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

Add session creation for tls read for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_tls.c | 329 +++++++++++++++++++++++++++++++-
 1 file changed, 327 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_tls.c b/drivers/crypto/cnxk/cn20k_tls.c
index 40fe48ae69..4a68edf731 100644
--- a/drivers/crypto/cnxk/cn20k_tls.c
+++ b/drivers/crypto/cnxk/cn20k_tls.c
@@ -461,6 +461,330 @@ cn20k_tls_read_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	return ret;
 }
 
+static int
+tls_write_rlens_get(struct rte_security_tls_record_xform *tls_xfrm,
+		    struct rte_crypto_sym_xform *crypto_xfrm)
+{
+	enum rte_crypto_cipher_algorithm c_algo = RTE_CRYPTO_CIPHER_NULL;
+	enum rte_crypto_auth_algorithm a_algo = RTE_CRYPTO_AUTH_NULL;
+	uint8_t roundup_byte, tls_hdr_len;
+	uint8_t mac_len, iv_len;
+
+	switch (tls_xfrm->ver) {
+	case RTE_SECURITY_VERSION_TLS_1_2:
+	case RTE_SECURITY_VERSION_TLS_1_3:
+		tls_hdr_len = 5;
+		break;
+	case RTE_SECURITY_VERSION_DTLS_1_2:
+		tls_hdr_len = 13;
+		break;
+	default:
+		tls_hdr_len = 0;
+		break;
+	}
+
+	/* Get Cipher and Auth algo */
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD)
+		return tls_hdr_len + ROC_CPT_AES_GCM_IV_LEN + ROC_CPT_AES_GCM_MAC_LEN;
+
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+		c_algo = crypto_xfrm->cipher.algo;
+		if (crypto_xfrm->next)
+			a_algo = crypto_xfrm->next->auth.algo;
+	} else {
+		a_algo = crypto_xfrm->auth.algo;
+		if (crypto_xfrm->next)
+			c_algo = crypto_xfrm->next->cipher.algo;
+	}
+
+	switch (c_algo) {
+	case RTE_CRYPTO_CIPHER_NULL:
+		roundup_byte = 4;
+		iv_len = 0;
+		break;
+	case RTE_CRYPTO_CIPHER_3DES_CBC:
+		roundup_byte = ROC_CPT_DES_BLOCK_LENGTH;
+		iv_len = ROC_CPT_DES_IV_LEN;
+		break;
+	case RTE_CRYPTO_CIPHER_AES_CBC:
+		roundup_byte = ROC_CPT_AES_BLOCK_LENGTH;
+		iv_len = ROC_CPT_AES_CBC_IV_LEN;
+		break;
+	default:
+		roundup_byte = 0;
+		iv_len = 0;
+		break;
+	}
+
+	switch (a_algo) {
+	case RTE_CRYPTO_AUTH_NULL:
+		mac_len = 0;
+		break;
+	case RTE_CRYPTO_AUTH_MD5_HMAC:
+		mac_len = 16;
+		break;
+	case RTE_CRYPTO_AUTH_SHA1_HMAC:
+		mac_len = 20;
+		break;
+	case RTE_CRYPTO_AUTH_SHA256_HMAC:
+		mac_len = 32;
+		break;
+	case RTE_CRYPTO_AUTH_SHA384_HMAC:
+		mac_len = 32;
+		break;
+	default:
+		mac_len = 0;
+		break;
+	}
+
+	return tls_hdr_len + iv_len + mac_len + roundup_byte;
+}
+
+static int
+tls_write_sa_fill(struct roc_ie_ow_tls_write_sa *write_sa,
+		  struct rte_security_tls_record_xform *tls_xfrm,
+		  struct rte_crypto_sym_xform *crypto_xfrm)
+{
+	enum rte_security_tls_version tls_ver = tls_xfrm->ver;
+	struct rte_crypto_sym_xform *auth_xfrm, *cipher_xfrm;
+	const uint8_t *key = NULL;
+	uint8_t *cipher_key;
+	uint64_t *tmp_key;
+	int i, length = 0;
+	size_t offset;
+
+	if (tls_ver == RTE_SECURITY_VERSION_TLS_1_2) {
+		write_sa->w2.s.version_select = ROC_IE_OW_TLS_VERSION_TLS_12;
+		write_sa->tls_12.seq_num = tls_xfrm->tls_1_2.seq_no - 1;
+	} else if (tls_ver == RTE_SECURITY_VERSION_DTLS_1_2) {
+		write_sa->w2.s.version_select = ROC_IE_OW_TLS_VERSION_DTLS_12;
+		write_sa->tls_12.seq_num = ((uint64_t)tls_xfrm->dtls_1_2.epoch << 48) |
+					   (tls_xfrm->dtls_1_2.seq_no & 0x0000ffffffffffff);
+		write_sa->tls_12.seq_num -= 1;
+	} else if (tls_ver == RTE_SECURITY_VERSION_TLS_1_3) {
+		write_sa->w2.s.version_select = ROC_IE_OW_TLS_VERSION_TLS_13;
+		write_sa->tls_13.seq_num = tls_xfrm->tls_1_3.seq_no - 1;
+	}
+
+	cipher_key = write_sa->cipher_key;
+
+	/* Set encryption algorithm */
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
+		length = crypto_xfrm->aead.key.length;
+		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_AES_GCM) {
+			write_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_AES_GCM;
+			if (length == 16)
+				write_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_128;
+			else
+				write_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
+		}
+		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+			write_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_CHACHA_POLY;
+			write_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
+		}
+
+		key = crypto_xfrm->aead.key.data;
+		memcpy(cipher_key, key, length);
+
+		if (tls_ver == RTE_SECURITY_VERSION_TLS_1_2)
+			memcpy(((uint8_t *)cipher_key + 32), &tls_xfrm->tls_1_2.imp_nonce, 4);
+		else if (tls_ver == RTE_SECURITY_VERSION_DTLS_1_2)
+			memcpy(((uint8_t *)cipher_key + 32), &tls_xfrm->dtls_1_2.imp_nonce, 4);
+		else if (tls_ver == RTE_SECURITY_VERSION_TLS_1_3)
+			memcpy(((uint8_t *)cipher_key + 32), &tls_xfrm->tls_1_3.imp_nonce, 12);
+
+		goto key_swap;
+	}
+
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AUTH) {
+		auth_xfrm = crypto_xfrm;
+		cipher_xfrm = crypto_xfrm->next;
+	} else {
+		cipher_xfrm = crypto_xfrm;
+		auth_xfrm = crypto_xfrm->next;
+	}
+
+	if (cipher_xfrm != NULL) {
+		if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_3DES_CBC) {
+			write_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_3DES;
+			length = cipher_xfrm->cipher.key.length;
+		} else if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_AES_CBC) {
+			write_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_AES_CBC;
+			length = cipher_xfrm->cipher.key.length;
+			if (length == 16)
+				write_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_128;
+			else if (length == 32)
+				write_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
+			else
+				return -EINVAL;
+		} else {
+			return -EINVAL;
+		}
+
+		key = cipher_xfrm->cipher.key.data;
+		if (key != NULL && length != 0) {
+			/* Copy encryption key */
+			memcpy(cipher_key, key, length);
+		}
+	}
+
+	if (auth_xfrm != NULL) {
+		if (auth_xfrm->auth.algo == RTE_CRYPTO_AUTH_MD5_HMAC)
+			write_sa->w2.s.mac_select = ROC_IE_OW_TLS_MAC_MD5;
+		else if (auth_xfrm->auth.algo == RTE_CRYPTO_AUTH_SHA1_HMAC)
+			write_sa->w2.s.mac_select = ROC_IE_OW_TLS_MAC_SHA1;
+		else if (auth_xfrm->auth.algo == RTE_CRYPTO_AUTH_SHA256_HMAC)
+			write_sa->w2.s.mac_select = ROC_IE_OW_TLS_MAC_SHA2_256;
+		else if (auth_xfrm->auth.algo == RTE_CRYPTO_AUTH_SHA384_HMAC)
+			write_sa->w2.s.mac_select = ROC_IE_OW_TLS_MAC_SHA2_384;
+		else
+			return -EINVAL;
+
+		roc_se_hmac_opad_ipad_gen(write_sa->w2.s.mac_select, auth_xfrm->auth.key.data,
+					  auth_xfrm->auth.key.length, write_sa->tls_12.opad_ipad,
+					  ROC_SE_TLS);
+	}
+
+	tmp_key = (uint64_t *)write_sa->tls_12.opad_ipad;
+	for (i = 0; i < (int)(ROC_CTX_MAX_OPAD_IPAD_LEN / sizeof(uint64_t)); i++)
+		tmp_key[i] = rte_be_to_cpu_64(tmp_key[i]);
+
+key_swap:
+	tmp_key = (uint64_t *)cipher_key;
+	for (i = 0; i < (int)(ROC_IE_OW_TLS_CTX_MAX_KEY_IV_LEN / sizeof(uint64_t)); i++)
+		tmp_key[i] = rte_be_to_cpu_64(tmp_key[i]);
+
+	write_sa->w0.s.ctx_hdr_size = ROC_IE_OW_TLS_CTX_HDR_SIZE;
+	/* Entire context size in 128B units */
+	write_sa->w0.s.ctx_size =
+		(PLT_ALIGN_CEIL(sizeof(struct roc_ie_ow_tls_write_sa), ROC_CTX_UNIT_128B) /
+		 ROC_CTX_UNIT_128B) -
+		1;
+	offset = offsetof(struct roc_ie_ow_tls_write_sa, tls_12.w26_rsvd7);
+
+	if (tls_ver == RTE_SECURITY_VERSION_TLS_1_3) {
+		offset = offsetof(struct roc_ie_ow_tls_write_sa, tls_13.w10_rsvd7);
+		write_sa->w0.s.ctx_size -= 1;
+	}
+
+	/* Word offset for HW managed CTX field */
+	write_sa->w0.s.hw_ctx_off = offset / 8;
+	write_sa->w0.s.ctx_push_size = write_sa->w0.s.hw_ctx_off;
+
+	write_sa->w0.s.aop_valid = 1;
+
+	write_sa->w2.s.iv_at_cptr = ROC_IE_OW_TLS_IV_SRC_DEFAULT;
+
+	if (write_sa->w2.s.version_select != ROC_IE_OW_TLS_VERSION_TLS_13) {
+#ifdef LA_IPSEC_DEBUG
+		if (tls_xfrm->options.iv_gen_disable == 1)
+			write_sa->w2.s.iv_at_cptr = ROC_IE_OW_TLS_IV_SRC_FROM_SA;
+#else
+		if (tls_xfrm->options.iv_gen_disable) {
+			plt_err("Application provided IV is not supported");
+			return -ENOTSUP;
+		}
+#endif
+	}
+
+	rte_wmb();
+
+	return 0;
+}
+
+static int
+cn20k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
+			  struct rte_security_tls_record_xform *tls_xfrm,
+			  struct rte_crypto_sym_xform *crypto_xfrm,
+			  struct cn20k_sec_session *sec_sess)
+{
+	struct roc_ie_ow_tls_write_sa *sa_dptr;
+	uint8_t tls_ver = tls_xfrm->ver;
+	struct cn20k_tls_record *tls;
+	union cpt_inst_w4 inst_w4;
+	void *write_sa;
+	int ret = 0;
+
+	tls = &sec_sess->tls_rec;
+	write_sa = &tls->write_sa;
+
+	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
+	sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_write_sa), 8);
+	if (sa_dptr == NULL) {
+		plt_err("Couldn't allocate memory for SA dptr");
+		return -ENOMEM;
+	}
+
+	/* Translate security parameters to SA */
+	ret = tls_write_sa_fill(sa_dptr, tls_xfrm, crypto_xfrm);
+	if (ret) {
+		plt_err("Could not fill write session parameters");
+		goto sa_dptr_free;
+	}
+
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
+		sec_sess->iv_offset = crypto_xfrm->aead.iv.offset;
+		sec_sess->iv_length = crypto_xfrm->aead.iv.length;
+	} else if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+		sec_sess->iv_offset = crypto_xfrm->cipher.iv.offset;
+		sec_sess->iv_length = crypto_xfrm->cipher.iv.length;
+	} else {
+		sec_sess->iv_offset = crypto_xfrm->next->cipher.iv.offset;
+		sec_sess->iv_length = crypto_xfrm->next->cipher.iv.length;
+	}
+
+	sec_sess->tls_opt.is_write = 1;
+	sec_sess->tls_opt.pad_shift = 0;
+	sec_sess->tls_opt.tls_ver = tls_ver;
+	sec_sess->tls_opt.enable_padding = tls_xfrm->options.extra_padding_enable;
+	sec_sess->max_extended_len = tls_write_rlens_get(tls_xfrm, crypto_xfrm);
+	sec_sess->proto = RTE_SECURITY_PROTOCOL_TLS_RECORD;
+
+	/* pre-populate CPT INST word 4 */
+	inst_w4.u64 = 0;
+	if ((tls_ver == RTE_SECURITY_VERSION_TLS_1_2) ||
+	    (tls_ver == RTE_SECURITY_VERSION_DTLS_1_2)) {
+		inst_w4.s.opcode_major = ROC_IE_OW_TLS_MAJOR_OP_RECORD_ENC | ROC_IE_OW_INPLACE_BIT;
+		if (sa_dptr->w2.s.cipher_select == ROC_IE_OW_TLS_CIPHER_3DES)
+			sec_sess->tls_opt.pad_shift = 3;
+		else
+			sec_sess->tls_opt.pad_shift = 4;
+	} else if (tls_ver == RTE_SECURITY_VERSION_TLS_1_3) {
+		inst_w4.s.opcode_major =
+			ROC_IE_OW_TLS13_MAJOR_OP_RECORD_ENC | ROC_IE_OW_INPLACE_BIT;
+	}
+	sec_sess->inst.w4 = inst_w4.u64;
+	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, write_sa);
+
+	memset(write_sa, 0, sizeof(struct roc_ie_ow_tls_write_sa));
+
+	/* Copy word0 from sa_dptr to populate ctx_push_sz ctx_size fields */
+	memcpy(write_sa, sa_dptr, 8);
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	/* Write session using microcode opcode */
+	ret = roc_cpt_ctx_write(lf, sa_dptr, write_sa, sizeof(struct roc_ie_ow_tls_write_sa));
+	if (ret) {
+		plt_err("Could not write tls write session to hardware");
+		goto sa_dptr_free;
+	}
+
+	/* Trigger CTX flush so that data is written back to DRAM */
+	ret = roc_cpt_lf_ctx_flush(lf, write_sa, false);
+	if (ret == -EFAULT) {
+		plt_err("Could not flush TLS write session to hardware");
+		goto sa_dptr_free;
+	}
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+sa_dptr_free:
+	plt_free(sa_dptr);
+
+	return ret;
+}
+
 int
 cn20k_tls_record_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 				struct cn20k_sec_session *sess,
@@ -492,8 +816,9 @@ cn20k_tls_record_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 	if (tls_xfrm->type == RTE_SECURITY_TLS_SESS_TYPE_READ)
 		return cn20k_tls_read_sa_create(roc_cpt, &qp->lf, tls_xfrm, crypto_xfrm,
 						(struct cn20k_sec_session *)sess);
-
-	return -ENOTSUP;
+	else
+		return cn20k_tls_write_sa_create(roc_cpt, &qp->lf, tls_xfrm, crypto_xfrm,
+						 (struct cn20k_sec_session *)sess);
 }
 
 int
-- 
2.25.1

