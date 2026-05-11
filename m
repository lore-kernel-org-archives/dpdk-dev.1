Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBCFCD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:36:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 310CC40674;
	Mon, 11 May 2026 12:36:39 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 807DB40666;
 Mon, 11 May 2026 12:36:35 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495786t0dcda340
X-QQ-Originating-IP: 6FidlmE7qk0UgeNBDxTh35KJARQoxgGZOvAQRItMtsA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11029369461352664365
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v4 01/20] net/txgbe: remove duplicate xstats counters
Date: Mon, 11 May 2026 18:35:43 +0800
Message-Id: <20260511103604.19724-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NEaes6yu2o+mCsm5geWOUf2B/MmMRIIlGkj/PA+OxPRR0IxShhb/4x8K
 c3VH+dKfZfJgICbIY7PIF9oNtgqWjr7p6sQbVBNUkoB5Fos8RNen0Biezy8E41m/HLiR++5
 EGPTmbfFNK1eKPPi26ZSY+4OFEznVzmEFhSZb2xuJcEqnNU2o/mn+GVUm6KvkuwswvGSYp5
 ZT0XlQ/BDBOJ7YOUqLQhkCm29ci7eU+R5Ml3MSsolYz4jgSTBPvlUPxB7xgKnNh0Hu+N52M
 RG05RfGV7mJ8FUX4yOzrZKuOitTxee49xgoHuVNezwFC4+9HZpjSarLoufLWYsnomSfG54F
 Uv7zJ/N4bQm7IHPxXsTYREOHE9GZzlnKReunNtdxw+BmeJIBnlkfens5mj00iMg+/+UYgkL
 8X9sWGkqUAFNtitIqVG2s31J+KOebgxLg2mMQWBLsRH5ghC1FavufLMDiyQZ38MM6DnRwsU
 nXX5dHS6YW991iqVnGymgX7LOw0DKBGz+1DNGHSsD108jCsFY4JHkQO/xfgj7aBaKSeAHJA
 SCP7TfxBzVL7NbcFoFmZL/lgmoJeiYan8ahmYzWPpm3mIJOFIc65cTTJvbzUp62PXKTzCPB
 sbI26DXhFpaK8G20IXTatBATUMU0yr24qSadQxF8qpQ+ZQJHomfhppSf8eBcvenfvlux7ok
 03lDkkuUqygp06EkICf9de5+daMxbaq9rOsrQlEdoNghr7s/ein8e+8PbazYwIuAkqd/+6o
 hIYH09KFP6b52bUM6Tgly9BZpZwNHBORkLbHXm3W4OXpLZtBSkkUJ9+IFq9fclsQilMip+k
 X1MQsA5iLUYXdIoxzTrKKu1jjHXjwE2LYqd36242CKet0bYOG/LJVNTwbAmxRfnOm4LXjmK
 d5kgAOefRAFStNxCGWzzVRdECsZ6ceaxbqSrzuHkHsk/V3qmD7if9BD5WDnIRNS5il3Z3hK
 OBfuBqjYLySbHmMNAyh4/IeSub+LvaR2EZhmHCfIwH/af2C7eie0KcCQDiyRoav+9h5pgR/
 A5WFDtj1ZEDSqLyobDhrJZPLYFaerkb+R7dWNWJYJ9mWCYt+UQ4p2gro5QelI=
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

