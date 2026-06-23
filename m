Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68CECDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:55:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30A474065D;
	Tue, 23 Jun 2026 12:55:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C89E140269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 12:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782212138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8PWW50NzEkgudZTaqApuhQVTaxlVtQS6yn1vBJNxTg=;
 b=YDL9u8pU7hIjFEyPi9KAjELzZ5U9T+1tB/Q/q13AmHuqnae7yRXq2NTIcwnkC/3MFVdUhP
 guNIanTRmkCVnnGViAoHKuQO4+SThyFb9d1X5icZw7LG5jUSrEjdf3ZYvwwRzbpftGTZ+J
 craDTxDGwGO5hjSYZJYME61euLor4HA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-QI9l57ULOe2aSWOu73GuwA-1; Tue,
 23 Jun 2026 06:55:34 -0400
X-MC-Unique: QI9l57ULOe2aSWOu73GuwA-1
X-Mimecast-MFC-AGG-ID: QI9l57ULOe2aSWOu73GuwA_1782212132
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D81318009DA; Tue, 23 Jun 2026 10:55:32 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 699B230A8; Tue, 23 Jun 2026 10:55:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v3 08/11] bus: align unplug with device probe
Date: Tue, 23 Jun 2026 12:54:35 +0200
Message-ID: <20260623105439.2144694-9-david.marchand@redhat.com>
In-Reply-To: <20260623105439.2144694-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260623105439.2144694-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1C74ov5YDW-Lao7TRtIZ8EBSeR47LGfEFHfX0wR5OF4_1782212132
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

Refactor bus unplug operations to be the counterpart of probe_device.
The (renamed) unplug operation now only handles:
- Driver removal (calling the driver's remove callback)
- Freeing probe-allocated resources (interrupts, mappings)

Device deletion (devargs removal, bus removal, freeing device
structure) is now handled only during bus cleanup, not in unplug.

Additionally, move driver pointer clearing from individual bus unplug
operations to EAL's local_dev_remove() where the unplug operation is
invoked. This centralizes driver lifecycle management and eliminates
code duplication across bus drivers.

For vdev, add a check in rte_vdev_uninit() since this public API can
be called on devices without a driver attached.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/prog_guide/device_hotplug.rst | 18 ++++---
 drivers/bus/auxiliary/auxiliary_common.c | 46 ++++++----------
 drivers/bus/cdx/cdx.c                    | 29 ++--------
 drivers/bus/fslmc/fslmc_bus.c            |  7 +--
 drivers/bus/ifpga/ifpga_bus.c            | 63 ++++++++++------------
 drivers/bus/pci/pci_common.c             | 57 ++++----------------
 drivers/bus/platform/platform.c          | 16 +++---
 drivers/bus/uacce/uacce.c                | 67 ++++++++----------------
 drivers/bus/vdev/vdev.c                  | 53 ++++++++-----------
 lib/eal/common/eal_common_dev.c          |  8 +--
 lib/eal/include/bus_driver.h             |  4 +-
 11 files changed, 129 insertions(+), 239 deletions(-)

diff --git a/doc/guides/prog_guide/device_hotplug.rst b/doc/guides/prog_guide/device_hotplug.rst
index 7eb7fbcc2b..d21ba0c244 100644
--- a/doc/guides/prog_guide/device_hotplug.rst
+++ b/doc/guides/prog_guide/device_hotplug.rst
@@ -165,7 +165,7 @@ using ``rte_dev_event_callback_register()`` function.
    on the device in question.
    When ``RTE_DEV_EVENT_REMOVE`` event is delivered,
    it indicates that the kernel has removed the device;
-   the application should call ``rte_dev_remove()`` to clean up EAL resources.
+   the application should call ``rte_dev_remove()`` to unplug the device driver.
 
 
 Event Notification Usage
@@ -256,13 +256,17 @@ When ``rte_dev_remove()`` is called, the following sequence occurs:
    See `Multi-process Synchronization`_ for details.
 
 #. **Device Unplug**:
-   The bus's ``unplug()`` method is called (``dev->bus->unplug()``),
-   which triggers the driver's remove function.
-   This typically stops device operations, releases device resources,
-   unmaps memory regions, and unregisters from subsystems.
+   The bus's ``unplug_device()`` method is called (``dev->bus->unplug_device()``),
+   which triggers the driver's remove function
+   and releases resources allocated during probe
+   (such as interrupt handles and device memory mappings).
 
-#. **Devargs Cleanup**:
-   The devargs associated with the device are removed from the global list.
+.. note::
+
+   The device structure, its devargs, and its entry in the bus device list
+   are NOT freed during ``rte_dev_remove()``.
+   They remain in memory until ``rte_eal_cleanup()`` is called,
+   at which point the bus's ``cleanup()`` method handles complete device deletion.
 
 
 Multi-process Synchronization
diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 048aacf254..10f466e57a 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -122,13 +122,11 @@ auxiliary_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	return ret;
 }
 
-/*
- * Call the remove() function of the driver.
- */
 static int
-rte_auxiliary_driver_remove_dev(struct rte_auxiliary_device *dev)
+auxiliary_unplug_device(struct rte_device *rte_dev)
 {
-	const struct rte_auxiliary_driver *drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
+	const struct rte_auxiliary_driver *drv = RTE_BUS_DRIVER(rte_dev->driver, *drv);
+	struct rte_auxiliary_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 	int ret = 0;
 
 	AUXILIARY_LOG(DEBUG, "Driver %s remove auxiliary device %s on NUMA node %i",
@@ -140,8 +138,8 @@ rte_auxiliary_driver_remove_dev(struct rte_auxiliary_device *dev)
 			return ret;
 	}
 
-	/* clear driver structure */
-	dev->device.driver = NULL;
+	rte_intr_instance_free(dev->intr_handle);
+	dev->intr_handle = NULL;
 
 	return 0;
 }
@@ -181,22 +179,6 @@ rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 	rte_bus_remove_driver(&auxiliary_bus, &driver->driver);
 }
 
-static int
-auxiliary_unplug(struct rte_device *dev)
-{
-	struct rte_auxiliary_device *adev = RTE_BUS_DEVICE(dev, *adev);
-	int ret;
-
-	ret = rte_auxiliary_driver_remove_dev(adev);
-	if (ret == 0) {
-		rte_bus_remove_device(&auxiliary_bus, &adev->device);
-		rte_devargs_remove(dev->devargs);
-		rte_intr_instance_free(adev->intr_handle);
-		free(adev);
-	}
-	return ret;
-}
-
 static int
 auxiliary_cleanup(void)
 {
@@ -206,13 +188,17 @@ auxiliary_cleanup(void)
 	RTE_BUS_FOREACH_DEV(dev, &auxiliary_bus) {
 		int ret;
 
-		if (!rte_dev_is_probed(&dev->device))
-			continue;
-		ret = auxiliary_unplug(&dev->device);
-		if (ret < 0) {
-			rte_errno = errno;
-			error = -1;
+		if (rte_dev_is_probed(&dev->device)) {
+			ret = auxiliary_unplug_device(&dev->device);
+			if (ret < 0) {
+				rte_errno = errno;
+				error = -1;
+			}
 		}
+
+		rte_devargs_remove(dev->device.devargs);
+		rte_bus_remove_device(&auxiliary_bus, &dev->device);
+		free(dev);
 	}
 
 	return error;
@@ -265,7 +251,7 @@ struct rte_bus auxiliary_bus = {
 	.find_device = rte_bus_generic_find_device,
 	.match = auxiliary_bus_match,
 	.probe_device = auxiliary_probe_device,
-	.unplug = auxiliary_unplug,
+	.unplug_device = auxiliary_unplug_device,
 	.parse = auxiliary_parse,
 	.dma_map = auxiliary_dma_map,
 	.dma_unmap = auxiliary_dma_unmap,
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 2443161e1a..c0b46a41ad 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -374,14 +374,11 @@ rte_cdx_unregister(struct rte_cdx_driver *driver)
 	rte_bus_remove_driver(&rte_cdx_bus, &driver->driver);
 }
 
-/*
- * If vendor/device ID match, call the remove() function of the
- * driver.
- */
 static int
-cdx_detach_dev(struct rte_cdx_device *dev)
+cdx_unplug_device(struct rte_device *rte_dev)
 {
-	const struct rte_cdx_driver *dr = RTE_BUS_DRIVER(dev->device.driver, *dr);
+	const struct rte_cdx_driver *dr = RTE_BUS_DRIVER(rte_dev->driver, *dr);
+	struct rte_cdx_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 	int ret = 0;
 
 	CDX_BUS_DEBUG("detach device %s using driver: %s",
@@ -393,9 +390,6 @@ cdx_detach_dev(struct rte_cdx_device *dev)
 			return ret;
 	}
 
-	/* clear driver structure */
-	dev->device.driver = NULL;
-
 	rte_cdx_unmap_device(dev);
 
 	rte_intr_instance_free(dev->intr_handle);
@@ -404,21 +398,6 @@ cdx_detach_dev(struct rte_cdx_device *dev)
 	return 0;
 }
 
-static int
-cdx_unplug(struct rte_device *dev)
-{
-	struct rte_cdx_device *cdx_dev = RTE_BUS_DEVICE(dev, *cdx_dev);
-	int ret;
-
-	ret = cdx_detach_dev(cdx_dev);
-	if (ret == 0) {
-		rte_bus_remove_device(&rte_cdx_bus, &cdx_dev->device);
-		rte_devargs_remove(dev->devargs);
-		free(cdx_dev);
-	}
-	return ret;
-}
-
 static int
 cdx_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
@@ -452,7 +431,7 @@ static struct rte_bus rte_cdx_bus = {
 	.find_device = rte_bus_generic_find_device,
 	.match = cdx_bus_match,
 	.probe_device = cdx_probe_device,
-	.unplug = cdx_unplug,
+	.unplug_device = cdx_unplug_device,
 	.parse = cdx_parse,
 	.dma_map = cdx_dma_map,
 	.dma_unmap = cdx_dma_unmap,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index c7549a361a..dca4c5b182 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -520,6 +520,7 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 		return 0;
 	}
 
+	/* FIXME: probe_device should allocate intr_handle */
 	ret = drv->probe(drv, dev);
 	if (ret != 0) {
 		DPAA2_BUS_ERR("Unable to probe");
@@ -531,7 +532,7 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 }
 
 static int
-fslmc_bus_unplug(struct rte_device *rte_dev)
+fslmc_bus_unplug_device(struct rte_device *rte_dev)
 {
 	struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 	const struct rte_dpaa2_driver *drv = RTE_BUS_DRIVER(rte_dev->driver, *drv);
@@ -540,7 +541,7 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 		int ret = drv->remove(dev);
 		if (ret != 0)
 			return ret;
-		dev->device.driver = NULL;
+		/* FIXME: unplug_device should free intr_handle */
 		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
 		return 0;
 	}
@@ -558,7 +559,7 @@ struct rte_bus rte_fslmc_bus = {
 	.get_iommu_class = rte_dpaa2_get_iommu_class,
 	.match = fslmc_bus_match,
 	.probe_device = fslmc_bus_probe_device,
-	.unplug = fslmc_bus_unplug,
+	.unplug_device = fslmc_bus_unplug_device,
 	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index af77d69ef6..7e2e2efce0 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -279,6 +279,25 @@ ifpga_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	return ret;
 }
 
+static int
+ifpga_unplug_device(struct rte_device *dev)
+{
+	const struct rte_afu_driver *afu_drv = RTE_BUS_DRIVER(dev->driver, *afu_drv);
+	struct rte_afu_device *afu_dev = RTE_BUS_DEVICE(dev, *afu_dev);
+	int ret = 0;
+
+	if (afu_drv->remove) {
+		ret = afu_drv->remove(afu_dev);
+		if (ret)
+			return ret;
+	}
+
+	rte_intr_instance_free(afu_dev->intr_handle);
+	afu_dev->intr_handle = NULL;
+
+	return 0;
+}
+
 /*
  * Cleanup the content of the Intel FPGA bus, and call the remove() function
  * for all registered devices.
@@ -290,52 +309,24 @@ ifpga_cleanup(void)
 	int error = 0;
 
 	RTE_BUS_FOREACH_DEV(afu_dev, &rte_ifpga_bus) {
-		const struct rte_afu_driver *drv;
 		int ret = 0;
 
-		if (!rte_dev_is_probed(&afu_dev->device))
-			goto free;
-		drv = RTE_BUS_DRIVER(afu_dev->device.driver, *drv);
-		if (drv->remove == NULL)
-			goto free;
-
-		ret = drv->remove(afu_dev);
-		if (ret < 0) {
-			rte_errno = errno;
-			error = -1;
+		if (rte_dev_is_probed(&afu_dev->device)) {
+			ret = ifpga_unplug_device(&afu_dev->device);
+			if (ret < 0) {
+				rte_errno = errno;
+				error = -1;
+			}
 		}
-		afu_dev->device.driver = NULL;
 
-free:
-		rte_bus_remove_device(&rte_ifpga_bus, &afu_dev->device);
 		rte_devargs_remove(afu_dev->device.devargs);
-		rte_intr_instance_free(afu_dev->intr_handle);
+		rte_bus_remove_device(&rte_ifpga_bus, &afu_dev->device);
 		free(afu_dev);
 	}
 
 	return error;
 }
 
-static int
-ifpga_unplug(struct rte_device *dev)
-{
-	struct rte_afu_device *afu_dev = RTE_BUS_DEVICE(dev, *afu_dev);
-	const struct rte_afu_driver *afu_drv = RTE_BUS_DRIVER(dev->driver, *afu_drv);
-	int ret;
-
-	ret = afu_drv->remove(afu_dev);
-	if (ret)
-		return ret;
-
-	rte_bus_remove_device(&rte_ifpga_bus, &afu_dev->device);
-
-	rte_devargs_remove(dev->devargs);
-	rte_intr_instance_free(afu_dev->intr_handle);
-	free(afu_dev);
-	return 0;
-
-}
-
 static int
 ifpga_parse(const char *name, void *addr)
 {
@@ -387,7 +378,7 @@ static struct rte_bus rte_ifpga_bus = {
 	.find_device = rte_bus_generic_find_device,
 	.match       = ifpga_bus_match,
 	.probe_device = ifpga_probe_device,
-	.unplug      = ifpga_unplug,
+	.unplug_device = ifpga_unplug_device,
 	.parse       = ifpga_parse,
 };
 
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 791e9a7b49..bf4822f7ec 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -282,13 +282,10 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	return ret;
 }
 
-/*
- * If vendor/device ID match, call the remove() function of the
- * driver.
- */
 static int
-rte_pci_detach_dev(struct rte_pci_device *dev)
+pci_unplug_device(struct rte_device *rte_dev)
 {
+	struct rte_pci_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 	struct rte_pci_addr *loc;
 	const struct rte_pci_driver *dr = RTE_BUS_DRIVER(dev->device.driver, *dr);
 	int ret = 0;
@@ -308,9 +305,6 @@ rte_pci_detach_dev(struct rte_pci_device *dev)
 			return ret;
 	}
 
-	/* clear driver structure */
-	dev->device.driver = NULL;
-
 	if (dr->drv_flags & RTE_PCI_DRV_NEED_MAPPING)
 		/* unmap resources for devices that use igb_uio */
 		rte_pci_unmap_device(dev);
@@ -330,33 +324,17 @@ pci_cleanup(void)
 	int error = 0;
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus) {
-		const struct rte_pci_driver *drv;
 		int ret = 0;
 
-		if (!rte_dev_is_probed(&dev->device))
-			goto free;
-		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
-		if (drv->remove == NULL)
-			goto free;
-
-		ret = drv->remove(dev);
-		if (ret < 0) {
-			rte_errno = errno;
-			error = -1;
+		if (rte_dev_is_probed(&dev->device)) {
+			ret = pci_unplug_device(&dev->device);
+			if (ret < 0) {
+				rte_errno = errno;
+				error = -1;
+			}
 		}
 
-		if (drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING)
-			rte_pci_unmap_device(dev);
-
-		dev->device.driver = NULL;
-
-free:
-		/* free interrupt handles */
-		rte_intr_instance_free(dev->intr_handle);
-		dev->intr_handle = NULL;
-		rte_intr_instance_free(dev->vfio_req_intr_handle);
-		dev->vfio_req_intr_handle = NULL;
-
+		rte_devargs_remove(dev->device.devargs);
 		rte_bus_remove_device(&rte_pci_bus, &dev->device);
 		pci_free(RTE_PCI_DEVICE_INTERNAL(dev));
 	}
@@ -521,21 +499,6 @@ pci_sigbus_handler(const void *failure_addr)
 	return ret;
 }
 
-static int
-pci_unplug(struct rte_device *dev)
-{
-	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
-	int ret;
-
-	ret = rte_pci_detach_dev(pdev);
-	if (ret == 0) {
-		rte_bus_remove_device(&rte_pci_bus, &pdev->device);
-		rte_devargs_remove(dev->devargs);
-		pci_free(RTE_PCI_DEVICE_INTERNAL(pdev));
-	}
-	return ret;
-}
-
 static int
 pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
@@ -784,7 +747,7 @@ struct rte_bus rte_pci_bus = {
 	.find_device = rte_bus_generic_find_device,
 	.match = pci_bus_match,
 	.probe_device = pci_probe_device,
-	.unplug = pci_unplug,
+	.unplug_device = pci_unplug_device,
 	.parse = pci_parse,
 	.dev_compare = pci_dev_compare,
 	.devargs_parse = rte_pci_devargs_parse,
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 170a2e03d0..5b3c78a505 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -416,19 +416,15 @@ device_release_driver(struct rte_platform_device *pdev)
 		if (ret)
 			PLATFORM_LOG_LINE(WARNING, "failed to remove %s", pdev->name);
 	}
-
-	pdev->device.driver = NULL;
 }
 
 static int
-platform_bus_unplug(struct rte_device *dev)
+platform_bus_unplug_device(struct rte_device *dev)
 {
 	struct rte_platform_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 
 	device_release_driver(pdev);
 	device_cleanup(pdev);
-	rte_devargs_remove(pdev->device.devargs);
-	free(pdev);
 
 	return 0;
 }
@@ -501,10 +497,12 @@ platform_bus_cleanup(void)
 	struct rte_platform_device *pdev;
 
 	RTE_BUS_FOREACH_DEV(pdev, &platform_bus) {
+		if (rte_dev_is_probed(&pdev->device))
+			platform_bus_unplug_device(&pdev->device);
+
+		rte_devargs_remove(pdev->device.devargs);
 		rte_bus_remove_device(&platform_bus, &pdev->device);
-		if (!rte_dev_is_probed(&pdev->device))
-			continue;
-		platform_bus_unplug(&pdev->device);
+		free(pdev);
 	}
 
 	return 0;
@@ -516,7 +514,7 @@ static struct rte_bus platform_bus = {
 	.find_device = rte_bus_generic_find_device,
 	.match = platform_bus_match,
 	.probe_device = platform_bus_probe_device,
-	.unplug = platform_bus_unplug,
+	.unplug_device = platform_bus_unplug_device,
 	.parse = platform_bus_parse,
 	.dma_map = platform_bus_dma_map,
 	.dma_unmap = platform_bus_dma_unmap,
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 8a3c55b248..bfe1f26557 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -385,40 +385,10 @@ uacce_probe_device(struct rte_driver *drv, struct rte_device *dev)
 }
 
 static int
-uacce_cleanup(void)
+uacce_unplug_device(struct rte_device *rte_dev)
 {
-	struct rte_uacce_device *dev;
-	int error = 0;
-
-	RTE_BUS_FOREACH_DEV(dev, &uacce_bus) {
-		const struct rte_uacce_driver *dr;
-		int ret = 0;
-
-		if (!rte_dev_is_probed(&dev->device))
-			goto free;
-		dr = RTE_BUS_DRIVER(dev->device.driver, *dr);
-		if (dr->remove == NULL)
-			goto free;
-
-		ret = dr->remove(dev);
-		if (ret < 0) {
-			rte_errno = errno;
-			error = -1;
-		}
-		dev->device.driver = NULL;
-
-free:
-		rte_bus_remove_device(&uacce_bus, &dev->device);
-		free(dev);
-	}
-
-	return error;
-}
-
-static int
-uacce_detach_dev(struct rte_uacce_device *dev)
-{
-	const struct rte_uacce_driver *dr = RTE_BUS_DRIVER(dev->device.driver, *dr);
+	const struct rte_uacce_driver *dr = RTE_BUS_DRIVER(rte_dev->driver, *dr);
+	struct rte_uacce_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 	int ret = 0;
 
 	UACCE_BUS_DEBUG("detach device %s using driver: %s", dev->device.name, dr->driver.name);
@@ -429,25 +399,32 @@ uacce_detach_dev(struct rte_uacce_device *dev)
 			return ret;
 	}
 
-	dev->device.driver = NULL;
-
 	return 0;
 }
 
 static int
-uacce_unplug(struct rte_device *dev)
+uacce_cleanup(void)
 {
-	struct rte_uacce_device *uacce_dev = RTE_BUS_DEVICE(dev, *uacce_dev);
-	int ret;
+	struct rte_uacce_device *dev;
+	int error = 0;
 
-	ret = uacce_detach_dev(uacce_dev);
-	if (ret == 0) {
-		rte_bus_remove_device(&uacce_bus, &uacce_dev->device);
-		rte_devargs_remove(dev->devargs);
-		free(uacce_dev);
+	RTE_BUS_FOREACH_DEV(dev, &uacce_bus) {
+		int ret = 0;
+
+		if (rte_dev_is_probed(&dev->device)) {
+			ret = uacce_unplug_device(&dev->device);
+			if (ret < 0) {
+				rte_errno = errno;
+				error = -1;
+			}
+		}
+
+		rte_devargs_remove(dev->device.devargs);
+		rte_bus_remove_device(&uacce_bus, &dev->device);
+		free(dev);
 	}
 
-	return ret;
+	return error;
 }
 
 static int
@@ -577,7 +554,7 @@ static struct rte_bus uacce_bus = {
 	.cleanup = uacce_cleanup,
 	.match = uacce_bus_match,
 	.probe_device = uacce_probe_device,
-	.unplug = uacce_unplug,
+	.unplug_device = uacce_unplug_device,
 	.find_device = rte_bus_generic_find_device,
 	.parse = uacce_parse,
 	.dev_iterate = rte_bus_generic_dev_iterate,
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 09221ccdea..7e94f86e28 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -343,19 +343,15 @@ rte_vdev_init(const char *name, const char *args)
 }
 
 static int
-vdev_remove_driver(struct rte_vdev_device *dev)
+vdev_unplug_device(struct rte_device *rte_dev)
 {
-	const char *name = rte_vdev_device_name(dev);
-	const struct rte_vdev_driver *driver;
+	const struct rte_vdev_driver *driver = RTE_BUS_DRIVER(rte_dev->driver, *driver);
+	struct rte_vdev_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 
-	if (!dev->device.driver) {
-		VDEV_LOG(DEBUG, "no driver attach to device %s", name);
-		return 1;
-	}
+	if (driver->remove)
+		return driver->remove(dev);
 
-	driver = RTE_BUS_DRIVER(dev->device.driver, *driver);
-
-	return driver->remove(dev);
+	return 0;
 }
 
 RTE_EXPORT_SYMBOL(rte_vdev_uninit)
@@ -376,7 +372,12 @@ rte_vdev_uninit(const char *name)
 		goto unlock;
 	}
 
-	ret = vdev_remove_driver(dev);
+	if (rte_dev_is_probed(&dev->device)) {
+		ret = vdev_unplug_device(&dev->device);
+	} else {
+		VDEV_LOG(DEBUG, "no driver attach to device %s", name);
+		ret = 1;
+	}
 	if (ret)
 		goto unlock;
 
@@ -553,27 +554,21 @@ vdev_cleanup(void)
 	struct rte_vdev_device *dev;
 	int error = 0;
 
+	rte_spinlock_recursive_lock(&vdev_device_list_lock);
 	RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
-		const struct rte_vdev_driver *drv;
 		int ret;
 
-		if (!rte_dev_is_probed(&dev->device))
-			goto free;
-
-		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
-
-		if (drv->remove == NULL)
-			goto free;
-
-		ret = drv->remove(dev);
-		if (ret < 0)
-			error = -1;
+		if (rte_dev_is_probed(&dev->device)) {
+			ret = vdev_unplug_device(&dev->device);
+			if (ret < 0)
+				error = -1;
+		}
 
-		dev->device.driver = NULL;
-free:
+		rte_devargs_remove(dev->device.devargs);
 		rte_bus_remove_device(&rte_vdev_bus, &dev->device);
 		free(dev);
 	}
+	rte_spinlock_recursive_unlock(&vdev_device_list_lock);
 
 	return error;
 }
@@ -591,12 +586,6 @@ vdev_find_device(const struct rte_bus *bus, const struct rte_device *start,
 	return dev;
 }
 
-static int
-vdev_unplug(struct rte_device *dev)
-{
-	return rte_vdev_uninit(dev->name);
-}
-
 static enum rte_iova_mode
 vdev_get_iommu_class(void)
 {
@@ -623,7 +612,7 @@ static struct rte_bus rte_vdev_bus = {
 	.find_device = vdev_find_device,
 	.match = vdev_bus_match,
 	.probe_device = vdev_probe_device,
-	.unplug = vdev_unplug,
+	.unplug_device = vdev_unplug_device,
 	.parse = vdev_parse,
 	.dma_map = vdev_dma_map,
 	.dma_unmap = vdev_dma_unmap,
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 2a2103ec57..762ed09e21 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -385,19 +385,21 @@ local_dev_remove(struct rte_device *dev)
 {
 	int ret;
 
-	if (dev->bus->unplug == NULL) {
-		EAL_LOG(ERR, "Function unplug not supported by bus (%s)",
+	if (dev->bus->unplug_device == NULL) {
+		EAL_LOG(ERR, "Function unplug_device not supported by bus (%s)",
 			dev->bus->name);
 		return -ENOTSUP;
 	}
 
-	ret = dev->bus->unplug(dev);
+	ret = dev->bus->unplug_device(dev);
 	if (ret) {
 		EAL_LOG(ERR, "Driver cannot detach the device (%s)",
 			dev->name);
 		return (ret < 0) ? ret : -ENOENT;
 	}
 
+	dev->driver = NULL;
+
 	return 0;
 }
 
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 9711e6712b..fde55ff06d 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -101,7 +101,7 @@ typedef int (*rte_bus_probe_device_t)(struct rte_driver *drv, struct rte_device
  *	0 on success.
  *	!0 on error.
  */
-typedef int (*rte_bus_unplug_t)(struct rte_device *dev);
+typedef int (*rte_bus_unplug_device_t)(struct rte_device *dev);
 
 /**
  * Bus specific parsing function.
@@ -323,7 +323,7 @@ struct rte_bus {
 	rte_bus_find_device_t find_device; /**< Find a device on the bus */
 	rte_bus_match_t match;       /**< Check if driver matches device */
 	rte_bus_probe_device_t probe_device; /**< Probe single device with driver */
-	rte_bus_unplug_t unplug;     /**< Remove single device from driver */
+	rte_bus_unplug_device_t unplug_device; /**< Remove single device from driver */
 	rte_bus_parse_t parse;       /**< Parse a device name */
 	rte_bus_dev_compare_t dev_compare; /**< Compare two device names */
 	rte_bus_devargs_parse_t devargs_parse; /**< Parse bus devargs */
-- 
2.54.0

