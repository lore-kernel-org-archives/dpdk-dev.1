Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BBFCD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57B6C40666;
	Mon, 11 May 2026 12:36:44 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id BF0754067D;
 Mon, 11 May 2026 12:36:41 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495796ta3cd914a
X-QQ-Originating-IP: ReQuNCdFqR4RT9CyoQ9o3bpEij/ZzpV1qq1Il/IXWy8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7719326627497208825
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 05/20] net/txgbe: fix inaccuracy in Tx rate limiting
Date: Mon, 11 May 2026 18:35:47 +0800
Message-Id: <20260511103604.19724-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MWdgP8+gtiFRPPvoTkDDAtptopZEBUtlfxdi2vxqhPL2ijkffP2egz0U
 Je0XC0AW8inX85d//PWhkPrmi+L+/MJIXzJtYKTNWIXFiebQrlbC7KLiFJdYUFOIDB+Qjy8
 r/vmrQRJ2mLZ26430zXMZEWEvqTQdIB+MAC2Ab5VcD++G1PRiUBwSA3bOkviMIGPBVqU1sg
 zJxwnGPEoN3jJj3I9JK/nvMx3sEeHpxq3xFTWkZ7zMtqGzXBCQAn7T9eoeqB1vQj5DPkshC
 /hsABg43oO4+zI4UVxYst9iZOwIZV7uyYimj4cgrOzAhpfjK8FfcC6j6q6E6KRPLblS9PK8
 5TrSItDfwkxTW9TRXEWkOUITyDco1+L5LwQOjQf0DBRQOdKIrGi1oBurx8cBv7pmOeQvwCF
 3/Up83VoP1q+QvFo1eKkkdBUBOv+Lnh7dpgfkgnHdG0H5QZRMj9h6qHOcEosv4qrRt888Km
 7SLbzoojZ3Dbrs+BN1sV0Flqz0cOAELTu+F1Cz2hqp0Vq/xPLI3YVAG/UkjedBa0v5YgDoX
 pnzDezZ4HWcdHMkXZf0l47tKkUJW5i8Ozp/i5rk+zP6JN1Q/Ib2cjV6/FNWq3zJFfi9F1cq
 RYA0ZwKsTgmSqBTTPzXwpYz5gdpWZGMVGALVmMolOoL1v34KKV7NXHYe+GK4zeE152emE6i
 pR5lVDGT2eKe5lpmIGvgrnPu/KnYtF5sNymaEkVHlMsL8X2I9iLc2GYBFo7jKB9DNJliWop
 Nz9ruo7UjQPZkl6SFDTGMY5DhbKXKQ0uZK5C5PFWtYZMbYyZ/imavqZtNVJuPfCfvtHR7v5
 2HCJ10MT+OjXZdrAHcaeMEHUOMwsnGgAdlC2B2SIa5uW4uG5ZhsFwAFFXLevCnF7j6BTFRG
 1L6OptUpEdEGfceDgzZm8ttgzMNLJy9lVYs19vDROVn4yE/yrd/fuOQrkjBwY/07xbPH8Ku
 zTmi8jgSoB/C5PXoQMEYphhkttTYRTjKdLFnNm3IouxwjmxndOWrP5A+MOeFtNdAqoKygia
 uylQkuTeS36L+W2pBignhTm3ZD4rhLraNE3sJBbyw6/eHqbJeCIHtxguiTqEE=
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
 drivers/net/txgbe/base/txgbe_regs.h | 1 +
 drivers/net/txgbe/txgbe_ethdev.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 95c585a025..060757323a 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1670,6 +1670,7 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_TDM_FACTOR_INT_SHIFT    16
 #define   TXGBE_TDM_FACTOR_FRA_SHIFT    2
 
+#define TXGBE_TDM_RL_ADJ                0x1820C
 #define TXGBE_TDM_RL_VM_IDX             0x018218
 #define TXGBE_TDM_RL_VM_CFG             0x01821C
 #define TXGBE_TDM_RL_CFG                0x018400
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 779874aac9..414107d7a7 100644
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
 
+			wr32(hw, TXGBE_TDM_RL_ADJ, 21);
 			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
 			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
 			      TXGBE_TDM_FACTOR_INT_MASK, factor_int << TXGBE_TDM_FACTOR_INT_SHIFT);
-- 
2.21.0.windows.1

