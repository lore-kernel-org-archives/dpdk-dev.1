Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6685DFF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B14B340667;
	Wed, 29 Apr 2026 12:26:17 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id EC0F6402A3;
 Wed, 29 Apr 2026 12:26:15 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458373t48689d41
X-QQ-Originating-IP: sV3fcs8heYA78nyBk5F0ueZP5kUNj2jizoa4xiESJCY=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16355615102933835324
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 03/20] net/ngbe: add missing CDR config for YT PHY
Date: Wed, 29 Apr 2026 18:24:57 +0800
Message-Id: <20260429102515.58880-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OVAgSpUT8SOP5hccfj55PyUNRKp3XPUM8jJ7e53ZzS9wUUwRRBGsuZWI
 G+SQ/W3QUmRaGqamNqoPQqkn3JrzAxCGE36bvcZ32Gv2NKjzKypo27M01owlaYvqrq1vPip
 FEXy92vmLJPfaEvh9PBay4jENdd+BnjXpEVIKKhRRXFcTniZcu4ujETFGf/fFxkyC5Hn81D
 xOAlsw4cL2KfB5Z5NZUJWX0ddmbVsDacdysJAkqCC80C+TLNCVTsPwIamWQQ5ndM7JZzQtM
 Y4tgdT8q6esJXWfKAORO5RVJCp0cJMTCKgxGVXEvvg90vzb1zGdpnqDY8qK3A84dO80imIE
 QitpiHSNODtRhkI5ZhABHouPYyL+kUw1pojDvwxpb8+BH+AVqr1LETNkK7wF0JZrIXhDl8y
 C8vizEyiDqf5cFLQEaiKfAgcDlSzdAz2SbHnhgwIJ8qPDvNIsl0O3NP72p129UO26tSDog0
 U275Fd5uxJboAjyw8sx32Dwr4ZvlydhphGCkR1S8wRrq9rAPAEyNO5b+8pfcj54EXBbXs01
 GVWObZTRYxRRutt4ONU7IZ0CYGgBAgp7EVtLBzPucZsZyQ5oWIExRo9c4n4ex8OAJvyTyco
 GJLFFq7Ae9I1vYvORjPCI5ZMKfSxr5+fxmYkSjnvBFMvHilfu9Oj5/0MYNP1FMmPiIbuWl4
 BI6rGg113ECSN5F/2fycnYNcf/Ggzc0wsCMncrN4/6cQQeGOhmQnDfDppH/mk7XA6yxCNFQ
 +usaeKxFboumpwr61MXZGA4m42P4lmErea236b7SEf1wRLrDQgmTQyf8n9au+z6RTDaHI83
 refrlKBqMnMrrumxVRO0aQDhEHle76Dh8xQ1lcsq2hFKW+dp1ikFfqKXbqaOiHFJdam4l4x
 Xb3I3ZdIxthJC2O1HyPQNgA9gWb/s5HIBG/S490PmNsgY+jT7zgWlxdyvcTgo+4aJIqLWfo
 lNILdWA5kqcVFrN6O/3Wvwbmhv7L20uZdnupCBiQnn6pq9tM+Npn0nosrF4wDSPIAn33zcP
 Ho8Gk5RoT7YnTaSWNGbc4XaHFlaHXUiqk/7k0hYMEmXU+tgflm
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

