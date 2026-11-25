Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3A9606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=FO3z7nZD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93AAA40679;
	Wed, 25 Nov 2026 15:06:34 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTPS id DAEEE402BD
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:28 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=chk2nho8+b7Z8SuQH/QYA6NXW1wv+gObSPW7nDCsKK0=;
 b=FO3z7nZDXop3Gfcy4wJornvwA3Z8cRPetLJH2LJ+w4POnxIa3roXO2UbG+xYulfIwLYiz5DUP
 P4+5i6QSu5xCHFvudaOTJQKCxVfdrK4lnKLKVZ5nU9Gr4EowQvt+22NFj9flNGv50bou3ny3jJz
 CJlJjd/SLpK4cwRPchOu+ic=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jZM0Q6qhDzLlVf;
 Wed, 25 Nov 2026 22:05:58 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 0501E40565;
 Wed, 25 Nov 2026 22:06:23 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:22 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 2/9] examples/l3fwd-power: extract functions for cpufreq
 library
Date: Wed, 25 Nov 2026 22:06:08 +0800
Message-ID: <20261125140616.3965843-3-yangshuaisong@h-partners.com>
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

Extract the legacy mode cpufreq initialization and deinitialization
from init_power_library() and deinit_power_library() into dedicated
power_cpufreq_init() and power_cpufreq_uninit() helpers, so each
power management sub-library has its own setup and teardown
functions.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 examples/l3fwd-power/main.c | 121 ++++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 34 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 8f1a398c96..dc0002982a 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2291,37 +2291,96 @@ power_uncore_uninit(void)
 	return res;
 }
 
-static int
-init_power_library(void)
+static int power_cpufreq_init(void)
 {
+	int lcore_init[RTE_MAX_LCORE] = {0};
 	enum power_management_env env;
 	unsigned int lcore_id;
-	int ret = 0;
+	int ret, res;
 
 	/* only legacy mode relies on the initialization of cpufreq library */
-	if (app_mode == APP_MODE_LEGACY) {
-		RTE_LCORE_FOREACH(lcore_id) {
-			/* init power management library */
-			ret = rte_power_init(lcore_id);
-			if (ret) {
-				RTE_LOG(ERR, L3FWD_POWER,
-					"Library initialization failed on core %u\n",
-					lcore_id);
-				return ret;
-			}
-			/* we're not supporting the VM channel mode */
-			env = rte_power_get_env();
-			if (env != PM_ENV_ACPI_CPUFREQ &&
-					env != PM_ENV_PSTATE_CPUFREQ &&
-					env != PM_ENV_AMD_PSTATE_CPUFREQ &&
-					env != PM_ENV_CPPC_CPUFREQ) {
-				RTE_LOG(ERR, L3FWD_POWER,
-					"Only ACPI and PSTATE mode are supported\n");
-				return -1;
-			}
+	if (app_mode != APP_MODE_LEGACY)
+		return 0;
+
+	RTE_LCORE_FOREACH(lcore_id) {
+		/* init power management library */
+		ret = rte_power_init(lcore_id);
+		if (ret != 0) {
+			RTE_LOG(ERR, L3FWD_POWER,
+				"Library initialization failed on core %u\n",
+				lcore_id);
+			goto uninit_cpufreq;
+		}
+
+		/* we're not supporting the VM channel mode */
+		env = rte_power_get_env();
+		if (env != PM_ENV_ACPI_CPUFREQ &&
+				env != PM_ENV_PSTATE_CPUFREQ &&
+				env != PM_ENV_AMD_PSTATE_CPUFREQ &&
+				env != PM_ENV_CPPC_CPUFREQ) {
+			RTE_LOG(ERR, L3FWD_POWER,
+				"Only ACPI and PSTATE mode are supported\n");
+			rte_power_exit(lcore_id);
+			ret = -1;
+			goto uninit_cpufreq;
+		}
+		lcore_init[lcore_id] = 1;
+	}
+
+	return 0;
+
+uninit_cpufreq:
+	RTE_LCORE_FOREACH(lcore_id) {
+		/* deinit power management library */
+		if (lcore_init[lcore_id] == 0)
+			break;
+
+		res = rte_power_exit(lcore_id);
+		if (res != 0)
+			RTE_LOG(ERR, L3FWD_POWER,
+				"uninit cpufreq on core-%u failed, ret = %d.\n",
+				lcore_id, res);
+	}
+
+	return ret;
+}
+
+static int power_cpufreq_uninit(void)
+{
+	unsigned int lcore_id;
+	int ret, res = 0;
+
+	/* only legacy mode relies on the initialization of cpufreq library */
+	if (app_mode != APP_MODE_LEGACY)
+		return 0;
+
+	RTE_LCORE_FOREACH(lcore_id) {
+		/* deinit power management library */
+		ret = rte_power_exit(lcore_id);
+		if (ret != 0) {
+			RTE_LOG(ERR, L3FWD_POWER,
+				"uninit cpufreq on core-%u failed, ret = %d.\n",
+				lcore_id, ret);
+			res = ret;
 		}
 	}
 
+	return res;
+}
+
+static int
+init_power_library(void)
+{
+	unsigned int lcore_id;
+	int ret;
+
+	ret = power_cpufreq_init();
+	if (ret != 0) {
+		RTE_LOG(ERR, L3FWD_POWER,
+			"Initialize cpufreq lib failed, ret = %d.\n", ret);
+		return ret;
+	}
+
 	ret = power_uncore_init();
 	if (ret != 0)
 		return ret;
@@ -2364,17 +2423,11 @@ deinit_power_library(void)
 	unsigned int lcore_id, max_pkg, max_die, die, pkg;
 	int ret = 0;
 
-	if (app_mode == APP_MODE_LEGACY) {
-		RTE_LCORE_FOREACH(lcore_id) {
-			/* deinit power management library */
-			ret = rte_power_exit(lcore_id);
-			if (ret) {
-				RTE_LOG(ERR, L3FWD_POWER,
-					"Library deinitialization failed on core %u\n",
-					lcore_id);
-				return ret;
-			}
-		}
+	ret = power_cpufreq_uninit();
+	if (ret != 0) {
+		RTE_LOG(ERR, L3FWD_POWER,
+			"Uninit cpufreq lib failed, ret = %d.\n", ret);
+		return ret;
 	}
 
 	ret = power_uncore_uninit();
-- 
2.33.0

