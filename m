Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E425EC4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 760BE40DCE;
	Tue, 21 Jul 2026 11:46:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 78E7C40B8D
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627174; x=1816163174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LBaAT/ibpe3ZCcP6m0CGcOSLr6z9fjTbLY4VMvfu1ws=;
 b=FyfaziGJHtzPTsZR6zKY4sPGEVMHz2PwqjK3lea7vYsq4WotjVV2HoMJ
 dlkwjEti3DmijHyRgLjsuzLH3+aem5LWjYVORvDYWQYUn2NELnbPMZBab
 Mx1kIwKJkfwgtD0vwDYQLVMwkUtz53HUh/nZUaGfSxmk6Dj3NyUwhAdqk
 dl2lLilPwDCgCyvK59vOMBvbghbPqCr60EAuH7HvC8Ew3xA86wOO1U3pT
 T1joWW263XzAqkT5z5bhbXtCng8VsBTMH+6qI7mlsEx126wOWSkXupXWU
 Q/mt04Sa8bXjvjZFuO03Z9dKFAgF4Ny2c5Vfa7BAHjBH1+8+n1CpyZOCN w==;
X-CSE-ConnectionGUID: tA3+5RfmTCqoK3e6TKY9SA==
X-CSE-MsgGUID: IAkXi3NUQzGi0Lw7DsHbTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872465"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872465"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:13 -0700
X-CSE-ConnectionGUID: +/0ekHHZSC6SFGlJP96ZCw==
X-CSE-MsgGUID: tB2o6ud9R+WVhmE6wdoNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922306"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 11/39] eal: move runtime state to appropriate structure
Date: Tue, 21 Jul 2026 10:45:19 +0100
Message-ID: <20260721094555.2188496-12-bruce.richardson@intel.com>
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
index fddeae255e..497b0933c7 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -15,14 +15,13 @@ eal_mcfg_complete(void)
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
index 4f72f2e3d9..b803ce356d 100644
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
@@ -2076,7 +2076,6 @@ eal_parse_huge_worker_stack(const char *arg)
 int
 eal_parse_args(void)
 {
-	struct internal_config *int_cfg = eal_get_internal_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct rte_config *rte_cfg = rte_eal_get_configuration();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
@@ -2449,7 +2448,7 @@ eal_parse_args(void)
 	}
 #endif
 
-	if (eal_adjust_config(int_cfg) != 0) {
+	if (eal_adjust_config() != 0) {
 		EAL_LOG(ERR, "Invalid configuration");
 		return -1;
 	}
@@ -2458,9 +2457,10 @@ eal_parse_args(void)
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
 
@@ -2501,7 +2501,7 @@ eal_cleanup_config(const struct eal_user_cfg *user_cfg)
 }
 
 int
-eal_adjust_config(struct internal_config *internal_cfg)
+eal_adjust_config(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int i;
@@ -2509,7 +2509,7 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	if (user_cfg->process_type == RTE_PROC_AUTO)
 		user_cfg->process_type = eal_proc_type_detect();
 
-	compute_ctrl_threads_cpuset(internal_cfg);
+	compute_ctrl_threads_cpuset();
 
 	/* if no memory amounts were requested, this will result in 0 and
 	 * will be overridden later, right after eal_hugepage_info_init() */
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 01f6bd5db1..0f19899517 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -359,8 +359,8 @@ process_msg(struct mp_msg_internal *m, struct sockaddr_un *s)
 	struct action_entry *entry;
 	struct rte_mp_msg *msg = &m->msg;
 	rte_mp_t action = NULL;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_runtime_state *runtime_state =
+		eal_get_runtime_state();
 
 	EAL_LOG(DEBUG, "msg: %s", msg->name);
 
@@ -397,7 +397,7 @@ process_msg(struct mp_msg_internal *m, struct sockaddr_un *s)
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
index 7a047a3a45..e63f84fe78 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -111,12 +111,6 @@ struct eal_runtime_state {
 	uint8_t reserved;
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
@@ -125,6 +119,6 @@ struct internal_config {
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
index 6340bab8be..f31254dac7 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -726,15 +726,6 @@ eal_mem_set_dump(void *virt, size_t size, bool dump);
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
index 4e962966aa..f6114b2f21 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -407,9 +407,8 @@ rte_eal_init(int argc, char **argv)
 	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
 	char thread_name[RTE_THREAD_NAME_SIZE];
 	const struct rte_config *config = rte_eal_get_configuration();
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 
@@ -454,7 +453,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	eal_reset_internal_config(internal_conf);
+	eal_reset_internal_config();
 
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
@@ -751,7 +750,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !user_cfg->no_telemetry) {
 		if (rte_telemetry_init(rte_eal_get_runtime_dir(),
 				rte_version(),
-				&internal_conf->ctrl_cpuset) != 0)
+				&runtime_state->ctrl_cpuset) != 0)
 			goto err_out;
 	}
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 62efae6b7b..b98d194f9b 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -569,9 +569,8 @@ rte_eal_init(int argc, char **argv)
 	char thread_name[RTE_THREAD_NAME_SIZE];
 	bool phys_addrs;
 	const struct rte_config *config = rte_eal_get_configuration();
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* first check if we have been run before */
 	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
@@ -614,7 +613,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	eal_reset_internal_config(internal_conf);
+	eal_reset_internal_config();
 
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
@@ -924,7 +923,7 @@ rte_eal_init(int argc, char **argv)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !user_cfg->no_telemetry) {
 		if (rte_telemetry_init(rte_eal_get_runtime_dir(),
 				rte_version(),
-				&internal_conf->ctrl_cpuset) != 0)
+				&runtime_state->ctrl_cpuset) != 0)
 			goto err_out;
 	}
 
-- 
2.53.0

