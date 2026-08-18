Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF86BC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:36:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 815E940E3A;
	Tue, 18 Aug 2026 15:34:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 801AD40E17
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060050; x=1818596050;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lesV+DT4eaqxb4Tsdd1M1tPd8EnVdX+ckGvEatvTys0=;
 b=Y44WPh6CdHj0CJkFMaF1aXIfeUUPvqUZoPQwt1kTc1U0VYN7TPTleMXc
 lw1ThKJCM8dqcvIDPZ1pW9rTMjh61t+opwApSfLXvBydh0qqsDoiGAgLB
 7LbSzKdyKRbQRAYXxc+gSWz24SsBrN4C+9R2VsUn5o7jVDBAzlkB1Ac0E
 +fDFAKNoOOugVXJc6nL42Opec94Y2eJwtuJADM+bkN1JrQ/UdR/2Ql1xQ
 hggIKXGxfpLRcFQGQB1Kktv5CRUqJ+Ai/2i11aAB+nbJPXcWaLdfpDwsy
 LCD9D+j20AX/XoO0y5iUALF5tShFsP9gJHCWB/GQaf/tHP1weBt2N6gCl w==;
X-CSE-ConnectionGUID: qBkpSNZZRoGl80OveQLeBQ==
X-CSE-MsgGUID: eS2ZkxQdR/e3lexsTsJqyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757668"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757668"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:34:09 -0700
X-CSE-ConnectionGUID: e1q0aeBiQYeQ+mkxD3tl3A==
X-CSE-MsgGUID: qwIpoV6/QKKZAk4EkuDaMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736740"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:34:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 26/39] eal: move device options staging list into user cfg
Date: Tue, 18 Aug 2026 14:33:19 +0100
Message-ID: <20260818133334.2620165-27-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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
index f733512aec..1bc6731fba 100644
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
index 606ef65bc0..b0052da4bf 100644
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
@@ -55,11 +58,23 @@ struct hugepage_file_discipline {
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
2.53.0

