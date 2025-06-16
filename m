Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A70C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 10:50:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8C7240667;
	Mon, 16 Jun 2025 12:50:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9785C40430
 for <dev@dpdk.org>; Mon, 16 Jun 2025 12:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750071003; x=1781607003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3468KybsMQaksh2KP6/eHb0eNMYI6JGlic9ZHbnxBTQ=;
 b=hjc89UASSmXEQTPXpOTbZXS4ZWSHJv3uI4LFj1BpXEHZPlztBoIZh5Nz
 zab7JuoPGay9fMgoay/tvqHSDB1bbdEz9iBrc+03In20+NQQ1LPOldnap
 8fGxI/XdwWOl1VH8W2RBbEALMOG5HBYOWIx6pbp40DDDnEn0yIx8b0cc/
 7ELIXeXu2aWhWS3aN66AtUVpyNqFHRGzBIdQ9DCmNf7mfI8YDCMn4C5ad
 vIvZMuNgStwvgVxBjtR+3p3A2ptnEbxd7VLykQxrKtyBwKZI2w806Vy5M
 jAgQFuLyoxdQWUahokOzcUkZ3dTrHKWUclXfQOoxjIhlFIErqnQBTBk0l g==;
X-CSE-ConnectionGUID: nfzpkcCCRx+UciL4CycTgg==
X-CSE-MsgGUID: fkquNhEfQL2KJDu0a/za1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="54828167"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="54828167"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 03:50:02 -0700
X-CSE-ConnectionGUID: Wj6CGwx6TRqA/HBYXfywqw==
X-CSE-MsgGUID: rqPB4bJrQa6x+ntQSpZAaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="148281540"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa006.fm.intel.com with ESMTP; 16 Jun 2025 03:50:01 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 2/3] argparse: mark parameter struct as const
Date: Mon, 16 Jun 2025 11:49:42 +0100
Message-ID: <20250616104944.3425929-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250616104944.3425929-1-bruce.richardson@intel.com>
References: <20250616104944.3425929-1-bruce.richardson@intel.com>
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

Now that argparse no longer modifies the parameters passed in by the
user, mark them as explicitly "const" to provide that guarantee to the
user.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/argparse/rte_argparse.c | 40 ++++++++++++++++++-------------------
 lib/argparse/rte_argparse.h |  2 +-
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 431d0f9b84..331f05f01d 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -323,10 +323,10 @@ calc_position_count(const struct rte_argparse *obj)
 	return count;
 }
 
-static struct rte_argparse_arg *
-find_position_arg(struct rte_argparse *obj, uint32_t index)
+static const struct rte_argparse_arg *
+find_position_arg(const struct rte_argparse *obj, uint32_t index)
 {
-	struct rte_argparse_arg *arg;
+	const struct rte_argparse_arg *arg;
 	uint32_t count = 0;
 	uint32_t i;
 
@@ -345,7 +345,7 @@ find_position_arg(struct rte_argparse *obj, uint32_t index)
 }
 
 static bool
-is_arg_match(struct rte_argparse_arg *arg, const char *curr_argv, uint32_t len)
+is_arg_match(const struct rte_argparse_arg *arg, const char *curr_argv, uint32_t len)
 {
 	if (strlen(arg->name_long) == len && strncmp(arg->name_long, curr_argv, len) == 0)
 		return true;
@@ -359,12 +359,12 @@ is_arg_match(struct rte_argparse_arg *arg, const char *curr_argv, uint32_t len)
 	return false;
 }
 
-static struct rte_argparse_arg *
-find_option_arg(struct rte_argparse *obj, uint32_t *idx,
+static const struct rte_argparse_arg *
+find_option_arg(const struct rte_argparse *obj, uint32_t *idx,
 		const char *curr_argv, const char *has_equal, const char **arg_name)
 {
 	uint32_t len = strlen(curr_argv) - (has_equal != NULL ? strlen(has_equal) : 0);
-	struct rte_argparse_arg *arg;
+	const struct rte_argparse_arg *arg;
 	uint32_t i;
 	bool match;
 
@@ -385,7 +385,7 @@ find_option_arg(struct rte_argparse *obj, uint32_t *idx,
 }
 
 static int
-parse_arg_int(struct rte_argparse_arg *arg, const char *value)
+parse_arg_int(const struct rte_argparse_arg *arg, const char *value)
 {
 	char *s = NULL;
 
@@ -410,7 +410,7 @@ parse_arg_int(struct rte_argparse_arg *arg, const char *value)
 }
 
 static int
-parse_arg_u8(struct rte_argparse_arg *arg, const char *value)
+parse_arg_u8(const struct rte_argparse_arg *arg, const char *value)
 {
 	unsigned long val;
 	char *s = NULL;
@@ -438,7 +438,7 @@ parse_arg_u8(struct rte_argparse_arg *arg, const char *value)
 }
 
 static int
-parse_arg_u16(struct rte_argparse_arg *arg, const char *value)
+parse_arg_u16(const struct rte_argparse_arg *arg, const char *value)
 {
 	unsigned long val;
 	char *s = NULL;
@@ -466,7 +466,7 @@ parse_arg_u16(struct rte_argparse_arg *arg, const char *value)
 }
 
 static int
-parse_arg_u32(struct rte_argparse_arg *arg, const char *value)
+parse_arg_u32(const struct rte_argparse_arg *arg, const char *value)
 {
 	unsigned long val;
 	char *s = NULL;
@@ -494,7 +494,7 @@ parse_arg_u32(struct rte_argparse_arg *arg, const char *value)
 }
 
 static int
-parse_arg_u64(struct rte_argparse_arg *arg, const char *value)
+parse_arg_u64(const struct rte_argparse_arg *arg, const char *value)
 {
 	unsigned long val;
 	char *s = NULL;
@@ -522,7 +522,7 @@ parse_arg_u64(struct rte_argparse_arg *arg, const char *value)
 }
 
 static int
-parse_arg_str(struct rte_argparse_arg *arg, const char *value)
+parse_arg_str(const struct rte_argparse_arg *arg, const char *value)
 {
 	if (value == NULL) {
 		*(char **)arg->val_saver = arg->val_set;
@@ -534,7 +534,7 @@ parse_arg_str(struct rte_argparse_arg *arg, const char *value)
 }
 
 static int
-parse_arg_bool(struct rte_argparse_arg *arg, const char *value)
+parse_arg_bool(const struct rte_argparse_arg *arg, const char *value)
 {
 	if (value == NULL) {
 		*(bool *)arg->val_saver = (arg->val_set != NULL);
@@ -555,7 +555,7 @@ parse_arg_bool(struct rte_argparse_arg *arg, const char *value)
 }
 
 static int
-parse_arg_autosave(struct rte_argparse_arg *arg, const char *value)
+parse_arg_autosave(const struct rte_argparse_arg *arg, const char *value)
 {
 	switch (arg->value_type) {
 	case RTE_ARGPARSE_VALUE_TYPE_NONE:
@@ -582,8 +582,8 @@ parse_arg_autosave(struct rte_argparse_arg *arg, const char *value)
 
 /* arg_parse indicates the name entered by the user, which can be long-name or short-name. */
 static int
-parse_arg_val(struct rte_argparse *obj, const char *arg_name,
-	      struct rte_argparse_arg *arg, char *value)
+parse_arg_val(const struct rte_argparse *obj, const char *arg_name,
+	      const struct rte_argparse_arg *arg, char *value)
 {
 	int ret;
 
@@ -606,11 +606,11 @@ is_help(const char *curr_argv)
 }
 
 static int
-parse_args(struct rte_argparse *obj, bool *arg_parsed,
+parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 		int argc, char **argv, bool *show_help)
 {
 	uint32_t position_count = calc_position_count(obj);
-	struct rte_argparse_arg *arg;
+	const struct rte_argparse_arg *arg;
 	uint32_t position_index = 0;
 	const char *arg_name;
 	uint32_t arg_idx;
@@ -795,7 +795,7 @@ show_args_help(const struct rte_argparse *obj)
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse, 24.03)
 int
-rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
+rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv)
 {
 	bool *arg_parsed = NULL;
 	bool show_help = false;
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 3d04d47771..52bef34363 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -187,7 +187,7 @@ struct rte_argparse {
  *   Otherwise negative error code is returned.
  */
 __rte_experimental
-int rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv);
+int rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv);
 
 /**
  * @warning
-- 
2.48.1

