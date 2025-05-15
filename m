Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9596DC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 08:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AC9440667;
	Thu, 15 May 2025 10:03:22 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 83C86402C2
 for <dev@dpdk.org>; Thu, 15 May 2025 10:03:20 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ENTKYv005188;
 Thu, 15 May 2025 01:03:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=kIlNk+XrC4Ro0vczH8ppJpi
 DBIv3FDWhTHC7E38Gbno=; b=EQUZ4biJrkzVy7yqYjJKVNMSMWteDZL9HdlvRt/
 xMDrCwW5k+0/pjiIaWgpdpkl6A2mMEg5O3DF8KyKl0UiraeDHu2bzAEbUb5TCJlA
 +ovFSdrUN4Jo4O9+PdFYnRJSV8Pksh79aauv48LpSYlki/ufJU2BuakuSC2dYEJN
 uYjPO7Yh/ZibJLjxsFSFmrEGqGVEGDbUeBhrfOwqAPDuYKm+6rTebIN5dqmpCMpd
 /AF6EIir6c7U1ROeMJ1EGSvZpv9D5GA+wEHCDuV/dH5zTBHYvyZDbOoAojV+oF/n
 VBwSrCZ+E5ItMl5e2Vgy+GDFCQ9IaC2t7OEj96HX+vKl7XA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46n4vtgtxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 01:03:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 01:03:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 01:03:18 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 0DA0D3F7085;
 Thu, 15 May 2025 01:03:15 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, Akhil Goyal <gakhil@marvell.com>
CC: <anoobj@marvell.com>
Subject: [PATCH] crypto/virtio: check for invalid IOVA address
Date: Thu, 15 May 2025 13:33:10 +0530
Message-ID: <20250515080313.1612-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Osyn7VxjXue8OcQw-o_YLNaZyNjq85m6
X-Authority-Analysis: v=2.4 cv=RMCzH5i+ c=1 sm=1 tr=0 ts=68259fc7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=Cb---znmh0XTWwkaO8YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Osyn7VxjXue8OcQw-o_YLNaZyNjq85m6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA3NyBTYWx0ZWRfX1pNlVxyZ1Vwu
 Nfo+oWeLseXPNC47UWsA9kTqd7C1ZBe7cjkytBakwn4FOLz5Am214PEke1onKXhyLMG57fUIGBh
 OmbgMlSoN4ZDQws4TVqDgP6+Pd7ng2Gm+sbKZC+fDTMMzTlIoA52UpW3xgo3PP1qvMZecSNFIxA
 Cah2EAQcj3vFApy5dEZXy1/T8j4GKObwK++sSCYfqGnkHu4K9VoqvXI0rFNNxkO4aYGChhy4BLD
 UKJHVtp67V7auF9ZB3FBQY4SpJviM+OMfhPNt1l/6KzXm49N0/CBds53MQiXeliD1zXaeWM1Jci
 tmUNoTFvq+wDVhM6Urtec7csdGu4gQHzMxRPsqBFiziqHkaDYWDs2xHDrrulzQflmrLarl0LNQQ
 3giX8TDySJSNah+uZcahUQJ6/3iDkgffvZViPHfsTuGVrb4UOkQRjRZjm+rmBe8RVUHX1Zwp
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

This change fixes coverity issue on overflowed constant.
Bad phys address should be checked before using it in
descriptor.

Coverity issue: 457462, 457465
Fixes: 10702138f1a ("crypto/virtio: support asymmetric RSA")

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/virtio/virtio_cryptodev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index bc737f1e68..fa215fe528 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -799,6 +799,10 @@ virtio_crypto_clear_session(
 	}
 
 	malloc_phys_addr = rte_malloc_virt2iova(ctrl);
+	if (malloc_phys_addr == RTE_BAD_IOVA) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("malloc_phys_addr is invalid");
+		return;
+	}
 
 	/* status part */
 	status = &(((struct virtio_crypto_inhdr *)
@@ -916,6 +920,10 @@ virtio_crypto_clear_session_packed(
 	}
 
 	malloc_phys_addr = rte_malloc_virt2iova(ctrl);
+	if (malloc_phys_addr == RTE_BAD_IOVA) {
+		VIRTIO_CRYPTO_SESSION_LOG_ERR("malloc_phys_addr is invalid");
+		return;
+	}
 
 	/* status part */
 	status = &(((struct virtio_crypto_inhdr *)
-- 
2.25.1

