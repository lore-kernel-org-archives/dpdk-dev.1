Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF35CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E26240697;
	Thu,  9 Oct 2025 15:01:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CE08E40671
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014876; x=1791550876;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wJN2Ag//x4yqLGGrkuycs3qJShAgHD+O2LXPg8EY9eo=;
 b=GCWCGQfdI8HI93kFLngTMiutYlXdWZH1EbVUoSf+cnt2DatfAS5hHpid
 Qw5r74NvJFM1gGh+8E5qZfQcgrJNUBt7A/EkBCuWGuf1Xv73N+ZglF+ZC
 XbKCxot8ExlWDO6dTNpN99REcWz9nEAVtSpEGtdpawpjlVpkiaxqLlllz
 NVdQiVr5v1qke5/BrwiLurSA0Z2ERZVIby5PdUHy8TzHue9pFqUQrRk2Q
 kDYhr2TfALNwOGOIVgbsTOdyh1tMUYAnSGvOvppEDClETDj7ITNPTCRjG
 4A1vIq7xaPVam9r0v6UmSPsqr4vFVmM3mbm7HMYItFsXMYcXWWHEDSRCD w==;
X-CSE-ConnectionGUID: a08scFYoQUyj2rwwF5mqkQ==
X-CSE-MsgGUID: euLX146PRji10Cj1L+DCrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663075"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663075"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:16 -0700
X-CSE-ConnectionGUID: CrtRMuUxRpODgCfTHmlnrA==
X-CSE-MsgGUID: 0BoDjdOOQtGArK0gk1qYtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951603"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 07/21] argparse: allow optional flag reordering
Date: Thu,  9 Oct 2025 14:00:42 +0100
Message-ID: <20251009130056.2630343-8-bruce.richardson@intel.com>
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

Allow argparse to behave like getopt in ignoring non-flag arguments and
moving them to the end of the list. This will allow use in DPDK for EAL
args where, for example:

  ./dpdk-test -l 1,2 lcores_autotest --no-huge -- argparse_autotest

will return from getopt processing in rte_eal_init as:

  ./dpdk-test -l 1,2 --no-huge -- lcores_autotest argparse_autotest

with EAL init function then replacing the "--" with argv[0] before
returning to the app with the return value of 5, for the 5 args
(including the "--") processed.

Since this is a significant behavioural change for argparse, which,
unlike getopt, has the idea of positional arguments, we place this
behaviour behind a new flag for argparse. If this new
"ignore_non_flag_args" option is set, then positional arguments are
disallowed and getopt behaviour is used for non-flag args.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_argparse.c               | 376 +++++++++++++++++++++++++
 doc/guides/prog_guide/argparse_lib.rst |  17 ++
 lib/argparse/rte_argparse.c            |  62 +++-
 lib/argparse/rte_argparse.h            |   6 +
 4 files changed, 453 insertions(+), 8 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 8d70166cfa..cce637ce22 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -1077,6 +1077,371 @@ test_argparse_parse_type(void)
 	return 0;
 }
 
+static int
+test_argparse_ignore_non_flag_args_disabled(void)
+{
+	struct rte_argparse *obj;
+	char *argv[6];
+	int ret;
+
+	/* Test that without ignore_non_flag_args, non-flag args cause an error */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = false;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("nonflagvalue");
+	argv[3] = test_strdup("-x");
+	ret = rte_argparse_parse(obj, 4, argv);
+	TEST_ASSERT(ret == -EINVAL, "Argparse should fail with non-flag arg when flag is disabled!");
+
+	/* Test with non-flag args mixed with flags */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = false;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("nonflagvalue1");
+	argv[2] = test_strdup("-a");
+	argv[3] = test_strdup("-x");
+	argv[4] = test_strdup("nonflagvalue2");
+	ret = rte_argparse_parse(obj, 5, argv);
+	TEST_ASSERT(ret == -EINVAL, "Argparse should fail with non-flag args when flag is disabled!");
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_basic(void)
+{
+	struct rte_argparse *obj;
+	char *argv[8];
+	int ret;
+
+	/* Test basic reordering: ['app', '-a', 'nonflagvalue', '-x']
+	 * Should process -a and -x, return 2 processed args, move nonflagvalue to end
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("nonflagvalue");
+	argv[3] = test_strdup("-x");
+	ret = rte_argparse_parse(obj, 4, argv);
+	TEST_ASSERT(ret == 3, "Argparse should return 3 (processed all but 1 non-flag), got %d!",
+			ret);
+	TEST_ASSERT(strcmp(argv[3], "nonflagvalue") == 0,
+		"Non-flag arg should be moved to end, but argv[3]='%s'!", argv[3]);
+
+	/* Test with multiple non-flag args:
+	 * ['app', '-a', 'nonflag1', '-x', 'nonflag2']
+	 * Should process -a and -x, return 3, reorder to [..., 'nonflag1', 'nonflag2']
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("nonflag1");
+	argv[3] = test_strdup("-x");
+	argv[4] = test_strdup("nonflag2");
+	ret = rte_argparse_parse(obj, 5, argv);
+	TEST_ASSERT(ret == 3, "Argparse should return 3 (processed all but 2 non-flags), got %d!",
+			ret);
+	TEST_ASSERT(strcmp(argv[3], "nonflag1") == 0,
+		"First non-flag arg should be at position 3, but argv[3]='%s'!", argv[3]);
+	TEST_ASSERT(strcmp(argv[4], "nonflag2") == 0,
+		"Second non-flag arg should be at position 4, but argv[4]='%s'!", argv[4]);
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_with_values(void)
+{
+	struct rte_argparse *obj;
+	int val_a = 0, val_x = 0;
+	char *argv[10];
+	int ret;
+
+	/* Test with flags that take values:
+	 * ['app', '-a', 'avalue', 'nonflag1', '-x', 'xvalue', 'nonflag2']
+	 * Should process -a avalue and -x xvalue, move non-flags to end
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = (void *)&val_a;
+	obj->args[0].val_set = NULL;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[1].val_saver = (void *)&val_x;
+	obj->args[1].val_set = NULL;
+	obj->args[1].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[1].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("100");
+	argv[3] = test_strdup("nonflag1");
+	argv[4] = test_strdup("-x");
+	argv[5] = test_strdup("200");
+	argv[6] = test_strdup("nonflag2");
+	ret = rte_argparse_parse(obj, 7, argv);
+	TEST_ASSERT(ret == 5, "Argparse should return 5 (app + 4 flag-related + 0 non-flags), got %d!",
+			ret);
+	TEST_ASSERT(val_a == 100, "Value for -a should be parsed correctly, got %d!", val_a);
+	TEST_ASSERT(val_x == 200, "Value for -x should be parsed correctly, got %d!", val_x);
+	TEST_ASSERT(strcmp(argv[5], "nonflag1") == 0,
+		"First non-flag arg should be at position 5, but argv[5]='%s'!", argv[5]);
+	TEST_ASSERT(strcmp(argv[6], "nonflag2") == 0,
+		"Second non-flag arg should be at position 6, but argv[6]='%s'!", argv[6]);
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_complex_order(void)
+{
+	struct rte_argparse *obj;
+	int val_a = 0;
+	char *argv[10];
+	int ret;
+
+	/* Test complex reordering matching example from requirements:
+	 * ['app', '-a', 'avalue', 'nonflag1', '-x', 'nonflag2']
+	 * Should become: ['app', '-a', 'avalue', '-x', 'nonflag1', 'nonflag2']
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = (void *)&val_a;
+	obj->args[0].val_set = NULL;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("50");
+	argv[3] = test_strdup("nonflag1");
+	argv[4] = test_strdup("-x");
+	argv[5] = test_strdup("nonflag2");
+	ret = rte_argparse_parse(obj, 6, argv);
+	TEST_ASSERT(ret == 4, "Argparse should return 4 (app + 3 flag-related), got %d!", ret);
+	TEST_ASSERT(val_a == 50, "Value for -a should be parsed correctly, got %d!", val_a);
+	/* Verify reordering */
+	TEST_ASSERT(strcmp(argv[4], "nonflag1") == 0,
+		"First non-flag should be at position 4, but argv[4]='%s'!", argv[4]);
+	TEST_ASSERT(strcmp(argv[5], "nonflag2") == 0,
+		"Second non-flag should be at position 5, but argv[5]='%s'!", argv[5]);
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_only_non_flags(void)
+{
+	struct rte_argparse *obj;
+	char *argv[5];
+	int ret;
+
+	/* Edge case: only non-flag args
+	 * ['app', 'nonflag1', 'nonflag2', 'nonflag3']
+	 * Should return 1 (only app name processed), argv unchanged
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("nonflag1");
+	argv[2] = test_strdup("nonflag2");
+	argv[3] = test_strdup("nonflag3");
+	ret = rte_argparse_parse(obj, 4, argv);
+	TEST_ASSERT(ret == 1, "Argparse should return 1 (only app name processed), got %d!", ret);
+	TEST_ASSERT(strcmp(argv[1], "nonflag1") == 0,
+		"First non-flag should remain at position 1, but argv[1]='%s'!", argv[1]);
+	TEST_ASSERT(strcmp(argv[2], "nonflag2") == 0,
+		"Second non-flag should remain at position 2, but argv[2]='%s'!", argv[2]);
+	TEST_ASSERT(strcmp(argv[3], "nonflag3") == 0,
+		"Third non-flag should remain at position 3, but argv[3]='%s'!", argv[3]);
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_no_non_flags(void)
+{
+	struct rte_argparse *obj;
+	char *argv[4];
+	int ret;
+
+	/* Edge case: no non-flag args, only flags
+	 * ['app', '-a', '-x']
+	 * Should process all args normally
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("-x");
+	ret = rte_argparse_parse(obj, 3, argv);
+	TEST_ASSERT(ret == 3, "Argparse should return 3 (all args processed), got %d!", ret);
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_with_double_dash(void)
+{
+	struct rte_argparse *obj;
+	char *argv[8];
+	int ret;
+
+	/* Test with -- separator:
+	 * ['app', '-a', 'nonflag1', '--', 'arg1', 'arg2']
+	 * Should process -a, stop at --, and move nonflag1 after --
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("nonflag1");
+	argv[3] = test_strdup("--");
+	argv[4] = test_strdup("arg1");
+	argv[5] = test_strdup("arg2");
+	ret = rte_argparse_parse(obj, 6, argv);
+	/* Should return position of first flag after -- */
+	TEST_ASSERT(ret == 3, "Argparse should return 3 (app + -a, stopped at --), got %d!", ret);
+	TEST_ASSERT(strcmp(argv[2], "--") == 0,
+		"-- should be moved to position 2, but argv[2]='%s'!", argv[2]);
+	TEST_ASSERT(strcmp(argv[3], "nonflag1") == 0,
+		"Non-flag should be moved after --, but argv[3]='%s'!", argv[3]);
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_leading_non_flags(void)
+{
+	struct rte_argparse *obj;
+	char *argv[7];
+	int ret;
+
+	/* Test with leading non-flag args:
+	 * ['app', 'nonflag1', 'nonflag2', '-a', '-x']
+	 * Should process -a and -x, move non-flags to end
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("nonflag1");
+	argv[2] = test_strdup("nonflag2");
+	argv[3] = test_strdup("-a");
+	argv[4] = test_strdup("-x");
+	ret = rte_argparse_parse(obj, 5, argv);
+	TEST_ASSERT(ret == 3, "Argparse should return 3 (app + 2 flags), got %d!", ret);
+	TEST_ASSERT(strcmp(argv[3], "nonflag1") == 0,
+		"First non-flag should be at position 3, but argv[3]='%s'!", argv[3]);
+	TEST_ASSERT(strcmp(argv[4], "nonflag2") == 0,
+		"Second non-flag should be at position 4, but argv[4]='%s'!", argv[4]);
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_trailing_non_flags(void)
+{
+	struct rte_argparse *obj;
+	char *argv[7];
+	int ret;
+
+	/* Test with trailing non-flag args:
+	 * ['app', '-a', '-x', 'nonflag1', 'nonflag2']
+	 * Should process -a and -x, non-flags already at end
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("-a");
+	argv[2] = test_strdup("-x");
+	argv[3] = test_strdup("nonflag1");
+	argv[4] = test_strdup("nonflag2");
+	ret = rte_argparse_parse(obj, 5, argv);
+	TEST_ASSERT(ret == 3, "Argparse should return 3 (app + 2 flags), got %d!", ret);
+	TEST_ASSERT(strcmp(argv[3], "nonflag1") == 0,
+		"First non-flag should remain at position 3, but argv[3]='%s'!", argv[3]);
+	TEST_ASSERT(strcmp(argv[4], "nonflag2") == 0,
+		"Second non-flag should remain at position 4, but argv[4]='%s'!", argv[4]);
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_with_positional(void)
+{
+	struct rte_argparse *obj;
+	char *argv[5];
+	int ret;
+
+	/* Test that ignore_non_flag_args cannot be used with positional args
+	 * This should fail during validation
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].name_long = "positional";
+	obj->args[0].name_short = NULL;
+	obj->args[0].val_saver = (void *)1;
+	obj->args[0].val_set = NULL;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("100");
+	ret = rte_argparse_parse(obj, 2, argv);
+	TEST_ASSERT(ret == -EINVAL,
+		"Argparse should fail when ignore_non_flag_args is used with positional args!");
+
+	return 0;
+}
+
+static int
+test_argparse_ignore_non_flag_args_short_and_long(void)
+{
+	struct rte_argparse *obj;
+	char *argv[8];
+	int ret;
+
+	/* Test with both short and long options:
+	 * ['app', '--abc', 'nonflag1', '-x', 'nonflag2']
+	 */
+	obj = test_argparse_init_obj();
+	obj->ignore_non_flag_args = true;
+	obj->args[0].val_saver = NULL;
+	obj->args[1].val_saver = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("--abc");
+	argv[2] = test_strdup("nonflag1");
+	argv[3] = test_strdup("-x");
+	argv[4] = test_strdup("nonflag2");
+	ret = rte_argparse_parse(obj, 5, argv);
+	TEST_ASSERT(ret == 3, "Argparse should return 3 (app + 2 flags), got %d!", ret);
+	TEST_ASSERT(strcmp(argv[3], "nonflag1") == 0,
+		"First non-flag should be at position 3, but argv[3]='%s'!", argv[3]);
+	TEST_ASSERT(strcmp(argv[4], "nonflag2") == 0,
+		"Second non-flag should be at position 4, but argv[4]='%s'!", argv[4]);
+
+	return 0;
+}
+
 static struct unit_test_suite argparse_test_suite = {
 	.suite_name = "Argparse Unit Test Suite",
 	.setup = test_argparse_setup,
@@ -1101,6 +1466,17 @@ static struct unit_test_suite argparse_test_suite = {
 		TEST_CASE(test_argparse_pos_autosave_parse_int),
 		TEST_CASE(test_argparse_pos_callback_parse_int),
 		TEST_CASE(test_argparse_parse_type),
+		TEST_CASE(test_argparse_ignore_non_flag_args_disabled),
+		TEST_CASE(test_argparse_ignore_non_flag_args_basic),
+		TEST_CASE(test_argparse_ignore_non_flag_args_with_values),
+		TEST_CASE(test_argparse_ignore_non_flag_args_complex_order),
+		TEST_CASE(test_argparse_ignore_non_flag_args_only_non_flags),
+		TEST_CASE(test_argparse_ignore_non_flag_args_no_non_flags),
+		TEST_CASE(test_argparse_ignore_non_flag_args_with_double_dash),
+		TEST_CASE(test_argparse_ignore_non_flag_args_leading_non_flags),
+		TEST_CASE(test_argparse_ignore_non_flag_args_trailing_non_flags),
+		TEST_CASE(test_argparse_ignore_non_flag_args_with_positional),
+		TEST_CASE(test_argparse_ignore_non_flag_args_short_and_long),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
index 7882d910ab..eff8f94a2d 100644
--- a/doc/guides/prog_guide/argparse_lib.rst
+++ b/doc/guides/prog_guide/argparse_lib.rst
@@ -15,6 +15,8 @@ Features and Capabilities
 
 - Support parsing positional argument (which must take with required-value).
 
+- Support getopt-style argument reordering for non-flag arguments as an alternative to positional arguments.
+
 - Support automatic generate usage information.
 
 - Support issue errors when provide with invalid arguments.
@@ -160,6 +162,21 @@ both use this way, the parsing is as follows:
 - For argument ``ooo``, it is positional argument,
   the ``ooo_val`` will be set to user input's value.
 
+Support of non-flag/positional arguments
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For arguments which are not flags (i.e. don't start with a hyphen '-'),
+there are two ways in which they can be handled by the library:
+
+#. Positional arguments: these are defined in the ``args`` array with a NULL ``short_name`` field,
+   and long_name field that does not start with a hyphen '-'.
+   They are parsed as required-value arguments.
+
+#. As ignored, or unhandled arguments: if the ``ignore_non_flag_args`` field in the ``rte_argparse`` object is set to true,
+   then any non-flag arguments will be ignored by the parser and moved to the end of the argument list.
+   In this mode, no positional arguments are allowed.
+   The return value from ``rte_argparse_parse()`` will indicate the position of the first ignored non-flag argument.
+
 Supported Value Types
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 8b0fcec4b8..1e320749b4 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -289,6 +289,13 @@ verify_argparse(const struct rte_argparse *obj, size_t *nb_args)
 		return -EINVAL;
 	}
 
+	for (idx = 0; idx < RTE_DIM(obj->reserved_flags); idx++) {
+		if (obj->reserved_flags[idx]) {
+			ARGPARSE_LOG(ERR, "reserved flags cannot be set!");
+			return -EINVAL;
+		}
+	}
+
 	for (idx = 0; idx < RTE_DIM(obj->reserved); idx++) {
 		if (obj->reserved[idx] != 0) {
 			ARGPARSE_LOG(ERR, "reserved field must be zero!");
@@ -298,6 +305,10 @@ verify_argparse(const struct rte_argparse *obj, size_t *nb_args)
 
 	idx = 0;
 	while (obj->args[idx].name_long != NULL) {
+		if (is_arg_positional(&obj->args[idx]) && obj->ignore_non_flag_args) {
+			ARGPARSE_LOG(ERR, "Error validating argparse object: positional args are not allowed when ignore_non_flag_args is set!");
+			return -EINVAL;
+		}
 		ret = verify_argparse_arg(obj, idx);
 		if (ret != 0)
 			return ret;
@@ -678,6 +689,8 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 	const struct rte_argparse_arg *arg;
 	uint32_t position_index = 0;
 	const char *arg_name;
+	size_t n_args_to_move;
+	char **args_to_move;
 	uint32_t arg_idx;
 	char *curr_argv;
 	char *has_equal;
@@ -685,6 +698,13 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 	int ret;
 	int i;
 
+	n_args_to_move = 0;
+	args_to_move = calloc(argc, sizeof(args_to_move[0]));
+	if (args_to_move == NULL) {
+		ARGPARSE_LOG(ERR, "failed to allocate memory for internal flag processing!");
+		return -ENOMEM;
+	}
+
 	for (i = 1; i < argc; i++) {
 		curr_argv = argv[i];
 
@@ -694,16 +714,23 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 		}
 
 		if (curr_argv[0] != '-') {
+			if (obj->ignore_non_flag_args) {
+				/* Move non-flag args to args_to_move array. */
+				args_to_move[n_args_to_move++] = curr_argv;
+				argv[i] = NULL;
+				continue;
+			}
 			/* process positional parameters. */
 			position_index++;
 			if (position_index > position_count) {
 				ARGPARSE_LOG(ERR, "too many positional arguments %s!", curr_argv);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_out;
 			}
 			arg = find_position_arg(obj, position_index);
 			ret = parse_arg_val(obj, arg->name_long, arg, curr_argv);
 			if (ret != 0)
-				return ret;
+				goto err_out;
 			continue;
 		}
 
@@ -718,26 +745,30 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 		arg = find_option_arg(obj, &arg_idx, curr_argv, has_equal, &arg_name);
 		if (arg == NULL || arg_name == NULL) {
 			ARGPARSE_LOG(ERR, "unknown argument %s!", curr_argv);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_out;
 		}
 
 		if (arg_parsed[arg_idx] && !arg_attr_flag_multi(arg)) {
 			ARGPARSE_LOG(ERR, "argument %s should not occur multiple times!", arg_name);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_out;
 		}
 
 		value = (has_equal != NULL ? has_equal + 1 : NULL);
 		if (arg->value_required == RTE_ARGPARSE_VALUE_NONE) {
 			if (value != NULL) {
 				ARGPARSE_LOG(ERR, "argument %s should not take value!", arg_name);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_out;
 			}
 		} else if (arg->value_required == RTE_ARGPARSE_VALUE_REQUIRED) {
 			if (value == NULL) {
 				if (i >= argc - 1) {
 					ARGPARSE_LOG(ERR, "argument %s doesn't have value!",
 							arg_name);
-					return -EINVAL;
+					ret = -EINVAL;
+					goto err_out;
 				}
 				/* Set value and make i move next. */
 				value = argv[++i];
@@ -748,13 +779,28 @@ parse_args(const struct rte_argparse *obj, bool *arg_parsed,
 
 		ret = parse_arg_val(obj, arg_name, arg, value);
 		if (ret != 0)
-			return ret;
+			goto err_out;
 
 		/* This argument parsed success! then mark it parsed. */
 		arg_parsed[arg_idx] = true;
 	}
 
-	return i;
+	ret = i;
+	if (n_args_to_move > 0) {
+		/* Close the gaps in argv array by moving elements down filling in the NULLs. */
+		int j = 1;
+		for (i = 1; i < ret; i++) {
+			if (argv[i] != NULL)
+				argv[j++] = argv[i];
+		}
+		ret = j; /* only return args actually handled */
+		/* Then put contents of the args_to_move array into the argv in the space left. */
+		for (i = 0; i < (int)n_args_to_move; i++)
+			argv[j++] = args_to_move[i];
+	}
+err_out:
+	free(args_to_move);
+	return ret;
 }
 
 static uint32_t
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 991f084927..ecf04396e9 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -158,6 +158,12 @@ struct rte_argparse {
 	const char *epilog;
 	/** Whether exit when error. */
 	bool exit_on_error;
+	/** behave like getopt and move non-flag args to the end, ignoring them otherwise.
+	 * If this flag is specified, no positional args are allowed.
+	 */
+	bool ignore_non_flag_args;
+	/* reserved for future flags/other use */
+	bool reserved_flags[6];
 	/** User callback for parsing arguments. */
 	rte_arg_parser_t callback;
 	/** Opaque which used to invoke callback. */
-- 
2.48.1

