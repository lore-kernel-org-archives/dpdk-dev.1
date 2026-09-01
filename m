Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A37CC61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 744AC40BA6;
	Tue,  1 Sep 2026 18:15:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4355140BA3
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279348; x=1819815348;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=sAAHKBG6XJY0v0knn+vJ8fgdei3W5nOark7gJYIJDCc=;
 b=eMoxEuG0U6CUywt4AOVTBwj3CNnBY7k2+UT28/zaX8WWoIxX80GYpERG
 StJFlfmZZU89h9npPMngWoyE0PYOsleaoJlLAJ45sZEhHKc6lNk9z+5oT
 Usm+FMfgltlsSvrQmlPDuTm6WLcY91eg4u59qwFWcZzgfFCZL8RIsQ4RR
 T/tkp2du+g+LDybDWxxGoVMHucmHBz6W2yTZUfz9KWFaKIV+uTUnSqLJA
 IyJbJuiE9yFlap9tMFdLkuMmDtNoK1V+PMxE3Zphm6Kn9qQ3RKBcKEEXc
 nQ1BkY3ITnrhGgX3r4Z52i82uNqbuL7xzoVDh+coGKvhm0vmpQYczv8/U g==;
X-CSE-ConnectionGUID: FAG74s2gTyOCqMXjr1Kl+A==
X-CSE-MsgGUID: R5tCMoIyQ6SkxuShZ0e6LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656049"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656049"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:15:48 -0700
X-CSE-ConnectionGUID: i/k7e9fOQO+vqp9n/m6trQ==
X-CSE-MsgGUID: chiQyhJwQq68r2+RPMalUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032526"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:15:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v15 06/25] vfio: remove modname parameter from init
Date: Tue,  1 Sep 2026 17:15:12 +0100
Message-ID: <b6701180c52598dbc327055c2c9491e6f5c790c5.1788278992.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788278991.git.anatoly.burakov@intel.com>
 <cover.1788278991.git.anatoly.burakov@intel.com>
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

All VFIO initialization always happens with "vfio" module, and now that the
API is not public, having a way to override the module name seems redundant
as there is not going to be a use case that calls into `rte_vfio_enable`
that isn't coming from EAL init. So, remove the parameter, and hardcode
the modname to "vfio" instead.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 2 +-
 lib/eal/freebsd/eal.c            | 2 +-
 lib/eal/include/rte_vfio.h       | 7 ++-----
 lib/eal/linux/eal.c              | 2 +-
 lib/eal/linux/eal_vfio.c         | 5 +++--
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index bc5c5c2499..f3791cce98 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1303,7 +1303,7 @@ pci_vfio_is_enabled(void)
 	int status = rte_vfio_is_enabled("vfio_pci");
 
 	if (!status) {
-		rte_vfio_enable("vfio");
+		rte_vfio_enable();
 		status = rte_vfio_is_enabled("vfio_pci");
 	}
 	return status;
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index aa6d4c2e16..52d265769e 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -839,7 +839,7 @@ int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
-int rte_vfio_enable(__rte_unused const char *modname)
+int rte_vfio_enable(void)
 {
 	rte_errno = ENOTSUP;
 	return -1;
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index e76181c83c..b53ce56a8d 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -94,20 +94,17 @@ int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
 
 /**
  * @internal
- * Enable a VFIO-related kmod.
+ * Initialize VFIO.
  *
  * This function is only relevant to linux and will return
  * an error on BSD.
  *
- * @param modname
- *   kernel module name.
- *
  * @return
  *   0 on success.
  *   <0 on failure.
  */
 __rte_internal
-int rte_vfio_enable(const char *modname);
+int rte_vfio_enable(void);
 
 /**
  * @internal
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 5577bab24a..17977baedc 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -771,7 +771,7 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-	if (rte_vfio_enable("vfio")) {
+	if (rte_vfio_enable()) {
 		rte_eal_init_alert("Cannot init VFIO");
 		rte_errno = EAGAIN;
 		goto err_out;
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index d4173f7a01..da46ef2f17 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -25,6 +25,7 @@
 #include "eal_internal_cfg.h"
 
 #define VFIO_MEM_EVENT_CLB_NAME "vfio_mem_event_clb"
+#define VFIO_MODNAME "vfio"
 
 /* hot plug/unplug of VFIO groups may cause all DMA maps to be dropped. we can
  * recreate the mappings for DPDK segments, but we cannot do so for memory that
@@ -1123,7 +1124,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
 int
-rte_vfio_enable(const char *modname)
+rte_vfio_enable(void)
 {
 	/* initialize group list */
 	unsigned int i, j;
@@ -1154,7 +1155,7 @@ rte_vfio_enable(const char *modname)
 	EAL_LOG(DEBUG, "Probing VFIO support...");
 
 	/* check if vfio module is loaded */
-	vfio_available = rte_eal_check_module(modname);
+	vfio_available = rte_eal_check_module(VFIO_MODNAME);
 
 	/* return error directly */
 	if (vfio_available == -1) {
-- 
2.52.0

