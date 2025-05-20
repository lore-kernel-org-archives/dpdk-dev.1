Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F588C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 16:41:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C7A240B9F;
	Tue, 20 May 2025 18:40:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id A2B7F40BA6
 for <dev@dpdk.org>; Tue, 20 May 2025 18:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747759247; x=1779295247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ekoR4NHYNKrL8QUOoBqVsCgm7QkwLFpIkmDBLmxBz+8=;
 b=B+dnkFfc3kQh83i+4UAoFsqmsEF9CAjXSLSLrPQBF+quL0VGb+GR6sUA
 +5qb/A/pDHeWQq2zbwk0CvoLZ4RYgwW+/7E2eEkfflo2bjmL7zIX53vH8
 o+xQP6qMtwwEA4iKhyJqNW5VLmrFK2qI0Bs5R4B16gsIDXeiGKzj5ykuK
 T8c1fNbg2F8tyTqPPcUOeSQWp2oqWAhz0F8TtlnlG/29mXJEUL8XyVtMh
 3NDURx4Mn2okxWcWMhubolLKYfM2BrCL/Hra5E4/RGO+fuMr0nQbsa2yp
 jZ2UZlQ8/JnTuLX6OdYKcENnPuazAcUjab4aR6UFqCL6dZcpuLQpM0v9T w==;
X-CSE-ConnectionGUID: 4iGhNy6USr+9RJH8QXl0Sg==
X-CSE-MsgGUID: WeS0wVb2QpuaTjvPJ84SLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37320470"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="37320470"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 09:40:46 -0700
X-CSE-ConnectionGUID: 34K5KVCFRBid36kx8yD04g==
X-CSE-MsgGUID: AMlT9T5jTZmGf+iqZdtsGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="170759479"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by fmviesa001.fm.intel.com with ESMTP; 20 May 2025 09:40:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [RFC PATCH 3/7] argparse: make argparse EAL-args compatible
Date: Tue, 20 May 2025 17:40:20 +0100
Message-ID: <20250520164025.2055721-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520164025.2055721-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
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
 app/test/test_argparse.c    | 46 ++++++++++++++++++-------------------
 lib/argparse/rte_argparse.c | 12 +++++++---
 lib/argparse/rte_argparse.h |  3 ++-
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index fcea620501..77bace5a39 100644
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
 
@@ -774,7 +774,7 @@ test_argparse_parse_type(void)
 	ret = rte_argparse_parse_type(str_invalid, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_INT, &val_int);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_int == 123, "Argparse parse type expect failed!");
 
 	/* test for u8 parsing */
@@ -786,7 +786,7 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u8 = 0;
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U8, &val_u8);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u8 == 123, "Argparse parse type expect failed!");
 
 	/* test for u16 parsing */
@@ -798,7 +798,7 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u16 = 0;
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U16, &val_u16);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u16 == 123, "Argparse parse type expect failed!");
 
 	/* test for u32 parsing */
@@ -810,7 +810,7 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u32 = 0;
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U32, &val_u32);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u32 == 123, "Argparse parse type expect failed!");
 
 	/* test for u64 parsing */
@@ -820,7 +820,7 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret != 0, "Argparse parse type expect failed!");
 	val_u64 = 0;
 	ret = rte_argparse_parse_type(str_ok, RTE_ARGPARSE_ARG_VALUE_U64, &val_u64);
-	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
+	TEST_ASSERT(ret >= 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u64 == 123, "Argparse parse type expect failed!");
 
 	return 0;
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 1cc06b550b..d8f964dc3c 100644
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

