Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92390CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 11:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C58740DD5;
	Tue, 16 Jun 2026 13:21:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0FC754026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 13:21:22 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GBJA8X3327087; Tue, 16 Jun 2026 04:21:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 RkR6oXlPJ8wFjDG9y4f+V/am7/Os+k1KHhhLYWXi68=; b=iMmP0Q/oyNR4TX4Ny
 GX9htPxwnkS4Vzc7tllHwm5Wm8ymasGdrKsTcq1qjs5xKgkRufIpP5bV2vHAvgqz
 a90BheSvAO76JE74KM50HWHNXMQOE/bb1RidnP07s8zQOm+bUoaBHSrPg/t5AwoH
 9Fs6am9FrtFeFgN9KNVrkhYpx1dxZakKpFR/o3ahdrQ6jnVc4xTjqEbWF45Nl0Nl
 0nNiZYTA2IAEfEyVt4ufTMDMXET6aOeerj+ZsNBm84VxZY5yiC3tTpm1nroBQ9GA
 wM7c1Nv9Y9WIPVDSgJKnt74i2vNy4sEX6OlmLeVUXCKjH/2l9yQmRPO65zykIL//
 lSSMw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qeksyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:21:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 04:21:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 04:21:21 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 88BB63F7094;
 Tue, 16 Jun 2026 04:21:19 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 2/4] test/crypto: add asym autotest support for cn20k
Date: Tue, 16 Jun 2026 16:51:11 +0530
Message-ID: <20260616112113.73680-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616112113.73680-1-ktejasree@marvell.com>
References: <20260616112113.73680-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jpqhM-dWm9BQ1sJb4vVoFwtsB_QxKgKQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfX/4VWw0KLwKTD
 WDu91OrAeWPhMTmrZ+BqQqL6x6TX+On2oq2qyjzrGySmMwPkRqmxqXYt5butNynPVTBDKlJb1T8
 xCoJPIBPJFnPYJJTAUmj72TMiY9dqaA=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a3131b2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=tE77Fx74zz6wD1elt1YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: jpqhM-dWm9BQ1sJb4vVoFwtsB_QxKgKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNCBTYWx0ZWRfX3EYr5aWKg9Xv
 xmIWO1zS+5hisTh3UHRFKfJjcNybxFI06wNS6jRhW6kl74TzVLoHGB51I746sRBVjqqLVCOx8dE
 juRsp6DU55dFVX8AIern4U9L7ex2g7Noi00sP4x7m0PEJ/2ChXXJsNnNuvYd9AyZ6JhAiztkr8X
 eKDtzuhseEI2AbM1Q2Sysr1x72meELlsxkDPt7KDoMT+J8n3zbud94wbA9TZYb3YtJq7P53euWH
 swOT84ZOyLSoKL42QflhQ0/H5Iy3pMAK1xRpjPibEB4Ktm7X/e21stHdWwlc6Vg7kqkrfLM9VH0
 vJMB0hZJBrv1kKB9XgklXqmZVWiClycajyqMmSCRaUR0iPs/gP7daCbtq+aWqNFQBAUo/SYv618
 mn0X808Zmu//FlLyWZ9Njy92QcR7eKpPBvrupoPZfgXzydgJQVuuwh/RgIHASAm4foU6gqGXnid
 xNbA3mBZILuAqwWKMGw==
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

Add crypto asym autotest support for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 app/test/test_cryptodev_asym.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index e7cc5a79e2..48637ef247 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -5583,6 +5583,12 @@ test_cryptodev_cn10k_asym(void)
 	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_CN10K_PMD));
 }
 
+static int
+test_cryptodev_cn20k_asym(void)
+{
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_CN20K_PMD));
+}
+
 static int
 test_cryptodev_virtio_asym(void)
 {
@@ -5600,5 +5606,6 @@ REGISTER_DRIVER_TEST(cryptodev_qat_asym_autotest, test_cryptodev_qat_asym);
 REGISTER_DRIVER_TEST(cryptodev_octeontx_asym_autotest, test_cryptodev_octeontx_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn9k_asym_autotest, test_cryptodev_cn9k_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn10k_asym_autotest, test_cryptodev_cn10k_asym);
+REGISTER_DRIVER_TEST(cryptodev_cn20k_asym_autotest, test_cryptodev_cn20k_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_asym_autotest, test_cryptodev_virtio_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_user_asym_autotest, test_cryptodev_virtio_user_asym);
-- 
2.34.1

