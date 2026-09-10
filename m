Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5202CC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3785C427E4;
	Thu, 10 Sep 2026 14:53:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id B972D427C7
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:53:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789044810; x=1820580810;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=sAAHKBG6XJY0v0knn+vJ8fgdei3W5nOark7gJYIJDCc=;
 b=Yy3bJv8HOEssF1TGiEACfbRbWiroE8njAj+Rcx7LdPEm1QK9R7LJGr5u
 TOyNpk0rp6u0dtzYFm7AmgVKOvVo39dubCmh2LonQl1fW8FdTYP8bkSvx
 baSe1qF8/sIyOP9ZoXXsaSi1iNJOD2T0nHgYCMVL78EO4wUhgzfa+21Nu
 Q94wiq8lRS32JH5zlyCX2GC9MHl1YG+67WarZhJ0ipf62JH+CGpyfxdOT
 qMxdhai4rrqerf5H3eVGBwLwmfmXoYzhnOw2TLZcaoNFtQiDtjaNC6yCF
 tkDQ0GG2FjSPn1a1Y2gHvVJkzvISqXLu0A412DhNVJd8JcL9slzYwVs2/ Q==;
X-CSE-ConnectionGUID: khCGCX9tRLSQoY5LjK/7OQ==
X-CSE-MsgGUID: liEa+HMgQiidurZYoJt4nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334025"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89334025"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 05:53:29 -0700
X-CSE-ConnectionGUID: Lx4QhxJeTeGYTpHuJ1up9w==
X-CSE-MsgGUID: uD9Sxo7+S1WsWH0iYvnfNQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2026 05:53:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v17 07/26] vfio: remove modname parameter from init
Date: Thu, 10 Sep 2026 13:52:51 +0100
Message-ID: <b6701180c52598dbc327055c2c9491e6f5c790c5.1789044747.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789044746.git.anatoly.burakov@intel.com>
 <cover.1789044746.git.anatoly.burakov@intel.com>
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

