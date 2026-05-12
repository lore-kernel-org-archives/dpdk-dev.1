Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE2ECD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 02:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7128B40653;
	Tue, 12 May 2026 04:35:20 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 981C0402C1
 for <dev@dpdk.org>; Tue, 12 May 2026 04:35:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vusJ5xPhEGy/CvBWDW3pmqZsNBYZGu+i678SGu4VE6Y=;
 b=iRqUTAcE36ltUcPz5Yzrh45tHzrvnkq9N10EbOd9rKJsmYcBMz+PRPABckqfUT+jU61ndP2OG
 NAMeC61C6LO9UqYtYql0l8PHC5GWbn05n9UttCmxJoCs/0ZI/O0IzEu4kfLYD9v7yCWP/iVT/bG
 wkbj+h7ABZhBFgOIZy0XvHY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gF0rC5hCWznfFT;
 Tue, 12 May 2026 10:28:11 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 4ED5640561;
 Tue, 12 May 2026 10:35:15 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 10:35:15 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 10:35:14 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v1 1/7] examples/l3fwd-power: fix uncore deinit for non-legacy
Date: Tue, 12 May 2026 10:35:07 +0800
Message-ID: <20260512023513.460169-2-lihuisong@huawei.com>
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

Uncore resources were not being deinitialized in non-legacy modes (such
as pmd-mgmt), causing the uncore frequency not to return to its original
value after the application exited.

The root cause is that uncore initialization can be performed for all
modes, whereas the deinitialization logic is incorrectly restricted
to legacy mode only. So do the deinitialization of uncore on all app
modes.

Fixes: 10db2a5b8724 ("examples/l3fwd-power: add options for uncore frequency")
Cc: stable@dpdk.org

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 examples/l3fwd-power/main.c | 66 ++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 02ec17d799..1122aeb930 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2271,28 +2271,31 @@ init_power_library(void)
 	unsigned int lcore_id;
 	int ret = 0;
 
-	RTE_LCORE_FOREACH(lcore_id) {
-		/* init power management library */
-		ret = rte_power_init(lcore_id);
-		if (ret) {
-			RTE_LOG(ERR, L3FWD_POWER,
-				"Library initialization failed on core %u\n",
-				lcore_id);
-			return ret;
-		}
-		/* we're not supporting the VM channel mode */
-		env = rte_power_get_env();
-		if (env != PM_ENV_ACPI_CPUFREQ &&
-				env != PM_ENV_PSTATE_CPUFREQ &&
-				env != PM_ENV_AMD_PSTATE_CPUFREQ &&
-				env != PM_ENV_CPPC_CPUFREQ) {
-			RTE_LOG(ERR, L3FWD_POWER,
-				"Only ACPI and PSTATE mode are supported\n");
-			return -1;
+	/* only legacy mode relies on the initialization of cpufreq library */
+	if (app_mode == APP_MODE_LEGACY) {
+		RTE_LCORE_FOREACH(lcore_id) {
+			/* init power management library */
+			ret = rte_power_init(lcore_id);
+			if (ret) {
+				RTE_LOG(ERR, L3FWD_POWER,
+					"Library initialization failed on core %u\n",
+					lcore_id);
+				return ret;
+			}
+			/* we're not supporting the VM channel mode */
+			env = rte_power_get_env();
+			if (env != PM_ENV_ACPI_CPUFREQ &&
+					env != PM_ENV_PSTATE_CPUFREQ &&
+					env != PM_ENV_AMD_PSTATE_CPUFREQ &&
+					env != PM_ENV_CPPC_CPUFREQ) {
+				RTE_LOG(ERR, L3FWD_POWER,
+					"Only ACPI and PSTATE mode are supported\n");
+				return -1;
+			}
 		}
 	}
 
-	if (cpu_resume_latency != -1) {
+	if (app_mode == APP_MODE_LEGACY && cpu_resume_latency != -1) {
 		RTE_LCORE_FOREACH(lcore_id) {
 			/* Back old CPU resume latency. */
 			ret = rte_power_qos_get_cpu_resume_latency(lcore_id);
@@ -2329,14 +2332,16 @@ deinit_power_library(void)
 	unsigned int lcore_id, max_pkg, max_die, die, pkg;
 	int ret = 0;
 
-	RTE_LCORE_FOREACH(lcore_id) {
-		/* deinit power management library */
-		ret = rte_power_exit(lcore_id);
-		if (ret) {
-			RTE_LOG(ERR, L3FWD_POWER,
-				"Library deinitialization failed on core %u\n",
-				lcore_id);
-			return ret;
+	if (app_mode == APP_MODE_LEGACY) {
+		RTE_LCORE_FOREACH(lcore_id) {
+			/* deinit power management library */
+			ret = rte_power_exit(lcore_id);
+			if (ret) {
+				RTE_LOG(ERR, L3FWD_POWER,
+					"Library deinitialization failed on core %u\n",
+					lcore_id);
+				return ret;
+			}
 		}
 	}
 
@@ -2360,7 +2365,7 @@ deinit_power_library(void)
 		}
 	}
 
-	if (cpu_resume_latency != -1) {
+	if (app_mode == APP_MODE_LEGACY && cpu_resume_latency != -1) {
 		RTE_LCORE_FOREACH(lcore_id) {
 			/* Restore the original value. */
 			rte_power_qos_set_cpu_resume_latency(lcore_id,
@@ -2602,8 +2607,7 @@ main(int argc, char **argv)
 	RTE_LOG(INFO, L3FWD_POWER, "Selected operation mode: %s\n",
 			mode_to_str(app_mode));
 
-	/* only legacy mode relies on power library */
-	if ((app_mode == APP_MODE_LEGACY) && init_power_library())
+	if (init_power_library())
 		rte_exit(EXIT_FAILURE, "init_power_library failed\n");
 
 	if (update_lcore_params() < 0)
@@ -2975,7 +2979,7 @@ main(int argc, char **argv)
 		rte_eth_dev_close(portid);
 	}
 
-	if ((app_mode == APP_MODE_LEGACY) && deinit_power_library())
+	if (deinit_power_library())
 		rte_exit(EXIT_FAILURE, "deinit_power_library failed\n");
 
 	if (rte_eal_cleanup() < 0)
-- 
2.33.0

