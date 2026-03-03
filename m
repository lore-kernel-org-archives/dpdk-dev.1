Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59320EC0462
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 09:11:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1AC640E40;
	Tue,  3 Mar 2026 10:11:06 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9AE5A40E12
 for <dev@dpdk.org>; Tue,  3 Mar 2026 10:11:01 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-01 (Coremail) with SMTP id qwCowAC3Ym6ipaZpYi4sCQ--.16406S7;
 Tue, 03 Mar 2026 17:10:59 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v18 05/13] net/sxe: support vlan filter
Date: Tue,  3 Mar 2026 17:10:49 +0800
Message-Id: <20260303091057.2952214-6-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260303091057.2952214-1-liujie5@linkdatatechnology.com>
References: <20260209012458.506200-13-liujie5@linkdatatechnology.com>
 <20260303091057.2952214-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: qwCowAC3Ym6ipaZpYi4sCQ--.16406S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr43tFyxXrWDXFWrCw17ZFb_yoWDZF1rpF
 WUGa48ArWxJFn7Xa95Aw43uF15GF4kX34qgFn3C34Yya42vryxJF1DJF9rA3yrKF98Gw1Y
 yan3Z3ZrGF1FkFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
 s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4
 CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8uwCF04k20xvY0x0E
 wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
 80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
 I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
 k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRNBM_UUUUU=
X-Originating-IP: [221.238.36.162]
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

Support vlan filter.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_offload_common.c |   4 +
 drivers/net/sxe/pf/sxe_filter.c           | 277 ++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_filter.h           |  13 +
 drivers/net/sxe/pf/sxe_main.c             |   2 +
 4 files changed, 296 insertions(+)

diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
index f07d2b9572..f7c7363a2e 100644
--- a/drivers/net/sxe/base/sxe_offload_common.c
+++ b/drivers/net/sxe/base/sxe_offload_common.c
@@ -12,6 +12,8 @@ u64 __sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev)
 
 	u64 offloads = 0;
 
+	offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+
 	return offloads;
 }
 
@@ -23,6 +25,8 @@ u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
 			RTE_ETH_RX_OFFLOAD_UDP_CKSUM   |
 			RTE_ETH_RX_OFFLOAD_TCP_CKSUM   |
 			RTE_ETH_RX_OFFLOAD_KEEP_CRC	|
+			RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
+			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
 			RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	if (!RTE_ETH_DEV_SRIOV(dev).active)
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
index 3cd5ddad03..8e3f6b6b29 100644
--- a/drivers/net/sxe/pf/sxe_filter.c
+++ b/drivers/net/sxe/pf/sxe_filter.c
@@ -276,3 +276,280 @@ static void sxe_hash_mac_addr_parse(u8 *mac_addr, u16 *reg_idx,
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
index 1f103f978d..51df05ac8e 100644
--- a/drivers/net/sxe/pf/sxe_filter.h
+++ b/drivers/net/sxe/pf/sxe_filter.h
@@ -43,10 +43,23 @@ void sxe_mac_addr_remove(struct rte_eth_dev *dev, u32 rar_idx);
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
index d9cc7be1e0..6ea261a0cb 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -154,6 +154,8 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 
 void sxe_hw_start(struct sxe_hw *hw)
 {
+	sxe_hw_vlan_filter_array_clear(hw);
+
 	sxe_fc_autoneg_localcap_set(hw);
 }
 
-- 
2.18.2

