Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B83DCA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:13:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82CE740E26;
	Wed,  3 Sep 2025 17:13:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BD67B40E1D
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756912434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vC/tgMwSiDD/qbWBqDYpmplAPbU9MBTIcuqENXrkiqA=;
 b=gTcyx9kCEgJNY4zxz/M7+DTmG4lZpRlv00CD6ELOlJZpybop5LlaMqlSKEbqDMlXlxGNoA
 JYiIzsdvU2BtmYEppjOK/cE8Oc8b5yr7R3iNQS3kYTubcdbbYHJKxKLEnjV/IASTKUkec/
 9K/VuVIsha57dVos8uN0IPVTrDbS+6o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-yyx7I9h8NHqQjCAdB8gu2A-1; Wed,
 03 Sep 2025 11:13:51 -0400
X-MC-Unique: yyx7I9h8NHqQjCAdB8gu2A-1
X-Mimecast-MFC-AGG-ID: yyx7I9h8NHqQjCAdB8gu2A_1756912429
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4D6E1956050; Wed,  3 Sep 2025 15:13:48 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B59D119560AB; Wed,  3 Sep 2025 15:13:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 Rosen Xu <rosen.xu@altera.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC v2 2/9] vfio: remove confusing check on VFIO presence
Date: Wed,  3 Sep 2025 17:13:19 +0200
Message-ID: <20250903151327.1964490-3-david.marchand@redhat.com>
In-Reply-To: <20250903151327.1964490-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151327.1964490-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PyGK6Sw1TX8FJCfRpWUv_GsT8bhxOcV-ycRB58DzAAs_1756912429
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

Contrary to what the VFIO_PRESENT macro may suggest, there is no check on
whether VFIO is enabled in the (build system) Linux kernel configuration.

Replace check on VFIO_PRESENT with RTE_EAL_VFIO (for components built on
FreeBSD or Windows), or simply remove it otherwise.

Then remove inclusion of rte_vfio.h when the only purpose was checking
VFIO_PRESENT.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Rosen Xu <rosen.xu@altera.com>
---
 doc/api/doxy-api.conf.in                   |  1 -
 doc/guides/cryptodevs/bcmfs.rst            |  4 ----
 drivers/bus/fslmc/fslmc_bus.c              | 12 +----------
 drivers/bus/pci/linux/pci.c                | 22 --------------------
 drivers/bus/pci/linux/pci_init.h           |  6 ------
 drivers/bus/pci/linux/pci_vfio.c           | 12 -----------
 drivers/bus/platform/bus_platform_driver.h | 20 +-----------------
 drivers/bus/platform/platform.c            |  4 ----
 drivers/bus/platform/platform_params.c     |  5 -----
 drivers/crypto/bcmfs/bcmfs_vfio.c          | 11 +++++-----
 drivers/raw/ifpga/afu_pmd_n3000.c          |  4 ----
 lib/eal/include/rte_vfio.h                 | 24 ++++++++--------------
 lib/eal/linux/eal.c                        |  4 ----
 lib/eal/linux/eal_interrupts.c             | 15 --------------
 lib/eal/linux/eal_vfio.h                   | 16 ---------------
 lib/eal/linux/eal_vfio_mp_sync.c           | 10 ---------
 16 files changed, 16 insertions(+), 154 deletions(-)

diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index 28cec3232f..bedd944681 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -92,7 +92,6 @@ FILE_PATTERNS           = rte_*.h \
 PREDEFINED              = __DOXYGEN__ \
                           RTE_ATOMIC \
                           RTE_HAS_CPUSET \
-                          VFIO_PRESENT \
                           __rte_lockable= \
                           __rte_guarded_by(x)= \
                           __rte_exclusive_locks_required(x)= \
diff --git a/doc/guides/cryptodevs/bcmfs.rst b/doc/guides/cryptodevs/bcmfs.rst
index d18a253913..049808a49c 100644
--- a/doc/guides/cryptodevs/bcmfs.rst
+++ b/doc/guides/cryptodevs/bcmfs.rst
@@ -59,10 +59,6 @@ Information about kernel, rootfs and toolchain can be found at
 `Broadcom Official Website <https://www.broadcom.com/products/ethernet-connectivity
 /network-adapters/smartnic/stingray-software>`__.
 
-    .. Note::
-        To execute BCMFS PMD, it must be compiled with VFIO_PRESENT flag on the
-        compiling platform and same gets enabled in rte_vfio.h.
-
 The BCMFS PMD may be compiled natively on a Stingray platform or
 cross-compiled on an x86 platform. For example, below commands can be executed
 for cross compiling on x86 platform.
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index ebc0c1fb4f..20458d5030 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -574,9 +574,6 @@ fslmc_all_device_support_iova(void)
 static enum rte_iova_mode
 rte_dpaa2_get_iommu_class(void)
 {
-	bool is_vfio_noiommu_enabled = 1;
-	bool has_iova_va;
-
 	if (rte_eal_iova_mode() == RTE_IOVA_PA)
 		return RTE_IOVA_PA;
 
@@ -584,14 +581,7 @@ rte_dpaa2_get_iommu_class(void)
 		return RTE_IOVA_DC;
 
 	/* check if all devices on the bus support Virtual addressing or not */
-	has_iova_va = fslmc_all_device_support_iova();
-
-#ifdef VFIO_PRESENT
-	is_vfio_noiommu_enabled = rte_vfio_noiommu_is_enabled() == true ?
-						true : false;
-#endif
-
-	if (has_iova_va && !is_vfio_noiommu_enabled)
+	if (fslmc_all_device_support_iova() != 0 && rte_vfio_noiommu_is_enabled() == 0)
 		return RTE_IOVA_VA;
 
 	return RTE_IOVA_PA;
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index c20d159218..66d7e09a6e 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -64,10 +64,8 @@ rte_pci_map_device(struct rte_pci_device *dev)
 	/* try mapping the NIC resources using VFIO if it exists */
 	switch (dev->kdrv) {
 	case RTE_PCI_KDRV_VFIO:
-#ifdef VFIO_PRESENT
 		if (pci_vfio_is_enabled())
 			ret = pci_vfio_map_resource(dev);
-#endif
 		break;
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
@@ -93,10 +91,8 @@ rte_pci_unmap_device(struct rte_pci_device *dev)
 	/* try unmapping the NIC resources using VFIO if it exists */
 	switch (dev->kdrv) {
 	case RTE_PCI_KDRV_VFIO:
-#ifdef VFIO_PRESENT
 		if (pci_vfio_is_enabled())
 			pci_vfio_unmap_resource(dev);
-#endif
 		break;
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
@@ -599,7 +595,6 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 
 	switch (pdev->kdrv) {
 	case RTE_PCI_KDRV_VFIO: {
-#ifdef VFIO_PRESENT
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
@@ -612,7 +607,6 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 			iova_mode = RTE_IOVA_PA;
 		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_VA) != 0)
 			iova_mode = RTE_IOVA_VA;
-#endif
 		break;
 	}
 
@@ -641,10 +635,8 @@ int rte_pci_read_config(const struct rte_pci_device *device,
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 		return pci_uio_read_config(intr_handle, buf, len, offset);
-#ifdef VFIO_PRESENT
 	case RTE_PCI_KDRV_VFIO:
 		return pci_vfio_read_config(device, buf, len, offset);
-#endif
 	default:
 		rte_pci_device_name(&device->addr, devname,
 				    RTE_DEV_NAME_MAX_LEN);
@@ -665,10 +657,8 @@ int rte_pci_write_config(const struct rte_pci_device *device,
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 		return pci_uio_write_config(intr_handle, buf, len, offset);
-#ifdef VFIO_PRESENT
 	case RTE_PCI_KDRV_VFIO:
 		return pci_vfio_write_config(device, buf, len, offset);
-#endif
 	default:
 		rte_pci_device_name(&device->addr, devname,
 				    RTE_DEV_NAME_MAX_LEN);
@@ -688,10 +678,8 @@ int rte_pci_mmio_read(const struct rte_pci_device *device, int bar,
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 		return pci_uio_mmio_read(device, bar, buf, len, offset);
-#ifdef VFIO_PRESENT
 	case RTE_PCI_KDRV_VFIO:
 		return pci_vfio_mmio_read(device, bar, buf, len, offset);
-#endif
 	default:
 		rte_pci_device_name(&device->addr, devname,
 				    RTE_DEV_NAME_MAX_LEN);
@@ -711,10 +699,8 @@ int rte_pci_mmio_write(const struct rte_pci_device *device, int bar,
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 		return pci_uio_mmio_write(device, bar, buf, len, offset);
-#ifdef VFIO_PRESENT
 	case RTE_PCI_KDRV_VFIO:
 		return pci_vfio_mmio_write(device, bar, buf, len, offset);
-#endif
 	default:
 		rte_pci_device_name(&device->addr, devname,
 				    RTE_DEV_NAME_MAX_LEN);
@@ -731,12 +717,10 @@ rte_pci_ioport_map(struct rte_pci_device *dev, int bar,
 	int ret = -1;
 
 	switch (dev->kdrv) {
-#ifdef VFIO_PRESENT
 	case RTE_PCI_KDRV_VFIO:
 		if (pci_vfio_is_enabled())
 			ret = pci_vfio_ioport_map(dev, bar, p);
 		break;
-#endif
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 		ret = pci_uio_ioport_map(dev, bar, p);
@@ -757,11 +741,9 @@ rte_pci_ioport_read(struct rte_pci_ioport *p,
 		void *data, size_t len, off_t offset)
 {
 	switch (p->dev->kdrv) {
-#ifdef VFIO_PRESENT
 	case RTE_PCI_KDRV_VFIO:
 		pci_vfio_ioport_read(p, data, len, offset);
 		break;
-#endif
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 		pci_uio_ioport_read(p, data, len, offset);
@@ -777,11 +759,9 @@ rte_pci_ioport_write(struct rte_pci_ioport *p,
 		const void *data, size_t len, off_t offset)
 {
 	switch (p->dev->kdrv) {
-#ifdef VFIO_PRESENT
 	case RTE_PCI_KDRV_VFIO:
 		pci_vfio_ioport_write(p, data, len, offset);
 		break;
-#endif
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 		pci_uio_ioport_write(p, data, len, offset);
@@ -798,12 +778,10 @@ rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 	int ret = -1;
 
 	switch (p->dev->kdrv) {
-#ifdef VFIO_PRESENT
 	case RTE_PCI_KDRV_VFIO:
 		if (pci_vfio_is_enabled())
 			ret = pci_vfio_ioport_unmap(p);
 		break;
-#endif
 	case RTE_PCI_KDRV_IGB_UIO:
 	case RTE_PCI_KDRV_UIO_GENERIC:
 		ret = pci_uio_ioport_unmap(p);
diff --git a/drivers/bus/pci/linux/pci_init.h b/drivers/bus/pci/linux/pci_init.h
index a4d37c0d0a..6949dd57d9 100644
--- a/drivers/bus/pci/linux/pci_init.h
+++ b/drivers/bus/pci/linux/pci_init.h
@@ -5,8 +5,6 @@
 #ifndef EAL_PCI_INIT_H_
 #define EAL_PCI_INIT_H_
 
-#include <rte_vfio.h>
-
 #include "private.h"
 
 /** IO resource type: */
@@ -50,8 +48,6 @@ void pci_uio_ioport_write(struct rte_pci_ioport *p,
 			  const void *data, size_t len, off_t offset);
 int pci_uio_ioport_unmap(struct rte_pci_ioport *p);
 
-#ifdef VFIO_PRESENT
-
 /* access config space */
 int pci_vfio_read_config(const struct rte_pci_device *dev,
 			 void *buf, size_t len, off_t offs);
@@ -77,6 +73,4 @@ int pci_vfio_unmap_resource(struct rte_pci_device *dev);
 
 int pci_vfio_is_enabled(void);
 
-#endif
-
 #endif /* EAL_PCI_INIT_H_ */
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 5317170231..d0844585fe 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -27,17 +27,6 @@
 #include "pci_init.h"
 #include "private.h"
 
-/**
- * @file
- * PCI probing using Linux VFIO.
- *
- * This code tries to determine if the PCI device is bound to VFIO driver,
- * and initialize it (map BARs, set up interrupts) if that's the case.
- *
- */
-
-#ifdef VFIO_PRESENT
-
 static struct rte_tailq_elem rte_vfio_tailq = {
 	.name = "VFIO_RESOURCE_LIST",
 };
@@ -1327,4 +1316,3 @@ pci_vfio_is_enabled(void)
 	}
 	return status;
 }
-#endif
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index ef4b27c0c0..76403043c1 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -15,9 +15,9 @@
 
 #include <dev_driver.h>
 #include <rte_common.h>
+#include <rte_compat.h>
 #include <rte_dev.h>
 #include <rte_os.h>
-#include <rte_vfio.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -144,8 +144,6 @@ RTE_PMD_EXPORT_NAME(nm)
 #define RTE_PMD_REGISTER_ALIAS(nm, alias) \
 static const char *pdrvinit_ ## nm ## _alias = RTE_STR(alias)
 
-#ifdef VFIO_PRESENT
-
 /**
  * Register a platform device driver.
  *
@@ -170,22 +168,6 @@ void rte_platform_register(struct rte_platform_driver *pdrv);
 __rte_internal
 void rte_platform_unregister(struct rte_platform_driver *pdrv);
 
-#else
-
-__rte_internal
-static inline void
-rte_platform_register(struct rte_platform_driver *pdrv __rte_unused)
-{
-}
-
-__rte_internal
-static inline void
-rte_platform_unregister(struct rte_platform_driver *pdrv __rte_unused)
-{
-}
-
-#endif /* VFIO_PRESENT */
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 0f50027236..90524fd961 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -25,8 +25,6 @@
 
 #include "private.h"
 
-#ifdef VFIO_PRESENT
-
 #define PLATFORM_BUS_DEVICES_PATH "/sys/bus/platform/devices"
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_register)
@@ -647,5 +645,3 @@ struct rte_platform_bus platform_bus = {
 
 RTE_REGISTER_BUS(platform, platform_bus.bus);
 RTE_LOG_REGISTER_DEFAULT(platform_bus_logtype, NOTICE);
-
-#endif /* VFIO_PRESENT */
diff --git a/drivers/bus/platform/platform_params.c b/drivers/bus/platform/platform_params.c
index 8a6214b97c..65b20d121f 100644
--- a/drivers/bus/platform/platform_params.c
+++ b/drivers/bus/platform/platform_params.c
@@ -10,13 +10,10 @@
 #include <rte_dev.h>
 #include <rte_errno.h>
 #include <rte_kvargs.h>
-#include <rte_vfio.h>
 
 #include "bus_platform_driver.h"
 #include "private.h"
 
-#ifdef VFIO_PRESENT
-
 enum platform_params {
 	RTE_PLATFORM_PARAM_NAME,
 };
@@ -73,5 +70,3 @@ platform_bus_dev_iterate(const void *start, const char *str,
 
 	return dev;
 }
-
-#endif /* VFIO_PRESENT */
diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c b/drivers/crypto/bcmfs/bcmfs_vfio.c
index dc2def580f..8d6ea16544 100644
--- a/drivers/crypto/bcmfs/bcmfs_vfio.c
+++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
@@ -7,13 +7,14 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 
-#include <rte_vfio.h>
-
 #include "bcmfs_device.h"
 #include "bcmfs_logs.h"
 #include "bcmfs_vfio.h"
 
-#ifdef VFIO_PRESENT
+#ifdef RTE_EAL_VFIO
+
+#include <rte_vfio.h>
+
 static int
 vfio_map_dev_obj(const char *path, const char *dev_obj,
 		 uint32_t *size, void **addr, int *dev_fd)
@@ -93,7 +94,7 @@ bcmfs_release_vfio(struct bcmfs_device *dev)
 		return;
 	}
 }
-#else
+#else /* ! RTE_EAL_VFIO */
 int
 bcmfs_attach_vfio(struct bcmfs_device *dev __rte_unused)
 {
@@ -104,4 +105,4 @@ void
 bcmfs_release_vfio(struct bcmfs_device *dev __rte_unused)
 {
 }
-#endif
+#endif /* RTE_EAL_VFIO */
diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c b/drivers/raw/ifpga/afu_pmd_n3000.c
index 6aae1b224e..0882a27701 100644
--- a/drivers/raw/ifpga/afu_pmd_n3000.c
+++ b/drivers/raw/ifpga/afu_pmd_n3000.c
@@ -1473,7 +1473,6 @@ static struct rte_pci_device *n3000_afu_get_pci_dev(struct afu_rawdev *dev)
 	return RTE_DEV_TO_PCI(afudev->rawdev->device);
 }
 
-#ifdef VFIO_PRESENT
 static int dma_afu_set_irqs(struct afu_rawdev *dev, uint32_t vec_start,
 	uint32_t count, int *efds)
 {
@@ -1511,7 +1510,6 @@ static int dma_afu_set_irqs(struct afu_rawdev *dev, uint32_t vec_start,
 	rte_free(irq_set);
 	return ret;
 }
-#endif
 
 static void *n3000_afu_get_port_addr(struct afu_rawdev *dev)
 {
@@ -1724,10 +1722,8 @@ static int dma_afu_ctx_init(struct afu_rawdev *dev, int index, uint8_t *addr)
 			IFPGA_RAWDEV_PMD_ERR("eventfd create failed");
 			return -EBADF;
 		}
-#ifdef VFIO_PRESENT
 		if (dma_afu_set_irqs(dev, vec_start, 1, efds))
 			IFPGA_RAWDEV_PMD_ERR("DMA interrupt setup failed");
-#endif
 	}
 	ctx->event_fd = efds[0];
 
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 923293040b..594d504c56 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -15,24 +15,16 @@
 
 #include <rte_compat.h>
 
-/*
- * determine if VFIO is present on the system
- */
-#if !defined(VFIO_PRESENT) && defined(RTE_EAL_VFIO)
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 6, 0)
-#define VFIO_PRESENT
-#endif /* kernel version >= 3.6.0 */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 0, 0)
-#define HAVE_VFIO_DEV_REQ_INTERFACE
-#endif /* kernel version >= 4.0.0 */
-#endif /* RTE_EAL_VFIO */
-
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-#ifdef VFIO_PRESENT
+#ifdef RTE_EAL_VFIO
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 0, 0)
+#define HAVE_VFIO_DEV_REQ_INTERFACE
+#endif /* kernel version >= 4.0.0 */
 
 #include <linux/vfio.h>
 
@@ -102,12 +94,12 @@ struct vfio_device_feature_bus_master {
 };
 #endif
 
-#else /* not VFIO_PRESENT */
+#else /* ! RTE_EAL_VFIO */
 
 /* we don't need an actual definition, only pointer is used */
 struct vfio_device_info;
 
-#endif /* VFIO_PRESENT */
+#endif /* RTE_EAL_VFIO */
 
 #define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 52efb8626b..708a387265 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -1121,14 +1121,12 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-#ifdef VFIO_PRESENT
 	if (rte_vfio_enable("vfio")) {
 		rte_eal_init_alert("Cannot init VFIO");
 		rte_errno = EAGAIN;
 		rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
 		return -1;
 	}
-#endif
 	/* in secondary processes, memory init may allocate additional fbarrays
 	 * not present in primary processes, so to avoid any potential issues,
 	 * initialize memzones first.
@@ -1330,9 +1328,7 @@ rte_eal_cleanup(void)
 		rte_memseg_walk(mark_freeable, NULL);
 
 	rte_service_finalize();
-#ifdef VFIO_PRESENT
 	vfio_mp_sync_cleanup();
-#endif
 	rte_mp_channel_cleanup();
 	eal_bus_cleanup();
 	rte_eal_alarm_cleanup();
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 4ec78de82c..d420ecf947 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -57,9 +57,7 @@ union intr_pipefds{
  */
 union rte_intr_read_buffer {
 	int uio_intr_count;              /* for uio device */
-#ifdef VFIO_PRESENT
 	uint64_t vfio_intr_count;        /* for vfio device */
-#endif
 	uint64_t timerfd_num;            /* for timerfd */
 	char charbuf[16];                /* for others */
 };
@@ -95,8 +93,6 @@ static struct rte_intr_source_list intr_sources;
 static rte_thread_t intr_thread;
 
 /* VFIO interrupts */
-#ifdef VFIO_PRESENT
-
 #define IRQ_SET_BUF_LEN  (sizeof(struct vfio_irq_set) + sizeof(int))
 /* irq set buffer length for queue interrupts and LSC interrupt */
 #define MSIX_IRQ_SET_BUF_LEN (sizeof(struct vfio_irq_set) + \
@@ -401,7 +397,6 @@ vfio_disable_req(const struct rte_intr_handle *intr_handle)
 	return ret;
 }
 #endif
-#endif
 
 static int
 uio_intx_intr_disable(const struct rte_intr_handle *intr_handle)
@@ -734,7 +729,6 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
 	case RTE_INTR_HANDLE_ALARM:
 		rc = -1;
 		break;
-#ifdef VFIO_PRESENT
 	case RTE_INTR_HANDLE_VFIO_MSIX:
 		if (vfio_enable_msix(intr_handle))
 			rc = -1;
@@ -752,7 +746,6 @@ rte_intr_enable(const struct rte_intr_handle *intr_handle)
 		if (vfio_enable_req(intr_handle))
 			rc = -1;
 		break;
-#endif
 #endif
 	/* not used at this moment */
 	case RTE_INTR_HANDLE_DEV_EVENT:
@@ -807,7 +800,6 @@ rte_intr_ack(const struct rte_intr_handle *intr_handle)
 	/* not used at this moment */
 	case RTE_INTR_HANDLE_ALARM:
 		return -1;
-#ifdef VFIO_PRESENT
 	/* VFIO MSI* is implicitly acked unlike INTx, nothing to do */
 	case RTE_INTR_HANDLE_VFIO_MSIX:
 	case RTE_INTR_HANDLE_VFIO_MSI:
@@ -819,7 +811,6 @@ rte_intr_ack(const struct rte_intr_handle *intr_handle)
 #ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 	case RTE_INTR_HANDLE_VFIO_REQ:
 		return -1;
-#endif
 #endif
 	/* not used at this moment */
 	case RTE_INTR_HANDLE_DEV_EVENT:
@@ -868,7 +859,6 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 	case RTE_INTR_HANDLE_ALARM:
 		rc = -1;
 		break;
-#ifdef VFIO_PRESENT
 	case RTE_INTR_HANDLE_VFIO_MSIX:
 		if (vfio_disable_msix(intr_handle))
 			rc = -1;
@@ -886,7 +876,6 @@ rte_intr_disable(const struct rte_intr_handle *intr_handle)
 		if (vfio_disable_req(intr_handle))
 			rc = -1;
 		break;
-#endif
 #endif
 	/* not used at this moment */
 	case RTE_INTR_HANDLE_DEV_EVENT:
@@ -948,7 +937,6 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 		case RTE_INTR_HANDLE_ALARM:
 			bytes_read = sizeof(buf.timerfd_num);
 			break;
-#ifdef VFIO_PRESENT
 #ifdef HAVE_VFIO_DEV_REQ_INTERFACE
 		case RTE_INTR_HANDLE_VFIO_REQ:
 #endif
@@ -957,7 +945,6 @@ eal_intr_process_interrupts(struct epoll_event *events, int nfds)
 		case RTE_INTR_HANDLE_VFIO_LEGACY:
 			bytes_read = sizeof(buf.vfio_intr_count);
 			break;
-#endif
 		case RTE_INTR_HANDLE_VDEV:
 		case RTE_INTR_HANDLE_EXT:
 			bytes_read = 0;
@@ -1221,13 +1208,11 @@ eal_intr_proc_rxtx_intr(int fd, const struct rte_intr_handle *intr_handle)
 	case RTE_INTR_HANDLE_UIO_INTX:
 		bytes_read = sizeof(buf.uio_intr_count);
 		break;
-#ifdef VFIO_PRESENT
 	case RTE_INTR_HANDLE_VFIO_MSIX:
 	case RTE_INTR_HANDLE_VFIO_MSI:
 	case RTE_INTR_HANDLE_VFIO_LEGACY:
 		bytes_read = sizeof(buf.vfio_intr_count);
 		break;
-#endif
 	case RTE_INTR_HANDLE_VDEV:
 		bytes_read = rte_intr_efd_counter_size_get(intr_handle);
 		/* For vdev, number of bytes to read is set by driver */
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 23a787ad20..e7d855c032 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -7,20 +7,6 @@
 
 #include <rte_common.h>
 
-/*
- * determine if VFIO is present on the system
- */
-#if !defined(VFIO_PRESENT) && defined(RTE_EAL_VFIO)
-#include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 6, 0)
-#define VFIO_PRESENT
-#else
-#pragma message("VFIO configured but not supported by this kernel, disabling.")
-#endif /* kernel version >= 3.6.0 */
-#endif /* RTE_EAL_VFIO */
-
-#ifdef VFIO_PRESENT
-
 #include <stdint.h>
 #include <linux/vfio.h>
 
@@ -154,6 +140,4 @@ struct vfio_mp_param {
 	};
 };
 
-#endif /* VFIO_PRESENT */
-
 #endif /* EAL_VFIO_H_ */
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index ce14e260fe..8230f3d24d 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -14,15 +14,6 @@
 #include "eal_private.h"
 #include "eal_vfio.h"
 
-/**
- * @file
- * VFIO socket for communication between primary and secondary processes.
- *
- * This file is only compiled if RTE_EAL_VFIO is set.
- */
-
-#ifdef VFIO_PRESENT
-
 static int
 vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 {
@@ -129,4 +120,3 @@ vfio_mp_sync_cleanup(void)
 
 	rte_mp_action_unregister(EAL_VFIO_MP);
 }
-#endif
-- 
2.51.0

