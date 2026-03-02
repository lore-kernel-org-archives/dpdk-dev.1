Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C2E9B366
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:02:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1CA440DD5;
	Mon,  2 Mar 2026 12:02:17 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 1C3FF4025F
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:02:14 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=fkZjeCl+BzhmmuFacOwDRfj+rAWOEeJx4k6yxHuKQak=;
 b=QFl2hB8CHUDvK2/Nx/KamTyXVOE0HjYAMBym58OWijrYBXcpKGu6NUf9xPaNwwNC6/j09UsZP
 ewUAxPKhkFLyYEJ+CdAcP624D63Lc6XVewJh5p3hfxHYniidV4tuMNwPLjdVW3b660VHvEDZ9+b
 Fa8T/hgtjCD1C/dYX2ZoeZg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fPbVk55v4znTWT;
 Mon,  2 Mar 2026 18:57:34 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 770F44056D;
 Mon,  2 Mar 2026 19:02:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Mar 2026 19:02:12 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <qianweili@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 1/2] bus/uacce: support driver forward compatibility
Date: Mon, 2 Mar 2026 19:02:05 +0800
Message-ID: <20260302110206.49670-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260302110206.49670-1-fengchengwen@huawei.com>
References: <20260302110206.49670-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

As we know, the uacce driver (e.g. hisi_acc DMA driver) reads the API of
the hardware device (through /sysfs/class/uacce/xxx/api) and compares it
with the API supported by the driver to match the corresponding hardware
device.

Hardware devices will continue to evolve, which means their APIs will
change, but business requirements demand that they support old
programming interfaces as much as possible.

To adapt to this situation, this commit supports forward compatibility
of driver APIs. For example, if the driver supports the hisi_qm_v5 API,
it can drive the hardware device that supports the hisi_qm_v6 or
hisi_qm_v7 API.

In addition, a driver flag (RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV) is
introduced. The driver supports forward compatibility of APIs only when
this flag is defined.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/bus/uacce/bus_uacce_driver.h |  5 +++
 drivers/bus/uacce/uacce.c            | 51 ++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index 618e0f9b76..c7445778a6 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -50,6 +50,7 @@ struct rte_uacce_device {
 	char dev_root[RTE_UACCE_DEV_PATH_SIZE];  /**< Sysfs path with device name. */
 	char cdev_path[RTE_UACCE_DEV_PATH_SIZE]; /**< Device path in devfs. */
 	char api[RTE_UACCE_API_NAME_SIZE];       /**< Device context type. */
+	uint32_t api_ver;                        /**< Device api version used for compatibility. */
 	char algs[RTE_UACCE_ALGS_NAME_SIZE];     /**< Device supported algorithms. */
 	uint32_t flags;                          /**< Device flags. */
 	int numa_node;                           /**< NUMA node connection, -1 if unknown. */
@@ -100,8 +101,12 @@ struct rte_uacce_driver {
 	rte_uacce_probe_t *probe;               /**< Device probe function. */
 	rte_uacce_remove_t *remove;             /**< Device remove function. */
 	const struct rte_uacce_id *id_table;    /**< ID table, NULL terminated. */
+	uint32_t drv_flags;                     /**< Flags RTE_UACCE_DRV_*. */
 };
 
+/** Device driver supports forward compatibility device */
+#define RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV	0x1
+
 /**
  * Get available queue number.
  *
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 79f990c54c..a471edcad0 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2024 HiSilicon Limited
  */
 
+#include <ctype.h>
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -324,19 +325,62 @@ uacce_scan(void)
 	return -1;
 }
 
+static uint32_t
+uacce_calc_api_ver(const char *api, int *offset)
+{
+	int len = strlen(api);
+	int end = len - 1;
+	unsigned long ver;
+
+	while (end >= 0 && isdigit(api[end]))
+		end--;
+
+	if (end <= 0 || end == len - 1 || api[end] != 'v')
+		return 0;
+
+	ver = strtoul(api + end + 1, NULL, 10);
+	if (ver > UINT32_MAX)
+		return 0;
+
+	if (offset != NULL)
+		*offset = end + 1;
+	return (uint32_t)ver;
+}
+
+static bool
+uacce_match_api(const struct rte_uacce_device *dev, bool forward_compat,
+		const struct rte_uacce_id *id_table)
+{
+	int dev_ver_off = 0, id_ver_off = 0;
+	uint32_t dev_ver, id_ver;
+
+	if (!forward_compat)
+		return strcmp(id_table->dev_api, dev->api) == 0;
+
+	dev_ver = uacce_calc_api_ver(dev->api, &dev_ver_off);
+	id_ver = uacce_calc_api_ver(id_table->dev_api, &id_ver_off);
+	return dev_ver > 0 && id_ver > 0 && dev_ver_off == id_ver_off &&
+		strncmp(id_table->dev_api, dev->api, dev_ver_off) == 0 &&
+		dev_ver >= id_ver;
+}
+
 static bool
-uacce_match(const struct rte_uacce_driver *dr, const struct rte_uacce_device *dev)
+uacce_match(const struct rte_uacce_driver *dr, struct rte_uacce_device *dev)
 {
+	bool forward_compat = !!(dr->drv_flags & RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV);
+	uint32_t api_ver = uacce_calc_api_ver(dev->api, NULL);
 	const struct rte_uacce_id *id_table;
 	const char *map;
 	uint32_t len;
 
 	for (id_table = dr->id_table; id_table->dev_api != NULL; id_table++) {
-		if (strcmp(id_table->dev_api, dev->api) != 0)
+		if (!uacce_match_api(dev, forward_compat, id_table))
 			continue;
 
-		if (id_table->dev_alg == NULL)
+		if (id_table->dev_alg == NULL) {
+			dev->api_ver = api_ver;
 			return true;
+		}
 
 		/* The dev->algs's algrothims is separated by new line, for
 		 * example: dev->algs could be: aaa\nbbbb\ncc, which has three
@@ -352,6 +396,7 @@ uacce_match(const struct rte_uacce_driver *dr, const struct rte_uacce_device *de
 		if (map[len] != '\0' && map[len] != '\n')
 			continue;
 
+		dev->api_ver = api_ver;
 		return true;
 	}
 
-- 
2.17.1

