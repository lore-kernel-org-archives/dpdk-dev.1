Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C0C9EC8D
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 15:41:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B88440156;
	Mon, 12 Jan 2026 16:41:03 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id A860240041
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:41:02 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8ba0d6c68a8so763551485a.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768232462; x=1768837262; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nmEYal2J2Xo6HAFWAVSlTt44pTWmB6ktZhtb7vR28CY=;
 b=hVyYSBz4deKkzZaasV8Pq+x6SAD6XPub4ysLOXDIWySyZjFgceDSzNYOOpjglmywtI
 NCbccowG9JM4ZjwnDdgOPGF8uChT3l0RP7R7SiaRyRH5234esF12lUYyWP4+l6E6ZJGG
 YJ/s8YN2EMm9myDjGfMyC42BaVioH0sxGMz1ChHZFkff52Hab2zNDtIxU4V/QrMKQZ6Y
 SJChd8yF0TmYnkicjjGgWlYtukdbi+jvrsyZvxg1g5Hkebqjb7k2+XZn8IbjLFy3I+gc
 xS3sB3qQlYjiT/TwWjqx2zSf+ixAH9CMGARx82v8M8IWJSZK4lEKmYCsyafxs6Ke+0YU
 1IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768232462; x=1768837262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmEYal2J2Xo6HAFWAVSlTt44pTWmB6ktZhtb7vR28CY=;
 b=hRzQD6pn6xtO4t4Q22/LXIXdutBtiPCfZAD3sxdFvyqESpZiN13D6oKZ4oxjlkOMIS
 lfKMikocSMgIYlIwJ7V8I2YhEpuOlPcf6au4NFfOW9GWe6rija8MuDtyJd5vgm45wxQQ
 /OHuBoh5xsvWYq1CMY92GzJGBQN7BzDiV/1ezmnODtD+a9XXiNBTmdSgRuwibHSUlHK5
 QR053nB2+m8mb5iq3nJVM1nwIjS+N8Ch6f8bXGlxZHypkBeg7jusr0KO3nrYxO8yyo+r
 U9ZG9mil7QOOm801pf6RmDjiqHOe76Tr3c/Xelv6w/adZd1X/vOfCTRzdfJPBEt/si7m
 7mkA==
X-Gm-Message-State: AOJu0YwShm3FX8jQ6Hs0NdOCV6yh3TfL8njUpDRjIHkRxYja022C+2ek
 YHStJQ1TWgkmmkSo7tmn7ucA2M0TqUgViZbErFcrZgH7mLXed7QTGkejTXxb/A==
X-Gm-Gg: AY/fxX6vJ6ARDbuRBAlTi+zEH6bfITl6X2aO65tE7yX+fxEgMaXDEPanFAIAdaL17kj
 knwh65a8x1qKBhP/d+7acpPjSX94JJNj+t/AzBhMyY1jbwGBTmz7hSAIk7xsUPPxvLhCQKPuZ8N
 DEF4mdLxKO9jgt+hlFitHFfJszPHLfTBMNhgpQp22FsPDTQV3GhXmB+DRendEKJ8xD4s69lN0Fk
 Eg3cKVaAvUuNdChQ2wjLJwDQ2q/zXZSLC/XE8Sdiyv8+69IUmVyEKbGH1K5limYNbrQ3L0i4TTt
 jO4Mty1/qQuLgk3fODQms5dRYLX5FeRDiu9fgAlmF9e8Oo7SeayZST1imQBT+HN0WUKhdo2Gpba
 5SC4xzx//0GeLYVwuObL+mcR9RQWGedKZmefvAM6QCop8qcSDEFJ3tTfElb4rL9rW28Bs+FBmfv
 hnRQfGNJSItIQU0tKELY3J52F3jg1EZJKdEChlLNJTNg==
X-Google-Smtp-Source: AGHT+IHZ9L+lcIVQzPxsYobUDXzzvZ0emEmMqDg5Xg40rF/WCOKmj8nHd++e6tzDsgqJTjO9wrZjag==
X-Received: by 2002:a05:620a:1a16:b0:8b2:63ed:dd10 with SMTP id
 af79cd13be357-8c3894327ccmr2602590785a.78.1768232461745; 
 Mon, 12 Jan 2026 07:41:01 -0800 (PST)
Received: from st47p01nt-relayp04.apple.com ([2620:149:13c1:500::12])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8d6b044sm124590341cf.14.2026.01.12.07.41.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 07:41:01 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v5] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Mon, 12 Jan 2026 10:40:59 -0500
Message-Id: <20260112154059.36879-1-scott.k.mitch1@gmail.com>
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
instead of uintptr_t casts. Benefits of this approach:
- API compatibility: works for both integer and pointer inputs
- Retains simple macros: no pragmas, no _Generic
- Enables compiler optimizations: Clang now can unroll and vectorize
pointer loops, and GCC still can apply these optimizations.

Example use case which benefits is __rte_raw_cksum. Performance
results from cksum_perf_autotest on Intel Xeon (Cascade Lake,
AVX-512) built with Clang 18.1 (TSC cycles/byte):
  Block size    Before    After    Improvement
         100      0.40     0.24        ~40%
        1500      0.50     0.06        ~8x
        9000      0.49     0.06        ~8x

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 app/test/meson.build         |   1 +
 app/test/test_ptr_add_sub.c  | 190 +++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_common.h |   4 +-
 3 files changed, 193 insertions(+), 2 deletions(-)
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
index 0000000000..ef449ca9af
--- /dev/null
+++ b/app/test/test_ptr_add_sub.c
@@ -0,0 +1,190 @@
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
+/* Test all C11 standard integer types */
+static int
+test_ptr_add_sub_integer_types(void)
+{
+	unsigned long long ull = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(ull, 100), 0x1064,
+		"RTE_PTR_ADD failed for unsigned long long");
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_SUB(ull, 100), 0x1000 - 100,
+		"RTE_PTR_SUB failed for unsigned long long");
+
+	long long ll = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(ll, 100), 0x1064,
+		"RTE_PTR_ADD failed for long long");
+
+	unsigned long ul = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(ul, 100), 0x1064,
+		"RTE_PTR_ADD failed for unsigned long");
+
+	long l = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(l, 100), 0x1064,
+		"RTE_PTR_ADD failed for long");
+
+	unsigned int ui = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(ui, 100), 0x1064,
+		"RTE_PTR_ADD failed for unsigned int");
+
+	int i = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(i, 100), 0x1064,
+		"RTE_PTR_ADD failed for int");
+
+	unsigned short us = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(us, 100), 0x1064,
+		"RTE_PTR_ADD failed for unsigned short");
+
+	short s = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(s, 100), 0x1064,
+		"RTE_PTR_ADD failed for short");
+
+	unsigned char uc = 100;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(uc, 50), 150,
+		"RTE_PTR_ADD failed for unsigned char");
+
+	signed char sc = 100;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(sc, 50), 150,
+		"RTE_PTR_ADD failed for signed char");
+
+	char c = 100;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(c, 50), 150,
+		"RTE_PTR_ADD failed for char");
+
+	_Bool b = 1;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(b, 99), 100,
+		"RTE_PTR_ADD failed for _Bool");
+
+	bool b2 = true;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(b2, 99), 100,
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
+	result = RTE_PTR_ADD(vp, 100);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
+		"RTE_PTR_ADD failed for void*");
+	result = RTE_PTR_SUB(vp, 50);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
+		"RTE_PTR_SUB failed for void*");
+
+	const void *cvp = buffer;
+	result = RTE_PTR_ADD(cvp, 100);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
+		"RTE_PTR_ADD failed for const void*");
+	result = RTE_PTR_SUB(cvp, 50);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
+		"RTE_PTR_SUB failed for const void*");
+
+	/* Test char* and const char* */
+	char *cp = buffer;
+	result = RTE_PTR_ADD(cp, 100);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
+		"RTE_PTR_ADD failed for char*");
+	result = RTE_PTR_SUB(cp, 50);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
+		"RTE_PTR_SUB failed for char*");
+
+	const char *ccp = buffer;
+	result = RTE_PTR_ADD(ccp, 100);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
+		"RTE_PTR_ADD failed for const char*");
+	result = RTE_PTR_SUB(ccp, 50);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
+		"RTE_PTR_SUB failed for const char*");
+
+	/* Test uint32_t* and const uint32_t* */
+	uint32_t *u32p = (uint32_t *)buffer;
+	result = RTE_PTR_ADD(u32p, 100);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
+		"RTE_PTR_ADD failed for uint32_t*");
+	result = RTE_PTR_SUB(u32p, 50);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
+		"RTE_PTR_SUB failed for uint32_t*");
+
+	const uint32_t *cu32p = (const uint32_t *)buffer;
+	result = RTE_PTR_ADD(cu32p, 100);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
+		"RTE_PTR_ADD failed for const uint32_t*");
+	result = RTE_PTR_SUB(cu32p, 50);
+	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
+		"RTE_PTR_SUB failed for const uint32_t*");
+
+	/* Verify assigning to const pointer works (adding const is safe) */
+	const void *result_const = RTE_PTR_ADD(cvp, 100);
+	TEST_ASSERT_EQUAL(result_const, (const void *)(buffer + 100),
+		"RTE_PTR_ADD failed when assigning to const void*");
+
+	return 0;
+}
+
+/* Test that typedefs resolve to native types correctly */
+static int
+test_ptr_add_sub_typedefs(void)
+{
+	uint64_t u64 = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(u64, 100), 0x1064,
+		"RTE_PTR_ADD failed for uint64_t");
+
+	uint32_t u32 = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(u32, 100), 0x1064,
+		"RTE_PTR_ADD failed for uint32_t");
+
+	uint16_t u16 = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(u16, 100), 0x1064,
+		"RTE_PTR_ADD failed for uint16_t");
+
+	uint8_t u8 = 100;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(u8, 50), 150,
+		"RTE_PTR_ADD failed for uint8_t");
+
+	uintptr_t uptr = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(uptr, 100), 0x1064,
+		"RTE_PTR_ADD failed for uintptr_t");
+
+	size_t sz = 0x1000;
+	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(sz, 100), 0x1064,
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
index 9e7d84f929..54289871d2 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -551,12 +551,12 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 /**
  * add a byte-value offset to a pointer
  */
-#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
+#define RTE_PTR_ADD(ptr, x) ((void *)((char *)(uintptr_t)(ptr) + (x)))
 
 /**
  * subtract a byte-value offset from a pointer
  */
-#define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
+#define RTE_PTR_SUB(ptr, x) ((void *)((char *)(uintptr_t)(ptr) - (x)))
 
 /**
  * get the difference between two pointer values, i.e. how far apart
-- 
2.39.5 (Apple Git-154)

