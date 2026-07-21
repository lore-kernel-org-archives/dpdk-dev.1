Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31557C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:48:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5549540E2C;
	Tue, 21 Jul 2026 11:46:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id AED5640DD5
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627184; x=1816163184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g4bsRf6BPtTwqA2fBflltTPHsyk151yZSTghfAGDrd0=;
 b=N1/O/JO4s0AWISq04cvcQxcH/aGD1yjTy+eul6KLRzxp9bztXmSZ54Sj
 qVwFpppXDoPq5otNiFHU1RsBZl9lFamD6zgmZpByHYHAyVC+jc9twgH+K
 hYr/qnnqNcYT2SeOXYa7QmG26tknOIZiX/GZJ9KBdKBVXSHyc1voJms04
 IxsHSfd8V6/vPq+ZDgKGMte5Y8jMrq5YUIQCgV0TUwpDC2vQ3sYsfaN3F
 qrjAn6V+WHznNqru41ew1YaM/igQ0xHHVXgVpD2ptO0bleK4ux1goku8V
 TIqId3pVXwgK7XND1zVAmacnmkcAfepl1YLJNnF/V4iHQPCZn6xAodtrL g==;
X-CSE-ConnectionGUID: zkKjLmYKSKiavhfc+3jrnw==
X-CSE-MsgGUID: jJITYIMkT5m3EHVrxn2UjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872486"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872486"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:23 -0700
X-CSE-ConnectionGUID: QeUEy4ttRLye+yW1MtMz2Q==
X-CSE-MsgGUID: erTnl8w0QmK4jtXPcCSgbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922376"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 21/39] eal: move main lcore setting to runtime config struct
Date: Tue, 21 Jul 2026 10:45:29 +0100
Message-ID: <20260721094555.2188496-22-bruce.richardson@intel.com>
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
 lib/eal/common/eal_common_options.c | 32 ++++++++++++++++-------------
 lib/eal/common/eal_internal_cfg.h   |  2 ++
 lib/eal/common/eal_private.h        |  1 -
 lib/eal/common/rte_service.c        |  3 +--
 lib/eal/freebsd/eal.c               | 12 +++++------
 lib/eal/linux/eal.c                 | 12 +++++------
 lib/eal/linux/eal_memory.c          |  3 +--
 lib/eal/windows/eal.c               |  9 ++++----
 10 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 9c421be225..df6cdb00e9 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -420,11 +420,9 @@ eal_dynmem_calc_num_pages_per_socket(
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
index 0b59262364..f45cdb2800 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -23,7 +23,7 @@
 RTE_EXPORT_SYMBOL(rte_get_main_lcore)
 unsigned int rte_get_main_lcore(void)
 {
-	return rte_eal_get_configuration()->main_lcore;
+	return eal_get_runtime_state()->main_lcore;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_count)
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 05b6eb418b..68909e97b0 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1194,23 +1194,24 @@ static int
 eal_parse_main_lcore(const char *arg)
 {
 	char *parsing_end;
-	struct rte_config *cfg = rte_eal_get_configuration();
-	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	long main_lcore;
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	errno = 0;
-	cfg->main_lcore = (uint32_t) strtol(arg, &parsing_end, 0);
-	if (errno || parsing_end[0] != 0)
-		return -1;
-	if (cfg->main_lcore >= RTE_MAX_LCORE)
+	main_lcore = strtol(arg, &parsing_end, 0);
+	if (errno || parsing_end[0] != 0 || main_lcore < 0 ||
+			main_lcore >= RTE_MAX_LCORE)
 		return -1;
+	user_cfg->main_lcore = (int)main_lcore;
 
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
@@ -2078,7 +2079,7 @@ int
 eal_parse_args(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct rte_config *rte_cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
 	uint16_t lcore_id_base = 0;
@@ -2202,13 +2203,16 @@ eal_parse_args(void)
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
index 2ee2fe5a4a..c14d11b225 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -93,6 +93,7 @@ struct eal_user_cfg {
 		uint64_t limit;    /**< memory limit in bytes */
 	} pagesz_mem_overrides[MAX_HUGEPAGE_SIZES];
 	unsigned int num_pagesz_mem_overrides;  /**< number of stored overrides */
+	int main_lcore;          /**< ID of the main lcore */
 };
 
 /**
@@ -148,6 +149,7 @@ struct eal_runtime_state {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
+	uint32_t main_lcore;          /**< ID of the main lcore */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 07500dd449..11f1571466 100644
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
index 0aacc5a304..eeeffd08a5 100644
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
@@ -653,18 +651,18 @@ rte_eal_init(int argc, char **argv)
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
index 51ab6a90dc..361af0c1ed 100644
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
 
@@ -829,17 +827,17 @@ rte_eal_init(int argc, char **argv)
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
index 1fc01beae9..8e61a0a6ae 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1762,7 +1762,6 @@ memseg_primary_init_32(void)
 		int hp_sizes = (int) platform_info->num_hugepage_sizes;
 		uint64_t max_socket_mem, cur_socket_mem;
 		unsigned int main_lcore_socket;
-		struct rte_config *cfg = rte_eal_get_configuration();
 		bool skip;
 		int ret;
 
@@ -1785,7 +1784,7 @@ memseg_primary_init_32(void)
 		/* ...or if we didn't specifically request memory on *any*
 		 * socket, and this is not main lcore
 		 */
-		main_lcore_socket = rte_lcore_to_socket_id(cfg->main_lcore);
+		main_lcore_socket = rte_lcore_to_socket_id(rte_get_main_lcore());
 		skip |= active_sockets == 0 && socket_id != main_lcore_socket;
 
 		if (skip) {
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 88fc168976..82b3886d9e 100644
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
@@ -346,17 +345,17 @@ rte_eal_init(int argc, char **argv)
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
2.53.0

