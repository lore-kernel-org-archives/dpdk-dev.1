Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BCCC61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4D1440DCB;
	Mon,  9 Jun 2025 09:05:33 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id AB0CD40B95;
 Mon,  9 Jun 2025 09:05:29 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452725t7b5db7a7
X-QQ-Originating-IP: nvUA3C63HOJKE/CDDebdZ5B5AXR59tf5ObR/hGU+0gU=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9801133671767811648
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v2 08/12] net/txgbe: fix incorrect device statistics
Date: Mon,  9 Jun 2025 15:04:50 +0800
Message-ID: <532DFAB41936EA66+20250609070454.223387-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OEBH2hTtioqYNVXtubkZweChZS9kHjd4K7zsEfD3qFrO792sAiHszr5X
 y1r3FUjEWOomRl662pdnTilhCpuC2P2f23QMWVSk9bUF2qS+ftKwVoIaI8NlPqlraPemrgV
 0BV3VJkmcejQMjS7oo/t8Vm1BE+CRlICYyJ6TkL1xgNmZcuLb/Fm3MjXT8Wjj6GFKRu2TCk
 /6hPl/BLZkB9lbeCziuGnvJb7u0LPHTty93mP2o8YnloEdqsiQM17j9xYBnjbWifhbCXkRn
 xQVhJdjuzBFouB773cE57JSF3YoQ/3yMbWmL69MdwETXF3ga9uJG0pC/uW7xqkCDYMhi42V
 O4zEU00lSCH+E52U3fSDCK0afh1fhcxmU6o8+TegHn55fyRoKNOKMmJFzjVBWH/hZSUMUjv
 qw3L8Y4rJl8Lz5mphX2MacXdPbDMtUnxxbu71czqCnGYvIOnhXc8cZ0Xtk4Sh5pZjuHa96/
 6hAtgMb/JtwmbWmD7essCY7R/xSeH4yXTrEUB+QxDWEcqmqrUA559D5HBFd7k5IlcQ3/Prd
 cyw/KTdEecj4Y5jcWBu1uYf/1AXyrqS8dIWguhmrRv+bbIqCGka8+lMHjJx1CDtdv83a2Bv
 /CYwS/aE4ivAiZ9dgpasBkd6C6tGHo5/ASSKeLfUSe5lfMnc7gkxLOVJySCA9RsLmQcANUD
 MIMQYY586vnR8TwDgPzZHka5eqGWmPDkG7JAEmKLXJCj9kn+TcRT6CTC0m7q1emBJBsxNrP
 kIN0lCKr+TqWAYQIWpAM9+ftQvSCGiVgvyWSoIWSUDpH87gneebQkpCu4O8gktizRSDodQI
 2FZFr/OBc+SsxMtEOoQf+H7nf6j+wnJMwVce/fL5ihO33L4JlpO8CoZ5ND8TyWHsYi66K2v
 40cxQFZWWUlXwtQNPSRHB9kLGw/pCr4KpBCKQefghO5lPG141I33AyXsn7hwDdDiBO60vQS
 BIP4zdQXkwTIkvduBdW9+Fb+ke8ZSAsBZRyAHeVXaBXRBDteMTlSf7pcmueG/uHJamPyiZ0
 j+ck/K+MyfaGI/rlK5KM/OfFSPrWoKgaWWYB+so+UdMcRfiaL2oVwMKucftA4=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

The extend statistic "rx_undersize_errors" is incorrectly read as the
counter of frames received with a length error, which names
"rx_length_error". And "rx_undersize_errors" is the counter of
shorter-than-64B frames received without any errors.

In addition, "tx_broadcast_packets" should use rd64() to get the full
count on the low and high registers.

Fixes: c9bb590d4295 ("net/txgbe: support device statistics")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index b68a0557be..580579094b 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2250,7 +2250,7 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 	hw_stats->rx_total_bytes += rd64(hw, TXGBE_MACRXGBOCTL);
 
 	hw_stats->rx_broadcast_packets += rd64(hw, TXGBE_MACRXOCTL);
-	hw_stats->tx_broadcast_packets += rd32(hw, TXGBE_MACTXOCTL);
+	hw_stats->tx_broadcast_packets += rd64(hw, TXGBE_MACTXOCTL);
 
 	hw_stats->rx_size_64_packets += rd64(hw, TXGBE_MACRX1TO64L);
 	hw_stats->rx_size_65_to_127_packets += rd64(hw, TXGBE_MACRX65TO127L);
@@ -2269,7 +2269,8 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 	hw_stats->tx_size_1024_to_max_packets +=
 			rd64(hw, TXGBE_MACTX1024TOMAXL);
 
-	hw_stats->rx_undersize_errors += rd64(hw, TXGBE_MACRXERRLENL);
+	hw_stats->rx_length_errors += rd64(hw, TXGBE_MACRXERRLENL);
+	hw_stats->rx_undersize_errors += rd32(hw, TXGBE_MACRXUNDERSIZE);
 	hw_stats->rx_oversize_cnt += rd32(hw, TXGBE_MACRXOVERSIZE);
 	hw_stats->rx_jabber_errors += rd32(hw, TXGBE_MACRXJABBER);
 
-- 
2.48.1

