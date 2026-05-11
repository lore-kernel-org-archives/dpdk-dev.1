Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD82CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:37:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2300140A82;
	Mon, 11 May 2026 12:37:05 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 0031340648;
 Mon, 11 May 2026 12:37:00 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495812tb01b541d
X-QQ-Originating-IP: lqt1KYf8zTdxXaYcX0wd9BCk1o7YAqblJSWY0hIVRIA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10853766958600923869
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v4 11/20] net/txgbe: fix traffic class priority configuration
Date: Mon, 11 May 2026 18:35:53 +0800
Message-Id: <20260511103604.19724-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NhQ9hXNievYaqqlawwmpf47H3MIJxI5xuSmYRD5uNIKC0g+Lm1XEUGL3
 kP2PsbzICE2pS27qkZWDNThqLSBLWp16aXuesPv2Dq6FPrVZ4kMADBByeYdofS5JDzmJHjx
 IuuserSS1xePrTMLlzlx6a+YVSHwRQsU1H2L2DojwtodvfKm+ronzPbnYIgMlFtycTIeN6E
 kuJ15DktxVL/qMwXn0hOvQlkW6gmUdxgyqhRW8HU1sBFs+JgMNT0uPauAhGSd2Nf0xDIB6K
 8FoPddsheabdIrLd1CW/KjR0+LQc1gmDFoZRgqIvDim4BJfO6RNK0sf4idC8PeWih8OyjyP
 Rw3TpZ3pKEICN9xlz+VZgfK17l6yEDSni9MMOSB+XiXGf2Px4wP3B4nSMUQoj2N3ekL20cF
 m+YlPhUzWYMTN2tLr0JFXBULAz3WOWZp6Rj8qDB31ReXbv17xOzXoibFbp54CCCRKzxgd8B
 xVLTZSa+c+VpeF30+KSsAajsFI74oLjQIIYW/1cZ/4NOj518aiiZ47t5i9Q3vknJzoNxWt/
 qZGKaN7PS+PADLXPxn934L5t6UGmsc2mywj4GAwWKO6A+V3T4uyzTsTJ1A8Qbb0nmeLOMvC
 Yx8T+RKNEWDnekM6i26Abf+/Tpwej4IgqhAU/TBlvcwTkn3TrpMJFEsMUmQRiUEG+HSLJJv
 gTmU6q+5Dsij8Oe9/Q94i/5WnNPRWMFSfbLLG0m5rgiDM44C1K7dC2Ounqomyajr7GPhyI9
 xLXrSLk5ut8B/c2VXJ/T/ADd087tJH1JT1Uowa9nYHkC742NzGCu7Bt6P1QPd2h1SgS26lt
 RlopoR9KV6J/ho26YVhBLfN4u2m1CZLKH/QB4A8ttIwk2sstuwPcvwZGQ/0n8eXavJDaIJk
 vJ3vQP7NqC2rmRBJ/nOtX1yhs7Hit70+C2LqMB0Sk4LCvM7vN3eU6LnzIc0GlQq16PKUpMZ
 3WTz/U20SUIHj+9LrEIA9UoRJxmR9ljXcUQN9/sIw74Yb+45r2slQvRY52wt8hCNEcGAxSW
 vtzzR1L/cbGD2FThwYxUSrcsD+GJf8+m1dITEz2zIPfLsGsWeIvI1ZzBkZ4KgQxoMGWN8+t
 OyxplyJ0hGiPoNVIplOT24=
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

After applying the following testpmd command, 802.1Q packets with specific
priorities were not properly directed to the corresponding traffic classes:
    port config 0 dcb vt off 4 pfc off

The old driver had two issues:
1. The hardware uses a 4-bit mapping register per traffic class for
   priority-to-TC mapping, but the driver incorrectly configured it
   as 3 bits.
2. The DCB TX configuration mistakenly wrote to the RX register.

Fix both issues, ensuring that tc-prio mapping works as expected.
Additionally, remove the stale and inconsistent TXGBE_DCBUP2TC_DEC macro as
it has no callers.

Fixes: 8bdc7882f376 ("net/txgbe: support DCB")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_dcb_hw.c | 2 +-
 drivers/net/txgbe/base/txgbe_regs.h   | 6 ++----
 drivers/net/txgbe/txgbe_rxtx.c        | 7 ++-----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_dcb_hw.c b/drivers/net/txgbe/base/txgbe_dcb_hw.c
index 75c91a6b6a..79e1da447b 100644
--- a/drivers/net/txgbe/base/txgbe_dcb_hw.c
+++ b/drivers/net/txgbe/base/txgbe_dcb_hw.c
@@ -154,7 +154,7 @@ s32 txgbe_dcb_config_tx_data_arbiter_raptor(struct txgbe_hw *hw, u16 *refill,
 	for (i = 0; i < TXGBE_DCB_UP_MAX; i++)
 		reg |= TXGBE_DCBUP2TC_MAP(i, map[i]);
 
-	wr32(hw, TXGBE_PBRXUP2TC, reg);
+	wr32(hw, TXGBE_PBTXUP2TC, reg);
 
 	/* Configure traffic class credits and priority */
 	for (i = 0; i < TXGBE_DCB_TC_MAX; i++) {
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index de382601c9..25aaf8ea68 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -503,10 +503,8 @@
 #define TXGBE_PBRXCTL                   0x019000
 #define   TXGBE_PBRXCTL_ST              MS(0, 0x1)
 #define   TXGBE_PBRXCTL_ENA             MS(31, 0x1)
-#define TXGBE_PBRXUP2TC                 0x019008
 #define TXGBE_PBTXUP2TC                 0x01C800
-#define   TXGBE_DCBUP2TC_MAP(tc, v)     LS(v, 3 * (tc), 0x7)
-#define   TXGBE_DCBUP2TC_DEC(tc, r)     RS(r, 3 * (tc), 0x7)
+#define   TXGBE_DCBUP2TC_MAP(tc, v)     LS(v, 4 * (tc), 0x7)
 #define TXGBE_PBRXSIZE(tc)              (0x019020 + (tc) * 4)
 #define   TXGBE_PBRXSIZE_KB(v)          LS(v, 10, 0x3FF)
 
@@ -1703,7 +1701,7 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_RDM_PF_HIDE(_i)   (0x12090 + ((_i) * 4))
 
 #define TXGBE_RPUP2TC                   0x019008
-#define   TXGBE_RPUP2TC_UP_SHIFT        3
+#define   TXGBE_RPUP2TC_UP_SHIFT        4
 #define   TXGBE_RPUP2TC_UP_MASK         0x7
 
 #define TXGBE_RDM_DCACHE_CTL             0x0120A8
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index be279dc4ec..851cd122d8 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -3385,11 +3385,8 @@ txgbe_vmdq_dcb_configure(struct rte_eth_dev *dev)
 
 	queue_mapping = 0;
 	for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
-		/*
-		 * mapping is done with 3 bits per priority,
-		 * so shift by i*3 each time
-		 */
-		queue_mapping |= ((cfg->dcb_tc[i] & 0x07) << (i * 3));
+		queue_mapping |= ((cfg->dcb_tc[i] & TXGBE_RPUP2TC_UP_MASK) <<
+				  (i * TXGBE_RPUP2TC_UP_SHIFT));
 
 	wr32(hw, TXGBE_RPUP2TC, queue_mapping);
 
-- 
2.21.0.windows.1

