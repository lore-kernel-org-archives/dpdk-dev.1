Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73461CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:55:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 717C340E38;
	Wed, 24 Jun 2026 13:53:53 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 629B140DDB;
 Wed, 24 Jun 2026 13:53:47 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782302024t8f252049
X-QQ-Originating-IP: SME8wVX89ElauHeyosiNXZ+GlWjUsPTvgz3szziEdXs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1300068311726584602
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 20/21] net/txgbe: fix to enable Tx desc check
Date: Wed, 24 Jun 2026 19:52:52 +0800
Message-Id: <20260624115254.20348-21-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NQeIjHPBP7yvb+WODnV6RdiYxDQX+olHMHOCkBUQzCwbadWfoe0LkPIY
 dqGom//pQr3hrq8kB/Hf+UnNksdXP90kPU1mgs3QoXMiAXoIKB3dieO4ybkOepu8Z96pR6j
 gvvkUyPiqAmRWc2eRpYAGahVJel5+exqowaHwV5Y4koq/vVYo6MVuiIgxneMllQLPWFAw4U
 1oWB3BfMOV53q6fj2/6jUA3wvwUu6WxDcPn7DFMxnV5yfnbNjUVz+aEvZR3Dn8PTEY8Mxlg
 It1NBYwd43KgadRKO2XrV7G4Xw6Khru2cguREnIaHzjV5Ei4tekadJZSwsAlevbN12OzYco
 frVOcR4WZ/NzWkAsekwP0RjPa3iEzDGAnf+Vkt33U2eHzp/LdPHOm0AQBWt9xUT13H53Plx
 sH7qk/hA5McTTJ/AO3bEJWoHlYzJU9Jp38QJqpTCe9M1nko5YS/u6XD7WLCiUuAIgrYCKcI
 WM5FZGkxaxk/DvEpYs++xKZwHl2o8DZgQ4vhfMbhy9vdZpJEtP15AujPZwrkU8i3XSHWMT5
 FINoIQVQqmtYe7WDxSX2HkxkoZCiKJgXUDWTlbgS0/BLVpcoCa4DeE3fcW7EkCSjOAPLgOE
 iem+kpXDfuKv+CYHOptCjMIfd2CtK6JVQjtQWkZW35f/KRxvG23xYVW+OwIoDqALFXVolrX
 z+gbAk/JU5YgsGQ4nA1poTSwTCww3xOIlMir2/KJLXAqFX8qwnWtD5QFy04msGXHMtRYLiy
 dijDhol8rm3a0pBch0F3GHIsOAI8D3w9QdP4GE0RvTsk2P9rYNOoKmXnij6MFn7eGhfY96J
 f2Su29fYHEQEDjWojyZ0HtGOtscEv/6ugRSqapTtSvfeLnNRcMNpydMmiuhSG1LE6rdtmTy
 rcXN84XOir1wUyGHsE5Aaeq3xOyk839j2iddfeUoIMoM85iKO+3PqoAQ1s+dx1YMo5muEk8
 WqgJl+cjolWOAnqaozAsu8niZS7gKNTcOr1uN3ELbskXnzH+2/BZlfjeibLey7q3CtddFsG
 Ejtt/yYCp+BnO5LFDp/Hw1n/nEU1nM6y1Z7t/6Uzs+2GG0y96FJ6NyIYJZMHdROb4tzZtr/
 E9F9hyNTa9+AyDMpRbGx7dTBC7sdOYv9tb2lHR7oNJpGr9TGgX670Y=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
index 22a80e5553..14e395eebe 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -4761,6 +4761,12 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
 		wr32(hw, TXGBE_TXRP(txq->reg_idx), 0);
 		wr32(hw, TXGBE_TXWP(txq->reg_idx), 0);
 
+#ifdef RTE_LIB_SECURITY
+		if (!txq->using_ipsec)
+#endif
+			wr32m(hw, TXGBE_TDM_DESC_CHK(txq->reg_idx / 32),
+			      RTE_BIT32(txq->reg_idx % 32), RTE_BIT32(txq->reg_idx % 32));
+
 		if (txq->headwb_mem) {
 			uint32_t txdctl;
 
@@ -4778,11 +4784,6 @@ txgbe_dev_tx_init(struct rte_eth_dev *dev)
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

