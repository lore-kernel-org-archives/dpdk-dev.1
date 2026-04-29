Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E097AFF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54E1C40695;
	Wed, 29 Apr 2026 12:26:27 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 808A940678;
 Wed, 29 Apr 2026 12:26:23 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458381t558bf482
X-QQ-Originating-IP: j8UMvX5LmTvAdC/5qnYJqpCliJqBcxkR9OD226nI0I4=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3605785546650690781
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 06/20] net/txgbe: fix link status check condition
Date: Wed, 29 Apr 2026 18:25:00 +0800
Message-Id: <20260429102515.58880-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MBREESna/OUi5zW4y2qtxFtWGIeH6f/eYW660k1IRymH3Vy01DjotYOh
 Woi3HcwDoQpJH5qVMtJ2aM7U9m0TXsAksXJhfK4bobnuHexJo6ABOGAL0gFmBeHR2s6r7A5
 VYgWNqgddASAFzlfxFV32WOanWJ6ueACzzseoiwx/bZ/SOIpo7enZOSmw93mUPtsm8VyoLC
 Ji4lz7BerJkRhTmGPWfLEEH1t60WyLzYl8Eu1GIHywPv3pW8KjZQ9AwFhD+YzWp7R/z7/h3
 HtMUDbE/H5JAzVPFBFkM29y/pkhU6X+RWd96iA0ZAjI0QTa/Mp8O3t+2Eg91AJ8G0JxCiD9
 33KQ2ZQ2GHOc8V18kSaoGiJaz/N3EWmeSbGbCBUioyB3Fs82rZdxC1/9mqOaXbyfl3xsdCw
 jbS1hfEuDH8XpRMrNS4dlp55oXYAe7ZUcVkt+no6kIXQofPpelHqZWzLWnx3KBFUI+mRxce
 a4yqETWzNAIJJn19lo0rKCVaKuX3qlMxqYwRWgWzJDvyjE2B3qNIaGyx0SgeH3PV1PdBD5t
 Ue55gOTiimpuVXBsRIHVjj16hWbt8CNODUdtGusjVzgvE3O5qTaTicn6zAJZkHNxkWRYZqd
 4Ic1UnaGf0TAkxeDvnJ0DuuCfI87DNiwfQ46aM5kd/jvW/f9CI76f8hom9811RlmuLV9HMu
 htXLN/ix1ddg+Mb5Hq1Q19ID5u5iVkp04eSiBLF02eSX5M5a5hSJphEDc3+XF6vYwClPuAF
 qNP1trqB1zsaqBWcGr4JB/R3DPUS17+pv4hB+OBdwsxRAoovgExQZOh8BOFm+LKRM16Tr+d
 /hPD4ia+1vGtW6zwE0NtwK/6+xwk1I1aOKwNrt62jO5cj9nkurztyCM7B7T3QxReWtE0Jf8
 8LQ4pzPgX3YVLMFw1ltAXvZvTSiOR6/CrlmpJMLA5/4L2Z4INNMFUGxrY+hvqDlpL9Qqawh
 ogRdpBl8ltbzFPfMJ+h7KzMLlCDdlsEAdlLdyX0ORSZzCJajjE8RZAXg3JwVSm29MVEDu0K
 uHihTt3fvq+H3Hs0yTxWKGkZAy7+8ZUT4TV+B8w2w2x52hppF60rjH/OAcCbKSGoiKWpVtq
 A==
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

