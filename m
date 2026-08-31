Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753FBC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:24:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EC9D4060A;
	Mon, 31 Aug 2026 12:24:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E4D2B4060A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:24:02 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V85WIq880142; Mon, 31 Aug 2026 03:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 r18YzMd3sho4NyVoPe9mz2m71sNoKAOlE2nA/SHERU=; b=k43jDiDT07qXG0f+3
 G9CQ1UiHIlCXIQB/fC4TzHLuPAQqJ7q1iCzTd2D68QgZ1147JGKYNEWlhEkbdaGC
 47o6gdhmLBM2X7LdyHhmewb1VSp+k8NmUaLhQp2sK3C5mEcwAzgN+NuBsPVTRUKK
 qZvhpE5nXGg1r0IuYDgJUOXJ85ZopeE4AYzMLyQuhQO2CZPBInI2/KjSEylwvvSL
 3PZHad+M3aP/CYG/ICC0HCIr610Tf6W5Xyxb3GHUSslisGlFEK0LZpefIMgAfTqZ
 OLeG8sODKXVZYgH732lPwVsUZ5sGVDhMWeRHm0FlLauiMpnhotGeEouAg9/na8EE
 +ENWA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gcy3ss7um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:24:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:24:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:24:00 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 7D9023F704C;
 Mon, 31 Aug 2026 03:23:57 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 05/10] crypto/qat: advertise RSA padding capabilities
Date: Mon, 31 Aug 2026 10:23:23 +0000
Message-ID: <20260831102328.2813604-6-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfXyp3h5m5n0P+k
 iW2EY6qBdYzDpxoMy5NAkr2jO/HFk2lgXRoJzKjHlpRxUN36Wkfno0u5KpOC1Y00ezyQtm7SCt2
 tpQ/QL7M2lkhazGUkDU0JhvvULY6I1+u3E8yscvfMskDDW+3X+EKCEQdsiQiq5Sj1WJkMHu8Zev
 WSLxtgij80MaXUt2qgXMYhX52n4p5ND0V+ZJ9FMPN0T+qnKJO0A81kxiGR77DsWLtRnX9IyvA4s
 qbvb5X0VeKSXG/w2ivOqin4l+ofaGOV+aOEp+eLbE2Gpd59rZLvYkCpV7n2k0pfFdRa/DMfZR20
 zaeKUGXKK2/3btLfaiYqIAA7q5tEwA0BusEvBELBWfDkZpg6Morh3SHu6qZA+vXmQT9WLB8CxdV
 K89zdlxmz+8Y0/fAwRmJfPQa5KTjdOO34qjCxQumtSzctfGKr2Qwz9lKYcc9DGrvHTTeW8+hOH8
 pAEJZHCPIiEGlJLDnKw==
X-Proofpoint-ORIG-GUID: ltJKIG09ED7WmTdj2fkuLcnBNBeP5naF
X-Proofpoint-GUID: ltJKIG09ED7WmTdj2fkuLcnBNBeP5naF
X-Authority-Analysis: v=2.4 cv=baVbluPB c=1 sm=1 tr=0 ts=6a955642 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=xsakuaDDZ4dC_ujxwQQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfXyb2I+a93g1/x
 j7G6Obj1yayYU7pD/TjamAO6ayHnKg7WsFHQZ855f/IydR5fBloz0GdkGt1feBQvxgl3IyjFpy7
 xAEpgN6G00EEXTXWZCAUPB0Yyg/EL6M=
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

Add QAT_ASYM_RSA_CAP macro to report RSA asymmetric capabilities
using rsa_capa, including modulus length and padding schemes.

Update Gen1 and Gen4 QAT asymmetric PMDs to advertise
RTE_CRYPTO_RSA_PADDING_NONE via pad_types, matching the padding
mode supported by the QAT RSA implementation.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/qat/asym/qat_asym.h           | 20 ++++++++++++++++++++
 drivers/crypto/qat/dev/qat_asym_pmd_gen1.c   |  5 +++--
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c |  5 +++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/asym/qat_asym.h b/drivers/crypto/qat/asym/qat_asym.h
index 0ecbc47548..cf40d445df 100644
--- a/drivers/crypto/qat/asym/qat_asym.h
+++ b/drivers/crypto/qat/asym/qat_asym.h
@@ -56,6 +56,26 @@ typedef uint64_t large_int_ptr;
 		}							\
 	}
 
+#define QAT_ASYM_RSA_CAP(o, l, r, i, p)					\
+	{								\
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,			\
+		{.asym = {						\
+			.xform_capa = {					\
+				.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA, \
+				.op_types = o,				\
+				.rsa_capa = {				\
+				.modlen = {				\
+				.min = l,				\
+				.max = r,				\
+				.increment = i				\
+				},					\
+				.pad_types = p,				\
+				},					\
+			}						\
+		},							\
+		}							\
+	}
+
 struct __rte_aligned(8) qat_asym_op_cookie {
 	uint64_t error;
 	uint32_t alg_bytesize; /* Bytesize of algorithm */
diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
index c96608dd37..5b93cf374b 100644
--- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
@@ -32,12 +32,13 @@ static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen1[] = {
 		0, 1, 512, 1),
 	QAT_ASYM_CAP(MODINV,
 		0, 1, 512, 1),
-	QAT_ASYM_CAP(RSA,
+	QAT_ASYM_RSA_CAP(
 			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
 			(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
 			(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
 			(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
-			64, 512, 64),
+			64, 512, 64,
+			(1 << RTE_CRYPTO_RSA_PADDING_NONE)),
 	QAT_ASYM_CAP(ECDH,
 			((1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) |
 			(1 << RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) |
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
index 41cad29142..106c512a06 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -121,12 +121,13 @@ static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen4[] = {
 		0, 1, 512, 1),
 	QAT_ASYM_CAP(MODINV,
 		0, 1, 512, 1),
-	QAT_ASYM_CAP(RSA,
+	QAT_ASYM_RSA_CAP(
 			((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
 			(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
 			(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
 			(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
-			64, 512, 64),
+			64, 512, 64,
+			(1 << RTE_CRYPTO_RSA_PADDING_NONE)),
 	{	/* SM2 */
 		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
 		{.asym = {
-- 
2.54.0

