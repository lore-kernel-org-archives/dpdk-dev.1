Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADE606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h1qEDmhC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5558240685;
	Thu, 26 Nov 2026 19:15:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 64CAA4065A
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716915; x=1827252915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OtXUQnKDZJ1dA2J0IDHeWLx9eLD8qZJxDffrBKQ6Cuk=;
 b=h1qEDmhCqahtNELttbP3Sx46Mj+r5HrbtYozyeJ1KYYx8a9hD6LVsm7f
 dlj+t9TB+aj9XkppRn+5Xa9piwt7kxwLyNg+f8rzgMpnftwgjIcTZ8+ao
 ras/zQl6nudg3ioniYXogXX7RyEc2gQEzLZE2XB8T6fcvh2tWd9cGa1ef
 d8KueIDZ+hBYGpUJe8bqMo0nwnGyHGZPOPK1CNvN8KWj+fxJH+jEnDlcZ
 O8gZtpfVgvtqP+YFwR1GBPR3eNP6HAH2jhUAwj82YGfQbRyGsZBW7UUcZ
 g8kfsA2e1xo7u9w1WTGm1OvQxbAKNPDIETEXeWhvZr8EzMMZ7sVh7p8Qw A==;
X-CSE-ConnectionGUID: 1aZ4kix8TmelMqC9SoI24w==
X-CSE-MsgGUID: vFwHbxiGSKa+ZwavxCcYZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633612"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633612"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:14 -0800
X-CSE-ConnectionGUID: ovbWzPFqSq6zHgvWMV/YEg==
X-CSE-MsgGUID: PpGCF5uxQaa4rt1v+Ze/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733072"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:09 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 20/39] eal: make lcore role a field in lcore config struct
Date: Thu, 26 Nov 2026 18:13:53 +0000
Message-ID: <20261126181414.124094-21-bruce.richardson@intel.com>
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

Rather than having a separate array for lcore role, just make the role a
field in the lcore_cfg struct.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c   | 28 ++++++++++++++--------------
 lib/eal/common/eal_common_options.c | 26 +++++++++++++-------------
 lib/eal/common/eal_internal_cfg.h   |  2 +-
 lib/eal/common/rte_service.c        |  6 +++---
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 24c8872765..3a4cc70c7e 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -90,7 +90,7 @@ rte_eal_lcore_role(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return RTE_LCORE_ROLE_OFF;
-	return runtime_state->lcore_role[lcore_id];
+	return runtime_state->lcore_cfg[lcore_id].role;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_has_role)
@@ -102,7 +102,7 @@ rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
 
-	return runtime_state->lcore_role[lcore_id] == role;
+	return runtime_state->lcore_cfg[lcore_id].role == role;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_is_enabled)
@@ -112,7 +112,7 @@ int rte_lcore_is_enabled(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
-	return runtime_state->lcore_role[lcore_id] == RTE_LCORE_ROLE_RTE;
+	return runtime_state->lcore_cfg[lcore_id].role == RTE_LCORE_ROLE_RTE;
 }
 
 RTE_EXPORT_SYMBOL(rte_get_next_lcore)
@@ -350,7 +350,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	if (callback->init == NULL)
 		goto no_init;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == RTE_LCORE_ROLE_OFF)
 			continue;
 		if (callback_init(callback, lcore_id) == 0)
 			continue;
@@ -358,7 +358,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 		 * previous lcore.
 		 */
 		while (lcore_id-- != 0) {
-			if (runtime_state->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
+			if (runtime_state->lcore_cfg[lcore_id].role == RTE_LCORE_ROLE_OFF)
 				continue;
 			callback_uninit(callback, lcore_id);
 		}
@@ -390,7 +390,7 @@ rte_lcore_callback_unregister(void *handle)
 	if (callback->uninit == NULL)
 		goto no_uninit;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == RTE_LCORE_ROLE_OFF)
 			continue;
 		callback_uninit(callback, lcore_id);
 	}
@@ -419,11 +419,11 @@ eal_lcore_non_eal_allocate(void)
 		goto out;
 	}
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] != RTE_LCORE_ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role != RTE_LCORE_ROLE_OFF)
 			continue;
 		rte_bitset_set(runtime_state->core_indices, core_index);
 		runtime_state->lcore_cfg[lcore_id].core_index = core_index;
-		runtime_state->lcore_role[lcore_id] =RTE_LCORE_ROLE_NON_EAL;
+		runtime_state->lcore_cfg[lcore_id].role = RTE_LCORE_ROLE_NON_EAL;
 		runtime_state->lcore_count++;
 		break;
 	}
@@ -447,7 +447,7 @@ eal_lcore_non_eal_allocate(void)
 		rte_bitset_clear(runtime_state->core_indices,
 				runtime_state->lcore_cfg[lcore_id].core_index);
 		runtime_state->lcore_cfg[lcore_id].core_index = -1;
-		runtime_state->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
+		runtime_state->lcore_cfg[lcore_id].role = RTE_LCORE_ROLE_OFF;
 		runtime_state->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
 		goto out;
@@ -464,14 +464,14 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 	struct lcore_callback *callback;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	if (runtime_state->lcore_role[lcore_id] != RTE_LCORE_ROLE_NON_EAL)
+	if (runtime_state->lcore_cfg[lcore_id].role != RTE_LCORE_ROLE_NON_EAL)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
 	rte_bitset_clear(runtime_state->core_indices,
 			runtime_state->lcore_cfg[lcore_id].core_index);
 	runtime_state->lcore_cfg[lcore_id].core_index = -1;
-	runtime_state->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
+	runtime_state->lcore_cfg[lcore_id].role = RTE_LCORE_ROLE_OFF;
 	runtime_state->lcore_count--;
 out:
 	rte_rwlock_write_unlock(&lcore_lock);
@@ -487,7 +487,7 @@ rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 
 	rte_rwlock_read_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == RTE_LCORE_ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == RTE_LCORE_ROLE_OFF)
 			continue;
 		ret = cb(lcore_id, arg);
 		if (ret != 0)
@@ -552,7 +552,7 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 	cpuset = eal_cpuset_to_str(&runtime_state->lcore_cfg[lcore_id].cpuset);
 	fprintf(f, "lcore %u, socket %u, role %s, cpuset %s\n", lcore_id,
 		rte_lcore_to_socket_id(lcore_id),
-		lcore_role_str(runtime_state->lcore_role[lcore_id]),
+		lcore_role_str(runtime_state->lcore_cfg[lcore_id].role),
 		cpuset != NULL ? cpuset : "<unknown>");
 	free(cpuset);
 	free(usage_str);
@@ -619,7 +619,7 @@ lcore_telemetry_info_cb(unsigned int lcore_id, void *arg)
 	rte_tel_data_add_dict_int(info->d, "lcore_id", lcore_id);
 	rte_tel_data_add_dict_int(info->d, "socket", rte_lcore_to_socket_id(lcore_id));
 	rte_tel_data_add_dict_string(info->d, "role",
-			lcore_role_str(runtime_state->lcore_role[lcore_id]));
+			lcore_role_str(runtime_state->lcore_cfg[lcore_id].role));
 	cpuset = rte_tel_data_alloc();
 	if (cpuset == NULL)
 		return -ENOMEM;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 6a7da51dac..e8109b94c0 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -907,10 +907,10 @@ eal_parse_service_coremask(const char *coremask)
 					return -1;
 				}
 
-				if (runtime_state->lcore_role[idx] == RTE_LCORE_ROLE_RTE)
+				if (runtime_state->lcore_cfg[idx].role == RTE_LCORE_ROLE_RTE)
 					taken_lcore_count++;
 
-				runtime_state->lcore_role[idx] = RTE_LCORE_ROLE_SERVICE;
+				runtime_state->lcore_cfg[idx].role = RTE_LCORE_ROLE_SERVICE;
 				count++;
 			}
 		}
@@ -946,7 +946,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 	/* set everything to disabled first, then set up values */
 	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		runtime_state->lcore_role[i] = RTE_LCORE_ROLE_OFF;
+		runtime_state->lcore_cfg[i].role = RTE_LCORE_ROLE_OFF;
 		runtime_state->lcore_cfg[i].core_index = -1;
 	}
 
@@ -975,7 +975,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 			}
 
 			rte_bitset_set(runtime_state->core_indices, count);
-			runtime_state->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
+			runtime_state->lcore_cfg[lcore_id].role = RTE_LCORE_ROLE_RTE;
 			runtime_state->lcore_cfg[lcore_id].core_index = count;
 			CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
 			CPU_SET(i, &runtime_state->lcore_cfg[lcore_id].cpuset);
@@ -1148,11 +1148,11 @@ eal_parse_service_corelist(const char *corelist)
 			if (min == RTE_MAX_LCORE)
 				min = idx;
 			for (idx = min; idx <= max; idx++) {
-				if (runtime_state->lcore_role[idx] != RTE_LCORE_ROLE_SERVICE) {
-					if (runtime_state->lcore_role[idx] == RTE_LCORE_ROLE_RTE)
+				if (runtime_state->lcore_cfg[idx].role != RTE_LCORE_ROLE_SERVICE) {
+					if (runtime_state->lcore_cfg[idx].role == RTE_LCORE_ROLE_RTE)
 						taken_lcore_count++;
 
-					runtime_state->lcore_role[idx] = RTE_LCORE_ROLE_SERVICE;
+					runtime_state->lcore_cfg[idx].role = RTE_LCORE_ROLE_SERVICE;
 					count++;
 				}
 			}
@@ -1175,7 +1175,7 @@ eal_parse_service_corelist(const char *corelist)
 	rte_cpuset_t service_cpuset;
 	CPU_ZERO(&service_cpuset);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (runtime_state->lcore_role[i] == RTE_LCORE_ROLE_SERVICE)
+		if (runtime_state->lcore_cfg[i].role == RTE_LCORE_ROLE_SERVICE)
 			CPU_SET(i, &service_cpuset);
 	}
 	if (CPU_COUNT(&service_cpuset) > 0) {
@@ -1205,12 +1205,12 @@ eal_parse_main_lcore(const char *arg)
 		return -1;
 
 	/* ensure main core is not used as service core */
-	if (runtime_state->lcore_role[cfg->main_lcore] == RTE_LCORE_ROLE_SERVICE) {
+	if (runtime_state->lcore_cfg[cfg->main_lcore].role == RTE_LCORE_ROLE_SERVICE) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
 	/* check that we have the core recorded in the core list */
-	if (runtime_state->lcore_role[cfg->main_lcore] != RTE_LCORE_ROLE_RTE) {
+	if (runtime_state->lcore_cfg[cfg->main_lcore].role != RTE_LCORE_ROLE_RTE) {
 		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
@@ -1400,7 +1400,7 @@ eal_parse_lcores(const char *lcores)
 	/* Reset lcore config */
 	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		runtime_state->lcore_role[idx] = RTE_LCORE_ROLE_OFF;
+		runtime_state->lcore_cfg[idx].role = RTE_LCORE_ROLE_OFF;
 		runtime_state->lcore_cfg[idx].core_index = -1;
 		CPU_ZERO(&runtime_state->lcore_cfg[idx].cpuset);
 		runtime_state->lcore_cfg[idx].first_cpu = UINT16_MAX;
@@ -1463,10 +1463,10 @@ eal_parse_lcores(const char *lcores)
 				continue;
 			set_count--;
 
-			if (runtime_state->lcore_role[idx] != RTE_LCORE_ROLE_RTE) {
+			if (runtime_state->lcore_cfg[idx].role != RTE_LCORE_ROLE_RTE) {
 				rte_bitset_set(runtime_state->core_indices, count);
 				runtime_state->lcore_cfg[idx].core_index = count;
-				runtime_state->lcore_role[idx] = RTE_LCORE_ROLE_RTE;
+				runtime_state->lcore_cfg[idx].role = RTE_LCORE_ROLE_RTE;
 				count++;
 			}
 
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index c5737d070c..83944c5951 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -129,6 +129,7 @@ struct eal_platform_info {
  */
 struct lcore_cfg {
 	int core_index;                   /**< relative index, starting from 0 */
+	enum rte_lcore_role_t role;       /**< role assigned to this lcore */
 	rte_cpuset_t cpuset;              /**< cpu set which the lcore affinity to */
 	uint16_t first_cpu;               /**< lowest CPU set in cpuset, UINT16_MAX if none */
 	/* Fields for executing code on a remote lcore */
@@ -153,7 +154,6 @@ struct eal_runtime_state {
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
-	enum rte_lcore_role_t lcore_role[RTE_MAX_LCORE]; /**< State of cores. */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
 };
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index c4908ae4be..954b5503b4 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -108,7 +108,7 @@ rte_service_init(void)
 	const struct rte_config *cfg = rte_eal_get_configuration();
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (runtime_state->lcore_role[i] == RTE_LCORE_ROLE_SERVICE) {
+		if (runtime_state->lcore_cfg[i].role == RTE_LCORE_ROLE_SERVICE) {
 			if ((unsigned int)i == cfg->main_lcore)
 				continue;
 			rte_service_lcore_add(i);
@@ -712,7 +712,7 @@ set_lcore_state(uint32_t lcore, int32_t state)
 {
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct core_state *cs =	RTE_LCORE_VAR_LCORE(lcore, lcore_states);
-	runtime_state->lcore_role[lcore] = state;
+	runtime_state->lcore_cfg[lcore].role = state;
 
 	/* update per-lcore optimized state tracking */
 	cs->is_service_core = (state == RTE_LCORE_ROLE_SERVICE);
@@ -1123,7 +1123,7 @@ rte_service_dump(FILE *f, uint32_t id)
 
 	fprintf(f, "Service Cores Summary\n");
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (runtime_state->lcore_role[i] != RTE_LCORE_ROLE_SERVICE)
+		if (runtime_state->lcore_cfg[i].role != RTE_LCORE_ROLE_SERVICE)
 			continue;
 
 		service_dump_calls_per_lcore(f, i);
-- 
2.55.0

