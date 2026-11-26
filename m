Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5E606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TOaoygSM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 325484065A;
	Thu, 26 Nov 2026 19:14:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id EC9BD402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716865; x=1827252865;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SKHSRwWKc8ytBnQiUcJ6/YorrfqpxM/WLr2FfhtZZco=;
 b=TOaoygSMkajaeUpCRdzM2AxYZP51utlDM3faMyYQL758LjeQvFlI/Csa
 9KHlPKrTqlZQs/srlBOcgTVu9oM7Yp3fze4/4oRVQbzsszYIu+yqrJ6HS
 mb6niuMZXoCw6kGTxrOenLsEDU64/IPKRUvdplaQhNzfBIu1DEpuIzQ1K
 +7dL5fgtuCAWxrodOEdDwuCYo4I3hLjGMR3HXpMta5C5aJhillFT4vdZ1
 YlVe4dW7zqntN/koDxUhlbr1qykLYwDA06VXYOzy22Kx8Ya+yXgH4hZQx
 WfrrNVa2RRKdAvuE6t27JPoWNG/5l6QB0qQ/PHjHe7s06Nt33cTEztEh4 w==;
X-CSE-ConnectionGUID: KLUCCrfNQ6OzsbKXHPIvKg==
X-CSE-MsgGUID: mRUptCEQTAS8o2K/sDxv9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633542"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633542"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:21 -0800
X-CSE-ConnectionGUID: gqe31Y3OQe+qFfojCTEuWQ==
X-CSE-MsgGUID: EPhOmSh6T8K3XJv3lc3r8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732845"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 03/39] eal: define new functionally distinct config structs
Date: Thu, 26 Nov 2026 18:13:36 +0000
Message-ID: <20261126181414.124094-4-bruce.richardson@intel.com>
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
index 1221e03253..cd24270f02 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -54,6 +54,31 @@ struct hugepage_file_discipline {
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
@@ -121,6 +146,9 @@ struct internal_config {
 	unsigned int no_auto_probing; /**< true to switch from block-listing to allow-listing */
 };
 
+struct eal_user_cfg *eal_get_user_configuration(void);
+struct eal_platform_info *eal_get_platform_info(void);
+struct eal_runtime_state *eal_get_runtime_state(void);
 void eal_reset_internal_config(struct internal_config *internal_cfg);
 
 #endif /* EAL_INTERNAL_CFG_H */
-- 
2.55.0

