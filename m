Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56740C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:36:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48E4E40E16;
	Tue, 18 Aug 2026 15:34:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 40B1A40E09
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060044; x=1818596044;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/WAo45ViBpeWgGcvyYh3mH496z7YyqQMr0DYk+rhHZo=;
 b=id3yWFvMKkJcxETYXHXINjy1aU8nGVFmCYlC48VrObPzQuIbBkW9zeK6
 tYnGWU8UitlBCxqk0QIIQIykDUfn2Ci+AOAKgWfVJWlvMuwCSoGtZJ4fu
 JfqedF1im/y6NlzNukaQDThEiBeELEIapm3lhmW8vVXtWc1J7qNq0WYgt
 2dJnCAGm6mt5COaUQ0tzSY4KC6JLQW4bquvhlWvN0c1RglZu5YLbeqPzQ
 IKps6ltKg0pd+k722iZ6fu+a7oFvnnA/OhbRtoNaIWX4mjEddKfnmruNv
 7l//63ry7far5EtCeil3py/5nhmMVQwz5GWXIzKppF0R51IUhM/oxSk2O A==;
X-CSE-ConnectionGUID: SP36CNWjTcSheeCktZgBcA==
X-CSE-MsgGUID: 9mKsLgKdR6KTGvXgV9YBbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757653"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757653"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:34:03 -0700
X-CSE-ConnectionGUID: UgkOWYaPTfy6v4tD5rtgkA==
X-CSE-MsgGUID: fpC21A4wTsmIBGBXZb8dGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736688"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:34:01 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 20/39] eal: make lcore role a field in lcore config struct
Date: Tue, 18 Aug 2026 14:33:13 +0100
Message-ID: <20260818133334.2620165-21-bruce.richardson@intel.com>
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
index 20d543d76f..0b59262364 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -89,7 +89,7 @@ rte_eal_lcore_role(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return ROLE_OFF;
-	return runtime_state->lcore_role[lcore_id];
+	return runtime_state->lcore_cfg[lcore_id].role;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_has_role)
@@ -101,7 +101,7 @@ rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
 
-	return runtime_state->lcore_role[lcore_id] == role;
+	return runtime_state->lcore_cfg[lcore_id].role == role;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_is_enabled)
@@ -111,7 +111,7 @@ int rte_lcore_is_enabled(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
-	return runtime_state->lcore_role[lcore_id] == ROLE_RTE;
+	return runtime_state->lcore_cfg[lcore_id].role == ROLE_RTE;
 }
 
 RTE_EXPORT_SYMBOL(rte_get_next_lcore)
@@ -339,7 +339,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	if (callback->init == NULL)
 		goto no_init;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == ROLE_OFF)
 			continue;
 		if (callback_init(callback, lcore_id) == 0)
 			continue;
@@ -347,7 +347,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 		 * previous lcore.
 		 */
 		while (lcore_id-- != 0) {
-			if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
+			if (runtime_state->lcore_cfg[lcore_id].role == ROLE_OFF)
 				continue;
 			callback_uninit(callback, lcore_id);
 		}
@@ -379,7 +379,7 @@ rte_lcore_callback_unregister(void *handle)
 	if (callback->uninit == NULL)
 		goto no_uninit;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == ROLE_OFF)
 			continue;
 		callback_uninit(callback, lcore_id);
 	}
@@ -408,11 +408,11 @@ eal_lcore_non_eal_allocate(void)
 		goto out;
 	}
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] != ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role != ROLE_OFF)
 			continue;
 		rte_bitset_set(runtime_state->core_indices, core_index);
 		runtime_state->lcore_cfg[lcore_id].core_index = core_index;
-		runtime_state->lcore_role[lcore_id] = ROLE_NON_EAL;
+		runtime_state->lcore_cfg[lcore_id].role = ROLE_NON_EAL;
 		runtime_state->lcore_count++;
 		break;
 	}
@@ -436,7 +436,7 @@ eal_lcore_non_eal_allocate(void)
 		rte_bitset_clear(runtime_state->core_indices,
 				runtime_state->lcore_cfg[lcore_id].core_index);
 		runtime_state->lcore_cfg[lcore_id].core_index = -1;
-		runtime_state->lcore_role[lcore_id] = ROLE_OFF;
+		runtime_state->lcore_cfg[lcore_id].role = ROLE_OFF;
 		runtime_state->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
 		goto out;
@@ -453,14 +453,14 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 	struct lcore_callback *callback;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	if (runtime_state->lcore_role[lcore_id] != ROLE_NON_EAL)
+	if (runtime_state->lcore_cfg[lcore_id].role != ROLE_NON_EAL)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
 	rte_bitset_clear(runtime_state->core_indices,
 			runtime_state->lcore_cfg[lcore_id].core_index);
 	runtime_state->lcore_cfg[lcore_id].core_index = -1;
-	runtime_state->lcore_role[lcore_id] = ROLE_OFF;
+	runtime_state->lcore_cfg[lcore_id].role = ROLE_OFF;
 	runtime_state->lcore_count--;
 out:
 	rte_rwlock_write_unlock(&lcore_lock);
@@ -476,7 +476,7 @@ rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 
 	rte_rwlock_read_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == ROLE_OFF)
 			continue;
 		ret = cb(lcore_id, arg);
 		if (ret != 0)
@@ -541,7 +541,7 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 	cpuset = eal_cpuset_to_str(&runtime_state->lcore_cfg[lcore_id].cpuset);
 	fprintf(f, "lcore %u, socket %u, role %s, cpuset %s\n", lcore_id,
 		rte_lcore_to_socket_id(lcore_id),
-		lcore_role_str(runtime_state->lcore_role[lcore_id]),
+		lcore_role_str(runtime_state->lcore_cfg[lcore_id].role),
 		cpuset != NULL ? cpuset : "<unknown>");
 	free(cpuset);
 	free(usage_str);
@@ -608,7 +608,7 @@ lcore_telemetry_info_cb(unsigned int lcore_id, void *arg)
 	rte_tel_data_add_dict_int(info->d, "lcore_id", lcore_id);
 	rte_tel_data_add_dict_int(info->d, "socket", rte_lcore_to_socket_id(lcore_id));
 	rte_tel_data_add_dict_string(info->d, "role",
-			lcore_role_str(runtime_state->lcore_role[lcore_id]));
+			lcore_role_str(runtime_state->lcore_cfg[lcore_id].role));
 	cpuset = rte_tel_data_alloc();
 	if (cpuset == NULL)
 		return -ENOMEM;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 62c94e7704..05b6eb418b 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -907,10 +907,10 @@ eal_parse_service_coremask(const char *coremask)
 					return -1;
 				}
 
-				if (runtime_state->lcore_role[idx] == ROLE_RTE)
+				if (runtime_state->lcore_cfg[idx].role == ROLE_RTE)
 					taken_lcore_count++;
 
-				runtime_state->lcore_role[idx] = ROLE_SERVICE;
+				runtime_state->lcore_cfg[idx].role = ROLE_SERVICE;
 				count++;
 			}
 		}
@@ -946,7 +946,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 	/* set everything to disabled first, then set up values */
 	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		runtime_state->lcore_role[i] = ROLE_OFF;
+		runtime_state->lcore_cfg[i].role = ROLE_OFF;
 		runtime_state->lcore_cfg[i].core_index = -1;
 	}
 
@@ -975,7 +975,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 			}
 
 			rte_bitset_set(runtime_state->core_indices, count);
-			runtime_state->lcore_role[lcore_id] = ROLE_RTE;
+			runtime_state->lcore_cfg[lcore_id].role = ROLE_RTE;
 			runtime_state->lcore_cfg[lcore_id].core_index = count;
 			CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
 			CPU_SET(i, &runtime_state->lcore_cfg[lcore_id].cpuset);
@@ -1148,11 +1148,11 @@ eal_parse_service_corelist(const char *corelist)
 			if (min == RTE_MAX_LCORE)
 				min = idx;
 			for (idx = min; idx <= max; idx++) {
-				if (runtime_state->lcore_role[idx] != ROLE_SERVICE) {
-					if (runtime_state->lcore_role[idx] == ROLE_RTE)
+				if (runtime_state->lcore_cfg[idx].role != ROLE_SERVICE) {
+					if (runtime_state->lcore_cfg[idx].role == ROLE_RTE)
 						taken_lcore_count++;
 
-					runtime_state->lcore_role[idx] = ROLE_SERVICE;
+					runtime_state->lcore_cfg[idx].role = ROLE_SERVICE;
 					count++;
 				}
 			}
@@ -1175,7 +1175,7 @@ eal_parse_service_corelist(const char *corelist)
 	rte_cpuset_t service_cpuset;
 	CPU_ZERO(&service_cpuset);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (runtime_state->lcore_role[i] == ROLE_SERVICE)
+		if (runtime_state->lcore_cfg[i].role == ROLE_SERVICE)
 			CPU_SET(i, &service_cpuset);
 	}
 	if (CPU_COUNT(&service_cpuset) > 0) {
@@ -1205,12 +1205,12 @@ eal_parse_main_lcore(const char *arg)
 		return -1;
 
 	/* ensure main core is not used as service core */
-	if (runtime_state->lcore_role[cfg->main_lcore] == ROLE_SERVICE) {
+	if (runtime_state->lcore_cfg[cfg->main_lcore].role == ROLE_SERVICE) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
 	/* check that we have the core recorded in the core list */
-	if (runtime_state->lcore_role[cfg->main_lcore] != ROLE_RTE) {
+	if (runtime_state->lcore_cfg[cfg->main_lcore].role != ROLE_RTE) {
 		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
@@ -1400,7 +1400,7 @@ eal_parse_lcores(const char *lcores)
 	/* Reset lcore config */
 	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		runtime_state->lcore_role[idx] = ROLE_OFF;
+		runtime_state->lcore_cfg[idx].role = ROLE_OFF;
 		runtime_state->lcore_cfg[idx].core_index = -1;
 		CPU_ZERO(&runtime_state->lcore_cfg[idx].cpuset);
 		runtime_state->lcore_cfg[idx].first_cpu = UINT16_MAX;
@@ -1463,10 +1463,10 @@ eal_parse_lcores(const char *lcores)
 				continue;
 			set_count--;
 
-			if (runtime_state->lcore_role[idx] != ROLE_RTE) {
+			if (runtime_state->lcore_cfg[idx].role != ROLE_RTE) {
 				rte_bitset_set(runtime_state->core_indices, count);
 				runtime_state->lcore_cfg[idx].core_index = count;
-				runtime_state->lcore_role[idx] = ROLE_RTE;
+				runtime_state->lcore_cfg[idx].role = ROLE_RTE;
 				count++;
 			}
 
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 10ca417574..8f1f5ae507 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -123,6 +123,7 @@ struct eal_platform_info {
  */
 struct lcore_cfg {
 	int core_index;                   /**< relative index, starting from 0 */
+	enum rte_lcore_role_t role;       /**< role assigned to this lcore */
 	rte_cpuset_t cpuset;              /**< cpu set which the lcore affinity to */
 	uint16_t first_cpu;               /**< lowest CPU set in cpuset, UINT16_MAX if none */
 	/* Fields for executing code on a remote lcore */
@@ -147,7 +148,6 @@ struct eal_runtime_state {
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
-	enum rte_lcore_role_t lcore_role[RTE_MAX_LCORE]; /**< State of cores. */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
 };
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index 36ef2d32a7..e28e17f8d5 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -108,7 +108,7 @@ rte_service_init(void)
 	const struct rte_config *cfg = rte_eal_get_configuration();
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (runtime_state->lcore_role[i] == ROLE_SERVICE) {
+		if (runtime_state->lcore_cfg[i].role == ROLE_SERVICE) {
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
 	cs->is_service_core = (state == ROLE_SERVICE);
@@ -1124,7 +1124,7 @@ rte_service_dump(FILE *f, uint32_t id)
 
 	fprintf(f, "Service Cores Summary\n");
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (runtime_state->lcore_role[i] != ROLE_SERVICE)
+		if (runtime_state->lcore_cfg[i].role != ROLE_SERVICE)
 			continue;
 
 		service_dump_calls_per_lcore(f, i);
-- 
2.53.0

