Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25BC606A327
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=bAJzuIBO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 398344067D;
	Wed, 25 Nov 2026 15:06:35 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTPS id 687C040430
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:29 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=wm5WG7VavWH6psgnBBRQM7v96Iiko05ukyOcDE7cesY=;
 b=bAJzuIBOcwc4Vxe0/oSJlnNwgXHCticzA2WC+GMwofetkS55zOWjRcoH96g/a1ou5iCxQ0Il0
 4Y48/+M0kHze0vrHSOvmtvKP8M+tjyKQ7J0/uzLYMnnrAKHyRxK1lGlu5GiPrl9q/9q1rL3z+jN
 jhkaV62w/+G8aVmVoLhPWQ4=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jZM0V5NlFz1cyVb;
 Wed, 25 Nov 2026 22:06:02 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 16A0340578;
 Wed, 25 Nov 2026 22:06:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:26 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 7/9] power: add detect callback for uncore driver
Date: Wed, 25 Nov 2026 22:06:13 +0800
Message-ID: <20261125140616.3965843-8-yangshuaisong@h-partners.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
References: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Huisong Li <lihuisong@huawei.com>

The automatic uncore driver detection currently probes drivers by
calling their init() and exit() callbacks on package 0 and die 0,
which may have side effects on the system.

Add an optional detect() callback to struct rte_power_uncore_ops so
a driver can check platform support, e.g. sysfs entries or device
nodes, without a full initialization. power_uncore_probe_driver()
uses detect() when available and falls back to the existing
init/exit probing for drivers without one.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 lib/power/power_uncore_ops.h | 17 +++++++++++++++++
 lib/power/rte_power_uncore.c | 11 ++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/lib/power/power_uncore_ops.h b/lib/power/power_uncore_ops.h
index 025a55cb97..e3c8f0b741 100644
--- a/lib/power/power_uncore_ops.h
+++ b/lib/power/power_uncore_ops.h
@@ -183,11 +183,28 @@ typedef unsigned int (*rte_power_uncore_get_num_pkgs_t)(void);
 typedef unsigned int (*rte_power_uncore_get_num_dies_t)(unsigned int pkg);
 typedef void (*rte_power_uncore_driver_cb_t)(void);
 
+/**
+ * Detect if the current platform supports this uncore frequency management driver.
+ *
+ * This callback is used during automatic driver detection to check whether
+ * the platform has the necessary hardware/software support (e.g., sysfs
+ * entries, device nodes) without performing a full initialization that may
+ * have side effects.
+ *
+ * This function should NOT be called in the fast path.
+ *
+ * @return
+ *  - 0 on success, the platform supports this driver.
+ *  - Negative on error, the platform does not support this driver.
+ */
+typedef int (*rte_power_uncore_detect_t)(void);
+
 /** Structure defining uncore power operations structure */
 struct rte_power_uncore_ops {
 	RTE_TAILQ_ENTRY(rte_power_uncore_ops) next;     /**< Next in list. */
 	char name[RTE_POWER_UNCORE_DRIVER_NAMESZ];      /**< power mgmt driver. */
 	rte_power_uncore_driver_cb_t cb;                /**< Driver specific callbacks. */
+	rte_power_uncore_detect_t detect;               /**< Detect platform support. */
 	rte_power_uncore_init_t init;                   /**< Initialize power management. */
 	rte_power_uncore_exit_t exit;                   /**< Exit power management. */
 	rte_power_uncore_get_num_pkgs_t get_num_pkgs;
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index cd2b2a51d5..1ec029702b 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -66,11 +66,16 @@ power_uncore_probe_driver(void)
 	int ret;
 
 	global_uncore_ops = NULL;
-	/* Use package-0 and die-0 to probe uncore driver. */
 	RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next) {
-		ret = ops->init(0, 0);
+		if (ops->detect) {
+			ret = ops->detect();
+		} else {
+			/* Use package-0 and die-0 to probe uncore driver. */
+			ret = ops->init(0, 0);
+			if (ret == 0)
+				ops->exit(0, 0);
+		}
 		if (ret == 0) {
-			ops->exit(0, 0);
 			env = power_uncore_driver_name2env(ops->name);
 			if (env == UINT32_MAX)
 				continue;
-- 
2.33.0

