Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F6CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93B1F40ED8;
	Tue, 16 Jun 2026 14:21:37 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 400BC40E15;
 Tue, 16 Jun 2026 14:21:31 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612482t1de2f556
X-QQ-Originating-IP: 5QtnwWfvz06uaFGR5k9NAeAc8tohpIU8kLDPd5m24Rk=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 888543517096629940
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v6 11/21] net/txgbe: fix traffic class priority configuration
Date: Tue, 16 Jun 2026 20:20:19 +0800
Message-Id: <20260616122030.9688-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MS/l5XZQsHIQRrE4NX0roem7LyfOuchn5FNnRhz8eRppSnPIy8ODmLa2
 kbM1fmOABgUGcDzjSewMH248VV0Mjut+Hg2eoguYzjdEXOhexQlJyifEv4R3OiKA77FeaP0
 80e5EPg4RUbO/mC/niB4cIO0p9lOQUYCo6lwx8N1HhC1rkLoM29j8/fNl76Zcg0CElQ64/9
 jcue66mdIH5+uaIuv+vKtM+MuTxKaRucMjHWssp0L1raAwXuxYCkjaIoY9w6CT+iZjMlN4D
 5G3XvIDxOr9e4TwB343jHZQAeebAPfNUIP6KCr1c+FLQiQu4MrFBZF8mE4qnUpAX8ZwK2qF
 lDGJnv96gLfF4GUyoP2PDfOhT3iWV9Vy8bKMt2DxArVbKIk171MbBPfkllwy2CqVhzO74kq
 CT/uEqVv/vCebrdjU3KfcOkDJde1uzvwdLCrYtD5TN0Rdr8TWfzfWqYTiAEDJ3/pof5PR4U
 OmYM3t/E77qV71vFLS059j1muZ07PWGvuG7qwaobTFmp3SAh4wTp+bu0WedcQD6MdjvMHX4
 GBMFVRrOZBcQ8aZlo0Fvfv4m/yQMhnzap/WWpWYdKInx9neOBxvAZZ6VUui3IA6eq7/i3Nk
 w4dbDFO8agyNz5tjZVkGy0vfJCeZMw77W7MB1KTS24a9SCFaL7jQ+LsL9tNjU8XNK/LyOFB
 IM/w0HeqLQMJ+vqq9DvdzVWGAPGnE/R3xD+vJCXi069eh/p7cVQ9yf0yo2Hl1YrEu4sytEi
 3M+kKUPsh/Rg4ei3x01bOeMU1MlqGiHqDh+hmdZfS6eLfHsNQHoWyMgyWD4fs12EDL/ENsd
 +Zv2qhgrp8zjSFY9oyMMN21apeiF5/RHzIwz6xgo3+DUB7dygy9+2Jr8hrH/VJXnhvph5oI
 zKoln5AQ8vtzKUMdvoD4dKz7crjjgHwyRSCd6kah0DXAkH6VUv9e2FcYUgx+o4aqfikTlhC
 qCAaiAEu1+xISl2Ho8N5MDztZFP+7xHthoDr14wYgSlhJov1llvEVPo83Y9ddh/nZrV/Sce
 K/oCmY+Az7osOeOx31af/g5fCvDMSAHldJLufyEjlUDNdkLWtk+a0lQmyN1rH0pY9Emv8iG
 Zh5wcmmIKSw3MgWS0/n8nV0fT3261+wJw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
index 2d0c4989d9..4611124b68 100644
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

