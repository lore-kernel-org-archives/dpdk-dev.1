Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024B7C3ABBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 15:22:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C43E64025D;
	Wed,  7 May 2025 17:22:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id DF4774025A
 for <dev@dpdk.org>; Wed,  7 May 2025 17:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746631337; x=1778167337;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xMKHOP6ikaG+2GaaLI0o/3hxs92TRaWSGR5SuP8Bazo=;
 b=VRMUG6vR9qmDwi+HRXesB6CT69VhXhhXnvTokdxOip6DV7BTFLaDgik6
 aaLHLtvJSLa4pCF+VvujlyKUnCqY8XqxaMe24v11+VsvQDqlE6TsIeSlS
 CgVxURIIc1IpgilVECNNmN1kiNcg2I5ggtBrws23y4weAgSMfXtHRaQQm
 Yi4qxbkIffDweGsX1eWOdzyEh1qDl/EgR650ubS27Co6Sy//3Z3y6Ml6A
 Gc6jT5V+BKritJXsv28I7MZMt8xqpzIB3xwcNbxaa3pY9q5S88OkVsGiC
 +qYHrSHwb6MVY5nWAgUkMfvyfr3rjTBkyshJpTLTk19WucgVO7MwaaP4K A==;
X-CSE-ConnectionGUID: YrBWWwp4RmacGEhcbBAtyQ==
X-CSE-MsgGUID: YD6AOT8cQNO5/1f0bAnwZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48526370"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="48526370"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 08:22:16 -0700
X-CSE-ConnectionGUID: ZMnoDR53RRuheSsPdHSTow==
X-CSE-MsgGUID: yt6nXkAtSBWOfoRrljsNUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="136997842"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa009.fm.intel.com with ESMTP; 07 May 2025 08:22:14 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v5 1/3] cmdline: use C standard library as number parser
Date: Wed,  7 May 2025 16:22:10 +0100
Message-ID: <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
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
into account a few quirks:

- We do not consider "negative" numbers to be valid for anything other than
  base-10 numbers, whereas C standard library does. We work around that by
  forcing base-10 when parsing numbers we expect to be negative.
- We do not consider numbers such as "+4" to be valid, whereas C standard
  library does. No one probably relies on this, so we just remove it from
  our tests, as it is now a valid number.
- C standard library's strtoull does not do range checks on negative
  numbers, so we have to parse knowingly-negative numbers as signed. We've
  already changed this to be the case on account of point 1 from this list,
  so no biggie.
- C standard library does not support binary numbers, so we keep around the
  relevant parts of the custom parser in place to support binary numbers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_cmdline_num.c     |   1 -
 lib/cmdline/cmdline_parse_num.c | 353 +++++++++++++++-----------------
 2 files changed, 167 insertions(+), 187 deletions(-)

diff --git a/app/test/test_cmdline_num.c b/app/test/test_cmdline_num.c
index 9276de59bd..471e9964ee 100644
--- a/app/test/test_cmdline_num.c
+++ b/app/test/test_cmdline_num.c
@@ -205,7 +205,6 @@ const char * num_invalid_strs[] = {
 		"1E3",
 		"0A",
 		"-B",
-		"+4",
 		"1.23G",
 		"",
 		" ",
diff --git a/lib/cmdline/cmdline_parse_num.c b/lib/cmdline/cmdline_parse_num.c
index f21796bedb..f7ccd26d96 100644
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
 
@@ -93,133 +77,106 @@ check_res_size(struct cmdline_token_num_data *nd, unsigned ressize)
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
+		if (neg || uintres > UINT8_MAX)
+			return -1;
+		return 0;
+	case RTE_UINT16:
+		if (neg || uintres > UINT16_MAX)
+			return -1;
+		return 0;
+	case RTE_UINT32:
+		if (neg || uintres > UINT32_MAX)
+			return -1;
+		return 0;
+	case RTE_UINT64:
+		if (neg)
+			return -1;
+		return 0;
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
+		lo_ok = 1; /* always valid */
+		hi_ok = neg || uintres <= INT64_MAX;
+		break;
+	default:
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
+	errno = 0;
+	if (neg)
+		/* for negatives, only support base-10 */
+		uintres = (uint64_t)strtoll(srcbuf, &end, 10);
+	else
+		/* 0 means autodetect base */
+		uintres = strtoull(srcbuf, &end, 0);
+
+	if (end == srcbuf || !cmdline_isendoftoken(*end) || errno == ERANGE)
+		return -1;
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
@@ -230,7 +187,7 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
 			/* fall-through */
 		case BIN_OK:
 			if (c >= '0' && c <= '1') {
-				if (add_to_res(c - '0', &res1, 2) < 0)
+				if (add_to_bin(c - '0', &uintres) < 0)
 					st = ERROR;
 			}
 			else {
@@ -239,10 +196,10 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
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
@@ -252,66 +209,90 @@ cmdline_parse_num(cmdline_parse_token_hdr_t *tk, const char *srcbuf, void *res,
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
+	if (st != BIN_OK)
+		return -1;
+
+	*res = uintres;
+	return buf - srcbuf;
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
+	if (res) {
+		if (check_res_size(&nd, ressize) < 0)
 			return -1;
+	}
+
+	if (nd.type >= RTE_UINT8 && nd.type <= RTE_INT64) {
+		int ret, neg = *srcbuf == '-';
+		uint64_t uintres;
+
+		/*
+		 * for backwards compatibility with previous iterations of
+		 * cmdline library, we need to take into account a few things:
+		 *
+		 * - we only support negatives when they're decimal
+		 * - we support binary which isn't supported by C parsers
+		 * - strtoull does not do range checks on negative numbers
+		 */
+		ret = parse_num(srcbuf, &uintres);
+
+		if (ret < 0) {
+			/* parse failed, try parsing as binary */
+			ret = parse_bin(srcbuf, &uintres);
+			if (ret < 0)
+				return -1;
 		}
-		break;
-
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
+		/* check if we're within valid range */
+		if (check_parsed_num(nd.type, neg, uintres) < 0)
+			return -1;
+
+		switch (nd.type) {
+		case RTE_UINT8:
+			if (res) *(uint8_t *)res = (uint8_t)uintres;
+			break;
+		case RTE_UINT16:
+			if (res) *(uint16_t *)res = (uint16_t)uintres;
+			break;
+		case RTE_UINT32:
+			if (res) *(uint32_t *)res = (uint32_t)uintres;
+			break;
+		case RTE_UINT64:
+			if (res) *(uint64_t *)res = uintres;
+			break;
+		case RTE_INT8:
+			if (res) *(int8_t *)res = (int8_t)uintres;
+			break;
+		case RTE_INT16:
+			if (res) *(int16_t *)res = (int16_t)uintres;
+			break;
+		case RTE_INT32:
+			if (res) *(int32_t *)res = (int32_t)uintres;
+			break;
+		case RTE_INT64:
+			if (res) *(int64_t *)res = (int64_t)uintres;
+			break;
+		default:
 			return -1;
 		}
-		break;
-	default:
-		debug_printf("error\n");
-		return -1;
+		return ret;
 	}
+	return -1;
 }
 
 
-- 
2.47.1

