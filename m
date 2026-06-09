Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A6CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 07:02:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A85E34066C;
	Tue,  9 Jun 2026 09:02:34 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B7A1D402AD;
 Tue,  9 Jun 2026 07:53:31 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65941nC93963465; Mon, 8 Jun 2026 22:53:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=LSeER0xbEA4y04Ne7RsO1s8
 L4a3dPmbqlqUpUqbw9L8=; b=i6G8QyHThTvVpPNT9NqHSOIXnSTDJr/Yt9WTUcC
 6kFZm8PWBq4POXVn0+fKJf9qar5KiawbWUuFMBJEfRi5AriG4tyiaXdDAeuoFTi7
 d21DQCbeWgupHlRIKnaVAlFI+nLFhb7m0xV484JOBrr/7ZUmALxRKmqWhpwAmS7O
 +zKUtcwK1s3ohNcBPGnx7bXRh3Lo81EcbhUHjHI8epKlRxqewnm5+CahQ8r/yNwu
 WhWav4WQcWePWN5oP5oq/GoqOIqHv7wVkIHGURFB1PWv4vMmT6L7AdpP0ra3n8Zq
 8SYAF+Nkk5nV95cdhkckdY2wQZzsqQJ86sn3/qcIdAgAVtQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8y7vs-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 22:53:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 22:53:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 22:53:04 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id 350D63F7066;
 Mon,  8 Jun 2026 22:53:02 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <kai.ji@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2] crypto/openssl: fix use-after-free bug and cleanup
Date: Tue, 9 Jun 2026 11:23:02 +0530
Message-ID: <20260609055302.1539202-1-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA1MSBTYWx0ZWRfX9WDQGat7nOUF
 MHE5knQicaFcxd+oBTv0ABiqRAvMd9DyxdIDSJMn99y5pX1nQER266R8CqhSEH0lSm7BhbytxAL
 2H/i/zEmGd3uQOiHaBEVrb2bAQw7NSEFOrk6yj7RkEfpCX9in5/nVOnp60oJtB1EuUluktAzlAp
 qSM7KXlv/6UWyxCV6NL8VitHA/qaIY5hTVVHyGYvIFe5F/TsIkMD7F2CqQzkYvmrNNDx38FdFuD
 lcFMwrNaYQvSHM1SJxMHKZ8S+qAgU5lDMd2AY9fIxhV1WeFxlTRmRdvh9arAUeW3GDWnPQw+wH+
 A0wrmUACcL2F6F8IqDasgZMe8W5JDG/a76+ZBMcsJLfN4BihdRV6Za3L7i9otC+37XtYCHzxJtb
 CZhOhvzchO2Z9zmSylZS+IxChtLFqhqYYPg9Hr+F58nrqzpp5RYczlUXikqSUzQT+c3jErpeEY8
 8eiowxm0pYQosKv+Fvg==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a27aa5a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=8AirrxEcAAAA:8
 a=DKgGA1gkAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8
 a=8tmNlDvhGHEp1ApXqeoA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=ST-jHhOKWsTCqRlWije3:22 a=bw8UsnbkUxisP6t34tfg:22
X-Proofpoint-ORIG-GUID: tNy1CoefVf_CRXxLdf-Ov_L3sVi8QjoW
X-Proofpoint-GUID: tNy1CoefVf_CRXxLdf-Ov_L3sVi8QjoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Mailman-Approved-At: Tue, 09 Jun 2026 09:02:31 +0200
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

params is freed before it is used by
EVP_PKEY_decapsulate_init()
causing a use-after-free issue.

Pass NULL to EVP_PKEY_decapsulate_init()
instead of params to avoid it.

Add resource cleanup for all error paths in the
ML-KEM decapsulate and encapsulate handlers.

Consolidate cleanup into multiple goto labels;
err_decap, err_pkey, err_params for decap and
err_encap, err_pkey, err_params for encap.

Fixes: 5f761d7b605e ("crypto/openssl: support ML-KEM and ML-DSA")
Cc: stable@dpdk.org

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
 .mailmap                                 |   1 +
 drivers/crypto/openssl/rte_openssl_pmd.c | 124 +++++++++--------------
 2 files changed, 47 insertions(+), 78 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4f93307aed..b6f47c10b9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1287,6 +1287,7 @@ Prashant Gupta <prashant.gupta_3@nxp.com>
 Prashant Upadhyaya <prashant.upadhyaya@aricent.com> <praupadhyaya@gmail.com>
 Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
+Pratik Senapati <psenapati@marvell.com> 
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
 Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 4f171f48cc..7464884fb2 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -3537,35 +3537,24 @@ mlkem_encap_op_evp(struct rte_crypto_op *cop,
 		return -1;
 	}
 
-	if (EVP_PKEY_fromdata_init(pctx) != 1) {
-		OSSL_PARAM_free(params);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+	cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
 
-	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_PUBLIC_KEY, params) != 1) {
-		OSSL_PARAM_free(params);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
-	OSSL_PARAM_free(params);
+	if (EVP_PKEY_fromdata_init(pctx) != 1)
+		goto err_params;
 
-	if (pkey == NULL) {
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_PUBLIC_KEY, params) != 1)
+		goto err_params;
+
+	if (pkey == NULL)
+		goto err_params;
 
 	cctx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);
-	if (cctx == NULL) {
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+	if (cctx == NULL)
+		goto err_pkey;
 
-	if (EVP_PKEY_encapsulate_init(cctx, NULL) != 1) {
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+
+	if (EVP_PKEY_encapsulate_init(cctx, NULL) != 1)
+		goto err_encap;
 
 	if (op->encap.message.length) {
 		const OSSL_PARAM kem_params[] = {
@@ -3574,49 +3563,42 @@ mlkem_encap_op_evp(struct rte_crypto_op *cop,
 			OSSL_PARAM_END
 		};
 
-		if (EVP_PKEY_encapsulate_init(cctx, kem_params) != 1) {
-			EVP_PKEY_free(pkey);
-			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-			return -1;
-		}
+		if (EVP_PKEY_encapsulate_init(cctx, kem_params) != 1)
+			goto err_encap;
 	}
 
 	if (EVP_PKEY_encapsulate(cctx, NULL, &outlen, NULL, &keylen) != 1) {
 		OPENSSL_LOG(ERR, "Failed to determine output length");
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
+		goto err_encap;
 	}
 
 	if (outlen > op->encap.cipher.length) {
 		OPENSSL_LOG(ERR, "Insufficient buffer for cipher text");
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
+		goto err_encap;
 	}
 
 	if (keylen > op->encap.sk.length) {
 		OPENSSL_LOG(ERR, "Insufficient buffer for shared key");
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
+		goto err_encap;
 	}
 
 	if (EVP_PKEY_encapsulate(cctx, op->encap.cipher.data, &outlen,
 			op->encap.sk.data, &keylen) != 1) {
 		OPENSSL_LOG(ERR, "Failed to encapculate");
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
+		goto err_encap;
 	}
 
 	op->encap.cipher.length = outlen;
 	op->encap.sk.length = keylen;
+	ret = 0;
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
 
+err_encap:
 	EVP_PKEY_CTX_free(cctx);
+err_pkey:
 	EVP_PKEY_free(pkey);
-	ret = 0;
-	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+err_params:
+	OSSL_PARAM_free(params);
 	return ret;
 }
 
@@ -3664,65 +3646,51 @@ mlkem_decap_op_evp(struct rte_crypto_op *cop,
 		return -1;
 	}
 
-	if (EVP_PKEY_fromdata_init(pctx) != 1) {
-		OSSL_PARAM_free(params);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+	cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
 
-	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_PRIVATE_KEY, params) != 1) {
-		OSSL_PARAM_free(params);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
-	OSSL_PARAM_free(params);
+	if (EVP_PKEY_fromdata_init(pctx) != 1)
+		goto err_params;
 
-	if (pkey == NULL) {
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_PRIVATE_KEY, params) != 1)
+		goto err_params;
+
+	if (pkey == NULL)
+		goto err_params;
 
 	cctx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);
-	if (cctx == NULL) {
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+	if (cctx == NULL)
+		goto err_pkey;
 
-	if (EVP_PKEY_decapsulate_init(cctx, params) != 1) {
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+	if (EVP_PKEY_decapsulate_init(cctx, NULL) != 1)
+		goto err_decap;
 
 	if (EVP_PKEY_decapsulate(cctx, NULL, &keylen,
 		op->decap.cipher.data, op->decap.cipher.length) != 1) {
 		OPENSSL_LOG(ERR, "Failed to determine output length");
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
+		goto err_decap;
 	}
 
 	if (keylen > op->decap.sk.length) {
 		OPENSSL_LOG(ERR, "Insufficient buffer for shared key");
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
+		goto err_decap;
 	}
 
 	if (EVP_PKEY_decapsulate(cctx, op->decap.sk.data, &keylen,
 			op->decap.cipher.data, op->decap.cipher.length) != 1) {
 		OPENSSL_LOG(ERR, "Failed to decapsulate");
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
+		goto err_decap;
 	}
 
 	op->decap.sk.length = keylen;
+	ret = 0;
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
 
+err_decap:
 	EVP_PKEY_CTX_free(cctx);
+err_pkey:
 	EVP_PKEY_free(pkey);
-	ret = 0;
-	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+err_params:
+	OSSL_PARAM_free(params);
 	return ret;
 }
 
-- 
2.43.0

