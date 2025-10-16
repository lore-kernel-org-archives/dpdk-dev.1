Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFCBCCD1A1
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:29:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42E88427B8;
	Thu, 16 Oct 2025 12:28:23 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0365B41153
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DC1141A26D3;
 Thu, 16 Oct 2025 12:28:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E9D81A270D;
 Thu, 16 Oct 2025 12:28:11 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B0E461800079;
 Thu, 16 Oct 2025 18:28:10 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v2 09/15] net/dpaa2: support dpmac counters in stats
Date: Thu, 16 Oct 2025 15:57:59 +0530
Message-ID: <20251016102805.2453687-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

Add support of dpmac counters in xstats.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 doc/guides/rel_notes/release_25_11.rst |   3 +
 drivers/net/dpaa2/dpaa2_ethdev.c       | 138 +++++++++++++++++++++++--
 drivers/net/dpaa2/dpaa2_ethdev.h       |  14 ++-
 drivers/net/dpaa2/mc/dpni.c            |  29 +++++-
 drivers/net/dpaa2/mc/fsl_dpmac.h       |  48 ++++++++-
 drivers/net/dpaa2/mc/fsl_dpni.h        |   3 +
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h    |  11 +-
 7 files changed, 233 insertions(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c3b94e1896..ba73d7deb8 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -76,6 +76,9 @@ New Features
   * Added multi-process per port.
   * Optimized code.
 
+* **Updated DPAA2 ethernet driver.**
+
+  * Added additional MAC counters in xstats.
 
 Removed Items
 -------------
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 0fd577c448..5c4c0ae462 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1,7 +1,7 @@
 /* * SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2024 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
@@ -106,6 +106,52 @@ static const struct rte_dpaa2_xstats_name_off dpaa2_xstats_strings[] = {
 	{"egress_confirmed_frames", 2, 4},
 	{"cgr_reject_frames", 4, 0},
 	{"cgr_reject_bytes", 4, 1},
+	{"mac_rx_64 bytes", 0, 0},
+	{"mac_rx_65-127 bytes", 0, 0},
+	{"mac_rx_128-255 bytes", 0, 0},
+	{"mac_rx_256-511 bytes", 0, 0},
+	{"mac_rx_512-1023 bytes", 0, 0},
+	{"mac_rx_1024-1518 bytes", 0, 0},
+	{"mac_rx_1519-max bytes", 0, 0},
+	{"mac_rx_frags", 0, 0},
+	{"mac_rx_jabber", 0, 0},
+	{"mac_rx_frame discards", 0, 0},
+	{"mac_rx_align errors", 0, 0},
+	{"mac_tx_undersized", 0, 0},
+	{"mac_rx_oversized", 0, 0},
+	{"mac_rx_pause", 0, 0},
+	{"mac_tx_b-pause", 0, 0},
+	{"mac_rx_bytes", 0, 0},
+	{"mac_rx_m-cast", 0, 0},
+	{"mac_rx_b-cast", 0, 0},
+	{"mac_rx_all frames", 0, 0},
+	{"mac_rx_u-cast", 0, 0},
+	{"mac_rx_frame errors", 0, 0},
+	{"mac_tx_bytes", 0, 0},
+	{"mac_tx_m-cast", 0, 0},
+	{"mac_tx_b-cast", 0, 0},
+	{"mac_tx_u-cast", 0, 0},
+	{"mac_tx_frame errors", 0, 0},
+	{"mac_rx_frames ok", 0, 0},
+	{"mac_tx_frames ok", 0, 0},
+	{"mac_tx_64 bytes", 0, 0},
+	{"mac_tx_65-127 bytes", 0, 0},
+	{"mac_tx_128-255 bytes", 0, 0},
+	{"mac_tx_256-511 bytes", 0, 0},
+	{"mac_tx_512-1023 bytes", 0, 0},
+	{"mac_tx_1024-1518 bytes", 0, 0},
+	{"mac_tx_1519-max bytes", 0, 0},
+	{"mac_rx_all_bytes", 0, 0},
+	{"mac_rx_fcs_err", 0, 0},
+	{"mac_rx_vlan_frame", 0, 0},
+	{"mac_rx_undersized", 0, 0},
+	{"mac_rx_control_frame", 0, 0},
+	{"mac_rx_frame_discard_not_trunc", 0, 0},
+	{"mac_tx_all_bytes", 0, 0},
+	{"mac_tx_fcs_err", 0, 0},
+	{"mac_tx_vlan_frame", 0, 0},
+	{"mac_tx_all_frame", 0, 0},
+	{"mac_tx_control_frame", 0, 0},
 };
 
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
@@ -1680,16 +1726,67 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
 	return retcode;
 };
 
+void
+dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint32_t *cnt_idx;
+	int i;
+
+	priv->cnt_idx_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_INDEX_DMA_SIZE,
+					   RTE_CACHE_LINE_SIZE);
+	if (!priv->cnt_idx_dma_mem) {
+		DPAA2_PMD_ERR("Failure to allocate memory for mac index");
+		goto out;
+	}
+
+	priv->cnt_values_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_VALUE_DMA_SIZE,
+					      RTE_CACHE_LINE_SIZE);
+	if (!priv->cnt_values_dma_mem) {
+		DPAA2_PMD_ERR("Failure to allocate memory for mac values");
+		goto err_alloc_values;
+	}
+
+	cnt_idx = priv->cnt_idx_dma_mem;
+	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
+		*cnt_idx++ = rte_cpu_to_le_32((uint32_t)i);
+
+	priv->cnt_idx_iova = rte_mem_virt2iova(priv->cnt_idx_dma_mem);
+	if (priv->cnt_idx_iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("%s: No IOMMU map for count index dma mem(%p)",
+			__func__, priv->cnt_idx_dma_mem);
+		goto err_dma_map;
+	}
+
+	priv->cnt_values_iova = rte_mem_virt2iova(priv->cnt_values_dma_mem);
+	if (priv->cnt_values_iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("%s: No IOMMU map for count values dma mem(%p)",
+			__func__, priv->cnt_values_dma_mem);
+		goto err_dma_map;
+	}
+
+	return;
+
+err_dma_map:
+	rte_free(priv->cnt_values_dma_mem);
+err_alloc_values:
+	rte_free(priv->cnt_idx_dma_mem);
+out:
+	priv->cnt_idx_dma_mem = NULL;
+	priv->cnt_values_dma_mem = NULL;
+}
+
 static int
 dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	struct rte_eth_xstat *xstats, unsigned int n)
 {
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
-	int32_t retcode;
+	unsigned int i = 0, j = 0, num = RTE_DIM(dpaa2_xstats_strings);
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	union dpni_statistics value[5] = {};
-	unsigned int i = 0, num = RTE_DIM(dpaa2_xstats_strings);
 	uint8_t page_id, stats_id;
+	uint64_t *cnt_values;
+	int32_t retcode;
 
 	if (n < num)
 		return num;
@@ -1715,8 +1812,8 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 	if (retcode)
 		goto err;
 
-	for (i = 0; i < priv->max_cgs; i++) {
-		if (!priv->cgid_in_use[i]) {
+	for (j = 0; j < priv->max_cgs; j++) {
+		if (!priv->cgid_in_use[j]) {
 			/* Get Counters from page_4*/
 			retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
 						      priv->token,
@@ -1726,13 +1823,38 @@ dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
 			break;
 		}
 	}
-
-	for (i = 0; i < num; i++) {
+	while (i < (num - DPAA2_MAC_NUM_STATS)) {
 		xstats[i].id = i;
 		page_id = dpaa2_xstats_strings[i].page_id;
 		stats_id = dpaa2_xstats_strings[i].stats_id;
 		xstats[i].value = value[page_id].raw.counter[stats_id];
+		i++;
+	}
+
+	dpaa2_dev_mac_setup_stats(dev);
+	retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
+					  priv->cnt_idx_iova, priv->cnt_values_iova,
+					  DPAA2_MAC_NUM_STATS);
+	if (retcode) {
+		DPAA2_PMD_WARN("MAC (mac_*) counters are not supported!!");
+		rte_free(priv->cnt_values_dma_mem);
+		rte_free(priv->cnt_idx_dma_mem);
+		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+			xstats[i].id = i;
+			xstats[i].value = 0;
+			i++;
+		}
 	}
+	if (!retcode) {
+		cnt_values = priv->cnt_values_dma_mem;
+		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+			/* mac counters value */
+			xstats[i].id = i;
+			xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
+			i++;
+		}
+	}
+
 	return i;
 err:
 	DPAA2_PMD_ERR("Error in obtaining extended stats (%d)", retcode);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index ffc9ebadb8..6026b378a7 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2015-2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2022 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
@@ -18,6 +18,7 @@
 
 #include <mc/fsl_dpni.h>
 #include <mc/fsl_mc_sys.h>
+#include <mc/fsl_dpmac.h>
 
 #include "base/dpaa2_hw_dpni_annot.h"
 
@@ -133,6 +134,11 @@
 #define DPAA2_PKT_TYPE_VLAN_1		0x0160
 #define DPAA2_PKT_TYPE_VLAN_2		0x0260
 
+/* mac counters */
+#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
+#define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
+#define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
+
 /* Global pool used by driver for SG list TX */
 extern struct rte_mempool *dpaa2_tx_sg_pool;
 /* Maximum SG segments */
@@ -419,6 +425,10 @@ struct dpaa2_dev_priv {
 	uint8_t channel_inuse;
 	/* Stores correction offset for one step timestamping */
 	uint16_t ptp_correction_offset;
+	/* for mac counters */
+	uint32_t *cnt_idx_dma_mem;
+	uint64_t *cnt_values_dma_mem;
+	uint64_t cnt_idx_iova, cnt_values_iova;
 
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
@@ -504,4 +514,6 @@ int dpaa2_dev_recycle_qp_setup(struct rte_dpaa2_device *dpaa2_dev,
 	struct dpaa2_queue **txq,
 	struct dpaa2_queue **rxq);
 
+void
+dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev);
 #endif /* _DPAA2_ETHDEV_H */
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index 558f08dc69..f651f29b02 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -3493,3 +3493,30 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 	/* send command to MC */
 	return mc_send_command(mc_io, &cmd);
 }
+/**
+ * dpni_get_mac_statistics() - Get statistics on the connected DPMAC objects
+ * @mc_io:       Pointer to opaque I/O object
+ * @cmd_flags:   Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:       Token of DPMAC object
+ * @iova_cnt:    IOVA containing the requested MAC counters formatted as an
+ *               array of __le32 representing the dpmac_counter_id.
+ * @iova_values: IOVA containing the values for all the requested counters
+ *               formatted as an array of __le64.
+ * @num_cnt:     Number of counters requested
+ *
+ * Return:       '0' on Success; Error code otherwise.
+ */
+int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt)
+{
+	struct dpni_cmd_get_mac_statistics *cmd_params;
+	struct mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPNI_CMDID_GET_MAC_STATISTICS, cmd_flags, token);
+	cmd_params = (struct dpni_cmd_get_mac_statistics *)cmd.params;
+	cmd_params->iova_cnt = cpu_to_le64(iova_cnt);
+	cmd_params->iova_values = cpu_to_le64(iova_values);
+	cmd_params->num_cnt = cpu_to_le32(num_cnt);
+
+	return mc_send_command(mc_io, &cmd);
+}
diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
index 41eca47cfa..375d646cfc 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -409,6 +409,34 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ * larger (up to max frame length specified), good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ * frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ * bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ * but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ * truncated) due to internal errors of the MAC client. Occurs when a received
+ * FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ * packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts transmitted frames with a CRC-32 error except
+ * for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ * are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all transmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ * 0x8808) but not pause frames.
  */
 enum dpmac_counter {
 	DPMAC_CNT_ING_FRAME_64,
@@ -438,7 +466,25 @@ enum dpmac_counter {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io,
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index e2b18f7468..1a12ed3c3c 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -2037,4 +2037,7 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
 
+int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
+
 #endif /* __FSL_DPNI_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index 1152182e34..f653f2c0e4 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #ifndef _FSL_DPNI_CMD_H
@@ -9,7 +9,7 @@
 
 /* DPNI Version */
 #define DPNI_VER_MAJOR				8
-#define DPNI_VER_MINOR				4
+#define DPNI_VER_MINOR				6
 
 #define DPNI_CMD_BASE_VERSION			1
 #define DPNI_CMD_VERSION_2			2
@@ -131,6 +131,7 @@
 #define DPNI_CMDID_SP_ENABLE		    DPNI_CMD(0x280)
 #define DPNI_CMDID_SET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x281)
 #define DPNI_CMDID_GET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x282)
+#define DPNI_CMDID_GET_MAC_STATISTICS			DPNI_CMD(0x283)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPNI_MASK(field)	\
@@ -1024,5 +1025,11 @@ struct dpni_cmd_sp_enable {
 	uint8_t en;
 };
 
+struct dpni_cmd_get_mac_statistics {
+	uint64_t iova_cnt;
+	uint64_t iova_values;
+	uint32_t num_cnt;
+};
+
 #pragma pack(pop)
 #endif /* _FSL_DPNI_CMD_H */
-- 
2.43.0

