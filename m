Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00F606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cjj7NUBG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FB3C40DD8;
	Thu, 26 Nov 2026 19:14:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 8E74640A79
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716875; x=1827252875;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=35SVbPjm54V4F/6IBG4QGz1TJWtLKd8pSdCRxdogVhE=;
 b=cjj7NUBGVCsQxXfrG866wTsXMq3j6q7cMubqkHfUwFDp+aLDRQSNzs+g
 H0GS7l9GR7ByP4CuTk80vjhyh7+Ha3KPVxs9Ly5xxgjJah5qaGteYembJ
 ktBS5l0sSArbGDk0YoNbVhCFm25o9yeV8+Cv4UFl+yL0a0n/na661rAVK
 Pe9nsdp/8NRxDQ+cyS1MYrTXkq7fQdyenjTVg9PM6KYC5kCHoC8MdpFzG
 42+bBHjBYPBkIXsjiNKt9zsS1jqatdG/2xF/TwoRfrqv6Phw+1mlGmlPi
 lZsX0X+4X40T9zzNk8qNIfRYzQZZ0nZfD2IdybFrEBDkt8smBgr4Yk0NP g==;
X-CSE-ConnectionGUID: 9hG11clnSP+pO1JO1itulg==
X-CSE-MsgGUID: BqMuvqyQTkywTk0NIiioag==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633578"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633578"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:35 -0800
X-CSE-ConnectionGUID: s1Sy5jBsRUCVtACWjj1cwg==
X-CSE-MsgGUID: Yqpcgjk+Q1G/en7HYbYKXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732918"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:33 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 17/39] eal: cleanup CPU init function
Date: Thu, 26 Nov 2026 18:13:50 +0000
Message-ID: <20261126181414.124094-18-bruce.richardson@intel.com>
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
index eab60d548a..02fbadb0ba 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -177,18 +177,10 @@ socket_id_cmp(const void *a, const void *b)
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
@@ -198,6 +190,12 @@ rte_eal_cpu_init(void)
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
@@ -206,71 +204,30 @@ rte_eal_cpu_init(void)
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
-			config->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
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
-		config->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
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
@@ -279,6 +236,7 @@ rte_eal_cpu_init(void)
 	}
 	EAL_LOG(INFO, "Detected NUMA nodes: %u", config->numa_node_count);
 
+	free(lcore_to_socket_id);
 	return 0;
 }
 
-- 
2.55.0

