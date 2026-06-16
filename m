Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346BCD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0EC9406BC;
	Tue, 16 Jun 2026 14:21:02 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 459484026A;
 Tue, 16 Jun 2026 14:21:01 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612458t2032b0b1
X-QQ-Originating-IP: uhSIweM08vUI2x77RqGTNsuaFBX42Rs6X5kn31cXqpU=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:20:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16238544055577028805
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 02/21] net/ngbe: remove duplicate xstats counters
Date: Tue, 16 Jun 2026 20:20:10 +0800
Message-Id: <20260616122030.9688-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OUuMuW/cX/8cIku+3ny+toeJZlwOk/ZKYWdO2zZgZ3QX+VnE1Lfu2SQm
 SQ/1rWU5tRuX1EMm8WZwhAzWZ+I3HCh5FzgcM0NdyTJrNUgKDzHmr/4lt74xbwnAomV4RT7
 W8jENaAdRrwy0NXy5+T1lVgKJCGv9NNR2IAGzeBhUOrgplAWzOSzT+Mb1oTSeTnaKXZMRKn
 GHA8nqLV8YZZoa8deAjyJLEXvfnu0Z7l1ZCCYHO3EeVj5lkIEu0uj1hf5rZD6EdxHCWTyTU
 96GS5FP9SwsNx0BsAz0EfuVwbMeQfnUbK7wKIM9b0iTLBpfPF/z7jvdAdSd7U5hQcLPIq7t
 OExatL4iRsnZNPXzA7J9+9FpdZNAuDKAodkpXwu9f40J+0wZjxrhdSNoMaQc87tGB3PlyLU
 HxTp8/LetLp/pxYwTME+YJJlvO4wgQDQNS8t7oMLn+tkJ6+yGfkYxr7F8k854wYVC61NQoW
 8y5M7mJLFPRsb409e7zQiyfC8JcClK7gfU9/G55coXTFyW1w7brmYJ1aM+GTMU+nsiJ3h3f
 zLwKY93Bk/8i9VAHHoj2cb/eTTZ6G9E+x1sjA5q48N9y70ny3+62rbYgRB1zk1jMSu2/p7c
 G0JVpkk+MX9Gb/jK57Ph2dZ7lOYiLlTs1eNtqTKIx3dtWGQlV0CjEJOIK7X5sn9kxWX9efU
 q5U8EgmGpQdIm6BI0hOMeSByU46aJ8ZQmbCpUeXykCzzZO8s9Q3vwD4WdSLICXkp5SC0UrQ
 3FsnSI52INT447rLK4+SVbcMN9EmmbcpFTMhpnvOrhuYWGrpX66a75pSGO3VP0636h87sxg
 9JnvkienbXWTvXtUATLcxrR81LgEIvb6Kfjw2rMtKCZUZYE66Zz4qIVBFEfjWxLles35+nq
 pb2cpKys0O4WtZSnLsDrlNoDY6WdFcpkBbjNfvRVgu7ZhHV1vIgazrsbE1cizjtUc0zZV5z
 qt1E/NjYgA7qXWZTnoyfShfq5LyHvrQFFcsIktV4WrJehD5aRirmBwMMBbZLCFx0AXu8ZeB
 1GjChP3ZWRlbF0xLV3fiM5LBZdOJYbKMxDshDAAsqNiclBm6AXp+4mrhbnB88vroLFudafI
 pontZLo8qsxFWIHVvlDy2TrRrZ6d6mkUn0Aq/iZPiRtAEHilgfyj3xEQH+jNcS25g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

Fixes: 8b433d04adc9 ("net/ngbe: support device xstats")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index 8b9d6371fb..6df53f3266 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -227,11 +227,6 @@ static const struct rte_ngbe_xstats_name_off rte_ngbe_stats_strings[] = {
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

