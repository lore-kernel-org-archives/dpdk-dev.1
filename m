Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F84CCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D34540656;
	Mon, 22 Jun 2026 13:12:07 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id D096140685;
 Mon, 22 Jun 2026 13:12:04 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126717t3e96c874
X-QQ-Originating-IP: ggOFqzfMYmm1khEF0GWuPEc0RqtJsp5yD/bpPrsQgV0=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13534579360372406400
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v9 11/21] net/txgbe: fix traffic class priority configuration
Date: Mon, 22 Jun 2026 19:10:59 +0800
Message-Id: <20260622111111.21024-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MvWsgqCEECOfYzhr1wqp+OC9X3ZcW573osxAh27DKZHf4YQ+2F/zpQCJ
 nqay7h85CVHykvPq5Ph6igzhldqpAfvO9cEZnL8rmJYOPz8kLyMJiX5u4Ll8FVmhjbF9JY+
 aXpYlfga2PpAOtDeAGQN9JO0/U+2j13zF6Pm3Lq7T17O88xanR+LJUydIXTwVBEb/EDdnpu
 A20/Fs+F+m1RJpTyU0FvtbwDTvx9U/wmQM+2Q70augWEchcMoFl7QovxOm+2MrUM1YOLCFb
 W8CFE2hWHaFWPBMcpnL+RJR329JEEUG+CJM8SYThxpNX6++DrFn99I8Q+NbJhOH/ei4iFWm
 NqCn94vhnGNF2gk35JeNPspAraSqx0Z/lltT1miQ8z/Y1RIClr49Q0PXcc9FPLy1ROH18d/
 M2pCex/HArgjtvsP8+Ok+pBKvOgHcqHSMLY2LcpjRJ9cV/a/cEQN2Rig5NIS2n8IlVC/dMY
 GUx55vw8qg8GJa0mPrtqock7d5e8baHMQDVRpkkLLjnl+qqsVRvbL+9oiiNsFzZAfKr2Few
 TZzMaE0oDhoOL1cpVtoEsp2tNqWjkTpabUumt7Mpi2xiKeHyj9ot9cgUZB+cFalL5/HQuxu
 myre03jquzRZ3j6VRl3hi8FAwMEppf4BddGTwtTKUW9nEMpWmihNPTds2rHgJKIfiMaAv0L
 LlrJ50EkPPcdp0Kq3qGcQ5I+6Ia/iyi4Hg3m0YbuWbpSO+Z3WCSlJxIimEilUtWMaBkhc4y
 G9p5NZskGQTpv0KbG6RqERW7egTfoynCIIE/Ml5nLugqzOK3rN//OAokKjAgLTQHd9wPGZe
 Q4/LU7Vuny3F7bpAlPSzhB1P9YMvGZ5BttE7y2070EScnWH7Y1eVRaJ/0dalNmoHcL4Pc61
 0Y/Xoyjr57owHhq6NmCPgzJKJht6x8oZxIFhjbdRfoMV0nQ6guqlGU8KRc/cLvPtJ/a/3sw
 bUEnZPvt9TBlbKz0fzn4uIEpxrqe/bpdZY23u9SL5h8wMimGWgJRaiNGhsFx1yh7yVshdrc
 SvS7qRg3rwTYBRtHB52RleWYW5NZ0F2APEK7omvLRsVZr76NmuJl4o0L+bt8xHBbbzDksGR
 /kyY5jf8Doxw7uFlLCUVL/ZyyuD7mJc4Q==
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
index 22c46e3d56..4aa62919b4 100644
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
 
@@ -1705,7 +1703,7 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_RDM_PF_HIDE(_i)   (0x12090 + ((_i) * 4))
 
 #define TXGBE_RPUP2TC                   0x019008
-#define   TXGBE_RPUP2TC_UP_SHIFT        3
+#define   TXGBE_RPUP2TC_UP_SHIFT        4
 #define   TXGBE_RPUP2TC_UP_MASK         0x7
 
 #define TXGBE_RDM_DCACHE_CTL             0x0120A8
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 1c7da75c2f..3525b708f8 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -3378,11 +3378,8 @@ txgbe_vmdq_dcb_configure(struct rte_eth_dev *dev)
 
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


