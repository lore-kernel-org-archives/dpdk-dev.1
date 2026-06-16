Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254A2CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3AC740E1C;
	Tue, 16 Jun 2026 14:21:07 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 184AF40289;
 Tue, 16 Jun 2026 14:21:04 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612461t3b623cef
X-QQ-Originating-IP: xRlw/Sezt/gRaxe5MNBgk3UXss5vx1KjkNBTNEe3YWg=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:20:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9487360306239478890
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 03/21] net/ngbe: add missing CDR config for YT PHY
Date: Tue, 16 Jun 2026 20:20:11 +0800
Message-Id: <20260616122030.9688-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OTbVraqnVAPCnmWCkhH7U/ViT1iJqdpQwby0dDdtdB3whuH1Fe6TUTR/
 0WCGDxIOUY5v6UIdyr2c5hXea+ECYMqXcHiiYD62/XjjoNUBp8tnxn4ZJCB1VwKZ3+wqu85
 Nq6wBXB0NMJRyBUTh/3yGak+Lnclk6beJdE4hSrnepoUo8izeLH56p0r2ptolum65qDGyNA
 X0brps1ptohpEa4wWCaLR8o9MqXXbg+rP7ikultJUrNeAVDl9dXCtMX6y1c5WxCjk67CX45
 eWqSz+gBmmKpeYL4TnpFMNCnmSxIQAe6TP+DMaQiedUbxPUBbwboJgh2MYsgzgS3ZbqHpbX
 D0TOj7A5HST0UPRcMKF35iGrbUKLZYPajGc6wEPrrzFEgYrWim8gLJH+Z0VAc0Ik0g0XMZV
 10uPJvrjEYte8FyiqNW6Z4+W+E0AkxbN2ACz14LFneEHGPekcmaa93Rw9LczPOphnd7kNp8
 zgDGNC8Yk/ybd9+NM+RjzCNTiR0mETEI7yFKqTqahq9C3Fdj4D37/Q5ESuNiyMTAybkGK2G
 +sUxRQ7V+v6gKKNCX28rbBm6sNbT1szkZgB/3cM8KhtVcCBMp3EjR5/yyhz8f+L79uHve0V
 icKrbtGi2Afv0OLaTxq2rw97rz7vyzXtqeio6cF/YmhAamBl5vUWPLuVAzuPV+NPQIOYJDT
 0dLlQSFkJAdRlMhEz6W9wRkXE5q8GymHICJrpELzD4TlLOOuHTaJogBi14ui8w4KG7/FiNV
 ZZoUl0JII0FkTJb1FDzdCtPZJZa43itY/PZI/uNOgqeSfQYffjuuqTaeGB9AHQJeYtqjB8T
 tVqr8U974FYvc9aZtSPeCkZt2XUCvOM0/32p/+QR1bddLeMz9D2rfM8peDX5d4ZWup+qOC1
 SQQoh6r6aHLaTimjC4FlG0bH1GNjUhPNsnHNkktNEbHTJZG5AspzwYvQx87pMDW82N4i6aR
 8r0aQECR7NOcnBTyA+esegvIn1qm/AlEYeaCKxdPPgSM/9aDlLEB3PTCAKp+oKX2XPKJCEL
 aq3Vt0F+0wrEkhuhSHaKTT6qy0qbD4DhuhigVlFhVQ0G4WOG7NlxijHYAt6vA=
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

