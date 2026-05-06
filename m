Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E232ACD3440
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:54:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6346A40A87;
	Wed,  6 May 2026 17:54:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 446BA40B9D
 for <dev@dpdk.org>; Wed,  6 May 2026 17:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778082850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kakn7frMyxxoDqSGYHKcmdKphiH2Gu3ieYU47EvKgEc=;
 b=Uv7Yb2TLoLDhKX0QjdWIrvxd0MOfAavxezGeBhYdL00XFyUbDNmpgDewrIdmGEhDK8ipYA
 kL7BIOQJJSqItTLhPwlkKHI+VNy9YuwG9Kh29w3v+T6rggIiPeqMBNtTjiezP8Zi9OQMIq
 SAlV0jjHtih8lKdiRwKJ+SySVYU7iJA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-LB6XeN-vPImAmFRChaJp0Q-1; Wed,
 06 May 2026 11:54:08 -0400
X-MC-Unique: LB6XeN-vPImAmFRChaJp0Q-1
X-Mimecast-MFC-AGG-ID: LB6XeN-vPImAmFRChaJp0Q_1778082846
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A78919560A2; Wed,  6 May 2026 15:54:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 904BE1800347; Wed,  6 May 2026 15:54:01 +0000 (UTC)
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
Subject: [PATCH v2 16/23] bus: factorize driver reference
Date: Wed,  6 May 2026 17:51:48 +0200
Message-ID: <20260506155201.2709810-17-david.marchand@redhat.com>
In-Reply-To: <20260506155201.2709810-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6V56YJqE2VjtFcQvVhgS0qj8t8JRU8C0xODi4rLNmSc_1778082846
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

Before this patch, setting the driver in the device object and error
rollback were the responsibility of each bus probe_device function.

This patch centralizes it in the EAL's local_dev_probe function.
The dev->driver field is now set before calling bus->probe_device,
ensuring that drivers can rely on it being set during probe.

On error, dev->driver is cleared only if the device was not previously
probed, to handle buses that support multiple probes
(RTE_PCI_DRV_PROBE_AGAIN).

As a consequence, each bus implementation no longer needs to set/clear
dev->driver and dev->device.driver.

In PCI bus, a side effect is that detecting a re-probe cannot use
rte_dev_is_probed (which checks dev->driver != NULL) anymore.
Switch to checking if intr_handle was allocated instead.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c |  2 --
 drivers/bus/cdx/cdx.c                    |  2 --
 drivers/bus/dpaa/dpaa_bus.c              |  6 ++----
 drivers/bus/fslmc/fslmc_bus.c            |  1 -
 drivers/bus/ifpga/ifpga_bus.c            |  2 --
 drivers/bus/pci/pci_common.c             |  6 ++----
 drivers/bus/platform/platform.c          |  8 +-------
 drivers/bus/uacce/uacce.c                |  1 -
 drivers/bus/vmbus/vmbus_common.c         |  2 --
 lib/eal/common/eal_common_bus.c          |  7 +++++++
 lib/eal/common/eal_common_dev.c          | 12 ++++++++++++
 11 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 206b69bbd4..ba8c35ebbe 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -120,8 +120,6 @@ auxiliary_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		aux_dev->driver = NULL;
 		rte_intr_instance_free(aux_dev->intr_handle);
 		aux_dev->intr_handle = NULL;
-	} else {
-		aux_dev->device.driver = &aux_drv->driver;
 	}
 
 	return ret;
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index e1405d1372..c6a4da7692 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -332,8 +332,6 @@ cdx_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		CDX_BUS_ERR("Probe CDX driver: %s device: %s failed: %d",
 			cdx_drv->driver.name, dev_name, ret);
 		goto error_probe;
-	} else {
-		cdx_dev->device.driver = &cdx_drv->driver;
 	}
 	cdx_dev->driver = cdx_drv;
 
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 7f4a85a91d..b7d0caaf61 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -800,12 +800,10 @@ dpaa_bus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	int ret;
 
 	ret = dpaa_drv->probe(dpaa_drv, dpaa_dev);
-	if (ret != 0) {
+	if (ret != 0)
 		DPAA_BUS_ERR("unable to probe: %s", dpaa_dev->name);
-	} else {
+	else
 		dpaa_dev->driver = dpaa_drv;
-		dpaa_dev->device.driver = &dpaa_drv->driver;
-	}
 
 	return ret;
 }
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 29ef3b58cf..ae69bd0da2 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -524,7 +524,6 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 		DPAA2_BUS_ERR("Unable to probe");
 	} else {
 		dev->driver = drv;
-		dev->device.driver = &drv->driver;
 		DPAA2_BUS_INFO("%s Plugged",  dev->device.name);
 	}
 
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index b2eb4f4413..a79a287fbe 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -281,8 +281,6 @@ ifpga_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	ret = afu_drv->probe(afu_dev);
 	if (ret)
 		afu_dev->driver = NULL;
-	else
-		afu_dev->device.driver = &afu_drv->driver;
 
 	return ret;
 }
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index a507360ef6..5c37c5e543 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -203,7 +203,7 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (pci_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		PCI_LOG(INFO, "Device %s is not NUMA-aware", pci_dev->name);
 
-	already_probed = rte_dev_is_probed(&pci_dev->device);
+	already_probed = (pci_dev->intr_handle != NULL);
 	if (already_probed && !(pci_drv->drv_flags & RTE_PCI_DRV_PROBE_AGAIN)) {
 		PCI_LOG(DEBUG, "Device %s is already probed", pci_dev->device.name);
 		return -EEXIST;
@@ -251,7 +251,7 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		 * to use driver flags for adjusting configuration.
 		 */
 		pci_dev->driver = pci_drv;
-		if (pci_dev->driver->drv_flags & RTE_PCI_DRV_NEED_MAPPING) {
+		if (pci_drv->drv_flags & RTE_PCI_DRV_NEED_MAPPING) {
 			ret = rte_pci_map_device(pci_dev);
 			if (ret != 0) {
 				pci_dev->driver = NULL;
@@ -285,8 +285,6 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		pci_dev->vfio_req_intr_handle = NULL;
 		rte_intr_instance_free(pci_dev->intr_handle);
 		pci_dev->intr_handle = NULL;
-	} else {
-		pci_dev->device.driver = &pci_drv->driver;
 	}
 
 	return ret;
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 01c8239cbb..671f36fac9 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -329,17 +329,11 @@ device_setup(struct rte_platform_device *pdev)
 static int
 driver_call_probe(struct rte_platform_driver *pdrv, struct rte_platform_device *pdev)
 {
-	int ret;
-
 	if (pdrv->probe != NULL) {
 		pdev->driver = pdrv;
-		ret = pdrv->probe(pdev);
-		if (ret)
-			return ret;
+		return pdrv->probe(pdev);
 	}
 
-	pdev->device.driver = &pdrv->driver;
-
 	return 0;
 }
 
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index b0deb39185..d4a18b2835 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -365,7 +365,6 @@ uacce_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		UACCE_BUS_ERR("probe device %s with driver %s failed %d",
 			      dev_name, uacce_drv->driver.name, ret);
 	} else {
-		uacce_dev->device.driver = &uacce_drv->driver;
 		uacce_dev->driver = uacce_drv;
 		UACCE_BUS_DEBUG("probe device %s with driver %s success",
 				dev_name, uacce_drv->driver.name);
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index bd375ae6bb..43652c0487 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -119,8 +119,6 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (ret != 0) {
 		vmbus_dev->driver = NULL;
 		rte_vmbus_unmap_device(vmbus_dev);
-	} else {
-		vmbus_dev->device.driver = &vmbus_drv->driver;
 	}
 
 	return ret;
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 94b7be5f5f..ca13ccce5b 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -86,6 +86,7 @@ rte_bus_generic_probe(struct rte_bus *bus)
 
 	TAILQ_FOREACH(dev, &bus->device_list, next) {
 		struct rte_driver *drv = NULL;
+		bool was_probed;
 		int ret;
 
 		if (rte_bus_device_is_ignored(bus, dev->name))
@@ -102,7 +103,13 @@ rte_bus_generic_probe(struct rte_bus *bus)
 		if (drv == NULL)
 			continue;
 
+		was_probed = rte_dev_is_probed(dev);
+		if (!was_probed)
+			dev->driver = drv;
 		ret = bus->probe_device(drv, dev);
+		if (!was_probed && ret != 0)
+			dev->driver = NULL;
+
 		if (ret > 0)
 			goto next_driver;
 
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 9047a01c4a..48b631532a 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -229,7 +229,19 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 		EAL_LOG(INFO, "Device %s is already probed", dev->name);
 		ret = -EEXIST;
 	} else {
+		bool was_probed = rte_dev_is_probed(dev);
+
+		/*
+		 * Reference driver structure.
+		 * This needs to be before .probe_device as some bus (like PCI) use
+		 * driver flags for adjusting configuration.
+		 */
+		if (!was_probed)
+			dev->driver = drv;
 		ret = dev->bus->probe_device(drv, dev);
+		if (!was_probed && ret != 0)
+			dev->driver = NULL;
+
 		if (ret > 0)
 			goto next_driver;
 	}
-- 
2.53.0

