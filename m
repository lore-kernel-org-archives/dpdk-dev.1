Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574E7CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CCBA40B8D;
	Wed, 24 Jun 2026 13:53:21 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 156D540669;
 Wed, 24 Jun 2026 13:53:14 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301990t36001f3e
X-QQ-Originating-IP: /ZiaEXhgrjPVuR69rfPPh85Aejw4zW+N/YTyJKn+Xjs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16900134110488076492
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 05/21] net/txgbe: fix inaccuracy in Tx rate limiting
Date: Wed, 24 Jun 2026 19:52:37 +0800
Message-Id: <20260624115254.20348-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mdc3TkmnJyI/KvOCaOd/HIcduQ7N/pWx8URQQon1nbRxO6qPOEPrxfvG
 Sh50x5SH3cDvqqedGKtzC7nOI7lqhYjB3GOe24Bg87tR2+C8BsgUrpqKBdLyyeVyygsWLsz
 19EEJmiUcPQemtqesvNZqiLHvTyjfiZu3r9usYnjbiRJ/ea0Vodr2bsq9wKuLCO1z/OfL+/
 t8dbjIzNmTMa6GFeehOWNvQL/+dqmSfofNzYlcuNCdYy6mdEIL7joXm2yemfFjdNQ7JndMG
 5C715/NFR4WECYgYQe6eBD9aVt3NnAc0SUACVqAy7CnVUV5k7K6X9kv4LP7RbdDF5noIvhR
 YGc3xaF6fLL5sWx6QOqjvNDc1U40F7ASKEPGJJbwEvQmt5lRs5dCTdjKoNlcTCh4ZO/1CIR
 JY632iYhOUfdt7dhmqKuxHbMxcgdQ1jnAYEyzI9zAU0Mm4gcq7z6o69t2jHQaR+uSad+EQr
 1PQp7XdCfBABuXeqVxQPOFOrWKL1zHPaUzSVGQTvCd/jcIMCGZip8a8eZLzO6J6T4qpXSwe
 7Y/JRuxiJ6XS7IndK7niPBQsJPnnFo4koxlsmCaLWckJfFXZ+MMw4oT2fDshOYL6agYBI91
 PPgyV0XLHV8oJ+ugIDPckfkmXd51pgAeQvl3iDaLdPQPpgkWjMutRRSE4g3ajqAYtuffocW
 r1xn/6UtSlA8u4a8EJ5igWBlOnzA8Z2ojKD5eeR/7maxy2UsW4BJtm/A2J52Wg5M92tfJfg
 M5FOjc81PZRtx6EMxsiUr65b3ed8dP2txnUxlYeL+EkhJ8H4Tz20DNmWTfcvenwhdN6xDyY
 1IHSAehlxV3WWGr5EDSN7UdDU4nrIxOxXSMEGOtxaJ1Az5+uDo/aq7KFrfZQ0vnk/XuDVYO
 F8VI7LJw4c7QVwSLxhNXsT2hQu5P6T1idsx09IOEL+ZcYuJmaWaQue0iYIgT2cG2RP9sebh
 Fw7WuHBElwgU3ur7egRjaKtr94k0vElce9A1JPyz+zgabyHQ7tf0BhOxE9oear5uFkGcGfm
 vvGmCSs2SvHzdvZpGWRl09JFFzVPCEqWeQkejlezZsxifgMXtIjy4IV4nAjetyC7b1g7kDu
 ujaBxaZJa7tVkQX8S1jRyb9YMNCISk1ZpP2nGj+3Lts
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

