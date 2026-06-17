Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78823CD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94D6940674;
	Wed, 17 Jun 2026 10:14:51 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id B91DF4027A;
 Wed, 17 Jun 2026 10:14:47 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684080td6aff116
X-QQ-Originating-IP: V85n78JjzUpNV8lPWyJApTmiPORsqgt5BdDcyOYzig4=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10079477844351497226
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v8 01/21] net/txgbe: remove duplicate xstats counters
Date: Wed, 17 Jun 2026 16:12:48 +0800
Message-Id: <20260617081309.19124-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OBXmF4AVJMYC84SWvGV08rQ2ekD4CZqfnBAfwjcCTyA3EUSNqexRa5vW
 Pe2b2e7AlL8Tj8ojo1RNJU2FqxkFCKycqWyihKABvWpdrYfcXNx67HrKQ65VsXVCRVFWZbp
 Y8Zl06V44UTMs4O+/EWU1Ao6A255QA7BfSv2Wty1Sa/OLFDbxk69B5hjQtaIYHC1TXOPlvr
 HILAu0BbSG7dr/yRFvasNjfU+saBonTgmpzn19qkT1Qvr3vU0TwRpyqcq8o50lfz8TRYkDV
 LuLk5WCsfOgkq3FkIoqiSiBiB+FmwSaG7AJ51lsT7V1F1m1a5vKZj9RaGyywlh7eEwBiflE
 jYl1GLGZ/ofwcOB3lPdkZRicBwRK4vhvG0XeV8lW8Ch93HtNTuSQjQQeQuJ2SnArtnZLEq3
 /0SViQcdow1A0t2XW0G+Gd6XloZ9djH5tJu3pd7d3lIURkuIntSKfWMdrNo46xE9aePi9M4
 31SPlVamNbbqbrrVNmCHPrDk+H1PJv/Jj04/8Bo0E7uwwLHjrFGqZieOJZzxJoPGsrIVGnE
 fNAhmJ7LfXW8CFhT6gLgQhMutbedHCbsV6SyaTRSp9lfNK0bFNmVxnOIsSshxRc0JA4O+8V
 wu1CXIc62rcFzz8dLUkGRH9hovwoLqcziPRzhQWXdNNoMrDpN5a/3LleTJQWp2d04govmm1
 c0n8i2xSoi3jchWeceH84eF7JLrU5oYnxUrjcwSCYIDKn2U2Fd+SU4+LB8RklbXUO8+aIIF
 RU7jpOYUmfdh4z4ycI0gEvnZiP8UXpnIAJ1ZbaTSxkgC4ypaqln+H3aPk+ZG5/gf44eFHuE
 r8Ud6QDp+nMxPGfyD8obPeQqGccneLIbgCTa9sxFVWRHaSNTD+uML91IT9wHRK5OFQ4gav9
 VPXOuJskIF4Hvk+PMl8U9HRYIAEGhSQMfg+tiHQ9wCXELaPZ/2wXbzTQUPeB/fBBpWReSEr
 CpuXd1SWrbRQIkffICOZRBf3FqltQLv6pWrqHoiL+srEQ/YmIiesUWbQi+2sIOe5YEufUxw
 R4fsy/YJS4bMCWvjIkI8/2YgH8nBPR4gReVbngGQqoSaGX/WaaXYAgKl8W5FsK/EJuVuNMp
 qclk2kGCnou8kKP+qTDO21oPDE04DqJSUuT+bmzyOOh
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

