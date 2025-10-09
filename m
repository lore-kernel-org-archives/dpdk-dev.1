Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78953CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AC36406B4;
	Thu,  9 Oct 2025 15:01:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 27ED64067A
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014878; x=1791550878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G7YtvljH9L46dDAXYqXelMWkm8m7a/cjH3rvv/Uqfxo=;
 b=n7X0grCHKb0Z6itVawGtACTtRcDhCLcm+buApnkSB7G3MU1tdVMQpkiB
 hYuBMwg9WkJ0iHchRb6gQYncuEm9AK/YzOeWhod5okB+obtcXDst8RZJf
 u4F+gJ08SPAJKyBovrJsWXygh4uNKJylbRl0V742WTbzNcQ/qQhqoGgjv
 pC4UuCHrKporRPMTnR7pX0dGOtGSDvnDDZc9I2FhtzOD11OqeTiWDFkfl
 w/hg5W69AeTuNBrAUbzekRRh2+HMds+TCAa+b7CDXaEuhEdkb+EpfvdTx
 xxMDX2u7Pre8CWxEbwSbTNz/BoXAkuYr18Nx0d7F24Bwyo6PsYX2ewDCg Q==;
X-CSE-ConnectionGUID: uYRXyYgfQVmtJQfzduX/Ng==
X-CSE-MsgGUID: I93xtiF8Sqi04rax8V2zZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663087"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663087"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:17 -0700
X-CSE-ConnectionGUID: kOK+6iiJTL+E9XrN7zhF1w==
X-CSE-MsgGUID: 7ObnGxamRMixR6AbcZYvWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951609"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 08/21] argparse: support parameters to short options
 without "="
Date: Thu,  9 Oct 2025 14:00:43 +0100
Message-ID: <20251009130056.2630343-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
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

When passing an optional parameter to a argparse argument, the only way
to do so has been to pass the argument using "=arg" on the end of the
option, for example "--foo=bar". However, for short options, i.e. those
of the form "-x", this requirement is unusual as getopt also supports
taking additional characters after the option as the parameter, e.g.
"-xarg".

Add support for this form of parameter for short options to argparse.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_argparse.c    | 131 ++++++++++++++++++++++++++++++++++++
 lib/argparse/rte_argparse.c |  10 +--
 2 files changed, 137 insertions(+), 4 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index cce637ce22..71a85ea960 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -1442,6 +1442,136 @@ test_argparse_ignore_non_flag_args_short_and_long(void)
 	return 0;
 }
 
+static int
+test_argparse_short_opt_value_without_equal(void)
+{
+	struct rte_argparse *obj;
+	int val_saver = 0;
+	char *argv[3];
+	int ret;
+
+	/* Test short option with required value using -a3 syntax (no '=') */
+	obj = test_argparse_init_obj();
+	obj->args[0].name_long = "--test-long";
+	obj->args[0].name_short = "-t";
+	obj->args[0].val_saver = (void *)&val_saver;
+	obj->args[0].val_set = NULL;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[1].name_long = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-t42");
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == 2, "Argparse parse with -t42 expect success, got %d!", ret);
+	TEST_ASSERT(val_saver == 42, "Argparse parse -t42 should set value to 42, got %d!",
+			val_saver);
+
+	/* Test short option with optional value using -t100 syntax (no '=') */
+	obj = test_argparse_init_obj();
+	obj->args[0].name_long = "--test-long";
+	obj->args[0].name_short = "-t";
+	obj->args[0].val_saver = (void *)&val_saver;
+	obj->args[0].val_set = (void *)99;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[1].name_long = NULL;
+	val_saver = 0;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-t123");
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == 2, "Argparse parse with -t123 expect success, got %d!", ret);
+	TEST_ASSERT(val_saver == 123, "Argparse parse -t123 should set value to 123, got %d!",
+			val_saver);
+
+	/* Test that -t alone with optional value uses default */
+	obj = test_argparse_init_obj();
+	obj->args[0].name_long = "--test-long";
+	obj->args[0].name_short = "-t";
+	obj->args[0].val_saver = (void *)&val_saver;
+	obj->args[0].val_set = (void *)99;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[1].name_long = NULL;
+	val_saver = 0;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-t");
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == 2, "Argparse parse with -t expect success, got %d!", ret);
+	TEST_ASSERT(val_saver == 99, "Argparse parse -t should use default 99, got %d!",
+			val_saver);
+
+	/* Test short option with '=' still works */
+	obj = test_argparse_init_obj();
+	obj->args[0].name_long = "--test-long";
+	obj->args[0].name_short = "-t";
+	obj->args[0].val_saver = (void *)&val_saver;
+	obj->args[0].val_set = NULL;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[1].name_long = NULL;
+	val_saver = 0;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-t=55");
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == 2, "Argparse parse with -t=55 expect success, got %d!", ret);
+	TEST_ASSERT(val_saver == 55, "Argparse parse -t=55 should set value to 55, got %d!",
+			val_saver);
+
+	/* Test that long option with value works with '=' */
+	obj = test_argparse_init_obj();
+	obj->args[0].name_long = "--test-long";
+	obj->args[0].name_short = "-t";
+	obj->args[0].val_saver = (void *)&val_saver;
+	obj->args[0].val_set = (void *)88;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[1].name_long = NULL;
+	val_saver = 0;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("--test-long=66");
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == 2, "Argparse parse with --test-long=66 expect success, got %d!", ret);
+	TEST_ASSERT(val_saver == 66, "Argparse parse --test-long=66 should set value to 66, got %d!",
+			val_saver);
+
+	/* Test short option with string value without '=' */
+	const char *str_saver = NULL;
+	obj = test_argparse_init_obj();
+	obj->args[0].name_long = "--test-string";
+	obj->args[0].name_short = "-s";
+	obj->args[0].val_saver = (void *)&str_saver;
+	obj->args[0].val_set = NULL;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_STR;
+	obj->args[1].name_long = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-shello");
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == 2, "Argparse parse with -shello expect success, got %d!", ret);
+	TEST_ASSERT(str_saver != NULL && strcmp(str_saver, "hello") == 0,
+		"Argparse parse -shello should set string to 'hello', got '%s'!",
+		str_saver ? str_saver : "(null)");
+
+	/* Test short option with negative number without '=' */
+	obj = test_argparse_init_obj();
+	obj->args[0].name_long = "--test-long";
+	obj->args[0].name_short = "-t";
+	obj->args[0].val_saver = (void *)&val_saver;
+	obj->args[0].val_set = NULL;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[1].name_long = NULL;
+	val_saver = 0;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-t-42");
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == 2, "Argparse parse with -t-42 expect success, got %d!", ret);
+	TEST_ASSERT(val_saver == -42, "Argparse parse -t-42 should set value to -42, got %d!",
+			val_saver);
+
+	return 0;
+}
+
 static struct unit_test_suite argparse_test_suite = {
 	.suite_name = "Argparse Unit Test Suite",
 	.setup = test_argparse_setup,
@@ -1477,6 +1607,7 @@ static struct unit_test_suite argparse_test_suite = {
 		TEST_CASE(test_argparse_ignore_non_flag_args_trailing_non_flags),
 		TEST_CASE(test_argparse_ignore_non_flag_args_with_positional),
 		TEST_CASE(test_argparse_ignore_non_flag_args_short_and_long),
+		TEST_CASE(test_argparse_short_opt_value_without_equal),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 1e320749b4..cc16ba6edc 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -693,7 +693,6 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 	char **args_to_move;
 	uint32_t arg_idx;
 	char *curr_argv;
-	char *has_equal;
 	char *value;
 	int ret;
 	int i;
@@ -740,9 +739,11 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 			continue;
 		}
 
-		has_equal = strchr(curr_argv, '=');
+		value = strchr(curr_argv, '=');
+		if (value == NULL && curr_argv[1] != '-' && strlen(curr_argv) > 2)
+			value = &curr_argv[2];
 		arg_name = NULL;
-		arg = find_option_arg(obj, &arg_idx, curr_argv, has_equal, &arg_name);
+		arg = find_option_arg(obj, &arg_idx, curr_argv, value, &arg_name);
 		if (arg == NULL || arg_name == NULL) {
 			ARGPARSE_LOG(ERR, "unknown argument %s!", curr_argv);
 			ret = -EINVAL;
@@ -755,7 +756,8 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 			goto err_out;
 		}
 
-		value = (has_equal != NULL ? has_equal + 1 : NULL);
+		if (value != NULL && value[0] == '=')
+			value++; /* skip '=' */
 		if (arg->value_required == RTE_ARGPARSE_VALUE_NONE) {
 			if (value != NULL) {
 				ARGPARSE_LOG(ERR, "argument %s should not take value!", arg_name);
-- 
2.48.1

