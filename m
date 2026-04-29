Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA60FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43BC041141;
	Wed, 29 Apr 2026 18:59:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 95D4B40F1A;
 Wed, 29 Apr 2026 18:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481974; x=1809017974;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NDbpo81k399DQxam8G0I4JILOjq+cMO2T/nNVubxPEA=;
 b=QbVzsGzyc1Ra4SqSXFf6PHqyfx4tS1SIkSjagvqhNsyuvZgTOXdkBJhq
 Xpx6MaUGa9jqPUgqSdofhXLbCkrOpsARxzldYKoI2Q+cJBLbUw9ALJxK/
 pAJS2sg5i1YehbSaumKmFjchtPOEBKzoZnNQk3K86oeQl/siYutEKJe+3
 ye0lhspNW7p23llp+HtcmNxba9HWArrc0tYmtWUGkzBOFoHZ3j4ulaADA
 TooKZgDN1E1GBo7hdbj146JnW1KsHF8QgF/jJd/pMmi1maHsOCD9ekTd/
 SIu9H80FEuFVlLXjC3WNwQhbOXi4YxomMZc5YKENi/9B16q9v1+hnfkXX A==;
X-CSE-ConnectionGUID: KqiBIx85QHOBSdnTyQJmjg==
X-CSE-MsgGUID: 1oJdD2wBSNCwEHNlH5idXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725352"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725352"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:34 -0700
X-CSE-ConnectionGUID: lrRnWvXuSXifaVXpl/BT9g==
X-CSE-MsgGUID: yEgzNtHQSWamPWmYsSVF+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697040"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:32 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 30/44] eal: remove internal config reset function
Date: Wed, 29 Apr 2026 17:58:22 +0100
Message-ID: <20260429165845.2136843-31-bruce.richardson@intel.com>
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

Rather than having a single function which attempts to reset multiple
internal config structures, just init each structure in the function
which configures it. Use structure assignment for initialization rather
than a series of assignment statements.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 85 ++++++-----------------------
 lib/eal/common/eal_internal_cfg.h   |  1 -
 lib/eal/freebsd/eal.c               |  2 -
 lib/eal/linux/eal.c                 |  7 +--
 4 files changed, 21 insertions(+), 74 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index bd08d29e1d..292ac7378e 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -466,72 +466,6 @@ eal_get_hugefile_prefix(void)
 	return HUGEFILE_PREFIX_DEFAULT;
 }
 
-void
-eal_reset_internal_config(void)
-{
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_platform_info *platform_info = eal_get_platform_info();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
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
@@ -1860,6 +1794,24 @@ int
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
@@ -1986,7 +1938,6 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
-	user_cfg->main_lcore = -1;
 	if (args.main_lcore != NULL && eal_parse_main_lcore(args.main_lcore) < 0)
 		return -1;
 
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 239fe2a7ac..979c1320e8 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -213,6 +213,5 @@ struct eal_runtime_state {
 struct eal_user_cfg *eal_get_user_configuration(void);
 struct eal_platform_info *eal_get_platform_info(void);
 struct eal_runtime_state *eal_get_runtime_state(void);
-void eal_reset_internal_config(void);
 
 #endif /* EAL_INTERNAL_CFG_H */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 120425d425..13bbd8b868 100644
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
index 3f2ad98425..328c74ae4d 100644
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
2.51.0

