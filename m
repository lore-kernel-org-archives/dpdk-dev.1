Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A77C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 09:29:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13A3D4065F;
	Wed, 14 May 2025 11:29:52 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2B2894065F
 for <dev@dpdk.org>; Wed, 14 May 2025 11:29:51 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIUaoC005458;
 Wed, 14 May 2025 02:29:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 YoA2pncIY2c/CikUearahTuDBhfDsiwhX/3m6MG5AA=; b=PbNG2C4soA7EDG1Wm
 h13zHjyBVSIc2NSwz+Le77fRlKDECmtBFSj6RAz0y/Vt+HZx5W+wvl3Hmy4dwM+w
 E8I19r9QQaopCHGxS+ika3gHlzeIemRQYQQfzB0bG0QYaNKyTfaKJ//16z0AAe37
 E+10Q6LiHoncBKX/o+iulqCxiz+toBMYedDAQz/Am9HVgicf2fZDE/j2WZWid8gN
 +Rbhfs0mI+4ab95WNNaluAshy4av9RDlitmI4OS4WVJhTPqNfh5qj/uZ+NTyWbhx
 mshn19O+X6lCaoPtN/TYdUfpSqy0TPGjRCidAEFkh4UkUt/Dy8QQIzjC1v6QGtTB
 FRRqw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mbe21f1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 02:29:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 14 May 2025 02:29:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 14 May 2025 02:29:49 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 5F10F3F7040;
 Wed, 14 May 2025 02:29:47 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v2] test/crypto: increment dequeue timeout
Date: Wed, 14 May 2025 14:59:38 +0530
Message-ID: <20250514092941.1558-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250421064708.1777-1-gmuthukrishn@marvell.com>
References: <20250421064708.1777-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hM27yfNicWTWPQsIy-jzTYDDAv0Q86at
X-Authority-Analysis: v=2.4 cv=fbyty1QF c=1 sm=1 tr=0 ts=6824628e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=3O7H7lqxqWkCj1SWBtEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: hM27yfNicWTWPQsIy-jzTYDDAv0Q86at
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA4MyBTYWx0ZWRfX3XHPweT1Xtk5
 lZPSZzqyZ6TuvhfG/cSTh9DsW5waBD+ea+xwI7BbLynQiV13WV2F4SHalgs5zONhQ15sh1ZBhSp
 pf/kFU8pxhUSftkP82naiGxvx9B2dQA4pkHEFPXwBmIL6F8QiRjBYsso6bLkBDS5xAf3FSArU2s
 B/lBDlbD8pdr1qP8QhjQS7ElHIaidSTwUYJpQVmm+kWm7VAdtPZLua9c4atI0+NUG8rgpTp0FrS
 VPRUPbU72YfGrS/vHdEIpWeDddnKNWqkTl6gEqbZl7XQklQS2P69YftwgNKz+AzX2YwROCgNQu4
 t1iMi/iDk2EQTr2Ol8kwdSY/wfyiHX9VjqWl7e+FS5b++qyOUtPOEFLasNGSG4w8pDc13HD6gua
 d6RqOZQjXr8hK5RQNggSPlmV0i5I5xJ7DJTom7AFpFGWXNb0JwqrB0WeAeT8QJldK6DVrRo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
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
v2:
 - no changes. only for CI.
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

