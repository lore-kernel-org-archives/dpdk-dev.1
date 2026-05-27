Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2583CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:03:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD58340664;
	Wed, 27 May 2026 15:03:23 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id A4F714026C;
 Wed, 27 May 2026 15:03:21 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779886989t79495a5f
X-QQ-Originating-IP: mKhgCwXmSWxQPx+ZVZ9FwGXzH8j+ygUkyOsrLP00F1A=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10445218665395381148
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v5 01/21] net/txgbe: remove duplicate xstats counters
Date: Wed, 27 May 2026 21:02:01 +0800
Message-Id: <20260527130222.24348-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OHrQ35p6ppl9Pq/nyrngEYo/sCgbIrk6koVZYYlaj455vyc0E1z4J1Pw
 bn9PcANqeluehHGTDjGrpQehM2NOxL8IwpGLYQ/GCdPylX0TyrGLr0dMS1mVgxFwRpNWT5V
 GL+uVMis0KVjf9BSb7Ng5IokfOQ/OUDNtsSSlfCPLRhosJbczVgLfLHgLPGYwkfPOG5LM+s
 av+OF2vh1wkncTd8xYBAceLpwXfngylP4RjiX2DFWu+7ATGyS9Q/hts+pNcGYMHxOhuD/Uk
 xJVH82Tt3BgFDyguwAMRVYwpBLErLxEUTIJCQH7lJq+ku/TRSvXcFU9xXyqmHp0Dd9HnfN1
 4s4kxKykYAt7iKBFjXKEAgzmvRriS8OD1W+uRit9OgeNJoGoDtt8URrZpt7bMKbWFV1C+QY
 +f2WvJmq8cmmYGcXPc9GB1lNILm41xozx4m9Q1fCv8ElcqojYfuhohDZwhNRhe2C9v3twHz
 ATcAIgbeRHn7KJOXCdR7VhTQPvxA4jU2FA01rxPoSeEeLqKcj214cyvPuzJ003Xbk85DetG
 +pA5NLBxzy2UFE6Zw1bLrnD1t3vHXW88F6vVANc9AP0fSYPmmKfE4meO2B+bf5AixbUGM9v
 UQZzAscDm96tmFaqJLlVF1Sl8MK8xDVPIO9lrUsosUok0NfmWqwFychmYQ5k8rDSi3Eoe6A
 /IWv5Rg5NiMp4zo7aYcovY9mVC5PLWPxdBelWOUgFULIY1UM3HAhpNYCZcldZNEr+0mGjXm
 NV7kDYm2DxqCrozr3HLJ/9JphG1oJ1KP1ZNjqsxzSa6dFDEn9WCaDDu92kZAQanQ7GRq4DX
 Eyu/EuDDRWnglGO0GUtCzNWtzkRcrzPM1o1J4fYbtxKvfVVtG0YX2Bd6eTCbuIlavZEuwz/
 /4htAeWk9HR5K6zmzVem09OM8vhpdG7SZ5XHD4v8wUwEqWOYEPwQYLPn8t/RDlH5ofz/BRx
 ydqufXn/yQsqQG238rQc0EAmTPCswpf3mcr8Gvc5561CBMhRg+T+A4VQY6f/0CeurHEK0Gm
 cNPJdSbw1DG5fFSIPzgJZa7nYD6TujCPC5ZqFgT/QkO3FJHTjvkXjgC9tgl9F0DFs0htxw/
 g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

