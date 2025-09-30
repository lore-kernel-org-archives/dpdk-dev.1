Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C847CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:01:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA95940E0B;
	Tue, 30 Sep 2025 12:00:50 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id A233240E0A
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:48 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226444tf0d8775f
X-QQ-Originating-IP: dRlAi0/vUYMEC4itQhlLblP8W3SDRayNriSmBqEBw1g=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14889170040542431108
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 11/20] net/txgbe: add RX desc merge mode for Amber-Lite NICs
Date: Tue, 30 Sep 2025 17:59:43 +0800
Message-Id: <20250930095953.18508-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MgOpuW05bt0i/o808YtqM3nHdXzvrp0L2Kyd8nzcxEgjIeDDx9dlOxYo
 +jj8P8MK1/ap6pv0C9ZCJi+1rlm3g3htPfLOGKvRmsrUbbNzhv32Eq1D+6IJGoKQKyd39ZF
 Xi/nWGpueFUeQQTS3fPTcisRPDrr2n6H/C3Lyopr4tU+lQ4ps8LM+Hsjn6PyNpkD89OMz0G
 y1p1cvDLE3TemRzlmsEdRlF6IIfUT0kKL11s1rZL9VlGrG1vMKUiV4JugRuHiTCdsARilFk
 iWEP+ri4oxLyhGPPOLjvWapTkMeiOYhs9un9LC/JnW2PABBYjuRW6NDcErHLAGbR1R755bx
 muGLF6DRZKXWuCVg1dOm8fyRpKXFHmyOPUP0qco9V1BHIGD5IyO6yrL9SLlIKNKJjsK1cwL
 aMVXGonXE0TDmSVHfSzGCW//h3Eg9K5d0Pa6Fs/6jNlTdj2Q/xIG35bnbpC0jbNa7tbVpol
 K2af7QgsLLLraFThZWMgAMZyhjbg+w8FEoVw+1vlumETffjUAiPQKFMP6oNOo4jqj+Samsk
 aq/xJxBxYBPk/1BsXXHY2lR4WwgL5hJAeAUWnVTiZKi4Yr7VejhQRuxmgnkgqjVHtIbHdjr
 rAnjqh0LGcsQqSwp2MD5XIsqd+TlCqGOxMMMw/qCECWqVW2RrMQZgvApG+kHbKNXZBk0OQ2
 azhmZVr8gj93GRoUplsqFWQAxyahrkhyogLJX//BdTMzoGxTLcT+X6hHODYKq2jRo9KMfeu
 AXrzAsoGKus1GvaA3RRXRIqgiz9VkhJFnisOr60UueGL5zML7SJyF2LiktKs++38lxMBiSn
 KbKxRIRwVOvtAuz6UYesawrAmq/1iZpmPO8iWTgEu1mGrQwUQQ2Osx3wHMoUQ1WBKXnH2i2
 n60lp1XY05ouTwJ9F3GVwgk9fhgklhvYoum37HptNBm73iAOm82H/HdnKz5XOBUhSgbt19E
 egNKjXjiuZ8vk5dM2d+M3TIioEghCt62kLUW5OGONwx/YjRKKdp8JK+eHQmnEIUY6MNqPOy
 5MMVE0p05f80B7+nMtrYKTwRfIeSlN+3Ruji8YQxZomznd5WlzkaoaDBwFPELoJW1mdm4fN
 w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
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

Add RX desc merge mode for Amber-Lite NICs. When enabled,
the hardware batch-processes RX packets, significantly
enhancing performance. This feature is enabled by default
in the driver and can be configured via the rx_desc_merge
parameter in devargs.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h |  4 ++++
 drivers/net/txgbe/base/txgbe_type.h |  3 +++
 drivers/net/txgbe/txgbe_ethdev.c    |  7 ++++++-
 drivers/net/txgbe/txgbe_rxtx.c      | 11 +++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 1a544bcd57..e050941992 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1377,6 +1377,7 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_RXCFG_HDRLEN(v)         LS(HDRLEN(v), 12, 0xF)
 #define     TXGBE_RXCFG_HDRLEN_MASK     MS(12, 0xF)
 #define   TXGBE_RXCFG_WTHRESH(v)        LS(v, 16, 0x7)
+#define   TXGBE_RXCFG_DESC_MERGE        MS(19, 0x1)
 #define   TXGBE_RXCFG_ETAG              MS(22, 0x1)
 #define   TXGBE_RXCFG_RSCMAX_MASK       MS(23, 0x3)
 #define     TXGBE_RXCFG_RSCMAX_1        LS(0, 23, 0x3)
@@ -1671,6 +1672,9 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_RPUP2TC_UP_SHIFT        3
 #define   TXGBE_RPUP2TC_UP_MASK         0x7
 
+#define TXGBE_RDM_DCACHE_CTL             0x0120A8
+#define   TXGBE_RDM_DCACHE_CTL_EN        MS(0, 0x1)
+
 /* mac switcher */
 #define TXGBE_ETHADDRL                  0x016200
 #define   TXGBE_ETHADDRL_AD0(v)         LS(v, 0, 0xFF)
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 844a2827bc..03e5bd489d 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -718,6 +718,7 @@ struct txgbe_phy_info {
 #define TXGBE_DEVARG_FFE_POST		"ffe_post"
 #define TXGBE_DEVARG_TX_HEAD_WB		"tx_headwb"
 #define TXGBE_DEVARG_TX_HEAD_WB_SIZE	"tx_headwb_size"
+#define TXGBE_DEVARG_RX_DESC_MERGE	"rx_desc_merge"
 
 static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_BP_AUTO,
@@ -730,6 +731,7 @@ static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_FFE_POST,
 	TXGBE_DEVARG_TX_HEAD_WB,
 	TXGBE_DEVARG_TX_HEAD_WB_SIZE,
+	TXGBE_DEVARG_RX_DESC_MERGE,
 	NULL
 };
 
@@ -782,6 +784,7 @@ struct txgbe_devargs {
 	u16 sgmii;
 	u16 tx_headwb;
 	u16 tx_headwb_size;
+	u16 rx_desc_merge;
 };
 
 struct txgbe_hw {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 9c14e4b8ed..13d1d6924d 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -516,6 +516,7 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 	/* New devargs for amberlite config */
 	u16 tx_headwb = 1;
 	u16 tx_headwb_size = 16;
+	u16 rx_desc_merge = 1;
 
 	if (devargs == NULL)
 		goto null;
@@ -544,6 +545,8 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 			   &txgbe_handle_devarg, &tx_headwb);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB_SIZE,
 			   &txgbe_handle_devarg, &tx_headwb_size);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_RX_DESC_MERGE,
+			   &txgbe_handle_devarg, &rx_desc_merge);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -553,6 +556,7 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 	hw->devarg.sgmii = sgmii;
 	hw->devarg.tx_headwb = tx_headwb;
 	hw->devarg.tx_headwb_size = tx_headwb_size;
+	hw->devarg.rx_desc_merge = rx_desc_merge;
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
@@ -5729,7 +5733,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
 			      TXGBE_DEVARG_FFE_PRE "=<uint16>"
 			      TXGBE_DEVARG_FFE_POST "=<uint16>"
 			      TXGBE_DEVARG_TX_HEAD_WB "=<0|1>"
-			      TXGBE_DEVARG_TX_HEAD_WB_SIZE "=<1|16>");
+			      TXGBE_DEVARG_TX_HEAD_WB_SIZE "=<1|16>"
+			      TXGBE_DEVARG_RX_DESC_MERGE "=<0|1>");
 
 RTE_LOG_REGISTER_SUFFIX(txgbe_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(txgbe_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index b15b6788e6..957aa5c6eb 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4667,6 +4667,17 @@ txgbe_dev_rx_init(struct rte_eth_dev *dev)
 		buf_size = ROUND_DOWN(buf_size, 0x1 << 10);
 		srrctl |= TXGBE_RXCFG_PKTLEN(buf_size);
 
+		if ((hw->mac.type == txgbe_mac_aml ||
+		     hw->mac.type == txgbe_mac_aml40) && hw->devarg.rx_desc_merge == 1) {
+			srrctl |= TXGBE_RXCFG_DESC_MERGE;
+
+			wr32(hw, TXGBE_RDM_DCACHE_CTL, TXGBE_RDM_DCACHE_CTL_EN);
+			wr32m(hw, TXGBE_RDM_RSC_CTL, TXGBE_RDM_RSC_CTL_FREE_CTL,
+							 TXGBE_RDM_RSC_CTL_FREE_CTL);
+			wr32m(hw, TXGBE_RDM_RSC_CTL, TXGBE_RDM_RSC_CTL_FREE_CNT_DIS,
+							 ~TXGBE_RDM_RSC_CTL_FREE_CNT_DIS);
+		}
+
 		wr32(hw, TXGBE_RXCFG(rxq->reg_idx), srrctl);
 
 		/* It adds dual VLAN length for supporting dual VLAN */
-- 
2.21.0.windows.1

