Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50258CD37B2
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 08:45:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BF6A402E8;
	Sat,  9 May 2026 10:45:09 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 5226D40269
 for <dev@dpdk.org>; Sat,  9 May 2026 10:45:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=iEE2iclL+b8HMm0w7UhrP2My90J4XfutroPeBUdY++s=;
 b=ZX/AhtpiWla7OQNf9UJmiZ6ke9BY+6/TybKm9yCGtu6djWLtst+08Z8R7u7ZqJqCmbQCDNLDV
 SPa93ye5h4DL6qe4+Vd66QuCWcwpkAH/mHtVJqv3RWTeBthtfy9s4QwW2qlDszZsJr+luT4yR/H
 fTGi5Ks0uSSkRl8uEJWNtcY=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gCKBH51WzznTWF;
 Sat,  9 May 2026 16:37:59 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id C864E40572;
 Sat,  9 May 2026 16:45:04 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 16:45:04 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 9 May 2026 16:45:04 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH 1/3] power: move power state structure to power cpufreq header
Date: Sat, 9 May 2026 16:45:01 +0800
Message-ID: <20260509084503.2917038-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260509084503.2917038-1-lihuisong@huawei.com>
References: <20260509084503.2917038-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
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

The "enum power_state" structure is defined by each cpufreq driver.
So move it to power_cpufreq.h to facilitate maintenance.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/acpi/acpi_cpufreq.c                 |  7 -------
 drivers/power/amd_pstate/amd_pstate_cpufreq.c     |  7 -------
 drivers/power/cppc/cppc_cpufreq.c                 |  7 -------
 drivers/power/intel_pstate/intel_pstate_cpufreq.c |  8 --------
 lib/power/power_cpufreq.h                         | 10 ++++++++++
 5 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/power/acpi/acpi_cpufreq.c b/drivers/power/acpi/acpi_cpufreq.c
index 81a5e3f6ea..21991af36a 100644
--- a/drivers/power/acpi/acpi_cpufreq.c
+++ b/drivers/power/acpi/acpi_cpufreq.c
@@ -31,13 +31,6 @@
 #define IA32_PERF_CTL     0x199
 #define CORE_TURBO_DISABLE_BIT ((uint64_t)1<<32)
 
-enum power_state {
-	POWER_IDLE = 0,
-	POWER_ONGOING,
-	POWER_USED,
-	POWER_UNKNOWN
-};
-
 /**
  * Power info per lcore.
  */
diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
index 95495bff7d..318f8c00e1 100644
--- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
+++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
@@ -35,13 +35,6 @@
 #define POWER_AMD_PSTATE_DRIVER "amd-pstate"
 #define BUS_FREQ     1000	/* khz */
 
-enum power_state {
-	POWER_IDLE = 0,
-	POWER_ONGOING,
-	POWER_USED,
-	POWER_UNKNOWN
-};
-
 /**
  * Power info per lcore.
  */
diff --git a/drivers/power/cppc/cppc_cpufreq.c b/drivers/power/cppc/cppc_cpufreq.c
index 3cd4165c83..e3ba9bb60a 100644
--- a/drivers/power/cppc/cppc_cpufreq.c
+++ b/drivers/power/cppc/cppc_cpufreq.c
@@ -39,13 +39,6 @@
 #define POWER_CPPC_DRIVER "cppc_cpufreq"
 #define BUS_FREQ     100000
 
-enum power_state {
-	POWER_IDLE = 0,
-	POWER_ONGOING,
-	POWER_USED,
-	POWER_UNKNOWN
-};
-
 /**
  * Power info per lcore.
  */
diff --git a/drivers/power/intel_pstate/intel_pstate_cpufreq.c b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
index 8e27570e3c..22a1b4465a 100644
--- a/drivers/power/intel_pstate/intel_pstate_cpufreq.c
+++ b/drivers/power/intel_pstate/intel_pstate_cpufreq.c
@@ -41,14 +41,6 @@
 		"/sys/devices/system/cpu/intel_pstate/turbo_pct"
 #define POWER_PSTATE_DRIVER "intel_pstate"
 
-
-enum power_state {
-	POWER_IDLE = 0,
-	POWER_ONGOING,
-	POWER_USED,
-	POWER_UNKNOWN
-};
-
 struct __rte_cache_aligned pstate_power_info {
 	unsigned int lcore_id;               /**< Logical core id */
 	uint32_t freqs[RTE_MAX_LCORE_FREQS]; /**< Frequency array */
diff --git a/lib/power/power_cpufreq.h b/lib/power/power_cpufreq.h
index fb0b7feb82..41bfaed7bb 100644
--- a/lib/power/power_cpufreq.h
+++ b/lib/power/power_cpufreq.h
@@ -18,6 +18,16 @@
 
 #define RTE_POWER_DRIVER_NAMESZ 24
 
+/**
+ * Power state of cpufreq driver
+ */
+enum power_state {
+	POWER_IDLE = 0,
+	POWER_ONGOING,
+	POWER_USED,
+	POWER_UNKNOWN
+};
+
 /**
  * Initialize power management for a specific lcore. If rte_power_set_env() has
  * not been called then an auto-detect of the environment will start and
-- 
2.33.0

