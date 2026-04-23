Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC684FAD3F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AECF40656;
	Thu, 23 Apr 2026 05:41:01 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id C2E7C40150;
 Thu, 23 Apr 2026 05:40:58 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915653t6f1d195f
X-QQ-Originating-IP: aYceQSd/p/hXkK504BlZSY5xoQuIkSWHbRDRSiEGzbk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:40:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13919449926613207040
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 03/18] net/ngbe: add missing CDR config for YT PHY
Date: Thu, 23 Apr 2026 11:40:08 +0800
Message-Id: <20260423034024.14404-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MhOKvsv6t0fkWf1Xz9nWjIaSpmosWK7PEYBhjwtaF1kuwE+z2cNgxVuB
 3q7HcpItgOpuRjlI06p2gra0md2ruo8V/7qexuplqDBNxe/FLIa/tHJ6g9uo2AppgJB1+PF
 hzmoqXvfMyHGxK59OuaT7TvbH0ONiz2F8KDcBPeLE08kHajs0yUCZOHHKIWc3fE0xkh83zP
 bcpwqJN3FpKPwf6fX9l9M9ZeoGr0X1b3WDN8Uqn6TIx4VBb5gPRXqxBbFhlPtG2Nr8N98CS
 bZ6ogOHElsgRAHm8/Z0CFIPsnxwAJUdD8fCHntKidiGIK5vlBPk4QZW6/Po87KTyz8Cna/t
 Y0P7fMb5BmKHtTsJ7UwXCrVDlUECyQnpq4oW3MfP3NM3NS8Le0m5eX64pJXH831UoyOoi76
 IvB2CzKQQ5nn7O9+edvNFTt3UzwLrvUJw0IxXDAzX0qC7m9NVJKcs6C6cMxTLWCa93lB7tV
 CR8PR00TAjchtRZ4jDdWFPwsrV3E68o2wN7pqqPTT+l7fdB365fKp5FKq7L9FHvxa307cwY
 8b7wosgR2UXNcui4X/0SQzYPVGh0yIpVF5k7u6cr4PcB4M1Z1K2lUCqjxNGyvjSksdBW0nD
 XOI61YF079EvDv7t/sA1D9YRRKyZAv/jVntshcp3X164YAfch4tUGGwk9U8P/PSYTd7g+/j
 zZIQP/J3aWyg5n81qWAN1bWPmlXJokowGQK2WNi3ueTMMbOi2fKNwzR/lLpmPGpT64Lq+TO
 C0UHVcFQT2N0s/IfixMHNgIpRhiP2xvnV84BttPQ8QYgNO96XyJ1CA6ne7ieNJP2ix1as4T
 49YU0I9JX6d9VTNEIHm1T7Lxk7dHvxMLGUKDroTlu5uuzcFxXCxQgxzwhp3rew442M1maQr
 G9PAic0YdgDkztn/ypKr7UZzWLm5zzHfsHSpCiuFGsyHL0cTKrGsCGvkcb1O3Eev0g1Er/b
 97BCMNcEBIunNMDZJGeS07SVJ6GRr4YoIQoIfWNp1jT6vv1zEmB7ZcKQY6P+EFNiA0QS9vD
 GqdFoBWroTYEzcy6vqDkq8eiuzY34oCbnQxWLLB1zY9/tZ+2btIvTvca+OGNlauF85BUE+/
 CX+ciaQPdMP
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

According to the PHY vendor, when YT8531S operates in UTP-to-Fiber or
RGMII-to-Fiber mode with auto-negotiation disabled (Force mode),
additional CDR (Clock Data Recovery) configuration is required to
improve link connectivity. Without this config, link may be unstable
or fail to establish.

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

