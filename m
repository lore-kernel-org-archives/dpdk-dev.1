Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51F8C47BE6
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 11:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A52F402DC;
	Tue,  6 Jan 2026 12:24:04 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8413F400EF
 for <dev@dpdk.org>; Tue,  6 Jan 2026 12:24:02 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6060jEhl128598; Tue, 6 Jan 2026 03:24:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 B0P5EqUtNkDyGEaVYcF2Zl5VlX4gAe6nU6ynXn2zp8=; b=BbfqqztcmcSi5s/Kk
 3jCPAQDiqTK0Or/X0XSOkMrUuiNN7y55QJ08XJhu1dctb+vql9T+1bFGgUAk+XYz
 cQgMosEFPYSZIPf1rAzZVnBYJIJ63e1RMOHk4Gv5dHjPVEBIUO9hGXVUJy8MzpcH
 cewyDRlqC1zspS2Mv+ruVhQ3qkehzXIkxeu26fREKcAR021atJ4xW/Jd9T0Du5TZ
 BxDrGtuvRA0X3dkRk0onTO3KHArXI3clzaj1h/2v+atP9ZFSyYroiZcsdhR9dNKD
 QhmU4WM/vm8vmdERT2CiQ6GmWddtTRKwK62BvD+hhw6LkRvk+iIo8dzyc7oRZ+g+
 5ndkA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bg9crjsd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 03:24:00 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Jan 2026 03:24:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Jan 2026 03:24:14 -0800
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id 69D883F7054;
 Tue,  6 Jan 2026 03:23:58 -0800 (PST)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <ktejasree@marvell.com>, <gakhil@marvell.com>,
 <kai.ji@intel.com>, <radu.nicolau@intel.com>
Subject: [PATCH v2] cryptodev: add SNOW5G spec
Date: Tue, 6 Jan 2026 11:23:57 +0000
Message-ID: <20260106112357.2454990-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260106104357.2452583-1-nkaithakadan@marvell.com>
References: <20260106104357.2452583-1-nkaithakadan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA5NyBTYWx0ZWRfXySdlZ3DrbdB9
 YisDMSt+MRf/oJ8rPLhD9xZ4K1Xi1bpq3xWT6RIeEMxwQuusx6d1yEBcjAFsrtkrRt1pe70EklZ
 st6ecXKH8b1CcHoYYGECgxqAMSB3do9OpPKWwnfxYsB+YcN1GDjDLCXzpXyoZPUTVNacyxQiCbl
 o+rspOC7TTPEeZ5WfDp4CdTiB3duIGOAXk1DEKsw4q+ArcgVKQsRjDGgAsosb4hYXlmrgGXi1Rx
 DXfdEuTbP7+BNpyun5aisKzh3htYiNuZt1I45827F9j5/nuJagCK7M/BpQ+GI9EZzMMA3Umpg61
 Pqc/YEuqbYq4We8q6lm55VgWWNR9vrNl6c8GZqdyc3Rf1cuXvT4VYcgeKMrVD/IPfqY2kQ4rYY4
 npYBTdXa39PxkIDjaCrTJSZUR361u8p77Oy9ioJuKe5VCxBWpmO+qd95FHJm+vssnvThCQFuTv5
 z4nNITKzPbUhO7oNvPA==
X-Proofpoint-ORIG-GUID: 5wxk6KUoPF429RMxcRWHCfC9-7NTohEc
X-Authority-Analysis: v=2.4 cv=aLr9aL9m c=1 sm=1 tr=0 ts=695cf0d0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=Zc_DtpmQZw8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=3g8a6ajrIIXMzza37a0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 5wxk6KUoPF429RMxcRWHCfC9-7NTohEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
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
 lib/cryptodev/rte_crypto_sym.h             | 8 +++++++-
 lib/cryptodev/rte_cryptodev.c              | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

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
index 6268bab327..1ea6cc7df9 100644
--- a/lib/cryptodev/rte_crypto_sym.h
+++ b/lib/cryptodev/rte_crypto_sym.h
@@ -178,8 +178,11 @@ enum rte_crypto_cipher_algorithm {
 	/**< ShangMi 4 (SM4) algorithm in OFB mode */
 	RTE_CRYPTO_CIPHER_SM4_CFB,
 	/**< ShangMi 4 (SM4) algorithm in CFB mode */
-	RTE_CRYPTO_CIPHER_SM4_XTS
+	RTE_CRYPTO_CIPHER_SM4_XTS,
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

