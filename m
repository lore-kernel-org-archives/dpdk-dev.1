Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA2C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 14:31:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E331240156;
	Sun, 16 Feb 2025 15:31:13 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7405D40150;
 Sun, 16 Feb 2025 15:31:12 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GDvQs3029925;
 Sun, 16 Feb 2025 06:31:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=HfxV8cytlPF72gH0r2DsboB
 CfllX2uCROGSOkJB4VaQ=; b=PkJc7gdMY3eOb0q7oxJhH+waPlvySjPltyzISb0
 rwAic0rX8AbzEV1r8O/u3cn/uDyLbWT5+8QCm7ROfVDqA/4GrJxoJNdFxlJgpfhF
 Z1T4EbGHl3/ToQVQZsOROSXQciNWHdEf/XCnSqL9SUUrYCF2pTzl/3QfgeBbNYHk
 WxoJCjucrMXow8Vh4V4fAvIoEDxxrDXYvly2ImBaO75fazlBDS19zB3Ecnk96wnY
 0ueOKIardDqdGk9GL6Ovn9I7ofrcVH7iPGuUNaZRtH5B3EejRUWeS3xudXf/Ea2n
 6eIyppBFvi6sd3oVhIan1xAFioO+5pBXe54Tkw0vafB9K7w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ug2bg465-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2025 06:31:11 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 16 Feb 2025 06:31:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 16 Feb 2025 06:31:10 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.24])
 by maili.marvell.com (Postfix) with ESMTP id 792A43F7057;
 Sun, 16 Feb 2025 06:31:07 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Kai Ji
 <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] crypto/openssl: validate incorrect signature in verify op
Date: Sun, 16 Feb 2025 19:58:19 +0530
Message-ID: <20250216142822.1508-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9PJrSnnnn_xdu9Vi1CtAI70HKC0xCDwR
X-Proofpoint-ORIG-GUID: 9PJrSnnnn_xdu9Vi1CtAI70HKC0xCDwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_05,2025-02-13_01,2024-11-22_01
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
 drivers/crypto/openssl/rte_openssl_pmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index b090611bd0..239688ed47 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -2710,6 +2710,8 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 		return ret;
 	}
 
+	cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+
 	switch (op->rsa.op_type) {
 	case RTE_CRYPTO_ASYM_OP_ENCRYPT:
 		if (EVP_PKEY_encrypt_init(rsa_ctx) != 1)
@@ -2807,6 +2809,7 @@ process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
 				op->rsa.sign.data,
 				op->rsa.sign.length) <= 0) {
 			OPENSSL_free(tmp);
+			ret = 0;
 			goto err_rsa;
 		}
 
-- 
2.25.1

