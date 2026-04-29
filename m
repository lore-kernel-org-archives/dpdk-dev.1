Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970BFFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:45:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D49734066C;
	Wed, 29 Apr 2026 13:45:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C06440669
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvOFCLsS7C+WJETQCJ1qgUuGNbA4JC34Pm3gMwARQu8=;
 b=WLp3VBoDlmjZDngTdkKRGy8gUAqsYBwM4Rk6wAPuQILnFBvz335In6qZPaemE4a7zk/6Nd
 I5N6brqyBQ3phajzfSOzZX6sQzlv5Ss/7vPP5XzNQ4BCDN158AfZNwTMqQLg3wAtmX3VzC
 ODY0UgI3+nErSK/Eb8Yn1xyyqW6j4Sg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-KIrFw9JUNWmBgOVlE6aKyQ-1; Wed,
 29 Apr 2026 07:45:28 -0400
X-MC-Unique: KIrFw9JUNWmBgOVlE6aKyQ-1
X-Mimecast-MFC-AGG-ID: KIrFw9JUNWmBgOVlE6aKyQ_1777463127
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B870195605C; Wed, 29 Apr 2026 11:45:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2827E180045E; Wed, 29 Apr 2026 11:45:23 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH 03/23] bus: remove device and driver checks in DMA map/unmap
Date: Wed, 29 Apr 2026 13:44:36 +0200
Message-ID: <20260429114503.932575-4-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kvVOzG3vTu5DS7aw_VIdoE5ckkyozE6gGQ76rXYLEIs_1777463127
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

Add rte_dev_is_probed() check in rte_dev_dma_map() and
rte_dev_dma_unmap() before calling bus-specific implementations.

The device parameter passed to bus DMA map/unmap operations cannot be
NULL as the caller already dereferenced the bus structure to invoke
these operations.
The driver reference in the bus-specific device cannot be NULL since
calling the .dma_map is done after dereferencing this pointer.

Remove redundant checks on probed device, and NULL checks on the
device/driver parameter and derived device/driver pointers.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c |  8 --------
 drivers/bus/pci/pci_common.c             | 12 ++----------
 drivers/bus/platform/platform.c          | 16 ++--------------
 drivers/bus/vdev/vdev.c                  | 24 ++----------------------
 lib/eal/common/eal_common_dev.c          |  8 ++++++++
 5 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 8f3e90eaf0..9690687600 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -356,10 +356,6 @@ auxiliary_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_auxiliary_device *aux_dev = RTE_DEV_TO_AUXILIARY(dev);
 
-	if (dev == NULL || aux_dev->driver == NULL) {
-		rte_errno = EINVAL;
-		return -1;
-	}
 	if (aux_dev->driver->dma_map == NULL) {
 		rte_errno = ENOTSUP;
 		return -1;
@@ -373,10 +369,6 @@ auxiliary_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 {
 	struct rte_auxiliary_device *aux_dev = RTE_DEV_TO_AUXILIARY(dev);
 
-	if (dev == NULL || aux_dev->driver == NULL) {
-		rte_errno = EINVAL;
-		return -1;
-	}
 	if (aux_dev->driver->dma_unmap == NULL) {
 		rte_errno = ENOTSUP;
 		return -1;
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 51fd8c80e4..d7f028e365 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -672,11 +672,7 @@ pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(dev);
 
-	if (!pdev || !pdev->driver) {
-		rte_errno = EINVAL;
-		return -1;
-	}
-	if (pdev->driver->dma_map)
+	if (pdev->driver->dma_map != NULL)
 		return pdev->driver->dma_map(pdev, addr, iova, len);
 	/**
 	 *  In case driver don't provides any specific mapping
@@ -695,11 +691,7 @@ pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
 	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(dev);
 
-	if (!pdev || !pdev->driver) {
-		rte_errno = EINVAL;
-		return -1;
-	}
-	if (pdev->driver->dma_unmap)
+	if (pdev->driver->dma_unmap != NULL)
 		return pdev->driver->dma_unmap(pdev, addr, iova, len);
 	/**
 	 *  In case driver don't provides any specific mapping
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index e54098d04f..8a89a3cad8 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -530,13 +530,7 @@ platform_bus_parse(const char *name, void *addr)
 static int
 platform_bus_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_platform_device *pdev;
-
-	pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
-	if (pdev == NULL || pdev->driver == NULL) {
-		rte_errno = EINVAL;
-		return -1;
-	}
+	struct rte_platform_device *pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
 
 	if (pdev->driver->dma_map != NULL)
 		return pdev->driver->dma_map(pdev, addr, iova, len);
@@ -547,13 +541,7 @@ platform_bus_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t l
 static int
 platform_bus_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_platform_device *pdev;
-
-	pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
-	if (pdev == NULL || pdev->driver == NULL) {
-		rte_errno = EINVAL;
-		return -1;
-	}
+	struct rte_platform_device *pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
 
 	if (pdev->driver->dma_unmap != NULL)
 		return pdev->driver->dma_unmap(pdev, addr, iova, len);
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index eb1de0186e..a200a67847 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -144,20 +144,10 @@ vdev_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 	struct rte_vdev_device *vdev = RTE_DEV_TO_VDEV(dev);
 	const struct rte_vdev_driver *driver;
 
-	if (!vdev) {
-		rte_errno = EINVAL;
-		return -1;
-	}
-
-	if (!vdev->device.driver) {
-		VDEV_LOG(DEBUG, "no driver attach to device %s", dev->name);
-		return 1;
-	}
-
 	driver = container_of(vdev->device.driver, const struct rte_vdev_driver,
 			driver);
 
-	if (driver->dma_map)
+	if (driver->dma_map != NULL)
 		return driver->dma_map(vdev, addr, iova, len);
 
 	return 0;
@@ -169,20 +159,10 @@ vdev_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 	struct rte_vdev_device *vdev = RTE_DEV_TO_VDEV(dev);
 	const struct rte_vdev_driver *driver;
 
-	if (!vdev) {
-		rte_errno = EINVAL;
-		return -1;
-	}
-
-	if (!vdev->device.driver) {
-		VDEV_LOG(DEBUG, "no driver attach to device %s", dev->name);
-		return 1;
-	}
-
 	driver = container_of(vdev->device.driver, const struct rte_vdev_driver,
 			driver);
 
-	if (driver->dma_unmap)
+	if (driver->dma_unmap != NULL)
 		return driver->dma_unmap(vdev, addr, iova, len);
 
 	return 0;
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 7185de0cb9..fceca75223 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -829,6 +829,10 @@ int
 rte_dev_dma_map(struct rte_device *dev, void *addr, uint64_t iova,
 		size_t len)
 {
+	if (!rte_dev_is_probed(dev)) {
+		rte_errno = EINVAL;
+		return -1;
+	}
 	if (dev->bus->dma_map == NULL || len == 0) {
 		rte_errno = ENOTSUP;
 		return -1;
@@ -847,6 +851,10 @@ int
 rte_dev_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 		  size_t len)
 {
+	if (!rte_dev_is_probed(dev)) {
+		rte_errno = EINVAL;
+		return -1;
+	}
 	if (dev->bus->dma_unmap == NULL || len == 0) {
 		rte_errno = ENOTSUP;
 		return -1;
-- 
2.53.0

