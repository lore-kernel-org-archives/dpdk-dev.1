Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF4CC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 13:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1136E4027F;
	Tue, 11 Mar 2025 14:16:10 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 16C3940263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 14:16:08 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BB5mel008060;
 Tue, 11 Mar 2025 06:16:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=wVvydeGQ9D3oxghew+MR+0h
 3E1Ydqxx9mXG45Ke9tDc=; b=B4mO4eunD0IrgpagHIIy5slE6sYWPJKssJ24FIv
 xN57vWCCChDn2dZ0lBw0/8soCrbFT10yFc8p1+juTZxniMxdjmmHgzTGUYD0CkBw
 SImbSs09xwwUHKj9IkvHsbq8r8/fWjls4+cEi8bmXf5arrxGLMNe9nVLsX9gQGfM
 Kc1HGRY9vfjSjaD0jUe2x3wUerhrT+b/PKQF7PSZgdD1HjNOMl38kpQ0f1RQJi2T
 M6ydglQ7z+hNMTmBbRqnyrUJapALZNx/zBD9SgHNG9yfYlzXd9BXjJg4zDBIvTJq
 U9pGhQe5qLgR9/GSbtj9Y/WkoRBx3kxK1DiwViXZjrGTfcQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45akyv09df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 06:16:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Mar 2025 06:16:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Mar 2025 06:16:06 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.105])
 by maili.marvell.com (Postfix) with ESMTP id 608E65E68C6;
 Tue, 11 Mar 2025 05:47:55 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH] test/crypto: skip test when virtio PMD not loaded
Date: Tue, 11 Mar 2025 18:17:45 +0530
Message-ID: <20250311124749.1219-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GE5J6lMl6WLxE-vt8FITaY-ZF5lrb9yn
X-Proofpoint-ORIG-GUID: GE5J6lMl6WLxE-vt8FITaY-ZF5lrb9yn
X-Authority-Analysis: v=2.4 cv=Rsc/LDmK c=1 sm=1 tr=0 ts=67d03797 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=lNgZ6EpQia3a2nAXriAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
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

Skip asymmetric test when virtio PMD is not loaded.

Fixes: 7e2e9d5f3227 ("test/crypto: add asymmetric cases for virtio")
Fixes: a8f3d4f5b547 ("test/crypto: add cases for virtio-user")

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index a98e3dc824..2377a18c72 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -4111,7 +4111,7 @@ test_cryptodev_virtio_asym(void)
 			RTE_STR(CRYPTODEV_NAME_VIRTIO_PMD));
 	if (gbl_driver_id == -1) {
 		RTE_LOG(ERR, USER1, "virtio PMD must be loaded.\n");
-		return TEST_FAILED;
+		return TEST_SKIPPED;
 	}
 
 	/* Use test suite registered for crypto_virtio PMD */
@@ -4125,7 +4125,7 @@ test_cryptodev_virtio_user_asym(void)
 			RTE_STR(CRYPTODEV_NAME_VIRTIO_USER_PMD));
 	if (gbl_driver_id == -1) {
 		RTE_LOG(ERR, USER1, "virtio user PMD must be loaded.\n");
-		return TEST_FAILED;
+		return TEST_SKIPPED;
 	}
 
 	/* Use test suite registered for crypto_virtio_user PMD */
-- 
2.25.1

