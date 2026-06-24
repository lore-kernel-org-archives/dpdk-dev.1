Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0119CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ECDA4069D;
	Wed, 24 Jun 2026 13:53:19 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 8A8DA40668;
 Wed, 24 Jun 2026 13:53:14 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301992t61ae4eec
X-QQ-Originating-IP: k9RGKhvlkEUlEioZ23DEe5NcU1cUtI/8ZFKKJppgN3E=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15355808688701682308
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 06/21] net/txgbe: fix link status check condition
Date: Wed, 24 Jun 2026 19:52:38 +0800
Message-Id: <20260624115254.20348-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NQ1SesBsQjVtsh/LHfr0jdGu0RGzdSpaGJp1hI/OAMMk+46Xr2BYQa6h
 qMLlLoaw3pbGcJ35i1wJmCqQg2S1CxBiulrush1Ki/D08Z9EV+o8bC5wp5/cNrX4zK/G6z8
 DAceEKuNARYPCsx45d0t7EZ21tDipjaMnK6JFke5fE3KKhVxoxl+TAswr2SyZAGgXVdJykg
 BPsbx/PFlJ8gIzyxj8ec5WCU5dr9alHhpEGJ/QFArJZbRWldt5ThiwJ71BaOcYzQanSv+Ov
 YIDTVbWZ36hjtuwfN0ShAdeuFCxC6tgHe2AQiwVIDz2FK8HqQWDxIpJxHLrAA9MFDcGHog1
 ivIa3EZvpxKAdWIre1k+eyTXt+qcpY4hj3xbijJTP1Jw3RNFIxt5NhYE1MdLN9m2vwan1ZI
 APE7UAvmXjVveOOQTweabVxHEkiTfH1Z8Wm8pOZTLBNKKb6AJjihgJS8NHUGwlsvgmo3/bE
 d4/S+5QkwoJYpmnV9u7xLm1swm/A30ZIrkPJynxR/UYcEkpSCiKM6J90uU8XQGfCIsCS2fi
 kCp62/FFXktVqFHkMfFQXvNShIHy1/x8SIXHqa6Q5QBZZUDQCP4dcG5bVgyUHFNo9xYSU8W
 uGF7RmyvqFYgTOEiNhsLCdMP6MLyNRaLgmX7uG8uIP85wdRBmFf+1WSj3CyWOXL5McHm/JM
 iKGXaW3HDIEXc4vw7kPrE1jfrElyaxaCICQr2ab6oQRIeg1mySlVcGPpmceWNRIMzufOx9U
 WmZAK44Yf5rs+KWOsEI5DNQOVo5iLIg7VSR3LdpsT+YyvP/AVEnD+xl8x4p8pwus/kYhKmX
 GQG8jXlqoxI/mhf+d/nMhgDx4/8b64Stg+3LDi8JA7tWtzRcqf9eKYCI8xrEbaxduxEd01J
 HWzfpITAvlo0e8f534j7o+B8bsZwifBRP9oviSzv6DlJzc0toJfS3K7HYESI9oVGQFYLqJg
 VeWzhKqQsmHqrql5aGkrPKimm6UiyDdY6cHHcCIFlAmulPvtX3LKnIKvEs6xxyTI8bH7nDi
 Ti3WXJdr+iYmSwkwVZ1EWMY55nCdCY8s++pjNax/qN5ITctbdW+KcfYMpDegZS/EoTokCbY
 Wmh5PC7Ye4y
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

The original code incorrectly used 'if (link_up)' instead of
'if (*link_up)', causing the condition to always evaluate to true
because the pointer itself is non-NULL. This led to incorrect speed
assignment.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   | 2 +-
 drivers/net/txgbe/base/txgbe_aml40.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index b376eca5b5..de9a1b1c93 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -67,7 +67,7 @@ s32 txgbe_check_mac_link_aml(struct txgbe_hw *hw, u32 *speed,
 			*link_up = false;
 	}
 
-	if (link_up) {
+	if (*link_up) {
 		switch (links_reg & TXGBE_CFG_PORT_ST_AML_LINK_MASK) {
 		case TXGBE_CFG_PORT_ST_AML_LINK_25G:
 			*speed = TXGBE_LINK_SPEED_25GB_FULL;
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 733bbac13a..eefd7119fd 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -68,7 +68,7 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 			*link_up = false;
 	}
 
-	if (link_up) {
+	if (*link_up) {
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
-- 
2.21.0.windows.1

