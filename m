Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10B7D2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 15:00:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD3D14028F;
	Sun, 11 Jan 2026 16:00:54 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 70E8D4028F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:00:53 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-888bd3bd639so53867416d6.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 07:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768143652; x=1768748452; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VKW/QQ6IRPDv+X1h169SImNB/lO5beXiMzoOrU4GXg=;
 b=gGIM5dRu6KOOMMeb5YzfwqxkSGD2VUGDjoHkMqYqtqKzMuE44Eln0oGd1P4l3DLhmJ
 rohj9EW8JQ9Ogasc05eje8ts1st+Q6vpi/AGSqEwv00yxf4reEb1ru3AzzaIibWA2PFU
 /ggDACZHo7NA74Y7xmsQ3kqVq29/GXo/uRsEri2emVpzwilxjzsVuMSl5RZ4EMthq9nH
 T9Z7jDRPDXWAAe/rLvekUs4j3KDsA+gTI7Ghjq7+o2rRzKY97r7SdiGa0y63pdT77V+M
 8Eo4YtjYIjpyyNx0hSipBtqi1B34c2LrQmZBJHp/+EmManRAtUa3+3NyNM7aaxRUDvkM
 XI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768143652; x=1768748452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7VKW/QQ6IRPDv+X1h169SImNB/lO5beXiMzoOrU4GXg=;
 b=rUREpFCgcMt1+IbRBI1fyTMK5hgfGMUieovrKNxRturQTp2KGjiaeJPl8Dy0M5o4k9
 DaRjz0uk6blv66jdNn/vQMNwwEeCzEl53CMS8UQZSy7ELkjSHWAaH/iPrHIw9tUt+Y4L
 DwCoz1fmMf4RSwxw7mRPARIMyOfYuOpA26x4fI/4ZXQKW4qnQ9R5wWfsXAKprY1X+joJ
 Hzs+VNlV+kkC3RmSsbBVSEzjhM7Ndb2bBWBK8qUD97tNi2IManONiyTrn24DeAm+uri2
 ddwm3ZqEUHcnO0zMfKENEL0VjqMwLg7g/aQo2nyHfEHYWLIlgIezF+0r5sQb0s/vocMz
 s7uA==
X-Gm-Message-State: AOJu0Yy1eZOuYNvY427INMAx6dKwn3q3t5/swUa6+Cxy9cavqCc1EyZD
 9C6zeWI8aJMrLv/s2606twzNrw60d+KbF9MZ+G1QjBvuSgJ8XUlPgZIeVPhVHA==
X-Gm-Gg: AY/fxX5I9GKCCjhgo7aYSsxD6fROhSGAnM9EjzksYKsu0ryvQ2yIMeuMGAlCu7HJzRh
 /Ct5VrbbIIAbTtPdhCEgsBr1zBY05wQuCtdDuNZpsMH7aR4B2ZuPR1KnfqTQdw00kDwgnWaPhR5
 RmhjGr2uR/UbrHHx7uMMjtx83Nv7Okf3XU6ybQFSaYugyTbYmXx0Pl+24BRZh+uVFUgmbYbHYWp
 v6sG8kcygqyLq5aFpbCKmeKcCjAo4dUapKHoY8pLecfQ9OE+QJ6vYanr2HhcnYgaYIRcciGxFU8
 QAMO9HngVAVTHmW50APtYXTc6HbaG/AziqqYrPSmuGyo7xXgjperOUcEwAg3XljJiRk1aFXE5cD
 M2ILgLvq8Ki1Pe0vwPMeBRx6sPGxZYrz6UcBAvVpUmq6u40UK3CmkUo1NeHQu+EdxJbYaIRYlnf
 F9DZ6o0Tx0Jzf7p37kgI3w2uk3O/S9HSUcQcokTgTh5fJ4uKvyEfhKjGaOqhNg62cXewMqocDeh
 31r
X-Google-Smtp-Source: AGHT+IEugolesoDfYhEzN8hCuEI4qfMzIYzMys0A19/08JH4d7BBKRde9nnNXd7aClY5ykNPhpeqDA==
X-Received: by 2002:a05:6214:2688:b0:87c:282b:aa28 with SMTP id
 6a1803df08f44-8907697fbaamr264707306d6.1.1768143652353; 
 Sun, 11 Jan 2026 07:00:52 -0800 (PST)
Received: from st57p01nt-relayp01.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077234d08sm119361056d6.28.2026.01.11.07.00.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 07:00:52 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH 1/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Sun, 11 Jan 2026 10:00:32 -0500
Message-Id: <20260111150033.81760-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
References: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
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
instead of uintptr_t casts when operating on pointer types. This
enables better compiler optimization, particularly for
Clang which can now recognize simple pointer patterns and apply
vectorization, loop unrolling, and improved assembly.

The implementation uses C11 _Generic to dispatch based on input type:
- Integer types (int, uint64_t, etc.) continue using uintptr_t
  arithmetic for API compatibility
- Pointer types use char* arithmetic, with const-qualified pointers
  using const char* internally to preserve optimization hints

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
 lib/eal/include/rte_common.h |  76 ++++++++++++++
 3 files changed, 267 insertions(+)
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
index 0000000000..de66f4509e
--- /dev/null
+++ b/app/test/test_ptr_add_sub.c
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
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
index 9e7d84f929..6f3dd744c1 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -551,12 +551,88 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 /**
  * add a byte-value offset to a pointer
  */
+#ifndef RTE_TOOLCHAIN_MSVC
+#define RTE_PTR_ADD(ptr, x) \
+	(__extension__ ({ \
+		/* Diagnostics suppressed for internal macro operations only. \
+		 * Compiler type-checks all _Generic branches even when unselected, \
+		 * triggering warnings with no external impact. */ \
+		__rte_diagnostic_push \
+		__rte_diagnostic_ignored_wcast_qual \
+		_Pragma("GCC diagnostic ignored \"-Wconditional-type-mismatch\"") \
+		/* Uses uintptr_t arithmetic for integer types (API compatibility), \
+		 * and char* arithmetic for pointer types (enables optimization). */ \
+		__auto_type _ptr_result = _Generic((ptr), \
+			unsigned long long: ((void *)((uintptr_t)(ptr) + (x))), \
+			long long:          ((void *)((uintptr_t)(ptr) + (x))), \
+			unsigned long:      ((void *)((uintptr_t)(ptr) + (x))), \
+			long:               ((void *)((uintptr_t)(ptr) + (x))), \
+			unsigned int:       ((void *)((uintptr_t)(ptr) + (x))), \
+			int:                ((void *)((uintptr_t)(ptr) + (x))), \
+			unsigned short:     ((void *)((uintptr_t)(ptr) + (x))), \
+			short:              ((void *)((uintptr_t)(ptr) + (x))), \
+			unsigned char:      ((void *)((uintptr_t)(ptr) + (x))), \
+			signed char:        ((void *)((uintptr_t)(ptr) + (x))), \
+			char:               ((void *)((uintptr_t)(ptr) + (x))), \
+			_Bool:              ((void *)((uintptr_t)(ptr) + (x))), \
+			/* Ternary with null pointer constant: per C11, if one operand \
+			 * is a null pointer constant and the other is a pointer, the \
+			 * result type is qualified per the pointer operand, normalizing \
+			 * const T* to const void* and T* to void*. */ \
+			default: _Generic((1 ? (ptr) : (void *)0), \
+				const void *: ((void *)((const char *)(ptr) + (x))), \
+				default:      ((void *)((char *)(ptr) + (x))) \
+			) \
+		); \
+		__rte_diagnostic_pop \
+		_ptr_result; \
+	}))
+#else
 #define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
+#endif
 
 /**
  * subtract a byte-value offset from a pointer
  */
+#ifndef RTE_TOOLCHAIN_MSVC
+#define RTE_PTR_SUB(ptr, x) \
+	(__extension__ ({ \
+		/* Diagnostics suppressed for internal macro operations only. \
+		 * Compiler type-checks all _Generic branches even when unselected, \
+		 * triggering warnings with no external impact. */ \
+		__rte_diagnostic_push \
+		__rte_diagnostic_ignored_wcast_qual \
+		_Pragma("GCC diagnostic ignored \"-Wconditional-type-mismatch\"") \
+		/* Uses uintptr_t arithmetic for integer types (API compatibility), \
+		 * and char* arithmetic for pointer types (enables optimization). */ \
+		__auto_type _ptr_result = _Generic((ptr), \
+			unsigned long long: ((void *)((uintptr_t)(ptr) - (x))), \
+			long long:          ((void *)((uintptr_t)(ptr) - (x))), \
+			unsigned long:      ((void *)((uintptr_t)(ptr) - (x))), \
+			long:               ((void *)((uintptr_t)(ptr) - (x))), \
+			unsigned int:       ((void *)((uintptr_t)(ptr) - (x))), \
+			int:                ((void *)((uintptr_t)(ptr) - (x))), \
+			unsigned short:     ((void *)((uintptr_t)(ptr) - (x))), \
+			short:              ((void *)((uintptr_t)(ptr) - (x))), \
+			unsigned char:      ((void *)((uintptr_t)(ptr) - (x))), \
+			signed char:        ((void *)((uintptr_t)(ptr) - (x))), \
+			char:               ((void *)((uintptr_t)(ptr) - (x))), \
+			_Bool:              ((void *)((uintptr_t)(ptr) - (x))), \
+			/* Ternary with null pointer constant: per C11, if one operand \
+			 * is a null pointer constant and the other is a pointer, the \
+			 * result type is qualified per the pointer operand, normalizing \
+			 * const T* to const void* and T* to void*. */ \
+			default: _Generic((1 ? (ptr) : (void *)0), \
+				const void *: ((void *)((const char *)(ptr) - (x))), \
+				default:      ((void *)((char *)(ptr) - (x))) \
+			) \
+		); \
+		__rte_diagnostic_pop \
+		_ptr_result; \
+	}))
+#else
 #define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
+#endif
 
 /**
  * get the difference between two pointer values, i.e. how far apart
-- 
2.39.5 (Apple Git-154)

