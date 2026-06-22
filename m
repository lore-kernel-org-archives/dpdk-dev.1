Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95941CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6889840662;
	Mon, 22 Jun 2026 13:11:49 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 10E4340663;
 Mon, 22 Jun 2026 13:11:46 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126702t70674889
X-QQ-Originating-IP: OKuz5skzGjDycchoTxkq9UjC6cOmeJOXRkQ1t2l9RMI=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16427427764133076175
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 05/21] net/txgbe: fix inaccuracy in Tx rate limiting
Date: Mon, 22 Jun 2026 19:10:53 +0800
Message-Id: <20260622111111.21024-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M8Zk4Li7PoFiMnYOir9gTFUbjy1q1pgoXn4nmjResU3ERqv+NwGg9+Ry
 iW9K0K6+ezXE1mlcsFbLZb6hecD6Pfd3jLLGdi+vW8Ix+ziJPGEIKd8Q1IcHzuQQvWY21fc
 KqwLYUrBvaqgaAn4nwcIyzttvqsCcNihSep2AkEa6QdzQByTR8bwmsd58IqAS1TmtNMYfCf
 9s5FaA5CLDYR51or4yQDyoXhee2ZZhor0CzqaxZdOUT/0v528mE03AMe8LnxHMXZFvVsE+N
 /2gERRmZj+hTXA+kPw704xpE8Lv8gaKPCDkRtcMqE/5aAMivSWRPyQFDVLFLeskeC9dF4X0
 7M+pH0ainO9YAzfnrvpVYXbEBwXiUBE5hVYc0NNR78pQydBzsMQG3yeAorALNkWOPnFgMRj
 rzYySJn8A7MLnLjckcsti5FSFpTttdsSXCXbrmyJvch5qkt58h7LYvXMIJQwLT9RVc3S0FC
 uDg9EdLAPsrs1rHfPkDrzsx84mJkZ8TnyfNlXujgG9zXP0xWY/bnWoOHTrEv1vBIaV5xnVN
 PvP4gCL+82/APciqzvgB8QEI5l4itwVlDUIVelWPqsOzcF7Z9YEpkHxB0Rgu8sZVJL35a9v
 IqjrV/dHqOZi6atkbJqtERo+X7jSlFClTjx9LE/xt1Kra3/yeRVB3x3v/KBHX/D3eYuAqsb
 oY8aNdEOvvqO6DRRGM3uYS+6qb8c2MMSprArfhsMUditwaFb1z1NHo8Kclb8nXWXDWHKQP7
 aVVR7BqFKc9p+fHOaqGK4K4TguNIMZiqBlCD2va1TNFQ4rRFNCzvZ5EW0LbBnkSzdzFQHYZ
 BHDpCgrjFQN1HCN37E5CsCRIBhqTDXiPuo9/iG+rUqnDcpgSwYVT1XPXmziY19DelvjVgGU
 RuD8yfFEp366uW8uX9q7hP/wAbbuDiYahH0Upddyp+KG1aI0MYuvK5tjHv5xuqGruQbO+E6
 YTLEG3iIQJZpr2/njf1F41uV7T0GGCrat3q8RYFjy3ftD+fUse6N8JGQ09u4X9GwzzMLBnx
 /a5+ayOwgsDaoa4vVtL6ADuvGL8f1VqCyeOlStGo6mJLdI6R49vELO1pBmD+dR4vX1iTJ5X
 vPWJNv5ERPOKza2edv5wxI=
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

Amber-lite NIC's TX rate limiting has large deviations for small
packets. To address this, the following changes are made:

1. Set TDM_RL_ADJ (0x1820c) to 21B (includes 7B Ethernet preamble,
   1B SFD, 1B EFD, and 12B IPG).
2) Remove the rate offset in the driver (e.g., 105 / 100, a rough
   compensation value from Linux kernel driver tests).

After these changes, accuracy deviation for 64B packets is within
~5%, while large packets show lower deviation.

Fixes: a309ab43acf3 ("net/txgbe: support Tx queue rate limiting for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h | 3 +++
 drivers/net/txgbe/txgbe_ethdev.c    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 95c585a025..3d1bc88430 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1670,6 +1670,9 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_TDM_FACTOR_INT_SHIFT    16
 #define   TXGBE_TDM_FACTOR_FRA_SHIFT    2
 
+#define TXGBE_TDM_RL_ADJ                0x1820C
+ /* Ethernet framing overhead: 7B Ethernet preamble + 1B SFD + 1B EFD + 12B IPG */
+#define   TXGBE_FRAME_OVERHEAD          21
 #define TXGBE_TDM_RL_VM_IDX             0x018218
 #define TXGBE_TDM_RL_VM_CFG             0x01821C
 #define TXGBE_TDM_RL_CFG                0x018400
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 77870f3aee..c97a7f1a4e 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -4314,7 +4314,6 @@ txgbe_set_queue_rate_limit(struct rte_eth_dev *dev,
 			u16 frac;
 
 			link_speed = dev->data->dev_link.link_speed;
-			tx_rate  = tx_rate * 105 / 100;
 			/* Calculate the rate factor values to set */
 			factor_int = link_speed / tx_rate;
 			frac = (link_speed % tx_rate) * 10000 / tx_rate;
@@ -4324,6 +4323,7 @@ txgbe_set_queue_rate_limit(struct rte_eth_dev *dev,
 				factor_fra = 0;
 			}
 
+			wr32(hw, TXGBE_TDM_RL_ADJ, TXGBE_FRAME_OVERHEAD);
 			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
 			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
 			      TXGBE_TDM_FACTOR_INT_MASK, factor_int << TXGBE_TDM_FACTOR_INT_SHIFT);
-- 
2.21.0.windows.1

