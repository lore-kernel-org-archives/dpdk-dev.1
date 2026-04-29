Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572CBCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:03:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 784C840E54;
	Wed, 29 Apr 2026 18:59:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 056BB40A70;
 Wed, 29 Apr 2026 18:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481986; x=1809017986;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JscDSl8UlUViJpL1QZt2cIlJS8GvUJ7Naj2qHE6TMjo=;
 b=WgaV2CPRvKM4bWxowefWKACKpAoP7w4A96VPRx41YgJWVaJRX0YuCWUp
 VnhwzzFfxzDnoC1gwuXMwpoNqDEJGVEMXQic7qPjaJxZHg6rVKnuT2X5A
 A5Yqn9dKWhN7fGrFPZqIH0pmGhPkfV62mMmJ7xjROctMRGfQwxqKcsRV0
 TYTouQHktf4rntJeV0RC6AmeEfsRH3mVuSHr35rwzaew+28PDtxtSfbP+
 DrfVHZ4yoAVuBBX1LrzmvVvVInwvwZhus4M0XlGXx/URaQK613MPWHXLY
 RAvuhcQWMlCBbOqASHzQM4lU1WagGAiFeZyxTDgt869wnqkruGzn3zSze A==;
X-CSE-ConnectionGUID: mwQdQnFjThqBMpac3tiIIw==
X-CSE-MsgGUID: Cb4iaWUHS2W49D4Yb6aqsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725381"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725381"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:45 -0700
X-CSE-ConnectionGUID: 6b3+AmA9S862xeMLzcekvg==
X-CSE-MsgGUID: VXJfShqNThiuJrxOk2ONQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697198"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:38 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 34/44] eal: add utilities for working with user config
 struct
Date: Wed, 29 Apr 2026 17:58:26 +0100
Message-ID: <20260429165845.2136843-35-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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
index 605c5a59d1..32984cb8eb 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1800,17 +1800,7 @@ eal_parse_args(void)
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
index b5962d6081..31f2c2cf72 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -10,6 +10,7 @@
 #ifndef EAL_INTERNAL_CFG_H
 #define EAL_INTERNAL_CFG_H
 
+#include <malloc.h>
 #include <sys/queue.h>
 
 #include <rte_devargs.h>
@@ -17,6 +18,7 @@
 #include <rte_os_shim.h>
 #include <rte_pci_dev_feature_defs.h>
 #include <rte_trace.h>
+#include <rte_vect.h>
 #include <stdint.h>
 #include <stdbool.h>
 
@@ -92,6 +94,8 @@ TAILQ_HEAD(eal_devopt_list, device_option);
 /**
  * User-provided EAL initialization configuration.
  * Immutable after initialization, so no need for atomic types or locks.
+ *
+ * NOTE: On modify, always update the initializer, copy, and cleanup functions below.
  */
 struct eal_user_cfg {
 	struct eal_devopt_list devopt_list; /**< staged device options (-a/-b/--vdev) */
@@ -141,6 +145,154 @@ struct eal_user_cfg {
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
2.51.0

