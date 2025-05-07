Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF85C3ABBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 10:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB9324025D;
	Wed,  7 May 2025 12:01:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0D10A4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 12:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746612088; x=1778148088;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kUbVHx+y8MRk4KMR1apwtOIsD8+BLsDaFP43NgWI1fo=;
 b=FjzZ4AwFDRd0Vv24eKfbh+TP5Bccpggj/sBl/T3wbu9czIut7W2MHWHs
 n9UUt+kQ2sM/ufR+O0MRkkOleZ2ccW2ov0N7dGje0Q+FrIITWy4mEo1id
 ctw/QC6Szqv3VGyuejfajh+bkknmfu74dtrdRymNXUczr2EACW2gUn/4B
 oKMnn0TtspStVwZhTfkEadQLZNiTnS8cRFCrNkxZU+vrCuSkG8+84npp6
 0x8DpD+1dUA1OgXWLegK96MMUd2E9IubqixPM35jthIehmeAflFBaTLQ9
 ey3coKbC5KnzHZ73O+a4E4oP754+zDv+nvJI11KqMCumwAsvDMsVjlJUN A==;
X-CSE-ConnectionGUID: Kqn3b/AiT6KrzblD+eXkSQ==
X-CSE-MsgGUID: CA2DJ4nTSDK/JiaCurXWVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58527591"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="58527591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 03:01:27 -0700
X-CSE-ConnectionGUID: rTscxHQNQW2xfZ7eab8uMA==
X-CSE-MsgGUID: OI+GfVzeTNW1sYGw0BHSxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="159199422"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa002.fm.intel.com with ESMTP; 07 May 2025 03:01:26 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v4 1/2] cmdline: add floating point support
Date: Wed,  7 May 2025 11:01:23 +0100
Message-ID: <e8234c26b5dd91aaa9e7b1e38887b1d6fdb2d053.1746612074.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
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
as unit tests for the new functionality. The parser supports single and
double precision floats, and will understand decimal fractions as well as
scientific notation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Removed unnecessary check for integer overflow when parsing negative
      floats (as we convert to double before changing sign)
    - Make naming of float exponent states more consistent
    
    v2 -> v3:
    - Fixed a bug where a free-standing negative exponent ("1e-") would attempt to be
      parsed, and added unit tests for this case
    - Added support for floats in dpdk-cmdline-gen script
    - Added documentation updates to call out float support

 app/test/test_cmdline_num.c            | 203 +++++++++++++++++-
 buildtools/dpdk-cmdline-gen.py         |  24 ++-
 doc/guides/prog_guide/cmdline.rst      |   3 +
 doc/guides/rel_notes/release_25_07.rst |   5 +
 lib/cmdline/cmdline_parse_num.c        | 273 +++++++++++++++++++++++++
 lib/cmdline/cmdline_parse_num.h        |   4 +-
 6 files changed, 497 insertions(+), 15 deletions(-)

diff --git a/app/test/test_cmdline_num.c b/app/test/test_cmdline_num.c
index 9276de59bd..e4038271c9 100644
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
+	const char * str;
+	double result;
+};
+
 const struct num_unsigned_str num_valid_positive_strs[] = {
 		/* decimal positive */
 		{"0", 0 },
@@ -141,6 +148,63 @@ const struct num_signed_str num_valid_negative_strs[] = {
 		{"-9223372036854775808", INT64_MIN },
 };
 
+const struct num_float_str num_valid_float_strs[] = {
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
@@ -183,6 +247,30 @@ const struct num_signed_str num_garbage_negative_strs[] = {
 		{"-9223372036854775808 garbage", INT64_MIN },
 };
 
+const char *float_invalid_strs[] = {
+	"0.",
+	".1",
+	"1.1.",
+	"1.1.1",
+	"-0.",
+	"-.1",
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
@@ -202,7 +290,16 @@ const char * num_invalid_strs[] = {
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
 		"+4",
@@ -216,6 +313,47 @@ const char * num_invalid_strs[] = {
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
+		/* FLT_EPSILON is too small for some tests */
+		eps = 1e-5f;
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
@@ -371,11 +509,11 @@ test_parse_num_invalid_data(void)
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
@@ -397,6 +535,31 @@ test_parse_num_invalid_data(void)
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
+
+			memset(&result, 0, sizeof(double));
+			memset(&buf, 0, sizeof(buf));
+
+			ret = cmdline_parse_num((cmdline_parse_token_hdr_t*)&token,
+					float_invalid_strs[i], (void*)&result, sizeof(result));
+			if (ret != -1) {
+				/* get some info about what we are trying to parse */
+				cmdline_get_help_num((cmdline_parse_token_hdr_t*)&token,
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
 
@@ -408,13 +571,13 @@ test_parse_num_valid(void)
 	enum cmdline_numtype type;
 	unsigned i;
 	char buf[CMDLINE_TEST_BUFSIZE];
-	uint64_t result;
 	cmdline_parse_token_num_t token;
 
 	/** valid strings **/
 
 	/* cycle through all possible parsed types */
 	for (type = RTE_UINT8; type <= RTE_INT64; type++) {
+		uint64_t result;
 		token.num_data.type = type;
 
 		/* test positive strings */
@@ -489,10 +652,44 @@ test_parse_num_valid(void)
 		}
 	}
 
+	/* float values */
+	for (type = RTE_FLOAT_SINGLE; type <= RTE_FLOAT_DOUBLE; type++) {
+		double result;
+		token.num_data.type = type;
+
+		/* test all valid strings */
+		for (i = 0; i < RTE_DIM(num_valid_float_strs); i++) {
+			result = 0;
+			memset(&buf, 0, sizeof(buf));
+
+
+			cmdline_get_help_num((cmdline_parse_token_hdr_t*)&token,
+					buf, sizeof(buf));
+
+			ret = cmdline_parse_num((cmdline_parse_token_hdr_t*) &token,
+				num_valid_float_strs[i].str,
+				(void*)&result, sizeof(result));
+
+			/* if it should have passed but didn't, or if it should have failed but didn't */
+			if ((ret < 0) == (can_parse_float(num_valid_float_strs[i].result, type) > 0)) {
+				printf("Error: parser behaves unexpectedly when parsing %s as %s!\n",
+						num_valid_float_strs[i].str, buf);
+				return -1;
+			}
+			/* check if result matches */
+			if (ret > 0 && float_cmp(num_valid_float_strs[i].result, &result, type) != 0) {
+				printf("Error: parsing %s as %s failed: result mismatch!\n",
+						num_valid_float_strs[i].str, buf);
+				return -1;
+			}
+		}
+	}
+
 	/** garbage strings **/
 
 	/* cycle through all possible parsed types */
 	for (type = RTE_UINT8; type <= RTE_INT64; type++) {
+		uint64_t result;
 		token.num_data.type = type;
 
 		/* test positive garbage strings */
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
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..54bc545110 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added floating point numbers support to cmdline library.**
+
+  The cmdline library now supports parsing single- and double-precision
+  floating point numbers in interactive user commands.
+
 
 Removed Items
 -------------
diff --git a/lib/cmdline/cmdline_parse_num.c b/lib/cmdline/cmdline_parse_num.c
index f21796bedb..9e4d559325 100644
--- a/lib/cmdline/cmdline_parse_num.c
+++ b/lib/cmdline/cmdline_parse_num.c
@@ -7,6 +7,8 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <inttypes.h>
+#include <float.h>
+#include <math.h>
 #include <string.h>
 #include <eal_export.h>
 #include <rte_string_fns.h>
@@ -34,6 +36,10 @@ enum num_parse_state_t {
 	DEC_NEG,
 	BIN,
 	HEX,
+	FLOAT_POS,
+	FLOAT_NEG,
+	FLOAT_EXP_POS,
+	FLOAT_EXP_NEG,
 
 	ERROR,
 
@@ -44,12 +50,27 @@ enum num_parse_state_t {
 	BIN_OK,
 	DEC_NEG_OK,
 	DEC_POS_OK,
+	FLOAT_POS_OK,
+	FLOAT_NEG_OK,
+	FLOAT_EXP_POS_OK,
+	FLOAT_EXP_NEG_OK,
+};
+
+struct float_parse_state {
+	uint64_t dec;
+	uint64_t frac;
+	uint64_t frac_exp;
+	uint64_t exp;
+#define FLOAT_FLAG_NEG_RES     (1 << 0)
+#define FLOAT_FLAG_NEG_EXP     (1 << 1)
+	int flags;
 };
 
 /* Keep it sync with enum in .h */
 static const char * num_help[] = {
 	"UINT8", "UINT16", "UINT32", "UINT64",
 	"INT8", "INT16", "INT32", "INT64",
+	"SINGLE", "DOUBLE"
 };
 
 static inline int
@@ -63,6 +84,50 @@ add_to_res(unsigned int c, uint64_t *res, unsigned int base)
 	return 0;
 }
 
+static inline int
+check_float_result(enum cmdline_numtype res_type, struct float_parse_state *fps,
+		void *res)
+{
+	double dec, frac, exp, result;
+
+	/* extract parts */
+	dec = (double) fps->dec;
+	frac = (double) fps->frac * pow(10.0, -(double)fps->frac_exp);
+	exp = (double) fps->exp;
+
+	/* exponent might be negative */
+	if (fps->flags & FLOAT_FLAG_NEG_EXP)
+		exp = pow(10.0, -exp);
+	else
+		exp = pow(10.0, exp);
+
+	/* combine decimal, fractional, and exponent parts */
+	result = (dec + frac) * exp;
+
+	/* check for any overflows */
+	if (isinf(frac) || isinf(exp) || isinf(result))
+		return -1;
+
+	/* result is a valid double */
+
+	/* check if result needs to be negative */
+	if (fps->flags & FLOAT_FLAG_NEG_RES)
+		result = -result;
+
+	if (res_type == RTE_FLOAT_SINGLE) {
+		/* float can overflow from conversion */
+		float flt = (float)result;
+		if (isinf(flt))
+			return -1;
+		if (res) *(float *)res = flt;
+	} else if (res_type == RTE_FLOAT_DOUBLE) {
+		if (res) *(double *)res = result;
+	} else {
+		return -1;
+	}
+	return 0;
+}
+
 static int
 check_res_size(struct cmdline_token_num_data *nd, unsigned ressize)
 {
@@ -87,6 +152,14 @@ check_res_size(struct cmdline_token_num_data *nd, unsigned ressize)
 		if (ressize < sizeof(int64_t))
 			return -1;
 		break;
+	case RTE_FLOAT_SINGLE:
+		if (ressize < sizeof(float))
+			return -1;
+		break;
+	case RTE_FLOAT_DOUBLE:
+		if (ressize < sizeof(double))
+			return -1;
+		break;
 	default:
 		return -1;
 	}
@@ -104,6 +177,7 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 	const char * buf;
 	char c;
 	uint64_t res1 = 0;
+	struct float_parse_state fps = {};
 
 	if (!tk)
 		return -1;
@@ -156,6 +230,10 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 				else
 					st = OCTAL_OK;
 			}
+			else if (c == '.') {
+				st = FLOAT_POS;
+				break;
+			}
 			else  {
 				st = ERROR;
 			}
@@ -173,11 +251,80 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 			}
 			break;
 
+		case FLOAT_POS:
+			if (c >= '0' && c <= '9') {
+				if (add_to_res(c - '0', &res1, 10) < 0)
+					st = ERROR;
+				else {
+					st = FLOAT_POS_OK;
+					fps.frac_exp++;
+				}
+			}
+			else {
+				st = ERROR;
+			}
+			break;
+
+		case FLOAT_NEG:
+			if (c >= '0' && c <= '9') {
+				if (add_to_res(c - '0', &res1, 10) < 0)
+					st = ERROR;
+				else {
+					st = FLOAT_NEG_OK;
+					fps.frac_exp++;
+				}
+			}
+			else {
+				st = ERROR;
+			}
+			break;
+
+		case FLOAT_EXP_POS:
+			if (c >= '0' && c <= '9') {
+				if (add_to_res(c - '0', &res1, 10) < 0)
+					st = ERROR;
+				else
+					st = FLOAT_EXP_POS_OK;
+			}
+			else if (c == '-') {
+				st = FLOAT_EXP_NEG;
+				fps.flags |= FLOAT_FLAG_NEG_EXP;
+			}
+			else {
+				st = ERROR;
+			}
+			break;
+
+		case FLOAT_EXP_NEG:
+			if (c >= '0' && c <= '9') {
+				if (add_to_res(c - '0', &res1, 10) < 0)
+					st = ERROR;
+				else
+					st = FLOAT_EXP_NEG_OK;
+			}
+			else {
+				st = ERROR;
+			}
+			break;
+
 		case DEC_NEG_OK:
 			if (c >= '0' && c <= '9') {
 				if (add_to_res(c - '0', &res1, 10) < 0)
 					st = ERROR;
 			}
+			else if (c == '.') {
+				fps.dec = res1;
+				fps.flags |= FLOAT_FLAG_NEG_RES;
+				st = FLOAT_NEG;
+				/* erase result */
+				res1 = 0;
+			} else if (c == 'e' || c == 'E') {
+				fps.dec = res1;
+				fps.flags |= FLOAT_FLAG_NEG_RES;
+				st = FLOAT_EXP_POS;
+				/* erase result */
+				res1 = 0;
+			}
 			else {
 				st = ERROR;
 			}
@@ -188,11 +335,75 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 				if (add_to_res(c - '0', &res1, 10) < 0)
 					st = ERROR;
 			}
+			else if (c == '.') {
+				fps.dec = res1;
+				st = FLOAT_POS;
+				/* erase result */
+				res1 = 0;
+			}
+			else if (c == 'e' || c == 'E') {
+				fps.dec = res1;
+				st = FLOAT_EXP_POS;
+				/* erase result */
+				res1 = 0;
+			}
 			else {
 				st = ERROR;
 			}
 			break;
 
+		case FLOAT_POS_OK:
+			if (c >= '0' && c <= '9') {
+				if (add_to_res(c - '0', &res1, 10) < 0)
+					st = ERROR;
+				else
+					fps.frac_exp++;
+			} else if (c == 'e' || c == 'E') {
+				fps.frac = res1;
+				st = FLOAT_EXP_POS;
+				/* erase result */
+				res1 = 0;
+			} else {
+				st = ERROR;
+			}
+			break;
+
+		case FLOAT_NEG_OK:
+			if (c >= '0' && c <= '9') {
+				if (add_to_res(c - '0', &res1, 10) < 0)
+					st = ERROR;
+				else
+					fps.frac_exp++;
+			} else if (c == 'e' || c == 'E') {
+				fps.frac = res1;
+				st = FLOAT_EXP_POS;
+				/* erase result */
+				res1 = 0;
+			} else {
+				st = ERROR;
+			}
+			break;
+
+		case FLOAT_EXP_POS_OK:
+			/* exponent is always whole */
+			if (c >= '0' && c <= '9') {
+				if (add_to_res(c - '0', &res1, 10) < 0)
+					st = ERROR;
+			} else {
+				st = ERROR;
+			}
+			break;
+
+		case FLOAT_EXP_NEG_OK:
+			/* exponent is always whole */
+			if (c >= '0' && c <= '9') {
+				if (add_to_res(c - '0', &res1, 10) < 0)
+					st = ERROR;
+			} else {
+				st = ERROR;
+			}
+			break;
+
 		case HEX:
 			st = HEX_OK;
 			/* fall-through */
@@ -282,6 +493,12 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 		} else if (nd.type == RTE_UINT64) {
 			if (res) *(uint64_t *)res = res1;
 			return buf-srcbuf;
+		} else if (nd.type == RTE_FLOAT_SINGLE || nd.type == RTE_FLOAT_DOUBLE) {
+			/* parsed double from integer */
+			fps.dec = res1;
+			if (check_float_result(nd.type, &fps, res) < 0)
+				return -1;
+			return buf-srcbuf;
 		} else {
 			return -1;
 		}
@@ -304,6 +521,62 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 				res1 <= (uint64_t)INT64_MAX + 1) {
 			if (res) *(int64_t *)res = (int64_t) (-res1);
 			return buf-srcbuf;
+		} else if (nd.type == RTE_FLOAT_SINGLE || nd.type == RTE_FLOAT_DOUBLE) {
+			/* parsed double from negative integer */
+			fps.dec = res1;
+			fps.flags |= FLOAT_FLAG_NEG_RES;
+			if (check_float_result(nd.type, &fps, res) < 0)
+				return -1;
+			return buf-srcbuf;
+		} else {
+			return -1;
+		}
+		break;
+
+	case FLOAT_POS_OK:
+		if (nd.type == RTE_FLOAT_SINGLE || nd.type == RTE_FLOAT_DOUBLE) {
+			fps.frac = res1;
+
+			if (check_float_result(nd.type, &fps, res) < 0)
+				return -1;
+			return buf-srcbuf;
+		} else {
+			return -1;
+		}
+		break;
+
+	case FLOAT_NEG_OK:
+		if (nd.type == RTE_FLOAT_SINGLE || nd.type == RTE_FLOAT_DOUBLE) {
+			fps.frac = res1;
+
+			if (check_float_result(nd.type, &fps, res) < 0)
+				return -1;
+			return buf-srcbuf;
+		} else {
+			return -1;
+		}
+		break;
+
+	case FLOAT_EXP_POS_OK:
+		/* watch for overflow in the exponent */
+		if (nd.type == RTE_FLOAT_SINGLE || nd.type == RTE_FLOAT_DOUBLE) {
+			fps.exp = res1;
+
+			if (check_float_result(nd.type, &fps, res) < 0)
+				return -1;
+			return buf-srcbuf;
+		} else {
+			return -1;
+		}
+		break;
+
+	case FLOAT_EXP_NEG_OK:
+		if (nd.type == RTE_FLOAT_SINGLE || nd.type == RTE_FLOAT_DOUBLE) {
+			fps.exp = res1;
+
+			if (check_float_result(nd.type, &fps, res) < 0)
+				return -1;
+			return buf-srcbuf;
 		} else {
 			return -1;
 		}
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
2.47.1

