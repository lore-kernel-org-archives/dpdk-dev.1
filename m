Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E58FAD3F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA0FB40693;
	Thu, 23 Apr 2026 05:41:14 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 4569840693;
 Thu, 23 Apr 2026 05:41:11 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915668td93e6901
X-QQ-Originating-IP: kBJvuTcASnKciAiqlji85V3efzha6oUz99RMYjchvNg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12783357493678094000
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 08/18] net/txgbe: fix link flow control registers for
 Amber-Lite
Date: Thu, 23 Apr 2026 11:40:13 +0800
Message-Id: <20260423034024.14404-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M/NR0wiIuy70VJkDj6cU084OhXnNDYB+uXchobjy5VyY4IlS3g5FlrwU
 g5z42M70BE7CEkFZsYwEDtf9cEz3Mj9jkouAy7Vg7pevwG5F07TWAXKFsxtwzwXBGgUron6
 I1CZjP/efHKHY2QhJnjde64I3KWZUToVSD73QokoK2ecFMhexrlSWffFicPTS9G5iT16vn7
 t3B5Log/KmQB0uyoRb/l4DF+yDGvotPuge0ewbTZhrpy2Wem+dCG1I0SmnC7OZybZUhz4Ma
 027qhXTuoqsv0FAHC8ZhRYRIbNhf8W0PJN4ze0LvTEgWucRb53egJ/MIJ4B1St+DRFqxpRE
 YAV51vPpKWbnpTkJu1uv/FwcwE90eWeBnEgDqdHs2dp5i4BLumBa7c/jTxcq3F7rB5mI57Q
 A7NZGH0OmppyMW6KqsngkHgEgX+U79nXcU4gRmGLzCLz+V5RSUUVRFTiAt10WUtkDXMvFBI
 aCc3bLGeiBuZ0PmkUNY76xjb5HmWsQBVkAA4f9+SD8CJ4V3hzS4yf6uiagW21532ua0xr33
 ApykLHeURWysT1Gj2f07Q+wkT9oFnyt9ULH2Tjq3ZznTc7UH2yfsgdLaMrHPPX/WChBOukE
 YM2IBsJkeAtG113kwvI61IGidJ+qcnXDA99CgrW9XivcIQSCrbMBXtwOdPrA4HUTS6kKhkA
 eDdI86u6ln+AngMI+ep/Xw19RrzORA1lNahcXZaHWx9ZpJFojhLm2Hu4qFwBpu67fhgIUcs
 f15a/kxtJNnAxL1KMLarwCIu5pPjnEMrpaOJxPQnwoyM9aup7PCLohxlDAmjIBWhZMriR4Y
 dFN3S9KvbFZmC8WE/HYy+EX63SzDEob6Fq4oeV7x+Ar4reeYmi/dekyeLzNJ8PC4cWFz1E9
 MC8GothhvetXxehOPY8gJzNsith4/pzTq9PFGCjG60LUNXX21JUGMihycavj0ImbULFrJhE
 4kO+uniXAjmUst4dHI13S97W6w4fS7yyiMw33Q66gHnanEYEELA8uQf3t7qR0KZlRT1ykvH
 /6p8F0s2up666H1GiTsu95guDLBPdgi9kkL0+RsGomQRoSwhD8eardi0Y67L0ydrAmW3fHF
 c/JXCpsLb8b
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   |  5 +++++
 drivers/net/txgbe/base/txgbe_regs.h |  2 ++
 drivers/net/txgbe/txgbe_ethdev.c    | 10 ++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 0f3db3a1ad..52fead6171 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -394,6 +394,11 @@ s32 txgbe_clear_hw_cntrs(struct txgbe_hw *hw)
 	rd32(hw, TXGBE_PBTXLNKXON);
 	rd32(hw, TXGBE_PBTXLNKXOFF);
 
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32(hw, TXGBE_PBRXLNKXON_AML, 0);
+		wr32(hw, TXGBE_PBRXLNKXOFF_AML, 0);
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
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 414107d7a7..e3492c9cd7 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2331,8 +2331,14 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 		hw_stats->up[i].rx_up_dropped +=
 				rd32(hw, TXGBE_PBRXMISS(i));
 	}
-	hw_stats->rx_xon_packets += rd32(hw, TXGBE_PBRXLNKXON);
-	hw_stats->rx_xoff_packets += rd32(hw, TXGBE_PBRXLNKXOFF);
+
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		hw_stats->rx_xon_packets = rd32(hw, TXGBE_PBRXLNKXON_AML);
+		hw_stats->rx_xoff_packets = rd32(hw, TXGBE_PBRXLNKXOFF_AML);
+	} else {
+		hw_stats->rx_xon_packets += rd32(hw, TXGBE_PBRXLNKXON);
+		hw_stats->rx_xoff_packets += rd32(hw, TXGBE_PBRXLNKXOFF);
+	}
 	hw_stats->tx_xon_packets += rd32(hw, TXGBE_PBTXLNKXON);
 	hw_stats->tx_xoff_packets += rd32(hw, TXGBE_PBTXLNKXOFF);
 
-- 
2.21.0.windows.1

