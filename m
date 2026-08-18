Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8377AC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 030AD40BA2;
	Tue, 18 Aug 2026 15:34:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id B6BC940A6C
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060036; x=1818596036;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3ThFuKAa1FLrNly7ry44kgT+1niTKytn6qlINCbekEo=;
 b=HCQF9gVr18WgpEkvRvk7TEhDUagw9VqX0ne/9+aEULnuQKH7wKNpOSCt
 HTz/Jiu3V62GW+w7+EpecpbZoskn5cHpJ9sJ1TrBwFaLOuehX80k1h/2P
 jZ1zSudjluSNI0t2t2r7ImC6SzLb5aMcei/U5OnbSp9WqGjqMrN7BfIno
 N40g65Q87ofsXWkNvVru1hvq2yCFyvRCAlO3zCa5eDpIoiCe70asfw1Ip
 91XWJBFFSaoQcnsTZrTZWdiX+sBIvKhbfMMQ4eWcVMLenSvwak/ZXHbV1
 JpHEmAFpKCPtSKMW/lJPSry8F2jBJv9R4ctcVr6/NK8sRkKmg2HemgEeR w==;
X-CSE-ConnectionGUID: QPx0QGDGTkGFNZdemYi0Mw==
X-CSE-MsgGUID: 0PGyGZ4ERuCnR4IJhYAVoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757632"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757632"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:55 -0700
X-CSE-ConnectionGUID: OlrZVD16Rs2Fo2IkUjSKMw==
X-CSE-MsgGUID: 0ettjJeeTe2j8M//fqVMCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736617"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:54 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 12/39] eal: record details of all cpus in platform info
Date: Tue, 18 Aug 2026 14:33:05 +0100
Message-ID: <20260818133334.2620165-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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

Populate the platform info structure with details of all the cores on
the system.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c | 19 ++++++++++++++
 lib/eal/common/eal_internal_cfg.h | 16 ++++++++++--
 lib/eal/common/eal_private.h      |  8 ++++++
 lib/eal/freebsd/eal_lcore.c       | 16 ++++++++----
 lib/eal/linux/eal_lcore.c         | 43 +++++++++++++++++++++++++++++++
 lib/eal/windows/eal_lcore.c       |  6 +++++
 6 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index b5f59a6380..a5f5c99af9 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -153,6 +153,7 @@ rte_eal_cpu_init(void)
 {
 	/* pointer to global configuration */
 	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	unsigned lcore_id;
 	unsigned count = 0;
 	unsigned int socket_id, prev_socket_id;
@@ -162,6 +163,24 @@ rte_eal_cpu_init(void)
 	int lcore_to_socket_id[RTE_MAX_LCORE] = {0};
 #endif
 
+	/* allocate cpu_info for all CPUs visible to the OS */
+	platform_info->cpu_count = eal_cpu_max();
+	platform_info->cpu_info = calloc(platform_info->cpu_count,
+			sizeof(*platform_info->cpu_info));
+	if (platform_info->cpu_info == NULL) {
+		EAL_LOG(ERR, "Cannot allocate cpu_info array");
+		return -1;
+	}
+
+	/* populate cpu_info with hardware topology for all detected CPUs */
+	for (size_t cpu_id = 0; cpu_id < platform_info->cpu_count; cpu_id++) {
+		if (eal_cpu_detected(cpu_id) == 0)
+			continue;
+		platform_info->cpu_info[cpu_id].detected = true;
+		platform_info->cpu_info[cpu_id].numa_id = eal_cpu_socket_id(cpu_id);
+		platform_info->cpu_info[cpu_id].core_id = eal_cpu_core_id(cpu_id);
+	}
+
 	/*
 	 * Parse the maximum set of logical cores, detect the subset of running
 	 * ones and enable them by default.
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 3f852e1b5d..7cec9cc64e 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -94,10 +94,22 @@ struct eal_user_cfg {
 };
 
 /**
- * Discovered information about cores, memory, etc. on the system.
- * Immutable after initialization, so no need for atomic types or locks.
+ * Hardware facts about a single physical CPU, populated during CPU discovery.
+ * Indexed by physical CPU ID (not DPDK lcore ID).
+ */
+struct eal_cpu_info {
+	bool detected;         /**< true if this CPU ID is valid and visible to the OS */
+	unsigned int numa_id;  /**< NUMA node this CPU belongs to */
+	unsigned int core_id;  /**< physical core number on its NUMA node */
+};
+
+/**
+ * Discovered information about the system hardware.
+ * Immutable after discovery.
  */
 struct eal_platform_info {
+	size_t cpu_count;                /**< number of entries in cpu_info[] */
+	struct eal_cpu_info *cpu_info;   /**< per-physical-CPU hardware facts */
 	uint8_t num_hugepage_sizes;      /**< how many sizes on this system */
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 };
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index f31254dac7..c4a7a35cd9 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -404,6 +404,14 @@ unsigned eal_cpu_core_id(unsigned lcore_id);
  */
 int eal_cpu_detected(unsigned lcore_id);
 
+/**
+ * Get the number of CPU IDs to allocate for platform CPU info.
+ * Returns max_cpu_id + 1: all valid CPU IDs are in [0, eal_cpu_max()).
+ *
+ * This function is private to the EAL.
+ */
+size_t eal_cpu_max(void);
+
 /**
  * Set TSC frequency from precise value or estimation
  *
diff --git a/lib/eal/freebsd/eal_lcore.c b/lib/eal/freebsd/eal_lcore.c
index 1d3d1b67b9..9d7027ceac 100644
--- a/lib/eal/freebsd/eal_lcore.c
+++ b/lib/eal/freebsd/eal_lcore.c
@@ -2,7 +2,10 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#include <sched.h>
+#include <errno.h>
 #include <unistd.h>
+#include <string.h>
 #include <sys/sysctl.h>
 
 #include <rte_log.h>
@@ -21,18 +24,21 @@ eal_cpu_core_id(__rte_unused unsigned lcore_id)
 	return 0;
 }
 
-static int
-eal_get_ncpus(void)
+size_t
+eal_cpu_max(void)
 {
 	static int ncpu = -1;
 	int mib[2] = {CTL_HW, HW_NCPU};
 	size_t len = sizeof(ncpu);
 
 	if (ncpu < 0) {
-		sysctl(mib, 2, &ncpu, &len, NULL, 0);
+		if (sysctl(mib, 2, &ncpu, &len, NULL, 0) != 0) {
+			EAL_LOG(ERR, "sysctl failed to get number of CPUs: %s", strerror(errno));
+			return CPU_SETSIZE;  /* fallback to CPU_SETSIZE */
+		}
 		EAL_LOG(INFO, "Sysctl reports %d cpus", ncpu);
 	}
-	return ncpu;
+	return (size_t)ncpu;
 }
 
 unsigned
@@ -47,6 +53,6 @@ eal_cpu_socket_id(__rte_unused unsigned cpu_id)
 int
 eal_cpu_detected(unsigned lcore_id)
 {
-	const unsigned ncpus = eal_get_ncpus();
+	const unsigned int ncpus = eal_cpu_max();
 	return lcore_id < ncpus;
 }
diff --git a/lib/eal/linux/eal_lcore.c b/lib/eal/linux/eal_lcore.c
index 29b36dd610..b8b2196ab6 100644
--- a/lib/eal/linux/eal_lcore.c
+++ b/lib/eal/linux/eal_lcore.c
@@ -4,7 +4,10 @@
 
 #include <unistd.h>
 #include <limits.h>
+#include <stdio.h>
+#include <string.h>
 
+#include <rte_argparse.h>
 #include <rte_log.h>
 
 #include "eal_private.h"
@@ -12,9 +15,31 @@
 #include "eal_thread.h"
 
 #define SYS_CPU_DIR "/sys/devices/system/cpu/cpu%u"
+#define SYS_CPU_POSSIBLE_PATH "/sys/devices/system/cpu/possible"
 #define CORE_ID_FILE "topology/core_id"
 #define NUMA_NODE_PATH "/sys/devices/system/node"
 
+static int
+eal_cpu_possible(rte_cpuset_t *cpuset)
+{
+	char cpu_list[BUFSIZ];
+	FILE *f;
+
+	f = fopen(SYS_CPU_POSSIBLE_PATH, "r");
+	if (f == NULL)
+		return -1;
+	if (fgets(cpu_list, sizeof(cpu_list), f) == NULL ||
+			strchr(cpu_list, '\n') == NULL) {
+		fclose(f);
+		return -1;
+	}
+	fclose(f);
+	cpu_list[strcspn(cpu_list, "\n")] = '\0';
+
+	return rte_argparse_parse_type(cpu_list,
+		RTE_ARGPARSE_VALUE_TYPE_CORELIST, cpuset);
+}
+
 /* Check if a cpu is present by the presence of the cpu information for it */
 int
 eal_cpu_detected(unsigned lcore_id)
@@ -72,3 +97,21 @@ eal_cpu_core_id(unsigned lcore_id)
 			"for lcore %u - assuming core 0", SYS_CPU_DIR, lcore_id);
 	return 0;
 }
+
+size_t
+eal_cpu_max(void)
+{
+	rte_cpuset_t possible_cpus;
+	int cpu_id;
+
+	if (eal_cpu_possible(&possible_cpus) == 0) {
+		for (cpu_id = CPU_SETSIZE - 1; cpu_id >= 0; cpu_id--) {
+			if (CPU_ISSET(cpu_id, &possible_cpus))
+				return cpu_id + 1;
+		}
+	}
+
+	EAL_LOG(WARNING, "Cannot read possible CPU IDs from %s, falling back to CPU_SETSIZE",
+			SYS_CPU_POSSIBLE_PATH);
+	return CPU_SETSIZE;
+}
diff --git a/lib/eal/windows/eal_lcore.c b/lib/eal/windows/eal_lcore.c
index d2a2c2d091..2287337530 100644
--- a/lib/eal/windows/eal_lcore.c
+++ b/lib/eal/windows/eal_lcore.c
@@ -273,6 +273,12 @@ eal_cpu_core_id(unsigned int lcore_id)
 	return cpu_map.lcores[lcore_id].core_id;
 }
 
+size_t
+eal_cpu_max(void)
+{
+	return (size_t)cpu_map.lcore_count;
+}
+
 unsigned int
 eal_socket_numa_node(unsigned int socket_id)
 {
-- 
2.53.0

