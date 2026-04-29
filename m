Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3FBFF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:47:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE2B540A67;
	Wed, 29 Apr 2026 13:47:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 45BD640664
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AXgIGAwFvyMqf7YTqb7wBJrJeLRS6bipTiAKx2tHqI=;
 b=R6mwDgNg39KbZuc/35COcBaJxegsyrkKRsVwL/qac+LS9+XbsnM9HzNO7maLiafkfR9216
 3LI/Te9BtAMZi6SNdDbCFQUwxfWt2ViViL213VPmlITz6KsHa4wiUMUBTtV2aw1fPxkwM+
 Lwjs+jaSsIE5qT7yJDlXSJA0PHKOmfk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-x7sr45NvPMO52g_BnZkbSA-1; Wed,
 29 Apr 2026 07:46:58 -0400
X-MC-Unique: x7sr45NvPMO52g_BnZkbSA-1
X-Mimecast-MFC-AGG-ID: x7sr45NvPMO52g_BnZkbSA_1777463216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 158FC1800451; Wed, 29 Apr 2026 11:46:56 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D0A0195608E; Wed, 29 Apr 2026 11:46:51 +0000 (UTC)
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
Subject: [PATCH 13/23] bus: support multiple probe
Date: Wed, 29 Apr 2026 13:44:46 +0200
Message-ID: <20260429114503.932575-14-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZyTWMCd6u3Mzh9IMCFUewZsXlGE88EVGDqnHFgXjzX8_1777463216
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

Add infrastructure to declare support for multiple probe attempts
on the same device. This prepares for the introduction of
generic probe_device operation.

The PCI bus enables this feature to support drivers with
RTE_PCI_DRV_PROBE_AGAIN flag.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 6 ------
 drivers/bus/cdx/cdx.c                    | 5 -----
 drivers/bus/dpaa/dpaa_bus.c              | 3 ---
 drivers/bus/fslmc/fslmc_bus.c            | 3 ---
 drivers/bus/ifpga/ifpga_bus.c            | 7 -------
 drivers/bus/pci/pci_common.c             | 1 +
 drivers/bus/platform/platform.c          | 3 ---
 drivers/bus/uacce/uacce.c                | 5 -----
 drivers/bus/vdev/vdev.c                  | 3 ---
 drivers/bus/vmbus/vmbus_common.c         | 6 ------
 lib/eal/common/eal_common_dev.c          | 3 +++
 lib/eal/include/bus_driver.h             | 1 +
 12 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 7824c26f92..c210e303ce 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -94,12 +94,6 @@ auxiliary_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (aux_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		AUXILIARY_LOG(INFO, "Device %s is not NUMA-aware", aux_dev->name);
 
-	if (rte_dev_is_probed(&aux_dev->device)) {
-		AUXILIARY_LOG(DEBUG, "Device %s is already probed on auxiliary bus",
-			aux_dev->device.name);
-		return -EEXIST;
-	}
-
 	iova_mode = rte_eal_iova_mode();
 	if ((aux_drv->drv_flags & RTE_AUXILIARY_DRV_NEED_IOVA_AS_VA) > 0 &&
 	    iova_mode != RTE_IOVA_VA) {
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index c38eae325b..64fb0a8534 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -315,11 +315,6 @@ cdx_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	const char *dev_name = cdx_dev->name;
 	int ret;
 
-	if (rte_dev_is_probed(&cdx_dev->device)) {
-		CDX_BUS_INFO("Device %s is already probed", dev_name);
-		return -EEXIST;
-	}
-
 	CDX_BUS_DEBUG("  probe device %s using driver: %s", dev_name,
 		cdx_drv->driver.name);
 
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 14cd64cc32..b0ed61ba39 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -826,9 +826,6 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	struct rte_dpaa_driver *dpaa_drv = RTE_BUS_DRIVER(drv, *dpaa_drv);
 	int ret;
 
-	if (rte_dev_is_probed(&dpaa_dev->device))
-		return 0;
-
 	if (rte_bus_device_is_ignored(&rte_dpaa_bus.bus, dpaa_dev->name))
 		return 0;
 
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index a975e464c1..e6db8f5100 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -541,9 +541,6 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 	struct rte_dpaa2_driver *drv = RTE_BUS_DRIVER(driver, *drv);
 	int ret = 0;
 
-	if (rte_dev_is_probed(&dev->device))
-		return 0;
-
 	if (dev->device.devargs &&
 	    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
 		DPAA2_BUS_DEBUG("%s Blocked, skipping",
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 92ad3513e0..d3f3370bc5 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -274,13 +274,6 @@ ifpga_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	struct rte_afu_driver *afu_drv = RTE_BUS_DRIVER(drv, *afu_drv);
 	int ret;
 
-	/* Check if a driver is already loaded */
-	if (rte_dev_is_probed(&afu_dev->device)) {
-		IFPGA_BUS_DEBUG("Device %s is already probed",
-				rte_ifpga_device_name(afu_dev));
-		return -EEXIST;
-	}
-
 	/* reference driver structure */
 	afu_dev->driver = afu_drv;
 
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index b57320064e..02542a903a 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -823,6 +823,7 @@ rte_pci_pasid_set_state(const struct rte_pci_device *dev,
 
 struct rte_pci_bus rte_pci_bus = {
 	.bus = {
+		.allow_multi_probe = true,
 		.scan = rte_pci_scan,
 		.probe = pci_probe,
 		.cleanup = pci_cleanup,
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 22979f31b3..3d04ba4d25 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -331,9 +331,6 @@ driver_call_probe(struct rte_platform_driver *pdrv, struct rte_platform_device *
 {
 	int ret;
 
-	if (rte_dev_is_probed(&pdev->device))
-		return -EBUSY;
-
 	if (pdrv->probe != NULL) {
 		pdev->driver = pdrv;
 		ret = pdrv->probe(pdev);
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index d8e15cd479..3dedc783ce 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -358,11 +358,6 @@ uacce_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	const char *dev_name = uacce_dev->name;
 	int ret;
 
-	if (rte_dev_is_probed(&uacce_dev->device)) {
-		UACCE_BUS_INFO("device %s is already probed", dev_name);
-		return -EEXIST;
-	}
-
 	UACCE_BUS_DEBUG("probe device %s using driver %s", dev_name, uacce_drv->driver.name);
 
 	ret = uacce_drv->probe(uacce_drv, uacce_dev);
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 5464fe28d4..4da9a2c950 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -190,9 +190,6 @@ vdev_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	enum rte_iova_mode iova_mode;
 	int ret;
 
-	if (rte_dev_is_probed(&vdev_dev->device))
-		return -EEXIST;
-
 	name = rte_vdev_device_name(vdev_dev);
 	VDEV_LOG(DEBUG, "Search driver to probe device %s", name);
 
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index ba923a2669..24b1c24f43 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -91,12 +91,6 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	char guid[RTE_UUID_STRLEN];
 	int ret;
 
-	/* Check if a driver is already loaded */
-	if (rte_dev_is_probed(&vmbus_dev->device)) {
-		VMBUS_LOG(DEBUG, "VMBUS driver already loaded");
-		return 0;
-	}
-
 	rte_uuid_unparse(vmbus_dev->device_id, guid, sizeof(guid));
 	VMBUS_LOG(INFO, "VMBUS device %s on NUMA socket %i",
 		  guid, vmbus_dev->device.numa_node);
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index a38c211e5d..9047a01c4a 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -225,6 +225,9 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 	drv = rte_bus_find_driver(dev->bus, drv, dev);
 	if (drv == NULL) {
 		ret = -ENOTSUP;
+	} else if (rte_dev_is_probed(dev) && !dev->bus->allow_multi_probe) {
+		EAL_LOG(INFO, "Device %s is already probed", dev->name);
+		ret = -EEXIST;
 	} else {
 		ret = dev->bus->probe_device(drv, dev);
 		if (ret > 0)
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 55568fe08a..5ab988426c 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -327,6 +327,7 @@ typedef void *(*rte_bus_dev_iterate_t)(const struct rte_bus *bus,
 struct rte_bus {
 	RTE_TAILQ_ENTRY(rte_bus) next; /**< Next bus object in linked list */
 	const char *name;            /**< Name of the bus */
+	bool allow_multi_probe;      /**< Allow probing devices multiple times */
 	rte_bus_scan_t scan;         /**< Scan for devices attached to bus */
 	rte_bus_probe_t probe;       /**< Probe devices on bus */
 	rte_bus_find_device_t find_device; /**< Find a device on the bus */
-- 
2.53.0

