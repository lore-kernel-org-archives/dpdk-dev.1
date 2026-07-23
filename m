Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB648C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 12:20:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7FA74028A;
	Thu, 23 Jul 2026 14:20:50 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 17BB240274;
 Thu, 23 Jul 2026 14:20:48 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8td6R2884184; Thu, 23 Jul 2026 05:20:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=zyFN9hAyBMf+6Vsg7f4VTH3
 uwLrlBxPx9TCGuJMqbec=; b=cc5laPey5W/4fjnZBrTs++7ircm3yc8ndjnILKk
 wDaxrs85UuXtDUl7BNuP+898Yj9bl9uNAXb6OUtAFyCi25qxpo3SqqcpMKo/bBUm
 8PEtT5EXevnmnflCRtkFmbbTnbOGxTeIpCK6IYOBMshILEz7cIc2hq9MtbseXryw
 oBDOEcBVekh7XS8Pzb8I4BtO2eqWhTwfBxSHMo9PgFDO/NcGTNYIKd/vsk/Wvw/n
 ZQ4mg6wDExfPj74GVCKy0zS0JX5+5NHJsI20pUTGnGGff+IlvSQrBuuYKbk6lrdT
 yzExtsOk50sxwi8PMkOL0r9pz+65gR0leu1mvaNWXrwf9Ug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fka6k978y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2026 05:20:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Jul 2026 05:20:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Jul 2026 05:20:46 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.40.118])
 by maili.marvell.com (Postfix) with ESMTP id 097863F70A9;
 Thu, 23 Jul 2026 05:20:42 -0700 (PDT)
From: Aarnav JP <ajp@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>, Jerin Jacob <jerinj@marvell.com>
CC: <rbhansali@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] common/cnxk: validate xform in inline IPsec session create
Date: Thu, 23 Jul 2026 17:45:09 +0530
Message-ID: <20260723121510.3781858-1-ajp@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyMiBTYWx0ZWRfXxitbUvfUvzbe
 0i98FzVQ3t0JdPFTrDfI4Cw74hdM3WUva6pSjhAbfwW5EFle/OgSfOeEqSikssd04t1r944Z/kA
 JJFJgAx9zXKLN3BMlkUGHrIOk3AT2F0=
X-Proofpoint-GUID: yJjaYmwgyvsewECN08y0J5aPFkmzuBeZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyMiBTYWx0ZWRfXxzBpvWGLnuIu
 dVXxvCPnVnuH33y93BoN9OjNWIiI0fz3O3ZH2KPkVWcj59uDODVM46u6NcZkYO+IZVr8nLZKyAF
 gu2+ndnM4ut2wNSiZU3CvF1Y5qId/fIUE8JPetyqw1wW+9FPFUPYRpeaPykK/U/krgJ9Br7CzMX
 +YEbuqMLnuwxTDiE820kC8JVHAvz0U/blFUiTR4cwE0t1u5BLXra6Xvb+6om4wtQ3q7nXywBW/t
 Oh1x9MBHmP1bnIoPdshu4Uo+ad3fx/IUIJmN098UtlrSNxykbYcRyYWRHN6YsaGouJ4u9qkSr+L
 lCXCMitnYRl+xMCdtiQmZETrxA77QsJs4nl5NiV/Zz2on6tT76uwRG2ye8xLlEqsoCCTb1cVyha
 22HZy4PK9plf15ViLnRTyHxzKFufyRDA62Eh0Xl69QWe3ZA8Pk3X5deReHEnZdo52MPeyUNyRU6
 P1vuAS4AIP96YYOB4hw==
X-Proofpoint-ORIG-GUID: yJjaYmwgyvsewECN08y0J5aPFkmzuBeZ
X-Authority-Analysis: v=2.4 cv=Ccs4Irrl c=1 sm=1 tr=0 ts=6a62071f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=I6QA7FsoImiLfbM0l8AA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
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

Add cnxk_ipsec_xform_verify() call in cn10k, cn20k and cn9k
inline IPsec session create paths to reject invalid crypto
transforms early, before any SA memory is written. Previously
this validation was only performed in the lookaside crypto
paths, allowing the inline paths to reach SA fill helpers
with unchecked key lengths and algorithm combinations.

Move the xform verification helpers from the crypto driver
private header to the shared cnxk_security.h so they are
accessible to both the net and crypto drivers.

Drop the aead.op vs direction consistency check from the
shared verifier since the cnxk driver derives SA direction
from ipsec_xform.direction and does not use aead.op.

Fixes: 69daa9e5022b ("net/cnxk: support inline security setup for cn10k")
Fixes: 7eabd6c63773 ("net/cnxk: support inline security setup for cn9k")
Fixes: 7eaa499dd0c2 ("net/cnxk: support CN20K inline IPsec session")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 drivers/common/cnxk/cnxk_security.h | 175 ++++++++++++++++++++++++++
 drivers/crypto/cnxk/cnxk_ipsec.h    | 183 +---------------------------
 drivers/net/cnxk/cn10k_ethdev_sec.c |   7 ++
 drivers/net/cnxk/cn20k_ethdev_sec.c |   7 ++
 drivers/net/cnxk/cn9k_ethdev_sec.c  |   7 ++
 5 files changed, 197 insertions(+), 182 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.h b/drivers/common/cnxk/cnxk_security.h
index 3912c8d376..10e7d5b520 100644
--- a/drivers/common/cnxk/cnxk_security.h
+++ b/drivers/common/cnxk/cnxk_security.h
@@ -4,6 +4,8 @@
 #ifndef _CNXK_SECURITY_H__
 #define _CNXK_SECURITY_H__
 
+#include <errno.h>
+
 #include <rte_crypto.h>
 #include <rte_security.h>
 
@@ -65,4 +67,177 @@ int __roc_api cnxk_ow_ipsec_outb_sa_fill(struct roc_ow_ipsec_outb_sa *sa,
 					 uint8_t ctx_ilen);
 bool __roc_api cnxk_ow_ipsec_inb_sa_valid(struct roc_ow_ipsec_inb_sa *sa);
 bool __roc_api cnxk_ow_ipsec_outb_sa_valid(struct roc_ow_ipsec_outb_sa *sa);
+
+static inline int
+ipsec_xform_cipher_verify(struct rte_crypto_sym_xform *crypto_xform)
+{
+	if (crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_NULL)
+		return 0;
+
+	if (crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_DES_CBC &&
+	    crypto_xform->cipher.key.length == 8)
+		return 0;
+
+	if (crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_AES_CBC ||
+	    crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_AES_CTR) {
+		switch (crypto_xform->cipher.key.length) {
+		case 16:
+		case 24:
+		case 32:
+			break;
+		default:
+			return -ENOTSUP;
+		}
+		return 0;
+	}
+
+	if (crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_3DES_CBC &&
+	    crypto_xform->cipher.key.length == 24)
+		return 0;
+
+	return -ENOTSUP;
+}
+
+static inline int
+ipsec_xform_auth_verify(struct rte_crypto_sym_xform *crypto_xform)
+{
+	uint16_t keylen = crypto_xform->auth.key.length;
+
+	if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_NULL)
+		return 0;
+
+	if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_MD5_HMAC) {
+		if (keylen == 16)
+			return 0;
+	}
+
+	if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_SHA1_HMAC) {
+		if (keylen >= 20 && keylen <= 64)
+			return 0;
+	} else if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_SHA256_HMAC) {
+		if (keylen >= 32 && keylen <= 64)
+			return 0;
+	} else if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_SHA384_HMAC) {
+		if (keylen == 48)
+			return 0;
+	} else if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_SHA512_HMAC) {
+		if (keylen == 64)
+			return 0;
+	} else if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_AES_GMAC) {
+		if (keylen >= 16 && keylen <= 32)
+			return 0;
+	}
+
+	if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_AES_XCBC_MAC &&
+	    keylen == ROC_CPT_AES_XCBC_KEY_LENGTH)
+		return 0;
+
+	return -ENOTSUP;
+}
+
+static inline int
+ipsec_xform_aead_verify(struct rte_security_ipsec_xform *ipsec_xform __rte_unused,
+			struct rte_crypto_sym_xform *crypto_xform)
+{
+	if (crypto_xform->aead.algo == RTE_CRYPTO_AEAD_AES_GCM ||
+	    crypto_xform->aead.algo == RTE_CRYPTO_AEAD_AES_CCM) {
+		switch (crypto_xform->aead.key.length) {
+		case 16:
+		case 24:
+		case 32:
+			break;
+		default:
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	return -ENOTSUP;
+}
+
+static inline int
+cnxk_ipsec_xform_verify(struct rte_security_ipsec_xform *ipsec_xform,
+			struct rte_crypto_sym_xform *crypto_xform)
+{
+	struct rte_crypto_sym_xform *auth_xform, *cipher_xform;
+	int ret;
+
+	if ((ipsec_xform->direction != RTE_SECURITY_IPSEC_SA_DIR_INGRESS) &&
+	    (ipsec_xform->direction != RTE_SECURITY_IPSEC_SA_DIR_EGRESS))
+		return -EINVAL;
+
+	if ((ipsec_xform->proto != RTE_SECURITY_IPSEC_SA_PROTO_ESP) &&
+	    (ipsec_xform->proto != RTE_SECURITY_IPSEC_SA_PROTO_AH))
+		return -EINVAL;
+
+	if ((ipsec_xform->mode != RTE_SECURITY_IPSEC_SA_MODE_TRANSPORT) &&
+	    (ipsec_xform->mode != RTE_SECURITY_IPSEC_SA_MODE_TUNNEL))
+		return -EINVAL;
+
+	if ((ipsec_xform->mode == RTE_SECURITY_IPSEC_SA_MODE_TUNNEL) &&
+	    (ipsec_xform->tunnel.type != RTE_SECURITY_IPSEC_TUNNEL_IPV4) &&
+	    (ipsec_xform->tunnel.type != RTE_SECURITY_IPSEC_TUNNEL_IPV6))
+		return -EINVAL;
+
+	if (crypto_xform->type == RTE_CRYPTO_SYM_XFORM_AEAD) {
+		if (ipsec_xform->proto != RTE_SECURITY_IPSEC_SA_PROTO_ESP)
+			return -EINVAL;
+		return ipsec_xform_aead_verify(ipsec_xform, crypto_xform);
+	}
+
+	if (ipsec_xform->proto == RTE_SECURITY_IPSEC_SA_PROTO_AH) {
+		if (ipsec_xform->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS) {
+			/* Ingress */
+			auth_xform = crypto_xform;
+			cipher_xform = crypto_xform->next;
+
+			if (crypto_xform->type != RTE_CRYPTO_SYM_XFORM_AUTH)
+				return -EINVAL;
+
+			if ((cipher_xform != NULL) &&
+			    ((cipher_xform->type != RTE_CRYPTO_SYM_XFORM_CIPHER) ||
+			     (cipher_xform->cipher.algo != RTE_CRYPTO_CIPHER_NULL)))
+				return -EINVAL;
+		} else {
+			/* Egress */
+			if (crypto_xform->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
+				cipher_xform = crypto_xform;
+				auth_xform = crypto_xform->next;
+
+				if (auth_xform == NULL ||
+				    cipher_xform->cipher.algo != RTE_CRYPTO_CIPHER_NULL)
+					return -EINVAL;
+			} else if (crypto_xform->type == RTE_CRYPTO_SYM_XFORM_AUTH)
+				auth_xform = crypto_xform;
+			else
+				return -EINVAL;
+		}
+	} else {
+		if (crypto_xform->next == NULL)
+			return -EINVAL;
+
+		if (ipsec_xform->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS) {
+			/* Ingress */
+			if (crypto_xform->type != RTE_CRYPTO_SYM_XFORM_AUTH ||
+			    crypto_xform->next->type != RTE_CRYPTO_SYM_XFORM_CIPHER)
+				return -EINVAL;
+			auth_xform = crypto_xform;
+			cipher_xform = crypto_xform->next;
+		} else {
+			/* Egress */
+			if (crypto_xform->type != RTE_CRYPTO_SYM_XFORM_CIPHER ||
+			    crypto_xform->next->type != RTE_CRYPTO_SYM_XFORM_AUTH)
+				return -EINVAL;
+			cipher_xform = crypto_xform;
+			auth_xform = crypto_xform->next;
+		}
+
+		ret = ipsec_xform_cipher_verify(cipher_xform);
+		if (ret)
+			return ret;
+	}
+
+	return ipsec_xform_auth_verify(auth_xform);
+}
+
 #endif /* _CNXK_SECURITY_H__ */
diff --git a/drivers/crypto/cnxk/cnxk_ipsec.h b/drivers/crypto/cnxk/cnxk_ipsec.h
index 5f65c34380..2ca3c2525c 100644
--- a/drivers/crypto/cnxk/cnxk_ipsec.h
+++ b/drivers/crypto/cnxk/cnxk_ipsec.h
@@ -7,6 +7,7 @@
 #include <rte_security.h>
 #include <rte_security_driver.h>
 
+#include "cnxk_security.h"
 #include "roc_cpt.h"
 #include "roc_ie_on.h"
 #include "roc_ie_ot.h"
@@ -21,186 +22,4 @@ struct cnxk_cpt_inst_tmpl {
 	uint64_t w7;
 };
 
-static inline int
-ipsec_xform_cipher_verify(struct rte_crypto_sym_xform *crypto_xform)
-{
-	if (crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_NULL)
-		return 0;
-
-	if (crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_DES_CBC &&
-	    crypto_xform->cipher.key.length == 8)
-		return 0;
-
-	if (crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_AES_CBC ||
-	    crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_AES_CTR) {
-		switch (crypto_xform->cipher.key.length) {
-		case 16:
-		case 24:
-		case 32:
-			break;
-		default:
-			return -ENOTSUP;
-		}
-		return 0;
-	}
-
-	if (crypto_xform->cipher.algo == RTE_CRYPTO_CIPHER_3DES_CBC &&
-	    crypto_xform->cipher.key.length == 24)
-		return 0;
-
-	return -ENOTSUP;
-}
-
-static inline int
-ipsec_xform_auth_verify(struct rte_crypto_sym_xform *crypto_xform)
-{
-	uint16_t keylen = crypto_xform->auth.key.length;
-
-	if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_NULL)
-		return 0;
-
-	if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_MD5_HMAC) {
-		if (keylen == 16)
-			return 0;
-	}
-
-	if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_SHA1_HMAC) {
-		if (keylen >= 20 && keylen <= 64)
-			return 0;
-	} else if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_SHA256_HMAC) {
-		if (keylen >= 32 && keylen <= 64)
-			return 0;
-	} else if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_SHA384_HMAC) {
-		if (keylen == 48)
-			return 0;
-	} else if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_SHA512_HMAC) {
-		if (keylen == 64)
-			return 0;
-	} else if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_AES_GMAC) {
-		if (keylen >= 16 && keylen <= 32)
-			return 0;
-	}
-
-	if (crypto_xform->auth.algo == RTE_CRYPTO_AUTH_AES_XCBC_MAC &&
-	    keylen == ROC_CPT_AES_XCBC_KEY_LENGTH)
-		return 0;
-
-	return -ENOTSUP;
-}
-
-static inline int
-ipsec_xform_aead_verify(struct rte_security_ipsec_xform *ipsec_xform,
-			struct rte_crypto_sym_xform *crypto_xform)
-{
-	if (ipsec_xform->direction == RTE_SECURITY_IPSEC_SA_DIR_EGRESS &&
-	    crypto_xform->aead.op != RTE_CRYPTO_AEAD_OP_ENCRYPT)
-		return -EINVAL;
-
-	if (ipsec_xform->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS &&
-	    crypto_xform->aead.op != RTE_CRYPTO_AEAD_OP_DECRYPT)
-		return -EINVAL;
-
-	if (crypto_xform->aead.algo == RTE_CRYPTO_AEAD_AES_GCM ||
-	    crypto_xform->aead.algo == RTE_CRYPTO_AEAD_AES_CCM) {
-		switch (crypto_xform->aead.key.length) {
-		case 16:
-		case 24:
-		case 32:
-			break;
-		default:
-			return -EINVAL;
-		}
-		return 0;
-	}
-
-	return -ENOTSUP;
-}
-
-static inline int
-cnxk_ipsec_xform_verify(struct rte_security_ipsec_xform *ipsec_xform,
-			struct rte_crypto_sym_xform *crypto_xform)
-{
-	struct rte_crypto_sym_xform *auth_xform, *cipher_xform;
-	int ret;
-
-	if ((ipsec_xform->direction != RTE_SECURITY_IPSEC_SA_DIR_INGRESS) &&
-	    (ipsec_xform->direction != RTE_SECURITY_IPSEC_SA_DIR_EGRESS))
-		return -EINVAL;
-
-	if ((ipsec_xform->proto != RTE_SECURITY_IPSEC_SA_PROTO_ESP) &&
-	    (ipsec_xform->proto != RTE_SECURITY_IPSEC_SA_PROTO_AH))
-		return -EINVAL;
-
-	if ((ipsec_xform->mode != RTE_SECURITY_IPSEC_SA_MODE_TRANSPORT) &&
-	    (ipsec_xform->mode != RTE_SECURITY_IPSEC_SA_MODE_TUNNEL))
-		return -EINVAL;
-
-	if ((ipsec_xform->mode == RTE_SECURITY_IPSEC_SA_MODE_TUNNEL) &&
-	    (ipsec_xform->tunnel.type != RTE_SECURITY_IPSEC_TUNNEL_IPV4) &&
-	    (ipsec_xform->tunnel.type != RTE_SECURITY_IPSEC_TUNNEL_IPV6))
-		return -EINVAL;
-
-	if (crypto_xform->type == RTE_CRYPTO_SYM_XFORM_AEAD)
-		return ipsec_xform_aead_verify(ipsec_xform, crypto_xform);
-
-	if (ipsec_xform->proto == RTE_SECURITY_IPSEC_SA_PROTO_AH) {
-		if (ipsec_xform->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS) {
-			/* Ingress */
-			auth_xform = crypto_xform;
-			cipher_xform = crypto_xform->next;
-
-			if (crypto_xform->type != RTE_CRYPTO_SYM_XFORM_AUTH)
-				return -EINVAL;
-
-			if ((cipher_xform != NULL) && ((cipher_xform->type !=
-			    RTE_CRYPTO_SYM_XFORM_CIPHER) ||
-			    (cipher_xform->cipher.algo !=
-			    RTE_CRYPTO_CIPHER_NULL)))
-				return -EINVAL;
-		} else {
-				/* Egress */
-			if (crypto_xform->type == RTE_CRYPTO_SYM_XFORM_CIPHER) {
-				cipher_xform = crypto_xform;
-				auth_xform = crypto_xform->next;
-
-				if (auth_xform == NULL ||
-				    cipher_xform->cipher.algo !=
-				    RTE_CRYPTO_CIPHER_NULL)
-					return -EINVAL;
-			} else if (crypto_xform->type ==
-				   RTE_CRYPTO_SYM_XFORM_AUTH)
-				auth_xform = crypto_xform;
-			else
-				return -EINVAL;
-		}
-	} else {
-		if (crypto_xform->next == NULL)
-			return -EINVAL;
-
-		if (ipsec_xform->direction ==
-		    RTE_SECURITY_IPSEC_SA_DIR_INGRESS) {
-			/* Ingress */
-			if (crypto_xform->type != RTE_CRYPTO_SYM_XFORM_AUTH ||
-			    crypto_xform->next->type !=
-				    RTE_CRYPTO_SYM_XFORM_CIPHER)
-				return -EINVAL;
-			auth_xform = crypto_xform;
-			cipher_xform = crypto_xform->next;
-		} else {
-			/* Egress */
-			if (crypto_xform->type != RTE_CRYPTO_SYM_XFORM_CIPHER ||
-			    crypto_xform->next->type !=
-				    RTE_CRYPTO_SYM_XFORM_AUTH)
-				return -EINVAL;
-			cipher_xform = crypto_xform;
-			auth_xform = crypto_xform->next;
-		}
-
-		ret = ipsec_xform_cipher_verify(cipher_xform);
-		if (ret)
-			return ret;
-	}
-
-	return ipsec_xform_auth_verify(auth_xform);
-}
 #endif /* __CNXK_IPSEC_H__ */
diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 2f1fdf34fc..0682294099 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -785,6 +785,13 @@ cn10k_eth_sec_session_create(void *device,
 
 	ipsec = &conf->ipsec;
 	crypto = conf->crypto_xform;
+
+	rc = cnxk_ipsec_xform_verify(ipsec, crypto);
+	if (rc) {
+		plt_err("Crypto xform verify failed, rc=%d", rc);
+		return rc;
+	}
+
 	inbound = !!(ipsec->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS);
 	inl_dev = !!dev->inb.inl_dev;
 
diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index a5be85901f..65f0235a46 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -817,6 +817,13 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 
 	ipsec = &conf->ipsec;
 	crypto = conf->crypto_xform;
+
+	rc = cnxk_ipsec_xform_verify(ipsec, crypto);
+	if (rc) {
+		plt_err("Crypto xform verify failed, rc=%d", rc);
+		return rc;
+	}
+
 	inbound = !!(ipsec->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS);
 	inl_dev = !!dev->inb.inl_dev;
 
diff --git a/drivers/net/cnxk/cn9k_ethdev_sec.c b/drivers/net/cnxk/cn9k_ethdev_sec.c
index 5e13dc862e..4024b243d7 100644
--- a/drivers/net/cnxk/cn9k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn9k_ethdev_sec.c
@@ -602,6 +602,13 @@ cn9k_eth_sec_session_create(void *device,
 
 	ipsec = &conf->ipsec;
 	crypto = conf->crypto_xform;
+
+	rc = cnxk_ipsec_xform_verify(ipsec, crypto);
+	if (rc) {
+		plt_err("Crypto xform verify failed, rc=%d", rc);
+		return rc;
+	}
+
 	inbound = !!(ipsec->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS);
 
 	lock = inbound ? &dev->inb.lock : &dev->outb.lock;
-- 
2.43.0

