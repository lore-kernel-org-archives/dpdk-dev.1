Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBDAC4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:49:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C1A840EDC;
	Tue, 21 Jul 2026 11:46:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id EF0E040ED2
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627196; x=1816163196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ySCr27ZjLmqtZ/QJPw8PwnwPh28M4/koGsuTEqMP/v0=;
 b=OlfqQIlYyYEgM5ZkRXkDCLb7TttSCm+OveftDcWXT7ctmZnRTeCVKcjq
 s2E2XA6h31Ei1X+O3aWELl5AuK+mLa65ShGv5KIeSLM4IS6E/BKRDldHx
 ChLBPSa1+N3WEbJlZXsY1rSDyhzBz3igzisvQQ7Glqd7s3cMDiYXBYh7d
 CkBVyA9WWwHyVRFvrqrYJGbOzjPjHw5S7lKjCZum6mnK4U6g7Yva8neA3
 bvC4xk+wKC3raNZ5D/iSuKWSNshERJh8mbG4G5ZT8feWT/g76YTBzFTjT
 sIbc2j0yYms1IZMqXHl5bWv9Ekbl6eZYPfdqo5+VGrs3OEy/SabFn+W3M Q==;
X-CSE-ConnectionGUID: pPMiy/F+TD2ntX8iEA1a/Q==
X-CSE-MsgGUID: 9ZnS6+jYQsqc3Z18G3BvZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872512"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872512"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:36 -0700
X-CSE-ConnectionGUID: MFobAxWdTB+P73Xy3399uw==
X-CSE-MsgGUID: yYrU2HgkRHmm54tHTH8Ccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922436"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:34 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 33/39] eal: remove internal config reset function
Date: Tue, 21 Jul 2026 10:45:41 +0100
Message-ID: <20260721094555.2188496-34-bruce.richardson@intel.com>
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

Rather than having a single function which attempts to reset multiple
internal config structures, just init each structure in the function
which configures it. Use structure assignment for initialization rather
than a series of assignment statements.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 92 ++++++-----------------------
 lib/eal/common/eal_internal_cfg.h   |  1 -
 lib/eal/freebsd/eal.c               |  2 -
 lib/eal/linux/eal.c                 |  7 +--
 4 files changed, 22 insertions(+), 80 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index a0b2243873..653a08b375 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -482,78 +482,6 @@ eal_get_hugefile_prefix(void)
 	return HUGEFILE_PREFIX_DEFAULT;
 }
 
-void
-eal_reset_internal_config(void)
-{
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	struct eal_platform_info *platform_info = eal_get_platform_info();
-	int i;
-
-	TAILQ_INIT(&user_cfg->devopt_list);
-	TAILQ_INIT(&user_cfg->plugin_list);
-	STAILQ_INIT(&user_cfg->trace_patterns);
-	TAILQ_INIT(&runtime_state->loaded_plugins);
-	user_cfg->memory = 0;
-	user_cfg->force_nrank = 0;
-	user_cfg->force_nchannel = 0;
-	user_cfg->force_numa = false;
-	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		user_cfg->numa_mem[i] = 0;
-	user_cfg->force_numa_limits = false;
-	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		user_cfg->numa_limit[i] = 0;
-	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
-		runtime_state->hugepage_mem_sz_limits[i] = 0;
-		user_cfg->pagesz_mem_overrides[i].pagesz = 0;
-		user_cfg->pagesz_mem_overrides[i].limit = 0;
-	}
-	user_cfg->num_pagesz_mem_overrides = 0;
-	user_cfg->process_type = RTE_PROC_PRIMARY;
-	user_cfg->no_hugetlbfs = false;
-	user_cfg->no_pci = false;
-	user_cfg->hugefile_prefix = NULL;
-	user_cfg->hugepage_dir = NULL;
-	user_cfg->hugepage_file.unlink_before_mapping = false;
-	user_cfg->hugepage_file.unlink_existing = true;
-	/* zero out hugedir descriptors */
-	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
-		memset(&platform_info->hugepage_info[i], 0,
-				sizeof(platform_info->hugepage_info[0]));
-		platform_info->hugepage_info[i].lock_descriptor = -1;
-	}
-	user_cfg->base_virtaddr = 0;
-
-	/* if set to NONE, interrupt mode is determined automatically */
-	user_cfg->vfio_intr_mode = RTE_INTR_MODE_NONE;
-	memset(user_cfg->vfio_vf_token, 0,
-			sizeof(user_cfg->vfio_vf_token));
-
-	user_cfg->no_auto_probing = false;
-
-#ifdef RTE_LIBEAL_USE_HPET
-	user_cfg->no_hpet = false;
-#else
-	user_cfg->no_hpet = true;
-#endif
-	user_cfg->vmware_tsc_map = false;
-	user_cfg->no_shconf = false;
-	user_cfg->in_memory = false;
-	user_cfg->create_uio_dev = false;
-	user_cfg->no_telemetry = false;
-	user_cfg->iova_mode = RTE_IOVA_DC;
-	user_cfg->user_mbuf_pool_ops_name = NULL;
-	CPU_ZERO(&runtime_state->ctrl_cpuset);
-	runtime_state->init_complete = 0;
-	CPU_ZERO(&user_cfg->service_cpuset);
-	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		free(user_cfg->lcore_cpusets[i]);
-		user_cfg->lcore_cpusets[i] = NULL;
-	}
-	user_cfg->max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH;
-	user_cfg->max_simd_bitwidth.forced = 0;
-}
-
 static int
 eal_plugin_path_add(const char *path)
 {
@@ -1977,6 +1905,24 @@ int
 eal_parse_args(void)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+
+	/*
+	 * Initialise user_cfg to defaults. Fields not listed here are zero,
+	 * false or NULL, which is the correct default (RTE_PROC_PRIMARY,
+	 * RTE_INTR_MODE_NONE, RTE_IOVA_DC, etc. are all defined as 0).
+	 */
+	*user_cfg = (struct eal_user_cfg){
+		.devopt_list = TAILQ_HEAD_INITIALIZER(user_cfg->devopt_list),
+		.plugin_list = TAILQ_HEAD_INITIALIZER(user_cfg->plugin_list),
+		.trace_patterns = STAILQ_HEAD_INITIALIZER(user_cfg->trace_patterns),
+		.hugepage_file.unlink_existing = true,
+		.main_lcore = -1,
+#ifndef RTE_LIBEAL_USE_HPET
+		.no_hpet = true,
+#endif
+		.max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH,
+	};
+
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
 	uint16_t lcore_id_base = 0;
@@ -2103,7 +2049,6 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
-	user_cfg->main_lcore = -1;
 	if (args.main_lcore != NULL && eal_parse_main_lcore(args.main_lcore) < 0)
 		return -1;
 
@@ -2374,6 +2319,7 @@ compute_ctrl_threads_cpuset(void)
 	rte_cpuset_t default_set;
 	unsigned int lcore_id;
 
+	CPU_ZERO(cpuset);
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		if (rte_lcore_has_role(lcore_id, ROLE_OFF))
 			continue;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 3bdeeaea10..74972248b7 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -224,6 +224,5 @@ struct eal_runtime_state {
 struct eal_user_cfg *eal_get_user_configuration(void);
 struct eal_platform_info *eal_get_platform_info(void);
 struct eal_runtime_state *eal_get_runtime_state(void);
-void eal_reset_internal_config(void);
 
 #endif /* EAL_INTERNAL_CFG_H */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 51604474cc..58150e5a0f 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -444,8 +444,6 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	eal_reset_internal_config();
-
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
 		rte_errno = ENOTSUP;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index ff75f6d430..d56aa3c609 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -410,8 +410,9 @@ eal_hugedirs_unlock(void)
 	int i;
 	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++)
 	{
-		/* skip uninitialized */
-		if (platform_info->hugepage_info[i].lock_descriptor < 0)
+		/* skip uninitialized or unlocked entries */
+		if (platform_info->hugepage_info[i].hugepage_sz == 0 ||
+				platform_info->hugepage_info[i].lock_descriptor < 0)
 			continue;
 		/* unlock hugepage file */
 		flock(platform_info->hugepage_info[i].lock_descriptor, LOCK_UN);
@@ -606,8 +607,6 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	eal_reset_internal_config();
-
 	if (rte_eal_cpu_init() < 0) {
 		rte_eal_init_alert("Cannot detect lcores.");
 		rte_errno = ENOTSUP;
-- 
2.53.0

