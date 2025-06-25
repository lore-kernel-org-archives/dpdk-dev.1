Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E805C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E35E40E38;
	Wed, 25 Jun 2025 14:52:21 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id EEC7A40E7C
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:18 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855933td9813147
X-QQ-Originating-IP: l2tG2EdVfVf4vD8HqsWtYHE+37oGkiVa9AQgJtHd9gQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:52:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10785061707437914746
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 10/15] net/txgbe: add RX desc merge mode for Amber-Lite NICs
Date: Wed, 25 Jun 2025 20:50:42 +0800
Message-Id: <20250625125047.18072-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NWwUqlpH66YHCpyxVhXNDXECwapDAARxccKJ+PjtGgyWiBDWReeyD82k
 SyUUq1peAspvgxjX1ZUMbUej0npabpjkc6WKHyTZ0V2+atTNHZHrXbxtHIJlzxiBUsFIJj1
 2xp0oTG6YjDpiU7B7fnIltdHQ6dDuuKHp3qNIxmE13ftscVW00ZvbZAgjIcLeqKpNqbS5cI
 Vj0ZweoqKa6FGGIy3PTLOuaaCzhKUFcG2I0Dqhmp8koHRWb6ut8jIlnAYEQ04Aukf0h3/ZE
 4/wX0E60E27lhpxtVoLC9Tb6MHwdoGo65yCq/+pitPkeJNGAA3i16lBUi6dpwmwtqUzFBz0
 Osg6tOjbUGg63RhOvYa2yooE4XTtPcgXkEWm/rAQmy7bOFcMHZaErAtkDuBfvVhP/t1LcY/
 RckhNBbvE359R0C8pXYgC4D0m0if4ll6Tl0Y+4DEBiSmzL5aQ50bVIGJCJ8ZVtfG00WufRI
 QzCx4oCyozf29LpV/QBk/ZVSpB5+9LNZp8TmmIuyabQ3LqvwrW7mJwjZ8Exi0eWTGEAMjdB
 dnYCUAQ9/Mn0hV2kdhK/9hlFX2rHCujNWiJPvQefxD/ReaJfg0BVcE9OYMqVeD/hUKbLFE4
 igZDpuD5UQ5hUOsKTDlYgoRKxRHzccwB8QJ7S74lX8ZtQgrdqkfSKbu5INSTLCuSxPHo9fS
 3cgiWqpo4qNobpXt3t5E/QqjbCD8wsZ53R8tqON+ZkCdzkpI9uorcRHXfBK3O+0q0Sw3Jcs
 8oJOVcxDjBiwq5I82P1S/TWRxak7h/jxTDKCvvx1lIn1nXpq8QMEup6q1MZq6IbLDlM+edr
 +q6Q20cI8AMhq81JbUNrJYCJB7EaUMjn+EmPHUTcl4bKorNMUAuGvMlbb+KQSaf4gYXTFNk
 AUnA91PAMjOfqXxZCe4VNZIT0bSc4Uvh+Z4MZPfx4cHWETDLXeno3XLfONWMQ0hz/6U/c1g
 GL70E2pePHHCsUhLC9KEYZF8eiBZ1m+WNf65GZoJF4WUF19cMstJL78bdd6vtKl/FKqiwSy
 PtJNtxRGf39kmWQhAPVfDMI1WhUyd2WmeyX215CkOzFShWRe1ZTUSUdLKTmk8=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
index 9846ce3c56..fe3206d797 100644
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

