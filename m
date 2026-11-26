Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1C606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=caPfrvGc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0357740A7D;
	Thu, 26 Nov 2026 19:15:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 5BD7C40684
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716917; x=1827252917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jmR9RxsB1q8NecMmXZZ8jNG+ZbM4oq4+FiA2QTFvs9E=;
 b=caPfrvGcg1rnLqc9YIJzdOlJGerv272McQIky9Xg6Sje7dVrZ4PIOMjb
 Vaczdr6RcDPu2Et3HTPxRqn0akcZp1wSMc+4GEDCKsMYav8YMhWVxxBsH
 Tow6p+3UKpMZ/5COopVLXCZLhGf+8D6xOUDrmESJLaehoV6nOkT41GCiI
 CcP8VzIE4upbYXAi5exv4+PsnexiFXRGm3grOSX7CYB1EZUDCRFl5BLyy
 os7r0mt2qJzUy7JTvnctZp7Els2Sq5xXwcJL7C9XF1Mr9k0v3B7KIUATL
 zsRgxolp/2b5BnOIkwgCfx5hpXOSbocEN9GNKNAsRJazwJFMsJYP7oRim Q==;
X-CSE-ConnectionGUID: tMhhTAlWRT6cuPnXvzA4lw==
X-CSE-MsgGUID: UuC0ialJRwyAVmIazvlQMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633613"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633613"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:15 -0800
X-CSE-ConnectionGUID: SjM7Oe6bQEWTqWPTZeSk3w==
X-CSE-MsgGUID: nZ9FQEyVR9SLkHXrQB8cUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733077"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:13 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 21/39] eal: move main lcore setting to runtime config struct
Date: Thu, 26 Nov 2026 18:13:54 +0000
Message-ID: <20261126181414.124094-22-bruce.richardson@intel.com>
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
index d5c1c62879..e431ddf03d 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -440,11 +440,9 @@ eal_dynmem_calc_num_pages_per_socket(
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
index 3a4cc70c7e..de603b2ff3 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -24,7 +24,7 @@
 RTE_EXPORT_SYMBOL(rte_get_main_lcore)
 unsigned int rte_get_main_lcore(void)
 {
-	return rte_eal_get_configuration()->main_lcore;
+	return eal_get_runtime_state()->main_lcore;
 }
 
 RTE_EXPORT_SYMBOL(rte_lcore_count)
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index e8109b94c0..b2aba99f12 100644
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
-	if (runtime_state->lcore_cfg[cfg->main_lcore].role == RTE_LCORE_ROLE_SERVICE) {
+	if (runtime_state->lcore_cfg[user_cfg->main_lcore].role == RTE_LCORE_ROLE_SERVICE) {
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
 	/* check that we have the core recorded in the core list */
-	if (runtime_state->lcore_cfg[cfg->main_lcore].role != RTE_LCORE_ROLE_RTE) {
+	if (runtime_state->lcore_cfg[user_cfg->main_lcore].role != RTE_LCORE_ROLE_RTE) {
 		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
@@ -2077,7 +2078,7 @@ int
 eal_parse_args(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct rte_config *rte_cfg = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
 	uint16_t lcore_id_base = 0;
@@ -2201,13 +2202,16 @@ eal_parse_args(void)
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
index 83944c5951..52822e4c2d 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -99,6 +99,7 @@ struct eal_user_cfg {
 		uint64_t limit;    /**< memory limit in bytes */
 	} pagesz_mem_overrides[MAX_HUGEPAGE_SIZES];
 	unsigned int num_pagesz_mem_overrides;  /**< number of stored overrides */
+	int main_lcore;          /**< ID of the main lcore */
 };
 
 /**
@@ -153,6 +154,7 @@ struct eal_runtime_state {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
+	uint32_t main_lcore;          /**< ID of the main lcore */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 7a236c5788..b146bd7f50 100644
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
index 954b5503b4..6813c22ddd 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -105,11 +105,10 @@ rte_service_init(void)
 		RTE_LCORE_VAR_ALLOC(lcore_states);
 
 	int i;
-	const struct rte_config *cfg = rte_eal_get_configuration();
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
 		if (runtime_state->lcore_cfg[i].role == RTE_LCORE_ROLE_SERVICE) {
-			if ((unsigned int)i == cfg->main_lcore)
+			if ((unsigned int)i == runtime_state->main_lcore)
 				continue;
 			rte_service_lcore_add(i);
 		}
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 89b43c450d..2cda49ea2d 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -357,9 +357,8 @@ static void
 eal_check_mem_on_local_socket(void)
 {
 	int socket_id;
-	const struct rte_config *config = rte_eal_get_configuration();
 
-	socket_id = rte_lcore_to_socket_id(config->main_lcore);
+	socket_id = rte_lcore_to_socket_id(rte_get_main_lcore());
 
 	if (rte_memseg_list_walk(check_socket, &socket_id) == 0)
 		EAL_LOG(WARNING, "WARNING: Main core has no memory on local socket!");
@@ -402,7 +401,6 @@ rte_eal_init(int argc, char **argv)
 	uint32_t has_run = 0;
 	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
 	char thread_name[RTE_THREAD_NAME_SIZE];
-	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool has_phys_addr;
@@ -652,18 +650,18 @@ rte_eal_init(int argc, char **argv)
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
index 330a245cd7..cdb8fbb363 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -436,9 +436,8 @@ static void
 eal_check_mem_on_local_socket(void)
 {
 	int socket_id;
-	const struct rte_config *config = rte_eal_get_configuration();
 
-	socket_id = rte_lcore_to_socket_id(config->main_lcore);
+	socket_id = rte_lcore_to_socket_id(rte_get_main_lcore());
 
 	if (rte_memseg_list_walk(check_socket, &socket_id) == 0)
 		EAL_LOG(WARNING, "WARNING: Main core has no memory on local socket!");
@@ -563,7 +562,6 @@ rte_eal_init(int argc, char **argv)
 	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
 	char thread_name[RTE_THREAD_NAME_SIZE];
 	bool phys_addrs;
-	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
@@ -838,17 +836,17 @@ rte_eal_init(int argc, char **argv)
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
index a7d1575a60..3cd100ce56 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1771,7 +1771,6 @@ memseg_primary_init_32(void)
 		int hp_sizes = (int) platform_info->num_hugepage_sizes;
 		uint64_t max_socket_mem, cur_socket_mem;
 		unsigned int main_lcore_socket;
-		struct rte_config *cfg = rte_eal_get_configuration();
 		bool skip;
 		int ret;
 
@@ -1794,7 +1793,7 @@ memseg_primary_init_32(void)
 		/* ...or if we didn't specifically request memory on *any*
 		 * socket, and this is not main lcore
 		 */
-		main_lcore_socket = rte_lcore_to_socket_id(cfg->main_lcore);
+		main_lcore_socket = rte_lcore_to_socket_id(rte_get_main_lcore());
 		skip |= active_sockets == 0 && socket_id != main_lcore_socket;
 
 		if (skip) {
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 2f8f6200ba..ddbf39dbc4 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -159,7 +159,6 @@ int
 rte_eal_init(int argc, char **argv)
 {
 	int i, fctret, bscan;
-	const struct rte_config *config = rte_eal_get_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool has_phys_addr;
@@ -351,17 +350,17 @@ rte_eal_init(int argc, char **argv)
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
2.55.0

