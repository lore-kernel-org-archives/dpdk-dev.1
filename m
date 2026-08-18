Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312C3C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7903F4067B;
	Tue, 18 Aug 2026 15:33:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9F31B40269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060026; x=1818596026;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9GJg4Tz9hSS/1AWt2+qwmu/gLR7mfeAryCApReYhH+Q=;
 b=AK7csC8A6z4qwnnM+sTf8yIwsJqDpUUzk7vBV6NDApDWRuHO79OhWiUs
 KCgO+12QgTgbMrlzWLuX6M2K0LzFN26OuKe3N36aqUuLaXY62SoRb41p+
 TEd1cKKNSHBIsurpega8+/aGsb5AFV3qOb7GwFYxzIeNXOKj1C+5Q8Jym
 8JiuW0bH/0omjpvef66UAc4ijGgHk24RmTXRSf0yf+HOfgHltJrQcC7En
 tMPS8Z7OLy4MFgNQ13ZMde/YnJzlgDUi1o017NdrCJI1/VfrVQ625tfjy
 Zm/xL5IQWRIaD854kYD2pwjkSeW57iSSQHoLijcqoKNbosDEqDz0YxB3h g==;
X-CSE-ConnectionGUID: lCTLEDh0R6SqH910A7sf1Q==
X-CSE-MsgGUID: 7O1/vQ5kS9e0XUN2nv+WcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757583"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:45 -0700
X-CSE-ConnectionGUID: ef4sdL7rQtez8CqDTEURSA==
X-CSE-MsgGUID: orOvHokpS8qCZwsrQq+Mfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736543"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 03/39] eal: define new functionally distinct config structs
Date: Tue, 18 Aug 2026 14:32:56 +0100
Message-ID: <20260818133334.2620165-4-bruce.richardson@intel.com>
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

Rather than having a generic internal_config structure which mixes
system configuration, memory configuration, and user options in one
struct, create separate structures for the platform info, system runtime
state and the user provided config. Later patches will complete these
with data moved from the current location.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c | 31 ++++++++++++++++++++++++++++++
 lib/eal/common/eal_internal_cfg.h  | 28 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index e2e69a75fb..5427b30659 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -5,6 +5,7 @@
 #include <rte_string_fns.h>
 
 #include <eal_export.h>
+#include "eal_internal_cfg.h"
 #include "eal_private.h"
 #include "eal_filesystem.h"
 #include "eal_memcfg.h"
@@ -27,6 +28,15 @@ static struct rte_config rte_config = {
 /* platform-specific runtime dir */
 static char runtime_dir[UNIX_PATH_MAX];
 
+/* user-provided EAL configuration */
+static struct eal_user_cfg eal_user_cfg;
+
+/* platform-discovered and runtime EAL state */
+static struct eal_platform_info eal_platform_info;
+
+/* internal runtime configuration */
+static struct eal_runtime_state eal_runtime_state;
+
 /* internal configuration */
 static struct internal_config internal_config;
 
@@ -63,6 +73,27 @@ eal_get_internal_configuration(void)
 	return &internal_config;
 }
 
+/* Return a pointer to the user configuration structure */
+struct eal_user_cfg *
+eal_get_user_configuration(void)
+{
+	return &eal_user_cfg;
+}
+
+/* Return a pointer to the platform state structure */
+struct eal_platform_info *
+eal_get_platform_info(void)
+{
+	return &eal_platform_info;
+}
+
+/* Return a pointer to the runtime state structure */
+struct eal_runtime_state *
+eal_get_runtime_state(void)
+{
+	return &eal_runtime_state;
+}
+
 RTE_EXPORT_SYMBOL(rte_eal_iova_mode)
 enum rte_iova_mode
 rte_eal_iova_mode(void)
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 07cd35167d..66224e7c75 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -48,6 +48,31 @@ struct hugepage_file_discipline {
 	bool unlink_existing;
 };
 
+/**
+ * User-provided EAL initialization configuration.
+ * Immutable after initialization, so no need for atomic types or locks.
+ */
+struct eal_user_cfg {
+	uint8_t reserved;
+};
+
+/**
+ * Discovered information about cores, memory, etc. on the system.
+ * Immutable after initialization, so no need for atomic types or locks.
+ */
+struct eal_platform_info {
+	uint8_t reserved;
+};
+
+/**
+ * Internal EAL runtime state
+ * May be modified at runtime, so access must be protected by locks or atomic types
+ * as appropriate.
+ */
+struct eal_runtime_state {
+	uint8_t reserved;
+};
+
 /**
  * internal configuration
  */
@@ -115,6 +140,9 @@ struct internal_config {
 	unsigned int no_auto_probing; /**< true to switch from block-listing to allow-listing */
 };
 
+struct eal_user_cfg *eal_get_user_configuration(void);
+struct eal_platform_info *eal_get_platform_info(void);
+struct eal_runtime_state *eal_get_runtime_state(void);
 void eal_reset_internal_config(struct internal_config *internal_cfg);
 
 #endif /* EAL_INTERNAL_CFG_H */
-- 
2.53.0

