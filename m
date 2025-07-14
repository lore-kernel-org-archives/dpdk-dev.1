Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E314C83F1B
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 03:55:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B1240649;
	Mon, 14 Jul 2025 05:55:13 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0546640041
 for <dev@dpdk.org>; Mon, 14 Jul 2025 05:55:04 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowADH8qaJf3RoneLPAw--.5262S6;
 Mon, 14 Jul 2025 11:55:02 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 05/14] net/sxe: support vlan filter
Date: Sun, 13 Jul 2025 23:54:37 -0400
Message-ID: <20250714035446.163709-5-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250714035446.163709-1-liujie5@linkdatatechnology.com>
References: <20250712061846.305072-14-liujie5@linkdatatechnology.com>
 <20250714035446.163709-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADH8qaJf3RoneLPAw--.5262S6
X-Coremail-Antispam: 1UD129KBjvJXoWfGw4DCF4UCw4rWw17KFyfZwb_yoWkXr4rpF
 WUGa48ArWfXFn7Xas5Aw43uF15GF4kXryqgFn3C34Yva42vryxJF1DtF9rA3yrKF98Gw1Y
 yws3Z3ZrGF1FkFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8GwCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU5Oz-UUUUU=
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

Support vlan filter.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_offload_common.c |   4 +
 drivers/net/sxe/pf/sxe.h                  |   5 +-
 drivers/net/sxe/pf/sxe_filter.c           | 277 ++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_filter.h           |  13 +
 drivers/net/sxe/pf/sxe_main.c             |   2 +
 5 files changed, 300 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
index 48677863d7..cc35c16ddf 100644
--- a/drivers/net/sxe/base/sxe_offload_common.c
+++ b/drivers/net/sxe/base/sxe_offload_common.c
@@ -14,6 +14,8 @@ u64 __sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev)
 
 	u64 offloads = 0;
 
+	offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+
 	return offloads;
 }
 
@@ -28,6 +30,8 @@ u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
 #ifdef DEV_RX_JUMBO_FRAME
 		   DEV_RX_OFFLOAD_JUMBO_FRAME |
 #endif
+			RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
+			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
 		   RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	if (!RTE_ETH_DEV_SRIOV(dev).active)
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 8f0037ebb0..2936fbfbe2 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -6,7 +6,7 @@
 
 #include <rte_pci.h>
 #include <rte_time.h>
-
+#include "sxe_filter.h"
 #include <stdbool.h>
 #include "sxe_types.h"
 #include "sxe_irq.h"
@@ -14,6 +14,7 @@
 #include "sxe_hw.h"
 
 struct sxe_hw;
+struct sxe_vlan_context;
 
 #define SXE_LPBK_DISABLED   0x0
 #define SXE_LPBK_ENABLED	0x1
@@ -41,6 +42,8 @@ struct sxe_adapter {
 	struct sxe_hw hw;
 
 	struct sxe_irq_context irq_ctxt;
+
+	struct sxe_vlan_context vlan_ctxt;
 	struct sxe_phy_context phy_ctxt;
 
 	bool rx_batch_alloc_allowed;
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
index e80866c56a..1b06bcc558 100644
--- a/drivers/net/sxe/pf/sxe_filter.c
+++ b/drivers/net/sxe/pf/sxe_filter.c
@@ -277,3 +277,280 @@ static void sxe_hash_mac_addr_parse(u8 *mac_addr, u16 *reg_idx,
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
+			PMD_LOG_ERR(DRV, "unsupported inner vlan without "
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
+		PMD_LOG_ERR(DRV, "unsupported VLAN type %d", vlan_type);
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
index 0f21f1ca81..a64b68374d 100644
--- a/drivers/net/sxe/pf/sxe_filter.h
+++ b/drivers/net/sxe/pf/sxe_filter.h
@@ -44,10 +44,23 @@ void sxe_mac_addr_remove(struct rte_eth_dev *dev, u32 rar_idx);
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
index 22418bf1ec..cc3145c09b 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -201,6 +201,8 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 
 void sxe_hw_start(struct sxe_hw *hw)
 {
+	sxe_hw_vlan_filter_array_clear(hw);
+
 	sxe_fc_autoneg_localcap_set(hw);
 
 	hw->mac.auto_restart = true;
-- 
2.18.4

