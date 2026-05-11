Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA6FCD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3C2F40668;
	Mon, 11 May 2026 12:36:35 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 70AC440657;
 Mon, 11 May 2026 12:36:33 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495791tb3419e21
X-QQ-Originating-IP: KfrtGKVCuzPJu0dbV0Y9CtwRFBhkJiWEFkk10V3s+Pc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16799225716457244045
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 03/20] net/ngbe: add missing CDR config for YT PHY
Date: Mon, 11 May 2026 18:35:45 +0800
Message-Id: <20260511103604.19724-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPAlP4yRn0xg/L5qVYxGJiXVNC3wq9T0azsVj6FL0QvIPcr48/u2DDXT
 EsmEJpr5KrELiKz0v3zuGOEEYdqYUglykqTtlMhtHdehDcEFHPx4ZGaiJF2tjZKwvCs8Z4r
 J0+4B9+01ER/C88K+DWyXfNB+te0oWhH6kh+fbbrIo1Anx9Olmbssb9O5s+GKLwNMkF2R0U
 DocWnu8M77CfKIZFD1+yS2xCaNXh5iT82EiajIhmCS4sVdzY4vtql5C3hhxRIE1PqiPdxfe
 EHeWTYY68srDEz63LWb3a5GmU1H242fgMGIusx1c7dtDZVufQ3Qt8oLWxlnRs+bBDzxqpjG
 uWitFl5cIfm7nP4NpjC1G1h4YGaotzVfLdZaG2aSEtiDHzQtNuVvwdSTJIk5fvGuKzu8lbv
 bfPX7W+uAb2AHdELREuARXOUrViZDG6PBOYA8yNqjP5D7rEGbjfYv5Fy8kgR1Zl5ELu7RaZ
 7x1kuC7GC4GKPR1uxc/+2SktPJ5TUjHVuRzrby8DhQFER94RW3PSelVzsLNQJhgHufNJiJe
 pdK5mZxm/5ljxDSp/QphzEUbV/v/CLCm8c34NUfnNvb81vPOYMyp06kmgpQY/lj/zmX+vVN
 3eaLxiINMZBjqheEWVD3mlqYyIzZKe3vdl5RgMeJKrEp0/znKfv7BLFqQ5pzZZsWqs4FYdB
 gDRleVUrhl0jAet6e9wbOs3J7GfvIPCz9/tAIffyrNM+KsIeyFzNaJMXc0bJ+mgqeb3reNC
 Z2hX+SRp68rlH0ZJ6J8O2DvmDmrjQhGmdH27/x86YKloWiOpT/Ry0lZDa+vhffHJUky4nOj
 huZ7Jc/utjRBFys8wDaveSg7lJ8f/Mpesz4Pwrv1eQp1lLVhMedeAaRvDpHS+dRnx9PddUU
 zclJiR6ud7emR5pxaU0+3PybcNOeTc/ChacxFS9RE88glyefm8cKc6HH/j2wJhhxQGg7ABb
 3JB/9GwTRLnyZtJZ9yWaH58aSiVhHt1/gNqO79wuh2S/tObBN4n6UVvVr7G5WEIRxAcuaI7
 Z17lkI6STYdd/fngJpLdM77oU7MbcFakOMQ7Ho9mQXqxUgKhrzQdGvEGj+0Wdbb2TqsWywA
 Q==
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

