Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC255C77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 198D5410F2;
	Thu, 26 Jun 2025 10:09:44 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id C3C21410FC
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:09:41 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925375t17b8716e
X-QQ-Originating-IP: 3o9r7lz8C9rCcdmg5NhNBfMRBp18AumtxZuye5M1NsA=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:09:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15888758985354873597
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v3 10/15] net/txgbe: add RX desc merge mode for Amber-Lite NICs
Date: Thu, 26 Jun 2025 16:02:15 +0800
Message-Id: <20250626080221.22488-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MZChPk4K8ikN7LQOqUlm210++JcIehzPpDURr9pw2TDEKou2P3/J5lG6
 nQzMgWaCgRRc19HxKOnm+7yszEBqr5sQWiK2yLFk2Vdz6xbc/QnysCYSP9Ma75Rie5bimVO
 8Fq52Y+E048LDFHr5939ulpAWcp8sIsWcnNjDhoBIzHlLYqMDs0qZxQ+LlZRbFODy6qDlpB
 TOSH63v1a63AzsDyrRoQsrrh4/88z9IYH3SqQM4gDJXaLQHqolGCcq/+asyx42xIVqOpOxB
 sCCsRKDzj8o/wt4j1CSthYrHZKzrRZ5oo3KCI1Dqzb5FubPZSpszJWemVNTagQFLSOeSe+E
 IgtBat5G3Ei6mW2cep5dq2kjYf4iVXl897k0/HdbwN2XtoOzK+l+ctRKvTiiWShH4jVo52a
 vpWQn8nurJrteDGmN5vtLgjgSffnsjYlXnkxvD42ZXkorRgS4XR5ZXoEuTR2bCXGpYFBMeP
 U0zuLKg1TjWaZZPQOmnEBnXJ+mloHh3L8jW4cShppEgY88wvyOTlQU9/x71nE80OVMZkHNO
 mYWoCIO9c0anx7SUtOS2H83iuuWSjPnry+VpVuz5sTMSW+RdI/CLIuvAfsAIR8Y6tZFej59
 3bMXYmGOmRhw2fddagNo16EindpNfLCfC5GOE4Sm9aXzPSHBxIxKO9XAQ0qteP5+2YI4XPO
 qIzVBVby7vkvWUy2Qmg8QlDJl0Xgpfa3kKrFnuZe9kwcT6j9tkGTPZxo271NlJh6lJkIfli
 DHh2A1zEzcoqHw9INExzWtp3CLRPZptE9Pvjxd2iZk1kS1FM0QgUYZQ69cWI0BRKRzMVIy6
 DN5UyvPeHvHUcT9VUKO1Hh+NG3GpCFzKA1uBi/Md2tNSH277Udsf9iIhY+jn1r3Du3qQVVx
 CuK7SAuKd1Y9dD9igBcD9RSUBPqZYzDCb1u3L+rdvGZW3VumhgEWfoxdDscnMgKVIqX5Gh5
 s1A+mIRKjL+gRevXnfOs8hG2atMLTIReBWvtZBOPfirGAeGgzplkg3389ciO1jTxjESorWf
 weTKZUqGp8QowfUhExr8yYw8Lt0mpw4KGFtTlQhDiXbY3Xt214D7QdTMkPQ9KhS+eAXpjrp
 g==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
 drivers/net/txgbe/txgbe_ethdev.c    |  4 ++++
 drivers/net/txgbe/txgbe_rxtx.c      | 11 +++++++++++
 4 files changed, 22 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 17257442f3..86f88e31fe 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1373,6 +1373,7 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_RXCFG_HDRLEN(v)         LS(HDRLEN(v), 12, 0xF)
 #define     TXGBE_RXCFG_HDRLEN_MASK     MS(12, 0xF)
 #define   TXGBE_RXCFG_WTHRESH(v)        LS(v, 16, 0x7)
+#define   TXGBE_RXCFG_DESC_MERGE        MS(19, 0x1)
 #define   TXGBE_RXCFG_ETAG              MS(22, 0x1)
 #define   TXGBE_RXCFG_RSCMAX_MASK       MS(23, 0x3)
 #define     TXGBE_RXCFG_RSCMAX_1        LS(0, 23, 0x3)
@@ -1666,6 +1667,9 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_RPUP2TC_UP_SHIFT        3
 #define   TXGBE_RPUP2TC_UP_MASK         0x7
 
+#define TXGBE_RDM_DCACHE_CTL             0x0120A8
+#define   TXGBE_RDM_DCACHE_CTL_EN        MS(0, 0x1)
+
 /* mac switcher */
 #define TXGBE_ETHADDRL                  0x016200
 #define   TXGBE_ETHADDRL_AD0(v)         LS(v, 0, 0xFF)
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 5692883f60..ba961b4b1e 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -725,6 +725,7 @@ struct txgbe_phy_info {
 #define TXGBE_DEVARG_FFE_POST		"ffe_post"
 #define TXGBE_DEVARG_TX_HEAD_WB		"tx_headwb"
 #define TXGBE_DEVARG_TX_HEAD_WB_SIZE	"tx_headwb_size"
+#define TXGBE_DEVARG_RX_DESC_MERGE	"rx_desc_merge"
 
 static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_BP_AUTO,
@@ -737,6 +738,7 @@ static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_FFE_POST,
 	TXGBE_DEVARG_TX_HEAD_WB,
 	TXGBE_DEVARG_TX_HEAD_WB_SIZE,
+	TXGBE_DEVARG_RX_DESC_MERGE,
 	NULL
 };
 
@@ -789,6 +791,7 @@ struct txgbe_devargs {
 	u16 sgmii;
 	u16 tx_headwb;
 	u16 tx_headwb_size;
+	u16 rx_desc_merge;
 };
 
 struct txgbe_hw {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index ed84594105..fffb8fb01d 100644
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
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 28c384af73..6cc763a4aa 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4649,6 +4649,17 @@ txgbe_dev_rx_init(struct rte_eth_dev *dev)
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

