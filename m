Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84D7CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9960940673;
	Mon, 22 Jun 2026 13:11:51 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id CD15240662;
 Mon, 22 Jun 2026 13:11:47 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126705t12357fa1
X-QQ-Originating-IP: SFxHxeJwt7xfqMBI+ZJaF6FitsXMmBt5pkQdziLtn00=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8063868802072560431
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 06/21] net/txgbe: fix link status check condition
Date: Mon, 22 Jun 2026 19:10:54 +0800
Message-Id: <20260622111111.21024-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M3cDnkiEq4gxriRGlsfSpvBzb9pAOOgF/AI2HXpgYemcgXDsjv0fYxS6
 cAkTZxU+IRoA2TiPH8KkmvBY3pcWGz/MkEyHj6Y/4Y6GcgTS+J8ViNQsUqJZKx6CVa3MAIo
 CfAlAjnQhdzCMRZxL4qszSZ4QKfZINoOkYm7rioqGFwlp59kMZR/d5a4lPJbOXk4ncxtqEy
 n6H5EkBagBWv8xC/QTuvsfNEBrx1p/lH0ALHwWRp9GMiHhbxuUSk55sI45Oe9C3TAksyyPZ
 liuGAUwuihMPMk2HsbTtI1duahQq6G34PB74L1hX+bXsDBH1MRRayqc65uwu1L0K0u0O3h4
 LOPlwFBr0jOWhbDM+4wwA6b/wpw5rfHEVffF0gqk54xmKhqQO6hwmRtuE1D/fuxdb1aa3D+
 D3ummCF19FcquP4FD5U6/fP8kqSrcLZ9xtWgR+n36COQf+WJkBWttGB4ETb3TziksMVny9X
 i/lJ/t8CM7STgLOrPlsieY7kFP9zlasmXak8Ke3Wn/zmDxIbJ8VkxqmWwiX2uZfOwCcUe/u
 1Dnx/LlTL4i+MFs5x8kr5J1UKAF3XrN6GJqT4k9GTHxGek+dBmXxr5AiJUEFBy+3K0o6wcU
 AVGUszQrwT+bS8y7u0GubavBU0TFg50EA4pjybEeRpAmJjEm4kgsOg/9RCMV7K7qWEoEGAG
 +19iOB7ndV7G1nOe7zVf47SFEfEJxmCkue+0DmV7a750KUgbkah4nH9iMKfXNpPr1HDPybN
 UK5km91BDDSKnXXKH0QwN9VCveC4A+5/MpN6CjEMOLQREljSxQwQH3Pm8r4/QkOjJVSHHPy
 3tTmZJsKzJR90/gjEpNyUn/xWsWh/FSt2Zkz82DPKtvNQHhwL26RBa66tmMryz8PsBDGJlu
 QbI+toQmBPFpw95aOCP1swp4Aw6xBbKhxWPvS5ZfO9oU4FDAtYt4E9krsHdsCniZZv/iIQE
 xfIT9kyZheqC3UGUks7prEkTuLal4RPPvIZMLtNAuv05MVoMUjHLaQ7VIlvbPOX1eRKY7zL
 LVg+wKTSZu0lhlcfdWkgqsv0uqzQI/KTXfps1awPv3uDbQE6HVDCJMkrQ0QtGJPqP6Md6Nl
 w==
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

