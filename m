Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5599EC47BE8
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 10:44:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EBB1402DC;
	Tue,  6 Jan 2026 11:44:04 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 059BE400EF
 for <dev@dpdk.org>; Tue,  6 Jan 2026 11:44:01 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6067I9XN2795732 for <dev@dpdk.org>; Tue, 6 Jan 2026 02:44:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=vNaAlplccAqL4vSL5DJxnaH
 baqlA0dSvIBahc/Paaf4=; b=IzWE50Gb8bsJmuuHlJx7iqp+/9oct04kZsPS5bp
 NM8O2SRdLFRXwXwOA1iqUkAomVCOJDYynkY43fCggMzuDezux5inYKSbkpv6tsQE
 kS2b2gYwYWc394tQjHFQaVF/Os7Evyde/7Xd6ndaZybMY0cbo0QItk/a6oqSSLv9
 J+aVGxDPy4hXPs8eQbwdND3XX+Hj6/6XQle5+Vse8rbUvI9/aJ4KsBpIaPWwBykf
 yvZ/RGunbvbhbOwb8jJT5URRzgbhFM3q67DP7JgPCW3jbDySdllO5EcDTOnUZqRB
 tUFpcATTH6IBv8KAn2HdNcndeJPnVEC6wBsHXbAJoWrRu3A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3ft4w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 06 Jan 2026 02:44:00 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Jan 2026 02:44:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Jan 2026 02:44:00 -0800
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id AE7693F7054;
 Tue,  6 Jan 2026 02:43:58 -0800 (PST)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <ktejasree@marvell.com>, <gakhil@marvell.com>
Subject: [PATCH] cryptodev: add SNOW5G spec
Date: Tue, 6 Jan 2026 10:43:57 +0000
Message-ID: <20260106104357.2452583-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695ce771 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=Zc_DtpmQZw8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=3g8a6ajrIIXMzza37a0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA5MSBTYWx0ZWRfX+J+HrBo436zO
 /z9musmbXIxEDjhmPo6g+wSAsIB+efTM9yUC8M3oKibj+uiC0axj6bezZWVTqfFfozR+YVtkO8p
 l9mn0IJibyvVmxQBXbbF703YQMobPeAziE92me5W11dNUjryUX6aK+Jgg6BsI/OEGYnkT2Y7vkE
 Jy2NyfPwfdW2htsmGAIBk4Zu8ORtdwhAOGfdLB03H6UrMJE5dCF6CZBr0Cvr7jvkNKG1tmx9KYX
 BwpdJCZEsdJTEbr2hZ0IlN22qnHshuXVtgsEspbBKDVS8GmOVteXc0uy4dGmpg/mquOfDCUBZtG
 5iG5Ra/2RjgXOLvx4elumwJYfylAykK3IoHK9imSaWGii/fPMUHbMX3GZJqEbY9p9TwMX6+GXOD
 9/gK+3XAL22kdJtzxOUKMnvlHDGpewjEjeTmDZv1ksDWgZRzzpw5OkvBwKevDAaejaMCpReWR/8
 Io4vx/I5yCKh0tAo2Tw==
X-Proofpoint-GUID: HlhjE9DtXOxDwzsz1cj4e3qJeCTGaF1q
X-Proofpoint-ORIG-GUID: HlhjE9DtXOxDwzsz1cj4e3qJeCTGaF1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-06_01,2025-10-01_01
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

Add specification for SNOW5G cipher and auth.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
Application and driver changes will be submitted as a separate patch.
 doc/guides/cryptodevs/features/default.ini | 2 ++
 lib/cryptodev/rte_crypto_sym.h             | 6 ++++++
 lib/cryptodev/rte_cryptodev.c              | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/doc/guides/cryptodevs/features/default.ini b/doc/guides/cryptodevs/features/default.ini
index 64198f013a..b377dc2c4c 100644
--- a/doc/guides/cryptodevs/features/default.ini
+++ b/doc/guides/cryptodevs/features/default.ini
@@ -60,6 +60,7 @@ AES DOCSIS BPI =
 DES CBC        =
 DES DOCSIS BPI =
 SNOW3G UEA2    =
+SNOW5G NEA4    =
 KASUMI F8      =
 ZUC EEA3       =
 SM4 ECB        =
@@ -89,6 +90,7 @@ SHA512 HMAC  =
 AES XCBC MAC =
 AES GMAC     =
 SNOW3G UIA2  =
+SNOW5G NIA4  =
 KASUMI F9    =
 ZUC EIA3     =
 AES CMAC (128)  =
diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sym.h
index 6268bab327..b15e32ddc9 100644
--- a/lib/cryptodev/rte_crypto_sym.h
+++ b/lib/cryptodev/rte_crypto_sym.h
@@ -180,6 +180,9 @@ enum rte_crypto_cipher_algorithm {
 	/**< ShangMi 4 (SM4) algorithm in CFB mode */
 	RTE_CRYPTO_CIPHER_SM4_XTS
 	/**< ShangMi 4 (SM4) algorithm in XTS mode */
+
+	RTE_CRYPTO_CIPHER_SNOW5G_NEA4,
+	/**< SNOW 5G algorithm in NEA4 mode */
 };
 
 /** Symmetric Cipher Direction */
@@ -384,6 +387,9 @@ enum rte_crypto_auth_algorithm {
 	/**< 256 bit SHAKE algorithm. */
 	RTE_CRYPTO_AUTH_SM3_HMAC,
 	/** < HMAC using ShangMi 3 (SM3) algorithm */
+
+	RTE_CRYPTO_AUTH_SNOW5G_NIA4,
+	/**< SNOW 5G algorithm in NIA4 mode. */
 };
 
 /** Symmetric Authentication / Hash Operations */
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index f4c6f692f0..6079ec30b1 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -96,6 +96,7 @@ crypto_cipher_algorithm_strings[] = {
 
 	[RTE_CRYPTO_CIPHER_KASUMI_F8]	= "kasumi-f8",
 	[RTE_CRYPTO_CIPHER_SNOW3G_UEA2]	= "snow3g-uea2",
+	[RTE_CRYPTO_CIPHER_SNOW5G_NEA4]	= "snow5g-nea4",
 	[RTE_CRYPTO_CIPHER_ZUC_EEA3]	= "zuc-eea3",
 	[RTE_CRYPTO_CIPHER_SM4_ECB]	= "sm4-ecb",
 	[RTE_CRYPTO_CIPHER_SM4_CBC]	= "sm4-cbc",
@@ -156,6 +157,7 @@ crypto_auth_algorithm_strings[] = {
 
 	[RTE_CRYPTO_AUTH_KASUMI_F9]	= "kasumi-f9",
 	[RTE_CRYPTO_AUTH_SNOW3G_UIA2]	= "snow3g-uia2",
+	[RTE_CRYPTO_AUTH_SNOW5G_NIA4]	= "snow5g-nia4",
 	[RTE_CRYPTO_AUTH_ZUC_EIA3]	= "zuc-eia3",
 	[RTE_CRYPTO_AUTH_SM3]		= "sm3",
 	[RTE_CRYPTO_AUTH_SM3_HMAC]	= "sm3-hmac",
-- 
2.48.1

