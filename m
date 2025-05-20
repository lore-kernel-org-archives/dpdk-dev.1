Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9188FC3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 16:41:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F33E140E09;
	Tue, 20 May 2025 18:40:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8C2E240DCF
 for <dev@dpdk.org>; Tue, 20 May 2025 18:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747759252; x=1779295252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ct3mlz1uilWfjChrTlNCofs7IninXClWHzDKT9Jy38I=;
 b=Of2Y6xQmuU7KWqfz0O4Tg42NITMv7CL6Y8Jpu1Ucyn5XVx3VP0y7cxNZ
 79jm3Cx3j836Ej1ac2fz9ns60vtMaPhvk1i9CHILRCEm29CQ4FI3Udx74
 bol42+mcO9sw0/Rg7xbN079qtfiia6/kFyu7c+UKvODVyTIcqpMV0bGd9
 U6JSF4kn+kEZPSlq46aPCVAW3YCtuIGU0cpPDCTsIpOzoH0wLHXAD2PWN
 aXVggSXO2wFbKUT0OABe0m9weAyG1LWaVbyvHhGPy8vXB+Ax/w0jv8nt0
 SDjlztJVQZkNDY3Gu05tLKwPC7J/ZdDEIydNB3sGRRfI0xDuVHGJJXP2y Q==;
X-CSE-ConnectionGUID: vfErac2rQWe4kanlf15o/g==
X-CSE-MsgGUID: 1j8bzV8jRWKUvCTJuldalA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37320483"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="37320483"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 09:40:52 -0700
X-CSE-ConnectionGUID: bvgYTfCrT3ewlPTS4gvm0g==
X-CSE-MsgGUID: v66bNLcbQR2pI9lIiMF+8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="170759493"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 09:40:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC PATCH 6/7] eal: combine parameter validation checks
Date: Tue, 20 May 2025 17:40:23 +0100
Message-ID: <20250520164025.2055721-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520164025.2055721-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
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
 lib/eal/common/eal_common_options.c | 332 ++++++++++++----------------
 lib/eal/common/eal_options.h        | 105 ---------
 lib/eal/linux/eal.c                 |   5 +-
 4 files changed, 140 insertions(+), 305 deletions(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index a2f64408f4..b4ba9a9d8b 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -252,8 +252,7 @@ eal_memseg_list_alloc(struct rte_memseg_list *msl, int reserve_flags)
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
index bb158a4983..50a2b139db 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -528,7 +528,6 @@ struct device_option {
 static struct device_option_list devopt_list =
 TAILQ_HEAD_INITIALIZER(devopt_list);
 
-static int main_lcore_parsed;
 static int core_parsed;
 
 /* Allow the application to print its usage message too if set */
@@ -1021,15 +1020,6 @@ eal_parse_service_coremask(const char *coremask)
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
@@ -1252,15 +1242,6 @@ eal_parse_service_corelist(const char *corelist)
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
 
@@ -1300,12 +1281,15 @@ eal_parse_main_lcore(const char *arg)
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
 
@@ -1600,11 +1584,11 @@ eal_log_usage(void)
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
@@ -1884,7 +1868,7 @@ eal_parse_huge_unlink(const char *arg, struct hugepage_file_discipline *out)
 		return 0;
 	}
 	if (strcmp(arg, HUGE_UNLINK_NEVER) == 0) {
-		EAL_LOG(WARNING, "Using --"OPT_HUGE_UNLINK"="
+		EAL_LOG(WARNING, "Using --huge-unlink="
 			HUGE_UNLINK_NEVER" may create data leaks.");
 		out->unlink_existing = false;
 		return 0;
@@ -2057,7 +2041,8 @@ eal_parse_huge_worker_stack(const char *arg)
 int
 eal_parse_args(void)
 {
-	struct internal_config *conf = eal_get_internal_configuration();
+	struct internal_config *int_cfg = eal_get_internal_configuration();
+	struct rte_config *rte_cfg = rte_eal_get_configuration();
 	struct arg_list_elem *arg;
 
 	/* check for conflicting options */
@@ -2086,21 +2071,64 @@ eal_parse_args(void)
 		EAL_LOG(ERR, "Options -m and --socket-mem can't be used at the same time");
 		return -1;
 	}
+	/* can't use both no-huge and socket-mem */
+	if (args.no_huge && args.socket_mem) {
+		EAL_LOG(ERR, "Options --no-huge and --socket-mem can't be used at the same time");
+		return -1;
+	}
+	/* can't use no-huge and huge-worker-stack */
+	if (args.huge_worker_stack != NULL && args.no_huge) {
+		EAL_LOG(ERR, "Options --no-huge and --huge-worker-stack can't be used at the same time");
+		return -1;
+	}
+	/* can't use socket-limit and legacy-mem */
+	if (args.socket_limit != NULL && args.legacy_mem) {
+		EAL_LOG(ERR, "Options --socket-limit and --legacy-mem can't be used at the same time");
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
+		return -1;
+	}
 
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
-		conf->process_type = eal_parse_proc_type(args.proc_type);
-		if (conf->process_type == RTE_PROC_INVALID) {
+		int_cfg->process_type = eal_parse_proc_type(args.proc_type);
+		if (int_cfg->process_type == RTE_PROC_INVALID) {
 			EAL_LOG(ERR, "invalid process type: %s", args.proc_type);
 			return -1;
 		}
@@ -2121,7 +2149,7 @@ eal_parse_args(void)
 		if (eal_plugin_add(arg->arg) < 0)
 			return -1;
 
-	/* parse the coremask /core-list */
+	/* parse the core list arguments */
 	if (args.coremask != NULL) {
 		int lcore_indexes[RTE_MAX_LCORE];
 
@@ -2145,13 +2173,6 @@ eal_parse_args(void)
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
@@ -2166,71 +2187,97 @@ eal_parse_args(void)
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
-		conf->memory = atoi(args.memory_size);
-		conf->memory *= 1024ULL;
-		conf->memory *= 1024ULL;
+		int_cfg->memory = atoi(args.memory_size);
+		int_cfg->memory *= 1024ULL;
+		int_cfg->memory *= 1024ULL;
 	}
 	if (args.memory_channels != NULL) {
-		conf->force_nchannel = atoi(args.memory_channels);
-		if (conf->force_nchannel == 0) {
+		int_cfg->force_nchannel = atoi(args.memory_channels);
+		if (int_cfg->force_nchannel == 0) {
 			EAL_LOG(ERR, "invalid memory channel parameter");
 			return -1;
 		}
 	}
 	if (args.memory_ranks != NULL) {
-		conf->force_nrank = atoi(args.memory_ranks);
-		if (conf->force_nrank == 0 || conf->force_nrank > 16) {
+		int_cfg->force_nrank = atoi(args.memory_ranks);
+		if (int_cfg->force_nrank == 0 || int_cfg->force_nrank > 16) {
 			EAL_LOG(ERR, "invalid memory rank parameter");
 			return -1;
 		}
 	}
-	if (args.huge_unlink != NULL) {
-		if (args.huge_unlink == (void *)1)
-			args.huge_unlink = NULL;
-		if (eal_parse_huge_unlink(args.huge_unlink, &conf->hugepage_file) < 0) {
-			EAL_LOG(ERR, "invalid huge-unlink parameter");
-			return -1;
-		}
-	}
 	if (args.no_huge) {
-		conf->no_hugetlbfs = 1;
+		int_cfg->no_hugetlbfs = 1;
 		/* no-huge is legacy mem */
-		conf->legacy_mem = 1;
+		int_cfg->legacy_mem = 1;
 	}
 	if (args.in_memory) {
-		conf->in_memory = 1;
+		int_cfg->in_memory = 1;
 		/* in-memory is a superset of noshconf and huge-unlink */
-		conf->no_shconf = 1;
-		conf->hugepage_file.unlink_before_mapping = true;
+		int_cfg->no_shconf = 1;
+		int_cfg->hugepage_file.unlink_before_mapping = true;
+	}
+	if (args.legacy_mem) {
+		int_cfg->legacy_mem = 1;
+		if (args.memory_size == NULL && args.socket_mem == NULL)
+			EAL_LOG(NOTICE, "Static memory layout is selected, amount of reserved memory can be adjusted with -m or --socket-mem");
 	}
-	if (args.legacy_mem)
-		conf->legacy_mem = 1;
 	if (args.single_file_segments)
-		conf->single_file_segments = 1;
+		int_cfg->single_file_segments = 1;
 	if (args.huge_dir != NULL) {
-		free(conf->hugepage_dir);  /* free old hugepage dir */
-		conf->hugepage_dir = args.huge_dir;
+		if (strlen(args.huge_dir) < 1) {
+			EAL_LOG(ERR, "Invalid hugepage dir parameter");
+			return -1;
+		}
+		free(int_cfg->hugepage_dir);  /* free old hugepage dir */
+		int_cfg->hugepage_dir = args.huge_dir;
 	}
 	if (args.file_prefix != NULL) {
-		free(conf->hugefile_prefix);  /* free old file prefix */
-		conf->hugefile_prefix = args.file_prefix;
+		if (strlen(args.file_prefix) < 1) {
+			EAL_LOG(ERR, "Invalid file prefix parameter");
+			return -1;
+		}
+		if (strchr(args.file_prefix, '%') != NULL) {
+			EAL_LOG(ERR, "Invalid char, '%%', in file_prefix parameter");
+			return -1;
+		}
+		free(int_cfg->hugefile_prefix);  /* free old file prefix */
+		int_cfg->hugefile_prefix = args.file_prefix;
+	}
+	if (args.huge_unlink != NULL) {
+		if (args.huge_unlink == (void *)1)
+			args.huge_unlink = NULL;
+		if (eal_parse_huge_unlink(args.huge_unlink, &int_cfg->hugepage_file) < 0) {
+			EAL_LOG(ERR, "invalid huge-unlink parameter");
+			return -1;
+		}
 	}
 	if (args.socket_mem != NULL) {
-		if (eal_parse_socket_arg(args.socket_mem, conf->socket_mem) < 0) {
+		if (eal_parse_socket_arg(args.socket_mem, int_cfg->socket_mem) < 0) {
 			EAL_LOG(ERR, "invalid socket-mem parameter: '%s'", args.socket_mem);
 			return -1;
 		}
-		conf->force_sockets = 1;
+		int_cfg->force_sockets = 1;
 	}
 	if (args.socket_limit != NULL) {
-		if (eal_parse_socket_arg(args.socket_limit, conf->socket_limit) < 0) {
+		if (eal_parse_socket_arg(args.socket_limit, int_cfg->socket_limit) < 0) {
 			EAL_LOG(ERR, "invalid socket limit parameter: '%s'", args.socket_limit);
 			return -1;
 		}
-		conf->force_socket_limits = 1;
+		int_cfg->force_socket_limits = 1;
 	}
 
 	/* tracing settings, not supported on windows */
@@ -2272,19 +2319,19 @@ eal_parse_args(void)
 	 * other options above have already set them.
 	 */
 	if (args.no_pci)
-		conf->no_pci = 1;
+		int_cfg->no_pci = 1;
 	if (args.no_hpet)
-		conf->no_hpet = 1;
+		int_cfg->no_hpet = 1;
 	if (args.vmware_tsc_map)
-		conf->vmware_tsc_map = 1;
+		int_cfg->vmware_tsc_map = 1;
 	if (args.no_shconf)
-		conf->no_shconf = 1;
+		int_cfg->no_shconf = 1;
 	if (args.no_telemetry)
-		conf->no_telemetry = 1;
+		int_cfg->no_telemetry = 1;
 	if (args.match_allocations)
-		conf->match_allocations = 1;
+		int_cfg->match_allocations = 1;
 	if (args.create_uio_dev)
-		conf->create_uio_dev = 1;
+		int_cfg->create_uio_dev = 1;
 
 
 	/* other misc settings */
@@ -2329,29 +2376,28 @@ eal_parse_args(void)
 		}
 	}
 	if (args.mbuf_pool_ops_name != NULL) {
-		free(conf->user_mbuf_pool_ops_name); /* free old ops name */
-		conf->user_mbuf_pool_ops_name = args.mbuf_pool_ops_name;
+		free(int_cfg->user_mbuf_pool_ops_name); /* free old ops name */
+		int_cfg->user_mbuf_pool_ops_name = args.mbuf_pool_ops_name;
+		if (strlen(int_cfg->user_mbuf_pool_ops_name) < 1) {
+			EAL_LOG(ERR, "Invalid mbuf pool ops name parameter");
+			return -1;
+		}
 	}
 
 	/* create runtime data directory. In no_shconf mode, skip any errors */
 	if (eal_create_runtime_dir() < 0) {
-		if (conf->no_shconf == 0) {
+		if (int_cfg->no_shconf == 0) {
 			EAL_LOG(ERR, "Cannot create runtime directory");
 			return -1;
 		}
 		EAL_LOG(WARNING, "No DPDK runtime directory created");
 	}
 
-	if (eal_adjust_config(conf) != 0) {
+	if (eal_adjust_config(int_cfg) != 0) {
 		EAL_LOG(ERR, "Invalid configuration");
 		return -1;
 	}
 
-	if (eal_check_common_options(conf) != 0) {
-		EAL_LOG(ERR, "Checking common options failed");
-		return -1;
-	}
-
 	return 0;
 }
 
@@ -2426,14 +2472,6 @@ eal_adjust_config(struct internal_config *internal_cfg)
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
@@ -2444,102 +2482,6 @@ eal_adjust_config(struct internal_config *internal_cfg)
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
-	if (internal_cfg->no_hugetlbfs && internal_cfg->force_sockets == 1) {
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
-	if (internal_conf->force_socket_limits && internal_conf->legacy_mem) {
-		EAL_LOG(ERR, "Option --"OPT_SOCKET_LIMIT
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
-			"-m or --"OPT_SOCKET_MEM);
-	}
-
-	return 0;
-}
-
 RTE_EXPORT_SYMBOL(rte_vect_get_max_simd_bitwidth)
 uint16_t
 rte_vect_get_max_simd_bitwidth(void)
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 41f95c4a1d..e7431bb797 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -9,116 +9,11 @@
 
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
-	OPT_SOCKET_MEM_NUM,
-#define OPT_SOCKET_LIMIT        "socket-limit"
-	OPT_SOCKET_LIMIT_NUM,
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
index 2a68a02bfd..9c9ae88570 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -328,9 +328,8 @@ rte_eal_config_reattach(void)
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
-- 
2.48.1

