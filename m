Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57611088E70
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 04:06:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D9A402A7;
	Thu, 19 Mar 2026 05:05:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B9C9F4013F;
 Thu, 19 Mar 2026 05:05:57 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J3QAaV1405169; Wed, 18 Mar 2026 21:05:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=LfOR5Wn07uPZQZX8OuNTNHU
 zF8ZAfpuZk0XlfT9yBhc=; b=ilzZp+s5B2oRqy+QK7/AkitDXOxCtm3UMCGgDL/
 PTfT59Q3w5534vn+KTzwfPIUekZ7OmJY+VTRyBcYKFQjDjVjB5BizM1B+4GqKTjd
 5vsFVThnVPp919g6BiSTGRa2tphaYg2fgASN/b60M/Ydod3/ldoZOfV3tT3l3IiY
 k/p6ZBHdLfyuXboviwzzMRJTc9lnpTIQ2ns1e2uX9cH+g6wUjI1UtYGa7P/7ibeW
 FJQsj39VkcnEF35dOxCe41p4x4ArlT2dQp2KOafToxIBC+UDbcdOA0CFDY6XYPXu
 1GhvDr93cqBh7+QB7c6XrjSOGKVNwxcpSgALhm8a3x5nNxA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cytccjbdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 21:05:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Mar 2026 21:05:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 18 Mar 2026 21:05:55 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 5D0763F7058;
 Wed, 18 Mar 2026 21:05:53 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] common/cnxk: validate cipher key length
Date: Thu, 19 Mar 2026 09:35:52 +0530
Message-ID: <20260319040552.4151899-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zWAuYi c=1 sm=1 tr=0 ts=69bb7624 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=UzQi_V4CL4N8gIqO2eoA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyOCBTYWx0ZWRfX3/Ch+55NsUs+
 nZbzsBcgFRy1HKqTWJrfMBoT9IO5uNGUEmTdBRptz4Q7144OsYjW3GWfCr8AugAPo/w0ExVHn2w
 1R0GQRqE06CfT3iRZ5tHvO9IphewTWKXRqxT0NK4+N/YNOWOsml3xCmMNUC+7ZitTDnnNIVY2ZC
 Ho2xU6yu6yYsW8t8GxkDYj6vhJiOeAcDEpdPK+DtMW9ZYEsa2eF4PKiYmfYo4plpw6m0qTmiJH/
 r59Ub6WgcDpVSEt1KM/Am5/XsFaS50qe0CzN2itoabDqPNIM+SJEyEZz7waoSQhxAOhqdXIFHNS
 M33inYdv+VOaH4wtfHaha7XViF+zJ8L5kwBSX3uyw1Yj8mC0J7M0M3koF53AySas50GGYQVlkkN
 IJZ7Y1Hui9bKuRLstEH7/1ePhfjVmaLetGIZ0VYbg0MrKCVRjo/SXHpdYkIDZpCNKwC0gPx+qEs
 yEaPKVipNdVxgE48RQQ==
X-Proofpoint-ORIG-GUID: 8_8l3y70eqdd_NagBCi6LLXrPnShiH-Q
X-Proofpoint-GUID: 8_8l3y70eqdd_NagBCi6LLXrPnShiH-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
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

Validate DES/3DES and AES key lengths before copying
into SA cipher_key[] to avoid out-of-bounds write
into adjacent IV/salt fields.

Cc: stable@dpdk.org

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 127 ++++++++++++++++------------
 drivers/common/cnxk/roc_cpt.h       |   1 +
 2 files changed, 76 insertions(+), 52 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 14d29e605a..04aca12131 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -170,6 +170,35 @@ ot_ipsec_sa_common_param_fill(union roc_ot_ipsec_sa_word2 *w2, uint8_t *cipher_k
 	w2->s.spi = ipsec_xfrm->spi;
 
 	if (key != NULL && length != 0) {
+		/* Validate key length and set AES key len before copy to avoid overflow */
+		if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC ||
+		    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR ||
+		    w2->s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
+		    w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
+		    w2->s.auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
+			switch (length) {
+			case ROC_CPT_AES128_KEY_LEN:
+				w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_128;
+				break;
+			case ROC_CPT_AES192_KEY_LEN:
+				w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_192;
+				break;
+			case ROC_CPT_AES256_KEY_LEN:
+				w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_256;
+				break;
+			default:
+				plt_err("Invalid AES key length");
+				return -EINVAL;
+			}
+		}
+		if (w2->s.enc_type == ROC_IE_SA_ENC_DES_CBC && length != ROC_CPT_DES_KEY_LEN) {
+			plt_err("Invalid DES key length");
+			return -EINVAL;
+		}
+		if (w2->s.enc_type == ROC_IE_SA_ENC_3DES_CBC && length != ROC_CPT_DES3_KEY_LEN) {
+			plt_err("Invalid 3DES key length");
+			return -EINVAL;
+		}
 		/* Copy encryption key */
 		memcpy(cipher_key, key, length);
 		tmp_key = (uint64_t *)cipher_key;
@@ -177,30 +206,7 @@ ot_ipsec_sa_common_param_fill(union roc_ot_ipsec_sa_word2 *w2, uint8_t *cipher_k
 			tmp_key[i] = rte_be_to_cpu_64(tmp_key[i]);
 	}
 
-	/* Set AES key length */
-	if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC ||
-	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR ||
-	    w2->s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
-	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
-	    w2->s.auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
-		switch (length) {
-		case ROC_CPT_AES128_KEY_LEN:
-			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_128;
-			break;
-		case ROC_CPT_AES192_KEY_LEN:
-			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_192;
-			break;
-		case ROC_CPT_AES256_KEY_LEN:
-			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_256;
-			break;
-		default:
-			plt_err("Invalid AES key length");
-			return -EINVAL;
-		}
-	}
-
-	if (ipsec_xfrm->life.packets_soft_limit != 0 ||
-	    ipsec_xfrm->life.packets_hard_limit != 0) {
+	if (ipsec_xfrm->life.packets_soft_limit != 0 || ipsec_xfrm->life.packets_hard_limit != 0) {
 		if (ipsec_xfrm->life.bytes_soft_limit != 0 ||
 		    ipsec_xfrm->life.bytes_hard_limit != 0) {
 			plt_err("Expiry tracking with both packets & bytes is not supported");
@@ -844,9 +850,11 @@ on_ipsec_sa_ctl_set(struct rte_security_ipsec_xform *ipsec,
 				break;
 			case RTE_CRYPTO_CIPHER_DES_CBC:
 				ctl->enc_type = ROC_IE_SA_ENC_DES_CBC;
+				aes_key_len = cipher_xform->cipher.key.length;
 				break;
 			case RTE_CRYPTO_CIPHER_3DES_CBC:
 				ctl->enc_type = ROC_IE_SA_ENC_3DES_CBC;
+				aes_key_len = cipher_xform->cipher.key.length;
 				break;
 			case RTE_CRYPTO_CIPHER_AES_CBC:
 				ctl->enc_type = ROC_IE_SA_ENC_AES_CBC;
@@ -897,20 +905,18 @@ on_ipsec_sa_ctl_set(struct rte_security_ipsec_xform *ipsec,
 		}
 	}
 
-	/* Set AES key length */
-	if (ctl->enc_type == ROC_IE_SA_ENC_AES_CBC ||
-	    ctl->enc_type == ROC_IE_SA_ENC_AES_CTR ||
-	    ctl->enc_type == ROC_IE_SA_ENC_AES_GCM ||
-	    ctl->enc_type == ROC_IE_SA_ENC_AES_CCM ||
+	/* Validate and set AES key length before copy */
+	if (ctl->enc_type == ROC_IE_SA_ENC_AES_CBC || ctl->enc_type == ROC_IE_SA_ENC_AES_CTR ||
+	    ctl->enc_type == ROC_IE_SA_ENC_AES_GCM || ctl->enc_type == ROC_IE_SA_ENC_AES_CCM ||
 	    ctl->auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
 		switch (aes_key_len) {
-		case 16:
+		case ROC_CPT_AES128_KEY_LEN:
 			ctl->aes_key_len = ROC_IE_SA_AES_KEY_LEN_128;
 			break;
-		case 24:
+		case ROC_CPT_AES192_KEY_LEN:
 			ctl->aes_key_len = ROC_IE_SA_AES_KEY_LEN_192;
 			break;
-		case 32:
+		case ROC_CPT_AES256_KEY_LEN:
 			ctl->aes_key_len = ROC_IE_SA_AES_KEY_LEN_256;
 			break;
 		default:
@@ -918,6 +924,14 @@ on_ipsec_sa_ctl_set(struct rte_security_ipsec_xform *ipsec,
 			return -EINVAL;
 		}
 	}
+	if (ctl->enc_type == ROC_IE_SA_ENC_DES_CBC && aes_key_len != ROC_CPT_DES_KEY_LEN) {
+		plt_err("Invalid DES key length");
+		return -EINVAL;
+	}
+	if (ctl->enc_type == ROC_IE_SA_ENC_3DES_CBC && aes_key_len != ROC_CPT_DES3_KEY_LEN) {
+		plt_err("Invalid 3DES key length");
+		return -EINVAL;
+	}
 
 	if (ipsec->options.esn)
 		ctl->esn_en = 1;
@@ -1364,6 +1378,35 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
 	w2->s.spi = ipsec_xfrm->spi;
 
 	if (key != NULL && length != 0) {
+		/* Validate key length and set AES key len before copy to avoid overflow */
+		if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC ||
+		    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR ||
+		    w2->s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
+		    w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
+		    w2->s.auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
+			switch (length) {
+			case ROC_CPT_AES128_KEY_LEN:
+				w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_128;
+				break;
+			case ROC_CPT_AES192_KEY_LEN:
+				w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_192;
+				break;
+			case ROC_CPT_AES256_KEY_LEN:
+				w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_256;
+				break;
+			default:
+				plt_err("Invalid AES key length");
+				return -EINVAL;
+			}
+		}
+		if (w2->s.enc_type == ROC_IE_SA_ENC_DES_CBC && length != ROC_CPT_DES_KEY_LEN) {
+			plt_err("Invalid DES key length");
+			return -EINVAL;
+		}
+		if (w2->s.enc_type == ROC_IE_SA_ENC_3DES_CBC && length != ROC_CPT_DES3_KEY_LEN) {
+			plt_err("Invalid 3DES key length");
+			return -EINVAL;
+		}
 		/* Copy encryption key */
 		memcpy(cipher_key, key, length);
 		tmp_key = (uint64_t *)cipher_key;
@@ -1371,26 +1414,6 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
 			tmp_key[i] = rte_be_to_cpu_64(tmp_key[i]);
 	}
 
-	/* Set AES key length */
-	if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC || w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM ||
-	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR || w2->s.enc_type == ROC_IE_SA_ENC_AES_GCM ||
-	    w2->s.enc_type == ROC_IE_SA_ENC_AES_CCM || w2->s.auth_type == ROC_IE_SA_AUTH_AES_GMAC) {
-		switch (length) {
-		case ROC_CPT_AES128_KEY_LEN:
-			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_128;
-			break;
-		case ROC_CPT_AES192_KEY_LEN:
-			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_192;
-			break;
-		case ROC_CPT_AES256_KEY_LEN:
-			w2->s.aes_key_len = ROC_IE_SA_AES_KEY_LEN_256;
-			break;
-		default:
-			plt_err("Invalid AES key length");
-			return -EINVAL;
-		}
-	}
-
 	if (ipsec_xfrm->life.packets_soft_limit != 0 || ipsec_xfrm->life.packets_hard_limit != 0) {
 		if (ipsec_xfrm->life.bytes_soft_limit != 0 ||
 		    ipsec_xfrm->life.bytes_hard_limit != 0) {
diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 4715359f49..533d194bd4 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -79,6 +79,7 @@
 #define ROC_CPT_SHA2_HMAC_LEN	16
 #define ROC_CPT_DES_IV_LEN	8
 
+#define ROC_CPT_DES_KEY_LEN	    8
 #define ROC_CPT_DES3_KEY_LEN	    24
 #define ROC_CPT_AES128_KEY_LEN	    16
 #define ROC_CPT_AES192_KEY_LEN	    24
-- 
2.34.1

