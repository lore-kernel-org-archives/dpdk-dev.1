Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E0C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CE9A406B6;
	Thu, 20 Aug 2026 16:25:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 543D44069F;
 Thu, 20 Aug 2026 16:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787235919; x=1818771919;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4GbCO+qVe9a88FztS1iwjgET7l5PbeyIDlsrGrnGtfc=;
 b=O1yeBEsf7d21oCKTbzH0T6fzEplrVOmjgk2NykpEV3aK6jrd7365qv/M
 MA2aWZ3bCUM0GK9dHGE3rQ42fzcbIxLXEifRberiJjRICi0lcOPKeIO5m
 +fzzpBg0qRCpGHzlT7k3bxSPPMRoMnYs+HamVYmFYMXNIYYaUfDoMVQkj
 7W+Mm9Ye4wuJ3W1pFEisvUukf2BPQPSqA+6aj8RUxgruKwRIdOkm2ntBI
 xCYNYuKwE02Ghj7qIuC84aDRMjSbQTanB9F0dK2ajab3tHnegDPSUO7/b
 3dvFEiflPh5K1xRVzN3WjXaW1yFr2GN9umMqrn5PtLRPkDCQjNjJRzv5l A==;
X-CSE-ConnectionGUID: VclgYr1TTIyk8GH/BW5GZw==
X-CSE-MsgGUID: RfvBfPeUTuykCZh/zI877Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113311561"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="113311561"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:25:19 -0700
X-CSE-ConnectionGUID: SFcpYF+ZTU+n+q3MRjga0A==
X-CSE-MsgGUID: TzRelaONRF6QcWrYJoWI+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="269878703"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 20 Aug 2026 07:25:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 1/3] app/test-mempool-perf: skeleton of new test app
Date: Thu, 20 Aug 2026 15:24:37 +0100
Message-ID: <20260820142439.3684311-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820142439.3684311-1-bruce.richardson@intel.com>
References: <20260820142439.3684311-1-bruce.richardson@intel.com>
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

Start a new app for running some performance tests of mempool drivers
with different parameters. If run with no parameters, prompt for the
options to use.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/meson.build                   |   1 +
 app/test-mempool-perf/main.c      | 330 ++++++++++++++++++++++++++++++
 app/test-mempool-perf/meson.build |   8 +
 doc/guides/tools/index.rst        |   1 +
 doc/guides/tools/mempoolperf.rst  | 139 +++++++++++++
 5 files changed, 479 insertions(+)
 create mode 100644 app/test-mempool-perf/main.c
 create mode 100644 app/test-mempool-perf/meson.build
 create mode 100644 doc/guides/tools/mempoolperf.rst

diff --git a/app/meson.build b/app/meson.build
index 1798db3ae4..81f36f497b 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -31,6 +31,7 @@ apps = [
         'test-pipeline',
         'test-pmd',
         'test-regex',
+        'test-mempool-perf',
         'test-sad',
         'test-security-perf',
 ]
diff --git a/app/test-mempool-perf/main.c b/app/test-mempool-perf/main.c
new file mode 100644
index 0000000000..877abc2170
--- /dev/null
+++ b/app/test-mempool-perf/main.c
@@ -0,0 +1,330 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <inttypes.h>
+
+#include <rte_argparse.h>
+#include <rte_eal.h>
+#include <rte_lcore.h>
+#include <rte_mempool.h>
+#include <rte_string_fns.h>
+
+#define DEFAULT_CACHE_SIZE          512
+#define DEFAULT_RAND_FACTOR         8
+#define DEFAULT_BURST_SIZE          32
+#define DEFAULT_NB_BUFS_PER_LCORE   1024
+
+struct test_config {
+	char     mempool_type[RTE_MEMPOOL_NAMESIZE];
+	uint32_t nb_bufs;
+	uint32_t cache_size;
+	uint32_t nb_threads;
+	uint32_t rand_factor;
+	uint32_t burst_size;
+	bool     access_on_alloc;
+};
+
+static struct test_config cfg = {
+	.mempool_type   = "",
+	.nb_bufs        = 0,  /* 0 means: compute from lcore count */
+	.cache_size     = DEFAULT_CACHE_SIZE,
+	.nb_threads     = 0,  /* 0 means: use all worker lcores */
+	.rand_factor    = DEFAULT_RAND_FACTOR,
+	.burst_size     = DEFAULT_BURST_SIZE,
+	.access_on_alloc = true,
+};
+
+static void
+apply_defaults(void)
+{
+	unsigned int nb_workers;
+
+	nb_workers = rte_lcore_count() > 1 ? rte_lcore_count() - 1 : 1;
+
+	if (cfg.nb_bufs == 0)
+		cfg.nb_bufs = DEFAULT_NB_BUFS_PER_LCORE * rte_lcore_count();
+	if (cfg.nb_threads == 0)
+		cfg.nb_threads = nb_workers;
+}
+
+static bool
+is_valid_mempool_type(const char *name)
+{
+	uint32_t i;
+
+	for (i = 0; i < rte_mempool_ops_table.num_ops; i++)
+		if (strcmp(name, rte_mempool_ops_table.ops[i].name) == 0)
+			return true;
+	return false;
+}
+
+static void
+list_mempool_types(void)
+{
+	uint32_t i;
+
+	printf("Available mempool types:\n");
+	for (i = 0; i < rte_mempool_ops_table.num_ops; i++)
+		printf("  [%u] %s\n", i, rte_mempool_ops_table.ops[i].name);
+}
+
+static void
+print_config(void)
+{
+	printf("\n=== test-mempool-perf configuration ===\n");
+	printf("  Mempool type     : %s\n", cfg.mempool_type);
+	printf("  Num buffers      : %" PRIu32 "\n", cfg.nb_bufs);
+	printf("  Cache size       : %" PRIu32 "\n", cfg.cache_size);
+	printf("  Thread count     : %" PRIu32 "\n", cfg.nb_threads);
+	printf("  Randomness factor: %" PRIu32 "\n", cfg.rand_factor);
+	printf("  Burst size       : %" PRIu32 "\n", cfg.burst_size);
+	printf("  Access on alloc  : %s\n", cfg.access_on_alloc ? "yes" : "no");
+	printf("========================================\n\n");
+}
+
+static void
+print_reproduce_cmd(void)
+{
+	printf("Reproduce using parameters:"
+		" -M %s -n %" PRIu32 " -c %" PRIu32 " -t %" PRIu32 " -r %" PRIu32 " -b %" PRIu32 " %s\n\n",
+			cfg.mempool_type, cfg.nb_bufs, cfg.cache_size, cfg.nb_threads, cfg.rand_factor,
+			cfg.burst_size, cfg.access_on_alloc ? "-A" : "-N");
+}
+
+static void
+trim_newline(char *s)
+{
+	size_t len = strlen(s);
+
+	if (len > 0 && s[len - 1] == '\n')
+		s[len - 1] = '\0';
+}
+
+static int
+prompt_uint32(const char *prompt, uint32_t *val)
+{
+	char buf[64];
+	char *end;
+	unsigned long v;
+
+	fputs(prompt, stdout);
+	fflush(stdout);
+	if (fgets(buf, sizeof(buf), stdin) == NULL)
+		return -1;
+	trim_newline(buf);
+	if (buf[0] == '\0')
+		return 0;  /* keep default */
+
+	v = strtoul(buf, &end, 0);
+	if (*end != '\0') {
+		fprintf(stderr, "Invalid number: %s\n", buf);
+		return -1;
+	}
+	*val = (uint32_t)v;
+	return 1;
+}
+
+static int
+run_interactive_mode(void)
+{
+	char prompt[128];
+	char buf[RTE_MEMPOOL_NAMESIZE];
+
+	printf("\n=== test-mempool-perf interactive setup ===\n");
+	printf("Press Enter to accept the default value.\n\n");
+
+	list_mempool_types();
+	printf("\n");
+
+	/* Mempool type is required; loop until a valid name is entered */
+	for (;;) {
+		printf("Mempool type (required): ");
+		fflush(stdout);
+		if (fgets(buf, sizeof(buf), stdin) == NULL)
+			return -1;
+		trim_newline(buf);
+		if (buf[0] == '\0') {
+			printf("  A mempool type is required; please enter one of the names above.\n");
+			continue;
+		}
+		if (is_valid_mempool_type(buf))
+			break;
+		printf("  Unknown mempool type '%s'; please enter one of the names above.\n", buf);
+	}
+	rte_strscpy(cfg.mempool_type, buf, sizeof(cfg.mempool_type));
+
+	/* Compute numeric defaults now that EAL is initialised */
+	apply_defaults();
+
+	/* Number of buffers */
+	snprintf(prompt, sizeof(prompt),
+		 "Number of buffers [%" PRIu32 "]: ", cfg.nb_bufs);
+	if (prompt_uint32(prompt, &cfg.nb_bufs) < 0)
+		return -1;
+
+	/* Cache size */
+	snprintf(prompt, sizeof(prompt),
+		 "Cache size [%" PRIu32 "]: ", cfg.cache_size);
+	if (prompt_uint32(prompt, &cfg.cache_size) < 0)
+		return -1;
+
+	/* Thread count */
+	snprintf(prompt, sizeof(prompt),
+		 "Thread count [%" PRIu32 "]: ", cfg.nb_threads);
+	if (prompt_uint32(prompt, &cfg.nb_threads) < 0)
+		return -1;
+
+	/* Randomness factor */
+	snprintf(prompt, sizeof(prompt),
+		 "Randomness factor [%" PRIu32 "]: ", cfg.rand_factor);
+	if (prompt_uint32(prompt, &cfg.rand_factor) < 0)
+		return -1;
+
+	/* Burst size */
+	snprintf(prompt, sizeof(prompt),
+		 "Burst size [%" PRIu32 "]: ", cfg.burst_size);
+	if (prompt_uint32(prompt, &cfg.burst_size) < 0)
+		return -1;
+	/* Access on allocation */
+	printf("Access buffers on allocation [%s]: ",
+	       cfg.access_on_alloc ? "yes" : "no");
+	fflush(stdout);
+	{
+		char yn[16];
+
+		if (fgets(yn, sizeof(yn), stdin) == NULL)
+			return -1;
+		trim_newline(yn);
+		if (yn[0] == 'y' || yn[0] == 'Y')
+			cfg.access_on_alloc = true;
+		else if (yn[0] == 'n' || yn[0] == 'N')
+			cfg.access_on_alloc = false;
+		/* else keep default */
+	}
+
+	return 0;
+}
+
+static bool summary_only;
+
+/* Used only in non-interactive mode to receive the --mempool-type string */
+static const char *mempool_type_arg;
+
+static int
+parse_args(int argc, char **argv)
+{
+	static struct rte_argparse obj = {
+		.prog_name = "test-mempool-perf",
+		.usage = "[EAL options] -- [options]",
+		.descriptor = "Mempool performance tester",
+		.exit_on_error = true,
+		.args = {
+			{ "--mempool-type", "-M",
+			  "Mempool driver to test (required in non-interactive mode)",
+			  (void *)&mempool_type_arg, NULL,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_STR,
+			},
+			{ "--nb-bufs", "-n",
+			  "Number of buffers in the pool (default: 1024 * lcore count)",
+			  (void *)&cfg.nb_bufs, NULL,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U32,
+			},
+			{ "--cache-size", "-c",
+			  "Per-lcore object cache size (default: 512)",
+			  (void *)&cfg.cache_size, NULL,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U32,
+			},
+			{ "--nb-threads", "-t",
+			  "Number of worker threads to use (default: all worker lcores)",
+			  (void *)&cfg.nb_threads, NULL,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U32,
+			},
+			{ "--rand-factor", "-r",
+			  "Randomness factor for alloc/free burst sizes (default: 8)",
+			  (void *)&cfg.rand_factor, NULL,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U32,
+			},
+			{ "--burst-size", "-b",
+			  "Number of objects per alloc/free burst (default: 32)",
+			  (void *)&cfg.burst_size, NULL,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U32,
+			},
+			{ "--access-on-alloc", "-A",
+			  "Enable touching buffer memory on allocation (default: enabled)",
+			  (void *)&cfg.access_on_alloc, (void *)true,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_BOOL,
+			},
+			{ "--no-access-on-alloc", "-N",
+			  "Disable touching buffer memory on allocation",
+			  (void *)&cfg.access_on_alloc, (void *)false,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_BOOL,
+			},
+			{ "--summary", "-s",
+			  "Print only the aggregate total, not per-lcore results",
+			  (void *)&summary_only, (void *)true,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_BOOL,
+			},
+			ARGPARSE_ARG_END(),
+		},
+	};
+	int ret;
+
+	ret = rte_argparse_parse(&obj, argc, argv);
+	if (ret < 0)
+		return ret;
+
+	if (mempool_type_arg != NULL)
+		rte_strscpy(cfg.mempool_type, mempool_type_arg,
+			    sizeof(cfg.mempool_type));
+
+	return 0;
+}
+
+int
+main(int argc, char **argv)
+{
+	int ret;
+
+	ret = rte_eal_init(argc, argv);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE, "Invalid EAL arguments\n");
+	argc -= ret;
+	argv += ret;
+
+	if (argc == 1) {
+		/* No app-specific arguments: enter interactive configuration */
+		ret = run_interactive_mode();
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE, "Interactive configuration failed\n");
+		print_reproduce_cmd();
+	} else {
+		ret = parse_args(argc, argv);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE, "Invalid application arguments\n");
+
+		if (cfg.mempool_type[0] == '\0') {
+			fprintf(stderr,
+				"Error: --mempool-type is required in non-interactive mode\n");
+			list_mempool_types();
+			rte_exit(EXIT_FAILURE, "Mempool type not specified\n");
+		}
+		if (!is_valid_mempool_type(cfg.mempool_type)) {
+			fprintf(stderr, "Error: unknown mempool type '%s'\n",
+				cfg.mempool_type);
+			list_mempool_types();
+			rte_exit(EXIT_FAILURE, "Invalid mempool type\n");
+		}
+
+		apply_defaults();
+	}
+
+	print_config();
+
+	rte_eal_cleanup();
+	return 0;
+}
diff --git a/app/test-mempool-perf/meson.build b/app/test-mempool-perf/meson.build
new file mode 100644
index 0000000000..2d61ac62e9
--- /dev/null
+++ b/app/test-mempool-perf/meson.build
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 Intel Corporation
+
+deps += ['mempool', 'argparse']
+
+sources = files(
+        'main.c',
+)
diff --git a/doc/guides/tools/index.rst b/doc/guides/tools/index.rst
index 13f75a5bc6..cb71ba7b55 100644
--- a/doc/guides/tools/index.rst
+++ b/doc/guides/tools/index.rst
@@ -17,6 +17,7 @@ DPDK Tools User Guides
     telemetrywatcher
     dmaperf
     flow-perf
+    mempoolperf
     securityperf
     testbbdev
     cryptoperf
diff --git a/doc/guides/tools/mempoolperf.rst b/doc/guides/tools/mempoolperf.rst
new file mode 100644
index 0000000000..e0ad859a29
--- /dev/null
+++ b/doc/guides/tools/mempoolperf.rst
@@ -0,0 +1,139 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2024 Intel Corporation
+
+dpdk-test-mempool-perf Application
+====================================
+
+The ``dpdk-test-mempool-perf`` tool measures the alloc/free throughput of DPDK mempool implementations.
+Worker threads repeatedly allocate and free objects in configurable burst sizes following a randomised pattern,
+exercising the pool under varying levels of occupancy.
+Any mempool driver registered with the DPDK mempool ops table can be tested.
+
+
+Running the Application
+-----------------------
+
+.. code-block:: console
+
+   dpdk-test-mempool-perf [EAL options] -- [application options]
+
+See the *DPDK Getting Started Guide* for a description of EAL options.
+
+The application operates in two modes depending on whether application-specific options are supplied after ``--``:
+
+interactive
+   Invoked with no options or only EAL options (nothing after ``--``, or ``--`` omitted).
+   The tool prompts for each parameter in turn; pressing Enter accepts the displayed default.
+   After configuration, a command line is printed that reproduces the same settings non-interactively.
+
+non-interactive
+   All configuration is supplied on the command line.
+   ``--mempool-type`` is required; all other parameters are optional.
+
+
+Application Options
+~~~~~~~~~~~~~~~~~~~
+
+``--mempool-type <name>`` / ``-M <name>``
+   Name of the mempool driver to test.
+   Required in non-interactive mode.
+   To list the drivers available on the current system,
+   run the application in interactive mode; the available names are printed at startup.
+   Common names include ``ring_mp_mc`` and ``stack``.
+
+``--nb-bufs <n>`` / ``-n <n>``
+   Total number of objects in the pool.
+   Default: 1024 multiplied by the total lcore count.
+   The pool must be large enough that it is not exhausted when all workers hold their maximum simultaneous in-flight objects,
+   which is ``(rand-factor / 2) * burst-size`` objects per worker.
+
+``--cache-size <n>`` / ``-c <n>``
+   Per-lcore object cache size, in objects.
+   Default: 512.
+   A larger cache reduces contention on the central pool at the cost of higher per-core memory usage.
+   Set to 0 to disable the per-lcore cache and measure underlying data structure throughput.
+
+``--nb-threads <n>`` / ``-t <n>``
+   Number of worker lcores to launch.
+   Default: all available worker lcores (total lcores minus the main lcore).
+
+``--rand-factor <n>`` / ``-r <n>``
+   Controls the width of the randomised allocation pattern.
+   Default: 8.
+   The value is rounded down to the nearest even number (minimum 2).
+   Half of the resulting slots perform bulk allocations and half perform bulk frees;
+   the order is reshuffled randomly at regular intervals.
+   A larger value means workers hold more in-flight objects on average
+   and vary their occupancy over a wider range,
+   exercising the pool under a more realistic mix of pressure levels.
+
+``--burst-size <n>`` / ``-b <n>``
+   Number of objects per alloc or free call.
+   Default: 32.
+   Higher burst sizes amortise per-call overhead
+   and can reveal differences between pool implementations that batch internal operations.
+
+``--access-on-alloc`` / ``-A``
+   Touch every cache line of each allocated object immediately after allocation (default behaviour).
+   This models workloads that initialise or write packet data after allocation,
+   ensuring that the measured throughput reflects both pool overhead and memory bandwidth pressure.
+
+``--no-access-on-alloc`` / ``-N``
+   Skip the memory-access step after allocation.
+   Use this to isolate pure pool ring or lock overhead from memory bandwidth effects.
+
+``--summary`` / ``-s``
+   Print only the aggregate total in the results, suppressing the per-worker-lcore breakdown.
+   Useful when scripting comparisons across pool types or configurations.
+
+
+Interactive Mode
+----------------
+
+Running the tool with only EAL options enters interactive mode::
+
+   dpdk-test-mempool-perf [EAL options]
+
+The application lists all available mempool drivers then prompts for each parameter.
+Pressing Enter at any prompt keeps the displayed default value.
+``--mempool-type`` is the only mandatory entry.
+
+After configuration the tool prints an equivalent non-interactive command::
+
+   Reproduce using parameters: -M ring_mp_mc -n 4096 -c 512 -t 3 -r 8 -b 32 -A
+
+Append this output after the EAL options on subsequent runs to reproduce the exact same configuration without prompting.
+
+
+Examples
+--------
+
+Run interactively, letting the tool prompt for all settings:
+
+.. code-block:: console
+
+   dpdk-test-mempool-perf -l 0-3
+
+Run non-interactively with four worker threads:
+
+.. code-block:: console
+
+   dpdk-test-mempool-perf -l 0-4 -- -M ring_mp_mc -t 4 -n 20480
+
+Disable the per-lcore cache to measure raw ring throughput:
+
+.. code-block:: console
+
+   dpdk-test-mempool-perf -l 0-1 -- -M ring_mp_mc -c 0
+
+Measure without memory access to isolate pool overhead from bandwidth:
+
+.. code-block:: console
+
+   dpdk-test-mempool-perf -l 0-4 -- -M ring_mp_mc -N
+
+Print only the aggregate total, suitable for scripted comparisons:
+
+.. code-block:: console
+
+   dpdk-test-mempool-perf -l 0-4 -- -M ring_mp_mc -s
-- 
2.53.0

