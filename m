Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1E5C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F19FF42E9B;
	Tue, 15 Sep 2026 21:23:16 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 4F87F42EAE
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:23:14 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so38263a91.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500193;
 x=1790104993; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kMEGIil9YAwuvZDiLzxjZQGi3OczRFWj5zWN0sIV4qQ=;
 b=KjeoiwJvQu325CfRgsqXp5zAFpHzWTOm8gAy8GXBFOO4hKcf8LS4o5GrNcHECs6MDa
 wXQhJaObIL7EftqQDC6n5tAwfqZ+eP2/1jSDAKkwXD4lNCpcPcYUa0e/DysiuAQ4s6uR
 F72YbiSMb9SZNTUXv0WG5AduNehTcxOsx1sujQEIoY6sW3vxdQpCqkGc/hCJZDqhJgLN
 pPUI7LT5BTHfM9Q7z/o/OYxzbkQZhSXU989C+KC2/3jEGmS73Iv2jdQOWy1gehqJ6Tmu
 WYq+hc39ygvCD79aa0fe6Ip7AM3h3D87L5qlZK+oZpQdwYhlnMqLHj/HoPrKBDZ19S4R
 5R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500193; x=1790104993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kMEGIil9YAwuvZDiLzxjZQGi3OczRFWj5zWN0sIV4qQ=;
 b=pHKJOCcF6i02L7W9gwbAv4f/BQ6PuVVfwRaOJGtdGvp/qAS+B1zjaiE+U19D5iJSYf
 UbQddtYOWZkATODoLE8WdWjjQsgSkK4MESEUcvTlhpKN4gw7DVVUltQwhzwvAix1bZUA
 ZDhdxY+G8H8tnAEhoCPBAK573SjxR5ZzvylzBAoiuQsIbNDZYydnUIxfP/cCmK4HBB19
 lbNjSuTfavDcdprCMq+7rT48S4NhigRvRxOoV4ff/Q+OXtCKurfBOCCZ/WUAlmJPWLDf
 niN9yhQ0mltyVlDEfI8Iem/c6Fr2mdSWIGdH+esCQ4etcqu4HgraF6v4HBr6N/KYPfVM
 Y1rQ==
X-Gm-Message-State: AFuF++k/qOuVD7EL+8kh2bKG+aQByFLTwSD/czqMr398PcjVGSTvy6Nm
 xtNwpoeCzGJj/Niy85C4mN9KLKVJzPRWGbQ5Ng3nXQki5iai98NCF5j85Hc/iW69f0/lflsub6V
 gDhwh47qEIA==
X-Gm-Gg: AYBFou1hpWxSQrDay1pnwG5j9Epkd03PWUrmWNdHWfE7PMfEkYbr/7VA6ANYNgg3CNB
 IzfnUwEOF+ZN/abwm0JkVbdOCgC7dm8O+kTvva8cI2bg8xt/FRIh4VlE9yNkXk+xLOzu5nNhE/0
 +2g6g7+KIeKd80H/x5Bd2xUnrrIyC+Lb9uSGBcxCg+l5TifMVoSvc/7Be5/bo10UFdAF8M0Tnk7
 Cmr2WmhkbwPeOe6mcqIs23uLdT8wLBy70QMeryvFw5wFryTevvTLtefHRDtmSMpiq2oORyw/qZa
 1ccYujui4Cbjj+jxSbG8XWl89IdYU34Zglj0iki2ARbs6jhdSsIL3GlU4SIZI11/LHwvxHO8lR7
 oGM5reUrNVn9zzUimBE/H6clcXKkP9s2FpM6SXzoJ5AEWrt87+uDfu/pMGyXCHRbDvkb0vCIpqF
 BK4tIPLsXpUTBuwGNkwBvJ2BuzVU46VjzFC/r2MiH3205t3BrSNrhFc2cvV++8oqDgCr6xUrblT
 nFO1SJBnUGRHGFsyTV5v2npi+me98SchMTQnA==
X-Received: by 2002:a17:90b:4486:b0:395:8124:ac53 with SMTP id
 98e67ed59e1d1-39dfe0471c8mr5314693a91.6.1789500193336; 
 Tue, 15 Sep 2026 12:23:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:23:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 17/18] test: add random number generator tests
Date: Tue, 15 Sep 2026 12:21:15 -0700
Message-ID: <20260915192207.3926217-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

Add functional tests for rte_random_bytes() and rte_rand32(). The
rte_random_bytes() cases cover a zero length request, requests smaller
than the internal chunk size, a request large enough to be split into
several chunks, and that two calls do not return the same bytes. Each
case also checks that nothing is written past the requested length.

The rte_rand32() cases check that every bit position is both set and
clear across a number of draws, and that rte_srand() makes the
sequence repeatable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build   |   1 +
 app/test/test_random.c | 297 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 298 insertions(+)
 create mode 100644 app/test/test_random.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 51abeeb732..794e4e5962 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -158,6 +158,7 @@ source_file_deps = {
     'test_prefetch.c': [],
     'test_ptr_compress.c': ['ptr_compress'],
     'test_rand_perf.c': [],
+    'test_random.c': [],
     'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
     'test_rcu_qsbr.c': ['rcu', 'hash'],
     'test_rcu_qsbr_perf.c': ['rcu', 'hash'],
diff --git a/app/test/test_random.c b/app/test/test_random.c
new file mode 100644
index 0000000000..f0084f5abb
--- /dev/null
+++ b/app/test/test_random.c
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <inttypes.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_random.h>
+
+#include "test.h"
+
+/* Larger than the chunk size rte_random_bytes() splits requests into,
+ * and not a multiple of it, so the loop is exercised.
+ */
+#define BIG_LEN (3 * 256 + 7)
+
+/* Fill pattern, any byte left untouched by the call is visible. */
+#define FILL_BYTE 0xa5
+
+static bool
+all_equal(const uint8_t *buf, size_t len, uint8_t val)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		if (buf[i] != val)
+			return false;
+
+	return true;
+}
+
+static int
+test_random_bytes_zero(void)
+{
+	uint8_t buf[8];
+
+	memset(buf, FILL_BYTE, sizeof(buf));
+
+	TEST_ASSERT(rte_random_bytes(buf, 0) == 0,
+		    "zero length request failed");
+	TEST_ASSERT(all_equal(buf, sizeof(buf), FILL_BYTE),
+		    "zero length request wrote to the buffer");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_random_bytes_small(void)
+{
+	uint8_t buf[32];
+	unsigned int i;
+
+	/* A single byte is worth checking on its own, it is the
+	 * smallest request that must still be filled.
+	 */
+	for (i = 1; i <= sizeof(buf); i++) {
+		memset(buf, FILL_BYTE, sizeof(buf));
+
+		TEST_ASSERT(rte_random_bytes(buf, i) == 0,
+			    "request of %u bytes failed", i);
+		TEST_ASSERT(all_equal(buf + i, sizeof(buf) - i, FILL_BYTE),
+			    "request of %u bytes wrote past the end", i);
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_random_bytes_large(void)
+{
+	uint8_t buf[BIG_LEN + 8];
+
+	memset(buf, FILL_BYTE, sizeof(buf));
+
+	/* Must be split internally and still filled completely. */
+	TEST_ASSERT(rte_random_bytes(buf, BIG_LEN) == 0,
+		    "request of %d bytes failed", BIG_LEN);
+	TEST_ASSERT(all_equal(buf + BIG_LEN, sizeof(buf) - BIG_LEN, FILL_BYTE),
+		    "request of %d bytes wrote past the end", BIG_LEN);
+	TEST_ASSERT(!all_equal(buf, BIG_LEN, 0),
+		    "request of %d bytes returned all zero", BIG_LEN);
+	TEST_ASSERT(!all_equal(buf, BIG_LEN, FILL_BYTE),
+		    "request of %d bytes left the buffer untouched", BIG_LEN);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_random_bytes_distinct(void)
+{
+	uint8_t a[64], b[64];
+
+	TEST_ASSERT(rte_random_bytes(a, sizeof(a)) == 0, "first call failed");
+	TEST_ASSERT(rte_random_bytes(b, sizeof(b)) == 0, "second call failed");
+
+	/* The chance of a false failure here is 2^-512. */
+	TEST_ASSERT(memcmp(a, b, sizeof(a)) != 0,
+		    "two calls returned the same bytes");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_rand(void)
+{
+	unsigned int i;
+	uint64_t any_set = 0;
+	uint64_t always_set = UINT64_MAX;
+
+	/* Every bit position should be both set and clear at some
+	 * point, which catches a generator that is stuck or that only
+	 * ever fills part of the word.
+	 */
+	for (i = 0; i < 100; i++) {
+		uint64_t v = rte_rand();
+
+		any_set |= v;
+		always_set &= v;
+	}
+
+	TEST_ASSERT(any_set == UINT64_MAX,
+		    "some bits were never set: %#" PRIx64, any_set);
+	TEST_ASSERT(always_set == 0,
+		    "some bits were always set: %#" PRIx64, always_set);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_rand32(void)
+{
+	unsigned int i;
+	uint32_t any_set = 0;
+	uint32_t always_set = UINT32_MAX;
+
+	/* Every bit position should be both set and clear at some
+	 * point, which catches a generator that is stuck or that only
+	 * ever fills part of the word.
+	 */
+	for (i = 0; i < 100; i++) {
+		uint32_t v = rte_rand32();
+
+		any_set |= v;
+		always_set &= v;
+	}
+
+	TEST_ASSERT(any_set == UINT32_MAX,
+		    "some bits were never set: %#x", any_set);
+	TEST_ASSERT(always_set == 0,
+		    "some bits were always set: %#x", always_set);
+
+	return TEST_SUCCESS;
+}
+
+/* Bounds worth covering: the power of two case is handled by masking,
+ * everything else goes through the rejection loop.
+ */
+static const uint64_t rand_max_bounds[] = {
+	2, 3, 17, 64, 1000, 1ULL << 32, (1ULL << 63) + 1, UINT64_MAX,
+};
+
+static int
+test_rand_max(void)
+{
+	unsigned int i, j;
+
+	/* A bound of one leaves only a single legal value. */
+	for (i = 0; i < 100; i++)
+		TEST_ASSERT(rte_rand_max(1) == 0,
+			    "upper bound of 1 returned a non-zero value");
+
+	for (i = 0; i < RTE_DIM(rand_max_bounds); i++) {
+		uint64_t bound = rand_max_bounds[i];
+
+		for (j = 0; j < 10000; j++) {
+			uint64_t v = rte_rand_max(bound);
+
+			TEST_ASSERT(v < bound,
+				    "value %" PRIu64 " is not less than the upper bound %" PRIu64,
+				    v, bound);
+		}
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_rand_max_spread(void)
+{
+	unsigned int i;
+	bool seen[3] = { false, false, false };
+
+	/* With a small bound every value has to show up quickly. The
+	 * chance of missing one in 100 draws is 3 * (2/3)^100.
+	 */
+	for (i = 0; i < 100; i++)
+		seen[rte_rand_max(RTE_DIM(seen))] = true;
+
+	for (i = 0; i < RTE_DIM(seen); i++)
+		TEST_ASSERT(seen[i], "value %u was never generated", i);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_drand(void)
+{
+	unsigned int i;
+	bool low = false, high = false;
+
+	for (i = 0; i < 100; i++) {
+		double v = rte_drand();
+
+		TEST_ASSERT(v >= 0.0 && v < 1.0,
+			    "value %f is outside of [0.0, 1.0)", v);
+
+		if (v < 0.5)
+			low = true;
+		else
+			high = true;
+	}
+
+	/* Both halves of the interval have to be used, which catches a
+	 * generator stuck on a constant. Missing one has a probability
+	 * of 2^-100.
+	 */
+	TEST_ASSERT(low, "no value below 0.5 was generated");
+	TEST_ASSERT(high, "no value of 0.5 or above was generated");
+
+	return TEST_SUCCESS;
+}
+
+/* Record a sequence that uses every generator function, so that a
+ * function left out of the shared state would show up here.
+ */
+static void
+record_sequence(uint64_t seed, uint64_t *out, unsigned int n)
+{
+	unsigned int i;
+
+	rte_srand(seed);
+
+	for (i = 0; i < n; i += 4) {
+		out[i] = rte_rand();
+		out[i + 1] = rte_rand32();
+		out[i + 2] = rte_rand_max(1000);
+		out[i + 3] = (uint64_t)(rte_drand() * (1ULL << 53));
+	}
+}
+
+static int
+test_srand_repeatable(void)
+{
+	uint64_t first[16], second[16];
+
+	record_sequence(42, first, RTE_DIM(first));
+	record_sequence(42, second, RTE_DIM(second));
+
+	TEST_ASSERT(memcmp(first, second, sizeof(first)) == 0,
+		    "same seed produced a different sequence");
+
+	record_sequence(43, second, RTE_DIM(second));
+
+	TEST_ASSERT(memcmp(first, second, sizeof(first)) != 0,
+		    "different seed produced the same sequence");
+
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite random_test_suite = {
+	.suite_name = "random autotest",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_random_bytes_zero),
+		TEST_CASE(test_random_bytes_small),
+		TEST_CASE(test_random_bytes_large),
+		TEST_CASE(test_random_bytes_distinct),
+		TEST_CASE(test_rand),
+		TEST_CASE(test_rand32),
+		TEST_CASE(test_rand_max),
+		TEST_CASE(test_rand_max_spread),
+		TEST_CASE(test_drand),
+		TEST_CASE(test_srand_repeatable),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_random(void)
+{
+	return unit_test_suite_runner(&random_test_suite);
+}
+
+REGISTER_FAST_TEST(random_autotest, NOHUGE_OK, ASAN_OK, test_random);
-- 
2.53.0

