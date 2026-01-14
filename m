Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AFCD30CFE
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 16:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A6BD40648;
	Wed, 14 Jan 2026 17:08:03 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id B3AC3400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 17:08:01 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1232d9f25e9so1120881c88.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 08:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768406880; x=1769011680; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P/hBgCoYK6RRwR/pWBmdwaAoj0mw7SpQOgZY6UQ6Ud4=;
 b=LBx/yIrh6+q+Wk0BW0v5UMQeiPS33ZC+3uXXeYtUpoLXxH1Vha29+XIICJDK867fit
 v3O4inu9KGK4voMsKrESsSl7qylGaTVRXKgFAktEM2rwljDoGScEVSW8PFU/WcPaTonU
 WhS9/qpZ69m0zLURByCG/x2CO6uubCFa94RvH1/5cwatDwiTSYKJEZ0mJ994gAh2bM9T
 YWTl3XAuw+WjP7vs1HHOEVUuy5shDoZ64IDjYuTVTS+wZgoLhOpXanlNaAsjcZpXQ0tC
 sB/Z9YFr1gM75i8AO2E5nD2oNT2gcTBQGItyup/05bW8iH0tu+NQNHLSdSHnwHiQkSM6
 K+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768406880; x=1769011680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/hBgCoYK6RRwR/pWBmdwaAoj0mw7SpQOgZY6UQ6Ud4=;
 b=Xs51Q8UqOet3u+0RcpNY7XoRZj1WMVAYmnQLqhjU3oDZmuYFi5ApPDV1NwLyj0f94N
 1AVhYraM+XM5zfT/UD0J/asSLunT13LWXmykXuItKo1x5unHeT04lyq1esYYxeoqW+eM
 MnOJCWVgQ5CVXqSo5TP28WGsR5pPwercq/Ft0X6AY2ibll+NWr1KUAXYq+RG70YTSReo
 wYzI4tMmTB4FHyTDHaG4F05AuhD8pyG7LMqm+pB489AlaqUJGOs+GPde0Wc6i8W8Ulxy
 EMC2voTY4+JoLGPqzycy44NMMsQQSY3ZCHA0D9nOVfQJA0+XCCrUH/q+r0VVyP0qLR3b
 RP0w==
X-Gm-Message-State: AOJu0YxDXQ2XMMhG6AB8plSWK+0K/7+qhObb08yvRSEKM3tOfj3j5050
 hBshfFGNXby/s31+Z+XYIAieDpbOct4uNHQ1teo7vek/dnypn6H6ynYD+Dy92g==
X-Gm-Gg: AY/fxX7IzMGcd3UGTLeqs/3P+b9DAybKQ1TW7h9UOb9upLRSFI+4xlkZWDdYGbMvAuh
 CaHdI11CTBxarOVo9rPoTnMa7tz0OdEBuTDL45aa+xrE8JvS+3zop3VO0bbxwy6YpNKY4gWH02M
 OBF5VGDHXsb8qUhgIsZakt6vxMBKfHb5Qmq8X/uQ17KYog3wBC4Jo8HKQDfXz10nu4YI4JuUaJ7
 kuL5mcILL5bl9JR8w23G4nI12YsZfL4O6KvohcpoVethtlNDwkdlnZVWQ4uKmKrH7NJcVG0oc78
 sJEEyf0CS7iGbBrrMyqlrAaWAwHH+VlGukHoKCjph8h/Iltn/sAltAmSpP6fAq7VfoeQj787mJv
 2PFK4Rc0luvs46p+uyz00NrUeMXW/aKx8APR3AkTKG/amMPrBmLCLHx3i3Zz/uMN+Dn4K75sZSv
 y2OO93ef4yArKysx6VKopmFx+I3Vjqhvwbs01MEDgJOIqBfmG5Vw9BsSXSQYlM
X-Received: by 2002:a05:7022:171c:b0:119:e56b:958c with SMTP id
 a92af1059eb24-12337701f83mr2354925c88.17.1768406878794; 
 Wed, 14 Jan 2026 08:07:58 -0800 (PST)
Received: from mr55p01nt-relayp02.apple.com
 ([2600:1010:b222:581b:5df7:e0c5:9edc:fc51])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f243421esm31439488c88.2.2026.01.14.08.07.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Jan 2026 08:07:58 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v6] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Wed, 14 Jan 2026 08:07:50 -0800
Message-Id: <20260114160750.12945-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
 app/test/test_ptr_add_sub.c  | 207 +++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_common.h |  14 ++-
 3 files changed, 218 insertions(+), 4 deletions(-)
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
index 0000000000..5c10acc7fb
--- /dev/null
+++ b/app/test/test_ptr_add_sub.c
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Apple Inc.
+ */
+
+#include "test.h"
+#include <stdint.h>
+#include <stdbool.h>
+
+#include <rte_common.h>
+
+/* Test constants for large integer types (16-bit and wider) */
+#define TEST_INITVAL_LARGE 0x1000
+#define TEST_INCREMENT_LARGE 100
+#define TEST_RETVAL_LARGE ((void *)0x1064)
+#define TEST_SUBVAL_LARGE ((void *)(TEST_INITVAL_LARGE - TEST_INCREMENT_LARGE))
+
+/* Test constants for 8-bit types */
+#define TEST_INITVAL_SMALL 100
+#define TEST_INCREMENT_SMALL 50
+#define TEST_RETVAL_SMALL ((void *)150)
+#define TEST_SUBVAL_SMALL ((void *)50)
+
+/* Test constants for bool (1-bit) */
+#define TEST_INITVAL_BOOL 1
+#define TEST_INCREMENT_BOOL 99
+#define TEST_RETVAL_BOOL ((void *)100)
+
+/* Test all C11 standard integer types */
+static int
+test_ptr_add_sub_integer_types(void)
+{
+	unsigned long long ull = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(ull, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for unsigned long long");
+	TEST_ASSERT_EQUAL(RTE_PTR_SUB(ull, TEST_INCREMENT_LARGE), TEST_SUBVAL_LARGE,
+		"RTE_PTR_SUB failed for unsigned long long");
+
+	long long ll = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(ll, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for long long");
+
+	unsigned long ul = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(ul, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for unsigned long");
+
+	long l = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(l, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for long");
+
+	unsigned int ui = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(ui, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for unsigned int");
+
+	int i = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(i, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for int");
+
+	unsigned short us = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(us, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for unsigned short");
+
+	short s = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(s, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for short");
+
+	unsigned char uc = TEST_INITVAL_SMALL;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(uc, TEST_INCREMENT_SMALL), TEST_RETVAL_SMALL,
+		"RTE_PTR_ADD failed for unsigned char");
+
+	signed char sc = TEST_INITVAL_SMALL;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(sc, TEST_INCREMENT_SMALL), TEST_RETVAL_SMALL,
+		"RTE_PTR_ADD failed for signed char");
+
+	char c = TEST_INITVAL_SMALL;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(c, TEST_INCREMENT_SMALL), TEST_RETVAL_SMALL,
+		"RTE_PTR_ADD failed for char");
+
+	_Bool b = TEST_INITVAL_BOOL;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(b, TEST_INCREMENT_BOOL), TEST_RETVAL_BOOL,
+		"RTE_PTR_ADD failed for _Bool");
+
+	bool b2 = TEST_INITVAL_BOOL;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(b2, TEST_INCREMENT_BOOL), TEST_RETVAL_BOOL,
+		"RTE_PTR_ADD failed for bool");
+
+	return 0;
+}
+
+/* Test pointer types including const correctness */
+static int
+test_ptr_add_sub_pointer_types(void)
+{
+	char buffer[256];
+	void *result;
+
+	/* Test void* and const void* */
+	void *vp = buffer;
+	result = RTE_PTR_ADD(vp, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT_LARGE),
+		"RTE_PTR_ADD failed for void*");
+	result = RTE_PTR_SUB(vp, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - TEST_INCREMENT_SMALL),
+		"RTE_PTR_SUB failed for void*");
+
+	const void *cvp = buffer;
+	result = RTE_PTR_ADD(cvp, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT_LARGE),
+		"RTE_PTR_ADD failed for const void*");
+	result = RTE_PTR_SUB(cvp, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - TEST_INCREMENT_SMALL),
+		"RTE_PTR_SUB failed for const void*");
+
+	/* Test char* and const char* */
+	char *cp = buffer;
+	result = RTE_PTR_ADD(cp, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT_LARGE),
+		"RTE_PTR_ADD failed for char*");
+	result = RTE_PTR_SUB(cp, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - TEST_INCREMENT_SMALL),
+		"RTE_PTR_SUB failed for char*");
+
+	const char *ccp = buffer;
+	result = RTE_PTR_ADD(ccp, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT_LARGE),
+		"RTE_PTR_ADD failed for const char*");
+	result = RTE_PTR_SUB(ccp, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - TEST_INCREMENT_SMALL),
+		"RTE_PTR_SUB failed for const char*");
+
+	/* Test uint32_t* and const uint32_t* */
+	uint32_t *u32p = (uint32_t *)buffer;
+	result = RTE_PTR_ADD(u32p, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT_LARGE),
+		"RTE_PTR_ADD failed for uint32_t*");
+	result = RTE_PTR_SUB(u32p, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - TEST_INCREMENT_SMALL),
+		"RTE_PTR_SUB failed for uint32_t*");
+
+	const uint32_t *cu32p = (const uint32_t *)buffer;
+	result = RTE_PTR_ADD(cu32p, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + TEST_INCREMENT_LARGE),
+		"RTE_PTR_ADD failed for const uint32_t*");
+	result = RTE_PTR_SUB(cu32p, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - TEST_INCREMENT_SMALL),
+		"RTE_PTR_SUB failed for const uint32_t*");
+
+	/* Verify assigning to const pointer works (adding const is safe) */
+	const void *result_const = RTE_PTR_ADD(cvp, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result_const, (const void *)(buffer + TEST_INCREMENT_LARGE),
+		"RTE_PTR_ADD failed when assigning to const void*");
+
+	return 0;
+}
+
+/* Test that typedefs resolve to native types correctly */
+static int
+test_ptr_add_sub_typedefs(void)
+{
+	uint64_t u64 = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(u64, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for uint64_t");
+
+	uint32_t u32 = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(u32, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for uint32_t");
+
+	uint16_t u16 = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(u16, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for uint16_t");
+
+	uint8_t u8 = TEST_INITVAL_SMALL;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(u8, TEST_INCREMENT_SMALL), TEST_RETVAL_SMALL,
+		"RTE_PTR_ADD failed for uint8_t");
+
+	uintptr_t uptr = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(uptr, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for uintptr_t");
+
+	size_t sz = TEST_INITVAL_LARGE;
+	TEST_ASSERT_EQUAL(RTE_PTR_ADD(sz, TEST_INCREMENT_LARGE), TEST_RETVAL_LARGE,
+		"RTE_PTR_ADD failed for size_t");
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
+	ret = test_ptr_add_sub_typedefs();
+	if (ret != 0)
+		return ret;
+
+	return 0;
+}
+
+REGISTER_FAST_TEST(ptr_add_sub_autotest, true, true, test_ptr_add_sub);
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 9e7d84f929..b525110b06 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -549,14 +549,20 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 /*********** Macros for pointer arithmetic ********/
 
 /**
- * add a byte-value offset to a pointer
+ * add and subtract a byte-value offset from a pointer
  */
-#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
-
+#ifdef RTE_CC_CLANG
 /**
- * subtract a byte-value offset from a pointer
+ * Clang doesn't optimize through uintptr_t, (char*) enables
+ * optimizations and doesn't generate warnings. GCC does optimize
+ * through uintptr_t but throws warnings (e.g. array-bounds) when cast to char*.
  */
+#define RTE_PTR_ADD(ptr, x) ((void *)((char *)(uintptr_t)(ptr) + (x)))
+#define RTE_PTR_SUB(ptr, x) ((void *)((char *)(uintptr_t)(ptr) - (x)))
+#else
+#define RTE_PTR_ADD(ptr, x) ((void *)((uintptr_t)(ptr) + (x)))
 #define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
+#endif
 
 /**
  * get the difference between two pointer values, i.e. how far apart
-- 
2.39.5 (Apple Git-154)

