Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E013C36008
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 17:31:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 381B240DDC;
	Mon, 24 Mar 2025 18:30:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 42E2540DCA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 18:30:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742837445; x=1774373445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O+Yuu0Icuoa6IFxpuMIpy/XjxIUJfbd1j3QPgIzKC6Q=;
 b=RM6a864D0NHkjK8gmt0QuN0CHmDxy/0s9EIJDjHoLrpIFlEFPMCjNpA3
 QSmzPpKY7dVnOB1pELIbnXY256JQf9AzBttDC0bCtuhXWhi9Cb4J6nIuL
 wU0O4u+tPEP3jy3aNpLAqfl8g02AkZEz9nVn1TsYbRqymWR9idakGNgM+
 cfH+Eiq0mFeTVWGe1Iy7yTSZyKZV8+V8M9oEzb8sSkmzM0vhLgsnQ5yVq
 ifAt9O0xU5hI9U/m/GVOKUhf8FpA+0O3amJRA63hYyP7qQ0TB3mQy4Wrq
 PA3D0sSHvTzQtRiKpLtmJ0ABIqNd2jr7ku5e3zrxlBZ/P8SJXn5BUKv9T g==;
X-CSE-ConnectionGUID: lZLCkokqSvK3fJhtA3Umbw==
X-CSE-MsgGUID: jZz+KunoQlejH0ZF3DuXrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="47715570"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="47715570"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2025 10:30:45 -0700
X-CSE-ConnectionGUID: 1YYBWdm9Spm4Roc6+jns6Q==
X-CSE-MsgGUID: /tEQHSwjT2eRc8MpICnHig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; d="scan'208";a="124141962"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa006.jf.intel.com with ESMTP; 24 Mar 2025 10:30:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Pravin Pathak <pravin.pathak@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 3/3] eal: allow automatic mapping of high lcore ids
Date: Mon, 24 Mar 2025 17:30:29 +0000
Message-ID: <20250324173030.3733517-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250324173030.3733517-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
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

To use cores with IDs greater than RTE_MAX_LCORE the user must provide a
mapping of those higher core numbers to ids within the 0 - RTE_MAX_LCORE
range. This can be awkward to do manually when more than a few lcores
are involved, so instead we can provide an extra option to EAL to do
this manually.

This patch therefore introduces the "map-lcore-ids" flag, which
automatically maps all provided lcore numbers to start at zero.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst  | 26 ++++++++++++++++-
 drivers/event/dlb2/pf/base/dlb2_resource.c |  2 +-
 lib/eal/common/eal_common_options.c        | 34 +++++++++++++++-------
 lib/eal/common/eal_options.h               |  3 ++
 lib/eal/include/rte_eal.h                  |  4 ++-
 5 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 9cfbf7de84..1d9525f73c 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -13,7 +13,7 @@ Lcore-related options
     List of cores to run on
 
     The argument format is ``<c1>[-c2][,c3[-c4],...]``
-    where ``c1``, ``c2``, etc are core indexes between 0 and 128.
+    where ``c1``, ``c2``, etc are core indexes between 0 and RTE_MAX_LCORE (default 128).
 
 *   ``--lcores <core map>``
 
@@ -29,10 +29,34 @@ Lcore-related options
     The grouping ``()`` can be omitted for single element group.
     The ``@`` can be omitted if cpus and lcores have the same value.
 
+.. Note::
+    When using ``--lcores`` parameter to map lcore ids to cpus,
+    the lcore ids must be in the range 0 to ``RTE_MAX_LCORE`` (default 128),
+    but the cpu ids need not be.
+
+    This allows an application to use cpus with ids greater than ``RTE_MAX_LCORE``,
+    so long as the total number of lcores is less than or equal to ``RTE_MAX_LCORE``.
+
 .. Note::
     At a given instance only one core option ``--lcores``, ``-l`` or ``-c`` can
     be used.
 
+*   ``--map-lcore-ids``, ``-M``
+
+    Automatically map the cpus given in a coremask using ``-c`` parameter,
+    or in a core list using ``-l`` parameter, to internal lcore-ids starting at 0.
+    (If ``--lcores`` parameter is provided, this parameter is ignored.)
+
+    This can provide a shorter way, compared to using ``--lcores`` parameter,
+    to use cpus with ids greater than ``RTE_MAX_LCORE`` in an application.
+
+    For example, ``-c 0x3000 --map-lcore-ids`` will cause cpus 12 and 13 to be used,
+    with application lcore ids of 0 and 1 respectively.
+    Similarly, ``-Ml 94,95,31-33`` is equivalent to ``--lcores=0@94,1@95,2@31,3@32,4@33``,
+    where the application lcore ids are 0-4,
+    mapped to the physical cpus 94, 95, 31, 32 and 33 respectively.
+
+
 *   ``--main-lcore <core ID>``
 
     Core ID that is used as main.
diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/dlb2/pf/base/dlb2_resource.c
index 9b087b03b5..d38aa5115e 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.c
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
@@ -931,7 +931,7 @@ dlb2_resource_probe(struct dlb2_hw *hw, const void *probe_args)
 	cpu = rte_get_next_lcore(-1, 1, 0);
 	hw->num_prod_cores = 0;
 	if (mask) {
-		int n = rte_eal_expand_coremask(mask, hw->prod_core_list);
+		int n = rte_eal_expand_coremask(mask, hw->prod_core_list, true);
 		if (n <= 0) {
 			DLB2_HW_ERR(hw, ": Invalid producer coremask=%s\n", mask);
 			return -1;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 22ea6b24e4..25061ffb9b 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -56,6 +56,7 @@ eal_short_options[] =
 	"d:" /* driver */
 	"h"  /* help */
 	"l:" /* corelist */
+	"M" /* map lcore ids to zero*/
 	"S:" /* service corelist */
 	"m:" /* memory size */
 	"n:" /* memory channels */
@@ -106,6 +107,7 @@ eal_long_options[] = {
 	{OPT_NO_TELEMETRY,      0, NULL, OPT_NO_TELEMETRY_NUM     },
 	{OPT_FORCE_MAX_SIMD_BITWIDTH, 1, NULL, OPT_FORCE_MAX_SIMD_BITWIDTH_NUM},
 	{OPT_HUGE_WORKER_STACK, 2, NULL, OPT_HUGE_WORKER_STACK_NUM     },
+	{OPT_MAP_LCORE_IDS,     0, NULL, OPT_MAP_LCORE_IDS_NUM    },
 
 	{0,                     0, NULL, 0                        }
 };
@@ -152,6 +154,7 @@ TAILQ_HEAD_INITIALIZER(devopt_list);
 static int main_lcore_parsed;
 static int mem_parsed;
 static struct lcore_options {
+	bool map_lcore_ids;
 	const char *core_mask_opt;
 	const char *core_list_opt;
 	const char *core_map_opt;
@@ -723,13 +726,14 @@ check_core_list(int *lcores, unsigned int count)
 	if (len > 0)
 		lcorestr[len - 1] = 0;
 	EAL_LOG(ERR, "To use high physical core ids, "
-		"please use --lcores to map them to lcore ids below RTE_MAX_LCORE, "
+		"please use --map-lcore-ids/-M flag to map core ids automatically, "
+		"or use --lcores to map them manually to lcore ids below RTE_MAX_LCORE, "
 		"e.g. --lcores %s", lcorestr);
 	return -1;
 }
 
 int
-rte_eal_expand_coremask(const char *coremask, int *cores)
+rte_eal_expand_coremask(const char *coremask, int *cores, bool no_check)
 {
 	const char *coremask_orig = coremask;
 	unsigned int count = 0;
@@ -784,7 +788,7 @@ rte_eal_expand_coremask(const char *coremask, int *cores)
 		return -1;
 	}
 
-	if (check_core_list(cores, count) != 0)
+	if (!no_check && check_core_list(cores, count) != 0)
 		return -1;
 
 	return count;
@@ -869,7 +873,7 @@ eal_parse_service_corelist(const char *corelist)
 }
 
 static int
-eal_parse_corelist(const char *corelist, int *cores)
+eal_parse_corelist(const char *corelist, int *cores, bool no_check)
 {
 	unsigned int count = 0, i;
 	char *end = NULL;
@@ -932,7 +936,7 @@ eal_parse_corelist(const char *corelist, int *cores)
 		return -1;
 	}
 
-	if (check_core_list(cores, count))
+	if (!no_check && check_core_list(cores, count))
 		return -1;
 
 	return count;
@@ -1558,6 +1562,10 @@ eal_parse_common_option(int opt, const char *optarg,
 	case 'l':
 		lcore_options.core_list_opt = optarg;
 		break;
+	/* map lcore ids */
+	case 'M':
+		lcore_options.map_lcore_ids = true;
+		break;
 	/* service coremask */
 	case 's':
 		lcore_options.service_mask_opt = optarg;
@@ -1866,10 +1874,11 @@ eal_adjust_config(struct internal_config *internal_cfg)
 
 
 	if (lcore_options.core_mask_opt || lcore_options.core_list_opt) {
-		int lcore_indexes[RTE_MAX_LCORE];
+		bool map_ids = lcore_options.map_lcore_ids;
+		int idxs[RTE_MAX_LCORE];
 		int nb_indexes = lcore_options.core_list_opt ?
-				eal_parse_corelist(lcore_options.core_list_opt, lcore_indexes) :
-				rte_eal_expand_coremask(lcore_options.core_mask_opt, lcore_indexes);
+				eal_parse_corelist(lcore_options.core_list_opt, idxs, map_ids) :
+				rte_eal_expand_coremask(lcore_options.core_mask_opt, idxs, map_ids);
 
 		if (nb_indexes < 0)
 			return -1;
@@ -1877,13 +1886,16 @@ eal_adjust_config(struct internal_config *internal_cfg)
 		char *core_map_opt = malloc(RTE_MAX_LCORE * 10);
 		size_t core_map_len = 0;
 		for (i = 0; i < nb_indexes; i++) {
-			if (!eal_cpu_detected(lcore_indexes[i])) {
-				EAL_LOG(ERR, "core %d not present", lcore_indexes[i]);
+			if (!eal_cpu_detected(idxs[i])) {
+				EAL_LOG(ERR, "core %d not present", idxs[i]);
 				return -1;
 			}
 			int n = snprintf(core_map_opt + core_map_len,
 					(RTE_MAX_LCORE * 10) - core_map_len,
-					"%s%d", i == 0 ? "" : ",", lcore_indexes[i]);
+					"%s%d@%d",
+					i == 0 ? "" : ",",
+					map_ids ? i : idxs[i],
+					idxs[i]);
 			if (n < 0 || (size_t)n >= (RTE_MAX_LCORE * 10) - core_map_len) {
 				EAL_LOG(ERR, "core map string too long");
 				return -1;
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 95fb4f6108..1344bce9ba 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -17,6 +17,9 @@ enum {
 	OPT_DEV_ALLOW_NUM       = 'a',
 #define OPT_DEV_BLOCK         "block"
 	OPT_DEV_BLOCK_NUM      = 'b',
+#define OPT_MAP_LCORE_IDS  "map-lcore-ids"
+	OPT_MAP_LCORE_IDS_NUM  = 'M',
+
 
 	/* first long only option value must be >= 256, so that we won't
 	 * conflict with short options */
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index 013075487c..2f7a7dcfbe 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -500,13 +500,15 @@ rte_eal_get_runtime_dir(void);
  * @param cores
  *   The output array to store the core ids.
  *   This array must be at least RTE_MAX_LCORE large.
+ * @param nocheck
+ *   If true, skip checking that the core ids are between 0..RTE_MAX_LCORE
  * @return
  *  The number of cores in the coremask, and in the returned "cores" array,
  *  -1 if the string content was invalid.
  */
 __rte_internal
 int
-rte_eal_expand_coremask(const char *coremask, int *cores);
+rte_eal_expand_coremask(const char *coremask, int *cores, bool nocheck);
 
 #ifdef __cplusplus
 }
-- 
2.45.2

