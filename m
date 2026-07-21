Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4382AC4452B
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A82040BA4;
	Tue, 21 Jul 2026 11:46:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 56DA140A81
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627176; x=1816163176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rgB0OTMvXE5/eD63u4em3KDb11i0/HzU/KQS/3m5d6Q=;
 b=NI6Gpu1V0mPwpzfzBy6w1z1QZaqAYb6Gp9LL5srof8EDLVOoVSldUZls
 VnoOW4W12AsRWTwYSrmdEWT4jIwmD/eFjXlKxWji14QqOxcnGmnDYYk/J
 swTatVAZFGzGV77BMLNIKcm5ZwIY/nyzHeLxxeMYMqafhWoeAVyjyyW90
 rwq5LXk7Qb+lmSEa1077++0DpI/Qf+CKSnWT3tVTDGcbg1TqSofW2cY2x
 SrIsrTIpDMGcIinjWVB1+LqBVwmJBFupVwAn2BjxOAqlIxJ+o42d//MEv
 DkWtrBhmIF3FxEERZStaHeBTeaBnqx23xIncpj8kIVJJtywEB/5ux4Dfk Q==;
X-CSE-ConnectionGUID: ZbTQLxolR7eNNqpFQ+YgiA==
X-CSE-MsgGUID: Ne8hZq2rTG6Y5f5qCK7Dyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872469"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872469"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:14 -0700
X-CSE-ConnectionGUID: adSdZznURTqqMXs9tG4fVQ==
X-CSE-MsgGUID: CQqUdXF2SQqzY1N9m1bQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922321"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 13/39] eal: use platform info for lcore lookups
Date: Tue, 21 Jul 2026 10:45:21 +0100
Message-ID: <20260721094555.2188496-14-bruce.richardson@intel.com>
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

Rather than storing the lcore and numa fields in the lcore_config
structure - which is a structure indexed by logical core id, rather than
physical cpu - use the platform info struct as the one source of truth
for cpu topology info.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c  | 38 +++++++++++++++++++-----------
 lib/eal/common/eal_common_thread.c | 37 ++++++++++++-----------------
 lib/eal/common/eal_private.h       |  9 +++++--
 3 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index a5f5c99af9..16af89a968 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -51,6 +51,9 @@ int rte_lcore_index(int lcore_id)
 RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
 int rte_lcore_to_cpu_id(int lcore_id)
 {
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	unsigned int cpu;
+
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
 		return -1;
 
@@ -61,7 +64,11 @@ int rte_lcore_to_cpu_id(int lcore_id)
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
@@ -127,7 +134,10 @@ RTE_EXPORT_SYMBOL(rte_lcore_to_socket_id)
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id)
 {
-	return lcore_config[lcore_id].numa_id;
+	if (unlikely(lcore_id >= RTE_MAX_LCORE))
+		return (unsigned int)SOCKET_ID_ANY;
+
+	return (unsigned int)eal_cpuset_socket_id(&lcore_config[lcore_id].cpuset);
 }
 
 static int
@@ -191,16 +201,16 @@ rte_eal_cpu_init(void)
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
 
@@ -210,22 +220,22 @@ rte_eal_cpu_init(void)
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
index c2e7315bf4..10e8d84aa7 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -37,30 +37,25 @@ unsigned rte_socket_id(void)
 	return RTE_PER_LCORE(_numa_id);
 }
 
-static int
-eal_cpuset_socket_id(rte_cpuset_t *cpusetp)
+int
+eal_cpuset_socket_id(const rte_cpuset_t *cpusetp)
 {
-	unsigned cpu = 0;
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
 	int socket_id = SOCKET_ID_ANY;
-	int sid;
 
 	if (cpusetp == NULL)
 		return SOCKET_ID_ANY;
 
-	do {
+	for (unsigned int cpu = 0; cpu < CPU_SETSIZE && cpu < platform_info->cpu_count; cpu++) {
 		if (!CPU_ISSET(cpu, cpusetp))
 			continue;
 
+		int sid = (int)platform_info->cpu_info[cpu].numa_id;
 		if (socket_id == SOCKET_ID_ANY)
-			socket_id = eal_cpu_socket_id(cpu);
-
-		sid = eal_cpu_socket_id(cpu);
-		if (socket_id != sid) {
-			socket_id = SOCKET_ID_ANY;
-			break;
-		}
-
-	} while (++cpu < CPU_SETSIZE);
+			socket_id = sid;
+		else if (socket_id != sid)
+			return SOCKET_ID_ANY;
+	}
 
 	return socket_id;
 }
@@ -70,19 +65,17 @@ thread_update_affinity(rte_cpuset_t *cpusetp)
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
+		/* Non-EAL thread: preserve SOCKET_ID_ANY if cpuset spans NUMA nodes. */
+		RTE_PER_LCORE(_numa_id) = (unsigned int)eal_cpuset_socket_id(cpusetp);
 	}
 }
 
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index c4a7a35cd9..a20627edd5 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -31,8 +31,6 @@ struct lcore_config {
 	volatile int ret;          /**< return value of function */
 
 	volatile RTE_ATOMIC(enum rte_lcore_state_t) state; /**< lcore state */
-	unsigned int numa_id;      /**< NUMA node ID for this lcore */
-	unsigned int core_id;      /**< core number on socket for this lcore */
 	int core_index;            /**< relative index, starting from 0 */
 	uint8_t core_role;         /**< role of core eg: OFF, RTE, SERVICE */
 
@@ -96,6 +94,13 @@ int eal_collate_args(int argc, char **argv);
  */
 char *eal_cpuset_to_str(const rte_cpuset_t *cpuset);
 
+/**
+ * Resolve a cpuset to a NUMA socket id.
+ *
+ * Returns SOCKET_ID_ANY if cpuset is NULL, empty, or spans multiple sockets.
+ */
+int eal_cpuset_socket_id(const rte_cpuset_t *cpuset);
+
 /**
  * Initialize the memzone subsystem (private to eal).
  *
-- 
2.53.0

