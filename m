Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78245104C007
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:59:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03D7040E34;
	Wed, 11 Mar 2026 11:59:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 475C040E4B
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773226742; x=1804762742;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=b2tZX6KVx5jzygxyz9WdJR7B2fxOmgDcz+jXpkOPfgI=;
 b=KOoj7X5eVcu390ZXsmQBoB42ohZ1FEYtyN/Q+Z9KqdAQJTlFO+//bnhF
 ENoes4NE8ujEfk8A5CJid1GtdkXND5yJANn+TD//NMtzIau78XgNeYcB4
 CfN8CXym5gk9XP5Nb+Ec44//bBjdzXFwrBeQNP09OS19NOnhB7UW/kUrM
 YP+UUO/U3bp4jQxhK1NEv87R9hFzzhLKBjUcVEeQe6VkaGczMzvcUWpAl
 8d7jrYTpTAHXGlUO4Temtr4fVKCa8Bfr9EUFTk2U2OFp12fYOiytqo50y
 PZRGAzNlCSlJC4VLPLQucqJ4WUZINYKf+HdGNL8elexVitLJSjPlHJ80J Q==;
X-CSE-ConnectionGUID: Zw39bd4tS86Qg8MnRsws1g==
X-CSE-MsgGUID: OoIyeJNaRbKr6UgUEQ7lnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74481622"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74481622"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 03:59:01 -0700
X-CSE-ConnectionGUID: pPH6kpS4TTm60Ev4ejDnsw==
X-CSE-MsgGUID: aG4uNUb6Q0Sy7yEsvrsl7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="250928202"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2026 03:59:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 3/5] eal/memory: get rid of global VA space limits
Date: Wed, 11 Mar 2026 10:58:51 +0000
Message-ID: <c070fdae02333d237c6498d30e75296b1e32fc03.1773225702.git.anatoly.burakov@intel.com>
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

Currently, all VA space reservations take into account global memory limit.
The original intent was to limit memory allocations to however many NUMA
nodes the machine had taking into the account that socket ID's may be
discontiguous. Since we have had "socket count" API for while and it gives
us correct NUMA node count, taking discontiguousness into account, we can
relax the total limits and remove the restrictions, and let VA space usage
scale with NUMA nodes.

The only place where we actually require a hard limit is in 32-bit code,
where we cannot allocate more than 2G of VA space.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 config/arm/meson.build                        |  1 -
 config/meson.build                            |  5 ---
 .../prog_guide/env_abstraction_layer.rst      |  2 --
 lib/eal/common/eal_common_dynmem.c            | 13 +++----
 lib/eal/freebsd/eal_memory.c                  | 36 +++----------------
 lib/eal/linux/eal_memory.c                    | 10 +++---
 6 files changed, 14 insertions(+), 53 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 523b0fc0ed..3b03f5e31b 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -69,7 +69,6 @@ part_number_config_arm = {
         'flags': [
             ['RTE_MACHINE', '"neoverse-n1"'],
             ['RTE_ARM_FEATURE_ATOMICS', true],
-            ['RTE_MAX_MEM_MB', 1048576],
             ['RTE_MAX_LCORE', 256],
             ['RTE_MAX_NUMA_NODES', 8]
         ]
diff --git a/config/meson.build b/config/meson.build
index 02e2798cca..f68f1f5f53 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -383,11 +383,6 @@ dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
 dpdk_conf.set('RTE_MAX_VFIO_GROUPS', 64)
 dpdk_conf.set('RTE_DRIVER_MEMPOOL_BUCKET_SIZE_KB', 64)
 dpdk_conf.set('RTE_LIBRTE_DPAA2_USE_PHYS_IOVA', true)
-if dpdk_conf.get('RTE_ARCH_64')
-    dpdk_conf.set('RTE_MAX_MEM_MB', 524288)
-else # for 32-bit we need smaller reserved memory areas
-    dpdk_conf.set('RTE_MAX_MEM_MB', 2048)
-endif
 if get_option('mbuf_refcnt_atomic')
     dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
 endif
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index 04368a3950..63e0568afa 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -208,8 +208,6 @@ variables:
   can have (where "type" is defined as "page size + NUMA node" combination)
 * ``RTE_MAX_MEM_MB_PER_TYPE`` controls how much megabytes of memory each
   memory type can address
-* ``RTE_MAX_MEM_MB`` places a global maximum on the amount of memory
-  DPDK can reserve
 
 Normally, these options do not need to be changed.
 
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index bfc4de6698..640199473e 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -30,7 +30,7 @@ eal_dynmem_memseg_lists_init(void)
 	} *memtypes = NULL;
 	int i, hpi_idx, msl_idx, ret = -1; /* fail unless told to succeed */
 	struct rte_memseg_list *msl;
-	uint64_t max_mem, max_mem_per_type;
+	uint64_t max_mem_per_type;
 	size_t mem_va_len, mem_va_page_sz;
 	unsigned int n_memtypes, cur_type;
 	void *mem_va_addr = NULL;
@@ -51,11 +51,8 @@ eal_dynmem_memseg_lists_init(void)
 	 * balancing act between maximum segments per type, maximum memory per
 	 * type, and number of detected NUMA nodes.
 	 *
-	 * the total amount of memory is limited by RTE_MAX_MEM_MB value.
-	 *
-	 * the total amount of memory per type is limited by either
-	 * RTE_MAX_MEM_MB_PER_TYPE, or by RTE_MAX_MEM_MB divided by the number
-	 * of detected NUMA nodes. additionally, maximum number of segments per
+	 * the total amount of memory per type is limited by
+	 * RTE_MAX_MEM_MB_PER_TYPE. additionally, maximum number of segments per
 	 * type is also limited by RTE_MAX_MEMSEG_PER_TYPE. this is because for
 	 * smaller page sizes, it can take hundreds of thousands of segments to
 	 * reach the above specified per-type memory limits.
@@ -110,9 +107,7 @@ eal_dynmem_memseg_lists_init(void)
 	}
 
 	/* set up limits for types */
-	max_mem = (uint64_t)RTE_MAX_MEM_MB << 20;
-	max_mem_per_type = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
-			max_mem / n_memtypes);
+	max_mem_per_type = (uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20;
 	mem_va_len = 0;
 	mem_va_page_sz = 0;
 
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 36dcc04ce4..6ae5b22f1b 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -337,7 +337,6 @@ memseg_primary_init(void)
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int hpi_idx, msl_idx = 0;
 	struct rte_memseg_list *msl;
-	uint64_t max_mem, total_mem;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -346,24 +345,15 @@ memseg_primary_init(void)
 		return 0;
 
 	/* FreeBSD has an issue where core dump will dump the entire memory
-	 * contents, including anonymous zero-page memory. Therefore, while we
-	 * will be limiting total amount of memory to RTE_MAX_MEM_MB, we will
-	 * also be further limiting total memory amount to whatever memory is
-	 * available to us through contigmem driver (plus spacing blocks).
-	 *
-	 * so, at each stage, we will be checking how much memory we are
-	 * preallocating, and adjust all the values accordingly.
+	 * contents, including anonymous zero-page memory. To avoid reserving VA
+	 * space we are not going to use, size memseg lists according to
+	 * contigmem-provided page counts.
 	 */
 
-	max_mem = (uint64_t)RTE_MAX_MEM_MB << 20;
-	total_mem = 0;
-
 	/* create memseg lists */
 	for (hpi_idx = 0; hpi_idx < (int) internal_conf->num_hugepage_sizes;
 			hpi_idx++) {
-		uint64_t max_type_mem, total_type_mem = 0;
-		uint64_t avail_mem;
-		int max_segs, avail_segs;
+		int avail_segs;
 		struct hugepage_info *hpi;
 		uint64_t hugepage_sz;
 		unsigned int n_segs;
@@ -373,15 +363,6 @@ memseg_primary_init(void)
 
 		/* no NUMA support on FreeBSD */
 
-		/* check if we've already exceeded total memory amount */
-		if (total_mem >= max_mem)
-			break;
-
-		/* first, calculate theoretical limits according to config */
-		max_type_mem = RTE_MIN(max_mem - total_mem,
-			(uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20);
-		max_segs = RTE_MAX_MEMSEG_PER_TYPE;
-
 		/* now, limit all of that to whatever will actually be
 		 * available to us, because without dynamic allocation support,
 		 * all of that extra memory will be sitting there being useless
@@ -393,11 +374,7 @@ memseg_primary_init(void)
 		 * that are non-contiguous.
 		 */
 		avail_segs = (hpi->num_pages[0] * 2) - 1;
-		avail_mem = avail_segs * hugepage_sz;
-
-		max_type_mem = RTE_MIN(avail_mem, max_type_mem);
-		max_segs = RTE_MIN(avail_segs, max_segs);
-		n_segs = RTE_MIN(max_type_mem / hugepage_sz, (uint64_t)max_segs);
+		n_segs = avail_segs;
 		if (n_segs == 0)
 			continue;
 
@@ -413,13 +390,10 @@ memseg_primary_init(void)
 				0, false))
 			return -1;
 
-		total_type_mem = n_segs * hugepage_sz;
 		if (memseg_list_alloc(msl)) {
 			EAL_LOG(ERR, "Cannot allocate VA space for memseg list");
 			return -1;
 		}
-
-		total_mem += total_type_mem;
 	}
 	return 0;
 }
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 3b2afee852..c169895c6f 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1695,12 +1695,13 @@ rte_eal_using_phys_addrs(void)
 static int __rte_unused
 memseg_primary_init_32(void)
 {
+	/* limit total amount of memory on 32-bit */
+	const uint64_t mem32_max_mem = 2ULL << 30;
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int active_sockets, hpi_idx, msl_idx = 0;
 	unsigned int socket_id, i;
 	struct rte_memseg_list *msl;
 	uint64_t extra_mem_per_socket, total_extra_mem, total_requested_mem;
-	uint64_t max_mem;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -1743,13 +1744,12 @@ memseg_primary_init_32(void)
 	else
 		total_requested_mem = internal_conf->memory;
 
-	max_mem = (uint64_t)RTE_MAX_MEM_MB << 20;
-	if (total_requested_mem > max_mem) {
+	if (total_requested_mem > mem32_max_mem) {
 		EAL_LOG(ERR, "Invalid parameters: 32-bit process can at most use %uM of memory",
-				(unsigned int)(max_mem >> 20));
+				(unsigned int)(mem32_max_mem >> 20));
 		return -1;
 	}
-	total_extra_mem = max_mem - total_requested_mem;
+	total_extra_mem = mem32_max_mem - total_requested_mem;
 	extra_mem_per_socket = active_sockets == 0 ? total_extra_mem :
 			total_extra_mem / active_sockets;
 
-- 
2.47.3

