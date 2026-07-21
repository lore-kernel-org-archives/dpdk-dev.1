Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B666BC4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:49:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E99B40EDF;
	Tue, 21 Jul 2026 11:46:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 74A56402AD
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627196; x=1816163196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IK/K5Z94VhiX46ys0KUSnsTmr9+zaMWa8cDFEgk5uvk=;
 b=BI0x72fKXuMSoQ+F2KJceJMN0veLqHoQgLpldV/LcDe2fbZcUMUZTiWb
 rKj34cSR/G8CcXTLs2P/ZFFtjx0wdtTCByYi7Vak8RoHw0SAR9K3Ljqyh
 w3QibenatacS48w9pWqknAZ7V1bvmGqs+2Sl/fSjXtQZ3KI9F9fTwOIBf
 K45g+t9Tj3DmrvXmknM1Waelqz+XoBy6ZYLM7dskzNZs4X1gTOTWcSZ8I
 wM39Rj7BlBqGHlc9/gwusE9f0xnzXosdlDWMSZSnlwLYt2Y9tZn+hvsGq
 hohmdWsAPPBAEU5mKE/G7LUUFuH1F7jy/GLyz+0LegaSrViXxgvVVMC0H A==;
X-CSE-ConnectionGUID: bQRK1y5wRuOXUCWjbpFNjA==
X-CSE-MsgGUID: S9FAfaJ5TDGauuhciUIHTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872510"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:35 -0700
X-CSE-ConnectionGUID: kBWV6RjtRXKbb6BrK0DEKw==
X-CSE-MsgGUID: pG8Umw8bSwqt190K4S8/7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922433"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:33 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 32/39] eal: clarify docs on params taking lcore IDs
Date: Tue, 21 Jul 2026 10:45:40 +0100
Message-ID: <20260721094555.2188496-33-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
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

The documentation doesn't make clear how the parameters to service core
and main lcore EAL flags relate to the regular --lcores parameter when
mapping lcores to physical CPU ids.

For example, when looking to add service cores to process run using the
command "/path/to/app -R -l 40-50", it's not clear whether the service
cores list parameter should be "-S 49-50" i.e. physical CPU ids, or "-S
9-10" i.e.  logical lcore IDs. Update the docs to make it clear its the
latter.

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
index b72f243cc6..2b94e4f22f 100644
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
@@ -61,8 +61,8 @@ BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry)
 LIST_ARG("--pagesz-mem", NULL, "Memory allocation per hugepage size (format: <pagesz>:<limit>, e.g. 2M:32G). Repeat option for multiple page sizes.", pagesz_mem)
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
2.53.0

