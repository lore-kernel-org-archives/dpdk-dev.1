Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EB2CD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EECF040DDB;
	Wed, 17 Jun 2026 10:14:57 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 01F1C40DD8;
 Wed, 17 Jun 2026 10:14:54 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684092t72577d39
X-QQ-Originating-IP: CRZpX7eictAxramUbxFoNKXKpavZxug8DYRxzJMw5yQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14268440446480912049
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 06/21] net/txgbe: fix link status check condition
Date: Wed, 17 Jun 2026 16:12:53 +0800
Message-Id: <20260617081309.19124-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nu7meyJZV74IlJHvKV7fU9CK/HdHsREBvGmGymvMSXpljWB7jN68Om+x
 zDOK0Rb2dEU9AkxdcK+QbE3+uO+97mDcGt9U6eQB7qM7WCi6ysC8Ybq0GzeUgbHha6EBfBL
 xvnepfIL05fB26D6UVywvLHO0EyYgBiEBbShtiV+n6hQZT91jiqft4L3pbt0Oj31FdyTDwc
 O9lU5rGQWsgRY5YxLnukd14Zkm+NcgCAMz963BhO+B2fccqZWMKB5sH+kJBTfJOhIs2CLMs
 XV4gr2hJppXOFeugoykbJmUqbd2+c84BcWqHP43pdeC33W1ThOzo2iTNvsrvb61j5li3tDy
 sJ4qiZ0RQ4nooa0D4qf5PoLTuZL8kElIbwuxsZvgnKxqqusg0ttF6tLi9odbmuCOrqBgkY+
 9tZvq/low6CdvSMtRktMtVWXf8Vz34IJVG/caI6z/xzALeoVT7B7yeLRPkIjHW3cWkp+cOp
 TjfUQJlzwcr4uIKRtDivdvGZPKSa9YSJyc4b3EWqbUrr74ubJj/MNVh70bVdknQY3LlOu5C
 xR/kyVTLAtlX2Z3+ThTra16a9v3laRS6EG7ziYcH8i+fMndTiWJ0gap1NS00RkdU2bK8Kbx
 lM7GFN3gOIrCDq9TLpo5vYMYu+jgUL7u3EmlFaR84w+nGVZ4ktuKL4Naea0uWT3q8pNdUk9
 cx8wohLWc7zFnSV68UvjirO15X/0yTZqew34jMRiovZrbvxvXfGAkg+kiAxEbne1g9Bivn9
 FnjjtKkfdWAYVmOPS/7ZIRnRyXrnt7EMn6bI/7EGVOA1RtuN2AH/Ife4QLEbYuKsdP5WhYD
 JQNaebNTq0h3dZxSsgRn6YLG588efpf9cH7B0lTnydNHRgnj61fFJ2ReLfphwXNs7CmwV8D
 LOEbdSjlDcX5cG/2rAfPsMuSZslcTA+C9zj7CuIa0fdwfwAGuhQDaVYwe7ZOsH1ZYThEAhj
 APdWz3qZrjsHP+1bxiuaq9KQu9QrOGV8/UthyY5N4QterNJWgGhr2HvSQoM/4g2DO39RUVy
 PsvFTMUZTXlqNG8u16/DZU775xAgpi9cxGlNstaPPw8iy3oCWRD10/1RcYeHw=
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

