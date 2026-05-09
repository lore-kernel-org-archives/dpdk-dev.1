Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D0CD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E9E94064F;
	Sat,  9 May 2026 13:29:24 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id CF739406B8;
 Sat,  9 May 2026 13:29:21 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326156t8dca56bc
X-QQ-Originating-IP: G7QDkkr7R1wuJ2ENVvE6niywwqvHmzjfawJI0tv93Xw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6748292886848221188
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v3 11/20] net/txgbe: fix traffic class priority configuration
Date: Sat,  9 May 2026 19:28:13 +0800
Message-Id: <20260509112823.7728-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NBplAH1p/X/dcb8xkni0Ympcc/+JO8yQZ01FpzpfgaUEEppL7fC61puV
 sKHtoSWPfGxmbwZ9uSc1JmkQhniBC6sBInFF4w/hkY5YDwebzqE5DKiUlFo06reWDuHqhBQ
 0mhOyCrVec4szr5hAHx/tUFdupgAnFET4XOAa5aG1uPLykHJRiUNkWQE27WydF07UWZWRF2
 ZGZy3Cf8HPEtciFR0hhZ/okV5+yEfsRFm6QVtIkgzCw0O896pby5hVALDb5AeWs+vCgfe3u
 lgpaAQuWHtWgNtpds/QX4OX1vQtrhoG/GSQhwsQzxjE2gMwHd8TJp9tngfjbliZ45kDlwUv
 +a7UTy4Poeq0yU6B7JtHSHTOsPx9kXd3PQZWVD5C05jqKxJSDvQ7r3DKEXit5FtZ4F20RVW
 8hvrYXFGahnSL1Wsgl/6FJAKVgGh6N6UlAQLDSkfDyJmTFrewRNlXxDeMqqz6X+BjDL8mE3
 7FCc1MaV0BtlrK0f7lo7StARTFzxTroe/yhYDC8BC+VZPzWiLm6uky7gotE1SRjhysKUK3w
 Sq8H/Ctr8V84ucZR+yh1XOJ/s4kIfjtvtR4afr8NCQsbyEzF5CKo+PRshjyN2TQm7JgoOti
 mn2I0gA8Kb/ZmUgjYeWVKBbVgr/ZeqO4i+9JQ4PgZtKvDjh2W6D5QFUxTWAazV8TaBm/bH1
 IJL7yINBJNsAUDBniE01hADetI+uIxdh5dfT0XrqlM4wXYdzH0CQ8sGL67wIcOJtiHq5D/+
 sZAuQfz3eB/Lld9/IOTz4m1niHZq4PEFt4+arQQ3MayJfSVr7A21NCzenhcaP58/ltSRWK0
 4Y1w25dzeXeguFmygSYN+wdgF5F1gEsj7z6hKTUO/dKU7h9AeXgjBk4p5YsDx734X6+lrVS
 lnIRWvLM++TOAVdJWN9EWsMvlN1e7JGMKAEj7hAc3TTNQ9xdxaXIB1CaaSamAmx4wN/x8+b
 rt+9IKeirVzzny5W5D4UqGYXimaq/372pMrW3mHiXxXooV5ulIwcuwcD/UeFeDz9qh1fs/2
 nkpaZGlZbqrltHUsUcR0AWY1mnu8nS0VVi14TTXDI2ixXyVB8aunezPHvx6Xda3hhjgHUw9
 mS/a2I9tX7nmetZ3vWOqwA=
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

