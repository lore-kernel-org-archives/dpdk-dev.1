Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26325FF886F
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 09:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 470DB40431;
	Thu, 30 Apr 2026 11:38:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E2A7840395
 for <dev@dpdk.org>; Thu, 30 Apr 2026 11:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777541930; x=1809077930;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9Hy6ceERmf3+ldyX2MNSZ9gOuhAUZIvvmG7nFr6j0ZQ=;
 b=Xu9HNMT1OySltB0O8hTfFAPIASZL8OrfIh2cnhR9C438Hy9fnRhr7dJh
 Y62rjlQLJsjJfD1SQU0mV9n2eS9mZLvyMJcumBBQSHFLdLm58DXWsWfd/
 vN2ASTqcFuGRJig5gbH4tM1jxYk8a1pmBXZ7WCRQgVfPuUcwN9VXLK7dI
 oEaW3nvvYyGuv+C9ifMvnrgOaCtnF34/deYfBUwmHjyRuxMBPUQgfhsAV
 9s3HAE4nlot6YDd9mn0pJvYLP1hlB5tK8DKmrCa5jzg49SMEXMzrUuKrh
 D+yPT1zsWLrYEvNN5ht+ykcz0hAmk87aVOg2LDr3BIuNLUTt8QuLsu6tx w==;
X-CSE-ConnectionGUID: 7xB6ITxsTgidJnxT0nTXQA==
X-CSE-MsgGUID: 7LHTTXlHTry4+gl581kGtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89863528"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89863528"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 02:38:49 -0700
X-CSE-ConnectionGUID: YPSbyQ4tRmm5uYdy+1PXxQ==
X-CSE-MsgGUID: 93oIIaqDQ3WI5FGrFGn+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="238855123"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 30 Apr 2026 02:38:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v1 1/1] app/testpmd: allow appending to flow dump file
Date: Thu, 30 Apr 2026 10:38:46 +0100
Message-ID: <711f81af5087b82e7ebc27e6ef69e9c497ad8c63.1777541917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When dumping flows into a file, allow appending to file rather than erasing
it and creating a new one.

Also, to disambiguate between "mode" in terms of appending, and "mode" in
terms of one vs. all flows, rename `mode` variable.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test-pmd/cmdline_flow.c | 45 ++++++++++++++++++++++++++++++++-----
 app/test-pmd/config.c       |  4 ++--
 app/test-pmd/testpmd.h      |  2 +-
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index ebc036b14b..67f200f2e3 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -267,7 +267,10 @@ enum index {
 	DUMP_ALL,
 	DUMP_ONE,
 	DUMP_IS_USER_ID,
+	DUMP_FILE_PATH,
 
+	DUMP_WRITE,
+	DUMP_APPEND,
 	/* Configure arguments */
 	CONFIG_QUEUES_NUMBER,
 	CONFIG_QUEUES_SIZE,
@@ -1263,8 +1266,9 @@ struct buffer {
 		} destroy; /**< Destroy arguments. */
 		struct {
 			char file[128];
-			bool mode;
+			bool dump_all;
 			uint64_t rule;
+			bool append_to_file;
 			bool is_user_id;
 		} dump; /**< Dump arguments. */
 		struct {
@@ -1550,8 +1554,7 @@ static const enum index next_destroy_attr[] = {
 };
 
 static const enum index next_dump_attr[] = {
-	COMMON_FILE_PATH,
-	END,
+	DUMP_FILE_PATH,
 	ZERO,
 };
 
@@ -4296,6 +4299,27 @@ static const struct token token_list[] = {
 		.next = NEXT(next_dump_subcmd),
 		.call = parse_dump,
 	},
+	[DUMP_FILE_PATH] = {
+		.name = "{file path}",
+		.type = "STRING",
+		.help = "file path",
+		.next = NEXT(NEXT_ENTRY(DUMP_WRITE, DUMP_APPEND, END)),
+		.args = ARGS(ARGS_ENTRY(struct buffer, args.dump.file)),
+		.call = parse_string0,
+		.comp = comp_none,
+	},
+	[DUMP_WRITE] = {
+		.name = "write",
+		.help = "open file in write mode (default)",
+		.next = NEXT(NEXT_ENTRY(END)),
+		.call = parse_dump,
+	},
+	[DUMP_APPEND] = {
+		.name = "append",
+		.help = "open file in append mode",
+		.next = NEXT(NEXT_ENTRY(END)),
+		.call = parse_dump,
+	},
 	/* Query arguments. */
 	[QUERY_ACTION] = {
 		.name = "{action}",
@@ -10733,7 +10757,9 @@ parse_dump(struct context *ctx, const struct token *token,
 	switch (ctx->curr) {
 	case DUMP_ALL:
 	case DUMP_ONE:
-		out->args.dump.mode = (ctx->curr == DUMP_ALL) ? true : false;
+		out->args.dump.dump_all = (ctx->curr == DUMP_ALL) ? true : false;
+		/* don't append to file by default */
+		out->args.dump.append_to_file = false;
 		out->command = ctx->curr;
 		ctx->objdata = 0;
 		ctx->object = out;
@@ -10742,6 +10768,12 @@ parse_dump(struct context *ctx, const struct token *token,
 	case DUMP_IS_USER_ID:
 		out->args.dump.is_user_id = true;
 		return len;
+	case DUMP_WRITE:
+		out->args.dump.append_to_file = false;
+		return len;
+	case DUMP_APPEND:
+		out->args.dump.append_to_file = true;
+		return len;
 	default:
 		return -1;
 	}
@@ -13579,9 +13611,10 @@ cmd_flow_parsed(const struct buffer *in)
 		break;
 	case DUMP_ONE:
 	case DUMP_ALL:
-		port_flow_dump(in->port, in->args.dump.mode,
+		port_flow_dump(in->port, in->args.dump.dump_all,
 				in->args.dump.rule, in->args.dump.file,
-				in->args.dump.is_user_id);
+				in->args.dump.is_user_id,
+				in->args.dump.append_to_file);
 		break;
 	case QUERY:
 		port_flow_query(in->port, in->args.query.rule,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 32c885de0b..c950793aaf 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -4162,7 +4162,7 @@ port_flow_flush(portid_t port_id)
 /** Dump flow rules. */
 int
 port_flow_dump(portid_t port_id, bool dump_all, uint64_t rule_id,
-		const char *file_name, bool is_user_id)
+		const char *file_name, bool is_user_id, bool append_to_file)
 {
 	int ret = 0;
 	FILE *file = stdout;
@@ -4198,7 +4198,7 @@ port_flow_dump(portid_t port_id, bool dump_all, uint64_t rule_id,
 	}
 
 	if (file_name && strlen(file_name)) {
-		file = fopen(file_name, "w");
+		file = fopen(file_name, append_to_file ? "a" : "w");
 		if (!file) {
 			fprintf(stderr, "Failed to create file %s: %s\n",
 				file_name, strerror(errno));
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 9b60ebd7fc..1a54535470 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1085,7 +1085,7 @@ int port_flow_update(portid_t port_id, uint32_t rule,
 int port_flow_flush(portid_t port_id);
 int port_flow_dump(portid_t port_id, bool dump_all,
 			uint64_t rule, const char *file_name,
-			bool is_user_id);
+			bool is_user_id, bool file_mode);
 int port_flow_query(portid_t port_id, uint64_t rule,
 		    const struct rte_flow_action *action, bool is_user_id);
 void port_flow_list(portid_t port_id, uint32_t n, const uint32_t *group);
-- 
2.47.3

