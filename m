Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8BCD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EBDC40696;
	Mon, 11 May 2026 12:36:45 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id D96124067E;
 Mon, 11 May 2026 12:36:41 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495798tc5aad2f2
X-QQ-Originating-IP: AzFjXvXCcDauBUgTSmiq99wDmN6BWYs3mccGGGkzLdg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9358975047868960168
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 06/20] net/txgbe: fix link status check condition
Date: Mon, 11 May 2026 18:35:48 +0800
Message-Id: <20260511103604.19724-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NrNHTFHgCqYa8T/8RDMtP6TrK9D3Usl2CWZQ1mQvRM81GAwBALq1z96T
 rDmPp6QmuV9VVdnYBphDMKZddvkHVY4kZLjR6dOUOK9FDiyXZAnaO+9a8zKVG7xg0wLmS39
 /qk1Uc2O5MnJHORlAt7rMXLjppPxuo3ezlrkDOFrOwzfhwUp5mbe+HUqGW2OWe/wxcEwPnA
 l4+VeU60dyT2KO5IZtx7n4W3ni+Cxa7f9nAV1NhrkSw45xkU1+TDhJnh1Zn3QNnD22zPG8e
 EUwTrexW8WZJnhaUKiN9D+aUHkh/0Bc4P0BUEOSzu99Rd0aHpgTlpUGfQyCousavXqYX6iO
 YPuxgf5x2CbyWjwO48uvx/Kq2tVlUsiwDBBRfe0XIV9UXi+WJ/sZEC7bwkdxSFv6S0frHWu
 ApdqGvX623cOjPpEW14aCIHaGtZkq1XJNoNXrDE+nMpX/mKlu6oZ4EpI0M9LHnRdwfNtgmS
 ctPcz+YcTITChHNXZKElJ3wRezMsiO94IAGc+xZCUyJc7+loT3Sno4kDhu8RHa1tDocgZxF
 b2DJT5/y+oQhErKNcgpPraAgh7D0DLdw/pPdW/BIvCj4G931BI6+d3k/BKmueAD+U+RVoRE
 mES6LwxoDU/0lUYxSDKhjixhwomB6hZyre7Tbbqs/pV6/Wxr762ozKekTxQLdjRBL5qlUI4
 nEksp+Mb74mJUZPq8lwOWwHMbS80VrPEqjkBDqrH/ybTbIGlkwXTxfCDhcgHVPjAGb34KNb
 kz7mkBxUF+8w0zPlVQHdjw4dTQl8E5D8i0e2fOUMIzMC2zXImeVQBxIXYIAg72+IHXRMEsj
 ZjtiWeBz/ycIPohJ227zjH4uuwOVd8/lQshI0UnOsDjkObr+8Gp74hjQkkiR7yZs8WQB+67
 q//3ZulYC1pvIm7tWBHhx05gJc7h3tx5DwJ9JPagrNX0hT+JEMxhc59FT+SMEbRicmqvNQs
 2G1bPyQOCIJpWGfyrH+RQ/vP0eohZm9OmR4Xt6phiId9IBwLI1btXKJ31V6iuChYtJZdkLu
 s1LOi+hHEwTMKaQe8F8wqmpWHScHHeTxS4p+E9P6TyhPndA+UdYPcx+Y+cXQjCJCptw6Cf4
 Hz8EPZ04x4vF1+QxRMJfkg=
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

