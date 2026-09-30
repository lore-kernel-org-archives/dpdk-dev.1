Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461FDCA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:21:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 285BE42DD4;
	Wed, 30 Sep 2026 12:21:09 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 9810342DCB;
 Wed, 30 Sep 2026 12:21:05 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763663t4d8f7d6c
X-QQ-Originating-IP: qVjiSB8ias5BvmDNekt+36UP8c4kG088ztgarQhX7Ms=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:21:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5159429820265397691
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 07/15] net/txgbe: fix link speed display info for 10G mode
Date: Wed, 30 Sep 2026 18:17:54 +0800
Message-ID: <CE8B8A8CA5605BB0+20260930102042.2214-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NZY6XYMwxuFEmYpe70T4V1dx3m+yErsnOLNeOkKD/cYrcPssDLthwQJs
 RwFp/msV+/FlNnGsG3yXBio+ahGm5WWLx3LxX1YVuT/63UkQx8f1BZw4Ao510gdKmAe4Lme
 3WffS2ZUee0rvUhPpnRjMSshwHQ0islbwV5k8A7w3nUaRccIJdZwNonCJQbGBiosegY4Eh6
 stDSQGAt3Wn9uer2e61NwZaVV9pOqsDJ4dDlexssDY4Bk/P0zKo6inmBZEQRk19SWzenKCO
 Z+/UEvA+W/XA7A5lNk3SvNOiziDmjFc0GZObZTt4FqKvKkN66a8xKJ1HzmWiLmiNr16l7wK
 duu0KR2HO6YyHrid+FkezWEgeRpg9ZO+iHx2MciThq9Iu+JHIUztH1qLaUXLnO/2QK7MhL9
 +tWQDYB84e0vP2x4F4tlSwYqM/XWG1DjhqtWVHN8SHNW4FMAfqwjFaw5pWzD2Mj/j0FSyzq
 GkD39lP4Q+OKM5KKCuJiDRNzht79l3iv+4B5BWj4+3nonT24tfVLhk74fJWeW8vlWQLnRak
 yFIxR6EWTgLKFHbvGXGLtwOm0+jBO9hXPt45U2Kr6WKkwmVis1aEQNDtO3U5Wl7Vl8MbRY7
 TI2DDYbqI3uXLS1uWMx7HSBhbDPUr3RPjClunzcADFlC6L7Hi6U8HzpTrbhLVfT2S0apajP
 JwCZrJLXB6xkpwpgQcq2CnZtKBrQhPmsOPPgJ9ZQ+X2+7MLTL3IrDd9guYP4VTMwlDOySOO
 ZNFA3sJ+COHc//jQPNzQ2if9Frm4MUu0lIs62SGzXN2SBcaKkw+2Z26VwX/GbCZN+0DAHEK
 2+hdKf0ulsdSVH/RgG3AdCWslOnyJ88NRZDqPO0hyCr7C1KGabN+wgh9ZDUdHk/55TKSNRe
 DT6395L0mr3xs4E3VDt89BxtoZNtmssaR5BnloAr+VnQrqQY9xLKcxArk6H4DuA6y6rPVEZ
 b6L0bRTEB79gllKZj5mYBXmOtmoj78CTdW910Q5W2KB2XCqi4qwMOlfjyLW9LSGm/vBuxR6
 AY3Ksoxb5l44Y9qv4PqhQayu+Yg5ljUO1vCOSe+IdAO6FMKkZMT4wItquzLY5NbduoY5hlI
 p4oXrAhvSHZLdbSLLXuYKG1+7q+yLQeJ3kCDXfpoyyh8CAvvB0Clhoe9yE7vialw7u4bOoS
 AquR
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

Add the 10G port status bit recognition, so a 10G link is reported
as 10G.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
2.55.0.windows.2

