Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A95CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F172406BC;
	Wed,  6 May 2026 17:54:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 27F7B4066C
 for <dev@dpdk.org>; Wed,  6 May 2026 17:54:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778082846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VXC46aMU9FHR4OwXzA83eV7V+klUVo8K5ASi+zSEnI=;
 b=jJgqa/Ll0diMA7/+9bITsApITAjcJwwx8OsQMeQgxvic/p2zHf/yUssewFw4EGcKVHIxx7
 LvJ/sT5tBq3KA5aKlLkNTJNCqqQLNePoClj+AskkSc3cDkvpwdNlxxS1CYlC6gqmv/wHEB
 QSzWx3Bt4M8ofNlZJjBLSWpEPt7ov7k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-2Avpm2tDOYGcL3Ga3pvLzw-1; Wed,
 06 May 2026 11:54:01 -0400
X-MC-Unique: 2Avpm2tDOYGcL3Ga3pvLzw-1
X-Mimecast-MFC-AGG-ID: 2Avpm2tDOYGcL3Ga3pvLzw_1778082839
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE4B81956095; Wed,  6 May 2026 15:53:58 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E82A01801A63; Wed,  6 May 2026 15:53:53 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v2 15/23] bus: implement probe in EAL
Date: Wed,  6 May 2026 17:51:47 +0200
Message-ID: <20260506155201.2709810-16-david.marchand@redhat.com>
In-Reply-To: <20260506155201.2709810-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RACQxkwMpUQ2TdfdEeonVeqki2_0V34JjtYE6Z1XVtY_1778082839
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

Add rte_bus_generic_probe() in EAL to eliminate duplicated device
probing logic across bus drivers. This function implements the common
pattern of iterating devices, finding matching drivers, and calling
the bus probe_device operation.

The generic probe includes rte_bus_device_is_ignored() check to skip
ignored devices during probing. Errors from probe_device() are logged
except for -EEXIST, which is silently skipped to support device reprobing.

Notes:
- rte_vmbus_probe() is kept as it's an exported public API, but
  the .probe field is removed from rte_vmbus_bus structure.
- rte_ifpga_device_name() is removed as it has no user remaining.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 39 +------------------
 drivers/bus/cdx/cdx.c                    | 38 +-----------------
 drivers/bus/dpaa/dpaa_bus.c              | 30 +--------------
 drivers/bus/fslmc/fslmc_bus.c            | 29 +-------------
 drivers/bus/ifpga/bus_ifpga_driver.h     |  9 -----
 drivers/bus/ifpga/ifpga_bus.c            | 34 +---------------
 drivers/bus/pci/pci_common.c             | 42 +-------------------
 drivers/bus/platform/platform.c          | 33 +---------------
 drivers/bus/uacce/uacce.c                | 33 +---------------
 drivers/bus/vdev/vdev.c                  | 37 +-----------------
 drivers/bus/vmbus/vmbus_common.c         | 35 +----------------
 drivers/dma/idxd/idxd_bus.c              | 21 +---------
 lib/eal/common/eal_common_bus.c          | 49 +++++++++++++++++++++++-
 lib/eal/include/bus_driver.h             | 23 ++++++++++-
 14 files changed, 81 insertions(+), 371 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index c210e303ce..206b69bbd4 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -152,43 +152,6 @@ rte_auxiliary_driver_remove_dev(struct rte_auxiliary_device *dev)
 	return 0;
 }
 
-/*
- * Scan the content of the auxiliary bus, and call the probe function for
- * all registered drivers to try to probe discovered devices.
- */
-static int
-auxiliary_probe(void)
-{
-	struct rte_auxiliary_device *dev = NULL;
-	size_t probed = 0, failed = 0;
-
-	RTE_BUS_FOREACH_DEV(dev, &auxiliary_bus.bus) {
-		struct rte_driver *drv = NULL;
-		int ret;
-
-		probed++;
-
-next_driver:
-		drv = rte_bus_find_driver(&auxiliary_bus.bus, drv, &dev->device);
-		if (drv == NULL)
-			continue;
-
-		ret = auxiliary_bus.bus.probe_device(drv, &dev->device);
-		if (ret < 0) {
-			if (ret != -EEXIST) {
-				AUXILIARY_LOG(ERR, "Requested device %s cannot be used",
-					      dev->name);
-				rte_errno = errno;
-				failed++;
-			}
-		} else if (ret > 0) {
-			goto next_driver;
-		}
-	}
-
-	return (probed && probed == failed) ? -1 : 0;
-}
-
 static int
 auxiliary_parse(const char *name, void *addr)
 {
@@ -302,7 +265,7 @@ auxiliary_get_iommu_class(void)
 struct rte_auxiliary_bus auxiliary_bus = {
 	.bus = {
 		.scan = auxiliary_scan,
-		.probe = auxiliary_probe,
+		.probe = rte_bus_generic_probe,
 		.cleanup = auxiliary_cleanup,
 		.find_device = rte_bus_generic_find_device,
 		.match = auxiliary_bus_match,
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 64fb0a8534..e1405d1372 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -347,42 +347,6 @@ cdx_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	return ret;
 }
 
-/*
- * Scan the content of the CDX bus, and call the probe() function for
- * all registered drivers that have a matching entry in its id_table
- * for discovered devices.
- */
-static int
-cdx_probe(void)
-{
-	struct rte_cdx_device *dev = NULL;
-	size_t probed = 0, failed = 0;
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_cdx_bus.bus) {
-		struct rte_driver *drv = NULL;
-		int ret;
-
-		probed++;
-
-next_driver:
-		drv = rte_bus_find_driver(&rte_cdx_bus.bus, drv, &dev->device);
-		if (drv == NULL)
-			continue;
-
-		ret = rte_cdx_bus.bus.probe_device(drv, &dev->device);
-		if (ret < 0) {
-			CDX_BUS_ERR("Requested device %s cannot be used",
-				dev->name);
-			rte_errno = errno;
-			failed++;
-		} else if (ret > 0) {
-			goto next_driver;
-		}
-	}
-
-	return (probed && probed == failed) ? -1 : 0;
-}
-
 static int
 cdx_parse(const char *name, void *addr)
 {
@@ -489,7 +453,7 @@ cdx_get_iommu_class(void)
 struct rte_cdx_bus rte_cdx_bus = {
 	.bus = {
 		.scan = cdx_scan,
-		.probe = cdx_probe,
+		.probe = rte_bus_generic_probe,
 		.find_device = rte_bus_generic_find_device,
 		.match = cdx_bus_match,
 		.probe_device = cdx_probe_device,
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 43d71cefa4..7f4a85a91d 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -779,31 +779,6 @@ rte_dpaa_bus_scan(void)
 	return 0;
 }
 
-static int
-rte_dpaa_bus_probe(void)
-{
-	struct rte_dpaa_device *dev;
-
-	/* For each registered driver, and device, call the driver->probe */
-	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
-		struct rte_driver *driver = NULL;
-		int ret;
-
-next_driver:
-		driver = rte_bus_find_driver(&rte_dpaa_bus.bus, driver, &dev->device);
-		if (driver == NULL)
-			continue;
-
-		ret = rte_dpaa_bus.bus.probe_device(driver, &dev->device);
-		if (ret < 0)
-			DPAA_BUS_ERR("Failed to probe device %s", dev->name);
-		else if (ret > 0)
-			goto next_driver;
-	}
-
-	return 0;
-}
-
 /*
  * Get iommu class of DPAA2 devices on the bus.
  */
@@ -824,9 +799,6 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	struct rte_dpaa_driver *dpaa_drv = RTE_BUS_DRIVER(drv, *dpaa_drv);
 	int ret;
 
-	if (rte_bus_device_is_ignored(&rte_dpaa_bus.bus, dpaa_dev->name))
-		return 0;
-
 	ret = dpaa_drv->probe(dpaa_drv, dpaa_dev);
 	if (ret != 0) {
 		DPAA_BUS_ERR("unable to probe: %s", dpaa_dev->name);
@@ -890,7 +862,7 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
 static struct rte_dpaa_bus rte_dpaa_bus = {
 	.bus = {
 		.scan = rte_dpaa_bus_scan,
-		.probe = rte_dpaa_bus_probe,
+		.probe = rte_bus_generic_probe,
 		.parse = rte_dpaa_bus_parse,
 		.dev_compare = dpaa_bus_dev_compare,
 		.find_device = rte_bus_generic_find_device,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 156f4e295f..29ef3b58cf 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -446,33 +446,6 @@ rte_fslmc_close(void)
 	return 0;
 }
 
-static int
-rte_fslmc_probe(void)
-{
-	struct rte_dpaa2_device *dev;
-	int ret;
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
-		struct rte_driver *driver = NULL;
-
-		if (rte_bus_device_is_ignored(&rte_fslmc_bus.bus, dev->device.name))
-			continue;
-
-next_driver:
-		driver = rte_bus_find_driver(&rte_fslmc_bus.bus, driver, &dev->device);
-		if (driver == NULL)
-			continue;
-
-		ret = rte_fslmc_bus.bus.probe_device(driver, &dev->device);
-		if (ret < 0)
-			DPAA2_BUS_ERR("Failed to probe device %s", dev->device.name);
-		else if (ret > 0)
-			goto next_driver;
-	}
-
-	return 0;
-}
-
 /*register a fslmc bus based dpaa2 driver */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_register)
 void
@@ -578,7 +551,7 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 struct rte_fslmc_bus rte_fslmc_bus = {
 	.bus = {
 		.scan = rte_fslmc_scan,
-		.probe = rte_fslmc_probe,
+		.probe = rte_bus_generic_probe,
 		.cleanup = rte_fslmc_close,
 		.parse = rte_fslmc_parse,
 		.dev_compare = fslmc_dev_compare,
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index c1ff38bdb2..b56916167c 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -99,15 +99,6 @@ struct rte_afu_driver {
 	const struct rte_afu_uuid *id_table;    /**< AFU uuid within FPGA. */
 };
 
-__rte_internal
-static inline const char *
-rte_ifpga_device_name(const struct rte_afu_device *afu)
-{
-	if (afu && afu->device.name)
-		return afu->device.name;
-	return NULL;
-}
-
 /**
  * Register a ifpga afu device driver.
  *
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index d3f3370bc5..b2eb4f4413 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -287,38 +287,6 @@ ifpga_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	return ret;
 }
 
-/*
- * Scan the content of the Intel FPGA bus, and call the probe() function for
- * all registered drivers that have a matching entry in its id_table
- * for discovered devices.
- */
-static int
-ifpga_probe(void)
-{
-	struct rte_afu_device *afu_dev = NULL;
-	int ret = 0;
-
-	RTE_BUS_FOREACH_DEV(afu_dev, &rte_ifpga_bus) {
-		struct rte_driver *drv = NULL;
-
-next_driver:
-		drv = rte_bus_find_driver(&rte_ifpga_bus, drv, &afu_dev->device);
-		if (drv == NULL)
-			continue;
-
-		ret = rte_ifpga_bus.probe_device(drv, &afu_dev->device);
-		if (ret == -EEXIST)
-			continue;
-		if (ret < 0)
-			IFPGA_BUS_ERR("failed to initialize %s device",
-				rte_ifpga_device_name(afu_dev));
-		else if (ret > 0)
-			goto next_driver;
-	}
-
-	return ret;
-}
-
 /*
  * Cleanup the content of the Intel FPGA bus, and call the remove() function
  * for all registered devices.
@@ -421,7 +389,7 @@ ifpga_parse(const char *name, void *addr)
 
 static struct rte_bus rte_ifpga_bus = {
 	.scan        = ifpga_scan,
-	.probe       = ifpga_probe,
+	.probe       = rte_bus_generic_probe,
 	.cleanup     = ifpga_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match       = ifpga_bus_match,
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 02542a903a..a507360ef6 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -334,46 +334,6 @@ rte_pci_detach_dev(struct rte_pci_device *dev)
 	return 0;
 }
 
-/*
- * Scan the content of the PCI bus, and call the probe() function for
- * all registered drivers that have a matching entry in its id_table
- * for discovered devices.
- */
-static int
-pci_probe(void)
-{
-	struct rte_pci_device *dev = NULL;
-	size_t probed = 0, failed = 0;
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
-		struct rte_driver *drv = NULL;
-		int ret;
-
-		probed++;
-
-next_driver:
-		drv = rte_bus_find_driver(&rte_pci_bus.bus, drv, &dev->device);
-		if (drv == NULL)
-			continue;
-
-		ret = rte_pci_bus.bus.probe_device(drv, &dev->device);
-		if (ret < 0) {
-			if (ret != -EEXIST) {
-				PCI_LOG(ERR, "Requested device " PCI_PRI_FMT " cannot be used",
-					dev->addr.domain, dev->addr.bus,
-					dev->addr.devid, dev->addr.function);
-				rte_errno = errno;
-				failed++;
-			}
-			ret = 0;
-		} else if (ret > 0) {
-			goto next_driver;
-		}
-	}
-
-	return (probed && probed == failed) ? -1 : 0;
-}
-
 static int
 pci_cleanup(void)
 {
@@ -825,7 +785,7 @@ struct rte_pci_bus rte_pci_bus = {
 	.bus = {
 		.allow_multi_probe = true,
 		.scan = rte_pci_scan,
-		.probe = pci_probe,
+		.probe = rte_bus_generic_probe,
 		.cleanup = pci_cleanup,
 		.find_device = rte_bus_generic_find_device,
 		.match = pci_bus_match,
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 3d04ba4d25..01c8239cbb 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -401,40 +401,9 @@ platform_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 	return match;
 }
 
-static int
-platform_bus_probe(void)
-{
-	struct rte_platform_device *pdev;
-
-	RTE_BUS_FOREACH_DEV(pdev, &platform_bus.bus) {
-		struct rte_driver *drv = NULL;
-		int ret;
-
-next_driver:
-		drv = rte_bus_find_driver(&platform_bus.bus, drv, &pdev->device);
-		if (drv == NULL)
-			continue;
-
-		ret = platform_bus.bus.probe_device(drv, &pdev->device);
-		if (ret == -EBUSY) {
-			PLATFORM_LOG_LINE(DEBUG, "device %s already probed", pdev->name);
-			continue;
-		}
-		if (ret < 0)
-			PLATFORM_LOG_LINE(ERR, "failed to probe %s", pdev->name);
-		else if (ret > 0)
-			goto next_driver;
-	}
-
-	return 0;
-}
-
 static int
 platform_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
-	if (rte_bus_device_is_ignored(&platform_bus.bus, dev->name))
-		return -EPERM;
-
 	if (!dev_is_bound_vfio_platform(dev->name))
 		return -EPERM;
 
@@ -547,7 +516,7 @@ platform_bus_cleanup(void)
 struct rte_platform_bus platform_bus = {
 	.bus = {
 		.scan = platform_bus_scan,
-		.probe = platform_bus_probe,
+		.probe = rte_bus_generic_probe,
 		.find_device = rte_bus_generic_find_device,
 		.match = platform_bus_match,
 		.probe_device = platform_bus_probe_device,
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 3dedc783ce..b0deb39185 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -374,37 +374,6 @@ uacce_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	return ret;
 }
 
-static int
-uacce_probe(void)
-{
-	size_t probed = 0, failed = 0;
-	struct rte_uacce_device *dev;
-
-	RTE_BUS_FOREACH_DEV(dev, &uacce_bus.bus) {
-		struct rte_driver *drv = NULL;
-		int ret;
-
-		probed++;
-
-next_driver:
-		drv = rte_bus_find_driver(&uacce_bus.bus, drv, &dev->device);
-		if (drv == NULL)
-			continue;
-
-		ret = uacce_bus.bus.probe_device(drv, &dev->device);
-		if (ret < 0) {
-			UACCE_BUS_LOG(ERR, "Requested device %s cannot be used",
-				dev->name);
-			rte_errno = errno;
-			failed++;
-		} else if (ret > 0) {
-			goto next_driver;
-		}
-	}
-
-	return (probed && probed == failed) ? -1 : 0;
-}
-
 static int
 uacce_cleanup(void)
 {
@@ -596,7 +565,7 @@ rte_uacce_unregister(struct rte_uacce_driver *driver)
 static struct rte_uacce_bus uacce_bus = {
 	.bus = {
 		.scan = uacce_scan,
-		.probe = uacce_probe,
+		.probe = rte_bus_generic_probe,
 		.cleanup = uacce_cleanup,
 		.match = uacce_bus_match,
 		.probe_device = uacce_probe_device,
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 4da9a2c950..b0a44e9aa7 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -546,41 +546,6 @@ vdev_scan(void)
 	return 0;
 }
 
-static int
-vdev_probe(void)
-{
-	struct rte_vdev_device *dev;
-	int r, ret = 0;
-
-	/* call the init function for each virtual device */
-	RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
-		struct rte_driver *drv = NULL;
-
-		/* we don't use the vdev lock here, as it's only used in DPDK
-		 * initialization; and we don't want to hold such a lock when
-		 * we call each driver probe.
-		 */
-
-next_driver:
-		drv = rte_bus_find_driver(&rte_vdev_bus, drv, &dev->device);
-		if (drv == NULL)
-			continue;
-
-		r = rte_vdev_bus.probe_device(drv, &dev->device);
-		if (r < 0) {
-			if (r == -EEXIST)
-				continue;
-			VDEV_LOG(ERR, "failed to initialize %s device",
-				rte_vdev_device_name(dev));
-			ret = -1;
-		} else if (r > 0) {
-			goto next_driver;
-		}
-	}
-
-	return ret;
-}
-
 static int
 vdev_cleanup(void)
 {
@@ -661,7 +626,7 @@ vdev_get_iommu_class(void)
 
 static struct rte_bus rte_vdev_bus = {
 	.scan = vdev_scan,
-	.probe = vdev_probe,
+	.probe = rte_bus_generic_probe,
 	.cleanup = vdev_cleanup,
 	.find_device = vdev_find_device,
 	.match = vdev_bus_match,
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 24b1c24f43..bd375ae6bb 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -135,38 +135,7 @@ RTE_EXPORT_SYMBOL(rte_vmbus_probe)
 int
 rte_vmbus_probe(void)
 {
-	struct rte_vmbus_device *dev;
-	size_t probed = 0, failed = 0;
-	char ubuf[RTE_UUID_STRLEN];
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_vmbus_bus.bus) {
-		struct rte_driver *drv = NULL;
-		int ret;
-
-		probed++;
-
-		rte_uuid_unparse(dev->device_id, ubuf, sizeof(ubuf));
-
-		if (rte_bus_device_is_ignored(&rte_vmbus_bus.bus, ubuf))
-			continue;
-
-next_driver:
-		drv = rte_bus_find_driver(&rte_vmbus_bus.bus, drv, &dev->device);
-		if (drv == NULL)
-			continue;
-
-		ret = rte_vmbus_bus.bus.probe_device(drv, &dev->device);
-		if (ret < 0) {
-			VMBUS_LOG(NOTICE,
-				"Requested device %s cannot be used", ubuf);
-			rte_errno = errno;
-			failed++;
-		} else if (ret > 0) {
-			goto next_driver;
-		}
-	}
-
-	return (probed && probed == failed) ? -1 : 0;
+	return rte_bus_generic_probe(&rte_vmbus_bus.bus);
 }
 
 static int
@@ -247,7 +216,7 @@ rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 struct rte_vmbus_bus rte_vmbus_bus = {
 	.bus = {
 		.scan = rte_vmbus_scan,
-		.probe = rte_vmbus_probe,
+		.probe = rte_bus_generic_probe,
 		.cleanup = rte_vmbus_cleanup,
 		.find_device = rte_bus_generic_find_device,
 		.match = vmbus_bus_match,
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 8215bcbba6..93bde69ff9 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -45,7 +45,6 @@ struct dsa_bus;
 static int dsa_scan(void);
 static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev);
 static int dsa_probe_device(struct rte_driver *drv, struct rte_device *dev);
-static int dsa_probe(void);
 static enum rte_iova_mode dsa_get_iommu_class(void);
 static int dsa_addr_parse(const char *name, void *addr);
 
@@ -60,9 +59,9 @@ struct dsa_bus {
 struct dsa_bus dsa_bus = {
 	.bus = {
 		.scan = dsa_scan,
+		.probe = rte_bus_generic_probe,
 		.match = dsa_match,
 		.probe_device = dsa_probe_device,
-		.probe = dsa_probe,
 		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = dsa_get_iommu_class,
 		.parse = dsa_addr_parse,
@@ -264,24 +263,6 @@ is_for_this_process_use(const char *name)
 	return retval;
 }
 
-static int
-dsa_probe(void)
-{
-	struct rte_dsa_device *dev;
-
-	RTE_BUS_FOREACH_DEV(dev, &dsa_bus.bus) {
-		if (dsa_match(&dsa_bus.driver, &dev->device) &&
-				!rte_bus_device_is_ignored(&dsa_bus.bus, dev->device.name)) {
-			dev->device.driver = &dsa_bus.driver;
-			dsa_probe_device(&dsa_bus.driver, &dev->device);
-			continue;
-		}
-		IDXD_PMD_DEBUG("WQ '%s', not allocated to DPDK", dev->wq_name);
-	}
-
-	return 0;
-}
-
 static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
 	const struct rte_dsa_device *dsa_dev = RTE_BUS_DEVICE(dev, *dsa_dev);
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 88c417e8d3..94b7be5f5f 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -72,6 +72,51 @@ rte_bus_scan(void)
 	return 0;
 }
 
+/*
+ * Generic probe function for buses.
+ * Iterates through all devices on the bus, finds matching drivers,
+ * and calls bus->probe_device() for each device.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_generic_probe)
+int
+rte_bus_generic_probe(struct rte_bus *bus)
+{
+	size_t probed = 0, failed = 0;
+	struct rte_device *dev;
+
+	TAILQ_FOREACH(dev, &bus->device_list, next) {
+		struct rte_driver *drv = NULL;
+		int ret;
+
+		if (rte_bus_device_is_ignored(bus, dev->name))
+			continue;
+
+		if (rte_dev_is_probed(dev) && !bus->allow_multi_probe) {
+			EAL_LOG(INFO, "Device %s is already probed", dev->name);
+			continue;
+		}
+
+		probed++;
+next_driver:
+		drv = rte_bus_find_driver(bus, drv, dev);
+		if (drv == NULL)
+			continue;
+
+		ret = bus->probe_device(drv, dev);
+		if (ret > 0)
+			goto next_driver;
+
+		if (ret < 0) {
+			if (ret == -EEXIST)
+				continue;
+			EAL_LOG(ERR, "Failed to probe device %s", dev->name);
+			failed++;
+		}
+	}
+
+	return (probed && probed == failed) ? -1 : 0;
+}
+
 /* Probe all devices of all buses */
 RTE_EXPORT_SYMBOL(rte_bus_probe)
 int
@@ -86,14 +131,14 @@ rte_bus_probe(void)
 			continue;
 		}
 
-		ret = bus->probe();
+		ret = bus->probe(bus);
 		if (ret)
 			EAL_LOG(ERR, "Bus (%s) probe failed.",
 				rte_bus_name(bus));
 	}
 
 	if (vbus) {
-		ret = vbus->probe();
+		ret = vbus->probe(vbus);
 		if (ret)
 			EAL_LOG(ERR, "Bus (%s) probe failed.",
 				rte_bus_name(vbus));
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 5ab988426c..b97967930a 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -40,11 +40,14 @@ typedef int (*rte_bus_scan_t)(void);
  *
  * This is called while iterating over each registered bus.
  *
+ * @param bus
+ *   A pointer to the bus structure.
+ *
  * @return
  *	0 for successful probe
  *	!0 for any error while probing
  */
-typedef int (*rte_bus_probe_t)(void);
+typedef int (*rte_bus_probe_t)(struct rte_bus *bus);
 
 /**
  * Device iterator to find a device on a bus.
@@ -596,6 +599,24 @@ __rte_internal
 struct rte_driver *rte_bus_find_driver(const struct rte_bus *bus, const struct rte_driver *start,
 	const struct rte_device *dev);
 
+/**
+ * Generic probe function for buses.
+ *
+ * Iterates through all devices on the bus, finds matching drivers using
+ * rte_bus_find_driver(), and calls bus->probe_device() for each device that has
+ * a matching driver.
+ *
+ * This function can be used by buses that don't require special probe
+ * logic and just need the standard device iteration and driver matching.
+ *
+ * @param bus
+ *   Pointer to the bus to probe.
+ * @return
+ *   0 on success.
+ */
+__rte_internal
+int rte_bus_generic_probe(struct rte_bus *bus);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

