Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F42CD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:36:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2804C40E2F;
	Wed, 17 Jun 2026 05:35:05 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 08A4B40E42;
 Wed, 17 Jun 2026 05:35:00 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667297t9dd89f48
X-QQ-Originating-IP: wMhVSX9Bktzb99lIugJFHn8PH5OCgCYqrEWQiCDsKbo=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15023395778304858126
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 15/21] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Wed, 17 Jun 2026 11:33:53 +0800
Message-Id: <20260617033400.376-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MmPNY57tR1XnsifJrKtIMX7nsLVywoFtpH4C9CI9Gj96i+xcXd/lmn81
 m7FCn8rxCXNHdxod0WCEuKA6lwfVbJP2Xwqay8mvHcjD3nBVBc4/yTsKL4NuNoIBVrQ5dyQ
 wPZmBUNRKabHg0Z79ADLfaPVEhrDLO/PZjHcG7AX82O4QjfZMQ1hgHzpcH4u8TR8nJm9gEO
 Al5TKhLynWfc+mDJBNdCyrhc+bPVlzMgs24VHOP6MbgCy86UcFrhjh874exE/1hqTmrmOl5
 uWgk65MTQr9cvVV24Dp/jQhM41wIO2zNKDxHzucrsVFCdyJ+StIXClzRgYc1JkmgV0BjZqM
 82Jlfon7dOG1Ppzvyf4izq1uC1ZAWO1/J1u6l71IswRSJa5r8CHq+R00IuUSKwM9TshSyJr
 wuWrTAqyhov/cLt/qF4Jq9wmmWn4v6aYKRts2ErjvqiZIZlKqQM6fhNAGECVa45iOjCTvSM
 U7FUrTtUt9tRzwBtBcUjErcKBQluKvd4cC7C038+Sc5F9YpsJ6FvprTNA0nv4Rt0msFpMFX
 S3PjFVzeege/7V/y+KRaURS6Ie128P8qF3dqfZSSQfONjCI5YEweKrHEKtDz/7n132rNjmK
 /uJnsGh7SKeEoa51/hxvEckLdxTX9sRacL86t0gNUf2FAwdmf4IhPxEqw6l+AM5lYKwBmmP
 PMwPKdxdMzDLjw6kAjL4yvmn7TjjVs9LVmQ052kaZqWRx+tTz2CC+z/9anUcFO3Dvv1Ju/g
 Ng9Qt11jOd/WePmuoUP2E9IFZzVIrJeWClbtjNED+dledI5ElR2oUpb9HOei2kSLmm7J1s8
 bVYFxjCInoamMktFllLTOnNFS8astGbPQtundpcUjJpXFEk0j3rFwSiFsRaHSKFEumOf27f
 mTUX/bpOjd7nZONB2YcRUSYz9kX4k1oKjS+Vn1jmS4EqHjbdhlbPFskAcslZ+5GYRmfs8Ul
 9cscntsxqMttVS2ATOinhbFKYbwjIq0l5KCPsG3nX/bGEYRiD+DMGGwvBjTsCu/fBrujEhB
 G/CeIccKcjI6oxgyefEYpitdGN0/stLHJqSQDVMhH6z0uGj5cn/+DZ1JeKfTeKkllgvwgUW
 jD4WrpBFDJG7kj6cwnfl/FscHHoDOycVA==
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

