Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A5606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 791EC40E2A;
	Fri, 23 Oct 2026 15:44:30 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id CD09840E19
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:21 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A851D1A0047;
 Fri, 23 Oct 2026 15:44:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 70E451A003D;
 Fri, 23 Oct 2026 15:44:21 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6788F18000BF;
 Fri, 23 Oct 2026 21:44:20 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 27/65] net/dpaa2: support DCB Rx mode via rte_flow
Date: Fri, 23 Oct 2026 19:13:07 +0530
Message-ID: <20261023134346.37727-28-prashant.gupta_3@nxp.com>
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

Add DCB (Data Center Bridging) support to the DPAA2 PMD so that
applications requesting RTE_ETH_MQ_RX_DCB map VLAN PCP priorities
to receive TCs, and expose the per-port mapping through the
standard rte_eth_dev_get_dcb_info() API.

Reject QoS entries whose index collides with an already-installed
DCB flow slot with -ENODATA, so user-added QoS rules cannot silently
overwrite the DCB-generated ones.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 107 ++++++++++++++++++++++++++++---
 drivers/net/dpaa2/dpaa2_ethdev.h |   3 +
 drivers/net/dpaa2/dpaa2_flow.c   |   5 ++
 3 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 9f92789d4e..cca7aa0891 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -507,7 +507,7 @@ dpaa2_setup_table_miss_action(struct rte_eth_dev *eth_dev,
 }
 
 static int
-dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
+dpaa2_setup_flow_rss_dist(struct rte_eth_dev *eth_dev,
 	uint64_t req_dist_set, int tc_index)
 {
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
@@ -555,6 +555,49 @@ dpaa2_setup_flow_dist(struct rte_eth_dev *eth_dev,
 	return 0;
 }
 
+static int
+dpaa2_setup_flow_dcb_dist(struct rte_eth_dev *eth_dev,
+	uint8_t prio, uint8_t tc)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct rte_flow_attr attr;
+	struct rte_flow_action actions[2];
+	struct rte_flow_item_vlan vlan_item;
+	struct rte_flow_item_vlan vlan_mask;
+	struct rte_flow_item items[2];
+	struct rte_flow_action_jump action_jump;
+	struct rte_flow *qos_flow;
+
+	memset(&attr, 0, sizeof(struct rte_flow_attr));
+	attr.ingress = 1;
+
+	attr.group = priv->num_rx_tc;
+	attr.priority = prio;
+	memset(&vlan_item, 0, sizeof(struct rte_flow_item_vlan));
+	memset(&vlan_mask, 0, sizeof(struct rte_flow_item_vlan));
+	vlan_item.hdr.vlan_tci = rte_cpu_to_be_16(RTE_VLAN_TCI_MAKE(0, prio, 0));
+	vlan_mask.hdr.vlan_tci = rte_cpu_to_be_16(RTE_VLAN_PRI_MASK);
+	items[0].spec = &vlan_item;
+	items[0].mask = &vlan_mask;
+	items[0].type = RTE_FLOW_ITEM_TYPE_VLAN;
+	items[1].type = RTE_FLOW_ITEM_TYPE_END;
+
+	actions[0].type = RTE_FLOW_ACTION_TYPE_JUMP;
+	action_jump.group = tc;
+	actions[0].conf = &action_jump;
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	qos_flow = rte_flow_create(eth_dev->data->port_id,
+		&attr, items, actions, NULL);
+	if (!qos_flow) {
+		DPAA2_PMD_WARN("Failed to direct vlan with prio(%d) to tc%d", prio, tc);
+		return -EIO;
+	}
+	priv->dcb_flow[prio] = qos_flow;
+
+	return 0;
+}
+
 static int
 dpaa2_remove_flow_rss_dist(struct rte_eth_dev *eth_dev,
 	uint8_t tc_index)
@@ -1175,6 +1218,28 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 	}
 }
 
+static int
+dpaa2_dev_dcb_info(struct rte_eth_dev *dev,
+	struct rte_eth_dcb_info *dcb_info)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int i;
+
+	if (!priv->nb_dcb_tcs)
+		return -ENOTSUP;
+
+	memset(dcb_info, 0, sizeof(struct rte_eth_dcb_info));
+	dcb_info->nb_tcs = priv->nb_dcb_tcs;
+	rte_memcpy(dcb_info->prio_tc, priv->prio_dcb_tc,
+		sizeof(uint8_t) * RTE_ETH_DCB_NUM_USER_PRIORITIES);
+	for (i = 0; i < dcb_info->nb_tcs; i++) {
+		dcb_info->tc_queue.tc_rxq[0][i].base = priv->dist_queues * i;
+		dcb_info->tc_queue.tc_rxq[0][i].nb_queue = priv->dist_queues;
+	}
+
+	return 0;
+}
+
 static int
 dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 {
@@ -1187,7 +1252,7 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 	int rx_l4_csum_offload = false;
 	int tx_l3_csum_offload = false;
 	int tx_l4_csum_offload = false;
-	int ret, tc_index;
+	int ret, tc_index, nb_tcs;
 	uint32_t max_rx_pktlen;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1245,15 +1310,26 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 			ret, dev->data->name);
 	}
 
-	if (eth_conf->rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
+	if (eth_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
 		for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
-			ret = dpaa2_setup_flow_dist(dev,
-					eth_conf->rx_adv_conf.rss_conf.rss_hf,
-					tc_index);
+			ret = dpaa2_setup_flow_rss_dist(dev,
+				eth_conf->rx_adv_conf.rss_conf.rss_hf, tc_index);
 			if (ret) {
-				DPAA2_PMD_ERR(
-					"Unable to set flow distribution on tc%d."
-					"Check queue config", tc_index);
+				DPAA2_PMD_ERR("RSS dist on tc%d err(%d)", tc_index, ret);
+				return ret;
+			}
+		}
+	}
+
+	if ((eth_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_DCB) && priv->qos_entries) {
+		nb_tcs = eth_conf->rx_adv_conf.dcb_rx_conf.nb_tcs;
+		for (tc_index = 0; tc_index < nb_tcs; tc_index++) {
+			if (tc_index >= priv->num_rx_tc)
+				break;
+			ret = dpaa2_setup_flow_dcb_dist(dev,
+				eth_conf->rx_adv_conf.dcb_rx_conf.dcb_tc[tc_index], tc_index);
+			if (ret) {
+				DPAA2_PMD_ERR("DCB direct to tc%d err(%d)", tc_index, ret);
 				return ret;
 			}
 		}
@@ -1320,7 +1396,7 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 	 */
 	if (dpaa2_svr_family == SVR_LX2160A) {
 		ret = dpni_set_offload(dpni, CMD_PRI_LOW, priv->token,
-				       DPNI_FLCTYPE_HASH, true);
+				DPNI_FLCTYPE_HASH, true);
 		if (ret) {
 			DPAA2_PMD_ERR("Error setting FLCTYPE: Err = %d", ret);
 			return ret;
@@ -2282,6 +2358,8 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 
 	dpaa2_tm_deinit(dev);
 	dpaa2_flow_clean(dev, MAX_TCS, DPAA2_FLOW_ALL_TYPE);
+	/** No matter dcb flows are created or not, they are destroyed in flow clean.*/
+	memset(priv->dcb_flow, 0, sizeof(void *) * RTE_ETH_DCB_NUM_USER_PRIORITIES);
 	/* Clean the device first */
 	ret = dpni_reset(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
@@ -3725,6 +3803,7 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.txq_info_get	      = dpaa2_txq_info_get,
 	.tm_ops_get	      = dpaa2_tm_ops_get,
 	.mtr_ops_get = dpaa2_mtr_ops_get,
+	.get_dcb_info = dpaa2_dev_dcb_info,
 	.timesync_enable      = dpaa2_timesync_enable,
 	.timesync_disable     = dpaa2_timesync_disable,
 	.timesync_read_time   = dpaa2_timesync_read_time,
@@ -4054,6 +4133,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		tbl_profile->entry_map_size = entry_num / 8 + 1;
 	}
 
+	for (i = 0; i < priv->num_rx_tc; i++) {
+		if (i >= RTE_ETH_DCB_NUM_USER_PRIORITIES)
+			break;
+		if (i >= priv->qos_entries)
+			break;
+		priv->prio_dcb_tc[i] = i;
+	}
+	priv->nb_dcb_tcs = i;
 	ret = dpni_set_max_frame_length(dpni_dev, CMD_PRI_LOW, priv->token,
 		RTE_ETHER_MAX_LEN - RTE_ETHER_CRC_LEN + VLAN_TAG_SIZE);
 	if (ret) {
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 0ad237a5cc..9ef6ee0e8c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -436,6 +436,9 @@ struct dpaa2_dev_priv {
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
 
 	struct dpaa2_flow_profile flow_profile;
+	uint8_t nb_dcb_tcs;
+	uint8_t prio_dcb_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES];
+	void *dcb_flow[RTE_ETH_DCB_NUM_USER_PRIORITIES];
 
 	uint16_t ss_offset;
 	uint64_t ss_iova;
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 920e9edc51..d9f7391faf 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -3228,6 +3228,11 @@ dpaa2_flow_get_flow_index(struct dpaa2_dev_priv *priv,
 			DPAA2_PMD_ERR("QoS flow index(%d) >= max(%d)", idx, priv->qos_entries);
 			return -ENOSPC;
 		}
+
+		if (idx < RTE_ETH_DCB_NUM_USER_PRIORITIES && priv->dcb_flow[idx]) {
+			DPAA2_PMD_ERR("QoS flow[%d] added conflicts with dcb flow", idx);
+			return -ENODATA;
+		}
 	} else {
 		if (attr->priority >= priv->fs_entries) {
 			DPAA2_PMD_ERR("FS[%d].entry(%d) >= max(%d)",
-- 
2.43.0

