Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA6CCA470
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C0C740B92;
	Fri,  3 Oct 2025 10:15:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1E2CC40A70
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479331; x=1791015331;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gVPop+7cZFIcX/pqPQPwMVuBV6FhWuPnXDBSH8gJSCk=;
 b=CcSxkV1ataXekh95gS0LUW5+MYrzIQghaY9/EYPcHVT+0wvsMl7JpGZA
 O0cKk3Rme3PUHz3YENVIktVLHpxyVigMdpBJeX2cIVincVh6VdZfhirKO
 hfZke+wSRg5NNOoQJ5dtEZWStgoQVhT4bDVmbzHdUNb2LX+isvxaBkaEd
 vmvA6bKNsV0n5EJGKfH0j58yCDOyMsHyKKmeyumUDBqQSuJ/GOqCG0tZL
 eB4cFnVXBM6abIoy3Uqu+/1IXj1YCKBwVQxuFbKjApSxf0NOc/82M0RVI
 6KuNnfuWpxsZmVbAHmKkT6+Z2AfDdjIC08pCdWC1yg6YzcznbEpk71bp8 w==;
X-CSE-ConnectionGUID: hH2aR2vNSMqdHjPBarARiw==
X-CSE-MsgGUID: xpoJxiFUR367dURT4jFiSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473599"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473599"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:30 -0700
X-CSE-ConnectionGUID: RkESQ/5WSHW38pCDOd7e4A==
X-CSE-MsgGUID: f97d2E/qRm20VTb3AikYkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525885"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:28 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 15/18] eal: introduce lcore remapping option for coremasks
Date: Fri,  3 Oct 2025 09:15:07 +0100
Message-ID: <20251003081510.1197166-16-bruce.richardson@intel.com>
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

Add the new "--remap-lcore-ids" or "-R" option to signify that lcore ids
are to start at a low range. This takes an optional parameter to specify
the value to start from. Initially, use this to adjust the core mappings
when using a coremask.

As well as remapping within the range of RTE_MAX_LCORE, to allow use of
cores >=RTE_MAX_LCORE we need to expand the internal arrays of cores to
be CPU_SETSIZE big, and limit the checks for RTE_MAX_LCORE to only cases
where we are not remapping. This requires an additional parameter to the
internal API rte_eal_parse_coremask, having a small knock-on effect on
DLB driver as the only other user of this API.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/event/dlb2/dlb2_priv.h             |  2 +-
 drivers/event/dlb2/pf/base/dlb2_resource.c |  4 +-
 lib/eal/common/eal_common_options.c        | 54 +++++++++++++++++-----
 lib/eal/common/eal_option_list.h           |  1 +
 lib/eal/include/rte_eal.h                  |  6 ++-
 5 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 7a5cbcca1e..6e0a5bc936 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -750,7 +750,7 @@ void dlb2_event_build_hcws(struct dlb2_port *qm_port,
 			   uint8_t *queue_id);
 
 /* Extern functions */
-extern int rte_eal_parse_coremask(const char *coremask, int *cores);
+extern int rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range);
 
 /* Extern globals */
 extern struct process_local_port_data dlb2_port[][DLB2_NUM_PORT_TYPES];
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/dlb2/pf/base/dlb2_resource.c
index 98f2f5ef92..6742c470f1 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.c
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
@@ -922,13 +922,13 @@ dlb2_resource_probe(struct dlb2_hw *hw, const void *probe_args)
 {
 	const struct dlb2_devargs *args = (const struct dlb2_devargs *)probe_args;
 	const char *mask = args ? args->producer_coremask : NULL;
-	int cpu = 0, cnt = 0, cores[RTE_MAX_LCORE], i;
+	int cpu = 0, cnt = 0, cores[CPU_SETSIZE], i;
 
 	if (args) {
 		mask = (const char *)args->producer_coremask;
 	}
 
-	if (mask && rte_eal_parse_coremask(mask, cores)) {
+	if (mask && rte_eal_parse_coremask(mask, cores, true)) {
 		DLB2_HW_ERR(hw, ": Invalid producer coremask=%s\n", mask);
 		return -1;
 	}
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 0f3db158f6..95081c9f54 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -841,26 +841,38 @@ eal_parse_service_coremask(const char *coremask)
 }
 
 static int
-update_lcore_config(int *cores)
+update_lcore_config(int *cores, bool remap, uint16_t remap_base)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
 	unsigned int count = 0;
 	unsigned int i;
+	unsigned int lcore_id = remap_base;
 	int ret = 0;
 
+	/* set everything to disabled first, then set up values */
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
+		cfg->lcore_role[i] = ROLE_OFF;
+		lcore_config[i].core_index = -1;
+	}
+
+	/* now go through the core mask */
+	for (i = 0; i < CPU_SETSIZE; i++) {
 		if (cores[i] != -1) {
 			if (eal_cpu_detected(i) == 0) {
 				EAL_LOG(ERR, "lcore %u unavailable", i);
 				ret = -1;
 				continue;
 			}
-			cfg->lcore_role[i] = ROLE_RTE;
+			if (!remap)
+				lcore_id = i;
+			cfg->lcore_role[lcore_id] = ROLE_RTE;
+			lcore_config[lcore_id].core_index = cores[i];
+			CPU_ZERO(&lcore_config[lcore_id].cpuset);
+			CPU_SET(i, &lcore_config[lcore_id].cpuset);
+			EAL_LOG(DEBUG, "lcore %u mapped to physical core %u", lcore_id, i);
+			lcore_id++;
 			count++;
-		} else {
-			cfg->lcore_role[i] = ROLE_OFF;
 		}
-		lcore_config[i].core_index = cores[i];
 	}
 	if (!ret)
 		cfg->lcore_count = count;
@@ -907,16 +919,16 @@ check_core_list(int *lcores, unsigned int count)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_parse_coremask)
 int
-rte_eal_parse_coremask(const char *coremask, int *cores)
+rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range)
 {
 	const char *coremask_orig = coremask;
-	int lcores[RTE_MAX_LCORE];
+	int lcores[CPU_SETSIZE];
 	unsigned int count = 0;
 	int i, j, idx;
 	int val;
 	char c;
 
-	for (idx = 0; idx < RTE_MAX_LCORE; idx++)
+	for (idx = 0; idx < CPU_SETSIZE; idx++)
 		cores[idx] = -1;
 	idx = 0;
 
@@ -957,6 +969,11 @@ rte_eal_parse_coremask(const char *coremask, int *cores)
 						RTE_MAX_LCORE);
 					return -1;
 				}
+				if (idx >= CPU_SETSIZE) {
+					EAL_LOG(ERR, "lcore %d >= CPU_SETSIZE (%d), cannot use.",
+						idx, CPU_SETSIZE);
+					return -1;
+				}
 				lcores[count++] = idx;
 			}
 		}
@@ -967,7 +984,8 @@ rte_eal_parse_coremask(const char *coremask, int *cores)
 		return -1;
 	}
 
-	if (check_core_list(lcores, count))
+	/* if we are asked to, we need to check that cores < RTE_MAX_LCORE */
+	if (limit_range && check_core_list(lcores, count) != 0)
 		return -1;
 
 	/*
@@ -1866,6 +1884,8 @@ eal_parse_args(void)
 	struct internal_config *int_cfg = eal_get_internal_configuration();
 	struct rte_config *rte_cfg = rte_eal_get_configuration();
 	struct arg_list_elem *arg;
+	bool remap_lcores = (args.remap_lcore_ids != NULL);
+	uint16_t lcore_id_base = 0;
 
 	/* print version before anything else */
 	/* since message is explicitly requested by user, we write message
@@ -1899,15 +1919,25 @@ eal_parse_args(void)
 		if (eal_plugin_add(arg->arg) < 0)
 			return -1;
 
+	if (remap_lcores && args.remap_lcore_ids != (void *)1) {
+		char *endp;
+		errno = 0;
+		lcore_id_base = (uint16_t)strtoul(args.remap_lcore_ids, &endp, 0);
+		if (errno != 0 || lcore_id_base >= RTE_MAX_LCORE || *endp != '\0') {
+			EAL_LOG(ERR, "invalid lcore base id: %s", args.remap_lcore_ids);
+			return -1;
+		}
+	}
+
 	/* parse the core list arguments */
 	if (args.coremask != NULL) {
-		int lcore_indexes[RTE_MAX_LCORE];
+		int lcore_indexes[CPU_SETSIZE];
 
-		if (rte_eal_parse_coremask(args.coremask, lcore_indexes) < 0) {
+		if (rte_eal_parse_coremask(args.coremask, lcore_indexes, !remap_lcores) < 0) {
 			EAL_LOG(ERR, "invalid coremask syntax");
 			return -1;
 		}
-		if (update_lcore_config(lcore_indexes) < 0) {
+		if (update_lcore_config(lcore_indexes, remap_lcores, lcore_id_base) < 0) {
 			char *available = available_cores();
 
 			EAL_LOG(ERR, "invalid coremask '%s', please check specified cores are part of %s",
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index f5c21c8376..e4a849e78e 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -57,6 +57,7 @@ BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
 BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf)
 BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry)
 STR_ARG("--proc-type", NULL, "Type of process (primary|secondary|auto)", proc_type)
+OPT_STR_ARG("--remap-lcore-ids", "-R", "Remap lcore IDs to be contiguous starting from 0, or supplied value", remap_lcore_ids)
 STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist)
 STR_ARG("--service-coremask", "-s", "[Deprecated] Bitmask of cores to use for service threads", service_coremask)
 BOOL_ARG("--single-file-segments", NULL, "Store all pages within single files (per-page-size, per-node)", single_file_segments)
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index 08977c61d3..bc58254ece 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -503,13 +503,15 @@ rte_eal_get_runtime_dir(void);
  *   A string describing a mask of core ids.
  * @param cores
  *   An array where to store the core ids orders.
- *   This array must be at least RTE_MAX_LCORE large.
+ *   This array must be at least CPU_SETSIZE large.
+ * @param limit_range
+ *   If set, return an error if any cores in the mask are >= RTE_MAX_LCORE.
  * @return
  *   0 on success, -1 if the string content was invalid.
  */
 __rte_internal
 int
-rte_eal_parse_coremask(const char *coremask, int *cores);
+rte_eal_parse_coremask(const char *coremask, int *cores, bool limit_range);
 
 #ifdef __cplusplus
 }
-- 
2.48.1

