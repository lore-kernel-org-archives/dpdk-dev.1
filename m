Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2FC3ABBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 15:22:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0007F4060B;
	Wed,  7 May 2025 17:22:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A3B864025A
 for <dev@dpdk.org>; Wed,  7 May 2025 17:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746631338; x=1778167338;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7pKwtfDcz+3OND/H/Gn6pbRpdYLVePXb2BWfzPChIzA=;
 b=lVjHct/Nn/akdtn0Mptjk57IzVvrje3qqG8rXnR4jqRf8Y8TGPCb9eza
 2/eU/pvKadS/mqxLYpPf3hoI0DT24wWvtLxXmW/3MuFajA+fkU+ARIVWK
 x9cvuVcxzTVSqSNBJCG3PQvITg36FDWzPvqdzgvicj0cOSYcgS4wklWEv
 Y8be6DjIbbtnURazYguzvMuXCqQGGbBPJrPQiw7TvkbmmeoXCGPqbwGE+
 9nta0qKWQRJAEQoDu/22hDhZJMQW7lBOdW6mlNZFa/S2YHUI6e258S4HA
 QfDly2ezXXRec6D6sp2Lmq7PvVfBSve52jM0E4aeMbwBKCPyacBPBPvWH Q==;
X-CSE-ConnectionGUID: GBKjH8GsT9qmsgoGYa6r2A==
X-CSE-MsgGUID: oSR2oYvSSbmI2IFOkUuq+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48526384"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="48526384"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 08:22:17 -0700
X-CSE-ConnectionGUID: zwFt9EeSRYa/vdy8wOAWRg==
X-CSE-MsgGUID: pbIprUYTRxaIwkhYNy3T2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="136997862"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa009.fm.intel.com with ESMTP; 07 May 2025 08:22:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v5 2/3] cmdline: add floating point support
Date: Wed,  7 May 2025 16:22:11 +0100
Message-ID: <b9f8ac77e4eeecd67a83d72cdf52ef3e08539bab.1746631324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
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

 app/test/test_cmdline_num.c            | 205 ++++++++++++++++++++++++-
 buildtools/dpdk-cmdline-gen.py         |  24 +--
 doc/guides/prog_guide/cmdline.rst      |   3 +
 doc/guides/rel_notes/release_25_07.rst |   5 +
 lib/cmdline/cmdline_parse_num.c        |  34 +++-
 lib/cmdline/cmdline_parse_num.h        |   4 +-
 6 files changed, 255 insertions(+), 20 deletions(-)

diff --git a/app/test/test_cmdline_num.c b/app/test/test_cmdline_num.c
index 471e9964ee..db3b286601 100644
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
@@ -183,6 +247,26 @@ const struct num_signed_str num_garbage_negative_strs[] = {
 		{"-9223372036854775808 garbage", INT64_MIN },
 };
 
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
@@ -202,7 +286,16 @@ const char * num_invalid_strs[] = {
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
@@ -215,6 +308,47 @@ const char * num_invalid_strs[] = {
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
@@ -370,11 +504,11 @@ test_parse_num_invalid_data(void)
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
@@ -396,6 +530,31 @@ test_parse_num_invalid_data(void)
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
 
@@ -407,13 +566,13 @@ test_parse_num_valid(void)
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
@@ -452,7 +611,7 @@ test_parse_num_valid(void)
 			cmdline_get_help_num((cmdline_parse_token_hdr_t*)&token,
 					buf, sizeof(buf));
 
-			ret = cmdline_parse_num((cmdline_parse_token_hdr_t*) &token,
+ 			ret = cmdline_parse_num((cmdline_parse_token_hdr_t*) &token,
 				num_valid_negative_strs[i].str,
 				(void*)&result, sizeof(result));
 
@@ -488,10 +647,44 @@ test_parse_num_valid(void)
 		}
 	}
 
+	/* cycle through all possible float types */
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
 
-	/* cycle through all possible parsed types */
+	/* cycle through all possible integer types */
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
index f7ccd26d96..4ffc58aeb5 100644
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
@@ -71,6 +74,14 @@ check_res_size(struct cmdline_token_num_data *nd, unsigned ressize)
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
@@ -216,7 +227,7 @@ parse_bin(const char *srcbuf, uint64_t *res)
 	return buf - srcbuf;
 }
 
-/* parse an int */
+/* parse a number */
 RTE_EXPORT_SYMBOL(cmdline_parse_num)
 int
 cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
@@ -237,7 +248,7 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 		if (check_res_size(&nd, ressize) < 0)
 			return -1;
 	}
-
+	/* integer parsing */
 	if (nd.type >= RTE_UINT8 && nd.type <= RTE_INT64) {
 		int ret, neg = *srcbuf == '-';
 		uint64_t uintres;
@@ -291,6 +302,25 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 			return -1;
 		}
 		return ret;
+	/* float parsing */
+	} else if (nd.type >= RTE_FLOAT_SINGLE && nd.type <= RTE_FLOAT_DOUBLE) {
+		char *end;
+		double dres = strtod(srcbuf, &end);
+
+		if (end == srcbuf || !cmdline_isendoftoken(*end) || isinf(dres))
+			return -1;
+
+		/* we parsed something, now let's ensure it fits */
+		if (nd.type == RTE_FLOAT_SINGLE) {
+			float flt = (float)dres;
+			if (isinf(flt))
+				return -1;
+			if (res) *(float *)res = flt;
+			return end-srcbuf;
+		} else if (nd.type == RTE_FLOAT_DOUBLE) {
+			if (res) *(double *)res = dres;
+			return end-srcbuf;
+		}
 	}
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

