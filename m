Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FC4C369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 06:47:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03CF9402DA;
	Mon, 21 Apr 2025 08:47:17 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 655B840151
 for <dev@dpdk.org>; Mon, 21 Apr 2025 08:47:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNkDxK005784;
 Sun, 20 Apr 2025 23:47:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=5ve8uqHRUoLVIwHaOWMELwn
 wpJpYx0JzEtlkxjyXKO4=; b=faGTfs2iRR99k+kRhEBfImq7FG5YnrJsryWI2eF
 MoNzDzpo23AQEDeGzVqQtnoUqqcc+I6JZAlEtw+7x/1ERBCzMZ7U2LTj+F1/i3UZ
 ynZA/HA8RcPr2T/J05Yl3g2XUQeP1aa13uru9ROfKnymzkqkJnWQHi9ymLD/uqLS
 jOPHolR5u41ARuEFKgGghRIqdI2VdJ6heL2P6MjVJTx6fEWl3KAVV34cvCnPHr1P
 Njq0Z0WUbqxJwNoHsmNA0o2Qr6COHE85a1pQvjCR2A38DdnX0mSh+D8sICeF307z
 mWbkKLyJkm+79B/yJKSq09vIzS2byjfVRZNvvGLU/mQaKNg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46503c1687-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Apr 2025 23:47:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 20 Apr 2025 23:47:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 20 Apr 2025 23:47:13 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 2961B3F70F6;
 Sun, 20 Apr 2025 23:47:10 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH] test/crypto: increment dequeue timeout
Date: Mon, 21 Apr 2025 12:17:05 +0530
Message-ID: <20250421064708.1777-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4UmwqIOvsMTN4lPIH7993CNBjCz_w5OT
X-Authority-Analysis: v=2.4 cv=WMh/XmsR c=1 sm=1 tr=0 ts=6805e9f2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=3O7H7lqxqWkCj1SWBtEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 4UmwqIOvsMTN4lPIH7993CNBjCz_w5OT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_03,2025-04-17_01,2024-11-22_01
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

Increment dequeue timeout to allow implementations taking
longer cycles.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 6b74dd9a73..226270556d 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -35,7 +35,7 @@
 #endif
 #define ASYM_TEST_MSG_LEN 256
 #define TEST_VECTOR_SIZE 256
-#define DEQ_TIMEOUT 50
+#define DEQ_TIMEOUT 10000
 
 static int gbl_driver_id;
 static struct crypto_testsuite_params_asym {
-- 
2.25.1

