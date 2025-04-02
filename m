Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A6C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 12:25:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D42940430;
	Wed,  2 Apr 2025 14:25:03 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 3EE1540261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 14:25:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZSPD406B3ztRZd;
 Wed,  2 Apr 2025 20:23:32 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 290C31800E5;
 Wed,  2 Apr 2025 20:24:57 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 20:24:56 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>, <roretzla@linux.microsoft.com>,
 <dmitry.kozliuk@gmail.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <mb@smartsharesystems.com>
Subject: [PATCH v3 3/3] app/dma-perf: fix infinite loop
Date: Wed, 2 Apr 2025 20:24:54 +0800
Message-ID: <20250402122454.2148612-4-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250402122454.2148612-1-huangdengdui@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <20250402122454.2148612-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
for testing, the problem of infinite loop occurs. This patch fix it
by adding a check for lcore_id.

Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 app/test-dma-perf/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 0586b3e1d0..1365456dd1 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -523,7 +523,7 @@ main(int argc, char *argv[])
 {
 	int ret;
 	uint16_t case_nb;
-	uint32_t i, nb_lcores;
+	uint32_t i, j, nb_lcores, lcore;
 	pid_t cpid, wpid;
 	int wstatus;
 	char args[MAX_EAL_PARAM_NB][MAX_EAL_PARAM_LEN];
@@ -603,6 +603,12 @@ main(int argc, char *argv[])
 			if (nb_lcores < 2)
 				rte_exit(EXIT_FAILURE,
 					"There should be at least 2 worker lcores.\n");
+			for (j = 0; j < test_cases[i].num_worker; j++) {
+				lcore = test_cases[i].dma_config[j].lcore_dma_map.lcore;
+				if (!rte_lcore_has_role(lcore, ROLE_RTE))
+					rte_exit(EXIT_FAILURE,
+						 "Worker lcore %u not enabled in EAL\n", lcore);
+			}
 
 			fd = fopen(rst_path_ptr, "a");
 			if (!fd) {
-- 
2.33.0

