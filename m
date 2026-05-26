Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A571FCD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 08:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5478140667;
	Tue, 26 May 2026 10:14:11 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 86FEF40279
 for <dev@dpdk.org>; Tue, 26 May 2026 10:14:09 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=RhAeqGoQTbXBZuPt2wRiqN5zMzTvyVRRlnPjm8UHtrE=;
 b=MKvvFgk1DRPU/ohEimXxMI/oPK9okIl5ICDsv4qz/PUpuIQAiQM0Inq+3JNiR99cuDgP4hckC
 Ce/smQ/vgLR91TafktqbYCTdewTz3uNdINvuwjfP9cV0CWqyccjMdQgSvSUOUxxXDF2Z/9oRXuF
 EquiNAia/lqs107lWH6Xpjk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gPlgk2w1dznTVR;
 Tue, 26 May 2026 16:06:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 28A394055B;
 Tue, 26 May 2026 16:14:08 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 16:14:08 +0800
Received: from localhost.localdomain (10.90.31.46) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 26 May 2026 16:14:07 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v2 5/5] power: support automatic detection of uncore driver
Date: Tue, 26 May 2026 16:11:38 +0800
Message-ID: <20260526081138.1434947-6-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260526081138.1434947-1-lihuisong@huawei.com>
References: <20260526081138.1434947-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

Currently, uncore driver library just supports intel_uncore driver
as default driver when user use AUTO_DETECT, which is not good to
application. So it is necessary to support probing for multi-uncore
drivers.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 doc/guides/rel_notes/release_26_07.rst |  6 ++++
 lib/power/rte_power_uncore.c           | 46 ++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..14436f9d7f 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,12 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Supported auto-detection of uncore power driver.**
+
+  The uncore power library now supports automatic probing of multiple
+  uncore drivers when using ``RTE_UNCORE_PM_ENV_AUTO_DETECT``,
+  instead of defaulting only to the Intel uncore driver.
+
 
 Removed Items
 -------------
diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index 25bdb113c5..ff11f0105c 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  * Copyright(c) 2023 AMD Corporation
  */
+#include <errno.h>
 
 #include <eal_export.h>
 #include <rte_spinlock.h>
@@ -46,6 +47,39 @@ rte_power_register_uncore_ops(struct rte_power_uncore_ops *driver_ops)
 	return 0;
 }
 
+static uint32_t power_uncore_driver_name2env(char *name)
+{
+	for (uint32_t i = 0; i < RTE_DIM(uncore_env_str); i++) {
+		if (!strcmp(name, uncore_env_str[i]))
+			return i;
+	}
+
+	return UINT32_MAX;
+}
+
+static int power_uncore_probe_driver(void)
+{
+	struct rte_power_uncore_ops *ops;
+	int ret;
+
+	global_uncore_ops = NULL;
+	/* Use package-0 and die-0 to probe uncore driver. */
+	RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next) {
+		ret = ops->init(0, 0);
+		if (ret == 0) {
+			uint32_t env = power_uncore_driver_name2env(ops->name);
+			if (env == UINT32_MAX)
+				continue;
+			global_uncore_env = env;
+			global_uncore_ops = ops;
+			ops->exit(0, 0);
+			break;
+		}
+	}
+
+	return global_uncore_ops ? 0 : -ENODEV;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_set_uncore_env, 23.11)
 int
 rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
@@ -60,12 +94,12 @@ rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
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
 
 	if (env <= RTE_DIM(uncore_env_str)) {
 		RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next)
-- 
2.33.0

