Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345EFC021AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 07:59:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16DE940E18;
	Wed, 19 Feb 2025 08:57:54 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 3F36540DDE
 for <dev@dpdk.org>; Wed, 19 Feb 2025 08:57:46 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 98CD0AE85C; Wed, 19 Feb 2025 15:57:45 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v13 10/28] net/rnp: add support device start stop operations
Date: Wed, 19 Feb 2025 15:57:11 +0800
Message-Id: <1739951849-67601-11-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
References: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
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

add basic support for device to start/stop function.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/rnp.rst             |   2 +
 drivers/net/rnp/base/rnp_common.c   |  22 +++
 drivers/net/rnp/base/rnp_common.h   |   1 +
 drivers/net/rnp/base/rnp_dma_regs.h |  10 +
 drivers/net/rnp/base/rnp_eth_regs.h |   5 +
 drivers/net/rnp/base/rnp_hw.h       |   1 +
 drivers/net/rnp/base/rnp_mac.h      |  14 ++
 drivers/net/rnp/base/rnp_mac_regs.h |  42 ++++
 drivers/net/rnp/rnp.h               |   3 +
 drivers/net/rnp/rnp_ethdev.c        | 284 +++++++++++++++++++++++++++-
 10 files changed, 383 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index c3547c38b6..66ff7f4090 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -75,6 +75,8 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_rx_queue_stop``
 * ``rte_eth_dev_tx_queue_start``
 * ``rte_eth_dev_tx_queue_stop``
+* ``rte_eth_dev_start``
+* ``rte_eth_dev_stop``
 * ``rte_eth_promiscuous_disable``
 * ``rte_eth_promiscuous_enable``
 * ``rte_eth_allmulticast_enable``
diff --git a/drivers/net/rnp/base/rnp_common.c b/drivers/net/rnp/base/rnp_common.c
index 58de3bde03..2dacb5113e 100644
--- a/drivers/net/rnp/base/rnp_common.c
+++ b/drivers/net/rnp/base/rnp_common.c
@@ -79,3 +79,25 @@ rnp_setup_common_ops(struct rnp_hw *hw)
 
 	return 0;
 }
+
+int rnp_clock_valid_check(struct rnp_hw *hw, u16 nr_lane)
+{
+	uint16_t timeout = 0;
+
+	do {
+		RNP_E_REG_WR(hw, RNP_RSS_REDIR_TB(nr_lane, 0), 0x7f);
+		udelay(10);
+		timeout++;
+		if (timeout >= 1000)
+			break;
+	} while (RNP_E_REG_RD(hw, RNP_RSS_REDIR_TB(nr_lane, 0)) != 0x7f);
+
+	if (timeout >= 1000) {
+		RNP_PMD_ERR("ethernet[%d] eth reg can't be write", nr_lane);
+		return -EPERM;
+	}
+	/* clear the dirty value */
+	RNP_E_REG_WR(hw, RNP_RSS_REDIR_TB(nr_lane, 0), 0);
+
+	return 0;
+}
diff --git a/drivers/net/rnp/base/rnp_common.h b/drivers/net/rnp/base/rnp_common.h
index cf1996a675..91e2996398 100644
--- a/drivers/net/rnp/base/rnp_common.h
+++ b/drivers/net/rnp/base/rnp_common.h
@@ -12,5 +12,6 @@
 	 ((macaddr[4] << 8)) | (macaddr[5]))
 int rnp_init_hw(struct rnp_hw *hw);
 int rnp_setup_common_ops(struct rnp_hw *hw);
+int rnp_clock_valid_check(struct rnp_hw *hw, u16 nr_lane);
 
 #endif /* _RNP_COMMON_H_ */
diff --git a/drivers/net/rnp/base/rnp_dma_regs.h b/drivers/net/rnp/base/rnp_dma_regs.h
index 7c17741c55..8bc6fe581a 100644
--- a/drivers/net/rnp/base/rnp_dma_regs.h
+++ b/drivers/net/rnp/base/rnp_dma_regs.h
@@ -6,9 +6,19 @@
 #define _RNP_DMA_REGS_H_
 
 #define RNP_DMA_VERSION		(0)
+#define RNP_DMA_CTRL		(0x4)
+/* 1bit <-> 16 bytes dma addr size */
+#define RNP_DMA_SCATTER_MEM_MASK	RTE_GENMASK32(31, 16)
+#define RNP_DMA_SCATTER_MEN_S		(16)
+#define RNP_DMA_RX_MEM_PAD_EN		RTE_BIT32(8)
+#define RTE_DMA_VEB_BYPASS		RTE_BIT32(4)
+#define RNP_DMA_TXRX_LOOP		RTE_BIT32(1)
+#define RNP_DMA_TXMRX_LOOP		RTE_BIT32(0)
+
 #define RNP_DMA_HW_EN		(0x10)
 #define RNP_DMA_EN_ALL		(0b1111)
 #define RNP_DMA_HW_STATE	(0x14)
+
 /* --- queue register --- */
 /* queue enable */
 #define RNP_RXQ_START(qid)	_RING_(0x0010 + 0x100 * (qid))
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index 10e3d954b8..60766d2035 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -10,6 +10,9 @@
 #define RNP_E_FILTER_EN		_ETH_(0x801c)
 #define RNP_E_REDIR_EN		_ETH_(0x8030)
 
+#define RNP_RX_ETH_F_CTRL(n)	_ETH_(0x8070 + ((n) * 0x8))
+#define RNP_RX_ETH_F_OFF	(0x7ff)
+#define RNP_RX_ETH_F_ON		(0x270)
 /* rx queue flow ctrl */
 #define RNP_RX_FC_ENABLE	_ETH_(0x8520)
 #define RNP_RING_FC_EN(n)	_ETH_(0x8524 + ((0x4) * ((n) / 32)))
@@ -28,6 +31,8 @@
 #define RNP_MAC_HASH_MASK		RTE_GENMASK32(11, 0)
 #define RNP_MAC_MULTICASE_TBL_EN	RTE_BIT32(2)
 #define RNP_MAC_UNICASE_TBL_EN		RTE_BIT32(3)
+/* rss function ctrl */
+#define RNP_RSS_REDIR_TB(n, id) _ETH_(0xe000 + ((n) * 0x200) + ((id) * 0x4))
 
 #define RNP_TC_PORT_OFFSET(lane)	_ETH_(0xe840 + 0x04 * (lane))
 
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index 9541b4e9be..548e3a4468 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -120,6 +120,7 @@ struct rnp_hw {
 	bool lane_is_sgmii[RNP_MAX_PORT_OF_PF];
 	struct rnp_mbx_info mbx;
 	struct rnp_fw_info fw_info;
+	u16 min_dma_size;
 
 	spinlock_t rxq_reset_lock; /* reset op isn't thread safe */
 	spinlock_t txq_reset_lock; /* reset op isn't thread safe */
diff --git a/drivers/net/rnp/base/rnp_mac.h b/drivers/net/rnp/base/rnp_mac.h
index 57cbd9e3d5..1dac903396 100644
--- a/drivers/net/rnp/base/rnp_mac.h
+++ b/drivers/net/rnp/base/rnp_mac.h
@@ -7,6 +7,20 @@
 
 #include "rnp_osdep.h"
 #include "rnp_hw.h"
+#include "rnp_eth_regs.h"
+
+#define RNP_RX_ETH_DISABLE(hw, nr_lane) do { \
+	wmb(); \
+	RNP_E_REG_WR(hw, RNP_RX_ETH_F_CTRL(nr_lane), \
+			RNP_RX_ETH_F_OFF); \
+} while (0)
+
+#define RNP_RX_ETH_ENABLE(hw, nr_lane) do { \
+	wmb(); \
+	RNP_E_REG_WR(hw, RNP_RX_ETH_F_CTRL(nr_lane), \
+			RNP_RX_ETH_F_ON); \
+} while (0)
+
 
 void rnp_mac_ops_init(struct rnp_hw *hw);
 int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac);
diff --git a/drivers/net/rnp/base/rnp_mac_regs.h b/drivers/net/rnp/base/rnp_mac_regs.h
index 1dc0668b48..1ae880143d 100644
--- a/drivers/net/rnp/base/rnp_mac_regs.h
+++ b/drivers/net/rnp/base/rnp_mac_regs.h
@@ -7,6 +7,41 @@
 
 #define RNP_MAC_BASE_OFFSET(n)  (_MAC_(0) + ((0x10000) * (n)))
 
+#define RNP_MAC_TX_CFG		(0x0)
+/* Transmitter Enable */
+#define RNP_MAC_TE		RTE_BIT32(0)
+/* Jabber Disable */
+#define RNP_MAC_JD		RTE_BIT32(16)
+#define RNP_SPEED_SEL_MASK	RTE_GENMASK32(30, 28)
+#define RNP_SPEED_SEL_S		(28)
+#define RNP_SPEED_SEL_1G	(b111 << RNP_SPEED_SEL_S)
+#define RNP_SPEED_SEL_10G	(b010 << RNP_SPEED_SEL_S)
+#define RNP_SPEED_SEL_40G	(b000 << RNP_SPEED_SEL_S)
+
+#define RNP_MAC_RX_CFG		(0x4)
+/* Receiver Enable */
+#define RNP_MAC_RE		RTE_BIT32(0)
+/* Automatic Pad or CRC Stripping */
+#define RNP_MAC_ACS		RTE_BIT32(1)
+/* CRC stripping for Type packets */
+#define RNP_MAC_CST		RTE_BIT32(2)
+/* Disable CRC Check */
+#define RNP_MAC_DCRCC		RTE_BIT32(3)
+/* Enable Max Frame Size Limit */
+#define RNP_MAC_GPSLCE		RTE_BIT32(6)
+/* Watchdog Disable */
+#define RNP_MAC_WD		RTE_BIT32(7)
+/* Jumbo Packet Support En */
+#define RNP_MAC_JE		RTE_BIT32(8)
+/* Enable IPC */
+#define RNP_MAC_IPC		RTE_BIT32(9)
+/* Loopback Mode */
+#define RNP_MAC_LM		RTE_BIT32(10)
+/* Giant Packet Size Limit */
+#define RNP_MAC_GPSL_MASK	RTE_GENMASK32(29, 16)
+#define RNP_MAC_MAX_GPSL	(1518)
+#define RNP_MAC_CPSL_SHIFT	(16)
+
 #define RNP_MAC_PKT_FLT_CTRL	(0x8)
 /* Receive All */
 #define RNP_MAC_RA		RTE_BIT32(31)
@@ -35,5 +70,12 @@
 #define RNP_MAC_HPF		RTE_BIT32(10)
 #define RNP_MAC_VTFE		RTE_BIT32(16)
 
+#define RNP_MAC_VFE		RTE_BIT32(16)
+/* mac link ctrl */
+#define RNP_MAC_LPI_CTRL	(0xd0)
+/* PHY Link Status Disable */
+#define RNP_MAC_PLSDIS		RTE_BIT32(18)
+/* PHY Link Status */
+#define RNP_MAC_PLS		RTE_BIT32(17)
 
 #endif /* _RNP_MAC_REGS_H_ */
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 4002b80a03..c38c31c128 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -110,6 +110,9 @@ struct rnp_eth_port {
 	struct rnp_port_attr attr;
 	struct rnp_tx_queue *tx_queues[RNP_MAX_RX_QUEUE_NUM];
 	struct rnp_hw *hw;
+
+	rte_spinlock_t rx_mac_lock;
+	bool port_stopped;
 };
 
 struct rnp_eth_adapter {
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 96cda076a1..43de704c90 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -15,6 +15,8 @@
 #include "base/rnp_mac.h"
 #include "base/rnp_eth_regs.h"
 #include "base/rnp_common.h"
+#include "base/rnp_dma_regs.h"
+#include "base/rnp_mac_regs.h"
 #include "rnp_rxtx.h"
 
 static struct rte_eth_dev *
@@ -53,9 +55,285 @@ static void rnp_dev_interrupt_handler(void *param)
 	RTE_SET_USED(param);
 }
 
+static void rnp_mac_rx_enable(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t mac_cfg;
+
+	rte_spinlock_lock(&port->rx_mac_lock);
+	mac_cfg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_RX_CFG);
+	mac_cfg |= RNP_MAC_RE;
+
+	mac_cfg &= ~RNP_MAC_GPSL_MASK;
+	mac_cfg |= (RNP_MAC_MAX_GPSL << RNP_MAC_CPSL_SHIFT);
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_RX_CFG, mac_cfg);
+	rte_spinlock_unlock(&port->rx_mac_lock);
+}
+
+static void rnp_mac_rx_disable(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t mac_cfg;
+
+	/* to protect conflict hw resource */
+	rte_spinlock_lock(&port->rx_mac_lock);
+	mac_cfg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_RX_CFG);
+	mac_cfg &= ~RNP_MAC_RE;
+
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_RX_CFG, mac_cfg);
+	rte_spinlock_unlock(&port->rx_mac_lock);
+}
+
+static void rnp_mac_tx_enable(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t mac_cfg;
+
+	mac_cfg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_TX_CFG);
+	mac_cfg |= RNP_MAC_TE;
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_TX_CFG, mac_cfg);
+}
+
+static void rnp_mac_tx_disable(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t ctrl;
+
+	/* must wait for tx side has send finish
+	 * before fisable tx side
+	 */
+	ctrl = RNP_MAC_REG_RD(hw, lane, RNP_MAC_TX_CFG);
+	ctrl &= ~RNP_MAC_TE;
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_TX_CFG, ctrl);
+}
+
+static void rnp_mac_init(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t mac_cfg;
+
+	rnp_mac_tx_enable(dev);
+	rnp_mac_rx_enable(dev);
+
+	mac_cfg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_LPI_CTRL);
+	mac_cfg |= RNP_MAC_PLSDIS | RNP_MAC_PLS;
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_LPI_CTRL, mac_cfg);
+}
+
+static int
+rnp_rx_scattered_setup(struct rte_eth_dev *dev)
+{
+	uint16_t max_pkt_size =
+		dev->data->dev_conf.rxmode.mtu + RNP_ETH_OVERHEAD;
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	uint16_t dma_buf_size;
+	uint16_t queue_id;
+	uint32_t dma_ctrl;
+
+	if (dev->data->rx_queues == NULL)
+		return -ENOMEM;
+	for (queue_id = 0; queue_id < dev->data->nb_rx_queues; queue_id++) {
+		rxq = dev->data->rx_queues[queue_id];
+		if (!rxq)
+			continue;
+		if (hw->min_dma_size == 0)
+			hw->min_dma_size = rxq->rx_buf_len;
+		else
+			hw->min_dma_size = RTE_MIN(hw->min_dma_size,
+					rxq->rx_buf_len);
+	}
+	if (hw->min_dma_size < RNP_MIN_DMA_BUF_SIZE) {
+		RNP_PMD_ERR("port[%d] scatter dma len is not support %d",
+				dev->data->port_id, hw->min_dma_size);
+		return -ENOTSUP;
+	}
+	dma_buf_size = hw->min_dma_size;
+	/* Setup max dma scatter engine split size */
+	dma_ctrl = RNP_E_REG_RD(hw,  RNP_DMA_CTRL);
+	if (max_pkt_size == dma_buf_size)
+		dma_buf_size += (dma_buf_size % 16);
+	RNP_PMD_INFO("PF[%d] MaxPktLen %d MbSize %d MbHeadRoom %d",
+			hw->mbx.pf_num, max_pkt_size,
+			dma_buf_size, RTE_PKTMBUF_HEADROOM);
+	dma_ctrl &= ~RNP_DMA_SCATTER_MEM_MASK;
+	dma_ctrl |= ((dma_buf_size / 16) << RNP_DMA_SCATTER_MEN_S);
+	RNP_E_REG_WR(hw, RNP_DMA_CTRL, dma_ctrl);
+
+	return 0;
+}
+
+static int rnp_enable_all_rx_queue(struct rte_eth_dev *dev)
+{
+	struct rnp_rx_queue *rxq;
+	uint16_t idx;
+	int ret = 0;
+
+	for (idx = 0; idx < dev->data->nb_rx_queues; idx++) {
+		rxq = dev->data->rx_queues[idx];
+		if (!rxq || rxq->rx_deferred_start)
+			continue;
+		if (dev->data->rx_queue_state[idx] ==
+				RTE_ETH_QUEUE_STATE_STOPPED) {
+			ret = rnp_rx_queue_start(dev, idx);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int rnp_enable_all_tx_queue(struct rte_eth_dev *dev)
+{
+	struct rnp_tx_queue *txq;
+	uint16_t idx;
+	int ret = 0;
+
+	for (idx = 0; idx < dev->data->nb_tx_queues; idx++) {
+		txq = dev->data->tx_queues[idx];
+		if (!txq || txq->tx_deferred_start)
+			continue;
+		if (dev->data->tx_queue_state[idx] ==
+				RTE_ETH_QUEUE_STATE_STOPPED) {
+			ret = rnp_tx_queue_start(dev, idx);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int rnp_dev_start(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rnp_hw *hw = port->hw;
+	uint16_t lane = 0;
+	uint16_t idx = 0;
+	int ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	lane = port->attr.nr_lane;
+	ret = rnp_clock_valid_check(hw, lane);
+	if (ret) {
+		RNP_PMD_ERR("port[%d] function[%d] lane[%d] hw clock error",
+				data->port_id, hw->mbx.pf_num, lane);
+		return ret;
+	}
+	/* disable eth rx flow */
+	RNP_RX_ETH_DISABLE(hw, lane);
+	ret = rnp_rx_scattered_setup(eth_dev);
+	if (ret)
+		return ret;
+	ret = rnp_enable_all_tx_queue(eth_dev);
+	if (ret)
+		goto txq_start_failed;
+	ret = rnp_enable_all_rx_queue(eth_dev);
+	if (ret)
+		goto rxq_start_failed;
+	rnp_mac_init(eth_dev);
+	/* enable eth rx flow */
+	RNP_RX_ETH_ENABLE(hw, lane);
+	port->port_stopped = 0;
+
+	return 0;
+rxq_start_failed:
+	for (idx = 0; idx < data->nb_rx_queues; idx++)
+		rnp_rx_queue_stop(eth_dev, idx);
+txq_start_failed:
+	for (idx = 0; idx < data->nb_tx_queues; idx++)
+		rnp_tx_queue_stop(eth_dev, idx);
+
+	return ret;
+}
+
+static int rnp_disable_all_rx_queue(struct rte_eth_dev *dev)
+{
+	struct rnp_rx_queue *rxq;
+	uint16_t idx;
+	int ret = 0;
+
+	for (idx = 0; idx < dev->data->nb_rx_queues; idx++) {
+		rxq = dev->data->rx_queues[idx];
+		if (!rxq || rxq->rx_deferred_start)
+			continue;
+		if (dev->data->rx_queue_state[idx] ==
+				RTE_ETH_QUEUE_STATE_STARTED) {
+			ret = rnp_rx_queue_stop(dev, idx);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int rnp_disable_all_tx_queue(struct rte_eth_dev *dev)
+{
+	struct rnp_tx_queue *txq;
+	uint16_t idx;
+	int ret = 0;
+
+	for (idx = 0; idx < dev->data->nb_tx_queues; idx++) {
+		txq = dev->data->tx_queues[idx];
+		if (!txq || txq->tx_deferred_start)
+			continue;
+		if (dev->data->tx_queue_state[idx] ==
+				RTE_ETH_QUEUE_STATE_STARTED) {
+			ret = rnp_tx_queue_stop(dev, idx);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
 static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 {
-	RTE_SET_USED(eth_dev);
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	const struct rte_eth_dev_data *data = eth_dev->data;
+	struct rte_eth_link link;
+	int ret;
+
+	if (port->port_stopped)
+		return 0;
+	eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
+	eth_dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+	eth_dev->tx_pkt_prepare = rte_eth_pkt_burst_dummy;
+
+	/* clear the recorded link status */
+	memset(&link, 0, sizeof(link));
+	rte_eth_linkstatus_set(eth_dev, &link);
+
+	ret = rnp_disable_all_tx_queue(eth_dev);
+	if (ret < 0) {
+		RNP_PMD_ERR("port[%u] disable tx queue failed", data->port_id);
+		return ret;
+	}
+	ret = rnp_disable_all_rx_queue(eth_dev);
+	if (ret < 0) {
+		RNP_PMD_ERR("port[%u] disable rx queue failed", data->port_id);
+		return ret;
+	}
+	rnp_mac_tx_disable(eth_dev);
+	rnp_mac_rx_disable(eth_dev);
+
+	eth_dev->data->dev_started = 0;
+	port->port_stopped = 1;
 
 	return 0;
 }
@@ -238,6 +516,7 @@ static int rnp_allmulticast_disable(struct rte_eth_dev *eth_dev)
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_close                    = rnp_dev_close,
+	.dev_start                    = rnp_dev_start,
 	.dev_stop                     = rnp_dev_stop,
 	.dev_infos_get                = rnp_dev_infos_get,
 
@@ -321,6 +600,7 @@ rnp_init_port_resource(struct rnp_eth_adapter *adapter,
 	}
 	rte_ether_addr_copy(&port->mac_addr, &eth_dev->data->mac_addrs[0]);
 
+	rte_spinlock_init(&port->rx_mac_lock);
 	adapter->ports[p_id] = port;
 	adapter->inited_ports++;
 
@@ -454,6 +734,8 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 		ret = rnp_init_port_resource(adapter, sub_eth_dev, name, p_id);
 		if (ret)
 			goto eth_alloc_error;
+		rnp_mac_rx_disable(sub_eth_dev);
+		rnp_mac_tx_disable(sub_eth_dev);
 		if (p_id) {
 			/* port 0 will be probe by platform */
 			rte_eth_dev_probing_finish(sub_eth_dev);
-- 
2.25.1

