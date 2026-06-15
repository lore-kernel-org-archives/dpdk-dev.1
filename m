Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6279FCD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 07:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D26CE436C1;
	Mon, 15 Jun 2026 09:33:29 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id CFA95436C0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:33:27 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=EHEzHppJk2Pu7UVwGl7dmMXwex9IAu+ze4yIE4rmbr4=;
 b=B1u5BYfxlXy6uGajgCagjwpyPLGuLOBpTBBxQRMUmvpD38vh231PB9Zs0qfaTdV6xLtJzIQ0i
 XBZulZjPlv0g01N7VlFTG/OYcbvi9Hcyyb1gIocqf7pXqUY0J70f59JJR/d2d1c7JB5k+fKpAlt
 6yafRcE7by93Ez79vFf7Ta8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gf1qX30xTz1K97d;
 Mon, 15 Jun 2026 15:25:28 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 5AA6E40561;
 Mon, 15 Jun 2026 15:33:24 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 15 Jun 2026 15:33:23 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>, <anatoly.burakov@intel.com>,
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v4 2/9] power/cpufreq: add the lcore ID verification to
 framework
Date: Mon, 15 Jun 2026 15:30:43 +0800
Message-ID: <20260615073050.1996063-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260615073050.1996063-1-lihuisong@huawei.com>
References: <20260615073050.1996063-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

Currently, many cpufreq drivers verify the lcore ID in their
own driver and just restrict it to the RTE_MAX_LCORE range.
Actually, the lcore ID verification is common for each cpufreq
driver. It is better to add this verification to framework.

In addition, the lcore ID for cpufreq library is used by the
application, which is missing in cpufreq library or driver.
So use RTE_POWER_VALID_LCOREID_OR_ERR_RET to verify it in
cpufreq framework.

Please note the lcore ID for cpufreq library must be ROLE_RTE
or ROLE_SERVICE after this patch.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/rte_power_cpufreq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/power/rte_power_cpufreq.c b/lib/power/rte_power_cpufreq.c
index f63e976dc2..8394cbc77f 100644
--- a/lib/power/rte_power_cpufreq.c
+++ b/lib/power/rte_power_cpufreq.c
@@ -116,6 +116,7 @@ rte_power_init(unsigned int lcore_id)
 	struct rte_power_cpufreq_ops *ops;
 	uint8_t env;
 
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	if (global_default_env != PM_ENV_NOT_SET)
 		return global_cpufreq_ops->init(lcore_id);
 
@@ -147,6 +148,7 @@ RTE_EXPORT_SYMBOL(rte_power_exit)
 int
 rte_power_exit(unsigned int lcore_id)
 {
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	if (global_default_env != PM_ENV_NOT_SET)
 		return global_cpufreq_ops->exit(lcore_id);
 
@@ -161,6 +163,7 @@ uint32_t
 rte_power_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t n)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, 0);
 	return global_cpufreq_ops->get_avail_freqs(lcore_id, freqs, n);
 }
 
@@ -169,6 +172,7 @@ uint32_t
 rte_power_get_freq(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, RTE_POWER_INVALID_FREQ_INDEX);
 	return global_cpufreq_ops->get_freq(lcore_id);
 }
 
@@ -177,6 +181,7 @@ uint32_t
 rte_power_set_freq(unsigned int lcore_id, uint32_t index)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->set_freq(lcore_id, index);
 }
 
@@ -185,6 +190,7 @@ int
 rte_power_freq_up(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_up(lcore_id);
 }
 
@@ -193,6 +199,7 @@ int
 rte_power_freq_down(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_down(lcore_id);
 }
 
@@ -201,6 +208,7 @@ int
 rte_power_freq_max(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_max(lcore_id);
 }
 
@@ -209,6 +217,7 @@ int
 rte_power_freq_min(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_min(lcore_id);
 }
 
@@ -217,6 +226,7 @@ int
 rte_power_turbo_status(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->turbo_status(lcore_id);
 }
 
@@ -225,6 +235,7 @@ int
 rte_power_freq_enable_turbo(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->enable_turbo(lcore_id);
 }
 
@@ -233,6 +244,7 @@ int
 rte_power_freq_disable_turbo(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->disable_turbo(lcore_id);
 }
 
@@ -242,5 +254,6 @@ rte_power_get_capabilities(unsigned int lcore_id,
 		struct rte_power_core_capabilities *caps)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->get_caps(lcore_id, caps);
 }
-- 
2.33.0

