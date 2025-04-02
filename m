Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE6BC3601A
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 12:25:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4488240275;
	Wed,  2 Apr 2025 14:25:02 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 4434640273
 for <dev@dpdk.org>; Wed,  2 Apr 2025 14:24:59 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZSPGR32F7z27hJh;
 Wed,  2 Apr 2025 20:25:35 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 4F1BB1402D0;
 Wed,  2 Apr 2025 20:24:56 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 20:24:55 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>, <roretzla@linux.microsoft.com>,
 <dmitry.kozliuk@gmail.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <mb@smartsharesystems.com>
Subject: [PATCH v3 1/3] eal: fix uncheck lcore ID
Date: Wed, 2 Apr 2025 20:24:52 +0800
Message-ID: <20250402122454.2148612-2-huangdengdui@huawei.com>
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

The worker_id may come from user input.
So it is necessary to verify it.

Fixes: a95d70547c57 ("eal: factorize lcore main loop")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/eal/common/eal_common_launch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
index 5320c3bd3c..a06c402edf 100644
--- a/lib/eal/common/eal_common_launch.c
+++ b/lib/eal/common/eal_common_launch.c
@@ -18,6 +18,9 @@
 int
 rte_eal_wait_lcore(unsigned worker_id)
 {
+	if (unlikely(worker_id >= RTE_MAX_LCORE))
+		return -EINVAL;
+
 	while (rte_atomic_load_explicit(&lcore_config[worker_id].state,
 			rte_memory_order_acquire) != WAIT)
 		rte_pause();
@@ -35,6 +38,9 @@ rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
 {
 	int rc = -EBUSY;
 
+	if (unlikely(worker_id >= RTE_MAX_LCORE))
+		return -EINVAL;
+
 	/* Check if the worker is in 'WAIT' state. Use acquire order
 	 * since 'state' variable is used as the guard variable.
 	 */
@@ -93,6 +99,9 @@ rte_eal_mp_remote_launch(int (*f)(void *), void *arg,
 enum rte_lcore_state_t
 rte_eal_get_lcore_state(unsigned lcore_id)
 {
+	if (unlikely(lcore_id >= RTE_MAX_LCORE))
+		return -EINVAL;
+
 	return lcore_config[lcore_id].state;
 }
 
-- 
2.33.0

