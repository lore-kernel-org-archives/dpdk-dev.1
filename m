Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E152EC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:24:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 120B7402E9;
	Mon, 31 Aug 2026 12:24:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DE6F2402E9
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:24:05 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V86WsR852258; Mon, 31 Aug 2026 03:24:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 MzPuMc7oy3ZPByI23AgD+2pkypB0yh32p9sMLND6z4=; b=XjKM+/DI2CPrG8P9X
 vv3NC1tWmVUNgWZ2o2OFDR20V7NTE1AXEM521f5hvHIB1js0F5Bsy3rdI+lQxm5Z
 exnYeehdq/o4aIl0jJM4Q/IeQ97/FquQJHVaSiF3y/IBLRWFx2P0n1Agv6+BiRtn
 VqaJWB+/6AjHOvzThzaQ6n8PSP5pImOMUh9QlwuneewVpjMOOefutvPPsJ8fejds
 P/f3lZZKmS+oteSq4U7VqnYIIqmpuAG7z43KrxajHShGLagR9ltqeo1ikjPtnXVG
 UMM0GGq1r7UqZ1BJccfDKpV+Ys0CT/TbhDlcCuhT/woIzBmc5m4mo3HWqRHUWZZz
 BBreg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbxxj3kv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:24:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:24:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:24:04 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 173343F704C;
 Mon, 31 Aug 2026 03:24:00 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 06/10] crypto/openssl: advertise RSA padding and hash
 capabilities
Date: Mon, 31 Aug 2026 10:23:24 +0000
Message-ID: <20260831102328.2813604-7-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX+/nU5vc1ryNj
 3VMOSS6mmLrQOIfV1w5YM1+CwzTcxsmr+aNyBZcaW8b4qc1pSXJl8c8lqBXU6KCkIo3+KqsVBct
 q45/PIn7CUbdM+lLAQxHgPZMsw4smrc=
X-Proofpoint-GUID: M6A8ASum3mK07-f9Z9db4cWOouiCUdxE
X-Proofpoint-ORIG-GUID: M6A8ASum3mK07-f9Z9db4cWOouiCUdxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfXxzWvZr0caTWp
 EonSXqxeFmq386mhLBEzTt8ZaDJAytCNhxmUFSCE1x4c2KUyVeR+GnlA0rwr/ulc71KzEq1eKOa
 ghwaMpYw2y+0x+pX9rDV013gjCTQGSbylvp0PcXz7D1GKv4pgMxSQmx2EHNkCVJ62+kBe+Uc+Tn
 9m1nH1FwtYPjigEmFAdJXARgw0/f3uazGPJmiRlVOuuWyRGVQBWxYvvWKT5SEGg2br4mOp5zTpr
 tXPAnQ1CwtAHpBsQWUTn67ZIyvpy/2AWGIQzTgt8CrjecRT2AT6R8N9t+D+cc/FwJX/aISzlnX2
 EcCAc+Qmf5U+xdwpSO8JsHtF3PXrXWHIVzGsNeVbCf+VYMTmCjigrSFhK5xHGU0TB5lerRVoO5Q
 rfxJmc2yEx0BF4FWsapG2RlB8HCLhHX5mipPR146VtI0E6bhhvp2+MmlWQumRYx422MmDIcVIUs
 TrPtH4Qn+VfQUdd7oVA==
X-Authority-Analysis: v=2.4 cv=QuJuG1yd c=1 sm=1 tr=0 ts=6a955645 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=UPZDziovfScicRDyQkcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
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
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 32 ++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index d927cc5228..33134573e5 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -731,14 +731,42 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
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
+#if (OPENSSL_VERSION_NUMBER >= 0x30000000L)
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
+#else
+				.pad_types = ((1 << RTE_CRYPTO_RSA_PADDING_NONE) |
+					(1 << RTE_CRYPTO_RSA_PADDING_PKCS1_5)),
+				},
+#endif
 			}
 		},
 		}
-- 
2.54.0

