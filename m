Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B546CD3436
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C595C40668;
	Thu,  7 May 2026 04:42:44 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 7842D4025A
 for <dev@dpdk.org>; Thu,  7 May 2026 04:42:36 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=+1D+drQfB8jFAsHdq+1mxT4yzRfV1MxzmAEqN+OWvjc=;
 b=D4Kgd5g/9JPMZsv8mUwLDCuiknUICRsCjyFF2iYQ6FEhtm92jpuJCA0AIE7NBipWu/0lg9gFK
 Aym54fEK6hKwxUJFq3VV5/L5OIZpg8QNIZ3IG6OunSptVvnh/sgnAU341gqfreqs8syJ6HU87Tr
 NlJXEgPGNRabX4Z+SoYDyBA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4g9xFX2GYlz1prL8;
 Thu,  7 May 2026 10:36:00 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 9E58640561;
 Thu,  7 May 2026 10:42:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 10:42:34 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 10:42:33 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 08/15] power/cpufreq: add the lcore ID verification to
 framework
Date: Thu, 7 May 2026 10:42:23 +0800
Message-ID: <20260507024230.1198111-9-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507024230.1198111-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260507024230.1198111-1-lihuisong@huawei.com>
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

The lcore ID verification is common for each cpufreq driver.
So add this verification to framework.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/rte_power_cpufreq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/power/rte_power_cpufreq.c b/lib/power/rte_power_cpufreq.c
index f63e976dc2..54872debfa 100644
--- a/lib/power/rte_power_cpufreq.c
+++ b/lib/power/rte_power_cpufreq.c
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2014 Intel Corporation
  */
-
 #include <eal_export.h>
 #include <rte_spinlock.h>
 #include <rte_debug.h>
@@ -116,6 +115,7 @@ rte_power_init(unsigned int lcore_id)
 	struct rte_power_cpufreq_ops *ops;
 	uint8_t env;
 
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	if (global_default_env != PM_ENV_NOT_SET)
 		return global_cpufreq_ops->init(lcore_id);
 
@@ -147,6 +147,7 @@ RTE_EXPORT_SYMBOL(rte_power_exit)
 int
 rte_power_exit(unsigned int lcore_id)
 {
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	if (global_default_env != PM_ENV_NOT_SET)
 		return global_cpufreq_ops->exit(lcore_id);
 
@@ -161,6 +162,7 @@ uint32_t
 rte_power_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t n)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, 0);
 	return global_cpufreq_ops->get_avail_freqs(lcore_id, freqs, n);
 }
 
@@ -169,6 +171,7 @@ uint32_t
 rte_power_get_freq(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, RTE_POWER_INVALID_FREQ_INDEX);
 	return global_cpufreq_ops->get_freq(lcore_id);
 }
 
@@ -177,6 +180,7 @@ uint32_t
 rte_power_set_freq(unsigned int lcore_id, uint32_t index)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->set_freq(lcore_id, index);
 }
 
@@ -185,6 +189,7 @@ int
 rte_power_freq_up(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_up(lcore_id);
 }
 
@@ -193,6 +198,7 @@ int
 rte_power_freq_down(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_down(lcore_id);
 }
 
@@ -201,6 +207,7 @@ int
 rte_power_freq_max(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_max(lcore_id);
 }
 
@@ -209,6 +216,7 @@ int
 rte_power_freq_min(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_min(lcore_id);
 }
 
@@ -217,6 +225,7 @@ int
 rte_power_turbo_status(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->turbo_status(lcore_id);
 }
 
@@ -225,6 +234,7 @@ int
 rte_power_freq_enable_turbo(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->enable_turbo(lcore_id);
 }
 
@@ -233,6 +243,7 @@ int
 rte_power_freq_disable_turbo(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->disable_turbo(lcore_id);
 }
 
@@ -242,5 +253,6 @@ rte_power_get_capabilities(unsigned int lcore_id,
 		struct rte_power_core_capabilities *caps)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->get_caps(lcore_id, caps);
 }
-- 
2.33.0

