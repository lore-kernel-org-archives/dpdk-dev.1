Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E503104C00E
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:59:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8B2A40EDC;
	Wed, 11 Mar 2026 11:59:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 74CA540E72
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773226743; x=1804762743;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=87iECER7/zYTdDFg+6MsuJ43eZbnU+/G93DDk3OXKYk=;
 b=nm7Tfs2OstGXSFB7yC25VC665fKXF/Dr1mprxWGHzQilEq430re4qb2K
 tCoRlVbDg4ChYbbclcGYlD0RauOdoJ0Ijtm/LWLpKenvDcfVWQQuFltvj
 eLt2P9iVFo2T6OY9BEdEAQuT7PXli1qVetAnWBwWkEVvRimz59uE6LT6h
 XahbboLDkkcOiJn6gy8jfADYCeDL+xATGdm79OI4tSKZI0yeErjiGKW0s
 ljTaGw9WtHllcd7Dgpa6Mr21JaHoU+F0No7Lrb6QXDGoXNZITiinbMAYS
 76frttND6c3QpZH8yh5Qk4omrMQxDICl79W6tFc6foV/O2wn6Fp2gJFhD g==;
X-CSE-ConnectionGUID: tcGSRzuERhaoZZK24PBZLg==
X-CSE-MsgGUID: 51E9uY/VQWmjSKkd9FagXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74481624"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74481624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 03:59:02 -0700
X-CSE-ConnectionGUID: 2KxvJFX7SD6EcJXa5jHxww==
X-CSE-MsgGUID: J4MIvkKrR1GOpk3s9hzMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="250928207"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2026 03:59:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v1 4/5] eal/memory: store default segment limits in config
Date: Wed, 11 Mar 2026 10:58:52 +0000
Message-ID: <8ef6f0951afc0b67db738b1d6a7bf0c46c936981.1773225702.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773225702.git.anatoly.burakov@intel.com>
References: 
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

Currently, VA space allocation is regulated by two constants picked up from
config - max memseg per list, and max memory per list. In preparation for
these limits being dynamic, add a per-page-size limit value in config,
populate that value from these defaults at init time, and adjust the code
to only refer to the mem limits from internal config.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_dynmem.c  | 29 +++++++++++------------------
 lib/eal/common/eal_common_options.c | 20 ++++++++++++++++++++
 lib/eal/common/eal_internal_cfg.h   |  2 ++
 lib/eal/common/eal_options.h        |  1 +
 lib/eal/freebsd/eal.c               |  6 ++++++
 lib/eal/linux/eal.c                 |  6 ++++++
 lib/eal/linux/eal_memory.c          |  6 ++++--
 lib/eal/windows/eal.c               |  6 ++++++
 8 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 640199473e..0d5e056239 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -24,13 +24,13 @@ eal_dynmem_memseg_lists_init(void)
 	struct memtype {
 		uint64_t page_sz;
 		int socket_id;
+		unsigned int hpi_idx;
 		unsigned int n_segs;
 		size_t mem_sz;
 		size_t va_offset;
 	} *memtypes = NULL;
 	int i, hpi_idx, msl_idx, ret = -1; /* fail unless told to succeed */
 	struct rte_memseg_list *msl;
-	uint64_t max_mem_per_type;
 	size_t mem_va_len, mem_va_page_sz;
 	unsigned int n_memtypes, cur_type;
 	void *mem_va_addr = NULL;
@@ -51,15 +51,9 @@ eal_dynmem_memseg_lists_init(void)
 	 * balancing act between maximum segments per type, maximum memory per
 	 * type, and number of detected NUMA nodes.
 	 *
-	 * the total amount of memory per type is limited by
-	 * RTE_MAX_MEM_MB_PER_TYPE. additionally, maximum number of segments per
-	 * type is also limited by RTE_MAX_MEMSEG_PER_TYPE. this is because for
-	 * smaller page sizes, it can take hundreds of thousands of segments to
-	 * reach the above specified per-type memory limits.
-	 *
-	 * each memory type is allotted a single memseg list. the size of that
-	 * list is calculated here to respect the per-type memory and segment
-	 * limits that apply.
+	 * the total amount of memory per type is limited by per-page-size
+	 * memory values in internal config. each memory type is allotted one
+	 * memseg list.
 	 */
 
 	/* create space for mem types */
@@ -90,6 +84,7 @@ eal_dynmem_memseg_lists_init(void)
 #endif
 			memtypes[cur_type].page_sz = hugepage_sz;
 			memtypes[cur_type].socket_id = socket_id;
+			memtypes[cur_type].hpi_idx = hpi_idx;
 
 			EAL_LOG(DEBUG, "Detected memory type: "
 				"socket_id:%u hugepage_sz:%" PRIu64,
@@ -106,18 +101,19 @@ eal_dynmem_memseg_lists_init(void)
 		goto out;
 	}
 
-	/* set up limits for types */
-	max_mem_per_type = (uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20;
 	mem_va_len = 0;
 	mem_va_page_sz = 0;
 
 	/* calculate total VA space and offsets for all mem types */
 	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
-		unsigned int max_segs_per_type;
+		unsigned int n_segs;
 		struct memtype *type = &memtypes[cur_type];
+		uint64_t max_mem_per_type;
 		uint64_t pagesz;
 
 		pagesz = type->page_sz;
+		max_mem_per_type =
+			internal_conf->hugepage_mem_sz_limits[type->hpi_idx];
 
 		/*
 		 * we need to create a segment list for this type. we must take
@@ -126,12 +122,9 @@ eal_dynmem_memseg_lists_init(void)
 		 * 1. total amount of memory to use for this memory type
 		 * 2. total amount of memory allowed per type
 		 * 3. number of segments needed to fit the amount of memory
-		 * 4. number of segments allowed per type
 		 */
-		max_segs_per_type = max_mem_per_type / pagesz;
-		max_segs_per_type = RTE_MIN(max_segs_per_type,
-				(unsigned int)RTE_MAX_MEMSEG_PER_TYPE);
-		type->n_segs = max_segs_per_type;
+		n_segs = max_mem_per_type / pagesz;
+		type->n_segs = n_segs;
 		type->mem_sz = (size_t)pagesz * type->n_segs;
 		mem_va_page_sz = RTE_MAX(mem_va_page_sz, (size_t)pagesz);
 		mem_va_len = RTE_ALIGN_CEIL(mem_va_len, pagesz);
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index aad676a004..806f4d0a2c 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -510,6 +510,7 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 		memset(&internal_cfg->hugepage_info[i], 0,
 				sizeof(internal_cfg->hugepage_info[0]));
 		internal_cfg->hugepage_info[i].lock_descriptor = -1;
+		internal_cfg->hugepage_mem_sz_limits[i] = 0;
 	}
 	internal_cfg->base_virtaddr = 0;
 
@@ -2359,6 +2360,25 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	return 0;
 }
 
+int
+eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < internal_cfg->num_hugepage_sizes; i++) {
+		const uint64_t pagesz = internal_cfg->hugepage_info[i].hugepage_sz;
+		uint64_t limit;
+
+		/* assign default limits */
+		limit = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
+				(uint64_t)RTE_MAX_MEMSEG_PER_TYPE * pagesz);
+
+		internal_cfg->hugepage_mem_sz_limits[i] = limit;
+	}
+
+	return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_vect_get_max_simd_bitwidth)
 uint16_t
 rte_vect_get_max_simd_bitwidth(void)
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 95d327a613..0bf192c6e5 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -96,6 +96,8 @@ struct internal_config {
 			/**< user defined mbuf pool ops name */
 	unsigned num_hugepage_sizes;      /**< how many sizes on this system */
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
+	uint64_t hugepage_mem_sz_limits[MAX_HUGEPAGE_SIZES];
+	/**< default max memory per hugepage size */
 	enum rte_iova_mode iova_mode ;    /**< Set IOVA mode on this system  */
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index f5e7905609..82cc8be8db 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -12,6 +12,7 @@ struct rte_tel_data;
 int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
+int eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg);
 int eal_adjust_config(struct internal_config *internal_cfg);
 int eal_cleanup_config(struct internal_config *internal_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 60f5e676a8..8b1ba5b99b 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -585,6 +585,12 @@ rte_eal_init(int argc, char **argv)
 			rte_errno = EACCES;
 			goto err_out;
 		}
+		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
+				eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
+			rte_eal_init_alert("Cannot apply hugepage memory limits.");
+			rte_errno = EINVAL;
+			goto err_out;
+		}
 	}
 
 	if (internal_conf->memory == 0 && internal_conf->force_numa == 0) {
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index d848de03d8..fc2e9b8c0e 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -748,6 +748,12 @@ rte_eal_init(int argc, char **argv)
 			rte_errno = EACCES;
 			goto err_out;
 		}
+		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
+				eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
+			rte_eal_init_alert("Cannot apply hugepage memory limits.");
+			rte_errno = EINVAL;
+			goto err_out;
+		}
 	}
 
 	if (internal_conf->memory == 0 && internal_conf->force_numa == 0) {
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index c169895c6f..38934b9a65 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1813,6 +1813,7 @@ memseg_primary_init_32(void)
 		for (hpi_idx = 0; hpi_idx < hp_sizes; hpi_idx++) {
 			uint64_t max_pagesz_mem, cur_pagesz_mem = 0;
 			uint64_t hugepage_sz;
+			uint64_t pagesz_mem_limit;
 			struct hugepage_info *hpi;
 			unsigned int n_segs;
 
@@ -1824,12 +1825,13 @@ memseg_primary_init_32(void)
 				continue;
 
 			max_pagesz_mem = max_socket_mem - cur_socket_mem;
+			pagesz_mem_limit = internal_conf->hugepage_mem_sz_limits[hpi_idx];
+			max_pagesz_mem = RTE_MIN(max_pagesz_mem, pagesz_mem_limit);
 
 			/* make it multiple of page size */
 			max_pagesz_mem = RTE_ALIGN_FLOOR(max_pagesz_mem,
 					hugepage_sz);
-			n_segs = RTE_MIN(max_pagesz_mem / hugepage_sz,
-					(unsigned int)RTE_MAX_MEMSEG_PER_TYPE);
+			n_segs = max_pagesz_mem / hugepage_sz;
 
 			EAL_LOG(DEBUG, "Attempting to preallocate "
 					"%" PRIu64 "M on socket %i",
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index f06375a624..6dacae7235 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -229,6 +229,12 @@ rte_eal_init(int argc, char **argv)
 		rte_errno = EACCES;
 		goto err_out;
 	}
+	if (!internal_conf->no_hugetlbfs &&
+			eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
+		rte_eal_init_alert("Cannot apply hugepage memory limits");
+		rte_errno = EINVAL;
+		goto err_out;
+	}
 
 	if (internal_conf->memory == 0 && !internal_conf->force_numa) {
 		if (internal_conf->no_hugetlbfs)
-- 
2.47.3

