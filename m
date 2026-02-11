Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4124FEB594B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 02:41:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1465A402E2;
	Wed, 11 Feb 2026 03:41:40 +0100 (CET)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com
 [115.124.28.123])
 by mails.dpdk.org (Postfix) with ESMTP id 393B34003C
 for <dev@dpdk.org>; Wed, 11 Feb 2026 03:41:35 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gUSwv9j_1770777693 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 11 Feb 2026 10:41:33 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: add igb_uio support for NBL VF devices
Date: Tue, 10 Feb 2026 18:40:29 -0800
Message-Id: <20260211024029.33810-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
References: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
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

Due to chip design limitations, only VF support
the igb_uio driver. PF are not compatible.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_core.c                    |  5 ++
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 28 +++++++++--
 drivers/net/nbl/nbl_dev/nbl_dev.h             |  3 ++
 drivers/net/nbl/nbl_dispatch.c                | 49 +++++++++++++++++++
 drivers/net/nbl/nbl_ethdev.c                  | 13 +++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c | 14 ++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h |  9 ++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c | 10 ++++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  5 ++
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |  3 ++
 drivers/net/nbl/nbl_include/nbl_def_hw.h      |  3 ++
 .../net/nbl/nbl_include/nbl_def_resource.h    |  3 ++
 12 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index 313f8c5bd6..8ca3d184cf 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -41,6 +41,11 @@ int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
 	common->eth_dev = eth_dev;
 	nbl_init_func_caps(pci_dev, &adapter->caps);
 
+	if (pci_dev->id.device_id ==  NBL_DEVICE_ID_M18100_VF)
+		common->is_vf = true;
+	else
+		common->is_vf = false;
+
 	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
 
 	/* every product's hw/chan/res layer has a great difference, so call their own init ops */
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 2b0413fb7c..ad06eee3d8 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -857,8 +857,12 @@ static void nbl_dev_mailbox_interrupt_handler(void *cn_arg)
 {
 	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)cn_arg;
 	const struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
 
 	chan_ops->notify_interrupt(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt));
+
+	if (net_dev->net_msix_mask_en)
+		rte_write32(net_dev->irq_data, net_dev->irq_enable_base);
 }
 
 static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
@@ -873,6 +877,7 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 	u8 *mac;
 	int ret;
 	u16 priv_cnt = 0;
+	u16 global_vector_id = 0;
 
 	board_info = &common->board_info;
 	disp_ops->get_board_info(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), board_info);
@@ -881,9 +886,22 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 	disp_ops->clear_flow(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
 
 	if (NBL_IS_NOT_COEXISTENCE(common)) {
-		ret = disp_ops->configure_msix_map(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), 0, 1, 0);
-		if (ret)
-			goto configure_msix_map_failed;
+		if (pci_dev->kdrv == RTE_PCI_KDRV_VFIO) {
+			ret = disp_ops->configure_msix_map(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+							   0, 1, 0);
+			if (ret)
+				goto configure_msix_map_failed;
+		} else {
+			ret = disp_ops->get_global_vector(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+							  net_dev->vsi_id, 0, &global_vector_id);
+			if (ret)
+				goto get_global_vector_failed;
+			net_dev->irq_enable_base =
+			disp_ops->get_msix_irq_enable_info(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+							   global_vector_id, &net_dev->irq_data);
+			net_dev->net_msix_mask_en = true;
+			rte_write32(net_dev->irq_data, net_dev->irq_enable_base);
+		}
 
 		ret = disp_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), 0, true);
 		if (ret)
@@ -960,7 +978,9 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 	}
 enable_mailbox_irq_failed:
 	if (NBL_IS_NOT_COEXISTENCE(common))
-		disp_ops->destroy_msix_map(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+		if (pci_dev->kdrv == RTE_PCI_KDRV_VFIO)
+			disp_ops->destroy_msix_map(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+get_global_vector_failed:
 configure_msix_map_failed:
 	return ret;
 }
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index bfe2b06deb..230a983cf4 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -62,6 +62,9 @@ struct nbl_dev_net_mgt {
 	bool hw_stats_inited;
 	rte_thread_t tid;
 	int fd[2];
+	bool net_msix_mask_en;
+	u8 *irq_enable_base;
+	u32 irq_data;
 };
 
 struct nbl_dev_mgt {
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index 52d37ba7fe..d2b55c0c25 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -80,6 +80,49 @@ static int nbl_disp_chan_enable_mailbox_irq_req(void *priv, u16 vector_id, bool
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
+static int nbl_disp_get_global_vector(void *priv, u16 vsi_id,
+				      u16 local_vector_id, u16 *global_vector_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	u16 ret = 0;
+
+	ret = NBL_OPS_CALL(res_ops->get_global_vector,
+			   (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+			    vsi_id, local_vector_id, global_vector_id));
+	return ret;
+}
+
+static int nbl_disp_chan_get_global_vector_req(void *priv, u16 vsi_id,
+					       u16 local_vector_id, u16 *global_vector_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_get_global_vector param = {0};
+	struct nbl_chan_param_get_global_vector result = {0};
+	struct nbl_chan_send_info chan_send;
+	int ret;
+
+	param.vsi_id = vsi_id;
+	param.vector_id = local_vector_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_GLOBAL_VECTOR,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	ret = chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+	*global_vector_id = result.vector_id;
+
+	return ret;
+}
+
+static u8 *nbl_disp_get_msix_irq_enable_info(void *priv, u16 global_vector_id, u32 *irq_data)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->get_msix_irq_enable_info,
+			    (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), global_vector_id, irq_data));
+}
+
 static int nbl_disp_alloc_txrx_queues(void *priv, u16 vsi_id, u16 queue_num)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
@@ -1035,6 +1078,12 @@ do {									\
 			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,		\
 			 nbl_disp_chan_enable_mailbox_irq_req,					\
 			 NULL);				\
+	NBL_DISP_SET_OPS(get_global_vector, nbl_disp_get_global_vector,				\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_GLOBAL_VECTOR,			\
+			 nbl_disp_chan_get_global_vector_req, NULL);				\
+	NBL_DISP_SET_OPS(get_msix_irq_enable_info, nbl_disp_get_msix_irq_enable_info,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,						\
+			 NULL, NULL);								\
 	NBL_DISP_SET_OPS(alloc_txrx_queues, nbl_disp_alloc_txrx_queues,	\
 			 NBL_DISP_CTRL_LVL_MGT,				\
 			 NBL_CHAN_MSG_ALLOC_TXRX_QUEUES,		\
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index d269ea8058..f73808d877 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -88,6 +88,19 @@ static int nbl_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		NBL_LOG(ERR, "Secondary process is not supported.");
 		return -ENOTSUP;
 	}
+
+	if (pci_dev->kdrv == RTE_PCI_KDRV_UIO_GENERIC) {
+		NBL_LOG(ERR, "uio_pci_generic is not supported.");
+		return -ENOTSUP;
+	}
+
+	if (pci_dev->kdrv == RTE_PCI_KDRV_IGB_UIO) {
+		if (pci_dev->id.device_id !=  NBL_DEVICE_ID_M18100_VF) {
+			NBL_LOG(ERR, "Only VF support igb_uio.");
+			return -ENOTSUP;
+		}
+	}
+
 	return rte_eth_dev_pci_generic_probe(pci_dev, sizeof(struct nbl_adapter),
 					     nbl_eth_dev_init);
 }
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
index 9e89a3be5f..a6fd60dfd7 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
@@ -138,6 +138,17 @@ static void nbl_hw_update_mailbox_queue_tail_ptr(void *priv, u16 tail_ptr, u8 tx
 	rte_delay_us(NBL_NOTIFY_DELAY_MIN_TIME_FOR_REGS);
 }
 
+static u8 *nbl_phy_get_msix_irq_enable_info(void *priv, u16 global_vector_id, u32 *irq_data)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_msix_notify msix_notify = { 0 };
+
+	msix_notify.glb_msix_idx = global_vector_id;
+	memcpy(irq_data, &msix_notify, sizeof(msix_notify));
+
+	return (hw_mgt->hw_addr + NBL_PCOMPLETER_MSIX_NOTIRY_OFFSET);
+}
+
 const struct nbl_hw_ops nbl_hw_ops = {
 	.update_tail_ptr		= nbl_hw_update_tail_ptr,
 	.get_tail_ptr			= nbl_hw_get_tail_ptr,
@@ -149,6 +160,9 @@ const struct nbl_hw_ops nbl_hw_ops = {
 	.stop_mailbox_txq		= nbl_hw_stop_mailbox_txq,
 	.get_mailbox_rx_tail_ptr	= nbl_hw_get_mailbox_rx_tail_ptr,
 	.update_mailbox_queue_tail_ptr	= nbl_hw_update_mailbox_queue_tail_ptr,
+
+	/* irq */
+	.get_msix_irq_enable_info	= nbl_phy_get_msix_irq_enable_info,
 };
 
 static int nbl_hw_setup_ops(struct nbl_hw_ops_tbl **hw_ops_tbl,
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
index fc276e83d6..ae9800a285 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
@@ -50,4 +50,13 @@ struct nbl_mailbox_qinfo_cfg_dbg_tbl {
 	u16 tx_tail_ptr;
 };
 
+#define NBL_PCOMPLETER_MSIX_NOTIRY_OFFSET	(0x1020)
+
+struct nbl_msix_notify {
+	u32 glb_msix_idx:13;
+	u32 rsv1:3;
+	u32 mask:1;
+	u32 rsv2:15;
+};
+
 #endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
index 5d40d4f5f8..189f8feb56 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
@@ -115,9 +115,19 @@ static int nbl_get_xstats_names(__rte_unused void *priv,
 	return 0;
 }
 
+static u8 *nbl_res_get_msix_irq_enable_info(void *priv, u16 global_vector_id, u32 *irq_data)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	const struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	return hw_ops->get_msix_irq_enable_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						global_vector_id, irq_data);
+}
+
 static struct nbl_resource_ops nbl_res_ops = {
 	.get_hw_xstats_cnt = nbl_get_xstats_cnt,
 	.get_hw_xstats_names = nbl_get_xstats_names,
+	.get_msix_irq_enable_info = nbl_res_get_msix_irq_enable_info,
 };
 
 static bool is_ops_inited;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 55880737f1..d31e3bc772 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -314,6 +314,11 @@ struct nbl_chan_param_enable_mailbox_irq {
 	bool enable_msix;
 };
 
+struct nbl_chan_param_get_global_vector {
+	u16 vsi_id;
+	u16 vector_id;
+};
+
 struct nbl_chan_param_register_net_info {
 	u16 pf_bdf;
 	u64 vf_bar_start;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
index 45e7504a07..01d0967727 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -23,6 +23,9 @@ struct nbl_dispatch_ops {
 				  bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv);
 	int (*enable_mailbox_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*get_global_vector)(void *priv, u16 vsi_id,
+				 u16 local_vector_id, u16 *global_vector_id);
+	u8* (*get_msix_irq_enable_info)(void *priv, u16 global_vector_id, u32 *irq_data);
 	void (*get_resource_pt_ops)(void *priv, struct nbl_resource_pt_ops *pt_ops, bool offload);
 	int (*register_net)(void *priv,
 			    struct nbl_register_net_param *register_param,
diff --git a/drivers/net/nbl/nbl_include/nbl_def_hw.h b/drivers/net/nbl/nbl_include/nbl_def_hw.h
index 285ca98570..e9836e0120 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_hw.h
@@ -22,6 +22,9 @@ struct nbl_hw_ops {
 	void (*stop_mailbox_txq)(void *priv);
 	uint16_t (*get_mailbox_rx_tail_ptr)(void *priv);
 	void (*update_mailbox_queue_tail_ptr)(void *priv, uint16_t tail_ptr, uint8_t txrx);
+
+	/* irq */
+	u8* (*get_msix_irq_enable_info)(void *priv, u16 global_vector_id, u32 *irq_data);
 };
 
 struct nbl_hw_ops_tbl {
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index 6935598789..3e6bb58f26 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -21,6 +21,9 @@ struct nbl_resource_ops {
 				  bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv, u16 func_id);
 	int (*enable_mailbox_irq)(void *priv, u16 func_id, u16 vector_id, bool enable_msix);
+	int (*get_global_vector)(void *priv, u16 vsi_id,
+				 u16 local_vector_id, u16 *global_vector_id);
+	u8* (*get_msix_irq_enable_info)(void *priv, u16 global_vector_id, u32 *irq_data);
 	void (*get_resource_pt_ops)(void *priv, struct nbl_resource_pt_ops *pt_ops, bool offload);
 	int (*register_net)(void *priv,
 			    struct nbl_register_net_param *register_param,
-- 
2.34.1

