Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E4BC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 09:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDC434026C;
	Tue, 29 Apr 2025 11:58:24 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2A7D840263
 for <dev@dpdk.org>; Tue, 29 Apr 2025 11:58:23 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T6ngXh024868;
 Tue, 29 Apr 2025 02:58:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=IEwryKKpJJfZ1EdqL9fFSGE
 1iufQxjaqLMKGVsTobLU=; b=Uogco3Q8e6snm0zvkf4jZAhWGYszQDXDhtdMKfC
 ytvWLGZH3HGajF7MmTmdthOoS9t3zf3zmT9oFwlAt4Iz25paui8NSMkiAjqs3/ml
 GUSvOrHYRQC5mq1xM3NUNBhn5WwEzl1KiByMNiCpCwfQ6EE969WpxtnMADAWyiQQ
 aJWLM1xU1vNVo5YzVL1dAWkKZwa7hb3HBIFTKVc9Cie7YDawuXVq98qijEUqmmdv
 s2NKSPZoXRCZQkcnn3pcFDakbkOC6RQzznyCy7tpC5tAbvX3pfXwwo44zP5Cd0Ea
 QLSvaPJhl9bPQNCvd2G+USkLsMl4mBBn+WZzZd4bSZqhA5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 469krcc7k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 02:58:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Apr 2025 02:58:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Apr 2025 02:58:20 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.77.34])
 by maili.marvell.com (Postfix) with ESMTP id 2A73F3F7045;
 Tue, 29 Apr 2025 02:58:17 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [PATCH] crypto/virtio: support RSA 8K mod ops
Date: Tue, 29 Apr 2025 15:28:10 +0530
Message-ID: <20250429095814.1881-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VeJXlaOATw8iBSCtoiXMHGdS5kV3JAxP
X-Authority-Analysis: v=2.4 cv=f61IBPyM c=1 sm=1 tr=0 ts=6810a2bd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=NvIv0wPN0YMeVG5OgtQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA3NCBTYWx0ZWRfX53asYpRudGNd
 DQt1t8jMCVuzKcWaggGYnR781FMteX5oA16o5Mex8rS/zGhOFc0d5GnKaWY+iYG3iziW50xoMap
 Bv7iNwh15eFqWLGQhO18uTVFeOaXA62fFWZ1lkXLWVkOmIn3oV6ANppp8sNsTG1Q091oDUIumm1
 bKfpBfPFP8EVo7jzV00a7/xAUvg/3QMyl7nWF45VbK7AB/gn3KXp4MLUEX9DM5cOGTF8r4D+xzr
 5kb9ccON5dgZhTWJvyuBI3r12v26hMtBKvTl074NAtECoT15apjufsObonjnM5ffCEbR64Of8h4
 GOr6ZDxzUybftZmJC5ZIKzuT0v518t0kmZwAnhycuSUhBQgWGPIiNZTocaDQ6c1dSfu2deU+Hdv
 Rk4neLx2l8ksprC6x2JXZJbpo5gQjMFij5OWE5J1O8Z9Fac6r6D6gnG6oGJEjHn7q1/ARzfO
X-Proofpoint-ORIG-GUID: VeJXlaOATw8iBSCtoiXMHGdS5kV3JAxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
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

Support RSA 8K mod ops in virtio PMD.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/virtio/virtio_cryptodev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.h b/drivers/crypto/virtio/virtio_cryptodev.h
index fad73d54a8..075b5ff444 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.h
+++ b/drivers/crypto/virtio/virtio_cryptodev.h
@@ -23,12 +23,12 @@
 
 #define VIRTIO_CRYPTO_MAX_IV_SIZE 16
 #define VIRTIO_CRYPTO_MAX_MSG_SIZE 512
-#define VIRTIO_CRYPTO_MAX_SIGN_SIZE 512
+#define VIRTIO_CRYPTO_MAX_SIGN_SIZE 1024
 #define VIRTIO_CRYPTO_MAX_CIPHER_SIZE 1024
 
 #define VIRTIO_CRYPTO_MAX_KEY_SIZE 256
 
-#define VIRTIO_CRYPTO_MAX_CTRL_DATA 2048
+#define VIRTIO_CRYPTO_MAX_CTRL_DATA 4096
 
 extern uint8_t cryptodev_virtio_driver_id;
 
-- 
2.25.1

