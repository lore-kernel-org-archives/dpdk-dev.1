Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF8FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:02:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 453C140EDD;
	Wed, 29 Apr 2026 18:59:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 27B324066E;
 Wed, 29 Apr 2026 18:59:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481966; x=1809017966;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iV0lzGSdkHfaXMSiohezI0FVPu8SjWUqXsDeV1mKoC0=;
 b=Xw1YXbBghL+KISOyR1qhc3yH1tcOyUZpJ7v30tY5BNemscXUBUwHGipc
 JB1TqKqIHQHUYPzlzLsvzlUWm6MJQxL4Bbuf3Y2zXL/hzR0kEssv3ODrK
 65gNV2pdA5SKJKdlcb5FZSIqe236TzBtf2HAum83cK5CwCTheZmxian8m
 TU0tzSj58VXifaJRNUPJK0+viqx4W3J4ZM/l8WmB3D36IS7x8YCmKpc5J
 P+GIE+wj447w/82g11e7QDzb+SY/UnTAaW6j2l/gCeQMN4IYFStHHXLzk
 BoDdyCZvg/1PxzPRzvLP/jgd7ABqoEcx2r88Mq0iOjR2IMBr9JZn22Uzp Q==;
X-CSE-ConnectionGUID: /sNaTcrOT1SWmg7w4UTw/w==
X-CSE-MsgGUID: pJBquclaSEKIdMOYG9ECug==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725337"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725337"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:25 -0700
X-CSE-ConnectionGUID: EoscfQncTNOGCQA53J6OHg==
X-CSE-MsgGUID: lKVSqr6uSFqxIWCtzZyzDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697011"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 23/44] eal: move devopt_list staging list into user_cfg
Date: Wed, 29 Apr 2026 17:58:15 +0100
Message-ID: <20260429165845.2136843-24-bruce.richardson@intel.com>
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

The file-static devopt_list in eal_common_options.c holds device
options (-a/-b/--vdev) staged during arg parsing for later consumption
by eal_option_device_parse(). Rather than holding this data as statics,
store it in the user_cfg struct.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 21 ++++++---------------
 lib/eal/common/eal_internal_cfg.h   | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index dc6f4643c4..71fc69e80d 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -289,18 +289,6 @@ static const char *default_solib_dir = RTE_EAL_PMD_PATH;
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
@@ -438,6 +426,7 @@ eal_clean_saved_args(void)
 static int
 eal_option_device_add(enum rte_devtype type, const char *arg)
 {
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct device_option *devopt;
 	size_t arglen;
 	int ret;
@@ -456,25 +445,26 @@ eal_option_device_add(enum rte_devtype type, const char *arg)
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
@@ -498,6 +488,7 @@ eal_reset_internal_config(void)
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int i;
 
+	TAILQ_INIT(&user_cfg->devopt_list);
 	user_cfg->memory = 0;
 	user_cfg->force_nrank = 0;
 	user_cfg->force_nchannel = 0;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 47af403c27..4decc26d2c 100644
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
@@ -54,11 +57,23 @@ struct hugepage_file_discipline {
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
2.51.0

