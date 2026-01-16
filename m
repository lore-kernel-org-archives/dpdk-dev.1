Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10303C98306
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 23:19:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3349042E95;
	Sat, 17 Jan 2026 00:19:14 +0100 (CET)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 5CB68402DA
 for <dev@dpdk.org>; Sat, 17 Jan 2026 00:19:12 +0100 (CET)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-11f36012fb2so3833193c88.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 15:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768605551; x=1769210351; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zTEOdic9bcKQDYl9HMKFzvzfr9t0S2b0G3p3T/1g5k=;
 b=OLgNfs3V7gVBU+H+3k7jMHeH1079IG3yDSm2pteorIKFeRV6JCOjrClEiRLg9Fsur1
 oD6GtZwK+zXkTZ5EKEcAVxb4Lt4EaeVtOtWA+FUgEysKctH4Lz5qhPZErRRlzZln7dZY
 VZGRjWue2No8OoCwG0R1V8IiztY7Yp4mE4+p9+/VBO+gFdzSGdmEPJjOE4DDpGoiI0+o
 h1jPLkovlb/N45/j/ZkX3LGO65rfxY5BKI6Pnjauxyi8KpA2/qAjzyfFtkh8cYxFgdmY
 /QrUSWwKPhSv+A0B1Vp0y+Dq3PK4IVAjeLycFJ/OsqwP9ESn5ZvFitWxPPTSvqHLamwo
 50UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768605551; x=1769210351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1zTEOdic9bcKQDYl9HMKFzvzfr9t0S2b0G3p3T/1g5k=;
 b=AkjYCGMQQ8iSBhun61CTX6V8T60BCK71tqgiN3MzgaDQ32HKccGUM2hV+FmsKL7kbc
 7BvSFblO5reDmWPvMgujxQWfqZRBMXKFfgFs5GHk6rkysWcnhzCi0L0qaQmQ++2nYM18
 JmNhXeVhAOrj16DQKktxWElYLiOG+HW5qemvHnAJrNTp5x4dMXPnxEGYTG0xht3ZoQhl
 xP0fRrOictNJUl6JyopX5Xqx6f8mnAL16OjXiznyWwyLUIawtwg+e3vPPHqi3Ri347VK
 phUED+iMP4CGbB8r798f0WbuQ2AReUdg1Wl3AVDVEgDf+yTRgeg0Akxw2YiGzE+eYQ7M
 Q78A==
X-Gm-Message-State: AOJu0Yw+whkOhl/lAx3EEeVoGgB9CYmMWcYyGYETjO+KKWbADwPBsoC9
 ClGA0wFJzZY2/61FUFb3+Jcfegrv2gYnfS20Y71+15Swt22jURCZLvgJdg3W5g==
X-Gm-Gg: AY/fxX6x2azKT+XX8QhV2EhWxMXmEnGAdH+yfJAQqT4p2u582YGVl84IWUlUAokBKxn
 F2dUu1a+rSI2yAUFk1j1bbNhTGl5llx8Ax3vw/17lEyyoyMpJLfvJ5ZNsjgp+uIwctGYMI0H+E3
 +wjYX5/Wv749nvdCXSq9j+WIX+wgEGZRQZ1cvrBiQqpbu0ULgesZnnFStBoeQWX8Ez8brQ921T1
 U5SGG5cFzNtN8ZOPdEd3RuPYzF9xvDES6VEG7sSWYTKKmCtH76NAGcQmJMfgJY4h4tCZ6qzA7bt
 LnsIDXBB4T09oZ7MoOoUq8ubZmCCDkqNCxsfCd7QgHJXqRykNJ2NKJQm9e3DK2ijjaSaNblD6Sk
 w9ytwKl86K1V+Ob+NsOUwsXvv6A9a+gpcI6vNBXc3bSmtFa8oCFf8rx1e4iAhyUvgqm8ZfFxxt/
 H5sh93PJ2R/ptF0qv9xlL1mmQCvw+Eh73I
X-Received: by 2002:a05:7022:928:b0:11b:803c:2cf5 with SMTP id
 a92af1059eb24-1244b36ef57mr3357093c88.33.1768605551073; 
 Fri, 16 Jan 2026 15:19:11 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1244ac6c2besm4967089c88.5.2026.01.16.15.19.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 15:19:10 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v8] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Fri, 16 Jan 2026 15:19:07 -0800
Message-Id: <20260116231907.13895-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260114215648.47820-1-scott.k.mitch1@gmail.com>
References: <20260114215648.47820-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Modify RTE_PTR_ADD and RTE_PTR_SUB to use char* pointer arithmetic
on Clang instead of uintptr_t casts. Benefits of this approach:
- API compatibility: works for both integer and pointer inputs
- Retains simple macros: no pragmas, no _Generic
- Enables Clang optimizations: Clang can now unroll and vectorize
  pointer loops. GCC uses uintptr_t to avoid false positive warnings.

Example use case which benefits is __rte_raw_cksum. Performance
results from cksum_perf_autotest on Intel Xeon (Cascade Lake,
AVX-512) built with Clang 18.1 (TSC cycles/byte):
  Block size    Before    After    Improvement
         100      0.40     0.24        ~40%
        1500      0.50     0.06        ~8x
        9000      0.49     0.06        ~8x

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

---
v8:
- Remove tests for types < 32-bit (bool, char, short, uint8_t, uint16_t)
- Merge test_ptr_add_sub_typedefs() into test_ptr_add_sub_integer_types()
- Separate RTE_PTR_ADD and RTE_PTR_SUB documentation
- Move Clang/GCC implementation note from Doxygen to regular comment
- Tests verify both intermediate ADD result and SUB round-trip
- Use uintptr_t cast consistently for all integer-to-pointer conversions
- Make TEST_RETVAL calculated from TEST_INITVAL + TEST_INCREMENT

v7:
- Fix tests: use TEST_BUFFER_SIZE macro for buffer allocation
- Fix tests: ADD then SUB same amount to avoid out-of-bounds pointer arithmetic
- All RTE_PTR_SUB tests now verify round-trip (ADD+SUB returns to original)

v6:
- Make char* optimization Clang-only to avoid GCC false positive warnings
- Improve tests: use named constants instead of magic numbers
- Improve tests: use void* casts on expected values instead of uintptr_t on results

v5:
- Initial implementation with char* arithmetic for all compilers

v4:
- Used _Generic for type-based dispatch with char* casts
- Had warnings on both Clang and GCC due to _Generic type-checking all branches
---
 app/test/meson.build         |   1 +
 app/test/test_ptr_add_sub.c  | 193 +++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_common.h |  15 ++-
 3 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 app/test/test_ptr_add_sub.c

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..80a19d65ba 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -152,6 +152,7 @@ source_file_deps = {
     'test_power_intel_uncore.c': ['power', 'power_intel_uncore'],
     'test_power_kvm_vm.c': ['power', 'power_kvm_vm'],
     'test_prefetch.c': [],
+    'test_ptr_add_sub.c': [],
     'test_ptr_compress.c': ['ptr_compress'],
     'test_rand_perf.c': [],
     'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
diff --git a/app/test/test_ptr_add_sub.c b/app/test/test_ptr_add_sub.c
new file mode 100644
index 0000000000..9674362d8d
--- /dev/null
+++ b/app/test/test_ptr_add_sub.c
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Apple Inc.
+ */
+
+#include "test.h"
+#include <stdint.h>
+
+#include <rte_common.h>
+
+/* Test constants for 32-bit and 64-bit integer types */
+#define TEST_INITVAL 0x1000
+#define TEST_INCREMENT 100
+#define TEST_RETVAL ((void *)(TEST_INITVAL + TEST_INCREMENT))
+
+/* Buffer size for pointer tests */
+#define TEST_BUFFER_SIZE (TEST_INCREMENT + 256)
+
+/* Test 32-bit and 64-bit integer types */
+static int
+test_ptr_add_sub_integer_types(void)
+{
+	void *result;
+
+	unsigned long long ull = TEST_INITVAL;
+	result = RTE_PTR_ADD(ull, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for unsigned long long");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(uintptr_t)ull,
+		"RTE_PTR_SUB round-trip failed for unsigned long long");
+
+	long long ll = TEST_INITVAL;
+	result = RTE_PTR_ADD(ll, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for long long");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(uintptr_t)ll,
+		"RTE_PTR_SUB round-trip failed for long long");
+
+	unsigned long ul = TEST_INITVAL;
+	result = RTE_PTR_ADD(ul, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for unsigned long");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(uintptr_t)ul,
+		"RTE_PTR_SUB round-trip failed for unsigned long");
+
+	long l = TEST_INITVAL;
+	result = RTE_PTR_ADD(l, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for long");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(uintptr_t)l,
+		"RTE_PTR_SUB round-trip failed for long");
+
+	unsigned int ui = TEST_INITVAL;
+	result = RTE_PTR_ADD(ui, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for unsigned int");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(uintptr_t)ui,
+		"RTE_PTR_SUB round-trip failed for unsigned int");
+
+	int i = TEST_INITVAL;
+	result = RTE_PTR_ADD(i, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for int");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(uintptr_t)i,
+		"RTE_PTR_SUB round-trip failed for int");
+
+	uint64_t u64 = TEST_INITVAL;
+	result = RTE_PTR_ADD(u64, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for uint64_t");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(uintptr_t)u64,
+		"RTE_PTR_SUB round-trip failed for uint64_t");
+
+	uint32_t u32 = TEST_INITVAL;
+	result = RTE_PTR_ADD(u32, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for uint32_t");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(uintptr_t)u32,
+		"RTE_PTR_SUB round-trip failed for uint32_t");
+
+	uintptr_t uptr = TEST_INITVAL;
+	result = RTE_PTR_ADD(uptr, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for uintptr_t");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)uptr,
+		"RTE_PTR_SUB round-trip failed for uintptr_t");
+
+	size_t sz = TEST_INITVAL;
+	result = RTE_PTR_ADD(sz, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, TEST_RETVAL,
+		"RTE_PTR_ADD failed for size_t");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)sz,
+		"RTE_PTR_SUB round-trip failed for size_t");
+
+	return 0;
+}
+
+/* Test pointer types including const correctness */
+static int
+test_ptr_add_sub_pointer_types(void)
+{
+	char buffer[TEST_BUFFER_SIZE];
+	void *result;
+
+	/* Test void* and const void* */
+	void *vp = buffer;
+	result = RTE_PTR_ADD(vp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for void*");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, vp,
+		"RTE_PTR_SUB round-trip failed for void*");
+
+	const void *cvp = buffer;
+	result = RTE_PTR_ADD(cvp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for const void*");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (const void *)cvp,
+		"RTE_PTR_SUB round-trip failed for const void*");
+
+	/* Test char* and const char* */
+	char *cp = buffer;
+	result = RTE_PTR_ADD(cp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for char*");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)cp,
+		"RTE_PTR_SUB round-trip failed for char*");
+
+	const char *ccp = buffer;
+	result = RTE_PTR_ADD(ccp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for const char*");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (const void *)ccp,
+		"RTE_PTR_SUB round-trip failed for const char*");
+
+	/* Test uint32_t* and const uint32_t* */
+	uint32_t *u32p = (uint32_t *)buffer;
+	result = RTE_PTR_ADD(u32p, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for uint32_t*");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)u32p,
+		"RTE_PTR_SUB round-trip failed for uint32_t*");
+
+	const uint32_t *cu32p = (const uint32_t *)buffer;
+	result = RTE_PTR_ADD(cu32p, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed for const uint32_t*");
+	result = RTE_PTR_SUB(result, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result, (const void *)cu32p,
+		"RTE_PTR_SUB round-trip failed for const uint32_t*");
+
+	/* Verify assigning to const pointer works (adding const is safe) */
+	const void *result_const = RTE_PTR_ADD(cvp, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result_const, (const void *)(buffer + TEST_INCREMENT),
+		"RTE_PTR_ADD failed when assigning to const void*");
+	result_const = RTE_PTR_SUB(result_const, TEST_INCREMENT);
+	TEST_ASSERT_EQUAL(result_const, cvp,
+		"RTE_PTR_SUB round-trip failed when assigning to const void*");
+
+	return 0;
+}
+
+/* Main test function that runs all subtests */
+static int
+test_ptr_add_sub(void)
+{
+	int ret;
+
+	ret = test_ptr_add_sub_integer_types();
+	if (ret != 0)
+		return ret;
+
+	ret = test_ptr_add_sub_pointer_types();
+	if (ret != 0)
+		return ret;
+
+	return 0;
+}
+
+REGISTER_FAST_TEST(ptr_add_sub_autotest, true, true, test_ptr_add_sub);
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..f2935929f7 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -551,12 +551,25 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 /**
  * add a byte-value offset to a pointer
  */
-#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
+#ifdef RTE_CC_CLANG
+/*
+ * Clang doesn't optimize through uintptr_t, (char*) enables
+ * optimizations and doesn't generate warnings. GCC does optimize
+ * through uintptr_t but throws warnings (e.g. array-bounds) when cast to char*.
+ */
+#define RTE_PTR_ADD(ptr, x) ((void *)((char *)(uintptr_t)(ptr) + (x)))
+#else
+#define RTE_PTR_ADD(ptr, x) ((void *)((uintptr_t)(ptr) + (x)))
+#endif
 
 /**
  * subtract a byte-value offset from a pointer
  */
+#ifdef RTE_CC_CLANG
+#define RTE_PTR_SUB(ptr, x) ((void *)((char *)(uintptr_t)(ptr) - (x)))
+#else
 #define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
+#endif
 
 /**
  * get the difference between two pointer values, i.e. how far apart
-- 
2.39.5 (Apple Git-154)

