Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76973C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C128F4069F;
	Fri,  6 Jun 2025 10:02:07 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 17B0D40689;
 Fri,  6 Jun 2025 10:02:04 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196921t364a7431
X-QQ-Originating-IP: AC3eMa+w8o0LpaqwhBvXS6ZvFA5RdRtP6tCXCdlBIAg=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:02:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14829231122270999532
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 08/12] net/txgbe: fix incorrect device statistics
Date: Fri,  6 Jun 2025 16:01:13 +0800
Message-ID: <67DC1C32F2D74A8B+20250606080117.183198-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQX39w6kl+AaNlSRFzV1Gb3O+kHBbjR3/pquebPJCEPIpexNK6FV5Txj
 MkYesZpaIezEKEdT+9adG89QqUURTkFAxD+82JC9tTAse3SgYZi6UfhSD++0rgQ2t/1un8M
 y4in69ADudRKDa/62kCNt5VhHKO6OVUHv+60wJKOqqx8DNpFqHHr50UYD6bw+Pu8yLToDSn
 rnSwyEudxTYo3ToaayXosH/rIFwRFjntJHarU8Lz/S+HRb0J+O4Zuhro5evmyg0/HXI73uZ
 Ro5UslQ0s2K8S1AUis7K5C/x3g1BY7DRLmwKVFMqf8VFv0WZQyS3L89bFyopPjIN8DdxB3j
 thrVcXtgE0+2Sd0Pr8U9mG0mVWJEDyzWDaj3wodT7qMSmtFZhWZ3jVrCS6v8VvO2D+/yeOV
 9iFiOvje520YiPKwT4dTTaYU0iumQEJPovpk5awuk8SxSvExf7hS5q5CMK1HfCvLAmbQ+zx
 UYL1LQtwP08/GdbXqy90PxG4RxsxGmgEv5/1Bp49cv1f9JtWrD0XAZpaA0/5hzZu/3K+09a
 t51vvyML67rksUYNM7XC/xr9m761isnKWJ3GReGZ+93Vq5Me9rLXUQewvh4YYHY/xOGUCly
 nMe6gmNhMdjyWonGHGCswVyJ8GGiWT9uwfFjdAwCtEW7NPb8ip0WAeWJCcVnlFVjQK5EBfB
 WIA1SM7mUdygMeHpWuS2UDW7zRM142wzK3rLHP/szUch0cas5xxFJLuRR8R31lg96HgR2RW
 NnXzJojfJRsBSzNM69Aj1QidLBEmLfTdX6Zkpk55vMMp+kshAD31OZQfLASE/yudZFwveMV
 XFjZ6HOuDrM985QtHK+xfCU3FgdtWOz/tb2lt1depfJvI8Sm28om2e+D8ExKeUyGGVU0rOW
 zhcZh8D17OgafNmQV1QVOMOZ38IGifwdh1JZF73pwQ3G3PKk9DbqQuHoFYGesNKIL0LxuIV
 eOP4YEYn2Fk2Ft9NClnZ2Rbm/i3OAmXrVEHFevpJSMF1nocsNuV6smmGzvDIrAJ/qM0wiSz
 DTR5dn5gAGhlETq1rHwoS8QxfUGZGGECw1x7Y2lK8QNmy2W3YUEk3A4P1xbRE=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

