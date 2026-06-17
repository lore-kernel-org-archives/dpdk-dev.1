Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F9BCD98EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F91C40E39;
	Wed, 17 Jun 2026 10:15:16 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 2D23740E25;
 Wed, 17 Jun 2026 10:15:12 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684104t5154a3d0
X-QQ-Originating-IP: V53oX407UfSHe5z48cXT3f4a0SVfQDq+mMkrTZjZQW4=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:15:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9294201124542223086
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v8 11/21] net/txgbe: fix traffic class priority configuration
Date: Wed, 17 Jun 2026 16:12:58 +0800
Message-Id: <20260617081309.19124-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPEorwW6cFo95cbmcQzEY/JLZmzurWkhUz65rZ9ttqwH0EivRSNIowhh
 7LqX6e6mphT+qEj4uEoBJyEVwK7Hj+8VozEC0zNqZpvFM2OFHVZPwn9voi8E9Edt6usjyGm
 aIjkbcYKroLD6bxhxhpGw6hRAhiEyb1hOArMkmlsezx9GAzakG3TawI2+JOtjJ0ssykTx7j
 Q8e3XLL4droGOVxeQP0gdU98afC5XV7XHZRIUCGldXGKVlbyYcqjVBHWt5Rl/wKTMVrTyaS
 Jz+7KdO5LUio1dYzUGHmi3OqxaghRN+1mcNARzbcz52EfBHFy2Eu9QpYs/JOxbvhnosQJRD
 nMtoh22go282mQ4yIOK7admbJAY3/mdsoxDM8/dSZgQLc8a5KyuPHVE6zcqfJ5TQRdw/ZpR
 SLze+zNzAZX7ntK24xTFtqVT9dwJZQup6ibWeK8SKWfvStJr4QuTIcSxpZtw9OPK41IY51e
 LCJwNi25EF/FjYt9thUHs2hGwZ1BHl486YLYrilbKqlLHWLagLw1jxb8dd0VpEzPDhqG/qi
 csdulHMFzlzKz2+3bJ9SuFFeaRE8FsmvNhXcaEQtF2aaGNucyqOkCd0LG7mHipdrNW+flka
 u+b5sBjc1XJ9ryVK1Gu+g3UD56dvWExH8uS9RkOlCWVQADmltIcdQe7P3JjrpmfEzEULjcY
 0uHk8d7T1iufUL3lI9VQJygjIVrdFiiSE1pg/DVARyEZm30ywlBqeowowAenH8pshWA1jGj
 RTiTk//0nweQGzj0At3pKGn2ZnstKK6E2ttf86YZc+x7CiLsibXY1nR+xC1Jxm7CquvgJYU
 /M8JmJsCiLDzzgOHKONEk4jHu2MN5YO1ma2DtkgKPU9klLF1IiuE1a0ZEi0VaDBYBzbEZyi
 +BLXHAWcf+8R/t1ObG8ExODSf+g83rpV9JTCT5KZ0V/RYGF87wADc+tNAkustGT4/JEHbQA
 SLqyLETZXdYIEr0YjIq9MgmcNFaN7iTXHlNe+G5UzT2xb4eBiuqBtalav6sGt++DD+2OWbd
 ZCN9YGvu64nuVCh8IMNEwUkmbJJpaMix2ebujI+R37oYR+bRKz2iBCDJyrmyfKgeKTd4pqm
 ld4Ywk3g39UM++YML54VWg=
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

