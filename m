Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA1BCD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F76D40A6D;
	Wed, 17 Jun 2026 05:34:35 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 362ED40679;
 Wed, 17 Jun 2026 05:34:31 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667266tbcdbb424
X-QQ-Originating-IP: vFfLSYBxKskET98vauRjtLTSoQUbaEUxvh0InuThwO0=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12003226916428528437
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 03/21] net/ngbe: add missing CDR config for YT PHY
Date: Wed, 17 Jun 2026 11:33:41 +0800
Message-Id: <20260617033400.376-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NZcrde3zhHkVxWO/7qw6bV+byY7IZWdQQwWSWLazLbZcECj8lHah4S7l
 L287cKOj/FCF6Q7e5Zqzmf25GAi2uLBm1fiAJcO4h2+SJwVUa15iQFKFqe+D31GzyX8uQkQ
 wowKHLpNhXIpbKJW2kRV7DySJclR0Pqib5JAiifIFMcWicUDqHsghIJdKC8TpyPDBGsSH23
 N134bQHw5EVOfWlyXnvowpbkw+j1ZjCAwNggvpiPsKickkkIvBkacemlikKhiWbCBZmahxu
 n44rCUXhxgk2tAdLNTGuxNh0MvQEUp4acT37bptXMa3gUFCvLqqFUipztZfn2wEWldeXgXD
 9INNdW2ZV7DN3hbieRtshYpAtXWu0h9ELTqqfStzGKnXEsZCFHRXDLvo6J3/gNozWfa+T/r
 La7SuuO/bR29nBVuRkeLV/OKGa0vDVd10mbrdsucsqSgRrSCmTA0VXVa3beS1vozwYzRtXr
 k/+AhCsPP+5B+lkr0toRTN0LZyll74jH/qYUs2VyQ9X9VWLem7RGBqRdbZ8o5ebH4x+BF77
 FYx9YVuxYVYmpsKFvXZ/qVzxXn4B0uHNm9ip+CVqqPpPR1m67akCmkGtCkD/pEZY+tWQqfZ
 NnbQwfnnevk9KzpMqsdEdTmeurzvCEdRVU25O+T2PS7GNMQJPwC2fm6kIBIORwyFOTgZyJd
 IxTe4E2t8q6ahmRjTnlXUu7IiIZRQa9pCb3xbaMwh0XEYCsnTubksjg7imDnVC/oWwwAWDI
 trZP2ck7E8zVu6cCjPrBrZU1Lj0n9Eq/yDjyIGpCsojlVsxhcJhf9mmugCRDwxgcuvlrpHo
 Lvn5ZgeA4Fs9IN8oxUBHPloXM0kAXzSDYmE3CQwYsrlFjtIN+U+/9MQVt4WlL4eHBClG2Lw
 nm9KmkH1gWp7usl/SaVCppqjpgRyZFjXlfCwrrCNBTq8tHzoIMdZ3B/MOkg60STeDk+6Zgh
 PjsZy2lRMqWntiNjCLps3fq4X5SpcmYOFeZNSPoQGURpx5YT6Ncn3eYZz3sYTwDjrhZfR/Y
 6McbdPPlkQosPO69PosEuYQKen6TvnFf2P+nmUhvFA7gcBMcZPuMprDCUgOF4=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

According to the PHY vendor, when YT8531S operates in UTP-to-Fiber or
RGMII-to-Fiber mode with auto-negotiation disabled (Force mode),
additional CDR (Clock Data Recovery) configuration is required to
improve link connectivity. Without this config, link may be unstable
or fail to establish.

Fixes: f1268369403d ("net/ngbe: support autoneg on/off for external PHY SFI mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_phy_yt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ngbe/base/ngbe_phy_yt.c b/drivers/net/ngbe/base/ngbe_phy_yt.c
index d110fbc8b2..ab0778d246 100644
--- a/drivers/net/ngbe/base/ngbe_phy_yt.c
+++ b/drivers/net/ngbe/base/ngbe_phy_yt.c
@@ -264,6 +264,9 @@ s32 ngbe_setup_phy_link_yt(struct ngbe_hw *hw, u32 speed,
 			value = YT_BCR_RESET | YT_BCR_ANE | YT_BCR_RESTART_AN |
 				YT_BCR_DUPLEX | YT_BCR_SPEED_SELECT1;
 		} else {
+			/* force mode need to config cdr */
+			ngbe_write_phy_reg_sds_ext_yt(hw, 0x3, 0, 0x1434);
+			ngbe_write_phy_reg_sds_ext_yt(hw, 0xe, 0, 0x163);
 			value = YT_BCR_RESET | YT_BCR_DUPLEX;
 			if (speed & NGBE_LINK_SPEED_1GB_FULL)
 				value |= YT_BCR_SPEED_SELECT1;
-- 
2.21.0.windows.1

