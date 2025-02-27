Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8EC19F32
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 14:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA0840B9A;
	Thu, 27 Feb 2025 15:00:32 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1DF2E40B9A;
 Thu, 27 Feb 2025 15:00:31 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RDlOCq028948;
 Thu, 27 Feb 2025 06:00:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 uOus+kblO3E0kLXqz2O6ZZ/hYF/aOY2AkpaUXU0yco=; b=F69jLIoVJQhjkUpuw
 fGaH35D2H0isOWcCnJzKSGp6Q5pRnwuWMq7rlXQPoj2v3AtZ46NDeuYzLpE2LUK8
 Vpds3Os4fMIw2cGpPv6hCrPWTZfJsUKzX89UkwcmBL1W8fXDLz0BXJHZDylnCQ4c
 LNrLad80ExlkzXwlVgxl3loPxWRkM4RhYMSfgMSu/6wdXnR8MOpRl9OsLJ87oWAL
 h1uThdgE8paLyAWeoe6cCYzkyHhHVXgnkfanyAJsMYsrIThmSbkUwcZ9kxyoJv/j
 5C2aj3xZISlmuNdLpHM3CVCFIbNQ0cKEfutoC73cj44JBoiRF3ATJTS8TxmApU0r
 hnpcQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 452s4dg132-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 06:00:30 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 06:00:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 06:00:29 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 640F45B692C;
 Thu, 27 Feb 2025 06:00:26 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, Jay Zhou
 <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v7 3/5] examples/vhost_crypto: fix user callbacks
Date: Thu, 27 Feb 2025 19:29:47 +0530
Message-ID: <bd24bedb384dbf40876ef1be0b26697f96ffd387.1740664527.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740664527.git.gmuthukrishn@marvell.com>
References: <cover.1740664527.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dQMd0R2unTVkWjoqGbWo6NsL4dw9PDE9
X-Authority-Analysis: v=2.4 cv=Kqy32XWN c=1 sm=1 tr=0 ts=67c06ffe cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=T2h4t0Lz3GQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=cGNggxaUmQD6pPA5iYsA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: dQMd0R2unTVkWjoqGbWo6NsL4dw9PDE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
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
Acked-by: Akhil Goyal <gakhil@marvell.com>
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

