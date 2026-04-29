Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB3FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:47:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADF284065E;
	Wed, 29 Apr 2026 13:46:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B4CBC4065E
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPcA6fVj8AkRG8vRftG1RXcV3eOxfPRk3hMDpQPvuhg=;
 b=VrjF+uiLWNyybGh6bx+gSa3Y1YURInIqY9qGU7gSxwgnwyDkMfDPze30aAwpJ65aEScjWN
 AP6/wBqktW2OxOrgTPp9+4snGQplu8Ndd2rB1sH7d6aSCiWd+M3k8jaqt5OiF1Jodefve4
 IsJFQAa8xpeN4gjshI5XmIQt7fJ3vCQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-3iVQ7jWGN6-7iGAwwVkBgg-1; Wed,
 29 Apr 2026 07:46:50 -0400
X-MC-Unique: 3iVQ7jWGN6-7iGAwwVkBgg-1
X-Mimecast-MFC-AGG-ID: 3iVQ7jWGN6-7iGAwwVkBgg_1777463208
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9736819560AF; Wed, 29 Apr 2026 11:46:48 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56AE1195608E; Wed, 29 Apr 2026 11:46:43 +0000 (UTC)
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
Subject: [PATCH 12/23] bus: refactor device probe
Date: Wed, 29 Apr 2026 13:44:45 +0200
Message-ID: <20260429114503.932575-13-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nhZS-yNeoyxlnrw6-cjQg9uDJfhlhbJ96cZnKRw7dcE_1777463208
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

Introduce a new rte_bus_probe_device_t operation with signature
(struct rte_driver *drv, struct rte_device *dev).

Replace the existing .plug field in the struct rte_bus with .probe_device.

Update all in-tree buses to use .probe_device instead of .plug.
Each bus probe() function now calls rte_bus_find_driver() (which uses the
match operation added in previous commit) and passes the found driver
to bus.probe_device(driver, device).

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c |  98 ++++++---------
 drivers/bus/cdx/cdx.c                    |  81 +++++--------
 drivers/bus/dpaa/dpaa_bus.c              |  63 +++++-----
 drivers/bus/fslmc/fslmc_bus.c            |  73 +++++-------
 drivers/bus/ifpga/ifpga_bus.c            |  68 ++++-------
 drivers/bus/pci/pci_common.c             | 145 +++++++++--------------
 drivers/bus/platform/platform.c          |  38 +++---
 drivers/bus/uacce/uacce.c                |  67 ++++-------
 drivers/bus/vdev/vdev.c                  |  58 +++++----
 drivers/bus/vmbus/vmbus_common.c         |  84 ++++++-------
 drivers/dma/idxd/idxd_bus.c              |  23 ++--
 lib/eal/common/eal_common_bus.c          |   5 +-
 lib/eal/common/eal_common_dev.c          |  14 ++-
 lib/eal/include/bus_driver.h             |  17 ++-
 14 files changed, 354 insertions(+), 480 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 21b5bcb416..7824c26f92 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -74,61 +74,60 @@ auxiliary_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
  * Call the probe() function of the driver.
  */
 static int
-rte_auxiliary_probe_one_driver(struct rte_auxiliary_driver *drv,
-			       struct rte_auxiliary_device *dev)
+auxiliary_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
+	struct rte_auxiliary_device *aux_dev = RTE_BUS_DEVICE(dev, *aux_dev);
+	struct rte_auxiliary_driver *aux_drv = RTE_BUS_DRIVER(drv, *aux_drv);
 	enum rte_iova_mode iova_mode;
 	int ret;
 
-	/* Check if driver supports it. */
-	if (!auxiliary_bus_match(&drv->driver, &dev->device))
-		/* Match of device and driver failed */
-		return 1;
+	if (!auxiliary_dev_exists(dev->name))
+		return -ENOENT;
 
 	/* No initialization when marked as blocked, return without error. */
-	if (dev->device.devargs != NULL &&
-	    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+	if (aux_dev->device.devargs != NULL &&
+	    aux_dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 		AUXILIARY_LOG(INFO, "Device is blocked, not initializing");
 		return -1;
 	}
 
-	if (dev->device.numa_node < 0 && rte_socket_count() > 1)
-		AUXILIARY_LOG(INFO, "Device %s is not NUMA-aware", dev->name);
+	if (aux_dev->device.numa_node < 0 && rte_socket_count() > 1)
+		AUXILIARY_LOG(INFO, "Device %s is not NUMA-aware", aux_dev->name);
 
-	if (rte_dev_is_probed(&dev->device)) {
+	if (rte_dev_is_probed(&aux_dev->device)) {
 		AUXILIARY_LOG(DEBUG, "Device %s is already probed on auxiliary bus",
-			dev->device.name);
+			aux_dev->device.name);
 		return -EEXIST;
 	}
 
 	iova_mode = rte_eal_iova_mode();
-	if ((drv->drv_flags & RTE_AUXILIARY_DRV_NEED_IOVA_AS_VA) > 0 &&
+	if ((aux_drv->drv_flags & RTE_AUXILIARY_DRV_NEED_IOVA_AS_VA) > 0 &&
 	    iova_mode != RTE_IOVA_VA) {
 		AUXILIARY_LOG(ERR, "Driver %s expecting VA IOVA mode but current mode is PA, not initializing",
-			      drv->driver.name);
+			      aux_drv->driver.name);
 		return -EINVAL;
 	}
 
 	/* Allocate interrupt instance */
-	dev->intr_handle =
+	aux_dev->intr_handle =
 		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-	if (dev->intr_handle == NULL) {
+	if (aux_dev->intr_handle == NULL) {
 		AUXILIARY_LOG(ERR, "Could not allocate interrupt instance for device %s",
-			dev->name);
+			aux_dev->name);
 		return -ENOMEM;
 	}
 
-	dev->driver = drv;
+	aux_dev->driver = aux_drv;
 
 	AUXILIARY_LOG(INFO, "Probe auxiliary driver: %s device: %s (NUMA node %i)",
-		      drv->driver.name, dev->name, dev->device.numa_node);
-	ret = drv->probe(drv, dev);
+		      aux_drv->driver.name, aux_dev->name, aux_dev->device.numa_node);
+	ret = aux_drv->probe(aux_drv, aux_dev);
 	if (ret != 0) {
-		dev->driver = NULL;
-		rte_intr_instance_free(dev->intr_handle);
-		dev->intr_handle = NULL;
+		aux_dev->driver = NULL;
+		rte_intr_instance_free(aux_dev->intr_handle);
+		aux_dev->intr_handle = NULL;
 	} else {
-		dev->device.driver = &drv->driver;
+		aux_dev->device.driver = &aux_drv->driver;
 	}
 
 	return ret;
@@ -159,33 +158,6 @@ rte_auxiliary_driver_remove_dev(struct rte_auxiliary_device *dev)
 	return 0;
 }
 
-/*
- * Call the probe() function of all registered drivers for the given device.
- * Return < 0 if initialization failed.
- * Return 1 if no driver is found for this device.
- */
-static int
-auxiliary_probe_all_drivers(struct rte_auxiliary_device *dev)
-{
-	struct rte_auxiliary_driver *drv;
-	int rc;
-
-	RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus.bus) {
-		if (!drv->match(dev->name))
-			continue;
-
-		rc = rte_auxiliary_probe_one_driver(drv, dev);
-		if (rc < 0)
-			/* negative value is an error */
-			return rc;
-		if (rc > 0)
-			/* positive value means driver doesn't support it */
-			continue;
-		return 0;
-	}
-	return 1;
-}
-
 /*
  * Scan the content of the auxiliary bus, and call the probe function for
  * all registered drivers to try to probe discovered devices.
@@ -195,12 +167,19 @@ auxiliary_probe(void)
 {
 	struct rte_auxiliary_device *dev = NULL;
 	size_t probed = 0, failed = 0;
-	int ret = 0;
 
 	RTE_BUS_FOREACH_DEV(dev, &auxiliary_bus.bus) {
+		struct rte_driver *drv = NULL;
+		int ret;
+
 		probed++;
 
-		ret = auxiliary_probe_all_drivers(dev);
+next_driver:
+		drv = rte_bus_find_driver(&auxiliary_bus.bus, drv, &dev->device);
+		if (drv == NULL)
+			continue;
+
+		ret = auxiliary_bus.bus.probe_device(drv, &dev->device);
 		if (ret < 0) {
 			if (ret != -EEXIST) {
 				AUXILIARY_LOG(ERR, "Requested device %s cannot be used",
@@ -208,7 +187,8 @@ auxiliary_probe(void)
 				rte_errno = errno;
 				failed++;
 			}
-			ret = 0;
+		} else if (ret > 0) {
+			goto next_driver;
 		}
 	}
 
@@ -250,14 +230,6 @@ rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 	rte_bus_remove_driver(&auxiliary_bus.bus, &driver->driver);
 }
 
-static int
-auxiliary_plug(struct rte_device *dev)
-{
-	if (!auxiliary_dev_exists(dev->name))
-		return -ENOENT;
-	return auxiliary_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_auxiliary_device));
-}
-
 static int
 auxiliary_unplug(struct rte_device *dev)
 {
@@ -340,7 +312,7 @@ struct rte_auxiliary_bus auxiliary_bus = {
 		.cleanup = auxiliary_cleanup,
 		.find_device = rte_bus_generic_find_device,
 		.match = auxiliary_bus_match,
-		.plug = auxiliary_plug,
+		.probe_device = auxiliary_probe_device,
 		.unplug = auxiliary_unplug,
 		.parse = auxiliary_parse,
 		.dma_map = auxiliary_dma_map,
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index c898ce9271..c38eae325b 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -308,29 +308,23 @@ cdx_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
  * driver.
  */
 static int
-cdx_probe_one_driver(struct rte_cdx_driver *dr,
-		struct rte_cdx_device *dev)
+cdx_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
-	const char *dev_name = dev->name;
-	bool already_probed;
+	struct rte_cdx_device *cdx_dev = RTE_BUS_DEVICE(dev, *cdx_dev);
+	struct rte_cdx_driver *cdx_drv = RTE_BUS_DRIVER(drv, *cdx_drv);
+	const char *dev_name = cdx_dev->name;
 	int ret;
 
-	/* The device is not blocked; Check if driver supports it */
-	if (!cdx_bus_match(&dr->driver, &dev->device))
-		/* Match of device and driver failed */
-		return 1;
-
-	already_probed = rte_dev_is_probed(&dev->device);
-	if (already_probed) {
+	if (rte_dev_is_probed(&cdx_dev->device)) {
 		CDX_BUS_INFO("Device %s is already probed", dev_name);
 		return -EEXIST;
 	}
 
 	CDX_BUS_DEBUG("  probe device %s using driver: %s", dev_name,
-		dr->driver.name);
+		cdx_drv->driver.name);
 
-	if (dr->drv_flags & RTE_CDX_DRV_NEED_MAPPING) {
-		ret = cdx_vfio_map_resource(dev);
+	if (cdx_drv->drv_flags & RTE_CDX_DRV_NEED_MAPPING) {
+		ret = cdx_vfio_map_resource(cdx_dev);
 		if (ret != 0) {
 			CDX_BUS_ERR("CDX map device failed: %d", ret);
 			goto error_map_device;
@@ -338,50 +332,26 @@ cdx_probe_one_driver(struct rte_cdx_driver *dr,
 	}
 
 	/* call the driver probe() function */
-	ret = dr->probe(dr, dev);
+	ret = cdx_drv->probe(cdx_drv, cdx_dev);
 	if (ret) {
 		CDX_BUS_ERR("Probe CDX driver: %s device: %s failed: %d",
-			dr->driver.name, dev_name, ret);
+			cdx_drv->driver.name, dev_name, ret);
 		goto error_probe;
 	} else {
-		dev->device.driver = &dr->driver;
+		cdx_dev->device.driver = &cdx_drv->driver;
 	}
-	dev->driver = dr;
+	cdx_dev->driver = cdx_drv;
 
 	return ret;
 
 error_probe:
-	cdx_vfio_unmap_resource(dev);
-	rte_intr_instance_free(dev->intr_handle);
-	dev->intr_handle = NULL;
+	cdx_vfio_unmap_resource(cdx_dev);
+	rte_intr_instance_free(cdx_dev->intr_handle);
+	cdx_dev->intr_handle = NULL;
 error_map_device:
 	return ret;
 }
 
-/*
- * If vendor/device ID match, call the probe() function of all
- * registered driver for the given device. Return < 0 if initialization
- * failed, return 1 if no driver is found for this device.
- */
-static int
-cdx_probe_all_drivers(struct rte_cdx_device *dev)
-{
-	struct rte_cdx_driver *dr = NULL;
-	int rc = 0;
-
-	RTE_BUS_FOREACH_DRV(dr, &rte_cdx_bus.bus) {
-		rc = cdx_probe_one_driver(dr, dev);
-		if (rc < 0)
-			/* negative value is an error */
-			return rc;
-		if (rc > 0)
-			/* positive value means driver doesn't support it */
-			continue;
-		return 0;
-	}
-	return 1;
-}
-
 /*
  * Scan the content of the CDX bus, and call the probe() function for
  * all registered drivers that have a matching entry in its id_table
@@ -392,17 +362,26 @@ cdx_probe(void)
 {
 	struct rte_cdx_device *dev = NULL;
 	size_t probed = 0, failed = 0;
-	int ret = 0;
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_cdx_bus.bus) {
+		struct rte_driver *drv = NULL;
+		int ret;
+
 		probed++;
 
-		ret = cdx_probe_all_drivers(dev);
+next_driver:
+		drv = rte_bus_find_driver(&rte_cdx_bus.bus, drv, &dev->device);
+		if (drv == NULL)
+			continue;
+
+		ret = rte_cdx_bus.bus.probe_device(drv, &dev->device);
 		if (ret < 0) {
 			CDX_BUS_ERR("Requested device %s cannot be used",
 				dev->name);
 			rte_errno = errno;
 			failed++;
+		} else if (ret > 0) {
+			goto next_driver;
 		}
 	}
 
@@ -470,12 +449,6 @@ cdx_detach_dev(struct rte_cdx_device *dev)
 	return 0;
 }
 
-static int
-cdx_plug(struct rte_device *dev)
-{
-	return cdx_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_cdx_device));
-}
-
 static int
 cdx_unplug(struct rte_device *dev)
 {
@@ -524,7 +497,7 @@ struct rte_cdx_bus rte_cdx_bus = {
 		.probe = cdx_probe,
 		.find_device = rte_bus_generic_find_device,
 		.match = cdx_bus_match,
-		.plug = cdx_plug,
+		.probe_device = cdx_probe_device,
 		.unplug = cdx_unplug,
 		.parse = cdx_parse,
 		.dma_map = cdx_dma_map,
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index ca80fff6ec..14cd64cc32 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -706,7 +706,6 @@ rte_dpaa_bus_probe(void)
 {
 	int ret = -1;
 	struct rte_dpaa_device *dev;
-	struct rte_dpaa_driver *drv;
 	FILE *svr_file = NULL;
 	uint32_t svr_ver;
 	static int process_once;
@@ -789,25 +788,18 @@ rte_dpaa_bus_probe(void)
 
 	/* For each registered driver, and device, call the driver->probe */
 	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
-		RTE_BUS_FOREACH_DRV(drv, &rte_dpaa_bus.bus) {
-			if (!dpaa_bus_match(&drv->driver, &dev->device))
-				continue;
-
-			if (rte_dev_is_probed(&dev->device))
-				continue;
-
-			if (rte_bus_device_is_ignored(&rte_dpaa_bus.bus, dev->name))
-				continue;
-
-			ret = drv->probe(drv, dev);
-			if (ret) {
-				DPAA_BUS_ERR("unable to probe: %s", dev->name);
-			} else {
-				dev->driver = drv;
-				dev->device.driver = &drv->driver;
-			}
-			break;
-		}
+		struct rte_driver *driver = NULL;
+
+next_driver:
+		driver = rte_bus_find_driver(&rte_dpaa_bus.bus, driver, &dev->device);
+		if (driver == NULL)
+			continue;
+
+		ret = rte_dpaa_bus.bus.probe_device(driver, &dev->device);
+		if (ret < 0)
+			DPAA_BUS_ERR("Failed to probe device %s", dev->name);
+		else if (ret > 0)
+			goto next_driver;
 	}
 	dpaa_bus_global_init = 1;
 
@@ -828,17 +820,27 @@ rte_dpaa_get_iommu_class(void)
 }
 
 static int
-dpaa_bus_plug(struct rte_device *dev __rte_unused)
+dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
-	/* No operation is performed while plugging the device */
-	return 0;
-}
+	struct rte_dpaa_device *dpaa_dev = RTE_BUS_DEVICE(dev, *dpaa_dev);
+	struct rte_dpaa_driver *dpaa_drv = RTE_BUS_DRIVER(drv, *dpaa_drv);
+	int ret;
 
-static int
-dpaa_bus_unplug(struct rte_device *dev __rte_unused)
-{
-	/* No operation is performed while unplugging the device */
-	return 0;
+	if (rte_dev_is_probed(&dpaa_dev->device))
+		return 0;
+
+	if (rte_bus_device_is_ignored(&rte_dpaa_bus.bus, dpaa_dev->name))
+		return 0;
+
+	ret = dpaa_drv->probe(dpaa_drv, dpaa_dev);
+	if (ret != 0) {
+		DPAA_BUS_ERR("unable to probe: %s", dpaa_dev->name);
+	} else {
+		dpaa_dev->driver = dpaa_drv;
+		dpaa_dev->device.driver = &dpaa_drv->driver;
+	}
+
+	return ret;
 }
 
 static int
@@ -899,8 +901,7 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = rte_dpaa_get_iommu_class,
 		.match = dpaa_bus_match,
-		.plug = dpaa_bus_plug,
-		.unplug = dpaa_bus_unplug,
+		.probe_device = dpaa_bus_probe_device,
 		.dev_iterate = rte_bus_generic_dev_iterate,
 		.cleanup = dpaa_bus_cleanup,
 	},
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 8cd9b1eb88..a975e464c1 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -411,7 +411,6 @@ rte_fslmc_probe(void)
 	int ret = 0;
 
 	struct rte_dpaa2_device *dev;
-	struct rte_dpaa2_driver *drv;
 
 	static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
 		.name = DPAA2_SEQN_DYNFIELD_NAME,
@@ -456,25 +455,21 @@ rte_fslmc_probe(void)
 	}
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
-		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
-			if (!fslmc_bus_match(&drv->driver, &dev->device))
-				continue;
+		struct rte_driver *driver = NULL;
 
-			if (rte_dev_is_probed(&dev->device))
-				continue;
+		if (rte_bus_device_is_ignored(&rte_fslmc_bus.bus, dev->device.name))
+			continue;
 
-			if (rte_bus_device_is_ignored(&rte_fslmc_bus.bus, dev->device.name))
-				continue;
+next_driver:
+		driver = rte_bus_find_driver(&rte_fslmc_bus.bus, driver, &dev->device);
+		if (driver == NULL)
+			continue;
 
-			ret = drv->probe(drv, dev);
-			if (ret) {
-				DPAA2_BUS_ERR("Unable to probe");
-			} else {
-				dev->driver = drv;
-				dev->device.driver = &drv->driver;
-			}
-			break;
-		}
+		ret = rte_fslmc_bus.bus.probe_device(driver, &dev->device);
+		if (ret < 0)
+			DPAA2_BUS_ERR("Failed to probe device %s", dev->device.name);
+		else if (ret > 0)
+			goto next_driver;
 	}
 
 	return 0;
@@ -540,35 +535,29 @@ rte_dpaa2_get_iommu_class(void)
 }
 
 static int
-fslmc_bus_plug(struct rte_device *rte_dev)
+fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 {
-	int ret = 0;
 	struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
-	struct rte_dpaa2_driver *drv;
-
-	RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
-		if (!fslmc_bus_match(&drv->driver, &dev->device))
-			continue;
+	struct rte_dpaa2_driver *drv = RTE_BUS_DRIVER(driver, *drv);
+	int ret = 0;
 
-		if (rte_dev_is_probed(&dev->device))
-			continue;
+	if (rte_dev_is_probed(&dev->device))
+		return 0;
 
-		if (dev->device.devargs &&
-		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-			DPAA2_BUS_DEBUG("%s Blocked, skipping",
-				      dev->device.name);
-			continue;
-		}
+	if (dev->device.devargs &&
+	    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+		DPAA2_BUS_DEBUG("%s Blocked, skipping",
+			      dev->device.name);
+		return 0;
+	}
 
-		ret = drv->probe(drv, dev);
-		if (ret) {
-			DPAA2_BUS_ERR("Unable to probe");
-		} else {
-			dev->driver = drv;
-			dev->device.driver = &drv->driver;
-			DPAA2_BUS_INFO("%s Plugged",  dev->device.name);
-		}
-		break;
+	ret = drv->probe(drv, dev);
+	if (ret != 0) {
+		DPAA2_BUS_ERR("Unable to probe");
+	} else {
+		dev->driver = drv;
+		dev->device.driver = &drv->driver;
+		DPAA2_BUS_INFO("%s Plugged",  dev->device.name);
 	}
 
 	return ret;
@@ -601,7 +590,7 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = rte_dpaa2_get_iommu_class,
 		.match = fslmc_bus_match,
-		.plug = fslmc_bus_plug,
+		.probe_device = fslmc_bus_probe_device,
 		.unplug = fslmc_bus_unplug,
 		.dev_iterate = rte_bus_generic_dev_iterate,
 	},
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 021171e955..92ad3513e0 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -268,57 +268,32 @@ ifpga_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 }
 
 static int
-ifpga_probe_one_driver(struct rte_afu_driver *drv,
-			struct rte_afu_device *afu_dev)
+ifpga_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
+	struct rte_afu_device *afu_dev = RTE_BUS_DEVICE(dev, *afu_dev);
+	struct rte_afu_driver *afu_drv = RTE_BUS_DRIVER(drv, *afu_drv);
 	int ret;
 
-	if (!ifpga_bus_match(&drv->driver, &afu_dev->device))
-		/* Match of device and driver failed */
-		return 1;
+	/* Check if a driver is already loaded */
+	if (rte_dev_is_probed(&afu_dev->device)) {
+		IFPGA_BUS_DEBUG("Device %s is already probed",
+				rte_ifpga_device_name(afu_dev));
+		return -EEXIST;
+	}
 
 	/* reference driver structure */
-	afu_dev->driver = drv;
+	afu_dev->driver = afu_drv;
 
 	/* call the driver probe() function */
-	ret = drv->probe(afu_dev);
+	ret = afu_drv->probe(afu_dev);
 	if (ret)
 		afu_dev->driver = NULL;
 	else
-		afu_dev->device.driver = &drv->driver;
+		afu_dev->device.driver = &afu_drv->driver;
 
 	return ret;
 }
 
-static int
-ifpga_probe_all_drivers(struct rte_afu_device *afu_dev)
-{
-	struct rte_afu_driver *drv = NULL;
-	int ret = 0;
-
-	/* Check if a driver is already loaded */
-	if (rte_dev_is_probed(&afu_dev->device)) {
-		IFPGA_BUS_DEBUG("Device %s is already probed",
-				rte_ifpga_device_name(afu_dev));
-		return -EEXIST;
-	}
-
-	RTE_BUS_FOREACH_DRV(drv, &rte_ifpga_bus) {
-		ret = ifpga_probe_one_driver(drv, afu_dev);
-		if (ret < 0)
-			/* negative value is an error */
-			return ret;
-		if (ret > 0)
-			/* positive value means driver doesn't support it */
-			continue;
-		return 0;
-	}
-	if ((ret > 0) && (afu_dev->driver == NULL))
-		return 0;
-	else
-		return ret;
-}
-
 /*
  * Scan the content of the Intel FPGA bus, and call the probe() function for
  * all registered drivers that have a matching entry in its id_table
@@ -331,12 +306,21 @@ ifpga_probe(void)
 	int ret = 0;
 
 	RTE_BUS_FOREACH_DEV(afu_dev, &rte_ifpga_bus) {
-		ret = ifpga_probe_all_drivers(afu_dev);
+		struct rte_driver *drv = NULL;
+
+next_driver:
+		drv = rte_bus_find_driver(&rte_ifpga_bus, drv, &afu_dev->device);
+		if (drv == NULL)
+			continue;
+
+		ret = rte_ifpga_bus.probe_device(drv, &afu_dev->device);
 		if (ret == -EEXIST)
 			continue;
 		if (ret < 0)
 			IFPGA_BUS_ERR("failed to initialize %s device",
 				rte_ifpga_device_name(afu_dev));
+		else if (ret > 0)
+			goto next_driver;
 	}
 
 	return ret;
@@ -379,12 +363,6 @@ ifpga_cleanup(void)
 	return error;
 }
 
-static int
-ifpga_plug(struct rte_device *dev)
-{
-	return ifpga_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_afu_device));
-}
-
 static int
 ifpga_unplug(struct rte_device *dev)
 {
@@ -454,7 +432,7 @@ static struct rte_bus rte_ifpga_bus = {
 	.cleanup     = ifpga_cleanup,
 	.find_device = rte_bus_generic_find_device,
 	.match       = ifpga_bus_match,
-	.plug        = ifpga_plug,
+	.probe_device = ifpga_probe_device,
 	.unplug      = ifpga_unplug,
 	.parse       = ifpga_parse,
 };
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index d7fda1752a..b57320064e 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -181,51 +181,42 @@ pci_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
  * driver.
  */
 static int
-rte_pci_probe_one_driver(struct rte_pci_driver *dr,
-			 struct rte_pci_device *dev)
+pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
-	int ret;
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
+	struct rte_pci_driver *pci_drv = RTE_BUS_DRIVER(drv, *pci_drv);
+	struct rte_pci_addr *loc = &pci_dev->addr;
 	bool already_probed;
-	struct rte_pci_addr *loc;
-
-	if ((dr == NULL) || (dev == NULL))
-		return -EINVAL;
-
-	loc = &dev->addr;
-
-	/* The device is not blocked; Check if driver supports it */
-	if (!pci_bus_match(&dr->driver, &dev->device))
-		/* Match of device and driver failed */
-		return 1;
+	int ret;
 
 	PCI_LOG(DEBUG, "PCI device "PCI_PRI_FMT" on NUMA socket %i",
 		loc->domain, loc->bus, loc->devid, loc->function,
-		dev->device.numa_node);
+		pci_dev->device.numa_node);
 
 	/* no initialization when marked as blocked, return without error */
-	if (dev->device.devargs != NULL &&
-		dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+	if (pci_dev->device.devargs != NULL &&
+		pci_dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 		PCI_LOG(INFO, "  Device is blocked, not initializing");
 		return 1;
 	}
 
-	if (dev->device.numa_node < 0 && rte_socket_count() > 1)
-		PCI_LOG(INFO, "Device %s is not NUMA-aware", dev->name);
+	if (pci_dev->device.numa_node < 0 && rte_socket_count() > 1)
+		PCI_LOG(INFO, "Device %s is not NUMA-aware", pci_dev->name);
 
-	already_probed = rte_dev_is_probed(&dev->device);
-	if (already_probed && !(dr->drv_flags & RTE_PCI_DRV_PROBE_AGAIN)) {
-		PCI_LOG(DEBUG, "Device %s is already probed", dev->device.name);
+	already_probed = rte_dev_is_probed(&pci_dev->device);
+	if (already_probed && !(pci_drv->drv_flags & RTE_PCI_DRV_PROBE_AGAIN)) {
+		PCI_LOG(DEBUG, "Device %s is already probed", pci_dev->device.name);
 		return -EEXIST;
 	}
 
-	PCI_LOG(DEBUG, "  probe driver: %x:%x %s", dev->id.vendor_id,
-		dev->id.device_id, dr->driver.name);
+	PCI_LOG(DEBUG, "  probe driver: %x:%x %s", pci_dev->id.vendor_id,
+		pci_dev->id.device_id, pci_drv->driver.name);
 
 	if (!already_probed) {
 		enum rte_iova_mode dev_iova_mode;
 		enum rte_iova_mode iova_mode;
 
-		dev_iova_mode = pci_device_iova_mode(dr, dev);
+		dev_iova_mode = pci_device_iova_mode(pci_drv, pci_dev);
 		iova_mode = rte_eal_iova_mode();
 		if (dev_iova_mode != RTE_IOVA_DC &&
 		    dev_iova_mode != iova_mode) {
@@ -236,21 +227,21 @@ rte_pci_probe_one_driver(struct rte_pci_driver *dr,
 		}
 
 		/* Allocate interrupt instance for pci device */
-		dev->intr_handle =
+		pci_dev->intr_handle =
 			rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-		if (dev->intr_handle == NULL) {
+		if (pci_dev->intr_handle == NULL) {
 			PCI_LOG(ERR, "Failed to create interrupt instance for %s",
-				dev->device.name);
+				pci_dev->device.name);
 			return -ENOMEM;
 		}
 
-		dev->vfio_req_intr_handle =
+		pci_dev->vfio_req_intr_handle =
 			rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-		if (dev->vfio_req_intr_handle == NULL) {
-			rte_intr_instance_free(dev->intr_handle);
-			dev->intr_handle = NULL;
+		if (pci_dev->vfio_req_intr_handle == NULL) {
+			rte_intr_instance_free(pci_dev->intr_handle);
+			pci_dev->intr_handle = NULL;
 			PCI_LOG(ERR, "Failed to create vfio req interrupt instance for %s",
-				dev->device.name);
+				pci_dev->device.name);
 			return -ENOMEM;
 		}
 
@@ -259,43 +250,43 @@ rte_pci_probe_one_driver(struct rte_pci_driver *dr,
 		 * This needs to be before rte_pci_map_device(), as it enables
 		 * to use driver flags for adjusting configuration.
 		 */
-		dev->driver = dr;
-		if (dev->driver->drv_flags & RTE_PCI_DRV_NEED_MAPPING) {
-			ret = rte_pci_map_device(dev);
+		pci_dev->driver = pci_drv;
+		if (pci_dev->driver->drv_flags & RTE_PCI_DRV_NEED_MAPPING) {
+			ret = rte_pci_map_device(pci_dev);
 			if (ret != 0) {
-				dev->driver = NULL;
-				rte_intr_instance_free(dev->vfio_req_intr_handle);
-				dev->vfio_req_intr_handle = NULL;
-				rte_intr_instance_free(dev->intr_handle);
-				dev->intr_handle = NULL;
+				pci_dev->driver = NULL;
+				rte_intr_instance_free(pci_dev->vfio_req_intr_handle);
+				pci_dev->vfio_req_intr_handle = NULL;
+				rte_intr_instance_free(pci_dev->intr_handle);
+				pci_dev->intr_handle = NULL;
 				return ret;
 			}
 		}
 	}
 
 	PCI_LOG(INFO, "Probe PCI driver: %s (%x:%04x) device: "PCI_PRI_FMT" (socket %i)",
-		dr->driver.name, dev->id.vendor_id, dev->id.device_id,
+		pci_drv->driver.name, pci_dev->id.vendor_id, pci_dev->id.device_id,
 		loc->domain, loc->bus, loc->devid, loc->function,
-		dev->device.numa_node);
+		pci_dev->device.numa_node);
 	/* call the driver probe() function */
-	ret = dr->probe(dr, dev);
+	ret = pci_drv->probe(pci_drv, pci_dev);
 	if (already_probed)
 		return ret; /* no rollback if already succeeded earlier */
 	if (ret) {
-		dev->driver = NULL;
-		if ((dr->drv_flags & RTE_PCI_DRV_NEED_MAPPING) &&
+		pci_dev->driver = NULL;
+		if ((pci_drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING) &&
 			/* Don't unmap if device is unsupported and
 			 * driver needs mapped resources.
 			 */
 			!(ret > 0 &&
-				(dr->drv_flags & RTE_PCI_DRV_KEEP_MAPPED_RES)))
-			rte_pci_unmap_device(dev);
-		rte_intr_instance_free(dev->vfio_req_intr_handle);
-		dev->vfio_req_intr_handle = NULL;
-		rte_intr_instance_free(dev->intr_handle);
-		dev->intr_handle = NULL;
+				(pci_drv->drv_flags & RTE_PCI_DRV_KEEP_MAPPED_RES)))
+			rte_pci_unmap_device(pci_dev);
+		rte_intr_instance_free(pci_dev->vfio_req_intr_handle);
+		pci_dev->vfio_req_intr_handle = NULL;
+		rte_intr_instance_free(pci_dev->intr_handle);
+		pci_dev->intr_handle = NULL;
 	} else {
-		dev->device.driver = &dr->driver;
+		pci_dev->device.driver = &pci_drv->driver;
 	}
 
 	return ret;
@@ -343,33 +334,6 @@ rte_pci_detach_dev(struct rte_pci_device *dev)
 	return 0;
 }
 
-/*
- * If vendor/device ID match, call the probe() function of all
- * registered driver for the given device. Return < 0 if initialization
- * failed, return 1 if no driver is found for this device.
- */
-static int
-pci_probe_all_drivers(struct rte_pci_device *dev)
-{
-	struct rte_pci_driver *dr = NULL;
-	int rc = 0;
-
-	if (dev == NULL)
-		return -EINVAL;
-
-	RTE_BUS_FOREACH_DRV(dr, &rte_pci_bus.bus) {
-		rc = rte_pci_probe_one_driver(dr, dev);
-		if (rc < 0)
-			/* negative value is an error */
-			return rc;
-		if (rc > 0)
-			/* positive value means driver doesn't support it */
-			continue;
-		return 0;
-	}
-	return 1;
-}
-
 /*
  * Scan the content of the PCI bus, and call the probe() function for
  * all registered drivers that have a matching entry in its id_table
@@ -380,12 +344,19 @@ pci_probe(void)
 {
 	struct rte_pci_device *dev = NULL;
 	size_t probed = 0, failed = 0;
-	int ret = 0;
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
+		struct rte_driver *drv = NULL;
+		int ret;
+
 		probed++;
 
-		ret = pci_probe_all_drivers(dev);
+next_driver:
+		drv = rte_bus_find_driver(&rte_pci_bus.bus, drv, &dev->device);
+		if (drv == NULL)
+			continue;
+
+		ret = rte_pci_bus.bus.probe_device(drv, &dev->device);
 		if (ret < 0) {
 			if (ret != -EEXIST) {
 				PCI_LOG(ERR, "Requested device " PCI_PRI_FMT " cannot be used",
@@ -395,6 +366,8 @@ pci_probe(void)
 				failed++;
 			}
 			ret = 0;
+		} else if (ret > 0) {
+			goto next_driver;
 		}
 	}
 
@@ -595,12 +568,6 @@ pci_sigbus_handler(const void *failure_addr)
 	return ret;
 }
 
-static int
-pci_plug(struct rte_device *dev)
-{
-	return pci_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_pci_device));
-}
-
 static int
 pci_unplug(struct rte_device *dev)
 {
@@ -861,7 +828,7 @@ struct rte_pci_bus rte_pci_bus = {
 		.cleanup = pci_cleanup,
 		.find_device = rte_bus_generic_find_device,
 		.match = pci_bus_match,
-		.plug = pci_plug,
+		.probe_device = pci_probe_device,
 		.unplug = pci_unplug,
 		.parse = pci_parse,
 		.dev_compare = pci_dev_compare,
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 3d6b6efe6e..22979f31b3 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -404,43 +404,36 @@ platform_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 	return match;
 }
 
-static int
-device_attach(struct rte_platform_device *pdev)
-{
-	struct rte_platform_driver *pdrv;
-
-	RTE_BUS_FOREACH_DRV(pdrv, &platform_bus.bus) {
-		if (platform_bus_match(&pdrv->driver, &pdev->device))
-			break;
-	}
-
-	if (pdrv == NULL)
-		return -ENODEV;
-
-	return driver_probe_device(pdrv, pdev);
-}
-
 static int
 platform_bus_probe(void)
 {
 	struct rte_platform_device *pdev;
-	int ret;
 
 	RTE_BUS_FOREACH_DEV(pdev, &platform_bus.bus) {
-		ret = device_attach(pdev);
+		struct rte_driver *drv = NULL;
+		int ret;
+
+next_driver:
+		drv = rte_bus_find_driver(&platform_bus.bus, drv, &pdev->device);
+		if (drv == NULL)
+			continue;
+
+		ret = platform_bus.bus.probe_device(drv, &pdev->device);
 		if (ret == -EBUSY) {
 			PLATFORM_LOG_LINE(DEBUG, "device %s already probed", pdev->name);
 			continue;
 		}
-		if (ret)
+		if (ret < 0)
 			PLATFORM_LOG_LINE(ERR, "failed to probe %s", pdev->name);
+		else if (ret > 0)
+			goto next_driver;
 	}
 
 	return 0;
 }
 
 static int
-platform_bus_plug(struct rte_device *dev)
+platform_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
 	if (rte_bus_device_is_ignored(&platform_bus.bus, dev->name))
 		return -EPERM;
@@ -448,7 +441,8 @@ platform_bus_plug(struct rte_device *dev)
 	if (!dev_is_bound_vfio_platform(dev->name))
 		return -EPERM;
 
-	return device_attach(RTE_BUS_DEVICE(dev, struct rte_platform_device));
+	return driver_probe_device(RTE_BUS_DRIVER(drv, struct rte_platform_driver),
+		RTE_BUS_DEVICE(dev, struct rte_platform_device));
 }
 
 static void
@@ -559,7 +553,7 @@ struct rte_platform_bus platform_bus = {
 		.probe = platform_bus_probe,
 		.find_device = rte_bus_generic_find_device,
 		.match = platform_bus_match,
-		.plug = platform_bus_plug,
+		.probe_device = platform_bus_probe_device,
 		.unplug = platform_bus_unplug,
 		.parse = platform_bus_parse,
 		.dma_map = platform_bus_dma_map,
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index bc2858a5c5..d8e15cd479 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -351,74 +351,59 @@ uacce_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 }
 
 static int
-uacce_probe_one_driver(struct rte_uacce_driver *dr, struct rte_uacce_device *dev)
+uacce_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
-	const char *dev_name = dev->name;
-	bool already_probed;
+	struct rte_uacce_device *uacce_dev = RTE_BUS_DEVICE(dev, *uacce_dev);
+	struct rte_uacce_driver *uacce_drv = RTE_BUS_DRIVER(drv, *uacce_drv);
+	const char *dev_name = uacce_dev->name;
 	int ret;
 
-	if (!uacce_bus_match(&dr->driver, &dev->device))
-		/* Match of device and driver failed */
-		return 1;
-
-	already_probed = rte_dev_is_probed(&dev->device);
-	if (already_probed) {
+	if (rte_dev_is_probed(&uacce_dev->device)) {
 		UACCE_BUS_INFO("device %s is already probed", dev_name);
 		return -EEXIST;
 	}
 
-	UACCE_BUS_DEBUG("probe device %s using driver %s", dev_name, dr->driver.name);
+	UACCE_BUS_DEBUG("probe device %s using driver %s", dev_name, uacce_drv->driver.name);
 
-	ret = dr->probe(dr, dev);
+	ret = uacce_drv->probe(uacce_drv, uacce_dev);
 	if (ret != 0) {
 		UACCE_BUS_ERR("probe device %s with driver %s failed %d",
-			      dev_name, dr->driver.name, ret);
+			      dev_name, uacce_drv->driver.name, ret);
 	} else {
-		dev->device.driver = &dr->driver;
-		dev->driver = dr;
+		uacce_dev->device.driver = &uacce_drv->driver;
+		uacce_dev->driver = uacce_drv;
 		UACCE_BUS_DEBUG("probe device %s with driver %s success",
-				dev_name, dr->driver.name);
+				dev_name, uacce_drv->driver.name);
 	}
 
 	return ret;
 }
 
-static int
-uacce_probe_all_drivers(struct rte_uacce_device *dev)
-{
-	struct rte_uacce_driver *dr;
-	int rc;
-
-	RTE_BUS_FOREACH_DRV(dr, &uacce_bus.bus) {
-		rc = uacce_probe_one_driver(dr, dev);
-		if (rc < 0)
-			/* negative value is an error */
-			return rc;
-		if (rc > 0)
-			/* positive value means driver doesn't support it */
-			continue;
-		return 0;
-	}
-
-	return 1;
-}
-
 static int
 uacce_probe(void)
 {
 	size_t probed = 0, failed = 0;
 	struct rte_uacce_device *dev;
-	int ret;
 
 	RTE_BUS_FOREACH_DEV(dev, &uacce_bus.bus) {
+		struct rte_driver *drv = NULL;
+		int ret;
+
 		probed++;
 
-		ret = uacce_probe_all_drivers(dev);
+next_driver:
+		drv = rte_bus_find_driver(&uacce_bus.bus, drv, &dev->device);
+		if (drv == NULL)
+			continue;
+
+		ret = uacce_bus.bus.probe_device(drv, &dev->device);
 		if (ret < 0) {
 			UACCE_BUS_LOG(ERR, "Requested device %s cannot be used",
 				dev->name);
 			rte_errno = errno;
 			failed++;
+		} else if (ret > 0) {
+			goto next_driver;
 		}
 	}
 
@@ -456,12 +441,6 @@ uacce_cleanup(void)
 	return error;
 }
 
-static int
-uacce_plug(struct rte_device *dev)
-{
-	return uacce_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_uacce_device));
-}
-
 static int
 uacce_detach_dev(struct rte_uacce_device *dev)
 {
@@ -625,7 +604,7 @@ static struct rte_uacce_bus uacce_bus = {
 		.probe = uacce_probe,
 		.cleanup = uacce_cleanup,
 		.match = uacce_bus_match,
-		.plug = uacce_plug,
+		.probe_device = uacce_probe_device,
 		.unplug = uacce_unplug,
 		.find_device = rte_bus_generic_find_device,
 		.parse = uacce_parse,
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index a4f6168581..5464fe28d4 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -182,32 +182,30 @@ vdev_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 }
 
 static int
-vdev_probe_all_drivers(struct rte_vdev_device *dev)
+vdev_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
+	struct rte_vdev_device *vdev_dev = RTE_BUS_DEVICE(dev, *vdev_dev);
+	struct rte_vdev_driver *vdev_drv = RTE_BUS_DRIVER(drv, *vdev_drv);
 	const char *name;
-	struct rte_vdev_driver *driver;
 	enum rte_iova_mode iova_mode;
 	int ret;
 
-	if (rte_dev_is_probed(&dev->device))
+	if (rte_dev_is_probed(&vdev_dev->device))
 		return -EEXIST;
 
-	name = rte_vdev_device_name(dev);
+	name = rte_vdev_device_name(vdev_dev);
 	VDEV_LOG(DEBUG, "Search driver to probe device %s", name);
 
-	if (vdev_parse(name, &driver))
-		return -1;
-
 	iova_mode = rte_eal_iova_mode();
-	if ((driver->drv_flags & RTE_VDEV_DRV_NEED_IOVA_AS_VA) && (iova_mode == RTE_IOVA_PA)) {
+	if ((vdev_drv->drv_flags & RTE_VDEV_DRV_NEED_IOVA_AS_VA) && (iova_mode == RTE_IOVA_PA)) {
 		VDEV_LOG(ERR, "%s requires VA IOVA mode but current mode is PA, not initializing",
 				name);
 		return -1;
 	}
 
-	ret = driver->probe(dev);
+	ret = vdev_drv->probe(vdev_dev);
 	if (ret == 0)
-		dev->device.driver = &driver->driver;
+		vdev_dev->device.driver = &vdev_drv->driver;
 	return ret;
 }
 
@@ -323,14 +321,23 @@ rte_vdev_init(const char *name, const char *args)
 	rte_spinlock_recursive_lock(&vdev_device_list_lock);
 	ret = insert_vdev(name, args, &dev, true);
 	if (ret == 0) {
-		ret = vdev_probe_all_drivers(dev);
-		if (ret) {
-			if (ret > 0)
-				VDEV_LOG(ERR, "no driver found for %s", name);
+		struct rte_driver *drv = NULL;
+
+next_driver:
+		drv = rte_bus_find_driver(&rte_vdev_bus, drv, &dev->device);
+		if (drv == NULL) {
+			VDEV_LOG(ERR, "no driver found for %s", name);
+			ret = -1;
+		} else {
+			ret = rte_vdev_bus.probe_device(drv, &dev->device);
+		}
+		if (ret < 0) {
 			/* If fails, remove it from vdev list */
 			rte_bus_remove_device(&rte_vdev_bus, &dev->device);
 			rte_devargs_remove(dev->device.devargs);
 			free(dev);
+		} else if (ret > 0) {
+			goto next_driver;
 		}
 	}
 	rte_spinlock_recursive_unlock(&vdev_device_list_lock);
@@ -393,8 +400,6 @@ struct vdev_param {
 	char name[RTE_DEV_NAME_MAX_LEN];
 };
 
-static int vdev_plug(struct rte_device *dev);
-
 /**
  * This function works as the action for both primary and secondary process
  * for static vdev discovery when a secondary process is booting.
@@ -552,18 +557,27 @@ vdev_probe(void)
 
 	/* call the init function for each virtual device */
 	RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
+		struct rte_driver *drv = NULL;
+
 		/* we don't use the vdev lock here, as it's only used in DPDK
 		 * initialization; and we don't want to hold such a lock when
 		 * we call each driver probe.
 		 */
 
-		r = vdev_probe_all_drivers(dev);
-		if (r != 0) {
+next_driver:
+		drv = rte_bus_find_driver(&rte_vdev_bus, drv, &dev->device);
+		if (drv == NULL)
+			continue;
+
+		r = rte_vdev_bus.probe_device(drv, &dev->device);
+		if (r < 0) {
 			if (r == -EEXIST)
 				continue;
 			VDEV_LOG(ERR, "failed to initialize %s device",
 				rte_vdev_device_name(dev));
 			ret = -1;
+		} else if (r > 0) {
+			goto next_driver;
 		}
 	}
 
@@ -623,12 +637,6 @@ vdev_find_device(const struct rte_bus *bus __rte_unused, const struct rte_device
 	return dev;
 }
 
-static int
-vdev_plug(struct rte_device *dev)
-{
-	return vdev_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_vdev_device));
-}
-
 static int
 vdev_unplug(struct rte_device *dev)
 {
@@ -660,7 +668,7 @@ static struct rte_bus rte_vdev_bus = {
 	.cleanup = vdev_cleanup,
 	.find_device = vdev_find_device,
 	.match = vdev_bus_match,
-	.plug = vdev_plug,
+	.probe_device = vdev_probe_device,
 	.unplug = vdev_unplug,
 	.parse = vdev_parse,
 	.dma_map = vdev_dma_map,
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index d811f1a229..ba923a2669 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -79,85 +79,59 @@ vmbus_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 
 	return false;
 }
+
 /*
  * If device ID match, call the devinit() function of the driver.
  */
 static int
-vmbus_probe_one_driver(struct rte_vmbus_driver *dr,
-		       struct rte_vmbus_device *dev)
+vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 {
+	struct rte_vmbus_device *vmbus_dev = RTE_BUS_DEVICE(dev, *vmbus_dev);
+	struct rte_vmbus_driver *vmbus_drv = RTE_BUS_DRIVER(drv, *vmbus_drv);
 	char guid[RTE_UUID_STRLEN];
 	int ret;
 
-	if (!vmbus_bus_match(&dr->driver, &dev->device))
-		return 1;	 /* not supported */
+	/* Check if a driver is already loaded */
+	if (rte_dev_is_probed(&vmbus_dev->device)) {
+		VMBUS_LOG(DEBUG, "VMBUS driver already loaded");
+		return 0;
+	}
 
-	rte_uuid_unparse(dev->device_id, guid, sizeof(guid));
+	rte_uuid_unparse(vmbus_dev->device_id, guid, sizeof(guid));
 	VMBUS_LOG(INFO, "VMBUS device %s on NUMA socket %i",
-		  guid, dev->device.numa_node);
+		  guid, vmbus_dev->device.numa_node);
 
 	/* no initialization when marked as blocked, return without error */
-	if (dev->device.devargs != NULL &&
-		dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+	if (vmbus_dev->device.devargs != NULL &&
+		vmbus_dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 		VMBUS_LOG(INFO, "  Device is blocked, not initializing");
 		return 1;
 	}
 
 	/* map resources for device */
-	ret = rte_vmbus_map_device(dev);
+	ret = rte_vmbus_map_device(vmbus_dev);
 	if (ret != 0)
 		return ret;
 
 	/* reference driver structure */
-	dev->driver = dr;
+	vmbus_dev->driver = vmbus_drv;
 
-	if (dev->device.numa_node < 0 && rte_socket_count() > 1)
+	if (vmbus_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		VMBUS_LOG(INFO, "Device %s is not NUMA-aware", guid);
 
 	/* call the driver probe() function */
-	VMBUS_LOG(INFO, "  probe driver: %s", dr->driver.name);
-	ret = dr->probe(dr, dev);
-	if (ret) {
-		dev->driver = NULL;
-		rte_vmbus_unmap_device(dev);
+	VMBUS_LOG(INFO, "  probe driver: %s", vmbus_drv->driver.name);
+	ret = vmbus_drv->probe(vmbus_drv, vmbus_dev);
+	if (ret != 0) {
+		vmbus_dev->driver = NULL;
+		rte_vmbus_unmap_device(vmbus_dev);
 	} else {
-		dev->device.driver = &dr->driver;
+		vmbus_dev->device.driver = &vmbus_drv->driver;
 	}
 
 	return ret;
 }
 
-/*
- * If device class GUID matches, call the probe function of
- * register drivers for the vmbus device.
- * Return -1 if initialization failed,
- * and 1 if no driver found for this device.
- */
-static int
-vmbus_probe_all_drivers(struct rte_vmbus_device *dev)
-{
-	struct rte_vmbus_driver *dr;
-	int rc;
-
-	/* Check if a driver is already loaded */
-	if (rte_dev_is_probed(&dev->device)) {
-		VMBUS_LOG(DEBUG, "VMBUS driver already loaded");
-		return 0;
-	}
-
-	RTE_BUS_FOREACH_DRV(dr, &rte_vmbus_bus.bus) {
-		rc = vmbus_probe_one_driver(dr, dev);
-		if (rc < 0) /* negative is an error */
-			return -1;
-
-		if (rc > 0) /* positive driver doesn't support it */
-			continue;
-
-		return 0;
-	}
-	return 1;
-}
-
 /*
  * Scan the vmbus, and call the devinit() function for
  * all registered drivers that have a matching entry in its id_table
@@ -172,6 +146,9 @@ rte_vmbus_probe(void)
 	char ubuf[RTE_UUID_STRLEN];
 
 	RTE_BUS_FOREACH_DEV(dev, &rte_vmbus_bus.bus) {
+		struct rte_driver *drv = NULL;
+		int ret;
+
 		probed++;
 
 		rte_uuid_unparse(dev->device_id, ubuf, sizeof(ubuf));
@@ -179,11 +156,19 @@ rte_vmbus_probe(void)
 		if (rte_bus_device_is_ignored(&rte_vmbus_bus.bus, ubuf))
 			continue;
 
-		if (vmbus_probe_all_drivers(dev) < 0) {
+next_driver:
+		drv = rte_bus_find_driver(&rte_vmbus_bus.bus, drv, &dev->device);
+		if (drv == NULL)
+			continue;
+
+		ret = rte_vmbus_bus.bus.probe_device(drv, &dev->device);
+		if (ret < 0) {
 			VMBUS_LOG(NOTICE,
 				"Requested device %s cannot be used", ubuf);
 			rte_errno = errno;
 			failed++;
+		} else if (ret > 0) {
+			goto next_driver;
 		}
 	}
 
@@ -272,6 +257,7 @@ struct rte_vmbus_bus rte_vmbus_bus = {
 		.cleanup = rte_vmbus_cleanup,
 		.find_device = rte_bus_generic_find_device,
 		.match = vmbus_bus_match,
+		.probe_device = vmbus_probe_device,
 		.parse = vmbus_parse,
 		.dev_compare = vmbus_dev_compare,
 	},
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index c7591823ad..8215bcbba6 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -44,6 +44,7 @@ struct rte_dsa_device {
 struct dsa_bus;
 static int dsa_scan(void);
 static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev);
+static int dsa_probe_device(struct rte_driver *drv, struct rte_device *dev);
 static int dsa_probe(void);
 static enum rte_iova_mode dsa_get_iommu_class(void);
 static int dsa_addr_parse(const char *name, void *addr);
@@ -60,6 +61,7 @@ struct dsa_bus dsa_bus = {
 	.bus = {
 		.scan = dsa_scan,
 		.match = dsa_match,
+		.probe_device = dsa_probe_device,
 		.probe = dsa_probe,
 		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = dsa_get_iommu_class,
@@ -210,32 +212,33 @@ read_device_int(struct rte_dsa_device *dev, const char *filename,
 }
 
 static int
-idxd_probe_dsa(struct rte_dsa_device *dev)
+dsa_probe_device(__rte_unused struct rte_driver *drv, struct rte_device *dev)
 {
+	struct rte_dsa_device *dsa_dev = RTE_BUS_DEVICE(dev, *dsa_dev);
 	struct idxd_dmadev idxd = {0};
 	int ret = 0;
 
 	IDXD_PMD_INFO("Probing device %s on numa node %d",
-			dev->wq_name, dev->device.numa_node);
-	if (read_wq_int(dev, "size", &ret) < 0)
+			dsa_dev->wq_name, dsa_dev->device.numa_node);
+	if (read_wq_int(dsa_dev, "size", &ret) < 0)
 		return -1;
 	idxd.max_batches = ret;
-	if (read_wq_int(dev, "max_batch_size", &ret) < 0)
+	if (read_wq_int(dsa_dev, "max_batch_size", &ret) < 0)
 		return -1;
 	idxd.max_batch_size = ret;
-	idxd.qid = dev->addr.wq_id;
-	idxd.u.bus.dsa_id = dev->addr.device_id;
+	idxd.qid = dsa_dev->addr.wq_id;
+	idxd.u.bus.dsa_id = dsa_dev->addr.device_id;
 	idxd.sva_support = 1;
 
-	idxd.portal = idxd_bus_mmap_wq(dev);
+	idxd.portal = idxd_bus_mmap_wq(dsa_dev);
 	if (idxd.portal == NULL) {
 		IDXD_PMD_ERR("WQ mmap failed");
 		return -ENOENT;
 	}
 
-	ret = idxd_dmadev_create(dev->wq_name, &dev->device, &idxd, &idxd_bus_ops);
+	ret = idxd_dmadev_create(dsa_dev->wq_name, dev, &idxd, &idxd_bus_ops);
 	if (ret) {
-		IDXD_PMD_ERR("Failed to create dmadev %s", dev->wq_name);
+		IDXD_PMD_ERR("Failed to create dmadev %s", dsa_dev->wq_name);
 		return ret;
 	}
 
@@ -270,7 +273,7 @@ dsa_probe(void)
 		if (dsa_match(&dsa_bus.driver, &dev->device) &&
 				!rte_bus_device_is_ignored(&dsa_bus.bus, dev->device.name)) {
 			dev->device.driver = &dsa_bus.driver;
-			idxd_probe_dsa(dev);
+			dsa_probe_device(&dsa_bus.driver, &dev->device);
 			continue;
 		}
 		IDXD_PMD_DEBUG("WQ '%s', not allocated to DPDK", dev->wq_name);
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 4884cdfa50..88c417e8d3 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -36,8 +36,9 @@ rte_bus_register(struct rte_bus *bus)
 	RTE_VERIFY(bus->scan);
 	RTE_VERIFY(bus->probe);
 	RTE_VERIFY(bus->find_device);
-	/* Buses supporting driver plug also require unplug. */
-	RTE_VERIFY(!bus->plug || bus->unplug);
+
+	/* A bus providing probe_device requires match. */
+	RTE_VERIFY(!bus->probe_device || bus->match);
 
 	TAILQ_INIT(&bus->device_list);
 	TAILQ_INIT(&bus->driver_list);
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 17e8901546..a38c211e5d 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -179,6 +179,7 @@ int
 local_dev_probe(const char *devargs, struct rte_device **new_dev)
 {
 	struct rte_device *dev;
+	struct rte_driver *drv;
 	struct rte_devargs *da;
 	int ret;
 
@@ -191,7 +192,7 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 	if (ret)
 		goto err_devarg;
 
-	if (da->bus->plug == NULL) {
+	if (da->bus->probe_device == NULL) {
 		EAL_LOG(ERR, "Function plug not supported by bus (%s)",
 			da->bus->name);
 		ret = -ENOTSUP;
@@ -219,9 +220,16 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 	 * those devargs shouldn't be removed manually anymore.
 	 */
 
-	ret = dev->bus->plug(dev);
-	if (ret > 0)
+	drv = NULL;
+next_driver:
+	drv = rte_bus_find_driver(dev->bus, drv, dev);
+	if (drv == NULL) {
 		ret = -ENOTSUP;
+	} else {
+		ret = dev->bus->probe_device(drv, dev);
+		if (ret > 0)
+			goto next_driver;
+	}
 
 	if (ret && !rte_dev_is_probed(dev)) { /* if hasn't ever succeeded */
 		EAL_LOG(ERR, "Driver cannot attach the device (%s)",
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 8acd5d52bd..55568fe08a 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -85,6 +85,21 @@ typedef struct rte_device *
  */
 typedef int (*rte_bus_plug_t)(struct rte_device *dev);
 
+/**
+ * Implementation specific probe function which is responsible for linking
+ * devices on that bus with applicable drivers.
+ *
+ * @param drv
+ *	Driver that matches the device.
+ * @param dev
+ *	Device pointer that was returned by a previous call to find_device.
+ *
+ * @return
+ *	0 on success.
+ *	!0 on error.
+ */
+typedef int (*rte_bus_probe_device_t)(struct rte_driver *drv, struct rte_device *dev);
+
 /**
  * Implementation specific remove function which is responsible for unlinking
  * devices on that bus from assigned driver.
@@ -316,7 +331,7 @@ struct rte_bus {
 	rte_bus_probe_t probe;       /**< Probe devices on bus */
 	rte_bus_find_device_t find_device; /**< Find a device on the bus */
 	rte_bus_match_t match;       /**< Check if driver matches device */
-	rte_bus_plug_t plug;         /**< Probe single device for drivers */
+	rte_bus_probe_device_t probe_device; /**< Probe single device with driver */
 	rte_bus_unplug_t unplug;     /**< Remove single device from driver */
 	rte_bus_parse_t parse;       /**< Parse a device name */
 	rte_bus_dev_compare_t dev_compare; /**< Compare two device names */
-- 
2.53.0

