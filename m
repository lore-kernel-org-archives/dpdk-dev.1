Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E929ACA0FF0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 01:28:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B14654029E;
	Wed, 27 Aug 2025 03:28:35 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 927784029E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 03:28:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cBRdK11bfzdcTf;
 Wed, 27 Aug 2025 09:24:05 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 1C08A180495;
 Wed, 27 Aug 2025 09:28:31 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 09:28:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>, <kevin.laatz@intel.com>
Subject: [PATCH 1/2] test/dma: fix some testcase never fail
Date: Wed, 27 Aug 2025 09:28:28 +0800
Message-ID: <20250827012829.40752-2-fengchengwen@huawei.com>
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

In the runtest() function, it will return error if the test return
value is less than 0.

But the 'copy' and 'error_handling' testcase may return 1 if failed
because its internal use or(||) operation.

This commit fix it by treating non-zero as error in runtest() function.

Fixes: 1b86a66a30c2 ("test/dma: add more comprehensive copy tests")
Fixes: 99d7ec4be237 ("test/dma: add failure handling tests")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_dmadev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 9cbb9a6552..482d564f7a 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -92,7 +92,7 @@ runtest(const void *args)
 	printf("DMA Dev %d: Running %s Tests %s\n", dev_id, printable,
 			check_err_stats ? " " : "(errors expected)");
 	for (i = 0; i < iterations; i++) {
-		if (test_fn(dev_id, vchan) < 0)
+		if (test_fn(dev_id, vchan) != 0)
 			return -1;
 
 		rte_dma_stats_get(dev_id, 0, &stats);
-- 
2.17.1

