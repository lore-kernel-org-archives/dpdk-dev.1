Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B0CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:03:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58136410F1;
	Wed, 29 Apr 2026 18:59:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 90F4540E78;
 Wed, 29 Apr 2026 18:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481973; x=1809017973;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N3UoMCfYHYvnwUr7WAiddpmjioD1wt9WK5sSUNdP8PU=;
 b=VZG5CcwmGX6jO7liJuUJQAjjlpCGozWY94Txzf1RieiIZtTNDXiENxNx
 tSgF0dc4bBy6g/EmrAZ5JaPaGN/vL/zNRh5XmWkhnQjVi6IosevkvKz9G
 Y1G9oZbZCulxu3j1iCgzMQUY36859hFUPEL8iIrebrbbNTkExK3hvoOlH
 mMevbws0/oLsqfvflF9ZmaEV4tBrvnHDfUEQx6haBvw3mcu5vp4w2iEua
 x0PQAkkj0PrbknMDGX9OvfsC2L8mMvTpOBMpR9LWf9ro50EkBKqjR3xXV
 wgksjk2UDi2RsUxbLYEjq8WhfsizOVyg1q8cAsILJvp7ap+qCV17xdAll Q==;
X-CSE-ConnectionGUID: 5W4Wei7TTh++L4FitJNBaQ==
X-CSE-MsgGUID: xSrqwkK+T1eMdACRLhJgGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725351"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725351"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:33 -0700
X-CSE-ConnectionGUID: O0gLedZzSamHjudEPc15cQ==
X-CSE-MsgGUID: sU/b0r7gQm6gUSg8SFVrCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697035"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:31 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 29/44] eal: clarify docs on params taking lcore IDs
Date: Wed, 29 Apr 2026 17:58:21 +0100
Message-ID: <20260429165845.2136843-30-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

The documentation doesn't make clear how the parameters to the service
core mask and core list parameters (or the main lcore parameter for that
matter) related to the provided lcore lists, or lcore mappings.

When using the "-R" flag, for example, as "/path/to/app -R -l 40-50",
(which will configure lcores 0-10 to run on CPUs 40-50 respectively) in
order to run service cores, it's not entirely clear whether the
parameter should be "-S 49-50" i.e. physical CPU ids, or "-S 9-10" i.e.
logical lcore IDs. Update the docs to make it clear its the latter.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst | 38 +++++++++++++++++++++--
 lib/eal/common/eal_option_list.h          |  6 ++--
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 32c24c8e41..33281ecec3 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -89,13 +89,45 @@ Lcore-related options
     and the use of ``()`` for core groupings,
     are not allowed when ``-R`` or ``--remap-lcore-ids`` is also used.

-*   ``--main-lcore <core ID>``
+*   ``--main-lcore <lcore ID>``

-    Core ID that is used as main.
+    Set the lcore ID to use for the main thread.
+    The value is a DPDK lcore ID, not a physical CPU ID,
+    and must be present in the enabled lcore set (as configured by ``-l``/``--lcores``).
+
+    In the simple case, without any explicit lcore-to-CPU mapping,
+    lcore IDs equal physical CPU IDs so the distinction does not matter.
+    The two differ when ``-R``/``--remap-lcore-ids`` assigns sequential lcore IDs to higher-numbered physical CPUs,
+    or when the ``@`` mapping syntax in ``--lcores`` is used.
+    In those cases the lcore ID must be specified here, not the physical CPU ID.
+
+    Example using ``--lcores`` explicit mapping:
+    ``--lcores=1@31,2@32,3@33 --main-lcore 2`` selects the thread with lcore ID 2,
+    running on physical CPU 32, as the main thread.
+
+    Example using ``-R`` remapping:
+    ``-l 31-33 -R --main-lcore 1`` starts three threads on physical CPUs 31, 32 and 33, remapped to lcore IDs 0, 1 and 2.
+    ``--main-lcore 1`` selects the thread remapped to lcore ID 1, which runs on physical CPU 32.

 *   ``-S, --service-corelist <service core list>``

-    List of cores to be used as service cores.
+    List of lcore IDs to be used as service cores.
+    The list format is the same as for ``-l``/``--lcores``:
+    a comma-separated set of lcore IDs or ranges (e.g. ``2,3`` or ``2-5``).
+    Each specified lcore ID must be present in the enabled lcore set.
+
+    The values are lcore IDs, not physical CPU IDs.
+    In the simple case, without any explicit lcore-to-CPU mapping, the two are equal so the distinction does not matter.
+    When using ``-R``/``--remap-lcore-ids`` or the ``@`` mapping syntax in ``--lcores``, lcore IDs and physical CPU IDs differ,
+    and the lcore IDs must be used here.
+
+    Example using ``--lcores`` explicit mapping:
+    ``--lcores=1@31,2@32,3@33 -S 2,3`` assigns the threads with
+    lcore IDs 2 and 3 (running on physical CPUs 32 and 33) as service cores.
+
+    Example using ``-R`` remapping:
+    ``-l 31-33 -R -S 1,2`` starts three threads on physical CPUs 31, 32 and 33, remapped to lcore IDs 0, 1 and 2.
+    ``-S 1,2`` assigns the threads with lcore IDs 1 and 2 (running on physical CPUs 32 and 33) as service cores.


 Device-related options
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index 6a5ddfd8d1..7ac2e8eadd 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -47,7 +47,7 @@ BOOL_ARG("--legacy-mem", NULL, "Enable legacy memory behavior", legacy_mem)
 OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color)
 LIST_ARG("--log-level", NULL, "Log level for loggers; use log-level=help for list of log types and levels", log_level)
 OPT_STR_ARG("--log-timestamp", NULL, "Enable/disable timestamp in log output", log_timestamp)
-STR_ARG("--main-lcore", NULL, "Select which core to use for the main thread", main_lcore)
+STR_ARG("--main-lcore", NULL, "Lcore ID to use for the main thread", main_lcore)
 STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name", mbuf_pool_ops_name)
 STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels)
 STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks)
@@ -60,8 +60,8 @@ BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf
 BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry)
 STR_ARG("--proc-type", NULL, "Type of process (primary|secondary|auto)", proc_type)
 OPT_STR_ARG("--remap-lcore-ids", "-R", "Remap lcore IDs to be contiguous starting from 0, or supplied value", remap_lcore_ids)
-STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist)
-STR_ARG("--service-coremask", "-s", "[Deprecated] Bitmask of cores to use for service threads", service_coremask)
+STR_ARG("--service-corelist", "-S", "List of lcore IDs to use for service threads", service_corelist)
+STR_ARG("--service-coremask", "-s", "[Deprecated] Bitmask of lcore IDs to use for service threads", service_coremask)
 BOOL_ARG("--single-file-segments", NULL, "Store all pages within single files (per-page-size, per-node)", single_file_segments)
 BOOL_ARG("--telemetry", NULL, "Enable telemetry", telemetry)
 LIST_ARG("--vdev", NULL, "Add a virtual device to the system; format=<driver><id>[,key=val,...]", vdev)
--
2.51.0

