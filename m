Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0739FC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2A1940EE1;
	Tue,  8 Sep 2026 15:28:07 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 58CC840EE1;
 Tue,  8 Sep 2026 15:28:03 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874080t7d2a0714
X-QQ-Originating-IP: tpyDNvsb7yE5QUJFM6EBuaWfdeuLGa6IRIpuPqDinDA=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:27:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15114511602039490421
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 06/15] net/txgbe: fix link speed display info for 10G mode
Date: Tue,  8 Sep 2026 21:25:51 +0800
Message-ID: <D2D9EDB50983044C+20260908132742.2661-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NHe429tUHwRsfMUKk4jHriw4JRF+UIpaqSMkiL61f7dqG9QeF/lxDxiK
 nueR93Sdy32rcKesYc9KWrE+kPD6h2b3MgYwIWGtBCBGajhQ0yy7AF8u0R2BmVakRcFd1DM
 B5JbBxZezEKFIsv0qJkiB49xbIr/FWUiFm1eoxJTcx/D9cDwPjK6A4v8onre8EWKNU5X/51
 v9jtnHoORSU64/0Z0Wkv3+yb1bg7YpwCFmD9VUD0FIBMSEAy+ohh8KtmwnB9WTQNO1x31O+
 GjBTuAhDMxg0WVy3q5AsnLsOK8DO3QwhwyOaXRTSYdHaZC/WE6HGXiMeWopSb//v2Jvkcn9
 WPH75F4OYTf0gjPxFmLtXhu2W+mXht+yWwpJWBEKXLdGebXI/n5x4xOnxE33kIJXZ+TIpON
 1oi5A7Rl+K4nkCoopdUWtxlMa9lI+DEZwmrEuYUJuG+eJ3lJps5cBLmIm5K9UsyNOxWhInN
 yA5VTF9uzybQATthhfL9qZQhusZrx/wyp4OUNKsk7WgEVaNZ7bpkGCXlWXvNV/XXuH9axr4
 mWf+MRBam0ZpZmXy/AiRaHJ8i4W1YVdqTUGnk1dHXK2JbaeJwpJIYZODqfy5Sajyjzx71mM
 stzZ+PlJ2TflhZ//+DI2rPlcKeeDscBnLnWpS/wYnYETfbkl+gmprJrPOF0mxbBVgBSrB6g
 A3xKfzguF+jG9g6UYxRmtJ4hi/KI1Fi62RjsZask/HzXWNZbBiN9XGyxJpcMBtl2K1FU6VB
 708t8EOYUVk1ueGZYdRH4VKE3hvXojvHqxr45f+XBPPTPHfOETSAJDNrnqBu0hpAYrjetjy
 7ZXXXWDdya4kHJ6vzV8jje+rWKlzTUpc1feLrpnMDZB79oyWzX50DQM7PkX0D5F2/wuokUy
 nynMJUK2qbydQIOopjZ5YeINmhoNLkSKZwr6fLMOGY3PUF5FVG126D0fXXCDM0NxRJVo9VD
 5XO0x/Bi/jDSMRGMfm2e3nFRe+ozl7Dqz3biIyWNqF3+Bx4lQAQ6GfMMqgoqqzcDP8GwCmL
 P+d7LGuLjhKE09o7pEIkcMt5dqZqPcBrHCMgUeBCyQvYM5YcgPpe7j11hlQBWNrf+6XFLbv
 QgD/jjXL4n1+QxTj7p5Afuc7xXOfxGH9uc6lgKD2opT5YVvxAFm4P9OdQ1MJ4iUePI8SklG
 U9Db
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

When an AML40 port links up at 10G, DPDK reports the speed as 100M
instead of 10G. The 10G link status bit is not recognized in
txgbe_check_mac_link_aml40(), so any non-40G speed falls through to
the default case (UNKNOWN) which is then reported as 100M.

Add the 10G port status bit recognition, and include 10G in the
default advertised speed mask in txgbe_dev_start() so a 10G link is
reported with the correct speed.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 3 +++
 drivers/net/txgbe/txgbe_ethdev.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 5fa7c6a243..d812adac69 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -85,6 +85,9 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
+			TXGBE_CFG_PORT_ST_AML_LINK_10G)
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
 	} else {
 		*speed = TXGBE_LINK_SPEED_UNKNOWN;
 	}
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 9e4eca40cf..bb4ff3c492 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1912,7 +1912,8 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	speed = 0x0;
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
 		if (hw->mac.type == txgbe_mac_aml40) {
-			speed = TXGBE_LINK_SPEED_40GB_FULL;
+			speed = TXGBE_LINK_SPEED_40GB_FULL |
+				TXGBE_LINK_SPEED_10GB_FULL;
 		} else  if (hw->mac.type == txgbe_mac_aml) {
 			speed = (TXGBE_LINK_SPEED_10GB_FULL |
 				 TXGBE_LINK_SPEED_25GB_FULL);
-- 
2.55.0.windows.2

