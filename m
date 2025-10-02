Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728ECAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:44:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56DD040E96;
	Thu,  2 Oct 2025 19:43:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7B97E40E42
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427013; x=1790963013;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UVVLh9BNp/MHG1Sprmuj9G/ydbBCeSICIeT6iBznglw=;
 b=Ghixt5LedSFwC0XMxDUiSOc5shGJ1YlAmWXT2Nh+8QpjinTUtUOFyRSp
 GFTB8RATLjWFAYNoT3nfuIYAXtzxYoVzJfi7ilKSgpBXDOOfXZ02iWjvf
 DudCqjIX8Gqea1UtihL0vPwtesVWK5VXsubLVsGIgo0XGIaxJIzAPe1SY
 GhSuraEkJ6YUUI6EAuEAcx9ngNdB7FJ+SqGyrYt90s4fxFRYhWOX7PkRK
 pkXM2nMIgGCMS/3OjNhLs0ZYS9BuI6cllG8rc9rezsadmohArIKFQ2UKz
 XQEmBWklp2fVruzZW92VUZITFrzS6Ht7L/A3aCZuBhYYIUQnsxBmx6Da2 g==;
X-CSE-ConnectionGUID: O9gFYHyvQzOI173SuZ2nxg==
X-CSE-MsgGUID: B10vEC9TTwWJNvg8JJiSUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271852"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271852"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:32 -0700
X-CSE-ConnectionGUID: bM98IbgESvKgxOl3C5pnQw==
X-CSE-MsgGUID: C/NKxwEhTpemGOX807JcTg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:31 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 07/18] eal: define the EAL parameters in argparse format
Date: Thu,  2 Oct 2025 18:43:04 +0100
Message-ID: <20251002174315.962992-8-bruce.richardson@intel.com>
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

Create eal_option_list.h, containing all the possible EAL parameters,
and basic info about them, such as type, whether they take a parameter
or not. Each entry is defined using a macro, which will be then
interpreted when the file is included.

First time this header in included in the eal_common_options.c file, the
macros are defined in such a way as to define field elements for an
"eal_init_args" structure, where each value is either a string type, if
it takes a parameter, or boolean type if it doesn't. For those elements
that take multiple values, i.e. are passed multiple times, we put them
in a TAILQ.

The second time of inclusion, the macros are defined so as to define the
arguments in an rte_argparse structure for EAL. For the basic string and
boolean types, we just store the values in the appropriate field in the
previous defined "eal_init_args" structure. For the list elements, we
use the argparse callback to process those elements, adding them to the
TAILQ as they are encountered.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 141 +++++++++++++++++++++++++++-
 lib/eal/common/eal_option_list.h    |  90 ++++++++++++++++++
 lib/eal/meson.build                 |   2 +-
 lib/meson.build                     |   1 +
 4 files changed, 230 insertions(+), 4 deletions(-)
 create mode 100644 lib/eal/common/eal_option_list.h

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 675745d610..75d42d97aa 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -10,6 +10,7 @@
 #include <limits.h>
 #include <errno.h>
 #include <getopt.h>
+#include <sys/queue.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <dlfcn.h>
 #include <libgen.h>
@@ -33,6 +34,7 @@
 #endif
 #include <rte_vect.h>
 
+#include <rte_argparse.h>
 #include <eal_export.h>
 #include "eal_internal_cfg.h"
 #include "eal_options.h"
@@ -47,6 +49,142 @@
 #define LCORE_OPT_LST 1
 #define LCORE_OPT_MSK 2
 
+/* Allow the application to print its usage message too if set */
+static rte_usage_hook_t rte_application_usage_hook;
+
+struct arg_list_elem {
+	TAILQ_ENTRY(arg_list_elem) next;
+	char *arg;
+};
+TAILQ_HEAD(arg_list, arg_list_elem);
+
+struct eal_init_args {
+	/* define a struct member for each EAL option, member name is the same as option name.
+	 * Parameters that take an argument e.g. -l, are char *,
+	 * parameters that take no options e.g. --no-huge, are bool.
+	 * parameters that can be given multiple times e.g. -a, are arg_lists,
+	 * parameters that are optional e.g. --huge-unlink,
+	 *   are char * but are set to (void *)1 if the parameter is not given.
+	 * for aliases, i.e. options under different names, no field needs to be output
+	 */
+#define LIST_ARG(long, short, help_str, fieldname) struct arg_list fieldname;
+#define STR_ARG(long, short, help_str, fieldname) char *fieldname;
+#define OPT_STR_ARG(long, short, help_str, fieldname) char *fieldname;
+#define BOOL_ARG(long, short, help_str, fieldname) bool fieldname;
+#define STR_ALIAS(long, short, help_str, fieldname)
+
+#define INCLUDE_ALL_ARG 1  /* for struct definition, include even unsupported values */
+#include "eal_option_list.h"
+#undef INCLUDE_ALL_ARG
+};
+struct eal_init_args args;
+
+/* an rte_argparse callback to append the argument to an arg_list
+ * in args. The index is the offset into the struct of the list.
+ */
+static int
+arg_list_callback(uint32_t index, const char *arg, void *init_args)
+{
+	struct arg_list *list = RTE_PTR_ADD(init_args, index);
+	struct arg_list_elem *elem;
+
+	elem = malloc(sizeof(*elem));
+	if (elem == NULL)
+		return -1;
+
+	elem->arg = strdup(arg);
+	if (elem->arg == NULL) {
+		free(elem);
+		return -1;
+	}
+
+	TAILQ_INSERT_TAIL(list, elem, next);
+	return 0;
+}
+
+static void
+eal_usage(const struct rte_argparse *obj)
+{
+	rte_argparse_print_help(stdout, obj);
+	if (rte_application_usage_hook != NULL)
+		rte_application_usage_hook(obj->prog_name);
+}
+
+/* undef the *_ARG macros before redefining to generate the argparse arg list */
+#undef LIST_ARG
+#undef STR_ARG
+#undef OPT_STR_ARG
+#undef BOOL_ARG
+#undef STR_ALIAS
+
+/* For arguments which have an arg_list type, they use callback (no val_saver),
+ * require a value, and have the SUPPORT_MULTI flag.
+ */
+#define LIST_ARG(long, short, help_str, fieldname) { \
+	.name_long = long, \
+	.name_short = short, \
+	.help = help_str, \
+	.val_set = (void *)offsetof(struct eal_init_args, fieldname), \
+	.value_required = RTE_ARGPARSE_VALUE_REQUIRED, \
+	.flags = RTE_ARGPARSE_FLAG_SUPPORT_MULTI, \
+},
+/* For arguments which have a string type, they use val_saver (no callback),
+ * and normally REQUIRED_VALUE.
+ */
+#define STR_ARG(long, short, help_str, fieldname) { \
+	.name_long = long, \
+	.name_short = short, \
+	.help = help_str, \
+	.val_saver = &args.fieldname, \
+	.value_required = RTE_ARGPARSE_VALUE_REQUIRED, \
+	.value_type = RTE_ARGPARSE_VALUE_TYPE_STR, \
+},
+/* For flags which have optional arguments, they use both val_saver and val_set,
+ * but still have a string type.
+ */
+#define OPT_STR_ARG(long, short, help_str, fieldname) { \
+	.name_long = long, \
+	.name_short = short, \
+	.help = help_str, \
+	.val_saver = &args.fieldname, \
+	.val_set = (void *)1, \
+	.value_required = RTE_ARGPARSE_VALUE_OPTIONAL, \
+	.value_type = RTE_ARGPARSE_VALUE_TYPE_STR, \
+},
+/* For boolean arguments, they use val_saver and val_set, with NO_VALUE flag.
+ */
+#define BOOL_ARG(long, short, help_str, fieldname) { \
+	.name_long = long, \
+	.name_short = short, \
+	.help = help_str, \
+	.val_saver = &args.fieldname, \
+	.val_set = (void *)1, \
+	.value_required = RTE_ARGPARSE_VALUE_NONE, \
+	.value_type = RTE_ARGPARSE_VALUE_TYPE_BOOL, \
+},
+#define STR_ALIAS STR_ARG
+
+#if RTE_VER_RELEASE == 99
+#define GUIDES_PATH "https://doc.dpdk.org/guides-" RTE_STR(RTE_VER_YEAR) "." RTE_STR(RTE_VER_MONTH)
+#else
+#define GUIDES_PATH "https://doc.dpdk.org/guides"
+#endif
+
+struct rte_argparse eal_argparse  = {
+	.prog_name = "",
+	.usage = "<DPDK EAL options> -- <App options>",
+	.epilog = "For more information on EAL options, see the DPDK documentation at: \n"
+			"\t" GUIDES_PATH "/" RTE_EXEC_ENV_NAME "_gsg/",
+	.exit_on_error = true,
+	.callback = arg_list_callback,
+	.print_help = eal_usage,
+	.opaque = &args,
+	.args = {
+		#include "eal_option_list.h"
+		ARGPARSE_ARG_END(),
+	}
+};
+
 const char
 eal_short_options[] =
 	"a:" /* allow */
@@ -164,9 +302,6 @@ static int main_lcore_parsed;
 static int mem_parsed;
 static int core_parsed;
 
-/* Allow the application to print its usage message too if set */
-static rte_usage_hook_t rte_application_usage_hook;
-
 /* Returns rte_usage_hook_t */
 rte_usage_hook_t
 eal_get_application_usage_hook(void)
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
new file mode 100644
index 0000000000..6a0c501680
--- /dev/null
+++ b/lib/eal/common/eal_option_list.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation.
+ */
+
+/** This file contains a list of EAL commandline arguments.
+ *
+ * It's designed to be included multiple times in the codebase to
+ * generate both argument structure and the argument definitions
+ * for argparse.
+ */
+
+/* check that all ARG macros are defined */
+ #ifndef LIST_ARG
+#error "LIST_ARG macro must be defined before including " __FILE__
+#endif
+#ifndef STR_ARG
+#error "STR_ARG macro must be defined before including " __FILE__
+#endif
+#ifndef OPT_STR_ARG
+#error "OPT_STR_ARG macro must be defined before including " __FILE__
+#endif
+#ifndef BOOL_ARG
+#error "BOOL_ARG macro must be defined before including " __FILE__
+#endif
+#ifndef STR_ALIAS
+#error "STR_ALIAS macro must be defined before including " __FILE__
+#endif
+
+
+/*
+ * list of EAL arguments as struct rte_argparse_arg.
+ * Format of each entry: long name, short name, help string, struct member name.
+ */
+/* (Alphabetical) List of common options first */
+LIST_ARG("--allow", "-a", "Add device to allow-list, causing DPDK to only use specified devices", allow)
+STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory", base_virtaddr)
+LIST_ARG("--block", "-b", "Add device to block-list, preventing DPDK from using the device", block)
+STR_ARG("--coremask", "-c", "[Deprecated] Hexadecimal bitmask of cores to use", coremask)
+LIST_ARG("--driver-path", "-d", "Path to external driver shared object, or directory of drivers", driver_path)
+STR_ARG("--force-max-simd-bitwidth", NULL, "Set max SIMD bitwidth to use in vector code paths", force_max_simd_bitwidth)
+OPT_STR_ARG("--huge-unlink", NULL, "Unlink hugetlbfs files on exit (existing|always|never)", huge_unlink)
+BOOL_ARG("--in-memory", NULL, "DPDK should not create shared mmap files in filesystem  (disables secondary process support)", in_memory)
+STR_ARG("--iova-mode", NULL, "IOVA mapping mode, physical (pa)/virtual (va)", iova_mode)
+STR_ARG("--lcores", "-l", "List of CPU cores to use", lcores)
+BOOL_ARG("--legacy-mem", NULL, "Enable legacy memory behavior", legacy_mem)
+OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color)
+LIST_ARG("--log-level", NULL, "Log level for loggers; use log-level=help for list of log types and levels", log_level)
+OPT_STR_ARG("--log-timestamp", NULL, "Enable/disable timestamp in log output", log_timestamp)
+STR_ARG("--main-lcore", NULL, "Select which core to use for the main thread", main_lcore)
+STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name", mbuf_pool_ops_name)
+STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels)
+STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks)
+STR_ARG("--memory-size", "-m", "Total size of memory to allocate initially", memory_size)
+BOOL_ARG("--no-hpet", NULL, "Disable HPET timer", no_hpet)
+BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge)
+BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
+BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf)
+BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry)
+STR_ARG("--proc-type", NULL, "Type of process (primary|secondary|auto)", proc_type)
+STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist)
+STR_ARG("--service-coremask", "-s", "[Deprecated] Bitmask of cores to use for service threads", service_coremask)
+BOOL_ARG("--single-file-segments", NULL, "Store all pages within single files (per-page-size, per-node)", single_file_segments)
+BOOL_ARG("--telemetry", NULL, "Enable telemetry", telemetry)
+LIST_ARG("--vdev", NULL, "Add a virtual device to the system; format=<driver><id>[,key=val,...]", vdev)
+BOOL_ARG("--vmware-tsc-map", NULL, "Use VMware TSC mapping instead of native RDTSC", vmware_tsc_map)
+BOOL_ARG("--version", "-v", "Show version", version)
+
+#if defined(INCLUDE_ALL_ARG) || !defined(RTE_EXEC_ENV_WINDOWS)
+/* Linux and FreeBSD options*/
+OPT_STR_ARG("--syslog", NULL, "Log to syslog (and optionally set facility)", syslog)
+LIST_ARG("--trace", NULL, "Enable trace based on regular expression trace name", trace)
+STR_ARG("--trace-bufsz", NULL, "Trace buffer size", trace_bufsz)
+STR_ARG("--trace-dir", NULL, "Trace directory", trace_dir)
+STR_ARG("--trace-mode", NULL, "Trace mode", trace_mode)
+#endif
+
+#if defined(INCLUDE_ALL_ARG) || defined(RTE_EXEC_ENV_LINUX)
+/* Linux-only options */
+BOOL_ARG("--create-uio-dev", NULL, "Create /dev/uioX devices", create_uio_dev)
+STR_ARG("--file-prefix", NULL, "Base filename of hugetlbfs files", file_prefix)
+STR_ARG("--huge-dir", NULL, "Directory for hugepage files", huge_dir)
+OPT_STR_ARG("--huge-worker-stack", NULL, "Allocate worker thread stacks from hugepage memory, with optional size (kB)", huge_worker_stack)
+BOOL_ARG("--match-allocations", NULL, "Free hugepages exactly as allocated", match_allocations)
+STR_ARG("--numa-mem", NULL, "Memory to allocate on NUMA nodes (comma separated values)", numa_mem)
+STR_ARG("--numa-limit", NULL, "Limit memory allocation on NUMA nodes (comma separated values)", numa_limit)
+STR_ALIAS("--socket-mem", NULL, "Alias for --numa-mem", numa_mem)
+STR_ALIAS("--socket-limit", NULL, "Alias for --numa-limit", numa_limit)
+STR_ARG("--vfio-intr", NULL, "VFIO interrupt mode (legacy|msi|msix)", vfio_intr)
+STR_ARG("--vfio-vf-token", NULL, "VF token (UUID) shared between SR-IOV PF and VFs", vfio_vf_token)
+#endif
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index e1d6c4cf17..f9fcee24ee 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -14,7 +14,7 @@ subdir(exec_env)
 
 subdir(arch_subdir)
 
-deps += ['log', 'kvargs']
+deps += ['argparse', 'kvargs']
 if not is_windows
     deps += ['telemetry']
 endif
diff --git a/lib/meson.build b/lib/meson.build
index a67efaf718..a28d81d3e3 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -71,6 +71,7 @@ libraries = [
 ]
 
 always_enable = [
+        'argparse',
         'cmdline',
         'eal',
         'ethdev',
-- 
2.48.1

