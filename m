Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FABC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 09:01:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDFB5410DD;
	Thu, 12 Jun 2025 10:59:43 +0200 (CEST)
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com
 [115.124.28.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7531F40E19
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:59:26 +0200 (CEST)
Received: from localhost.localdomain(mailfrom:kyo.liu@nebula-matrix.com
 fp:SMTPD_---.dJxInOX_1749718764 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 12 Jun 2025 16:59:24 +0800
From: Kyo Liu <kyo.liu@nebula-matrix.com>
To: kyo.liu@nebula-matrix.com,
	dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 17/17] net/nbl: nbl device support set mtu and promisc
Date: Thu, 12 Jun 2025 08:58:38 +0000
Message-ID: <20250612085840.729830-18-kyo.liu@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
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

Implement NBL device set mtu and promisc functions

Signed-off-by: Kyo Liu <kyo.liu@nebula-matrix.com>
---
 drivers/net/nbl/nbl_core.h                    |  2 +
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 60 +++++++++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.h             |  4 +-
 drivers/net/nbl/nbl_dispatch.c                | 76 +++++++++++++++++++
 drivers/net/nbl/nbl_dispatch.h                |  2 +
 drivers/net/nbl/nbl_ethdev.c                  | 31 +++++---
 drivers/net/nbl/nbl_include/nbl_def_channel.h | 10 +++
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |  1 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |  2 +
 9 files changed, 175 insertions(+), 13 deletions(-)

diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index 997544b112..d3fe1d02d2 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -51,6 +51,8 @@
 #define NBL_IS_NOT_COEXISTENCE(common)		({ typeof(common) _common = (common);	\
 						_common->nl_socket_route < 0 ||		\
 						_common->ifindex < 0; })
+#define NBL_IS_COEXISTENCE(common)		((common)->devfd != -1)
+
 struct nbl_core {
 	void *phy_mgt;
 	void *res_mgt;
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 4fa132ae1c..6e26989e1c 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -507,6 +507,63 @@ static int nbl_xstats_reset(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+static int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu)
+{
+	struct rte_eth_dev_data *dev_data = eth_dev->data;
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	uint32_t frame_size = mtu + NBL_ETH_OVERHEAD;
+	int ret;
+
+	/* check if mtu is within the allowed range */
+	if (mtu < RTE_ETHER_MIN_MTU || frame_size > NBL_FRAME_SIZE_MAX)
+		return -EINVAL;
+
+	/* mtu setting is forbidden if port is start */
+	if (dev_data->dev_started) {
+		NBL_LOG(ERR, "port %d must be stopped before configuration", dev_data->port_id);
+		return -EBUSY;
+	}
+
+	dev_data->dev_conf.rxmode.mtu = frame_size;
+	ret = disp_ops->set_mtu(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id, mtu);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int nbl_promiscuous_enable(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_common_info *common = &adapter->common;
+
+	if (!common->is_vf)
+		disp_ops->set_promisc_mode(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+					   dev_mgt->net_dev->vsi_id, 1);
+	dev_mgt->net_dev->promisc = 1;
+
+	return 0;
+}
+
+static int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_common_info *common = &adapter->common;
+
+	if (!common->is_vf)
+		disp_ops->set_promisc_mode(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+					   dev_mgt->net_dev->vsi_id, 0);
+	dev_mgt->net_dev->promisc = 0;
+
+	return 0;
+}
+
 struct nbl_dev_ops dev_ops = {
 	.dev_configure = nbl_dev_configure,
 	.dev_start = nbl_dev_port_start,
@@ -523,6 +580,9 @@ struct nbl_dev_ops dev_ops = {
 	.xstats_get = nbl_xstats_get,
 	.xstats_get_names = nbl_xstats_get_names,
 	.xstats_reset = nbl_xstats_reset,
+	.promiscuous_disable = nbl_promiscuous_disable,
+	.promiscuous_enable = nbl_promiscuous_enable,
+	.mtu_set = nbl_mtu_set,
 };
 
 static int nbl_dev_setup_chan_queue(struct nbl_adapter *adapter)
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index 1541aebba5..a97a53bc02 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -47,7 +47,9 @@ struct nbl_dev_net_mgt {
 	u8 eth_mode;
 	u8 eth_id;
 	u16 max_mac_num;
-	bool trust;
+	u8 trust:1;
+	u8 promisc:1;
+	u8 rsv:6;
 };
 
 struct nbl_dev_mgt {
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index e18b543ad6..c7c021eb5b 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -812,6 +812,73 @@ static void nbl_disp_get_private_stat_data_req(void *priv, u32 eth_id, u64 *data
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
+static int nbl_disp_set_mtu(void *priv, u16 vsi_id, u16 mtu)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL(res_ops->set_mtu, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id, mtu));
+	return ret;
+}
+
+static int nbl_disp_chan_set_mtu_req(void *priv, u16 vsi_id, u16 mtu)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_chan_param_set_mtu param = {0};
+
+	param.mtu = mtu;
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_MTU_SET,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static int nbl_disp_set_promisc_mode(void *priv, u16 vsi_id, u16 mode)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL(res_ops->set_promisc_mode,
+			   (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id, mode));
+	return ret;
+}
+
+static int nbl_disp_chan_set_promisc_mode_req(void *priv, u16 vsi_id, u16 mode)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_common_info *common;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_set_promisc_mode param = {0};
+	struct nbl_chan_send_info chan_send = {0};
+	int ret = 0;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	if (NBL_IS_COEXISTENCE(common)) {
+		ret = ioctl(common->devfd, NBL_DEV_USER_SET_PROMISC_MODE, &mode);
+		if (ret) {
+			NBL_LOG(ERR, "userspace send set_promisc_mode ioctl msg faild ret %d", ret);
+			return ret;
+		}
+		return 0;
+	}
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param.vsi_id = vsi_id;
+	param.mode = mode;
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SET_PROSISC_MODE,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
 #define NBL_DISP_OPS_TBL						\
 do {									\
 	NBL_DISP_SET_OPS(alloc_txrx_queues, nbl_disp_alloc_txrx_queues,	\
@@ -970,6 +1037,14 @@ do {									\
 			 NBL_DISP_CTRL_LVL_MGT,				\
 			 NBL_CHAN_MSG_GET_ETH_STATS,			\
 			 nbl_disp_get_private_stat_data_req, NULL);	\
+	NBL_DISP_SET_OPS(set_promisc_mode, nbl_disp_set_promisc_mode,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_SET_PROSISC_MODE,			\
+			 nbl_disp_chan_set_promisc_mode_req, NULL);	\
+	NBL_DISP_SET_OPS(set_mtu, nbl_disp_set_mtu,			\
+			 NBL_DISP_CTRL_LVL_MGT,	NBL_CHAN_MSG_MTU_SET,	\
+			 nbl_disp_chan_set_mtu_req,			\
+			 NULL);						\
 } while (0)
 
 /* Structure starts here, adding an op should not modify anything below */
@@ -1085,6 +1160,7 @@ int nbl_disp_init(void *p)
 	NBL_DISP_MGT_TO_RES_OPS_TBL(*disp_mgt) = res_ops_tbl;
 	NBL_DISP_MGT_TO_CHAN_OPS_TBL(*disp_mgt) = chan_ops_tbl;
 	NBL_DISP_MGT_TO_DISP_OPS_TBL(*disp_mgt) = *disp_ops_tbl;
+	NBL_DISP_MGT_TO_COMMON(*disp_mgt) = NBL_ADAPTER_TO_COMMON(adapter);
 
 	if (disp_product_ops->dispatch_init) {
 		ret = disp_product_ops->dispatch_init(*disp_mgt);
diff --git a/drivers/net/nbl/nbl_dispatch.h b/drivers/net/nbl/nbl_dispatch.h
index dcdf87576a..d1572769fe 100644
--- a/drivers/net/nbl/nbl_dispatch.h
+++ b/drivers/net/nbl/nbl_dispatch.h
@@ -16,11 +16,13 @@
 #define NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)	((disp_mgt)->disp_ops_tbl)
 #define NBL_DISP_MGT_TO_DISP_OPS(disp_mgt)	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->ops)
 #define NBL_DISP_MGT_TO_DISP_PRIV(disp_mgt)	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->priv)
+#define NBL_DISP_MGT_TO_COMMON(disp_mgt)	((disp_mgt)->common)
 
 struct nbl_dispatch_mgt {
 	struct nbl_resource_ops_tbl *res_ops_tbl;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_common_info *common;
 	uint32_t ctrl_lvl;
 };
 
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index 06543f6716..794a304e30 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -36,18 +36,25 @@ struct eth_dev_ops nbl_eth_dev_ops = {
 	.dev_close = nbl_dev_close,
 };
 
-#define NBL_DEV_NET_OPS_TBL						\
-do {									\
-	NBL_DEV_NET_OPS(dev_configure,		dev_ops->dev_configure);\
-	NBL_DEV_NET_OPS(dev_start,		dev_ops->dev_start);	\
-	NBL_DEV_NET_OPS(dev_stop,		dev_ops->dev_stop);	\
-	NBL_DEV_NET_OPS(dev_infos_get,		dev_ops->dev_infos_get);\
-	NBL_DEV_NET_OPS(tx_queue_setup,		dev_ops->tx_queue_setup);\
-	NBL_DEV_NET_OPS(rx_queue_setup,		dev_ops->rx_queue_setup);\
-	NBL_DEV_NET_OPS(rx_queue_release,	dev_ops->rx_queue_release);\
-	NBL_DEV_NET_OPS(tx_queue_release,	dev_ops->tx_queue_release);\
-	NBL_DEV_NET_OPS(link_update,		dev_ops->link_update);	\
-	NBL_DEV_NET_OPS(stats_get,		dev_ops->stats_get);	\
+#define NBL_DEV_NET_OPS_TBL							\
+do {										\
+	NBL_DEV_NET_OPS(dev_configure,		dev_ops->dev_configure);	\
+	NBL_DEV_NET_OPS(dev_start,		dev_ops->dev_start);		\
+	NBL_DEV_NET_OPS(dev_stop,		dev_ops->dev_stop);		\
+	NBL_DEV_NET_OPS(dev_infos_get,		dev_ops->dev_infos_get);	\
+	NBL_DEV_NET_OPS(tx_queue_setup,		dev_ops->tx_queue_setup);	\
+	NBL_DEV_NET_OPS(rx_queue_setup,		dev_ops->rx_queue_setup);	\
+	NBL_DEV_NET_OPS(rx_queue_release,	dev_ops->rx_queue_release);	\
+	NBL_DEV_NET_OPS(tx_queue_release,	dev_ops->tx_queue_release);	\
+	NBL_DEV_NET_OPS(link_update,		dev_ops->link_update);		\
+	NBL_DEV_NET_OPS(promiscuous_enable,	dev_ops->promiscuous_enable);	\
+	NBL_DEV_NET_OPS(promiscuous_disable,	dev_ops->promiscuous_disable);	\
+	NBL_DEV_NET_OPS(stats_get,		dev_ops->stats_get);		\
+	NBL_DEV_NET_OPS(stats_reset,		dev_ops->stats_reset);		\
+	NBL_DEV_NET_OPS(xstats_get,		dev_ops->xstats_get);		\
+	NBL_DEV_NET_OPS(xstats_get_names,	dev_ops->xstats_get_names);	\
+	NBL_DEV_NET_OPS(xstats_reset,		dev_ops->xstats_reset);		\
+	NBL_DEV_NET_OPS(mtu_set,		dev_ops->mtu_set);		\
 } while (0)
 
 static void nbl_set_eth_dev_ops(struct nbl_adapter *adapter,
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 30cb14b746..4c8e6eebd0 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -404,6 +404,16 @@ struct nbl_chan_param_get_private_stat_data {
 	u32 data_len;
 };
 
+struct nbl_chan_param_set_promisc_mode {
+	u16 vsi_id;
+	u16 mode;
+};
+
+struct nbl_chan_param_set_mtu {
+	u16 vsi_id;
+	u16 mtu;
+};
+
 struct nbl_channel_ops {
 	int (*send_msg)(void *priv, struct nbl_chan_send_info *chan_send);
 	int (*send_ack)(void *priv, struct nbl_chan_ack_info *chan_ack);
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
index 92dbc428ef..0c1b938bb6 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -33,6 +33,7 @@ struct nbl_dispatch_ops {
 	void (*clear_flow)(void *priv, u16 vsi_id);
 	void (*get_firmware_version)(void *priv, char *firmware_verion, u8 max_len);
 	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	int (*set_mtu)(void *priv, u16 vsi_id, u16 mtu);
 	int (*alloc_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
 	void (*free_txrx_queues)(void *priv, u16 vsi_id);
 	u16 (*get_vsi_id)(void *priv);
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index f9864e261b..a26856ad3b 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -72,6 +72,8 @@ struct nbl_resource_ops {
 	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set);
 	void (*remove_cqs)(void *priv, u16 vsi_id);
 	void (*get_link_state)(void *priv, u8 eth_id, struct nbl_eth_link_info *eth_link_info);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	int (*set_mtu)(void *priv, u16 vsi_id, u16 mtu);
 };
 
 struct nbl_resource_ops_tbl {
-- 
2.43.0

