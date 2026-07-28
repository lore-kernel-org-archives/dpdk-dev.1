Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E22C53219
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 12:05:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51EE6406B6;
	Tue, 28 Jul 2026 14:05:22 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 7B4EE40612
 for <dev@dpdk.org>; Tue, 28 Jul 2026 14:05:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=CLso6E2qu5WNaRGLpFH8jYWFgB3OFyHieRAlqkI+Urc=;
 b=J/D1plTcquo6QkEH189HDTYLhuNJ8/Vgb0lMNgNsGnM6ndxxgIvdVPa3+eUo5u+zPNIkqxH0/
 rNSC1+BhULdyS39cqoWo5WDaHS/Gl3jnY2S2B1en1wad/RFJbH+3RuAVLOx4lMK7poeBLO8FCfY
 kajgEQSN6UjWvq/Hs2/HSks=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h8Ynf4BFTz1prQc;
 Tue, 28 Jul 2026 19:55:50 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 17B1A40575;
 Tue, 28 Jul 2026 20:05:19 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 28 Jul 2026 20:05:18 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v3 6/6] power: remove unused auto-detection uncore
Date: Tue, 28 Jul 2026 20:02:08 +0800
Message-ID: <20260728120208.1858832-7-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260728120208.1858832-1-lihuisong@huawei.com>
References: <20260526081138.1434947-1-lihuisong@huawei.com>
 <20260728120208.1858832-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Applications need to set uncore environment first by calling the API
rte_power_set_uncore_env, please see the commit 3b3af56d3c9c ("power:
fix uncore configuration").

Now, rte_power_set_uncore_env() supports automatic detection of uncore
drivers, the automatic detection environment code can be deleted.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/rte_power_uncore.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/lib/power/rte_power_uncore.c b/lib/power/rte_power_uncore.c
index 64a8c2648d..8c07cee583 100644
--- a/lib/power/rte_power_uncore.c
+++ b/lib/power/rte_power_uncore.c
@@ -140,32 +140,14 @@ RTE_EXPORT_SYMBOL(rte_power_uncore_init)
 int
 rte_power_uncore_init(unsigned int pkg, unsigned int die)
 {
-	int ret = -1;
-	struct rte_power_uncore_ops *ops;
-	uint8_t env;
+	if (global_uncore_env == RTE_UNCORE_PM_ENV_NOT_SET ||
+	    global_uncore_env == RTE_UNCORE_PM_ENV_AUTO_DETECT ||
+	    !global_uncore_ops) {
+		POWER_LOG(ERR, "Please set uncore environment first.");
+		return -1;
+	}
 
-	if ((global_uncore_env != RTE_UNCORE_PM_ENV_NOT_SET) &&
-		(global_uncore_env != RTE_UNCORE_PM_ENV_AUTO_DETECT))
-		return global_uncore_ops->init(pkg, die);
-
-	/* Auto Detect Environment */
-	RTE_TAILQ_FOREACH(ops, &uncore_ops_list, next)
-		if (ops) {
-			POWER_LOG(INFO,
-				"Attempting to initialise %s power management...",
-				ops->name);
-			ret = ops->init(pkg, die);
-			if (ret == 0) {
-				for (env = 0; env < RTE_DIM(uncore_env_str); env++)
-					if (strncmp(ops->name, uncore_env_str[env],
-						RTE_POWER_UNCORE_DRIVER_NAMESZ) == 0) {
-						rte_power_set_uncore_env(env);
-						goto out;
-					}
-			}
-		}
-out:
-	return ret;
+	return global_uncore_ops->init(pkg, die);
 }
 
 RTE_EXPORT_SYMBOL(rte_power_uncore_exit)
-- 
2.33.0

