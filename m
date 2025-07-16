Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3124C83F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 08:30:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C989340674;
	Wed, 16 Jul 2025 10:29:49 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5B09E402E6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 10:29:43 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowACHs6ftYndo4EaBBA--.9864S7;
 Wed, 16 Jul 2025 16:29:41 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v9 06/14] net/sxe: add filter function
Date: Wed, 16 Jul 2025 04:29:22 -0400
Message-ID: <20250716082930.83026-6-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250716082930.83026-1-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHs6ftYndo4EaBBA--.9864S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1kZFy3uFyDXrWxWrWDXFb_yoW3Kr1DpF
 48uasFkFy3XFnrXanFyr409F13C3ZYgryjgry3Caya9aySqr45XrykJFyUAa9Yk3s8Gr4a
 qFs293ZrGr1Fy3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
 s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7
 CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
 FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
 Wlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj
 6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
 0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
 cSsGvfC2KfnxnUUI43ZEXa7sRRrgA7UUUUU==
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

Add filter function.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/pf/sxe.h        |   4 +
 drivers/net/sxe/pf/sxe_filter.c | 191 ++++++++++++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_filter.h |  29 +++++
 drivers/net/sxe/pf/sxe_main.c   |   1 +
 4 files changed, 225 insertions(+)

diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 2936fbfbe2..660c0ab8b5 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -44,6 +44,10 @@ struct sxe_adapter {
 	struct sxe_irq_context irq_ctxt;
 
 	struct sxe_vlan_context vlan_ctxt;
+	struct sxe_mac_filter_context mac_filter_ctxt;
+#ifdef RTE_ADAPTER_HAVE_FNAV_CONF
+	struct rte_eth_fdir_conf fnav_conf;
+#endif
 	struct sxe_phy_context phy_ctxt;
 
 	bool rx_batch_alloc_allowed;
diff --git a/drivers/net/sxe/pf/sxe_filter.c b/drivers/net/sxe/pf/sxe_filter.c
index 1b06bcc558..fd3a3c0984 100644
--- a/drivers/net/sxe/pf/sxe_filter.c
+++ b/drivers/net/sxe/pf/sxe_filter.c
@@ -83,6 +83,47 @@ static void sxe_default_mac_addr_get(struct sxe_adapter *adapter)
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
@@ -150,6 +191,156 @@ s32 sxe_mac_addr_init(struct rte_eth_dev *eth_dev)
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
index a64b68374d..da40c75d84 100644
--- a/drivers/net/sxe/pf/sxe_filter.h
+++ b/drivers/net/sxe/pf/sxe_filter.h
@@ -19,6 +19,27 @@ struct sxe_adapter;
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
@@ -35,6 +56,14 @@ struct sxe_mac_filter_context {
 
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
index cc3145c09b..700934b378 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -195,6 +195,7 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 		goto l_end;
 	}
 
+	sxe_hw_uc_addr_clear(hw);
 l_end:
 	return ret;
 }
-- 
2.18.4

