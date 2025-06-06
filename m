Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB8FC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5A4240608;
	Fri,  6 Jun 2025 10:02:10 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 464964042F;
 Fri,  6 Jun 2025 10:02:06 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196923t283588a9
X-QQ-Originating-IP: 6zAjZo7abUQ4GiNbOI5pWd2zI1U1jEkq7JwDN6Lm2nM=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:02:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4164444303058273378
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 09/12] net/ngbe: fix incorrect device statistics
Date: Fri,  6 Jun 2025 16:01:14 +0800
Message-ID: <7D54203FD2AC1BDD+20250606080117.183198-10-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NVrBVhUXM4Iv9DkeErXuq5PlPV8katK717O1KEhJdubMTBGHtqveF4t3
 3Dihnih9iHCb//2/btkY6LJFCS1WiDgxpgbsnsQf2yzU8HiG1Xxwek+lD36WViRuqaOzKrM
 HHrqCL5XtezZSzh+m9ZofJGYWNPgdBhoUcvWAST1jM9CId7h+c6P+fRAvp81PQGP5XaN19N
 gLkUbDW7pxOnu1o9ds48W81fiV7XQY5qTROnGu+Zt1K/PH513ItrLuJWwbpWpUDIHQs7o+s
 r51LMLUSeJwZRsw8QufCNC000f1M71SV/N8Z92kNByz1TT/PjmTuZa949XLyxZ4SjfMga9o
 y3eESPKNztuVj3bmcw0nI90QH1MuchgBryNCrKtxglK/37m8Y/My7ydWssDRaSw8MQzXI6i
 +diqb9mU/Mlai5sDwRsNX6qwO27X+fcukw9DI90AF07NPT8ggsIORdun3NdkReZE1uwQWG0
 CrrYonKRD9Wx31v6FuHKiqJN5zmIVZdmaE5nYmiXGks4RsEkMBQ7eLHOhkdfOzuuo+vPxhl
 t8Zwg/fJ8Cmgbuu/u/YXie+aayaE+n4AwAbEWoQXZ2raxpteWGeddjHPDzVw4tcKm2k3djp
 +QhgLFDRNbEPUdvhkmEllz9n77iTOD5J8JJfAA9PjZ2QU5JO0lPY1D3JCM/3zIuEsWGryn5
 v1a37m5CLA8bCiehsMjaIc0AU/ya5TDjwLv6oW+gsVsRFJwFnWds2SQlgbO28KqF6fyZCtT
 key5bQSjNHJGRIUmaifdTqzmrRrHfwAKYa/bLazYOLp3GkbiG+TCFyXUaG/ZaCDqelxUloN
 csMaaRGp0z8D+HdRJC5rx4JJTpRNOsMRb+YhgP+g86GJX2oIEEoyG1gt2C0BXWhJKzXr0Ie
 OosipadjSfiiA7J091nkJHo8INhObNaroPJ2otcb2KMxHF5A+3r6Ac/7PxQu8hnFdSvUBzU
 9Xhc+Au7m3Bx1J61mZvesiUwx1DiUq0IaHF/Z0yMwP7CD3iLHSK3wQ4sHBXxvQgcgS5itlm
 ev2b+W6oE+IZkIKE0boYgS2PjFnzf7YGCdqaRcH6WZpH7jrbNQwmNOwAvqMje4CbrnUhrs5
 /bCUpjl+YJL
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

