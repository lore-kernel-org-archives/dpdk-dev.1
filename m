Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72471C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 09:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBEFC40672;
	Tue, 27 May 2025 11:21:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 551DD40672
 for <dev@dpdk.org>; Tue, 27 May 2025 11:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748337693; x=1779873693;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3uEUlLQBkaVFcdKPHIo12f0jjqjUoa4j28XgOMwy6Zs=;
 b=IpjuIKXd7xiiB25dJA0+S8Z9pw3CDVQM/xoiKEMDYyjpxKv1hMb/gOYV
 L/ETF02VTQwi3t3iJlEm60mhIlWqKeqBpZdyUYJ+SHMOkzpMUQqjDbn+G
 sr266GhDdPZBpkpBtTzp6QUCpfxF3Hlag/n+3+dTvVgtUVCgrzUoZYriW
 Vv2X/1zFYwYK+UNSenXqOWc/oWp0cjeugrt4jXyZ/JUcbjQDAEYuPKkVx
 rBwV3uOujFzfln7r//hlEUfbMozTJwHpHCAB/y90WLeXNjyCJgeVSY0KD
 2wrtBdfTpm5bQuyPKOXmPOCU8qFVXubb0OSMkse5zOPuut1cREjvEuyVE g==;
X-CSE-ConnectionGUID: 8TvvzQ9kR9Wrv2oPyM4OGQ==
X-CSE-MsgGUID: UF3KBhsqSFWF7YSvU1mHQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50197819"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="50197819"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 02:21:32 -0700
X-CSE-ConnectionGUID: 085+ojfzREONOz2pHpGZGg==
X-CSE-MsgGUID: Eklz+RKLT1u3aZJrhQW+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143703958"
Received: from silpixa00401217.ir.intel.com ([10.55.128.45])
 by orviesa008.jf.intel.com with ESMTP; 27 May 2025 02:21:31 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/3] argparse: use enums to remove max-value defines in lists
Date: Tue, 27 May 2025 10:21:13 +0100
Message-ID: <20250527092113.903910-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527092113.903910-1-bruce.richardson@intel.com>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
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

The use of lists of #defines with _MAX entries at the end causes issues
for ABI compatibility as those MAX values often leak through to
applications and can cause issues when changed.

We can rework the code to increase type safety by splitting the flags
field and using enums for each set of values explicitly:

* One enum for whether an argument takes a parameter or not (or
  optionally takes one)
* One enum for the type of the argument.
* A separate flags field for any additional info - right now this is
  only to indicate an argument can appear more than once.

The use of the MAX field is no longer necessary using the enums as we
can use an inline function with a switch statement to check for valid
values. Compilers like GCC will warn when an enum value is missing from
the switch statement, easing future maintenance if enum values are
added.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_argparse.c               | 178 ++++++++++++-------------
 doc/guides/rel_notes/release_25_07.rst |  35 +++++
 examples/dma/dmafwd.c                  |  20 +--
 examples/flow_filtering/main.c         |   4 +-
 lib/argparse/rte_argparse.c            | 144 ++++++++++----------
 lib/argparse/rte_argparse.h            |  92 +++++++------
 6 files changed, 255 insertions(+), 218 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index a907fbe53f..0459fa5c0d 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -79,8 +79,8 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
 	.exit_on_error = false, \
 	.callback = test_argparse_callback, \
 	.args = { \
-		{ "--abc", "-a", "abc argument", (void *)1, (void *)1, RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_INT }, \
-		{ "--xyz", "-x", "xyz argument", (void *)1, (void *)2, RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_INT }, \
+		{ "--abc", "-a", "abc argument", (void *)1, (void *)1, RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE }, \
+		{ "--xyz", "-x", "xyz argument", (void *)1, (void *)2, RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE }, \
 		ARGPARSE_ARG_END(), \
 	}, \
 }
@@ -188,27 +188,20 @@ test_argparse_invalid_arg_help(void)
 static int
 test_argparse_invalid_has_val(void)
 {
-	uint64_t set_mask[] = { 0,
-				RTE_ARGPARSE_ARG_NO_VALUE,
-				RTE_ARGPARSE_ARG_OPTIONAL_VALUE
-			      };
+	uint64_t invalid_values[] = {
+			RTE_ARGPARSE_VALUE_NONE,
+			RTE_ARGPARSE_VALUE_OPTIONAL,
+	};
 	struct rte_argparse *obj;
 	uint32_t index;
 	int ret;
 
-	/* test optional arg don't config has-value. */
-	obj = test_argparse_init_obj();
-	obj->args[0].flags &= ~RTE_ARGPARSE_HAS_VAL_BITMASK;
-	ret = rte_argparse_parse(obj, default_argc, default_argv);
-	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
-
 	/* test positional arg don't config required-value. */
-	for (index = 0; index < RTE_DIM(set_mask); index++) {
+	for (index = 0; index < RTE_DIM(invalid_values); index++) {
 		obj = test_argparse_init_obj();
 		obj->args[0].name_long = "abc";
 		obj->args[0].name_short = NULL;
-		obj->args[0].flags &= ~RTE_ARGPARSE_HAS_VAL_BITMASK;
-		obj->args[0].flags |= set_mask[index];
+		obj->args[0].value_required = invalid_values[index];
 		ret = rte_argparse_parse(obj, default_argc, default_argv);
 		TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 	}
@@ -225,14 +218,15 @@ test_argparse_invalid_arg_saver(void)
 	/* test saver == NULL with val-type != 0. */
 	obj = test_argparse_init_obj();
 	obj->args[0].val_saver = NULL;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_INT;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_NONE;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	ret = rte_argparse_parse(obj, default_argc, default_argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 
 	/* test saver == NULL with callback is NULL. */
 	obj = test_argparse_init_obj();
 	obj->args[0].val_saver = NULL;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_NO_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_NONE;
 	obj->callback = NULL;
 	ret = rte_argparse_parse(obj, default_argc, default_argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
@@ -241,15 +235,7 @@ test_argparse_invalid_arg_saver(void)
 	obj = test_argparse_init_obj();
 	obj->args[0].val_saver = (void *)1;
 	obj->args[0].val_set = (void *)1;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_NO_VALUE;
-	ret = rte_argparse_parse(obj, default_argc, default_argv);
-	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
-
-	/* test saver != NULL with val-type is max. */
-	obj = test_argparse_init_obj();
-	obj->args[0].val_saver = (void *)1;
-	obj->args[0].val_set = (void *)1;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_MAX;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_NONE;
 	ret = rte_argparse_parse(obj, default_argc, default_argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 
@@ -257,7 +243,8 @@ test_argparse_invalid_arg_saver(void)
 	obj = test_argparse_init_obj();
 	obj->args[0].val_saver = (void *)1;
 	obj->args[0].val_set = (void *)1;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_INT;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	ret = rte_argparse_parse(obj, default_argc, default_argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 
@@ -272,9 +259,7 @@ test_argparse_invalid_arg_flags(void)
 
 	/* test set unused bits. */
 	obj = test_argparse_init_obj();
-	obj->args[0].flags |= ~(RTE_ARGPARSE_HAS_VAL_BITMASK |
-				RTE_ARGPARSE_VAL_TYPE_BITMASK |
-				RTE_ARGPARSE_ARG_SUPPORT_MULTI);
+	obj->args[0].flags |= ~(RTE_ARGPARSE_FLAG_SUPPORT_MULTI);
 	ret = rte_argparse_parse(obj, default_argc, default_argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 
@@ -284,14 +269,15 @@ test_argparse_invalid_arg_flags(void)
 	obj->args[0].name_short = NULL;
 	obj->args[0].val_saver = (void *)1;
 	obj->args[0].val_set = NULL;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_INT |
-			     RTE_ARGPARSE_ARG_SUPPORT_MULTI;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
+	obj->args[0].flags |= RTE_ARGPARSE_FLAG_SUPPORT_MULTI;
 	ret = rte_argparse_parse(obj, default_argc, default_argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 
 	/* test optional arg enabled multiple but prased by autosave. */
 	obj = test_argparse_init_obj();
-	obj->args[0].flags |= RTE_ARGPARSE_ARG_SUPPORT_MULTI;
+	obj->args[0].flags |= RTE_ARGPARSE_FLAG_SUPPORT_MULTI;
 	ret = rte_argparse_parse(obj, default_argc, default_argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 
@@ -344,7 +330,6 @@ test_argparse_invalid_option(void)
 static int
 test_argparse_opt_autosave_parse_int_of_no_val(void)
 {
-	uint64_t flags = RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_INT;
 	struct rte_argparse *obj;
 	int val_saver = 0;
 	char *argv[2];
@@ -355,7 +340,8 @@ test_argparse_opt_autosave_parse_int_of_no_val(void)
 	obj->args[0].name_short = "-t";
 	obj->args[0].val_saver = (void *)&val_saver;
 	obj->args[0].val_set = (void *)100;
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_NONE;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	obj->args[1].name_long = NULL;
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
@@ -363,7 +349,8 @@ test_argparse_opt_autosave_parse_int_of_no_val(void)
 	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_NONE;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
@@ -376,7 +363,6 @@ test_argparse_opt_autosave_parse_int_of_no_val(void)
 static int
 test_argparse_opt_autosave_parse_int_of_required_val(void)
 {
-	uint64_t flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_INT;
 	struct rte_argparse *obj;
 	int val_saver = 0;
 	char *argv[3];
@@ -387,7 +373,8 @@ test_argparse_opt_autosave_parse_int_of_required_val(void)
 	obj->args[0].name_short = "-t";
 	obj->args[0].val_saver = (void *)&val_saver;
 	obj->args[0].val_set = NULL;
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	obj->args[1].name_long = NULL;
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
@@ -396,7 +383,8 @@ test_argparse_opt_autosave_parse_int_of_required_val(void)
 	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 3, argv);
@@ -404,7 +392,8 @@ test_argparse_opt_autosave_parse_int_of_required_val(void)
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test invalid value. */
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	argv[2] = test_strdup("100a");
@@ -417,7 +406,6 @@ test_argparse_opt_autosave_parse_int_of_required_val(void)
 static int
 test_argparse_opt_autosave_parse_int_of_optional_val(void)
 {
-	uint64_t flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE | RTE_ARGPARSE_ARG_VALUE_INT;
 	struct rte_argparse *obj;
 	int val_saver = 0;
 	char *argv[2];
@@ -429,14 +417,16 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 	obj->args[0].name_short = "-t";
 	obj->args[0].val_saver = (void *)&val_saver;
 	obj->args[0].val_set = (void *)100;
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	obj->args[1].name_long = NULL;
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
 	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
@@ -444,13 +434,15 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test with value. */
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("--test-long=200");
 	ret = rte_argparse_parse(obj, 2, argv);
 	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 200, "Argparse parse expect success!");
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("-t=200");
 	ret = rte_argparse_parse(obj, 2, argv);
@@ -458,12 +450,14 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 	TEST_ASSERT(val_saver == 200, "Argparse parse expect success!");
 
 	/* test with option value, but with wrong value. */
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("--test-long=200a");
 	ret = rte_argparse_parse(obj, 2, argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("-t=200a");
 	ret = rte_argparse_parse(obj, 2, argv);
@@ -498,7 +492,7 @@ test_argparse_opt_callback_parse_int_of_no_val(void)
 	obj->args[0].name_short = "-t";
 	obj->args[0].val_saver = NULL;
 	obj->args[0].val_set = (void *)1;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_NO_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_NONE;
 	obj->args[1].name_long = NULL;
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
@@ -506,7 +500,7 @@ test_argparse_opt_callback_parse_int_of_no_val(void)
 	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
-	obj->args[0].flags = RTE_ARGPARSE_ARG_NO_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_NONE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
@@ -549,7 +543,7 @@ test_argparse_opt_callback_parse_int_of_required_val(void)
 	obj->args[0].name_short = "-t";
 	obj->args[0].val_saver = NULL;
 	obj->args[0].val_set = (void *)1;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
 	obj->args[1].name_long = NULL;
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
@@ -558,7 +552,7 @@ test_argparse_opt_callback_parse_int_of_required_val(void)
 	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
-	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 3, argv);
@@ -566,12 +560,12 @@ test_argparse_opt_callback_parse_int_of_required_val(void)
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test no more parameters. */
-	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
 	ret = rte_argparse_parse(obj, 2, argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 
 	/* test callback return failed. */
-	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
 	argv[2] = test_strdup("100a");
 	ret = rte_argparse_parse(obj, 3, argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
@@ -613,7 +607,7 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 	obj->args[0].name_short = "-t";
 	obj->args[0].val_saver = NULL;
 	obj->args[0].val_set = (void *)1;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
 	obj->args[1].name_long = NULL;
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
@@ -621,7 +615,7 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 10, "Argparse parse expect success!");
 
-	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
@@ -629,13 +623,13 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 	TEST_ASSERT(val_saver == 10, "Argparse parse expect success!");
 
 	/* test with value. */
-	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
 	val_saver = 0;
 	argv[1] = test_strdup("--test-long=100");
 	ret = rte_argparse_parse(obj, 2, argv);
 	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
-	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
 	val_saver = 0;
 	argv[1] = test_strdup("-t=100");
 	ret = rte_argparse_parse(obj, 2, argv);
@@ -643,7 +637,7 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test callback return failed. */
-	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_OPTIONAL;
 	argv[1] = test_strdup("-t=100a");
 	ret = rte_argparse_parse(obj, 2, argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
@@ -654,7 +648,6 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 static int
 test_argparse_pos_autosave_parse_int(void)
 {
-	uint64_t flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_INT;
 	struct rte_argparse *obj;
 	int val_saver = 0;
 	char *argv[3];
@@ -666,7 +659,8 @@ test_argparse_pos_autosave_parse_int(void)
 	obj->args[0].name_short = NULL;
 	obj->args[0].val_saver = (void *)&val_saver;
 	obj->args[0].val_set = NULL;
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	obj->args[1].name_long = NULL;
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("100");
@@ -675,14 +669,16 @@ test_argparse_pos_autosave_parse_int(void)
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test positional autosave parse failed. */
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	val_saver = 0;
 	argv[1] = test_strdup("100a");
 	ret = rte_argparse_parse(obj, 2, argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
 
 	/* test too much position parameters. */
-	obj->args[0].flags = flags;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_INT;
 	argv[1] = test_strdup("100");
 	argv[2] = test_strdup("200");
 	ret = rte_argparse_parse(obj, 3, argv);
@@ -727,12 +723,12 @@ test_argparse_pos_callback_parse_int(void)
 	obj->args[0].name_short = NULL;
 	obj->args[0].val_saver = NULL;
 	obj->args[0].val_set = (void *)1;
-	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
 	obj->args[1].name_long = "test-long2";
 	obj->args[1].name_short = NULL;
 	obj->args[1].val_saver = NULL;
 	obj->args[1].val_set = (void *)2;
-	obj->args[1].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
+	obj->args[1].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
 	obj->args[2].name_long = NULL;
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("100");
@@ -743,8 +739,8 @@ test_argparse_pos_callback_parse_int(void)
 	TEST_ASSERT(val_saver[2] == 200, "Argparse parse expect success!");
 
 	/* test positional callback parse failed. */
-	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
-	obj->args[1].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[1].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
 	argv[2] = test_strdup("200a");
 	ret = rte_argparse_parse(obj, 3, argv);
 	TEST_ASSERT(ret == -EINVAL, "Argparse parse expect failed!");
@@ -775,78 +771,78 @@ test_argparse_parse_type(void)
 	int ret;
 
 	/* test for int parsing */
-	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
+	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_VALUE_TYPE_INT, &val_int);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
+	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_VALUE_TYPE_INT, &val_int);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
+	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_VALUE_TYPE_INT, &val_int);
 	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_int == 123, "Argparse parse type expect failed!");
 
 	/* test for u8 parsing */
-	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_ARG_VALUE_U8, &val_u8);
+	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_VALUE_TYPE_U8, &val_u8);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_erange_u8, RTE_ARGPARSE_ARG_VALUE_U8, &val_u8);
+	ret = rte_argparse_parse_type(str_erange_u8, RTE_ARGPARSE_VALUE_TYPE_U8, &val_u8);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_U8, &val_u8);
+	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_VALUE_TYPE_U8, &val_u8);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u8 = 0;
-	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U8, &val_u8);
+	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_VALUE_TYPE_U8, &val_u8);
 	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u8 == 123, "Argparse parse type expect failed!");
 
 	/* test for u16 parsing */
-	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_ARG_VALUE_U16, &val_u16);
+	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_VALUE_TYPE_U16, &val_u16);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_erange_u16, RTE_ARGPARSE_ARG_VALUE_U16, &val_u16);
+	ret = rte_argparse_parse_type(str_erange_u16, RTE_ARGPARSE_VALUE_TYPE_U16, &val_u16);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_U16, &val_u16);
+	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_VALUE_TYPE_U16, &val_u16);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u16 = 0;
-	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U16, &val_u16);
+	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_VALUE_TYPE_U16, &val_u16);
 	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u16 == 123, "Argparse parse type expect failed!");
 
 	/* test for u32 parsing */
-	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_ARG_VALUE_U32, &val_u32);
+	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_VALUE_TYPE_U32, &val_u32);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_erange_u32, RTE_ARGPARSE_ARG_VALUE_U32, &val_u32);
+	ret = rte_argparse_parse_type(str_erange_u32, RTE_ARGPARSE_VALUE_TYPE_U32, &val_u32);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_U32, &val_u32);
+	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_VALUE_TYPE_U32, &val_u32);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u32 = 0;
-	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U32, &val_u32);
+	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_VALUE_TYPE_U32, &val_u32);
 	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u32 == 123, "Argparse parse type expect failed!");
 
 	/* test for u64 parsing */
-	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_ARG_VALUE_U64, &val_u64);
+	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_VALUE_TYPE_U64, &val_u64);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
-	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_U64, &val_u64);
+	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_VALUE_TYPE_U64, &val_u64);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u64 = 0;
-	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U64, &val_u64);
+	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_VALUE_TYPE_U64, &val_u64);
 	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u64 == 123, "Argparse parse type expect failed!");
 
 	/* test for string parsing - all it does is save string, so all are valid */
 	const char *val_str;
-	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_ARG_VALUE_STR, &val_str);
+	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_VALUE_TYPE_STR, &val_str);
 	TEST_ASSERT(ret == 0, "Argparse parse a string failed unexpectedly!");
 
 	/* test for boolean parsing */
 	bool val_bool = false;
-	ret = rte_argparse_parse_type(bool_true, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	ret = rte_argparse_parse_type(bool_true, RTE_ARGPARSE_VALUE_TYPE_BOOL, &val_bool);
 	TEST_ASSERT(ret == 0 && val_bool == true, "Argparse parse type for bool (true) failed!");
-	ret = rte_argparse_parse_type(bool_false, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	ret = rte_argparse_parse_type(bool_false, RTE_ARGPARSE_VALUE_TYPE_BOOL, &val_bool);
 	TEST_ASSERT(ret == 0 && val_bool == false, "Argparse parse type for bool (false) failed!");
-	ret = rte_argparse_parse_type(bool_invalid, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	ret = rte_argparse_parse_type(bool_invalid, RTE_ARGPARSE_VALUE_TYPE_BOOL, &val_bool);
 	TEST_ASSERT(ret != 0, "Argparse parse type for bool (invalid) passed unexpectedly!");
-	ret = rte_argparse_parse_type(bool_numeric_true, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	ret = rte_argparse_parse_type(bool_numeric_true, RTE_ARGPARSE_VALUE_TYPE_BOOL, &val_bool);
 	TEST_ASSERT(ret == 0 && val_bool == true, "Argparse parse type for bool (numeric true) failed!");
-	ret = rte_argparse_parse_type(bool_numeric_false, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	ret = rte_argparse_parse_type(bool_numeric_false, RTE_ARGPARSE_VALUE_TYPE_BOOL, &val_bool);
 	TEST_ASSERT(ret == 0 && val_bool == false, "Argparse parse type for bool (numeric false) failed!");
-	ret = rte_argparse_parse_type(bool_numeric_invalid, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	ret = rte_argparse_parse_type(bool_numeric_invalid, RTE_ARGPARSE_VALUE_TYPE_BOOL, &val_bool);
 	TEST_ASSERT(ret != 0, "Argparse parse type for bool (numeric invalid) passed unexpectedly!");
 	return 0;
 }
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 608526f021..0720dd9cea 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -91,6 +91,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* argparse: The ``rte_argparse_arg`` structure used for defining arguments has been updated.
+    See next section, :ref:`ABI-Changes` for details.
+
+.. _ABI-Changes:
 
 ABI Changes
 -----------
@@ -117,6 +121,37 @@ ABI Changes
      ``rte_argparse_parse()`` stops processing arguments when a ``--`` argument is encountered.
      This behaviour mirrors the behaviour of the ``getopt()`` function,
      as well as the behaviour of ``rte_eal_init()`` function.
+   * The ``rte_argparse_arg`` structure used for defining arguments has been updated
+     to separate out into separate fields the options for:
+
+     #. Whether the argument is required or optional.
+     #. What the type of the argument is (in case of saving the parameters automatically).
+     #. Any other flags - of which there is only one, ``RTE_ARGPARSE_FLAG_SUPPORT_MULTI``, at this time.
+
+   * With the splitting of the flags into separate enums for categories,
+     the names of the flags have been changed to better reflect their purpose.
+     The flags/enum values are:
+
+     * For the ``value_required`` field:
+
+        * ``RTE_ARGPARSE_VALUE_NONE``
+        * ``RTE_ARGPARSE_VALUE_REQUIRED``
+        * ``RTE_ARGPARSE_VALUE_OPTIONAL``
+
+     * For the ``value_type`` field:
+
+        * ``RTE_ARGPARSE_VALUE_TYPE_NONE`` (No argument value type is specified, callback is to be used for processing.)
+        * ``RTE_ARGPARSE_VALUE_TYPE_INT``
+        * ``RTE_ARGPARSE_VALUE_TYPE_U8``
+        * ``RTE_ARGPARSE_VALUE_TYPE_U16``
+        * ``RTE_ARGPARSE_VALUE_TYPE_U32``
+        * ``RTE_ARGPARSE_VALUE_TYPE_U64``
+        * ``RTE_ARGPARSE_VALUE_TYPE_STR``
+        * ``RTE_ARGPARSE_VALUE_TYPE_BOOL``
+
+     * Other flags:
+
+        * ``RTE_ARGPARSE_FLAG_SUPPORT_MULTI`` (Allows the argument to be specified multiple times.)
 
 
 Known Issues
diff --git a/examples/dma/dmafwd.c b/examples/dma/dmafwd.c
index acceae6b7b..5ba0aaa40b 100644
--- a/examples/dma/dmafwd.c
+++ b/examples/dma/dmafwd.c
@@ -644,43 +644,43 @@ dma_parse_args(int argc, char **argv, unsigned int nb_ports)
 		.args = {
 			{ "--mac-updating", NULL, "Enable MAC addresses updating",
 			  &mac_updating, (void *)1,
-			  RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_INT,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_INT,
 			},
 			{ "--no-mac-updating", NULL, "Disable MAC addresses updating",
 			  &mac_updating, (void *)0,
-			  RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_INT,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_INT,
 			},
 			{ "--portmask", "-p", "hexadecimal bitmask of ports to configure",
 			  NULL, (void *)CMD_LINE_OPT_PORTMASK_INDEX,
-			  RTE_ARGPARSE_ARG_REQUIRED_VALUE,
+			  RTE_ARGPARSE_VALUE_REQUIRED,
 			},
 			{ "--nb-queue", "-q", "number of RX queues per port (default is 1)",
 			  &nb_queues, NULL,
-			  RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_U16,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U16,
 			},
 			{ "--copy-type", "-c", "type of copy: sw|hw",
 			  NULL, (void *)CMD_LINE_OPT_COPY_TYPE_INDEX,
-			  RTE_ARGPARSE_ARG_REQUIRED_VALUE,
+			  RTE_ARGPARSE_VALUE_REQUIRED,
 			},
 			{ "--ring-size", "-s", "size of dmadev descriptor ring for hardware copy mode or rte_ring for software copy mode",
 			  &ring_size, NULL,
-			  RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_U16,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U16,
 			},
 			{ "--dma-batch-size", "-b", "number of requests per DMA batch",
 			  &dma_batch_sz, NULL,
-			  RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_U32,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U32,
 			},
 			{ "--max-frame-size", "-f", "max frame size",
 			  &max_frame_size, NULL,
-			  RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_U32,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U32,
 			},
 			{ "--force-min-copy-size", "-m", "force a minimum copy length, even for smaller packets",
 			  &force_min_copy_size, NULL,
-			  RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_U32,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U32,
 			},
 			{ "--stats-interval", "-i", "interval, in seconds, between stats prints (default is 1)",
 			  &stats_interval, NULL,
-			  RTE_ARGPARSE_ARG_REQUIRED_VALUE | RTE_ARGPARSE_ARG_VALUE_U16,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_U16,
 			},
 			ARGPARSE_ARG_END(),
 		},
diff --git a/examples/flow_filtering/main.c b/examples/flow_filtering/main.c
index c0bc1938ce..9c429a8335 100644
--- a/examples/flow_filtering/main.c
+++ b/examples/flow_filtering/main.c
@@ -274,11 +274,11 @@ flow_filtering_parse_args(int argc, char **argv)
 		.args = {
 			{ "--template", NULL, "Enable template API flow",
 			  &use_template_api, (void *)1,
-			  RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_INT,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_INT,
 			},
 			{ "--non-template", NULL, "Enable non template API flow",
 			  &use_template_api, (void *)0,
-			  RTE_ARGPARSE_ARG_NO_VALUE | RTE_ARGPARSE_ARG_VALUE_INT,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_INT,
 			},
 			ARGPARSE_ARG_END(),
 		},
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index bb03cdc4af..d7fee101d4 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -30,30 +30,48 @@ is_arg_positional(const struct rte_argparse_arg *arg)
 	return arg->name_long[0] != '-';
 }
 
-static inline uint32_t
-arg_attr_has_val(const struct rte_argparse_arg *arg)
+static inline bool
+is_valid_has_value_field(const struct rte_argparse_arg *arg)
 {
-	return RTE_FIELD_GET64(RTE_ARGPARSE_HAS_VAL_BITMASK, arg->flags);
+	switch (arg->value_required) {
+		case RTE_ARGPARSE_VALUE_NONE:
+		case RTE_ARGPARSE_VALUE_OPTIONAL:
+		case RTE_ARGPARSE_VALUE_REQUIRED:
+			return true;
+		/* omit default case so compiler warns on any missing enum values */
+	}
+	return false;
 }
 
-static inline uint32_t
-arg_attr_val_type(const struct rte_argparse_arg *arg)
-{
-	return RTE_FIELD_GET64(RTE_ARGPARSE_VAL_TYPE_BITMASK, arg->flags);
+static inline bool
+is_valid_value_type_field(const struct rte_argparse_arg *arg)
+{
+	switch (arg->value_type) {
+		case RTE_ARGPARSE_VALUE_TYPE_NONE:
+		case RTE_ARGPARSE_VALUE_TYPE_INT:
+		case RTE_ARGPARSE_VALUE_TYPE_U8:
+		case RTE_ARGPARSE_VALUE_TYPE_U16:
+		case RTE_ARGPARSE_VALUE_TYPE_U32:
+		case RTE_ARGPARSE_VALUE_TYPE_U64:
+		case RTE_ARGPARSE_VALUE_TYPE_STR:
+		case RTE_ARGPARSE_VALUE_TYPE_BOOL:
+			return true;
+		/* omit default case so compiler warns on any missing enum values */
+	}
+	return false;
 }
 
+
 static inline bool
 arg_attr_flag_multi(const struct rte_argparse_arg *arg)
 {
-	return RTE_FIELD_GET64(RTE_ARGPARSE_ARG_SUPPORT_MULTI, arg->flags);
+	return (arg->flags & RTE_ARGPARSE_FLAG_SUPPORT_MULTI) != 0;
 }
 
 static inline uint64_t
 arg_attr_unused_bits(const struct rte_argparse_arg *arg)
 {
-#define USED_BIT_MASK	(RTE_ARGPARSE_HAS_VAL_BITMASK | \
-			 RTE_ARGPARSE_VAL_TYPE_BITMASK | \
-			 RTE_ARGPARSE_ARG_SUPPORT_MULTI)
+#define USED_BIT_MASK	(RTE_ARGPARSE_FLAG_SUPPORT_MULTI)
 	return arg->flags & ~USED_BIT_MASK;
 }
 
@@ -110,56 +128,51 @@ verify_arg_help(const struct rte_argparse_arg *arg)
 static int
 verify_arg_has_val(const struct rte_argparse_arg *arg)
 {
-	uint32_t has_val = arg_attr_has_val(arg);
-
+	if (!is_valid_has_value_field(arg)) {
+		ARGPARSE_LOG(ERR, "argument %s has invalid value field!", arg->name_long);
+		return -EINVAL;
+	}
 	if (is_arg_positional(arg)) {
-		if (has_val == RTE_ARGPARSE_ARG_REQUIRED_VALUE)
+		if (arg->value_required == RTE_ARGPARSE_VALUE_REQUIRED)
 			return 0;
 		ARGPARSE_LOG(ERR, "argument %s is positional, must config required-val!",
 			     arg->name_long);
 		return -EINVAL;
 	}
 
-	if (has_val == 0) {
-		ARGPARSE_LOG(ERR, "argument %s is optional, has-value config wrong!",
-			     arg->name_long);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
 static int
 verify_arg_saver(const struct rte_argparse *obj, uint32_t index)
 {
-	uint32_t cmp_max = RTE_FIELD_GET64(RTE_ARGPARSE_VAL_TYPE_BITMASK,
-					   RTE_ARGPARSE_ARG_VALUE_MAX);
 	const struct rte_argparse_arg *arg = &obj->args[index];
-	uint32_t val_type = arg_attr_val_type(arg);
-	uint32_t has_val = arg_attr_has_val(arg);
 
 	if (arg->val_saver == NULL) {
-		if (val_type != 0) {
+		if (arg->value_type != RTE_ARGPARSE_VALUE_TYPE_NONE) {
 			ARGPARSE_LOG(ERR, "argument %s parsed by callback, value-type should not be set!",
 				     arg->name_long);
 			return -EINVAL;
 		}
-
 		if (obj->callback == NULL) {
 			ARGPARSE_LOG(ERR, "argument %s parsed by callback, but callback is NULL!",
 				     arg->name_long);
 			return -EINVAL;
 		}
-
 		return 0;
 	}
 
-	if (val_type == 0 || val_type >= cmp_max) {
-		ARGPARSE_LOG(ERR, "argument %s value-type config wrong!", arg->name_long);
+	/* check value_type field */
+	if (!is_valid_value_type_field(arg)) {
+		ARGPARSE_LOG(ERR, "argument %s has invalid value-type field!", arg->name_long);
+		return -EINVAL;
+	}
+	if (arg->value_type == RTE_ARGPARSE_VALUE_TYPE_NONE) {
+		ARGPARSE_LOG(ERR, "missing value-type for argument %s!", arg->name_long);
 		return -EINVAL;
 	}
 
-	if (has_val == RTE_ARGPARSE_ARG_REQUIRED_VALUE && arg->val_set != NULL) {
+	if (arg->value_required == RTE_ARGPARSE_VALUE_REQUIRED && arg->val_set != NULL) {
 		ARGPARSE_LOG(ERR, "argument %s has required value, value-set should be NULL!",
 			     arg->name_long);
 		return -EINVAL;
@@ -180,7 +193,7 @@ verify_arg_flags(const struct rte_argparse *obj, uint32_t index)
 		return -EINVAL;
 	}
 
-	if (!(arg->flags & RTE_ARGPARSE_ARG_SUPPORT_MULTI))
+	if (!(arg->flags & RTE_ARGPARSE_FLAG_SUPPORT_MULTI))
 		return 0;
 
 	if (is_arg_positional(arg)) {
@@ -543,26 +556,27 @@ parse_arg_bool(struct rte_argparse_arg *arg, const char *value)
 static int
 parse_arg_autosave(struct rte_argparse_arg *arg, const char *value)
 {
-	static struct {
-		int (*f_parse_type)(struct rte_argparse_arg *arg, const char *value);
-	} map[] = {
-		/* Sort by RTE_ARGPARSE_ARG_VALUE_XXX. */
-		{ NULL          },
-		{ parse_arg_int },
-		{ parse_arg_u8  },
-		{ parse_arg_u16 },
-		{ parse_arg_u32 },
-		{ parse_arg_u64 },
-		{ parse_arg_str},
-		{ parse_arg_bool },
-	};
-	uint32_t index = arg_attr_val_type(arg);
-	int ret = -EINVAL;
-
-	if (index > 0 && index < RTE_DIM(map))
-		ret = map[index].f_parse_type(arg, value);
-
-	return ret;
+	switch (arg->value_type) {
+	case RTE_ARGPARSE_VALUE_TYPE_NONE:
+		ARGPARSE_LOG(ERR, "argument %s doesn't specify a value-type!", arg->name_long);
+		return -EINVAL;
+	case RTE_ARGPARSE_VALUE_TYPE_INT:
+		return parse_arg_int(arg, value);
+	case RTE_ARGPARSE_VALUE_TYPE_U8:
+		return parse_arg_u8(arg, value);
+	case RTE_ARGPARSE_VALUE_TYPE_U16:
+		return parse_arg_u16(arg, value);
+	case RTE_ARGPARSE_VALUE_TYPE_U32:
+		return parse_arg_u32(arg, value);
+	case RTE_ARGPARSE_VALUE_TYPE_U64:
+		return parse_arg_u64(arg, value);
+	case RTE_ARGPARSE_VALUE_TYPE_STR:
+		return parse_arg_str(arg, value);
+	case RTE_ARGPARSE_VALUE_TYPE_BOOL:
+		return parse_arg_bool(arg, value);
+	/* omit default case so compiler warns on missing enum values */
+	}
+	return -EINVAL;
 }
 
 /* arg_parse indicates the name entered by the user, which can be long-name or short-name. */
@@ -615,7 +629,7 @@ parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
 			/* process positional parameters. */
 			position_index++;
 			if (position_index > position_count) {
-				ARGPARSE_LOG(ERR, "too much positional argument %s!", curr_argv);
+				ARGPARSE_LOG(ERR, "too many positional arguments %s!", curr_argv);
 				return -EINVAL;
 			}
 			arg = find_position_arg(obj, position_index);
@@ -640,23 +654,20 @@ parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
 		}
 
 		if ((arg->flags & ARG_ATTR_FLAG_PARSED_MASK) && !arg_attr_flag_multi(arg)) {
-			ARGPARSE_LOG(ERR, "argument %s should not occur multiple!",
-				     arg_name);
+			ARGPARSE_LOG(ERR, "argument %s should not occur multiple times!", arg_name);
 			return -EINVAL;
 		}
 
 		value = (has_equal != NULL ? has_equal + 1 : NULL);
-		if (arg_attr_has_val(arg) == RTE_ARGPARSE_ARG_NO_VALUE) {
+		if (arg->value_required == RTE_ARGPARSE_VALUE_NONE) {
 			if (value != NULL) {
-				ARGPARSE_LOG(ERR, "argument %s should not take value!",
-					     arg_name);
+				ARGPARSE_LOG(ERR, "argument %s should not take value!", arg_name);
 				return -EINVAL;
 			}
-		} else if (arg_attr_has_val(arg) == RTE_ARGPARSE_ARG_REQUIRED_VALUE) {
+		} else if (arg->value_required == RTE_ARGPARSE_VALUE_REQUIRED) {
 			if (value == NULL) {
 				if (i >= argc - 1) {
-					ARGPARSE_LOG(ERR, "argument %s doesn't have value!",
-						     arg_name);
+					ARGPARSE_LOG(ERR, "argument %s doesn't have value!", arg_name);
 					return -EINVAL;
 				}
 				/* Set value and make i move next. */
@@ -808,21 +819,18 @@ rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_argparse_parse_type, 24.03)
 int
-rte_argparse_parse_type(const char *str, uint64_t val_type, void *val)
+rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type, void *val)
 {
-	uint32_t cmp_max = RTE_FIELD_GET64(RTE_ARGPARSE_VAL_TYPE_BITMASK,
-					   RTE_ARGPARSE_ARG_VALUE_MAX);
 	struct rte_argparse_arg arg = {
 		.name_long = str,
 		.name_short = NULL,
 		.val_saver = val,
 		.val_set = NULL,
-		.flags = val_type,
+		.value_type = val_type,
 	};
-	uint32_t value_type = arg_attr_val_type(&arg);
-
-	if (value_type == 0 || value_type >= cmp_max)
+	if (val_type == RTE_ARGPARSE_VALUE_TYPE_NONE) {
+		ARGPARSE_LOG(ERR, "argument %s doesn't have value-type!", str);
 		return -EINVAL;
-
+	}
 	return parse_arg_autosave(&arg, str);
 }
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 8cdb3195cb..8a78d53bd3 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -37,49 +37,44 @@
 extern "C" {
 #endif
 
-/**@{@name Flag definition (in bitmask form) for an argument
- *
- * @note Bits[0~1] represent the argument whether has value,
- * bits[2~9] represent the value type which used when autosave.
- *
- * @see struct rte_argparse_arg::flags
- */
-/** The argument has no value. */
-#define RTE_ARGPARSE_ARG_NO_VALUE       RTE_SHIFT_VAL64(1, 0)
-/** The argument must have a value. */
-#define RTE_ARGPARSE_ARG_REQUIRED_VALUE RTE_SHIFT_VAL64(2, 0)
-/** The argument has optional value. */
-#define RTE_ARGPARSE_ARG_OPTIONAL_VALUE RTE_SHIFT_VAL64(3, 0)
-/** The argument's value is int type. */
-#define RTE_ARGPARSE_ARG_VALUE_INT      RTE_SHIFT_VAL64(1, 2)
-/** The argument's value is uint8 type. */
-#define RTE_ARGPARSE_ARG_VALUE_U8       RTE_SHIFT_VAL64(2, 2)
-/** The argument's value is uint16 type. */
-#define RTE_ARGPARSE_ARG_VALUE_U16      RTE_SHIFT_VAL64(3, 2)
-/** The argument's value is uint32 type. */
-#define RTE_ARGPARSE_ARG_VALUE_U32      RTE_SHIFT_VAL64(4, 2)
-/** The argument's value is uint64 type. */
-#define RTE_ARGPARSE_ARG_VALUE_U64      RTE_SHIFT_VAL64(5, 2)
-/** The argument's value is string type. */
-#define RTE_ARGPARSE_ARG_VALUE_STR      RTE_SHIFT_VAL64(6, 2)
-/** The argument's value is boolean flag type. */
-#define RTE_ARGPARSE_ARG_VALUE_BOOL     RTE_SHIFT_VAL64(7, 2)
-/** Max value type. */
-#define RTE_ARGPARSE_ARG_VALUE_MAX      RTE_SHIFT_VAL64(8, 2)
 /**
- * Flag for that argument support occur multiple times.
- * This flag can be set only when the argument is optional.
- * When this flag is set, the callback type must be used for parsing.
+ * enum defining whether an argument takes a value or not.
  */
-#define RTE_ARGPARSE_ARG_SUPPORT_MULTI  RTE_BIT64(10)
-/** Reserved for this library implementation usage. */
-#define RTE_ARGPARSE_ARG_RESERVED_FIELD RTE_GENMASK64(63, 48)
-/**@}*/
+enum rte_argparse_value_required {
+	/** The argument takes no value. */
+	RTE_ARGPARSE_VALUE_NONE,
+	/** The argument must have a value. */
+	RTE_ARGPARSE_VALUE_REQUIRED,
+	/** The argument has optional value. */
+	RTE_ARGPARSE_VALUE_OPTIONAL,
+};
 
-/** Bitmask used to get the argument whether has value. */
-#define RTE_ARGPARSE_HAS_VAL_BITMASK	RTE_GENMASK64(1, 0)
-/** Bitmask used to get the argument's value type. */
-#define RTE_ARGPARSE_VAL_TYPE_BITMASK	RTE_GENMASK64(9, 2)
+/** enum defining the type of the argument, integer, boolean or just string */
+enum rte_argparse_value_type {
+	/** Argument takes no value, or value type not specified.
+	 * Should be used when argument is to be handled via callback.
+	 */
+	RTE_ARGPARSE_VALUE_TYPE_NONE = 0,
+	/** The argument's value is int type. */
+	RTE_ARGPARSE_VALUE_TYPE_INT,
+	/** The argument's value is uint8 type. */
+	RTE_ARGPARSE_VALUE_TYPE_U8,
+	/** The argument's value is uint16 type. */
+	RTE_ARGPARSE_VALUE_TYPE_U16,
+	/** The argument's value is uint32 type. */
+	RTE_ARGPARSE_VALUE_TYPE_U32,
+	/** The argument's value is uint64 type. */
+	RTE_ARGPARSE_VALUE_TYPE_U64,
+	/** The argument's value is string type. */
+	RTE_ARGPARSE_VALUE_TYPE_STR,
+	/** The argument's value is boolean flag type. */
+	RTE_ARGPARSE_VALUE_TYPE_BOOL,
+};
+
+/** Additional flags which may be specified for each argument */
+enum rte_argparse_arg_flags {
+	RTE_ARGPARSE_FLAG_SUPPORT_MULTI = RTE_BIT32(0),
+};
 
 /**
  * A structure used to hold argument's configuration.
@@ -105,10 +100,8 @@ struct rte_argparse_arg {
 
 	/**
 	 * Saver for the argument's value.
-	 * 1) If the filed is NULL, the callback way is used for parsing
-	 *    argument.
-	 * 2) If the field is not NULL, the autosave way is used for parsing
-	 *    argument.
+	 * 1) If this field is NULL, the callback is used for parsing argument.
+	 * 2) If this field is not NULL, the argument's value will be automatically saved.
 	 */
 	void *val_saver;
 	/**
@@ -123,8 +116,13 @@ struct rte_argparse_arg {
 	 */
 	void *val_set;
 
-	/** Flag definition (RTE_ARGPARSE_ARG_*) for the argument. */
-	uint64_t flags;
+	/** Specify if the argument takes a value, @see enum rte_argparse_value_required. */
+	enum rte_argparse_value_required value_required;
+	/** The type of the argument, @see enum rte_argparse_value_type. */
+	enum rte_argparse_value_type value_type;
+
+	/** any additional flags for this argument */
+	uint32_t flags;
 };
 
 /**
@@ -206,7 +204,7 @@ int rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv);
  *   0 on success. Otherwise negative value is returned.
  */
 __rte_experimental
-int rte_argparse_parse_type(const char *str, uint64_t val_type, void *val);
+int rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type, void *val);
 
 #ifdef __cplusplus
 }
-- 
2.48.1

