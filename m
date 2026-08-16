Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B8DC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 02:52:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94D664064A;
	Sun, 16 Aug 2026 04:52:47 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE2E40144
 for <dev@dpdk.org>; Sun, 16 Aug 2026 04:52:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAAn+u32JYFqrYDQBQ--.14967S3;
 Sun, 16 Aug 2026 10:52:40 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v2 01/13] net/sxe2: add Rx queue buffer split fill support
Date: Sun, 16 Aug 2026 10:52:21 +0800
Message-ID: <20260816025233.2727226-2-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
References: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAn+u32JYFqrYDQBQ--.14967S3
X-Coremail-Antispam: 1UD129KBjvJXoWfJryfZF47Ww1ftw4fuw17Wrg_yoWDCF45pF
 1UWF13tayIqrs29F45Jr4Fq3W7KrWrGayj9an3Gw1rKF1vqF9YyF4jyr1ftan5Ca1DXw4r
 tanxWF4kKr18JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
 ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr1le2I2
 62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
 AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
 0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMxAIw28Icx
 kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
 CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUO89NUUUUU
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

Implement sxe2_rxq_buf_split_fill function to configure Rx queue
buffer split offload. The function validates and sets split
parameters based on protocol header type.

Supports following split types:
- L2: Ether
- L3: IPv4, IPv6
- L4: TCP, UDP, SCTP
- Tunnel: GRE/NAT
- Inner L2/L3/L4 for tunneled packets

Sets split_type_mask and header_len (256 bytes) for hardware
buffer split configuration. Returns error if protocol header
is not configured or unsupported.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 142 ++++++++++++++++++++++++++++---
 1 file changed, 128 insertions(+), 14 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index b09989fe50..9ed5559eff 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -26,10 +26,9 @@ static void sxe2_drv_trace_id_alloc(uint64_t *trace_id)
 }
 
 static void __sxe2_drv_cmd_params_fill(struct sxe2_adapter *adapter,
-		struct sxe2_drv_cmd_params *cmd, uint32_t opc, const char *opc_str,
+		struct sxe2_drv_cmd_params *cmd, uint32_t opc,
 		void *in_data, uint32_t in_len, void *out_data, uint32_t out_len)
 {
-	PMD_DEV_LOG_DEBUG(adapter, DRV, "cmd opcode:%s", opc_str);
 	cmd->timeout = SXE2_DRV_CMD_DFLT_TIMEOUT;
 	cmd->opcode  = opc;
 	cmd->vsi_id  = adapter->vsi_ctxt.dpdk_vsi_id;
@@ -44,7 +43,7 @@ static void __sxe2_drv_cmd_params_fill(struct sxe2_adapter *adapter,
 }
 
 #define sxe2_drv_cmd_params_fill(adapter, cmd, opc, in_data, in_len, out_data, out_len) \
-	__sxe2_drv_cmd_params_fill(adapter, cmd, opc, #opc, in_data, in_len, out_data, out_len)
+	__sxe2_drv_cmd_params_fill(adapter, cmd, opc, in_data, in_len, out_data, out_len)
 
 
 int32_t sxe2_drv_dev_caps_get(struct sxe2_adapter *adapter, struct sxe2_drv_dev_caps_resp *dev_caps)
@@ -193,6 +192,102 @@ int32_t sxe2_drv_vsi_del(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi)
 #define SXE2_RXQ_CTXT_CFG_BUF_LEN_ALIGN  (1 << 7)
 #define SXE2_RX_HDR_SIZE 256
 
+static int32_t sxe2_rxq_buf_split_fill(struct sxe2_rx_queue *rxq,
+				   struct sxe2_drv_rxq_ctxt *ctxt)
+{
+	int32_t ret = 0;
+	uint32_t proto_hdr;
+
+	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) {
+		proto_hdr = rxq->rx_seg[0].proto_hdr;
+		if (proto_hdr == RTE_PTYPE_UNKNOWN) {
+			PMD_LOG_ERR(RX, "Buffer split protocol must be configured");
+			ret = -1;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_L4_MASK) {
+		case RTE_PTYPE_L4_TCP:
+			ctxt->split_type_mask = SXE2_PTYPE_L4_TCP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_L4_UDP:
+			ctxt->split_type_mask = SXE2_PTYPE_L4_UDP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_L4_SCTP:
+			ctxt->split_type_mask = SXE2_PTYPE_L4_SCTP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_L3_MASK) {
+		case RTE_PTYPE_L3_IPV4_EXT_UNKNOWN:
+			ctxt->split_type_mask = SXE2_PTYPE_L3_IPV4;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_L3_IPV6_EXT_UNKNOWN:
+			ctxt->split_type_mask = SXE2_PTYPE_L3_IPV6;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_L2_MASK) {
+		case RTE_PTYPE_L2_ETHER:
+			ctxt->split_type_mask = SXE2_PTYPE_L2_ETHER;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_INNER_L4_MASK) {
+		case RTE_PTYPE_INNER_L4_TCP:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_TCP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_INNER_L4_UDP:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_UDP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_INNER_L4_SCTP:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L4_SCTP;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_INNER_L3_MASK) {
+		case RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV4;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		case RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L3_IPV6;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_INNER_L2_MASK) {
+		case RTE_PTYPE_INNER_L2_ETHER:
+			ctxt->split_type_mask = SXE2_PTYPE_INNER_L2_ETHER;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+
+		switch (proto_hdr & RTE_PTYPE_TUNNEL_MASK) {
+		case RTE_PTYPE_TUNNEL_GRENAT:
+			ctxt->split_type_mask = SXE2_PTYPE_TUNNEL_GRENAT;
+			ctxt->hdr_len = SXE2_RX_HDR_SIZE;
+			goto l_end;
+		}
+		PMD_LOG_ERR(RX, "Buffer split protocol is not supported");
+		ret = -1;
+	} else {
+		ctxt->hdr_len = 0;
+		ctxt->split_type_mask = 0;
+	}
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
 		struct sxe2_drv_rxq_cfg_req *req, uint16_t rxq_cnt)
 {
@@ -226,7 +321,17 @@ static int32_t sxe2_rxq_ctxt_cfg_fill(struct sxe2_rx_queue *rxq,
 	else
 		ctxt->keep_crc_en = 0;
 
+	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) {
+		ret = sxe2_rxq_buf_split_fill(rxq, ctxt);
+		if (ret)
+			goto l_end;
+		ctxt->split_en = 1;
+	} else {
+		ctxt->split_en = 0;
+	}
+
 	ctxt->desc_size = sizeof(union sxe2_rx_desc);
+l_end:
 	return ret;
 }
 
@@ -391,7 +496,7 @@ int32_t sxe2_drv_vsi_info_get(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi
 			&vsi_info_get_resp, sizeof(vsi_info_get_resp));
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret) {
-		PMD_DEV_LOG_ERR(adapter, DRV, "switchdev cpvsi info get failed, ret=%d", ret);
+		PMD_DEV_LOG_ERR(adapter, DRV, "vsi %u info get failed, ret=%d", vsi->vsi_id, ret);
 		goto l_end;
 	}
 
@@ -412,6 +517,7 @@ int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
 {
 	int32_t ret = 0;
 	struct sxe2_common_device *cdev = adapter->cdev;
+	struct rte_eth_dev *dev = &rte_eth_devices[adapter->dev_info.dev_data->port_id];
 	struct sxe2_drv_cmd_params param = {0};
 	struct sxe2_drv_link_info_resp resp = {0};
 
@@ -425,6 +531,7 @@ int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
 	}
 	adapter->link_ctxt.speed = resp.speed;
 	adapter->link_ctxt.link_up = resp.status;
+	(void)sxe2_link_update(dev, 0);
 
 l_end:
 	return ret;
@@ -447,7 +554,7 @@ int32_t sxe2_drv_rxq_bind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx, ui
 				 NULL, 0);
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_DEV_LOG_ERR(adapter, DRV, "rxq bind irq failed, ret=%d", ret);
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq %u bind irq failed, ret=%d", rxq_idx, ret);
 
 	return ret;
 }
@@ -467,7 +574,7 @@ int32_t sxe2_drv_rxq_unbind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx)
 				 NULL, 0);
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_DEV_LOG_ERR(adapter, DRV, "rxq unbind irq failed, ret=%d", ret);
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq %u unbind irq failed, ret=%d", rxq_idx, ret);
 
 	return ret;
 }
@@ -668,7 +775,7 @@ int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set)
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_DEV_LOG_WARN(adapter, DRV, "promic config failed, ret=%d", ret);
+		PMD_DEV_LOG_WARN(adapter, DRV, "promisc config failed, ret=%d", ret);
 
 	return ret;
 }
@@ -1532,7 +1639,7 @@ int32_t sxe2_drv_get_udp_tunnel_port(struct sxe2_adapter *adapter,
 		[SXE2_FLOW_UDP_TUNNEL_PROTOCOL_GTP_U] = SXE2_UDP_TUNNEL_PROTOCOL_GTP_U,
 		[SXE2_FLOW_UDP_TUNNEL_PROTOCOL_NVGRE] = SXE2_UDP_TUNNEL_PROTOCOL_NVGRE,
 	};
-	struct sxe2_udp_tunnel_cfg tunnel_config = {};
+	struct sxe2_udp_tunnel_cfg tunnel_config = {0};
 
 	tunnel_config.protocol = flow_proto_to_udp_tunnel_proto[proto];
 	ret = sxe2_drv_udp_tunnel_get(adapter, &tunnel_config);
@@ -1560,8 +1667,10 @@ int32_t sxe2_drv_udp_tunnel_get(struct sxe2_adapter *adapter,
 				 &req, sizeof(req),
 				 &resp, sizeof(resp));
 	ret = sxe2_drv_cmd_exec(cdev, &cmd);
-	if (ret)
+	if (ret) {
 		PMD_LOG_ERR(DRV, "Failed to get udp proto %d port, ret=%d", req.type, ret);
+		goto l_end;
+	}
 
 	tunnel_config->fw_port   = resp.port;
 	tunnel_config->fw_status = resp.enable;
@@ -1569,6 +1678,7 @@ int32_t sxe2_drv_udp_tunnel_get(struct sxe2_adapter *adapter,
 	tunnel_config->fw_src_en = resp.src;
 	tunnel_config->fw_used   = resp.fw_used;
 
+l_end:
 	return ret;
 }
 
@@ -1591,7 +1701,7 @@ int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter, struct eth_
 				 &resp, sizeof(resp));
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret) {
-		PMD_LOG_ERR(DRV, "get queue info map failed, ret=%d", ret);
+		PMD_LOG_ERR(DRV, "rx queue mapping failed, ret=%d", ret);
 		goto l_end;
 	}
 
@@ -1635,7 +1745,7 @@ int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id,
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_LOG_ERR(DRV, "get dev caps failed, ret=%d", ret);
+		PMD_LOG_ERR(DRV, "rx queue mapping failed, ret=%d", ret);
 
 l_end:
 	return ret;
@@ -1652,7 +1762,7 @@ int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id,
 
 	txq = eth_dev->data->tx_queues[queue_id];
 	if (txq == NULL) {
-		PMD_LOG_ERR(DRV, "Rx queue %u is not available or setup", queue_id);
+		PMD_LOG_ERR(DRV, "Tx queue %u is not available or setup", queue_id);
 		ret = -EINVAL;
 		goto l_end;
 	}
@@ -1666,7 +1776,7 @@ int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id,
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_LOG_ERR(DRV, "get dev caps failed, ret=%d", ret);
+		PMD_LOG_ERR(DRV, "tx queue mapping failed, ret=%d", ret);
 
 l_end:
 	return ret;
@@ -1726,10 +1836,14 @@ int32_t sxe2_drv_flow_filter_add(struct sxe2_adapter *adapter, struct sxe2_flow
 	sxe2_drv_cmd_params_fill(adapter, &cmd, SXE2_DRV_CMD_FLOW_FILTER_ADD, &req,
 			   sizeof(req), &resp, sizeof(resp));
 	ret = sxe2_drv_cmd_exec(cdev, &cmd);
-	if (ret)
+	if (ret) {
 		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to add flow filter, ret: %d.", ret);
+		flow->create_err = ret;
+		goto l_end;
+	}
 	flow->flow_id = resp.flow_id;
 	flow->create_err = ret;
+l_end:
 	return ret;
 }
 
-- 
2.52.0

