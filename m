Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88343606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0773940BA2;
	Fri, 23 Oct 2026 15:44:07 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 009F940A82
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:01 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C7A381A003D;
 Fri, 23 Oct 2026 15:44:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 677211A000A;
 Fri, 23 Oct 2026 15:44:00 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F40CE18000B1;
 Fri, 23 Oct 2026 21:43:58 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 08/65] bus/fslmc: split bus-level device walk from VFIO
 primitives
Date: Fri, 23 Oct 2026 19:12:48 +0530
Message-ID: <20261023134346.37727-9-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
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

The fslmc bus and its VFIO backend were tangled: VFIO-internal types
and DPAA2_MC_*_DEVID constants were exposed in a public header, and
the device-iteration / blocklist / primary-secondary policy for probe
and close lived inside fslmc_vfio.c (fslmc_vfio_process_group /
fslmc_vfio_close_group) even though it is pure bus logic. On top of
that, several bus-internal symbols were still declared with public
"fslmc_*" names.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/fslmc_bus.c            | 217 ++++++++++++-
 drivers/bus/fslmc/fslmc_vfio.c           | 391 ++++++-----------------
 drivers/bus/fslmc/fslmc_vfio.h           |  48 +--
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c |   3 +-
 drivers/bus/fslmc/private.h              |  14 +-
 5 files changed, 326 insertions(+), 347 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 1c638a2d82..7116817c75 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2016,2018-2021 NXP
+ *   Copyright 2016,2018-2021, 2026 NXP
  *
  */
 
@@ -332,7 +332,7 @@ rte_fslmc_scan(void)
 		goto scan_fail;
 	}
 
-	ret = fslmc_get_container_group(group_name, &groupid);
+	ret = fslmc_vfio_get_container_group(group_name, &groupid);
 	if (ret != 0)
 		goto scan_fail;
 
@@ -383,6 +383,175 @@ rte_fslmc_scan(void)
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
+				ret = fslmc_vfio_process_mcp(dev);
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
@@ -424,7 +593,7 @@ rte_fslmc_probe(struct rte_bus *bus)
 		}
 	}
 
-	ret = fslmc_vfio_process_group();
+	ret = fslmc_bus_process_iodevices();
 	if (ret) {
 		DPAA2_BUS_ERR("Unable to setup devices %d", ret);
 		return ret;
@@ -445,12 +614,52 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
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
index adde629ce6..5b22e985b1 100644
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
@@ -202,11 +225,44 @@ fslmc_vfio_add_group(int vfio_group_fd,
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
@@ -228,10 +284,8 @@ fslmc_vfio_clear_group(int vfio_group_fd)
 
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
@@ -276,18 +330,6 @@ fslmc_vfio_iommu_type(int vfio_group_fd)
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
@@ -356,7 +398,7 @@ fslmc_vfio_container_fd(void)
 }
 
 static int
-fslmc_get_group_id(const char *group_name,
+fslmc_vfio_get_group_id(const char *group_name,
 	int *groupid)
 {
 	int ret;
@@ -393,7 +435,7 @@ fslmc_vfio_open_group_fd(const char *group_name)
 	if (vfio_group_fd > 0)
 		return vfio_group_fd;
 
-	ret = fslmc_get_group_id(group_name, &iommu_group_num);
+	ret = fslmc_vfio_get_group_id(group_name, &iommu_group_num);
 	if (ret)
 		return ret;
 	/* if primary, try to open the group */
@@ -568,7 +610,7 @@ fslmc_vfio_open_container_fd(void)
 }
 
 int
-fslmc_get_container_group(const char *group_name,
+fslmc_vfio_get_container_group(const char *group_name,
 	int *groupid)
 {
 	int ret;
@@ -578,7 +620,7 @@ fslmc_get_container_group(const char *group_name,
 
 		return -EINVAL;
 	}
-	ret = fslmc_get_group_id(group_name, groupid);
+	ret = fslmc_vfio_get_group_id(group_name, groupid);
 	if (ret)
 		return ret;
 
@@ -1246,9 +1288,9 @@ fslmc_vfio_setup_device(const char *dev_addr,
 			dev_addr);
 }
 
-static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
+static void *fslmc_vfio_map_mcp_obj(const char *mcp_obj)
 {
-	intptr_t v_addr = (intptr_t)MAP_FAILED;
+	void *v_addr = MAP_FAILED;
 	int32_t ret, mc_fd;
 	struct vfio_group_status status = { .argsz = sizeof(status) };
 
@@ -1264,7 +1306,7 @@ static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
 		goto MC_FAILURE;
 	}
 
-	v_addr = (size_t)mmap(NULL, reg_info.size,
+	v_addr = mmap(NULL, reg_info.size,
 		PROT_WRITE | PROT_READ, MAP_SHARED,
 		mc_fd, reg_info.offset);
 
@@ -1386,13 +1428,17 @@ rte_dpaa2_vfio_setup_intr(struct rte_intr_handle *intr_handle,
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
@@ -1430,11 +1476,11 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
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
@@ -1475,13 +1521,11 @@ fslmc_process_iodevices(struct rte_dpaa2_device *dev)
 	return 0;
 }
 
-static int
-fslmc_process_mcp(struct rte_dpaa2_device *dev)
+int
+fslmc_vfio_process_mcp(struct rte_dpaa2_device *dev)
 {
 	int ret;
-	intptr_t v_addr;
-	struct fsl_mc_io dpmng  = {0};
-	struct mc_version mc_ver_info = {0};
+	void *v_addr;
 
 	rte_mcp_ptr_list = malloc(sizeof(void *) * (MC_PORTAL_INDEX + 1));
 	if (!rte_mcp_ptr_list) {
@@ -1490,41 +1534,22 @@ fslmc_process_mcp(struct rte_dpaa2_device *dev)
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
-
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
 
@@ -1537,237 +1562,6 @@ fslmc_process_mcp(struct rte_dpaa2_device *dev)
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
@@ -1805,21 +1599,20 @@ fslmc_vfio_setup_group(void)
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
@@ -1830,7 +1623,7 @@ fslmc_vfio_setup_group(void)
 	}
 	if (ret) {
 		DPAA2_BUS_ERR("vfio group connect failed(%d)", ret);
-		fslmc_vfio_clear_group(vfio_group_fd);
+		fslmc_vfio_clear_group();
 		return ret;
 	}
 
@@ -1838,14 +1631,14 @@ fslmc_vfio_setup_group(void)
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
index c995fd67b8..5403459a8b 100644
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
 
@@ -9,40 +9,11 @@
 #define _FSLMC_VFIO_H_
 
 #include <rte_compat.h>
+#include <rte_vfio.h>
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
 
 __rte_internal
 int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index);
@@ -50,14 +21,9 @@ int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index);
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
index 20a454c3fc..841dc9c0c6 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- *   Copyright 2016,2021 NXP
+ *   Copyright 2016, 2021, 2026 NXP
  */
 
 #ifndef BUS_FSLMC_PRIVATE_H
@@ -9,6 +9,16 @@
 
 #include <bus_fslmc_driver.h>
 
-extern struct rte_bus rte_fslmc_bus;
+int fslmc_vfio_process_mcp(struct rte_dpaa2_device *dev);
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
-- 
2.43.0

