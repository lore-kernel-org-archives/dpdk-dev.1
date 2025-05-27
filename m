Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE8C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 09:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEBF640664;
	Tue, 27 May 2025 11:21:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 596804066F
 for <dev@dpdk.org>; Tue, 27 May 2025 11:21:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748337689; x=1779873689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=av1talyW4dcQOHG4sYvf7k//FYPMwSqqdh4e7tMXX38=;
 b=b/tBAI0lwtBpgCC3FLwVL+Q14fG6IpgCLiu6ulb//hY06a/E2YES12Q/
 tM+eHPfXoTNQw16a+TmgH6/EGvRv75NUPHwpRz4d1RKvRYK05Jjh6zXHl
 SekzSKBQYLvsuE2r7iC7SkMKTwlM/BtTF96CziZLhKOWDgxfj3/+hb22L
 8rtY8pEnPwBYcfAxV31Ee18ZpG5I3ScehaN+8mZ3pO765zrFRakE7+r2V
 X3pYvTl+Qjbo315G/dpIhWcbsInBCKlvzvV+FzFXB/lcLaRnI+4VQLrQm
 nGxHSDhOpoCRm9vD4I+rRkLCKGz6STVGA5VJdzzk8TCqdzkH1L29RUIQX A==;
X-CSE-ConnectionGUID: Wm0zxJ/cRZ+ahxuRxnQ2/Q==
X-CSE-MsgGUID: iodwO5OaQeGG0SjtqB6zvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50197812"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="50197812"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 02:21:28 -0700
X-CSE-ConnectionGUID: 5fA35eWAThODNCoEmcwUMA==
X-CSE-MsgGUID: KIXphoWJSrCHwpdCqntyQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143703939"
Received: from silpixa00401217.ir.intel.com ([10.55.128.45])
 by orviesa008.jf.intel.com with ESMTP; 27 May 2025 02:21:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/3] argparse: make argparse EAL-args compatible
Date: Tue, 27 May 2025 10:21:12 +0100
Message-ID: <20250527092113.903910-3-bruce.richardson@intel.com>
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

The argparse library was missing two key features which made it
unsuitable for use by EAL or any program wanting similar behaviour.

1. It didn't stop parsing arguments when it hit a "--" character
2. It never returned the number of arguments parsed

Fix both these issues - the latter is a change to the ABI, since we now
return >= 0 rather than == 0 on success. However, the ABI is still
experimental so we can make exactly these sorts of tweaks to it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_argparse.c               | 46 +++++++++++++-------------
 doc/guides/rel_notes/release_25_07.rst |  9 +++++
 lib/argparse/rte_argparse.c            | 12 +++++--
 lib/argparse/rte_argparse.h            |  3 +-
 4 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 6b0d1524b5..a907fbe53f 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -360,14 +360,14 @@ test_argparse_opt_autosave_parse_int_of_no_val(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	obj->args[0].flags = flags;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	return 0;
@@ -393,14 +393,14 @@ test_argparse_opt_autosave_parse_int_of_required_val(void)
 	argv[1] = test_strdup("--test-long");
 	argv[2] = test_strdup("100");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	obj->args[0].flags = flags;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test invalid value. */
@@ -434,13 +434,13 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 	obj->args[0].flags = flags;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test with value. */
@@ -448,13 +448,13 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 	val_saver = 0;
 	argv[1] = test_strdup("--test-long=200");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 200, "Argparse parse expect success!");
 	obj->args[0].flags = flags;
 	val_saver = 0;
 	argv[1] = test_strdup("-t=200");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 200, "Argparse parse expect success!");
 
 	/* test with option value, but with wrong value. */
@@ -503,14 +503,14 @@ test_argparse_opt_callback_parse_int_of_no_val(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	obj->args[0].flags = RTE_ARGPARSE_ARG_NO_VALUE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	return 0;
@@ -555,14 +555,14 @@ test_argparse_opt_callback_parse_int_of_required_val(void)
 	argv[1] = test_strdup("--test-long");
 	argv[2] = test_strdup("100");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test no more parameters. */
@@ -618,14 +618,14 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 10, "Argparse parse expect success!");
 
 	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 10, "Argparse parse expect success!");
 
 	/* test with value. */
@@ -633,13 +633,13 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 	val_saver = 0;
 	argv[1] = test_strdup("--test-long=100");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t=100");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test callback return failed. */
@@ -671,7 +671,7 @@ test_argparse_pos_autosave_parse_int(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("100");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test positional autosave parse failed. */
@@ -738,7 +738,7 @@ test_argparse_pos_callback_parse_int(void)
 	argv[1] = test_strdup("100");
 	argv[2] = test_strdup("200");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret >= 0, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver[1] == 100, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver[2] == 200, "Argparse parse expect success!");
 
@@ -780,7 +780,7 @@ test_argparse_parse_type(void)
 	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_int == 123, "Argparse parse type expect failed!");
 
 	/* test for u8 parsing */
@@ -792,7 +792,7 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u8 = 0;
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U8, &val_u8);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u8 == 123, "Argparse parse type expect failed!");
 
 	/* test for u16 parsing */
@@ -804,7 +804,7 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u16 = 0;
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U16, &val_u16);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u16 == 123, "Argparse parse type expect failed!");
 
 	/* test for u32 parsing */
@@ -816,7 +816,7 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u32 = 0;
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U32, &val_u32);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u32 == 123, "Argparse parse type expect failed!");
 
 	/* test for u64 parsing */
@@ -826,7 +826,7 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u64 = 0;
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U64, &val_u64);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u64 == 123, "Argparse parse type expect failed!");
 
 	/* test for string parsing - all it does is save string, so all are valid */
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 523d69c854..608526f021 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -109,6 +109,15 @@ ABI Changes
 
 * No ABI change that would break compatibility with 24.11.
 
+* argparse: The experimental "argparse" library has had the following updates:
+   * The main parsing function, ``rte_argparse_parse()``,
+     now returns the number of arguments parsed on success, rather than zero.
+     It still returns a negative value on error.
+   * When parsing a list of arguments,
+     ``rte_argparse_parse()`` stops processing arguments when a ``--`` argument is encountered.
+     This behaviour mirrors the behaviour of the ``getopt()`` function,
+     as well as the behaviour of ``rte_eal_init()`` function.
+
 
 Known Issues
 ------------
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index af2ca7e455..bb03cdc4af 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -605,6 +605,12 @@ parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
 
 	for (i = 1; i < argc; i++) {
 		curr_argv = argv[i];
+
+		if (strcmp(argv[i], "--") == 0) {
+			i++;
+			break;
+		}
+
 		if (curr_argv[0] != '-') {
 			/* process positional parameters. */
 			position_index++;
@@ -668,7 +674,7 @@ parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
 		arg->flags |= ARG_ATTR_FLAG_PARSED_MASK;
 	}
 
-	return 0;
+	return i;
 }
 
 static uint32_t
@@ -784,7 +790,7 @@ rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
 		goto error;
 
 	ret = parse_args(obj, argc, argv, &show_help);
-	if (ret != 0)
+	if (ret < 0)
 		goto error;
 
 	if (show_help) {
@@ -792,7 +798,7 @@ rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
 		exit(0);
 	}
 
-	return 0;
+	return ret;
 
 error:
 	if (obj->exit_on_error)
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 332184302e..8cdb3195cb 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -183,7 +183,8 @@ struct rte_argparse {
  *   Array of parameters points.
  *
  * @return
- *   0 on success. Otherwise negative value is returned.
+ *   number of arguments parsed (>= 0) on success.
+ *   Otherwise negative error code is returned.
  */
 __rte_experimental
 int rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv);
-- 
2.48.1

