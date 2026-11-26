Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547A606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BbeY41ZM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56139406B6;
	Thu, 26 Nov 2026 19:14:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 95F9E4064E
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716866; x=1827252866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9/Q0ms7l3m9nottwJzrt8yrppOKVfblwrHwFlTZc+0Y=;
 b=BbeY41ZMHKYQ5JE12DOEsvI9phsMuKJ0jpkhcdBgJyUOw/NbXa7NkIAf
 hgpnKCqem6PBCKe14qYteKFrSvkrmN+qxSAMQG7C5pqqdWaM8JZ13CHc5
 aE4Up7VthOmyGNdppgP5XpQB2Z2SzN66QtfmDt29uBg40mgGYXbVrqx50
 isOZ/KCcKIhqr23LhdWGk0R1stPcUsLwAvhFCSY+mUmt/DQ9eoXJhzuGe
 qTYWMk2xrdVZgHwU2ZCoC+BLVXArjB4tNZno7KaOKRfwhfy5OC0jyfIJM
 DxldMAhToRpudBEYXWH2B8Ga6jDlQ2ETuHCfu9uI+vv5NcBGT+b742DMY Q==;
X-CSE-ConnectionGUID: bTIDepdGQIiFCzLc/GVIJg==
X-CSE-MsgGUID: rBcXwhYSRQuCmy5ytkCCeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633549"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633549"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:26 -0800
X-CSE-ConnectionGUID: k7XB4W/3TlqBshrg6aXFfg==
X-CSE-MsgGUID: otTjFn1yQqO9P3sbLjbpYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732864"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:24 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 08/39] eal: move hugepage limit fields to new config structs
Date: Thu, 26 Nov 2026 18:13:41 +0000
Message-ID: <20261126181414.124094-9-bruce.richardson@intel.com>
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
index 97f8a05b30..a3f25a79f5 100644
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
index c3cc41bac8..9a5a57110a 100644
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
@@ -1903,7 +1906,7 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
 }
 
 static int
-eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
+eal_parse_pagesz_mem(char *strval, struct eal_user_cfg *user_cfg)
 {
 	char strval_cpy[1024];
 	char *fields[3];
@@ -1964,8 +1967,8 @@ eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
 		return -1;
 	}
 
-	for (i = 0; i < internal_cfg->num_pagesz_mem_overrides; i++) {
-		pmo = &internal_cfg->pagesz_mem_overrides[i];
+	for (i = 0; i < user_cfg->num_pagesz_mem_overrides; i++) {
+		pmo = &user_cfg->pagesz_mem_overrides[i];
 		if (pmo->pagesz != pagesz)
 			continue;
 
@@ -1977,17 +1980,17 @@ eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
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
@@ -2324,7 +2327,7 @@ eal_parse_args(void)
 		user_cfg->force_numa_limits = true;
 	}
 	TAILQ_FOREACH(arg, &args.pagesz_mem, next) {
-		if (eal_parse_pagesz_mem(arg->arg, int_cfg) < 0) {
+		if (eal_parse_pagesz_mem(arg->arg, user_cfg) < 0) {
 			EAL_LOG(ERR, "invalid pagesz-mem parameter: '%s'", arg->arg);
 			return -1;
 		}
@@ -2521,6 +2524,8 @@ eal_adjust_config(struct internal_config *internal_cfg)
 int
 eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
 {
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int i;
 
 	for (i = 0; i < internal_cfg->num_hugepage_sizes; i++) {
@@ -2533,12 +2538,12 @@ eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
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
index f84867e2dc..d380cd1252 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -80,6 +80,12 @@ struct eal_user_cfg {
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
@@ -96,7 +102,8 @@ struct eal_platform_info {
  * as appropriate.
  */
 struct eal_runtime_state {
-	uint8_t reserved;
+	uint64_t hugepage_mem_sz_limits[MAX_HUGEPAGE_SIZES];
+	/**< default max memory per hugepage size */
 };
 
 /**
@@ -122,14 +129,6 @@ struct internal_config {
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
index 3da8d179e6..ff55e07fe5 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1711,6 +1711,7 @@ memseg_primary_init_32(void)
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* no-huge does not need this at all */
 	if (user_cfg->no_hugetlbfs)
@@ -1831,7 +1832,7 @@ memseg_primary_init_32(void)
 				continue;
 
 			max_pagesz_mem = max_socket_mem - cur_socket_mem;
-			pagesz_mem_limit = internal_conf->hugepage_mem_sz_limits[hpi_idx];
+			pagesz_mem_limit = runtime_state->hugepage_mem_sz_limits[hpi_idx];
 			max_pagesz_mem = RTE_MIN(max_pagesz_mem, pagesz_mem_limit);
 
 			/* make it multiple of page size */
-- 
2.55.0

