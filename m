Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0647CC61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1134B40611;
	Thu, 27 Aug 2026 13:43:55 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 75C0940151;
 Thu, 27 Aug 2026 13:43:52 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831029t55c52bd3
X-QQ-Originating-IP: r0Nps7CY7hspihf4nIEwQhey5OhOvJOKM8c3IvEwwtw=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:43:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14439905447134748660
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 05/13] net/txgbe: fix link speed display info for 10G mode
Date: Thu, 27 Aug 2026 19:41:57 +0800
Message-ID: <814613EB33F13C71+20260827114309.10530-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NLOgczPaVtJAGVTYL4A0Ccr42aRW2WStYbKcjdNDPS+wCAk+Fnou1R4H
 +9zXEwMu0KVZ39jdhywY5alS6Alc5G9YuQn4zqo52ZEo3gfZhZPhMvmI/ugoZHtGqVI63ze
 8dbCEonTmosoXwdGf4ziTapUJHKsyVzaj/tsb7L6WSVP2R9gF4nLomcHEr4e6swNHKXkrmy
 hB1SJNtMRhkqPktvD3k5EyV/emPxTGhelW3WtEBd067j78YnTS2OzRdC3NEH+N8ufg/a6cj
 HMXs/z4hjZ6jq8OpAjL1EdJiaekvbwjyosMRPSRuuyM1TgixpGUDZga6/a2vlPdCgW5TKQN
 xRb+3y7d8sxB5yCBphfbR09xjWSBpnf975zgTixXeWTw1g1WilmaZyeaM3Mbqe2W0wnfVLE
 YW8covZMMmHtcU42dw/lHZ3kG4msJgmrlCkuQat+MbZ2vkuBVTFptAvIOADCJxcGpYHEGoY
 FKNmkBRJhwnZwI8lw8Ck2/mbe4BmJ0F/b9QDfIzwb4EPV+TUaKit78vUBKK93Lx5MRFtkEu
 NSEOzWrj6YwPg/QGNrjauarBOBPwqVRTAonI0QFWG0pOKMpTmZzYGrkrNtIfLwdUENeX79o
 OD6cAywYsdImCEupWBNTEdGxALowUNf9YD7snOvGvkHeueUraA7OS75dSMZZm7A1KqoIbrk
 aWw83GjmZrnrX3g4ji6clfmZkeniXWPq8azb7CCefUe1XF7oyYVRY2dYJgP/jRdZFx/Dz3n
 Uj+mjV/9enmOatFdPr8d/hKj/8HKXMqMgFBLqECy989wcH/oV94WtdmtpDBZVKGTxUN//6j
 Nnc0xJykG0wye22iD37O7lW31RcxDXO42U/+Rs4MZOmN7OguWw1Crq4SKBO9I78PqnhAZqZ
 0o3FImYcVU6o3StCJrjCcOOc767tis6oHS2Wcmp3kcu+8Q0qxBOjqppjQjH2hi+Rrtl84lV
 e9AYbfaI1An8KAxTx6RVeG7GMTHJZ4TvhgN2qbDfaTPeFengWedFIaTJr2Fe0TSDBiWBxuN
 UpQ5LxSvGbcaa3RljRplTXGVbEvqbjskGzOtTfHspbVih1e24LfR8NkUvvGPe6L37aWmdzp
 ym5l4tdyv9wzOD8nNmg1ymT3Ef9yGVJ8UZ6+UJYN9WcQXRkzK3NLuYlZexQvj8/YjLOyyXr
 Ss2KGa2XIMCIY60JcCUUKI73qA==
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
index 05eac68f3b..90d4453b06 100644
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
index b0d2bc3450..ae755996e6 100644
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

