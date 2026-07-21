Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76067C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0E0F40E43;
	Tue, 21 Jul 2026 11:46:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3DEE540DFB
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627187; x=1816163187;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D1GbSihsFc2RTHPB6niRjCI6XtHjNlZI19RSd9NFw9Y=;
 b=hh2OokvZ+xRy8U/7WmRZoy/m8wiN1WCxvCWyMitX0r8zGKv3QaTw6PNP
 4ptVAVVQazF/UZY8iu0bXls4vJplmibxg9GlYdBeMzLfBl2qFjojqhogc
 uyKt+FdtB9KFRcYf02yE92YmEE24U9pMx6Ezi1DNAYZXapIiztvILl2gf
 K+ecVHBf+MP7rhOAVqPbYkplOkPLt+M5Da3pVajxUtQ0DPkxL/eQ9A1tI
 esWP/XK9FksSyCyUKCvhD0YRKxf5ZIa6ImIxTAIf2/Ml8ItH6MuLWsYq6
 dgJVbsZLFin7dm4pimLRD+d+TqTezI7vpKpe81LBxK4Aj8RPkLVRjJquB Q==;
X-CSE-ConnectionGUID: j2fDi0fLSxmK9yx7u3QyAQ==
X-CSE-MsgGUID: r+iH6DifQXyTgHW39C6jNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872490"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872490"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:26 -0700
X-CSE-ConnectionGUID: 5qVdhMFMTI2xTGO+OMnFZg==
X-CSE-MsgGUID: TihLMnYESlWe96uUitQBRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922389"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 24/39] eal: remove rte_config structure
Date: Tue, 21 Jul 2026 10:45:32 +0100
Message-ID: <20260721094555.2188496-25-bruce.richardson@intel.com>
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

The rte_config structure is no longer used, so remove it, and the
function returning a pointer to it.

In the process, as a general cleanup, remove references to rte_config in
error or info messages where it no longer makes sense to do so.
For example, messages around creating or attaching to the shared memory
config were referencing "rte_config", even though rte_config itself
hasn't been in shared memory.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c | 10 ----------
 lib/eal/common/eal_private.h       | 15 ---------------
 lib/eal/freebsd/eal.c              | 18 +++++++++---------
 lib/eal/include/rte_memzone.h      | 10 +++++-----
 lib/eal/include/rte_tailq.h        |  2 +-
 lib/eal/linux/eal.c                | 18 +++++++++---------
 6 files changed, 24 insertions(+), 49 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index ebb7c222d9..35654cc71f 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -20,9 +20,6 @@ static struct rte_mem_config early_mem_config = {
 	.memory_hotplug_lock = RTE_RWLOCK_INITIALIZER,
 };
 
-/* Address of global and public configuration */
-static struct rte_config rte_config;
-
 /* platform-specific runtime dir */
 static char runtime_dir[UNIX_PATH_MAX];
 
@@ -56,13 +53,6 @@ eal_set_runtime_dir(const char *run_dir)
 	return 0;
 }
 
-/* Return a pointer to the configuration structure */
-struct rte_config *
-rte_eal_get_configuration(void)
-{
-	return &rte_config;
-}
-
 /* Return a pointer to the memory config structure */
 struct rte_mem_config *
 eal_get_mcfg(void)
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 0a82e068e8..b1d3c69601 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -17,21 +17,6 @@
 
 #include "eal_internal_cfg.h"
 
-/**
- * The global RTE configuration structure.
- */
-struct rte_config {
-	int _unused; /**< dummy field to prevent empty struct */
-};
-
-/**
- * Get the global configuration structure.
- *
- * @return
- *   A pointer to the global configuration structure.
- */
-struct rte_config *rte_eal_get_configuration(void);
-
 /**
  * Put the argument list into a structure.
  *
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index ffc3a3f0cd..3b7b6540d1 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -145,7 +145,7 @@ rte_eal_config_create(void)
 	rte_mem_cfg_addr = eal_get_virtual_area(rte_mem_cfg_addr,
 			&cfg_len_aligned, page_sz, 0, 0);
 	if (rte_mem_cfg_addr == NULL) {
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config");
+		EAL_LOG(ERR, "Cannot mmap shared memory config");
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
 		return -1;
@@ -156,7 +156,7 @@ rte_eal_config_create(void)
 			cfg_len_aligned, PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_FIXED, mem_cfg_fd, 0);
 	if (mapped_mem_cfg_addr == MAP_FAILED) {
-		EAL_LOG(ERR, "Cannot remap memory for rte_config: %s", strerror(errno));
+		EAL_LOG(ERR, "Cannot remap shared memory config: %s", strerror(errno));
 		munmap(rte_mem_cfg_addr, cfg_len);
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
@@ -201,7 +201,7 @@ rte_eal_config_attach(void)
 	if (rte_mem_cfg_addr == MAP_FAILED) {
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config! error %i (%s)",
+		EAL_LOG(ERR, "Cannot mmap shared memory config! error %i (%s)",
 			errno, strerror(errno));
 		return -1;
 	}
@@ -239,12 +239,12 @@ rte_eal_config_reattach(void)
 
 	if (mem_config == MAP_FAILED || mem_config != rte_mem_cfg_addr) {
 		if (mem_config != MAP_FAILED) {
-			EAL_LOG(ERR, "Cannot mmap memory for rte_config at [%p], got [%p] - please use '--base-virtaddr' option",
+			EAL_LOG(ERR, "Cannot mmap shared memory config at [%p], got [%p] - please use '--base-virtaddr' option",
 					rte_mem_cfg_addr, mem_config);
 			munmap(mem_config, sizeof(struct rte_mem_config));
 			return -1;
 		}
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config! error %i (%s)",
+		EAL_LOG(ERR, "Cannot mmap shared memory config! error %i (%s)",
 			errno, strerror(errno));
 		return -1;
 	}
@@ -280,9 +280,9 @@ eal_proc_type_detect(void)
 	return ptype;
 }
 
-/* Sets up rte_config structure with the pointer to shared memory config.*/
+/* Attaches to or creates the shared memory config for this process. */
 static int
-rte_config_init(void)
+eal_mem_config_init(void)
 {
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
@@ -485,7 +485,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (rte_config_init() < 0) {
+	if (eal_mem_config_init() < 0) {
 		rte_eal_init_alert("Cannot init config");
 		goto err_out;
 	}
@@ -564,7 +564,7 @@ rte_eal_init(int argc, char **argv)
 		rte_eal_iova_mode() == RTE_IOVA_PA ? "PA" : "VA");
 
 	if (!user_cfg->no_hugetlbfs) {
-		/* rte_config isn't initialized yet */
+		/* shared mem config not yet attached */
 		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
 			eal_hugepage_info_init() :
 			eal_hugepage_info_read();
diff --git a/lib/eal/include/rte_memzone.h b/lib/eal/include/rte_memzone.h
index 5a0e1b8a15..7f94b6ff71 100644
--- a/lib/eal/include/rte_memzone.h
+++ b/lib/eal/include/rte_memzone.h
@@ -13,8 +13,8 @@
  * portions of physical memory. These zones are identified by a name.
  *
  * The memzone descriptors are shared by all partitions and are
- * located in a known place of physical memory. This zone is accessed
- * using rte_eal_get_configuration(). The lookup (by name) of a
+ * located in a known place of physical memory accessible via the
+ * shared memory config. The lookup (by name) of a
  * memory zone can be done in any partition and returns the same
  * physical address.
  *
@@ -137,7 +137,7 @@ size_t rte_memzone_max_get(void);
  *   A pointer to a correctly-filled read-only memzone descriptor, or NULL
  *   on error.
  *   On error case, rte_errno will be set appropriately:
- *    - E_RTE_NO_CONFIG - function could not get pointer to rte_config structure
+ *    - E_RTE_NO_CONFIG - function could not get pointer to shared memory config
  *    - ENOSPC - the maximum number of memzones has already been allocated
  *    - EEXIST - a memzone with the same name already exists
  *    - ENOMEM - no appropriate memory area found in which to create memzone
@@ -202,7 +202,7 @@ const struct rte_memzone *rte_memzone_reserve(const char *name,
  *   A pointer to a correctly-filled read-only memzone descriptor, or NULL
  *   on error.
  *   On error case, rte_errno will be set appropriately:
- *    - E_RTE_NO_CONFIG - function could not get pointer to rte_config structure
+ *    - E_RTE_NO_CONFIG - function could not get pointer to shared memory config
  *    - ENOSPC - the maximum number of memzones has already been allocated
  *    - EEXIST - a memzone with the same name already exists
  *    - ENOMEM - no appropriate memory area found in which to create memzone
@@ -273,7 +273,7 @@ const struct rte_memzone *rte_memzone_reserve_aligned(const char *name,
  *   A pointer to a correctly-filled read-only memzone descriptor, or NULL
  *   on error.
  *   On error case, rte_errno will be set appropriately:
- *    - E_RTE_NO_CONFIG - function could not get pointer to rte_config structure
+ *    - E_RTE_NO_CONFIG - function could not get pointer to shared memory config
  *    - ENOSPC - the maximum number of memzones has already been allocated
  *    - EEXIST - a memzone with the same name already exists
  *    - ENOMEM - no appropriate memory area found in which to create memzone
diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
index e7caed6812..dced107368 100644
--- a/lib/eal/include/rte_tailq.h
+++ b/lib/eal/include/rte_tailq.h
@@ -29,7 +29,7 @@ RTE_TAILQ_HEAD(rte_tailq_entry_head, rte_tailq_entry);
 
 /**
  * The structure defining a tailq header entry for storing
- * in the rte_config structure in shared memory. Each tailq
+ * in shared memory. Each tailq
  * is identified by name.
  * Any library storing a set of objects e.g. rings, mempools, hash-tables,
  * is recommended to use an entry here, so as to make it easy for
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index c24d02f646..270393f468 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -225,7 +225,7 @@ rte_eal_config_create(void)
 	rte_mem_cfg_addr = eal_get_virtual_area(rte_mem_cfg_addr,
 			&cfg_len_aligned, page_sz, 0, 0);
 	if (rte_mem_cfg_addr == NULL) {
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config");
+		EAL_LOG(ERR, "Cannot mmap shared memory config");
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
 		return -1;
@@ -239,7 +239,7 @@ rte_eal_config_create(void)
 		munmap(rte_mem_cfg_addr, cfg_len);
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
-		EAL_LOG(ERR, "Cannot remap memory for rte_config");
+		EAL_LOG(ERR, "Cannot remap shared memory config");
 		return -1;
 	}
 
@@ -283,7 +283,7 @@ rte_eal_config_attach(void)
 	if (mem_config == MAP_FAILED) {
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config! error %i (%s)",
+		EAL_LOG(ERR, "Cannot mmap shared memory config! error %i (%s)",
 			errno, strerror(errno));
 		return -1;
 	}
@@ -323,12 +323,12 @@ rte_eal_config_reattach(void)
 	if (mem_config == MAP_FAILED || mem_config != rte_mem_cfg_addr) {
 		if (mem_config != MAP_FAILED) {
 			/* errno is stale, don't use */
-			EAL_LOG(ERR, "Cannot mmap memory for rte_config at [%p], got [%p] - please use '--base-virtaddr' option",
+			EAL_LOG(ERR, "Cannot mmap shared memory config at [%p], got [%p] - please use '--base-virtaddr' option",
 				 rte_mem_cfg_addr, mem_config);
 			munmap(mem_config, sizeof(struct rte_mem_config));
 			return -1;
 		}
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config! error %i (%s)",
+		EAL_LOG(ERR, "Cannot mmap shared memory config! error %i (%s)",
 			errno, strerror(errno));
 		return -1;
 	}
@@ -364,9 +364,9 @@ eal_proc_type_detect(void)
 	return ptype;
 }
 
-/* Sets up rte_config structure with the pointer to shared memory config.*/
+/* Attaches to or creates the shared memory config for this process. */
 static int
-rte_config_init(void)
+eal_mem_config_init(void)
 {
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
@@ -640,7 +640,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (rte_config_init() < 0) {
+	if (eal_mem_config_init() < 0) {
 		rte_eal_init_alert("Cannot init config");
 		goto err_out;
 	}
@@ -728,7 +728,7 @@ rte_eal_init(int argc, char **argv)
 		rte_eal_iova_mode() == RTE_IOVA_PA ? "PA" : "VA");
 
 	if (!user_cfg->no_hugetlbfs) {
-		/* rte_config isn't initialized yet */
+		/* shared mem config not yet attached */
 		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
 				eal_hugepage_info_init() :
 				eal_hugepage_info_read();
-- 
2.53.0

