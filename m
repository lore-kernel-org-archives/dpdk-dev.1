Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3A0FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5065340ED6;
	Wed, 29 Apr 2026 18:59:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 89A3940E78;
 Wed, 29 Apr 2026 18:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481964; x=1809017964;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v4xUEMDxwJHzKSATjeBE7x3MbvbDHP7i2pSeR+Ho/rY=;
 b=dwgDIAldYG/TAE6rR/pgxPuKlnEqJFoXhARspAdAk84MZjCB31CkakGr
 Na7dr8yAjJ75hwAZsUyp31GbV/PYwCrdE2otDTZmE3s6zGhUWA68Hj8qf
 bUUpeShWBtVvXpFEEAuSJSS9TvmoKxDnKGlGKdogNixdNkaCz1k2kqG3K
 COuOTXqWNAJUfE6QZL/71Xs1mhObXJrPyQlkCj/G3Qgs4zqTR3KbUmj9u
 e/47TuCCD2RgjU8ozGkW5RVMwakdyRFbUdYy3bXelLZggE/wnMsFq/6le
 7XYCL2kPF3mca9hV7g46v8iV/JrTCjec63wXyB8KEwI9CXzzYR/kCK/lo g==;
X-CSE-ConnectionGUID: HUUDZmNRRX2vUdnmPPjTOQ==
X-CSE-MsgGUID: N+FviSMwR/OdXQqRZ7bv0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725335"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725335"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:24 -0700
X-CSE-ConnectionGUID: C+mrqTUIQ0aNtxSoBDjixA==
X-CSE-MsgGUID: Z8lhp/T+R/iaZ6wAjYKOhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697007"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 22/44] eal: separate runtime state update from arg parsing
Date: Wed, 29 Apr 2026 17:58:14 +0100
Message-ID: <20260429165845.2136843-23-bruce.richardson@intel.com>
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

The eal_parse_args function was performing several updates to the
runtime state that do not logically belong in a parse_args function.
Move these to the "eal_adjust_config()" function, which is now renamed
to the more accurate "eal_apply_runtime_state()". Ensure too, that all
queries for the multi process mode use the runtime state rather than the
original user provided value, which needs resolution if it's AUTO.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 68 +++++++++++++----------------
 lib/eal/common/eal_options.h        |  2 +-
 lib/eal/freebsd/eal.c               |  5 +--
 lib/eal/linux/eal.c                 |  5 +--
 lib/eal/linux/eal_vfio.c            |  9 ++--
 5 files changed, 37 insertions(+), 52 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 9b3ba64c4c..dc6f4643c4 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1960,7 +1960,6 @@ int
 eal_parse_args(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
 	uint16_t lcore_id_base = 0;
@@ -2088,17 +2087,6 @@ eal_parse_args(void)
 	if (args.main_lcore != NULL && eal_parse_main_lcore(args.main_lcore) < 0)
 		return -1;
 
-	if (user_cfg->main_lcore != -1) {
-		runtime_state->main_lcore = user_cfg->main_lcore;
-	} else {
-		/* default main lcore is the first one */
-		runtime_state->main_lcore = rte_get_next_lcore(-1, 0, 0);
-		if (runtime_state->main_lcore >= RTE_MAX_LCORE) {
-			EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
-			return -1;
-		}
-	}
-
 	/* memory options */
 	if (args.memory_size != NULL) {
 		user_cfg->memory = atoi(args.memory_size);
@@ -2299,23 +2287,11 @@ eal_parse_args(void)
 		}
 	}
 
-#ifndef RTE_EXEC_ENV_WINDOWS
-	/* create runtime data directory. In no_shconf mode, skip any errors */
-	if (eal_create_runtime_dir() < 0) {
-		if (!user_cfg->no_shconf) {
-			EAL_LOG(ERR, "Cannot create runtime directory");
-			return -1;
-		}
-		EAL_LOG(WARNING, "No DPDK runtime directory created");
-	}
-#endif
-
-	if (eal_adjust_config() != 0) {
-		EAL_LOG(ERR, "Invalid configuration");
-		return -1;
-	}
+	/* sum per-NUMA memory requests into user_cfg->memory */
+	for (int i = 0; i < RTE_MAX_NUMA_NODES; i++)
+		user_cfg->memory += user_cfg->numa_mem[i];
 
-	return 0;
+	return eal_apply_runtime_state();
 }
 
 static void
@@ -2363,20 +2339,38 @@ eal_cleanup_config(const struct eal_user_cfg *user_cfg)
 }
 
 int
-eal_adjust_config(void)
+eal_apply_runtime_state(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	int i;
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
-	if (user_cfg->process_type == RTE_PROC_AUTO)
-		user_cfg->process_type = eal_proc_type_detect();
+	/* set the main lcore */
+	if (user_cfg->main_lcore != -1) {
+		runtime_state->main_lcore = user_cfg->main_lcore;
+	} else {
+		/* default main lcore is the first one */
+		runtime_state->main_lcore = rte_get_next_lcore(-1, 0, 0);
+		if (runtime_state->main_lcore >= RTE_MAX_LCORE) {
+			EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
+			return -1;
+		}
+	}
 
-	compute_ctrl_threads_cpuset();
+#ifndef RTE_EXEC_ENV_WINDOWS
+	/* create runtime data directory. In no_shconf mode, skip any errors */
+	if (eal_create_runtime_dir() < 0) {
+		if (!user_cfg->no_shconf) {
+			EAL_LOG(ERR, "Cannot create runtime directory");
+			return -1;
+		}
+		EAL_LOG(WARNING, "No DPDK runtime directory created");
+	}
+#endif
 
-	/* if no memory amounts were requested, this will result in 0 and
-	 * will be overridden later, right after eal_hugepage_info_init() */
-	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		user_cfg->memory += user_cfg->numa_mem[i];
+	runtime_state->process_type = (user_cfg->process_type == RTE_PROC_AUTO) ?
+			eal_proc_type_detect() : user_cfg->process_type;
+
+	compute_ctrl_threads_cpuset();
 
 	return 0;
 }
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index a70c5b0c05..d5ad7a4720 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -13,7 +13,7 @@ struct eal_user_cfg;
 int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
-int eal_adjust_config(void);
+int eal_apply_runtime_state(void);
 int eal_cleanup_config(const struct eal_user_cfg *user_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 0fafb2c295..16748f965e 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -285,9 +285,6 @@ static int
 eal_mem_config_init(void)
 {
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-
-	runtime_state->process_type = user_cfg->process_type;
 
 	switch (runtime_state->process_type) {
 	case RTE_PROC_PRIMARY:
@@ -565,7 +562,7 @@ rte_eal_init(int argc, char **argv)
 
 	if (!user_cfg->no_hugetlbfs) {
 		/* shared mem config not yet attached */
-		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
+		ret = rte_eal_process_type() == RTE_PROC_PRIMARY ?
 			eal_hugepage_info_init() :
 			eal_hugepage_info_read();
 		if (ret < 0) {
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 8d3559aa37..8d67d6744f 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -369,9 +369,6 @@ static int
 eal_mem_config_init(void)
 {
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-
-	runtime_state->process_type = user_cfg->process_type;
 
 	switch (runtime_state->process_type) {
 	case RTE_PROC_PRIMARY:
@@ -729,7 +726,7 @@ rte_eal_init(int argc, char **argv)
 
 	if (!user_cfg->no_hugetlbfs) {
 		/* shared mem config not yet attached */
-		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
+		ret = rte_eal_process_type() == RTE_PROC_PRIMARY ?
 				eal_hugepage_info_init() :
 				eal_hugepage_info_read();
 		if (ret < 0) {
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 678ac57e87..019966593e 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -482,8 +482,7 @@ vfio_get_group_fd(struct vfio_config *vfio_cfg,
 	 * knowledge of them. Requesting a group fd from the primary for a
 	 * container it doesn't know about would be incorrect.
 	 */
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	bool mp_request = (user_cfg->process_type == RTE_PROC_SECONDARY) &&
+	bool mp_request = (rte_eal_process_type() == RTE_PROC_SECONDARY) &&
 			(vfio_cfg == default_vfio_cfg);
 
 	vfio_group_fd = vfio_open_group_fd(iommu_group_num, mp_request);
@@ -770,7 +769,6 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	int iommu_group_num;
 	rte_uuid_t vf_token;
 	int i, ret;
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* get group number */
 	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
@@ -852,7 +850,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		 * Note this can happen several times with the hotplug
 		 * functionality.
 		 */
-		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
 				vfio_cfg->vfio_active_groups == 1 &&
 				vfio_group_device_count(vfio_group_fd) == 0) {
 			const struct vfio_iommu_type *t;
@@ -1105,7 +1103,6 @@ rte_vfio_enable(const char *modname)
 	unsigned int i, j;
 	int vfio_available;
 	DIR *dir;
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	rte_spinlock_recursive_t lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER;
 
@@ -1149,7 +1146,7 @@ rte_vfio_enable(const char *modname)
 	}
 	closedir(dir);
 
-	if (user_cfg->process_type == RTE_PROC_PRIMARY) {
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		if (vfio_mp_sync_setup() == -1) {
 			default_vfio_cfg->vfio_container_fd = -1;
 		} else {
-- 
2.51.0

