Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4E606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bK51s2Jz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A50240A77;
	Thu, 26 Nov 2026 19:14:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 0C60540684
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716870; x=1827252870;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Cg6o5xm1xuBHCILlB01XId6a2W+1QyaJyxGtQBP764=;
 b=bK51s2JzY23eSXz0TKDGs8SzUERNIidmTUkMcbrFv0eUzc/jJN22OpjS
 6NSzran6gm8UTfi1wFN3FEipOSEARFXZezQSy60geUC7s+Mj7GdLhM1FU
 JgZ7ah4NSBXoteSjTVd3MgHOCE9rtEkLkZpXcbcia++75Rf8RWHJinyNt
 FXXMmYCld4ISl63u3jZGciU2E6dX7smwAPzo+uuAE+HvX38Qt5L6wRRsw
 tXo9Pcs0KUXtIItU6FgCs8kFYIHY7shmunTL8Riejih4KzdDXic3Orzo1
 FplLN/8OhUlh6YC0OvJIMAaixHu6bafqnkMczyZ6uLYrTCurnvMTL++2K g==;
X-CSE-ConnectionGUID: uDUoLnzlS3C32Sns04cDQw==
X-CSE-MsgGUID: 042GmWtmQ0CpIm35O0RavQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633553"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633553"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:29 -0800
X-CSE-ConnectionGUID: F6JfdCJeTaaLNRiD9PjbcA==
X-CSE-MsgGUID: AjG0cPGoRWyqkpmOTvEHtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732886"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:28 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 11/39] eal: move runtime state to appropriate structure
Date: Thu, 26 Nov 2026 18:13:44 +0000
Message-ID: <20261126181414.124094-12-bruce.richardson@intel.com>
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

Remove the last of the fields from the internal config to the runtime
state structure, allowing us to remove the general internal_config
struct and its reference function.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  | 10 ----------
 lib/eal/common/eal_common_mcfg.c    |  5 ++---
 lib/eal/common/eal_common_memzone.c |  4 +++-
 lib/eal/common/eal_common_options.c | 18 +++++++++---------
 lib/eal/common/eal_common_proc.c    |  6 +++---
 lib/eal/common/eal_common_thread.c  |  8 ++++----
 lib/eal/common/eal_internal_cfg.h   |  8 +-------
 lib/eal/common/eal_options.h        |  2 +-
 lib/eal/common/eal_private.h        |  9 ---------
 lib/eal/freebsd/eal.c               |  7 +++----
 lib/eal/linux/eal.c                 |  7 +++----
 11 files changed, 29 insertions(+), 55 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 50cba4fa1a..f1a5e84aa9 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -37,9 +37,6 @@ static struct eal_platform_info eal_platform_info;
 /* internal runtime configuration */
 static struct eal_runtime_state eal_runtime_state;
 
-/* internal configuration */
-static struct internal_config internal_config;
-
 RTE_EXPORT_SYMBOL(rte_eal_get_runtime_dir)
 const char *
 rte_eal_get_runtime_dir(void)
@@ -66,13 +63,6 @@ rte_eal_get_configuration(void)
 	return &rte_config;
 }
 
-/* Return a pointer to the internal configuration structure */
-struct internal_config *
-eal_get_internal_configuration(void)
-{
-	return &internal_config;
-}
-
 /* Return a pointer to the user configuration structure */
 struct eal_user_cfg *
 eal_get_user_configuration(void)
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index e060285f51..86dbb0a1fe 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -16,14 +16,13 @@ eal_mcfg_complete(void)
 {
 	struct rte_config *cfg = rte_eal_get_configuration();
 	struct rte_mem_config *mcfg = cfg->mem_config;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* ALL shared mem_config related INIT DONE */
 	if (cfg->process_type == RTE_PROC_PRIMARY)
 		mcfg->magic = RTE_MAGIC;
 
-	internal_conf->init_complete = 1;
+	runtime_state->init_complete = 1;
 }
 
 void
diff --git a/lib/eal/common/eal_common_memzone.c b/lib/eal/common/eal_common_memzone.c
index db43af13a8..1207d524c9 100644
--- a/lib/eal/common/eal_common_memzone.c
+++ b/lib/eal/common/eal_common_memzone.c
@@ -20,6 +20,7 @@
 
 #include "malloc_heap.h"
 #include "malloc_elem.h"
+#include "eal_internal_cfg.h"
 #include "eal_private.h"
 #include "eal_memcfg.h"
 
@@ -30,9 +31,10 @@ RTE_EXPORT_SYMBOL(rte_memzone_max_set)
 int
 rte_memzone_max_set(size_t max)
 {
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct rte_mem_config *mcfg;
 
-	if (eal_get_internal_configuration()->init_complete > 0) {
+	if (runtime_state->init_complete > 0) {
 		EAL_LOG(ERR, "Max memzone cannot be set after EAL init");
 		return -1;
 	}
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index bbdc22d1d6..5d11f90a05 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -507,7 +507,7 @@ eal_get_hugefile_prefix(void)
 }
 
 void
-eal_reset_internal_config(struct internal_config *internal_cfg)
+eal_reset_internal_config(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
@@ -563,8 +563,8 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	user_cfg->no_telemetry = false;
 	user_cfg->iova_mode = RTE_IOVA_DC;
 	user_cfg->user_mbuf_pool_ops_name = NULL;
-	CPU_ZERO(&internal_cfg->ctrl_cpuset);
-	internal_cfg->init_complete = 0;
+	CPU_ZERO(&runtime_state->ctrl_cpuset);
+	runtime_state->init_complete = 0;
 	user_cfg->max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH;
 	user_cfg->max_simd_bitwidth.forced = 0;
 }
@@ -2075,7 +2075,6 @@ eal_parse_huge_worker_stack(const char *arg)
 int
 eal_parse_args(void)
 {
-	struct internal_config *int_cfg = eal_get_internal_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct rte_config *rte_cfg = rte_eal_get_configuration();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
@@ -2448,7 +2447,7 @@ eal_parse_args(void)
 	}
 #endif
 
-	if (eal_adjust_config(int_cfg) != 0) {
+	if (eal_adjust_config() != 0) {
 		EAL_LOG(ERR, "Invalid configuration");
 		return -1;
 	}
@@ -2457,9 +2456,10 @@ eal_parse_args(void)
 }
 
 static void
-compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
+compute_ctrl_threads_cpuset(void)
 {
-	rte_cpuset_t *cpuset = &internal_cfg->ctrl_cpuset;
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	rte_cpuset_t *cpuset = &runtime_state->ctrl_cpuset;
 	rte_cpuset_t default_set;
 	unsigned int lcore_id;
 
@@ -2500,7 +2500,7 @@ eal_cleanup_config(const struct eal_user_cfg *user_cfg)
 }
 
 int
-eal_adjust_config(struct internal_config *internal_cfg)
+eal_adjust_config(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int i;
@@ -2508,7 +2508,7 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	if (user_cfg->process_type == RTE_PROC_AUTO)
 		user_cfg->process_type = eal_proc_type_detect();
 
-	compute_ctrl_threads_cpuset(internal_cfg);
+	compute_ctrl_threads_cpuset();
 
 	/* if no memory amounts were requested, this will result in 0 and
 	 * will be overridden later, right after eal_hugepage_info_init() */
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index b70e9189a4..1e9a0c3115 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -361,8 +361,8 @@ process_msg(struct mp_msg_internal *m, struct sockaddr_un *s)
 	struct action_entry *entry;
 	struct rte_mp_msg *msg = &m->msg;
 	rte_mp_t action = NULL;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_runtime_state *runtime_state =
+		eal_get_runtime_state();
 
 	EAL_LOG(DEBUG, "msg: %s", msg->name);
 
@@ -399,7 +399,7 @@ process_msg(struct mp_msg_internal *m, struct sockaddr_un *s)
 	pthread_mutex_unlock(&mp_mutex_action);
 
 	if (!action) {
-		if (m->type == MP_REQ && !internal_conf->init_complete) {
+		if (m->type == MP_REQ && !runtime_state->init_complete) {
 			/* if this is a request, and init is not yet complete,
 			 * and callback wasn't registered, we should tell the
 			 * requester to ignore our existence because we're not
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index dcd81f9e32..c2e7315bf4 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -234,9 +234,8 @@ struct control_thread_params {
 
 static int control_thread_init(void *arg)
 {
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	rte_cpuset_t *cpuset = &internal_conf->ctrl_cpuset;
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	rte_cpuset_t *cpuset = &runtime_state->ctrl_cpuset;
 	struct control_thread_params *params = arg;
 
 	__rte_thread_init(rte_lcore_id(), cpuset);
@@ -354,11 +353,12 @@ RTE_EXPORT_SYMBOL(rte_thread_register)
 int
 rte_thread_register(void)
 {
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int lcore_id;
 	rte_cpuset_t cpuset;
 
 	/* EAL init flushes all lcores, we can't register before. */
-	if (eal_get_internal_configuration()->init_complete != 1) {
+	if (runtime_state->init_complete != 1) {
 		EAL_LOG(DEBUG, "Called %s before EAL init.", __func__);
 		rte_errno = EINVAL;
 		return -1;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 764aeff954..aa140e074f 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -116,12 +116,6 @@ struct eal_platform_info {
 struct eal_runtime_state {
 	uint64_t hugepage_mem_sz_limits[MAX_HUGEPAGE_SIZES];
 	/**< default max memory per hugepage size */
-};
-
-/**
- * internal configuration
- */
-struct internal_config {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
@@ -130,6 +124,6 @@ struct internal_config {
 struct eal_user_cfg *eal_get_user_configuration(void);
 struct eal_platform_info *eal_get_platform_info(void);
 struct eal_runtime_state *eal_get_runtime_state(void);
-void eal_reset_internal_config(struct internal_config *internal_cfg);
+void eal_reset_internal_config(void);
 
 #endif /* EAL_INTERNAL_CFG_H */
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 58a047a532..58fb3085e5 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -14,7 +14,7 @@ int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
 int eal_apply_hugepage_mem_sz_limits(void);
-int eal_adjust_config(struct internal_config *internal_cfg);
+int eal_adjust_config(void);
 int eal_cleanup_config(const struct eal_user_cfg *user_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 60441ac0f2..7e705c62c8 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -712,15 +712,6 @@ eal_mem_set_dump(void *virt, size_t size, bool dump);
 int
 eal_set_runtime_dir(const char *run_dir);
 
-/**
- * Get the internal configuration structure.
- *
- * @return
- *   A pointer to the internal configuration structure.
- */
-struct internal_config *
-eal_get_internal_configuration(void);
-
 /**
  * Get the current value of the rte_application_usage pointer
  *
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 1b633946c7..95f94239b9 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -406,9 +406,8 @@ rte_eal_init(int argc, char **argv)
 	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
 	char thread_name[RTE_THREAD_NAME_SIZE];
 	const struct rte_config *config = rte_eal_get_configuration();
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 
@@ -453,7 +452,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	eal_reset_internal_config(internal_conf);
+	eal_reset_internal_config();
 
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
@@ -750,7 +749,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !user_cfg->no_telemetry) {
 		if (rte_telemetry_init(rte_eal_get_runtime_dir(),
 				rte_version(),
-				&internal_conf->ctrl_cpuset) != 0)
+				&runtime_state->ctrl_cpuset) != 0)
 			goto err_out;
 	}
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index d107bd399b..bfade6d57b 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -566,9 +566,8 @@ rte_eal_init(int argc, char **argv)
 	char thread_name[RTE_THREAD_NAME_SIZE];
 	bool phys_addrs;
 	const struct rte_config *config = rte_eal_get_configuration();
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* first check if we have been run before */
 	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
@@ -611,7 +610,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	eal_reset_internal_config(internal_conf);
+	eal_reset_internal_config();
 
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
@@ -933,7 +932,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !user_cfg->no_telemetry) {
 		if (rte_telemetry_init(rte_eal_get_runtime_dir(),
 				rte_version(),
-				&internal_conf->ctrl_cpuset) != 0)
+				&runtime_state->ctrl_cpuset) != 0)
 			goto err_out;
 	}
 
-- 
2.55.0

