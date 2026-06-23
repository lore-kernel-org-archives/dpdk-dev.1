Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3922ACD98F0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 04:27:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B1D74060A;
	Tue, 23 Jun 2026 06:27:35 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 39B45402ED
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:27:32 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0g3D72831834; Mon, 22 Jun 2026 21:27:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 o8aqhRpGYGP8tEMcxZYQphurH3hRd+TwaoJBysNDmk=; b=ZnowGOGhpmaNuPjTF
 UZy1Hjknhg5ADJi25U5oxJWkIG1LGSdSWSLUc8/g5L+mil4ouid7i3C/x4TpKPTi
 U7lHt5CeKHMiPNQ3DZa994vJb0Od4FXDxS67pnkoj49qkEHCOKiJxYJaAgcyxs15
 siOyThiR8vV2Zi4z29ZlZOXtj2wF+zUFy4TSk4+rpttHxBhvvs8TW9/HJcDycxZc
 cyivW1bF+8BKc/ILj/vTG9/ekUZL5a9o0OHRb7b6Gzvl6D8r+MikzB/4B+7OkGUw
 Q7Z98yir6Tc5enNYtlfzwa5UTdHauEvSCzF50cSHWQeq4dBI1ciCbxbegYSCFvZ+
 N8JYA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4exf48wnbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 21:27:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 21:27:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 21:27:30 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id E7D913F708D;
 Mon, 22 Jun 2026 21:27:28 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 2/3] test/crypto: add autotest support for cn20k
Date: Tue, 23 Jun 2026 09:57:22 +0530
Message-ID: <20260623042723.89226-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623042723.89226-1-ktejasree@marvell.com>
References: <20260623042723.89226-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YIuBRGCLHgxwAX9hNQtT2TPd3SyPaEG_
X-Proofpoint-GUID: YIuBRGCLHgxwAX9hNQtT2TPd3SyPaEG_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzMiBTYWx0ZWRfX83tASsl2KYg9
 pPrX2Z0XhbhTSGp8Mtjsio9yZ9hJQAZo9doiT967+gISP1eRpqbLjIlTwD7FB3X4vCmXzVhGbd1
 /3+4qMy+qpKCQzmlgNsdNrh9x0ezBbM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzMiBTYWx0ZWRfX9dRgWjHAXsqB
 XCzEEzmrGDqyBUW23YXoRcLyAmp5plScHZjiBsd/UU8nM/wUfZlBSX/WAQKix4EhhJzCL1N6PIH
 QIELSlEu4JlZa39870WD5hwVlMeliiiDg76uIl+aYb8lzSrhg1Fx2H4ODVyBEj3NeNlpxfvnBmu
 0a6PMYOGCDM1YK4/IfFOL9ZuoKKH5xha3v4Es1a0UL7Q2xP1q9Bz75qod7/S7SHm2gnZ5hKw4nJ
 HjjMim3JrhdfgWGme6222WgI9Z0Fl5mZOQtMajydlyj8ThLUtMyPWvHr+IZp0Scea7pCo9KOJEE
 lGkn5JzPtWWToPJKpgJejD9Ft/UwxLOFfDBr6rPfuTwn9KeRR/uvc6PrtuRNkD9XMLKx7UkLXJj
 i5VovZ0jTX/Y8Vb11X7fA1Oru7NdMHuyU3ag7033oVugZzdS88huVDaIkx/jDQoQi2mmWzayxPP
 AH7vnVV97mUQQTyLF0w==
X-Authority-Analysis: v=2.4 cv=J9uaKgnS c=1 sm=1 tr=0 ts=6a3a0b33 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=OV1A51sQi1GZLY8EOPMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add crypto autotest support for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 app/test/test_cryptodev.c | 15 +++++++++++++++
 app/test/test_cryptodev.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index b908f10317..884629ec8c 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -20863,6 +20863,18 @@ test_cryptodev_cn10k_raw_api(void)
 	return run_cryptodev_raw_testsuite(RTE_STR(CRYPTODEV_NAME_CN10K_PMD));
 }
 
+static int
+test_cryptodev_cn20k(void)
+{
+	return run_cryptodev_testsuite(RTE_STR(CRYPTODEV_NAME_CN20K_PMD));
+}
+
+static int
+test_cryptodev_cn20k_raw_api(void)
+{
+	return run_cryptodev_raw_testsuite(RTE_STR(CRYPTODEV_NAME_CN20K_PMD));
+}
+
 static int
 test_cryptodev_dpaa2_sec_raw_api(void)
 {
@@ -20883,6 +20895,8 @@ test_cryptodev_zsda(void)
 
 REGISTER_DRIVER_TEST(cryptodev_cn10k_raw_api_autotest,
 		test_cryptodev_cn10k_raw_api);
+REGISTER_DRIVER_TEST(cryptodev_cn20k_raw_api_autotest,
+		test_cryptodev_cn20k_raw_api);
 REGISTER_DRIVER_TEST(cryptodev_dpaa2_sec_raw_api_autotest,
 		test_cryptodev_dpaa2_sec_raw_api);
 REGISTER_DRIVER_TEST(cryptodev_dpaa_sec_raw_api_autotest,
@@ -20915,4 +20929,5 @@ REGISTER_DRIVER_TEST(cryptodev_nitrox_autotest, test_cryptodev_nitrox);
 REGISTER_DRIVER_TEST(cryptodev_bcmfs_autotest, test_cryptodev_bcmfs);
 REGISTER_DRIVER_TEST(cryptodev_cn9k_autotest, test_cryptodev_cn9k);
 REGISTER_DRIVER_TEST(cryptodev_cn10k_autotest, test_cryptodev_cn10k);
+REGISTER_DRIVER_TEST(cryptodev_cn20k_autotest, test_cryptodev_cn20k);
 REGISTER_DRIVER_TEST(cryptodev_zsda_autotest, test_cryptodev_zsda);
diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index 49aa45ec17..d125dea958 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -74,6 +74,7 @@
 #define CRYPTODEV_NAME_BCMFS_PMD	crypto_bcmfs
 #define CRYPTODEV_NAME_CN9K_PMD		crypto_cn9k
 #define CRYPTODEV_NAME_CN10K_PMD	crypto_cn10k
+#define CRYPTODEV_NAME_CN20K_PMD	crypto_cn20k
 #define CRYPTODEV_NAME_MLX5_PMD		crypto_mlx5
 #define CRYPTODEV_NAME_UADK_PMD		crypto_uadk
 #define CRYPTODEV_NAME_ZSDA_SYM_PMD	crypto_zsda
-- 
2.34.1

