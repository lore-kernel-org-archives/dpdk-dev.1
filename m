Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917CDCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 08:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAEE640612;
	Tue, 28 Oct 2025 09:47:38 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id EA6E9402F0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:47:36 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59S8lY9d92161706,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1761641255;
 bh=Mw8Y1YBelKdHYsT1jhOFMjJC512xqyb5F188QNJM0zQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=u11OhsHFkjnRfInINvhvpOAKO9gZqMWK9+iVUAXKY/2O4oKRz4rkhccOOOZs841sd
 n6rymQtgUGqNDkJYVJ50XUBfxaLY7Hi4XdxDB+BFRsCkE9jg568a5OXSBXBS65x6K3
 Gwunv2O8mbvty6e8gcXfAsN4gow/0wLMQTfP+r6KqS9c56g9oLrY0ITMPmbv8T2ikm
 xiTJGUuI6BpNW2tasZeHFgCBeVIxMhufpYkNbWTx2KZJVXsM83B2xWuGSEJkHyzA5F
 cUanvgysWfHxlD5ec5ZqA/u+9aP8ARqQPyx2ERmocoYF74TlF3AFxX+XUDEr0qqUrg
 bJ05vGLxb7knw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59S8lY9d92161706
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 28 Oct 2025 16:47:34 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Tue, 28 Oct 2025 16:47:34 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.33 via Frontend
 Transport; Tue, 28 Oct 2025 16:47:34 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 1/3] net/r8169: support multiq for 8126 and 8127
Date: Tue, 28 Oct 2025 16:47:14 +0800
Message-ID: <20251028084716.369128-2-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028084716.369128-1-howard_wang@realsil.com.cn>
References: <20251028084716.369128-1-howard_wang@realsil.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

8126 and 8127 support 4 RX queues and 2 TX queues.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 .mailmap                           |   1 +
 MAINTAINERS                        |   1 +
 doc/guides/nics/features/r8169.ini |   3 +
 doc/guides/nics/r8169.rst          |   2 +
 drivers/net/r8169/r8169_compat.h   |   9 +
 drivers/net/r8169/r8169_ethdev.c   | 187 +++++-
 drivers/net/r8169/r8169_ethdev.h   | 149 ++++-
 drivers/net/r8169/r8169_hw.c       | 139 +++--
 drivers/net/r8169/r8169_hw.h       |   3 +
 drivers/net/r8169/r8169_rxtx.c     | 883 ++++++++++++++++++++---------
 10 files changed, 1061 insertions(+), 316 deletions(-)

diff --git a/.mailmap b/.mailmap
index 10c37a97a6..e5f0cab364 100644
--- a/.mailmap
+++ b/.mailmap
@@ -682,6 +682,7 @@ Jason He <jason.he@broadcom.com>
 Jason Wang <jasowang@redhat.com>
 Jasper Tran O'Leary <jtranoleary@google.com>
 Jasvinder Singh <jasvinder.singh@intel.com>
+Javen Xu <javen_xu@realsil.com.cn>
 Jay Ding <jay.ding@broadcom.com>
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>
 Jay Rolette <rolette@infiniteio.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 5f198bfb66..0279181bd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1035,6 +1035,7 @@ Realtek r8169
 M: Howard Wang <howard_wang@realsil.com.cn>
 M: Chunhao Lin <hau@realtek.com>
 M: Xing Wang <xing_wang@realsil.com.cn>
+M: Javen Xu <javen_xu@realsil.com.cn>
 F: drivers/net/r8169/
 F: doc/guides/nics/r8169.rst
 F: doc/guides/nics/features/r8169.ini
diff --git a/doc/guides/nics/features/r8169.ini b/doc/guides/nics/features/r8169.ini
index 6a91aa2240..3660b5c86e 100644
--- a/doc/guides/nics/features/r8169.ini
+++ b/doc/guides/nics/features/r8169.ini
@@ -13,6 +13,9 @@ Scattered Rx         = Y
 TSO                  = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
 Flow control         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
diff --git a/doc/guides/nics/r8169.rst b/doc/guides/nics/r8169.rst
index 4423ae4ed3..bd9aa6cbdd 100644
--- a/doc/guides/nics/r8169.rst
+++ b/doc/guides/nics/r8169.rst
@@ -31,3 +31,5 @@ Features of the R8169 PMD are:
 
 * Checksum offload
 * Jumbo frames supported
+* RSS (Receive Side Scaling)
+* Multiple queues for TX and RX
diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index e085f6242a..b106105389 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -293,6 +293,15 @@ enum RTL_register_content {
 	RxRUNT = (1UL << 20),
 	RxCRC  = (1UL << 19),
 
+	RxRWT_V3  = (1 << 18),
+	RxRES_V3  = (1 << 20),
+	RxRUNT_V3 = (1 << 19),
+	RxCRC_V3  = (1 << 17),
+
+	RxRES_V4  = (1 << 22),
+	RxRUNT_V4 = (1 << 21),
+	RxCRC_V4  = (1 << 20),
+
 	/* ChipCmd bits */
 	StopReq    = 0x80,
 	CmdReset   = 0x10,
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index 69512ced8b..1f7106a95e 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -47,7 +47,16 @@ static int rtl_allmulticast_disable(struct rte_eth_dev *dev);
 static int rtl_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 static int rtl_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 			      size_t fw_size);
-
+static int rtl_reta_update(struct rte_eth_dev *dev,
+			   struct rte_eth_rss_reta_entry64 *reta_conf,
+			   uint16_t reta_size);
+static int rtl_reta_query(struct rte_eth_dev *dev,
+			  struct rte_eth_rss_reta_entry64 *reta_conf,
+			  uint16_t reta_size);
+static int rtl_rss_hash_update(struct rte_eth_dev *dev,
+			       struct rte_eth_rss_conf *rss_conf);
+static int rtl_rss_hash_conf_get(struct rte_eth_dev *dev,
+				 struct rte_eth_rss_conf *rss_conf);
 /*
  * The set of PCI devices this driver supports
  */
@@ -108,6 +117,11 @@ static const struct eth_dev_ops rtl_eth_dev_ops = {
 	.tx_queue_release     = rtl_tx_queue_release,
 	.tx_done_cleanup      = rtl_tx_done_cleanup,
 	.txq_info_get         = rtl_txq_info_get,
+
+	.reta_update          = rtl_reta_update,
+	.reta_query           = rtl_reta_query,
+	.rss_hash_update      = rtl_rss_hash_update,
+	.rss_hash_conf_get    = rtl_rss_hash_conf_get,
 };
 
 static int
@@ -408,8 +422,13 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_rx_pktlen = JUMBO_FRAME_9K;
 	dev_info->max_mac_addrs = 1;
 
-	dev_info->max_rx_queues = 1;
-	dev_info->max_tx_queues = 1;
+	if (hw->mcfg >= CFG_METHOD_69) {
+		dev_info->max_rx_queues = 4;
+		dev_info->max_tx_queues = 2;
+	} else {
+		dev_info->max_rx_queues = 1;
+		dev_info->max_tx_queues = 1;
+	}
 
 	dev_info->default_rxconf = (struct rte_eth_rxconf) {
 		.rx_free_thresh = RTL_RX_FREE_THRESH,
@@ -445,10 +464,14 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 	dev_info->max_mtu = dev_info->max_rx_pktlen - RTL_ETH_OVERHEAD;
 
-	dev_info->rx_offload_capa = (rtl_get_rx_port_offloads() |
+	dev_info->rx_offload_capa = (rtl_get_rx_port_offloads(hw) |
 				     dev_info->rx_queue_offload_capa);
 	dev_info->tx_offload_capa = rtl_get_tx_port_offloads();
 
+	dev_info->hash_key_size = RTL_RSS_KEY_SIZE;
+	dev_info->reta_size = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
+	dev_info->flow_type_rss_offloads = RTL_RSS_CTRL_OFFLOAD_ALL;
+
 	return 0;
 }
 
@@ -535,7 +558,7 @@ rtl_sw_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
 
 static int
 rtl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
-		struct eth_queue_stats *qstats __rte_unused)
+		  struct eth_queue_stats *qstats __rte_unused)
 {
 	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
 	struct rtl_hw *hw = &adapter->hw;
@@ -709,6 +732,160 @@ rtl_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 		return 0;
 }
 
+static int
+rtl_reta_update(struct rte_eth_dev *dev,
+		struct rte_eth_rss_reta_entry64 *reta_conf, uint16_t reta_size)
+{
+	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
+	struct rtl_hw *hw = &adapter->hw;
+	u32 reta;
+	u16 idx, shift;
+	u8 mask, rss_indir_tbl;
+	int i, j;
+
+	if (reta_size != RTL_MAX_INDIRECTION_TABLE_ENTRIES) {
+		PMD_DRV_LOG(ERR, "The size of hash lookup table configured "
+			"(%d) doesn't match the number hardware can supported "
+			"(%d)", reta_size, RTL_MAX_INDIRECTION_TABLE_ENTRIES);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < reta_size; i += 4) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+		mask = (reta_conf[idx].mask >> shift) & 0xf;
+
+		if (!mask)
+			continue;
+
+		for (j = 0, reta = 0; j < 4; j++) {
+			rss_indir_tbl = (u8)reta_conf[idx].reta[shift + j];
+			reta |= rss_indir_tbl << (j * 8);
+
+			if (!(mask & (1 << j)))
+				continue;
+
+			hw->rss_indir_tbl[i + j] = rss_indir_tbl;
+		}
+
+		RTL_W32(hw, RSS_INDIRECTION_TBL_8125_V2 + i, reta);
+	}
+
+	return 0;
+}
+
+static int
+rtl_reta_query(struct rte_eth_dev *dev,
+	       struct rte_eth_rss_reta_entry64 *reta_conf, uint16_t reta_size)
+{
+	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
+	struct rtl_hw *hw = &adapter->hw;
+	u16 idx, shift;
+	int i;
+
+	if (reta_size != RTL_MAX_INDIRECTION_TABLE_ENTRIES) {
+		PMD_DRV_LOG(ERR, "The size of hash lookup table configured "
+			"(%d) doesn't match the number hardware can supported "
+			"(%d)", reta_size, RTL_MAX_INDIRECTION_TABLE_ENTRIES);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < reta_size; i++) {
+		idx = i / RTE_ETH_RETA_GROUP_SIZE;
+		shift = i % RTE_ETH_RETA_GROUP_SIZE;
+
+		if (reta_conf[idx].mask & (1ULL << shift))
+			reta_conf[idx].reta[shift] = hw->rss_indir_tbl[i];
+	}
+
+	return 0;
+}
+
+static int
+rtl_rss_hash_update(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
+{
+	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
+	struct rtl_hw *hw = &adapter->hw;
+	u32 rss_ctrl_8125;
+
+	if (!hw->EnableRss || !(rss_conf->rss_hf & RTL_RSS_OFFLOAD_ALL))
+		return -EINVAL;
+
+	if (rss_conf->rss_key)
+		memcpy(hw->rss_key, rss_conf->rss_key, RTL_RSS_KEY_SIZE);
+
+	rtl8125_store_rss_key(hw);
+
+	rss_ctrl_8125 = RTL_R32(hw, RSS_CTRL_8125) & ~RTL_RSS_CTRL_OFFLOAD_ALL;
+
+	if (rss_conf->rss_hf & RTE_ETH_RSS_IPV4)
+		rss_ctrl_8125 |= RSS_CTRL_IPV4_SUPP;
+	if (rss_conf->rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP)
+		rss_ctrl_8125 |= RSS_CTRL_TCP_IPV4_SUPP;
+	if (rss_conf->rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP)
+		rss_ctrl_8125 |= RSS_CTRL_TCP_IPV6_SUPP;
+	if (rss_conf->rss_hf & RTE_ETH_RSS_IPV6)
+		rss_ctrl_8125 |= RSS_CTRL_IPV6_SUPP;
+	if (rss_conf->rss_hf & RTE_ETH_RSS_IPV6_EX)
+		rss_ctrl_8125 |= RSS_CTRL_IPV6_EXT_SUPP;
+	if (rss_conf->rss_hf & RTE_ETH_RSS_IPV6_TCP_EX)
+		rss_ctrl_8125 |= RSS_CTRL_TCP_IPV6_EXT_SUPP;
+	if (rss_conf->rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP)
+		rss_ctrl_8125 |= RSS_CTRL_UDP_IPV4_SUPP;
+	if (rss_conf->rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP)
+		rss_ctrl_8125 |= RSS_CTRL_UDP_IPV6_SUPP;
+	if (rss_conf->rss_hf & RTE_ETH_RSS_IPV6_UDP_EX)
+		rss_ctrl_8125 |= RSS_CTRL_UDP_IPV6_EXT_SUPP;
+
+	RTL_W32(hw, RSS_CTRL_8125, rss_ctrl_8125);
+
+	return 0;
+}
+
+static int
+rtl_rss_hash_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf)
+{
+	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
+	struct rtl_hw *hw = &adapter->hw;
+	u64 rss_hf = 0;
+	u32 rss_ctrl_8125;
+
+	if (!hw->EnableRss) {
+		rss_conf->rss_hf = rss_hf;
+		return 0;
+	}
+
+	if (rss_conf->rss_key) {
+		rss_conf->rss_key_len = RTL_RSS_KEY_SIZE;
+		memcpy(rss_conf->rss_key, hw->rss_key, RTL_RSS_KEY_SIZE);
+	}
+
+	rss_ctrl_8125 = RTL_R32(hw, RSS_CTRL_8125);
+
+	if (rss_ctrl_8125 & RSS_CTRL_IPV4_SUPP)
+		rss_hf |= RTE_ETH_RSS_IPV4;
+	if (rss_ctrl_8125 & RSS_CTRL_TCP_IPV4_SUPP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_TCP;
+	if (rss_ctrl_8125 & RSS_CTRL_TCP_IPV6_SUPP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_TCP;
+	if (rss_ctrl_8125 & RSS_CTRL_IPV6_SUPP)
+		rss_hf |= RTE_ETH_RSS_IPV6;
+	if (rss_ctrl_8125 & RSS_CTRL_IPV6_EXT_SUPP)
+		rss_hf |= RTE_ETH_RSS_IPV6_EX;
+	if (rss_ctrl_8125 & RSS_CTRL_TCP_IPV6_EXT_SUPP)
+		rss_hf |= RTE_ETH_RSS_IPV6_TCP_EX;
+	if (rss_ctrl_8125 & RSS_CTRL_UDP_IPV4_SUPP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_UDP;
+	if (rss_ctrl_8125 & RSS_CTRL_UDP_IPV6_SUPP)
+		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP;
+	if (rss_ctrl_8125 & RSS_CTRL_UDP_IPV6_EXT_SUPP)
+		rss_hf |= RTE_ETH_RSS_IPV6_UDP_EX;
+
+	rss_conf->rss_hf = rss_hf;
+
+	return 0;
+}
+
 static int
 rtl_dev_init(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/r8169/r8169_ethdev.h b/drivers/net/r8169/r8169_ethdev.h
index 84a233dfed..a7604df6c2 100644
--- a/drivers/net/r8169/r8169_ethdev.h
+++ b/drivers/net/r8169/r8169_ethdev.h
@@ -32,6 +32,49 @@ enum rtl_fc_mode {
 	rtl_fc_default
 };
 
+enum rtl_rss_register_content {
+	/* RSS */
+	RSS_CTRL_TCP_IPV4_SUPP     = (1 << 0),
+	RSS_CTRL_IPV4_SUPP         = (1 << 1),
+	RSS_CTRL_TCP_IPV6_SUPP     = (1 << 2),
+	RSS_CTRL_IPV6_SUPP         = (1 << 3),
+	RSS_CTRL_IPV6_EXT_SUPP     = (1 << 4),
+	RSS_CTRL_TCP_IPV6_EXT_SUPP = (1 << 5),
+	RSS_HALF_SUPP              = (1 << 7),
+	RSS_CTRL_UDP_IPV4_SUPP     = (1 << 11),
+	RSS_CTRL_UDP_IPV6_SUPP     = (1 << 12),
+	RSS_CTRL_UDP_IPV6_EXT_SUPP = (1 << 13),
+	RSS_QUAD_CPU_EN            = (1 << 16),
+	RSS_HQ_Q_SUP_R             = (1 << 31),
+};
+
+#define RTL_RSS_OFFLOAD_ALL ( \
+	RTE_ETH_RSS_IPV4 | \
+	RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+	RTE_ETH_RSS_IPV6 | \
+	RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
+	RTE_ETH_RSS_IPV6_EX | \
+	RTE_ETH_RSS_IPV6_TCP_EX | \
+	RTE_ETH_RSS_IPV6_UDP_EX)
+
+#define RTL_RSS_CTRL_OFFLOAD_ALL ( \
+	RSS_CTRL_TCP_IPV4_SUPP | \
+	RSS_CTRL_IPV4_SUPP | \
+	RSS_CTRL_TCP_IPV6_SUPP | \
+	RSS_CTRL_IPV6_SUPP | \
+	RSS_CTRL_IPV6_EXT_SUPP | \
+	RSS_CTRL_TCP_IPV6_EXT_SUPP | \
+	RSS_CTRL_UDP_IPV4_SUPP | \
+	RSS_CTRL_UDP_IPV6_SUPP | \
+	RSS_CTRL_UDP_IPV6_EXT_SUPP)
+
+#define RTL_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
+#define RTL_MAX_INDIRECTION_TABLE_ENTRIES RTE_ETH_RSS_RETA_SIZE_128
+#define RSS_MASK_BITS_OFFSET 8
+#define RSS_CPU_NUM_OFFSET   16
+
 struct rtl_hw {
 	struct rtl_hw_ops hw_ops;
 	u8  *mmio_addr;
@@ -77,11 +120,7 @@ struct rtl_hw {
 	/* Enable Tx No Close */
 	u8  HwSuppTxNoCloseVer;
 	u8  EnableTxNoClose;
-	u16 hw_clo_ptr_reg;
-	u16 sw_tail_ptr_reg;
 	u32 MaxTxDescPtrMask;
-	u32 NextHwDesCloPtr0;
-	u32 BeginHwDesCloPtr0;
 
 	/* Dash */
 	u8 HwSuppDashVer;
@@ -93,6 +132,13 @@ struct rtl_hw {
 
 	/* Fiber */
 	u32 HwFiberModeVer;
+
+	/* Multi queue*/
+	u8 EnableRss;
+	u8 HwSuppRxDescType;
+	u16 RxDescLength;
+	u8 rss_key[RTL_RSS_KEY_SIZE];
+	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
 };
 
 struct rtl_sw_stats {
@@ -109,6 +155,93 @@ struct rtl_adapter {
 	struct rtl_sw_stats sw_stats;
 };
 
+/* Struct RxDesc in kernel r8169 */
+struct rtl_rx_desc {
+	u32 opts1;
+	u32 opts2;
+	u64 addr;
+};
+
+struct rtl_rx_descv3 {
+	union {
+		struct {
+			u32 rsv1;
+			u32 rsv2;
+		} RxDescDDWord1;
+	};
+
+	union {
+		struct {
+			u32 RSSResult;
+			u16 HeaderBufferLen;
+			u16 HeaderInfo;
+		} RxDescNormalDDWord2;
+
+		struct {
+			u32 rsv5;
+			u32 rsv6;
+		} RxDescDDWord2;
+	};
+
+	union {
+		u64   addr;
+
+		struct {
+			u32 TimeStampLow;
+			u32 TimeStampHigh;
+		} RxDescTimeStamp;
+
+		struct {
+			u32 rsv8;
+			u32 rsv9;
+		} RxDescDDWord3;
+	};
+
+	union {
+		struct {
+			u32 opts2;
+			u32 opts1;
+		} RxDescNormalDDWord4;
+
+		struct {
+			u16 TimeStampHHigh;
+			u16 rsv11;
+			u32 opts1;
+		} RxDescPTPDDWord4;
+	};
+};
+
+struct rtl_rx_descv4 {
+	union {
+		u64   addr;
+
+		struct {
+			u32 RSSInfo;
+			u32 RSSResult;
+		} RxDescNormalDDWord1;
+	};
+
+	struct {
+		u32 opts2;
+		u32 opts1;
+	} RxDescNormalDDWord2;
+};
+
+enum rx_desc_ring_type {
+	RX_DESC_RING_TYPE_UNKNOWN = 0,
+	RX_DESC_RING_TYPE_1,
+	RX_DESC_RING_TYPE_2,
+	RX_DESC_RING_TYPE_3,
+	RX_DESC_RING_TYPE_4,
+	RX_DESC_RING_TYPE_MAX
+};
+
+enum rx_desc_len {
+	RX_DESC_LEN_TYPE_1 = (sizeof(struct rtl_rx_desc)),
+	RX_DESC_LEN_TYPE_3 = (sizeof(struct rtl_rx_descv3)),
+	RX_DESC_LEN_TYPE_4 = (sizeof(struct rtl_rx_descv4))
+};
+
 #define RTL_DEV_PRIVATE(eth_dev) \
 	((struct rtl_adapter *)((eth_dev)->data->dev_private))
 
@@ -149,7 +282,7 @@ void rtl_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 void rtl_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 		      struct rte_eth_txq_info *qinfo);
 
-uint64_t rtl_get_rx_port_offloads(void);
+uint64_t rtl_get_rx_port_offloads(struct rtl_hw *hw);
 uint64_t rtl_get_tx_port_offloads(void);
 
 int rtl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
@@ -165,4 +298,10 @@ int rtl_tx_done_cleanup(void *tx_queue, uint32_t free_cnt);
 int rtl_stop_queues(struct rte_eth_dev *dev);
 void rtl_free_queues(struct rte_eth_dev *dev);
 
+static inline struct rtl_rx_desc*
+rtl_get_rxdesc(struct rtl_hw *hw, struct rtl_rx_desc *base, u32 const number)
+{
+	return (struct rtl_rx_desc *)((u8 *)base + hw->RxDescLength * number);
+}
+
 #endif /* R8169_ETHDEV_H */
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index e25336ac19..cb0fadf193 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -929,6 +929,88 @@ rtl8125_hw_clear_int_miti(struct rtl_hw *hw)
 	}
 }
 
+static void
+rtl8125_set_rss_hash_opt(struct rtl_hw *hw, u16 nb_rx_queues)
+{
+	u32 hash_mask_len;
+	u32 rss_ctrl;
+
+	rss_ctrl = rte_log2_u32(nb_rx_queues);
+	rss_ctrl &= (BIT_0 | BIT_1 | BIT_2);
+	rss_ctrl <<= RSS_CPU_NUM_OFFSET;
+
+	/* Perform hash on these packet types */
+	rss_ctrl |= RTL_RSS_CTRL_OFFLOAD_ALL;
+
+	hash_mask_len = rte_log2_u32(RTL_MAX_INDIRECTION_TABLE_ENTRIES);
+	hash_mask_len &= (BIT_0 | BIT_1 | BIT_2);
+	rss_ctrl |= hash_mask_len << RSS_MASK_BITS_OFFSET;
+
+	RTL_W32(hw, RSS_CTRL_8125, rss_ctrl);
+}
+
+static void
+rtl8125_store_reta(struct rtl_hw *hw)
+{
+	u32 reta;
+	int i;
+
+	for (i = 0; i < RTL_MAX_INDIRECTION_TABLE_ENTRIES; i += 4) {
+		reta = hw->rss_indir_tbl[i];
+		reta |= hw->rss_indir_tbl[i + 1] << 8;
+		reta |= hw->rss_indir_tbl[i + 2] << 16;
+		reta |= hw->rss_indir_tbl[i + 3] << 24;
+		RTL_W32(hw, RSS_INDIRECTION_TBL_8125_V2 + i, reta);
+	}
+}
+
+void
+rtl8125_store_rss_key(struct rtl_hw *hw)
+{
+	u32 rss_key;
+	int i;
+
+	for (i = 0; i < RTL_RSS_KEY_SIZE; i += 4) {
+		rss_key = hw->rss_key[i];
+		rss_key |= hw->rss_key[i + 1] << 8;
+		rss_key |= hw->rss_key[i + 2] << 16;
+		rss_key |= hw->rss_key[i + 3] << 24;
+		RTL_W32(hw, RSS_KEY_8125 + i, rss_key);
+	}
+}
+
+void
+rtl8125_config_rss(struct rtl_hw *hw, u16 nb_rx_queues)
+{
+	rtl8125_set_rss_hash_opt(hw, nb_rx_queues);
+
+	rtl8125_store_reta(hw);
+
+	rtl8125_store_rss_key(hw);
+}
+
+static void
+rtl8125_set_rx_desc_type(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_58:
+		RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~EnableRxDescV4_0);
+		break;
+	case CFG_METHOD_69:
+		RTL_W32(hw, RxConfig, EnableRxDescV3 | RTL_R32(hw, RxConfig));
+		break;
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+	case CFG_METHOD_91:
+		RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) | EnableRxDescV4_0);
+		break;
+	}
+}
+
 static void
 rtl8125_hw_config(struct rtl_hw *hw)
 {
@@ -973,12 +1055,6 @@ rtl8125_hw_config(struct rtl_hw *hw)
 		break;
 	}
 
-	/* RSS_control_0 */
-	RTL_W32(hw, RSS_CTRL_8125, 0x00);
-
-	/* VMQ_control */
-	RTL_W16(hw, Q_NUM_CTRL_8125, 0x0000);
-
 	/* Disable speed down */
 	RTL_W8(hw, Config1, RTL_R8(hw, Config1) & ~0x10);
 
@@ -1002,18 +1078,7 @@ rtl8125_hw_config(struct rtl_hw *hw)
 			RTL_W8(hw, 0x20E4, RTL_R8(hw, 0x20E4) & ~BIT_2);
 	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-	case CFG_METHOD_56:
-	case CFG_METHOD_57:
-	case CFG_METHOD_58:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
-		RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~EnableRxDescV4_0);
-		break;
-	}
+	rtl8125_set_rx_desc_type(hw);
 
 	if (hw->mcfg == CFG_METHOD_58 || hw->mcfg == CFG_METHOD_91) {
 		rtl_clear_mac_ocp_bit(hw, 0xE00C, BIT_12);
@@ -1844,22 +1909,6 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	if (hw->HwSuppTxNoCloseVer > 0 && tx_no_close_enable == 1)
 		hw->EnableTxNoClose = TRUE;
 
-	switch (hw->HwSuppTxNoCloseVer) {
-	case 4:
-	case 5:
-		hw->hw_clo_ptr_reg = HW_CLO_PTR0_8126;
-		hw->sw_tail_ptr_reg = SW_TAIL_PTR0_8126;
-		break;
-	case 6:
-		hw->hw_clo_ptr_reg = HW_CLO_PTR0_8125BP;
-		hw->sw_tail_ptr_reg = SW_TAIL_PTR0_8125BP;
-		break;
-	default:
-		hw->hw_clo_ptr_reg = HW_CLO_PTR0_8125;
-		hw->sw_tail_ptr_reg = SW_TAIL_PTR0_8125;
-		break;
-	}
-
 	switch (hw->mcfg) {
 	case CFG_METHOD_21:
 	case CFG_METHOD_22:
@@ -1950,6 +1999,11 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		hw->mcu_pme_setting = rtl_mac_ocp_read(hw, 0xE00A);
 	}
 
+	if (hw->mcfg >= CFG_METHOD_69)
+		hw->EnableRss = 1;
+	else
+		hw->EnableRss = 0;
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_49:
 	case CFG_METHOD_52:
@@ -1985,6 +2039,23 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		break;
 	}
 
+	switch (hw->mcfg) {
+	case CFG_METHOD_69:
+		hw->HwSuppRxDescType = RX_DESC_RING_TYPE_3;
+		hw->RxDescLength = RX_DESC_LEN_TYPE_3;
+		break;
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+	case CFG_METHOD_91:
+		hw->HwSuppRxDescType = RX_DESC_RING_TYPE_4;
+		hw->RxDescLength = RX_DESC_LEN_TYPE_4;
+		break;
+	default:
+		hw->HwSuppRxDescType = RX_DESC_RING_TYPE_1;
+		hw->RxDescLength = RX_DESC_LEN_TYPE_1;
+		break;
+	}
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_91:
 		tmp = (u8)rtl_mac_ocp_read(hw, 0xD006);
diff --git a/drivers/net/r8169/r8169_hw.h b/drivers/net/r8169/r8169_hw.h
index ffd2914b10..e1fe238b85 100644
--- a/drivers/net/r8169/r8169_hw.h
+++ b/drivers/net/r8169/r8169_hw.h
@@ -79,6 +79,9 @@ void rtl8168_set_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
 u64 rtl_get_hw_mcu_patch_code_ver(struct rtl_hw *hw);
 u64 rtl_get_bin_mcu_patch_code_ver(const u16 *entry, u16 entry_cnt);
 
+void rtl8125_store_rss_key(struct rtl_hw *hw);
+void rtl8125_config_rss(struct rtl_hw *hw, u16 nb_rx_queues);
+
 extern const struct rtl_hw_ops rtl8168g_ops;
 extern const struct rtl_hw_ops rtl8168h_ops;
 extern const struct rtl_hw_ops rtl8168ep_ops;
diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 7bb2ab9cee..94ae5f8212 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -36,6 +36,8 @@
 #define MIN_PATCH_LENGTH 47
 #define ETH_ZLEN	 60		/* Min. octets in frame sans FCS */
 
+#define QUEUE_NUM_LIMIT 128
+
 /* Struct TxDesc in kernel r8169 */
 struct rtl_tx_desc {
 	RTE_ATOMIC(u32) opts1;
@@ -43,13 +45,6 @@ struct rtl_tx_desc {
 	u64 addr;
 };
 
-/* Struct RxDesc in kernel r8169 */
-struct rtl_rx_desc {
-	u32 opts1;
-	u32 opts2;
-	u64 addr;
-};
-
 /* Structure associated with each descriptor of the TX ring of a TX queue. */
 struct rtl_tx_entry {
 	struct rte_mbuf *mbuf;
@@ -73,6 +68,10 @@ struct rtl_tx_queue {
 	uint16_t	     port_id;
 	uint16_t	     tx_free_thresh;
 	uint16_t	     tx_free;
+	uint16_t	     hw_clo_ptr_reg;
+	uint16_t	     sw_tail_ptr_reg;
+	uint32_t	     NextHwDesCloPtr;
+	uint32_t	     BeginHwDesCloPtr;
 };
 
 /* Structure associated with each RX queue. */
@@ -99,10 +98,15 @@ enum _DescStatusBit {
 	FirstFrag   = (1 << 29), /* First segment of a packet */
 	LastFrag    = (1 << 28), /* Final segment of a packet */
 
-	DescOwn_V3  = DescOwn, /* Descriptor is owned by NIC. */
-	RingEnd_V3  = RingEnd, /* End of descriptor ring */
+	DescOwn_V3   = DescOwn, /* Descriptor is owned by NIC. */
+	RingEnd_V3   = RingEnd, /* End of descriptor ring */
 	FirstFrag_V3 = (1 << 25), /* First segment of a packet */
-	LastFrag_V3 = (1 << 24), /* Final segment of a packet */
+	LastFrag_V3  = (1 << 24), /* Final segment of a packet */
+
+	DescOwn_V4   = DescOwn, /* Descriptor is owned by NIC */
+	RingEnd_V4   = RingEnd, /* End of descriptor ring */
+	FirstFrag_V4 = FirstFrag, /* First segment of a packet */
+	LastFrag_V4  = LastFrag, /* Final segment of a packet */
 
 	/* TX private */
 	/*------ offset 0 of TX descriptor ------*/
@@ -172,7 +176,24 @@ enum _DescStatusBit {
 	/*@@@@@@ offset 4 of RX descriptor => bits for RTL8169 only     begin @@@@@@*/
 	RxV6F_v3       = RxV6F,
 	RxV4F_v3       = RxV4F,
+
 	/*@@@@@@ offset 4 of RX descriptor => bits for RTL8169 only     end @@@@@@*/
+	RxIPF_v4       = (1 << 17), /* IP checksum failed */
+	RxUDPF_v4      = (1 << 16), /* UDP/IP checksum failed */
+	RxTCPF_v4      = (1 << 15), /* TCP/IP checksum failed */
+	RxSCTPF_v4     = (1 << 19), /* SCTP checksum failed */
+	RxVlanTag_v4   = RxVlanTag, /* VLAN tag available */
+
+	/*@@@@@@ offset 0 of rx descriptor => bits for RTL8125 only     begin @@@@@@*/
+	RxUDPT_v4      = (1 << 19),
+	RxTCPT_v4      = (1 << 18),
+	RxSCTP_v4      = (1 << 19),
+	/*@@@@@@ offset 0 of rx descriptor => bits for RTL8125 only     end @@@@@@*/
+
+	/*@@@@@@ offset 4 of rx descriptor => bits for RTL8125 only     begin @@@@@@*/
+	RxV6F_v4       = RxV6F,
+	RxV4F_v4       = RxV4F,
+	/*@@@@@@ offset 4 of rx descriptor => bits for RTL8125 only     end @@@@@@*/
 };
 
 #define GTTCPHO_SHIFT  18
@@ -183,7 +204,7 @@ enum _DescStatusBit {
 #define LSOPKTSIZE_MAX 0xffffU
 #define MSS_MAX        0x07ffu /* MSS value */
 
-typedef void (*rtl_clear_rdu_func)(struct rtl_hw *);
+typedef void (*rtl_clear_rdu_func)(struct rtl_hw *, uint16_t);
 static rtl_clear_rdu_func rtl_clear_rdu;
 
 /* ---------------------------------RX---------------------------------- */
@@ -237,23 +258,59 @@ rtl_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	qinfo->conf.offloads = rxq->offloads;
 }
 
+static void
+rtl_mark_as_last_descriptor_v1(struct rtl_rx_desc *desc)
+{
+	desc->opts1 |= rte_cpu_to_le_32(RingEnd);
+}
+
+static void
+rtl_mark_as_last_descriptor_v3(struct rtl_rx_descv3 *descv3)
+{
+	descv3->RxDescNormalDDWord4.opts1 |= rte_cpu_to_le_32(RingEnd);
+}
+
+static void
+rtl_mark_as_last_descriptor_v4(struct rtl_rx_descv4 *descv4)
+{
+	descv4->RxDescNormalDDWord2.opts1 |= rte_cpu_to_le_32(RingEnd);
+}
+
+static void
+rtl_mark_as_last_descriptor(struct rtl_hw *hw, struct rtl_rx_desc *desc)
+{
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		rtl_mark_as_last_descriptor_v3((struct rtl_rx_descv3 *)desc);
+		break;
+	case RX_DESC_RING_TYPE_4:
+		rtl_mark_as_last_descriptor_v4((struct rtl_rx_descv4 *)desc);
+		break;
+	default:
+		rtl_mark_as_last_descriptor_v1(desc);
+		break;
+	}
+}
+
 static void
 rtl_reset_rx_queue(struct rtl_rx_queue *rxq)
 {
-	static const struct rtl_rx_desc zero_rxd = {0};
+	struct rtl_hw *hw = rxq->hw;
 	int i;
 
 	for (i = 0; i < rxq->nb_rx_desc; i++)
-		rxq->hw_ring[i] = zero_rxd;
+		memset(rxq->hw_ring, 0, hw->RxDescLength * rxq->nb_rx_desc);
+
+	rtl_mark_as_last_descriptor(hw, rtl_get_rxdesc(hw, rxq->hw_ring,
+						       rxq->nb_rx_desc - 1));
 
-	rxq->hw_ring[rxq->nb_rx_desc - 1].opts1 = rte_cpu_to_le_32(RingEnd);
 	rxq->rx_tail = 0;
 	rxq->pkt_first_seg = NULL;
 	rxq->pkt_last_seg = NULL;
 }
 
 uint64_t
-rtl_get_rx_port_offloads(void)
+rtl_get_rx_port_offloads(struct rtl_hw *hw)
 {
 	uint64_t offloads;
 
@@ -263,6 +320,9 @@ rtl_get_rx_port_offloads(void)
 		   RTE_ETH_RX_OFFLOAD_SCATTER     |
 		   RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
+	if (hw->EnableRss)
+		offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
+
 	return offloads;
 }
 
@@ -323,7 +383,7 @@ rtl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	 * handle the maximum ring size is allocated in order to allow for
 	 * resizing in later calls to the queue setup function.
 	 */
-	size = sizeof(struct rtl_rx_desc) * (nb_rx_desc + 1);
+	size = hw->RxDescLength * (nb_rx_desc + 1);
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, size,
 				      RTL_RING_ALIGN, socket_id);
 	if (mz == NULL) {
@@ -346,17 +406,86 @@ rtl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 }
 
+static inline void
+rtl_set_desc_dma_addr(struct rtl_hw *hw, struct rtl_rx_desc *desc,
+		      uint64_t dma_addr)
+{
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		((struct rtl_rx_descv3 *)desc)->addr = dma_addr;
+		break;
+	case RX_DESC_RING_TYPE_4:
+		((struct rtl_rx_descv4 *)desc)->addr = dma_addr;
+		break;
+	default:
+		desc->addr = dma_addr;
+		break;
+	}
+}
+
+static inline void
+rtl_mark_to_asic_v1(struct rtl_rx_desc *desc, u32 rx_buf_sz)
+{
+	u32 eor = rte_le_to_cpu_32(desc->opts1) & RingEnd;
+
+	desc->opts2 = 0;
+	rte_wmb();
+	desc->opts1 = rte_cpu_to_le_32(DescOwn | eor | rx_buf_sz);
+}
+
+static inline void
+rtl_mark_to_asic_v3(struct rtl_rx_descv3 *descv3, u32 rx_buf_sz)
+{
+	u32 eor = rte_le_to_cpu_32(descv3->RxDescNormalDDWord4.opts1) & RingEnd;
+
+	descv3->RxDescNormalDDWord4.opts2 = 0;
+	rte_wmb();
+	descv3->RxDescNormalDDWord4.opts1 = rte_cpu_to_le_32(DescOwn | eor |
+							     rx_buf_sz);
+}
+
+static inline void
+rtl_mark_to_asic_v4(struct rtl_rx_descv4 *descv4, u32 rx_buf_sz)
+{
+	u32 eor = rte_le_to_cpu_32(descv4->RxDescNormalDDWord2.opts1) & RingEnd;
+
+	descv4->RxDescNormalDDWord2.opts2 = 0;
+	rte_wmb();
+	descv4->RxDescNormalDDWord2.opts1 = rte_cpu_to_le_32(DescOwn | eor |
+							     rx_buf_sz);
+}
+
+static inline void
+rtl_mark_to_asic(struct rtl_hw *hw, struct rtl_rx_desc *desc)
+{
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		rtl_mark_to_asic_v3((struct rtl_rx_descv3 *)desc, hw->rx_buf_sz);
+		break;
+	case RX_DESC_RING_TYPE_4:
+		rtl_mark_to_asic_v4((struct rtl_rx_descv4 *)desc, hw->rx_buf_sz);
+		break;
+	default:
+		rtl_mark_to_asic_v1(desc, hw->rx_buf_sz);
+		break;
+	}
+}
+
+static inline void
+rtl_map_to_asic(struct rtl_hw *hw, struct rtl_rx_desc *desc, uint64_t dma_addr)
+{
+	rtl_set_desc_dma_addr(hw, desc, dma_addr);
+	rtl_mark_to_asic(hw, desc);
+}
+
 static int
 rtl_alloc_rx_queue_mbufs(struct rtl_rx_queue *rxq)
 {
 	struct rtl_rx_entry *rxe = rxq->sw_ring;
 	struct rtl_hw *hw = rxq->hw;
-	struct rtl_rx_desc *rxd;
 	int i;
 	uint64_t dma_addr;
 
-	rxd = &rxq->hw_ring[0];
-
 	/* Initialize software ring entries */
 	for (i = 0; i < rxq->nb_rx_desc; i++) {
 		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
@@ -369,16 +498,12 @@ rtl_alloc_rx_queue_mbufs(struct rtl_rx_queue *rxq)
 
 		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
 
-		rxd = &rxq->hw_ring[i];
-		rxd->addr = dma_addr;
-		rxd->opts2 = 0;
-		rte_wmb();
-		rxd->opts1 = rte_cpu_to_le_32(DescOwn | hw->rx_buf_sz);
+		rtl_map_to_asic(hw, rtl_get_rxdesc(hw, rxq->hw_ring, i),
+				dma_addr);
 		rxe[i].mbuf = mbuf;
 	}
 
-	/* Mark as last desc */
-	rxd->opts1 |= rte_cpu_to_le_32(RingEnd);
+	rtl_mark_as_last_descriptor(hw, rtl_get_rxdesc(hw, rxq->hw_ring, i));
 
 	return 0;
 }
@@ -448,41 +573,95 @@ rtl_hw_set_rx_packet_filter(struct rtl_hw *hw)
 }
 
 static void
-rtl8125_clear_rdu(struct rtl_hw *hw)
+rtl8125_clear_rdu(struct rtl_hw *hw, uint16_t queue_id)
 {
-	RTL_W32(hw, ISR0_8125, (RxOK | RxErr | RxDescUnavail));
+	if (queue_id == 0)
+		RTL_W32(hw, ISR0_8125, (RxOK | RxErr | RxDescUnavail));
+	else
+		RTL_W8(hw, ISR1_8125 + (queue_id - 1) * 4, (BIT_0 | BIT_1));
 }
 
 static void
-rtl8168_clear_rdu(struct rtl_hw *hw)
+rtl8168_clear_rdu(struct rtl_hw *hw, uint16_t queue_id __rte_unused)
 {
 	RTL_W16(hw, IntrStatus, (RxOK | RxErr | RxDescUnavail));
 }
 
+static void
+rtl_init_rss(struct rtl_hw *hw, u16 nb_rx_queues)
+{
+	u64 rand;
+	int i;
+
+	for (i = 0; i < RTL_MAX_INDIRECTION_TABLE_ENTRIES; i++)
+		hw->rss_indir_tbl[i] = i & (nb_rx_queues - 1);
+
+	for (i = 0; i < RTL_RSS_KEY_SIZE; i += sizeof(u64)) {
+		rand = rte_rand();
+		memcpy(&hw->rss_key[i], &rand, sizeof(u64));
+	}
+}
+
+static void
+rtl8125_set_rx_q_num(struct rtl_hw *hw, unsigned int num_rx_queues)
+{
+	u16 q_ctrl;
+	u16 rx_q_num;
+
+	rx_q_num = (u16)rte_log2_u32(num_rx_queues);
+	rx_q_num &= (BIT_0 | BIT_1 | BIT_2);
+	rx_q_num <<= 2;
+	q_ctrl = RTL_R16(hw, Q_NUM_CTRL_8125);
+	q_ctrl &= ~(BIT_2 | BIT_3 | BIT_4);
+	q_ctrl |= rx_q_num;
+	RTL_W16(hw, Q_NUM_CTRL_8125, q_ctrl);
+}
+
 int
 rtl_rx_init(struct rte_eth_dev *dev)
 {
 	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
 	struct rtl_hw *hw = &adapter->hw;
 	struct rtl_rx_queue *rxq;
-	int ret;
+	int ret, i;
 	u32 csi_tmp, max_rx_pkt_size;
+	u16 nb_rx_queues = dev->data->nb_rx_queues;
+	u16 desc_start_addr_lo[QUEUE_NUM_LIMIT];
+
+	desc_start_addr_lo[0] = RxDescAddrLow;
+	for (i = 1; i < nb_rx_queues; i++)
+		desc_start_addr_lo[i] = (u16)(RDSAR_Q1_LOW_8125 + (i - 1) * 8);
 
 	rxq = dev->data->rx_queues[0];
+	for (i = 0; i < nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
 
-	if (rxq->mb_pool == NULL) {
-		PMD_INIT_LOG(ERR, "r8169 rx queue pool not setup!");
-		return -ENOMEM;
-	}
+		if (!rxq->mb_pool) {
+			PMD_INIT_LOG(ERR, "r8169 rx queue pool not setup!");
+			return -ENOMEM;
+		}
 
-	RTL_W32(hw, RxDescAddrLow, ((u64)rxq->hw_ring_phys_addr & DMA_BIT_MASK(32)));
-	RTL_W32(hw, RxDescAddrHigh, ((u64)rxq->hw_ring_phys_addr >> 32));
+		hw->rx_buf_sz = rte_pktmbuf_data_room_size(rxq->mb_pool) -
+				RTE_PKTMBUF_HEADROOM;
 
-	dev->rx_pkt_burst = rtl_recv_pkts;
-	hw->rx_buf_sz = rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;
+		RTL_W32(hw, desc_start_addr_lo[i],
+			(u64)rxq->hw_ring_phys_addr & DMA_BIT_MASK(32));
+		RTL_W32(hw, desc_start_addr_lo[i] + 4,
+			(u64)rxq->hw_ring_phys_addr >> 32);
+
+		ret = rtl_alloc_rx_queue_mbufs(rxq);
+		if (ret) {
+			PMD_INIT_LOG(ERR, "r8169 rx mbuf alloc failed!");
+			return ret;
+		}
+
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
 
 	max_rx_pkt_size = dev->data->mtu + RTL_ETH_OVERHEAD;
+	RTL_W16(hw, RxMaxSize, max_rx_pkt_size);
 
+	dev->rx_pkt_burst = rtl_recv_pkts;
 	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER ||
 	    max_rx_pkt_size > hw->rx_buf_sz) {
 		if (!dev->data->scattered_rx)
@@ -491,14 +670,6 @@ rtl_rx_init(struct rte_eth_dev *dev)
 		dev->data->scattered_rx = 1;
 	}
 
-	RTL_W16(hw, RxMaxSize, max_rx_pkt_size);
-
-	ret = rtl_alloc_rx_queue_mbufs(rxq);
-	if (ret) {
-		PMD_INIT_LOG(ERR, "r8169 rx mbuf alloc failed!");
-		return ret;
-	}
-
 	rtl_enable_cfg9346_write(hw);
 
 	if (!rtl_is_8125(hw)) {
@@ -524,24 +695,57 @@ rtl_rx_init(struct rte_eth_dev *dev)
 
 	rtl_disable_cfg9346_write(hw);
 
-	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | CmdRxEnb);
-
-	dev->data->rx_queue_state[0] = RTE_ETH_QUEUE_STATE_STARTED;
-
 	if (rtl_is_8125(hw))
 		rtl_clear_rdu = rtl8125_clear_rdu;
 	else
 		rtl_clear_rdu = rtl8168_clear_rdu;
 
+	/* RSS_control_0 */
+	if (hw->EnableRss) {
+		rtl_init_rss(hw, nb_rx_queues);
+		rtl8125_config_rss(hw, nb_rx_queues);
+	} else {
+		RTL_W32(hw, RSS_CTRL_8125, 0x00);
+	}
+
+	/* VMQ_control */
+	rtl8125_set_rx_q_num(hw, nb_rx_queues);
+
+	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | CmdRxEnb);
+
 	return 0;
 }
 
-static inline void
-rtl_mark_to_asic(struct rtl_rx_desc *rxd, u32 size)
+static inline bool
+rtl_rx_ip_csum(struct rtl_hw *hw, uint32_t opts1, uint32_t opts2)
 {
-	u32 eor = rte_le_to_cpu_32(rxd->opts1) & RingEnd;
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		return (((opts2 & RxV4F_v3) && !(opts2 & RxIPF_v3)) ||
+			(opts2 & RxV6F_v3));
+	case RX_DESC_RING_TYPE_4:
+		return (((opts2 & RxV4F_v4) && !(opts1 & RxIPF_v4)) ||
+			(opts2 & RxV6F_v4));
+	default:
+		return (((opts2 & RxV4F) && !(opts1 & RxIPF)) ||
+			(opts2 & RxV6F));
+	}
+}
 
-	rxd->opts1 = rte_cpu_to_le_32(DescOwn | eor | size);
+static inline bool
+rtl_rx_l4_csum(struct rtl_hw *hw, uint32_t opts1, uint32_t opts2)
+{
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		return (((opts2 & RxTCPT_v3) && !(opts2 & RxTCPF_v3)) ||
+			((opts2 & RxUDPT_v3) && !(opts2 & RxUDPF_v3)));
+	case RX_DESC_RING_TYPE_4:
+		return (((opts1 & RxTCPT_v4) && !(opts1 & RxTCPF_v4)) ||
+			((opts1 & RxUDPT_v4) && !(opts1 & RxUDPF_v4)));
+	default:
+		return (((opts1 & RxTCPT) && !(opts1 & RxTCPF)) ||
+			((opts1 & RxUDPT) && !(opts1 & RxUDPF)));
+	}
 }
 
 static inline uint64_t
@@ -549,15 +753,15 @@ rtl_rx_desc_error_to_pkt_flags(struct rtl_rx_queue *rxq, uint32_t opts1,
 			       uint32_t opts2)
 {
 	uint64_t pkt_flags = 0;
+	struct rtl_hw *hw = rxq->hw;
 
 	if (!(rxq->offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM))
 		goto exit;
 
 	/* RX csum offload for RTL8169*/
-	if (((opts2 & RxV4F) && !(opts1 & RxIPF)) || (opts2 & RxV6F)) {
+	if (rtl_rx_ip_csum(hw, opts1, opts2)) {
 		pkt_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
-		if (((opts1 & RxTCPT) && !(opts1 & RxTCPF)) ||
-		    ((opts1 & RxUDPT) && !(opts1 & RxUDPF)))
+		if (rtl_rx_l4_csum(hw, opts1, opts2))
 			pkt_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 	}
 
@@ -565,6 +769,76 @@ rtl_rx_desc_error_to_pkt_flags(struct rtl_rx_queue *rxq, uint32_t opts1,
 	return pkt_flags;
 }
 
+static u32
+rtl_rx_desc_opts1(struct rtl_hw *hw, struct rtl_rx_desc *desc)
+{
+	uint32_t opts1;
+
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		opts1 = ((struct rtl_rx_descv3 *)desc)->RxDescNormalDDWord4.opts1;
+		break;
+	case RX_DESC_RING_TYPE_4:
+		opts1 = ((struct rtl_rx_descv4 *)desc)->RxDescNormalDDWord2.opts1;
+		break;
+	default:
+		opts1 = desc->opts1;
+		break;
+	}
+
+	return rte_le_to_cpu_32(opts1);
+}
+
+static u32
+rtl_rx_desc_opts2(struct rtl_hw *hw, struct rtl_rx_desc *desc)
+{
+	uint32_t opts2;
+
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		opts2 = ((struct rtl_rx_descv3 *)desc)->RxDescNormalDDWord4.opts2;
+		break;
+	case RX_DESC_RING_TYPE_4:
+		opts2 = ((struct rtl_rx_descv4 *)desc)->RxDescNormalDDWord2.opts2;
+		break;
+	default:
+		opts2 = desc->opts2;
+		break;
+	}
+
+	return rte_le_to_cpu_32(opts2);
+}
+
+static u32
+rtl_get_rx_desc_hash(struct rtl_hw *hw, struct rtl_rx_desc *desc)
+{
+	u32 rss = 0;
+
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		rss = ((struct rtl_rx_descv3 *)desc)->RxDescNormalDDWord2.RSSResult;
+		break;
+	case RX_DESC_RING_TYPE_4:
+		rss = ((struct rtl_rx_descv4 *)desc)->RxDescNormalDDWord1.RSSResult;
+		break;
+	}
+
+	return rte_le_to_cpu_32(rss);
+}
+
+static inline int
+rtl_check_rx_desc_error(struct rtl_hw *hw, uint32_t opts1)
+{
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		return (opts1 & RxRES_V3);
+	case RX_DESC_RING_TYPE_4:
+		return (opts1 & RxRES_V4);
+	default:
+		return (opts1 & RxRES);
+	}
+}
+
 /* PMD receive function */
 uint16_t
 rtl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
@@ -573,7 +847,6 @@ rtl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	struct rte_eth_dev *dev = &rte_eth_devices[rxq->port_id];
 	struct rtl_hw *hw = rxq->hw;
 	struct rtl_rx_desc *rxd;
-	struct rtl_rx_desc *hw_ring;
 	struct rtl_rx_entry *rxe;
 	struct rtl_rx_entry *sw_ring = rxq->sw_ring;
 	struct rte_mbuf *new_mb;
@@ -589,14 +862,12 @@ rtl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	uint32_t opts2;
 	uint64_t dma_addr;
 
-	hw_ring = rxq->hw_ring;
-
 	RTE_ASSERT(RTL_R8(hw, ChipCmd) & CmdRxEnb);
 
 	while (nb_rx < nb_pkts) {
-		rxd = &hw_ring[tail];
+		rxd = rtl_get_rxdesc(hw, rxq->hw_ring, tail);
 
-		opts1 = rte_le_to_cpu_32(rxd->opts1);
+		opts1 = rtl_rx_desc_opts1(hw, rxd);
 		if (opts1 & DescOwn)
 			break;
 
@@ -607,78 +878,78 @@ rtl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		 */
 		rte_rmb();
 
-		if (unlikely(opts1 & RxRES)) {
+		if (unlikely(rtl_check_rx_desc_error(hw, opts1))) {
 			stats->rx_errors++;
-			rtl_mark_to_asic(rxd, hw->rx_buf_sz);
+			rtl_mark_to_asic(hw, rxd);
 			nb_hold++;
 			tail = (tail + 1) % nb_rx_desc;
-		} else {
-			opts2 = rte_le_to_cpu_32(rxd->opts2);
-
-			new_mb = rte_mbuf_raw_alloc(rxq->mb_pool);
-			if (new_mb == NULL) {
-				PMD_RX_LOG(DEBUG, "RX mbuf alloc failed port_id=%u "
-					   "queue_id=%u",
-					   (uint32_t)rxq->port_id, (uint32_t)rxq->queue_id);
-				dev->data->rx_mbuf_alloc_failed++;
-				break;
-			}
+			continue;
+		}
 
-			nb_hold++;
-			rxe = &sw_ring[tail];
+		opts2 = rtl_rx_desc_opts2(hw, rxd);
+
+		new_mb = rte_mbuf_raw_alloc(rxq->mb_pool);
+		if (!new_mb) {
+			PMD_RX_LOG(DEBUG, "RX mbuf alloc failed port_id=%u "
+				   "queue_id=%u",
+				   (u32)rxq->port_id, (u32)rxq->queue_id);
+			dev->data->rx_mbuf_alloc_failed++;
+			break;
+		}
 
-			rmb = rxe->mbuf;
+		nb_hold++;
+		rxe = &sw_ring[tail];
 
-			tail = (tail + 1) % nb_rx_desc;
+		rmb = rxe->mbuf;
 
-			/* Prefetch next mbufs */
-			rte_prefetch0(sw_ring[tail].mbuf);
-
-			/*
-			 * When next RX descriptor is on a cache-line boundary,
-			 * prefetch the next 4 RX descriptors and the next 8 pointers
-			 * to mbufs.
-			 */
-			if ((tail & 0x3) == 0) {
-				rte_prefetch0(&sw_ring[tail]);
-				rte_prefetch0(&hw_ring[tail]);
-			}
+		/* Prefetch next mbufs */
+		tail = (tail + 1) % nb_rx_desc;
+		rte_prefetch0(sw_ring[tail].mbuf);
 
-			/* Refill the RX desc */
-			rxe->mbuf = new_mb;
-			dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mb));
+		/*
+		 * When next RX descriptor is on a cache-line boundary,
+		 * prefetch the next 4 RX descriptors and the next 8 pointers
+		 * to mbufs.
+		 */
+		if ((tail & 0x3) == 0) {
+			rte_prefetch0(&sw_ring[tail]);
+			rte_prefetch0(rtl_get_rxdesc(hw, rxq->hw_ring, tail));
+		}
 
-			/* Setup RX descriptor */
-			rxd->addr = dma_addr;
-			rxd->opts2 = 0;
-			rte_wmb();
-			rtl_mark_to_asic(rxd, hw->rx_buf_sz);
+		/* Refill the RX desc */
+		rxe->mbuf = new_mb;
+		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mb));
 
-			pkt_len = opts1 & 0x00003fff;
-			pkt_len -= RTE_ETHER_CRC_LEN;
+		/* Setup RX descriptor */
+		rtl_map_to_asic(hw, rxd, dma_addr);
 
-			rmb->data_off = RTE_PKTMBUF_HEADROOM;
-			rte_prefetch1((char *)rmb->buf_addr + rmb->data_off);
-			rmb->nb_segs = 1;
-			rmb->next = NULL;
-			rmb->pkt_len = pkt_len;
-			rmb->data_len = pkt_len;
-			rmb->port = rxq->port_id;
+		pkt_len = opts1 & 0x00003fff;
+		pkt_len -= RTE_ETHER_CRC_LEN;
 
-			if (opts2 & RxVlanTag)
-				rmb->vlan_tci = rte_bswap16(opts2 & 0xffff);
+		rmb->data_off = RTE_PKTMBUF_HEADROOM;
+		rte_prefetch1((char *)rmb->buf_addr + rmb->data_off);
+		rmb->nb_segs = 1;
+		rmb->next = NULL;
+		rmb->pkt_len = pkt_len;
+		rmb->data_len = pkt_len;
+		rmb->port = rxq->port_id;
 
-			rmb->ol_flags = rtl_rx_desc_error_to_pkt_flags(rxq, opts1, opts2);
+		if (hw->EnableRss)
+			rmb->hash.rss = rtl_get_rx_desc_hash(hw, rxd);
 
-			/*
-			 * Store the mbuf address into the next entry of the array
-			 * of returned packets.
-			 */
-			rx_pkts[nb_rx++] = rmb;
+		if (opts2 & RxVlanTag)
+			rmb->vlan_tci = rte_bswap16(opts2 & 0xffff);
 
-			stats->rx_bytes += pkt_len;
-			stats->rx_packets++;
-		}
+		rmb->ol_flags = rtl_rx_desc_error_to_pkt_flags(rxq, opts1, opts2);
+
+		/*
+		 * Store the mbuf address into the next entry of the array
+		 * of returned packets.
+		 */
+		rx_pkts[nb_rx++] = rmb;
+
+		stats->rx_bytes += pkt_len;
+		stats->rx_packets++;
 	}
 
 	rxq->rx_tail = tail;
@@ -688,7 +959,7 @@ rtl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		rte_wmb();
 
 		/* Clear RDU */
-		rtl_clear_rdu(hw);
+		rtl_clear_rdu(hw, rxq->queue_id);
 
 		nb_hold = 0;
 	}
@@ -698,6 +969,19 @@ rtl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	return nb_rx;
 }
 
+static inline int
+rtl_is_non_eop(struct rtl_hw *hw, u32 opts1)
+{
+	switch (hw->HwSuppRxDescType) {
+	case RX_DESC_RING_TYPE_3:
+		return !(opts1 & LastFrag_V3);
+	case RX_DESC_RING_TYPE_4:
+		return !(opts1 & LastFrag_V4);
+	default:
+		return !(opts1 & LastFrag);
+	}
+}
+
 /* PMD receive function for scattered pkts */
 uint16_t
 rtl_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -707,7 +991,6 @@ rtl_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	struct rte_eth_dev *dev = &rte_eth_devices[rxq->port_id];
 	struct rtl_hw *hw = rxq->hw;
 	struct rtl_rx_desc *rxd;
-	struct rtl_rx_desc *hw_ring;
 	struct rtl_rx_entry *rxe;
 	struct rtl_rx_entry *sw_ring = rxq->sw_ring;
 	struct rte_mbuf *first_seg;
@@ -725,8 +1008,6 @@ rtl_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	uint32_t opts2;
 	uint64_t dma_addr;
 
-	hw_ring = rxq->hw_ring;
-
 	/*
 	 * Retrieve RX context of current packet, if any.
 	 */
@@ -737,136 +1018,136 @@ rtl_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 	while (nb_rx < nb_pkts) {
 next_desc:
-		rxd = &hw_ring[tail];
+		rxd = rtl_get_rxdesc(hw, rxq->hw_ring, tail);
 
-		opts1 = rte_le_to_cpu_32(rxd->opts1);
+		opts1 = rtl_rx_desc_opts1(hw, rxd);
 		if (opts1 & DescOwn)
 			break;
 
 		/*
 		 * This barrier is needed to keep us from reading
 		 * any other fields out of the Rx descriptor until
-		 * we know the status of DescOwn
+		 * we know the status of DescOwn.
 		 */
 		rte_rmb();
 
-		if (unlikely(opts1 & RxRES)) {
+		if (unlikely(rtl_check_rx_desc_error(hw, opts1))) {
 			stats->rx_errors++;
-			rtl_mark_to_asic(rxd, hw->rx_buf_sz);
+			rtl_mark_to_asic(hw, rxd);
 			nb_hold++;
 			tail = (tail + 1) % nb_rx_desc;
-		} else {
-			opts2 = rte_le_to_cpu_32(rxd->opts2);
-
-			new_mb = rte_mbuf_raw_alloc(rxq->mb_pool);
-			if (new_mb == NULL) {
-				PMD_RX_LOG(DEBUG, "RX mbuf alloc failed port_id=%u "
-					   "queue_id=%u",
-					   (uint32_t)rxq->port_id, (uint32_t)rxq->queue_id);
-				dev->data->rx_mbuf_alloc_failed++;
-				break;
-			}
-
-			nb_hold++;
-			rxe = &sw_ring[tail];
+			continue;
+		}
 
-			rmb = rxe->mbuf;
+		opts2 = rtl_rx_desc_opts2(hw, rxd);
 
-			/* Prefetch next mbufs */
-			tail = (tail + 1) % nb_rx_desc;
-			rte_prefetch0(sw_ring[tail].mbuf);
-
-			/*
-			 * When next RX descriptor is on a cache-line boundary,
-			 * prefetch the next 4 RX descriptors and the next 8 pointers
-			 * to mbufs.
-			 */
-			if ((tail & 0x3) == 0) {
-				rte_prefetch0(&sw_ring[tail]);
-				rte_prefetch0(&hw_ring[tail]);
-			}
+		new_mb = rte_mbuf_raw_alloc(rxq->mb_pool);
+		if (!new_mb) {
+			PMD_RX_LOG(DEBUG, "RX mbuf alloc failed port_id=%u "
+				   "queue_id=%u",
+				   (u32)rxq->port_id, (u32)rxq->queue_id);
+			dev->data->rx_mbuf_alloc_failed++;
+			break;
+		}
 
-			/* Refill the RX desc */
-			rxe->mbuf = new_mb;
-			dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mb));
-
-			/* Setup RX descriptor */
-			rxd->addr = dma_addr;
-			rxd->opts2 = 0;
-			rte_wmb();
-			rtl_mark_to_asic(rxd, hw->rx_buf_sz);
-
-			data_len = opts1 & 0x00003fff;
-			rmb->data_len = data_len;
-			rmb->data_off = RTE_PKTMBUF_HEADROOM;
-
-			/*
-			 * If this is the first buffer of the received packet,
-			 * set the pointer to the first mbuf of the packet and
-			 * initialize its context.
-			 * Otherwise, update the total length and the number of segments
-			 * of the current scattered packet, and update the pointer to
-			 * the last mbuf of the current packet.
-			 */
-			if (first_seg == NULL) {
-				first_seg = rmb;
-				first_seg->pkt_len = data_len;
-				first_seg->nb_segs = 1;
-			} else {
-				first_seg->pkt_len += data_len;
-				first_seg->nb_segs++;
-				last_seg->next = rmb;
-			}
+		nb_hold++;
+		rxe = &sw_ring[tail];
 
-			/*
-			 * If this is not the last buffer of the received packet,
-			 * update the pointer to the last mbuf of the current scattered
-			 * packet and continue to parse the RX ring.
-			 */
-			if (!(opts1 & LastFrag)) {
-				last_seg = rmb;
-				goto next_desc;
-			}
+		rmb = rxe->mbuf;
 
-			/*
-			 * This is the last buffer of the received packet.
-			 */
-			rmb->next = NULL;
-
-			first_seg->pkt_len -= RTE_ETHER_CRC_LEN;
-			if (data_len <= RTE_ETHER_CRC_LEN) {
-				rte_pktmbuf_free_seg(rmb);
-				first_seg->nb_segs--;
-				last_seg->data_len = last_seg->data_len -
-						     (RTE_ETHER_CRC_LEN - data_len);
-				last_seg->next = NULL;
-			} else {
-				rmb->data_len = data_len - RTE_ETHER_CRC_LEN;
-			}
+		/* Prefetch next mbufs */
+		tail = (tail + 1) % nb_rx_desc;
+		rte_prefetch0(sw_ring[tail].mbuf);
 
-			first_seg->port = rxq->port_id;
+		/*
+		 * When next RX descriptor is on a cache-line boundary,
+		 * prefetch the next 4 RX descriptors and the next 8 pointers
+		 * to mbufs.
+		 */
+		if ((tail & 0x3) == 0) {
+			rte_prefetch0(&sw_ring[tail]);
+			rte_prefetch0(rtl_get_rxdesc(hw, rxq->hw_ring, tail));
+		}
 
-			if (opts2 & RxVlanTag)
-				first_seg->vlan_tci = rte_bswap16(opts2 & 0xffff);
+		/* Refill the RX desc */
+		rxe->mbuf = new_mb;
+		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mb));
 
-			first_seg->ol_flags = rtl_rx_desc_error_to_pkt_flags(rxq, opts1, opts2);
+		/* Setup RX descriptor */
+		rtl_map_to_asic(hw, rxd, dma_addr);
 
-			rte_prefetch1((char *)first_seg->buf_addr + first_seg->data_off);
+		data_len = opts1 & 0x00003fff;
+		rmb->data_len = data_len;
+		rmb->data_off = RTE_PKTMBUF_HEADROOM;
 
-			/*
-			 * Store the mbuf address into the next entry of the array
-			 * of returned packets.
-			 */
-			rx_pkts[nb_rx++] = first_seg;
+		/*
+		 * If this is the first buffer of the received packet,
+		 * set the pointer to the first mbuf of the packet and
+		 * initialize its context.
+		 * Otherwise, update the total length and the number of segments
+		 * of the current scattered packet, and update the pointer to
+		 * the last mbuf of the current packet.
+		 */
+		if (!first_seg) {
+			first_seg = rmb;
+			first_seg->pkt_len = data_len;
+			first_seg->nb_segs = 1;
+		} else {
+			first_seg->pkt_len += data_len;
+			first_seg->nb_segs++;
+			last_seg->next = rmb;
+		}
 
-			stats->rx_bytes += first_seg->pkt_len;
-			stats->rx_packets++;
+		/*
+		 * If this is not the last buffer of the received packet,
+		 * update the pointer to the last mbuf of the current scattered
+		 * packet and continue to parse the RX ring.
+		 */
+		if (rtl_is_non_eop(hw, opts1)) {
+			last_seg = rmb;
+			goto next_desc;
+		}
 
-			/*
-			 * Setup receipt context for a new packet.
-			 */
-			first_seg = NULL;
+		/*
+		 * This is the last buffer of the received packet.
+		 */
+		rmb->next = NULL;
+
+		first_seg->pkt_len -= RTE_ETHER_CRC_LEN;
+		if (data_len <= RTE_ETHER_CRC_LEN) {
+			rte_pktmbuf_free_seg(rmb);
+			first_seg->nb_segs--;
+			last_seg->data_len = last_seg->data_len -
+					     (RTE_ETHER_CRC_LEN - data_len);
+			last_seg->next = NULL;
+		} else {
+			rmb->data_len = data_len - RTE_ETHER_CRC_LEN;
 		}
+
+		first_seg->port = rxq->port_id;
+		if (hw->EnableRss)
+			first_seg->hash.rss = rtl_get_rx_desc_hash(hw, rxd);
+
+		if (opts2 & RxVlanTag)
+			first_seg->vlan_tci = rte_bswap16(opts2 & 0xffff);
+
+		first_seg->ol_flags = rtl_rx_desc_error_to_pkt_flags(rxq, opts1, opts2);
+
+		rte_prefetch1((char *)first_seg->buf_addr + first_seg->data_off);
+
+		/*
+		 * Store the mbuf address into the next entry of the array
+		 * of returned packets.
+		 */
+		rx_pkts[nb_rx++] = first_seg;
+
+		stats->rx_bytes += first_seg->pkt_len;
+		stats->rx_packets++;
+
+		/*
+		 * Setup receipt context for a new packet.
+		 */
+		first_seg = NULL;
 	}
 
 	/*
@@ -885,7 +1166,7 @@ rtl_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rte_wmb();
 
 		/* Clear RDU */
-		rtl_clear_rdu(hw);
+		rtl_clear_rdu(hw, rxq->queue_id);
 
 		nb_hold = 0;
 	}
@@ -954,6 +1235,10 @@ rtl_reset_tx_queue(struct rtl_tx_queue *txq)
 	txq->tx_tail = 0;
 	txq->tx_head = 0;
 	txq->tx_free = txq->nb_tx_desc - 1;
+
+	/* EnableTxNoClose */
+	txq->NextHwDesCloPtr = 0;
+	txq->BeginHwDesCloPtr = 0;
 }
 
 uint64_t
@@ -1042,10 +1327,6 @@ rtl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	rtl_reset_tx_queue(txq);
 
-	/* EnableTxNoClose */
-	hw->NextHwDesCloPtr0 = 0;
-	hw->BeginHwDesCloPtr0 = 0;
-
 	dev->data->tx_queues[queue_idx] = txq;
 
 	return 0;
@@ -1092,18 +1373,64 @@ rtl8168_set_mtps(struct rtl_hw *hw)
 		RTL_W8(hw, MTPS, 0x3F);
 }
 
+static void
+rtl8125_set_tx_q_num(struct rtl_hw *hw, unsigned int num_tx_queues)
+{
+	u16 mac_ocp_data;
+
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE63E);
+	mac_ocp_data &= ~(BIT_11 | BIT_10);
+	mac_ocp_data |= ((rte_log2_u32(num_tx_queues) & 0x03) << 10);
+	rtl_mac_ocp_write(hw, 0xE63E, mac_ocp_data);
+}
+
 int
 rtl_tx_init(struct rte_eth_dev *dev)
 {
 	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
 	struct rtl_hw *hw = &adapter->hw;
 	struct rtl_tx_queue *txq;
+	u16 nb_tx_queues = dev->data->nb_tx_queues;
+	u16 desc_start_addr_lo[QUEUE_NUM_LIMIT];
+	u16 hw_clo_ptr0_reg, sw_tail_ptr0_reg, reg_len;
+	int i;
 
-	txq = dev->data->tx_queues[0];
+	desc_start_addr_lo[0] = TxDescStartAddrLow;
+	for (i = 1; i < nb_tx_queues; i++)
+		desc_start_addr_lo[i] = (u16)(TNPDS_Q1_LOW_8125 + (i - 1) * 8);
 
-	RTL_W32(hw, TxDescStartAddrLow,
-		((u64)txq->hw_ring_phys_addr & DMA_BIT_MASK(32)));
-	RTL_W32(hw, TxDescStartAddrHigh, ((u64)txq->hw_ring_phys_addr >> 32));
+	switch (hw->HwSuppTxNoCloseVer) {
+	case 4:
+	case 5:
+		hw_clo_ptr0_reg = HW_CLO_PTR0_8126;
+		sw_tail_ptr0_reg = SW_TAIL_PTR0_8126;
+		reg_len = 4;
+		break;
+	case 6:
+		hw_clo_ptr0_reg = HW_CLO_PTR0_8125BP;
+		sw_tail_ptr0_reg = SW_TAIL_PTR0_8125BP;
+		reg_len = 8;
+		break;
+	default:
+		hw_clo_ptr0_reg = HW_CLO_PTR0_8125;
+		sw_tail_ptr0_reg = SW_TAIL_PTR0_8125;
+		reg_len = 4;
+		break;
+	}
+
+	for (i = 0; i < nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+
+		RTL_W32(hw, desc_start_addr_lo[i],
+			(u64)txq->hw_ring_phys_addr & DMA_BIT_MASK(32));
+		RTL_W32(hw, desc_start_addr_lo[i] + 4,
+			(u64)txq->hw_ring_phys_addr >> 32);
+
+		txq->hw_clo_ptr_reg = (u16)(hw_clo_ptr0_reg + i * reg_len);
+		txq->sw_tail_ptr_reg = (u16)(sw_tail_ptr0_reg + i * reg_len);
+
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
 
 	rtl_enable_cfg9346_write(hw);
 
@@ -1119,9 +1446,9 @@ rtl_tx_init(struct rte_eth_dev *dev)
 
 	rtl_disable_cfg9346_write(hw);
 
-	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | CmdTxEnb);
+	rtl8125_set_tx_q_num(hw, nb_tx_queues);
 
-	dev->data->tx_queue_state[0] = RTE_ETH_QUEUE_STATE_STARTED;
+	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | CmdTxEnb);
 
 	return 0;
 }
@@ -1351,15 +1678,17 @@ rtl_fast_mod_mask(const u32 input, const u32 mask)
 }
 
 static u32
-rtl_get_hw_clo_ptr(struct rtl_hw *hw)
+rtl_get_hw_clo_ptr(struct rtl_tx_queue *txq)
 {
+	struct rtl_hw *hw = txq->hw;
+
 	switch (hw->HwSuppTxNoCloseVer) {
 	case 3:
-		return RTL_R16(hw, hw->hw_clo_ptr_reg);
+		return RTL_R16(hw, txq->hw_clo_ptr_reg);
 	case 4:
 	case 5:
 	case 6:
-		return RTL_R32(hw, hw->hw_clo_ptr_reg);
+		return RTL_R32(hw, txq->hw_clo_ptr_reg);
 	default:
 		return 0;
 	}
@@ -1384,20 +1713,20 @@ rtl8125_tx_clean(struct rtl_hw *hw, struct rtl_tx_queue *txq)
 	uint16_t head = txq->tx_head;
 	uint16_t desc_freed = 0;
 	uint32_t tx_left;
-	uint32_t tx_desc_closed, next_hw_desc_clo_ptr0;
+	uint32_t tx_desc_closed;
 
 	if (!txq)
 		return;
 
 	if (enable_tx_no_close) {
-		next_hw_desc_clo_ptr0 = rtl_get_hw_clo_ptr(hw);
-		hw->NextHwDesCloPtr0 = next_hw_desc_clo_ptr0;
-		tx_desc_closed = rtl_fast_mod_mask(next_hw_desc_clo_ptr0 -
-						   hw->BeginHwDesCloPtr0, hw->MaxTxDescPtrMask);
+		txq->NextHwDesCloPtr = rtl_get_hw_clo_ptr(txq);
+		tx_desc_closed = rtl_fast_mod_mask(txq->NextHwDesCloPtr -
+						   txq->BeginHwDesCloPtr,
+						   hw->MaxTxDescPtrMask);
 		tx_left = RTE_MIN(((rte_atomic_load_explicit(&txq->tx_tail,
 				    rte_memory_order_relaxed) % nb_tx_desc) - head),
 				    tx_desc_closed);
-		hw->BeginHwDesCloPtr0 += tx_left;
+		txq->BeginHwDesCloPtr += tx_left;
 	} else {
 		tx_left = (rte_atomic_load_explicit(&txq->tx_tail,
 						    rte_memory_order_relaxed) % nb_tx_desc) - head;
@@ -1484,20 +1813,20 @@ rtl8125_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 	uint32_t tx_left;
 	uint32_t count = 0;
 	uint32_t status;
-	uint32_t tx_desc_closed, next_hw_desc_clo_ptr0;
+	uint32_t tx_desc_closed;
 
 	if (!txq)
 		return -ENODEV;
 
 	if (enable_tx_no_close) {
-		next_hw_desc_clo_ptr0 = rtl_get_hw_clo_ptr(hw);
-		hw->NextHwDesCloPtr0 = next_hw_desc_clo_ptr0;
-		tx_desc_closed = rtl_fast_mod_mask(next_hw_desc_clo_ptr0 -
-						   hw->BeginHwDesCloPtr0, hw->MaxTxDescPtrMask);
+		txq->NextHwDesCloPtr = rtl_get_hw_clo_ptr(txq);
+		tx_desc_closed = rtl_fast_mod_mask(txq->NextHwDesCloPtr -
+						   txq->BeginHwDesCloPtr,
+						   hw->MaxTxDescPtrMask);
 		tx_left = RTE_MIN(((rte_atomic_load_explicit(&txq->tx_tail,
 				    rte_memory_order_relaxed) % nb_tx_desc) - head),
 				    tx_desc_closed);
-		hw->BeginHwDesCloPtr0 += tx_left;
+		txq->BeginHwDesCloPtr += tx_left;
 	} else {
 		tx_left = (rte_atomic_load_explicit(&txq->tx_tail,
 						    rte_memory_order_relaxed) % nb_tx_desc) - head;
@@ -1602,9 +1931,9 @@ rtl8125_doorbell(struct rtl_hw *hw, struct rtl_tx_queue *txq)
 {
 	if (hw->EnableTxNoClose)
 		if (hw->HwSuppTxNoCloseVer > 3)
-			RTL_W32(hw, hw->sw_tail_ptr_reg, txq->tx_tail);
+			RTL_W32(hw, txq->sw_tail_ptr_reg, txq->tx_tail);
 		else
-			RTL_W16(hw, hw->sw_tail_ptr_reg, txq->tx_tail);
+			RTL_W16(hw, txq->sw_tail_ptr_reg, txq->tx_tail);
 	else
 		RTL_W16(hw, TPPOLL_8125, BIT_0);
 }
@@ -1671,36 +2000,46 @@ rtl_stop_queues(struct rte_eth_dev *dev)
 {
 	struct rtl_tx_queue *txq;
 	struct rtl_rx_queue *rxq;
+	int i;
 
 	PMD_INIT_FUNC_TRACE();
 
-	txq = dev->data->tx_queues[0];
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
 
-	rtl_tx_queue_release_mbufs(txq);
-	rtl_reset_tx_queue(txq);
-	dev->data->tx_queue_state[0] = RTE_ETH_QUEUE_STATE_STOPPED;
-
-	rxq = dev->data->rx_queues[0];
+		rtl_tx_queue_release_mbufs(txq);
+		rtl_reset_tx_queue(txq);
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
 
-	rtl_rx_queue_release_mbufs(rxq);
-	rtl_reset_rx_queue(rxq);
-	dev->data->rx_queue_state[0] = RTE_ETH_QUEUE_STATE_STOPPED;
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
 
+		rtl_rx_queue_release_mbufs(rxq);
+		rtl_reset_rx_queue(rxq);
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
 	return 0;
 }
 
 void
 rtl_free_queues(struct rte_eth_dev *dev)
 {
-	PMD_INIT_FUNC_TRACE();
+	int i;
 
-	rte_eth_dma_zone_free(dev, "rx_ring", 0);
-	rtl_rx_queue_release(dev, 0);
-	dev->data->rx_queues[0] = 0;
-	dev->data->nb_rx_queues = 0;
+	PMD_INIT_FUNC_TRACE();
 
-	rte_eth_dma_zone_free(dev, "tx_ring", 0);
-	rtl_tx_queue_release(dev, 0);
-	dev->data->tx_queues[0] = 0;
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		rte_eth_dma_zone_free(dev, "tx_ring", i);
+		rtl_tx_queue_release(dev, i);
+		dev->data->tx_queues[i] = 0;
+	}
 	dev->data->nb_tx_queues = 0;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rte_eth_dma_zone_free(dev, "rx_ring", i);
+		rtl_rx_queue_release(dev, i);
+		dev->data->rx_queues[i] = 0;
+	}
+	dev->data->nb_rx_queues = 0;
 }
-- 
2.34.1

