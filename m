Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA71C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 16:31:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C60342F29;
	Tue, 10 Jun 2025 18:31:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D94A842F1D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 18:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749573086; x=1781109086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dkk11D2yLhF6bqWLKlINxleflpBN0HU0+Fnk1Jujzmw=;
 b=ESRQwxo38S/Ui/PEREkiP0yB7Iuv3zla4XGl+ZomG+2qiq/QfieH6K8f
 e868Y6WCnaIQ2GYvGkI6Gq29LXQX2PJoWXYw+V1m2AzC0oV/2/h8nxS4K
 nuTFNidxM3ZKpqG1H+icDM6XKLLpoEOFeJhdnPw9XJFeWv1cwAIiaMW5L
 vSrciib3FnjfoNokWJ63/vYhk1LZeMU4XW5uxh3PM6hXRAs9pqv9aTE6m
 2nDQo3UnEFxjJTerlaqZsnYb4xX+efTv5XJtiy8aoTxITALHcdCqLb5//
 GVMh8Y+vYkzbcYCNMUVygGC5d3mN3pDx6XFPA6J04imN0IOvaiY5DJ4Jg Q==;
X-CSE-ConnectionGUID: XSaGGbUJSHSCClVfWGbzdw==
X-CSE-MsgGUID: gILia0onQZGIdQIG/AoNyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63101393"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="63101393"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 09:31:25 -0700
X-CSE-ConnectionGUID: czIrzkyqTAuuAHsKMoLy9Q==
X-CSE-MsgGUID: imAOM0sKSW+uEN99wrGMJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="146868457"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.33])
 by orviesa009.jf.intel.com with ESMTP; 10 Jun 2025 09:31:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 2/3] argparse: make argparse EAL-args compatible
Date: Tue, 10 Jun 2025 17:29:37 +0100
Message-ID: <20250610163109.111651-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250610163109.111651-1-bruce.richardson@intel.com>
References: <20250527092113.903910-1-bruce.richardson@intel.com>
 <20250610163109.111651-1-bruce.richardson@intel.com>
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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_argparse.c               | 36 +++++++++++++-------------
 doc/guides/rel_notes/release_25_07.rst |  9 +++++++
 lib/argparse/rte_argparse.c            | 12 ++++++---
 lib/argparse/rte_argparse.h            |  6 +++--
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 6b0d1524b5..382b6250b3 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -360,14 +360,14 @@ test_argparse_opt_autosave_parse_int_of_no_val(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	obj->args[0].flags = flags;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	return 0;
@@ -393,14 +393,14 @@ test_argparse_opt_autosave_parse_int_of_required_val(void)
 	argv[1] = test_strdup("--test-long");
 	argv[2] = test_strdup("100");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 3, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	obj->args[0].flags = flags;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 3, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test invalid value. */
@@ -434,13 +434,13 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 	obj->args[0].flags = flags;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test with value. */
@@ -448,13 +448,13 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 	val_saver = 0;
 	argv[1] = test_strdup("--test-long=200");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 200, "Argparse parse expect success!");
 	obj->args[0].flags = flags;
 	val_saver = 0;
 	argv[1] = test_strdup("-t=200");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 200, "Argparse parse expect success!");
 
 	/* test with option value, but with wrong value. */
@@ -503,14 +503,14 @@ test_argparse_opt_callback_parse_int_of_no_val(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	obj->args[0].flags = RTE_ARGPARSE_ARG_NO_VALUE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	return 0;
@@ -555,14 +555,14 @@ test_argparse_opt_callback_parse_int_of_required_val(void)
 	argv[1] = test_strdup("--test-long");
 	argv[2] = test_strdup("100");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 3, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	obj->args[0].flags = RTE_ARGPARSE_ARG_REQUIRED_VALUE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 3, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test no more parameters. */
@@ -618,14 +618,14 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("--test-long");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 10, "Argparse parse expect success!");
 
 	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 10, "Argparse parse expect success!");
 
 	/* test with value. */
@@ -633,13 +633,13 @@ test_argparse_opt_callback_parse_int_of_optional_val(void)
 	val_saver = 0;
 	argv[1] = test_strdup("--test-long=100");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 	obj->args[0].flags = RTE_ARGPARSE_ARG_OPTIONAL_VALUE;
 	val_saver = 0;
 	argv[1] = test_strdup("-t=100");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test callback return failed. */
@@ -671,7 +671,7 @@ test_argparse_pos_autosave_parse_int(void)
 	argv[0] = test_strdup(obj->prog_name);
 	argv[1] = test_strdup("100");
 	ret = rte_argparse_parse(obj, 2, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 2, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver == 100, "Argparse parse expect success!");
 
 	/* test positional autosave parse failed. */
@@ -738,7 +738,7 @@ test_argparse_pos_callback_parse_int(void)
 	argv[1] = test_strdup("100");
 	argv[2] = test_strdup("200");
 	ret = rte_argparse_parse(obj, 3, argv);
-	TEST_ASSERT(ret == 0, "Argparse parse expect success!");
+	TEST_ASSERT(ret == 3, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver[1] == 100, "Argparse parse expect success!");
 	TEST_ASSERT(val_saver[2] == 200, "Argparse parse expect success!");
 
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 68f56347da..a420cef248 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -170,6 +170,15 @@ ABI Changes
 
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
index 49485861e3..13a3f4d9eb 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -606,6 +606,12 @@ parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
 
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
@@ -669,7 +675,7 @@ parse_args(struct rte_argparse *obj, int argc, char **argv, bool *show_help)
 		arg->flags |= ARG_ATTR_FLAG_PARSED_MASK;
 	}
 
-	return 0;
+	return i;
 }
 
 static uint32_t
@@ -785,7 +791,7 @@ rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
 		goto error;
 
 	ret = parse_args(obj, argc, argv, &show_help);
-	if (ret != 0)
+	if (ret < 0)
 		goto error;
 
 	if (show_help) {
@@ -793,7 +799,7 @@ rte_argparse_parse(struct rte_argparse *obj, int argc, char **argv)
 		exit(0);
 	}
 
-	return 0;
+	return ret;
 
 error:
 	if (obj->exit_on_error)
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 332184302e..fd5c33b319 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -173,7 +173,8 @@ struct rte_argparse {
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
  *
- * Parse parameters.
+ * Parse parameters passed until all are processed,
+ * or until a "--" parameter is encountered.
  *
  * @param obj
  *   Parser object.
@@ -183,7 +184,8 @@ struct rte_argparse {
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

