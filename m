Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4182606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qy3Cah4I
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DF2940BA4;
	Thu, 26 Nov 2026 19:14:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id E0A7C40684
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716871; x=1827252871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xe0vfFPyP5Z4x8nk0qLESqOer+vUmnvNeC/49rdI0vg=;
 b=Qy3Cah4IiPFjCzhrYClFnlDaBWIe3oUePCacFME6EJicG6tpMHRHRpFs
 scj4OvpgohbF0PVoPA0MWsqWKzqchpjzaGZv7MNKjjMBwBonMPUKI37mj
 y8WDVsJvKbHLowVeW1hcTxJ1LMpqKsiY7yiGCSb0Kco2phFUl7+KQjMuA
 M/XVDhWeMkPqyrlaT5hxFM/sMvWMftUS+N0CUewcBXpO9Q7g4eLSDZELJ
 L2ErxIS9f3h7IoDVhvkDEAuXedoHKxk3gE99wYrBlp3qGgF8T9x85Homv
 VBGg23heJxmE5dKz3g/AkIhf30WD/NmWxwRa94IXe8b4vAYlytazxEs3L w==;
X-CSE-ConnectionGUID: hZrcmqQEQsi8NxmdRwBT9Q==
X-CSE-MsgGUID: LDXQwfMrTLucQiBgOW+uwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633559"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633559"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:30 -0800
X-CSE-ConnectionGUID: 7D1fC/08RIqkrYXglf93hA==
X-CSE-MsgGUID: DRm3PpKbRKGLuEkadE1Hrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732894"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:29 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 12/39] eal: record details of all cpus in platform info
Date: Thu, 26 Nov 2026 18:13:45 +0000
Message-ID: <20261126181414.124094-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
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
index 3ddacdb8ce..7277867213 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -164,6 +164,7 @@ rte_eal_cpu_init(void)
 {
 	/* pointer to global configuration */
 	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	unsigned lcore_id;
 	unsigned count = 0;
 	unsigned int socket_id, prev_socket_id;
@@ -173,6 +174,24 @@ rte_eal_cpu_init(void)
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
index aa140e074f..3e04f42594 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -100,10 +100,22 @@ struct eal_user_cfg {
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
index 7e705c62c8..550dcb6b22 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -390,6 +390,14 @@ unsigned eal_cpu_core_id(unsigned lcore_id);
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
2.55.0

