Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AB7CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 244D5400EF;
	Wed, 24 Jun 2026 13:53:14 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 5296D40666;
 Wed, 24 Jun 2026 13:53:08 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301986t8e42fac1
X-QQ-Originating-IP: u0cnE0KLx9Xc797biB9apU0mdYOliETgRYEYxv6G/BE=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2903655738286214701
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 03/21] net/ngbe: add missing CDR config for YT PHY
Date: Wed, 24 Jun 2026 19:52:35 +0800
Message-Id: <20260624115254.20348-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OEM1rzvTEGt3v+KGZzU11NTUxtsw2/qBDLCBRz2DWMNvoPlyK5vrmftJ
 b6qIcM1d/7S8bkdJUM3si6RRxsD1A3U5h3p+SvdniBeGl7pOUeHJVTbO4e7QdGqw3+tufpz
 yhY9VPQa/HM6rcAdvoCbWLMVZCgYvG7HvkdK4y0JVx2It1uYFzBjevvzduqWJS+nv37QWpP
 vBpIpnN6wPNtOXBHrNDb/CBwZDAujqdIBLoPon0dORWofd5DZ0xqfdMWQPFBHfYkeHmQZdn
 gxymBQOFIDgEYz3+Ii4TOCsRTVg9g5+J/TjtqOPKaVKNOQdqgdMIeGle58BZ0mlseVf1IdT
 r+itviG1gCTdqdkv69v+UXo6buV73YM2SKQeNl94GEjw5yB7v1jcNTQw2WNd1iA0sY0AHYK
 lkA3Z5JeTcOEqnvgta9o1OHoWBDDWmlk/21j0DOdhI1rCSsHz4jNKYCt8JiFqJ+FtGSwOzI
 HvRA8HsWA3Is2Yg+fPmS76pxGZL9uSKf0xmBwiex4PjUD8bisBzln+WwkQZOp1DUaVHBCOw
 MXhdh7ES4tHROD9FUJGbXi6sd2PHTVxbEMJaPyzSoji5v7OgrsXHe0IxCinS3YIUxxw3Z1s
 Au1OKVxf0NQkvRFsfTR5HjnLbYQQ3xjhLGy+JN58JGcywL02xBoITvMdcrYENEGZuO7vHDn
 dvtQvMfnX/byf3EmsnwQJ4K/gGl0d8WQKxCK2nty0tEh6Cwl3rcwoLMJdmS6LFaB5OKFzI/
 0OOBOsFBNOOZ4+ffndOxo22xjjjiUhAzegUuIq1NbdjKZjDYaEMNFQH4b4x864+GMrYfkCh
 atF3+CNJOsctBbmKUGCI1xnYPHs27x6sjX2SAc5+YUGPAST5QPEB47XZrAWvL3NaQuuw8QX
 89HfssGw+/ILSi6ZQ54BTAPLq6orxdHIrNHI9MOjZ1EIAuvuY1vlEUyN9XXpDeY+pvnuPnw
 eKnJ9U3rqBR+nJhKvxzL1fy4n2aMhmFTlHGpwueAbaUb5/BocklIBU7VmO7jdkJOujDzl4d
 hlR1+auDaDeKGNnkQQkjmF18WbGCjUFks+2kQXSc8yl4tBrc3iNJpc7zsF+Abq1uzE9xx19
 nZqUQS8v51Htb5qvqYslqreZ/QaxwW7qfQJJGTtOYn5
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

