Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9C4C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:33:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E607240A76;
	Tue, 18 Feb 2025 17:32:28 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4CF2440666
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:32:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7D30720376EB; Tue, 18 Feb 2025 08:32:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D30720376EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739896334;
 bh=G0dkf1d7cFFXXRI0D6fp/4x/6xdg4Tu7/5qkGRBE9cs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tDeKv1TVYn2CwVIUActv17K4QZpPRqDN9PcavJUCeSIazyczXsT2y8uBy2gbBTEF4
 g5YBq62e6kuCHeXn3AJpkLAUdjEISOXRqUG0/g+GDNdJTAo8GCIoZu/E8YQiG1QoxF
 fq78aq8SM8tLH9fsQUkojlOkzwDVmtYCsGfUysMQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 05/10] test-pmd: avoid undefined behavior
Date: Tue, 18 Feb 2025 08:32:04 -0800
Message-Id: <1739896329-1946-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
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
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
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
2.48.1.vfs.0.0

