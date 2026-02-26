Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6636EFD8FD7
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78CC14065E;
	Thu, 26 Feb 2026 17:44:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A45D6402E4
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772124295; x=1803660295;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1dKfaXh7H7ozAb0dYqQrpFvSoWRb3vQu9ptibGtmdb4=;
 b=VTG/6qDqYJw5W2PXyIt6jgSYAXqAijp2uFnuF0o0vMYmscpqVKXO0PUd
 tb8pUffOdAJc+i0HYeVZVsvPXvz49yASuKvrtvJSYSUVNs6eLdr8OW3Wo
 Tv7WNqWG8kq4G433bSFSUyWsCVZk7Ity2EHzeYvwiujHvfQadXyB1Ua7V
 P9M+JiefKXoyIF2WEJGUQpoNau3zDG0oZiCBvwLgzkdUMeui9yiNTdNcj
 imX+Ptj3J4m5kNgyfoeDRZrkKOmSX+gZjm1wBfCY4NXsFAk3B5iuGT60b
 u9MiGcj5qbo3Qd4dSwbnguQ2B07eT2rIPLiXiezetPw0QI9gVAhoJ7MqJ g==;
X-CSE-ConnectionGUID: G6zOn1FFQOWnpAXvX/e3ag==
X-CSE-MsgGUID: D6fWdCX2SmedozkgCuT/LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73375861"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73375861"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:44:54 -0800
X-CSE-ConnectionGUID: 4wECJxtJRoqL8+Mm3hmc8w==
X-CSE-MsgGUID: XewshfsRSnyCngThgrdSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216523509"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 26 Feb 2026 08:44:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v12 2/3] cmdline: add floating point support
Date: Thu, 26 Feb 2026 16:44:49 +0000
Message-ID: <162c8c5bbecaafc97e698196e57b7835d794a83c.1772124281.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
References: 
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

Add support for parsing floating point numbers in cmdline library, as well
as unit tests for the new functionality. Use C library for parsing.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v10 -> v11:
    - Fixed all checkpatch warnings
    
    v7 -> v8:
    - Fixed leftover comment about needing bigger epsilon value
    - Fixed debug prints to avoid indexing num_help[] array
    
    v6 -> v7:
    - Fixed a bug in float compare in unit tests where a bigger epsilon
      value than necessary was "needed" because we were comparing float
      result to a double result
    
    v5 -> v6:
    - Small refactor to reduce amount of noise
    - Use strtof for parsing single precision floats
    - More unit tests
    
    v4 -> v5:
    - Reworked to use standard C library functions as much as possible,
      keeping near-100% compatibility with earlier versions (the only
      difference is that strings like "+4" are now considered valid)
    
    v3 -> v4:
    - Removed unnecessary check for integer overflow when parsing negative
      floats (as we convert to double before changing sign)
    - Make naming of float exponent states more consistent
    
    v2 -> v3:
    - Fixed a bug where a free-standing negative exponent ("1e-") would attempt to be
      parsed, and added unit tests for this case
    - Added support for floats in dpdk-cmdline-gen script
    - Added documentation updates to call out float support

 app/test/test_cmdline_num.c            | 287 ++++++++++++++++++++++++-
 buildtools/dpdk-cmdline-gen.py         |  24 ++-
 doc/guides/prog_guide/cmdline.rst      |   3 +
 doc/guides/rel_notes/release_26_03.rst |   5 +
 lib/cmdline/cmdline_parse_num.c        |  68 +++++-
 lib/cmdline/cmdline_parse_num.h        |   4 +-
 6 files changed, 372 insertions(+), 19 deletions(-)

diff --git a/app/test/test_cmdline_num.c b/app/test/test_cmdline_num.c
index 100c564188..a1142dab69 100644
--- a/app/test/test_cmdline_num.c
+++ b/app/test/test_cmdline_num.c
@@ -5,6 +5,8 @@
 #include <stdio.h>
 #include <string.h>
 #include <inttypes.h>
+#include <float.h>
+#include <math.h>
 
 #include <rte_string_fns.h>
 
@@ -23,6 +25,11 @@ struct num_signed_str {
 	int64_t result;
 };
 
+struct num_float_str {
+	const char *str;
+	double result;
+};
+
 const struct num_unsigned_str num_valid_positive_strs[] = {
 		/* decimal positive */
 		{"0", 0 },
@@ -144,6 +151,63 @@ const struct num_signed_str num_valid_negative_strs[] = {
 		{"-0b1000000000000000000000000000000000000000000000000000000000000000", INT64_MIN },
 };
 
+const struct num_float_str float_valid_strs[] = {
+		/* zero */
+		{"0", 0},
+		/* parse int as float */
+		{"1", 1},
+		{"-1", -1},
+		/* fractional */
+		{"1.23", 1.23},
+		{"-1.23", -1.23},
+		{"0.123", 0.123},
+		{"-0.123", -0.123},
+		{"123.456", 123.456},
+		{"-123.456", -123.456},
+		/* positive exponent */
+		{"1e2", 1e2},
+		{"-1e2", -1e2},
+		{"1E2", 1E2},
+		{"-1E2", -1E2},
+		{"0.12e3", 0.12e3},
+		{"-0.12e3", -0.12e3},
+		{"1.23e4", 1.23e4},
+		{"-1.23e4", -1.23e4},
+		{"1.23E4", 1.23E4},
+		{"-1.23E4", -1.23E4},
+		{"123.456e7", 123.456e7},
+		{"-123.456e7", -123.456e7},
+		{"123.456E7", 123.456E7},
+		{"-123.456E7", -123.456E7},
+		/* negative exponent */
+		{"1e-2", 1e-2},
+		{"-1e-2", -1e-2},
+		{"1E-2", 1E-2},
+		{"-1E-2", -1E-2},
+		{"0.12e-3", 0.12e-3},
+		{"-0.12e-3", -0.12e-3},
+		{"1.23e-4", 1.23e-4},
+		{"-1.23e-4", -1.23e-4},
+		{"1.23E-4", 1.23E-4},
+		{"-1.23E-4", -1.23E-4},
+		{"123.456e-7", 123.456e-7},
+		{"-123.456e-7", -123.456e-7},
+		{"123.456E-7", 123.456E-7},
+		{"-123.456E-7", -123.456E-7},
+		/* try overflowing float */
+		{"2e63", 2e63},
+		{"-2e63", -2e63},
+		{"2E63", 2E63},
+		{"-2E63", -2E63},
+		{"18446744073709551615", (double) UINT64_MAX},
+		{"-9223372036854775808", (double) INT64_MIN},
+		/* try overflowing double */
+		{"2e308", HUGE_VAL},
+		{"-2e308", -HUGE_VAL},
+		{"2E308", HUGE_VAL},
+		{"-2E308", HUGE_VAL},
+};
+
 const struct num_unsigned_str num_garbage_positive_strs[] = {
 		/* valid strings with garbage on the end, should still be valid */
 		/* decimal */
@@ -214,6 +278,71 @@ const struct num_signed_str num_garbage_negative_strs[] = {
 		{"-01000000000000000000000 garbage", INT64_MIN },
 };
 
+const struct num_float_str float_garbage_strs[] = {
+	/* valid strings with garbage on the end, should still be valid */
+	/* positive float positive exponent */
+	{"123.456e7\0garbage", 123.456e7},
+	{"123.456e7\rgarbage", 123.456e7},
+	{"123.456e7\tgarbage", 123.456e7},
+	{"123.456e7\ngarbage", 123.456e7},
+	{"123.456e7#garbage", 123.456e7},
+	{"123.456e7 garbage", 123.456e7},
+	/* negative float positive exponent */
+	{"-123.456e7\0garbage", -123.456e7},
+	{"-123.456e7\rgarbage", -123.456e7},
+	{"-123.456e7\tgarbage", -123.456e7},
+	{"-123.456e7\ngarbage", -123.456e7},
+	{"-123.456e7#garbage", -123.456e7},
+	{"-123.456e7 garbage", -123.456e7},
+	/* positive float negative exponent */
+	{"123.456e-7\0garbage", 123.456e-7},
+	{"123.456e-7\rgarbage", 123.456e-7},
+	{"123.456e-7\tgarbage", 123.456e-7},
+	{"123.456e-7\ngarbage", 123.456e-7},
+	{"123.456e-7#garbage", 123.456e-7},
+	{"123.456e-7 garbage", 123.456e-7},
+	/* negative float negative exponent */
+	{"-123.456e-7\0garbage", -123.456e-7},
+	{"-123.456e-7\rgarbage", -123.456e-7},
+	{"-123.456e-7\tgarbage", -123.456e-7},
+	{"-123.456e-7\ngarbage", -123.456e-7},
+	{"-123.456e-7#garbage", -123.456e-7},
+	{"-123.456e-7 garbage", -123.456e-7},
+	/* float overflows */
+	{"18446744073709551615\0garbage", (double) UINT64_MAX},
+	{"18446744073709551615\rgarbage", (double) UINT64_MAX},
+	{"18446744073709551615\ngarbage", (double) UINT64_MAX},
+	{"18446744073709551615\tgarbage", (double) UINT64_MAX},
+	{"18446744073709551615#garbage", (double) UINT64_MAX},
+	{"18446744073709551615 garbage", (double) UINT64_MAX},
+	{"-9223372036854775808\0garbage", (double) INT64_MIN},
+	{"-9223372036854775808\rgarbage", (double) INT64_MIN},
+	{"-9223372036854775808\ngarbage", (double) INT64_MIN},
+	{"-9223372036854775808\tgarbage", (double) INT64_MIN},
+	{"-9223372036854775808#garbage", (double) INT64_MIN},
+	{"-9223372036854775808 garbage", (double) INT64_MIN},
+};
+
+const char *float_invalid_strs[] = {
+	"1.1.",
+	"1.1.1",
+	"-1.1.",
+	"-1.1.1",
+	"e",
+	"1e",
+	"-1e",
+	"0.1e",
+	"-0.1e",
+	"1.e",
+	"-1.e",
+	"1.23e3.4",
+	"-1.23e3.4",
+	"1e1e",
+	"1e1e1",
+	"1e-",
+	"-1e-"
+};
+
 const char * num_invalid_strs[] = {
 		"18446744073709551616", /* out of range unsigned */
 		"-9223372036854775809", /* out of range negative signed */
@@ -231,7 +360,16 @@ const char * num_invalid_strs[] = {
 		/* too long (128+ chars) */
 		("0b1111000011110000111100001111000011110000111100001111000011110000"
 		  "1111000011110000111100001111000011110000111100001111000011110000"),
+		/* valid float values but should fail to parse as ints */
 		"1E3",
+		"-1E3",
+		"1.23",
+		"-1.23",
+		"1E-3",
+		"-1E-3",
+		"1.23E4",
+		"-1.23E4",
+		/* misc invalid values */
 		"0A",
 		"-B",
 		"1.23G",
@@ -244,6 +382,48 @@ const char * num_invalid_strs[] = {
 		"\0",
 };
 
+static int
+float_cmp(double expected, void *actual_p, enum cmdline_numtype type)
+{
+	double eps;
+	double actual_d;
+
+	if (type == RTE_FLOAT_SINGLE) {
+		/* read as float, convert to double */
+		actual_d = (double)*(float *)actual_p;
+		/* downcast expected to float as well */
+		expected = (double)(float)expected;
+		eps = FLT_EPSILON;
+	} else {
+		/* read as double */
+		actual_d = *(double *)actual_p;
+		eps = DBL_EPSILON;
+	}
+	/* compare using epsilon value */
+	if (fabs(expected - actual_d) < eps)
+		return 0;
+	/* not equal */
+	return expected < actual_d ? -1 : 1;
+}
+
+static int
+can_parse_float(double expected_result, enum cmdline_numtype type)
+{
+	switch (type) {
+	case RTE_FLOAT_SINGLE:
+		if (expected_result > FLT_MAX || expected_result < -FLT_MAX)
+			return 0;
+		break;
+	case RTE_FLOAT_DOUBLE:
+		if (expected_result > DBL_MAX || expected_result < -DBL_MAX)
+			return 0;
+		break;
+	default:
+		return 1;
+	}
+	return 1;
+}
+
 static int
 can_parse_unsigned(uint64_t expected_result, enum cmdline_numtype type)
 {
@@ -399,11 +579,11 @@ test_parse_num_invalid_data(void)
 	int ret = 0;
 	unsigned i;
 	char buf[CMDLINE_TEST_BUFSIZE];
-	uint64_t result; /* pick largest buffer */
 	cmdline_parse_token_num_t token;
 
-	/* cycle through all possible parsed types */
+	/* cycle through all possible integer types */
 	for (type = RTE_UINT8; type <= RTE_INT64; type++) {
+		uint64_t result; /* pick largest buffer */
 		token.num_data.type = type;
 
 		/* test full strings */
@@ -425,6 +605,30 @@ test_parse_num_invalid_data(void)
 			}
 		}
 	}
+
+	/* cycle through all possible float types */
+	for (type = RTE_FLOAT_SINGLE; type <= RTE_FLOAT_DOUBLE; type++) {
+		double result; /* pick largest buffer */
+		token.num_data.type = type;
+
+		/* test full strings */
+		for (i = 0; i < RTE_DIM(float_invalid_strs); i++) {
+			memset(&result, 0, sizeof(double));
+			memset(&buf, 0, sizeof(buf));
+
+			ret = cmdline_parse_num((cmdline_parse_token_hdr_t *)&token,
+					float_invalid_strs[i], (void *)&result, sizeof(result));
+			if (ret != -1) {
+				/* get some info about what we are trying to parse */
+				cmdline_get_help_num((cmdline_parse_token_hdr_t *)&token,
+						buf, sizeof(buf));
+
+				printf("Error: parsing %s as %s succeeded!\n",
+						float_invalid_strs[i], buf);
+				return -1;
+			}
+		}
+	}
 	return 0;
 }
 
@@ -436,13 +640,13 @@ test_parse_num_valid(void)
 	enum cmdline_numtype type;
 	unsigned i;
 	char buf[CMDLINE_TEST_BUFSIZE];
-	uint64_t result;
 	cmdline_parse_token_num_t token;
 
 	/** valid strings **/
 
-	/* cycle through all possible parsed types */
+	/* cycle through all possible integer types */
 	for (type = RTE_UINT8; type <= RTE_INT64; type++) {
+		uint64_t result;
 		token.num_data.type = type;
 
 		/* test positive strings */
@@ -517,10 +721,48 @@ test_parse_num_valid(void)
 		}
 	}
 
+	/* cycle through all possible float types */
+	for (type = RTE_FLOAT_SINGLE; type <= RTE_FLOAT_DOUBLE; type++) {
+		double result;
+		token.num_data.type = type;
+
+		/* test all valid strings */
+		for (i = 0; i < RTE_DIM(float_valid_strs); i++) {
+			int expected;
+
+			result = 0;
+			memset(&buf, 0, sizeof(buf));
+
+
+			cmdline_get_help_num((cmdline_parse_token_hdr_t *)&token,
+					buf, sizeof(buf));
+
+			ret = cmdline_parse_num((cmdline_parse_token_hdr_t *) &token,
+				float_valid_strs[i].str,
+				(void *)&result, sizeof(result));
+
+			/* should it have failed? */
+			expected = can_parse_float(float_valid_strs[i].result, type);
+			if ((ret < 0) == (expected > 0)) {
+				printf("Error: parser behaves unexpectedly when parsing %s as %s!\n",
+						float_valid_strs[i].str, buf);
+				return -1;
+			}
+			/* check if result matches */
+			expected = float_cmp(float_valid_strs[i].result, &result, type);
+			if (ret > 0 && expected != 0) {
+				printf("Error: parsing %s as %s failed: result mismatch!\n",
+						float_valid_strs[i].str, buf);
+				return -1;
+			}
+		}
+	}
+
 	/** garbage strings **/
 
-	/* cycle through all possible parsed types */
+	/* cycle through all possible integer types */
 	for (type = RTE_UINT8; type <= RTE_INT64; type++) {
+		uint64_t result;
 		token.num_data.type = type;
 
 		/* test positive garbage strings */
@@ -598,6 +840,41 @@ test_parse_num_valid(void)
 		}
 	}
 
+	/* cycle through all possible float types */
+	for (type = RTE_FLOAT_SINGLE; type <= RTE_FLOAT_DOUBLE; type++) {
+		double result;
+		token.num_data.type = type;
+
+		/* test all valid strings */
+		for (i = 0; i < RTE_DIM(float_garbage_strs); i++) {
+			int expected;
+			result = 0;
+			memset(&buf, 0, sizeof(buf));
+
+			cmdline_get_help_num((cmdline_parse_token_hdr_t *)&token,
+					buf, sizeof(buf));
+
+			ret = cmdline_parse_num((cmdline_parse_token_hdr_t *) &token,
+				float_garbage_strs[i].str,
+				(void *)&result, sizeof(result));
+
+			/* should it have failed? */
+			expected = can_parse_float(float_garbage_strs[i].result, type);
+			if ((ret < 0) == (expected > 0)) {
+				printf("Error: parser behaves unexpectedly when parsing %s as %s!\n",
+						float_garbage_strs[i].str, buf);
+				return -1;
+			}
+			/* check if result matches */
+			expected = float_cmp(float_garbage_strs[i].result, &result, type);
+			if (ret > 0 && expected != 0) {
+				printf("Error: parsing %s as %s failed: result mismatch!\n",
+						float_garbage_strs[i].str, buf);
+				return -1;
+			}
+		}
+	}
+
 	memset(&buf, 0, sizeof(buf));
 
 	/* coverage! */
diff --git a/buildtools/dpdk-cmdline-gen.py b/buildtools/dpdk-cmdline-gen.py
index 7dadded783..6c76d7116a 100755
--- a/buildtools/dpdk-cmdline-gen.py
+++ b/buildtools/dpdk-cmdline-gen.py
@@ -17,16 +17,18 @@
     RTE_SET_USED(cl);
     RTE_SET_USED(data);
 """
-NUMERIC_TYPES = [
-    "UINT8",
-    "UINT16",
-    "UINT32",
-    "UINT64",
-    "INT8",
-    "INT16",
-    "INT32",
-    "INT64",
-]
+NUMERIC_TYPES = {
+    "UINT8": "uint8_t",
+    "UINT16": "uint16_t",
+    "UINT32": "uint32_t",
+    "UINT64": "uint64_t",
+    "INT8": "int8_t",
+    "INT16": "int16_t",
+    "INT32": "int32_t",
+    "INT64": "int64_t",
+    "FLOAT_SINGLE": "float",
+    "FLOAT_DOUBLE": "double",
+}
 
 
 def process_command(lineno, tokens, comment):
@@ -70,7 +72,7 @@ def process_command(lineno, tokens, comment):
                 f"\tTOKEN_STRING_INITIALIZER(struct cmd_{name}_result, {t_name}, {t_val});"
             )
         elif t_type in NUMERIC_TYPES:
-            result_struct.append(f"\t{t_type.lower()}_t {t_name};")
+            result_struct.append(f"\t{NUMERIC_TYPES[t_type]} {t_name};")
             initializers.append(
                 f"static cmdline_parse_token_num_t cmd_{name}_{t_name}_tok =\n"
                 f"\tTOKEN_NUM_INITIALIZER(struct cmd_{name}_result, {t_name}, RTE_{t_type});"
diff --git a/doc/guides/prog_guide/cmdline.rst b/doc/guides/prog_guide/cmdline.rst
index e20281ceb5..447a90e32e 100644
--- a/doc/guides/prog_guide/cmdline.rst
+++ b/doc/guides/prog_guide/cmdline.rst
@@ -22,6 +22,7 @@ The DPDK command-line library supports the following features:
 
    * Strings
    * Signed/unsigned 16/32/64-bit integers
+   * Single/double precision floats
    * IP Addresses
    * Ethernet Addresses
 
@@ -68,6 +69,8 @@ The format of the list file must be:
 
   * ``<UINT16>port_id``
 
+  * ``<FLOAT_SINGLE>ratio``
+
   * ``<IP>src_ip``
 
   * ``<IPv4>dst_ip4``
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..7e7c3494fd 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -106,6 +106,11 @@ New Features
   Added handling of the key combination Control+L
   to clear the screen before redisplaying the prompt.
 
+* **Added floating point numbers support to cmdline library.**
+
+  The cmdline library now supports parsing single- and double-precision
+  floating point numbers in interactive user commands.
+
 Removed Items
 -------------
 
diff --git a/lib/cmdline/cmdline_parse_num.c b/lib/cmdline/cmdline_parse_num.c
index 38a2bf6be6..297f4dc96c 100644
--- a/lib/cmdline/cmdline_parse_num.c
+++ b/lib/cmdline/cmdline_parse_num.c
@@ -8,6 +8,8 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <inttypes.h>
+#include <float.h>
+#include <math.h>
 #include <string.h>
 #include <eal_export.h>
 #include <rte_string_fns.h>
@@ -34,6 +36,7 @@ struct cmdline_token_ops cmdline_token_num_ops = {
 static const char * num_help[] = {
 	"UINT8", "UINT16", "UINT32", "UINT64",
 	"INT8", "INT16", "INT32", "INT64",
+	"FLOAT_SINGLE", "FLOAT_DOUBLE"
 };
 
 static inline int
@@ -71,6 +74,14 @@ check_res_size(struct cmdline_token_num_data *num_data, unsigned int res_size)
 		if (res_size < sizeof(int64_t))
 			return -1;
 		break;
+	case RTE_FLOAT_SINGLE:
+		if (res_size < sizeof(float))
+			return -1;
+		break;
+	case RTE_FLOAT_DOUBLE:
+		if (res_size < sizeof(double))
+			return -1;
+		break;
 	default:
 		debug_printf("Wrong number type: %d\n", num_data->type);
 		return -1;
@@ -81,7 +92,7 @@ check_res_size(struct cmdline_token_num_data *num_data, unsigned int res_size)
 static int
 validate_type(enum cmdline_numtype type)
 {
-	if (type < RTE_UINT8 || type > RTE_INT64)
+	if (type < RTE_UINT8 || type > RTE_FLOAT_DOUBLE)
 		return -1;
 	/* ensure no buffer overrun can occur */
 	if ((uint64_t) type >= RTE_DIM(num_help))
@@ -162,6 +173,26 @@ parse_num(const char *srcbuf, uint64_t *resptr)
 	return end - srcbuf;
 }
 
+static int
+parse_float(const char *srcbuf, enum cmdline_numtype type, double *resptr)
+{
+	double dres;
+	char *end;
+
+	if (type == RTE_FLOAT_SINGLE)
+		dres = (double)strtof(srcbuf, &end);
+	else if (type == RTE_FLOAT_DOUBLE)
+		dres = strtod(srcbuf, &end);
+	else
+		return -1;
+
+	if (end == srcbuf || !cmdline_isendoftoken(*end) || isinf(dres))
+		return -1;
+
+	*resptr = dres;
+	return end - srcbuf;
+}
+
 static int
 parse_bin(const char *srcbuf, uint64_t *res)
 {
@@ -280,7 +311,24 @@ write_num(enum cmdline_numtype type, void *res, uint64_t uintres)
 	return 0;
 }
 
-/* parse an int */
+static int
+write_float(enum cmdline_numtype type, void *res, double dres)
+{
+	switch (type) {
+	case RTE_FLOAT_SINGLE:
+		*(float *)res = (float)dres;
+		break;
+	case RTE_FLOAT_DOUBLE:
+		*(double *)res = dres;
+		break;
+	default:
+		debug_printf("Wrong float type\n");
+		return -1;
+	}
+	return 0;
+}
+
+/* parse a number */
 RTE_EXPORT_SYMBOL(cmdline_parse_num)
 int
 cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
@@ -303,6 +351,7 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 	if (res && check_res_size(&num_data, res_size) < 0)
 		return -1;
 
+	/* integer parsing */
 	if (num_data.type >= RTE_UINT8 && num_data.type <= RTE_INT64) {
 		int ret, neg = *srcbuf == '-';
 		uint64_t uintres;
@@ -324,6 +373,21 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 		if (res && write_num(num_data.type, res, uintres) < 0)
 			return -1;
 
+		return ret;
+	/* float parsing */
+	} else if (num_data.type >= RTE_FLOAT_SINGLE && num_data.type <= RTE_FLOAT_DOUBLE) {
+		double dres;
+		int ret;
+
+		/* try parsing as float */
+		ret = parse_float(srcbuf, num_data.type, &dres);
+		if (ret < 0)
+			return -1;
+
+		/* parsing succeeded, write the value if necessary */
+		if (res && write_float(num_data.type, res, dres))
+			return -1;
+
 		return ret;
 	}
 	return -1;
diff --git a/lib/cmdline/cmdline_parse_num.h b/lib/cmdline/cmdline_parse_num.h
index bdd0267612..b2792a2d11 100644
--- a/lib/cmdline/cmdline_parse_num.h
+++ b/lib/cmdline/cmdline_parse_num.h
@@ -22,7 +22,9 @@ enum cmdline_numtype {
 	RTE_INT8,
 	RTE_INT16,
 	RTE_INT32,
-	RTE_INT64
+	RTE_INT64,
+	RTE_FLOAT_SINGLE,
+	RTE_FLOAT_DOUBLE,
 };
 
 struct cmdline_token_num_data {
-- 
2.47.3

