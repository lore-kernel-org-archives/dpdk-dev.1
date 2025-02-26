Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7FBC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 18:44:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 181AD40658;
	Wed, 26 Feb 2025 19:44:52 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 361D040650;
 Wed, 26 Feb 2025 19:44:50 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QCj8EW008119;
 Wed, 26 Feb 2025 10:44:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 uOus+kblO3E0kLXqz2O6ZZ/hYF/aOY2AkpaUXU0yco=; b=cuD2PzMqDnWEXY9vh
 NZA/kBdWj/frWrcOZgSRGT6bncoc2PLCn8XaXJIT/ifl6eZvsUWCiCgi2BRPMI8N
 lu+O/PS9xmx5Ha8hdLyGeOcSh5a6VrnGYoKorEUSq7RL5PxIiZPofA/VGmQ6tzOd
 vpVv4anq0+UhGvh1es0tlJPkdk/hFny8Obz2jJ2gypflS0uBE8L5nT0pbnw6/kZr
 hX5IrKa4ueFemhB47u77VWv8rtaqfTL8lHb//e4vdNoMFZpdwDaNfbnUaLjXynMI
 1tRP3MB3mLr/R++NF+fUhAPm5XSYyMqwIVZ2YxJWillBv4kwmWctfTMhffak1jTp
 x4KiA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 451yn39bqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 10:44:49 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Feb 2025 10:44:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Feb 2025 10:44:48 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.81])
 by maili.marvell.com (Postfix) with ESMTP id DCF113F7074;
 Wed, 26 Feb 2025 10:44:44 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, Jay Zhou
 <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [v6 3/5] examples/vhost_crypto: fix user callbacks
Date: Thu, 27 Feb 2025 00:13:14 +0530
Message-ID: <5e77e6ac5f3fcf3200b6eb7993868ae9745f63a0.1740594750.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1740594750.git.gmuthukrishn@marvell.com>
References: <cover.1740594750.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Znf7EQviicktb9ZeeQLBfYk_28RaQBDe
X-Authority-Analysis: v=2.4 cv=BLRJrEQG c=1 sm=1 tr=0 ts=67bf6121 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=T2h4t0Lz3GQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=cGNggxaUmQD6pPA5iYsA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Znf7EQviicktb9ZeeQLBfYk_28RaQBDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
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

