Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0305C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:34:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E570F40A75;
	Tue, 18 Aug 2026 15:33:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3AFAB40A67
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060033; x=1818596033;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YjXGu6cssIkf4rNgjjHLX5bEUf/nRk5hwNTbTiSO9js=;
 b=aYB1JUmqMC8gvZ805YraCIUV5ZZ80SN5/x3esxkECLultzdG9wEr7zc0
 O9VyvwtVsWZ0X6TanFPhF+vbefS01B10cuKL6LE7AaTylaq9ifTknLe7X
 gETyIOozEJsVJAh2cYJu6m3RH1TlBjT0YBArDhWbWAdmtnYGmmIqUApVs
 A1t49N0oYzBq6kRTJrh8wFZ5tZ2sJHK4elL1bgmkOq0/gQFiUvVp28jT6
 /lTRaAchT1LfAGvjZwaxgU38k2J9SvK2VPAVneXVyLwwTHsr4fb3dcHCA
 RRNCmY7nkD9eyU7gSIyN1crVwVPbLqCj2O4+lLls+k7ohdtvPWDrnDrvy g==;
X-CSE-ConnectionGUID: OEeL2dpzQrS3aYxyAy2TGA==
X-CSE-MsgGUID: SWslmnGXRHG3ZO1ug9tpgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757619"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757619"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:51 -0700
X-CSE-ConnectionGUID: cjdU6JcHQgyrnjAs6/GLwA==
X-CSE-MsgGUID: 8OZAEc9RQDa3RhDTIDke9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736580"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 08/39] eal: move hugepage limit fields to new config structs
Date: Tue, 18 Aug 2026 14:33:01 +0100
Message-ID: <20260818133334.2620165-9-bruce.richardson@intel.com>
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

Move the pagesz-mem fields to the user config structure as these are
specified via commandline input. The derived memory limit for hugepages
is moved to the runtime configuration, since it's not a direct user
input parameter.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_dynmem.c  |  3 ++-
 lib/eal/common/eal_common_options.c | 35 ++++++++++++++++-------------
 lib/eal/common/eal_internal_cfg.h   | 17 +++++++-------
 lib/eal/linux/eal_memory.c          |  3 ++-
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 752cd539a1..e48466c272 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -37,6 +37,7 @@ eal_dynmem_memseg_lists_init(void)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* no-huge does not need this at all */
 	if (user_cfg->no_hugetlbfs)
@@ -109,7 +110,7 @@ eal_dynmem_memseg_lists_init(void)
 
 		pagesz = type->page_sz;
 		max_mem_per_type =
-			internal_conf->hugepage_mem_sz_limits[type->hpi_idx];
+			runtime_state->hugepage_mem_sz_limits[type->hpi_idx];
 
 		/*
 		 * we need to create a segment list for this type. we must take
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 3d1842688c..b6a5b3ea8b 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -510,6 +510,7 @@ void
 eal_reset_internal_config(struct internal_config *internal_cfg)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int i;
 
 	user_cfg->memory = 0;
@@ -521,6 +522,12 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	user_cfg->force_numa_limits = false;
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
 		user_cfg->numa_limit[i] = 0;
+	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
+		runtime_state->hugepage_mem_sz_limits[i] = 0;
+		user_cfg->pagesz_mem_overrides[i].pagesz = 0;
+		user_cfg->pagesz_mem_overrides[i].limit = 0;
+	}
+	user_cfg->num_pagesz_mem_overrides = 0;
 	user_cfg->process_type = RTE_PROC_PRIMARY;
 	user_cfg->no_hugetlbfs = false;
 	user_cfg->no_pci = false;
@@ -533,11 +540,7 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 		memset(&internal_cfg->hugepage_info[i], 0,
 				sizeof(internal_cfg->hugepage_info[0]));
 		internal_cfg->hugepage_info[i].lock_descriptor = -1;
-		internal_cfg->hugepage_mem_sz_limits[i] = 0;
-		internal_cfg->pagesz_mem_overrides[i].pagesz = 0;
-		internal_cfg->pagesz_mem_overrides[i].limit = 0;
 	}
-	internal_cfg->num_pagesz_mem_overrides = 0;
 	internal_cfg->base_virtaddr = 0;
 
 	/* if set to NONE, interrupt mode is determined automatically */
@@ -1904,7 +1907,7 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
 }
 
 static int
-eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
+eal_parse_pagesz_mem(char *strval, struct eal_user_cfg *user_cfg)
 {
 	char strval_cpy[1024];
 	char *fields[3];
@@ -1965,8 +1968,8 @@ eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
 		return -1;
 	}
 
-	for (i = 0; i < internal_cfg->num_pagesz_mem_overrides; i++) {
-		pmo = &internal_cfg->pagesz_mem_overrides[i];
+	for (i = 0; i < user_cfg->num_pagesz_mem_overrides; i++) {
+		pmo = &user_cfg->pagesz_mem_overrides[i];
 		if (pmo->pagesz != pagesz)
 			continue;
 
@@ -1978,17 +1981,17 @@ eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
 	}
 
 	/* do we have space? */
-	if (internal_cfg->num_pagesz_mem_overrides >= MAX_HUGEPAGE_SIZES) {
+	if (user_cfg->num_pagesz_mem_overrides >= MAX_HUGEPAGE_SIZES) {
 		EAL_LOG(ERR,
 			"--pagesz-mem: too many page size entries (max %d)",
 			MAX_HUGEPAGE_SIZES);
 		return -1;
 	}
 
-	pmo = &internal_cfg->pagesz_mem_overrides[internal_cfg->num_pagesz_mem_overrides];
+	pmo = &user_cfg->pagesz_mem_overrides[user_cfg->num_pagesz_mem_overrides];
 	pmo->pagesz = pagesz;
 	pmo->limit = mem_limit;
-	internal_cfg->num_pagesz_mem_overrides++;
+	user_cfg->num_pagesz_mem_overrides++;
 
 	return 0;
 }
@@ -2325,7 +2328,7 @@ eal_parse_args(void)
 		user_cfg->force_numa_limits = true;
 	}
 	TAILQ_FOREACH(arg, &args.pagesz_mem, next) {
-		if (eal_parse_pagesz_mem(arg->arg, int_cfg) < 0) {
+		if (eal_parse_pagesz_mem(arg->arg, user_cfg) < 0) {
 			EAL_LOG(ERR, "invalid pagesz-mem parameter: '%s'", arg->arg);
 			return -1;
 		}
@@ -2522,6 +2525,8 @@ eal_adjust_config(struct internal_config *internal_cfg)
 int
 eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
 {
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int i;
 
 	for (i = 0; i < internal_cfg->num_hugepage_sizes; i++) {
@@ -2534,12 +2539,12 @@ eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
 				(uint64_t)RTE_MAX_MEMSEG_PER_TYPE * pagesz);
 
 		/* override with user value for matching page size */
-		for (j = 0; j < (unsigned int)internal_cfg->num_pagesz_mem_overrides; j++) {
-			if (internal_cfg->pagesz_mem_overrides[j].pagesz == pagesz)
-				limit = internal_cfg->pagesz_mem_overrides[j].limit;
+		for (j = 0; j < user_cfg->num_pagesz_mem_overrides; j++) {
+			if (user_cfg->pagesz_mem_overrides[j].pagesz == pagesz)
+				limit = user_cfg->pagesz_mem_overrides[j].limit;
 		}
 
-		internal_cfg->hugepage_mem_sz_limits[i] = limit;
+		runtime_state->hugepage_mem_sz_limits[i] = limit;
 	}
 
 	return 0;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 4e81a84085..cef5164e99 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -74,6 +74,12 @@ struct eal_user_cfg {
 	char *hugepage_dir;      /**< specific hugetlbfs directory to use */
 	uint64_t numa_mem[RTE_MAX_NUMA_NODES];    /**< amount of memory per NUMA node */
 	uint64_t numa_limit[RTE_MAX_NUMA_NODES];  /**< limit amount of memory per NUMA node */
+	/** storage for user-specified pagesz-mem overrides */
+	struct pagesz_mem_override {
+		uint64_t pagesz;   /**< page size in bytes */
+		uint64_t limit;    /**< memory limit in bytes */
+	} pagesz_mem_overrides[MAX_HUGEPAGE_SIZES];
+	unsigned int num_pagesz_mem_overrides;  /**< number of stored overrides */
 };
 
 /**
@@ -90,7 +96,8 @@ struct eal_platform_info {
  * as appropriate.
  */
 struct eal_runtime_state {
-	uint8_t reserved;
+	uint64_t hugepage_mem_sz_limits[MAX_HUGEPAGE_SIZES];
+	/**< default max memory per hugepage size */
 };
 
 /**
@@ -116,14 +123,6 @@ struct internal_config {
 			/**< user defined mbuf pool ops name */
 	unsigned num_hugepage_sizes;      /**< how many sizes on this system */
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
-	uint64_t hugepage_mem_sz_limits[MAX_HUGEPAGE_SIZES];
-	/**< default max memory per hugepage size */
-	/** storage for user-specified pagesz-mem overrides */
-	struct pagesz_mem_override {
-		uint64_t pagesz;   /**< page size in bytes */
-		uint64_t limit;    /**< memory limit in bytes */
-	} pagesz_mem_overrides[MAX_HUGEPAGE_SIZES];
-	unsigned int num_pagesz_mem_overrides;  /**< number of stored overrides */
 	enum rte_iova_mode iova_mode ;    /**< Set IOVA mode on this system  */
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 2184b022fc..a45be4a56a 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1704,6 +1704,7 @@ memseg_primary_init_32(void)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* no-huge does not need this at all */
 	if (user_cfg->no_hugetlbfs)
@@ -1824,7 +1825,7 @@ memseg_primary_init_32(void)
 				continue;
 
 			max_pagesz_mem = max_socket_mem - cur_socket_mem;
-			pagesz_mem_limit = internal_conf->hugepage_mem_sz_limits[hpi_idx];
+			pagesz_mem_limit = runtime_state->hugepage_mem_sz_limits[hpi_idx];
 			max_pagesz_mem = RTE_MIN(max_pagesz_mem, pagesz_mem_limit);
 
 			/* make it multiple of page size */
-- 
2.53.0

