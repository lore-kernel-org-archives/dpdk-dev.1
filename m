Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07830606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lsLHq2iI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73DC040A67;
	Thu, 26 Nov 2026 19:14:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id D738940A79
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716875; x=1827252875;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oRvVqS9dl+OO6TR4LB0Ur2Bst1YmhcYg16hvCHtvb8w=;
 b=lsLHq2iIsz1f459CDlnTC6UItO5QOro0pARXNSLgZ4X5E5DCDkPnFxHd
 H0ZC9lh9hFtSI81OwzRixHQZ2JRWqBKji1/q4ru7fJVLp+J2NAPHB5Nnx
 +mPpwwpzBLGTWYhkdAeeffWWBpxx1HQUChp+IfVMLaHbH0Pmb7nHO7QfU
 LgYLDoqOyDrrSxfGBErpbQOrGaRniMzUKE25jkxbyYRxJYbR1556gk7PB
 1UuuN2G7DY8tQVgxN69Pc2SrEVaM70c2MO/rjG5REkT4ebX7bvvvYNRYz
 koyqwFENW5OlOw30s3wunyzyJpfLzjtJmMtRS2xSbPLVXHOHuKYZ1k+R9 g==;
X-CSE-ConnectionGUID: Ov/sujkEREaLyHeJ4vJc/w==
X-CSE-MsgGUID: rf2brImpTbi8fduN7w5cDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633577"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633577"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:34 -0800
X-CSE-ConnectionGUID: znMo8SD2R+u4Sr50ymTaLQ==
X-CSE-MsgGUID: jbSlNd4pSg68BD4Cc9h3Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732912"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:32 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 16/39] eal: move core indices bitset to runtime state
Date: Thu, 26 Nov 2026 18:13:49 +0000
Message-ID: <20261126181414.124094-17-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the bitset for tracking allocated lcore ids to the runtime
configuration struct, to co-exist with the other lcore data.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c   | 12 +++++++-----
 lib/eal/common/eal_common_options.c | 11 ++++++-----
 lib/eal/common/eal_internal_cfg.h   |  2 ++
 lib/eal/common/eal_private.h        |  3 ---
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index e207697900..eab60d548a 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -234,7 +234,7 @@ rte_eal_cpu_init(void)
 		runtime_state->lcore_cfg[lcore_id].first_cpu = lcore_id;
 
 		/* This is the first time we discover the lcores, so the bitset should be zeroed */
-		rte_bitset_set(config->core_indices, count);
+		rte_bitset_set(runtime_state->core_indices, count);
 
 		/* By default, each detected core is enabled */
 		config->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
@@ -428,7 +428,7 @@ eal_lcore_non_eal_allocate(void)
 	int core_index = -1;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	core_index = rte_bitset_find_first_clear(cfg->core_indices, RTE_MAX_LCORE);
+	core_index = rte_bitset_find_first_clear(runtime_state->core_indices, RTE_MAX_LCORE);
 	if (core_index == -1) {
 		EAL_LOG(DEBUG, "No core_index available.");
 		lcore_id = RTE_MAX_LCORE;
@@ -437,7 +437,7 @@ eal_lcore_non_eal_allocate(void)
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (cfg->lcore_role[lcore_id] != RTE_LCORE_ROLE_OFF)
 			continue;
-		rte_bitset_set(cfg->core_indices, core_index);
+		rte_bitset_set(runtime_state->core_indices, core_index);
 		runtime_state->lcore_cfg[lcore_id].core_index = core_index;
 		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_NON_EAL;
 		cfg->lcore_count++;
@@ -460,7 +460,8 @@ eal_lcore_non_eal_allocate(void)
 		}
 		EAL_LOG(DEBUG, "Initialization refused for lcore %u.",
 			lcore_id);
-		rte_bitset_clear(cfg->core_indices, runtime_state->lcore_cfg[lcore_id].core_index);
+		rte_bitset_clear(runtime_state->core_indices,
+				runtime_state->lcore_cfg[lcore_id].core_index);
 		runtime_state->lcore_cfg[lcore_id].core_index = -1;
 		cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 		cfg->lcore_count--;
@@ -484,7 +485,8 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
-	rte_bitset_clear(cfg->core_indices, runtime_state->lcore_cfg[lcore_id].core_index);
+	rte_bitset_clear(runtime_state->core_indices,
+			runtime_state->lcore_cfg[lcore_id].core_index);
 	runtime_state->lcore_cfg[lcore_id].core_index = -1;
 	cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 	cfg->lcore_count--;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index fa1d7763c2..4477969a1f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -864,6 +864,7 @@ static int
 eal_parse_service_coremask(const char *coremask)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int i, j, idx = 0;
 	unsigned int count = 0;
 	char c;
@@ -920,7 +921,7 @@ eal_parse_service_coremask(const char *coremask)
 		if (coremask[i] != '0')
 			return -1;
 
-	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
+	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 
 	if (count == 0)
 		return -1;
@@ -946,7 +947,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 	int ret = 0;
 
 	/* set everything to disabled first, then set up values */
-	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
+	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		cfg->lcore_role[i] = RTE_LCORE_ROLE_OFF;
 		runtime_state->lcore_cfg[i].core_index = -1;
@@ -976,7 +977,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				continue;
 			}
 
-			rte_bitset_set(cfg->core_indices, count);
+			rte_bitset_set(runtime_state->core_indices, count);
 			cfg->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
 			runtime_state->lcore_cfg[lcore_id].core_index = count;
 			CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
@@ -1400,7 +1401,7 @@ eal_parse_lcores(const char *lcores)
 	CPU_ZERO(&cpuset);
 
 	/* Reset lcore config */
-	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
+	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
 		cfg->lcore_role[idx] = RTE_LCORE_ROLE_OFF;
 		runtime_state->lcore_cfg[idx].core_index = -1;
@@ -1466,7 +1467,7 @@ eal_parse_lcores(const char *lcores)
 			set_count--;
 
 			if (cfg->lcore_role[idx] != RTE_LCORE_ROLE_RTE) {
-				rte_bitset_set(cfg->core_indices, count);
+				rte_bitset_set(runtime_state->core_indices, count);
 				runtime_state->lcore_cfg[idx].core_index = count;
 				cfg->lcore_role[idx] = RTE_LCORE_ROLE_RTE;
 				count++;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 28388793a1..e0a3c8dec5 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -16,6 +16,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 
+#include <rte_bitset.h>
 #include <rte_stdatomic.h>
 #include "eal_thread.h"
 
@@ -150,6 +151,7 @@ struct eal_runtime_state {
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
+	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index e146be3adb..d2b99582c9 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -11,7 +11,6 @@
 #include <sys/queue.h>
 
 #include <dev_driver.h>
-#include <rte_bitset.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -22,8 +21,6 @@
  * The global RTE configuration structure.
  */
 struct rte_config {
-	RTE_BITSET_DECLARE(core_indices,
-			   RTE_MAX_LCORE); /**< bitset of currently allocated core_indices */
 	uint32_t main_lcore;         /**< Id of the main lcore */
 	uint32_t lcore_count;        /**< Number of available logical cores. */
 	uint32_t numa_node_count;    /**< Number of detected NUMA nodes. */
-- 
2.55.0

