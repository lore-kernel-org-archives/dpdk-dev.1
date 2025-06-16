Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569CBC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 10:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A649440659;
	Mon, 16 Jun 2025 12:49:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E936240430
 for <dev@dpdk.org>; Mon, 16 Jun 2025 12:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750070998; x=1781606998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=98d4e571VYn1r5eKRRDVAa0YSkWR9Er1ChaIf68a55E=;
 b=bry1J4JglUdQxLwk3F4GGYPKLn2QiX5OOtIRQ5Yf+uygWhbZclcO5Vmu
 pY4StblRYtzOJqXJrswPKSbXB5mCTzx2iAYdKbm8IQc8AbWlsmv3ZADZc
 hcLmGnXmlT9DnDW+msvTLu073bHiwjsMcMJep0sR52N/gH9qZ7kkR15Io
 8+4t97UsZCLJ/5um7FY3AL58hqNW9ibpZg9UEupA4XIYgGFSzVx6L/frq
 OwFr56LxKaKS0fpJd3tNRrkV11XGtVD2PhLVm3J8H29Qq5gFhhn9VJptN
 UXzKZ6vj8VRKylatTUU8yY51T4GVSsW00RP1OD05WrNWlhGRCuaLBWX7G A==;
X-CSE-ConnectionGUID: JDsG9q64R+2x3KONOQi7uA==
X-CSE-MsgGUID: 2nvlhBnURjSPie0eigzS5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="54828154"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="54828154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 03:49:57 -0700
X-CSE-ConnectionGUID: N9vSQ2H2TnWTCK0VPspp4w==
X-CSE-MsgGUID: Zg+XrShhRFe69B+RfjWucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="148281505"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa006.fm.intel.com with ESMTP; 16 Jun 2025 03:49:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 1/3] argparse: track parsed arguments internally
Date: Mon, 16 Jun 2025 11:49:41 +0100
Message-ID: <20250616104944.3425929-2-bruce.richardson@intel.com>
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

Change how the argparse library records what cmdline arguments have been
seen or not; instead of setting an extra hidden flag in the user-passed
argument structure, set a flag on an internally allocated and managed
array. This means that the user parameters are not modified during the
parse operation, so they can be reused multiple times if necessary, e.g.
in testing.

This change also fixes a coverity issue, where the flag used to indicate
a seen argument was not adjusted to take account of the change of type
of the "flags" setting from 64-bit to 32-bit.

Coverity issue: 470190
Fixes: 04acc21beeeb ("argparse: use enums to remove max-value defines in lists")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/argparse/rte_argparse.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index b5b8467dea..431d0f9b84 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -16,8 +16,6 @@ RTE_LOG_REGISTER_DEFAULT(rte_argparse_logtype, INFO);
 #define ARGPARSE_LOG(level, ...) \
 	RTE_LOG_LINE(level, ARGPARSE, "" __VA_ARGS__)
 
-#define ARG_ATTR_FLAG_PARSED_MASK	RTE_BIT64(63)
-
 static inline bool
 is_arg_optional(const struct rte_argparse_arg *arg)
 {
@@ -273,9 +271,9 @@ verify_argparse_arg(const struct rte_argparse *obj, uint32_t index)
 }
 
 static int
-verify_argparse(const struct rte_argparse *obj)
+verify_argparse(const struct rte_argparse *obj, size_t *nb_args)
 {
-	uint32_t idx;
+	size_t idx;
 	int ret;
 
 	if (obj->prog_name == NULL) {
@@ -302,6 +300,7 @@ verify_argparse(const struct rte_argparse *obj)
 			return ret;
 		idx++;
 	}
+	*nb_args = idx;
 
 	return 0;
 }
@@ -361,8 +360,8 @@ is_arg_match(struct rte_argparse_arg *arg, const char *curr_argv, uint32_t len)
 }
 
 static struct rte_argparse_arg *
-find_option_arg(struct rte_argparse *obj, const char *curr_argv, const char *has_equal,
-		const char **arg_name)
+find_option_arg(struct rte_argparse *obj, uint32_t *idx,
+		const char *curr_argv, const char *has_equal, const char **arg_name)
 {
 	uint32_t len = strlen(curr_argv) - (has_equal != NULL ? strlen(has_equal) : 0);
 	struct rte_argparse_arg *arg;
@@ -377,6 +376,7 @@ find_option_arg(struct rte_argparse *obj, const char *curr_argv, const char *has
 		if (match) {
 			/* Obtains the exact matching name (long or short). */
 			*arg_name = len > 2 ? arg->name_long : arg->name_short;
+			*idx = i;
 			return arg;
 		}
 	}
@@ -606,12 +606,14 @@ is_help(const char *curr_argv)
 }
 
 static int
-parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
+parse_args(struct rte_argparse *obj, bool *arg_parsed,
+		int argc, char **argv, bool *show_help)
 {
 	uint32_t position_count = calc_position_count(obj);
 	struct rte_argparse_arg *arg;
 	uint32_t position_index = 0;
 	const char *arg_name;
+	uint32_t arg_idx;
 	char *curr_argv;
 	char *has_equal;
 	char *value;
@@ -648,13 +650,13 @@ parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
 
 		has_equal = strchr(curr_argv, '=');
 		arg_name = NULL;
-		arg = find_option_arg(obj, curr_argv, has_equal, &arg_name);
+		arg = find_option_arg(obj, &arg_idx, curr_argv, has_equal, &arg_name);
 		if (arg == NULL || arg_name == NULL) {
 			ARGPARSE_LOG(ERR, "unknown argument %s!", curr_argv);
 			return -EINVAL;
 		}
 
-		if ((arg->flags & ARG_ATTR_FLAG_PARSED_MASK) && !arg_attr_flag_multi(arg)) {
+		if (arg_parsed[arg_idx] && !arg_attr_flag_multi(arg)) {
 			ARGPARSE_LOG(ERR, "argument %s should not occur multiple times!", arg_name);
 			return -EINVAL;
 		}
@@ -684,7 +686,7 @@ parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
 			return ret;
 
 		/* This argument parsed success! then mark it parsed. */
-		arg->flags |= ARG_ATTR_FLAG_PARSED_MASK;
+		arg_parsed[arg_idx] = true;
 	}
 
 	return i;
@@ -795,14 +797,25 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse, 24.03)
 int
 rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
 {
+	bool *arg_parsed = NULL;
 	bool show_help = false;
+	size_t nb_args = 0;
 	int ret;
 
-	ret = verify_argparse(obj);
+	ret = verify_argparse(obj, &nb_args);
 	if (ret != 0)
 		goto error;
 
-	ret = parse_args(obj, argc, argv, &show_help);
+	/* allocate the flags array to indicate what arguments are parsed or not */
+	arg_parsed = calloc(nb_args, sizeof(*arg_parsed));
+	if (arg_parsed == NULL) {
+		ARGPARSE_LOG(ERR, "failed to allocate memory for argument flags!");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = parse_args(obj, arg_parsed, argc, argv, &show_help);
+	free(arg_parsed);
 	if (ret < 0)
 		goto error;
 
-- 
2.48.1

