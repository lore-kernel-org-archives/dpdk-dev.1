Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968DC107BCC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 16:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0074D402D4;
	Fri, 13 Mar 2026 17:06:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9B80D4026C
 for <dev@dpdk.org>; Fri, 13 Mar 2026 17:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773418004; x=1804954004;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zXC1GeaGRxKol6GI8yU6Zbi9GfWLKP8xMqEjgT5KBVM=;
 b=ma6CkkJVRK9b5f3MZsoSqz3AGFcPq8rnJKijA+0iTHFNTY6U+TovmXf0
 AfMSZiBnCXIzV/DgNGDuq/qjt+KiGi906J6ZYWWY8SeCFtjhVD9m5zYun
 MTFIPeTTcXvs3WPBfUb8Ssyes1xB71emS4F5HUt2G0sI5BrfnisvuiVIp
 rZ0K9XTaGPJWchUmK++gXySuaXDKQ9FWrm7qC1mE31txtaaT/dt1b0QM/
 q0F8+OYPXu1Ac27RzIVYIoi/tGSbLNZ4GoCqVxnSesBGR0YtgD/Oed9JJ
 9OZVAelrEUIpIvZKwIKYdE27A3yF3bUCRySq6pYum3DK6gHfRByKsdx7i A==;
X-CSE-ConnectionGUID: fVIDfeaEQ62B0P1vMvhIsw==
X-CSE-MsgGUID: l7tzvSjbSBmx/7WxDrrfcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74563520"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="74563520"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 09:06:42 -0700
X-CSE-ConnectionGUID: Cy9mpwayTluE9Mu5X50Qyw==
X-CSE-MsgGUID: 1pN3GIyFTSmMpMEPz/iOgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="246377238"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 13 Mar 2026 09:06:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 1/6] eal: reject non-numeric input in str to size
Date: Fri, 13 Mar 2026 16:06:32 +0000
Message-ID: <9a66399f084c1e1b4deb0ed61210c7918c9ac2a9.1773417833.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
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

