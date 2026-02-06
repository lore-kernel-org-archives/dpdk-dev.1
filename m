Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A13ECD9AA
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6AF5402DB;
	Fri,  6 Feb 2026 02:02:11 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id B298740156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 02:02:09 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so1593202eec.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 17:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770339728; x=1770944528; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnrbGzgA3IuiVGrSVTHMUMa7HkjioR00T/zR+PNyyag=;
 b=Ia/SUUT8sV1FTJt0l4thq2LX3kKyO0YO6sGJ/olPlw350C+SArnk5we0sRvR3bRYPt
 6++V7YfyRqdLxaOReJwRSy9jcJyz/31o/VVU3ugJDhw37W6aBpf5bkAIL3m/C4SjJyJ2
 tOGm5vp27+esda89lKOMA5uomFhBWnx3y8QqQTWOswm+8UHaxaYG3yC+OlzpwxDc4/s8
 7Xly0n1WEW0psU+ijzD7kJnM77qeX9aCwBMbeSHM0RRagzBRZDgl/ZHh7O/6MlYA61C9
 wcImTTDixKAzUBjpY63XP1C/EEJ8mlhsaCi/Nqeh+81gtG+KqurKr3O1SUWbnCRHLZPk
 jQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770339728; x=1770944528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TnrbGzgA3IuiVGrSVTHMUMa7HkjioR00T/zR+PNyyag=;
 b=SzRxqy7A5D0PNUKxHbBDI4yYHiJcRbdrAItZcqXuYzgCSApQqlKHgLb3BpwZrtbmaT
 pTeN/j2REGYpjqvRDJIzjHfDEiOXms0/L2zqbhGceHyib7NrMeQzFQLa22QjgueALgi1
 ZpElL1QzDvozM9R2z8t6Xzijsc8e9FIR5SkwnK83D3r2LEj+Ono33F5CMG8Vhk9kewVw
 qsvECniNLbi8LAX5HwK+6ofZjaxQNP+zPC3gnIFCP1OrP1DXlxkFNBscssV+JIESJ7hX
 hvkgTWxp0KRNwkOgkjYZhEkV9Haffjn9/FG9XlgYzL4p+bjCK3xb1/6i8LsVv0IlYSW6
 81og==
X-Gm-Message-State: AOJu0YzGr9M5nHq7cggK1B+u/4DFOf2CvT3KxDt8ecfnrOVEZWONOwGc
 KCAhv2vVjNdVXNnX2LA32L9BpcKzyE9c8oIkPACiYvLTPy/zgQv2vrWxiNYrEA==
X-Gm-Gg: AZuq6aJWVy7WEhfKdGFAuLZG8R0nzFfUMlEHhj2Bio5obYVZbyNhOR65azZwOsTtV+i
 BdVxlopkkWonfUiNxZ4z72LBlqO6jHJqx/4qowzrZ3GdpEyRYh7U8r1UZT/ynvNCswZKVdF5Psp
 EMhIDANmFtMTNyhm4qhd50x+cnoxOop+xbC+W+yB9vQy95ERCdDu5XrNYwrPtc1YLTO7p6FsZqA
 jiAmL1q2hTUA9QuqymsFSjmsVl/kJzz9nl5M7uKMW01zEEo0nIOxNCEgRrxLwSBe4R+TnV0W/UL
 0IyVMDanxkyScJB8FGsqTtzq8mZFCVVkeCICw1qyoc7aLLnvxJiucrwE1cSE7McOrL6LDmVhnjo
 JHZHYWYz7k6h6NoheG+IVuT7cdz9h3sVvUWgwftscOGB/JG4xrPNBUaw2MAVU6lXVU1lmgNYmGv
 XFLIn5ncSZAJ2HCGQqMcXfnDg6WoCM3h3VYfjRXVeFBEnpnYu/nQmQ
X-Received: by 2002:a05:7301:1699:b0:2b7:961e:1b78 with SMTP id
 5a478bee46e88-2b856400accmr426535eec.12.1770339727555; 
 Thu, 05 Feb 2026 17:02:07 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([216.157.103.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127041d9c91sm859766c88.2.2026.02.05.17.02.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 17:02:06 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v22] eal: RTE_PTR_ADD/SUB API improvements
Date: Thu,  5 Feb 2026 17:01:57 -0800
Message-Id: <20260206010157.98321-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260205070345.23483-1-scott.k.mitch1@gmail.com>
References: <20260205070345.23483-1-scott.k.mitch1@gmail.com>
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

RTE_PTR_ADD and RTE_PTR_SUB APIs have a few limitations:
1. ptr cast to uintptr_t drops pointer provenance and
prevents compiler optimizations
2. return cast discards qualifiers (const, volatile)
which may hide correctness/concurrency issues.
3. Accepts both "pointers" and "integers as pointers" which
overloads the use case and constrains the implementation
to address other challenges.

This patch removes support for integer types which allows
addressing each of the challenges above. Examples:
1. Clang is able to optimize and improve __rte_raw_cksum
(which uses RTE_PTR_ADD) by ~40% (100 bytes) to ~8x (1.5k bytes)
TSC cycles/byte.
2. Refactoring discovered cases that dropped qualifiers (volatile)
that the new API exposes.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
Depends-on: patch-160679 ("eal: add __rte_may_alias and __rte_aligned to unaligned typedefs")

v22:
- msvc fix RTE_PTR_ALIGN_FLOOR compile issue

v21:
- Fix PTR_ALIGN to preserve return type correctly, avoid void* cast
because alignment is known
- Remove unecessary PTR_DIFF usage with PTR_ALIGN due to prior fix
- Remove RTE_INT_PTR and PLT_PTR_UNQUAL
- Consistent != NULL usage, add __rte_assume
- Add edge case tests to test_common.c

v20:
- Fix test_common.c test_ptr_add_sub_align failure due to alignas

v19:
- Remove first patch from series (already merged)
- Fix test_common.c test_ptr_add_sub_align failure, enhance test
 
v18:
- Removed RTE_INT_PTR* macros
- Explicit NULL compare in asserts
- Consolidated test_ptr_add_sub.c into test_common.c

v17:
- Improved release notes to explicitly list macro names for search/indexing
- eal_common_fbarray.c RTE_ASSERT to runtime NULL check

v16:
- Fixed test_common.c: parenthesize PTR_DIFF in RTE_INT_PTR tests

v15:
- Fixed __rte_alloc_size, spilt into 2 patch series
- Replaced RTE_INT_PTR_ADD/SUB with simpler RTE_INT_PTR(val) macro
users do int arithmetic directly: RTE_INT_PTR(addr + offset)

v14:
- fixed cpp compiler error, avoiding array pointer decay
which is implicitly done in cpp (but not c)
- fixed MALLOC_ELEM_TRAILER const preservation compile error

v13:
- Added release notes documenting API changes
- Fixed alignment in test file: use alignas(uint32_t) for buffer
- Fixed NULL pointer handling in cdx_vfio.c: check base_va before RTE_PTR_ADD
- Added GCC array-bounds diagnostic suppression in malloc_elem_from_data()
- Added bug tracker reference for volatile cast issue in idxd_pci.c
- Improved __rte_auto_type documentation: added C++11 and C23 support
- Moved doxygen rationale for void* return type to @return blocks
- Fixed MALLOC_ELEM_TRAILER to use RTE_PTR_UNQUAL for write operations

v12:
- void* return type to avoid optimizations assuming
aligned access which isn't generally safe/true.

v11:
- Split API into PTR and INT_PTR variants, update all usage
of PTR API for new APIs.

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

 app/test-pmd/cmdline_flow.c                 |   4 +-
 app/test/test_common.c                      | 502 +++++++++++++++++++-
 doc/guides/rel_notes/release_26_03.rst      |  13 +
 drivers/bus/cdx/cdx_vfio.c                  |  13 +-
 drivers/bus/pci/linux/pci.c                 |   6 +-
 drivers/bus/vmbus/linux/vmbus_uio.c         |   6 +-
 drivers/common/cnxk/roc_cpt_debug.c         |  12 +-
 drivers/common/cnxk/roc_ml.c                |   4 +-
 drivers/common/cnxk/roc_nix_bpf.c           |   2 +-
 drivers/common/cnxk/roc_nix_inl.h           |   4 +-
 drivers/common/cnxk/roc_nix_inl_dp.h        |   8 +-
 drivers/common/mlx5/mlx5_common_mr.c        |   2 +-
 drivers/dma/idxd/idxd_pci.c                 |  11 +-
 drivers/dma/odm/odm_dmadev.c                |   4 +-
 drivers/event/cnxk/cn10k_worker.c           |  32 +-
 drivers/event/cnxk/cn20k_worker.c           |  32 +-
 drivers/mempool/bucket/rte_mempool_bucket.c |   7 +-
 drivers/net/cxgbe/sge.c                     |   4 +-
 drivers/net/ena/ena_ethdev.c                |   9 +-
 drivers/net/mlx4/mlx4_txq.c                 |   3 +-
 lib/eal/common/eal_common_fbarray.c         |   3 +-
 lib/eal/common/eal_common_memory.c          |  32 +-
 lib/eal/common/eal_common_options.c         |   3 +-
 lib/eal/common/malloc_elem.h                |  34 +-
 lib/eal/freebsd/eal_memory.c                |   4 +
 lib/eal/include/rte_common.h                | 175 ++++++-
 lib/eal/linux/eal_memalloc.c                |   6 +
 lib/eal/linux/eal_memory.c                  |   7 +
 lib/eal/windows/eal_memalloc.c              |   6 +
 lib/graph/rte_graph.h                       |   4 +-
 lib/latencystats/rte_latencystats.c         |   3 +
 lib/mbuf/rte_mbuf.c                         |   2 +
 lib/mbuf/rte_mbuf.h                         |   4 +
 lib/member/rte_xxh64_avx512.h               |   6 +-
 lib/mempool/rte_mempool.h                   |   6 +
 lib/pdcp/pdcp_entity.h                      |   8 +-
 lib/vhost/vhost_user.c                      |  13 +-
 37 files changed, 855 insertions(+), 139 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index ebc036b14b..8c2fc6c7b6 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -12468,7 +12468,7 @@ parse_meter_color(struct context *ctx, const struct token *token,
 
 		if (!arg)
 			return -1;
-		*(int *)RTE_PTR_ADD(action->conf, arg->offset) = i;
+		*(int *)RTE_PTR_ADD(RTE_PTR_UNQUAL(action->conf), arg->offset) = i;
 	} else {
 		((struct rte_flow_item_meter_color *)
 			ctx->object)->color = (enum rte_color)i;
@@ -13351,7 +13351,7 @@ indirect_action_flow_conf_create(const struct buffer *in)
 		indlst_conf = NULL;
 		goto end;
 	}
-	indlst_conf->conf = RTE_PTR_ADD(indlst_conf, base + len);
+	indlst_conf->conf = (const void **)RTE_PTR_ADD(indlst_conf, base + len);
 	for (i = 0; i < indlst_conf->conf_num; i++)
 		indlst_conf->conf[i] = indlst_conf->actions[i].conf;
 	SLIST_INSERT_HEAD(&indlst_conf_head, indlst_conf, next);
diff --git a/app/test/test_common.c b/app/test/test_common.c
index 3e1c7df0c1..d66b6cb01f 100644
--- a/app/test/test_common.c
+++ b/app/test/test_common.c
@@ -20,9 +20,466 @@
 	{printf(x "() test failed!\n");\
 	return -1;}
 
+static int
+test_ptr_add_sub_align(void)
+{
+/* Independent test parameters */
+#define RTE_TEST_COMMON_MAX_ALIGNMENT RTE_CACHE_LINE_SIZE
+#define RTE_TEST_COMMON_MAX_OFFSET 256
+#define RTE_TEST_COMMON_MAX_INCREMENT 128
+/* Dependent: computed based on test requirements */
+/* Extra RTE_TEST_COMMON_MAX_ALIGNMENT to ensure CEIL can round up without going out of bounds */
+#define TEST_BUFFER_SIZE (RTE_TEST_COMMON_MAX_OFFSET + RTE_TEST_COMMON_MAX_INCREMENT + \
+		(2 * RTE_TEST_COMMON_MAX_ALIGNMENT) + 16)
+
+	/* Unaligned buffer for testing unaligned pointer types */
+	char unaligned_buffer[TEST_BUFFER_SIZE];
+	/* Aligned buffer for testing aligned pointer types - must be aligned to RTE_TEST_COMMON_MAX_ALIGNMENT */
+	alignas(RTE_TEST_COMMON_MAX_ALIGNMENT) char aligned_buffer[TEST_BUFFER_SIZE];
+	size_t offset;
+	uint8_t uval, aval;
+	uint16_t u16_uval, u16_aval;
+	uint32_t u32_uval, u32_aval;
+	uint64_t u64_uval, u64_aval;
+
+	uval = (uint8_t)rte_rand();
+	aval = (uint8_t)rte_rand();
+	if (uval == aval)
+		aval = (uint8_t)~aval;
+
+	/* Compute expected values for each type width by replicating byte pattern */
+	memset(&u16_uval, uval, sizeof(u16_uval));
+	memset(&u16_aval, aval, sizeof(u16_aval));
+	memset(&u32_uval, uval, sizeof(u32_uval));
+	memset(&u32_aval, aval, sizeof(u32_aval));
+	memset(&u64_uval, uval, sizeof(u64_uval));
+	memset(&u64_aval, aval, sizeof(u64_aval));
+
+	/* Initialize buffers - prevents compiler optimization and tests unaligned access */
+	memset(unaligned_buffer, uval, sizeof(unaligned_buffer));
+	memset(aligned_buffer, aval, sizeof(aligned_buffer));
+
+	/* Test various offsets to ensure correctness across memory range */
+	for (offset = 0; offset < RTE_TEST_COMMON_MAX_OFFSET; offset++) {
+		void *ubase = unaligned_buffer + offset;
+		void *abase = aligned_buffer + offset;
+		size_t increment;
+
+		/* Test different increment values */
+		for (increment = 0; increment < RTE_TEST_COMMON_MAX_INCREMENT; increment++) {
+			void *result;
+			char *cp_result;
+			const void *cvp_result;
+			unaligned_uint16_t *u16p_result;
+			unaligned_uint32_t *u32p_result;
+			unaligned_uint64_t *u64p_result;
+			uintptr_t uptr_val, aptr_val;
+			uintptr_t uexp_floor, uexp_ceil, aexp_floor, aexp_ceil;
+			size_t align;
+
+			/* Test void* ADD and SUB using unaligned buffer */
+			result = RTE_PTR_ADD(ubase, increment);
+			RTE_TEST_ASSERT_EQUAL(result, (void *)((char *)ubase + increment),
+				"RTE_PTR_ADD for void* at offset=%zu inc=%zu",
+				offset, increment);
+			result = RTE_PTR_SUB(result, increment);
+			RTE_TEST_ASSERT_EQUAL(result, ubase,
+				"RTE_PTR_SUB for void* at offset=%zu inc=%zu",
+				offset, increment);
+
+			/* Test char* type preservation using unaligned buffer */
+			cp_result = RTE_PTR_ADD((char *)ubase, increment);
+			RTE_TEST_ASSERT_EQUAL(cp_result, (char *)ubase + increment,
+				"RTE_PTR_ADD for char* at offset=%zu inc=%zu",
+				offset, increment);
+			RTE_TEST_ASSERT_EQUAL((unsigned char)*cp_result, (unsigned char)uval,
+				"char* dereference at offset=%zu inc=%zu",
+				offset, increment);
+			cp_result = RTE_PTR_SUB(cp_result, increment);
+			RTE_TEST_ASSERT_EQUAL(cp_result, (char *)ubase,
+				"RTE_PTR_SUB for char* at offset=%zu inc=%zu",
+				offset, increment);
+
+			/* Test const void* preservation using unaligned buffer */
+			cvp_result = RTE_PTR_ADD((const void *)ubase, increment);
+			RTE_TEST_ASSERT_EQUAL(cvp_result,
+				(const void *)((char *)ubase + increment),
+				"RTE_PTR_ADD for const void* at offset=%zu inc=%zu",
+				offset, increment);
+			cvp_result = RTE_PTR_SUB(cvp_result, increment);
+			RTE_TEST_ASSERT_EQUAL(cvp_result, (const void *)ubase,
+				"RTE_PTR_SUB for const void* at offset=%zu inc=%zu",
+				offset, increment);
+
+			/* Test unaligned_uint16_t* using unaligned buffer */
+			u16p_result = RTE_PTR_ADD((unaligned_uint16_t *)ubase, increment);
+			RTE_TEST_ASSERT_EQUAL(u16p_result,
+				(unaligned_uint16_t *)((char *)ubase + increment),
+				"RTE_PTR_ADD for u16* at offset=%zu inc=%zu",
+				offset, increment);
+			RTE_TEST_ASSERT_EQUAL(*u16p_result, u16_uval,
+				"unaligned u16 dereference at offset=%zu inc=%zu",
+				offset, increment);
+			u16p_result = RTE_PTR_SUB(u16p_result, increment);
+			RTE_TEST_ASSERT_EQUAL(u16p_result, (unaligned_uint16_t *)ubase,
+				"RTE_PTR_SUB for u16* at offset=%zu inc=%zu",
+				offset, increment);
+
+			/* Test unaligned_uint32_t* using unaligned buffer */
+			u32p_result = RTE_PTR_ADD((unaligned_uint32_t *)ubase, increment);
+			RTE_TEST_ASSERT_EQUAL(u32p_result,
+				(unaligned_uint32_t *)((char *)ubase + increment),
+				"RTE_PTR_ADD for u32* at offset=%zu inc=%zu",
+				offset, increment);
+			RTE_TEST_ASSERT_EQUAL(*u32p_result, u32_uval,
+				"unaligned u32 dereference at offset=%zu inc=%zu",
+				offset, increment);
+			u32p_result = RTE_PTR_SUB(u32p_result, increment);
+			RTE_TEST_ASSERT_EQUAL(u32p_result, (unaligned_uint32_t *)ubase,
+				"RTE_PTR_SUB for u32* at offset=%zu inc=%zu",
+				offset, increment);
+
+			/* Test unaligned_uint64_t* using unaligned buffer */
+			u64p_result = RTE_PTR_ADD((unaligned_uint64_t *)ubase, increment);
+			RTE_TEST_ASSERT_EQUAL(u64p_result,
+				(unaligned_uint64_t *)((char *)ubase + increment),
+				"RTE_PTR_ADD for u64* at offset=%zu inc=%zu",
+				offset, increment);
+			RTE_TEST_ASSERT_EQUAL(*u64p_result, u64_uval,
+				"unaligned u64 dereference at offset=%zu inc=%zu",
+				offset, increment);
+			u64p_result = RTE_PTR_SUB(u64p_result, increment);
+			RTE_TEST_ASSERT_EQUAL(u64p_result, (unaligned_uint64_t *)ubase,
+				"RTE_PTR_SUB for u64* at offset=%zu inc=%zu",
+				offset, increment);
+
+			/* Test aligned uint16_t* at 2-byte aligned offsets */
+			if (offset % sizeof(uint16_t) == 0) {
+				uint16_t *a16p_result;
+				a16p_result = RTE_PTR_ADD((uint16_t *)abase, increment);
+				RTE_TEST_ASSERT_EQUAL(a16p_result,
+					(uint16_t *)((char *)abase + increment),
+					"RTE_PTR_ADD for uint16_t* at offset=%zu inc=%zu",
+					offset, increment);
+				RTE_TEST_ASSERT_EQUAL(*a16p_result, u16_aval,
+					"aligned u16 dereference at offset=%zu inc=%zu",
+					offset, increment);
+				a16p_result = RTE_PTR_SUB(a16p_result, increment);
+				RTE_TEST_ASSERT_EQUAL(a16p_result, (uint16_t *)abase,
+					"RTE_PTR_SUB for uint16_t* at offset=%zu inc=%zu",
+					offset, increment);
+			}
+
+			/* Test aligned uint32_t* at 4-byte aligned offsets */
+			if (offset % sizeof(uint32_t) == 0) {
+				uint32_t *a32p_result;
+				a32p_result = RTE_PTR_ADD((uint32_t *)abase, increment);
+				RTE_TEST_ASSERT_EQUAL(a32p_result,
+					(uint32_t *)((char *)abase + increment),
+					"RTE_PTR_ADD for uint32_t* at offset=%zu inc=%zu",
+					offset, increment);
+				RTE_TEST_ASSERT_EQUAL(*a32p_result, u32_aval,
+					"aligned u32 dereference at offset=%zu inc=%zu",
+					offset, increment);
+				a32p_result = RTE_PTR_SUB(a32p_result, increment);
+				RTE_TEST_ASSERT_EQUAL(a32p_result, (uint32_t *)abase,
+					"RTE_PTR_SUB for uint32_t* at offset=%zu inc=%zu",
+					offset, increment);
+			}
+
+			/* Test aligned uint64_t* at 8-byte aligned offsets */
+			if (offset % sizeof(uint64_t) == 0) {
+				uint64_t *a64p_result;
+				a64p_result = RTE_PTR_ADD((uint64_t *)abase, increment);
+				RTE_TEST_ASSERT_EQUAL(a64p_result,
+					(uint64_t *)((char *)abase + increment),
+					"RTE_PTR_ADD for uint64_t* at offset=%zu inc=%zu",
+					offset, increment);
+				RTE_TEST_ASSERT_EQUAL(*a64p_result, u64_aval,
+					"aligned u64 dereference at offset=%zu inc=%zu",
+					offset, increment);
+				a64p_result = RTE_PTR_SUB(a64p_result, increment);
+				RTE_TEST_ASSERT_EQUAL(a64p_result, (uint64_t *)abase,
+					"RTE_PTR_SUB for uint64_t* at offset=%zu inc=%zu",
+					offset, increment);
+			}
+
+			/* Test alignment functions with various alignments */
+			uptr_val = (uintptr_t)RTE_PTR_ADD(ubase, increment);
+			aptr_val = (uintptr_t)RTE_PTR_ADD(abase, increment);
+
+			/* Test power-of-2 alignments: 1, 2, 4, 8, 16 */
+			for (align = 1; align <= RTE_TEST_COMMON_MAX_ALIGNMENT; align <<= 1) {
+				/* Compute expected values using arithmetic, not masking */
+				uexp_floor = (uptr_val / align) * align;
+				uexp_ceil = ((uptr_val + align - 1) / align) * align;
+				aexp_floor = (aptr_val / align) * align;
+				aexp_ceil = ((aptr_val + align - 1) / align) * align;
+
+				result = RTE_PTR_ADD(ubase, increment);
+				result = RTE_PTR_ALIGN_FLOOR(result, align);
+				RTE_TEST_ASSERT_EQUAL((uintptr_t)result, uexp_floor,
+					"ALIGN_FLOOR offset=%zu inc=%zu align=%zu",
+					offset, increment, align);
+				RTE_TEST_ASSERT_EQUAL((uintptr_t)result % align, 0,
+					"ALIGN_FLOOR not aligned offset=%zu inc=%zu align=%zu",
+					offset, increment, align);
+
+				result = RTE_PTR_ADD(ubase, increment);
+				result = RTE_PTR_ALIGN_CEIL(result, align);
+				RTE_TEST_ASSERT_EQUAL((uintptr_t)result, uexp_ceil,
+					"ALIGN_CEIL offset=%zu inc=%zu align=%zu",
+					offset, increment, align);
+				RTE_TEST_ASSERT_EQUAL((uintptr_t)result % align, 0,
+					"ALIGN_CEIL not aligned offset=%zu inc=%zu align=%zu",
+					offset, increment, align);
+
+				result = RTE_PTR_ADD(ubase, increment);
+				result = RTE_PTR_ALIGN(result, align);
+				RTE_TEST_ASSERT_EQUAL((uintptr_t)result, uexp_ceil,
+					"ALIGN != CEIL offset=%zu inc=%zu align=%zu",
+					offset, increment, align);
+
+				/* Test type preservation */
+				cp_result = RTE_PTR_ADD((char *)ubase, increment);
+				cp_result = RTE_PTR_ALIGN_FLOOR(cp_result, align);
+				RTE_TEST_ASSERT_EQUAL((uintptr_t)cp_result, uexp_floor,
+					"char* ALIGN_FLOOR offset=%zu inc=%zu align=%zu",
+					offset, increment, align);
+
+				cp_result = RTE_PTR_ADD((char *)ubase, increment);
+				cp_result = RTE_PTR_ALIGN_CEIL(cp_result, align);
+				RTE_TEST_ASSERT_EQUAL((uintptr_t)cp_result, uexp_ceil,
+					"char* ALIGN_CEIL offset=%zu inc=%zu align=%zu",
+					offset, increment, align);
+
+				cp_result = RTE_PTR_ADD((char *)ubase, increment);
+				cp_result = RTE_PTR_ALIGN(cp_result, align);
+				RTE_TEST_ASSERT_EQUAL((uintptr_t)cp_result, uexp_ceil,
+					"char* ALIGN != CEIL offset=%zu inc=%zu align=%zu",
+					offset, increment, align);
+
+				/* Test aligned uint16_t* at 2-byte aligned offsets */
+				if (offset % sizeof(uint16_t) == 0 && align >= sizeof(uint16_t)) {
+					uint16_t *a16p_result;
+
+					a16p_result = RTE_PTR_ADD((uint16_t *)abase, increment);
+					a16p_result = RTE_PTR_ALIGN_FLOOR(a16p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a16p_result, aexp_floor,
+						"uint16_t* ALIGN_FLOOR offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a16p_result, u16_aval,
+						"uint16_t* ALIGN_FLOOR dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+
+					a16p_result = RTE_PTR_ADD((uint16_t *)abase, increment);
+					a16p_result = RTE_PTR_ALIGN_CEIL(a16p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a16p_result, aexp_ceil,
+						"uint16_t* ALIGN_CEIL offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a16p_result, u16_aval,
+						"uint16_t* ALIGN_CEIL dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+
+					a16p_result = RTE_PTR_ADD((uint16_t *)abase, increment);
+					a16p_result = RTE_PTR_ALIGN(a16p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a16p_result, aexp_ceil,
+						"uint16_t* ALIGN != CEIL offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a16p_result, u16_aval,
+						"uint16_t* ALIGN dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+				}
+
+				/* Test aligned uint32_t* at 4-byte aligned offsets */
+				if (offset % sizeof(uint32_t) == 0 && align >= sizeof(uint32_t)) {
+					uint32_t *a32p_result;
+
+					a32p_result = RTE_PTR_ADD((uint32_t *)abase, increment);
+					a32p_result = RTE_PTR_ALIGN_FLOOR(a32p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a32p_result, aexp_floor,
+						"uint32_t* ALIGN_FLOOR offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a32p_result, u32_aval,
+						"uint32_t* ALIGN_FLOOR dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+
+					a32p_result = RTE_PTR_ADD((uint32_t *)abase, increment);
+					a32p_result = RTE_PTR_ALIGN_CEIL(a32p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a32p_result, aexp_ceil,
+						"uint32_t* ALIGN_CEIL offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a32p_result, u32_aval,
+						"uint32_t* ALIGN_CEIL dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+
+					a32p_result = RTE_PTR_ADD((uint32_t *)abase, increment);
+					a32p_result = RTE_PTR_ALIGN(a32p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a32p_result, aexp_ceil,
+						"uint32_t* ALIGN != CEIL offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a32p_result, u32_aval,
+						"uint32_t* ALIGN dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+				}
+
+				/* Test aligned uint64_t* at 8-byte aligned offsets */
+				if (offset % sizeof(uint64_t) == 0 && align >= sizeof(uint64_t)) {
+					uint64_t *a64p_result;
+
+					a64p_result = RTE_PTR_ADD((uint64_t *)abase, increment);
+					a64p_result = RTE_PTR_ALIGN_FLOOR(a64p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a64p_result, aexp_floor,
+						"uint64_t* ALIGN_FLOOR offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a64p_result, u64_aval,
+						"uint64_t* ALIGN_FLOOR dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+
+					a64p_result = RTE_PTR_ADD((uint64_t *)abase, increment);
+					a64p_result = RTE_PTR_ALIGN_CEIL(a64p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a64p_result, aexp_ceil,
+						"uint64_t* ALIGN_CEIL offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a64p_result, u64_aval,
+						"uint64_t* ALIGN_CEIL dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+
+					a64p_result = RTE_PTR_ADD((uint64_t *)abase, increment);
+					a64p_result = RTE_PTR_ALIGN(a64p_result, align);
+					RTE_TEST_ASSERT_EQUAL((uintptr_t)a64p_result, aexp_ceil,
+						"uint64_t* ALIGN != CEIL offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+					RTE_TEST_ASSERT_EQUAL(*a64p_result, u64_aval,
+						"uint64_t* ALIGN dereference offset=%zu inc=%zu "
+						"align=%zu", offset, increment, align);
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int
+test_ptr_align_edge_cases(void)
+{
+/* Independent test parameters */
+#define RTE_COMMON_TEST_PAGE_SIZE 4096
+#define RTE_COMMON_TEST_CACHE_LINE_ALIGN RTE_CACHE_LINE_SIZE
+/* Dependent: computed based on test requirements */
+/* Must fit PAGE_SIZE alignment tests */
+#define RTE_COMMON_TEST_EDGE_CASE_BUFFER_SIZE (2 * RTE_COMMON_TEST_PAGE_SIZE)
+#define RTE_COMMON_TEST_DOUBLE_PAGE_SIZE (2 * RTE_COMMON_TEST_PAGE_SIZE)
+/* Must be >= CACHE_LINE_ALIGN to prevent overflow in CEIL boundary test */
+#define RTE_COMMON_TEST_BOUNDARY_TEST_OFFSET (2 * RTE_COMMON_TEST_CACHE_LINE_ALIGN)
+
+	/* Ensure BOUNDARY_TEST_OFFSET is large enough to prevent overflow in CEIL test */
+	/* near_max + CACHE_LINE_ALIGN - 1 must not wrap, so BOUNDARY_TEST_OFFSET >= CACHE_LINE_ALIGN */
+	RTE_BUILD_BUG_ON(RTE_COMMON_TEST_BOUNDARY_TEST_OFFSET < RTE_COMMON_TEST_CACHE_LINE_ALIGN);
+
+	alignas(RTE_CACHE_LINE_SIZE) char test_buffer[RTE_COMMON_TEST_EDGE_CASE_BUFFER_SIZE];
+	void *result;
+	uint64_t *typed_result;
+
+	/* Initialize buffer */
+	memset(test_buffer, 0xAA, sizeof(test_buffer));
+
+	/* Test 1: Very large alignment values (page size and beyond) */
+	const size_t large_alignments[] = {RTE_COMMON_TEST_PAGE_SIZE,
+					    RTE_COMMON_TEST_DOUBLE_PAGE_SIZE};
+	for (size_t i = 0; i < RTE_DIM(large_alignments); i++) {
+		size_t align = large_alignments[i];
+		void *unaligned_ptr = test_buffer + 1;  /* Intentionally misaligned by 1 byte */
+
+		/* Ensure buffer is large enough for this alignment */
+		RTE_TEST_ASSERT(RTE_COMMON_TEST_EDGE_CASE_BUFFER_SIZE >= align,
+			"Buffer too small for alignment %zu", align);
+
+		result = RTE_PTR_ALIGN_FLOOR(unaligned_ptr, align);
+		RTE_TEST_ASSERT((uintptr_t)result % align == 0,
+			"FLOOR with alignment %zu not aligned", align);
+		RTE_TEST_ASSERT(result <= unaligned_ptr,
+			"FLOOR with alignment %zu went forward", align);
+
+		result = RTE_PTR_ALIGN_CEIL(unaligned_ptr, align);
+		RTE_TEST_ASSERT((uintptr_t)result % align == 0,
+			"CEIL with alignment %zu not aligned", align);
+		RTE_TEST_ASSERT(result >= unaligned_ptr,
+			"CEIL with alignment %zu went backward", align);
+	}
+
+	/* Test 2: Address space boundary arithmetic (no dereferencing) */
+	/* Test FLOOR lower bound - pointer near zero */
+	/* Dynamically compute offset that allows FLOOR to align down without underflow */
+	uintptr_t near_zero = RTE_COMMON_TEST_BOUNDARY_TEST_OFFSET;
+	void *low_ptr = (void *)near_zero;
+	uintptr_t expected_floor = (near_zero / RTE_COMMON_TEST_CACHE_LINE_ALIGN) *
+				   RTE_COMMON_TEST_CACHE_LINE_ALIGN;
+
+	result = RTE_PTR_ALIGN_FLOOR(low_ptr, RTE_COMMON_TEST_CACHE_LINE_ALIGN);
+	RTE_TEST_ASSERT((uintptr_t)result % RTE_COMMON_TEST_CACHE_LINE_ALIGN == 0,
+		"Low address FLOOR not aligned to %d", RTE_COMMON_TEST_CACHE_LINE_ALIGN);
+	RTE_TEST_ASSERT((uintptr_t)result == expected_floor,
+		"Low address FLOOR computed incorrectly: got %p, expected %p",
+		result, (void *)expected_floor);
+	RTE_TEST_ASSERT((uintptr_t)result <= near_zero,
+		"Low address FLOOR went forward");
+
+	/* Test CEIL upper bound - pointer near UINTPTR_MAX */
+	/* Compute offset that allows CEIL to align up without wrapping */
+	/* Ensure no overflow: near_max + CACHE_LINE_ALIGN - 1 must not wrap */
+	uintptr_t near_max = UINTPTR_MAX - RTE_COMMON_TEST_BOUNDARY_TEST_OFFSET;
+	void *high_ptr = (void *)near_max;
+	uintptr_t expected_ceil = ((near_max + RTE_COMMON_TEST_CACHE_LINE_ALIGN - 1) /
+				   RTE_COMMON_TEST_CACHE_LINE_ALIGN) *
+				  RTE_COMMON_TEST_CACHE_LINE_ALIGN;
+
+	result = RTE_PTR_ALIGN_CEIL(high_ptr, RTE_COMMON_TEST_CACHE_LINE_ALIGN);
+	RTE_TEST_ASSERT((uintptr_t)result % RTE_COMMON_TEST_CACHE_LINE_ALIGN == 0,
+		"High address CEIL not aligned to %d", RTE_COMMON_TEST_CACHE_LINE_ALIGN);
+	RTE_TEST_ASSERT((uintptr_t)result == expected_ceil,
+		"High address CEIL computed incorrectly: got %p, expected %p",
+		result, (void *)expected_ceil);
+	RTE_TEST_ASSERT((uintptr_t)result >= near_max,
+		"High address CEIL went backward");
+
+	/* Test 3: Type preservation with extreme alignments */
+	/* Test CEIL with PAGE_SIZE - aligns upward into buffer */
+	typed_result = (uint64_t *)test_buffer;
+	typed_result = RTE_PTR_ALIGN_CEIL(typed_result, RTE_COMMON_TEST_PAGE_SIZE);
+	RTE_TEST_ASSERT((uintptr_t)typed_result % RTE_COMMON_TEST_PAGE_SIZE == 0,
+		"CEIL type preservation failed with PAGE_SIZE alignment");
+	RTE_TEST_ASSERT((uintptr_t)typed_result <
+			(uintptr_t)test_buffer + RTE_COMMON_TEST_EDGE_CASE_BUFFER_SIZE,
+		"CEIL went beyond buffer bounds");
+	/* Verify we can dereference as uint64_t* (compiler should allow this) */
+	*typed_result = 0x123456789ABCDEF0ULL;
+	RTE_TEST_ASSERT(*typed_result == 0x123456789ABCDEF0ULL,
+		"CEIL type-preserved pointer dereference failed");
+
+	/* Test FLOOR with CACHE_LINE_ALIGN - buffer is guaranteed cache-line aligned */
+	/* Use cache line alignment since buffer is only guaranteed RTE_CACHE_LINE_SIZE aligned */
+	typed_result = (uint64_t *)(test_buffer + RTE_COMMON_TEST_CACHE_LINE_ALIGN);
+	typed_result = RTE_PTR_ALIGN_FLOOR(typed_result, RTE_COMMON_TEST_CACHE_LINE_ALIGN);
+	RTE_TEST_ASSERT((uintptr_t)typed_result % RTE_COMMON_TEST_CACHE_LINE_ALIGN == 0,
+		"FLOOR type preservation failed with CACHE_LINE alignment");
+	RTE_TEST_ASSERT((uintptr_t)typed_result >= (uintptr_t)test_buffer,
+		"FLOOR went before buffer start");
+	RTE_TEST_ASSERT((uintptr_t)typed_result <
+			(uintptr_t)test_buffer + RTE_COMMON_TEST_EDGE_CASE_BUFFER_SIZE,
+		"FLOOR went beyond buffer bounds");
+	/* Safe to dereference now */
+	*typed_result = 0xDEADBEEFCAFEBABEULL;
+	RTE_TEST_ASSERT(*typed_result == 0xDEADBEEFCAFEBABEULL,
+		"FLOOR type-preserved pointer dereference failed");
+
+	return 0;
+}
+
 /* this is really a sanity check */
 static int
-test_macros(int __rte_unused unused_parm)
+test_macros(void)
 {
 #define SMALLER 0x1000U
 #define BIGGER 0x2000U
@@ -37,10 +494,6 @@ test_macros(int __rte_unused unused_parm)
 	RTE_SWAP(smaller, bigger);
 	RTE_TEST_ASSERT(smaller == BIGGER && bigger == SMALLER,
 		"RTE_SWAP");
-	RTE_TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(SMALLER, PTR_DIFF), BIGGER,
-		"RTE_PTR_ADD");
-	RTE_TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_SUB(BIGGER, PTR_DIFF), SMALLER,
-		"RTE_PTR_SUB");
 	RTE_TEST_ASSERT_EQUAL(RTE_PTR_DIFF(BIGGER, SMALLER), PTR_DIFF,
 		"RTE_PTR_DIFF");
 	RTE_TEST_ASSERT_EQUAL(RTE_MAX(SMALLER, BIGGER), BIGGER,
@@ -188,19 +641,11 @@ test_align(void)
 			if (RTE_ALIGN_FLOOR((uintptr_t)i, p) % p)
 				FAIL_ALIGN("RTE_ALIGN_FLOOR", i, p);
 
-			val = RTE_PTR_ALIGN_FLOOR((uintptr_t) i, p);
-			if (ERROR_FLOOR(val, i, p))
-				FAIL_ALIGN("RTE_PTR_ALIGN_FLOOR", i, p);
-
 			val = RTE_ALIGN_FLOOR(i, p);
 			if (ERROR_FLOOR(val, i, p))
 				FAIL_ALIGN("RTE_ALIGN_FLOOR", i, p);
 
 			/* align ceiling */
-			val = RTE_PTR_ALIGN((uintptr_t) i, p);
-			if (ERROR_CEIL(val, i, p))
-				FAIL_ALIGN("RTE_PTR_ALIGN", i, p);
-
 			val = RTE_ALIGN(i, p);
 			if (ERROR_CEIL(val, i, p))
 				FAIL_ALIGN("RTE_ALIGN", i, p);
@@ -209,10 +654,6 @@ test_align(void)
 			if (ERROR_CEIL(val, i, p))
 				FAIL_ALIGN("RTE_ALIGN_CEIL", i, p);
 
-			val = RTE_PTR_ALIGN_CEIL((uintptr_t)i, p);
-			if (ERROR_CEIL(val, i, p))
-				FAIL_ALIGN("RTE_PTR_ALIGN_CEIL", i, p);
-
 			/* by this point we know that val is aligned to p */
 			if (!rte_is_aligned((void*)(uintptr_t) val, p))
 				FAIL("rte_is_aligned");
@@ -340,18 +781,27 @@ test_fls(void)
 	return 0;
 }
 
+static struct unit_test_suite common_test_suite = {
+	.suite_name = "common autotest",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_ptr_add_sub_align),
+		TEST_CASE(test_ptr_align_edge_cases),
+		TEST_CASE(test_align),
+		TEST_CASE(test_macros),
+		TEST_CASE(test_misc),
+		TEST_CASE(test_bsf),
+		TEST_CASE(test_log2),
+		TEST_CASE(test_fls),
+		TEST_CASES_END()
+	}
+};
+
 static int
 test_common(void)
 {
-	int ret = 0;
-	ret |= test_align();
-	ret |= test_macros(0);
-	ret |= test_misc();
-	ret |= test_bsf();
-	ret |= test_log2();
-	ret |= test_fls();
-
-	return ret;
+	return unit_test_suite_runner(&common_test_suite);
 }
 
 REGISTER_FAST_TEST(common_autotest, NOHUGE_OK, ASAN_OK, test_common);
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 031eaa657e..dda0cec591 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -116,6 +116,19 @@ API Changes
   * cfgfile: name must be less than CFG_NAME_LEN
     and value must be less than CFG_VALUE_LEN.
 
+* **eal: Improved pointer arithmetic macros.**
+
+  * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL``,
+    and ``RTE_PTR_ALIGN_FLOOR`` now preserve const/volatile qualifiers and use
+    pointer arithmetic instead of integer casts to enable compiler optimizations. These
+    macros do not nest infinitely and may require intermediate variables.
+  * Passing NULL to ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``,
+    ``RTE_PTR_ALIGN_CEIL``, or ``RTE_PTR_ALIGN_FLOOR`` clarified as undefined behavior.
+  * Existing code passing integer types as pointer to ``RTE_PTR_ADD`` or ``RTE_PTR_SUB``
+    should use native operators (e.g. + -).
+  * Existing code passing integer types as pointer to ``RTE_PTR_ALIGN``,
+    ``RTE_PTR_ALIGN_CEIL`` or ``RTE_PTR_ALIGN_FLOOR`` should use
+    ``RTE_ALIGN``, ``RTE_ALIGN_CEIL`` or ``RTE_ALIGN_FLOOR``.
 
 ABI Changes
 -----------
diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 11fe3265d2..a1009bc0ca 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -367,9 +367,16 @@ cdx_vfio_get_region_info(int vfio_dev_fd, struct vfio_region_info **info,
 static int
 find_max_end_va(const struct rte_memseg_list *msl, void *arg)
 {
-	size_t sz = msl->len;
-	void *end_va = RTE_PTR_ADD(msl->base_va, sz);
-	void **max_va = arg;
+	size_t sz;
+	void *end_va;
+	void **max_va;
+
+	if (msl->base_va == NULL)
+		return 0;
+
+	sz = msl->len;
+	end_va = RTE_PTR_ADD(msl->base_va, sz);
+	max_va = arg;
 
 	if (*max_va < end_va)
 		*max_va = end_va;
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 2ffac82e94..455db2cdec 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -109,9 +109,13 @@ static int
 find_max_end_va(const struct rte_memseg_list *msl, void *arg)
 {
 	size_t sz = msl->len;
-	void *end_va = RTE_PTR_ADD(msl->base_va, sz);
+	void *end_va;
 	void **max_va = arg;
 
+	if (msl->base_va == NULL)
+		return 0;
+
+	end_va = RTE_PTR_ADD(msl->base_va, sz);
 	if (*max_va < end_va)
 		*max_va = end_va;
 	return 0;
diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index fbafc5027d..0ef05c0096 100644
--- a/drivers/bus/vmbus/linux/vmbus_uio.c
+++ b/drivers/bus/vmbus/linux/vmbus_uio.c
@@ -122,9 +122,13 @@ static int
 find_max_end_va(const struct rte_memseg_list *msl, void *arg)
 {
 	size_t sz = msl->memseg_arr.len * msl->page_sz;
-	void *end_va = RTE_PTR_ADD(msl->base_va, sz);
+	void *end_va;
 	void **max_va = arg;
 
+	if (msl->base_va == NULL)
+		return 0;
+
+	end_va = RTE_PTR_ADD(msl->base_va, sz);
 	if (*max_va < end_va)
 		*max_va = end_va;
 	return 0;
diff --git a/drivers/common/cnxk/roc_cpt_debug.c b/drivers/common/cnxk/roc_cpt_debug.c
index 28aedf088e..44c47a341c 100644
--- a/drivers/common/cnxk/roc_cpt_debug.c
+++ b/drivers/common/cnxk/roc_cpt_debug.c
@@ -16,8 +16,8 @@
 static inline void
 cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 {
-	struct cpt_frag_info_s *frag_info;
-	struct cpt_rxc_sg_s *rxc_sg;
+	const struct cpt_frag_info_s *frag_info;
+	const struct cpt_rxc_sg_s *rxc_sg;
 	uint32_t offset;
 	int i;
 
@@ -94,7 +94,7 @@ cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 		frag_info++;
 	}
 
-	rxc_sg = (struct cpt_rxc_sg_s *)frag_info;
+	rxc_sg = (const struct cpt_rxc_sg_s *)frag_info;
 	for (i = 0; i < cpth->w4.sctr_size; i++) {
 		cpt_dump(file, "CPT RXC SC SGS \t%p:", rxc_sg);
 		cpt_dump(file, "W0: seg1_size \t0x%x\t\tseg2_size \t0x%x\t\tseg3_size \t0x%04x",
@@ -125,9 +125,9 @@ cpt_cnxk_parse_hdr_dump(FILE *file, const struct cpt_parse_hdr_s *cpth)
 static inline void
 cpt_cn10k_parse_hdr_dump(FILE *file, const struct cpt_cn10k_parse_hdr_s *cpth)
 {
-	struct cpt_frag_info_s *frag_info;
+	const struct cpt_frag_info_s *frag_info;
 	uint32_t offset;
-	uint64_t *slot;
+	const uint64_t *slot;
 
 	cpt_dump(file, "CPT_PARSE \t0x%p:", cpth);
 
@@ -178,7 +178,7 @@ cpt_cn10k_parse_hdr_dump(FILE *file, const struct cpt_cn10k_parse_hdr_s *cpth)
 	cpt_dump(file, "W1: frag_size2 \t0x%x", frag_info->w1.frag_size2);
 	cpt_dump(file, "W1: frag_size3 \t0x%x", frag_info->w1.frag_size3);
 
-	slot = (uint64_t *)(frag_info + 1);
+	slot = (const uint64_t *)(frag_info + 1);
 	cpt_dump(file, "Frag Slot2:  WQE ptr \t%p", (void *)plt_be_to_cpu_64(slot[0]));
 	cpt_dump(file, "Frag Slot3:  WQE ptr \t%p", (void *)plt_be_to_cpu_64(slot[1]));
 }
diff --git a/drivers/common/cnxk/roc_ml.c b/drivers/common/cnxk/roc_ml.c
index 7390697b1d..e82bb58943 100644
--- a/drivers/common/cnxk/roc_ml.c
+++ b/drivers/common/cnxk/roc_ml.c
@@ -589,7 +589,9 @@ roc_ml_blk_init(struct roc_bphy *roc_bphy, struct roc_ml *roc_ml)
 
 	plt_ml_dbg(
 		"MLAB: Physical Address : 0x%016lx",
-		PLT_PTR_ADD_U64_CAST(ml->pci_dev->mem_resource[0].phys_addr, ML_MLAB_BLK_OFFSET));
+		   PLT_PTR_ADD_U64_CAST(
+				   (void *)(uintptr_t)(ml->pci_dev->mem_resource[0].phys_addr),
+				   ML_MLAB_BLK_OFFSET));
 	plt_ml_dbg("MLAB: Virtual Address : 0x%016lx",
 		   PLT_PTR_ADD_U64_CAST(ml->pci_dev->mem_resource[0].addr, ML_MLAB_BLK_OFFSET));
 
diff --git a/drivers/common/cnxk/roc_nix_bpf.c b/drivers/common/cnxk/roc_nix_bpf.c
index 98c9855a5b..5de4fc3efe 100644
--- a/drivers/common/cnxk/roc_nix_bpf.c
+++ b/drivers/common/cnxk/roc_nix_bpf.c
@@ -160,7 +160,7 @@ nix_precolor_conv_table_write(struct roc_nix *roc_nix, uint64_t val,
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	int64_t *addr;
 
-	addr = PLT_PTR_ADD(nix->base, off);
+	addr = (void *)(uintptr_t)(nix->base + off);
 	plt_write64(val, addr);
 }
 
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 7970ac2258..27f3f79c36 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -59,7 +59,7 @@ roc_nix_inl_on_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_ON_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline struct roc_ie_on_outb_sa *
@@ -67,7 +67,7 @@ roc_nix_inl_on_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_ON_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline void *
diff --git a/drivers/common/cnxk/roc_nix_inl_dp.h b/drivers/common/cnxk/roc_nix_inl_dp.h
index eb101db179..688d703fd1 100644
--- a/drivers/common/cnxk/roc_nix_inl_dp.h
+++ b/drivers/common/cnxk/roc_nix_inl_dp.h
@@ -49,7 +49,7 @@ roc_nix_inl_ot_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OT_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline struct roc_ot_ipsec_outb_sa *
@@ -57,7 +57,7 @@ roc_nix_inl_ot_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline void *
@@ -77,7 +77,7 @@ roc_nix_inl_ow_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OW_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline struct roc_ow_ipsec_outb_sa *
@@ -85,7 +85,7 @@ roc_nix_inl_ow_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline void *
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index 8ed988dec9..aae39fdb6e 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -1447,7 +1447,7 @@ mlx5_mempool_get_extmem_cb(struct rte_mempool *mp, void *opaque,
 	seg = &heap[data->heap_size - 1];
 	msl = rte_mem_virt2memseg_list((void *)addr);
 	page_size = msl != NULL ? msl->page_sz : rte_mem_page_size();
-	page_start = RTE_PTR_ALIGN_FLOOR(addr, page_size);
+	page_start = RTE_ALIGN_FLOOR(addr, page_size);
 	seg->start = page_start;
 	seg->end = page_start + page_size;
 	/* Maintain the heap order. */
diff --git a/drivers/dma/idxd/idxd_pci.c b/drivers/dma/idxd/idxd_pci.c
index 214f6f22d5..fb76a050b1 100644
--- a/drivers/dma/idxd/idxd_pci.c
+++ b/drivers/dma/idxd/idxd_pci.c
@@ -59,7 +59,7 @@ idxd_pci_dev_command(struct idxd_dmadev *idxd, enum rte_idxd_cmds command)
 	return err_code;
 }
 
-static uint32_t *
+static volatile uint32_t *
 idxd_get_wq_cfg(struct idxd_pci_common *pci, uint8_t wq_idx)
 {
 	return RTE_PTR_ADD(pci->wq_regs_base,
@@ -205,9 +205,9 @@ init_pci_device(struct rte_pci_device *dev, struct idxd_dmadev *idxd,
 	pci->regs = dev->mem_resource[0].addr;
 	version = pci->regs->version;
 	grp_offset = (uint16_t)pci->regs->offsets[0];
-	pci->grp_regs = RTE_PTR_ADD(pci->regs, grp_offset * 0x100);
+	pci->grp_regs = RTE_PTR_ADD((volatile void *)pci->regs, grp_offset * 0x100);
 	wq_offset = (uint16_t)(pci->regs->offsets[0] >> 16);
-	pci->wq_regs_base = RTE_PTR_ADD(pci->regs, wq_offset * 0x100);
+	pci->wq_regs_base = RTE_PTR_ADD((volatile void *)pci->regs, wq_offset * 0x100);
 	pci->portals = dev->mem_resource[2].addr;
 	pci->wq_cfg_sz = (pci->regs->wqcap >> 24) & 0x0F;
 
@@ -395,7 +395,10 @@ idxd_dmadev_probe_pci(struct rte_pci_driver *drv, struct rte_pci_device *dev)
 		/* add the queue number to each device name */
 		snprintf(qname, sizeof(qname), "%s-q%d", name, qid);
 		idxd.qid = qid;
-		idxd.portal = RTE_PTR_ADD(idxd.u.pci->portals,
+		/* FIXME: cast drops volatile propagation to idxd_dmadev.portal
+		 * See: https://bugs.dpdk.org/show_bug.cgi?id=1871
+		 */
+		idxd.portal = RTE_PTR_ADD(RTE_PTR_UNQUAL(idxd.u.pci->portals),
 				qid * IDXD_PORTAL_SIZE);
 		if (idxd_is_wq_enabled(&idxd))
 			IDXD_PMD_ERR("Error, WQ %u seems enabled", qid);
diff --git a/drivers/dma/odm/odm_dmadev.c b/drivers/dma/odm/odm_dmadev.c
index a2f4ed9a8e..3b4b058427 100644
--- a/drivers/dma/odm/odm_dmadev.c
+++ b/drivers/dma/odm/odm_dmadev.c
@@ -422,7 +422,7 @@ odm_dmadev_completed(void *dev_private, uint16_t vchan, const uint16_t nb_cpls,
 	int cnt;
 
 	vq = &odm->vq[vchan];
-	const uint32_t *base_addr = vq->cring_mz->addr;
+	uint32_t *base_addr = vq->cring_mz->addr;
 	const uint16_t cring_max_entry = vq->cring_max_entry;
 
 	cring_head = vq->cring_head;
@@ -482,7 +482,7 @@ odm_dmadev_completed_status(void *dev_private, uint16_t vchan, const uint16_t nb
 	int cnt;
 
 	vq = &odm->vq[vchan];
-	const uint32_t *base_addr = vq->cring_mz->addr;
+	uint32_t *base_addr = vq->cring_mz->addr;
 	const uint16_t cring_max_entry = vq->cring_max_entry;
 
 	cring_head = vq->cring_head;
diff --git a/drivers/event/cnxk/cn10k_worker.c b/drivers/event/cnxk/cn10k_worker.c
index 80077ec8a1..f33c3a561a 100644
--- a/drivers/event/cnxk/cn10k_worker.c
+++ b/drivers/event/cnxk/cn10k_worker.c
@@ -261,14 +261,14 @@ cn10k_sso_hws_new_event_lmtst(struct cn10k_sso_hws *ws, uint8_t queue_id,
 					aw7);
 
 			vst1q_u64((void *)lmt_addr, aw0);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 16), aw1);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 32), aw2);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 48), aw3);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 64), aw4);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 80), aw5);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 96), aw6);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 112), aw7);
-			lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 128);
+			vst1q_u64((void *)(lmt_addr + 16), aw1);
+			vst1q_u64((void *)(lmt_addr + 32), aw2);
+			vst1q_u64((void *)(lmt_addr + 48), aw3);
+			vst1q_u64((void *)(lmt_addr + 64), aw4);
+			vst1q_u64((void *)(lmt_addr + 80), aw5);
+			vst1q_u64((void *)(lmt_addr + 96), aw6);
+			vst1q_u64((void *)(lmt_addr + 112), aw7);
+			lmt_addr += 128;
 		} break;
 		case 4: {
 			uint64x2_t aw0, aw1, aw2, aw3;
@@ -291,10 +291,10 @@ cn10k_sso_hws_new_event_lmtst(struct cn10k_sso_hws *ws, uint8_t queue_id,
 					aw3);
 
 			vst1q_u64((void *)lmt_addr, aw0);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 16), aw1);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 32), aw2);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 48), aw3);
-			lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 64);
+			vst1q_u64((void *)(lmt_addr + 16), aw1);
+			vst1q_u64((void *)(lmt_addr + 32), aw2);
+			vst1q_u64((void *)(lmt_addr + 48), aw3);
+			lmt_addr += 64;
 		} break;
 		case 2: {
 			uint64x2_t aw0, aw1;
@@ -310,8 +310,8 @@ cn10k_sso_hws_new_event_lmtst(struct cn10k_sso_hws *ws, uint8_t queue_id,
 					aw1);
 
 			vst1q_u64((void *)lmt_addr, aw0);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 16), aw1);
-			lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 32);
+			vst1q_u64((void *)(lmt_addr + 16), aw1);
+			lmt_addr += 32;
 		} break;
 		case 1: {
 			__uint128_t aw0;
@@ -322,7 +322,7 @@ cn10k_sso_hws_new_event_lmtst(struct cn10k_sso_hws *ws, uint8_t queue_id,
 			aw0 |= (uint64_t)ev[0].sched_type << 32;
 
 			*((__uint128_t *)lmt_addr) = aw0;
-			lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 16);
+			lmt_addr += 16;
 		} break;
 		}
 		ev += parts;
@@ -338,7 +338,7 @@ cn10k_sso_hws_new_event_lmtst(struct cn10k_sso_hws *ws, uint8_t queue_id,
 		aw0 |= ev[0].event & (BIT_ULL(32) - 1);
 		aw0 |= (uint64_t)ev[0].sched_type << 32;
 		*((__uint128_t *)lmt_addr) = aw0;
-		lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 16);
+		lmt_addr += 16;
 	}
 #endif
 
diff --git a/drivers/event/cnxk/cn20k_worker.c b/drivers/event/cnxk/cn20k_worker.c
index 53daf3b4b0..8c1df3dbaf 100644
--- a/drivers/event/cnxk/cn20k_worker.c
+++ b/drivers/event/cnxk/cn20k_worker.c
@@ -231,14 +231,14 @@ cn20k_sso_hws_new_event_lmtst(struct cn20k_sso_hws *ws, uint8_t queue_id,
 			aw7 = vorrq_u64(vandq_u64(vshrq_n_u64(aw7, 6), tt_mask), aw7);
 
 			vst1q_u64((void *)lmt_addr, aw0);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 16), aw1);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 32), aw2);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 48), aw3);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 64), aw4);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 80), aw5);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 96), aw6);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 112), aw7);
-			lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 128);
+			vst1q_u64((void *)(lmt_addr + 16), aw1);
+			vst1q_u64((void *)(lmt_addr + 32), aw2);
+			vst1q_u64((void *)(lmt_addr + 48), aw3);
+			vst1q_u64((void *)(lmt_addr + 64), aw4);
+			vst1q_u64((void *)(lmt_addr + 80), aw5);
+			vst1q_u64((void *)(lmt_addr + 96), aw6);
+			vst1q_u64((void *)(lmt_addr + 112), aw7);
+			lmt_addr += 128;
 		} break;
 		case 4: {
 			uint64x2_t aw0, aw1, aw2, aw3;
@@ -253,10 +253,10 @@ cn20k_sso_hws_new_event_lmtst(struct cn20k_sso_hws *ws, uint8_t queue_id,
 			aw3 = vorrq_u64(vandq_u64(vshrq_n_u64(aw3, 6), tt_mask), aw3);
 
 			vst1q_u64((void *)lmt_addr, aw0);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 16), aw1);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 32), aw2);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 48), aw3);
-			lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 64);
+			vst1q_u64((void *)(lmt_addr + 16), aw1);
+			vst1q_u64((void *)(lmt_addr + 32), aw2);
+			vst1q_u64((void *)(lmt_addr + 48), aw3);
+			lmt_addr += 64;
 		} break;
 		case 2: {
 			uint64x2_t aw0, aw1;
@@ -268,8 +268,8 @@ cn20k_sso_hws_new_event_lmtst(struct cn20k_sso_hws *ws, uint8_t queue_id,
 			aw1 = vorrq_u64(vandq_u64(vshrq_n_u64(aw1, 6), tt_mask), aw1);
 
 			vst1q_u64((void *)lmt_addr, aw0);
-			vst1q_u64((void *)PLT_PTR_ADD(lmt_addr, 16), aw1);
-			lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 32);
+			vst1q_u64((void *)(lmt_addr + 16), aw1);
+			lmt_addr += 32;
 		} break;
 		case 1: {
 			__uint128_t aw0;
@@ -280,7 +280,7 @@ cn20k_sso_hws_new_event_lmtst(struct cn20k_sso_hws *ws, uint8_t queue_id,
 			aw0 |= (uint64_t)ev[0].sched_type << 32;
 
 			*((__uint128_t *)lmt_addr) = aw0;
-			lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 16);
+			lmt_addr += 16;
 		} break;
 		}
 		ev += parts;
@@ -296,7 +296,7 @@ cn20k_sso_hws_new_event_lmtst(struct cn20k_sso_hws *ws, uint8_t queue_id,
 		aw0 |= ev[0].event & (BIT_ULL(32) - 1);
 		aw0 |= (uint64_t)ev[0].sched_type << 32;
 		*((__uint128_t *)lmt_addr) = aw0;
-		lmt_addr = (uintptr_t)PLT_PTR_ADD(lmt_addr, 16);
+		lmt_addr += 16;
 	}
 #endif
 
diff --git a/drivers/mempool/bucket/rte_mempool_bucket.c b/drivers/mempool/bucket/rte_mempool_bucket.c
index c0b480bfc7..6fee10176b 100644
--- a/drivers/mempool/bucket/rte_mempool_bucket.c
+++ b/drivers/mempool/bucket/rte_mempool_bucket.c
@@ -376,8 +376,8 @@ count_underfilled_buckets(struct rte_mempool *mp,
 	uintptr_t align;
 	uint8_t *iter;
 
-	align = (uintptr_t)RTE_PTR_ALIGN_CEIL(memhdr->addr, bucket_page_sz) -
-		(uintptr_t)memhdr->addr;
+	align = RTE_PTR_DIFF(RTE_PTR_ALIGN_CEIL(memhdr->addr, bucket_page_sz),
+			     memhdr->addr);
 
 	for (iter = (uint8_t *)memhdr->addr + align;
 	     iter < (uint8_t *)memhdr->addr + memhdr->len;
@@ -602,8 +602,7 @@ bucket_populate(struct rte_mempool *mp, unsigned int max_objs,
 		return -EINVAL;
 
 	bucket_page_sz = rte_align32pow2(bd->bucket_mem_size);
-	align = RTE_PTR_ALIGN_CEIL((uintptr_t)vaddr, bucket_page_sz) -
-		(uintptr_t)vaddr;
+	align = RTE_PTR_DIFF(RTE_PTR_ALIGN_CEIL(vaddr, bucket_page_sz), vaddr);
 
 	bucket_header_sz = bd->header_size - mp->header_size;
 	if (iova != RTE_BAD_IOVA)
diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c
index e9d45f24c4..a5d112d52d 100644
--- a/drivers/net/cxgbe/sge.c
+++ b/drivers/net/cxgbe/sge.c
@@ -591,7 +591,7 @@ static void write_sgl(struct rte_mbuf *mbuf, struct sge_txq *q,
 			memcpy(sgl->sge, buf, part0);
 		part1 = RTE_PTR_DIFF((u8 *)end, (u8 *)q->stat);
 		rte_memcpy(q->desc, RTE_PTR_ADD((u8 *)buf, part0), part1);
-		end = RTE_PTR_ADD((void *)q->desc, part1);
+		end = RTE_PTR_ADD(q->desc, part1);
 	}
 	if ((uintptr_t)end & 8)           /* 0-pad to multiple of 16 */
 		*(u64 *)end = 0;
@@ -1297,7 +1297,7 @@ static void inline_tx_mbuf(const struct sge_txq *q, caddr_t from, caddr_t *to,
 		from = RTE_PTR_ADD(from, left);
 		left = len - left;
 		rte_memcpy((void *)q->desc, from, left);
-		*to = RTE_PTR_ADD((void *)q->desc, left);
+		*to = RTE_PTR_ADD(q->desc, left);
 	}
 }
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index ea4afbc75d..da23b271d5 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -2379,7 +2379,14 @@ static void *pci_bar_addr(struct rte_pci_device *dev, uint32_t bar)
 {
 	const struct rte_mem_resource *res = &dev->mem_resource[bar];
 	size_t offset = res->phys_addr % rte_mem_page_size();
-	void *vaddr = RTE_PTR_ADD(res->addr, offset);
+	void *vaddr;
+
+	if (res->addr == NULL) {
+		PMD_INIT_LOG_LINE(ERR, "PCI BAR [%u] address is NULL", bar);
+		return NULL;
+	}
+
+	vaddr = RTE_PTR_ADD(res->addr, offset);
 
 	PMD_INIT_LOG_LINE(INFO, "PCI BAR [%u]: phys_addr=0x%" PRIx64 ", addr=%p, offset=0x%zx, adjusted_addr=%p",
 		bar, res->phys_addr, res->addr, offset, vaddr);
diff --git a/drivers/net/mlx4/mlx4_txq.c b/drivers/net/mlx4/mlx4_txq.c
index 0db2e55bef..26e40e5218 100644
--- a/drivers/net/mlx4/mlx4_txq.c
+++ b/drivers/net/mlx4/mlx4_txq.c
@@ -114,7 +114,8 @@ txq_uar_uninit_secondary(struct txq *txq)
 	void *addr;
 
 	addr = ppriv->uar_table[txq->stats.idx];
-	munmap(RTE_PTR_ALIGN_FLOOR(addr, page_size), page_size);
+	if (addr != NULL)
+		munmap(RTE_PTR_ALIGN_FLOOR(addr, page_size), page_size);
 }
 
 /**
diff --git a/lib/eal/common/eal_common_fbarray.c b/lib/eal/common/eal_common_fbarray.c
index 8bdcefb717..526ba9f2eb 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 
 #include <rte_common.h>
+#include <rte_debug.h>
 #include <rte_eal_paging.h>
 #include <rte_errno.h>
 #include <rte_log.h>
@@ -1048,7 +1049,7 @@ void *
 rte_fbarray_get(const struct rte_fbarray *arr, unsigned int idx)
 {
 	void *ret = NULL;
-	if (arr == NULL) {
+	if (arr == NULL || arr->data == NULL) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index dccf9406c5..206c99695a 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -309,6 +309,9 @@ virt2memseg(const void *addr, const struct rte_memseg_list *msl)
 
 	/* a memseg list was specified, check if it's the right one */
 	start = msl->base_va;
+	if (start == NULL)
+		return NULL;
+
 	end = RTE_PTR_ADD(start, msl->len);
 
 	if (addr < start || addr >= end)
@@ -332,6 +335,8 @@ virt2memseg_list(const void *addr)
 		msl = &mcfg->memsegs[msl_idx];
 
 		start = msl->base_va;
+		if (start == NULL)
+			continue;
 		end = RTE_PTR_ADD(start, msl->len);
 		if (addr >= start && addr < end)
 			break;
@@ -680,10 +685,16 @@ RTE_EXPORT_SYMBOL(rte_mem_lock_page)
 int
 rte_mem_lock_page(const void *virt)
 {
-	uintptr_t virtual = (uintptr_t)virt;
 	size_t page_size = rte_mem_page_size();
-	uintptr_t aligned = RTE_PTR_ALIGN_FLOOR(virtual, page_size);
-	return rte_mem_lock((void *)aligned, page_size);
+	const void *aligned;
+
+	if (virt == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	aligned = RTE_PTR_ALIGN_FLOOR(virt, page_size);
+	return rte_mem_lock(aligned, page_size);
 }
 
 RTE_EXPORT_SYMBOL(rte_memseg_contig_walk_thread_unsafe)
@@ -1448,7 +1459,7 @@ handle_eal_memseg_info_request(const char *cmd __rte_unused,
 
 	ms_iova = ms->iova;
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = ms_start_addr + ms->len;
 	ms_size = ms->len;
 	hugepage_size = ms->hugepage_sz;
 	ms_socket_id = ms->socket_id;
@@ -1520,7 +1531,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 	}
 
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = ms_start_addr + ms->len;
 	rte_mcfg_mem_read_unlock();
 
 	rte_tel_data_start_dict(d);
@@ -1531,8 +1542,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 	elem = heap->first;
 	while (elem) {
 		elem_start_addr = (uint64_t)elem;
-		elem_end_addr =
-			(uint64_t)RTE_PTR_ADD(elem_start_addr, elem->size);
+		elem_end_addr = elem_start_addr + elem->size;
 
 		if ((uint64_t)elem_start_addr >= ms_start_addr &&
 		    (uint64_t)elem_end_addr <= ms_end_addr)
@@ -1554,7 +1564,8 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 	struct rte_mem_config *mcfg;
 	struct rte_memseg_list *msl;
 	const struct rte_memseg *ms;
-	struct malloc_elem *elem;
+	/* volatile placement consistent with malloc_heap pointers */
+	struct malloc_elem *volatile elem;
 	struct malloc_heap *heap;
 	struct rte_tel_data *c;
 	uint64_t ms_start_addr, ms_end_addr;
@@ -1598,7 +1609,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 	}
 
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = ms_start_addr + ms->len;
 
 	rte_mcfg_mem_read_unlock();
 
@@ -1610,8 +1621,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 	elem = heap->first;
 	while (elem) {
 		elem_start_addr = (uint64_t)elem;
-		elem_end_addr =
-			(uint64_t)RTE_PTR_ADD(elem_start_addr, elem->size);
+		elem_end_addr = elem_start_addr + elem->size;
 
 		if (elem_start_addr < ms_start_addr ||
 				elem_end_addr > ms_end_addr) {
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index aad676a004..2e732ff8ee 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1664,8 +1664,7 @@ eal_parse_base_virtaddr(const char *arg)
 	 * it can align to 2MB for x86. So this alignment can also be used
 	 * on x86 and other architectures.
 	 */
-	internal_conf->base_virtaddr =
-		RTE_PTR_ALIGN_CEIL((uintptr_t)addr, (size_t)RTE_PGSIZE_16M);
+	internal_conf->base_virtaddr = RTE_ALIGN_CEIL((uintptr_t)addr, (size_t)RTE_PGSIZE_16M);
 
 	return 0;
 }
diff --git a/lib/eal/common/malloc_elem.h b/lib/eal/common/malloc_elem.h
index c7ff6718f8..babaead7de 100644
--- a/lib/eal/common/malloc_elem.h
+++ b/lib/eal/common/malloc_elem.h
@@ -79,9 +79,11 @@ static const unsigned int MALLOC_ELEM_TRAILER_LEN = RTE_CACHE_LINE_SIZE;
 #define MALLOC_TRAILER_COOKIE  0xadd2e55badbadbadULL /**< Trailer cookie.*/
 
 /* define macros to make referencing the header and trailer cookies easier */
-#define MALLOC_ELEM_TRAILER(elem) (*((uint64_t*)RTE_PTR_ADD(elem, \
-		elem->size - MALLOC_ELEM_TRAILER_LEN)))
-#define MALLOC_ELEM_HEADER(elem) (elem->header_cookie)
+#define MALLOC_ELEM_TRAILER(elem) \
+	/* typeof preserves qualifiers (const/volatile) of elem */ \
+	(*(typeof((elem)->header_cookie) *)RTE_PTR_ADD(elem, \
+		(elem)->size - MALLOC_ELEM_TRAILER_LEN))
+#define MALLOC_ELEM_HEADER(elem) ((elem)->header_cookie)
 
 static inline void
 set_header(struct malloc_elem *elem)
@@ -306,13 +308,31 @@ old_malloc_size(struct malloc_elem *elem)
 static inline struct malloc_elem *
 malloc_elem_from_data(const void *data)
 {
+	struct malloc_elem *result;
+
 	if (data == NULL)
 		return NULL;
 
-	struct malloc_elem *elem = RTE_PTR_SUB(data, MALLOC_ELEM_HEADER_LEN);
-	if (!malloc_elem_cookies_ok(elem))
-		return NULL;
-	return elem->state != ELEM_PAD ? elem:  RTE_PTR_SUB(elem, elem->pad);
+	/* The allocator returns a pointer in the middle of an allocation pool.
+	 * GCC's interprocedural analysis can't trace this and warns about
+	 * out-of-bounds access when we do backwards pointer arithmetic to
+	 * find the malloc_elem header.
+	 */
+	__rte_diagnostic_push
+	__rte_diagnostic_ignored_array_bounds
+	{
+		struct malloc_elem *elem =
+			RTE_PTR_SUB(RTE_PTR_UNQUAL(data), MALLOC_ELEM_HEADER_LEN);
+
+		if (!malloc_elem_cookies_ok(elem))
+			result = NULL;
+		else
+			result = elem->state != ELEM_PAD ? elem :
+				RTE_PTR_SUB(elem, elem->pad);
+	}
+	__rte_diagnostic_pop
+
+	return result;
 }
 
 /*
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 6d3d46a390..49a89fe2fb 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -178,6 +178,10 @@ rte_eal_hugepage_init(void)
 					"RTE_MAX_MEMSEG_PER_TYPE and/or RTE_MAX_MEM_MB_PER_TYPE in configuration.");
 				return -1;
 			}
+			if (msl->base_va == NULL) {
+				EAL_LOG(ERR, "Base VA is NULL for memseg list %d", msl_idx);
+				return -1;
+			}
 			arr = &msl->memseg_arr;
 			seg = rte_fbarray_get(arr, ms_idx);
 
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..7fc6ce3bf0 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -103,6 +103,34 @@ extern "C" {
 		__GNUC_PATCHLEVEL__)
 #endif
 
+/*
+ * Type inference for use in macros.
+ */
+#if (defined(__cplusplus) && __cplusplus >= 201103L) || \
+		(defined(__STDC_VERSION__) && __STDC_VERSION__ >= 202311L)
+#define __rte_auto_type auto
+#elif defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
+#define __rte_auto_type __auto_type
+#endif
+
+/*
+ * Helper macro for array decay in pointer arithmetic macros.
+ * Example: char arr[10]; RTE_PTR_ADD(arr, 5) needs arr to decay to char*.
+ *
+ * GCC/Clang in C mode need "+ 0" to force arrays to decay to pointers.
+ * Not needed for C++ (automatic decay) or MSVC (ternary checks both branches).
+ *
+ * Note: This must be an object-like macro (not function-like) because it gets
+ * used with nested macro expansion (e.g., RTE_PTR_ALIGN_FLOOR(RTE_PTR_ADD(...))).
+ * A function-like macro would wrap the argument in parentheses, causing _Pragma
+ * directives from nested statement expressions to appear in invalid contexts.
+ */
+#if !defined(RTE_TOOLCHAIN_MSVC) && !defined(__cplusplus)
+#define __rte_ptr_arith_add_zero + 0
+#else
+#define __rte_ptr_arith_add_zero
+#endif
+
 /**
  * Force type alignment
  *
@@ -210,6 +238,16 @@ typedef uint16_t unaligned_uint16_t;
 #define __rte_diagnostic_ignored_wcast_qual
 #endif
 
+/**
+ * Macro to disable compiler warnings about invalid array bounds access.
+ */
+#if !defined(RTE_TOOLCHAIN_MSVC)
+#define __rte_diagnostic_ignored_array_bounds \
+	_Pragma("GCC diagnostic ignored \"-Warray-bounds\"")
+#else
+#define __rte_diagnostic_ignored_array_bounds
+#endif
+
 /**
  * Mark a function or variable to a weak reference.
  */
@@ -549,14 +587,72 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 /*********** Macros for pointer arithmetic ********/
 
 /**
- * add a byte-value offset to a pointer
+ * Add a byte-value offset to a pointer.
+ *
+ * @param ptr
+ *   The pointer (must be non-NULL)
+ * @param x
+ *   Byte offset to add
+ * @return
+ *   void* (or const void* / volatile void* / const volatile void* preserving qualifiers).
+ *   Returning void* prevents the compiler from making alignment assumptions based
+ *   on the pointer type, which is important when doing byte-offset arithmetic that
+ *   may cross struct boundaries or result in unaligned pointers.
  */
-#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
+#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
+#define RTE_PTR_ADD(ptr, x) \
+(__extension__ ({ \
+	/* (1) Force array decay and ensure single evaluation */ \
+	__rte_auto_type __rte_ptr_add = (ptr) __rte_ptr_arith_add_zero; \
+	__rte_diagnostic_push \
+	__rte_diagnostic_ignored_wcast_qual \
+	/* (2) Calculate result, preserving const/volatile via ternary */ \
+	__rte_auto_type __rte_ptr_add_res = \
+		(1 ? (void *)((char *)__rte_ptr_add + (x)) : __rte_ptr_add); \
+	__rte_diagnostic_pop \
+	/* (3) Return the result */ \
+	__rte_ptr_add_res; \
+}))
+#else
+/* MSVC fallback (ternary preserves const, no statement exprs) */
+#define RTE_PTR_ADD(ptr, x) \
+	(1 ? (void *)((char *)((ptr) __rte_ptr_arith_add_zero) + (x)) : \
+		((ptr) __rte_ptr_arith_add_zero))
+#endif
 
 /**
- * subtract a byte-value offset from a pointer
+ * Subtract a byte-value offset from a pointer.
+ *
+ * @param ptr
+ *   The pointer (must be non-NULL)
+ * @param x
+ *   Byte offset to subtract
+ * @return
+ *   void* (or const void* / volatile void* / const volatile void* preserving qualifiers).
+ *   Returning void* prevents the compiler from making alignment assumptions based
+ *   on the pointer type, which is important when doing byte-offset arithmetic that
+ *   may cross struct boundaries or result in unaligned pointers.
  */
-#define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
+#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
+#define RTE_PTR_SUB(ptr, x) \
+(__extension__ ({ \
+	/* (1) Force array decay and ensure single evaluation */ \
+	__rte_auto_type __rte_ptr_sub = (ptr) __rte_ptr_arith_add_zero; \
+	__rte_diagnostic_push \
+	__rte_diagnostic_ignored_wcast_qual \
+	/* (2) Calculate result, preserving const/volatile via ternary */ \
+	__rte_auto_type __rte_ptr_sub_res = \
+		(1 ? (void *)((char *)__rte_ptr_sub - (x)) : __rte_ptr_sub); \
+	__rte_diagnostic_pop \
+	/* (3) Return the result */ \
+	__rte_ptr_sub_res; \
+}))
+#else
+/* MSVC fallback (ternary preserves const, no statement exprs) */
+#define RTE_PTR_SUB(ptr, x) \
+	(1 ? (void *)((char *)((ptr) __rte_ptr_arith_add_zero) - (x)) : \
+		((ptr) __rte_ptr_arith_add_zero))
+#endif
 
 /**
  * get the difference between two pointer values, i.e. how far apart
@@ -602,13 +698,38 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 
 
 /**
- * Macro to align a pointer to a given power-of-two. The resultant
- * pointer will be a pointer of the same type as the first parameter, and
- * point to an address no higher than the first parameter. Second parameter
- * must be a power-of-two value.
+ * Macro to align a pointer to a given power-of-two.
+ *
+ * Aligns the pointer down to the specified alignment boundary.
+ *
+ * @param ptr
+ *   The pointer (must be non-NULL)
+ * @param align
+ *   Alignment boundary (must be a power-of-two value)
+ * @return
+ *   Aligned pointer of the same type as ptr, pointing to an address no higher than ptr.
+ *   Returns pointer of same type as input, preserving const/volatile qualifiers.
+ *   Since alignment operations guarantee proper alignment, the return type matches
+ *   the input type.
  */
+#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
 #define RTE_PTR_ALIGN_FLOOR(ptr, align) \
-	((typeof(ptr))RTE_ALIGN_FLOOR((uintptr_t)(ptr), align))
+(__extension__ ({ \
+	/* (1) Force array decay and ensure single evaluation */ \
+	__rte_auto_type __rte_ptr_floor = (ptr) __rte_ptr_arith_add_zero; \
+	/* (2) Compute misalignment as integer, but adjust pointer using pointer arithmetic */ \
+	size_t __rte_ptr_floor_misalign = (uintptr_t)__rte_ptr_floor & ((align) - 1); \
+	__rte_diagnostic_push \
+	__rte_diagnostic_ignored_wcast_qual \
+	/* (3) Return the aligned result, cast to preserve input type. We avoid RTE_PTR_SUB */ \
+	/*  to skip the void* cast which may defeat compiler alignment optimizations. */ \
+	(typeof(__rte_ptr_floor))((char *)__rte_ptr_floor - __rte_ptr_floor_misalign); \
+	__rte_diagnostic_pop \
+}))
+#else
+#define RTE_PTR_ALIGN_FLOOR(ptr, align) \
+	((typeof(ptr))RTE_ALIGN_FLOOR((uintptr_t) ((ptr) __rte_ptr_arith_add_zero), align))
+#endif
 
 /**
  * Macro to align a value to a given power-of-two. The resultant value
@@ -620,13 +741,41 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 	(typeof(val))((val) & (~((typeof(val))((align) - 1))))
 
 /**
- * Macro to align a pointer to a given power-of-two. The resultant
- * pointer will be a pointer of the same type as the first parameter, and
- * point to an address no lower than the first parameter. Second parameter
- * must be a power-of-two value.
+ * Macro to align a pointer to a given power-of-two.
+ *
+ * Aligns the pointer up to the specified alignment boundary.
+ *
+ * @param ptr
+ *   The pointer (must be non-NULL)
+ * @param align
+ *   Alignment boundary (must be a power-of-two value)
+ * @return
+ *   Aligned pointer of the same type as ptr, pointing to an address no lower than ptr.
+ *   Returns pointer of same type as input, preserving const/volatile qualifiers.
+ *   Since alignment operations guarantee proper alignment, the return type matches
+ *   the input type.
  */
+#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
+#define RTE_PTR_ALIGN_CEIL(ptr, align) \
+(__extension__ ({ \
+	/* (1) Force array decay and ensure single evaluation */ \
+	__rte_auto_type __rte_ptr_ceil = (ptr) __rte_ptr_arith_add_zero; \
+	/* (2) Compute alignment as integer, but adjust pointer using pointer arithmetic */ \
+	size_t __rte_ptr_ceil_align_m1 = (align) - 1; \
+	uintptr_t __rte_ptr_ceil_aligned = ((uintptr_t)__rte_ptr_ceil + __rte_ptr_ceil_align_m1) \
+						& ~__rte_ptr_ceil_align_m1; \
+	size_t __rte_ptr_ceil_offset = __rte_ptr_ceil_aligned - (uintptr_t)__rte_ptr_ceil; \
+	__rte_diagnostic_push \
+	__rte_diagnostic_ignored_wcast_qual \
+	/* (3) Return the aligned result, cast to preserve input type. We avoid RTE_PTR_SUB */ \
+	/*  to skip the void* cast which may defeat compiler alignment optimizations. */ \
+	(typeof(__rte_ptr_ceil))((char *)__rte_ptr_ceil + __rte_ptr_ceil_offset); \
+	__rte_diagnostic_pop \
+}))
+#else
 #define RTE_PTR_ALIGN_CEIL(ptr, align) \
 	RTE_PTR_ALIGN_FLOOR((typeof(ptr))RTE_PTR_ADD(ptr, (align) - 1), align)
+#endif
 
 /**
  * Macro to align a value to a given power-of-two. The resultant value
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index d9e8ea76b9..484ea8fc94 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -842,6 +842,12 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 		void *map_addr;
 
 		cur = rte_fbarray_get(&cur_msl->memseg_arr, cur_idx);
+
+		if (cur_msl->base_va == NULL) {
+			EAL_LOG(ERR, "Base VA is NULL for memseg list");
+			goto out;
+		}
+
 		map_addr = RTE_PTR_ADD(cur_msl->base_va,
 				cur_idx * page_sz);
 
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 7c4197a5b8..7198bdc0f8 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -764,6 +764,13 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 			return -1;
 		}
 		memseg_len = (size_t)page_sz;
+
+		if (msl->base_va == NULL) {
+			EAL_LOG(ERR, "Base VA is NULL for memseg list");
+			close(fd);
+			return -1;
+		}
+
 		addr = RTE_PTR_ADD(msl->base_va, ms_idx * memseg_len);
 
 		/* we know this address is already mmapped by memseg list, so
diff --git a/lib/eal/windows/eal_memalloc.c b/lib/eal/windows/eal_memalloc.c
index 5db5a474cc..6432caccd3 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -230,6 +230,12 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 		void *map_addr;
 
 		cur = rte_fbarray_get(&cur_msl->memseg_arr, cur_idx);
+
+		if (cur_msl->base_va == NULL) {
+			EAL_LOG(ERR, "Base VA is NULL for memseg list");
+			goto out;
+		}
+
 		map_addr = RTE_PTR_ADD(cur_msl->base_va, cur_idx * page_sz);
 
 		if (alloc_seg(cur, map_addr, wa->socket, wa->hi)) {
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index 7e433f4661..d8ac0011e4 100644
--- a/lib/graph/rte_graph.h
+++ b/lib/graph/rte_graph.h
@@ -407,9 +407,9 @@ void rte_graph_obj_dump(FILE *f, struct rte_graph *graph, bool all);
 /** Macro to browse rte_node object after the graph creation */
 #define rte_graph_foreach_node(count, off, graph, node)                        \
 	for (count = 0, off = graph->nodes_start,                              \
-	     node = RTE_PTR_ADD(graph, off);                                   \
+	     node = RTE_PTR_ADD(RTE_PTR_UNQUAL(graph), off);                           \
 	     count < graph->nb_nodes;                                          \
-	     off = node->next, node = RTE_PTR_ADD(graph, off), count++)
+	     off = node->next, node = RTE_PTR_ADD(RTE_PTR_UNQUAL(graph), off), count++)
 
 /**
  * Get node object with in graph from id.
diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index f8d6762dbc..64c57806d7 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -104,6 +104,9 @@ latencystats_collect(uint64_t values[])
 	unsigned int i, scale;
 	const uint64_t *stats;
 
+	if (glob_stats == NULL)
+		return;
+
 	for (i = 0; i < NUM_LATENCY_STATS; i++) {
 		stats = RTE_PTR_ADD(glob_stats, lat_stats_strings[i].offset);
 		scale = lat_stats_strings[i].scale;
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 0d931c7a15..46d3439f8a 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -193,6 +193,8 @@ __rte_pktmbuf_init_extmem(struct rte_mempool *mp,
 
 	RTE_ASSERT(ctx->ext < ctx->ext_num);
 	RTE_ASSERT(ctx->off + ext_mem->elt_size <= ext_mem->buf_len);
+	RTE_ASSERT(ext_mem->buf_ptr != NULL);
+	__rte_assume(ext_mem->buf_ptr != NULL);
 
 	m->buf_addr = RTE_PTR_ADD(ext_mem->buf_ptr, ctx->off);
 	rte_mbuf_iova_set(m, ext_mem->buf_iova == RTE_BAD_IOVA ? RTE_BAD_IOVA :
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 2004391f57..29a147eeb9 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -217,6 +217,8 @@ rte_mbuf_data_iova_default(const struct rte_mbuf *mb)
 static inline struct rte_mbuf *
 rte_mbuf_from_indirect(struct rte_mbuf *mi)
 {
+	RTE_ASSERT(mi != NULL);
+	__rte_assume(mi != NULL);
 	return (struct rte_mbuf *)RTE_PTR_SUB(mi->buf_addr, sizeof(*mi) + mi->priv_size);
 }
 
@@ -289,6 +291,8 @@ rte_mbuf_to_baddr(struct rte_mbuf *md)
 static inline void *
 rte_mbuf_to_priv(struct rte_mbuf *m)
 {
+	RTE_ASSERT(m != NULL);
+	__rte_assume(m != NULL);
 	return RTE_PTR_ADD(m, sizeof(struct rte_mbuf));
 }
 
diff --git a/lib/member/rte_xxh64_avx512.h b/lib/member/rte_xxh64_avx512.h
index 58f896ebb8..774b26d8df 100644
--- a/lib/member/rte_xxh64_avx512.h
+++ b/lib/member/rte_xxh64_avx512.h
@@ -58,7 +58,7 @@ rte_xxh64_sketch_avx512(const void *key, uint32_t key_len,
 			 _mm512_set1_epi64(key_len));
 
 	while (remaining >= 8) {
-		input = _mm512_set1_epi64(*(uint64_t *)RTE_PTR_ADD(key, offset));
+		input = _mm512_set1_epi64(*(const uint64_t *)RTE_PTR_ADD(key, offset));
 		v_hash = _mm512_xor_epi64(v_hash,
 				xxh64_round_avx512(_mm512_setzero_si512(), input));
 		v_hash = _mm512_madd52lo_epu64(_mm512_set1_epi64(PRIME64_4),
@@ -71,7 +71,7 @@ rte_xxh64_sketch_avx512(const void *key, uint32_t key_len,
 
 	if (remaining >= 4) {
 		input = _mm512_set1_epi64
-			(*(uint32_t *)RTE_PTR_ADD(key, offset));
+			(*(const uint32_t *)RTE_PTR_ADD(key, offset));
 		v_hash = _mm512_xor_epi64(v_hash,
 			_mm512_mullo_epi64(input,
 				_mm512_set1_epi64(PRIME64_1)));
@@ -86,7 +86,7 @@ rte_xxh64_sketch_avx512(const void *key, uint32_t key_len,
 
 	while (remaining != 0) {
 		input = _mm512_set1_epi64
-			(*(uint8_t *)RTE_PTR_ADD(key, offset));
+			(*(const uint8_t *)RTE_PTR_ADD(key, offset));
 		v_hash = _mm512_xor_epi64(v_hash,
 			_mm512_mullo_epi64(input,
 				_mm512_set1_epi64(PRIME64_5)));
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 1144dca58a..2c865035a6 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -376,6 +376,8 @@ struct __rte_cache_aligned rte_mempool {
 static inline struct rte_mempool_objhdr *
 rte_mempool_get_header(void *obj)
 {
+	RTE_ASSERT(obj != NULL);
+	__rte_assume(obj != NULL);
 	return (struct rte_mempool_objhdr *)RTE_PTR_SUB(obj,
 		sizeof(struct rte_mempool_objhdr));
 }
@@ -399,6 +401,8 @@ static inline struct rte_mempool *rte_mempool_from_obj(void *obj)
 static inline struct rte_mempool_objtlr *rte_mempool_get_trailer(void *obj)
 {
 	struct rte_mempool *mp = rte_mempool_from_obj(obj);
+	RTE_ASSERT(mp != NULL);
+	__rte_assume(mp != NULL);
 	return (struct rte_mempool_objtlr *)RTE_PTR_ADD(obj, mp->elt_size);
 }
 
@@ -1845,6 +1849,8 @@ static inline rte_iova_t
 rte_mempool_virt2iova(const void *elt)
 {
 	const struct rte_mempool_objhdr *hdr;
+	RTE_ASSERT(elt != NULL);
+	__rte_assume(elt != NULL);
 	hdr = (const struct rte_mempool_objhdr *)RTE_PTR_SUB(elt,
 		sizeof(*hdr));
 	return hdr->iova;
diff --git a/lib/pdcp/pdcp_entity.h b/lib/pdcp/pdcp_entity.h
index f854192e98..7a2c41dd56 100644
--- a/lib/pdcp/pdcp_entity.h
+++ b/lib/pdcp/pdcp_entity.h
@@ -198,17 +198,19 @@ struct entity_priv_ul_part {
 
 static inline struct entity_priv *
 entity_priv_get(const struct rte_pdcp_entity *entity) {
-	return RTE_PTR_ADD(entity, sizeof(struct rte_pdcp_entity));
+	return RTE_PTR_ADD(RTE_PTR_UNQUAL(entity), sizeof(struct rte_pdcp_entity));
 }
 
 static inline struct entity_priv_dl_part *
 entity_dl_part_get(const struct rte_pdcp_entity *entity) {
-	return RTE_PTR_ADD(entity, sizeof(struct rte_pdcp_entity) + sizeof(struct entity_priv));
+	return RTE_PTR_ADD(RTE_PTR_UNQUAL(entity),
+			   sizeof(struct rte_pdcp_entity) + sizeof(struct entity_priv));
 }
 
 static inline struct entity_priv_ul_part *
 entity_ul_part_get(const struct rte_pdcp_entity *entity) {
-	return RTE_PTR_ADD(entity, sizeof(struct rte_pdcp_entity) + sizeof(struct entity_priv));
+	return RTE_PTR_ADD(RTE_PTR_UNQUAL(entity),
+			   sizeof(struct rte_pdcp_entity) + sizeof(struct entity_priv));
 }
 
 static inline int
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..a9ab6487f2 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -824,9 +824,16 @@ void
 mem_set_dump(struct virtio_net *dev, void *ptr, size_t size, bool enable, uint64_t pagesz)
 {
 #ifdef MADV_DONTDUMP
-	void *start = RTE_PTR_ALIGN_FLOOR(ptr, pagesz);
-	uintptr_t end = RTE_ALIGN_CEIL((uintptr_t)ptr + size, pagesz);
-	size_t len = end - (uintptr_t)start;
+	void *start;
+	uintptr_t end;
+	size_t len;
+
+	if (ptr == NULL)
+		return;
+
+	start = RTE_PTR_ALIGN_FLOOR(ptr, pagesz);
+	end = RTE_ALIGN_CEIL((uintptr_t)ptr + size, pagesz);
+	len = end - (uintptr_t)start;
 
 	if (madvise(start, len, enable ? MADV_DODUMP : MADV_DONTDUMP) == -1) {
 		VHOST_CONFIG_LOG(dev->ifname, INFO,
-- 
2.39.5 (Apple Git-154)

