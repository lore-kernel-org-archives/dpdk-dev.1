Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB844CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 02:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B56BF40430;
	Tue, 12 Aug 2025 04:07:13 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 91BC7402AC
 for <dev@dpdk.org>; Tue, 12 Aug 2025 04:07:11 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c1FBy1j3xzdcD6;
 Tue, 12 Aug 2025 10:02:50 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 7B09B14027D;
 Tue, 12 Aug 2025 10:07:09 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 10:07:08 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
Subject: [PATCH 01/10] app/dma-perf: fix use-after-free
Date: Tue, 12 Aug 2025 10:06:59 +0800
Message-ID: <20250812020708.16186-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250812020708.16186-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20250812020708.16186-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

The test_case->eal_args was pointer the entry of cfgfile, it will be
used later, but the cfgfile was closed in load_configs(). This commit
fix it by using strdup.

Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-dma-perf/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 0586b3e1d0..25a79d1d6c 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -480,6 +480,8 @@ load_configs(const char *path)
 					section_name, "test_seconds"));
 
 		test_case->eal_args = rte_cfgfile_get_entry(cfgfile, section_name, "eal_args");
+		if (test_case->eal_args != NULL)
+			test_case->eal_args = strdup(test_case->eal_args);
 		test_case->is_valid = true;
 	}
 
-- 
2.17.1

