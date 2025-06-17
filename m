Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A49C71155
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 06:12:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFBEB40DDA;
	Tue, 17 Jun 2025 08:12:18 +0200 (CEST)
Received: from out28-104.mail.aliyun.com (out28-104.mail.aliyun.com
 [115.124.28.104])
 by mails.dpdk.org (Postfix) with ESMTP id B7A5F406BB
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:12:10 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.dO-dyZh_1750140728 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 17 Jun 2025 14:12:08 +0800
From: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	kyo.liu@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 06/16] net/nbl: add Dispatch layer definitions and
 implementation
Date: Mon, 16 Jun 2025 23:11:48 -0700
Message-Id: <20250617061158.3097233-7-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617061158.3097233-1-dimon.zhao@nebula-matrix.com>
References: <20250617061158.3097233-1-dimon.zhao@nebula-matrix.com>
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

add Dispatch layer related definitions

Signed-off-by: dimon.zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |   1 +
 drivers/net/nbl/nbl_core.c                    |   7 +
 drivers/net/nbl/nbl_core.h                    |   4 +
 drivers/net/nbl/nbl_dispatch.c                | 466 ++++++++++++++++++
 drivers/net/nbl/nbl_dispatch.h                |  29 ++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  18 +
 drivers/net/nbl/nbl_include/nbl_def_common.h  |   4 +
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |  77 +++
 .../net/nbl/nbl_include/nbl_def_resource.h    |   5 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  17 +
 10 files changed, 628 insertions(+)
 create mode 100644 drivers/net/nbl/nbl_dispatch.c
 create mode 100644 drivers/net/nbl/nbl_dispatch.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dispatch.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index f34121260e..23601727ef 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -12,6 +12,7 @@ includes += include_directories('nbl_hw')
 sources = files(
         'nbl_ethdev.c',
         'nbl_core.c',
+        'nbl_dispatch.c',
         'nbl_common/nbl_common.c',
         'nbl_common/nbl_thread.c',
         'nbl_hw/nbl_channel.c',
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index 70600401fe..548eb3a2fd 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -50,8 +50,14 @@ int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
 	if (ret)
 		goto res_init_fail;
 
+	ret = nbl_disp_init(adapter);
+	if (ret)
+		goto disp_init_fail;
+
 	return 0;
 
+disp_init_fail:
+	product_base_ops->res_remove(adapter);
 res_init_fail:
 	product_base_ops->chan_remove(adapter);
 chan_init_fail:
@@ -66,6 +72,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
 
+	nbl_disp_remove(adapter);
 	product_base_ops->res_remove(adapter);
 	product_base_ops->chan_remove(adapter);
 	product_base_ops->phy_remove(adapter);
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index f693913b47..2730539050 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -10,6 +10,7 @@
 #include "nbl_def_phy.h"
 #include "nbl_def_channel.h"
 #include "nbl_def_resource.h"
+#include "nbl_def_dispatch.h"
 
 #define NBL_VENDOR_ID				(0x1F0F)
 #define NBL_DEVICE_ID_M18110			(0x3403)
@@ -35,10 +36,12 @@
 #define NBL_ADAPTER_TO_PHY_MGT(adapter)		((adapter)->core.phy_mgt)
 #define NBL_ADAPTER_TO_CHAN_MGT(adapter)	((adapter)->core.chan_mgt)
 #define NBL_ADAPTER_TO_RES_MGT(adapter)		((adapter)->core.res_mgt)
+#define NBL_ADAPTER_TO_DISP_MGT(adapter)	((adapter)->core.disp_mgt)
 
 #define NBL_ADAPTER_TO_PHY_OPS_TBL(adapter)	((adapter)->intf.phy_ops_tbl)
 #define NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter)	((adapter)->intf.channel_ops_tbl)
 #define NBL_ADAPTER_TO_RES_OPS_TBL(adapter)	((adapter)->intf.resource_ops_tbl)
+#define NBL_ADAPTER_TO_DISP_OPS_TBL(adapter)	((adapter)->intf.dispatch_ops_tbl)
 
 struct nbl_core {
 	void *phy_mgt;
@@ -52,6 +55,7 @@ struct nbl_interface {
 	struct nbl_phy_ops_tbl *phy_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
 	struct nbl_resource_ops_tbl *resource_ops_tbl;
+	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
 };
 
 struct nbl_adapter {
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
new file mode 100644
index 0000000000..ffeeba3048
--- /dev/null
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -0,0 +1,466 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_dispatch.h"
+
+static int nbl_disp_alloc_txrx_queues(void *priv, u16 vsi_id, u16 queue_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->alloc_txrx_queues(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+					  vsi_id, queue_num);
+}
+
+static int nbl_disp_chan_alloc_txrx_queues_req(void *priv, u16 vsi_id,
+					       u16 queue_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_alloc_txrx_queues param = {0};
+	struct nbl_chan_param_alloc_txrx_queues result = {0};
+	struct nbl_chan_send_info chan_send;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param.vsi_id = vsi_id;
+	param.queue_num = queue_num;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ALLOC_TXRX_QUEUES, &param,
+		      sizeof(param), &result, sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return 0;
+}
+
+static void nbl_disp_free_txrx_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	res_ops->free_txrx_queues(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id);
+}
+
+static void nbl_disp_chan_free_txrx_queues_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_free_txrx_queues param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_FREE_TXRX_QUEUES, &param,
+		      sizeof(param), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_clear_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->clear_queues, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static void nbl_disp_chan_clear_queues_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CLEAR_QUEUE, &vsi_id, sizeof(vsi_id),
+		      NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_start_tx_ring(void *priv,
+				  struct nbl_start_tx_ring_param *param,
+				  u64 *dma_addr)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->start_tx_ring(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				      param, dma_addr);
+}
+
+static void nbl_disp_release_tx_ring(void *priv, u16 queue_idx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->release_tx_ring(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				     queue_idx);
+}
+
+static void nbl_disp_stop_tx_ring(void *priv, u16 queue_idx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->stop_tx_ring(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				     queue_idx);
+}
+
+static int nbl_disp_start_rx_ring(void *priv,
+				  struct nbl_start_rx_ring_param *param,
+				  u64 *dma_addr)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->start_rx_ring(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				      param, dma_addr);
+}
+
+static int nbl_disp_alloc_rx_bufs(void *priv, u16 queue_idx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->alloc_rx_bufs(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				      queue_idx);
+}
+
+static void nbl_disp_release_rx_ring(void *priv, u16 queue_idx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->release_rx_ring(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				     queue_idx);
+}
+
+static void nbl_disp_stop_rx_ring(void *priv, u16 queue_idx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->stop_rx_ring(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				     queue_idx);
+}
+
+static void nbl_disp_update_rx_ring(void *priv, u16 index)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	res_ops->update_rx_ring(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), index);
+}
+
+static int nbl_disp_alloc_rings(void *priv, u16 tx_num, u16 rx_num, u16 queue_offset)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->alloc_rings(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				    tx_num, rx_num, queue_offset);
+}
+
+static void nbl_disp_remove_rings(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	res_ops->remove_rings(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt));
+}
+
+static int
+nbl_disp_setup_queue(void *priv, struct nbl_txrx_queue_param *param, bool is_tx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->setup_queue(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+				    param, is_tx);
+}
+
+static int
+nbl_disp_chan_setup_queue_req(void *priv,
+			      struct nbl_txrx_queue_param *queue_param,
+			      bool is_tx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_setup_queue param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	memcpy(&param.queue_param, queue_param, sizeof(param.queue_param));
+	param.is_tx = is_tx;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SETUP_QUEUE, &param,
+		      sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_remove_all_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	res_ops->remove_all_queues(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id);
+}
+
+static void nbl_disp_chan_remove_all_queues_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_remove_all_queues param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
+		      &param, sizeof(param), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+#define NBL_DISP_OPS_TBL						\
+do {									\
+	NBL_DISP_SET_OPS(alloc_txrx_queues, nbl_disp_alloc_txrx_queues,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_ALLOC_TXRX_QUEUES,		\
+			 nbl_disp_chan_alloc_txrx_queues_req,		\
+			 NULL);						\
+	NBL_DISP_SET_OPS(free_txrx_queues, nbl_disp_free_txrx_queues,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_FREE_TXRX_QUEUES,			\
+			 nbl_disp_chan_free_txrx_queues_req,		\
+			 NULL);						\
+	NBL_DISP_SET_OPS(alloc_rings, nbl_disp_alloc_rings,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(remove_rings, nbl_disp_remove_rings,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(start_tx_ring, nbl_disp_start_tx_ring,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(stop_tx_ring, nbl_disp_stop_tx_ring,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(release_tx_ring, nbl_disp_release_tx_ring,	\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(start_rx_ring, nbl_disp_start_rx_ring,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(alloc_rx_bufs, nbl_disp_alloc_rx_bufs,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(stop_rx_ring, nbl_disp_stop_rx_ring,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(release_rx_ring, nbl_disp_release_rx_ring,	\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(update_rx_ring, nbl_disp_update_rx_ring,	\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(setup_queue, nbl_disp_setup_queue,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_SETUP_QUEUE,			\
+			 nbl_disp_chan_setup_queue_req, NULL);		\
+	NBL_DISP_SET_OPS(remove_all_queues, nbl_disp_remove_all_queues,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REMOVE_ALL_QUEUES,		\
+			 nbl_disp_chan_remove_all_queues_req, NULL);	\
+	NBL_DISP_SET_OPS(clear_queues, nbl_disp_clear_queues,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_CLEAR_QUEUE,			\
+			 nbl_disp_chan_clear_queues_req, NULL);		\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_disp_setup_msg(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_channel_ops *chan_ops;
+	int ret = 0;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+#define NBL_DISP_SET_OPS(disp_op, res_func, ctrl_lvl2, msg_type, msg_req, msg_resp)		\
+do {												\
+	typeof(msg_type) _msg_type = (msg_type);						\
+	typeof(msg_resp) _msg_resp = (msg_resp);						\
+	uint32_t _ctrl_lvl = rte_bit_relaxed_get32(ctrl_lvl2, &disp_mgt->ctrl_lvl);		\
+	if (_msg_type >= 0 && _msg_resp != NULL && _ctrl_lvl)					\
+		ret += chan_ops->register_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),		\
+					      _msg_type, _msg_resp, disp_mgt);			\
+} while (0)
+	NBL_DISP_OPS_TBL;
+#undef  NBL_DISP_SET_OPS
+
+	return ret;
+}
+
+/* Ctrl lvl means that if a certain level is set, then all disp_ops that decleared this lvl
+ * will go directly to res_ops, rather than send a channel msg, and vice versa.
+ */
+static int nbl_disp_setup_ctrl_lvl(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
+{
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_DISP_MGT_TO_DISP_OPS(disp_mgt);
+
+	rte_bit_relaxed_set32(lvl, &disp_mgt->ctrl_lvl);
+
+#define NBL_DISP_SET_OPS(disp_op, res_func, ctrl, msg_type, msg_req, msg_resp)		\
+do {											\
+	disp_ops->NBL_NAME(disp_op) =							\
+		rte_bit_relaxed_get32(ctrl, &disp_mgt->ctrl_lvl) ? res_func : msg_req; ;\
+} while (0)
+	NBL_DISP_OPS_TBL;
+#undef  NBL_DISP_SET_OPS
+
+	return 0;
+}
+
+static int nbl_disp_setup_disp_mgt(struct nbl_dispatch_mgt **disp_mgt)
+{
+	*disp_mgt = rte_zmalloc("nbl_disp_mgt", sizeof(struct nbl_dispatch_mgt), 0);
+	if (!*disp_mgt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_disp_remove_disp_mgt(struct nbl_dispatch_mgt **disp_mgt)
+{
+	rte_free(*disp_mgt);
+	*disp_mgt = NULL;
+}
+
+static void nbl_disp_remove_ops(struct nbl_dispatch_ops_tbl **disp_ops_tbl)
+{
+	rte_free(NBL_DISP_OPS_TBL_TO_OPS(*disp_ops_tbl));
+	rte_free(*disp_ops_tbl);
+	*disp_ops_tbl = NULL;
+}
+
+static int nbl_disp_setup_ops(struct nbl_dispatch_ops_tbl **disp_ops_tbl,
+			      struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops;
+
+	*disp_ops_tbl = rte_zmalloc("nbl_disp_ops_tbl", sizeof(struct nbl_dispatch_ops_tbl), 0);
+	if (!*disp_ops_tbl)
+		return -ENOMEM;
+
+	disp_ops = rte_zmalloc("nbl_dispatch_ops", sizeof(struct nbl_dispatch_ops), 0);
+	if (!disp_ops) {
+		rte_free(*disp_ops_tbl);
+		return -ENOMEM;
+	}
+
+	NBL_DISP_OPS_TBL_TO_OPS(*disp_ops_tbl) = disp_ops;
+	NBL_DISP_OPS_TBL_TO_PRIV(*disp_ops_tbl) = disp_mgt;
+
+	return 0;
+}
+
+int nbl_disp_init(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dispatch_mgt **disp_mgt;
+	struct nbl_dispatch_ops_tbl **disp_ops_tbl;
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_product_dispatch_ops *disp_product_ops = NULL;
+	int ret = 0;
+
+	disp_mgt = (struct nbl_dispatch_mgt **)&NBL_ADAPTER_TO_DISP_MGT(adapter);
+	disp_ops_tbl = &NBL_ADAPTER_TO_DISP_OPS_TBL(adapter);
+	res_ops_tbl = NBL_ADAPTER_TO_RES_OPS_TBL(adapter);
+	chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
+	disp_product_ops = nbl_dispatch_get_product_ops(adapter->caps.product_type);
+
+	ret = nbl_disp_setup_disp_mgt(disp_mgt);
+	if (ret)
+		return ret;
+
+	ret = nbl_disp_setup_ops(disp_ops_tbl, *disp_mgt);
+	if (ret)
+		goto setup_ops_fail;
+
+	NBL_DISP_MGT_TO_RES_OPS_TBL(*disp_mgt) = res_ops_tbl;
+	NBL_DISP_MGT_TO_CHAN_OPS_TBL(*disp_mgt) = chan_ops_tbl;
+	NBL_DISP_MGT_TO_DISP_OPS_TBL(*disp_mgt) = *disp_ops_tbl;
+
+	if (disp_product_ops->dispatch_init) {
+		ret = disp_product_ops->dispatch_init(*disp_mgt);
+		if (ret)
+			goto dispatch_init_fail;
+	}
+
+	ret = nbl_disp_setup_ctrl_lvl(*disp_mgt, NBL_DISP_CTRL_LVL_ALWAYS);
+	if (ret)
+		goto setup_ctrl_lvl_fail;
+	return 0;
+
+setup_ctrl_lvl_fail:
+	disp_product_ops->dispatch_uninit(*disp_mgt);
+dispatch_init_fail:
+	nbl_disp_remove_ops(disp_ops_tbl);
+setup_ops_fail:
+	nbl_disp_remove_disp_mgt(disp_mgt);
+
+	return ret;
+}
+
+void nbl_disp_remove(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dispatch_mgt **disp_mgt;
+	struct nbl_dispatch_ops_tbl **disp_ops_tbl;
+
+	disp_mgt = (struct nbl_dispatch_mgt **)&NBL_ADAPTER_TO_DISP_MGT(adapter);
+	disp_ops_tbl = &NBL_ADAPTER_TO_DISP_OPS_TBL(adapter);
+
+	nbl_disp_remove_ops(disp_ops_tbl);
+	nbl_disp_remove_disp_mgt(disp_mgt);
+}
+
+static int nbl_disp_leonis_init(void *p)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)p;
+	int ret;
+
+	nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
+	ret = nbl_disp_setup_msg(disp_mgt);
+
+	return ret;
+}
+
+static int nbl_disp_leonis_uninit(void *p)
+{
+	RTE_SET_USED(p);
+	return 0;
+}
+
+static struct nbl_product_dispatch_ops nbl_product_dispatch_ops[NBL_PRODUCT_MAX] = {
+	{
+		.dispatch_init		= nbl_disp_leonis_init,
+		.dispatch_uninit	= nbl_disp_leonis_uninit,
+	},
+};
+
+struct nbl_product_dispatch_ops *nbl_dispatch_get_product_ops(enum nbl_product_type product_type)
+{
+	return &nbl_product_dispatch_ops[product_type];
+}
diff --git a/drivers/net/nbl/nbl_dispatch.h b/drivers/net/nbl/nbl_dispatch.h
new file mode 100644
index 0000000000..dcdf87576a
--- /dev/null
+++ b/drivers/net/nbl/nbl_dispatch.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DISPATCH_H_
+#define _NBL_DISPATCH_H_
+
+#include "nbl_ethdev.h"
+
+#define NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)	((disp_mgt)->res_ops_tbl)
+#define NBL_DISP_MGT_TO_RES_OPS(disp_mgt)	(NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)	(NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)->priv)
+#define NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)	((disp_mgt)->chan_ops_tbl)
+#define NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt)	(NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt)	(NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)->priv)
+#define NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)	((disp_mgt)->disp_ops_tbl)
+#define NBL_DISP_MGT_TO_DISP_OPS(disp_mgt)	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_DISP_PRIV(disp_mgt)	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->priv)
+
+struct nbl_dispatch_mgt {
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	uint32_t ctrl_lvl;
+};
+
+struct nbl_product_dispatch_ops *nbl_dispatch_get_product_ops(enum nbl_product_type product_type);
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index faf5d3ed3d..25d54a435d 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -281,6 +281,24 @@ enum nbl_chan_msg_type {
 	NBL_CHAN_MSG_MAX,
 };
 
+struct nbl_chan_param_alloc_txrx_queues {
+	u16 vsi_id;
+	u16 queue_num;
+};
+
+struct nbl_chan_param_free_txrx_queues {
+	u16 vsi_id;
+};
+
+struct nbl_chan_param_setup_queue {
+	struct nbl_txrx_queue_param queue_param;
+	bool is_tx;
+};
+
+struct nbl_chan_param_remove_all_queues {
+	u16 vsi_id;
+};
+
 struct nbl_chan_send_info {
 	uint16_t dstid;
 	uint16_t msg_type;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index 0bfc6a233b..fb2ccb28bf 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -13,6 +13,10 @@
 #  define NBL_PRIU64		"llu"
 # endif
 
+#define NBL_OPS_CALL(func, para)	\
+	({ typeof(func) _func = (func);	\
+	 (!_func) ? 0 : _func para; })
+
 struct nbl_dma_mem {
 	void *va;
 	uint64_t pa;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
new file mode 100644
index 0000000000..01193820ce
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_DISPATCH_H_
+#define _NBL_DEF_DISPATCH_H_
+
+#include "nbl_include.h"
+
+#define NBL_DISP_OPS_TBL_TO_OPS(disp_ops_tbl)	((disp_ops_tbl)->ops)
+#define NBL_DISP_OPS_TBL_TO_PRIV(disp_ops_tbl)	((disp_ops_tbl)->priv)
+
+enum {
+	NBL_DISP_CTRL_LVL_NEVER = 0,
+	NBL_DISP_CTRL_LVL_MGT,
+	NBL_DISP_CTRL_LVL_NET,
+	NBL_DISP_CTRL_LVL_ALWAYS,
+	NBL_DISP_CTRL_LVL_MAX,
+};
+
+struct nbl_dispatch_ops {
+	int (*add_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
+	int (*get_mac_addr)(void *priv, u8 *mac);
+	void (*del_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
+	int (*add_multi_rule)(void *priv, u16 vsi);
+	void (*del_multi_rule)(void *priv, u16 vsi);
+	int (*cfg_multi_mcast)(void *priv, u16 vsi, u16 enable);
+	void (*clear_flow)(void *priv, u16 vsi_id);
+	void (*get_firmware_version)(void *priv, char *firmware_version, u8 max_len);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	int (*alloc_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
+	void (*free_txrx_queues)(void *priv, u16 vsi_id);
+	u16 (*get_vsi_id)(void *priv);
+	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id);
+	int (*setup_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
+	void (*remove_txrx_queues)(void *priv, u16 vsi_id);
+	int (*alloc_rings)(void *priv, u16 tx_num, u16 rx_num, u16 queue_offset);
+	void (*remove_rings)(void *priv);
+	int (*start_tx_ring)(void *priv, struct nbl_start_tx_ring_param *param, u64 *dma_addr);
+	void (*stop_tx_ring)(void *priv, u16 queue_idx);
+	void (*release_tx_ring)(void *priv, u16 queue_idx);
+	int (*start_rx_ring)(void *priv, struct nbl_start_rx_ring_param *param, u64 *dma_addr);
+	int (*alloc_rx_bufs)(void *priv, u16 queue_idx);
+	void (*stop_rx_ring)(void *priv, u16 queue_idx);
+	void (*release_rx_ring)(void *priv, u16 queue_idx);
+	void (*update_rx_ring)(void *priv, u16 index);
+	u16 (*get_tx_ehdr_len)(void *priv);
+	void (*cfg_txrx_vlan)(void *priv, u16 vlan_tci, u16 vlan_proto);
+	int (*setup_queue)(void *priv, struct nbl_txrx_queue_param *param, bool is_tx);
+	void (*remove_all_queues)(void *priv, u16 vsi_id);
+	int (*register_vsi2q)(void *priv, u16 vsi_index, u16 vsi_id,
+			      u16 queue_offset, u16 queue_num);
+	int (*setup_q2vsi)(void *priv, u16 vsi_id);
+	void (*remove_q2vsi)(void *priv, u16 vsi_id);
+	int (*setup_rss)(void *priv, u16 vsi_id);
+	void (*remove_rss)(void *priv, u16 vsi_id);
+	int (*cfg_dsch)(void *priv, u16 vsi_id, bool vld);
+	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps);
+	void (*remove_cqs)(void *priv, u16 vsi_id);
+	int (*set_rxfh_indir)(void *priv, u16 vsi_id, u32 *indir, u32 indir_size);
+	void (*clear_queues)(void *priv, u16 vsi_id);
+	u16 (*xmit_pkts)(void *priv, void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts);
+	u16 (*recv_pkts)(void *priv, void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts);
+	u16 (*get_vsi_global_qid)(void *priv, u16 vsi_id, u16 local_qid);
+
+	void (*dummy_func)(void *priv);
+};
+
+struct nbl_dispatch_ops_tbl {
+	struct nbl_dispatch_ops *ops;
+	void *priv;
+};
+
+int nbl_disp_init(void *p);
+void nbl_disp_remove(void *p);
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index c1cf041c74..43302df842 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -25,6 +25,11 @@ struct nbl_resource_ops {
 	int (*reset_stats)(void *priv);
 	void (*update_rx_ring)(void *priv, u16 queue_idx);
 	u16 (*get_tx_ehdr_len)(void *priv);
+	int (*alloc_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
+	void (*free_txrx_queues)(void *priv, u16 vsi_id);
+	void (*clear_queues)(void *priv, u16 vsi_id);
+	int (*setup_queue)(void *priv, struct nbl_txrx_queue_param *param, bool is_tx);
+	void (*remove_all_queues)(void *priv, u16 vsi_id);
 	u64 (*restore_abnormal_ring)(void *priv, u16 local_queue_id, int type);
 	int (*restart_abnormal_ring)(void *priv, int ring_index, int type);
 	void (*cfg_txrx_vlan)(void *priv, u16 vlan_tci, u16 vlan_proto);
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 0eae45ecf1..45b39b1854 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -83,4 +83,21 @@ struct nbl_start_tx_ring_param {
 	const struct rte_eth_txconf *conf;
 };
 
+struct nbl_txrx_queue_param {
+	u16 vsi_id;
+	u64 dma;
+	u64 avail;
+	u64 used;
+	u16 desc_num;
+	u16 local_queue_id;
+	u16 intr_en;
+	u16 intr_mask;
+	u16 global_vector_id;
+	u16 half_offload_en;
+	u16 split;
+	u16 extend_header;
+	u16 cxt;
+	u16 rxcsum;
+};
+
 #endif
-- 
2.34.1

