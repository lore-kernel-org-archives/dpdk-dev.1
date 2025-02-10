Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB3CC0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 07:29:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7177C410FB;
	Mon, 10 Feb 2025 08:27:43 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id F2B7E40EA5
 for <dev@dpdk.org>; Mon, 10 Feb 2025 08:27:34 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id E9176A3EE3; Mon, 10 Feb 2025 15:27:10 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v8 13/28] net/rnp: add support link setup operations
Date: Mon, 10 Feb 2025 15:26:40 +0800
Message-Id: <1739172415-48507-14-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
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

add set link_down/link_up implement

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/base/rnp_eth_regs.h |  3 +
 drivers/net/rnp/base/rnp_fw_cmd.c   | 22 +++++++
 drivers/net/rnp/base/rnp_fw_cmd.h   |  6 ++
 drivers/net/rnp/base/rnp_mbx_fw.c   | 33 ++++++++++
 drivers/net/rnp/base/rnp_mbx_fw.h   |  1 +
 drivers/net/rnp/rnp_ethdev.c        |  4 ++
 drivers/net/rnp/rnp_link.c          | 99 +++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_link.h          |  2 +
 8 files changed, 170 insertions(+)

diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index be7ed5b886..c74886e70c 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -5,6 +5,9 @@
 #ifndef _RNP_ETH_REGS_H
 #define _RNP_ETH_REGS_H
 
+#define RNP_ETH_TX_FIFO_STATE		_ETH_(0x0330)
+#define RNP_ETH_TX_FIFO_EMPT(lane)	((1 << (lane)) | (1 << ((lane) + 4)))
+
 #define RNP_E_ENG_BYPASS	_ETH_(0x8000)
 #define RNP_E_VXLAN_PARSE_EN	_ETH_(0x8004)
 #define RNP_E_FILTER_EN		_ETH_(0x801c)
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.c b/drivers/net/rnp/base/rnp_fw_cmd.c
index c5ae7b954c..17d3bb2761 100644
--- a/drivers/net/rnp/base/rnp_fw_cmd.c
+++ b/drivers/net/rnp/base/rnp_fw_cmd.c
@@ -107,6 +107,25 @@ rnp_build_lane_evet_mask(struct rnp_mbx_fw_cmd_req *req,
 	arg->event_en = req_arg->param2;
 }
 
+static void
+rnp_build_ifup_down(struct rnp_mbx_fw_cmd_req *req,
+		    struct rnp_fw_req_arg *req_arg,
+		    void *cookie)
+{
+	struct rnp_ifup_down_req *arg =
+		(struct rnp_ifup_down_req *)req->data;
+
+	req->flags = 0;
+	req->opcode = RNP_IFUP_DOWN;
+	req->datalen = sizeof(*arg);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+
+	arg->nr_lane = req_arg->param0;
+	arg->up = req_arg->param1;
+}
+
 int rnp_build_fwcmd_req(struct rnp_mbx_fw_cmd_req *req,
 			struct rnp_fw_req_arg *arg,
 			void *cookie)
@@ -132,6 +151,9 @@ int rnp_build_fwcmd_req(struct rnp_mbx_fw_cmd_req *req,
 	case RNP_SET_LANE_EVENT_EN:
 		rnp_build_lane_evet_mask(req, arg, cookie);
 		break;
+	case RNP_IFUP_DOWN:
+		rnp_build_ifup_down(req, arg, cookie);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 	}
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.h b/drivers/net/rnp/base/rnp_fw_cmd.h
index 6734834644..4d73b1e018 100644
--- a/drivers/net/rnp/base/rnp_fw_cmd.h
+++ b/drivers/net/rnp/base/rnp_fw_cmd.h
@@ -310,6 +310,12 @@ struct rnp_link_stat_req {
 	struct rnp_port_stat states[RNP_MAX_PORT_OF_PF];
 };
 
+struct rnp_ifup_down_req {
+	u32 nr_lane;
+	u32 up;
+	u8 rsvd[24];
+};
+
 struct rnp_mbx_fw_cmd_req {
 	u16 flags;
 	u16 opcode;
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
index b968c50a5f..41b7d0df8b 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.c
+++ b/drivers/net/rnp/base/rnp_mbx_fw.c
@@ -464,3 +464,36 @@ rnp_rcv_msg_from_fw(struct rnp_eth_adapter *adapter, u32 *msgbuf)
 
 	return 0;
 }
+
+static void rnp_link_stat_reset(struct rnp_hw *hw, u16 lane)
+{
+	u32 state;
+
+	spin_lock(&hw->link_sync);
+	state = RNP_E_REG_RD(hw, RNP_FW_LINK_SYNC);
+	state &= ~RNP_LINK_MAGIC_MASK;
+	state |= RNP_LINK_MAGIC_CODE;
+	state &= ~RTE_BIT32(lane);
+
+	RNP_E_REG_WR(hw, RNP_FW_LINK_SYNC, state);
+	rte_spinlock_unlock(&hw->link_sync);
+}
+
+int rnp_mbx_fw_ifup_down(struct rnp_eth_port *port, bool up)
+{
+	u16 nr_lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_fw_req_arg arg;
+	int err;
+
+	memset(&arg, 0, sizeof(arg));
+	arg.opcode = RNP_IFUP_DOWN;
+	arg.param0 = nr_lane;
+	arg.param1 = up;
+
+	err = rnp_fw_send_norep_cmd(port, &arg);
+	/* force firmware send irq event to dpdk */
+	if (!err && up)
+		rnp_link_stat_reset(hw, nr_lane);
+	return err;
+}
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.h b/drivers/net/rnp/base/rnp_mbx_fw.h
index 159a0237be..397d2ec8c4 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.h
+++ b/drivers/net/rnp/base/rnp_mbx_fw.h
@@ -19,5 +19,6 @@ int rnp_fw_init(struct rnp_hw *hw);
 int rnp_rcv_msg_from_fw(struct rnp_eth_adapter *adapter, u32 *msgbuf);
 int rnp_fw_mbx_ifup_down(struct rnp_eth_port *port, int up);
 int rnp_mbx_fw_lane_link_event_en(struct rnp_eth_port *port, bool en);
+int rnp_mbx_fw_ifup_down(struct rnp_eth_port *port, bool up);
 
 #endif /* _RNP_MBX_FW_H_ */
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index dbedb150c1..e122ccc006 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -327,6 +327,7 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 	rnp_mbx_fw_lane_link_event_en(port, lsc);
 	if (!lsc)
 		rnp_run_link_poll_task(port);
+	rnp_dev_set_link_up(eth_dev);
 	/* enable eth rx flow */
 	RNP_RX_ETH_ENABLE(hw, lane);
 	port->port_stopped = 0;
@@ -412,6 +413,7 @@ static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 	/* clear the recorded link status */
 	memset(&link, 0, sizeof(link));
 	rte_eth_linkstatus_set(eth_dev, &link);
+	rnp_dev_set_link_down(eth_dev);
 	rnp_disable_all_tx_queue(eth_dev);
 	rnp_disable_all_rx_queue(eth_dev);
 	rnp_mac_tx_disable(eth_dev);
@@ -639,6 +641,8 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.rss_hash_conf_get            = rnp_dev_rss_hash_conf_get,
 	/* link impl */
 	.link_update                  = rnp_dev_link_update,
+	.dev_set_link_up              = rnp_dev_set_link_up,
+	.dev_set_link_down            = rnp_dev_set_link_down,
 };
 
 static void
diff --git a/drivers/net/rnp/rnp_link.c b/drivers/net/rnp/rnp_link.c
index 4d1b07c132..1aaef3df84 100644
--- a/drivers/net/rnp/rnp_link.c
+++ b/drivers/net/rnp/rnp_link.c
@@ -338,3 +338,102 @@ rnp_cancel_link_poll_task(struct rnp_eth_port *port)
 {
 	rte_eal_alarm_cancel(rnp_dev_link_task, port->eth_dev);
 }
+
+int rnp_dev_set_link_up(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	uint16_t nr_lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	uint16_t timeout;
+	uint16_t index;
+	uint32_t state;
+	uint16_t idx;
+	int ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (port->attr.link_ready)
+		return 0;
+	/* Cur link-state Is Down Verity The Rx Dma Queue State Is Empty */
+	if (!port->attr.link_ready) {
+		for (idx = 0; idx < eth_dev->data->nb_rx_queues; idx++) {
+			rxq = eth_dev->data->rx_queues[idx];
+			if (!rxq)
+				continue;
+			index = rxq->attr.index;
+			timeout = 0;
+			do {
+				if (!RNP_E_REG_RD(hw, RNP_RXQ_READY(index)))
+					break;
+				rte_delay_us(10);
+				timeout++;
+			} while (timeout < 1000);
+		}
+	}
+	ret = rnp_mbx_fw_ifup_down(port, TRUE);
+	if (ret) {
+		RNP_PMD_WARN("port[%d] is set linkup failed",
+				eth_dev->data->port_id);
+		return ret;
+	}
+	timeout = 0;
+	do {
+		rte_io_rmb();
+		state = RNP_E_REG_RD(hw, RNP_FW_LINK_SYNC);
+		if (state & RTE_BIT32(nr_lane))
+			break;
+		timeout++;
+		rte_delay_us(10);
+	} while (timeout < 100);
+
+	return ret;
+}
+
+int rnp_dev_set_link_down(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	uint16_t nr_lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_tx_queue *txq;
+	uint32_t timeout = 0;
+	uint32_t check_v;
+	uint32_t state;
+	uint16_t idx;
+
+	PMD_INIT_FUNC_TRACE();
+	RNP_RX_ETH_DISABLE(hw, nr_lane);
+	for (idx = 0; idx < eth_dev->data->nb_tx_queues; idx++) {
+		txq = eth_dev->data->tx_queues[idx];
+		if (!txq)
+			continue;
+		txq->tx_link = false;
+	}
+	/* 2 Check eth tx fifo empty state */
+	do {
+		state = RNP_E_REG_RD(hw, RNP_ETH_TX_FIFO_STATE);
+		check_v = RNP_ETH_TX_FIFO_EMPT(nr_lane);
+		state &= check_v;
+		if (state == check_v)
+			break;
+		rte_delay_us(10);
+		timeout++;
+		if (timeout >= 1000) {
+			RNP_PMD_WARN("lane[%d] isn't empty of link-down action",
+					nr_lane);
+			break;
+		}
+	} while (1);
+	/* 3 Tell Firmware Do Link-down Event Work */
+	rnp_mbx_fw_ifup_down(port, FALSE);
+	/* 4 Wait For Link-Down that Firmware Do done */
+	timeout = 0;
+	do {
+		if (!port->attr.link_ready)
+			break;
+		rte_delay_us(10);
+		timeout++;
+	} while (timeout < 2000);
+
+	return 0;
+}
diff --git a/drivers/net/rnp/rnp_link.h b/drivers/net/rnp/rnp_link.h
index 8c2a3cbd59..6f55049b1e 100644
--- a/drivers/net/rnp/rnp_link.h
+++ b/drivers/net/rnp/rnp_link.h
@@ -32,5 +32,7 @@ int rnp_dev_link_update(struct rte_eth_dev *eth_dev,
 			int wait_to_complete);
 void rnp_run_link_poll_task(struct rnp_eth_port *port);
 void rnp_cancel_link_poll_task(struct rnp_eth_port *port);
+int rnp_dev_set_link_up(struct rte_eth_dev *eth_dev);
+int rnp_dev_set_link_down(struct rte_eth_dev *eth_dev);
 
 #endif /* _RNP_LINK_H_ */
-- 
2.34.1

