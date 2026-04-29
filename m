Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C3FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 318A540670;
	Wed, 29 Apr 2026 12:26:26 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 716AA40676;
 Wed, 29 Apr 2026 12:26:23 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458378t82a1803e
X-QQ-Originating-IP: bicVkK9GcwhsstuHfa4/UpL/TDWf2wMtORscKntq+/k=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 408695603032947641
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 05/20] net/txgbe: fix inaccuracy in TX rate limiting
Date: Wed, 29 Apr 2026 18:24:59 +0800
Message-Id: <20260429102515.58880-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nr5N425iK0yrKGEjTI+ref/Mu8vSH4hDYxeOv6QlBD+ZOlt4ffRAdNfj
 DXF+9M8Gcbk7i9XohT51GEWQpSpNqS+K8Z7z/Jvm+apXkMO3KtlFXRapTL1040MpK3S/rcL
 TkACnS/XWRmkx6X7VLzbfv9N00i7Z7h+9NvT6NJeb7YMdFW52epU4SA/+Mlv5eb7w+dq7Kl
 1dN7zw/Ki8WC9Xgai8tjp+KBeWXzWuuYZjLgph0qOSQ06RCku6qgAtNU9kpJjqkRr/WS0pU
 aG2Noxpn574pQil6sZr/FQuSAASY9QQwiNfv7keRfoL+BBQCXHNstVf9+0lWt5LT/lZs5mf
 ERVMpYq19Owj8fWxowL6cgzUERaTcyiF3yPgFvt0N6Y+QAwsj31RPpAWNVrw5A/r00x/Q4t
 Dy8bUSfgurdgH0SWfSq8zi+RcN122baSp+C47kD6xHJzsIcis81EcRyO/XUm7gqfd8Xy7qW
 cQny0zS5uvAV2qoWtZt2RLTo/jLAIBaQ0n0Ws5kEEriqe9yFacwEexl79c96oe89esb57UM
 nJhoOHyhMhKTwITnpJJybhURWnWMpHXGi+Fzg0DxYcDMljqpHYPFLDiIhRTL0Vp/xH+2aB4
 20JAc+a6Lf6N3F9iE+F90nWb8iPj+S4MZGqJrXPTbWr7cKR16Ha4Uwxv9lAkaoL1kWWl+my
 F8eCSk/y+wW+/yWyW990PQyOdwfwLt2S46hvErpwK2vgublhho9NQC5Lnf4KhNGSHFew0tU
 6o0PEVED4FIVX0VOKiwHdWO021JOplNWZFwvdL4H7Z94ZQWEhvrucYFsIGbPvVkcGPs7jrk
 ee8NBVDShLSDEx4C/K6DunIiENEXhZlK4fsvFiuf6Jeomm1NbQp8FksYwfyiXOpj3GNOIXs
 BzOCbK5CzPXjP0xm7PQtpuh6QXSG+7y/drryWbKO9O23W2pP+tR6qCT4PD+PdxQfBa4Dzvh
 k+LDHtsnnvIFzPQpsseNmN7qSU0yw9fEPY3Q3JBpYpP76PcaWrt0op3wmOBgJQA3jK84q1i
 ShEGkvuT6hsW59OxVL1xRzLVR4ifPo84ioY9D31/Nk5ZUyHlfY
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

Amber-lite NIC's TX rate limiting has large deviations for small
packets. To fix this issue, there are some changes:

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

