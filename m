Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E578CCA470
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D50FA40C35;
	Fri,  3 Oct 2025 10:15:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 312CF40A6C
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479332; x=1791015332;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8PPpVrRT6Rfl0doq+wirc1RMfIxWQ0h7/F9sI/bBIFA=;
 b=LaZ52KVfYJB3OlDU1WvKkM3p14tINQTyXq+IH92hcCxQN2DRD45bskA0
 FE+VdoSTBjlcoCIBY7DQG4tnkWqYYkZgss2N30tgKFRUEd7ySYuqO0Dn8
 QNfO+CpwUSgKLssfm0Yzw6T4fpjFpu/V/+byUcaPHF6FEGdSbgfb1M6HS
 OCXkFDhwqkSqBdTmrDoZHls4q1b1pr8mSDAgAOvTsIME3aVci3o6jsOn/
 F81e+MyXvZiiMbkOk64Y3V/FWxR5gEEMewptmfwbU6qYTu2txs8SNQQYg
 ux9fG69xIuCo/rLL2TKQq50L+r7BpOkgULSpCA/7UcMX749PY5qJp/rWs Q==;
X-CSE-ConnectionGUID: f4ctMtg/RVi1OZE1EftkcQ==
X-CSE-MsgGUID: 5kRnIkP4S8+tKbSjQzZTYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473602"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473602"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:31 -0700
X-CSE-ConnectionGUID: f5Jlbe07REKz3Q+5XIHJSQ==
X-CSE-MsgGUID: h4s2TdlfR4iGUIGCshJ2WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525892"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 16/18] eal: rework internal coremask parsing to use cpu sets
Date: Fri,  3 Oct 2025 09:15:08 +0100
Message-ID: <20251003081510.1197166-17-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003081510.1197166-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
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

Rather than working off arrays of lcore values, update the coremask
handling to use rte_cpuset_t. The use of the array provides no
additional value for coremasks, since the order of the bits set will
always be from lowest core number to highest, making the tracking of
what core was 0, 1, 2 etc. pointless.

As part of this change, move the prototype for the parse_coremask
function from rte_eal.h to eal_options.h, for two reasons:

1. This is an internal function that should not be used by apps and so
   there is no need to have it in a public header.
2. If the compilation command is run without the _GNU_SOURCE flag, we
   miss definitions from sched.h and so get build errors for the
   rte_cpuset_t type when compiling examples against an installed DPDK.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/event/dlb2/dlb2_priv.h             |  2 +-
 drivers/event/dlb2/pf/base/dlb2_resource.c | 11 ++++----
 lib/eal/common/eal_common_options.c        | 30 ++++++++--------------
 lib/eal/common/eal_options.h               |  2 ++
 lib/eal/include/rte_eal.h                  | 22 ----------------
 5 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 6e0a5bc936..607b4d24d0 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -750,7 +750,7 @@ void dlb2_event_build_hcws(struct dlb2_port *qm_port,
 			   uint8_t *queue_id);
 
 /* Extern functions */
-extern int rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range);
+extern int rte_eal_parse_coremask(const char *coremask, rte_cpuset_t *cpuset, bool limit_range);
 
 /* Extern globals */
 extern struct process_local_port_data dlb2_port[][DLB2_NUM_PORT_TYPES];
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/dlb2/pf/base/dlb2_resource.c
index 6742c470f1..490dcaf7dd 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.c
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
@@ -922,28 +922,29 @@ dlb2_resource_probe(struct dlb2_hw *hw, const void *probe_args)
 {
 	const struct dlb2_devargs *args = (const struct dlb2_devargs *)probe_args;
 	const char *mask = args ? args->producer_coremask : NULL;
-	int cpu = 0, cnt = 0, cores[CPU_SETSIZE], i;
+	rte_cpuset_t cpuset;
+	int cpu = 0, cnt = 0, i, set_count = 0;
 
 	if (args) {
 		mask = (const char *)args->producer_coremask;
 	}
 
-	if (mask && rte_eal_parse_coremask(mask, cores, true)) {
+	if (mask && rte_eal_parse_coremask(mask, &cpuset, true)) {
 		DLB2_HW_ERR(hw, ": Invalid producer coremask=%s\n", mask);
 		return -1;
 	}
 
 	hw->num_prod_cores = 0;
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		bool is_pcore = (mask && cores[i] != -1);
+		bool is_pcore = (mask && CPU_ISSET(i, &cpuset));
 
 		if (rte_lcore_is_enabled(i)) {
 			if (is_pcore) {
 				/*
 				 * Populate the producer cores from parsed
-				 * coremask
+				 * coremask using the set_count as index.
 				 */
-				hw->prod_core_list[cores[i]] = i;
+				hw->prod_core_list[set_count++] = i;
 				hw->num_prod_cores++;
 
 			} else if ((++cnt == DLB2_EAL_PROBE_CORE ||
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 95081c9f54..86351535ee 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -841,7 +841,7 @@ eal_parse_service_coremask(const char *coremask)
 }
 
 static int
-update_lcore_config(int *cores, bool remap, uint16_t remap_base)
+update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
 	unsigned int count = 0;
@@ -855,9 +855,9 @@ update_lcore_config(int *cores, bool remap, uint16_t remap_base)
 		lcore_config[i].core_index = -1;
 	}
 
-	/* now go through the core mask */
+	/* now go through the cpuset */
 	for (i = 0; i < CPU_SETSIZE; i++) {
-		if (cores[i] != -1) {
+		if (CPU_ISSET(i, cpuset)) {
 			if (eal_cpu_detected(i) == 0) {
 				EAL_LOG(ERR, "lcore %u unavailable", i);
 				ret = -1;
@@ -866,7 +866,7 @@ update_lcore_config(int *cores, bool remap, uint16_t remap_base)
 			if (!remap)
 				lcore_id = i;
 			cfg->lcore_role[lcore_id] = ROLE_RTE;
-			lcore_config[lcore_id].core_index = cores[i];
+			lcore_config[lcore_id].core_index = count;
 			CPU_ZERO(&lcore_config[lcore_id].cpuset);
 			CPU_SET(i, &lcore_config[lcore_id].cpuset);
 			EAL_LOG(DEBUG, "lcore %u mapped to physical core %u", lcore_id, i);
@@ -919,7 +919,7 @@ check_core_list(int *lcores, unsigned int count)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_parse_coremask)
 int
-rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range)
+rte_eal_parse_coremask(const char *coremask, rte_cpuset_t *cpuset, bool limit_range)
 {
 	const char *coremask_orig = coremask;
 	int lcores[CPU_SETSIZE];
@@ -928,8 +928,7 @@ rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range)
 	int val;
 	char c;
 
-	for (idx = 0; idx < CPU_SETSIZE; idx++)
-		cores[idx] = -1;
+	CPU_ZERO(cpuset);
 	idx = 0;
 
 	EAL_LOG(WARNING, "'-c <coremask>' option is deprecated, and will be removed in a future release");
@@ -975,6 +974,7 @@ rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range)
 					return -1;
 				}
 				lcores[count++] = idx;
+				CPU_SET(idx, cpuset);
 			}
 		}
 	}
@@ -988,16 +988,6 @@ rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range)
 	if (limit_range && check_core_list(lcores, count) != 0)
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
 	return 0;
 }
 
@@ -1931,13 +1921,13 @@ eal_parse_args(void)
 
 	/* parse the core list arguments */
 	if (args.coremask != NULL) {
-		int lcore_indexes[CPU_SETSIZE];
+		rte_cpuset_t cpuset;
 
-		if (rte_eal_parse_coremask(args.coremask, lcore_indexes, !remap_lcores) < 0) {
+		if (rte_eal_parse_coremask(args.coremask, &cpuset, !remap_lcores) < 0) {
 			EAL_LOG(ERR, "invalid coremask syntax");
 			return -1;
 		}
-		if (update_lcore_config(lcore_indexes, remap_lcores, lcore_id_base) < 0) {
+		if (update_lcore_config(&cpuset, remap_lcores, lcore_id_base) < 0) {
 			char *available = available_cores();
 
 			EAL_LOG(ERR, "invalid coremask '%s', please check specified cores are part of %s",
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 4a8a0f1df7..f5e7905609 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -20,5 +20,7 @@ int eal_save_args(int argc, char **argv);
 void eal_clean_saved_args(void);
 int handle_eal_info_request(const char *cmd, const char *params __rte_unused,
 		struct rte_tel_data *d);
+__rte_internal
+int rte_eal_parse_coremask(const char *coremask, rte_cpuset_t *cpuset, bool limit_range);
 
 #endif /* EAL_OPTIONS_H */
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index bc58254ece..619b8fbade 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -491,28 +491,6 @@ rte_eal_mbuf_user_pool_ops(void);
 const char *
 rte_eal_get_runtime_dir(void);
 
-/**
- * Convert a string describing a mask of core ids into an array of core ids.
- *
- * On success, the passed array is filled with the orders of the core ids
- * present in the mask (-1 indicating that a core id is absent).
- * For example, passing a 0xa coremask results in cores[1] = 0, cores[3] = 1,
- * and the rest of the array is set to -1.
- *
- * @param coremask
- *   A string describing a mask of core ids.
- * @param cores
- *   An array where to store the core ids orders.
- *   This array must be at least CPU_SETSIZE large.
- * @param limit_range
- *   If set, return an error if any cores in the mask are >= RTE_MAX_LCORE.
- * @return
- *   0 on success, -1 if the string content was invalid.
- */
-__rte_internal
-int
-rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range);
-
 #ifdef __cplusplus
 }
 #endif
-- 
2.48.1

