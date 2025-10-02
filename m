Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4081FCCD182
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 771AA40E34;
	Thu,  2 Oct 2025 19:43:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 515DD40E31
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427011; x=1790963011;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cTNlCNSnUeJ9wvWlGYXkJ4nrT7mmRkqTxlbZZ2bxIII=;
 b=Zo/qJVAXAPY4+2Y8ADBaNK8QoZIeojm6hl4oNPll0lbSTIOiR8LDzMIj
 4exg0qcTW1tbRhZo8vdNu7f0gCPrHKZLBAKlFSiRaZh5z9v8rHczxmj7Z
 uRkuRhbbxSlmXqWNfFBMS+y/24zb9ExP2ElGz4LznFx3X0Aqu3PtY/zjx
 WLwVsphog9clMjiZXeXlM1yQpEvtOBDDdTVKoX70KRF7jcnGXdWfwPund
 GR89WoKO7el4EZABlZnITBpfKfz5m2cJHhIcRyjZ3zv714ZW3YeT9dK/p
 MVCmEWq7qrSPuY6cnTH3O6IWC2DXJKqPQ1WHaWzEqYizWB1XpjP5I45jF w==;
X-CSE-ConnectionGUID: o+DTffn2TBOZjYn/X1sAAw==
X-CSE-MsgGUID: 8QHuNRMSSkO1F5CVbXEhmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271846"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271846"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:30 -0700
X-CSE-ConnectionGUID: Gb9TeQD1TJWEqnxglLnSCg==
X-CSE-MsgGUID: T3e6LL5HQZuPQ/BfVyoz3A==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 05/18] argparse: add support for parsing core lists
Date: Thu,  2 Oct 2025 18:43:02 +0100
Message-ID: <20251002174315.962992-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251002174315.962992-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
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

Core lists are widely used in DPDK, so add support for parsing them.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_argparse.c               | 188 +++++++++++++++++++++++++
 doc/guides/prog_guide/argparse_lib.rst |  32 +++++
 lib/argparse/rte_argparse.c            |  63 +++++++++
 lib/argparse/rte_argparse.h            |   2 +
 4 files changed, 285 insertions(+)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 0a229752fa..c829ea75e4 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -6,6 +6,7 @@
 #include <string.h>
 
 #include <rte_argparse.h>
+#include <rte_os.h>
 
 #include "test.h"
 
@@ -500,6 +501,40 @@ test_argparse_opt_autosave_parse_int_of_optional_val(void)
 	return 0;
 }
 
+static int
+test_argparse_opt_parse_corelist_of_required_val(void)
+{
+	struct rte_argparse *obj;
+	rte_cpuset_t val_cpuset;
+	char *argv[3];
+	int ret;
+
+	/* test with long option and single core - this is known to work */
+	obj = test_argparse_init_obj();
+	obj->args[0].name_long = "--corelist";
+	obj->args[0].name_short = "-c";
+	obj->args[0].val_saver = (void *)&val_cpuset;
+	obj->args[0].val_set = NULL;
+	obj->args[0].value_required = RTE_ARGPARSE_VALUE_REQUIRED;
+	obj->args[0].value_type = RTE_ARGPARSE_VALUE_TYPE_CORELIST;
+	obj->args[1].name_long = NULL;
+	argv[0] = test_strdup(obj->prog_name);
+	argv[1] = test_strdup("--corelist");
+	argv[2] = test_strdup("1,3-5");
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse(obj, 3, argv);
+	TEST_ASSERT(ret == 3, "Argparse parse expect success!");
+	TEST_ASSERT(!CPU_ISSET(0, &val_cpuset), "Core 0 should not be set in corelist!");
+	TEST_ASSERT(CPU_ISSET(1, &val_cpuset), "Core 1 should be set in corelist!");
+	TEST_ASSERT(!CPU_ISSET(2, &val_cpuset), "Core 2 should not be set in corelist!");
+	TEST_ASSERT(CPU_ISSET(3, &val_cpuset), "Core 3 should be set in corelist!");
+	TEST_ASSERT(CPU_ISSET(4, &val_cpuset), "Core 4 should be set in corelist!");
+	TEST_ASSERT(CPU_ISSET(5, &val_cpuset), "Core 5 should be set in corelist!");
+	TEST_ASSERT(!CPU_ISSET(6, &val_cpuset), "Core 6 should not be set in corelist!");
+
+	return 0;
+}
+
 static int
 opt_callback_parse_int_of_no_val(uint32_t index, const char *value, void *opaque)
 {
@@ -782,6 +817,152 @@ test_argparse_pos_callback_parse_int(void)
 	return 0;
 }
 
+static int
+test_argparse_parse_type_corelist(void)
+{
+	char *corelist_valid_single = test_strdup("5");
+	char *corelist_valid_multiple = test_strdup("0,1,5");
+	char *corelist_valid_range = test_strdup("1-5");
+	char *corelist_valid_mixed = test_strdup("0,1,5-10,12-16,18,20");
+	char *corelist_valid_reverse_range = test_strdup("10-5");
+	char *corelist_valid_initial_spaces = test_strdup("   1,2,5-7");
+	char *corelist_valid_empty = test_strdup("");
+	char *corelist_invalid_spaces = test_strdup(" 1 , 2 , 5-7 ");
+	char *corelist_invalid_letters = test_strdup("1,a,3");
+	char *corelist_invalid_range_incomplete = test_strdup("1-");
+	char *corelist_invalid_range_double_dash = test_strdup("1--5");
+	char *corelist_invalid_special_chars = test_strdup("1,2@3");
+	char *corelist_invalid_comma_only = test_strdup(",");
+	char *corelist_invalid_out_of_range = test_strdup("70000");
+	rte_cpuset_t val_cpuset;
+	int ret;
+
+	/* test valid single core */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_single,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (single core) failed!");
+	TEST_ASSERT(CPU_ISSET(5, &val_cpuset), "Core 5 should be set in corelist!");
+	TEST_ASSERT(!CPU_ISSET(0, &val_cpuset), "Core 0 should not be set in corelist!");
+	TEST_ASSERT(!CPU_ISSET(1, &val_cpuset), "Core 1 should not be set in corelist!");
+
+	/* test valid multiple cores */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_multiple,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (multiple cores) failed!");
+	TEST_ASSERT(CPU_ISSET(0, &val_cpuset), "Core 0 should be set in corelist!");
+	TEST_ASSERT(CPU_ISSET(1, &val_cpuset), "Core 1 should be set in corelist!");
+	TEST_ASSERT(CPU_ISSET(5, &val_cpuset), "Core 5 should be set in corelist!");
+	TEST_ASSERT(!CPU_ISSET(2, &val_cpuset), "Core 2 should not be set in corelist!");
+	TEST_ASSERT(!CPU_ISSET(3, &val_cpuset), "Core 3 should not be set in corelist!");
+
+	/* test valid range */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_range,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (range) failed!");
+	for (int i = 1; i <= 5; i++)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset), "Core %d should be set in range 1-5!", i);
+	TEST_ASSERT(!CPU_ISSET(0, &val_cpuset), "Core 0 should not be set in range 1-5!");
+	TEST_ASSERT(!CPU_ISSET(6, &val_cpuset), "Core 6 should not be set in range 1-5!");
+
+	/* test valid mixed corelist */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_mixed,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (mixed) failed!");
+	TEST_ASSERT(CPU_ISSET(0, &val_cpuset), "Core 0 should be set in mixed corelist!");
+	TEST_ASSERT(CPU_ISSET(1, &val_cpuset), "Core 1 should be set in mixed corelist!");
+	for (int i = 5; i <= 10; i++)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset), "Core %d should be set in range 5-10!", i);
+	for (int i = 12; i <= 16; i++)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset), "Core %d should be set in range 12-16!", i);
+
+	TEST_ASSERT(CPU_ISSET(18, &val_cpuset), "Core 18 should be set in mixed corelist!");
+	TEST_ASSERT(CPU_ISSET(20, &val_cpuset), "Core 20 should be set in mixed corelist!");
+	TEST_ASSERT(!CPU_ISSET(2, &val_cpuset), "Core 2 should not be set in mixed corelist!");
+	TEST_ASSERT(!CPU_ISSET(11, &val_cpuset), "Core 11 should not be set in mixed corelist!");
+	TEST_ASSERT(!CPU_ISSET(17, &val_cpuset), "Core 17 should not be set in mixed corelist!");
+	TEST_ASSERT(!CPU_ISSET(19, &val_cpuset), "Core 19 should not be set in mixed corelist!");
+
+	/* test valid reverse range (10-5 should be interpreted as 5-10) */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_reverse_range,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (reverse range) failed!");
+	for (int i = 5; i <= 10; i++)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset),
+				"Core %d should be set in reverse range 10-5!", i);
+	TEST_ASSERT(!CPU_ISSET(4, &val_cpuset), "Core 4 should not be set in reverse range 10-5!");
+	TEST_ASSERT(!CPU_ISSET(11, &val_cpuset), "Core 11 should not be set in reverse range 10-5!");
+
+	/* test valid corelist with initial spaces only */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_initial_spaces,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (with initial spaces) failed!");
+	TEST_ASSERT(CPU_ISSET(1, &val_cpuset), "Core 1 should be set in initial spaced corelist!");
+	TEST_ASSERT(CPU_ISSET(2, &val_cpuset), "Core 2 should be set in initial spaced corelist!");
+	for (int i = 5; i <= 7; i++)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset),
+				"Core %d should be set in initial spaced range 5-7!", i);
+
+	/* test valid empty corelist */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_empty,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (empty) failed!");
+	/* Verify that no cores are set in empty corelist */
+	for (int i = 0; i < CPU_SETSIZE; i++)
+		TEST_ASSERT(!CPU_ISSET(i, &val_cpuset),
+				"Core %d should not be set in empty corelist!", i);
+
+	/* test invalid corelist with spaces */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_spaces,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (with spaces) should have failed!");
+
+	/* test invalid corelist with letters */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_letters,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (with letters) should have failed!");
+
+	/* test invalid corelist with incomplete range */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_incomplete,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (incomplete range) should have failed!");
+
+	/* test invalid corelist with double dash */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_double_dash,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (double dash) should have failed!");
+
+	/* test invalid corelist with special characters */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_special_chars,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (special chars) should have failed!");
+
+	/* test invalid comma-only corelist */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_comma_only,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (comma only) should have failed!");
+
+	/* test invalid out-of-range corelist */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_out_of_range,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (out of range) should have failed!");
+
+	return 0;
+}
+
 static int
 test_argparse_parse_type(void)
 {
@@ -880,6 +1061,12 @@ test_argparse_parse_type(void)
 	ret = rte_argparse_parse_type(bool_numeric_invalid, RTE_ARGPARSE_VALUE_TYPE_BOOL,
 			&val_bool);
 	TEST_ASSERT(ret != 0, "Argparse parse type for bool (numeric invalid) passed unexpectedly!");
+
+	/* test for corelist parsing */
+	ret = test_argparse_parse_type_corelist();
+	if (ret != 0)
+		return ret;
+
 	return 0;
 }
 
@@ -900,6 +1087,7 @@ static struct unit_test_suite argparse_test_suite = {
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_no_val),
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_required_val),
 		TEST_CASE(test_argparse_opt_autosave_parse_int_of_optional_val),
+		TEST_CASE(test_argparse_opt_parse_corelist_of_required_val),
 		TEST_CASE(test_argparse_opt_callback_parse_int_of_no_val),
 		TEST_CASE(test_argparse_opt_callback_parse_int_of_required_val),
 		TEST_CASE(test_argparse_opt_callback_parse_int_of_optional_val),
diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
index 7868af5672..7882d910ab 100644
--- a/doc/guides/prog_guide/argparse_lib.rst
+++ b/doc/guides/prog_guide/argparse_lib.rst
@@ -229,6 +229,38 @@ Boolean arguments are parsed using ``RTE_ARGPARSE_VALUE_TYPE_BOOL`` and accept t
       },
    };
 
+Corelist Type
+^^^^^^^^^^^^^
+
+The argparse library supports automatic parsing of CPU core lists using the
+``RTE_ARGPARSE_VALUE_TYPE_CORELIST`` value type. This feature allows users to
+specify CPU cores in a flexible format similar to other DPDK applications.
+
+.. code-block:: C
+
+   #include <rte_os.h>  /* for CPU set operations */
+
+   static rte_cpuset_t cores;
+
+   static struct rte_argparse obj = {
+      .args = {
+         { "--cores", "-c", "CPU cores to use", &cores, NULL, RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_CORELIST },
+         ARGPARSE_ARG_END(),
+      },
+   };
+
+The corelist parsing supports the following input formats:
+
+- **Single core**: ``--cores 5`` (sets core 5)
+- **Multiple cores**: ``--cores 1,2,5`` (sets cores 1, 2, and 5)
+- **Core ranges**: ``--cores 1-5`` (sets cores 1, 2, 3, 4, and 5)
+- **Mixed format**: ``--cores 0,2-4,7`` (sets cores 0, 2, 3, 4, and 7)
+- **Reverse ranges**: ``--cores 5-1`` (equivalent to 1-5, sets cores 1, 2, 3, 4, and 5)
+- **Empty corelist**: ``--cores ""`` (sets no cores)
+
+The parsed result is stored in an ``rte_cpuset_t`` structure that can be used
+with standard CPU set operations:
+
 Parsing by callback way
 ~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 2b5da5f1db..e4851bd046 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -5,9 +5,11 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
+#include <rte_os.h>
 
 #include "rte_argparse.h"
 
@@ -53,6 +55,7 @@ is_valid_value_type_field(const struct rte_argparse_arg *arg)
 	case RTE_ARGPARSE_VALUE_TYPE_U64:
 	case RTE_ARGPARSE_VALUE_TYPE_STR:
 	case RTE_ARGPARSE_VALUE_TYPE_BOOL:
+	case RTE_ARGPARSE_VALUE_TYPE_CORELIST:
 		return true;
 	/* omit default case so compiler warns on any missing enum values */
 	}
@@ -554,6 +557,64 @@ parse_arg_bool(const struct rte_argparse_arg *arg, const char *value)
 	return 0;
 }
 
+static int
+parse_arg_corelist(const struct rte_argparse_arg *arg, const char *value)
+{
+	rte_cpuset_t *cpuset = arg->val_saver;
+	const char *last = value;
+	int min = -1;
+
+	if (value == NULL) {
+		*cpuset = *(rte_cpuset_t *)arg->val_set;
+		return 0;
+	}
+
+	CPU_ZERO(cpuset);
+	while (*last != '\0') {
+		char *end;
+		int64_t idx;
+		int32_t max;
+
+		while (isblank(*value))
+			value++;
+
+		if (!isdigit(*value))
+			return -1;
+
+		errno = 0;
+		idx = strtol(value, &end, 10);
+		last = end;
+		if (errno || idx > UINT16_MAX)
+			return -1;
+
+		if (*end == '-') {
+			min = idx; /* start of range, move to next loop stage */
+		} else if (*end == ',' || *end == '\0') {
+			/* single value followed by comma or end (min is set only by '-') */
+			if (min == -1) {
+				min = max = idx;
+			} else if (min > idx) {
+				/* we have range from high to low */
+				max = min;
+				min = idx;
+			} else {
+				/* range from low to high */
+				max = idx;
+			}
+
+			for (; min <= max; min++)
+				CPU_SET(min, cpuset);
+
+			min = -1; /* no longer in a range */
+		} else {
+			/* end is an unexpected character, return error */
+			return -1;
+		}
+		value = last + 1;
+	}
+	return 0;
+}
+
 static int
 parse_arg_autosave(const struct rte_argparse_arg *arg, const char *value)
 {
@@ -575,6 +636,8 @@ parse_arg_autosave(const struct rte_argparse_arg *arg, const char *value)
 		return parse_arg_str(arg, value);
 	case RTE_ARGPARSE_VALUE_TYPE_BOOL:
 		return parse_arg_bool(arg, value);
+	case RTE_ARGPARSE_VALUE_TYPE_CORELIST:
+		return parse_arg_corelist(arg, value);
 	/* omit default case so compiler warns on missing enum values */
 	}
 	return -EINVAL;
diff --git a/lib/argparse/rte_argparse.h b/lib/argparse/rte_argparse.h
index 63b49ba220..991f084927 100644
--- a/lib/argparse/rte_argparse.h
+++ b/lib/argparse/rte_argparse.h
@@ -69,6 +69,8 @@ enum rte_argparse_value_type {
 	RTE_ARGPARSE_VALUE_TYPE_STR,
 	/** The argument's value is boolean flag type. */
 	RTE_ARGPARSE_VALUE_TYPE_BOOL,
+	/** The argument's value is a corelist */
+	RTE_ARGPARSE_VALUE_TYPE_CORELIST,
 };
 
 /** Additional flags which may be specified for each argument */
-- 
2.48.1

