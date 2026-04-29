Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3400FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A22F40668;
	Wed, 29 Apr 2026 12:26:11 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id E113240657;
 Wed, 29 Apr 2026 12:26:08 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458358t3ceabceb
X-QQ-Originating-IP: XMmlFyACa1NDodzSE5cpKheVG8bjEMsNRmOyEkui8l0=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:25:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15898170178546901695
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 01/20] net/txgbe: remove duplicate xstats counters
Date: Wed, 29 Apr 2026 18:24:55 +0800
Message-Id: <20260429102515.58880-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvkbAvg9krHpVykj1U5FAko3ivxozmxfeKJZpE2lq7KU/qYVzcIshaxp
 z7CkRUOReGCoYNRlmIhtXAIix1TBNl3oKD0oGL0J0tOFh+ykRdC5KVkhPz9B/W5bHKnb0qZ
 iWGXgh/Z8l6KwoMQaHJ1MJxG5ZC/yq7VE6MjQH3NR1L9spIs8WHWi0WTHylYWqN9ZSi3pY5
 Bl4CyCKjdzFWtvtrC6HP/uu6dDFCHz7MWa7Ms6xkiZpx/5s1jIAIB7fQg+PB5XLtZRvkluC
 OTzNhNNdd+0Qodd08Libm/RCswyl6+Vb8h4NKFddYuez08wT0Bmp1/1eSYPgTYrsSFReKke
 X640c6QIZpSpM8I2bEJaIeXpQF4hS2aNSFziaFeYHNYrGUpIiR1MBLZebyFEYTvLxdMVk6o
 boMJt3CNPCoJwMzR9uOyfl4lPevd05Aqh0zOX6fjVQMY6uS/0pXyvmXKhSWMEi+iGxJIKJ9
 1EL9zlHFrX9ZybEh0BHCnUckTRJf5Xb0DeQZm5hs5dOSFv/a4XRF2FMunH1YVUkOAbQsbbL
 PrGFRRJu1uUKXA+QwFhZJNt+HBP7/YNMVIaOZqO8BHKhvC2CI80pYGWI1kxaDH4A67HCqkC
 /NiMY7Ezj5NHJ3x+I1WfixYllpPi2rqiWcIK5FLxCjxe2j9GBAemTkizfpvJcaVjZQZ0WMi
 1U6B9Yv3hbheJ3j+uFOf2o6DRjoRXnb4+Cph8eEjxvYDWfNVKVKHgb4T9awgOEQg3hfs7UC
 4i+Y86qSrm53Z1+n1GDulZMyRlosEFdNlK6xVzIEUh+4oov5e9LaJzx4l3DE5piymQokiDT
 uoXNgW02eq/Mbg6VOuCMXcFtZ4xIwzalxVNDLj7GfBeozeCz1nqOYlPhdiqmpnVyqHgphtI
 riqnm1s9urCP6RrBSeH7j0TuWNk9EOYzFJZRJ4TVbH8nP5c69xYLjRHiRVAbrJWbKPGaayG
 RaeeOF47TBwNFzjYvbcMR7wl5RUzTPXOsRU66jjMHgQQ0/XVZPL0Qsb5Nv2xOzH0FTVWl2N
 f+FjBxdVznadvZKGkIRy5YBtFc/LQafyvGIH95Sdu0+21M/Q1v
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

