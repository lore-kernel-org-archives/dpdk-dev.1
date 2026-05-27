Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B02CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:03:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E57A406B4;
	Wed, 27 May 2026 15:03:32 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 659DB40673;
 Wed, 27 May 2026 15:03:29 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887006tfb8a35ef
X-QQ-Originating-IP: cWvUm2pfQaGLaiqN6e2vgZJLjMtfeDj4c7UQfwfd+XM=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2741021265129640467
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 06/21] net/txgbe: fix link status check condition
Date: Wed, 27 May 2026 21:02:06 +0800
Message-Id: <20260527130222.24348-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M83iEva+1QDBMc0d6gBK3mHiM5brOX8TQIj7XM52ELibrSidv+t6tWU9
 NqbgxNNimCYbNsXcEpM2mD5oYBeU2swigjgbX1UnbXtn9gEx9actMu3FpOeh/NPL0QSkTlk
 ZRWKguaTNSY9C/0Db54+MwRaKONsidS/BRKS8dxB86TDdkZY53z1Z0p5W+F8UP3ZPRKxO3s
 JKLCl/KFz4s9/HXAQvoePY2rYz9jKhcCbjAQP30lHQo87AnI9WQHZpReAWqA7aA95obrwtV
 wQLEPdUUE8d53Xl4Tpj+A83iSrxIvhUuoj8cg7Ln+8zYTS+0+PGejTCc+W+TviyEZ4a+70R
 AJtY58QswQaWRPvU3nql6D0cahHPd3lIak/Dawv+WmmTLcE7TZUSB8TTcVMJ1tcZx6LKTzB
 hmE3gx63Y5/NdqjsWtoMBGhc/Uj/Cqz1RG0fyy1UmdEMsHdUPjtcpw4K9CwdO+zoG9Sk+b4
 wSAB2LICKGpaXz9ZvpH/ZvPtSAcFb9LgsEkz+5iMZeb78HCyrHsyYiPHL5eSe7kShzkdbKq
 9YVO/96Sc+SEF8EzPuIhsg1HgVZw1xbhIrYqp6wVHNiEfNW1Vem8F3WX6YAHZ0VCRszj+8r
 QUdhpOtMa+u7bNOOB0sxqdxpjzZ2V3z92k05lQrFrSWjcViL5lM8YdR1aFpBx478wwJzD7c
 v2qdd2AwnYFCGoLxzfJujX+dRLkfRVDJL5T1DtCbaNCa+SArIrSxJWn9i4Q9pn8EqJQH1pc
 VjgfDEBWrEq1gPJNKLWTCMIG/lAcgOuovl7y+EQRG2fIaYh4WCW0dYA/Uef+P7z+maXHAeu
 dB/YKgcIPHxRC/836Uz347quZVfuwmKZOnhH2gFtjcPUfHxO2P/qSuWM7cfj+i4FoBhErwZ
 nQq7yRMS1vgdW97xJssPfkw+SKu4C30g81My85rW0IPN8ogbru4/PqMXzV3InwGVBMdzVks
 u6ir7HfIFBWlvoreeDDrHHgJl/G9SH2aFYM7be2Vz/sY+eF/1UG0vwKFZzSWEbLpQo9wySo
 1oCZ+WXh6PIj0N/r4cq5+sowoFYjZhQBUaASHg8ADIcw1CgIK5HDthMYRiwnQ=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

