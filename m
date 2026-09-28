Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C5C98328
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 05:05:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13F3740A70;
	Mon, 28 Sep 2026 07:04:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 69D3A40A6E
 for <dev@dpdk.org>; Mon, 28 Sep 2026 07:04:55 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S1wfcP1521939; Sun, 27 Sep 2026 22:04:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
 wiLUktek4RFdldLZN9BmksaTwhfz52D9UTv0umVTiQ=; b=DoYo+0CmCSSSDzqr7
 Te7fOQa4yqA4JSAiz91igvFBqNgYikWpljrzEU7QbjhjUez3oJc05xdPrdQtq06f
 zRIfN5iay374pTd3baiC3PmQnHYJ0vHXUTUiMf+hvB7EAdkfcdC0DWd98N3WAlb2
 77sGvCV9R3tAyy0ZDhum228GZrt1CjW+J2R8BZ8Vvavdxel5Jgdf+7DDMNzTCldj
 D+gUt4we1xtjpfXZr3CLAfmur0OXKlh1HUpLD7lw9b71qvTJmRTuKGJApcn3qJ0r
 /4hZ2duQVHnxW4sMOVGfhtER5l/t9Lnvpkcu1IhihMC+SA4Y9P3bqc+jj4xPwYVO
 H9JaA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gxxt7syyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 22:04:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 22:04:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 22:04:53 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 051A63F70BB;
 Sun, 27 Sep 2026 22:04:49 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v4 4/8] crypto/openssl: advertise RSA padding and hash
 capabilities
Date: Mon, 28 Sep 2026 05:04:08 +0000
Message-ID: <20260928050412.276760-5-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928050412.276760-1-ssarananaga@marvell.com>
References: <20260925081500.3848187-1-ssarananaga@marvell.com>
 <20260928050412.276760-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfX++R09UKiPoAI
 lLAdCz5qVwMI97Zvyt3sz3oLjdaPTW5SsX87Z6tuI0/1BVXhH+LAOxQc+CDaKCcdXwUA6uFA/8j
 c5y+EBsfxyPIwYGjENVN+/HIgoUysqhCSLfKZCJv8UmqZO7bLgbOOJ2qKyoLUmTRzxrXem2fY91
 8JzDXLMzZZGGt7OjXtcKX9dWWRdIGG5qx8XIB0/bWxGqYIEmWvz6Hbf7zbd1jbOZhHi/SWhQjXH
 xJUD4febWrrCInuT3XKcbzoI+XeP29j5POQKk/glcs51k4MNW85dEra37SlKaYwEGpOTmjNKZhj
 Wvt4MYCWTyllSyFqqfr73LtI5+dyI3dt5eVWPzVMyXVjZktnI8kg+YJI5+nJfWEnzQIxfIwUuh3
 WtrK/Z/8R7urxiZMgsL9Vn6MqBLENqpNTQLLtVQehnJgYNGp8wLFxCmz+GLcsqePxi2lvg97FSQ
 +s+MhD2lWG7M81oZXmw==
X-Proofpoint-GUID: 7ePihwbPYi8pRHtpqrp6ECSJ74yZZzg6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfX9+xZKXH60X4N
 RqErOTS9n3tH76pMS7lXSTyVjJFIiXDvb62L42eaA2ypzCcMpZPB/J5mGyAYRsohueZ+SO8GkjJ
 a2bX94aoh/pSCNVFw1EF1XBzBfIm9nQ=
X-Authority-Analysis: v=2.4 cv=YaEodARf c=1 sm=1 tr=0 ts=6ab9f576 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=bt2ItxIhNOdH_RBkUzcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 7ePihwbPYi8pRHtpqrp6ECSJ74yZZzg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
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

