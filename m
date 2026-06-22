Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D6CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C9B4065B;
	Mon, 22 Jun 2026 13:11:54 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 9992740667;
 Mon, 22 Jun 2026 13:11:52 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126710t94e0eea2
X-QQ-Originating-IP: uoqDUJE/8tEzcy+2w4xkwjn4Y0D9zsdN/asRJrjG/H4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15744902662989337152
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 08/21] net/txgbe: fix link flow control registers for
 Amber-Lite
Date: Mon, 22 Jun 2026 19:10:56 +0800
Message-Id: <20260622111111.21024-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MN7J+qOXnZ1LEUF/rAEbyng54J9TpIEu6cY8Uq88y3j+8/c0nAoll7Lm
 yehfmBDyd3miaqC1bB2WcC2EkPOGCcTWm+xXuHx3p3CihvjCJejx3roLG7nlAGR2wJqUQL8
 yiYpCvMl5hN+nzPVf9vY9GM48I4IG+YH6hg8fnChIOCyH8Zx8SxZfqQ/7oQ3GfeKk5GR+GM
 aGTvFuUEHrZwMLB5DWIAbKNMU0AEcZA4bbg506HzE2qA1ch4kd43C6S/D3UucVbNnu0jBW1
 rfNQ+qOBUm8mdvmCd9RfI3Wi7SFZgfOmNhy/6z8/UBItbTBscVtLRtCI88ON4xbHK5HivZU
 pdLS0eoF+In6ICowV4nAz2AOk+doTjvL2j3jN0y9XviWFOcrNQ56oUfTOvQoNQXe1eqPGe7
 2mHRwbkqKpFNXOvg6CGaNHZ1BRR/5p8xb85kw4tvyL2rGfwTnEB2s2R3IUiYCm91cXnDWx7
 HaP+FqIvThPMNOWNRuYxv3ho2K+IXYeAr3PRBQyS/lx6ywx8eW5hlutnKs/4jGYPDFHwoDf
 soumZhTplPyXtWzqihigH48furON9gjmedCGRtR4C+Cw9+omn+819XLwX+uf6QivuoGHRXY
 AGbFcmcnxlyqMrFWMRuirZF51RVxHWqIqLp5plZVw+u4gqfwAuTelXeXOgAnY1di2EjBsAR
 +KETTtBvriZFqPJQy/nQc57gPbDMLQJavnFmxkIaUisUWt0Qx034wxFGn9aiaiGHpS8bE74
 kS1ahit0WsW5rQGMXFbBy2ZkqPiP5KpNVzGWVSTrc1afPnO1M81rctt/jAMsAblgkjbOtHa
 WYUOMx1/Qh1aHyDaqcRU+n8fhJT/cfJIzJegR9Vr2WUIM8Ti9kuQ+SuYOWcvRvZkWAJn60L
 SNQK2A7GV/mEZtgq+x/fgmcbBvaOOK9ctxkINyaXOHb0pxA74rzAoOkBEqafnIasOQ4Q70M
 5NBXJW3/jXfgBep0YBqRI6Rs6S+SMsZgwKw8SYTGbOk+o3fawpRyRR9id9FZd0nIsyWiryf
 Mk4zc2ftnPM8ez0/MCo4lmdtYJYK4l9FJSrJSABkFA/whI0Ztbx1F5e+NNUkatfkcFuJ9ww
 Twb2VrUwBAbTxzbam7Y0HFGNeC+4BLJOQ==
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

