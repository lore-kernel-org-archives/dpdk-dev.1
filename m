Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2411C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E29A40678;
	Mon, 21 Jul 2025 17:16:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 39D6640668
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753111012; x=1784647012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8p3BeQvTpRHohDUKuKO6YSZiBhUxPhWz1H758IVOzg0=;
 b=D1uSLjj7pcaJ4eGrnWsdCcyr3C6XDzdTqfiiZtPB2472jT0N5pcOYy24
 sK2nKpO7cNlsRI6BpXOAXbua1G39l5rZRtRBlEpCYUDREO13QCl0Vkavg
 YtL5/vsvoAShf9t60TVJ+q7T4xz/wHrc5UnUT64/qSKsU6RR5Mf/ak7Ex
 6mxNzVEzGRlaEJev7TPl1QKS/ae+EqVOmR6iJJuX5/8ddV5dh60MQoIfN
 fKgsEzwXab8MpfRPJtO2qsGSya9MKwRt9Dy21mBDL/mNzrvPhwFLPhhAD
 mBQcabXJ6SD40UmH3hlZQKgdcCW6esGTGNYXWx98c+tQfm8yhhXyMo61s g==;
X-CSE-ConnectionGUID: bb8NsEBkTXiiGOV+c+DT3A==
X-CSE-MsgGUID: WzHTm7YuR9GIW8axO73mPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="42949379"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="42949379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 08:16:51 -0700
X-CSE-ConnectionGUID: 9UVUfrh/RSWX8L94pcYDCA==
X-CSE-MsgGUID: GYZVXy04RTG76w7+41bTjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; d="scan'208";a="182575401"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2025 08:16:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v5 2/9] argparse: export function to print help text for object
Date: Mon, 21 Jul 2025 16:16:35 +0100
Message-ID: <20250721151643.2739725-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250721151643.2739725-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250721151643.2739725-1-bruce.richardson@intel.com>
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

Make the function to print out the help text for an argparse object a
public function, which takes as a new parameter the file stream on which
to print. This can be used in future to allow application to extend
their own help information.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/argparse/rte_argparse.c | 43 +++++++++++++++++++------------------
 lib/argparse/rte_argparse.h | 14 ++++++++++++
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 331f05f01d..d3b32c6357 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -716,23 +716,23 @@ calc_help_align(const struct rte_argparse *obj)
 }
 
 static void
-show_oneline_help(const struct rte_argparse_arg *arg, uint32_t width)
+show_oneline_help(FILE *stream, const struct rte_argparse_arg *arg, uint32_t width)
 {
 	uint32_t len = 0;
 	uint32_t i;
 
 	if (arg->name_short != NULL)
-		len = printf(" %s,", arg->name_short);
-	len += printf(" %s", arg->name_long);
+		len = fprintf(stream, " %s,", arg->name_short);
+	len += fprintf(stream, " %s", arg->name_long);
 
 	for (i = len; i < width; i++)
-		printf(" ");
+		fprintf(stream, " ");
 
-	printf("%s\n", arg->help);
+	fprintf(stream, "%s\n", arg->help);
 }
 
 static void
-show_args_pos_help(const struct rte_argparse *obj, uint32_t align)
+show_args_pos_help(FILE *stream, const struct rte_argparse *obj, uint32_t align)
 {
 	uint32_t position_count = calc_position_count(obj);
 	const struct rte_argparse_arg *arg;
@@ -741,19 +741,19 @@ show_args_pos_help(const struct rte_argparse *obj, uint32_t align)
 	if (position_count == 0)
 		return;
 
-	printf("\npositional arguments:\n");
+	fprintf(stream, "\npositional arguments:\n");
 	for (i = 0; /* NULL */; i++) {
 		arg = &obj->args[i];
 		if (arg->name_long == NULL)
 			break;
 		if (!is_arg_positional(arg))
 			continue;
-		show_oneline_help(arg, align);
+		show_oneline_help(stream, arg, align);
 	}
 }
 
 static void
-show_args_opt_help(const struct rte_argparse *obj, uint32_t align)
+show_args_opt_help(FILE *stream, const struct rte_argparse *obj, uint32_t align)
 {
 	static const struct rte_argparse_arg help = {
 		.name_long = "--help",
@@ -763,34 +763,35 @@ show_args_opt_help(const struct rte_argparse *obj, uint32_t align)
 	const struct rte_argparse_arg *arg;
 	uint32_t i;
 
-	printf("\noptions:\n");
-	show_oneline_help(&help, align);
+	fprintf(stream, "\noptions:\n");
+	show_oneline_help(stream, &help, align);
 	for (i = 0; /* NULL */; i++) {
 		arg = &obj->args[i];
 		if (arg->name_long == NULL)
 			break;
 		if (!is_arg_optional(arg))
 			continue;
-		show_oneline_help(arg, align);
+		show_oneline_help(stream, arg, align);
 	}
 }
 
-static void
-show_args_help(const struct rte_argparse *obj)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_print_help, 25.07)
+void
+rte_argparse_print_help(FILE *stream, const struct rte_argparse *obj)
 {
 	uint32_t align = calc_help_align(obj);
 
-	printf("usage: %s %s\n", obj->prog_name, obj->usage);
+	fprintf(stream, "usage: %s %s\n", obj->prog_name, obj->usage);
 	if (obj->descriptor != NULL)
-		printf("\ndescriptor: %s\n", obj->descriptor);
+		fprintf(stream, "\ndescriptor: %s\n", obj->descriptor);
 
-	show_args_pos_help(obj, align);
-	show_args_opt_help(obj, align);
+	show_args_pos_help(stream, obj, align);
+	show_args_opt_help(stream, obj, align);
 
 	if (obj->epilog != NULL)
-		printf("\n%s\n", obj->epilog);
+		fprintf(stream, "\n%s\n", obj->epilog);
 	else
-		printf("\n");
+		fprintf(stream, "\n");
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse, 24.03)
@@ -820,7 +821,7 @@ rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv)
 		goto error;
 
 	if (show_help) {
-		show_args_help(obj);
+		rte_argparse_print_help(stdout, obj);
 		exit(0);
 	}
 
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 52bef34363..baf278f6b9 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -189,6 +189,20 @@ struct rte_argparse {
 __rte_experimental
 int rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Output the help text information for the given argparse object.
+ *
+ * @param stream
+ *   Output file handle, e.g. stdout, stderr, on which to print the help text.
+ * @param obj
+ *   Parser object.
+ */
+__rte_experimental
+void rte_argparse_print_help(FILE *stream, const struct rte_argparse *obj);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
-- 
2.48.1

