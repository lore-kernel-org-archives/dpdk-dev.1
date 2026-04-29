Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D591CD13D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:00:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BEDA40DCB;
	Wed, 29 Apr 2026 18:59:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 85F3040B97;
 Wed, 29 Apr 2026 18:59:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481950; x=1809017950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qlRQQK6tvcdZtJJ1u87/R1CLXWIKjtBUVtCsa1ZE5Eg=;
 b=Kd+X+x9/MFqWw9pe0V4uGZuqwRyJuL1spAKtGZoE9x1HJSjvQSvS7qNp
 1PVINI9LRjdOULzvhyBxyjWRH+qqMIiaw7DsUt910slu5O6CwRNdTaZ/8
 8vFHjj1GpHWRFdEyGY5mgvYBu/U3qhx1pyG3m/oAjjIAXgPZ56hBi+eoy
 Xopo0cfoe9GD1QnAJCHBRMdyo6WTw3o/UFOZf/pJT5NzaVFL/qaL5Qy5R
 C9fQ4/px7UiFPXIz+FVsIOWJIzSsv6xINcb5WiMBKW2+rBDIYNsn62pIj
 U5IMqya2lvmBVI+hISfZw+9LEvI2GD4o01ZdygstT1PIGgGQDH2BTHrD0 Q==;
X-CSE-ConnectionGUID: A6yfyMDuQuitOQLKI9D81Q==
X-CSE-MsgGUID: DLcQIgsTSa2QSj6jZaM1AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725308"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725308"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:09 -0700
X-CSE-ConnectionGUID: XUXxjdG/ShKIaZswfpV6oQ==
X-CSE-MsgGUID: tcWj4YGLRm2KIGGGDnZ7kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696961"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 11/44] eal: use platform info for lcore lookups
Date: Wed, 29 Apr 2026 17:58:03 +0100
Message-ID: <20260429165845.2136843-12-bruce.richardson@intel.com>
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

Rather than storing the lcore and numa fields in the lcore_config
structure - which is a structure indexed by logical core id, rather than
physical cpu - use the platform info struct as the one source of truth
for cpu topology info.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c  | 42 ++++++++++++++++--------
 lib/eal/common/eal_common_thread.c | 51 +++++++++---------------------
 lib/eal/common/eal_private.h       |  2 --
 3 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index d8cc5e1a91..ba3a0c8a92 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -50,6 +50,9 @@ int rte_lcore_index(int lcore_id)
 RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
 int rte_lcore_to_cpu_id(int lcore_id)
 {
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	unsigned int cpu;
+
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
 		return -1;
 
@@ -60,7 +63,11 @@ int rte_lcore_to_cpu_id(int lcore_id)
 		lcore_id = (int)rte_lcore_id();
 	}
 
-	return lcore_config[lcore_id].core_id;
+	for (cpu = 0; cpu < CPU_SETSIZE && cpu < platform_info->cpu_count; cpu++) {
+		if (CPU_ISSET(cpu, &lcore_config[lcore_id].cpuset))
+			return (int)platform_info->cpu_info[cpu].core_id;
+	}
+	return -1;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_cpuset)
@@ -126,7 +133,14 @@ RTE_EXPORT_SYMBOL(rte_lcore_to_socket_id)
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id)
 {
-	return lcore_config[lcore_id].numa_id;
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	unsigned int cpu;
+
+	for (cpu = 0; cpu < CPU_SETSIZE && cpu < platform_info->cpu_count; cpu++) {
+		if (CPU_ISSET(cpu, &lcore_config[lcore_id].cpuset))
+			return platform_info->cpu_info[cpu].numa_id;
+	}
+	return 0;
 }
 
 static int
@@ -190,38 +204,38 @@ rte_eal_cpu_init(void)
 		/* init cpuset for per lcore config */
 		CPU_ZERO(&lcore_config[lcore_id].cpuset);
 
-		/* find socket first */
-		socket_id = eal_cpu_socket_id(lcore_id);
-		lcore_to_socket_id[lcore_id] = socket_id;
-
 		if (eal_cpu_detected(lcore_id) == 0) {
 			config->lcore_role[lcore_id] = ROLE_OFF;
 			lcore_config[lcore_id].core_index = -1;
 			continue;
 		}
 
+		/* find socket first */
+		socket_id = platform_info->cpu_info[lcore_id].numa_id;
+		lcore_to_socket_id[lcore_id] = socket_id;
+
 		/* By default, lcore 1:1 map to cpu id */
 		CPU_SET(lcore_id, &lcore_config[lcore_id].cpuset);
 
 		/* By default, each detected core is enabled */
 		config->lcore_role[lcore_id] = ROLE_RTE;
 		lcore_config[lcore_id].core_role = ROLE_RTE;
-		lcore_config[lcore_id].core_id = eal_cpu_core_id(lcore_id);
-		lcore_config[lcore_id].numa_id = socket_id;
 		EAL_LOG(DEBUG, "Detected lcore %u as "
 				"core %u on NUMA node %u",
-				lcore_id, lcore_config[lcore_id].core_id,
-				lcore_config[lcore_id].numa_id);
+				lcore_id,
+				platform_info->cpu_info[lcore_id].core_id,
+				platform_info->cpu_info[lcore_id].numa_id);
 		count++;
 	}
 	for (; lcore_id < CPU_SETSIZE; lcore_id++) {
 		if (eal_cpu_detected(lcore_id) == 0)
 			continue;
-		socket_id = eal_cpu_socket_id(lcore_id);
-		lcore_to_socket_id[lcore_id] = socket_id;
+		if (unlikely(lcore_id >= platform_info->cpu_count))
+			break;
+		lcore_to_socket_id[lcore_id] = platform_info->cpu_info[lcore_id].numa_id;
 		EAL_LOG(DEBUG, "Skipped lcore %u as core %u on NUMA node %u",
-			lcore_id, eal_cpu_core_id(lcore_id),
-			socket_id);
+			lcore_id, platform_info->cpu_info[lcore_id].core_id,
+			platform_info->cpu_info[lcore_id].numa_id);
 	}
 
 	/* Set the count of enabled logical cores of the EAL configuration */
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index c2e7315bf4..774344013d 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -37,52 +37,31 @@ unsigned rte_socket_id(void)
 	return RTE_PER_LCORE(_numa_id);
 }
 
-static int
-eal_cpuset_socket_id(rte_cpuset_t *cpusetp)
-{
-	unsigned cpu = 0;
-	int socket_id = SOCKET_ID_ANY;
-	int sid;
-
-	if (cpusetp == NULL)
-		return SOCKET_ID_ANY;
-
-	do {
-		if (!CPU_ISSET(cpu, cpusetp))
-			continue;
-
-		if (socket_id == SOCKET_ID_ANY)
-			socket_id = eal_cpu_socket_id(cpu);
-
-		sid = eal_cpu_socket_id(cpu);
-		if (socket_id != sid) {
-			socket_id = SOCKET_ID_ANY;
-			break;
-		}
-
-	} while (++cpu < CPU_SETSIZE);
-
-	return socket_id;
-}
-
 static void
 thread_update_affinity(rte_cpuset_t *cpusetp)
 {
 	unsigned int lcore_id = rte_lcore_id();
 
-	/* store numa_id in TLS for quick access */
-	RTE_PER_LCORE(_numa_id) =
-		eal_cpuset_socket_id(cpusetp);
-
 	/* store cpuset in TLS for quick access */
-	memmove(&RTE_PER_LCORE(_cpuset), cpusetp,
-		sizeof(rte_cpuset_t));
+	memmove(&RTE_PER_LCORE(_cpuset), cpusetp, sizeof(rte_cpuset_t));
 
 	if (lcore_id != (unsigned)LCORE_ID_ANY) {
-		/* EAL thread will update lcore_config */
-		lcore_config[lcore_id].numa_id = RTE_PER_LCORE(_numa_id);
+		/* EAL thread: update lcore_config cpuset first then find numa based on that */
 		memmove(&lcore_config[lcore_id].cpuset, cpusetp,
 			sizeof(rte_cpuset_t));
+		RTE_PER_LCORE(_numa_id) = rte_lcore_to_socket_id(lcore_id);
+	} else {
+		/* Non-EAL thread: derive NUMA node from first CPU in cpuset. */
+		const struct eal_platform_info *platform_info = eal_get_platform_info();
+		unsigned int cpu;
+
+		RTE_PER_LCORE(_numa_id) = SOCKET_ID_ANY;
+		for (cpu = 0; cpu < CPU_SETSIZE  && cpu < platform_info->cpu_count; cpu++) {
+			if (CPU_ISSET(cpu, cpusetp)) {
+				RTE_PER_LCORE(_numa_id) = platform_info->cpu_info[cpu].numa_id;
+				break;
+			}
+		}
 	}
 }
 
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 00a73a9d61..48569f2ed7 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -30,8 +30,6 @@ struct lcore_config {
 	volatile int ret;          /**< return value of function */
 
 	volatile RTE_ATOMIC(enum rte_lcore_state_t) state; /**< lcore state */
-	unsigned int numa_id;      /**< NUMA node ID for this lcore */
-	unsigned int core_id;      /**< core number on socket for this lcore */
 	int core_index;            /**< relative index, starting from 0 */
 	uint8_t core_role;         /**< role of core eg: OFF, RTE, SERVICE */
 
-- 
2.51.0

