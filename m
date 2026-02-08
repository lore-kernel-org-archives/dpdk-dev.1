Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF72EF06E2
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 11:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D42E406B4;
	Sun,  8 Feb 2026 12:56:33 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 677C840687
 for <dev@dpdk.org>; Sun,  8 Feb 2026 12:56:30 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-05 (Coremail) with SMTP id zQCowAD3hAjreYhpts_KBw--.49177S8;
 Sun, 08 Feb 2026 19:56:28 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v16 07/13] net/sxe: support rss offload
Date: Sun,  8 Feb 2026 19:56:20 +0800
Message-Id: <20260208115626.146863-7-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260208115626.146863-1-liujie5@linkdatatechnology.com>
References: <20260208093122.10329-13-liujie5@linkdatatechnology.com>
 <20260208115626.146863-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: zQCowAD3hAjreYhpts_KBw--.49177S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr4Dtr1ktr43Wr1kKrW8Crg_yoWDuF18pF
 WkG3W8trWftF1Sgw15Aa1UuF13Wr1vka1UKa93J3yfAa1UJF1xJryYya4UKw1rt3sxXr1k
 JFZYqa45GF1kuFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
 IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
 Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0w
 CY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E
 4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
 WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
 Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU55rsUUUUU=
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

Support rss offload.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/base/sxe_offload_common.c |   3 +-
 drivers/net/sxe/pf/sxe_offload.c          | 299 ++++++++++++++++++++++
 drivers/net/sxe/pf/sxe_offload.h          |  33 +++
 3 files changed, 334 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
index f7c7363a2e..4eb4e03a4d 100644
--- a/drivers/net/sxe/base/sxe_offload_common.c
+++ b/drivers/net/sxe/base/sxe_offload_common.c
@@ -27,7 +27,8 @@ u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
 			RTE_ETH_RX_OFFLOAD_KEEP_CRC	|
 			RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
 			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
-			RTE_ETH_RX_OFFLOAD_SCATTER;
+			RTE_ETH_RX_OFFLOAD_SCATTER |
+			RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
 	if (!RTE_ETH_DEV_SRIOV(dev).active)
 		rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TCP_LRO;
diff --git a/drivers/net/sxe/pf/sxe_offload.c b/drivers/net/sxe/pf/sxe_offload.c
index 0fa3f4822a..d34cf7ecc8 100644
--- a/drivers/net/sxe/pf/sxe_offload.c
+++ b/drivers/net/sxe/pf/sxe_offload.c
@@ -9,11 +9,26 @@
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
@@ -35,3 +50,287 @@ u64 sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev)
 {
 	return __sxe_tx_port_offload_capa_get(dev);
 }
+
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
2.18.2

