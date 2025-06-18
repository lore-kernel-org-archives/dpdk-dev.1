Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B36C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 12:54:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C830242DDC;
	Wed, 18 Jun 2025 14:54:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8AB2D42DCD;
 Wed, 18 Jun 2025 14:54:25 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8xuZ6025944;
 Wed, 18 Jun 2025 05:54:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 cmdmnYGat2StQ+0AiHbB14F7W4ZtQe+w6gaasogDyg=; b=RRorFt8cpHjd8KPvf
 740LbfxUZzzzCJ+0QvWi5xz0Gxt93kO9ovlH6ovfs+XEZcqtrB1e7FseuCFCEy20
 ngKpN9gm4lVfIt00KIYZw0I5HGVczhbs9f3gt5Fo4VpmEjdwVeuTnGQ3TBvKTtPA
 pFwwdePVGZQkkVtk98YnhrlSVH2lF3xFfB3Tl1suVTvuBwdBow6vkW0/e3Ml4ZJl
 BTRwwe0c1T+mOYFpia2C5njSncPZhJYnQUCObDR9yHWbCHjdNl9EiuKA3ShqXvr5
 KM0HROR2P98D037hBaqBPNPwjdndk/nY+Mtpsz8/stIOhh7bJ6jMgPl95Mz1V4nC
 y0OAA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bj4xse9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 05:54:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 05:54:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 05:54:23 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id 1246A3F7043;
 Wed, 18 Jun 2025 05:54:20 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>, <stable@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>, <fanzhang.oss@gmail.com>
Subject: [PATCH 3/3] test/crypto: set ptr to null post crypto op free
Date: Wed, 18 Jun 2025 12:54:09 +0000
Message-ID: <20250618125410.767919-4-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250618125410.767919-1-nkaithakadan@marvell.com>
References: <20250618125410.767919-1-nkaithakadan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ULrdHDfy c=1 sm=1 tr=0 ts=6852b700 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=pbQ8Gh6SirihF9SoSYUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwOSBTYWx0ZWRfX61o9O9HhMCzn
 Dcf9m2U/VDbC0lFwCNZCu5N3JcnDMIEV1aT73bTtsdjEblUImBbFgPHBX6oTt7hph4DoR0SrwlF
 ZEn1KomTRZj2oVMEu+0NmXH+Ed612Kpg0R/KG0ZOh0j5ARgjGAmWO+Bq/nk/MjsTaiH7BnfX5sP
 881aCum/4yPKNWhGGunKheEL+x9p3R1yqM7R0kTdemsX/nuufoqXlGxvmOnrVuMeFH2na0/d8MC
 oprVmIhI6aBRl1LES0GB6mbxGdD9hOvcyxnEgcOXAaS2fobJzfmbAHVImjEbt/GpTA0KFLyIg+F
 J5O6ZSAJ+t7iJSYCGUpgBBcght2GjpftzmGhXUr8zuZESiozHE8dwvrYRY5uUa5p9X1r+R2wWkT
 vQZpEQjwd0zAsOwwPSzkp3Dxt97YePWa9Euta3yz0nvaBLSl+83huZbO0OxeI+aVGSHXLG9x
X-Proofpoint-GUID: KWP3FnI8iqQSWZN2N6hNu7mO6224Bb9f
X-Proofpoint-ORIG-GUID: KWP3FnI8iqQSWZN2N6hNu7mO6224Bb9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
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

Set pointer to NULL post rte_crypto_op_free operation.

Fixes: 3bf0db60f5d2 ("test/crypto: add queue pair depth used count")
Fixes: 202d375c60bc ("app/test: add cryptodev unit and performance tests")
Fixes: ffbe3be0d4b5 ("app/test: add libcrypto")

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 app/test/test_cryptodev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 7535ef6974..5229ac2bf6 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -2625,6 +2625,7 @@ test_queue_pair_descriptor_count(void)
 
 		rte_pktmbuf_free(ops_deq[i]->sym->m_src);
 		rte_crypto_op_free(ops_deq[i]);
+		ops_deq[i] = NULL;
 	}
 
 	return TEST_SUCCESS;
@@ -14789,6 +14790,7 @@ test_multi_session(void)
 
 		/* free crypto operation structure */
 		rte_crypto_op_free(ut_params->op);
+		ut_params->op = NULL;
 
 		/*
 		 * free mbuf - both obuf and ibuf are usually the same,
@@ -14933,6 +14935,7 @@ test_multi_session_random_usage(void)
 					ut_paramz[j].iv);
 
 		rte_crypto_op_free(ut_paramz[j].ut_params.op);
+		ut_paramz[j].ut_params.op = NULL;
 
 		/*
 		 * free mbuf - both obuf and ibuf are usually the same,
-- 
2.48.1

