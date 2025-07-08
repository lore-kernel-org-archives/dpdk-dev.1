Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390C5C83F0A
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 17:21:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E254640BA6;
	Tue,  8 Jul 2025 19:20:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3182C40BA6
 for <dev@dpdk.org>; Tue,  8 Jul 2025 19:20:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751995254; x=1783531254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SZuQcmCM4wag162Cn7SNOad50BjnyqbsFlMXzoKpUs0=;
 b=Sy6EwBDOLlhQqySoWCtUG3/CFbzVVnKSGWXLuHtj54Jd6G+ceBEDURDH
 zh4sjlFUPZPgLIhu4wxF1DTRF85p6FQUO3Y3n2QbIqRQuwjuX0nvWWYzQ
 T/PBBT2qIC8fGytiD0jUsOGlIQMrZC/BZbzOUCPZTZio/nSe/e3mwvZk6
 Wp9kc31TD3ezYc9rJZRl4c2j5IYaWS5wEEw9iCwc+gvIfW+uM/T0rE++k
 SwuF4yxt9ReSHheovVQOVbiBSMaikyt8MA8e6hPJcN3mmigC4u8GcxU27
 AGj/x6PXLcnUMnzKHe07+l13KNf3FKt7Z27RsnNQnN8MIBDPExh8xUoLc w==;
X-CSE-ConnectionGUID: QlbVygjWSZ6yDVCR7joVCg==
X-CSE-MsgGUID: gdMx5HQDSnWBrWsEV6yfvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57913124"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57913124"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 10:20:53 -0700
X-CSE-ConnectionGUID: sTojXN+DTnKlliDHUQkCVw==
X-CSE-MsgGUID: rdgpiuFRTnm0EVelilsaMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="161200624"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by orviesa005.jf.intel.com with ESMTP; 08 Jul 2025 10:20:51 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v2 2/5] eal: define the EAL parameters in argparse format
Date: Tue,  8 Jul 2025 17:20:36 +0000
Message-ID: <20250708172039.183989-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250708172039.183989-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250708172039.183989-1-bruce.richardson@intel.com>
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
 lib/eal/common/eal_common_options.c | 192 ++++++++++++++++++++++++++++
 lib/eal/meson.build                 |   2 +-
 lib/meson.build                     |   1 +
 3 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index cafae9d9d7..7558206f93 100644
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
@@ -47,6 +49,196 @@
 #define LCORE_OPT_LST 1
 #define LCORE_OPT_MSK 2
 
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
+	char *proc_type;
+	char *service_coremask;
+	char *service_corelist;
+	bool single_file_segments;
+	char *socket_mem;
+	char *socket_limit;
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
+	.exit_on_error = true,
+	.callback = arg_list_callback,
+	.opaque = &args,
+	.args = {
+		/* list of EAL arguments as struct rte_argparse_arg. */
+		LIST_ARG("--allow", "-a", "Add device to allow-list", allow),
+		STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory", base_virtaddr),
+		LIST_ARG("--block", "-b", "Add device to block-list", block),
+		STR_ARG("--coremask", "-c", "Hexadecimal bitmask of cores to use", coremask),
+		BOOL_ARG("--create-uio-dev", NULL, "Create /dev/uioX devices", create_uio_dev),
+		LIST_ARG("--driver-path", "-d", "Path to external driver shared object", driver_path),
+		STR_ARG("--file-prefix", NULL, "Base filename of hugetlbfs files", file_prefix),
+		STR_ARG("--force-max-simd-bitwidth", NULL, "Set max SIMD bitwidth to use in vector code paths", force_max_simd_bitwidth),
+		STR_ARG("--huge-dir", NULL, "Directory for hugepage files", huge_dir),
+		OPT_STR_ARG("--huge-unlink", NULL, "Unlink hugetlbfs files on exit (existing|always|never)", huge_unlink),
+		OPT_STR_ARG("--huge-worker-stack", NULL, "Allocate worker thread stacks from hugepage memory, with optional size (kB)", huge_worker_stack),
+		BOOL_ARG("--in-memory", NULL, "DPDK should not create shared mmap files in filesystem", in_memory),
+		STR_ARG("--iova-mode", NULL, "IOVA mapping mode, physical (pa)/virtual (va)", iova_mode),
+		STR_ARG("--lcores", "-l", "List of CPU cores to use", lcores),
+		BOOL_ARG("--legacy-mem", NULL, "Enable legacy memory behavior", legacy_mem),
+		OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color),
+		STR_ARG("--log-level", NULL, "Log level for all loggers", log_level),
+		OPT_STR_ARG("--log-timestamp", NULL, "Enable/disable timestamp in log output", log_timestamp),
+		STR_ARG("--main-lcore", NULL, "Select which core to use for the main thread", main_lcore),
+		BOOL_ARG("--match-allocations", NULL, "Free hugepages exactly as allocated", match_allocations),
+		STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name", mbuf_pool_ops_name),
+		STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels),
+		STR_ARG("--memory-ranks", "-r", "Number of memory ranks", memory_ranks),
+		STR_ARG("--memory-size", "-m", "Total size of memory to allocate initially", memory_size),
+		BOOL_ARG("--no-hpet", NULL, "Disable HPET timer", no_hpet),
+		BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge),
+		BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci),
+		BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf),
+		BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry),
+		STR_ARG("--proc-type", NULL, "Type of process (primary/secondary)", proc_type),
+		STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist),
+		STR_ARG("--service-coremask", "-s", "Hexadecimal bitmask of cores to use for service threads", service_coremask),
+		BOOL_ARG("--single-file-segments", NULL, "Store all pages within single files (per-page-size, per-node)", single_file_segments),
+		STR_ARG("--socket-mem", NULL, "List of memory sizes to be allocated per socket on init", socket_mem),
+		STR_ARG("--socket-limit", NULL, "Memory limits per socket", socket_limit),
+		OPT_STR_ARG("--syslog", NULL, "Log to syslog (and optionally set facility)", syslog),
+		BOOL_ARG("--telemetry", NULL, "Enable telemetry", telemetry),
+		STR_ARG("--trace", NULL, "Enable trace based on regular expression trace name", trace),
+		STR_ARG("--trace-bufsz", NULL, "Trace buffer size", trace_bufsz),
+		STR_ARG("--trace-dir", NULL, "Trace directory", trace_dir),
+		STR_ARG("--trace-mode", NULL, "Trace mode", trace_mode),
+		LIST_ARG("--vdev", NULL, "Virtual device to add to the system", vdev),
+		STR_ARG("--vfio-intr", NULL, "VFIO interrupt mode (legacy|msi|msix)", vfio_intr),
+		STR_ARG("--vfio-vf-token", NULL, "VF token (UUID) shared between SR-IOV PF and VFs", vfio_vf_token),
+		BOOL_ARG("--vmware-tsc-map", NULL, "Use VMware TSC mapping instead of native RDTSC", vmware_tsc_map),
+		BOOL_ARG("--version", "-v", "Show version", version),
+		ARGPARSE_ARG_END(),
+	}
+};
+
 const char
 eal_short_options[] =
 	"a:" /* allow */
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

