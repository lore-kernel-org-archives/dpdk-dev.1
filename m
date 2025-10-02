Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC276CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6853640EE3;
	Thu,  2 Oct 2025 19:43:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 77A7F40EAB
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427017; x=1790963017;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tiG2V0gNZ9UFmLM8U5tsgHxG30tik0zDRCMG6bLFk+w=;
 b=TlJRtbg78V8Mmwxnp7T9bktwLSXTy7Bkb5EMelCqVX6sF/w+YMptKfRP
 yaYPHsVc1Nc4hkNXkZIuYRFbSTLOYhP//YOZWiT76t5Y1dQ4DF6x8HUzE
 xmRf4gRXdRTkR5Oz9LhH1uTYbIkEhWxxsVWmhAUJWlZLIYBURVsXoQD2e
 5Lc2jbNnpJwSlweBa8D7Tnjzwh2VxBgS3X6Ouee+CH5HjkloJ1lB59ek4
 eHxqWN6SDW5QkQTM1k14ggclHgtvHrP9UeULQaw8D3+wEyTk4Q/8iRNv2
 VTYu/4CO/tM69y/JZC2K22CzVByVh5zTHBIl5hvNB/DeeRfhKoLUBFGDF w==;
X-CSE-ConnectionGUID: HIxvMYDsTSScxRFL1BVSdg==
X-CSE-MsgGUID: OSA8RIUGRA2Y0Gl/MStrSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271866"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271866"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:36 -0700
X-CSE-ConnectionGUID: a0WZwIUNS22nbxNnYKHraQ==
X-CSE-MsgGUID: 8+gKj6aJQvKdjm/oGR15Fg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 10/18] eal: combine parameter validation checks
Date: Thu,  2 Oct 2025 18:43:07 +0100
Message-ID: <20251002174315.962992-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251002174315.962992-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
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

Remove the separate function to check combinations of cmdline
parameters. Instead, just do those checks when parsing the parameters
since we have all info about what parameters are provided at that point.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_memory.c  |   3 +-
 lib/eal/common/eal_common_options.c | 262 +++++++++++-----------------
 lib/eal/common/eal_options.h        | 107 ------------
 lib/eal/linux/eal.c                 |   5 +-
 lib/eal/linux/eal_memory.c          |   2 +-
 5 files changed, 106 insertions(+), 273 deletions(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 38ccc734e8..c62edf5e55 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -258,8 +258,7 @@ eal_memseg_list_alloc(struct rte_memseg_list *msl, int reserve_flags)
 		 * including common code, so don't duplicate the message.
 		 */
 		if (rte_errno == EADDRNOTAVAIL)
-			EAL_LOG(ERR, "Cannot reserve %llu bytes at [%p] - "
-				"please use '--" OPT_BASE_VIRTADDR "' option",
+			EAL_LOG(ERR, "Cannot reserve %llu bytes at [%p] - please use '--base-virtaddr' option",
 				(unsigned long long)mem_sz, msl->base_va);
 #endif
 		return -1;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index e3e3deb7f4..b6aeeadd8d 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -251,7 +251,6 @@ struct device_option {
 static struct device_option_list devopt_list =
 TAILQ_HEAD_INITIALIZER(devopt_list);
 
-static int main_lcore_parsed;
 static int core_parsed;
 
 /* Returns rte_usage_hook_t */
@@ -764,15 +763,6 @@ eal_parse_service_coremask(const char *coremask)
 		for (j = 0; j < BITS_PER_HEX && idx < RTE_MAX_LCORE;
 				j++, idx++) {
 			if ((1 << j) & val) {
-				/* handle main lcore already parsed */
-				uint32_t lcore = idx;
-				if (main_lcore_parsed &&
-						cfg->main_lcore == lcore) {
-					EAL_LOG(ERR,
-						"lcore %u is main lcore, cannot use as service core",
-						idx);
-					return -1;
-				}
 
 				if (eal_cpu_detected(idx) == 0) {
 					EAL_LOG(ERR,
@@ -995,15 +985,6 @@ eal_parse_service_corelist(const char *corelist)
 				min = idx;
 			for (idx = min; idx <= max; idx++) {
 				if (cfg->lcore_role[idx] != ROLE_SERVICE) {
-					/* handle main lcore already parsed */
-					uint32_t lcore = idx;
-					if (cfg->main_lcore == lcore &&
-							main_lcore_parsed) {
-						EAL_LOG(ERR,
-							"Error: lcore %u is main lcore, cannot use as service core",
-							idx);
-						return -1;
-					}
 					if (cfg->lcore_role[idx] == ROLE_RTE)
 						taken_lcore_count++;
 
@@ -1043,12 +1024,15 @@ eal_parse_main_lcore(const char *arg)
 		return -1;
 	if (cfg->main_lcore >= RTE_MAX_LCORE)
 		return -1;
-	main_lcore_parsed = 1;
 
 	/* ensure main core is not used as service core */
 	if (lcore_config[cfg->main_lcore].core_role == ROLE_SERVICE) {
-		EAL_LOG(ERR,
-			"Error: Main lcore is used as a service core");
+		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
+		return -1;
+	}
+	/* check that we have the core recorded in the core list */
+	if (cfg->lcore_role[cfg->main_lcore] != ROLE_RTE) {
+		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
 
@@ -1343,11 +1327,11 @@ eal_log_usage(void)
 	rte_log_list_types(stdout, "\t");
 	printf("\n");
 	printf("Syntax using globbing pattern:     ");
-	printf("--"OPT_LOG_LEVEL" pattern:level\n");
+	printf("--log-level pattern:level\n");
 	printf("Syntax using regular expression:   ");
-	printf("--"OPT_LOG_LEVEL" regexp,level\n");
+	printf("--log-level regexp,level\n");
 	printf("Syntax for the global level:       ");
-	printf("--"OPT_LOG_LEVEL" level\n");
+	printf("--log-level level\n");
 	printf("Logs are emitted if allowed by both global and specific levels.\n");
 	printf("\n");
 	printf("Log level can be a number or the first letters of its name:\n");
@@ -1627,7 +1611,7 @@ eal_parse_huge_unlink(const char *arg, struct hugepage_file_discipline *out)
 		return 0;
 	}
 	if (strcmp(arg, HUGE_UNLINK_NEVER) == 0) {
-		EAL_LOG(WARNING, "Using --"OPT_HUGE_UNLINK"="
+		EAL_LOG(WARNING, "Using --huge-unlink="
 			HUGE_UNLINK_NEVER" may create data leaks.");
 		out->unlink_existing = false;
 		return 0;
@@ -1807,6 +1791,7 @@ int
 eal_parse_args(void)
 {
 	struct internal_config *int_cfg = eal_get_internal_configuration();
+	struct rte_config *rte_cfg = rte_eal_get_configuration();
 	struct arg_list_elem *arg;
 
 	/* check for conflicting options */
@@ -1832,19 +1817,62 @@ eal_parse_args(void)
 	}
 	/* can't have both -m and --socket-mem */
 	if (args.memory_size != NULL && args.numa_mem != NULL) {
-		EAL_LOG(ERR, "Options -m and --socket-mem can't be used at the same time");
+		EAL_LOG(ERR, "Options -m and --numa-mem can't be used at the same time");
+		return -1;
+	}
+	/* can't use both no-huge and socket-mem */
+	if (args.no_huge && args.numa_mem) {
+		EAL_LOG(ERR, "Options --no-huge and --numa-mem can't be used at the same time");
+		return -1;
+	}
+	/* can't use no-huge and huge-worker-stack */
+	if (args.huge_worker_stack != NULL && args.no_huge) {
+		EAL_LOG(ERR, "Options --no-huge and --huge-worker-stack can't be used at the same time");
+		return -1;
+	}
+	/* can't use socket-limit and legacy-mem */
+	if (args.numa_limit != NULL && args.legacy_mem) {
+		EAL_LOG(ERR, "Options --numa-limit and --legacy-mem can't be used at the same time");
+		return -1;
+	}
+	/* can't use legacy-mem and in-memory */
+	if (args.legacy_mem && args.in_memory) {
+		EAL_LOG(ERR, "Options --legacy-mem and --in-memory can't be used at the same time");
+		return -1;
+	}
+	/* can't use legacy-mem and match-allocations */
+	if (args.legacy_mem && args.match_allocations) {
+		EAL_LOG(ERR, "Options --legacy-mem and --match-allocations can't be used at the same time");
+		return -1;
+	}
+	/* can't use no-huge and match-allocations */
+	if (args.no_huge && args.match_allocations) {
+		EAL_LOG(ERR, "Options --no-huge and --match-allocations can't be used at the same time");
+		return -1;
+	}
+	/* can't use no-huge and huge-unlink */
+	if (args.no_huge && args.huge_unlink) {
+		EAL_LOG(ERR, "Options --no-huge and --huge-unlink can't be used at the same time");
+		return -1;
+	}
+	/* can't use single-file-segments and huge-unlink */
+	if (args.single_file_segments && args.huge_unlink) {
+		EAL_LOG(ERR, "Options --single-file-segments and --huge-unlink can't be used at the same time");
+		return -1;
+	}
+	/* can't use in-memory and huge-unlink */
+	if (args.in_memory && args.huge_unlink) {
+		EAL_LOG(ERR, "Options --in-memory and --huge-unlink can't be used at the same time");
 		return -1;
 	}
 
-	/* parse options */
 	/* print version before anything else */
-	if (args.version) {
-		/* since message is explicitly requested by user, we write message
-		 * at highest log level so it can always be seen even if info or
-		 * warning messages are disabled
-		 */
+	/* since message is explicitly requested by user, we write message
+	 * at highest log level so it can always be seen even if info or
+	 * warning messages are disabled
+	 */
+	if (args.version)
 		EAL_LOG(CRIT, "RTE Version: '%s'", rte_version());
-	}
 
 	/* parse the process type */
 	if (args.proc_type != NULL) {
@@ -1870,7 +1898,7 @@ eal_parse_args(void)
 		if (eal_plugin_add(arg->arg) < 0)
 			return -1;
 
-	/* parse the coremask /core-list */
+	/* parse the core list arguments */
 	if (args.coremask != NULL) {
 		int lcore_indexes[RTE_MAX_LCORE];
 
@@ -1894,13 +1922,6 @@ eal_parse_args(void)
 		}
 		core_parsed = 1;
 	}
-	if (args.main_lcore != NULL) {
-		if (eal_parse_main_lcore(args.main_lcore) < 0) {
-			EAL_LOG(ERR, "invalid main-lcore parameter");
-			return -1;
-		}
-	}
-
 	/* service core options */
 	if (args.service_coremask != NULL) {
 		if (eal_parse_service_coremask(args.service_coremask) < 0) {
@@ -1915,6 +1936,17 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
+	if (args.main_lcore != NULL) {
+		if (eal_parse_main_lcore(args.main_lcore) < 0)
+			return -1;
+	} else {
+		/* default main lcore is the first one */
+		rte_cfg->main_lcore = rte_get_next_lcore(-1, 0, 0);
+		if (rte_cfg->main_lcore >= RTE_MAX_LCORE) {
+			EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
+			return -1;
+		}
+	}
 
 	/* memory options */
 	if (args.memory_size != NULL) {
@@ -1936,14 +1968,6 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
-	if (args.huge_unlink != NULL) {
-		if (args.huge_unlink == (void *)1)
-			args.huge_unlink = NULL;
-		if (eal_parse_huge_unlink(args.huge_unlink, &int_cfg->hugepage_file) < 0) {
-			EAL_LOG(ERR, "invalid huge-unlink parameter");
-			return -1;
-		}
-	}
 	if (args.no_huge) {
 		int_cfg->no_hugetlbfs = 1;
 		/* no-huge is legacy mem */
@@ -1955,11 +1979,18 @@ eal_parse_args(void)
 		int_cfg->no_shconf = 1;
 		int_cfg->hugepage_file.unlink_before_mapping = true;
 	}
-	if (args.legacy_mem)
+	if (args.legacy_mem) {
 		int_cfg->legacy_mem = 1;
+		if (args.memory_size == NULL && args.numa_mem == NULL)
+			EAL_LOG(NOTICE, "Static memory layout is selected, amount of reserved memory can be adjusted with -m or --socket-mem");
+	}
 	if (args.single_file_segments)
 		int_cfg->single_file_segments = 1;
 	if (args.huge_dir != NULL) {
+		if (strlen(args.huge_dir) < 1) {
+			EAL_LOG(ERR, "Invalid hugepage dir parameter");
+			return -1;
+		}
 		free(int_cfg->hugepage_dir);  /* free old hugepage dir */
 		int_cfg->hugepage_dir = strdup(args.huge_dir);
 		if (int_cfg->hugepage_dir == NULL) {
@@ -1968,6 +1999,14 @@ eal_parse_args(void)
 		}
 	}
 	if (args.file_prefix != NULL) {
+		if (strlen(args.file_prefix) < 1) {
+			EAL_LOG(ERR, "Invalid file prefix parameter");
+			return -1;
+		}
+		if (strchr(args.file_prefix, '%') != NULL) {
+			EAL_LOG(ERR, "Invalid char, '%%', in file_prefix parameter");
+			return -1;
+		}
 		free(int_cfg->hugefile_prefix);  /* free old file prefix */
 		int_cfg->hugefile_prefix = strdup(args.file_prefix);
 		if (int_cfg->hugefile_prefix == NULL) {
@@ -1975,6 +2014,14 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
+	if (args.huge_unlink != NULL) {
+		if (args.huge_unlink == (void *)1)
+			args.huge_unlink = NULL;
+		if (eal_parse_huge_unlink(args.huge_unlink, &int_cfg->hugepage_file) < 0) {
+			EAL_LOG(ERR, "invalid huge-unlink parameter");
+			return -1;
+		}
+	}
 	if (args.numa_mem != NULL) {
 		if (eal_parse_socket_arg(args.numa_mem, int_cfg->numa_mem) < 0) {
 			EAL_LOG(ERR, "invalid numa-mem parameter: '%s'", args.numa_mem);
@@ -2092,6 +2139,10 @@ eal_parse_args(void)
 			EAL_LOG(ERR, "failed to allocate memory for mbuf pool ops name parameter");
 			return -1;
 		}
+		if (strlen(int_cfg->user_mbuf_pool_ops_name) < 1) {
+			EAL_LOG(ERR, "Invalid mbuf pool ops name parameter");
+			return -1;
+		}
 	}
 
 #ifndef RTE_EXEC_ENV_WINDOWS
@@ -2110,11 +2161,6 @@ eal_parse_args(void)
 		return -1;
 	}
 
-	if (eal_check_common_options(int_cfg) != 0) {
-		EAL_LOG(ERR, "Checking common options failed");
-		return -1;
-	}
-
 	return 0;
 }
 
@@ -2194,14 +2240,6 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	if (internal_conf->process_type == RTE_PROC_AUTO)
 		internal_conf->process_type = eal_proc_type_detect();
 
-	/* default main lcore is the first one */
-	if (!main_lcore_parsed) {
-		cfg->main_lcore = rte_get_next_lcore(-1, 0, 0);
-		if (cfg->main_lcore >= RTE_MAX_LCORE)
-			return -1;
-		lcore_config[cfg->main_lcore].core_role = ROLE_RTE;
-	}
-
 	compute_ctrl_threads_cpuset(internal_cfg);
 
 	/* if no memory amounts were requested, this will result in 0 and
@@ -2212,102 +2250,6 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	return 0;
 }
 
-int
-eal_check_common_options(struct internal_config *internal_cfg)
-{
-	struct rte_config *cfg = rte_eal_get_configuration();
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	if (cfg->lcore_role[cfg->main_lcore] != ROLE_RTE) {
-		EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
-		return -1;
-	}
-
-	if (internal_cfg->process_type == RTE_PROC_INVALID) {
-		EAL_LOG(ERR, "Invalid process type specified");
-		return -1;
-	}
-	if (internal_cfg->hugefile_prefix != NULL &&
-			strlen(internal_cfg->hugefile_prefix) < 1) {
-		EAL_LOG(ERR, "Invalid length of --" OPT_FILE_PREFIX " option");
-		return -1;
-	}
-	if (internal_cfg->hugepage_dir != NULL &&
-			strlen(internal_cfg->hugepage_dir) < 1) {
-		EAL_LOG(ERR, "Invalid length of --" OPT_HUGE_DIR" option");
-		return -1;
-	}
-	if (internal_cfg->user_mbuf_pool_ops_name != NULL &&
-			strlen(internal_cfg->user_mbuf_pool_ops_name) < 1) {
-		EAL_LOG(ERR, "Invalid length of --" OPT_MBUF_POOL_OPS_NAME" option");
-		return -1;
-	}
-	if (strchr(eal_get_hugefile_prefix(), '%') != NULL) {
-		EAL_LOG(ERR, "Invalid char, '%%', in --"OPT_FILE_PREFIX" "
-			"option");
-		return -1;
-	}
-	if (internal_cfg->no_hugetlbfs && internal_cfg->force_numa == 1) {
-		EAL_LOG(ERR, "Option --"OPT_SOCKET_MEM" cannot "
-			"be specified together with --"OPT_NO_HUGE);
-		return -1;
-	}
-	if (internal_cfg->no_hugetlbfs &&
-			internal_cfg->hugepage_file.unlink_before_mapping &&
-			!internal_cfg->in_memory) {
-		EAL_LOG(ERR, "Option --"OPT_HUGE_UNLINK" cannot "
-			"be specified together with --"OPT_NO_HUGE);
-		return -1;
-	}
-	if (internal_cfg->no_hugetlbfs &&
-			internal_cfg->huge_worker_stack_size != 0) {
-		EAL_LOG(ERR, "Option --"OPT_HUGE_WORKER_STACK" cannot "
-			"be specified together with --"OPT_NO_HUGE);
-		return -1;
-	}
-	if (internal_conf->force_numa_limits && internal_conf->legacy_mem) {
-		EAL_LOG(ERR, "Option --"OPT_NUMA_LIMIT
-			" is only supported in non-legacy memory mode");
-	}
-	if (internal_cfg->single_file_segments &&
-			internal_cfg->hugepage_file.unlink_before_mapping &&
-			!internal_cfg->in_memory) {
-		EAL_LOG(ERR, "Option --"OPT_SINGLE_FILE_SEGMENTS" is "
-			"not compatible with --"OPT_HUGE_UNLINK);
-		return -1;
-	}
-	if (!internal_cfg->hugepage_file.unlink_existing &&
-			internal_cfg->in_memory) {
-		EAL_LOG(ERR, "Option --"OPT_IN_MEMORY" is not compatible "
-			"with --"OPT_HUGE_UNLINK"="HUGE_UNLINK_NEVER);
-		return -1;
-	}
-	if (internal_cfg->legacy_mem &&
-			internal_cfg->in_memory) {
-		EAL_LOG(ERR, "Option --"OPT_LEGACY_MEM" is not compatible "
-				"with --"OPT_IN_MEMORY);
-		return -1;
-	}
-	if (internal_cfg->legacy_mem && internal_cfg->match_allocations) {
-		EAL_LOG(ERR, "Option --"OPT_LEGACY_MEM" is not compatible "
-				"with --"OPT_MATCH_ALLOCATIONS);
-		return -1;
-	}
-	if (internal_cfg->no_hugetlbfs && internal_cfg->match_allocations) {
-		EAL_LOG(ERR, "Option --"OPT_NO_HUGE" is not compatible "
-				"with --"OPT_MATCH_ALLOCATIONS);
-		return -1;
-	}
-	if (internal_cfg->legacy_mem && internal_cfg->memory == 0) {
-		EAL_LOG(NOTICE, "Static memory layout is selected, "
-			"amount of reserved memory can be adjusted with "
-			"-m or --"OPT_NUMA_MEM);
-	}
-
-	return 0;
-}
-
 RTE_EXPORT_SYMBOL(rte_vect_get_max_simd_bitwidth)
 uint16_t
 rte_vect_get_max_simd_bitwidth(void)
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index fd28111e73..4a8a0f1df7 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -9,118 +9,11 @@
 
 struct rte_tel_data;
 
-enum {
-	/* long options mapped to a short option */
-#define OPT_HELP              "help"
-	OPT_HELP_NUM            = 'h',
-#define OPT_DEV_ALLOW	      "allow"
-	OPT_DEV_ALLOW_NUM       = 'a',
-#define OPT_DEV_BLOCK         "block"
-	OPT_DEV_BLOCK_NUM      = 'b',
-#define OPT_COREMASK          "coremask"
-	OPT_COREMASK_NUM       = 'c',
-#define OPT_DRIVER_PATH       "driver-path"
-	OPT_DRIVER_PATH_NUM    = 'd',
-#define OPT_LCORES            "lcores"
-	OPT_LCORES_NUM         = 'l',
-#define OPT_MEMORY_SIZE       "memory-size"
-	OPT_MEMORY_SIZE_NUM    = 'm',
-#define OPT_MEMORY_CHANNELS   "memory-channels"
-	OPT_MEMORY_CHANNELS_NUM = 'n',
-#define OPT_MEMORY_RANKS     "memory-ranks"
-	OPT_MEMORY_RANKS_NUM   = 'r',
-#define OPT_SERVICE_COREMASK  "service-coremask"
-	OPT_SERVICE_COREMASK_NUM = 's',
-#define OPT_SERVICE_CORELIST  "service-corelist"
-	OPT_SERVICE_CORELIST_NUM = 'S',
-#define OPT_VERSION           "version"
-	OPT_VERSION_NUM        = 'v',
-
-	/* first long only option value must be >= 256, so that we won't
-	 * conflict with short options */
-	OPT_LONG_MIN_NUM = 256,
-#define OPT_BASE_VIRTADDR     "base-virtaddr"
-	OPT_BASE_VIRTADDR_NUM,
-#define OPT_CREATE_UIO_DEV    "create-uio-dev"
-	OPT_CREATE_UIO_DEV_NUM,
-#define OPT_FILE_PREFIX       "file-prefix"
-	OPT_FILE_PREFIX_NUM,
-#define OPT_HUGE_DIR          "huge-dir"
-	OPT_HUGE_DIR_NUM,
-#define OPT_HUGE_UNLINK       "huge-unlink"
-	OPT_HUGE_UNLINK_NUM,
-#define OPT_LOG_COLOR	      "log-color"
-	OPT_LOG_COLOR_NUM,
-#define OPT_LOG_LEVEL         "log-level"
-	OPT_LOG_LEVEL_NUM,
-#define OPT_LOG_TIMESTAMP     "log-timestamp"
-	OPT_LOG_TIMESTAMP_NUM,
-#define OPT_TRACE             "trace"
-	OPT_TRACE_NUM,
-#define OPT_TRACE_DIR         "trace-dir"
-	OPT_TRACE_DIR_NUM,
-#define OPT_TRACE_BUF_SIZE    "trace-bufsz"
-	OPT_TRACE_BUF_SIZE_NUM,
-#define OPT_TRACE_MODE        "trace-mode"
-	OPT_TRACE_MODE_NUM,
-#define OPT_MAIN_LCORE        "main-lcore"
-	OPT_MAIN_LCORE_NUM,
-#define OPT_MBUF_POOL_OPS_NAME "mbuf-pool-ops-name"
-	OPT_MBUF_POOL_OPS_NAME_NUM,
-#define OPT_PROC_TYPE         "proc-type"
-	OPT_PROC_TYPE_NUM,
-#define OPT_NO_HPET           "no-hpet"
-	OPT_NO_HPET_NUM,
-#define OPT_NO_HUGE           "no-huge"
-	OPT_NO_HUGE_NUM,
-#define OPT_NO_PCI            "no-pci"
-	OPT_NO_PCI_NUM,
-#define OPT_NO_SHCONF         "no-shconf"
-	OPT_NO_SHCONF_NUM,
-#define OPT_IN_MEMORY         "in-memory"
-	OPT_IN_MEMORY_NUM,
-#define OPT_SOCKET_MEM        "socket-mem"
-#define OPT_NUMA_MEM          "numa-mem"
-	OPT_NUMA_MEM_NUM,
-#define OPT_SOCKET_LIMIT      "socket-limit"
-#define OPT_NUMA_LIMIT        "numa-limit"
-	OPT_NUMA_LIMIT_NUM,
-#define OPT_SYSLOG            "syslog"
-	OPT_SYSLOG_NUM,
-#define OPT_VDEV              "vdev"
-	OPT_VDEV_NUM,
-#define OPT_VFIO_INTR         "vfio-intr"
-	OPT_VFIO_INTR_NUM,
-#define OPT_VFIO_VF_TOKEN     "vfio-vf-token"
-	OPT_VFIO_VF_TOKEN_NUM,
-#define OPT_VMWARE_TSC_MAP    "vmware-tsc-map"
-	OPT_VMWARE_TSC_MAP_NUM,
-#define OPT_LEGACY_MEM    "legacy-mem"
-	OPT_LEGACY_MEM_NUM,
-#define OPT_SINGLE_FILE_SEGMENTS    "single-file-segments"
-	OPT_SINGLE_FILE_SEGMENTS_NUM,
-#define OPT_IOVA_MODE          "iova-mode"
-	OPT_IOVA_MODE_NUM,
-#define OPT_MATCH_ALLOCATIONS  "match-allocations"
-	OPT_MATCH_ALLOCATIONS_NUM,
-#define OPT_TELEMETRY         "telemetry"
-	OPT_TELEMETRY_NUM,
-#define OPT_NO_TELEMETRY      "no-telemetry"
-	OPT_NO_TELEMETRY_NUM,
-#define OPT_FORCE_MAX_SIMD_BITWIDTH  "force-max-simd-bitwidth"
-	OPT_FORCE_MAX_SIMD_BITWIDTH_NUM,
-#define OPT_HUGE_WORKER_STACK  "huge-worker-stack"
-	OPT_HUGE_WORKER_STACK_NUM,
-
-	OPT_LONG_MAX_NUM
-};
-
 int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
 int eal_adjust_config(struct internal_config *internal_cfg);
 int eal_cleanup_config(struct internal_config *internal_cfg);
-int eal_check_common_options(struct internal_config *internal_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
 int eal_save_args(int argc, char **argv);
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 3359f29e8b..1b4372323d 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -329,9 +329,8 @@ rte_eal_config_reattach(void)
 	if (mem_config == MAP_FAILED || mem_config != rte_mem_cfg_addr) {
 		if (mem_config != MAP_FAILED) {
 			/* errno is stale, don't use */
-			EAL_LOG(ERR, "Cannot mmap memory for rte_config at [%p], got [%p]"
-				" - please use '--" OPT_BASE_VIRTADDR
-				"' option", rte_mem_cfg_addr, mem_config);
+			EAL_LOG(ERR, "Cannot mmap memory for rte_config at [%p], got [%p] - please use '--base-virtaddr' option",
+				 rte_mem_cfg_addr, mem_config);
 			munmap(mem_config, sizeof(struct rte_mem_config));
 			return -1;
 		}
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index ee964446c7..8e1763e890 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1960,7 +1960,7 @@ rte_eal_memseg_init(void)
 	if (!internal_conf->legacy_mem && rte_socket_count() > 1) {
 		EAL_LOG(WARNING, "DPDK is running on a NUMA system, but is compiled without NUMA support.");
 		EAL_LOG(WARNING, "This will have adverse consequences for performance and usability.");
-		EAL_LOG(WARNING, "Please use --"OPT_LEGACY_MEM" option, or recompile with NUMA support.");
+		EAL_LOG(WARNING, "Please use --legacy-mem option, or recompile with NUMA support.");
 	}
 #endif
 
-- 
2.48.1

