Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA48CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:05:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACC4C40616;
	Mon, 12 Oct 2026 13:05:42 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id B0435402D0;
 Mon, 12 Oct 2026 13:05:39 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803136tb63c8d4e
X-QQ-Originating-IP: srqAMdAxTd7vSRhJj0f2Utk3QAKyMdwBH77hWYFRPoc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2733558731365012258
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 04/16] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Mon, 12 Oct 2026 18:56:21 +0800
Message-ID: <56B25E1553CF485F+20261012110518.1911-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OAOHw7tUGLQOI52Koqaq2GfnLKls5IXBZSoqdpetAzBwRttnopHJIlwh
 oca53Zve3yN8+S9Zi8Irjsu4aHepC2OoGRsg5YrbWrYkrY7h29Lsx41KS9QMk5+rRAsxmSk
 x+dgNka+WBBKvC4ruEpz6s5DRgmDItOqI9MX9VKS4VtkfvLBRBD0oaZl8jR9mGK3P0/HCSV
 W28o0CY3ecp9iKgsgo3MvxVqNVP8ck2dlBlal4uHiYkALEaX792lk9HSRD9sjRs7ElXCWzV
 CEioNGASobspCWt2Vedc6Q3Z1CC/XXvNMm0xwNpgTvQdLSNhn8iYUCAvMRGLqlRwNF1z4Xh
 as+E7UgDmaNzQtnPsDMQF8y4DuzBsMbgDzUMoZl5x2Rzkry6StJJH4SXncdpYm9hVmkMhaY
 Xy1jFxoA5Bsik8poCTFU6KbL2qPPP/O6s2Q3gwv06N+KflGcd1hfeEsLT9ojX5yB0QK7QQ6
 5g5YTjYdFXv/85vhDPFmWniw1qMWXggmSch6icMaU6zXLLh8R+uNDFqlRmu1vMZ6PpgdL+l
 q6QRkrG5IDvxW2Q66Z0b/HSUV3yP4cyyKKF4pKgYsTA+TMxb0Cq9XrDli9aB7vkE1dyaZ8/
 9wnt98fcTZnAjArnOzX5U4inhvtGWUQ3hTwK2DkShybjBz0j1ilJLgPjy4FRIdpOk9ktHQe
 PyM7ulPEo+P8SOyM81P4gG4lhrVBIpG6lcZp2XbU9wbzBtdKvwd9YwVmljsm6jtMepJV0B9
 w4aVW0Ql1lMKnY9IUy/fMsGVVstFetvMOTSnb6/odOF4pKs6X+ABD+rIWtmYvviwZCQTsTa
 U6GWkgZpYKcisVbkztSAfn1of4jZ9NzOZkHp2vOruiJNUe563690qBuFr4sHz5ZdALk5yV6
 mzLqIRrwchB7mX/GdrbLWE5W9oAclwAuQHtRI8oKIjlAX/jMh5QaiT0xUhD8mT4uOuI78bN
 fQpKteI0wBV0Zm9vSroObG4xizmp7jYDVcEJrc52jbcmnYk3kM2n3SDQafvwbg0tuGEqYie
 7sJnMCa7o82PU7BCyOXpftrSotZzVardn3Y8duXdOxrWdOiwuvvbRLPPBw9mY9HQSnmYdT6
 xH9VUztG+DH
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

When an AML40 port is configured in 10G forced mode (auto_neg=0),
the hardware can link up but the driver keeps reporting link down
after a peer link failure: link_valid is cleared on timeout but
never restored when the peer recovers, so the link stays down until
the port is restarted.

Restore hw->link_valid = true in the success path of
txgbe_setup_phy_link_aml40(), symmetric to the 40G path. Handle
TXGBE_ERR_PHY_INIT_NOT_DONE before the timeout split and leave
link_valid untouched, matching the 25G path in
txgbe_setup_phy_link_aml(); the alarm retry then attempts the
setup again.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 7476759d4d..5fa7c6a243 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -202,9 +202,18 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 
 	rte_spinlock_lock(&hw->phy_lock);
 	ret_status = txgbe_set_link_to_amlite(hw, speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+
+	/* The PHY did not come out of reset; leave link_valid alone and
+	 * let the retry in the alarm handler attempt the setup again.
+	 */
+	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
+		goto out;
+
 	if (ret_status == TXGBE_ERR_TIMEOUT)
 		hw->link_valid = false;
-	rte_spinlock_unlock(&hw->phy_lock);
+	else
+		hw->link_valid = true;
 
 	for (i = 0; i < 4; i++) {
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
-- 
2.55.0.windows.2

