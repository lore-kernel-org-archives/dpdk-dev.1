Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B07C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 11:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E30B240609;
	Tue,  1 Jul 2025 13:37:11 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D47A140269
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:37:09 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7D6520329E;
 Tue,  1 Jul 2025 13:37:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DE6720329A;
 Tue,  1 Jul 2025 13:37:09 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D7F751800078;
 Tue,  1 Jul 2025 19:37:08 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [v5 2/9] bus/dpaa: enhance DPAA SoC version
Date: Tue,  1 Jul 2025 17:07:00 +0530
Message-Id: <20250701113707.2793004-3-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701113707.2793004-1-vanshika.shukla@nxp.com>
References: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-1-vanshika.shukla@nxp.com>
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

Provide internal API to identify DPAA1 SoC version instead of accessing
global variable directly.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c |  9 +++---
 drivers/bus/dpaa/bus_dpaa_driver.h |  9 +++---
 drivers/bus/dpaa/dpaa_bus.c        | 48 ++++++++++++++++++++++--------
 drivers/net/dpaa/dpaa_ethdev.c     | 29 +++++-------------
 drivers/net/dpaa/dpaa_rxtx.c       |  4 +--
 5 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 11fabcaff5..fbce0638b7 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017,2019-2024 NXP
+ * Copyright 2017,2019-2025 NXP
  *
  */
 
@@ -520,11 +520,12 @@ qman_init_portal(struct qman_portal *portal,
 	if (!c)
 		c = portal->config;
 
-	if (dpaa_svr_family == SVR_LS1043A_FAMILY)
+	if (dpaa_soc_ver() == SVR_LS1043A_FAMILY) {
 		portal->use_eqcr_ci_stashing = 3;
-	else
+	} else {
 		portal->use_eqcr_ci_stashing =
-					((qman_ip_rev >= QMAN_REV30) ? 1 : 0);
+			(qman_ip_rev >= QMAN_REV30 ? 1 : 0);
+	}
 
 	/*
 	 * prep the low-level portal struct with the mapped addresses from the
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 325071dc0f..976f356699 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017-2022 NXP
+ *   Copyright 2017-2022, 2025 NXP
  *
  */
 #ifndef BUS_DPAA_DRIVER_H
@@ -55,11 +55,9 @@ dpaa_seqn(struct rte_mbuf *mbuf)
 /* DPAA SoC identifier; If this is not available, it can be concluded
  * that board is non-DPAA. Single slot is currently supported.
  */
-#define DPAA_SOC_ID_FILE	"/sys/devices/soc0/soc_id"
 
 #define SVR_LS1043A_FAMILY	0x87920000
 #define SVR_LS1046A_FAMILY	0x87070000
-#define SVR_MASK		0xffff0000
 
 /** Device driver supports link state interrupt */
 #define RTE_DPAA_DRV_INTR_LSC  0x0008
@@ -70,8 +68,6 @@ dpaa_seqn(struct rte_mbuf *mbuf)
 #define RTE_DEV_TO_DPAA_CONST(ptr) \
 	container_of(ptr, const struct rte_dpaa_device, device)
 
-extern unsigned int dpaa_svr_family;
-
 struct rte_dpaa_device;
 struct rte_dpaa_driver;
 
@@ -250,6 +246,9 @@ RTE_PMD_EXPORT_NAME(nm)
 __rte_internal
 struct fm_eth_port_cfg *dpaa_get_eth_port_cfg(int dev_id);
 
+__rte_internal
+uint32_t dpaa_soc_ver(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 620a5c33ed..d4f3dc3586 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2017-2020 NXP
+ * Copyright 2017-2025 NXP
  *
  */
 /* System headers */
@@ -46,12 +46,16 @@
 #include <netcfg.h>
 #include <fman.h>
 
+#define DPAA_SOC_ID_FILE	"/sys/devices/soc0/soc_id"
+#define DPAA_SVR_MASK 0xffff0000
+
 struct rte_dpaa_bus {
 	struct rte_bus bus;
 	TAILQ_HEAD(, rte_dpaa_device) device_list;
 	TAILQ_HEAD(, rte_dpaa_driver) driver_list;
 	int device_count;
 	int detected;
+	uint32_t svr_ver;
 };
 
 static struct rte_dpaa_bus rte_dpaa_bus;
@@ -60,9 +64,6 @@ static struct netcfg_info *dpaa_netcfg;
 /* define a variable to hold the portal_key, once created.*/
 static pthread_key_t dpaa_portal_key;
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_svr_family)
-unsigned int dpaa_svr_family;
-
 #define FSL_DPAA_BUS_NAME	dpaa_bus
 
 RTE_EXPORT_INTERNAL_SYMBOL(per_lcore_dpaa_io)
@@ -73,6 +74,13 @@ RTE_EXPORT_INTERNAL_SYMBOL(dpaa_seqn_dynfield_offset)
 int dpaa_seqn_dynfield_offset = -1;
 
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_eth_port_cfg)
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_soc_ver)
+uint32_t dpaa_soc_ver(void)
+{
+	return rte_dpaa_bus.svr_ver;
+}
+
 struct fm_eth_port_cfg *
 dpaa_get_eth_port_cfg(int dev_id)
 {
@@ -663,7 +671,7 @@ rte_dpaa_bus_probe(void)
 	struct rte_dpaa_device *dev;
 	struct rte_dpaa_driver *drv;
 	FILE *svr_file = NULL;
-	unsigned int svr_ver;
+	uint32_t svr_ver;
 	int probe_all = rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST;
 	static int process_once;
 
@@ -671,6 +679,29 @@ rte_dpaa_bus_probe(void)
 	if (!rte_dpaa_bus.detected)
 		return 0;
 
+	if (rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST)
+		probe_all = true;
+
+	svr_file = fopen(DPAA_SOC_ID_FILE, "r");
+	if (svr_file) {
+		if (fscanf(svr_file, "svr:%x", &svr_ver) > 0)
+			rte_dpaa_bus.svr_ver = svr_ver & DPAA_SVR_MASK;
+		else
+			rte_dpaa_bus.svr_ver = 0;
+		fclose(svr_file);
+	} else {
+		rte_dpaa_bus.svr_ver = 0;
+	}
+	if (rte_dpaa_bus.svr_ver == SVR_LS1046A_FAMILY) {
+		DPAA_BUS_LOG(INFO, "This is LS1046A family SoC.");
+	} else if (rte_dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
+		DPAA_BUS_LOG(INFO, "This is LS1043A family SoC.");
+	} else {
+		DPAA_BUS_LOG(WARNING,
+			"This is Unknown(%08x) DPAA1 family SoC.",
+			rte_dpaa_bus.svr_ver);
+	}
+
 	/* Device list creation is only done once */
 	if (!process_once) {
 		rte_dpaa_bus_dev_build();
@@ -699,13 +730,6 @@ rte_dpaa_bus_probe(void)
 	 */
 	rte_mbuf_set_platform_mempool_ops(DPAA_MEMPOOL_OPS_NAME);
 
-	svr_file = fopen(DPAA_SOC_ID_FILE, "r");
-	if (svr_file) {
-		if (fscanf(svr_file, "svr:%x", &svr_ver) > 0)
-			dpaa_svr_family = svr_ver & SVR_MASK;
-		fclose(svr_file);
-	}
-
 	TAILQ_FOREACH(dev, &rte_dpaa_bus.device_list, next) {
 		if (dev->device_type == FSL_DPAA_ETH) {
 			ret = rte_dpaa_setup_intr(dev->intr_handle);
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 66d62485af..7d0f830204 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2017-2020,2022-2024 NXP
+ *   Copyright 2017-2020,2022-2025 NXP
  *
  */
 /* System headers */
@@ -173,7 +173,7 @@ dpaa_poll_queue_default_config(struct qm_mcc_initfq *opts)
 	opts->fqd.fq_ctrl = QM_FQCTRL_AVOIDBLOCK | QM_FQCTRL_CTXASTASHING |
 			   QM_FQCTRL_PREFERINCACHE;
 	opts->fqd.context_a.stashing.exclusive = 0;
-	if (dpaa_svr_family != SVR_LS1046A_FAMILY)
+	if (dpaa_soc_ver() != SVR_LS1046A_FAMILY)
 		opts->fqd.context_a.stashing.annotation_cl =
 						DPAA_IF_RX_ANNOTATION_STASH;
 	opts->fqd.context_a.stashing.data_cl = DPAA_IF_RX_DATA_STASH;
@@ -594,30 +594,15 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 
 static int
 dpaa_fw_version_get(struct rte_eth_dev *dev,
-		     char *fw_version,
-		     size_t fw_size)
+	char *fw_version, size_t fw_size)
 {
 	struct fman_if *fif = dev->process_private;
 	int ret;
-	FILE *svr_file = NULL;
-	unsigned int svr_ver = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
-	svr_file = fopen(DPAA_SOC_ID_FILE, "r");
-	if (!svr_file) {
-		DPAA_PMD_ERR("Unable to open SoC device");
-		return -ENOTSUP; /* Not supported on this infra */
-	}
-	if (fscanf(svr_file, "svr:%x", &svr_ver) > 0)
-		dpaa_svr_family = svr_ver & SVR_MASK;
-	else
-		DPAA_PMD_ERR("Unable to read SoC device");
-
-	fclose(svr_file);
-
 	ret = snprintf(fw_version, fw_size, "SVR:%x-fman-v%x",
-		       svr_ver, fif->fman->ip_rev);
+			dpaa_soc_ver(), fif->fman->ip_rev);
 	if (ret < 0)
 		return -EINVAL;
 
@@ -1190,7 +1175,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		/* In multicore scenario stashing becomes a bottleneck on LS1046.
 		 * So do not enable stashing in this case
 		 */
-		if (dpaa_svr_family != SVR_LS1046A_FAMILY)
+		if (dpaa_soc_ver() != SVR_LS1046A_FAMILY)
 			opts.fqd.context_a.stashing.annotation_cl =
 						DPAA_IF_RX_ANNOTATION_STASH;
 		opts.fqd.context_a.stashing.data_cl = DPAA_IF_RX_DATA_STASH;
@@ -1218,7 +1203,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 				"ret:%d(%s)", rxq->fqid, ret, strerror(ret));
 			return ret;
 		}
-		if (dpaa_svr_family == SVR_LS1043A_FAMILY) {
+		if (dpaa_soc_ver() == SVR_LS1043A_FAMILY) {
 			rxq->cb.dqrr_dpdk_pull_cb = dpaa_rx_cb_no_prefetch;
 		} else {
 			rxq->cb.dqrr_dpdk_pull_cb = dpaa_rx_cb;
@@ -2520,7 +2505,7 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 		}
 
 		/* disabling the default push mode for LS1043 */
-		if (dpaa_svr_family == SVR_LS1043A_FAMILY)
+		if (dpaa_soc_ver() == SVR_LS1043A_FAMILY)
 			dpaa_push_mode_max_queue = 0;
 
 		/* if push mode queues to be enabled. Currently we are allowing
diff --git a/drivers/net/dpaa/dpaa_rxtx.c b/drivers/net/dpaa/dpaa_rxtx.c
index 05bd73becf..4dca63ea7e 100644
--- a/drivers/net/dpaa/dpaa_rxtx.c
+++ b/drivers/net/dpaa/dpaa_rxtx.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2017,2019-2024 NXP
+ *   Copyright 2017,2019-2025 NXP
  *
  */
 
@@ -1268,7 +1268,7 @@ dpaa_eth_ls1043a_mbuf_realloc(struct rte_mbuf *mbuf)
 {
 	uint64_t len, offset;
 
-	if (dpaa_svr_family != SVR_LS1043A_FAMILY)
+	if (dpaa_soc_ver() != SVR_LS1043A_FAMILY)
 		return 0;
 
 	while (mbuf) {
-- 
2.25.1

