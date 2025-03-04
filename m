Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8BC282D0
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 21:53:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33E8040395;
	Tue,  4 Mar 2025 22:53:46 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B83B5402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 22:53:43 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D7CED210EAF6; Tue,  4 Mar 2025 13:53:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7CED210EAF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741125222;
 bh=+zfbMwI3L2z7Do3Fgz5P1/IgoIF1b1VqR7O2myDN2L0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LWWuzCdcj9H93ZI8JhhB3bu6WB9u8xr/VR3Dcdckz/28UmyKSbw59R0/GdqspsqJp
 8MFzGcYyPotubu+gX3r5eBl31bf4slnTx+WI/+jpShSjVqsubDkS6ifVGyz49Y3xbV
 /wZ/c0LWRxJeGV24TUuP1H3nRkQSnJ4kVQeimffc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v2 2/2] app/test: add test_init_m128i using compiler intrinsic
Date: Tue,  4 Mar 2025 13:53:19 -0800
Message-Id: <1741125199-1217-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
 <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
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

This test initializes an __m128i data type using the old
non-portable way used until now and the more portable way
using compiler intrinsics. The test ensures the resulting
values after initialization match.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_thash.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/app/test/test_thash.c b/app/test/test_thash.c
index 33b0c6adac..5f7081a3ad 100644
--- a/app/test/test_thash.c
+++ b/app/test/test_thash.c
@@ -1029,6 +1029,35 @@ test_keygen(void)
 	return TEST_SUCCESS;
 }
 
+#ifdef RTE_ARCH_X86
+#ifndef RTE_TOOLCHAIN_MSVC
+static int
+test_init_m128i(void)
+{
+	/* When initializing __m128i with two constant values like below
+	 * MSVC issues warning C4305:
+	 *     'initializing': truncation from 'unsigned __int64' to 'char'
+	 */
+	static const __m128i a = {
+			0x0405060700010203ULL, 0x0C0D0E0F08090A0BULL};
+
+	/* Using compiler intrinsics to initialize __m128i is therefore
+	 * preferred, like below
+	 */
+	const __m128i b = _mm_set_epi64x(
+			0x0C0D0E0F08090A0BULL, 0x0405060700010203ULL);
+
+	if (memcmp(&a, &b, sizeof(a)) != 0) {
+		printf("Same value was expected when initializing data "
+				"type using compiler intrinsic\n");
+		return -1;
+	}
+
+	return TEST_SUCCESS;
+}
+#endif
+#endif
+
 static struct unit_test_suite thash_tests = {
 	.suite_name = "thash autotest",
 	.setup = NULL,
@@ -1051,6 +1080,11 @@ static struct unit_test_suite thash_tests = {
 	TEST_CASE(test_adjust_tuple),
 	TEST_CASE(test_adjust_tuple_mult_reta),
 	TEST_CASE(test_keygen),
+#ifdef RTE_ARCH_X86
+#ifndef RTE_TOOLCHAIN_MSVC
+	TEST_CASE(test_init_m128i),
+#endif
+#endif
 	TEST_CASES_END()
 	}
 };
-- 
2.48.1.vfs.0.0

