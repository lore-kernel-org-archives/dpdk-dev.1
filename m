Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0160D107BCC6
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 16:07:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8013E40648;
	Fri, 13 Mar 2026 17:06:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 927B4402EF
 for <dev@dpdk.org>; Fri, 13 Mar 2026 17:06:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773418008; x=1804954008;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rNZGhQfF/NmsvxqW2VzJss8053k1bY3Q/6tW3EqxcOY=;
 b=ewpgMALS4T30iPVKm3lc+bTv9pBD58VJzI1lP8zaXfCTsFWh/m+DxbAU
 4Y2XPPhKIQCLgwwtBqS4Td/t0hyzJMEzFpXfVcqsw/VxUtb0i9K0TvDc2
 maLmabBUa873dd8mCiZGhlE50IuZ85NphDdOyo+jY7w62BsCa7f+fZdXp
 npgVO5ax2yapUPJXBoR4Iva2jw3m8aL90gleQQXUTH4RUUdPeok90N9g+
 +tMOMI3LtDTJNHtKVJc86YL6m1UqKps1Y9gpGy5TPrRfg5tRl3WY8xafU
 mVOIJrlBNsbqQ1HUrg2/JS2UkieijY0mtszH/h2XchkntxfL1+IVMd/r6 Q==;
X-CSE-ConnectionGUID: gIwTtxkhSim5J1qO44L3jw==
X-CSE-MsgGUID: 2FWTrS/ySBuSMfMCfSOCog==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74563529"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="74563529"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 09:06:47 -0700
X-CSE-ConnectionGUID: eFIAg/opRa+nD59YrizM0Q==
X-CSE-MsgGUID: IEds7hP0SqC7pH2uKFCqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="246377258"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 13 Mar 2026 09:06:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v2 5/6] eal/memory: store default segment limits in config
Date: Fri, 13 Mar 2026 16:06:36 +0000
Message-ID: <4b4aa7b43e8354f5ae325e634c88e4e649707be5.1773417833.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
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
 lib/eal/common/eal_common_dynmem.c  | 22 ++++++++--------------
 lib/eal/common/eal_common_options.c | 20 ++++++++++++++++++++
 lib/eal/common/eal_internal_cfg.h   |  2 ++
 lib/eal/common/eal_options.h        |  1 +
 lib/eal/freebsd/eal.c               |  6 ++++++
 lib/eal/linux/eal.c                 |  6 ++++++
 lib/eal/linux/eal_memory.c          |  3 +++
 lib/eal/windows/eal.c               |  6 ++++++
 8 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index c163bf4967..c33fbdea6d 100644
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
 	} memtypes[RTE_MAX_MEMSEG_LISTS] = {0};
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
 
 	/* maximum number of memtypes we're ever going to get */
@@ -92,6 +86,7 @@ eal_dynmem_memseg_lists_init(void)
 #endif
 			memtypes[cur_type].page_sz = hugepage_sz;
 			memtypes[cur_type].socket_id = socket_id;
+			memtypes[cur_type].hpi_idx = hpi_idx;
 
 			EAL_LOG(DEBUG, "Detected memory type: "
 				"socket_id:%u hugepage_sz:%" PRIu64,
@@ -101,8 +96,6 @@ eal_dynmem_memseg_lists_init(void)
 	/* number of memtypes could have been lower due to no NUMA support */
 	n_memtypes = cur_type;
 
-	/* set up limits for types */
-	max_mem_per_type = (uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20;
 	mem_va_len = 0;
 	mem_va_page_sz = 0;
 
@@ -110,9 +103,12 @@ eal_dynmem_memseg_lists_init(void)
 	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
 		unsigned int n_segs;
 		struct memtype *type = &memtypes[cur_type];
+		uint64_t max_mem_per_type;
 		uint64_t pagesz;
 
 		pagesz = type->page_sz;
+		max_mem_per_type =
+			internal_conf->hugepage_mem_sz_limits[type->hpi_idx];
 
 		/*
 		 * we need to create a segment list for this type. we must take
@@ -121,10 +117,8 @@ eal_dynmem_memseg_lists_init(void)
 		 * 1. total amount of memory to use for this memory type
 		 * 2. total amount of memory allowed per type
 		 * 3. number of segments needed to fit the amount of memory
-		 * 4. number of segments allowed per type
 		 */
 		n_segs = max_mem_per_type / pagesz;
-		n_segs = RTE_MIN(n_segs, (unsigned int)RTE_MAX_MEMSEG_PER_TYPE);
 		type->n_segs = n_segs;
 		type->mem_sz = (size_t)pagesz * type->n_segs;
 		mem_va_page_sz = RTE_MAX(mem_va_page_sz, (size_t)pagesz);
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index aad676a004..bbc4427524 100644
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
+	unsigned int i;
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
index 55779badec..1ed4f69e3e 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1813,6 +1813,7 @@ memseg_primary_init_32(void)
 		for (hpi_idx = 0; hpi_idx < hp_sizes; hpi_idx++) {
 			uint64_t max_pagesz_mem, cur_pagesz_mem = 0;
 			uint64_t hugepage_sz;
+			uint64_t pagesz_mem_limit;
 			struct hugepage_info *hpi;
 
 			hpi = &internal_conf->hugepage_info[hpi_idx];
@@ -1823,6 +1824,8 @@ memseg_primary_init_32(void)
 				continue;
 
 			max_pagesz_mem = max_socket_mem - cur_socket_mem;
+			pagesz_mem_limit = internal_conf->hugepage_mem_sz_limits[hpi_idx];
+			max_pagesz_mem = RTE_MIN(max_pagesz_mem, pagesz_mem_limit);
 
 			/* make it multiple of page size */
 			max_pagesz_mem = RTE_ALIGN_FLOOR(max_pagesz_mem,
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

