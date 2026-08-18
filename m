Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF64C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65AFB40E50;
	Tue, 18 Aug 2026 15:34:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2C0B440E21
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060049; x=1818596049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N2tyc1nUZRuj0RGvDGfLQ8pRs6Ghq5j3XjwVHNJPvcA=;
 b=R4KA00bB9k7a0i3nqHO7sDX18YKneDEmpCVOy6nNqPe+4Yf9Csi/p0Bu
 rX4vndH+EVppNNgkMsHf68GOxk1PRHYyTS/v53wPGu127gHOF5VtZgoBE
 Vbp+vsGQX9lsbZVo8IKs1b30xclrPZuUARCbgDy+6TGcpOO1K9lKtGU4A
 DsgPO76SYhxTm4uOZiqn5Ye/NQGQYBYSXWO8qvk97yoGATpbBc2A4lyTk
 sbcEKjZ90nMCmSTQ67pYJQ1Mt2gLN0rqkB0zBx8aqUVhvllx0sVUyJZwJ
 JDqVhRTsBeIWwQNDRWPwKzdBMbBKpX8xrvOdf/OAmzdV4ZNy7uZI98QA+ g==;
X-CSE-ConnectionGUID: hyK/QhYuSW21GVLAJgdG9A==
X-CSE-MsgGUID: IgZQWd7ISKeY5+klpNC75Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757661"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757661"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:34:08 -0700
X-CSE-ConnectionGUID: HJE/D4/ZSgaybf4pUvmWkg==
X-CSE-MsgGUID: cKfiLbkpTtG/AKGTjQ/P6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736735"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:34:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 25/39] eal: separate runtime state update from arg parsing
Date: Tue, 18 Aug 2026 14:33:18 +0100
Message-ID: <20260818133334.2620165-26-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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
 lib/eal/freebsd/eal.c               |  7 +--
 lib/eal/linux/eal.c                 |  7 +--
 lib/eal/linux/eal_vfio.c            |  9 ++--
 5 files changed, 39 insertions(+), 54 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 68909e97b0..f733512aec 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2079,7 +2079,6 @@ int
 eal_parse_args(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
 	uint16_t lcore_id_base = 0;
@@ -2207,17 +2206,6 @@ eal_parse_args(void)
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
 		char *end = NULL;
@@ -2442,23 +2430,11 @@ eal_parse_args(void)
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
@@ -2506,20 +2482,38 @@ eal_cleanup_config(const struct eal_user_cfg *user_cfg)
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
index 58fb3085e5..eee7339e90 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -14,7 +14,7 @@ int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
 int eal_apply_hugepage_mem_sz_limits(void);
-int eal_adjust_config(void);
+int eal_apply_runtime_state(void);
 int eal_cleanup_config(const struct eal_user_cfg *user_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 3b7b6540d1..cf13b33811 100644
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
@@ -573,7 +570,7 @@ rte_eal_init(int argc, char **argv)
 			rte_errno = EACCES;
 			goto err_out;
 		}
-		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
 				eal_apply_hugepage_mem_sz_limits() < 0) {
 			rte_eal_init_alert("Cannot apply hugepage memory limits.");
 			rte_errno = EINVAL;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 270393f468..8fc547172c 100644
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
@@ -737,7 +734,7 @@ rte_eal_init(int argc, char **argv)
 			rte_errno = EACCES;
 			goto err_out;
 		}
-		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
 				eal_apply_hugepage_mem_sz_limits() < 0) {
 			rte_eal_init_alert("Cannot apply hugepage memory limits.");
 			rte_errno = EINVAL;
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
2.53.0

