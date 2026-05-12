Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D7CD4846
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 02:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A64E40679;
	Tue, 12 May 2026 04:35:24 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 2AE8940264
 for <dev@dpdk.org>; Tue, 12 May 2026 04:35:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=V1ilNfMPysLsNrnKw2FD1dhhHwlRU7GbrDfPp85Imo0=;
 b=Z84uCcEdNbbY79yRqijOG1vVw/J4QSJqpcD96OvgYl43itPK6s/6oAmZZBd5hH3rlqK4LB5qJ
 AvpNC8ZEz8QC6KtJcQvslJjA/YYZY5LNnVTFgqwE4FzY7+Zm+OirMvvc0zUB1h2AuHhqRlezYFW
 TRVHHYYRnOHhsL/lvNA4AGQ=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gF0qc1Gjpzmq8g;
 Tue, 12 May 2026 10:27:40 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id A42CD40571;
 Tue, 12 May 2026 10:35:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
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
Subject: [PATCH v1 7/7] examples/l3fwd-power: switch to new init/deinit uncore
 API
Date: Tue, 12 May 2026 10:35:13 +0800
Message-ID: <20260512023513.460169-8-lihuisong@huawei.com>
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

The new rte_power_uncore_driver_init/deinit() is friendly to user.
So replace the old way.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 examples/l3fwd-power/main.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index a22634a04e..afcb352373 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2199,9 +2199,9 @@ power_uncore_init(void)
 	if (enabled_uncore == -1)
 		return 0;
 
-	ret = rte_power_set_uncore_env(RTE_UNCORE_PM_ENV_AUTO_DETECT);
-	if (ret < 0) {
-		RTE_LOG(INFO, L3FWD_POWER, "Failed to set uncore env\n");
+	ret = rte_power_uncore_driver_init();
+	if (ret != 0) {
+		RTE_LOG(INFO, L3FWD_POWER, "Failed to initialize uncore driver.\n");
 		return ret;
 	}
 
@@ -2214,12 +2214,6 @@ power_uncore_init(void)
 		if (max_die == 0)
 			return -1;
 		for (die = 0; die < max_die; die++) {
-			ret = rte_power_uncore_init(pkg, die);
-			if (ret == -1) {
-				RTE_LOG(INFO, L3FWD_POWER, "Unable to initialize uncore for pkg %02u die %02u\n"
-				, pkg, die);
-				return ret;
-			}
 			if (g_uncore_cfg.uncore_choice == UNCORE_MIN) {
 				ret = rte_power_uncore_freq_min(pkg, die);
 				if (ret == -1) {
@@ -2331,7 +2325,7 @@ init_power_library(void)
 static int
 deinit_power_library(void)
 {
-	unsigned int lcore_id, max_pkg, max_die, die, pkg;
+	unsigned int lcore_id;
 	int ret = 0;
 
 	if (app_mode == APP_MODE_LEGACY) {
@@ -2348,24 +2342,8 @@ deinit_power_library(void)
 	}
 
 	/* if uncore option was set */
-	if (enabled_uncore == 0) {
-		max_pkg = rte_power_uncore_get_num_pkgs();
-		if (max_pkg == 0)
-			return -1;
-		for (pkg = 0; pkg < max_pkg; pkg++) {
-			max_die = rte_power_uncore_get_num_dies(pkg);
-			if (max_die == 0)
-				return -1;
-			for (die = 0; die < max_die; die++) {
-				ret = rte_power_uncore_exit(pkg, die);
-				if (ret < 0) {
-					RTE_LOG(ERR, L3FWD_POWER, "Failed to exit uncore deinit successfully for pkg %02u die %02u\n"
-						, pkg, die);
-					return -1;
-				}
-			}
-		}
-	}
+	if (enabled_uncore == 0)
+		rte_power_uncore_driver_deinit();
 
 	if (cpu_resume_latency != -1) {
 		RTE_LCORE_FOREACH(lcore_id) {
-- 
2.33.0

