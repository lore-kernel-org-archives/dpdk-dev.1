Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC8C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E28EF410F6;
	Tue, 21 Jul 2026 11:46:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id CE84040EF0
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627201; x=1816163201;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ArPYJfD2EZsdUS9hz4WfbfnfSnlvugFIF/Aoe/z8VAM=;
 b=U/B8sXJx6/8oRrxcDqIU49V+J4mHHFw4U3q584If+Ds4yUmFQ+ebaBTc
 yXLcNDJo+ovlVovEO2+idvcYTaTnwDJtmpFtMeKJRq3jyBTMcOhhacoad
 qfPkrPo2JsQgVkewJ/hs/XqoDlgNCfe03I6fw78N5Sg4idGREfk4aGStx
 t+6ZTzA3o+T076PHnvCY6ldhNYe6HZq80Yr35QnGGTk/CpiwX1T1hoCUA
 zIQMnnGUHf3A8pZiSSBDtpoDB0YPDiM7EAtfinqlRrFmqcYS2sq05gScA
 7hWMNeW0rTB1WWzr1M4MAm9Ty1fB7tNs6rgs7VVtpYoTMzpq8+8PVQzvD w==;
X-CSE-ConnectionGUID: 8IdlWPhYSoStyjRFMfeSbQ==
X-CSE-MsgGUID: ekDCBHM5R2WBWkdw529Etg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872522"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872522"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:40 -0700
X-CSE-ConnectionGUID: ailNq7I/R2OqSmCcc5301Q==
X-CSE-MsgGUID: AISho6oUQXqzMl9JW9pB+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922473"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 37/39] eal: add utilities for working with user config struct
Date: Tue, 21 Jul 2026 10:45:45 +0100
Message-ID: <20260721094555.2188496-38-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
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
index 6e6e6f86e2..120ce37a47 100644
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

