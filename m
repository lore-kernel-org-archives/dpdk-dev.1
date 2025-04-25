Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CAFC369D7
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 02:37:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC1F840669;
	Fri, 25 Apr 2025 04:37:08 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6E76C4028C
 for <dev@dpdk.org>; Fri, 25 Apr 2025 04:37:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowACnSvtG9QpoC2i4Cw--.963S8;
 Fri, 25 Apr 2025 10:36:55 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	JieLiu <liujie5@linkdatatechnology.com>
Subject: [PATCH 07/13] net/sxe: support rss offload
Date: Thu, 24 Apr 2025 19:36:46 -0700
Message-Id: <20250425023652.37368-7-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
References: <20250425023652.37368-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnSvtG9QpoC2i4Cw--.963S8
X-Coremail-Antispam: 1UD129KBjvAXoW3Cr43tF4ruw4fXFyrtr4xZwb_yoW8JFy7uo
 WSgrsrGw1rZw17u34DXFn7JFW7ZrWUKa97Jwsa9rn8uFn7Jr1UCr15XanxAr4DWw1YvryU
 KF1I93sIqr47KFWfn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
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
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUndgCUUUUU
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

Support rss offload.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_offload_common.c |  12 +-
 drivers/net/sxe/pf/sxe.h                  |   2 +
 drivers/net/sxe/pf/sxe_ethdev.c           |  12 +-
 drivers/net/sxe/pf/sxe_offload.c          | 298 ++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_offload.h          |  33 +++
 5 files changed, 350 insertions(+), 7 deletions(-)

diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
index 48f16240df..510ef065df 100644
--- a/drivers/net/sxe/base/sxe_offload_common.c
+++ b/drivers/net/sxe/base/sxe_offload_common.c
@@ -28,15 +28,16 @@ u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
 	u64 rx_offload_capa;
 
 	rx_offload_capa = RTE_ETH_RX_OFFLOAD_IPV4_CKSUM  |
-		   RTE_ETH_RX_OFFLOAD_UDP_CKSUM   |
-		   RTE_ETH_RX_OFFLOAD_TCP_CKSUM   |
-		   RTE_ETH_RX_OFFLOAD_KEEP_CRC	|
+			RTE_ETH_RX_OFFLOAD_UDP_CKSUM   |
+			RTE_ETH_RX_OFFLOAD_TCP_CKSUM   |
+			RTE_ETH_RX_OFFLOAD_KEEP_CRC	|
 #ifdef DEV_RX_JUMBO_FRAME
-		   DEV_RX_OFFLOAD_JUMBO_FRAME |
+			DEV_RX_OFFLOAD_JUMBO_FRAME |
 #endif
 			RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
 			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
-		   RTE_ETH_RX_OFFLOAD_SCATTER;
+			RTE_ETH_RX_OFFLOAD_SCATTER |
+			RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
 	if (!RTE_ETH_DEV_SRIOV(dev).active)
 		rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TCP_LRO;
@@ -60,4 +61,3 @@ u64 __sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev)
 
 	return tx_offload_capa;
 }
-
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 7effe4e830..b9a25eeb43 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -57,6 +57,8 @@ struct sxe_adapter {
 
 	u32 mtu;
 
+	bool rss_reta_updated;
+
 #if defined DPDK_24_11_1
 	RTE_ATOMIC(bool)link_thread_running;
 	RTE_ATOMIC(bool)is_stopping;
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
index 41f5edfe6c..c015104094 100644
--- a/drivers/net/sxe/pf/sxe_ethdev.c
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -347,6 +347,8 @@ static s32 sxe_dev_stop(struct rte_eth_dev *dev)
 	memset(&link, 0, sizeof(link));
 	rte_eth_linkstatus_set(dev, &link);
 
+	adapter->rss_reta_updated = false;
+
 	dev->data->dev_started = 0;
 	adapter->is_stopped = true;
 
@@ -463,6 +465,11 @@ static s32 sxe_dev_infos_get(struct rte_eth_dev *dev,
 
 	dev_info->rx_desc_lim = sxe_rx_desc_lim;
 	dev_info->tx_desc_lim = sxe_tx_desc_lim;
+
+	dev_info->hash_key_size = SXE_HKEY_MAX_INDEX * sizeof(u32);
+	dev_info->reta_size = RTE_ETH_RSS_RETA_SIZE_128;
+	dev_info->flow_type_rss_offloads = SXE_RSS_OFFLOAD_ALL;
+
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_10G;
 
 	dev_info->default_rxportconf.burst_size = 32;
@@ -621,7 +628,10 @@ static const struct eth_dev_ops sxe_eth_dev_ops = {
 	.rx_queue_intr_disable	= sxe_rx_queue_intr_disable,
 
 	.mtu_set		= sxe_mtu_set,
-
+	.reta_update		= sxe_rss_reta_update,
+	.reta_query		= sxe_rss_reta_query,
+	.rss_hash_update	= sxe_rss_hash_update,
+	.rss_hash_conf_get	= sxe_rss_hash_conf_get,
 
 	.mac_addr_add		= sxe_mac_addr_add,
 	.mac_addr_remove	= sxe_mac_addr_remove,
diff --git a/drivers/net/sxe/pf/sxe_offload.c b/drivers/net/sxe/pf/sxe_offload.c
index 2c9101eb30..2c50e6183c 100644
--- a/drivers/net/sxe/pf/sxe_offload.c
+++ b/drivers/net/sxe/pf/sxe_offload.c
@@ -15,11 +15,26 @@
 #include "sxe_queue_common.h"
 #include "sxe_offload_common.h"
 
+static u8 rss_sxe_key[40] = {
+	0x6D, 0x5A, 0x56, 0xDA, 0x25, 0x5B, 0x0E, 0xC2,
+	0x41, 0x67, 0x25, 0x3D, 0x43, 0xA3, 0x8F, 0xB0,
+	0xD0, 0xCA, 0x2B, 0xCB, 0xAE, 0x7B, 0x30, 0xB4,
+	0x77, 0xCB, 0x2D, 0xA3, 0x80, 0x30, 0xF2, 0x0C,
+	0x6A, 0x42, 0xB7, 0x3B, 0xBE, 0xAC, 0x01, 0xFA,
+};
+
 #define SXE_4_BIT_WIDTH  (CHAR_BIT / 2)
 #define SXE_4_BIT_MASK   RTE_LEN2MASK(SXE_4_BIT_WIDTH, u8)
 #define SXE_8_BIT_WIDTH  CHAR_BIT
 #define SXE_8_BIT_MASK   UINT8_MAX
 
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_FILTER_CTRL
+u8 *sxe_rss_hash_key_get(void)
+{
+	return rss_sxe_key;
+}
+#endif
+
 u64 sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev)
 {
 	return __sxe_rx_queue_offload_capa_get(dev);
@@ -42,3 +57,286 @@ u64 sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev)
 	return __sxe_tx_port_offload_capa_get(dev);
 }
 
+void sxe_rss_disable(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_hw_rss_cap_switch(hw, false);
+}
+
+void sxe_rss_hash_set(struct sxe_hw *hw,
+				struct rte_eth_rss_conf *rss_conf)
+{
+	u8  *hash_key;
+	u32 rss_key[SXE_MAX_RSS_KEY_ENTRIES];
+	u16 i;
+	u64 rss_hf;
+	u32 rss_field = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	hash_key = rss_conf->rss_key;
+	if (hash_key != NULL) {
+		for (i = 0; i < SXE_MAX_RSS_KEY_ENTRIES; i++) {
+			rss_key[i]  = hash_key[(i * 4)];
+			rss_key[i] |= hash_key[(i * 4) + 1] << 8;
+			rss_key[i] |= hash_key[(i * 4) + 2] << 16;
+			rss_key[i] |= hash_key[(i * 4) + 3] << 24;
+		}
+		sxe_hw_rss_key_set_all(hw, rss_key);
+	}
+
+	rss_hf = rss_conf->rss_hf;
+	if (rss_hf & RTE_ETH_RSS_IPV4)
+		rss_field |= SXE_MRQC_RSS_FIELD_IPV4;
+
+	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP)
+		rss_field |= SXE_MRQC_RSS_FIELD_IPV4_TCP;
+
+	if (rss_hf & RTE_ETH_RSS_IPV6)
+		rss_field |= SXE_MRQC_RSS_FIELD_IPV6;
+
+	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP)
+		rss_field |= SXE_MRQC_RSS_FIELD_IPV6_TCP;
+
+	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP)
+		rss_field |= SXE_MRQC_RSS_FIELD_IPV4_UDP;
+
+	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP)
+		rss_field |= SXE_MRQC_RSS_FIELD_IPV6_UDP;
+
+	sxe_hw_rss_field_set(hw, rss_field);
+
+	sxe_hw_rss_cap_switch(hw, true);
+}
+
+void sxe_rss_configure(struct rte_eth_dev *dev)
+{
+	struct rte_eth_rss_conf *rss_conf;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u16 i;
+	u16 j;
+	u8  rss_indir_tbl[SXE_MAX_RETA_ENTRIES];
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (!adapter->rss_reta_updated) {
+		for (i = 0, j = 0; i < SXE_MAX_RETA_ENTRIES; i++, j++) {
+			if (j == dev->data->nb_rx_queues)
+				j = 0;
+
+			rss_indir_tbl[i] = j;
+		}
+
+		sxe_hw_rss_redir_tbl_set_all(hw, rss_indir_tbl);
+	}
+
+	rss_conf = &dev->data->dev_conf.rx_adv_conf.rss_conf;
+	if ((rss_conf->rss_hf & SXE_RSS_OFFLOAD_ALL) == 0) {
+		PMD_LOG_INFO(INIT, "user rss config match hw supports is 0");
+		sxe_rss_disable(dev);
+		return;
+	}
+
+	if (rss_conf->rss_key == NULL)
+		rss_conf->rss_key = rss_sxe_key;
+
+	sxe_rss_hash_set(hw, rss_conf);
+}
+
+s32 sxe_rss_reta_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_reta_entry64 *reta_conf,
+			u16 reta_size)
+{
+	u16 i;
+	u8 j, mask;
+	u32 reta, r;
+	u16 idx, shift;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct rte_eth_dev_data *dev_data = dev->data;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (!dev_data->dev_started) {
+		PMD_LOG_ERR(DRV,
+			"port %d must be started before rss reta update",
+			 dev_data->port_id);
+		ret = -EIO;
+		goto l_end;
+	}
+
+	if (reta_size != RTE_ETH_RSS_RETA_SIZE_128) {
+		PMD_LOG_ERR(DRV, "The size of hash lookup table configured "
+			"(%d) doesn't match the number hardware can supported "
+			"(%d)", reta_size, RTE_ETH_RSS_RETA_SIZE_128);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (i = 0; i < reta_size; i += SXE_4_BIT_WIDTH) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		mask = (u8)((reta_conf[idx].mask >> shift) &
+						SXE_4_BIT_MASK);
+		if (!mask)
+			continue;
+
+		if (mask == SXE_4_BIT_MASK)
+			r = 0;
+		else
+			r = sxe_hw_rss_redir_tbl_get_by_idx(hw, i);
+
+		for (j = 0, reta = 0; j < SXE_4_BIT_WIDTH; j++) {
+			if (mask & (0x1 << j)) {
+				reta |= reta_conf[idx].reta[shift + j] <<
+						(CHAR_BIT * j);
+			} else {
+				reta |= r & (SXE_8_BIT_MASK <<
+					(CHAR_BIT * j));
+			}
+		}
+
+		sxe_hw_rss_redir_tbl_set_by_idx(hw, i, reta);
+	}
+	adapter->rss_reta_updated = true;
+
+l_end:
+	return ret;
+}
+
+s32 sxe_rss_reta_query(struct rte_eth_dev *dev,
+			 struct rte_eth_rss_reta_entry64 *reta_conf,
+			 u16 reta_size)
+{
+	u16 i;
+	u8 j, mask;
+	u32 reta;
+	u16 idx, shift;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	s32 ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	if (reta_size != RTE_ETH_RSS_RETA_SIZE_128) {
+		PMD_LOG_ERR(DRV, "the size of hash lookup table configured "
+			"(%d) doesn't match the number hardware can supported "
+			"(%d)", reta_size, RTE_ETH_RSS_RETA_SIZE_128);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (i = 0; i < reta_size; i += SXE_4_BIT_WIDTH) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		mask = (u8)((reta_conf[idx].mask >> shift) &
+						SXE_4_BIT_MASK);
+		if (!mask)
+			continue;
+
+		reta = sxe_hw_rss_redir_tbl_get_by_idx(hw, i);
+		for (j = 0; j < SXE_4_BIT_WIDTH; j++) {
+			if (mask & (0x1 << j)) {
+				reta_conf[idx].reta[shift + j] =
+					((reta >> (CHAR_BIT * j)) &
+						SXE_8_BIT_MASK);
+			}
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+s32 sxe_rss_hash_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_conf *rss_conf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u64 rss_hf;
+	s32 ret = 0;
+
+	rss_hf = (rss_conf->rss_hf & SXE_RSS_OFFLOAD_ALL);
+
+	if (!sxe_hw_is_rss_enabled(hw)) {
+		if (rss_hf != 0) {
+			PMD_LOG_ERR(DRV, "rss not init but want set");
+			ret = -EINVAL;
+			goto l_end;
+		}
+
+		goto l_end;
+	}
+
+	if (rss_hf == 0) {
+		PMD_LOG_ERR(DRV, "rss init but want disable it");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	sxe_rss_hash_set(hw, rss_conf);
+
+l_end:
+	return ret;
+}
+
+s32 sxe_rss_hash_conf_get(struct rte_eth_dev *dev,
+				struct rte_eth_rss_conf *rss_conf)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u8 *hash_key;
+	u32 rss_field;
+	u32 rss_key;
+	u64 rss_hf;
+	u16 i;
+
+	hash_key = rss_conf->rss_key;
+	if (hash_key != NULL) {
+		for (i = 0; i < SXE_MAX_RSS_KEY_ENTRIES; i++) {
+			rss_key = sxe_hw_rss_key_get_by_idx(hw, i);
+			hash_key[(i * 4)] = rss_key & 0x000000FF;
+			hash_key[(i * 4) + 1] = (rss_key >> 8) & 0x000000FF;
+			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
+			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
+		}
+	}
+
+
+	if (!sxe_hw_is_rss_enabled(hw)) {
+		rss_conf->rss_hf = 0;
+		PMD_LOG_INFO(DRV, "rss not enabled, return 0");
+		goto l_end;
+	}
+
+	rss_hf = 0;
+	rss_field = sxe_hw_rss_field_get(hw);
+	if (rss_field & SXE_MRQC_RSS_FIELD_IPV4)
+		rss_hf |= RTE_ETH_RSS_IPV4;
+
+	if (rss_field & SXE_MRQC_RSS_FIELD_IPV4_TCP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_TCP;
+
+	if (rss_field & SXE_MRQC_RSS_FIELD_IPV4_UDP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_UDP;
+
+	if (rss_field & SXE_MRQC_RSS_FIELD_IPV6)
+		rss_hf |= RTE_ETH_RSS_IPV6;
+
+	if (rss_field & SXE_MRQC_RSS_FIELD_IPV6_TCP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_TCP;
+
+	if (rss_field & SXE_MRQC_RSS_FIELD_IPV6_UDP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP;
+
+	PMD_LOG_DEBUG(DRV, "got rss hash func=0x%" SXE_PRIX64, rss_hf);
+	rss_conf->rss_hf = rss_hf;
+
+l_end:
+	return 0;
+}
diff --git a/drivers/net/sxe/pf/sxe_offload.h b/drivers/net/sxe/pf/sxe_offload.h
index a70d6bf94b..458b6464c5 100644
--- a/drivers/net/sxe/pf/sxe_offload.h
+++ b/drivers/net/sxe/pf/sxe_offload.h
@@ -7,6 +7,21 @@
 
 #include "sxe_hw.h"
 
+#define SXE_RSS_OFFLOAD_ALL ( \
+		RTE_ETH_RSS_IPV4 | \
+		RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+		RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+		RTE_ETH_RSS_IPV6 | \
+		RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+		RTE_ETH_RSS_NONFRAG_IPV6_UDP)
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_FILTER_CTRL
+u8 *sxe_rss_hash_key_get(void);
+#endif
+
+void sxe_rss_hash_set(struct sxe_hw *hw,
+				struct rte_eth_rss_conf *rss_conf);
+
 u64 sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev);
 
 u64 sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev);
@@ -15,4 +30,22 @@ u64 sxe_tx_queue_offload_capa_get(struct rte_eth_dev *dev);
 
 u64 sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev);
 
+void sxe_rss_disable(struct rte_eth_dev *dev);
+
+void sxe_rss_configure(struct rte_eth_dev *dev);
+
+s32 sxe_rss_reta_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_reta_entry64 *reta_conf,
+			u16 reta_size);
+
+s32 sxe_rss_reta_query(struct rte_eth_dev *dev,
+			 struct rte_eth_rss_reta_entry64 *reta_conf,
+			 u16 reta_size);
+
+s32 sxe_rss_hash_update(struct rte_eth_dev *dev,
+			struct rte_eth_rss_conf *rss_conf);
+
+s32 sxe_rss_hash_conf_get(struct rte_eth_dev *dev,
+				struct rte_eth_rss_conf *rss_conf);
+
 #endif
-- 
2.18.4

