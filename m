Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A3FFAD3F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A037C40664;
	Thu, 23 Apr 2026 05:40:58 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 53E0640615;
 Thu, 23 Apr 2026 05:40:54 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915649t63947e28
X-QQ-Originating-IP: l3Hy5Wom0rKXHM2B7Y9WqBGJnrHQxo4Q4H1BmNNp+r8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:40:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9504303853455918794
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 01/18] net/txgbe: remove duplicate xstats counters
Date: Thu, 23 Apr 2026 11:40:06 +0800
Message-Id: <20260423034024.14404-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MostCOYFA6wYzZoCfu18HjbQxTTz2J8pDTwGMq/gohxaL/iu5nOfNsqU
 Um8fg8SnTg8K6KzhSCXl9nQtLtSyIQTjHBo0xcnKOZpmri4rxg4cWivSoeQF6jSZuwAQk++
 vQDHmiMWQS2qin3SPnrntuaYF1w5ebxMpXBzi8odTPQRdFR+H7MQhEeceAfokDM2CJrSMN5
 HnDJ0C+5mmoW3LT7f3i87E2XTH0WULhiTyqA/DHEwCOfRBJrfl8bhE8cPOpzI+yZVbCWJsN
 33u8RuCohadQ3wAP+GsVV7SoaoOGhDD08tCtbV32v38JO3b8JCASPJUJ3jx2Gd6CjxqK7Hq
 tpS9QHBJ7YG8bCjZlZwCx0jn421upr+KY/lemKXUd8ZXUQ4o4VddWIkV8PyyTQylA0dPI8S
 6Ga5TaluYm/oIi+ADouC6+niFvBnv+eF8GWDcnJTov+s6soR42hN97p6bQ24QKdh9DrQifA
 Oxo4ql3ThHmloDcFxeyCADwLI0D+Dlg+5f0gPDiALOV+m3bSdQ02bFwJtA4SAV6m/C8iAdu
 IWGcKNKJUmyX6McfVLdyBID8CpF3jJ3e0cy60PDZdH1KWNs8+JF86cRvdzuPItYWZ17sKja
 /da3+iobdDKBz1pSBf1uPFg6VprokjZKaNxbNpA5PaxVzoqNq4otcRKTHlwkNLE5Dtgn1Dy
 jLsLeNQ2N8O69XejzzPuKxxVfloZ8I/3f1YUlbR7V4W/PLzZwZMFaqwJ8m2QjG5gjEsCTnO
 dZyf30LU1rblVFX7IcuLXNd/X/K1qSm9wKKW7BouSCp9Lb3CCpgyVTcSe5bhO8nPcNhUgq6
 z8l4uaZWerhRCa1MJ+DMsF5MPBJvGHKqtB1Xs18JOyZSqCB09ia17/U7B8XCxAbFLQHXTtD
 094c8IxY58+3HByZqvK3DSNOcAyK0XkA2hIpHV70/98Jjb9hw6r4PT7iey/ATm/kTYi7MJv
 89a1bH00ITUTJDrJRW4j8BlcomGAGJEHdaEcPv92FHN5f1Ces+Nevv9Dl6z/rr4WtdfcJ9N
 bcJIL6IiqM36/oep3fnMc4P7TH+ilQ/jcIQxaPeoLFU3l7x7a5HIxPVKfDSqvfoDT9SP2S0
 g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

Remove four redundant counters (tx_xon_packets, rx_xon_packets,
tx_xoff_packets and rx_xoff_packets) from xstats, as they were duplicates
of tx_flow_control_xon_packets and others. Both sets were reading the same
registers but being output twice under different names. After removing
these entries, the flow control counters in DPDK now align with those in
our Linux kernel driver.

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 5d360f8305..779874aac9 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -261,11 +261,6 @@ static const struct rte_txgbe_xstats_name_off rte_txgbe_stats_strings[] = {
 	HW_XSTAT(tx_size_1024_to_max_packets),
 
 	/* Flow Control */
-	HW_XSTAT(tx_xon_packets),
-	HW_XSTAT(rx_xon_packets),
-	HW_XSTAT(tx_xoff_packets),
-	HW_XSTAT(rx_xoff_packets),
-
 	HW_XSTAT_NAME(tx_xon_packets, "tx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(rx_xon_packets, "rx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(tx_xoff_packets, "tx_flow_control_xoff_packets"),
-- 
2.21.0.windows.1

