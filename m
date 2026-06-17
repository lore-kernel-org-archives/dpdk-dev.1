Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04C3CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A032640663;
	Wed, 17 Jun 2026 10:14:49 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 77639402E2;
 Wed, 17 Jun 2026 10:14:45 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684082tf8343063
X-QQ-Originating-IP: uQ2UuRTpwaXoQO/f9E9E5A92EnLhfBw1l9PJrnDUrFs=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9401464344477890692
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 02/21] net/ngbe: remove duplicate xstats counters
Date: Wed, 17 Jun 2026 16:12:49 +0800
Message-Id: <20260617081309.19124-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M5ijqkBWpgeqxvifFLQGi4ziDxohgiNVeYU7jUo9UAjs9KEZJ4e1tpKo
 o/hVEmcP9ELUCE0LPLmo/33gc0rg2JBNQ/u4iZ62jPxm8lG7qS//EufIgLVSpBA/Fojc6t0
 lKc8wnwb0skaigWhWOEFwv42md0koRFdSJttBPAqxO1bWulUQ9VcIiy+PneeZsl4ZJhEvwZ
 dArj11gE/7kiOh8VF4phH0MBQYKlsXwTJrogL9W5Z/l9BuFl+gzu/fXsThFWYEt4FQ1mhbu
 vI6AcORocJwTCiD9/YxmtzdWXWdpNvYMVoawSUaaurZM7HRflEG4zHpa3CK1bIU7AXpQ4tz
 yh4tbSWYgNv+6aKRjCZfc4VLeEXkBoqNGGMgVX7Er+ApCSihVnG3KKmUxKSdyyI0j8En+/a
 lTma75ltCW0ndTx4sccPF6yCav+DCZ0BxL0VN2cis+7T6PD8TcD9N/GyBLqHBxMyKEnqXsH
 HXHMnz+XQzP7kY4YqE8sq2W1VQ/GRwu/Sq3+7N7yE86FS/HqRHM3Kr1M3rsWIMWGKlVRYEq
 QvnVJEjY+aqJ55xDtaKzjNQ6H3NeAbQHVcSNtu33wL9sEs/kDRzZ2Q5Z1hxk1S+bKCCCUPO
 WHBP9GcKEcmgam1Ans7f7EK3dW5cZbJdU0Ugo8CtDGv113CDWMbNT9GbG8g1snEtojhp4yb
 aJ8gUOv6CHgONg/Yc2lwLnpeKyCJFs60aPOMgkM1RnlP2KnFiSTnNh4GHm7x3kfHGTJ8ic0
 PUSiIvv+RxTrEOzdpwqS6+kBgIfbEC9XZDdfH2GD3KKbxJxluJ+cVMO7VQuiCoyG6ggtQYH
 s6MgJdHMbEiaW6c3MqU11X44k4MA+obI7rjIJR67SFZPjDCkiMpJ6D08Itg/JGWUQS9TWOm
 zdMsS8JnYqcV1EbrpxRwWQ0aSKz10xZLuWnjT8559miA1lDeldZlfJ8f2G2DAivnvwbMy0R
 zMZS6EzF5Gttj2Y/XE90r9j4YxpXucSKtk8lHGVIjdhLQ1SVjcHpX+nBgPnjw4Yc/NNGWF6
 ZVFWofa4DCacbc0IKLnspRUZL1ShhJG0L7oWGJc8LtaxShCz4mJ2iKOiC1FiQjU1qEHbGe7
 5uB+mD0ObPQ6tdxSBF3npT8foi0PdzYpMtuV+lzCzE1te4nUnJXRIE8Z12KDJobgw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
index f7b4a8b159..09bcd791ed 100644
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

