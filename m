Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4D2C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C90B740E0F;
	Tue, 21 Jul 2026 11:46:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id F0DB8406B6
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627180; x=1816163180;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2a19VaDrTZo1wNP3l+RfDRN1reCSaxNtd/I+N9CA0DU=;
 b=WuE4G7XcorTtosAQ5QNSfLT3VRh19VXYQD7Ur894Nam0bzsMBqRLP9Lv
 oHabGeHE5j23hRr+qn/2eV1GfskFKVpmIlyKi3uXNxoXtRRjhLH0XSSSb
 J8MyCtFRr9vT0IT1vZAuNspzHAiMPYVXwbYJcSzaD0Cts9D/dlqvsmrB7
 jBJR0uz9c8r8T/tzpWNuh5MS9tocpXd3WWP/swcUjDiSGdt5xoFigjKqB
 G41Ktn6iUrgw9/11B5HwphNDjHiWhCMIOuYnLqFpG6nltG4GVYh/hYTJ/
 EdTDHoZi76NyU1zTYq0mcpbqsabshA6m98zJMyaDDEY7LUhndyWobC8uT g==;
X-CSE-ConnectionGUID: mEvR7fXCQ7eSZgMVI4y9sA==
X-CSE-MsgGUID: iqlfAlbFS8yZxLw28jgu2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872479"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872479"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:20 -0700
X-CSE-ConnectionGUID: mapp3qpoSZyHDjj/wfSjJw==
X-CSE-MsgGUID: UdYW62g3REOQAv+9wmnplQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922358"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 18/39] eal: move NUMA node information to platform info struct
Date: Tue, 21 Jul 2026 10:45:26 +0100
Message-ID: <20260721094555.2188496-19-bruce.richardson@intel.com>
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
index 350329db65..43acc6ebee 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -166,7 +166,6 @@ socket_id_cmp(const void *a, const void *b)
 int
 rte_eal_cpu_init(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 	int *lcore_to_socket_id;
 	size_t nb_detected_cpus = 0;
@@ -213,19 +212,47 @@ rte_eal_cpu_init(void)
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
 
@@ -233,20 +260,20 @@ RTE_EXPORT_SYMBOL(rte_socket_count)
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
index 35760fee6f..a28e2d9fdf 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -112,6 +112,8 @@ struct eal_cpu_info {
 struct eal_platform_info {
 	size_t cpu_count;                /**< number of entries in cpu_info[] */
 	struct eal_cpu_info *cpu_info;   /**< per-physical-CPU hardware facts */
+	uint32_t numa_node_count;        /**< number of detected NUMA nodes */
+	uint32_t *numa_nodes;            /**< sorted list of detected NUMA node IDs */
 	uint8_t num_hugepage_sizes;      /**< how many sizes on this system */
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 };
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 65ae4df27c..7a7332114f 100644
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
2.53.0

