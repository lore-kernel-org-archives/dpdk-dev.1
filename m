Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD9FAD3F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:40:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5572A40616;
	Thu, 23 Apr 2026 05:40:57 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 9217A40150;
 Thu, 23 Apr 2026 05:40:54 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915651tee8f8dd4
X-QQ-Originating-IP: 9JwptJgVKMtv/z/IBNM+X5SBC6eTtsn+43m8rFD6Yso=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:40:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15799963195420602188
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 02/18] net/ngbe: remove duplicate xstats counters
Date: Thu, 23 Apr 2026 11:40:07 +0800
Message-Id: <20260423034024.14404-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MyNcQibNhlwYIj0Rd90MTqZjB4m9Z5ON3zs5rLwjrwcI4DrwfMyvQW6h
 WraWRlHvjFvcWOymzxy6YKQb+cuXz038JWJz5tmRxc94I6+mlbAAGB3wXNEMMGAzoINTDl3
 w++AWXMYlOupBMZ6+H4G41zVsMMwqJqsPjNgerXpzDBXNihS91foVAFidAyODnrxzn8q+DW
 JdgTfqJTyKeyxOp8+Y+mnCDxvsVntixseuHGM3OE2278E7g7etgmUZbMnRNBAC+XUy/qqtq
 XmBiz1ok6n5QJBxusaPdZczctuTeXnzGlUEp//bUZSDTlvld8w02ZXXLPJE828qYqJui2PL
 dUD1AiqOXYjLl/QfdsB0G6a8CAYFJVSJLNGsS+3nH3KF+EWYANp4B2yaXpd2MhrwyIBf9vU
 tugJAyQbGguAOUq5LQ0oZ9o5D21joSfK5QwMKCocuVSHj+OpnUMCp/+mCy49HO912HTcSGG
 z5C58byU/Qqs0bD6TpevG2zDonng1KaFDvrhV1ldHNYJSEHn4fM2ilH461Eb+Ftr0O9wC7I
 b70Iwt/5ujXJv/5wXwevFp36qiTxUmApgbWjQt49Krjda+7Hpka+wFctWCxoHTZqTkebL5U
 l4TmTdJztAbzZxWqa9KJeEP2alt6j/iJcVnEvfGMoynEScs1K4nAE+DYca7NZtg1eEi9F4O
 wyoKWB9zPgZW7uMMhrmwv+eAyCrrxZ2uyrObRsen+hqPKlPaEpxR0P8xNOn/UrtBYV0HIXY
 y9v+6YPxOESNHUD32VhHomIUrF1Yveu+nrWATZvx2lR50Ohf2fh8khGqbd9ie36nSKxVvKk
 jfed2P+SPnkORDxpl2cGm3k8xRReutiK1x3btxKUss1KtrTzA03TVzn91+aQ6ODrarYwGEH
 399W8QiycOSbB+dpnXF6j933Dio3JOBzHVXnopt/ZiDLvMfKlh2oy2Qs6VZmFPGvIBuujeD
 XbtyI4k/c8ts767ApvOe5np5Cn+er3e1HlbrfH/fWtQ6fbUutxnH3elN0C6YNoyKffLMWB5
 zOi8PrEco3a5SQnXSK2x5hryj8yYU9o/vCwNtKXBqfBhs5Q0cA36bxgE/XaQnkIgaTXge2y
 wjVHoFC0dqmxGYBCx5jSXnaxqa2S+zkapp/Glzq9Lzv5B6WVv1M3t0=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

