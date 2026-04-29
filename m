Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374F6FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C162840678;
	Wed, 29 Apr 2026 13:46:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 993F0406B6
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbuZcogPYXs6MgY8moFhpDz3BtFvWfbcSajaMizRv0U=;
 b=QPrLSPMCXkWUOEVhGV9dLMZ7gmrboKR/LqEwyMj0nKMAYL552pM0xh/Q2Ngm+DB6x8KFMz
 u7hVZwQfUsbjXJKVwtQT4oHtX/T0c0kxy3AhdEskSflXlAdlN8jEKDwl+8qdNG6ViXqwQh
 jSTcERuF/88LXPaKVcxcmp5zcx3BNh8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-bhNV9sc2PIWQBQ99pY0Qyg-1; Wed,
 29 Apr 2026 07:46:42 -0400
X-MC-Unique: bhNV9sc2PIWQBQ99pY0Qyg-1
X-Mimecast-MFC-AGG-ID: bhNV9sc2PIWQBQ99pY0Qyg_1777463200
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E438195608E; Wed, 29 Apr 2026 11:46:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24D1F19560AB; Wed, 29 Apr 2026 11:46:34 +0000 (UTC)
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
Subject: [PATCH 11/23] bus: factorize driver lookup
Date: Wed, 29 Apr 2026 13:44:44 +0200
Message-ID: <20260429114503.932575-12-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3h2S4MvWopMXJzo3T0Sb6UgQmt_qD7IsCDae6RKqmg8_1777463200
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

Introduce a new bus operation 'match' that checks whether a driver can
handle a given device. This separates the matching logic from iteration,
with buses providing match logic and EAL providing generic iteration
through rte_bus_find_driver().

The match operation returns true if a driver matches a device.
Matching logic is bus-specific (e.g., ID table matching for PCI/CDX,
device type matching for DPAA/FSLMC, UUID matching for IFPGA/VMBUS,
name matching for vdev/platform, API/algorithm matching for uacce).

A generic helper rte_bus_find_driver() iterates through all drivers
on a bus and returns the next matching driver, eliminating the need
for each bus to duplicate iteration logic.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 14 ++++-----
 drivers/bus/auxiliary/private.h          |  6 ----
 drivers/bus/cdx/cdx.c                    | 16 +++++-----
 drivers/bus/dpaa/dpaa_bus.c              | 21 ++++++-------
 drivers/bus/fslmc/fslmc_bus.c            | 23 +++++++-------
 drivers/bus/ifpga/ifpga_bus.c            | 14 +++++----
 drivers/bus/pci/pci_common.c             | 20 ++++++-------
 drivers/bus/pci/private.h                | 15 ----------
 drivers/bus/platform/platform.c          |  9 ++++--
 drivers/bus/uacce/uacce.c                | 19 ++++++------
 drivers/bus/vdev/vdev.c                  | 20 +++++++++++++
 drivers/bus/vmbus/vmbus_common.c         | 21 ++++---------
 drivers/dma/idxd/idxd_bus.c              | 35 ++++++++++++++--------
 lib/eal/common/eal_common_bus.c          | 19 ++++++++++++
 lib/eal/include/bus_driver.h             | 38 ++++++++++++++++++++++++
 15 files changed, 173 insertions(+), 117 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 05299db8fe..21b5bcb416 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -59,13 +59,12 @@ auxiliary_on_scan(struct rte_auxiliary_device *aux_dev)
 	aux_dev->device.devargs = rte_bus_find_devargs(&auxiliary_bus.bus, aux_dev->name);
 }
 
-/*
- * Match the auxiliary driver and device using driver function.
- */
-bool
-auxiliary_match(const struct rte_auxiliary_driver *aux_drv,
-		const struct rte_auxiliary_device *aux_dev)
+static bool
+auxiliary_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
+	const struct rte_auxiliary_driver *aux_drv = RTE_BUS_DRIVER(drv, *aux_drv);
+	const struct rte_auxiliary_device *aux_dev = RTE_BUS_DEVICE(dev, *aux_dev);
+
 	if (aux_drv->match == NULL)
 		return false;
 	return aux_drv->match(aux_dev->name);
@@ -82,7 +81,7 @@ rte_auxiliary_probe_one_driver(struct rte_auxiliary_driver *drv,
 	int ret;
 
 	/* Check if driver supports it. */
-	if (!auxiliary_match(drv, dev))
+	if (!auxiliary_bus_match(&drv->driver, &dev->device))
 		/* Match of device and driver failed */
 		return 1;
 
@@ -340,6 +339,7 @@ struct rte_auxiliary_bus auxiliary_bus = {
 		.probe = auxiliary_probe,
 		.cleanup = auxiliary_cleanup,
 		.find_device = rte_bus_generic_find_device,
+		.match = auxiliary_bus_match,
 		.plug = auxiliary_plug,
 		.unplug = auxiliary_unplug,
 		.parse = auxiliary_parse,
diff --git a/drivers/bus/auxiliary/private.h b/drivers/bus/auxiliary/private.h
index 659d798cd6..116154eb56 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -44,10 +44,4 @@ int auxiliary_scan(void);
  */
 void auxiliary_on_scan(struct rte_auxiliary_device *aux_dev);
 
-/*
- * Match the auxiliary driver and device by driver function.
- */
-bool auxiliary_match(const struct rte_auxiliary_driver *aux_drv,
-		     const struct rte_auxiliary_device *aux_dev);
-
 #endif /* BUS_AUXILIARY_PRIVATE_H */
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index d6f83e2e80..c898ce9271 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -279,13 +279,12 @@ cdx_unmap_resource(void *requested_addr, size_t size)
 			requested_addr, size, rte_strerror(rte_errno));
 	}
 }
-/*
- * Match the CDX Driver and Device using device id and vendor id.
- */
+
 static bool
-cdx_match(const struct rte_cdx_driver *cdx_drv,
-		const struct rte_cdx_device *cdx_dev)
+cdx_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
+	const struct rte_cdx_driver *cdx_drv = RTE_BUS_DRIVER(drv, *cdx_drv);
+	const struct rte_cdx_device *cdx_dev = RTE_BUS_DEVICE(dev, *cdx_dev);
 	const struct rte_cdx_id *id_table;
 
 	for (id_table = cdx_drv->id_table; id_table->vendor_id != 0;
@@ -298,10 +297,10 @@ cdx_match(const struct rte_cdx_driver *cdx_drv,
 				id_table->device_id != RTE_CDX_ANY_ID)
 			continue;
 
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
@@ -317,7 +316,7 @@ cdx_probe_one_driver(struct rte_cdx_driver *dr,
 	int ret;
 
 	/* The device is not blocked; Check if driver supports it */
-	if (!cdx_match(dr, dev))
+	if (!cdx_bus_match(&dr->driver, &dev->device))
 		/* Match of device and driver failed */
 		return 1;
 
@@ -524,6 +523,7 @@ struct rte_cdx_bus rte_cdx_bus = {
 		.scan = cdx_scan,
 		.probe = cdx_probe,
 		.find_device = rte_bus_generic_find_device,
+		.match = cdx_bus_match,
 		.plug = cdx_plug,
 		.unplug = cdx_unplug,
 		.parse = cdx_parse,
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index b3a754cbf4..ca80fff6ec 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -626,19 +626,16 @@ rte_dpaa_driver_unregister(struct rte_dpaa_driver *driver)
 	rte_bus_remove_driver(&rte_dpaa_bus.bus, &driver->driver);
 }
 
-static int
-rte_dpaa_device_match(struct rte_dpaa_driver *drv,
-		      struct rte_dpaa_device *dev)
+static bool
+dpaa_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
-	if (!drv || !dev) {
-		DPAA_BUS_DEBUG("Invalid drv or dev received.");
-		return -1;
-	}
+	const struct rte_dpaa_driver *dpaa_drv = RTE_BUS_DRIVER(drv, *dpaa_drv);
+	const struct rte_dpaa_device *dpaa_dev = RTE_BUS_DEVICE(dev, *dpaa_dev);
 
-	if (drv->drv_type == dev->device_type)
-		return 0;
+	if (dpaa_drv->drv_type == dpaa_dev->device_type)
+		return true;
 
-	return -1;
+	return false;
 }
 
 static int
@@ -793,8 +790,7 @@ rte_dpaa_bus_probe(void)
 	/* For each registered driver, and device, call the driver->probe */
 	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
 		RTE_BUS_FOREACH_DRV(drv, &rte_dpaa_bus.bus) {
-			ret = rte_dpaa_device_match(drv, dev);
-			if (ret)
+			if (!dpaa_bus_match(&drv->driver, &dev->device))
 				continue;
 
 			if (rte_dev_is_probed(&dev->device))
@@ -902,6 +898,7 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.dev_compare = dpaa_bus_dev_compare,
 		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = rte_dpaa_get_iommu_class,
+		.match = dpaa_bus_match,
 		.plug = dpaa_bus_plug,
 		.unplug = dpaa_bus_unplug,
 		.dev_iterate = rte_bus_generic_dev_iterate,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 716f0178b5..8cd9b1eb88 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -381,14 +381,16 @@ rte_fslmc_scan(void)
 	return 0;
 }
 
-static int
-rte_fslmc_match(struct rte_dpaa2_driver *dpaa2_drv,
-		struct rte_dpaa2_device *dpaa2_dev)
+static bool
+fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
+	const struct rte_dpaa2_driver *dpaa2_drv = RTE_BUS_DRIVER(drv, *dpaa2_drv);
+	const struct rte_dpaa2_device *dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
+
 	if (dpaa2_drv->drv_type == dpaa2_dev->dev_type)
-		return 0;
+		return true;
 
-	return 1;
+	return false;
 }
 
 static int
@@ -455,8 +457,7 @@ rte_fslmc_probe(void)
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
-			ret = rte_fslmc_match(drv, dev);
-			if (ret)
+			if (!fslmc_bus_match(&drv->driver, &dev->device))
 				continue;
 
 			if (rte_dev_is_probed(&dev->device))
@@ -504,14 +505,12 @@ rte_fslmc_driver_unregister(struct rte_dpaa2_driver *driver)
 static inline int
 fslmc_all_device_support_iova(void)
 {
-	int ret = 0;
 	struct rte_dpaa2_device *dev;
 	struct rte_dpaa2_driver *drv;
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
-			ret = rte_fslmc_match(drv, dev);
-			if (ret)
+			if (!fslmc_bus_match(&drv->driver, &dev->device))
 				continue;
 			/* if the driver is not supporting IOVA */
 			if (!(drv->drv_flags & RTE_DPAA2_DRV_IOVA_AS_VA))
@@ -548,8 +547,7 @@ fslmc_bus_plug(struct rte_device *rte_dev)
 	struct rte_dpaa2_driver *drv;
 
 	RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
-		ret = rte_fslmc_match(drv, dev);
-		if (ret)
+		if (!fslmc_bus_match(&drv->driver, &dev->device))
 			continue;
 
 		if (rte_dev_is_probed(&dev->device))
@@ -602,6 +600,7 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 		.dev_compare = fslmc_dev_compare,
 		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = rte_dpaa2_get_iommu_class,
+		.match = fslmc_bus_match,
 		.plug = fslmc_bus_plug,
 		.unplug = fslmc_bus_unplug,
 		.dev_iterate = rte_bus_generic_dev_iterate,
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 7d3331fe7e..021171e955 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -245,10 +245,11 @@ ifpga_scan(void)
 /*
  * Match the AFU Driver and AFU Device using the ID Table
  */
-static int
-rte_afu_match(const struct rte_afu_driver *afu_drv,
-	      const struct rte_afu_device *afu_dev)
+static bool
+ifpga_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
+	const struct rte_afu_driver *afu_drv = RTE_BUS_DRIVER(drv, *afu_drv);
+	const struct rte_afu_device *afu_dev = RTE_BUS_DEVICE(dev, *afu_dev);
 	const struct rte_afu_uuid *id_table;
 
 	for (id_table = afu_drv->id_table;
@@ -260,10 +261,10 @@ rte_afu_match(const struct rte_afu_driver *afu_drv,
 				 afu_dev->id.uuid.uuid_high)
 			continue;
 
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 static int
@@ -272,7 +273,7 @@ ifpga_probe_one_driver(struct rte_afu_driver *drv,
 {
 	int ret;
 
-	if (!rte_afu_match(drv, afu_dev))
+	if (!ifpga_bus_match(&drv->driver, &afu_dev->device))
 		/* Match of device and driver failed */
 		return 1;
 
@@ -452,6 +453,7 @@ static struct rte_bus rte_ifpga_bus = {
 	.probe       = ifpga_probe,
 	.cleanup     = ifpga_cleanup,
 	.find_device = rte_bus_generic_find_device,
+	.match       = ifpga_bus_match,
 	.plug        = ifpga_plug,
 	.unplug      = ifpga_unplug,
 	.parse       = ifpga_parse,
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 70ce63eac7..d7fda1752a 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -141,13 +141,12 @@ pci_unmap_resource(void *requested_addr, size_t size)
 	} else
 		PCI_LOG(DEBUG, "  PCI memory unmapped at %p", requested_addr);
 }
-/*
- * Match the PCI Driver and Device using the ID Table
- */
-int
-rte_pci_match(const struct rte_pci_driver *pci_drv,
-	      const struct rte_pci_device *pci_dev)
+
+static bool
+pci_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
+	const struct rte_pci_driver *pci_drv = RTE_BUS_DRIVER(drv, *pci_drv);
+	const struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
 	const struct rte_pci_id *id_table;
 
 	for (id_table = pci_drv->id_table; id_table->vendor_id != 0;
@@ -171,10 +170,10 @@ rte_pci_match(const struct rte_pci_driver *pci_drv,
 				id_table->class_id != RTE_CLASS_ANY_ID)
 			continue;
 
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
@@ -195,7 +194,7 @@ rte_pci_probe_one_driver(struct rte_pci_driver *dr,
 	loc = &dev->addr;
 
 	/* The device is not blocked; Check if driver supports it */
-	if (!rte_pci_match(dr, dev))
+	if (!pci_bus_match(&dr->driver, &dev->device))
 		/* Match of device and driver failed */
 		return 1;
 
@@ -680,7 +679,7 @@ rte_pci_get_iommu_class(void)
 		RTE_BUS_FOREACH_DRV(drv, &rte_pci_bus.bus) {
 			enum rte_iova_mode dev_iova_mode;
 
-			if (!rte_pci_match(drv, dev))
+			if (!pci_bus_match(&drv->driver, &dev->device))
 				continue;
 
 			dev_iova_mode = pci_device_iova_mode(drv, dev);
@@ -861,6 +860,7 @@ struct rte_pci_bus rte_pci_bus = {
 		.probe = pci_probe,
 		.cleanup = pci_cleanup,
 		.find_device = rte_bus_generic_find_device,
+		.match = pci_bus_match,
 		.plug = pci_plug,
 		.unplug = pci_unplug,
 		.parse = pci_parse,
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index 21637882f8..c54ea7b9d8 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -217,21 +217,6 @@ pci_uio_remap_resource(struct rte_pci_device *dev);
 int pci_uio_map_resource_by_index(struct rte_pci_device *dev, int res_idx,
 		struct mapped_pci_resource *uio_res, int map_idx);
 
-/*
- * Match the PCI Driver and Device using the ID Table
- *
- * @param pci_drv
- *      PCI driver from which ID table would be extracted
- * @param pci_dev
- *      PCI device to match against the driver
- * @return
- *      1 for successful match
- *      0 for unsuccessful match
- */
-int
-rte_pci_match(const struct rte_pci_driver *pci_drv,
-	      const struct rte_pci_device *pci_dev);
-
 /**
  * OS specific callbacks for rte_pci_get_iommu_class
  *
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 636f051049..3d6b6efe6e 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -371,8 +371,10 @@ driver_probe_device(struct rte_platform_driver *pdrv, struct rte_platform_device
 }
 
 static bool
-driver_match_device(struct rte_platform_driver *pdrv, struct rte_platform_device *pdev)
+platform_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
+	const struct rte_platform_driver *pdrv = RTE_BUS_DRIVER(drv, *pdrv);
+	const struct rte_platform_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 	bool match = false;
 	char *kdrv;
 
@@ -408,7 +410,7 @@ device_attach(struct rte_platform_device *pdev)
 	struct rte_platform_driver *pdrv;
 
 	RTE_BUS_FOREACH_DRV(pdrv, &platform_bus.bus) {
-		if (driver_match_device(pdrv, pdev))
+		if (platform_bus_match(&pdrv->driver, &pdev->device))
 			break;
 	}
 
@@ -488,7 +490,7 @@ platform_bus_parse(const char *name, void *addr)
 	rte_strscpy(pdev.name, name, sizeof(pdev.name));
 
 	RTE_BUS_FOREACH_DRV(pdrv, &platform_bus.bus) {
-		if (driver_match_device(pdrv, &pdev))
+		if (platform_bus_match(&pdrv->driver, &pdev.device))
 			break;
 	}
 
@@ -556,6 +558,7 @@ struct rte_platform_bus platform_bus = {
 		.scan = platform_bus_scan,
 		.probe = platform_bus_probe,
 		.find_device = rte_bus_generic_find_device,
+		.match = platform_bus_match,
 		.plug = platform_bus_plug,
 		.unplug = platform_bus_unplug,
 		.parse = platform_bus_parse,
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 153ebc5eea..bc2858a5c5 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -314,38 +314,36 @@ uacce_match_api(const struct rte_uacce_device *dev, bool forward_compat,
 }
 
 static bool
-uacce_match(const struct rte_uacce_driver *dr, struct rte_uacce_device *dev)
+uacce_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
+	const struct rte_uacce_driver *dr = RTE_BUS_DRIVER(drv, *dr);
+	const struct rte_uacce_device *uacce_dev = RTE_BUS_DEVICE(dev, *uacce_dev);
 	bool forward_compat = !!(dr->drv_flags & RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV);
-	uint32_t api_ver = uacce_calc_api_ver(dev->api, NULL);
 	const struct rte_uacce_id *id_table;
 	const char *map;
 	uint32_t len;
 
 	for (id_table = dr->id_table; id_table->dev_api != NULL; id_table++) {
-		if (!uacce_match_api(dev, forward_compat, id_table))
+		if (!uacce_match_api(uacce_dev, forward_compat, id_table))
 			continue;
 
-		if (id_table->dev_alg == NULL) {
-			dev->api_ver = api_ver;
+		if (id_table->dev_alg == NULL)
 			return true;
-		}
 
 		/* The dev->algs's algrothims is separated by new line, for
 		 * example: dev->algs could be: aaa\nbbbb\ncc, which has three
 		 * algorithms: aaa, bbbb and cc.
 		 * The id_table->dev_alg should be a single algrithm, e.g. bbbb.
 		 */
-		map = strstr(dev->algs, id_table->dev_alg);
+		map = strstr(uacce_dev->algs, id_table->dev_alg);
 		if (map == NULL)
 			continue;
-		if (map != dev->algs && map[-1] != '\n')
+		if (map != uacce_dev->algs && map[-1] != '\n')
 			continue;
 		len = strlen(id_table->dev_alg);
 		if (map[len] != '\0' && map[len] != '\n')
 			continue;
 
-		dev->api_ver = api_ver;
 		return true;
 	}
 
@@ -359,7 +357,7 @@ uacce_probe_one_driver(struct rte_uacce_driver *dr, struct rte_uacce_device *dev
 	bool already_probed;
 	int ret;
 
-	if (!uacce_match(dr, dev))
+	if (!uacce_bus_match(&dr->driver, &dev->device))
 		/* Match of device and driver failed */
 		return 1;
 
@@ -626,6 +624,7 @@ static struct rte_uacce_bus uacce_bus = {
 		.scan = uacce_scan,
 		.probe = uacce_probe,
 		.cleanup = uacce_cleanup,
+		.match = uacce_bus_match,
 		.plug = uacce_plug,
 		.unplug = uacce_unplug,
 		.find_device = rte_bus_generic_find_device,
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 3e610bd780..a4f6168581 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -162,6 +162,25 @@ vdev_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 	return 0;
 }
 
+/*
+ * Check if a vdev driver matches a vdev device by name.
+ */
+static bool
+vdev_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
+{
+	const char *name = dev->name;
+
+	/* Check driver name match */
+	if (strncmp(drv->name, name, strlen(drv->name)) == 0)
+		return true;
+
+	/* Check driver alias match */
+	if (drv->alias && strncmp(drv->alias, name, strlen(drv->alias)) == 0)
+		return true;
+
+	return false;
+}
+
 static int
 vdev_probe_all_drivers(struct rte_vdev_device *dev)
 {
@@ -640,6 +659,7 @@ static struct rte_bus rte_vdev_bus = {
 	.probe = vdev_probe,
 	.cleanup = vdev_cleanup,
 	.find_device = vdev_find_device,
+	.match = vdev_bus_match,
 	.plug = vdev_plug,
 	.unplug = vdev_unplug,
 	.parse = vdev_parse,
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 3260bd5395..d811f1a229 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -65,25 +65,15 @@ vmbus_unmap_resource(void *requested_addr, size_t size)
 	}
 }
 
-/**
- * Match the VMBUS driver and device using UUID table
- *
- * @param drv
- *	VMBUS driver from which ID table would be extracted
- * @param pci_dev
- *	VMBUS device to match against the driver
- * @return
- *	true for successful match
- *	false for unsuccessful match
- */
 static bool
-vmbus_match(const struct rte_vmbus_driver *dr,
-	    const struct rte_vmbus_device *dev)
+vmbus_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
+	const struct rte_vmbus_driver *dr = RTE_BUS_DRIVER(drv, *dr);
+	const struct rte_vmbus_device *vmbus_dev = RTE_BUS_DEVICE(dev, *vmbus_dev);
 	const rte_uuid_t *id_table;
 
 	for (id_table = dr->id_table; !rte_uuid_is_null(*id_table); ++id_table) {
-		if (rte_uuid_compare(*id_table, dev->class_id) == 0)
+		if (rte_uuid_compare(*id_table, vmbus_dev->class_id) == 0)
 			return true;
 	}
 
@@ -99,7 +89,7 @@ vmbus_probe_one_driver(struct rte_vmbus_driver *dr,
 	char guid[RTE_UUID_STRLEN];
 	int ret;
 
-	if (!vmbus_match(dr, dev))
+	if (!vmbus_bus_match(&dr->driver, &dev->device))
 		return 1;	 /* not supported */
 
 	rte_uuid_unparse(dev->device_id, guid, sizeof(guid));
@@ -281,6 +271,7 @@ struct rte_vmbus_bus rte_vmbus_bus = {
 		.probe = rte_vmbus_probe,
 		.cleanup = rte_vmbus_cleanup,
 		.find_device = rte_bus_generic_find_device,
+		.match = vmbus_bus_match,
 		.parse = vmbus_parse,
 		.dev_compare = vmbus_dev_compare,
 	},
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 1c203e1288..c7591823ad 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -43,6 +43,7 @@ struct rte_dsa_device {
 /* forward prototypes */
 struct dsa_bus;
 static int dsa_scan(void);
+static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev);
 static int dsa_probe(void);
 static enum rte_iova_mode dsa_get_iommu_class(void);
 static int dsa_addr_parse(const char *name, void *addr);
@@ -58,6 +59,7 @@ struct dsa_bus {
 struct dsa_bus dsa_bus = {
 	.bus = {
 		.scan = dsa_scan,
+		.match = dsa_match,
 		.probe = dsa_probe,
 		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = dsa_get_iommu_class,
@@ -126,7 +128,7 @@ idxd_bus_mmap_wq(struct rte_dsa_device *dev)
 }
 
 static int
-read_wq_string(struct rte_dsa_device *dev, const char *filename,
+read_wq_string(const struct rte_dsa_device *dev, const char *filename,
 		char *value, size_t valuelen)
 {
 	char sysfs_node[PATH_MAX];
@@ -241,7 +243,7 @@ idxd_probe_dsa(struct rte_dsa_device *dev)
 }
 
 static int
-is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
+is_for_this_process_use(const char *name)
 {
 	char prefix[256];
 	int retval = 0;
@@ -256,9 +258,6 @@ is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
 	if (strncmp(name, prefix, prefixlen) == 0 && name[prefixlen] == '_')
 		retval = 1;
 
-	if (retval)
-		retval = !rte_bus_device_is_ignored(&dsa_bus.bus, dev->device.name);
-
 	return retval;
 }
 
@@ -268,14 +267,8 @@ dsa_probe(void)
 	struct rte_dsa_device *dev;
 
 	RTE_BUS_FOREACH_DEV(dev, &dsa_bus.bus) {
-		char type[64], name[64];
-
-		if (read_wq_string(dev, "type", type, sizeof(type)) < 0 ||
-				read_wq_string(dev, "name", name, sizeof(name)) < 0)
-			continue;
-
-		if (strncmp(type, "user", 4) == 0 &&
-				is_for_this_process_use(dev, name)) {
+		if (dsa_match(&dsa_bus.driver, &dev->device) &&
+				!rte_bus_device_is_ignored(&dsa_bus.bus, dev->device.name)) {
 			dev->device.driver = &dsa_bus.driver;
 			idxd_probe_dsa(dev);
 			continue;
@@ -286,6 +279,22 @@ dsa_probe(void)
 	return 0;
 }
 
+static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev)
+{
+	const struct rte_dsa_device *dsa_dev = RTE_BUS_DEVICE(dev, *dsa_dev);
+
+	if (drv == &dsa_bus.driver) {
+		char type[64], name[64];
+
+		if (read_wq_string(dsa_dev, "type", type, sizeof(type)) >= 0 &&
+				read_wq_string(dsa_dev, "name", name, sizeof(name)) >= 0) {
+			return strncmp(type, "user", 4) == 0 && is_for_this_process_use(name);
+		}
+	}
+
+	return false;
+}
+
 static int
 dsa_scan(void)
 {
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 46a8e68532..4884cdfa50 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -473,3 +473,22 @@ rte_bus_generic_dev_iterate(const struct rte_bus *bus,
 	rte_kvargs_free(kvargs);
 	return dev;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_find_driver)
+struct rte_driver *
+rte_bus_find_driver(const struct rte_bus *bus, const struct rte_driver *start,
+	const struct rte_device *dev)
+{
+	struct rte_driver *drv;
+
+	if (start != NULL)
+		drv = TAILQ_NEXT(start, next);
+	else
+		drv = TAILQ_FIRST(&bus->driver_list);
+	while (drv != NULL) {
+		if (bus->match(drv, dev))
+			break;
+		drv = TAILQ_NEXT(drv, next);
+	}
+	return drv;
+}
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index e3e52928f4..8acd5d52bd 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -233,6 +233,24 @@ typedef int (*rte_bus_sigbus_handler_t)(const void *failure_addr);
  */
 typedef int (*rte_bus_cleanup_t)(void);
 
+/**
+ * Check if a driver matches a device.
+ *
+ * This function checks whether a driver can handle a given device.
+ * Matching logic is bus-specific (e.g., PCI uses ID tables, vdev uses
+ * name matching, fslmc uses device type).
+ *
+ * @param drv
+ *	Driver to check.
+ * @param dev
+ *	Device to check against.
+ *
+ * @return
+ *	true if the driver matches the device, false otherwise.
+ */
+typedef bool (*rte_bus_match_t)(const struct rte_driver *drv,
+				 const struct rte_device *dev);
+
 /**
  * Bus scan policies
  */
@@ -297,6 +315,7 @@ struct rte_bus {
 	rte_bus_scan_t scan;         /**< Scan for devices attached to bus */
 	rte_bus_probe_t probe;       /**< Probe devices on bus */
 	rte_bus_find_device_t find_device; /**< Find a device on the bus */
+	rte_bus_match_t match;       /**< Check if driver matches device */
 	rte_bus_plug_t plug;         /**< Probe single device for drivers */
 	rte_bus_unplug_t unplug;     /**< Remove single device from driver */
 	rte_bus_parse_t parse;       /**< Parse a device name */
@@ -542,6 +561,25 @@ void rte_bus_add_driver(struct rte_bus *bus, struct rte_driver *driver);
 __rte_internal
 void rte_bus_remove_driver(struct rte_bus *bus, struct rte_driver *driver);
 
+/**
+ * Find the first driver that matches a device on a bus.
+ *
+ * Iterates through all registered drivers on the bus and returns the next
+ * one that matches the given device according to the bus's match operation.
+ *
+ * @param bus
+ *   A pointer to a rte_bus structure.
+ * @param start
+ *   Starting iteration context.
+ * @param dev
+ *   A pointer to a rte_device structure.
+ * @return
+ *   Pointer to the matching driver, or NULL if no match found.
+ */
+__rte_internal
+struct rte_driver *rte_bus_find_driver(const struct rte_bus *bus, const struct rte_driver *start,
+	const struct rte_device *dev);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

