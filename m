Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB070C021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 19:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89EC5427C6;
	Fri, 21 Feb 2025 20:53:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3D6DC42792
 for <dev@dpdk.org>; Fri, 21 Feb 2025 20:52:50 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D231E2053686; Fri, 21 Feb 2025 11:52:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D231E2053686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740167568;
 bh=hCkAEA7h4xaSTnes7Oz9OZKRVEMRJI2e+m8zpkWtGns=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FUl3rPTgg7KHcJOst5w+7E9Ufk3urgGl0zXxxREQpwPnUXpaX32UwDNoq9ky20bh8
 xWojClkesydVFFkF/L1AZel/jUr+P+kxU91RuCubCeuPGOmWVh7qoBo1Xv3GZvWiq0
 oKo2ke0jyt9HH1FnKd4vyo/nmWuCu5SHgdjk5Vt4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v5 05/10] test-pmd: avoid undefined behavior
Date: Fri, 21 Feb 2025 11:52:38 -0800
Message-Id: <1740167563-12332-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740167563-12332-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740167563-12332-1-git-send-email-andremue@linux.microsoft.com>
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

