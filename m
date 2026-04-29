Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56218FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 293A740670;
	Wed, 29 Apr 2026 13:45:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E45134065E
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YS5/i86U9/qOor6r8Ca+bnbjXny2WKXhNY8pWgUMKIg=;
 b=Br0zeHdxsuZ1SVJlG2us77x6gFsV3/R2+f+Xo0EOApOIvzxxa0ReHvUy3vVSAQ0zeS+5Sj
 0owUvNZUg9TdVWAkwbZNqnRZoSNs69M09YK0nGqeuRoLZ4XFKXcNJLkfSbj91l8AXew3ex
 DLkmSqV3zNSMt6xLVZFWc7bTxNKE3BU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-IbhGo5MiNaCcCFvDBcS2MQ-1; Wed,
 29 Apr 2026 07:45:37 -0400
X-MC-Unique: IbhGo5MiNaCcCFvDBcS2MQ-1
X-Mimecast-MFC-AGG-ID: IbhGo5MiNaCcCFvDBcS2MQ_1777463135
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BE9B1956080; Wed, 29 Apr 2026 11:45:35 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E2F2300019F; Wed, 29 Apr 2026 11:45:29 +0000 (UTC)
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
 Wei Hu <weh@microsoft.com>
Subject: [PATCH 04/23] drivers/bus: remove device and driver checks in unplug
Date: Wed, 29 Apr 2026 13:44:37 +0200
Message-ID: <20260429114503.932575-5-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EsXcwPCLMnyNpy8IVS_ITW6YCvLFaKVPpU0d4lLhJro_1777463135
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

rte_dev_remove() checks if a device is probed before calling the bus
unplug operation. Individual bus detach/remove functions checking that
dev->driver is non-NULL are therefore redundant.

However, when the unplug operation is called at bus cleanup, care must
be taken that devices are in probed state, so some check on
rte_dev_is_probed() must be added.

The device parameter passed to bus unplug operations cannot be NULL as
the caller already dereferenced the bus structure to invoke these
operations.
The driver reference in the bus-specific device cannot be NULL since
calling the .unplug is done after dereferencing this pointer.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 14 ++++--------
 drivers/bus/cdx/cdx.c                    | 12 +++-------
 drivers/bus/dpaa/dpaa_bus.c              |  2 +-
 drivers/bus/fslmc/fslmc_bus.c            |  2 +-
 drivers/bus/ifpga/ifpga_bus.c            | 29 ++++--------------------
 drivers/bus/pci/pci_common.c             | 19 +++++-----------
 drivers/bus/platform/platform.c          | 13 ++++-------
 drivers/bus/uacce/uacce.c                | 13 +++++------
 drivers/bus/vdev/vdev.c                  |  4 ++--
 drivers/bus/vmbus/vmbus_common.c         |  4 +++-
 10 files changed, 36 insertions(+), 76 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 9690687600..1fe0cb4d78 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -144,16 +144,9 @@ rte_auxiliary_probe_one_driver(struct rte_auxiliary_driver *drv,
 static int
 rte_auxiliary_driver_remove_dev(struct rte_auxiliary_device *dev)
 {
-	struct rte_auxiliary_driver *drv;
+	struct rte_auxiliary_driver *drv = dev->driver;
 	int ret = 0;
 
-	if (dev == NULL)
-		return -EINVAL;
-
-	drv = dev->driver;
-	if (drv == NULL)
-		return 0;
-
 	AUXILIARY_LOG(DEBUG, "Driver %s remove auxiliary device %s on NUMA node %i",
 		      drv->driver.name, dev->name, dev->device.numa_node);
 
@@ -318,10 +311,9 @@ auxiliary_plug(struct rte_device *dev)
 static int
 auxiliary_unplug(struct rte_device *dev)
 {
-	struct rte_auxiliary_device *adev;
+	struct rte_auxiliary_device *adev = RTE_DEV_TO_AUXILIARY(dev);
 	int ret;
 
-	adev = RTE_DEV_TO_AUXILIARY(dev);
 	ret = rte_auxiliary_driver_remove_dev(adev);
 	if (ret == 0) {
 		rte_auxiliary_remove_device(adev);
@@ -341,6 +333,8 @@ auxiliary_cleanup(void)
 	RTE_TAILQ_FOREACH_SAFE(dev, &auxiliary_bus.device_list, next, tmp_dev) {
 		int ret;
 
+		if (!rte_dev_is_probed(&dev->device))
+			continue;
 		ret = auxiliary_unplug(&dev->device);
 		if (ret < 0) {
 			rte_errno = errno;
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 9bc41d9980..f498b747e2 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -501,18 +501,13 @@ cdx_remove_device(struct rte_cdx_device *cdx_dev)
 static int
 cdx_detach_dev(struct rte_cdx_device *dev)
 {
-	struct rte_cdx_driver *dr;
+	struct rte_cdx_driver *dr = dev->driver;
 	int ret = 0;
 
-	if (dev == NULL)
-		return -EINVAL;
-
-	dr = dev->driver;
-
 	CDX_BUS_DEBUG("detach device %s using driver: %s",
 		dev->device.name, dr->driver.name);
 
-	if (dr->remove) {
+	if (dr->remove != NULL) {
 		ret = dr->remove(dev);
 		if (ret < 0)
 			return ret;
@@ -539,10 +534,9 @@ cdx_plug(struct rte_device *dev)
 static int
 cdx_unplug(struct rte_device *dev)
 {
-	struct rte_cdx_device *cdx_dev;
+	struct rte_cdx_device *cdx_dev = RTE_DEV_TO_CDX_DEV(dev);
 	int ret;
 
-	cdx_dev = RTE_DEV_TO_CDX_DEV(dev);
 	ret = cdx_detach_dev(cdx_dev);
 	if (ret == 0) {
 		cdx_remove_device(cdx_dev);
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 1d12f2dceb..1bfc44155d 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -938,7 +938,7 @@ dpaa_bus_cleanup(void)
 
 		if (!rte_dev_is_probed(&dev->device))
 			continue;
-		if (!drv || !drv->remove)
+		if (drv->remove == NULL)
 			continue;
 		ret = drv->remove(dev);
 		if (ret < 0) {
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index cf881b3eec..7e5a3e947e 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -619,7 +619,7 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 			struct rte_dpaa2_device, device);
 	struct rte_dpaa2_driver *drv = dev->driver;
 
-	if (drv && drv->remove) {
+	if (drv->remove != NULL) {
 		drv->remove(dev);
 		dev->driver = NULL;
 		dev->device.driver = NULL;
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 5cc1207c46..fc5308b6f4 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -365,7 +365,9 @@ ifpga_cleanup(void)
 		struct rte_afu_driver *drv = afu_dev->driver;
 		int ret = 0;
 
-		if (drv == NULL || drv->remove == NULL)
+		if (!rte_dev_is_probed(&afu_dev->device))
+			goto free;
+		if (drv->remove == NULL)
 			goto free;
 
 		ret = drv->remove(afu_dev);
@@ -392,34 +394,13 @@ ifpga_plug(struct rte_device *dev)
 	return ifpga_probe_all_drivers(RTE_DEV_TO_AFU(dev));
 }
 
-static int
-ifpga_remove_driver(struct rte_afu_device *afu_dev)
-{
-	const char *name;
-
-	name = rte_ifpga_device_name(afu_dev);
-	if (afu_dev->driver == NULL) {
-		IFPGA_BUS_DEBUG("no driver attach to device %s", name);
-		return 1;
-	}
-
-	return afu_dev->driver->remove(afu_dev);
-}
-
 static int
 ifpga_unplug(struct rte_device *dev)
 {
-	struct rte_afu_device *afu_dev = NULL;
+	struct rte_afu_device *afu_dev = RTE_DEV_TO_AFU(dev);
 	int ret;
 
-	if (dev == NULL)
-		return -EINVAL;
-
-	afu_dev = RTE_DEV_TO_AFU(dev);
-	if (!afu_dev)
-		return -ENOENT;
-
-	ret = ifpga_remove_driver(afu_dev);
+	ret = afu_dev->driver->remove(afu_dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index d7f028e365..1385b0c959 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -310,13 +310,9 @@ static int
 rte_pci_detach_dev(struct rte_pci_device *dev)
 {
 	struct rte_pci_addr *loc;
-	struct rte_pci_driver *dr;
+	struct rte_pci_driver *dr = dev->driver;
 	int ret = 0;
 
-	if (dev == NULL)
-		return -EINVAL;
-
-	dr = dev->driver;
 	loc = &dev->addr;
 
 	PCI_LOG(DEBUG, "PCI device "PCI_PRI_FMT" on NUMA socket %i",
@@ -416,7 +412,9 @@ pci_cleanup(void)
 		struct rte_pci_driver *drv = dev->driver;
 		int ret = 0;
 
-		if (drv == NULL || drv->remove == NULL)
+		if (!rte_dev_is_probed(&dev->device))
+			goto free;
+		if (drv->remove == NULL)
 			goto free;
 
 		ret = drv->remove(dev);
@@ -590,13 +588,9 @@ pci_find_device_by_addr(const void *failure_addr)
 static int
 pci_hot_unplug_handler(struct rte_device *dev)
 {
-	struct rte_pci_device *pdev = NULL;
+	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(dev);
 	int ret = 0;
 
-	pdev = RTE_DEV_TO_PCI(dev);
-	if (!pdev)
-		return -1;
-
 	switch (pdev->kdrv) {
 	case RTE_PCI_KDRV_VFIO:
 		/*
@@ -654,10 +648,9 @@ pci_plug(struct rte_device *dev)
 static int
 pci_unplug(struct rte_device *dev)
 {
-	struct rte_pci_device *pdev;
+	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(dev);
 	int ret;
 
-	pdev = RTE_DEV_TO_PCI(dev);
 	ret = rte_pci_detach_dev(pdev);
 	if (ret == 0) {
 		rte_pci_remove_device(pdev);
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 8a89a3cad8..0345f1daf7 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -476,11 +476,10 @@ platform_bus_plug(struct rte_device *dev)
 static void
 device_release_driver(struct rte_platform_device *pdev)
 {
-	struct rte_platform_driver *pdrv;
+	struct rte_platform_driver *pdrv = pdev->driver;
 	int ret;
 
-	pdrv = pdev->driver;
-	if (pdrv != NULL && pdrv->remove != NULL) {
+	if (pdrv->remove != NULL) {
 		ret = pdrv->remove(pdev);
 		if (ret)
 			PLATFORM_LOG_LINE(WARNING, "failed to remove %s", pdev->name);
@@ -493,11 +492,7 @@ device_release_driver(struct rte_platform_device *pdev)
 static int
 platform_bus_unplug(struct rte_device *dev)
 {
-	struct rte_platform_device *pdev;
-
-	pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
-	if (pdev == NULL)
-		return -EINVAL;
+	struct rte_platform_device *pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
 
 	device_release_driver(pdev);
 	device_cleanup(pdev);
@@ -572,6 +567,8 @@ platform_bus_cleanup(void)
 
 	RTE_TAILQ_FOREACH_SAFE(pdev, &platform_bus.device_list, next, tmp) {
 		TAILQ_REMOVE(&platform_bus.device_list, pdev, next);
+		if (!rte_dev_is_probed(&pdev->device))
+			continue;
 		platform_bus_unplug(&pdev->device);
 	}
 
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index ade2452ad5..d0ea454911 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -453,7 +453,9 @@ uacce_cleanup(void)
 		struct rte_uacce_driver *dr = dev->driver;
 		int ret = 0;
 
-		if (dr == NULL || dr->remove == NULL)
+		if (!rte_dev_is_probed(&dev->device))
+			goto free;
+		if (dr->remove == NULL)
 			goto free;
 
 		ret = dr->remove(dev);
@@ -481,14 +483,12 @@ uacce_plug(struct rte_device *dev)
 static int
 uacce_detach_dev(struct rte_uacce_device *dev)
 {
-	struct rte_uacce_driver *dr;
+	struct rte_uacce_driver *dr = dev->driver;
 	int ret = 0;
 
-	dr = dev->driver;
-
 	UACCE_BUS_DEBUG("detach device %s using driver: %s", dev->device.name, dr->driver.name);
 
-	if (dr->remove) {
+	if (dr->remove != NULL) {
 		ret = dr->remove(dev);
 		if (ret < 0)
 			return ret;
@@ -503,10 +503,9 @@ uacce_detach_dev(struct rte_uacce_device *dev)
 static int
 uacce_unplug(struct rte_device *dev)
 {
-	struct rte_uacce_device *uacce_dev;
+	struct rte_uacce_device *uacce_dev = RTE_DEV_TO_UACCE_DEV(dev);
 	int ret;
 
-	uacce_dev = RTE_DEV_TO_UACCE_DEV(dev);
 	ret = uacce_detach_dev(uacce_dev);
 	if (ret == 0) {
 		TAILQ_REMOVE(&uacce_bus.device_list, uacce_dev, next);
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index a200a67847..906e9dbe08 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -567,9 +567,9 @@ vdev_cleanup(void)
 
 	RTE_TAILQ_FOREACH_SAFE(dev, &vdev_device_list, next, tmp_dev) {
 		const struct rte_vdev_driver *drv;
-		int ret = 0;
+		int ret;
 
-		if (dev->device.driver == NULL)
+		if (!rte_dev_is_probed(&dev->device))
 			goto free;
 
 		drv = container_of(dev->device.driver, const struct rte_vdev_driver, driver);
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index bdc0fbb62d..d38c75d597 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -210,7 +210,9 @@ rte_vmbus_cleanup(void)
 		const struct rte_vmbus_driver *drv = dev->driver;
 		int ret;
 
-		if (drv == NULL || drv->remove == NULL)
+		if (!rte_dev_is_probed(&dev->device))
+			continue;
+		if (drv->remove == NULL)
 			continue;
 
 		ret = drv->remove(dev);
-- 
2.53.0

