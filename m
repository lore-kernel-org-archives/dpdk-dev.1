Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9771C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:48:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB53440E01;
	Tue, 21 Jul 2026 11:46:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7FC4040BA5
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627180; x=1816163180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yS+83bcMK89s/+piKg85FwjMLLccA4H4UoqLFXO2tYU=;
 b=eKm2ookUeJYSyopAvpjOsdZ9VIFFrQMorVFvmLRvgDouXN7fw6j7zRP3
 kbnyvw7MELqpU1NPhEz3yRQoXnjPj184H/XGXPuTKm1yYkTPlRlaHoQbN
 fm1OUPC0DUCsAqOqjdNiyfTOx6ajG4kA1GIJz5OqTZzGzfDWYjHEYWx1q
 nJCSORMZ1d+64bzuNKWIJWSbIqmH2LYWelJbGZQ9HM/Gz/S3Cj4clH/Hk
 R3SgGuo5nPDddFbxz3JVxDhA7bMSVEvsHy1Cd32QrDtxc2dYIX4+3SlWU
 OzeGxvLzKAqgQBhM4EiuUJpIOgl6Ys7FWqK5y5FPkJgh4lFT0Z+71yL0q g==;
X-CSE-ConnectionGUID: VxcyCAe4R+y9WvjoMc/Iqw==
X-CSE-MsgGUID: 2vBtgCxCSvSuXAWtl73mOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872478"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872478"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:19 -0700
X-CSE-ConnectionGUID: o3GsetljT1mAeZHPPezQgg==
X-CSE-MsgGUID: p3Un60MASBOdzmRGjABtRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922353"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 17/39] eal: cleanup CPU init function
Date: Tue, 21 Jul 2026 10:45:25 +0100
Message-ID: <20260721094555.2188496-18-bruce.richardson@intel.com>
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

The CPU init function did extra work in zeroing the runtime config for
lcores, something that was being done a second time in configuring the
argparsing stage when preparing to set up the correct cpu affinities for
each lcore. Therefore we can remove that unnecessary initialization, and
have the function not make any changes to "runtime_state" but only the
"platform_info".

In the process we can make some other cleanups too:
* remove the limit on the lcore_to_socket_id array, and dynamically
  allocate it to the correct number of present cores.
* with the runtime lcore init gone, we can move the assignment to the
  lcore_to_socket_id into the first loop, allowing us to remove the
  second loop entirely.
* the log message about "skipping" lcores was incorrect for modern DPDK,
  since we no longer have a hard-link between physical core numbers and
  lcore ids. Therefore just report what cores are detected on what
  sockets.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c | 92 +++++++++----------------------
 1 file changed, 25 insertions(+), 67 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index da33790b06..350329db65 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -166,18 +166,10 @@ socket_id_cmp(const void *a, const void *b)
 int
 rte_eal_cpu_init(void)
 {
-	/* pointer to global configuration */
 	struct rte_config *config = rte_eal_get_configuration();
 	struct eal_platform_info *platform_info = eal_get_platform_info();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	unsigned lcore_id;
-	unsigned count = 0;
-	unsigned int socket_id, prev_socket_id;
-#if CPU_SETSIZE > RTE_MAX_LCORE
-	int lcore_to_socket_id[CPU_SETSIZE] = {0};
-#else
-	int lcore_to_socket_id[RTE_MAX_LCORE] = {0};
-#endif
+	int *lcore_to_socket_id;
+	size_t nb_detected_cpus = 0;
 
 	/* allocate cpu_info for all CPUs visible to the OS */
 	platform_info->cpu_count = eal_cpu_max();
@@ -187,6 +179,12 @@ rte_eal_cpu_init(void)
 		EAL_LOG(ERR, "Cannot allocate cpu_info array");
 		return -1;
 	}
+	lcore_to_socket_id = calloc(platform_info->cpu_count, sizeof(*lcore_to_socket_id));
+	if (lcore_to_socket_id == NULL) {
+		EAL_LOG(ERR, "Cannot allocate lcore_to_socket_id array");
+		free(platform_info->cpu_info);
+		return -1;
+	}
 
 	/* populate cpu_info with hardware topology for all detected CPUs */
 	for (size_t cpu_id = 0; cpu_id < platform_info->cpu_count; cpu_id++) {
@@ -195,71 +193,30 @@ rte_eal_cpu_init(void)
 		platform_info->cpu_info[cpu_id].detected = true;
 		platform_info->cpu_info[cpu_id].numa_id = eal_cpu_socket_id(cpu_id);
 		platform_info->cpu_info[cpu_id].core_id = eal_cpu_core_id(cpu_id);
-	}
-
-	/*
-	 * Parse the maximum set of logical cores, detect the subset of running
-	 * ones and enable them by default.
-	 */
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		runtime_state->lcore_cfg[lcore_id].core_index = count;
-
-		/* init cpuset for per lcore config */
-		CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
-		runtime_state->lcore_cfg[lcore_id].first_cpu = UINT16_MAX;
+		/* store numa id for later processing to determine all unique numa nodes */
+		lcore_to_socket_id[nb_detected_cpus++] = platform_info->cpu_info[cpu_id].numa_id;
 
-		if (eal_cpu_detected(lcore_id) == 0) {
-			config->lcore_role[lcore_id] = ROLE_OFF;
-			runtime_state->lcore_cfg[lcore_id].core_index = -1;
-			continue;
-		}
-
-		/* find socket first */
-		socket_id = platform_info->cpu_info[lcore_id].numa_id;
-		lcore_to_socket_id[lcore_id] = socket_id;
-
-		/* By default, lcore 1:1 map to cpu id */
-		CPU_SET(lcore_id, &runtime_state->lcore_cfg[lcore_id].cpuset);
-		runtime_state->lcore_cfg[lcore_id].first_cpu = lcore_id;
-
-		/* This is the first time we discover the lcores, so the bitset should be zeroed */
-		rte_bitset_set(runtime_state->core_indices, count);
-
-		/* By default, each detected core is enabled */
-		config->lcore_role[lcore_id] = ROLE_RTE;
-		EAL_LOG(DEBUG, "Detected lcore %u as "
-				"core %u on NUMA node %u",
-				lcore_id,
-				platform_info->cpu_info[lcore_id].core_id,
-				platform_info->cpu_info[lcore_id].numa_id);
-		count++;
-	}
-	for (; lcore_id < CPU_SETSIZE; lcore_id++) {
-		if (eal_cpu_detected(lcore_id) == 0)
-			continue;
-		if (unlikely(lcore_id >= platform_info->cpu_count))
-			break;
-		lcore_to_socket_id[lcore_id] = platform_info->cpu_info[lcore_id].numa_id;
-		EAL_LOG(DEBUG, "Skipped lcore %u as core %u on NUMA node %u",
-			lcore_id, platform_info->cpu_info[lcore_id].core_id,
-			platform_info->cpu_info[lcore_id].numa_id);
+		EAL_LOG(DEBUG, "Detected CPU %zu as core %u on NUMA node %u",
+				cpu_id,
+				platform_info->cpu_info[cpu_id].core_id,
+				platform_info->cpu_info[cpu_id].numa_id);
 	}
 
-	/* Set the count of enabled logical cores of the EAL configuration */
-	config->lcore_count = count;
-	EAL_LOG(DEBUG,
-			"Maximum logical cores by configuration: %u",
-			RTE_MAX_LCORE);
-	EAL_LOG(INFO, "Detected CPU lcores: %u", config->lcore_count);
+	if (nb_detected_cpus == 0) {
+		EAL_LOG(ERR, "No CPUs detected for platform topology");
+		free(platform_info->cpu_info);
+		free(lcore_to_socket_id);
+		return -1;
+	}
 
 	/* sort all socket id's in ascending order */
-	qsort(lcore_to_socket_id, RTE_DIM(lcore_to_socket_id),
+	qsort(lcore_to_socket_id, nb_detected_cpus,
 			sizeof(lcore_to_socket_id[0]), socket_id_cmp);
 
-	prev_socket_id = -1;
+	int prev_socket_id = -1;
 	config->numa_node_count = 0;
-	for (lcore_id = 0; lcore_id < RTE_DIM(lcore_to_socket_id); lcore_id++) {
-		socket_id = lcore_to_socket_id[lcore_id];
+	for (size_t i = 0; i < nb_detected_cpus; i++) {
+		int socket_id = lcore_to_socket_id[i];
 		if (socket_id != prev_socket_id)
 			config->numa_nodes[config->numa_node_count++] =	socket_id;
 		prev_socket_id = socket_id;
@@ -268,6 +225,7 @@ rte_eal_cpu_init(void)
 	}
 	EAL_LOG(INFO, "Detected NUMA nodes: %u", config->numa_node_count);
 
+	free(lcore_to_socket_id);
 	return 0;
 }
 
-- 
2.53.0

