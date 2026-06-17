Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5AACD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00A7740DD1;
	Wed, 17 Jun 2026 10:14:57 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 19C8440A73;
 Wed, 17 Jun 2026 10:14:52 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684089t3883b9d6
X-QQ-Originating-IP: BB8ZjwmlS08MXLRokL/DevIv55sOmYPKsMrHrRN4VcM=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14888437388638613329
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 05/21] net/txgbe: fix inaccuracy in Tx rate limiting
Date: Wed, 17 Jun 2026 16:12:52 +0800
Message-Id: <20260617081309.19124-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MKijbibGp4YDE15FGCSMsyHjFxe795PfhllvyOPPtonlmMPcaGUU4piY
 ZgT+ICW9ZhM77/Y085eP64NoKF+llkmK5H6h32seioaD+YP5aoOnXOfnvuWYq6r7HVtGO3q
 Mn1Qr9YiQjGqgN0UOi08JXY3iools62h/of7QlT6SuFmcLIXu74xGTjRuvTT7TjBQaKJoZw
 UGdyQT7/PQ/aEFOcm8gvQt7n5TFrGCZLSJad1kqw2z8xgD8GY5CDyG3uH7TVTOAWGSPerdt
 Jw2yUlauJ20L6hiMmcXLeHsl+yR0oba+m18QrUUqo0UclWvzv0lhFBOVmVjHJyx/jxXWBE4
 u6pJ4yVSYx7MpSTQVeflxhLMZKlhAndwD2HBMvQnpx8ylYDKly+GpkUWAmpxlVfpETAxfWs
 +ieZ43k14kHYJcfShlOC2Dfr/5plshZv/fLhW539SIIITffyHKK0R2eyvUsWS/RfL1anMC5
 yRy2RlmKwL+IYOkL7JiCgiQinI3iEE8bLiABl8XqxOnV+NerLY4330Iuxh4Xokqs45YUdg5
 +PmQzTXn4kABzlV6rbQ4BoIfTg6UkvSlSuPoThFEwyMt545QzD2mKX+26JuAMmicdYmLjUq
 4hKf1YVU8fXBYscuykJYQ5OrgUbgDRiyNEP/idYZCnX2CguEXxEna24/EMPa5gbaDSN1yKm
 4fPhXTiWkDwMHT+eDZTM1jRoNIMw47m4z3LLFDzMKSKTQDIjvoklygnePUWaCJOPGboCmnw
 XeOVR5c8Cw5gINpXuwSwR9yOOOUK8LkZ43dagnuc64EhOxfpDFlehZwUp/eNqamHVOP6YtS
 0juAfUeNQ6NDaFVi2ailsFTWHhLT8RbcheOM8cxJc/MO/hKJk0ahEHhSrMPex/9LET3/sSJ
 WqZRAsmImdMmoCB48VlnRPWeXdjB6DM5PBLNXpTy6FcNIHx1zIME+L8FMLURQ0XgJg8+fFX
 bfKwrlXHzkvjEh7uQXieA2ZQKhJgq2rB+deYSY7s1r1BJq0MTaf3ShWL/t4HhEVuc8+rchS
 5vxrWuILbEPEzUieTVq5mmOBpc+ssOphCDfvbUM7KpED0TTa19VyHgf6/EBuvdCZ5hM8vt8
 2VX5fl/uAOypKv4Wlw5eRnKBLtsT1mewA==
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

