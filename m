Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E8BFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:46:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53BB14065E;
	Wed, 29 Apr 2026 13:46:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7EAF84065E
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yai4TbEzC4bzzGFm+c673KNsXTAfV6eyluX+SCHTNDs=;
 b=QNbso2O1iUWvFNYTV3J9UETeWi3pOAGNDyI49GlY2kWi9qLNGCSd4scS872fkEDp6eqLYM
 TG3+k56nYM/BCA502IESR2DI6ueEs6zUa7O6cDgiMclyS0u2320OleMgIh+uf482SFvWJi
 NaAlNwTquV3ve8JokqN6wbzRVtpE4fk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-s1HlB-rjP3ygYIuLePf2tg-1; Wed,
 29 Apr 2026 07:46:18 -0400
X-MC-Unique: s1HlB-rjP3ygYIuLePf2tg-1
X-Mimecast-MFC-AGG-ID: s1HlB-rjP3ygYIuLePf2tg_1777463175
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12A311800576; Wed, 29 Apr 2026 11:46:15 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D9451800480; Wed, 29 Apr 2026 11:46:09 +0000 (UTC)
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
Subject: [PATCH 08/23] bus: factorize device list
Date: Wed, 29 Apr 2026 13:44:41 +0200
Message-ID: <20260429114503.932575-9-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ovyI-Q8vqpkZGMquw7d_VyhcK0NfjljnfCGRk43n1YI_1777463175
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

Move device list from bus-specific structures to the common rte_bus
structure and remove unnecessary wrapper functions. This eliminates
code duplication across bus drivers.

Remove device_list from bus-specific structures and their wrapper
functions (e.g., rte_pci_add_device), using EAL helpers
(rte_bus_add_device, rte_bus_remove_device, rte_bus_insert_device)
directly instead. Remove custom iteration macros (FOREACH_DEVICE_ON_*)
and use standard TAILQ_FOREACH with rte_device* and RTE_BUS_DEVICE
macro.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c     | 47 ++++------------
 drivers/bus/auxiliary/bus_auxiliary_driver.h |  1 -
 drivers/bus/auxiliary/linux/auxiliary.c      |  7 +--
 drivers/bus/auxiliary/private.h              | 20 -------
 drivers/bus/cdx/bus_cdx_driver.h             |  1 -
 drivers/bus/cdx/cdx.c                        | 44 ++++-----------
 drivers/bus/cdx/private.h                    |  1 -
 drivers/bus/dpaa/bus_dpaa_driver.h           |  1 -
 drivers/bus/dpaa/dpaa_bus.c                  | 51 +++++++----------
 drivers/bus/fslmc/bus_fslmc_driver.h         |  1 -
 drivers/bus/fslmc/fslmc_bus.c                | 52 ++++++++---------
 drivers/bus/fslmc/fslmc_vfio.c               | 45 +++++++--------
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c     |  4 +-
 drivers/bus/fslmc/private.h                  |  2 -
 drivers/bus/ifpga/bus_ifpga_driver.h         |  1 -
 drivers/bus/ifpga/ifpga_bus.c                | 28 ++++------
 drivers/bus/pci/bsd/pci.c                    | 12 ++--
 drivers/bus/pci/bus_pci_driver.h             |  1 -
 drivers/bus/pci/linux/pci.c                  | 12 ++--
 drivers/bus/pci/pci_common.c                 | 55 +++++-------------
 drivers/bus/pci/private.h                    | 30 ----------
 drivers/bus/pci/windows/pci.c                | 12 ++--
 drivers/bus/platform/bus_platform_driver.h   |  1 -
 drivers/bus/platform/platform.c              | 32 +++++------
 drivers/bus/platform/private.h               |  5 --
 drivers/bus/uacce/bus_uacce_driver.h         |  1 -
 drivers/bus/uacce/uacce.c                    | 34 +++++------
 drivers/bus/vdev/bus_vdev_driver.h           |  1 -
 drivers/bus/vdev/vdev.c                      | 45 +++++++--------
 drivers/bus/vmbus/bus_vmbus_driver.h         |  1 -
 drivers/bus/vmbus/linux/vmbus_bus.c          |  7 +--
 drivers/bus/vmbus/private.h                  | 10 ----
 drivers/bus/vmbus/vmbus_common.c             | 41 +++-----------
 drivers/dma/idxd/idxd_bus.c                  | 21 ++-----
 lib/eal/common/eal_common_bus.c              | 27 +++++++++
 lib/eal/include/bus_driver.h                 | 59 ++++++++++++++++++++
 36 files changed, 286 insertions(+), 427 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 7e2d832dda..a1a3a747a5 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -198,7 +198,7 @@ auxiliary_probe(void)
 	size_t probed = 0, failed = 0;
 	int ret = 0;
 
-	FOREACH_DEVICE_ON_AUXILIARY_BUS(dev) {
+	RTE_BUS_FOREACH_DEV(dev, &auxiliary_bus.bus) {
 		probed++;
 
 		ret = auxiliary_probe_all_drivers(dev);
@@ -251,45 +251,21 @@ rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 	rte_bus_remove_driver(&auxiliary_bus.bus, &driver->driver);
 }
 
-/* Add a device to auxiliary bus */
-void
-auxiliary_add_device(struct rte_auxiliary_device *aux_dev)
-{
-	TAILQ_INSERT_TAIL(&auxiliary_bus.device_list, aux_dev, next);
-}
-
-/* Insert a device into a predefined position in auxiliary bus */
-void
-auxiliary_insert_device(struct rte_auxiliary_device *exist_aux_dev,
-			struct rte_auxiliary_device *new_aux_dev)
-{
-	TAILQ_INSERT_BEFORE(exist_aux_dev, new_aux_dev, next);
-}
-
-/* Remove a device from auxiliary bus */
-static void
-rte_auxiliary_remove_device(struct rte_auxiliary_device *auxiliary_dev)
-{
-	TAILQ_REMOVE(&auxiliary_bus.device_list, auxiliary_dev, next);
-}
-
 static struct rte_device *
 auxiliary_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 		      const void *data)
 {
-	const struct rte_auxiliary_device *pstart;
-	struct rte_auxiliary_device *adev;
+	struct rte_device *dev;
 
 	if (start != NULL) {
-		pstart = RTE_BUS_DEVICE(start, *pstart);
-		adev = TAILQ_NEXT(pstart, next);
+		dev = TAILQ_NEXT(start, next);
 	} else {
-		adev = TAILQ_FIRST(&auxiliary_bus.device_list);
+		dev = TAILQ_FIRST(&auxiliary_bus.bus.device_list);
 	}
-	while (adev != NULL) {
-		if (cmp(&adev->device, data) == 0)
-			return &adev->device;
-		adev = TAILQ_NEXT(adev, next);
+	while (dev != NULL) {
+		if (cmp(dev, data) == 0)
+			return dev;
+		dev = TAILQ_NEXT(dev, next);
 	}
 	return NULL;
 }
@@ -310,7 +286,7 @@ auxiliary_unplug(struct rte_device *dev)
 
 	ret = rte_auxiliary_driver_remove_dev(adev);
 	if (ret == 0) {
-		rte_auxiliary_remove_device(adev);
+		rte_bus_remove_device(&auxiliary_bus.bus, &adev->device);
 		rte_devargs_remove(dev->devargs);
 		rte_intr_instance_free(adev->intr_handle);
 		free(adev);
@@ -321,10 +297,10 @@ auxiliary_unplug(struct rte_device *dev)
 static int
 auxiliary_cleanup(void)
 {
-	struct rte_auxiliary_device *dev, *tmp_dev;
+	struct rte_auxiliary_device *dev;
 	int error = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &auxiliary_bus.device_list, next, tmp_dev) {
+	RTE_BUS_FOREACH_DEV(dev, &auxiliary_bus.bus) {
 		int ret;
 
 		if (!rte_dev_is_probed(&dev->device))
@@ -391,7 +367,6 @@ struct rte_auxiliary_bus auxiliary_bus = {
 		.get_iommu_class = auxiliary_get_iommu_class,
 		.dev_iterate = auxiliary_dev_iterate,
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(auxiliary_bus.device_list),
 };
 
 RTE_REGISTER_BUS(auxiliary, auxiliary_bus.bus);
diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index 59c46e08a0..165145b15e 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -110,7 +110,6 @@ typedef int (rte_auxiliary_dma_unmap_t)(struct rte_auxiliary_device *dev,
  * A structure describing an auxiliary device.
  */
 struct rte_auxiliary_device {
-	RTE_TAILQ_ENTRY(rte_auxiliary_device) next; /**< Next probed device. */
 	struct rte_device device;                 /**< Inherit core device */
 	char name[RTE_DEV_NAME_MAX_LEN + 1];      /**< ASCII device name */
 	struct rte_intr_handle *intr_handle;       /**< Interrupt handle */
diff --git a/drivers/bus/auxiliary/linux/auxiliary.c b/drivers/bus/auxiliary/linux/auxiliary.c
index 7c430629d0..c65bbc8fcc 100644
--- a/drivers/bus/auxiliary/linux/auxiliary.c
+++ b/drivers/bus/auxiliary/linux/auxiliary.c
@@ -35,7 +35,6 @@ auxiliary_scan_one(const char *dirname, const char *name)
 		return -1;
 	}
 	dev->device.name = dev->name;
-	dev->device.bus = &auxiliary_bus.bus;
 
 	/* Get NUMA node, default to 0 if not present */
 	snprintf(filename, sizeof(filename), "%s/%s/numa_node",
@@ -49,12 +48,12 @@ auxiliary_scan_one(const char *dirname, const char *name)
 	auxiliary_on_scan(dev);
 
 	/* Device is valid, add in list (sorted) */
-	TAILQ_FOREACH(dev2, &auxiliary_bus.device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev2, &auxiliary_bus.bus) {
 		ret = strcmp(dev->name, dev2->name);
 		if (ret > 0)
 			continue;
 		if (ret < 0) {
-			auxiliary_insert_device(dev2, dev);
+			rte_bus_insert_device(&auxiliary_bus.bus, &dev2->device, &dev->device);
 		} else { /* already registered */
 			if (rte_dev_is_probed(&dev2->device) &&
 			    dev2->device.devargs != dev->device.devargs) {
@@ -66,7 +65,7 @@ auxiliary_scan_one(const char *dirname, const char *name)
 		}
 		return 0;
 	}
-	auxiliary_add_device(dev);
+	rte_bus_add_device(&auxiliary_bus.bus, &dev->device);
 	return 0;
 }
 
diff --git a/drivers/bus/auxiliary/private.h b/drivers/bus/auxiliary/private.h
index 66ba97b946..0b3d73a08d 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -24,15 +24,10 @@ extern int auxiliary_bus_logtype;
  */
 struct rte_auxiliary_bus {
 	struct rte_bus bus;                  /* Inherit the generic class */
-	TAILQ_HEAD(, rte_auxiliary_device) device_list;  /* List of devices */
 };
 
 extern struct rte_auxiliary_bus auxiliary_bus;
 
-/* Auxiliary bus iterators */
-#define FOREACH_DEVICE_ON_AUXILIARY_BUS(p) \
-	TAILQ_FOREACH(p, &(auxiliary_bus.device_list), next)
-
 /*
  * Test whether the auxiliary device exist.
  */
@@ -49,21 +44,6 @@ int auxiliary_scan(void);
  */
 void auxiliary_on_scan(struct rte_auxiliary_device *aux_dev);
 
-/*
- * Add an auxiliary device to the auxiliary bus (append to auxiliary device
- * list). This function also updates the bus references of the auxiliary
- * device and the generic device object embedded within.
- */
-void auxiliary_add_device(struct rte_auxiliary_device *aux_dev);
-
-/*
- * Insert an auxiliary device in the auxiliary bus at a particular location
- * in the device list. It also updates the auxiliary bus reference of the
- * new devices to be inserted.
- */
-void auxiliary_insert_device(struct rte_auxiliary_device *exist_aux_dev,
-			     struct rte_auxiliary_device *new_aux_dev);
-
 /*
  * Match the auxiliary driver and device by driver function.
  */
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index 823a5b1be3..cee6c4a8d6 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -53,7 +53,6 @@ struct rte_cdx_id {
  * A structure describing a CDX device.
  */
 struct rte_cdx_device {
-	RTE_TAILQ_ENTRY(rte_cdx_device) next;	/**< Next probed CDX device. */
 	struct rte_device device;		/**< Inherit core device */
 	struct rte_cdx_driver *driver;		/**< CDX driver used in probing */
 	char name[RTE_DEV_NAME_MAX_LEN];	/**< Device name */
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 5973f75be2..bc221a4d00 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -84,10 +84,6 @@
 
 #define CDX_DEV_PREFIX	"cdx-"
 
-/* CDX Bus iterators */
-#define FOREACH_DEVICE_ON_CDXBUS(p)	\
-		RTE_TAILQ_FOREACH(p, &rte_cdx_bus.device_list, next)
-
 struct rte_cdx_bus rte_cdx_bus;
 
 enum cdx_params {
@@ -99,13 +95,6 @@ static const char * const cdx_params_keys[] = {
 	NULL,
 };
 
-/* Add a device to CDX bus */
-static void
-cdx_add_device(struct rte_cdx_device *cdx_dev)
-{
-	TAILQ_INSERT_TAIL(&rte_cdx_bus.device_list, cdx_dev, next);
-}
-
 static int
 cdx_get_kernel_driver_by_path(const char *filename, char *driver_name,
 		size_t len)
@@ -167,7 +156,6 @@ cdx_scan_one(const char *dirname, const char *dev_name)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->device.bus = &rte_cdx_bus.bus;
 	memcpy(dev->name, dev_name, RTE_DEV_NAME_MAX_LEN);
 	dev->device.name = dev->name;
 
@@ -215,7 +203,7 @@ cdx_scan_one(const char *dirname, const char *dev_name)
 	}
 	dev->id.device_id = (uint16_t)tmp;
 
-	cdx_add_device(dev);
+	rte_bus_add_device(&rte_cdx_bus.bus, &dev->device);
 
 	return 0;
 
@@ -416,7 +404,7 @@ cdx_probe(void)
 	size_t probed = 0, failed = 0;
 	int ret = 0;
 
-	FOREACH_DEVICE_ON_CDXBUS(dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_cdx_bus.bus) {
 		probed++;
 
 		ret = cdx_probe_all_drivers(dev);
@@ -465,30 +453,21 @@ static struct rte_device *
 cdx_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 		const void *data)
 {
-	const struct rte_cdx_device *cdx_start;
-	struct rte_cdx_device *cdx_dev;
+	struct rte_device *dev;
 
 	if (start != NULL) {
-		cdx_start = RTE_BUS_DEVICE(start, *cdx_start);
-		cdx_dev = TAILQ_NEXT(cdx_start, next);
+		dev = TAILQ_NEXT(start, next);
 	} else {
-		cdx_dev = TAILQ_FIRST(&rte_cdx_bus.device_list);
+		dev = TAILQ_FIRST(&rte_cdx_bus.bus.device_list);
 	}
-	while (cdx_dev != NULL) {
-		if (cmp(&cdx_dev->device, data) == 0)
-			return &cdx_dev->device;
-		cdx_dev = TAILQ_NEXT(cdx_dev, next);
+	while (dev != NULL) {
+		if (cmp(dev, data) == 0)
+			return dev;
+		dev = TAILQ_NEXT(dev, next);
 	}
 	return NULL;
 }
 
-/* Remove a device from CDX bus */
-static void
-cdx_remove_device(struct rte_cdx_device *cdx_dev)
-{
-	TAILQ_REMOVE(&rte_cdx_bus.device_list, cdx_dev, next);
-}
-
 /*
  * If vendor/device ID match, call the remove() function of the
  * driver.
@@ -534,7 +513,7 @@ cdx_unplug(struct rte_device *dev)
 
 	ret = cdx_detach_dev(cdx_dev);
 	if (ret == 0) {
-		cdx_remove_device(cdx_dev);
+		rte_bus_remove_device(&rte_cdx_bus.bus, &cdx_dev->device);
 		rte_devargs_remove(dev->devargs);
 		free(cdx_dev);
 	}
@@ -562,7 +541,7 @@ cdx_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 static enum rte_iova_mode
 cdx_get_iommu_class(void)
 {
-	if (TAILQ_EMPTY(&rte_cdx_bus.device_list))
+	if (TAILQ_EMPTY(&rte_cdx_bus.bus.device_list))
 		return RTE_IOVA_DC;
 
 	return RTE_IOVA_VA;
@@ -624,7 +603,6 @@ struct rte_cdx_bus rte_cdx_bus = {
 		.get_iommu_class = cdx_get_iommu_class,
 		.dev_iterate = cdx_dev_iterate,
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(rte_cdx_bus.device_list),
 };
 
 RTE_REGISTER_BUS(cdx, rte_cdx_bus.bus);
diff --git a/drivers/bus/cdx/private.h b/drivers/bus/cdx/private.h
index 3807a17bfb..f69673aaab 100644
--- a/drivers/bus/cdx/private.h
+++ b/drivers/bus/cdx/private.h
@@ -12,7 +12,6 @@
  */
 struct rte_cdx_bus {
 	struct rte_bus bus;				/**< Inherit the generic class */
-	RTE_TAILQ_HEAD(, rte_cdx_device) device_list;	/**< List of CDX devices */
 };
 
 /**
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 1575ed19e7..7e5e9b2126 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -79,7 +79,6 @@ struct dpaa_device_id {
 };
 
 struct rte_dpaa_device {
-	TAILQ_ENTRY(rte_dpaa_device) next;
 	struct rte_device device;
 	union {
 		struct rte_eth_dev *eth_dev;
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index f9f902cbd6..8305f8cb23 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -59,7 +59,6 @@
 
 struct rte_dpaa_bus {
 	struct rte_bus bus;
-	TAILQ_HEAD(, rte_dpaa_device) device_list;
 	int device_count;
 	int detected;
 	uint32_t svr_ver;
@@ -164,19 +163,18 @@ dpaa_add_to_device_list(struct rte_dpaa_device *newdev)
 {
 	int comp, inserted = 0;
 	struct rte_dpaa_device *dev = NULL;
-	struct rte_dpaa_device *tdev = NULL;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_dpaa_bus.device_list, next, tdev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
 		comp = compare_dpaa_devices(newdev, dev);
 		if (comp < 0) {
-			TAILQ_INSERT_BEFORE(dev, newdev, next);
+			rte_bus_insert_device(&rte_dpaa_bus.bus, &dev->device, &newdev->device);
 			inserted = 1;
 			break;
 		}
 	}
 
 	if (!inserted)
-		TAILQ_INSERT_TAIL(&rte_dpaa_bus.device_list, newdev, next);
+		rte_bus_add_device(&rte_dpaa_bus.bus, &newdev->device);
 }
 
 /*
@@ -217,7 +215,6 @@ dpaa_create_device_list(void)
 			goto cleanup;
 		}
 
-		dev->device.bus = &rte_dpaa_bus.bus;
 		dev->device.numa_node = SOCKET_ID_ANY;
 
 		/* Allocate interrupt handle instance */
@@ -347,10 +344,9 @@ static void
 dpaa_clean_device_list(void)
 {
 	struct rte_dpaa_device *dev = NULL;
-	struct rte_dpaa_device *tdev = NULL;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_dpaa_bus.device_list, next, tdev) {
-		TAILQ_REMOVE(&rte_dpaa_bus.device_list, dev, next);
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
+		rte_bus_remove_device(&rte_dpaa_bus.bus, &dev->device);
 		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
 		dev = NULL;
@@ -775,7 +771,7 @@ rte_dpaa_bus_probe(void)
 	process_once = 1;
 
 	/* If no device present on DPAA bus nothing needs to be done */
-	if (TAILQ_EMPTY(&rte_dpaa_bus.device_list))
+	if (TAILQ_EMPTY(&rte_dpaa_bus.bus.device_list))
 		return 0;
 
 	/* Register DPAA mempool ops only if any DPAA device has
@@ -783,7 +779,7 @@ rte_dpaa_bus_probe(void)
 	 */
 	rte_mbuf_set_platform_mempool_ops(DPAA_MEMPOOL_OPS_NAME);
 
-	TAILQ_FOREACH(dev, &rte_dpaa_bus.device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
 		if (dev->device_type == FSL_DPAA_ETH) {
 			ret = rte_dpaa_setup_intr(dev->intr_handle);
 			if (ret)
@@ -795,7 +791,7 @@ rte_dpaa_bus_probe(void)
 	dpaax_iova_table_populate();
 
 	/* For each registered driver, and device, call the driver->probe */
-	TAILQ_FOREACH(dev, &rte_dpaa_bus.device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
 		RTE_BUS_FOREACH_DRV(drv, &rte_dpaa_bus.bus) {
 			ret = rte_dpaa_device_match(drv, dev);
 			if (ret)
@@ -826,24 +822,22 @@ static struct rte_device *
 rte_dpaa_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 		     const void *data)
 {
-	struct rte_dpaa_device *dev;
-	const struct rte_dpaa_device *dstart;
+	struct rte_device *dev;
 
 	/* find_device is called with 'data' as an opaque object - just call
 	 * cmp with this and each device object on bus.
 	 */
 
 	if (start != NULL) {
-		dstart = RTE_BUS_DEVICE(start, *dstart);
-		dev = TAILQ_NEXT(dstart, next);
+		dev = TAILQ_NEXT(start, next);
 	} else {
-		dev = TAILQ_FIRST(&rte_dpaa_bus.device_list);
+		dev = TAILQ_FIRST(&rte_dpaa_bus.bus.device_list);
 	}
 
 	while (dev != NULL) {
-		if (cmp(&dev->device, data) == 0) {
-			DPAA_BUS_DEBUG("Found dev=(%s)", dev->device.name);
-			return &dev->device;
+		if (cmp(dev, data) == 0) {
+			DPAA_BUS_DEBUG("Found dev=(%s)", dev->name);
+			return dev;
 		}
 		dev = TAILQ_NEXT(dev, next);
 	}
@@ -883,9 +877,8 @@ static void *
 dpaa_bus_dev_iterate(const void *start, const char *str,
 		     const struct rte_dev_iterator *it __rte_unused)
 {
-	const struct rte_dpaa_device *dstart;
-	struct rte_dpaa_device *dev;
 	char *dup, *dev_name = NULL;
+	struct rte_device *dev;
 
 	if (str == NULL) {
 		DPAA_BUS_DEBUG("No device string");
@@ -907,16 +900,15 @@ dpaa_bus_dev_iterate(const void *start, const char *str,
 	dev_name = dup + strlen("name=");
 
 	if (start != NULL) {
-		dstart = RTE_BUS_DEVICE(start, *dstart);
-		dev = TAILQ_NEXT(dstart, next);
+		dev = TAILQ_NEXT((const struct rte_device *)start, next);
 	} else {
-		dev = TAILQ_FIRST(&rte_dpaa_bus.device_list);
+		dev = TAILQ_FIRST(&rte_dpaa_bus.bus.device_list);
 	}
 
 	while (dev != NULL) {
-		if (strcmp(dev->device.name, dev_name) == 0) {
+		if (strcmp(dev->name, dev_name) == 0) {
 			free(dup);
-			return &dev->device;
+			return dev;
 		}
 		dev = TAILQ_NEXT(dev, next);
 	}
@@ -928,10 +920,10 @@ dpaa_bus_dev_iterate(const void *start, const char *str,
 static int
 dpaa_bus_cleanup(void)
 {
-	struct rte_dpaa_device *dev, *tmp_dev;
+	struct rte_dpaa_device *dev;
 
 	BUS_INIT_FUNC_TRACE();
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_dpaa_bus.device_list, next, tmp_dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
 		struct rte_dpaa_driver *drv = dev->driver;
 		int ret = 0;
 
@@ -988,7 +980,6 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.cleanup = dpaa_bus_cleanup,
 	},
 	.max_push_rxq_num = DPAA_DEFAULT_PUSH_MODE_QUEUE,
-	.device_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.device_list),
 	.device_count = 0,
 };
 
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index c82b182720..ab8bc1c41d 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -93,7 +93,6 @@ enum rte_dpaa2_dev_type {
  * A structure describing a DPAA2 device.
  */
 struct rte_dpaa2_device {
-	TAILQ_ENTRY(rte_dpaa2_device) next; /**< Next probed DPAA2 device. */
 	struct rte_device device;           /**< Inherit core device */
 	enum rte_dpaa2_dev_type dev_type;   /**< Device Type */
 	uint16_t object_id;                 /**< DPAA2 Object ID */
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 36ec018785..3e7f03375a 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -46,10 +46,9 @@ static void
 cleanup_fslmc_device_list(void)
 {
 	struct rte_dpaa2_device *dev;
-	struct rte_dpaa2_device *t_dev;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_fslmc_bus.device_list, next, t_dev) {
-		TAILQ_REMOVE(&rte_fslmc_bus.device_list, dev, next);
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+		rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
 		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
 		dev = NULL;
@@ -84,19 +83,18 @@ insert_in_device_list(struct rte_dpaa2_device *newdev)
 {
 	int comp, inserted = 0;
 	struct rte_dpaa2_device *dev = NULL;
-	struct rte_dpaa2_device *tdev = NULL;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_fslmc_bus.device_list, next, tdev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		comp = compare_dpaa2_devname(newdev, dev);
 		if (comp < 0) {
-			TAILQ_INSERT_BEFORE(dev, newdev, next);
+			rte_bus_insert_device(&rte_fslmc_bus.bus, &dev->device, &newdev->device);
 			inserted = 1;
 			break;
 		}
 	}
 
 	if (!inserted)
-		TAILQ_INSERT_TAIL(&rte_fslmc_bus.device_list, newdev, next);
+		rte_bus_add_device(&rte_fslmc_bus.bus, &newdev->device);
 }
 
 static void
@@ -107,7 +105,7 @@ dump_device_list(void)
 	/* Only if the log level has been set to Debugging, print list */
 	if (rte_log_can_log(dpaa2_logtype_bus, RTE_LOG_DEBUG)) {
 		DPAA2_BUS_LOG(DEBUG, "List of devices scanned on bus:");
-		TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next) {
+		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 			DPAA2_BUS_LOG(DEBUG, "\t\t%s", dev->device.name);
 		}
 	}
@@ -142,7 +140,6 @@ scan_one_fslmc_device(char *dev_name)
 		return -ENOMEM;
 	}
 
-	dev->device.bus = &rte_fslmc_bus.bus;
 	dev->device.numa_node = SOCKET_ID_ANY;
 
 	/* Allocate interrupt instance */
@@ -319,7 +316,7 @@ rte_fslmc_scan(void)
 		struct rte_dpaa2_device *dev;
 
 		DPAA2_BUS_DEBUG("Fslmc bus already scanned. Not rescanning");
-		TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next) {
+		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 			dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus.bus,
 				dev->device.name);
 		}
@@ -420,7 +417,7 @@ rte_fslmc_probe(void)
 		.align = alignof(dpaa2_seqn_t),
 	};
 
-	if (TAILQ_EMPTY(&rte_fslmc_bus.device_list))
+	if (TAILQ_EMPTY(&rte_fslmc_bus.bus.device_list))
 		return 0;
 
 	dpaa2_seqn_dynfield_offset =
@@ -456,7 +453,7 @@ rte_fslmc_probe(void)
 		return 0;
 	}
 
-	TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
 			ret = rte_fslmc_match(drv, dev);
 			if (ret)
@@ -486,8 +483,7 @@ static struct rte_device *
 rte_fslmc_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 		      const void *data)
 {
-	const struct rte_dpaa2_device *dstart;
-	struct rte_dpaa2_device *dev;
+	struct rte_device *dev;
 
 	DPAA2_BUS_DEBUG("Finding a device named %s", (const char *)data);
 
@@ -497,16 +493,15 @@ rte_fslmc_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 	 */
 
 	if (start != NULL) {
-		dstart = RTE_BUS_DEVICE(start, *dstart);
-		dev = TAILQ_NEXT(dstart, next);
+		dev = TAILQ_NEXT(start, next);
 	} else {
-		dev = TAILQ_FIRST(&rte_fslmc_bus.device_list);
+		dev = TAILQ_FIRST(&rte_fslmc_bus.bus.device_list);
 	}
 	while (dev != NULL) {
-		if (cmp(&dev->device, data) == 0) {
+		if (cmp(dev, data) == 0) {
 			DPAA2_BUS_DEBUG("Found device (%s)",
-					dev->device.name);
-			return &dev->device;
+					dev->name);
+			return dev;
 		}
 		dev = TAILQ_NEXT(dev, next);
 	}
@@ -543,7 +538,7 @@ fslmc_all_device_support_iova(void)
 	struct rte_dpaa2_device *dev;
 	struct rte_dpaa2_driver *drv;
 
-	TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
 			ret = rte_fslmc_match(drv, dev);
 			if (ret)
@@ -565,7 +560,7 @@ rte_dpaa2_get_iommu_class(void)
 	if (rte_eal_iova_mode() == RTE_IOVA_PA)
 		return RTE_IOVA_PA;
 
-	if (TAILQ_EMPTY(&rte_fslmc_bus.device_list))
+	if (TAILQ_EMPTY(&rte_fslmc_bus.bus.device_list))
 		return RTE_IOVA_DC;
 
 	/* check if all devices on the bus support Virtual addressing or not */
@@ -632,9 +627,8 @@ static void *
 fslmc_bus_dev_iterate(const void *start, const char *str,
 		      const struct rte_dev_iterator *it __rte_unused)
 {
-	const struct rte_dpaa2_device *dstart;
-	struct rte_dpaa2_device *dev;
 	char *dup, *dev_name = NULL;
+	struct rte_device *dev;
 
 	if (str == NULL) {
 		DPAA2_BUS_DEBUG("No device string");
@@ -656,16 +650,15 @@ fslmc_bus_dev_iterate(const void *start, const char *str,
 	dev_name = dup + strlen("name=");
 
 	if (start != NULL) {
-		dstart = RTE_BUS_DEVICE(start, *dstart);
-		dev = TAILQ_NEXT(dstart, next);
+		dev = TAILQ_NEXT(RTE_CAST_PTR(struct rte_device *, start), next);
 	} else {
-		dev = TAILQ_FIRST(&rte_fslmc_bus.device_list);
+		dev = TAILQ_FIRST(&rte_fslmc_bus.bus.device_list);
 	}
 
 	while (dev != NULL) {
-		if (strcmp(dev->device.name, dev_name) == 0) {
+		if (strcmp(dev->name, dev_name) == 0) {
 			free(dup);
-			return &dev->device;
+			return dev;
 		}
 		dev = TAILQ_NEXT(dev, next);
 	}
@@ -687,7 +680,6 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 		.unplug = fslmc_bus_unplug,
 		.dev_iterate = fslmc_bus_dev_iterate,
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(rte_fslmc_bus.device_list),
 	.device_count = {0},
 };
 
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 7daa18d850..e38f3e9fe7 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1539,7 +1539,7 @@ fslmc_process_mcp(struct rte_dpaa2_device *dev)
 int
 fslmc_vfio_close_group(void)
 {
-	struct rte_dpaa2_device *dev, *dev_temp;
+	struct rte_dpaa2_device *dev;
 	int vfio_group_fd;
 	const char *group_name = fslmc_vfio_get_group_name();
 
@@ -1552,12 +1552,12 @@ fslmc_vfio_close_group(void)
 		return -EIO;
 	}
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_fslmc_bus.device_list, next, dev_temp) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		if (dev->device.devargs &&
 		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 			DPAA2_BUS_LOG(DEBUG, "%s Blacklisted, skipping",
 				      dev->device.name);
-			TAILQ_REMOVE(&rte_fslmc_bus.device_list, dev, next);
+			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
 				continue;
 		}
 		switch (dev->dev_type) {
@@ -1593,12 +1593,11 @@ fslmc_vfio_process_group(void)
 {
 	int ret;
 	int found_mportal = 0;
-	struct rte_dpaa2_device *dev, *dev_temp;
+	struct rte_dpaa2_device *dev;
 	bool is_dpmcp_in_blocklist = false, is_dpio_in_blocklist = false;
 	int dpmcp_count = 0, dpio_count = 0, current_device;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_fslmc_bus.device_list, next,
-		dev_temp) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		if (dev->dev_type == DPAA2_MPORTAL) {
 			dpmcp_count++;
 			if (dev->device.devargs &&
@@ -1615,16 +1614,15 @@ fslmc_vfio_process_group(void)
 
 	/* Search the MCP as that should be initialized first. */
 	current_device = 0;
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_fslmc_bus.device_list, next,
-		dev_temp) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		if (dev->dev_type == DPAA2_MPORTAL) {
 			current_device++;
 			if (dev->device.devargs &&
 			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 				DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 					      dev->device.name);
-				TAILQ_REMOVE(&rte_fslmc_bus.device_list,
-						dev, next);
+				rte_bus_remove_device(&rte_fslmc_bus.bus,
+						&dev->device);
 				continue;
 			}
 
@@ -1632,8 +1630,8 @@ fslmc_vfio_process_group(void)
 			    !is_dpmcp_in_blocklist) {
 				if (dpmcp_count == 1 ||
 				    current_device != dpmcp_count) {
-					TAILQ_REMOVE(&rte_fslmc_bus.device_list,
-						     dev, next);
+					rte_bus_remove_device(&rte_fslmc_bus.bus,
+						     &dev->device);
 					continue;
 				}
 			}
@@ -1647,7 +1645,7 @@ fslmc_vfio_process_group(void)
 				found_mportal = 1;
 			}
 
-			TAILQ_REMOVE(&rte_fslmc_bus.device_list, dev, next);
+			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
 			free(dev);
 			dev = NULL;
 			/* Ideally there is only a single dpmcp, but in case
@@ -1666,27 +1664,26 @@ fslmc_vfio_process_group(void)
 	 * other devices.
 	 */
 	current_device = 0;
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_fslmc_bus.device_list, next, dev_temp) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		if (dev->dev_type == DPAA2_DPRC) {
 			ret = fslmc_process_iodevices(dev);
 			if (ret) {
 				DPAA2_BUS_ERR("Unable to process dprc");
 				return ret;
 			}
-			TAILQ_REMOVE(&rte_fslmc_bus.device_list, dev, next);
+			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
 		}
 	}
 
 	current_device = 0;
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_fslmc_bus.device_list, next,
-		dev_temp) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		if (dev->dev_type == DPAA2_IO)
 			current_device++;
 		if (dev->device.devargs &&
 		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 				      dev->device.name);
-			TAILQ_REMOVE(&rte_fslmc_bus.device_list, dev, next);
+			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
 			continue;
 		}
 		if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
@@ -1694,7 +1691,7 @@ fslmc_vfio_process_group(void)
 		    dev->dev_type != DPAA2_CRYPTO &&
 		    dev->dev_type != DPAA2_QDMA &&
 		    dev->dev_type != DPAA2_IO) {
-			TAILQ_REMOVE(&rte_fslmc_bus.device_list, dev, next);
+			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
 			continue;
 		}
 		switch (dev->dev_type) {
@@ -1736,14 +1733,14 @@ fslmc_vfio_process_group(void)
 			if (!is_dpio_in_blocklist && dpio_count > 1) {
 				if (rte_eal_process_type() == RTE_PROC_SECONDARY
 				    && current_device != dpio_count) {
-					TAILQ_REMOVE(&rte_fslmc_bus.device_list,
-						     dev, next);
+					rte_bus_remove_device(&rte_fslmc_bus.bus,
+						     &dev->device);
 					break;
 				}
 				if (rte_eal_process_type() == RTE_PROC_PRIMARY
 				    && current_device == dpio_count) {
-					TAILQ_REMOVE(&rte_fslmc_bus.device_list,
-						     dev, next);
+					rte_bus_remove_device(&rte_fslmc_bus.bus,
+						     &dev->device);
 					break;
 				}
 			}
@@ -1761,7 +1758,7 @@ fslmc_vfio_process_group(void)
 			/* Unknown - ignore */
 			DPAA2_BUS_DEBUG("Found unknown device (%s)",
 					dev->device.name);
-			TAILQ_REMOVE(&rte_fslmc_bus.device_list, dev, next);
+			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
 			free(dev);
 			dev = NULL;
 		}
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
index a057cb1309..a66e55a456 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
@@ -28,7 +28,7 @@ rte_dpaa2_create_dprc_device(int vdev_fd __rte_unused,
 {
 	struct dpaa2_dprc_dev *dprc_node;
 	struct dprc_endpoint endpoint1, endpoint2;
-	struct rte_dpaa2_device *dev, *dev_tmp;
+	struct rte_dpaa2_device *dev;
 	int ret, dprc_id = obj->object_id;
 
 	/* Allocate DPAA2 dprc handle */
@@ -49,7 +49,7 @@ rte_dpaa2_create_dprc_device(int vdev_fd __rte_unused,
 		return ret;
 	}
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_fslmc_bus.device_list, next, dev_tmp) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
 		/** DPRC is always created before it's children are created.*/
 		dev->container = dprc_node;
 		if (dev->dev_type == DPAA2_ETH) {
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index 338f55b094..2fe592f24d 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -14,8 +14,6 @@
  */
 struct rte_fslmc_bus {
 	struct rte_bus bus;     /**< Generic Bus object */
-	TAILQ_HEAD(, rte_dpaa2_device) device_list;
-				/**< FSLMC DPAA2 Device list */
 	int device_count[DPAA2_DEVTYPE_MAX];
 				/**< Count of all devices scanned */
 };
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index 7d724dc1a0..c1ff38bdb2 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -67,7 +67,6 @@ struct rte_afu_shared {
  * A structure describing a AFU device.
  */
 struct rte_afu_device {
-	RTE_TAILQ_ENTRY(rte_afu_device) next;       /**< Next in device list. */
 	struct rte_device device;               /**< Inherit core device */
 	struct rte_rawdev *rawdev;    /**< Point Rawdev */
 	struct rte_afu_id id;                   /**< AFU id within FPGA. */
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index c038144ebd..4edff5efd4 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -38,9 +38,6 @@
  */
 static struct rte_bus rte_ifpga_bus;
 
-static TAILQ_HEAD(, rte_afu_device) ifpga_afu_dev_list =
-	TAILQ_HEAD_INITIALIZER(ifpga_afu_dev_list);
-
 /* register a ifpga bus based driver */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_register)
 void rte_ifpga_driver_register(struct rte_afu_driver *driver)
@@ -63,7 +60,7 @@ ifpga_find_afu_dev(const struct rte_rawdev *rdev,
 {
 	struct rte_afu_device *afu_dev = NULL;
 
-	TAILQ_FOREACH(afu_dev, &ifpga_afu_dev_list, next) {
+	RTE_BUS_FOREACH_DEV(afu_dev, &rte_ifpga_bus) {
 		if (afu_dev->rawdev == rdev &&
 			!ifpga_afu_id_cmp(&afu_dev->id, afu_id))
 			return afu_dev;
@@ -139,7 +136,6 @@ ifpga_scan_one(struct rte_rawdev *rawdev,
 	if (!afu_dev)
 		goto end;
 
-	afu_dev->device.bus = &rte_ifpga_bus;
 	afu_dev->device.devargs = devargs;
 	afu_dev->device.numa_node = SOCKET_ID_ANY;
 	afu_dev->device.name = devargs->name;
@@ -236,7 +232,7 @@ ifpga_scan(void)
 
 		afu_dev = ifpga_scan_one(rawdev, devargs);
 		if (afu_dev != NULL)
-			TAILQ_INSERT_TAIL(&ifpga_afu_dev_list, afu_dev, next);
+			rte_bus_add_device(&rte_ifpga_bus, &afu_dev->device);
 	}
 
 end:
@@ -333,7 +329,7 @@ ifpga_probe(void)
 	struct rte_afu_device *afu_dev = NULL;
 	int ret = 0;
 
-	TAILQ_FOREACH(afu_dev, &ifpga_afu_dev_list, next) {
+	RTE_BUS_FOREACH_DEV(afu_dev, &rte_ifpga_bus) {
 		ret = ifpga_probe_all_drivers(afu_dev);
 		if (ret == -EEXIST)
 			continue;
@@ -352,10 +348,10 @@ ifpga_probe(void)
 static int
 ifpga_cleanup(void)
 {
-	struct rte_afu_device *afu_dev, *tmp_dev;
+	struct rte_afu_device *afu_dev;
 	int error = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(afu_dev, &ifpga_afu_dev_list, next, tmp_dev) {
+	RTE_BUS_FOREACH_DEV(afu_dev, &rte_ifpga_bus) {
 		struct rte_afu_driver *drv = afu_dev->driver;
 		int ret = 0;
 
@@ -373,7 +369,7 @@ ifpga_cleanup(void)
 		afu_dev->device.driver = NULL;
 
 free:
-		TAILQ_REMOVE(&ifpga_afu_dev_list, afu_dev, next);
+		rte_bus_remove_device(&rte_ifpga_bus, &afu_dev->device);
 		rte_devargs_remove(afu_dev->device.devargs);
 		rte_intr_instance_free(afu_dev->intr_handle);
 		free(afu_dev);
@@ -398,7 +394,7 @@ ifpga_unplug(struct rte_device *dev)
 	if (ret)
 		return ret;
 
-	TAILQ_REMOVE(&ifpga_afu_dev_list, afu_dev, next);
+	rte_bus_remove_device(&rte_ifpga_bus, &afu_dev->device);
 
 	rte_devargs_remove(dev->devargs);
 	rte_intr_instance_free(afu_dev->intr_handle);
@@ -411,15 +407,15 @@ static struct rte_device *
 ifpga_find_device(const struct rte_device *start,
 	rte_dev_cmp_t cmp, const void *data)
 {
-	struct rte_afu_device *afu_dev;
+	struct rte_device *dev;
 
-	TAILQ_FOREACH(afu_dev, &ifpga_afu_dev_list, next) {
-		if (start && &afu_dev->device == start) {
+	TAILQ_FOREACH(dev, &rte_ifpga_bus.device_list, next) {
+		if (start && dev == start) {
 			start = NULL;
 			continue;
 		}
-		if (cmp(&afu_dev->device, data) == 0)
-			return &afu_dev->device;
+		if (cmp(dev, data) == 0)
+			return dev;
 	}
 
 	return NULL;
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index aba44492e0..78d14ab3ae 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -233,7 +233,6 @@ pci_scan_one(int dev_pci_fd, struct pci_conf *conf)
 
 	memset(pdev, 0, sizeof(*pdev));
 	dev = &pdev->device;
-	dev->device.bus = &rte_pci_bus.bus;
 
 	dev->addr.domain = conf->pc_sel.pc_domain;
 	dev->addr.bus = conf->pc_sel.pc_bus;
@@ -298,19 +297,20 @@ pci_scan_one(int dev_pci_fd, struct pci_conf *conf)
 	}
 
 	/* device is valid, add in list (sorted) */
-	if (TAILQ_EMPTY(&rte_pci_bus.device_list)) {
-		rte_pci_add_device(dev);
+	if (TAILQ_EMPTY(&rte_pci_bus.bus.device_list)) {
+		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
 	}
 	else {
 		struct rte_pci_device *dev2 = NULL;
 		int ret;
 
-		TAILQ_FOREACH(dev2, &rte_pci_bus.device_list, next) {
+		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus.bus) {
 			ret = rte_pci_addr_cmp(&dev->addr, &dev2->addr);
 			if (ret > 0)
 				continue;
 			else if (ret < 0) {
-				rte_pci_insert_device(dev2, dev);
+				rte_bus_insert_device(&rte_pci_bus.bus, &dev2->device,
+					&dev->device);
 			} else { /* already registered */
 				dev2->kdrv = dev->kdrv;
 				dev2->max_vfs = dev->max_vfs;
@@ -322,7 +322,7 @@ pci_scan_one(int dev_pci_fd, struct pci_conf *conf)
 			}
 			return 0;
 		}
-		rte_pci_add_device(dev);
+		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
 	}
 
 	return 0;
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index 993d690f96..b0e5428e64 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -33,7 +33,6 @@ enum rte_pci_kernel_driver {
  * A structure describing a PCI device.
  */
 struct rte_pci_device {
-	RTE_TAILQ_ENTRY(rte_pci_device) next;   /**< Next probed PCI device. */
 	struct rte_device device;           /**< Inherit core device */
 	struct rte_pci_addr addr;           /**< PCI location. */
 	struct rte_pci_id id;               /**< PCI ID. */
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 5f263f8b28..cf8a60313b 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -218,7 +218,6 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 
 	memset(pdev, 0, sizeof(*pdev));
 	dev = &pdev->device;
-	dev->device.bus = &rte_pci_bus.bus;
 	dev->addr = *addr;
 
 	/* get vendor id */
@@ -322,18 +321,19 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 		return 0;
 	}
 	/* device is valid, add in list (sorted) */
-	if (TAILQ_EMPTY(&rte_pci_bus.device_list)) {
-		rte_pci_add_device(dev);
+	if (TAILQ_EMPTY(&rte_pci_bus.bus.device_list)) {
+		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
 	} else {
 		struct rte_pci_device *dev2;
 
-		TAILQ_FOREACH(dev2, &rte_pci_bus.device_list, next) {
+		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus.bus) {
 			ret = rte_pci_addr_cmp(&dev->addr, &dev2->addr);
 			if (ret > 0)
 				continue;
 
 			if (ret < 0) {
-				rte_pci_insert_device(dev2, dev);
+				rte_bus_insert_device(&rte_pci_bus.bus, &dev2->device,
+					&dev->device);
 			} else { /* already registered */
 				if (!rte_dev_is_probed(&dev2->device)) {
 					dev2->kdrv = dev->kdrv;
@@ -377,7 +377,7 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 			return 0;
 		}
 
-		rte_pci_add_device(dev);
+		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
 	}
 
 	return 0;
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 79cc14a6dd..94dc63d865 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -383,7 +383,7 @@ pci_probe(void)
 	size_t probed = 0, failed = 0;
 	int ret = 0;
 
-	FOREACH_DEVICE_ON_PCIBUS(dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
 		probed++;
 
 		ret = pci_probe_all_drivers(dev);
@@ -405,10 +405,10 @@ pci_probe(void)
 static int
 pci_cleanup(void)
 {
-	struct rte_pci_device *dev, *tmp_dev;
+	struct rte_pci_device *dev;
 	int error = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_pci_bus.device_list, next, tmp_dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
 		struct rte_pci_driver *drv = dev->driver;
 		int ret = 0;
 
@@ -432,7 +432,7 @@ pci_cleanup(void)
 		rte_intr_instance_free(dev->vfio_req_intr_handle);
 		dev->vfio_req_intr_handle = NULL;
 
-		TAILQ_REMOVE(&rte_pci_bus.device_list, dev, next);
+		rte_bus_remove_device(&rte_pci_bus.bus, &dev->device);
 		pci_free(RTE_PCI_DEVICE_INTERNAL(dev));
 	}
 
@@ -466,7 +466,7 @@ rte_pci_dump(FILE *f)
 {
 	struct rte_pci_device *dev = NULL;
 
-	FOREACH_DEVICE_ON_PCIBUS(dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
 		pci_dump_one_device(f, dev);
 	}
 }
@@ -512,45 +512,21 @@ rte_pci_unregister(struct rte_pci_driver *driver)
 	rte_bus_remove_driver(&rte_pci_bus.bus, &driver->driver);
 }
 
-/* Add a device to PCI bus */
-void
-rte_pci_add_device(struct rte_pci_device *pci_dev)
-{
-	TAILQ_INSERT_TAIL(&rte_pci_bus.device_list, pci_dev, next);
-}
-
-/* Insert a device into a predefined position in PCI bus */
-void
-rte_pci_insert_device(struct rte_pci_device *exist_pci_dev,
-		      struct rte_pci_device *new_pci_dev)
-{
-	TAILQ_INSERT_BEFORE(exist_pci_dev, new_pci_dev, next);
-}
-
-/* Remove a device from PCI bus */
-static void
-rte_pci_remove_device(struct rte_pci_device *pci_dev)
-{
-	TAILQ_REMOVE(&rte_pci_bus.device_list, pci_dev, next);
-}
-
 static struct rte_device *
 pci_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 		const void *data)
 {
-	const struct rte_pci_device *pstart;
-	struct rte_pci_device *pdev;
+	struct rte_device *dev;
 
 	if (start != NULL) {
-		pstart = RTE_BUS_DEVICE(start, *pstart);
-		pdev = TAILQ_NEXT(pstart, next);
+		dev = TAILQ_NEXT(start, next);
 	} else {
-		pdev = TAILQ_FIRST(&rte_pci_bus.device_list);
+		dev = TAILQ_FIRST(&rte_pci_bus.bus.device_list);
 	}
-	while (pdev != NULL) {
-		if (cmp(&pdev->device, data) == 0)
-			return &pdev->device;
-		pdev = TAILQ_NEXT(pdev, next);
+	while (dev != NULL) {
+		if (cmp(dev, data) == 0)
+			return dev;
+		dev = TAILQ_NEXT(dev, next);
 	}
 	return NULL;
 }
@@ -569,7 +545,7 @@ pci_find_device_by_addr(const void *failure_addr)
 
 	check_point = (uint64_t)(uintptr_t)failure_addr;
 
-	FOREACH_DEVICE_ON_PCIBUS(pdev) {
+	RTE_BUS_FOREACH_DEV(pdev, &rte_pci_bus.bus) {
 		for (i = 0; i != RTE_DIM(pdev->mem_resource); i++) {
 			start = (uint64_t)(uintptr_t)pdev->mem_resource[i].addr;
 			len = pdev->mem_resource[i].len;
@@ -653,7 +629,7 @@ pci_unplug(struct rte_device *dev)
 
 	ret = rte_pci_detach_dev(pdev);
 	if (ret == 0) {
-		rte_pci_remove_device(pdev);
+		rte_bus_remove_device(&rte_pci_bus.bus, &pdev->device);
 		rte_devargs_remove(dev->devargs);
 		pci_free(RTE_PCI_DEVICE_INTERNAL(pdev));
 	}
@@ -708,7 +684,7 @@ rte_pci_get_iommu_class(void)
 	bool devices_want_pa = false;
 	int iommu_no_va = -1;
 
-	FOREACH_DEVICE_ON_PCIBUS(dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
 		/*
 		 * We can check this only once, because the IOMMU hardware is
 		 * the same for all of them.
@@ -916,7 +892,6 @@ struct rte_pci_bus rte_pci_bus = {
 		.hot_unplug_handler = pci_hot_unplug_handler,
 		.sigbus_handler = pci_sigbus_handler,
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(rte_pci_bus.device_list),
 };
 
 RTE_REGISTER_BUS(pci, rte_pci_bus.bus);
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index 8b5f563dc3..52fa6b0f76 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -34,15 +34,10 @@ extern int pci_bus_logtype;
  */
 struct rte_pci_bus {
 	struct rte_bus bus;               /**< Inherit the generic class */
-	RTE_TAILQ_HEAD(, rte_pci_device) device_list; /**< List of PCI devices */
 };
 
 extern struct rte_pci_bus rte_pci_bus;
 
-/* PCI Bus iterators */
-#define FOREACH_DEVICE_ON_PCIBUS(p)	\
-	RTE_TAILQ_FOREACH(p, &(rte_pci_bus.device_list), next)
-
 struct rte_pci_driver;
 struct rte_pci_device;
 
@@ -78,31 +73,6 @@ pci_common_set(struct rte_pci_device *dev);
 void
 pci_free(struct rte_pci_device_internal *pdev);
 
-/**
- * Add a PCI device to the PCI Bus (append to PCI Device list). This function
- * also updates the bus references of the PCI Device (and the generic device
- * object embedded within.
- *
- * @param pci_dev
- *	PCI device to add
- * @return void
- */
-void rte_pci_add_device(struct rte_pci_device *pci_dev);
-
-/**
- * Insert a PCI device in the PCI Bus at a particular location in the device
- * list. It also updates the PCI Bus reference of the new devices to be
- * inserted.
- *
- * @param exist_pci_dev
- *	Existing PCI device in PCI Bus
- * @param new_pci_dev
- *	PCI device to be added before exist_pci_dev
- * @return void
- */
-void rte_pci_insert_device(struct rte_pci_device *exist_pci_dev,
-		struct rte_pci_device *new_pci_dev);
-
 /**
  * A structure describing a PCI mapping.
  */
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 549319ad5b..3b3f97da27 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -415,7 +415,6 @@ pci_scan_one(HDEVINFO dev_info, PSP_DEVINFO_DATA device_info_data)
 	memset(pdev, 0, sizeof(*pdev));
 	dev = &pdev->device;
 
-	dev->device.bus = &rte_pci_bus.bus;
 	dev->addr = addr;
 	dev->id = pci_id;
 	dev->max_vfs = 0; /* TODO: get max_vfs */
@@ -431,17 +430,18 @@ pci_scan_one(HDEVINFO dev_info, PSP_DEVINFO_DATA device_info_data)
 	}
 
 	/* device is valid, add in list (sorted) */
-	if (TAILQ_EMPTY(&rte_pci_bus.device_list)) {
-		rte_pci_add_device(dev);
+	if (TAILQ_EMPTY(&rte_pci_bus.bus.device_list)) {
+		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
 	} else {
 		struct rte_pci_device *dev2 = NULL;
 
-		TAILQ_FOREACH(dev2, &rte_pci_bus.device_list, next) {
+		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus.bus) {
 			ret = rte_pci_addr_cmp(&dev->addr, &dev2->addr);
 			if (ret > 0) {
 				continue;
 			} else if (ret < 0) {
-				rte_pci_insert_device(dev2, dev);
+				rte_bus_insert_device(&rte_pci_bus.bus, &dev2->device,
+					&dev->device);
 			} else { /* already registered */
 				dev2->kdrv = dev->kdrv;
 				dev2->max_vfs = dev->max_vfs;
@@ -451,7 +451,7 @@ pci_scan_one(HDEVINFO dev_info, PSP_DEVINFO_DATA device_info_data)
 			}
 			return 0;
 		}
-		rte_pci_add_device(dev);
+		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
 	}
 
 	return 0;
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index a72d5c00a3..3912ed5b85 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -94,7 +94,6 @@ struct rte_platform_resource {
  * A structure describing a platform device.
  */
 struct rte_platform_device {
-	RTE_TAILQ_ENTRY(rte_platform_device) next; /**< Next attached platform device */
 	struct rte_device device; /**< Core device */
 	struct rte_platform_driver *driver; /**< Matching device driver */
 	char name[RTE_DEV_NAME_MAX_LEN]; /**< Device name */
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 9d3c4877b0..0c23e5d9b6 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -57,11 +57,10 @@ dev_add(const char *dev_name)
 	rte_strscpy(pdev->name, dev_name, sizeof(pdev->name));
 	pdev->device.name = pdev->name;
 	pdev->device.devargs = rte_bus_find_devargs(&platform_bus.bus, dev_name);
-	pdev->device.bus = &platform_bus.bus;
 	snprintf(path, sizeof(path), PLATFORM_BUS_DEVICES_PATH "/%s/numa_node", dev_name);
 	pdev->device.numa_node = eal_parse_sysfs_value(path, &val) ? rte_socket_id() : val;
 
-	FOREACH_DEVICE_ON_PLATFORM_BUS(tmp) {
+	RTE_BUS_FOREACH_DEV(tmp, &platform_bus.bus) {
 		if (!strcmp(tmp->name, pdev->name)) {
 			PLATFORM_LOG_LINE(INFO, "device %s already added", pdev->name);
 
@@ -73,7 +72,7 @@ dev_add(const char *dev_name)
 		}
 	}
 
-	TAILQ_INSERT_HEAD(&platform_bus.device_list, pdev, next);
+	rte_bus_add_device(&platform_bus.bus, &pdev->device);
 
 	PLATFORM_LOG_LINE(INFO, "adding device %s to the list", dev_name);
 
@@ -425,7 +424,7 @@ platform_bus_probe(void)
 	struct rte_platform_device *pdev;
 	int ret;
 
-	FOREACH_DEVICE_ON_PLATFORM_BUS(pdev) {
+	RTE_BUS_FOREACH_DEV(pdev, &platform_bus.bus) {
 		ret = device_attach(pdev);
 		if (ret == -EBUSY) {
 			PLATFORM_LOG_LINE(DEBUG, "device %s already probed", pdev->name);
@@ -441,20 +440,18 @@ platform_bus_probe(void)
 static struct rte_device *
 platform_bus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp, const void *data)
 {
-	const struct rte_platform_device *pstart;
-	struct rte_platform_device *pdev;
+	struct rte_device *dev;
 
 	if (start != NULL) {
-		pstart = RTE_BUS_DEVICE(start, *pstart);
-		pdev = TAILQ_NEXT(pstart, next);
+		dev = TAILQ_NEXT(start, next);
 	} else {
-		pdev = RTE_TAILQ_FIRST(&platform_bus.device_list);
+		dev = RTE_TAILQ_FIRST(&platform_bus.bus.device_list);
 	}
-	while (pdev) {
-		if (cmp(&pdev->device, data) == 0)
-			return &pdev->device;
+	while (dev) {
+		if (cmp(dev, data) == 0)
+			return dev;
 
-		pdev = RTE_TAILQ_NEXT(pdev, next);
+		dev = RTE_TAILQ_NEXT(dev, next);
 	}
 
 	return NULL;
@@ -550,7 +547,7 @@ platform_bus_get_iommu_class(void)
 	struct rte_platform_driver *pdrv;
 	struct rte_platform_device *pdev;
 
-	FOREACH_DEVICE_ON_PLATFORM_BUS(pdev) {
+	RTE_BUS_FOREACH_DEV(pdev, &platform_bus.bus) {
 		pdrv = pdev->driver;
 		if (pdrv != NULL && pdrv->drv_flags & RTE_PLATFORM_DRV_NEED_IOVA_AS_VA)
 			return RTE_IOVA_VA;
@@ -562,10 +559,10 @@ platform_bus_get_iommu_class(void)
 static int
 platform_bus_cleanup(void)
 {
-	struct rte_platform_device *pdev, *tmp;
+	struct rte_platform_device *pdev;
 
-	RTE_TAILQ_FOREACH_SAFE(pdev, &platform_bus.device_list, next, tmp) {
-		TAILQ_REMOVE(&platform_bus.device_list, pdev, next);
+	RTE_BUS_FOREACH_DEV(pdev, &platform_bus.bus) {
+		rte_bus_remove_device(&platform_bus.bus, &pdev->device);
 		if (!rte_dev_is_probed(&pdev->device))
 			continue;
 		platform_bus_unplug(&pdev->device);
@@ -588,7 +585,6 @@ struct rte_platform_bus platform_bus = {
 		.dev_iterate = platform_bus_dev_iterate,
 		.cleanup = platform_bus_cleanup,
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(platform_bus.device_list),
 };
 
 RTE_REGISTER_BUS(platform, platform_bus.bus);
diff --git a/drivers/bus/platform/private.h b/drivers/bus/platform/private.h
index f7ee80f3ac..81a8984052 100644
--- a/drivers/bus/platform/private.h
+++ b/drivers/bus/platform/private.h
@@ -16,16 +16,11 @@
 
 extern struct rte_platform_bus platform_bus;
 
-/* Platform bus iterators. */
-#define FOREACH_DEVICE_ON_PLATFORM_BUS(p) \
-	RTE_TAILQ_FOREACH(p, &(platform_bus.device_list), next)
-
 /*
  * Structure describing platform bus.
  */
 struct rte_platform_bus {
 	struct rte_bus bus; /* Core bus */
-	RTE_TAILQ_HEAD(, rte_platform_device) device_list; /* List of bus devices */
 };
 
 extern int platform_bus_logtype;
diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index 051e1736cf..04ced912c9 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -43,7 +43,6 @@ struct rte_uacce_driver;
  * A structure describing a UACCE device.
  */
 struct rte_uacce_device {
-	RTE_TAILQ_ENTRY(rte_uacce_device) next;  /**< Next in device list. */
 	struct rte_device device;                /**< Inherit core device. */
 	struct rte_uacce_driver *driver;         /**< Driver used in probing. */
 	char name[RTE_DEV_NAME_MAX_LEN];         /**< Device name. */
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index c0a1e1d8ec..199517442d 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -39,7 +39,6 @@
  */
 struct rte_uacce_bus {
 	struct rte_bus bus;		            /* Inherit the generic class. */
-	TAILQ_HEAD(, rte_uacce_device) device_list; /* List of devices. */
 };
 
 /* Forward declaration of UACCE bus. */
@@ -54,9 +53,6 @@ static const char *const uacce_params_keys[] = {
 	NULL,
 };
 
-#define FOREACH_DEVICE_ON_UACCEBUS(p)	\
-		RTE_TAILQ_FOREACH(p, &uacce_bus.device_list, next)
-
 extern int uacce_bus_logtype;
 #define RTE_LOGTYPE_UACCE_BUS uacce_bus_logtype
 #define UACCE_BUS_LOG(level, ...) \
@@ -217,7 +213,6 @@ uacce_scan_one(const char *dev_name)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->device.bus = &uacce_bus.bus;
 	dev->device.name = dev->name;
 	dev->device.devargs = rte_bus_find_devargs(&uacce_bus.bus, dev_name);
 	snprintf(dev->name, sizeof(dev->name), "%s", dev_name);
@@ -243,7 +238,7 @@ uacce_scan_one(const char *dev_name)
 	if (ret != 0)
 		goto err;
 
-	TAILQ_INSERT_TAIL(&uacce_bus.device_list, dev, next);
+	rte_bus_add_device(&uacce_bus.bus, &dev->device);
 	return 0;
 
 err:
@@ -425,7 +420,7 @@ uacce_probe(void)
 	struct rte_uacce_device *dev;
 	int ret;
 
-	FOREACH_DEVICE_ON_UACCEBUS(dev) {
+	RTE_BUS_FOREACH_DEV(dev, &uacce_bus.bus) {
 		probed++;
 
 		ret = uacce_probe_all_drivers(dev);
@@ -443,10 +438,10 @@ uacce_probe(void)
 static int
 uacce_cleanup(void)
 {
-	struct rte_uacce_device *dev, *tmp_dev;
+	struct rte_uacce_device *dev;
 	int error = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &uacce_bus.device_list, next, tmp_dev) {
+	RTE_BUS_FOREACH_DEV(dev, &uacce_bus.bus) {
 		struct rte_uacce_driver *dr = dev->driver;
 		int ret = 0;
 
@@ -464,7 +459,7 @@ uacce_cleanup(void)
 		dev->device.driver = NULL;
 
 free:
-		TAILQ_REMOVE(&uacce_bus.device_list, dev, next);
+		rte_bus_remove_device(&uacce_bus.bus, &dev->device);
 		free(dev);
 	}
 
@@ -505,7 +500,7 @@ uacce_unplug(struct rte_device *dev)
 
 	ret = uacce_detach_dev(uacce_dev);
 	if (ret == 0) {
-		TAILQ_REMOVE(&uacce_bus.device_list, uacce_dev, next);
+		rte_bus_remove_device(&uacce_bus.bus, &uacce_dev->device);
 		rte_devargs_remove(dev->devargs);
 		free(uacce_dev);
 	}
@@ -516,20 +511,18 @@ uacce_unplug(struct rte_device *dev)
 static struct rte_device *
 uacce_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,  const void *data)
 {
-	const struct rte_uacce_device *uacce_start;
-	struct rte_uacce_device *uacce_dev;
+	struct rte_device *dev;
 
 	if (start != NULL) {
-		uacce_start = RTE_BUS_DEVICE(start, *uacce_start);
-		uacce_dev = TAILQ_NEXT(uacce_start, next);
+		dev = TAILQ_NEXT(start, next);
 	} else {
-		uacce_dev = TAILQ_FIRST(&uacce_bus.device_list);
+		dev = TAILQ_FIRST(&uacce_bus.bus.device_list);
 	}
 
-	while (uacce_dev != NULL) {
-		if (cmp(&uacce_dev->device, data) == 0)
-			return &uacce_dev->device;
-		uacce_dev = TAILQ_NEXT(uacce_dev, next);
+	while (dev != NULL) {
+		if (cmp(dev, data) == 0)
+			return dev;
+		dev = TAILQ_NEXT(dev, next);
 	}
 
 	return NULL;
@@ -707,7 +700,6 @@ static struct rte_uacce_bus uacce_bus = {
 		.parse = uacce_parse,
 		.dev_iterate = uacce_dev_iterate,
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(uacce_bus.device_list),
 };
 
 RTE_REGISTER_BUS(uacce, uacce_bus.bus);
diff --git a/drivers/bus/vdev/bus_vdev_driver.h b/drivers/bus/vdev/bus_vdev_driver.h
index eceaa56696..8d114e4b3b 100644
--- a/drivers/bus/vdev/bus_vdev_driver.h
+++ b/drivers/bus/vdev/bus_vdev_driver.h
@@ -16,7 +16,6 @@ extern "C" {
 #endif
 
 struct rte_vdev_device {
-	RTE_TAILQ_ENTRY(rte_vdev_device) next;      /**< Next attached vdev */
 	struct rte_device device;               /**< Inherit core device */
 };
 
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index c360c38ed5..db73b08c38 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -31,9 +31,6 @@
 /* Forward declare to access virtual bus name */
 static struct rte_bus rte_vdev_bus;
 
-
-static TAILQ_HEAD(, rte_vdev_device) vdev_device_list =
-	TAILQ_HEAD_INITIALIZER(vdev_device_list);
 /* The lock needs to be recursive because a vdev can manage another vdev. */
 static rte_spinlock_recursive_t vdev_device_list_lock =
 	RTE_SPINLOCK_RECURSIVE_INITIALIZER;
@@ -198,7 +195,7 @@ find_vdev(const char *name)
 	if (!name)
 		return NULL;
 
-	TAILQ_FOREACH(dev, &vdev_device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
 		const char *devname = rte_vdev_device_name(dev);
 
 		if (!strcmp(devname, name))
@@ -262,7 +259,6 @@ insert_vdev(const char *name, const char *args,
 		goto fail;
 	}
 
-	dev->device.bus = &rte_vdev_bus;
 	dev->device.numa_node = SOCKET_ID_ANY;
 
 	if (find_vdev(name)) {
@@ -279,7 +275,7 @@ insert_vdev(const char *name, const char *args,
 		rte_devargs_insert(&devargs);
 	dev->device.devargs = devargs;
 	dev->device.name = devargs->name;
-	TAILQ_INSERT_TAIL(&vdev_device_list, dev, next);
+	rte_bus_add_device(&rte_vdev_bus, &dev->device);
 
 	if (p_dev)
 		*p_dev = dev;
@@ -307,7 +303,7 @@ rte_vdev_init(const char *name, const char *args)
 			if (ret > 0)
 				VDEV_LOG(ERR, "no driver found for %s", name);
 			/* If fails, remove it from vdev list */
-			TAILQ_REMOVE(&vdev_device_list, dev, next);
+			rte_bus_remove_device(&rte_vdev_bus, &dev->device);
 			rte_devargs_remove(dev->device.devargs);
 			free(dev);
 		}
@@ -354,7 +350,7 @@ rte_vdev_uninit(const char *name)
 	if (ret)
 		goto unlock;
 
-	TAILQ_REMOVE(&vdev_device_list, dev, next);
+	rte_bus_remove_device(&rte_vdev_bus, &dev->device);
 	rte_devargs_remove(dev->device.devargs);
 	free(dev);
 
@@ -405,7 +401,7 @@ vdev_action(const struct rte_mp_msg *mp_msg, const void *peer)
 		num = 0;
 
 		rte_spinlock_recursive_lock(&vdev_device_list_lock);
-		TAILQ_FOREACH(dev, &vdev_device_list, next) {
+		RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
 			devname = rte_vdev_device_name(dev);
 			if (strlen(devname) == 0) {
 				VDEV_LOG(INFO, "vdev with no name is not sent");
@@ -511,12 +507,11 @@ vdev_scan(void)
 			continue;
 		}
 
-		dev->device.bus = &rte_vdev_bus;
 		dev->device.devargs = devargs;
 		dev->device.numa_node = SOCKET_ID_ANY;
 		dev->device.name = devargs->name;
 
-		TAILQ_INSERT_TAIL(&vdev_device_list, dev, next);
+		rte_bus_add_device(&rte_vdev_bus, &dev->device);
 
 		rte_spinlock_recursive_unlock(&vdev_device_list_lock);
 	}
@@ -531,7 +526,7 @@ vdev_probe(void)
 	int r, ret = 0;
 
 	/* call the init function for each virtual device */
-	TAILQ_FOREACH(dev, &vdev_device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
 		/* we don't use the vdev lock here, as it's only used in DPDK
 		 * initialization; and we don't want to hold such a lock when
 		 * we call each driver probe.
@@ -553,10 +548,10 @@ vdev_probe(void)
 static int
 vdev_cleanup(void)
 {
-	struct rte_vdev_device *dev, *tmp_dev;
+	struct rte_vdev_device *dev;
 	int error = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &vdev_device_list, next, tmp_dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
 		const struct rte_vdev_driver *drv;
 		int ret;
 
@@ -574,7 +569,7 @@ vdev_cleanup(void)
 
 		dev->device.driver = NULL;
 free:
-		TAILQ_REMOVE(&vdev_device_list, dev, next);
+		rte_bus_remove_device(&rte_vdev_bus, &dev->device);
 		free(dev);
 	}
 
@@ -585,24 +580,22 @@ struct rte_device *
 rte_vdev_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 		     const void *data)
 {
-	const struct rte_vdev_device *vstart;
-	struct rte_vdev_device *dev;
+	struct rte_device *dev;
 
 	rte_spinlock_recursive_lock(&vdev_device_list_lock);
-	if (start != NULL) {
-		vstart = RTE_BUS_DEVICE(start, *vstart);
-		dev = TAILQ_NEXT(vstart, next);
-	} else {
-		dev = TAILQ_FIRST(&vdev_device_list);
-	}
+	if (start != NULL)
+		dev = TAILQ_NEXT(start, next);
+	else
+		dev = TAILQ_FIRST(&rte_vdev_bus.device_list);
+
 	while (dev != NULL) {
-		if (cmp(&dev->device, data) == 0)
+		if (cmp(dev, data) == 0)
 			break;
 		dev = TAILQ_NEXT(dev, next);
 	}
 	rte_spinlock_recursive_unlock(&vdev_device_list_lock);
 
-	return dev ? &dev->device : NULL;
+	return dev;
 }
 
 static int
@@ -624,7 +617,7 @@ vdev_get_iommu_class(void)
 	struct rte_vdev_device *dev;
 	struct rte_vdev_driver *driver;
 
-	TAILQ_FOREACH(dev, &vdev_device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_vdev_bus) {
 		name = rte_vdev_device_name(dev);
 		if (vdev_parse(name, &driver))
 			continue;
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index 4a06ff8e66..d53bda2340 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -37,7 +37,6 @@ enum hv_uio_map {
  * A structure describing a VMBUS device.
  */
 struct rte_vmbus_device {
-	RTE_TAILQ_ENTRY(rte_vmbus_device) next; /**< Next probed VMBUS device */
 	const struct rte_vmbus_driver *driver; /**< Associated driver */
 	struct rte_device device;              /**< Inherit core device */
 	rte_uuid_t device_id;		       /**< VMBUS device id */
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 5958b97077..6268a14d40 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -288,7 +288,6 @@ vmbus_scan_one(const char *name)
 	if (dev == NULL)
 		return -1;
 
-	dev->device.bus = &rte_vmbus_bus.bus;
 	dev->device.name = dev_name = strdup(name);
 	if (!dev->device.name)
 		goto error;
@@ -357,7 +356,7 @@ vmbus_scan_one(const char *name)
 	/* device is valid, add in list (sorted) */
 	VMBUS_LOG(DEBUG, "Adding vmbus device %s", name);
 
-	TAILQ_FOREACH(dev2, &rte_vmbus_bus.device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev2, &rte_vmbus_bus.bus) {
 		int ret;
 
 		ret = rte_uuid_compare(dev->device_id, dev2->device_id);
@@ -365,7 +364,7 @@ vmbus_scan_one(const char *name)
 			continue;
 
 		if (ret < 0) {
-			vmbus_insert_device(dev2, dev);
+			rte_bus_insert_device(&rte_vmbus_bus.bus, &dev2->device, &dev->device);
 		} else { /* already registered */
 			VMBUS_LOG(NOTICE,
 				"%s already registered", name);
@@ -375,7 +374,7 @@ vmbus_scan_one(const char *name)
 		return 0;
 	}
 
-	vmbus_add_device(dev);
+	rte_bus_add_device(&rte_vmbus_bus.bus, &dev->device);
 	return 0;
 error:
 	VMBUS_LOG(DEBUG, "failed");
diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index bd1151385c..6abb97c607 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -20,15 +20,10 @@
  */
 struct rte_vmbus_bus {
 	struct rte_bus bus;               /**< Inherit the generic class */
-	RTE_TAILQ_HEAD(, rte_vmbus_device) device_list; /**< List of devices */
 };
 
 extern struct rte_vmbus_bus rte_vmbus_bus;
 
-/* VMBus iterators */
-#define FOREACH_DEVICE_ON_VMBUS(p)	\
-	RTE_TAILQ_FOREACH(p, &(rte_vmbus_bus.device_list), next)
-
 extern int vmbus_logtype_bus;
 #define RTE_LOGTYPE_VMBUS_BUS vmbus_logtype_bus
 #define VMBUS_LOG(level, ...) \
@@ -98,11 +93,6 @@ int vmbus_chan_create(const struct rte_vmbus_device *device,
 		      uint16_t relid, uint16_t subid, uint8_t monitor_id,
 		      struct vmbus_channel **new_chan);
 
-void vmbus_add_device(struct rte_vmbus_device *vmbus_dev);
-void vmbus_insert_device(struct rte_vmbus_device *exist_vmbus_dev,
-			 struct rte_vmbus_device *new_vmbus_dev);
-void vmbus_remove_device(struct rte_vmbus_device *vmbus_device);
-
 void vmbus_uio_irq_control(const struct rte_vmbus_device *dev, int32_t onoff);
 int vmbus_uio_irq_read(struct rte_vmbus_device *dev);
 
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index a414f0a892..889b9347d7 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -181,7 +181,7 @@ rte_vmbus_probe(void)
 	size_t probed = 0, failed = 0;
 	char ubuf[RTE_UUID_STRLEN];
 
-	FOREACH_DEVICE_ON_VMBUS(dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_vmbus_bus.bus) {
 		probed++;
 
 		rte_uuid_unparse(dev->device_id, ubuf, sizeof(ubuf));
@@ -203,10 +203,10 @@ rte_vmbus_probe(void)
 static int
 rte_vmbus_cleanup(void)
 {
-	struct rte_vmbus_device *dev, *tmp_dev;
+	struct rte_vmbus_device *dev;
 	int error = 0;
 
-	RTE_TAILQ_FOREACH_SAFE(dev, &rte_vmbus_bus.device_list, next, tmp_dev) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_vmbus_bus.bus) {
 		const struct rte_vmbus_driver *drv = dev->driver;
 		int ret;
 
@@ -223,7 +223,7 @@ rte_vmbus_cleanup(void)
 
 		dev->driver = NULL;
 		dev->device.driver = NULL;
-		TAILQ_REMOVE(&rte_vmbus_bus.device_list, dev, next);
+		rte_bus_remove_device(&rte_vmbus_bus.bus, &dev->device);
 		free(dev);
 	}
 
@@ -274,42 +274,20 @@ rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 	rte_bus_remove_driver(&rte_vmbus_bus.bus, &driver->driver);
 }
 
-/* Add a device to VMBUS bus */
-void
-vmbus_add_device(struct rte_vmbus_device *vmbus_dev)
-{
-	TAILQ_INSERT_TAIL(&rte_vmbus_bus.device_list, vmbus_dev, next);
-}
-
-/* Insert a device into a predefined position in VMBUS bus */
-void
-vmbus_insert_device(struct rte_vmbus_device *exist_vmbus_dev,
-		      struct rte_vmbus_device *new_vmbus_dev)
-{
-	TAILQ_INSERT_BEFORE(exist_vmbus_dev, new_vmbus_dev, next);
-}
-
-/* Remove a device from VMBUS bus */
-void
-vmbus_remove_device(struct rte_vmbus_device *vmbus_dev)
-{
-	TAILQ_REMOVE(&rte_vmbus_bus.device_list, vmbus_dev, next);
-}
-
 /* VMBUS doesn't support hotplug */
 static struct rte_device *
 vmbus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 		  const void *data)
 {
-	struct rte_vmbus_device *dev;
+	struct rte_device *dev;
 
-	FOREACH_DEVICE_ON_VMBUS(dev) {
-		if (start && &dev->device == start) {
+	TAILQ_FOREACH(dev, &rte_vmbus_bus.bus.device_list, next) {
+		if (start && dev == start) {
 			start = NULL;
 			continue;
 		}
-		if (cmp(&dev->device, data) == 0)
-			return &dev->device;
+		if (cmp(dev, data) == 0)
+			return dev;
 	}
 
 	return NULL;
@@ -325,7 +303,6 @@ struct rte_vmbus_bus rte_vmbus_bus = {
 		.parse = vmbus_parse,
 		.dev_compare = vmbus_dev_compare,
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(rte_vmbus_bus.device_list),
 };
 
 RTE_REGISTER_BUS(vmbus, rte_vmbus_bus.bus);
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 7f4920b274..b3e691a2bd 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -49,16 +49,12 @@ static struct rte_device *dsa_find_device(const struct rte_device *start,
 static enum rte_iova_mode dsa_get_iommu_class(void);
 static int dsa_addr_parse(const char *name, void *addr);
 
-/** List of devices */
-TAILQ_HEAD(dsa_device_list, rte_dsa_device);
-
 /**
  * Structure describing the DSA bus
  */
 struct dsa_bus {
 	struct rte_bus bus;               /**< Inherit the generic class */
 	struct rte_driver driver;         /**< Driver struct for devices to point to */
-	struct dsa_device_list device_list;  /**< List of PCI devices */
 };
 
 struct dsa_bus dsa_bus = {
@@ -72,7 +68,6 @@ struct dsa_bus dsa_bus = {
 	.driver = {
 		.name = "dmadev_idxd",
 	},
-	.device_list = TAILQ_HEAD_INITIALIZER(dsa_bus.device_list),
 };
 
 static inline const char *
@@ -274,7 +269,7 @@ dsa_probe(void)
 {
 	struct rte_dsa_device *dev;
 
-	TAILQ_FOREACH(dev, &dsa_bus.device_list, next) {
+	RTE_BUS_FOREACH_DEV(dev, &dsa_bus.bus) {
 		char type[64], name[64];
 
 		if (read_wq_string(dev, "type", type, sizeof(type)) < 0 ||
@@ -332,9 +327,8 @@ dsa_scan(void)
 			free(dev);
 			continue;
 		}
-		dev->device.bus = &dsa_bus.bus;
 		strlcpy(dev->wq_name, wq->d_name, sizeof(dev->wq_name));
-		TAILQ_INSERT_TAIL(&dsa_bus.device_list, dev, next);
+		rte_bus_add_device(&dsa_bus.bus, &dev->device);
 		devcount++;
 
 		read_device_int(dev, "numa_node", &numa_node);
@@ -350,16 +344,13 @@ static struct rte_device *
 dsa_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 			 const void *data)
 {
-	struct rte_dsa_device *dev = TAILQ_FIRST(&dsa_bus.device_list);
-
-	/* the rte_device struct must be at start of dsa structure */
-	RTE_BUILD_BUG_ON(offsetof(struct rte_dsa_device, device) != 0);
+	struct rte_device *dev = TAILQ_FIRST(&dsa_bus.bus.device_list);
 
 	if (start != NULL) /* jump to start point if given */
-		dev = TAILQ_NEXT((const struct rte_dsa_device *)start, next);
+		dev = TAILQ_NEXT(start, next);
 	while (dev != NULL) {
-		if (cmp(&dev->device, data) == 0)
-			return &dev->device;
+		if (cmp(dev, data) == 0)
+			return dev;
 		dev = TAILQ_NEXT(dev, next);
 	}
 	return NULL;
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index e155936014..2748e99826 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -38,6 +38,7 @@ rte_bus_register(struct rte_bus *bus)
 	/* Buses supporting driver plug also require unplug. */
 	RTE_VERIFY(!bus->plug || bus->unplug);
 
+	TAILQ_INIT(&bus->device_list);
 	TAILQ_INIT(&bus->driver_list);
 	TAILQ_INSERT_TAIL(&rte_bus_list, bus, next);
 	EAL_LOG(DEBUG, "Registered [%s] bus.", rte_bus_name(bus));
@@ -371,6 +372,32 @@ rte_bus_sigbus_handler(const void *failure_addr)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_add_device)
+void
+rte_bus_add_device(struct rte_bus *bus, struct rte_device *dev)
+{
+	TAILQ_INSERT_TAIL(&bus->device_list, dev, next);
+	dev->bus = bus;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_remove_device)
+void
+rte_bus_remove_device(struct rte_bus *bus, struct rte_device *dev)
+{
+	TAILQ_REMOVE(&bus->device_list, dev, next);
+	dev->bus = NULL;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_insert_device)
+void
+rte_bus_insert_device(struct rte_bus *bus,
+		      struct rte_device *exist_dev,
+		      struct rte_device *new_dev)
+{
+	TAILQ_INSERT_BEFORE(exist_dev, new_dev, next);
+	new_dev->bus = bus;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_add_driver)
 void
 rte_bus_add_driver(struct rte_bus *bus, struct rte_driver *driver)
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 3c8f661a17..5b40fcd606 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -286,6 +286,7 @@ struct rte_bus {
 	rte_bus_sigbus_handler_t sigbus_handler;
 					/**< handle sigbus error on the bus */
 	rte_bus_cleanup_t cleanup;   /**< Cleanup devices on bus */
+	RTE_TAILQ_HEAD(, rte_device) device_list; /**< List of devices on the bus */
 	RTE_TAILQ_HEAD(, rte_driver) driver_list; /**< List of drivers on the bus */
 };
 
@@ -371,6 +372,64 @@ void rte_bus_unregister(struct rte_bus *bus);
 #define RTE_BUS_DRIVER(drv, bus_drv_type) \
 	container_of(drv, typeof(bus_drv_type), driver)
 
+/**
+ * Helper macro to iterate over all devices on a bus.
+ *
+ * @param dev
+ *   Variable name for the bus-specific device pointer.
+ * @param bus
+ *   Pointer to the bus structure.
+ *
+ * Example:
+ *   struct rte_pci_device *pci_dev;
+ *   RTE_BUS_FOREACH_DEV(pci_dev, &pci_bus.bus) {
+ *       // Use pci_dev here
+ *   }
+ */
+#define RTE_BUS_FOREACH_DEV(dev, bus) \
+	for (struct rte_device *__rte_dev = TAILQ_FIRST(&(bus)->device_list), *__rte_dev_tmp; \
+			(__rte_dev != NULL && ((dev) = RTE_BUS_DEVICE(__rte_dev, *dev), \
+				__rte_dev_tmp = TAILQ_NEXT(__rte_dev, next), 1)) || \
+			(dev = NULL, 0); \
+			__rte_dev = __rte_dev_tmp)
+
+/**
+ * Add a device to the bus device list.
+ *
+ * @param bus
+ *   A pointer to a rte_bus structure.
+ * @param dev
+ *   A pointer to a rte_device structure to add.
+ */
+__rte_internal
+void rte_bus_add_device(struct rte_bus *bus, struct rte_device *dev);
+
+/**
+ * Remove a device from the bus device list.
+ *
+ * @param bus
+ *   A pointer to a rte_bus structure.
+ * @param dev
+ *   A pointer to a rte_device structure to remove.
+ */
+__rte_internal
+void rte_bus_remove_device(struct rte_bus *bus, struct rte_device *dev);
+
+/**
+ * Insert a device before another in the bus device list.
+ *
+ * @param bus
+ *   A pointer to a rte_bus structure.
+ * @param exist_dev
+ *   Existing device in the list.
+ * @param new_dev
+ *   New device to insert before exist_dev.
+ */
+__rte_internal
+void rte_bus_insert_device(struct rte_bus *bus,
+			   struct rte_device *exist_dev,
+			   struct rte_device *new_dev);
+
 /**
  * Helper macro to iterate over all drivers on a bus.
  *
-- 
2.53.0

