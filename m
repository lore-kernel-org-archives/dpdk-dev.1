Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDB3C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 08:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEF6B42792;
	Thu,  3 Sep 2026 10:27:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 192D442793
 for <dev@dpdk.org>; Thu,  3 Sep 2026 10:27:24 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6835nflk159164; Thu, 3 Sep 2026 01:27:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
 wiLUktek4RFdldLZN9BmksaTwhfz52D9UTv0umVTiQ=; b=eotD9qba4SQsH2pOT
 jhGr/52pzUFBdEw6tnDt7mSUdq0k/GDUQty22m2f/XoRFbQ3UbOCJQVBWpwSljR1
 AEiJn17He5LYddgyrSWT2dot9sVxDE1oVsP76Tw1o9pI5x/g3Es1jKECozFueTCn
 JALC2XR69AWHBxdop3P7+7yCD3aSQt1rjjMJod3dAzxyTFbjfgDnJKMuQ+sDOcEk
 Ty0ejDRDeUV9wLVr5H6xfxx7oZlt6JWTkMVbgF5iDKW4QrwDXBpWNfw6Eiof7af+
 Fbu7reURdNkfx3jrmnFkyhm1mr9+8e6le9+vTeJIcnuqtQotZrJnweZhzvB88GFn
 CPOmg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gegb63rqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 01:27:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 01:27:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 01:27:22 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 5D82C3F7068;
 Thu,  3 Sep 2026 01:27:19 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v2 4/8] crypto/openssl: advertise RSA padding and hash
 capabilities
Date: Thu, 3 Sep 2026 08:26:44 +0000
Message-ID: <20260903082648.3610676-5-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903082648.3610676-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
 <20260903082648.3610676-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX4WRV9JyH4SqR
 zjAP4uKOjDP8qlPjVQ/x/xnbwTgsHtwCBGKp62rOROW7+WWcl7UdlTq6JXflL+uWgz5rhshEYp8
 UcjhS7tVfyr8HJ60NRNvl8gyuQCFqgUB177X3xyghgj9Z0muuA4LtrvaWVKl+oo5WaO9fAko32w
 h7B0Aqr5Oi16xHLuJ7l0cTChL3JENbKNit/aegC1oONafFraaU/M7e+Yp89Ls/uJ/OLfQS1HNDb
 HEGUpeJtQ5ECBx86X832NOW6YqK8X3EU4XhWETpXcDDJ3mLs22Lj5j1gL1t9UXCLm1ka/3SZhlT
 orJw2mIoI1DP/MokTM/Ab2Zv0ZCZkc0Q9oi1yMoy+udT3uSMtgOKJKW+ATLqBr69MuhCa1+ZOXj
 jFU2ow8dLCTYygczMKc4EiyFr1QN441De2VsV/KSCZuBWGKIfVcpjT23HsSt0Z0JSY3dbHBz+4y
 vrlxI1eThHEqCz2DVPw==
X-Proofpoint-GUID: iS8z1GlB-sxoFnBYScv2qXgZLwbBIJpH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX886qChE+/6+P
 WBa7dVA+HxU63KrKNYx3LIdKOwfIS64skpgamAgb1bhaxNW+Jkm+5KSxcxmqwO/aqxnP10Xra8A
 r9azCKgWQiN0RCqoEKMIrxC7lMz9y1Y=
X-Authority-Analysis: v=2.4 cv=GpJyPE1C c=1 sm=1 tr=0 ts=6a992f6b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=bt2ItxIhNOdH_RBkUzcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: iS8z1GlB-sxoFnBYScv2qXgZLwbBIJpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
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

Extend the OpenSSL PMD RSA asymmetric capability to use rsa_capa
and report supported padding schemes, primary hash algorithms,
and MGF1 hash algorithms.

For OpenSSL 3.0 and later, advertise OAEP padding along with
SHA-1, SHA-2, and SHA-3 digests for both primary hash and MGF1.
For older OpenSSL versions, advertise only NONE and PKCS#1 v1.5
padding modes supported by the PMD.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 26 ++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index d927cc5228..60d33f3474 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -731,14 +731,36 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 					(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
 					(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
 					(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
-				{
+				.rsa_capa = {
 				.modlen = {
 				/* min length is based on openssl rsa keygen */
 				.min = 30,
 				/* value 0 symbolizes no limit on max length */
 				.max = 0,
 				.increment = 1
-				}, }
+				},
+				.pad_types = ((1 << RTE_CRYPTO_RSA_PADDING_NONE) |
+					(1 << RTE_CRYPTO_RSA_PADDING_PKCS1_5) |
+					(1 << RTE_CRYPTO_RSA_PADDING_OAEP)),
+				.mgf1_hash_algos = (RTE_BIT64(RTE_CRYPTO_AUTH_SHA1) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA224) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA256) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA384) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA512) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA3_224) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA3_256) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA3_384) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA3_512)),
+				},
+				.hash_algos = (RTE_BIT64(RTE_CRYPTO_AUTH_SHA1) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA224) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA256) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA384) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA512) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA3_224) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA3_256) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA3_384) |
+					RTE_BIT64(RTE_CRYPTO_AUTH_SHA3_512)),
 			}
 		},
 		}
-- 
2.54.0

