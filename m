Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295DDCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:01:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58C4340E34;
	Wed, 29 Apr 2026 18:59:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5822F40E1F;
 Wed, 29 Apr 2026 18:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481956; x=1809017956;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t5wH12LSbonArc9P7JzNk5mzVXwNa0HI2YjkKpZsBmo=;
 b=R6h4/r2qSXgF+SXlBKounZIGhAG3b/BP/7XysQayaqM2m6XbzOHqsX3a
 a6qvoFIEdZELwLG/Y9J/lEEgyt9U4UHTYClVI3z0LgpBRujFl0qwtkmR+
 TmodbNGxFOerNq/ySLdLUBaU4T4mmBhW2UC6GOwRackHz5TIn3jt3DAEi
 2qavuG9YxsOfcHW6DuR84itpzHHz5ICf1SyqksisfoL2jpjCDfEDhXMY3
 HaBJ7fnF5EJbIdnJqV3df/fxdE3Z1H3KIsakch/DW8CVZJRDA4skW0tnP
 lHfMTMTafcXZ+GJcp/z11dwrGCJiigDliRorfT0p5i5sVqbiNYCbQPWfq w==;
X-CSE-ConnectionGUID: U73HGgJ5T9Cvzils1Z7U5w==
X-CSE-MsgGUID: 216I5o/kQfqMhzZUQL/CLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725320"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:16 -0700
X-CSE-ConnectionGUID: Agy+JiEBQ0WL8iq97guQ2Q==
X-CSE-MsgGUID: 9nVmLeMsQfii2eW/nJDBzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696981"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 16/44] eal: move lcore role and count to runtime state
Date: Wed, 29 Apr 2026 17:58:08 +0100
Message-ID: <20260429165845.2136843-17-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

Move the lcore role and lcore count values from rte_config struct to the
runtime state struct. Update all call sites. The service_lcore_count
value was set but never actually used, so just remove it from rte_config
rather than moving it to the new structure.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c   | 54 ++++++++++++++---------------
 lib/eal/common/eal_common_options.c | 38 ++++++++++----------
 lib/eal/common/eal_internal_cfg.h   |  2 ++
 lib/eal/common/eal_private.h        |  3 --
 lib/eal/common/rte_service.c        | 14 ++++----
 5 files changed, 53 insertions(+), 58 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 01cbaf572b..457c4c91a0 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -28,7 +28,7 @@ unsigned int rte_get_main_lcore(void)
 RTE_EXPORT_SYMBOL(rte_lcore_count)
 unsigned int rte_lcore_count(void)
 {
-	return rte_eal_get_configuration()->lcore_count;
+	return eal_get_runtime_state()->lcore_count;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_index)
@@ -84,33 +84,33 @@ RTE_EXPORT_SYMBOL(rte_eal_lcore_role)
 enum rte_lcore_role_t
 rte_eal_lcore_role(unsigned int lcore_id)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return ROLE_OFF;
-	return cfg->lcore_role[lcore_id];
+	return runtime_state->lcore_role[lcore_id];
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_has_role)
 int
 rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
 
-	return cfg->lcore_role[lcore_id] == role;
+	return runtime_state->lcore_role[lcore_id] == role;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_is_enabled)
 int rte_lcore_is_enabled(unsigned int lcore_id)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
-	return cfg->lcore_role[lcore_id] == ROLE_RTE;
+	return runtime_state->lcore_role[lcore_id] == ROLE_RTE;
 }
 
 RTE_EXPORT_SYMBOL(rte_get_next_lcore)
@@ -302,7 +302,7 @@ void *
 rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	rte_lcore_uninit_cb uninit, void *arg)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct lcore_callback *callback;
 	unsigned int lcore_id;
 
@@ -322,7 +322,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	if (callback->init == NULL)
 		goto no_init;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
 			continue;
 		if (callback_init(callback, lcore_id) == 0)
 			continue;
@@ -330,7 +330,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 		 * previous lcore.
 		 */
 		while (lcore_id-- != 0) {
-			if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+			if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
 				continue;
 			callback_uninit(callback, lcore_id);
 		}
@@ -352,7 +352,7 @@ RTE_EXPORT_SYMBOL(rte_lcore_callback_unregister)
 void
 rte_lcore_callback_unregister(void *handle)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct lcore_callback *callback = handle;
 	unsigned int lcore_id;
 
@@ -362,7 +362,7 @@ rte_lcore_callback_unregister(void *handle)
 	if (callback->uninit == NULL)
 		goto no_uninit;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
 			continue;
 		callback_uninit(callback, lcore_id);
 	}
@@ -377,17 +377,17 @@ rte_lcore_callback_unregister(void *handle)
 unsigned int
 eal_lcore_non_eal_allocate(void)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct lcore_callback *callback;
 	struct lcore_callback *prev;
 	unsigned int lcore_id;
 
 	rte_rwlock_write_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] != ROLE_OFF)
+		if (runtime_state->lcore_role[lcore_id] != ROLE_OFF)
 			continue;
-		cfg->lcore_role[lcore_id] = ROLE_NON_EAL;
-		cfg->lcore_count++;
+		runtime_state->lcore_role[lcore_id] = ROLE_NON_EAL;
+		runtime_state->lcore_count++;
 		break;
 	}
 	if (lcore_id == RTE_MAX_LCORE) {
@@ -407,8 +407,8 @@ eal_lcore_non_eal_allocate(void)
 		}
 		EAL_LOG(DEBUG, "Initialization refused for lcore %u.",
 			lcore_id);
-		cfg->lcore_role[lcore_id] = ROLE_OFF;
-		cfg->lcore_count--;
+		runtime_state->lcore_role[lcore_id] = ROLE_OFF;
+		runtime_state->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
 		goto out;
 	}
@@ -420,16 +420,16 @@ eal_lcore_non_eal_allocate(void)
 void
 eal_lcore_non_eal_release(unsigned int lcore_id)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct lcore_callback *callback;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	if (cfg->lcore_role[lcore_id] != ROLE_NON_EAL)
+	if (runtime_state->lcore_role[lcore_id] != ROLE_NON_EAL)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
-	cfg->lcore_role[lcore_id] = ROLE_OFF;
-	cfg->lcore_count--;
+	runtime_state->lcore_role[lcore_id] = ROLE_OFF;
+	runtime_state->lcore_count--;
 out:
 	rte_rwlock_write_unlock(&lcore_lock);
 }
@@ -438,13 +438,13 @@ RTE_EXPORT_SYMBOL(rte_lcore_iterate)
 int
 rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int lcore_id;
 	int ret = 0;
 
 	rte_rwlock_read_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
 			continue;
 		ret = cb(lcore_id, arg);
 		if (ret != 0)
@@ -489,7 +489,6 @@ static int
 lcore_dump_cb(unsigned int lcore_id, void *arg)
 {
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	struct rte_config *cfg = rte_eal_get_configuration();
 	char *cpuset;
 	struct rte_lcore_usage usage;
 	rte_lcore_usage_cb usage_cb;
@@ -510,7 +509,7 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 	cpuset = eal_cpuset_to_str(&runtime_state->lcore_cfg[lcore_id].cpuset);
 	fprintf(f, "lcore %u, socket %u, role %s, cpuset %s\n", lcore_id,
 		rte_lcore_to_socket_id(lcore_id),
-		lcore_role_str(cfg->lcore_role[lcore_id]),
+		lcore_role_str(runtime_state->lcore_role[lcore_id]),
 		cpuset != NULL ? cpuset : "<unknown>");
 	free(cpuset);
 	free(usage_str);
@@ -563,7 +562,6 @@ static int
 lcore_telemetry_info_cb(unsigned int lcore_id, void *arg)
 {
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	struct rte_config *cfg = rte_eal_get_configuration();
 	struct lcore_telemetry_info *info = arg;
 	char ratio_str[RTE_TEL_MAX_STRING_LEN];
 	struct rte_lcore_usage usage;
@@ -577,7 +575,7 @@ lcore_telemetry_info_cb(unsigned int lcore_id, void *arg)
 	rte_tel_data_start_dict(info->d);
 	rte_tel_data_add_dict_int(info->d, "lcore_id", lcore_id);
 	rte_tel_data_add_dict_int(info->d, "socket", rte_lcore_to_socket_id(lcore_id));
-	rte_tel_data_add_dict_string(info->d, "role", lcore_role_str(cfg->lcore_role[lcore_id]));
+	rte_tel_data_add_dict_string(info->d, "role", lcore_role_str(runtime_state->lcore_role[lcore_id]));
 	cpuset = rte_tel_data_alloc();
 	if (cpuset == NULL)
 		return -ENOMEM;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 02c40e5ce1..3535e467c6 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -841,7 +841,7 @@ static int xdigit2val(unsigned char c)
 static int
 eal_parse_service_coremask(const char *coremask)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int i, j, idx = 0;
 	unsigned int count = 0;
 	char c;
@@ -885,10 +885,10 @@ eal_parse_service_coremask(const char *coremask)
 					return -1;
 				}
 
-				if (cfg->lcore_role[idx] == ROLE_RTE)
+				if (runtime_state->lcore_role[idx] == ROLE_RTE)
 					taken_lcore_count++;
 
-				cfg->lcore_role[idx] = ROLE_SERVICE;
+				runtime_state->lcore_role[idx] = ROLE_SERVICE;
 				count++;
 			}
 		}
@@ -907,14 +907,12 @@ eal_parse_service_coremask(const char *coremask)
 			"Please ensure -c or -l includes service cores");
 	}
 
-	cfg->service_lcore_count = count;
 	return 0;
 }
 
 static int
 update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int lcore_id = remap_base;
 	unsigned int count = 0;
@@ -923,7 +921,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 
 	/* set everything to disabled first, then set up values */
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		cfg->lcore_role[i] = ROLE_OFF;
+		runtime_state->lcore_role[i] = ROLE_OFF;
 		runtime_state->lcore_cfg[i].core_index = -1;
 	}
 
@@ -951,7 +949,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				continue;
 			}
 
-			cfg->lcore_role[lcore_id] = ROLE_RTE;
+			runtime_state->lcore_role[lcore_id] = ROLE_RTE;
 			runtime_state->lcore_cfg[lcore_id].core_index = count;
 			CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
 			CPU_SET(i, &runtime_state->lcore_cfg[lcore_id].cpuset);
@@ -966,7 +964,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 		ret = -1;
 	}
 	if (!ret)
-		cfg->lcore_count = count;
+		runtime_state->lcore_count = count;
 	return ret;
 }
 
@@ -1085,7 +1083,7 @@ rte_eal_parse_coremask(const char *coremask, rte_cpuset_t *cpuset, bool limit_ra
 static int
 eal_parse_service_corelist(const char *corelist)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int i;
 	unsigned count = 0;
 	char *end = NULL;
@@ -1124,11 +1122,11 @@ eal_parse_service_corelist(const char *corelist)
 			if (min == RTE_MAX_LCORE)
 				min = idx;
 			for (idx = min; idx <= max; idx++) {
-				if (cfg->lcore_role[idx] != ROLE_SERVICE) {
-					if (cfg->lcore_role[idx] == ROLE_RTE)
+				if (runtime_state->lcore_role[idx] != ROLE_SERVICE) {
+					if (runtime_state->lcore_role[idx] == ROLE_RTE)
 						taken_lcore_count++;
 
-					cfg->lcore_role[idx] = ROLE_SERVICE;
+					runtime_state->lcore_role[idx] = ROLE_SERVICE;
 					count++;
 				}
 			}
@@ -1151,7 +1149,7 @@ eal_parse_service_corelist(const char *corelist)
 	rte_cpuset_t service_cpuset;
 	CPU_ZERO(&service_cpuset);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (cfg->lcore_role[i] == ROLE_SERVICE)
+		if (runtime_state->lcore_role[i] == ROLE_SERVICE)
 			CPU_SET(i, &service_cpuset);
 	}
 	if (CPU_COUNT(&service_cpuset) > 0) {
@@ -1171,6 +1169,7 @@ eal_parse_main_lcore(const char *arg)
 {
 	char *parsing_end;
 	struct rte_config *cfg = rte_eal_get_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	errno = 0;
 	cfg->main_lcore = (uint32_t) strtol(arg, &parsing_end, 0);
@@ -1180,12 +1179,12 @@ eal_parse_main_lcore(const char *arg)
 		return -1;
 
 	/* ensure main core is not used as service core */
-	if (cfg->lcore_role[cfg->main_lcore] == ROLE_SERVICE) {
+	if (runtime_state->lcore_role[cfg->main_lcore] == ROLE_SERVICE) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
 	/* check that we have the core recorded in the core list */
-	if (cfg->lcore_role[cfg->main_lcore] != ROLE_RTE) {
+	if (runtime_state->lcore_role[cfg->main_lcore] != ROLE_RTE) {
 		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
@@ -1351,7 +1350,6 @@ check_cpuset(rte_cpuset_t *set)
 static int
 eal_parse_lcores(const char *lcores)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	rte_cpuset_t lcore_set;
 	unsigned int set_count;
@@ -1375,7 +1373,7 @@ eal_parse_lcores(const char *lcores)
 
 	/* Reset lcore config */
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		cfg->lcore_role[idx] = ROLE_OFF;
+		runtime_state->lcore_role[idx] = ROLE_OFF;
 		runtime_state->lcore_cfg[idx].core_index = -1;
 		CPU_ZERO(&runtime_state->lcore_cfg[idx].cpuset);
 		runtime_state->lcore_cfg[idx].first_cpu = UINT16_MAX;
@@ -1438,9 +1436,9 @@ eal_parse_lcores(const char *lcores)
 				continue;
 			set_count--;
 
-			if (cfg->lcore_role[idx] != ROLE_RTE) {
+			if (runtime_state->lcore_role[idx] != ROLE_RTE) {
 				runtime_state->lcore_cfg[idx].core_index = count;
-				cfg->lcore_role[idx] = ROLE_RTE;
+				runtime_state->lcore_role[idx] = ROLE_RTE;
 				count++;
 			}
 
@@ -1467,7 +1465,7 @@ eal_parse_lcores(const char *lcores)
 	if (count == 0)
 		goto err;
 
-	cfg->lcore_count = count;
+	runtime_state->lcore_count = count;
 	ret = 0;
 
 err:
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 17e96ab634..d46d3f59d3 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -137,6 +137,8 @@ struct eal_runtime_state {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
+	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
+	enum rte_lcore_role_t lcore_role[RTE_MAX_LCORE]; /**< State of cores. */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 };
 
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 86500cbc5b..80fa49ce8b 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -22,9 +22,6 @@
  */
 struct rte_config {
 	uint32_t main_lcore;         /**< Id of the main lcore */
-	uint32_t lcore_count;        /**< Number of available logical cores. */
-	uint32_t service_lcore_count;/**< Number of available service cores. */
-	enum rte_lcore_role_t lcore_role[RTE_MAX_LCORE]; /**< State of cores. */
 
 	/** Primary or secondary configuration */
 	enum rte_proc_type_t process_type;
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index dbf4fe153b..36ef2d32a7 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -105,9 +105,10 @@ rte_service_init(void)
 		RTE_LCORE_VAR_ALLOC(lcore_states);
 
 	int i;
-	struct rte_config *cfg = rte_eal_get_configuration();
+	const struct rte_config *cfg = rte_eal_get_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (cfg->lcore_role[i] == ROLE_SERVICE) {
+		if (runtime_state->lcore_role[i] == ROLE_SERVICE) {
 			if ((unsigned int)i == cfg->main_lcore)
 				continue;
 			rte_service_lcore_add(i);
@@ -709,10 +710,9 @@ rte_service_map_lcore_get(uint32_t id, uint32_t lcore)
 static void
 set_lcore_state(uint32_t lcore, int32_t state)
 {
-	/* mark core state in hugepage backed config */
-	struct rte_config *cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct core_state *cs =	RTE_LCORE_VAR_LCORE(lcore, lcore_states);
-	cfg->lcore_role[lcore] = state;
+	runtime_state->lcore_role[lcore] = state;
 
 	/* update per-lcore optimized state tracking */
 	cs->is_service_core = (state == ROLE_SERVICE);
@@ -1101,7 +1101,7 @@ RTE_EXPORT_SYMBOL(rte_service_dump)
 int32_t
 rte_service_dump(FILE *f, uint32_t id)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	uint32_t i;
 	int print_one = (id != UINT32_MAX);
 
@@ -1124,7 +1124,7 @@ rte_service_dump(FILE *f, uint32_t id)
 
 	fprintf(f, "Service Cores Summary\n");
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (cfg->lcore_role[i] != ROLE_SERVICE)
+		if (runtime_state->lcore_role[i] != ROLE_SERVICE)
 			continue;
 
 		service_dump_calls_per_lcore(f, i);
-- 
2.51.0

