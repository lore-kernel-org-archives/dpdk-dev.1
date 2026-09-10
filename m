Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0246C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:56:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 474AD42EAE;
	Thu, 10 Sep 2026 15:53:00 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2BC3342E49
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F66A1A002F;
 Thu, 10 Sep 2026 15:52:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A35351A0072;
 Thu, 10 Sep 2026 15:52:47 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4788818000B5;
 Thu, 10 Sep 2026 21:52:46 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 39/47] net/dpaa2: support flow table miss actions
Date: Thu, 10 Sep 2026 19:21:50 +0530
Message-ID: <20260910135158.2181141-40-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Implement the group_set_miss_actions callback so that the default
action of the QoS and flow steering tables can be configured. A table
miss either drops the frame, steers it to a default queue, or jumps to
a default traffic class.

The default action is applied while the port is configured, so that the
tables have a defined miss behaviour before any flow rule is added.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c |  58 ++++++++
 drivers/net/dpaa2/dpaa2_flow.c   | 237 +++++++++++++++++++++++++++++++
 2 files changed, 295 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 32fab43142..812e3f529f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -354,6 +354,52 @@ static int dpaa2_dev_link_update(struct rte_eth_dev *dev,
 static int dpaa2_dev_set_link_up(struct rte_eth_dev *dev);
 static int dpaa2_dev_set_link_down(struct rte_eth_dev *dev);
 static int dpaa2_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
+static int
+dpaa2_setup_table_miss_action(struct rte_eth_dev *eth_dev,
+	uint8_t tc_index)
+{
+	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
+	struct rte_flow_group_attr attr;
+	struct rte_flow_action actions[2];
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.ingress = 1;
+	if (tc_index < priv->num_rx_tc) {
+		tbl_profile = &priv->flow_profile.tc_profile[tc_index];
+		if (tbl_profile->default_drop) {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else if (tbl_profile->default_queue.index >= eth_dev->data->nb_rx_queues) {
+			DPAA2_PMD_DEBUG("%s-tc%d-default-rxq(%d) >= max rxq(%d), Force to drop.",
+				eth_dev->data->name, tc_index, tbl_profile->default_queue.index,
+				eth_dev->data->nb_rx_queues);
+			tbl_profile->default_drop = true;
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
+			actions[0].conf = &tbl_profile->default_queue;
+		}
+	} else {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		if (tbl_profile->default_drop) {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else if (tbl_profile->default_jump.group >= priv->num_rx_tc) {
+			DPAA2_PMD_DEBUG("%s-default-tc(%d) >= max tc(%d), Force to drop.",
+				eth_dev->data->name, tbl_profile->default_jump.group,
+				priv->num_rx_tc);
+			tbl_profile->default_drop = true;
+			actions[0].type = RTE_FLOW_ACTION_TYPE_DROP;
+		} else {
+			actions[0].type = RTE_FLOW_ACTION_TYPE_JUMP;
+			actions[0].conf = &tbl_profile->default_jump;
+		}
+	}
+	actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+
+	return rte_flow_group_set_miss_actions(eth_dev->data->port_id,
+			tc_index, &attr, actions, NULL);
+}
+
 static int
 dpaa2_setup_flow_rss_dist(struct rte_eth_dev *eth_dev,
 	uint64_t req_dist_set, int tc_index)
@@ -1087,6 +1133,13 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 					def_act_conf->default_flows[tc_index];
 			}
 		}
+		if (priv->fs_entries) {
+			ret = dpaa2_setup_table_miss_action(dev, tc_index);
+			if (ret) {
+				DPAA2_PMD_ERR("Error(%d) to set miss action of %s-tc%d table",
+					ret, dev->data->name, tc_index);
+			}
+		}
 	}
 	if (def_act_conf) {
 		tbl_profile = &priv->flow_profile.qos_profile;
@@ -1097,6 +1150,11 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 			tbl_profile->default_jump.group = def_act_conf->default_tc;
 		}
 	}
+	ret = dpaa2_setup_table_miss_action(dev, priv->num_rx_tc);
+	if (ret) {
+		DPAA2_PMD_ERR("Error(%d) to set miss action of %s-QoS table",
+			ret, dev->data->name);
+	}
 
 	if (eth_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
 		for (tc_index = 0; tc_index < priv->num_rx_tc; tc_index++) {
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index e86e6d1f8b..a51225d38d 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -3831,6 +3831,52 @@ dpaa2_flow_clear_fs_table(struct dpaa2_dev_priv *priv,
 	return 0;
 }
 
+static int
+dpaa2_flow_fs_table_set_default(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, int discard, uint16_t default_queue)
+{
+	int ret;
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpni_rx_dist_cfg *tc_cfg;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct dpaa2_queue *queue;
+	char mc_rev[1024];
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+	snprintf(mc_rev, 1024, "MC rev(%d.%d.%d)",
+		RTE_FSL_MC_REV_MAJOR(dpaa2_dev->bus_info->mc_rev),
+		RTE_FSL_MC_REV_MINOR(dpaa2_dev->bus_info->mc_rev),
+		RTE_FSL_MC_REV_REVISION(dpaa2_dev->bus_info->mc_rev));
+	if (!tbl_profile->dpkg.num_extracts &&
+		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
+		DPAA2_PMD_DEBUG("%s can't set miss action of FS table indepentently.",
+			mc_rev);
+		return 0;
+	}
+	tc_cfg = &tbl_profile->tc_cfg;
+	tc_cfg->enable = true;
+	if (discard) {
+		tbl_profile->default_drop = true;
+		tc_cfg->fs_miss_flow_id = DPNI_FS_MISS_ACTION_DROP;
+	} else {
+		queue = dpaa2_flow_queue_action_to_queue(priv, tc_id, default_queue);
+		if (!queue)
+			return -EINVAL;
+		tbl_profile->default_drop = false;
+		tbl_profile->default_queue.index = default_queue;
+		tc_cfg->fs_miss_flow_id = queue->flow_id;
+	}
+	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW, priv->token, tc_cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("%s: Failed(%d) to set default action of TC[%d]",
+			__func__, ret, tc_id);
+		return ret;
+	}
+
+	return 0;
+}
 
 static int
 dpaa2_flow_fs_rss_table_config(struct dpaa2_dev_priv *priv,
@@ -3924,6 +3970,62 @@ dpaa2_flow_fs_rss_table_config(struct dpaa2_dev_priv *priv,
 	return 0;
 }
 
+static int
+dpaa2_flow_qos_table_set_default(struct dpaa2_dev_priv *priv,
+	int discard, uint8_t default_tc, uint16_t default_flow)
+{
+	int ret;
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpni_qos_tbl_cfg qos_cfg;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	char mc_rev[1024];
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+	tbl_profile = &priv->flow_profile.qos_profile;
+	snprintf(mc_rev, 1024, "MC rev(%d.%d.%d)",
+		RTE_FSL_MC_REV_MAJOR(dpaa2_dev->bus_info->mc_rev),
+		RTE_FSL_MC_REV_MINOR(dpaa2_dev->bus_info->mc_rev),
+		RTE_FSL_MC_REV_REVISION(dpaa2_dev->bus_info->mc_rev));
+	if (!tbl_profile->dpkg.num_extracts &&
+		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
+		DPAA2_PMD_DEBUG("%s can't set miss action of QoS table indepentently.",
+			mc_rev);
+		return 0;
+	}
+	if (default_flow < priv->dist_queues &&
+		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV) {
+		DPAA2_PMD_WARN("%s can't direct miss traffic to TC%d-flow%d by QoS table only.",
+			mc_rev, default_tc, default_flow);
+		return 0;
+	}
+
+	rte_memcpy(&qos_cfg, &tbl_profile->qos_cfg, sizeof(struct dpni_qos_tbl_cfg));
+	qos_cfg.key_cfg_iova = 0;
+	qos_cfg.default_tc = default_tc;
+	qos_cfg.default_flow_id = default_flow;
+	qos_cfg.discard_on_miss = discard ? true : false;
+	qos_cfg.set_default_flow_id = default_flow < priv->dist_queues ? true : false;
+
+	ret = dpni_set_qos_table(dpni, CMD_PRI_LOW, priv->token, &qos_cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("%s: Failed(%d) to set default action of QoS",
+			__func__, ret);
+		return ret;
+	}
+	if (discard) {
+		tbl_profile->default_drop = true;
+	} else {
+		tbl_profile->default_drop = false;
+		tbl_profile->default_jump.group = default_tc;
+	}
+	rte_memcpy(&tbl_profile->qos_cfg.discard_on_miss,
+		&qos_cfg.discard_on_miss,
+		sizeof(struct dpni_qos_tbl_cfg) -
+		offsetof(struct dpni_qos_tbl_cfg, discard_on_miss));
+
+	return 0;
+}
 
 static int
 dpaa2_flow_qos_table_config(struct dpaa2_dev_priv *priv,
@@ -5927,6 +6029,140 @@ dpaa2_flow_destroy(struct rte_eth_dev *dev,
 	return qos_ret ? qos_ret : fs_ret;
 }
 
+static int
+dpaa2_flow_set_miss_actions(struct rte_eth_dev *dev,
+	uint32_t group, const struct rte_flow_group_attr *attr,
+	const struct rte_flow_action actions[], struct rte_flow_error *err)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	enum dpaa2_flow_dist_type flow_type = DPAA2_FLOW_NULL_TYPE;
+	int end_of_list = 0, i = 0, discard = false, err_code = 0;
+	const struct rte_flow_action_jump *action_jump = NULL;
+	const struct rte_flow_action_queue *dest_queue = NULL;
+	uint32_t group_id, group_type;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
+	struct dpaa2_queue *miss_rxq = NULL;
+	uint8_t qos_tc = 0xff;
+	uint16_t qos_flow = 0xffff;
+
+	RTE_SET_USED(attr);
+
+	group_type = RTE_DPAA2_FLOW_GROUP_TYPE_GET(group);
+	group_id = RTE_DPAA2_FLOW_GROUP_ID_GET(group);
+	if (group_id >= priv->num_rx_tc &&
+		group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW) {
+		group_type = RTE_DPAA2_QOS_GROUP_FLOW;
+		group_id = 0;
+	}
+	if (group_type == RTE_DPAA2_QOS_GROUP_FLOW)
+		flow_type = DPAA2_FLOW_QOS_TYPE;
+	else if (group_type == RTE_DPAA2_FS_GROUP_FLOW)
+		flow_type = DPAA2_FLOW_FS_TYPE;
+	else if (group >= priv->num_rx_tc)
+		flow_type = DPAA2_FLOW_QOS_TYPE;
+	else
+		flow_type = DPAA2_FLOW_FS_TYPE;
+
+	while (!end_of_list) {
+		switch (actions[i].type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+			dest_queue = actions[i].conf;
+			if (dest_queue->index >= dev->data->nb_rx_queues) {
+				error_type = RTE_FLOW_ERROR_TYPE_ACTION_CONF;
+				err_code = -EINVAL;
+				err_str = "Queue index overflows";
+				goto failure_to_set_miss_actions;
+			}
+			miss_rxq = priv->rx_vq[dest_queue->index];
+			break;
+		case RTE_FLOW_ACTION_TYPE_JUMP:
+			action_jump = actions[i].conf;
+			break;
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			discard = true;
+			break;
+		case RTE_FLOW_ACTION_TYPE_END:
+			end_of_list = 1;
+			break;
+		default:
+			DPAA2_PMD_WARN("Invalid default action type[%d]:(%d)",
+				i, actions[i].type);
+			break;
+		}
+		i++;
+	}
+
+	if (flow_type == DPAA2_FLOW_QOS_TYPE) {
+		if (!priv->qos_entries) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_code = -EINVAL;
+			err_str = "No QoS table available!";
+			goto failure_to_set_miss_actions;
+		}
+		if (action_jump && miss_rxq) {
+			if (action_jump->group != miss_rxq->tc_index) {
+				error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+				err_code = -EINVAL;
+				err_str = "Jump group conflicts to miss queue's TC";
+				goto failure_to_set_miss_actions;
+			}
+		}
+		if (action_jump)
+			qos_tc = action_jump->group;
+		if (miss_rxq) {
+			qos_tc = miss_rxq->tc_index;
+			qos_flow = miss_rxq->flow_id;
+		}
+		if ((!discard && qos_tc == 0xff) ||
+			(discard && qos_tc != 0xff)) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_code = -EINVAL;
+			err_str = "Invalid miss action set for QoS table";
+			goto failure_to_set_miss_actions;
+		}
+		err_code = dpaa2_flow_qos_table_set_default(priv, discard, qos_tc, qos_flow);
+		if (err_code) {
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_str = "Failed to set miss action for QoS table";
+			goto failure_to_set_miss_actions;
+		}
+
+		return 0;
+	}
+
+	if (!priv->fs_entries) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_code = -EINVAL;
+		err_str = "No FS table available!";
+		goto failure_to_set_miss_actions;
+	}
+	if (!discard && !miss_rxq) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_code = -EINVAL;
+		err_str = "Invalid miss action set for FS table";
+		goto failure_to_set_miss_actions;
+	}
+	if (miss_rxq && miss_rxq->tc_index != group_id) {
+		error_type = RTE_FLOW_ERROR_TYPE_ATTR_GROUP;
+		err_code = -EINVAL;
+		err_str = "Group conflicts with dest queue's TC ID";
+		goto failure_to_set_miss_actions;
+	}
+	err_code = dpaa2_flow_fs_table_set_default(priv, group_id, discard,
+		dest_queue ? dest_queue->index : 0);
+	if (err_code) {
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_str = "Failed to set miss action for FS table";
+	}
+
+failure_to_set_miss_actions:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	rte_flow_error_set(err, -err_code, error_type, NULL, err_str);
+
+	return err_code;
+}
 
 static int
 dpaa2_flow_actions_update(struct rte_eth_dev *dev,
@@ -6380,6 +6616,7 @@ const struct rte_flow_ops dpaa2_flow_ops = {
 	.create	= dpaa2_flow_create,
 	.validate = dpaa2_flow_validate,
 	.destroy = dpaa2_flow_destroy,
+	.group_set_miss_actions = dpaa2_flow_set_miss_actions,
 	.actions_update = dpaa2_flow_actions_update,
 	.flush	= dpaa2_flow_flush,
 	.query	= dpaa2_flow_query,
-- 
2.43.0

