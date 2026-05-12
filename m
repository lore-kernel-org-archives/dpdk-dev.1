Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C514ECD4846
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 02:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A3764067D;
	Tue, 12 May 2026 04:35:25 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 55DB340611
 for <dev@dpdk.org>; Tue, 12 May 2026 04:35:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oJV54H8Q9xYBjFpO0XWZyfNrBy0NYKbk+hFQ8LbEAKU=;
 b=ZhciNNLV0sEjKPGdBfGrQAY16LsHX43MxH80sUaBPcKhQqo+8jrip/dxPgvthK/i8y8P/Erof
 RMGNslEOHkQNV4H8Lj87TnX+IXh/VehpIA5Jy1nlCcNOr/a4tDIY0V/dIjkxYZhJeFXZJNWzbBD
 /4w8fCzfFrBc4zVKz8WQMHY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gF0qZ43mBzL4TJ;
 Tue, 12 May 2026 10:27:38 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 4C68140571;
 Tue, 12 May 2026 10:35:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 10:35:17 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 10:35:16 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v1 6/7] power: add global uncore init and deinit interface
Date: Tue, 12 May 2026 10:35:12 +0800
Message-ID: <20260512023513.460169-7-lihuisong@huawei.com>
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

Currently, the uncore power library requires users to manually set
environment variables and call rte_power_uncore_init() one by one
in their applications. Since these steps are essentially part of
the driver initialization, they can be encapsulated in the uncore
core. So introduce two global API to initialize and deinitialize
uncore driver for application.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/rte_power_uncore.c | 88 ++++++++++++++++++++++++++++++++++++
 lib/power/rte_power_uncore.h | 20 ++++++++
 2 files changed, 108 insertions(+)

diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index a5d080e09e..0611a60d33 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -79,6 +79,12 @@ static int rte_power_probe_uncore_driver(void)
 	return global_uncore_ops ? 0 : -ENODEV;
 }
 
+static void rte_power_remove_uncore_driver(void)
+{
+	global_uncore_ops = NULL;
+	global_uncore_env = RTE_UNCORE_PM_ENV_NOT_SET;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_set_uncore_env, 23.11)
 int
 rte_power_set_uncore_env(enum rte_uncore_power_mgmt_env env)
@@ -135,6 +141,88 @@ rte_power_get_uncore_env(void)
 	return global_uncore_env;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_uncore_driver_init, 26.07)
+int
+rte_power_uncore_driver_init(void)
+{
+	int die, pkg, max_pkg, max_die;
+	int ret;
+
+	rte_spinlock_lock(&global_env_cfg_lock);
+	ret = rte_power_probe_uncore_driver();
+	if (ret) {
+		POWER_LOG(ERR, "Probe uncore driver failed, ret = %d.", ret);
+		goto out;
+	}
+
+	max_pkg = rte_power_uncore_get_num_pkgs();
+	if (max_pkg == 0) {
+		ret = -EINVAL;
+		goto remove_uncore_drv;
+	}
+
+	for (pkg = 0; pkg < max_pkg; pkg++) {
+		max_die = rte_power_uncore_get_num_dies(pkg);
+		if (max_die == 0) {
+			ret = -EINVAL;
+			goto remove_uncore_drv;
+		}
+
+		for (die = 0; die < max_die; die++) {
+			ret = rte_power_uncore_init(pkg, die);
+			if (ret) {
+				POWER_LOG(ERR, "Unable to initialize uncore for pkg-%d die-%d",
+					  pkg, die);
+				goto uncore_exit;
+			}
+		}
+	}
+	rte_spinlock_unlock(&global_env_cfg_lock);
+	return 0;
+
+uncore_exit:
+	for (; pkg >= 0; pkg--) {
+		max_die = rte_power_uncore_get_num_dies(pkg);
+		for (die = 0; die < max_die; die++) {
+			ret = rte_power_uncore_exit(pkg, die);
+			if (ret)
+				POWER_LOG(ERR, "Failed to deinitialize uncore for pkg-%d die-%d",
+					  pkg, die);
+		}
+	}
+
+remove_uncore_drv:
+	rte_power_remove_uncore_driver();
+out:
+	rte_spinlock_unlock(&global_env_cfg_lock);
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_power_uncore_driver_deinit, 26.07)
+void
+rte_power_uncore_driver_deinit(void)
+{
+	unsigned int die, pkg, max_pkg, max_die;
+
+	rte_spinlock_lock(&global_env_cfg_lock);
+	if (global_uncore_ops == NULL)
+		goto out;
+
+	max_pkg = rte_power_uncore_get_num_pkgs();
+	for (pkg = 0; pkg < max_pkg; pkg++) {
+		max_die = rte_power_uncore_get_num_dies(pkg);
+		for (die = 0; die < max_die; die++) {
+			if (rte_power_uncore_exit(pkg, die) != 0)
+				POWER_LOG(ERR, "Unable to deinitialize uncore for pkg-%02u die-%02u",
+					  pkg, die);
+		}
+	}
+
+	rte_power_remove_uncore_driver();
+out:
+	rte_spinlock_unlock(&global_env_cfg_lock);
+}
+
 RTE_EXPORT_SYMBOL(rte_power_uncore_init)
 int
 rte_power_uncore_init(unsigned int pkg, unsigned int die)
diff --git a/lib/power/rte_power_uncore.h b/lib/power/rte_power_uncore.h
index 66aea1b37f..cac9127894 100644
--- a/lib/power/rte_power_uncore.h
+++ b/lib/power/rte_power_uncore.h
@@ -26,6 +26,26 @@ enum rte_uncore_power_mgmt_env {
 	RTE_UNCORE_PM_ENV_AMD_HSMP
 };
 
+/**
+ * Probing and Initializing the uncore driver on platform.
+ *
+ * @return
+ *  - 0 on success.
+ *  - Negative on error.
+ */
+__rte_experimental
+int rte_power_uncore_driver_init(void);
+
+/**
+ * Deinitializing the uncore driver on platform.
+ *
+ * @return
+ *  - 0 on success.
+ *  - Negative on error.
+ */
+__rte_experimental
+void rte_power_uncore_driver_deinit(void);
+
 /**
  * Set the default uncore power management implementation.
  * This has to be called prior to calling any other rte_power_uncore_*() API.
-- 
2.33.0

