Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994CCCD4F54
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B450B40A81;
	Sun, 24 May 2026 11:33:26 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id B97A4402EE
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S13;
 Sun, 24 May 2026 17:33:07 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 11/23] net/sxe2: add support for VF representors
Date: Sun, 24 May 2026 17:32:47 +0800
Message-ID: <20260524093259.397506-12-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S13
X-Coremail-Antispam: 1UD129KBjvAXoWkGF4DWFyrCry7KF1UCryUKFg_yoWDWFWrXo
 WxWrsrXF1fG34Ik3y8ZF1xCFWUA3y8Wws8Ja1fuF1DuanxGa45KF4UKw45Z3WqgFs5tF90
 9wn2ya97tFsrJFWrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYb7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0x7Aq67IIx4CEVc8vx2IErcIFxwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
 0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1l
 IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Add support for VF representors in sxe2 PMD. This allows the host
application (e.g., OVS-DPDK) to control and monitor virtual functions
through a dedicated ethdev on the PF (Physical Function) side.

Key changes include:
- Added representor enumeration and identification logic.
- Implemented representor-specific dev_ops (link update, stats, etc.).
- Configured back-channel communication between PF and VF for control
  messages.
- Supported the "-a <DBDF>,representor=[0-N]" EAL parameter to
  instantiate representor ports.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_common.c          |   46 +
 drivers/common/sxe2/sxe2_common.h          |    2 +
 drivers/net/sxe2/meson.build               |    8 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c           |  311 +++-
 drivers/net/sxe2/sxe2_cmd_chnl.h           |   28 +
 drivers/net/sxe2/sxe2_drv_cmd.h            |  280 +--
 drivers/net/sxe2/sxe2_ethdev.c             |  201 ++-
 drivers/net/sxe2/sxe2_ethdev.h             |   11 +
 drivers/net/sxe2/sxe2_ethdev_repr.c        |  607 +++++++
 drivers/net/sxe2/sxe2_ethdev_repr.h        |   32 +
 drivers/net/sxe2/sxe2_filter.c             |  121 +-
 drivers/net/sxe2/sxe2_filter.h             |    2 +
 drivers/net/sxe2/sxe2_flow.c               | 1337 ++++++++++++++
 drivers/net/sxe2/sxe2_flow.h               |   29 +
 drivers/net/sxe2/sxe2_flow_parse_action.c  | 1182 +++++++++++++
 drivers/net/sxe2/sxe2_flow_parse_action.h  |   23 +
 drivers/net/sxe2/sxe2_flow_parse_engine.c  |  106 ++
 drivers/net/sxe2/sxe2_flow_parse_engine.h  |   13 +
 drivers/net/sxe2/sxe2_flow_parse_pattern.c | 1822 ++++++++++++++++++++
 drivers/net/sxe2/sxe2_flow_parse_pattern.h |   40 +
 drivers/net/sxe2/sxe2_irq.c                |   54 +
 drivers/net/sxe2/sxe2_irq.h                |    4 +
 drivers/net/sxe2/sxe2_queue.c              |    6 +-
 drivers/net/sxe2/sxe2_stats.c              |   17 +-
 drivers/net/sxe2/sxe2_switchdev.c          |  332 ++++
 drivers/net/sxe2/sxe2_switchdev.h          |   33 +
 drivers/net/sxe2/sxe2_txrx.c               |    7 +
 drivers/net/sxe2/sxe2_txrx_poll.c          |    8 +
 drivers/net/sxe2/sxe2_vsi.c                |  146 ++
 drivers/net/sxe2/sxe2_vsi.h                |   12 +-
 30 files changed, 6684 insertions(+), 136 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.c
 create mode 100644 drivers/net/sxe2/sxe2_ethdev_repr.h
 create mode 100644 drivers/net/sxe2/sxe2_flow.c
 create mode 100644 drivers/net/sxe2/sxe2_flow.h
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.c
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_action.h
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.c
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_engine.h
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.c
 create mode 100644 drivers/net/sxe2/sxe2_flow_parse_pattern.h
 create mode 100644 drivers/net/sxe2/sxe2_switchdev.c
 create mode 100644 drivers/net/sxe2/sxe2_switchdev.h

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index f34427c569..a5d36998e1 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -169,6 +169,37 @@ static int32_t sxe2_parse_class_type(const char *key, const char *value, void *a
 	return ret;
 }
 
+static int32_t sxe2_parse_driver(const char *key, const char *value, void *args)
+{
+	int32_t ret = -EINVAL;
+
+	if (value == NULL || args == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+
+	if (strcmp(value, "sxe2") != 0) {
+		PMD_LOG_ERR(COM, "%s: \"%s\" is not a valid driver.",
+			key, value);
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_parse_representor(const char *key, const char *value, void *args)
+{
+	int32_t ret = 0;
+
+	if (value == NULL || args == NULL)
+		goto l_end;
+
+	PMD_LOG_INFO(COM, "representor arg %s: \"%s\".", key, value);
+
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_common_device_setup(struct sxe2_common_device *cdev)
 {
 	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
@@ -394,6 +425,21 @@ static int32_t sxe2_common_pci_probe(struct rte_pci_driver *pci_drv __rte_unused
 			goto l_free_args;
 		}
 
+		ret = sxe2_kvargs_process(kv_info_p, SXE2_DEVARGS_KEY_DRIVER,
+				sxe2_parse_driver, NULL);
+		if (ret < 0) {
+			PMD_LOG_ERR(COM, "Unsupported sxe2 driver name: %s",
+				rte_dev->devargs->args);
+			goto l_free_args;
+		}
+
+		ret = sxe2_kvargs_process(kv_info_p, SXE2_DEVARGS_KEY_REPR,
+				sxe2_parse_representor, NULL);
+		if (ret < 0) {
+			PMD_LOG_ERR(COM, "Unsupported sxe2 driver representor: %s",
+				rte_dev->devargs->args);
+			goto l_free_args;
+		}
 	}
 
 	cdev = sxe2_common_device_alloc(rte_dev, class_type);
diff --git a/drivers/common/sxe2/sxe2_common.h b/drivers/common/sxe2/sxe2_common.h
index 5fe218db99..23cffac581 100644
--- a/drivers/common/sxe2/sxe2_common.h
+++ b/drivers/common/sxe2/sxe2_common.h
@@ -18,6 +18,8 @@
 	((cdev)->config.cmd_fd)
 
 #define SXE2_DEVARGS_KEY_CLASS "class"
+#define SXE2_DEVARGS_KEY_DRIVER "driver"
+#define SXE2_DEVARGS_KEY_REPR "representor"
 
 struct sxe2_class_driver;
 
diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 0658b2ee3a..61925ee80f 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -71,6 +71,12 @@ sources += files(
         'sxe2_mp.c',
         'sxe2_stats.c',
         'sxe2_irq.c',
+        'sxe2_switchdev.c',
+        'sxe2_ethdev_repr.c',
+        'sxe2_flow.c',
+        'sxe2_flow_parse_action.c',
+        'sxe2_flow_parse_pattern.c',
+        'sxe2_flow_parse_engine.c',
 )
 
-allow_internal_get_api = true
\ No newline at end of file
+allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index d1f15084ed..6e2dd139a5 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -64,6 +64,23 @@ int32_t sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter, struct sxe2_drv_dev_
 	return ret;
 }
 
+int32_t sxe2_drv_switchdev_info_get(struct sxe2_adapter *adapter,
+				    struct sxe2_switchdev_info *switchdev_info)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_DEV_GET_SWITCHDEV_INFO,
+				 NULL, 0, switchdev_info,
+				 sizeof(struct sxe2_switchdev_info));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "get switchdev info failed, ret=%d", ret);
+
+	return ret;
+}
+
 int32_t sxe2_drv_dev_info_get(struct sxe2_adapter *adapter,
 				struct sxe2_drv_dev_info_resp *dev_info_resp)
 {
@@ -167,7 +184,11 @@ static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
 	req->q_cnt = rxq_cnt;
 	req->max_frame_size = dev_data->mtu + SXE2_ETH_OVERHEAD;
 
-	ctxt->queue_id = rxq->queue_id;
+	if (adapter->is_dev_repr)
+		ctxt->queue_id = adapter->repr_priv_data->repr_q_id;
+	else
+		ctxt->queue_id = rxq->queue_id;
+
 	ctxt->depth = rxq->ring_depth;
 	ctxt->buf_len = RTE_ALIGN(rxq->rx_buf_len, SXE2_RXQ_CTXT_CFG_BUF_LEN_ALIGN);
 	ctxt->dma_addr = rxq->base_addr;
@@ -241,7 +262,10 @@ static void sxe2_txq_ctxt_cfg_fill(struct sxe2_tx_queue *txq,
 		ctxt = &req->cfg[q_idx];
 		ctxt->depth = txq[q_idx].ring_depth;
 		ctxt->dma_addr = txq[q_idx].base_addr;
-		ctxt->queue_id = txq[q_idx].queue_id;
+		if (adapter->is_dev_repr)
+			ctxt->queue_id = adapter->repr_priv_data->repr_q_id;
+		else
+			ctxt->queue_id = txq[q_idx].queue_id;
 
 		ctxt->sched_mode = sxe2_sched_mode_get(adapter);
 	}
@@ -288,7 +312,10 @@ int32_t sxe2_drv_rxq_switch(struct sxe2_adapter *adapter, struct sxe2_rx_queue *
 	struct sxe2_drv_q_switch_req req;
 
 	req.vsi_id = rte_cpu_to_le_16(rxq->vsi->vsi_id);
-	req.q_idx = rxq->queue_id;
+	if (adapter->is_dev_repr)
+		req.q_idx = adapter->repr_priv_data->repr_q_id;
+	else
+		req.q_idx = rxq->queue_id;
 
 	req.is_enable  = (uint8_t)enable;
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_RXQ_DISABLE,
@@ -310,7 +337,10 @@ int32_t sxe2_drv_txq_switch(struct sxe2_adapter *adapter, struct sxe2_tx_queue *
 	struct sxe2_drv_q_switch_req req;
 
 	req.vsi_id = rte_cpu_to_le_16(txq->vsi->vsi_id);
-	req.q_idx = txq->queue_id;
+	if (adapter->is_dev_repr)
+		req.q_idx = adapter->repr_priv_data->repr_q_id;
+	else
+		req.q_idx = txq->queue_id;
 
 	req.is_enable  = (uint8_t)enable;
 	req.sched_mode = sxe2_sched_mode_get(adapter);
@@ -326,6 +356,37 @@ int32_t sxe2_drv_txq_switch(struct sxe2_adapter *adapter, struct sxe2_tx_queue *
 	return ret;
 }
 
+int32_t sxe2_drv_vsi_info_get(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_vsi_info_get_req vsi_info_get_req = {0};
+	struct sxe2_drv_vsi_info_get_resp vsi_info_get_resp = {0};
+
+	vsi_info_get_req.vsi_id = vsi->vsi_id;
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VSI_INFO_GET,
+			&vsi_info_get_req, sizeof(vsi_info_get_req),
+			&vsi_info_get_resp, sizeof(vsi_info_get_resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "switchdev cpvsi info get failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	vsi->txqs.q_cnt = vsi_info_get_resp.used_queues.queues_cnt;
+	vsi->txqs.base_idx_in_func = vsi_info_get_resp.used_queues.base_idx_in_pf;
+
+	vsi->rxqs.q_cnt = vsi_info_get_resp.used_queues.queues_cnt;
+	vsi->rxqs.base_idx_in_func = vsi_info_get_resp.used_queues.base_idx_in_pf;
+
+	vsi->irqs.avail_cnt = vsi_info_get_resp.used_msix.msix_vectors_cnt;
+	vsi->irqs.base_idx_in_pf = vsi_info_get_resp.used_msix.base_idx_in_func;
+
+l_end:
+	return ret;
+}
+
 int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
 {
 	int32_t ret = 0;
@@ -614,6 +675,101 @@ int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set)
 	return ret;
 }
 
+int32_t sxe2_drv_switchdev_uplink_config(struct sxe2_adapter *adapter,  bool set)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_switchdev_uplink_info switchdev_uplink_info_req = {0};
+
+	switchdev_uplink_info_req.pf_id = adapter->pf_idx;
+	switchdev_uplink_info_req.is_set = set;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_SWITCH_UPLINK,
+				 &switchdev_uplink_info_req,
+				 sizeof(switchdev_uplink_info_req),
+				 NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "switchdev uplink info config failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_switchdev_repr_vf_config(struct sxe2_adapter *adapter,
+				      struct sxe2_switchdev_repr_info *repr_vf,
+				      bool set)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_switchdev_repr_info switchdev_repr_info_req = {0};
+
+	switchdev_repr_info_req.pf_id = adapter->pf_idx;
+	switchdev_repr_info_req.is_set = set;
+	switchdev_repr_info_req.cp_vsi_id = repr_vf->cp_vsi_id;
+	switchdev_repr_info_req.repr_pf_id = repr_vf->repr_pf_id;
+	switchdev_repr_info_req.repr_vf_id = repr_vf->repr_vf_id;
+	switchdev_repr_info_req.repr_q_id = repr_vf->repr_q_id;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_SWITCH_REPR,
+			&switchdev_repr_info_req,
+			sizeof(switchdev_repr_info_req),
+			NULL, 0);
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "switchdev repr info config failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_switchdev_mode_get(struct sxe2_adapter *adapter, bool *is_switchdev)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_switchdev_mode_info switchdev_mode_info_req = {0};
+	struct sxe2_switchdev_mode_info switchdev_mode_info_resp = {0};
+
+	switchdev_mode_info_req.pf_id = adapter->pf_idx;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_SWITCH_MODE,
+				 &switchdev_mode_info_req,
+				 sizeof(switchdev_mode_info_req),
+				 &switchdev_mode_info_resp,
+				 sizeof(switchdev_mode_info_resp));
+
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "switchdev mode info get failed, ret=%d", ret);
+	else
+		*is_switchdev = (bool)switchdev_mode_info_resp.is_switchdev;
+
+	return ret;
+}
+
+int32_t sxe2_drv_switchdev_cpvsi_get(struct sxe2_adapter *adapter, uint16_t *cp_vsi_id)
+{
+	int32_t ret = 0;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_switchdev_cpvsi_info switchdev_cpvsi_resp = {0};
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_SWITCH_CPVSI,
+				 NULL, 0,
+				 &switchdev_cpvsi_resp,
+				 sizeof(switchdev_cpvsi_resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "switchdev cpvsi info get failed, ret=%d", ret);
+	else
+		*cp_vsi_id = switchdev_cpvsi_resp.cp_vsi_id;
+
+	return ret;
+}
+
 int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add)
 {
 	int32_t ret = 0;
@@ -1434,3 +1590,150 @@ int32_t sxe2_drv_mapping_stats_info_clear(struct rte_eth_dev *eth_dev)
 
 	return ret;
 }
+
+int32_t sxe2_drv_flow_filter_add(struct sxe2_adapter *adapter, struct sxe2_flow *flow)
+{
+	struct sxe2_drv_flow_filter_req req = { 0 };
+	struct sxe2_drv_flow_filter_resp resp = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	memcpy(&req.pattern_inner, &flow->pattern_inner, sizeof(req.pattern_inner));
+	memcpy(&req.pattern_outer, &flow->pattern_outer, sizeof(req.pattern_outer));
+	memcpy(&req.action, &flow->action, sizeof(req.action));
+	memcpy(&req.meta, &flow->meta, sizeof(req.meta));
+	req.engine_type = flow->engine_type;
+	req.flow_id = 0;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_FILTER_ADD, &req,
+			   sizeof(req), &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add flow filter, ret: %d.", ret);
+	flow->flow_id = resp.flow_id;
+	flow->create_err = ret;
+	return ret;
+}
+
+int32_t sxe2_drv_flow_filter_del(struct sxe2_adapter *adapter, struct sxe2_flow *flow)
+{
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_drv_flow_filter_req req = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+	memcpy(&req.pattern_inner, &flow->pattern_inner, sizeof(req.pattern_inner));
+	memcpy(&req.pattern_outer, &flow->pattern_outer, sizeof(req.pattern_outer));
+	memcpy(&req.action, &flow->action, sizeof(req.action));
+	memcpy(&req.meta, &flow->meta, sizeof(req.meta));
+	req.engine_type = flow->engine_type;
+	req.flow_id = flow->flow_id;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_FILTER_DEL, &req,
+			   sizeof(req), NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV,
+			"Failed to delete flow filter, flow id: %u, ret: %d.",
+			flow->flow_id, ret);
+	return ret;
+}
+
+int32_t sxe2_drv_flow_fnav_get_stat_id(struct sxe2_adapter *adapter, uint32_t *stat_id)
+{
+	struct sxe2_drv_flow_fnav_get_stat_id_req req = { 0 };
+	struct sxe2_drv_flow_fnav_get_stat_id_resp resp = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_FNAV_STAT_ALLOC,
+				 &req, sizeof(req),
+				 &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get fnav stat id, ret: %d.", ret);
+		goto l_end;
+	}
+	*stat_id = resp.stat_id;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_flow_fnav_free_stat(struct sxe2_adapter *adapter, uint32_t stat_id)
+{
+	struct sxe2_drv_flow_fnav_free_stat_id_req req = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	req.stat_id = stat_id;
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_FNAV_STAT_FREE,
+				 &req, sizeof(req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to free fnav stat id, ret: %d.", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
+		struct sxe2_fnav_cid_mgr *mgr)
+{
+	struct sxe2_drv_flow_fnav_query_stat_req req = { 0 };
+	struct sxe2_drv_flow_fnav_query_stat_resp resp = { 0 };
+	struct sxe2_drv_cmd_params cmd             = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret                                 = -1;
+
+	req.stat_id = mgr->stat_index;
+	req.stat_ctrl = mgr->count_type;
+	req.is_clear = 1;
+
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_FNAV_STAT_QUERY,
+				 &req, sizeof(req),
+				 &resp, sizeof(resp));
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV,
+			"Failed to query fnav stat, stat id: %u, ret: %d.",
+			req.stat_id, ret);
+		goto l_end;
+	}
+	mgr->hits += resp.stat_hits;
+	mgr->bytes += resp.stat_bytes;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_srcvsi_prune_config(struct sxe2_adapter *adapter,
+			uint16_t *vsi_list, uint16_t vsi_cnt, bool set)
+{
+	int32_t ret = 0;
+	uint16_t idx;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_srcvsi_ext_cfg_req srcvsi_list_prune_cfg_req = {0};
+
+	srcvsi_list_prune_cfg_req.vsi_id = adapter->vsi_ctxt.dpdk_vsi_id;
+	srcvsi_list_prune_cfg_req.is_add = set;
+	srcvsi_list_prune_cfg_req.srcvsi_cnt = vsi_cnt;
+	for (idx = 0; idx < vsi_cnt; idx++)
+		srcvsi_list_prune_cfg_req.srcvsi_list[idx] = vsi_list[idx];
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_VSI_SRCVSI_PRUNE,
+				 &srcvsi_list_prune_cfg_req,
+				 sizeof(srcvsi_list_prune_cfg_req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_WARN(adapter, DRV, "srcvsi prune config failed, ret=%d", ret);
+
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index c13653e8af..d505f93dc1 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -12,6 +12,9 @@
 int32_t sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter,
 		struct sxe2_drv_dev_caps_resp *dev_caps);
 
+int32_t sxe2_drv_switchdev_info_get(struct sxe2_adapter *adapter,
+		struct sxe2_switchdev_info *switchdev_info);
+
 int32_t sxe2_drv_dev_info_get(struct sxe2_adapter *adapter,
 		struct sxe2_drv_dev_info_resp *dev_info_resp);
 
@@ -64,6 +67,8 @@ int32_t sxe2_drv_ipsec_txsa_delete(struct sxe2_adapter *adapter,
 
 int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set);
 
+int32_t sxe2_drv_vsi_info_get(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi);
+
 int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter);
 
 int32_t sxe2_drv_get_mac_stats(struct sxe2_adapter *adapter);
@@ -91,6 +96,15 @@ int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set);
 
 int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
 
+int32_t sxe2_drv_switchdev_uplink_config(struct sxe2_adapter *adapter,  bool set);
+
+int32_t sxe2_drv_switchdev_repr_vf_config(struct sxe2_adapter *adapter,
+				struct sxe2_switchdev_repr_info *repr_vf, bool set);
+
+int32_t sxe2_drv_switchdev_cpvsi_get(struct sxe2_adapter *adapter, uint16_t *cp_vsi_id);
+
+int32_t sxe2_drv_switchdev_mode_get(struct sxe2_adapter *adapter, bool *is_switchdev);
+
 int32_t sxe2_drv_mc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
 
 int32_t sxe2_drv_vlan_config_query(struct sxe2_adapter *adapter);
@@ -122,4 +136,18 @@ int32_t sxe2_drv_rxq_bind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx, ui
 
 int32_t sxe2_drv_rxq_unbind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx);
 
+int32_t sxe2_drv_flow_filter_add(struct sxe2_adapter *adapter, struct sxe2_flow *flow);
+
+int32_t sxe2_drv_flow_filter_del(struct sxe2_adapter *adapter, struct sxe2_flow *flow);
+
+int32_t sxe2_drv_flow_fnav_get_stat_id(struct sxe2_adapter *adapter, uint32_t *stat_id);
+
+int32_t sxe2_drv_flow_fnav_free_stat(struct sxe2_adapter *adapter, uint32_t stat_id);
+
+int32_t sxe2_drv_flow_fnav_query_stat(struct sxe2_adapter *adapter,
+		struct sxe2_fnav_cid_mgr *mgr);
+
+int32_t sxe2_drv_srcvsi_prune_config(struct sxe2_adapter *adapter,
+		uint16_t *vsi_list, uint16_t vsi_cnt, bool set);
+
 #endif /* __SXE2_CMD_CHNL_H__ */
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 0b2a715000..48c012367c 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -108,7 +108,6 @@ enum sxe2_phys_port_name_type {
 	SXE2_PHYS_PORT_NAME_TYPE_LEGACY,
 	SXE2_PHYS_PORT_NAME_TYPE_UPLINK,
 	SXE2_PHYS_PORT_NAME_TYPE_PFVF,
-
 	SXE2_PHYS_PORT_NAME_TYPE_UNKNOWN,
 };
 
@@ -123,12 +122,27 @@ struct sxe2_switchdev_info {
 	uint32_t mpesw_owner;
 };
 
+struct sxe2_switchdev_uplink_info {
+	uint8_t pf_id;
+	uint8_t is_set;
+	uint8_t rsv[2];
+};
+
+struct sxe2_switchdev_repr_info {
+	uint8_t pf_id;
+	uint8_t is_set;
+	uint8_t rsv[2];
+	uint16_t cp_vsi_id;
+	uint16_t repr_pf_id;
+	uint16_t repr_vf_id;
+	uint16_t repr_q_id;
+};
+
 struct sxe2_switchdev_mode_info {
 	uint8_t pf_id;
 	uint8_t is_switchdev;
 	uint8_t rsv[2];
 };
-
 struct sxe2_switchdev_cpvsi_info {
 	uint16_t cp_vsi_id;
 	uint8_t rsv[2];
@@ -216,8 +230,8 @@ struct sxe2_drv_q_switch_req {
 };
 
 struct sxe2_drv_queue_irq_bind_req {
-	__le16 q_idx;
-	__le16 msix_idx;
+	uint16_t q_idx;
+	uint16_t msix_idx;
 	uint8_t itr_idx;
 	uint8_t bind;
 	uint8_t rsv[2];
@@ -253,6 +267,44 @@ struct sxe2_drv_link_info_resp {
 	uint8_t rsv[3];
 };
 
+struct sxe2_drv_flow_filter_req {
+	uint32_t flow_id;
+	struct sxe2_flow_meta meta;
+	enum sxe2_flow_engine_type engine_type;
+	struct sxe2_flow_pattern pattern_outer;
+	struct sxe2_flow_pattern pattern_inner;
+	struct sxe2_flow_action action;
+};
+
+struct sxe2_drv_flow_filter_resp {
+	enum sxe2_flow_engine_type engine_type;
+	uint32_t flow_id;
+};
+
+struct sxe2_drv_flow_fnav_get_stat_id_req {
+	uint8_t need_update;
+};
+
+struct sxe2_drv_flow_fnav_get_stat_id_resp {
+	uint32_t stat_id;
+};
+
+struct sxe2_drv_flow_fnav_free_stat_id_req {
+	uint32_t stat_id;
+};
+
+struct sxe2_drv_flow_fnav_query_stat_req {
+	uint32_t stat_id;
+	uint32_t stat_ctrl;
+	uint32_t is_clear;
+};
+
+struct sxe2_drv_flow_fnav_query_stat_resp {
+	uint32_t stat_index;
+	uint64_t stat_hits;
+	uint64_t stat_bytes;
+};
+
 struct sxe2_drv_vlan_cfg_query_resp {
 	uint16_t vsi_id;
 	uint8_t port_vlan_exist;
@@ -330,25 +382,25 @@ struct sxe2_vlan_filter_switch_req {
 };
 
 struct sxe2_rss_key_req {
-	__le16 vsi_id;
-	__le16 key_size;
+	uint16_t vsi_id;
+	uint16_t key_size;
 	uint8_t key[];
 };
 
 struct sxe2_rss_lut_req {
-	__le16 vsi_id;
-	__le16 lut_size;
+	uint16_t vsi_id;
+	uint16_t lut_size;
 	uint8_t lut[];
 };
 
 struct sxe2_rss_func_req {
-	__le16 vsi_id;
+	uint16_t vsi_id;
 	uint8_t func;
 	uint8_t rsv[1];
 };
 
 struct sxe2_rss_hf_req {
-	__le16 vsi_id;
+	uint16_t vsi_id;
 	uint8_t rsv[2];
 	uint32_t headers[BITS_TO_U32(SXE2_FLOW_HDR_MAX)];
 	uint32_t hash_flds[BITS_TO_U32(SXE2_FLOW_FLD_ID_MAX)];
@@ -358,7 +410,7 @@ struct sxe2_rss_hf_req {
 };
 
 struct sxe2_tm_res {
-	__le16 teid;
+	uint16_t teid;
 };
 
 struct sxe2_tm_info {
@@ -366,32 +418,32 @@ struct sxe2_tm_info {
 	uint32_t peak;
 	uint8_t priority;
 	uint8_t reserve;
-	__le16 weight;
+	uint16_t weight;
 };
 
 struct sxe2_tm_add_mid_msg {
-	__le16 parent_teid;
+	uint16_t parent_teid;
 	uint8_t adj_lvl;
 	struct sxe2_tm_info info;
 };
 struct sxe2_tm_add_queue_msg {
-	__le16 parent_teid;
-	__le16 queue_id;
+	uint16_t parent_teid;
+	uint16_t queue_id;
 	uint8_t adj_lvl;
 	struct sxe2_tm_info info;
 };
 
 struct sxe2_drv_ipsec_capa_resq {
-	__le16 tx_sa_cnt;
-	__le16 rx_sa_cnt;
-	__le16 ip_id_cnt;
-	__le16 udp_group_cnt;
+	uint16_t tx_sa_cnt;
+	uint16_t rx_sa_cnt;
+	uint16_t ip_id_cnt;
+	uint16_t udp_group_cnt;
 };
 
 #define SXE2_IPSEC_KEY_LEN (32)
 #define SXE2_IPV6_ADDR_LEN (4)
 struct sxe2_drv_ipsec_txsa_add_req {
-	__le32 mode;
+	uint32_t mode;
 	uint8_t encrypt_keys[SXE2_IPSEC_KEY_LEN];
 	uint8_t auth_keys[SXE2_IPSEC_KEY_LEN];
 	bool func_type;
@@ -400,14 +452,14 @@ struct sxe2_drv_ipsec_txsa_add_req {
 };
 
 struct sxe2_drv_ipsec_txsa_add_resp {
-	__le16 index;
+	uint16_t index;
 };
 
 struct sxe2_drv_ipsec_rxsa_add_req {
-	__le32 mode;
-	__le32 spi;
-	__le32 ipaddr[SXE2_IPV6_ADDR_LEN];
-	__le32 udp_port;
+	uint32_t mode;
+	uint32_t spi;
+	uint32_t ipaddr[SXE2_IPV6_ADDR_LEN];
+	uint32_t udp_port;
 	uint8_t sport_en;
 	uint8_t dport_en;
 	uint8_t is_over_sdn;
@@ -422,11 +474,11 @@ struct sxe2_drv_ipsec_rxsa_add_req {
 struct sxe2_drv_ipsec_rxsa_add_resp {
 	uint8_t ip_id;
 	uint8_t udp_group_id;
-	__le16 sa_idx;
+	uint16_t sa_idx;
 };
 
 struct sxe2_drv_ipsec_txsa_del_req {
-	__le16 sa_idx;
+	uint16_t sa_idx;
 	bool func_type;
 	uint8_t func_id;
 	uint8_t drv_id;
@@ -435,116 +487,116 @@ struct sxe2_drv_ipsec_txsa_del_req {
 struct sxe2_drv_ipsec_rxsa_del_req {
 	uint8_t ip_id;
 	uint8_t group_id;
-	__le16 sa_idx;
-	__le32 spi;
+	uint16_t sa_idx;
+	uint32_t spi;
 	bool func_type;
 	uint8_t func_id;
 	uint8_t drv_id;
 };
 
 struct sxe2_drv_vsi_sw_stats {
-	__le64 rx_packets;
-	__le64 rx_bytes;
-	__le64 tx_packets;
-	__le64 tx_bytes;
+	uint64_t rx_packets;
+	uint64_t rx_bytes;
+	uint64_t tx_packets;
+	uint64_t tx_bytes;
 };
 
 struct sxe2_drv_vsi_stats_req {
-	__le16 vsi_id;
+	uint16_t vsi_id;
 	uint8_t  rsv[2];
 	struct sxe2_drv_vsi_sw_stats sw_stats;
 };
 
 struct sxe2_drv_vsi_stats_resp {
-	__le64 rx_vsi_unicast_packets;
-	__le64 rx_vsi_bytes;
-	__le64 tx_vsi_unicast_packets;
-	__le64 tx_vsi_bytes;
-	__le64 rx_vsi_multicast_packets;
-	__le64 tx_vsi_multicast_packets;
-	__le64 rx_vsi_broadcast_packets;
-	__le64 tx_vsi_broadcast_packets;
+	uint64_t rx_vsi_unicast_packets;
+	uint64_t rx_vsi_bytes;
+	uint64_t tx_vsi_unicast_packets;
+	uint64_t tx_vsi_bytes;
+	uint64_t rx_vsi_multicast_packets;
+	uint64_t tx_vsi_multicast_packets;
+	uint64_t rx_vsi_broadcast_packets;
+	uint64_t tx_vsi_broadcast_packets;
 };
 
 #define SXE2_MAX_USER_PRIORITY         (8)
 
 struct sxe2_drv_mac_stats_resp {
-	__le64 rx_out_of_buffer;
-	__le64 rx_qblock_drop;
-	__le64 tx_frame_good;
-	__le64 rx_frame_good;
-	__le64 rx_crc_errors;
-	__le64 tx_bytes_good;
-	__le64 rx_bytes_good;
-	__le64 tx_multicast_good;
-	__le64 tx_broadcast_good;
-	__le64 rx_multicast_good;
-	__le64 rx_broadcast_good;
-	__le64 rx_len_errors;
-	__le64 rx_out_of_range_errors;
-	__le64 rx_oversize_pkts_phy;
-	__le64 rx_symbol_err;
-	__le64 rx_pause_frame;
-	__le64 tx_pause_frame;
-	__le64 rx_discards_phy;
-	__le64 rx_discards_ips_phy;
-	__le64 tx_dropped_link_down;
-	__le64 rx_undersize_good;
-	__le64 rx_runt_error;
-	__le64 tx_bytes_good_bad;
-	__le64 tx_frame_good_bad;
-	__le64 rx_jabbers;
-	__le64 rx_size_64;
-	__le64 rx_size_65_127;
-	__le64 rx_size_128_255;
-	__le64 rx_size_256_511;
-	__le64 rx_size_512_1023;
-	__le64 rx_size_1024_1522;
-	__le64 rx_size_1523_max;
-	__le64 rx_pcs_symbol_err_phy;
-	__le64 rx_corrected_bits_phy;
-	__le64 rx_err_lane_0_phy;
-	__le64 rx_err_lane_1_phy;
-	__le64 rx_err_lane_2_phy;
-	__le64 rx_err_lane_3_phy;
-	__le64 rx_prio_buf_discard[SXE2_MAX_USER_PRIORITY];
-	__le64 rx_illegal_bytes;
-	__le64 rx_oversize_good;
-	__le64 tx_unicast;
-	__le64 tx_broadcast;
-	__le64 tx_multicast;
-	__le64 tx_vlan_packet_good;
-	__le64 tx_size_64;
-	__le64 tx_size_65_127;
-	__le64 tx_size_128_255;
-	__le64 tx_size_256_511;
-	__le64 tx_size_512_1023;
-	__le64 tx_size_1024_1522;
-	__le64 tx_size_1523_max;
-	__le64 tx_underflow_error;
-	__le64 rx_byte_good_bad;
-	__le64 rx_frame_good_bad;
-	__le64 rx_unicast_good;
-	__le64 rx_vlan_packets;
-	__le64 prio_xoff_rx[SXE2_MAX_USER_PRIORITY];
-	__le64 prio_xon_rx[SXE2_MAX_USER_PRIORITY];
-	__le64 prio_xon_tx[SXE2_MAX_USER_PRIORITY];
-	__le64 prio_xoff_tx[SXE2_MAX_USER_PRIORITY];
-	__le64 prio_xon_2_xoff[SXE2_MAX_USER_PRIORITY];
+	uint64_t rx_out_of_buffer;
+	uint64_t rx_qblock_drop;
+	uint64_t tx_frame_good;
+	uint64_t rx_frame_good;
+	uint64_t rx_crc_errors;
+	uint64_t tx_bytes_good;
+	uint64_t rx_bytes_good;
+	uint64_t tx_multicast_good;
+	uint64_t tx_broadcast_good;
+	uint64_t rx_multicast_good;
+	uint64_t rx_broadcast_good;
+	uint64_t rx_len_errors;
+	uint64_t rx_out_of_range_errors;
+	uint64_t rx_oversize_pkts_phy;
+	uint64_t rx_symbol_err;
+	uint64_t rx_pause_frame;
+	uint64_t tx_pause_frame;
+	uint64_t rx_discards_phy;
+	uint64_t rx_discards_ips_phy;
+	uint64_t tx_dropped_link_down;
+	uint64_t rx_undersize_good;
+	uint64_t rx_runt_error;
+	uint64_t tx_bytes_good_bad;
+	uint64_t tx_frame_good_bad;
+	uint64_t rx_jabbers;
+	uint64_t rx_size_64;
+	uint64_t rx_size_65_127;
+	uint64_t rx_size_128_255;
+	uint64_t rx_size_256_511;
+	uint64_t rx_size_512_1023;
+	uint64_t rx_size_1024_1522;
+	uint64_t rx_size_1523_max;
+	uint64_t rx_pcs_symbol_err_phy;
+	uint64_t rx_corrected_bits_phy;
+	uint64_t rx_err_lane_0_phy;
+	uint64_t rx_err_lane_1_phy;
+	uint64_t rx_err_lane_2_phy;
+	uint64_t rx_err_lane_3_phy;
+	uint64_t rx_prio_buf_discard[SXE2_MAX_USER_PRIORITY];
+	uint64_t rx_illegal_bytes;
+	uint64_t rx_oversize_good;
+	uint64_t tx_unicast;
+	uint64_t tx_broadcast;
+	uint64_t tx_multicast;
+	uint64_t tx_vlan_packet_good;
+	uint64_t tx_size_64;
+	uint64_t tx_size_65_127;
+	uint64_t tx_size_128_255;
+	uint64_t tx_size_256_511;
+	uint64_t tx_size_512_1023;
+	uint64_t tx_size_1024_1522;
+	uint64_t tx_size_1523_max;
+	uint64_t tx_underflow_error;
+	uint64_t rx_byte_good_bad;
+	uint64_t rx_frame_good_bad;
+	uint64_t rx_unicast_good;
+	uint64_t rx_vlan_packets;
+	uint64_t prio_xoff_rx[SXE2_MAX_USER_PRIORITY];
+	uint64_t prio_xon_rx[SXE2_MAX_USER_PRIORITY];
+	uint64_t prio_xon_tx[SXE2_MAX_USER_PRIORITY];
+	uint64_t prio_xoff_tx[SXE2_MAX_USER_PRIORITY];
+	uint64_t prio_xon_2_xoff[SXE2_MAX_USER_PRIORITY];
 };
 
 struct sxe2_txq_map_info {
-	__le32 txq_lan_pkt_cnt;
-	__le32 txq_lan_byte_cnt;
+	uint32_t txq_lan_pkt_cnt;
+	uint32_t txq_lan_byte_cnt;
 };
 
 struct sxe2_rxq_map_info {
-	__le64 rxq_lan_in_pkt_cnt;
-	__le64 rxq_lan_in_byte_cnt;
-	__le64 rxq_fd_in_pkt_cnt;
-	__le64 rxq_mng_in_pkt_cnt;
-	__le64 rxq_mng_in_byte_cnt;
-	__le64 rxq_mng_out_pkt_cnt;
+	uint64_t rxq_lan_in_pkt_cnt;
+	uint64_t rxq_lan_in_byte_cnt;
+	uint64_t rxq_fd_in_pkt_cnt;
+	uint64_t rxq_mng_in_pkt_cnt;
+	uint64_t rxq_mng_in_byte_cnt;
+	uint64_t rxq_mng_out_pkt_cnt;
 };
 
 struct sxe2_queue_map_info {
@@ -553,12 +605,12 @@ struct sxe2_queue_map_info {
 };
 
 struct sxe2_drv_rx_map_req {
-	__le16 queue_id;
+	uint16_t queue_id;
 	uint8_t pool_idx;
 };
 
 struct sxe2_drv_tx_map_req {
-	__le16 queue_id;
+	uint16_t queue_id;
 	uint8_t pool_idx;
 };
 
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index f3fee74ddf..317101fb60 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -33,9 +33,13 @@
 #include "sxe2_ptype.h"
 #include "sxe2_common_log.h"
 #include "sxe2_mp.h"
+#include "sxe2_flow.h"
 #include "sxe2_stats.h"
 #include "sxe2_host_regs.h"
+#include "sxe2_switchdev.h"
 #include "sxe2_ioctl_chnl_func.h"
+#include "sxe2_ethdev_repr.h"
+#include "sxe2vf_regs.h"
 
 #define SXE2_PCI_VENDOR_ID_1    0x1ff2
 #define SXE2_PCI_DEVICE_ID_PF_1 0x10b1
@@ -83,6 +87,27 @@ static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_pf[SXE2_PCI_MAP_RES_
 				      .reg_width = 10},
 };
 
+static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_vf[SXE2_PCI_MAP_RES_MAX_COUNT] = {
+	[SXE2_PCI_MAP_RES_INVALID]  = {.addr_base = 0,
+				      .bar_idx = 0,
+				      .reg_width = 0},
+	[SXE2_PCI_MAP_RES_DOORBELL_TX] = {.addr_base = SXE2VF_TXQ_TAIL(0),
+				      .bar_idx = 0,
+				      .reg_width = 4},
+	[SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL] = {.addr_base = SXE2VF_RXQ_TAIL(0),
+				      .bar_idx = 0,
+				      .reg_width = 4},
+	[SXE2_PCI_MAP_RES_IRQ_DYN] = {.addr_base = SXE2VF_VF_DYN_CTL(0),
+				      .bar_idx = 0,
+				      .reg_width = 4},
+	[SXE2_PCI_MAP_RES_IRQ_ITR] = {.addr_base = SXE2VF_VF_INT_ITR(0, 0),
+				      .bar_idx = 0,
+				      .reg_width = 4},
+	[SXE2_PCI_MAP_RES_IRQ_MSIX] = {.addr_base = SXE2VF_BAR4_MSIX_CTL(0),
+				      .bar_idx = 4,
+				      .reg_width = 0x10},
+};
+
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev);
 static int32_t sxe2_dev_start(struct rte_eth_dev *dev);
 static int32_t sxe2_dev_stop(struct rte_eth_dev *dev);
@@ -137,6 +162,7 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.rss_hash_update            = sxe2_dev_rss_hash_update,
 	.rss_hash_conf_get          = sxe2_dev_rss_hash_conf_get,
 
+	.flow_ops_get               = sxe2_flow_ops_get,
 	.tm_ops_get                 = sxe2_tm_ops_get,
 
 	.stats_get                  = sxe2_stats_info_get,
@@ -566,7 +592,7 @@ static int32_t sxe2_eth_init(struct rte_eth_dev *dev)
 	return ret;
 }
 
-static void sxe2_eth_uinit(struct rte_eth_dev *dev __rte_unused)
+void sxe2_eth_uinit(struct rte_eth_dev *dev __rte_unused)
 {
 	sxe2_mac_addr_uinit(dev);
 	(void)sxe2_filter_uinit(dev);
@@ -607,6 +633,16 @@ static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
 		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_FC_STATE;
 }
 
+static void sxe2_sw_representor_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+			struct sxe2_drv_representor_caps *repr_caps)
+{
+	adapter->repr_ctxt.nb_vf = repr_caps->cnt_repr_vf;
+	if (adapter->repr_ctxt.nb_vf > 0) {
+		memcpy(adapter->repr_ctxt.repr_vf_id, repr_caps->repr_vf_id,
+			adapter->repr_ctxt.nb_vf * sizeof(struct sxe2_drv_vsi_caps));
+	}
+}
+
 static void sxe2_sw_sched_hw_cap_set(struct sxe2_adapter *adapter,
 				     struct sxe2_txsch_caps *txsch_caps)
 {
@@ -636,20 +672,47 @@ static int32_t sxe2_func_caps_get(struct sxe2_adapter *adapter)
 
 	sxe2_sw_vsi_ctx_hw_cap_set(adapter, &dev_caps.vsi_caps);
 
+	sxe2_sw_representor_ctx_hw_cap_set(adapter, &dev_caps.repr_caps);
+
 	sxe2_sw_sched_hw_cap_set(adapter, &dev_caps.txsch_caps);
 
 l_end:
 	return ret;
 }
 
+static int32_t sxe2_switchdev_info_get(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	struct sxe2_switchdev_info switchdev_info = {0};
+
+	ret = sxe2_drv_switchdev_info_get(adapter, &switchdev_info);
+	if (ret)
+		goto l_end;
+	if (switchdev_info.master && switchdev_info.representor) {
+		PMD_LOG_ERR(INIT, "device could not be both master and representor");
+		ret = -ENODEV;
+		goto l_end;
+	}
+	adapter->switchdev_info = switchdev_info;
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_dev_caps_get(struct sxe2_adapter *adapter)
 {
 	int32_t ret = -1;
 
 	ret = sxe2_func_caps_get(adapter);
-	if (ret)
+	if (ret) {
 		PMD_LOG_ERR(INIT, "get function caps failed, ret=%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_switchdev_info_get(adapter);
+	if (ret)
+		PMD_LOG_ERR(INIT, "get switchdev info failed, ret=%d", ret);
 
+l_end:
 	return ret;
 }
 
@@ -935,7 +998,10 @@ int32_t sxe2_dev_pci_map_init(struct rte_eth_dev *dev)
 	bar_info[1].seg_info = seg_info;
 	map_ctxt->bar_info = bar_info;
 
-	map_ctxt->addr_info = sxe2_net_map_addr_info_pf;
+	if (adapter->dev_type == SXE2_DEV_T_VF)
+		map_ctxt->addr_info = sxe2_net_map_addr_info_vf;
+	else
+		map_ctxt->addr_info = sxe2_net_map_addr_info_pf;
 
 	ret = sxe2_dev_pci_res_seg_map(adapter, SXE2_PCI_MAP_RES_DOORBELL_TX,
 				       txq_cnt, txq_base);
@@ -1138,6 +1204,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_dev_info_err;
 	}
 
+	ret = sxe2_switchdev_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize switchdev mode, ret=[%d]", ret);
+		goto init_switchdev_err;
+	}
+
 	ret = sxe2_sw_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize sw parameters, ret=[%d]", ret);
@@ -1168,6 +1240,12 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_rss_err;
 	}
 
+	ret = sxe2_flow_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init flow, ret=%d", ret);
+		goto init_flow_err;
+	}
+
 	ret = sxe2_sched_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to init sched, ret=%d", ret);
@@ -1191,15 +1269,19 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 init_xstats_err:
 	(void)sxe2_sched_uinit(dev);
 init_sched_err:
+	(void)sxe2_flow_uninit(dev);
+init_flow_err:
 init_rss_err:
 	sxe2_security_uinit(dev);
 init_security_err:
+	sxe2_eth_uinit(dev);
+init_eth_err:
 	sxe2_intr_uninit(dev);
 init_irq_err:
 	sxe2_sw_uninit(dev);
 init_sw_err:
-	sxe2_eth_uinit(dev);
-init_eth_err:
+	(void)sxe2_switchdev_uninit(dev);
+init_switchdev_err:
 init_dev_info_err:
 	sxe2_vsi_uninit(dev);
 init_vsi_err:
@@ -1214,6 +1296,7 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 		sxe2_mp_uninit(dev);
 		goto l_end;
 	}
+	sxe2_repr_all_close(dev);
 	(void)sxe2_dev_stop(dev);
 	(void)sxe2_queues_release(dev);
 	sxe2_mp_uninit(dev);
@@ -1222,6 +1305,7 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	sxe2_vsi_uninit(dev);
 	sxe2_security_uinit(dev);
 	sxe2_intr_uninit(dev);
+	(void)sxe2_switchdev_uninit(dev);
 	sxe2_sw_uninit(dev);
 	sxe2_eth_uinit(dev);
 	sxe2_dev_pci_map_uinit(dev);
@@ -1233,10 +1317,29 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 static int32_t sxe2_dev_uninit(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
+	int32_t i = 0;
+	struct sxe2_adapter *adapter = NULL;
+	struct rte_eth_dev *rep_dev = NULL;
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		goto l_end;
 
+	adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	for (i = 0; i < adapter->repr_ctxt.nb_repr_vf; i++) {
+		rep_dev = adapter->repr_ctxt.vf_rep_eth_dev[i];
+		if (rep_dev) {
+			ret = rep_dev->dev_ops->dev_close(rep_dev);
+			if (ret)
+				goto l_end;
+			if (rep_dev->intr_handle)
+				rte_intr_instance_free(rep_dev->intr_handle);
+			ret = rte_eth_dev_release_port(rep_dev);
+			if (ret)
+				goto l_end;
+			adapter->repr_ctxt.vf_rep_eth_dev[i] = NULL;
+		}
+	}
+
 	ret = sxe2_dev_close(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Sxe2 dev close failed, ret=%d", ret);
@@ -1270,6 +1373,65 @@ static int32_t sxe2_eth_pmd_remove(struct sxe2_common_device *cdev)
 	return ret;
 }
 
+static uint16_t sxe2_switchdev_repr_id_encode_get(struct sxe2_switchdev_info *switchdev_info)
+{
+	enum rte_eth_representor_type type;
+	uint16_t repr = switchdev_info->vf_num;
+	uint32_t pf = switchdev_info->pf_num;
+
+	switch (switchdev_info->port_name_type) {
+	case SXE2_PHYS_PORT_NAME_TYPE_UPLINK:
+		if (!switchdev_info->representor)
+			return UINT16_MAX;
+		type = RTE_ETH_REPRESENTOR_PF;
+		pf = switchdev_info->mpesw_owner;
+		break;
+	case SXE2_PHYS_PORT_NAME_TYPE_PFVF:
+	default:
+		type = RTE_ETH_REPRESENTOR_VF;
+		break;
+	}
+
+	return SXE2_REPRESENTOR_ID(pf, type, repr);
+}
+
+static bool sxe2_switchdev_repr_match(struct sxe2_adapter *adapter,
+				   struct rte_eth_devargs *req_eth_da)
+{
+	uint32_t port_idx = 0;
+	uint32_t repr_idx;
+	uint16_t kernel_repr_id = sxe2_switchdev_repr_id_encode_get(&adapter->switchdev_info);
+	uint16_t repr_id;
+
+	switch (req_eth_da->type) {
+	case RTE_ETH_REPRESENTOR_PF:
+		break;
+	case RTE_ETH_REPRESENTOR_VF:
+		if (adapter->switchdev_info.port_name_type !=
+		SXE2_PHYS_PORT_NAME_TYPE_PFVF) {
+			rte_errno = EBUSY;
+			return false;
+		}
+		break;
+	case RTE_ETH_REPRESENTOR_NONE:
+		rte_errno = EBUSY;
+		return false;
+	default:
+		rte_errno = ENOTSUP;
+		return false;
+	}
+
+	for (repr_idx = 0; repr_idx < req_eth_da->nb_representor_ports; ++repr_idx) {
+		repr_id = SXE2_REPRESENTOR_ID(req_eth_da->ports[port_idx],
+					      req_eth_da->type,
+					      req_eth_da->representor_ports[repr_idx]);
+		if (repr_id == kernel_repr_id)
+			return true;
+	}
+	rte_errno = EBUSY;
+	return false;
+}
+
 static int32_t sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
 		struct rte_eth_devargs *req_eth_da __rte_unused,
 		uint16_t owner_id __rte_unused,
@@ -1311,10 +1473,34 @@ static int32_t sxe2_eth_pmd_probe_pf(struct sxe2_common_device *cdev,
 		goto l_release_port;
 	}
 
+	if (req_eth_da->nb_representor_ports > 0) {
+		if (!adapter->switchdev_info.is_switchdev) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "Representor requested but Switchdev not enabled");
+			ret = -ENOTSUP;
+			goto l_dev_uinit;
+		}
+
+		if (!sxe2_switchdev_repr_match(adapter, req_eth_da)) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "Representor parameters mismatch");
+			ret = -ENOTSUP;
+			goto l_dev_uinit;
+		}
+
+		ret = sxe2_switchdev_repr_devs_init(adapter, req_eth_da);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "Failed to init representor, ret=%d", ret);
+			goto l_dev_uinit;
+		}
+	} else {
+		PMD_DEV_LOG_DEBUG(adapter, INIT, "No representors requested, skipping.");
+	}
+
 	rte_eth_dev_probing_finish(eth_dev);
 	PMD_DEV_LOG_DEBUG(adapter, INIT, "Sxe2 eth pmd probe successful!");
 	goto l_end;
 
+l_dev_uinit:
+	(void)sxe2_dev_uninit(eth_dev);
 l_release_port:
 	(void)rte_eth_dev_release_port(eth_dev);
 l_end:
@@ -1384,6 +1570,11 @@ static struct sxe2_class_driver sxe2_eth_pmd = {
 	.intr_rmv = 1,
 };
 
+bool sxe2_ethdev_check(struct rte_eth_dev *dev)
+{
+	return !strcmp(dev->device->driver->name, "sxe2_pci");
+}
+
 RTE_INIT(rte_sxe2_pmd_init)
 {
 	sxe2_common_init();
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 65ada44c12..6397a2e5c6 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -64,6 +64,9 @@ enum sxe2_fnav_tunnel_flag_type {
 #define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
 #define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
 
+#define SXE2_REPRESENTOR_ID(pf, type, repr) \
+		(((pf) << 14) + ((type) << 12) + ((repr) & 0xfff))
+
 #define SXE2_I2C_EEPROM_DEV_ADDR	0xA0
 #define SXE2_I2C_EEPROM_DEV_ADDR2	0xA2
 #define SXE2_MODULE_TYPE_SFP		0x03
@@ -309,16 +312,20 @@ struct sxe2_adapter {
 	struct sxe2_vsi_context       vsi_ctxt;
 	struct sxe2_filter_context    filter_ctxt;
 	struct sxe2_rss_context       rss_ctxt;
+	struct sxe2_flow_context      flow_ctxt;
 	struct sxe2_link_context      link_ctxt;
 	struct sxe2_ptp_context       ptp_ctxt;
 	struct sxe2_sched_hw_cap      sched_ctxt;
 	struct sxe2_tm_context        tm_ctxt;
 	struct sxe2_devargs           devargs;
 	struct sxe2_security_ctx      security_ctx;
+	struct sxe2_repr_context      repr_ctxt;
 	struct sxe2_switchdev_info    switchdev_info;
 	bool                          rule_started;
 	bool                          flow_isolated;
+	bool                          flow_isolate_cfg;
 	uint16_t                           dev_port_id;
+	bool                          is_dev_repr;
 	uint64_t                           cap_flags;
 	enum sxe2_dev_type            dev_type;
 	uint32_t    ptype_tbl[SXE2_MAX_PTYPE_NUM];
@@ -340,6 +347,8 @@ void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 			    enum sxe2_pci_map_resource res_type,
 			    uint16_t idx_in_func);
 
+bool sxe2_ethdev_check(struct rte_eth_dev *dev);
+
 uint32_t sxe2_sched_mode_get(struct sxe2_adapter *adapter);
 
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
@@ -366,6 +375,8 @@ int32_t sxe2_dev_pci_map_init(struct rte_eth_dev *dev);
 
 void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev);
 
+void sxe2_eth_uinit(struct rte_eth_dev *dev);
+
 static inline bool
 sxe2_dev_port_vlan_check(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
new file mode 100644
index 0000000000..a43991c379
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -0,0 +1,607 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_ethdev_repr.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_common.h"
+#include "sxe2_common_log.h"
+#include "sxe2_tx.h"
+#include "sxe2_rx.h"
+#include "sxe2_txrx.h"
+#include "sxe2_switchdev.h"
+#include "sxe2_ptype.h"
+#include "sxe2_mp.h"
+#include "sxe2_stats.h"
+#include "sxe2_flow.h"
+
+static struct sxe2_pci_map_addr_info sxe2_net_map_addr_info_repr[SXE2_PCI_MAP_RES_MAX_COUNT] = {
+	{0, 0, 0},
+	{ SXE2_TXQ_LEGACY_DBLL(0), 0, 4},
+	{ SXE2_RXQ_TAIL(0), 0, 4},
+	{ SXE2_VF_DYN_CTL(0), 0, 4},
+	{ SXE2_VF_INT_ITR(0, 0), 0, 4},
+	{ SXE2_BAR4_MSIX_CTL(0), 4, 0x10},
+};
+
+static void sxe2_repr_dev_uinit(struct rte_eth_dev *dev);
+
+static int32_t sxe2_repr_promisc_enable(struct rte_eth_dev *dev __rte_unused)
+{
+	return 0;
+}
+static int32_t sxe2_repr_promisc_disable(struct rte_eth_dev *dev __rte_unused)
+{
+	return 0;
+}
+static int32_t sxe2_repr_allmulti_enable(struct rte_eth_dev *dev __rte_unused)
+{
+	return 0;
+}
+static int32_t sxe2_repr_allmulti_disable(struct rte_eth_dev *dev __rte_unused)
+{
+	return 0;
+}
+
+static int32_t sxe2_repr_dev_configure(struct rte_eth_dev *dev)
+{
+	dev->data->mtu = SXE2_FRAME_SIZE_MAX - SXE2_ETH_OVERHEAD;
+	return 0;
+}
+
+static int32_t sxe2_repr_dev_start(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	PMD_INIT_FUNC_TRACE();
+
+	ret = sxe2_queues_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init queues.");
+		goto l_end;
+	}
+
+	sxe2_rx_mode_func_set(dev);
+	sxe2_tx_mode_func_set(dev);
+
+	ret = sxe2_link_update_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize link update, ret:%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_repr_rxq_intr_enable(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to enable rx queue intr");
+		goto l_end;
+	}
+
+	ret = sxe2_queues_start(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "enable queues failed");
+		goto l_start_queues_err;
+	}
+
+	dev->data->dev_started = 1;
+	adapter->started = 1;
+	goto l_end;
+l_start_queues_err:
+	(void)sxe2_rxq_intr_disable(dev);
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_repr_dev_stop(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	PMD_INIT_FUNC_TRACE();
+
+	if (adapter->started == 0)
+		goto l_end;
+
+	sxe2_repr_rxq_intr_disable(dev);
+
+	sxe2_txqs_all_stop(dev);
+	sxe2_rxqs_all_stop(dev);
+
+	dev->data->dev_started = 0;
+	adapter->started = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_repr_dev_close(struct rte_eth_dev *dev)
+{
+	PMD_DEV_LOG_INFO(SXE2_DEV_PRIVATE_TO_ADAPTER(dev),
+			 INIT, "repr close");
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		sxe2_mp_uninit(dev);
+		goto l_end;
+	}
+	(void)sxe2_repr_dev_stop(dev);
+	(void)sxe2_queues_release(dev);
+	sxe2_mp_uninit(dev);
+	sxe2_repr_dev_uinit(dev);
+l_end:
+	return 0;
+}
+
+static int32_t sxe2_repr_dev_infos_get(struct rte_eth_dev *dev,
+			struct rte_eth_dev_info *dev_info)
+{
+	dev_info->max_rx_queues = 1;
+	dev_info->max_tx_queues = 1;
+	dev_info->min_rx_bufsize = SXE2_MIN_BUF_SIZE;
+	dev_info->max_rx_pktlen = SXE2_FRAME_SIZE_MAX;
+	dev_info->max_lro_pkt_size = SXE2_FRAME_SIZE_MAX * SXE2_RX_LRO_DESC_MAX_NUM;
+	dev_info->max_mtu = dev_info->max_rx_pktlen - SXE2_ETH_OVERHEAD;
+	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
+	dev_info->max_mac_addrs = SXE2_NUM_MACADDR_MAX;
+
+	dev_info->rx_offload_capa =
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC |
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM;
+	dev_info->tx_offload_capa =
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM;
+
+	dev_info->tx_queue_offload_capa = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+
+	dev_info->default_rxconf = (struct rte_eth_rxconf) {
+		.rx_thresh = {
+			.pthresh = SXE2_DEFAULT_RX_PTHRESH,
+			.hthresh = SXE2_DEFAULT_RX_HTHRESH,
+			.wthresh = SXE2_DEFAULT_RX_WTHRESH,
+		},
+		.rx_free_thresh = SXE2_DEFAULT_RX_FREE_THRESH,
+		.rx_drop_en = 0,
+		.offloads = 0,
+	};
+
+	dev_info->default_txconf = (struct rte_eth_txconf) {
+		.tx_thresh = {
+			.pthresh = SXE2_DEFAULT_TX_PTHRESH,
+			.hthresh = SXE2_DEFAULT_TX_HTHRESH,
+			.wthresh = SXE2_DEFAULT_TX_WTHRESH,
+		},
+		.tx_free_thresh = SXE2_DEFAULT_TX_FREE_THRESH,
+		.tx_rs_thresh = SXE2_DEFAULT_TX_RSBIT_THRESH,
+		.offloads = 0,
+	};
+
+	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = SXE2_MAX_RING_DESC,
+		.nb_min = SXE2_MIN_RING_DESC,
+		.nb_align = SXE2_ALIGN,
+	};
+
+	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = SXE2_MAX_RING_DESC,
+		.nb_min = SXE2_MIN_RING_DESC,
+		.nb_align = SXE2_ALIGN,
+		.nb_mtu_seg_max = SXE2_TX_MTU_SEG_MAX,
+		.nb_seg_max = SXE2_MAX_RING_DESC,
+	};
+
+	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G |
+			 RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
+
+	dev_info->nb_rx_queues = dev->data->nb_rx_queues;
+	dev_info->nb_tx_queues = dev->data->nb_tx_queues;
+
+	dev_info->default_rxportconf.burst_size = SXE2_RX_MAX_BURST;
+	dev_info->default_txportconf.burst_size = SXE2_TX_MAX_BURST;
+	dev_info->default_rxportconf.nb_queues = 1;
+	dev_info->default_txportconf.nb_queues = 1;
+	dev_info->default_rxportconf.ring_size = SXE2_RING_SIZE_MIN;
+	dev_info->default_txportconf.ring_size = SXE2_RING_SIZE_MIN;
+
+	dev_info->rx_seg_capa.offset_allowed = false;
+
+	dev_info->rx_seg_capa.offset_align_log2 = false;
+
+	return 0;
+}
+
+static const struct eth_dev_ops sxe2_switchdev_repr_dev_ops = {
+	.dev_configure              = sxe2_repr_dev_configure,
+
+	.dev_start                  = sxe2_repr_dev_start,
+	.dev_stop                   = sxe2_repr_dev_stop,
+
+	.rx_queue_start             = sxe2_rx_queue_start,
+	.rx_queue_stop              = sxe2_rx_queue_stop,
+	.tx_queue_start             = sxe2_tx_queue_start,
+	.tx_queue_stop              = sxe2_tx_queue_stop,
+	.rx_queue_setup             = sxe2_rx_queue_setup,
+	.rx_queue_release           = sxe2_rx_queue_release,
+	.tx_queue_setup             = sxe2_tx_queue_setup,
+	.tx_queue_release           = sxe2_tx_queue_release,
+
+	.dev_close                  = sxe2_repr_dev_close,
+	.dev_infos_get              = sxe2_repr_dev_infos_get,
+	.dev_supported_ptypes_get   = sxe2_dev_supported_ptypes_get,
+	.link_update                = sxe2_link_update,
+
+	.promiscuous_enable         = sxe2_repr_promisc_enable,
+	.promiscuous_disable        = sxe2_repr_promisc_disable,
+	.allmulticast_enable        = sxe2_repr_allmulti_enable,
+	.allmulticast_disable       = sxe2_repr_allmulti_disable,
+
+	.stats_get                  = sxe2_stats_info_get,
+	.stats_reset                = sxe2_stats_info_reset,
+	.xstats_get                 = sxe2_xstats_info_get,
+	.xstats_get_names           = sxe2_xstats_names_get,
+	.xstats_reset               = sxe2_stats_info_reset,
+};
+
+void sxe2_repr_all_close(struct rte_eth_dev *dev)
+{
+	uint16_t vf_id;
+	struct rte_eth_dev *repr_eth_dev = NULL;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (adapter->repr_ctxt.nb_repr_vf) {
+		for (vf_id = 0; vf_id < adapter->repr_ctxt.nb_repr_vf; vf_id++) {
+			repr_eth_dev = adapter->repr_ctxt.vf_rep_eth_dev[vf_id];
+			if (!repr_eth_dev || repr_eth_dev->data->dev_started == 0)
+				continue;
+
+			(void)rte_eth_dev_stop(repr_eth_dev->data->port_id);
+			(void)rte_eth_dev_close(repr_eth_dev->data->port_id);
+		}
+	}
+}
+
+static void sxe2_repr_adapter_init(struct rte_eth_dev *dev_repr,
+				   struct sxe2_adapter *parent_adapter,
+				   uint16_t repr_id)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev_repr);
+
+	dev_repr->data->backer_port_id = parent_adapter->dev_port_id;
+	dev_repr->data->representor_id = repr_id;
+	dev_repr->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
+
+	adapter->is_dev_repr = true;
+	adapter->dev_port_id = dev_repr->data->port_id;
+	adapter->dev_type = parent_adapter->dev_type;
+	adapter->switchdev_info.is_switchdev = parent_adapter->switchdev_info.is_switchdev;
+	adapter->port_idx = parent_adapter->port_idx;
+	adapter->pf_idx = parent_adapter->pf_idx;
+	adapter->dev_info.pci = parent_adapter->dev_info.pci;
+	adapter->dev_info.fw = parent_adapter->dev_info.fw;
+}
+
+static int32_t sxe2_repr_eth_init(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+
+	ret = sxe2_filter_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize l2 filter, ret:%d", ret);
+		goto l_end;
+	}
+	ret = sxe2_link_update_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize link update, ret:%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_mac_addr_init(dev);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to initialize mac address, ret:%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_repr_dev_pci_map_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *rep_adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_pci_map_context *map_ctxt = &rep_adapter->map_ctxt;
+	struct sxe2_pci_map_bar_info *bar_info = NULL;
+	struct sxe2_pci_map_segment_info *seg_info = NULL;
+	uint16_t txq_cnt = rep_adapter->q_ctxt.qp_cnt_assign;
+	uint16_t txq_base = rep_adapter->q_ctxt.base_idx_in_pf;
+	uint16_t rxq_cnt = rep_adapter->q_ctxt.qp_cnt_assign;
+	uint16_t rxq_base = rep_adapter->q_ctxt.base_idx_in_pf;
+	uint16_t irq_cnt = rep_adapter->irq_ctxt.max_cnt_hw;
+	uint16_t irq_base = rep_adapter->irq_ctxt.base_idx_in_func;
+	int32_t ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	rep_adapter->dev_info.dev_data = dev->data;
+
+	map_ctxt->bar_cnt = 2;
+
+	bar_info = rte_zmalloc("repr_bar_info",
+			sizeof(struct sxe2_pci_map_bar_info) * map_ctxt->bar_cnt, 0);
+	if (bar_info == NULL) {
+		PMD_LOG_ERR(INIT, "Failed to alloc bar_info");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	bar_info[0].bar_idx = 0;
+	bar_info[0].map_cnt = SXE2_PCI_MAP_RES_MAX_COUNT;
+	seg_info = rte_zmalloc("repr_seg_info_bar0",
+			sizeof(struct sxe2_pci_map_segment_info) * bar_info[0].map_cnt, 0);
+	if (seg_info == NULL) {
+		PMD_LOG_ERR(INIT, "Failed to alloc seg_info");
+		ret = -ENOMEM;
+		goto l_free_bar;
+	}
+
+	bar_info[0].seg_info = seg_info;
+
+	bar_info[1].bar_idx = 4;
+	bar_info[1].map_cnt = SXE2_PCI_MAP_RES_MAX_COUNT;
+	seg_info = rte_zmalloc("repr_seg_info_bar4",
+			sizeof(struct sxe2_pci_map_segment_info) * bar_info[1].map_cnt,
+			0);
+	if (!seg_info) {
+		PMD_LOG_ERR(INIT, "Failed to alloc seg_info");
+		ret = -ENOMEM;
+		goto l_free_seg0;
+	}
+
+	bar_info[1].seg_info = seg_info;
+	map_ctxt->bar_info = bar_info;
+
+	map_ctxt->addr_info = sxe2_net_map_addr_info_repr;
+
+	ret = sxe2_dev_pci_res_seg_map(rep_adapter, SXE2_PCI_MAP_RES_DOORBELL_TX,
+			txq_cnt, txq_base);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to map txq doorbell addr, ret=%d", ret);
+		goto l_free_seg1;
+	}
+
+	ret = sxe2_dev_pci_res_seg_map(rep_adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL,
+			rxq_cnt, rxq_base);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to map rxq tail doorbell addr, ret=%d", ret);
+		goto l_free_txq;
+	}
+
+	ret = sxe2_dev_pci_res_seg_map(rep_adapter, SXE2_PCI_MAP_RES_IRQ_DYN,
+			irq_cnt, irq_base);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to map irq dyn addr, ret=%d", ret);
+		goto l_free_rxq_tail;
+	}
+
+	ret = sxe2_dev_pci_res_seg_map(rep_adapter, SXE2_PCI_MAP_RES_IRQ_ITR,
+			irq_cnt, irq_base);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to map irq itr addr, ret=%d", ret);
+		goto l_free_irq_dyn;
+	}
+
+	ret = sxe2_dev_pci_res_seg_map(rep_adapter, SXE2_PCI_MAP_RES_IRQ_MSIX,
+			irq_cnt, irq_base);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to map irq msix addr, ret=%d", ret);
+		goto l_free_irq_itr;
+	}
+	goto l_end;
+
+l_free_irq_itr:
+	(void)sxe2_dev_pci_seg_unmap(rep_adapter, SXE2_PCI_MAP_RES_IRQ_ITR);
+l_free_irq_dyn:
+	(void)sxe2_dev_pci_seg_unmap(rep_adapter, SXE2_PCI_MAP_RES_IRQ_DYN);
+l_free_rxq_tail:
+	(void)sxe2_dev_pci_seg_unmap(rep_adapter, SXE2_PCI_MAP_RES_DOORBELL_RX_TAIL);
+l_free_txq:
+	(void)sxe2_dev_pci_seg_unmap(rep_adapter, SXE2_PCI_MAP_RES_DOORBELL_TX);
+l_free_seg1:
+	if (bar_info[1].seg_info) {
+		rte_free(bar_info[1].seg_info);
+		bar_info[1].seg_info = NULL;
+	}
+l_free_seg0:
+	if (bar_info[0].seg_info) {
+		rte_free(bar_info[0].seg_info);
+		bar_info[0].seg_info = NULL;
+	}
+l_free_bar:
+	if (bar_info) {
+		rte_free(bar_info);
+		bar_info = NULL;
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_repr_dev_init(struct rte_eth_dev *dev,
+			   struct sxe2_adapter *parent_adapter,
+			   uint16_t repr_id)
+{
+	int32_t ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe2_set_common_function(dev);
+
+	sxe2_repr_adapter_init(dev, parent_adapter, repr_id);
+
+	dev->dev_ops = &sxe2_switchdev_repr_dev_ops;
+
+	ret = sxe2_vsi_repr_main_vsi_create(dev, parent_adapter, repr_id);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to create representor main vsi, ret=[%d]", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_switchdev_repr_private_data_init(dev, parent_adapter, repr_id);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to fill representor private data, ret=[%d]", ret);
+		goto l_init_priv_data_err;
+	}
+
+	ret = sxe2_repr_dev_pci_map_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to pci addr map, ret=[%d]", ret);
+		goto l_init_pci_error;
+	}
+
+	ret = sxe2_switchdev_dev_info_init(dev, parent_adapter);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get device info, ret=[%d]", ret);
+		goto l_init_dev_info_err;
+	}
+
+	ret = sxe2_flow_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init flow, ret=%d", ret);
+		goto l_init_flow_err;
+	}
+
+	ret = sxe2_repr_eth_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init device, status = %d", ret);
+		goto l_init_eth_err;
+	}
+
+	ret = sxe2_sw_irq_ctxt_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize sw parameters, ret=[%d]", ret);
+		goto l_init_sw_err;
+	}
+
+	goto l_end;
+
+l_init_sw_err:
+	sxe2_eth_uinit(dev);
+l_init_eth_err:
+	(void)sxe2_flow_uninit(dev);
+l_init_flow_err:
+l_init_dev_info_err:
+	sxe2_dev_pci_map_uinit(dev);
+l_init_pci_error:
+	(void)sxe2_switchdev_uninit(dev);
+l_init_priv_data_err:
+	sxe2_vsi_repr_main_vsi_destroy(dev);
+l_end:
+	return ret;
+}
+
+static void sxe2_repr_dev_uinit(struct rte_eth_dev *dev)
+{
+	sxe2_eth_uinit(dev);
+	(void)sxe2_flow_uninit(dev);
+	sxe2_dev_pci_map_uinit(dev);
+	(void)sxe2_switchdev_uninit(dev);
+	sxe2_vsi_repr_main_vsi_destroy(dev);
+}
+
+int32_t sxe2_switchdev_repr_devs_init(struct sxe2_adapter *adapter,
+				  struct rte_eth_devargs *req_eth_da)
+{
+	struct rte_eth_dev *eth_dev = NULL;
+	int32_t ret;
+	uint16_t repr_idx = 0, tmp_repr_idx = 0;
+	char name[RTE_ETH_NAME_MAX_LEN];
+
+	if (req_eth_da->nb_representor_ports == 0) {
+		ret = 0;
+		goto l_end;
+	}
+
+	if (req_eth_da->nb_representor_ports > adapter->repr_ctxt.nb_vf) {
+		PMD_LOG_ERR(INIT, "Failed to create repr vsi, nb_representor_ports=%d, nb_vf=%d",
+			    req_eth_da->nb_representor_ports, adapter->repr_ctxt.nb_vf);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_other_vsi_create(adapter, req_eth_da->nb_representor_ports);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to create representor vsi, ret=%d", ret);
+		goto l_release_port;
+	}
+
+	adapter->repr_ctxt.vf_rep_eth_dev = rte_zmalloc("sxe2_repr_ethdev",
+			req_eth_da->nb_representor_ports * sizeof(struct rte_eth_dev *), 0);
+	if (adapter->repr_ctxt.vf_rep_eth_dev == NULL) {
+		PMD_LOG_ERR(INIT, "Failed to malloc representor eth dev.");
+		ret = -ENOMEM;
+		goto l_release_port;
+	}
+
+	for (repr_idx = 0; repr_idx < req_eth_da->nb_representor_ports; ++repr_idx) {
+		snprintf(name, sizeof(name), "sxe2_representor_c%dpf%d%s%u",
+			 adapter->pf_idx, adapter->pf_idx,
+			 "vf",
+			 req_eth_da->representor_ports[repr_idx]);
+
+		eth_dev = rte_eth_dev_allocate(name);
+		if (!eth_dev) {
+			ret = -ENOMEM;
+			goto l_release_port;
+		}
+		eth_dev->data->dev_private = rte_zmalloc_socket(name,
+			sizeof(struct sxe2_adapter),
+			RTE_CACHE_LINE_SIZE,
+			rte_socket_id());
+
+		if (!eth_dev->data->dev_private) {
+			rte_eth_dev_release_port(eth_dev);
+			ret = -ENOMEM;
+			goto l_release_port;
+		}
+
+		eth_dev->device = rte_eth_devices[adapter->dev_info.dev_data->port_id].device;
+
+		ret = sxe2_repr_dev_init(eth_dev, adapter,
+					 req_eth_da->representor_ports[repr_idx]);
+		if (ret) {
+			PMD_LOG_ERR(INIT, "Sxe2 dev init failed, ret=%d", ret);
+			rte_eth_dev_release_port(eth_dev);
+			goto l_release_port;
+		}
+
+		eth_dev->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_SHARED);
+		if (eth_dev->intr_handle == NULL) {
+			PMD_LOG_ERR(INIT, "Sxe2 dev init representor intr_handle failed");
+			ret = -ENOMEM;
+			sxe2_repr_dev_uinit(eth_dev);
+			rte_eth_dev_release_port(eth_dev);
+			goto l_release_port;
+		}
+		adapter->repr_ctxt.vf_rep_eth_dev[repr_idx] = eth_dev;
+		rte_eth_dev_probing_finish(eth_dev);
+	}
+	adapter->repr_ctxt.nb_repr_vf = req_eth_da->nb_representor_ports;
+	goto l_end;
+
+l_release_port:
+	for (tmp_repr_idx = 0; tmp_repr_idx < repr_idx; ++tmp_repr_idx) {
+		struct rte_eth_dev *rep_dev = adapter->repr_ctxt.vf_rep_eth_dev[tmp_repr_idx];
+		if (rep_dev) {
+			sxe2_repr_dev_uinit(rep_dev);
+			if (rep_dev->intr_handle)
+				rte_intr_instance_free(rep_dev->intr_handle);
+			rte_eth_dev_release_port(rep_dev);
+			adapter->repr_ctxt.vf_rep_eth_dev[tmp_repr_idx] = NULL;
+		}
+	}
+
+	rte_free(adapter->repr_ctxt.vf_rep_eth_dev);
+	adapter->repr_ctxt.vf_rep_eth_dev = NULL;
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.h b/drivers/net/sxe2/sxe2_ethdev_repr.h
new file mode 100644
index 0000000000..71a666337f
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SX2_ETHDEV_REPR_H__
+#define __SX2_ETHDEV_REPR_H__
+#include <rte_compat.h>
+#include <rte_kvargs.h>
+#include <rte_time.h>
+#include <ethdev_driver.h>
+#include <ethdev_pci.h>
+#include <rte_tm_driver.h>
+#include <rte_io.h>
+#include <rte_ethdev.h>
+#include <rte_alarm.h>
+#include <rte_dev_info.h>
+
+#include "sxe2_vsi.h"
+#include "sxe2_irq.h"
+#include "sxe2_queue.h"
+struct sxe2_adapter;
+
+void sxe2_repr_all_close(struct rte_eth_dev *dev);
+
+int32_t sxe2_repr_dev_init(struct rte_eth_dev *dev,
+		       struct sxe2_adapter *parent_adapter,
+		       uint16_t repr_id);
+
+int32_t sxe2_switchdev_repr_devs_init(struct sxe2_adapter *adapter,
+				  struct rte_eth_devargs *req_eth_da);
+
+#endif /* __SX2_ETHDEV_REPR_H__ */
diff --git a/drivers/net/sxe2/sxe2_filter.c b/drivers/net/sxe2/sxe2_filter.c
index cfeeb7a6c3..696242ed0c 100644
--- a/drivers/net/sxe2/sxe2_filter.c
+++ b/drivers/net/sxe2/sxe2_filter.c
@@ -9,6 +9,7 @@
 #include "sxe2_common_log.h"
 #include "sxe2_ethdev.h"
 #include "sxe2_cmd_chnl.h"
+#include "sxe2_switchdev.h"
 
 static struct sxe2_mac_filter *sxe2_uc_filter_find(struct sxe2_adapter *adapter,
 			struct rte_ether_addr *macaddr)
@@ -700,16 +701,96 @@ static int32_t sxe2_all_filter_hw_set(struct sxe2_adapter *adapter)
 	return ret;
 }
 
+static int32_t sxe2_uplink_hw_clear(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (adapter->filter_ctxt.hw_uplink_config) {
+		if (adapter->dev_type == SXE2_DEV_T_PF) {
+			ret = sxe2_uplink_clear(adapter);
+			if (ret) {
+				PMD_DEV_LOG_ERR(adapter, DRV,
+						"Failed to clear uplink, ret:%d", ret);
+				goto l_end;
+			}
+			adapter->filter_ctxt.hw_uplink_config = false;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_uplink_hw_set(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->filter_ctxt.hw_uplink_config) {
+		if (adapter->dev_type == SXE2_DEV_T_PF) {
+			ret = sxe2_uplink_set(adapter);
+			if (ret && ret != -EEXIST) {
+				PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set uplink, ret:%d", ret);
+				goto l_end;
+			}
+			adapter->filter_ctxt.hw_uplink_config = true;
+			ret = 0;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_repr_hw_clear(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (adapter->filter_ctxt.hw_repr_config) {
+		if (adapter->dev_type == SXE2_DEV_T_PF ||
+			adapter->dev_type == SXE2_DEV_T_PF_BOND) {
+			ret = sxe2_repr_clear(adapter);
+			if (ret) {
+				PMD_DEV_LOG_ERR(adapter, DRV, "Failed to clear repr, ret:%d", ret);
+				goto l_end;
+			}
+			adapter->filter_ctxt.hw_repr_config = false;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_repr_hw_set(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->filter_ctxt.hw_repr_config) {
+		if (adapter->dev_type == SXE2_DEV_T_PF ||
+			adapter->dev_type == SXE2_DEV_T_PF_BOND) {
+			ret = sxe2_repr_set(adapter);
+			if (ret && ret != -EEXIST) {
+				PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set repr, ret:%d", ret);
+				goto l_end;
+			}
+			adapter->filter_ctxt.hw_repr_config = true;
+			ret = 0;
+		}
+	}
+l_end:
+	return ret;
+}
+
 int32_t sxe2_l2_rule_update(struct sxe2_adapter *adapter)
 {
 	int32_t ret = 0;
 
-	if (!adapter->flow_isolated && !adapter->switchdev_info.is_switchdev &&
-	    adapter->rule_started) {
+	if (!adapter->flow_isolated &&
+	    !adapter->switchdev_info.is_switchdev &&
+	    adapter->rule_started)
 		adapter->filter_ctxt.cur_l2_config = true;
-	} else {
+	else
 		adapter->filter_ctxt.cur_l2_config = false;
-	}
 
 	if (adapter->filter_ctxt.cur_l2_config !=
 	    adapter->filter_ctxt.hw_l2_config) {
@@ -726,6 +807,38 @@ int32_t sxe2_l2_rule_update(struct sxe2_adapter *adapter)
 	return ret;
 }
 
+int32_t sxe2_switchdev_rule_update(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->flow_isolated &&
+	    adapter->switchdev_info.is_switchdev) {
+		adapter->filter_ctxt.cur_uplink_config = true;
+		adapter->filter_ctxt.cur_repr_config = true;
+	} else {
+		adapter->filter_ctxt.cur_uplink_config = false;
+		adapter->filter_ctxt.cur_repr_config = false;
+	}
+
+	if (adapter->filter_ctxt.cur_uplink_config !=
+	    adapter->filter_ctxt.hw_uplink_config) {
+		if (adapter->filter_ctxt.cur_uplink_config)
+			ret = sxe2_uplink_hw_set(adapter);
+		else
+			ret = sxe2_uplink_hw_clear(adapter);
+	}
+
+	if (adapter->filter_ctxt.cur_repr_config !=
+	    adapter->filter_ctxt.hw_repr_config) {
+		if (adapter->filter_ctxt.cur_repr_config)
+			ret = sxe2_repr_hw_set(adapter);
+		else
+			ret = sxe2_repr_hw_clear(adapter);
+	}
+
+	return ret;
+}
+
 int32_t sxe2_filter_rule_stop(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
diff --git a/drivers/net/sxe2/sxe2_filter.h b/drivers/net/sxe2/sxe2_filter.h
index 6262e8c845..b2538ed22f 100644
--- a/drivers/net/sxe2/sxe2_filter.h
+++ b/drivers/net/sxe2/sxe2_filter.h
@@ -89,6 +89,8 @@ int32_t sxe2_l2_rule_update(struct sxe2_adapter *adapter);
 
 int32_t sxe2_filter_rule_stop(struct rte_eth_dev *dev);
 
+int32_t sxe2_switchdev_rule_update(struct sxe2_adapter *adapter);
+
 int32_t sxe2_filter_rule_start(struct rte_eth_dev *dev);
 
 int32_t sxe2_filter_init(struct rte_eth_dev *dev);
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
new file mode 100644
index 0000000000..6999cb0725
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -0,0 +1,1337 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <sys/queue.h>
+#include <unistd.h>
+#include "sxe2_ethdev.h"
+#include "sxe2_flow.h"
+#include "sxe2_flow_parse_pattern.h"
+#include "sxe2_flow_parse_action.h"
+#include "sxe2_flow_parse_engine.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_flow_public.h"
+#include "sxe2_common_log.h"
+
+static int32_t sxe2_check_para(const struct rte_flow_attr *attr,
+			   const struct rte_flow_item pattern[],
+			   const struct rte_flow_action actions[],
+			   struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	if (!pattern) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
+				NULL, "NULL pattern.");
+		ret = -rte_errno;
+		goto l_end;
+	}
+
+	if (!actions) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION_NUM,
+				NULL, "NULL action.");
+		ret = -rte_errno;
+		goto l_end;
+	}
+
+	if (!attr) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR,
+				NULL, "NULL attribute.");
+		ret = -rte_errno;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_valid_attr(const struct rte_flow_attr *attr, struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+
+	if (!attr->ingress) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
+				attr, "Only support ingress.");
+		ret = -rte_errno;
+		goto l_end;
+	}
+
+	if (attr->egress) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
+				attr, "Not support egress.");
+		ret = -rte_errno;
+		goto l_end;
+	}
+
+	if (attr->group >= 4) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
+				attr, "Not support group >= 4.");
+		ret = -rte_errno;
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_check_hdr_duplicate(struct sxe2_flow_item *item_new,
+					 struct sxe2_flow_item *item_exist)
+{
+	int32_t ret = 0;
+	uint16_t i = 0;
+	uint16_t size = sizeof(struct sxe2_flow_item);
+	union sxe2_flow_item_raw item_raw_new;
+	union sxe2_flow_item_raw item_raw_exist;
+	rte_memcpy(&item_raw_new.item, item_new, size);
+	rte_memcpy(&item_raw_exist.item, item_exist, size);
+
+	for (i = 0; i < size; i++) {
+		if (item_raw_new.raw[i] != item_raw_exist.raw[i])
+			goto l_end;
+	}
+	ret = -EEXIST;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_check_flow_duplicate(struct sxe2_flow *flow_new,
+					      struct sxe2_flow *flow_exist)
+{
+	int32_t ret = 0;
+	int32_t ret_mask1 = 0;
+	int32_t ret_mask2 = 0;
+	int32_t ret_spec1 = 0;
+	int32_t ret_spec2 = 0;
+
+	if (flow_new->engine_type != flow_exist->engine_type)
+		goto l_end;
+	if (flow_new->meta.flow_type != flow_exist->meta.flow_type)
+		goto l_end;
+	if (!sxe2_bitmap_equal(flow_new->flow_type, flow_exist->flow_type,
+			SXE2_EXPANSION_MAX))
+		goto l_end;
+	if (flow_new->meta.flow_prio != flow_exist->meta.flow_prio)
+		goto l_end;
+
+	ret_mask1 = sxe2_flow_check_hdr_duplicate(&flow_new->pattern_outer.item_mask,
+						  &flow_exist->pattern_outer.item_mask);
+	ret_mask2 = sxe2_flow_check_hdr_duplicate(&flow_new->pattern_inner.item_mask,
+						  &flow_exist->pattern_inner.item_mask);
+
+	ret_spec1 = sxe2_flow_check_hdr_duplicate(&flow_new->pattern_outer.item_spec,
+						  &flow_exist->pattern_outer.item_spec);
+	ret_spec2 = sxe2_flow_check_hdr_duplicate(&flow_new->pattern_inner.item_spec,
+						  &flow_exist->pattern_inner.item_spec);
+
+	if (flow_new->engine_type == SXE2_FLOW_ENGINE_FNAV) {
+		if (ret_mask1 == 0 || ret_mask2 == 0) {
+			ret = -EEXIST;
+			goto l_end;
+		}
+
+		if (ret_spec1 == -EEXIST && ret_spec2 == -EEXIST) {
+			ret = -EEXIST;
+			goto l_end;
+		}
+	} else {
+		if (ret_mask1 == -EEXIST && ret_mask2 == -EEXIST &&
+			ret_spec1 == -EEXIST && ret_spec2 == -EEXIST) {
+			ret = -EEXIST;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_check_flow_list_duplicate(struct rte_eth_dev *dev,
+						   struct rte_flow *flow_list)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_flow *sxe2_flow_new = NULL;
+	struct rte_flow *rte_flow_exist = NULL;
+	struct sxe2_flow *sxe2_flow_exist = NULL;
+	TAILQ_FOREACH(sxe2_flow_new, &flow_list->sxe2_flow_list, next) {
+		TAILQ_FOREACH(rte_flow_exist, &adapter->flow_ctxt.rte_flow_list, next) {
+			TAILQ_FOREACH(sxe2_flow_exist, &rte_flow_exist->sxe2_flow_list, next) {
+				ret = sxe2_flow_check_flow_duplicate(sxe2_flow_new,
+								     sxe2_flow_exist);
+				if (ret != 0)
+					goto l_end;
+			}
+		}
+	}
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_check_function(struct rte_eth_dev *dev,
+				    struct rte_flow *flow_list,
+				    struct rte_flow_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_flow_list_t *sxe2_flow_list = &flow_list->sxe2_flow_list;
+	struct sxe2_flow *flow = TAILQ_FIRST(sxe2_flow_list);
+	int32_t ret = 0;
+
+	uint16_t flow_dst_vsi = UINT16_MAX;
+
+	if (adapter->dev_type == SXE2_DEV_T_VF) {
+		if (sxe2_test_bit(SXE2_FLOW_ACTION_TO_VSI, flow->action.act_types)) {
+			flow_dst_vsi = flow->action.vsi.vsi_index;
+
+			if (adapter->vsi_ctxt.dpdk_vsi_id != flow_dst_vsi &&
+				adapter->vsi_ctxt.kernel_vsi_id != flow_dst_vsi) {
+				PMD_LOG_ERR(DRV, "Failed to redirect other function");
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to redirect other function");
+				ret = -ENOTSUP;
+				goto l_end;
+			}
+		}
+
+		if (sxe2_test_bit(SXE2_FLOW_ACTION_TO_VSI_LIST, flow->action.act_types)) {
+			PMD_LOG_ERR(DRV,
+				"Failed to redirect multiple driver or function");
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to redirect multiple driver or function");
+				ret = -ENOTSUP;
+				goto l_end;
+		}
+
+		if (!adapter->flow_isolated &&
+			flow->engine_type == SXE2_FLOW_ENGINE_SWITCH) {
+			PMD_LOG_ERR(DRV,
+				"Failed to switch engine rules in a non-flow-isolated state");
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to switch engine rules in a non-flow-isolated state");
+				ret = -ENOTSUP;
+				goto l_end;
+		}
+
+		if (adapter->switchdev_info.is_switchdev &&
+			flow->engine_type == SXE2_FLOW_ENGINE_SWITCH) {
+			PMD_LOG_ERR(DRV,
+				"Failed to switch engine rules in a switchdev mode state");
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to switch engine rules in a switchdev mode state");
+				ret = -ENOTSUP;
+				goto l_end;
+		}
+	}
+
+	if (adapter->is_dev_repr) {
+		if (flow->engine_type != SXE2_FLOW_ENGINE_SWITCH) {
+			PMD_LOG_ERR(DRV,
+				"Failed to config non switch engine rules in representor dev");
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to config non switch engine rules in representor dev");
+				ret = -ENOTSUP;
+				goto l_end;
+		}
+
+		if (sxe2_test_bit(SXE2_FLOW_ACTION_QUEUE, flow->action.act_types) ||
+			sxe2_test_bit(SXE2_FLOW_ACTION_Q_REGION, flow->action.act_types)) {
+			PMD_LOG_ERR(DRV,
+				"Failed to config queue rules in representor dev");
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"Failed to config queue rules in representor dev");
+				ret = -ENOTSUP;
+				goto l_end;
+		}
+	}
+
+	if (adapter->switchdev_info.is_switchdev &&
+		adapter->dev_type == SXE2_DEV_T_PF &&
+		!adapter->is_dev_repr &&
+		!adapter->flow_isolated) {
+		if (sxe2_test_bit(SXE2_FLOW_ACTION_TO_VSI, flow->action.act_types)) {
+			if (flow->action.vsi.vsi_index == adapter->vsi_ctxt.dpdk_vsi_id) {
+				PMD_LOG_ERR(DRV,
+					"Failed to config rx fwd rule to current uplink dev");
+					rte_flow_error_set(error, ENOTSUP,
+						RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+						"Failed to config rx fwd rule to current uplink dev");
+					ret = -ENOTSUP;
+					goto l_end;
+			}
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_meta_proc(struct rte_eth_dev *dev,
+			       const struct rte_flow_attr *attr,
+			       struct rte_flow *flow_list,
+			       struct rte_flow_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_flow_list_t *sxe2_flow_list = &flow_list->sxe2_flow_list;
+	struct sxe2_flow *flow = TAILQ_FIRST(sxe2_flow_list);
+	int32_t ret = 0;
+
+	if (attr->priority >= 1) {
+		if (flow->engine_type != SXE2_FLOW_ENGINE_SWITCH) {
+			PMD_LOG_ERR(DRV, "Only support priority 0.");
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
+					attr, "Only support priority 0.");
+			ret = -rte_errno;
+			goto l_end;
+		} else if (!adapter->switchdev_info.is_switchdev) {
+			PMD_LOG_ERR(DRV, "Legacy mode only support priority 0.");
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
+					attr, "Legacy mode only priority 0.");
+			ret = -rte_errno;
+			goto l_end;
+		} else {
+			flow->meta.flow_prio = attr->priority;
+		}
+	}
+
+	flow->meta.flow_src_vsi = adapter->vsi_ctxt.dpdk_vsi_id;
+
+	if (adapter->is_dev_repr && adapter->repr_priv_data &&
+		adapter->repr_priv_data->parent_adapter) {
+		flow->meta.flow_rule_vsi =
+			adapter->repr_priv_data->parent_adapter->vsi_ctxt.dpdk_vsi_id;
+	} else {
+		flow->meta.flow_rule_vsi = adapter->vsi_ctxt.dpdk_vsi_id;
+	}
+
+	if (flow->engine_type == SXE2_FLOW_ENGINE_SWITCH) {
+		flow->meta.switch_pattern_dup_allow =
+			adapter->devargs.flow_dup_pattern_mode;
+
+		flow->meta.switch_src_direct = SXE2_FLOW_SW_DIRECT_RX;
+
+		if (adapter->switchdev_info.is_switchdev && adapter->is_dev_repr) {
+			flow->meta.switch_src_direct = SXE2_FLOW_SW_DIRECT_TX;
+			flow->meta.flow_src_vsi = adapter->repr_priv_data->repr_vf_vsi_id;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_src_split_proc(struct rte_eth_dev *dev,
+				    struct rte_flow *flow_list,
+				    struct rte_flow_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_flow_list_t *sxe2_flow_list = &flow_list->sxe2_flow_list;
+	struct sxe2_flow *flow = TAILQ_FIRST(sxe2_flow_list);
+	int32_t ret = 0;
+
+	int32_t idx = 0;
+	uint8_t flow_cnt = 0;
+	uint8_t flow_create_cnt = 0;
+	uint8_t flow_bond_num = 1;
+	uint16_t flow_src_vsi[SXE2_MAX_DRV_TYPE_CNT][SXE2_MAX_BOND_MEMBER_CNT];
+	uint16_t flow_dst_vsi = UINT16_MAX;
+	struct sxe2_flow *flow_new = NULL;
+
+	if (sxe2_test_bit(SXE2_FLOW_ACTION_TO_VSI, flow->action.act_types))
+		flow_dst_vsi = flow->action.vsi.vsi_index;
+
+	for (idx = 0; idx < SXE2_MAX_BOND_MEMBER_CNT; idx++) {
+		flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx] = UINT16_MAX;
+		flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] = UINT16_MAX;
+	}
+
+	flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][0] = adapter->vsi_ctxt.dpdk_vsi_id;
+	flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][0] = adapter->vsi_ctxt.kernel_vsi_id;
+	if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV ||
+		flow->engine_type == SXE2_FLOW_ENGINE_ACL) {
+		if (!adapter->devargs.func_flow_direct_en &&
+			adapter->dev_type != SXE2_DEV_T_PF_BOND) {
+			if (adapter->flow_isolated) {
+				for (idx = 0; idx < flow_bond_num; idx++) {
+					if (flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] !=
+								UINT16_MAX)
+						flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx] =
+										UINT16_MAX;
+				}
+			} else {
+				for (idx = 0; idx < flow_bond_num; idx++)
+					flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] = UINT16_MAX;
+			}
+		}
+
+		for (idx = 0; idx < flow_bond_num; idx++) {
+			if (flow_dst_vsi == flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx])
+				flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] = UINT16_MAX;
+			if (flow_dst_vsi == flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx])
+				flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx] = UINT16_MAX;
+		}
+	} else {
+		for (idx = 0; idx < flow_bond_num; idx++)
+			flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] = UINT16_MAX;
+	}
+
+	if (adapter->switchdev_info.is_switchdev && adapter->is_dev_repr) {
+		flow_bond_num = 1;
+		flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][0] =
+			adapter->repr_priv_data->repr_vf_u_vsi_id;
+		flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][0] =
+			adapter->repr_priv_data->repr_vf_k_vsi_id;
+	}
+
+	for (idx = 0; idx < flow_bond_num; idx++) {
+		if (flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] != UINT16_MAX)
+			flow_cnt++;
+		if (flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx] != UINT16_MAX)
+			flow_cnt++;
+	}
+
+	if (flow_cnt == 0) {
+		PMD_LOG_ERR(DRV, "Failed to redirect same device.");
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to redirect same device");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (idx = 0; idx < flow_bond_num; idx++) {
+		if (flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx] != UINT16_MAX) {
+			if (flow_create_cnt == 0) {
+				flow->meta.flow_src_vsi =
+					flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx];
+				flow_create_cnt++;
+			} else {
+				flow_new = rte_zmalloc("sxe2_flow", sizeof(*flow), 0);
+				if (!flow_new) {
+					rte_flow_error_set(error, ENOMEM,
+						   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+						   "Failed to alloc memory for flow rule");
+					ret = -ENOMEM;
+					goto l_end;
+				}
+				rte_memcpy(flow_new, flow, sizeof(struct sxe2_flow));
+				TAILQ_INSERT_TAIL(sxe2_flow_list, flow_new, next);
+				flow_new->meta.flow_src_vsi =
+						flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx];
+				flow_create_cnt++;
+			}
+		}
+		if (flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx] != UINT16_MAX) {
+			if (flow_create_cnt == 0) {
+				flow->meta.flow_src_vsi =
+					flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx];
+				flow_create_cnt++;
+			} else {
+				flow_new = rte_zmalloc("sxe2_flow", sizeof(*flow), 0);
+				if (!flow_new) {
+					rte_flow_error_set(error, ENOMEM,
+						RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+						"Failed to alloc memory for flow rule");
+					ret = -ENOMEM;
+					goto l_end;
+				}
+				rte_memcpy(flow_new, flow, sizeof(struct sxe2_flow));
+				TAILQ_INSERT_TAIL(sxe2_flow_list, flow_new, next);
+				flow_new->meta.flow_src_vsi =
+					flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx];
+				flow_create_cnt++;
+			}
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_adjust_action(struct rte_eth_dev *dev __rte_unused,
+				   struct rte_flow *flow_list,
+				   struct rte_flow_error *error __rte_unused)
+{
+	struct sxe2_flow_list_t *sxe2_flow_list = &flow_list->sxe2_flow_list;
+	struct sxe2_flow *flow = NULL;
+	int32_t ret = 0;
+	int32_t dest_num = 0;
+	int32_t pass_num = 0;
+	int32_t mark_num = 0;
+	int32_t count_num = 0;
+	int32_t drop_num = 0;
+
+	TAILQ_FOREACH(flow, sxe2_flow_list, next) {
+		if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV) {
+			dest_num = sxe2_test_bit(SXE2_FLOW_ACTION_Q_REGION,
+					    flow->action.act_types) +
+				   sxe2_test_bit(SXE2_FLOW_ACTION_QUEUE,
+					    flow->action.act_types);
+			pass_num = sxe2_test_bit(SXE2_FLOW_ACTION_PASSTHRU,
+					    flow->action.act_types);
+			mark_num = sxe2_test_bit(SXE2_FLOW_ACTION_MARK,
+					    flow->action.act_types);
+			count_num = sxe2_test_bit(SXE2_FLOW_ACTION_COUNT,
+					     flow->action.act_types);
+			drop_num = sxe2_test_bit(SXE2_FLOW_ACTION_DROP,
+					    flow->action.act_types);
+
+			if (dest_num) {
+				sxe2_clear_bit(SXE2_FLOW_ACTION_PASSTHRU,
+					  flow->action.act_types);
+				pass_num = 0;
+				sxe2_clear_bit(SXE2_FLOW_ACTION_TO_VSI,
+					  flow->action.act_types);
+			}
+
+			if (pass_num)
+				flow->action.passthru.vsi_index = flow->meta.flow_src_vsi;
+
+			if (mark_num) {
+				if (dest_num == 0) {
+					flow->action.q_region.q_index = 0;
+					flow->action.q_region.region = 7;
+					flow->action.q_region.vsi_index = flow->meta.flow_src_vsi;
+					sxe2_set_bit(SXE2_FLOW_ACTION_Q_REGION,
+						flow->action.act_types);
+					dest_num++;
+				}
+				sxe2_clear_bit(SXE2_FLOW_ACTION_PASSTHRU,
+					flow->action.act_types);
+				pass_num = 0;
+			}
+			if (count_num) {
+				if (dest_num == 0 && drop_num == 0) {
+					if (pass_num == 0) {
+						sxe2_set_bit(SXE2_FLOW_ACTION_PASSTHRU,
+							flow->action.act_types);
+						flow->action.passthru.vsi_index =
+									flow->meta.flow_src_vsi;
+						pass_num++;
+					}
+				}
+			}
+			PMD_LOG_DEBUG(DRV, "dest_num: %d, pass_num: %d, mark_num: %d, count_num: "
+				"%d, drop_num: %d", dest_num, pass_num, mark_num, count_num,
+				drop_num);
+			PMD_LOG_DEBUG(DRV, "src_vsi: %d", flow->meta.flow_src_vsi);
+		}
+	}
+
+	return ret;
+}
+
+static int32_t sxe2_flow_check_item_empty(uint8_t *item, uint16_t size)
+{
+	uint16_t i = 0;
+
+	for (i = 0; i < size; i++) {
+		if (item[i] != 0)
+			return -1;
+	}
+	return 0;
+}
+
+static int32_t sxe2_flowlist_add_proto_type(struct rte_eth_dev *dev __rte_unused,
+					struct rte_flow *flow_list,
+					struct rte_flow_error *error)
+{
+	struct sxe2_flow_list_t *sxe2_flow_list = &flow_list->sxe2_flow_list;
+	struct sxe2_flow *flow = TAILQ_FIRST(sxe2_flow_list);
+	struct sxe2_flow_pattern *pattern = &flow->pattern_outer;
+	int32_t ret = 0;
+
+	if (flow->engine_type == SXE2_FLOW_ENGINE_SWITCH) {
+		if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4, flow->flow_type) &&
+		    sxe2_flow_check_item_empty((uint8_t *)&pattern->item_mask.ipv4,
+			sizeof(pattern->item_mask.ipv4)) == 0) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_TYPE, pattern->map_spec);
+			pattern->item_spec.eth.ether_type =
+				rte_cpu_to_be_16(SXE2_FLOW_ETH_TYPE_IPV4);
+			pattern->item_mask.eth.ether_type = 0xffff;
+		}
+		if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6, flow->flow_type) &&
+		    sxe2_flow_check_item_empty((uint8_t *)&pattern->item_mask.ipv6,
+			sizeof(pattern->item_mask.ipv6)) == 0) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_TYPE, pattern->map_spec);
+			pattern->item_spec.eth.ether_type =
+				rte_cpu_to_be_16(SXE2_FLOW_ETH_TYPE_IPV6);
+			pattern->item_mask.eth.ether_type = 0xffff;
+		}
+
+		if (flow->meta.tunnel_type == SXE2_FLOW_TUNNEL_TYPE_NONE) {
+			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_UDP, flow->flow_type) &&
+			    sxe2_flow_check_item_empty((uint8_t *)&pattern->item_mask.udp,
+				sizeof(pattern->item_mask.udp)) == 0) {
+				if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4,
+					     flow->flow_type)) {
+					sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, pattern->map_spec);
+					pattern->item_spec.ipv4.protocol =
+						SXE2_FLOW_IP_PROTOCOL_UDP;
+					pattern->item_mask.ipv4.protocol = 0xff;
+				}
+				if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6,
+					     flow->flow_type)) {
+					ret = -EINVAL;
+					rte_flow_error_set(error, ENOENT,
+						RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+						"UDP after IPv6 must has pattern item.");
+					PMD_LOG_ERR(DRV,
+						"UDP after IPv6 must has pattern item.");
+					goto l_end;
+				}
+			}
+			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_TCP, flow->flow_type) &&
+			    sxe2_flow_check_item_empty((uint8_t *)&pattern->item_mask.tcp,
+				sizeof(pattern->item_mask.tcp)) == 0) {
+				if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV4,
+					     flow->flow_type)) {
+					sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT,
+						pattern->map_spec);
+					pattern->item_spec.ipv4.protocol =
+						SXE2_FLOW_IP_PROTOCOL_TCP;
+					pattern->item_mask.ipv4.protocol = 0xff;
+				}
+				if (sxe2_test_bit(SXE2_EXPANSION_OUTER_IPV6,
+					     flow->flow_type)) {
+					ret = -EINVAL;
+					rte_flow_error_set(error, ENOENT,
+						RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+						"TCP after IPv6 must has pattern item.");
+					PMD_LOG_ERR(DRV,
+						"TCP after IPv6 must has pattern item.");
+					goto l_end;
+				}
+			}
+			if (sxe2_test_bit(SXE2_EXPANSION_OUTER_SCTP,
+				     flow->flow_type)) {
+				ret = -EINVAL;
+				rte_flow_error_set(error, ENOENT,
+					RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					"SWITCH not support SCTP.");
+				PMD_LOG_ERR(DRV, "SWITCH not support SCTP.");
+				goto l_end;
+			}
+		}
+	}
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_tunnel_split_proc(struct rte_eth_dev *dev __rte_unused,
+				       struct rte_flow *flow_list,
+				       struct rte_flow_error *error)
+{
+	struct sxe2_flow_list_t *sxe2_flow_list = &flow_list->sxe2_flow_list;
+	struct sxe2_flow_list_t tunnel_flow_list;
+	struct sxe2_flow *sxe2_flow_exist = NULL;
+	struct sxe2_flow *sxe2_flow_new = NULL;
+	struct sxe2_flow_pattern *pattern = NULL;
+	int32_t ret = 0;
+
+	TAILQ_INIT(&tunnel_flow_list);
+
+	TAILQ_FOREACH(sxe2_flow_exist, sxe2_flow_list, next) {
+		if (sxe2_flow_exist->engine_type != SXE2_FLOW_ENGINE_SWITCH)
+			continue;
+		if (sxe2_test_bit(SXE2_FLOW_FLD_ID_IPV4_PROT,
+				sxe2_flow_exist->pattern_outer.map_spec)) {
+			pattern = &sxe2_flow_exist->pattern_outer;
+			if ((pattern->item_spec.ipv4.protocol &
+				pattern->item_mask.ipv4.protocol) ==
+				(SXE2_FLOW_IP_PROTOCOL_GRE &
+				pattern->item_mask.ipv4.protocol)) {
+				sxe2_flow_new = rte_zmalloc("sxe2_flow",
+					sizeof(struct sxe2_flow), 0);
+				if (!sxe2_flow_new) {
+					rte_flow_error_set(error, ENOMEM,
+						RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+						"Failed to alloc memory for flow rule");
+					ret = -ENOMEM;
+					goto l_end;
+				}
+				rte_memcpy(sxe2_flow_new, sxe2_flow_exist,
+					sizeof(struct sxe2_flow));
+				pattern = &sxe2_flow_new->pattern_outer;
+				sxe2_flow_new->meta.tunnel_type =
+					SXE2_FLOW_TUNNEL_TYPE_GRE;
+				sxe2_set_bit(SXE2_FLOW_HDR_GRE, pattern->hdrs);
+				pattern->item_spec.ipv4.protocol =
+					SXE2_FLOW_IP_PROTOCOL_GRE;
+				pattern->item_mask.ipv4.protocol = 0xff;
+				TAILQ_INSERT_TAIL(&tunnel_flow_list, sxe2_flow_new, next);
+			}
+		}
+	}
+	TAILQ_FOREACH(sxe2_flow_exist, &tunnel_flow_list, next)
+		TAILQ_INSERT_TAIL(sxe2_flow_list, sxe2_flow_exist, next);
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_post_proc(struct rte_eth_dev *dev,
+			       const struct rte_flow_attr *attr,
+			       struct rte_flow *flow_list,
+			       struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+
+	ret = sxe2_flowlist_add_proto_type(dev, flow_list, error);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_flow_check_function(dev, flow_list, error);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_flow_meta_proc(dev, attr, flow_list, error);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_flow_src_split_proc(dev, flow_list, error);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_flow_adjust_action(dev, flow_list, error);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_flow_tunnel_split_proc(dev, flow_list, error);
+	if (ret)
+		goto l_end;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_validate_with_flow(struct rte_eth_dev *dev,
+					struct rte_flow *flow_list,
+					const struct rte_flow_attr *attr,
+					const struct rte_flow_item pattern[],
+					const struct rte_flow_action actions[],
+					struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_flow *flow = NULL;
+
+	ret = sxe2_check_para(attr, pattern, actions, error);
+	if (ret != 0)
+		goto l_end;
+
+	ret = sxe2_flow_valid_attr(attr, error);
+	if (ret != 0)
+		goto l_end;
+
+	flow = rte_zmalloc("sxe2_flow", sizeof(*flow), 0);
+	if (!flow) {
+		rte_flow_error_set(error, ENOMEM,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to alloc memory for flow rule");
+		PMD_LOG_ERR(DRV, "Failed to alloc memory for flow rule.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	TAILQ_INSERT_TAIL(&flow_list->sxe2_flow_list, flow, next);
+	flow->create_err = -1;
+
+	ret = sxe2_flow_parse_pattern(dev, pattern, error, flow);
+	if (ret != 0)
+		goto l_end;
+
+	ret = sxe2_flow_parse_engine(dev, attr, actions, error, flow);
+	if (ret != 0)
+		goto l_end;
+
+	ret = sxe2_flow_parse_action(dev, actions, error, flow);
+	if (ret != 0)
+		goto l_end;
+
+	ret = sxe2_flow_post_proc(dev, attr, flow_list, error);
+	if (ret != 0)
+		goto l_end;
+
+	ret = sxe2_flow_check_flow_list_duplicate(dev, flow_list);
+	if (ret != 0) {
+		rte_flow_error_set(error, EEXIST, RTE_FLOW_ERROR_TYPE_ITEM,
+				NULL, "Duplicate flow.");
+		PMD_LOG_ERR(DRV, "Duplicate flow.");
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+static const char *sxe2_flow_convert_ret_to_flow_msg(int32_t ret)
+{
+	const char *msg = NULL;
+	if (ret > 0)
+		ret = -ret;
+	switch (ret) {
+	case -ENOMEM:
+		msg = "no memory";
+		break;
+	case -ENOTSUP:
+		msg = "not support";
+		break;
+	case -EEXIST:
+		msg = "rule already exist";
+		break;
+	case -ETIMEDOUT:
+		msg = "timeout";
+		break;
+	case -EINVAL:
+		msg = "invalid parameter";
+		break;
+	case -ENOSPC:
+		msg = "no space";
+		break;
+	case -ENOENT:
+		msg = "no such rule";
+		break;
+	default:
+		msg = "unknown error";
+		break;
+	}
+	return msg;
+}
+
+static int32_t sxe2_flow_rte_list_free(struct sxe2_adapter *adapter,
+				   struct rte_flow **flow_ptr,
+				   struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	int32_t ret1 = 0;
+	struct rte_flow *flow = *flow_ptr;
+	struct rte_flow *flow_temp = NULL;
+	struct sxe2_flow *hw_flow = NULL;
+	struct sxe2_flow *hw_flow_temp = NULL;
+	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	rte_spinlock_lock(&adapter->flow_ctxt.flow_list_lock);
+	TAILQ_FOREACH(flow_temp, &adapter->flow_ctxt.rte_flow_list, next) {
+		if (flow_temp == flow)
+			TAILQ_REMOVE(&adapter->flow_ctxt.rte_flow_list, flow, next);
+	}
+
+	TAILQ_FOREACH_SAFE(hw_flow, &flow->sxe2_flow_list, next, hw_flow_temp) {
+		if (hw_flow->create_err == 0) {
+			if (sxe2_test_bit(SXE2_FLOW_ACTION_COUNT, hw_flow->action.act_types)) {
+				ret = sxe2_flow_query_mgr(adapter, hw_flow, &mgr, error);
+				if (ret) {
+					PMD_LOG_ERR(DRV,
+						"Failed to query flow count, flow id: %u, ret: %d.",
+						hw_flow->flow_id, ret);
+					rte_flow_error_set(error, EIO,
+						RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+						"Failed to query flow count");
+					ret1 = ret;
+				}
+			}
+
+			ret = sxe2_drv_flow_filter_del(adapter, hw_flow);
+			if (ret) {
+				PMD_LOG_ERR(DRV,
+					"Failed to delete flow filter, ret: %d:%s",
+					ret, sxe2_flow_convert_ret_to_flow_msg(ret));
+				rte_flow_error_set(error, EIO,
+					RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					"Failed to delete flow filter");
+				ret1 = ret;
+			}
+
+			if (sxe2_test_bit(SXE2_FLOW_ACTION_COUNT, hw_flow->action.act_types)) {
+				ret = sxe2_flow_free_mgr(adapter, hw_flow,
+							 &mgr, error);
+				if (ret)
+					ret1 = ret;
+			}
+		}
+
+		TAILQ_REMOVE(&flow->sxe2_flow_list, hw_flow, next);
+		rte_free(hw_flow);
+	}
+	rte_free(flow);
+	*flow_ptr = NULL;
+	rte_spinlock_unlock(&adapter->flow_ctxt.flow_list_lock);
+
+	return ret1;
+}
+
+static int32_t sxe2_flow_validate(struct rte_eth_dev *dev,
+			      const struct rte_flow_attr *attr,
+			      const struct rte_flow_item pattern[],
+			      const struct rte_flow_action actions[],
+			      struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct rte_flow *flow_list = NULL;
+	struct sxe2_flow *hw_flow = NULL;
+	struct sxe2_flow *hw_flow_temp = NULL;
+	flow_list = rte_zmalloc("rte_flow_va", sizeof(*flow_list), 0);
+	if (!flow_list) {
+		rte_flow_error_set(error, ENOMEM,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Failed to alloc memory for flow rule");
+		PMD_LOG_ERR(DRV, "Failed to alloc memory for flow rule.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	TAILQ_INIT(&flow_list->sxe2_flow_list);
+
+	ret = sxe2_flow_validate_with_flow(dev, flow_list, attr, pattern, actions, error);
+	if (ret != 0)
+		goto l_free;
+l_free:
+
+	TAILQ_FOREACH_SAFE(hw_flow, &flow_list->sxe2_flow_list, next, hw_flow_temp) {
+		TAILQ_REMOVE(&flow_list->sxe2_flow_list, hw_flow, next);
+		rte_free(hw_flow);
+	}
+	rte_free(flow_list);
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_isolate(struct rte_eth_dev *dev,
+				 int32_t enable,
+				 struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (dev->data->dev_started) {
+		rte_flow_error_set(error, EBUSY,
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				   NULL,
+				   "port must be stopped first");
+		ret = -EBUSY;
+		goto l_end;
+	}
+
+	if (adapter->is_dev_repr) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"representor dev cannot change isolated mode ");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (enable == adapter->flow_isolated)
+		goto l_end;
+
+	if (adapter->dev_type == SXE2_DEV_T_VF &&
+		adapter->switchdev_info.is_switchdev) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"isolated mode cannot be change when port in switch dev mode");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	rte_spinlock_lock(&adapter->flow_ctxt.flow_list_lock);
+	if (!TAILQ_EMPTY(&adapter->flow_ctxt.rte_flow_list))
+		PMD_DEV_LOG_WARN(adapter, DRV,
+			"The configured flow item may not take effect.");
+	rte_spinlock_unlock(&adapter->flow_ctxt.flow_list_lock);
+
+	adapter->flow_isolated = !!enable;
+
+	ret = sxe2_l2_rule_update(adapter);
+	if (ret != 0)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to update l2 rule");
+
+	ret = sxe2_switchdev_rule_update(adapter);
+	if (ret != 0)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to update switchdev rule");
+
+l_end:
+	if (ret == 0)
+		adapter->flow_isolate_cfg = !!enable;
+	return ret;
+}
+
+static struct rte_flow *sxe2_flow_create(struct rte_eth_dev *dev,
+					 const struct rte_flow_attr *attr,
+					 const struct rte_flow_item pattern[],
+					 const struct rte_flow_action action[],
+					 struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_flow *flow_list = NULL;
+	struct sxe2_flow *flow = NULL;
+
+	flow_list = rte_zmalloc("sxe2_flow_create", sizeof(*flow_list), 0);
+	if (!flow_list) {
+		rte_flow_error_set(error, ENOMEM,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Failed to alloc memory for flow rule");
+		PMD_LOG_ERR(DRV, "Failed to alloc memory for flow rule.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	TAILQ_INIT(&flow_list->sxe2_flow_list);
+
+	ret = sxe2_flow_validate_with_flow(dev, flow_list, attr, pattern, action, error);
+	if (ret != 0)
+		goto l_free_flow;
+
+	TAILQ_FOREACH(flow, &flow_list->sxe2_flow_list, next) {
+		ret = sxe2_fnav_get_filter_cid(adapter, flow);
+		if (ret != 0) {
+			PMD_LOG_ERR(DRV, "fnav get stats id failed, ret:%d", ret);
+			rte_flow_error_set(error, EIO,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Failed to add fnav rule:alloc cid failed.");
+			goto l_free_flow;
+		}
+		ret = sxe2_drv_flow_filter_add(adapter, flow);
+		if (ret) {
+			rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				   "Failed to add flow filter to hw.");
+			PMD_LOG_ERR(DRV, "Failed to add flow filter to hw.ret:%d:%s",
+				ret, sxe2_flow_convert_ret_to_flow_msg(ret));
+			goto l_free_flow;
+		}
+	}
+
+	TAILQ_INSERT_TAIL(&adapter->flow_ctxt.rte_flow_list, flow_list, next);
+	goto l_end;
+l_free_flow:
+	(void)sxe2_flow_rte_list_free(adapter, &flow_list, error);
+l_end:
+	return flow_list;
+}
+
+static int32_t sxe2_flow_destroy(struct rte_eth_dev *dev,
+			     struct rte_flow *flow,
+			     struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	ret = sxe2_flow_rte_list_free(adapter, &flow, error);
+	if (ret)
+		PMD_LOG_ERR(DRV, "Failed to destroy flow.ret:%d.", ret);
+	return ret;
+}
+
+static int32_t sxe2_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_flow *flow = NULL;
+	struct rte_flow *tmp_flow = NULL;
+	struct rte_flow_list_t *flow_list = &adapter->flow_ctxt.rte_flow_list;
+	TAILQ_FOREACH_SAFE(flow, flow_list, next, tmp_flow) {
+		ret = sxe2_flow_destroy(dev, flow, error);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "Failed to flush flows.ret:%d.", ret);
+
+			if (ret != -EAGAIN)
+				ret = -EINVAL;
+			goto l_end;
+		}
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow)
+{
+	int32_t ret = 0;
+	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
+				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
+	uint32_t stat_index;
+	uint32_t user_id;
+	uint32_t driver_id;
+	struct sxe2_fnav_cid_mgr *temp = NULL;
+	struct sxe2_fnav_cid_mgr *mgr = NULL;
+
+	if (sxe2_test_bit(SXE2_FLOW_ACTION_COUNT, flow->action.act_types)) {
+		user_id = flow->action.count.user_id;
+		driver_id = flow->action.count.driver_id;
+
+		TAILQ_FOREACH(temp, cid_mgr_list, next) {
+			if (temp->user_id == user_id &&
+				temp->driver_id == driver_id) {
+				mgr = temp;
+				break;
+			}
+		}
+		if (mgr == NULL) {
+			mgr = rte_zmalloc("sxe2_fnav_cid_mgr",
+				sizeof(struct sxe2_fnav_cid_mgr), 0);
+			if (!mgr) {
+				PMD_LOG_ERR(DRV,
+					"Failed to alloc sxe2vf_fnav_cid_mgr memory.");
+				ret = -ENOMEM;
+				goto l_end;
+			}
+
+			ret = sxe2_drv_flow_fnav_get_stat_id(adapter, &stat_index);
+			if (ret) {
+				PMD_LOG_ERR(DRV, "Failed to alloc fw count id.");
+				rte_free(mgr);
+				goto l_end;
+			}
+
+			TAILQ_INSERT_TAIL(cid_mgr_list, mgr, next);
+			mgr->user_id = user_id;
+			mgr->driver_id = driver_id;
+			mgr->stat_index = stat_index;
+			mgr->count_type = adapter->flow_ctxt.hw_res.count_type;
+		}
+		flow->action.count.stat_index = mgr->stat_index;
+		flow->action.count.stat_ctrl = mgr->count_type;
+	}
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
+		       struct sxe2_flow *flow,
+		       struct sxe2_fnav_cid_mgr **mgr_ptr,
+		       struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
+				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
+	struct sxe2_fnav_cid_mgr *mgr = *mgr_ptr;
+	uint32_t user_id = flow->action.count.user_id;
+	if (user_id == 0) {
+		TAILQ_REMOVE(cid_mgr_list, mgr, next);
+		ret = sxe2_drv_flow_fnav_free_stat(adapter, mgr->stat_index);
+		if (ret) {
+			rte_flow_error_set(error, EIO,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Failed to free flow count.");
+			PMD_LOG_ERR(DRV,
+				"Failed to free flow count, flow id: %u, ret: %d.",
+				flow->flow_id, ret);
+		}
+		rte_free(mgr);
+		*mgr_ptr = NULL;
+	}
+	return ret;
+}
+
+int32_t sxe2_flow_query_mgr(struct sxe2_adapter *adapter,
+			struct sxe2_flow *flow,
+			struct sxe2_fnav_cid_mgr **mgr_ptr,
+			struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
+				&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
+	struct sxe2_fnav_cid_mgr *temp = NULL;
+	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	uint32_t user_id = flow->action.count.user_id;
+	uint32_t driver_id = flow->action.count.driver_id;
+
+	TAILQ_FOREACH(temp, cid_mgr_list, next) {
+		if (temp->user_id == user_id &&
+			temp->driver_id == driver_id) {
+			mgr = temp;
+			break;
+		}
+	}
+	if (!mgr) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"fnav flow query count invalid user_id or driver_id.");
+		PMD_LOG_ERR(DRV,
+			"fnav flow query count invalid user_id or driver_id.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	ret = sxe2_drv_flow_fnav_query_stat(adapter, mgr);
+	if (ret) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+			"Failed to query flow count.");
+		PMD_LOG_ERR(DRV,
+			"Failed to query flow count, flow id: %u, ret: %d.",
+			flow->flow_id, ret);
+		goto l_end;
+	}
+	*mgr_ptr = mgr;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_query_count(struct sxe2_adapter *adapter,
+				 struct sxe2_flow *flow,
+				 struct rte_flow_query_count *count,
+				 struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	switch (flow->action.count.stat_ctrl) {
+	case SXE2_FNAV_STAT_ENA_NONE:
+		count->hits_set = 0;
+		count->bytes_set = 0;
+		break;
+	case SXE2_FNAV_STAT_ENA_PKTS:
+		count->hits_set = 1;
+		count->bytes_set = 0;
+		break;
+	case SXE2_FNAV_STAT_ENA_BYTES:
+		count->hits_set = 0;
+		count->bytes_set = 1;
+		break;
+	case SXE2_FNAV_STAT_ENA_ALL:
+		count->hits_set = 1;
+		count->bytes_set = 1;
+		break;
+	default:
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (!sxe2_test_bit(SXE2_FLOW_ACTION_COUNT, flow->action.act_types)) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"this flow don't have count action.");
+		PMD_LOG_ERR(DRV, "this flow don't have count action.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	ret = sxe2_flow_query_mgr(adapter, flow, &mgr, error);
+	if (ret) {
+		PMD_LOG_ERR(DRV,
+			"Failed to query flow count, flow id: %u, ret: %d.",
+			flow->flow_id, ret);
+		goto l_end;
+	}
+	count->hits = mgr->hits;
+	count->bytes = mgr->bytes;
+	if (count->reset) {
+		mgr->hits = 0;
+		mgr->bytes = 0;
+	}
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_query(struct rte_eth_dev *dev,
+			   struct rte_flow *flow_list,
+			   const struct rte_flow_action *actions,
+			   void *data,
+			   struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct rte_flow_query_count *count = data;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_flow *flow = NULL;
+
+	if (!flow_list) {
+		ret = -EINVAL;
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
+				NULL, "Invalid flow");
+		PMD_LOG_ERR(DRV, "Invalid flow to query flow.");
+		goto l_end;
+	}
+
+	rte_spinlock_lock(&adapter->flow_ctxt.flow_list_lock);
+	for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
+		switch (actions->type) {
+		case RTE_FLOW_ACTION_TYPE_VOID:
+			break;
+		case RTE_FLOW_ACTION_TYPE_COUNT:
+			flow = TAILQ_FIRST(&flow_list->sxe2_flow_list);
+			ret = sxe2_flow_query_count(adapter, flow, count, error);
+			if (ret) {
+				PMD_LOG_ERR(DRV,
+					"Failed to query flow count, flow id: %u, ret: %d.",
+					flow->flow_id, ret);
+				goto l_end_unlock;
+			}
+			break;
+		default:
+			rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION,
+					actions,
+					"action not supported");
+			PMD_LOG_ERR(DRV,
+					"Failed to query flow action type:%d.",
+					actions->type);
+			ret = -ENOTSUP;
+			goto l_end_unlock;
+		}
+	}
+
+l_end_unlock:
+	rte_spinlock_unlock(&adapter->flow_ctxt.flow_list_lock);
+
+l_end:
+	return ret;
+}
+
+const struct rte_flow_ops sxe2_flow_ops = {
+	.validate = sxe2_flow_validate,
+	.create = sxe2_flow_create,
+	.destroy = sxe2_flow_destroy,
+	.flush = sxe2_flow_flush,
+	.query = sxe2_flow_query,
+	.isolate = sxe2_flow_isolate,
+};
+
+int32_t sxe2_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops)
+{
+	int32_t ret = 0;
+
+	if (dev == NULL) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	*ops = &sxe2_flow_ops;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_flow_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	TAILQ_INIT(&adapter->flow_ctxt.rte_flow_list);
+	TAILQ_INIT(&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list);
+	if (adapter->devargs.fnav_stat_type)
+		adapter->flow_ctxt.hw_res.count_type =
+			adapter->devargs.fnav_stat_type;
+	else
+		adapter->flow_ctxt.hw_res.count_type = SXE2_FNAV_STAT_ENA_ALL;
+
+	adapter->flow_ctxt.fnav_inited = 1;
+	rte_spinlock_init(&adapter->flow_ctxt.flow_list_lock);
+	return ret;
+}
+
+int32_t sxe2_flow_uninit(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_flow_error error;
+	struct sxe2_fnav_cid_mgr *mgr = NULL;
+	struct sxe2_fnav_cid_mgr *temp = NULL;
+	struct sxe2_fnav_cid_mgr_list_t *cid_mgr_list =
+						&adapter->flow_ctxt.hw_res.fnav_cid_mgr_list;
+
+	ret = sxe2_flow_flush(dev, &error);
+	if (ret)
+		PMD_LOG_ERR(DRV, "Failed to flush flow, ret: %d.", ret);
+
+	TAILQ_FOREACH_SAFE(mgr, cid_mgr_list, next, temp) {
+		TAILQ_REMOVE(cid_mgr_list, mgr, next);
+		ret = sxe2_drv_flow_fnav_free_stat(adapter, mgr->stat_index);
+		if (ret)
+			PMD_LOG_ERR(DRV,
+				"Failed to free fnav stat id, ret: %d.", ret);
+		rte_free(mgr);
+	}
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_flow.h b/drivers/net/sxe2/sxe2_flow.h
new file mode 100644
index 0000000000..9970fddcf0
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_FLOW_H__
+#define __SXE2_FLOW_H__
+#include <rte_flow_driver.h>
+#include "sxe2_osal.h"
+#include "sxe2_common.h"
+
+
+int32_t sxe2_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops);
+
+int32_t sxe2_flow_init(struct rte_eth_dev *dev);
+
+int32_t sxe2_flow_uninit(struct rte_eth_dev *dev);
+
+int32_t sxe2_fnav_get_filter_cid(struct sxe2_adapter *adapter, struct sxe2_flow *flow);
+
+int32_t sxe2_flow_free_mgr(struct sxe2_adapter *adapter,
+		       struct sxe2_flow *flow,
+		       struct sxe2_fnav_cid_mgr **mgr_ptr,
+		       struct rte_flow_error *error);
+
+int32_t sxe2_flow_query_mgr(struct sxe2_adapter *adapter,
+			struct sxe2_flow *flow,
+			struct sxe2_fnav_cid_mgr **mgr_ptr,
+			struct rte_flow_error *error);
+#endif /* __SXE2_FLOW_H__ */
diff --git a/drivers/net/sxe2/sxe2_flow_parse_action.c b/drivers/net/sxe2/sxe2_flow_parse_action.c
new file mode 100644
index 0000000000..a9559e2d7e
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow_parse_action.c
@@ -0,0 +1,1182 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_flow_parse_action.h"
+#include "sxe2_common_log.h"
+#include "sxe2_flow_public.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_vsi.h"
+
+
+static int32_t sxe2_flow_check_rss_action_attr(const struct rte_flow_action_rss *rss,
+					   struct rte_flow_error *error)
+{
+	int32_t ret = ENOTSUP;
+	switch (rss->func) {
+	case RTE_ETH_HASH_FUNCTION_DEFAULT:
+	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
+	case RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ:
+	case RTE_ETH_HASH_FUNCTION_SIMPLE_XOR:
+		break;
+	default:
+		PMD_LOG_ERR(DRV, "RSS hash function[%d] not support.", rss->func);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (rss->level > 2)
+		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"RSS  level is could not be greater than 2");
+	if (rss->key_len)
+		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"a nonzero RSS key_len is not supported");
+	if (rss->queue_num)
+		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"a non-NULL RSS queue is not supported");
+	ret = 0;
+l_end:
+	return ret;
+}
+
+
+static int32_t sxe2_flow_set_rss_action_func(enum rte_eth_hash_function rss_func,
+					 uint64_t rss_type,
+					 struct sxe2_flow *flow,
+					 struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	if (rss_func == RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
+		if (flow->has_hdr) {
+			ret = -EINVAL;
+			rte_flow_error_set(error, -EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Failed to cfg Simple XOR hash with not empty pattern");
+			PMD_LOG_ERR(DRV, "Failed to cfg Simple XOR hash with not empty pattern.");
+			goto l_end;
+		}
+	} else {
+		if (!flow->has_hdr) {
+			ret = -EINVAL;
+			rte_flow_error_set(error, -EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Failed to cfg Simple hash with empty pattern");
+			PMD_LOG_ERR(DRV, "Failed to cfg Simple hash with empty pattern.");
+			goto l_end;
+		}
+	}
+
+	if (rss_func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
+		if (rss_type & (RTE_ETH_RSS_L3_SRC_ONLY |
+					RTE_ETH_RSS_L3_DST_ONLY |
+					RTE_ETH_RSS_L4_SRC_ONLY |
+					RTE_ETH_RSS_L4_DST_ONLY)) {
+			ret = -EINVAL;
+			rte_flow_error_set(error, -EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Failed to cfg symm func rss_type l3/l4 only.");
+			PMD_LOG_ERR(DRV, "Failed to cfg symm func rss_type l3/l4 only.");
+			goto l_end;
+		}
+
+		if (!(rss_type & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_IPV6 |
+					RTE_ETH_RSS_FRAG_IPV4 | RTE_ETH_RSS_FRAG_IPV6 |
+					RTE_ETH_RSS_NONFRAG_IPV4_UDP |
+					RTE_ETH_RSS_NONFRAG_IPV6_UDP |
+					RTE_ETH_RSS_NONFRAG_IPV4_TCP |
+					RTE_ETH_RSS_NONFRAG_IPV6_TCP |
+					RTE_ETH_RSS_NONFRAG_IPV4_SCTP |
+					RTE_ETH_RSS_NONFRAG_IPV6_SCTP))) {
+			ret = -EINVAL;
+			rte_flow_error_set(error, -EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Failed to cfg symm func unsupported rss_type.");
+			PMD_LOG_ERR(DRV, "Failed to cfg symm func unsupported rss_type.");
+			goto l_end;
+		}
+		flow->action.rss.func = SXE2_RSS_HASH_FUNC_SYM_TOEPLITZ;
+	}
+	if (rss_func == RTE_ETH_HASH_FUNCTION_SIMPLE_XOR)
+		flow->action.rss.func = SXE2_RSS_HASH_FUNC_XOR;
+	if (rss_func == RTE_ETH_HASH_FUNCTION_DEFAULT)
+		flow->action.rss.func = SXE2_RSS_HASH_FUNC_TOEPLITZ;
+	if (rss_func == RTE_ETH_HASH_FUNCTION_TOEPLITZ)
+		flow->action.rss.func = SXE2_RSS_HASH_FUNC_TOEPLITZ;
+l_end:
+	return ret;
+}
+
+
+static uint64_t sxe2_hash_invalid_comb[] = {
+	RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_NONFRAG_IPV4_UDP,
+	RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_NONFRAG_IPV4_TCP,
+	RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_NONFRAG_IPV4_SCTP,
+	RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_NONFRAG_IPV6_UDP,
+	RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_NONFRAG_IPV6_TCP,
+	RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_NONFRAG_IPV6_SCTP,
+	RTE_ETH_RSS_FRAG_IPV4 | RTE_ETH_RSS_NONFRAG_IPV4_OTHER,
+	RTE_ETH_RSS_FRAG_IPV6 | RTE_ETH_RSS_NONFRAG_IPV6_OTHER,
+	RTE_ETH_RSS_L3_PRE32 | RTE_ETH_RSS_L3_PRE48 | RTE_ETH_RSS_L3_PRE64,
+};
+
+struct sxe2_rss_attr_type {
+	uint64_t attr;
+	uint64_t type;
+};
+
+static struct sxe2_rss_attr_type sxe2_rss_attr_valid_type[] = {
+	{RTE_ETH_RSS_L2_SRC_ONLY | RTE_ETH_RSS_L2_DST_ONLY, RTE_ETH_RSS_ETH},
+	{RTE_ETH_RSS_L3_SRC_ONLY | RTE_ETH_RSS_L3_DST_ONLY, SXE2_VALID_RSS_L3},
+	{RTE_ETH_RSS_L4_SRC_ONLY | RTE_ETH_RSS_L4_DST_ONLY, SXE2_VALID_RSS_L4},
+
+	{RTE_ETH_RSS_L3_PRE32, SXE2_VALID_RSS_IPV6},
+	{RTE_ETH_RSS_L3_PRE48, SXE2_VALID_RSS_IPV6},
+	{RTE_ETH_RSS_L3_PRE64, SXE2_VALID_RSS_IPV6},
+	{SXE2_INVALID_RSS_ATTR, 0}
+};
+
+
+static void sxe2_flow_action_pre(struct sxe2_flow *flow)
+{
+	flow->action.vsi.vsi_index = UINT16_MAX;
+	flow->action.vsi_list.vsi_cnt = 0;
+	sxe2_bitmap_zero(flow->action.vsi_list.vsi_list_map, SXE2_VSI_MAX);
+}
+
+static void sxe2_flow_action_post(struct sxe2_flow *flow, uint8_t action_num[])
+{
+	if (sxe2_test_bit(SXE2_FLOW_ACTION_TO_VSI, flow->action.act_types))
+		action_num[SXE2_FLOW_ACTION_TO_VSI] = 1;
+
+	if (sxe2_test_bit(SXE2_FLOW_ACTION_TO_VSI_LIST, flow->action.act_types))
+		action_num[SXE2_FLOW_ACTION_TO_VSI_LIST] = 1;
+}
+
+
+static void sxe2_flow_action_vsi_merge(struct sxe2_flow *flow, uint16_t add_vsi_id)
+{
+	if (flow->action.vsi_list.vsi_cnt == 0) {
+		if (flow->action.vsi.vsi_index == UINT16_MAX) {
+			flow->action.vsi.vsi_index = add_vsi_id;
+			sxe2_set_bit(SXE2_FLOW_ACTION_TO_VSI, flow->action.act_types);
+			goto l_end;
+		}
+
+		if (flow->action.vsi.vsi_index == add_vsi_id)
+			goto l_end;
+
+		sxe2_set_bit(flow->action.vsi.vsi_index, flow->action.vsi_list.vsi_list_map);
+		sxe2_set_bit(add_vsi_id, flow->action.vsi_list.vsi_list_map);
+		flow->action.vsi_list.vsi_cnt = 2;
+		flow->action.vsi.vsi_index = UINT16_MAX;
+		sxe2_clear_bit(SXE2_FLOW_ACTION_TO_VSI, flow->action.act_types);
+		sxe2_set_bit(SXE2_FLOW_ACTION_TO_VSI_LIST, flow->action.act_types);
+	}
+
+	if (sxe2_test_bit(add_vsi_id, flow->action.vsi_list.vsi_list_map))
+		goto l_end;
+
+	sxe2_set_bit(add_vsi_id, flow->action.vsi_list.vsi_list_map);
+	flow->action.vsi_list.vsi_cnt++;
+
+l_end:
+	return;
+}
+
+
+static int32_t sxe2_flow_vsi_get_ethdev(struct rte_eth_dev *dev,
+				uint16_t dev_port_id, uint16_t *vsi_index)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_eth_dev *dst_dev;
+	struct sxe2_adapter *dst_adapter;
+	int32_t ret = 0;
+
+	dst_dev = &rte_eth_devices[dev_port_id];
+	if (!dst_dev->data) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (!sxe2_ethdev_check(dst_dev)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "dst dev is not sxe2 ethdev.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	dst_adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dst_dev);
+	if (!dst_adapter) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "dst dev adapter is null.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (adapter->dev_info.pci.serial_number != dst_adapter->dev_info.pci.serial_number) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "dst dev sn is miss match current dev.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (adapter->dev_type != SXE2_DEV_T_PF_BOND) {
+		if (adapter->pf_idx != dst_adapter->pf_idx) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "dst dev pf id is miss match current dev.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+
+	if (dst_adapter->is_dev_repr) {
+		if (dst_adapter->repr_priv_data == NULL) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "dst dev repr data is null.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		*vsi_index = dst_adapter->repr_priv_data->repr_vf_vsi_id;
+	} else {
+		*vsi_index = dst_adapter->vsi_ctxt.dpdk_vsi_id;
+	}
+
+l_end:
+	return ret;
+}
+static int32_t sxe2_flow_check_rss_action_type_with_pattern(struct sxe2_flow_pattern *pattern,
+							uint64_t rss_type)
+{
+	uint64_t rss_type_allow = pattern->rss_type_allow;
+	int32_t ret = -EINVAL;
+
+	if ((rss_type & rss_type_allow) != rss_type)
+		goto l_end;
+
+	if (sxe2_test_bit(SXE2_FLOW_HDR_VLAN, pattern->hdrs) &&
+		!sxe2_test_bit(SXE2_FLOW_HDR_QINQ, pattern->hdrs)) {
+		if ((rss_type & RTE_ETH_RSS_C_VLAN) != 0 &&
+			(rss_type & RTE_ETH_RSS_S_VLAN) == 0)
+			goto l_end;
+	}
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_check_rss_action_type_valid(uint64_t rss_type)
+{
+	struct sxe2_rss_attr_type *attr_type;
+	uint32_t i;
+	int32_t ret = -EINVAL;
+
+	for (i = 0; i < RTE_DIM(sxe2_hash_invalid_comb); i++) {
+		if (rte_popcount64(rss_type & sxe2_hash_invalid_comb[i]) > 1) {
+			PMD_LOG_ERR(DRV, "Error rss_type invalid comb[%d].", i);
+			goto l_end;
+		}
+	}
+
+	for (i = 0; i < RTE_DIM(sxe2_rss_attr_valid_type); i++) {
+		attr_type = &sxe2_rss_attr_valid_type[i];
+		if ((attr_type->attr & rss_type) &&
+				!(attr_type->type & rss_type)) {
+			PMD_LOG_ERR(DRV, "Rss_type valid_comb[%d] check error.", i);
+			goto l_end;
+		}
+	}
+
+	ret = 0;
+l_end:
+	return ret;
+}
+
+
+static void sxe2_flow_set_rss_action_type_l234(BITMAP_TYPE *hdr,
+					       BITMAP_TYPE *fld,
+					       uint64_t rss_type)
+{
+	if (rss_type & RTE_ETH_RSS_ETH) {
+		if (rss_type & RTE_ETH_RSS_L2_SRC_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_SA, fld);
+		} else if (rss_type & RTE_ETH_RSS_L2_DST_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_DA, fld);
+		} else {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_SA, fld);
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_DA, fld);
+		}
+	}
+	if (rss_type & RTE_ETH_RSS_L2_PAYLOAD) {
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_TYPE, fld);
+		sxe2_set_bit(SXE2_FLOW_HDR_ETH_NON_IP, hdr);
+	}
+
+	if (sxe2_test_bit(SXE2_FLOW_HDR_VLAN, hdr)) {
+		if (rss_type & RTE_ETH_RSS_S_VLAN)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_S_TCI, fld);
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_QINQ, hdr)) {
+		if (rss_type & RTE_ETH_RSS_C_VLAN)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_C_TCI, fld);
+	}
+
+	if (rss_type & (RTE_ETH_RSS_IPV4 |
+				RTE_ETH_RSS_NONFRAG_IPV4_OTHER |
+				RTE_ETH_RSS_NONFRAG_IPV4_UDP |
+				RTE_ETH_RSS_NONFRAG_IPV4_TCP |
+				RTE_ETH_RSS_NONFRAG_IPV4_SCTP |
+				RTE_ETH_RSS_FRAG_IPV4 |
+				RTE_ETH_RSS_IPV4_CHKSUM)) {
+		if (rss_type & RTE_ETH_RSS_L3_SRC_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_SA, fld);
+		} else if (rss_type & RTE_ETH_RSS_L3_DST_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_DA, fld);
+		} else {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_SA, fld);
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_DA, fld);
+		}
+
+		if (rss_type & RTE_ETH_RSS_NONFRAG_IPV4_OTHER)
+			sxe2_set_bit(SXE2_FLOW_HDR_IPV_OTHER, hdr);
+		if (rss_type & RTE_ETH_RSS_FRAG_IPV4) {
+			sxe2_set_bit(SXE2_FLOW_HDR_IPV_FRAG, hdr);
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_ID, fld);
+		}
+
+		if (rss_type & RTE_ETH_RSS_IPV4_CHKSUM)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_CHKSUM, fld);
+	}
+
+	if (rss_type & (RTE_ETH_RSS_IPV6 |
+				RTE_ETH_RSS_FRAG_IPV6 |
+				RTE_ETH_RSS_NONFRAG_IPV6_OTHER |
+				RTE_ETH_RSS_NONFRAG_IPV6_UDP |
+				RTE_ETH_RSS_NONFRAG_IPV6_TCP |
+				RTE_ETH_RSS_NONFRAG_IPV6_SCTP)) {
+		if (rss_type & RTE_ETH_RSS_L3_PRE32) {
+			if (rss_type & RTE_ETH_RSS_L3_SRC_ONLY) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE32_SA, fld);
+			} else if (rss_type & RTE_ETH_RSS_L3_DST_ONLY) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE32_DA, fld);
+			} else {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE32_SA, fld);
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE32_DA, fld);
+			}
+		} else if (rss_type & RTE_ETH_RSS_L3_PRE48) {
+			if (rss_type & RTE_ETH_RSS_L3_SRC_ONLY) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE48_SA, fld);
+			} else if (rss_type & RTE_ETH_RSS_L3_DST_ONLY) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE48_DA, fld);
+			} else {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE48_SA, fld);
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE48_DA, fld);
+			}
+		} else if (rss_type & RTE_ETH_RSS_L3_PRE64) {
+			if (rss_type & RTE_ETH_RSS_L3_SRC_ONLY) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE64_SA, fld);
+			} else if (rss_type & RTE_ETH_RSS_L3_DST_ONLY) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE64_DA, fld);
+			} else {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE64_SA, fld);
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PRE64_DA, fld);
+			}
+		} else {
+			if (rss_type & RTE_ETH_RSS_L3_SRC_ONLY) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_SA, fld);
+			} else if (rss_type & RTE_ETH_RSS_L3_DST_ONLY) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_DA, fld);
+			} else {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_SA, fld);
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_DA, fld);
+			}
+		}
+		if (rss_type & RTE_ETH_RSS_FRAG_IPV6) {
+			sxe2_set_bit(SXE2_FLOW_HDR_IPV_FRAG, hdr);
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_ID, fld);
+		}
+		if (rss_type & RTE_ETH_RSS_NONFRAG_IPV6_OTHER)
+			sxe2_set_bit(SXE2_FLOW_HDR_IPV_OTHER, hdr);
+	}
+
+	if (rss_type & (RTE_ETH_RSS_NONFRAG_IPV4_TCP |
+				RTE_ETH_RSS_NONFRAG_IPV6_TCP)) {
+		if (rss_type & RTE_ETH_RSS_L4_SRC_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_SRC_PORT, fld);
+		} else if (rss_type & RTE_ETH_RSS_L4_DST_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_DST_PORT, fld);
+		} else {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_SRC_PORT, fld);
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_DST_PORT, fld);
+		}
+		if (rss_type & RTE_ETH_RSS_L4_CHKSUM)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_CHKSUM, fld);
+	}
+
+	if (rss_type & (RTE_ETH_RSS_NONFRAG_IPV4_UDP |
+				RTE_ETH_RSS_NONFRAG_IPV6_UDP)) {
+		if (rss_type & RTE_ETH_RSS_L4_SRC_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_SRC_PORT, fld);
+		} else if (rss_type & RTE_ETH_RSS_L4_DST_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_DST_PORT, fld);
+		} else {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_SRC_PORT, fld);
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_DST_PORT, fld);
+		}
+		if (rss_type & RTE_ETH_RSS_L4_CHKSUM)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_CHKSUM, fld);
+	}
+
+	if (rss_type & (RTE_ETH_RSS_NONFRAG_IPV4_SCTP |
+				RTE_ETH_RSS_NONFRAG_IPV6_SCTP)) {
+		if (rss_type & RTE_ETH_RSS_L4_SRC_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_SRC_PORT, fld);
+		} else if (rss_type & RTE_ETH_RSS_L4_DST_ONLY) {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_DST_PORT, fld);
+		} else {
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_SRC_PORT, fld);
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_DST_PORT, fld);
+		}
+		if (rss_type & RTE_ETH_RSS_L4_CHKSUM)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_CHKSUM, fld);
+	}
+}
+
+
+static int32_t sxe2_flow_set_rss_action_hdr_type(struct sxe2_flow *flow,
+		bool is_inner)
+{
+	struct sxe2_flow_action_rss *rss = &flow->action.rss;
+	BITMAP_TYPE *hdr = rss->hdr_out;
+	int32_t ret = 0;
+
+	rss->hdr_type = SXE2_RSS_ANY_HEADERS;
+	if (!is_inner) {
+		rss->hdr_type = SXE2_RSS_OUTER_HEADERS;
+		goto l_end;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_IPV4, hdr)) {
+		if (sxe2_test_bit(SXE2_FLOW_HDR_UDP, hdr)) {
+			if (sxe2_test_bit(SXE2_FLOW_HDR_GRE, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_UDP_GRE;
+			} else if (sxe2_test_bit(SXE2_FLOW_HDR_GENEVE, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_UDP_GENEVE;
+			} else if (sxe2_test_bit(SXE2_FLOW_HDR_VXLAN, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_UDP_VXLAN;
+			} else if (sxe2_test_bit(SXE2_FLOW_HDR_GTPU, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_UDP_GTPU;
+			}
+		} else {
+			if (sxe2_test_bit(SXE2_FLOW_HDR_GRE, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4_GRE;
+			} else {
+				rss->hdr_type = SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV4;
+			}
+		}
+	} else if (sxe2_test_bit(SXE2_FLOW_HDR_IPV6, hdr)) {
+		if (sxe2_test_bit(SXE2_FLOW_HDR_UDP, hdr)) {
+			if (sxe2_test_bit(SXE2_FLOW_HDR_GRE, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_UDP_GRE;
+			} else if (sxe2_test_bit(SXE2_FLOW_HDR_GENEVE, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_UDP_GENEVE;
+			} else if (sxe2_test_bit(SXE2_FLOW_HDR_VXLAN, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_UDP_VXLAN;
+			} else if (sxe2_test_bit(SXE2_FLOW_HDR_GTPU, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_UDP_GTPU;
+			}
+		} else {
+			if (sxe2_test_bit(SXE2_FLOW_HDR_GRE, hdr)) {
+				rss->hdr_type =
+					SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6_GRE;
+			} else {
+				rss->hdr_type = SXE2_RSS_INNER_HEADERS_WITH_OUTER_IPV6;
+			}
+		}
+	}
+
+l_end:
+	if (rss->hdr_type == SXE2_RSS_ANY_HEADERS) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "Unsupported rss hdr type.");
+	}
+	return ret;
+}
+
+static int32_t sxe2_flow_set_rss_action_level(uint32_t level,
+		struct sxe2_flow *flow, struct rte_flow_error *error)
+{
+	bool is_inner = false;
+	struct sxe2_flow_action_rss *rss = &flow->action.rss;
+	int32_t ret = 0;
+
+	if (flow->meta.tunnel_type != SXE2_FLOW_TUNNEL_TYPE_NONE) {
+		if (level == 0 || level == 2)
+			is_inner = true;
+		else if (level == 1)
+			is_inner = false;
+	} else {
+		if (level == 2) {
+			ret = -EINVAL;
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"RSS hash level 2 is not allowed no tunnel flow.");
+			PMD_LOG_ERR(DRV, "RSS hash level 2 is not allowed no tunnel flow.");
+			goto l_end;
+		}
+		is_inner = false;
+	}
+	rss->is_inner = is_inner;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_set_rss_action_type(uint64_t rss_type,
+		struct sxe2_flow *flow, struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_flow_pattern *pattern = NULL;
+	struct sxe2_flow_action_rss *rss = &flow->action.rss;
+	BITMAP_TYPE *hdr;
+	BITMAP_TYPE *fld;
+	bool is_inner = rss->is_inner;
+
+	ret = sxe2_flow_check_rss_action_type_valid(rss_type);
+	if (ret) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"RSS hash type has invalid combination.");
+		PMD_LOG_ERR(DRV, "RSS hash type has invalid combination.");
+		goto l_end;
+	}
+
+	pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	ret = sxe2_flow_check_rss_action_type_with_pattern(pattern,
+			rss_type);
+	if (ret) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"RSS hash type is not allowed by pattern.");
+		PMD_LOG_ERR(DRV, "RSS hash type is not allowed by pattern.");
+		goto l_end;
+	}
+
+	sxe2_bitmap_copy(rss->hdr_out, flow->pattern_outer.hdrs,
+			SXE2_FLOW_HDR_MAX);
+	sxe2_bitmap_copy(rss->hdr_in, flow->pattern_inner.hdrs,
+			SXE2_FLOW_HDR_MAX);
+	hdr = is_inner ? rss->hdr_in : rss->hdr_out;
+	fld = rss->fld;
+	sxe2_flow_set_rss_action_type_l234(hdr, fld, rss_type);
+
+	ret = sxe2_flow_set_rss_action_hdr_type(flow, is_inner);
+	if (ret) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"Unsupported rss hdr type.");
+		PMD_LOG_ERR(DRV, "Unsupported rss hdr type.");
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_action_rss(const struct rte_flow_action *action,
+				      struct rte_flow_error *error,
+				      struct sxe2_flow *flow)
+{
+	const struct rte_flow_action_rss *rss = action->conf;
+	int32_t ret = 0;
+	uint64_t rss_type = rss->types;
+	enum rte_eth_hash_function rss_func = rss->func;
+	uint32_t level = rss->level;
+
+	rss_type = rte_eth_rss_hf_refine(rss_type);
+
+	ret = sxe2_flow_check_rss_action_attr(rss, error);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_flow_set_rss_action_func(rss_func, rss_type, flow, error);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_flow_set_rss_action_level(level, flow, error);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_flow_set_rss_action_type(rss_type, flow, error);
+	if (ret)
+		goto l_end;
+	sxe2_set_bit(SXE2_FLOW_ACTION_RSS, flow->action.act_types);
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_action_qregion(struct rte_eth_dev *dev,
+		const struct rte_flow_action *action,
+		struct rte_flow_error *error, struct sxe2_flow *flow)
+{
+	int32_t ret = 0;
+	uint8_t i = 0;
+	const struct rte_flow_action_rss *rss = action->conf;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (rss->types != 0 || rss->key_len != 0) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Queue region not support rss types or key.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (rss->queue_num <= 1) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Queue region size can't be 0 or 1.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (i = 0; i < rss->queue_num - 1; i++) {
+		if (rss->queue[i + 1] != rss->queue[i] + 1) {
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					action, "Queue index for queue region is not continuous.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+	if (rss->queue[rss->queue_num - 1] >= adapter->dev_info.dev_data->nb_rx_queues) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Queue index for queue region is out of range.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (!(rte_is_power_of_2(rss->queue_num))) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Queue region size must be power of 2.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	flow->action.q_region.vsi_index = adapter->vsi_ctxt.dpdk_vsi_id;
+	flow->action.q_region.q_index = rss->queue[0];
+	flow->action.q_region.region = (uint8_t)rte_log2_u32(rss->queue_num);
+	sxe2_set_bit(SXE2_FLOW_ACTION_Q_REGION, flow->action.act_types);
+l_end:
+	return ret;
+}
+
+
+static int32_t sxe2_flow_parse_action_queue(struct rte_eth_dev *dev,
+					const struct rte_flow_action *action,
+					struct rte_flow_error *error,
+					struct sxe2_flow *flow)
+{
+	int32_t ret = 0;
+	const struct rte_flow_action_queue *queue = action->conf;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (queue->index >= adapter->dev_info.dev_data->nb_rx_queues) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+			action, "Invalid queue index.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	flow->action.queue.vsi_index = adapter->vsi_ctxt.dpdk_vsi_id;
+	flow->action.queue.q_index = queue->index;
+	sxe2_set_bit(SXE2_FLOW_ACTION_QUEUE, flow->action.act_types);
+l_end:
+	return ret;
+}
+
+
+static int32_t sxe2_flow_parse_action_represented_port(struct rte_eth_dev *dev,
+						   const struct rte_flow_action *action,
+						   struct rte_flow_error *error,
+						   struct sxe2_flow *flow)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	const struct rte_flow_action_ethdev *action_ethdev_conf;
+	const struct rte_eth_dev *dst_repr_dev;
+	uint16_t dst_repr_vsi_id;
+	uint16_t dst_backer_port_id;
+	uint16_t src_backer_port_id;
+	int32_t ret = 0;
+
+	if (!adapter->switchdev_info.is_switchdev) {
+		rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Represented port action only support in switchdev mode.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (adapter->dev_type == SXE2_DEV_T_VF) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"Failed to cfg vf dev type.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	action_ethdev_conf = action->conf;
+	if (!rte_eth_dev_is_valid_port(action_ethdev_conf->port_id)) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Invalid port for represented port action.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	dst_repr_dev = &rte_eth_devices[action_ethdev_conf->port_id];
+	if (!dst_repr_dev->data) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Invalid port for represented port action.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	dst_backer_port_id = dst_repr_dev->data->backer_port_id;
+	if (adapter->is_dev_repr)
+		src_backer_port_id = dev->data->backer_port_id;
+	else
+		src_backer_port_id = adapter->dev_port_id;
+
+	if (src_backer_port_id != dst_backer_port_id) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Represented port action only support to cfg port in same device.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_flow_vsi_get_ethdev(dev, action_ethdev_conf->port_id, &dst_repr_vsi_id);
+	if (ret != 0) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION,
+			action, "Port representor action port dev invalid.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	sxe2_flow_action_vsi_merge(flow, dst_repr_vsi_id);
+l_end:
+	return ret;
+}
+
+
+static int32_t sxe2_flow_parse_action_port_representor(struct rte_eth_dev *dev,
+						   const struct rte_flow_action *action,
+						   struct rte_flow_error *error,
+						   struct sxe2_flow *flow)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	const struct rte_flow_action_ethdev *action_ethdev_conf;
+	uint16_t dst_vsi_id;
+	int32_t ret = 0;
+
+	if (!adapter->switchdev_info.is_switchdev) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"Port representor action only support in switchdev mode.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (adapter->dev_type == SXE2_DEV_T_VF) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"Cfg rule dev type is vf.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (!adapter->is_dev_repr) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"Cfg rule dev type is not repr.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	action_ethdev_conf = action->conf;
+	if (!action_ethdev_conf || !rte_eth_dev_is_valid_port(action_ethdev_conf->port_id)) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Invalid port for port representor action.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (dev->data->backer_port_id != action_ethdev_conf->port_id) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Invalid port for port representor.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_flow_vsi_get_ethdev(dev, action_ethdev_conf->port_id, &dst_vsi_id);
+	if (ret != 0) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION,
+			action, "Port representor action port dev invalid.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	sxe2_flow_action_vsi_merge(flow, dst_vsi_id);
+l_end:
+	return ret;
+}
+
+int32_t sxe2_flow_parse_action_port_id(struct rte_eth_dev *dev,
+				   const struct rte_flow_action *action,
+				   struct rte_flow_error *error,
+				   struct sxe2_flow *flow)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	const struct rte_flow_action_port_id *action_port_id_conf;
+	uint16_t dst_port_id;
+	uint16_t dst_vsi_id;
+	int32_t ret = 0;
+
+	action_port_id_conf = (const struct rte_flow_action_port_id *)action->conf;
+	dst_port_id = action_port_id_conf->original ?
+			adapter->dev_port_id : action_port_id_conf->id;
+
+	if (!rte_eth_dev_is_valid_port(dst_port_id)) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Invalid port id.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_flow_vsi_get_ethdev(dev, dst_port_id, &dst_vsi_id);
+	if (ret != 0) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, action,
+			"Failed to cfg port dev invalid.");
+		goto l_end;
+	}
+
+	sxe2_flow_action_vsi_merge(flow, dst_vsi_id);
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_action_send_to_kernel(struct rte_eth_dev *dev,
+			const struct rte_flow_action *action, struct rte_flow_error *error,
+			struct sxe2_flow *flow)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	if (adapter->vsi_ctxt.kernel_vsi_id == UINT16_MAX) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION, action,
+			"Failed to cfg send to kernel action without kernel vsi.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	sxe2_flow_action_vsi_merge(flow, adapter->vsi_ctxt.kernel_vsi_id);
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_flow_check_actions(struct rte_eth_dev *dev __rte_unused, struct sxe2_flow *flow,
+				   uint8_t action_num[], struct rte_flow_error *error)
+{
+	enum sxe2_flow_engine_type engine_type = flow->engine_type;
+	int32_t ret = 0;
+	int32_t dest_num = action_num[SXE2_FLOW_ACTION_Q_REGION] +
+			   action_num[SXE2_FLOW_ACTION_QUEUE];
+	int32_t vsi_num = action_num[SXE2_FLOW_ACTION_TO_VSI];
+	int32_t vsi_list_num = action_num[SXE2_FLOW_ACTION_TO_VSI_LIST];
+	int32_t pass_num = action_num[SXE2_FLOW_ACTION_PASSTHRU];
+	int32_t drop_num = action_num[SXE2_FLOW_ACTION_DROP];
+	int32_t mark_num = action_num[SXE2_FLOW_ACTION_MARK];
+	int32_t count_num = action_num[SXE2_FLOW_ACTION_COUNT];
+	int32_t rss_num = action_num[SXE2_FLOW_ACTION_RSS];
+	int32_t fwd_num = dest_num + vsi_num + vsi_list_num;
+	int32_t total_num = dest_num + vsi_num + vsi_list_num + pass_num +
+			drop_num + mark_num + count_num + rss_num;
+
+	if (pass_num > 1 || drop_num > 1 || mark_num > 1 ||
+			count_num > 1 || rss_num > 1 || dest_num > 1 ||
+			vsi_num > 1 || vsi_list_num > 1) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"ecah action can only be used once.");
+		PMD_LOG_ERR(DRV, "ecah action can only be used once.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (vsi_list_num && engine_type != SXE2_FLOW_ENGINE_SWITCH) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"VSI_LIST action is only supported for switch engine.");
+		PMD_LOG_ERR(DRV, "VSI_LIST action is only supported for switch engine.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (drop_num) {
+		if (total_num > drop_num + count_num) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Drop action can't be used with other actions unless count.");
+			PMD_LOG_ERR(DRV,
+				"Drop action can't be used with other actions unless count.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+
+	if (fwd_num > 1) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+			"Only supports one type of forwarding action.");
+		PMD_LOG_ERR(DRV, "Only supports one type of forwarding action.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (vsi_list_num) {
+		if (total_num > vsi_list_num) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"VSI_LIST action can't be used with other actions.");
+			PMD_LOG_ERR(DRV,
+				"VSI_LIST action can't be used with other actions.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+
+	if (engine_type == SXE2_FLOW_ENGINE_FNAV) {
+		if (vsi_num) {
+			flow->action.q_region.q_index = 0;
+			flow->action.q_region.region = 7;
+			flow->action.q_region.vsi_index = flow->action.vsi.vsi_index;
+			sxe2_set_bit(SXE2_FLOW_ACTION_Q_REGION, flow->action.act_types);
+			dest_num++;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+
+int32_t sxe2_flow_parse_action(struct rte_eth_dev *dev,
+			const struct rte_flow_action actions[],
+			struct rte_flow_error *error,
+			struct sxe2_flow *flow)
+{
+	int32_t ret = 0;
+	const struct rte_flow_action *action;
+	const struct rte_flow_action_count *act_count;
+	const struct rte_flow_action_mark *act_mark;
+	uint8_t action_num[SXE2_FLOW_ACTION_MAX] = {0};
+	enum sxe2_flow_engine_type engine_type = flow->engine_type;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	sxe2_flow_action_pre(flow);
+
+	for (action = actions; action->type != RTE_FLOW_ACTION_TYPE_END; action++) {
+		switch (action->type) {
+		case RTE_FLOW_ACTION_TYPE_VOID:
+			break;
+		case RTE_FLOW_ACTION_TYPE_PASSTHRU:
+			if (engine_type == SXE2_FLOW_ENGINE_FNAV) {
+				sxe2_set_bit(SXE2_FLOW_ACTION_PASSTHRU, flow->action.act_types);
+				action_num[SXE2_FLOW_ACTION_PASSTHRU]++;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Passthru action is not supported for this flow.");
+				PMD_LOG_ERR(DRV,
+					"Passthru action is not supported for this flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			if (engine_type == SXE2_FLOW_ENGINE_ACL ||
+				engine_type == SXE2_FLOW_ENGINE_SWITCH ||
+				engine_type == SXE2_FLOW_ENGINE_FNAV) {
+				sxe2_set_bit(SXE2_FLOW_ACTION_DROP, flow->action.act_types);
+				action_num[SXE2_FLOW_ACTION_DROP]++;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Drop action is not supported for this flow.");
+				PMD_LOG_ERR(DRV,
+					"Drop action is not supported for this flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_MARK:
+			if (engine_type == SXE2_FLOW_ENGINE_FNAV) {
+				sxe2_set_bit(SXE2_FLOW_ACTION_MARK, flow->action.act_types);
+				act_mark = action->conf;
+				flow->action.mark.mark_id = act_mark->id;
+				action_num[SXE2_FLOW_ACTION_MARK]++;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Mark action is not supported for this flow.");
+				PMD_LOG_ERR(DRV,
+					"Mark action is not supported for this flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_COUNT:
+			if (engine_type == SXE2_FLOW_ENGINE_FNAV) {
+				sxe2_set_bit(SXE2_FLOW_ACTION_COUNT, flow->action.act_types);
+				act_count = action->conf;
+				flow->action.count.user_id = act_count->id;
+				flow->action.count.driver_id = 0;
+				if (flow->action.count.user_id == 0)
+					flow->action.count.driver_id =
+						++adapter->flow_ctxt.hw_res.global_index;
+				action_num[SXE2_FLOW_ACTION_COUNT]++;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Count action is not supported for this flow.");
+				PMD_LOG_ERR(DRV,
+					"Count action is not supported for this flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_RSS:
+			if (engine_type == SXE2_FLOW_ENGINE_RSS) {
+				ret = sxe2_flow_parse_action_rss(action, error, flow);
+				if (ret != 0)
+					goto l_end;
+				action_num[SXE2_FLOW_ACTION_RSS]++;
+			} else if (engine_type == SXE2_FLOW_ENGINE_ACL ||
+				engine_type == SXE2_FLOW_ENGINE_SWITCH ||
+				engine_type == SXE2_FLOW_ENGINE_FNAV) {
+				ret = sxe2_flow_parse_action_qregion(dev, action, error, flow);
+				if (ret != 0)
+					goto l_end;
+				action_num[SXE2_FLOW_ACTION_Q_REGION]++;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"RSS action is only supported for RSS flow.");
+				PMD_LOG_ERR(DRV,
+					"RSS action is only supported for RSS flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+			if (engine_type == SXE2_FLOW_ENGINE_ACL ||
+				engine_type == SXE2_FLOW_ENGINE_SWITCH ||
+				engine_type == SXE2_FLOW_ENGINE_FNAV) {
+				ret = sxe2_flow_parse_action_queue(dev, action, error, flow);
+				if (ret != 0)
+					goto l_end;
+				action_num[SXE2_FLOW_ACTION_QUEUE]++;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Queue action is not supported for this flow.");
+				PMD_LOG_ERR(DRV,
+					"Queue action is not supported for this flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+			if (engine_type == SXE2_FLOW_ENGINE_SWITCH) {
+				ret = sxe2_flow_parse_action_represented_port(dev,
+					action, error, flow);
+				if (ret != 0)
+					goto l_end;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"REPRESENTED PORT action is only supported for SWITCH flow.");
+				PMD_LOG_ERR(DRV,
+					"REPRESENTED PORT action is only supported for SWITCH flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
+			if (engine_type == SXE2_FLOW_ENGINE_SWITCH) {
+				ret = sxe2_flow_parse_action_port_representor(dev,
+					action, error, flow);
+				if (ret != 0)
+					goto l_end;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"PORT REPRESENTOR action is only supported for SWITCH flow.");
+				PMD_LOG_ERR(DRV,
+					"PORT REPRESENTOR action is only supported for SWITCH flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+			if (engine_type == SXE2_FLOW_ENGINE_SWITCH ||
+				engine_type == SXE2_FLOW_ENGINE_ACL ||
+				engine_type == SXE2_FLOW_ENGINE_FNAV) {
+				ret = sxe2_flow_parse_action_port_id(dev, action,
+						error, flow);
+				if (ret != 0)
+					goto l_end;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"PORT ID action is only supported for this flow.");
+				PMD_LOG_ERR(DRV,
+					"PORT ID action is only supported for this flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL:
+			if (engine_type == SXE2_FLOW_ENGINE_ACL ||
+				engine_type == SXE2_FLOW_ENGINE_FNAV ||
+				engine_type == SXE2_FLOW_ENGINE_SWITCH) {
+				ret = sxe2_flow_parse_action_send_to_kernel(dev,
+						action, error, flow);
+				if (ret != 0)
+					goto l_end;
+			} else {
+				rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"SEND TO KERNEL action is only supported for this flow.");
+				PMD_LOG_ERR(DRV,
+					"SEND TO KERNEL action is only supported for this flow.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			break;
+		default:
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, actions,
+				"Invalid action.");
+			PMD_LOG_ERR(DRV, "Invalid action type:%d", actions->type);
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+
+	sxe2_flow_action_post(flow, action_num);
+
+	ret = sxe2_flow_check_actions(dev, flow, action_num, error);
+	if (ret != 0)
+		goto l_end;
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_flow_parse_action.h b/drivers/net/sxe2/sxe2_flow_parse_action.h
new file mode 100644
index 0000000000..479d10a522
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow_parse_action.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef SXE2_FLOW_PARSE_ACTION_H_
+#define SXE2_FLOW_PARSE_ACTION_H_
+#include <rte_flow_driver.h>
+
+#include "sxe2_osal.h"
+#include "sxe2_flow_define.h"
+
+
+int32_t sxe2_flow_parse_action(struct rte_eth_dev *dev,
+			const struct rte_flow_action actions[],
+			struct rte_flow_error *error,
+			struct sxe2_flow *flow);
+
+int32_t sxe2_flow_parse_action_port_id(struct rte_eth_dev *dev,
+			const struct rte_flow_action *action,
+			struct rte_flow_error *error,
+			struct sxe2_flow *flow);
+
+#endif /* SXE2_FLOW_PARSE_ACTION_H_ */
diff --git a/drivers/net/sxe2/sxe2_flow_parse_engine.c b/drivers/net/sxe2/sxe2_flow_parse_engine.c
new file mode 100644
index 0000000000..09de1b94c4
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow_parse_engine.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_flow_parse_engine.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_flow_public.h"
+#include "sxe2_flow_parse_action.h"
+#include "sxe2_common_log.h"
+
+static int32_t sxe2_flow_parse_engine_chk(struct sxe2_flow *flow,
+		struct rte_flow_error *error)
+{
+	int32_t ret = 0;
+
+	if (flow->engine_type == SXE2_FLOW_ENGINE_FNAV) {
+		if (flow->has_mask) {
+			ret = -EINVAL;
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_MASK, NULL,
+				"FNAV flow doesn't support mask");
+			PMD_LOG_ERR(DRV, "FNAV flow doesn't support mask");
+			goto l_end;
+		}
+		if (sxe2_test_bit(SXE2_FLOW_FLD_ID_S_VID,
+				flow->pattern_outer.map_spec) &&
+			sxe2_test_bit(SXE2_FLOW_FLD_ID_C_VID,
+				flow->pattern_outer.map_spec)) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				"Can't set double vid,please use tci.");
+			PMD_LOG_ERR(DRV,
+				"Can't set double vid,please use tci.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_flow_parse_engine(struct rte_eth_dev *dev,
+		const struct rte_flow_attr *attr,
+		const struct rte_flow_action actions[],
+		struct rte_flow_error *error,
+		struct sxe2_flow *flow)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	const struct rte_flow_action *action;
+
+	if (flow->has_mask == 0 && flow->has_spec == 0) {
+		flow->engine_type = SXE2_FLOW_ENGINE_RSS;
+		goto l_end;
+	}
+
+	if (attr->group == 1) {
+		flow->engine_type = SXE2_FLOW_ENGINE_SWITCH;
+		goto l_end;
+	}
+	if (attr->group == 2) {
+		flow->engine_type = SXE2_FLOW_ENGINE_ACL;
+		goto l_end;
+	}
+	if (attr->group == 3) {
+		flow->engine_type = SXE2_FLOW_ENGINE_FNAV;
+		goto l_end;
+	}
+
+	if (adapter->is_dev_repr) {
+		flow->engine_type = SXE2_FLOW_ENGINE_SWITCH;
+		goto l_end;
+	}
+
+	if (adapter->switchdev_info.is_switchdev &&
+	    adapter->dev_type == SXE2_DEV_T_VF) {
+		flow->engine_type = SXE2_FLOW_ENGINE_FNAV;
+		goto l_end;
+	}
+
+	for (action = actions; action->type != RTE_FLOW_ACTION_TYPE_END; action++) {
+		switch (action->type) {
+		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+			flow->engine_type = SXE2_FLOW_ENGINE_SWITCH;
+			goto l_end;
+		default:
+			break;
+		}
+	}
+
+	if (adapter->switchdev_info.is_switchdev) {
+		flow->engine_type = SXE2_FLOW_ENGINE_FNAV;
+		goto l_end;
+	}
+
+	if (adapter->flow_isolated)
+		flow->engine_type = SXE2_FLOW_ENGINE_SWITCH;
+	else
+		flow->engine_type = SXE2_FLOW_ENGINE_FNAV;
+
+l_end:
+	ret = sxe2_flow_parse_engine_chk(flow, error);
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_flow_parse_engine.h b/drivers/net/sxe2/sxe2_flow_parse_engine.h
new file mode 100644
index 0000000000..1485beecb4
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow_parse_engine.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef SXE2_FLOW_PARSE_ENGINE_H_
+#define SXE2_FLOW_PARSE_ENGINE_H_
+#include "sxe2_osal.h"
+#include "sxe2_flow_define.h"
+
+int32_t sxe2_flow_parse_engine(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+			const struct rte_flow_action actions[], struct rte_flow_error *error,
+			struct sxe2_flow *flow);
+#endif /* SXE2_FLOW_PARSE_ENGINE_H_ */
diff --git a/drivers/net/sxe2/sxe2_flow_parse_pattern.c b/drivers/net/sxe2/sxe2_flow_parse_pattern.c
new file mode 100644
index 0000000000..189abb1a33
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow_parse_pattern.c
@@ -0,0 +1,1822 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include "sxe2_flow_parse_pattern.h"
+#include "rte_common.h"
+#include "rte_flow.h"
+#include "sxe2_common_log.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_flow_define.h"
+
+const struct sxe2_flow_expand_node sxe2_support_expansion[SXE2_EXPANSION_MAX] = {
+	[SXE2_EXPANSION_OUTER_ETH] = {
+		.type = RTE_FLOW_ITEM_TYPE_ETH,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE,
+		.is_tunnel = false,
+		.name = "eth",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_OUTER_VLAN,
+					      SXE2_EXPANSION_OUTER_IPV4,
+					      SXE2_EXPANSION_OUTER_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_OUTER_VLAN] = {
+		.type = RTE_FLOW_ITEM_TYPE_VLAN,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE,
+		.is_tunnel = false,
+		.name = "vlan",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_OUTER_QINQ,
+					      SXE2_EXPANSION_OUTER_IPV4,
+					      SXE2_EXPANSION_OUTER_IPV6,
+					      SXE2_EXPANSION_OUTER_END),
+	},
+	[SXE2_EXPANSION_OUTER_QINQ] = {
+		.type = RTE_FLOW_ITEM_TYPE_VLAN,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE,
+		.is_tunnel = false,
+		.name = "vlan",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_OUTER_IPV4,
+					      SXE2_EXPANSION_OUTER_IPV6,
+					      SXE2_EXPANSION_OUTER_END),
+	},
+	[SXE2_EXPANSION_OUTER_IPV4] = {
+		.type = RTE_FLOW_ITEM_TYPE_IPV4,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_IPIP,
+		.is_tunnel = false,
+		.name = "ipv4",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_OUTER_UDP,
+					      SXE2_EXPANSION_OUTER_TCP,
+					      SXE2_EXPANSION_OUTER_SCTP,
+					      SXE2_EXPANSION_GRE,
+					      SXE2_EXPANSION_NVGRE,
+					      SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_OUTER_END),
+	},
+	[SXE2_EXPANSION_OUTER_IPV6] = {
+		.type = RTE_FLOW_ITEM_TYPE_IPV6,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_IPIP,
+		.is_tunnel = false,
+		.name = "ipv6",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_OUTER_IPV6_FRAG_EXT,
+					      SXE2_EXPANSION_OUTER_UDP,
+					      SXE2_EXPANSION_OUTER_TCP,
+					      SXE2_EXPANSION_OUTER_SCTP,
+					      SXE2_EXPANSION_GRE,
+					      SXE2_EXPANSION_NVGRE,
+					      SXE2_EXPANSION_ETH,
+					      SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_OUTER_END),
+	},
+	[SXE2_EXPANSION_OUTER_IPV6_FRAG_EXT] = {
+		.type = RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE,
+		.is_tunnel = false,
+		.name = "ipv6_frag_ext",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_OUTER_END),
+	},
+	[SXE2_EXPANSION_OUTER_UDP] = {
+		.type = RTE_FLOW_ITEM_TYPE_UDP,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE,
+		.is_tunnel = false,
+		.name = "udp",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_VXLAN,
+					      SXE2_EXPANSION_VXLAN_GPE,
+					      SXE2_EXPANSION_GENEVE,
+					      SXE2_EXPANSION_GTPU,
+					      SXE2_EXPANSION_GRE,
+					      SXE2_EXPANSION_NVGRE,
+					      SXE2_EXPANSION_OUTER_END),
+	},
+	[SXE2_EXPANSION_OUTER_TCP] = {
+		.type = RTE_FLOW_ITEM_TYPE_TCP,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE,
+		.is_tunnel = false,
+		.name = "tcp",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_OUTER_END),
+	},
+	[SXE2_EXPANSION_OUTER_SCTP] = {
+		.type = RTE_FLOW_ITEM_TYPE_SCTP,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE,
+		.is_tunnel = false,
+		.name = "sctp",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_OUTER_END),
+	},
+	[SXE2_EXPANSION_OUTER_END] = {
+		.type = RTE_FLOW_ITEM_TYPE_END,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE,
+		.is_tunnel = false,
+		.name = "end",
+		.next = SXE2_FLOW_EXPAND_NEXT(0),
+	},
+	[SXE2_EXPANSION_VXLAN] = {
+		.type = RTE_FLOW_ITEM_TYPE_VXLAN,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_VXLAN,
+		.is_tunnel = true,
+		.name = "vxlan",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_ETH,
+					      SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_VXLAN_GPE] = {
+		.type = RTE_FLOW_ITEM_TYPE_VXLAN_GPE,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_VXLAN,
+		.is_tunnel = true,
+		.name = "vxlan_gpe",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_ETH,
+					      SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_GRE] = {
+		.type = RTE_FLOW_ITEM_TYPE_GRE,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_GRE,
+		.is_tunnel = true,
+		.name = "gre",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_ETH,
+					      SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_NVGRE] = {
+		.type = RTE_FLOW_ITEM_TYPE_NVGRE,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_GRE,
+		.is_tunnel = true,
+		.name = "nvgre",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_ETH,
+					      SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_GENEVE] = {
+		.type = RTE_FLOW_ITEM_TYPE_GENEVE,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_GENEVE,
+		.is_tunnel = true,
+		.name = "geneve",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_ETH,
+					      SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_GTPU] = {
+		.type = RTE_FLOW_ITEM_TYPE_GTPU,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_GTPU,
+		.is_tunnel = true,
+		.name = "gtpu",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_ETH] = {
+		.type = RTE_FLOW_ITEM_TYPE_ETH,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "eth",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_VLAN,
+					      SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_VLAN] = {
+		.type = RTE_FLOW_ITEM_TYPE_VLAN,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "vlan",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_IPV4,
+					      SXE2_EXPANSION_IPV6,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_IPV4] = {
+		.type = RTE_FLOW_ITEM_TYPE_IPV4,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "ipv4",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_UDP,
+					      SXE2_EXPANSION_TCP,
+					      SXE2_EXPANSION_SCTP,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_IPV6] = {
+		.type = RTE_FLOW_ITEM_TYPE_IPV6,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "ipv6",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_UDP,
+					      SXE2_EXPANSION_TCP,
+					      SXE2_EXPANSION_SCTP,
+					      SXE2_EXPANSION_IPV6_FRAG_EXT,
+					      SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_UDP] = {
+		.type = RTE_FLOW_ITEM_TYPE_UDP,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "udp",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_TCP] = {
+		.type = RTE_FLOW_ITEM_TYPE_TCP,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "tcp",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_SCTP] = {
+		.type = RTE_FLOW_ITEM_TYPE_SCTP,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "sctp",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_IPV6_FRAG_EXT] = {
+		.type = RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "ipv6_frag_ext",
+		.next = SXE2_FLOW_EXPAND_NEXT(SXE2_EXPANSION_END),
+	},
+	[SXE2_EXPANSION_END] = {
+		.type = RTE_FLOW_ITEM_TYPE_END,
+		.tunnel_type = SXE2_FLOW_TUNNEL_TYPE_PARENT,
+		.is_tunnel = true,
+		.name = "end",
+		.next = SXE2_FLOW_EXPAND_NEXT(0),
+	}
+};
+
+const char *sxe2_flow_type_name[SXE2_FLOW_TYPE_MAX] = {
+	[SXE2_FLOW_MAC_PAY] = "SXE2_FLOW_MAC_PAY",
+	[SXE2_FLOW_MAC_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_FRAG_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_UDP_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_TCP_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_SCTP_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_FRAG_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_UDP_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_TCP_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_SCTP_PAY] =
+	"SXE2_FLOW_MAC_IPV4_GRE_MAC_VLAN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_FRAG_PAY] =
+	"SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_GRE_MAC_VLAN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GTPU_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GTPU_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_MAC_VLAN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_VLAN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_VLAN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_VLAN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_VLAN_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_VXGEN_MAC_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_VXGEN_MAC_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV6_UDP_GRE_MAC_IPV6_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV4_SCTP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_FRAG_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_FRAG_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_UDP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_UDP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_TCP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_TCP_PAY",
+	[SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_SCTP_PAY] = "SXE2_FLOW_MAC_IPV4_UDP_GRE_MAC_IPV6_SCTP_PAY",
+};
+#define SXE2_FLOW_TYPE_NAME_MAX_LEN 128
+
+static int32_t sxe2_flow_get_flow_type(struct sxe2_flow *flow)
+{
+	int32_t ret = -EINVAL;
+	uint16_t i = 0;
+	uint16_t len = 0;
+	char flow_type_name[SXE2_FLOW_TYPE_NAME_MAX_LEN] = {0};
+	len = snprintf(flow_type_name, sizeof(flow_type_name), "SXE2_FLOW_");
+	i += len;
+	if (sxe2_test_bit(SXE2_FLOW_HDR_ETH, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"MAC_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_IPV4, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"IPV4_");
+		i += len;
+	} else if (sxe2_test_bit(SXE2_FLOW_HDR_IPV6, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"IPV6_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_IPV_FRAG, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"FRAG_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_UDP, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"UDP_");
+		i += len;
+	} else if (sxe2_test_bit(SXE2_FLOW_HDR_TCP, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"TCP_");
+		i += len;
+	} else if (sxe2_test_bit(SXE2_FLOW_HDR_SCTP, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"SCTP_");
+		i += len;
+	}
+
+	if (sxe2_test_bit(SXE2_FLOW_HDR_VXLAN, flow->pattern_outer.hdrs) ||
+	    sxe2_test_bit(SXE2_FLOW_HDR_GENEVE, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"VXGEN_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_GRE, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"GRE_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_GTPU, flow->pattern_outer.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"GTPU_");
+		i += len;
+	}
+
+	if (sxe2_test_bit(SXE2_FLOW_HDR_ETH, flow->pattern_inner.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"MAC_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_VLAN, flow->pattern_inner.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"VLAN_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_IPV4, flow->pattern_inner.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"IPV4_");
+		i += len;
+	} else if (sxe2_test_bit(SXE2_FLOW_HDR_IPV6, flow->pattern_inner.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"IPV6_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_IPV_FRAG, flow->pattern_inner.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"FRAG_");
+		i += len;
+	}
+	if (sxe2_test_bit(SXE2_FLOW_HDR_UDP, flow->pattern_inner.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"UDP_");
+		i += len;
+	} else if (sxe2_test_bit(SXE2_FLOW_HDR_TCP, flow->pattern_inner.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"TCP_");
+		i += len;
+	} else if (sxe2_test_bit(SXE2_FLOW_HDR_SCTP, flow->pattern_inner.hdrs)) {
+		len = snprintf(flow_type_name + i, sizeof(flow_type_name) - i,
+			"SCTP_");
+		i += len;
+	}
+
+	len = snprintf(flow_type_name + i, sizeof(flow_type_name), "PAY");
+	i += len;
+
+	for (i = 0; i < SXE2_FLOW_TYPE_MAX; i++) {
+		if (sxe2_flow_type_name[i] == NULL)
+			continue;
+		if (strcmp(flow_type_name, sxe2_flow_type_name[i]) == 0) {
+			flow->meta.flow_type = i;
+			ret = 0;
+			break;
+		}
+	}
+	if (ret != 0)
+		PMD_LOG_ERR(DRV,
+			"Unsupported flow type. %s is not supported.", flow_type_name);
+	return ret;
+}
+
+static int32_t sxe2_flow_is_expandable_item(const struct rte_flow_item *item)
+{
+	int32_t ret = -EINVAL;
+	switch (item->type) {
+	case RTE_FLOW_ITEM_TYPE_ETH:
+	case RTE_FLOW_ITEM_TYPE_VLAN:
+	case RTE_FLOW_ITEM_TYPE_IPV4:
+	case RTE_FLOW_ITEM_TYPE_IPV6:
+	case RTE_FLOW_ITEM_TYPE_IPV6_FRAG_EXT:
+	case RTE_FLOW_ITEM_TYPE_UDP:
+	case RTE_FLOW_ITEM_TYPE_TCP:
+	case RTE_FLOW_ITEM_TYPE_SCTP:
+	case RTE_FLOW_ITEM_TYPE_VXLAN:
+	case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
+	case RTE_FLOW_ITEM_TYPE_GRE:
+	case RTE_FLOW_ITEM_TYPE_NVGRE:
+	case RTE_FLOW_ITEM_TYPE_GENEVE:
+	case RTE_FLOW_ITEM_TYPE_GTPU:
+	case RTE_FLOW_ITEM_TYPE_VOID:
+	case RTE_FLOW_ITEM_TYPE_END:
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int32_t sxe2_flow_valid_next_expansion(enum sxe2_expansion *current,
+	const struct rte_flow_item *item,
+	enum sxe2_flow_tunnel_type *tunnel_type, BITMAP_TYPE *flow_type)
+{
+	int32_t ret = -EINVAL;
+	const struct rte_flow_item *next;
+	const enum sxe2_expansion *next_expansion = current;
+	const struct sxe2_flow_expand_node *node;
+	uint8_t len = 0;
+	char typelist[512] = {0};
+	char error[1024] = {0};
+	enum sxe2_flow_tunnel_type tunnel_type_now = SXE2_FLOW_TUNNEL_TYPE_NONE;
+	enum sxe2_flow_tunnel_type tunnel_type_next = SXE2_FLOW_TUNNEL_TYPE_NONE;
+	uint8_t is_tunnel_now = 0;
+	uint8_t is_tunnel_next = 0;
+
+	if (item->type != sxe2_support_expansion[*current].type) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	next = item;
+	do {
+		next++;
+		if (next->type == RTE_FLOW_ITEM_TYPE_VOID)
+			continue;
+		break;
+	} while (1);
+
+	node = &sxe2_support_expansion[*current];
+	next_expansion = node->next;
+	while (*next_expansion != 0) {
+		len = strlen(typelist);
+		snprintf(typelist + len, sizeof(typelist) - len,
+			"%s|", sxe2_support_expansion[*next_expansion].name);
+		if (sxe2_support_expansion[*next_expansion].type == next->type) {
+			ret = 0;
+			break;
+		}
+		next_expansion++;
+	}
+	if (ret != 0) {
+		snprintf(error, sizeof(error),
+			"The next item of %s only can be one of [%s].",
+			sxe2_support_expansion[*current].name, typelist);
+		PMD_LOG_ERR(INIT, "Invalid pattern sequence. %s", error);
+		goto l_end;
+	}
+	tunnel_type_now = sxe2_support_expansion[*current].tunnel_type;
+	tunnel_type_next = sxe2_support_expansion[*next_expansion].tunnel_type;
+	is_tunnel_now = sxe2_support_expansion[*current].is_tunnel;
+	is_tunnel_next = sxe2_support_expansion[*next_expansion].is_tunnel;
+
+
+	if (!is_tunnel_now && is_tunnel_next) {
+		if (tunnel_type_next == SXE2_FLOW_TUNNEL_TYPE_PARENT)
+			*tunnel_type = tunnel_type_now;
+		else
+			*tunnel_type = tunnel_type_next;
+	}
+
+l_end:
+	sxe2_set_bit(*current, flow_type);
+	*current = *next_expansion;
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_eth(const struct rte_flow_item *item,
+					struct rte_flow_error *error,
+					struct sxe2_flow *flow,
+					enum sxe2_expansion next,
+					bool is_inner)
+{
+	const struct rte_flow_item_eth *eth_spec;
+	const struct rte_flow_item_eth *eth_mask;
+	const struct rte_ether_addr *dst_addr_mask;
+	const struct rte_ether_addr *src_addr_mask;
+	const struct rte_ether_addr *dst_addr_spec;
+	const struct rte_ether_addr *src_addr_spec;
+	rte_be16_t type_mask;
+	rte_be16_t type_spec;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	uint16_t ether_type;
+	eth_spec = item->spec;
+	eth_mask = item->mask;
+
+	if (eth_spec == NULL && eth_mask == NULL)
+		goto l_end;
+
+	dst_addr_mask = &eth_mask->hdr.dst_addr;
+	src_addr_mask = &eth_mask->hdr.src_addr;
+	dst_addr_spec = &eth_spec->hdr.dst_addr;
+	src_addr_spec = &eth_spec->hdr.src_addr;
+	type_mask = eth_mask->hdr.ether_type;
+	type_spec = eth_spec->hdr.ether_type;
+
+	if (eth_mask->has_vlan) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported eth mask has_vlan.");
+		PMD_LOG_ERR(DRV, "Unsupported eth mask has_vlan");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (!rte_is_zero_ether_addr(dst_addr_mask)) {
+		if (!rte_is_broadcast_ether_addr(dst_addr_mask))
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_DA, pattern->map_mask);
+
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_DA, pattern->map_spec);
+		rte_memcpy(pattern->item_spec.eth.dst_addr, dst_addr_spec,
+			RTE_ETHER_ADDR_LEN);
+		rte_memcpy(pattern->item_mask.eth.dst_addr, dst_addr_mask,
+			RTE_ETHER_ADDR_LEN);
+	}
+	if (!rte_is_zero_ether_addr(src_addr_mask)) {
+		if (!rte_is_broadcast_ether_addr(src_addr_mask))
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_SA, pattern->map_mask);
+
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_SA, pattern->map_spec);
+		rte_memcpy(pattern->item_spec.eth.src_addr, src_addr_spec,
+			RTE_ETHER_ADDR_LEN);
+		rte_memcpy(pattern->item_mask.eth.src_addr, src_addr_mask,
+			RTE_ETHER_ADDR_LEN);
+	}
+	if (type_mask != 0) {
+		if (type_mask != UINT16_MAX) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Unsupported eth ether_type mask");
+			PMD_LOG_ERR(DRV, "unsupported eth ether_type mask[0x%x].",
+				    type_mask);
+			ret = -EINVAL;
+			goto l_end;
+		}
+		if (next != SXE2_EXPANSION_OUTER_END && next != SXE2_EXPANSION_END) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Unsupported eth ether_type match with next item.");
+			PMD_LOG_ERR(DRV, "unsupported eth ether_type match with next item.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		ether_type = rte_be_to_cpu_16(type_spec);
+		if (ether_type == RTE_ETHER_TYPE_IPV4 ||
+				ether_type == RTE_ETHER_TYPE_IPV6) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Ether_type unsupported ipv4/ipv6(0x0800/0x86DD).");
+			PMD_LOG_ERR(DRV, "Ether_type unsupported ipv4/ipv6(0x0800/0x86DD).");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		if (ether_type == RTE_ETHER_TYPE_VLAN || ether_type == RTE_ETHER_TYPE_QINQ ||
+				ether_type == RTE_ETHER_TYPE_QINQ1) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Ether_type unsupported vlan(0x8100/0x88a8/0x9100).");
+			PMD_LOG_ERR(DRV, "Ether_type unsupported vlan(0x8100/0x88a8/0x9100).");
+			ret = -EINVAL;
+			goto l_end;
+		}
+
+		if (ether_type <= SXE2_FLOW_ETH_TYPE_MIN) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Ether_type need max 1500.");
+			PMD_LOG_ERR(DRV, "Ether_type need max 1500.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_ETH_TYPE, pattern->map_spec);
+		pattern->item_spec.eth.ether_type = type_spec;
+		pattern->item_mask.eth.ether_type = type_mask;
+	}
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_ETH, pattern->hdrs);
+	pattern->rss_type_allow |= RTE_ETH_RSS_ETH;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L2_DST_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L2_SRC_ONLY;
+	if (next == SXE2_EXPANSION_OUTER_END || next == SXE2_EXPANSION_END)
+		pattern->rss_type_allow |= RTE_ETH_RSS_L2_PAYLOAD;
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_vlan(const struct rte_flow_item *item,
+				struct rte_flow_error *error,
+				struct sxe2_flow *flow,
+				enum sxe2_expansion next __rte_unused,
+				bool is_inner)
+{
+	const struct rte_flow_item_vlan *vlan_spec;
+	const struct rte_flow_item_vlan *vlan_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	rte_be16_t vlan_tci_mask;
+	rte_be16_t vlan_tci_spec;
+	rte_be16_t eth_proto_mask;
+	rte_be16_t eth_proto_spec;
+	int32_t ret = 0;
+	vlan_spec = item->spec;
+	vlan_mask = item->mask;
+	bool is_qinq = false;
+
+	if (sxe2_test_bit(SXE2_FLOW_HDR_VLAN, pattern->hdrs))
+		is_qinq = true;
+
+	if (vlan_spec == NULL && vlan_mask == NULL)
+		goto l_end;
+
+	vlan_tci_mask = vlan_mask->hdr.vlan_tci;
+	vlan_tci_spec = vlan_spec->hdr.vlan_tci;
+	eth_proto_mask = vlan_mask->hdr.eth_proto;
+	eth_proto_spec = vlan_spec->hdr.eth_proto;
+
+	if (vlan_mask->has_more_vlan || vlan_mask->reserved) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported vlan mask has_qinq.");
+		PMD_LOG_ERR(DRV, "Unsupported vlan mask has_qinq");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (vlan_tci_mask) {
+		if (vlan_tci_spec == 0) {
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "vlan id can't be 0.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+
+	if (eth_proto_mask) {
+		if (eth_proto_mask != UINT16_MAX) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Unsupported vlan ether_type mask");
+			PMD_LOG_ERR(DRV, "unsupported vlan ether_type mask.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		if (eth_proto_spec != RTE_BE16(0x8100) &&
+			eth_proto_spec != RTE_BE16(0x88a8) &&
+			eth_proto_spec != RTE_BE16(0x9100)) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Unsupported vlan ether_type, only support 0x8100, 0x88a8 and 0x9100.");
+			PMD_LOG_ERR(DRV, "Unsupported vlan ether_type, only support 0x8100, 0x88a8 and 0x9100.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+	if (!is_qinq) {
+		if (vlan_tci_mask) {
+			if (vlan_tci_mask == RTE_BE16(0x0fff)) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_S_VID, pattern->map_spec);
+			} else if (vlan_tci_mask == UINT16_MAX) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_S_TCI, pattern->map_spec);
+			} else {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_S_TCI, pattern->map_mask);
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_S_TCI, pattern->map_spec);
+			}
+		}
+		if (eth_proto_mask)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_S_TPID, pattern->map_spec);
+	} else {
+		if (vlan_tci_mask) {
+			if (vlan_tci_mask == RTE_BE16(0x0fff)) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_C_VID, pattern->map_spec);
+			} else if (vlan_tci_mask == UINT16_MAX) {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_C_TCI, pattern->map_spec);
+			} else {
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_C_TCI, pattern->map_mask);
+				sxe2_set_bit(SXE2_FLOW_FLD_ID_C_TCI, pattern->map_spec);
+			}
+		}
+		if (eth_proto_mask)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_C_TPID, pattern->map_spec);
+	}
+	if (is_qinq) {
+		pattern->item_spec.qinq.type =  eth_proto_spec;
+		pattern->item_mask.qinq.type =  eth_proto_mask;
+		pattern->item_spec.qinq.vlan = vlan_tci_spec;
+		pattern->item_mask.qinq.vlan = vlan_tci_mask;
+	} else {
+		pattern->item_spec.vlan.type = eth_proto_spec;
+		pattern->item_mask.vlan.type = eth_proto_mask;
+		pattern->item_spec.vlan.vlan = vlan_tci_spec;
+		pattern->item_mask.vlan.vlan = vlan_tci_mask;
+	}
+l_end:
+	pattern->rss_type_allow |= RTE_ETH_RSS_S_VLAN;
+	pattern->rss_type_allow |= RTE_ETH_RSS_C_VLAN;
+	if (!is_qinq)
+		sxe2_set_bit(SXE2_FLOW_HDR_VLAN, pattern->hdrs);
+	else
+		sxe2_set_bit(SXE2_FLOW_HDR_QINQ, pattern->hdrs);
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_ipv4(const struct rte_flow_item *item,
+					struct rte_flow_error *error,
+					struct sxe2_flow *flow,
+					enum sxe2_expansion next,
+					bool is_inner)
+{
+	const struct rte_flow_item_ipv4 *ipv4_spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	ipv4_spec = item->spec;
+	ipv4_mask = item->mask;
+
+	if (ipv4_mask == NULL && ipv4_spec == NULL)
+		goto l_end;
+
+	if (ipv4_mask->hdr.version_ihl || ipv4_mask->hdr.total_length ||
+			ipv4_mask->hdr.hdr_checksum || ipv4_mask->hdr.packet_id) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some IPv4 mask.");
+		PMD_LOG_ERR(DRV, "Unsupported some IPv4 mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (ipv4_mask->hdr.src_addr) {
+		if (ipv4_mask->hdr.src_addr != UINT32_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_SA, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_SA, pattern->map_spec);
+		pattern->item_spec.ipv4.saddr = ipv4_spec->hdr.src_addr;
+		pattern->item_mask.ipv4.saddr = ipv4_mask->hdr.src_addr;
+	}
+	if (ipv4_mask->hdr.dst_addr) {
+		if (ipv4_mask->hdr.dst_addr != UINT32_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_DA, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_DA, pattern->map_spec);
+		pattern->item_spec.ipv4.daddr = ipv4_spec->hdr.dst_addr;
+		pattern->item_mask.ipv4.daddr = ipv4_mask->hdr.dst_addr;
+	}
+
+	if (ipv4_mask->hdr.next_proto_id) {
+		if (next != SXE2_EXPANSION_OUTER_END && next != SXE2_EXPANSION_END) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "IPv4 proto id must be the last partten.");
+			PMD_LOG_ERR(DRV, "IPv4 proto id must be the last partten.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		if (ipv4_mask->hdr.next_proto_id != UINT8_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_PROT, pattern->map_spec);
+		pattern->item_spec.ipv4.protocol = ipv4_spec->hdr.next_proto_id;
+		pattern->item_mask.ipv4.protocol = ipv4_mask->hdr.next_proto_id;
+	}
+	if (ipv4_mask->hdr.time_to_live) {
+		if (ipv4_mask->hdr.time_to_live != UINT8_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_TTL, pattern->map_mask);
+		if (ipv4_spec->hdr.time_to_live == 0) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "ipv4 ttl must be not 0.");
+			PMD_LOG_ERR(DRV, "ipv4 ttl must be not 0.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_TTL, pattern->map_spec);
+		pattern->item_spec.ipv4.ttl = ipv4_spec->hdr.time_to_live;
+		pattern->item_mask.ipv4.ttl = ipv4_mask->hdr.time_to_live;
+	}
+	if (ipv4_mask->hdr.type_of_service) {
+		if (ipv4_mask->hdr.type_of_service != UINT8_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_TOS, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV4_TOS, pattern->map_spec);
+		pattern->item_spec.ipv4.tos = ipv4_spec->hdr.type_of_service;
+		pattern->item_mask.ipv4.tos = ipv4_mask->hdr.type_of_service;
+	}
+	if (ipv4_mask->hdr.fragment_offset) {
+		if (ipv4_spec->hdr.fragment_offset == rte_cpu_to_be_16(RTE_IPV4_HDR_MF_FLAG) &&
+			ipv4_mask->hdr.fragment_offset == rte_cpu_to_be_16(RTE_IPV4_HDR_MF_FLAG)) {
+			if (next != SXE2_EXPANSION_OUTER_END && next != SXE2_EXPANSION_END) {
+				rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ITEM,
+						item, "IPv4 frag offset must be the last partten.");
+				PMD_LOG_ERR(DRV, "IPv4 frag offset must be the last partten.");
+				ret = -EINVAL;
+				goto l_end;
+			}
+			sxe2_set_bit(SXE2_FLOW_HDR_IPV_FRAG, pattern->hdrs);
+		} else {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported ipv4 fragment_offset cfg.");
+			PMD_LOG_ERR(DRV, "Unsupported ipv4 fragment_offset cfg.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+	}
+
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_IPV4, pattern->hdrs);
+	pattern->rss_type_allow |= RTE_ETH_RSS_IPV4;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L3_SRC_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L3_DST_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_IPV4_CHKSUM;
+	if (next == SXE2_EXPANSION_OUTER_END || next == SXE2_EXPANSION_END) {
+		pattern->rss_type_allow |= RTE_ETH_RSS_FRAG_IPV4;
+		pattern->rss_type_allow |= RTE_ETH_RSS_NONFRAG_IPV4_OTHER;
+	}
+
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_ipv6(const struct rte_flow_item *item,
+				struct rte_flow_error *error,
+				struct sxe2_flow *flow,
+				enum sxe2_expansion next __rte_unused,
+				bool is_inner)
+{
+	const struct rte_flow_item_ipv6 *ipv6_spec;
+	const struct rte_flow_item_ipv6 *ipv6_mask;
+	uint32_t vtc_flow_mask;
+	uint32_t tc_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	ipv6_spec = item->spec;
+	ipv6_mask = item->mask;
+	uint8_t ipv6_addr_mask[16] = {
+		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
+	};
+	uint8_t ipv6_addr_empty[16] = { 0 };
+
+	if (ipv6_mask == NULL && ipv6_spec == NULL)
+		goto l_end;
+
+	if (ipv6_mask->hdr.payload_len || ipv6_mask->has_hop_ext ||
+		ipv6_mask->has_route_ext || ipv6_mask->has_frag_ext ||
+		ipv6_mask->has_auth_ext || ipv6_mask->has_esp_ext ||
+		ipv6_mask->has_dest_ext || ipv6_mask->has_mobil_ext ||
+		ipv6_mask->has_hip_ext || ipv6_mask->has_shim6_ext) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some IPv6 mask");
+		PMD_LOG_ERR(DRV, "Unsupported some IPv6 mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (memcmp(&ipv6_mask->hdr.src_addr, ipv6_addr_empty,
+		   sizeof(ipv6_addr_empty)) != 0) {
+		if (memcmp(&ipv6_mask->hdr.src_addr, ipv6_addr_mask,
+			   sizeof(ipv6_addr_mask)) != 0)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_SA, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_SA, pattern->map_spec);
+		rte_memcpy(&pattern->item_spec.ipv6.saddr, &ipv6_spec->hdr.src_addr,
+			   sizeof(ipv6_spec->hdr.src_addr));
+		rte_memcpy(&pattern->item_mask.ipv6.saddr, &ipv6_mask->hdr.src_addr,
+			   sizeof(ipv6_mask->hdr.src_addr));
+	}
+	if (memcmp(&ipv6_mask->hdr.dst_addr, ipv6_addr_empty,
+		    sizeof(ipv6_addr_empty)) != 0) {
+		if (memcmp(&ipv6_mask->hdr.dst_addr, ipv6_addr_mask,
+			   sizeof(ipv6_addr_mask)) != 0)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_DA, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_DA, pattern->map_spec);
+		rte_memcpy(&pattern->item_spec.ipv6.daddr, &ipv6_spec->hdr.dst_addr,
+			   sizeof(ipv6_spec->hdr.dst_addr));
+		rte_memcpy(&pattern->item_mask.ipv6.daddr, &ipv6_mask->hdr.dst_addr,
+			   sizeof(ipv6_mask->hdr.dst_addr));
+	}
+	if (ipv6_mask->hdr.vtc_flow) {
+		vtc_flow_mask = rte_be_to_cpu_32(ipv6_mask->hdr.vtc_flow);
+		tc_mask = vtc_flow_mask & (SXE2_IPV6_TC_MASK << SXE2_IPV6_TC_SHIFT);
+		if (tc_mask != vtc_flow_mask) {
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "ipv6 vtc_flow only support TC mask.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		if (tc_mask != (SXE2_IPV6_TC_MASK << SXE2_IPV6_TC_SHIFT))
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_DSCP, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_DSCP, pattern->map_spec);
+		pattern->item_spec.ipv6.pri_ver_flow = ipv6_spec->hdr.vtc_flow;
+		pattern->item_mask.ipv6.pri_ver_flow = ipv6_mask->hdr.vtc_flow;
+	}
+	if (ipv6_mask->hdr.proto) {
+		if (next != SXE2_EXPANSION_OUTER_END && next != SXE2_EXPANSION_END) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "IPv6 proto id must be the last partten.");
+			PMD_LOG_ERR(DRV, "IPv6 proto id must be the last partten.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		if (ipv6_mask->hdr.proto != UINT8_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PROT, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_PROT, pattern->map_spec);
+		pattern->item_spec.ipv6.nexthdr = ipv6_spec->hdr.proto;
+		pattern->item_mask.ipv6.nexthdr = ipv6_mask->hdr.proto;
+	}
+	if (ipv6_mask->hdr.hop_limits) {
+		if (ipv6_mask->hdr.hop_limits != UINT8_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_TTL, pattern->map_mask);
+
+		if (ipv6_spec->hdr.hop_limits == 0) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "ipv6 hop must be not 0.");
+			PMD_LOG_ERR(DRV, "ipv6 hop must be not 0.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_IPV6_TTL, pattern->map_spec);
+		pattern->item_spec.ipv6.hop_limit = ipv6_spec->hdr.hop_limits;
+		pattern->item_mask.ipv6.hop_limit = ipv6_mask->hdr.hop_limits;
+	}
+
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_IPV6, pattern->hdrs);
+	pattern->rss_type_allow |= RTE_ETH_RSS_IPV6;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L3_SRC_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L3_DST_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L3_PRE32;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L3_PRE48;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L3_PRE64;
+	if (next == SXE2_EXPANSION_OUTER_END || next == SXE2_EXPANSION_END)
+		pattern->rss_type_allow |= RTE_ETH_RSS_NONFRAG_IPV6_OTHER;
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_ipv6_frag_ext(const struct rte_flow_item *item,
+					 struct rte_flow_error *error,
+					 struct sxe2_flow *flow,
+					 enum sxe2_expansion next __rte_unused,
+					 bool is_inner)
+{
+	const struct rte_flow_item_ipv6_frag_ext *ipv6_frag_spec;
+	const struct rte_flow_item_ipv6_frag_ext *ipv6_frag_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	ipv6_frag_spec = item->spec;
+	ipv6_frag_mask = item->mask;
+
+	if (ipv6_frag_mask == NULL && ipv6_frag_spec == NULL)
+		goto l_end;
+
+	if (ipv6_frag_mask->hdr.reserved || ipv6_frag_mask->hdr.frag_data ||
+	    ipv6_frag_mask->hdr.id || ipv6_frag_mask->hdr.next_header) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some IPv6 frag ext mask");
+		PMD_LOG_ERR(DRV, "Unsupported some IPv6 frag ext mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_IPV_FRAG, pattern->hdrs);
+	pattern->rss_type_allow |= RTE_ETH_RSS_FRAG_IPV6;
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_tcp(const struct rte_flow_item *item,
+				struct rte_flow_error *error,
+				struct sxe2_flow *flow,
+				enum sxe2_expansion next __rte_unused,
+				bool is_inner)
+{
+	const struct rte_flow_item_tcp *tcp_spec;
+	const struct rte_flow_item_tcp *tcp_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	tcp_spec = item->spec;
+	tcp_mask = item->mask;
+
+	if (tcp_mask == NULL && tcp_spec == NULL)
+		goto l_end;
+
+	if (tcp_mask->hdr.sent_seq || tcp_mask->hdr.recv_ack ||
+	    tcp_mask->hdr.data_off || tcp_mask->hdr.tcp_flags ||
+	    tcp_mask->hdr.rx_win || tcp_mask->hdr.cksum ||
+	    tcp_mask->hdr.tcp_urp) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some TCP mask");
+		PMD_LOG_ERR(DRV, "Unsupported some TCP mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (tcp_mask->hdr.src_port) {
+		if (tcp_mask->hdr.src_port != UINT16_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_SRC_PORT, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_SRC_PORT, pattern->map_spec);
+		pattern->item_spec.tcp.source = tcp_spec->hdr.src_port;
+		pattern->item_mask.tcp.source = tcp_mask->hdr.src_port;
+	}
+	if (tcp_mask->hdr.dst_port) {
+		if (tcp_mask->hdr.dst_port != UINT16_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_DST_PORT, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_TCP_DST_PORT, pattern->map_spec);
+		pattern->item_spec.tcp.dest = tcp_spec->hdr.dst_port;
+		pattern->item_mask.tcp.dest = tcp_mask->hdr.dst_port;
+	}
+
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_TCP, pattern->hdrs);
+	if (sxe2_test_bit(SXE2_FLOW_HDR_IPV4, pattern->hdrs))
+		pattern->rss_type_allow |= RTE_ETH_RSS_NONFRAG_IPV4_TCP;
+	else if (sxe2_test_bit(SXE2_FLOW_HDR_IPV6, pattern->hdrs))
+		pattern->rss_type_allow |= RTE_ETH_RSS_NONFRAG_IPV6_TCP;
+
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_SRC_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_DST_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_CHKSUM;
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_udp(const struct rte_flow_item *item,
+				struct rte_flow_error *error,
+				struct sxe2_flow *flow,
+				enum sxe2_expansion next __rte_unused,
+				bool is_inner)
+{
+	const struct rte_flow_item_udp *udp_spec;
+	const struct rte_flow_item_udp *udp_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	udp_spec = item->spec;
+	udp_mask = item->mask;
+
+	if (udp_mask == NULL && udp_spec == NULL)
+		goto l_end;
+
+	if (udp_mask->hdr.dgram_len || udp_mask->hdr.dgram_cksum) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some UDP mask");
+		PMD_LOG_ERR(DRV, "Unsupported some UDP mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (udp_mask->hdr.src_port) {
+		if (udp_mask->hdr.src_port != UINT16_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_SRC_PORT, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_SRC_PORT, pattern->map_spec);
+		pattern->item_spec.udp.source = udp_spec->hdr.src_port;
+		pattern->item_mask.udp.source = udp_mask->hdr.src_port;
+	}
+	if (udp_mask->hdr.dst_port) {
+		if (udp_mask->hdr.dst_port != UINT16_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_DST_PORT, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_UDP_DST_PORT, pattern->map_spec);
+		pattern->item_spec.udp.dest = udp_spec->hdr.dst_port;
+		pattern->item_mask.udp.dest = udp_mask->hdr.dst_port;
+	}
+
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_UDP, pattern->hdrs);
+	if (sxe2_test_bit(SXE2_FLOW_HDR_IPV4, pattern->hdrs))
+		pattern->rss_type_allow |= RTE_ETH_RSS_NONFRAG_IPV4_UDP;
+	else if (sxe2_test_bit(SXE2_FLOW_HDR_IPV6, pattern->hdrs))
+		pattern->rss_type_allow |= RTE_ETH_RSS_NONFRAG_IPV6_UDP;
+
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_SRC_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_DST_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_CHKSUM;
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_sctp(const struct rte_flow_item *item,
+					struct rte_flow_error *error,
+					struct sxe2_flow *flow,
+					enum sxe2_expansion next __rte_unused,
+					bool is_inner)
+{
+	const struct rte_flow_item_sctp *sctp_spec;
+	const struct rte_flow_item_sctp *sctp_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	sctp_spec = item->spec;
+	sctp_mask = item->mask;
+
+	if (sctp_mask == NULL && sctp_spec == NULL)
+		goto l_end;
+
+	if (sctp_mask->hdr.cksum || sctp_mask->hdr.tag) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some SCTP mask");
+		PMD_LOG_ERR(DRV, "Unsupported some SCTP mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (sctp_mask->hdr.src_port) {
+		if (sctp_mask->hdr.src_port != UINT16_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_SRC_PORT, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_SRC_PORT, pattern->map_spec);
+		pattern->item_spec.sctp.src_port = sctp_spec->hdr.src_port;
+		pattern->item_mask.sctp.src_port = sctp_mask->hdr.src_port;
+	}
+	if (sctp_mask->hdr.dst_port) {
+		if (sctp_mask->hdr.dst_port != UINT16_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_DST_PORT, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_SCTP_DST_PORT, pattern->map_spec);
+		pattern->item_spec.sctp.dst_port = sctp_spec->hdr.dst_port;
+		pattern->item_mask.sctp.dst_port = sctp_mask->hdr.dst_port;
+	}
+
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_SCTP, pattern->hdrs);
+	if (sxe2_test_bit(SXE2_FLOW_HDR_IPV4, pattern->hdrs))
+		pattern->rss_type_allow |= RTE_ETH_RSS_NONFRAG_IPV4_SCTP;
+	else if (sxe2_test_bit(SXE2_FLOW_HDR_IPV6, pattern->hdrs))
+		pattern->rss_type_allow |= RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_SRC_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_DST_ONLY;
+	pattern->rss_type_allow |= RTE_ETH_RSS_L4_CHKSUM;
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_geneve(const struct rte_flow_item *item,
+							struct rte_flow_error *error,
+							struct sxe2_flow *flow,
+							enum sxe2_expansion next __rte_unused,
+							bool is_inner)
+{
+	const struct rte_flow_item_geneve *geneve_spec;
+	const struct rte_flow_item_geneve *geneve_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	geneve_spec = item->spec;
+	geneve_mask = item->mask;
+
+	if (!(geneve_spec && geneve_mask))
+		goto l_end;
+
+	if (geneve_mask->protocol || geneve_mask->ver_opt_len_o_c_rsvd0 || geneve_mask->rsvd1) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some Geneve mask");
+		PMD_LOG_ERR(DRV, "Unsupported some Geneve mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (geneve_mask->vni[0] || geneve_mask->vni[1] || geneve_mask->vni[2]) {
+		if (strcmp((const char *)geneve_mask->vni, "\xFF\xFF\xFF") != 0)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_GENEVE_VNI, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_GENEVE_VNI, pattern->map_spec);
+		pattern->item_spec.geneve.vni = (geneve_spec->vni[2] << 16) |
+			(geneve_spec->vni[1] << 8) | geneve_spec->vni[0];
+		pattern->item_mask.geneve.vni = (geneve_mask->vni[2] << 16) |
+			(geneve_mask->vni[1] << 8) | geneve_mask->vni[0];
+	}
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_GENEVE, pattern->hdrs);
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_gtpu(const struct rte_flow_item *item,
+						struct rte_flow_error *error,
+						struct sxe2_flow *flow,
+						enum sxe2_expansion next __rte_unused,
+						bool is_inner)
+{
+	const struct rte_flow_item_gtp *gtpu_spec;
+	const struct rte_flow_item_gtp *gtpu_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	gtpu_spec = item->spec;
+	gtpu_mask = item->mask;
+
+	if (gtpu_mask == NULL && gtpu_spec == NULL)
+		goto l_end;
+
+	if (gtpu_mask->v_pt_rsv_flags || gtpu_mask->msg_type || gtpu_mask->msg_len) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some GTPU mask");
+		PMD_LOG_ERR(DRV, "Unsupported some GTPU mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (gtpu_mask->teid) {
+		if (gtpu_mask->teid != UINT32_MAX)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_GTPU_TEID, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_GTPU_TEID, pattern->map_spec);
+		pattern->item_spec.gtpu.teid = gtpu_spec->teid;
+		pattern->item_mask.gtpu.teid = gtpu_mask->teid;
+	}
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_GTPU, pattern->hdrs);
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_gre(const struct rte_flow_item *item,
+					struct rte_flow_error *error,
+					struct sxe2_flow *flow,
+					enum sxe2_expansion next __rte_unused,
+					bool is_inner)
+{
+	const struct rte_flow_item_gre *gre_spec;
+	const struct rte_flow_item_gre *gre_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	gre_spec = item->spec;
+	gre_mask = item->mask;
+
+	if (gre_mask == NULL && gre_spec == NULL)
+		goto l_end;
+
+	if (gre_mask->c_rsvd0_ver || gre_mask->protocol) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some GRE mask");
+		PMD_LOG_ERR(DRV, "Unsupported some GRE mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_GRE, pattern->hdrs);
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_nvgre(const struct rte_flow_item *item,
+					struct rte_flow_error *error,
+					struct sxe2_flow *flow,
+					enum sxe2_expansion next __rte_unused,
+					bool is_inner)
+{
+	const struct rte_flow_item_nvgre *nvgre_spec;
+	const struct rte_flow_item_nvgre *nvgre_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	nvgre_spec = item->spec;
+	nvgre_mask = item->mask;
+
+	if (nvgre_mask == NULL && nvgre_spec == NULL)
+		goto l_end;
+
+	if (nvgre_mask->c_k_s_rsvd0_ver || nvgre_mask->protocol || nvgre_mask->flow_id) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some NVGRE mask");
+		PMD_LOG_ERR(DRV, "Unsupported some NVGRE mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (nvgre_mask->tni[0] || nvgre_mask->tni[1] || nvgre_mask->tni[2]) {
+		if (strcmp((const char *)nvgre_mask->tni, "\xFF\xFF\xFF") != 0)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_NVGRE_TNI, pattern->map_mask);
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_NVGRE_TNI, pattern->map_spec);
+		pattern->item_spec.nvgre.tni =
+			(nvgre_spec->tni[2] << 16) |
+			(nvgre_spec->tni[1] << 8) |
+			(nvgre_spec->tni[0]);
+		pattern->item_mask.nvgre.tni =
+			(nvgre_mask->tni[2] << 16) |
+			(nvgre_mask->tni[1] << 8) |
+			(nvgre_mask->tni[0]);
+	}
+
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_GRE, pattern->hdrs);
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_vxlan(const struct rte_flow_item *item,
+					struct rte_flow_error *error,
+					struct sxe2_flow *flow,
+					enum sxe2_expansion next __rte_unused,
+					bool is_inner)
+{
+	const struct rte_flow_item_vxlan *vxlan_spec;
+	const struct rte_flow_item_vxlan *vxlan_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	vxlan_spec = item->spec;
+	vxlan_mask = item->mask;
+
+	if (vxlan_mask == NULL && vxlan_spec == NULL)
+		goto l_end;
+
+	if (vxlan_mask->flags ||
+	    vxlan_mask->rsvd1 ||
+	    vxlan_mask->rsvd0[0] ||
+	    vxlan_mask->rsvd0[1] ||
+	    vxlan_mask->rsvd0[2]) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some VXLAN mask");
+		PMD_LOG_ERR(DRV, "Unsupported some VXLAN mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (vxlan_mask->vni[0] || vxlan_mask->vni[1] || vxlan_mask->vni[2]) {
+		if (strcmp((const char *)vxlan_mask->vni, "\xFF\xFF\xFF") != 0)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_VXLAN_VNI, pattern->map_mask);
+
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_VXLAN_VNI, pattern->map_spec);
+		pattern->item_spec.vxlan.vni =
+			(vxlan_spec->vni[2] << 16) |
+			(vxlan_spec->vni[1] << 8) |
+			(vxlan_spec->vni[0]);
+		pattern->item_mask.vxlan.vni =
+			(vxlan_mask->vni[2] << 16) |
+			(vxlan_mask->vni[1] << 8) |
+			(vxlan_mask->vni[0]);
+	}
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_VXLAN, pattern->hdrs);
+	return ret;
+}
+
+static int32_t sxe2_flow_parse_pattern_vxlan_gpe(const struct rte_flow_item *item,
+					     struct rte_flow_error *error,
+					     struct sxe2_flow *flow,
+					     enum sxe2_expansion next __rte_unused,
+					     bool is_inner)
+{
+	const struct rte_flow_item_vxlan_gpe *vxlan_gpe_spec;
+	const struct rte_flow_item_vxlan_gpe *vxlan_gpe_mask;
+	struct sxe2_flow_pattern *pattern = is_inner ? &flow->pattern_inner : &flow->pattern_outer;
+	int32_t ret = 0;
+	vxlan_gpe_spec = item->spec;
+	vxlan_gpe_mask = item->mask;
+
+	if (vxlan_gpe_mask == NULL && vxlan_gpe_spec == NULL)
+		goto l_end;
+
+	if (vxlan_gpe_mask->flags ||
+	    vxlan_gpe_mask->protocol ||
+	    vxlan_gpe_mask->rsvd1 ||
+	    vxlan_gpe_mask->rsvd0[0] ||
+	    vxlan_gpe_mask->rsvd0[1]) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Unsupported some VXLAN-GPE mask");
+		PMD_LOG_ERR(DRV, "Unsupported some VXLAN-GPE mask");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if (vxlan_gpe_mask->vni[0] || vxlan_gpe_mask->vni[1] || vxlan_gpe_mask->vni[2]) {
+		if (strcmp((const char *)vxlan_gpe_mask->vni, "\xFF\xFF\xFF") != 0)
+			sxe2_set_bit(SXE2_FLOW_FLD_ID_VXLAN_VNI, pattern->map_mask);
+
+		sxe2_set_bit(SXE2_FLOW_FLD_ID_VXLAN_VNI, pattern->map_spec);
+		pattern->item_spec.vxlan.vni =
+			(vxlan_gpe_spec->vni[2] << 16) |
+			(vxlan_gpe_spec->vni[1] << 8) |
+			(vxlan_gpe_spec->vni[0]);
+		pattern->item_mask.vxlan.vni =
+			(vxlan_gpe_mask->vni[2] << 16) |
+			(vxlan_gpe_mask->vni[1] << 8) |
+			(vxlan_gpe_mask->vni[0]);
+	}
+
+l_end:
+	sxe2_set_bit(SXE2_FLOW_HDR_VXLAN, pattern->hdrs);
+	return ret;
+}
+
+struct sxe2_flow_parse_pattern_ops sxe2_flow_parse_pattern_list[] = {
+	[SXE2_EXPANSION_OUTER_ETH] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_eth,
+	},
+	[SXE2_EXPANSION_OUTER_VLAN] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_vlan,
+	},
+	[SXE2_EXPANSION_OUTER_QINQ] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_vlan,
+	},
+	[SXE2_EXPANSION_OUTER_IPV4] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_ipv4,
+	},
+	[SXE2_EXPANSION_OUTER_IPV6] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_ipv6,
+	},
+	[SXE2_EXPANSION_OUTER_IPV6_FRAG_EXT] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_ipv6_frag_ext,
+	},
+	[SXE2_EXPANSION_OUTER_TCP] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_tcp,
+	},
+	[SXE2_EXPANSION_OUTER_UDP] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_udp,
+	},
+	[SXE2_EXPANSION_OUTER_SCTP] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_sctp,
+	},
+	[SXE2_EXPANSION_GENEVE] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_geneve,
+	},
+	[SXE2_EXPANSION_GTPU] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_gtpu,
+	},
+	[SXE2_EXPANSION_GRE] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_gre,
+	},
+	[SXE2_EXPANSION_NVGRE] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_nvgre,
+	},
+	[SXE2_EXPANSION_VXLAN] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_vxlan,
+	},
+	[SXE2_EXPANSION_VXLAN_GPE] = {
+		.is_inner = false,
+		.func = sxe2_flow_parse_pattern_vxlan_gpe,
+	},
+	[SXE2_EXPANSION_ETH] = {
+		.is_inner = true,
+		.func = sxe2_flow_parse_pattern_eth,
+	},
+	[SXE2_EXPANSION_VLAN] = {
+		.is_inner = true,
+		.func = sxe2_flow_parse_pattern_vlan,
+	},
+	[SXE2_EXPANSION_IPV4] = {
+		.is_inner = true,
+		.func = sxe2_flow_parse_pattern_ipv4,
+	},
+	[SXE2_EXPANSION_IPV6] = {
+		.is_inner = true,
+		.func = sxe2_flow_parse_pattern_ipv6,
+	},
+	[SXE2_EXPANSION_IPV6_FRAG_EXT] = {
+		.is_inner = true,
+		.func = sxe2_flow_parse_pattern_ipv6_frag_ext,
+	},
+	[SXE2_EXPANSION_TCP] = {
+		.is_inner = true,
+		.func = sxe2_flow_parse_pattern_tcp,
+	},
+	[SXE2_EXPANSION_UDP] = {
+		.is_inner = true,
+		.func = sxe2_flow_parse_pattern_udp,
+	},
+	[SXE2_EXPANSION_SCTP] = {
+		.is_inner = true,
+		.func = sxe2_flow_parse_pattern_sctp,
+	},
+
+};
+
+int32_t sxe2_flow_parse_pattern(struct rte_eth_dev *dev __rte_unused,
+			    const struct rte_flow_item patterns[],
+			    struct rte_flow_error *error,
+			    struct sxe2_flow *flow)
+{
+	int32_t ret = 0;
+	const struct rte_flow_item *item = patterns;
+	enum sxe2_expansion now = SXE2_EXPANSION_OUTER_ETH;
+	enum sxe2_expansion next = SXE2_EXPANSION_OUTER_ETH;
+	enum sxe2_flow_tunnel_type tunnel_type = SXE2_FLOW_TUNNEL_TYPE_NONE;
+	DECLARE_BITMAP(flow_type, SXE2_EXPANSION_MAX);
+	sxe2_bitmap_zero(flow_type, SXE2_EXPANSION_MAX);
+	sxe2_flow_parse_pattern_func_t func;
+	bool is_inner = false;
+
+	for (item = patterns; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+		if (item->type == RTE_FLOW_ITEM_TYPE_VOID)
+			continue;
+
+		if (item->last) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"FANV not support range pattern.");
+			PMD_LOG_ERR(DRV, "flow not supported range pattern.");
+			ret = -EINVAL;
+			goto l_end;
+		}
+		ret = sxe2_flow_is_expandable_item(item);
+		if (ret != 0) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Unsupported item type.");
+			PMD_LOG_ERR(DRV, "Unsupported item type: %d", item->type);
+			goto l_end;
+		}
+		next = now;
+		ret = sxe2_flow_valid_next_expansion(&next, item,
+				&tunnel_type, flow_type);
+		if (ret != 0) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Invalid pattern sequence for rule.");
+			PMD_LOG_ERR(DRV, "Invalid pattern sequence for rule.");
+			goto l_end;
+		}
+
+		if ((item->spec != NULL && item->mask == NULL) ||
+		    (item->spec == NULL && item->mask != NULL)) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Invalid pattern spec miss macth mask for rule.");
+			PMD_LOG_ERR(DRV, "Invalid pattern spec miss macth mask for rule.");
+			goto l_end;
+		}
+
+		func = sxe2_flow_parse_pattern_list[now].func;
+		is_inner = sxe2_flow_parse_pattern_list[now].is_inner;
+		ret = func(item, error, flow, next, is_inner);
+		if (ret != 0)
+			goto l_end;
+		now = next;
+	}
+	if (sxe2_bitmap_weight(flow->pattern_outer.hdrs, SXE2_FLOW_HDR_MAX) > 0)
+		flow->has_hdr = 1;
+
+	if (sxe2_bitmap_weight(flow->pattern_inner.map_mask, SXE2_FLOW_FLD_ID_MAX) > 0 ||
+	   sxe2_bitmap_weight(flow->pattern_outer.map_mask, SXE2_FLOW_FLD_ID_MAX) > 0)
+		flow->has_mask = 1;
+
+	if (sxe2_bitmap_weight(flow->pattern_inner.map_spec, SXE2_FLOW_FLD_ID_MAX) > 0 ||
+	   sxe2_bitmap_weight(flow->pattern_outer.map_spec, SXE2_FLOW_FLD_ID_MAX) > 0)
+		flow->has_spec = 1;
+
+	flow->meta.tunnel_type = tunnel_type;
+	if (flow->has_hdr) {
+		ret = sxe2_flow_get_flow_type(flow);
+		if (ret != 0) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					NULL, "Unsupported flow type.");
+			goto l_end;
+		}
+	}
+	sxe2_bitmap_copy(flow->flow_type, flow_type, SXE2_EXPANSION_MAX);
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_flow_parse_pattern.h b/drivers/net/sxe2/sxe2_flow_parse_pattern.h
new file mode 100644
index 0000000000..69d83a6ea6
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_flow_parse_pattern.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef SXE2_FLOW_PARSE_PATTERN_H_
+#define SXE2_FLOW_PARSE_PATTERN_H_
+#include <rte_flow_driver.h>
+#include "sxe2_osal.h"
+#include "sxe2_flow_define.h"
+
+#define SXE2_FLOW_EXPAND_NEXT(...) \
+	((const enum sxe2_expansion []){ \
+		__VA_ARGS__, 0, \
+	})
+
+struct sxe2_flow_expand_node {
+	const enum rte_flow_item_type type;
+	const enum sxe2_flow_tunnel_type tunnel_type;
+	const uint8_t is_tunnel;
+	const enum sxe2_expansion *const next;
+	const char *const name;
+};
+
+typedef int32_t (*sxe2_flow_parse_pattern_func_t)(const struct rte_flow_item *item,
+					      struct rte_flow_error *error,
+					      struct sxe2_flow *flow,
+					      enum sxe2_expansion next,
+					      bool is_inner);
+
+struct sxe2_flow_parse_pattern_ops {
+	bool is_inner;
+	sxe2_flow_parse_pattern_func_t func;
+};
+
+int32_t sxe2_flow_parse_pattern(struct rte_eth_dev *dev,
+			    const struct rte_flow_item patterns[],
+			    struct rte_flow_error *error,
+			    struct sxe2_flow *flow);
+
+#endif /* SXE2_FLOW_PARSE_PATTERN_H_ */
diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index 13619500ea..3634eb99b6 100644
--- a/drivers/net/sxe2/sxe2_irq.c
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -20,6 +20,7 @@
 #include "sxe2vf_regs.h"
 #include "sxe2_host_regs.h"
 #include "sxe2_cmd_chnl.h"
+#include "sxe2_switchdev.h"
 
 #define SXE2_INT_EVENT_OICR_ALL (SXE2_PF_INT_OICR_SWINT | \
 					SXE2_PF_INT_OICR_LAN_TX_ERR | \
@@ -58,6 +59,14 @@ static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t
 						     RTE_ETH_EVENT_INTR_LSC,
 						     NULL);
 	}
+	if (oicr & RTE_BIT32(SXE2_COM_SW_MODE_SWITCHDEV)) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "event notify switchdev");
+		(void)sxe2_switchdev_notify_callback(adapter, true);
+	}
+	if (oicr & RTE_BIT32(SXE2_COM_SW_MODE_LEGACY)) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "event notify legacy");
+		(void)sxe2_switchdev_notify_callback(adapter, false);
+	}
 }
 
 static uint32_t sxe2_event_intr_handle(void *param __rte_unused)
@@ -881,6 +890,42 @@ int32_t sxe2_rxq_intr_enable(struct rte_eth_dev *dev)
 	return ret;
 }
 
+int32_t sxe2_repr_rxq_intr_enable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	uint16_t rxq_cnt = dev->data->nb_rx_queues;
+	int32_t ret = 0;
+	uint16_t qid = adapter->repr_priv_data->repr_q_id;
+	uint32_t val;
+
+	if (!rxq_cnt)
+		goto l_end;
+
+	sxe2_pci_hw_irq_disable(adapter, qid);
+	sxe2_pci_hw_int_itr_set(adapter, qid, SXE2_ITR_INTERVAL_NORMAL);
+	ret = sxe2_drv_rxq_bind_irq(adapter, qid, qid);
+	if (ret != 0) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "RXQ[%u] bind IRQ[%u] failed.",
+				qid, qid);
+		goto l_end;
+	}
+	sxe2_pci_hw_irq_enable(adapter, qid);
+
+	val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, qid);
+	if ((val & SXE2VF_DYN_CTL_INTENABLE) == 0)
+		goto l_end;
+
+	sxe2_pci_hw_msix_disable(adapter, qid);
+	sxe2_pci_hw_irq_trigger(adapter, qid);
+	val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, qid);
+	sxe2_pci_hw_irq_clear_pba(adapter, qid);
+	val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, qid);
+	sxe2_pci_hw_msix_enable(adapter, qid);
+
+l_end:
+	return ret;
+}
+
 void sxe2_rxq_intr_disable(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter =
@@ -901,6 +946,15 @@ void sxe2_rxq_intr_disable(struct rte_eth_dev *dev)
 	return;
 }
 
+void sxe2_repr_rxq_intr_disable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	uint16_t qid = adapter->repr_priv_data->repr_q_id;
+
+	sxe2_pci_hw_irq_disable(adapter, qid);
+	(void)sxe2_drv_rxq_unbind_irq(adapter, qid);
+}
+
 int32_t sxe2_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
 	struct sxe2_adapter *adapter =
diff --git a/drivers/net/sxe2/sxe2_irq.h b/drivers/net/sxe2/sxe2_irq.h
index c898c16f84..e35278610b 100644
--- a/drivers/net/sxe2/sxe2_irq.h
+++ b/drivers/net/sxe2/sxe2_irq.h
@@ -60,8 +60,12 @@ void sxe2_sw_irq_ctx_hw_cap_set(struct sxe2_adapter *adapter,
 
 int32_t sxe2_rxq_intr_enable(struct rte_eth_dev *dev);
 
+int32_t sxe2_repr_rxq_intr_enable(struct rte_eth_dev *dev);
+
 void sxe2_rxq_intr_disable(struct rte_eth_dev *dev);
 
+void sxe2_repr_rxq_intr_disable(struct rte_eth_dev *dev);
+
 int32_t sxe2_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
 
 int32_t sxe2_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
diff --git a/drivers/net/sxe2/sxe2_queue.c b/drivers/net/sxe2/sxe2_queue.c
index 220cab6fce..afb2681b72 100644
--- a/drivers/net/sxe2/sxe2_queue.c
+++ b/drivers/net/sxe2/sxe2_queue.c
@@ -24,7 +24,11 @@ int32_t sxe2_queues_init(struct rte_eth_dev *dev)
 	struct sxe2_rx_queue *rxq;
 	uint16_t nb_rxq;
 
-	frame_size = dev->data->mtu + SXE2_ETH_OVERHEAD;
+	if (adapter->is_dev_repr)
+		frame_size = SXE2_FRAME_SIZE_MAX - SXE2_ETH_OVERHEAD;
+	else
+		frame_size = dev->data->mtu + SXE2_ETH_OVERHEAD;
+
 	for (nb_rxq = 0; nb_rxq < dev->data->nb_rx_queues; nb_rxq++) {
 		rxq = dev->data->rx_queues[nb_rxq];
 		if (!rxq)
diff --git a/drivers/net/sxe2/sxe2_stats.c b/drivers/net/sxe2/sxe2_stats.c
index 7ea2815fa3..2f8bb432c4 100644
--- a/drivers/net/sxe2/sxe2_stats.c
+++ b/drivers/net/sxe2/sxe2_stats.c
@@ -154,7 +154,12 @@ static int32_t sxe2_vsi_hw_stats_get_update(struct sxe2_adapter *adapter)
 
 	ret = sxe2_drv_get_vsi_stats(adapter);
 	if (ret) {
-		PMD_LOG_ERR(DRV, "get vsi stats failed, ret:%d.", ret);
+		if (adapter->is_dev_repr) {
+			PMD_LOG_WARN(DRV, "get repr vsi stats failed, ret:%d.", ret);
+			ret = 0;
+		} else {
+			PMD_LOG_ERR(DRV, "get vsi stats failed, ret:%d.", ret);
+		}
 		goto l_end;
 	}
 
@@ -231,7 +236,7 @@ static void sxe2_stats_update(struct sxe2_adapter *adapter)
 	stats->rx_sw_drop_bytes = sw_stats->rx_sw_drop_bytes +
 			sw_stats_prev->rx_sw_drop_bytes;
 
-	if (adapter->dev_type != SXE2_DEV_T_VF) {
+	if (adapter->dev_type != SXE2_DEV_T_VF  && !adapter->is_dev_repr) {
 		stats->rx_out_of_buffer = hw_stats->rx_out_of_buffer;
 		stats->rx_qblock_drop = hw_stats->rx_qblock_drop;
 		stats->tx_frame_good = hw_stats->tx_frame_good;
@@ -364,7 +369,7 @@ int32_t sxe2_xstats_info_get(struct rte_eth_dev *dev,
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
 		return sxe2_mp_req_get_xstats(dev, xstats, usr_cnt);
 
-	if (adapter->dev_type == SXE2_DEV_T_VF)
+	if (adapter->dev_type == SXE2_DEV_T_VF || adapter->is_dev_repr)
 		xstats_cnt = SXE2_XSTAT_CNT_VF;
 	else
 		xstats_cnt = SXE2_XSTAT_CNT_PF;
@@ -387,7 +392,7 @@ int32_t sxe2_xstats_info_get(struct rte_eth_dev *dev,
 		goto end;
 	}
 
-	if (adapter->dev_type == SXE2_DEV_T_VF) {
+	if (adapter->dev_type == SXE2_DEV_T_VF || adapter->is_dev_repr) {
 		sxe2_stats_update(adapter);
 		for (i = 0; i < xstats_cnt; i++) {
 			(void)sxe2_xstat_vf_offset_get(i, &offset);
@@ -431,7 +436,7 @@ int32_t sxe2_xstats_names_get(__rte_unused struct rte_eth_dev *dev,
 	int32_t ret = -1;
 	uint32_t xstats_cnt = 0;
 
-	if (adapter->dev_type == SXE2_DEV_T_VF) {
+	if (adapter->dev_type == SXE2_DEV_T_VF || adapter->is_dev_repr) {
 		field = sxe2_xstats_field_vf;
 		xstats_cnt = SXE2_XSTAT_CNT_VF;
 	} else {
@@ -476,7 +481,7 @@ int32_t sxe2_stats_hw_reset(struct rte_eth_dev *dev)
 		PMD_LOG_ERR(DRV, "reset vsi stats failed, ret:%d.", ret);
 		goto l_end;
 	}
-	if (adapter->dev_type != SXE2_DEV_T_VF) {
+	if (adapter->dev_type != SXE2_DEV_T_VF && !adapter->is_dev_repr) {
 		ret = sxe2_drv_mac_stats_reset(adapter);
 		if (ret) {
 			PMD_LOG_ERR(DRV, "reset mac stats failed, ret:%d.", ret);
diff --git a/drivers/net/sxe2/sxe2_switchdev.c b/drivers/net/sxe2/sxe2_switchdev.c
new file mode 100644
index 0000000000..44703cfb5c
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_switchdev.c
@@ -0,0 +1,332 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_os.h>
+#include <rte_tailq.h>
+#include "sxe2_osal.h"
+#include "sxe2_mac.h"
+#include "sxe2_common_log.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_switchdev.h"
+#include "sxe2_cmd_chnl.h"
+#include "sxe2_host_regs.h"
+
+int32_t sxe2_uplink_clear(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "Current mode is not switchdev");
+		goto l_end;
+	}
+
+	ret = sxe2_drv_switchdev_uplink_config(adapter, false);
+l_end:
+	return ret;
+}
+
+int32_t sxe2_uplink_set(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "Current mode is not switchdev");
+		goto l_end;
+	}
+
+	ret = sxe2_drv_switchdev_uplink_config(adapter, true);
+l_end:
+	return ret;
+}
+
+int32_t sxe2_repr_clear(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	uint16_t repr_id = 0;
+	struct rte_eth_dev *repr_dev;
+	struct sxe2_adapter *repr_adapter;
+	struct sxe2_switchdev_repr_info repr_vf;
+
+	if (!adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "Current mode is not switchdev");
+		goto l_end;
+	}
+
+	for (repr_id = 0; repr_id < adapter->repr_ctxt.nb_repr_vf; repr_id++) {
+		repr_dev = adapter->repr_ctxt.vf_rep_eth_dev[repr_id];
+		if (!repr_dev)
+			continue;
+		repr_adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(repr_dev);
+		if (repr_adapter &&
+		    repr_adapter->repr_priv_data &&
+		    repr_adapter->repr_priv_data->cp_vsi) {
+			memset(&repr_vf, 0, sizeof(struct sxe2_switchdev_repr_info));
+
+			repr_vf.repr_pf_id = repr_adapter->repr_priv_data->repr_pf_id;
+			repr_vf.repr_vf_id = repr_adapter->repr_priv_data->repr_vf_id;
+			repr_vf.cp_vsi_id = repr_adapter->repr_priv_data->cp_vsi->vsi_id;
+			repr_vf.repr_q_id = repr_adapter->repr_priv_data->repr_q_id;
+			ret = sxe2_drv_switchdev_repr_vf_config(adapter, &repr_vf,
+								false);
+		}
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_repr_set(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+	uint16_t repr_id = 0;
+	struct rte_eth_dev *repr_dev;
+	struct sxe2_adapter *repr_adapter;
+	struct sxe2_switchdev_repr_info repr_vf;
+
+	if (!adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "Current mode is not switchdev");
+		goto l_end;
+	}
+
+	for (repr_id = 0; repr_id < adapter->repr_ctxt.nb_repr_vf; repr_id++) {
+		repr_dev = adapter->repr_ctxt.vf_rep_eth_dev[repr_id];
+		if (!repr_dev)
+			continue;
+		repr_adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(repr_dev);
+		if (repr_adapter &&
+		    repr_adapter->repr_priv_data &&
+		    repr_adapter->repr_priv_data->cp_vsi) {
+			memset(&repr_vf, 0, sizeof(struct sxe2_switchdev_repr_info));
+
+			repr_vf.repr_pf_id = repr_adapter->repr_priv_data->repr_pf_id;
+			repr_vf.repr_vf_id = repr_adapter->repr_priv_data->repr_vf_id;
+			repr_vf.cp_vsi_id = repr_adapter->repr_priv_data->cp_vsi->vsi_id;
+			repr_vf.repr_q_id = repr_adapter->repr_priv_data->repr_q_id;
+			ret = sxe2_drv_switchdev_repr_vf_config(adapter, &repr_vf, true);
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+void sxe2_free_repr_info(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (adapter->repr_ctxt.vf_rep_eth_dev) {
+		rte_free(adapter->repr_ctxt.vf_rep_eth_dev);
+		adapter->repr_ctxt.vf_rep_eth_dev = NULL;
+	}
+
+	adapter->repr_ctxt.nb_repr_vf = 0;
+}
+
+static int32_t sxe2_switchdev_clear(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (!adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "Current mode is not switchdev");
+		goto l_end;
+	}
+
+	adapter->switchdev_info.is_switchdev = false;
+
+	if (!adapter->flow_isolate_cfg && adapter->flow_isolated)
+		adapter->flow_isolated = false;
+
+	ret = sxe2_l2_rule_update(adapter);
+	if (ret != 0)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to update l2 rule");
+
+	ret = sxe2_switchdev_rule_update(adapter);
+	if (ret != 0)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to update switchdev rule");
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_switchdev_set(struct sxe2_adapter *adapter)
+{
+	int32_t ret = 0;
+
+	if (adapter->switchdev_info.is_switchdev) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "Current mode switch dev");
+		goto l_end;
+	}
+
+	adapter->switchdev_info.is_switchdev = true;
+
+	if (adapter->flow_isolate_cfg && !adapter->flow_isolated)
+		adapter->flow_isolated = true;
+
+	ret = sxe2_l2_rule_update(adapter);
+	if (ret != 0)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to update l2 rule");
+
+	ret = sxe2_switchdev_rule_update(adapter);
+	if (ret != 0)
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to update switchdev rule");
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_switchdev_notify_callback(struct sxe2_adapter *adapter, bool set)
+{
+	struct rte_eth_dev *dev = &rte_eth_devices[adapter->dev_info.dev_data->port_id];
+	int32_t ret = 0;
+	bool cur_switchdev_set = false;
+
+	if (adapter->repr_ctxt.nb_repr_vf) {
+		PMD_DEV_LOG_WARN(adapter, DRV, "switch dev notify remove dev");
+		rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_RMV, NULL);
+		goto l_end;
+	}
+
+	ret = sxe2_drv_switchdev_mode_get(adapter, &cur_switchdev_set);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get switchdev mode");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (set != cur_switchdev_set) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "current switchdev mode miss macth");
+		goto l_end;
+	}
+
+	if (set) {
+		ret = sxe2_switchdev_set(adapter);
+		if (ret != 0) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to set switchdev");
+			goto l_end;
+		}
+	} else {
+		ret = sxe2_switchdev_clear(adapter);
+		if (ret != 0) {
+			PMD_DEV_LOG_ERR(adapter, DRV, "Failed to clear switchdev");
+			goto l_end;
+		}
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_switchdev_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	PMD_DEV_LOG_INFO(adapter, INIT, "switchdev init");
+
+	if (adapter->switchdev_info.is_switchdev)
+		adapter->flow_isolated = true;
+
+	adapter->repr_priv_data = NULL;
+	adapter->repr_ctxt.nb_repr_vf = 0;
+
+	return 0;
+}
+
+int32_t sxe2_switchdev_uninit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	PMD_DEV_LOG_INFO(adapter, INIT, "switchdev uinit");
+
+	if (adapter->repr_priv_data) {
+		rte_free(adapter->repr_priv_data);
+		adapter->repr_priv_data = NULL;
+	}
+
+	return 0;
+}
+
+int32_t sxe2_switchdev_dev_info_init(struct rte_eth_dev *dev,
+			struct sxe2_adapter *parent_adapter)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_dev_info *dev_info = &adapter->dev_info;
+	struct sxe2_dev_info *parent_dev_info = &parent_adapter->dev_info;
+	struct sxe2_drv_dev_info_resp dev_info_resp = {0};
+	struct sxe2_drv_dev_fw_info_resp dev_fw_info_resp = {0};
+	int32_t ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	dev_info->pci = parent_dev_info->pci;
+	dev_info->pci.max_vfs = 0;
+
+	ret = sxe2_drv_dev_info_get(adapter, &dev_info_resp);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get device info, ret=[%d]", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_drv_dev_fw_info_get(adapter, &dev_fw_info_resp);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to get device fw info, ret=[%d]", ret);
+		goto l_end;
+	}
+	dev_info->fw.build_id = dev_fw_info_resp.build_id;
+	dev_info->fw.fix_version_id = dev_fw_info_resp.fix_version_id;
+	dev_info->fw.sub_version_id = dev_fw_info_resp.sub_version_id;
+	dev_info->fw.main_version_id = dev_fw_info_resp.main_version_id;
+
+	rte_ether_addr_copy((struct rte_ether_addr *)dev_info_resp.mac_addr,
+						(struct rte_ether_addr *)dev_info->mac.perm_addr);
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_switchdev_repr_private_data_init(struct rte_eth_dev *dev,
+		struct sxe2_adapter *parent_adapter, uint16_t repr_id)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_repr_private_data *repr_priv_data = adapter->repr_priv_data;
+	int32_t ret = 0;
+
+	if (repr_priv_data != NULL)
+		goto l_end;
+
+	repr_priv_data = rte_zmalloc("sxe2_repr_priv_data",
+			sizeof(struct sxe2_repr_private_data), 0);
+	if (repr_priv_data == NULL) {
+		PMD_LOG_ERR(INIT, "Failed to malloc representor private data.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	repr_priv_data->parent_adapter = parent_adapter;
+	repr_priv_data->repr_id = repr_id;
+	repr_priv_data->cp_vsi =
+		TAILQ_FIRST(&parent_adapter->vsi_ctxt.other_vsi_list);
+	if (repr_priv_data->cp_vsi == NULL) {
+		PMD_LOG_ERR(INIT, "Failed to get cp vsi.");
+		ret = -EINVAL;
+		goto l_free;
+	}
+	repr_priv_data->repr_q_id = repr_id;
+	repr_priv_data->repr_pf_id = parent_adapter->pf_idx;
+	repr_priv_data->repr_vf_id = repr_id;
+	repr_priv_data->repr_vf_k_vsi_id =
+		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id;
+	repr_priv_data->repr_vf_u_vsi_id =
+		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
+
+	repr_priv_data->repr_vf_vsi_id =
+		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id !=
+		SXE2_INVALID_VSI_ID ?
+		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id :
+		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
+
+	adapter->repr_priv_data = repr_priv_data;
+	goto l_end;
+l_free:
+	rte_free(repr_priv_data);
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_switchdev.h b/drivers/net/sxe2/sxe2_switchdev.h
new file mode 100644
index 0000000000..0a74454424
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_switchdev.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_SWITCHDEV_H__
+#define __SXE2_SWITCHDEV_H__
+#include <ethdev_driver.h>
+
+struct sxe2_adapter;
+
+int32_t sxe2_uplink_clear(struct sxe2_adapter *adapter);
+
+int32_t sxe2_uplink_set(struct sxe2_adapter *adapter);
+
+int32_t sxe2_repr_clear(struct sxe2_adapter *adapter);
+
+int32_t sxe2_repr_set(struct sxe2_adapter *adapter);
+
+int32_t sxe2_switchdev_notify_callback(struct sxe2_adapter *adapter, bool set);
+
+int32_t sxe2_switchdev_init(struct rte_eth_dev *dev);
+
+int32_t sxe2_switchdev_uninit(struct rte_eth_dev *dev);
+
+void sxe2_free_repr_info(struct rte_eth_dev *dev);
+
+int32_t sxe2_switchdev_dev_info_init(struct rte_eth_dev *dev,
+			struct sxe2_adapter *parent_adapter);
+
+int32_t sxe2_switchdev_repr_private_data_init(struct rte_eth_dev *dev,
+		struct sxe2_adapter *parent_adapter, uint16_t repr_id);
+
+#endif /* __SXE2_SWITCHDEV_H__ */
diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index 2eb8365457..a2cea954d5 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -152,6 +152,13 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 	uint32_t batch_flags = 0;
 
 	PMD_INIT_FUNC_TRACE();
+
+	if (adapter->is_dev_repr) {
+		dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+		dev->tx_pkt_burst = sxe2_tx_pkts;
+		tx_mode_flags = 0;
+		return;
+	}
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		tx_mode_flags = 0;
 		ret = sxe2_tx_vec_support_check(dev, &vec_flags);
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index 8b6e585c36..f3c4fa0d91 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -454,6 +454,14 @@ uint16_t sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkt
 				desc_l2tag2 = tx_pkt->vlan_tci_outer;
 				desc_type_cmd_tso_mss |= SXE2_TX_CTXT_DESC_CMD_IL2TAG2_MASK;
 			}
+			if (unlikely(vsi->vsi_type == SXE2_VSI_T_DPDK_ESW)) {
+				desc_type_cmd_tso_mss |=
+					(SXE2_TX_CTXT_DESC_CMD_SWTCH_VSI <<
+					SXE2_TX_CTXT_DESC_CMD_SHIFT);
+				desc_type_cmd_tso_mss |=
+					((vsi->adapter->repr_priv_data->repr_vf_vsi_id & 0x3FFULL)
+					<< SXE2_TX_CTXT_DESC_VSI_SHIFT);
+			}
 
 			ctxt_desc->tunneling_params =
 				rte_cpu_to_le_32(desc_tunneling_params);
diff --git a/drivers/net/sxe2/sxe2_vsi.c b/drivers/net/sxe2/sxe2_vsi.c
index baaa20c02e..d29480b931 100644
--- a/drivers/net/sxe2/sxe2_vsi.c
+++ b/drivers/net/sxe2/sxe2_vsi.c
@@ -98,9 +98,15 @@ static struct sxe2_vsi *sxe2_vsi_node_create(struct sxe2_adapter *adapter,
 
 static void sxe2_vsi_node_free(struct sxe2_vsi *vsi)
 {
+	struct sxe2_adapter *adapter;
+
 	if (!vsi)
 		return;
 
+	adapter = vsi->adapter;
+	if (vsi->vsi_type == SXE2_VSI_T_ESW)
+		TAILQ_REMOVE(&adapter->vsi_ctxt.other_vsi_list, vsi, next);
+
 	rte_free(vsi);
 	vsi = NULL;
 }
@@ -174,10 +180,54 @@ static int32_t sxe2_main_vsi_create(struct sxe2_adapter *adapter)
 	return ret;
 }
 
+int32_t sxe2_other_vsi_create(struct sxe2_adapter *adapter, uint16_t cnt_vf)
+{
+	int32_t ret = 0;
+	struct sxe2_vsi *other_vsi = NULL;
+	uint16_t vsi_id = SXE2_INVALID_VSI_ID;
+
+	PMD_INIT_FUNC_TRACE();
+
+	other_vsi = sxe2_vsi_node_create(adapter, SXE2_INVALID_VSI_ID, SXE2_VSI_T_DPDK_ESW);
+	if (other_vsi == NULL) {
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	ret = sxe2_drv_switchdev_cpvsi_get(adapter, &vsi_id);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to query vsi from fw, ret=%d", ret);
+		goto l_free_vsi;
+	}
+
+	other_vsi->vsi_id = vsi_id;
+	other_vsi->vsi_type = SXE2_VSI_T_DPDK_ESW;
+
+	ret = sxe2_drv_vsi_info_get(adapter, other_vsi);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Failed to query vsi info from fw, ret=%d", ret);
+		goto l_free_vsi;
+	}
+
+	other_vsi->txqs.q_cnt = RTE_MIN(cnt_vf, other_vsi->txqs.q_cnt);
+	other_vsi->rxqs.q_cnt = RTE_MIN(cnt_vf, other_vsi->rxqs.q_cnt);
+	other_vsi->irqs.avail_cnt = RTE_MIN(cnt_vf, other_vsi->irqs.avail_cnt);
+
+	TAILQ_INSERT_TAIL(&adapter->vsi_ctxt.other_vsi_list, other_vsi, next);
+	goto l_end;
+
+l_free_vsi:
+	sxe2_vsi_node_free(other_vsi);
+l_end:
+	return ret;
+}
+
 int32_t sxe2_vsi_init(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
 	int32_t ret = 0;
+	uint16_t srcvsi_list[SXE2_SRCVSI_PRUNE_MAX_NUM];
+	uint16_t srcvsi_cnt;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -187,6 +237,18 @@ int32_t sxe2_vsi_init(struct rte_eth_dev *dev)
 		goto l_end;
 	}
 
+	if (adapter->vsi_ctxt.kernel_vsi_id != SXE2_INVALID_VSI_ID) {
+		srcvsi_list[0] = adapter->vsi_ctxt.kernel_vsi_id;
+		srcvsi_list[1] = adapter->vsi_ctxt.dpdk_vsi_id;
+		srcvsi_cnt = 2;
+		ret = sxe2_drv_srcvsi_prune_config(adapter, srcvsi_list, srcvsi_cnt, true);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "Failed to set src vsi to fw, ret=%d", ret);
+			goto l_end;
+		}
+		PMD_LOG_DEBUG(DRV, "Successfully set src vsi");
+	}
+
 l_end:
 	return ret;
 }
@@ -194,21 +256,105 @@ int32_t sxe2_vsi_init(struct rte_eth_dev *dev)
 void sxe2_vsi_uninit(struct rte_eth_dev *dev)
 {
 	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi *var, *tvar;
 	int32_t ret;
+	uint16_t srcvsi_list[SXE2_SRCVSI_PRUNE_MAX_NUM];
+	uint16_t srcvsi_cnt;
 
 	if (adapter->vsi_ctxt.main_vsi == NULL) {
 		PMD_LOG_INFO(DRV, "vsi is not created, no need to destroy.");
 		goto l_end;
 	}
 
+	if (adapter->vsi_ctxt.kernel_vsi_id != SXE2_INVALID_VSI_ID) {
+		srcvsi_list[0] = adapter->vsi_ctxt.kernel_vsi_id;
+		srcvsi_list[1] = adapter->vsi_ctxt.dpdk_vsi_id;
+		srcvsi_cnt = 2;
+		ret = sxe2_drv_srcvsi_prune_config(adapter, srcvsi_list,
+						   srcvsi_cnt, false);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "Failed to clear src vsi to fw, ret=%d", ret);
+			if (ret == -EPERM)
+				goto l_free;
+			goto l_end;
+		}
+		PMD_LOG_DEBUG(DRV, "Successfully clear src vsi");
+	}
+
+l_free:
 	ret = sxe2_vsi_destroy(adapter, adapter->vsi_ctxt.main_vsi);
 	if (ret) {
 		PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
 		goto l_end;
 	}
+	RTE_TAILQ_FOREACH_SAFE(var, &adapter->vsi_ctxt.other_vsi_list, next, tvar) {
+		ret = sxe2_vsi_destroy(adapter, var);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "Failed to del vsi from fw, ret=%d", ret);
+			break;
+		}
+	}
 
 	PMD_LOG_DEBUG(DRV, "vsi destroyed.");
 
 l_end:
 	return;
 }
+
+int32_t sxe2_vsi_repr_main_vsi_create(struct rte_eth_dev *dev,
+				  struct sxe2_adapter *parent_adapter,
+				  uint16_t repr_id)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_vsi *vsi = NULL;
+	struct sxe2_vsi *pos;
+	int32_t ret = 0;
+
+	TAILQ_FOREACH(pos, &parent_adapter->vsi_ctxt.other_vsi_list, next) {
+		if (pos->vsi_type == SXE2_VSI_T_DPDK_ESW) {
+			vsi = pos;
+			break;
+		}
+	}
+
+	if (vsi == NULL) {
+		PMD_LOG_ERR(INIT, "Failed to get dpdk vsi.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	TAILQ_INIT(&adapter->vsi_ctxt.other_vsi_list);
+
+	adapter->vsi_ctxt.vsi_type = SXE2_VSI_T_DPDK_ESW;
+	adapter->vsi_ctxt.kernel_vsi_id = SXE2_INVALID_VSI_ID;
+
+	adapter->cdev = parent_adapter->cdev;
+
+	adapter->q_ctxt.base_idx_in_pf = vsi->txqs.base_idx_in_func +
+		RTE_MIN(vsi->txqs.q_cnt, repr_id);
+	adapter->irq_ctxt.base_idx_in_func = vsi->irqs.base_idx_in_pf +
+		RTE_MIN(vsi->irqs.avail_cnt, repr_id);
+	adapter->q_ctxt.qp_cnt_assign = RTE_MIN(vsi->txqs.q_cnt, 1);
+	adapter->irq_ctxt.max_cnt_hw = RTE_MIN(vsi->irqs.avail_cnt, 1);
+
+	adapter->vsi_ctxt.main_vsi =
+		sxe2_vsi_node_create(adapter, vsi->vsi_id, SXE2_VSI_T_DPDK_ESW);
+	if (adapter->vsi_ctxt.main_vsi == NULL) {
+		ret = -ENOMEM;
+		PMD_LOG_ERR(DRV, "Failed to create vsi struct, ret=%d", ret);
+		goto l_end;
+	}
+	adapter->vsi_ctxt.dpdk_vsi_id = adapter->vsi_ctxt.main_vsi->vsi_id;
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+void sxe2_vsi_repr_main_vsi_destroy(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	sxe2_vsi_node_free(adapter->vsi_ctxt.main_vsi);
+}
diff --git a/drivers/net/sxe2/sxe2_vsi.h b/drivers/net/sxe2/sxe2_vsi.h
index e712f738f1..176f34b4f8 100644
--- a/drivers/net/sxe2/sxe2_vsi.h
+++ b/drivers/net/sxe2/sxe2_vsi.h
@@ -192,13 +192,23 @@ struct sxe2_vsi_context {
 	uint16_t bond_member_dpdk_vsi_id[SXE2_MAX_BOND_MEMBER_CNT];
 
 	struct sxe2_vsi *main_vsi;
+
+	struct sxe2_vsi_list_head other_vsi_list;
 };
 
 void sxe2_sw_vsi_ctx_hw_cap_set(struct sxe2_adapter *adapter,
-		struct sxe2_drv_vsi_caps *vsi_caps);
+				struct sxe2_drv_vsi_caps *vsi_caps);
+
+int32_t sxe2_other_vsi_create(struct sxe2_adapter *adapter,  uint16_t cnt_vf);
 
 int32_t sxe2_vsi_init(struct rte_eth_dev *dev);
 
 void sxe2_vsi_uninit(struct rte_eth_dev *dev);
 
+int32_t sxe2_vsi_repr_main_vsi_create(struct rte_eth_dev *dev,
+				  struct sxe2_adapter *parent_adapter,
+				  uint16_t repr_id);
+
+void sxe2_vsi_repr_main_vsi_destroy(struct rte_eth_dev *dev);
+
 #endif /* __SXE2_VSI_H__ */
-- 
2.47.3

