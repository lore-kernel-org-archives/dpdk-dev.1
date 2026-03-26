Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5441106F31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:25:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C32742D27;
	Thu, 26 Mar 2026 11:25:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D232E42D55
 for <dev@dpdk.org>; Thu, 26 Mar 2026 11:25:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774520728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7oujqNNj5nwAnTnESwj7SrT/gZTk4KZgErNADMW3L0=;
 b=HW5U8LzPKDQDPkiVbeVbVyG8NcsAd5T9wbUgcT6fXH8fjq31zzRx1gaCQfAPl/UNxH6cgu
 rQZRJkRf12wF8v/q8YlOMKUhFCbgsT+B5+6cixN4s6L4C60avjrwfKL3NWOQicDclrmu5/
 5Mr8+8mRdpOwyHW4/wcx7dMqWuAohQ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-mLfS_c05NTq0k-skQO1-lg-1; Thu,
 26 Mar 2026 06:25:25 -0400
X-MC-Unique: mLfS_c05NTq0k-skQO1-lg-1
X-Mimecast-MFC-AGG-ID: mLfS_c05NTq0k-skQO1-lg_1774520722
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97B4D180035D; Thu, 26 Mar 2026 10:25:22 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 477B43000223; Thu, 26 Mar 2026 10:25:18 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v2 5/7] bus: factorize devargs lookup
Date: Thu, 26 Mar 2026 11:24:21 +0100
Message-ID: <20260326102424.2361945-6-david.marchand@redhat.com>
In-Reply-To: <20260326102424.2361945-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NdFwxdqH3JyTyZp1jC2y_fnRU7jnugKJ8LvZcu54Nbs_1774520722
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

Each bus reimplements some similar devargs lookup code.

The differences are in how some bus (PCI, VMBUS etc...) normalizes the
device names. We can't use the .parse existing handler from outside the
bus code itself, as the size of the bus specific device location address
is unknown.
Introduce a bus specific helper to compare two device names and
hide this ugly detail.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Maxime Leroy <maxime@leroys.fr>
---
Changes since v1:
- fixed copy/paste descriptions in doxygen,

Changes since RFC v3:
- fixed doxygen,

---
 drivers/bus/auxiliary/auxiliary_common.c | 16 ++-------
 drivers/bus/cdx/cdx.c                    | 14 +-------
 drivers/bus/dpaa/dpaa_bus.c              | 41 +++++++++++++-----------
 drivers/bus/fslmc/fslmc_bus.c            | 34 ++++++++++----------
 drivers/bus/pci/pci_common.c             | 38 +++++++++++-----------
 drivers/bus/platform/platform.c          | 17 ++--------
 drivers/bus/uacce/uacce.c                | 19 ++---------
 drivers/bus/vmbus/linux/vmbus_bus.c      |  2 +-
 drivers/bus/vmbus/private.h              |  3 --
 drivers/bus/vmbus/vmbus_common.c         | 30 ++++++++---------
 drivers/dma/idxd/idxd_bus.c              | 14 ++------
 lib/eal/common/eal_common_bus.c          | 20 ++++++++++++
 lib/eal/include/bus_driver.h             | 32 ++++++++++++++++++
 13 files changed, 133 insertions(+), 147 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 119533df28..e5b4f4460d 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -25,18 +25,6 @@
 
 #include "private.h"
 
-static struct rte_devargs *
-auxiliary_devargs_lookup(const char *name)
-{
-	struct rte_devargs *devargs;
-
-	RTE_EAL_DEVARGS_FOREACH(auxiliary_bus.bus.name, devargs) {
-		if (strcmp(devargs->name, name) == 0)
-			return devargs;
-	}
-	return NULL;
-}
-
 #ifndef AUXILIARY_OS_SUPPORTED
 /*
  * Test whether the auxiliary device exist.
@@ -68,7 +56,7 @@ auxiliary_scan(void)
 void
 auxiliary_on_scan(struct rte_auxiliary_device *aux_dev)
 {
-	aux_dev->device.devargs = auxiliary_devargs_lookup(aux_dev->name);
+	aux_dev->device.devargs = rte_bus_find_devargs(&auxiliary_bus.bus, aux_dev->name);
 }
 
 /*
@@ -399,7 +387,7 @@ auxiliary_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 bool
 auxiliary_is_ignored_device(const char *name)
 {
-	struct rte_devargs *devargs = auxiliary_devargs_lookup(name);
+	struct rte_devargs *devargs = rte_bus_find_devargs(&auxiliary_bus.bus, name);
 
 	switch (auxiliary_bus.bus.conf.scan_mode) {
 	case RTE_BUS_SCAN_ALLOWLIST:
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index b183d98453..0801825ef5 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -151,22 +151,10 @@ void rte_cdx_unmap_device(struct rte_cdx_device *dev)
 	cdx_vfio_unmap_resource(dev);
 }
 
-static struct rte_devargs *
-cdx_devargs_lookup(const char *dev_name)
-{
-	struct rte_devargs *devargs;
-
-	RTE_EAL_DEVARGS_FOREACH(rte_cdx_bus.bus.name, devargs) {
-		if (strcmp(devargs->name, dev_name) == 0)
-			return devargs;
-	}
-	return NULL;
-}
-
 static bool
 cdx_ignore_device(const char *dev_name)
 {
-	struct rte_devargs *devargs = cdx_devargs_lookup(dev_name);
+	struct rte_devargs *devargs = rte_bus_find_devargs(&rte_cdx_bus.bus, dev_name);
 
 	switch (rte_cdx_bus.bus.conf.scan_mode) {
 	case RTE_BUS_SCAN_ALLOWLIST:
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index e3c17d41f7..356c56d989 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -198,22 +198,6 @@ dpaa_sec_available(void)
 
 static void dpaa_clean_device_list(void);
 
-static struct rte_devargs *
-dpaa_devargs_lookup(struct rte_dpaa_device *dev)
-{
-	struct rte_devargs *devargs;
-	char dev_name[32];
-
-	RTE_EAL_DEVARGS_FOREACH(rte_dpaa_bus.bus.name, devargs) {
-		devargs->bus->parse(devargs->name, &dev_name);
-		if (strcmp(dev_name, dev->device.name) == 0) {
-			DPAA_BUS_INFO("**Devargs matched %s", dev_name);
-			return devargs;
-		}
-	}
-	return NULL;
-}
-
 static int
 dpaa_create_device_list(void)
 {
@@ -269,7 +253,9 @@ dpaa_create_device_list(void)
 				(fman_intf->fman->idx + 1), fman_intf->mac_idx);
 		}
 		dev->device.name = dev->name;
-		dev->device.devargs = dpaa_devargs_lookup(dev);
+		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus.bus, dev->name);
+		if (dev->device.devargs != NULL)
+			DPAA_BUS_INFO("**Devargs matched %s", dev->name);
 
 		dpaa_add_to_device_list(dev);
 	}
@@ -317,7 +303,9 @@ dpaa_create_device_list(void)
 		sprintf(dev->name, "dpaa_sec-%d", i+1);
 		DPAA_BUS_LOG(INFO, "%s cryptodev added", dev->name);
 		dev->device.name = dev->name;
-		dev->device.devargs = dpaa_devargs_lookup(dev);
+		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus.bus, dev->name);
+		if (dev->device.devargs != NULL)
+			DPAA_BUS_INFO("**Devargs matched %s", dev->name);
 
 		dpaa_add_to_device_list(dev);
 	}
@@ -341,7 +329,9 @@ dpaa_create_device_list(void)
 		sprintf(dev->name, "dpaa_qdma-%d", i+1);
 		DPAA_BUS_LOG(INFO, "%s qdma device added", dev->name);
 		dev->device.name = dev->name;
-		dev->device.devargs = dpaa_devargs_lookup(dev);
+		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus.bus, dev->name);
+		if (dev->device.devargs != NULL)
+			DPAA_BUS_INFO("**Devargs matched %s", dev->name);
 
 		dpaa_add_to_device_list(dev);
 	}
@@ -572,6 +562,18 @@ rte_dpaa_bus_parse(const char *name, void *out)
 	return 0;
 }
 
+static int
+dpaa_bus_devname_compare(const char *name1, const char *name2)
+{
+	char devname1[32], devname2[32];
+
+	if (rte_dpaa_bus_parse(name1, devname1) != 0 ||
+			rte_dpaa_bus_parse(name2, devname2) != 0)
+		return 1;
+
+	return strncmp(devname1, devname2, sizeof(devname1));
+}
+
 #define DPAA_DEV_PATH1 "/sys/devices/platform/soc/soc:fsl,dpaa"
 #define DPAA_DEV_PATH2 "/sys/devices/platform/fsl,dpaa"
 
@@ -988,6 +990,7 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.scan = rte_dpaa_bus_scan,
 		.probe = rte_dpaa_bus_probe,
 		.parse = rte_dpaa_bus_parse,
+		.devname_compare = dpaa_bus_devname_compare,
 		.find_device = rte_dpaa_find_device,
 		.get_iommu_class = rte_dpaa_get_iommu_class,
 		.plug = dpaa_bus_plug,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 8f3e3dc1be..f72b512b1a 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -99,22 +99,6 @@ insert_in_device_list(struct rte_dpaa2_device *newdev)
 		TAILQ_INSERT_TAIL(&rte_fslmc_bus.device_list, newdev, next);
 }
 
-static struct rte_devargs *
-fslmc_devargs_lookup(struct rte_dpaa2_device *dev)
-{
-	struct rte_devargs *devargs;
-	char dev_name[32];
-
-	RTE_EAL_DEVARGS_FOREACH(rte_fslmc_bus.bus.name, devargs) {
-		devargs->bus->parse(devargs->name, &dev_name);
-		if (strcmp(dev_name, dev->device.name) == 0) {
-			DPAA2_BUS_INFO("**Devargs matched %s", dev_name);
-			return devargs;
-		}
-	}
-	return NULL;
-}
-
 static void
 dump_device_list(void)
 {
@@ -216,7 +200,10 @@ scan_one_fslmc_device(char *dev_name)
 		ret = -ENOMEM;
 		goto cleanup;
 	}
-	dev->device.devargs = fslmc_devargs_lookup(dev);
+	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus.bus, dev_name);
+	if (dev->device.devargs != NULL)
+		DPAA2_BUS_INFO("**Devargs matched %s", dev_name);
+
 
 	/* Update the device found into the device_count table */
 	rte_fslmc_bus.device_count[dev->dev_type]++;
@@ -308,6 +295,18 @@ rte_fslmc_parse(const char *name, void *addr)
 	return ret;
 }
 
+static int
+fslmc_devname_compare(const char *name1, const char *name2)
+{
+	char devname1[32], devname2[32];
+
+	if (rte_fslmc_parse(name1, devname1) != 0 ||
+			rte_fslmc_parse(name2, devname2) != 0)
+		return 1;
+
+	return strncmp(devname1, devname2, sizeof(devname1));
+}
+
 static int
 rte_fslmc_scan(void)
 {
@@ -691,6 +690,7 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 		.probe = rte_fslmc_probe,
 		.cleanup = rte_fslmc_close,
 		.parse = rte_fslmc_parse,
+		.devname_compare = fslmc_devname_compare,
 		.find_device = rte_fslmc_find_device,
 		.get_iommu_class = rte_dpaa2_get_iommu_class,
 		.plug = fslmc_bus_plug,
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 1d26fce680..8782dc342a 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -79,32 +79,15 @@ pci_asprintf(char **buffer, const char *format, ...)
 }
 #endif /* RTE_EXEC_ENV_WINDOWS */
 
-static struct rte_devargs *
-pci_devargs_lookup(const struct rte_pci_addr *pci_addr)
-{
-	struct rte_devargs *devargs;
-	struct rte_pci_addr addr;
-
-	RTE_EAL_DEVARGS_FOREACH(rte_pci_bus.bus.name, devargs) {
-		devargs->bus->parse(devargs->name, &addr);
-		if (!rte_pci_addr_cmp(pci_addr, &addr))
-			return devargs;
-	}
-	return NULL;
-}
-
 void
 pci_common_set(struct rte_pci_device *dev)
 {
-	struct rte_devargs *devargs;
-
 	/* Each device has its internal, canonical name set. */
 	rte_pci_device_name(&dev->addr,
 			dev->name, sizeof(dev->name));
 	dev->device.name = dev->name;
 
-	devargs = pci_devargs_lookup(&dev->addr);
-	dev->device.devargs = devargs;
+	dev->device.devargs = rte_bus_find_devargs(&rte_pci_bus.bus, dev->name);
 
 	if (dev->bus_info != NULL ||
 			asprintf(&dev->bus_info, "vendor_id=%"PRIx16", device_id=%"PRIx16,
@@ -503,6 +486,18 @@ pci_parse(const char *name, void *addr)
 	return parse == false;
 }
 
+static int
+pci_devname_compare(const char *name1, const char *name2)
+{
+	struct rte_pci_addr addr1, addr2;
+
+	if (rte_pci_addr_parse(name1, &addr1) != 0 ||
+			rte_pci_addr_parse(name2, &addr2) != 0)
+		return 1;
+
+	return rte_pci_addr_cmp(&addr1, &addr2);
+}
+
 /* register a driver */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_register)
 void
@@ -721,7 +716,11 @@ pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 bool
 rte_pci_ignore_device(const struct rte_pci_addr *pci_addr)
 {
-	struct rte_devargs *devargs = pci_devargs_lookup(pci_addr);
+	char name[RTE_DEV_NAME_MAX_LEN];
+	struct rte_devargs *devargs;
+
+	rte_pci_device_name(pci_addr, name, sizeof(name));
+	devargs = rte_bus_find_devargs(&rte_pci_bus.bus, name);
 
 	switch (rte_pci_bus.bus.conf.scan_mode) {
 	case RTE_BUS_SCAN_ALLOWLIST:
@@ -946,6 +945,7 @@ struct rte_pci_bus rte_pci_bus = {
 		.plug = pci_plug,
 		.unplug = pci_unplug,
 		.parse = pci_parse,
+		.devname_compare = pci_devname_compare,
 		.devargs_parse = rte_pci_devargs_parse,
 		.dma_map = pci_dma_map,
 		.dma_unmap = pci_dma_unmap,
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 18fa73795c..23c39aada6 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -43,25 +43,12 @@ rte_platform_unregister(struct rte_platform_driver *pdrv)
 	TAILQ_REMOVE(&platform_bus.driver_list, pdrv, next);
 }
 
-static struct rte_devargs *
-dev_devargs(const char *dev_name)
-{
-	struct rte_devargs *devargs;
-
-	RTE_EAL_DEVARGS_FOREACH(platform_bus.bus.name, devargs) {
-		if (!strcmp(devargs->name, dev_name))
-			return devargs;
-	}
-
-	return NULL;
-}
-
 static bool
 dev_allowed(const char *dev_name)
 {
 	struct rte_devargs *devargs;
 
-	devargs = dev_devargs(dev_name);
+	devargs = rte_bus_find_devargs(&platform_bus.bus, dev_name);
 	if (devargs == NULL)
 		return true;
 
@@ -93,7 +80,7 @@ dev_add(const char *dev_name)
 
 	rte_strscpy(pdev->name, dev_name, sizeof(pdev->name));
 	pdev->device.name = pdev->name;
-	pdev->device.devargs = dev_devargs(dev_name);
+	pdev->device.devargs = rte_bus_find_devargs(&platform_bus.bus, dev_name);
 	pdev->device.bus = &platform_bus.bus;
 	snprintf(path, sizeof(path), PLATFORM_BUS_DEVICES_PATH "/%s/numa_node", dev_name);
 	pdev->device.numa_node = eal_parse_sysfs_value(path, &val) ? rte_socket_id() : val;
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 06a3643290..e6963dc18a 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -70,25 +70,10 @@ extern int uacce_bus_logtype;
 #define UACCE_BUS_DEBUG(fmt, ...) UACCE_BUS_LOG(DEBUG, fmt, ##__VA_ARGS__)
 
 
-static struct rte_devargs *
-uacce_devargs_lookup(const char *dev_name)
-{
-	char name[RTE_UACCE_DEV_PATH_SIZE] = {0};
-	struct rte_devargs *devargs;
-
-	snprintf(name, sizeof(name), "%s%s", UACCE_DEV_PREFIX, dev_name);
-	RTE_EAL_DEVARGS_FOREACH(uacce_bus.bus.name, devargs) {
-		if (strcmp(devargs->name, name) == 0)
-			return devargs;
-	}
-
-	return NULL;
-}
-
 static bool
 uacce_ignore_device(const char *dev_name)
 {
-	struct rte_devargs *devargs = uacce_devargs_lookup(dev_name);
+	struct rte_devargs *devargs = rte_bus_find_devargs(&uacce_bus.bus, dev_name);
 
 	switch (uacce_bus.bus.conf.scan_mode) {
 	case RTE_BUS_SCAN_ALLOWLIST:
@@ -257,7 +242,7 @@ uacce_scan_one(const char *dev_name)
 
 	dev->device.bus = &uacce_bus.bus;
 	dev->device.name = dev->name;
-	dev->device.devargs = uacce_devargs_lookup(dev_name);
+	dev->device.devargs = rte_bus_find_devargs(&uacce_bus.bus, dev_name);
 	snprintf(dev->name, sizeof(dev->name), "%s", dev_name);
 	snprintf(dev->dev_root, sizeof(dev->dev_root), "%s/%s",
 		 UACCE_BUS_CLASS_PATH, dev_name);
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 4c59097273..5958b97077 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -333,7 +333,7 @@ vmbus_scan_one(const char *name)
 		dev->monitor_id = UINT8_MAX;
 	}
 
-	dev->device.devargs = vmbus_devargs_lookup(dev);
+	dev->device.devargs = rte_bus_find_devargs(&rte_vmbus_bus.bus, dev_name);
 
 	dev->device.numa_node = SOCKET_ID_ANY;
 	if (vmbus_use_numa(dev)) {
diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index 25b8a27fcf..8ac6119ef2 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -98,9 +98,6 @@ struct vmbus_channel {
 
 #define VMBUS_MAX_CHANNELS	64
 
-struct rte_devargs *
-vmbus_devargs_lookup(struct rte_vmbus_device *dev);
-
 int vmbus_chan_create(const struct rte_vmbus_device *device,
 		      uint16_t relid, uint16_t subid, uint8_t monitor_id,
 		      struct vmbus_channel **new_chan);
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index f857244c85..96d16ff545 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -171,7 +171,11 @@ vmbus_probe_all_drivers(struct rte_vmbus_device *dev)
 static bool
 vmbus_ignore_device(struct rte_vmbus_device *dev)
 {
-	struct rte_devargs *devargs = vmbus_devargs_lookup(dev);
+	char name[RTE_DEV_NAME_MAX_LEN];
+	struct rte_devargs *devargs;
+
+	rte_uuid_unparse(dev->device_id, name, sizeof(name));
+	devargs = rte_bus_find_devargs(&rte_vmbus_bus.bus, name);
 
 	switch (rte_vmbus_bus.bus.conf.scan_mode) {
 	case RTE_BUS_SCAN_ALLOWLIST:
@@ -260,25 +264,16 @@ vmbus_parse(const char *name, void *addr)
 	return ret;
 }
 
-/*
- * scan for matching device args on command line
- * example:
- *	-a 'vmbus:635a7ae3-091e-4410-ad59-667c4f8c04c3,latency=20'
- */
-struct rte_devargs *
-vmbus_devargs_lookup(struct rte_vmbus_device *dev)
+static int
+vmbus_devname_compare(const char *name1, const char *name2)
 {
-	struct rte_devargs *devargs;
-	rte_uuid_t addr;
-
-	RTE_EAL_DEVARGS_FOREACH(rte_vmbus_bus.bus.name, devargs) {
-		vmbus_parse(devargs->name, &addr);
+	rte_uuid_t guid1, guid2;
 
-		if (rte_uuid_compare(dev->device_id, addr) == 0)
-			return devargs;
-	}
-	return NULL;
+	if (vmbus_parse(name1, &guid1) != 0 ||
+			vmbus_parse(name2, &guid2) != 0)
+		return 1;
 
+	return rte_uuid_compare(guid1, guid2);
 }
 
 /* register vmbus driver */
@@ -349,6 +344,7 @@ struct rte_vmbus_bus rte_vmbus_bus = {
 		.cleanup = rte_vmbus_cleanup,
 		.find_device = vmbus_find_device,
 		.parse = vmbus_parse,
+		.devname_compare = vmbus_devname_compare,
 	},
 	.device_list = TAILQ_HEAD_INITIALIZER(rte_vmbus_bus.device_list),
 	.driver_list = TAILQ_HEAD_INITIALIZER(rte_vmbus_bus.driver_list),
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 9a8213bbbe..136ac511ef 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -247,16 +247,6 @@ idxd_probe_dsa(struct rte_dsa_device *dev)
 	return 0;
 }
 
-static int search_devargs(const char *name)
-{
-	struct rte_devargs *devargs;
-	RTE_EAL_DEVARGS_FOREACH(dsa_bus.bus.name, devargs) {
-		if (strcmp(devargs->name, name) == 0)
-			return 1;
-	}
-	return 0;
-}
-
 static int
 is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
 {
@@ -275,9 +265,9 @@ is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
 
 	if (retval && dsa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_UNDEFINED) {
 		if (dsa_bus.bus.conf.scan_mode == RTE_BUS_SCAN_ALLOWLIST)
-			retval = search_devargs(dev->device.name);
+			retval = rte_bus_find_devargs(&dsa_bus.bus, dev->device.name) != NULL;
 		else
-			retval = !search_devargs(dev->device.name);
+			retval = rte_bus_find_devargs(&dsa_bus.bus, dev->device.name) == NULL;
 	}
 
 	return retval;
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 0a2311a342..863c7418bb 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -8,6 +8,7 @@
 
 #include <bus_driver.h>
 #include <rte_debug.h>
+#include <rte_devargs.h>
 #include <rte_string_fns.h>
 #include <rte_errno.h>
 
@@ -205,6 +206,25 @@ rte_bus_find_by_name(const char *busname)
 	return rte_bus_find(NULL, cmp_bus_name, (const void *)busname);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_find_devargs)
+struct rte_devargs *
+rte_bus_find_devargs(const struct rte_bus *bus, const char *name)
+{
+	rte_bus_devname_compare_t cmp = bus->devname_compare;
+	struct rte_devargs *devargs;
+
+	if (cmp == NULL)
+		cmp = strcmp;
+
+	RTE_EAL_DEVARGS_FOREACH(rte_bus_name(bus), devargs) {
+		if (cmp(name, devargs->name) != 0)
+			continue;
+		return devargs;
+	}
+
+	return NULL;
+}
+
 static int
 bus_can_parse(const struct rte_bus *bus, const void *_name)
 {
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 60527b75b6..0760b09b8f 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -118,6 +118,22 @@ typedef int (*rte_bus_unplug_t)(struct rte_device *dev);
  */
 typedef int (*rte_bus_parse_t)(const char *name, void *addr);
 
+/**
+ * Bus specific device name comparison function.
+ * Bus can normalize the names of devices using an internal representation.
+ * This helper makes it possible to check whether two names refer to the same device.
+ *
+ * @param[in] name1
+ *	device name
+ * @param[in] name2
+ *	device name
+ *
+ * @return
+ *      0 if the two names refer to the same device.
+ *      !0 otherwise.
+ */
+typedef int (*rte_bus_devname_compare_t)(const char *name1, const char *name2);
+
 /**
  * Parse bus part of the device arguments.
  *
@@ -258,6 +274,7 @@ struct rte_bus {
 	rte_bus_plug_t plug;         /**< Probe single device for drivers */
 	rte_bus_unplug_t unplug;     /**< Remove single device from driver */
 	rte_bus_parse_t parse;       /**< Parse a device name */
+	rte_bus_devname_compare_t devname_compare; /**< Compare two device names */
 	rte_bus_devargs_parse_t devargs_parse; /**< Parse bus devargs */
 	rte_dev_dma_map_t dma_map;   /**< DMA map for device in the bus */
 	rte_dev_dma_unmap_t dma_unmap; /**< DMA unmap for device in the bus */
@@ -281,6 +298,21 @@ struct rte_bus {
 __rte_internal
 void rte_bus_register(struct rte_bus *bus);
 
+/**
+ * Find the devargs associated to a device.
+ *
+ * @param bus
+ *   A pointer to a rte_bus structure describing the bus
+ *   to search for devargs on.
+ * @param dev_name
+ *   A device name.
+ *
+ * @return
+ *   Pointer to the device devargs, or NULL if none found.
+ */
+__rte_internal
+struct rte_devargs *rte_bus_find_devargs(const struct rte_bus *bus, const char *dev_name);
+
 /**
  * Helper for Bus registration.
  * The constructor has higher priority than PMD constructors.
-- 
2.53.0

