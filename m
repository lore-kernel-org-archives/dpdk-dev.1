Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D192CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7247C40E28;
	Thu, 15 Oct 2026 16:12:20 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id EE51840A6D
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:11:55 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D1A991A007D;
 Thu, 15 Oct 2026 16:11:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C8E01A00A9;
 Thu, 15 Oct 2026 16:11:55 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2022C1800068;
 Thu, 15 Oct 2026 22:11:55 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v26 23/26] net/dpaa: enhance VSP port support
Date: Thu, 15 Oct 2026 19:41:41 +0530
Message-Id: <20261015141144.3140281-24-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
References: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
 <20261015141144.3140281-1-hemant.agrawal@nxp.com>
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

Map fman_onic to OH_OFFLINE_PARSING in get_rx_port_type(), as the VSP
configuration already does; ONIC ports otherwise got the wrong port
type and FMC operations failed.

Replace the parallel vsp_handle[] and vsp_bpid[] arrays with one
struct dpaa_if_vsp per profile, holding the handle and the buffer pool
parameters it was configured with. The bpid and size are stored by
value rather than as a dpaa_bp_info pointer, because that pointer is
mempool private data freed by dpaa_mbuf_free_pool() while the port can
still be around; a later queue setup with a new pool would otherwise
read freed memory. This drops the bpid and size parameters of
dpaa_port_vsp_update() and leaves room for more than one external pool
per profile.

Bound the VSP ID in dpaa_eth_rx_queue_bp_check(), the first place
vsp[] is indexed: the ID comes from the FMC profiles and the DTS
vsp-window, so neither is guaranteed to fit the array.

Also handle the shared-MAC base profile in dpaa_port_vsp_update()
before any handle is freed, return -EINVAL instead of 0 for a port
with no profiles or a bad VSP ID, always reconfigure rather than
skipping when the BPID is unchanged, skip BMI stats and Rx disable for
ONIC ports in dev_stop() as dev_start() does, and clean up all
DPAA_VSP_PROFILE_MAX_NUM profiles, clearing bp_num so a later queue
setup cannot match a stale pool.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c |  46 +++++++++----
 drivers/net/dpaa/dpaa_ethdev.h |  13 +++-
 drivers/net/dpaa/dpaa_flow.c   | 122 ++++++++++++++++++---------------
 drivers/net/dpaa/dpaa_flow.h   |   7 +-
 4 files changed, 113 insertions(+), 75 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index cefeb2ce0f..947e224b93 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -505,7 +505,7 @@ static int dpaa_eth_dev_stop(struct rte_eth_dev *dev)
 	PMD_INIT_FUNC_TRACE();
 	dev->data->dev_started = 0;
 
-	if (!fif->is_shared_mac) {
+	if (!fif->is_shared_mac && fif->mac_type != fman_onic) {
 		fman_if_bmi_stats_disable(fif);
 		fman_if_disable_rx(fif);
 	}
@@ -594,7 +594,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 	if (fif->num_profiles) {
-		ret = dpaa_port_vsp_cleanup(dpaa_intf, fif);
+		ret = dpaa_port_vsp_cleanup(dpaa_intf);
 		if (ret) {
 			DPAA_PMD_WARN("%s: cleanup VSP failed(%d)",
 				dev->data->name, ret);
@@ -1102,11 +1102,20 @@ static inline int dpaa_eth_rx_queue_bp_check(struct rte_eth_dev *dev,
 			vsp_id = 0;
 	}
 
-	if (dpaa_intf->vsp_bpid[vsp_id] &&
-		bpid != dpaa_intf->vsp_bpid[vsp_id]) {
+	/* vsp_id originates from the FMC profile IDs, and base_profile_id from
+	 * the DTS vsp-window, so bound it against the array before indexing.
+	 */
+	if (vsp_id >= DPAA_VSP_PROFILE_MAX_NUM) {
+		DPAA_PMD_ERR("Invalid VSP ID(%d) >= max(%d)",
+			     vsp_id, DPAA_VSP_PROFILE_MAX_NUM);
+		return -EINVAL;
+	}
+
+	if (dpaa_intf->vsp[vsp_id].bp_num != 0 &&
+		bpid != dpaa_intf->vsp[vsp_id].bpid[0]) {
 		DPAA_PMD_ERR("Various MPs are assigned to RXQs with same VSP");
 
-		return -1;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1151,10 +1160,10 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			return -EINVAL;
 		}
 	} else {
-		if (dpaa_eth_rx_queue_bp_check(dev, rxq->vsp_id,
-			DPAA_MEMPOOL_TO_POOL_INFO(mp)->bpid)) {
-			return -EINVAL;
-		}
+		ret = dpaa_eth_rx_queue_bp_check(dev, rxq->vsp_id,
+				DPAA_MEMPOOL_TO_POOL_INFO(mp)->bpid);
+		if (ret)
+			return ret;
 	}
 
 	if (dpaa_intf->bp_info && dpaa_intf->bp_info->bp &&
@@ -1194,9 +1203,12 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		int8_t vsp_id = rxq->vsp_id;
 
 		if (vsp_id >= 0) {
-			ret = dpaa_port_vsp_update(dpaa_intf, fmc_q, vsp_id,
-					DPAA_MEMPOOL_TO_POOL_INFO(mp)->bpid,
-					fif, buffsz + RTE_PKTMBUF_HEADROOM);
+			dpaa_intf->vsp[vsp_id].bpid[0] =
+				DPAA_MEMPOOL_TO_POOL_INFO(mp)->bpid;
+			dpaa_intf->vsp[vsp_id].size[0] =
+				DPAA_MEMPOOL_TO_POOL_INFO(mp)->size;
+			dpaa_intf->vsp[vsp_id].bp_num = 1;
+			ret = dpaa_port_vsp_update(dpaa_intf, fmc_q, vsp_id, fif);
 			if (ret) {
 				DPAA_PMD_ERR("dpaa_port_vsp_update failed");
 				return ret;
@@ -1209,12 +1221,16 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 					     " to shared interface on DPDK.");
 				return -EINVAL;
 			}
-			dpaa_intf->vsp_bpid[fif->base_profile_id] =
+			dpaa_intf->vsp[fif->base_profile_id].bpid[0] =
 				DPAA_MEMPOOL_TO_POOL_INFO(mp)->bpid;
+			dpaa_intf->vsp[fif->base_profile_id].size[0] =
+				DPAA_MEMPOOL_TO_POOL_INFO(mp)->size;
+			dpaa_intf->vsp[fif->base_profile_id].bp_num = 1;
 		}
 	} else {
-		dpaa_intf->vsp_bpid[0] =
-			DPAA_MEMPOOL_TO_POOL_INFO(mp)->bpid;
+		dpaa_intf->vsp[0].bpid[0] = DPAA_MEMPOOL_TO_POOL_INFO(mp)->bpid;
+		dpaa_intf->vsp[0].size[0] = DPAA_MEMPOOL_TO_POOL_INFO(mp)->size;
+		dpaa_intf->vsp[0].bp_num = 1;
 	}
 
 	dpaa_intf->valid = 1;
diff --git a/drivers/net/dpaa/dpaa_ethdev.h b/drivers/net/dpaa/dpaa_ethdev.h
index 3cf5fba51d..47c8e2b086 100644
--- a/drivers/net/dpaa/dpaa_ethdev.h
+++ b/drivers/net/dpaa/dpaa_ethdev.h
@@ -116,6 +116,16 @@ enum {
 
 #define FMC_FILE "/tmp/fmc.bin"
 
+struct dpaa_if_vsp {
+	/* Copied from the mempool private data, which is freed with the
+	 * mempool while the port may still be around.
+	 */
+	uint32_t bpid[FMAN_PORT_MAX_EXT_POOLS_NUM];
+	uint32_t size[FMAN_PORT_MAX_EXT_POOLS_NUM];
+	uint8_t bp_num;
+	void *vsp_handle;
+};
+
 extern struct rte_mempool *dpaa_tx_sg_pool;
 
 /* PMD related logs */
@@ -162,8 +172,7 @@ struct dpaa_if {
 	 */
 	struct qman_fq *next_tx_conf_queue;
 
-	void *vsp_handle[DPAA_VSP_PROFILE_MAX_NUM];
-	uint32_t vsp_bpid[DPAA_VSP_PROFILE_MAX_NUM];
+	struct dpaa_if_vsp vsp[DPAA_VSP_PROFILE_MAX_NUM];
 };
 
 struct dpaa_if_stats {
diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index bfe294d21d..201a9ff8e2 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2019,2021-2025 NXP
+ * Copyright 2017-2019,2021-2026 NXP
  */
 
 /* System headers */
@@ -10,6 +10,7 @@
 
 #include <dpaa_ethdev.h>
 #include <dpaa_flow.h>
+#include <dpaa_mempool.h>
 #include <rte_dpaa_logs.h>
 #include <fmlib/fm_port_ext.h>
 #include <fmlib/fm_vsp_ext.h>
@@ -810,8 +811,7 @@ int dpaa_fm_config(struct rte_eth_dev *dev, uint64_t req_dist_set)
 
 	if (fif->num_profiles) {
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
-			dpaa_intf->rx_queues[i].vsp_id =
-				fm_default_vsp_id(fif);
+			dpaa_intf->rx_queues[i].vsp_id = fm_default_vsp_id(fif);
 
 		i = 0;
 	}
@@ -943,28 +943,23 @@ int dpaa_fm_term(void)
 }
 
 static int dpaa_port_vsp_configure(struct dpaa_if *dpaa_intf,
-		uint8_t vsp_id, t_handle fman_handle,
-		struct fman_if *fif, u32 mbuf_data_room_size)
+		uint8_t vsp_id, t_handle fman_handle, struct fman_if *fif)
 {
+	struct dpaa_if_vsp *vsp;
 	t_fm_vsp_params vsp_params;
 	t_fm_buffer_prefix_content buf_prefix_cont;
-	uint8_t idx = mac_idx[fif->mac_idx];
+	uint8_t idx = mac_idx[fif->mac_idx], i;
 	int ret;
-
-	if (vsp_id == fif->base_profile_id && fif->is_shared_mac) {
-		/* For shared interface, VSP of base
-		 * profile is default pool located in kernel.
-		 */
-		dpaa_intf->vsp_bpid[vsp_id] = 0;
-		return 0;
-	}
+	struct t_fm_ext_pools *pools;
 
 	if (vsp_id >= DPAA_VSP_PROFILE_MAX_NUM) {
-		DPAA_PMD_ERR("VSP ID %d exceeds MAX number %d",
+		DPAA_PMD_ERR("Invalid VSP ID(%d) >= max(%d)",
 			vsp_id, DPAA_VSP_PROFILE_MAX_NUM);
-		return -1;
+		return -EINVAL;
 	}
 
+	vsp = &dpaa_intf->vsp[vsp_id];
+
 	memset(&vsp_params, 0, sizeof(vsp_params));
 	vsp_params.h_fm = fman_handle;
 	vsp_params.relative_profile_id = vsp_id;
@@ -977,17 +972,21 @@ static int dpaa_port_vsp_configure(struct dpaa_if *dpaa_intf,
 	vsp_params.port_params.port_type = get_rx_port_type(fif);
 	if (vsp_params.port_params.port_type == e_FM_PORT_TYPE_DUMMY) {
 		DPAA_PMD_ERR("Mac type %d error", fif->mac_type);
-		return -1;
+		return -EINVAL;
 	}
 
-	vsp_params.ext_buf_pools.num_of_pools_used = 1;
-	vsp_params.ext_buf_pools.ext_buf_pool[0].id = dpaa_intf->vsp_bpid[vsp_id];
-	vsp_params.ext_buf_pools.ext_buf_pool[0].size = mbuf_data_room_size;
+	pools = &vsp_params.ext_buf_pools;
 
-	dpaa_intf->vsp_handle[vsp_id] = fm_vsp_config(&vsp_params);
-	if (!dpaa_intf->vsp_handle[vsp_id]) {
-		DPAA_PMD_ERR("fm_vsp_config error for profile %d", vsp_id);
-		return -EINVAL;
+	pools->num_of_pools_used = vsp->bp_num;
+	for (i = 0; i < vsp->bp_num; i++) {
+		pools->ext_buf_pool[i].id = vsp->bpid[i];
+		pools->ext_buf_pool[i].size = vsp->size[i];
+	}
+
+	vsp->vsp_handle = fm_vsp_config(&vsp_params);
+	if (!vsp->vsp_handle) {
+		DPAA_PMD_ERR("Configure VSP[%d] failed!", vsp_id);
+		return -EIO;
 	}
 
 	/* configure the application buffer (structure, size and
@@ -1005,19 +1004,18 @@ static int dpaa_port_vsp_configure(struct dpaa_if *dpaa_intf,
 	buf_prefix_cont.manip_ext_space =
 		RTE_PKTMBUF_HEADROOM - DPAA_MBUF_HW_ANNOTATION;
 
-	ret = fm_vsp_config_buffer_prefix_content(dpaa_intf->vsp_handle[vsp_id],
-					       &buf_prefix_cont);
+	ret = fm_vsp_config_buffer_prefix_content(vsp->vsp_handle,
+			&buf_prefix_cont);
 	if (ret != E_OK) {
-		DPAA_PMD_ERR("fm_vsp_config_buffer_prefix_content error for profile %d err: %d",
-			     vsp_id, ret);
+		DPAA_PMD_ERR("Configure VSP[%d]'s buffer prefix failed(%d)!",
+			vsp_id, ret);
 		return ret;
 	}
 
 	/* initialize the FM VSP module */
-	ret = fm_vsp_init(dpaa_intf->vsp_handle[vsp_id]);
+	ret = fm_vsp_init(vsp->vsp_handle);
 	if (ret != E_OK) {
-		DPAA_PMD_ERR("fm_vsp_init error for profile %d err:%d",
-			 vsp_id, ret);
+		DPAA_PMD_ERR("Init VSP[%d] failed(%d)!", vsp_id, ret);
 		return ret;
 	}
 
@@ -1025,29 +1023,44 @@ static int dpaa_port_vsp_configure(struct dpaa_if *dpaa_intf,
 }
 
 int dpaa_port_vsp_update(struct dpaa_if *dpaa_intf,
-		bool fmc_mode, uint8_t vsp_id, uint32_t bpid,
-		struct fman_if *fif, u32 mbuf_data_room_size)
+		bool fmc_mode, uint8_t vsp_id, struct fman_if *fif)
 {
 	int ret = 0;
 	t_handle fman_handle;
+	struct dpaa_if_vsp *vsp;
 
-	if (!fif->num_profiles)
-		return 0;
+	if (!fif->num_profiles) {
+		DPAA_PMD_ERR("%s: No multiple VSPs specified!",
+			dpaa_intf->name);
+		return -EINVAL;
+	}
 
-	if (vsp_id >= fif->num_profiles)
-		return 0;
+	if (vsp_id >= (fif->base_profile_id + fif->num_profiles)) {
+		DPAA_PMD_ERR("%s: Invalid VSP ID(%d) >= base(%d) + num(%d)",
+			dpaa_intf->name, vsp_id, fif->base_profile_id,
+			fif->num_profiles);
+		return -EINVAL;
+	}
 
-	if (dpaa_intf->vsp_bpid[vsp_id] == bpid)
+	if (vsp_id == fif->base_profile_id && fif->is_shared_mac) {
+		/* For shared interface, VSP of base
+		 * profile is default pool located in kernel.
+		 */
+		dpaa_intf->vsp[vsp_id].bp_num = 0;
+		dpaa_intf->vsp[vsp_id].vsp_handle = NULL;
 		return 0;
+	}
 
-	if (dpaa_intf->vsp_handle[vsp_id]) {
-		ret = fm_vsp_free(dpaa_intf->vsp_handle[vsp_id]);
+	vsp = &dpaa_intf->vsp[vsp_id];
+
+	if (vsp->vsp_handle) {
+		ret = fm_vsp_free(vsp->vsp_handle);
 		if (ret != E_OK) {
-			DPAA_PMD_ERR("Error fm_vsp_free: err %d vsp_handle[%d]",
-				     ret, vsp_id);
+			DPAA_PMD_ERR("Free VSP[%d]'s handle failed(%d)",
+				vsp_id, ret);
 			return ret;
 		}
-		dpaa_intf->vsp_handle[vsp_id] = 0;
+		vsp->vsp_handle = NULL;
 	}
 
 	if (fmc_mode)
@@ -1055,25 +1068,26 @@ int dpaa_port_vsp_update(struct dpaa_if *dpaa_intf,
 	else
 		fman_handle = fm_info.fman_handle;
 
-	dpaa_intf->vsp_bpid[vsp_id] = bpid;
-
-	return dpaa_port_vsp_configure(dpaa_intf, vsp_id, fman_handle, fif,
-				       mbuf_data_room_size);
+	return dpaa_port_vsp_configure(dpaa_intf, vsp_id, fman_handle, fif);
 }
 
-int dpaa_port_vsp_cleanup(struct dpaa_if *dpaa_intf, struct fman_if *fif)
+int dpaa_port_vsp_cleanup(struct dpaa_if *dpaa_intf)
 {
-	int idx, ret;
+	int ret;
+	uint8_t idx;
 
-	for (idx = 0; idx < (uint8_t)fif->num_profiles; idx++) {
-		if (dpaa_intf->vsp_handle[idx]) {
-			ret = fm_vsp_free(dpaa_intf->vsp_handle[idx]);
+	for (idx = 0; idx < DPAA_VSP_PROFILE_MAX_NUM; idx++) {
+		if (dpaa_intf->vsp[idx].vsp_handle) {
+			ret = fm_vsp_free(dpaa_intf->vsp[idx].vsp_handle);
 			if (ret != E_OK) {
-				DPAA_PMD_ERR("Error fm_vsp_free: err %d"
-					     " vsp_handle[%d]", ret, idx);
+				DPAA_PMD_ERR("Free VSP[%d] failed(%d)",
+					idx, ret);
 				return ret;
 			}
+			dpaa_intf->vsp[idx].vsp_handle = NULL;
 		}
+		/* Drop cached pool parameters too. */
+		dpaa_intf->vsp[idx].bp_num = 0;
 	}
 
 	return E_OK;
diff --git a/drivers/net/dpaa/dpaa_flow.h b/drivers/net/dpaa/dpaa_flow.h
index 4742b8dd0a..6a949d6dd4 100644
--- a/drivers/net/dpaa/dpaa_flow.h
+++ b/drivers/net/dpaa/dpaa_flow.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017,2019,2022 NXP
+ * Copyright 2017,2019,2022,2026 NXP
  */
 
 #ifndef __DPAA_FLOW_H__
@@ -11,9 +11,8 @@ int dpaa_fm_config(struct rte_eth_dev *dev, uint64_t req_dist_set);
 int dpaa_fm_deconfig(struct dpaa_if *dpaa_intf, struct fman_if *fif);
 void dpaa_write_fm_config_to_file(void);
 int dpaa_port_vsp_update(struct dpaa_if *dpaa_intf,
-	bool fmc_mode, uint8_t vsp_id, uint32_t bpid, struct fman_if *fif,
-	u32 mbuf_data_room_size);
-int dpaa_port_vsp_cleanup(struct dpaa_if *dpaa_intf, struct fman_if *fif);
+	bool fmc_mode, uint8_t vsp_id, struct fman_if *fif);
+int dpaa_port_vsp_cleanup(struct dpaa_if *dpaa_intf);
 int dpaa_port_fmc_init(struct fman_if *fif,
 		       uint32_t *fqids, int8_t *vspids, int max_nb_rxq);
 
-- 
2.25.1

