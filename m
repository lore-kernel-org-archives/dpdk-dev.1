Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60453C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 08:09:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E22140B97;
	Thu, 15 May 2025 10:09:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 018A7402C2
 for <dev@dpdk.org>; Thu, 15 May 2025 10:09:00 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EFJlVR005870;
 Thu, 15 May 2025 01:09:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=P8LjikhkfUY7RQic6HPD5IO
 OY/LciJ2eUJMc+/E87wA=; b=Eo1OVd8wXZKU5C0ebAQt1jQUgeZ0JOe2/hSUFbf
 SdEj7rF8LzYCYFBcSnSn67mRm2y57flkv+3Ps0T5SH1536qw2PVuwHXAyV4YDgwG
 DGLvOsEd+adwkdNtdZRW8XorXPy4S68neqfkaVGRPTnRwwCgkHXy/GO3F8Ji9nAO
 XdqB2r64ARgPl5vBOAUEO+busRjjeu7tyREDiX0Db2GL+AjQihaz/oz3GAgpCjcm
 REzELcJWgR7e0SHGaj4TRNwCvU2qvrd9SptzQ+5MNBHK0NX2yn0Q9dkiSdbqsrAY
 y4L3zBHnL0NQJhcOnlvZvFzRgk2A9L/3fdEmH2EWH2ZUAJw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mbe243h2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 01:08:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 01:08:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 01:08:59 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 2349A3F707D;
 Thu, 15 May 2025 01:08:56 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: <anoobj@marvell.com>
Subject: [PATCH] test/crypto: fix return value in RSA test
Date: Thu, 15 May 2025 13:38:50 +0530
Message-ID: <20250515080853.1708-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RdJkTaRrxGpY801NUIylDVCJxpJn28lA
X-Authority-Analysis: v=2.4 cv=fbyty1QF c=1 sm=1 tr=0 ts=6825a11c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=55YVfXhggWhydvCemTQA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: RdJkTaRrxGpY801NUIylDVCJxpJn28lA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA3OCBTYWx0ZWRfX/lq5Pmd9UAJP
 i1mDm3ySMpcfcbDdbmYam8yKmiTT7PoBLPYmH2foLcAy2jDIMp1mHafWdo1XppknC+EkslZSDUk
 OAHR7h7cfjWiam9ffFwlIrV+xd+7RAAGsW9aQ/pB9IYWbKg+5QQULD16bXJHO4/l86NzIEvP6aJ
 fYbtliOV2gYk3wIeqeoH3hwVKoEJ3KAB4OJcD0qUpdSe/ipOo9dbW+dOBb92anLniGvu7BWO1H/
 Js2jzR1yIL0Rt45SWGmsZXFB/2hLNHttn0X4YiFd9k8NTNgTL2/9tHJftITA/04CXYB7BmBe46H
 xEdOBFGHVVREFAMvxJGTt+Nx9zi+EPm9sLUi5joXqxI1H9/IbGFfxmNuhUSHpsjv8zNsFxmI2Ro
 9IW6RUlbPFx+l8a777LXPtrscp7YqRjViJLmvtzJiYN77fnk/VHLAQgkUbTzreet8oBcgiOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
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

This patch fixes incorrect return value when RSA negative
test scenario is validated.

Coverity-issue: 457463
Fixes: 9682e8246ae ("test/crypto: add negative case for RSA verification")

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 2377a18c72..6ecbea6b40 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -155,6 +155,7 @@ queue_ops_rsa_sign_verify(void *sess)
 	if (result_op->status != RTE_CRYPTO_OP_STATUS_ERROR) {
 		RTE_LOG(ERR, USER1, "Failed to process sign-verify op\n");
 		status = TEST_FAILED;
+		goto error_exit;
 	}
 
 	status = TEST_SUCCESS;
-- 
2.25.1

