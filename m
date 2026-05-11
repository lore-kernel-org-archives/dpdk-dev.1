Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9987ACD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:38:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47C4B40A7D;
	Mon, 11 May 2026 12:37:23 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 11B1440DCA;
 Mon, 11 May 2026 12:37:20 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495838t26c24621
X-QQ-Originating-IP: hIk76wT5suUtS3I82fafXp4jD9Lg9CxLn4zMZAdmBQM=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:37:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13248451390419033631
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 20/20] net/txgbe: fix to enable Tx desc check
Date: Mon, 11 May 2026 18:36:02 +0800
Message-Id: <20260511103604.19724-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M3uTjkO5QXGx5JF4UqEefs22gNqJ6Hr/MKb7LmC1ywT+EWUbBrL+iYKu
 7s5X3ZhyWHkhC2/zsiZ6IkeQAZPIq6ELUuKVruazG8OziD1fs24p57mIejf+iBFirK12ttf
 pP/tbqTuA56bUO7wF72GcyvPFWAGepQLI/rnvlWFbs6QfF7dZ/s/oD+4tjcstO4xYbln/Mu
 HeBsuM+jAez2qryFdNh04C+tEFSLpeJcYbGP0WcYVh0kZgjAUt+wg/54XJmkh0Xhojnz4qF
 lX2stdS5LpLuF5eOMNWpwmoauKZv80bfE+LqB80xBceTlBUWFQfyTvOQ6IHE2+6yxVxhH3v
 tNQy+aXpQ9yf7W/Tz8TIDmQZuPW+8jBUmMcRnCfLl9QRObNQuLv9kpmhrAILuu94ovBrL6+
 z5Cz7gbcoRdQ//SK3ua8LK6viFYV/+MaJI2kE7BQ40bHWzpek8Gg265w6Tp/G1JeaXV17TE
 mhTv2M+4kXxwQGHwcHL0J8UVOUF70OrV85TE12jIcme4ndgRyJJu8LqHvjaiXReWt6qVene
 jWIOvhGO4MRxh/cti0XkdSDwapy83vY8OXRqGg2Ge8sk3D0Grjm3CRtkCez0r0UXWymC0db
 Og6YUZlRaTHDd8xHG/nlqA+3JazQh4jiu9xDvwd2i1te/GijBW3xcb/Y8TOtBYCy7tRm74O
 feqcCiKXlAawTbMclWHIxP31v2XgMU9wouqWbtIY8rs6Vl3pNXzG1chL0aH/PBY4fJrnD4G
 LT67R2Gj4wFH5XnFgZmnc4bJOC1NLOWUL8/zkBqv+1HXs9YRkEyCYCz8i4kWY8/Ao4c5LXW
 tXTAQEBM49wb3KX1xAApL2oRLxmEEIdiJNQYa3H1j8ZVM/0oIMNEwd6xW3NT2x8B6sU8ou+
 qtTt8wnocdK7MGechx4HULW64XwIchUSk1+3mTsdWlCesAIu/EgVtkaXUagirz6r57gHRgm
 PT0dGLOe6+axtsENCC620pzjObzghH8EADoxjnpViA4Nmgel7PK8yPvk9glf/FUC3RHTtCh
 11Vz2fgvo+etDXjTMCbJPFCHcuLpv6aW3Ndxyw6jTiwRWgBdbDliecSuaXC8u56KcWVBUWD
 QSdv235LRKzb+iDZ7rxXi0=
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

Now lib security is enabled by default, and cannot be disabled if the
driver is intended to be used. So Tdm_desc_chk is always unable to enable.
Remove this restriction, and just enable the corresponding queue check.

Fixes: 0eabdfcd4af4 ("net/txgbe: enable Tx descriptor error interrupt")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index ef53a868a6..8b3d5eec14 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4768,6 +4768,12 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		wr32(hw, TXGBE_TXRP(txq->reg_idx), 0);
 		wr32(hw, TXGBE_TXWP(txq->reg_idx), 0);
 
+#ifdef RTE_LIBRTE_SECURITY
+		if (!(txq->using_ipsec))
+#endif
+			wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
+			      BIT(txq->reg_idx % 32), BIT(txq->reg_idx % 32));
+
 		if (txq->headwb_mem) {
 			uint32_t txdctl;
 
@@ -4785,11 +4791,6 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		}
 	}
 
-#ifndef RTE_LIB_SECURITY
-	for (i = 0; i < 4; i++)
-		wr32(hw, TXGBE_TDM_DESC_CHK(i), 0xFFFFFFFF);
-#endif
-
 	/* Device configured with multiple TX queues. */
 	txgbe_dev_mq_tx_configure(dev);
 }
-- 
2.21.0.windows.1

