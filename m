Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC5EC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:35:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35F9040DDE;
	Tue, 18 Aug 2026 15:34:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3B29040A89
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060040; x=1818596040;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E1ICTThhV3QGXX8BFsGrDZ8NdH38Krwqv4NN8Ba3vOs=;
 b=nVhXop734uqNBGIWT/lcD13ZWkSSKnTFB9Jtb5OGwvaSPDLpSfmqRaX+
 EHsVErS1yKJWfo334VEi2pcnQjlJtAjRJzGRlpCUbD94DVV48FRowRsLw
 yCZ6mIbqP5RrATwa0NWyyhHIWS8XKOH//pCgOGsUdKhE6ugErLFsoX+ht
 VOaOdULQi76LLxh0eJp/WW+vCRr+Swn77sU34GWbhk1MyLgClLA0z4t8o
 K2UJT410KAQA/t900+5U86VTfXL29pk+05F+iBOhY4S/YEYJpsKdBoP1E
 3mwuTdy1dtzSJ2L7lH1UEJdJiFNm/7ZAIjJOrC/xiu8gECDw58Gi1gx17 A==;
X-CSE-ConnectionGUID: CMOxEy8fQW2TLTwIO6lp5g==
X-CSE-MsgGUID: zMqOQHjjQAm0RfNbskmcRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757642"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757642"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:59 -0700
X-CSE-ConnectionGUID: afGstnfSS/6GLIj8oG7zfw==
X-CSE-MsgGUID: hxRyQWUQTsSyKj9d5qx1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736649"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:58 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 16/39] eal: move core indices bitset to runtime state
Date: Tue, 18 Aug 2026 14:33:09 +0100
Message-ID: <20260818133334.2620165-17-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index c0d8c5d137..da33790b06 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -223,7 +223,7 @@ rte_eal_cpu_init(void)
 		runtime_state->lcore_cfg[lcore_id].first_cpu = lcore_id;
 
 		/* This is the first time we discover the lcores, so the bitset should be zeroed */
-		rte_bitset_set(config->core_indices, count);
+		rte_bitset_set(runtime_state->core_indices, count);
 
 		/* By default, each detected core is enabled */
 		config->lcore_role[lcore_id] = ROLE_RTE;
@@ -417,7 +417,7 @@ eal_lcore_non_eal_allocate(void)
 	int core_index = -1;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	core_index = rte_bitset_find_first_clear(cfg->core_indices, RTE_MAX_LCORE);
+	core_index = rte_bitset_find_first_clear(runtime_state->core_indices, RTE_MAX_LCORE);
 	if (core_index == -1) {
 		EAL_LOG(DEBUG, "No core_index available.");
 		lcore_id = RTE_MAX_LCORE;
@@ -426,7 +426,7 @@ eal_lcore_non_eal_allocate(void)
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (cfg->lcore_role[lcore_id] != ROLE_OFF)
 			continue;
-		rte_bitset_set(cfg->core_indices, core_index);
+		rte_bitset_set(runtime_state->core_indices, core_index);
 		runtime_state->lcore_cfg[lcore_id].core_index = core_index;
 		cfg->lcore_role[lcore_id] = ROLE_NON_EAL;
 		cfg->lcore_count++;
@@ -449,7 +449,8 @@ eal_lcore_non_eal_allocate(void)
 		}
 		EAL_LOG(DEBUG, "Initialization refused for lcore %u.",
 			lcore_id);
-		rte_bitset_clear(cfg->core_indices, runtime_state->lcore_cfg[lcore_id].core_index);
+		rte_bitset_clear(runtime_state->core_indices,
+				runtime_state->lcore_cfg[lcore_id].core_index);
 		runtime_state->lcore_cfg[lcore_id].core_index = -1;
 		cfg->lcore_role[lcore_id] = ROLE_OFF;
 		cfg->lcore_count--;
@@ -473,7 +474,8 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
-	rte_bitset_clear(cfg->core_indices, runtime_state->lcore_cfg[lcore_id].core_index);
+	rte_bitset_clear(runtime_state->core_indices,
+			runtime_state->lcore_cfg[lcore_id].core_index);
 	runtime_state->lcore_cfg[lcore_id].core_index = -1;
 	cfg->lcore_role[lcore_id] = ROLE_OFF;
 	cfg->lcore_count--;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 4011d5d696..bc18374377 100644
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
 		cfg->lcore_role[i] = ROLE_OFF;
 		runtime_state->lcore_cfg[i].core_index = -1;
@@ -976,7 +977,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				continue;
 			}
 
-			rte_bitset_set(cfg->core_indices, count);
+			rte_bitset_set(runtime_state->core_indices, count);
 			cfg->lcore_role[lcore_id] = ROLE_RTE;
 			runtime_state->lcore_cfg[lcore_id].core_index = count;
 			CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
@@ -1400,7 +1401,7 @@ eal_parse_lcores(const char *lcores)
 	CPU_ZERO(&cpuset);
 
 	/* Reset lcore config */
-	rte_bitset_clear_all(cfg->core_indices, RTE_MAX_LCORE);
+	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
 		cfg->lcore_role[idx] = ROLE_OFF;
 		runtime_state->lcore_cfg[idx].core_index = -1;
@@ -1466,7 +1467,7 @@ eal_parse_lcores(const char *lcores)
 			set_count--;
 
 			if (cfg->lcore_role[idx] != ROLE_RTE) {
-				rte_bitset_set(cfg->core_indices, count);
+				rte_bitset_set(runtime_state->core_indices, count);
 				runtime_state->lcore_cfg[idx].core_index = count;
 				cfg->lcore_role[idx] = ROLE_RTE;
 				count++;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 4f17f63a45..1aa1338d80 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -16,6 +16,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 
+#include <rte_bitset.h>
 #include <rte_stdatomic.h>
 #include "eal_thread.h"
 
@@ -144,6 +145,7 @@ struct eal_runtime_state {
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
+	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index b0961304ed..65ae4df27c 100644
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
2.53.0

