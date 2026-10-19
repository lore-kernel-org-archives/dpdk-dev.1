Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B481CCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9514740A79;
	Mon, 19 Oct 2026 15:08:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 77E1440A80
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:24 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8O1Ol288002 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 cHofjyBh0ZH5sny4rCOSVUzxcfY5SWVTnXkVEdiExA=; b=hVqKZyG84snYvLfU+
 xW1lqe68+Qi6HxiEg9IU9ej1IX2z6B4XRj9ajU+1zyEKY7Yo3xtEn4rSQRFzScBV
 eVANUb0AyavriDcnwi284EEmdDAPJqqr704Qmeck1Z2+RgnD/gk1IT3po/NtXwhZ
 aRVAJqjytBlyJk8U/C7GS8W7JVM6Jigl81yB8bEgwsHI5sPeILGV3y0u9uS55iPk
 GQB3Y4+ismLP74CcerUhjtb8BQJMIkmuSlIuchCjxfK41WKqWUal/YAbdwrekZe4
 mccNOgOiFlDw2yTpsj6OxGYvzoFlSct9jnXr6OdTui4OskUvEMGU7e1bcXK7fDGj
 7zCTw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hcss7b53b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:22 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id CF7CE3F704D;
 Mon, 19 Oct 2026 06:08:19 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 07/16] crypto/cnxk: validate TLS xform and keys before SA key
 copy
Date: Mon, 19 Oct 2026 18:37:48 +0530
Message-ID: <20261019130759.2181566-8-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RdAFmFtv c=1 sm=1 tr=0 ts=6ad61647 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=PNdaLdljmCghjKRSiBkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwgsEdkarJLFP
 JZDP1xLPQwQUA4lwnKO0UcbfhoXhbsI2PTbdCUNsDVoV2N+7e3raSXIDKFevoXipomjAcNBIsP+
 WnGmB6E0Y/VMNNnaqoecnB7iUzbesdo=
X-Proofpoint-ORIG-GUID: 6fBNkFmoFgV6eTOiCUK6S8A9B58EOdRL
X-Proofpoint-GUID: 6fBNkFmoFgV6eTOiCUK6S8A9B58EOdRL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX9k8qbSZXsw5Z
 ZMf+0A2jtaXsmgP73rVMbwYnvP5MmJcbFz9KN6Vl16/9pAKLUMmXqgRknaI7BFZ8y1LlyK0kK5N
 9H5wWaicsQob3SCRByZr4uXQw83Z8cRIdSRuFvwtbHEPyJWmxECwnmRVOkYCAVDdwhUaBC/OK/A
 qNgSGdwpeMkrD3eGz0dUpUiDf4g7rn/CSXze79cWGnjrMgCJucHnLaJyumyG08I9lgeVbijR9CU
 TNe6QMam+ZJHQOWDsdlyBngzX0VfQcF47Xq4MlK5mr0gdmqKIzIB7Vi9mGrIkM0luEJ01pldzmT
 yJGIPWjqf7wkHfev7RMXbDBvmnkLTG/XgYOT+RekiV06e25VkzJpZ4gWCWEgtg7PangwI2x24Zv
 IqgTKjfCslZqjXqkjf9cU3v86475R0QWILFhpqhxzE7vE8gzF0KIdU8jnwtikW95igEp0TX4PG9
 HoPnHT5S7g+nUmGmIWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

cn10k_tls_record_session_update() and cn20k_tls_record_session_update()
forwarded the crypto_xform to tls_write_sa_fill() without running
cnxk_tls_xform_verify(), unlike the create path.

Separately, the AEAD key-length guard in the SA fill routines used a
single 16/32 check that incorrectly accepted a 16-byte
ChaCha20-Poly1305 key (ChaCha requires 32), and both the AEAD and the
read-side cipher paths copied key.data without a NULL check, so a
malformed xform could crash in memcpy().

- Call cnxk_tls_xform_verify() on the update path.
- Make the AEAD key-length validation algorithm-specific (AES-GCM
  16/32, ChaCha20-Poly1305 32, reject others).
- Reject NULL key pointers before the memcpy on both the AEAD and
  cipher paths, for cn10k and cn20k.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cn10k_tls.c | 33 +++++++++++++++++++++----
 drivers/crypto/cnxk/cn20k_tls.c | 44 +++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_tls.c b/drivers/crypto/cnxk/cn10k_tls.c
index 1a7b87e400..8aa6d5ad4b 100644
--- a/drivers/crypto/cnxk/cn10k_tls.c
+++ b/drivers/crypto/cnxk/cn10k_tls.c
@@ -358,19 +358,25 @@ tls_read_sa_fill(struct roc_ie_ot_tls_read_sa *read_sa,
 	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
 		length = crypto_xfrm->aead.key.length;
 		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_AES_GCM) {
+			if (length != 16 && length != 32)
+				return -EINVAL;
 			read_sa->w2.s.cipher_select = ROC_IE_OT_TLS_CIPHER_AES_GCM;
 			if (length == 16)
 				read_sa->w2.s.aes_key_len = ROC_IE_OT_TLS_AES_KEY_LEN_128;
 			else
 				read_sa->w2.s.aes_key_len = ROC_IE_OT_TLS_AES_KEY_LEN_256;
-		}
-
-		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+		} else if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+			if (length != 32)
+				return -EINVAL;
 			read_sa->w2.s.cipher_select = ROC_IE_OT_TLS_CIPHER_CHACHA_POLY;
 			read_sa->w2.s.aes_key_len = ROC_IE_OT_TLS_AES_KEY_LEN_256;
+		} else {
+			return -EINVAL;
 		}
 
 		key = crypto_xfrm->aead.key.data;
+		if (key == NULL)
+			return -EINVAL;
 		memcpy(cipher_key, key, length);
 
 		if (tls_ver == RTE_SECURITY_VERSION_TLS_1_2)
@@ -395,6 +401,8 @@ tls_read_sa_fill(struct roc_ie_ot_tls_read_sa *read_sa,
 		if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_3DES_CBC) {
 			read_sa->w2.s.cipher_select = ROC_IE_OT_TLS_CIPHER_3DES;
 			length = cipher_xfrm->cipher.key.length;
+			if (length != 24)
+				return -EINVAL;
 		} else if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_AES_CBC) {
 			read_sa->w2.s.cipher_select = ROC_IE_OT_TLS_CIPHER_AES_CBC;
 			length = cipher_xfrm->cipher.key.length;
@@ -409,6 +417,8 @@ tls_read_sa_fill(struct roc_ie_ot_tls_read_sa *read_sa,
 		}
 
 		key = cipher_xfrm->cipher.key.data;
+		if (key == NULL || length == 0)
+			return -EINVAL;
 		memcpy(cipher_key, key, length);
 	}
 
@@ -515,18 +525,25 @@ tls_write_sa_fill(struct roc_ie_ot_tls_write_sa *write_sa,
 	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
 		length = crypto_xfrm->aead.key.length;
 		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_AES_GCM) {
+			if (length != 16 && length != 32)
+				return -EINVAL;
 			write_sa->w2.s.cipher_select = ROC_IE_OT_TLS_CIPHER_AES_GCM;
 			if (length == 16)
 				write_sa->w2.s.aes_key_len = ROC_IE_OT_TLS_AES_KEY_LEN_128;
 			else
 				write_sa->w2.s.aes_key_len = ROC_IE_OT_TLS_AES_KEY_LEN_256;
-		}
-		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+		} else if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+			if (length != 32)
+				return -EINVAL;
 			write_sa->w2.s.cipher_select = ROC_IE_OT_TLS_CIPHER_CHACHA_POLY;
 			write_sa->w2.s.aes_key_len = ROC_IE_OT_TLS_AES_KEY_LEN_256;
+		} else {
+			return -EINVAL;
 		}
 
 		key = crypto_xfrm->aead.key.data;
+		if (key == NULL)
+			return -EINVAL;
 		memcpy(cipher_key, key, length);
 
 		if (tls_ver == RTE_SECURITY_VERSION_TLS_1_2)
@@ -551,6 +568,8 @@ tls_write_sa_fill(struct roc_ie_ot_tls_write_sa *write_sa,
 		if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_3DES_CBC) {
 			write_sa->w2.s.cipher_select = ROC_IE_OT_TLS_CIPHER_3DES;
 			length = cipher_xfrm->cipher.key.length;
+			if (length != 24)
+				return -EINVAL;
 		} else if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_AES_CBC) {
 			write_sa->w2.s.cipher_select = ROC_IE_OT_TLS_CIPHER_AES_CBC;
 			length = cipher_xfrm->cipher.key.length;
@@ -833,6 +852,10 @@ cn10k_tls_record_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 	if (conf->tls_record.type == RTE_SECURITY_TLS_SESS_TYPE_READ)
 		return -ENOTSUP;
 
+	ret = cnxk_tls_xform_verify(&conf->tls_record, conf->crypto_xform);
+	if (ret)
+		return ret;
+
 	roc_cpt = &vf->cpt;
 	ret = cn10k_tls_write_sa_create(roc_cpt, &qp->lf, &conf->tls_record, conf->crypto_xform,
 					(struct cn10k_sec_session *)sess);
diff --git a/drivers/crypto/cnxk/cn20k_tls.c b/drivers/crypto/cnxk/cn20k_tls.c
index 882d193c25..ac6f6d9c4b 100644
--- a/drivers/crypto/cnxk/cn20k_tls.c
+++ b/drivers/crypto/cnxk/cn20k_tls.c
@@ -249,19 +249,25 @@ tls_read_sa_fill(struct roc_ie_ow_tls_read_sa *read_sa,
 	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
 		length = crypto_xfrm->aead.key.length;
 		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_AES_GCM) {
+			if (length != 16 && length != 32)
+				return -EINVAL;
 			read_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_AES_GCM;
 			if (length == 16)
 				read_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_128;
 			else
 				read_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
-		}
-
-		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+		} else if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+			if (length != 32)
+				return -EINVAL;
 			read_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_CHACHA_POLY;
 			read_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
+		} else {
+			return -EINVAL;
 		}
 
 		key = crypto_xfrm->aead.key.data;
+		if (key == NULL)
+			return -EINVAL;
 		memcpy(cipher_key, key, length);
 
 		if (tls_ver == RTE_SECURITY_VERSION_TLS_1_2)
@@ -286,6 +292,8 @@ tls_read_sa_fill(struct roc_ie_ow_tls_read_sa *read_sa,
 		if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_3DES_CBC) {
 			read_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_3DES;
 			length = cipher_xfrm->cipher.key.length;
+			if (length != 24)
+				return -EINVAL;
 		} else if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_AES_CBC) {
 			read_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_AES_CBC;
 			length = cipher_xfrm->cipher.key.length;
@@ -300,6 +308,8 @@ tls_read_sa_fill(struct roc_ie_ow_tls_read_sa *read_sa,
 		}
 
 		key = cipher_xfrm->cipher.key.data;
+		if (key == NULL || length == 0)
+			return -EINVAL;
 		memcpy(cipher_key, key, length);
 	}
 
@@ -576,18 +586,25 @@ tls_write_sa_fill(struct roc_ie_ow_tls_write_sa *write_sa,
 	if (crypto_xfrm->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
 		length = crypto_xfrm->aead.key.length;
 		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_AES_GCM) {
+			if (length != 16 && length != 32)
+				return -EINVAL;
 			write_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_AES_GCM;
 			if (length == 16)
 				write_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_128;
 			else
 				write_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
-		}
-		if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+		} else if (crypto_xfrm->aead.algo == RTE_CRYPTO_AEAD_CHACHA20_POLY1305) {
+			if (length != 32)
+				return -EINVAL;
 			write_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_CHACHA_POLY;
 			write_sa->w2.s.aes_key_len = ROC_IE_OW_TLS_AES_KEY_LEN_256;
+		} else {
+			return -EINVAL;
 		}
 
 		key = crypto_xfrm->aead.key.data;
+		if (key == NULL)
+			return -EINVAL;
 		memcpy(cipher_key, key, length);
 
 		if (tls_ver == RTE_SECURITY_VERSION_TLS_1_2)
@@ -612,6 +629,8 @@ tls_write_sa_fill(struct roc_ie_ow_tls_write_sa *write_sa,
 		if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_3DES_CBC) {
 			write_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_3DES;
 			length = cipher_xfrm->cipher.key.length;
+			if (length != 24)
+				return -EINVAL;
 		} else if (cipher_xfrm->cipher.algo == RTE_CRYPTO_CIPHER_AES_CBC) {
 			write_sa->w2.s.cipher_select = ROC_IE_OW_TLS_CIPHER_AES_CBC;
 			length = cipher_xfrm->cipher.key.length;
@@ -626,10 +645,9 @@ tls_write_sa_fill(struct roc_ie_ow_tls_write_sa *write_sa,
 		}
 
 		key = cipher_xfrm->cipher.key.data;
-		if (key != NULL && length != 0) {
-			/* Copy encryption key */
-			memcpy(cipher_key, key, length);
-		}
+		if (key == NULL)
+			return -EINVAL;
+		memcpy(cipher_key, key, length);
 	}
 
 	if (auth_xfrm != NULL) {
@@ -716,7 +734,6 @@ cn20k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 		plt_err("Couldn't allocate memory for WRITE SA");
 		return -ENOMEM;
 	}
-	tls->write_sa = write_sa;
 
 	/* Allocate memory to be used as dptr for CPT ucode WRITE_SA op */
 	sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_write_sa), 8);
@@ -782,6 +799,9 @@ cn20k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 
 	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
+	if (tls->write_sa != NULL)
+		rte_free(tls->write_sa);
+	tls->write_sa = write_sa;
 sa_dptr_free:
 	plt_free(sa_dptr);
 sa_cptr_free:
@@ -834,6 +854,10 @@ cn20k_tls_record_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 	if (conf->tls_record.type == RTE_SECURITY_TLS_SESS_TYPE_READ)
 		return -ENOTSUP;
 
+	ret = cnxk_tls_xform_verify(&conf->tls_record, conf->crypto_xform);
+	if (ret)
+		return ret;
+
 	roc_cpt = &vf->cpt;
 	ret = cn20k_tls_write_sa_create(roc_cpt, &qp->lf, &conf->tls_record, conf->crypto_xform,
 					(struct cn20k_sec_session *)sess);
-- 
2.43.0

