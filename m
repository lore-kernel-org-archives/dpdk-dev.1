Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95565CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FE2640E3B;
	Tue, 16 Jun 2026 14:21:14 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 7CE2D40E31;
 Tue, 16 Jun 2026 14:21:11 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612468te0bffc4b
X-QQ-Originating-IP: 5nlhNY2Z+69WA/MwFjm/zHYQsyl3M2ipQRWwtlEqMaw=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15974674573506972812
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 06/21] net/txgbe: fix link status check condition
Date: Tue, 16 Jun 2026 20:20:14 +0800
Message-Id: <20260616122030.9688-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NHHBtKpbeb7pdHkpf6lmdugsOFg+zZzt0/rZlw+2vV1e/HP3BmlW/9Ps
 HB4P88uUh/118MhfLXkrmy4VppHa2k1PqZuoZloUR1uJv9e/POTpgdUfKduUJhgMB8tQkyD
 hBqpXlISlUHBKfM4VmmXcPvTxTBev/qD2zo99R2svAwdNzyxrT9cHo0tpx+Ek2ijY8XH2Ux
 VC5NdhXfNYUsEL1Zu1aPmm8c2pK4dSRujhQ2bFwxXSnIAwRrHzzb8eMogwGGkU9JGoAxC85
 1QfYRFv2lPB/f1gnbq13R7VguvgMYfvYUBON/tWdCpcVAq9/So62dmvtWUFNRVa1PdmuAN9
 XdO3oGrCHe6F+FTUoJeUXVvLW0Nj4n2LSq1sgpi3i+vkbgy+lyGrMyalkxyvP+huWBXG17T
 Hj0z6JpfhCubfpbTUWOZkJhvDiEL85TiS/CoNviCgzptPOaPQkcGSRmXwymtg7xF+fuyVFP
 4L0w3EUONR0+QoyrXzbE/UJ2d1Z1TKZyhatRCmdY1ZMbRBZIXE9JvxKM/Bh2P67DqP23uQs
 YVMQnQ5DPB1cR3tY5iAV4xCHsM6jN29k9CxkAcMfFeOlx0ibQn2gHEVGzJwioIYFVRJv9VN
 2+bxhsMQajIYEMILD9JQFs1jJMQbs1RVcihobVJTWt1veCwf8cXvLr0JwzQXjAmJ11LsAjW
 g0/PHWrf6amt4hfrZIrnALI6tgh56900oXj7K2zKjFNRckqnjazDdPys5wGm+EU7vHzuVCo
 njyfWjOXGZuWOyWlGbQ5l8K3rSMU963dJRjZsQz0y3pI9V/Zs2Srplqc/teIImwey7b31L4
 y3woH3o/bkDHqZ69Cml2CQEsR6dARgA9cV/L94aHROZsquHaqLKJnl90X99Y93e4iAKicDZ
 0JiWoSEdYzN43WJWYhyntNfHXeQ9VMWaN9VgCOOuhBZUcqit4qCn3owWOWwOce8LAy2XZyK
 /MnCDdu5ERIiipmPN6npSXQ5E52xe1dbGayKuBOvf54tCMUf7fdUmUSNW/qhq1vXsXQv80R
 PmJ+0YgxjfIvVOG8eUM6GmQHqP9kkbV2XFJhJyrCv1ruBi139E
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

The original code incorrectly used 'if (link_up)' instead of
'if (*link_up)', causing the condition to always evaluate to true
because the pointer itself is non-NULL. This led to incorrect speed
assignment.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   | 2 +-
 drivers/net/txgbe/base/txgbe_aml40.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index b376eca5b5..de9a1b1c93 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -67,7 +67,7 @@ s32 txgbe_check_mac_link_aml(struct txgbe_hw *hw, u32 *speed,
 			*link_up = false;
 	}
 
-	if (link_up) {
+	if (*link_up) {
 		switch (links_reg & TXGBE_CFG_PORT_ST_AML_LINK_MASK) {
 		case TXGBE_CFG_PORT_ST_AML_LINK_25G:
 			*speed = TXGBE_LINK_SPEED_25GB_FULL;
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 733bbac13a..eefd7119fd 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -68,7 +68,7 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 			*link_up = false;
 	}
 
-	if (link_up) {
+	if (*link_up) {
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
-- 
2.21.0.windows.1

