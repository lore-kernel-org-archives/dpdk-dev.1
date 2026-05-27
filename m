Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B5CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E163640A6E;
	Wed, 27 May 2026 15:03:36 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id A005740A72;
 Wed, 27 May 2026 15:03:34 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887012t1792fa6a
X-QQ-Originating-IP: P2wGQ+Pbadzg0ZvQ70rkPmihP8VHO9TmI4PvcBpGRas=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7363216502583722921
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 08/21] net/txgbe: fix link flow control registers for
 Amber-Lite
Date: Wed, 27 May 2026 21:02:08 +0800
Message-Id: <20260527130222.24348-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NFCRr/yKd31oVIZHu/+GqyyPd5rUAyJBcvKLPNRhZfPvTHm2335y9Slh
 SNZ8asBm/o1eSci2Dh8pc7ae0Q/57s0dZU+A98WGlU9BdZgsNqwd+juIxEogNzl7r407wWi
 aEeUB6SxedVUBWwiEAim68RLeNfh4TYYp7Q6up2LV9ko4GCOLmazj9rsc6+lihzoCi+u+SW
 OM9oJBAD1gR6hfbB5dFd6Jqon14WjuAyL/zJSXF6PcQuzRlDqGuuSE6ZxzbODiMTgZ404qf
 ZUyEumTdU/5xFkxAxGR9SOVB4471+FSLB8jfTk5j7j0T8cYVSsYS2Gk7SJG++wBWuRqJL8K
 slaxdA2G2aIq8vdqyOwtzBI62UHOpva9NkDo9xNoB6GAzoeOOco71DJ3gzsCcOyXkwEX18G
 YC6T6oXyQ1rV3rqWeWm+Xww4XeQg2jHJnum4bePqi7CdRa8QE7qZKHr4wZv9yDlknkYJHkj
 N1ijkBTF2MJU0xoj7thCJJ3eTs7qO5LAyo64en3dFYgf7axjBQCR40Fpv3mPDKqqbZyUYua
 uL1H63yP22xiwoMeZjHQI5ctpRmrVNKNYTtIK7YCiUl0IjwWH4FQXTyJOX5xXhEqRI6LOPh
 YSqIf/Qu90O186muf0T/sT9UjRJJ8+u02U/hkXewlmLV9u87z8bpe58daoSwpQm5xOhiELB
 Slc5rejO3AXxniQ69eTElq/41NhH0edMekjrZfL7dhGg5YGuy5avN47JRKR1bnxX56bLQeP
 QTTj1ksFbqcQ1hWk86JAYg1XzgrMwdg2mM3B+/pT5g3fEsHHExNS1Ad2XhOGTBEvuOP7yCr
 uKp8SL1hQT+BMQE/rhKaUd6KYnbvnv5BiUQpueczBKEn/WOyCE8pfW3NoNM8CMjnizLdJZf
 ZsoqEQzXyZUV+ZEN5A3uNocFqUbbatAIE6w1f+Ts8wRAz3lsxErsc3dWQb7rFwQ1j48ZuGz
 lA7o6BM46tRnNcoPGV1fUDR51pBn9Ee8fdPrVbPt9ZzYGZUCHA9fP2JSmAcXEKmNBNNBjci
 wrYlba7+o/Rmab13UoLsGCaVUAxnFiRxJpVDxsTgMb/LDf4gTXy3YAiIfB8QKnqzZHzALhd
 hpgH7mkvLlyE4+rPWlJLys=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
index 099341b5ab..9b5a4b72e4 100644
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

