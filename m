Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75AECD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:11:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A42EA40656;
	Mon, 22 Jun 2026 13:11:42 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 4C7D74060B;
 Mon, 22 Jun 2026 13:11:39 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126691t8aeaf2b3
X-QQ-Originating-IP: BR+l33P0XlFsHl5pghPUUIFIeZ4qFDUmHnNePeB9gic=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18123063263091323316
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v9 01/21] net/txgbe: remove duplicate xstats counters
Date: Mon, 22 Jun 2026 19:10:49 +0800
Message-Id: <20260622111111.21024-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OezX69k+IMSHBvZG8akZhy0lNT6vDCrc1gC8iour4Q1z03v1vOlJsaVO
 Z+umXjJGeVpAPhMr0GhTiDzXDDqV/FT+pD/1ZW/Ak9H1TxM34Sd4ZjYD3gNW7RCViEyStdz
 kbUCgmrq/qhY95v4SOuW0CiZKYjtATcIxZKtAirM42iG+PS7jplpevQnK2vU2sFeuM9ymYs
 FGjdBx3xOY6i7eipQMR61NKNvknQcyZGceBeQkRihC3Gak2B/qugRY8bqtAtX8e8C75LdHH
 Hq7VXX3jKTWEXkNDDJmkQ+/ibefQMhNr66xvUvpNdGEwT6Vt/EJXfct6jmiJEEGmDRZ0xXo
 YXfZmc8lnVAepFR0eiyZfWTP+gPRrWxpd08jC9+fOGxs4uvkKyprTwpzG0xU7jouYuyWP51
 If5Dcp4mS+eTd6ayHuDOB2NQryWSWOUWe2zZx6hMSb1LTJKAsYR/3VLQLnCUDSYoMwpLeVL
 wYnWPhCc5VO83b8ChJesh9jDsu3JEYK4t7Trt81zpcduOutJ0rQ6dA6gU9ZnE65cdpFJGbB
 zVxkp9eem4jQZfo8gN8crN0tRYDQouBtMW0o2pDgujSPnLnamWzjxy+Hp8BpmeUE1rvQo07
 pn89wxs1ErnymQby0ftsw0DVZ8QI9JBfLulypxXku7mfOYEAs2bDC8S1rjmt2xiRcQLJPdJ
 2TDKW8cy8TEJtZGQLN8Gc0wUIl1OROnn7zcx+OiMrs4yelDJxHXnoDpUro+a0ZE8zYt/Kde
 pEJ9ZHN7Ay0yakt//ipjqQcRdoXv2A6aB4qTT/tDRjq8SZ7+m0yL+GKez2WwsnzDpPHZOoJ
 rEvqsqZzEwua26r71szduYptDD7CCS+2ipVMw6xup/YaYPcTkE9c/MzMTgWkiNNFPPJQh+u
 8f+iO8Q51qRNoSq7xgX3+EanTDPnojBUvHQYn5Z9wi1k2H0mvvD4prvth/pIMzcRlgTRzbZ
 ldx/IplRNapivNhy8cv/uRYhebRxk3PcVwvc4OJow5jDM3W9nZmA5HkNMhbckkNpUqscHSI
 GVDxKQH3yTPIM+FGLGji21wum6UVG2eAcLx470hrpbNVTcF043jeiuOnpgMqmemEy8LRUFP
 st2sy49sD6B8Q8ajz1/H4vqImLSAS15aA4e5zbfwYs7iLNusRMQ7xFHglSD209COYLbI7tH
 ghr4LqxVKgoi5wASLF5ZJJl+R5rmZ3HYO5we
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
index 0f484dfe91..77870f3aee 100644
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

