Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDE606A31F
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:22:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98E4240B9D;
	Fri, 30 Oct 2026 06:20:47 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 72AF040A77
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:36 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B6AD1A00BC;
 Fri, 30 Oct 2026 06:20:36 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CFD081A00B3;
 Fri, 30 Oct 2026 06:20:35 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 754E81800224;
 Fri, 30 Oct 2026 13:20:34 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S3 13/14] drivers: bus/fslmc provide shared DPRTC RTC
 services
Date: Fri, 30 Oct 2026 10:50:15 +0530
Message-ID: <20261030052016.3301766-14-prashant.gupta_3@nxp.com>
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

Introduce shared DPRTC RTC services in the fslmc bus layer.

Move the DPRTC MC driver and object management code from the
DPAA2 Ethernet PMD into bus/fslmc. Add bus-level APIs for DPRTC
allocation, release, time read and time update operations.

The fslmc bus acquires a DPRTC handle during initialization and
exposes it through rte_fslmc_bus_info. DPAA2 PTP operations are
updated to use these bus services instead of managing a private
DPRTC instance.

This centralizes DPRTC ownership and enables RTC functionality
to be shared by FSLMC-based drivers.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h          |   1 +
 drivers/bus/fslmc/fslmc_bus.c                 |   7 +
 drivers/bus/fslmc/fslmc_vfio.c                |  10 ++
 drivers/{net/dpaa2 => bus/fslmc}/mc/dprtc.c   |   0
 .../{net/dpaa2 => bus/fslmc}/mc/fsl_dprtc.h   |   0
 .../dpaa2 => bus/fslmc}/mc/fsl_dprtc_cmd.h    |   0
 drivers/bus/fslmc/meson.build                 |   2 +
 drivers/bus/fslmc/portal/dpaa2_hw_dprtc.c     | 131 ++++++++++++++++++
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  18 +++
 drivers/bus/fslmc/private.h                   |   5 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |   1 +
 drivers/net/dpaa2/dpaa2_ethdev.h              |   1 +
 drivers/net/dpaa2/dpaa2_ptp.c                 |  96 +++----------
 drivers/net/dpaa2/meson.build                 |   1 -
 14 files changed, 192 insertions(+), 81 deletions(-)
 rename drivers/{net/dpaa2 => bus/fslmc}/mc/dprtc.c (100%)
 rename drivers/{net/dpaa2 => bus/fslmc}/mc/fsl_dprtc.h (100%)
 rename drivers/{net/dpaa2 => bus/fslmc}/mc/fsl_dprtc_cmd.h (100%)
 create mode 100644 drivers/bus/fslmc/portal/dpaa2_hw_dprtc.c

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 1cef0d7b4b..73d7f9abf1 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -90,6 +90,7 @@ enum rte_dpaa2_dev_type {
 };
 
 struct rte_fslmc_bus_info {
+	void *rtc_handle;
 	int sp_protocol;
 	uint64_t mc_rev;
 	uint32_t svr;
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index cb88333c68..477f765a67 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -640,6 +640,9 @@ fslmc_bus_process_iodevices(void)
 		}
 	}
 
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		fslmc_bus_info.rtc_handle = fslmc_vfio_get_rtc_handle();
+
 	return 0;
 }
 
@@ -710,6 +713,10 @@ fslmc_bus_close_group(void)
 {
 	struct rte_dpaa2_device *dev;
 
+	if (fslmc_bus_info.rtc_handle)
+		fslmc_vfio_put_rtc_handle(fslmc_bus_info.rtc_handle);
+	fslmc_bus_info.rtc_handle = NULL;
+
 	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus) {
 		if (dev->device.devargs &&
 		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 58e33c6866..40bcd51153 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1783,3 +1783,13 @@ fslmc_vfio_setup_group(void)
 
 	return 0;
 }
+
+void *fslmc_vfio_get_rtc_handle(void)
+{
+	return rte_dpaa2_alloc_dprtc_dev();
+}
+
+void fslmc_vfio_put_rtc_handle(void *rtc_handle)
+{
+	rte_dpaa2_free_dprtc_dev(rtc_handle);
+}
diff --git a/drivers/net/dpaa2/mc/dprtc.c b/drivers/bus/fslmc/mc/dprtc.c
similarity index 100%
rename from drivers/net/dpaa2/mc/dprtc.c
rename to drivers/bus/fslmc/mc/dprtc.c
diff --git a/drivers/net/dpaa2/mc/fsl_dprtc.h b/drivers/bus/fslmc/mc/fsl_dprtc.h
similarity index 100%
rename from drivers/net/dpaa2/mc/fsl_dprtc.h
rename to drivers/bus/fslmc/mc/fsl_dprtc.h
diff --git a/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h b/drivers/bus/fslmc/mc/fsl_dprtc_cmd.h
similarity index 100%
rename from drivers/net/dpaa2/mc/fsl_dprtc_cmd.h
rename to drivers/bus/fslmc/mc/fsl_dprtc_cmd.h
diff --git a/drivers/bus/fslmc/meson.build b/drivers/bus/fslmc/meson.build
index 50d9e91a37..67379432a0 100644
--- a/drivers/bus/fslmc/meson.build
+++ b/drivers/bus/fslmc/meson.build
@@ -19,12 +19,14 @@ sources = files(
         'mc/dpio.c',
         'mc/dpmng.c',
         'mc/dprc.c',
+        'mc/dprtc.c',
         'mc/mc_sys.c',
         'portal/dpaa2_hw_dpbp.c',
         'portal/dpaa2_hw_dpci.c',
         'portal/dpaa2_hw_dpcon.c',
         'portal/dpaa2_hw_dpio.c',
         'portal/dpaa2_hw_dprc.c',
+        'portal/dpaa2_hw_dprtc.c',
         'qbman/qbman_portal.c',
         'qbman/qbman_debug.c',
 )
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dprtc.c b/drivers/bus/fslmc/portal/dpaa2_hw_dprtc.c
new file mode 100644
index 0000000000..13c9385e45
--- /dev/null
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dprtc.c
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ *
+ *   Copyright 2026 NXP
+ *
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <errno.h>
+
+#include <eal_export.h>
+#include <rte_malloc.h>
+#include <dev_driver.h>
+
+#include "private.h"
+#include <fslmc_logs.h>
+#include <mc/fsl_dprtc.h>
+#include "portal/dpaa2_hw_pvt.h"
+
+TAILQ_HEAD(dprtc_dev_list, dpaa2_dprtc_dev);
+static struct dprtc_dev_list dprtc_dev_list
+	= TAILQ_HEAD_INITIALIZER(dprtc_dev_list); /*!< DPRTC device list */
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dprtc_dev)
+struct dpaa2_dprtc_dev *rte_dpaa2_alloc_dprtc_dev(void)
+{
+	struct dpaa2_dprtc_dev *dprtc_dev = NULL;
+	uint16_t expected;
+
+	/* Get DPCI dev handle from list using index */
+	TAILQ_FOREACH(dprtc_dev, &dprtc_dev_list, next) {
+		expected = 0;
+		if (rte_atomic_compare_exchange_strong_explicit(&dprtc_dev->in_use,
+				&expected, 1, rte_memory_order_acquire,
+				rte_memory_order_relaxed))
+			break;
+	}
+
+	return dprtc_dev;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_dprtc_set_time)
+int rte_dpaa2_dprtc_set_time(struct dpaa2_dprtc_dev *dprtc, uint64_t ns)
+{
+	int ret;
+
+	ret = dprtc_set_time(&dprtc->dprtc, CMD_PRI_LOW, dprtc->token, ns);
+	if (ret)
+		DPAA2_BUS_ERR("dprtc_set_time failed ret: %d", ret);
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_dprtc_get_time)
+int rte_dpaa2_dprtc_get_time(struct dpaa2_dprtc_dev *dprtc, uint64_t *ns)
+{
+	int ret;
+
+	ret = dprtc_get_time(&dprtc->dprtc, CMD_PRI_LOW, dprtc->token, ns);
+	if (ret)
+		DPAA2_BUS_ERR("dprtc_get_time failed ret: %d", ret);
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_free_dprtc_dev)
+void rte_dpaa2_free_dprtc_dev(struct dpaa2_dprtc_dev *dprtc)
+{
+	struct dpaa2_dprtc_dev *dprtc_dev = NULL;
+
+	/* Match DPCI handle and mark it free */
+	TAILQ_FOREACH(dprtc_dev, &dprtc_dev_list, next) {
+		if (dprtc_dev == dprtc) {
+			rte_atomic_store_explicit(&dprtc_dev->in_use, 0,
+				rte_memory_order_release);
+			return;
+		}
+	}
+}
+
+static int
+dpaa2_create_dprtc_device(int vdev_fd __rte_unused,
+	struct vfio_device_info *obj_info __rte_unused,
+	struct rte_dpaa2_device *obj)
+{
+	struct dpaa2_dprtc_dev *dprtc_dev;
+	struct dprtc_attr attr;
+	int ret = 0, dprtc_id = obj->object_id;
+
+	/* Allocate DPAA2 dprtc handle */
+	dprtc_dev = rte_zmalloc(NULL, sizeof(struct dpaa2_dprtc_dev), 0);
+	if (!dprtc_dev) {
+		DPAA2_BUS_ERR("Memory allocation failed for DPRTC Device");
+		return -ENOMEM;
+	}
+
+	/* Open the dprtc object */
+	dprtc_dev->dprtc.regs = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
+	ret = dprtc_open(&dprtc_dev->dprtc, CMD_PRI_LOW, dprtc_id,
+			&dprtc_dev->token);
+	if (ret) {
+		DPAA2_BUS_ERR("Unable to open dprtc object: err(%d)", ret);
+		goto init_err;
+	}
+
+	ret = dprtc_get_attributes(&dprtc_dev->dprtc, CMD_PRI_LOW,
+			dprtc_dev->token, &attr);
+	if (ret) {
+		DPAA2_BUS_ERR("Unable to get dprtc attr: err(%d)", ret);
+		goto init_err;
+	}
+
+	dprtc_dev->dprtc_id = dprtc_id;
+
+	TAILQ_INSERT_TAIL(&dprtc_dev_list, dprtc_dev, next);
+
+	return 0;
+
+init_err:
+	rte_free(dprtc_dev);
+
+	return ret;
+}
+
+static struct rte_dpaa2_object rte_dpaa2_dprtc_obj = {
+	.dev_type = DPAA2_DPRTC,
+	.create = dpaa2_create_dprtc_device,
+};
+
+RTE_PMD_REGISTER_DPAA2_OBJECT(dprtc, rte_dpaa2_dprtc_obj);
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 2250c8db6e..502cf5eeb5 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -284,6 +284,15 @@ struct dpaa2_dpcon_dev {
 	uint8_t channel_index;
 };
 
+struct dpaa2_dprtc_dev {
+	TAILQ_ENTRY(dpaa2_dprtc_dev) next;
+	struct fsl_mc_io dprtc;
+	uint16_t token;
+	uint32_t dprtc_id;
+
+	RTE_ATOMIC(uint16_t) in_use;
+};
+
 /* DPCON channel pool, shared by the net rx-interrupt path and the event PMD */
 __rte_internal
 struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void);
@@ -568,6 +577,15 @@ void dpaa2_free_dpbp_dev(struct dpaa2_dpbp_dev *dpbp);
 __rte_internal
 int dpaa2_dpbp_supported(void);
 
+__rte_internal
+struct dpaa2_dprtc_dev *rte_dpaa2_alloc_dprtc_dev(void);
+__rte_internal
+void rte_dpaa2_free_dprtc_dev(struct dpaa2_dprtc_dev *dprtc);
+__rte_internal
+int rte_dpaa2_dprtc_get_time(struct dpaa2_dprtc_dev *dprtc, uint64_t *ns);
+__rte_internal
+int rte_dpaa2_dprtc_set_time(struct dpaa2_dprtc_dev *dprtc, uint64_t ns);
+
 __rte_internal
 struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void);
 
diff --git a/drivers/bus/fslmc/private.h b/drivers/bus/fslmc/private.h
index 3586092529..44d1c1453a 100644
--- a/drivers/bus/fslmc/private.h
+++ b/drivers/bus/fslmc/private.h
@@ -18,8 +18,9 @@ void fslmc_vfio_close_iodevices(struct rte_dpaa2_device *dev);
 int fslmc_vfio_setup_group(void);
 void fslmc_vfio_clear_group(void);
 
+void *fslmc_vfio_get_rtc_handle(void);
+void fslmc_vfio_put_rtc_handle(void *rtc_handle);
+
 int fslmc_vfio_get_container_group(const char *group_name, int *gropuid);
 int fslmc_vfio_dmamap(void);
-
-
 #endif /* BUS_FSLMC_PRIVATE_H */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c842f1546d..68e70cdb45 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3601,6 +3601,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	priv->mc_rev = dpaa2_dev->bus_info->mc_rev;
+	priv->rtc_handle = dpaa2_dev->bus_info->rtc_handle;
 	priv->num_rx_tc = attr.num_rx_tcs;
 	priv->num_tx_tc = attr.num_tx_tcs;
 	priv->qos_entries = attr.qos_entries;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 7a58833ba1..573a23d00f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -499,6 +499,7 @@ struct dpaa2_dev_priv {
 	uint64_t *cnt_values_dma_mem;
 	uint64_t cnt_idx_iova, cnt_values_iova;
 	uint64_t mc_rev;
+	void *rtc_handle;
 
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 2863cad4dd..774fe58d77 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -17,19 +17,10 @@
 #include <rte_time.h>
 
 #include <bus_fslmc_driver.h>
-#include <fsl_dprtc.h>
-#include <fsl_dpkg.h>
 
 #include <dpaa2_ethdev.h>
 #include <dpaa2_pmd_logs.h>
 
-struct dpaa2_dprtc_dev {
-	struct fsl_mc_io dprtc;  /** handle to DPRTC portal object */
-	uint16_t token;
-	uint32_t dprtc_id; /*HW ID for DPRTC object */
-};
-static struct dpaa2_dprtc_dev *dprtc_dev;
-
 int dpaa2_timesync_enable(struct rte_eth_dev *dev __rte_unused)
 {
 	return 0;
@@ -41,15 +32,16 @@ int dpaa2_timesync_disable(struct rte_eth_dev *dev __rte_unused)
 }
 
 int dpaa2_timesync_read_time(struct rte_eth_dev *dev,
-					struct timespec *timestamp)
+	struct timespec *timestamp)
 {
 	uint64_t ns;
 	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	RTE_SET_USED(dev);
+	if (!priv->rtc_handle)
+		return -ENODEV;
 
-	ret = dprtc_get_time(&dprtc_dev->dprtc, CMD_PRI_LOW,
-			     dprtc_dev->token, &ns);
+	ret = rte_dpaa2_dprtc_get_time(priv->rtc_handle, &ns);
 	if (ret) {
 		DPAA2_PMD_ERR("dprtc_get_time failed ret: %d", ret);
 		return ret;
@@ -61,19 +53,19 @@ int dpaa2_timesync_read_time(struct rte_eth_dev *dev,
 }
 
 int dpaa2_timesync_write_time(struct rte_eth_dev *dev,
-					const struct timespec *ts)
+	const struct timespec *ts)
 {
 	uint64_t ns;
 	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	RTE_SET_USED(dev);
+	if (!priv->rtc_handle)
+		return -ENODEV;
 
 	ns = rte_timespec_to_ns(ts);
-
-	ret = dprtc_set_time(&dprtc_dev->dprtc, CMD_PRI_LOW,
-			     dprtc_dev->token, ns);
+	ret = rte_dpaa2_dprtc_set_time(priv->rtc_handle, ns);
 	if (ret) {
-		DPAA2_PMD_ERR("dprtc_set_time failed ret: %d", ret);
+		DPAA2_PMD_ERR("Failed(%d) to set rtc", ret);
 		return ret;
 	}
 
@@ -84,22 +76,22 @@ int dpaa2_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
 {
 	uint64_t ns;
 	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	RTE_SET_USED(dev);
+	if (!priv->rtc_handle)
+		return -ENODEV;
 
-	ret = dprtc_get_time(&dprtc_dev->dprtc, CMD_PRI_LOW,
-			     dprtc_dev->token, &ns);
+	ret = rte_dpaa2_dprtc_get_time(priv->rtc_handle, &ns);
 	if (ret) {
-		DPAA2_PMD_ERR("dprtc_get_time failed ret: %d", ret);
+		DPAA2_PMD_ERR("Failed(%d) to get rtc", ret);
 		return ret;
 	}
 
 	ns += delta;
 
-	ret = dprtc_set_time(&dprtc_dev->dprtc, CMD_PRI_LOW,
-			     dprtc_dev->token, ns);
+	ret = rte_dpaa2_dprtc_set_time(priv->rtc_handle, ns);
 	if (ret) {
-		DPAA2_PMD_ERR("dprtc_set_time failed ret: %d", ret);
+		DPAA2_PMD_ERR("Failed(%d) to set rtc", ret);
 		return ret;
 	}
 
@@ -130,55 +122,3 @@ int dpaa2_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
 	*timestamp = rte_ns_to_timespec(priv->rx_timestamp);
 	return 0;
 }
-
-#if defined(RTE_LIBRTE_IEEE1588)
-static int
-dpaa2_create_dprtc_device(int vdev_fd __rte_unused,
-	struct vfio_device_info *obj_info __rte_unused,
-	struct rte_dpaa2_device *obj)
-{
-	struct dprtc_attr attr;
-	int ret, dprtc_id = obj->object_id;
-
-	PMD_INIT_FUNC_TRACE();
-
-	/* Allocate DPAA2 dprtc handle */
-	dprtc_dev = rte_malloc(NULL, sizeof(struct dpaa2_dprtc_dev), 0);
-	if (!dprtc_dev) {
-		DPAA2_PMD_ERR("Memory allocation failed for DPRTC Device");
-		return -1;
-	}
-
-	/* Open the dprtc object */
-	dprtc_dev->dprtc.regs = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
-	ret = dprtc_open(&dprtc_dev->dprtc, CMD_PRI_LOW, dprtc_id,
-			  &dprtc_dev->token);
-	if (ret) {
-		DPAA2_PMD_ERR("Unable to open dprtc object: err(%d)", ret);
-		goto init_err;
-	}
-
-	ret = dprtc_get_attributes(&dprtc_dev->dprtc, CMD_PRI_LOW,
-				    dprtc_dev->token, &attr);
-	if (ret) {
-		DPAA2_PMD_ERR("Unable to get dprtc attr: err(%d)", ret);
-		goto init_err;
-	}
-
-	dprtc_dev->dprtc_id = dprtc_id;
-
-	return 0;
-
-init_err:
-	rte_free(dprtc_dev);
-
-	return -1;
-}
-
-static struct rte_dpaa2_object rte_dpaa2_dprtc_obj = {
-	.dev_type = DPAA2_DPRTC,
-	.create = dpaa2_create_dprtc_device,
-};
-
-RTE_PMD_REGISTER_DPAA2_OBJECT(dprtc, rte_dpaa2_dprtc_obj);
-#endif
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index b821f7bfad..61f68f6fec 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -17,7 +17,6 @@ sources = files(
         'dpaa2_recycle.c',
         'dpaa2_rxtx.c',
         'dpaa2_ptp.c',
-        'mc/dprtc.c',
         'mc/dpkg.c',
         'mc/dpdmux.c',
         'mc/dpni.c',
-- 
2.43.0

