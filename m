Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CCEC624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:57:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9079142E60;
	Thu,  3 Sep 2026 15:54:36 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9A27542E46
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:29 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 793DB200483;
 Thu,  3 Sep 2026 15:54:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 18FBB200490;
 Thu,  3 Sep 2026 15:54:29 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 004E918000B7;
 Thu,  3 Sep 2026 21:54:27 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 27/45] drivers: refresh dpaa2 MC and SoC version info
Date: Thu,  3 Sep 2026 19:23:35 +0530
Message-ID: <20260903135353.3358303-28-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

Fix MC revision typo to correct major to minor.
Get MC/SoC rev info only once and save them in bus info
as well as other information to reduce replicated variables.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h     |  11 +-
 drivers/bus/fslmc/fslmc_bus.c            |   2 +
 drivers/bus/fslmc/fslmc_vfio.c           | 200 ++++++++++++++++++-----
 drivers/bus/fslmc/fslmc_vfio.h           |  30 +++-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |  79 +--------
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h |   7 -
 drivers/bus/fslmc/private.h              |   3 +
 drivers/net/dpaa2/dpaa2_ethdev.c         |  18 +-
 drivers/net/dpaa2/dpaa2_ethdev.h         |   1 +
 drivers/net/dpaa2/dpaa2_rxtx.c           |  10 +-
 10 files changed, 225 insertions(+), 136 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index c64ef094d0..b4a5a86318 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2016,2021-2023 NXP
+ *   Copyright 2016,2021-2026 NXP
  *
  */
 
@@ -89,6 +89,14 @@ enum rte_dpaa2_dev_type {
 	DPAA2_DEVTYPE_MAX,
 };
 
+struct rte_fslmc_bus_info {
+	void *mem_pool;
+	int sp_protocol;
+	uint64_t mc_rev;
+	uint32_t svr;
+	uint32_t pvr;
+};
+
 /**
  * A structure describing a DPAA2 device.
  */
@@ -103,6 +111,7 @@ struct rte_dpaa2_device {
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
 	char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
 	struct rte_dma_dev *dmadev;          /**< DMA device */
+	const struct rte_fslmc_bus_info *bus_info;
 };
 
 typedef int (*rte_dpaa2_obj_create_t)(int vdev_fd,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index ee162b0ed8..2427421075 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -29,6 +29,7 @@
 
 struct rte_bus rte_fslmc_bus;
 static int fslmc_bus_device_count[DPAA2_DEVTYPE_MAX];
+struct rte_fslmc_bus_info fslmc_bus_info;
 
 #define DPAA2_SEQN_DYNFIELD_NAME "dpaa2_seqn_dynfield"
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_seqn_dynfield_offset)
@@ -199,6 +200,7 @@ scan_one_fslmc_device(char *dev_name)
 		goto cleanup;
 	}
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
+	dev->bus_info = &fslmc_bus_info;
 
 	/* Update the device found into the device_count table */
 	fslmc_bus_device_count[dev->dev_type]++;
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 412b70e5ae..4eb8552696 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -87,6 +87,83 @@ enum {
 	FSLMC_VFIO_SOCKET_REQ_MEM
 };
 
+/* Variable to store DPAA2 platform type */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_svr_family)
+uint32_t dpaa2_svr_family;
+
+/* Variable to store DPAA2 DQRR size */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dqrr_size)
+uint32_t dpaa2_dqrr_size;
+/* Variable to store DPAA2 EQCR size */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eqcr_size)
+uint32_t dpaa2_eqcr_size;
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_cluster_base)
+uint32_t dpaa2_cluster_base;
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_cluster_size)
+uint32_t dpaa2_cluster_size;
+
+struct fslmc_soc_type {
+	uint32_t svr;
+	uint32_t cluster_base;
+	uint32_t cluster_size;
+	uint32_t qm_dq_size;
+	uint32_t qm_eq_size;
+};
+
+/* For LS208X platform There are four clusters with following mapping:
+ * Cluster 1 (ID = x04) : CPU0, CPU1;
+ * Cluster 2 (ID = x05) : CPU2, CPU3;
+ * Cluster 3 (ID = x06) : CPU4, CPU5;
+ * Cluster 4 (ID = x07) : CPU6, CPU7;
+ */
+/* For LS108X platform There are two clusters with following mapping:
+ * Cluster 1 (ID = x02) : CPU0, CPU1, CPU2, CPU3;
+ * Cluster 2 (ID = x03) : CPU4, CPU5, CPU6, CPU7;
+ */
+/* For LX2160 platform There are four clusters with following mapping:
+ * Cluster 1 (ID = x00) : CPU0, CPU1;
+ * Cluster 2 (ID = x01) : CPU2, CPU3;
+ * Cluster 3 (ID = x02) : CPU4, CPU5;
+ * Cluster 4 (ID = x03) : CPU6, CPU7;
+ * Cluster 1 (ID = x04) : CPU8, CPU9;
+ * Cluster 2 (ID = x05) : CPU10, CP11;
+ * Cluster 3 (ID = x06) : CPU12, CPU13;
+ * Cluster 4 (ID = x07) : CPU14, CPU15;
+ */
+
+int
+fslmc_vfio_core_cluster_sdest(uint32_t cpu_id)
+{
+	int x = cpu_id / dpaa2_cluster_size;
+
+	if (!dpaa2_cluster_size) {
+		DPAA2_BUS_ERR("SoC type has not been initialized!");
+
+		return -ENODEV;
+	}
+
+	return dpaa2_cluster_base + x;
+}
+
+static const struct fslmc_soc_type s_soc_type[] = {
+	{
+		SVR_LS2080A, 4, 2,
+		DPAA2_DQRR_RING_SIZE, DPAA2_EQCR_RING_SIZE
+	},
+	{
+		SVR_LS2088A, 4, 2,
+		DPAA2_DQRR_RING_SIZE, DPAA2_EQCR_RING_SIZE
+	},
+	{
+		SVR_LS1080A, 2, 4,
+		DPAA2_DQRR_RING_SIZE, DPAA2_EQCR_RING_SIZE
+	},
+	{
+		SVR_LX2160A, 0, 2,
+		DPAA2_LX2_DQRR_RING_SIZE, DPAA2_LX2_EQCR_RING_SIZE
+	}
+};
+
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_get_mcp_ptr)
 void *
 dpaa2_get_mcp_ptr(int portal_idx)
@@ -168,6 +245,70 @@ rte_fslmc_object_register(struct rte_dpaa2_object *object)
 	TAILQ_INSERT_TAIL(&dpaa2_obj_list, object, next);
 }
 
+static int
+fslmc_vfio_get_bus_info(void *regs, struct rte_fslmc_bus_info *bus_info)
+{
+	struct fsl_mc_io mc_io;
+	struct mc_version mc_ver_info = {0};
+	struct mc_soc_version mc_plat_info;
+	int ret;
+	size_t i;
+
+	mc_io.regs = regs;
+
+	ret = mc_get_version(&mc_io, CMD_PRI_LOW, &mc_ver_info);
+	if (ret) {
+		DPAA2_BUS_ERR("Failed(%d) to obtain MC version.", ret);
+		return ret;
+	}
+	DPAA2_BUS_INFO("MC version is %d.%d.%d.", mc_ver_info.major,
+		mc_ver_info.minor, mc_ver_info.revision);
+
+	bus_info->mc_rev = RTE_FSL_MC_REV(mc_ver_info.major,
+		mc_ver_info.minor, mc_ver_info.revision);
+
+	if (bus_info->mc_rev < RTE_FSL_MC_REV(MC_VER_MAJOR, MC_VER_MINOR, 0)) {
+		DPAA2_BUS_ERR("DPAA2 MC version not compatible! %d.%d.%d < %d.%d.0",
+			mc_ver_info.major, mc_ver_info.minor, mc_ver_info.revision,
+			MC_VER_MAJOR, MC_VER_MINOR);
+		return -EPERM;
+	}
+
+	memset(&mc_plat_info, 0, sizeof(struct mc_soc_version));
+	ret = mc_get_soc_version(&mc_io, CMD_PRI_LOW, &mc_plat_info);
+	if (ret) {
+		DPAA2_BUS_ERR("Unable to get SoC version err:%d", ret);
+		return ret;
+	}
+
+	memset(&mc_plat_info, 0, sizeof(struct mc_soc_version));
+	ret = mc_get_soc_version(&mc_io, CMD_PRI_LOW, &mc_plat_info);
+	if (ret) {
+		DPAA2_BUS_ERR("Unable to get SoC version err:%d", ret);
+		return ret;
+	}
+
+	for (i = 0; i < RTE_DIM(s_soc_type); i++) {
+		if ((mc_plat_info.svr & DPAA2_SVR_MASK) == s_soc_type[i].svr) {
+			dpaa2_svr_family = s_soc_type[i].svr;
+			dpaa2_cluster_base = s_soc_type[i].cluster_base;
+			dpaa2_cluster_size = s_soc_type[i].cluster_size;
+			dpaa2_dqrr_size = s_soc_type[i].qm_dq_size;
+			dpaa2_eqcr_size = s_soc_type[i].qm_eq_size;
+			break;
+		}
+	}
+	if (i == RTE_DIM(s_soc_type)) {
+		DPAA2_BUS_ERR("Invalid SoC version: 0x%08x", mc_plat_info.svr);
+		return -ENODEV;
+	}
+
+	bus_info->svr = mc_plat_info.svr;
+	bus_info->pvr = mc_plat_info.pvr;
+
+	return 0;
+}
+
 static const char *
 fslmc_vfio_get_group_name(void)
 {
@@ -1247,9 +1388,9 @@ fslmc_vfio_setup_device(const char *dev_addr,
 			dev_addr);
 }
 
-static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
+static void *fslmc_vfio_map_mcp_obj(const char *mcp_obj)
 {
-	intptr_t v_addr = (intptr_t)MAP_FAILED;
+	void *v_addr = MAP_FAILED;
 	int32_t ret, mc_fd;
 	struct vfio_group_status status = { .argsz = sizeof(status) };
 
@@ -1265,7 +1406,7 @@ static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
 		goto MC_FAILURE;
 	}
 
-	v_addr = (size_t)mmap(NULL, reg_info.size,
+	v_addr = mmap(NULL, reg_info.size,
 		PROT_WRITE | PROT_READ, MAP_SHARED,
 		mc_fd, reg_info.offset);
 
@@ -1388,7 +1529,7 @@ rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
 }
 
 static void
-fslmc_close_iodevices(struct rte_dpaa2_device *dev,
+fslmc_vfio_close_iodevices(struct rte_dpaa2_device *dev,
 	int vfio_fd)
 {
 	struct rte_dpaa2_object *object = NULL;
@@ -1431,11 +1572,11 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 }
 
 /*
- * fslmc_process_iodevices for processing only IO (ETH, CRYPTO, and possibly
+ * fslmc_vfio_process_iodevices for processing only IO (ETH, CRYPTO, and possibly
  * EVENT) devices.
  */
 static int
-fslmc_process_iodevices(struct rte_dpaa2_device *dev)
+fslmc_vfio_process_iodevices(struct rte_dpaa2_device *dev)
 {
 	int dev_fd, ret;
 	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
@@ -1477,12 +1618,10 @@ fslmc_process_iodevices(struct rte_dpaa2_device *dev)
 }
 
 static int
-fslmc_process_mcp(struct rte_dpaa2_device *dev)
+fslmc_vfio_process_mcp(struct rte_dpaa2_device *dev)
 {
 	int ret;
-	intptr_t v_addr;
-	struct fsl_mc_io dpmng  = {0};
-	struct mc_version mc_ver_info = {0};
+	void *v_addr;
 
 	rte_mcp_ptr_list = malloc(sizeof(void *) * (MC_PORTAL_INDEX + 1));
 	if (!rte_mcp_ptr_list) {
@@ -1491,15 +1630,16 @@ fslmc_process_mcp(struct rte_dpaa2_device *dev)
 		goto cleanup;
 	}
 
-	v_addr = vfio_map_mcp_obj(dev->device.name);
-	if (v_addr == (intptr_t)MAP_FAILED) {
+	v_addr = fslmc_vfio_map_mcp_obj(dev->device.name);
+	if (v_addr == MAP_FAILED) {
 		DPAA2_BUS_ERR("Error mapping region (errno = %d)", errno);
 		ret = -1;
 		goto cleanup;
 	}
 
-	/* check the MC version compatibility */
-	dpmng.regs = (void *)v_addr;
+	ret = fslmc_vfio_get_bus_info(v_addr, &fslmc_bus_info);
+	if (ret)
+		goto cleanup;
 
 	/* In case of secondary processes, MC version check is no longer
 	 * required.
@@ -1509,23 +1649,7 @@ fslmc_process_mcp(struct rte_dpaa2_device *dev)
 		return 0;
 	}
 
-	if (mc_get_version(&dpmng, CMD_PRI_LOW, &mc_ver_info)) {
-		DPAA2_BUS_ERR("Unable to obtain MC version");
-		ret = -1;
-		goto cleanup;
-	}
-
-	if ((mc_ver_info.major != MC_VER_MAJOR) ||
-	    (mc_ver_info.minor < MC_VER_MINOR)) {
-		DPAA2_BUS_ERR("DPAA2 MC version not compatible!"
-			      " Expected %d.%d.x, Detected %d.%d.%d",
-			      MC_VER_MAJOR, MC_VER_MINOR,
-			      mc_ver_info.major, mc_ver_info.minor,
-			      mc_ver_info.revision);
-		ret = -1;
-		goto cleanup;
-	}
-	rte_mcp_ptr_list[MC_PORTAL_INDEX] = (void *)v_addr;
+	rte_mcp_ptr_list[MC_PORTAL_INDEX] = v_addr;
 
 	return 0;
 
@@ -1567,7 +1691,7 @@ fslmc_vfio_close_group(void)
 		case DPAA2_CRYPTO:
 		case DPAA2_QDMA:
 		case DPAA2_IO:
-			fslmc_close_iodevices(dev, vfio_group_fd);
+			fslmc_vfio_close_iodevices(dev, vfio_group_fd);
 			break;
 		case DPAA2_CON:
 		case DPAA2_CI:
@@ -1576,7 +1700,7 @@ fslmc_vfio_close_group(void)
 			if (rte_eal_process_type() == RTE_PROC_SECONDARY)
 				continue;
 
-			fslmc_close_iodevices(dev, vfio_group_fd);
+			fslmc_vfio_close_iodevices(dev, vfio_group_fd);
 			break;
 		case DPAA2_DPRTC:
 		default:
@@ -1639,7 +1763,7 @@ fslmc_vfio_process_group(void)
 			}
 
 			if (!found_mportal) {
-				ret = fslmc_process_mcp(dev);
+				ret = fslmc_vfio_process_mcp(dev);
 				if (ret) {
 					DPAA2_BUS_ERR("Unable to map MC Portal");
 					return ret;
@@ -1668,7 +1792,7 @@ fslmc_vfio_process_group(void)
 	current_device = 0;
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		if (dev->dev_type == DPAA2_DPRC) {
-			ret = fslmc_process_iodevices(dev);
+			ret = fslmc_vfio_process_iodevices(dev);
 			if (ret) {
 				DPAA2_BUS_ERR("Unable to process dprc");
 				return ret;
@@ -1700,7 +1824,7 @@ fslmc_vfio_process_group(void)
 		case DPAA2_ETH:
 		case DPAA2_CRYPTO:
 		case DPAA2_QDMA:
-			ret = fslmc_process_iodevices(dev);
+			ret = fslmc_vfio_process_iodevices(dev);
 			if (ret) {
 				DPAA2_BUS_DEBUG("Dev (%s) init failed",
 						dev->device.name);
@@ -1723,7 +1847,7 @@ fslmc_vfio_process_group(void)
 			/* Call the object creation routine and remove the
 			 * device entry from device list
 			 */
-			ret = fslmc_process_iodevices(dev);
+			ret = fslmc_vfio_process_iodevices(dev);
 			if (ret) {
 				DPAA2_BUS_DEBUG("Dev (%s) init failed",
 						dev->device.name);
@@ -1747,7 +1871,7 @@ fslmc_vfio_process_group(void)
 				}
 			}
 
-			ret = fslmc_process_iodevices(dev);
+			ret = fslmc_vfio_process_iodevices(dev);
 			if (ret) {
 				DPAA2_BUS_DEBUG("Dev (%s) init failed",
 						dev->device.name);
diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfio.h
index c995fd67b8..554123ffa6 100644
--- a/drivers/bus/fslmc/fslmc_vfio.h
+++ b/drivers/bus/fslmc/fslmc_vfio.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2015-2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016,2019-2023 NXP
+ *   Copyright 2016,2019-2026 NXP
  *
  */
 
@@ -9,6 +9,8 @@
 #define _FSLMC_VFIO_H_
 
 #include <rte_compat.h>
+#include <rte_vfio.h>
+#include <rte_interrupts.h>
 
 /* Pathname of FSL-MC devices directory. */
 #define SYSFS_FSL_MC_DEVICES	"/sys/bus/fsl-mc/devices"
@@ -44,6 +46,30 @@ struct fslmc_vfio_container {
 
 extern char *fslmc_container;
 
+extern uint32_t dpaa2_svr_family;
+extern uint32_t dpaa2_dqrr_size;
+extern uint32_t dpaa2_eqcr_size;
+extern uint32_t dpaa2_cluster_base;
+extern uint32_t dpaa2_cluster_size;
+
+#define DPAA2_SVR_MASK 0xffff0000
+
+#define SVR_LS1080A	0x87030000
+#define SVR_LS2080A	0x87010000
+#define SVR_LS2088A	0x87090000
+#define SVR_LX2160A	0x87360000
+
+#define MC_MAJOR_OFFSET 32
+#define MC_MINOR_OFFSET 16
+#define MC_MINOR_MASK ((((uint64_t)1) << (MC_MAJOR_OFFSET - MC_MINOR_OFFSET)) - 1)
+#define MC_REVISION_MASK ((((uint64_t)1) << MC_MINOR_OFFSET) - 1)
+#define RTE_FSL_MC_REV(major, minor, revision) \
+	((((uint64_t)(major)) << MC_MAJOR_OFFSET) + \
+	(((uint64_t)(minor)) << MC_MINOR_OFFSET) + (revision))
+#define RTE_FSL_MC_REV_MAJOR(rev) ((uint32_t)((rev) >> MC_MAJOR_OFFSET))
+#define RTE_FSL_MC_REV_MINOR(rev) ((uint32_t)(((rev) >> MC_MINOR_OFFSET) & MC_MINOR_MASK))
+#define RTE_FSL_MC_REV_REVISION(rev) ((uint32_t)((rev) & MC_REVISION_MASK))
+
 __rte_internal
 int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index);
 
@@ -60,4 +86,6 @@ int fslmc_vfio_close_group(void);
 char *fslmc_get_container(void);
 int fslmc_get_container_group(const char *group_name, int *gropuid);
 int fslmc_vfio_dmamap(void);
+int fslmc_vfio_core_cluster_sdest(uint32_t cpu_id);
+
 #endif /* _FSLMC_VFIO_H_ */
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e17050b625..20d1bb2a66 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2022 NXP
+ *   Copyright 2016-2026 NXP
  *
  */
 #include <uapi/linux/vfio.h>
@@ -63,45 +63,9 @@ static struct dpio_dev_list dpio_dev_list
 	= TAILQ_HEAD_INITIALIZER(dpio_dev_list); /*!< DPIO device list */
 static uint32_t io_space_count;
 
-/* Variable to store DPAA2 platform type */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_svr_family)
-uint32_t dpaa2_svr_family;
-
-/* Variable to store DPAA2 DQRR size */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dqrr_size)
-uint8_t dpaa2_dqrr_size;
-/* Variable to store DPAA2 EQCR size */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eqcr_size)
-uint8_t dpaa2_eqcr_size;
-
 /* Variable to hold the portal_key, once created.*/
 static pthread_key_t dpaa2_portal_key;
 
-/*Stashing Macros default for LS208x*/
-static int dpaa2_core_cluster_base = 0x04;
-static int dpaa2_cluster_sz = 2;
-
-/* For LS208X platform There are four clusters with following mapping:
- * Cluster 1 (ID = x04) : CPU0, CPU1;
- * Cluster 2 (ID = x05) : CPU2, CPU3;
- * Cluster 3 (ID = x06) : CPU4, CPU5;
- * Cluster 4 (ID = x07) : CPU6, CPU7;
- */
-/* For LS108X platform There are two clusters with following mapping:
- * Cluster 1 (ID = x02) : CPU0, CPU1, CPU2, CPU3;
- * Cluster 2 (ID = x03) : CPU4, CPU5, CPU6, CPU7;
- */
-/* For LX2160 platform There are four clusters with following mapping:
- * Cluster 1 (ID = x00) : CPU0, CPU1;
- * Cluster 2 (ID = x01) : CPU2, CPU3;
- * Cluster 3 (ID = x02) : CPU4, CPU5;
- * Cluster 4 (ID = x03) : CPU6, CPU7;
- * Cluster 1 (ID = x04) : CPU8, CPU9;
- * Cluster 2 (ID = x05) : CPU10, CP11;
- * Cluster 3 (ID = x06) : CPU12, CPU13;
- * Cluster 4 (ID = x07) : CPU14, CPU15;
- */
-
 static struct dpaa2_dpio_dev *get_dpio_dev_from_id(int32_t dpio_id)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
@@ -141,14 +105,6 @@ dpaa2_get_core_id(void)
 	return cpu_id;
 }
 
-static int
-dpaa2_core_cluster_sdest(int cpu_id)
-{
-	int x = cpu_id / dpaa2_cluster_sz;
-
-	return dpaa2_core_cluster_base + x;
-}
-
 static void
 dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
 {
@@ -307,15 +263,17 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id, bool ethrx
 	/* Set the STASH Destination depending on Current CPU ID.
 	 * Valid values of SDEST are 4,5,6,7. Where,
 	 */
-	sdest = dpaa2_core_cluster_sdest(cpu_id);
+	sdest = fslmc_vfio_core_cluster_sdest(cpu_id);
 	DPAA2_BUS_DEBUG("Portal= %d  CPU= %u SDEST= %d",
 			dpio_dev->index, cpu_id, sdest);
+	if (sdest < 0)
+		return sdest;
 
 	ret = dpio_set_stashing_destination(dpio_dev->dpio, CMD_PRI_LOW,
 					    dpio_dev->token, sdest);
 	if (ret) {
 		DPAA2_BUS_ERR("%d ERROR in SDEST",  ret);
-		return -1;
+		return ret;
 	}
 
 #ifdef RTE_EVENT_DPAA2
@@ -542,33 +500,6 @@ dpaa2_create_dpio_device(int vdev_fd,
 		goto err;
 	}
 
-	/* find the SoC type for the first time */
-	if (!dpaa2_svr_family) {
-		struct mc_soc_version mc_plat_info = {0};
-
-		if (mc_get_soc_version(dpio_dev->dpio,
-				       CMD_PRI_LOW, &mc_plat_info)) {
-			DPAA2_BUS_ERR("Unable to get SoC version information");
-		} else if ((mc_plat_info.svr & 0xffff0000) == SVR_LS1080A) {
-			dpaa2_core_cluster_base = 0x02;
-			dpaa2_cluster_sz = 4;
-			DPAA2_BUS_DEBUG("LS108x (A53) Platform Detected");
-		} else if ((mc_plat_info.svr & 0xffff0000) == SVR_LX2160A) {
-			dpaa2_core_cluster_base = 0x00;
-			dpaa2_cluster_sz = 2;
-			DPAA2_BUS_DEBUG("LX2160 Platform Detected");
-		}
-		dpaa2_svr_family = (mc_plat_info.svr & 0xffff0000);
-
-		if (dpaa2_svr_family == SVR_LX2160A) {
-			dpaa2_dqrr_size = DPAA2_LX2_DQRR_RING_SIZE;
-			dpaa2_eqcr_size = DPAA2_LX2_EQCR_RING_SIZE;
-		} else {
-			dpaa2_dqrr_size = DPAA2_DQRR_RING_SIZE;
-			dpaa2_eqcr_size = DPAA2_EQCR_RING_SIZE;
-		}
-	}
-
 	if (dpaa2_svr_family == SVR_LX2160A)
 		reg_info.index = DPAA2_SWP_CENA_MEM_REGION;
 	else
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 7e2271cc35..2c559e5354 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -35,13 +35,6 @@ RTE_DECLARE_PER_LCORE(struct dpaa2_io_portal_t, _dpaa2_io);
 #define DPAA2_PER_LCORE_DQRR_MBUF(i) \
 	RTE_PER_LCORE(_dpaa2_io).dpio_dev->dpaa2_held_bufs.mbuf[i]
 
-/* Variable to store DPAA2 DQRR size */
-extern uint8_t dpaa2_dqrr_size;
-/* Variable to store DPAA2 EQCR size */
-extern uint8_t dpaa2_eqcr_size;
-
-extern struct dpaa2_io_portal_t dpaa2_io_portal[RTE_MAX_LCORE];
-
 /* Affine a DPIO portal to current processing thread */
 __rte_internal
 int dpaa2_affine_qbman_swp(void);
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index 20a454c3fc..1c8a3e59e9 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -11,4 +11,7 @@
 
 extern struct rte_bus rte_fslmc_bus;
 
+/* MC/SoC version and capability info, shared by the bus and VFIO code. */
+extern struct rte_fslmc_bus_info fslmc_bus_info;
+
 #endif /* BUS_FSLMC_PRIVATE_H */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 1df84e1316..e6ce29b2ea 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -329,24 +329,21 @@ dpaa2_fw_version_get(struct rte_eth_dev *dev,
 	char *fw_version, size_t fw_size)
 {
 	int ret;
+	uint32_t major, minor, rev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = dev->process_private;
 	struct mc_soc_version mc_plat_info = {0};
-	struct mc_version mc_ver_info = {0};
 
 	PMD_INIT_FUNC_TRACE();
 
+	major = RTE_FSL_MC_REV_MAJOR(priv->mc_rev);
+	minor = RTE_FSL_MC_REV_MINOR(priv->mc_rev);
+	rev = RTE_FSL_MC_REV_REVISION(priv->mc_rev);
 	if (mc_get_soc_version(dpni, CMD_PRI_LOW, &mc_plat_info))
 		DPAA2_PMD_WARN("\tmc_get_soc_version failed");
 
-	if (mc_get_version(dpni, CMD_PRI_LOW, &mc_ver_info))
-		DPAA2_PMD_WARN("\tmc_get_version failed");
-
-	ret = snprintf(fw_version, fw_size,
-		       "%x-%d.%d.%d",
-		       mc_plat_info.svr,
-		       mc_ver_info.major,
-		       mc_ver_info.minor,
-		       mc_ver_info.revision);
+	ret = snprintf(fw_version, fw_size, "%x-%d.%d.%d",
+		mc_plat_info.svr, major, minor, rev);
 	if (ret < 0)
 		return -EINVAL;
 
@@ -3537,6 +3534,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	priv->mc_rev = dpaa2_dev->bus_info->mc_rev;
 	priv->num_rx_tc = attr.num_rx_tcs;
 	priv->num_tx_tc = attr.num_tx_tcs;
 	priv->qos_entries = attr.qos_entries;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 6c72b9012c..f1d1967cd1 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -528,6 +528,7 @@ struct dpaa2_dev_priv {
 	uint32_t *cnt_idx_dma_mem;
 	uint64_t *cnt_values_dma_mem;
 	uint64_t cnt_idx_iova, cnt_values_iova;
+	uint64_t mc_rev;
 
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 26c84e7125..f417edf52b 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1123,9 +1123,9 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 	/* Function receive frames for a given device and VQ */
 	struct dpaa2_queue *dpaa2_q = queue;
 	struct qbman_result *dq_storage;
-	uint32_t fqid = dpaa2_q->fqid;
-	int ret, num_rx = 0, next_pull = nb_pkts, num_pulled;
-	uint8_t pending, status;
+	uint32_t fqid = dpaa2_q->fqid, next_pull = nb_pkts;
+	int ret;
+	uint8_t pending, status, num_rx = 0, num_pulled;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
@@ -1269,8 +1269,8 @@ uint16_t dpaa2_dev_tx_conf(void *queue)
 	struct dpaa2_queue *dpaa2_q = (struct dpaa2_queue *)queue;
 	struct qbman_result *dq_storage;
 	uint32_t fqid = dpaa2_q->fqid;
-	int ret, num_tx_conf = 0, num_pulled;
-	uint8_t pending, status;
+	int ret, num_tx_conf = 0;
+	uint8_t pending, status, num_pulled;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
-- 
2.43.0

