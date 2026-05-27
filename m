Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E11CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:03:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE84F40676;
	Wed, 27 May 2026 15:03:24 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id D605B40650;
 Wed, 27 May 2026 15:03:21 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779886997t02019471
X-QQ-Originating-IP: goWTKZs3aF2k2l7Z8J47BqDEhZ9ZdFG6UIgdctdb+9U=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6983871070741500449
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 03/21] net/ngbe: add missing CDR config for YT PHY
Date: Wed, 27 May 2026 21:02:03 +0800
Message-Id: <20260527130222.24348-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M7dxyDFn9MPm3JFFHs3TJ1fXgiZ0qUs3M/iwWiARp6UbVCDBVu73ZwvJ
 XhkiIVSFKUswguPabM00s4xZEWC5NrI4Vu89PR1ocuEsJFh4PlxHKbLWjCjqQvC54yJBial
 bK/O3SuYISHyT8lpDumYuBNWVoYSdEhClZw6pZI2aVZRoUrS7CBk1woQVKm6BqDQgsJLyNa
 Yzm8YxGHQwPvI7DY3ZUUe8J3VTDC9VkwGJJbYJfmwxy/r5YrlDpuLUFZDsuGce37365+cPa
 2mLg6ZWUHmkHX3vmQZRJUKgeQ+RuVht7RXfZ+oFlHuPfQ8AcpVm9RYYoHPrfeee/amxDNzp
 W1X4XJg7WhNv8zImS68sRsB7PK3nC0dAGEn3EC8IVm4fdxoI7r2gAk2/YdYWMdX5VOs9Xch
 fTOMWl0WeBa8t0M5qr6ymQYmwre2iO9uAAqNTRUuDzUYYcD2c9Sh4Ml3XN/zT/mHrZMSR+B
 bi6ByntAcUNoug3r+gTjXu2HdNDSd5n96qrZhhG7aNIKaO2SCwlZ7g78v1e6wij8OdLWdE4
 wWA5nWYvsQAWp1NiRar8fXwEJM5DQ/jtbfSkhTMhFI7KuXyYeR5eZvjuDB2iFBUwDvvWRHf
 6OCSLLcuhhqE/PikXsjgS7XCUM/Zm4o21P3FdE+q5ZbiL5nf3clWaHDWz/13SiySeGhuyW3
 SFPxjY/LmAAjMQYFMBhtC3tEBf4WioPVnPP8RZrZZF/dmX0seUW2OFblIq0OJG/nb7d+LDV
 8pZcVKKnwtJ6LPHTlMeA0gZV6RtAKW67CvYsHvMoOKPwtO5q5+RtNnpZY2sgsbr3mXyu8fT
 QnlLmQDMXcwwk9rZLF9cjtyfBAw4YtvSnH68NmndzS6cPPnSof0JmLrepXMdWTgtNCONtui
 u1Yv1qCEOQHxFwW24cLzkzQcrX2kL8GhwDP0JZNYq1TvG4QVyTLpsql698kWTncE7dGjFpS
 T4byr8O2njcZT8cc9sED6Lf8u4ulUNoAoxRY/vFMexyfMqnNiYCkG8VGRO7kr0dE0B3LVh8
 kHZFOmn3gyadUzesq4Sxp2TnnpCzqgw7XZosbZJy6lm+CqhhLpg1Y1CK2Fhjk=
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

According to the PHY vendor, when YT8531S operates in UTP-to-Fiber or
RGMII-to-Fiber mode with auto-negotiation disabled (Force mode),
additional CDR (Clock Data Recovery) configuration is required to
improve link connectivity. Without this config, link may be unstable
or fail to establish.

Fixes: f1268369403d ("net/ngbe: support autoneg on/off for external PHY SFI mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_phy_yt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ngbe/base/ngbe_phy_yt.c b/drivers/net/ngbe/base/ngbe_phy_yt.c
index d110fbc8b2..ab0778d246 100644
--- a/drivers/net/ngbe/base/ngbe_phy_yt.c
+++ b/drivers/net/ngbe/base/ngbe_phy_yt.c
@@ -264,6 +264,9 @@ s32 ngbe_setup_phy_link_yt(struct ngbe_hw *hw, u32 speed,
 			value = YT_BCR_RESET | YT_BCR_ANE | YT_BCR_RESTART_AN |
 				YT_BCR_DUPLEX | YT_BCR_SPEED_SELECT1;
 		} else {
+			/* force mode need to config cdr */
+			ngbe_write_phy_reg_sds_ext_yt(hw, 0x3, 0, 0x1434);
+			ngbe_write_phy_reg_sds_ext_yt(hw, 0xe, 0, 0x163);
 			value = YT_BCR_RESET | YT_BCR_DUPLEX;
 			if (speed & NGBE_LINK_SPEED_1GB_FULL)
 				value |= YT_BCR_SPEED_SELECT1;
-- 
2.21.0.windows.1

