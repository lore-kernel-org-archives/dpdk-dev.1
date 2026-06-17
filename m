Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C27FCD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:15:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A668140679;
	Wed, 17 Jun 2026 10:14:52 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 7147940609;
 Wed, 17 Jun 2026 10:14:48 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684085t69c489dc
X-QQ-Originating-IP: ADb4VU6gUeD+2lA8/hUlmX9+0cxTE5v4/0bej9vwUPg=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10632538687495224198
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 03/21] net/ngbe: add missing CDR config for YT PHY
Date: Wed, 17 Jun 2026 16:12:50 +0800
Message-Id: <20260617081309.19124-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Of8SBErQAQJCgSGx94rwbJkuh22ck9LE4wCMNWVSuA/oyWRxaTHuePMo
 qZsKjZNDPz3zZ9mQ3keAXHkkAXbWyhzmb7JNIY5c2bMjMRzGvXqMzYJN7zIAfqUoEz4v3yI
 3uR6o2uoi0JJEeT/m0kbzB50iG2/4bSG9xJ8t/LXHldSNOGDrq4vJZMloqfYMR4ozMht2zf
 0jlUJNzE7OVGQzH6Zo3aJzE0tCzNejGBEfYDW3Lda0roNf9KbqlKcl4rFmwD6mVgWwNLc4k
 +rstunpW+ADDak++AdFKE/fyivlZBI0GPa9LLJPKKXaEmdDk0EYNVf9XeZRiPswdYMHfb8Q
 yg6vuxCJIxmhOWv2M8TCTtgVXaX6bncczn5s2+7v1Bupd6Odm3E4OfdS51n4SgnC1PFCxzz
 r+eQm7XdJ6XJWCgmnWWpws838lifA++h8JJ/gA2nSTPxheTSkASkVyrLLD1hUZWeSRgbAy+
 +k0fM6kIqcuMbwPvmt9NwFusnbom3Y8rB7GJbTlLz4JP+WS31Zg8/CFOWIyFm580H6Ri8lf
 9nYtgcj0cBNO0EKULtsJ2UPT0CZ3HRcvhzp1pBF8EtXVKl+abOC26r4w2NZbodXM5whEmTa
 RimN/GibwHnRcexA7EQJNoJd7/gzjM9bhMIRiN/Oe+rv1tQlqSPkjqKdkFieLtZvCtZNujs
 mbfF/6HcCgPsamPRHq23B2iMcH0CqmwkPvoad1ENvkPentT77u88VcSrvWBQlXjnbca03bj
 bIcG2WkLIsaqLm0zSegovHBASB9mwniUHroJsysfTOqfzWkEbC1O3k/REzDn19U3SL3hq6H
 KfRmUg9cnDz4oHdGZ8todQJUKsxASNUOEfbDFyrHbw9m9r4fbbwzw+4J71ffznhHBUYLA3z
 NnPnHALlb9+Z1NZQrOAhihyjZVb6Wf5D5k8abxrZtSpi1DTyhdt5bDoc6D4mHS18zDEuGlr
 S1Dkh1/NyxidEwV0PiA6S//VL3AH4HoLn9Ew+bBx50Jvx3tyZBXFmo1qXlvVvKcS1Pw2fxM
 Roy1N1JgQxKRa3/KPYzJOOE8p+o1ouXcidMD2/8immNy6kNR/g4jwG891fT6gmBajqzHfES
 6inFyKwQeBJz1KsDyZymMWTDIrj5eKjoA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

