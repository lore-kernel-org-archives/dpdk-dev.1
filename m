Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE5606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=M9xyoZC+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 570EE40284;
	Wed, 25 Nov 2026 15:06:28 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTPS id 04DBF40151
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:26 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=kA7M3Rg2aeNvekX7J0UsdpAXCP3gaRwZ/dy6m9eRkw0=;
 b=M9xyoZC+cDO5P8z8ewhIhEjtdxhxycuY7mpvKXlAMIW6Mq+DZ2KdHSm909OqOZExyZZpkneYq
 Kb6IHOqU2Rav9PVGRNPSrs1d5YdiqUZON5YUJjLHzlyNW96rOt8w6qG4eNr+zaDqWqgWYXRS8iU
 2bcnLlIeHmooAta2zodx7ag=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jZLzg3GsczpSvq;
 Wed, 25 Nov 2026 22:05:19 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F14B40575;
 Wed, 25 Nov 2026 22:06:22 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:21 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 1/9] examples/l3fwd-power: extract function to deinit uncore
Date: Wed, 25 Nov 2026 22:06:07 +0800
Message-ID: <20261125140616.3965843-2-yangshuaisong@h-partners.com>
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

Extract the uncore deinitialization from deinit_power_library()
into a dedicated power_uncore_uninit() helper.

The per-die exit loop is made best-effort: a failure is logged and
the loop continues instead of aborting, so all initialized packages
and dies are cleaned up.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 examples/l3fwd-power/main.c | 53 ++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 5b4cb9f210..8f1a398c96 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2261,6 +2261,36 @@ power_uncore_init(void)
 	return 0;
 }
 
+static int
+power_uncore_uninit(void)
+{
+	unsigned int max_pkg, max_die, die, pkg;
+	int ret, res = 0;
+
+	if (enabled_uncore == -1)
+		return 0;
+
+	max_pkg = rte_power_uncore_get_num_pkgs();
+	if (max_pkg == 0)
+		return -1;
+	for (pkg = 0; pkg < max_pkg; pkg++) {
+		max_die = rte_power_uncore_get_num_dies(pkg);
+		if (max_die == 0)
+			return -1;
+		for (die = 0; die < max_die; die++) {
+			ret = rte_power_uncore_exit(pkg, die);
+			if (ret < 0) {
+				RTE_LOG(ERR, L3FWD_POWER,
+					"Failed to exit uncore for pkg %02u die %02u, ret = %d.\n",
+					pkg, die, ret);
+				res = -1;
+			}
+		}
+	}
+
+	return res;
+}
+
 static int
 init_power_library(void)
 {
@@ -2347,24 +2377,11 @@ deinit_power_library(void)
 		}
 	}
 
-	/* if uncore option was set */
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
+	ret = power_uncore_uninit();
+	if (ret != 0) {
+		RTE_LOG(ERR, L3FWD_POWER, "Uninit power uncore failed, ret = %d.\n",
+			ret);
+		return ret;
 	}
 
 	if (cpu_resume_latency != -1) {
-- 
2.33.0

