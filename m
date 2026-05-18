Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E59CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 10:59:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60E46402D9;
	Mon, 18 May 2026 12:59:08 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 099FD402B8
 for <dev@dpdk.org>; Mon, 18 May 2026 12:59:05 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vgKTagdHk6aEZ1aon6r7+PiWWgXfPl85AfXW8z+PzRw=;
 b=veGdRK7ai5sYWsvlPPUninyhQiCepsdmuGwRW+SEUEvZju7aSFhujzuLZVh957mtQm403ItuO
 PjT2MpNPfPzZu+SRw++3GXi2V6XQe/6cFSsHFV/9t4Sl42MChCGNWO3wcfp2YysfNY5185juu0Z
 83d4htAAotZ4lB3+Eoq9/e0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gJvkn4CT2z12LHX;
 Mon, 18 May 2026 18:52:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D752E4056E;
 Mon, 18 May 2026 18:59:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 May 2026 18:59:03 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <qianweili@huawei.com>
Subject: [PATCH v2] bus/uacce: support no-iommu mode
Date: Mon, 18 May 2026 18:58:57 +0800
Message-ID: <20260518105857.23083-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260422075326.34206-1-fengchengwen@huawei.com>
References: <20260422075326.34206-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

The uacce bus originally only supports devices with SVA capability.
This patch extends the uacce bus to support no-iommu mode for devices
without or not enabling IOMMU/SVA.

For no-iommu mode UACCE devices:
- The device api name is suffixed with _noiommu
- The device flags bit1 was set (UACCE_DEV_FLAG_NOIOMMU)

To support such devices, DPDK device drivers can mark
RTE_UACCE_DRV_SUPPORT_NOIOMMU_MODE in drv_flags to declare capability
of working with no-iommu devices.

This commit also fixes typo UACCE_DEV_FLGA_SVA -> UACCE_DEV_FLAG_SVA.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

---
v2: Fix AI review comment

---
 doc/guides/rel_notes/release_26_07.rst |  4 ++++
 drivers/bus/uacce/bus_uacce_driver.h   |  8 +++++++
 drivers/bus/uacce/uacce.c              | 31 ++++++++++++++++++++------
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..1f53e1253e 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,10 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **UACCE bus supports no-iommu mode.**
+
+  Support no-iommu mode for devices without or not enabling IOMMU/SVA.
+
 
 Removed Items
 -------------
diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index c7445778a6..d2ff8a2d53 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <linux/types.h>
 
+#include <rte_bitops.h>
 #include <rte_compat.h>
 #include <rte_devargs.h>
 #include <dev_driver.h>
@@ -28,6 +29,11 @@ extern "C" {
 #define RTE_UACCE_ALGS_NAME_SIZE	384
 #define RTE_UACCE_ATTR_MAX_SIZE		384
 
+/* UACCE device flag of SVA. */
+#define UACCE_DEV_FLAG_SVA	RTE_BIT32(0)
+/* UACCE device flag of NOIOMMU. */
+#define UACCE_DEV_FLAG_NOIOMMU	RTE_BIT32(1)
+
 /*
  * Definition for queue file region type.
  */
@@ -106,6 +112,8 @@ struct rte_uacce_driver {
 
 /** Device driver supports forward compatibility device */
 #define RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV	0x1
+/** Device driver supports NO-IOMMU mode */
+#define RTE_UACCE_DRV_SUPPORT_NOIOMMU_MODE	0x2
 
 /**
  * Get available queue number.
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index ade2452ad5..70fb5c730a 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -15,7 +15,6 @@
 #include <sys/types.h>
 
 #include <eal_export.h>
-#include <rte_bitops.h>
 #include <rte_common.h>
 #include <rte_devargs.h>
 #include <rte_eal_paging.h>
@@ -28,9 +27,6 @@
 
 #define UACCE_BUS_CLASS_PATH	"/sys/class/uacce"
 
-/* UACCE device flag of SVA. */
-#define UACCE_DEV_FLGA_SVA	RTE_BIT32(0)
-
 /* Support -a uacce:device-name when start DPDK application. */
 #define UACCE_DEV_PREFIX	"uacce:"
 
@@ -151,9 +147,25 @@ uacce_read_attr_u32(const char *dev_root, const char *attr, uint32_t *val)
 static int
 uacce_read_api(struct rte_uacce_device *dev)
 {
-	int ret = uacce_read_attr(dev->dev_root, "api", dev->api, sizeof(dev->api) - 1);
+#define NOIOMMU_SUFFIX		"_noiommu"
+	size_t api_len, sub_len;
+	int ret;
+
+	ret = uacce_read_attr(dev->dev_root, "api", dev->api, sizeof(dev->api) - 1);
 	if (ret < 0)
 		return ret;
+
+	/*
+	 * If the device is in no-iommu mode, the UACCE_DEV_FLAG_NOIOMMU flag
+	 * in its "flags" will be set, and its "api" will contain the suffix
+	 * _noiommu. To facilitate matching with the driver, the suffix is
+	 * removed here.
+	 */
+	api_len = strlen(dev->api);
+	sub_len = strlen(NOIOMMU_SUFFIX);
+	if (api_len > sub_len && strcmp(dev->api + api_len - sub_len, NOIOMMU_SUFFIX) == 0)
+		dev->api[api_len - sub_len] = 0;
+
 	return 0;
 }
 
@@ -196,8 +208,8 @@ uacce_read_qfrt_sz(struct rte_uacce_device *dev)
 static int
 uacce_verify(struct rte_uacce_device *dev)
 {
-	if (!(dev->flags & UACCE_DEV_FLGA_SVA)) {
-		UACCE_BUS_WARN("device %s don't support SVA, skip it!", dev->name);
+	if (!(dev->flags & (UACCE_DEV_FLAG_SVA | UACCE_DEV_FLAG_NOIOMMU))) {
+		UACCE_BUS_WARN("device %s don't support SVA or NOIOMMU, skip it!", dev->name);
 		return 1; /* >0 will skip this device. */
 	}
 
@@ -333,11 +345,16 @@ static bool
 uacce_match(const struct rte_uacce_driver *dr, struct rte_uacce_device *dev)
 {
 	bool forward_compat = !!(dr->drv_flags & RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV);
+	bool drv_support_noiommu = !!(dr->drv_flags & RTE_UACCE_DRV_SUPPORT_NOIOMMU_MODE);
+	bool dev_in_noiommu = !!(dev->flags & UACCE_DEV_FLAG_NOIOMMU);
 	uint32_t api_ver = uacce_calc_api_ver(dev->api, NULL);
 	const struct rte_uacce_id *id_table;
 	const char *map;
 	uint32_t len;
 
+	if (dev_in_noiommu && !drv_support_noiommu)
+		return false;
+
 	for (id_table = dr->id_table; id_table->dev_api != NULL; id_table++) {
 		if (!uacce_match_api(dev, forward_compat, id_table))
 			continue;
-- 
2.17.1

