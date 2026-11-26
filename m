Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20616606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FneQV3bA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0378440E64;
	Thu, 26 Nov 2026 19:15:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 2F00A40E0B
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716933; x=1827252933;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nqnsfXuDaYG7LlBrK5zy4Y7vxPxydBvzHfPw3IURDPM=;
 b=FneQV3bAm0RjVTWoCgWG+DFdslSVViNzH28bOLGQnRuhTAXSAfPX3JsG
 RXmQWzM/3dCl99Q0s48peNXS2uZAF2NROn7gK9l6XRiVKKaFNEQtr6J4L
 906a2HrJsE+tQlC4BPG2gCtJKzi7mG044rVJHRgntOSBwHN8ClsmJTyxV
 wJV3U/iL6PVbZULYe8C47ZNBfAEXiaRgYpHN/XYb5KSv91P2ZepEGey10
 tDdHozmyznZTnQTa82CVDzqxg2QA9puTpFLes1nxMvuGI5jVNBuyVOtO5
 cdQi+aXX0RNRbLHGG8n4jooh+ZY+yn3YEGX5I+kJUBJT05excK7V5iUTw w==;
X-CSE-ConnectionGUID: 9m+8QqMmSp2PvCTPLk0Sig==
X-CSE-MsgGUID: pC+IoMmWQZi1KUJSYwRrGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633643"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633643"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:31 -0800
X-CSE-ConnectionGUID: 7Xx0SX+zREmJv6VPWMwMUA==
X-CSE-MsgGUID: tD2eFHsURaaBUXVk5PFaSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733174"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:30 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 37/39] eal: add utilities for working with user config
 struct
Date: Thu, 26 Nov 2026 18:14:10 +0000
Message-ID: <20261126181414.124094-38-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index bdf5a8b03d..7590ad9c8c 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1910,17 +1910,7 @@ eal_parse_args(void)
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
index 6dcf2c55a7..935d322345 100644
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
 
@@ -99,6 +101,8 @@ TAILQ_HEAD(eal_devopt_list, device_option);
 /**
  * User-provided EAL initialization configuration.
  * Immutable after initialization, so no need for atomic types or locks.
+ *
+ * NOTE: On modify, always update the initializer, copy, and cleanup functions below.
  */
 struct eal_user_cfg {
 	struct eal_devopt_list devopt_list; /**< staged device options (-a/-b/--vdev) */
@@ -154,6 +158,154 @@ struct eal_user_cfg {
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
2.55.0

