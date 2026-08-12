Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BFBC5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 09:53:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8127D40A73;
	Wed, 12 Aug 2026 11:53:16 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 631F540B9A
 for <dev@dpdk.org>; Wed, 12 Aug 2026 11:53:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=1mEKslBUiq0I7iWrBibWouWI89JCP6dhefHcYHYIupM=;
 b=Z5CfsYM+AU1hNQ/JEpeqLFEmBL8yK9l1xjcgSvmJazcSgT3d0AfkGXATKYd073WfknSYDvhLi
 /dEQoDhUkQEHGZLvBhjQOrCSzy194gBXXsPa/TmKfuKU8884TNnGVTDANABBd+urWscyMVcZhT4
 r30488xUFHtjOoj5By2qpak=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hKk712ZKgzLlXC;
 Wed, 12 Aug 2026 17:42:37 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 3F32840586;
 Wed, 12 Aug 2026 17:53:14 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Aug 2026 17:53:13 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v5 5/6] power: support automatic detection of uncore driver
Date: Wed, 12 Aug 2026 17:49:55 +0800
Message-ID: <20260812094956.3356537-6-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260812094956.3356537-1-lihuisong@huawei.com>
References: <20260812094956.3356537-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Currently, uncore driver library just supports intel_uncore
driver as default driver when user use AUTO_DETECT, please see
the commit 3b3af56d3c9c ("power: fix uncore configuration").
This is not good to use for application. So this patch support
probing for uncore drivers.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 doc/guides/rel_notes/release_26_11.rst |  6 ++++
 lib/power/rte_power_uncore.c           | 49 ++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..65438e8e3a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Support auto-detection of uncore power driver.**
+
+  The uncore power library now supports automatic probing of multiple
+  uncore drivers when using ``RTE_UNCORE_PM_ENV_AUTO_DETECT``,
+  instead of defaulting only to the Intel uncore driver.
+
 
 Removed Items
 -------------
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index b50e09a2ad..c50ff8d199 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  * Copyright(c) 2023 AMD Corporation
  */
+#include <errno.h>
 
 #include <eal_export.h>
 #include <rte_spinlock.h>
@@ -46,6 +47,42 @@ rte_power_register_uncore_ops(struct rte_power_uncore_ops *driver_ops)
 	return 0;
 }
 
+static uint32_t
+power_uncore_driver_name2env(const char *name)
+{
+	for (uint32_t i = 0; i < RTE_DIM(uncore_env_str); i++) {
+		if (!strcmp(name, uncore_env_str[i]))
+			return i;
+	}
+
+	return UINT32_MAX;
+}
+
+static int
+power_uncore_probe_driver(void)
+{
+	struct rte_power_uncore_ops *ops;
+	uint32_t env;
+	int ret;
+
+	global_uncore_ops = NULL;
+	/* Use package-0 and die-0 to probe uncore driver. */
+	RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next) {
+		ret = ops->init(0, 0);
+		if (ret == 0) {
+			ops->exit(0, 0);
+			env = power_uncore_driver_name2env(ops->name);
+			if (env == UINT32_MAX)
+				continue;
+			global_uncore_env = env;
+			global_uncore_ops = ops;
+			break;
+		}
+	}
+
+	return global_uncore_ops != NULL ? 0 : -ENODEV;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_set_uncore_env, 23.11)
 int
 rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
@@ -60,12 +97,12 @@ rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 		goto out;
 	}
 
-	if (env == RTE_UNCORE_PM_ENV_AUTO_DETECT)
-		/* Currently only intel_uncore is supported.
-		 * This will be extended with auto-detection support
-		 * for multiple uncore implementations.
-		 */
-		env = RTE_UNCORE_PM_ENV_INTEL_UNCORE;
+	if (env == RTE_UNCORE_PM_ENV_AUTO_DETECT) {
+		ret = power_uncore_probe_driver();
+		if (ret != 0)
+			POWER_LOG(ERR, "Probe uncore driver failed, ret = %d", ret);
+		goto out;
+	}
 
 	if (env < RTE_DIM(uncore_env_str)) {
 		RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next)
-- 
2.33.0

