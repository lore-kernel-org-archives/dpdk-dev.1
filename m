Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C9CEC01C9
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:53:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EF7F402D6;
	Mon, 23 Mar 2026 11:53:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 80E9E40268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 11:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774263220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKW/EkDTx1+bTW/b+BUMkzYbSruY6ZxCjOEpVP5Quk8=;
 b=RVx7OJ8Q5C+JO8nfJYLMV4R/9K8o389QzQA4/I5Vzek5wjbzUupB1gcpBJMO9biaMDEsC5
 74mEeRW/EyaaR9ssNavw+7w9NGzppvHLcXiQcU8ouExB9wvhJJcg37ddWDr2VZfRHAOA+Y
 j3R+oDzK/FfjOoajpybL00qMT81ywZ8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-zYeNfzuDPFmHwM_85Qv8nw-1; Mon,
 23 Mar 2026 06:53:36 -0400
X-MC-Unique: zYeNfzuDPFmHwM_85Qv8nw-1
X-Mimecast-MFC-AGG-ID: zYeNfzuDPFmHwM_85Qv8nw_1774263215
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B2B518002CB; Mon, 23 Mar 2026 10:53:34 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94B67180058C; Mon, 23 Mar 2026 10:53:30 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH 4/8] drivers: cleanup devargs lookup in bus scan
Date: Mon, 23 Mar 2026 11:52:58 +0100
Message-ID: <20260323105306.1531689-5-david.marchand@redhat.com>
In-Reply-To: <20260323105306.1531689-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UvFBWSF6kdh6rUbGT_jra6VJhgtLOplMhcGU0xfmz1U_1774263215
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

Don't hardcode the bus names in the RTE_EAL_DEVARGS_FOREACH() calls.
The bus name is set by code in EAL.
Even if there is nothing broken, let's reuse the name from the bus object.

And remove the now useless macros.

Note: in the ifpga bus case, the call was using an incorrect macro
(IFPGA_ARG_NAME instead of IFPGA_BUS_NAME), yet it was working fine
as this macro is aligned with the ifpga bus name.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/bus/auxiliary/auxiliary_common.c     | 2 +-
 drivers/bus/auxiliary/bus_auxiliary_driver.h | 2 --
 drivers/bus/cdx/cdx.c                        | 3 +--
 drivers/bus/dpaa/dpaa_bus.c                  | 6 ++----
 drivers/bus/fslmc/fslmc_bus.c                | 8 +++-----
 drivers/bus/ifpga/bus_ifpga_driver.h         | 2 --
 drivers/bus/ifpga/ifpga_bus.c                | 4 ++--
 drivers/bus/pci/pci_common.c                 | 2 +-
 drivers/bus/platform/platform.c              | 2 +-
 drivers/bus/uacce/uacce.c                    | 2 +-
 drivers/bus/vdev/vdev.c                      | 2 +-
 drivers/bus/vmbus/vmbus_common.c             | 2 +-
 drivers/raw/ifpga/ifpga_rawdev.c             | 2 +-
 13 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index ac766e283e..119533df28 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -30,7 +30,7 @@ auxiliary_devargs_lookup(const char *name)
 {
 	struct rte_devargs *devargs;
 
-	RTE_EAL_DEVARGS_FOREACH(RTE_BUS_AUXILIARY_NAME, devargs) {
+	RTE_EAL_DEVARGS_FOREACH(auxiliary_bus.bus.name, devargs) {
 		if (strcmp(devargs->name, name) == 0)
 			return devargs;
 	}
diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index 1dc814151e..8450d56583 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -28,8 +28,6 @@
 extern "C" {
 #endif
 
-#define RTE_BUS_AUXILIARY_NAME "auxiliary"
-
 /* Forward declarations */
 struct rte_auxiliary_driver;
 struct rte_auxiliary_device;
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 729d54337c..b183d98453 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -82,7 +82,6 @@
 #include "cdx_logs.h"
 #include "private.h"
 
-#define CDX_BUS_NAME	cdx
 #define CDX_DEV_PREFIX	"cdx-"
 
 /* CDX Bus iterators */
@@ -157,7 +156,7 @@ cdx_devargs_lookup(const char *dev_name)
 {
 	struct rte_devargs *devargs;
 
-	RTE_EAL_DEVARGS_FOREACH("cdx", devargs) {
+	RTE_EAL_DEVARGS_FOREACH(rte_cdx_bus.bus.name, devargs) {
 		if (strcmp(devargs->name, dev_name) == 0)
 			return devargs;
 	}
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 5e0f32bfe8..e3c17d41f7 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -77,8 +77,6 @@ static pthread_key_t dpaa_portal_key;
 struct dpaa_portal *dpaa_portals[RTE_MAX_LCORE] = {NULL};
 static int dpaa_bus_global_init;
 
-#define FSL_DPAA_BUS_NAME	dpaa_bus
-
 RTE_EXPORT_INTERNAL_SYMBOL(per_lcore_dpaa_io)
 RTE_DEFINE_PER_LCORE(struct dpaa_portal *, dpaa_io);
 
@@ -206,7 +204,7 @@ dpaa_devargs_lookup(struct rte_dpaa_device *dev)
 	struct rte_devargs *devargs;
 	char dev_name[32];
 
-	RTE_EAL_DEVARGS_FOREACH("dpaa_bus", devargs) {
+	RTE_EAL_DEVARGS_FOREACH(rte_dpaa_bus.bus.name, devargs) {
 		devargs->bus->parse(devargs->name, &dev_name);
 		if (strcmp(dev_name, dev->device.name) == 0) {
 			DPAA_BUS_INFO("**Devargs matched %s", dev_name);
@@ -1003,5 +1001,5 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 	.device_count = 0,
 };
 
-RTE_REGISTER_BUS(FSL_DPAA_BUS_NAME, rte_dpaa_bus.bus);
+RTE_REGISTER_BUS(dpaa_bus, rte_dpaa_bus.bus);
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_bus, NOTICE);
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index ac9fb7a08c..8f3e3dc1be 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -26,7 +26,6 @@
 #include <dpaax_iova_table.h>
 
 #define VFIO_IOMMU_GROUP_PATH "/sys/kernel/iommu_groups"
-#define FSLMC_BUS_NAME	fslmc
 
 struct rte_fslmc_bus rte_fslmc_bus;
 
@@ -106,7 +105,7 @@ fslmc_devargs_lookup(struct rte_dpaa2_device *dev)
 	struct rte_devargs *devargs;
 	char dev_name[32];
 
-	RTE_EAL_DEVARGS_FOREACH("fslmc", devargs) {
+	RTE_EAL_DEVARGS_FOREACH(rte_fslmc_bus.bus.name, devargs) {
 		devargs->bus->parse(devargs->name, &dev_name);
 		if (strcmp(dev_name, dev->device.name) == 0) {
 			DPAA2_BUS_INFO("**Devargs matched %s", dev_name);
@@ -266,8 +265,7 @@ rte_fslmc_parse(const char *name, void *addr)
 	 */
 	if (sep_exists) {
 		/* If either of "fslmc" or "name" are starting part */
-		if (!strncmp(name, RTE_STR(FSLMC_BUS_NAME),
-			     strlen(RTE_STR(FSLMC_BUS_NAME))) ||
+		if (!strncmp(name, rte_fslmc_bus.bus.name, strlen(rte_fslmc_bus.bus.name)) ||
 		   (!strncmp(name, "name", strlen("name")))) {
 			goto jump_out;
 		} else {
@@ -704,5 +702,5 @@ struct rte_fslmc_bus rte_fslmc_bus = {
 	.device_count = {0},
 };
 
-RTE_REGISTER_BUS(FSLMC_BUS_NAME, rte_fslmc_bus.bus);
+RTE_REGISTER_BUS(fslmc, rte_fslmc_bus.bus);
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_bus, NOTICE);
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index d34ab8cec1..5e77a8f170 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -21,8 +21,6 @@
 extern "C" {
 #endif /* __cplusplus */
 
-#define IFPGA_BUS_NAME ifpga
-
 /* Forward declarations */
 struct rte_afu_device;
 struct rte_afu_driver;
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index fdce1f6b1f..2692a09d15 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -220,7 +220,7 @@ ifpga_scan(void)
 	struct rte_afu_device *afu_dev = NULL;
 
 	/* for FPGA devices we scan the devargs_list populated via cmdline */
-	RTE_EAL_DEVARGS_FOREACH(IFPGA_ARG_NAME, devargs) {
+	RTE_EAL_DEVARGS_FOREACH(rte_ifpga_bus.name, devargs) {
 		if (devargs->bus != &rte_ifpga_bus)
 			continue;
 
@@ -516,5 +516,5 @@ static struct rte_bus rte_ifpga_bus = {
 	.parse       = ifpga_parse,
 };
 
-RTE_REGISTER_BUS(IFPGA_BUS_NAME, rte_ifpga_bus);
+RTE_REGISTER_BUS(ifpga, rte_ifpga_bus);
 RTE_LOG_REGISTER_DEFAULT(ifpga_bus_logtype, NOTICE);
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index bf5df3d94e..1d26fce680 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -85,7 +85,7 @@ pci_devargs_lookup(const struct rte_pci_addr *pci_addr)
 	struct rte_devargs *devargs;
 	struct rte_pci_addr addr;
 
-	RTE_EAL_DEVARGS_FOREACH("pci", devargs) {
+	RTE_EAL_DEVARGS_FOREACH(rte_pci_bus.bus.name, devargs) {
 		devargs->bus->parse(devargs->name, &addr);
 		if (!rte_pci_addr_cmp(pci_addr, &addr))
 			return devargs;
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index f6673cf181..18fa73795c 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -48,7 +48,7 @@ dev_devargs(const char *dev_name)
 {
 	struct rte_devargs *devargs;
 
-	RTE_EAL_DEVARGS_FOREACH("platform", devargs) {
+	RTE_EAL_DEVARGS_FOREACH(platform_bus.bus.name, devargs) {
 		if (!strcmp(devargs->name, dev_name))
 			return devargs;
 	}
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index a471edcad0..06a3643290 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -77,7 +77,7 @@ uacce_devargs_lookup(const char *dev_name)
 	struct rte_devargs *devargs;
 
 	snprintf(name, sizeof(name), "%s%s", UACCE_DEV_PREFIX, dev_name);
-	RTE_EAL_DEVARGS_FOREACH("uacce", devargs) {
+	RTE_EAL_DEVARGS_FOREACH(uacce_bus.bus.name, devargs) {
 		if (strcmp(devargs->name, name) == 0)
 			return devargs;
 	}
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index be375f63dc..eb1de0186e 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -526,7 +526,7 @@ vdev_scan(void)
 	rte_spinlock_unlock(&vdev_custom_scan_lock);
 
 	/* for virtual devices we scan the devargs_list populated via cmdline */
-	RTE_EAL_DEVARGS_FOREACH("vdev", devargs) {
+	RTE_EAL_DEVARGS_FOREACH(rte_vdev_bus.name, devargs) {
 
 		dev = calloc(1, sizeof(*dev));
 		if (!dev)
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index a787d8b18d..f857244c85 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -271,7 +271,7 @@ vmbus_devargs_lookup(struct rte_vmbus_device *dev)
 	struct rte_devargs *devargs;
 	rte_uuid_t addr;
 
-	RTE_EAL_DEVARGS_FOREACH("vmbus", devargs) {
+	RTE_EAL_DEVARGS_FOREACH(rte_vmbus_bus.bus.name, devargs) {
 		vmbus_parse(devargs->name, &addr);
 
 		if (rte_uuid_compare(dev->device_id, addr) == 0)
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 5b9b596435..01e9427d53 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1823,7 +1823,7 @@ ifpga_cfg_probe(struct rte_vdev_device *vdev)
 
 	snprintf(dev_name, RTE_RAWDEV_NAME_MAX_LEN, "%d|%s",
 		args.port, args.bdf);
-	ret = rte_eal_hotplug_add(RTE_STR(IFPGA_BUS_NAME),
+	ret = rte_eal_hotplug_add(vdev->device.devargs->bus->name,
 			dev_name, vdev->device.devargs->args);
 	if (ret) {
 		rte_free(ifpga_dev->vdev_name[i]);
-- 
2.53.0

