Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D0CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:20:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A2DF427C1;
	Thu, 16 Oct 2025 13:19:52 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 9AEA9427C3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:50 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613584tf476054d
X-QQ-Originating-IP: duvf1iA/zzcquW6EPjZ+9co1hEMzcTbrCApI/fHKZAY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13276757711631801462
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 11/21] net/txgbe: add RX desc merge mode for Amber-Lite NICs
Date: Thu, 16 Oct 2025 19:17:25 +0800
Message-Id: <20251016111736.25372-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MuSZonXTFQ5JZxGiQW4ya35Mw1XeoeaWCYOMRnYRZ+tiHPJKgBpOufcH
 n3VRnLZbuzuOVa7OBygvF8eGGRrhjyhwt/rSoGzH5nozchl61UqKtBu32t7XrVeH94ZY069
 toJ+uhtguhgPdsBqzJu//I77CXL/NPhhHXI2rS1ectjhYWaLlDIuLU8h8e+xzoybLwljgQS
 iq0HbYh06OxeQnOWhvfUiiUkBuhfs4Mar/2lPIWRNeJ5RGalz3fSoni74o6nHad/gBbwnmS
 igXmllhp+zdXU34gY4Qz7dtea5IcWJ/aGbW1PbBi4+cZg0sN6Z4Q+5LDmd4g9wYwnERbt38
 A4UcWjXeHx7tagouX0VGnLEQu3Qs45Up/OBYk4sCis6pcl0EmbNl3KqLy9gk/x7qE7jm5C6
 OcRN6M6qrPmKuHyHCcld0XEF6dCu65J6x3z5bAsf8YBOoj61FeVRS0Bo2vyrm+XpyMeHG0L
 TKcNtyCMM0Vla7JN+T5fyuU12s4Q5kEyfTic08V6znoFb46GcQL0pJcGAsCVRvAQDuNC8mT
 ADoLvD/tYiOhhH/7wX3dNYsC12xJdmSYCXBDSBjfYE5wr7jErEEmA0Iso5Rgkz0dCx8D6/F
 hutFo9MiD8t33R49QAY6kYrxP4iKoNxOFO1hkNEdrtrYJ0EymvC/T+OnpYAzMhqhNjIoiYi
 6s8T4gHHg2Vb+ljQly/rAUeJ4PgoloOilz9n2ewBWe23Aq5Ip/KPWHwtzrGpNdmVNLKeM1A
 3GesMzPmOPsvqxLqZKK5MlMesMZnJtEClN2afTj4iJYQ8kOpOEd5QDPuSD7JBF3sSaI5Hj4
 fmPdMD1Pq4OKIX9zh11PqHm01eR20CzMt0RIw7ISFihs/0HRI3d4cysZUyEx+xtwf4YopVt
 0SYie0jl+sCq9UnDvErGe2JDNhIdi+DKlAxIWZbgxXxYS/Q8uA5qhIFiYae0kuqClWk/d3h
 W2w3kzeI33Um6WKVmcZLPdj+Pw+TsQpyFiy1qYL2PW7/Ct5LKwciSb+Pf10A/XHXEUEd0mf
 CYGejznoHo5n/t91g9iA7ceI7tSBhIL2oXv4O5J+6gMmTKLbarPto3Y43fOPt8Pm6QQokcq
 xhRrWAZUT9U
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
index 219f4c242a..9c2b740d2a 100644
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

