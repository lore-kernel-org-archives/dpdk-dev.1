Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00B606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=i4uwNAn9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D716C402EE;
	Wed, 25 Nov 2026 15:06:33 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTPS id DCA4340151
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:27 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=r4HjKk+Fi5FTXZ9YOZULBfsNxjnaPxBufcFQjpukn8k=;
 b=i4uwNAn9vbycpoTbxM/tZEBe9fIYptWHWWgjw2tuGedQy5vDHZIKf3xKKfEBCol1TZDiTbc+t
 QZ92zOec3NuYRPTo53nB+nO4Nw9fTGIhZPMNuhPSjdJSjPTTk8bO/44vGRtTFfffxsRNZICFm/8
 h41BjSJd7IkUi3zjnwxB9AU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jZM0T2lLpzLlVf;
 Wed, 25 Nov 2026 22:06:01 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 6C3E140563;
 Wed, 25 Nov 2026 22:06:25 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:24 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 5/9] examples/l3fwd-power: add rollback and best-effort deinit
Date: Wed, 25 Nov 2026 22:06:11 +0800
Message-ID: <20261125140616.3965843-6-yangshuaisong@h-partners.com>
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

Make the deinitialization path best-effort: power_uncore_uninit(),
power_cpufreq_uninit() and deinit_power_library() now return void
and continue the cleanup on intermediate failures instead of
aborting it.

init_power_library() is also updated to roll back the cpufreq
library and the uncore units when a later initialization step
fails.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 examples/l3fwd-power/main.c | 67 +++++++++++++------------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 857b885f43..b6430f0c78 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2289,34 +2289,26 @@ power_uncore_init(void)
 	return ret;
 }
 
-static int
+static void
 power_uncore_uninit(void)
 {
 	unsigned int max_pkg, max_die, die, pkg;
-	int ret, res = 0;
+	int ret;
 
 	if (enabled_uncore == -1)
-		return 0;
+		return;
 
 	max_pkg = rte_power_uncore_get_num_pkgs();
-	if (max_pkg == 0)
-		return -1;
 	for (pkg = 0; pkg < max_pkg; pkg++) {
 		max_die = rte_power_uncore_get_num_dies(pkg);
-		if (max_die == 0)
-			return -1;
 		for (die = 0; die < max_die; die++) {
 			ret = rte_power_uncore_exit(pkg, die);
-			if (ret < 0) {
+			if (ret < 0)
 				RTE_LOG(ERR, L3FWD_POWER,
 					"Failed to exit uncore for pkg %02u die %02u, ret = %d.\n",
 					pkg, die, ret);
-				res = -1;
-			}
 		}
 	}
-
-	return res;
 }
 
 static int power_cpufreq_init(void)
@@ -2373,27 +2365,23 @@ static int power_cpufreq_init(void)
 	return ret;
 }
 
-static int power_cpufreq_uninit(void)
+static void power_cpufreq_uninit(void)
 {
 	unsigned int lcore_id;
-	int ret, res = 0;
+	int ret;
 
 	/* only legacy mode relies on the initialization of cpufreq library */
 	if (app_mode != APP_MODE_LEGACY)
-		return 0;
+		return;
 
 	RTE_LCORE_FOREACH(lcore_id) {
 		/* deinit power management library */
 		ret = rte_power_exit(lcore_id);
-		if (ret != 0) {
+		if (ret != 0)
 			RTE_LOG(ERR, L3FWD_POWER,
 				"uninit cpufreq on core-%u failed, ret = %d.\n",
 				lcore_id, ret);
-			res = ret;
-		}
 	}
-
-	return res;
 }
 
 static int
@@ -2476,39 +2464,31 @@ init_power_library(void)
 	}
 
 	ret = power_uncore_init();
-	if (ret != 0)
+	if (ret != 0) {
+		RTE_LOG(ERR, L3FWD_POWER,
+			"Initialize power uncore failed, ret = %d.\n", ret);
+		power_cpufreq_uninit();
 		return ret;
+	}
 
 	ret = power_qos_init();
-	if (ret != 0)
+	if (ret != 0) {
 		RTE_LOG(ERR, L3FWD_POWER,
 			"Initialize power QoS lib failed, ret = %d.\n", ret);
+		power_uncore_uninit();
+		power_cpufreq_uninit();
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
-static int
+static void
 deinit_power_library(void)
 {
-	int ret = 0;
-
-	ret = power_cpufreq_uninit();
-	if (ret != 0) {
-		RTE_LOG(ERR, L3FWD_POWER,
-			"Uninit cpufreq lib failed, ret = %d.\n", ret);
-		return ret;
-	}
-
-	ret = power_uncore_uninit();
-	if (ret != 0) {
-		RTE_LOG(ERR, L3FWD_POWER, "Uninit power uncore failed, ret = %d.\n",
-			ret);
-		return ret;
-	}
-
 	power_qos_uninit();
-
-	return ret;
+	power_uncore_uninit();
+	power_cpufreq_uninit();
 }
 
 static void
@@ -3114,8 +3094,7 @@ main(int argc, char **argv)
 		rte_eth_dev_close(portid);
 	}
 
-	if (deinit_power_library())
-		rte_exit(EXIT_FAILURE, "deinit_power_library failed\n");
+	deinit_power_library();
 
 	if (rte_eal_cleanup() < 0)
 		RTE_LOG(ERR, L3FWD_POWER, "EAL cleanup failed\n");
-- 
2.33.0

