Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A7BCD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA1EA40698;
	Sat,  9 May 2026 13:29:14 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 65F2740698;
 Sat,  9 May 2026 13:29:12 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326148t1e944beb
X-QQ-Originating-IP: EplhUoLk0Xj8f3xKUmr3itLF2vpn5+KbFGG0sF014PA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4571642426925269306
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 08/20] net/txgbe: fix link flow control registers for
 Amber-Lite
Date: Sat,  9 May 2026 19:28:10 +0800
Message-Id: <20260509112823.7728-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OKkKo7I1HxIeNGaEzweXVqW/VOThVlxUahNqVL4CG5cGee7lxp2zR3SQ
 h6XSNp2cKix7X5KvrQtqT2nn8phGW4iBXNM6FUpqmMatisxPLHYsPz5DLl2A9MYOdPtUCzB
 iNvdAxVsHmqOvyg83GT+SrEW5KUVuxw/7IMNELg/vi9Jm/lmmpMCWjQ7R1qZJ7nUaCARnEm
 DkWeS4cR1eOpLRWuj5LOfuPuGoHXgu+jNRBEnOlbN9YBYubNIaPiAeuxjHrYRkIbXQsxqAF
 EuILeZduHNnLIxrtasBVhBR0SyLsmljZUvfaaCYsmZy0P7e/gIbgayat8Jn8baDrResaTkW
 rgltqyKYUWiFX5BG+++YgV+GvbUmeaUdmlc+R7HOxh9weJ6mBSQIFlxKZ2EIJ3oaK/fmh4Q
 IY3V9aq5XDAJ+xF+Xy6eDEVHP8Oettj2EH9bBznjLCKn+u3rrxCwH7+3YWjOmGNmcXXVRFu
 RV6enZtIvIN6OhKWI6hHtIu9N9f8lYdQF9Q6HhGLq+ljCp4de0dXvZf6s4c86QjwqlZkTYe
 Ks9wakxD6lSvoafnbksNnk+HjrMzyqV9s/y1M8WHyl+kVClWXyGreE+AEnTC/Mq3RPzyhKP
 TuHf10ysLEvMhDGOgmRtuRJ4U5d1PIGN0eZkJekx9rg+OWrKzw6JUC0I6PJBUnb88AGCeLb
 5l5lIFj5LXlofIvrkXvRYdz7rsRqGsmBufaDns8kim9Hlt3zzTBu1Q+m7270PGOQJXOPB+C
 17/7iCkGJNfjGdkDxg74V9qkipNVI1WTS1tL942xYMR9TkpqOCEIb9EMS2EwA3eZrie4t7M
 33uyTCMy4acaadF9oHCLRHOAuOJL5lrJcBL11RW2+1E4/HFKPsDiky6FhaLhHJuqyREkBXn
 pH6lFed9Z5m+9Fp5w5Q6VFQhiWJfpySxBTdqB/V0gsMOIy5I0SY45HUCinUeHlmwVsNyffX
 xKuWENz6DAVSXI5gngo2nROLSQYf8QjED0LnpEuKiknRTAUDV9NtvsEmjWYFTQhArq9cBPR
 sjJcUqpjj3pt3z5CSLzJRusCBROPf/lGh7kDQYNZU+YJraxKQPz8DC0hjMxW8+3v8HLEpeM
 pMXMLwTQIVI
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
index 060757323a..de382601c9 100644
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
index 414107d7a7..3ae233f70a 100644
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

