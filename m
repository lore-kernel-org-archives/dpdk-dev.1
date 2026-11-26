Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB4606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lkTbU6fU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE46A40E12;
	Thu, 26 Nov 2026 19:15:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id A614B40DD7
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716921; x=1827252921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4PDBCEtfkH3sfsDhCdLMMa7lfj3wP8NNPhfo4UYlOco=;
 b=lkTbU6fU42JRL95BUWZkDWf66Rg/adFo502W43WvYxfAcXFWfc8w7Y05
 goJkWfaPL9HFMiob4zMYs/P5I3hu7ysOdqEhcIFTVoWQLNEvsGgXDMP4G
 f8ty7AmF/1C3F2w+HleGNrZPlGmbyeq3srlFitYSu+x+vfTWM5yfLQNJG
 mY4rjpOcagXSDoqA3s1iaVjZI0WqhxK2+UGOpVs/30PN0t1lBRIxFts9o
 jrlw1klAxZPONyFnz2cEx8TnHdIfvxsIosMohJT9AKdhZWsmm5ECPljI7
 f1A9i4VCMs1rxPpBMBFW6gC0CfdCnQstKc/7T2y2zgZAr2o9HCFW0rOMg Q==;
X-CSE-ConnectionGUID: /REnQ4ckQsihcrT/Qcvz1Q==
X-CSE-MsgGUID: pSE7ysFPSa63cU200du2iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633618"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:21 -0800
X-CSE-ConnectionGUID: hec3WQLZQ7ub4ocmFdDxZg==
X-CSE-MsgGUID: LsGTT1puQ9qqlphtAYHYJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733110"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 26/39] eal: move device options staging list into user cfg
Date: Thu, 26 Nov 2026 18:13:59 +0000
Message-ID: <20261126181414.124094-27-bruce.richardson@intel.com>
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

The file-static devopt_list in eal_common_options.c holds device options
(-a/-b/--vdev) staged during arg parsing for later consumption by
eal_option_device_parse(). Rather than holding this as file local static
data, store it in the user_cfg struct.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 21 ++++++---------------
 lib/eal/common/eal_internal_cfg.h   | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index ea49a44218..1369f75be7 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -305,18 +305,6 @@ static const char *default_solib_dir = RTE_EAL_PMD_PATH;
 RTE_PMD_EXPORT_SYMBOL(const char, dpdk_solib_path)[] =
 "DPDK_PLUGIN_PATH=" RTE_EAL_PMD_PATH;
 
-TAILQ_HEAD(device_option_list, device_option);
-
-struct device_option {
-	TAILQ_ENTRY(device_option) next;
-
-	enum rte_devtype type;
-	char arg[];
-};
-
-static struct device_option_list devopt_list =
-TAILQ_HEAD_INITIALIZER(devopt_list);
-
 /* Returns rte_usage_hook_t */
 rte_usage_hook_t
 eal_get_application_usage_hook(void)
@@ -454,6 +442,7 @@ eal_clean_saved_args(void)
 static int
 eal_option_device_add(enum rte_devtype type, const char *arg)
 {
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct device_option *devopt;
 	size_t arglen;
 	int ret;
@@ -472,25 +461,26 @@ eal_option_device_add(enum rte_devtype type, const char *arg)
 		free(devopt);
 		return -EINVAL;
 	}
-	TAILQ_INSERT_TAIL(&devopt_list, devopt, next);
+	TAILQ_INSERT_TAIL(&user_cfg->devopt_list, devopt, next);
 	return 0;
 }
 
 int
 eal_option_device_parse(void)
 {
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct device_option *devopt;
 	void *tmp;
 	int ret = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(devopt, &devopt_list, next, tmp) {
+	RTE_TAILQ_FOREACH_SAFE(devopt, &user_cfg->devopt_list, next, tmp) {
 		if (ret == 0) {
 			ret = rte_devargs_add(devopt->type, devopt->arg);
 			if (ret)
 				EAL_LOG(ERR, "Unable to parse device '%s'",
 					devopt->arg);
 		}
-		TAILQ_REMOVE(&devopt_list, devopt, next);
+		TAILQ_REMOVE(&user_cfg->devopt_list, devopt, next);
 		free(devopt);
 	}
 	return ret;
@@ -514,6 +504,7 @@ eal_reset_internal_config(void)
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 	int i;
 
+	TAILQ_INIT(&user_cfg->devopt_list);
 	user_cfg->memory = 0;
 	user_cfg->force_nrank = 0;
 	user_cfg->force_nchannel = 0;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 550489829f..578de5184f 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -10,6 +10,9 @@
 #ifndef EAL_INTERNAL_CFG_H
 #define EAL_INTERNAL_CFG_H
 
+#include <sys/queue.h>
+
+#include <rte_devargs.h>
 #include <rte_eal.h>
 #include <rte_os_shim.h>
 #include <rte_pci_dev_feature_defs.h>
@@ -61,11 +64,23 @@ struct hugepage_file_discipline {
 	bool unlink_existing;
 };
 
+/**
+ * A single device option (-a/-b/--vdev) staged during arg parsing.
+ * Lives in user_cfg->devopt_list; drained by eal_option_device_parse().
+ */
+struct device_option {
+	TAILQ_ENTRY(device_option) next;
+	enum rte_devtype type;
+	char arg[];
+};
+TAILQ_HEAD(eal_devopt_list, device_option);
+
 /**
  * User-provided EAL initialization configuration.
  * Immutable after initialization, so no need for atomic types or locks.
  */
 struct eal_user_cfg {
+	struct eal_devopt_list devopt_list; /**< staged device options (-a/-b/--vdev) */
 	size_t memory;           /**< amount of asked memory */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
 	enum rte_proc_type_t process_type; /**< requested process type */
-- 
2.55.0

