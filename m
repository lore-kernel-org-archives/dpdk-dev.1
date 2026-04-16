Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A0F433D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E271740691;
	Thu, 16 Apr 2026 05:06:32 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 44ADD40611
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=olG0Of3b7goZ1cEsoJKpUTBc55tfRv0j9xcAZj7rG4U=;
 b=SKHHOY9S8ot+po5+6+4wiVME6h7SLLiUJLKTrUtCkLgeW/bky5B//YvFVLPeGt2NMm3j67MdJ
 3q2GpSrfE2pH2tUJy+rNXGQcAvIkonVvmuTGb6Y+Nour82vwEEq4x/bOGRwTxQu3wtqxnogsc41
 lf9yFxZv47L+KJqPBo7gZLk=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fx2mv2ncGzRhV0;
 Thu, 16 Apr 2026 10:59:59 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 319994048F;
 Thu, 16 Apr 2026 11:06:18 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:17 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:16 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 10/15] power/cpufreq: add the lcore ID verification to
 framework
Date: Thu, 16 Apr 2026 11:06:07 +0800
Message-ID: <20260416030612.2379407-11-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260416030612.2379407-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
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
 lib/power/rte_power_cpufreq.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/power/rte_power_cpufreq.c b/lib/power/rte_power_cpufreq.c
index f63e976dc2..c51dc8364e 100644
--- a/lib/power/rte_power_cpufreq.c
+++ b/lib/power/rte_power_cpufreq.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2014 Intel Corporation
  */
+#include <errno.h>
 
 #include <eal_export.h>
 #include <rte_spinlock.h>
@@ -116,6 +117,7 @@ rte_power_init(unsigned int lcore_id)
 	struct rte_power_cpufreq_ops *ops;
 	uint8_t env;
 
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	if (global_default_env != PM_ENV_NOT_SET)
 		return global_cpufreq_ops->init(lcore_id);
 
@@ -147,6 +149,7 @@ RTE_EXPORT_SYMBOL(rte_power_exit)
 int
 rte_power_exit(unsigned int lcore_id)
 {
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	if (global_default_env != PM_ENV_NOT_SET)
 		return global_cpufreq_ops->exit(lcore_id);
 
@@ -161,6 +164,7 @@ uint32_t
 rte_power_freqs(unsigned int lcore_id, uint32_t *freqs, uint32_t n)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, 0);
 	return global_cpufreq_ops->get_avail_freqs(lcore_id, freqs, n);
 }
 
@@ -169,6 +173,7 @@ uint32_t
 rte_power_get_freq(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, RTE_POWER_INVALID_FREQ_INDEX);
 	return global_cpufreq_ops->get_freq(lcore_id);
 }
 
@@ -177,6 +182,7 @@ uint32_t
 rte_power_set_freq(unsigned int lcore_id, uint32_t index)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->set_freq(lcore_id, index);
 }
 
@@ -185,6 +191,7 @@ int
 rte_power_freq_up(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_up(lcore_id);
 }
 
@@ -193,6 +200,7 @@ int
 rte_power_freq_down(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_down(lcore_id);
 }
 
@@ -201,6 +209,7 @@ int
 rte_power_freq_max(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_max(lcore_id);
 }
 
@@ -209,6 +218,7 @@ int
 rte_power_freq_min(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->freq_min(lcore_id);
 }
 
@@ -217,6 +227,7 @@ int
 rte_power_turbo_status(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->turbo_status(lcore_id);
 }
 
@@ -225,6 +236,7 @@ int
 rte_power_freq_enable_turbo(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->enable_turbo(lcore_id);
 }
 
@@ -233,6 +245,7 @@ int
 rte_power_freq_disable_turbo(unsigned int lcore_id)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->disable_turbo(lcore_id);
 }
 
@@ -242,5 +255,6 @@ rte_power_get_capabilities(unsigned int lcore_id,
 		struct rte_power_core_capabilities *caps)
 {
 	RTE_ASSERT(global_cpufreq_ops != NULL);
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -1);
 	return global_cpufreq_ops->get_caps(lcore_id, caps);
 }
-- 
2.33.0

