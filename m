Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F72ECA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3162442E77;
	Wed,  7 Oct 2026 10:11:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 171A540290
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHt0wpKYfbRz0Gh81wXmNKX+24rdpRs8GIrsbastd10=;
 b=HpzMC0rhAHwbZr2Nm+7nuYcIH7HnrZoH08fi18V5Os0cT+5ALGd5nTlQrXjfHfEB2Otulc
 4bDU8QlAg8RditooOzCnwrBmG8L6t9SmYMH597BtP0CA0hFC1LwFDv3hTAY2Ficv3oqfhR
 UEnQflKwyanstVo9PewM/bmvuMDqEtI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-1_qyotOMMFW7ydmGISd27g-1; Wed,
 07 Oct 2026 04:11:02 -0400
X-MC-Unique: 1_qyotOMMFW7ydmGISd27g-1
X-Mimecast-MFC-AGG-ID: 1_qyotOMMFW7ydmGISd27g_1791360661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7212B180133C; Wed,  7 Oct 2026 08:11:01 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D363E30000E6; Wed,  7 Oct 2026 08:10:59 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [RESEND][PATCH v19 07/26] vfio: add module check API
Date: Wed,  7 Oct 2026 10:10:04 +0200
Message-ID: <20261007081026.574382-8-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hV5NFRiggLlHNW2kst9EYm4Ngy1xiMoZhq_Dz6pMW10_1791360661
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Anatoly Burakov <anatoly.burakov@intel.com>

All VFIO initialization always happens with "vfio" module, and now that the
API is not public, having a way to override the module name seems redundant
as there is not going to be a use case that calls into `rte_vfio_enable`
that isn't coming from EAL init.

On the other hand, there are a few users of VFIO API that depend on
checking if a specific kernel module is loaded. This call is coupled with
checking if VFIO is enabled (which should not be the case, as these are
orthogonal), and depending on context different modules are checked with
a string literal (which is suboptimal as well).

Provide a new API in VFIO to check for whether a specific VFIO-related
kernel module is loaded, decouple it from "enabled" check, and adjust all
callers accordingly.

With this change, there is no user left for the EAL function, remove it.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
Changes since v18:
- squashed all kmod checks into a single patch,

---
 drivers/bus/pci/linux/pci_vfio.c | 11 +++---
 lib/eal/common/eal_private.h     | 14 --------
 lib/eal/linux/eal.c              | 37 +------------------
 lib/eal/linux/eal_vfio.c         | 61 +++++++++++++++++++++++++++++---
 lib/eal/linux/include/dev_vfio.h | 39 ++++++++++++++------
 lib/vhost/socket.c               |  2 +-
 6 files changed, 93 insertions(+), 71 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 2d8144deb0..3b967d62c8 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -1300,11 +1300,12 @@ pci_vfio_mmio_write(const struct rte_pci_device *dev, int bar,
 int
 pci_vfio_is_enabled(void)
 {
-	int status = dev_vfio_is_enabled("vfio_pci");
+	int status;
 
-	if (!status) {
-		dev_vfio_enable("vfio");
-		status = dev_vfio_is_enabled("vfio_pci");
-	}
+	if (dev_vfio_enable() < 0)
+		return 0;
+
+	status = dev_vfio_is_enabled() &&
+		dev_vfio_module_is_loaded(DEV_VFIO_MODULE_VFIO_PCI);
 	return status;
 }
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 6340bab8be..8507791ec2 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -206,20 +206,6 @@ int rte_eal_alarm_init(void);
  */
 void rte_eal_alarm_cleanup(void);
 
-/**
- * Function is to check if the kernel module(like, vfio, vfio_iommu_type1,
- * etc.) loaded.
- *
- * @param module_name
- *	The module's name which need to be checked
- *
- * @return
- *	-1 means some error happens(NULL pointer or open failure)
- *	0  means the module not loaded
- *	1  means the module loaded
- */
-int rte_eal_check_module(const char *module_name);
-
 /**
  * Memory reservation flags.
  */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index c8020a4972..55734b6057 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -17,9 +17,7 @@
 #include <fnmatch.h>
 #include <stddef.h>
 #include <errno.h>
-#include <limits.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
 #if defined(RTE_ARCH_X86)
 #include <sys/io.h>
 #endif
@@ -772,7 +770,7 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-	if (dev_vfio_enable("vfio")) {
+	if (dev_vfio_enable()) {
 		rte_eal_init_alert("Cannot init VFIO");
 		rte_errno = EAGAIN;
 		goto err_out;
@@ -1029,36 +1027,3 @@ rte_eal_vfio_get_vf_token(rte_uuid_t vf_token)
 	rte_uuid_copy(vf_token, cfg->vfio_vf_token);
 }
 
-int
-rte_eal_check_module(const char *module_name)
-{
-	char sysfs_mod_name[PATH_MAX];
-	struct stat st;
-	int n;
-
-	if (NULL == module_name)
-		return -1;
-
-	/* Check if there is sysfs mounted */
-	if (stat("/sys/module", &st) != 0) {
-		EAL_LOG(DEBUG, "sysfs is not mounted! error %i (%s)",
-			errno, strerror(errno));
-		return -1;
-	}
-
-	/* A module might be built-in, therefore try sysfs */
-	n = snprintf(sysfs_mod_name, PATH_MAX, "/sys/module/%s", module_name);
-	if (n < 0 || n > PATH_MAX) {
-		EAL_LOG(DEBUG, "Could not format module path");
-		return -1;
-	}
-
-	if (stat(sysfs_mod_name, &st) != 0) {
-		EAL_LOG(DEBUG, "Module %s not found! error %i (%s)",
-		        sysfs_mod_name, errno, strerror(errno));
-		return 0;
-	}
-
-	/* Module has been found */
-	return 1;
-}
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 93f4bfc695..3548c87884 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -4,9 +4,12 @@
 
 #include <uapi/linux/vfio.h>
 
+#include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <string.h>
 #include <fcntl.h>
+#include <sys/stat.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <dirent.h>
@@ -58,6 +61,48 @@ struct vfio_config {
 static struct vfio_config vfio_cfgs[RTE_MAX_VFIO_CONTAINERS];
 static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
 
+static int
+vfio_check_module(enum dev_vfio_module module)
+{
+	const char *module_name;
+	char sysfs_mod_name[PATH_MAX];
+	struct stat st;
+	int n;
+
+	switch (module) {
+	case DEV_VFIO_MODULE_VFIO:
+		module_name = "vfio";
+		break;
+	case DEV_VFIO_MODULE_VFIO_PCI:
+		module_name = "vfio_pci";
+		break;
+	default:
+		return -1;
+	}
+
+	/* Check if there is sysfs mounted */
+	if (stat("/sys/module", &st) != 0) {
+		EAL_LOG(DEBUG, "sysfs is not mounted! error %i (%s)", errno, strerror(errno));
+		return -1;
+	}
+
+	/* A module might be built-in, therefore try sysfs */
+	n = snprintf(sysfs_mod_name, PATH_MAX, "/sys/module/%s", module_name);
+	if (n < 0 || n >= PATH_MAX) {
+		EAL_LOG(DEBUG, "Could not format module path");
+		return -1;
+	}
+
+	if (stat(sysfs_mod_name, &st) != 0) {
+		EAL_LOG(DEBUG, "Module %s not found! error %i (%s)", sysfs_mod_name, errno,
+			strerror(errno));
+		return 0;
+	}
+
+	/* Module has been found */
+	return 1;
+}
+
 static int vfio_type1_dma_map(int);
 static int vfio_type1_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
 static int vfio_spapr_dma_map(int);
@@ -1100,7 +1145,7 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_enable)
 int
-dev_vfio_enable(const char *modname)
+dev_vfio_enable(void)
 {
 	/* initialize group list */
 	unsigned int i, j;
@@ -1127,7 +1172,7 @@ dev_vfio_enable(const char *modname)
 	EAL_LOG(DEBUG, "Probing VFIO support...");
 
 	/* check if vfio module is loaded */
-	vfio_available = rte_eal_check_module(modname);
+	vfio_available = vfio_check_module(DEV_VFIO_MODULE_VFIO);
 
 	/* return error directly */
 	if (vfio_available == -1) {
@@ -1175,12 +1220,18 @@ dev_vfio_enable(const char *modname)
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_module_is_loaded)
+int
+dev_vfio_module_is_loaded(enum dev_vfio_module module)
+{
+	return vfio_check_module(module) > 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_is_enabled)
 int
-dev_vfio_is_enabled(const char *modname)
+dev_vfio_is_enabled(void)
 {
-	const int mod_available = rte_eal_check_module(modname) > 0;
-	return default_vfio_cfg->vfio_enabled && mod_available;
+	return default_vfio_cfg->vfio_enabled;
 }
 
 int
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index 2e1f3a6160..8e06f7dee8 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -35,6 +35,17 @@ struct vfio_device_info;
 
 #define DEV_VFIO_DEFAULT_CONTAINER_FD (-1)
 
+/**
+ * @enum dev_vfio_module
+ * VFIO kernel modules.
+ *
+ * These values identify kernel modules used by VFIO.
+ */
+enum dev_vfio_module {
+	DEV_VFIO_MODULE_VFIO,     /**< Core VFIO module. */
+	DEV_VFIO_MODULE_VFIO_PCI, /**< VFIO PCI module. */
+};
+
 /**
  * @internal
  * Setup vfio_cfg for the device identified by its address.
@@ -84,31 +95,39 @@ int dev_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
 
 /**
  * @internal
- * Enable a VFIO-related kmod.
- *
- * @param modname
- *   kernel module name.
+ * Initialize VFIO.
  *
  * @return
  *   0 on success.
  *   <0 on failure.
  */
 __rte_internal
-int dev_vfio_enable(const char *modname);
+int dev_vfio_enable(void);
 
 /**
  * @internal
- * Check whether a VFIO-related kmod is enabled.
+ * Check whether a VFIO module is loaded.
  *
- * @param modname
- *   kernel module name.
+ * @param module
+ *   VFIO module to check.
  *
  * @return
- *   1 if true.
+ *   1 if the requested module is loaded.
+ *   0 otherwise.
+ */
+__rte_internal
+int dev_vfio_module_is_loaded(enum dev_vfio_module module);
+
+/**
+ * @internal
+ * Check whether VFIO was initialized.
+ *
+ * @return
+ *   1 if VFIO was initialized.
  *   0 otherwise.
  */
 __rte_internal
-int dev_vfio_is_enabled(const char *modname);
+int dev_vfio_is_enabled(void);
 
 /**
  * @internal
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 95acca3ab0..d30b34caa6 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -245,7 +245,7 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 
 		if (dev != NULL) {
 			dev->async_copy = 1;
-			dev->dma_map_available = dev_vfio_is_enabled("vfio");
+			dev->dma_map_available = dev_vfio_is_enabled();
 		}
 	}
 
-- 
2.54.0

