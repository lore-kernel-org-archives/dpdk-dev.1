Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213DDC369D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 02:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DADF40657;
	Fri, 25 Apr 2025 04:37:04 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id D948F402F0
 for <dev@dpdk.org>; Fri, 25 Apr 2025 04:36:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowACnSvtG9QpoC2i4Cw--.963S6;
 Fri, 25 Apr 2025 10:36:55 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	JieLiu <liujie5@linkdatatechnology.com>
Subject: [PATCH 05/13] net/sxe: support vlan filter
Date: Thu, 24 Apr 2025 19:36:44 -0700
Message-Id: <20250425023652.37368-5-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnSvtG9QpoC2i4Cw--.963S6
X-Coremail-Antispam: 1UD129KBjvAXoW3Cr4DKrW5Wr4rJr4kCF1UAwb_yoW8Gr18uo
 WxJrsxGF1rury7Kr9agF1kuFW7Xr4xKrZ8t3yavFs8X3ZxAa45Cr17tw1ayFn5Ww4YqF4D
 J3Z29F9Fyr47Wa1fn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gr1l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnxRDUUUUU
X-Originating-IP: [60.29.3.194]
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

From: JieLiu <liujie5@linkdatatechnology.com>

Support vlan filter.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_offload_common.c |   4 +
 drivers/net/sxe/pf/sxe.h                  |   4 +
 drivers/net/sxe/pf/sxe_ethdev.c           |  17 ++
 drivers/net/sxe/pf/sxe_filter.c           | 277 ++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_filter.h           |  13 +
 drivers/net/sxe/pf/sxe_main.c             |   2 +
 drivers/net/sxe/pf/sxe_rx.c               |   5 +
 7 files changed, 322 insertions(+)

diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
index 91ae1c792c..48f16240df 100644
--- a/drivers/net/sxe/base/sxe_offload_common.c
+++ b/drivers/net/sxe/base/sxe_offload_common.c
@@ -18,6 +18,8 @@ u64 __sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev)
 
 	u64 offloads = 0;
 
+	offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+
 	return offloads;
 }
 
@@ -32,6 +34,8 @@ u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
 #ifdef DEV_RX_JUMBO_FRAME
 		   DEV_RX_OFFLOAD_JUMBO_FRAME |
 #endif
+			RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
+			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
 		   RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	if (!RTE_ETH_DEV_SRIOV(dev).active)
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 8a578137bd..d6a8058bfc 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -11,11 +11,13 @@
 #include <stdbool.h>
 #endif
 #include "sxe_types.h"
+#include "sxe_filter.h"
 #include "sxe_irq.h"
 #include "sxe_phy.h"
 #include "sxe_hw.h"
 
 struct sxe_hw;
+struct sxe_vlan_context;
 
 #define SXE_LPBK_DISABLED   0x0
 #define SXE_LPBK_ENABLED	0x1
@@ -45,6 +47,8 @@ struct sxe_adapter {
 	struct sxe_hw hw;
 
 	struct sxe_irq_context irq_ctxt;
+
+	struct sxe_vlan_context vlan_ctxt;
 	struct sxe_phy_context phy_ctxt;
 
 	bool rx_batch_alloc_allowed;
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
index b09c60ba26..a1c7e11150 100644
--- a/drivers/net/sxe/pf/sxe_ethdev.c
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -260,6 +260,9 @@ static s32 sxe_dev_start(struct rte_eth_dev *dev)
 		goto l_error;
 	}
 
+	sxe_vlan_filter_configure(dev);
+
+
 	sxe_txrx_start(dev);
 
 	irq->to_pcs_init = true;
@@ -626,6 +629,11 @@ static const struct eth_dev_ops sxe_eth_dev_ops = {
 	.flow_ctrl_get		= sxe_flow_ctrl_get,
 	.flow_ctrl_set		= sxe_flow_ctrl_set,
 
+	.vlan_filter_set	  = sxe_vlan_filter_set,
+	.vlan_tpid_set		= sxe_vlan_tpid_set,
+	.vlan_offload_set	 = sxe_vlan_offload_set,
+	.vlan_strip_queue_set = sxe_vlan_strip_queue_set,
+
 	.get_reg		= sxe_get_regs,
 
 	.dev_set_link_up	= sxe_dev_set_link_up,
@@ -714,6 +722,14 @@ static void sxe_ethdev_mac_mem_free(struct rte_eth_dev *eth_dev)
 	}
 }
 
+
+#ifdef DPDK_19_11_6
+static void sxe_pf_init(struct sxe_adapter *adapter)
+{
+	memset(&adapter->vlan_ctxt, 0, sizeof(adapter->vlan_ctxt));
+}
+#endif
+
 s32 sxe_ethdev_init(struct rte_eth_dev *eth_dev, void *param __rte_unused)
 {
 	s32 ret = 0;
@@ -761,6 +777,7 @@ s32 sxe_ethdev_init(struct rte_eth_dev *eth_dev, void *param __rte_unused)
 
 #ifdef DPDK_19_11_6
 	eth_dev->data->dev_flags |= RTE_ETH_DEV_CLOSE_REMOVE;
+	sxe_pf_init(adapter);
 #endif
 	ret = sxe_hw_base_init(eth_dev);
 	if (ret) {
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
index 52abca85c4..1c2bc05b12 100644
--- a/drivers/net/sxe/pf/sxe_filter.c
+++ b/drivers/net/sxe/pf/sxe_filter.c
@@ -281,3 +281,280 @@ static void sxe_hash_mac_addr_parse(u8 *mac_addr, u16 *reg_idx,
 			 mac_addr[0], mac_addr[1], mac_addr[2], mac_addr[3],
 			 mac_addr[4], mac_addr[5], *reg_idx, *bit_idx);
 }
+
+s32 sxe_vlan_filter_set(struct rte_eth_dev *eth_dev, u16 vlan_id, s32 on)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vlan_context *vlan_ctxt = &adapter->vlan_ctxt;
+	u8 reg_idx;
+	u8 bit_idx;
+	u32 value;
+
+	reg_idx = (vlan_id >> SXE_VLAN_ID_SHIFT) & SXE_VLAN_ID_REG_MASK;
+	bit_idx = (vlan_id & SXE_VLAN_ID_BIT_MASK);
+
+	value = sxe_hw_vlan_filter_array_read(hw, reg_idx);
+	if (on)
+		value |= (1 << bit_idx);
+	else
+		value &= ~(1 << bit_idx);
+
+	sxe_hw_vlan_filter_array_write(hw, reg_idx, value);
+
+	vlan_ctxt->vlan_hash_table[reg_idx] = value;
+
+	PMD_LOG_INFO(DRV, "vlan_id:0x%x on:%d set done", vlan_id, on);
+
+	return 0;
+}
+
+static void sxe_vlan_tpid_write(struct sxe_hw *hw, u16 tpid)
+{
+	u32 value;
+
+	value = sxe_hw_vlan_type_get(hw);
+	value = (value & (~SXE_VLNCTRL_VET)) | tpid;
+	sxe_hw_vlan_type_set(hw, value);
+
+	value = sxe_hw_txctl_vlan_type_get(hw);
+	value = (value & (~SXE_DMATXCTL_VT_MASK)) |
+		(tpid << SXE_DMATXCTL_VT_SHIFT);
+	sxe_hw_txctl_vlan_type_set(hw, value);
+}
+
+s32 sxe_vlan_tpid_set(struct rte_eth_dev *eth_dev,
+			enum rte_vlan_type vlan_type, u16 tpid)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret = 0;
+	u32 txctl;
+	bool double_vlan;
+
+	txctl = sxe_hw_txctl_vlan_type_get(hw);
+	double_vlan = txctl & SXE_DMATXCTL_GDV;
+
+	switch (vlan_type) {
+	case RTE_ETH_VLAN_TYPE_INNER:
+		if (double_vlan) {
+			sxe_vlan_tpid_write(hw, tpid);
+		} else {
+			ret = -ENOTSUP;
+			PMD_LOG_ERR(DRV, "unsupport inner vlan without "
+					 "global double vlan.");
+		}
+		break;
+	case RTE_ETH_VLAN_TYPE_OUTER:
+		if (double_vlan) {
+			sxe_hw_vlan_ext_type_set(hw,
+				(tpid << SXE_EXVET_VET_EXT_SHIFT));
+		} else {
+			sxe_vlan_tpid_write(hw, tpid);
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		PMD_LOG_ERR(DRV, "Unsupported VLAN type %d", vlan_type);
+		break;
+	}
+
+	PMD_LOG_INFO(DRV, "double_vlan:%d vlan_type:%d tpid:0x%x set done ret:%d",
+			   double_vlan, vlan_type, tpid, ret);
+	return ret;
+}
+
+static void sxe_vlan_strip_bitmap_set(struct rte_eth_dev *dev, u16 queue_idx, bool on)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_vlan_context *vlan_ctxt = &adapter->vlan_ctxt;
+
+	sxe_rx_queue_s *rxq;
+
+	if (queue_idx >= SXE_HW_TXRX_RING_NUM_MAX ||
+		queue_idx >= dev->data->nb_rx_queues) {
+		PMD_LOG_ERR(DRV, "invalid queue idx:%u exceed max"
+			   " queue number:%u or nb_rx_queues:%u.",
+			   queue_idx, SXE_HW_TXRX_RING_NUM_MAX,
+			   dev->data->nb_rx_queues);
+		return;
+	}
+
+	if (on)
+		SXE_STRIP_BITMAP_SET(vlan_ctxt, queue_idx);
+	else
+		SXE_STRIP_BITMAP_CLEAR(vlan_ctxt, queue_idx);
+
+	rxq = dev->data->rx_queues[queue_idx];
+
+	if (on) {
+		rxq->vlan_flags = RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+		rxq->offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	} else {
+		rxq->vlan_flags = RTE_MBUF_F_RX_VLAN;
+		rxq->offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	}
+
+	PMD_LOG_INFO(DRV, "queue idx:%u vlan strip on:%d set bitmap and offload done.",
+			 queue_idx, on);
+}
+
+void sxe_vlan_strip_switch_set(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u16 i;
+	sxe_rx_queue_s *rxq;
+	bool on;
+
+	PMD_INIT_FUNC_TRACE();
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+
+		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			on = true;
+		else
+			on = false;
+		sxe_hw_vlan_tag_strip_switch(hw, i, on);
+
+		sxe_vlan_strip_bitmap_set(dev, i, on);
+	}
+}
+
+static void sxe_vlan_filter_disable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_hw_vlan_filter_switch(hw, 0);
+}
+
+static void sxe_vlan_filter_enable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_vlan_context *vlan_ctxt = &adapter->vlan_ctxt;
+	u32 vlan_ctl;
+	u16 i;
+
+	PMD_INIT_FUNC_TRACE();
+
+	vlan_ctl = sxe_hw_vlan_type_get(hw);
+	vlan_ctl &= ~SXE_VLNCTRL_CFI;
+	vlan_ctl |= SXE_VLNCTRL_VFE;
+	sxe_hw_vlan_type_set(hw, vlan_ctl);
+
+	for (i = 0; i < SXE_VFT_TBL_SIZE; i++)
+		sxe_hw_vlan_filter_array_write(hw, i, vlan_ctxt->vlan_hash_table[i]);
+}
+
+static void sxe_vlan_extend_disable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 ctrl;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ctrl = sxe_hw_txctl_vlan_type_get(hw);
+	ctrl &= ~SXE_DMATXCTL_GDV;
+	sxe_hw_txctl_vlan_type_set(hw, ctrl);
+
+	ctrl = sxe_hw_ext_vlan_get(hw);
+	ctrl &= ~SXE_EXTENDED_VLAN;
+	sxe_hw_ext_vlan_set(hw, ctrl);
+}
+
+static void sxe_vlan_extend_enable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 ctrl;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ctrl = sxe_hw_txctl_vlan_type_get(hw);
+	ctrl |= SXE_DMATXCTL_GDV;
+	sxe_hw_txctl_vlan_type_set(hw, ctrl);
+
+	ctrl = sxe_hw_ext_vlan_get(hw);
+	ctrl |= SXE_EXTENDED_VLAN;
+	sxe_hw_ext_vlan_set(hw, ctrl);
+}
+
+static s32 sxe_vlan_offload_configure(struct rte_eth_dev *dev, s32 mask)
+{
+	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
+
+	if (mask & RTE_ETH_VLAN_STRIP_MASK)
+		sxe_vlan_strip_switch_set(dev);
+
+	if (mask & RTE_ETH_VLAN_FILTER_MASK) {
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_FILTER)
+			sxe_vlan_filter_enable(dev);
+		else
+			sxe_vlan_filter_disable(dev);
+	}
+
+	if (mask & RTE_ETH_VLAN_EXTEND_MASK) {
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_EXTEND)
+			sxe_vlan_extend_enable(dev);
+		else
+			sxe_vlan_extend_disable(dev);
+	}
+
+	PMD_LOG_INFO(DRV, "mask:0x%x rx mode offload:0x%" SXE_PRIX64
+			 " vlan offload set done", mask, rxmode->offloads);
+
+	return 0;
+}
+
+s32 sxe_vlan_offload_set(struct rte_eth_dev *dev, s32 vlan_mask)
+{
+	s32 mask;
+	s32 ret = 0;
+
+	if (vlan_mask & RTE_ETH_VLAN_STRIP_MASK) {
+		PMD_LOG_WARN(DRV, "please set vlan strip before device start, not at this stage.");
+		ret = -1;
+		goto l_out;
+	}
+	mask = vlan_mask & ~RTE_ETH_VLAN_STRIP_MASK;
+
+	sxe_vlan_offload_configure(dev, mask);
+
+	PMD_LOG_INFO(DRV, "vlan offload mask:0x%x set done.", vlan_mask);
+
+l_out:
+	return ret;
+}
+
+void sxe_vlan_strip_queue_set(struct rte_eth_dev *dev, u16 queue, s32 on)
+{
+	UNUSED(dev);
+	UNUSED(queue);
+	UNUSED(on);
+	PMD_LOG_WARN(DRV, "please set vlan strip before device start, not at this stage.");
+}
+
+void sxe_vlan_filter_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 vlan_mask;
+	u32 vlan_ctl;
+
+	vlan_mask = RTE_ETH_VLAN_STRIP_MASK | RTE_ETH_VLAN_FILTER_MASK |
+			RTE_ETH_VLAN_EXTEND_MASK;
+	sxe_vlan_offload_configure(dev, vlan_mask);
+
+	if (dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_ONLY) {
+		vlan_ctl = sxe_hw_vlan_type_get(hw);
+		vlan_ctl |= SXE_VLNCTRL_VFE;
+		sxe_hw_vlan_type_set(hw, vlan_ctl);
+		LOG_DEBUG_BDF("vmdq mode enable vlan filter done.");
+	}
+}
diff --git a/drivers/net/sxe/pf/sxe_filter.h b/drivers/net/sxe/pf/sxe_filter.h
index d7cf571b65..2e1211677e 100644
--- a/drivers/net/sxe/pf/sxe_filter.h
+++ b/drivers/net/sxe/pf/sxe_filter.h
@@ -51,10 +51,23 @@ void sxe_mac_addr_remove(struct rte_eth_dev *dev, u32 rar_idx);
 s32 sxe_mac_addr_set(struct rte_eth_dev *dev,
 				 struct rte_ether_addr *mac_addr);
 
+s32 sxe_vlan_filter_set(struct rte_eth_dev *eth_dev, u16 vlan_id, s32 on);
+
+s32 sxe_vlan_tpid_set(struct rte_eth_dev *eth_dev,
+			enum rte_vlan_type vlan_type, u16 tpid);
+
+s32 sxe_vlan_offload_set(struct rte_eth_dev *dev, s32 vlan_mask);
+
+void sxe_vlan_strip_queue_set(struct rte_eth_dev *dev, u16 queue, s32 on);
+
+void sxe_vlan_filter_configure(struct rte_eth_dev *dev);
+
 s32 sxe_set_mc_addr_list(struct rte_eth_dev *dev,
 			  struct rte_ether_addr *mc_addr_list,
 			  u32 nb_mc_addr);
 
+void sxe_vlan_strip_switch_set(struct rte_eth_dev *dev);
+
 void sxe_fc_mac_addr_set(struct sxe_adapter *adapter);
 
 #endif
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
index 52c6248a82..482d73669d 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -212,6 +212,8 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 
 void sxe_hw_start(struct sxe_hw *hw)
 {
+	sxe_hw_vlan_filter_array_clear(hw);
+
 	sxe_fc_autoneg_localcap_set(hw);
 
 	hw->mac.auto_restart = true;
diff --git a/drivers/net/sxe/pf/sxe_rx.c b/drivers/net/sxe/pf/sxe_rx.c
index 976513a166..2f879d92cb 100644
--- a/drivers/net/sxe/pf/sxe_rx.c
+++ b/drivers/net/sxe/pf/sxe_rx.c
@@ -1072,6 +1072,9 @@ static inline void
 			rxq->crc_len = RTE_ETHER_CRC_LEN;
 		else
 			rxq->crc_len = 0;
+
+		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			rx_conf->offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	}
 }
 
@@ -1093,6 +1096,8 @@ static inline void
 		adapter->mtu = dev->data->mtu;
 #endif
 
+	rx_conf->offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+
 	if (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_SCATTER)
 		dev->data->scattered_rx = 1;
 
-- 
2.18.4

