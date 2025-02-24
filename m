Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C35BC021BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:25:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E78554279C;
	Mon, 24 Feb 2025 17:25:05 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 06FBA410D5
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:24:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9E41D203CDE1; Mon, 24 Feb 2025 08:24:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E41D203CDE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740414289;
 bh=hCkAEA7h4xaSTnes7Oz9OZKRVEMRJI2e+m8zpkWtGns=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gEBIpHhb5H/UbGr1VwDMT2SfbP0qk8yRaqpUXqLddegVwYYUA95jh83fYnkIA+Cys
 jd29tREX+gUVC7SIEWgfyfegYR+nZ+37c3QMZG5wzCcl+2AIB4U/T7HcTiITYmGV4s
 8tqjiWvyj++Xb2cVJQFYpxE1ZGr88ozGsQDX0EOI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v6 05/10] test-pmd: avoid undefined behavior
Date: Mon, 24 Feb 2025 08:24:20 -0800
Message-Id: <1740414265-12217-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
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
 app/test-pmd/cmdline.c | 12 ++++++++----
 app/test-pmd/testpmd.h |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 2afcf916c0..d0b47eac8f 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -8980,6 +8980,14 @@ dump_socket_mem(FILE *f)
 	last_total = total;
 }
 
+#ifdef RTE_EXEC_ENV_WINDOWS
+int
+rte_trace_save(void)
+{
+	return TEST_SKIPPED;
+}
+#endif
+
 static void cmd_dump_parsed(void *parsed_result,
 			    __rte_unused struct cmdline *cl,
 			    __rte_unused void *data)
@@ -9002,10 +9010,8 @@ static void cmd_dump_parsed(void *parsed_result,
 		rte_devargs_dump(stdout);
 	else if (!strcmp(res->dump, "dump_lcores"))
 		rte_lcore_dump(stdout);
-#ifndef RTE_EXEC_ENV_WINDOWS
 	else if (!strcmp(res->dump, "dump_trace"))
 		rte_trace_save();
-#endif
 	else if (!strcmp(res->dump, "dump_log_types"))
 		rte_log_dump(stdout);
 }
@@ -9020,9 +9026,7 @@ static cmdline_parse_token_string_t cmd_dump_dump =
 		"dump_mempool#"
 		"dump_devargs#"
 		"dump_lcores#"
-#ifndef RTE_EXEC_ENV_WINDOWS
 		"dump_trace#"
-#endif
 		"dump_log_types");
 
 static cmdline_parse_inst_t cmd_dump = {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index a933fb433a..de8e8f8dca 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -84,6 +84,8 @@ extern volatile uint8_t f_quit;
 /* Maximum number of pools supported per Rx queue */
 #define MAX_MEMPOOL 8
 
+#define TEST_SKIPPED 77
+
 typedef uint32_t lcoreid_t;
 typedef uint16_t portid_t;
 typedef uint16_t queueid_t;
-- 
2.48.1.vfs.0.0

