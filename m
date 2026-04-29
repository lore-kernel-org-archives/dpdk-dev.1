Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE34FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:01:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5986140E2F;
	Wed, 29 Apr 2026 18:59:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 606E940BA5;
 Wed, 29 Apr 2026 18:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481955; x=1809017955;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HV3NoV2IXjwBQncnyQFZxXvwls0kQZ8no7SXFNjRCLQ=;
 b=RVkIAz+4rVtCI7vQBWOUZi2rXLJCf6U+NPvtu12v5EDjQLGx6K/Wunxj
 f6kV/c6vY4M+n60EztJEnWqcF9BYtbE7ZBvBsGGZ1ehqm8L/L+iBpvTju
 FEmgqQh0Op8SRsvtFyAFlUVdZJSQ6/F2lyVzKV08XdSaDhVi4SsqitDZJ
 bp62KZh2ITpIS+d9Z0QzUkTvKxCv3W+8wrtve1Ccu9SeETPaiN1ZPHkUB
 13RTQ/pkLxI4+Qd0Iakni85Wtiepj+mEZ3DjLaBpYHEMU8ZeytWzdnVvO
 3GS9Lsc9/B4DeglKUDUPVC1ozzPf2kRLudBF+MShqz2aC6ZYnJ00P+1C5 g==;
X-CSE-ConnectionGUID: zdAEjKpoRBOPqL+memrNCA==
X-CSE-MsgGUID: Bst9uKKTRRuZjKSZgsY08g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725319"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725319"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:14 -0700
X-CSE-ConnectionGUID: UstkRBeSRzOwR5wPQ+U+VA==
X-CSE-MsgGUID: +Uq/uq40RLOVNM0zZzyrhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696977"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 15/44] eal: move numa node information to platform info
 struct
Date: Wed, 29 Apr 2026 17:58:07 +0100
Message-ID: <20260429165845.2136843-16-bruce.richardson@intel.com>
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

The numa node information for the platform is stored in rte_config but
belongs more in platform info struct. Move the data to that location. In
the process remove the hard-coded limit for RTE_MAX_NUMA_NODES for the
array. At least for platform info, we can record details about all numa
nodes, whatever the number.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_lcore.c | 45 +++++++++++++++++++++----------
 lib/eal/common/eal_internal_cfg.h |  2 ++
 lib/eal/common/eal_private.h      |  2 --
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 808fffbb6c..01cbaf572b 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -167,7 +167,6 @@ socket_id_cmp(const void *a, const void *b)
 int
 rte_eal_cpu_init(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 	int *lcore_to_socket_id;
 
@@ -206,19 +205,37 @@ rte_eal_cpu_init(void)
 	qsort(lcore_to_socket_id, platform_info->cpu_count,
 			sizeof(lcore_to_socket_id[0]), socket_id_cmp);
 
+	/* allocate worst-case (one NUMA node per CPU), then dedup and shrink */
+	platform_info->numa_nodes = malloc(platform_info->cpu_count *
+			sizeof(*platform_info->numa_nodes));
+	if (platform_info->numa_nodes == NULL) {
+		EAL_LOG(ERR, "Cannot allocate numa_nodes array");
+		free(lcore_to_socket_id);
+		free(platform_info->cpu_info);
+		return -1;
+	}
+
+	uint32_t numa_node_count = 0;
 	int prev_socket_id = -1;
-	config->numa_node_count = 0;
 	for (size_t cpu_id = 0; cpu_id < platform_info->cpu_count; cpu_id++) {
 		int socket_id = lcore_to_socket_id[cpu_id];
-		if (socket_id != prev_socket_id)
-			config->numa_nodes[config->numa_node_count++] =	socket_id;
-		prev_socket_id = socket_id;
-		if (config->numa_node_count >= RTE_MAX_NUMA_NODES)
-			break;
+		if (socket_id != prev_socket_id) {
+			platform_info->numa_nodes[numa_node_count++] = socket_id;
+			prev_socket_id = socket_id;
+		}
 	}
-	EAL_LOG(INFO, "Detected NUMA nodes: %u", config->numa_node_count);
-
+	platform_info->numa_node_count = numa_node_count;
 	free(lcore_to_socket_id);
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
 
@@ -226,20 +243,20 @@ RTE_EXPORT_SYMBOL(rte_socket_count)
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
index ef4bcfc01a..17e96ab634 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -105,6 +105,8 @@ struct eal_cpu_info {
 struct eal_platform_info {
 	size_t cpu_count;                /**< number of entries in cpu_info[] */
 	struct eal_cpu_info *cpu_info;   /**< per-physical-CPU hardware facts */
+	uint32_t numa_node_count;        /**< number of detected NUMA nodes */
+	uint32_t *numa_nodes;            /**< sorted list of detected NUMA node IDs, heap-allocated */
 	uint8_t num_hugepage_sizes;      /**< how many sizes on this system */
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 };
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index bd9c9f2b70..86500cbc5b 100644
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
2.51.0

