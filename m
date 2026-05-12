Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0BCD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 02:35:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ABB740667;
	Tue, 12 May 2026 04:35:21 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id CD29A402DF
 for <dev@dpdk.org>; Tue, 12 May 2026 04:35:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=+qrBOKnm0QnNOFND18j/JW3rSirXE2kicb3y5FNOhno=;
 b=hn+xjXN7fzRHsYVXJ/Qzl/qldC8Q61CXsuK4k2OxQTXNGHGwnP/eB8po0H0jcJ6iC17MmbLyW
 CaH9BGtlOdjKjerT8Malxe81tZOYAfYeB2TbtjXrv90I1+/DuG+Hy904x8JtMP0rKCQUIRob3QF
 Uso4QW5/tC6I13O1GD3MtGY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gF0qc5XF1zS1MJ;
 Tue, 12 May 2026 10:27:40 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id BE2454056A;
 Tue, 12 May 2026 10:35:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 10:35:16 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 10:35:16 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v1 5/7] power: support automatic detection of uncore driver
Date: Tue, 12 May 2026 10:35:11 +0800
Message-ID: <20260512023513.460169-6-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260512023513.460169-1-lihuisong@huawei.com>
References: <20260512023513.460169-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
 lib/power/rte_power_uncore.c | 44 +++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index e26919acce..a5d080e09e 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  * Copyright(c) 2023 AMD Corporation
  */
+#include <errno.h>
 
 #include <eal_export.h>
 #include <rte_spinlock.h>
@@ -47,6 +48,37 @@ rte_power_register_uncore_ops(struct rte_power_uncore_ops *driver_ops)
 	return 0;
 }
 
+static uint32_t rte_power_uncore_driver_name2env(char *name)
+{
+	for (uint32_t i = 0; i < RTE_DIM(uncore_env_str); i++) {
+		if (!strcmp(name, uncore_env_str[i]))
+			return i;
+	}
+
+	return UINT32_MAX;
+}
+
+static int rte_power_probe_uncore_driver(void)
+{
+	struct rte_power_uncore_ops *ops;
+	int ret;
+
+	global_uncore_ops = NULL;
+	/* Use package-0 and die-0 to probe uncore driver. */
+	RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next) {
+		ret = ops->init(0, 0);
+		if (!ret) {
+			global_uncore_env =
+				rte_power_uncore_driver_name2env(ops->name);
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
@@ -61,12 +93,12 @@ rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
 		goto out;
 	}
 
-	if (env == RTE_UNCORE_PM_ENV_AUTO_DETECT)
-		/* Currently only intel_uncore is supported.
-		 * This will be extended with auto-detection support
-		 * for multiple uncore implementations.
-		 */
-		env = RTE_UNCORE_PM_ENV_INTEL_UNCORE;
+	if (env == RTE_UNCORE_PM_ENV_AUTO_DETECT) {
+		ret = rte_power_probe_uncore_driver();
+		if (ret)
+			POWER_LOG(ERR, "Probe uncore driver failed, ret = %d.", ret);
+		goto out;
+	}
 
 	if (env <= RTE_DIM(uncore_env_str)) {
 		RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next)
-- 
2.33.0

