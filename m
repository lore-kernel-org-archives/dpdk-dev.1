Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5038CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E465040663;
	Wed, 24 Jun 2026 13:53:16 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id C5C30400EF;
 Wed, 24 Jun 2026 13:53:09 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301981tdaf025d9
X-QQ-Originating-IP: Y+f/KceSM0LXzp8M09VwXddXgJsABKnEmOhVFfnCDRo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:52:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14477358512883474487
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v10 01/21] net/txgbe: remove duplicate xstats counters
Date: Wed, 24 Jun 2026 19:52:33 +0800
Message-Id: <20260624115254.20348-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OJMDfpxdSlueEkqwLV7QCRRF9FUpoFgqpM4/BYO7zroYHSleevukxmKj
 a01jDpuVhDQ36VPrGd3qT4EB0VBKtnhjcl7fVjG5yqykbjjQiTNRd2zvuTF27lO8v6YwbpG
 r8AnTjh8xtEXidkmRBc6ASrjrOWFKHjWV68r9H8G30ax5ZBPjOzoS6LVgNzVyffgZdRZH8j
 HIFiDtzj0FG4pIdC2ySrznYygGJDwvhJJ0L6tm/Ign9UPaTNc1t96lNwaQxMrVi4SH+WGTv
 xszDb1m126Fe8i4WdlVKmcPRELEI9fNPPdWcuI+sakDUpOPDriRLMucqsZVUyVg1X106yRy
 xWT76PZ4rzQBiJ+o9thYMrDPOSOxJ9ZI79dSKgUbp7L9gLiE4vhaiJmmer9ffdb/LV4DKEK
 GAJzTAMM7vlhw35P84E1sKAQMnEAaN2tLLWqkMLaZEPklDeQ3oY7qR3LVEgBADVI75GV8Oe
 M0/eAGzek5Kwh4BxcYuaFtVeN/5PFt31c5LLp5FAEuUcKEMfQ1RCgwsRNZGplcGpFJnio7O
 a2QEXk9tQpqXTaX6ZzGp86SsxDoUjrE4BnJkLzRzDKBFDu903NrD9Fwy716D7NGO5/NLfFf
 XiiZjOVkuTHmV4WyLOf+jy3FnngTYIm6EyEl6k4CgAlmm5aelhjSjDFeTsN8yxGpYEs3P4d
 YBd+ljMjfMbjwOUQac9IwAT+cGc96aY0d+s64AqFjl9pzl69vj+oBfJ+qqxSSIY+s8qjd9A
 fuXmXttVKHlxArac+WTY6kQVW9pSk4eHbwrvEwltcuAEqJdhGaW0Mlla1FqZQ9wfkwyc3vZ
 89LUWGePTD+e+RQYsVLqqP1dC2cyUzmUwF1G8k0lsFtkmwSc982SnT4F59nHddV6o3ROLNQ
 6OZ6j9lWJoUKysOMkFvuSYQRmf3BCET38NMRcxOCPutOrms1PGC/Wk0QyNtOazPtOisX13s
 r7P7DpA8TYfUX3bPHT1NzO217GIJMIASnCFy+LmWz6HECH8iVCHr4VTiSVk146kSZxfc+A0
 qMI73QRv/YXCXGI2frPbr6wCF9KJ3Cf8v+LwKFI3XsA+VFi76uD1YWZtm+aayZyLXqjoK0W
 A==
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

