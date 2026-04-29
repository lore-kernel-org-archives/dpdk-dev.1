Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D78BCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:01:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A37CB40DD6;
	Wed, 29 Apr 2026 18:59:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 59A4740E30;
 Wed, 29 Apr 2026 18:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481958; x=1809017958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Uyb3dHVpeMu3aie0OauSeaFAH5/Ch5HawpjmLJoGYI0=;
 b=am+JbdpgCVCqrTyqdz29xux7m1ULkNt5C+YFBYesTfgOKx/frDQbQoJ0
 xc3p3l1J/M7xnp770lwL3cdAdyIn67lOGaAO6JQCgHkqaSSzrss9UGhKJ
 flYV0n//VnoPmuALzpGwPRkIC4oCSbVLQUlw5gT5E5goHKo4IbJyUlG6S
 EsRFDtyR5Zggl1gdSEhZ/gLFDac1X2WN8PDhKIq3BF+zceq4fBeOImKWn
 R57eKlD4QTJsWr9miwxfiwnQBX18Q//o6DEBFhI4hK+ytgXinWll42dlH
 UutxrtwSCZY8eZlMNWBeq4fWpNVi77sHoRhzRC+kftHAx3i/STWzM4rz5 Q==;
X-CSE-ConnectionGUID: qF4C2UydS0ifdH6bdZSu6Q==
X-CSE-MsgGUID: L6krXjjXQQOGpC6akqJ33w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725323"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725323"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:17 -0700
X-CSE-ConnectionGUID: s6AF0+9DTWSE4iXegh2SRQ==
X-CSE-MsgGUID: rHsUkEvjQ0OoFLx8eyY75Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696985"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 17/44] eal: make lcore role a field in lcore config struct
Date: Wed, 29 Apr 2026 17:58:09 +0100
Message-ID: <20260429165845.2136843-18-bruce.richardson@intel.com>
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
index 457c4c91a0..1ec1dc080a 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -88,7 +88,7 @@ rte_eal_lcore_role(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return ROLE_OFF;
-	return runtime_state->lcore_role[lcore_id];
+	return runtime_state->lcore_cfg[lcore_id].role;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_has_role)
@@ -100,7 +100,7 @@ rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
 
-	return runtime_state->lcore_role[lcore_id] == role;
+	return runtime_state->lcore_cfg[lcore_id].role == role;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_is_enabled)
@@ -110,7 +110,7 @@ int rte_lcore_is_enabled(unsigned int lcore_id)
 
 	if (lcore_id >= RTE_MAX_LCORE)
 		return 0;
-	return runtime_state->lcore_role[lcore_id] == ROLE_RTE;
+	return runtime_state->lcore_cfg[lcore_id].role == ROLE_RTE;
 }
 
 RTE_EXPORT_SYMBOL(rte_get_next_lcore)
@@ -322,7 +322,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 	if (callback->init == NULL)
 		goto no_init;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == ROLE_OFF)
 			continue;
 		if (callback_init(callback, lcore_id) == 0)
 			continue;
@@ -330,7 +330,7 @@ rte_lcore_callback_register(const char *name, rte_lcore_init_cb init,
 		 * previous lcore.
 		 */
 		while (lcore_id-- != 0) {
-			if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
+			if (runtime_state->lcore_cfg[lcore_id].role == ROLE_OFF)
 				continue;
 			callback_uninit(callback, lcore_id);
 		}
@@ -362,7 +362,7 @@ rte_lcore_callback_unregister(void *handle)
 	if (callback->uninit == NULL)
 		goto no_uninit;
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == ROLE_OFF)
 			continue;
 		callback_uninit(callback, lcore_id);
 	}
@@ -384,9 +384,9 @@ eal_lcore_non_eal_allocate(void)
 
 	rte_rwlock_write_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] != ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role != ROLE_OFF)
 			continue;
-		runtime_state->lcore_role[lcore_id] = ROLE_NON_EAL;
+		runtime_state->lcore_cfg[lcore_id].role = ROLE_NON_EAL;
 		runtime_state->lcore_count++;
 		break;
 	}
@@ -407,7 +407,7 @@ eal_lcore_non_eal_allocate(void)
 		}
 		EAL_LOG(DEBUG, "Initialization refused for lcore %u.",
 			lcore_id);
-		runtime_state->lcore_role[lcore_id] = ROLE_OFF;
+		runtime_state->lcore_cfg[lcore_id].role = ROLE_OFF;
 		runtime_state->lcore_count--;
 		lcore_id = RTE_MAX_LCORE;
 		goto out;
@@ -424,11 +424,11 @@ eal_lcore_non_eal_release(unsigned int lcore_id)
 	struct lcore_callback *callback;
 
 	rte_rwlock_write_lock(&lcore_lock);
-	if (runtime_state->lcore_role[lcore_id] != ROLE_NON_EAL)
+	if (runtime_state->lcore_cfg[lcore_id].role != ROLE_NON_EAL)
 		goto out;
 	TAILQ_FOREACH(callback, &lcore_callbacks, next)
 		callback_uninit(callback, lcore_id);
-	runtime_state->lcore_role[lcore_id] = ROLE_OFF;
+	runtime_state->lcore_cfg[lcore_id].role = ROLE_OFF;
 	runtime_state->lcore_count--;
 out:
 	rte_rwlock_write_unlock(&lcore_lock);
@@ -444,7 +444,7 @@ rte_lcore_iterate(rte_lcore_iterate_cb cb, void *arg)
 
 	rte_rwlock_read_lock(&lcore_lock);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (runtime_state->lcore_role[lcore_id] == ROLE_OFF)
+		if (runtime_state->lcore_cfg[lcore_id].role == ROLE_OFF)
 			continue;
 		ret = cb(lcore_id, arg);
 		if (ret != 0)
@@ -509,7 +509,7 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 	cpuset = eal_cpuset_to_str(&runtime_state->lcore_cfg[lcore_id].cpuset);
 	fprintf(f, "lcore %u, socket %u, role %s, cpuset %s\n", lcore_id,
 		rte_lcore_to_socket_id(lcore_id),
-		lcore_role_str(runtime_state->lcore_role[lcore_id]),
+		lcore_role_str(runtime_state->lcore_cfg[lcore_id].role),
 		cpuset != NULL ? cpuset : "<unknown>");
 	free(cpuset);
 	free(usage_str);
@@ -575,7 +575,7 @@ lcore_telemetry_info_cb(unsigned int lcore_id, void *arg)
 	rte_tel_data_start_dict(info->d);
 	rte_tel_data_add_dict_int(info->d, "lcore_id", lcore_id);
 	rte_tel_data_add_dict_int(info->d, "socket", rte_lcore_to_socket_id(lcore_id));
-	rte_tel_data_add_dict_string(info->d, "role", lcore_role_str(runtime_state->lcore_role[lcore_id]));
+	rte_tel_data_add_dict_string(info->d, "role", lcore_role_str(runtime_state->lcore_cfg[lcore_id].role));
 	cpuset = rte_tel_data_alloc();
 	if (cpuset == NULL)
 		return -ENOMEM;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 3535e467c6..83e0d986a5 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -885,10 +885,10 @@ eal_parse_service_coremask(const char *coremask)
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
@@ -921,7 +921,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 
 	/* set everything to disabled first, then set up values */
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		runtime_state->lcore_role[i] = ROLE_OFF;
+		runtime_state->lcore_cfg[i].role = ROLE_OFF;
 		runtime_state->lcore_cfg[i].core_index = -1;
 	}
 
@@ -949,7 +949,7 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				continue;
 			}
 
-			runtime_state->lcore_role[lcore_id] = ROLE_RTE;
+			runtime_state->lcore_cfg[lcore_id].role = ROLE_RTE;
 			runtime_state->lcore_cfg[lcore_id].core_index = count;
 			CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
 			CPU_SET(i, &runtime_state->lcore_cfg[lcore_id].cpuset);
@@ -1122,11 +1122,11 @@ eal_parse_service_corelist(const char *corelist)
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
@@ -1149,7 +1149,7 @@ eal_parse_service_corelist(const char *corelist)
 	rte_cpuset_t service_cpuset;
 	CPU_ZERO(&service_cpuset);
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (runtime_state->lcore_role[i] == ROLE_SERVICE)
+		if (runtime_state->lcore_cfg[i].role == ROLE_SERVICE)
 			CPU_SET(i, &service_cpuset);
 	}
 	if (CPU_COUNT(&service_cpuset) > 0) {
@@ -1179,12 +1179,12 @@ eal_parse_main_lcore(const char *arg)
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
@@ -1373,7 +1373,7 @@ eal_parse_lcores(const char *lcores)
 
 	/* Reset lcore config */
 	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		runtime_state->lcore_role[idx] = ROLE_OFF;
+		runtime_state->lcore_cfg[idx].role = ROLE_OFF;
 		runtime_state->lcore_cfg[idx].core_index = -1;
 		CPU_ZERO(&runtime_state->lcore_cfg[idx].cpuset);
 		runtime_state->lcore_cfg[idx].first_cpu = UINT16_MAX;
@@ -1436,9 +1436,9 @@ eal_parse_lcores(const char *lcores)
 				continue;
 			set_count--;
 
-			if (runtime_state->lcore_role[idx] != ROLE_RTE) {
+			if (runtime_state->lcore_cfg[idx].role != ROLE_RTE) {
 				runtime_state->lcore_cfg[idx].core_index = count;
-				runtime_state->lcore_role[idx] = ROLE_RTE;
+				runtime_state->lcore_cfg[idx].role = ROLE_RTE;
 				count++;
 			}
 
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index d46d3f59d3..41a1437435 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -116,6 +116,7 @@ struct eal_platform_info {
  */
 struct lcore_cfg {
 	int core_index;                   /**< relative index, starting from 0 */
+	enum rte_lcore_role_t role;       /**< role assigned to this lcore */
 	rte_cpuset_t cpuset;              /**< cpu set which the lcore affinity to */
 	uint16_t first_cpu;               /**< lowest CPU set in cpuset, UINT16_MAX if none */
 	/* Fields for executing code on a remote lcore */
@@ -138,7 +139,6 @@ struct eal_runtime_state {
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
-	enum rte_lcore_role_t lcore_role[RTE_MAX_LCORE]; /**< State of cores. */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
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
2.51.0

