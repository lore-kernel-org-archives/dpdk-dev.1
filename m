Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30286CD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:35:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0BCD40E28;
	Wed, 17 Jun 2026 05:34:54 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id B63DC40A7A;
 Wed, 17 Jun 2026 05:34:51 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667281tab566cf0
X-QQ-Originating-IP: XEbKQCbbX0MfeMZQXZZLVj43Yw7tSSPFyKbULs9nlD4=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13079526783246047314
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v7 09/21] net/txgbe: fix link flow control config for Sapphire
Date: Wed, 17 Jun 2026 11:33:47 +0800
Message-Id: <20260617033400.376-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MZChPk4K8ikNSjVjB7fJYU14LlvneocepOx8/D06cIloJbH68klO1uuM
 hYKsjUNFLrAglkjD/CwU7ncERPzhKrKEahc2sTo7q6eoOcla5gDacgKLxvm0bP1z001o50W
 JnifarKpNqU+Iu4LMDsm6iqNEZCQc5q5EOMXWzuCOXavIoSl78omfYqiAIImmcTBlfrM3AK
 5KNWOKjnN9lTF0ryMo/ddIbXZlM6/5pS01WUIUAgi9IyI+JDa9G3zUBhUD/o4gBBCI8PAr0
 kFjunGZ7DuiSWWMXApPe3BZ8qjgdXBRSMWd1W6VaX3xtT8OirOiBfXDPpygYEwGDGMaNBRx
 exgi+YVBKbWRvuOJh3Dh9su7uWwYNf/4TCJxaZHPAp8cOWJBq789uU4z2u3pLhTtggoC0ia
 0vOX2l8USrONnB64jJ94BxdjP8HPR7Yleo/l2GW/5tBeEqBzWaawWwqblVwGRVdh92TCjOz
 9DCrVg7+EX4Z7YgN3J5v4C2q9LA4LiuPO/qcSre/dYf0dW/eOBe3g1tGGp59297tJ5RAT1i
 ob0EIi6bNwx8WLAjPvBGBNL5R9yZjH4uA4qfZeHWMPmdTqBwe+eWxMTgll6xSnEWeuKBDvG
 stIeJJFtaNREWNwqxxhtldCkQ446JkcUvDOM4tcjbdsEUVtn9QtjvCVtsI/EpLvaELpFa4S
 yWoRJB0ylIvOZqiBMCQJBH8QkoFxYYDGr5S1R3wGmlDL8wR1KAsXLfAeuU4zbyhWkQQhxi5
 5rULXGqU1yhfKvyBcQQ42ohXXRItVRuo7OwEATgVamOhfj0fyAHO/KL4QWouM/e0XkHy6VI
 D4Xl3/jSfk0+tlKajS6RZHIGE2Jg3Q0M1J84RFfXxP6MlMk46OAHz5c8nOSk7VPNr0zUZ4P
 CdEYm/ysJCv3mdKHdVuiaV0CZVgvANNmrrd9+ND6iQ3l9eQfEh9w9qPfTe6A4YARLxrhSHC
 7YQLdGBWKCZpaAKwYJyStGGiajBnG0+mfJYCM+0TbXZljmskAyoi/4Ym6SdrmukMIcf7Onc
 aneQKATmWHI7/nkhk8OA/u9rrb99qmvahWcUDr5P1md58naxsVzyE04K/RnB1xrM7bywBAc
 BvyXNtu/XzAJ6dpwoaA+hA=
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

SP chips have a hardware bug preventing XON flow control support,
so the driver disables it.

Fixes: 69ce8c8a4ce3 ("net/txgbe: support flow control")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 0d3310e15c..db45c5c0ef 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -1037,8 +1037,10 @@ s32 txgbe_fc_enable(struct txgbe_hw *hw)
 	for (i = 0; i < TXGBE_DCB_TC_MAX; i++) {
 		if ((hw->fc.current_mode & txgbe_fc_tx_pause) &&
 		    hw->fc.high_water[i]) {
-			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]) |
-				TXGBE_FCWTRLO_XON;
+			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]);
+			/* Only AML support XON */
+			if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+				fcrtl |= TXGBE_FCWTRLO_XON;
 			fcrth = TXGBE_FCWTRHI_TH(hw->fc.high_water[i]) |
 				TXGBE_FCWTRHI_XOFF;
 		} else {
-- 
2.21.0.windows.1

