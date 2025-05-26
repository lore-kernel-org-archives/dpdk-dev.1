Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9538FC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:01:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 762224067A;
	Mon, 26 May 2025 18:59:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A62884067A
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:44 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q1D5Pr028978
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 KaUNclkRsiCwEABDusKu1gUf+mJ7apRf6ygfRg+wuY=; b=O7t4GXhBwtOdavnWi
 Gm1mzOvRKf3zHfe0itWU1XLfVC9IMtblG+1u8hrUJD+Izs2X3qHS2qVKX8lxyXD1
 DCGBAjhSpioeNg2y0DW4zPnMFhBEaacI5MTKbOj/vACq9on4fT9xwxbGcXAljM6s
 Qr9ty2rJHed6ddbCMRYxE2YZzGUVu2rsEzctqxw4RrNM3cF5c3PM2fIxFxhsH+Bn
 aZhS97a3Xx2wUvWh+PnIrRZx1WgElEsEYOKeV25t5EIlGGZd6NfE2N/vnrNJnDpm
 ylz06jojlwM8C8JPIcYOQAIrAU34kcPYKqixkzE6v7LjtD4/18XK/OWT/DrqKohD
 tAhsQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebhjrq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:38 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 5DACF3F7048;
 Mon, 26 May 2025 09:59:35 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 23/40] crypto/cnxk: add tls write session creation
Date: Mon, 26 May 2025 22:28:02 +0530
Message-ID: <20250526165819.2197892-24-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QmIISWZA_bekkNdjU2EGEK77TWa9FS0l
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68349dff cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=Z45Zc8Lmu-4BIUzS0UoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX2Acxsf+9elLG
 yCfKHCX099RK4lAiNqBh0QH4vVCCZfyaygaHaiVfGEhrVIDPU+uYJvNtm90dmnuZTdF2QbsVudF
 Sp9+324+FCsbCyFvtrU4fCkNpcSmFNmgAOLsStIrN7rOjrO/WxLP3SLnaob8/FeHBReBTV+tJJo
 0V/jcWqiY4HNjGlBvRLU5lnn1BUd2WpsXjGEVc/IchlwnZ3WD0sFwXhkCP4RwQ7q/JA/gb+KrhO
 lLIYh8cjs1HmPdJ4vKOQau8mMUp2/a1ass/VaMrgC9M88F9Dr+tR06zn35QLayFDo73UGakOcd4
 1TmJmQNT74Dugkm303nxbFFmcM2YioohtIJhO9DY9tcLjVOXrPkABAjX+gQokdpFp7uFYZeFxMe
 252+4SWBkqsdAMycPGiCdqUMV0a8KdxyIRPYVI9atTVMSBwxqsj7p+XFUdMh8Bs6XQzniq50
X-Proofpoint-GUID: QmIISWZA_bekkNdjU2EGEK77TWa9FS0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

Add support for tls read session creation for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c |   4 +
 drivers/crypto/cnxk/cn20k_cryptodev_sec.h |  12 +
 drivers/crypto/cnxk/cn20k_tls.c           | 463 +++++++++++++++++++++-
 3 files changed, 473 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index 7374a83795..e5158af595 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -32,6 +32,10 @@ cn20k_sec_session_create(void *dev, struct rte_security_session_conf *conf,
 		return cn20k_ipsec_session_create(vf, qp, &conf->ipsec, conf->crypto_xform, sess);
 	}
 
+	if (conf->protocol == RTE_SECURITY_PROTOCOL_TLS_RECORD)
+		return cn20k_tls_record_session_create(vf, qp, &conf->tls_record,
+						       conf->crypto_xform, sess);
+
 	return -ENOTSUP;
 }
 
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.h b/drivers/crypto/cnxk/cn20k_cryptodev_sec.h
index 4d6dcc9670..42f588e4ac 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.h
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.h
@@ -12,9 +12,19 @@
 #include "roc_cpt.h"
 
 #include "cn20k_ipsec.h"
+#include "cn20k_tls.h"
 
 #define SEC_SESS_SIZE sizeof(struct rte_security_session)
 
+struct cn20k_tls_opt {
+	uint16_t pad_shift : 3;
+	uint16_t enable_padding : 1;
+	uint16_t tail_fetch_len : 2;
+	uint16_t tls_ver : 2;
+	uint16_t is_write : 1;
+	uint16_t mac_len : 7;
+};
+
 void cn20k_sec_ops_override(void);
 
 struct __rte_aligned(ROC_ALIGN) cn20k_sec_session {
@@ -31,6 +41,7 @@ struct __rte_aligned(ROC_ALIGN) cn20k_sec_session {
 	uint8_t iv_length;
 	union {
 		uint16_t u16;
+		struct cn20k_tls_opt tls_opt;
 		struct {
 			uint8_t ip_csum;
 			uint8_t is_outbound : 1;
@@ -46,6 +57,7 @@ struct __rte_aligned(ROC_ALIGN) cn20k_sec_session {
 	 */
 	union {
 		struct cn20k_ipsec_sa sa;
+		struct cn20k_tls_record tls_rec;
 	};
 };
 
diff --git a/drivers/crypto/cnxk/cn20k_tls.c b/drivers/crypto/cnxk/cn20k_tls.c
index cef13a68a4..513e49de6b 100644
--- a/drivers/crypto/cnxk/cn20k_tls.c
+++ b/drivers/crypto/cnxk/cn20k_tls.c
@@ -15,8 +15,452 @@
 #include "cn20k_tls.h"
 #include "cnxk_cryptodev.h"
 #include "cnxk_cryptodev_ops.h"
+#include "cnxk_ipsec.h"
 #include "cnxk_security.h"
 
+static int
+tls_xform_cipher_auth_verify(struct rte_crypto_sym_xform *cipher_xform,
+			     struct rte_crypto_sym_xform *auth_xform)
+{
+	enum rte_crypto_cipher_algorithm c_algo = cipher_xform->cipher.algo;
+	enum rte_crypto_auth_algorithm a_algo = auth_xform->auth.algo;
+	int ret = -ENOTSUP;
+
+	switch (c_algo) {
+	case RTE_CRYPTO_CIPHER_NULL:
+		if ((a_algo == RTE_CRYPTO_AUTH_MD5_HMAC) || (a_algo == RTE_CRYPTO_AUTH_SHA1_HMAC) ||
+		    (a_algo == RTE_CRYPTO_AUTH_SHA256_HMAC) ||
+		    (a_algo == RTE_CRYPTO_AUTH_SHA384_HMAC))
+			ret = 0;
+		break;
+	case RTE_CRYPTO_CIPHER_3DES_CBC:
+		if (a_algo == RTE_CRYPTO_AUTH_SHA1_HMAC)
+			ret = 0;
+		break;
+	case RTE_CRYPTO_CIPHER_AES_CBC:
+		if ((a_algo == RTE_CRYPTO_AUTH_SHA1_HMAC) ||
+		    (a_algo == RTE_CRYPTO_AUTH_SHA256_HMAC) ||
+		    (a_algo == RTE_CRYPTO_AUTH_SHA384_HMAC))
+			ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int
+tls_xform_cipher_verify(struct rte_crypto_sym_xform *crypto_xform)
+{
+	enum rte_crypto_cipher_algorithm c_algo = crypto_xform->cipher.algo;
+	uint16_t keylen = crypto_xform->cipher.key.length;
+
+	if (((c_algo == RTE_CRYPTO_CIPHER_NULL) && (keylen == 0)) ||
+	    ((c_algo == RTE_CRYPTO_CIPHER_3DES_CBC) && (keylen == 24)) ||
+	    ((c_algo == RTE_CRYPTO_CIPHER_AES_CBC) && ((keylen == 16) || (keylen == 32))))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int
+tls_xform_auth_verify(struct rte_crypto_sym_xform *crypto_xform)
+{
+	enum rte_crypto_auth_algorithm a_algo = crypto_xform->auth.algo;
+	uint16_t keylen = crypto_xform->auth.key.length;
+
+	if (((a_algo == RTE_CRYPTO_AUTH_MD5_HMAC) && (keylen == 16)) ||
+	    ((a_algo == RTE_CRYPTO_AUTH_SHA1_HMAC) && (keylen == 20)) ||
+	    ((a_algo == RTE_CRYPTO_AUTH_SHA256_HMAC) && (keylen == 32)) ||
+	    ((a_algo == RTE_CRYPTO_AUTH_SHA384_HMAC) && (keylen == 48)))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int
+tls_xform_aead_verify(struct rte_security_tls_record_xform *tls_xform,
+		      struct rte_crypto_sym_xform *crypto_xform)
+{
+	uint16_t keylen = crypto_xform->aead.key.length;
+
+	if (tls_xform->type == RTE_SECURITY_TLS_SESS_TYPE_WRITE &&
+	    crypto_xform->aead.op != RTE_CRYPTO_AEAD_OP_ENCRYPT)
+		return -EINVAL;
+
+	if (tls_xform->type == RTE_SECURITY_TLS_SESS_TYPE_READ &&
+	    crypto_xform->aead.op != RTE_CRYPTO_AEAD_OP_DECRYPT)
+		return -EINVAL;
+
+	if (crypto_xform->aead.algo == RTE_CRYPTO_AEAD_AES_GCM) {
+		if ((keylen == 16) || (keylen == 32))
+			return 0;
+	}
+
+	if ((crypto_xform->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) && (keylen == 32))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int
+cnxk_tls_xform_verify(struct rte_security_tls_record_xform *tls_xform,
+		      struct rte_crypto_sym_xform *crypto_xform)
+{
+	struct rte_crypto_sym_xform *auth_xform, *cipher_xform = NULL;
+	int ret = 0;
+
+	if ((tls_xform->ver != RTE_SECURITY_VERSION_TLS_1_2) &&
+	    (tls_xform->ver != RTE_SECURITY_VERSION_DTLS_1_2) &&
+	    (tls_xform->ver != RTE_SECURITY_VERSION_TLS_1_3))
+		return -EINVAL;
+
+	if ((tls_xform->type != RTE_SECURITY_TLS_SESS_TYPE_READ) &&
+	    (tls_xform->type != RTE_SECURITY_TLS_SESS_TYPE_WRITE))
+		return -EINVAL;
+
+	if (crypto_xform->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
+		/* optional padding is not allowed in TLS-1.2 for AEAD */
+		if ((tls_xform->options.extra_padding_enable == 1) &&
+		    (tls_xform->ver != RTE_SECURITY_VERSION_TLS_1_3))
+			return -EINVAL;
+
+		return tls_xform_aead_verify(tls_xform, crypto_xform);
+	}
+
+	/* TLS-1.3 only support AEAD.
+	 * Control should not reach here for TLS-1.3
+	 */
+	if (tls_xform->ver == RTE_SECURITY_VERSION_TLS_1_3)
+		return -EINVAL;
+
+	if (tls_xform->type == RTE_SECURITY_TLS_SESS_TYPE_WRITE) {
+		/* Egress */
+
+		/* First should be for auth in Egress */
+		if (crypto_xform->type != RTE_CRYPTO_SYM_XFORM_AUTH)
+			return -EINVAL;
+
+		/* Next if present, should be for cipher in Egress */
+		if ((crypto_xform->next != NULL) &&
+		    (crypto_xform->next->type != RTE_CRYPTO_SYM_XFORM_CIPHER))
+			return -EINVAL;
+
+		auth_xform = crypto_xform;
+		cipher_xform = crypto_xform->next;
+	} else {
+		/* Ingress */
+
+		/* First can be for auth only when next is NULL in Ingress. */
+		if ((crypto_xform->type == RTE_CRYPTO_SYM_XFORM_AUTH) &&
+		    (crypto_xform->next != NULL))
+			return -EINVAL;
+		else if ((crypto_xform->type != RTE_CRYPTO_SYM_XFORM_CIPHER) ||
+			 (crypto_xform->next->type != RTE_CRYPTO_SYM_XFORM_AUTH))
+			return -EINVAL;
+
+		cipher_xform = crypto_xform;
+		auth_xform = crypto_xform->next;
+	}
+
+	if (cipher_xform) {
+		if ((tls_xform->type == RTE_SECURITY_TLS_SESS_TYPE_WRITE) &&
+		    !(cipher_xform->cipher.op == RTE_CRYPTO_CIPHER_OP_ENCRYPT &&
+		      auth_xform->auth.op == RTE_CRYPTO_AUTH_OP_GENERATE))
+			return -EINVAL;
+
+		if ((tls_xform->type == RTE_SECURITY_TLS_SESS_TYPE_READ) &&
+		    !(cipher_xform->cipher.op == RTE_CRYPTO_CIPHER_OP_DECRYPT &&
+		      auth_xform->auth.op == RTE_CRYPTO_AUTH_OP_VERIFY))
+			return -EINVAL;
+	} else {
+		if ((tls_xform->type == RTE_SECURITY_TLS_SESS_TYPE_WRITE) &&
+		    (auth_xform->auth.op != RTE_CRYPTO_AUTH_OP_GENERATE))
+			return -EINVAL;
+
+		if ((tls_xform->type == RTE_SECURITY_TLS_SESS_TYPE_READ) &&
+		    (auth_xform->auth.op == RTE_CRYPTO_AUTH_OP_VERIFY))
+			return -EINVAL;
+	}
+
+	if (cipher_xform)
+		ret = tls_xform_cipher_verify(cipher_xform);
+
+	if (!ret)
+		ret = tls_xform_auth_verify(auth_xform);
+
+	if (cipher_xform && !ret)
+		return tls_xform_cipher_auth_verify(cipher_xform, auth_xform);
+
+	return ret;
+}
+
+static size_t
+tls_read_ctx_size(struct roc_ie_ow_tls_read_sa *sa, enum rte_security_tls_version tls_ver)
+{
+	size_t size;
+
+	/* Variable based on Anti-replay Window */
+	if (tls_ver == RTE_SECURITY_VERSION_TLS_1_3) {
+		size = offsetof(struct roc_ie_ow_tls_read_sa, tls_13.ctx) +
+		       sizeof(struct roc_ie_ow_tls_1_3_read_ctx_update_reg);
+	} else {
+		size = offsetof(struct roc_ie_ow_tls_read_sa, tls_12.ctx) +
+		       offsetof(struct roc_ie_ow_tls_read_ctx_update_reg, ar_winbits);
+	}
+
+	if (sa->w0.s.ar_win)
+		size += (1 << (sa->w0.s.ar_win - 1)) * sizeof(uint64_t);
+
+	return size;
+}
+
+static int
+tls_read_sa_fill(struct roc_ie_ow_tls_read_sa *read_sa,
+		 struct rte_security_tls_record_xform *tls_xfrm,
+		 struct rte_crypto_sym_xform *crypto_xfrm, struct cn20k_tls_opt *tls_opt)
+{
+	enum rte_security_tls_version tls_ver = tls_xfrm->ver;
+	struct rte_crypto_sym_xform *auth_xfrm, *cipher_xfrm;
+	const uint8_t *key = NULL;
+	uint64_t *tmp, *tmp_key;
+	uint32_t replay_win_sz;
+	uint8_t *cipher_key;
+	int i, length = 0;
+	size_t offset;
+
+	/* Initialize the SA */
+	memset(read_sa, 0, sizeof(struct roc_ie_ow_tls_read_sa));
+
+	if (tls_ver == RTE_SECURITY_VERSION_TLS_1_2) {
+		read_sa->w2.s.version_select = ROC_IE_OW_TLS_VERSION_TLS_12;
+		read_sa->tls_12.ctx.ar_valid_mask = tls_xfrm->tls_1_2.seq_no - 1;
+	} else if (tls_ver == RTE_SECURITY_VERSION_DTLS_1_2) {
+		read_sa->w2.s.version_select = ROC_IE_OW_TLS_VERSION_DTLS_12;
+	} else if (tls_ver == RTE_SECURITY_VERSION_TLS_1_3) {
+		read_sa->w2.s.version_select = ROC_IE_OW_TLS_VERSION_TLS_13;
+		read_sa->tls_13.ctx.ar_valid_mask = tls_xfrm->tls_1_3.seq_no - 1;
+	}
+
+	cipher_key = read_sa->cipher_key;
+
+	/* Set encryption algorithm */
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
+		length = crypto_xfrm->aead.key.length;
+		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_AES_GCM) {
+			read_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_AES_GCM;
+			if (length == 16)
+				read_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_128;
+			else
+				read_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
+		}
+
+		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+			read_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_CHACHA_POLY;
+			read_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
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
+			read_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_3DES;
+			length = cipher_xfrm->cipher.key.length;
+		} else if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_AES_CBC) {
+			read_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_AES_CBC;
+			length = cipher_xfrm->cipher.key.length;
+			if (length == 16)
+				read_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_128;
+			else if (length == 32)
+				read_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
+			else
+				return -EINVAL;
+		} else {
+			return -EINVAL;
+		}
+
+		key = cipher_xfrm->cipher.key.data;
+		memcpy(cipher_key, key, length);
+	}
+
+	switch (auth_xfrm->auth.algo) {
+	case RTE_CRYPTO_AUTH_MD5_HMAC:
+		read_sa->w2.s.mac_select = ROC_IE_OW_TLS_MAC_MD5;
+		tls_opt->mac_len = 0;
+		break;
+	case RTE_CRYPTO_AUTH_SHA1_HMAC:
+		read_sa->w2.s.mac_select = ROC_IE_OW_TLS_MAC_SHA1;
+		tls_opt->mac_len = 20;
+		break;
+	case RTE_CRYPTO_AUTH_SHA256_HMAC:
+		read_sa->w2.s.mac_select = ROC_IE_OW_TLS_MAC_SHA2_256;
+		tls_opt->mac_len = 32;
+		break;
+	case RTE_CRYPTO_AUTH_SHA384_HMAC:
+		read_sa->w2.s.mac_select = ROC_IE_OW_TLS_MAC_SHA2_384;
+		tls_opt->mac_len = 48;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	roc_se_hmac_opad_ipad_gen(read_sa->w2.s.mac_select, auth_xfrm->auth.key.data,
+				  auth_xfrm->auth.key.length, read_sa->tls_12.opad_ipad,
+				  ROC_SE_TLS);
+
+	tmp = (uint64_t *)read_sa->tls_12.opad_ipad;
+	for (i = 0; i < (int)(ROC_CTX_MAX_OPAD_IPAD_LEN / sizeof(uint64_t)); i++)
+		tmp[i] = rte_be_to_cpu_64(tmp[i]);
+
+key_swap:
+	tmp_key = (uint64_t *)cipher_key;
+	for (i = 0; i < (int)(ROC_IE_OW_TLS_CTX_MAX_KEY_IV_LEN / sizeof(uint64_t)); i++)
+		tmp_key[i] = rte_be_to_cpu_64(tmp_key[i]);
+
+	if (tls_xfrm->ver == RTE_SECURITY_VERSION_DTLS_1_2) {
+		/* Only support power-of-two window sizes supported */
+		replay_win_sz = tls_xfrm->dtls_1_2.ar_win_sz;
+		if (replay_win_sz) {
+			if (!rte_is_power_of_2(replay_win_sz) ||
+			    replay_win_sz > ROC_IE_OW_TLS_AR_WIN_SIZE_MAX)
+				return -ENOTSUP;
+
+			read_sa->w0.s.ar_win = rte_log2_u32(replay_win_sz) - 5;
+		}
+	}
+
+	read_sa->w0.s.ctx_hdr_size = ROC_IE_OW_TLS_CTX_HDR_SIZE;
+	read_sa->w0.s.aop_valid = 1;
+
+	offset = offsetof(struct roc_ie_ow_tls_read_sa, tls_12.ctx);
+	if (tls_ver == RTE_SECURITY_VERSION_TLS_1_3)
+		offset = offsetof(struct roc_ie_ow_tls_read_sa, tls_13.ctx);
+
+	/* Entire context size in 128B units */
+	read_sa->w0.s.ctx_size =
+		(PLT_ALIGN_CEIL(tls_read_ctx_size(read_sa, tls_ver), ROC_CTX_UNIT_128B) /
+		 ROC_CTX_UNIT_128B) -
+		1;
+
+	/* Word offset for HW managed CTX field */
+	read_sa->w0.s.hw_ctx_off = offset / 8;
+	read_sa->w0.s.ctx_push_size = read_sa->w0.s.hw_ctx_off;
+
+	rte_wmb();
+
+	return 0;
+}
+
+static int
+cn20k_tls_read_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
+			 struct rte_security_tls_record_xform *tls_xfrm,
+			 struct rte_crypto_sym_xform *crypto_xfrm,
+			 struct cn20k_sec_session *sec_sess)
+{
+	struct roc_ie_ow_tls_read_sa *sa_dptr;
+	uint8_t tls_ver = tls_xfrm->ver;
+	struct cn20k_tls_record *tls;
+	union cpt_inst_w4 inst_w4;
+	void *read_sa;
+	int ret = 0;
+
+	tls = &sec_sess->tls_rec;
+	read_sa = &tls->read_sa;
+
+	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
+	sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_read_sa), 8);
+	if (sa_dptr == NULL) {
+		plt_err("Could not allocate memory for SA dptr");
+		return -ENOMEM;
+	}
+
+	/* Translate security parameters to SA */
+	ret = tls_read_sa_fill(sa_dptr, tls_xfrm, crypto_xfrm, &sec_sess->tls_opt);
+	if (ret) {
+		plt_err("Could not fill read session parameters");
+		goto sa_dptr_free;
+	}
+	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
+		sec_sess->iv_offset = crypto_xfrm->aead.iv.offset;
+		sec_sess->iv_length = crypto_xfrm->aead.iv.length;
+	} else if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+		sec_sess->iv_offset = crypto_xfrm->cipher.iv.offset;
+		sec_sess->iv_length = crypto_xfrm->cipher.iv.length;
+	} else {
+		sec_sess->iv_offset = crypto_xfrm->auth.iv.offset;
+		sec_sess->iv_length = crypto_xfrm->auth.iv.length;
+	}
+
+	sec_sess->proto = RTE_SECURITY_PROTOCOL_TLS_RECORD;
+
+	/* pre-populate CPT INST word 4 */
+	inst_w4.u64 = 0;
+	if ((tls_ver == RTE_SECURITY_VERSION_TLS_1_2) ||
+	    (tls_ver == RTE_SECURITY_VERSION_DTLS_1_2)) {
+		inst_w4.s.opcode_major = ROC_IE_OW_TLS_MAJOR_OP_RECORD_DEC | ROC_IE_OW_INPLACE_BIT;
+		sec_sess->tls_opt.tail_fetch_len = 0;
+		if (sa_dptr->w2.s.cipher_select == ROC_IE_OW_TLS_CIPHER_3DES)
+			sec_sess->tls_opt.tail_fetch_len = 1;
+		else if (sa_dptr->w2.s.cipher_select == ROC_IE_OW_TLS_CIPHER_AES_CBC)
+			sec_sess->tls_opt.tail_fetch_len = 2;
+	} else if (tls_xfrm->ver == RTE_SECURITY_VERSION_TLS_1_3) {
+		inst_w4.s.opcode_major =
+			ROC_IE_OW_TLS13_MAJOR_OP_RECORD_DEC | ROC_IE_OW_INPLACE_BIT;
+	}
+
+	sec_sess->tls_opt.tls_ver = tls_ver;
+	sec_sess->inst.w4 = inst_w4.u64;
+	sec_sess->inst.w7 = cnxk_cpt_sec_inst_w7_get(roc_cpt, read_sa);
+
+	memset(read_sa, 0, sizeof(struct roc_ie_ow_tls_read_sa));
+
+	/* Copy word0 from sa_dptr to populate ctx_push_sz ctx_size fields */
+	memcpy(read_sa, sa_dptr, 8);
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	/* Write session using microcode opcode */
+	ret = roc_cpt_ctx_write(lf, sa_dptr, read_sa, sizeof(struct roc_ie_ow_tls_read_sa));
+	if (ret) {
+		plt_err("Could not write read session to hardware");
+		goto sa_dptr_free;
+	}
+
+	/* Trigger CTX flush so that data is written back to DRAM */
+	ret = roc_cpt_lf_ctx_flush(lf, read_sa, true);
+	if (ret == -EFAULT) {
+		plt_err("Could not flush TLS read session to hardware");
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
@@ -36,13 +480,20 @@ cn20k_tls_record_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 				struct rte_crypto_sym_xform *crypto_xfrm,
 				struct rte_security_session *sess)
 {
-	RTE_SET_USED(vf);
-	RTE_SET_USED(qp);
-	RTE_SET_USED(tls_xfrm);
-	RTE_SET_USED(crypto_xfrm);
-	RTE_SET_USED(sess);
+	struct roc_cpt *roc_cpt;
+	int ret;
 
-	return 0;
+	ret = cnxk_tls_xform_verify(tls_xfrm, crypto_xfrm);
+	if (ret)
+		return ret;
+
+	roc_cpt = &vf->cpt;
+
+	if (tls_xfrm->type == RTE_SECURITY_TLS_SESS_TYPE_READ)
+		return cn20k_tls_read_sa_create(roc_cpt, &qp->lf, tls_xfrm, crypto_xfrm,
+						(struct cn20k_sec_session *)sess);
+
+	return -ENOTSUP;
 }
 
 int
-- 
2.25.1

