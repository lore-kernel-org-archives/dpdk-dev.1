Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CFCCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70333410F6;
	Tue, 29 Sep 2026 13:21:46 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 08513410EE;
 Tue, 29 Sep 2026 13:21:43 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680901t1b1dcc1e
X-QQ-Originating-IP: m5nIuUuyfVXxRKxRThzkA0nIVhNRhHxb8WEaxU618Po=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2599805801455733379
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 04/15] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Tue, 29 Sep 2026 19:18:04 +0800
Message-ID: <EFC11E34B0BF5B2F+20260929112119.4516-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NqlQHeD3iZu/sFPJceHmHU2JXyqOgYUyIAN53NtXAFmFjXPV3GnN2o6g
 sRItF2om4dO2IVIjJJYKmrBapib2Srz2h4zFqhdgDOwMjtmPCLGdEf6oMP/oHo+Ah8LNP5t
 EE1bgEu09uW+D0+WKmUbGApwZOKq74SM1X1V3wbLltsM4NMsVszVLl5RlAIdMAdS+Y8gCRI
 T6arZWlhCLwai4dK93sGgayEXWnSXbBXsTBXUXuV4DuFV3CGTpn7+6yZ0awxhvIL8e/JYe3
 MxmjU+hNT7C08eshSDBs6BarREGizhYjGVvgvuRrdRqe1jtVSrsovYHmYB6dNEGSUiim4NB
 pjxQf/tGx2K9C9MRwyw45h2vjtgaXMuvhXoN5/M5VMtuHTO9e+JX+qzvqgXb3ABwF55AKbW
 Qil2xCx75YDNCQcp/D4lbWYHFddbZcXGbxXYdjzc5zoL97+f/FLXRW4CFEB+fu3Ot/xMkW6
 8JzX2IOTOzXNbSPMlmvBfE/2a9BnNuzoy2y2fXhgvi0ytMj73IEpQHWQti7/26VZhixizHl
 PJp/5Nj7KgUwNYCi2racx9hDBoaHdcADy2YJmrg8ysrxrYgm2XYhcxTxK7LfOwjVITlfOAF
 BQUQfEcFMH8cRdp3IgLOZIzCjDQWXDNq35uadv36LzXc5D9wml1AEQVfnJDvFBVOUnUB4/9
 LJaFMRT/fYhJubgOZ+rCMQE/YSryjetVfvqakpcUGHU1x3h+wZP4xuAuCybEx1I4uZ+QA6Y
 fmkGygGZkcc+jMRc2F6UC1eylCqkuXp7mIRK+tzOWmQS7PP4D7RZfnLJHO6F0Dn18Tmr+7L
 +o+vtyT9DVQm+I0m4gHp606g6R0R+Sf4+Bea2itv20yqK8zMPAQ4AjLCD7gNNwuWFpaT4eq
 jV24CacyiIMdi77xHMyJOcXr3Y6QzgOu9iQZF8hXiVoboMbbFCI+ww8wrLv5ycwarr4Ohmj
 A4AEDZ2cmUME+Eu/Ubvp8Lzfd9sTH+FLHSGIPaDOQgLLreN76z5c7kgXoC91urjP9la11zs
 ZvKNYNtQZCz8KwPkvJDkfa+xa3Rg7YHIS4Ls1Who8F2Qr1txWjU44TTpBeAIs=
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

