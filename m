Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA22C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C965D40ED4;
	Tue, 18 Aug 2026 15:34:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 69CE940E37
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060054; x=1818596054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ix6liv+JbfioCK1THB+NdAJv9SDl/olWjALcQy0sZ2M=;
 b=PevkJFDJDthvz8wlawlEG2KVbe+NhFn/EdnprQnwzLaEBG6EQdzOHReQ
 MggZo7HnFIps0ehyF4lKFnAeT0pA74Dxey0yWwi2gVgNOnJUuXSRDi3HI
 pjzK68IJvGLl4/FJqGapGZd/IHL1MY8WOJe/8HqvqcNOa4zSs9f4bCwvv
 Y7T4qhQ4h+od749wmGqk0QCt560YZ8qWu1WHi/gs7230BO0rLY6MLB5BB
 lushdyga8AFKgx8aSW9TNGkGqit2T0YnDE/Sb1YclBJimEkjFhLdOIs83
 VZ6v3FlepJnJM0jX3G6lRVW0SEIJJ4+oz/PBn0AdixpJpIAtyxQNxNlgo w==;
X-CSE-ConnectionGUID: Eey5OfC/QKWPpVgTf1Z4QA==
X-CSE-MsgGUID: 1YpOLRLKTEao6bzAu81SkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757678"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757678"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:34:13 -0700
X-CSE-ConnectionGUID: DlOXAbQSRVu/Fh9Dm/6JDQ==
X-CSE-MsgGUID: xY25K+QdQoiwtsVlOMBgtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736762"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:34:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 30/39] eal: record service cores in user config struct
Date: Tue, 18 Aug 2026 14:33:23 +0100
Message-ID: <20260818133334.2620165-31-bruce.richardson@intel.com>
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

The user provided service coremask or service corelist needs to be
recorded in the user config struct, so store it there as a cpuset.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 157 ++++++++--------------------
 lib/eal/common/eal_internal_cfg.h   |   1 +
 2 files changed, 46 insertions(+), 112 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 132aca1557..31eff2c59d 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -545,6 +545,7 @@ eal_reset_internal_config(void)
 	user_cfg->user_mbuf_pool_ops_name = NULL;
 	CPU_ZERO(&runtime_state->ctrl_cpuset);
 	runtime_state->init_complete = 0;
+	CPU_ZERO(&user_cfg->service_cpuset);
 	user_cfg->max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH;
 	user_cfg->max_simd_bitwidth.forced = 0;
 }
@@ -852,21 +853,20 @@ static int xdigit2val(unsigned char c)
 }
 
 static int
-eal_parse_service_coremask(const char *coremask)
+eal_parse_service_coremask(const char *coremask, rte_cpuset_t *cpuset)
 {
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int i, j, idx = 0;
 	unsigned int count = 0;
 	char c;
 	int val;
-	uint32_t taken_lcore_count = 0;
 
 	EAL_LOG(WARNING, "'-s <service-coremask>' is deprecated, and will be removed in a future release.");
 	EAL_LOG(WARNING, "\tUse '-S <service-corelist>' option instead.");
 
 	if (coremask == NULL)
 		return -1;
-	/* Remove all blank characters ahead and after .
+	/* Remove all blank characters ahead and after.
 	 * Remove 0x/0X if exists.
 	 */
 	while (isblank(*coremask))
@@ -888,20 +888,9 @@ eal_parse_service_coremask(const char *coremask)
 			return -1;
 		}
 		val = xdigit2val(c);
-		for (j = 0; j < BITS_PER_HEX && idx < RTE_MAX_LCORE;
-				j++, idx++) {
+		for (j = 0; j < BITS_PER_HEX && idx < RTE_MAX_LCORE; j++, idx++) {
 			if ((1 << j) & val) {
-
-				if (eal_cpu_detected(idx) == 0) {
-					EAL_LOG(ERR,
-						"lcore %u unavailable", idx);
-					return -1;
-				}
-
-				if (runtime_state->lcore_cfg[idx].role == ROLE_RTE)
-					taken_lcore_count++;
-
-				runtime_state->lcore_cfg[idx].role = ROLE_SERVICE;
+				CPU_SET(idx, cpuset);
 				count++;
 			}
 		}
@@ -913,16 +902,15 @@ eal_parse_service_coremask(const char *coremask)
 
 	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
 
-	if (count == 0)
-		return -1;
-
-	if (taken_lcore_count != count) {
-		EAL_LOG(WARNING,
-			"Not all service cores are in the coremask. "
-			"Please ensure -c or -l includes service cores");
-	}
+	return count > 0 ? 0 : -1;
+}
 
-	return 0;
+static int
+eal_parse_service_corelist(const char *corelist, rte_cpuset_t *cpuset)
+{
+	if (rte_argparse_parse_type(corelist, RTE_ARGPARSE_VALUE_TYPE_CORELIST, cpuset) != 0)
+		return -1;
+	return CPU_COUNT(cpuset) > 0 ? 0 : -1;
 }
 
 static int
@@ -1097,89 +1085,6 @@ rte_eal_parse_coremask(const char *coremask, rte_cpuset_t *cpuset, bool limit_ra
 	return 0;
 }
 
-static int
-eal_parse_service_corelist(const char *corelist)
-{
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	int i;
-	unsigned count = 0;
-	char *end = NULL;
-	uint32_t min, max, idx;
-	uint32_t taken_lcore_count = 0;
-
-	if (corelist == NULL)
-		return -1;
-
-	/* Remove all blank characters ahead and after */
-	while (isblank(*corelist))
-		corelist++;
-	i = strlen(corelist);
-	while ((i > 0) && isblank(corelist[i - 1]))
-		i--;
-
-	/* Get list of cores */
-	min = RTE_MAX_LCORE;
-	do {
-		while (isblank(*corelist))
-			corelist++;
-		if (*corelist == '\0')
-			return -1;
-		errno = 0;
-		idx = strtoul(corelist, &end, 10);
-		if (errno || end == NULL)
-			return -1;
-		if (idx >= RTE_MAX_LCORE)
-			return -1;
-		while (isblank(*end))
-			end++;
-		if (*end == '-') {
-			min = idx;
-		} else if ((*end == ',') || (*end == '\0')) {
-			max = idx;
-			if (min == RTE_MAX_LCORE)
-				min = idx;
-			for (idx = min; idx <= max; idx++) {
-				if (runtime_state->lcore_cfg[idx].role != ROLE_SERVICE) {
-					if (runtime_state->lcore_cfg[idx].role == ROLE_RTE)
-						taken_lcore_count++;
-
-					runtime_state->lcore_cfg[idx].role = ROLE_SERVICE;
-					count++;
-				}
-			}
-			min = RTE_MAX_LCORE;
-		} else
-			return -1;
-		corelist = end + 1;
-	} while (*end != '\0');
-
-	if (count == 0)
-		return -1;
-
-	if (taken_lcore_count != count) {
-		EAL_LOG(WARNING,
-			"Not all service cores were in the coremask. "
-			"Please ensure -c or -l includes service cores");
-	}
-
-	/* log the configured service cores for debugging */
-	rte_cpuset_t service_cpuset;
-	CPU_ZERO(&service_cpuset);
-	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (runtime_state->lcore_cfg[i].role == ROLE_SERVICE)
-			CPU_SET(i, &service_cpuset);
-	}
-	if (CPU_COUNT(&service_cpuset) > 0) {
-		char *cpuset_str = eal_cpuset_to_str(&service_cpuset);
-		if (cpuset_str != NULL) {
-			EAL_LOG(DEBUG, "Service cores configured: %s", cpuset_str);
-			free(cpuset_str);
-		}
-	}
-
-	return 0;
-}
-
 /* Changes the lcore id of the main thread */
 static int
 eal_parse_main_lcore(const char *arg)
@@ -1196,8 +1101,8 @@ eal_parse_main_lcore(const char *arg)
 		return -1;
 	user_cfg->main_lcore = (int)main_lcore;
 
-	/* ensure main core is not used as service core */
-	if (runtime_state->lcore_cfg[user_cfg->main_lcore].role == ROLE_SERVICE) {
+	/* check main core is not already down as a service core */
+	if (CPU_ISSET(user_cfg->main_lcore, &user_cfg->service_cpuset)) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
@@ -2181,13 +2086,15 @@ eal_parse_args(void)
 
 	/* service core options */
 	if (args.service_coremask != NULL) {
-		if (eal_parse_service_coremask(args.service_coremask) < 0) {
+		if (eal_parse_service_coremask(args.service_coremask,
+				&user_cfg->service_cpuset) < 0) {
 			EAL_LOG(ERR, "invalid service coremask: '%s'",
 					args.service_coremask);
 			return -1;
 		}
 	} else if (args.service_corelist != NULL) {
-		if (eal_parse_service_corelist(args.service_corelist) < 0) {
+		if (eal_parse_service_corelist(args.service_corelist,
+				&user_cfg->service_cpuset) < 0) {
 			EAL_LOG(ERR, "invalid service core list: '%s'",
 					args.service_corelist);
 			return -1;
@@ -2517,6 +2424,32 @@ eal_apply_runtime_state(void)
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
+	/* Apply service core roles: service_cpuset bits are lcore IDs */
+	if (CPU_COUNT(&user_cfg->service_cpuset) > 0) {
+		unsigned int i;
+		char *cpuset_str;
+
+		for (i = 0; i < RTE_MAX_LCORE; i++) {
+			if (!CPU_ISSET(i, &user_cfg->service_cpuset))
+				continue;
+			if (eal_cpu_detected(i) == 0) {
+				EAL_LOG(ERR, "Requested service lcore %u unavailable", i);
+				return -1;
+			}
+			if (runtime_state->lcore_cfg[i].role != ROLE_RTE) {
+				EAL_LOG(WARNING,
+					"service lcore %u is not in the enabled lcore set; please ensure -c or -l includes service cores",
+					i);
+			}
+			runtime_state->lcore_cfg[i].role = ROLE_SERVICE;
+		}
+		cpuset_str = eal_cpuset_to_str(&user_cfg->service_cpuset);
+		if (cpuset_str != NULL) {
+			EAL_LOG(DEBUG, "Service cores configured: %s", cpuset_str);
+			free(cpuset_str);
+		}
+	}
+
 	/* set the main lcore */
 	if (user_cfg->main_lcore != -1) {
 		runtime_state->main_lcore = user_cfg->main_lcore;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index b8699f4804..2bce7ba662 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -137,6 +137,7 @@ struct eal_user_cfg {
 		uint64_t limit;    /**< memory limit in bytes */
 	} pagesz_mem_overrides[MAX_HUGEPAGE_SIZES];
 	unsigned int num_pagesz_mem_overrides;  /**< number of stored overrides */
+	rte_cpuset_t service_cpuset; /**<  each bit set is one lcore ID to use as service core */
 	int main_lcore;          /**< ID of the main lcore */
 };
 
-- 
2.53.0

