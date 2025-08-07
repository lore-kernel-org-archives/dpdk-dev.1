Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB28C87FCB
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 02:49:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01AA94026A;
	Thu,  7 Aug 2025 04:49:41 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 4EA9340264
 for <dev@dpdk.org>; Thu,  7 Aug 2025 04:49:39 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4byBS369dNztT8g;
 Thu,  7 Aug 2025 10:48:35 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 31C6F1402C7;
 Thu,  7 Aug 2025 10:49:37 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 10:49:36 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <mb@smartsharesystems.com>,
 <david.marchand@redhat.com>, <roretzla@linux.microsoft.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v5] eal: fix uncheck lcore role
Date: Thu, 7 Aug 2025 10:49:36 +0800
Message-ID: <20250807024936.2039379-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250724112551.2502389-1-huangdengdui@huawei.com>
References: <20250724112551.2502389-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Only the lcore whose role is ROLE_RTE or ROLE_SERVICE can be
launched. This patch adds the lcore role check.

In addition, update the function's documentation to explain
the range of lcores.

Fixes: a95d70547c57 ("eal: factorize lcore main loop")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/eal/common/eal_common_launch.c | 7 +++++++
 lib/eal/include/rte_launch.h       | 8 +++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/eal/common/eal_common_launch.c b/lib/eal/common/eal_common_launch.c
index a7deac6ecd..be7226e4b6 100644
--- a/lib/eal/common/eal_common_launch.c
+++ b/lib/eal/common/eal_common_launch.c
@@ -36,8 +36,15 @@ RTE_EXPORT_SYMBOL(rte_eal_remote_launch)
 int
 rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int worker_id)
 {
+	enum rte_lcore_role_t role;
 	int rc = -EBUSY;
 
+	role = lcore_config[worker_id].core_role;
+	if (role != ROLE_RTE && role != ROLE_SERVICE) {
+		rc = -EINVAL;
+		goto finish;
+	}
+
 	/* Check if the worker is in 'WAIT' state. Use acquire order
 	 * since 'state' variable is used as the guard variable.
 	 */
diff --git a/lib/eal/include/rte_launch.h b/lib/eal/include/rte_launch.h
index f7bf9f6b2d..a2d89e89f1 100644
--- a/lib/eal/include/rte_launch.h
+++ b/lib/eal/include/rte_launch.h
@@ -58,11 +58,13 @@ typedef int (lcore_function_t)(void *);
  * @param arg
  *   The argument for the function.
  * @param worker_id
- *   The identifier of the lcore on which the function should be executed.
+ *   The identifier of the lcore on which the function should be executed,
+ *   which MUST be between 0 and RTE_MAX_LCORE-1.
  * @return
  *   - 0: Success. Execution of function f started on the remote lcore.
  *   - (-EBUSY): The remote lcore is not in a WAIT state.
  *   - (-EPIPE): Error reading or writing pipe to worker thread
+ *   - (-EINVAL): The role of the remote lcore is neither ROLE_RTE nor ROLE_SERVICE.
  */
 int rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned worker_id);
 
@@ -105,7 +107,7 @@ int rte_eal_mp_remote_launch(lcore_function_t *f, void *arg,
  * To be executed on the MAIN lcore only.
  *
  * @param worker_id
- *   The identifier of the lcore.
+ *   The identifier of the lcore, which MUST be between 0 and RTE_MAX_LCORE-1.
  * @return
  *   The state of the lcore.
  */
@@ -120,7 +122,7 @@ enum rte_lcore_state_t rte_eal_get_lcore_state(unsigned int worker_id);
  * the lcore finishes its job and moves to the WAIT state.
  *
  * @param worker_id
- *   The identifier of the lcore.
+ *   The identifier of the lcore, which MUST be between 0 and RTE_MAX_LCORE-1.
  * @return
  *   - 0: If the remote launch function was never called on the lcore
  *     identified by the worker_id.
-- 
2.33.0

