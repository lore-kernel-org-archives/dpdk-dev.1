Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B627FC61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:44:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1416E42EDE;
	Fri, 13 Jun 2025 10:43:08 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 51C8B402E2;
 Fri, 13 Jun 2025 10:43:05 +0200 (CEST)
X-QQ-mid: esmtpsz18t1749804161t60b109cc
X-QQ-Originating-IP: p151aObuXIE629B3AoD24NNJ4VPSsPwk/dYVxdkQ1WQ=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.58])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 13 Jun 2025 16:42:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9166380683830308591
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v3 14/17] net/ngbe: fix incorrect device statistics
Date: Fri, 13 Jun 2025 16:41:56 +0800
Message-Id: <20250613084159.22184-15-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250613084159.22184-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250613084159.22184-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N/DcPz7jUYXlBa3tBrJXimSgRhkB+29Lyjo2hOmM1VIit2CfVaS1mwkm
 0qjbLEtH43WXuW/IebGpuQiE3p1tSYbxQ2QzlPL/Hgvb6J6y866dhWy7F02C280/UUZxyjx
 iA5h1x6uuR95RUt3SzVV2f+bdUaaeWj9e09KVR8vpKnrMm0ftEbRsZ1ZgYoxaixBxW3rC0L
 BL/fvDxMm7S5WI/NjYOv6ATco/HQuM+iJR2uJJ3BsoJCVZChKM6RBwRTVw2SeQ9kbFCjlfo
 lBgVGu6176zhqmasOVOSjmIUlbCq9wBI7b/B/Ja7jnJXAEEtYa3n6vZzSfZVJOAiPTAgPEE
 GRdV1/lxqkvW9UFFauMWVyrZNzpS4pl+WMV8W/ZKM7CF+MQwn455Z2Ywn0VoxFbsw/vUglw
 ruqVxqCi94PIsXjKzVUYceEe4TEmHcin4oE1kPt4NaMxQzcJcQhHRVdFnpIszuw0JfIA95H
 Zyl1e/5oEl5EWYkdfMvwDSJ17QGhV/UeQfHwFLx55mQtI4T/qHpcWTDtVkh8hMiRuTyyI8r
 ZykfW0dA8Dwgj1Qb5Y0ko44T5GqOQUpPT3Ix8JNbTgHtH6SDqfKgTAA2RXfjtB3sCdjxSFl
 Komtuxw9PfPNFbnIzaSaOHNjmSZfBvtE2i8OqjGJ6Wu0uCA0XCrVP3aq7NsaJwXWrxRFdIi
 eWCRVxCVoi2fa740ryryLYiAzm6YW6L6o62ZGUWgSmPWITuEU1f5MXNxIuhoSjtb5wZHiVe
 LQKMW+UpcGbDSRFjWBJPA5Gplhmv57V1tf3HcfSp0JjdPZm3LktLw5dlLPUhYLRAkoUbMaG
 kS4EaG6qH7nJzlFetElMuw2KGGFMjTmofrQIZh7hborwUWRcb95vYiKpmP4Zc4BBjR0a9Mp
 BLRlrP4WYsF4Q0dqTBngZNvjsgjem52EpC00wHzYwqfPPrUpnE3Jvzf7OXyISCESSHShRpl
 eLcZuD1wGMFHik+moSo85j9/QIcKF/JMLrJ5KO4TqstEfp9IIhrS5apQqR+i+vak0dzNAKN
 fBPmJrfj4C7pyv1Me1geOTOXfDY+DpZqd5rEiu6BdxiKf+v7wfuZtM7QoK0oOyD6zxI74rM
 aJ9RvjYN8ex
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

