Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5B6C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 16:41:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4199A40DD6;
	Tue, 20 May 2025 18:40:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5709740B9A
 for <dev@dpdk.org>; Tue, 20 May 2025 18:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747759248; x=1779295248;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+zGf+Fu2ThEemwTgehbk4w1vwdx4o0kjHxQls7RkTgg=;
 b=D4LJtUDz0sg8hvh3DAZzttu72XcTl2RR8TVP0veNZAQYs2XLJHmyPWer
 HRc4iYvEJURz+XnuSHiWPaEmPn0SgJODMXD/DKUcZoDxZc9pZbylaxfXs
 rI7vq2kQfwQDiulqz94/W4UXWXiwAB/aFjVeQSahnub7/AMyILNn7N97z
 H3CIqhkwBWDgHm2cVuiuugc3WSmdU+/19bixMy78zuMwhpBvpFoYRi5VX
 ReKCji6B2PqcKWlqwubgKbtI+KbgRNvJlGzq9E0nmTWIovz8J8ixDlwZA
 7m3AYwNnWnyILDbsHv4T+9a+5iQGchaeX+X2GVUOkfvRTnFPsklfedYhv g==;
X-CSE-ConnectionGUID: ABWSPT3DT+aAU7uaRTSb0g==
X-CSE-MsgGUID: GzZD24ctTM2pPobEoRrGVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37320473"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="37320473"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 09:40:48 -0700
X-CSE-ConnectionGUID: RGAe6tBrTRK7dalXrk/tYA==
X-CSE-MsgGUID: x7FnD0vrRG+PaLxrmbTm8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="170759485"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 09:40:46 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [RFC PATCH 4/7] eal: define the EAL parameters in argparse format
Date: Tue, 20 May 2025 17:40:21 +0100
Message-ID: <20250520164025.2055721-5-bruce.richardson@intel.com>
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

This table should allow us to parse all the eal args into a single
structure for later parsing in a fixed-order field basis. For those
elements that take multiple values, define a TAILQ and a callback to
process those elements.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---

Note: Within the structure to store the elements, each field has the
  same name as the cmdline parameter it corresponds to - just with "-"
  replaced by "_". This allows us to later write generic code using
  macros to check structure fields and auto-generate the error messages.

---
 lib/eal/common/eal_common_options.c | 418 ++++++++++++++++++++++++++++
 lib/eal/meson.build                 |   2 +-
 2 files changed, 419 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index a22dc69681..f0cccc1759 100644
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
@@ -47,6 +49,422 @@
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
+#define LIST_FLAGS (RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_SUPPORT_MULTI)
+#define STR_FLAGS (RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_STR)
+#define OPT_STR_FLAGS (RTE_ARGPARSE_ARG_OPTIONAL_VALUE | RTE_ARGPARSE_ARG_VALUE_STR)
+#define BOOL_FLAGS (RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_BOOL)
+
+struct rte_argparse eal_argparse  = {
+	.prog_name = "",
+	.usage = "<DPDK EAL options>",
+	.exit_on_error = true,
+	.callback = arg_list_callback,
+	.opaque = &args,
+	.args = {
+		/* list of EAL arguments as struct rte_argparse_arg.
+		 * For arguments which have an arg_list type, they use callback (no val_saver),
+		 * and have the SUPPORT_MULTI flag set (as well as REQUIRED_VALUE flag).
+		 * For arguments which have a string type, they use val_saver (no callback),
+		 * and normally REQUIRED_VALUE.
+		 * For flags which have optional arguments, they use both val_saver and val_set,
+		 * but still have a string type.
+		 * For boolean arguments, they use val_saver and val_set, with NO_VALUE flag.
+		 */
+		{
+			.name_long = "--allow",
+			.name_short = "-a",
+			.help = "Add device to allow-list",
+			.val_set = (void *)offsetof(struct eal_init_args, allow),
+			.flags = LIST_FLAGS
+		},
+		{
+			.name_long = "--base-virtaddr",
+			.help = "Base virtual address to reserve memory",
+			.val_saver = &args.base_virtaddr,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--block",
+			.name_short = "-b",
+			.help = "Add device to block-list",
+			.val_set = (void *)offsetof(struct eal_init_args, block),
+			.flags = LIST_FLAGS
+		},
+		{
+			.name_long = "--coremask",
+			.name_short = "-c",
+			.help = "Hexadecimal bitmask of cores to use",
+			.val_saver = &args.coremask,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--create-uio-dev",
+			.help = "Create /dev/uioX devices",
+			.val_saver = &args.create_uio_dev,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--driver-path",
+			.name_short = "-d",
+			.help = "Path to external driver shared object",
+			.val_set = (void *)offsetof(struct eal_init_args, driver_path),
+			.flags = LIST_FLAGS
+		},
+		{
+			.name_long = "--file-prefix",
+			.help = "Base filename of hugetlbfs files",
+			.val_saver = &args.file_prefix,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--force-max-simd-bitwidth",
+			.help = "Set max SIMD bitwidth to use in vector code paths",
+			.val_saver = &args.force_max_simd_bitwidth,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--huge-dir",
+			.help = "Directory for hugepage files",
+			.val_saver = &args.huge_dir,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--huge-unlink",
+			.help = "Unlink hugetlbfs files on exit (existing|always|never)",
+			.val_saver = &args.huge_unlink,
+			.val_set = (void *)1,
+			.flags = OPT_STR_FLAGS
+		},
+		{
+			.name_long = "--huge-worker-stack",
+			.help = "Allocate worker thread stacks from hugepage memory, with optional size (kB)",
+			.val_saver = &args.huge_worker_stack,
+			.val_set = (void *) 1,
+			.flags = OPT_STR_FLAGS
+		},
+		{
+			.name_long = "--in-memory",
+			.help = "DPDK should not create shared mmap files in filesystem",
+			.val_saver = &args.in_memory,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--iova-mode",
+			.help = "IOVA mapping mode, physical (pa)/virtual (va)",
+			.val_saver = &args.iova_mode,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--lcores",
+			.name_short = "-l",
+			.help = "List of CPU cores to use",
+			.val_saver = &args.lcores,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--legacy-mem",
+			.help = "Enable legacy memory behavior",
+			.val_saver = &args.legacy_mem,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--log-color",
+			.help = "Enable/disable color in log output",
+			.val_saver = &args.log_color,
+			.val_set = (void *)1,
+			.flags = OPT_STR_FLAGS
+		},
+		{
+			.name_long = "--log-level",
+			.help = "Log level for all loggers",
+			.val_saver = &args.log_level,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--log-timestamp",
+			.help = "Enable/disable timestamp in log output",
+			.val_saver = &args.log_timestamp,
+			.val_set = (void *)1,
+			.flags = OPT_STR_FLAGS
+		},
+		{
+			.name_long = "--main-lcore",
+			.help = "Select which core to use for the main thread",
+			.val_saver = &args.main_lcore,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--match-allocations",
+			.help = "Free hugepages exactly as allocated",
+			.val_saver = &args.match_allocations,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--mbuf-pool-ops-name",
+			.help = "User defined mbuf default pool ops name",
+			.val_saver = &args.mbuf_pool_ops_name,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--memory-channels",
+			.name_short = "-n",
+			.help = "Number of memory channels per socket",
+			.val_saver = &args.memory_channels,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--memory-ranks",
+			.name_short = "-r",
+			.help = "Number of memory ranks",
+			.val_saver = &args.memory_ranks,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--memory-size",
+			.name_short = "-m",
+			.help = "Total size of memory to allocate initially",
+			.val_saver = &args.memory_size,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--no-hpet",
+			.help = "Disable HPET timer",
+			.val_saver = &args.no_hpet,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--no-huge",
+			.help = "Disable hugetlbfs support",
+			.val_saver = &args.no_huge,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--no-pci",
+			.help = "Disable all PCI devices",
+			.val_saver = &args.no_pci,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--no-shconf",
+			.help = "Disable shared config file generation",
+			.val_saver = &args.no_shconf,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+				{
+			.name_long = "--no-telemetry",
+			.help = "Disable telemetry",
+			.val_saver = &args.no_telemetry,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--proc-type",
+			.help = "Type of process (primary/secondary)",
+			.val_saver = &args.proc_type,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--service-corelist",
+			.name_short = "-S",
+			.help = "List of cores to use for service threads",
+			.val_saver = &args.service_corelist,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--service-coremask",
+			.name_short = "-s",
+			.help = "Hexadecimal bitmask of cores to use for service threads",
+			.val_saver = &args.service_coremask,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--single-file-segments",
+			.help = "Store all pages within single files (per-page-size, per-node)",
+			.val_saver = &args.single_file_segments,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--socket-mem",
+			.help = "List of memory sizes to be allocated per socket on init",
+			.val_saver = &args.socket_mem,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--socket-limit",
+			.help = "Memory limits per socket",
+			.val_saver = &args.socket_limit,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--syslog",
+			.help = "Log to syslog (and optionally set facility)",
+			.val_saver = &args.syslog,
+			.val_set = (void *)1,
+			.flags = OPT_STR_FLAGS
+		},
+		{
+			.name_long = "--telemetry",
+			.help = "Enable telemetry",
+			.val_saver = &args.telemetry,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--trace",
+			.help = "Enable trace based on regular expression trace name",
+			.val_saver = &args.trace,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--trace-bufsz",
+			.help = "Trace buffer size",
+			.val_saver = &args.trace_bufsz,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--trace-dir",
+			.help = "Trace directory",
+			.val_saver = &args.trace_dir,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--trace-mode",
+			.help = "Trace mode",
+			.val_saver = &args.trace_mode,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--vdev",
+			.help = "Virtual device to add to the system",
+			.val_set = (void *)offsetof(struct eal_init_args, vdev),
+			.flags = LIST_FLAGS
+		},
+		{
+			.name_long = "--vfio-intr",
+			.help = "VFIO interrupt mode (legacy|msi|msix)",
+			.val_saver = &args.vfio_intr,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--vfio-vf-token",
+			.help = "VF token (UUID) shared between SR-IOV PF and VFs",
+			.val_saver = &args.vfio_vf_token,
+			.flags = STR_FLAGS
+		},
+		{
+			.name_long = "--vmware-tsc-map",
+			.help = "Use VMware TSC mapping instead of native RDTSC",
+			.val_saver = &args.vmware_tsc_map,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
+		{
+			.name_long = "--version",
+			.name_short = "-v",
+			.help = "Show version",
+			.val_saver = &args.version,
+			.val_set = (void *)1,
+			.flags = BOOL_FLAGS
+		},
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
--
2.48.1

