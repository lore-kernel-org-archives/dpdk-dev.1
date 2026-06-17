Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C9CD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BABA40670;
	Wed, 17 Jun 2026 05:34:31 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 94FEF4065A;
 Wed, 17 Jun 2026 05:34:28 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667263t8a93c441
X-QQ-Originating-IP: B05S2FEyKQIq4ntofPE50656/8UY51wWb106HGvB7Q8=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17274272908437289955
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 02/21] net/ngbe: remove duplicate xstats counters
Date: Wed, 17 Jun 2026 11:33:40 +0800
Message-Id: <20260617033400.376-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mj3i0F+2cCqzWD07vmwzL0+hnJFqExDZJiDrHzkbz2onTHIVOFXM6/tP
 4Rf8LDxauJdVT9QgyT1bk6kdVW1ZFzbHgQKftSb/HXZPjSyZzD7a4amYp19YHxper0PbJbS
 lKMAfWorOOpiZgUTg0vzlud6hfFpLBG8iI7T4eaR1CM82hbvEQVRi7Fd8eOwkucGz9vBkaw
 HxTyqmt2YuzCZVLUvD+7qOq2Zs6jJ7uvT7fGP7GHwkOX1Nh6zu8tF7BZIpaWrdbEHHL6v3G
 JlXSgUhkIx1CQN/+uP3iPmS4CQt8tXgWClCn750LSpub6we/KS7VETj+b9yOQDUR0IZmDzg
 onXJeTpz4IqYOLKLcWMDPv9sMLVh6JAwBY2ny8BaDNYA+nR39STOGfayHRV7Iuw/hXGsORa
 NjePbziYn/btFGftZHh6p/E6SW7Z9ciCZRSTr2gp5RoL0IvA2n8O9Xi9b7QliJA9YkLrQgg
 dsJOzOd/H2iJ4gmVcNEqSNAg+PbelSrl73hDg7E6n67SgacDbF41peWe1Ep1X56Tl+jQ679
 +GSndPEN82dt+x/NMlzw2ISNyVbK8S/54ovFDze5rW5zJSoYmxbA1Mnb7u9d3sVH7KbF6IW
 ch8FJBiBqa5+V1u1+jHjSR2y/uf52ikE1cm7PcA4t8n3LcQtAL5gcAIOvoEJoZG8PaLpkSS
 lQZLN8vXalifYG4LCj5LgpXtUKCdqaPIHrCmhsQjZR8O6HQMnii3k7LVI7djGq3K7sCerfA
 tZsZ7gsn9xE43i42TY04qosaswsZAb7LZgvTXzibDDQ/D1qI4d2r0iDTTxynz6ZrfrxVdEf
 bcTLfNgf47EEtuyDDBCARpKdbzdXGq6lv62P1IOXVt9PWvvrsFSZ1rODPbDAkuMYFVV4AeF
 4SqOEXEGR/m3eTDQc4xlVgTPCJs0QBb5+ayaKhPcw2E+KitfYbjFiXtEEEtTD7Jo6dTsJuM
 2bOfSvrgIpr7wVxQGDIrVBH3j2VO5dJtO+d3sZzGxQ1pry4U1n1CdkJKUPiCzbgOWY2YrSu
 DNxfnkErLOaA/yRtod2sjCiYbqJSsszQSBtpim7GT26xOCcDO+l1ZqWY9WkANR5GVismKrg
 P9B1uXKVIrAgD9QdZHCJmhOTw1i6IRIhklJigo67ByHBkUgWTPc5Mk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

