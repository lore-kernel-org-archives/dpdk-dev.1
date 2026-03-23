Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84600EC01C4
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:53:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF236402D6;
	Mon, 23 Mar 2026 11:53:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 340A940669
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:53:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774263236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62BlZHKr4Bsp46kxdFf7NABrqZJcJlcbyYKcyW3aTzY=;
 b=UX4+P7kshJrAJtqa7+vjeHCWw3lUl+DQ1UU8aiKSA+h7ie5FYN19fwxy3alIt/hdwt4Mpi
 VgZEeStmeujlLwPOWiiupk9K7s3gLzRFpUJlb8ZJE01HGY8jGYvqnPeUb2hXD7k6wEk5dC
 DQXj0eBhtfz34L8IzgSt0NM+5WryvU0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-86CgIbwUNqqI_MWPxZ4-CQ-1; Mon,
 23 Mar 2026 06:53:53 -0400
X-MC-Unique: 86CgIbwUNqqI_MWPxZ4-CQ-1
X-Mimecast-MFC-AGG-ID: 86CgIbwUNqqI_MWPxZ4-CQ_1774263231
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89A7018005BA; Mon, 23 Mar 2026 10:53:51 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA10C19560B7; Mon, 23 Mar 2026 10:53:46 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH 6/8] bus: factorize device selection
Date: Mon, 23 Mar 2026 11:53:00 +0100
Message-ID: <20260323105306.1531689-7-david.marchand@redhat.com>
In-Reply-To: <20260323105306.1531689-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AyfmzZ2UnDbhGkFjALKQLfOyXh6pGbwCkCQT11UDhbo_1774263231
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

All buses (thankfully) implement the same logic when it comes to
selecting the devices to probe based on -a/-b options.
As we want to adjust how devices are selected, provide a common helper
in EAL and use it in the buses.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Reviewed-by: Robin Jarry <rjarry@redhat.com>
---
Changes since RFC v2:
- changed API to query about a device name and hide the devargs meaning
  in the common code,

---
 drivers/bus/auxiliary/auxiliary_common.c | 19 ----------------
 drivers/bus/auxiliary/linux/auxiliary.c  |  2 +-
 drivers/bus/auxiliary/private.h          |  6 -----
 drivers/bus/cdx/cdx.c                    | 21 +-----------------
 drivers/bus/dpaa/dpaa_bus.c              | 24 ++++++--------------
 drivers/bus/fslmc/fslmc_bus.c            | 22 ++++++-------------
 drivers/bus/pci/bsd/pci.c                |  5 ++++-
 drivers/bus/pci/linux/pci.c              |  2 +-
 drivers/bus/pci/pci_common.c             | 23 -------------------
 drivers/bus/pci/private.h                | 11 ----------
 drivers/bus/pci/windows/pci.c            |  4 +++-
 drivers/bus/platform/platform.c          | 28 ++----------------------
 drivers/bus/uacce/uacce.c                | 22 +------------------
 drivers/bus/vmbus/vmbus_common.c         | 25 +--------------------
 drivers/dma/idxd/idxd_bus.c              |  8 ++-----
 lib/eal/common/eal_common_bus.c          | 19 ++++++++++++++++
 lib/eal/include/bus_driver.h             |  6 +++++
 17 files changed, 55 insertions(+), 192 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index e5b4f4460d..8f3e90eaf0 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -384,25 +384,6 @@ auxiliary_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 	return aux_dev->driver->dma_unmap(aux_dev, addr, iova, len);
 }
 
-bool
-auxiliary_is_ignored_device(const char *name)
-{
-	struct rte_devargs *devargs = rte_bus_find_devargs(&auxiliary_bus.bus, name);
-
-	switch (auxiliary_bus.bus.conf.scan_mode) {
-	case RTE_BUS_SCAN_ALLOWLIST:
-		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
-			return false;
-		break;
-	case RTE_BUS_SCAN_UNDEFINED:
-	case RTE_BUS_SCAN_BLOCKLIST:
-		if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
-			return false;
-		break;
-	}
-	return true;
-}
-
 static enum rte_iova_mode
 auxiliary_get_iommu_class(void)
 {
diff --git a/drivers/bus/auxiliary/linux/auxiliary.c b/drivers/bus/auxiliary/linux/auxiliary.c
index 02fc9285dc..ac9bf55efa 100644
--- a/drivers/bus/auxiliary/linux/auxiliary.c
+++ b/drivers/bus/auxiliary/linux/auxiliary.c
@@ -110,7 +110,7 @@ auxiliary_scan(void)
 		if (e->d_name[0] == '.')
 			continue;
 
-		if (auxiliary_is_ignored_device(e->d_name))
+		if (rte_bus_is_ignored_device(&auxiliary_bus.bus, e->d_name))
 			continue;
 
 		snprintf(dirname, sizeof(dirname), "%s/%s",
diff --git a/drivers/bus/auxiliary/private.h b/drivers/bus/auxiliary/private.h
index 4604f6f4a7..6e61a5f494 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -53,12 +53,6 @@ int auxiliary_scan(void);
  */
 void auxiliary_on_scan(struct rte_auxiliary_device *aux_dev);
 
-/*
- * Validate whether a device with given auxiliary device should be ignored
- * or not.
- */
-bool auxiliary_is_ignored_device(const char *name);
-
 /*
  * Add an auxiliary device to the auxiliary bus (append to auxiliary device
  * list). This function also updates the bus references of the auxiliary
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 0801825ef5..58d8c8b4da 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -151,25 +151,6 @@ void rte_cdx_unmap_device(struct rte_cdx_device *dev)
 	cdx_vfio_unmap_resource(dev);
 }
 
-static bool
-cdx_ignore_device(const char *dev_name)
-{
-	struct rte_devargs *devargs = rte_bus_find_devargs(&rte_cdx_bus.bus, dev_name);
-
-	switch (rte_cdx_bus.bus.conf.scan_mode) {
-	case RTE_BUS_SCAN_ALLOWLIST:
-		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
-			return false;
-		break;
-	case RTE_BUS_SCAN_UNDEFINED:
-	case RTE_BUS_SCAN_BLOCKLIST:
-		if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
-			return false;
-		break;
-	}
-	return true;
-}
-
 /*
  * Scan one cdx sysfs entry, and fill the devices list from it.
  * It checks if the CDX device is bound to vfio-cdx driver. In case
@@ -269,7 +250,7 @@ cdx_scan(void)
 		if (e->d_name[0] == '.')
 			continue;
 
-		if (cdx_ignore_device(e->d_name))
+		if (rte_bus_is_ignored_device(&rte_cdx_bus.bus, e->d_name))
 			continue;
 
 		snprintf(dirname, sizeof(dirname), "%s/%s",
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 356c56d989..9ff58af0c4 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -717,7 +717,6 @@ rte_dpaa_bus_probe(void)
 	struct rte_dpaa_driver *drv;
 	FILE *svr_file = NULL;
 	uint32_t svr_ver;
-	int probe_all = rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST;
 	static int process_once;
 	char *penv;
 
@@ -725,9 +724,6 @@ rte_dpaa_bus_probe(void)
 	if (!rte_dpaa_bus.detected)
 		return 0;
 
-	if (rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST)
-		probe_all = true;
-
 	svr_file = fopen(DPAA_SOC_ID_FILE, "r");
 	if (svr_file) {
 		if (fscanf(svr_file, "svr:%x", &svr_ver) > 0)
@@ -809,21 +805,15 @@ rte_dpaa_bus_probe(void)
 			if (rte_dev_is_probed(&dev->device))
 				continue;
 
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
+			if (rte_bus_is_ignored_device(&rte_dpaa_bus.bus, dev->name))
 				continue;
 
-			if (probe_all ||
-			    (dev->device.devargs &&
-			     dev->device.devargs->policy == RTE_DEV_ALLOWED)) {
-				ret = drv->probe(drv, dev);
-				if (ret) {
-					DPAA_BUS_ERR("unable to probe:%s",
-						     dev->name);
-				} else {
-					dev->driver = drv;
-					dev->device.driver = &drv->driver;
-				}
+			ret = drv->probe(drv, dev);
+			if (ret) {
+				DPAA_BUS_ERR("unable to probe: %s", dev->name);
+			} else {
+				dev->driver = drv;
+				dev->device.driver = &drv->driver;
 			}
 			break;
 		}
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index f72b512b1a..b5d839b6b0 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -407,7 +407,6 @@ static int
 rte_fslmc_probe(void)
 {
 	int ret = 0;
-	int probe_all;
 
 	struct rte_dpaa2_device *dev;
 	struct rte_dpaa2_driver *drv;
@@ -454,8 +453,6 @@ rte_fslmc_probe(void)
 		return 0;
 	}
 
-	probe_all = rte_fslmc_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST;
-
 	TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next) {
 		TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
 			ret = rte_fslmc_match(drv, dev);
@@ -465,23 +462,18 @@ rte_fslmc_probe(void)
 			if (rte_dev_is_probed(&dev->device))
 				continue;
 
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+			if (rte_bus_is_ignored_device(&rte_fslmc_bus.bus, dev->device.name)) {
 				DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
 					      dev->device.name);
 				continue;
 			}
 
-			if (probe_all ||
-			   (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_ALLOWED)) {
-				ret = drv->probe(drv, dev);
-				if (ret) {
-					DPAA2_BUS_ERR("Unable to probe");
-				} else {
-					dev->driver = drv;
-					dev->device.driver = &drv->driver;
-				}
+			ret = drv->probe(drv, dev);
+			if (ret) {
+				DPAA2_BUS_ERR("Unable to probe");
+			} else {
+				dev->driver = drv;
+				dev->device.driver = &drv->driver;
 			}
 			break;
 		}
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 3f13e1d6ac..ffd84ee5f0 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -370,12 +370,15 @@ rte_pci_scan(void)
 		}
 
 		for (i = 0; i < conf_io.num_matches; i++) {
+			char name[RTE_DEV_NAME_MAX_LEN];
+
 			pci_addr.domain = matches[i].pc_sel.pc_domain;
 			pci_addr.bus = matches[i].pc_sel.pc_bus;
 			pci_addr.devid = matches[i].pc_sel.pc_dev;
 			pci_addr.function = matches[i].pc_sel.pc_func;
+			rte_pci_device_name(&pci_addr, name, sizeof(name));
 
-			if (rte_pci_ignore_device(&pci_addr))
+			if (rte_bus_is_ignored_device(&rte_pci_bus.bus, name))
 				continue;
 
 			if (pci_scan_one(fd, &matches[i]) < 0)
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 2ffac82e94..03a3c37dea 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -458,7 +458,7 @@ rte_pci_scan(void)
 		if (parse_pci_addr_format(e->d_name, sizeof(e->d_name), &addr) != 0)
 			continue;
 
-		if (rte_pci_ignore_device(&addr))
+		if (rte_bus_is_ignored_device(&rte_pci_bus.bus, e->d_name))
 			continue;
 
 		snprintf(dirname, sizeof(dirname), "%s/%s",
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 8782dc342a..5ef9e80e3e 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -713,29 +713,6 @@ pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 	return -1;
 }
 
-bool
-rte_pci_ignore_device(const struct rte_pci_addr *pci_addr)
-{
-	char name[RTE_DEV_NAME_MAX_LEN];
-	struct rte_devargs *devargs;
-
-	rte_pci_device_name(pci_addr, name, sizeof(name));
-	devargs = rte_bus_find_devargs(&rte_pci_bus.bus, name);
-
-	switch (rte_pci_bus.bus.conf.scan_mode) {
-	case RTE_BUS_SCAN_ALLOWLIST:
-		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
-			return false;
-		break;
-	case RTE_BUS_SCAN_UNDEFINED:
-	case RTE_BUS_SCAN_BLOCKLIST:
-		if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
-			return false;
-		break;
-	}
-	return true;
-}
-
 enum rte_iova_mode
 rte_pci_get_iommu_class(void)
 {
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index 38109844b9..8591c4a0a7 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -82,17 +82,6 @@ pci_common_set(struct rte_pci_device *dev);
 void
 pci_free(struct rte_pci_device_internal *pdev);
 
-/**
- * Validate whether a device with given PCI address should be ignored or not.
- *
- * @param pci_addr
- *	PCI address of device to be validated
- * @return
- *	true: if device is to be ignored,
- *	false: if device is to be scanned,
- */
-bool rte_pci_ignore_device(const struct rte_pci_addr *pci_addr);
-
 /**
  * Add a PCI device to the PCI Bus (append to PCI Device list). This function
  * also updates the bus references of the PCI Device (and the generic device
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index a5ce3b51f7..91c8e567d1 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -373,6 +373,7 @@ pci_scan_one(HDEVINFO dev_info, PSP_DEVINFO_DATA device_info_data)
 	struct rte_pci_device *dev = NULL;
 	int ret = -1;
 	char  pci_device_info[REGSTR_VAL_MAX_HCID_LEN];
+	char name[RTE_DEV_NAME_MAX_LEN];
 	struct rte_pci_addr addr;
 	struct rte_pci_id pci_id;
 
@@ -380,7 +381,8 @@ pci_scan_one(HDEVINFO dev_info, PSP_DEVINFO_DATA device_info_data)
 	if (ret != 0)
 		goto end;
 
-	if (rte_pci_ignore_device(&addr)) {
+	rte_pci_device_name(&addr, name, sizeof(name));
+	if (rte_bus_is_ignored_device(&rte_pci_bus.bus, name)) {
 		/*
 		 * We won't add this device, but we want to continue
 		 * looking for supported devices
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 23c39aada6..ad7898f011 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -43,30 +43,6 @@ rte_platform_unregister(struct rte_platform_driver *pdrv)
 	TAILQ_REMOVE(&platform_bus.driver_list, pdrv, next);
 }
 
-static bool
-dev_allowed(const char *dev_name)
-{
-	struct rte_devargs *devargs;
-
-	devargs = rte_bus_find_devargs(&platform_bus.bus, dev_name);
-	if (devargs == NULL)
-		return true;
-
-	switch (platform_bus.bus.conf.scan_mode) {
-	case RTE_BUS_SCAN_UNDEFINED:
-	case RTE_BUS_SCAN_ALLOWLIST:
-		if (devargs->policy == RTE_DEV_ALLOWED)
-			return true;
-		break;
-	case RTE_BUS_SCAN_BLOCKLIST:
-		if (devargs->policy == RTE_DEV_BLOCKED)
-			return false;
-		break;
-	}
-
-	return true;
-}
-
 static int
 dev_add(const char *dev_name)
 {
@@ -160,7 +136,7 @@ platform_bus_scan(void)
 		if (dev_name[0] == '.')
 			continue;
 
-		if (!dev_allowed(dev_name))
+		if (rte_bus_is_ignored_device(&platform_bus.bus, dev_name))
 			continue;
 
 		if (!dev_is_bound_vfio_platform(dev_name))
@@ -484,7 +460,7 @@ platform_bus_plug(struct rte_device *dev)
 {
 	struct rte_platform_device *pdev;
 
-	if (!dev_allowed(dev->name))
+	if (rte_bus_is_ignored_device(&platform_bus.bus, dev->name))
 		return -EPERM;
 
 	if (!dev_is_bound_vfio_platform(dev->name))
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index e6963dc18a..ee02ecd1ce 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -70,26 +70,6 @@ extern int uacce_bus_logtype;
 #define UACCE_BUS_DEBUG(fmt, ...) UACCE_BUS_LOG(DEBUG, fmt, ##__VA_ARGS__)
 
 
-static bool
-uacce_ignore_device(const char *dev_name)
-{
-	struct rte_devargs *devargs = rte_bus_find_devargs(&uacce_bus.bus, dev_name);
-
-	switch (uacce_bus.bus.conf.scan_mode) {
-	case RTE_BUS_SCAN_ALLOWLIST:
-		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
-			return false;
-		break;
-	case RTE_BUS_SCAN_UNDEFINED:
-	case RTE_BUS_SCAN_BLOCKLIST:
-		if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
-			return false;
-		break;
-	}
-
-	return true;
-}
-
 /*
  * Returns the number of bytes read (removed last newline) on success.
  * Otherwise negative value is returned.
@@ -296,7 +276,7 @@ uacce_scan(void)
 			continue;
 		}
 
-		if (uacce_ignore_device(e->d_name))
+		if (rte_bus_is_ignored_device(&uacce_bus.bus, e->d_name))
 			continue;
 
 		if (uacce_scan_one(e->d_name) < 0)
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 96d16ff545..a9eb7cf933 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -168,29 +168,6 @@ vmbus_probe_all_drivers(struct rte_vmbus_device *dev)
 	return 1;
 }
 
-static bool
-vmbus_ignore_device(struct rte_vmbus_device *dev)
-{
-	char name[RTE_DEV_NAME_MAX_LEN];
-	struct rte_devargs *devargs;
-
-	rte_uuid_unparse(dev->device_id, name, sizeof(name));
-	devargs = rte_bus_find_devargs(&rte_vmbus_bus.bus, name);
-
-	switch (rte_vmbus_bus.bus.conf.scan_mode) {
-	case RTE_BUS_SCAN_ALLOWLIST:
-		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
-			return false;
-		break;
-	case RTE_BUS_SCAN_UNDEFINED:
-	case RTE_BUS_SCAN_BLOCKLIST:
-		if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
-			return false;
-		break;
-	}
-	return true;
-}
-
 /*
  * Scan the vmbus, and call the devinit() function for
  * all registered drivers that have a matching entry in its id_table
@@ -209,7 +186,7 @@ rte_vmbus_probe(void)
 
 		rte_uuid_unparse(dev->device_id, ubuf, sizeof(ubuf));
 
-		if (vmbus_ignore_device(dev))
+		if (rte_bus_is_ignored_device(&rte_vmbus_bus.bus, ubuf))
 			continue;
 
 		if (vmbus_probe_all_drivers(dev) < 0) {
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 136ac511ef..00e7e7315c 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -263,12 +263,8 @@ is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
 	if (strncmp(name, prefix, prefixlen) == 0 && name[prefixlen] == '_')
 		retval = 1;
 
-	if (retval && dsa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_UNDEFINED) {
-		if (dsa_bus.bus.conf.scan_mode == RTE_BUS_SCAN_ALLOWLIST)
-			retval = rte_bus_find_devargs(&dsa_bus.bus, dev->device.name) != NULL;
-		else
-			retval = rte_bus_find_devargs(&dsa_bus.bus, dev->device.name) == NULL;
-	}
+	if (retval && !rte_bus_is_ignored_device(&dsa_bus.bus, dev->device.name))
+		retval = 1;
 
 	return retval;
 }
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 863c7418bb..2ca0af7914 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -246,6 +246,25 @@ rte_bus_find_by_device_name(const char *str)
 	return rte_bus_find(NULL, bus_can_parse, name);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_is_ignored_device)
+bool
+rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name)
+{
+	struct rte_devargs *devargs = rte_bus_find_devargs(bus, dev_name);
+
+	switch (bus->conf.scan_mode) {
+	case RTE_BUS_SCAN_ALLOWLIST:
+		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
+			return false;
+		break;
+	case RTE_BUS_SCAN_UNDEFINED:
+	case RTE_BUS_SCAN_BLOCKLIST:
+		if (devargs == NULL || devargs->policy != RTE_DEV_BLOCKED)
+			return false;
+		break;
+	}
+	return true;
+}
 
 /*
  * Get iommu class of devices on the bus.
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 2a21e4ac54..e67e052404 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -312,6 +312,12 @@ void rte_bus_register(struct rte_bus *bus);
 __rte_internal
 struct rte_devargs *rte_bus_find_devargs(const struct rte_bus *bus, const char *dev_name);
 
+/**
+ * Indicate if a device should be skipped during probing of a bus.
+ */
+__rte_internal
+bool rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name);
+
 /**
  * Helper for Bus registration.
  * The constructor has higher priority than PMD constructors.
-- 
2.53.0

