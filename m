Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D701CCD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 08:45:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AA414064F;
	Sat,  9 May 2026 10:45:10 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 58E15402AB
 for <dev@dpdk.org>; Sat,  9 May 2026 10:45:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=udTNONkNGK+qiBF2dcqnCT6DYRfs4YKa0grIHLEtnDg=;
 b=V2+PKBhrzwUjjUsHB7L5+9doNmcA0MO3pZTRIOOMjM7U6DIT72q23+Q5NvdpsKQB2zJs/l4G3
 cRHisjWgCOzDJ38M+q5hfKRq9cngoIiD/YWp8ZUyhccYrdepKYXzaoUnBSL5+1EonT19qHXxjJ1
 UfQcNDU0+V3F4MMoy3p341Q=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gCK9j4Y0nz1T4Jt;
 Sat,  9 May 2026 16:37:29 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 4A5EB40561;
 Sat,  9 May 2026 16:45:05 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 16:45:05 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 9 May 2026 16:45:04 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH 2/3] power: unify decimal format macro for strtoul
Date: Sat, 9 May 2026 16:45:02 +0800
Message-ID: <20260509084503.2917038-3-lihuisong@huawei.com>
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

Unify and move POWER_CONVERT_TO_DECIMAL definition to common header
file to facilitate the use of drivers and library.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/acpi/acpi_cpufreq.c             | 1 -
 drivers/power/amd_pstate/amd_pstate_cpufreq.c | 2 --
 drivers/power/cppc/cppc_cpufreq.c             | 2 --
 lib/power/power_common.c                      | 1 -
 lib/power/power_common.h                      | 2 ++
 5 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/acpi/acpi_cpufreq.c b/drivers/power/acpi/acpi_cpufreq.c
index 21991af36a..875c66336d 100644
--- a/drivers/power/acpi/acpi_cpufreq.c
+++ b/drivers/power/acpi/acpi_cpufreq.c
@@ -14,7 +14,6 @@
 #include "power_common.h"
 
 #define STR_SIZE     1024
-#define POWER_CONVERT_TO_DECIMAL 10
 
 #define POWER_GOVERNOR_USERSPACE "userspace"
 #define POWER_SYSFILE_AVAIL_FREQ \
diff --git a/drivers/power/amd_pstate/amd_pstate_cpufreq.c b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
index 318f8c00e1..bc67981d71 100644
--- a/drivers/power/amd_pstate/amd_pstate_cpufreq.c
+++ b/drivers/power/amd_pstate/amd_pstate_cpufreq.c
@@ -16,8 +16,6 @@
 #define FREQ_ROUNDING_DELTA 500
 #define ROUND_FREQ_TO_N_1000 1000
 
-#define POWER_CONVERT_TO_DECIMAL 10
-
 #define POWER_GOVERNOR_USERSPACE "userspace"
 #define POWER_SYSFILE_SETSPEED   \
 		"/sys/devices/system/cpu/cpu%u/cpufreq/scaling_setspeed"
diff --git a/drivers/power/cppc/cppc_cpufreq.c b/drivers/power/cppc/cppc_cpufreq.c
index e3ba9bb60a..9ae25bad27 100644
--- a/drivers/power/cppc/cppc_cpufreq.c
+++ b/drivers/power/cppc/cppc_cpufreq.c
@@ -20,8 +20,6 @@
  */
 #define UNIT_DIFF 10000
 
-#define POWER_CONVERT_TO_DECIMAL 10
-
 #define POWER_GOVERNOR_USERSPACE "userspace"
 #define POWER_SYSFILE_SETSPEED   \
 		"/sys/devices/system/cpu/cpu%u/cpufreq/scaling_setspeed"
diff --git a/lib/power/power_common.c b/lib/power/power_common.c
index 2da034e9d0..da22a4d160 100644
--- a/lib/power/power_common.c
+++ b/lib/power/power_common.c
@@ -21,7 +21,6 @@ RTE_LOG_REGISTER_DEFAULT(rte_power_logtype, INFO);
 		"/sys/devices/system/cpu/cpu%u/cpufreq/scaling_driver"
 #define POWER_SYSFILE_GOVERNOR  \
 		"/sys/devices/system/cpu/cpu%u/cpufreq/scaling_governor"
-#define POWER_CONVERT_TO_DECIMAL 10
 
 RTE_EXPORT_INTERNAL_SYMBOL(cpufreq_check_scaling_driver)
 int
diff --git a/lib/power/power_common.h b/lib/power/power_common.h
index 3f56b1103d..e2d5b68a17 100644
--- a/lib/power/power_common.h
+++ b/lib/power/power_common.h
@@ -23,6 +23,8 @@ extern int rte_power_logtype;
 #define POWER_DEBUG_LOG(...)
 #endif
 
+#define POWER_CONVERT_TO_DECIMAL 10
+
 /* check if scaling driver matches one we want */
 __rte_internal
 int cpufreq_check_scaling_driver(const char *driver);
-- 
2.33.0

