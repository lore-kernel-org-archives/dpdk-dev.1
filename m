Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F325C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:14:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AE4C43250;
	Thu, 24 Sep 2026 18:13:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C5C1642FED
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266432; x=1821802432;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IgKfxXvly4WL4GTdQxusKWSlQNrsWZFFkIarLqSGUbk=;
 b=lqa/FMG7DN45oSScOxJ2pk52HjK033tZ+rZ+AemqLPBABrPaY/NJNAuP
 vv37Jt9cV4ajHq2yR7d6FcFUj/KCjxPdwKcYilzd5O1fWQAVhg6j9RPOi
 La1UvDi9VsVWtYKz6hOZ4fxCiEQ/tiNRufS/ERn9Jth4rYSqLQD9yvooj
 sE3nqaR1pczc9zDe9IWwiDU6bO/XdGID96eA2Ct/qrYdJE7ug3a1B6aSG
 WVIKaQ/jlkFZzfFnKPgH2A4LRJ+nCphCf5xIYqPzo5ydKaP1+yxW95QuB
 xhWi/d2eF9jZFLn1MPNcjbIvZOsag68Aq+pBoSz9WFbOPYErlOeRWh21d w==;
X-CSE-ConnectionGUID: HfXIkSuoQ5+RJ/Bor34Z+A==
X-CSE-MsgGUID: xN1Y3GKoQAaNVp6r8DM9ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000621"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000621"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:13:51 -0700
X-CSE-ConnectionGUID: QYKosyl1QSaaQkttzsnJYQ==
X-CSE-MsgGUID: FhwN6F5pTTqWRyS9Mlr+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277829973"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v18 04/29] vfio: decouple EAL from VFIO internals
Date: Thu, 24 Sep 2026 17:13:11 +0100
Message-ID: <b06b7c190f2c8b4123ad9ff909cbb8f74f06e126.1790266166.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
References: 
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

Currently, the multiprocess cleanup for VFIO is called via an internal-only
API, and this is the only thing `eal_vfio.h` is used for in EAL. In order
to make `eal_vfio.h` truly VFIO-internal, export a cleanup function from
`rte_vfio` API instead, and call that. This allows us to remove all EAL
references to `eal_vfio.h` in non-VFIO related files.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c      | 6 ++++++
 lib/eal/include/rte_vfio.h | 9 +++++++++
 lib/eal/linux/eal.c        | 3 +--
 lib/eal/linux/eal_vfio.c   | 7 +++++++
 lib/eal/windows/eal.c      | 6 ++++++
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 0fe54a9dd7c..991ca450640 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -845,6 +845,12 @@ int rte_vfio_enable(__rte_unused const char *modname)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
+void
+rte_vfio_cleanup(void)
+{
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
 int rte_vfio_is_enabled(__rte_unused const char *modname)
 {
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 0ddeb08f94a..e76181c83cc 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -109,6 +109,15 @@ int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
 __rte_internal
 int rte_vfio_enable(const char *modname);
 
+/**
+ * @internal
+ * Cleanup VFIO resources.
+ *
+ * This function is only relevant to Linux.
+ */
+__rte_internal
+void rte_vfio_cleanup(void);
+
 /**
  * @internal
  * Check whether a VFIO-related kmod is enabled.
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index fc2e9b8c0e8..5577bab24a2 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -54,7 +54,6 @@
 #include "eal_memcfg.h"
 #include "eal_trace.h"
 #include "eal_options.h"
-#include "eal_vfio.h"
 #include "hotplug_mp.h"
 #include "log_internal.h"
 
@@ -986,7 +985,7 @@ rte_eal_cleanup(void)
 
 	rte_service_finalize();
 	eal_bus_cleanup();
-	vfio_mp_sync_cleanup();
+	rte_vfio_cleanup();
 	rte_mp_channel_cleanup();
 	rte_eal_alarm_cleanup();
 	rte_trace_save();
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 33fa04feaf7..6c77076bc3e 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -2217,3 +2217,10 @@ rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 
 	return container_dma_unmap(vfio_cfg, vaddr, iova, len);
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
+void
+rte_vfio_cleanup(void)
+{
+	vfio_mp_sync_cleanup();
+}
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index de7a89a8291..b8771d4d858 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -152,6 +152,12 @@ rte_eal_cleanup(void)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
+void
+rte_vfio_cleanup(void)
+{
+}
+
 /* Launch threads, called at application init(). */
 RTE_EXPORT_SYMBOL(rte_eal_init)
 int
-- 
2.52.0

