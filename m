Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD46D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 21:58:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5DB24064A;
	Wed, 14 Jan 2026 22:58:09 +0100 (CET)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 0C1764027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 22:58:08 +0100 (CET)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12331482b8fso768291c88.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 13:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768427887; x=1769032687; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQ4IPCbs2WpVsBJw+ZL/Vw5dAq+dIZdICU6N3uvzliM=;
 b=Inx862K3QuS8/rJLJp9EJUcwoHCWgIAkcidaNsHD8e2ukfDbWeBINrgZt3RSHiVMNV
 0/D5/BExJ0UYRiCRrHYOoFkxBhj/CHIteTVrUDgsYKaGaM1CHSY7mn5x+n9sSlFtOdfM
 3wN+OyJLT5mwonQwKuZIkXr4EV+VY8oNkwTk7K/sgw+vKP6JF+CZaVKZ1YVbmLj8ZA2S
 oQ8p1LdhFhnwLuK1xg6bEGgkakUpk210aMKH7KzOvmfebS31UO6Js2e1FYJ8UzEua4Gl
 Mf7hpALgnqBKXwWb4/lXITWL+h4sdgIcTA1YPW1GF09vgx1GnNtuwU7RomimDuEgGiKq
 ydyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768427887; x=1769032687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EQ4IPCbs2WpVsBJw+ZL/Vw5dAq+dIZdICU6N3uvzliM=;
 b=KeM92HSzW11byBq58ndogJ7oI1HP050nZsHfPU3LacWUqbWlOIq03t3/asK5v65JU+
 MlITGZK/EV4l+wpiylKFx/H7/ENDw/zOZ2pk2suUGOzafY1/ENHNKWic9u5exkRxgp4+
 zhsFkqHzW8l1zwdYF0Le/cExA+AIhO3qme1DPpAVaCx7n6S9c9sLD4weii7LIEOsLdzT
 GS29vKbB3B+uZU6yJc37LBmhHigxn+8LNW1eL9GZmC7Ff2v40Cdx62oTl6vlXLM38DxJ
 mRblrRCufoDyrMr1gDc9wgZ4TiavudnO9My9pBgjU5yQjRfLqkXkGafCb+yB/x++4AT1
 8Luw==
X-Gm-Message-State: AOJu0YzCXUDjIEbcIXpzeedpmu3EnrslqJh63Qf9xBFus3vqEeXOyonU
 YEofzRCMVmMEOgmX1sqrONKz2/XzFSgELzhQg26hOhGj8yGKajg4/7eGe63gNQ==
X-Gm-Gg: AY/fxX4GGOCUbJZr2xFDIJzqYUL75RY8D32RztpS1cc6Te7+S0ym2Bvj79jaAThk4J4
 VXI7BIAoX6Zma1thJbCIhDjuQi5sx6opz4Jt+CzPTzk1K3VurayjoRnq4+6yptH2SoRE776R1Vh
 iia7s6I2kRy/7Gvqf/DVW9V0saaA2GB8GeintBXYBr5OLbCyT/+cEkVz4wWlLIEkmPwztYY+YTp
 cT4lkSxvD3P0CKm62NBUW0kn4fZN+uEhLb0bnF3m7rUVBlnpmDUpizhtYW9GOrR5VKhZAP5PBaM
 GgTYohHJsCfKK/gNxbqYoDYmgfSQk36Rcn3geZl4gvKQWyCTy7Dltd7phlkddtte7klhsoQ/mDc
 N7usgr3pakJzwl/aZ7BgzldllFRrImKxflammkPvjCu+g47sb3gV8I5rdECxMfnBVY4owpftsNo
 35Xv7mUQiSiTXBcLUhL6iqGYbd3jX6lBa/w7lQ1CvZwyR6ab9k/g==
X-Received: by 2002:a05:7022:1709:b0:123:2dd0:10bc with SMTP id
 a92af1059eb24-123376cc879mr2661250c88.10.1768427886439; 
 Wed, 14 Jan 2026 13:58:06 -0800 (PST)
Received: from mr41p01nt-relayp01.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121f248c246sm32208783c88.11.2026.01.14.13.58.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Jan 2026 13:58:06 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v7] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Wed, 14 Jan 2026 13:56:48 -0800
Message-Id: <20260114215648.47820-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260114160750.12945-1-scott.k.mitch1@gmail.com>
References: <20260114160750.12945-1-scott.k.mitch1@gmail.com>
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
 app/test/test_ptr_add_sub.c  | 197 +++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_common.h |  14 ++-
 3 files changed, 208 insertions(+), 4 deletions(-)
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
index 0000000000..2956eabeb3
--- /dev/null
+++ b/app/test/test_ptr_add_sub.c
@@ -0,0 +1,197 @@
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
+/* Buffer size for pointer tests */
+#define TEST_BUFFER_SIZE (TEST_INCREMENT_LARGE + TEST_INCREMENT_SMALL + 256)
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
+	char buffer[TEST_BUFFER_SIZE];
+	void *result;
+
+	/* Test void* and const void* */
+	void *vp = buffer;
+	result = RTE_PTR_ADD(vp, TEST_INCREMENT_LARGE);
+	result = RTE_PTR_SUB(result, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, vp, "RTE_PTR_ADD/SUB failed for void*");
+
+	const void *cvp = buffer;
+	result = RTE_PTR_ADD(cvp, TEST_INCREMENT_SMALL);
+	result = RTE_PTR_SUB(result, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (const void *)cvp,
+		"RTE_PTR_ADD/SUB failed for const void*");
+
+	/* Test char* and const char* */
+	char *cp = buffer;
+	result = RTE_PTR_ADD(cp, TEST_INCREMENT_LARGE);
+	result = RTE_PTR_SUB(result, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, (void *)cp, "RTE_PTR_ADD/SUB failed for char*");
+
+	const char *ccp = buffer;
+	result = RTE_PTR_ADD(ccp, TEST_INCREMENT_SMALL);
+	result = RTE_PTR_SUB(result, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (const void *)ccp,
+		"RTE_PTR_ADD/SUB failed for const char*");
+
+	/* Test uint32_t* and const uint32_t* */
+	uint32_t *u32p = (uint32_t *)buffer;
+	result = RTE_PTR_ADD(u32p, TEST_INCREMENT_LARGE);
+	result = RTE_PTR_SUB(result, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result, (void *)u32p,
+		"RTE_PTR_ADD/SUB failed for uint32_t*");
+
+	const uint32_t *cu32p = (const uint32_t *)buffer;
+	result = RTE_PTR_ADD(cu32p, TEST_INCREMENT_SMALL);
+	result = RTE_PTR_SUB(result, TEST_INCREMENT_SMALL);
+	TEST_ASSERT_EQUAL(result, (const void *)cu32p,
+		"RTE_PTR_ADD/SUB failed for const uint32_t*");
+
+	/* Verify assigning to const pointer works (adding const is safe) */
+	const void *result_const = RTE_PTR_ADD(cvp, TEST_INCREMENT_LARGE);
+	result_const = RTE_PTR_SUB(result_const, TEST_INCREMENT_LARGE);
+	TEST_ASSERT_EQUAL(result_const, cvp,
+		"RTE_PTR_ADD/SUB failed when assigning to const void*");
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

