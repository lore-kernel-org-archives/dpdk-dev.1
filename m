Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D3CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 16:16:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 955324065D;
	Fri, 29 May 2026 18:16:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8C75E400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 18:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780071366; x=1811607366;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zXC1GeaGRxKol6GI8yU6Zbi9GfWLKP8xMqEjgT5KBVM=;
 b=iraI590OtJBojnTOs2sgzNSN+B+50xPaHDnkHOZZTWO4KdlSbOzXK6Z3
 9pXY2qOzBOMthmwG41khOJwvYsaSBnatPeQKkK8rDPndOVaQ06At50/3/
 sfIMwoYYxzNGyqrO70e6HvacZs9SNPPLO1uzbENnE0Tf0CvMMcl/DDSeu
 GZP6ye0ijHUzzpRnF2kvKgz3Vscik2dFD80OFuft/SY00Hd3ap2BjqCM0
 GiAKLjPyv5Gsvf4uflHHEHxThhgwkLoXG3XBiEIqLA9QneK4ksRS/ZkoT
 Tr6hpFbIcRFxR7sQxiswy7YqK1D8tGkhYho3wZ81xwjEJGBpzAFfr65ln A==;
X-CSE-ConnectionGUID: wPl6EQ6TRca4SxskzgW1Gw==
X-CSE-MsgGUID: tTCQURWJT5efSV5YLiEKiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="106375607"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="106375607"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 09:16:03 -0700
X-CSE-ConnectionGUID: wiJvqg3iQLqM8L4kBQtuLA==
X-CSE-MsgGUID: n83hq4amQTWhUynMX1+ceQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="266756029"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 29 May 2026 09:16:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 1/6] eal: reject non-numeric input in str to size
Date: Fri, 29 May 2026 17:15:48 +0100
Message-ID: <0f4f34f49024583025a28640c770235da6ae1893.1780071269.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780071269.git.anatoly.burakov@intel.com>
 <cover.1780071269.git.anatoly.burakov@intel.com>
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

Add a check in rte_str_to_size validating that strtoull() consumed at least
one character. If not, set errno to EINVAL and return 0.

Also move rte_str_to_size unit coverage from malloc tests to
string_autotest, where string utility tests belong, and add a new test to
test for handling invalid numerical input.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_malloc.c                 | 30 ------------
 app/test/test_string_fns.c             | 66 ++++++++++++++++++++++++++
 lib/eal/common/eal_common_string_fns.c |  4 ++
 3 files changed, 70 insertions(+), 30 deletions(-)

diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index 344a730e28..da868c8091 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -271,35 +271,6 @@ test_reordered_free(void)
 	return ret;
 }
 
-/* test function inside the malloc lib*/
-static int
-test_str_to_size(void)
-{
-	struct {
-		const char *str;
-		uint64_t value;
-	} test_values[] =
-	{{ "5G", (uint64_t)5 * 1024 * 1024 *1024 },
-			{"0x20g", (uint64_t)0x20 * 1024 * 1024 *1024},
-			{"10M", 10 * 1024 * 1024},
-			{"050m", 050 * 1024 * 1024},
-			{"8K", 8 * 1024},
-			{"15k", 15 * 1024},
-			{"0200", 0200},
-			{"0x103", 0x103},
-			{"432", 432},
-			{"-1", 0}, /* negative values return 0 */
-			{"  -2", 0},
-			{"  -3MB", 0},
-			{"18446744073709551616", 0} /* ULLONG_MAX + 1 == out of range*/
-	};
-	unsigned i;
-	for (i = 0; i < RTE_DIM(test_values); i++)
-		if (rte_str_to_size(test_values[i].str) != test_values[i].value)
-			return -1;
-	return 0;
-}
-
 static int
 test_multi_alloc_statistics(void)
 {
@@ -1145,7 +1116,6 @@ test_free_sensitive(void)
 static struct unit_test_suite test_suite = {
 	.suite_name = "Malloc test suite",
 	.unit_test_cases = {
-		TEST_CASE(test_str_to_size),
 		TEST_CASE(test_zero_aligned_alloc),
 		TEST_CASE(test_malloc_bad_params),
 		TEST_CASE(test_realloc),
diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index 786eda9e49..697cb7ed15 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <stddef.h>
+#include <inttypes.h>
 #include <errno.h>
 #include <string.h>
 
@@ -314,6 +315,69 @@ test_rte_basename(void)
 	return 0;
 }
 
+static int
+test_rte_str_to_size(void)
+{
+	struct {
+		const char *str;
+		uint64_t value;
+	} valid_values[] = {
+		{"5G", (uint64_t)5 * 1024 * 1024 * 1024},
+		{"0x20g", (uint64_t)0x20 * 1024 * 1024 * 1024},
+		{"10M", 10 * 1024 * 1024},
+		{"050m", 050 * 1024 * 1024},
+		{"8K", 8 * 1024},
+		{"15k", 15 * 1024},
+		{"0200", 0200},
+		{"0x103", 0x103},
+		{"432", 432},
+		{"-1", 0},
+		{"  -2", 0},
+		{"  -3MB", 0},
+	};
+	struct {
+		const char *str;
+	} invalid_values[] = {
+		/* we can only check for invalid input at the start of the string */
+		{"garbage"},
+		{""},
+		{"   "},
+	};
+	unsigned int i;
+	uint64_t value;
+
+	LOG("Checking valid rte_str_to_size inputs\n");
+
+	for (i = 0; i < RTE_DIM(valid_values); i++) {
+		errno = 0;
+		value = rte_str_to_size(valid_values[i].str);
+		if (value != valid_values[i].value) {
+			LOG("FAIL: valid input '%s'\n", valid_values[i].str);
+			return -1;
+		}
+		LOG("PASS: valid input '%s' -> %" PRIu64 "\n",
+			valid_values[i].str, value);
+	}
+
+	LOG("Checking invalid rte_str_to_size inputs\n");
+
+	for (i = 0; i < RTE_DIM(invalid_values); i++) {
+		errno = 0;
+		(void)rte_str_to_size(invalid_values[i].str);
+		if (errno == 0) {
+			LOG("FAIL: invalid input '%s' did not set errno\n",
+				invalid_values[i].str);
+			return -1;
+		}
+		LOG("PASS: invalid input '%s' set errno=%d\n",
+			invalid_values[i].str, errno);
+	}
+
+	LOG("%s - PASSED\n", __func__);
+
+	return 0;
+}
+
 static int
 test_string_fns(void)
 {
@@ -325,6 +389,8 @@ test_string_fns(void)
 		return -1;
 	if (test_rte_basename() < 0)
 		return -1;
+	if (test_rte_str_to_size() < 0)
+		return -1;
 	return 0;
 }
 
diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index fa87831c3a..e0dc48bd80 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -85,6 +85,10 @@ rte_str_to_size(const char *str)
 
 	errno = 0;
 	size = strtoull(str, &endptr, 0);
+	if (endptr == str) {
+		errno = EINVAL;
+		return 0;
+	}
 	if (errno)
 		return 0;
 
-- 
2.47.3

