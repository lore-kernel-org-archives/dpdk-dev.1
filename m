Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13107C61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F8B140B9C;
	Mon,  9 Jun 2025 09:05:39 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 2A88440DD0;
 Mon,  9 Jun 2025 09:05:30 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452727t3515bb24
X-QQ-Originating-IP: FMn0LM4C4VWdEzQypwa1PzTLJCmUtX4Pyj3agHUG3y8=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16213667323343615605
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v2 09/12] net/ngbe: fix incorrect device statistics
Date: Mon,  9 Jun 2025 15:04:51 +0800
Message-ID: <63DC12F514B9F5CE+20250609070454.223387-10-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nnelav7R/H77aqXxWyAvacrtjpngcxE+yttk6C5cD934Epz3O6GvDvs/
 1HXAKHFlz/vKYN6r7FaDdAczGkw8WaTNLAHzZL5utYA3Wcog0kqYhW5Q5fhwkO4FnmF54Lh
 F4hPxnseEYe3V1Becrx/0WxjjEyOoJuUQolDFk6raR514iwR8NADJKnXgmyicJP7TjLAlGI
 8x/DiBsO20Eei0Ikt24V7QGRxf8i3cRfL/SxDf+yQJ8jCNwo3cFyz5CC3pG/60knUtl2xRM
 NeuF5A7vjk5G+ORqQ0OAGCtXxMlPu8psBoifJlInJQBG2X1IL+m1SO30KUrlWKzpZtpETLz
 6eYE0bp0fjtLoqhfzHZgBbUFUciSBLhlMP4wXJKtzRJ5h1hh/i/z3rpxyOsYBQOhVTpwArM
 LvP/1j7fVab8xiul9urbTrP15je9aU4X0dlgTRP10WaNUC06tQcVnJa1sAUacTgmQmjDGcf
 2wfxaz63wPCzcIy52/EE9s0adb+LtKIaR9PmTpbXf1MMvPrL1Pmvx5EQuio1Dl1fnlLJybt
 6RwZOir2PheCuSm4a4yStyJfOA12XyXCLvrx/HdxXcEC8fRTgJ506IayNcVc7edyNuocVRR
 nYwN0Lkb3kZVUHZEZzo+8P/0spyl0d/CvUvfQXMvkwA9OjmUtaH9Mba4l1eBMyh69wGCWyc
 Zptqphdc2sWe46KgkQ577HY4h6GcwQPmvDVTZppt5ySvEtElpeVQLI35TSAnDqUF/Ita/sF
 9Mo+4BHwoaQbubiO3dho1GEwQ+4JznhfzQFw8tXMHd9jI6VttevsiAjAg00NMv5DkXuiEj0
 fLhtjP6JQf8UrJefglZEbE+fctNI0FFKX7RUu5/fY/+8Dbq6Gqli3OYd6oXw6KG7Sz3g4Q9
 hsJ0q7RQX7r3Mlgskh2c0P9MkU4MGy+3xtzdtMm2i1KTEWH9HHqmUfkWWaT6tWpVawmASTh
 U2K22sFe6T1UgO4QVdP+0iMpRF7NFkap8XCz1G09y+W0mDHyZnGYQzeHB83bJVGipGG/boS
 UBKPDcXTzYB7RB0Q378CQ6AoToUm9GfVxL/qhtZ13O25DbRzGoWDhDnCFQyQOr8vLO/d5St
 E3fJF06HOku
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Fixes: fdb1e851975a ("net/ngbe: support basic statistics")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index a8f847de8d..d3ac40299f 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -1429,7 +1429,7 @@ ngbe_read_stats_registers(struct ngbe_hw *hw,
 	hw_stats->rx_total_bytes += rd64(hw, NGBE_MACRXGBOCTL);
 
 	hw_stats->rx_broadcast_packets += rd64(hw, NGBE_MACRXOCTL);
-	hw_stats->tx_broadcast_packets += rd32(hw, NGBE_MACTXOCTL);
+	hw_stats->tx_broadcast_packets += rd64(hw, NGBE_MACTXOCTL);
 
 	hw_stats->rx_size_64_packets += rd64(hw, NGBE_MACRX1TO64L);
 	hw_stats->rx_size_65_to_127_packets += rd64(hw, NGBE_MACRX65TO127L);
@@ -1448,7 +1448,8 @@ ngbe_read_stats_registers(struct ngbe_hw *hw,
 	hw_stats->tx_size_1024_to_max_packets +=
 			rd64(hw, NGBE_MACTX1024TOMAXL);
 
-	hw_stats->rx_undersize_errors += rd64(hw, NGBE_MACRXERRLENL);
+	hw_stats->rx_length_errors += rd64(hw, NGBE_MACRXERRLENL);
+	hw_stats->rx_undersize_errors += rd32(hw, NGBE_MACRXUNDERSIZE);
 	hw_stats->rx_oversize_cnt += rd32(hw, NGBE_MACRXOVERSIZE);
 	hw_stats->rx_jabber_errors += rd32(hw, NGBE_MACRXJABBER);
 
-- 
2.48.1

