Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D659EFD8FD4
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:21:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ED4140669;
	Thu, 26 Feb 2026 17:21:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CF82E40649
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772122892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcISnb8oEY/tPBUKLRcZvCWhDYW1VbaxPZWaqLFT1AA=;
 b=BfmPAl6qmfDlC6gBh7zc6s3WVqv4VadVpHJ59n8xsN5jUVgjTlP5TAhYFSwohS6P1CX+/Z
 tL9sy0ZCi16ALPl2AsZvJYqtIM96nR+faRbA7hikF5MVZUtIOLdKNJTYsaGQ+mciuzuTn6
 URo5zf9nUXocAtbgLYKXQn2kD4l1dyQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-OHc6G7pJOTmgw36eH0qsig-1; Thu,
 26 Feb 2026 11:21:26 -0500
X-MC-Unique: OHc6G7pJOTmgw36eH0qsig-1
X-Mimecast-MFC-AGG-ID: OHc6G7pJOTmgw36eH0qsig_1772122884
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 620A318004BB; Thu, 26 Feb 2026 16:21:24 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.223])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C6DD19560B5; Thu, 26 Feb 2026 16:21:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [RFC v2 4/5] bus: factorize device selection
Date: Thu, 26 Feb 2026 17:20:55 +0100
Message-ID: <20260226162057.207202-5-david.marchand@redhat.com>
In-Reply-To: <20260226162057.207202-1-david.marchand@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YoI9KoFfw6hhBfbHz3SX17bS34K9j2DF239oB6SjFgU_1772122884
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
---
 drivers/bus/auxiliary/auxiliary_common.c | 15 +----------
 drivers/bus/cdx/cdx.c                    | 21 +---------------
 drivers/bus/dpaa/dpaa_bus.c              | 24 ++++++------------
 drivers/bus/fslmc/fslmc_bus.c            | 22 ++++++----------
 drivers/bus/pci/pci_common.c             | 15 +----------
 drivers/bus/platform/platform.c          | 28 ++-------------------
 drivers/bus/uacce/uacce.c                | 22 +---------------
 drivers/bus/vmbus/vmbus_common.c         | 21 +---------------
 drivers/dma/idxd/idxd_bus.c              | 32 +++++++++---------------
 lib/eal/common/eal_common_bus.c          | 18 +++++++++++++
 lib/eal/include/bus_driver.h             |  7 ++++++
 11 files changed, 58 insertions(+), 167 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index ac766e283e..5baf76441a 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -399,20 +399,7 @@ auxiliary_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 bool
 auxiliary_is_ignored_device(const char *name)
 {
-	struct rte_devargs *devargs = auxiliary_devargs_lookup(name);
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
+	return rte_bus_is_ignored_device(&auxiliary_bus.bus, auxiliary_devargs_lookup(name));
 }
 
 static enum rte_iova_mode
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 729d54337c..ce0da41b82 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -164,25 +164,6 @@ cdx_devargs_lookup(const char *dev_name)
 	return NULL;
 }
 
-static bool
-cdx_ignore_device(const char *dev_name)
-{
-	struct rte_devargs *devargs = cdx_devargs_lookup(dev_name);
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
@@ -282,7 +263,7 @@ cdx_scan(void)
 		if (e->d_name[0] == '.')
 			continue;
 
-		if (cdx_ignore_device(e->d_name))
+		if (rte_bus_is_ignored_device(&rte_cdx_bus.bus, cdx_devargs_lookup(e->d_name)))
 			continue;
 
 		snprintf(dirname, sizeof(dirname), "%s/%s",
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 5e0f32bfe8..bc1dbf3592 100644
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
+			if (rte_bus_is_ignored_device(&rte_dpaa_bus.bus, dev->device.devargs))
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
index ac9fb7a08c..27ef84659a 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -410,7 +410,6 @@ static int
 rte_fslmc_probe(void)
 {
 	int ret = 0;
-	int probe_all;
 
 	struct rte_dpaa2_device *dev;
 	struct rte_dpaa2_driver *drv;
@@ -457,8 +456,6 @@ rte_fslmc_probe(void)
 		return 0;
 	}
 
-	probe_all = rte_fslmc_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST;
-
 	TAILQ_FOREACH(dev, &rte_fslmc_bus.device_list, next) {
 		TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
 			ret = rte_fslmc_match(drv, dev);
@@ -468,23 +465,18 @@ rte_fslmc_probe(void)
 			if (rte_dev_is_probed(&dev->device))
 				continue;
 
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+			if (rte_bus_is_ignored_device(&rte_fslmc_bus.bus, dev->device.devargs)) {
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
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index bf5df3d94e..c5cc9db9cf 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -721,20 +721,7 @@ pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 bool
 rte_pci_ignore_device(const struct rte_pci_addr *pci_addr)
 {
-	struct rte_devargs *devargs = pci_devargs_lookup(pci_addr);
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
+	return rte_bus_is_ignored_device(&rte_pci_bus.bus, pci_devargs_lookup(pci_addr));
 }
 
 enum rte_iova_mode
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index f6673cf181..21f8240e28 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -56,30 +56,6 @@ dev_devargs(const char *dev_name)
 	return NULL;
 }
 
-static bool
-dev_allowed(const char *dev_name)
-{
-	struct rte_devargs *devargs;
-
-	devargs = dev_devargs(dev_name);
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
@@ -173,7 +149,7 @@ platform_bus_scan(void)
 		if (dev_name[0] == '.')
 			continue;
 
-		if (!dev_allowed(dev_name))
+		if (rte_bus_is_ignored_device(&platform_bus.bus, dev_devargs(dev_name)))
 			continue;
 
 		if (!dev_is_bound_vfio_platform(dev_name))
@@ -497,7 +473,7 @@ platform_bus_plug(struct rte_device *dev)
 {
 	struct rte_platform_device *pdev;
 
-	if (!dev_allowed(dev->name))
+	if (rte_bus_is_ignored_device(&platform_bus.bus, dev->devargs))
 		return -EPERM;
 
 	if (!dev_is_bound_vfio_platform(dev->name))
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 79f990c54c..bf04e22057 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -84,26 +84,6 @@ uacce_devargs_lookup(const char *dev_name)
 	return NULL;
 }
 
-static bool
-uacce_ignore_device(const char *dev_name)
-{
-	struct rte_devargs *devargs = uacce_devargs_lookup(dev_name);
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
@@ -310,7 +290,7 @@ uacce_scan(void)
 			continue;
 		}
 
-		if (uacce_ignore_device(e->d_name))
+		if (rte_bus_is_ignored_device(&uacce_bus.bus, uacce_devargs_lookup(e->d_name)))
 			continue;
 
 		if (uacce_scan_one(e->d_name) < 0)
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index a787d8b18d..c386bf02c4 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -168,25 +168,6 @@ vmbus_probe_all_drivers(struct rte_vmbus_device *dev)
 	return 1;
 }
 
-static bool
-vmbus_ignore_device(struct rte_vmbus_device *dev)
-{
-	struct rte_devargs *devargs = vmbus_devargs_lookup(dev);
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
@@ -205,7 +186,7 @@ rte_vmbus_probe(void)
 
 		rte_uuid_unparse(dev->device_id, ubuf, sizeof(ubuf));
 
-		if (vmbus_ignore_device(dev))
+		if (rte_bus_is_ignored_device(&rte_vmbus_bus.bus, vmbus_devargs_lookup((dev))))
 			continue;
 
 		if (vmbus_probe_all_drivers(dev) < 0) {
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 9a8213bbbe..2e96039334 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -6,6 +6,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <stdbool.h>
 #include <libgen.h>
 
 #include <bus_driver.h>
@@ -247,40 +248,32 @@ idxd_probe_dsa(struct rte_dsa_device *dev)
 	return 0;
 }
 
-static int search_devargs(const char *name)
+static const struct rte_devargs *search_devargs(const char *name)
 {
 	struct rte_devargs *devargs;
 	RTE_EAL_DEVARGS_FOREACH(dsa_bus.bus.name, devargs) {
 		if (strcmp(devargs->name, name) == 0)
-			return 1;
+			return devargs;
 	}
-	return 0;
+	return NULL;
 }
 
-static int
+static bool
 is_for_this_process_use(struct rte_dsa_device *dev, const char *name)
 {
 	char prefix[256];
-	int retval = 0;
 	size_t prefixlen;
 
 	prefixlen = rte_basename(rte_eal_get_runtime_dir(), prefix, sizeof(prefix));
 	if (prefixlen >= sizeof(prefix) || strcmp(prefix, ".") == 0)
-		return retval;
-
-	if (strncmp(name, "dpdk_", 5) == 0)
-		retval = 1;
-	if (strncmp(name, prefix, prefixlen) == 0 && name[prefixlen] == '_')
-		retval = 1;
-
-	if (retval && dsa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_UNDEFINED) {
-		if (dsa_bus.bus.conf.scan_mode == RTE_BUS_SCAN_ALLOWLIST)
-			retval = search_devargs(dev->device.name);
-		else
-			retval = !search_devargs(dev->device.name);
+		return false;
+
+	if (strncmp(name, "dpdk_", 5) == 0 ||
+			(strncmp(name, prefix, prefixlen) == 0 && name[prefixlen] == '_')) {
+		return !rte_bus_is_ignored_device(&dsa_bus.bus, search_devargs(dev->device.name));
 	}
 
-	return retval;
+	return false;
 }
 
 static int
@@ -295,8 +288,7 @@ dsa_probe(void)
 				read_wq_string(dev, "name", name, sizeof(name)) < 0)
 			continue;
 
-		if (strncmp(type, "user", 4) == 0 &&
-				is_for_this_process_use(dev, name)) {
+		if (strncmp(type, "user", 4) == 0 && is_for_this_process_use(dev, name)) {
 			dev->device.driver = &dsa_bus.driver;
 			idxd_probe_dsa(dev);
 			continue;
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 0a2311a342..fbe20cfe35 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -8,6 +8,7 @@
 
 #include <bus_driver.h>
 #include <rte_debug.h>
+#include <rte_devargs.h>
 #include <rte_string_fns.h>
 #include <rte_errno.h>
 
@@ -226,6 +227,23 @@ rte_bus_find_by_device_name(const char *str)
 	return rte_bus_find(NULL, bus_can_parse, name);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_is_ignored_device)
+bool
+rte_bus_is_ignored_device(const struct rte_bus *bus, const struct rte_devargs *devargs)
+{
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
index 60527b75b6..1ec1ff57bb 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -302,6 +302,13 @@ RTE_INIT_PRIO(businitfn_ ##nm, BUS) \
 __rte_internal
 void rte_bus_unregister(struct rte_bus *bus);
 
+/**
+ * Indicate if a device referenced by some devargs should be skipped during
+ * probing of a bus.
+ */
+__rte_internal
+bool rte_bus_is_ignored_device(const struct rte_bus *bus, const struct rte_devargs *devargs);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

