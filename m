Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FE0CD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:34:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A03440DD1;
	Wed, 17 Jun 2026 05:34:37 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 26E3440A73;
 Wed, 17 Jun 2026 05:34:31 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667260t266d8d56
X-QQ-Originating-IP: L+/T4UW9IrX68DtAmMm49Sb1nwIwIJwEczCKwC1rjJU=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3611862520337539434
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v7 01/21] net/txgbe: remove duplicate xstats counters
Date: Wed, 17 Jun 2026 11:33:39 +0800
Message-Id: <20260617033400.376-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MVkZiY22hz/mErAmm7iLD4lYRHOY3ouudSP3yXPjfL9s8aCFA3R5tJev
 ZbQZZOXFTiWu2w6c13DijpFg+gOfhmyTSKnJWD3Z3jX6kKRUHnX7UJAPjt3ovXKrKZ1czSa
 Op10Z79VuK+GeRnyuXWSViiMjtwD4t7Rmw6v98BtdbnqEP0MR9qq82cuI/vKHDSewmoku4A
 W+2KQRZdw34/xP5MErtk92ep2USLM9gq8uYuE9jZ1V2tqKAbX2ihcWF0IQYq3Kjue4INxPq
 mfCNqIUZe8T0Dtf1lyasF5o8dn3yQPJvUVeK2csVmaMcQXKiCNap99H/mScyXE4dQoYShFX
 lvVivSS+cTp8+GsKP++Enp06dvFW68KRi2qsA/Zm1oApJz57KLeCBEpY+Ex5uP9H4A7x7NL
 mcWwHtw9+LqNfOblkuVmadYHuz+umT9OigVGF5kZxOhLBhfhZEIXeXuq1HfY19W63OWba3u
 KTlZ5Yucof8TUG9O4CmQ2OVxDpY6bPTB9020/J4POoPVOGQlDsAVImKOhv3zDeh/n+vUm86
 PhU3qJThWI5lHG5iv3NlRyL7iSNk1fOEdHYLmYAx3OEQq0C0PiOM5aeQF86vSwg7TmSBQQW
 0S87P9iMb1RjjyiE++RrT9lNqT65cA1TKYHJu7bO/ttGh7gYo9IHMjI5sug5Vu9Si4Rfh+4
 ECoXFi2U9ZtQUKgy6129kKxFzDcLEPK/CKDj1WftRDhbkbVm+86vmSfZPutqcjZV04OlE58
 suV7mKxl3JDZluQ94SjSVmd2/OBG2Rn/vdLMiReQSBUQxVP/MaP926OtClAQqxHvsK1rc8B
 9+GDJ9AT9Vr3b0UJMWPetMLrXdljSza3F923WWnxZbYTgN5HxQlXYzRIxL6KShoUWxAVMDQ
 1/tzxSJxbdj/rypdIoNh6BsDAhzDiVJof5CnZztus2wkq57uZ2M3Fv1jiG8r7wddeuVgLJn
 4gHyWrjxEA/DqO4GfP21sV6O33vtL5J6p/NcftJ56RsWN1wqVAcdTe32oOuJnQF2ei6pGQc
 WLLkF4QQt5008Hij5nA9uxl+UKuvWc5xX7UtnDT4ud58nkPDOhG9yD54W1inIOx6ADOq4d6
 Q==
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

