Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C25CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00C9D40E2A;
	Tue, 16 Jun 2026 14:21:11 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 8FDF9406BB;
 Tue, 16 Jun 2026 14:21:06 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612455tefc7d727
X-QQ-Originating-IP: KU3Zj7DIeYlYOy6S7oiaIpMaFnCHhilEdltx+4dmYBw=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:20:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1163678479374141362
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v6 01/21] net/txgbe: remove duplicate xstats counters
Date: Tue, 16 Jun 2026 20:20:09 +0800
Message-Id: <20260616122030.9688-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OdZIIXGVDipeJctJ8OxJ7eZg3kUMyYqoM5mU0jlj9aukmtzwooW8ruGO
 c8dZFu9U/+WpxT5pTg+9T52BJFTWe6wHWorRgkfZzhzncFSXPlad3/WcKuEGdNwXw18Nj2G
 JQX2IY2gJ3mCHeXfQsUBhDmWBKSKQF29kjvjHkEM4Mua4Qfc47FXnemCRZ902Bh13PJBIiq
 HVyQYjTGvVNZa756+gY24A3hftrh9Qqut8quTd3LdOzHv1xMlCN9YF0UUjPb12E1hYVOwRu
 rdP/z1Prska7EyE1SqA+ejuaFTRteKNBqlIELmKI//1BwI+XsA1NzuMXk+fRD+3/+NFVBW0
 kVNkiG4mL5Nw0RJLu/kL77TGBJvRTNL3FxUWqduMy3mlTCoKNLAxbcFPbnlY+i5PioxNRh+
 grDSB1NmWfsHUQjfrhElHyQ6/OTYsE2gYjp8RFup8Rt76Ej94iDS0vEPvPZGWQd47PFARHq
 wko8pJuwbmRAy5jHb6HNL+KliaO6h89jitSmxDYYHR52YOnDz5l6erIohaenAdJCLP7dVvy
 vmFlwv5RZwEzIPtrNnCR/RD9l2jto2ACJdLeTMXQkCSMNN/hw1p7miL8hySJ7F/boObRiwO
 sLAO9TQkolN/5OXTrw5diUGW4QeEuOAIojR9OdZo58GCVk7Lt4a4JC+6Ry/a9ed1rBBsp2F
 RTjGnTxdkXte8FD4aP4ct5re327vWpjNIZlWC5owCD1CLHpp7niJSPy9vbQ4LwjqdYZyJi6
 cASHtofFh8K/rqbubLVyJ0OIlSScd/rPtmRR2MYpSvmuqFHMKubANu+TxlSraNjZ+0+SClF
 ILslVvJtaMJ5xmkmp9SS+8ezcxb2g/icdfb/40Xa0tDmqOb0sgpHDCT3NinTiFJ9DC6ZbBN
 ipUCkRtj0yHenIZqldaBCfhiSbA3NE8wjaz5e7SiRw0p92yjXGReQXFLndQZjplBCwUkIU9
 TYDo6PpJVgIJQr4ICRagbqMeeh8KNADMLmCn6m8ac1Mjzdq7aCiNacc06PIIDO4nGWLsnI0
 JcDfb3qAuHVTtc9GYQBPCTuKmyOI2ZApzcOzqz3cNuNV9149mkH+IC/e6IIZt4SflJ/uk9B
 EDTvvG7eQvcGBQcBEDSIyU=
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

