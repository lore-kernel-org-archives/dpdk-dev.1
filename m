Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A0C021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 07:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C0CC40A6F;
	Wed, 26 Feb 2025 08:42:44 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 2CE284027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 08:42:41 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 85A4654B9DE; Wed, 26 Feb 2025 15:42:40 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v16 16/29] net/rnp: add MTU set operation
Date: Wed, 26 Feb 2025 15:42:03 +0800
Message-Id: <1740555736-19894-17-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
References: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
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

add mtu update limit for multiple port mode.
multiple mode just used the max-mtu of ports
to limit receive.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |   1 +
 doc/guides/nics/rnp.rst             |   3 +
 drivers/net/rnp/base/rnp_eth_regs.h |   3 +
 drivers/net/rnp/rnp.h               |   3 +
 drivers/net/rnp/rnp_ethdev.c        | 145 ++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 695b9c0dba..6d13370e8f 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -10,6 +10,7 @@ Link status event    = Y
 Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
+MTU update           = Y
 RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index f5a79492bb..6aa8b00af6 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -50,6 +50,7 @@ Features
   Inner RSS is only support for vxlan/nvgre
 - Promiscuous mode
 - Link state information
+- MTU update
 
 Prerequisites and Pre-conditions
 --------------------------------
@@ -87,6 +88,8 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_rss_reta_update``
 * ``rte_eth_dev_set_link_down``
 * ``rte_eth_dev_set_link_up``
+* ``rte_eth_dev_get_mtu``
+* ``rte_eth_dev_set_mtu``
 * ``rte_eth_promiscuous_disable``
 * ``rte_eth_promiscuous_enable``
 * ``rte_eth_allmulticast_enable``
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index c74886e70c..91a18dd42d 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -16,6 +16,9 @@
 #define RNP_RX_ETH_F_CTRL(n)	_ETH_(0x8070 + ((n) * 0x8))
 #define RNP_RX_ETH_F_OFF	(0x7ff)
 #define RNP_RX_ETH_F_ON		(0x270)
+/* max/min pkts length receive limit ctrl */
+#define RNP_MIN_FRAME_CTRL	_ETH_(0x80f0)
+#define RNP_MAX_FRAME_CTRL	_ETH_(0x80f4)
 /* rx queue flow ctrl */
 #define RNP_RX_FC_ENABLE	_ETH_(0x8520)
 #define RNP_RING_FC_EN(n)	_ETH_(0x8524 + ((0x4) * ((n) / 32)))
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index e5f3ac32bf..8323858043 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -123,6 +123,9 @@ struct rnp_eth_port {
 	bool hw_rss_en;
 	uint32_t indirtbl[RNP_RSS_INDIR_SIZE];
 
+	uint16_t cur_mtu;
+	bool jumbo_en;
+
 	rte_spinlock_t rx_mac_lock;
 	bool port_stopped;
 };
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 33c4de5789..4afdccd0ab 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -21,6 +21,7 @@
 #include "rnp_rss.h"
 #include "rnp_link.h"
 
+static int rnp_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 static struct rte_eth_dev *
 rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
 {
@@ -142,6 +143,13 @@ static void rnp_mac_rx_enable(struct rte_eth_dev *dev)
 	mac_cfg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_RX_CFG);
 	mac_cfg |= RNP_MAC_RE;
 
+	if (port->jumbo_en) {
+		mac_cfg |= RNP_MAC_JE;
+		mac_cfg |= RNP_MAC_GPSLCE | RNP_MAC_WD;
+	} else {
+		mac_cfg &= ~RNP_MAC_JE;
+		mac_cfg &= ~RNP_MAC_WD;
+	}
 	mac_cfg &= ~RNP_MAC_GPSL_MASK;
 	mac_cfg |= (RNP_MAC_MAX_GPSL << RNP_MAC_CPSL_SHIFT);
 	RNP_MAC_REG_WR(hw, lane, RNP_MAC_RX_CFG, mac_cfg);
@@ -211,6 +219,7 @@ rnp_rx_scattered_setup(struct rte_eth_dev *dev)
 {
 	uint16_t max_pkt_size =
 		dev->data->dev_conf.rxmode.mtu + RNP_ETH_OVERHEAD;
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
 	struct rnp_hw *hw = port->hw;
 	struct rnp_rx_queue *rxq;
@@ -236,6 +245,12 @@ rnp_rx_scattered_setup(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 	dma_buf_size = hw->min_dma_size;
+	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER ||
+			max_pkt_size > dma_buf_size ||
+			dev->data->mtu + RNP_ETH_OVERHEAD > dma_buf_size)
+		dev->data->scattered_rx = 1;
+	else
+		dev->data->scattered_rx = 0;
 	/* Setup max dma scatter engine split size */
 	if (max_pkt_size == dma_buf_size)
 		dma_buf_size += (dma_buf_size % 16);
@@ -296,6 +311,7 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
 	struct rte_eth_dev_data *data = eth_dev->data;
+	uint16_t max_rx_pkt_len = eth_dev->data->mtu;
 	bool lsc = data->dev_conf.intr_conf.lsc;
 	struct rnp_hw *hw = port->hw;
 	uint16_t lane = 0;
@@ -316,6 +332,9 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 	if (ret)
 		return ret;
 	ret = rnp_rx_scattered_setup(eth_dev);
+	if (ret)
+		return ret;
+	ret = rnp_mtu_set(eth_dev, max_rx_pkt_len);
 	if (ret)
 		return ret;
 	ret = rnp_enable_all_tx_queue(eth_dev);
@@ -655,6 +674,131 @@ static int rnp_allmulticast_disable(struct rte_eth_dev *eth_dev)
 	return rnp_update_mpfm(port, RNP_MPF_MODE_ALLMULTI, 0);
 }
 
+static bool
+rnp_verify_pf_scatter(struct rnp_eth_adapter *adapter)
+{
+	struct rnp_hw *hw = &adapter->hw;
+	struct rte_eth_dev *eth_dev;
+	uint8_t i = 0;
+
+	for (i = 0; i < hw->max_port_num; i++) {
+		if (adapter->ports[i] == NULL)
+			continue;
+		eth_dev = adapter->ports[i]->eth_dev;
+		if (eth_dev->data == NULL)
+			continue;
+		/* sub port of pf eth_dev state is not
+		 * started so the scatter_rx attr isn't
+		 * setup don't check this sub port.
+		 */
+		if (!eth_dev->data->dev_started)
+			continue;
+		if (!eth_dev->data->scattered_rx)
+			return false;
+	}
+
+	return true;
+}
+
+static int
+rnp_update_valid_mtu(struct rnp_eth_port *port, uint16_t *set_mtu)
+{
+	struct rnp_eth_adapter *adapter = port->hw->back;
+	struct rnp_eth_port *sub_port = NULL;
+	struct rnp_hw *hw = port->hw;
+	uint16_t origin_mtu = 0;
+	uint16_t mtu = 0;
+	uint8_t i = 0;
+
+	if (hw->max_port_num == 1) {
+		port->cur_mtu = *set_mtu;
+
+		return 0;
+	}
+	origin_mtu = port->cur_mtu;
+	port->cur_mtu = *set_mtu;
+	mtu = *set_mtu;
+	for (i = 0; i < hw->max_port_num; i++) {
+		sub_port = adapter->ports[i];
+		if (sub_port == NULL)
+			continue;
+		mtu = RTE_MAX(mtu, sub_port->cur_mtu);
+	}
+	if (hw->max_port_num > 1 &&
+			mtu + RNP_ETH_OVERHEAD > hw->min_dma_size) {
+		if (!rnp_verify_pf_scatter(adapter)) {
+			RNP_PMD_ERR("single pf multiple port max_frame_sz "
+					"is bigger than min_dma_size please "
+					"stop all pf port before set mtu.");
+			port->cur_mtu = origin_mtu;
+			return -EINVAL;
+		}
+	}
+	*set_mtu = mtu;
+
+	return 0;
+}
+
+static int
+rnp_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint32_t frame_size = mtu + RNP_ETH_OVERHEAD;
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	bool jumbo_en = false;
+	uint32_t reg;
+	int ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	/* check that mtu is within the allowed range */
+	if (frame_size < RTE_ETHER_MIN_LEN ||
+			frame_size > RNP_MAC_MAXFRM_SIZE) {
+		RNP_PMD_ERR("valid packet length must be "
+				"range from %u to  %u, "
+				"when Jumbo Frame Feature disabled",
+				(uint32_t)RTE_ETHER_MIN_LEN,
+				(uint32_t)RTE_ETHER_MAX_LEN);
+		return -EINVAL;
+	}
+	/*
+	 * Refuse mtu that requires the support of scattered packets
+	 * when this feature has not been enabled before.
+	 */
+	if (dev->data->dev_started && !dev->data->scattered_rx &&
+			frame_size > dev->data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM) {
+		RNP_PMD_ERR("port %d mtu update must be stopped "
+				"before configuration when scatter rx off.",
+				dev->data->port_id);
+
+		return -EBUSY;
+	}
+	/* For one pf multiple port the mtu we must set
+	 * the biggest mtu the ports selong to pf
+	 * because of the control button is only one
+	 */
+	ret = rnp_update_valid_mtu(port, &mtu);
+	if (ret < 0)
+		return ret;
+	frame_size = mtu + RNP_ETH_OVERHEAD;
+	if (frame_size > RTE_ETHER_MAX_LEN)
+		jumbo_en = true;
+	/* setting the MTU */
+	RNP_E_REG_WR(hw, RNP_MAX_FRAME_CTRL, frame_size);
+	RNP_E_REG_WR(hw, RNP_MIN_FRAME_CTRL, 60);
+	if (jumbo_en) {
+		/* To protect conflict hw resource */
+		rte_spinlock_lock(&port->rx_mac_lock);
+		reg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_RX_CFG);
+		reg |= RNP_MAC_JE;
+		RNP_MAC_REG_WR(hw, lane, RNP_MAC_RX_CFG, reg);
+		rte_spinlock_unlock(&port->rx_mac_lock);
+	}
+	port->jumbo_en = jumbo_en;
+
+	return 0;
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_configure                = rnp_dev_configure,
@@ -669,6 +813,7 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.allmulticast_enable          = rnp_allmulticast_enable,
 	.allmulticast_disable         = rnp_allmulticast_disable,
 
+	.mtu_set                      = rnp_mtu_set,
 	.rx_queue_setup               = rnp_rx_queue_setup,
 	.rx_queue_release             = rnp_dev_rx_queue_release,
 	.rx_queue_stop                = rnp_rx_queue_stop,
-- 
2.25.1

