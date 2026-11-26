Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4D606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g8o6Gg9Q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1520140A72;
	Thu, 26 Nov 2026 19:14:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id CECBC4069D
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716871; x=1827252871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eQhZlHnUfYkBz+38RkbpntRGaABCwzypkc+26Np5ht0=;
 b=g8o6Gg9Q2MQjmYw7yK5Z8f/JLTUy/jF48j14BNeHNzdp59AlDNVwdjYL
 BTiMhARHrM+7tmDc6nFvsZ4KTy2NO4JJi3/dTFRBUvvNiw2TpmL4saJzY
 qCYA+ZUOSXCZLY7uk/10zcQglm+4TOOo5cp/QdnpCYHOZZGZN6KpcLpzh
 m/B+Jm+9t56fV3KbmHR0rIll54g8q2ol/OvIylhfWIMFhj2NQuADLcWrj
 ctOjnykJ3uDksLhWFW4OFcBKA7MMk0YXouD9KV+SH5VpX0rj5yArHt+eJ
 +6jODH2AducaBbv1L0LdUpNaMR5twRdQqNLSLk3rhwjI8RbVxAiyxoAko Q==;
X-CSE-ConnectionGUID: 9gcPLAlwRYq+K9/QUsTWtQ==
X-CSE-MsgGUID: WUrnpnyrSlaSDyVo0euRtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633561"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633561"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:31 -0800
X-CSE-ConnectionGUID: A6JFjF0lSha7aYVcHDT8Hg==
X-CSE-MsgGUID: U2Fp7qI/ThqmnAtdv5EqcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732898"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:29 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 13/39] eal: use platform info for lcore lookups
Date: Thu, 26 Nov 2026 18:13:46 +0000
Message-ID: <20261126181414.124094-14-bruce.richardson@intel.com>
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
index 7277867213..1042ffabd9 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -52,6 +52,9 @@ int rte_lcore_index(int lcore_id)
 RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
 int rte_lcore_to_cpu_id(int lcore_id)
 {
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	unsigned int cpu;
+
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
 		return -1;
 
@@ -62,7 +65,11 @@ int rte_lcore_to_cpu_id(int lcore_id)
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
@@ -128,7 +135,10 @@ RTE_EXPORT_SYMBOL(rte_lcore_to_socket_id)
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id)
 {
-	return lcore_config[lcore_id].numa_id;
+	if (unlikely(lcore_id >= RTE_MAX_LCORE))
+		return (unsigned int)SOCKET_ID_ANY;
+
+	return (unsigned int)eal_cpuset_socket_id(&lcore_config[lcore_id].cpuset);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cpu_socket_id, 26.11)
@@ -202,16 +212,16 @@ rte_eal_cpu_init(void)
 		/* init cpuset for per lcore config */
 		CPU_ZERO(&lcore_config[lcore_id].cpuset);
 
-		/* find socket first */
-		socket_id = eal_cpu_socket_id(lcore_id);
-		lcore_to_socket_id[lcore_id] = socket_id;
-
 		if (eal_cpu_detected(lcore_id) == 0) {
 			config->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
 			lcore_config[lcore_id].core_index = -1;
 			continue;
 		}
 
+		/* find socket first */
+		socket_id = platform_info->cpu_info[lcore_id].numa_id;
+		lcore_to_socket_id[lcore_id] = socket_id;
+
 		/* By default, lcore 1:1 map to cpu id */
 		CPU_SET(lcore_id, &lcore_config[lcore_id].cpuset);
 
@@ -221,22 +231,22 @@ rte_eal_cpu_init(void)
 		/* By default, each detected core is enabled */
 		config->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
 		lcore_config[lcore_id].core_role = RTE_LCORE_ROLE_RTE;
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
index 550dcb6b22..8e7c30fe08 100644
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
2.55.0

