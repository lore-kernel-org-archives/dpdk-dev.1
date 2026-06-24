Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D77CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E35294067D;
	Wed, 24 Jun 2026 13:53:22 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id A725540A6E;
 Wed, 24 Jun 2026 13:53:18 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301996t7fdc54b6
X-QQ-Originating-IP: F6m3S6g1fLhB3iizKQvMhQjXcaWdiUjapxDNU7lhUgg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1372060461972652685
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 08/21] net/txgbe: fix link flow control registers for
 Amber-Lite
Date: Wed, 24 Jun 2026 19:52:40 +0800
Message-Id: <20260624115254.20348-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NGWqk+RSQ2Da8LDZvCOReIWa/qsraxMvSprOpqPLLeYIQUOhyuQk+fEp
 wii64rrB4XWXiMoMLK6NlT1zlDFw9sJk+g1bDnbVINu0YeFu3x7c5sCmPTEqAdmfHBUsfzk
 qfqDK3WJfoJJm9jGrhz1XUKOUtQouiNKl4+0mlQK0lG+p7XsLgpiLx8jUisRLwUUM0dlLI4
 55GaewnJCWMIXphxxWTEdPtJH5N10nLtATlmmXwE4Y+NBEAp9xln/IKTuLapVK11cUMmaOd
 PPXQTekN/59e1gu3+o5g2Fa3B4OM8fzIJtoQYrwqdjMGHYV8a5EUqF8oACwVrd7hyFD5WT6
 pi1fTtwosTAD8WSQuPZn2qyyHerBAHvHXjMXtWHnNm89R0u1t30QvpeMm57OOlEBd4RJxHm
 YNdoFCJufvi4E1rdeO4YCcfJaqKRdqFsr5BspjJ5mBu+GybZbDFgwx10GhiJ0tFk8KhaTg+
 ICmnkPA5QPZ/1Xy0SYwddfFR/21yNUrBDlH7TloBsfBzXmqOBaxI00zbM+sYNDtMFgJEzM1
 yMIllUYdtqg67Fr7Y4U6dPdGbKqvNghgXUojHyAYAX+WqpmsUdBLgavMYPpNMTDwuJa68jn
 TJ7FUs1qL/BBLV9QDeiciFMamlCiUYnTbatNsvO1zZXudZ5bxKP9IXlvY8lBQAAgEBn+crV
 QuxXSvF983x8/BCgMlwnDiM2O0if/avIz7AcUgjzNJB1sG0TkLYjW/54oRdoYE1I/aUDYvB
 tfw94dlOZh9Baz3z8c90rP1Uxv8Yhd9qRrNMgEHsjm4y7TWQR14IyYnE0+nnlbUV4TUYQBR
 J9RhMuqp0OgHJZow7P2ixjCWWgnX/m0p+UJnklWVpcCA+h1vv+z0pXHZKySUB5wwS6sFmhA
 UybI9DiB5FzpjO15NHQs77SYkOfWF3G+CjHDhNYtAGwNVM0T7OXssLb4jvMhzIMSO7QDAD/
 T4nSi70a+/gc8uDbWaAZcrpQzfjXn+SaG2aXUIMuD4lkmp41AkLbLrvqFAe0XapM6qV5gUB
 nMtFaX2NYW8x2xeLTD9gi7E6mTDusOU4NZ/REdQyF1YiKvEds8mNuIODzYV/55CV3jef4tB
 Ybx6KDkyxiXES6P28xBSQveu61756d390DV5NTOwkRsjKCYQaGu7cU=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

The flow control counter registers on AML NICs differ from those on SP
NICs. Update the register offsets accordingly to ensure the counters
work correctly.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   |  7 ++++++
 drivers/net/txgbe/base/txgbe_regs.h |  2 ++
 drivers/net/txgbe/base/txgbe_type.h |  4 ++++
 drivers/net/txgbe/txgbe_ethdev.c    | 34 +++++++++++++++++++----------
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 0f3db3a1ad..0d3310e15c 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -394,6 +394,13 @@ s32 txgbe_clear_hw_cntrs(struct txgbe_hw *hw)
 	rd32(hw, TXGBE_PBTXLNKXON);
 	rd32(hw, TXGBE_PBTXLNKXOFF);
 
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32(hw, TXGBE_PBRXLNKXON_AML, 0);
+		wr32(hw, TXGBE_PBRXLNKXOFF_AML, 0);
+		hw->last_stats.rx_xon_packets = 0;
+		hw->last_stats.rx_xoff_packets = 0;
+	}
+
 	/* DMA Stats */
 	rd32(hw, TXGBE_DMARXPKT);
 	rd32(hw, TXGBE_DMATXPKT);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 3d1bc88430..22c46e3d56 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1085,6 +1085,8 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_PBRXDROP                    0x019068
 #define TXGBE_PBRXLNKXOFF                 0x011988
 #define TXGBE_PBRXLNKXON                  0x011E0C
+#define TXGBE_PBRXLNKXOFF_AML             0x011F80
+#define TXGBE_PBRXLNKXON_AML              0x011F84
 #define TXGBE_PBRXUPXON(up)               (0x011E30 + (up) * 4)
 #define TXGBE_PBRXUPXOFF(up)              (0x011E10 + (up) * 4)
 
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index ede780321f..505f598fb7 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -876,6 +876,10 @@ struct txgbe_hw {
 		u64 tx_qp_bytes;
 		u64 rx_qp_mc_packets;
 	} qp_last[TXGBE_MAX_QP];
+	struct {
+		u64 rx_xon_packets;
+		u64 rx_xoff_packets;
+	} last_stats;
 
 	rte_spinlock_t phy_lock;
 	/*amlite: new SW-FW mbox */
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index c97a7f1a4e..94ac89c7f6 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2264,16 +2264,18 @@ txgbe_dev_reset(struct rte_eth_dev *dev)
 	return ret;
 }
 
+#define TXGBE_UPDATE_COUNTER_32BIT_GENERIC(reg, last, count, reset)  \
+	do {                                                            \
+		uint32_t current = rd32(hw, reg);                       \
+		if ((current) < (last))                                 \
+			current += 0x100000000ULL;                      \
+		if (reset)                                           \
+			(last) = current;                               \
+		(count) = (uint32_t)((current) - (last));               \
+	} while (0)
+
 #define UPDATE_QP_COUNTER_32bit(reg, last_counter, counter)     \
-	{                                                       \
-		uint32_t current_counter = rd32(hw, reg);       \
-		if (current_counter < last_counter)             \
-			current_counter += 0x100000000LL;       \
-		if (!hw->offset_loaded)                         \
-			last_counter = current_counter;         \
-		counter = current_counter - last_counter;       \
-		counter &= 0xFFFFFFFFLL;                        \
-	}
+	TXGBE_UPDATE_COUNTER_32BIT_GENERIC(reg, last_counter, counter, !hw->offset_loaded)
 
 #define UPDATE_QP_COUNTER_36bit(reg_lsb, reg_msb, last_counter, counter) \
 	{                                                                \
@@ -2331,8 +2333,18 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 		hw_stats->up[i].rx_up_dropped +=
 				rd32(hw, TXGBE_PBRXMISS(i));
 	}
-	hw_stats->rx_xon_packets += rd32(hw, TXGBE_PBRXLNKXON);
-	hw_stats->rx_xoff_packets += rd32(hw, TXGBE_PBRXLNKXOFF);
+
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		TXGBE_UPDATE_COUNTER_32BIT_GENERIC(TXGBE_PBRXLNKXON_AML,
+						   hw->last_stats.rx_xon_packets,
+						   hw_stats->rx_xon_packets, !hw->offset_loaded);
+		TXGBE_UPDATE_COUNTER_32BIT_GENERIC(TXGBE_PBRXLNKXOFF_AML,
+						   hw->last_stats.rx_xoff_packets,
+						   hw_stats->rx_xoff_packets, !hw->offset_loaded);
+	} else {
+		hw_stats->rx_xon_packets += rd32(hw, TXGBE_PBRXLNKXON);
+		hw_stats->rx_xoff_packets += rd32(hw, TXGBE_PBRXLNKXOFF);
+	}
 	hw_stats->tx_xon_packets += rd32(hw, TXGBE_PBTXLNKXON);
 	hw_stats->tx_xoff_packets += rd32(hw, TXGBE_PBTXLNKXOFF);
 
-- 
2.21.0.windows.1

