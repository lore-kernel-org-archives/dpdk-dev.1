Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9E6CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:53:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0DFF40696;
	Wed,  6 May 2026 17:53:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 18C2B40689
 for <dev@dpdk.org>; Wed,  6 May 2026 17:53:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778082786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViBEaWSl/4ZjOehzyL/FhIXxBN8IKiPaw+OK2d3iawY=;
 b=XV2C32CAQXL8vIzEH8qMmIRnS1UFFRxxBlEZ2POEyExUhNu+tnGCQBI78xTsVsDXSdSWZ3
 pMhgiptd5vbAk+lRxo9WH6f45zFD2Ufm9NRq7n3p3TXWcKb6bwOwq4M+31wlfLU0Pyfyq8
 LDENHV3I37X/9bzG4iwGtmfkYIHQ8e8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-g5dGaU1hP_2b7KYkOWMnrQ-1; Wed,
 06 May 2026 11:53:01 -0400
X-MC-Unique: g5dGaU1hP_2b7KYkOWMnrQ-1
X-Mimecast-MFC-AGG-ID: g5dGaU1hP_2b7KYkOWMnrQ_1778082778
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9365519560AF; Wed,  6 May 2026 15:52:58 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA0D418004A3; Wed,  6 May 2026 15:52:53 +0000 (UTC)
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
Subject: [PATCH v2 07/23] bus: factorize driver list
Date: Wed,  6 May 2026 17:51:39 +0200
Message-ID: <20260506155201.2709810-8-david.marchand@redhat.com>
In-Reply-To: <20260506155201.2709810-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mYOEIyH72KgpK0PKgPh9cZkxYocObE32__CA3Z7v8JU_1778082778
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

Move driver_list management from individual bus implementations to
common EAL bus code. This eliminates duplication and provides a
consistent API for driver registration across all buses.

Introduce rte_bus_add_driver() and rte_bus_remove_driver() helpers that
manage a per-bus driver list internally in EAL. Update all buses to use
these common helpers and remove bus-specific driver_list fields and
iteration macros.
Store a reference to the bus object in the generic driver.

Also update the dma/idxd code that has only one hardcoded driver.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c     | 11 +++--
 drivers/bus/auxiliary/bus_auxiliary_driver.h |  1 -
 drivers/bus/auxiliary/linux/auxiliary.c      |  3 +-
 drivers/bus/auxiliary/private.h              |  4 --
 drivers/bus/cdx/bus_cdx_driver.h             |  2 -
 drivers/bus/cdx/cdx.c                        | 12 ++----
 drivers/bus/cdx/private.h                    |  1 -
 drivers/bus/dpaa/bus_dpaa_driver.h           |  1 -
 drivers/bus/dpaa/dpaa_bus.c                  |  8 ++--
 drivers/bus/fslmc/bus_fslmc_driver.h         |  1 -
 drivers/bus/fslmc/fslmc_bus.c                | 11 +++--
 drivers/bus/fslmc/private.h                  |  2 -
 drivers/bus/ifpga/bus_ifpga_driver.h         |  3 +-
 drivers/bus/ifpga/ifpga_bus.c                |  9 ++--
 drivers/bus/pci/bus_pci_driver.h             |  1 -
 drivers/bus/pci/pci_common.c                 |  9 ++--
 drivers/bus/pci/private.h                    |  4 --
 drivers/bus/platform/bus_platform_driver.h   |  1 -
 drivers/bus/platform/platform.c              |  9 ++--
 drivers/bus/platform/private.h               |  4 --
 drivers/bus/uacce/bus_uacce_driver.h         |  2 -
 drivers/bus/uacce/uacce.c                    | 12 ++----
 drivers/bus/vdev/bus_vdev_driver.h           |  1 -
 drivers/bus/vdev/vdev.c                      |  9 ++--
 drivers/bus/vmbus/bus_vmbus_driver.h         |  1 -
 drivers/bus/vmbus/private.h                  |  4 --
 drivers/bus/vmbus/vmbus_common.c             |  7 ++--
 drivers/dma/idxd/idxd_bus.c                  |  6 ++-
 lib/eal/common/eal_common_bus.c              | 17 ++++++++
 lib/eal/include/bus_driver.h                 | 44 ++++++++++++++++++++
 lib/eal/include/dev_driver.h                 |  1 +
 31 files changed, 106 insertions(+), 95 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index afb4a7ce1b..7e2d832dda 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -171,7 +171,7 @@ auxiliary_probe_all_drivers(struct rte_auxiliary_device *dev)
 	struct rte_auxiliary_driver *drv;
 	int rc;
 
-	FOREACH_DRIVER_ON_AUXILIARY_BUS(drv) {
+	RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus.bus) {
 		if (!drv->match(dev->name))
 			continue;
 
@@ -226,7 +226,7 @@ auxiliary_parse(const char *name, void *addr)
 	if (strlen(name) == 0)
 		return 0;
 
-	FOREACH_DRIVER_ON_AUXILIARY_BUS(drv) {
+	RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus.bus) {
 		if (drv->match(name))
 			break;
 	}
@@ -240,7 +240,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_register)
 void
 rte_auxiliary_register(struct rte_auxiliary_driver *driver)
 {
-	TAILQ_INSERT_TAIL(&auxiliary_bus.driver_list, driver, next);
+	rte_bus_add_driver(&auxiliary_bus.bus, &driver->driver);
 }
 
 /* Unregister a driver */
@@ -248,7 +248,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_unregister)
 void
 rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 {
-	TAILQ_REMOVE(&auxiliary_bus.driver_list, driver, next);
+	rte_bus_remove_driver(&auxiliary_bus.bus, &driver->driver);
 }
 
 /* Add a device to auxiliary bus */
@@ -369,7 +369,7 @@ auxiliary_get_iommu_class(void)
 {
 	const struct rte_auxiliary_driver *drv;
 
-	FOREACH_DRIVER_ON_AUXILIARY_BUS(drv) {
+	RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus.bus) {
 		if ((drv->drv_flags & RTE_AUXILIARY_DRV_NEED_IOVA_AS_VA) > 0)
 			return RTE_IOVA_VA;
 	}
@@ -392,7 +392,6 @@ struct rte_auxiliary_bus auxiliary_bus = {
 		.dev_iterate = auxiliary_dev_iterate,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(auxiliary_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(auxiliary_bus.driver_list),
 };
 
 RTE_REGISTER_BUS(auxiliary, auxiliary_bus.bus);
diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index 5c14592f6f..59c46e08a0 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -121,7 +121,6 @@ struct rte_auxiliary_device {
  * A structure describing an auxiliary driver.
  */
 struct rte_auxiliary_driver {
-	RTE_TAILQ_ENTRY(rte_auxiliary_driver) next; /**< Next in list. */
 	struct rte_driver driver;             /**< Inherit core driver. */
 	rte_auxiliary_match_t *match;         /**< Device match function. */
 	rte_auxiliary_probe_t *probe;         /**< Device probe function. */
diff --git a/drivers/bus/auxiliary/linux/auxiliary.c b/drivers/bus/auxiliary/linux/auxiliary.c
index 4cfd0a266c..7c430629d0 100644
--- a/drivers/bus/auxiliary/linux/auxiliary.c
+++ b/drivers/bus/auxiliary/linux/auxiliary.c
@@ -117,7 +117,8 @@ auxiliary_scan(void)
 			 AUXILIARY_SYSFS_PATH, e->d_name);
 
 		/* Ignore if no driver can handle. */
-		FOREACH_DRIVER_ON_AUXILIARY_BUS(drv) {
+		drv = NULL;
+		RTE_BUS_FOREACH_DRV(drv, &auxiliary_bus.bus) {
 			if (drv->match(e->d_name))
 				break;
 		}
diff --git a/drivers/bus/auxiliary/private.h b/drivers/bus/auxiliary/private.h
index 6e61a5f494..66ba97b946 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -25,7 +25,6 @@ extern int auxiliary_bus_logtype;
 struct rte_auxiliary_bus {
 	struct rte_bus bus;                  /* Inherit the generic class */
 	TAILQ_HEAD(, rte_auxiliary_device) device_list;  /* List of devices */
-	TAILQ_HEAD(, rte_auxiliary_driver) driver_list;  /* List of drivers */
 };
 
 extern struct rte_auxiliary_bus auxiliary_bus;
@@ -34,9 +33,6 @@ extern struct rte_auxiliary_bus auxiliary_bus;
 #define FOREACH_DEVICE_ON_AUXILIARY_BUS(p) \
 	TAILQ_FOREACH(p, &(auxiliary_bus.device_list), next)
 
-#define FOREACH_DRIVER_ON_AUXILIARY_BUS(p) \
-	TAILQ_FOREACH(p, &(auxiliary_bus.driver_list), next)
-
 /*
  * Test whether the auxiliary device exist.
  */
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index 935e37158a..823a5b1be3 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -91,9 +91,7 @@ typedef int (rte_cdx_remove_t)(struct rte_cdx_device *);
  * A structure describing a CDX driver.
  */
 struct rte_cdx_driver {
-	RTE_TAILQ_ENTRY(rte_cdx_driver) next;	/**< Next in list. */
 	struct rte_driver driver;		/**< Inherit core driver. */
-	struct rte_cdx_bus *bus;		/**< CDX bus reference. */
 	rte_cdx_probe_t *probe;			/**< Device probe function. */
 	rte_cdx_remove_t *remove;		/**< Device remove function. */
 	const struct rte_cdx_id *id_table;	/**< ID table, NULL terminated. */
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 267c7598c7..5973f75be2 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -88,9 +88,6 @@
 #define FOREACH_DEVICE_ON_CDXBUS(p)	\
 		RTE_TAILQ_FOREACH(p, &rte_cdx_bus.device_list, next)
 
-#define FOREACH_DRIVER_ON_CDXBUS(p)	\
-		RTE_TAILQ_FOREACH(p, &rte_cdx_bus.driver_list, next)
-
 struct rte_cdx_bus rte_cdx_bus;
 
 enum cdx_params {
@@ -394,7 +391,7 @@ cdx_probe_all_drivers(struct rte_cdx_device *dev)
 	struct rte_cdx_driver *dr = NULL;
 	int rc = 0;
 
-	FOREACH_DRIVER_ON_CDXBUS(dr) {
+	RTE_BUS_FOREACH_DRV(dr, &rte_cdx_bus.bus) {
 		rc = cdx_probe_one_driver(dr, dev);
 		if (rc < 0)
 			/* negative value is an error */
@@ -453,8 +450,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_register)
 void
 rte_cdx_register(struct rte_cdx_driver *driver)
 {
-	TAILQ_INSERT_TAIL(&rte_cdx_bus.driver_list, driver, next);
-	driver->bus = &rte_cdx_bus;
+	rte_bus_add_driver(&rte_cdx_bus.bus, &driver->driver);
 }
 
 /* unregister a driver */
@@ -462,8 +458,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_unregister)
 void
 rte_cdx_unregister(struct rte_cdx_driver *driver)
 {
-	TAILQ_REMOVE(&rte_cdx_bus.driver_list, driver, next);
-	driver->bus = NULL;
+	rte_bus_remove_driver(&rte_cdx_bus.bus, &driver->driver);
 }
 
 static struct rte_device *
@@ -630,7 +625,6 @@ struct rte_cdx_bus rte_cdx_bus = {
 		.dev_iterate = cdx_dev_iterate,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(rte_cdx_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(rte_cdx_bus.driver_list),
 };
 
 RTE_REGISTER_BUS(cdx, rte_cdx_bus.bus);
diff --git a/drivers/bus/cdx/private.h b/drivers/bus/cdx/private.h
index 81987d0cfe..3807a17bfb 100644
--- a/drivers/bus/cdx/private.h
+++ b/drivers/bus/cdx/private.h
@@ -13,7 +13,6 @@
 struct rte_cdx_bus {
 	struct rte_bus bus;				/**< Inherit the generic class */
 	RTE_TAILQ_HEAD(, rte_cdx_device) device_list;	/**< List of CDX devices */
-	RTE_TAILQ_HEAD(, rte_cdx_driver) driver_list;	/**< List of CDX drivers */
 };
 
 /**
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 64cbfd8e92..1575ed19e7 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -98,7 +98,6 @@ typedef int (*rte_dpaa_probe_t)(struct rte_dpaa_driver *dpaa_drv,
 typedef int (*rte_dpaa_remove_t)(struct rte_dpaa_device *dpaa_dev);
 
 struct rte_dpaa_driver {
-	TAILQ_ENTRY(rte_dpaa_driver) next;
 	struct rte_driver driver;
 	enum rte_dpaa_type drv_type;
 	rte_dpaa_probe_t probe;
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index ca6fd06ac0..f9f902cbd6 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -60,7 +60,6 @@
 struct rte_dpaa_bus {
 	struct rte_bus bus;
 	TAILQ_HEAD(, rte_dpaa_device) device_list;
-	TAILQ_HEAD(, rte_dpaa_driver) driver_list;
 	int device_count;
 	int detected;
 	uint32_t svr_ver;
@@ -618,7 +617,7 @@ rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
 
 	BUS_INIT_FUNC_TRACE();
 
-	TAILQ_INSERT_TAIL(&rte_dpaa_bus.driver_list, driver, next);
+	rte_bus_add_driver(&rte_dpaa_bus.bus, &driver->driver);
 }
 
 /* un-register a dpaa bus based dpaa driver */
@@ -628,7 +627,7 @@ rte_dpaa_driver_unregister(struct rte_dpaa_driver *driver)
 {
 	BUS_INIT_FUNC_TRACE();
 
-	TAILQ_REMOVE(&rte_dpaa_bus.driver_list, driver, next);
+	rte_bus_remove_driver(&rte_dpaa_bus.bus, &driver->driver);
 }
 
 static int
@@ -797,7 +796,7 @@ rte_dpaa_bus_probe(void)
 
 	/* For each registered driver, and device, call the driver->probe */
 	TAILQ_FOREACH(dev, &rte_dpaa_bus.device_list, next) {
-		TAILQ_FOREACH(drv, &rte_dpaa_bus.driver_list, next) {
+		RTE_BUS_FOREACH_DRV(drv, &rte_dpaa_bus.bus) {
 			ret = rte_dpaa_device_match(drv, dev);
 			if (ret)
 				continue;
@@ -990,7 +989,6 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 	},
 	.max_push_rxq_num = DPAA_DEFAULT_PUSH_MODE_QUEUE,
 	.device_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.driver_list),
 	.device_count = 0,
 };
 
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 51bca8a6ef..c82b182720 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -138,7 +138,6 @@ rte_fslmc_vfio_mem_dmaunmap(uint64_t iova, uint64_t size);
  * A structure describing a DPAA2 driver.
  */
 struct rte_dpaa2_driver {
-	TAILQ_ENTRY(rte_dpaa2_driver) next; /**< Next in list. */
 	struct rte_driver driver;           /**< Inherit core driver. */
 	uint32_t drv_flags;                 /**< Flags for controlling device.*/
 	enum rte_dpaa2_dev_type drv_type;   /**< Driver Type */
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 59c9d85bb8..36ec018785 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -457,7 +457,7 @@ rte_fslmc_probe(void)
 	}
 
 	TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next) {
-		TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
+		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
 			ret = rte_fslmc_match(drv, dev);
 			if (ret)
 				continue;
@@ -522,7 +522,7 @@ rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
 	RTE_VERIFY(driver);
 	RTE_VERIFY(driver->probe != NULL);
 
-	TAILQ_INSERT_TAIL(&rte_fslmc_bus.driver_list, driver, next);
+	rte_bus_add_driver(&rte_fslmc_bus.bus, &driver->driver);
 }
 
 /*un-register a fslmc bus based dpaa2 driver */
@@ -530,7 +530,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_unregister)
 void
 rte_fslmc_driver_unregister(struct rte_dpaa2_driver *driver)
 {
-	TAILQ_REMOVE(&rte_fslmc_bus.driver_list, driver, next);
+	rte_bus_remove_driver(&rte_fslmc_bus.bus, &driver->driver);
 }
 
 /*
@@ -544,7 +544,7 @@ fslmc_all_device_support_iova(void)
 	struct rte_dpaa2_driver *drv;
 
 	TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next) {
-		TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
+		RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
 			ret = rte_fslmc_match(drv, dev);
 			if (ret)
 				continue;
@@ -582,7 +582,7 @@ fslmc_bus_plug(struct rte_device *rte_dev)
 	struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 	struct rte_dpaa2_driver *drv;
 
-	TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
+	RTE_BUS_FOREACH_DRV(drv, &rte_fslmc_bus.bus) {
 		ret = rte_fslmc_match(drv, dev);
 		if (ret)
 			continue;
@@ -688,7 +688,6 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 		.dev_iterate = fslmc_bus_dev_iterate,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(rte_fslmc_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(rte_fslmc_bus.driver_list),
 	.device_count = {0},
 };
 
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index 6f14085d98..338f55b094 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -16,8 +16,6 @@ struct rte_fslmc_bus {
 	struct rte_bus bus;     /**< Generic Bus object */
 	TAILQ_HEAD(, rte_dpaa2_device) device_list;
 				/**< FSLMC DPAA2 Device list */
-	TAILQ_HEAD(, rte_dpaa2_driver) driver_list;
-				/**< FSLMC DPAA2 Driver list */
 	int device_count[DPAA2_DEVTYPE_MAX];
 				/**< Count of all devices scanned */
 };
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index b0ba8c9e64..7d724dc1a0 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -91,10 +91,9 @@ typedef int (afu_probe_t)(struct rte_afu_device *);
 typedef int (afu_remove_t)(struct rte_afu_device *);
 
 /**
- * A structure describing a AFU device.
+ * A structure describing a AFU driver.
  */
 struct rte_afu_driver {
-	RTE_TAILQ_ENTRY(rte_afu_driver) next;   /**< Next afu driver. */
 	struct rte_driver driver;               /**< Inherit core driver. */
 	afu_probe_t *probe;                     /**< Device Probe function. */
 	afu_remove_t *remove;                   /**< Device Remove function. */
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 63f6a01cde..c038144ebd 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -40,9 +40,6 @@ static struct rte_bus rte_ifpga_bus;
 
 static TAILQ_HEAD(, rte_afu_device) ifpga_afu_dev_list =
 	TAILQ_HEAD_INITIALIZER(ifpga_afu_dev_list);
-static TAILQ_HEAD(, rte_afu_driver) ifpga_afu_drv_list =
-	TAILQ_HEAD_INITIALIZER(ifpga_afu_drv_list);
-
 
 /* register a ifpga bus based driver */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_register)
@@ -50,14 +47,14 @@ void rte_ifpga_driver_register(struct rte_afu_driver *driver)
 {
 	RTE_VERIFY(driver);
 
-	TAILQ_INSERT_TAIL(&ifpga_afu_drv_list, driver, next);
+	rte_bus_add_driver(&rte_ifpga_bus, &driver->driver);
 }
 
 /* un-register a fpga bus based driver */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_unregister)
 void rte_ifpga_driver_unregister(struct rte_afu_driver *driver)
 {
-	TAILQ_REMOVE(&ifpga_afu_drv_list, driver, next);
+	rte_bus_remove_driver(&rte_ifpga_bus, &driver->driver);
 }
 
 static struct rte_afu_device *
@@ -309,7 +306,7 @@ ifpga_probe_all_drivers(struct rte_afu_device *afu_dev)
 		return -EEXIST;
 	}
 
-	TAILQ_FOREACH(drv, &ifpga_afu_drv_list, next) {
+	RTE_BUS_FOREACH_DRV(drv, &rte_ifpga_bus) {
 		ret = ifpga_probe_one_driver(drv, afu_dev);
 		if (ret < 0)
 			/* negative value is an error */
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index 22ab962f05..993d690f96 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -122,7 +122,6 @@ typedef int (pci_dma_unmap_t)(struct rte_pci_device *dev, void *addr,
  * A structure describing a PCI driver.
  */
 struct rte_pci_driver {
-	RTE_TAILQ_ENTRY(rte_pci_driver) next;  /**< Next in list. */
 	struct rte_driver driver;          /**< Inherit core driver. */
 	rte_pci_probe_t *probe;            /**< Device probe function. */
 	rte_pci_remove_t *remove;          /**< Device remove function. */
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index f3d7878966..79cc14a6dd 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -358,7 +358,7 @@ pci_probe_all_drivers(struct rte_pci_device *dev)
 	if (dev == NULL)
 		return -EINVAL;
 
-	FOREACH_DRIVER_ON_PCIBUS(dr) {
+	RTE_BUS_FOREACH_DRV(dr, &rte_pci_bus.bus) {
 		rc = rte_pci_probe_one_driver(dr, dev);
 		if (rc < 0)
 			/* negative value is an error */
@@ -501,7 +501,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_register)
 void
 rte_pci_register(struct rte_pci_driver *driver)
 {
-	TAILQ_INSERT_TAIL(&rte_pci_bus.driver_list, driver, next);
+	rte_bus_add_driver(&rte_pci_bus.bus, &driver->driver);
 }
 
 /* unregister a driver */
@@ -509,7 +509,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_unregister)
 void
 rte_pci_unregister(struct rte_pci_driver *driver)
 {
-	TAILQ_REMOVE(&rte_pci_bus.driver_list, driver, next);
+	rte_bus_remove_driver(&rte_pci_bus.bus, &driver->driver);
 }
 
 /* Add a device to PCI bus */
@@ -720,7 +720,7 @@ rte_pci_get_iommu_class(void)
 		if (dev->kdrv == RTE_PCI_KDRV_UNKNOWN ||
 		    dev->kdrv == RTE_PCI_KDRV_NONE)
 			continue;
-		FOREACH_DRIVER_ON_PCIBUS(drv) {
+		RTE_BUS_FOREACH_DRV(drv, &rte_pci_bus.bus) {
 			enum rte_iova_mode dev_iova_mode;
 
 			if (!rte_pci_match(drv, dev))
@@ -917,7 +917,6 @@ struct rte_pci_bus rte_pci_bus = {
 		.sigbus_handler = pci_sigbus_handler,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(rte_pci_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(rte_pci_bus.driver_list),
 };
 
 RTE_REGISTER_BUS(pci, rte_pci_bus.bus);
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index 8591c4a0a7..8b5f563dc3 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -35,7 +35,6 @@ extern int pci_bus_logtype;
 struct rte_pci_bus {
 	struct rte_bus bus;               /**< Inherit the generic class */
 	RTE_TAILQ_HEAD(, rte_pci_device) device_list; /**< List of PCI devices */
-	RTE_TAILQ_HEAD(, rte_pci_driver) driver_list; /**< List of PCI drivers */
 };
 
 extern struct rte_pci_bus rte_pci_bus;
@@ -44,9 +43,6 @@ extern struct rte_pci_bus rte_pci_bus;
 #define FOREACH_DEVICE_ON_PCIBUS(p)	\
 	RTE_TAILQ_FOREACH(p, &(rte_pci_bus.device_list), next)
 
-#define FOREACH_DRIVER_ON_PCIBUS(p)	\
-	RTE_TAILQ_FOREACH(p, &(rte_pci_bus.driver_list), next)
-
 struct rte_pci_driver;
 struct rte_pci_device;
 
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index 09eb08e347..a72d5c00a3 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -107,7 +107,6 @@ struct rte_platform_device {
  * A structure describing a platform device driver.
  */
 struct rte_platform_driver {
-	RTE_TAILQ_ENTRY(rte_platform_driver) next; /**< Next available platform driver */
 	struct rte_driver driver; /**< Core driver */
 	rte_platform_probe_t *probe;  /**< Device probe function */
 	rte_platform_remove_t *remove; /**< Device remove function */
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 0e57473f25..9d3c4877b0 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -33,14 +33,14 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_register)
 void
 rte_platform_register(struct rte_platform_driver *pdrv)
 {
-	TAILQ_INSERT_TAIL(&platform_bus.driver_list, pdrv, next);
+	rte_bus_add_driver(&platform_bus.bus, &pdrv->driver);
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_unregister)
 void
 rte_platform_unregister(struct rte_platform_driver *pdrv)
 {
-	TAILQ_REMOVE(&platform_bus.driver_list, pdrv, next);
+	rte_bus_remove_driver(&platform_bus.bus, &pdrv->driver);
 }
 
 static int
@@ -408,7 +408,7 @@ device_attach(struct rte_platform_device *pdev)
 {
 	struct rte_platform_driver *pdrv;
 
-	FOREACH_DRIVER_ON_PLATFORM_BUS(pdrv) {
+	RTE_BUS_FOREACH_DRV(pdrv, &platform_bus.bus) {
 		if (driver_match_device(pdrv, pdev))
 			break;
 	}
@@ -510,7 +510,7 @@ platform_bus_parse(const char *name, void *addr)
 
 	rte_strscpy(pdev.name, name, sizeof(pdev.name));
 
-	FOREACH_DRIVER_ON_PLATFORM_BUS(pdrv) {
+	RTE_BUS_FOREACH_DRV(pdrv, &platform_bus.bus) {
 		if (driver_match_device(pdrv, &pdev))
 			break;
 	}
@@ -589,7 +589,6 @@ struct rte_platform_bus platform_bus = {
 		.cleanup = platform_bus_cleanup,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(platform_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(platform_bus.driver_list),
 };
 
 RTE_REGISTER_BUS(platform, platform_bus.bus);
diff --git a/drivers/bus/platform/private.h b/drivers/bus/platform/private.h
index d89ba0e4a5..f7ee80f3ac 100644
--- a/drivers/bus/platform/private.h
+++ b/drivers/bus/platform/private.h
@@ -20,16 +20,12 @@ extern struct rte_platform_bus platform_bus;
 #define FOREACH_DEVICE_ON_PLATFORM_BUS(p) \
 	RTE_TAILQ_FOREACH(p, &(platform_bus.device_list), next)
 
-#define FOREACH_DRIVER_ON_PLATFORM_BUS(p) \
-	RTE_TAILQ_FOREACH(p, &(platform_bus.driver_list), next)
-
 /*
  * Structure describing platform bus.
  */
 struct rte_platform_bus {
 	struct rte_bus bus; /* Core bus */
 	RTE_TAILQ_HEAD(, rte_platform_device) device_list; /* List of bus devices */
-	RTE_TAILQ_HEAD(, rte_platform_driver) driver_list; /* List of bus drivers */
 };
 
 extern int platform_bus_logtype;
diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index 476afbc857..051e1736cf 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -85,9 +85,7 @@ typedef int (rte_uacce_remove_t)(struct rte_uacce_device *);
  * A structure describing a UACCE driver.
  */
 struct rte_uacce_driver {
-	RTE_TAILQ_ENTRY(rte_uacce_driver) next;	/**< Next in list. */
 	struct rte_driver driver;               /**< Inherit core driver. */
-	struct rte_uacce_bus *bus;              /**< UACCE bus reference. */
 	rte_uacce_probe_t *probe;               /**< Device probe function. */
 	rte_uacce_remove_t *remove;             /**< Device remove function. */
 	const struct rte_uacce_id *id_table;    /**< ID table, NULL terminated. */
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 6e1eb73e68..c0a1e1d8ec 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -40,7 +40,6 @@
 struct rte_uacce_bus {
 	struct rte_bus bus;		            /* Inherit the generic class. */
 	TAILQ_HEAD(, rte_uacce_device) device_list; /* List of devices. */
-	TAILQ_HEAD(, rte_uacce_driver) driver_list; /* List of drivers. */
 };
 
 /* Forward declaration of UACCE bus. */
@@ -57,8 +56,6 @@ static const char *const uacce_params_keys[] = {
 
 #define FOREACH_DEVICE_ON_UACCEBUS(p)	\
 		RTE_TAILQ_FOREACH(p, &uacce_bus.device_list, next)
-#define FOREACH_DRIVER_ON_UACCEBUS(p)	\
-		RTE_TAILQ_FOREACH(p, &uacce_bus.driver_list, next)
 
 extern int uacce_bus_logtype;
 #define RTE_LOGTYPE_UACCE_BUS uacce_bus_logtype
@@ -407,7 +404,7 @@ uacce_probe_all_drivers(struct rte_uacce_device *dev)
 	struct rte_uacce_driver *dr;
 	int rc;
 
-	FOREACH_DRIVER_ON_UACCEBUS(dr) {
+	RTE_BUS_FOREACH_DRV(dr, &uacce_bus.bus) {
 		rc = uacce_probe_one_driver(dr, dev);
 		if (rc < 0)
 			/* negative value is an error */
@@ -689,16 +686,14 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_register)
 void
 rte_uacce_register(struct rte_uacce_driver *driver)
 {
-	TAILQ_INSERT_TAIL(&uacce_bus.driver_list, driver, next);
-	driver->bus = &uacce_bus;
+	rte_bus_add_driver(&uacce_bus.bus, &driver->driver);
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_unregister)
 void
 rte_uacce_unregister(struct rte_uacce_driver *driver)
 {
-	TAILQ_REMOVE(&uacce_bus.driver_list, driver, next);
-	driver->bus = NULL;
+	rte_bus_remove_driver(&uacce_bus.bus, &driver->driver);
 }
 
 static struct rte_uacce_bus uacce_bus = {
@@ -713,7 +708,6 @@ static struct rte_uacce_bus uacce_bus = {
 		.dev_iterate = uacce_dev_iterate,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(uacce_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(uacce_bus.driver_list),
 };
 
 RTE_REGISTER_BUS(uacce, uacce_bus.bus);
diff --git a/drivers/bus/vdev/bus_vdev_driver.h b/drivers/bus/vdev/bus_vdev_driver.h
index f352daabda..eceaa56696 100644
--- a/drivers/bus/vdev/bus_vdev_driver.h
+++ b/drivers/bus/vdev/bus_vdev_driver.h
@@ -91,7 +91,6 @@ typedef int (rte_vdev_dma_unmap_t)(struct rte_vdev_device *dev, void *addr,
  * A virtual device driver abstraction.
  */
 struct rte_vdev_driver {
-	RTE_TAILQ_ENTRY(rte_vdev_driver) next; /**< Next in list. */
 	struct rte_driver driver;        /**< Inherited general driver. */
 	rte_vdev_probe_t *probe;         /**< Virtual device probe function. */
 	rte_vdev_remove_t *remove;       /**< Virtual device remove function. */
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index ea81b755e3..c360c38ed5 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -38,9 +38,6 @@ static TAILQ_HEAD(, rte_vdev_device) vdev_device_list =
 static rte_spinlock_recursive_t vdev_device_list_lock =
 	RTE_SPINLOCK_RECURSIVE_INITIALIZER;
 
-static TAILQ_HEAD(, rte_vdev_driver) vdev_driver_list =
-	TAILQ_HEAD_INITIALIZER(vdev_driver_list);
-
 struct vdev_custom_scan {
 	TAILQ_ENTRY(vdev_custom_scan) next;
 	rte_vdev_scan_callback callback;
@@ -56,7 +53,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_vdev_register)
 void
 rte_vdev_register(struct rte_vdev_driver *driver)
 {
-	TAILQ_INSERT_TAIL(&vdev_driver_list, driver, next);
+	rte_bus_add_driver(&rte_vdev_bus, &driver->driver);
 }
 
 /* unregister a driver */
@@ -64,7 +61,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_vdev_unregister)
 void
 rte_vdev_unregister(struct rte_vdev_driver *driver)
 {
-	TAILQ_REMOVE(&vdev_driver_list, driver, next);
+	rte_bus_remove_driver(&rte_vdev_bus, &driver->driver);
 }
 
 RTE_EXPORT_SYMBOL(rte_vdev_add_custom_scan)
@@ -123,7 +120,7 @@ vdev_parse(const char *name, void *addr)
 	struct rte_vdev_driver **out = addr;
 	struct rte_vdev_driver *driver = NULL;
 
-	TAILQ_FOREACH(driver, &vdev_driver_list, next) {
+	RTE_BUS_FOREACH_DRV(driver, &rte_vdev_bus) {
 		if (strncmp(driver->driver.name, name,
 			    strlen(driver->driver.name)) == 0)
 			break;
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index fca512db31..4a06ff8e66 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -68,7 +68,6 @@ typedef int (vmbus_remove_t)(struct rte_vmbus_device *);
  * A structure describing a VMBUS driver.
  */
 struct rte_vmbus_driver {
-	RTE_TAILQ_ENTRY(rte_vmbus_driver) next; /**< Next in list. */
 	struct rte_driver driver;
 	vmbus_probe_t *probe;               /**< Device Probe function. */
 	vmbus_remove_t *remove;             /**< Device Remove function. */
diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index 8ac6119ef2..bd1151385c 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -21,7 +21,6 @@
 struct rte_vmbus_bus {
 	struct rte_bus bus;               /**< Inherit the generic class */
 	RTE_TAILQ_HEAD(, rte_vmbus_device) device_list; /**< List of devices */
-	RTE_TAILQ_HEAD(, rte_vmbus_driver) driver_list; /**< List of drivers */
 };
 
 extern struct rte_vmbus_bus rte_vmbus_bus;
@@ -30,9 +29,6 @@ extern struct rte_vmbus_bus rte_vmbus_bus;
 #define FOREACH_DEVICE_ON_VMBUS(p)	\
 	RTE_TAILQ_FOREACH(p, &(rte_vmbus_bus.device_list), next)
 
-#define FOREACH_DRIVER_ON_VMBUS(p)	\
-	RTE_TAILQ_FOREACH(p, &(rte_vmbus_bus.driver_list), next)
-
 extern int vmbus_logtype_bus;
 #define RTE_LOGTYPE_VMBUS_BUS vmbus_logtype_bus
 #define VMBUS_LOG(level, ...) \
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index d38c75d597..a414f0a892 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -155,7 +155,7 @@ vmbus_probe_all_drivers(struct rte_vmbus_device *dev)
 		return 0;
 	}
 
-	FOREACH_DRIVER_ON_VMBUS(dr) {
+	RTE_BUS_FOREACH_DRV(dr, &rte_vmbus_bus.bus) {
 		rc = vmbus_probe_one_driver(dr, dev);
 		if (rc < 0) /* negative is an error */
 			return -1;
@@ -263,7 +263,7 @@ rte_vmbus_register(struct rte_vmbus_driver *driver)
 	VMBUS_LOG(DEBUG,
 		"Registered driver %s", driver->driver.name);
 
-	TAILQ_INSERT_TAIL(&rte_vmbus_bus.driver_list, driver, next);
+	rte_bus_add_driver(&rte_vmbus_bus.bus, &driver->driver);
 }
 
 /* unregister vmbus driver */
@@ -271,7 +271,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_unregister)
 void
 rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 {
-	TAILQ_REMOVE(&rte_vmbus_bus.driver_list, driver, next);
+	rte_bus_remove_driver(&rte_vmbus_bus.bus, &driver->driver);
 }
 
 /* Add a device to VMBUS bus */
@@ -326,7 +326,6 @@ struct rte_vmbus_bus rte_vmbus_bus = {
 		.dev_compare = vmbus_dev_compare,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(rte_vmbus_bus.device_list),
-	.driver_list = TAILQ_HEAD_INITIALIZER(rte_vmbus_bus.driver_list),
 };
 
 RTE_REGISTER_BUS(vmbus, rte_vmbus_bus.bus);
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 291cd6c707..7f4920b274 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -70,7 +70,7 @@ struct dsa_bus dsa_bus = {
 		.parse = dsa_addr_parse,
 	},
 	.driver = {
-		.name = "dmadev_idxd"
+		.name = "dmadev_idxd",
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(dsa_bus.device_list),
 };
@@ -392,3 +392,7 @@ dsa_addr_parse(const char *name, void *addr)
 }
 
 RTE_REGISTER_BUS(dsa, dsa_bus.bus);
+RTE_INIT(dsa_bus_init)
+{
+	rte_bus_add_driver(&dsa_bus.bus, &dsa_bus.driver);
+}
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index b33f5b4bf4..e155936014 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -38,6 +38,7 @@ rte_bus_register(struct rte_bus *bus)
 	/* Buses supporting driver plug also require unplug. */
 	RTE_VERIFY(!bus->plug || bus->unplug);
 
+	TAILQ_INIT(&bus->driver_list);
 	TAILQ_INSERT_TAIL(&rte_bus_list, bus, next);
 	EAL_LOG(DEBUG, "Registered [%s] bus.", rte_bus_name(bus));
 }
@@ -369,3 +370,19 @@ rte_bus_sigbus_handler(const void *failure_addr)
 
 	return ret;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_add_driver)
+void
+rte_bus_add_driver(struct rte_bus *bus, struct rte_driver *driver)
+{
+	TAILQ_INSERT_TAIL(&bus->driver_list, driver, next);
+	driver->bus = bus;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_remove_driver)
+void
+rte_bus_remove_driver(struct rte_bus *bus, struct rte_driver *driver)
+{
+	TAILQ_REMOVE(&bus->driver_list, driver, next);
+	driver->bus = NULL;
+}
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 71346fb8b2..3c8f661a17 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -286,6 +286,7 @@ struct rte_bus {
 	rte_bus_sigbus_handler_t sigbus_handler;
 					/**< handle sigbus error on the bus */
 	rte_bus_cleanup_t cleanup;   /**< Cleanup devices on bus */
+	RTE_TAILQ_HEAD(, rte_driver) driver_list; /**< List of drivers on the bus */
 };
 
 /**
@@ -370,6 +371,49 @@ void rte_bus_unregister(struct rte_bus *bus);
 #define RTE_BUS_DRIVER(drv, bus_drv_type) \
 	container_of(drv, typeof(bus_drv_type), driver)
 
+/**
+ * Helper macro to iterate over all drivers on a bus.
+ *
+ * @param drv
+ *   Variable name for the bus-specific driver pointer.
+ * @param bus
+ *   Pointer to the bus structure.
+ *
+ * Example:
+ *   struct rte_pci_driver *pci_drv;
+ *   RTE_BUS_FOREACH_DRV(pci_drv, &pci_bus.bus) {
+ *       // Use pci_drv here
+ *   }
+ */
+#define RTE_BUS_FOREACH_DRV(drv, bus) \
+	for (struct rte_driver *__rte_drv = TAILQ_FIRST(&(bus)->driver_list), *__rte_drv_tmp; \
+			(__rte_drv != NULL && ((drv) = RTE_BUS_DRIVER(__rte_drv, *drv), \
+				__rte_drv_tmp = TAILQ_NEXT(__rte_drv, next), 1)) || \
+			(drv = NULL, 0); \
+			__rte_drv = __rte_drv_tmp)
+
+/**
+ * Add a driver to the bus driver list.
+ *
+ * @param bus
+ *   A pointer to a rte_bus structure.
+ * @param driver
+ *   A pointer to a rte_driver structure to add.
+ */
+__rte_internal
+void rte_bus_add_driver(struct rte_bus *bus, struct rte_driver *driver);
+
+/**
+ * Remove a driver from the bus driver list.
+ *
+ * @param bus
+ *   A pointer to a rte_bus structure.
+ * @param driver
+ *   A pointer to a rte_driver structure to remove.
+ */
+__rte_internal
+void rte_bus_remove_driver(struct rte_bus *bus, struct rte_driver *driver);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/eal/include/dev_driver.h b/lib/eal/include/dev_driver.h
index a2517ac1d4..2052e3ecb2 100644
--- a/lib/eal/include/dev_driver.h
+++ b/lib/eal/include/dev_driver.h
@@ -15,6 +15,7 @@ struct rte_driver {
 	RTE_TAILQ_ENTRY(rte_driver) next; /**< Next in list. */
 	const char *name;                   /**< Driver name. */
 	const char *alias;              /**< Driver alias. */
+	const struct rte_bus *bus;      /**< Bus reference. */
 };
 
 /**
-- 
2.53.0

