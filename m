Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF37C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 13:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8F094026C;
	Thu,  8 May 2025 15:16:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 098F34026B
 for <dev@dpdk.org>; Thu,  8 May 2025 15:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746710168; x=1778246168;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=b0TcbyJtbQnSR0YWhECuf3SoqGFwuhGMVICk1cGu+nc=;
 b=C4599Kwnbadd0PzdoAq+bRTcdqBIqHQqpwIlpqr6H/lQFbRlQitdDX6e
 E63Btbb78pHzly8rVF6IW2G6k0+Seyvjv/DT5llZYMEU48sW4aTQJZN1l
 4jMSrrtP6FsJ+EikvKjZ3fj1UOh4S2HX9KUMT3SBfp3jdFAEcQfxh0tVY
 /DWIngMGmWVxL1BhagU1Ls4V4ICoWdjoLjyEGkLF9cOXUwj4OPeR3bUAZ
 3/V1gOye5vLMWzM6SCQSszK2G/1HmMHYIe8kyM8S3WhOFhJUdVYlNSUGJ
 VTE9spHKqsh2BQBXL/k9fBbQV/2NULrwkSsh0YVT6Cw0xiFVPz8NmJQwB Q==;
X-CSE-ConnectionGUID: YFnxrmCWTt6O8iJe7oUZLQ==
X-CSE-MsgGUID: gyJK2HFITtugFmwgwlmwcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48359603"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="48359603"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 06:16:07 -0700
X-CSE-ConnectionGUID: WO0EI7WmQSSCqhmHvpZsRQ==
X-CSE-MsgGUID: IjF0/sDETK2ENOCJ4fSMRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="136781196"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa010.fm.intel.com with ESMTP; 08 May 2025 06:16:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v8 1/3] cmdline: use C standard library as number parser
Date: Thu,  8 May 2025 14:16:01 +0100
Message-ID: <7bebd92be36f945c175382bb1e0482e55844c1d2.1746710154.git.anatoly.burakov@intel.com>
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

Remove custom number parser and use C standard library instead. In order to
keep compatibility with earlier versions of the parser, we have to take
into account a couple of quirks:

- We did not consider "negative" numbers to be valid for anything other
  than base-10 numbers, whereas C standard library does. Adjust the tests
  to match the new behavior.
- We did not consider numbers such as "+4" to be valid, whereas C
  standard library does. Adjust the tests to match the new behavior.
- C standard library's strtoull does not do range checks on negative
  numbers, so we have to parse knowingly-negative numbers as signed.
- C standard library does not support binary numbers, so we keep around the
  relevant parts of the custom parser in place to support binary numbers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v7 -> v8:
    - Added the commented-out out-of-bounds check back
    - Replaced debug print messages to ensure they don't attempt to
      index the num_help[] array (should fix compile errors)
    
    v5 -> v6:
    - Allowed more negative numbers (such as negative octals or hex)
    - Updated unit tests to check new cases
    - Small refactoring of code to reduce amount of noise
    - More verbose debug output
    
    v4 -> v5:
    - Added this commit

 app/test/test_cmdline_num.c     |  19 +-
 lib/cmdline/cmdline_parse_num.c | 367 ++++++++++++++++----------------
 2 files changed, 195 insertions(+), 191 deletions(-)

diff --git a/app/test/test_cmdline_num.c b/app/test/test_cmdline_num.c
index 9276de59bd..dd70f6f824 100644
--- a/app/test/test_cmdline_num.c
+++ b/app/test/test_cmdline_num.c
@@ -139,6 +139,8 @@ const struct num_signed_str num_valid_negative_strs[] = {
 		{"-2147483648", INT32_MIN },
 		{"-2147483649", INT32_MIN - 1LL },
 		{"-9223372036854775808", INT64_MIN },
+		{"-0x8000000000000000", INT64_MIN },
+		{"-01000000000000000000000", INT64_MIN },
 };
 
 const struct num_unsigned_str num_garbage_positive_strs[] = {
@@ -175,12 +177,27 @@ const struct num_unsigned_str num_garbage_positive_strs[] = {
 
 const struct num_signed_str num_garbage_negative_strs[] = {
 		/* valid strings with garbage on the end, should still be valid */
+		/* negative numbers */
 		{"-9223372036854775808\0garbage", INT64_MIN },
 		{"-9223372036854775808\rgarbage", INT64_MIN },
 		{"-9223372036854775808\tgarbage", INT64_MIN },
 		{"-9223372036854775808\ngarbage", INT64_MIN },
 		{"-9223372036854775808#garbage", INT64_MIN },
 		{"-9223372036854775808 garbage", INT64_MIN },
+		/* negative hex */
+		{"-0x8000000000000000\0garbage", INT64_MIN },
+		{"-0x8000000000000000\rgarbage", INT64_MIN },
+		{"-0x8000000000000000\tgarbage", INT64_MIN },
+		{"-0x8000000000000000\ngarbage", INT64_MIN },
+		{"-0x8000000000000000#garbage", INT64_MIN },
+		{"-0x8000000000000000 garbage", INT64_MIN },
+		/* negative octal */
+		{"-01000000000000000000000\0garbage", INT64_MIN },
+		{"-01000000000000000000000\rgarbage", INT64_MIN },
+		{"-01000000000000000000000\tgarbage", INT64_MIN },
+		{"-01000000000000000000000\ngarbage", INT64_MIN },
+		{"-01000000000000000000000#garbage", INT64_MIN },
+		{"-01000000000000000000000 garbage", INT64_MIN },
 };
 
 const char * num_invalid_strs[] = {
@@ -197,7 +214,6 @@ const char * num_invalid_strs[] = {
 		"0b01110101017001",
 		/* false negative numbers */
 		"-12345F623",
-		"-0x1234580A",
 		"-0b0111010101",
 		/* too long (128+ chars) */
 		("0b1111000011110000111100001111000011110000111100001111000011110000"
@@ -205,7 +221,6 @@ const char * num_invalid_strs[] = {
 		"1E3",
 		"0A",
 		"-B",
-		"+4",
 		"1.23G",
 		"",
 		" ",
diff --git a/lib/cmdline/cmdline_parse_num.c b/lib/cmdline/cmdline_parse_num.c
index f21796bedb..1e04a59038 100644
--- a/lib/cmdline/cmdline_parse_num.c
+++ b/lib/cmdline/cmdline_parse_num.c
@@ -4,6 +4,7 @@
  * All rights reserved.
  */
 
+#include <errno.h>
 #include <stdio.h>
 #include <stdint.h>
 #include <inttypes.h>
@@ -29,23 +30,6 @@ struct cmdline_token_ops cmdline_token_num_ops = {
 	.get_help = cmdline_get_help_num,
 };
 
-enum num_parse_state_t {
-	START,
-	DEC_NEG,
-	BIN,
-	HEX,
-
-	ERROR,
-
-	FIRST_OK, /* not used */
-	ZERO_OK,
-	HEX_OK,
-	OCTAL_OK,
-	BIN_OK,
-	DEC_NEG_OK,
-	DEC_POS_OK,
-};
-
 /* Keep it sync with enum in .h */
 static const char * num_help[] = {
 	"UINT8", "UINT16", "UINT32", "UINT64",
@@ -53,13 +37,13 @@ static const char * num_help[] = {
 };
 
 static inline int
-add_to_res(unsigned int c, uint64_t *res, unsigned int base)
+add_to_bin(unsigned int c, uint64_t *res)
 {
 	/* overflow */
-	if ((UINT64_MAX - c) / base < *res)
+	if ((UINT64_MAX - c) / 2 < *res)
 		return -1;
 
-	*res = (uint64_t) (*res * base + c);
+	*res = (uint64_t) (*res * 2 + c);
 	return 0;
 }
 
@@ -88,138 +72,117 @@ check_res_size(struct cmdline_token_num_data *nd, unsigned ressize)
 			return -1;
 		break;
 	default:
+		debug_printf("Wrong number type: %d\n", nd->type);
 		return -1;
 	}
 	return 0;
 }
 
-/* parse an int */
-RTE_EXPORT_SYMBOL(cmdline_parse_num)
-int
-cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
-	unsigned ressize)
+static int
+check_parsed_num(enum cmdline_numtype type, int neg, uint64_t uintres)
 {
-	struct cmdline_token_num_data nd;
-	enum num_parse_state_t st = START;
+	int lo_ok, hi_ok;
+
+	switch (type) {
+	case RTE_UINT8:
+		lo_ok = !neg;
+		hi_ok = uintres <= UINT8_MAX;
+		break;
+	case RTE_UINT16:
+		lo_ok = !neg;
+		hi_ok = uintres <= UINT16_MAX;
+		break;
+	case RTE_UINT32:
+		lo_ok = !neg;
+		hi_ok = uintres <= UINT32_MAX;
+		break;
+	case RTE_UINT64:
+		lo_ok = !neg;
+		hi_ok = 1; /* can't be out of range if parsed successfully */
+		break;
+	case RTE_INT8:
+		lo_ok = !neg || (int64_t)uintres >= INT8_MIN;
+		hi_ok = neg || uintres <= INT8_MAX;
+		break;
+	case RTE_INT16:
+		lo_ok = !neg || (int64_t)uintres >= INT16_MIN;
+		hi_ok = neg || uintres <= INT16_MAX;
+		break;
+	case RTE_INT32:
+		lo_ok = !neg || (int64_t)uintres >= INT32_MIN;
+		hi_ok = neg || uintres <= INT32_MAX;
+		break;
+	case RTE_INT64:
+		lo_ok = 1; /* can't be out of range if parsed successfully */
+		hi_ok = neg || uintres <= INT64_MAX;
+		break;
+	default:
+		debug_printf("Wrong number type\n");
+		return -1;
+	}
+	/* check ranges */
+	if (!lo_ok || !hi_ok)
+		return -1;
+	return 0;
+}
+
+static int
+parse_num(const char *srcbuf, uint64_t *resptr)
+{
+	uint64_t uintres;
+	char *end;
+	int neg = *srcbuf == '-';
+
+	/*
+	 * strtoull does not do range checks on negative numbers, so we need to
+	 * use strtoll if we know the value we're parsing looks like a negative
+	 * one. we use base 0 for both, 0 means autodetect base.
+	 */
+	errno = 0;
+	if (neg)
+		uintres = (uint64_t)strtoll(srcbuf, &end, 0);
+	else
+		uintres = strtoull(srcbuf, &end, 0);
+
+	if (end == srcbuf || !cmdline_isendoftoken(*end) || errno == ERANGE)
+		return -1;
+
+	*resptr = uintres;
+	return end - srcbuf;
+}
+
+static int
+parse_bin(const char *srcbuf, uint64_t *res)
+{
+	uint64_t uintres = 0;
+	enum {
+		ERROR,
+		START,
+		BIN,
+		ZERO_OK,
+		BIN_OK,
+	} st = START;
 	const char * buf;
 	char c;
-	uint64_t res1 = 0;
-
-	if (!tk)
-		return -1;
-
-	if (!srcbuf || !*srcbuf)
-		return -1;
 
 	buf = srcbuf;
 	c = *buf;
-
-	memcpy(&nd, &((struct cmdline_token_num *)tk)->num_data, sizeof(nd));
-
-	/* check that we have enough room in res */
-	if (res) {
-		if (check_res_size(&nd, ressize) < 0)
-			return -1;
-	}
-
 	while (st != ERROR && c && !cmdline_isendoftoken(c)) {
 		debug_printf("%c %x -> ", c, c);
 		switch (st) {
 		case START:
-			if (c == '-') {
-				st = DEC_NEG;
-			}
-			else if (c == '0') {
+			if (c == '0') {
 				st = ZERO_OK;
 			}
-			else if (c >= '1' && c <= '9') {
-				if (add_to_res(c - '0', &res1, 10) < 0)
-					st = ERROR;
-				else
-					st = DEC_POS_OK;
-			}
-			else  {
+			else {
 				st = ERROR;
 			}
 			break;
 
 		case ZERO_OK:
-			if (c == 'x') {
-				st = HEX;
-			}
-			else if (c == 'b') {
+			if (c == 'b') {
 				st = BIN;
 			}
-			else if (c >= '0' && c <= '7') {
-				if (add_to_res(c - '0', &res1, 10) < 0)
-					st = ERROR;
-				else
-					st = OCTAL_OK;
-			}
-			else  {
-				st = ERROR;
-			}
-			break;
-
-		case DEC_NEG:
-			if (c >= '0' && c <= '9') {
-				if (add_to_res(c - '0', &res1, 10) < 0)
-					st = ERROR;
-				else
-					st = DEC_NEG_OK;
-			}
-			else {
-				st = ERROR;
-			}
-			break;
-
-		case DEC_NEG_OK:
-			if (c >= '0' && c <= '9') {
-				if (add_to_res(c - '0', &res1, 10) < 0)
-					st = ERROR;
-			}
-			else {
-				st = ERROR;
-			}
-			break;
-
-		case DEC_POS_OK:
-			if (c >= '0' && c <= '9') {
-				if (add_to_res(c - '0', &res1, 10) < 0)
-					st = ERROR;
-			}
-			else {
-				st = ERROR;
-			}
-			break;
-
-		case HEX:
-			st = HEX_OK;
-			/* fall-through */
-		case HEX_OK:
-			if (c >= '0' && c <= '9') {
-				if (add_to_res(c - '0', &res1, 16) < 0)
-					st = ERROR;
-			}
-			else if (c >= 'a' && c <= 'f') {
-				if (add_to_res(c - 'a' + 10, &res1, 16) < 0)
-					st = ERROR;
-			}
-			else if (c >= 'A' && c <= 'F') {
-				if (add_to_res(c - 'A' + 10, &res1, 16) < 0)
-					st = ERROR;
-			}
-			else {
-				st = ERROR;
-			}
-			break;
-
-
-		case OCTAL_OK:
-			if (c >= '0' && c <= '7') {
-				if (add_to_res(c - '0', &res1, 8) < 0)
-					st = ERROR;
-			}
 			else {
 				st = ERROR;
 			}
@@ -230,7 +193,7 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 			/* fall-through */
 		case BIN_OK:
 			if (c >= '0' && c <= '1') {
-				if (add_to_res(c - '0', &res1, 2) < 0)
+				if (add_to_bin(c - '0', &uintres) < 0)
 					st = ERROR;
 			}
 			else {
@@ -239,10 +202,10 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 			break;
 		default:
 			debug_printf("not impl ");
-
+			st = ERROR;
 		}
 
-		debug_printf("(%"PRIu64")\n", res1);
+		debug_printf("(%"PRIu64")\n", uintres);
 
 		buf ++;
 		c = *buf;
@@ -252,66 +215,92 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 			return -1;
 	}
 
-	switch (st) {
-	case ZERO_OK:
-	case DEC_POS_OK:
-	case HEX_OK:
-	case OCTAL_OK:
-	case BIN_OK:
-		if (nd.type == RTE_INT8 && res1 <= INT8_MAX) {
-			if (res) *(int8_t *)res = (int8_t) res1;
-			return buf-srcbuf;
-		} else if (nd.type == RTE_INT16 && res1 <= INT16_MAX) {
-			if (res) *(int16_t *)res = (int16_t) res1;
-			return buf-srcbuf;
-		} else if (nd.type == RTE_INT32 && res1 <= INT32_MAX) {
-			if (res) *(int32_t *)res = (int32_t) res1;
-			return buf-srcbuf;
-		} else if (nd.type == RTE_INT64 && res1 <= INT64_MAX) {
-			if (res) *(int64_t *)res = (int64_t) res1;
-			return buf-srcbuf;
-		} else if (nd.type == RTE_UINT8 && res1 <= UINT8_MAX) {
-			if (res) *(uint8_t *)res = (uint8_t) res1;
-			return buf-srcbuf;
-		} else if (nd.type == RTE_UINT16  && res1 <= UINT16_MAX) {
-			if (res) *(uint16_t *)res = (uint16_t) res1;
-			return buf-srcbuf;
-		} else if (nd.type == RTE_UINT32 && res1 <= UINT32_MAX) {
-			if (res) *(uint32_t *)res = (uint32_t) res1;
-			return buf-srcbuf;
-		} else if (nd.type == RTE_UINT64) {
-			if (res) *(uint64_t *)res = res1;
-			return buf-srcbuf;
-		} else {
-			return -1;
-		}
-		break;
+	if (st != BIN_OK)
+		return -1;
+
+	*res = uintres;
+	return buf - srcbuf;
+}
 
-	case DEC_NEG_OK:
-		if (nd.type == RTE_INT8 &&
-				res1 <= INT8_MAX + 1) {
-			if (res) *(int8_t *)res = (int8_t) (-res1);
-			return buf-srcbuf;
-		} else if (nd.type == RTE_INT16 &&
-				res1 <= (uint16_t)INT16_MAX + 1) {
-			if (res) *(int16_t *)res = (int16_t) (-res1);
-			return buf-srcbuf;
-		} else if (nd.type == RTE_INT32 &&
-				res1 <= (uint32_t)INT32_MAX + 1) {
-			if (res) *(int32_t *)res = (int32_t) (-res1);
-			return buf-srcbuf;
-		} else if (nd.type == RTE_INT64 &&
-				res1 <= (uint64_t)INT64_MAX + 1) {
-			if (res) *(int64_t *)res = (int64_t) (-res1);
-			return buf-srcbuf;
-		} else {
-			return -1;
-		}
+static int
+write_num(enum cmdline_numtype type, void *res, uint64_t uintres)
+{
+	switch (type) {
+	case RTE_UINT8:
+		*(uint8_t *)res = (uint8_t)uintres;
+		break;
+	case RTE_UINT16:
+		*(uint16_t *)res = (uint16_t)uintres;
+		break;
+	case RTE_UINT32:
+		*(uint32_t *)res = (uint32_t)uintres;
+		break;
+	case RTE_UINT64:
+		*(uint64_t *)res = uintres;
+		break;
+	case RTE_INT8:
+		*(int8_t *)res = (int8_t)uintres;
+		break;
+	case RTE_INT16:
+		*(int16_t *)res = (int16_t)uintres;
+		break;
+	case RTE_INT32:
+		*(int32_t *)res = (int32_t)uintres;
+		break;
+	case RTE_INT64:
+		*(int64_t *)res = (int64_t)uintres;
 		break;
 	default:
-		debug_printf("error\n");
+		debug_printf("Wrong number type\n");
 		return -1;
 	}
+	return 0;
+}
+
+/* parse an int */
+RTE_EXPORT_SYMBOL(cmdline_parse_num)
+int
+cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
+	unsigned ressize)
+{
+	struct cmdline_token_num_data nd;
+
+	if (!tk)
+		return -1;
+
+	if (!srcbuf || !*srcbuf)
+		return -1;
+
+	memcpy(&nd, &((struct cmdline_token_num *)tk)->num_data, sizeof(nd));
+
+	/* check that we have enough room in res */
+	if (res && check_res_size(&nd, ressize) < 0)
+		return -1;
+
+	if (nd.type >= RTE_UINT8 && nd.type <= RTE_INT64) {
+		int ret, neg = *srcbuf == '-';
+		uint64_t uintres;
+
+		/* try parsing as number */
+		ret = parse_num(srcbuf, &uintres);
+
+		if (ret < 0) {
+			/* parse failed, try parsing as binary */
+			ret = parse_bin(srcbuf, &uintres);
+			if (ret < 0)
+				return -1;
+		}
+		/* check if we're within valid range */
+		if (check_parsed_num(nd.type, neg, uintres) < 0)
+			return -1;
+
+		/* parsing succeeded, write the value if necessary */
+		if (res && write_num(nd.type, res, uintres) < 0)
+			return -1;
+
+		return ret;
+	}
+	return -1;
 }
 
 
@@ -328,9 +317,9 @@ cmdline_get_help_num(cmdline_parse_token_hdr_t *tk, char *dstbuf, unsigned int s
 
 	memcpy(&nd, &((struct cmdline_token_num *)tk)->num_data, sizeof(nd));
 
-	/* should not happen.... don't so this test */
-	/* if (nd.type >= (sizeof(num_help)/sizeof(const char *))) */
-	/* return -1; */
+	/* ensure we have a valid help message for the given type */
+	if (nd.type >= RTE_DIM(num_help))
+		return -1;
 
 	ret = strlcpy(dstbuf, num_help[nd.type], size);
 	if (ret < 0)
-- 
2.47.1

