Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63986CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 01:28:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD2840659;
	Wed, 27 Aug 2025 03:28:38 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 9A6A54028F
 for <dev@dpdk.org>; Wed, 27 Aug 2025 03:28:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cBRjK55vHztTNk;
 Wed, 27 Aug 2025 09:27:33 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 646441402DB;
 Wed, 27 Aug 2025 09:28:31 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 09:28:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>, <kevin.laatz@intel.com>
Subject: [PATCH 2/2] test/dma: support auto adapt ringsize
Date: Wed, 27 Aug 2025 09:28:29 +0800
Message-ID: <20250827012829.40752-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250827012829.40752-1-fengchengwen@huawei.com>
References: <20250827012829.40752-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

The default ringsize is 512, some DMA devices may not support, this
commit support auto adapt ringsize.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_dmadev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 482d564f7a..e1a919cd81 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -1135,7 +1135,7 @@ test_dmadev_setup(void)
 	int16_t dev_id = test_dev_id;
 	struct rte_dma_stats stats;
 	const struct rte_dma_conf conf = { .nb_vchans = 1};
-	const struct rte_dma_vchan_conf qconf = {
+	struct rte_dma_vchan_conf qconf = {
 			.direction = RTE_DMA_DIR_MEM_TO_MEM,
 			.nb_desc = TEST_RINGSIZE,
 	};
@@ -1151,6 +1151,10 @@ test_dmadev_setup(void)
 	if (rte_dma_configure(dev_id, &conf) != 0)
 		ERR_RETURN("Error with rte_dma_configure()\n");
 
+	if (qconf.nb_desc < info.min_desc)
+		qconf.nb_desc = info.min_desc;
+	if (qconf.nb_desc > info.max_desc)
+		qconf.nb_desc = info.max_desc;
 	if (rte_dma_vchan_setup(dev_id, vchan, &qconf) < 0)
 		ERR_RETURN("Error with queue configuration\n");
 
-- 
2.17.1

