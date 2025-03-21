Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8ADC35FFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 04:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E0B440674;
	Fri, 21 Mar 2025 05:03:25 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 29FC040276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 05:03:22 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZJph90bVhz1d0Zv;
 Fri, 21 Mar 2025 12:03:05 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id D46A31402CC;
 Fri, 21 Mar 2025 12:03:20 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Mar 2025 12:03:20 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>, 
 <liuyonglong@huawei.com>, <stephen@networkplumber.org>
Subject: [PATCH 2/2] app/dma-perf: fix infinite loop
Date: Fri, 21 Mar 2025 12:03:16 +0800
Message-ID: <20250321040316.104126-3-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250321040316.104126-1-huangdengdui@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

When a core that is not used by the rte is specified in the config
for testing, the problem of infinite loop occurs. The root cause
is that the program waits for the completion of the test task when
the test worker fails to be started on the lcore. This patch fix it.

Fixes: 533d7e7f66f3 ("app/dma-perf: support config per device")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 app/test-dma-perf/benchmark.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 6d617ea200..351c1c966e 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -751,7 +751,10 @@ mem_copy_benchmark(struct test_configure *cfg)
 				goto out;
 		}
 
-		rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id);
+		if (rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id)) {
+			printf("Error: Fail to start the test on lcore %d\n", lcore_id);
+			goto out;
+		}
 	}
 
 	while (1) {
-- 
2.33.0

