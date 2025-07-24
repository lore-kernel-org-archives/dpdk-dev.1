Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C98C83F26
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 11:25:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A0C140285;
	Thu, 24 Jul 2025 13:25:57 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 00FEB40262
 for <dev@dpdk.org>; Thu, 24 Jul 2025 13:25:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bnpcY0TY1z27hFx;
 Thu, 24 Jul 2025 19:26:53 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 9A885140295;
 Thu, 24 Jul 2025 19:25:52 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 19:25:52 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <mb@smartsharesystems.com>,
 <david.marchand@redhat.com>, <roretzla@linux.microsoft.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v4] eal: fix uncheck lcore ID and lcore role
Date: Thu, 24 Jul 2025 19:25:51 +0800
Message-ID: <20250724112551.2502389-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250321040316.104126-1-huangdengdui@huawei.com>
References: <20250321040316.104126-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

The worker_id may come from user input. So it is necessary to verify it.

In addition, only the lcore whose role is ROLE_RTE or ROLE_SERVICE can be
launched. This patch adds the lcore role check.

Fixes: a95d70547c57 ("eal: factorize lcore main loop")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/eal/common/eal_common_launch.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
index a7deac6ecd..09366ea404 100644
--- a/lib/eal/common/eal_common_launch.c
+++ b/lib/eal/common/eal_common_launch.c
@@ -20,6 +20,9 @@ RTE_EXPORT_SYMBOL(rte_eal_wait_lcore)
 int
 rte_eal_wait_lcore(unsigned worker_id)
 {
+	if (unlikely(worker_id >= RTE_MAX_LCORE))
+		return -EINVAL;
+
 	while (rte_atomic_load_explicit(&lcore_config[worker_id].state,
 			rte_memory_order_acquire) != WAIT)
 		rte_pause();
@@ -37,6 +40,18 @@ int
 rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
 {
 	int rc = -EBUSY;
+	uint8_t role;
+
+	if (unlikely(worker_id >= RTE_MAX_LCORE)) {
+		rc = -EINVAL;
+		goto finish;
+	}
+
+	role = lcore_config[worker_id].core_role;
+	if (role != ROLE_RTE && role != ROLE_SERVICE) {
+		rc = -EINVAL;
+		goto finish;
+	}
 
 	/* Check if the worker is in 'WAIT' state. Use acquire order
 	 * since 'state' variable is used as the guard variable.
@@ -98,6 +113,9 @@ RTE_EXPORT_SYMBOL(rte_eal_get_lcore_state)
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

