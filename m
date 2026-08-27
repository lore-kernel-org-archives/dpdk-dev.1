Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC68C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0300040698;
	Thu, 27 Aug 2026 17:14:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5404240689
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843693; x=1819379693;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5Z0HWp3zCRXv80lscfm3J71jdNHcRSp4oJOdHohxdTQ=;
 b=L1ycRhhVxcTiaspwDeZAaGfuLEvtxGa/onOD2iTru3SabIJHZSts1k0t
 KYAf4pLtCaDXhkSjs2jP6XIaRigJ8h0IvJNa/UDvmRdO2f2V6Hdz8oW6/
 JflTef3qZAI8rlvVfAEjEdCksJZLNhicBd1MaZld56GHZ38QcdhefoPUO
 bHCQtFFW+Qra6RbvNvJIPkIOOfmlbrZvsKAEy2Bn0P7ckMq5M8D+I27Af
 0eRQCauJ0QKcQ34z01XpAWb/DqO4FpU02RJem3P+snn+bwAAImkTochiE
 IKzZoADNKHJZbDHuTAcrjv984FWDezD1HWUYYwO1CqW/OjUHCg1ouPZZb A==;
X-CSE-ConnectionGUID: f0KDrYgnSaGIroaracVSWA==
X-CSE-MsgGUID: Fk6HnDiDRV203bpqn11ZHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371586"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371586"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:14:53 -0700
X-CSE-ConnectionGUID: 9t9myPi+SpywpNKXXVHcEg==
X-CSE-MsgGUID: nImSqvWmSteVmR8MOBJzvg==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:14:51 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v13 04/24] vfio: decouple EAL from VFIO internals
Date: Thu, 27 Aug 2026 16:14:07 +0100
Message-ID: <e5df1adf888ca5e84ff9ab2a744a9edaea044f0e.1787843386.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787843385.git.anatoly.burakov@intel.com>
 <cover.1787843385.git.anatoly.burakov@intel.com>
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

