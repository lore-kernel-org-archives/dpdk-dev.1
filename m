Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F2C79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:02:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 151FD410E7;
	Wed,  9 Sep 2026 12:02:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4F00D40A76
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948154; x=1820484154;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9cbud6fiMJYnMIg78VWxy6r3ZDHlVnHwGiHA2vo5csU=;
 b=WGmewOPbVh9b9ZZY/CkLiNf7aN95JeWfC3Z7cWefOFgxm9cygbOKJDMG
 dGmJGDSpgR8f+4Kb1CIzjU3osIzTZE0H/kMWyBBGv5dKE0S1nkTbfTjQ2
 tVDbBV7DcuSxadSJmHctY70rcvyIMNOAaX+da19tiCsKd3F++DCZ77Uk/
 ga31xzCXYCfC91Mbb/7irleU8fg6LVzcypXDhrVgp9bK8WPrhEZ6aYAE3
 NW2Dj/H9/6igCwTDZ/P6OuY0OzIWR1UlOzFyUHmwt6uZayzxLg03xF4D3
 iMM5ydvC4cxPdm2SDgP9+r0h1aoFyPmrGzBx9xrAql8v6mj/6J15LyE0R A==;
X-CSE-ConnectionGUID: PtjqTiuTRdecGhcureIa2Q==
X-CSE-MsgGUID: 4Fx0vg4WTIa1Y3GY5Bb69w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492174"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492174"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:02:33 -0700
X-CSE-ConnectionGUID: XuaO3PvET16rowVChqndHQ==
X-CSE-MsgGUID: m5PFhhOjQUKen0UnTm4PSw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:02:31 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v16 03/26] vfio: make all functions internal
Date: Wed,  9 Sep 2026 11:01:56 +0100
Message-ID: <3958d215f21a7b7feed9072d6fb625b00eba81a5.1788947937.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788947937.git.anatoly.burakov@intel.com>
 <cover.1788947937.git.anatoly.burakov@intel.com>
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

The VFIO API is an externally exported API because the original intent was
to offer DMA mapping facilities to applications. However, practical usage
of this API seems to be centered around drivers, so keeping this API
exported to applications only creates needless API/ABI stability surface
that has no added value.

Make the entire VFIO API internal-only and visible only to drivers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/api/doxy-api-index.md              |  3 +-
 doc/guides/rel_notes/deprecation.rst   |  6 ----
 doc/guides/rel_notes/release_26_11.rst |  8 +++++
 lib/eal/freebsd/eal.c                  | 30 ++++++++--------
 lib/eal/include/meson.build            |  2 +-
 lib/eal/include/rte_vfio.h             | 47 ++++++++++++++++++++++----
 lib/eal/linux/eal_vfio.c               | 32 +++++++++---------
 lib/eal/windows/eal.c                  |  4 +--
 8 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 9296042119..4216b1b9e4 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -37,8 +37,7 @@ The public API headers are grouped by topics:
   [latency](@ref rte_latencystats.h),
   [devargs](@ref rte_devargs.h),
   [PCI](@ref rte_pci.h),
-  [vdev](@ref rte_bus_vdev.h),
-  [vfio](@ref rte_vfio.h)
+  [vdev](@ref rte_bus_vdev.h)
 
 - **device specific**:
   [softnic](@ref rte_eth_softnic.h),
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 6ad7698c6b..8a82c815e3 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -29,12 +29,6 @@ Deprecation Notices
   Use the ``-S <service-corelist>`` parameter instead
   to specify the cores to be used for background services in DPDK.
 
-* eal: The entire VFIO API (``rte_vfio_*``) will be made internal only,
-  and will only be available to EAL and drivers.
-  Group-based API (``rte_vfio_*_group_*``) will be removed
-  and replaced with unified container device assignment API.
-  This change will be made in 26.11 release.
-
 * vdpa: The vDPA driver API will no longer offer ``get_vfio_group_fd``
   as part of its internal API. All drivers will be adjusted
   to use the new unified VFIO container device assignment API.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..b5793b5c94 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -93,6 +93,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* vfio: The entire VFIO API (``rte_vfio_*``) was made internal.
+  These functions are now available only to EAL and drivers,
+  and are no longer part of the public API.
+
 
 ABI Changes
 -----------
@@ -109,6 +113,10 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* vfio: The entire VFIO API (``rte_vfio_*``) was made internal.
+  These functions are now available only to EAL and drivers,
+  and are no longer part of the public ABI.
+
 
 Known Issues
 ------------
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 8b1ba5b99b..0fe54a9dd7 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -819,7 +819,7 @@ rte_eal_vfio_get_vf_token(__rte_unused rte_uuid_t vf_token)
 {
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_setup_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_setup_device)
 int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
 		      __rte_unused const char *dev_addr,
 		      __rte_unused int *vfio_dev_fd,
@@ -829,7 +829,7 @@ int rte_vfio_setup_device(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_release_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_release_device)
 int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 			__rte_unused const char *dev_addr,
 			__rte_unused int fd)
@@ -838,33 +838,33 @@ int rte_vfio_release_device(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
 int rte_vfio_enable(__rte_unused const char *modname)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
 int rte_vfio_is_enabled(__rte_unused const char *modname)
 {
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
 int rte_vfio_noiommu_is_enabled(void)
 {
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_clear_group)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
 int rte_vfio_clear_group(__rte_unused int vfio_group_fd)
 {
 	rte_errno = ENOTSUP;
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_num)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_num)
 int
 rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
 		       __rte_unused const char *dev_addr,
@@ -874,7 +874,7 @@ rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_container_fd)
 int
 rte_vfio_get_container_fd(void)
 {
@@ -882,7 +882,7 @@ rte_vfio_get_container_fd(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
 int
 rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
 {
@@ -890,7 +890,7 @@ rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_create)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
 int
 rte_vfio_container_create(void)
 {
@@ -898,7 +898,7 @@ rte_vfio_container_create(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_destroy)
 int
 rte_vfio_container_destroy(__rte_unused int container_fd)
 {
@@ -906,7 +906,7 @@ rte_vfio_container_destroy(__rte_unused int container_fd)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
 int
 rte_vfio_container_group_bind(__rte_unused int container_fd,
 		__rte_unused int iommu_group_num)
@@ -915,7 +915,7 @@ rte_vfio_container_group_bind(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
 int
 rte_vfio_container_group_unbind(__rte_unused int container_fd,
 		__rte_unused int iommu_group_num)
@@ -924,7 +924,7 @@ rte_vfio_container_group_unbind(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
 int
 rte_vfio_container_dma_map(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
@@ -935,7 +935,7 @@ rte_vfio_container_dma_map(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
 int
 rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index aef5824e5f..9282143918 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -55,12 +55,12 @@ headers += files(
         'rte_trace_point_register.h',
         'rte_uuid.h',
         'rte_version.h',
-        'rte_vfio.h',
 )
 
 driver_sdk_headers = files(
         'bus_driver.h',
         'dev_driver.h',
+        'rte_vfio.h',
 )
 
 # special case install the generic headers, since they go in a subdir
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index d1e8bce56b..0ddeb08f94 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -7,7 +7,11 @@
 
 /**
  * @file
- * RTE VFIO. This library provides various VFIO related utility functions.
+ * @internal
+ *
+ * RTE VFIO internal API.
+ *
+ * This library provides VFIO related utility functions for use by drivers.
  */
 
 #include <stdbool.h>
@@ -36,6 +40,7 @@ struct vfio_device_info;
 #define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
 
 /**
+ * @internal
  * Setup vfio_cfg for the device identified by its address.
  * It discovers the configured I/O MMU groups or sets a new one for the device.
  * If a new groups is assigned, the DMA mapping is performed.
@@ -60,10 +65,12 @@ struct vfio_device_info;
  *   <0 on failure.
  *   >1 if the device cannot be managed this way.
  */
+__rte_internal
 int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
+ * @internal
  * Release a device mapped to a VFIO-managed I/O MMU group.
  *
  * This function is only relevant to linux and will return
@@ -82,9 +89,11 @@ int rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
  *   0 on success.
  *   <0 on failure.
  */
+__rte_internal
 int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd);
 
 /**
+ * @internal
  * Enable a VFIO-related kmod.
  *
  * This function is only relevant to linux and will return
@@ -97,9 +106,11 @@ int rte_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
  *   0 on success.
  *   <0 on failure.
  */
+__rte_internal
 int rte_vfio_enable(const char *modname);
 
 /**
+ * @internal
  * Check whether a VFIO-related kmod is enabled.
  *
  * This function is only relevant to Linux.
@@ -111,9 +122,11 @@ int rte_vfio_enable(const char *modname);
  *   1 if true.
  *   0 otherwise.
  */
+__rte_internal
 int rte_vfio_is_enabled(const char *modname);
 
 /**
+ * @internal
  * Whether VFIO NOIOMMU mode is enabled.
  *
  * This function is only relevant to Linux.
@@ -123,10 +136,12 @@ int rte_vfio_is_enabled(const char *modname);
  *   0 if false.
  *   <0 for errors.
  */
+__rte_internal
 int rte_vfio_noiommu_is_enabled(void);
 
 /**
- * Remove group fd from internal VFIO group fd array/
+ * @internal
+ * Remove group fd from internal VFIO group fd array.
  *
  * This function is only relevant to linux and will return
  * an error on BSD.
@@ -138,11 +153,13 @@ int rte_vfio_noiommu_is_enabled(void);
  *   0 on success.
  *   <0 on failure.
  */
+__rte_internal
 int
 rte_vfio_clear_group(int vfio_group_fd);
 
 /**
- * Parse IOMMU group number for a device
+ * @internal
+ * Parse IOMMU group number for a device.
  *
  * This function is only relevant to linux and will return
  * an error on BSD.
@@ -161,12 +178,14 @@ rte_vfio_clear_group(int vfio_group_fd);
  *   0 for non-existent group or VFIO
  *  <0 for errors
  */
+__rte_internal
 int
 rte_vfio_get_group_num(const char *sysfs_base,
 		      const char *dev_addr, int *iommu_group_num);
 
 /**
- * Get device information
+ * @internal
+ * Get device information.
  *
  * This function is only relevant to Linux and will return an error on BSD.
  *
@@ -186,12 +205,13 @@ rte_vfio_get_group_num(const char *sysfs_base,
  *   0 on success.
  *  <0 on failure.
  */
-__rte_experimental
+__rte_internal
 int
 rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
+ * @internal
  * Get the default VFIO container fd
  *
  * This function is only relevant to linux and will return
@@ -201,11 +221,13 @@ rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
  *  > 0 default container fd
  *  < 0 if VFIO is not enabled or not supported
  */
+__rte_internal
 int
 rte_vfio_get_container_fd(void);
 
 /**
- * Open VFIO group fd or get an existing one
+ * @internal
+ * Open VFIO group fd or get an existing one.
  *
  * This function is only relevant to linux and will return
  * an error on BSD.
@@ -217,10 +239,12 @@ rte_vfio_get_container_fd(void);
  *  > 0 group fd
  *  < 0 for errors
  */
+__rte_internal
 int
 rte_vfio_get_group_fd(int iommu_group_num);
 
 /**
+ * @internal
  * Create a new container for device binding.
  *
  * @note Any newly allocated DPDK memory will not be mapped into these
@@ -235,10 +259,12 @@ rte_vfio_get_group_fd(int iommu_group_num);
  *   the container fd if successful
  *   <0 if failed
  */
+__rte_internal
 int
 rte_vfio_container_create(void);
 
 /**
+ * @internal
  * Destroy the container, unbind all vfio groups within it.
  *
  * @param container_fd
@@ -248,10 +274,12 @@ rte_vfio_container_create(void);
  *    0 if successful
  *   <0 if failed
  */
+__rte_internal
 int
 rte_vfio_container_destroy(int container_fd);
 
 /**
+ * @internal
  * Bind a IOMMU group to a container.
  *
  * @param container_fd
@@ -264,10 +292,12 @@ rte_vfio_container_destroy(int container_fd);
  *   group fd if successful
  *   <0 if failed
  */
+__rte_internal
 int
 rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
 
 /**
+ * @internal
  * Unbind a IOMMU group from a container.
  *
  * @param container_fd
@@ -280,10 +310,12 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
  *    0 if successful
  *   <0 if failed
  */
+__rte_internal
 int
 rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
 
 /**
+ * @internal
  * Perform DMA mapping for devices in a container.
  *
  * @param container_fd
@@ -303,11 +335,13 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
  *    0 if successful
  *   <0 if failed
  */
+__rte_internal
 int
 rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
 		uint64_t iova, uint64_t len);
 
 /**
+ * @internal
  * Perform DMA unmapping for devices in a container.
  *
  * @param container_fd
@@ -327,6 +361,7 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr,
  *    0 if successful
  *   <0 if failed
  */
+__rte_internal
 int
 rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr,
 		uint64_t iova, uint64_t len);
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index f1050ffa60..33fa04feaf 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -532,7 +532,7 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
 int
 rte_vfio_get_group_fd(int iommu_group_num)
 {
@@ -731,7 +731,7 @@ vfio_sync_default_container(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_clear_group)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
 int
 rte_vfio_clear_group(int vfio_group_fd)
 {
@@ -755,7 +755,7 @@ rte_vfio_clear_group(int vfio_group_fd)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_setup_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_setup_device)
 int
 rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info)
@@ -1009,7 +1009,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_release_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_release_device)
 int
 rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 		    int vfio_dev_fd)
@@ -1098,7 +1098,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_enable)
 int
 rte_vfio_enable(const char *modname)
 {
@@ -1175,7 +1175,7 @@ rte_vfio_enable(const char *modname)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
 int
 rte_vfio_is_enabled(const char *modname)
 {
@@ -1215,7 +1215,7 @@ vfio_set_iommu_type(int vfio_container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_vfio_get_device_info, 24.03)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_device_info)
 int
 rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info)
@@ -1349,7 +1349,7 @@ vfio_open_container_fd(bool mp_request)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_container_fd)
 int
 rte_vfio_get_container_fd(void)
 {
@@ -1363,7 +1363,7 @@ rte_vfio_get_container_fd(void)
 	return default_vfio_cfg->vfio_container_fd;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_group_num)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_num)
 int
 rte_vfio_get_group_num(const char *sysfs_base,
 		const char *dev_addr, int *iommu_group_num)
@@ -2034,7 +2034,7 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_noiommu_is_enabled)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
 int
 rte_vfio_noiommu_is_enabled(void)
 {
@@ -2067,7 +2067,7 @@ rte_vfio_noiommu_is_enabled(void)
 	return c == 'Y';
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_create)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
 int
 rte_vfio_container_create(void)
 {
@@ -2094,7 +2094,7 @@ rte_vfio_container_create(void)
 	return vfio_cfgs[i].vfio_container_fd;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_destroy)
 int
 rte_vfio_container_destroy(int container_fd)
 {
@@ -2120,7 +2120,7 @@ rte_vfio_container_destroy(int container_fd)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_bind)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
 int
 rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
@@ -2135,7 +2135,7 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
 int
 rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 {
@@ -2176,7 +2176,7 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
 int
 rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
@@ -2197,7 +2197,7 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 	return container_dma_map(vfio_cfg, vaddr, iova, len);
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
 int
 rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 6dacae7235..de7a89a829 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -453,7 +453,7 @@ eal_asprintf(char **buffer, const char *format, ...)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_map)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
 int
 rte_vfio_container_dma_map(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
@@ -464,7 +464,7 @@ rte_vfio_container_dma_map(__rte_unused int container_fd,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_container_dma_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_unmap)
 int
 rte_vfio_container_dma_unmap(__rte_unused int container_fd,
 			__rte_unused uint64_t vaddr,
-- 
2.52.0

