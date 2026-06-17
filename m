Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD77CD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA43140DF8;
	Wed, 17 Jun 2026 10:15:03 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 181FE40E20;
 Wed, 17 Jun 2026 10:14:59 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684097t47f1ea83
X-QQ-Originating-IP: ejKKMI2pzYXhKVxmi9ev0wQelQBYUKEFJTDuhUMWp9o=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12136605923231445968
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 08/21] net/txgbe: fix link flow control registers for
 Amber-Lite
Date: Wed, 17 Jun 2026 16:12:55 +0800
Message-Id: <20260617081309.19124-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ML8hOghqQD+0dvE7qhaKQH2Pmbf2mi5IDJrIwsxRYTbaYxAg+hFPjzuq
 Thy4pYuitplFk33MZLwRw8F8g4pkN0WNbet3mOR6XmjzMwvlvlwhpg92UuwK/rGV3xIgqt2
 LhRIC1QDXT87H9Xb4DNqjndhtudmzFwg/aNdrxP+8LR9DXJp7yc2Gcu0z/84LtT32EFSXx9
 IWu72jVtPLIPwWkTpbB8rKCN4QpxImJsS0gM8z2YPUJ2yqq4a+bledHY4QVNhbLlQsThF0O
 BI7PvpoJQd/1qFk4+1L4iTFrKNHjGVJwxTxin/6zgRJZFmFvjAYdR77OH9DRLoOKKoGvSD4
 0l2iWPIDvnLvfwAYf5Gz/IT+5cc/6cJuvqipkPCFKLGAhwola6feG/YlpgDJp09R3xY4ZVW
 ZEJSsu2Jgb66Y4b2SyK7urfJ6eeTPuPSSxMPy0/gsse5Q8v0qpg8RMbIpV6Ky0KZvaleFQV
 RV4XwehPCFDFjmhn9+CE4X+MlAUZtqJU7eZX++LjjjJmCL9aTFediY2EMn8dNznE0liV7QG
 yMBKm5SxQC38l7t5dUoKdZr8Kx6jHDLAao+r1lbIKp97HJIZmzZL6ox/gQ/HPgoD29vAdE9
 5b+SRqUpg+NLUwX3OeVXkr7yVuI7vipk5oMRCZKh8wnYKprXToZO+TI3il3HvRfGs29Wny0
 HGfFxvAImDgndf6Z3HlRTIyFGt2cwqPvh015W6diuQC3sPpGlVDB/mNI32ucn8+4k/yVJFJ
 Kkqm61ijEZOP+9DUbcm2JpmCVSJCX+XTDQvAWlNp3kpIIqeA+EFTlw7CzNORxKt/ghdX/Lr
 Gl7XCC/GUGotRyfoECZBBPeRYfiNKSj3ht1uN7T9DrDMhyfsmOk0VAUx86vZIhpcxA07PLp
 wPAL5ZtELZ2kKHK6ediGCwDhlSDmwipX9C5GafJRtYMa/QwZrltOzKvRf4ON5ObAB4gO6sM
 x9xP5KCU816SJ40leKmeHsATTBBVc8itYHGLOaKCK6qk9adtxKRwgOZdK46KO3rYkPSje0a
 YnUqxmBoabmHNQVEASqW9nkOp210ICUpZbqGOW0XNkIERj7CJu+w0P9vaF7DN/NXo3kHMO+
 8aD61r3+DsILI2zOEpFNxZ7gOiJe+lAag==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

