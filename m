Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A62CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:03:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18BC940395;
	Wed, 27 May 2026 15:03:29 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 24EED4026C;
 Wed, 27 May 2026 15:03:26 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887003t84d59840
X-QQ-Originating-IP: weSQ3RazwrIIWa4y2G0WQpabC4bRMukD0qfKwx88+5A=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17484448054299611340
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 05/21] net/txgbe: fix inaccuracy in Tx rate limiting
Date: Wed, 27 May 2026 21:02:05 +0800
Message-Id: <20260527130222.24348-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MkhAA4qIuU0pkmvX/zn1tflQk8/yDI4/TPG1hIncIBgiwsw9+wa9K1kB
 kfxXUrg2jGEZ4dzDwz/Prp4DedeDDMEBEiNRinVzXMdG/sPTh0d8Pp2wDbpKb0/Iaf1q40I
 1xfAOGvO93MFMs2hdGjrNJxhrxbCUgdaBXySYT3eDklVOwN+qRhKQys8h/C08ROZmRb1Jbu
 4qz8KRv0ZlxzhlQqw58jFZyCyDdh1badNHJ910opZIU/BUvxBbshOaSYQ7TcB4Oam4qYaxl
 ks2pXBg8KKdm07z6Q6XHSe3/wjOnghdk07c72ugDKCMEIZZlcb94LuSezRORrRcyrCnscU7
 NNoRvQZ36rhsR3/nl0QS82zHQCmcjg579iW+lvJVRlqZicQp23y2snJuhjD7F21mqS+vfWB
 vCIrUyTyGqfuhS28SJp3cLNQjF8V49ZMZ7eaRiVOwqGEm/HIR2Kd/4mK5FAhzTbnMmbcNS6
 O4S6MoCGRJQc7rdD2pm/dROinycYio3DWTeTY8uUj04Du4yrA9sOjJpceEI1bfjorDRlkP+
 BTK2QPGzGG8fCyvUDz/4ukYVVFguS6DPTSysstat3ONsHoWZA0PpDPmTWGPiCPxatVvMkwU
 /0hqKm4t/4/CnT86ifDEuiBuG8o0N/IR7evIV9O310Yb2LLcIingGQzHc5A6j/MiBXvuj8Q
 5zPjAvV9N+a0dQg5xORPllzmEQwkfD1pQRv3sdcdFFF4tJIe+a+J8l8MB843bDlIRmb6vlZ
 qD/R85DjByTkJMbulL2eir1UtdID7sSR+QzVBRRkLnPtxD/E9idKEmhSQe8dhFdivSEvqVf
 wY/bsnzP80TnpUXFC0mmLAD4b0fF7X8D0dtelDeO1Rf/RpJvJ+sUbJIj9EpGF+uvGj/DjAN
 heYAucTlqsYQvFaPOZs0paCljgcuwUUDousYCOB0IYncGGbhVr1GVcA9Cy1JdjciH8Hw4AC
 aCbmvDXp+Yih9J+qvbf4XVpQY07rMlD1jfGwgR6ii8xG87sfGpFZsioGgPY+kBltgpPpjUM
 rpebml+s7bT6h3oj3vMSAWsUrGWTaUGv4B6WoOLGjWiKQ33LUcvyzzDFSoMJxZG/JHlfe+w
 H71ZN4nJS43LiGA/Yq8z94=
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

