Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C301606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7D3C42796;
	Fri, 23 Oct 2026 15:44:58 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6CF154113C
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:46 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50B78200034;
 Fri, 23 Oct 2026 15:44:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1CC82200031;
 Fri, 23 Oct 2026 15:44:46 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B34F1800068;
 Fri, 23 Oct 2026 21:44:44 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 50/65] net/dpaa2: add APIs to query device info and set
 default action
Date: Fri, 23 Oct 2026 19:13:30 +0530
Message-ID: <20261023134346.37727-51-prashant.gupta_3@nxp.com>
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

Add experimental dpaa2 PMD APIs so applications can discover the
device's classification resources and program the default (table-miss)
action for the QoS and flow-steering tables.

- rte_pmd_dpaa2_dev_info_get(): return the generic rte_eth_dev_info
  plus dpaa2-specific resource counts (rx_tc_num, tx_tc_num,
  qos_entries, fs_entries, dist_queues) via struct
  rte_pmd_dpaa2_dev_info.

- rte_pmd_dpaa2_rx_queue_info_get(): return the generic rte_eth_rxq_info
  plus the queue's tc_id and flow_id via struct rte_pmd_dpaa2_rxq_info,
  so applications can map a queue to its TC/flow.

- rte_pmd_dpaa2_dev_configure_default_action(): set the per-TC default
  flow (or drop) for the FS tables and the default TC (or drop) for the
  QoS table via struct rte_pmd_dpaa2_default_action_conf, re-applying
  the table miss action for each affected table.

New symbols are exported as experimental.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c  | 104 ++++++++++++++++++++++++++++++
 drivers/net/dpaa2/rte_pmd_dpaa2.h |  36 +++++++++++
 2 files changed, 140 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 572fcca91a..f00f906040 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1236,6 +1236,61 @@ dpaa2_dev_dcb_info(struct rte_eth_dev *dev,
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_dev_configure_default_action, 26.11)
+int
+rte_pmd_dpaa2_dev_configure_default_action(uint16_t port_id,
+	struct rte_pmd_dpaa2_default_action_conf *def_act_conf)
+{
+	int ret;
+	struct rte_eth_dev *dev;
+	struct dpaa2_dev_priv *priv;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	uint16_t base, tc_index, default_flow;
+
+	if (!rte_pmd_dpaa2_dev_is_dpaa2(port_id))
+		return -EINVAL;
+
+	dev = &rte_eth_devices[port_id];
+	priv = dev->data->dev_private;
+
+	for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
+		tbl_profile = &priv->flow_profile.tc_profile[tc_index];
+		base = priv->dist_queues * tc_index;
+		if (tc_index >= def_act_conf->max_tc)
+			break;
+		default_flow = def_act_conf->default_flows[tc_index];
+		if (default_flow >= priv->dist_queues) {
+			tbl_profile->default_drop = true;
+		} else {
+			tbl_profile->default_drop = false;
+			tbl_profile->default_queue.index = base + default_flow;
+		}
+		if (priv->fs_entries) {
+			ret = dpaa2_setup_table_miss_action(dev, tc_index);
+			if (ret) {
+				DPAA2_PMD_ERR("Error(%d) to set miss action of %s-tc%d table",
+					ret, dev->data->name, tc_index);
+				return ret;
+			}
+		}
+	}
+
+	tbl_profile = &priv->flow_profile.qos_profile;
+	if (def_act_conf->default_tc >= priv->num_rx_tc) {
+		tbl_profile->default_drop = true;
+	} else {
+		tbl_profile->default_drop = false;
+		tbl_profile->default_jump.group = def_act_conf->default_tc;
+	}
+	ret = dpaa2_setup_table_miss_action(dev, priv->num_rx_tc);
+	if (ret) {
+		DPAA2_PMD_ERR("Error(%d) to set miss action of %s-QoS table",
+			ret, dev->data->name);
+	}
+
+	return ret;
+}
+
 static int
 dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 {
@@ -4300,6 +4355,55 @@ rte_pmd_dpaa2_ep_name(uint32_t eth_id)
 	return priv->ep_name;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_rx_queue_info_get, 25.11)
+int
+rte_pmd_dpaa2_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
+	struct rte_pmd_dpaa2_rxq_info *qinfo)
+{
+	int ret;
+	struct rte_eth_dev *dev;
+	struct dpaa2_queue *rxq;
+
+	if (!rte_pmd_dpaa2_dev_is_dpaa2(port_id))
+		return -EINVAL;
+
+	ret = rte_eth_rx_queue_info_get(port_id, queue_id, &qinfo->rxq_info);
+	if (ret)
+		return ret;
+	dev = &rte_eth_devices[port_id];
+	rxq = dev->data->rx_queues[queue_id];
+	qinfo->tc_id = rxq->tc_index;
+	qinfo->flow_id = rxq->flow_id;
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_dev_info_get, 25.11)
+int
+rte_pmd_dpaa2_dev_info_get(uint16_t port_id,
+	struct rte_pmd_dpaa2_dev_info *dev_info)
+{
+	int ret;
+	struct rte_eth_dev *dev;
+	struct dpaa2_dev_priv *priv;
+
+	if (!rte_pmd_dpaa2_dev_is_dpaa2(port_id))
+		return -EINVAL;
+
+	ret = rte_eth_dev_info_get(port_id, &dev_info->dev_info);
+	if (ret)
+		return ret;
+	dev = &rte_eth_devices[port_id];
+	priv = dev->data->dev_private;
+	dev_info->rx_tc_num = priv->num_rx_tc;
+	dev_info->tx_tc_num = priv->num_tx_tc;
+	dev_info->qos_entries = priv->qos_entries;
+	dev_info->fs_entries = priv->fs_entries;
+	dev_info->dist_queues = priv->dist_queues;
+
+	return 0;
+}
+
 static int
 rte_dpaa2_probe(struct rte_dpaa2_driver *dpaa2_drv,
 		struct rte_dpaa2_device *dpaa2_dev)
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index 74b7e63c54..5a61a952bf 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -167,6 +167,42 @@ uint16_t
 rte_dpaa2_dev_tx_multi_ports(uint16_t port_id[],
 	uint16_t txq_id[], struct rte_mbuf **bufs, uint16_t nb_pkts);
 
+struct rte_pmd_dpaa2_rxq_info {
+	struct rte_eth_rxq_info rxq_info;
+	uint8_t tc_id;
+	uint16_t flow_id;
+};
+
+__rte_experimental
+int
+rte_pmd_dpaa2_rx_queue_info_get(uint16_t port_id, uint16_t queue_id,
+	struct rte_pmd_dpaa2_rxq_info *qinfo);
+
+struct rte_pmd_dpaa2_dev_info {
+	struct rte_eth_dev_info dev_info;
+	uint8_t rx_tc_num;
+	uint8_t tx_tc_num;
+	uint16_t qos_entries;
+	uint16_t fs_entries;
+	uint16_t dist_queues;
+};
+
+__rte_experimental
+int
+rte_pmd_dpaa2_dev_info_get(uint16_t port_id,
+	struct rte_pmd_dpaa2_dev_info *dev_info);
+
+struct rte_pmd_dpaa2_default_action_conf {
+	uint8_t default_tc;
+	uint8_t max_tc;
+	uint16_t default_flows[];
+};
+
+__rte_experimental
+int
+rte_pmd_dpaa2_dev_configure_default_action(uint16_t port_id,
+	struct rte_pmd_dpaa2_default_action_conf *def_act_conf);
+
 #define RTE_DPAA2_EVENT_PORT_CFG_ATOMIC RTE_BIT32(31)
 
 /** RTE_DPAA2_MIX_GROUP_FLOW has same behavio as RTE_DPAA2_FLAT_GROUP_FLOW*/
-- 
2.43.0

