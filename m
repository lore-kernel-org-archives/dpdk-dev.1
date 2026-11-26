Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B4606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mIsWgiB2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FDDF40A6B;
	Thu, 26 Nov 2026 19:15:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id D2B2440DD1
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716921; x=1827252921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ge9tJH4yrwk8fhVkURZQSSvHxPwaZ/JWuFbNaUE/m1Q=;
 b=mIsWgiB2dIGtQ0rCgvkE9WPw+heUlI27E9oPH3fb9WFYGvNNWX/rBrdo
 cEGxV+aDMljkY06Aeo34jgPAu4nqjFrqSOIezL5rtQrDFQ0AJaxIMzeYr
 N5QBg/b8UnFfPtX1Vio4MJCywdVGzLWEVZ1EN036scQFZ5yCCQfpjnlam
 T2X/IDxeka6qsORP8oBxIf4DqWFahNDNzePXiiYA4R7/EnxQLU+vYxWsQ
 Rev6me65aXKRSVJdZbF9bNH0RBBQAYpJTB/o9etNnAv0or1cf+07DCva1
 uWplqS0FN/YSiLHzXkz05590p9BFEPfrTFlBlMjAeKlAFUaPl8vRr1ek+ Q==;
X-CSE-ConnectionGUID: tLTWqhbHSBq4xhOC/Xt9Mg==
X-CSE-MsgGUID: OhJuL2zsQ0KXPHWzZnHwpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633616"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633616"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:19 -0800
X-CSE-ConnectionGUID: QQE06UpBSamrgfEk73Covw==
X-CSE-MsgGUID: ePtAVZPbRFyDUehqxeWYcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733096"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 24/39] eal: remove rte_config structure
Date: Thu, 26 Nov 2026 18:13:57 +0000
Message-ID: <20261126181414.124094-25-bruce.richardson@intel.com>
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
index c7c600fa13..798e60a359 100644
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
index 6714699828..18333071de 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -144,7 +144,7 @@ rte_eal_config_create(void)
 	rte_mem_cfg_addr = eal_get_virtual_area(rte_mem_cfg_addr,
 			&cfg_len_aligned, page_sz, 0, 0);
 	if (rte_mem_cfg_addr == NULL) {
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config");
+		EAL_LOG(ERR, "Cannot mmap shared memory config");
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
 		return -1;
@@ -155,7 +155,7 @@ rte_eal_config_create(void)
 			cfg_len_aligned, PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_FIXED, mem_cfg_fd, 0);
 	if (mapped_mem_cfg_addr == MAP_FAILED) {
-		EAL_LOG(ERR, "Cannot remap memory for rte_config: %s", strerror(errno));
+		EAL_LOG(ERR, "Cannot remap shared memory config: %s", strerror(errno));
 		munmap(rte_mem_cfg_addr, cfg_len);
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
@@ -200,7 +200,7 @@ rte_eal_config_attach(void)
 	if (rte_mem_cfg_addr == MAP_FAILED) {
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config! error %i (%s)",
+		EAL_LOG(ERR, "Cannot mmap shared memory config! error %i (%s)",
 			errno, strerror(errno));
 		return -1;
 	}
@@ -238,12 +238,12 @@ rte_eal_config_reattach(void)
 
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
@@ -279,9 +279,9 @@ eal_proc_type_detect(void)
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
@@ -484,7 +484,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (rte_config_init() < 0) {
+	if (eal_mem_config_init() < 0) {
 		rte_eal_init_alert("Cannot init config");
 		goto err_out;
 	}
@@ -563,7 +563,7 @@ rte_eal_init(int argc, char **argv)
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
index 2b02d984e9..7f8010b61d 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -222,7 +222,7 @@ rte_eal_config_create(void)
 	rte_mem_cfg_addr = eal_get_virtual_area(rte_mem_cfg_addr,
 			&cfg_len_aligned, page_sz, 0, 0);
 	if (rte_mem_cfg_addr == NULL) {
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config");
+		EAL_LOG(ERR, "Cannot mmap shared memory config");
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
 		return -1;
@@ -236,7 +236,7 @@ rte_eal_config_create(void)
 		munmap(rte_mem_cfg_addr, cfg_len);
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
-		EAL_LOG(ERR, "Cannot remap memory for rte_config");
+		EAL_LOG(ERR, "Cannot remap shared memory config");
 		return -1;
 	}
 
@@ -280,7 +280,7 @@ rte_eal_config_attach(void)
 	if (mem_config == MAP_FAILED) {
 		close(mem_cfg_fd);
 		mem_cfg_fd = -1;
-		EAL_LOG(ERR, "Cannot mmap memory for rte_config! error %i (%s)",
+		EAL_LOG(ERR, "Cannot mmap shared memory config! error %i (%s)",
 			errno, strerror(errno));
 		return -1;
 	}
@@ -320,12 +320,12 @@ rte_eal_config_reattach(void)
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
@@ -361,9 +361,9 @@ eal_proc_type_detect(void)
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
@@ -637,7 +637,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (rte_config_init() < 0) {
+	if (eal_mem_config_init() < 0) {
 		rte_eal_init_alert("Cannot init config");
 		goto err_out;
 	}
@@ -735,7 +735,7 @@ rte_eal_init(int argc, char **argv)
 		rte_eal_iova_mode() == RTE_IOVA_PA ? "PA" : "VA");
 
 	if (!user_cfg->no_hugetlbfs) {
-		/* rte_config isn't initialized yet */
+		/* shared mem config not yet attached */
 		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
 				eal_hugepage_info_init() :
 				eal_hugepage_info_read();
-- 
2.55.0

