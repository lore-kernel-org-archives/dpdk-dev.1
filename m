Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A3606A33C
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eYzoZ7Ml
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 891E2402C6;
	Fri, 20 Nov 2026 12:14:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 9869540151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 12:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795173270; x=1826709270;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qErzSRfKhl04v/pXe+bJwLsnri8fXJkAzapDOSK7ufA=;
 b=eYzoZ7Mlo14K/Qf8vySozEDWbwznSBrqIgCklIYKGOU5+/iqRNMvT8PG
 86wswdv6C4IZpanYrLsJ8rwrr01K67lwHG4xXbeHZlWNxW35MknFqpGCu
 dAZ/3v+sBIVgonIhxDAHR+e/lH7c4o5WhVI+FS85xNTidK557Ojp8v5w1
 Ni70TM+YtTZCPLX0S//uGjYnyXzMwpj06h3d1jYi1dXleBhTQ4Cjdappl
 Q6BbATrdOV7BGqLz6OmswNKI1cwssYVT/H5X8txgsO/MonjyR4YbF/N3T
 3SUD0JdFjyqarhnvsgjSYDy0rVcPbLNrpMRKoBCr5OsUl1+y+Zd6Xhggf g==;
X-CSE-ConnectionGUID: gQl834pIQk6VO3D7rwhO9A==
X-CSE-MsgGUID: cdKFkFIMQ/Kj4ENl8oOQPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3932462"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3932462"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:14:28 -0800
X-CSE-ConnectionGUID: WcTP92XOSq2Iuk0AGqAiPA==
X-CSE-MsgGUID: RfQEIOVrTkqR4Uwv7+xJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10576708"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 20 Nov 2026 03:14:28 -0800
From: John McNamara <john.mcnamara@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	John McNamara <john.mcnamara@intel.com>
Subject: [PATCH v1] doc: update release notes for 26.11
Date: Fri, 20 Nov 2026 11:14:14 +0000
Message-ID: <20261120111419.576367-1-john.mcnamara@intel.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix grammar, spelling and formatting of DPDK 26.11 release notes.

Signed-off-by: John McNamara <john.mcnamara@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst | 34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8387949ef3..2f0e58d75a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -58,11 +58,11 @@ New Features
 * **Added division round up macro.**
 
   Added the ``RTE_DIV_ROUND_UP`` macro in ``rte_common.h``
-  to divide dividend by divisor, rounding up to the nearest integer.
+  to divide a dividend by a divisor, rounding up to the nearest integer.
 
 * **Improved pointer arithmetic macros.**
 
-  Updated  the macros ``RTE_PTR_ADD``, ``RTE_PTR_SUB``,
+  Updated the macros ``RTE_PTR_ADD``, ``RTE_PTR_SUB``,
   ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL`` and ``RTE_PTR_ALIGN_FLOOR``
   to preserve const/volatile qualifiers
   and use pointer arithmetic instead of integer casts to enable compiler optimizations.
@@ -77,12 +77,12 @@ New Features
 
   Introduced pile, a lock-free, stack-like implementation,
   optimized for bulk operations.
-  The pile is only LIFO on bulk level, not on object level;
-  i.e. arrays of bulks are pushed and popped in LIFO manner,
+  The pile is only LIFO at the bulk level, not at the object level;
+  i.e., arrays of bulks are pushed and popped in a LIFO manner,
   but objects within each bulk are not ordered as expected by a stack.
   Furthermore, it is not strictly bounded by its size, but might hold more objects.
 
-* **Added unplug operation support to DPAA bus.**
+* **Added support for the unplug operation to the DPAA bus.**
 
   Implemented device unplug operation to allow runtime removal of DPAA devices.
 
@@ -100,11 +100,11 @@ New Features
   The platform bus now matches DPDK drivers against the device-tree ``compatible`` sysfs strings
   exposed by each platform device, in addition to the existing kernel driver name and
   device name checks.
-  This allows drivers to be probed by DT compatible string when
+  This allows drivers to be probed by a device tree (DT) compatible string when
   the kernel driver is the generic ``vfio-platform``,
   which carries no device identity in its name.
 
-* **Added link speed 1.6T to ethdev.**
+* **Added 1.6T link speed to ethdev.**
 
   Added the 1.6 Tb/s Ethernet link speed,
   allowing aggregate links such as two 800 Gb/s members to be represented.
@@ -255,7 +255,7 @@ New Features
 
 * **Updated Solarflare network driver.**
 
-  * Added VF support on AMD Solarflare X45xx adapters.
+  * Added VF support for AMD Solarflare X45xx adapters.
 
 * **Updated Wangxun txgbe driver.**
 
@@ -331,9 +331,9 @@ New Features
   with AMD-specific hardware access, a primary/secondary topology
   and a packed scratchpad handshake.
 
-* **Supported auto-detection of uncore power driver.**
+* **Added auto-detection of the uncore power driver.**
 
-  The uncore power library got automatic probing of multiple uncore drivers
+  The uncore power library now probes multiple uncore drivers automatically
   when using ``RTE_UNCORE_PM_ENV_AUTO_DETECT``,
   instead of defaulting only to the Intel uncore driver.
 
@@ -341,7 +341,7 @@ New Features
 
   Added build time configurable graph node profiling statistics
   via ``RTE_GRAPH_PROFILE`` in ``rte_config.h`` (disabled by default).
-  When enabled, tracks cycles spent processing various burst size ranges per node.
+  When enabled, it tracks cycles spent processing various burst size ranges per node.
   The edges of the ranges are build time configurable via
   ``RTE_GRAPH_PROFILE_BURST_SMALL``, ``RTE_GRAPH_PROFILE_BURST_MEDIUM``, and
   ``RTE_GRAPH_PROFILE_BURST_LARGE`` in ``rte_config.h``.
@@ -352,7 +352,7 @@ New Features
   using bitmap scanning instead of a circular buffer.
   This ensures that in fan-out-then-converge topologies,
   all branches feeding a converge node complete before that node is visited.
-  Reducing the occurrence of double-visits.
+  This reduces the occurrence of double-visits.
 
 * **Added explicit link auto-negotiation control in testpmd.**
 
@@ -516,7 +516,7 @@ API Changes
     and ``RTE_PTR_ALIGN_FLOOR`` now preserve const/volatile qualifiers.
     These macros do not nest infinitely and may require intermediate variables.
   * Passing NULL to ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``,
-    ``RTE_PTR_ALIGN_CEIL``, or ``RTE_PTR_ALIGN_FLOOR`` clarified as undefined behavior.
+    ``RTE_PTR_ALIGN_CEIL``, or ``RTE_PTR_ALIGN_FLOOR`` is clarified as undefined behavior.
   * ``RTE_PTR_ADD`` and ``RTE_PTR_SUB`` no longer accept integer types
     as the pointer argument; existing code should use native operators (e.g. + -).
   * ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL`` and ``RTE_PTR_ALIGN_FLOOR``
@@ -580,7 +580,7 @@ API Changes
   * The ``RTE_ETH_NUM_RECEIVE_MAC_ADDR`` and ``RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY`` macros
     are VMDq related and are sizes of internal arrays in ethdev
     that only drivers need to care about.
-    Those macros are moved to the driver only ethdev API.
+    Those macros have been moved to the driver only ethdev API.
 
 * ethdev: Promoted the following API from experimental to stable:
 
@@ -678,7 +678,7 @@ API Changes
   ``rte_reorder_min_seqn_set`` and ``rte_reorder_memory_footprint_get``.
 
 * vhost: Introduced ``RTE_VHOST_USER_MAP_POPULATE``
-  as a replacement of ``RTE_VHOST_USER_ASYNC_COPY``
+  as a replacement for ``RTE_VHOST_USER_ASYNC_COPY``
   for users that did not rely on the vhost async copy feature
   but expected guest pages to be prefaulted.
 
@@ -692,8 +692,8 @@ API Changes
 
 * bpf: Made the ``bpf_def.h`` header file private,
   so eBPF instruction opcodes are no longer publicly available
-  (their numerical values follow the RFC and e.g. Linux headers).
-  The definition of the instruction struct and number of program arguments
+  (their numerical values follow the RFC and match, for example, those in Linux headers).
+  The definition of the instruction struct and the number of program arguments
   were moved to ``rte_bpf.h`` and gained the public ``RTE_`` prefix:
   ``struct rte_ebpf_insn`` and ``RTE_BPF_FUNC_MAX_ARGS``.
 
-- 
2.53.0

