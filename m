Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D43CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 11:21:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 793DA40E0C;
	Tue, 16 Jun 2026 13:21:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6084340DFB
 for <dev@dpdk.org>; Tue, 16 Jun 2026 13:21:25 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GBId9K3389284; Tue, 16 Jun 2026 04:21:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 0NyElao8U8z6sKBia+ezN+1b3DenUDzc7RwhOVvAmU=; b=Jzj6hDoSpB4Hez7ah
 8l9bIOl5A7d240I9hQ5otzHKcznxd7+vtBgFHAwDt952skPGVXfaST8R0UpG+JLF
 6iUv9hGJYlKPIyLMcFjej4rX6HVen+b5wzI1nMFwHsIvAWeJwqmVhReWdtE7AumG
 ve/aEODqfM1hb7quV43+P2kfHV2sCQCRcpnaejWHoDZ5gfkwXIk2PEb6CSGKK8o0
 bSwxK/tHVoFxIIV25SlTJmWSisDFMyTClA55ZeO0tXyJymQGgpFRzUqk0XI0TiEV
 XJG5c6xtzvN/l5U7GaNm7cQAS/CI+mXtRAfzY8ZZKwSC25e6/SOqcbvQ62crW8El
 EI0Vw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eu46a0a4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:21:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 04:21:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 04:21:23 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id E14743F7094;
 Tue, 16 Jun 2026 04:21:21 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 3/4] test/crypto: add autotest support for cn20k
Date: Tue, 16 Jun 2026 16:51:12 +0530
Message-ID: <20260616112113.73680-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616112113.73680-1-ktejasree@marvell.com>
References: <20260616112113.73680-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfX5uWHHjLYHvq7
 t5TWpwjDBhXhps04oWGuep0NBRmV+MmstZFFj119HbmtQlD77CVOdtMzWVzEkx1mvp0cf/p5+gY
 rLib7EIWg83TZMJDBPZkkZBYGsXAsKQ=
X-Proofpoint-ORIG-GUID: lCVbvja3gS3uUNp8Yz25Rob38cs4TqBI
X-Proofpoint-GUID: lCVbvja3gS3uUNp8Yz25Rob38cs4TqBI
X-Authority-Analysis: v=2.4 cv=U72iy+ru c=1 sm=1 tr=0 ts=6a3131b4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=67BDL3DaJ7e3yVzrGGQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfX9qh6xIO15JFc
 pOVLfwFtCtNMz+ujK/MRCFmWrVG0K7KEMX6XKqdeOxD5xoTKnUJCwWAZHpaNmcoyM2rLzrF+ImL
 Ew0ecCRWyfuh9vNewan4JHnqjoQUeW5swHRAuv0qo4+wlj0VFQKuoxnpMv4ChHfb7WZDxA9NC1Z
 NDZCMvQmS/MtIwWcmkob2jbt/wVw0JUWXtlM/YVRVPhnjTLmSrMTvnWq68rtPiYtnP2hoVBUq9s
 bu9FWBAEHTgLOKR2Zk6HPF/huUoNpFxMaJueSixPodhZTt9HfagekOUvL5JVOzNpoeq+dSwnYWy
 46uhe15/ajUV4iab80Mi/jBQuzmPRoAfdZPElMbt+cHN9KIA3iC2N7j9bX3MwS1c5U2ootR/ltM
 eO8NYHkqS1KUUevqgGA9w13JrfL+H7RLiKZcgq1D9d5ipitOCqQWYnyH+XW28OBNMXzqIU3L+gm
 iGIQwwOiDotm0yV9WMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
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
---
 app/test/test_cryptodev.c | 15 +++++++++++++++
 app/test/test_cryptodev.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index a60983c6b7..bd726ddcf9 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -20880,6 +20880,18 @@ test_cryptodev_cn10k_raw_api(void)
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
@@ -20935,4 +20947,7 @@ REGISTER_DRIVER_TEST(cryptodev_nitrox_autotest, test_cryptodev_nitrox);
 REGISTER_DRIVER_TEST(cryptodev_bcmfs_autotest, test_cryptodev_bcmfs);
 REGISTER_DRIVER_TEST(cryptodev_cn9k_autotest, test_cryptodev_cn9k);
 REGISTER_DRIVER_TEST(cryptodev_cn10k_autotest, test_cryptodev_cn10k);
+REGISTER_DRIVER_TEST(cryptodev_cn20k_autotest, test_cryptodev_cn20k);
+REGISTER_DRIVER_TEST(cryptodev_cn20k_raw_api_autotest,
+		test_cryptodev_cn20k_raw_api);
 REGISTER_DRIVER_TEST(cryptodev_zsda_autotest, test_cryptodev_zsda);
diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index 23d12ec961..f4d8f9be0a 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -76,6 +76,7 @@
 #define CRYPTODEV_NAME_BCMFS_PMD	crypto_bcmfs
 #define CRYPTODEV_NAME_CN9K_PMD		crypto_cn9k
 #define CRYPTODEV_NAME_CN10K_PMD	crypto_cn10k
+#define CRYPTODEV_NAME_CN20K_PMD	crypto_cn20k
 #define CRYPTODEV_NAME_MLX5_PMD		crypto_mlx5
 #define CRYPTODEV_NAME_UADK_PMD		crypto_uadk
 #define CRYPTODEV_NAME_ZSDA_SYM_PMD	crypto_zsda
-- 
2.34.1

