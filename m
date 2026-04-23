Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70DCFAD3F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:41:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3888A40671;
	Thu, 23 Apr 2026 05:41:18 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 8DDCB40671;
 Thu, 23 Apr 2026 05:41:15 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915671t7b36ab15
X-QQ-Originating-IP: Ft4Ppik/2+laqSkbhcOrr74kz8l0e2481ouKXP6GD6o=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12941673506579306576
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 09/18] net/txgbe: fix link flow control config for Sapphire
Date: Thu, 23 Apr 2026 11:40:14 +0800
Message-Id: <20260423034024.14404-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OAplO0LdqKgi6CkdTKU3PsxJNzBwV/WMa6Ct963QjI83CycHJHtUCYUN
 Z8LQqSOgzN1kBm0XK+Xl9/2gXsJh/kZkN/1LQRQHyyxoWBb7hprh5D0CKrLypCpCN7jNiuj
 mgi8ld8f8E0Pd8NnouN+7H4yuBRJIknk9rQBn/orxl0p7pfyrk5c/wRs+Z6O5Kt0SYs5PYy
 U4QuraE3m03B3p1p+236/U8cOUVXNGV5fgBJojZxR9vPL8VdJ+MQWI5U93kjjJ4PBqOlyFR
 8PD5GKgfi6mQ824PSmdyHccSp/gnNrUh8lX5CJkb9rSQQMFY0H8RWj7F2cYCCtrGsViJtTU
 DxD2Gd6gHFxsuCeYz/H57rerfji3Zv+YOLix/HUE+eGe8rqlwOeJjvdor/4nwx5f0Nskgg5
 DU9FskkBFfmq1d+xLIkBmALoy7tNv00TbKUh7IF7C1JyhimItFVy9lMjlAVm2h6Ds05YFM4
 pzsAW7NCuEB8zHMcWJ6z9eb21U1oDuFIo/p+3dbMIfcdzElftuHkIC+BLWXUDgbXE2MYS/+
 ZfIXw8ktOFHL4OmvIYuD8Yg/MWMXWKWNQJdeHK6vR+t98kjmyrk6IJnwSC1OcJ2R5Y7jvFz
 wGSEQhy0PrnH0U2LKQ7Cve5nfjhAG4VLQsaoweoNLtEhADfsqx9pqGv1jOkISWPT6ZgcpmU
 vYlbWgD6F0zirU1ExgszvfuGdUWgIEiRcJRiH4s7108O/BXGlSmsEZ6BD7rXfu9qN8l+s2l
 fScQPXvTZxALOutQI+WDeacC7XHOxvNmxcEVnOVpDw9SLaWJ0pkU1dp7v8SU1Qq5u/sKRFl
 0Yx3zYPTowkm9rCm9YCqbfsZavNY4hNN3912qac/ok9FN1NcF4tIK9MYgWRobdY6WtaErzh
 3/sI+HdU9VtHujPgF5bffx40vehOF9vhGBPSe8FGqnUnHzs2X6ay9LmXE1q5J3vb6P0cECR
 fET//E1QCI7YujIwuO+B59zOnJ+xJ3uAEqHH16zfGkuwFSG6RJWv/kvIsDhRWWPT9ktfo5c
 5mh9qhbgUAs2yOu6bE7/LH1zEymFeofywmen11dUZNEgZk3vg2odDe4DTAW+0NuG3+07kD6
 3u7LxnSckVW
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

SP chips have a hardware bug preventing XON flow control support,
so the driver disables it.

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 52fead6171..0719b56e3c 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -1035,8 +1035,10 @@ s32 txgbe_fc_enable(struct txgbe_hw *hw)
 	for (i = 0; i < TXGBE_DCB_TC_MAX; i++) {
 		if ((hw->fc.current_mode & txgbe_fc_tx_pause) &&
 		    hw->fc.high_water[i]) {
-			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]) |
-				TXGBE_FCWTRLO_XON;
+			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]);
+			/* SP doesn't support xon */
+			if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+				fcrtl |= TXGBE_FCWTRLO_XON;
 			fcrth = TXGBE_FCWTRHI_TH(hw->fc.high_water[i]) |
 				TXGBE_FCWTRHI_XOFF;
 		} else {
-- 
2.21.0.windows.1

