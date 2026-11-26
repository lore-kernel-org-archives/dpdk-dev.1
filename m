Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B16C606A327
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Me0TYF2O
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A940B40695;
	Thu, 26 Nov 2026 19:14:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id D783D40611
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716866; x=1827252866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RkswNe/1XW+P3wyBB1+vMMixqztoVnnLXu2gs9Nmsn0=;
 b=Me0TYF2Ot2+27ocq/iMUOuQOQDa9D64vDHCkZqlbNUkr510O14IoAx0v
 XUKz3Qv6m8eDWdqMF68VXApnPb3gtZm64YDB/Y8NFvS4sBiteIC8tPAuy
 NmqW2iD4pUCrwAOJobS3okqiJ1D1Nx92RtpFAw99YDAzrQOHal57VtR9F
 D3eNGPwCThKQq6uO8LLLd/L6tJ8dgsOBdMCaRfeQ9slzrcw4tsstAWpkM
 tFXFMAQkMo9IIB5s1nJDHMuWmeZPIGQC9Hi+rfW/R+5z3v612Uoozby2O
 baZI84dJr42jihxkoCsZLnyjgUI0PifP9Xl8YRidi6cMpTi+ef/iywXn+ w==;
X-CSE-ConnectionGUID: STjIYypCSzKqVfGmMaPz0A==
X-CSE-MsgGUID: Q1OPoT+0Tve7mKLXZVbarQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633545"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633545"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:23 -0800
X-CSE-ConnectionGUID: NuvdDNU/Qo+DljRpB49ipg==
X-CSE-MsgGUID: qZqZrtF8So2GHJFfSayl7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732852"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 05/39] eal: move NUMA request fields to user config
Date: Thu, 26 Nov 2026 18:13:38 +0000
Message-ID: <20261126181414.124094-6-bruce.richardson@intel.com>
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

As with basic memory user parameters, move the NUMA-specific parameters
to the user config struct. Update flag types to bool in the process.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_dynmem.c  | 15 +++++++--------
 lib/eal/common/eal_common_options.c | 24 +++++++++++-------------
 lib/eal/common/eal_internal_cfg.h   | 11 ++++-------
 lib/eal/common/malloc_heap.c        |  2 +-
 lib/eal/freebsd/eal.c               |  2 +-
 lib/eal/linux/eal.c                 |  2 +-
 lib/eal/linux/eal_memory.c          | 23 ++++++++++++-----------
 lib/eal/windows/eal.c               |  2 +-
 8 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 4643c13fb0..a5652ebd5f 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -232,6 +232,7 @@ eal_dynmem_hugepage_init(void)
 	int hp_sz_idx, socket_id;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	memset(used_hp, 0, sizeof(used_hp));
 
@@ -268,7 +269,7 @@ eal_dynmem_hugepage_init(void)
 
 	/* make a copy of numa_mem, needed for balanced allocation. */
 	for (hp_sz_idx = 0; hp_sz_idx < RTE_MAX_NUMA_NODES; hp_sz_idx++)
-		memory[hp_sz_idx] = internal_conf->numa_mem[hp_sz_idx];
+		memory[hp_sz_idx] = user_cfg->numa_mem[hp_sz_idx];
 
 	/* calculate final number of pages */
 	if (eal_dynmem_calc_num_pages_per_socket(memory,
@@ -336,10 +337,10 @@ eal_dynmem_hugepage_init(void)
 	}
 
 	/* if socket limits were specified, set them */
-	if (internal_conf->force_numa_limits) {
+	if (user_cfg->force_numa_limits) {
 		unsigned int i;
 		for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
-			uint64_t limit = internal_conf->numa_limit[i];
+			uint64_t limit = user_cfg->numa_limit[i];
 			if (limit == 0)
 				continue;
 			if (rte_mem_alloc_validator_register("socket-limit",
@@ -376,8 +377,6 @@ eal_dynmem_calc_num_pages_per_socket(
 	unsigned int requested, available;
 	int total_num_pages = 0;
 	uint64_t remaining_mem, cur_mem;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	uint64_t total_mem = user_cfg->memory;
 
@@ -385,7 +384,7 @@ eal_dynmem_calc_num_pages_per_socket(
 		return -1;
 
 	/* if specific memory amounts per socket weren't requested */
-	if (internal_conf->force_numa == 0) {
+	if (!user_cfg->force_numa) {
 		size_t total_size;
 #ifdef RTE_ARCH_64
 		int cpu_per_socket[RTE_MAX_NUMA_NODES];
@@ -512,8 +511,8 @@ eal_dynmem_calc_num_pages_per_socket(
 
 		/* if we didn't satisfy all memory requirements per socket */
 		if (memory[socket] > 0 &&
-				internal_conf->numa_mem[socket] != 0) {
-			requested = internal_conf->numa_mem[socket] / 0x100000;
+				user_cfg->numa_mem[socket] != 0) {
+			requested = user_cfg->numa_mem[socket] / 0x100000;
 			available = requested - (memory[socket] / 0x100000);
 			EAL_LOG(ERR, "Not enough memory available on socket %u! Requested: %uMB, available: %uMB",
 				socket, requested, available);
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 31c58004cc..57c2bfc180 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -515,18 +515,16 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	user_cfg->memory = 0;
 	user_cfg->force_nrank = 0;
 	user_cfg->force_nchannel = 0;
+	user_cfg->force_numa = false;
+	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
+		user_cfg->numa_mem[i] = 0;
+	user_cfg->force_numa_limits = false;
+	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
+		user_cfg->numa_limit[i] = 0;
 	internal_cfg->hugefile_prefix = NULL;
 	internal_cfg->hugepage_dir = NULL;
 	internal_cfg->hugepage_file.unlink_before_mapping = false;
 	internal_cfg->hugepage_file.unlink_existing = true;
-	internal_cfg->force_numa = 0;
-	/* zero out the NUMA config */
-	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		internal_cfg->numa_mem[i] = 0;
-	internal_cfg->force_numa_limits = 0;
-	/* zero out the NUMA limits config */
-	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		internal_cfg->numa_limit[i] = 0;
 	/* zero out hugedir descriptors */
 	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
 		memset(&internal_cfg->hugepage_info[i], 0,
@@ -2306,18 +2304,18 @@ eal_parse_args(void)
 		}
 	}
 	if (args.numa_mem != NULL) {
-		if (eal_parse_socket_arg(args.numa_mem, int_cfg->numa_mem) < 0) {
+		if (eal_parse_socket_arg(args.numa_mem, user_cfg->numa_mem) < 0) {
 			EAL_LOG(ERR, "invalid numa-mem parameter: '%s'", args.numa_mem);
 			return -1;
 		}
-		int_cfg->force_numa = 1;
+		user_cfg->force_numa = true;
 	}
 	if (args.numa_limit != NULL) {
-		if (eal_parse_socket_arg(args.numa_limit, int_cfg->numa_limit) < 0) {
+		if (eal_parse_socket_arg(args.numa_limit, user_cfg->numa_limit) < 0) {
 			EAL_LOG(ERR, "invalid numa-limit parameter: '%s'", args.numa_limit);
 			return -1;
 		}
-		int_cfg->force_numa_limits = 1;
+		user_cfg->force_numa_limits = true;
 	}
 	TAILQ_FOREACH(arg, &args.pagesz_mem, next) {
 		if (eal_parse_pagesz_mem(arg->arg, int_cfg) < 0) {
@@ -2509,7 +2507,7 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	/* if no memory amounts were requested, this will result in 0 and
 	 * will be overridden later, right after eal_hugepage_info_init() */
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		user_cfg->memory += internal_cfg->numa_mem[i];
+		user_cfg->memory += user_cfg->numa_mem[i];
 
 	return 0;
 }
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index e56014cf73..fe67bb95e1 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -63,6 +63,10 @@ struct eal_user_cfg {
 	size_t memory;           /**< amount of asked memory */
 	uint8_t force_nchannel;  /**< force number of channels */
 	uint8_t force_nrank;     /**< force number of ranks */
+	bool force_numa;         /**< true to request memory on specific NUMA nodes */
+	bool force_numa_limits;  /**< true to apply per-NUMA memory limits */
+	uint64_t numa_mem[RTE_MAX_NUMA_NODES];    /**< amount of memory per NUMA node */
+	uint64_t numa_limit[RTE_MAX_NUMA_NODES];  /**< limit amount of memory per NUMA node */
 };
 
 /**
@@ -99,13 +103,6 @@ struct internal_config {
 	 */
 	volatile unsigned create_uio_dev; /**< true to create /dev/uioX devices */
 	volatile enum rte_proc_type_t process_type; /**< multi-process proc type */
-	/** true to try allocating memory on specific NUMA nodes */
-	volatile unsigned force_numa;
-	/** amount of memory per NUMA node */
-	volatile uint64_t numa_mem[RTE_MAX_NUMA_NODES];
-	volatile unsigned force_numa_limits;
-	/** limit amount of memory per NUMA node */
-	volatile uint64_t numa_limit[RTE_MAX_NUMA_NODES];
 	uintptr_t base_virtaddr;          /**< base address to try and reserve memory from */
 	volatile unsigned legacy_mem;
 	/**< true to enable legacy memory behavior (no dynamic allocation,
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 39240c261c..77f364158a 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -701,7 +701,7 @@ malloc_heap_alloc_on_heap_id(size_t size, unsigned int heap_id, unsigned int fla
 static unsigned int
 malloc_get_numa_socket(void)
 {
-	const struct internal_config *conf = eal_get_internal_configuration();
+	const struct eal_user_cfg *conf = eal_get_user_configuration();
 	unsigned int socket_id = rte_socket_id();
 	unsigned int idx;
 
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index ef48082770..9e027405ca 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -593,7 +593,7 @@ rte_eal_init(int argc, char **argv)
 		}
 	}
 
-	if (user_cfg->memory == 0 && internal_conf->force_numa == 0) {
+	if (user_cfg->memory == 0 && !user_cfg->force_numa) {
 		if (internal_conf->no_hugetlbfs)
 			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 		else
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index e06c356932..dc252cab37 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -764,7 +764,7 @@ rte_eal_init(int argc, char **argv)
 		}
 	}
 
-	if (user_cfg->memory == 0 && internal_conf->force_numa == 0) {
+	if (user_cfg->memory == 0 && !user_cfg->force_numa) {
 		if (internal_conf->no_hugetlbfs)
 			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 	}
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 4566f2ef4c..df4df5be8d 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -274,8 +274,7 @@ map_all_hugepages(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi,
 	struct bitmask *oldmask = NULL;
 	bool have_numa = true;
 	unsigned long maxnode = 0;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* Check if kernel supports NUMA. */
 	if (numa_available() != 0) {
@@ -294,7 +293,7 @@ map_all_hugepages(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi,
 			oldpolicy = MPOL_DEFAULT;
 		}
 		for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-			if (internal_conf->numa_mem[i])
+			if (user_cfg->numa_mem[i])
 				maxnode = i + 1;
 	}
 #endif
@@ -313,7 +312,7 @@ map_all_hugepages(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi,
 
 			if (j == maxnode) {
 				node_id = (node_id + 1) % maxnode;
-				while (!internal_conf->numa_mem[node_id]) {
+				while (!user_cfg->numa_mem[node_id]) {
 					node_id++;
 					node_id %= maxnode;
 				}
@@ -1142,6 +1141,7 @@ eal_legacy_hugepage_init(void)
 	struct hugepage_info used_hp[MAX_HUGEPAGE_SIZES];
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	uint64_t memory[RTE_MAX_NUMA_NODES];
 
@@ -1282,7 +1282,7 @@ eal_legacy_hugepage_init(void)
 
 	/* make a copy of numa_mem, needed for balanced allocation. */
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		memory[i] = internal_conf->numa_mem[i];
+		memory[i] = user_cfg->numa_mem[i];
 
 	/* map all hugepages and sort them */
 	for (i = 0; i < (int)internal_conf->num_hugepage_sizes; i++) {
@@ -1350,7 +1350,7 @@ eal_legacy_hugepage_init(void)
 
 	huge_recover_sigbus();
 
-	if (eal_get_user_configuration()->memory == 0 && internal_conf->force_numa == 0)
+	if (eal_get_user_configuration()->memory == 0 && !user_cfg->force_numa)
 		eal_get_user_configuration()->memory = eal_get_hugepage_mem_size();
 
 	nr_hugefiles = nr_hugepages;
@@ -1378,7 +1378,7 @@ eal_legacy_hugepage_init(void)
 
 	/* make a copy of numa_mem, needed for number of pages calculation */
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		memory[i] = internal_conf->numa_mem[i];
+		memory[i] = user_cfg->numa_mem[i];
 
 	/* calculate final number of pages */
 	nr_hugepages = eal_dynmem_calc_num_pages_per_socket(memory,
@@ -1712,6 +1712,7 @@ memseg_primary_init_32(void)
 	uint64_t extra_mem_per_socket, total_extra_mem, total_requested_mem;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* no-huge does not need this at all */
 	if (internal_conf->no_hugetlbfs)
@@ -1736,12 +1737,12 @@ memseg_primary_init_32(void)
 	 */
 	active_sockets = 0;
 	total_requested_mem = 0;
-	if (internal_conf->force_numa)
+	if (user_cfg->force_numa)
 		for (i = 0; i < rte_socket_count(); i++) {
 			uint64_t mem;
 
 			socket_id = rte_socket_id_by_idx(i);
-			mem = internal_conf->numa_mem[socket_id];
+			mem = user_cfg->numa_mem[socket_id];
 
 			if (mem == 0)
 				continue;
@@ -1798,7 +1799,7 @@ memseg_primary_init_32(void)
 
 		/* if we didn't specifically request memory on this socket */
 		skip = active_sockets != 0 &&
-				internal_conf->numa_mem[socket_id] == 0;
+				user_cfg->numa_mem[socket_id] == 0;
 		/* ...or if we didn't specifically request memory on *any*
 		 * socket, and this is not main lcore
 		 */
@@ -1813,7 +1814,7 @@ memseg_primary_init_32(void)
 
 		/* max amount of memory on this socket */
 		max_socket_mem = (active_sockets != 0 ?
-					internal_conf->numa_mem[socket_id] :
+					user_cfg->numa_mem[socket_id] :
 					eal_get_user_configuration()->memory) +
 					extra_mem_per_socket;
 		cur_socket_mem = 0;
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index efbee01757..d8c9fa26e3 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -242,7 +242,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (user_cfg->memory == 0 && !internal_conf->force_numa) {
+	if (user_cfg->memory == 0 && !user_cfg->force_numa) {
 		if (internal_conf->no_hugetlbfs)
 			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 	}
-- 
2.55.0

