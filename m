Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2AAC021A2
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 258B840676;
	Tue, 11 Feb 2025 09:51:02 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 365CC4064E
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:50:56 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 6BE0BA3A65; Tue, 11 Feb 2025 16:50:32 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net, Wenbo Cao <caowenbo@mucse.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v9 09/28] net/rnp: add queue stop and start operations
Date: Tue, 11 Feb 2025 16:49:59 +0800
Message-Id: <1739263818-59770-10-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
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

support rx/tx queue stop/start,for rx queue stop
need to reset a queue,must stop all rx queue
during reset this queue.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini  |   1 +
 drivers/net/rnp/base/rnp_common.c |   3 +
 drivers/net/rnp/rnp_link.c        | 340 ++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_link.h        |  36 ++++
 drivers/net/rnp/rnp_rxtx.c        | 167 +++++++++++++++
 drivers/net/rnp/rnp_rxtx.h        |   9 +
 6 files changed, 556 insertions(+)
 create mode 100644 drivers/net/rnp/rnp_link.c
 create mode 100644 drivers/net/rnp/rnp_link.h

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 65f1ed3da0..fd7d4b9d8d 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Speed capabilities   = Y
+Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Linux                = Y
diff --git a/drivers/net/rnp/base/rnp_common.c b/drivers/net/rnp/base/rnp_common.c
index 5655126ae0..58de3bde03 100644
--- a/drivers/net/rnp/base/rnp_common.c
+++ b/drivers/net/rnp/base/rnp_common.c
@@ -65,6 +65,9 @@ int rnp_init_hw(struct rnp_hw *hw)
 	/* setup mac resiger ctrl base */
 	for (idx = 0; idx < hw->max_port_num; idx++)
 		hw->mac_base[idx] = (u8 *)hw->e_ctrl + RNP_MAC_BASE_OFFSET(idx);
+	/* tx all hw queue must be started */
+	for (idx = 0; idx < RNP_MAX_RX_QUEUE_NUM; idx++)
+		RNP_E_REG_WR(hw, RNP_TXQ_START(idx), true);
 
 	return 0;
 }
diff --git a/drivers/net/rnp/rnp_link.c b/drivers/net/rnp/rnp_link.c
new file mode 100644
index 0000000000..4d1b07c132
--- /dev/null
+++ b/drivers/net/rnp/rnp_link.c
@@ -0,0 +1,340 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include <rte_alarm.h>
+
+#include "base/rnp_mac_regs.h"
+#include "base/rnp_dma_regs.h"
+#include "base/rnp_mac.h"
+#include "base/rnp_fw_cmd.h"
+#include "base/rnp_mbx_fw.h"
+
+#include "rnp.h"
+#include "rnp_rxtx.h"
+#include "rnp_link.h"
+
+static void
+rnp_link_flow_setup(struct rnp_eth_port *port)
+{
+	struct rnp_hw *hw = port->hw;
+	u32 ctrl = 0;
+	u16 lane = 0;
+
+	lane = port->attr.nr_lane;
+	rte_spinlock_lock(&port->rx_mac_lock);
+	ctrl = RNP_MAC_REG_RD(hw, lane, RNP_MAC_RX_CFG);
+	if (port->attr.link_ready) {
+		ctrl &= ~RNP_MAC_LM;
+		RNP_RX_ETH_ENABLE(hw, lane);
+	} else {
+		RNP_RX_ETH_DISABLE(hw, lane);
+		ctrl |= RNP_MAC_LM;
+	}
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_RX_CFG, ctrl);
+	rte_spinlock_unlock(&port->rx_mac_lock);
+}
+
+static uint64_t
+rnp_parse_speed_code(uint32_t speed_code)
+{
+	uint32_t speed = 0;
+
+	switch (speed_code) {
+	case RNP_LANE_SPEED_10M:
+		speed = RTE_ETH_SPEED_NUM_10M;
+		break;
+	case RNP_LANE_SPEED_100M:
+		speed = RTE_ETH_SPEED_NUM_100M;
+		break;
+	case RNP_LANE_SPEED_1G:
+		speed = RTE_ETH_SPEED_NUM_1G;
+		break;
+	case RNP_LANE_SPEED_10G:
+		speed = RTE_ETH_SPEED_NUM_10G;
+		break;
+	case RNP_LANE_SPEED_25G:
+		speed = RTE_ETH_SPEED_NUM_25G;
+		break;
+	case RNP_LANE_SPEED_40G:
+		speed = RTE_ETH_SPEED_NUM_40G;
+		break;
+	default:
+		speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+	}
+
+	return speed;
+}
+
+static bool
+rnp_update_speed_changed(struct rnp_eth_port *port)
+{
+	struct rnp_hw *hw = port->hw;
+	uint32_t speed_code = 0;
+	bool speed_changed = 0;
+	bool duplex = false;
+	uint32_t magic = 0;
+	uint32_t linkstate;
+	uint64_t speed = 0;
+	uint16_t lane = 0;
+
+	lane = port->attr.nr_lane;
+	linkstate = RNP_E_REG_RD(hw, RNP_DEVICE_LINK_EX);
+	magic = linkstate & 0xF0000000;
+	/* check if speed is changed. even if link is not changed */
+	if (RNP_SPEED_META_VALID(magic) &&
+			(linkstate & RNP_LINK_STATE(lane))) {
+		speed_code = RNP_LINK_SPEED_CODE(linkstate, lane);
+		speed = rnp_parse_speed_code(speed_code);
+		if (speed != port->attr.speed) {
+			duplex = RNP_LINK_DUPLEX_STATE(linkstate, lane);
+			port->attr.phy_meta.link_duplex = duplex;
+			port->attr.speed = speed;
+			speed_changed = 1;
+		}
+	}
+
+	return speed_changed;
+}
+
+static bool
+rnp_update_link_changed(struct rnp_eth_port *port,
+			struct rnp_link_stat_req *link)
+{
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t link_up_bit = 0;
+	bool link_changed = 0;
+	uint32_t sync_bit = 0;
+	bool duplex = 0;
+
+	link_up_bit = link->lane_status & RTE_BIT32(lane);
+	sync_bit = RNP_E_REG_RD(hw, RNP_FW_LINK_SYNC);
+	lane = port->attr.nr_lane;
+	if (link_up_bit) {
+		/* port link down to up */
+		if (!port->attr.link_ready)
+			link_changed = true;
+		port->attr.link_ready = true;
+		if (link->port_st_magic == RNP_SPEED_VALID_MAGIC) {
+			port->attr.speed = link->states[lane].speed;
+			duplex = link->states[lane].duplex;
+			port->attr.duplex = duplex;
+			RNP_PMD_INFO("phy_id %d speed %d duplex "
+					"%d issgmii %d PortID %d",
+					link->states[lane].phy_addr,
+					link->states[lane].speed,
+					link->states[lane].duplex,
+					link->states[lane].is_sgmii,
+					port->attr.port_id);
+		}
+	} else {
+		/* port link to down */
+		if (port->attr.link_ready)
+			link_changed = true;
+		port->attr.link_ready = false;
+	}
+	if (!link_changed && sync_bit != link_up_bit)
+		link_changed = 1;
+
+	return link_changed;
+}
+
+static void rnp_link_stat_sync_mark(struct rnp_hw *hw, int lane, int up)
+{
+	uint32_t sync;
+
+	rte_spinlock_lock(&hw->link_sync);
+	sync = RNP_E_REG_RD(hw, RNP_FW_LINK_SYNC);
+	sync &= ~RNP_LINK_MAGIC_MASK;
+	sync |= RNP_LINK_MAGIC_CODE;
+	if (up)
+		sync |= RTE_BIT32(lane);
+	else
+		sync &= ~RTE_BIT32(lane);
+	RNP_E_REG_WR(hw, RNP_FW_LINK_SYNC, sync);
+	rte_spinlock_unlock(&hw->link_sync);
+}
+
+static void rnp_link_report(struct rnp_eth_port *port, bool link_en)
+{
+	struct rte_eth_dev_data *data = port->eth_dev->data;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	struct rnp_tx_queue *txq;
+	struct rte_eth_link link;
+	uint16_t idx;
+
+	if (data == NULL)
+		return;
+	for (idx = 0; idx < data->nb_rx_queues; idx++) {
+		rxq = data->rx_queues[idx];
+		if (!rxq)
+			continue;
+		rxq->rx_link = link_en;
+	}
+	for (idx = 0; idx < data->nb_tx_queues; idx++) {
+		txq = data->tx_queues[idx];
+		if (!txq)
+			continue;
+		txq->tx_link = link_en;
+	}
+	/* set default link info */
+	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+	link.link_status = RTE_ETH_LINK_DOWN;
+	link.link_autoneg = RTE_ETH_LINK_FIXED;
+	if (link_en) {
+		link.link_duplex = port->attr.phy_meta.link_duplex;
+		link.link_speed = port->attr.speed;
+		link.link_status = link_en;
+	}
+	link.link_autoneg = port->attr.phy_meta.link_autoneg;
+	RNP_PMD_LOG(INFO, "PF[%d]link changed: changed_lane:0x%x, "
+			"status:0x%x",
+			hw->mbx.pf_num,
+			port->attr.nr_lane,
+			link_en);
+	/* report link info to upper firmwork */
+	rte_eth_linkstatus_set(port->eth_dev, &link);
+	/* notice event process link status change */
+	rte_eth_dev_callback_process(port->eth_dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+	/* notice firmware LSC event sw received */
+	rnp_link_stat_sync_mark(hw, port->attr.nr_lane, link_en);
+}
+
+static void rnp_dev_alarm_link_handler(void *param)
+{
+	struct rnp_eth_port *port = param;
+	uint32_t status;
+
+	if (port == NULL || port->eth_dev == NULL)
+		return;
+	status = port->attr.link_ready;
+	rnp_link_report(port, status);
+}
+
+void rnp_link_event(struct rnp_eth_adapter *adapter,
+		    struct rnp_mbx_fw_cmd_req *req)
+{
+	struct rnp_link_stat_req *link = (struct rnp_link_stat_req *)req->data;
+	struct rnp_hw *hw = &adapter->hw;
+	struct rnp_eth_port *port = NULL;
+	bool speed_changed;
+	bool link_changed;
+	uint32_t lane;
+	uint8_t i = 0;
+
+	/* get real-time link && speed info */
+	for (i = 0; i < hw->max_port_num; i++) {
+		port = adapter->ports[i];
+		if (port == NULL)
+			continue;
+		speed_changed = false;
+		link_changed = false;
+		lane = port->attr.nr_lane;
+		if (RNP_LINK_NOCHANGED(lane, link->changed_lanes)) {
+			speed_changed = rnp_update_speed_changed(port);
+			if (!speed_changed)
+				continue;
+		}
+		link_changed = rnp_update_link_changed(port, link);
+		if (link_changed || speed_changed) {
+			rnp_link_flow_setup(port);
+			rte_eal_alarm_set(RNP_ALARM_INTERVAL,
+					rnp_dev_alarm_link_handler,
+					(void *)port);
+		}
+	}
+}
+
+int rnp_dev_link_update(struct rte_eth_dev *eth_dev,
+			int wait_to_complete)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rnp_phy_meta *phy_meta = &port->attr.phy_meta;
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	struct rte_eth_link link;
+	uint32_t status;
+
+	PMD_INIT_FUNC_TRACE();
+	memset(&link, 0, sizeof(link));
+	if (wait_to_complete && rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rnp_mbx_fw_get_lane_stat(port);
+	status = port->attr.link_ready;
+	link.link_duplex = phy_meta->link_duplex;
+	link.link_status = status ? RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+	if (link.link_status)
+		link.link_speed = port->attr.speed;
+	link.link_autoneg = phy_meta->link_autoneg ?
+		RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
+	rnp_link_stat_sync_mark(hw, lane, link.link_status);
+	rte_eth_linkstatus_set(eth_dev, &link);
+
+	return 0;
+}
+
+static void rnp_dev_link_task(void *param)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	bool speed_changed = false;
+	bool link_changed = false;
+	bool duplex_attr = false;
+	uint32_t speed_code = 0;
+	uint32_t link_state;
+	bool duplex = false;
+	uint32_t speed = 0;
+
+	link_state = RNP_E_REG_RD(hw, RNP_DEVICE_LINK_EX);
+	if (link_state & RNP_LINK_DUPLEX_ATTR_EN)
+		duplex_attr = true;
+	else
+		link_state = RNP_E_REG_RD(hw, RNP_DEVICE_LINK);
+	if (link_state & RNP_LINK_STATE(lane)) {
+		/* Port link change to up */
+		speed_code = RNP_LINK_SPEED_CODE(link_state, lane);
+		speed = rnp_parse_speed_code(speed_code);
+		if (duplex_attr) {
+			duplex = RNP_LINK_DUPLEX_STATE(link_state, lane);
+			port->attr.phy_meta.link_duplex = duplex;
+		}
+		port->attr.speed = speed;
+		port->attr.pre_link = port->attr.link_ready;
+		port->attr.link_ready = true;
+	} else {
+		/* Port link to down */
+		port->attr.speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+		port->attr.pre_link = port->attr.link_ready;
+		port->attr.link_ready = false;
+	}
+	if (port->attr.pre_link != port->attr.link_ready)
+		link_changed = true;
+	if (!link_changed)
+		speed_changed = rnp_update_speed_changed(port);
+	if (link_changed || speed_changed) {
+		if (!duplex_attr)
+			rnp_mbx_fw_get_lane_stat(port);
+		rnp_link_flow_setup(port);
+		rnp_link_report(port, port->attr.link_ready);
+	}
+	rte_eal_alarm_set(RNP_ALARM_INTERVAL,
+			rnp_dev_link_task,
+			(void *)dev);
+}
+
+void
+rnp_run_link_poll_task(struct rnp_eth_port *port)
+{
+	rte_eal_alarm_set(RNP_ALARM_INTERVAL, rnp_dev_link_task,
+			(void *)port->eth_dev);
+}
+
+void
+rnp_cancel_link_poll_task(struct rnp_eth_port *port)
+{
+	rte_eal_alarm_cancel(rnp_dev_link_task, port->eth_dev);
+}
diff --git a/drivers/net/rnp/rnp_link.h b/drivers/net/rnp/rnp_link.h
new file mode 100644
index 0000000000..f0705f17da
--- /dev/null
+++ b/drivers/net/rnp/rnp_link.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_LINK_H_
+#define _RNP_LINK_H_
+
+#define RNP_DEVICE_LINK		(0x3000c)
+#define RNP_DEVICE_LINK_EX	(0xa800 + 64 * 64 - 4)
+#define RNP_LINK_NOCHANGED(lane_bit, change_lane) \
+	(!((RTE_BIT32(lane_bit)) & (change_lane)))
+#define RNP_LINK_DUPLEX_ATTR_EN		(0xA0000000)
+#define RNP_SPEED_META_VALID(magic)	(!!(magic) == 0xA0000000)
+#define RNP_LINK_STATE(n)		RTE_BIT32(n)
+#define RNP_LINK_SPEED_CODE(sp, n) \
+	(((sp) & RTE_GENMASK32((11) + ((4) * (n)), \
+		(8) + ((4) * (n)))) >> (8 + 4 * (n)))
+#define RNP_LINK_DUPLEX_STATE(sp, n)	((sp) & RTE_BIT32((24) + (n)))
+#define RNP_ALARM_INTERVAL	(50000) /* unit us */
+enum rnp_lane_speed {
+	RNP_LANE_SPEED_10M = 0,
+	RNP_LANE_SPEED_100M,
+	RNP_LANE_SPEED_1G,
+	RNP_LANE_SPEED_10G,
+	RNP_LANE_SPEED_25G,
+	RNP_LANE_SPEED_40G,
+};
+
+void rnp_link_event(struct rnp_eth_adapter *adapter,
+		    struct rnp_mbx_fw_cmd_req *req);
+int rnp_dev_link_update(struct rte_eth_dev *eth_dev,
+			int wait_to_complete);
+void rnp_run_link_poll_task(struct rnp_eth_port *port);
+void rnp_cancel_link_poll_task(struct rnp_eth_port *port);
+
+#endif /* _RNP_LINK_H_ */
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 6aa43945f4..5fa3eddce8 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -88,6 +88,7 @@ rnp_rx_queue_reset(struct rnp_eth_port *port,
 	struct rte_eth_txconf def_conf;
 	struct rnp_hw *hw = port->hw;
 	struct rte_mbuf *m_mbuf[2];
+	bool tx_origin_e = false;
 	bool tx_new = false;
 	uint16_t index;
 	int err = 0;
@@ -123,6 +124,9 @@ rnp_rx_queue_reset(struct rnp_eth_port *port,
 		return -ENOMEM;
 	}
 	rnp_rxq_flow_disable(hw, index);
+	tx_origin_e = txq->txq_started;
+	rte_io_wmb();
+	txq->txq_started = false;
 	rte_mbuf_refcnt_set(m_mbuf[0], 1);
 	rte_mbuf_refcnt_set(m_mbuf[1], 1);
 	m_mbuf[0]->data_off = RTE_PKTMBUF_HEADROOM;
@@ -141,6 +145,7 @@ rnp_rx_queue_reset(struct rnp_eth_port *port,
 			rnp_tx_queue_reset(port, txq);
 			rnp_tx_queue_sw_reset(txq);
 		}
+		txq->txq_started = tx_origin_e;
 	}
 	rte_mempool_put_bulk(adapter->reset_pool, (void **)m_mbuf, 2);
 	rnp_rxq_flow_enable(hw, index);
@@ -372,6 +377,7 @@ rnp_tx_queue_sw_reset(struct rnp_tx_queue *txq)
 	txq->nb_tx_free = txq->attr.nb_desc - 1;
 	txq->tx_next_dd = txq->tx_rs_thresh - 1;
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
+	txq->tx_tail = 0;
 
 	size = (txq->attr.nb_desc + RNP_TX_MAX_BURST_SIZE);
 	for (idx = 0; idx < size * sizeof(struct rnp_tx_desc); idx++)
@@ -474,3 +480,164 @@ rnp_tx_queue_setup(struct rte_eth_dev *dev,
 
 	return err;
 }
+
+int rnp_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rnp_tx_queue *txq;
+
+	PMD_INIT_FUNC_TRACE();
+	txq = eth_dev->data->tx_queues[qidx];
+	if (!txq) {
+		RNP_PMD_ERR("TX queue %u is null or not setup", qidx);
+		return -EINVAL;
+	}
+	if (data->tx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STARTED) {
+		txq->txq_started = 0;
+		/* wait for tx burst process stop traffic */
+		rte_delay_us(10);
+		rnp_tx_queue_release_mbuf(txq);
+		rnp_tx_queue_reset(port, txq);
+		rnp_tx_queue_sw_reset(txq);
+		data->tx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	return 0;
+}
+
+int rnp_tx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
+{
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rnp_tx_queue *txq;
+
+	PMD_INIT_FUNC_TRACE();
+
+	txq = data->tx_queues[qidx];
+	if (!txq) {
+		RNP_PMD_ERR("Can't start tx queue %d it's not setup by "
+				"tx_queue_setup API", qidx);
+		return -EINVAL;
+	}
+	if (data->tx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STOPPED) {
+		data->tx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STARTED;
+		txq->txq_started = 1;
+	}
+
+	return 0;
+}
+
+int rnp_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	bool ori_q_state[RNP_MAX_RX_QUEUE_NUM];
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	uint16_t hwrid;
+	uint16_t i = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	memset(ori_q_state, 0, sizeof(ori_q_state));
+	if (qidx >= data->nb_rx_queues)
+		return -EINVAL;
+	rxq = data->rx_queues[qidx];
+	if (!rxq) {
+		RNP_PMD_ERR("rx queue %u is null or not setup", qidx);
+		return -EINVAL;
+	}
+	if (data->rx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STARTED) {
+		hwrid = rxq->attr.index;
+		for (i = 0; i < RNP_MAX_RX_QUEUE_NUM; i++) {
+			RNP_E_REG_WR(hw, RNP_RXQ_DROP_TIMEOUT_TH(i), 16);
+			ori_q_state[i] = RNP_E_REG_RD(hw, RNP_RXQ_START(i));
+			RNP_E_REG_WR(hw, RNP_RXQ_START(i), 0);
+		}
+		rxq->rxq_started = false;
+		rnp_rx_queue_release_mbuf(rxq);
+		RNP_E_REG_WR(hw, RNP_RXQ_START(hwrid), 0);
+		rnp_rx_queue_reset(port, rxq);
+		rnp_rx_queue_sw_reset(rxq);
+		for (i = 0; i < RNP_MAX_RX_QUEUE_NUM; i++) {
+			RNP_E_REG_WR(hw, RNP_RXQ_DROP_TIMEOUT_TH(i),
+					rxq->nodesc_tm_thresh);
+			RNP_E_REG_WR(hw, RNP_RXQ_START(i), ori_q_state[i]);
+		}
+		RNP_E_REG_WR(hw, RNP_RXQ_START(hwrid), 0);
+		data->rx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	return 0;
+}
+
+static int rnp_alloc_rxq_mbuf(struct rnp_rx_queue *rxq)
+{
+	struct rnp_rxsw_entry *rx_swbd = rxq->sw_ring;
+	volatile struct rnp_rx_desc *rxd;
+	struct rte_mbuf *mbuf = NULL;
+	uint64_t dma_addr;
+	uint16_t i;
+
+	for (i = 0; i < rxq->attr.nb_desc; i++) {
+		mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+		if (!mbuf)
+			goto rx_mb_alloc_failed;
+		rx_swbd[i].mbuf = mbuf;
+
+		rte_mbuf_refcnt_set(mbuf, 1);
+		mbuf->next = NULL;
+		mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+		mbuf->port = rxq->attr.port_id;
+		dma_addr = rnp_get_dma_addr(&rxq->attr, mbuf);
+
+		rxd = &rxq->rx_bdr[i];
+		*rxd = rxq->zero_desc;
+		rxd->d.pkt_addr = dma_addr;
+		rxd->d.cmd = 0;
+	}
+	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
+	for (i = 0; i < RNP_RX_MAX_BURST_SIZE; ++i)
+		rxq->sw_ring[rxq->attr.nb_desc + i].mbuf = &rxq->fake_mbuf;
+
+	return 0;
+rx_mb_alloc_failed:
+	RNP_PMD_ERR("rx queue %u alloc mbuf failed", rxq->attr.queue_id);
+	rnp_rx_queue_release_mbuf(rxq);
+
+	return -ENOMEM;
+}
+
+int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	uint16_t hwrid;
+
+	PMD_INIT_FUNC_TRACE();
+	rxq = data->rx_queues[qidx];
+	if (!rxq) {
+		RNP_PMD_ERR("RX queue %u is Null or Not setup", qidx);
+		return -EINVAL;
+	}
+	if (data->rx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STOPPED) {
+		hwrid = rxq->attr.index;
+		/* disable ring */
+		rte_io_wmb();
+		RNP_E_REG_WR(hw, RNP_RXQ_START(hwrid), 0);
+		if (rnp_alloc_rxq_mbuf(rxq) != 0) {
+			RNP_PMD_ERR("Could not alloc mbuf for queue:%d", qidx);
+			return -ENOMEM;
+		}
+		rte_io_wmb();
+		RNP_REG_WR(rxq->rx_tailreg, 0, rxq->attr.nb_desc - 1);
+		RNP_E_REG_WR(hw, RNP_RXQ_START(hwrid), 1);
+		rxq->nb_rx_free = rxq->attr.nb_desc - 1;
+		rxq->rxq_started = true;
+
+		data->rx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 3ea977ccaa..94e1f06722 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -65,11 +65,14 @@ struct rnp_rx_queue {
 
 	uint32_t nodesc_tm_thresh; /* rx queue no desc timeout thresh */
 	uint8_t rx_deferred_start; /* do not start queue with dev_start(). */
+	uint8_t rxq_started; /* rx queue is started */
+	uint8_t rx_link; /* device link state */
 	uint8_t pthresh; /* rx desc prefetch threshold */
 	uint8_t pburst; /* rx desc prefetch burst */
 
 	uint64_t rx_offloads; /* user set hw offload features */
 	struct rte_mbuf **free_mbufs; /* rx bulk alloc reserve of free mbufs */
+	struct rte_mbuf fake_mbuf; /* dummy mbuf */
 };
 
 struct rnp_txsw_entry {
@@ -98,6 +101,8 @@ struct rnp_tx_queue {
 	uint16_t tx_free_thresh; /* thresh to free tx desc resource */
 
 	uint8_t tx_deferred_start; /*< Do not start queue with dev_start(). */
+	uint8_t txq_started; /* tx queue is started */
+	uint8_t tx_link; /* device link state */
 	uint8_t pthresh; /* rx desc prefetch threshold */
 	uint8_t pburst; /* rx desc burst*/
 
@@ -115,9 +120,13 @@ int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
 		       unsigned int socket_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mb_pool);
+int rnp_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
+int rnp_tx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_tx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t qidx, uint16_t nb_desc,
 		       unsigned int socket_id,
 		       const struct rte_eth_txconf *tx_conf);
+int rnp_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
+int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
 
 #endif /* _RNP_RXTX_H_ */
-- 
2.34.1

