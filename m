Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC13C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 11:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27F37410DC;
	Thu, 13 Mar 2025 12:38:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2F77F40EF1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 12:38:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741865918; x=1773401918;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V4bhU4hlkbD7MeBq80bp59YPHFKowCDpzWlyYGqiRek=;
 b=cz2MKhKuO8m60AWxBFLdnSfoZfaA7aRObsJ0kthkGqAP8+c2TR806uB/
 M2gYCW2RLX4+rNmvt0DOOBDQ4f1bhuWCNkGdiixPfxq2iOdg/sNOTyaJT
 T8+y/muZCcmU/yphlb5uA/2JN4FeRPKvm3AtHYiZFQU3grbi5iQHnsCKz
 CXoy4QZ8sdJYzMU6vqrSQPzfH6Nsen5iGk1Y2vVr2o0QJ4fgH59GMGOuI
 XrcUDB3MedawGq4ynwanoJ7eszV9tAJgc0LIB8fs4Jp4pnoN31LUXjrEc
 G5Vuh2QCG5K9REo47IeQ9SuZusYJ6pxgB19c29+gJCghI0W0cf6qAxfuq g==;
X-CSE-ConnectionGUID: qwHwkFEMScK3jHWO6BIyXw==
X-CSE-MsgGUID: 4XC+9DlLSYi0icz2jRe0rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42145708"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="42145708"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 04:38:38 -0700
X-CSE-ConnectionGUID: RLoOQG3IRjy+qwuHCT08iQ==
X-CSE-MsgGUID: gsSpRjD3QieW5keL1Zos8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="120888952"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 04:38:36 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 2/3] eal: convert core masks and lists to core sets
Date: Thu, 13 Mar 2025 11:38:28 +0000
Message-ID: <20250313113829.1480907-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313113829.1480907-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
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

Rather than directly parsing and working with the core mask and core
list parameters, convert them into core maps, and centralise all core
parsing there. This allows future work to adjust the mappings of cores
when generating that mapping parameter.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
NOTE: this does change the behaviour of the internal API rte_eal_parse
core_mask, used by dlb driver. However, since this is an internal API
changing behaviour should be allowed AFAIK.
---
 drivers/event/dlb2/dlb2_priv.h             |   2 -
 drivers/event/dlb2/pf/base/dlb2_resource.c |  48 ++---
 lib/eal/common/eal_common_options.c        | 193 ++++-----------------
 3 files changed, 53 insertions(+), 190 deletions(-)

diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 52da31ed31..63c0bea155 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -737,8 +737,6 @@ void dlb2_event_build_hcws(struct dlb2_port *qm_port,
 			   uint8_t *sched_type,
 			   uint8_t *queue_id);
 
-/* Extern functions */
-extern int rte_eal_parse_coremask(const char *coremask, int *cores);
 
 /* Extern globals */
 extern struct process_local_port_data dlb2_port[][DLB2_NUM_PORT_TYPES];
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/dlb2/pf/base/dlb2_resource.c
index 3004902118..c4bc248afc 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.c
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
@@ -922,49 +922,31 @@ dlb2_resource_probe(struct dlb2_hw *hw, const void *probe_args)
 {
 	const struct dlb2_devargs *args = (const struct dlb2_devargs *)probe_args;
 	const char *mask = args ? args->producer_coremask : NULL;
-	int cpu = 0, cnt = 0, cores[RTE_MAX_LCORE], i;
+	int cpu = 0;
 
 	if (args) {
 		mask = (const char *)args->producer_coremask;
 	}
 
-	if (mask && rte_eal_parse_coremask(mask, cores)) {
-		DLB2_HW_ERR(hw, ": Invalid producer coremask=%s\n", mask);
-		return -1;
-	}
-
+	cpu = rte_get_next_lcore(-1, 1, 0);
 	hw->num_prod_cores = 0;
-	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		bool is_pcore = (mask && cores[i] != -1);
-
-		if (rte_lcore_is_enabled(i)) {
-			if (is_pcore) {
-				/*
-				 * Populate the producer cores from parsed
-				 * coremask
-				 */
-				hw->prod_core_list[cores[i]] = i;
-				hw->num_prod_cores++;
-
-			} else if ((++cnt == DLB2_EAL_PROBE_CORE ||
-			   rte_lcore_count() < DLB2_EAL_PROBE_CORE)) {
-				/*
-				 * If no producer coremask is provided, use the
-				 * second EAL core to probe
-				 */
-				cpu = i;
-				break;
-			}
-		} else if (is_pcore) {
-			DLB2_HW_ERR(hw, "Producer coremask(%s) must be a subset of EAL coremask\n",
-				     mask);
+	if (mask) {
+		int n = rte_eal_parse_coremask(mask, hw->prod_core_list);
+		if (n <= 0) {
+			DLB2_HW_ERR(hw, ": Invalid producer coremask=%s\n", mask);
 			return -1;
 		}
+		hw->num_prod_cores = n;
+		cpu = hw->prod_core_list[0];
 
+		for (u8 i = 0; i < hw->num_prod_cores; i++) {
+			if (!rte_lcore_is_enabled(hw->prod_core_list[i])) {
+				DLB2_HW_ERR(hw, "Producer coremask(%s) must be a subset of EAL coremask\n",
+					     mask);
+				return -1;
+			}
+		}
 	}
-	/* Use the first core in producer coremask to probe */
-	if (hw->num_prod_cores)
-		cpu = hw->prod_core_list[0];
 
 	dlb2_get_pp_allocation(hw, cpu, DLB2_LDB_PORT);
 	dlb2_get_pp_allocation(hw, cpu, DLB2_DIR_PORT);
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 55c49a923f..807ba760ce 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -690,33 +690,6 @@ eal_parse_service_coremask(const char *coremask)
 	return 0;
 }
 
-static int
-update_lcore_config(int *cores)
-{
-	struct rte_config *cfg = rte_eal_get_configuration();
-	unsigned int count = 0;
-	unsigned int i;
-	int ret = 0;
-
-	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (cores[i] != -1) {
-			if (eal_cpu_detected(i) == 0) {
-				EAL_LOG(ERR, "lcore %u unavailable", i);
-				ret = -1;
-				continue;
-			}
-			cfg->lcore_role[i] = ROLE_RTE;
-			count++;
-		} else {
-			cfg->lcore_role[i] = ROLE_OFF;
-		}
-		lcore_config[i].core_index = cores[i];
-	}
-	if (!ret)
-		cfg->lcore_count = count;
-	return ret;
-}
-
 static int
 check_core_list(int *lcores, unsigned int count)
 {
@@ -759,7 +732,6 @@ int
 rte_eal_parse_coremask(const char *coremask, int *cores)
 {
 	const char *coremask_orig = coremask;
-	int lcores[RTE_MAX_LCORE];
 	unsigned int count = 0;
 	int i, j, idx;
 	int val;
@@ -803,30 +775,19 @@ rte_eal_parse_coremask(const char *coremask, int *cores)
 						RTE_MAX_LCORE);
 					return -1;
 				}
-				lcores[count++] = idx;
+				cores[count++] = idx;
 			}
 		}
 	}
 	if (count == 0) {
-		EAL_LOG(ERR, "No lcores in coremask: [%s]",
-			coremask_orig);
+		EAL_LOG(ERR, "No lcores in coremask: [%s]", coremask_orig);
 		return -1;
 	}
 
-	if (check_core_list(lcores, count))
+	if (check_core_list(cores, count) != 0)
 		return -1;
 
-	/*
-	 * Now that we've got a list of cores no longer than RTE_MAX_LCORE,
-	 * and no lcore in that list is greater than RTE_MAX_LCORE, populate
-	 * the cores array.
-	 */
-	do {
-		count--;
-		cores[lcores[count]] = count;
-	} while (count != 0);
-
-	return 0;
+	return count;
 }
 
 static int
@@ -911,7 +872,6 @@ static int
 eal_parse_corelist(const char *corelist, int *cores)
 {
 	unsigned int count = 0, i;
-	int lcores[RTE_MAX_LCORE];
 	char *end = NULL;
 	int min, max;
 	int idx;
@@ -949,7 +909,7 @@ eal_parse_corelist(const char *corelist, int *cores)
 
 				/* Check if this idx is already present */
 				for (i = 0; i < count; i++) {
-					if (lcores[i] == idx)
+					if (cores[i] == idx)
 						dup = true;
 				}
 				if (dup)
@@ -959,7 +919,7 @@ eal_parse_corelist(const char *corelist, int *cores)
 						RTE_MAX_LCORE);
 					return -1;
 				}
-				lcores[count++] = idx;
+				cores[count++] = idx;
 			}
 			min = -1;
 		} else
@@ -967,23 +927,15 @@ eal_parse_corelist(const char *corelist, int *cores)
 		corelist = end + 1;
 	} while (*end != '\0');
 
-	if (count == 0)
+	if (count == 0) {
+		EAL_LOG(ERR, "No lcores in corelist");
 		return -1;
+	}
 
-	if (check_core_list(lcores, count))
+	if (check_core_list(cores, count))
 		return -1;
 
-	/*
-	 * Now that we've got a list of cores no longer than RTE_MAX_LCORE,
-	 * and no lcore in that list is greater than RTE_MAX_LCORE, populate
-	 * the cores array.
-	 */
-	do {
-		count--;
-		cores[lcores[count]] = count;
-	} while (count != 0);
-
-	return 0;
+	return count;
 }
 
 /* Changes the lcore id of the main thread */
@@ -1500,75 +1452,6 @@ eal_parse_base_virtaddr(const char *arg)
 	return 0;
 }
 
-/* caller is responsible for freeing the returned string */
-static char *
-available_cores(void)
-{
-	char *str = NULL;
-	int previous;
-	int sequence;
-	char *tmp;
-	int idx;
-
-	/* find the first available cpu */
-	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		if (eal_cpu_detected(idx) == 0)
-			continue;
-		break;
-	}
-	if (idx >= RTE_MAX_LCORE)
-		return NULL;
-
-	/* first sequence */
-	if (asprintf(&str, "%d", idx) < 0)
-		return NULL;
-	previous = idx;
-	sequence = 0;
-
-	for (idx++ ; idx < RTE_MAX_LCORE; idx++) {
-		if (eal_cpu_detected(idx) == 0)
-			continue;
-
-		if (idx == previous + 1) {
-			previous = idx;
-			sequence = 1;
-			continue;
-		}
-
-		/* finish current sequence */
-		if (sequence) {
-			if (asprintf(&tmp, "%s-%d", str, previous) < 0) {
-				free(str);
-				return NULL;
-			}
-			free(str);
-			str = tmp;
-		}
-
-		/* new sequence */
-		if (asprintf(&tmp, "%s,%d", str, idx) < 0) {
-			free(str);
-			return NULL;
-		}
-		free(str);
-		str = tmp;
-		previous = idx;
-		sequence = 0;
-	}
-
-	/* finish last sequence */
-	if (sequence) {
-		if (asprintf(&tmp, "%s-%d", str, previous) < 0) {
-			free(str);
-			return NULL;
-		}
-		free(str);
-		str = tmp;
-	}
-
-	return str;
-}
-
 #define HUGE_UNLINK_NEVER "never"
 
 static int
@@ -1981,43 +1864,43 @@ eal_adjust_config(struct internal_config *internal_cfg)
 		return -1;
 	}
 
-	if (lcore_options.core_mask_opt) {
-		int lcore_indexes[RTE_MAX_LCORE];
-
-		if (rte_eal_parse_coremask(lcore_options.core_mask_opt, lcore_indexes) < 0) {
-			EAL_LOG(ERR, "invalid coremask syntax");
-			return -1;
-		}
-		if (update_lcore_config(lcore_indexes) < 0) {
-			char *available = available_cores();
 
-			EAL_LOG(ERR,
-				"invalid coremask, please check specified cores are part of %s",
-				available);
-			free(available);
-			return -1;
-		}
-	} else if (lcore_options.core_list_opt) {
+	if (lcore_options.core_mask_opt || lcore_options.core_list_opt) {
 		int lcore_indexes[RTE_MAX_LCORE];
+		int nb_indexes = lcore_options.core_list_opt ?
+				eal_parse_corelist(lcore_options.core_list_opt, lcore_indexes) :
+				rte_eal_parse_coremask(lcore_options.core_mask_opt, lcore_indexes);
 
-		if (eal_parse_corelist(lcore_options.core_list_opt, lcore_indexes) < 0) {
-			EAL_LOG(ERR, "invalid core list syntax");
+		if (nb_indexes < 0)
 			return -1;
-		}
-		if (update_lcore_config(lcore_indexes) < 0) {
-			char *available = available_cores();
 
-			EAL_LOG(ERR,
-				"invalid core list, please check specified cores are part of %s",
-				available);
-			free(available);
-			return -1;
+		char *core_map_opt = malloc(RTE_MAX_LCORE * 10);
+		size_t core_map_len = 0;
+		for (i = 0; i < nb_indexes; i++) {
+			if (!eal_cpu_detected(lcore_indexes[i])) {
+				EAL_LOG(ERR, "core %d not present", lcore_indexes[i]);
+				return -1;
+			}
+			int n = snprintf(core_map_opt + core_map_len,
+					(RTE_MAX_LCORE * 10) - core_map_len,
+					"%s%d", i == 0 ? "" : ",", lcore_indexes[i]);
+			if (n < 0 || (size_t)n >= (RTE_MAX_LCORE * 10) - core_map_len) {
+				EAL_LOG(ERR, "core map string too long");
+				return -1;
+			}
+			core_map_len += n;
 		}
-	} else if (lcore_options.core_map_opt) {
+		lcore_options.core_map_opt = core_map_opt;
+		printf("Generated core map: %s\n", lcore_options.core_map_opt);
+	}
+
+	if (lcore_options.core_map_opt) {
 		if (eal_parse_lcores(lcore_options.core_map_opt) < 0) {
 			EAL_LOG(ERR, "invalid parameter for --"	OPT_LCORES);
 			return -1;
 		}
+		if (lcore_options.core_mask_opt || lcore_options.core_list_opt)
+			free(RTE_CAST_PTR(void *,lcore_options.core_map_opt));
 	} else {
 		eal_auto_detect_cores(cfg);
 	}
-- 
2.43.0

