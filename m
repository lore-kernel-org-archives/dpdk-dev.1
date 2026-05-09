Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63FCCD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D29B74026D;
	Sat,  9 May 2026 13:28:57 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id EC8D140269;
 Sat,  9 May 2026 13:28:55 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326125t82265b28
X-QQ-Originating-IP: JvGNLy8pvgIa3Gz4vsUqJ7R8NK7p05h6Cc0EhjO+bdo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:28:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2553874047074953984
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v3 01/20] net/txgbe: remove duplicate xstats counters
Date: Sat,  9 May 2026 19:28:03 +0800
Message-Id: <20260509112823.7728-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NG63YEgwc4yzF4rfTkYgbOHa1MO96gxgajJbCoqa9hTADphfZRs1kf9a
 xWjNl3AnTaIwip0gz36qtFw879Re4TdVp/uCP2O4yJSUIGnojRhnCDJSUtn3YRR6IN0+HXj
 +NzR6s0tboKqZsQ6iPGOT3uP/jrdnSaOkJf8mMY9jd/DFXBwqyEUqdKDloxrxVgBl/qOnZi
 1+KzVOBne+rNrUd+tTvk5t3kcbG9HFMG2YrYpVqH9iLUmCqIq3HWY6tYxNjkQgyQQWPGzyo
 Z9zITj8WlnKQ0kWoosrGYVOBEkvZeyLktYetefWtwG3dKu/l0wAp6hIHSV3Vgw0VBhNnYJa
 y2jmUU8wjCwSbb3yLO82bedry7z9adccZE93Fr0wPfd90mnKgVkv4SQSNvZGN0H4VTpgpZ4
 gdKkhpp0s1a+B10v3MOMWJbg2L3jM6NR+XiES8xrhnTl2IJGjQ3dR5MqQ6BOv5zjtnDL3mD
 2jBsyx3QVxx+0sV9HcGcPNwouImW8EyWwlVekoEBl2gaMKzDFAIQgQGMdbOsgShWf+Up6GT
 cfKGWx/y2///+bEp6ik2PI5KXl6qrNM6C5OE/44ZZRSmdkeAIsQlzJ49+4ygwFnwB5wLpYp
 VVNORQV6v97KzyukIv+g1AKvaAbGGjJ8Pl3Ub0jO0SCVs+R8+wJ/L+3Mi/TSvwa3VdXSHlf
 LjGgdaaQmnEM9+UsEji0/NsqVwAMe2cCFQWo8jflcAC+xjbGSV+a1tebLn01p57qTJkYr1f
 GOanUI0o+1L7pdbWmu/t8eKzg/ylta3Fee9pTMgAP6OZstoz1wL7pcQ2eHrR7aLqGcKtzmu
 vofF3BC1xMTIIDCpxPhpcH8tNsuyqneuGxGHiK5JPwMkzwYjkzkN2weAiCwSorT0aQd3fns
 d3boV2zcUtHRuh0V3BehRJc3costRtHGuGlSLccd7tu4FfPr81c7fgWTbTRX4RdTfdhk3cV
 v/yN7jBcv450sX6DwLBy0x5FESaR5noQfQi2QZ2kxRNGhRKRh3aa23elxxRd6sGkWiDMYi2
 g9fYE5GyH9SlRWOWc465p+pAzoCDdRqjqwrhwvtSBHBq4P5cQf+dLf4lPthmCsjYKKs8xNc
 w==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

Fixes: 91fe49c87d76 ("net/txgbe: support device xstats")
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

