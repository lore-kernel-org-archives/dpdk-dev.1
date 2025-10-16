Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8D0CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1A75427C8;
	Thu, 16 Oct 2025 13:20:04 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id BE8B1427E3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:20:02 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613597t2da926ba
X-QQ-Originating-IP: dcnKHmJLrCKHHTFQf7S+fDL8/k1OVHX1mswjaWGQJXs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14402060307665585284
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 16/21] net/txgbe: add support for TX queue rate limiting
Date: Thu, 16 Oct 2025 19:17:30 +0800
Message-Id: <20251016111736.25372-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N6kxY2waEBPd6Fo+3Lh5V1FqNziaEAajHgVLWqszQFw7Z2ZlcJCheDPV
 xs5Myw2g7pblVVIPa4DwQfu46g6ACK2LtCmz48wz8LUjjNoaprCPwVoB420Xa5xEJA1F2zu
 ZnPligvFJKn/LcT1hEO71UCuxVEcjohQ+kU+PNzuILVMXs5iT9u9Ao2uh20sd0R+xfgNPbv
 XNunQN7+hCmnDJwlxcvmwBvio7jhw0dNNHhr9RpjltkaUZnEtMVffXtDsucA6Gka6cMcs2K
 4on1Jky2niWukNp8DWXT4y++wAHSmnSXnGqUdaPMpJXNp+ERZW9w4V8r+s25oswMTezFZik
 xnSwvf/b793QkpeSQ04IRn61fwofAM5sXaoG/n1Py7uybK65YvAbmIe+K4JBjsuEXSzhpA8
 bfB0AwMai2nCDVezO0alEYVHlHXIw1iDAvxDbROhiTFI/fkZiOLqRjM/xRXAmzI5eqYuxUU
 ake9HArR+S2o2BD7R5MImjafdo0iCUZJ/l4S+P+PwXudzPEGAn33kBtQrTIdMCOgPe9Abii
 UyZQomqbzgwLjF/JhJArX5J1kE23aLYlrWwScShJpNBD9y+TMfHHk3aznVy7TukbtBXu8th
 ujXOT4NeWtXxzoh/5Xzkr/IKTniVY0+f2gpD/G8mpwKAhSE4EbNckwCsf1ZI0qRKItFk7+T
 nWw68WqtDAYNiKD/pc2DalevoUTLSnnRia9vqHRs3rbdrxMHKJL9d0a2je4RPMDCh39icva
 0SaotdwL2wIljcBi6w19AEJnN3ZeCV+FpBTGtj3nh9NZ9hV0I8IPc5/0PQmYjqErLEZHrs2
 +WSurQPQVqNBHUH1zVSiR76BTaxvSQ0Z3voDi+rMdDxzqY7LL9iPTFFDrkuaagvoCXJkT3U
 r7K3KqYgIiH8KpvKnVXwBQqdUw94pprC3UDBe+hd+bcTx7KAA1S7J86fXhC6lJ2bZYFDWtE
 COP8xzSm34NQ7cB8DlrjWKdQw4aX67WD/jCpYRpX+cWfuv7xmUJIyIGH6qMNBi+d3zKOhUQ
 D63yoCOfJMwyMfIfcnkRXoHEqfWRn2yw00szdj7Ujj1FuiSZq/vAP9dXLkO+Sr35R54lmN3
 AJjw6phyhUw
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

Add TX queue rate limiting functionality for Amber-Lite NICs.
Due to hardware design differences, the TX queue rate limiting
configuration for Amber-Lite NICs requires updates compared to
Sapphire NICs.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_osdep.h |  2 +
 drivers/net/txgbe/base/txgbe_regs.h  | 12 +++++
 drivers/net/txgbe/txgbe_ethdev.c     | 69 +++++++++++++++++++++++-----
 3 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_osdep.h b/drivers/net/txgbe/base/txgbe_osdep.h
index a1477653e2..f4282b3241 100644
--- a/drivers/net/txgbe/base/txgbe_osdep.h
+++ b/drivers/net/txgbe/base/txgbe_osdep.h
@@ -164,6 +164,8 @@ static inline u64 REVERT_BIT_MASK64(u64 mask)
 
 #define IOMEM
 
+#define BIT(nr)         (1UL << (nr))
+
 #define prefetch(x) rte_prefetch0(x)
 
 #define ARRAY_SIZE(x) ((int32_t)RTE_DIM(x))
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 2e0ac9c742..f2e4994863 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1656,6 +1656,18 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_ARBTXRATE_MIN(v)        LS(v, 0, 0x3FFF)
 #define   TXGBE_ARBTXRATE_MAX(v)        LS(v, 16, 0x3FFF)
 
+#define TXGBE_TDM_RL_QUEUE_IDX          0x018210
+#define TXGBE_TDM_RL_QUEUE_CFG          0x018214
+#define   TXGBE_TDM_FACTOR_INT_MASK     MS(16, 0xFFFF)
+#define   TXGBE_TDM_FACTOR_FRA_MASK     MS(0, 0xFFFC)
+#define   TXGBE_TDM_FACTOR_INT_SHIFT    16
+#define   TXGBE_TDM_FACTOR_FRA_SHIFT    2
+
+#define TXGBE_TDM_RL_VM_IDX             0x018218
+#define TXGBE_TDM_RL_VM_CFG             0x01821C
+#define TXGBE_TDM_RL_CFG                0x018400
+#define TXGBE_TDM_RL_EN                 MS(0, 0x1)
+
 /* qos */
 #define TXGBE_ARBTXCTL                  0x018200
 #define   TXGBE_ARBTXCTL_RRM            MS(1, 0x1)
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index e6694f7fc2..c7c3668066 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -4245,33 +4245,80 @@ txgbe_configure_msix(struct rte_eth_dev *dev)
 			| TXGBE_ITR_WRDSA);
 }
 
+static u16 txgbe_frac_to_bi(u16 frac, u16 denom, int max_bits)
+{
+	u16 value = 0;
+
+	while (frac > 0 && max_bits > 0) {
+		max_bits -= 1;
+		frac *= 2;
+		if (frac >= denom) {
+			value |= BIT(max_bits);
+			frac -= denom;
+		}
+	}
+
+	return value;
+}
+
 int
 txgbe_set_queue_rate_limit(struct rte_eth_dev *dev,
 			   uint16_t queue_idx, uint32_t tx_rate)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t bcnrc_val;
+	int factor_int, factor_fra;
+	uint32_t link_speed;
 
 	if (queue_idx >= hw->mac.max_tx_queues)
 		return -EINVAL;
 
-	if (tx_rate != 0) {
-		bcnrc_val = TXGBE_ARBTXRATE_MAX(tx_rate);
-		bcnrc_val |= TXGBE_ARBTXRATE_MIN(tx_rate / 2);
-	} else {
-		bcnrc_val = 0;
-	}
-
 	/*
 	 * Set global transmit compensation time to the MMW_SIZE in ARBTXMMW
 	 * register. MMW_SIZE=0x014 if 9728-byte jumbo is supported.
 	 */
 	wr32(hw, TXGBE_ARBTXMMW, 0x14);
 
-	/* Set ARBTXRATE of queue X */
-	wr32(hw, TXGBE_ARBPOOLIDX, queue_idx);
-	wr32(hw, TXGBE_ARBTXRATE, bcnrc_val);
-	txgbe_flush(hw);
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		if (tx_rate) {
+			u16 frac;
+
+			link_speed = dev->data->dev_link.link_speed;
+			tx_rate  = tx_rate * 105 / 100;
+			/* Calculate the rate factor values to set */
+			factor_int = link_speed / tx_rate;
+			frac = (link_speed % tx_rate) * 10000 / tx_rate;
+			factor_fra = txgbe_frac_to_bi(frac, 10000, 14);
+			if (tx_rate > link_speed) {
+				factor_int = 1;
+				factor_fra = 0;
+			}
+
+			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_FACTOR_INT_MASK, factor_int << TXGBE_TDM_FACTOR_INT_SHIFT);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_FACTOR_FRA_MASK, factor_fra << TXGBE_TDM_FACTOR_FRA_SHIFT);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_RL_EN, TXGBE_TDM_RL_EN);
+		} else {
+			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_RL_EN, 0);
+		}
+	} else {
+		if (tx_rate != 0) {
+			bcnrc_val = TXGBE_ARBTXRATE_MAX(tx_rate);
+			bcnrc_val |= TXGBE_ARBTXRATE_MIN(tx_rate / 2);
+		} else {
+			bcnrc_val = 0;
+		}
+
+		/* Set ARBTXRATE of queue X */
+		wr32(hw, TXGBE_ARBPOOLIDX, queue_idx);
+		wr32(hw, TXGBE_ARBTXRATE, bcnrc_val);
+		txgbe_flush(hw);
+	}
 
 	return 0;
 }
-- 
2.21.0.windows.1

