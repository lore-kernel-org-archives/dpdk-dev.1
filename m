Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7B9CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:55:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26EA940E35;
	Wed, 24 Jun 2026 13:53:52 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id A127240E2E;
 Wed, 24 Jun 2026 13:53:36 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782302013tb02f406d
X-QQ-Originating-IP: yPS6eRvlrUi7znlr0Tpmc2mnoZ4RSs61Makif+UBzwI=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16924216666904602393
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 15/21] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Wed, 24 Jun 2026 19:52:47 +0800
Message-Id: <20260624115254.20348-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NsKw77UaNFtDd5OYy30MPvHlooSeHMH8ZzdS2I3oh7KZpJkn7IChxqR2
 XYKylgKq+zT33CM0IGIZqlVLVNiyq1YYROEJXp9EiKGlREmU5CO9TLRt7IIIc0tCeUfkW8q
 NLQ7Jy8NBPCTCd4u/AdMqOXsulsJNwm7gjAhfNKLFEVtUZelPe9w1EPDdeIoDHcoOxvfzul
 /pq2IbICyzoDHKopvfNyLzuTcJ1d6MOmFfBJkRkBjt4c1ZQuoi7LYiRyohE33M1ROXPMhRZ
 bzlPKr8OCWEWsoPiIJCNjbW+mg6azmaL+lZXlKt8taxFbfq5NRrhTNpxYCVl/4cJA+lc9yX
 b3AQYyNQtTZ4SrL6Ot430vm7+W0lai/uTWHDbyRBiCvDZRE37OqXtIzvTjAaxgLHmyia3Vn
 28wfrtxHUfYhDqaKlK/Qj48/z7iaysYeJ0lHwCkw9As0Mp4Gqzo9bc+mn4JyKNArVGhehXR
 h1wlP4GGjUylc3aOr8+P52ZMYRS1bmhiq6JLaBLsfOI1SSXnHd2/oxjfBTq+AmulPF0e5cK
 u6bQulSvTk/Zcqq5g4pahperhTiQ5XTbSNSToGBA8xEUE1qL0BqTzod7rLOdvFyK3u2O+yn
 VVFS1+ptt1Z8OI/Yzz3UPfGA9gQodDnjafb0nNN3nV/TX66QCDLFt0IdVlajAf53xzroVxn
 lCQsgXfAO6t8IofKB23lYmJzqT2sCjFevuijHtnMcicSB71FPIHPeONDCfnXpp8to7656sY
 ktvvX+Y++j3lXI6Gw2vOD3ExuFYMzK4PEKb7DISbg0EORHOM3ed8HgWmgUYZcHsLnNd47n6
 /b4I1u6V4IZ6+TwIdD04jcWFHCAkskkMuNvZkWoVB1wCE2tE+8Dj8l2gaokCMQAwW0NBa0i
 1vjbX7blZkrk+9M9x2kKmoMPZYIgM4rQwg1JzBnK/dZ71wdzYBKqxjS4D6MnZSspZd53L+z
 bBkU3SASox15sx9HQtMFBXC6DjqtBvXu1q3r/TiYx0PEoqFKJVuTrmCT5aKaCHXc9TptLSf
 Sr+Sa0LZIjYMGMgOmnnQJO0bnnlITDImIXwKAnkknt1+4gExnNx407X30rN+/ts+pYVXi6y
 oGuSTvp2+3pp7CJ+1iEBbEUvffmEDfX1gskYFSoKQ/rE/0qVNgwdcE=
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
index 5d449a0bd9..ac80d85f08 100644
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

