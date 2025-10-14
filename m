Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DC5CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:21:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40099406B4;
	Tue, 14 Oct 2025 09:20:19 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 689BB402AE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 08:00:49 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A27F1A1BC0;
 Tue, 14 Oct 2025 08:00:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 20BAF1A1BEF;
 Tue, 14 Oct 2025 08:00:49 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9906B1800091;
 Tue, 14 Oct 2025 14:00:48 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 09/15] net/dpaa2: setup the speed cap based on the actual MAC
Date: Tue, 14 Oct 2025 11:30:39 +0530
Message-ID: <20251014060045.1304694-10-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
References: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:20:04 +0200
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

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Previously, the speed_capa field from struct rte_eth_dev_info was
populated with all possible speeds that the MACs on the system could
sustain. What this meant is that the bitmap of speed capability did not
reflect what the MAC could do in the current circumstance.

Fix this by using the newly added MC command
dpni_get_mac_speed_capability() which returns a bitmap of
enum dpmac_link_speed. Since the MC API is a newly added one, we check
for the DPNI version to determine is we can use the API, if not the code
will fallback to the procedure used up until now.

Also, we interogate the MC firmware only at probe time to get the needed
into and then we store the information in the private structure to
use it any time .dev_infos_get() is called.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c    | 87 ++++++++++++++++++++++++++---
 drivers/net/dpaa2/dpaa2_ethdev.h    | 12 ++++
 drivers/net/dpaa2/mc/dpni.c         | 21 +++++++
 drivers/net/dpaa2/mc/fsl_dpmac.h    | 15 +++++
 drivers/net/dpaa2/mc/fsl_dpni.h     |  5 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h |  4 ++
 6 files changed, 134 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 5c4c0ae462..529856f704 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -290,6 +290,79 @@ dpaa2_fw_version_get(struct rte_eth_dev *dev,
 		return 0;
 }
 
+static uint32_t dpaa2_speed_to_rte_link_speed(enum dpmac_link_speed dpmac_speed)
+{
+	switch (dpmac_speed) {
+	case DPMAC_LINK_SPEED_10M:
+		return RTE_ETH_LINK_SPEED_10M;
+	case DPMAC_LINK_SPEED_100M:
+		return RTE_ETH_LINK_SPEED_100M;
+	case DPMAC_LINK_SPEED_1G:
+		return RTE_ETH_LINK_SPEED_1G;
+	case DPMAC_LINK_SPEED_2_5G:
+		return RTE_ETH_LINK_SPEED_2_5G;
+	case DPMAC_LINK_SPEED_5G:
+		return RTE_ETH_LINK_SPEED_5G;
+	case DPMAC_LINK_SPEED_10G:
+		return RTE_ETH_LINK_SPEED_10G;
+	case DPMAC_LINK_SPEED_25G:
+		return RTE_ETH_LINK_SPEED_25G;
+	case DPMAC_LINK_SPEED_40G:
+		return RTE_ETH_LINK_SPEED_40G;
+	case DPMAC_LINK_SPEED_50G:
+		return RTE_ETH_LINK_SPEED_50G;
+	case DPMAC_LINK_SPEED_100G:
+		return RTE_ETH_LINK_SPEED_100G;
+	default:
+		return 0;
+	}
+}
+
+static uint32_t dpaa2_dev_get_speed_capability(struct rte_eth_dev *dev)
+{
+	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	enum dpmac_link_speed speed;
+	uint32_t dpmac_speed_cap;
+	uint32_t speed_capa = 0;
+	int ret;
+
+	/* The dpni_get_mac_supported_eth_if() API is only available starting
+	 * with DPNI ver 8.6.
+	 */
+	if (dpaa2_dev_cmp_dpni_ver(priv, DPNI_GET_MAC_SUPPORTED_IFS_VER_MAJOR,
+				   DPNI_GET_MAC_SUPPORTED_IFS_VER_MINOR) < 0)
+		goto fallback;
+
+	if (priv->ep_dev_type != DPAA2_MAC)
+		goto fallback;
+
+	ret = dpni_get_mac_speed_capability(dpni, CMD_PRI_LOW, priv->token,
+					    &dpmac_speed_cap);
+	if (ret < 0) {
+		DPAA2_PMD_WARN("dpni_get_mac_speed_capability() failed with %d", ret);
+		goto fallback;
+	}
+	for (speed = DPMAC_LINK_SPEED_10M; speed < DPMAC_LINK_SPEED_MAX; speed++) {
+		if ((dpmac_speed_cap & (1 << speed)) == 0)
+			continue;
+
+		speed_capa |= dpaa2_speed_to_rte_link_speed(speed);
+	}
+
+	return speed_capa;
+
+fallback:
+	speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_2_5G |
+		RTE_ETH_LINK_SPEED_10G;
+
+	if (dpaa2_svr_family == SVR_LX2160A)
+		speed_capa |= RTE_ETH_LINK_SPEED_25G | RTE_ETH_LINK_SPEED_40G |
+			RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
+
+	return speed_capa;
+}
+
 static int
 dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	struct rte_eth_dev_info *dev_info)
@@ -307,9 +380,6 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 					dev_rx_offloads_nodis;
 	dev_info->tx_offload_capa = dev_tx_offloads_sup |
 					dev_tx_offloads_nodis;
-	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G |
-			RTE_ETH_LINK_SPEED_2_5G |
-			RTE_ETH_LINK_SPEED_10G;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	dev_info->max_hash_mac_addrs = 0;
@@ -326,12 +396,7 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->default_txportconf.ring_size = CONG_ENTER_TX_THRESHOLD;
 	dev_info->default_rxportconf.ring_size = DPAA2_RX_DEFAULT_NBDESC;
 
-	if (dpaa2_svr_family == SVR_LX2160A) {
-		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_25G |
-				RTE_ETH_LINK_SPEED_40G |
-				RTE_ETH_LINK_SPEED_50G |
-				RTE_ETH_LINK_SPEED_100G;
-	}
+	dev_info->speed_capa = priv->speed_capa;
 
 	return 0;
 }
@@ -1130,6 +1195,7 @@ dpaa2_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 		/*todo -= add more types */
 		RTE_PTYPE_L2_ETHER,
 		RTE_PTYPE_L3_IPV4,
+
 		RTE_PTYPE_L3_IPV4_EXT,
 		RTE_PTYPE_L3_IPV6,
 		RTE_PTYPE_L3_IPV6_EXT,
@@ -2976,6 +3042,9 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	DPAA2_PMD_INFO("%s: netdev created, connected to %s",
 		eth_dev->data->name, dpaa2_dev->ep_name);
 
+
+	priv->speed_capa = dpaa2_dev_get_speed_capability(eth_dev);
+
 	return 0;
 init_err:
 	dpaa2_dev_close(eth_dev);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 6026b378a7..c4133f604f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -400,6 +400,7 @@ struct dpaa2_dev_priv {
 
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
+	uint32_t speed_capa;
 
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
@@ -436,6 +437,17 @@ struct dpaa2_dev_priv {
 	LIST_HEAD(shaper_profiles, dpaa2_tm_shaper_profile) shaper_profiles;
 };
 
+#define DPNI_GET_MAC_SUPPORTED_IFS_VER_MAJOR	8
+#define DPNI_GET_MAC_SUPPORTED_IFS_VER_MINOR	6
+
+static inline int dpaa2_dev_cmp_dpni_ver(struct dpaa2_dev_priv *priv,
+					 uint16_t ver_major, uint16_t ver_minor)
+{
+	if (priv->dpni_ver_major == ver_major)
+		return priv->dpni_ver_minor - ver_minor;
+	return priv->dpni_ver_major - ver_major;
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index f651f29b02..a1f168dd04 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -3493,6 +3493,7 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 	/* send command to MC */
 	return mc_send_command(mc_io, &cmd);
 }
+
 /**
  * dpni_get_mac_statistics() - Get statistics on the connected DPMAC objects
  * @mc_io:       Pointer to opaque I/O object
@@ -3520,3 +3521,23 @@ int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+int dpni_get_mac_speed_capability(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+				  uint32_t *speed_cap)
+{
+	struct dpni_rsp_mac_speed_cap *rsp_params;
+	struct mc_command cmd = { 0 };
+	int err;
+
+	cmd.header = mc_encode_cmd_header(DPNI_CMDID_GET_MAC_SPEED_CAPABILITY,
+					  cmd_flags, token);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	rsp_params = (struct dpni_rsp_mac_speed_cap *)cmd.params;
+	*speed_cap = le32_to_cpu(rsp_params->speed_cap);
+
+	return 0;
+}
diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
index 375d646cfc..61d7573a4b 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -67,6 +67,21 @@ enum dpmac_eth_if {
 	DPMAC_ETH_IF_1000BASEX,
 	DPMAC_ETH_IF_USXGMII,
 };
+
+enum dpmac_link_speed {
+	DPMAC_LINK_SPEED_10M = 0,
+	DPMAC_LINK_SPEED_100M,
+	DPMAC_LINK_SPEED_1G,
+	DPMAC_LINK_SPEED_2_5G,
+	DPMAC_LINK_SPEED_5G,
+	DPMAC_LINK_SPEED_10G,
+	DPMAC_LINK_SPEED_25G,
+	DPMAC_LINK_SPEED_40G,
+	DPMAC_LINK_SPEED_50G,
+	DPMAC_LINK_SPEED_100G,
+	DPMAC_LINK_SPEED_MAX,
+};
+
 /*
  * @DPMAC_FEC_NONE: RS-FEC (enabled by default) is disabled
  * @DPMAC_FEC_RS: RS-FEC (Clause 91) mode configured
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 2f8125314c..8d28b8ce76 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #ifndef __FSL_DPNI_H
@@ -2017,4 +2017,7 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
 
+int dpni_get_mac_speed_capability(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+				  uint32_t *speed_cap);
+
 #endif /* __FSL_DPNI_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index f653f2c0e4..cf4558d540 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -132,6 +132,7 @@
 #define DPNI_CMDID_SET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x281)
 #define DPNI_CMDID_GET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x282)
 #define DPNI_CMDID_GET_MAC_STATISTICS			DPNI_CMD(0x283)
+#define DPNI_CMDID_GET_MAC_SPEED_CAPABILITY		DPNI_CMD(0x284)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPNI_MASK(field)	\
@@ -1031,5 +1032,8 @@ struct dpni_cmd_get_mac_statistics {
 	uint32_t num_cnt;
 };
 
+struct dpni_rsp_mac_speed_cap {
+	uint32_t speed_cap;
+};
 #pragma pack(pop)
 #endif /* _FSL_DPNI_CMD_H */
-- 
2.43.0

