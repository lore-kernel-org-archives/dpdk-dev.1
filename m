Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F052D74EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 444C140269;
	Fri, 23 Jan 2026 17:27:47 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 340404021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:27:46 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-121a0bcd376so7880464c88.0
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769185665; x=1769790465; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0A/+aR7ngwCGGzFcLux6+js9APkWtLra0CUh6WmMBkU=;
 b=BlpKsix3rECl1zywXwHqVOlephbdgKUEy6wBiQ1GqmeH3IszY1SWM9NqM3cKSXjxtb
 gWhFx56H1gmsqkLGyxktZf/VttMI8195ENxgJi6wYt433raEiTVi0YDCrWbsTpbyS3uz
 VFHVZYYpIQL2vGUIjNfUT990cH/lmJc0YVkrxtu+4bzvDzBhaqyc6GOD1vKoSLoLq4fk
 pY4R0GtSGZaqOyekKVg8VD5UlygiYVjWgv4fpkX6jNXXK3IMIXFraNmYK0fI20EQNK9E
 XbptwgksBUqJgEQwKi+FeemcfYOWOlN6e2j3D7Aw7TPg6CQtDCI7qAnKl6AHc3j8R3Gj
 vGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769185665; x=1769790465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0A/+aR7ngwCGGzFcLux6+js9APkWtLra0CUh6WmMBkU=;
 b=Ve6iUGTvkPyuFDxpZj8uid1O0X0YdKNuXWCZ9gGRyWPqFlMceZSjkopl29Zt/q+RKM
 Ka+pcJqP+STRCvVy/XebDY3WB2yWYs77k8YUdTTCB26afCadIScy736Uba3ej2pe8DHR
 iCFMTPIOtFyDWZo+mPLk2qQALJEb/gALd3+7eQcQyZ/cYCw47yIkVnsomsWQTJm8OE+w
 WqXGyQIMZfULCRsOldV+6nbCcJAGi7rOJ6ZtRwB1+kCrEkHHR7e9MDusy3ov0IoRKX5f
 GfaMrP0zBWAktBhqNTOPgvXCFHKLwjTEhvTmRliV+9rkR2z1flMrr3B2G8GdSQxzwoSE
 HeGA==
X-Gm-Message-State: AOJu0YzK41q8rOdgznC/Y5hcaQ+aDOcYmC0y5Vh69PCdzV2vFj+zIA+D
 yKRFvaJ4YRYQ+K34Un+ycdTYYxJVBGxDll0PvroIZ6lFXYuNkDH383CJJWvL0w==
X-Gm-Gg: AZuq6aLCYvxe2w45S8Oqv+zU/5zdqo92gKbl1Vrgbcm94M1b/kiFiLqkNFGY27xVgCx
 0Pa3tcR2UUTLI3rRQFMYHn0s81/DrnMXhUK54zG7uEFG/ZaB3eN+1IlGxhQtWT4fLSzwZQDGcDf
 dy8YKW+H+r31IDPn3AnnbfpZjaebTVeGS8a9yD2YrqznQ3pcb6XWF0NQ4RfOtMpcGwQJKWMIQ3I
 HLl1yBgTuJHPY3zqLlbQHUyovsUA4AAv9zmqI+5KDWTsguH9ZhE3DD50kQAeYdL2jsUC5cNrv90
 tJFlBqLVKkNBqlhb+rinYdlEb+dyD8Tl65uvi4wKehOyht826jetTlLsui8Qv3icXX8dZzPKFvt
 3HZ5CiW6kWiOy652YwQCZ3PlTvhjba2SCuBtDka+jFtTf9A8YUKLHZQ/JwvG3nOKuwDFie4rWOO
 VuRPSGq9Z+y/Op0QqVaOLwLo2wpD+BjIDx
X-Received: by 2002:a05:7022:250d:b0:123:34e8:aec2 with SMTP id
 a92af1059eb24-1247dba9c3amr1798969c88.1.1769185664476; 
 Fri, 23 Jan 2026 08:27:44 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1247d91b9e1sm5497392c88.5.2026.01.23.08.27.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Jan 2026 08:27:44 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v10] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Fri, 23 Jan 2026 08:27:42 -0800
Message-Id: <20260123162742.69675-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260117210322.5419-1-scott.k.mitch1@gmail.com>
References: <20260117210322.5419-1-scott.k.mitch1@gmail.com>
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
v10:
- Use unit_test_suite_runner for easier subtest failure identification

v9:
- Fix include order: system includes, then DPDK includes, then application includes
- Use NOHUGE_OK and ASAN_OK constants in REGISTER_FAST_TEST (instead of true, true)

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
 app/test/test_ptr_add_sub.c  | 195 +++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_common.h |  15 ++-
 3 files changed, 210 insertions(+), 1 deletion(-)
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
index 0000000000..4169230daf
--- /dev/null
+++ b/app/test/test_ptr_add_sub.c
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Apple Inc.
+ */
+
+#include <stdint.h>
+
+#include <rte_common.h>
+
+#include "test.h"
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
+static struct unit_test_suite ptr_add_sub_test_suite = {
+	.suite_name = "ptr add/sub autotest",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_ptr_add_sub_integer_types),
+		TEST_CASE(test_ptr_add_sub_pointer_types),
+		TEST_CASES_END()
+	}
+};
+
+/* Main test function that runs all subtests */
+static int
+test_ptr_add_sub(void)
+{
+	return unit_test_suite_runner(&ptr_add_sub_test_suite);
+}
+
+REGISTER_FAST_TEST(ptr_add_sub_autotest, NOHUGE_OK, ASAN_OK, test_ptr_add_sub);
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

