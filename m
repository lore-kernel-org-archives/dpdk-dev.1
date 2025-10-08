Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF85CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 20:43:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 927F940696;
	Wed,  8 Oct 2025 22:43:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 29E494065A
 for <dev@dpdk.org>; Wed,  8 Oct 2025 22:43:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759956183; x=1791492183;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h9YNLFhM/vwrPWp47V2WfhaX5ON4ImobiN1WCImpiYk=;
 b=DgwO1Ai7Ga/0kbwz/kTYNG85IxknnREIk9yB440bs7RYPW1YCkJCQuHC
 SdLztf0qa+X96o8Zx2rgB/ZUgImKoLBBzpfN6nsPJ7vCwu2lgX8y8bj4z
 rVpgKz+givvW3YYFGivIhA2xNAmJYmDRli6c40Kz4QcU0ipr4un6cKJtM
 AdD2zigFkb1CdTpbDbEDaEXDeWCJvOoefWekPAXkUdz9SRnSysKfODsuq
 wjPsOpbWtPoIPJBrSdp4zKZJc+dA3mqqsyUVgbM3ZTd7WXi8pcRacLz6j
 s7fO86VxSNXZlJWjAxIBb2nlYdKlqTiqd9m8XHSKtUZSxsimE16NJbmwx Q==;
X-CSE-ConnectionGUID: KE/qn14cSqmRRRl+MlamKg==
X-CSE-MsgGUID: DsimomG0S6msoPdEH7E2FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62079238"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62079238"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 13:43:03 -0700
X-CSE-ConnectionGUID: XsyV6sJvSIGc50ptYbbOFQ==
X-CSE-MsgGUID: +WAycb/ASSmjj5IErm/fBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; d="scan'208";a="179790639"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 08 Oct 2025 13:43:02 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 08/21] argparse: support parameters to short options
 without "="
Date: Wed,  8 Oct 2025 21:42:31 +0100
Message-ID: <20251008204244.2288583-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008204244.2288583-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251008204244.2288583-1-bruce.richardson@intel.com>
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
index 2f9b644493..32dfbf95e1 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -1435,6 +1435,136 @@ test_argparse_ignore_non_flag_args_short_and_long(void)
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
@@ -1470,6 +1600,7 @@ static struct unit_test_suite argparse_test_suite = {
 		TEST_CASE(test_argparse_ignore_non_flag_args_trailing_non_flags),
 		TEST_CASE(test_argparse_ignore_non_flag_args_with_positional),
 		TEST_CASE(test_argparse_ignore_non_flag_args_short_and_long),
+		TEST_CASE(test_argparse_short_opt_value_without_equal),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 26a1371f36..21b35098c1 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -691,7 +691,6 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 	char **args_to_move;
 	uint32_t arg_idx;
 	char *curr_argv;
-	char *has_equal;
 	char *value;
 	int ret;
 	int i;
@@ -738,9 +737,11 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
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
@@ -753,7 +754,8 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
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

