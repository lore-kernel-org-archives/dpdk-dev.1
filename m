Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B3CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45B8042DA1;
	Wed,  7 Oct 2026 09:32:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 89B0A42D45
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791358351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4VRJOmkoLaOumik+/nI9aJT5IOv2udIWei01Z18okJg=;
 b=hZ6nCu0udUs2b6V6sevTI6EWO23t8Xara/39i7EZxyfmcYorceOF7xh+Ljp+Kai+2JVuGT
 VG322lIZKReR8SetWWMSvGM8a9F3TzcaXA77Kb19XOmSSfMTejE/wWDqAjRxL0Qpg2i8WC
 C8+rIA9MtuzrETVHqlhKIqPtuBx/eRs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-csHqze_7MPSOxMo-ErKPsA-1; Wed,
 07 Oct 2026 03:32:29 -0400
X-MC-Unique: csHqze_7MPSOxMo-ErKPsA-1
X-Mimecast-MFC-AGG-ID: csHqze_7MPSOxMo-ErKPsA_1791358348
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F486180065F; Wed,  7 Oct 2026 07:32:28 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2B991956044; Wed,  7 Oct 2026 07:32:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v19 05/26] eal: provide VFIO only for Linux
Date: Wed,  7 Oct 2026 09:31:43 +0200
Message-ID: <20261007073206.567001-6-david.marchand@redhat.com>
In-Reply-To: <20261007073206.567001-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Fpv_ek7AthM-wqFv-4Bh0ObnozXTyZQIUFeRzpr1tY_1791358348
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

The VFIO API is used only in Linux related code.

We can hide this API on other OSes and unexport associated symbols,
before the next commit which makes this API entirely internal.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/freebsd/eal.c                  | 128 -------------------------
 lib/eal/include/meson.build            |   1 -
 lib/eal/linux/include/meson.build      |   1 +
 lib/eal/{ => linux}/include/rte_vfio.h |  31 ------
 lib/eal/windows/eal.c                  |  23 -----
 5 files changed, 1 insertion(+), 183 deletions(-)
 rename lib/eal/{ => linux}/include/rte_vfio.h (88%)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 8b1ba5b99b..faf5f0e911 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -41,7 +41,6 @@
 #include <rte_dev.h>
 #include <rte_devargs.h>
 #include <rte_version.h>
-#include <rte_vfio.h>
 #include <malloc_heap.h>
 #include <telemetry_internal.h>
 
@@ -818,130 +817,3 @@ void
 rte_eal_vfio_get_vf_token(__rte_unused rte_uuid_t vf_token)
 {
 }
-
-RTE_EXPORT_SYMBOL(rte_vfio_setup_device)
-int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
-		      __rte_unused const char *dev_addr,
-		      __rte_unused int *vfio_dev_fd,
-		      __rte_unused struct vfio_device_info *device_info)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_release_device)
-int rte_vfio_release_device(__rte_unused const char *sysfs_base,
-			__rte_unused const char *dev_addr,
-			__rte_unused int fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_enable)
-int rte_vfio_enable(__rte_unused const char *modname)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_is_enabled)
-int rte_vfio_is_enabled(__rte_unused const char *modname)
-{
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled)
-int rte_vfio_noiommu_is_enabled(void)
-{
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_clear_group)
-int rte_vfio_clear_group(__rte_unused int vfio_group_fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_num)
-int
-rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
-		       __rte_unused const char *dev_addr,
-		       __rte_unused int *iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
-int
-rte_vfio_get_container_fd(void)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd)
-int
-rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_container_create)
-int
-rte_vfio_container_create(void)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_container_destroy)
-int
-rte_vfio_container_destroy(__rte_unused int container_fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind)
-int
-rte_vfio_container_group_bind(__rte_unused int container_fd,
-		__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind)
-int
-rte_vfio_container_group_unbind(__rte_unused int container_fd,
-		__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
-int
-rte_vfio_container_dma_map(__rte_unused int container_fd,
-			__rte_unused uint64_t vaddr,
-			__rte_unused uint64_t iova,
-			__rte_unused uint64_t len)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
-int
-rte_vfio_container_dma_unmap(__rte_unused int container_fd,
-			__rte_unused uint64_t vaddr,
-			__rte_unused uint64_t iova,
-			__rte_unused uint64_t len)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index aef5824e5f..67c6a8021a 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -55,7 +55,6 @@ headers += files(
         'rte_trace_point_register.h',
         'rte_uuid.h',
         'rte_version.h',
-        'rte_vfio.h',
 )
 
 driver_sdk_headers = files(
diff --git a/lib/eal/linux/include/meson.build b/lib/eal/linux/include/meson.build
index 7d18dd52f1..00854cd6fa 100644
--- a/lib/eal/linux/include/meson.build
+++ b/lib/eal/linux/include/meson.build
@@ -5,4 +5,5 @@ includes += include_directories('.')
 
 headers += files(
         'rte_os.h',
+        'rte_vfio.h',
 )
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/linux/include/rte_vfio.h
similarity index 88%
rename from lib/eal/include/rte_vfio.h
rename to lib/eal/linux/include/rte_vfio.h
index d1e8bce56b..432ad3c10d 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/linux/include/rte_vfio.h
@@ -19,8 +19,6 @@
 extern "C" {
 #endif
 
-#ifdef RTE_EXEC_ENV_LINUX
-
 #define RTE_VFIO_DIR "/dev/vfio"
 #define RTE_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
 #define RTE_VFIO_GROUP_FMT "/dev/vfio/%u"
@@ -28,8 +26,6 @@ extern "C" {
 #define RTE_VFIO_NOIOMMU_MODE      \
 	"/sys/module/vfio/parameters/enable_unsafe_noiommu_mode"
 
-#endif /* RTE_EXEC_ENV_LINUX */
-
 /* we don't need an actual definition, only pointer is used */
 struct vfio_device_info;
 
@@ -40,9 +36,6 @@ struct vfio_device_info;
  * It discovers the configured I/O MMU groups or sets a new one for the device.
  * If a new groups is assigned, the DMA mapping is performed.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
  * @param sysfs_base
  *   sysfs path prefix.
  *
@@ -66,9 +59,6 @@ int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 /**
  * Release a device mapped to a VFIO-managed I/O MMU group.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
  * @param sysfs_base
  *   sysfs path prefix.
  *
@@ -87,9 +77,6 @@ int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
 /**
  * Enable a VFIO-related kmod.
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
  * @param modname
  *   kernel module name.
  *
@@ -102,8 +89,6 @@ int rte_vfio_enable(const char *modname);
 /**
  * Check whether a VFIO-related kmod is enabled.
  *
- * This function is only relevant to Linux.
- *
  * @param modname
  *   kernel module name.
  *
@@ -116,8 +101,6 @@ int rte_vfio_is_enabled(const char *modname);
 /**
  * Whether VFIO NOIOMMU mode is enabled.
  *
- * This function is only relevant to Linux.
- *
  * @return
  *   1 if true.
  *   0 if false.
@@ -128,9 +111,6 @@ int rte_vfio_noiommu_is_enabled(void);
 /**
  * Remove group fd from internal VFIO group fd array/
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
  * @param vfio_group_fd
  *   VFIO Group FD.
  *
@@ -144,9 +124,6 @@ rte_vfio_clear_group(int vfio_group_fd);
 /**
  * Parse IOMMU group number for a device
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
  * @param sysfs_base
  *   sysfs path prefix.
  *
@@ -168,8 +145,6 @@ rte_vfio_get_group_num(const char *sysfs_base,
 /**
  * Get device information
  *
- * This function is only relevant to Linux and will return an error on BSD.
- *
  * @param sysfs_base
  *   sysfs path prefix.
  *
@@ -194,9 +169,6 @@ rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 /**
  * Get the default VFIO container fd
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
  * @return
  *  > 0 default container fd
  *  < 0 if VFIO is not enabled or not supported
@@ -207,9 +179,6 @@ rte_vfio_get_container_fd(void);
 /**
  * Open VFIO group fd or get an existing one
  *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
  * @param iommu_group_num
  *   iommu group number
  *
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 6dacae7235..cac8faa53d 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -24,7 +24,6 @@
 #include <eal_options.h>
 #include <eal_private.h>
 #include <rte_service_component.h>
-#include <rte_vfio.h>
 
 #include "eal_firmware.h"
 #include "eal_hugepages.h"
@@ -453,28 +452,6 @@ eal_asprintf(char **buffer, const char *format, ...)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
-int
-rte_vfio_container_dma_map(__rte_unused int container_fd,
-			__rte_unused uint64_t vaddr,
-			__rte_unused uint64_t iova,
-			__rte_unused uint64_t len)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
-int
-rte_vfio_container_dma_unmap(__rte_unused int container_fd,
-			__rte_unused uint64_t vaddr,
-			__rte_unused uint64_t iova,
-			__rte_unused uint64_t len)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_firmware_read)
 int
 rte_firmware_read(__rte_unused const char *name,
-- 
2.54.0

