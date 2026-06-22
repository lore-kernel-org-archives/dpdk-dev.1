Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EEECDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC47740A80;
	Mon, 22 Jun 2026 13:12:17 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 17FB940A6C;
 Mon, 22 Jun 2026 13:12:14 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126731t81446f69
X-QQ-Originating-IP: kTn5mDiRyZHjIfF2UrDXDUK/ZEi3qRXZ/vI0IZ2ompg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:12:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2461062630615354132
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 15/21] net/txgbe: fix FEC mode configuration on 25G NIC
Date: Mon, 22 Jun 2026 19:11:03 +0800
Message-Id: <20260622111111.21024-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MzVAWEUeolcaJbQH/nCJ6DtdFyvyf/wJo0T5/UHurhGChqP22/Y+o8wO
 W3+fpd7iJjCDCApovvUB88p/CSjLzdInr8br74+K/bPkj3eX+3m0dpMFJQ5wQFtEnHrM91h
 q1PVzAQ4ZOZU6ouONH5IjiEaLc6vDiyw7NIUDFK3PKAHJFrNoZWmSkZiz8A08sW/MRdtVBD
 PDOQNdzruFBRAJqhxym0znPXWuO0jYyIIM3r/fZ5C2nO30C2eABttXKAgjerFlgdQ9Z8teO
 H75hPmQFWghxfZdguI87YzEz1VjS8KjXeup5TAaoG4tr4diwO9gvFVd+E1YyieFp1tuKmX6
 wYsYYaeJS6j5XdlGOcX0Im9c1LYYtfhdyVs6Q8h+MDm0+5b/nW8+fAl8wyJeGRdIeNWe46y
 UuI+gdP7avJlgKdU8mX9TxLniP+KMdwwbclF97CBTjO0XauITQS0LML8AakIo2jRMxS30FH
 ZPcNISJoqREkF4H+a3PFOUVL32UUC3Gw9MfidLL3FRIVZs3W7SYR/UZzEbsgcJx+0xq/yGK
 5gxU89SFZ+YzjBhh43Aekv/3eXs1T71GSExus4kuNGU06xdhlH7262ClxFJ17erixQvdgkt
 mbcxF9wGawE+pipQTMo3zSz/ESMnoLD8BBgQ8a4xY9vkwdlpKPhjsJtBDzfn3+06BCFpoa6
 1z2O2OCouDZ2spXzDEVcNov+E9EVEh49rCutIT82c14cDoC2oK+BF7a3Rhm3CBNyykH/GG1
 4Z+b7prhFRnyPdF5VucX9Qs70DmI3CE7RD+wmiAcULpT5jH4BSon3sXvVl1umNQqYR7p5QO
 +CDuVpgRmizQaPSjyZPGf8kNje5tm2vFG5IFR+1aDqp7lpIC5plmW5KTczumGUoXRpMtOnn
 TBoQ/5QThfi878eKsQDrIa32gbIPqNRQWeLuzp6QhCm2hWzVqS+AeuKIjGVP+iUAruCSjD+
 8sR7VQB82rj1LKKtiQ8ObVjce1LEbxpUBlm9CEwzSEWg0nvaV/XJ8LLmL86IhRfd0XDdbqu
 rKUyv39BWrKoQO/ZoBk1ymwrqB4LcQ2aAC1w/lOHUBXYAKv0A726R2nzaTBqhxxGbQclwgv
 RbTbE5bGxdUGzPsyE882Pb70+FzCiCmSZsVDEqqT/Ve
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

