Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560EF606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PdUye8Wk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A29E440616;
	Thu, 26 Nov 2026 19:15:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id C800240609
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716910; x=1827252910;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6TdzA2I4YvNdyAYhkS88zX0vohs/1cUSu7ZgT0ZTC/w=;
 b=PdUye8WkOKsW+Om76GEJSU5dUOdRcwZCGf3yttsJtA5qLYConXU/wnOv
 gS7FZGm3agpia6P0uzKySrVHtaeqMayWfXQCgLNbGmZddvvBJgs7bYsmK
 jl1Z4PlZCj3Kr93brEo4sUYLt0WVMo/+FYD/HZc7ua+PB2nATrrvtcNU4
 7/YsoFd1x8LKjsH61dL6Jg4w+nHAyFcABlMDAl+n8IWV6iZ60hU5To6pK
 JbfXA3D+G1vo6gsqlRyfnqc5cPhg5Fq4MGLXsgTcD8HCgeIEZmc7XrqMY
 i7tMsYgeC8TcCTANTCWgYxwgU+sNM8t5KNDGLR5mMtzdHDuxVhky4d8Na A==;
X-CSE-ConnectionGUID: lD8LD3c3QaCbio+0/O6vUg==
X-CSE-MsgGUID: HN+ATUYUQiO5STYSFyLXlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633609"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633609"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:09 -0800
X-CSE-ConnectionGUID: YigAosWnRlWgF1Q/N8MxQQ==
X-CSE-MsgGUID: 4rZ/XgQ6Rb29vxdVruuDdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732921"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:34 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 18/39] eal: move NUMA node information to platform info
 struct
Date: Thu, 26 Nov 2026 18:13:51 +0000
Message-ID: <20261126181414.124094-19-bruce.richardson@intel.com>
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

The numa node information for the platform is stored in rte_config but
belongs more in platform info struct. Move the data to that location. In
the process remove the hard-coded limit for RTE_MAX_NUMA_NODES for the
array. At least for platform info, we can record details about all numa
nodes, whatever the number.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c | 59 ++++++++++++++++++++++---------
 lib/eal/common/eal_internal_cfg.h |  2 ++
 lib/eal/common/eal_private.h      |  2 --
 3 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 02fbadb0ba..e208ee7437 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -177,7 +177,6 @@ socket_id_cmp(const void *a, const void *b)
 int
 rte_eal_cpu_init(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 	int *lcore_to_socket_id;
 	size_t nb_detected_cpus = 0;
@@ -224,19 +223,47 @@ rte_eal_cpu_init(void)
 	qsort(lcore_to_socket_id, nb_detected_cpus,
 			sizeof(lcore_to_socket_id[0]), socket_id_cmp);
 
-	int prev_socket_id = -1;
-	config->numa_node_count = 0;
-	for (size_t i = 0; i < nb_detected_cpus; i++) {
-		int socket_id = lcore_to_socket_id[i];
-		if (socket_id != prev_socket_id)
-			config->numa_nodes[config->numa_node_count++] =	socket_id;
-		prev_socket_id = socket_id;
-		if (config->numa_node_count >= RTE_MAX_NUMA_NODES)
-			break;
+	/* allocate worst-case (one NUMA node per CPU), then dedup and shrink */
+	platform_info->numa_nodes = calloc(platform_info->cpu_count,
+			sizeof(*platform_info->numa_nodes));
+	if (platform_info->numa_nodes == NULL) {
+		EAL_LOG(ERR, "Cannot allocate numa_nodes array");
+		free(lcore_to_socket_id);
+		free(platform_info->cpu_info);
+		return -1;
 	}
-	EAL_LOG(INFO, "Detected NUMA nodes: %u", config->numa_node_count);
 
+	uint32_t numa_node_count = 0;
+	int prev_socket_id = -1;
+	for (size_t cpu_id = 0; cpu_id < nb_detected_cpus; cpu_id++) {
+		int socket_id = lcore_to_socket_id[cpu_id];
+		if (socket_id != prev_socket_id) {
+			platform_info->numa_nodes[numa_node_count++] = socket_id;
+			prev_socket_id = socket_id;
+		}
+	}
 	free(lcore_to_socket_id);
+
+	if (numa_node_count > RTE_MAX_NUMA_NODES) {
+		EAL_LOG(ERR, "Detected %u NUMA nodes, but only RTE_MAX_NUMA_NODES (%u) are supported",
+				numa_node_count, RTE_MAX_NUMA_NODES);
+		free(platform_info->numa_nodes);
+		platform_info->numa_nodes = NULL;
+		free(platform_info->cpu_info);
+		platform_info->cpu_info = NULL;
+		return -1;
+	}
+	platform_info->numa_node_count = numa_node_count;
+
+	/* shrink to the actual number of unique NUMA nodes found,
+	 * realloc may fail, in that case we keep the original allocation
+	 */
+	uint32_t *tmp = realloc(platform_info->numa_nodes,
+			numa_node_count * sizeof(*platform_info->numa_nodes));
+	if (tmp != NULL)
+		platform_info->numa_nodes = tmp;
+	EAL_LOG(INFO, "Detected NUMA nodes: %u", platform_info->numa_node_count);
+
 	return 0;
 }
 
@@ -244,20 +271,20 @@ RTE_EXPORT_SYMBOL(rte_socket_count)
 unsigned int
 rte_socket_count(void)
 {
-	const struct rte_config *config = rte_eal_get_configuration();
-	return config->numa_node_count;
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	return platform_info->numa_node_count;
 }
 
 RTE_EXPORT_SYMBOL(rte_socket_id_by_idx)
 int
 rte_socket_id_by_idx(unsigned int idx)
 {
-	const struct rte_config *config = rte_eal_get_configuration();
-	if (idx >= config->numa_node_count) {
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	if (idx >= platform_info->numa_node_count) {
 		rte_errno = EINVAL;
 		return -1;
 	}
-	return config->numa_nodes[idx];
+	return platform_info->numa_nodes[idx];
 }
 
 static rte_rwlock_t lcore_lock = RTE_RWLOCK_INITIALIZER;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index e0a3c8dec5..feb7baf71f 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -118,6 +118,8 @@ struct eal_cpu_info {
 struct eal_platform_info {
 	size_t cpu_count;                /**< number of entries in cpu_info[] */
 	struct eal_cpu_info *cpu_info;   /**< per-physical-CPU hardware facts */
+	uint32_t numa_node_count;        /**< number of detected NUMA nodes */
+	uint32_t *numa_nodes;            /**< sorted list of detected NUMA node IDs */
 	uint8_t num_hugepage_sizes;      /**< how many sizes on this system */
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 };
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index d2b99582c9..4d1a28762e 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -23,8 +23,6 @@
 struct rte_config {
 	uint32_t main_lcore;         /**< Id of the main lcore */
 	uint32_t lcore_count;        /**< Number of available logical cores. */
-	uint32_t numa_node_count;    /**< Number of detected NUMA nodes. */
-	uint32_t numa_nodes[RTE_MAX_NUMA_NODES]; /**< List of detected NUMA nodes. */
 	uint32_t service_lcore_count;/**< Number of available service cores. */
 	enum rte_lcore_role_t lcore_role[RTE_MAX_LCORE]; /**< State of cores. */
 
-- 
2.55.0

