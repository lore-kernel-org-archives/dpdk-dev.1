Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2B0C369D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 02:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3E504042E;
	Fri, 25 Apr 2025 04:37:01 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 12ED2400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 04:36:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowACnSvtG9QpoC2i4Cw--.963S7;
 Fri, 25 Apr 2025 10:36:55 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	JieLiu <liujie5@linkdatatechnology.com>
Subject: [PATCH 06/13] net/sxe: add mac layer filter function
Date: Thu, 24 Apr 2025 19:36:45 -0700
Message-Id: <20250425023652.37368-6-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnSvtG9QpoC2i4Cw--.963S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKF43Cw1UCrW3CF17Gw17Wrg_yoWDGFW5pF
 48ua4jkFy3XFsrXanrAw48uF13CanYgryjgFy3C3429ayfXr45XryktFyUAayvkryDGr42
 qrs29wnrGr1Fy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8JwCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-XoxUUUUU=
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

Add mac layer filter function.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/pf/sxe.h        |   1 +
 drivers/net/sxe/pf/sxe_ethdev.c |  16 ++-
 drivers/net/sxe/pf/sxe_filter.c | 191 ++++++++++++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_filter.h |  29 +++++
 drivers/net/sxe/pf/sxe_main.c   |   1 +
 5 files changed, 237 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index d6a8058bfc..7effe4e830 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -49,6 +49,7 @@ struct sxe_adapter {
 	struct sxe_irq_context irq_ctxt;
 
 	struct sxe_vlan_context vlan_ctxt;
+	struct sxe_mac_filter_context mac_filter_ctxt;
 	struct sxe_phy_context phy_ctxt;
 
 	bool rx_batch_alloc_allowed;
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
index a1c7e11150..41f5edfe6c 100644
--- a/drivers/net/sxe/pf/sxe_ethdev.c
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -399,6 +399,7 @@ static s32 sxe_dev_close(struct rte_eth_dev *dev)
 
 	sxe_queues_free(dev);
 
+	sxe_mac_addr_set(dev, &adapter->mac_filter_ctxt.def_mac_addr);
 	sxe_irq_uninit(dev);
 
 l_end:
@@ -611,6 +612,11 @@ static const struct eth_dev_ops sxe_eth_dev_ops = {
 #endif
 #endif
 
+	.promiscuous_enable	= sxe_promiscuous_enable,
+	.promiscuous_disable	= sxe_promiscuous_disable,
+	.allmulticast_enable	= sxe_allmulticast_enable,
+	.allmulticast_disable	= sxe_allmulticast_disable,
+
 	.rx_queue_intr_enable	= sxe_rx_queue_intr_enable,
 	.rx_queue_intr_disable	= sxe_rx_queue_intr_disable,
 
@@ -720,13 +726,21 @@ static void sxe_ethdev_mac_mem_free(struct rte_eth_dev *eth_dev)
 		rte_free(eth_dev->data->hash_mac_addrs);
 		eth_dev->data->hash_mac_addrs = NULL;
 	}
-}
 
+	if (adapter->mac_filter_ctxt.uc_addr_table) {
+		rte_free(adapter->mac_filter_ctxt.uc_addr_table);
+		adapter->mac_filter_ctxt.uc_addr_table = NULL;
+	}
+
+}
 
 #ifdef DPDK_19_11_6
 static void sxe_pf_init(struct sxe_adapter *adapter)
 {
 	memset(&adapter->vlan_ctxt, 0, sizeof(adapter->vlan_ctxt));
+	memset(&adapter->mac_filter_ctxt.uta_hash_table, 0,
+		sizeof(adapter->mac_filter_ctxt.uta_hash_table));
+
 }
 #endif
 
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
index 1c2bc05b12..889f95ddb2 100644
--- a/drivers/net/sxe/pf/sxe_filter.c
+++ b/drivers/net/sxe/pf/sxe_filter.c
@@ -87,6 +87,47 @@ static void sxe_default_mac_addr_get(struct sxe_adapter *adapter)
 	rte_ether_addr_copy(&mac_addr, &adapter->mac_filter_ctxt.fc_mac_addr);
 }
 
+static u8 sxe_sw_uc_entry_add(struct rte_eth_dev *eth_dev, u8 index,
+	u8 *mac_addr)
+{
+	u8 i, pool;
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+
+	pool = sxe_vf_num_get(eth_dev);
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (!uc_table[i].used) {
+			uc_table[i].pool_idx = pool;
+			uc_table[i].used = true;
+			uc_table[i].rar_idx = i;
+			uc_table[i].original_index = index;
+			uc_table[i].type = SXE_PF;
+			rte_memcpy(uc_table[i].addr, mac_addr, SXE_MAC_ADDR_LEN);
+			break;
+		}
+	}
+
+	return i;
+}
+
+static u8 sxe_sw_uc_entry_del(struct sxe_adapter *adapter, u8 index)
+{
+	u8 i;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (!uc_table[i].used || uc_table[i].type != SXE_PF)
+			continue;
+
+		if (uc_table[i].original_index == index) {
+			uc_table[i].used = false;
+			break;
+		}
+	}
+
+	return i;
+}
+
 s32 sxe_mac_addr_init(struct rte_eth_dev *eth_dev)
 {
 	struct sxe_adapter *adapter = eth_dev->data->dev_private;
@@ -154,6 +195,156 @@ s32 sxe_mac_addr_init(struct rte_eth_dev *eth_dev)
 	goto l_out;
 }
 
+static void sxe_pf_promisc_mac_update(struct rte_eth_dev *dev, bool enable)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
+	u16 pf_pool = sxe_vf_num_get(dev);
+	s32 i;
+
+	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
+		if (uc_table[i].used && uc_table[i].type != SXE_PF) {
+			if (enable)
+				sxe_hw_uc_addr_pool_enable(&adapter->hw,
+					uc_table[i].rar_idx, pf_pool);
+			else
+				sxe_hw_uc_addr_pool_del(&adapter->hw,
+					uc_table[i].rar_idx, pf_pool);
+		}
+	}
+}
+
+s32 sxe_promiscuous_enable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 flt_ctrl;
+	u32 vm_l2_ctrl = 0;
+	u16 vf_num;
+
+	flt_ctrl = sxe_hw_rx_mode_get(hw);
+	PMD_LOG_DEBUG(DRV, "read flt_ctrl=0x%x", flt_ctrl);
+
+	flt_ctrl |= (SXE_FCTRL_UPE | SXE_FCTRL_MPE);
+
+	vf_num = sxe_vf_num_get(dev);
+	if (vf_num != 0) {
+		vm_l2_ctrl = sxe_hw_pool_rx_mode_get(hw, vf_num) |
+				SXE_VMOLR_ROMPE | SXE_VMOLR_MPE;
+		sxe_hw_pool_rx_mode_set(hw, vm_l2_ctrl, vf_num);
+
+		sxe_pf_promisc_mac_update(dev, true);
+	}
+
+	PMD_LOG_DEBUG(DRV, "write flt_ctrl=0x%x vmolr=0x%x", flt_ctrl, vm_l2_ctrl);
+	sxe_hw_rx_mode_set(hw, flt_ctrl);
+	adapter->mac_filter_ctxt.promiscuous_mode = true;
+
+	return 0;
+}
+
+s32 sxe_promiscuous_disable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 flt_ctrl;
+	u32 vm_l2_ctrl = 0;
+	u16 vf_num;
+
+	flt_ctrl = sxe_hw_rx_mode_get(hw);
+	PMD_LOG_DEBUG(DRV, "read flt_ctrl=0x%x", flt_ctrl);
+
+	flt_ctrl &= (~SXE_FCTRL_UPE);
+	if (dev->data->all_multicast == 1)
+		flt_ctrl |= SXE_FCTRL_MPE;
+	else
+		flt_ctrl &= (~SXE_FCTRL_MPE);
+
+	vf_num = sxe_vf_num_get(dev);
+	if (vf_num != 0) {
+		vm_l2_ctrl = sxe_hw_pool_rx_mode_get(hw, vf_num);
+		if (dev->data->all_multicast == 0) {
+			vm_l2_ctrl &= ~SXE_VMOLR_MPE;
+			if ((sxe_hw_mc_filter_get(hw) & SXE_MCSTCTRL_MFE) == 0)
+				vm_l2_ctrl &= ~SXE_VMOLR_ROMPE;
+		}
+		sxe_hw_pool_rx_mode_set(hw, vm_l2_ctrl, vf_num);
+		sxe_pf_promisc_mac_update(dev, false);
+	}
+
+	PMD_LOG_DEBUG(DRV, "write flt_ctrl=0x%x vmolr=0x%x", flt_ctrl, vm_l2_ctrl);
+	sxe_hw_rx_mode_set(hw, flt_ctrl);
+	adapter->mac_filter_ctxt.promiscuous_mode = false;
+
+	return 0;
+}
+
+s32 sxe_allmulticast_enable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 flt_ctrl;
+	u32 vm_l2_ctrl = 0;
+	u16 vf_num;
+
+	flt_ctrl = sxe_hw_rx_mode_get(hw);
+	PMD_LOG_DEBUG(DRV, "read flt_ctrl=0x%x", flt_ctrl);
+
+	flt_ctrl |= SXE_FCTRL_MPE;
+
+	PMD_LOG_DEBUG(DRV, "write flt_ctrl=0x%x", flt_ctrl);
+	sxe_hw_rx_mode_set(hw, flt_ctrl);
+
+	vf_num = sxe_vf_num_get(dev);
+	if (vf_num != 0) {
+		vm_l2_ctrl = sxe_hw_pool_rx_mode_get(hw, vf_num) |
+				SXE_VMOLR_MPE | SXE_VMOLR_ROMPE;
+		sxe_hw_pool_rx_mode_set(hw, vm_l2_ctrl, vf_num);
+	}
+
+	PMD_LOG_DEBUG(DRV, "write flt_ctrl=0x%x vmolr=0x%x",
+			flt_ctrl, vm_l2_ctrl);
+
+	return 0;
+}
+
+s32 sxe_allmulticast_disable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 flt_ctrl;
+	u32 vm_l2_ctrl = 0;
+	u16 vf_num;
+
+	if (dev->data->promiscuous == 1) {
+		PMD_LOG_DEBUG(DRV, "promiscuous is enable, allmulticast must be enabled.");
+		goto l_out;
+	}
+
+	flt_ctrl = sxe_hw_rx_mode_get(hw);
+	PMD_LOG_DEBUG(DRV, "read flt_ctrl=0x%x", flt_ctrl);
+
+	flt_ctrl &= (~SXE_FCTRL_MPE);
+
+	vf_num = sxe_vf_num_get(dev);
+	if (vf_num != 0) {
+		vm_l2_ctrl = sxe_hw_pool_rx_mode_get(hw, vf_num) &
+					(~SXE_VMOLR_MPE);
+		if ((sxe_hw_mc_filter_get(hw) & SXE_MCSTCTRL_MFE) == 0)
+			vm_l2_ctrl &= ~SXE_VMOLR_ROMPE;
+
+		sxe_hw_pool_rx_mode_set(hw, vm_l2_ctrl, vf_num);
+	} else {
+		sxe_hw_rx_mode_set(hw, flt_ctrl);
+	}
+
+	PMD_LOG_DEBUG(DRV, "write flt_ctrl=0x%x vmolr=0x%x",
+			flt_ctrl, vm_l2_ctrl);
+
+l_out:
+	return 0;
+}
+
 s32 sxe_mac_addr_add(struct rte_eth_dev *dev,
 				 struct rte_ether_addr *mac_addr,
 				 u32 index, u32 pool)
diff --git a/drivers/net/sxe/pf/sxe_filter.h b/drivers/net/sxe/pf/sxe_filter.h
index 2e1211677e..476d58f294 100644
--- a/drivers/net/sxe/pf/sxe_filter.h
+++ b/drivers/net/sxe/pf/sxe_filter.h
@@ -26,6 +26,27 @@ struct sxe_adapter;
 		RTE_ALIGN((SXE_HW_TXRX_RING_NUM_MAX / (sizeof(u32) * BYTE_BIT_NUM)), \
 		sizeof(u32))
 
+struct sxe_vlan_context {
+	u32 vlan_hash_table[SXE_VFT_TBL_SIZE];
+	u32 strip_bitmap[SXE_VLAN_STRIP_BITMAP_SIZE];
+	u32  vlan_table_size;
+};
+
+enum sxe_uc_addr_src_type {
+	SXE_PF = 0,
+	SXE_VF,
+	SXE_VF_MACVLAN
+};
+
+struct sxe_uc_addr_table {
+	u8 rar_idx;
+	u8 pool_idx;
+	u8 type;
+	u8 original_index;
+	bool used;
+	u8 addr[SXE_MAC_ADDR_LEN];
+};
+
 struct sxe_mac_filter_context {
 	struct rte_ether_addr def_mac_addr;
 	struct rte_ether_addr cur_mac_addr;
@@ -42,6 +63,14 @@ struct sxe_mac_filter_context {
 
 s32 sxe_mac_addr_init(struct rte_eth_dev *eth_dev);
 
+s32 sxe_promiscuous_enable(struct rte_eth_dev *dev);
+
+s32 sxe_promiscuous_disable(struct rte_eth_dev *dev);
+
+s32 sxe_allmulticast_enable(struct rte_eth_dev *dev);
+
+s32 sxe_allmulticast_disable(struct rte_eth_dev *dev);
+
 s32 sxe_mac_addr_add(struct rte_eth_dev *dev,
 				 struct rte_ether_addr *mac_addr,
 				 u32 rar_idx, u32 pool);
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
index 482d73669d..4196f6e537 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -206,6 +206,7 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 		goto l_end;
 	}
 
+	sxe_hw_uc_addr_clear(hw);
 l_end:
 	return ret;
 }
-- 
2.18.4

