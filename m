Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495CBCA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 798BC40279;
	Fri,  9 Oct 2026 13:36:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5496D40274
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:36:47 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998Iuo82295928; Fri, 9 Oct 2026 04:36:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=3n4HFv9zOqpI0iZjZOWoQyx
 JqZOCWilT6He9bc8b8AA=; b=YMUOmXUE4w0DzMFpLugFsli6Em3BtVb23Le7dIA
 bf7YnxSrztq8x6S44kmqiCf/vtYClz75arIEuTAyLMy66aOxRlxV69cdl+jkktwG
 2Gf2DB2PAqHSnttSBGXGqGKWc2w1C7sKr0C9NAiT63XNfRVc9aBwzlOhpri6V9P9
 7/zkDyl53LldbZ4m2YmqGPQgsMyxnNyDQcJ+8Bap5cMSFjOBjArdfo0nPvb3YVS3
 +kIu7UkoQeZkRDEaRy+7l7sWaEBj6uMTDehbmGSr1PkBCMCqg/Af2oUF3rBopVkO
 /Elh83j0+VAITWsiZyhEAEapY9Y7dN+Sy9wP/a78xDmqroA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h68dhnusm-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 04:36:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Oct 2026 04:36:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Oct 2026 04:36:44 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 113805B6933;
 Fri,  9 Oct 2026 04:36:40 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH] crypto/cnxk: improve RSA private key validation
Date: Fri, 9 Oct 2026 11:36:29 +0000
Message-ID: <20261009113629.2597960-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=U+IHnuru c=1 sm=1 tr=0 ts=6ac8d1ce cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=eaxBnfHGimJaXI9AQbIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX0btaFGQ0KwoV
 sAH0mcozFhm7LvVR11SiCCjwA725eqHTYn7vg5KXTEYkyl/sH8WD6TInc+TpTTMb2oJCe39uhck
 yFt7oYo6SwrQPEy42JtdASNprXl0W0Y=
X-Proofpoint-ORIG-GUID: TwztMlyWfD_1zvsZc2P5iKDypcMIqTkv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX2+8n6oMjEhmY
 SHOy3kL4/jLVFaEUNHZA3mmXO1DDmFgeWpYQCUDXWkdItkopBSGOwXaGRKwAtLd9YEDotricMwo
 A4DcagGsaujH7kEXV767zoFR0DzuVqUSAXpwrSp5KBefRtThKHuHGTRk1iw8XSpwQJso9A2F4kt
 m0otEfYVycybsXUvlJcBUkFxRRIKEt3yqFg+3Jl+dCkyUG8VywKSUeD2IkrQfA/1s3290yh2/O3
 9taNrkMe7jA8xB3BGmPPWUnLsFOj4P3vfbHJBMQqm0jiTt5aqOVWk7CEN/yXa0T5WDRxZu0a3+3
 NAh+CnQOIAiPP+Axy6Ixh2BAiX5derMxojgbkuhvCv33+zL8e1FQnr3rqmbMLmyLSixAhA+Y47u
 Mnm3RQVbdS0Hag10h3XejEkArL1cYOyTyKDfq8WvDWgY6TUVYWobzXGDWVFUmrNwPVoQEBfY1po
 6oPU0d7BZQkboTZPkzg==
X-Proofpoint-GUID: TwztMlyWfD_1zvsZc2P5iKDypcMIqTkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
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

Add upfront RSA modulus length validation and reject zero-length or
unsupported modulus sizes. Validate CRT key component pointers and
lengths, validate private exponent length, and derive the actual CRT
key size from component lengths instead of relying solely on modulus
size.

Also round up the half-modulus bound used for CRT parameters so
odd-length moduli do not incorrectly reject valid factors.

These checks ensure RSA key material fits within CNXK hardware limits,
prevent invalid parameter acceptance, and avoid potential NULL pointer
dereferences.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_ae.h | 59 ++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index f2aa5d5a2e..b94f5de769 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -19,6 +19,17 @@
 
 #define CNXK_AE_EDDSA_MAX_PARAM_LEN 1024
 
+/*
+ * Maximum RSA modulus length (in bytes) supported by CNXK hardware. Must
+ * match CNXK_CPT_MAX_ASYM_OP_MOD_LEN in cnxk_cryptodev_ops.c and the
+ * modlen.max capability advertised in cnxk_cryptodev_capabilities.c. The
+ * per-op scratch buffer (CNXK_CPT_MAX_ASYM_OP_NUM_PARAMS *
+ * CNXK_CPT_MAX_ASYM_OP_MOD_LEN) that cnxk_ae_rsa_crt_prep()/
+ * cnxk_ae_rsa_exp_prep() write into is sized against this limit, so RSA
+ * key material must be rejected up front if it exceeds it.
+ */
+#define CNXK_AE_RSA_MAX_MODLEN 1024
+
 struct cnxk_ae_sess {
 	uint8_t rte_sess[ASYM_SESS_SIZE];
 	enum rte_crypto_asym_xform_type xfrm_type;
@@ -135,23 +146,55 @@ cnxk_ae_fill_rsa_params(struct cnxk_ae_sess *sess,
 	size_t mod_len = xfrm_rsa->n.length;
 	size_t exp_len = xfrm_rsa->e.length;
 	uint64_t total_size;
+	size_t max_len;
 	size_t len = 0;
 
+	/* Bound n/e against CNXK's RSA capability and require valid data,
+	 * since they're used unconditionally below.
+	 */
+	if (mod_len > CNXK_AE_RSA_MAX_MODLEN || exp_len == 0 || exp_len > CNXK_AE_RSA_MAX_MODLEN ||
+	    xfrm_rsa->n.data == NULL || xfrm_rsa->e.data == NULL)
+		return -EINVAL;
+
 	/* Set private key type */
 	rsa->key_type = xfrm_rsa->key_type;
 
 	if (rsa->key_type == RTE_RSA_KEY_TYPE_QT) {
-		if (qt.p.length != 0 && qt.p.data == NULL)
+		/* Round up so an odd-length modulus doesn't reject a legitimately
+		 * sized factor (mod_len/2 alone truncates down).
+		 */
+		max_len = (mod_len + 1) / 2;
+
+		/*
+		 * Each quintuple component (q, dQ, p, dP, qInv) is independently
+		 * caller-controlled and copied with its own length, so every one of
+		 * them must be bounds-checked individually against mod_len/2 -
+		 * relying on qt.p.length alone is not sufficient.
+		 */
+		if (qt.p.length == 0 || qt.p.length > max_len || qt.p.data == NULL ||
+		    qt.q.length == 0 || qt.q.length > max_len || qt.q.data == NULL ||
+		    qt.dP.length == 0 || qt.dP.length > max_len || qt.dP.data == NULL ||
+		    qt.dQ.length == 0 || qt.dQ.length > max_len || qt.dQ.data == NULL ||
+		    qt.qInv.length == 0 || qt.qInv.length > max_len || qt.qInv.data == NULL)
 			return -EINVAL;
 
-		/* Make sure key length used is not more than mod_len/2 */
-		if (qt.p.data != NULL)
-			len = (((mod_len / 2) < qt.p.length) ? 0 : qt.p.length * 5);
+		/* Total size is the actual sum of the quintuple component lengths */
+		len = qt.q.length + qt.dQ.length + qt.p.length + qt.dP.length + qt.qInv.length;
 	} else if (rsa->key_type == RTE_RSA_KEY_TYPE_EXP) {
-		if (d.length != 0 && d.data == NULL)
+		/*
+		 * d is optional here: RTE_RSA_KEY_TYPE_EXP also covers
+		 * public-only (encrypt/verify) transforms that supply just
+		 * n/e, which cnxk_ae_rsa_prep() uses without ever reading d.
+		 * When a private exponent is supplied, bound it and require
+		 * its data.
+		 */
+		if (d.length > mod_len || (d.length != 0 && d.data == NULL))
 			return -EINVAL;
 
 		len = d.length;
+	} else {
+		/* Reject unknown key_type instead of silently treating it as EXP. */
+		return -EINVAL;
 	}
 
 	/* Total size required for RSA key params(n,e,(q,dQ,p,dP,qInv)) */
@@ -174,8 +217,7 @@ cnxk_ae_fill_rsa_params(struct cnxk_ae_sess *sess,
 		rsa->qt.dQ.data = rsa->qt.q.data + qt.q.length;
 		memcpy(rsa->qt.dQ.data, qt.dQ.data, qt.dQ.length);
 		rsa->qt.p.data = rsa->qt.dQ.data + qt.dQ.length;
-		if (qt.p.data != NULL)
-			memcpy(rsa->qt.p.data, qt.p.data, qt.p.length);
+		memcpy(rsa->qt.p.data, qt.p.data, qt.p.length);
 		rsa->qt.dP.data = rsa->qt.p.data + qt.p.length;
 		memcpy(rsa->qt.dP.data, qt.dP.data, qt.dP.length);
 		rsa->qt.qInv.data = rsa->qt.dP.data + qt.dP.length;
@@ -189,7 +231,8 @@ cnxk_ae_fill_rsa_params(struct cnxk_ae_sess *sess,
 	} else if (rsa->key_type == RTE_RSA_KEY_TYPE_EXP) {
 		/* Private key in exponent format */
 		rsa->d.data = rsa->e.data + exp_len;
-		memcpy(rsa->d.data, d.data, d.length);
+		if (d.data != NULL)
+			memcpy(rsa->d.data, d.data, d.length);
 		rsa->d.length = d.length;
 	}
 	rsa->n.length = mod_len;
-- 
2.54.0

