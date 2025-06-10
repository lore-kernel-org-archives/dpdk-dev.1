Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18375C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 16:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2F7F42F11;
	Tue, 10 Jun 2025 18:31:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3323042EAD
 for <dev@dpdk.org>; Tue, 10 Jun 2025 18:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749573083; x=1781109083;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x5TLknhPV8YZ/f3PEm3bngxLuIj3vHHYOcs147ISdHU=;
 b=nkemxL9+/F9A45UiqA6tj59BiErHol9RuIEZkLv59uoGZ/wvqqnML7Hv
 ymMSxxpi3MwNFKd+LDNF6yjZncJR7tv9i2uWvRWSG7+CpEtkz+rZk0+ba
 nXjyy6a2kSEh8iyMn15pYuARVhGwHo7RfL8bbv67HIOy/OzO7Q6S6Syg5
 cWXc+k223Nr7l4hvIdZMGRDgPJwvgBXmLTwqaU2e9KaQ+IVVOYFz73IK9
 gp7q07amair7Fd5qF8aF3NEts0+KQWuGb6yQ0WOBqqlTc5FhvHdKRyhEe
 qb3Jki9Fs8OJupBCy9GwEKR2PS5wYvtqYDRgbh1OgzRkYXR9Cj1bhrBgl Q==;
X-CSE-ConnectionGUID: cyd35WnCRgiXwQyCF7du5A==
X-CSE-MsgGUID: ttJUPgxmQd6ysHhpF0TVtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63101385"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="63101385"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 09:31:23 -0700
X-CSE-ConnectionGUID: VbdrMrZjS4SUlSqIcWo67A==
X-CSE-MsgGUID: /5Gf2CB2TDq2pfojabk2rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="146868451"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.33])
 by orviesa009.jf.intel.com with ESMTP; 10 Jun 2025 09:31:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 1/3] argparse: add support for string and boolean args
Date: Tue, 10 Jun 2025 17:29:36 +0100
Message-ID: <20250610163109.111651-2-bruce.richardson@intel.com>
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

Sometimes we don't want to parse the string at all, when doing arg
parsing, and just save it off for later. Add support for that.

Also, rather than assuming boolean values have to be the same size as
uint8 (or some other size), add an explicitly type for that - which also
allows checking for true/false and 0/1 values explicitly.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_argparse.c               | 25 ++++++++++++++++++
 doc/guides/rel_notes/release_25_07.rst |  6 +++++
 lib/argparse/rte_argparse.c            | 35 ++++++++++++++++++++++++++
 lib/argparse/rte_argparse.h            |  6 ++++-
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index fcea620501..6b0d1524b5 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -761,6 +761,12 @@ test_argparse_parse_type(void)
 	char *str_erange_u8 = test_strdup("256");
 	char *str_invalid = test_strdup("1a");
 	char *str_ok = test_strdup("123");
+	char *bool_true = test_strdup("true");
+	char *bool_false = test_strdup("false");
+	char *bool_invalid = test_strdup("invalid");
+	char *bool_numeric_true = test_strdup("1");
+	char *bool_numeric_false = test_strdup("0");
+	char *bool_numeric_invalid = test_strdup("2");
 	uint16_t val_u16;
 	uint32_t val_u32;
 	uint64_t val_u64;
@@ -823,6 +829,25 @@ test_argparse_parse_type(void)
 	TEST_ASSERT(ret == 0, "Argparse parse type expect failed!");
 	TEST_ASSERT(val_u64 == 123, "Argparse parse type expect failed!");
 
+	/* test for string parsing - all it does is save string, so all are valid */
+	const char *val_str;
+	ret = rte_argparse_parse_type(str_erange, RTE_ARGPARSE_ARG_VALUE_STR, &val_str);
+	TEST_ASSERT(ret == 0, "Argparse parse a string failed unexpectedly!");
+
+	/* test for boolean parsing */
+	bool val_bool = false;
+	ret = rte_argparse_parse_type(bool_true, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	TEST_ASSERT(ret == 0 && val_bool == true, "Argparse parse type for bool (true) failed!");
+	ret = rte_argparse_parse_type(bool_false, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	TEST_ASSERT(ret == 0 && val_bool == false, "Argparse parse type for bool (false) failed!");
+	ret = rte_argparse_parse_type(bool_invalid, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	TEST_ASSERT(ret != 0, "Argparse parse type for bool (invalid) passed unexpectedly!");
+	ret = rte_argparse_parse_type(bool_numeric_true, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	TEST_ASSERT(ret == 0 && val_bool == true, "Argparse parse type for bool (numeric true) failed!");
+	ret = rte_argparse_parse_type(bool_numeric_false, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	TEST_ASSERT(ret == 0 && val_bool == false, "Argparse parse type for bool (numeric false) failed!");
+	ret = rte_argparse_parse_type(bool_numeric_invalid, RTE_ARGPARSE_ARG_VALUE_BOOL, &val_bool);
+	TEST_ASSERT(ret != 0, "Argparse parse type for bool (numeric invalid) passed unexpectedly!");
 	return 0;
 }
 
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index a5b353d342..68f56347da 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -113,6 +113,12 @@ New Features
   See the :doc:`../prog_guide/eventdev/event_vector_adapter` guide
   for more details on the new library.
 
+* **Added support for string and boolean types to the "argparse" library.**
+
+  The "argparse" library now supports parsing of string and boolean types.
+  String values are simply saved as-is,
+  while the boolean support allows for values "true", "false", "1" or "0".
+
 
 Removed Items
 -------------
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 18290e0c38..49485861e3 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -508,6 +508,39 @@ parse_arg_u64(struct rte_argparse_arg *arg, const char *value)
 	return 0;
 }
 
+static int
+parse_arg_str(struct rte_argparse_arg *arg, const char *value)
+{
+	if (value == NULL) {
+		*(char **)arg->val_saver = arg->val_set;
+		return 0;
+	}
+	*(const char **)arg->val_saver = value;
+
+	return 0;
+}
+
+static int
+parse_arg_bool(struct rte_argparse_arg *arg, const char *value)
+{
+	if (value == NULL) {
+		*(bool *)arg->val_saver = (arg->val_set != NULL);
+		return 0;
+	}
+
+	if (strcmp(value, "true") == 0 || strcmp(value, "1") == 0)
+		*(bool *)arg->val_saver = true;
+	else if (strcmp(value, "false") == 0 || strcmp(value, "0") == 0)
+		*(bool *)arg->val_saver = false;
+	else {
+		ARGPARSE_LOG(ERR, "argument %s expects a boolean (true/false, 0/1) value!",
+			arg->name_long);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 parse_arg_autosave(struct rte_argparse_arg *arg, const char *value)
 {
@@ -521,6 +554,8 @@ parse_arg_autosave(struct rte_argparse_arg *arg, const char *value)
 		{ parse_arg_u16 },
 		{ parse_arg_u32 },
 		{ parse_arg_u64 },
+		{ parse_arg_str},
+		{ parse_arg_bool },
 	};
 	uint32_t index = arg_attr_val_type(arg);
 	int ret = -EINVAL;
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index d0cfaa1e4c..332184302e 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -60,8 +60,12 @@ extern "C" {
 #define RTE_ARGPARSE_ARG_VALUE_U32      RTE_SHIFT_VAL64(4, 2)
 /** The argument's value is uint64 type. */
 #define RTE_ARGPARSE_ARG_VALUE_U64      RTE_SHIFT_VAL64(5, 2)
+/** The argument's value is string type. */
+#define RTE_ARGPARSE_ARG_VALUE_STR      RTE_SHIFT_VAL64(6, 2)
+/** The argument's value is boolean flag type. */
+#define RTE_ARGPARSE_ARG_VALUE_BOOL     RTE_SHIFT_VAL64(7, 2)
 /** Max value type. */
-#define RTE_ARGPARSE_ARG_VALUE_MAX      RTE_SHIFT_VAL64(6, 2)
+#define RTE_ARGPARSE_ARG_VALUE_MAX      RTE_SHIFT_VAL64(8, 2)
 /**
  * Flag for that argument support occur multiple times.
  * This flag can be set only when the argument is optional.
-- 
2.48.1

