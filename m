Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD8C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5247840E72;
	Tue, 11 Feb 2025 23:02:48 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BD6464027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:02:41 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E9B8D210D0E8; Tue, 11 Feb 2025 14:02:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9B8D210D0E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739311360;
 bh=bJPwYx3kJnQUsOBtCze7A+Usccnj5BRz32AZdIxFE6o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DW0kHR64fDicRRy/2SI85wU4eoyIYHXC8LERMOf8WWHiLfNrOwVkMmssXAWMnGQyJ
 o+Z7uMkYcX1xdXcNA9vjjtIbvmKLghMwidqLs8VlXw+a/B9jEH6QdmFcpyrGBo9ark
 JwiNJOMbgQl0+LEYmsqtrxU99UGW71QTQT0q56OA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Aman Singh <aman.deep.singh@intel.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 05/10] test-pmd: avoid undefined behavior
Date: Tue, 11 Feb 2025 14:02:01 -0800
Message-Id: <1739311325-14425-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
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

Compiling with MSVC results in warnings like below:

app/test-pmd/cmdline.c(9023): warning C5101: use of preprocessor
    directive in function-like macro argument list is undefined behavior

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test-pmd/cmdline.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 2afcf916c0..4f0b0340c8 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -9011,6 +9011,18 @@ static void cmd_dump_parsed(void *parsed_result,
 }
 
 static cmdline_parse_token_string_t cmd_dump_dump =
+#ifdef RTE_EXEC_ENV_WINDOWS
+	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
+		"dump_physmem#"
+		"dump_memzone#"
+		"dump_socket_mem#"
+		"dump_struct_sizes#"
+		"dump_ring#"
+		"dump_mempool#"
+		"dump_devargs#"
+		"dump_lcores#"
+		"dump_log_types");
+#else
 	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
 		"dump_physmem#"
 		"dump_memzone#"
@@ -9020,10 +9032,9 @@ static cmdline_parse_token_string_t cmd_dump_dump =
 		"dump_mempool#"
 		"dump_devargs#"
 		"dump_lcores#"
-#ifndef RTE_EXEC_ENV_WINDOWS
 		"dump_trace#"
-#endif
 		"dump_log_types");
+#endif
 
 static cmdline_parse_inst_t cmd_dump = {
 	.f = cmd_dump_parsed,  /* function to call */
-- 
2.47.2.vfs.0.1

