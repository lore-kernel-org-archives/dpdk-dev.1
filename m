Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC247CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E0CA40664;
	Wed,  6 May 2026 17:53:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E71DD40693
 for <dev@dpdk.org>; Wed,  6 May 2026 17:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778082807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paY/IU6Qm72tqvrlllhmla26RGLZaZjzJy6vSQZsB8U=;
 b=Ns+1Ou21A8hWvwlK2Dt+g6kM9JKSsZ+4uKQgNZ29XIYQm/PI4s3qJKpiDmPv+4DAWlNx8J
 dbio7VhI1mE4iwLHiJQh5kB2+w7DC+FVhEjAswPClq9HnZP3qewBlbqKibgMdgo5m5O/d2
 Ix03MTeKfCMsiZJTQecB4YJnss08zLc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-btajy57iOZ6_ovJPfbLecA-1; Wed,
 06 May 2026 11:53:23 -0400
X-MC-Unique: btajy57iOZ6_ovJPfbLecA-1
X-Mimecast-MFC-AGG-ID: btajy57iOZ6_ovJPfbLecA_1778082795
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AB54180056E; Wed,  6 May 2026 15:53:15 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C954819560A3; Wed,  6 May 2026 15:53:09 +0000 (UTC)
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
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 09/23] bus: consolidate device lookup
Date: Wed,  6 May 2026 17:51:41 +0200
Message-ID: <20260506155201.2709810-10-david.marchand@redhat.com>
In-Reply-To: <20260506155201.2709810-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oAdoiwIdDUp6lbnN55F7mSUxSZHVxmB_ME2KS7b_Mfk_1778082795
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

A majority of bus drivers are repeating the pattern of looping on the
bus device_list and simply passing the device to the cmp callback.

Extend rte_bus_find_device_t so it takes a reference to the bus object
and add rte_bus_generic_find_device() to achieve the same.

Leave the vdev bus alone, as it has an internal locking requirement.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_vdev.c                     |  6 ++---
 drivers/bus/auxiliary/auxiliary_common.c | 21 +---------------
 drivers/bus/auxiliary/auxiliary_params.c |  4 +--
 drivers/bus/cdx/cdx.c                    | 25 ++----------------
 drivers/bus/dpaa/dpaa_bus.c              | 30 +---------------------
 drivers/bus/fslmc/fslmc_bus.c            | 32 +-----------------------
 drivers/bus/ifpga/ifpga_bus.c            | 19 +-------------
 drivers/bus/pci/pci_common.c             | 21 +---------------
 drivers/bus/pci/pci_params.c             |  4 +--
 drivers/bus/platform/platform.c          | 22 +---------------
 drivers/bus/platform/platform_params.c   |  9 +------
 drivers/bus/uacce/uacce.c                | 26 ++-----------------
 drivers/bus/vdev/vdev.c                  |  4 +--
 drivers/bus/vdev/vdev_params.c           |  2 +-
 drivers/bus/vdev/vdev_private.h          |  3 ++-
 drivers/bus/vmbus/vmbus_common.c         | 21 +---------------
 drivers/dma/idxd/idxd_bus.c              | 20 +--------------
 drivers/net/bonding/rte_eth_bond_args.c  |  2 +-
 drivers/net/vdev_netvsc/vdev_netvsc.c    |  2 +-
 drivers/raw/ifpga/ifpga_rawdev.c         |  2 +-
 lib/eal/common/eal_common_bus.c          | 21 +++++++++++++++-
 lib/eal/common/eal_common_dev.c          |  4 +--
 lib/eal/common/hotplug_mp.c              |  4 +--
 lib/eal/include/bus_driver.h             | 24 ++++++++++++++++--
 lib/eal/linux/eal_dev.c                  |  3 +--
 25 files changed, 73 insertions(+), 258 deletions(-)

diff --git a/app/test/test_vdev.c b/app/test/test_vdev.c
index 49286194c3..c82d996404 100644
--- a/app/test/test_vdev.c
+++ b/app/test/test_vdev.c
@@ -60,7 +60,7 @@ get_matching_vdev(const char *match_str)
 		}
 	}
 
-	dev = vdev_bus->find_device(NULL, cmp_dev_match, kvargs);
+	dev = vdev_bus->find_device(vdev_bus, NULL, cmp_dev_match, kvargs);
 	rte_kvargs_free(kvargs);
 
 	return dev;
@@ -82,7 +82,7 @@ test_vdev_bus(void)
 		printf("Failed to create vdev net_null_test0\n");
 		goto fail;
 	}
-	dev0 = vdev_bus->find_device(NULL, cmp_dev_name, "net_null_test0");
+	dev0 = vdev_bus->find_device(vdev_bus, NULL, cmp_dev_name, "net_null_test0");
 	if (dev0 == NULL) {
 		printf("Cannot find net_null_test0 vdev\n");
 		goto fail;
@@ -93,7 +93,7 @@ test_vdev_bus(void)
 		printf("Failed to create vdev net_null_test1\n");
 		goto fail;
 	}
-	dev1 = vdev_bus->find_device(NULL, cmp_dev_name, "net_null_test1");
+	dev1 = vdev_bus->find_device(vdev_bus, NULL, cmp_dev_name, "net_null_test1");
 	if (dev1 == NULL) {
 		printf("Cannot find net_null_test1 vdev\n");
 		goto fail;
diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index a1a3a747a5..eb0a27cc11 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -251,25 +251,6 @@ rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 	rte_bus_remove_driver(&auxiliary_bus.bus, &driver->driver);
 }
 
-static struct rte_device *
-auxiliary_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		      const void *data)
-{
-	struct rte_device *dev;
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT(start, next);
-	} else {
-		dev = TAILQ_FIRST(&auxiliary_bus.bus.device_list);
-	}
-	while (dev != NULL) {
-		if (cmp(dev, data) == 0)
-			return dev;
-		dev = TAILQ_NEXT(dev, next);
-	}
-	return NULL;
-}
-
 static int
 auxiliary_plug(struct rte_device *dev)
 {
@@ -358,7 +339,7 @@ struct rte_auxiliary_bus auxiliary_bus = {
 		.scan = auxiliary_scan,
 		.probe = auxiliary_probe,
 		.cleanup = auxiliary_cleanup,
-		.find_device = auxiliary_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.plug = auxiliary_plug,
 		.unplug = auxiliary_unplug,
 		.parse = auxiliary_parse,
diff --git a/drivers/bus/auxiliary/auxiliary_params.c b/drivers/bus/auxiliary/auxiliary_params.c
index e4c7ee0c3b..1a76155c67 100644
--- a/drivers/bus/auxiliary/auxiliary_params.c
+++ b/drivers/bus/auxiliary/auxiliary_params.c
@@ -45,7 +45,6 @@ auxiliary_dev_iterate(const void *start,
 		    const char *str,
 		    const struct rte_dev_iterator *it __rte_unused)
 {
-	rte_bus_find_device_t find_device;
 	struct rte_kvargs *kvargs = NULL;
 	struct rte_device *dev;
 
@@ -58,8 +57,7 @@ auxiliary_dev_iterate(const void *start,
 			return NULL;
 		}
 	}
-	find_device = auxiliary_bus.bus.find_device;
-	dev = find_device(start, auxiliary_dev_match, kvargs);
+	dev = rte_bus_generic_find_device(&auxiliary_bus.bus, start, auxiliary_dev_match, kvargs);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index bc221a4d00..45c6e8335d 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -449,25 +449,6 @@ rte_cdx_unregister(struct rte_cdx_driver *driver)
 	rte_bus_remove_driver(&rte_cdx_bus.bus, &driver->driver);
 }
 
-static struct rte_device *
-cdx_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		const void *data)
-{
-	struct rte_device *dev;
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT(start, next);
-	} else {
-		dev = TAILQ_FIRST(&rte_cdx_bus.bus.device_list);
-	}
-	while (dev != NULL) {
-		if (cmp(dev, data) == 0)
-			return dev;
-		dev = TAILQ_NEXT(dev, next);
-	}
-	return NULL;
-}
-
 /*
  * If vendor/device ID match, call the remove() function of the
  * driver.
@@ -572,7 +553,6 @@ cdx_dev_iterate(const void *start,
 		const char *str,
 		const struct rte_dev_iterator *it __rte_unused)
 {
-	rte_bus_find_device_t find_device;
 	struct rte_kvargs *kvargs = NULL;
 	struct rte_device *dev;
 
@@ -584,8 +564,7 @@ cdx_dev_iterate(const void *start,
 			return NULL;
 		}
 	}
-	find_device = rte_cdx_bus.bus.find_device;
-	dev = find_device(start, cdx_dev_match, kvargs);
+	dev = rte_bus_generic_find_device(&rte_cdx_bus.bus, start, cdx_dev_match, kvargs);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
@@ -594,7 +573,7 @@ struct rte_cdx_bus rte_cdx_bus = {
 	.bus = {
 		.scan = cdx_scan,
 		.probe = cdx_probe,
-		.find_device = cdx_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.plug = cdx_plug,
 		.unplug = cdx_unplug,
 		.parse = cdx_parse,
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 8305f8cb23..0bacc0e9d5 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -818,34 +818,6 @@ rte_dpaa_bus_probe(void)
 	return 0;
 }
 
-static struct rte_device *
-rte_dpaa_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		     const void *data)
-{
-	struct rte_device *dev;
-
-	/* find_device is called with 'data' as an opaque object - just call
-	 * cmp with this and each device object on bus.
-	 */
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT(start, next);
-	} else {
-		dev = TAILQ_FIRST(&rte_dpaa_bus.bus.device_list);
-	}
-
-	while (dev != NULL) {
-		if (cmp(dev, data) == 0) {
-			DPAA_BUS_DEBUG("Found dev=(%s)", dev->name);
-			return dev;
-		}
-		dev = TAILQ_NEXT(dev, next);
-	}
-
-	DPAA_BUS_DEBUG("Unable to find any device");
-	return NULL;
-}
-
 /*
  * Get iommu class of DPAA2 devices on the bus.
  */
@@ -972,7 +944,7 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.probe = rte_dpaa_bus_probe,
 		.parse = rte_dpaa_bus_parse,
 		.dev_compare = dpaa_bus_dev_compare,
-		.find_device = rte_dpaa_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = rte_dpaa_get_iommu_class,
 		.plug = dpaa_bus_plug,
 		.unplug = dpaa_bus_unplug,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 3e7f03375a..312145b712 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -479,36 +479,6 @@ rte_fslmc_probe(void)
 	return 0;
 }
 
-static struct rte_device *
-rte_fslmc_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		      const void *data)
-{
-	struct rte_device *dev;
-
-	DPAA2_BUS_DEBUG("Finding a device named %s", (const char *)data);
-
-	/* find_device is always called with an opaque object which should be
-	 * passed along to the 'cmp' function iterating over all device obj
-	 * on the bus.
-	 */
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT(start, next);
-	} else {
-		dev = TAILQ_FIRST(&rte_fslmc_bus.bus.device_list);
-	}
-	while (dev != NULL) {
-		if (cmp(dev, data) == 0) {
-			DPAA2_BUS_DEBUG("Found device (%s)",
-					dev->name);
-			return dev;
-		}
-		dev = TAILQ_NEXT(dev, next);
-	}
-
-	return NULL;
-}
-
 /*register a fslmc bus based dpaa2 driver */
 RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_register)
 void
@@ -674,7 +644,7 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 		.cleanup = rte_fslmc_close,
 		.parse = rte_fslmc_parse,
 		.dev_compare = fslmc_dev_compare,
-		.find_device = rte_fslmc_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = rte_dpaa2_get_iommu_class,
 		.plug = fslmc_bus_plug,
 		.unplug = fslmc_bus_unplug,
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 4edff5efd4..7d3331fe7e 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -403,23 +403,6 @@ ifpga_unplug(struct rte_device *dev)
 
 }
 
-static struct rte_device *
-ifpga_find_device(const struct rte_device *start,
-	rte_dev_cmp_t cmp, const void *data)
-{
-	struct rte_device *dev;
-
-	TAILQ_FOREACH(dev, &rte_ifpga_bus.device_list, next) {
-		if (start && dev == start) {
-			start = NULL;
-			continue;
-		}
-		if (cmp(dev, data) == 0)
-			return dev;
-	}
-
-	return NULL;
-}
 static int
 ifpga_parse(const char *name, void *addr)
 {
@@ -468,7 +451,7 @@ static struct rte_bus rte_ifpga_bus = {
 	.scan        = ifpga_scan,
 	.probe       = ifpga_probe,
 	.cleanup     = ifpga_cleanup,
-	.find_device = ifpga_find_device,
+	.find_device = rte_bus_generic_find_device,
 	.plug        = ifpga_plug,
 	.unplug      = ifpga_unplug,
 	.parse       = ifpga_parse,
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 94dc63d865..70ce63eac7 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -512,25 +512,6 @@ rte_pci_unregister(struct rte_pci_driver *driver)
 	rte_bus_remove_driver(&rte_pci_bus.bus, &driver->driver);
 }
 
-static struct rte_device *
-pci_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		const void *data)
-{
-	struct rte_device *dev;
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT(start, next);
-	} else {
-		dev = TAILQ_FIRST(&rte_pci_bus.bus.device_list);
-	}
-	while (dev != NULL) {
-		if (cmp(dev, data) == 0)
-			return dev;
-		dev = TAILQ_NEXT(dev, next);
-	}
-	return NULL;
-}
-
 /*
  * find the device which encounter the failure, by iterate over all device on
  * PCI bus to check if the memory failure address is located in the range
@@ -879,7 +860,7 @@ struct rte_pci_bus rte_pci_bus = {
 		.scan = rte_pci_scan,
 		.probe = pci_probe,
 		.cleanup = pci_cleanup,
-		.find_device = pci_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.plug = pci_plug,
 		.unplug = pci_unplug,
 		.parse = pci_parse,
diff --git a/drivers/bus/pci/pci_params.c b/drivers/bus/pci/pci_params.c
index d771d8d1ba..d596c3bba8 100644
--- a/drivers/bus/pci/pci_params.c
+++ b/drivers/bus/pci/pci_params.c
@@ -63,7 +63,6 @@ rte_pci_dev_iterate(const void *start,
 		    const char *str,
 		    const struct rte_dev_iterator *it __rte_unused)
 {
-	rte_bus_find_device_t find_device;
 	struct rte_kvargs *kvargs = NULL;
 	struct rte_device *dev;
 
@@ -75,8 +74,7 @@ rte_pci_dev_iterate(const void *start,
 			return NULL;
 		}
 	}
-	find_device = rte_pci_bus.bus.find_device;
-	dev = find_device(start, pci_dev_match, kvargs);
+	dev = rte_bus_generic_find_device(&rte_pci_bus.bus, start, pci_dev_match, kvargs);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 0c23e5d9b6..c795bd4b9c 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -437,26 +437,6 @@ platform_bus_probe(void)
 	return 0;
 }
 
-static struct rte_device *
-platform_bus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp, const void *data)
-{
-	struct rte_device *dev;
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT(start, next);
-	} else {
-		dev = RTE_TAILQ_FIRST(&platform_bus.bus.device_list);
-	}
-	while (dev) {
-		if (cmp(dev, data) == 0)
-			return dev;
-
-		dev = RTE_TAILQ_NEXT(dev, next);
-	}
-
-	return NULL;
-}
-
 static int
 platform_bus_plug(struct rte_device *dev)
 {
@@ -575,7 +555,7 @@ struct rte_platform_bus platform_bus = {
 	.bus = {
 		.scan = platform_bus_scan,
 		.probe = platform_bus_probe,
-		.find_device = platform_bus_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.plug = platform_bus_plug,
 		.unplug = platform_bus_unplug,
 		.parse = platform_bus_parse,
diff --git a/drivers/bus/platform/platform_params.c b/drivers/bus/platform/platform_params.c
index 65b20d121f..f8538a1d84 100644
--- a/drivers/bus/platform/platform_params.c
+++ b/drivers/bus/platform/platform_params.c
@@ -46,7 +46,6 @@ void *
 platform_bus_dev_iterate(const void *start, const char *str,
 			 const struct rte_dev_iterator *it __rte_unused)
 {
-	rte_bus_find_device_t find_device;
 	struct rte_kvargs *kvargs = NULL;
 	struct rte_device *dev;
 
@@ -59,13 +58,7 @@ platform_bus_dev_iterate(const void *start, const char *str,
 		}
 	}
 
-	find_device = platform_bus.bus.find_device;
-	if (find_device == NULL) {
-		rte_kvargs_free(kvargs);
-		return NULL;
-	}
-
-	dev = platform_bus.bus.find_device(start, platform_dev_match, kvargs);
+	dev = rte_bus_generic_find_device(&platform_bus.bus, start, platform_dev_match, kvargs);
 	rte_kvargs_free(kvargs);
 
 	return dev;
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 199517442d..ef133a6ae7 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -508,26 +508,6 @@ uacce_unplug(struct rte_device *dev)
 	return ret;
 }
 
-static struct rte_device *
-uacce_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,  const void *data)
-{
-	struct rte_device *dev;
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT(start, next);
-	} else {
-		dev = TAILQ_FIRST(&uacce_bus.bus.device_list);
-	}
-
-	while (dev != NULL) {
-		if (cmp(dev, data) == 0)
-			return dev;
-		dev = TAILQ_NEXT(dev, next);
-	}
-
-	return NULL;
-}
-
 static int
 uacce_parse(const char *name, void *addr)
 {
@@ -565,7 +545,6 @@ static void *
 uacce_dev_iterate(const void *start, const char *str,
 		  const struct rte_dev_iterator *it __rte_unused)
 {
-	rte_bus_find_device_t find_device;
 	struct rte_kvargs *kvargs = NULL;
 	struct rte_device *dev;
 
@@ -576,8 +555,7 @@ uacce_dev_iterate(const void *start, const char *str,
 			return NULL;
 		}
 	}
-	find_device = uacce_bus.bus.find_device;
-	dev = find_device(start, uacce_dev_match, kvargs);
+	dev = rte_bus_generic_find_device(&uacce_bus.bus, start, uacce_dev_match, kvargs);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
@@ -696,7 +674,7 @@ static struct rte_uacce_bus uacce_bus = {
 		.cleanup = uacce_cleanup,
 		.plug = uacce_plug,
 		.unplug = uacce_unplug,
-		.find_device = uacce_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.parse = uacce_parse,
 		.dev_iterate = uacce_dev_iterate,
 	},
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index db73b08c38..9b88df8bdc 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -577,8 +577,8 @@ vdev_cleanup(void)
 }
 
 struct rte_device *
-rte_vdev_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		     const void *data)
+rte_vdev_find_device(const struct rte_bus *bus __rte_unused, const struct rte_device *start,
+		     rte_dev_cmp_t cmp, const void *data)
 {
 	struct rte_device *dev;
 
diff --git a/drivers/bus/vdev/vdev_params.c b/drivers/bus/vdev/vdev_params.c
index 68ae09e2e9..fedd82b25d 100644
--- a/drivers/bus/vdev/vdev_params.c
+++ b/drivers/bus/vdev/vdev_params.c
@@ -58,7 +58,7 @@ rte_vdev_dev_iterate(const void *start,
 			return NULL;
 		}
 	}
-	dev = rte_vdev_find_device(start, vdev_dev_match, kvargs);
+	dev = rte_vdev_find_device(NULL, start, vdev_dev_match, kvargs);
 	rte_kvargs_free(kvargs);
 	return dev;
 }
diff --git a/drivers/bus/vdev/vdev_private.h b/drivers/bus/vdev/vdev_private.h
index e683f5f133..ac036693d8 100644
--- a/drivers/bus/vdev/vdev_private.h
+++ b/drivers/bus/vdev/vdev_private.h
@@ -12,7 +12,8 @@ extern "C" {
 #endif
 
 struct rte_device *
-rte_vdev_find_device(const struct rte_device *start,
+rte_vdev_find_device(const struct rte_bus *bus,
+		     const struct rte_device *start,
 		     rte_dev_cmp_t cmp,
 		     const void *data);
 
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 889b9347d7..3260bd5395 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -275,31 +275,12 @@ rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 }
 
 /* VMBUS doesn't support hotplug */
-static struct rte_device *
-vmbus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-		  const void *data)
-{
-	struct rte_device *dev;
-
-	TAILQ_FOREACH(dev, &rte_vmbus_bus.bus.device_list, next) {
-		if (start && dev == start) {
-			start = NULL;
-			continue;
-		}
-		if (cmp(dev, data) == 0)
-			return dev;
-	}
-
-	return NULL;
-}
-
-
 struct rte_vmbus_bus rte_vmbus_bus = {
 	.bus = {
 		.scan = rte_vmbus_scan,
 		.probe = rte_vmbus_probe,
 		.cleanup = rte_vmbus_cleanup,
-		.find_device = vmbus_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.parse = vmbus_parse,
 		.dev_compare = vmbus_dev_compare,
 	},
diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index b3e691a2bd..1c203e1288 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -44,8 +44,6 @@ struct rte_dsa_device {
 struct dsa_bus;
 static int dsa_scan(void);
 static int dsa_probe(void);
-static struct rte_device *dsa_find_device(const struct rte_device *start,
-		rte_dev_cmp_t cmp,  const void *data);
 static enum rte_iova_mode dsa_get_iommu_class(void);
 static int dsa_addr_parse(const char *name, void *addr);
 
@@ -61,7 +59,7 @@ struct dsa_bus dsa_bus = {
 	.bus = {
 		.scan = dsa_scan,
 		.probe = dsa_probe,
-		.find_device = dsa_find_device,
+		.find_device = rte_bus_generic_find_device,
 		.get_iommu_class = dsa_get_iommu_class,
 		.parse = dsa_addr_parse,
 	},
@@ -340,22 +338,6 @@ dsa_scan(void)
 	return 0;
 }
 
-static struct rte_device *
-dsa_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
-			 const void *data)
-{
-	struct rte_device *dev = TAILQ_FIRST(&dsa_bus.bus.device_list);
-
-	if (start != NULL) /* jump to start point if given */
-		dev = TAILQ_NEXT(start, next);
-	while (dev != NULL) {
-		if (cmp(dev, data) == 0)
-			return dev;
-		dev = TAILQ_NEXT(dev, next);
-	}
-	return NULL;
-}
-
 static enum rte_iova_mode
 dsa_get_iommu_class(void)
 {
diff --git a/drivers/net/bonding/rte_eth_bond_args.c b/drivers/net/bonding/rte_eth_bond_args.c
index 4fbd25cd33..823ed80f07 100644
--- a/drivers/net/bonding/rte_eth_bond_args.c
+++ b/drivers/net/bonding/rte_eth_bond_args.c
@@ -45,7 +45,7 @@ find_port_id_by_pci_addr(const struct rte_pci_addr *pci_addr)
 		return -1;
 	}
 
-	dev = pci_bus->find_device(NULL, bond_pci_addr_cmp, pci_addr);
+	dev = pci_bus->find_device(pci_bus, NULL, bond_pci_addr_cmp, pci_addr);
 	if (dev == NULL) {
 		RTE_BOND_LOG(ERR, "unable to find PCI device");
 		return -1;
diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..d70da6c7c1 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -794,7 +794,7 @@ vdev_netvsc_scan_callback(__rte_unused void *arg)
 			     VDEV_NETVSC_DRIVER_NAME_LEN))
 			return;
 
-	dev = vbus->find_device(NULL, vdev_netvsc_cmp_rte_device,
+	dev = vbus->find_device(vbus, NULL, vdev_netvsc_cmp_rte_device,
 				VDEV_NETVSC_DRIVER_NAME);
 	if (dev)
 		return;
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 5b9b596435..d1d54e9065 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1874,7 +1874,7 @@ ifpga_cfg_remove(struct rte_vdev_device *vdev)
 		args.port, args.bdf);
 	bus = rte_bus_find_by_name(RTE_STR(IFPGA_BUS_NAME));
 	if (bus) {
-		if (bus->find_device(NULL, cmp_dev_name, dev_name)) {
+		if (bus->find_device(bus, NULL, cmp_dev_name, dev_name)) {
 			ret = rte_eal_hotplug_remove(RTE_STR(IFPGA_BUS_NAME),
 				dev_name);
 		}
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 2748e99826..f81d13e7d0 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -182,7 +182,7 @@ bus_find_device(const struct rte_bus *bus, const void *_dev)
 {
 	struct rte_device *dev;
 
-	dev = bus->find_device(NULL, cmp_rte_device, _dev);
+	dev = bus->find_device(bus, NULL, cmp_rte_device, _dev);
 	return dev == NULL;
 }
 
@@ -398,6 +398,25 @@ rte_bus_insert_device(struct rte_bus *bus,
 	new_dev->bus = bus;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_generic_find_device)
+struct rte_device *
+rte_bus_generic_find_device(const struct rte_bus *bus, const struct rte_device *start,
+		    rte_dev_cmp_t cmp, const void *data)
+{
+	struct rte_device *dev;
+
+	if (start != NULL)
+		dev = TAILQ_NEXT(start, next);
+	else
+		dev = TAILQ_FIRST(&bus->device_list);
+	while (dev != NULL) {
+		if (cmp(dev, data) == 0)
+			return dev;
+		dev = TAILQ_NEXT(dev, next);
+	}
+	return NULL;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_add_driver)
 void
 rte_bus_add_driver(struct rte_bus *bus, struct rte_driver *driver)
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index fceca75223..e08a0f9dbc 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -207,7 +207,7 @@ local_dev_probe(const char *devargs, struct rte_device **new_dev)
 	if (ret)
 		goto err_devarg;
 
-	dev = da->bus->find_device(NULL, cmp_dev_name, da->name);
+	dev = da->bus->find_device(da->bus, NULL, cmp_dev_name, da->name);
 	if (dev == NULL) {
 		EAL_LOG(ERR, "Cannot find device (%s)",
 			da->name);
@@ -347,7 +347,7 @@ rte_eal_hotplug_remove(const char *busname, const char *devname)
 		return -ENOENT;
 	}
 
-	dev = bus->find_device(NULL, cmp_dev_name, devname);
+	dev = bus->find_device(bus, NULL, cmp_dev_name, devname);
 	if (dev == NULL) {
 		EAL_LOG(ERR, "Cannot find plugged device (%s)", devname);
 		return -EINVAL;
diff --git a/lib/eal/common/hotplug_mp.c b/lib/eal/common/hotplug_mp.c
index 17089ca3db..57a5c0bdfe 100644
--- a/lib/eal/common/hotplug_mp.c
+++ b/lib/eal/common/hotplug_mp.c
@@ -135,7 +135,7 @@ __handle_secondary_request(void *param)
 			goto finish;
 		}
 
-		dev = bus->find_device(NULL, cmp_dev_name, da.name);
+		dev = bus->find_device(bus, NULL, cmp_dev_name, da.name);
 		if (dev == NULL) {
 			EAL_LOG(ERR, "Cannot find plugged device (%s)", da.name);
 			ret = -ENOENT;
@@ -262,7 +262,7 @@ static void __handle_primary_request(void *param)
 			goto quit;
 		}
 
-		dev = bus->find_device(NULL, cmp_dev_name, da->name);
+		dev = bus->find_device(bus, NULL, cmp_dev_name, da->name);
 		if (dev == NULL) {
 			EAL_LOG(ERR, "Cannot find plugged device (%s)", da->name);
 			ret = -ENOENT;
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 5b40fcd606..31c9586a33 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -69,8 +69,8 @@ typedef int (*rte_bus_probe_t)(void);
  *	The first device matching the data, NULL if none exists.
  */
 typedef struct rte_device *
-(*rte_bus_find_device_t)(const struct rte_device *start, rte_dev_cmp_t cmp,
-			 const void *data);
+(*rte_bus_find_device_t)(const struct rte_bus *bus, const struct rte_device *start,
+			 rte_dev_cmp_t cmp, const void *data);
 
 /**
  * Implementation specific probe function which is responsible for linking
@@ -430,6 +430,26 @@ void rte_bus_insert_device(struct rte_bus *bus,
 			   struct rte_device *exist_dev,
 			   struct rte_device *new_dev);
 
+/**
+ * Find a device on a bus.
+ *
+ * @param bus
+ *   A pointer to a rte_bus structure.
+ * @param start
+ *   Starting point for the search. If NULL, search from the beginning.
+ * @param cmp
+ *   Comparison function to match devices.
+ * @param data
+ *   Data to pass to the comparison function.
+ * @return
+ *   The first matching device, or NULL if not found.
+ */
+__rte_internal
+struct rte_device *rte_bus_generic_find_device(const struct rte_bus *bus,
+					       const struct rte_device *start,
+					       rte_dev_cmp_t cmp,
+					       const void *data);
+
 /**
  * Helper macro to iterate over all drivers on a bus.
  *
diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index 33b78464d5..ec408649d0 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -278,8 +278,7 @@ dev_uev_handler(__rte_unused void *param)
 				goto failure_handle_err;
 			}
 
-			dev = bus->find_device(NULL, cmp_dev_name,
-					       uevent.devname);
+			dev = bus->find_device(bus, NULL, cmp_dev_name, uevent.devname);
 			if (dev == NULL) {
 				EAL_LOG(ERR, "Cannot find device (%s) on "
 					"bus (%s)", uevent.devname, busname);
-- 
2.53.0

