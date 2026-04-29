Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E20ECCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:04:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00B644111C;
	Wed, 29 Apr 2026 18:59:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3EB7A40A70;
 Wed, 29 Apr 2026 18:59:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481988; x=1809017988;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4hD4gtT2YAbUCpEUR1eHOeiZyWt6gp+fdsX0s5tADDI=;
 b=bMGTeJeoFkEBELLblKjpsvWgcHe2W0d/rcQoP4oz7BsMN/uf2xFGGZ9M
 hf22DNjmTx78Iyelwl/TXxymdiKOyELjZgqSzp78DYUVl8nL+OuISIEqj
 T2mMKYzHr2dv/UMkgPZEvS/xHi/l6TYsZON4cj+A/EMtwadjLXs6aa3ko
 nROiIbvXkLgkn1zaXSJCT7tnbro5M3lVF41t/85lZdOcJK7y5Pi2D7MNN
 mHFecYakeDCfL+IL0uGPt+4xLl2PN5JFZWCBmtJRPI31KmMJEC7tI8wqS
 FbkxoDJUErmblyugSzpCA7Qaj4QKRoKMqwbB7AG6itxnxfiAcnWEBRzqd Q==;
X-CSE-ConnectionGUID: e25KdxRcRpqWOWwSdo/5zw==
X-CSE-MsgGUID: +DUtraOBTfu5aNmnXX3UKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725392"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725392"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:47 -0700
X-CSE-ConnectionGUID: kY/Ocf6uQa+ozyOTydsRXw==
X-CSE-MsgGUID: 3rK3v2+YS+yJfX9iNrDWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697222"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:46 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 38/44] eal_cfg: configure defaults for easier testing and
 use
Date: Wed, 29 Apr 2026 17:58:30 +0100
Message-ID: <20260429165845.2136843-39-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

Add a function to configure the lcore settings with the current thread
affinities. Use that function when EAL is being initialized without any
lcores otherwise being specified. This minics existing DPDK behaviour
when no "-l" or "-c" flags are passed on EAL commandline. Also set the
"in-memory" flag by default, which makes testing easier, and should be a
sensible default for most app cases except when multi-process is
required.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal_cfg/eal_cfg.c     | 91 ++++++++++++++++++++++++++++++++++++---
 lib/eal_cfg/rte_eal_cfg.h | 48 ++++++++++++++++++++-
 2 files changed, 133 insertions(+), 6 deletions(-)

diff --git a/lib/eal_cfg/eal_cfg.c b/lib/eal_cfg/eal_cfg.c
index 70f0122b81..18a508e7ad 100644
--- a/lib/eal_cfg/eal_cfg.c
+++ b/lib/eal_cfg/eal_cfg.c
@@ -7,7 +7,9 @@
 
 #include <eal_export.h>
 #include <rte_errno.h>
+#include <rte_lcore.h>
 #include <rte_log.h>
+#include <rte_thread.h>
 
 #include "eal_internal_cfg.h"
 #include "rte_eal_cfg.h"
@@ -29,6 +31,9 @@ rte_eal_cfg_create(void)
 	}
 
 	cfg->user_cfg = EAL_USER_CFG_INITIALIZER(cfg->user_cfg);
+	/* default to in-memory mode without a shared config */
+	cfg->user_cfg.in_memory = true;
+	cfg->user_cfg.no_shconf = true;
 
 	return cfg;
 }
@@ -44,21 +49,97 @@ rte_eal_cfg_free(struct rte_eal_cfg *cfg)
 	free(cfg);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_lcores_from_affinity, 26.07)
+int
+rte_eal_cfg_set_lcores_from_affinity(struct rte_eal_cfg *cfg, bool remap)
+{
+	rte_cpuset_t cpuset;
+	unsigned int lcore_id = 0;
+	int count = 0;
+
+	if (cfg == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (rte_thread_get_affinity_by_id(rte_thread_self(), &cpuset) != 0) {
+		rte_errno = ENOTSUP;
+		return -1;
+	}
+
+	/* clear any existing lcore configuration before populating */
+	for (unsigned int i = 0; i < RTE_MAX_LCORE; i++) {
+		free(cfg->user_cfg.lcore_cpusets[i]);
+		cfg->user_cfg.lcore_cpusets[i] = NULL;
+	}
+
+	for (unsigned int cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, &cpuset))
+			continue;
+		if (!remap)
+			lcore_id = cpu;
+		if (lcore_id >= RTE_MAX_LCORE)
+			break;
+		cfg->user_cfg.lcore_cpusets[lcore_id] = malloc(sizeof(rte_cpuset_t));
+		if (cfg->user_cfg.lcore_cpusets[lcore_id] == NULL) {
+			for (unsigned int i = 0; i < lcore_id; i++) {
+				free(cfg->user_cfg.lcore_cpusets[i]);
+				cfg->user_cfg.lcore_cpusets[i] = NULL;
+			}
+			rte_errno = ENOMEM;
+			return -1;
+		}
+		CPU_ZERO(cfg->user_cfg.lcore_cpusets[lcore_id]);
+		CPU_SET(cpu, cfg->user_cfg.lcore_cpusets[lcore_id]);
+		count++;
+		lcore_id++;
+	}
+
+	if (count == 0) {
+		rte_errno = ENOTSUP;
+		return -1;
+	}
+
+	return 0;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_init_from_cfg, 26.07)
 int
 rte_eal_init_from_cfg(const char *progname, struct rte_eal_cfg *cfg)
 {
-	struct rte_eal_cfg local_cfg = {
-		.user_cfg = EAL_USER_CFG_INITIALIZER(local_cfg.user_cfg),
-	};
+	unsigned int i;
 
 	if (progname == NULL || progname[0] == '\0') {
 		rte_errno = EINVAL;
 		return -1;
 	}
 
-	if (cfg == NULL)
-		cfg = &local_cfg;
+	if (cfg == NULL) {
+		struct rte_eal_cfg local_cfg = {
+			.user_cfg = EAL_USER_CFG_INITIALIZER(local_cfg.user_cfg),
+		};
+		local_cfg.user_cfg.in_memory = true;
+		local_cfg.user_cfg.no_shconf = true;
+		if (rte_eal_cfg_set_lcores_from_affinity(&local_cfg, true) < 0) {
+			eal_user_cfg_cleanup(&local_cfg.user_cfg);
+			return -1;
+		}
+
+		int ret = rte_eal_runtime_init(progname, &local_cfg.user_cfg);
+		eal_user_cfg_cleanup(&local_cfg.user_cfg);
+		return ret;
+	}
+
+	/* If no lcores have been configured, default to the current thread's
+	 * CPU affinity, matching rte_eal_init() behaviour when neither -c nor
+	 * -l is passed.
+	 */
+	for (i = 0; i < RTE_MAX_LCORE; i++) {
+		if (cfg->user_cfg.lcore_cpusets[i] != NULL)
+			break;
+	}
+	if (i == RTE_MAX_LCORE && rte_eal_cfg_set_lcores_from_affinity(cfg, true) < 0)
+		return -1;
 
 	return rte_eal_runtime_init(progname, &cfg->user_cfg);
 }
diff --git a/lib/eal_cfg/rte_eal_cfg.h b/lib/eal_cfg/rte_eal_cfg.h
index c0d316a6cb..ecabe136d8 100644
--- a/lib/eal_cfg/rte_eal_cfg.h
+++ b/lib/eal_cfg/rte_eal_cfg.h
@@ -19,6 +19,8 @@
 extern "C" {
 #endif
 
+#include <stdbool.h>
+
 #include <rte_compat.h>
 
 /**
@@ -32,6 +34,11 @@ struct rte_eal_cfg;
  * Allocates and initialises a configuration struct with default values
  * equivalent to those used when rte_eal_init() is called with no options.
  *
+ * Returned defaults include:
+ *   - empty lcore configuration (no lcores configured)
+ *   - in-memory mode enabled, which disables multi-process mode,
+ *     but allows multiple identical application instances to run concurrently.
+ *
  * @return
  *   Pointer to a new configuration handle, or NULL on failure (rte_errno set).
  */
@@ -51,13 +58,52 @@ __rte_experimental
 void
 rte_eal_cfg_free(struct rte_eal_cfg *cfg);
 
+/**
+ * Populate lcore configuration from the calling thread's CPU affinity.
+ *
+ * Queries the current thread's CPU affinity and replaces the lcore
+ * configuration in @p cfg with one DPDK lcore per CPU in the affinity
+ * set. Any existing lcore configuration in the handle is cleared before
+ * the new mapping is applied.
+ *
+ * When @p remap is false, an identity mapping is used: lcore ID equals
+ * the physical CPU number. CPUs with numbers at or above RTE_MAX_LCORE
+ * are silently skipped. This matches the behaviour of rte_eal_init()
+ * when neither -c nor -l is passed on the command line.
+ *
+ * When @p remap is true, lcore IDs are assigned sequentially starting
+ * from 0 regardless of physical CPU numbers, so CPUs above RTE_MAX_LCORE
+ * are usable as long as the total count stays within RTE_MAX_LCORE.
+ *
+ * rte_eal_init_from_cfg() calls this automatically with @p remap set to
+ * true when no lcores have been configured in the handle.
+ *
+ * @param cfg
+ *   Configuration handle created with rte_eal_cfg_create(). Must not be NULL.
+ * @param remap
+ *   If true, assign sequential lcore IDs (0, 1, 2, ...) to affinitised CPUs.
+ *   If false, use identity mapping (lcore ID == physical CPU ID).
+ * @return
+ *   0 on success, or -1 on failure (rte_errno is set to EINVAL if cfg is NULL,
+ *   ENOTSUP if the affinity could not be queried or yielded no usable CPUs,
+ *   or ENOMEM on allocation failure).
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_lcores_from_affinity(struct rte_eal_cfg *cfg, bool remap);
+
 /**
  * Initialise the EAL using a programmatic configuration handle.
  *
  * This function is a programmatic alternative to rte_eal_init().
  * The caller optionally creates a configuration handle with rte_eal_cfg_create(),
  * populates it via setter functions, and passes it to this function
- * in place of argc/argv. If @p cfg is NULL, default EAL configuration is used.
+ * in place of argc/argv.
+ *
+ * If @p cfg is NULL, default EAL configuration is used, where:
+ *   - lcores are assigned based on the current thread's CPU affinity
+ *   - in-memory mode is enabled, which disables multi-process mode,
+ *     but allows multiple identical application instances to run concurrently.
  *
  * @param progname
  *   The program name, used for logging. Must not be NULL or empty.
-- 
2.51.0

