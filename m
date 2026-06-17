Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A1CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FFFC40E49;
	Wed, 17 Jun 2026 10:15:22 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 15D514027A;
 Wed, 17 Jun 2026 10:15:16 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684115t0d3a8f72
X-QQ-Originating-IP: 4EVOns8ZbtukpakiyBMuMoZPUkPY2+Nm/uC7CZ/k+3Y=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:15:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10656906796549014596
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 15/21] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Wed, 17 Jun 2026 16:13:02 +0800
Message-Id: <20260617081309.19124-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NyTsQ4JOu2J23Lbuib+CW3hL698Fs01vom/jmTOhbvb8AlqjHQVQW3Sb
 49hYrupxCBPszXK1NJIZ1yTHv3Jg8qggZ4aNsKRqIqoJAnOvmZ0vseT3lnRa2h35Hy8S1o0
 35Z8LNo98tlN+oQd+p6oiZKjVdBS/O5xxSe+NaPYYXrGws524eqmtKFuo63RLXvESgCGf0j
 LEGz4gZXEk34jv7vXUUJLZeHkNey5+Xzht244Yqc0DSdaAzhs+aK+QvZPe5rG6RyF1vjQy2
 f0e8z2vHeryRRK2TXUwjT2e4Ch97nVA52UFdGXHcraRHGWyTA/pJ3vB4hHM8Nez6/43cwZ3
 +g4IBCBqobLASVMOtduvdyoAUSQGJwLBVHygWltTapxL66F5Gm9r/FC1REfVNMrIZ9eCUYS
 GA68/B8qQ82Dw+38qT6YXPM9pUY6EURyWSDepnlDrLIsJOe9NZ7N4h0YQg82rlDcY3EoTys
 1ZBfbtRkfueSS/E6pAIyuG18ayFvMN9X/SChx67H2LDDERPb1qs3HR5YEz8kn1AFnUVsA0w
 rV5zmQ15qLOpwjWlbdvQVbrLY1rUlXN0FPCEabt257QAaB65/dBSiAGwQOviaThOZqKpxJP
 GYCBD0KczMVcbZ7QVsP+/1+cfz/QcEDxynWjbbyb6HBF5TKqLbcSc4cKyo5TvsEh0SaYyD1
 8j5+oh2D1ZerqdCcvLfWA1WMZExdWiT9liyRglcmd7z3aytHjiIbMjlCyzd++QE7BdSzKuX
 mYklNuRzktSlpEUo8vdi6gYtvvkPfCVlHwmDghQQaxgG45eLdZsA66zOheVrmO6c2z6gSLh
 Y2P0rIoekxlNOudL51Bvv6CujhQDQ/vI1fHDM2nFwXB28EaB6u9pnWepN4KFDNBYMRMdVBV
 tYJ9sPw+rNyIGOv7K1NZBLVFLWdyCGMQT9Wbvqvgt5akD1VtkRcjLI0aQAa+f14h16+Rl/A
 sL+2WMGT/26qf+R6NrEya4LUDiozZCSKAv05t+819prS9GCvfVkcyy2VnP6V/sNK2+YumSb
 PJTti1g9kKLghCYM1YS79U5gwrpUg2rFELx9qMFLEyrYZcxNJbaScMt9zlXBsDr6azfRxwx
 05agUgKWqJnxMG29ZBbFfOZ0+SeoUcWaw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

