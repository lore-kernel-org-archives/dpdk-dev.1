Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FBBC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:38:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D753A40EE7;
	Tue, 18 Aug 2026 15:34:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1A39B40ECF
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060061; x=1818596061;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sAS0SKFpeC0YKRgp8c3pDDeRzafVMRpPb+srvJEZf7s=;
 b=Yqya7j9aF+G/XG7AxVbdVkt1Rn5jXUII1Ktosal/Oz/WMGm0yBb9RhCr
 8zLG+q9AGfrqzUhZ2Rxtpl6r7SKGojxKHTpyDmwvW89Pr0q5dS1CoaWe/
 6rbVx57ndaGtPKSUgQdrrjTB9TNG/C3tk59Cu3gjk1xrORxs7nhwQPDSG
 OFS36L/goAgjCA9aKrt0FCRH8fClyNyMSpYUOZJFRMi7ktmfB7Lt/PHMv
 l9pDJ+4XsDv1j+db4vzSbYDluKIJ8oraVvvTyFAHa+I7b9h0CkVX9znee
 EbRuAKdRxUE7OBw9xGPxjh/IOM6dwhPY/Bgsk4j1FFVSp8fLHS3spRz8E w==;
X-CSE-ConnectionGUID: wtatIEqDTGq3AzsrTcFLmA==
X-CSE-MsgGUID: 34en/2C7S6uFHWGd/I0tVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757701"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757701"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:34:20 -0700
X-CSE-ConnectionGUID: dIK4QwYeQvCLXEZe12ki9A==
X-CSE-MsgGUID: 18dN1OejRzuE++qJx0Ux8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736797"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:34:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 37/39] eal: add utilities for working with user config
 struct
Date: Tue, 18 Aug 2026 14:33:30 +0100
Message-ID: <20260818133334.2620165-38-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since the user-config struct has tailqs elements, string elements and
variable length arrays it cannot be initialized via a simple "= {0}" and
copy and cleanup requires looping through the various non-basic
elements. Add functions below the struct definitions to handle these
tasks correctly, adding a comment on the struct to remind any future
editors to also adjust the functions if necessary.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c |  12 +--
 lib/eal/common/eal_internal_cfg.h   | 152 ++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 11 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 08a3984b7e..39dbc67f1f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1911,17 +1911,7 @@ eal_parse_args(void)
 	 * false or NULL, which is the correct default (RTE_PROC_PRIMARY,
 	 * RTE_INTR_MODE_NONE, RTE_IOVA_DC, etc. are all defined as 0).
 	 */
-	*user_cfg = (struct eal_user_cfg){
-		.devopt_list = TAILQ_HEAD_INITIALIZER(user_cfg->devopt_list),
-		.plugin_list = TAILQ_HEAD_INITIALIZER(user_cfg->plugin_list),
-		.trace_patterns = STAILQ_HEAD_INITIALIZER(user_cfg->trace_patterns),
-		.hugepage_file.unlink_existing = true,
-		.main_lcore = -1,
-#ifndef RTE_LIBEAL_USE_HPET
-		.no_hpet = true,
-#endif
-		.max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH,
-	};
+	*user_cfg = EAL_USER_CFG_INITIALIZER(*user_cfg);
 
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index daf7f8e92b..0c4254f1e9 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -10,6 +10,7 @@
 #ifndef EAL_INTERNAL_CFG_H
 #define EAL_INTERNAL_CFG_H
 
+#include <stdlib.h>
 #include <sys/queue.h>
 
 #include <rte_devargs.h>
@@ -17,6 +18,7 @@
 #include <rte_os_shim.h>
 #include <rte_pci_dev_feature_defs.h>
 #include <rte_trace.h>
+#include <rte_vect.h>
 #include <stdint.h>
 #include <stdbool.h>
 
@@ -93,6 +95,8 @@ TAILQ_HEAD(eal_devopt_list, device_option);
 /**
  * User-provided EAL initialization configuration.
  * Immutable after initialization, so no need for atomic types or locks.
+ *
+ * NOTE: On modify, always update the initializer, copy, and cleanup functions below.
  */
 struct eal_user_cfg {
 	struct eal_devopt_list devopt_list; /**< staged device options (-a/-b/--vdev) */
@@ -148,6 +152,154 @@ struct eal_user_cfg {
 	int            main_lcore;    /**< ID of the main lcore */
 };
 
+#ifdef RTE_LIBEAL_USE_HPET
+#define EAL_NO_HPET_DEFAULT false
+#else
+#define EAL_NO_HPET_DEFAULT true
+#endif
+
+#define EAL_USER_CFG_INITIALIZER(self) (struct eal_user_cfg){ \
+	.devopt_list = TAILQ_HEAD_INITIALIZER((self).devopt_list), \
+	.plugin_list = TAILQ_HEAD_INITIALIZER((self).plugin_list), \
+	.trace_patterns = STAILQ_HEAD_INITIALIZER((self).trace_patterns), \
+	.hugepage_file.unlink_existing = true, \
+	.main_lcore = -1, \
+	.no_hpet = EAL_NO_HPET_DEFAULT, \
+	.max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH, \
+}
+
+static inline void
+eal_user_cfg_cleanup(struct eal_user_cfg *cfg)
+{
+	while (!TAILQ_EMPTY(&cfg->devopt_list)) {
+		struct device_option *devopt = TAILQ_FIRST(&cfg->devopt_list);
+		TAILQ_REMOVE(&cfg->devopt_list, devopt, next);
+		free(devopt);
+	}
+
+	while (!TAILQ_EMPTY(&cfg->plugin_list)) {
+		struct eal_plugin_path *p = TAILQ_FIRST(&cfg->plugin_list);
+		TAILQ_REMOVE(&cfg->plugin_list, p, next);
+		free(p);
+	}
+
+	while (!STAILQ_EMPTY(&cfg->trace_patterns)) {
+		struct eal_trace_arg *ta = STAILQ_FIRST(&cfg->trace_patterns);
+		STAILQ_REMOVE_HEAD(&cfg->trace_patterns, next);
+		free(ta->val);
+		free(ta);
+	}
+
+	free(cfg->trace_dir);
+	cfg->trace_dir = NULL;
+	free(cfg->hugefile_prefix);
+	cfg->hugefile_prefix = NULL;
+	free(cfg->hugepage_dir);
+	cfg->hugepage_dir = NULL;
+	free(cfg->user_mbuf_pool_ops_name);
+	cfg->user_mbuf_pool_ops_name = NULL;
+
+	for (unsigned int i = 0; i < RTE_MAX_LCORE; i++) {
+		free(cfg->lcore_cpusets[i]);
+		cfg->lcore_cpusets[i] = NULL;
+	}
+}
+
+static inline int
+eal_user_cfg_copy(struct eal_user_cfg *dst, const struct eal_user_cfg *src)
+{
+
+	/* copy all scalar/fixed-size fields */
+	*dst = *src;
+
+	/* re-initialise list heads — the shallow copy above has stale pointers */
+	TAILQ_INIT(&dst->devopt_list);
+	TAILQ_INIT(&dst->plugin_list);
+	STAILQ_INIT(&dst->trace_patterns);
+
+	/* zero heap string pointers so cleanup is safe on partial failure */
+	dst->trace_dir = NULL;
+	dst->hugefile_prefix = NULL;
+	dst->hugepage_dir = NULL;
+	dst->user_mbuf_pool_ops_name = NULL;
+	for (unsigned int i = 0; i < RTE_MAX_LCORE; i++)
+		dst->lcore_cpusets[i] = NULL;
+
+	/* deep-copy device option list (device_option has a flexible array member) */
+	struct device_option *devopt, *devopt_copy;
+	TAILQ_FOREACH(devopt, &src->devopt_list, next) {
+		size_t arglen = strlen(devopt->arg) + 1;
+		devopt_copy = calloc(1, sizeof(*devopt_copy) + arglen);
+		if (devopt_copy == NULL)
+			goto err;
+		devopt_copy->type = devopt->type;
+		memcpy(devopt_copy->arg, devopt->arg, arglen);
+		TAILQ_INSERT_TAIL(&dst->devopt_list, devopt_copy, next);
+	}
+
+	/* deep-copy plugin path list */
+	struct eal_plugin_path *p, *p_copy;
+	TAILQ_FOREACH(p, &src->plugin_list, next) {
+		p_copy = malloc(sizeof(*p_copy));
+		if (p_copy == NULL)
+			goto err;
+		memcpy(p_copy->name, p->name, sizeof(p_copy->name));
+		TAILQ_INSERT_TAIL(&dst->plugin_list, p_copy, next);
+	}
+
+	/* deep-copy trace pattern list */
+	struct eal_trace_arg *ta, *ta_copy;
+	STAILQ_FOREACH(ta, &src->trace_patterns, next) {
+		ta_copy = malloc(sizeof(*ta_copy));
+		if (ta_copy == NULL)
+			goto err;
+		ta_copy->val = strdup(ta->val);
+		if (ta_copy->val == NULL) {
+			free(ta_copy);
+			goto err;
+		}
+		STAILQ_INSERT_TAIL(&dst->trace_patterns, ta_copy, next);
+	}
+
+	/* deep-copy heap strings */
+	if (src->trace_dir != NULL) {
+		dst->trace_dir = strdup(src->trace_dir);
+		if (dst->trace_dir == NULL)
+			goto err;
+	}
+	if (src->hugefile_prefix != NULL) {
+		dst->hugefile_prefix = strdup(src->hugefile_prefix);
+		if (dst->hugefile_prefix == NULL)
+			goto err;
+	}
+	if (src->hugepage_dir != NULL) {
+		dst->hugepage_dir = strdup(src->hugepage_dir);
+		if (dst->hugepage_dir == NULL)
+			goto err;
+	}
+	if (src->user_mbuf_pool_ops_name != NULL) {
+		dst->user_mbuf_pool_ops_name = strdup(src->user_mbuf_pool_ops_name);
+		if (dst->user_mbuf_pool_ops_name == NULL)
+			goto err;
+	}
+
+	/* deep-copy per-lcore cpusets */
+	for (unsigned int i = 0; i < RTE_MAX_LCORE; i++) {
+		if (src->lcore_cpusets[i] == NULL)
+			continue;
+		dst->lcore_cpusets[i] = malloc(sizeof(rte_cpuset_t));
+		if (dst->lcore_cpusets[i] == NULL)
+			goto err;
+		*dst->lcore_cpusets[i] = *src->lcore_cpusets[i];
+	}
+
+	return 0;
+
+err:
+	eal_user_cfg_cleanup(dst);
+	return -1;
+}
+
 /**
  * Hardware facts about a single physical CPU, populated during CPU discovery.
  * Indexed by physical CPU ID (not DPDK lcore ID).
-- 
2.53.0

