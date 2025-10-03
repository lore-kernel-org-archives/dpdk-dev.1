Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBA8CCA470
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEDB840693;
	Fri,  3 Oct 2025 10:15:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 71BBE40665
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479323; x=1791015323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hGlUtc7m7u+VvCXrD5ISpppr96r47SHbNNf+C4ftYlg=;
 b=M98KvFE+tsubjj4/1JgBkiWoCJBw0Sd+GBxhDsSI7cBz9iTsc6QZE9GM
 Xx1+wiYttHrzAsnqAK0FFWrNbN7G89mUD96RCEA3P4tyEPsJj0+fsbd6T
 HBycjcJl/YnQmJY0lN9s+o0i0MQDPJsmoGo44celhFOp5auL+Q2J1rve8
 dIYZ2gsB8H4UDfmLxema40/83Y/cY3DPBaZ189qRSvnbqMQe5D6Yc1pBn
 CPUUim/obNu3vgdQXPprhoWVooNh3oarbE9HNZa9kW1LyTVrg2k/0oPXf
 0W5G2avJZPAggpcBFBbU9QpbLzDHyvngHty8KrxemQgEdBHBVm6GHJskc g==;
X-CSE-ConnectionGUID: UbnB223VRE+/OY+4yJzANg==
X-CSE-MsgGUID: O+/JxA10SAGaxd/x4Q4+4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61473575"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="61473575"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:15:22 -0700
X-CSE-ConnectionGUID: 1DKz+a5CQDiP7p1gLeUytw==
X-CSE-MsgGUID: SYODdYfITeC/P5Ifk5OgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="184525844"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 03 Oct 2025 01:15:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 08/18] eal: gather EAL args before processing
Date: Fri,  3 Oct 2025 09:15:00 +0100
Message-ID: <20251003081510.1197166-9-bruce.richardson@intel.com>
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

DPDK traditionally has iterated through all args and processed them as
they appear in the commandline. The arg processing logic can be
simplified if instead we initially gather all arguments into a structure
which is then processed with the arguments dealt with in a fixed/known
order.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 880 ++++++++++++++--------------
 lib/eal/common/eal_options.h        |  10 +-
 lib/eal/common/eal_private.h        |  11 +
 lib/eal/freebsd/eal.c               | 164 +-----
 lib/eal/linux/eal.c                 | 379 +-----------
 lib/eal/windows/eal.c               | 113 +---
 6 files changed, 485 insertions(+), 1072 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 75d42d97aa..72df7c5b48 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -46,8 +46,7 @@
 #endif
 
 #define BITS_PER_HEX 4
-#define LCORE_OPT_LST 1
-#define LCORE_OPT_MSK 2
+#define NUMA_MEM_STRLEN (RTE_MAX_NUMA_NODES * 10)
 
 /* Allow the application to print its usage message too if set */
 static rte_usage_hook_t rte_application_usage_hook;
@@ -185,79 +184,33 @@ struct rte_argparse eal_argparse  = {
 	}
 };
 
-const char
-eal_short_options[] =
-	"a:" /* allow */
-	"b:" /* block */
-	"c:" /* coremask */
-	"s:" /* service coremask */
-	"d:" /* driver */
-	"h"  /* help */
-	"l:" /* corelist */
-	"S:" /* service corelist */
-	"m:" /* memory size */
-	"n:" /* memory channels */
-	"r:" /* memory ranks */
-	"v"  /* version */
-	;
-
-const struct option
-eal_long_options[] = {
-	{OPT_BASE_VIRTADDR,     1, NULL, OPT_BASE_VIRTADDR_NUM    },
-	{OPT_COREMASK,          1, NULL, OPT_COREMASK_NUM        },
-	{OPT_CREATE_UIO_DEV,    0, NULL, OPT_CREATE_UIO_DEV_NUM   },
-	{OPT_DRIVER_PATH,       1, NULL, OPT_DRIVER_PATH_NUM     },
-	{OPT_FILE_PREFIX,       1, NULL, OPT_FILE_PREFIX_NUM      },
-	{OPT_HELP,              0, NULL, OPT_HELP_NUM             },
-	{OPT_HUGE_DIR,          1, NULL, OPT_HUGE_DIR_NUM         },
-	{OPT_HUGE_UNLINK,       2, NULL, OPT_HUGE_UNLINK_NUM      },
-	{OPT_IOVA_MODE,	        1, NULL, OPT_IOVA_MODE_NUM        },
-	{OPT_LCORES,            1, NULL, OPT_LCORES_NUM           },
-	{OPT_LOG_COLOR,		2, NULL, OPT_LOG_COLOR_NUM	  },
-	{OPT_LOG_LEVEL,         1, NULL, OPT_LOG_LEVEL_NUM        },
-	{OPT_LOG_TIMESTAMP,     2, NULL, OPT_LOG_TIMESTAMP_NUM    },
-	{OPT_MEMORY_CHANNELS,   1, NULL, OPT_MEMORY_CHANNELS_NUM },
-	{OPT_MEMORY_RANKS,      1, NULL, OPT_MEMORY_RANKS_NUM    },
-	{OPT_MEMORY_SIZE,       1, NULL, OPT_MEMORY_SIZE_NUM     },
-	{OPT_SERVICE_CORELIST,  1, NULL, OPT_SERVICE_CORELIST_NUM },
-	{OPT_SERVICE_COREMASK,  1, NULL, OPT_SERVICE_COREMASK_NUM },
-	{OPT_TRACE,             1, NULL, OPT_TRACE_NUM            },
-	{OPT_TRACE_DIR,         1, NULL, OPT_TRACE_DIR_NUM        },
-	{OPT_TRACE_BUF_SIZE,    1, NULL, OPT_TRACE_BUF_SIZE_NUM   },
-	{OPT_TRACE_MODE,        1, NULL, OPT_TRACE_MODE_NUM       },
-	{OPT_MAIN_LCORE,        1, NULL, OPT_MAIN_LCORE_NUM       },
-	{OPT_MBUF_POOL_OPS_NAME, 1, NULL, OPT_MBUF_POOL_OPS_NAME_NUM},
-	{OPT_NO_HPET,           0, NULL, OPT_NO_HPET_NUM          },
-	{OPT_NO_HUGE,           0, NULL, OPT_NO_HUGE_NUM          },
-	{OPT_NO_PCI,            0, NULL, OPT_NO_PCI_NUM           },
-	{OPT_NO_SHCONF,         0, NULL, OPT_NO_SHCONF_NUM        },
-	{OPT_IN_MEMORY,         0, NULL, OPT_IN_MEMORY_NUM        },
-	{OPT_DEV_BLOCK,         1, NULL, OPT_DEV_BLOCK_NUM        },
-	{OPT_DEV_ALLOW,		1, NULL, OPT_DEV_ALLOW_NUM	  },
-	{OPT_PROC_TYPE,         1, NULL, OPT_PROC_TYPE_NUM        },
-	/* socket-mem/socket-limit are kept for backwards compatibility */
-	{OPT_SOCKET_MEM,        1, NULL, OPT_NUMA_MEM_NUM         },
-	{OPT_SOCKET_LIMIT,      1, NULL, OPT_NUMA_LIMIT_NUM       },
-	{OPT_NUMA_MEM,          1, NULL, OPT_NUMA_MEM_NUM         },
-	{OPT_NUMA_LIMIT,        1, NULL, OPT_NUMA_LIMIT_NUM       },
-#ifndef RTE_EXEC_ENV_WINDOWS
-	{OPT_SYSLOG,            2, NULL, OPT_SYSLOG_NUM           },
-#endif
-	{OPT_VDEV,              1, NULL, OPT_VDEV_NUM             },
-	{OPT_VFIO_INTR,         1, NULL, OPT_VFIO_INTR_NUM        },
-	{OPT_VFIO_VF_TOKEN,     1, NULL, OPT_VFIO_VF_TOKEN_NUM    },
-	{OPT_VMWARE_TSC_MAP,    0, NULL, OPT_VMWARE_TSC_MAP_NUM   },
-	{OPT_LEGACY_MEM,        0, NULL, OPT_LEGACY_MEM_NUM       },
-	{OPT_SINGLE_FILE_SEGMENTS, 0, NULL, OPT_SINGLE_FILE_SEGMENTS_NUM},
-	{OPT_MATCH_ALLOCATIONS, 0, NULL, OPT_MATCH_ALLOCATIONS_NUM},
-	{OPT_TELEMETRY,         0, NULL, OPT_TELEMETRY_NUM        },
-	{OPT_NO_TELEMETRY,      0, NULL, OPT_NO_TELEMETRY_NUM     },
-	{OPT_FORCE_MAX_SIMD_BITWIDTH, 1, NULL, OPT_FORCE_MAX_SIMD_BITWIDTH_NUM},
-	{OPT_HUGE_WORKER_STACK, 2, NULL, OPT_HUGE_WORKER_STACK_NUM     },
-	{OPT_VERSION,           0, NULL, OPT_VERSION_NUM         },
-
-	{0,                     0, NULL, 0                        }
-};
+/* function to call into argparse library to parse the passed argc/argv parameters
+ * to the eal_init_args structure.
+ */
+int
+eal_collate_args(int argc, char **argv)
+{
+	if (argc < 1 || argv == NULL)
+		return -EINVAL;
+
+	/* initialize the list of arguments */
+	memset(&args, 0, sizeof(args));
+	TAILQ_INIT(&args.allow);
+	TAILQ_INIT(&args.block);
+	TAILQ_INIT(&args.driver_path);
+	TAILQ_INIT(&args.log_level);
+	TAILQ_INIT(&args.trace);
+	TAILQ_INIT(&args.vdev);
+
+	/* parse the arguments */
+	eal_argparse.prog_name = argv[0];
+	int retval = rte_argparse_parse(&eal_argparse, argc, argv);
+	if (retval < 0)
+		return retval;
+
+	argv[retval - 1] = argv[0];
+	return retval - 1;
+}
 
 TAILQ_HEAD(shared_driver_list, shared_driver);
 
@@ -299,7 +252,6 @@ static struct device_option_list devopt_list =
 TAILQ_HEAD_INITIALIZER(devopt_list);
 
 static int main_lcore_parsed;
-static int mem_parsed;
 static int core_parsed;
 
 /* Returns rte_usage_hook_t */
@@ -323,7 +275,12 @@ rte_set_application_usage_hook(rte_usage_hook_t usage_func)
 	return old_func;
 }
 
-#ifndef RTE_EXEC_ENV_WINDOWS
+#ifdef RTE_EXEC_ENV_WINDOWS
+
+int
+eal_save_args(__rte_unused int argc, __rte_unused char **argv) { return 0; }
+
+#else /* RTE_EXEC_ENV_WINDOWS */
 static char **eal_args;
 static char **eal_app_args;
 
@@ -411,7 +368,7 @@ eal_save_args(int argc, char **argv)
 	eal_args = NULL;
 	return -1;
 }
-#endif
+#endif /* !RTE_EXEC_ENV_WINDOWS */
 
 static int
 eal_option_device_add(enum rte_devtype type, const char *optarg)
@@ -839,17 +796,6 @@ eal_parse_service_coremask(const char *coremask)
 	return 0;
 }
 
-static int
-eal_service_cores_parsed(void)
-{
-	int idx;
-	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		if (lcore_config[idx].core_role == ROLE_SERVICE)
-			return 1;
-	}
-	return 0;
-}
-
 static int
 update_lcore_config(int *cores)
 {
@@ -1676,361 +1622,487 @@ eal_parse_huge_unlink(const char *arg, struct hugepage_file_discipline *out)
 	return -1;
 }
 
-bool
-eal_option_is_log(int opt)
+/* Parse all arguments looking for log related ones */
+int
+eal_parse_log_options(void)
 {
-	switch (opt) {
-	case OPT_LOG_COLOR_NUM:
-	case OPT_LOG_LEVEL_NUM:
-	case OPT_LOG_TIMESTAMP_NUM:
-	case OPT_SYSLOG_NUM:
-		return true;
-	default:
-		return false;
+	struct arg_list_elem *arg;
+	TAILQ_FOREACH(arg, &args.log_level, next) {
+		if (eal_parse_log_level(arg->arg) < 0) {
+			EAL_LOG(ERR, "invalid log-level parameter");
+			return -1;
+		}
+	}
+	if (args.log_color != NULL) {
+		/* if value is 1, no argument specified, so pass NULL */
+		if (args.log_color == (void *)1)
+			args.log_color = NULL;
+		if (eal_log_color(args.log_color) < 0) {
+			EAL_LOG(ERR, "invalid log-color parameter");
+			return -1;
+		}
+	}
+	if (args.log_timestamp != NULL) {
+		/* similarly log_timestamp may be 1 */
+		if (args.log_timestamp == (void *)1)
+			args.log_timestamp = NULL;
+		if (eal_log_timestamp(args.log_timestamp) < 0) {
+			EAL_LOG(ERR, "invalid log-timestamp parameter");
+			return -1;
+		}
+	}
+	if (args.syslog != NULL) {
+#ifdef RTE_EXEC_ENV_WINDOWS
+		EAL_LOG(WARNING, "syslog is not supported on Windows, ignoring parameter");
+#else
+		/* also syslog parameter may be 1 */
+		if (args.syslog == (void *)1)
+			args.syslog = NULL;
+		if (eal_log_syslog(args.syslog) < 0) {
+			EAL_LOG(ERR, "invalid syslog parameter");
+			return -1;
+		}
+#endif
 	}
+	return 0;
 }
 
-/* Parse all arguments looking for log related ones */
-int
-eal_parse_log_options(int argc, char * const argv[])
+static int
+eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
 {
-	struct internal_config *internal_conf = eal_get_internal_configuration();
-	int option_index, opt;
-	const int old_optind = optind;
-	const int old_optopt = optopt;
-	const int old_opterr = opterr;
-	char *old_optarg = optarg;
-#ifdef RTE_EXEC_ENV_FREEBSD
-	const int old_optreset = optreset;
-	optreset = 1;
-#endif
+	char *arg[RTE_MAX_NUMA_NODES];
+	char *end;
+	int arg_num, i, len;
 
-	optind = 1;
-	opterr = 0;
+	len = strnlen(strval, NUMA_MEM_STRLEN);
+	if (len == NUMA_MEM_STRLEN) {
+		EAL_LOG(ERR, "--numa-mem/--socket-mem parameter is too long");
+		return -1;
+	}
 
-	while ((opt = getopt_long(argc, argv, eal_short_options,
-				  eal_long_options, &option_index)) != EOF) {
+	/* all other error cases will be caught later */
+	if (!isdigit(strval[len-1]))
+		return -1;
 
-		if (!eal_option_is_log(opt))
-			continue;
+	/* split the optarg into separate socket values */
+	arg_num = rte_strsplit(strval, len,
+			arg, RTE_MAX_NUMA_NODES, ',');
 
-		if (eal_parse_common_option(opt, optarg, internal_conf) < 0)
+	/* if split failed, or 0 arguments */
+	if (arg_num <= 0)
+		return -1;
+
+	/* parse each defined socket option */
+	errno = 0;
+	for (i = 0; i < arg_num; i++) {
+		uint64_t val;
+		end = NULL;
+		val = strtoull(arg[i], &end, 10);
+
+		/* check for invalid input */
+		if ((errno != 0)  ||
+				(arg[i][0] == '\0') || (end == NULL) || (*end != '\0'))
 			return -1;
+		val <<= 20;
+		socket_arg[i] = val;
 	}
 
-	/* restore getopt lib */
-	optind = old_optind;
-	optopt = old_optopt;
-	optarg = old_optarg;
-	opterr = old_opterr;
-#ifdef RTE_EXEC_ENV_FREEBSD
-	optreset = old_optreset;
+	return 0;
+}
+
+static int
+eal_parse_vfio_intr(const char *mode)
+{
+	struct internal_config *internal_conf =
+		eal_get_internal_configuration();
+	static struct {
+		const char *name;
+		enum rte_intr_mode value;
+	} map[] = {
+		{ "legacy", RTE_INTR_MODE_LEGACY },
+		{ "msi", RTE_INTR_MODE_MSI },
+		{ "msix", RTE_INTR_MODE_MSIX },
+	};
+
+	for (size_t i = 0; i < RTE_DIM(map); i++) {
+		if (!strcmp(mode, map[i].name)) {
+			internal_conf->vfio_intr_mode = map[i].value;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+static int
+eal_parse_vfio_vf_token(const char *vf_token)
+{
+	struct internal_config *cfg = eal_get_internal_configuration();
+	rte_uuid_t uuid;
+
+	if (!rte_uuid_parse(vf_token, uuid)) {
+		rte_uuid_copy(cfg->vfio_vf_token, uuid);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int
+eal_parse_huge_worker_stack(const char *arg)
+{
+#ifdef RTE_EXEC_ENV_WINDOWS
+	EAL_LOG(WARNING, "Cannot set worker stack size on Windows, parameter ignored");
+	RTE_SET_USED(arg);
+#else
+	struct internal_config *cfg = eal_get_internal_configuration();
+
+	if (arg == NULL || arg[0] == '\0') {
+		pthread_attr_t attr;
+		int ret;
+
+		if (pthread_attr_init(&attr) != 0) {
+			EAL_LOG(ERR, "Could not retrieve default stack size");
+			return -1;
+		}
+		ret = pthread_attr_getstacksize(&attr, &cfg->huge_worker_stack_size);
+		pthread_attr_destroy(&attr);
+		if (ret != 0) {
+			EAL_LOG(ERR, "Could not retrieve default stack size");
+			return -1;
+		}
+	} else {
+		unsigned long stack_size;
+		char *end;
+
+		errno = 0;
+		stack_size = strtoul(arg, &end, 10);
+		if (errno || end == NULL || stack_size == 0 ||
+				stack_size >= (size_t)-1 / 1024)
+			return -1;
+
+		cfg->huge_worker_stack_size = stack_size * 1024;
+	}
+
+	EAL_LOG(DEBUG, "Each worker thread will use %zu kB of DPDK memory as stack",
+		cfg->huge_worker_stack_size / 1024);
 #endif
 	return 0;
 }
 
+/* Parse the arguments given in the command line of the application */
 int
-eal_parse_common_option(int opt, const char *optarg,
-			struct internal_config *conf)
+eal_parse_args(void)
 {
-	static int b_used;
-	static int a_used;
-
-	switch (opt) {
-	case 'b':
-		if (a_used)
-			goto ba_conflict;
-		if (eal_option_device_add(RTE_DEVTYPE_BLOCKED, optarg) < 0)
+	struct internal_config *int_cfg = eal_get_internal_configuration();
+	struct arg_list_elem *arg;
+
+	/* check for conflicting options */
+	/* both -a and -b cannot be used together (one list must be empty at least) */
+	if (!TAILQ_EMPTY(&args.allow) && !TAILQ_EMPTY(&args.block)) {
+		EAL_LOG(ERR, "Options allow (-a) and block (-b) can't be used at the same time");
+		return -1;
+	}
+	/* both -l and -c cannot be used at the same time */
+	if (args.coremask != NULL && args.lcores != NULL) {
+		EAL_LOG(ERR, "Options coremask (-c) and core list (-l) can't be used at the same time");
+		return -1;
+	}
+	/* both -s and -S cannot be used at the same time */
+	if (args.service_coremask != NULL && args.service_corelist != NULL) {
+		EAL_LOG(ERR, "Options service coremask (-s) and service core list (-S) can't be used at the same time");
+		return -1;
+	}
+	/* can't have both telemetry and no-telemetry */
+	if (args.no_telemetry && args.telemetry) {
+		EAL_LOG(ERR, "Options telemetry and no-telemetry can't be used at the same time");
+		return -1;
+	}
+	/* can't have both -m and --socket-mem */
+	if (args.memory_size != NULL && args.numa_mem != NULL) {
+		EAL_LOG(ERR, "Options -m and --socket-mem can't be used at the same time");
+		return -1;
+	}
+
+	/* parse options */
+	/* print version before anything else */
+	if (args.version) {
+		/* since message is explicitly requested by user, we write message
+		 * at highest log level so it can always be seen even if info or
+		 * warning messages are disabled
+		 */
+		EAL_LOG(CRIT, "RTE Version: '%s'", rte_version());
+	}
+
+	/* parse the process type */
+	if (args.proc_type != NULL) {
+		int_cfg->process_type = eal_parse_proc_type(args.proc_type);
+		if (int_cfg->process_type == RTE_PROC_INVALID) {
+			EAL_LOG(ERR, "invalid process type: %s", args.proc_type);
 			return -1;
-		b_used = 1;
-		break;
+		}
+	}
 
-	case 'a':
-		if (b_used)
-			goto ba_conflict;
-		if (eal_option_device_add(RTE_DEVTYPE_ALLOWED, optarg) < 0)
+	/* device -a/-b/-vdev options*/
+	TAILQ_FOREACH(arg, &args.allow, next)
+		if (eal_option_device_add(RTE_DEVTYPE_ALLOWED, arg->arg) < 0)
 			return -1;
-		a_used = 1;
-		break;
-	/* coremask */
-	case 'c': {
+	TAILQ_FOREACH(arg, &args.block, next)
+		if (eal_option_device_add(RTE_DEVTYPE_BLOCKED, arg->arg) < 0)
+			return -1;
+	TAILQ_FOREACH(arg, &args.vdev, next)
+		if (eal_option_device_add(RTE_DEVTYPE_VIRTUAL, arg->arg) < 0)
+			return -1;
+	/* driver loading options */
+	TAILQ_FOREACH(arg, &args.driver_path, next)
+		if (eal_plugin_add(arg->arg) < 0)
+			return -1;
+
+	/* parse the coremask /core-list */
+	if (args.coremask != NULL) {
 		int lcore_indexes[RTE_MAX_LCORE];
 
-		if (eal_service_cores_parsed())
-			EAL_LOG(WARNING,
-				"Service cores parsed before dataplane cores. Please ensure -c is before -s or -S");
-		if (rte_eal_parse_coremask(optarg, lcore_indexes) < 0) {
+		if (rte_eal_parse_coremask(args.coremask, lcore_indexes) < 0) {
 			EAL_LOG(ERR, "invalid coremask syntax");
 			return -1;
 		}
 		if (update_lcore_config(lcore_indexes) < 0) {
 			char *available = available_cores();
 
-			EAL_LOG(ERR,
-				"invalid coremask, please check specified cores are part of %s",
-				available);
+			EAL_LOG(ERR, "invalid coremask '%s', please check specified cores are part of %s",
+					args.coremask, available);
 			free(available);
 			return -1;
 		}
-
-		if (core_parsed) {
-			if (core_parsed == LCORE_OPT_MSK)
-				EAL_LOG(ERR, "Option '-c' passed multiple times to EAL");
-			else
-				EAL_LOG(ERR, "Option -c is ignored, because option -l/--lcores used");
+		core_parsed = 1;
+	} else if (args.lcores != NULL) {
+		if (eal_parse_lcores(args.lcores) < 0) {
+			EAL_LOG(ERR, "invalid lcore list: '%s'", args.lcores);
 			return -1;
 		}
-
-		core_parsed = LCORE_OPT_MSK;
-		break;
+		core_parsed = 1;
 	}
-	/* corelist */
-	case 'l': {
-		if (eal_service_cores_parsed())
-			EAL_LOG(WARNING,
-				"Service cores parsed before dataplane cores. Please ensure -l is before -s or -S");
-
-		if (eal_parse_lcores(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameter for -l/--" OPT_LCORES);
+	if (args.main_lcore != NULL) {
+		if (eal_parse_main_lcore(args.main_lcore) < 0) {
+			EAL_LOG(ERR, "invalid main-lcore parameter");
 			return -1;
 		}
+	}
 
-		if (core_parsed) {
-			if (core_parsed == LCORE_OPT_LST)
-				EAL_LOG(ERR, "Core list option passed multiple times to EAL");
-			else
-				EAL_LOG(ERR, "Option '-l/--lcores' is ignored, because coremask option used");
+	/* service core options */
+	if (args.service_coremask != NULL) {
+		if (eal_parse_service_coremask(args.service_coremask) < 0) {
+			EAL_LOG(ERR, "invalid service coremask: '%s'",
+					args.service_coremask);
 			return -1;
 		}
+	} else if (args.service_corelist != NULL) {
+		if (eal_parse_service_corelist(args.service_corelist) < 0) {
+			EAL_LOG(ERR, "invalid service core list: '%s'",
+					args.service_corelist);
+			return -1;
+		}
+	}
 
-		core_parsed = LCORE_OPT_LST;
-		break;
+	/* memory options */
+	if (args.memory_size != NULL) {
+		int_cfg->memory = atoi(args.memory_size);
+		int_cfg->memory *= 1024ULL;
+		int_cfg->memory *= 1024ULL;
 	}
-	/* service coremask */
-	case 's':
-		if (eal_parse_service_coremask(optarg) < 0) {
-			EAL_LOG(ERR, "invalid service coremask");
+	if (args.memory_channels != NULL) {
+		int_cfg->force_nchannel = atoi(args.memory_channels);
+		if (int_cfg->force_nchannel == 0) {
+			EAL_LOG(ERR, "invalid memory channel parameter");
 			return -1;
 		}
-		break;
-	/* service corelist */
-	case 'S':
-		if (eal_parse_service_corelist(optarg) < 0) {
-			EAL_LOG(ERR, "invalid service core list");
+	}
+	if (args.memory_ranks != NULL) {
+		int_cfg->force_nrank = atoi(args.memory_ranks);
+		if (int_cfg->force_nrank == 0 || int_cfg->force_nrank > 16) {
+			EAL_LOG(ERR, "invalid memory rank parameter");
 			return -1;
 		}
-		break;
-	/* size of memory */
-	case 'm':
-		conf->memory = atoi(optarg);
-		conf->memory *= 1024ULL;
-		conf->memory *= 1024ULL;
-		mem_parsed = 1;
-		break;
-	/* force number of channels */
-	case 'n':
-		conf->force_nchannel = atoi(optarg);
-		if (conf->force_nchannel == 0) {
-			EAL_LOG(ERR, "invalid channel number");
+	}
+	if (args.huge_unlink != NULL) {
+		if (args.huge_unlink == (void *)1)
+			args.huge_unlink = NULL;
+		if (eal_parse_huge_unlink(args.huge_unlink, &int_cfg->hugepage_file) < 0) {
+			EAL_LOG(ERR, "invalid huge-unlink parameter");
 			return -1;
 		}
-		break;
-	/* force number of ranks */
-	case 'r':
-		conf->force_nrank = atoi(optarg);
-		if (conf->force_nrank == 0 ||
-		    conf->force_nrank > 16) {
-			EAL_LOG(ERR, "invalid rank number");
+	}
+	if (args.no_huge) {
+		int_cfg->no_hugetlbfs = 1;
+		/* no-huge is legacy mem */
+		int_cfg->legacy_mem = 1;
+	}
+	if (args.in_memory) {
+		int_cfg->in_memory = 1;
+		/* in-memory is a superset of noshconf and huge-unlink */
+		int_cfg->no_shconf = 1;
+		int_cfg->hugepage_file.unlink_before_mapping = true;
+	}
+	if (args.legacy_mem)
+		int_cfg->legacy_mem = 1;
+	if (args.single_file_segments)
+		int_cfg->single_file_segments = 1;
+	if (args.huge_dir != NULL) {
+		free(int_cfg->hugepage_dir);  /* free old hugepage dir */
+		int_cfg->hugepage_dir = strdup(args.huge_dir);
+		if (int_cfg->hugepage_dir == NULL) {
+			EAL_LOG(ERR, "failed to allocate memory for hugepage dir parameter");
 			return -1;
 		}
-		break;
-	/* force loading of external driver */
-	case 'd':
-		if (eal_plugin_add(optarg) == -1)
+	}
+	if (args.file_prefix != NULL) {
+		free(int_cfg->hugefile_prefix);  /* free old file prefix */
+		int_cfg->hugefile_prefix = strdup(args.file_prefix);
+		if (int_cfg->hugefile_prefix == NULL) {
+			EAL_LOG(ERR, "failed to allocate memory for file prefix parameter");
 			return -1;
-		break;
-	case 'v':
-		/* since message is explicitly requested by user, we
-		 * write message at highest log level so it can always
-		 * be seen
-		 * even if info or warning messages are disabled */
-		EAL_LOG(CRIT, "RTE Version: '%s'", rte_version());
-		break;
-
-	/* long options */
-	case OPT_HUGE_UNLINK_NUM:
-		if (eal_parse_huge_unlink(optarg, &conf->hugepage_file) < 0) {
-			EAL_LOG(ERR, "invalid --"OPT_HUGE_UNLINK" option");
+		}
+	}
+	if (args.numa_mem != NULL) {
+		if (eal_parse_socket_arg(args.numa_mem, int_cfg->numa_mem) < 0) {
+			EAL_LOG(ERR, "invalid numa-mem parameter: '%s'", args.numa_mem);
 			return -1;
 		}
-		break;
-
-	case OPT_NO_HUGE_NUM:
-		conf->no_hugetlbfs = 1;
-		/* no-huge is legacy mem */
-		conf->legacy_mem = 1;
-		break;
-
-	case OPT_NO_PCI_NUM:
-		conf->no_pci = 1;
-		break;
-
-	case OPT_NO_HPET_NUM:
-		conf->no_hpet = 1;
-		break;
-
-	case OPT_VMWARE_TSC_MAP_NUM:
-		conf->vmware_tsc_map = 1;
-		break;
-
-	case OPT_NO_SHCONF_NUM:
-		conf->no_shconf = 1;
-		break;
-
-	case OPT_IN_MEMORY_NUM:
-		conf->in_memory = 1;
-		/* in-memory is a superset of noshconf and huge-unlink */
-		conf->no_shconf = 1;
-		conf->hugepage_file.unlink_before_mapping = true;
-		break;
-
-	case OPT_PROC_TYPE_NUM:
-		conf->process_type = eal_parse_proc_type(optarg);
-		break;
-
-	case OPT_MAIN_LCORE_NUM:
-		if (eal_parse_main_lcore(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameter for --"
-					OPT_MAIN_LCORE);
+		int_cfg->force_numa = 1;
+	}
+	if (args.numa_limit != NULL) {
+		if (eal_parse_socket_arg(args.numa_limit, int_cfg->numa_limit) < 0) {
+			EAL_LOG(ERR, "invalid numa-limit parameter: '%s'", args.numa_limit);
 			return -1;
 		}
-		break;
+		int_cfg->force_numa_limits = 1;
+	}
 
-	case OPT_VDEV_NUM:
-		if (eal_option_device_add(RTE_DEVTYPE_VIRTUAL,
-				optarg) < 0) {
+	/* tracing settings, not supported on windows */
+#ifdef RTE_EXEC_ENV_WINDOWS
+	if (!TAILQ_EMPTY(&args.trace) ||
+			args.trace_dir != NULL ||
+			args.trace_bufsz != NULL ||
+			args.trace_mode != NULL)
+		EAL_LOG(WARNING, "Tracing is not supported on Windows, ignoring tracing parameters");
+#else
+	TAILQ_FOREACH(arg, &args.trace, next) {
+		if (eal_trace_args_save(arg->arg) < 0) {
+			EAL_LOG(ERR, "invalid trace parameter, '%s'", arg->arg);
 			return -1;
 		}
-		break;
-
-#ifndef RTE_EXEC_ENV_WINDOWS
-	case OPT_SYSLOG_NUM:
-		if (eal_log_syslog(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameters for --"
-					OPT_SYSLOG);
+	}
+	if (args.trace_dir != NULL) {
+		if (eal_trace_dir_args_save(args.trace_dir) < 0) {
+			EAL_LOG(ERR, "invalid trace directory, '%s'", args.trace_dir);
 			return -1;
 		}
-		break;
-#endif
-
-	case OPT_LOG_LEVEL_NUM:
-		if (eal_parse_log_level(optarg) < 0) {
-			EAL_LOG(ERR,
-				"invalid parameters for --"
-				OPT_LOG_LEVEL);
+	}
+	if (args.trace_bufsz != NULL) {
+		if (eal_trace_bufsz_args_save(args.trace_bufsz) < 0) {
+			EAL_LOG(ERR, "invalid trace buffer size, '%s'", args.trace_bufsz);
 			return -1;
 		}
-		break;
-
-	case OPT_LOG_TIMESTAMP_NUM:
-		if (eal_log_timestamp(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameters for --"
-				OPT_LOG_TIMESTAMP);
+	}
+	if (args.trace_mode != NULL) {
+		if (eal_trace_mode_args_save(args.trace_mode) < 0) {
+			EAL_LOG(ERR, "invalid trace mode, '%s'", args.trace_mode);
 			return -1;
 		}
-		break;
+	}
+#endif
 
-	case OPT_LOG_COLOR_NUM:
-		if (eal_log_color(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameters for --"
-				OPT_LOG_COLOR);
+	/* simple flag settings
+	 * Only set these to 1, as we don't want to set them to 0 in case
+	 * other options above have already set them.
+	 */
+	if (args.no_pci)
+		int_cfg->no_pci = 1;
+	if (args.no_hpet)
+		int_cfg->no_hpet = 1;
+	if (args.vmware_tsc_map)
+		int_cfg->vmware_tsc_map = 1;
+	if (args.no_shconf)
+		int_cfg->no_shconf = 1;
+	if (args.no_telemetry)
+		int_cfg->no_telemetry = 1;
+	if (args.match_allocations)
+		int_cfg->match_allocations = 1;
+	if (args.create_uio_dev)
+		int_cfg->create_uio_dev = 1;
+
+
+	/* other misc settings */
+	if (args.iova_mode != NULL) {
+		if (eal_parse_iova_mode(args.iova_mode) < 0) {
+			EAL_LOG(ERR, "invalid iova mode parameter '%s'", args.iova_mode);
 			return -1;
 		}
-		break;
-
-#ifndef RTE_EXEC_ENV_WINDOWS
-	case OPT_TRACE_NUM: {
-		if (eal_trace_args_save(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameters for --"
-				OPT_TRACE);
+	};
+	if (args.base_virtaddr != NULL) {
+		if (eal_parse_base_virtaddr(args.base_virtaddr) < 0) {
+			EAL_LOG(ERR, "invalid base virtaddr '%s'", args.base_virtaddr);
 			return -1;
 		}
-		break;
 	}
-
-	case OPT_TRACE_DIR_NUM: {
-		if (eal_trace_dir_args_save(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameters for --"
-				OPT_TRACE_DIR);
+	if (args.force_max_simd_bitwidth != NULL) {
+		if (eal_parse_simd_bitwidth(args.force_max_simd_bitwidth) < 0) {
+			EAL_LOG(ERR, "invalid SIMD bitwidth parameter '%s'",
+					args.force_max_simd_bitwidth);
 			return -1;
 		}
-		break;
 	}
-
-	case OPT_TRACE_BUF_SIZE_NUM: {
-		if (eal_trace_bufsz_args_save(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameters for --"
-				OPT_TRACE_BUF_SIZE);
+	if (args.vfio_intr != NULL) {
+		if (eal_parse_vfio_intr(args.vfio_intr) < 0) {
+			EAL_LOG(ERR, "invalid vfio interrupt parameter: '%s'", args.vfio_intr);
 			return -1;
 		}
-		break;
 	}
-
-	case OPT_TRACE_MODE_NUM: {
-		if (eal_trace_mode_args_save(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameters for --"
-				OPT_TRACE_MODE);
+	if (args.vfio_vf_token != NULL) {
+		if (eal_parse_vfio_vf_token(args.vfio_vf_token) < 0) {
+			EAL_LOG(ERR, "invalid vfio vf token parameter: '%s'", args.vfio_vf_token);
 			return -1;
 		}
-		break;
 	}
-#endif /* !RTE_EXEC_ENV_WINDOWS */
 
-	case OPT_LEGACY_MEM_NUM:
-		conf->legacy_mem = 1;
-		break;
-	case OPT_SINGLE_FILE_SEGMENTS_NUM:
-		conf->single_file_segments = 1;
-		break;
-	case OPT_IOVA_MODE_NUM:
-		if (eal_parse_iova_mode(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameters for --"
-				OPT_IOVA_MODE);
+	if (args.huge_worker_stack != NULL) {
+		if (args.huge_worker_stack == (void *)1)
+			args.huge_worker_stack = NULL;
+		if (eal_parse_huge_worker_stack(args.huge_worker_stack) < 0) {
+			EAL_LOG(ERR, "invalid huge worker stack parameter");
 			return -1;
 		}
-		break;
-	case OPT_BASE_VIRTADDR_NUM:
-		if (eal_parse_base_virtaddr(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameter for --"
-					OPT_BASE_VIRTADDR);
+	}
+	if (args.mbuf_pool_ops_name != NULL) {
+		free(int_cfg->user_mbuf_pool_ops_name); /* free old ops name */
+		int_cfg->user_mbuf_pool_ops_name = strdup(args.mbuf_pool_ops_name);
+		if (int_cfg->user_mbuf_pool_ops_name == NULL) {
+			EAL_LOG(ERR, "failed to allocate memory for mbuf pool ops name parameter");
 			return -1;
 		}
-		break;
-	case OPT_TELEMETRY_NUM:
-		break;
-	case OPT_NO_TELEMETRY_NUM:
-		conf->no_telemetry = 1;
-		break;
-	case OPT_FORCE_MAX_SIMD_BITWIDTH_NUM:
-		if (eal_parse_simd_bitwidth(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameter for --"
-					OPT_FORCE_MAX_SIMD_BITWIDTH);
+	}
+
+#ifndef RTE_EXEC_ENV_WINDOWS
+	/* create runtime data directory. In no_shconf mode, skip any errors */
+	if (eal_create_runtime_dir() < 0) {
+		if (int_cfg->no_shconf == 0) {
+			EAL_LOG(ERR, "Cannot create runtime directory");
 			return -1;
 		}
-		break;
+		EAL_LOG(WARNING, "No DPDK runtime directory created");
+	}
+#endif
 
-	/* don't know what to do, leave this to caller */
-	default:
-		return 1;
+	if (eal_adjust_config(int_cfg) != 0) {
+		EAL_LOG(ERR, "Invalid configuration");
+		return -1;
+	}
 
+	if (eal_check_common_options(int_cfg) != 0) {
+		EAL_LOG(ERR, "Checking common options failed");
+		return -1;
 	}
 
 	return 0;
-
-ba_conflict:
-	EAL_LOG(ERR,
-		"Options allow (-a) and block (-b) can't be used at the same time");
-	return -1;
 }
 
 static void
@@ -2163,13 +2235,8 @@ eal_check_common_options(struct internal_config *internal_cfg)
 			"option");
 		return -1;
 	}
-	if (mem_parsed && internal_cfg->force_numa == 1) {
-		EAL_LOG(ERR, "Options -m and --"OPT_NUMA_MEM" cannot "
-			"be specified at the same time");
-		return -1;
-	}
 	if (internal_cfg->no_hugetlbfs && internal_cfg->force_numa == 1) {
-		EAL_LOG(ERR, "Option --"OPT_NUMA_MEM" cannot "
+		EAL_LOG(ERR, "Option --"OPT_SOCKET_MEM" cannot "
 			"be specified together with --"OPT_NO_HUGE);
 		return -1;
 	}
@@ -2255,98 +2322,3 @@ rte_vect_set_max_simd_bitwidth(uint16_t bitwidth)
 	internal_conf->max_simd_bitwidth.bitwidth = bitwidth;
 	return 0;
 }
-
-void
-eal_common_usage(void)
-{
-	printf("[options]\n\n"
-	       "EAL common options:\n"
-	       "  -c COREMASK         Hexadecimal bitmask of cores to run on\n"
-	       "  -l, --"OPT_LCORES" CORELIST\n"
-	       "                      List of cores to run on\n"
-	       "                      The basic argument format is <c1>[-c2][,c3[-c4],...]\n"
-	       "                      where c1, c2, etc are core indexes between 0 and %d\n"
-	       "                      Can also be used to map lcore set to physical CPU set\n"
-	       "                      The argument format is\n"
-	       "                            '<lcores[@cpus]>[<,lcores[@cpus]>...]'\n"
-	       "                      lcores and cpus list are grouped by '(' and ')'\n"
-	       "                      Within the group, '-' is used for range separator,\n"
-	       "                      ',' is used for single number separator.\n"
-	       "                      '( )' can be omitted for single element group,\n"
-	       "                      '@' can be omitted if cpus and lcores have the same value\n"
-	       "  -s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores\n"
-	       "  -S SERVICE CORELIST List of cores to run services on\n"
-	       "  --"OPT_MAIN_LCORE" ID     Core ID that is used as main\n"
-	       "  --"OPT_MBUF_POOL_OPS_NAME" Pool ops name for mbuf to use\n"
-	       "  -n CHANNELS         Number of memory channels\n"
-	       "  -m MB               Memory to allocate (see also --"OPT_NUMA_MEM")\n"
-	       "  -r RANKS            Force number of memory ranks (don't detect)\n"
-	       "  -b, --block         Add a device to the blocked list.\n"
-	       "                      Prevent EAL from using this device. The argument\n"
-	       "                      format for PCI devices is <domain:bus:devid.func>.\n"
-	       "  -a, --allow         Add a device to the allow list.\n"
-	       "                      Only use the specified devices. The argument format\n"
-	       "                      for PCI devices is <[domain:]bus:devid.func>.\n"
-	       "                      This option can be present several times.\n"
-	       "                      [NOTE: " OPT_DEV_ALLOW " cannot be used with "OPT_DEV_BLOCK" option]\n"
-	       "  --"OPT_VDEV"              Add a virtual device.\n"
-	       "                      The argument format is <driver><id>[,key=val,...]\n"
-	       "                      (ex: --vdev=net_pcap0,iface=eth2).\n"
-	       "  --"OPT_IOVA_MODE"   Set IOVA mode. 'pa' for IOVA_PA\n"
-	       "                      'va' for IOVA_VA\n"
-	       "  -d LIB.so|DIR       Add a driver or driver directory\n"
-	       "                      (can be used multiple times)\n"
-	       "  --"OPT_VMWARE_TSC_MAP"    Use VMware TSC map instead of native RDTSC\n"
-	       "  --"OPT_PROC_TYPE"         Type of this process (primary|secondary|auto)\n"
-#ifndef RTE_EXEC_ENV_WINDOWS
-	       "  --"OPT_SYSLOG"[=<facility>] Enable use of syslog (and optionally set facility)\n"
-#endif
-	       "  --"OPT_LOG_LEVEL"=<level> Set global log level\n"
-	       "  --"OPT_LOG_LEVEL"=<type-match>:<level>\n"
-	       "                      Set specific log level\n"
-	       "  --"OPT_LOG_LEVEL"=help    Show log types and levels\n"
-	       "  --"OPT_LOG_TIMESTAMP"[=<format>]  Timestamp log output\n"
-	       "  --"OPT_LOG_COLOR"[=<when>] Colorize log messages\n"
-#ifndef RTE_EXEC_ENV_WINDOWS
-	       "  --"OPT_TRACE"=<regex-match>\n"
-	       "                      Enable trace based on regular expression trace name.\n"
-	       "                      By default, the trace is disabled.\n"
-	       "		      User must specify this option to enable trace.\n"
-	       "  --"OPT_TRACE_DIR"=<directory path>\n"
-	       "                      Specify trace directory for trace output.\n"
-	       "                      By default, trace output will created at\n"
-	       "                      $HOME directory and parameter must be\n"
-	       "                      specified once only.\n"
-	       "  --"OPT_TRACE_BUF_SIZE"=<int>\n"
-	       "                      Specify maximum size of allocated memory\n"
-	       "                      for trace output for each thread. Valid\n"
-	       "                      unit can be either 'B|K|M' for 'Bytes',\n"
-	       "                      'KBytes' and 'MBytes' respectively.\n"
-	       "                      Default is 1MB and parameter must be\n"
-	       "                      specified once only.\n"
-	       "  --"OPT_TRACE_MODE"=<o[verwrite] | d[iscard]>\n"
-	       "                      Specify the mode of update of trace\n"
-	       "                      output file. Either update on a file can\n"
-	       "                      be wrapped or discarded when file size\n"
-	       "                      reaches its maximum limit.\n"
-	       "                      Default mode is 'overwrite' and parameter\n"
-	       "                      must be specified once only.\n"
-#endif /* !RTE_EXEC_ENV_WINDOWS */
-	       "  -v                  Display version information on startup\n"
-	       "  -h, --"OPT_HELP"          This help\n"
-	       "  --"OPT_IN_MEMORY"   Operate entirely in memory. This will\n"
-	       "                      disable secondary process support\n"
-	       "  --"OPT_BASE_VIRTADDR"     Base virtual address\n"
-	       "  --"OPT_TELEMETRY"   Enable telemetry support (on by default)\n"
-	       "  --"OPT_NO_TELEMETRY"   Disable telemetry support\n"
-	       "  --"OPT_FORCE_MAX_SIMD_BITWIDTH" Force the max SIMD bitwidth\n"
-	       "\nEAL options for DEBUG use only:\n"
-	       "  --"OPT_HUGE_UNLINK"[=existing|always|never]\n"
-	       "                      When to unlink files in hugetlbfs\n"
-	       "                      ('existing' by default, no value means 'always')\n"
-	       "  --"OPT_NO_HUGE"           Use malloc instead of hugetlbfs\n"
-	       "  --"OPT_NO_PCI"            Disable PCI\n"
-	       "  --"OPT_NO_HPET"           Disable HPET\n"
-	       "  --"OPT_NO_SHCONF"         No shared config (mmap'd files)\n"
-	       "\n", RTE_MAX_LCORE);
-}
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 6ef45559f0..c4d2cc84dc 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -115,18 +115,12 @@ enum {
 	OPT_LONG_MAX_NUM
 };
 
-extern const char eal_short_options[];
-extern const struct option eal_long_options[];
-
-bool eal_option_is_log(int opt);
-int eal_parse_log_options(int argc, char * const argv[]);
-int eal_parse_common_option(int opt, const char *argv,
-			    struct internal_config *conf);
+int eal_parse_log_options(void);
+int eal_parse_args(void);
 int eal_option_device_parse(void);
 int eal_adjust_config(struct internal_config *internal_cfg);
 int eal_cleanup_config(struct internal_config *internal_cfg);
 int eal_check_common_options(struct internal_config *internal_cfg);
-void eal_common_usage(void);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
 int eal_save_args(int argc, char **argv);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 5846917cc5..ab8b37b956 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -72,6 +72,17 @@ struct rte_config {
  */
 struct rte_config *rte_eal_get_configuration(void);
 
+/**
+ * Put the argument list into a structure.
+ *
+ * This allows the arguments to then be processed out-of-order.
+ *
+ * @return
+ *  - 0 on success
+ * - Negative on error
+ */
+int eal_collate_args(int argc, char **argv);
+
 /**
  * Initialize the memzone subsystem (private to eal).
  *
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 1804b4cfd2..c6d1298d69 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -160,7 +160,7 @@ rte_eal_config_create(void)
 			cfg_len_aligned, PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_FIXED, mem_cfg_fd, 0);
 	if (mapped_mem_cfg_addr == MAP_FAILED) {
-		EAL_LOG(ERR, "Cannot remap memory for rte_config");
+		EAL_LOG(ERR, "Cannot remap memory for rte_config: %s", strerror(errno));
 		munmap(rte_mem_cfg_addr, cfg_len);
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
@@ -245,11 +245,8 @@ rte_eal_config_reattach(void)
 
 	if (mem_config == MAP_FAILED || mem_config != rte_mem_cfg_addr) {
 		if (mem_config != MAP_FAILED) {
-			/* errno is stale, don't use */
-			EAL_LOG(ERR, "Cannot mmap memory for rte_config at [%p], got [%p]"
-					  " - please use '--" OPT_BASE_VIRTADDR
-					  "' option",
-				rte_mem_cfg_addr, mem_config);
+			EAL_LOG(ERR, "Cannot mmap memory for rte_config at [%p], got [%p] - please use '--base-virtaddr' option",
+					rte_mem_cfg_addr, mem_config);
 			munmap(mem_config, sizeof(struct rte_mem_config));
 			return -1;
 		}
@@ -332,21 +329,6 @@ rte_config_init(void)
 	return 0;
 }
 
-/* display usage */
-static void
-eal_usage(const char *prgname)
-{
-	rte_usage_hook_t hook = eal_get_application_usage_hook();
-
-	printf("\nUsage: %s ", prgname);
-	eal_common_usage();
-	/* Allow the application to print its usage message too if hook is set */
-	if (hook) {
-		printf("===== Application Usage =====\n\n");
-		(hook)(prgname);
-	}
-}
-
 static inline size_t
 eal_get_hugepage_mem_size(void)
 {
@@ -367,123 +349,6 @@ eal_get_hugepage_mem_size(void)
 	return (size < SIZE_MAX) ? (size_t)(size) : SIZE_MAX;
 }
 
-/* Parse the argument given in the command line of the application */
-static int
-eal_parse_args(int argc, char **argv)
-{
-	int opt, ret;
-	char **argvopt;
-	int option_index;
-	char *prgname = argv[0];
-	const int old_optind = optind;
-	const int old_optopt = optopt;
-	const int old_optreset = optreset;
-	char * const old_optarg = optarg;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	argvopt = argv;
-	optind = 1;
-	optreset = 1;
-
-	while ((opt = getopt_long(argc, argvopt, eal_short_options,
-				  eal_long_options, &option_index)) != EOF) {
-
-		/* getopt didn't recognise the option */
-		if (opt == '?') {
-			eal_usage(prgname);
-			ret = -1;
-			goto out;
-		}
-
-		/* eal_parse_log_options() already handled this option */
-		if (eal_option_is_log(opt))
-			continue;
-
-		ret = eal_parse_common_option(opt, optarg, internal_conf);
-		/* common parser is not happy */
-		if (ret < 0) {
-			eal_usage(prgname);
-			ret = -1;
-			goto out;
-		}
-		/* common parser handled this option */
-		if (ret == 0)
-			continue;
-
-		switch (opt) {
-		case OPT_MBUF_POOL_OPS_NAME_NUM:
-		{
-			char *ops_name = strdup(optarg);
-			if (ops_name == NULL)
-				EAL_LOG(ERR, "Could not store mbuf pool ops name");
-			else {
-				/* free old ops name */
-				free(internal_conf->user_mbuf_pool_ops_name);
-
-				internal_conf->user_mbuf_pool_ops_name =
-						ops_name;
-			}
-			break;
-		}
-		case OPT_HELP_NUM:
-			eal_usage(prgname);
-			exit(EXIT_SUCCESS);
-		default:
-			if (opt < OPT_LONG_MIN_NUM && isprint(opt)) {
-				EAL_LOG(ERR, "Option %c is not supported "
-					"on FreeBSD", opt);
-			} else if (opt >= OPT_LONG_MIN_NUM &&
-				   opt < OPT_LONG_MAX_NUM) {
-				EAL_LOG(ERR, "Option %s is not supported "
-					"on FreeBSD",
-					eal_long_options[option_index].name);
-			} else {
-				EAL_LOG(ERR, "Option %d is not supported "
-					"on FreeBSD", opt);
-			}
-			eal_usage(prgname);
-			ret = -1;
-			goto out;
-		}
-	}
-
-	/* create runtime data directory. In no_shconf mode, skip any errors */
-	if (eal_create_runtime_dir() < 0) {
-		if (internal_conf->no_shconf == 0) {
-			EAL_LOG(ERR, "Cannot create runtime directory");
-			ret = -1;
-			goto out;
-		} else
-			EAL_LOG(WARNING, "No DPDK runtime directory created");
-	}
-
-	if (eal_adjust_config(internal_conf) != 0) {
-		ret = -1;
-		goto out;
-	}
-
-	/* sanity checks */
-	if (eal_check_common_options(internal_conf) != 0) {
-		eal_usage(prgname);
-		ret = -1;
-		goto out;
-	}
-
-	if (optind >= 0)
-		argv[optind-1] = prgname;
-	ret = optind-1;
-
-out:
-	/* restore getopt lib */
-	optind = old_optind;
-	optopt = old_optopt;
-	optreset = old_optreset;
-	optarg = old_optarg;
-
-	return ret;
-}
-
 static int
 check_socket(const struct rte_memseg_list *msl, void *arg)
 {
@@ -553,8 +418,18 @@ rte_eal_init(int argc, char **argv)
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 
+	/* Save and collate args at the top */
+	eal_save_args(argc, argv);
+
+	fctret = eal_collate_args(argc, argv);
+	if (fctret < 0) {
+		rte_eal_init_alert("invalid command-line arguments.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	/* setup log as early as possible */
-	if (eal_parse_log_options(argc, argv) < 0) {
+	if (eal_parse_log_options() < 0) {
 		rte_eal_init_alert("invalid log arguments.");
 		rte_errno = EINVAL;
 		return -1;
@@ -585,18 +460,14 @@ rte_eal_init(int argc, char **argv)
 
 	eal_reset_internal_config(internal_conf);
 
-	/* clone argv to report out later in telemetry */
-	eal_save_args(argc, argv);
-
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
 
-	fctret = eal_parse_args(argc, argv);
-	if (fctret < 0) {
-		rte_eal_init_alert("Invalid 'command line' arguments.");
+	if (eal_parse_args() < 0) {
+		rte_eal_init_alert("Error parsing command-line arguments.");
 		rte_errno = EINVAL;
 		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
 		return -1;
@@ -605,8 +476,7 @@ rte_eal_init(int argc, char **argv)
 	/* FreeBSD always uses legacy memory model */
 	internal_conf->legacy_mem = true;
 	if (internal_conf->in_memory) {
-		EAL_LOG(WARNING, "Warning: ignoring unsupported flag, '%s'",
-			OPT_IN_MEMORY);
+		EAL_LOG(WARNING, "Warning: ignoring unsupported flag, '--in-memory'");
 		internal_conf->in_memory = false;
 	}
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 6cd9782f40..a13ee23db4 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -59,9 +59,6 @@
 #include "log_internal.h"
 
 #define MEMSIZE_IF_NO_HUGE_PAGE (64ULL * 1024ULL * 1024ULL)
-
-#define SOCKET_MEM_STRLEN (RTE_MAX_NUMA_NODES * 10)
-
 #define KERNEL_IOMMU_GROUPS_PATH "/sys/kernel/iommu_groups"
 
 /* define fd variable here, because file needs to be kept open for the
@@ -438,362 +435,6 @@ eal_hugedirs_unlock(void)
 	}
 }
 
-/* display usage */
-static void
-eal_usage(const char *prgname)
-{
-	rte_usage_hook_t hook = eal_get_application_usage_hook();
-
-	printf("\nUsage: %s ", prgname);
-	eal_common_usage();
-	printf("EAL Linux options:\n"
-	       "  --"OPT_NUMA_MEM"        Memory to allocate on NUMA nodes (comma separated values)\n"
-	       "  --"OPT_NUMA_LIMIT"      Limit memory allocation on NUMA nodes (comma separated values)\n"
-	       "  --"OPT_HUGE_DIR"          Directory where hugetlbfs is mounted\n"
-	       "  --"OPT_FILE_PREFIX"       Prefix for hugepage filenames\n"
-	       "  --"OPT_CREATE_UIO_DEV"    Create /dev/uioX (usually done by hotplug)\n"
-	       "  --"OPT_VFIO_INTR"         Interrupt mode for VFIO (legacy|msi|msix)\n"
-	       "  --"OPT_VFIO_VF_TOKEN"     VF token (UUID) shared between SR-IOV PF and VFs\n"
-	       "  --"OPT_LEGACY_MEM"        Legacy memory mode (no dynamic allocation, contiguous segments)\n"
-	       "  --"OPT_SINGLE_FILE_SEGMENTS" Put all hugepage memory in single files\n"
-	       "  --"OPT_MATCH_ALLOCATIONS" Free hugepages exactly as allocated\n"
-	       "  --"OPT_HUGE_WORKER_STACK"[=size]\n"
-	       "                      Allocate worker thread stacks from hugepage memory.\n"
-	       "                      Size is in units of kbytes and defaults to system\n"
-	       "                      thread stack size if not specified.\n"
-	       "\n");
-	/* Allow the application to print its usage message too if hook is set */
-	if (hook) {
-		printf("===== Application Usage =====\n\n");
-		(hook)(prgname);
-	}
-}
-
-static int
-eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
-{
-	char * arg[RTE_MAX_NUMA_NODES];
-	char *end;
-	int arg_num, i, len;
-
-	len = strnlen(strval, SOCKET_MEM_STRLEN);
-	if (len == SOCKET_MEM_STRLEN) {
-		EAL_LOG(ERR, "--socket-mem is too long");
-		return -1;
-	}
-
-	/* all other error cases will be caught later */
-	if (!isdigit(strval[len-1]))
-		return -1;
-
-	/* split the optarg into separate socket values */
-	arg_num = rte_strsplit(strval, len,
-			arg, RTE_MAX_NUMA_NODES, ',');
-
-	/* if split failed, or 0 arguments */
-	if (arg_num <= 0)
-		return -1;
-
-	/* parse each defined socket option */
-	errno = 0;
-	for (i = 0; i < arg_num; i++) {
-		uint64_t val;
-		end = NULL;
-		val = strtoull(arg[i], &end, 10);
-
-		/* check for invalid input */
-		if ((errno != 0)  ||
-				(arg[i][0] == '\0') || (end == NULL) || (*end != '\0'))
-			return -1;
-		val <<= 20;
-		socket_arg[i] = val;
-	}
-
-	return 0;
-}
-
-static int
-eal_parse_vfio_intr(const char *mode)
-{
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	unsigned i;
-	static struct {
-		const char *name;
-		enum rte_intr_mode value;
-	} map[] = {
-		{ "legacy", RTE_INTR_MODE_LEGACY },
-		{ "msi", RTE_INTR_MODE_MSI },
-		{ "msix", RTE_INTR_MODE_MSIX },
-	};
-
-	for (i = 0; i < RTE_DIM(map); i++) {
-		if (!strcmp(mode, map[i].name)) {
-			internal_conf->vfio_intr_mode = map[i].value;
-			return 0;
-		}
-	}
-	return -1;
-}
-
-static int
-eal_parse_vfio_vf_token(const char *vf_token)
-{
-	struct internal_config *cfg = eal_get_internal_configuration();
-	rte_uuid_t uuid;
-
-	if (!rte_uuid_parse(vf_token, uuid)) {
-		rte_uuid_copy(cfg->vfio_vf_token, uuid);
-		return 0;
-	}
-
-	return -1;
-}
-
-static int
-eal_parse_huge_worker_stack(const char *arg)
-{
-	struct internal_config *cfg = eal_get_internal_configuration();
-
-	if (arg == NULL || arg[0] == '\0') {
-		pthread_attr_t attr;
-		int ret;
-
-		if (pthread_attr_init(&attr) != 0) {
-			EAL_LOG(ERR, "Could not retrieve default stack size");
-			return -1;
-		}
-		ret = pthread_attr_getstacksize(&attr, &cfg->huge_worker_stack_size);
-		pthread_attr_destroy(&attr);
-		if (ret != 0) {
-			EAL_LOG(ERR, "Could not retrieve default stack size");
-			return -1;
-		}
-	} else {
-		unsigned long stack_size;
-		char *end;
-
-		errno = 0;
-		stack_size = strtoul(arg, &end, 10);
-		if (errno || end == NULL || stack_size == 0 ||
-				stack_size >= (size_t)-1 / 1024)
-			return -1;
-
-		cfg->huge_worker_stack_size = stack_size * 1024;
-	}
-
-	EAL_LOG(DEBUG, "Each worker thread will use %zu kB of DPDK memory as stack",
-		cfg->huge_worker_stack_size / 1024);
-	return 0;
-}
-
-/* Parse the argument given in the command line of the application */
-static int
-eal_parse_args(int argc, char **argv)
-{
-	int opt, ret;
-	char **argvopt;
-	int option_index;
-	char *prgname = argv[0];
-	const int old_optind = optind;
-	const int old_optopt = optopt;
-	char * const old_optarg = optarg;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	argvopt = argv;
-	optind = 1;
-
-	while ((opt = getopt_long(argc, argvopt, eal_short_options,
-				  eal_long_options, &option_index)) != EOF) {
-
-		/* getopt didn't recognise the option */
-		if (opt == '?') {
-			eal_usage(prgname);
-			ret = -1;
-			goto out;
-		}
-
-		/* eal_parse_log_options() already handled this option */
-		if (eal_option_is_log(opt))
-			continue;
-
-		ret = eal_parse_common_option(opt, optarg, internal_conf);
-		/* common parser is not happy */
-		if (ret < 0) {
-			eal_usage(prgname);
-			ret = -1;
-			goto out;
-		}
-		/* common parser handled this option */
-		if (ret == 0)
-			continue;
-
-		switch (opt) {
-		case OPT_HELP_NUM:
-			eal_usage(prgname);
-			exit(EXIT_SUCCESS);
-
-		case OPT_HUGE_DIR_NUM:
-		{
-			char *hdir = strdup(optarg);
-			if (hdir == NULL)
-				EAL_LOG(ERR, "Could not store hugepage directory");
-			else {
-				/* free old hugepage dir */
-				free(internal_conf->hugepage_dir);
-				internal_conf->hugepage_dir = hdir;
-			}
-			break;
-		}
-		case OPT_FILE_PREFIX_NUM:
-		{
-			char *prefix = strdup(optarg);
-			if (prefix == NULL)
-				EAL_LOG(ERR, "Could not store file prefix");
-			else {
-				/* free old prefix */
-				free(internal_conf->hugefile_prefix);
-				internal_conf->hugefile_prefix = prefix;
-			}
-			break;
-		}
-		case OPT_NUMA_MEM_NUM:
-			if (eal_parse_socket_arg(optarg,
-					internal_conf->numa_mem) < 0) {
-				EAL_LOG(ERR, "invalid parameters for --"
-						OPT_NUMA_MEM
-						" (aka --"
-						OPT_SOCKET_MEM
-						")");
-				eal_usage(prgname);
-				ret = -1;
-				goto out;
-			}
-			internal_conf->force_numa = 1;
-			break;
-
-		case OPT_NUMA_LIMIT_NUM:
-			if (eal_parse_socket_arg(optarg,
-					internal_conf->numa_limit) < 0) {
-				EAL_LOG(ERR, "invalid parameters for --"
-						OPT_NUMA_LIMIT
-						" (aka --"
-						OPT_SOCKET_LIMIT
-						")");
-				eal_usage(prgname);
-				ret = -1;
-				goto out;
-			}
-			internal_conf->force_numa_limits = 1;
-			break;
-
-		case OPT_VFIO_INTR_NUM:
-			if (eal_parse_vfio_intr(optarg) < 0) {
-				EAL_LOG(ERR, "invalid parameters for --"
-						OPT_VFIO_INTR);
-				eal_usage(prgname);
-				ret = -1;
-				goto out;
-			}
-			break;
-
-		case OPT_VFIO_VF_TOKEN_NUM:
-			if (eal_parse_vfio_vf_token(optarg) < 0) {
-				EAL_LOG(ERR, "invalid parameters for --"
-						OPT_VFIO_VF_TOKEN);
-				eal_usage(prgname);
-				ret = -1;
-				goto out;
-			}
-			break;
-
-		case OPT_CREATE_UIO_DEV_NUM:
-			internal_conf->create_uio_dev = 1;
-			break;
-
-		case OPT_MBUF_POOL_OPS_NAME_NUM:
-		{
-			char *ops_name = strdup(optarg);
-			if (ops_name == NULL)
-				EAL_LOG(ERR, "Could not store mbuf pool ops name");
-			else {
-				/* free old ops name */
-				free(internal_conf->user_mbuf_pool_ops_name);
-
-				internal_conf->user_mbuf_pool_ops_name =
-						ops_name;
-			}
-			break;
-		}
-		case OPT_MATCH_ALLOCATIONS_NUM:
-			internal_conf->match_allocations = 1;
-			break;
-
-		case OPT_HUGE_WORKER_STACK_NUM:
-			if (eal_parse_huge_worker_stack(optarg) < 0) {
-				EAL_LOG(ERR, "invalid parameter for --"
-					OPT_HUGE_WORKER_STACK);
-				eal_usage(prgname);
-				ret = -1;
-				goto out;
-			}
-			break;
-
-		default:
-			if (opt < OPT_LONG_MIN_NUM && isprint(opt)) {
-				EAL_LOG(ERR, "Option %c is not supported "
-					"on Linux", opt);
-			} else if (opt >= OPT_LONG_MIN_NUM &&
-				   opt < OPT_LONG_MAX_NUM) {
-				EAL_LOG(ERR, "Option %s is not supported "
-					"on Linux",
-					eal_long_options[option_index].name);
-			} else {
-				EAL_LOG(ERR, "Option %d is not supported "
-					"on Linux", opt);
-			}
-			eal_usage(prgname);
-			ret = -1;
-			goto out;
-		}
-	}
-
-	/* create runtime data directory. In no_shconf mode, skip any errors */
-	if (eal_create_runtime_dir() < 0) {
-		if (internal_conf->no_shconf == 0) {
-			EAL_LOG(ERR, "Cannot create runtime directory");
-			ret = -1;
-			goto out;
-		} else
-			EAL_LOG(WARNING, "No DPDK runtime directory created");
-	}
-
-	if (eal_adjust_config(internal_conf) != 0) {
-		ret = -1;
-		goto out;
-	}
-
-	/* sanity checks */
-	if (eal_check_common_options(internal_conf) != 0) {
-		eal_usage(prgname);
-		ret = -1;
-		goto out;
-	}
-
-	if (optind >= 0)
-		argv[optind-1] = prgname;
-	ret = optind-1;
-
-out:
-	/* restore getopt lib */
-	optind = old_optind;
-	optopt = old_optopt;
-	optarg = old_optarg;
-
-	return ret;
-}
-
 static int
 check_socket(const struct rte_memseg_list *msl, void *arg)
 {
@@ -938,8 +579,18 @@ rte_eal_init(int argc, char **argv)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
+	/* clone argv to report out later in telemetry */
+	eal_save_args(argc, argv);
+
+	fctret = eal_collate_args(argc, argv);
+	if (fctret < 0) {
+		rte_eal_init_alert("Invalid command line arguments.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	/* setup log as early as possible */
-	if (eal_parse_log_options(argc, argv) < 0) {
+	if (eal_parse_log_options() < 0) {
 		rte_eal_init_alert("invalid log arguments.");
 		rte_errno = EINVAL;
 		return -1;
@@ -970,18 +621,14 @@ rte_eal_init(int argc, char **argv)
 
 	eal_reset_internal_config(internal_conf);
 
-	/* clone argv to report out later in telemetry */
-	eal_save_args(argc, argv);
-
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
 
-	fctret = eal_parse_args(argc, argv);
-	if (fctret < 0) {
-		rte_eal_init_alert("Invalid 'command line' arguments.");
+	if (eal_parse_args() < 0) {
+		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
 		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
 		return -1;
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 2502ec3c3d..3d65c405cc 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -82,99 +82,6 @@ rte_mp_disable(void)
 	return true;
 }
 
-/* display usage */
-static void
-eal_usage(const char *prgname)
-{
-	rte_usage_hook_t hook = eal_get_application_usage_hook();
-
-	printf("\nUsage: %s ", prgname);
-	eal_common_usage();
-	/* Allow the application to print its usage message too
-	 * if hook is set
-	 */
-	if (hook) {
-		printf("===== Application Usage =====\n\n");
-		(hook)(prgname);
-	}
-}
-
-/* Parse the argument given in the command line of the application */
-static int
-eal_parse_args(int argc, char **argv)
-{
-	int opt, ret;
-	char **argvopt;
-	int option_index;
-	char *prgname = argv[0];
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	argvopt = argv;
-
-	while ((opt = getopt_long(argc, argvopt, eal_short_options,
-		eal_long_options, &option_index)) != EOF) {
-
-		int ret;
-
-		/* getopt is not happy, stop right now */
-		if (opt == '?') {
-			eal_usage(prgname);
-			return -1;
-		}
-
-		/* eal_parse_log_options() already handled this option */
-		if (eal_option_is_log(opt))
-			continue;
-
-		ret = eal_parse_common_option(opt, optarg, internal_conf);
-		/* common parser is not happy */
-		if (ret < 0) {
-			eal_usage(prgname);
-			return -1;
-		}
-		/* common parser handled this option */
-		if (ret == 0)
-			continue;
-
-		switch (opt) {
-		case OPT_HELP_NUM:
-			eal_usage(prgname);
-			exit(EXIT_SUCCESS);
-		default:
-			if (opt < OPT_LONG_MIN_NUM && isprint(opt)) {
-				EAL_LOG(ERR, "Option %c is not supported "
-					"on Windows", opt);
-			} else if (opt >= OPT_LONG_MIN_NUM &&
-				opt < OPT_LONG_MAX_NUM) {
-				EAL_LOG(ERR, "Option %s is not supported "
-					"on Windows",
-					eal_long_options[option_index].name);
-			} else {
-				EAL_LOG(ERR, "Option %d is not supported "
-					"on Windows", opt);
-			}
-			eal_usage(prgname);
-			return -1;
-		}
-	}
-
-	if (eal_adjust_config(internal_conf) != 0)
-		return -1;
-
-	/* sanity checks */
-	if (eal_check_common_options(internal_conf) != 0) {
-		eal_usage(prgname);
-		return -1;
-	}
-
-	if (optind >= 0)
-		argv[optind - 1] = prgname;
-	ret = optind - 1;
-	optind = 0; /* reset getopt lib */
-	return ret;
-}
-
 static int
 sync_func(void *arg __rte_unused)
 {
@@ -260,8 +167,18 @@ rte_eal_init(int argc, char **argv)
 	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
 	char thread_name[RTE_THREAD_NAME_SIZE];
 
+	/* clone argv to report out later in telemetry */
+	eal_save_args(argc, argv);
+
+	fctret = eal_collate_args(argc, argv);
+	if (fctret < 0) {
+		rte_eal_init_alert("Invalid command line arguments.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
 	/* setup log as early as possible */
-	if (eal_parse_log_options(argc, argv) < 0) {
+	if (eal_parse_log_options() < 0) {
 		rte_eal_init_alert("invalid log arguments.");
 		rte_errno = EINVAL;
 		return -1;
@@ -288,9 +205,11 @@ rte_eal_init(int argc, char **argv)
 		return -1;
 	}
 
-	fctret = eal_parse_args(argc, argv);
-	if (fctret < 0)
-		exit(1);
+	if (eal_parse_args() < 0) {
+		rte_eal_init_alert("Invalid command line arguments.");
+		rte_errno = EINVAL;
+		return -1;
+	}
 
 	if (eal_option_device_parse()) {
 		rte_errno = ENODEV;
-- 
2.48.1

