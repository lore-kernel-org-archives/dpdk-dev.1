Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D71CD98E1
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:34:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF22F40DF6;
	Wed, 17 Jun 2026 05:34:39 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 49B4240A84;
 Wed, 17 Jun 2026 05:34:35 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667271td31337ed
X-QQ-Originating-IP: 58AXmc+jUD7Hiuowl2aCwjKTGvEtwN+rDOVfb/NHbsE=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9639860857691069101
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 05/21] net/txgbe: fix inaccuracy in Tx rate limiting
Date: Wed, 17 Jun 2026 11:33:43 +0800
Message-Id: <20260617033400.376-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MjtcwOZJa0njS69Pe7IAofJu4StaUXNaxp0tRpPRmEweicLtbY9/6tyr
 vnrnjXRjV7mmYY2G1cQMNS+W8yRswzYez5asMg8StoztfsfDcqLZfoUWwVsmUz+60sJ0aRT
 9JZsH+HcDf95adnQd/RP4AElOCHAbu3Riv9Q74GmCAYCwjRBDOXxCbQtn3TLWbacrfmdeyJ
 45eTvmZOZsHeJ6Cjg9PK1zXIXt7DJSdu6mCX2K+RAJIuCShHINSFbb9TRg95bm1/hQ6PlVd
 c+hFVLg2ZFO0UiMEQs1sqaayDmPEDBATj6F6CFt6Hjg6MYF6eOg35TYivWt0+OljQsgwK8j
 HTVMqiL3y1yQMtJEHDXfvVqdw+zpFnR81NfKDpMagkRGusBHILIO05AtXuNVg+eYO7nOtvp
 FOI/G8KKld1/AvPsDlxn/nHb7WHQ9O/0x+WiOoZaN7DvMhmk65/J4TL9bhF6K8poC/GLRIU
 ztzTRos/ehfZGxI9LoSSTMrGv/cGWQaHKbpiUhwGZegORtm/giqZWWYX62sBWQVFuXkjx15
 KCFaOQWu5meNvM110a9ZC1JROEwQGr9CXOQ0P6O46FNFnUOtxgHMJ0AzrM8aF4X0GxIFICd
 CLmA60bpasiqISDyPAlJhwgQumdGws7jh/LJStPDKjEU/2QSSNwqCqnPNG2kqxp5dQKUWQO
 cQx0BBguN4P+4CUFPpki/ZkNMyOmtInjbvtw+zgrRnkXaIpKp1qeDeDNafCSW5295XNcFej
 zrd2SraYPjl6KVqd4aXGeOfxqht1tBtrkBmjEMgZ2TV0VfSjWGYaGyKzUK6zfpIPwci2MsF
 bVvX+gMT5b1w9R0DFFrNP7HJ6jiGvB473spkZcOh2wJ1ToYvPx7KUuPHKQlminVE3sCxP69
 PJOv+rJ1PPqjwzyyrOdC8rGGkmmr6HiKiTlftnXCUDIGHyCRtSxtpPUGnRf5xlwTIisq7lZ
 qAfSi3UoOBL4Qgzee+dJo6hNdeR4Zsxqz6YDBORnJI3cbxD8bXGobCv0FZ9BROVPZ++8NQD
 ElJgThNEGXJj2fuGWQo6PEuETn1g0ryhm7dHdugDuKOpEXO7fxmYTzvFISuIe0vnYihTcUK
 mIDJI4xwJdtaDmboXXhKEDEZR4HwfF5IQ==
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
index 779874aac9..099341b5ab 100644
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

