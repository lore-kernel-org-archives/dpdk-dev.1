Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E105DC021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:05:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C87B2402CC;
	Fri, 21 Feb 2025 18:05:37 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 27843402BB;
 Fri, 21 Feb 2025 18:05:36 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8OXDQ019414;
 Fri, 21 Feb 2025 09:05:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 u9eCq1Jaen5vY6yDxjhTQzoyrt62gjzQDmnf97bBmw=; b=dMJU2CBlMgwl5lOon
 TZIBdppFjv5I/hhasnjTv8pzFPOQ/LOmlRznztTSWfj6nFlt1+X3VveV0xjHix50
 /+OPXI3Bxbm6feW9IlsCPXgzolYuTrv3/1tWk0/4/RNKxTWfegyOg+cs7GDsIo9b
 p2+IoBIWo5nvdhDPikcmC5qYM59K013c/hXC5v+DzGpMmIFgrAFM69At6V/AMRoM
 UFzl68DdTf8U8FI0v0dyxaH7Az8wcr73GC3+aN3q+eNSDQBUFqFcweRVhZdAX99U
 5yrCdHxRyd7ykI6hSTVvSzDBkjDepl0c0Jqti8SJCsKJEFwxuhkymPZrvbAsa7YT
 WA9bw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44xnxu8ygq-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:05:35 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:05:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:05:11 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id F053C5B6938;
 Fri, 21 Feb 2025 09:05:08 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Kai Ji
 <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2] crypto/openssl: validate incorrect signature in verify op
Date: Fri, 21 Feb 2025 22:35:01 +0530
Message-ID: <20250221170504.1578-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250216142822.1508-1-gmuthukrishn@marvell.com>
References: <20250216142822.1508-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Af8Z_T7o26Q409MjOqMIW1whZRR_uJcK
X-Proofpoint-ORIG-GUID: Af8Z_T7o26Q409MjOqMIW1whZRR_uJcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
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

Return correct error status when incorrect signature is
used in RSA verify op.

Fixes: d7bd42f6db19 ("crypto/openssl: update RSA routine with 3.0 EVP API")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v2:
 - added comments.
---
 drivers/crypto/openssl/rte_openssl_pmd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index b090611bd0..5bfad92b7c 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -2803,9 +2803,15 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 			goto err_rsa;
 		}
 
-		if (EVP_PKEY_verify_recover(rsa_ctx, tmp, &outlen,
+		ret = EVP_PKEY_verify_recover(rsa_ctx, tmp, &outlen,
 				op->rsa.sign.data,
-				op->rsa.sign.length) <= 0) {
+				op->rsa.sign.length);
+		if (ret <= 0) {
+			/* OpenSSL RSA verification returns one on
+			 * successful verification, otherwise 0. Hence,
+			 * this enqueue operation should succeed even if
+			 * invalid signature has been requested in verify.
+			 */
 			OPENSSL_free(tmp);
 			goto err_rsa;
 		}
-- 
2.25.1

