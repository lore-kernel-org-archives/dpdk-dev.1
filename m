Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3190C021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 10:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1579640DF6;
	Mon, 24 Feb 2025 11:04:33 +0100 (CET)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 885B640E18;
 Mon, 24 Feb 2025 11:04:30 +0100 (CET)
X-QQ-mid: bizesmtpsz5t1740391465tym6wdj
X-QQ-Originating-IP: /5OO/rByDSRnAZ56AM4LDTjioDktrlQrNQGaq6L+NO8=
Received: from DSK-zaiyuwang.trustnetic.com ( [218.72.40.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 24 Feb 2025 18:04:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3609944945698611519
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH 2/2] net/txgbe: remove meaningless choice for SW-FW sync
Date: Mon, 24 Feb 2025 17:59:08 +0800
Message-Id: <20250224095910.27384-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250224095910.27384-1-zaiyuwang@trustnetic.com>
References: <20250224095910.27384-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NUDY11p76rEhAY0UCmdFbjNROStdXAjmWexKRZPKVxoLOHysRYljx9ms
 +T232+dqx1zFqKBeVvK4tTR4xC9cRre6Ew88oCIi3xA9wQOufXIF9mEyhBPP1HyVd5PrgHd
 oght0MbqmeW2FrUnkHzjx3RpVRtOewL/WRdZSs4Z2DUr8ubZJNkoJOEOv5TSm4QzaAsCwzl
 5JAOKNKPT7g2x+0KUoo6UQc5CgBRI96j8RfXArMxB0+tcrjrD4+bzJFnOs240rqS2wy+lH1
 bNGSDieTVfix4mCOTETSlpxfzrzHwnYoqFa6mHbM2/zbUeYiMCfpPkFWj7aFcdkAEbdWL68
 16lhW36Pu5VV6xhp1AZ5sHPgO+zt2Uwlq/zjKY/K+/KHjkyxPmQxIH7IrOo1IZ2kDtnwz8D
 GHLERpYvTUuLkjaEFO5TG3aRghxbNLadbBTOjrTqP1FJiX6p2oYylS/OC6OklniAmx02oYV
 +jfSgQldmG3DUDjn2hmUUJr3hzd2RNqRpvX9BgHV+iXHi0U4oTotccs6Pax7PZJH6tBGnPf
 JtlSgxBsv3C74JZXRAlEiO5x+hUipD91K4fGM5j7HpllMgJMygh2yI/R5KZKt73e8HuJ962
 D8ds1TDQs94SJTKp7nyT5igNruVmeJl1Kr3qlw63CJzpeMyAO8JqSQ7u20T+lf+dTA1YxYL
 4/t9UYza2c4ema5Mzw+C6C6ynskFd0icoGW6J06MfPu9pR7PnP3mvxOVuRj1PK4QEWO25Sx
 e+HWG7/hGdt+sxOHjWpQjpmkZCVz3Mu1DHu9wpNYGo3kqmXIvR76s61xDzAUgZrH2ovgXCx
 hRp/n/hUS5o9zr+uWbrJkwbWLhk6+0yp4MOghTRdSdKb0FWaxGxuwxcgF39LCfJRsc8OJjA
 4Xn0EU+SpejS2gW7vMCjaZsdgwf2nMG9PmAw6QTIutva7hw+zDrFPnCpllZLOn7bCCSbriU
 gA0tnGSZxiefdyHXr137Fh8Mi8XiP/VZje2YYYFV/NtWa7AfNOUorcu1GHEzIG79Yt+M=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Remove superfluous 'if' and 'else' for SW-FW sync.

Bugzilla ID: 1581
Fixes: 5364a1ce30df ("net/txgbe: add PHY init")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_phy.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index d87af656d5..ce6882e262 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -80,12 +80,8 @@ static s32 txgbe_read_phy_if(struct txgbe_hw *hw)
 	if (hw->phy.nw_mng_if_sel & TXGBE_ETHPHYIF_MDIO_ACT)
 		hw->phy.addr = TXGBE_ETHPHYIF_MDIO_BASE(hw->phy.nw_mng_if_sel);
 
-	if (!hw->phy.phy_semaphore_mask) {
-		if (hw->bus.lan_id)
-			hw->phy.phy_semaphore_mask = TXGBE_MNGSEM_SWPHY;
-		else
-			hw->phy.phy_semaphore_mask = TXGBE_MNGSEM_SWPHY;
-	}
+	if (!hw->phy.phy_semaphore_mask)
+		hw->phy.phy_semaphore_mask = TXGBE_MNGSEM_SWPHY;
 
 	return 0;
 }
-- 
2.21.0.windows.1

