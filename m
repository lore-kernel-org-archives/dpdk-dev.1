Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6B4CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:22:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A61040EE6;
	Tue, 16 Jun 2026 14:21:43 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 9E54240EDB;
 Tue, 16 Jun 2026 14:21:37 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612495t544e6b75
X-QQ-Originating-IP: FZ7TtW06pu15Z24xedmghF7b1KEw4wIIhnTZ4F6Sf2A=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2676592631076088771
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 15/21] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Tue, 16 Jun 2026 20:20:23 +0800
Message-Id: <20260616122030.9688-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Ncu1oMVBQDrngp/QGnnSzyObU9gSIepZNws12HHCEg9c/dYB7RSW1SsW
 904usaFvYilSP4/dyHIIkfIB7F4++8BGd+LBlZDpTAUZ0nJIa6DR23Qp/xssLw3HLbxA2oO
 cpqV+cciYMZ8jnGctHoWVnyC3VlzgKPaHS3cx/LbsdAS8d3jM+yd6x8F3AcmV9q+UqYMtDx
 hjIucRLuVekmuoUzFhNBDCD8V2YbJqdY2eVe2CGKMPkRRMYob2ddO4ynwxaqebhQiO5JeJ7
 ziDM1boiVVVBHFyD+URscw2TPfPc4K1CaeAuLcardnaj12NST+hD4tX9USz+BpH00qWJGd8
 UZHigisrPG2jdAuo10lnKw410t3zVUjWRXtHxwDTdQJFHL0e8mUr7wq9Auq2D/A4mcOyRcf
 KTboTbGpTMbfyrR2jtZiuT8Zoo307EJTCWuM4XE3u/6v4pWzAQacyoNxTY8xtVDUgogkUyj
 01l7gqNc77F8uXKzTKyhd0c8/5FfLngKUJxBAgOkBdnr8BnrZ+jfIPDxrfer9NYITdiwMGG
 c/Guz2fK911tsmZeNFQ0lL77IGVH6a2kVn8a5u2ZWLWfx6kFVQQlzbNZZG90zQEYwNT0PMU
 6AXV6S+tX025bK8OHA2kQ0WZ1hZFku8Raq5q6t5UO81Wmy0UqZYN9pNBA7KAQ5a3S+X/IVZ
 RxbZWbLNq6TH4v0vH64c78o/a1vdxns704rQi2kuyX2UeWILD4Tt3fYjY/07lZmijC8olGL
 e7+CxKnEhea0TA+jedxxe6zvJ5ccIkszR7rhols2KEbCO9N/obgiyZagPkKFRA+uTHTp3PN
 /u39ENjhPwkpWyuUk0iBdv2mpGufRNkawKR49pMXHM39VZfwAMYrn9R48p4LJhQOWovGw6F
 XfDrtGADAgpo5xiiJjeEbDJ//WvnFob3QOVLxP513hoFHoN3HE9Y57U0n7uw35uLZafrB0b
 slw2cXfqDd+LR48Qi2BJtFp7794L6shBQG4zEus3NaaAIEhc/D0lWgWYPFiqwuW+ZQcparF
 VDYL4j8Eo62tVGokPnQkrwNYEFUbaRR6Eft/XLpFVCzBNe72OlqrTEJv/wduJgl7NrKRfh+
 u5OE9Exffh+PXt+836MJ6TxDqDjJEX+1A==
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

