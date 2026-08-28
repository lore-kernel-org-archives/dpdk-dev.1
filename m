Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0945DC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:07:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C75EB40679;
	Fri, 28 Aug 2026 15:07:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id AAAB840395
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922430; x=1819458430;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5Z0HWp3zCRXv80lscfm3J71jdNHcRSp4oJOdHohxdTQ=;
 b=etDIyQ6VZhhnxRPz35a5310hSS5IcmTBilEmgX/zmH1ARXwBHDIniBPV
 fWL45K7H532POTOOFrxolTkbGdjEAcvuoEteqv2OUnn1W8LTXu6S1TzAF
 ujEg468W1pc6xLQoF8t9giAxt/VSarWCJjdtassgfTYDruhFQ8Btcvfpd
 1ghyUSFu2JhG/Rg9NOt4ruENJWupsPHfmnYodDpNdx/YMgfPqz4zE2Z+r
 aUUCrbg59ms/QxOvVYeJfupT+LE+7OW29PNcO6+71xorR9UvqNmVcoa0A
 GTz+V6SAIHLk5D+t6nc/9LdV1YcrKctJqTM8HySHZ/FqC3nm2Rzc0m1Tq g==;
X-CSE-ConnectionGUID: SpYwmKAbSGuAjGKSe+CYhQ==
X-CSE-MsgGUID: V+mZN73tQ8KiZ+X/KDJtiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964505"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964505"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:09 -0700
X-CSE-ConnectionGUID: gycC1yA3Rny4du3+2qWMzA==
X-CSE-MsgGUID: ZslGoTscQsOTODoN0GJU4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271959696"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v14 04/25] vfio: decouple EAL from VFIO internals
Date: Fri, 28 Aug 2026 14:06:32 +0100
Message-ID: <e5df1adf888ca5e84ff9ab2a744a9edaea044f0e.1787922362.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787922362.git.anatoly.burakov@intel.com>
 <cover.1787922362.git.anatoly.burakov@intel.com>
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
index 0fe54a9dd7..991ca45064 100644
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
index 0ddeb08f94..e76181c83c 100644
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
index fc2e9b8c0e..5577bab24a 100644
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
index 33fa04feaf..6c77076bc3 100644
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
index de7a89a829..b8771d4d85 100644
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

