Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B79ECA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:06:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 488C24060B;
	Mon, 12 Oct 2026 13:05:50 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 5CFA640609;
 Mon, 12 Oct 2026 13:05:47 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803144tdec3eaef
X-QQ-Originating-IP: RFHsGXevQy/Kr2FTriJ9iz1r5Zshi4/JKJe6xZiWRks=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17134969038939733904
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 07/16] net/txgbe: fix link speed display info for 10G mode
Date: Mon, 12 Oct 2026 18:56:24 +0800
Message-ID: <CC8EB24C90DB238B+20261012110518.1911-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Naw95TAcpOaRWyGY7agNOXIapXj2dF/Ot/sqZ7jeTNNxM/EeV2zN+kgf
 eTxtPOAZ1yMc4C3CaQvhBuMFzMc7KrqV6xaejdqFTKUptGexeB1Iow4uki7OUDMCaN9FMPg
 A2byh9OKVkDgDDrEtS3Ek91v2ki+3Rmta9MVOfHOjX1xU4tEQnafB6H0J/Fd4w/RAzODrZW
 EfDkOY2s3ZWKgNUZDwYKwBjoL88R+yUw43gKgaaos+g6wLkL116QuZf8fxnQHBpAWCctmKT
 YZEIHgYRhZpXK5eHo22h+0Uxj1fo8gOM5iG7QJgxqoU1LzStsUv/IyC6L9aoA3SaVa6NKgq
 +0FjRjdsBEfJhsPULP5hb+W+AOlbX5fFM2nlpgWmjZAtlSRFfV5VJe6WvI0G0UsmmgVAcWq
 6obn9uj0Ra5WmdITgFQxwEtQOKNGS1W880fnhq2pzmNY7z7x42pmiNQkQ3thfvhgkyFMh+w
 6w14moF3Gj3FdR8DbVpxzIsree6nAGZniagSD0n5T4g1nLB21KOZONw1MsNNUXQKVQWR/xh
 7c3SHx/szRkABoFIlSKnT0WnWVfnds9x7H+LYUiA58bS34PI+OBxTpGyL0XgvsIrTnpDCxS
 lAEV8X7/ipEonQLXyvZYzJN9vYHjULlLK3w9u86Mhp0GY5QPFuCWd3xvMHQ3CvF425ADjcX
 GSsk/wqYJwjChcTf8Dlj5VTRXHxcDdGw0qSRBoGkquaiR+yCfV/QK7bkaviu6UmDDBLcaLY
 p1nN6B4xeXvRL9c1zD3ylMlyaXk/+C6gx3z2bJ1vGnWf83ar5LEZHKIfKbdVD4yJ1S0YReT
 vo+JYXM8zH7sSzbxNuV5EK4IWyn/r0Bn1qOO2scMbseVHbpU00Kf1Zs5kH1aQ96T1rONtI8
 n1k98RJOpyvbsmfp+qhk77Yz1tQHMqlEq3IoI2rxCTTC2xT+HyqXeYVrkm4Zw9SFvH+VRCv
 yjw7MPzr23IZz6pxumJSceQrWOzXDgS1FpaOz6zvNmoXY1s8BWXoWMMragk9MtD9pZU4IQp
 YtLI0moe8JRiO81AkhduTa1UynHWSs5Zkmbzry/VNMYZ4Swc6C9qt7B1o9xx9jvkRNpHeoj
 V+qM8ycXdcjJDE6uXhxf4KNQXOE3ywc4tTtAQevfUsXAAyTk+MZmFA/0kWyjql4RxM3KiAz
 wiyY
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

Add the 10G port status bit recognition, so a 10G link is reported
as 10G.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 892dddd373..b52702b197 100644
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

