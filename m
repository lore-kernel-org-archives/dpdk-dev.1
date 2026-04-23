Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52109FAD3F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA9DD40678;
	Thu, 23 Apr 2026 05:41:06 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 544A440150;
 Thu, 23 Apr 2026 05:41:03 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915660t3e4ec7ce
X-QQ-Originating-IP: oGmA4C3vqmAvI0Zmo0ggDqwZmTeEBC6XY8AlNcB58qc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:40:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1539962495263407949
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 05/18] net/txgbe: fix inaccuracy in TX rate limiting
Date: Thu, 23 Apr 2026 11:40:10 +0800
Message-Id: <20260423034024.14404-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ObFHHlrAm440NqUjyUYpeJmZuqWNqDEsuqdKI6vnALeytHiqBbktRgue
 VKKk7t7kVaeA2TLsgek9reZZzeg29agH5Ck1OsVFeaUsAESkP9RwDkRs8t/yAIKd5nYBeA/
 k4wl/n5ovDtEbP3nWVwOvStNeYX5b8kN99MxWqHr81aNQ18AQJw7sRYNZPCzzHJR6MlUf9E
 SeKob3iuKP/wHuiMWcnnzoKMMrlZP0d2054BJzeK8nbrSfwoLXUailUyaK12BYm6jnWCDHn
 YKDH7Nv7r9ivNkex8YQGIv37S5d+Q0gL94dsb7xLp35NwCO3AAspwBxNbzgTzGeFN+BfeKV
 TOf7brDEMedoMkG1ov3KUW2kOMM29q3id6pH4SGhQImnY4VN1vAvznxkZuH2f+7TBh+MS5r
 qZoVRbBvm2X6nmrCEqFCCZrt24u6pGJ3qrPPCIoA2mHZ94rqaq+GP46QKzbxNXhRMofxmqy
 aEas1DRVkLft5jwOzHR/VpHJdZ2yzPcM6AQcCeIOizLn4485e5i7ha/xNNYY7nj3jYyxgMy
 pOu4DaNak/JHxQ3TpakOWbrXYrurb9cWd8IxXN9y3agdHFE2XC4NsbXZpF7E2adS8bSfTqt
 8afv3I1AuuW3gdVwqydHw4//pVUMZmTmMbjYCrnOLbOmwLx6R933Xf6gFcmTfpu9fc0Vm67
 RZ9+eNzImiYIhBwpKfm1z/22D4WBWqmxee99JSDWZIwkfjK+M+eH9kzZzGA6pI+Q3hrHl/Y
 Z/j2++9W9xy6PvwmX6xq4bl2zRIrPMET5dESPsSwMPI9Og4oLWaN9u8aiK/SQ+ZQqOREElp
 1yV6ctTaKcz4564vQGoH0viSpmhPxAbNBqXgy1TnVyCEGhNskUnJq07jWd4b72n4st+o6f+
 6tU1PiwC1l27lHvTXvQ+IqeHXS97eAwgSpY6fCLlRBYvG8364IabFD4qBf91mGoG9GQb+/9
 /fyhME2HswjiSEyjUW148QQOA0CbxBYhJMkq+L7vBKXEZE/EFEFJ8YP2Sbpi8WrqHktEAXI
 B3uVS70FqC1J08xQQBy7sRAUHqfoIl14o2s1vJXFITv+sg4XNvpMWEyUwj9OI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

