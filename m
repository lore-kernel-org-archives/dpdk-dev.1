Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ED8C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:22:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6386741149;
	Wed, 23 Jul 2025 18:21:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5EB2B41104
 for <dev@dpdk.org>; Wed, 23 Jul 2025 18:21:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753287678; x=1784823678;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pwmmD3QAHQdMOcjxxMG9Eqq35GNAY/FDXCqmYzCrqYY=;
 b=cjE+c0eEHHItk+9xiOkgUGEJ+cMLMXD1kVAW7YCGp4SHmkpgrEDyV0ov
 2kXb/sIqbpvmUv2pUbtbGF7kAI4oy040+grzMCMVr/am1sI8dqLL+J7Yg
 hnf9fGlpWhGsqCVYdS3o4ebt94nBYmx088ZyDmpR6t4uTVB57/rEg1l2T
 uzcrgumEXm8huUXlr8snt1km//IeIgeK5e5JYbKX/eO9bYCTczm/lQU3c
 lrydM3MHaAbv1kRbME7Tx7d4stmm7cD1xn+Wsm2BInS5aJ0rZiM3TcjQa
 Dp5SXm+3vnICVSA4XO5Ip5tdB2sv2uNewwAwpU2bnN+9+3aHHQEwkQkfM Q==;
X-CSE-ConnectionGUID: 1vkyAQ23RLWxP2ZK9vL1Fg==
X-CSE-MsgGUID: zZS8+8nNRNOHsC/4WIyf7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43198021"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="43198021"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 09:21:17 -0700
X-CSE-ConnectionGUID: A6tyiCvvQM24mWF/eLypwQ==
X-CSE-MsgGUID: m0xpp4J/RCO7wr7GGlzuXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="160148944"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa008.fm.intel.com with ESMTP; 23 Jul 2025 09:21:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 12/13] eal: simplify running CPUs with ids above max lcores
Date: Wed, 23 Jul 2025 17:20:10 +0100
Message-ID: <20250723162013.2392-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723162013.2392-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
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

To simplify use on systems with large numbers of cores, where it becomes
more awkward to use CPU cores numbered above 128, we add to EAL the "-L"
or "--lcores-remapped" option, which simply takes a list of cores to run
on, and maps them to lcore ids starting at a defined base (0 by
default).

To enable secondary process use of this, we also add in an extra flag
--lcoreid-base, which changes the starting lcore id from 0. This flag is
mandatory in secondary processes, to ensure that we don't have lcore ids
that overlap between primary and secondary.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst | 46 ++++++++++++-
 doc/guides/rel_notes/release_25_11.rst    |  9 +++
 lib/eal/common/eal_common_options.c       | 79 +++++++++++++++++++++--
 lib/eal/common/eal_option_list.h          |  2 +
 4 files changed, 130 insertions(+), 6 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 0b17879d42..d45d79b827 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -4,6 +4,28 @@
 Lcore-related options
 ~~~~~~~~~~~~~~~~~~~~~
 
+*   ``-L, --lcores-remapped <core list>``
+
+    List of physical CPU cores to use,
+    with each core assigned a sequential logical core (lcore) ID starting from 0.
+    This is a simplified alternative to ``--lcores``, described below,
+    for cases where you want to use specific physical cores,
+    (some or all of which have physical ids greater than RTE_MAX_LCORE)
+    but don't need complex logical-to-physical core mappings.
+
+    The argument format is a standard core list: ``<c1>[-c2][,c3[-c4],...]``
+    where ``c1``, ``c2``, etc are physical core indexes.
+
+    Examples:
+
+    ``--lcores-remapped=3-5``
+      Use physical cores 3, 4, and 5 as logical cores 0, 1, and 2 respectively.
+      This is equivalent to ``--lcores=0@3,1@4,2@5``.
+
+    ``--lcores-remapped=150,152,154``
+      Use physical cores 150, 152, and 154 as logical cores 0, 1, and 2 respectively.
+      This is equivalent to ``--lcores=0@150,1@152,2@154``.
+
 *   ``-l, --lcores <core list>``
 
     List of cores to run on
@@ -64,9 +86,31 @@ Lcore-related options
 
 .. note::
 
-    At a given instance only one core option ``--lcores``, ``-l`` or ``-c`` can
+    At a given instance only one core option ``--lcores`` / ``-l``, or ``--lcores-remapped`` / ``-L`` can
     be used.
 
+*   ``--lcoreid-base <base ID>``
+
+    Adjust the base logical core ID for ``--lcores-remapped`` (default: 0).
+    When used with ``--lcores-remapped``,
+    logical core numbering starts from this value instead of 0.
+    This is particularly useful for secondary processes in a multi-process setup,
+    as lcore_ids must all be unique across all processes.
+
+    Example:
+
+    ``--lcores-remapped=3-5 --lcoreid-base=10``
+      Use physical cores 3, 4, and 5 as logical cores 10, 11, and 12 respectively.
+      This is equivalent to ``--lcores=10@3,11@4,12@5``.
+
+.. note::
+
+    The ``--lcores-remapped`` option is ignored if used with ``--lcores``, ``-l`` option.
+
+.. note::
+
+    For secondary processes, ``--lcoreid-base`` *must* be specified when using ``--lcores-remapped``.
+
 *   ``--main-lcore <core ID>``
 
     Core ID that is used as main.
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 75bbd0e821..39fc800f6e 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,15 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added EAL lcores-remapped(-L) argument to simplify running on higher-numbered cores.**
+
+  Added new EAL command line arguments ``-L, --lcores-remapped`` and ``--lcoreid-base``
+  that provide a simplified way to specify which physical CPU cores to use.
+  The ``--lcores-remapped`` argument allows specifying a list of physical cores on which the EAL threads are to be spawned,
+  with each thread being assigned an lcore id in sequence.
+  The lcore numbering starts at 0 by default, though this can be overridden using ``--lcoreid-base``.
+  See :doc:`../linux_gsg/eal_args.include` for more details.
+
 * **Allow overriding the automatic usage/help generation in argparse library.**
 
   The argparse library now supports overriding the automatic help text generation,
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index c568e59ef3..af2bd33fd4 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -232,6 +232,8 @@ eal_collate_args(int argc, char **argv)
 
 	/* for non-list args, we can just check for zero/null values using macro */
 	if (CONFLICTING_OPTIONS(args, coremask, lcores) ||
+			CONFLICTING_OPTIONS(args, coremask, lcores_remapped) ||
+			CONFLICTING_OPTIONS(args, lcores, lcores_remapped) ||
 			CONFLICTING_OPTIONS(args, service_coremask, service_corelist) ||
 			CONFLICTING_OPTIONS(args, no_telemetry, telemetry) ||
 			CONFLICTING_OPTIONS(args, memory_size, numa_mem) ||
@@ -1351,6 +1353,67 @@ eal_parse_lcores(const char *lcores)
 	return ret;
 }
 
+static int
+eal_parse_lcores_remapped(const char *corelist, const char *base_str)
+{
+	struct rte_config *cfg = rte_eal_get_configuration();
+	rte_cpuset_t phys_cores;
+
+	/* Reset lcore config */
+	for (int i = 0; i < RTE_MAX_LCORE; i++) {
+		cfg->lcore_role[i] = ROLE_OFF;
+		lcore_config[i].core_index = -1;
+		CPU_ZERO(&lcore_config[i].cpuset);
+	}
+
+	/* Parse the physical core list using rte_argparse_parse_type */
+	if (rte_argparse_parse_type(corelist, RTE_ARGPARSE_VALUE_TYPE_CORELIST, &phys_cores) < 0) {
+		EAL_LOG(ERR, "Invalid lcores-remapped format: '%s'", corelist);
+		return -1;
+	}
+	if (CPU_COUNT(&phys_cores) == 0) {
+		EAL_LOG(ERR, "No valid cores specified in lcores-remapped: '%s'", corelist);
+		return -1;
+	}
+
+	if (check_cpuset(&phys_cores) < 0)
+		return -1;
+
+	/* Parse base lcore ID if provided */
+	unsigned int base_lcore = 0;
+	if (base_str != NULL) {
+		char *end;
+		errno = 0;
+		base_lcore = strtoul(base_str, &end, 10);
+		if (errno || end == NULL || *end != '\0' || base_lcore >= RTE_MAX_LCORE) {
+			EAL_LOG(ERR, "Invalid lcoreid-base: '%s'", base_str);
+			return -1;
+		}
+	}
+
+	/* Map logical cores starting from base_lcore to physical cores */
+	unsigned int count = 0;
+	for (int i = 0; i < CPU_SETSIZE && count < RTE_MAX_LCORE; i++) {
+		if (CPU_ISSET(i, &phys_cores)) {
+			const unsigned int lcore_id = base_lcore + count;
+			if (lcore_id >= RTE_MAX_LCORE) {
+				EAL_LOG(ERR, "Logical lcore %u exceeds RTE_MAX_LCORE (%d)",
+						lcore_id, RTE_MAX_LCORE);
+				return -1;
+			}
+
+			/* Set up the lcore configuration */
+			cfg->lcore_role[lcore_id] = ROLE_RTE;
+			lcore_config[lcore_id].core_index = count;
+			CPU_SET(i, &lcore_config[lcore_id].cpuset);
+			count++;
+		}
+	}
+
+	cfg->lcore_count = count;
+	return 0;
+}
+
 static void
 eal_log_usage(void)
 {
@@ -1842,6 +1905,8 @@ eal_parse_args(void)
 			EAL_LOG(ERR, "invalid process type: %s", args.proc_type);
 			return -1;
 		}
+		if (int_cfg->process_type == RTE_PROC_AUTO)
+			int_cfg->process_type = eal_proc_type_detect();
 	}
 
 	/* device -a/-b/-vdev options*/
@@ -1882,6 +1947,15 @@ eal_parse_args(void)
 			return -1;
 		}
 		core_parsed = 1;
+	} else if (args.lcores_remapped != NULL) {
+		if (int_cfg->process_type == RTE_PROC_SECONDARY && args.lcoreid_base == NULL) {
+			EAL_LOG(ERR, "Must use --lcoreid-base with --lcores-remapped when running secondary processes");
+			return -1;
+		}
+		/* Parse the remapped cores list */
+		if (eal_parse_lcores_remapped(args.lcores_remapped, args.lcoreid_base) < 0)
+			return -1;
+		core_parsed = 1;
 	}
 	/* service core options */
 	if (args.service_coremask != NULL) {
@@ -2187,8 +2261,6 @@ eal_adjust_config(struct internal_config *internal_cfg)
 {
 	int i;
 	struct rte_config *cfg = rte_eal_get_configuration();
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
 	if (!core_parsed)
 		eal_auto_detect_cores(cfg);
@@ -2198,9 +2270,6 @@ eal_adjust_config(struct internal_config *internal_cfg)
 		return -1;
 	}
 
-	if (internal_conf->process_type == RTE_PROC_AUTO)
-		internal_conf->process_type = eal_proc_type_detect();
-
 	compute_ctrl_threads_cpuset(internal_cfg);
 
 	/* if no memory amounts were requested, this will result in 0 and
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index dd148b7fed..976df16347 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -42,6 +42,8 @@ OPT_STR_ARG("--huge-unlink", NULL, "Unlink hugetlbfs files on exit (existing|alw
 BOOL_ARG("--in-memory", NULL, "DPDK should not create shared mmap files in filesystem  (disables secondary process support)", in_memory)
 STR_ARG("--iova-mode", NULL, "IOVA mapping mode, physical (pa)/virtual (va)", iova_mode)
 STR_ARG("--lcores", "-l", "List of CPU cores to use", lcores)
+STR_ARG("--lcores-remapped", "-L", "List of cores to use, assigning each a sequential lcore ID (start 0 by default)", lcores_remapped)
+STR_ARG("--lcoreid-base", NULL, "Number remapped lcores from <N>, rather than 0 (e.g. for secondary processes)", lcoreid_base)
 BOOL_ARG("--legacy-mem", NULL, "Enable legacy memory behavior", legacy_mem)
 OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color)
 STR_ARG("--log-level", NULL, "Log level for loggers; use log-level=help for list of log types and levels", log_level)
-- 
2.48.1

