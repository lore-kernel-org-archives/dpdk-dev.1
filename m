Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85514CD4F54
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACD534066E;
	Sun, 24 May 2026 11:33:16 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 78580402C3
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S8;
 Sun, 24 May 2026 17:33:06 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 06/23] net/sxe2: support TM hierarchy and shaping
Date: Sun, 24 May 2026 17:32:42 +0800
Message-ID: <20260524093259.397506-7-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S8
X-Coremail-Antispam: 1UD129KBjvAXoWDJFWxZw15ZFWrAFyrZF48tFb_yoW7Xry7Wo
 W7Wr4UXw4fJw1Ik3y5Xw1xJry7Z3yUW3Z5A3y7uFs8uws3Cw17GF4UGa4Yga929F4FyF1k
 Wwn2v397ZrWUX3yfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1PfHUUUUU
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

This patch implements the traffic management ops for example PMD.
It supports a 4-level hierarchy: port, vsi, queue group and queue.

- Support node add/delete and hierarchy commit.
- Support private shaper and rate limiting on each node.

The hardware requires all nodes to be configured before the hierarchy
is committed to the global registers.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build     |    3 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c |  163 +++++
 drivers/net/sxe2/sxe2_cmd_chnl.h |    6 +
 drivers/net/sxe2/sxe2_drv_cmd.h  |   24 +
 drivers/net/sxe2/sxe2_ethdev.c   |   82 +++
 drivers/net/sxe2/sxe2_ethdev.h   |    6 +
 drivers/net/sxe2/sxe2_tm.c       | 1151 ++++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_tm.h       |   76 ++
 drivers/net/sxe2/sxe2_tx.c       |    1 -
 9 files changed, 1510 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_tm.c
 create mode 100644 drivers/net/sxe2/sxe2_tm.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index dfd31bfc97..d0aa7fecf0 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -63,6 +63,7 @@ sources += files(
         'sxe2_mac.c',
         'sxe2_filter.c',
         'sxe2_rss.c',
+        'sxe2_tm.c',
 )
 
-allow_internal_get_api = true
+allow_internal_get_api = true
\ No newline at end of file
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index b997e7b044..19323ffcc4 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -230,6 +230,7 @@ static void sxe2_txq_ctxt_cfg_fill(struct sxe2_tx_queue *txq,
 				   struct sxe2_drv_txq_cfg_req *req,
 				   uint16_t txq_cnt)
 {
+	struct sxe2_adapter *adapter = txq->vsi->adapter;
 	struct sxe2_drv_txq_ctxt *ctxt = req->cfg;
 	uint16_t q_idx = 0;
 
@@ -241,6 +242,8 @@ static void sxe2_txq_ctxt_cfg_fill(struct sxe2_tx_queue *txq,
 		ctxt->depth = txq[q_idx].ring_depth;
 		ctxt->dma_addr = txq[q_idx].base_addr;
 		ctxt->queue_id = txq[q_idx].queue_id;
+
+		ctxt->sched_mode = sxe2_sched_mode_get(adapter);
 	}
 }
 
@@ -310,6 +313,7 @@ int32_t sxe2_drv_txq_switch(struct sxe2_adapter *adapter, struct sxe2_tx_queue *
 	req.q_idx = txq->queue_id;
 
 	req.is_enable  = (uint8_t)enable;
+	req.sched_mode = sxe2_sched_mode_get(adapter);
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TXQ_DISABLE,
 			&req, sizeof(req), NULL, 0);
 
@@ -714,3 +718,162 @@ int32_t sxe2_drv_ptp_gettime(struct sxe2_adapter *adapter, struct sxe2_rx_queue
 	(void)rxq;
 	return 0;
 }
+
+int32_t sxe2_drv_root_tree_alloc(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_tm_context *tm_ctxt = &adapter->tm_ctxt;
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_tm_res tm_resp;
+	int32_t ret;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_SCHED_ROOT_TREE_ALLOC,
+				 NULL, 0,
+				 &tm_resp, sizeof(tm_resp));
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "add sched root failed, ret:%d", ret);
+		goto l_end;
+	}
+
+	tm_ctxt->root_teid = tm_resp.teid;
+
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_root_tree_release(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_tm_res tm_res = {0};
+	int32_t ret;
+
+	tm_res.teid = adapter->tm_ctxt.root_teid;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_SCHED_ROOT_TREE_RELEASE,
+				 &tm_res, sizeof(tm_res),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "release sched root failed, ret:%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static void sxe2_drv_tm_node_to_info(struct sxe2_adapter *adapter,
+		struct sxe2_tm_node *node, struct sxe2_tm_info *info)
+{
+	uint32_t rate = 0;
+
+	if (node->shaper_profile->profile.committed.rate == UINT64_MAX)
+		rate = UINT32_MAX;
+	else
+		rate = (uint32_t)(node->shaper_profile->profile.committed.rate * 8 / 1000);
+
+	info->committed = rte_cpu_to_le_32(rate);
+
+	if (node->shaper_profile->profile.peak.rate == UINT64_MAX)
+		rate = UINT32_MAX;
+	else
+		rate = (uint32_t)(node->shaper_profile->profile.peak.rate * 8 / 1000);
+
+	info->peak = rte_cpu_to_le_32(rate);
+
+	info->priority = (adapter->tm_ctxt.prio_max - 1 - node->priority);
+
+	info->weight = rte_cpu_to_le_16(node->hw_weight);
+}
+
+static int32_t sxe2_drv_tm_commit_node(struct sxe2_adapter *adapter,
+		struct sxe2_tm_node *tm_node)
+{
+	struct sxe2_drv_cmd_params cmd = { 0 };
+	struct sxe2_tm_add_mid_msg msg_mid = {0};
+	struct sxe2_tm_add_queue_msg msg_queue = {0};
+	struct sxe2_tm_res res = {0};
+	struct sxe2_common_device *cdev = adapter->cdev;
+	int32_t ret;
+	uint32_t i;
+
+	if (tm_node->type == SXE2_TM_NODE_TYPE_VSIG) {
+		goto l_add;
+	} else if (tm_node->type == SXE2_TM_NODE_TYPE_MID) {
+		sxe2_drv_tm_node_to_info(adapter, tm_node, &msg_mid.info);
+		msg_mid.parent_teid = rte_cpu_to_le_16(tm_node->parent->teid);
+		msg_mid.adj_lvl = adapter->sched_ctxt.adj_lvl;
+
+		sxe2_drv_cmd_params_fill(adapter, &cmd,
+					 SXE2_DRV_CMD_SCHED_TM_ADD_MID_NODE,
+					 &msg_mid, sizeof(msg_mid),
+					 &res, sizeof(res));
+		ret = sxe2_drv_cmd_exec(cdev, &cmd);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "add tm mid node failed, ret:%d", ret);
+			goto l_end;
+		}
+	} else if (tm_node->type == SXE2_TM_NODE_TYPE_QUEUE) {
+		sxe2_drv_tm_node_to_info(adapter, tm_node, &msg_queue.info);
+		msg_queue.parent_teid = rte_cpu_to_le_16(tm_node->parent->teid);
+		msg_queue.queue_id = rte_cpu_to_le_16(tm_node->id);
+		msg_queue.adj_lvl = adapter->sched_ctxt.adj_lvl;
+
+		sxe2_drv_cmd_params_fill(adapter, &cmd,
+					 SXE2_DRV_CMD_SCHED_TM_ADD_QUEUE_NODE,
+					 &msg_queue, sizeof(msg_queue),
+					 &res, sizeof(res));
+		ret = sxe2_drv_cmd_exec(cdev, &cmd);
+		if (ret) {
+			PMD_LOG_ERR(DRV, "add tm queue failed, ret:%d", ret);
+			goto l_end;
+		}
+	} else {
+		PMD_LOG_ERR(DRV, "commit tm node failed, type:%d", tm_node->type);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	tm_node->teid = rte_le_to_cpu_16(res.teid);
+
+l_add:
+	for (i = 0; i < tm_node->child_cnt; i++) {
+		ret = sxe2_drv_tm_commit_node(adapter, tm_node->children[i]);
+		if (ret)
+			goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_drv_tm_commit(struct sxe2_adapter *adapter)
+{
+	struct sxe2_drv_cmd_params cmd = { 0 };
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_tm_res tm_res = {0};
+	int32_t ret;
+
+	tm_res.teid = adapter->tm_ctxt.root_teid;
+	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_SCHED_ROOT_CHILDREN_DELETE,
+				 &tm_res, sizeof(tm_res),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &cmd);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "del tm root failed, ret:%d", ret);
+		goto l_end;
+	}
+
+	ret = sxe2_drv_tm_commit_node(adapter, adapter->tm_ctxt.root);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "commit tm node failed, ret:%d", ret);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(DRV, "commit tm success");
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index 3274db6551..6e209377c7 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -38,6 +38,12 @@ int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter);
 
 int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set);
 
+int32_t sxe2_drv_root_tree_release(struct rte_eth_dev *dev);
+
+int32_t sxe2_drv_root_tree_alloc(struct rte_eth_dev *dev);
+
+int32_t sxe2_drv_tm_commit(struct sxe2_adapter *adapter);
+
 int32_t sxe2_drv_allmulti_config(struct sxe2_adapter *adapter, bool set);
 
 int32_t sxe2_drv_uc_config(struct sxe2_adapter *adapter, struct rte_ether_addr *addr, bool add);
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index ced5a4b1a0..07f083644c 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -349,6 +349,30 @@ struct sxe2_rss_hf_req {
 	uint8_t rsv1[3];
 };
 
+struct sxe2_tm_res {
+	__le16 teid;
+};
+
+struct sxe2_tm_info {
+	uint32_t committed;
+	uint32_t peak;
+	uint8_t priority;
+	uint8_t reserve;
+	__le16 weight;
+};
+
+struct sxe2_tm_add_mid_msg {
+	__le16 parent_teid;
+	uint8_t adj_lvl;
+	struct sxe2_tm_info info;
+};
+struct sxe2_tm_add_queue_msg {
+	__le16 parent_teid;
+	__le16 queue_id;
+	uint8_t adj_lvl;
+	struct sxe2_tm_info info;
+};
+
 enum sxe2_drv_cmd_module {
 	SXE2_DRV_CMD_MODULE_HANDSHAKE = 0,
 	SXE2_DRV_CMD_MODULE_DEV = 1,
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index d48841b8e4..a095888c00 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -130,6 +130,8 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.reta_query                 = sxe2_dev_rss_reta_query,
 	.rss_hash_update            = sxe2_dev_rss_hash_update,
 	.rss_hash_conf_get          = sxe2_dev_rss_hash_conf_get,
+
+	.tm_ops_get                 = sxe2_tm_ops_get,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
@@ -575,6 +577,14 @@ static void sxe2_drv_dev_caps_set(struct sxe2_adapter *adapter,
 		adapter->cap_flags |= SXE2_DEV_CAPS_OFFLOAD_FC_STATE;
 }
 
+static void sxe2_sw_sched_hw_cap_set(struct sxe2_adapter *adapter,
+				     struct sxe2_txsch_caps *txsch_caps)
+{
+	adapter->sched_ctxt.tm_layers = txsch_caps->layer_cap;
+	adapter->sched_ctxt.root_max_children = txsch_caps->tm_mid_node_num;
+	adapter->sched_ctxt.prio_max = txsch_caps->prio_num;
+}
+
 static int32_t sxe2_func_caps_get(struct sxe2_adapter *adapter)
 {
 	int32_t ret = -1;
@@ -594,6 +604,8 @@ static int32_t sxe2_func_caps_get(struct sxe2_adapter *adapter)
 
 	sxe2_sw_vsi_ctx_hw_cap_set(adapter, &dev_caps.vsi_caps);
 
+	sxe2_sw_sched_hw_cap_set(adapter, &dev_caps.txsch_caps);
+
 l_end:
 	return ret;
 }
@@ -930,6 +942,68 @@ void sxe2_dev_pci_map_uinit(struct rte_eth_dev *dev)
 	adapter->dev_info.dev_data = NULL;
 }
 
+uint32_t sxe2_sched_mode_get(struct sxe2_adapter *adapter)
+{
+	uint32_t ret_mode = SXE2_SCHED_MODE_INVALID;
+	struct sxe2_tm_context *tm_ctxt = &adapter->tm_ctxt;
+
+	if (adapter->devargs.high_performance_mode)
+		ret_mode = SXE2_SCHED_MODE_HIGH_PERFORMANCE;
+	else if (tm_ctxt->committed)
+		ret_mode = SXE2_SCHED_MODE_TM;
+	else
+		ret_mode = SXE2_SCHED_MODE_DEFAULT;
+
+	return ret_mode;
+}
+
+static int32_t sxe2_sched_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	adapter->sched_ctxt.adj_lvl = adapter->devargs.sched_layer_mode;
+
+	if (adapter->devargs.high_performance_mode) {
+		PMD_LOG_DEBUG(DRV, "TM feature will be disabled in high-performance mode.");
+		adapter->cap_flags &= ~(SXE2_DEV_CAPS_OFFLOAD_TM);
+	} else {
+		ret = sxe2_tm_init(dev);
+		if (ret)
+			goto l_end;
+
+		ret = sxe2_drv_root_tree_alloc(dev);
+		if (ret)
+			goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_sched_uinit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	if (adapter->devargs.high_performance_mode == 0) {
+		ret = sxe2_tm_uninit(dev);
+		if (ret) {
+			PMD_LOG_ERR(INIT, "Failed to uninit tm, ret=%d", ret);
+			goto l_end;
+		}
+
+		ret = sxe2_drv_root_tree_release(dev);
+		if (ret) {
+			PMD_LOG_ERR(INIT, "Failed to release root tree, ret=%d", ret);
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 			     struct sxe2_dev_kvargs_info *kvargs __rte_unused)
 {
@@ -985,8 +1059,15 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_rss_err;
 	}
 
+	ret = sxe2_sched_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to init sched, ret=%d", ret);
+		goto init_sched_err;
+	}
+
 	goto l_end;
 
+init_sched_err:
 init_rss_err:
 init_eth_err:
 init_dev_info_err:
@@ -1002,6 +1083,7 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	(void)sxe2_dev_stop(dev);
 	(void)sxe2_queues_release(dev);
 	(void)sxe2_rss_disable(dev);
+	(void)sxe2_sched_uinit(dev);
 	sxe2_vsi_uninit(dev);
 	sxe2_dev_pci_map_uinit(dev);
 	sxe2_eth_uinit(dev);
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 556a11cc77..609e1e92ba 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
  */
+
 #ifndef __SXE2_ETHDEV_H__
 #define __SXE2_ETHDEV_H__
 #include <rte_compat.h>
@@ -18,6 +19,7 @@
 #include "sxe2_queue.h"
 #include "sxe2_mac.h"
 #include "sxe2_osal.h"
+#include "sxe2_tm.h"
 #include "sxe2_filter.h"
 
 struct sxe2_link_msg {
@@ -307,6 +309,8 @@ struct sxe2_adapter {
 	struct sxe2_rss_context       rss_ctxt;
 	struct sxe2_link_context      link_ctxt;
 	struct sxe2_ptp_context       ptp_ctxt;
+	struct sxe2_sched_hw_cap      sched_ctxt;
+	struct sxe2_tm_context        tm_ctxt;
 	struct sxe2_devargs           devargs;
 	struct sxe2_switchdev_info    switchdev_info;
 	bool                          rule_started;
@@ -333,6 +337,8 @@ void *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 			    enum sxe2_pci_map_resource res_type,
 			    uint16_t idx_in_func);
 
+uint32_t sxe2_sched_mode_get(struct sxe2_adapter *adapter);
+
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
 						    enum sxe2_pci_map_resource res_type);
 
diff --git a/drivers/net/sxe2/sxe2_tm.c b/drivers/net/sxe2/sxe2_tm.c
new file mode 100644
index 0000000000..4c4f793cd5
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_tm.c
@@ -0,0 +1,1151 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_ethdev.h>
+#include <rte_tm_driver.h>
+
+#include "sxe2_tm.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_common_log.h"
+#include "sxe2_cmd_chnl.h"
+
+static uint16_t sxe2_tm_level_node_num_get(uint8_t level)
+{
+	uint16_t node_num = 0;
+
+	switch (level) {
+	case 0:
+		node_num = SXE2_TM_1L_NODE_NUM_MAX;
+		break;
+	case 1:
+		node_num = SXE2_TM_2L_NODE_NUM_MAX;
+		break;
+	case 2:
+		node_num = SXE2_TM_3L_NODE_NUM_MAX;
+	break;
+	case 3:
+		node_num = SXE2_TM_4L_NODE_NUM_MAX;
+		break;
+	}
+	return node_num;
+}
+
+static int32_t sxe2_tm_capabilities_get(struct rte_eth_dev *dev,
+			  struct rte_tm_capabilities *cap,
+			  struct rte_tm_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	uint32_t i;
+
+	if (!cap || !error) {
+		PMD_LOG_ERR(DRV, "sxe2 get tm cap failed, cap or error is NULL.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_end;
+	}
+
+	error->type = RTE_TM_ERROR_TYPE_NONE;
+	memset(cap, 0, sizeof(struct rte_tm_capabilities));
+
+	for (i = 0; i < adapter->tm_ctxt.tm_layers; i++)
+		cap->n_nodes_max += sxe2_tm_level_node_num_get(i);
+
+	cap->n_levels_max = adapter->tm_ctxt.tm_layers;
+
+	cap->non_leaf_nodes_identical = 1;
+
+	cap->leaf_nodes_identical = 1;
+
+	cap->shaper_n_max = cap->n_nodes_max;
+
+	cap->shaper_private_n_max = cap->n_nodes_max;
+
+	cap->shaper_private_dual_rate_n_max = cap->n_nodes_max;
+
+	cap->shaper_private_rate_min = 0;
+
+	cap->shaper_private_rate_max = 12500000000ull;
+
+	cap->shaper_private_packet_mode_supported = 0;
+	cap->shaper_private_byte_mode_supported = 1;
+
+	cap->shaper_pkt_length_adjust_min = RTE_TM_ETH_FRAMING_OVERHEAD;
+
+	cap->shaper_pkt_length_adjust_max = RTE_TM_ETH_FRAMING_OVERHEAD_FCS;
+
+	cap->shaper_shared_n_max = 0;
+	cap->shaper_shared_n_nodes_per_shaper_max = 0;
+	cap->shaper_shared_n_shapers_per_node_max = 0;
+	cap->shaper_shared_dual_rate_n_max = 0;
+	cap->shaper_shared_rate_min = 0;
+	cap->shaper_shared_rate_max = 0;
+	cap->shaper_shared_packet_mode_supported = 0;
+	cap->shaper_shared_byte_mode_supported = 0;
+
+	cap->sched_n_children_max = dev->data->nb_tx_queues;
+
+	cap->sched_sp_n_priorities_max = 7;
+
+	cap->sched_wfq_n_children_per_group_max = 1;
+	cap->sched_wfq_n_groups_max = 0;
+	cap->sched_wfq_weight_max = 0;
+	cap->sched_wfq_packet_mode_supported = 0;
+	cap->sched_wfq_byte_mode_supported = 0;
+
+	cap->cman_wred_packet_mode_supported = 0;
+	cap->cman_wred_byte_mode_supported = 0;
+	cap->cman_head_drop_supported = 0;
+	cap->cman_wred_context_n_max = 0;
+	cap->cman_wred_context_private_n_max = 0;
+	cap->cman_wred_context_shared_n_max = 0;
+	cap->cman_wred_context_shared_n_nodes_per_context_max = 0;
+	cap->cman_wred_context_shared_n_contexts_per_node_max = 0;
+
+	cap->dynamic_update_mask = 0;
+
+	cap->stats_mask = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_level_capabilities_get(struct rte_eth_dev *dev,
+		uint32_t level_id, struct rte_tm_level_capabilities *cap,
+		struct rte_tm_error *error)
+{
+	int32_t ret = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (!cap || !error) {
+		PMD_LOG_ERR(DRV, "sxe2 get tm cap failed, cap or error is NULL.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_end;
+	}
+
+	if (level_id >= adapter->tm_ctxt.tm_layers) {
+		ret = -EINVAL;
+		error->type = RTE_TM_ERROR_TYPE_LEVEL_ID;
+		error->message = "too deep level";
+		goto l_end;
+	}
+
+	cap->n_nodes_max = sxe2_tm_level_node_num_get(level_id);
+
+	cap->non_leaf_nodes_identical = true;
+
+	cap->leaf_nodes_identical = true;
+
+	if (level_id != adapter->tm_ctxt.tm_layers - 1) {
+		cap->n_nodes_nonleaf_max = cap->n_nodes_max;
+		cap->n_nodes_leaf_max = 0;
+
+		cap->nonleaf.shaper_private_supported = true;
+		cap->nonleaf.shaper_private_dual_rate_supported = true;
+		cap->nonleaf.shaper_private_rate_min = 0;
+
+		cap->nonleaf.shaper_private_rate_max = 12500000000ull;
+		cap->nonleaf.shaper_private_packet_mode_supported = 0;
+		cap->nonleaf.shaper_private_byte_mode_supported = 1;
+
+		cap->nonleaf.shaper_shared_n_max = 0;
+		cap->nonleaf.shaper_shared_packet_mode_supported = 0;
+		cap->nonleaf.shaper_shared_byte_mode_supported = 0;
+
+		cap->nonleaf.sched_n_children_max = SXE2_TM_MAX_CHILDREN_COUNT;
+		cap->nonleaf.sched_sp_n_priorities_max = 7;
+
+		cap->nonleaf.sched_wfq_n_children_per_group_max = 0;
+		cap->nonleaf.sched_wfq_n_groups_max = 0;
+		cap->nonleaf.sched_wfq_weight_max = 0;
+		cap->nonleaf.sched_wfq_packet_mode_supported = 0;
+		cap->nonleaf.sched_wfq_byte_mode_supported = 0;
+
+		cap->nonleaf.stats_mask = 0;
+	} else {
+		cap->n_nodes_nonleaf_max = 0;
+		cap->n_nodes_leaf_max = cap->n_nodes_max;
+
+		cap->leaf.shaper_private_supported = true;
+		cap->leaf.shaper_private_dual_rate_supported = true;
+		cap->leaf.shaper_private_rate_min = 0;
+		cap->leaf.shaper_private_rate_max = 12500000000ull;
+		cap->leaf.shaper_private_packet_mode_supported = 0;
+		cap->leaf.shaper_private_byte_mode_supported = 1;
+
+		cap->leaf.shaper_shared_n_max = 0;
+		cap->leaf.shaper_shared_packet_mode_supported = 0;
+		cap->leaf.shaper_shared_byte_mode_supported = 0;
+
+		cap->leaf.cman_head_drop_supported = false;
+		cap->leaf.cman_wred_context_private_supported = false;
+		cap->leaf.cman_wred_context_shared_n_max = 0;
+
+		cap->leaf.stats_mask = 0;
+	}
+
+l_end:
+	return ret;
+}
+
+static struct sxe2_tm_node *sxe2_tm_find_node(struct sxe2_tm_node *parent, uint32_t id)
+{
+	struct sxe2_tm_node *node = NULL;
+	uint32_t i;
+
+	if (parent == NULL || parent->id == id) {
+		node = parent;
+		goto l_end;
+	}
+
+	for (i = 0; i < parent->child_cnt; i++) {
+		node = sxe2_tm_find_node(parent->children[i], id);
+		if (node)
+			goto l_end;
+	}
+
+l_end:
+	return node;
+}
+
+static int32_t sxe2_node_capabilities_get(struct rte_eth_dev *dev, uint32_t node_id,
+				      struct rte_tm_node_capabilities *cap,
+				      struct rte_tm_error *error)
+{
+	int32_t ret = -EINVAL;
+	struct sxe2_tm_node *tm_node;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (!cap || !error) {
+		PMD_LOG_ERR(DRV, "sxe2 get tm cap failed, cap or error is NULL.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_end;
+	}
+
+	if (node_id == RTE_TM_NODE_ID_NULL) {
+		PMD_LOG_ERR(DRV, "invalid node id");
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "invalid node id";
+		goto l_end;
+	}
+
+	tm_node = sxe2_tm_find_node(adapter->tm_ctxt.root, node_id);
+	if (!tm_node) {
+		PMD_LOG_ERR(DRV, "no such node");
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "no such node";
+		goto l_end;
+	}
+
+	cap->shaper_private_supported = true;
+	cap->shaper_private_dual_rate_supported = true;
+	cap->shaper_private_rate_min = 0;
+	cap->shaper_private_rate_max = 12500000000ull;
+	cap->shaper_private_packet_mode_supported = 0;
+	cap->shaper_private_byte_mode_supported = 1;
+
+	cap->shaper_shared_n_max = 0;
+	cap->shaper_shared_packet_mode_supported = 0;
+	cap->shaper_shared_byte_mode_supported = 0;
+
+	if (tm_node->level == adapter->tm_ctxt.tm_layers - 1) {
+		cap->leaf.cman_head_drop_supported = false;
+		cap->leaf.cman_wred_context_private_supported = false;
+		cap->leaf.cman_wred_context_shared_n_max = 0;
+	} else {
+		cap->nonleaf.sched_n_children_max = SXE2_TM_MAX_CHILDREN_COUNT;
+		cap->nonleaf.sched_sp_n_priorities_max = 7;
+		cap->nonleaf.sched_wfq_n_children_per_group_max = 0;
+		cap->nonleaf.sched_wfq_n_groups_max = 0;
+		cap->nonleaf.sched_wfq_weight_max = 0;
+		cap->nonleaf.sched_wfq_packet_mode_supported = 0;
+		cap->nonleaf.sched_wfq_byte_mode_supported = 0;
+	}
+	cap->stats_mask = 0;
+
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_shaper_profile_param_check(const struct rte_tm_shaper_params *profile,
+					      struct rte_tm_error *error)
+{
+	int32_t ret = 0;
+
+	if (profile->committed.size) {
+		PMD_LOG_ERR(DRV, "committed bucket size not supported.");
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE_COMMITTED_SIZE;
+		error->message = "committed bucket size not supported";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (profile->peak.size) {
+		PMD_LOG_ERR(DRV, "peak bucket size not supported.");
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PEAK_SIZE;
+		error->message = "peak bucket size not supported";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (profile->pkt_length_adjust) {
+		PMD_LOG_ERR(DRV, "packet length adjustment not supported.");
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PKT_ADJUST_LEN;
+		error->message = "packet length adjustment not supported";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (profile->committed.rate > SXE2_HW_RATE_MAX ||
+		profile->committed.rate < SXE2_HW_RATE_MIN) {
+		PMD_LOG_ERR(DRV, "The committed rate limit value is required to be in "
+			"the range [%" PRIu64 ", %" PRIu64 "].",
+			(uint64_t)SXE2_HW_RATE_MIN, (uint64_t)SXE2_HW_RATE_MAX);
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE_COMMITTED_RATE;
+		error->message = "invalid rate limit: value out of range.";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (profile->peak.rate > SXE2_HW_RATE_MAX ||
+		profile->peak.rate < SXE2_HW_RATE_MIN) {
+		PMD_LOG_ERR(DRV, "The peak rate limit value is required to be in "
+			"the range [%" PRIu64 ", %" PRIu64 "].",
+			(uint64_t)SXE2_HW_RATE_MIN, (uint64_t)SXE2_HW_RATE_MAX);
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PEAK_RATE;
+		error->message = "invalid rate limit: value out of range.";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (profile->committed.rate > profile->peak.rate) {
+		PMD_LOG_ERR(DRV, "committed rate can't be greater than peak rate.");
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE_COMMITTED_RATE;
+		error->message = "committed rate can't be greater than peak rate.";
+		ret = -EINVAL;
+		goto l_end;
+	}
+l_end:
+	return ret;
+}
+
+static inline struct sxe2_tm_shaper_profile *
+sxe2_tm_shaper_profile_search(struct rte_eth_dev *dev, uint32_t id)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_shaper_profile_list *shaper_profile_list =
+		&adapter->tm_ctxt.profile_list;
+	struct sxe2_tm_shaper_profile *shaper_profile = NULL;
+
+	TAILQ_FOREACH(shaper_profile, shaper_profile_list, node) {
+		if (id == shaper_profile->id)
+			goto l_end;
+	}
+
+	shaper_profile = NULL;
+
+l_end:
+	return shaper_profile;
+}
+
+static int32_t sxe2_tm_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
+				      const struct rte_tm_shaper_params *profile,
+				      struct rte_tm_error *error)
+{
+	int32_t ret = -EINVAL;
+	struct sxe2_tm_shaper_profile *shaper_profile = NULL;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (!profile || !error) {
+		PMD_LOG_ERR(DRV, "Invalid input: profile:0x%p or error:0x%p is null.",
+			profile, error);
+		if (error) {
+			error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+			error->message = "Invalid input: profile or error is null.";
+		}
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_end;
+	}
+
+	ret = sxe2_tm_shaper_profile_param_check(profile, error);
+	if (ret)
+		goto l_end;
+
+	shaper_profile = sxe2_tm_shaper_profile_search(dev, shaper_profile_id);
+	if (shaper_profile) {
+		PMD_LOG_ERR(DRV, "profile ID exist.");
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE_ID;
+		error->message = "profile ID exist";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	shaper_profile = rte_zmalloc("sxe2_tm_shaper_profile",
+							sizeof(struct sxe2_tm_shaper_profile), 0);
+	if (!shaper_profile) {
+		PMD_LOG_ERR(DRV, "Alloc shaper_profile memory failed.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "Alloc shaper_profile memory failed";
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	rte_memcpy(&shaper_profile->profile, profile,
+					sizeof(struct rte_tm_shaper_params));
+	shaper_profile->id = shaper_profile_id;
+
+	TAILQ_INSERT_TAIL(&adapter->tm_ctxt.profile_list, shaper_profile, node);
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_shaper_profile_del(struct rte_eth_dev *dev,
+		uint32_t id, struct rte_tm_error *error)
+{
+	int32_t ret = -EINVAL;
+	struct sxe2_tm_shaper_profile *shaper_profile = NULL;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	if (!error) {
+		PMD_LOG_ERR(DRV, "Error param is null.");
+		goto l_end;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_end;
+	}
+
+	shaper_profile = sxe2_tm_shaper_profile_search(dev, id);
+	if (!shaper_profile) {
+		PMD_LOG_ERR(DRV, "profile ID not exist.");
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE_ID;
+		error->message = "profile ID not exist";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (shaper_profile->ref_cnt) {
+		PMD_LOG_ERR(DRV, "profile in use.");
+		error->type = RTE_TM_ERROR_TYPE_SHAPER_PROFILE;
+		error->message = "profile in use";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	TAILQ_REMOVE(&adapter->tm_ctxt.profile_list, shaper_profile, node);
+	rte_free(shaper_profile);
+
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_node_param_check(struct rte_eth_dev *dev,
+			uint32_t parent_node_type,
+			uint32_t node_id, uint32_t priority, uint32_t weight,
+			const struct rte_tm_node_params *params,
+			bool is_leaf, struct rte_tm_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_tm_context *tm_ctxt = &adapter->tm_ctxt;
+	int32_t ret = -EINVAL;
+
+	if (node_id == RTE_TM_NODE_ID_NULL) {
+		PMD_LOG_ERR(DRV, "Invalid node id.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "invalid node id";
+		goto l_end;
+	}
+
+	if (parent_node_type == SXE2_TM_NODE_TYPE_VSIG &&
+			priority >= tm_ctxt->prio_max) {
+		PMD_LOG_ERR(DRV, "Priority should be less than %u.", tm_ctxt->prio_max);
+		error->type = RTE_TM_ERROR_TYPE_NODE_PRIORITY;
+		error->message = "The priority is too high.";
+		goto l_end;
+	}
+
+	if (priority > SXE2_TM_PRIO_MAX) {
+		PMD_LOG_ERR(DRV, "Priority should be less than %u.", SXE2_TM_PRIO_MAX);
+		error->type = RTE_TM_ERROR_TYPE_NODE_PRIORITY;
+		error->message = "The priority is too high.";
+		goto l_end;
+	}
+
+	if (weight > SXE2_TM_WEIGHT_MAX || weight < SXE2_TM_WEIGHT_MIN) {
+		PMD_LOG_ERR(DRV, "Weight must be between 1 and 200.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_WEIGHT;
+		error->message = "weight must be between 1 and 200";
+		goto l_end;
+	}
+
+	if (params->shared_shaper_id) {
+		PMD_LOG_ERR(DRV, "Shared shaper not supported.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_SHARED_SHAPER_ID;
+		error->message = "shared shaper not supported";
+		goto l_end;
+	}
+	if (params->n_shared_shapers) {
+		PMD_LOG_ERR(DRV, "Shared shaper not supported..");
+		error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_N_SHARED_SHAPERS;
+		error->message = "shared shaper not supported";
+		goto l_end;
+	}
+
+	if (!is_leaf) {
+		if (node_id <= dev->data->nb_tx_queues) {
+			PMD_LOG_ERR(DRV, "no leaf node id must bigger than queue id.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+			error->message = "no leaf node id must bigger than queue id.";
+			goto l_end;
+		}
+
+		if (params->nonleaf.wfq_weight_mode) {
+			PMD_LOG_ERR(DRV, "WFQ not supported.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
+			error->message = "WFQ not supported";
+			goto l_end;
+		}
+
+		if (params->nonleaf.n_sp_priorities != 1) {
+			PMD_LOG_ERR(DRV, "SP priority not supported.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_N_SP_PRIORITIES;
+			error->message = "SP priority not supported";
+			goto l_end;
+		}
+	} else {
+		if (node_id >= dev->data->nb_tx_queues) {
+			PMD_LOG_ERR(DRV, "leaf node id must be queue id.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+			error->message = "leaf node id must be queue id.";
+			goto l_end;
+		}
+
+		if (params->leaf.cman) {
+			PMD_LOG_ERR(DRV, "Congestion management not supported.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_CMAN;
+			error->message = "Congestion management not supported";
+			goto l_end;
+		}
+		if (params->leaf.wred.wred_profile_id != RTE_TM_WRED_PROFILE_ID_NONE) {
+			PMD_LOG_ERR(DRV, "WRED not supported.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_WRED_PROFILE_ID;
+			error->message = "WRED not supported";
+			goto l_end;
+		}
+		if (params->leaf.wred.shared_wred_context_id) {
+			PMD_LOG_ERR(DRV, "WRED not supported.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_SHARED_WRED_CONTEXT_ID;
+			error->message = "WRED not supported";
+			goto l_end;
+		}
+		if (params->leaf.wred.n_shared_wred_contexts) {
+			PMD_LOG_ERR(DRV, "WRED not supported.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_N_SHARED_WRED_CONTEXTS;
+			error->message = "WRED not supported";
+			goto l_end;
+		}
+	}
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_add_child(struct sxe2_tm_node *parent,
+		struct sxe2_tm_node *child)
+{
+	int32_t ret = -1;
+	uint32_t i;
+	for (i = 0; i < SXE2_TM_MAX_CHILDREN_COUNT; i++) {
+		if (parent->children[i] == NULL) {
+			parent->children[i] = child;
+			child->index_in_parent = i;
+			parent->child_cnt++;
+			ret = 0;
+			break;
+		}
+	}
+	return ret;
+}
+
+static int32_t sxe2_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id, uint32_t parent_node_id,
+			    uint32_t priority, uint32_t weight, uint32_t level_id,
+			    const struct rte_tm_node_params *params,
+			    struct rte_tm_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_tm_shaper_profile *shaper_profile = NULL;
+	struct sxe2_tm_context *tm_ctxt = &adapter->tm_ctxt;
+	struct sxe2_tm_node *tm_node = NULL;
+	struct sxe2_tm_node *parent_node = NULL;
+	int32_t ret = -EINVAL;
+	bool is_leaf;
+
+	if (!params || !error) {
+		PMD_LOG_ERR(DRV, "Invalid input: params:0x%p or error:0x%p is null.",
+			params, error);
+		if (error) {
+			error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+			error->message = "Invalid input: params or error is null.";
+		}
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_end;
+	}
+
+	shaper_profile = sxe2_tm_shaper_profile_search(dev, params->shaper_profile_id);
+	if (!shaper_profile) {
+		PMD_LOG_ERR(DRV, "Shaper profile does not exist.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS_SHAPER_PROFILE_ID;
+		error->message = "shaper profile does not exist";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (parent_node_id == RTE_TM_NODE_ID_NULL) {
+		if (level_id != 0) {
+			PMD_LOG_ERR(DRV, "Wrong level, root node (NULL parent) must be at level 0.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS;
+			error->message = "Wrong level, root node (NULL parent) must be at level 0";
+			ret = -EINVAL;
+			goto l_end;
+		}
+
+		if (tm_ctxt->root) {
+			PMD_LOG_ERR(DRV, "Already have a root.");
+			error->type = RTE_TM_ERROR_TYPE_NODE_PARENT_NODE_ID;
+			error->message = "already have a root";
+			ret = -EINVAL;
+			goto l_end;
+		}
+
+		ret = sxe2_tm_node_param_check(dev, SXE2_TM_NODE_TYPE_INVALID, node_id, priority,
+					       weight, params, false, error);
+		if (ret)
+			goto l_end;
+
+		tm_node = rte_zmalloc("tm_node_root", sizeof(struct sxe2_tm_node), 0);
+		if (!tm_node) {
+			PMD_LOG_ERR(DRV, "Alloc tm_node memory failed.");
+			error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+			error->message = "Alloc tm_node memory failed";
+			ret = -ENOMEM;
+			goto l_end;
+		}
+
+		tm_node->id = node_id;
+		tm_node->level = 0;
+		tm_node->parent = NULL;
+		tm_node->child_cnt = 0;
+		tm_node->weight = weight;
+		tm_node->hw_weight = SXE2_TM_WEIGHT_SUM;
+		tm_node->type = SXE2_TM_NODE_TYPE_VSIG;
+		tm_node->priority = priority;
+		tm_node->shaper_profile = shaper_profile;
+
+		tm_node->teid = tm_ctxt->root_teid;
+
+		shaper_profile->ref_cnt++;
+		tm_ctxt->root = tm_node;
+		ret = 0;
+		goto l_end;
+	}
+
+	parent_node = sxe2_tm_find_node(tm_ctxt->root, parent_node_id);
+	if (!parent_node) {
+		PMD_LOG_ERR(DRV, "Parent not exist.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_PARENT_NODE_ID;
+		error->message = "parent not exist";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (parent_node->child_cnt >= SXE2_TM_MAX_CHILDREN_COUNT ||
+		(parent_node->type == SXE2_TM_NODE_TYPE_VSIG &&
+		 parent_node->child_cnt >= tm_ctxt->root_max_children)) {
+		PMD_LOG_ERR(DRV, "Parent node is full.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS;
+		error->message = "parent node is full";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (level_id == RTE_TM_NODE_LEVEL_ID_ANY) {
+		level_id = parent_node->level + 1;
+	} else if (level_id != parent_node->level + 1) {
+		PMD_LOG_ERR(DRV, "Wrong level.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS;
+		error->message = "Wrong level";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (level_id >= tm_ctxt->tm_layers) {
+		PMD_LOG_ERR(DRV, "The maximum number of TM configuration levels is %d",
+				tm_ctxt->tm_layers);
+		error->type = RTE_TM_ERROR_TYPE_NODE_PARAMS;
+		error->message = "TM level exceeds supported hardware limit";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (level_id + 1 == tm_ctxt->tm_layers)
+		is_leaf = true;
+	else
+		is_leaf = false;
+
+	ret = sxe2_tm_node_param_check(dev, parent_node->type, node_id, priority, weight,
+				       params, is_leaf, error);
+	if (ret)
+		goto l_end;
+
+	if (sxe2_tm_find_node(tm_ctxt->root, node_id)) {
+		PMD_LOG_ERR(DRV, "Node id already used.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "node id already used";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	tm_node = rte_zmalloc("tm_node_no_root", sizeof(struct sxe2_tm_node), 0);
+	if (!tm_node) {
+		PMD_LOG_ERR(DRV, "Alloc tm_node memory failed.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "Alloc tm_node memory failed";
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	if (level_id + 1 != tm_ctxt->tm_layers)
+		tm_node->type = SXE2_TM_NODE_TYPE_MID;
+	else
+		tm_node->type = SXE2_TM_NODE_TYPE_QUEUE;
+	tm_node->id = node_id;
+	tm_node->level = level_id;
+	tm_node->parent = parent_node;
+	tm_node->child_cnt = 0;
+	tm_node->weight = weight;
+	tm_node->priority = priority;
+	tm_node->shaper_profile = shaper_profile;
+	shaper_profile->ref_cnt++;
+
+	ret = sxe2_tm_add_child(parent_node, tm_node);
+	if (ret) {
+		shaper_profile->ref_cnt--;
+		rte_free(tm_node);
+	}
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_tree_delete(struct sxe2_tm_node *tm_node)
+{
+	int32_t ret = 0;
+	uint32_t i, j;
+	struct sxe2_tm_node *parent = NULL;
+
+	if (!tm_node)
+		goto l_end;
+
+	parent = tm_node->parent;
+
+	if (tm_node->child_cnt != 0) {
+		for (i = SXE2_TM_MAX_CHILDREN_COUNT; i > 0; i--) {
+			if (tm_node->children[i - 1])
+				ret = sxe2_tm_tree_delete(tm_node->children[i - 1]);
+		}
+	}
+
+	if (tm_node->shaper_profile)
+		tm_node->shaper_profile->ref_cnt--;
+
+	if (tm_node->type != SXE2_TM_NODE_TYPE_VSIG && parent) {
+		for (i = 0; i < parent->child_cnt; i++) {
+			if (parent->children[i] == tm_node)
+				break;
+		}
+		for (j = i; j < parent->child_cnt - 1; j++)
+			parent->children[j] = parent->children[j + 1];
+
+		parent->children[parent->child_cnt - 1] = NULL;
+		parent->child_cnt--;
+	}
+	rte_free(tm_node);
+	tm_node = NULL;
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_node_delete(struct rte_eth_dev *dev, uint32_t node_id,
+		struct rte_tm_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_tm_context *tm_ctxt = &adapter->tm_ctxt;
+	struct sxe2_tm_node *tm_node = NULL;
+	int32_t ret = -EINVAL;
+
+	if (!error) {
+		PMD_LOG_ERR(DRV, "Invalid input: error is null.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_end;
+	}
+
+	if (node_id == RTE_TM_NODE_ID_NULL) {
+		PMD_LOG_ERR(DRV, "Invalid node id. node_id = %u", node_id);
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "invalid node id";
+		goto l_end;
+	}
+
+	tm_node = sxe2_tm_find_node(tm_ctxt->root, node_id);
+	if (!tm_node) {
+		PMD_LOG_ERR(DRV, "No such node.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "no such node";
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	ret = sxe2_tm_tree_delete(tm_node);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Delete node failed.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "Delete node failed";
+		goto l_end;
+	}
+
+	if (tm_node == tm_ctxt->root)
+		tm_ctxt->root = NULL;
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_node_type_get(struct rte_eth_dev *dev, uint32_t node_id,
+		int32_t *is_leaf, struct rte_tm_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_tm_context *tm_ctxt = &adapter->tm_ctxt;
+	struct sxe2_tm_node *tm_node = NULL;
+	int32_t ret = -EINVAL;
+
+	if (!is_leaf || !error) {
+		PMD_LOG_ERR(DRV, "Invalid input: is_leaf:0x%p or error:0x%p is null.",
+			is_leaf, error);
+		if (error) {
+			error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+			error->message = "Invalid input: is_leaf or error is null";
+		}
+		goto l_end;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_end;
+	}
+
+	if (node_id == RTE_TM_NODE_ID_NULL) {
+		PMD_LOG_ERR(DRV, "Invalid node id.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "invalid node id";
+		goto l_end;
+	}
+
+	tm_node = sxe2_tm_find_node(tm_ctxt->root, node_id);
+	if (!tm_node) {
+		PMD_LOG_ERR(DRV, "No such node.");
+		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+		error->message = "no such node";
+		goto l_end;
+	}
+
+	if (tm_node->level + 1 == tm_ctxt->tm_layers)
+		*is_leaf = true;
+	else
+		*is_leaf = false;
+	ret = 0;
+l_end:
+	return ret;
+}
+
+int32_t sxe2_tm_uninit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_tm_context *tm_ctxt = &adapter->tm_ctxt;
+	struct sxe2_tm_shaper_profile *shaper_profile = NULL;
+	int32_t ret = 0;
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		ret = 0;
+		goto l_end;
+	}
+
+	tm_ctxt->tm_layers = 0;
+	tm_ctxt->root_max_children = 0;
+	tm_ctxt->committed = false;
+
+	(void)sxe2_tm_tree_delete(tm_ctxt->root);
+
+	while ((shaper_profile = TAILQ_FIRST(&tm_ctxt->profile_list))) {
+		TAILQ_REMOVE(&tm_ctxt->profile_list, shaper_profile, node);
+		rte_free(shaper_profile);
+	}
+l_end:
+	return ret;
+}
+
+int32_t sxe2_tm_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_sched_hw_cap *sched_ctxt = &adapter->sched_ctxt;
+	struct sxe2_tm_context *tm_ctxt = &adapter->tm_ctxt;
+	int32_t ret = 0;
+	struct sxe2_tm_shaper_profile *shaper_profile = NULL;
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0)
+		goto l_end;
+
+	tm_ctxt->tm_layers = sched_ctxt->tm_layers;
+	tm_ctxt->root_max_children = sched_ctxt->root_max_children;
+	tm_ctxt->prio_max = sched_ctxt->prio_max;
+	tm_ctxt->committed = false;
+	TAILQ_INIT(&tm_ctxt->profile_list);
+	tm_ctxt->root = NULL;
+
+	shaper_profile = rte_zmalloc("sxe2_tm_shaper_profile",
+		sizeof(struct sxe2_tm_shaper_profile), 0);
+	if (!shaper_profile) {
+		PMD_LOG_ERR(DRV, "Alloc shaper_profile memory failed.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	shaper_profile->id = RTE_TM_SHAPER_PROFILE_ID_NONE;
+	shaper_profile->ref_cnt = 1;
+	shaper_profile->profile.committed.rate = UINT64_MAX;
+	shaper_profile->profile.peak.rate = UINT64_MAX;
+	TAILQ_INSERT_TAIL(&tm_ctxt->profile_list, shaper_profile, node);
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_chk_all_leaf(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+	uint32_t i = 0;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		if (!sxe2_tm_find_node(adapter->tm_ctxt.root, i)) {
+			ret = -1;
+			break;
+		}
+	}
+	return ret;
+}
+
+static int32_t sxe2_tm_weight_calc(struct sxe2_tm_node *tm_node)
+{
+	int32_t ret = 0;
+	int32_t total_weight = 0;
+	int32_t total_weight2 = 0;
+	uint32_t i = 0;
+	uint32_t j = 0;
+	uint32_t k = 0;
+	uint32_t maxindex = 0;
+	uint32_t maxweight = 0;
+	struct sxe2_tm_node *cacl_node[SXE2_TM_MAX_CHILDREN_COUNT] = {NULL};
+
+	if (!tm_node) {
+		PMD_LOG_ERR(DRV, "Invalid input: tm_node is null.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (tm_node->child_cnt == 0)
+		goto l_end;
+
+	for (j = SXE2_TM_PRIO_MIN; j <= SXE2_TM_PRIO_MAX; j++) {
+		k = 0;
+		total_weight = 0;
+		total_weight2 = 0;
+		maxindex = 0;
+		maxweight = 0;
+
+		for (i = 0; i < tm_node->child_cnt; i++) {
+			if (tm_node->children[i]->priority == j)
+				cacl_node[k++] = tm_node->children[i];
+		}
+		if (k == 0)
+			continue;
+
+		for (i = 0; i < k; i++)
+			total_weight += cacl_node[i]->weight;
+
+		for (i = 0; i < k; i++) {
+			cacl_node[i]->hw_weight = cacl_node[i]->weight *
+				SXE2_TM_WEIGHT_SUM / total_weight;
+			total_weight2 += cacl_node[i]->hw_weight;
+			if (cacl_node[i]->hw_weight > maxweight) {
+				maxweight = cacl_node[i]->hw_weight;
+				maxindex = i;
+			}
+		}
+
+		cacl_node[maxindex]->hw_weight += SXE2_TM_WEIGHT_SUM - total_weight2;
+	}
+
+	for (i = 0; i < tm_node->child_cnt; i++) {
+		ret = sxe2_tm_weight_calc(tm_node->children[i]);
+		if (ret)
+			goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_tm_hierarchy_commit(struct rte_eth_dev *dev,
+				     int32_t clear_on_fail, struct rte_tm_error *error)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = -EINVAL;
+
+	if (!error) {
+		PMD_LOG_ERR(DRV, "Invalid input: error is null.");
+		ret = -EINVAL;
+		goto l_clear_on_fail;
+	}
+
+	if ((adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_TM) == 0) {
+		PMD_LOG_ERR(DRV, "The TM capability is not supported.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The TM capability is not supported.";
+		ret = ENOTSUP;
+		goto l_clear_on_fail;
+	}
+
+	if (dev->data->dev_started) {
+		PMD_LOG_ERR(DRV, "Device failed to Stop.");
+		error->message = "Device failed to Stop";
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		ret = -EPERM;
+		goto l_clear_on_fail;
+	}
+
+	ret = sxe2_tm_chk_all_leaf(dev);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "All tx queues need config.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "All tx queues need config.";
+		goto l_clear_on_fail;
+	}
+
+	ret = sxe2_tm_weight_calc(adapter->tm_ctxt.root);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "The weight in tree is wrong.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "The weight in tree is wrong.";
+		goto l_clear_on_fail;
+	}
+
+	ret = sxe2_drv_tm_commit(adapter);
+	if (ret) {
+		PMD_LOG_ERR(DRV, "Commit tree to fw failed.");
+		error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+		error->message = "Commit tree to fw failed.";
+		goto l_clear_on_fail;
+	}
+
+	adapter->tm_ctxt.committed = true;
+	ret = 0;
+	goto l_end;
+
+l_clear_on_fail:
+	if (clear_on_fail) {
+		(void)sxe2_tm_uninit(dev);
+		(void)sxe2_tm_init(dev);
+	}
+
+l_end:
+	return ret;
+}
+
+static const struct rte_tm_ops sxe2_tm_ops = {
+	.capabilities_get = sxe2_tm_capabilities_get,
+	.level_capabilities_get = sxe2_level_capabilities_get,
+	.node_capabilities_get = sxe2_node_capabilities_get,
+	.shaper_profile_add = sxe2_tm_shaper_profile_add,
+	.shaper_profile_delete = sxe2_tm_shaper_profile_del,
+	.node_add = sxe2_tm_node_add,
+	.node_delete = sxe2_tm_node_delete,
+	.node_type_get = sxe2_tm_node_type_get,
+
+	.hierarchy_commit = sxe2_tm_hierarchy_commit,
+};
+
+int32_t sxe2_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg)
+{
+	int32_t ret = 0;
+
+	if (!arg) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "%s failed because arg is NULL", __func__);
+		goto l_end;
+	}
+	*(const void **)arg = &sxe2_tm_ops;
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_tm.h b/drivers/net/sxe2/sxe2_tm.h
new file mode 100644
index 0000000000..c4f8da6a8e
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_tm.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_TM_H__
+#define __SXE2_TM_H__
+#include <ethdev_driver.h>
+#include <rte_flow_driver.h>
+#include "sxe2_osal.h"
+
+#define SXE2_TM_MAX_LEVEL 7
+#define SXE2_TM_1L_NODE_NUM_MAX 1
+#define SXE2_TM_2L_NODE_NUM_MAX 8
+#define SXE2_TM_3L_NODE_NUM_MAX 64
+#define SXE2_TM_4L_NODE_NUM_MAX 256
+
+#define SXE2_TM_MAX_CHILDREN_COUNT 8
+
+#define SXE2_TM_WEIGHT_MAX  (200)
+#define SXE2_TM_WEIGHT_MIN  (1)
+#define SXE2_TM_WEIGHT_SUM  (32768)
+
+#define SXE2_HW_RATE_MIN 62500ull
+#define SXE2_HW_RATE_MAX 12500000000ull
+
+#define SXE2_TM_PRIO_MAX (7)
+#define SXE2_TM_PRIO_MIN (0)
+
+enum sxe2_tm_node_type {
+	SXE2_TM_NODE_TYPE_VSIG = 0,
+	SXE2_TM_NODE_TYPE_MID,
+	SXE2_TM_NODE_TYPE_QUEUE,
+	SXE2_TM_NODE_TYPE_INVALID,
+};
+
+struct sxe2_tm_shaper_profile {
+	TAILQ_ENTRY(sxe2_tm_shaper_profile) node;
+	uint32_t id;
+	uint32_t ref_cnt;
+	struct rte_tm_shaper_params profile;
+};
+
+TAILQ_HEAD(sxe2_shaper_profile_list, sxe2_tm_shaper_profile);
+
+struct sxe2_tm_node {
+	uint16_t id;
+	uint16_t teid;
+	uint32_t level;
+	uint32_t child_cnt;
+	uint32_t type;
+	uint16_t hw_weight;
+	uint16_t weight;
+	uint8_t priority;
+	struct sxe2_tm_node *parent;
+	uint8_t index_in_parent;
+	struct sxe2_tm_node *children[SXE2_TM_MAX_CHILDREN_COUNT];
+	struct sxe2_tm_shaper_profile *shaper_profile;
+};
+
+struct sxe2_tm_context {
+	uint32_t tm_layers;
+	uint16_t root_teid;
+	uint8_t root_max_children;
+	uint8_t prio_max;
+	bool committed;
+	struct sxe2_tm_node *root;
+	struct sxe2_shaper_profile_list profile_list;
+};
+
+int32_t sxe2_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg);
+
+int32_t sxe2_tm_init(struct rte_eth_dev *dev);
+
+int32_t sxe2_tm_uninit(struct rte_eth_dev *dev);
+
+#endif /* __SXE2_TM_H__ */
diff --git a/drivers/net/sxe2/sxe2_tx.c b/drivers/net/sxe2/sxe2_tx.c
index a05beb8c7a..a280edc9c5 100644
--- a/drivers/net/sxe2/sxe2_tx.c
+++ b/drivers/net/sxe2/sxe2_tx.c
@@ -304,7 +304,6 @@ int32_t __rte_cold sxe2_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	offloads = tx_conf->offloads | dev->data->dev_conf.txmode.offloads;
-
 	txq = sxe2_tx_queue_alloc(dev, queue_idx, nb_desc, socket_id);
 	if (txq == NULL) {
 		PMD_LOG_ERR(TX, "failed to alloc sxe2vf tx queue:%u resource", queue_idx);
-- 
2.47.3

