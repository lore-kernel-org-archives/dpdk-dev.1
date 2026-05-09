Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46073CD37AF
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:30:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0D8040B90;
	Sat,  9 May 2026 13:29:32 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id BC52140A6D;
 Sat,  9 May 2026 13:29:29 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326167tc9ea3914
X-QQ-Originating-IP: pKzDLk/iY0aHTN3T4Px8c3eP70WXvT8SloeqzG5Phqs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9176396367864237892
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 15/20] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Sat,  9 May 2026 19:28:17 +0800
Message-Id: <20260509112823.7728-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvH2zBBgt3uThV83R3FpTyvMa2DR2NFuQz4gIFyzjVZjCkmuXP5D/Tcc
 N5bd9gzG2hbzlVHt3akDm8SsyMU96M0KFQOTxLN4pLG8koIGpZrk1a+GDWDg/BKt9MNoZ6W
 ZCWzqR+3/WKwv/3ezqQAbELsouF00FQ2ZQbNvEUggW1+zoeC2fPvpHoguyvQnOyZVBbWqCC
 I80pIIoYzoMc/26Ki9KVpTkMqrZ2Cs3EiJhd+6CZDJg6BtL2KIo5XP0hsW9DcX9TtKRCfVt
 Vs2WgH9gU3sRaTnwfhV8g2MTJ8C3ipXxImCBI9qjj6Ar0vJZLKcpiUVU4t7Fa4H5CoSqtWN
 h4DESYgieCiowLOyjM2z0tpdaEi1V6ZTIsKVNruAAz4YsZMvKtNQZPjbZFGEoddjKWGcdOo
 MIsCgnKv8B7n0f9PjlTJZIeUdCItOFVEa9+sZLmuq1mjWid6pCbm4QUU9tobhsP4KhK6W0L
 LCKuLwAXq0GS5u4xDerA4yC3kx4585Lx5pR/2/Bpg7aodYs+SIXqNPcBojXx0WACy0+TYqq
 qCGEQaNioxpSdBHeCK5XhtPGbMj9bErvGxpNAtxyjwe6pO7QB/aXc0Cop7+yBWRufDFqo83
 QjJN5nwqK6LfxA72jCMMjUDpOFZgOENH9jJz5/O1Rh14H+bCKcsCxzNrXpCU+jSloWcknPn
 cZFCHhc3TCY19cmCemqmPSVq1en3kb3UQGu1tqBNLk5DYzEu3A/2H2FbnDCTRO1JpdoTR93
 R31RxULkgCpXnl0vUzMIJC4TIUEwi/sXqXyxqt0LnAT7nzJoF8gm7fJOnHIbngQXSKAeAYD
 4pLBLWAaqVF9ew9NB4fYg82VLamcMr+xl3VE6Lwvup9BqzDb8CTo/1FE7Qwdi3J1/pRE1ph
 13r2pnULrJCg2Hteg7F6tCHeT0619vgXtGn52A9GiBkgDlVvORa10uvfOXKaZ/QBVJpOdFF
 GTdrJSkewfZx8eXhoG82wx+T4AjAjVB22XvEnACXqeh1TMqtHxpCCPJSOL4S+zb3rFTyr6U
 HrL5pKBCAV2PNusXSvaCDlKx8CKkzuEoQybpOmX7/yc7oKZ43zrtbd6Bpiu8CL46KLp7p+y
 izfssm1VafXQk53uZmXksQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

The 25G NIC offers off, RS, Base-R, and auto FEC modes. When
reconfiguring the PHY, the FEC mode must match on both sides;
otherwise, the link cannot come up. The current driver fails to
maintain this requirement, causing link instability.

Add proper FEC mode handling during PHY reconfiguration to
guarantee link establishment.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index a5b9d951ea..fbb09d144b 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -282,6 +282,14 @@ s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
 	    !(hw->fec_mode & hw->cur_fec_link)))
 		goto out;
 
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL &&
+	    link_speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		txgbe_e56_fec_polling(hw, &link_up);
+
+		if (link_up)
+			goto out;
+	}
+
 	rte_spinlock_lock(&hw->phy_lock);
 	ret_status = txgbe_set_link_to_amlite(hw, speed);
 	rte_spinlock_unlock(&hw->phy_lock);
@@ -360,7 +368,10 @@ static s32 txgbe_setup_mac_link_multispeed_fiber_aml(struct txgbe_hw *hw,
 		/* If we already have link at this speed, just jump out */
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
 
-		if (link_speed == TXGBE_LINK_SPEED_25GB_FULL && link_up)
+		hw->cur_fec_link = txgbe_phy_fec_get(hw);
+
+		if (link_speed == TXGBE_LINK_SPEED_25GB_FULL && link_up &&
+		    hw->fec_mode & hw->cur_fec_link)
 			goto out;
 
 		/* Allow module to change analog characteristics (10G -> 25G) */
-- 
2.21.0.windows.1

