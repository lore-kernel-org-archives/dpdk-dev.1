Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC6CD98E6
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0843840E12;
	Wed, 17 Jun 2026 05:34:42 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id BDC1540DD7;
 Wed, 17 Jun 2026 05:34:37 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667274tad3b4acc
X-QQ-Originating-IP: 6dCi1eHVNe+TeFErtwjcWapzdmEsJ4209dFYoTdAyMI=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:34:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14057107978233876447
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 06/21] net/txgbe: fix link status check condition
Date: Wed, 17 Jun 2026 11:33:44 +0800
Message-Id: <20260617033400.376-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NIGuNFWusAfR7+mx+sfAE/1ztZG2SEqkFSNEk3Tz/CuJJ7lJr7VmHJ8V
 PpwsjxI8poJtvS4zGquleyaL5yZYVJBQEBjtccF49KtgIlGI3RSvzOAMHPgUtl3DBL/t2wF
 cpkE78F2vyGCDJ0k02sl3feuU5h0tXUl+Fhx+2BcSpcnPSEvKrcc9SZQ2YtIGMaaHWamAxK
 0n9wqg7Mtk+NblKMf7WbQ0LNzEpZW8yJ7EeTgZhc8+i7JqxX4S3IUBc6UDRrFER4a/YsAsT
 8shbO7U1sZUy712F3baqKNKVENTHm9JjCfnikYPN2/FekWnx50Z2d4FlM81zUVwo1kQfIDP
 8FhkLQqUy928zcd3v5AjGv7xFvfKb+0cCKWFEymWlokPArJHK7WoF5TdX5rVogVzKL34aJl
 3EWvZ2LaZHd14b985KtQ7xXBQitA2F0OdtpTKRZQ5ahINZfYMe5WkCsTK9/28oE21QojqMK
 qYcOd9i8l6sYreu6568oXJ7zXHzr8y+6eHPfg+g0EYTebvSu5PvlqJxidAotlDU2PyCU4mp
 rU9wERtoFtHCbrp+THMTXgAF+cBGNKdjdmn/lkUixVb0ZVLLFXcaePVdv7A85efkfbUpB/w
 tZcXSYerwMcbbB3QFR+F0n7sxeiXwda3z/0NSvz5LfBUjnechHdfQLLwcbtdyh2Th+qjVGw
 h2p2FuCtRuL94ccsUlQwXfhMPmE7Iid+FVgszGrHmydY0v1DFFAstIfMaF3qRVOeLHZ32rh
 oH7qVDG8sZiRUbDHs6GSkMhMzdsfqnWj30a+/6si4bkKu2ouPy0y36Or9FsM+MxBDqTyUC+
 6j9xrw1iER1DTDxKDXxk9DPwip46BlLa4LOi9l5/KHEHRdXkGGYY6d32z2IPPBlJYlo77sm
 HCNPg2Y78LKWC2YwgMOt46aPE3Gce2FX1Hk12LXSCnCvH9Wl9QskqfUFsdt7mGj4fLXOx+t
 Jvtd5xjIMXiYt8e1MO8xUjb6FiMXmIXtCEX4tAM78p2LLezXWvO4xfJS/mjv8SONZTX/R2T
 /UQQr5VxjN5WdsP8MM6rLplthkvyieDWPNxMb78IAPn8uQvgCgGcHm7wZBy0A=
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

