Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63357CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 08:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 601244021F;
	Thu, 28 May 2026 10:01:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1CC084014F;
 Thu, 28 May 2026 09:58:26 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S5XbdW3412522; Thu, 28 May 2026 00:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=N24nFMCStIpspaJ7o+aU5aN
 Gil2Nvse0tB/J7cDQnC8=; b=ZF8tFFJXjwGB1JHJDwHF/RQ9gjYGW9DfFHOMVzs
 UwdZBYbtl8npUj4iEwYDIZl7FPpRCswkZoG8Hgnbkmm3olOQENwH1BTwFUNhQCq3
 D0n7JXY3cDa0crtEDIPhjC1YH7ocTjBW9fuVHcKarlSXPnrGjqY/kJRPqxHOeUL2
 LOAqdo/jBDHC7f5WJ4WEKVZL1kwbeDajrxeMT6s6KClRyCZOAFwJ0eqAmdVkP9bx
 dzhVkfunUObL2ax+KhD0Nki6hjUrdZtWb1/Bu3ghx9PJcalP2qMPEPqEDcv22tOt
 Cjiunt4BMCWiNe6f3FBnyLAXfrDsYh/oY3twYcr/IK1sJ5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ee7wp9eqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 00:58:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 28 May 2026 00:58:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 28 May 2026 00:58:25 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id 3D4425C68E4;
 Thu, 28 May 2026 00:58:22 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <anoobj@marvell.com>, <gmuthukrishn@marvell.com>,
 <kai.ji@intel.com>, <stable@dpdk.org>
Subject: [PATCH] crypto/openssl: fix use-after-free bug and cleanup
Date: Thu, 28 May 2026 13:28:22 +0530
Message-ID: <20260528075822.2206494-1-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a17f5a2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=KKAkSRfTAAAA:8
 a=vggBfdFIAAAA:8 a=oCJs8q-oAAAA:8 a=wsvv8ueEjdeQH-pRDKAA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cvBusfyB2V15izCimMoJ:22
 a=qUF70SbvcHBaGhGVny9j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA3OSBTYWx0ZWRfX7A7WkXmf58Y9
 4Sp3s+ntzJnF4nN6Lr+IuOIMggnaF4dmWNZS6tmVMgNbwEO343m3FXE3jwVecNdDUSu4yu+S3PP
 6wvSPkxeJoMouAljLQ2mNjylf66F01HYXx1iThDDEq/2/7sNPVEgWuRKhes//T6YsDUos1+QbKL
 vfXygD3VUZGD6nMt7lhIc2bs4rdOtDaOYbVSk4DKUMLsiBLibE9sb2EBo5pwEKGoXfapXda5n5E
 I0LexfDW4BH8HWVEroYSyv7DWCmhIAdn6nz+pCE4xK5LU7dXPOh3GoGBDqnBmMYUTzAP2vO9w6I
 YLsu6W/SxO2FQDbJ7WxDTuhuoTlX7LcNWdWxPEkT6XFNkKiqyVd8vLbedZ2M0XDiMmPPflwWoPL
 HKMQFC3T72VVOZo4GO5l1rQxusZ+CrFHFXpXokbrqVmg8EaJQdOEwx0BtD1BmMncPujwsZLc4J0
 mlfVKEJZbeLJXp8eGBQ==
X-Proofpoint-GUID: I7bra43xw1SbAGVe_ZEM1V2VFeLQt28J
X-Proofpoint-ORIG-GUID: I7bra43xw1SbAGVe_ZEM1V2VFeLQt28J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Mailman-Approved-At: Thu, 28 May 2026 10:01:46 +0200
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
EVP_PKEY_decapsulate_init() causing a
use-after-free issue. Pass NULL to
EVP_PKEY_decapsulate_init() instead of params
to avoid it.

Add resource cleanup for all error paths in the ML-KEM
decapsulate handler and consolidate cleanup into
two goto labels err_pkey and err_decap.

Fixes: 5f761d7b60 ("crypto/openssl: support ML-KEM and ML-DSA")
Cc: stable@dpdk.org
Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
 .mailmap                                 |  1 +
 drivers/crypto/openssl/rte_openssl_pmd.c | 30 +++++++++++-------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4f93307aed..031becba8c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1929,3 +1929,4 @@ Zoltan Kiss <zoltan.kiss@schaman.hu> <zoltan.kiss@linaro.org>
 Zorik Machulsky <zorik@amazon.com>
 Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
 Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
+Pratik Senapati <psenapati@marvell.com>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 4f171f48cc..5bc51b8f0f 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -3683,38 +3683,29 @@ mlkem_decap_op_evp(struct rte_crypto_op *cop,
 	}
 
 	cctx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);
-	if (cctx == NULL) {
-		EVP_PKEY_free(pkey);
-		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
-	}
+	if (cctx == NULL)
+		goto err_pkey;
 
-	if (EVP_PKEY_decapsulate_init(cctx, params) != 1) {
+	if (EVP_PKEY_decapsulate_init(cctx, NULL) != 1) {
 		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-		return -1;
+		goto err_decap;
 	}
 
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
@@ -3724,6 +3715,13 @@ mlkem_decap_op_evp(struct rte_crypto_op *cop,
 	ret = 0;
 	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
 	return ret;
+
+err_decap:
+	EVP_PKEY_CTX_free(cctx);
+err_pkey:
+	EVP_PKEY_free(pkey);
+	cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+	return -1;
 }
 
 static int
-- 
2.43.0

