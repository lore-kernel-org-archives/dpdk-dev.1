Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F56CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:54:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3914840E01;
	Wed, 24 Jun 2026 13:53:40 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 55E594067A;
 Wed, 24 Jun 2026 13:53:34 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782302003t466e7da2
X-QQ-Originating-IP: uV8ZxKHu/6DmR4+NQSpEyT4tGKNbzgtxHygZELGd4S8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3494836558466603207
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v10 11/21] net/txgbe: fix traffic class priority configuration
Date: Wed, 24 Jun 2026 19:52:43 +0800
Message-Id: <20260624115254.20348-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDcmOARaZyGSwWqAtw1UXZbeAmJF4Szt+wjK9WXjxmgVysdGYmX3ED2V
 /bYvcH/fhp8+adPjkf+hUtXdU7+SPLGSZXSeSSohW0lmadI/XT7N9MK+kEYTdCDkXhR1k8k
 Y2+JHH8W9K3xn/eqAxaAqfkaoWIMEHe1b16g+/bWVoKPc8BQgtS/6k6hGsFYPGMcMPbdS1b
 0XWFnLDwxyyQQqGU14G06U1KtOTj8IcGcARhIcYnU9p1ChYc966rD1GAJp+2HOQE/C5YfS4
 hedDmPZaD+fFckr17bquP2JY3hj77eplfaGSDc3g26XkL/4d1WeQSUHUE3A8U7SaF2UpkW6
 OyDOokHEk41bx6DxsT6II+xSMyfRt7dMm8qv4KJTYPbGWKYe+rlSKvi9maIR401iMgRbrxk
 GGEMN8Go5Ntveuo61KJtSi39mj6nMjFiWdTyXg/bEInI3F5CIIhpk+LfTD2y3g8jw7xrWaU
 5o70kzPZ/mJurpVYIEdrkvTlBByk7Ee6/1DZOBe7TJlftwT1EvjMZhFJ2wr8YzD6M6LYM0d
 7n4jU5KEqbUCzi7ZW1Hw3W4h2S4gEVIagUSgmrN08s6p97C85vf2qGh7BjwjTE6JsORmCrn
 j8E2uSCQWCsqXkXn6WtlWSg8yDNEFxA3AxwIPsJqsYuFeXAjbfbcGhoZTpny+tv+Ui43CDc
 oKuB/8eMRrR2uX86aoL6527BVGKio8W7V54M8pr4GOIL0Ze1+VJwDXEOVR9bV8cl9eIQCiN
 ax//3qvH2cAPXigZO7tQfj1uc3HZ8E+6aJYOXQNENbNbjee34SVAhJJM6cQgziW5SmWfM2W
 G1CMxXbYh9aoPIFASlOzNxv4B7pCrGrwq1LYKDhk5gquBEHoqSYdeJZFhinYRqYUN7WiWNU
 eqvivri8ABTs7OE8CWS+Rm8S4Wwlph8Vnc4jLKFdlvz+z2rkHrHTJHXGj0HqYr+HoUnMzVX
 GPnyPKn/QlRRdfWwUVk5fcQLTECiNYMozuincBmy4xNrIi1WaqugEPmKUF/U9BxB0HlDOdS
 p3rIPW3pxtuTD9eEAfCAgk/2WNWk2gsq0ARcXMhy8fBfVGlGEEwXqLQeIq8w1NuCb6v0y7V
 oHPMEW/nn5rAHQmAi0z+olqiqON3QbYXv+l+VrWgp8FK2RkkbMjL20=
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
index 906ff16b67..42baaa3ab1 100644
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

