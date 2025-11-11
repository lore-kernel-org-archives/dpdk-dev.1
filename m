Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F5CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:32:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 927604066A;
	Tue, 11 Nov 2025 12:32:03 +0100 (CET)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com
 [115.124.28.123])
 by mails.dpdk.org (Postfix) with ESMTP id 97FA84026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:32:01 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fJvT89O_1762860719 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 11 Nov 2025 19:31:59 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Alvin Wang <alvin.wang@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 3/4] net/nbl: add support for imissed stats
Date: Tue, 11 Nov 2025 03:31:42 -0800
Message-Id: <20251111113144.3567291-4-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
 <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add an imissed statistic to monitor the number of RX packets
dropped by the hardware.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 210 +++++++++++++++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   9 +
 drivers/net/nbl/nbl_dispatch.c                |  65 ++++++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |   5 +
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   4 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   4 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   6 +
 7 files changed, 299 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 52daf924cc..58eb1c6231 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -132,6 +132,80 @@ static int nbl_dev_txrx_start(struct rte_eth_dev *eth_dev)
 	return ret;
 }
 
+static int nbl_dev_update_hw_stats(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	u32 *uvn_stat_pkt_drop;
+	int i = 0;
+	int ret = 0;
+
+	if (!net_dev->hw_stats_inited)
+		return 0;
+	uvn_stat_pkt_drop = calloc(eth_dev->data->nb_rx_queues, sizeof(*uvn_stat_pkt_drop));
+	if (!uvn_stat_pkt_drop) {
+		ret = -ENOMEM;
+		goto alloc_uvn_stat_pkt_drop_fail;
+	}
+	ret = disp_ops->get_uvn_pkt_drop_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+					       net_dev->vsi_id,
+					       eth_dev->data->nb_rx_queues, uvn_stat_pkt_drop);
+	if (ret)
+		goto get_uvn_pkt_drop_stats_fail;
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
+		net_dev->hw_stats.total_uvn_stat_pkt_drop[i] += uvn_stat_pkt_drop[i];
+	free(uvn_stat_pkt_drop);
+	uvn_stat_pkt_drop = NULL;
+
+	return 0;
+
+get_uvn_pkt_drop_stats_fail:
+	free(uvn_stat_pkt_drop);
+	uvn_stat_pkt_drop = NULL;
+alloc_uvn_stat_pkt_drop_fail:
+	return ret;
+}
+
+static void nbl_dev_update_hw_stats_handler(void *param)
+{
+	struct rte_eth_dev *eth_dev = param;
+
+	nbl_dev_update_hw_stats(eth_dev);
+
+	rte_eal_alarm_set(NBL_ALARM_INTERNAL, nbl_dev_update_hw_stats_handler, eth_dev);
+}
+
+static int nbl_dev_hw_stats_start(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_ustore_stats ustore_stats = {0};
+	int ret;
+
+	if (!common->is_vf) {
+		ret = disp_ops->get_ustore_total_pkt_drop_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+						common->eth_id, &ustore_stats);
+		if (ret) {
+			net_dev->hw_stats_inited = false;
+			return 0;
+		}
+		net_dev->hw_stats_inited = true;
+		net_dev->hw_stats.start_ustore_stats->rx_drop_packets =
+			ustore_stats.rx_drop_packets;
+		net_dev->hw_stats.start_ustore_stats->rx_trun_packets =
+			ustore_stats.rx_trun_packets;
+	}
+
+	rte_eal_alarm_set(NBL_ALARM_INTERNAL, nbl_dev_update_hw_stats_handler, eth_dev);
+
+	return 0;
+}
+
 int nbl_dev_port_start(struct rte_eth_dev *eth_dev)
 {
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
@@ -152,6 +226,10 @@ int nbl_dev_port_start(struct rte_eth_dev *eth_dev)
 		return ret;
 	}
 
+	ret = nbl_dev_hw_stats_start(eth_dev);
+	if (ret)
+		return ret;
+
 	common->pf_start = 1;
 	return 0;
 }
@@ -181,6 +259,13 @@ static void nbl_dev_txrx_stop(struct rte_eth_dev *eth_dev)
 	disp_ops->remove_all_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id);
 }
 
+static int nbl_dev_hw_stats_stop(struct rte_eth_dev *eth_dev)
+{
+	rte_eal_alarm_cancel(nbl_dev_update_hw_stats_handler, eth_dev);
+
+	return 0;
+}
+
 int nbl_dev_port_stop(struct rte_eth_dev *eth_dev)
 {
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
@@ -188,6 +273,7 @@ int nbl_dev_port_stop(struct rte_eth_dev *eth_dev)
 	common->pf_start = 0;
 	rte_delay_ms(NBL_SAFE_THREADS_WAIT_TIME);
 
+	nbl_dev_hw_stats_stop(eth_dev);
 	nbl_clear_queues(eth_dev);
 	nbl_dev_txrx_stop(eth_dev);
 	nbl_userdev_port_config(adapter, NBL_KERNEL_NETWORK);
@@ -375,8 +461,50 @@ int nbl_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats,
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
 	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_ustore_stats ustore_stats = {0};
+	int i = 0;
+	int ret = 0;
+
+	ret = disp_ops->get_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), rte_stats, qstats);
+	if (ret)
+		goto get_stats_fail;
 
-	return disp_ops->get_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), rte_stats, qstats);
+	if (!net_dev->hw_stats_inited)
+		return 0;
+
+	rte_eal_alarm_cancel(nbl_dev_update_hw_stats_handler, eth_dev);
+	ret = nbl_dev_update_hw_stats(eth_dev);
+	if (ret)
+		goto update_hw_stats_fail;
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS)
+			qstats->q_errors[i] = net_dev->hw_stats.total_uvn_stat_pkt_drop[i];
+		rte_stats->imissed += net_dev->hw_stats.total_uvn_stat_pkt_drop[i];
+	}
+
+	if (!common->is_vf) {
+		ret = disp_ops->get_ustore_total_pkt_drop_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+								common->eth_id, &ustore_stats);
+		if (ret)
+			goto get_ustore_total_pkt_drop_stats_fail;
+		rte_stats->imissed += ustore_stats.rx_drop_packets -
+					net_dev->hw_stats.start_ustore_stats->rx_drop_packets;
+		rte_stats->imissed += ustore_stats.rx_trun_packets -
+					net_dev->hw_stats.start_ustore_stats->rx_trun_packets;
+	}
+
+	rte_eal_alarm_set(NBL_ALARM_INTERNAL, nbl_dev_update_hw_stats_handler, eth_dev);
+
+	return 0;
+
+get_ustore_total_pkt_drop_stats_fail:
+update_hw_stats_fail:
+	rte_eal_alarm_set(NBL_ALARM_INTERNAL, nbl_dev_update_hw_stats_handler, eth_dev);
+get_stats_fail:
+	return ret;
 }
 
 int nbl_stats_reset(struct rte_eth_dev *eth_dev)
@@ -384,8 +512,56 @@ int nbl_stats_reset(struct rte_eth_dev *eth_dev)
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
 	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	u32 *uvn_stat_pkt_drop;
+	struct nbl_ustore_stats ustore_stats = {0};
+	int i = 0;
+	int ret = 0;
+
+	ret = disp_ops->reset_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+
+	if (!net_dev->hw_stats_inited || ret)
+		return ret;
 
-	return disp_ops->reset_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+	rte_eal_alarm_cancel(nbl_dev_update_hw_stats_handler, eth_dev);
+
+	uvn_stat_pkt_drop = calloc(eth_dev->data->nb_rx_queues, sizeof(*uvn_stat_pkt_drop));
+	if (!uvn_stat_pkt_drop) {
+		ret = -ENOMEM;
+		goto alloc_uvn_stat_pkt_drop_fail;
+	}
+	ret = disp_ops->get_uvn_pkt_drop_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+					       net_dev->vsi_id,
+					       eth_dev->data->nb_rx_queues, uvn_stat_pkt_drop);
+	if (ret)
+		goto get_uvn_pkt_drop_stats_fail;
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
+		net_dev->hw_stats.total_uvn_stat_pkt_drop[i] = 0;
+	if (!common->is_vf) {
+		ret = disp_ops->get_ustore_total_pkt_drop_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+								common->eth_id, &ustore_stats);
+		if (ret)
+			goto get_ustore_total_pkt_drop_stats_fail;
+		net_dev->hw_stats.start_ustore_stats->rx_drop_packets =
+			ustore_stats.rx_drop_packets;
+		net_dev->hw_stats.start_ustore_stats->rx_trun_packets =
+			ustore_stats.rx_trun_packets;
+	}
+	free(uvn_stat_pkt_drop);
+	uvn_stat_pkt_drop = NULL;
+
+	rte_eal_alarm_set(NBL_ALARM_INTERNAL, nbl_dev_update_hw_stats_handler, eth_dev);
+
+	return 0;
+
+get_ustore_total_pkt_drop_stats_fail:
+get_uvn_pkt_drop_stats_fail:
+	free(uvn_stat_pkt_drop);
+	uvn_stat_pkt_drop = NULL;
+alloc_uvn_stat_pkt_drop_fail:
+	rte_eal_alarm_set(NBL_ALARM_INTERNAL, nbl_dev_update_hw_stats_handler, eth_dev);
+	return ret;
 }
 
 static int nbl_dev_update_hw_xstats(struct nbl_dev_mgt *dev_mgt, struct rte_eth_xstat *xstats,
@@ -837,6 +1013,14 @@ static void nbl_dev_remove_net_dev(struct nbl_dev_mgt *dev_mgt)
 	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
 	struct nbl_dev_ring_mgt *ring_mgt = &net_dev->ring_mgt;
 	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+
+	if (!common->is_vf) {
+		rte_free(net_dev->hw_stats.start_ustore_stats);
+		net_dev->hw_stats.start_ustore_stats = NULL;
+	}
+	rte_free(net_dev->hw_stats.total_uvn_stat_pkt_drop);
+	net_dev->hw_stats.total_uvn_stat_pkt_drop = NULL;
 
 	disp_ops->remove_rss(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
 	disp_ops->remove_q2vsi(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
@@ -924,11 +1108,29 @@ static int nbl_dev_setup_net_dev(struct nbl_dev_mgt *dev_mgt,
 		goto setup_q2vsi_failed;
 	}
 
-	ret = disp_ops->setup_rss(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
-				  net_dev->vsi_id);
+	ret = disp_ops->setup_rss(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+
+	net_dev->hw_stats.total_uvn_stat_pkt_drop =
+		rte_zmalloc("nbl_total_uvn_stat_pkt_drop",
+			    sizeof(u64) * (ring_mgt->rx_ring_num), 0);
+	if (!net_dev->hw_stats.total_uvn_stat_pkt_drop) {
+		ret = -ENOMEM;
+		goto alloc_total_uvn_stat_pkt_drop_fail;
+	}
+	if (!common->is_vf) {
+		net_dev->hw_stats.start_ustore_stats =
+			rte_zmalloc("nbl_start_ustore_stats", sizeof(struct nbl_ustore_stats), 0);
+		if (!net_dev->hw_stats.start_ustore_stats) {
+			ret = -ENOMEM;
+			goto alloc_start_ustore_stats_fail;
+		}
+	}
 
 	return ret;
 
+alloc_start_ustore_stats_fail:
+	rte_free(net_dev->hw_stats.total_uvn_stat_pkt_drop);
+alloc_total_uvn_stat_pkt_drop_fail:
 setup_q2vsi_failed:
 	disp_ops->free_txrx_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
 				   net_dev->vsi_id);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index 99d8fd9483..c8a5a4670b 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -20,6 +20,8 @@
 #define NBL_FRAME_SIZE_MAX			(9600)
 #define NBL_DEV_MIN_RX_BUFSIZE			(2048)
 
+#define NBL_ALARM_INTERNAL			(10000000)
+
 struct nbl_dev_ring {
 	u16 index;
 	u64 dma;
@@ -37,6 +39,11 @@ struct nbl_dev_ring_mgt {
 	u8 active_ring_num;
 };
 
+struct nbl_hw_stats {
+	u64 *total_uvn_stat_pkt_drop;
+	struct nbl_ustore_stats *start_ustore_stats;
+};
+
 struct nbl_dev_net_mgt {
 	const struct rte_eth_dev *eth_dev;
 	struct nbl_dev_ring_mgt ring_mgt;
@@ -51,6 +58,8 @@ struct nbl_dev_net_mgt {
 	u8 trust:1;
 	u8 promisc:1;
 	u8 rsv:6;
+	struct nbl_hw_stats hw_stats;
+	bool hw_stats_inited;
 };
 
 struct nbl_dev_mgt {
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index 96d2c84c40..52d37ba7fe 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -816,6 +816,60 @@ static int nbl_disp_get_stats(void *priv, struct rte_eth_stats *rte_stats,
 	return res_ops->get_stats(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), rte_stats, qstats);
 }
 
+static int nbl_disp_get_uvn_pkt_drop_stats(void *priv, u16 vsi_id,
+					   u16 num_queues, u32 *uvn_stat_pkt_drop)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	int ret = 0;
+
+	ret = NBL_OPS_CALL(res_ops->get_uvn_pkt_drop_stats,
+			   (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+			    vsi_id, num_queues, uvn_stat_pkt_drop));
+	return ret;
+}
+
+static int nbl_disp_chan_get_uvn_pkt_drop_stats_req(void *priv, u16 vsi_id,
+						    u16 num_queues, u32 *uvn_stat_pkt_drop)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_get_uvn_pkt_drop_stats param = {0};
+	struct nbl_chan_send_info chan_send = {0};
+
+	param.vsi_id = vsi_id;
+	param.num_queues = num_queues;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_GET_UVN_PKT_DROP_STATS,
+		      &param, sizeof(param),
+		      uvn_stat_pkt_drop, num_queues * sizeof(*uvn_stat_pkt_drop), 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_get_ustore_total_pkt_drop_stats(void *priv, u8 eth_id,
+						    struct nbl_ustore_stats *ustore_stats)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	int ret = 0;
+
+	ret = NBL_OPS_CALL(res_ops->get_ustore_total_pkt_drop_stats,
+			   (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), eth_id, ustore_stats));
+	return ret;
+}
+
+static int nbl_disp_chan_get_ustore_total_pkt_drop_stats_req(void *priv, u8 eth_id,
+							     struct nbl_ustore_stats *ustore_stats)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,
+		      &eth_id, sizeof(eth_id), ustore_stats, sizeof(*ustore_stats), 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
 static int nbl_disp_reset_stats(void *priv)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
@@ -1111,6 +1165,17 @@ do {									\
 	NBL_DISP_SET_OPS(get_stats, nbl_disp_get_stats,			\
 			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
 			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(get_uvn_pkt_drop_stats,			\
+			 nbl_disp_get_uvn_pkt_drop_stats,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_GET_UVN_PKT_DROP_STATS,		\
+			 nbl_disp_chan_get_uvn_pkt_drop_stats_req, NULL);\
+	NBL_DISP_SET_OPS(get_ustore_total_pkt_drop_stats,		\
+			 nbl_disp_get_ustore_total_pkt_drop_stats,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,	\
+			 nbl_disp_chan_get_ustore_total_pkt_drop_stats_req,\
+			 NULL);						\
 	NBL_DISP_SET_OPS(reset_stats, nbl_disp_reset_stats,		\
 			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
 			 NULL, NULL);					\
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 6b150ed715..55880737f1 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -395,6 +395,11 @@ struct nbl_chan_param_get_private_stat_data {
 	u32 data_len;
 };
 
+struct nbl_chan_param_get_uvn_pkt_drop_stats {
+	u16 vsi_id;
+	u16 num_queues;
+};
+
 struct nbl_chan_send_info {
 	uint16_t dstid;
 	uint16_t msg_type;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
index 5284e9a929..45e7504a07 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -76,6 +76,10 @@ struct nbl_dispatch_ops {
 	void (*get_link_state)(void *priv, u8 eth_id, struct nbl_eth_link_info *eth_link_info);
 	int (*get_stats)(void *priv, struct rte_eth_stats *rte_stats,
 			 struct eth_queue_stats *qstats);
+	int (*get_uvn_pkt_drop_stats)(void *priv, u16 vsi_id,
+				      u16 num_queues, u32 *uvn_stat_pkt_drop);
+	int (*get_ustore_total_pkt_drop_stats)(void *priv, u8 eth_id,
+					       struct nbl_ustore_stats *ustore_stats);
 	int (*reset_stats)(void *priv);
 	int (*get_txrx_xstats_cnt)(void *priv, u16 *xstats_cnt);
 	int (*get_txrx_xstats)(void *priv, struct rte_eth_xstat *xstats,
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index b8f19f81b5..6935598789 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -46,6 +46,10 @@ struct nbl_resource_ops {
 	void (*release_rx_ring)(void *priv, u16 queue_idx);
 	int (*get_stats)(void *priv, struct rte_eth_stats *rte_stats,
 			 struct eth_queue_stats *qstats);
+	int (*get_uvn_pkt_drop_stats)(void *priv, u16 vsi_id,
+				      u16 num_queues, u32 *uvn_stat_pkt_drop);
+	int (*get_ustore_total_pkt_drop_stats)(void *priv, u8 eth_id,
+					       struct nbl_ustore_stats *ustore_stats);
 	int (*reset_stats)(void *priv);
 	int (*get_txrx_xstats_cnt)(void *priv, u16 *xstats_cnt);
 	int (*get_txrx_xstats)(void *priv, struct rte_eth_xstat *xstats,
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index e0f0497e3f..eeae6a3301 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -25,6 +25,7 @@
 #include <unistd.h>
 #include <net/if.h>
 
+#include <rte_alarm.h>
 #include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
@@ -202,4 +203,9 @@ struct nbl_txq_stats {
 	uint64_t tx_tso_packets;
 };
 
+struct nbl_ustore_stats {
+	u64 rx_drop_packets;
+	u64 rx_trun_packets;
+};
+
 #endif
-- 
2.34.1

