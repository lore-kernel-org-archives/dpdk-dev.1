Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABD6CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:02:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 879FC40DCD;
	Tue, 30 Sep 2025 12:01:00 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id C8BFE40E1F
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:57 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226452t26773769
X-QQ-Originating-IP: LdZmLwo+x940J4kAIxgUwVJ02BnZwNPUvBF62PRpkvo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3282865521064815579
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 14/20] net/txgbe: disable unstable features
Date: Tue, 30 Sep 2025 17:59:46 +0800
Message-Id: <20250930095953.18508-15-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NLzRLBwQcCCDJ9cC9dTwEHL4oaJ881OZNwCId6Cl0ECR1mUliW90iwJF
 3dIvetFRovRvUw1qUilUy0mF/HB/W6YMsNWpXpRlImys5gycg7SMcQBWQNAG9ocnr8Q4VvD
 SpxFe5NLqv4yO4rc70/PMQ4qL3LJ0qpwmupHqLRVoVNbgpvSaoi4jd3sLJj1pb4v3ki28mC
 A9ijoOc2RZQa+Zkhub5DBZBOIVNt8PzWg4AaAf0iqCpZGFW/wItPTnc6Nf81pfAkbdhts6V
 goRjdADHdzOpKwZBBg8ds2HooL+9lWTBSMcSihM+1hugNzbaYgRco4urj8hvwNWSqea9xm7
 au3PiRDVcgFi9nx1z3JYPslt0D5EC5IbolOD+RXqW1nG++g6rTPO0owPobnbSe9HXzqwMnl
 MOlq6v3USPPluWmM/V1Cy3WvdyIeSrzRU+CcdMoLO2Y55EgSjiExGcJLI2H181Oq4lLHoCg
 tb0ktEazPT/XeGUd7sd6UlpS6l/nlcvgPFXo/ip/HVAodhRSEt0MYsi3aCX22SYyoHp2Tye
 YyRzfXZBPQEDepaYkUc2VkDBSOcDvwlu8uE4JWHsF4SaxDTClPUYdjRb+LZnhMityMW30Zi
 eOWFFJUWeXn8448iM75OWUmjGwNwoWwUCatqlQZof0qKCss/riq+iigO84CCDzI7+ohsjTt
 fezTHCsOQoCRac+s5uxAXR/A0rrCWkwg/7LIdsf8Aoa9y+EpkQckZ7oZOCAc443+oBQyLXh
 4uhBlLIhuheoY3XyMb8YuUhTzN6CxCAomuhxtSuSQ6uiPulgE/PdbEiXDqIdDDyMnu9efQV
 rT9TBlzSkSM0rbE4IBxuEVfPHkPdHVumvDCXkU7z2wLDPrAo3ttew/JIkpIgerEEueFhYPp
 8GODTFg/VOHUOGUO5WlhO82e5Oml9UZrkJtOG/MaFIqIY7+p9faZtKqJYfQ/Z/SkRRra5OZ
 98JQGIa4EjrFOsrh7il487AuTyBfD1HZMZOj9BjKppu4v9eAHk8b7pr9wdWZpnk1tshuRoe
 Ffki1zB0aSUzTBbnwlwKhP0PswLwSTlIGH2wEhM0z30LzgWamc8qHcV9/hCOUCvWEpR4kFL
 YY7Q188R/GK
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Temporarily disabled unstable features on Amber-Lite NICs (e.g.,
flow control). These incomplete features will be gradually completed
in future driver updates.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index cbf7aafe7f..d845fd0a69 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -144,6 +144,10 @@ s32 txgbe_setup_fc(struct txgbe_hw *hw)
 	u32 value = 0;
 	u64 reg_bp = 0;
 
+	/* amlite-to-do */
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		return 0;
+
 	/* Validate the requested mode */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == txgbe_fc_rx_pause) {
 		DEBUGOUT("txgbe_fc_rx_pause not valid in strict IEEE mode");
@@ -3242,6 +3246,9 @@ void txgbe_set_hard_rate_select_speed(struct txgbe_hw *hw,
 	u32 esdp_reg = rd32(hw, TXGBE_GPIODATA);
 
 	switch (speed) {
+	case TXGBE_LINK_SPEED_25GB_FULL:
+		/* amlite-to-do */
+		break;
 	case TXGBE_LINK_SPEED_10GB_FULL:
 		esdp_reg |= (TXGBE_GPIOBIT_4 | TXGBE_GPIOBIT_5);
 		break;
-- 
2.21.0.windows.1

