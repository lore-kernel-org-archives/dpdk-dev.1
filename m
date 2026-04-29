Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA13CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9315740E4A;
	Wed, 29 Apr 2026 18:59:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3DEF140E30;
 Wed, 29 Apr 2026 18:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481959; x=1809017959;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5I0zSDZxBBEyVyhC11uzy4D2W8xVjChVx2QIZMfjagY=;
 b=CmmxK5/Gt65lLNxnNj7YpBhA1hYfRWzPHXbyrpR5SrZaJx8VdNIuiX7r
 LxNwR1yOVFf7Ca6bzWeMHwPNGprhIlJFKjf2tIgvv8b0Pzl/xIoHZSn7r
 GnEMdPjm44VA2rK/ThSf9s0hqrNBuEiMmN03ATNrWZ8P+lbS0juVKKDjs
 tBFwz7Wwz9l+h6eNjlC7n4YyF12r12IBzBgawHVyWX5r1UjaHaAGObus7
 WRr6uIrIaGKm40xMABmCZ9FsoS2Mlk9NYF00ucmVkAAwI9zwDgAsocDo0
 DHbBv5LX+4+h5pVUah9AM4L4s1olg1JO+q7P8QWvMEN4VZDAdEzJWsUpv A==;
X-CSE-ConnectionGUID: IHmCNLr3RA+bMmUUNcMPWg==
X-CSE-MsgGUID: 8mhvLM6lTNS6Z0CdaVN20w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725325"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725325"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:18 -0700
X-CSE-ConnectionGUID: s4NDUdkeR2q+7FBLYEeZvQ==
X-CSE-MsgGUID: Z/QceKYRRNq+GOCUZnEgfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696990"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 18/44] eal: move main lcore setting to runtime config
 struct
Date: Wed, 29 Apr 2026 17:58:10 +0100
Message-ID: <20260429165845.2136843-19-bruce.richardson@intel.com>
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

Move the main lcore setting from the rte_config struct to the new
runtime structure. One additional wrinkle here is that this is an
optional user setting, so it also needs to be stored in eal_user_cfg if
specified. The difference is that the eal_user_cfg value is the raw
value and can be "-1" if unspecified, while the runtime config value has
to have a valid lcore id.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_dynmem.c  |  4 +---
 lib/eal/common/eal_common_lcore.c   |  2 +-
 lib/eal/common/eal_common_options.c | 27 +++++++++++++++------------
 lib/eal/common/eal_internal_cfg.h   |  2 ++
 lib/eal/common/eal_private.h        |  1 -
 lib/eal/common/rte_service.c        |  3 +--
 lib/eal/freebsd/eal.c               | 12 +++++-------
 lib/eal/linux/eal.c                 | 12 +++++-------
 lib/eal/linux/eal_memory.c          |  3 +--
 lib/eal/windows/eal.c               |  9 ++++-----
 10 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index c1c72499c4..674ea5ec42 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -437,11 +437,9 @@ eal_dynmem_calc_num_pages_per_socket(
 		total_size = user_cfg->memory;
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES && total_size != 0;
 				socket++) {
-			struct rte_config *cfg = rte_eal_get_configuration();
 			unsigned int main_lcore_socket;
 
-			main_lcore_socket =
-				rte_lcore_to_socket_id(cfg->main_lcore);
+			main_lcore_socket = rte_lcore_to_socket_id(rte_get_main_lcore());
 
 			if (main_lcore_socket != socket)
 				continue;
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 1ec1dc080a..bafcfe78d2 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -22,7 +22,7 @@
 RTE_EXPORT_SYMBOL(rte_get_main_lcore)
 unsigned int rte_get_main_lcore(void)
 {
-	return rte_eal_get_configuration()->main_lcore;
+	return eal_get_runtime_state()->main_lcore;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_count)
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 83e0d986a5..9b3ba64c4c 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1168,23 +1168,23 @@ static int
 eal_parse_main_lcore(const char *arg)
 {
 	char *parsing_end;
-	struct rte_config *cfg = rte_eal_get_configuration();
-	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	errno = 0;
-	cfg->main_lcore = (uint32_t) strtol(arg, &parsing_end, 0);
+	user_cfg->main_lcore = (uint32_t) strtol(arg, &parsing_end, 0);
 	if (errno || parsing_end[0] != 0)
 		return -1;
-	if (cfg->main_lcore >= RTE_MAX_LCORE)
+	if (user_cfg->main_lcore >= RTE_MAX_LCORE)
 		return -1;
 
 	/* ensure main core is not used as service core */
-	if (runtime_state->lcore_cfg[cfg->main_lcore].role == ROLE_SERVICE) {
+	if (runtime_state->lcore_cfg[user_cfg->main_lcore].role == ROLE_SERVICE) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
 	/* check that we have the core recorded in the core list */
-	if (runtime_state->lcore_cfg[cfg->main_lcore].role != ROLE_RTE) {
+	if (runtime_state->lcore_cfg[user_cfg->main_lcore].role != ROLE_RTE) {
 		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
@@ -1960,7 +1960,7 @@ int
 eal_parse_args(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct rte_config *rte_cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
 	uint16_t lcore_id_base = 0;
@@ -2084,13 +2084,16 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
-	if (args.main_lcore != NULL) {
-		if (eal_parse_main_lcore(args.main_lcore) < 0)
-			return -1;
+	user_cfg->main_lcore = -1;
+	if (args.main_lcore != NULL && eal_parse_main_lcore(args.main_lcore) < 0)
+		return -1;
+
+	if (user_cfg->main_lcore != -1) {
+		runtime_state->main_lcore = user_cfg->main_lcore;
 	} else {
 		/* default main lcore is the first one */
-		rte_cfg->main_lcore = rte_get_next_lcore(-1, 0, 0);
-		if (rte_cfg->main_lcore >= RTE_MAX_LCORE) {
+		runtime_state->main_lcore = rte_get_next_lcore(-1, 0, 0);
+		if (runtime_state->main_lcore >= RTE_MAX_LCORE) {
 			EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
 			return -1;
 		}
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 41a1437435..5572af28af 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -86,6 +86,7 @@ struct eal_user_cfg {
 	uintptr_t base_virtaddr; /**< base address to try and reserve memory from */
 	uint64_t numa_mem[RTE_MAX_NUMA_NODES];    /**< amount of memory per NUMA node */
 	uint64_t numa_limit[RTE_MAX_NUMA_NODES];  /**< limit amount of memory per NUMA node */
+	int main_lcore;          /**< ID of the main lcore */
 };
 
 /**
@@ -138,6 +139,7 @@ struct eal_runtime_state {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
+	uint32_t main_lcore;          /**< ID of the main lcore */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 };
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 80fa49ce8b..ffbaba6add 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -21,7 +21,6 @@
  * The global RTE configuration structure.
  */
 struct rte_config {
-	uint32_t main_lcore;         /**< Id of the main lcore */
 
 	/** Primary or secondary configuration */
 	enum rte_proc_type_t process_type;
diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index e28e17f8d5..aa068f88ea 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -105,11 +105,10 @@ rte_service_init(void)
 		RTE_LCORE_VAR_ALLOC(lcore_states);
 
 	int i;
-	const struct rte_config *cfg = rte_eal_get_configuration();
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		if (runtime_state->lcore_cfg[i].role == ROLE_SERVICE) {
-			if ((unsigned int)i == cfg->main_lcore)
+			if ((unsigned int)i == runtime_state->main_lcore)
 				continue;
 			rte_service_lcore_add(i);
 		}
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index a75af85a7c..30702f5b20 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -358,9 +358,8 @@ static void
 eal_check_mem_on_local_socket(void)
 {
 	int socket_id;
-	const struct rte_config *config = rte_eal_get_configuration();
 
-	socket_id = rte_lcore_to_socket_id(config->main_lcore);
+	socket_id = rte_lcore_to_socket_id(rte_get_main_lcore());
 
 	if (rte_memseg_list_walk(check_socket, &socket_id) == 0)
 		EAL_LOG(WARNING, "WARNING: Main core has no memory on local socket!");
@@ -403,7 +402,6 @@ rte_eal_init(int argc, char **argv)
 	uint32_t has_run = 0;
 	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
 	char thread_name[RTE_THREAD_NAME_SIZE];
-	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool has_phys_addr;
@@ -647,18 +645,18 @@ rte_eal_init(int argc, char **argv)
 	eal_check_mem_on_local_socket();
 
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
-			&runtime_state->lcore_cfg[config->main_lcore].cpuset) != 0) {
+			&runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
-	__rte_thread_init(config->main_lcore,
-		&runtime_state->lcore_cfg[config->main_lcore].cpuset);
+	__rte_thread_init(rte_get_main_lcore(),
+		&runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset);
 
 	ret = eal_thread_dump_current_affinity(cpuset, sizeof(cpuset));
 
 	EAL_LOG(DEBUG, "Main lcore %u is ready (tid=%zx;cpuset=[%s%s])",
-		config->main_lcore, (uintptr_t)pthread_self(), cpuset,
+		rte_get_main_lcore(), (uintptr_t)pthread_self(), cpuset,
 		ret == 0 ? "" : "...");
 
 	RTE_LCORE_FOREACH_WORKER(i) {
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 9ef4b4e6f5..71c15d1ad5 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -439,9 +439,8 @@ static void
 eal_check_mem_on_local_socket(void)
 {
 	int socket_id;
-	const struct rte_config *config = rte_eal_get_configuration();
 
-	socket_id = rte_lcore_to_socket_id(config->main_lcore);
+	socket_id = rte_lcore_to_socket_id(rte_get_main_lcore());
 
 	if (rte_memseg_list_walk(check_socket, &socket_id) == 0)
 		EAL_LOG(WARNING, "WARNING: Main core has no memory on local socket!");
@@ -566,7 +565,6 @@ rte_eal_init(int argc, char **argv)
 	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
 	char thread_name[RTE_THREAD_NAME_SIZE];
 	bool phys_addrs;
-	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
@@ -823,17 +821,17 @@ rte_eal_init(int argc, char **argv)
 	eal_check_mem_on_local_socket();
 
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
-			&runtime_state->lcore_cfg[config->main_lcore].cpuset) != 0) {
+			&runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
-	__rte_thread_init(config->main_lcore,
-		&runtime_state->lcore_cfg[config->main_lcore].cpuset);
+	__rte_thread_init(rte_get_main_lcore(),
+		&runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset);
 
 	ret = eal_thread_dump_current_affinity(cpuset, sizeof(cpuset));
 	EAL_LOG(DEBUG, "Main lcore %u is ready (tid=%zx;cpuset=[%s%s])",
-		config->main_lcore, (uintptr_t)pthread_self(), cpuset,
+		rte_get_main_lcore(), (uintptr_t)pthread_self(), cpuset,
 		ret == 0 ? "" : "...");
 
 	RTE_LCORE_FOREACH_WORKER(i) {
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 36763bb44f..c341e9a599 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1778,7 +1778,6 @@ memseg_primary_init_32(void)
 		int hp_sizes = (int) platform_info->num_hugepage_sizes;
 		uint64_t max_socket_mem, cur_socket_mem;
 		unsigned int main_lcore_socket;
-		struct rte_config *cfg = rte_eal_get_configuration();
 		bool skip;
 		int ret;
 
@@ -1801,7 +1800,7 @@ memseg_primary_init_32(void)
 		/* ...or if we didn't specifically request memory on *any*
 		 * socket, and this is not main lcore
 		 */
-		main_lcore_socket = rte_lcore_to_socket_id(cfg->main_lcore);
+		main_lcore_socket = rte_lcore_to_socket_id(rte_get_main_lcore());
 		skip |= active_sockets == 0 && socket_id != main_lcore_socket;
 
 		if (skip) {
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 988352f867..0d1ba3aaeb 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -154,7 +154,6 @@ int
 rte_eal_init(int argc, char **argv)
 {
 	int i, fctret, bscan;
-	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool has_phys_addr;
@@ -340,17 +339,17 @@ rte_eal_init(int argc, char **argv)
 	eal_rand_init();
 
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
-			&runtime_state->lcore_cfg[config->main_lcore].cpuset) != 0) {
+			&runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
-	__rte_thread_init(config->main_lcore,
-		&runtime_state->lcore_cfg[config->main_lcore].cpuset);
+	__rte_thread_init(rte_get_main_lcore(),
+		&runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset);
 
 	ret = eal_thread_dump_current_affinity(cpuset, sizeof(cpuset));
 	EAL_LOG(DEBUG, "Main lcore %u is ready (tid=%zx;cpuset=[%s%s])",
-		config->main_lcore, rte_thread_self().opaque_id, cpuset,
+		rte_get_main_lcore(), rte_thread_self().opaque_id, cpuset,
 		ret == 0 ? "" : "...");
 
 	RTE_LCORE_FOREACH_WORKER(i) {
-- 
2.51.0

