Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBECC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:15:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E1E143283;
	Thu, 24 Sep 2026 18:14:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5651D43254
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266438; x=1821802438;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RT0o7K1p8yIaLwJZJ/XYspU3ptp8FNOyejZN8frqpxI=;
 b=M5G2qnQw65ZzUFc8rQ7M8qU1O/bl7KGuDWWyW6QRPn1s0KY+WvIt0pl+
 1wbct7tEq6gmoVk29eQnaj3CWbb6kVHwbQYchq/FJpthuVQfLMh2VcDUZ
 7PoefWzjIlp+lI0lj/8f0I5Fbyurd1pgkyobAe0nHUZ0v4/z6phPu0lNr
 HAgtWUx0dhWmC1xD/Y4Io9rT5nRmcALJIYcS2FFiG2EEmpt8l+kXj35HI
 IMZPWUwqf5IJ7FB1pZtXVlgTPHFtcmngwoWzVKCD39t7kKZJu0/4Yr9pU
 3pNdX7c44H06b+RpAZUkpEyh1ZaKiwYmRWOipRL2aATsXxuUYwpz5r+jS Q==;
X-CSE-ConnectionGUID: ZbW9B4dIRt6TcNFZtt43cw==
X-CSE-MsgGUID: LXxYImLPRPS5imqCylQ/Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000649"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000649"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:13:57 -0700
X-CSE-ConnectionGUID: azfvBOsvRSm2JfEcXEXgxw==
X-CSE-MsgGUID: Xfjm4HnkQS6eCObYMuIODQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830015"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v18 09/29] vfio: add module check API
Date: Thu, 24 Sep 2026 17:13:16 +0100
Message-ID: <6ac1973cfde10f10515a379e5ba9a22c5545bbb1.1790266166.git.anatoly.burakov@intel.com>
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

Currently, there are a few users of VFIO API that depend on checking if a
specific kernel module is loaded. This call is coupled with checking if
VFIO is enabled (which should not be the case, as these are orthogonal),
and depending on context different modules are checked with a string
literal (which is suboptimal as well).

Provide a new API in VFIO to check for whether a specific VFIO-related
kernel module is loaded, decouple it from "enabled" check, and adjust all
callers accordingly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci_vfio.c | 11 ++++++-----
 lib/eal/freebsd/eal.c            |  8 +++++++-
 lib/eal/include/rte_vfio.h       | 34 +++++++++++++++++++++++++++-----
 lib/eal/linux/eal_vfio.c         | 27 +++++++++++++++++++------
 lib/vhost/socket.c               |  3 ++-
 5 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index f3791cce982..ed713a005f6 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1300,11 +1300,12 @@ pci_vfio_mmio_write(const struct rte_pci_device *dev, int bar,
 int
 pci_vfio_is_enabled(void)
 {
-	int status = rte_vfio_is_enabled("vfio_pci");
+	int status;
 
-	if (!status) {
-		rte_vfio_enable();
-		status = rte_vfio_is_enabled("vfio_pci");
-	}
+	if (rte_vfio_enable() < 0)
+		return 0;
+
+	status = rte_vfio_is_enabled() &&
+		rte_vfio_module_is_loaded(RTE_VFIO_MODULE_VFIO_PCI);
 	return status;
 }
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 5628d60d589..a2060978fe1 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -851,8 +851,14 @@ rte_vfio_cleanup(void)
 {
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_module_is_loaded)
+int rte_vfio_module_is_loaded(__rte_unused enum rte_vfio_module module)
+{
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
-int rte_vfio_is_enabled(__rte_unused const char *modname)
+int rte_vfio_is_enabled(void)
 {
 	return 0;
 }
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index b53ce56a8dc..da003c33a56 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -39,6 +39,17 @@ struct vfio_device_info;
 
 #define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
 
+/**
+ * @enum rte_vfio_module
+ * VFIO kernel modules.
+ *
+ * These values identify kernel modules used by VFIO.
+ */
+enum rte_vfio_module {
+	RTE_VFIO_MODULE_VFIO,     /**< Core VFIO module. */
+	RTE_VFIO_MODULE_VFIO_PCI, /**< VFIO PCI module. */
+};
+
 /**
  * @internal
  * Setup vfio_cfg for the device identified by its address.
@@ -117,19 +128,32 @@ void rte_vfio_cleanup(void);
 
 /**
  * @internal
- * Check whether a VFIO-related kmod is enabled.
+ * Check whether a VFIO module is loaded.
  *
  * This function is only relevant to Linux.
  *
- * @param modname
- *   kernel module name.
+ * @param module
+ *   VFIO module to check.
  *
  * @return
- *   1 if true.
+ *   1 if the requested module is loaded.
  *   0 otherwise.
  */
 __rte_internal
-int rte_vfio_is_enabled(const char *modname);
+int rte_vfio_module_is_loaded(enum rte_vfio_module module);
+
+/**
+ * @internal
+ * Check whether VFIO was initialized.
+ *
+ * This function is only relevant to Linux.
+ *
+ * @return
+ *   1 if VFIO was initialized.
+ *   0 otherwise.
+ */
+__rte_internal
+int rte_vfio_is_enabled(void);
 
 /**
  * @internal
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 41bf401dec6..780c344bf70 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -64,14 +64,23 @@ static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
 static bool vfio_enabled;
 
 static int
-vfio_check_module(const char *module_name)
+vfio_check_module(enum rte_vfio_module module)
 {
+	const char *module_name;
 	char sysfs_mod_name[PATH_MAX];
 	struct stat st;
 	int n;
 
-	if (NULL == module_name)
+	switch (module) {
+	case RTE_VFIO_MODULE_VFIO:
+		module_name = "vfio";
+		break;
+	case RTE_VFIO_MODULE_VFIO_PCI:
+		module_name = "vfio_pci";
+		break;
+	default:
 		return -1;
+	}
 
 	/* Check if there is sysfs mounted */
 	if (stat("/sys/module", &st) != 0) {
@@ -1189,7 +1198,7 @@ rte_vfio_enable(void)
 	EAL_LOG(DEBUG, "Probing VFIO support...");
 
 	/* check if vfio module is loaded */
-	vfio_available = vfio_check_module("vfio");
+	vfio_available = vfio_check_module(RTE_VFIO_MODULE_VFIO);
 
 	/* return error directly */
 	if (vfio_available == -1) {
@@ -1237,12 +1246,18 @@ rte_vfio_enable(void)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_module_is_loaded)
+int
+rte_vfio_module_is_loaded(enum rte_vfio_module module)
+{
+	return vfio_check_module(module) > 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
 int
-rte_vfio_is_enabled(const char *modname)
+rte_vfio_is_enabled(void)
 {
-	const int mod_available = vfio_check_module(modname) > 0;
-	return vfio_enabled && mod_available;
+	return vfio_enabled;
 }
 
 int
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index a8f58c95e83..1e38ea76474 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -245,7 +245,8 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 
 		if (dev != NULL) {
 			dev->async_copy = 1;
-			dev->dma_map_available = rte_vfio_is_enabled("vfio");
+			dev->dma_map_available = rte_vfio_is_enabled() &&
+					rte_vfio_module_is_loaded(RTE_VFIO_MODULE_VFIO);
 		}
 	}
 
-- 
2.52.0

