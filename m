Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDA9CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E992140B98;
	Wed,  6 May 2026 17:54:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 57FB040A67
 for <dev@dpdk.org>; Wed,  6 May 2026 17:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778082888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJIZ9GZzgO4MHfVj9TdTNsHsn6PT436WT5XuvTnRjro=;
 b=QkNVySEhcfLqB6iISOuhp4gbvIcMGlcMGr+Uc87e6U/qwR53aEc201Oqwx1vetjJCBeMy4
 Ud+78CzPEieVZMtWvCUxS9AtgaoPsIQvwJoI91y84FhFa8gfE8AhQfB3hRxgvAQnlrM5oA
 fvI5c4bsjK4bJewt1+0v5tNI8q5jqFQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-3MJuVZ__Ph-va2lLFSafPw-1; Wed,
 06 May 2026 11:54:46 -0400
X-MC-Unique: 3MJuVZ__Ph-va2lLFSafPw-1
X-Mimecast-MFC-AGG-ID: 3MJuVZ__Ph-va2lLFSafPw_1778082880
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18C8F1800451; Wed,  6 May 2026 15:54:40 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E51919560A2; Wed,  6 May 2026 15:54:35 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 21/23] drivers/bus: remove specific bus types
Date: Wed,  6 May 2026 17:51:53 +0200
Message-ID: <20260506155201.2709810-22-david.marchand@redhat.com>
In-Reply-To: <20260506155201.2709810-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: smZRVzzkybcsYD2pO8Hcip0UKjDxfA1XT-3r_FrUU8g_1778082880
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

All the buses can have a simple rte_bus object.
Mark as static whenever possible.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c   | 44 ++++++++-------
 drivers/bus/auxiliary/linux/auxiliary.c    | 10 ++--
 drivers/bus/auxiliary/private.h            |  9 +---
 drivers/bus/cdx/bus_cdx_driver.h           |  1 -
 drivers/bus/cdx/cdx.c                      | 42 +++++++--------
 drivers/bus/cdx/private.h                  |  7 ---
 drivers/bus/dpaa/dpaa_bus.c                | 58 +++++++++-----------
 drivers/bus/fslmc/fslmc_bus.c              | 62 +++++++++++-----------
 drivers/bus/fslmc/fslmc_vfio.c             | 30 +++++------
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c   |  2 +-
 drivers/bus/fslmc/private.h                |  9 +---
 drivers/bus/pci/bsd/pci.c                  | 16 +++---
 drivers/bus/pci/linux/pci.c                | 13 +++--
 drivers/bus/pci/pci_common.c               | 60 ++++++++++-----------
 drivers/bus/pci/pci_params.c               |  2 +-
 drivers/bus/pci/private.h                  |  9 +---
 drivers/bus/pci/windows/pci.c              | 13 +++--
 drivers/bus/platform/bus_platform_driver.h |  1 -
 drivers/bus/platform/platform.c            | 52 +++++++++---------
 drivers/bus/platform/private.h             |  9 ----
 drivers/bus/uacce/uacce.c                  | 49 +++++++----------
 drivers/bus/vmbus/linux/vmbus_bus.c        | 10 ++--
 drivers/bus/vmbus/private.h                |  9 +---
 drivers/bus/vmbus/vmbus_common.c           | 34 ++++++------
 24 files changed, 236 insertions(+), 315 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index ff05716539..048aacf254 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -56,7 +56,7 @@ auxiliary_scan(void)
 void
 auxiliary_on_scan(struct rte_auxiliary_device *aux_dev)
 {
-	aux_dev->device.devargs = rte_bus_find_devargs(&auxiliary_bus.bus, aux_dev->name);
+	aux_dev->device.devargs = rte_bus_find_devargs(&auxiliary_bus, aux_dev->name);
 }
 
 static bool
@@ -156,7 +156,7 @@ auxiliary_parse(const char *name, void *addr)
 	if (strlen(name) == 0)
 		return 0;
 
-	RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus.bus) {
+	RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus) {
 		if (drv->match(name))
 			break;
 	}
@@ -170,7 +170,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_register)
 void
 rte_auxiliary_register(struct rte_auxiliary_driver *driver)
 {
-	rte_bus_add_driver(&auxiliary_bus.bus, &driver->driver);
+	rte_bus_add_driver(&auxiliary_bus, &driver->driver);
 }
 
 /* Unregister a driver */
@@ -178,7 +178,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_unregister)
 void
 rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 {
-	rte_bus_remove_driver(&auxiliary_bus.bus, &driver->driver);
+	rte_bus_remove_driver(&auxiliary_bus, &driver->driver);
 }
 
 static int
@@ -189,7 +189,7 @@ auxiliary_unplug(struct rte_device *dev)
 
 	ret = rte_auxiliary_driver_remove_dev(adev);
 	if (ret == 0) {
-		rte_bus_remove_device(&auxiliary_bus.bus, &adev->device);
+		rte_bus_remove_device(&auxiliary_bus, &adev->device);
 		rte_devargs_remove(dev->devargs);
 		rte_intr_instance_free(adev->intr_handle);
 		free(adev);
@@ -203,7 +203,7 @@ auxiliary_cleanup(void)
 	struct rte_auxiliary_device *dev;
 	int error = 0;
 
-	RTE_BUS_FOREACH_DEV(dev, &auxiliary_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &auxiliary_bus) {
 		int ret;
 
 		if (!rte_dev_is_probed(&dev->device))
@@ -250,7 +250,7 @@ auxiliary_get_iommu_class(void)
 {
 	const struct rte_auxiliary_driver *drv;
 
-	RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus.bus) {
+	RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus) {
 		if ((drv->drv_flags & RTE_AUXILIARY_DRV_NEED_IOVA_AS_VA) > 0)
 			return RTE_IOVA_VA;
 	}
@@ -258,22 +258,20 @@ auxiliary_get_iommu_class(void)
 	return RTE_IOVA_DC;
 }
 
-struct rte_auxiliary_bus auxiliary_bus = {
-	.bus = {
-		.scan = auxiliary_scan,
-		.probe = rte_bus_generic_probe,
-		.cleanup = auxiliary_cleanup,
-		.find_device = rte_bus_generic_find_device,
-		.match = auxiliary_bus_match,
-		.probe_device = auxiliary_probe_device,
-		.unplug = auxiliary_unplug,
-		.parse = auxiliary_parse,
-		.dma_map = auxiliary_dma_map,
-		.dma_unmap = auxiliary_dma_unmap,
-		.get_iommu_class = auxiliary_get_iommu_class,
-		.dev_iterate = rte_bus_generic_dev_iterate,
-	},
+struct rte_bus auxiliary_bus = {
+	.scan = auxiliary_scan,
+	.probe = rte_bus_generic_probe,
+	.cleanup = auxiliary_cleanup,
+	.find_device = rte_bus_generic_find_device,
+	.match = auxiliary_bus_match,
+	.probe_device = auxiliary_probe_device,
+	.unplug = auxiliary_unplug,
+	.parse = auxiliary_parse,
+	.dma_map = auxiliary_dma_map,
+	.dma_unmap = auxiliary_dma_unmap,
+	.get_iommu_class = auxiliary_get_iommu_class,
+	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(auxiliary, auxiliary_bus.bus);
+RTE_REGISTER_BUS(auxiliary, auxiliary_bus);
 RTE_LOG_REGISTER_DEFAULT(auxiliary_bus_logtype, NOTICE);
diff --git a/drivers/bus/auxiliary/linux/auxiliary.c b/drivers/bus/auxiliary/linux/auxiliary.c
index c65bbc8fcc..b99a205dba 100644
--- a/drivers/bus/auxiliary/linux/auxiliary.c
+++ b/drivers/bus/auxiliary/linux/auxiliary.c
@@ -48,12 +48,12 @@ auxiliary_scan_one(const char *dirname, const char *name)
 	auxiliary_on_scan(dev);
 
 	/* Device is valid, add in list (sorted) */
-	RTE_BUS_FOREACH_DEV(dev2, &auxiliary_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev2, &auxiliary_bus) {
 		ret = strcmp(dev->name, dev2->name);
 		if (ret > 0)
 			continue;
 		if (ret < 0) {
-			rte_bus_insert_device(&auxiliary_bus.bus, &dev2->device, &dev->device);
+			rte_bus_insert_device(&auxiliary_bus, &dev2->device, &dev->device);
 		} else { /* already registered */
 			if (rte_dev_is_probed(&dev2->device) &&
 			    dev2->device.devargs != dev->device.devargs) {
@@ -65,7 +65,7 @@ auxiliary_scan_one(const char *dirname, const char *name)
 		}
 		return 0;
 	}
-	rte_bus_add_device(&auxiliary_bus.bus, &dev->device);
+	rte_bus_add_device(&auxiliary_bus, &dev->device);
 	return 0;
 }
 
@@ -109,7 +109,7 @@ auxiliary_scan(void)
 		if (e->d_name[0] == '.')
 			continue;
 
-		if (rte_bus_device_is_ignored(&auxiliary_bus.bus, e->d_name))
+		if (rte_bus_device_is_ignored(&auxiliary_bus, e->d_name))
 			continue;
 
 		snprintf(dirname, sizeof(dirname), "%s/%s",
@@ -117,7 +117,7 @@ auxiliary_scan(void)
 
 		/* Ignore if no driver can handle. */
 		drv = NULL;
-		RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus.bus) {
+		RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus) {
 			if (drv->match(e->d_name))
 				break;
 		}
diff --git a/drivers/bus/auxiliary/private.h b/drivers/bus/auxiliary/private.h
index 116154eb56..282ad94618 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -19,14 +19,7 @@ extern int auxiliary_bus_logtype;
 #define AUXILIARY_LOG(level, ...) \
 	RTE_LOG_LINE(level, AUXILIARY_BUS, __VA_ARGS__)
 
-/*
- * Structure describing the auxiliary bus
- */
-struct rte_auxiliary_bus {
-	struct rte_bus bus;                  /* Inherit the generic class */
-};
-
-extern struct rte_auxiliary_bus auxiliary_bus;
+extern struct rte_bus auxiliary_bus;
 
 /*
  * Test whether the auxiliary device exist.
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index 97fd3b6f88..1ac481119c 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -25,7 +25,6 @@ extern "C" {
 /* Forward declarations */
 struct rte_cdx_device;
 struct rte_cdx_driver;
-struct rte_cdx_bus;
 
 #define RTE_CDX_BUS_DEVICES_PATH "/sys/bus/cdx/devices"
 
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index cb4f755b8e..2443161e1a 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -84,7 +84,7 @@
 
 #define CDX_DEV_PREFIX	"cdx-"
 
-struct rte_cdx_bus rte_cdx_bus;
+static struct rte_bus rte_cdx_bus;
 
 static int
 cdx_get_kernel_driver_by_path(const char *filename, char *driver_name,
@@ -194,7 +194,7 @@ cdx_scan_one(const char *dirname, const char *dev_name)
 	}
 	dev->id.device_id = (uint16_t)tmp;
 
-	rte_bus_add_device(&rte_cdx_bus.bus, &dev->device);
+	rte_bus_add_device(&rte_cdx_bus, &dev->device);
 
 	return 0;
 
@@ -226,7 +226,7 @@ cdx_scan(void)
 		if (e->d_name[0] == '.')
 			continue;
 
-		if (rte_bus_device_is_ignored(&rte_cdx_bus.bus, e->d_name))
+		if (rte_bus_device_is_ignored(&rte_cdx_bus, e->d_name))
 			continue;
 
 		snprintf(dirname, sizeof(dirname), "%s/%s",
@@ -363,7 +363,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_register)
 void
 rte_cdx_register(struct rte_cdx_driver *driver)
 {
-	rte_bus_add_driver(&rte_cdx_bus.bus, &driver->driver);
+	rte_bus_add_driver(&rte_cdx_bus, &driver->driver);
 }
 
 /* unregister a driver */
@@ -371,7 +371,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_unregister)
 void
 rte_cdx_unregister(struct rte_cdx_driver *driver)
 {
-	rte_bus_remove_driver(&rte_cdx_bus.bus, &driver->driver);
+	rte_bus_remove_driver(&rte_cdx_bus, &driver->driver);
 }
 
 /*
@@ -412,7 +412,7 @@ cdx_unplug(struct rte_device *dev)
 
 	ret = cdx_detach_dev(cdx_dev);
 	if (ret == 0) {
-		rte_bus_remove_device(&rte_cdx_bus.bus, &cdx_dev->device);
+		rte_bus_remove_device(&rte_cdx_bus, &cdx_dev->device);
 		rte_devargs_remove(dev->devargs);
 		free(cdx_dev);
 	}
@@ -440,27 +440,25 @@ cdx_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 static enum rte_iova_mode
 cdx_get_iommu_class(void)
 {
-	if (TAILQ_EMPTY(&rte_cdx_bus.bus.device_list))
+	if (TAILQ_EMPTY(&rte_cdx_bus.device_list))
 		return RTE_IOVA_DC;
 
 	return RTE_IOVA_VA;
 }
 
-struct rte_cdx_bus rte_cdx_bus = {
-	.bus = {
-		.scan = cdx_scan,
-		.probe = rte_bus_generic_probe,
-		.find_device = rte_bus_generic_find_device,
-		.match = cdx_bus_match,
-		.probe_device = cdx_probe_device,
-		.unplug = cdx_unplug,
-		.parse = cdx_parse,
-		.dma_map = cdx_dma_map,
-		.dma_unmap = cdx_dma_unmap,
-		.get_iommu_class = cdx_get_iommu_class,
-		.dev_iterate = rte_bus_generic_dev_iterate,
-	},
+static struct rte_bus rte_cdx_bus = {
+	.scan = cdx_scan,
+	.probe = rte_bus_generic_probe,
+	.find_device = rte_bus_generic_find_device,
+	.match = cdx_bus_match,
+	.probe_device = cdx_probe_device,
+	.unplug = cdx_unplug,
+	.parse = cdx_parse,
+	.dma_map = cdx_dma_map,
+	.dma_unmap = cdx_dma_unmap,
+	.get_iommu_class = cdx_get_iommu_class,
+	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(cdx, rte_cdx_bus.bus);
+RTE_REGISTER_BUS(cdx, rte_cdx_bus);
 RTE_LOG_REGISTER_DEFAULT(cdx_logtype_bus, NOTICE);
diff --git a/drivers/bus/cdx/private.h b/drivers/bus/cdx/private.h
index f69673aaab..289301bade 100644
--- a/drivers/bus/cdx/private.h
+++ b/drivers/bus/cdx/private.h
@@ -7,13 +7,6 @@
 
 #include "bus_cdx_driver.h"
 
-/**
- * Structure describing the CDX bus.
- */
-struct rte_cdx_bus {
-	struct rte_bus bus;				/**< Inherit the generic class */
-};
-
 /**
  * Map a particular resource from a file.
  *
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 08c1607647..ee467b94d5 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -57,10 +57,6 @@
 #define DPAA_MAX_PUSH_MODE_QUEUE 8
 #define DPAA_DEFAULT_PUSH_MODE_QUEUE 4
 
-struct rte_dpaa_bus {
-	struct rte_bus bus;
-};
-
 struct rte_dpaa_bus_private {
 	int device_count;
 	int detected;
@@ -69,7 +65,7 @@ struct rte_dpaa_bus_private {
 	RTE_ATOMIC(uint16_t) push_rxq_num;
 };
 
-static struct rte_dpaa_bus rte_dpaa_bus;
+static struct rte_bus rte_dpaa_bus;
 static struct rte_dpaa_bus_private dpaa_bus;
 static struct netcfg_info *dpaa_netcfg;
 
@@ -168,17 +164,17 @@ dpaa_add_to_device_list(struct rte_dpaa_device *newdev)
 	int comp, inserted = 0;
 	struct rte_dpaa_device *dev = NULL;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus) {
 		comp = compare_dpaa_devices(newdev, dev);
 		if (comp < 0) {
-			rte_bus_insert_device(&rte_dpaa_bus.bus, &dev->device, &newdev->device);
+			rte_bus_insert_device(&rte_dpaa_bus, &dev->device, &newdev->device);
 			inserted = 1;
 			break;
 		}
 	}
 
 	if (!inserted)
-		rte_bus_add_device(&rte_dpaa_bus.bus, &newdev->device);
+		rte_bus_add_device(&rte_dpaa_bus, &newdev->device);
 }
 
 /*
@@ -253,7 +249,7 @@ dpaa_create_device_list(void)
 				(fman_intf->fman->idx + 1), fman_intf->mac_idx);
 		}
 		dev->device.name = dev->name;
-		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus.bus, dev->name);
+		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus, dev->name);
 		if (dev->device.devargs != NULL)
 			DPAA_BUS_INFO("**Devargs matched %s", dev->name);
 
@@ -303,7 +299,7 @@ dpaa_create_device_list(void)
 		sprintf(dev->name, "dpaa_sec-%d", i+1);
 		DPAA_BUS_LOG(INFO, "%s cryptodev added", dev->name);
 		dev->device.name = dev->name;
-		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus.bus, dev->name);
+		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus, dev->name);
 		if (dev->device.devargs != NULL)
 			DPAA_BUS_INFO("**Devargs matched %s", dev->name);
 
@@ -329,7 +325,7 @@ dpaa_create_device_list(void)
 		sprintf(dev->name, "dpaa_qdma-%d", i+1);
 		DPAA_BUS_LOG(INFO, "%s qdma device added", dev->name);
 		dev->device.name = dev->name;
-		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus.bus, dev->name);
+		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus, dev->name);
 		if (dev->device.devargs != NULL)
 			DPAA_BUS_INFO("**Devargs matched %s", dev->name);
 
@@ -349,8 +345,8 @@ dpaa_clean_device_list(void)
 {
 	struct rte_dpaa_device *dev = NULL;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
-		rte_bus_remove_device(&rte_dpaa_bus.bus, &dev->device);
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus) {
+		rte_bus_remove_device(&rte_dpaa_bus, &dev->device);
 		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
 		dev = NULL;
@@ -583,7 +579,7 @@ rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
 
 	BUS_INIT_FUNC_TRACE();
 
-	rte_bus_add_driver(&rte_dpaa_bus.bus, &driver->driver);
+	rte_bus_add_driver(&rte_dpaa_bus, &driver->driver);
 }
 
 /* un-register a dpaa bus based dpaa driver */
@@ -593,7 +589,7 @@ rte_dpaa_driver_unregister(struct rte_dpaa_driver *driver)
 {
 	BUS_INIT_FUNC_TRACE();
 
-	rte_bus_remove_driver(&rte_dpaa_bus.bus, &driver->driver);
+	rte_bus_remove_driver(&rte_dpaa_bus, &driver->driver);
 }
 
 static bool
@@ -760,7 +756,7 @@ rte_dpaa_bus_scan(void)
 	process_once = 1;
 
 	/* If no device present on DPAA bus nothing needs to be done */
-	if (TAILQ_EMPTY(&rte_dpaa_bus.bus.device_list))
+	if (TAILQ_EMPTY(&rte_dpaa_bus.device_list))
 		return 0;
 
 	/* Register DPAA mempool ops only if any DPAA device has
@@ -768,7 +764,7 @@ rte_dpaa_bus_scan(void)
 	 */
 	rte_mbuf_set_platform_mempool_ops(DPAA_MEMPOOL_OPS_NAME);
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus) {
 		if (dev->device_type == FSL_DPAA_ETH) {
 			ret = rte_dpaa_setup_intr(dev->intr_handle);
 			if (ret)
@@ -816,7 +812,7 @@ dpaa_bus_cleanup(void)
 	struct rte_dpaa_device *dev;
 
 	BUS_INIT_FUNC_TRACE();
-	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_dpaa_bus) {
 		const struct rte_dpaa_driver *drv;
 		int ret = 0;
 
@@ -859,19 +855,17 @@ RTE_FINI_PRIO(dpaa_cleanup, 102)
 	DPAA_BUS_DEBUG("Worker thread clean up done");
 }
 
-static struct rte_dpaa_bus rte_dpaa_bus = {
-	.bus = {
-		.scan = rte_dpaa_bus_scan,
-		.probe = rte_bus_generic_probe,
-		.parse = rte_dpaa_bus_parse,
-		.dev_compare = dpaa_bus_dev_compare,
-		.find_device = rte_bus_generic_find_device,
-		.get_iommu_class = rte_dpaa_get_iommu_class,
-		.match = dpaa_bus_match,
-		.probe_device = dpaa_bus_probe_device,
-		.dev_iterate = rte_bus_generic_dev_iterate,
-		.cleanup = dpaa_bus_cleanup,
-	},
+static struct rte_bus rte_dpaa_bus = {
+	.scan = rte_dpaa_bus_scan,
+	.probe = rte_bus_generic_probe,
+	.parse = rte_dpaa_bus_parse,
+	.dev_compare = dpaa_bus_dev_compare,
+	.find_device = rte_bus_generic_find_device,
+	.get_iommu_class = rte_dpaa_get_iommu_class,
+	.match = dpaa_bus_match,
+	.probe_device = dpaa_bus_probe_device,
+	.dev_iterate = rte_bus_generic_dev_iterate,
+	.cleanup = dpaa_bus_cleanup,
 };
 
 static struct rte_dpaa_bus_private dpaa_bus = {
@@ -879,5 +873,5 @@ static struct rte_dpaa_bus_private dpaa_bus = {
 	.device_count = 0,
 };
 
-RTE_REGISTER_BUS(dpaa_bus, rte_dpaa_bus.bus);
+RTE_REGISTER_BUS(dpaa_bus, rte_dpaa_bus);
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_bus, NOTICE);
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 821fe63955..88511d4dc7 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -27,7 +27,7 @@
 
 #define VFIO_IOMMU_GROUP_PATH "/sys/kernel/iommu_groups"
 
-struct rte_fslmc_bus rte_fslmc_bus;
+struct rte_bus rte_fslmc_bus;
 static int fslmc_bus_device_count[DPAA2_DEVTYPE_MAX];
 
 #define DPAA2_SEQN_DYNFIELD_NAME "dpaa2_seqn_dynfield"
@@ -48,8 +48,8 @@ cleanup_fslmc_device_list(void)
 {
 	struct rte_dpaa2_device *dev;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
-		rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
 		rte_intr_instance_free(dev->intr_handle);
 		free(dev);
 		dev = NULL;
@@ -85,17 +85,17 @@ insert_in_device_list(struct rte_dpaa2_device *newdev)
 	int comp, inserted = 0;
 	struct rte_dpaa2_device *dev = NULL;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		comp = compare_dpaa2_devname(newdev, dev);
 		if (comp < 0) {
-			rte_bus_insert_device(&rte_fslmc_bus.bus, &dev->device, &newdev->device);
+			rte_bus_insert_device(&rte_fslmc_bus, &dev->device, &newdev->device);
 			inserted = 1;
 			break;
 		}
 	}
 
 	if (!inserted)
-		rte_bus_add_device(&rte_fslmc_bus.bus, &newdev->device);
+		rte_bus_add_device(&rte_fslmc_bus, &newdev->device);
 }
 
 static void
@@ -106,7 +106,7 @@ dump_device_list(void)
 	/* Only if the log level has been set to Debugging, print list */
 	if (rte_log_can_log(dpaa2_logtype_bus, RTE_LOG_DEBUG)) {
 		DPAA2_BUS_LOG(DEBUG, "List of devices scanned on bus:");
-		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 			DPAA2_BUS_LOG(DEBUG, "\t\t%s", dev->device.name);
 		}
 	}
@@ -198,7 +198,7 @@ scan_one_fslmc_device(char *dev_name)
 		ret = -ENOMEM;
 		goto cleanup;
 	}
-	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus.bus, dev_name);
+	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
 
 	/* Update the device found into the device_count table */
 	fslmc_bus_device_count[dev->dev_type]++;
@@ -247,7 +247,7 @@ rte_fslmc_parse(const char *name, void *addr)
 	 */
 	if (sep_exists) {
 		/* If either of "fslmc" or "name" are starting part */
-		if (!strncmp(name, rte_fslmc_bus.bus.name, strlen(rte_fslmc_bus.bus.name)) ||
+		if (!strncmp(name, rte_fslmc_bus.name, strlen(rte_fslmc_bus.name)) ||
 		   (!strncmp(name, "name", strlen("name")))) {
 			goto jump_out;
 		} else {
@@ -317,8 +317,8 @@ rte_fslmc_scan(void)
 		struct rte_dpaa2_device *dev;
 
 		DPAA2_BUS_DEBUG("Fslmc bus already scanned. Not rescanning");
-		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
-			dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus.bus,
+		RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+			dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus,
 				dev->device.name);
 		}
 		return 0;
@@ -369,7 +369,7 @@ rte_fslmc_scan(void)
 	dump_device_list();
 
 	/* Bus initialization - only if devices were found */
-	if (!TAILQ_EMPTY(&rte_fslmc_bus.bus.device_list)) {
+	if (!TAILQ_EMPTY(&rte_fslmc_bus.device_list)) {
 		static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
 			.name = DPAA2_SEQN_DYNFIELD_NAME,
 			.size = sizeof(dpaa2_seqn_t),
@@ -455,7 +455,7 @@ rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
 	RTE_VERIFY(driver);
 	RTE_VERIFY(driver->probe != NULL);
 
-	rte_bus_add_driver(&rte_fslmc_bus.bus, &driver->driver);
+	rte_bus_add_driver(&rte_fslmc_bus, &driver->driver);
 }
 
 /*un-register a fslmc bus based dpaa2 driver */
@@ -463,7 +463,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_unregister)
 void
 rte_fslmc_driver_unregister(struct rte_dpaa2_driver *driver)
 {
-	rte_bus_remove_driver(&rte_fslmc_bus.bus, &driver->driver);
+	rte_bus_remove_driver(&rte_fslmc_bus, &driver->driver);
 }
 
 /*
@@ -475,8 +475,8 @@ fslmc_all_device_support_iova(void)
 	struct rte_dpaa2_device *dev;
 	struct rte_dpaa2_driver *drv;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
-		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus) {
 			if (!fslmc_bus_match(&drv->driver, &dev->device))
 				continue;
 			/* if the driver is not supporting IOVA */
@@ -496,7 +496,7 @@ rte_dpaa2_get_iommu_class(void)
 	if (rte_eal_iova_mode() == RTE_IOVA_PA)
 		return RTE_IOVA_PA;
 
-	if (TAILQ_EMPTY(&rte_fslmc_bus.bus.device_list))
+	if (TAILQ_EMPTY(&rte_fslmc_bus.device_list))
 		return RTE_IOVA_DC;
 
 	/* check if all devices on the bus support Virtual addressing or not */
@@ -546,21 +546,19 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 	return -ENODEV;
 }
 
-struct rte_fslmc_bus rte_fslmc_bus = {
-	.bus = {
-		.scan = rte_fslmc_scan,
-		.probe = rte_bus_generic_probe,
-		.cleanup = rte_fslmc_close,
-		.parse = rte_fslmc_parse,
-		.dev_compare = fslmc_dev_compare,
-		.find_device = rte_bus_generic_find_device,
-		.get_iommu_class = rte_dpaa2_get_iommu_class,
-		.match = fslmc_bus_match,
-		.probe_device = fslmc_bus_probe_device,
-		.unplug = fslmc_bus_unplug,
-		.dev_iterate = rte_bus_generic_dev_iterate,
-	},
+struct rte_bus rte_fslmc_bus = {
+	.scan = rte_fslmc_scan,
+	.probe = rte_bus_generic_probe,
+	.cleanup = rte_fslmc_close,
+	.parse = rte_fslmc_parse,
+	.dev_compare = fslmc_dev_compare,
+	.find_device = rte_bus_generic_find_device,
+	.get_iommu_class = rte_dpaa2_get_iommu_class,
+	.match = fslmc_bus_match,
+	.probe_device = fslmc_bus_probe_device,
+	.unplug = fslmc_bus_unplug,
+	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(fslmc, rte_fslmc_bus.bus);
+RTE_REGISTER_BUS(fslmc, rte_fslmc_bus);
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_bus, NOTICE);
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 5784adaf90..412b70e5ae 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1554,12 +1554,12 @@ fslmc_vfio_close_group(void)
 		return -EIO;
 	}
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		if (dev->device.devargs &&
 		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 			DPAA2_BUS_LOG(DEBUG, "%s Blacklisted, skipping",
 				      dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
 				continue;
 		}
 		switch (dev->dev_type) {
@@ -1599,7 +1599,7 @@ fslmc_vfio_process_group(void)
 	bool is_dpmcp_in_blocklist = false, is_dpio_in_blocklist = false;
 	int dpmcp_count = 0, dpio_count = 0, current_device;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		if (dev->dev_type == DPAA2_MPORTAL) {
 			dpmcp_count++;
 			if (dev->device.devargs &&
@@ -1616,14 +1616,14 @@ fslmc_vfio_process_group(void)
 
 	/* Search the MCP as that should be initialized first. */
 	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		if (dev->dev_type == DPAA2_MPORTAL) {
 			current_device++;
 			if (dev->device.devargs &&
 			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 				DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 					      dev->device.name);
-				rte_bus_remove_device(&rte_fslmc_bus.bus,
+				rte_bus_remove_device(&rte_fslmc_bus,
 						&dev->device);
 				continue;
 			}
@@ -1632,7 +1632,7 @@ fslmc_vfio_process_group(void)
 			    !is_dpmcp_in_blocklist) {
 				if (dpmcp_count == 1 ||
 				    current_device != dpmcp_count) {
-					rte_bus_remove_device(&rte_fslmc_bus.bus,
+					rte_bus_remove_device(&rte_fslmc_bus,
 						     &dev->device);
 					continue;
 				}
@@ -1647,7 +1647,7 @@ fslmc_vfio_process_group(void)
 				found_mportal = 1;
 			}
 
-			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
 			free(dev);
 			dev = NULL;
 			/* Ideally there is only a single dpmcp, but in case
@@ -1666,26 +1666,26 @@ fslmc_vfio_process_group(void)
 	 * other devices.
 	 */
 	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		if (dev->dev_type == DPAA2_DPRC) {
 			ret = fslmc_process_iodevices(dev);
 			if (ret) {
 				DPAA2_BUS_ERR("Unable to process dprc");
 				return ret;
 			}
-			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
 		}
 	}
 
 	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		if (dev->dev_type == DPAA2_IO)
 			current_device++;
 		if (dev->device.devargs &&
 		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 				      dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
 			continue;
 		}
 		if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
@@ -1693,7 +1693,7 @@ fslmc_vfio_process_group(void)
 		    dev->dev_type != DPAA2_CRYPTO &&
 		    dev->dev_type != DPAA2_QDMA &&
 		    dev->dev_type != DPAA2_IO) {
-			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
 			continue;
 		}
 		switch (dev->dev_type) {
@@ -1735,13 +1735,13 @@ fslmc_vfio_process_group(void)
 			if (!is_dpio_in_blocklist && dpio_count > 1) {
 				if (rte_eal_process_type() == RTE_PROC_SECONDARY
 				    && current_device != dpio_count) {
-					rte_bus_remove_device(&rte_fslmc_bus.bus,
+					rte_bus_remove_device(&rte_fslmc_bus,
 						     &dev->device);
 					break;
 				}
 				if (rte_eal_process_type() == RTE_PROC_PRIMARY
 				    && current_device == dpio_count) {
-					rte_bus_remove_device(&rte_fslmc_bus.bus,
+					rte_bus_remove_device(&rte_fslmc_bus,
 						     &dev->device);
 					break;
 				}
@@ -1760,7 +1760,7 @@ fslmc_vfio_process_group(void)
 			/* Unknown - ignore */
 			DPAA2_BUS_DEBUG("Found unknown device (%s)",
 					dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus.bus, &dev->device);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
 			free(dev);
 			dev = NULL;
 		}
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
index a66e55a456..868ed646af 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
@@ -49,7 +49,7 @@ rte_dpaa2_create_dprc_device(int vdev_fd __rte_unused,
 		return ret;
 	}
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		/** DPRC is always created before it's children are created.*/
 		dev->container = dprc_node;
 		if (dev->dev_type == DPAA2_ETH) {
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index a0dda4f9d6..20a454c3fc 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -9,13 +9,6 @@
 
 #include <bus_fslmc_driver.h>
 
-/*
- * FSLMC bus
- */
-struct rte_fslmc_bus {
-	struct rte_bus bus;     /**< Generic Bus object */
-};
-
-extern struct rte_fslmc_bus rte_fslmc_bus;
+extern struct rte_bus rte_fslmc_bus;
 
 #endif /* BUS_FSLMC_PRIVATE_H */
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 78d14ab3ae..c6df31d486 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -297,20 +297,18 @@ pci_scan_one(int dev_pci_fd, struct pci_conf *conf)
 	}
 
 	/* device is valid, add in list (sorted) */
-	if (TAILQ_EMPTY(&rte_pci_bus.bus.device_list)) {
-		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
-	}
-	else {
+	if (TAILQ_EMPTY(&rte_pci_bus.device_list)) {
+		rte_bus_add_device(&rte_pci_bus, &dev->device);
+	} else {
 		struct rte_pci_device *dev2 = NULL;
 		int ret;
 
-		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus.bus) {
+		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus) {
 			ret = rte_pci_addr_cmp(&dev->addr, &dev2->addr);
 			if (ret > 0)
 				continue;
 			else if (ret < 0) {
-				rte_bus_insert_device(&rte_pci_bus.bus, &dev2->device,
-					&dev->device);
+				rte_bus_insert_device(&rte_pci_bus, &dev2->device, &dev->device);
 			} else { /* already registered */
 				dev2->kdrv = dev->kdrv;
 				dev2->max_vfs = dev->max_vfs;
@@ -322,7 +320,7 @@ pci_scan_one(int dev_pci_fd, struct pci_conf *conf)
 			}
 			return 0;
 		}
-		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
+		rte_bus_add_device(&rte_pci_bus, &dev->device);
 	}
 
 	return 0;
@@ -378,7 +376,7 @@ rte_pci_scan(void)
 			pci_addr.function = matches[i].pc_sel.pc_func;
 			rte_pci_device_name(&pci_addr, name, sizeof(name));
 
-			if (rte_bus_device_is_ignored(&rte_pci_bus.bus, name))
+			if (rte_bus_device_is_ignored(&rte_pci_bus, name))
 				continue;
 
 			if (pci_scan_one(fd, &matches[i]) < 0)
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index cf8a60313b..9aae0a5d14 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -321,19 +321,18 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 		return 0;
 	}
 	/* device is valid, add in list (sorted) */
-	if (TAILQ_EMPTY(&rte_pci_bus.bus.device_list)) {
-		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
+	if (TAILQ_EMPTY(&rte_pci_bus.device_list)) {
+		rte_bus_add_device(&rte_pci_bus, &dev->device);
 	} else {
 		struct rte_pci_device *dev2;
 
-		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus.bus) {
+		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus) {
 			ret = rte_pci_addr_cmp(&dev->addr, &dev2->addr);
 			if (ret > 0)
 				continue;
 
 			if (ret < 0) {
-				rte_bus_insert_device(&rte_pci_bus.bus, &dev2->device,
-					&dev->device);
+				rte_bus_insert_device(&rte_pci_bus, &dev2->device, &dev->device);
 			} else { /* already registered */
 				if (!rte_dev_is_probed(&dev2->device)) {
 					dev2->kdrv = dev->kdrv;
@@ -377,7 +376,7 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 			return 0;
 		}
 
-		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
+		rte_bus_add_device(&rte_pci_bus, &dev->device);
 	}
 
 	return 0;
@@ -458,7 +457,7 @@ rte_pci_scan(void)
 		if (parse_pci_addr_format(e->d_name, sizeof(e->d_name), &addr) != 0)
 			continue;
 
-		if (rte_bus_device_is_ignored(&rte_pci_bus.bus, e->d_name))
+		if (rte_bus_device_is_ignored(&rte_pci_bus, e->d_name))
 			continue;
 
 		snprintf(dirname, sizeof(dirname), "%s/%s",
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 2bdb94a924..fd18b8772b 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -87,7 +87,7 @@ pci_common_set(struct rte_pci_device *dev)
 			dev->name, sizeof(dev->name));
 	dev->device.name = dev->name;
 
-	dev->device.devargs = rte_bus_find_devargs(&rte_pci_bus.bus, dev->name);
+	dev->device.devargs = rte_bus_find_devargs(&rte_pci_bus, dev->name);
 
 	if (dev->bus_info != NULL ||
 			asprintf(&dev->bus_info, "vendor_id=%"PRIx16", device_id=%"PRIx16,
@@ -329,7 +329,7 @@ pci_cleanup(void)
 	struct rte_pci_device *dev;
 	int error = 0;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus) {
 		const struct rte_pci_driver *drv;
 		int ret = 0;
 
@@ -353,7 +353,7 @@ pci_cleanup(void)
 		rte_intr_instance_free(dev->vfio_req_intr_handle);
 		dev->vfio_req_intr_handle = NULL;
 
-		rte_bus_remove_device(&rte_pci_bus.bus, &dev->device);
+		rte_bus_remove_device(&rte_pci_bus, &dev->device);
 		pci_free(RTE_PCI_DEVICE_INTERNAL(dev));
 	}
 
@@ -387,7 +387,7 @@ rte_pci_dump(FILE *f)
 {
 	struct rte_pci_device *dev = NULL;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus) {
 		pci_dump_one_device(f, dev);
 	}
 }
@@ -422,7 +422,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_register)
 void
 rte_pci_register(struct rte_pci_driver *driver)
 {
-	rte_bus_add_driver(&rte_pci_bus.bus, &driver->driver);
+	rte_bus_add_driver(&rte_pci_bus, &driver->driver);
 }
 
 /* unregister a driver */
@@ -430,7 +430,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_unregister)
 void
 rte_pci_unregister(struct rte_pci_driver *driver)
 {
-	rte_bus_remove_driver(&rte_pci_bus.bus, &driver->driver);
+	rte_bus_remove_driver(&rte_pci_bus, &driver->driver);
 }
 
 /*
@@ -447,7 +447,7 @@ pci_find_device_by_addr(const void *failure_addr)
 
 	check_point = (uint64_t)(uintptr_t)failure_addr;
 
-	RTE_BUS_FOREACH_DEV(pdev, &rte_pci_bus.bus) {
+	RTE_BUS_FOREACH_DEV(pdev, &rte_pci_bus) {
 		for (i = 0; i != RTE_DIM(pdev->mem_resource); i++) {
 			start = (uint64_t)(uintptr_t)pdev->mem_resource[i].addr;
 			len = pdev->mem_resource[i].len;
@@ -525,7 +525,7 @@ pci_unplug(struct rte_device *dev)
 
 	ret = rte_pci_detach_dev(pdev);
 	if (ret == 0) {
-		rte_bus_remove_device(&rte_pci_bus.bus, &pdev->device);
+		rte_bus_remove_device(&rte_pci_bus, &pdev->device);
 		rte_devargs_remove(dev->devargs);
 		pci_free(RTE_PCI_DEVICE_INTERNAL(pdev));
 	}
@@ -582,7 +582,7 @@ rte_pci_get_iommu_class(void)
 	bool devices_want_pa = false;
 	int iommu_no_va = -1;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_pci_bus) {
 		/*
 		 * We can check this only once, because the IOMMU hardware is
 		 * the same for all of them.
@@ -594,7 +594,7 @@ rte_pci_get_iommu_class(void)
 		if (dev->kdrv == RTE_PCI_KDRV_UNKNOWN ||
 		    dev->kdrv == RTE_PCI_KDRV_NONE)
 			continue;
-		RTE_BUS_FOREACH_DRV(drv, &rte_pci_bus.bus) {
+		RTE_BUS_FOREACH_DRV(drv, &rte_pci_bus) {
 			enum rte_iova_mode dev_iova_mode;
 
 			if (!pci_bus_match(&drv->driver, &dev->device))
@@ -772,27 +772,25 @@ rte_pci_pasid_set_state(const struct rte_pci_device *dev,
 			offset + RTE_PCI_PASID_CTRL) != sizeof(pasid) ? -1 : 0;
 }
 
-struct rte_pci_bus rte_pci_bus = {
-	.bus = {
-		.allow_multi_probe = true,
-		.scan = rte_pci_scan,
-		.probe = rte_bus_generic_probe,
-		.cleanup = pci_cleanup,
-		.find_device = rte_bus_generic_find_device,
-		.match = pci_bus_match,
-		.probe_device = pci_probe_device,
-		.unplug = pci_unplug,
-		.parse = pci_parse,
-		.dev_compare = pci_dev_compare,
-		.devargs_parse = rte_pci_devargs_parse,
-		.dma_map = pci_dma_map,
-		.dma_unmap = pci_dma_unmap,
-		.get_iommu_class = rte_pci_get_iommu_class,
-		.dev_iterate = rte_pci_dev_iterate,
-		.hot_unplug_handler = pci_hot_unplug_handler,
-		.sigbus_handler = pci_sigbus_handler,
-	},
+struct rte_bus rte_pci_bus = {
+	.allow_multi_probe = true,
+	.scan = rte_pci_scan,
+	.probe = rte_bus_generic_probe,
+	.cleanup = pci_cleanup,
+	.find_device = rte_bus_generic_find_device,
+	.match = pci_bus_match,
+	.probe_device = pci_probe_device,
+	.unplug = pci_unplug,
+	.parse = pci_parse,
+	.dev_compare = pci_dev_compare,
+	.devargs_parse = rte_pci_devargs_parse,
+	.dma_map = pci_dma_map,
+	.dma_unmap = pci_dma_unmap,
+	.get_iommu_class = rte_pci_get_iommu_class,
+	.dev_iterate = rte_pci_dev_iterate,
+	.hot_unplug_handler = pci_hot_unplug_handler,
+	.sigbus_handler = pci_sigbus_handler,
 };
 
-RTE_REGISTER_BUS(pci, rte_pci_bus.bus);
+RTE_REGISTER_BUS(pci, rte_pci_bus);
 RTE_LOG_REGISTER_DEFAULT(pci_bus_logtype, NOTICE);
diff --git a/drivers/bus/pci/pci_params.c b/drivers/bus/pci/pci_params.c
index e308c85ed2..6cbd98b4c8 100644
--- a/drivers/bus/pci/pci_params.c
+++ b/drivers/bus/pci/pci_params.c
@@ -75,7 +75,7 @@ rte_pci_dev_iterate(const struct rte_bus *bus __rte_unused,
 			return NULL;
 		}
 	}
-	dev = rte_bus_generic_find_device(&rte_pci_bus.bus, start, pci_dev_match, kvargs);
+	dev = rte_bus_generic_find_device(&rte_pci_bus, start, pci_dev_match, kvargs);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index c54ea7b9d8..8103c32881 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -29,14 +29,7 @@ extern int pci_bus_logtype;
 #define RTE_PCI_DEVICE_INTERNAL_CONST(ptr) \
 	container_of(ptr, const struct rte_pci_device_internal, device)
 
-/**
- * Structure describing the PCI bus
- */
-struct rte_pci_bus {
-	struct rte_bus bus;               /**< Inherit the generic class */
-};
-
-extern struct rte_pci_bus rte_pci_bus;
+extern struct rte_bus rte_pci_bus;
 
 struct rte_pci_driver;
 struct rte_pci_device;
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 3b3f97da27..7b51301d1e 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -382,7 +382,7 @@ pci_scan_one(HDEVINFO dev_info, PSP_DEVINFO_DATA device_info_data)
 		goto end;
 
 	rte_pci_device_name(&addr, name, sizeof(name));
-	if (rte_bus_device_is_ignored(&rte_pci_bus.bus, name)) {
+	if (rte_bus_device_is_ignored(&rte_pci_bus, name)) {
 		/*
 		 * We won't add this device, but we want to continue
 		 * looking for supported devices
@@ -430,18 +430,17 @@ pci_scan_one(HDEVINFO dev_info, PSP_DEVINFO_DATA device_info_data)
 	}
 
 	/* device is valid, add in list (sorted) */
-	if (TAILQ_EMPTY(&rte_pci_bus.bus.device_list)) {
-		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
+	if (TAILQ_EMPTY(&rte_pci_bus.device_list)) {
+		rte_bus_add_device(&rte_pci_bus, &dev->device);
 	} else {
 		struct rte_pci_device *dev2 = NULL;
 
-		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus.bus) {
+		RTE_BUS_FOREACH_DEV(dev2, &rte_pci_bus) {
 			ret = rte_pci_addr_cmp(&dev->addr, &dev2->addr);
 			if (ret > 0) {
 				continue;
 			} else if (ret < 0) {
-				rte_bus_insert_device(&rte_pci_bus.bus, &dev2->device,
-					&dev->device);
+				rte_bus_insert_device(&rte_pci_bus, &dev2->device, &dev->device);
 			} else { /* already registered */
 				dev2->kdrv = dev->kdrv;
 				dev2->max_vfs = dev->max_vfs;
@@ -451,7 +450,7 @@ pci_scan_one(HDEVINFO dev_info, PSP_DEVINFO_DATA device_info_data)
 			}
 			return 0;
 		}
-		rte_bus_add_device(&rte_pci_bus.bus, &dev->device);
+		rte_bus_add_device(&rte_pci_bus, &dev->device);
 	}
 
 	return 0;
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index 3ac405a201..e4dcbacf5e 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -24,7 +24,6 @@ extern "C" {
 #endif
 
 /* Forward declarations */
-struct rte_platform_bus;
 struct rte_platform_device;
 struct rte_platform_driver;
 
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 4492ed62ec..170a2e03d0 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -29,18 +29,20 @@
 
 #define PLATFORM_BUS_DEVICES_PATH "/sys/bus/platform/devices"
 
+static struct rte_bus platform_bus;
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_register)
 void
 rte_platform_register(struct rte_platform_driver *pdrv)
 {
-	rte_bus_add_driver(&platform_bus.bus, &pdrv->driver);
+	rte_bus_add_driver(&platform_bus, &pdrv->driver);
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_unregister)
 void
 rte_platform_unregister(struct rte_platform_driver *pdrv)
 {
-	rte_bus_remove_driver(&platform_bus.bus, &pdrv->driver);
+	rte_bus_remove_driver(&platform_bus, &pdrv->driver);
 }
 
 static int
@@ -56,11 +58,11 @@ dev_add(const char *dev_name)
 
 	rte_strscpy(pdev->name, dev_name, sizeof(pdev->name));
 	pdev->device.name = pdev->name;
-	pdev->device.devargs = rte_bus_find_devargs(&platform_bus.bus, dev_name);
+	pdev->device.devargs = rte_bus_find_devargs(&platform_bus, dev_name);
 	snprintf(path, sizeof(path), PLATFORM_BUS_DEVICES_PATH "/%s/numa_node", dev_name);
 	pdev->device.numa_node = eal_parse_sysfs_value(path, &val) ? rte_socket_id() : val;
 
-	RTE_BUS_FOREACH_DEV(tmp, &platform_bus.bus) {
+	RTE_BUS_FOREACH_DEV(tmp, &platform_bus) {
 		if (!strcmp(tmp->name, pdev->name)) {
 			PLATFORM_LOG_LINE(INFO, "device %s already added", pdev->name);
 
@@ -72,7 +74,7 @@ dev_add(const char *dev_name)
 		}
 	}
 
-	rte_bus_add_device(&platform_bus.bus, &pdev->device);
+	rte_bus_add_device(&platform_bus, &pdev->device);
 
 	PLATFORM_LOG_LINE(INFO, "adding device %s to the list", dev_name);
 
@@ -135,7 +137,7 @@ platform_bus_scan(void)
 		if (dev_name[0] == '.')
 			continue;
 
-		if (rte_bus_device_is_ignored(&platform_bus.bus, dev_name))
+		if (rte_bus_device_is_ignored(&platform_bus, dev_name))
 			continue;
 
 		if (!dev_is_bound_vfio_platform(dev_name))
@@ -440,7 +442,7 @@ platform_bus_parse(const char *name, void *addr)
 
 	rte_strscpy(pdev.name, name, sizeof(pdev.name));
 
-	RTE_BUS_FOREACH_DRV(pdrv, &platform_bus.bus) {
+	RTE_BUS_FOREACH_DRV(pdrv, &platform_bus) {
 		if (platform_bus_match(&pdrv->driver, &pdev.device))
 			break;
 	}
@@ -482,7 +484,7 @@ platform_bus_get_iommu_class(void)
 	const struct rte_platform_driver *pdrv;
 	struct rte_platform_device *pdev;
 
-	RTE_BUS_FOREACH_DEV(pdev, &platform_bus.bus) {
+	RTE_BUS_FOREACH_DEV(pdev, &platform_bus) {
 		if (!rte_dev_is_probed(&pdev->device))
 			continue;
 		pdrv = RTE_BUS_DRIVER(pdev->device.driver, *pdrv);
@@ -498,8 +500,8 @@ platform_bus_cleanup(void)
 {
 	struct rte_platform_device *pdev;
 
-	RTE_BUS_FOREACH_DEV(pdev, &platform_bus.bus) {
-		rte_bus_remove_device(&platform_bus.bus, &pdev->device);
+	RTE_BUS_FOREACH_DEV(pdev, &platform_bus) {
+		rte_bus_remove_device(&platform_bus, &pdev->device);
 		if (!rte_dev_is_probed(&pdev->device))
 			continue;
 		platform_bus_unplug(&pdev->device);
@@ -508,22 +510,20 @@ platform_bus_cleanup(void)
 	return 0;
 }
 
-struct rte_platform_bus platform_bus = {
-	.bus = {
-		.scan = platform_bus_scan,
-		.probe = rte_bus_generic_probe,
-		.find_device = rte_bus_generic_find_device,
-		.match = platform_bus_match,
-		.probe_device = platform_bus_probe_device,
-		.unplug = platform_bus_unplug,
-		.parse = platform_bus_parse,
-		.dma_map = platform_bus_dma_map,
-		.dma_unmap = platform_bus_dma_unmap,
-		.get_iommu_class = platform_bus_get_iommu_class,
-		.dev_iterate = rte_bus_generic_dev_iterate,
-		.cleanup = platform_bus_cleanup,
-	},
+static struct rte_bus platform_bus = {
+	.scan = platform_bus_scan,
+	.probe = rte_bus_generic_probe,
+	.find_device = rte_bus_generic_find_device,
+	.match = platform_bus_match,
+	.probe_device = platform_bus_probe_device,
+	.unplug = platform_bus_unplug,
+	.parse = platform_bus_parse,
+	.dma_map = platform_bus_dma_map,
+	.dma_unmap = platform_bus_dma_unmap,
+	.get_iommu_class = platform_bus_get_iommu_class,
+	.dev_iterate = rte_bus_generic_dev_iterate,
+	.cleanup = platform_bus_cleanup,
 };
 
-RTE_REGISTER_BUS(platform, platform_bus.bus);
+RTE_REGISTER_BUS(platform, platform_bus);
 RTE_LOG_REGISTER_DEFAULT(platform_bus_logtype, NOTICE);
diff --git a/drivers/bus/platform/private.h b/drivers/bus/platform/private.h
index bf5d75df03..18d42d43d8 100644
--- a/drivers/bus/platform/private.h
+++ b/drivers/bus/platform/private.h
@@ -14,15 +14,6 @@
 
 #include "bus_platform_driver.h"
 
-extern struct rte_platform_bus platform_bus;
-
-/*
- * Structure describing platform bus.
- */
-struct rte_platform_bus {
-	struct rte_bus bus; /* Core bus */
-};
-
 extern int platform_bus_logtype;
 #define RTE_LOGTYPE_PLATFORM_BUS platform_bus_logtype
 #define PLATFORM_LOG_LINE(level, ...) \
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 4fc4d522a8..73c6819e66 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -34,15 +34,8 @@
 /* Support -a uacce:device-name when start DPDK application. */
 #define UACCE_DEV_PREFIX	"uacce:"
 
-/*
- * Structure describing the UACCE bus.
- */
-struct rte_uacce_bus {
-	struct rte_bus bus;		            /* Inherit the generic class. */
-};
-
 /* Forward declaration of UACCE bus. */
-static struct rte_uacce_bus uacce_bus;
+static struct rte_bus uacce_bus;
 
 
 extern int uacce_bus_logtype;
@@ -206,7 +199,7 @@ uacce_scan_one(const char *dev_name)
 		return -ENOMEM;
 
 	dev->device.name = dev->name;
-	dev->device.devargs = rte_bus_find_devargs(&uacce_bus.bus, dev_name);
+	dev->device.devargs = rte_bus_find_devargs(&uacce_bus, dev_name);
 	snprintf(dev->name, sizeof(dev->name), "%s", dev_name);
 	snprintf(dev->dev_root, sizeof(dev->dev_root), "%s/%s",
 		 UACCE_BUS_CLASS_PATH, dev_name);
@@ -230,7 +223,7 @@ uacce_scan_one(const char *dev_name)
 	if (ret != 0)
 		goto err;
 
-	rte_bus_add_device(&uacce_bus.bus, &dev->device);
+	rte_bus_add_device(&uacce_bus, &dev->device);
 	return 0;
 
 err:
@@ -260,7 +253,7 @@ uacce_scan(void)
 			continue;
 		}
 
-		if (rte_bus_device_is_ignored(&uacce_bus.bus, e->d_name))
+		if (rte_bus_device_is_ignored(&uacce_bus, e->d_name))
 			continue;
 
 		if (uacce_scan_one(e->d_name) < 0)
@@ -378,7 +371,7 @@ uacce_cleanup(void)
 	struct rte_uacce_device *dev;
 	int error = 0;
 
-	RTE_BUS_FOREACH_DEV(dev, &uacce_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &uacce_bus) {
 		const struct rte_uacce_driver *dr;
 		int ret = 0;
 
@@ -396,7 +389,7 @@ uacce_cleanup(void)
 		dev->device.driver = NULL;
 
 free:
-		rte_bus_remove_device(&uacce_bus.bus, &dev->device);
+		rte_bus_remove_device(&uacce_bus, &dev->device);
 		free(dev);
 	}
 
@@ -430,7 +423,7 @@ uacce_unplug(struct rte_device *dev)
 
 	ret = uacce_detach_dev(uacce_dev);
 	if (ret == 0) {
-		rte_bus_remove_device(&uacce_bus.bus, &uacce_dev->device);
+		rte_bus_remove_device(&uacce_bus, &uacce_dev->device);
 		rte_devargs_remove(dev->devargs);
 		free(uacce_dev);
 	}
@@ -549,29 +542,27 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_register)
 void
 rte_uacce_register(struct rte_uacce_driver *driver)
 {
-	rte_bus_add_driver(&uacce_bus.bus, &driver->driver);
+	rte_bus_add_driver(&uacce_bus, &driver->driver);
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_unregister)
 void
 rte_uacce_unregister(struct rte_uacce_driver *driver)
 {
-	rte_bus_remove_driver(&uacce_bus.bus, &driver->driver);
+	rte_bus_remove_driver(&uacce_bus, &driver->driver);
 }
 
-static struct rte_uacce_bus uacce_bus = {
-	.bus = {
-		.scan = uacce_scan,
-		.probe = rte_bus_generic_probe,
-		.cleanup = uacce_cleanup,
-		.match = uacce_bus_match,
-		.probe_device = uacce_probe_device,
-		.unplug = uacce_unplug,
-		.find_device = rte_bus_generic_find_device,
-		.parse = uacce_parse,
-		.dev_iterate = rte_bus_generic_dev_iterate,
-	},
+static struct rte_bus uacce_bus = {
+	.scan = uacce_scan,
+	.probe = rte_bus_generic_probe,
+	.cleanup = uacce_cleanup,
+	.match = uacce_bus_match,
+	.probe_device = uacce_probe_device,
+	.unplug = uacce_unplug,
+	.find_device = rte_bus_generic_find_device,
+	.parse = uacce_parse,
+	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
-RTE_REGISTER_BUS(uacce, uacce_bus.bus);
+RTE_REGISTER_BUS(uacce, uacce_bus);
 RTE_LOG_REGISTER_DEFAULT(uacce_bus_logtype, NOTICE);
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 6268a14d40..0af10f6a69 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -39,8 +39,6 @@ static const rte_uuid_t vmbus_nic_uuid = {
 	0xf2, 0xd2, 0xf9, 0x65, 0xed, 0xe
 };
 
-extern struct rte_vmbus_bus rte_vmbus_bus;
-
 /* Read sysfs file to get UUID */
 static int
 parse_sysfs_uuid(const char *filename, rte_uuid_t uu)
@@ -332,7 +330,7 @@ vmbus_scan_one(const char *name)
 		dev->monitor_id = UINT8_MAX;
 	}
 
-	dev->device.devargs = rte_bus_find_devargs(&rte_vmbus_bus.bus, dev_name);
+	dev->device.devargs = rte_bus_find_devargs(&rte_vmbus_bus, dev_name);
 
 	dev->device.numa_node = SOCKET_ID_ANY;
 	if (vmbus_use_numa(dev)) {
@@ -356,7 +354,7 @@ vmbus_scan_one(const char *name)
 	/* device is valid, add in list (sorted) */
 	VMBUS_LOG(DEBUG, "Adding vmbus device %s", name);
 
-	RTE_BUS_FOREACH_DEV(dev2, &rte_vmbus_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev2, &rte_vmbus_bus) {
 		int ret;
 
 		ret = rte_uuid_compare(dev->device_id, dev2->device_id);
@@ -364,7 +362,7 @@ vmbus_scan_one(const char *name)
 			continue;
 
 		if (ret < 0) {
-			rte_bus_insert_device(&rte_vmbus_bus.bus, &dev2->device, &dev->device);
+			rte_bus_insert_device(&rte_vmbus_bus, &dev2->device, &dev->device);
 		} else { /* already registered */
 			VMBUS_LOG(NOTICE,
 				"%s already registered", name);
@@ -374,7 +372,7 @@ vmbus_scan_one(const char *name)
 		return 0;
 	}
 
-	rte_bus_add_device(&rte_vmbus_bus.bus, &dev->device);
+	rte_bus_add_device(&rte_vmbus_bus, &dev->device);
 	return 0;
 error:
 	VMBUS_LOG(DEBUG, "failed");
diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index 6abb97c607..6efac86b77 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -15,14 +15,7 @@
 #include <rte_eal_paging.h>
 #include <rte_vmbus_reg.h>
 
-/**
- * Structure describing the VM bus
- */
-struct rte_vmbus_bus {
-	struct rte_bus bus;               /**< Inherit the generic class */
-};
-
-extern struct rte_vmbus_bus rte_vmbus_bus;
+extern struct rte_bus rte_vmbus_bus;
 
 extern int vmbus_logtype_bus;
 #define RTE_LOGTYPE_VMBUS_BUS vmbus_logtype_bus
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 2b1730afc2..01573927ce 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -23,8 +23,6 @@
 
 #include "private.h"
 
-extern struct rte_vmbus_bus rte_vmbus_bus;
-
 /* map a particular resource from a file */
 void *
 vmbus_map_resource(void *requested_addr, int fd, off_t offset, size_t size,
@@ -128,7 +126,7 @@ RTE_EXPORT_SYMBOL(rte_vmbus_probe)
 int
 rte_vmbus_probe(void)
 {
-	return rte_bus_generic_probe(&rte_vmbus_bus.bus);
+	return rte_bus_generic_probe(&rte_vmbus_bus);
 }
 
 static int
@@ -137,7 +135,7 @@ rte_vmbus_cleanup(void)
 	struct rte_vmbus_device *dev;
 	int error = 0;
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_vmbus_bus.bus) {
+	RTE_BUS_FOREACH_DEV(dev, &rte_vmbus_bus) {
 		const struct rte_vmbus_driver *drv;
 		int ret;
 
@@ -154,7 +152,7 @@ rte_vmbus_cleanup(void)
 		rte_vmbus_unmap_device(dev);
 
 		dev->device.driver = NULL;
-		rte_bus_remove_device(&rte_vmbus_bus.bus, &dev->device);
+		rte_bus_remove_device(&rte_vmbus_bus, &dev->device);
 		free(dev);
 	}
 
@@ -194,7 +192,7 @@ rte_vmbus_register(struct rte_vmbus_driver *driver)
 	VMBUS_LOG(DEBUG,
 		"Registered driver %s", driver->driver.name);
 
-	rte_bus_add_driver(&rte_vmbus_bus.bus, &driver->driver);
+	rte_bus_add_driver(&rte_vmbus_bus, &driver->driver);
 }
 
 /* unregister vmbus driver */
@@ -202,22 +200,20 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_unregister)
 void
 rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 {
-	rte_bus_remove_driver(&rte_vmbus_bus.bus, &driver->driver);
+	rte_bus_remove_driver(&rte_vmbus_bus, &driver->driver);
 }
 
 /* VMBUS doesn't support hotplug */
-struct rte_vmbus_bus rte_vmbus_bus = {
-	.bus = {
-		.scan = rte_vmbus_scan,
-		.probe = rte_bus_generic_probe,
-		.cleanup = rte_vmbus_cleanup,
-		.find_device = rte_bus_generic_find_device,
-		.match = vmbus_bus_match,
-		.probe_device = vmbus_probe_device,
-		.parse = vmbus_parse,
-		.dev_compare = vmbus_dev_compare,
-	},
+struct rte_bus rte_vmbus_bus = {
+	.scan = rte_vmbus_scan,
+	.probe = rte_bus_generic_probe,
+	.cleanup = rte_vmbus_cleanup,
+	.find_device = rte_bus_generic_find_device,
+	.match = vmbus_bus_match,
+	.probe_device = vmbus_probe_device,
+	.parse = vmbus_parse,
+	.dev_compare = vmbus_dev_compare,
 };
 
-RTE_REGISTER_BUS(vmbus, rte_vmbus_bus.bus);
+RTE_REGISTER_BUS(vmbus, rte_vmbus_bus);
 RTE_LOG_REGISTER_DEFAULT(vmbus_logtype_bus, NOTICE);
-- 
2.53.0

