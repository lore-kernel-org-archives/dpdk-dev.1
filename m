Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEAACD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93EED40669;
	Mon, 22 Jun 2026 13:12:03 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 29CC440657;
 Mon, 22 Jun 2026 13:12:00 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126713t5c7049fa
X-QQ-Originating-IP: PF99R1Efq+tofso67R/hUZSvDM6Wo4A/vYizmEg62bw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14112335131089295398
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v9 09/21] net/txgbe: fix link flow control config for Sapphire
Date: Mon, 22 Jun 2026 19:10:57 +0800
Message-Id: <20260622111111.21024-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NfJkUnPhMXV9mpwMX32woMeMSTi6nH0caBRPROkzQkkukFOjFT3ZzVFF
 ZOT+D8QrX9tBz8DaVkhS7vgpYiJYx+G+/W7LR+Rf3RXBqIzIjemspJ41yRYIPtpfGMUx3zZ
 O2EMYpWi0973vGovHoVrvpAklyJFek/4CBl9EaMsgZLRGWdDCaQ5VkMW2k1KspuihMkJbqJ
 KIqxjHdXTIUBKBnSbeJnHo87nCeH5wiuZHYhGYcoanGfrrbFZvLkvyXstwHPl18DCTbxHg1
 VH7dgjot0qY8QADWbO+YhsdsREd5/ZYRii0/Gt5R9pci8UNt9Is6eNWUI2fHQdH/DWX+myV
 NzxffiQTgYg+6y7P7JDqtVrWfkSgul4UlSEimTPNpn7/NQFzvp3HrUDtuM/1Ot5jo2DQTEU
 Xh43uOyxmal55wwX3ayZrqL0MKcp6W7DxYyI2Irart8iPGcZLCc8fXUoVyc3L4wcsxkod8o
 kYOyCz+ioDAcK5DH94DzDGQ49X+jNX2rtvMu4HkpKBHlnMsQlh0xQ9sD8gaEHH3ld5EDf9M
 Kp1zN09oi79O9NEj+IcnNq25cEqKFOeSmfoKA1iqR+laFe0k9oTKC7zpIMRCk6DHUxifKvR
 GasAqHkiu8n/0gAo5MLGwmdOE7V52YJMjDgUXVl7ad8ciJ0w3NcU/VZZJ/EzegQlvbEZg8x
 LnFcTVryWRUz/Uz9S4wR1lV4TWEF6BDeXRFxt0DpaiCJUhj0tNr9vKH20YsaCgrRjBrHuv7
 Ztps/7XCuiEMwR31cwh4gwV49MNjlfzGzKYwHqcqht1LikiLoZOJ8wvPbXHDtj2F1tNSgxz
 Ry+1xY6Def+DXGB72GLgPi4Uy/kYRrCgKJESXt7LPFht2Z4Fj9yL8yU7bU+pTSVGHF7G8Ro
 MNRGe7G1038xCBT4xLJp0khRQnxiUmWtTHfJyGUtGBJVH8Tu8e+o+FtIq/y0ZGx3n4u8/EG
 3akoDUlo7jq8n4xfDVdA8Rv5wkjO+PgIiWH4So6oJHQ+qxJqgMcrUg5tZ1TlPq5O5XqPNx/
 mYnzc/T4KBR82/7mQ3c+4AMxlO931Sg0JjTFX5ZmAJrayBE1ru6qerla1MjhGX5rw62XpSg
 SiveWN42FwAkxtGl77JIPogsQBGhoOG2tYk+RaW26oO
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

Fixes: 69ce8c8a4ce3 ("net/txgbe: support flow control")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 0d3310e15c..db45c5c0ef 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -1037,8 +1037,10 @@ s32 txgbe_fc_enable(struct txgbe_hw *hw)
 	for (i = 0; i < TXGBE_DCB_TC_MAX; i++) {
 		if ((hw->fc.current_mode & txgbe_fc_tx_pause) &&
 		    hw->fc.high_water[i]) {
-			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]) |
-				TXGBE_FCWTRLO_XON;
+			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]);
+			/* Only AML support XON */
+			if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+				fcrtl |= TXGBE_FCWTRLO_XON;
 			fcrth = TXGBE_FCWTRHI_TH(hw->fc.high_water[i]) |
 				TXGBE_FCWTRHI_XOFF;
 		} else {
-- 
2.21.0.windows.1

