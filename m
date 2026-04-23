Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C6FAD3F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D2FC40A7A;
	Thu, 23 Apr 2026 05:41:35 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 7D56C40A79;
 Thu, 23 Apr 2026 05:41:32 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915690tf49d204a
X-QQ-Originating-IP: u2xuN7Y1MidawS+9d5HVgKJuVjTvL27CrOe8eJwTlLc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4133679208435135767
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 15/18] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Thu, 23 Apr 2026 11:40:20 +0800
Message-Id: <20260423034024.14404-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MziGzrjZeogZQpZZHpme/4jnB9sYodAABZwkITdB5DThZF40lLU7VxK3
 g40ja6Rcs5wr29S93JZB47dN08I0rbwFmD3L8SDrQOEJE+eq5NdiRpIXfGixZBYJy1YtR7P
 sxZBJ6qbGSqlsXJMVvkamPvnsOAD8lScoxbnseLX7SBFO27Q7An2n9sFT1X5uZh3UeFIyZZ
 2p3m604wyt+2W5FomyB3NBxCK3WZKM9B0FE5bRwjHT05R+JcRXxIs76DsI4iQTEeM54mNGs
 fI8VIM3ueXV3n1rRVeHKOt5/SsnncSPicsSRcrVNGrKjkE23Kg12rr1V6cQXzJ8ULg32iis
 AunEK3e86Yj/OLYlFGmC0mPKKepZiRqXuMeTvhlzSOSvfka1VLUY02uZIW+pJ/JaP6Mnu3N
 DkzXcMW2cGT4k4u2FVae181Rv94/KizTGgKcOxBztnX4l6Fwz8gZBwcLRLzQ4vDw9YLPJaC
 HRgJz2UebR8GkPMo1ZA+FGCcz3FszBm2WpsI+SpNef6alhqANz4sIEFYQkw4dNdWTCO7hha
 Mgawi+9dGOKVe/PEoob76Q9s7l+l5s9MViq88TClCuieK0VtoifCoYS1f37mEyKYHB0F8QY
 eCFxJlasSVKMv8Ri1g5PXhW1LYtWcZjTH/ikHiGXAl6jrDMK4YTtviRk62GRpY1mvbMC+b5
 uJZkxzsYr2Rw2Wk2YJ3gYKjPk9hjOy6K9b6AQ5ubxfoz9tSKPiDKYRnJ4EIKbyFj+sCpBlI
 0N5rc4UYGFoXunknfKhYPtHnsXT5LaJgQrGZtb4jFrLrtcSW0vcb6xNdJsoNYXIizdb1hXI
 PvDf2syLjrh//G2reUjBUBVmMmuATveRlNd77cD2OixbpvMZniUR6Tjgi9uD44hHGSyH/Oi
 GFIfAIbXBsawW5M/KS4HmX4cngq3jChEaHqqupj/zyk23F7oeJenwXK237xpO8W2Hv17RUs
 nXQGUPQmTtXW/T713OfGhduRzkYBaQyIZjVbI2k4vlT/q75aAkXVPHgpExG3m+BACY21grp
 X9TedIafnDaJRFo2s5g2W3Rnq66TtaQzlJZWrfNEMnlm5F/rOgTysOKLyC2sy/PEYHWLfzL
 FEX1JuDM1Mu
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

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index 7fab78f9a5..6eb63a8f06 100644
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
+		if ((link_speed == TXGBE_LINK_SPEED_25GB_FULL) && link_up &&
+		    hw->fec_mode & hw->cur_fec_link)
 			goto out;
 
 		/* Allow module to change analog characteristics (10G -> 25G) */
-- 
2.21.0.windows.1

