Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BB1CD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E9DA40DCF;
	Mon, 11 May 2026 12:37:09 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id E401D40A6D;
 Mon, 11 May 2026 12:37:06 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495824t6ae7bf58
X-QQ-Originating-IP: 1ZiOdjBriwZE/QXh+0XCj1F8OOLlSklFzAAp/fqPehw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:37:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11934590496882079622
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 15/20] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Mon, 11 May 2026 18:35:57 +0800
Message-Id: <20260511103604.19724-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MxvL9FbKokt4zZv8IKiUUA+KJbWKS3f2d7QK7P5nIpSJIqX3ikg+6y2t
 h779Bs/4HVrHWF5J35ogdlmtDc2CJ7z3I6ik1QyyX1AHeWP6HPtKqzuBqYB8VYgMcrFrSUX
 0OUMHGV8yGWD5Ytfdjv9BfR356G1h2wrtOejIHD0qAdsiG7uC7i0FiTECiaOv7VETp+gYh/
 Nm7dMBUPLelT9E7W5QbPLCFaykynoVMdQPJQ7bhQKw3C/REjw3GyecxqIUMtoX/PF1NyazL
 n8sjfJN0UOZhezDPdrA89X6n8cy2N2hAXlgVoPUbJ0KV/eKN925PQjF6H50oo+LtWjP5YFT
 n3Mw7cojLufjav2GxqXW4GgYI9kkobOomGUfr3QUAXJr86PpaiTp/OxNMave9Jd/d6n3Tjq
 AIieprVbFdZafLPoMu85ToGOGQXj/+EiPKkHp3U1ZC78u51TNRsChioz25NI9ABtRGiNOYA
 L7qYy6xQdwPUOcP57n2apE6i68I/o4DBPuCJC3fmRP/97uvUripWfNLnCF0Cgf7XOoeogbc
 KeqH0IABWAcDEBqaKPcS7cbt21jCfUCQNqXyQ3uDbdpB7ysfWd74bE/yz5TtrJGlIw/nscy
 bimNn8R0z3cko5qwHYSSm35xxbouYbtV9wrJydL5e8lh4PjWezxUj9fplx2p1QMeyBa62V1
 LjpcKukRA5fhQ8Co3UDE0cDlC+AX19dKas4nBGVbHXQnHvC5bSR0op/zTL97ln04nEBxkAX
 oPUo6yqKTPXnBF6LoA+4W2wS+RYtX4v/YvnyqUZRFew6sqF/W+DRS6Nzao2UtnzXCYg6R2Z
 lbCnLsj17kM9HSFiftS14U8X1aDHIs5kYZjXJgWx6evzVJNOB6QV/zzjTnRAfndGh1v+FHZ
 Wn30Gu7jz3x9/kQH20QDlANwLD6WkPcp9vjyZ17Bpv/hzYrHpGc+V135f5NmboNVNSDTTsb
 fZAtK9zzlqfg5YIA62+B+gguMzxA+BvAEwQrMTH7nwECOsGSipTVEc6WXL2CO42ffPGHReW
 eezXJuNvsJDZuqugXSiki9fYWrqTqW9LDhpc52Ou0w2LYpsCVHlWXo//XNcdSAmxO5Rg0kX
 cQesNZg3SVnnzIKmEgpjGB8Dy/vmR99qQ==
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

