Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB22CD98E1
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:35:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAD7F40E3F;
	Wed, 17 Jun 2026 05:35:00 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id A177940DFB;
 Wed, 17 Jun 2026 05:34:54 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667286t27f6b5b3
X-QQ-Originating-IP: f9nl7caSpOEls1Tl1xc7tWoM+8WIXq4U4vWM9pfW8to=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2350816823847591339
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v7 11/21] net/txgbe: fix traffic class priority configuration
Date: Wed, 17 Jun 2026 11:33:49 +0800
Message-Id: <20260617033400.376-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N7uMf/cKLdHSnKljG7N2SY4ClF53eVwEbDyYg2NiCSyFmFyE+I2JHkcS
 LSnsmG6Yq2HBTmnK2Wx+PmIyck3wPhaWbrNSEXxac0zjYgp0eOATzxwmnvKtmA4Lg8TeSZY
 aK2fxLtyrA6kYBMQX8rl6xMb2us0JOOrgpAAP5OFJnpAkYeECYA30gMQ9e2phz+hyeSNgaF
 S/LCWJXE7h+cVPjch5KwEBYZ/oD24O33Q4KC01bF2TUKfyVNhK7GXlg+7tNSxIkRypapGMs
 GhaW4RDJLjQOVC/UQe+mLhDvm9fmlE4KlN0JWn2ZglSgX+hqHQf8AF92tSiH5xLEyJLSoWL
 rROuyRxKHfEUt5QTIwDi7Hr3/R7xcEDDC34cS7TzMW4138XhISlirsIh5fMtVPS4rK1d860
 t66cwxPfOFxCzTnWP7uG5B/bdNyJ61Q68DEo5AK91n9kqhIUurBT38I7Dtdb+aMuQMGFFXh
 qkdVy8HvmH3nDBUSLQ2uM8jIT0V9VvRwQDazNFafyHDIrl2/og4h7R9aEV58qPfp+uVdjPe
 fyAOvEsxD2Er/YzSWVZ23ZH500XPagi60l2ze8CmIgnSXODtd6ejdtDkiE1pI9uJgYYo3be
 2SbXeOU8jqP/ajtqk0QQCw596M4B0iJj6NXU01/OCEEPEzSBNio6yV6PkA++JBplJktXw15
 YKuxnf+IZEikTJydVoigN1YYO+RAUinispQ2DYl7Z2r3owsnvCqz59/vmBwZeQSYIm/kgjV
 eUO9nVpe5ak2SGoXVYpMyeYuVA1HYGFF3vuOr2lW3502QLQimgZEN2bhPfIcg6kJZarcTjR
 KwPOAhRkgKIZ+onx01gijrWjQfh5hp4C4auLJIOkliq0nr1ym+hi8wWE5oazvd9TdlMCaUh
 sP4P7LoxioCcdCkyPNK0OhVzIHHARJA+DwhxJbs2PAKISDHSl1BuAkIJMy2baQbNsX6Svz8
 7jyTxIv4aQDDYMxJqVuyPFwq9TuEtg2/f2AS9VeVyZnOcLCR4OV+hTemWWVl3MwbSBKsrcx
 UUxU+az5HHZEVrqgJtbFDj1IkaZzPllZ0W/6O8QboUeWnHz8Iv3k6HqHt9zIyhAV/wxDLfW
 hC1tYFQCNpQdIBDtZgL6smVy9+XKWHJfA==
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
index 2d0c4989d9..4611124b68 100644
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

