Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9C606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=WJSlFtpE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2DB840611;
	Wed, 25 Nov 2026 15:06:29 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTPS id 4F075402B2
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:27 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=hFjkrV8Mv/IbRZcjrYGamufbRiddiHpUQ+g+djql2x4=;
 b=WJSlFtpEYJpTRC1VzZ4pYbVWjK0MNycmuHtTdTzOzPb7Va9xTCk+Wdk6W8tQPT5SYRYA932nE
 OCZabzctGFM0XAgLTfLhlRusMmrUcp1SiMj72RNCXj8f47CpLYtdAOTtrnDRRC2/zemmouVYxum
 GGGvReIaOWitzRPsvr2UoV0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jZLzy6SHLznTVW;
 Wed, 25 Nov 2026 22:05:34 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id D46D940565;
 Wed, 25 Nov 2026 22:06:23 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:23 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 3/9] examples/l3fwd-power: extract functions for power QoS
Date: Wed, 25 Nov 2026 22:06:09 +0800
Message-ID: <20261125140616.3965843-4-yangshuaisong@h-partners.com>
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

Extract the power QoS initialization and deinitialization from
init_power_library() and deinit_power_library() into dedicated
power_qos_init() and power_qos_uninit() helpers.

power_qos_init() also gains a rollback path which restores the CPU
resume latency of the cores that were already configured when a
later step fails.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 examples/l3fwd-power/main.c | 109 ++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 37 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index dc0002982a..03d8b3f5e1 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -2369,11 +2369,77 @@ static int power_cpufreq_uninit(void)
 }
 
 static int
-init_power_library(void)
+power_qos_init(void)
 {
+	int lcore_init[RTE_MAX_LCORE] = {0};
 	unsigned int lcore_id;
 	int ret;
 
+	if (cpu_resume_latency == -1)
+		return 0;
+
+	RTE_LCORE_FOREACH(lcore_id) {
+		/* Back old CPU resume latency. */
+		ret = rte_power_qos_get_cpu_resume_latency(lcore_id);
+		if (ret < 0) {
+			RTE_LOG(ERR, L3FWD_POWER,
+				"Failed to get cpu resume latency on lcore-%u, ret=%d.\n",
+				lcore_id, ret);
+			goto uninit_qos;
+		}
+		resume_latency_bk[lcore_id] = ret;
+
+		/*
+		 * Set the cpu resume latency of the worker lcore based
+		 * on user's request. If set strict latency (0), just
+		 * allow the CPU to enter the shallowest idle state to
+		 * improve performance.
+		 */
+		ret = rte_power_qos_set_cpu_resume_latency(lcore_id, cpu_resume_latency);
+		if (ret != 0) {
+			RTE_LOG(ERR, L3FWD_POWER,
+				"Failed to set cpu resume latency on lcore-%u, ret=%d.\n",
+				lcore_id, ret);
+			goto uninit_qos;
+		}
+		lcore_init[lcore_id] = 1;
+	}
+
+	return 0;
+
+uninit_qos:
+	RTE_LCORE_FOREACH(lcore_id) {
+		if (lcore_init[lcore_id] == 0)
+			break;
+
+		/* Restore the original value. */
+		rte_power_qos_set_cpu_resume_latency(lcore_id,
+						     resume_latency_bk[lcore_id]);
+	}
+
+	return ret;
+}
+
+static void
+power_qos_uninit(void)
+{
+	unsigned int lcore_id;
+
+	if (cpu_resume_latency == -1)
+		return;
+
+	RTE_LCORE_FOREACH(lcore_id) {
+		/* Restore the original value. */
+		rte_power_qos_set_cpu_resume_latency(lcore_id,
+						     resume_latency_bk[lcore_id]);
+	}
+}
+
+static int
+init_power_library(void)
+{
+	int ret;
+
 	ret = power_cpufreq_init();
 	if (ret != 0) {
 		RTE_LOG(ERR, L3FWD_POWER,
@@ -2385,34 +2451,10 @@ init_power_library(void)
 	if (ret != 0)
 		return ret;
 
-	if (cpu_resume_latency != -1) {
-		RTE_LCORE_FOREACH(lcore_id) {
-			/* Back old CPU resume latency. */
-			ret = rte_power_qos_get_cpu_resume_latency(lcore_id);
-			if (ret < 0) {
-				RTE_LOG(ERR, L3FWD_POWER,
-					"Failed to get cpu resume latency on lcore-%u, ret=%d.\n",
-					lcore_id, ret);
-				return ret;
-			}
-			resume_latency_bk[lcore_id] = ret;
-
-			/*
-			 * Set the cpu resume latency of the worker lcore based
-			 * on user's request. If set strict latency (0), just
-			 * allow the CPU to enter the shallowest idle state to
-			 * improve performance.
-			 */
-			ret = rte_power_qos_set_cpu_resume_latency(lcore_id,
-							cpu_resume_latency);
-			if (ret != 0) {
-				RTE_LOG(ERR, L3FWD_POWER,
-					"Failed to set cpu resume latency on lcore-%u, ret=%d.\n",
-					lcore_id, ret);
-				return ret;
-			}
-		}
-	}
+	ret = power_qos_init();
+	if (ret != 0)
+		RTE_LOG(ERR, L3FWD_POWER,
+			"Initialize power QoS lib failed, ret = %d.\n", ret);
 
 	return ret;
 }
@@ -2420,7 +2462,6 @@ init_power_library(void)
 static int
 deinit_power_library(void)
 {
-	unsigned int lcore_id, max_pkg, max_die, die, pkg;
 	int ret = 0;
 
 	ret = power_cpufreq_uninit();
@@ -2437,13 +2478,7 @@ deinit_power_library(void)
 		return ret;
 	}
 
-	if (cpu_resume_latency != -1) {
-		RTE_LCORE_FOREACH(lcore_id) {
-			/* Restore the original value. */
-			rte_power_qos_set_cpu_resume_latency(lcore_id,
-						resume_latency_bk[lcore_id]);
-		}
-	}
+	power_qos_uninit();
 
 	return ret;
 }
-- 
2.33.0

