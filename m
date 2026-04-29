Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE2CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADE9140DFD;
	Wed, 29 Apr 2026 18:59:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 15B5140B99;
 Wed, 29 Apr 2026 18:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481949; x=1809017949;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GXw1+GxlEaxTx3ot9W3ix3YplUZiLSQGaaFKQGcczRw=;
 b=kguN71JyieRlkZRpYeJsjYp61vT5Xo2EUlsz86YW6Cf0U4U1WmpXcfmE
 G3Hds4UmwhsUnUAU3eL1qXsN3O5SLhyDHoZqVZnH7oB38fFHapkuOUV1b
 +xvC0xSUrDvYEjjS8MhpIc+2FiosxMmMX4EPddrDFwMTLoiO2AW4biaa5
 j/N1Rvk67xsXJ/tS3XeimT0k3vPzifuJTNwjfVyPOfZHNa62S+iFBBPkg
 yfPtmjhdJXpvmJKptIPwpF/P96BQrugJ6MaJRCIdTI0MmrFc8QaE0KhYi
 EnqrQQm3A93AtuCtX6+l/XZNmEhdm3LfTPr1jVZbw+raFJyhRJwAxpFIv g==;
X-CSE-ConnectionGUID: di0Yze4RTCS+5GCg4IbDEw==
X-CSE-MsgGUID: /PHWnJgyTOa5szXzYQXqFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725304"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725304"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:08 -0700
X-CSE-ConnectionGUID: i+wUTwP0Q6SFri2s+UgE6Q==
X-CSE-MsgGUID: v9Ir6LfMSPSyplg+dE1KxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696955"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 10/44] eal: record details of all cpus in platform info
Date: Wed, 29 Apr 2026 17:58:02 +0100
Message-ID: <20260429165845.2136843-11-bruce.richardson@intel.com>
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

Populate the platform info structure with details of all the cores on
the system.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c | 19 +++++++++++++++++++
 lib/eal/common/eal_internal_cfg.h | 16 ++++++++++++++--
 lib/eal/common/eal_private.h      |  8 ++++++++
 lib/eal/freebsd/eal_lcore.c       | 16 +++++++++++-----
 lib/eal/linux/eal_lcore.c         | 13 +++++++++++++
 lib/eal/windows/eal_lcore.c       |  6 ++++++
 6 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 39411f9370..d8cc5e1a91 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -152,6 +152,7 @@ rte_eal_cpu_init(void)
 {
 	/* pointer to global configuration */
 	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	unsigned lcore_id;
 	unsigned count = 0;
 	unsigned int socket_id, prev_socket_id;
@@ -161,6 +162,24 @@ rte_eal_cpu_init(void)
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
index 9a898e676e..8ed7171bdc 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -88,10 +88,22 @@ struct eal_user_cfg {
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
index d9807fb2fb..00a73a9d61 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -388,6 +388,14 @@ unsigned eal_cpu_core_id(unsigned lcore_id);
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
index 1d3d1b67b9..c20d25358b 100644
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
+	const unsigned ncpus = eal_cpu_max();
 	return lcore_id < ncpus;
 }
diff --git a/lib/eal/linux/eal_lcore.c b/lib/eal/linux/eal_lcore.c
index 29b36dd610..6a806336bd 100644
--- a/lib/eal/linux/eal_lcore.c
+++ b/lib/eal/linux/eal_lcore.c
@@ -72,3 +72,16 @@ eal_cpu_core_id(unsigned lcore_id)
 			"for lcore %u - assuming core 0", SYS_CPU_DIR, lcore_id);
 	return 0;
 }
+
+size_t
+eal_cpu_max(void)
+{
+	long n = sysconf(_SC_NPROCESSORS_CONF);
+
+	if (n <= 0) {
+		EAL_LOG(WARNING, "sysconf(_SC_NPROCESSORS_CONF) failed, "
+				"falling back to CPU_SETSIZE");
+		return CPU_SETSIZE;
+	}
+	return (size_t)n;
+}
diff --git a/lib/eal/windows/eal_lcore.c b/lib/eal/windows/eal_lcore.c
index a498044620..dcbba383f7 100644
--- a/lib/eal/windows/eal_lcore.c
+++ b/lib/eal/windows/eal_lcore.c
@@ -239,6 +239,12 @@ eal_cpu_core_id(unsigned int lcore_id)
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
2.51.0

