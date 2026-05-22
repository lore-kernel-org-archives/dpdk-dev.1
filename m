Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E5CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 04:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B705E4065A;
	Fri, 22 May 2026 06:11:18 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 77EF9402A2
 for <dev@dpdk.org>; Fri, 22 May 2026 06:11:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ki4n+d8nOXb3S4WGNiHkfyehm703CQzgulTwe5JDsW4=;
 b=SHjcbKHj5sAD+pc0j4/TRgqOBiNVwptQjqnWiIdrKc3v6sBTmqpNJJLtEAXq7LalHAjmqlmyV
 7kPkElNjSLZLU/z92PDLEDPUAwxqGNyRUfvG3jaPS68auiKehsLMp2Sk4e2LbZJw4pLetk4h/IL
 FHlOjcQWI7xp8dIR+z7+l18=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gMBV44CsKzpStk;
 Fri, 22 May 2026 12:03:56 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 859CB40576;
 Fri, 22 May 2026 12:11:13 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 12:11:13 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 22 May 2026 12:11:12 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v3 03/10] power/cpufreq: add the lcore ID verification to
 framework
Date: Fri, 22 May 2026 12:11:03 +0800
Message-ID: <20260522041110.2023062-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260522041110.2023062-1-lihuisong@huawei.com>
References: <20260522041110.2023062-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Currently, many cpufreq drivers verify the lcore ID in their
own driver and just restrict it to the RTE_MAX_LCORE range.
Actually, the lcore ID verification is common for each cpufreq
driver. It is better to add this verification to framework.

In addition, the lcore ID for cpufreq library is used by the
application and managed by the EAL layer. So this patch use
rte_lcore_is_eal_managed to verify the lcore ID in cpufreq
core.

Please note the lcore ID for cpufreq library must be ROLE_RTE
or ROLE_SERVICE after this patch.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 doc/guides/rel_notes/release_26_07.rst |  7 +++++++
 lib/power/rte_power_cpufreq.c          | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index be5ccecd46..98a7cf0203 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -69,6 +69,13 @@ New Features
   to check whether a logical core is managed by EAL
   (i.e., its role is ``ROLE_RTE`` or ``ROLE_SERVICE``).
 
+* **Added lcore ID verification to power cpufreq framework.**
+
+  Added centralized lcore ID validation using ``rte_lcore_is_eal_managed()``
+  in the power cpufreq framework. All cpufreq API functions now verify
+  that the lcore ID is EAL-managed (``ROLE_RTE`` or ``ROLE_SERVICE``)
+  before proceeding, replacing per-driver range checks.
+
 
 Removed Items
 -------------
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

