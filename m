Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85858CD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 051F140664;
	Sat,  9 May 2026 13:29:01 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 9DCD14064F;
 Sat,  9 May 2026 13:28:58 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326136t6bef0f13
X-QQ-Originating-IP: 7t6ta4T1FNITKHGYceGMOBM3pAyn2erp+hBB4nOBFVg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:28:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11883211596100321418
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 03/20] net/ngbe: add missing CDR config for YT PHY
Date: Sat,  9 May 2026 19:28:05 +0800
Message-Id: <20260509112823.7728-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MALXGmGsaHY4SGRzwgArg7ixvoBeY374iROTX8pJKWrhjhCevHCW4AGO
 PzIlsA6oqEjZZn9Qq5JrgT8AAQ0LWKZra/thbNjg6O8lgPI8nHejawF08aiq9rNfPF6fkrg
 RvC+t1oedYPlM9VT8Z7MErsbCgL6LG4ztJk/7VcxqCn4AIlUv1FPZ7qjtrrrUM/adynIp++
 Zi9xzwnZkRdH9XKn/DTEfj0PTUFBzRXpLHqk+TdalYpRCLLdUc6y7B5XA1iUrILsjC0nhyH
 BhLVjPV+3Ka2fA2sKlkYCUGtOt50YheYTCLokWkyv/cp6T/5N6ys18v36girVaAaguCrT63
 ziWmZWlOBGdnINxQTjLzOmJ4R0uYQhH1FQRBajAJguoiM9UEjsXEJphKIdcVVexlaimJHv4
 nRmAK6SaMRizAJjjyKVFDenXq6FjcsSVhj5ZfC/hutn7Ih2bW0jZCMFjBfBrCKBnS+pCnBI
 BowVVSRy7YOmNkjuk/h2//7OvX9eKr2XnYG+LVybQe/lkNtDSkaillhduj8Z9bnCs34U/VC
 vw/rxRn4iH0uiKURJZVck0ghZzxcDYfsB1/5WznhwB2HaAL68Wdm5RHm+7Y3vAI4KQV+q9D
 P2tvQrudCbs8kinX7EDXab7bCMJPDIQENOVaevHXig7k+Kx5R3iuFOZKZlwou0xeQzdMh0P
 BXDZ9orLennDsiVHwWxNZQtDaE9QIPhOM8LbGOGbX7wdOFMU9rS1Zw53TTf1DaAN5U9dbWm
 oxMe0+hDtZmdS9QTvxnPvKoIsh2ZvfeQAuWl99JOJreXiyXCF+7FjJqVOI2B8yrdQCpm984
 Iar5tZqk/6VfJDvFy91ynT+u1AoFYwJ+dWrNpYcP9V3gU4yiZopY8y6WzK0jspQT1nSQB/U
 B63J/Uc/neh3+u/SRlI0qyD/OecYTCPSGDPUpHeUcR6+lBsdMc8Ndl0vjX11oFXBvRO1LrM
 qhByZOEtPhWEeD2LVurx9OvvHM5wfel41yBqMjYz+99B37oe12i1NO52EY11UGlLzy9ce4f
 yvHRjizTxOKhgs7TSTxhn7Dd3q0aL+YCFsiM2KHvcsQEZ7SBcKHNKek8EijegLrJJM+Rd75
 +KeNhWErnsu
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

