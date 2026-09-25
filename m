Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B7C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:15:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C59CC40DD3;
	Fri, 25 Sep 2026 10:15:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CC95240DD3
 for <dev@dpdk.org>; Fri, 25 Sep 2026 10:15:50 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4ZxUu810215; Fri, 25 Sep 2026 01:15:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
 wiLUktek4RFdldLZN9BmksaTwhfz52D9UTv0umVTiQ=; b=AY2wI60CjhAzFfazQ
 jd1ZAs7mShdzIfw/A5K5mykAzqe0cBiklgJeU+QMvgpfyvKD0IJUv732vesre7hy
 lnoGutsyYvLnYTNrg/80O1tDRA0fC2kY1lYyrOpyyxuABr8nYChxkK4eTQmueh4M
 vfmpt8BPOreCv+MrYeam/4JUX8Scgrbl/KymvPVBQMN2FKvVJ2GLc+eO3D/jgvRH
 UjG2mMiz+xKznl3cQDRxLlVdgrKE4r4tyvqJOYxiIRX3zwJAyVpTjKIbuOulWZHC
 yH80UyAl/wiz6a/oR4nuDOXoglOl90Oh+ePDu7ExQn4A1nZJpVeCs2EMBegLri7q
 jjv+w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gw5q7mu0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:15:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Sep 2026 01:15:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 25 Sep 2026 01:15:48 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id E67765B6954;
 Fri, 25 Sep 2026 01:15:44 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v3 4/8] crypto/openssl: advertise RSA padding and hash
 capabilities
Date: Fri, 25 Sep 2026 08:14:56 +0000
Message-ID: <20260925081500.3848187-5-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925081500.3848187-1-ssarananaga@marvell.com>
References: <20260903082648.3610676-1-ssarananaga@marvell.com>
 <20260925081500.3848187-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=e6CT2qp/ c=1 sm=1 tr=0 ts=6ab62db5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=bt2ItxIhNOdH_RBkUzcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX9rNhujMFhKjv
 HXi/QHJNQaNq+rsJlhWIdn1buvnHay5QNU1FJVhGPKtnszG/FE9Tw3V3B72Rg3QgxFtnsWbuDQS
 3oD3Qt3mp7Qz3CyBqOXJX+4W7F3Bc1A=
X-Proofpoint-ORIG-GUID: 4dDtqgl-HDQX61RL4nale-7xYu8q6MNS
X-Proofpoint-GUID: 4dDtqgl-HDQX61RL4nale-7xYu8q6MNS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX2VlJ/04kdmyy
 lvdFEVmadsu+sLxFqn9BcJr3TfcnoYZZiZFqNiI7lfRfuDf0aUUX4Cl+tJ7EsUOFyBcAQPbTvqo
 BMO+8ZIeC8kJCC2hv13KTWio79l603muy5bzBNNxduMAf6Hl611jcU3gCFGowUoCwnpz4U2NTv/
 6512aDay54xgbJqa1C9U0GkiXN5ResCuv477WS44AbrcRAPp37LpSihgqPttmfgvp33IWxOn8Th
 8jmsIpEC1AQ8zdvv0ngphCGKY46QJCdpXRbfRYl3Z8i/Vto2O8wRvd1eXTeRwwcT3R7depnjNL+
 B0X3cGNGl6uCKLfLhtYoBdWwsDxPRxw1o/tgp4LQ6iyflyT2U2ZrLYjXrkWg/EowGQRWISooJ5f
 XE7MuTFWnDyXf9KcateVFW9iPqtdYr0Rb0YcBSlJ24lLzdrtQ9k7xboiNPDWbnqNR3cFrc1ZoEq
 4PCeTkWr9BtxtdlrxKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
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

