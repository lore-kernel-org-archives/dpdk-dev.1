Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C00FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 947974065B;
	Wed, 29 Apr 2026 13:46:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B498740657
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2xY+bzbXKcvSM+BDi/hGkd4RKZhFXsa+Lz1IPqslK8=;
 b=XzRPv2R0pp6tQcbuPSdBeEK9aab3Tb3KW1UJyGaQ9HCQXx0P3/xVDciXX8nC0c1R66S4ct
 Ww39rN7XZDGl+uO7GBSTdO2u7l0LvDk8VipgpFzTZre9SX1rz9iLiytrguGLXCAAuuzYfi
 xek78Y8+JoPWJSnMdSFpn279/hv9BkY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-i0z5ycHJPZSJ7wI-a4tNQA-1; Wed,
 29 Apr 2026 07:46:34 -0400
X-MC-Unique: i0z5ycHJPZSJ7wI-a4tNQA-1
X-Mimecast-MFC-AGG-ID: i0z5ycHJPZSJ7wI-a4tNQA_1777463192
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62863195608F; Wed, 29 Apr 2026 11:46:32 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AF46180045E; Wed, 29 Apr 2026 11:46:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 10/23] bus: consolidate device iteration
Date: Wed, 29 Apr 2026 13:44:43 +0200
Message-ID: <20260429114503.932575-11-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u_K1EcYe0r24RalAMosfABuEkVuRGkBYgsNfKK4fuLQ_1777463192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Many buses (auxiliary, cdx, dpaa, fslmc, platform, uacce, vdev...) had
nearly identical dev_iterate implementations using name-based matching:
- Parse kvargs with "name" parameter
- Match device name via strcmp
- Call rte_bus_find_device()

Extend bus device iterator callback and introduce
rte_bus_generic_dev_iterate() generic helper in EAL.

Only the PCI bus is left with its matching on PCI address criteria.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c |  2 +-
 drivers/bus/auxiliary/auxiliary_params.c | 63 -----------------------
 drivers/bus/auxiliary/meson.build        |  5 +-
 drivers/bus/auxiliary/private.h          |  6 ---
 drivers/bus/cdx/cdx.c                    | 52 +------------------
 drivers/bus/dpaa/dpaa_bus.c              | 46 +----------------
 drivers/bus/fslmc/fslmc_bus.c            | 46 +----------------
 drivers/bus/pci/pci_params.c             |  3 +-
 drivers/bus/pci/private.h                |  6 ++-
 drivers/bus/platform/meson.build         |  5 +-
 drivers/bus/platform/platform.c          |  2 +-
 drivers/bus/platform/platform_params.c   | 65 ------------------------
 drivers/bus/platform/private.h           |  7 ---
 drivers/bus/uacce/uacce.c                | 48 +----------------
 drivers/bus/vdev/meson.build             |  5 +-
 drivers/bus/vdev/vdev.c                  | 20 +++++---
 drivers/bus/vdev/vdev_logs.h             | 16 ------
 drivers/bus/vdev/vdev_params.c           | 64 -----------------------
 drivers/bus/vdev/vdev_private.h          | 29 -----------
 lib/eal/common/eal_common_bus.c          | 41 +++++++++++++++
 lib/eal/common/eal_common_dev.c          |  4 +-
 lib/eal/include/bus_driver.h             | 51 ++++++++++++++++++-
 lib/ethdev/rte_ethdev.c                  |  2 +-
 23 files changed, 123 insertions(+), 465 deletions(-)
 delete mode 100644 drivers/bus/auxiliary/auxiliary_params.c
 delete mode 100644 drivers/bus/platform/platform_params.c
 delete mode 100644 drivers/bus/vdev/vdev_logs.h
 delete mode 100644 drivers/bus/vdev/vdev_params.c
 delete mode 100644 drivers/bus/vdev/vdev_private.h

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index eb0a27cc11..05299db8fe 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -346,7 +346,7 @@ struct rte_auxiliary_bus auxiliary_bus = {
 		.dma_map = auxiliary_dma_map,
 		.dma_unmap = auxiliary_dma_unmap,
 		.get_iommu_class = auxiliary_get_iommu_class,
-		.dev_iterate = auxiliary_dev_iterate,
+		.dev_iterate = rte_bus_generic_dev_iterate,
 	},
 };
 
diff --git a/drivers/bus/auxiliary/auxiliary_params.c b/drivers/bus/auxiliary/auxiliary_params.c
deleted file mode 100644
index 1a76155c67..0000000000
--- a/drivers/bus/auxiliary/auxiliary_params.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright (c) 2021 NVIDIA Corporation & Affiliates
- */
-
-#include <string.h>
-
-#include <bus_driver.h>
-#include <dev_driver.h>
-#include <rte_errno.h>
-#include <rte_kvargs.h>
-
-#include "private.h"
-
-enum auxiliary_params {
-	RTE_AUXILIARY_PARAM_NAME,
-};
-
-static const char * const auxiliary_params_keys[] = {
-	[RTE_AUXILIARY_PARAM_NAME] = "name",
-	NULL,
-};
-
-static int
-auxiliary_dev_match(const struct rte_device *dev,
-	      const void *_kvlist)
-{
-	const struct rte_kvargs *kvlist = _kvlist;
-	const char *key = auxiliary_params_keys[RTE_AUXILIARY_PARAM_NAME];
-	const char *name;
-
-	/* no kvlist arg, all devices match */
-	if (kvlist == NULL)
-		return 0;
-
-	/* if key is present in kvlist and does not match, filter device */
-	name = rte_kvargs_get(kvlist, key);
-	if (name != NULL && strcmp(name, dev->name))
-		return -1;
-
-	return 0;
-}
-
-void *
-auxiliary_dev_iterate(const void *start,
-		    const char *str,
-		    const struct rte_dev_iterator *it __rte_unused)
-{
-	struct rte_kvargs *kvargs = NULL;
-	struct rte_device *dev;
-
-	if (str != NULL) {
-		kvargs = rte_kvargs_parse(str, auxiliary_params_keys);
-		if (kvargs == NULL) {
-			AUXILIARY_LOG(ERR, "cannot parse argument list %s",
-				      str);
-			rte_errno = EINVAL;
-			return NULL;
-		}
-	}
-	dev = rte_bus_generic_find_device(&auxiliary_bus.bus, start, auxiliary_dev_match, kvargs);
-	rte_kvargs_free(kvargs);
-	return dev;
-}
diff --git a/drivers/bus/auxiliary/meson.build b/drivers/bus/auxiliary/meson.build
index 38d2f05d4b..846b714e2a 100644
--- a/drivers/bus/auxiliary/meson.build
+++ b/drivers/bus/auxiliary/meson.build
@@ -2,10 +2,7 @@
 # Copyright (c) 2021 NVIDIA Corporation & Affiliates
 
 driver_sdk_headers += files('bus_auxiliary_driver.h')
-sources = files(
-        'auxiliary_common.c',
-        'auxiliary_params.c',
-)
+sources = files('auxiliary_common.c')
 if is_linux
     cflags += '-DAUXILIARY_OS_SUPPORTED'
     sources += files(
diff --git a/drivers/bus/auxiliary/private.h b/drivers/bus/auxiliary/private.h
index 0b3d73a08d..659d798cd6 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -50,10 +50,4 @@ void auxiliary_on_scan(struct rte_auxiliary_device *aux_dev);
 bool auxiliary_match(const struct rte_auxiliary_driver *aux_drv,
 		     const struct rte_auxiliary_device *aux_dev);
 
-/*
- * Iterate over devices, matching any device against the provided string.
- */
-void *auxiliary_dev_iterate(const void *start, const char *str,
-			    const struct rte_dev_iterator *it);
-
 #endif /* BUS_AUXILIARY_PRIVATE_H */
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 45c6e8335d..d6f83e2e80 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -86,15 +86,6 @@
 
 struct rte_cdx_bus rte_cdx_bus;
 
-enum cdx_params {
-	RTE_CDX_PARAM_NAME,
-};
-
-static const char * const cdx_params_keys[] = {
-	[RTE_CDX_PARAM_NAME] = "name",
-	NULL,
-};
-
 static int
 cdx_get_kernel_driver_by_path(const char *filename, char *driver_name,
 		size_t len)
@@ -528,47 +519,6 @@ cdx_get_iommu_class(void)
 	return RTE_IOVA_VA;
 }
 
-static int
-cdx_dev_match(const struct rte_device *dev,
-		const void *_kvlist)
-{
-	const struct rte_kvargs *kvlist = _kvlist;
-	const char *key = cdx_params_keys[RTE_CDX_PARAM_NAME];
-	const char *name;
-
-	/* no kvlist arg, all devices match */
-	if (kvlist == NULL)
-		return 0;
-
-	/* if key is present in kvlist and does not match, filter device */
-	name = rte_kvargs_get(kvlist, key);
-	if (name != NULL && strcmp(name, dev->name))
-		return -1;
-
-	return 0;
-}
-
-static void *
-cdx_dev_iterate(const void *start,
-		const char *str,
-		const struct rte_dev_iterator *it __rte_unused)
-{
-	struct rte_kvargs *kvargs = NULL;
-	struct rte_device *dev;
-
-	if (str != NULL) {
-		kvargs = rte_kvargs_parse(str, cdx_params_keys);
-		if (kvargs == NULL) {
-			CDX_BUS_ERR("cannot parse argument list %s", str);
-			rte_errno = EINVAL;
-			return NULL;
-		}
-	}
-	dev = rte_bus_generic_find_device(&rte_cdx_bus.bus, start, cdx_dev_match, kvargs);
-	rte_kvargs_free(kvargs);
-	return dev;
-}
-
 struct rte_cdx_bus rte_cdx_bus = {
 	.bus = {
 		.scan = cdx_scan,
@@ -580,7 +530,7 @@ struct rte_cdx_bus rte_cdx_bus = {
 		.dma_map = cdx_dma_map,
 		.dma_unmap = cdx_dma_unmap,
 		.get_iommu_class = cdx_get_iommu_class,
-		.dev_iterate = cdx_dev_iterate,
+		.dev_iterate = rte_bus_generic_dev_iterate,
 	},
 };
 
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 0bacc0e9d5..b3a754cbf4 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -845,50 +845,6 @@ dpaa_bus_unplug(struct rte_device *dev __rte_unused)
 	return 0;
 }
 
-static void *
-dpaa_bus_dev_iterate(const void *start, const char *str,
-		     const struct rte_dev_iterator *it __rte_unused)
-{
-	char *dup, *dev_name = NULL;
-	struct rte_device *dev;
-
-	if (str == NULL) {
-		DPAA_BUS_DEBUG("No device string");
-		return NULL;
-	}
-
-	/* Expectation is that device would be name=device_name */
-	if (strncmp(str, "name=", 5) != 0) {
-		DPAA_BUS_DEBUG("Invalid device string (%s)", str);
-		return NULL;
-	}
-
-	/* Now that name=device_name format is available, split */
-	dup = strdup(str);
-	if (dup == NULL) {
-		DPAA_BUS_DEBUG("Dup string (%s) failed!", str);
-		return NULL;
-	}
-	dev_name = dup + strlen("name=");
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT((const struct rte_device *)start, next);
-	} else {
-		dev = TAILQ_FIRST(&rte_dpaa_bus.bus.device_list);
-	}
-
-	while (dev != NULL) {
-		if (strcmp(dev->name, dev_name) == 0) {
-			free(dup);
-			return dev;
-		}
-		dev = TAILQ_NEXT(dev, next);
-	}
-
-	free(dup);
-	return NULL;
-}
-
 static int
 dpaa_bus_cleanup(void)
 {
@@ -948,7 +904,7 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.get_iommu_class = rte_dpaa_get_iommu_class,
 		.plug = dpaa_bus_plug,
 		.unplug = dpaa_bus_unplug,
-		.dev_iterate = dpaa_bus_dev_iterate,
+		.dev_iterate = rte_bus_generic_dev_iterate,
 		.cleanup = dpaa_bus_cleanup,
 	},
 	.max_push_rxq_num = DPAA_DEFAULT_PUSH_MODE_QUEUE,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 312145b712..716f0178b5 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -593,50 +593,6 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
 	return -ENODEV;
 }
 
-static void *
-fslmc_bus_dev_iterate(const void *start, const char *str,
-		      const struct rte_dev_iterator *it __rte_unused)
-{
-	char *dup, *dev_name = NULL;
-	struct rte_device *dev;
-
-	if (str == NULL) {
-		DPAA2_BUS_DEBUG("No device string");
-		return NULL;
-	}
-
-	/* Expectation is that device would be name=device_name */
-	if (strncmp(str, "name=", 5) != 0) {
-		DPAA2_BUS_DEBUG("Invalid device string (%s)", str);
-		return NULL;
-	}
-
-	/* Now that name=device_name format is available, split */
-	dup = strdup(str);
-	if (dup == NULL) {
-		DPAA2_BUS_DEBUG("Dup string (%s) failed!", str);
-		return NULL;
-	}
-	dev_name = dup + strlen("name=");
-
-	if (start != NULL) {
-		dev = TAILQ_NEXT(RTE_CAST_PTR(struct rte_device *, start), next);
-	} else {
-		dev = TAILQ_FIRST(&rte_fslmc_bus.bus.device_list);
-	}
-
-	while (dev != NULL) {
-		if (strcmp(dev->name, dev_name) == 0) {
-			free(dup);
-			return dev;
-		}
-		dev = TAILQ_NEXT(dev, next);
-	}
-
-	free(dup);
-	return NULL;
-}
-
 struct rte_fslmc_bus rte_fslmc_bus = {
 	.bus = {
 		.scan = rte_fslmc_scan,
@@ -648,7 +604,7 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 		.get_iommu_class = rte_dpaa2_get_iommu_class,
 		.plug = fslmc_bus_plug,
 		.unplug = fslmc_bus_unplug,
-		.dev_iterate = fslmc_bus_dev_iterate,
+		.dev_iterate = rte_bus_generic_dev_iterate,
 	},
 	.device_count = {0},
 };
diff --git a/drivers/bus/pci/pci_params.c b/drivers/bus/pci/pci_params.c
index d596c3bba8..e308c85ed2 100644
--- a/drivers/bus/pci/pci_params.c
+++ b/drivers/bus/pci/pci_params.c
@@ -59,7 +59,8 @@ pci_dev_match(const struct rte_device *dev,
 }
 
 void *
-rte_pci_dev_iterate(const void *start,
+rte_pci_dev_iterate(const struct rte_bus *bus __rte_unused,
+		    const void *start,
 		    const char *str,
 		    const struct rte_dev_iterator *it __rte_unused)
 {
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index 52fa6b0f76..21637882f8 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -258,6 +258,9 @@ rte_pci_get_iommu_class(void);
  * matching any device against the provided
  * string.
  *
+ * @param bus
+ *   A pointer to the bus structure.
+ *
  * @param start
  *   Iteration starting point.
  *
@@ -272,7 +275,8 @@ rte_pci_get_iommu_class(void);
  *   NULL otherwise.
  */
 void *
-rte_pci_dev_iterate(const void *start,
+rte_pci_dev_iterate(const struct rte_bus *bus,
+		    const void *start,
 		    const char *str,
 		    const struct rte_dev_iterator *it);
 
diff --git a/drivers/bus/platform/meson.build b/drivers/bus/platform/meson.build
index 8633cc4e75..9b1f55c3bb 100644
--- a/drivers/bus/platform/meson.build
+++ b/drivers/bus/platform/meson.build
@@ -11,8 +11,5 @@ endif
 require_iova_in_mbuf = false
 
 deps += ['kvargs']
-sources = files(
-        'platform_params.c',
-        'platform.c',
-)
+sources = files('platform.c')
 driver_sdk_headers += files('bus_platform_driver.h')
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index c795bd4b9c..636f051049 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -562,7 +562,7 @@ struct rte_platform_bus platform_bus = {
 		.dma_map = platform_bus_dma_map,
 		.dma_unmap = platform_bus_dma_unmap,
 		.get_iommu_class = platform_bus_get_iommu_class,
-		.dev_iterate = platform_bus_dev_iterate,
+		.dev_iterate = rte_bus_generic_dev_iterate,
 		.cleanup = platform_bus_cleanup,
 	},
 };
diff --git a/drivers/bus/platform/platform_params.c b/drivers/bus/platform/platform_params.c
deleted file mode 100644
index f8538a1d84..0000000000
--- a/drivers/bus/platform/platform_params.c
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(C) 2023 Marvell.
- */
-
-#include <string.h>
-#include <errno.h>
-
-#include <rte_bus.h>
-#include <rte_common.h>
-#include <rte_dev.h>
-#include <rte_errno.h>
-#include <rte_kvargs.h>
-
-#include "bus_platform_driver.h"
-#include "private.h"
-
-enum platform_params {
-	RTE_PLATFORM_PARAM_NAME,
-};
-
-static const char * const platform_params_keys[] = {
-	[RTE_PLATFORM_PARAM_NAME] = "name",
-	NULL
-};
-
-static int
-platform_dev_match(const struct rte_device *dev, const void *_kvlist)
-{
-	const char *key = platform_params_keys[RTE_PLATFORM_PARAM_NAME];
-	const struct rte_kvargs *kvlist = _kvlist;
-	const char *name;
-
-	/* no kvlist arg, all devices match */
-	if (kvlist == NULL)
-		return 0;
-
-	/* if key is present in kvlist and does not match, filter device */
-	name = rte_kvargs_get(kvlist, key);
-	if (name != NULL && strcmp(name, dev->name))
-		return -1;
-
-	return 0;
-}
-
-void *
-platform_bus_dev_iterate(const void *start, const char *str,
-			 const struct rte_dev_iterator *it __rte_unused)
-{
-	struct rte_kvargs *kvargs = NULL;
-	struct rte_device *dev;
-
-	if (str != NULL) {
-		kvargs = rte_kvargs_parse(str, platform_params_keys);
-		if (!kvargs) {
-			PLATFORM_LOG_LINE(ERR, "cannot parse argument list %s", str);
-			rte_errno = EINVAL;
-			return NULL;
-		}
-	}
-
-	dev = rte_bus_generic_find_device(&platform_bus.bus, start, platform_dev_match, kvargs);
-	rte_kvargs_free(kvargs);
-
-	return dev;
-}
diff --git a/drivers/bus/platform/private.h b/drivers/bus/platform/private.h
index 81a8984052..bf5d75df03 100644
--- a/drivers/bus/platform/private.h
+++ b/drivers/bus/platform/private.h
@@ -28,11 +28,4 @@ extern int platform_bus_logtype;
 #define PLATFORM_LOG_LINE(level, ...) \
 	RTE_LOG_LINE(level, PLATFORM_BUS, __VA_ARGS__)
 
-/*
- * Iterate registered platform devices and find one that matches provided string.
- */
-void *
-platform_bus_dev_iterate(const void *start, const char *str,
-			 const struct rte_dev_iterator *it __rte_unused);
-
 #endif /* PLATFORM_PRIVATE_H */
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index ef133a6ae7..153ebc5eea 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -44,14 +44,6 @@ struct rte_uacce_bus {
 /* Forward declaration of UACCE bus. */
 static struct rte_uacce_bus uacce_bus;
 
-enum uacce_params {
-	RTE_UACCE_PARAM_NAME,
-};
-
-static const char *const uacce_params_keys[] = {
-	[RTE_UACCE_PARAM_NAME] = "name",
-	NULL,
-};
 
 extern int uacce_bus_logtype;
 #define RTE_LOGTYPE_UACCE_BUS uacce_bus_logtype
@@ -522,44 +514,6 @@ uacce_parse(const char *name, void *addr)
 	return ret;
 }
 
-static int
-uacce_dev_match(const struct rte_device *dev, const void *_kvlist)
-{
-	const char *key = uacce_params_keys[RTE_UACCE_PARAM_NAME];
-	const struct rte_kvargs *kvlist = _kvlist;
-	const char *name;
-
-	/* no kvlist arg, all devices match. */
-	if (kvlist == NULL)
-		return 0;
-
-	/* if key is present in kvlist and does not match, filter device. */
-	name = rte_kvargs_get(kvlist, key);
-	if (name != NULL && strcmp(name, dev->name))
-		return -1;
-
-	return 0;
-}
-
-static void *
-uacce_dev_iterate(const void *start, const char *str,
-		  const struct rte_dev_iterator *it __rte_unused)
-{
-	struct rte_kvargs *kvargs = NULL;
-	struct rte_device *dev;
-
-	if (str != NULL) {
-		kvargs = rte_kvargs_parse(str, uacce_params_keys);
-		if (kvargs == NULL) {
-			UACCE_BUS_ERR("cannot parse argument list %s", str);
-			return NULL;
-		}
-	}
-	dev = rte_bus_generic_find_device(&uacce_bus.bus, start, uacce_dev_match, kvargs);
-	rte_kvargs_free(kvargs);
-	return dev;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_avail_queues)
 int
 rte_uacce_avail_queues(struct rte_uacce_device *dev)
@@ -676,7 +630,7 @@ static struct rte_uacce_bus uacce_bus = {
 		.unplug = uacce_unplug,
 		.find_device = rte_bus_generic_find_device,
 		.parse = uacce_parse,
-		.dev_iterate = uacce_dev_iterate,
+		.dev_iterate = rte_bus_generic_dev_iterate,
 	},
 };
 
diff --git a/drivers/bus/vdev/meson.build b/drivers/bus/vdev/meson.build
index 50f0c8918d..6487b0d672 100644
--- a/drivers/bus/vdev/meson.build
+++ b/drivers/bus/vdev/meson.build
@@ -1,10 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = files(
-        'vdev.c',
-        'vdev_params.c',
-)
+sources = files('vdev.c')
 headers = files('rte_bus_vdev.h')
 driver_sdk_headers = files('bus_vdev_driver.h')
 
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 9b88df8bdc..3e610bd780 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -10,12 +10,14 @@
 #include <stdbool.h>
 #include <sys/queue.h>
 
+#include <rte_os_shim.h>
 #include <eal_export.h>
 #include <rte_eal.h>
 #include <dev_driver.h>
 #include <bus_driver.h>
 #include <rte_common.h>
 #include <rte_devargs.h>
+#include <rte_log.h>
 #include <rte_memory.h>
 #include <rte_tailq.h>
 #include <rte_spinlock.h>
@@ -23,11 +25,15 @@
 #include <rte_errno.h>
 
 #include "bus_vdev_driver.h"
-#include "vdev_logs.h"
-#include "vdev_private.h"
 
 #define VDEV_MP_KEY	"bus_vdev_mp"
 
+int vdev_logtype_bus;
+#define RTE_LOGTYPE_VDEV_BUS vdev_logtype_bus
+
+#define VDEV_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, VDEV_BUS, "%s(): ", __func__, __VA_ARGS__)
+
 /* Forward declare to access virtual bus name */
 static struct rte_bus rte_vdev_bus;
 
@@ -576,9 +582,9 @@ vdev_cleanup(void)
 	return error;
 }
 
-struct rte_device *
-rte_vdev_find_device(const struct rte_bus *bus __rte_unused, const struct rte_device *start,
-		     rte_dev_cmp_t cmp, const void *data)
+static struct rte_device *
+vdev_find_device(const struct rte_bus *bus __rte_unused, const struct rte_device *start,
+	rte_dev_cmp_t cmp, const void *data)
 {
 	struct rte_device *dev;
 
@@ -633,14 +639,14 @@ static struct rte_bus rte_vdev_bus = {
 	.scan = vdev_scan,
 	.probe = vdev_probe,
 	.cleanup = vdev_cleanup,
-	.find_device = rte_vdev_find_device,
+	.find_device = vdev_find_device,
 	.plug = vdev_plug,
 	.unplug = vdev_unplug,
 	.parse = vdev_parse,
 	.dma_map = vdev_dma_map,
 	.dma_unmap = vdev_dma_unmap,
 	.get_iommu_class = vdev_get_iommu_class,
-	.dev_iterate = rte_vdev_dev_iterate,
+	.dev_iterate = rte_bus_generic_dev_iterate,
 };
 
 RTE_REGISTER_BUS(vdev, rte_vdev_bus);
diff --git a/drivers/bus/vdev/vdev_logs.h b/drivers/bus/vdev/vdev_logs.h
deleted file mode 100644
index 38859ae4b7..0000000000
--- a/drivers/bus/vdev/vdev_logs.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2017 Intel Corporation
- */
-
-#ifndef _VDEV_LOGS_H_
-#define _VDEV_LOGS_H_
-
-#include <rte_log.h>
-
-extern int vdev_logtype_bus;
-#define RTE_LOGTYPE_VDEV_BUS vdev_logtype_bus
-
-#define VDEV_LOG(level, ...) \
-	RTE_LOG_LINE_PREFIX(level, VDEV_BUS, "%s(): ", __func__, __VA_ARGS__)
-
-#endif /* _VDEV_LOGS_H_ */
diff --git a/drivers/bus/vdev/vdev_params.c b/drivers/bus/vdev/vdev_params.c
deleted file mode 100644
index fedd82b25d..0000000000
--- a/drivers/bus/vdev/vdev_params.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018 Gaëtan Rivet
- */
-
-#include <errno.h>
-#include <string.h>
-
-#include <dev_driver.h>
-#include <rte_kvargs.h>
-#include <rte_errno.h>
-
-#include "vdev_logs.h"
-#include "vdev_private.h"
-
-enum vdev_params {
-	RTE_VDEV_PARAM_NAME,
-	RTE_VDEV_PARAM_MAX,
-};
-
-static const char * const vdev_params_keys[] = {
-	[RTE_VDEV_PARAM_NAME] = "name",
-	[RTE_VDEV_PARAM_MAX] = NULL,
-};
-
-static int
-vdev_dev_match(const struct rte_device *dev,
-	       const void *_kvlist)
-{
-	const struct rte_kvargs *kvlist = _kvlist;
-	const char *key = vdev_params_keys[RTE_VDEV_PARAM_NAME];
-	const char *name;
-
-	/* no kvlist arg, all devices match */
-	if (kvlist == NULL)
-		return 0;
-
-	/* if key is present in kvlist and does not match, filter device */
-	name = rte_kvargs_get(kvlist, key);
-	if (name != NULL && strcmp(name, dev->name))
-		return -1;
-
-	return 0;
-}
-
-void *
-rte_vdev_dev_iterate(const void *start,
-		     const char *str,
-		     const struct rte_dev_iterator *it __rte_unused)
-{
-	struct rte_kvargs *kvargs = NULL;
-	struct rte_device *dev;
-
-	if (str != NULL) {
-		kvargs = rte_kvargs_parse(str, vdev_params_keys);
-		if (kvargs == NULL) {
-			VDEV_LOG(ERR, "cannot parse argument list");
-			rte_errno = EINVAL;
-			return NULL;
-		}
-	}
-	dev = rte_vdev_find_device(NULL, start, vdev_dev_match, kvargs);
-	rte_kvargs_free(kvargs);
-	return dev;
-}
diff --git a/drivers/bus/vdev/vdev_private.h b/drivers/bus/vdev/vdev_private.h
deleted file mode 100644
index ac036693d8..0000000000
--- a/drivers/bus/vdev/vdev_private.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018 Gaëtan Rivet
- */
-
-#ifndef _VDEV_PRIVATE_H_
-#define _VDEV_PRIVATE_H_
-
-#include <rte_os_shim.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-struct rte_device *
-rte_vdev_find_device(const struct rte_bus *bus,
-		     const struct rte_device *start,
-		     rte_dev_cmp_t cmp,
-		     const void *data);
-
-void *
-rte_vdev_dev_iterate(const void *start,
-		     const char *str,
-		     const struct rte_dev_iterator *it);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* _VDEV_PRIVATE_H_ */
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index f81d13e7d0..46a8e68532 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -9,6 +9,7 @@
 #include <bus_driver.h>
 #include <rte_debug.h>
 #include <rte_devargs.h>
+#include <rte_kvargs.h>
 #include <rte_string_fns.h>
 #include <rte_errno.h>
 
@@ -432,3 +433,43 @@ rte_bus_remove_driver(struct rte_bus *bus, struct rte_driver *driver)
 	TAILQ_REMOVE(&bus->driver_list, driver, next);
 	driver->bus = NULL;
 }
+
+static int
+bus_dev_match_by_name(const struct rte_device *dev, const void *_kvlist)
+{
+	const struct rte_kvargs *kvlist = _kvlist;
+	const char *name;
+
+	if (kvlist == NULL)
+		return 0;
+
+	name = rte_kvargs_get(kvlist, "name");
+	if (name != NULL && strcmp(name, dev->name))
+		return -1;
+
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_generic_dev_iterate)
+void *
+rte_bus_generic_dev_iterate(const struct rte_bus *bus,
+			     const void *start,
+			     const char *str,
+			     const struct rte_dev_iterator *it __rte_unused)
+{
+	static const char * const params_keys[] = { "name", NULL };
+	struct rte_kvargs *kvargs = NULL;
+	struct rte_device *dev;
+
+	if (str != NULL) {
+		kvargs = rte_kvargs_parse(str, params_keys);
+		if (kvargs == NULL) {
+			rte_errno = EINVAL;
+			return NULL;
+		}
+	}
+
+	dev = rte_bus_generic_find_device(bus, start, bus_dev_match_by_name, kvargs);
+	rte_kvargs_free(kvargs);
+	return dev;
+}
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index e08a0f9dbc..17e8901546 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -756,13 +756,13 @@ bus_next_dev_cmp(const struct rte_bus *bus,
 	if (rte_errno != 0)
 		return -1;
 	if (it->cls_str == NULL) {
-		dev = bus->dev_iterate(dev, bus_str, it);
+		dev = bus->dev_iterate(bus, dev, bus_str, it);
 		goto end;
 	}
 	/* cls_str != NULL */
 	if (dev == NULL) {
 next_dev_on_bus:
-		dev = bus->dev_iterate(dev, bus_str, it);
+		dev = bus->dev_iterate(bus, dev, bus_str, it);
 		it->device = dev;
 	}
 	if (dev == NULL)
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 31c9586a33..e3e52928f4 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -262,6 +262,32 @@ struct rte_bus_conf {
  */
 typedef enum rte_iova_mode (*rte_bus_get_iommu_class_t)(void);
 
+/**
+ * Per bus, device iteration function.
+ *
+ * Similar to rte_dev_iterate_t but also pass along the bus pointer.
+ *
+ * @param bus
+ *   A pointer to the bus structure.
+ *
+ * @param start
+ *   Starting iteration context.
+ *
+ * @param devstr
+ *   Device description string.
+ *
+ * @param it
+ *   Device iterator.
+ *
+ * @return
+ *   The address of the current element matching the device description
+ *   string.
+ */
+typedef void *(*rte_bus_dev_iterate_t)(const struct rte_bus *bus,
+				       const void *start,
+				       const char *devstr,
+				       const struct rte_dev_iterator *it);
+
 /**
  * A structure describing a generic bus.
  */
@@ -280,7 +306,7 @@ struct rte_bus {
 	rte_dev_dma_unmap_t dma_unmap; /**< DMA unmap for device in the bus */
 	struct rte_bus_conf conf;    /**< Bus configuration */
 	rte_bus_get_iommu_class_t get_iommu_class; /**< Get iommu class */
-	rte_dev_iterate_t dev_iterate; /**< Device iterator. */
+	rte_bus_dev_iterate_t dev_iterate; /**< Bus device iterator. */
 	rte_bus_hot_unplug_handler_t hot_unplug_handler;
 				/**< handle hot-unplug failure on the bus */
 	rte_bus_sigbus_handler_t sigbus_handler;
@@ -321,6 +347,29 @@ struct rte_devargs *rte_bus_find_devargs(const struct rte_bus *bus, const char *
 __rte_internal
 bool rte_bus_device_is_ignored(const struct rte_bus *bus, const char *dev_name);
 
+/**
+ * Generic device iterator for buses using name-based matching.
+ *
+ * This helper implements the standard name-based device iteration pattern
+ * using kvargs parsing. Buses that only support "name" parameter matching
+ * can use this instead of implementing their own dev_iterate function.
+ *
+ * @param bus
+ *   A pointer to the bus structure.
+ * @param start
+ *   The starting device (NULL to start from the beginning).
+ * @param str
+ *   The device filter string (e.g., "name=eth0").
+ *
+ * @return
+ *   Pointer to the matching device, or NULL if not found.
+ */
+__rte_internal
+void *rte_bus_generic_dev_iterate(const struct rte_bus *bus,
+				   const void *start,
+				   const char *str,
+				   const struct rte_dev_iterator *it);
+
 /**
  * Helper for Bus registration.
  * The constructor has higher priority than PMD constructors.
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2edc7a362e..43475bace9 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -313,7 +313,7 @@ rte_eth_iterator_next(struct rte_dev_iterator *iter)
 				iter->class_device == NULL) {
 			/* get next rte_device to try. */
 			iter->device = iter->bus->dev_iterate(
-					iter->device, iter->bus_str, iter);
+					iter->bus, iter->device, iter->bus_str, iter);
 			if (iter->device == NULL)
 				break; /* no more rte_device candidate */
 		}
-- 
2.53.0

