Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE1C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 14:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C770940B98;
	Fri, 18 Jul 2025 16:34:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9ABA140A87
 for <dev@dpdk.org>; Fri, 18 Jul 2025 16:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752849251; x=1784385251;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R5FQOYdgv9bVvIC1WX138HxXwB18eki+WGhFD+7LBpY=;
 b=lNRnksmr7VeodV59XcZ7TBSa3CGhMydCT+XR0zK/S/oa1+H/1Mmb3D8a
 N3Y4bv0mZeOv0BQJ0X+M9YtftGZdfBvMTuq+ATbmxf2aqt+YRKtv9IsMU
 VQRBAuwN0rwSfjhktZFSMuTc82oHVzlZKJYwTXpH7zX0ZVkCEZ2meqD82
 BDj8Ona01lVKzTrsUc+uTB4y0Qgnc6o4VLiwyjrurr4+ya/FLSVoYhMSY
 PaPlbMFvpiVCrJ7dT4lh+rmubcqsRQ9dCNzah1j4PKSRV/tcRZ+hjyX8F
 H6O8UGjQ3+JijT1Du7X83FNt9Q8rDu/jeWV58an30UnmGNKSlTnBUWZum A==;
X-CSE-ConnectionGUID: xuEWA5LZTFODJoG+xnt0lw==
X-CSE-MsgGUID: QEFLkRqoSZKN65LKdJQFBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="72597097"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="72597097"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 07:34:10 -0700
X-CSE-ConnectionGUID: /ehTZjLSQuqKRjSuk+rpYw==
X-CSE-MsgGUID: b99UNc3GQfGvx/DrJInpzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="162389340"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa005.fm.intel.com with ESMTP; 18 Jul 2025 07:34:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 5/9] eal: define the EAL parameters in argparse format
Date: Fri, 18 Jul 2025 15:33:51 +0100
Message-ID: <20250718143356.1578988-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250718143356.1578988-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250718143356.1578988-1-bruce.richardson@intel.com>
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

This table should allow us to parse all the eal args into a single
structure for later parsing in a fixed-order field basis. For those
elements that take multiple values, define a TAILQ and a callback to
process those elements.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 221 +++++++++++++++++++++++++++-
 lib/eal/meson.build                 |   2 +-
 lib/meson.build                     |   1 +
 3 files changed, 220 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index cafae9d9d7..9cbb6f31e7 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -28,11 +28,13 @@
 #include <rte_version.h>
 #include <rte_devargs.h>
 #include <rte_memcpy.h>
+#include <sys/queue.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <rte_telemetry.h>
 #endif
 #include <rte_vect.h>
 
+#include <rte_argparse.h>
 #include <eal_export.h>
 #include "eal_internal_cfg.h"
 #include "eal_options.h"
@@ -47,6 +49,222 @@
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
+	 * NOTE: List is to be kept alphabetically by option name
+	 */
+	struct arg_list allow;
+	char *base_virtaddr;
+	struct arg_list block;
+	char *coremask;
+	bool create_uio_dev;
+	struct arg_list driver_path;
+	char *file_prefix;
+	char *force_max_simd_bitwidth;
+	char *huge_dir;
+	char *huge_unlink;   /* parameter optional */
+	char *huge_worker_stack;  /* parameter optional */
+	bool in_memory;
+	char *iova_mode;
+	char *lcores;
+	bool legacy_mem;
+	char *log_color;   /* parameter optional */
+	char *log_level;
+	char *log_timestamp;  /* parameter optional */
+	char *main_lcore;
+	bool match_allocations;
+	char *mbuf_pool_ops_name;
+	char *memory_channels;
+	char *memory_ranks;
+	char *memory_size;
+	bool no_hpet;
+	bool no_huge;
+	bool no_pci;
+	bool no_shconf;
+	bool no_telemetry;
+	char *numa_mem;
+	char *numa_limit;
+	char *proc_type;
+	char *service_coremask;
+	char *service_corelist;
+	bool single_file_segments;
+	char *syslog;   /* parameter optional */
+	bool telemetry;
+	char *trace;
+	char *trace_bufsz;
+	char *trace_dir;
+	char *trace_mode;
+	struct arg_list vdev;
+	bool version;
+	char *vfio_intr;
+	char *vfio_vf_token;
+	bool vmware_tsc_map;
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
+}
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
+}
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
+}
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
+}
+
+struct rte_argparse eal_argparse  = {
+	.prog_name = "",
+	.usage = "<DPDK EAL options>",
+	.epilog = "For more information on EAL options, see the DPDK documentation at: \n"
+			"\thttps://doc.dpdk.org/guides/" RTE_EXEC_ENV_NAME "_gsg/",
+	.exit_on_error = true,
+	.callback = arg_list_callback,
+	.print_help = eal_usage,
+	.opaque = &args,
+	.args = {
+		/* list of EAL arguments as struct rte_argparse_arg. */
+		/* (Alphabetical) List of common options first */
+		LIST_ARG("--allow", "-a", "Add device to allow-list, causing DPDK to only use specified devices", allow),
+		STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory", base_virtaddr),
+		LIST_ARG("--block", "-b", "Add device to block-list, preventing DPDK from using the device", block),
+		STR_ARG("--coremask", "-c", "Hexadecimal bitmask of cores to use", coremask),
+		LIST_ARG("--driver-path", "-d", "Path to external driver shared object, or directory of drivers", driver_path),
+		STR_ARG("--force-max-simd-bitwidth", NULL, "Set max SIMD bitwidth to use in vector code paths", force_max_simd_bitwidth),
+		OPT_STR_ARG("--huge-unlink", NULL, "Unlink hugetlbfs files on exit (existing|always|never)", huge_unlink),
+		BOOL_ARG("--in-memory", NULL, "DPDK should not create shared mmap files in filesystem  (disables secondary process support)", in_memory),
+		STR_ARG("--iova-mode", NULL, "IOVA mapping mode, physical (pa)/virtual (va)", iova_mode),
+		STR_ARG("--lcores", "-l", "List of CPU cores to use", lcores),
+		BOOL_ARG("--legacy-mem", NULL, "Enable legacy memory behavior", legacy_mem),
+		OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color),
+		STR_ARG("--log-level", NULL, "Log level for loggers; use log-level=help for list of log types and levels", log_level),
+		OPT_STR_ARG("--log-timestamp", NULL, "Enable/disable timestamp in log output", log_timestamp),
+		STR_ARG("--main-lcore", NULL, "Select which core to use for the main thread", main_lcore),
+		STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name", mbuf_pool_ops_name),
+		STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels),
+		STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks),
+		STR_ARG("--memory-size", "-m", "Total size of memory to allocate initially", memory_size),
+		BOOL_ARG("--no-hpet", NULL, "Disable HPET timer", no_hpet),
+		BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge),
+		BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci),
+		BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf),
+		BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry),
+		STR_ARG("--proc-type", NULL, "Type of process (primary|secondary|auto)", proc_type),
+		STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist),
+		STR_ARG("--service-coremask", "-s", "Hexadecimal bitmask of cores to use for service threads", service_coremask),
+		BOOL_ARG("--single-file-segments", NULL, "Store all pages within single files (per-page-size, per-node)", single_file_segments),
+		BOOL_ARG("--telemetry", NULL, "Enable telemetry", telemetry),
+		LIST_ARG("--vdev", NULL, "Add a virtual device to the system; format=<driver><id>[,key=val,...]", vdev),
+		BOOL_ARG("--vmware-tsc-map", NULL, "Use VMware TSC mapping instead of native RDTSC", vmware_tsc_map),
+		BOOL_ARG("--version", "-v", "Show version", version),
+
+#ifndef RTE_EXEC_ENV_WINDOWS
+		/* Linux and FreeBSD options*/
+		OPT_STR_ARG("--syslog", NULL, "Log to syslog (and optionally set facility)", syslog),
+		STR_ARG("--trace", NULL, "Enable trace based on regular expression trace name", trace),
+		STR_ARG("--trace-bufsz", NULL, "Trace buffer size", trace_bufsz),
+		STR_ARG("--trace-dir", NULL, "Trace directory", trace_dir),
+		STR_ARG("--trace-mode", NULL, "Trace mode", trace_mode),
+#endif
+
+#ifdef RTE_EXEC_ENV_LINUX
+		/* Linux-only options */
+		BOOL_ARG("--create-uio-dev", NULL, "Create /dev/uioX devices", create_uio_dev),
+		STR_ARG("--file-prefix", NULL, "Base filename of hugetlbfs files", file_prefix),
+		STR_ARG("--huge-dir", NULL, "Directory for hugepage files", huge_dir),
+		OPT_STR_ARG("--huge-worker-stack", NULL, "Allocate worker thread stacks from hugepage memory, with optional size (kB)", huge_worker_stack),
+		BOOL_ARG("--match-allocations", NULL, "Free hugepages exactly as allocated", match_allocations),
+		STR_ARG("--numa-mem", NULL, "Memory to allocate on NUMA nodes (comma separated values)", numa_mem),
+		STR_ARG("--numa-limit", NULL, "Limit memory allocation on NUMA nodes (comma separated values)", numa_limit),
+		STR_ARG("--socket-mem", NULL, "Alias for --numa-mem", numa_mem),
+		STR_ARG("--socket-limit", NULL, "Alias for --numa-limit", numa_limit),
+		STR_ARG("--vfio-intr", NULL, "VFIO interrupt mode (legacy|msi|msix)", vfio_intr),
+		STR_ARG("--vfio-vf-token", NULL, "VF token (UUID) shared between SR-IOV PF and VFs", vfio_vf_token),
+#endif
+		ARGPARSE_ARG_END(),
+	}
+};
+
 const char
 eal_short_options[] =
 	"a:" /* allow */
@@ -165,9 +383,6 @@ static int main_lcore_parsed;
 static int mem_parsed;
 static int core_parsed;
 
-/* Allow the application to print its usage message too if set */
-static rte_usage_hook_t rte_application_usage_hook;
-
 /* Returns rte_usage_hook_t */
 rte_usage_hook_t
 eal_get_application_usage_hook(void)
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
index 0d56b2083b..dec90059e1 100644
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

