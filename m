Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AF606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:21:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B77A040A77;
	Fri, 30 Oct 2026 06:20:36 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 2A02040A80
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:31 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E05571A00B9;
 Fri, 30 Oct 2026 06:20:30 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 52DB11A00B3;
 Fri, 30 Oct 2026 06:20:30 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EE39F1800068;
 Fri, 30 Oct 2026 13:20:28 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S3 08/14] drivers: bus/fslmc centralize device handling
Date: Fri, 30 Oct 2026 10:50:10 +0530
Message-ID: <20261030052016.3301766-9-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Move device enumeration, initialization and cleanup sequencing
from the VFIO implementation into the FSLMC bus layer.

Introduce a shared bus information structure to hold MC
revision and platform information and associate it with each
discovered device. Retrieve MC and SoC information during MCP
processing and make the resulting bus data available to bus
clients.

As part of this restructuring:
- add a common bus information object and device reference;
- move group device processing and cleanup orchestration into
  the bus layer;
- keep VFIO code focused on VFIO resource management and device
  access;
- centralize MC version and SoC information handling;
- move platform-specific topology information from DPIO code to
  the VFIO layer.

This prepares the bus infrastructure for sharing platform and
management-controller information across FSLMC devices while
separating bus management from VFIO implementation details.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h     |  10 +-
 drivers/bus/fslmc/fslmc_bus.c            | 219 +++++++++-
 drivers/bus/fslmc/fslmc_vfio.c           | 526 ++++++++++-------------
 drivers/bus/fslmc/fslmc_vfio.h           |  71 ++-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |  79 +---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h |   9 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c |   3 +-
 drivers/bus/fslmc/private.h              |  15 +-
 drivers/net/dpaa2/dpaa2_ethdev.c         |  18 +-
 drivers/net/dpaa2/dpaa2_ethdev.h         |   1 +
 drivers/net/dpaa2/dpaa2_rxtx.c           |   7 +-
 11 files changed, 516 insertions(+), 442 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 44f81cf662..26292e54bb 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2016,2021-2023 NXP
+ *   Copyright 2016,2021-2026 NXP
  *
  */
 
@@ -89,6 +89,13 @@ enum rte_dpaa2_dev_type {
 	DPAA2_DEVTYPE_MAX,
 };
 
+struct rte_fslmc_bus_info {
+	int sp_protocol;
+	uint64_t mc_rev;
+	uint32_t svr;
+	uint32_t pvr;
+};
+
 /**
  * A structure describing a DPAA2 device.
  */
@@ -102,6 +109,7 @@ struct rte_dpaa2_device {
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
 	struct rte_intr_handle *intr_handle; /**< Interrupt handle */
 	char name[FSLMC_OBJECT_MAX_LEN];    /**< DPAA2 Object name*/
+	const struct rte_fslmc_bus_info *bus_info;
 };
 
 typedef int (*rte_dpaa2_obj_create_t)(int vdev_fd,
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 1c638a2d82..de7e9b78c1 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2016,2018-2021 NXP
+ *   Copyright 2016,2018-2021, 2026 NXP
  *
  */
 
@@ -29,6 +29,7 @@
 
 struct rte_bus rte_fslmc_bus;
 static int fslmc_bus_device_count[DPAA2_DEVTYPE_MAX];
+static struct rte_fslmc_bus_info fslmc_bus_info;
 
 #define DPAA2_SEQN_DYNFIELD_NAME "dpaa2_seqn_dynfield"
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_seqn_dynfield_offset)
@@ -199,6 +200,7 @@ scan_one_fslmc_device(char *dev_name)
 		goto cleanup;
 	}
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
+	dev->bus_info = &fslmc_bus_info;
 
 	/* Update the device found into the device_count table */
 	fslmc_bus_device_count[dev->dev_type]++;
@@ -332,7 +334,7 @@ rte_fslmc_scan(void)
 		goto scan_fail;
 	}
 
-	ret = fslmc_get_container_group(group_name, &groupid);
+	ret = fslmc_vfio_get_container_group(group_name, &groupid);
 	if (ret != 0)
 		goto scan_fail;
 
@@ -383,6 +385,175 @@ rte_fslmc_scan(void)
 	return 0;
 }
 
+static int
+fslmc_bus_process_iodevices(void)
+{
+	int ret;
+	int found_mportal = 0;
+	struct rte_dpaa2_device *dev;
+	bool is_dpmcp_in_blocklist = false, is_dpio_in_blocklist = false;
+	int dpmcp_count = 0, dpio_count = 0, current_device;
+
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		if (dev->dev_type == DPAA2_MPORTAL) {
+			dpmcp_count++;
+			if (dev->device.devargs &&
+			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
+				is_dpmcp_in_blocklist = true;
+		}
+		if (dev->dev_type == DPAA2_IO) {
+			dpio_count++;
+			if (dev->device.devargs &&
+			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
+				is_dpio_in_blocklist = true;
+		}
+	}
+
+	/* Search the MCP as that should be initialized first. */
+	current_device = 0;
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		if (dev->dev_type == DPAA2_MPORTAL) {
+			current_device++;
+			if (dev->device.devargs &&
+			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+				DPAA2_BUS_DEBUG("%s Blocked, skipping", dev->device.name);
+				rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+				continue;
+			}
+
+			if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+			    !is_dpmcp_in_blocklist) {
+				if (dpmcp_count == 1 ||
+				    current_device != dpmcp_count) {
+					rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+					continue;
+				}
+			}
+
+			if (!found_mportal) {
+				ret = fslmc_vfio_process_mcp(dev, &fslmc_bus_info);
+				if (ret) {
+					DPAA2_BUS_ERR("Unable to map MC Portal");
+					return ret;
+				}
+				found_mportal = 1;
+			}
+
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			free(dev);
+			dev = NULL;
+			/* Ideally there is only a single dpmcp, but in case
+			 * multiple exists, looping on remaining devices.
+			 */
+		}
+	}
+
+	/* Cannot continue if there is not even a single mportal */
+	if (!found_mportal) {
+		DPAA2_BUS_ERR("No MC Portal device found. Not continuing");
+		return -EIO;
+	}
+
+	/* Search for DPRC device next as it updates endpoint of
+	 * other devices.
+	 */
+	current_device = 0;
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		if (dev->dev_type == DPAA2_DPRC) {
+			ret = fslmc_vfio_process_iodevices(dev);
+			if (ret) {
+				DPAA2_BUS_ERR("Unable to process dprc");
+				return ret;
+			}
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+		}
+	}
+
+	current_device = 0;
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		if (dev->dev_type == DPAA2_IO)
+			current_device++;
+		if (dev->device.devargs &&
+		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+			DPAA2_BUS_DEBUG("%s Blocked, skipping", dev->device.name);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			continue;
+		}
+		if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		    dev->dev_type != DPAA2_ETH &&
+		    dev->dev_type != DPAA2_CRYPTO &&
+		    dev->dev_type != DPAA2_QDMA &&
+		    dev->dev_type != DPAA2_IO) {
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			continue;
+		}
+		switch (dev->dev_type) {
+		case DPAA2_ETH:
+		case DPAA2_CRYPTO:
+		case DPAA2_QDMA:
+			ret = fslmc_vfio_process_iodevices(dev);
+			if (ret) {
+				DPAA2_BUS_DEBUG("Dev (%s) init failed", dev->device.name);
+				return ret;
+			}
+			break;
+		case DPAA2_CON:
+		case DPAA2_CI:
+		case DPAA2_BPOOL:
+		case DPAA2_DPRTC:
+		case DPAA2_MUX:
+			/* IN case of secondary processes, all control objects
+			 * like dpbp, dpcon, dpci are not initialized/required
+			 * - all of these are assumed to be initialized and made
+			 *   available by primary.
+			 */
+			if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+				continue;
+
+			/* Call the object creation routine and remove the
+			 * device entry from device list
+			 */
+			ret = fslmc_vfio_process_iodevices(dev);
+			if (ret) {
+				DPAA2_BUS_DEBUG("Dev (%s) init failed", dev->device.name);
+				return ret;
+			}
+
+			break;
+		case DPAA2_IO:
+			if (!is_dpio_in_blocklist && dpio_count > 1) {
+				if (rte_eal_process_type() == RTE_PROC_SECONDARY
+				    && current_device != dpio_count) {
+					rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+					break;
+				}
+				if (rte_eal_process_type() == RTE_PROC_PRIMARY
+				    && current_device == dpio_count) {
+					rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+					break;
+				}
+			}
+
+			ret = fslmc_vfio_process_iodevices(dev);
+			if (ret) {
+				DPAA2_BUS_DEBUG("Dev (%s) init failed", dev->device.name);
+				return ret;
+			}
+
+			break;
+		case DPAA2_UNKNOWN:
+		default:
+			/* Unknown - ignore */
+			DPAA2_BUS_DEBUG("Found unknown device (%s)", dev->device.name);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+			free(dev);
+			dev = NULL;
+		}
+	}
+
+	return 0;
+}
+
 /* Bus initialization needs the DPDK heap and DMA mapping of the memory
  * segments, which EAL only sets up after the bus scan, so it is done here.
  */
@@ -424,7 +595,7 @@ rte_fslmc_probe(struct rte_bus *bus)
 		}
 	}
 
-	ret = fslmc_vfio_process_group();
+	ret = fslmc_bus_process_iodevices();
 	if (ret) {
 		DPAA2_BUS_ERR("Unable to setup devices %d", ret);
 		return ret;
@@ -445,12 +616,52 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 	return false;
 }
 
+static int
+fslmc_bus_close_group(void)
+{
+	struct rte_dpaa2_device *dev;
+
+	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
+		if (dev->device.devargs &&
+		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+			DPAA2_BUS_DEBUG("%s Blacklisted, skipping", dev->device.name);
+			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
+				continue;
+		}
+		switch (dev->dev_type) {
+		case DPAA2_ETH:
+		case DPAA2_CRYPTO:
+		case DPAA2_QDMA:
+		case DPAA2_IO:
+			fslmc_vfio_close_iodevices(dev);
+			break;
+		case DPAA2_CON:
+		case DPAA2_CI:
+		case DPAA2_BPOOL:
+		case DPAA2_MUX:
+			if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+				continue;
+
+			fslmc_vfio_close_iodevices(dev);
+			break;
+		case DPAA2_DPRTC:
+		default:
+			DPAA2_BUS_DEBUG("Device cannot be closed: Not supported (%s)",
+					dev->device.name);
+		}
+	}
+
+	fslmc_vfio_clear_group();
+
+	return 0;
+}
+
 static int
 rte_fslmc_close(struct rte_bus *bus __rte_unused)
 {
 	int ret = 0;
 
-	ret = fslmc_vfio_close_group();
+	ret = fslmc_bus_close_group();
 	if (ret)
 		DPAA2_BUS_INFO("Unable to close devices %d", ret);
 
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index adde629ce6..58e33c6866 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2015-2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2024 NXP
+ *   Copyright 2016-2024, 2026 NXP
  *
  */
 
@@ -47,6 +47,29 @@
 
 #define FSLMC_VFIO_MP "fslmc_vfio_mp_sync"
 
+struct fslmc_vfio_device {
+	LIST_ENTRY(fslmc_vfio_device) next;
+	int fd; /* fslmc root container device ?? */
+	int index; /*index of child object */
+	char dev_name[64];
+	struct fslmc_vfio_device *child; /* Child object */
+};
+
+struct fslmc_vfio_group {
+	LIST_ENTRY(fslmc_vfio_group) next;
+	int fd; /* /dev/vfio/"groupid" */
+	int groupid;
+	int connected;
+	char group_name[64]; /* dprc.x*/
+	int iommu_type;
+	LIST_HEAD(, fslmc_vfio_device) vfio_devices;
+};
+
+struct fslmc_vfio_container {
+	int fd; /* /dev/vfio/vfio */
+	LIST_HEAD(, fslmc_vfio_group) groups;
+};
+
 /* Container is composed by multiple groups, however,
  * now each process only supports single group with in container.
  */
@@ -87,6 +110,81 @@ enum {
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
+	if (!dpaa2_cluster_size) {
+		DPAA2_BUS_ERR("SoC type has not been initialized!");
+
+		return -ENODEV;
+	}
+
+	return dpaa2_cluster_base + cpu_id / dpaa2_cluster_size;
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
@@ -168,6 +266,63 @@ rte_fslmc_object_register(struct rte_dpaa2_object *object)
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
@@ -202,11 +357,44 @@ fslmc_vfio_add_group(int vfio_group_fd,
 }
 
 static int
-fslmc_vfio_clear_group(int vfio_group_fd)
+fslmc_vfio_group_fd_by_name(const char *group_name)
+{
+	struct fslmc_vfio_group *group;
+
+	LIST_FOREACH(group, &s_vfio_container.groups, next) {
+		if (!strcmp(group->group_name, group_name))
+			return group->fd;
+	}
+	return -ENODEV;
+}
+
+static int
+fslmc_vfio_group_fd(void)
+{
+	const char *group_name = fslmc_vfio_get_group_name();
+	int vfio_group_fd;
+
+	vfio_group_fd = fslmc_vfio_group_fd_by_name(group_name);
+	if (vfio_group_fd <= 0) {
+		DPAA2_BUS_INFO("%s: Get fd by name(%s) failed(%d)",
+			__func__, group_name, vfio_group_fd);
+		if (vfio_group_fd < 0)
+			return vfio_group_fd;
+		return -EIO;
+	}
+
+	return vfio_group_fd;
+}
+
+void
+fslmc_vfio_clear_group(void)
 {
 	struct fslmc_vfio_group *group;
 	struct fslmc_vfio_device *dev;
-	int clear = 0;
+	int clear = 0, vfio_group_fd = fslmc_vfio_group_fd();
+
+	if (vfio_group_fd < 0)
+		return;
 
 	LIST_FOREACH(group, &s_vfio_container.groups, next) {
 		if (group->fd == vfio_group_fd) {
@@ -228,10 +416,8 @@ fslmc_vfio_clear_group(int vfio_group_fd)
 
 		s_vfio_container.fd = -1;
 	}
-	if (clear)
-		return 0;
-
-	return -ENODEV;
+	if (!clear)
+		DPAA2_BUS_ERR("Failed to find vfio group");
 }
 
 static int
@@ -276,18 +462,6 @@ fslmc_vfio_iommu_type(int vfio_group_fd)
 	return -ENODEV;
 }
 
-static int
-fslmc_vfio_group_fd_by_name(const char *group_name)
-{
-	struct fslmc_vfio_group *group;
-
-	LIST_FOREACH(group, &s_vfio_container.groups, next) {
-		if (!strcmp(group->group_name, group_name))
-			return group->fd;
-	}
-	return -ENODEV;
-}
-
 static int
 fslmc_vfio_group_fd_by_id(int group_id)
 {
@@ -356,7 +530,7 @@ fslmc_vfio_container_fd(void)
 }
 
 static int
-fslmc_get_group_id(const char *group_name,
+fslmc_vfio_get_group_id(const char *group_name,
 	int *groupid)
 {
 	int ret;
@@ -393,7 +567,7 @@ fslmc_vfio_open_group_fd(const char *group_name)
 	if (vfio_group_fd > 0)
 		return vfio_group_fd;
 
-	ret = fslmc_get_group_id(group_name, &iommu_group_num);
+	ret = fslmc_vfio_get_group_id(group_name, &iommu_group_num);
 	if (ret)
 		return ret;
 	/* if primary, try to open the group */
@@ -568,7 +742,7 @@ fslmc_vfio_open_container_fd(void)
 }
 
 int
-fslmc_get_container_group(const char *group_name,
+fslmc_vfio_get_container_group(const char *group_name,
 	int *groupid)
 {
 	int ret;
@@ -578,7 +752,7 @@ fslmc_get_container_group(const char *group_name,
 
 		return -EINVAL;
 	}
-	ret = fslmc_get_group_id(group_name, groupid);
+	ret = fslmc_vfio_get_group_id(group_name, groupid);
 	if (ret)
 		return ret;
 
@@ -1246,9 +1420,9 @@ fslmc_vfio_setup_device(const char *dev_addr,
 			dev_addr);
 }
 
-static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
+static void *fslmc_vfio_map_mcp_obj(const char *mcp_obj)
 {
-	intptr_t v_addr = (intptr_t)MAP_FAILED;
+	void *v_addr = MAP_FAILED;
 	int32_t ret, mc_fd;
 	struct vfio_group_status status = { .argsz = sizeof(status) };
 
@@ -1264,7 +1438,7 @@ static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
 		goto MC_FAILURE;
 	}
 
-	v_addr = (size_t)mmap(NULL, reg_info.size,
+	v_addr = mmap(NULL, reg_info.size,
 		PROT_WRITE | PROT_READ, MAP_SHARED,
 		mc_fd, reg_info.offset);
 
@@ -1386,13 +1560,17 @@ rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
 	return -EIO;
 }
 
-static void
-fslmc_close_iodevices(struct rte_dpaa2_device *dev,
-	int vfio_fd)
+void
+fslmc_vfio_close_iodevices(struct rte_dpaa2_device *dev)
 {
 	struct rte_dpaa2_object *object = NULL;
 	const struct rte_dpaa2_driver *drv;
-	int ret;
+	int ret, vfio_fd = fslmc_vfio_group_fd();
+
+	if (vfio_fd <= 0) {
+		DPAA2_BUS_ERR("Failed(%d) to get vfio group fd", vfio_fd);
+		return;
+	}
 
 	switch (dev->dev_type) {
 	case DPAA2_IO:
@@ -1430,11 +1608,11 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 }
 
 /*
- * fslmc_process_iodevices for processing only IO (ETH, CRYPTO, and possibly
+ * fslmc_vfio_process_iodevices for processing only IO (ETH, CRYPTO, and possibly
  * EVENT) devices.
  */
-static int
-fslmc_process_iodevices(struct rte_dpaa2_device *dev)
+int
+fslmc_vfio_process_iodevices(struct rte_dpaa2_device *dev)
 {
 	int dev_fd, ret;
 	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
@@ -1475,13 +1653,12 @@ fslmc_process_iodevices(struct rte_dpaa2_device *dev)
 	return 0;
 }
 
-static int
-fslmc_process_mcp(struct rte_dpaa2_device *dev)
+int
+fslmc_vfio_process_mcp(struct rte_dpaa2_device *dev,
+	struct rte_fslmc_bus_info *bus_info)
 {
 	int ret;
-	intptr_t v_addr;
-	struct fsl_mc_io dpmng  = {0};
-	struct mc_version mc_ver_info = {0};
+	void *v_addr;
 
 	rte_mcp_ptr_list = malloc(sizeof(void *) * (MC_PORTAL_INDEX + 1));
 	if (!rte_mcp_ptr_list) {
@@ -1490,41 +1667,26 @@ fslmc_process_mcp(struct rte_dpaa2_device *dev)
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
+	ret = fslmc_vfio_get_bus_info(v_addr, bus_info);
+	if (ret)
+		goto cleanup;
 
 	/* In case of secondary processes, MC version check is no longer
 	 * required.
 	 */
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-		rte_mcp_ptr_list[MC_PORTAL_INDEX] = (void *)v_addr;
+		rte_mcp_ptr_list[MC_PORTAL_INDEX] = v_addr;
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
 
@@ -1537,237 +1699,6 @@ fslmc_process_mcp(struct rte_dpaa2_device *dev)
 	return ret;
 }
 
-int
-fslmc_vfio_close_group(void)
-{
-	struct rte_dpaa2_device *dev;
-	int vfio_group_fd;
-	const char *group_name = fslmc_vfio_get_group_name();
-
-	vfio_group_fd = fslmc_vfio_group_fd_by_name(group_name);
-	if (vfio_group_fd <= 0) {
-		DPAA2_BUS_INFO("%s: Get fd by name(%s) failed(%d)",
-			__func__, group_name, vfio_group_fd);
-		if (vfio_group_fd < 0)
-			return vfio_group_fd;
-		return -EIO;
-	}
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->device.devargs &&
-		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-			DPAA2_BUS_LOG(DEBUG, "%s Blacklisted, skipping",
-				      dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-				continue;
-		}
-		switch (dev->dev_type) {
-		case DPAA2_ETH:
-		case DPAA2_CRYPTO:
-		case DPAA2_QDMA:
-		case DPAA2_IO:
-			fslmc_close_iodevices(dev, vfio_group_fd);
-			break;
-		case DPAA2_CON:
-		case DPAA2_CI:
-		case DPAA2_BPOOL:
-		case DPAA2_MUX:
-			if (rte_eal_process_type() == RTE_PROC_SECONDARY)
-				continue;
-
-			fslmc_close_iodevices(dev, vfio_group_fd);
-			break;
-		case DPAA2_DPRTC:
-		default:
-			DPAA2_BUS_DEBUG("Device cannot be closed: Not supported (%s)",
-					dev->device.name);
-		}
-	}
-
-	fslmc_vfio_clear_group(vfio_group_fd);
-
-	return 0;
-}
-
-int
-fslmc_vfio_process_group(void)
-{
-	int ret;
-	int found_mportal = 0;
-	struct rte_dpaa2_device *dev;
-	bool is_dpmcp_in_blocklist = false, is_dpio_in_blocklist = false;
-	int dpmcp_count = 0, dpio_count = 0, current_device;
-
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_MPORTAL) {
-			dpmcp_count++;
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
-				is_dpmcp_in_blocklist = true;
-		}
-		if (dev->dev_type == DPAA2_IO) {
-			dpio_count++;
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED)
-				is_dpio_in_blocklist = true;
-		}
-	}
-
-	/* Search the MCP as that should be initialized first. */
-	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_MPORTAL) {
-			current_device++;
-			if (dev->device.devargs &&
-			    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-				DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
-					      dev->device.name);
-				rte_bus_remove_device(&rte_fslmc_bus,
-						&dev->device);
-				continue;
-			}
-
-			if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
-			    !is_dpmcp_in_blocklist) {
-				if (dpmcp_count == 1 ||
-				    current_device != dpmcp_count) {
-					rte_bus_remove_device(&rte_fslmc_bus,
-						     &dev->device);
-					continue;
-				}
-			}
-
-			if (!found_mportal) {
-				ret = fslmc_process_mcp(dev);
-				if (ret) {
-					DPAA2_BUS_ERR("Unable to map MC Portal");
-					return ret;
-				}
-				found_mportal = 1;
-			}
-
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-			free(dev);
-			dev = NULL;
-			/* Ideally there is only a single dpmcp, but in case
-			 * multiple exists, looping on remaining devices.
-			 */
-		}
-	}
-
-	/* Cannot continue if there is not even a single mportal */
-	if (!found_mportal) {
-		DPAA2_BUS_ERR("No MC Portal device found. Not continuing");
-		return -EIO;
-	}
-
-	/* Search for DPRC device next as it updates endpoint of
-	 * other devices.
-	 */
-	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_DPRC) {
-			ret = fslmc_process_iodevices(dev);
-			if (ret) {
-				DPAA2_BUS_ERR("Unable to process dprc");
-				return ret;
-			}
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-		}
-	}
-
-	current_device = 0;
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
-		if (dev->dev_type == DPAA2_IO)
-			current_device++;
-		if (dev->device.devargs &&
-		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-			DPAA2_BUS_LOG(DEBUG, "%s Blocked, skipping",
-				      dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-			continue;
-		}
-		if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
-		    dev->dev_type != DPAA2_ETH &&
-		    dev->dev_type != DPAA2_CRYPTO &&
-		    dev->dev_type != DPAA2_QDMA &&
-		    dev->dev_type != DPAA2_IO) {
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-			continue;
-		}
-		switch (dev->dev_type) {
-		case DPAA2_ETH:
-		case DPAA2_CRYPTO:
-		case DPAA2_QDMA:
-			ret = fslmc_process_iodevices(dev);
-			if (ret) {
-				DPAA2_BUS_DEBUG("Dev (%s) init failed",
-						dev->device.name);
-				return ret;
-			}
-			break;
-		case DPAA2_CON:
-		case DPAA2_CI:
-		case DPAA2_BPOOL:
-		case DPAA2_DPRTC:
-		case DPAA2_MUX:
-			/* IN case of secondary processes, all control objects
-			 * like dpbp, dpcon, dpci are not initialized/required
-			 * - all of these are assumed to be initialized and made
-			 *   available by primary.
-			 */
-			if (rte_eal_process_type() == RTE_PROC_SECONDARY)
-				continue;
-
-			/* Call the object creation routine and remove the
-			 * device entry from device list
-			 */
-			ret = fslmc_process_iodevices(dev);
-			if (ret) {
-				DPAA2_BUS_DEBUG("Dev (%s) init failed",
-						dev->device.name);
-				return ret;
-			}
-
-			break;
-		case DPAA2_IO:
-			if (!is_dpio_in_blocklist && dpio_count > 1) {
-				if (rte_eal_process_type() == RTE_PROC_SECONDARY
-				    && current_device != dpio_count) {
-					rte_bus_remove_device(&rte_fslmc_bus,
-						     &dev->device);
-					break;
-				}
-				if (rte_eal_process_type() == RTE_PROC_PRIMARY
-				    && current_device == dpio_count) {
-					rte_bus_remove_device(&rte_fslmc_bus,
-						     &dev->device);
-					break;
-				}
-			}
-
-			ret = fslmc_process_iodevices(dev);
-			if (ret) {
-				DPAA2_BUS_DEBUG("Dev (%s) init failed",
-						dev->device.name);
-				return ret;
-			}
-
-			break;
-		case DPAA2_UNKNOWN:
-		default:
-			/* Unknown - ignore */
-			DPAA2_BUS_DEBUG("Found unknown device (%s)",
-					dev->device.name);
-			rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
-			free(dev);
-			dev = NULL;
-		}
-	}
-
-	return 0;
-}
-
 int
 fslmc_vfio_setup_group(void)
 {
@@ -1805,21 +1736,20 @@ fslmc_vfio_setup_group(void)
 	if (ret) {
 		DPAA2_BUS_ERR("VFIO(%s:fd=%d) error getting group status(%d)",
 			group_name, vfio_group_fd, ret);
-		fslmc_vfio_clear_group(vfio_group_fd);
+		fslmc_vfio_clear_group();
 		return ret;
 	}
 
 	if (!(status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
 		DPAA2_BUS_ERR("VFIO group not viable");
-		fslmc_vfio_clear_group(vfio_group_fd);
+		fslmc_vfio_clear_group();
 		return -EPERM;
 	}
 
 	/* check if group does not have a container yet */
 	if (!(status.flags & VFIO_GROUP_FLAGS_CONTAINER_SET)) {
 		/* Now connect this IOMMU group to given container */
-		ret = vfio_connect_container(vfio_container_fd,
-			vfio_group_fd);
+		ret = vfio_connect_container(vfio_container_fd, vfio_group_fd);
 	} else {
 		/* Here is supposed in secondary process,
 		 * group has been set to container in primary process.
@@ -1830,7 +1760,7 @@ fslmc_vfio_setup_group(void)
 	}
 	if (ret) {
 		DPAA2_BUS_ERR("vfio group connect failed(%d)", ret);
-		fslmc_vfio_clear_group(vfio_group_fd);
+		fslmc_vfio_clear_group();
 		return ret;
 	}
 
@@ -1838,14 +1768,14 @@ fslmc_vfio_setup_group(void)
 	ret = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD, group_name);
 	if (ret < 0) {
 		DPAA2_BUS_ERR("Error getting device %s fd", group_name);
-		fslmc_vfio_clear_group(vfio_group_fd);
+		fslmc_vfio_clear_group();
 		return ret;
 	}
 
 	ret = fslmc_vfio_mp_sync_setup();
 	if (ret) {
 		DPAA2_BUS_ERR("VFIO MP sync setup failed!");
-		fslmc_vfio_clear_group(vfio_group_fd);
+		fslmc_vfio_clear_group();
 		return ret;
 	}
 
diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfio.h
index c995fd67b8..5a1c9f483e 100644
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
 
@@ -9,40 +9,34 @@
 #define _FSLMC_VFIO_H_
 
 #include <rte_compat.h>
+#include <rte_interrupts.h>
 
 /* Pathname of FSL-MC devices directory. */
 #define SYSFS_FSL_MC_DEVICES	"/sys/bus/fsl-mc/devices"
-#define DPAA2_MC_DPNI_DEVID	7
-#define DPAA2_MC_DPSECI_DEVID	3
-#define DPAA2_MC_DPCON_DEVID	5
-#define DPAA2_MC_DPIO_DEVID	9
-#define DPAA2_MC_DPBP_DEVID	10
-#define DPAA2_MC_DPCI_DEVID	11
-
-struct fslmc_vfio_device {
-	LIST_ENTRY(fslmc_vfio_device) next;
-	int fd; /* fslmc root container device ?? */
-	int index; /*index of child object */
-	char dev_name[64];
-	struct fslmc_vfio_device *child; /* Child object */
-};
-
-struct fslmc_vfio_group {
-	LIST_ENTRY(fslmc_vfio_group) next;
-	int fd; /* /dev/vfio/"groupid" */
-	int groupid;
-	int connected;
-	char group_name[64]; /* dprc.x*/
-	int iommu_type;
-	LIST_HEAD(, fslmc_vfio_device) vfio_devices;
-};
-
-struct fslmc_vfio_container {
-	int fd; /* /dev/vfio/vfio */
-	LIST_HEAD(, fslmc_vfio_group) groups;
-};
-
-extern char *fslmc_container;
+
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
 
 __rte_internal
 int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index);
@@ -50,14 +44,9 @@ int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index);
 __rte_internal
 int rte_dpaa2_intr_disable(struct rte_intr_handle *intr_handle, int index);
 
-int rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
-			      int vfio_dev_fd,
-			      int num_irqs);
+int rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle, int vfio_dev_fd,
+	int num_irqs);
+
+int fslmc_vfio_core_cluster_sdest(uint32_t cpu_id);
 
-int fslmc_vfio_setup_group(void);
-int fslmc_vfio_process_group(void);
-int fslmc_vfio_close_group(void);
-char *fslmc_get_container(void);
-int fslmc_get_container_group(const char *group_name, int *gropuid);
-int fslmc_vfio_dmamap(void);
 #endif /* _FSLMC_VFIO_H_ */
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 9fe449ed38..b1443f327a 100644
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
@@ -548,33 +506,6 @@ dpaa2_create_dpio_device(int vdev_fd,
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
index 7e2271cc35..0838254437 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2023 NXP
+ *   Copyright 2016-2023, 2026 NXP
  *
  */
 
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
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
index 02b69d404d..2234da0975 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2021 NXP
+ *   Copyright 2021, 2026 NXP
  *
  */
 
@@ -17,6 +17,7 @@
 #include <mc/fsl_dprc.h>
 #include "portal/dpaa2_hw_pvt.h"
 
+extern struct rte_bus rte_fslmc_bus;
 TAILQ_HEAD(dprc_dev_list, dpaa2_dprc_dev);
 static struct dprc_dev_list dprc_dev_list
 	= TAILQ_HEAD_INITIALIZER(dprc_dev_list); /*!< DPRC device list */
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index 20a454c3fc..3586092529 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- *   Copyright 2016,2021 NXP
+ *   Copyright 2016, 2021, 2026 NXP
  */
 
 #ifndef BUS_FSLMC_PRIVATE_H
@@ -9,6 +9,17 @@
 
 #include <bus_fslmc_driver.h>
 
-extern struct rte_bus rte_fslmc_bus;
+int fslmc_vfio_process_mcp(struct rte_dpaa2_device *dev,
+	struct rte_fslmc_bus_info *bus_info);
+int fslmc_vfio_process_iodevices(struct rte_dpaa2_device *dev);
+
+void fslmc_vfio_close_iodevices(struct rte_dpaa2_device *dev);
+
+int fslmc_vfio_setup_group(void);
+void fslmc_vfio_clear_group(void);
+
+int fslmc_vfio_get_container_group(const char *group_name, int *gropuid);
+int fslmc_vfio_dmamap(void);
+
 
 #endif /* BUS_FSLMC_PRIVATE_H */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 6f475baa79..81118d02f8 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -382,24 +382,21 @@ dpaa2_fw_version_get(struct rte_eth_dev *dev,
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
 
@@ -3536,6 +3533,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	priv->mc_rev = dpaa2_dev->bus_info->mc_rev;
 	priv->num_rx_tc = attr.num_rx_tcs;
 	priv->num_tx_tc = attr.num_tx_tcs;
 	priv->qos_entries = attr.qos_entries;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 6f4fd01e2f..5bc34a6d92 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -498,6 +498,7 @@ struct dpaa2_dev_priv {
 	uint32_t *cnt_idx_dma_mem;
 	uint64_t *cnt_values_dma_mem;
 	uint64_t cnt_idx_iova, cnt_values_iova;
+	uint64_t mc_rev;
 
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index e52b05ab96..48016c6af5 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1137,7 +1137,8 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 	struct dpaa2_queue *dpaa2_q = queue;
 	struct qbman_result *dq_storage;
 	uint32_t fqid = dpaa2_q->fqid;
-	int ret, num_rx = 0, next_pull = nb_pkts, num_pulled;
+	uint16_t num_rx = 0, next_pull = nb_pkts, num_pulled;
+	int ret;
 	uint8_t pending, status;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
@@ -1281,8 +1282,8 @@ uint16_t dpaa2_dev_tx_conf(void *queue)
 	/* Function receive frames for a given device and VQ */
 	struct dpaa2_queue *dpaa2_q = (struct dpaa2_queue *)queue;
 	struct qbman_result *dq_storage;
-	uint32_t fqid = dpaa2_q->fqid;
-	int ret, num_tx_conf = 0, num_pulled;
+	uint32_t fqid = dpaa2_q->fqid, num_tx_conf = 0, num_pulled;
+	int ret;
 	uint8_t pending, status;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
-- 
2.43.0

