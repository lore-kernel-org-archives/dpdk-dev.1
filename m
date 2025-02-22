Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF5C021B5
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 08:38:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BE1D42DBE;
	Sat, 22 Feb 2025 09:38:42 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 814E742D92;
 Sat, 22 Feb 2025 09:38:40 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M7qqIX027137;
 Sat, 22 Feb 2025 00:38:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 YonoalNQQSixPltyzXp+uATv/njmi/FQlrBddclzCs=; b=G1dwEn2y8xLbllfi1
 +0NxMd+g2cRhreqj+do3O/1vzOevUhVdXsctGwzwl48WFubzbGgfe6+uSUPcGbbl
 R5a4DDFLvDciNLtVpo+jtUeR4PxTGNsZTzJA1xajaf4YMKpFNlFdETWPFawbOtAV
 9vAUFQD+5EVvzIeppPWGCk+bZJCYy1kODQABHA+vCgUM0X05YHeVU+vrpaJqjIDF
 GpvuoLcUEDAI+KIQmA5zx9j30vzJ8K2tYhMAFwEI5Tj6inudIMkEClAqlgY1BQwl
 7lImUYiQL6sC+rpBSjmC4mL1zn4je6iHh1VkOk2rusxPK2R7n+jP7Pe0mzhHp1DD
 oWZuQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44xnxua9a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 22 Feb 2025 00:38:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 22 Feb 2025 00:38:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 22 Feb 2025 00:38:38 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 988A25B6938;
 Sat, 22 Feb 2025 00:38:34 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, Jay Zhou
 <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v4 3/5] examples/vhost_crypto: fix user callbacks
Date: Sat, 22 Feb 2025 14:08:08 +0530
Message-ID: <cd9c3a5f248ee8b6c0ad174a003993875bb3ee97.1740212213.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740212213.git.gmuthukrishn@marvell.com>
References: <cover.1740212213.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KWBi-0Et_3qwgNtPbff9HSFbNZ4qnzQ4
X-Proofpoint-ORIG-GUID: KWBi-0Et_3qwgNtPbff9HSFbNZ4qnzQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_03,2025-02-20_02,2024-11-22_01
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

In order to handle new vhost user connection, use new_connection
and destroy_connection callbacks.

Fixes: f5188211c721 ("examples/vhost_crypto: add sample application")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 examples/vhost_crypto/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 558c09a60f..b1fe4120b9 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -362,8 +362,8 @@ destroy_device(int vid)
 }
 
 static const struct rte_vhost_device_ops virtio_crypto_device_ops = {
-	.new_device =  new_device,
-	.destroy_device = destroy_device,
+	.new_connection =  new_device,
+	.destroy_connection = destroy_device,
 };
 
 static int
-- 
2.25.1

