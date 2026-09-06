Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FFCC79F8C
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1424B4027E;
	Sun,  6 Sep 2026 19:12:19 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id DA5844026D
 for <dev@dpdk.org>; Sun,  6 Sep 2026 19:12:16 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so2331704b3a.1
 for <dev@dpdk.org>; Sun, 06 Sep 2026 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788714736;
 x=1789319536; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SsMhSbtRSXkWHvY3kgQhjRw8eHR7EkhYoTQXp6XiHwQ=;
 b=U/u5LKvruJ3Q2qAxRygKvZ/ziWH6I2mNj19JAyEedzvVvGq9+q8fhy0yMV6Wrvju2L
 FPiLlDUkJpGnBQ5/yyezvifz29GvsG0bIZw934ZFdV2j6h7WqdXu/8bGyl5hAGtUP0QE
 HH/Zy7ojTp6CA+JNIArRxECansNClTuRzNtA583ya3djrthi2sJw3Tj7G+QtgetCLUkh
 2BOaaDRkqxgCUrydA4PYnaPIbGxroV+mjM+CweU9zWewIsGXd/I7DOGMVx/JhgnVinTx
 sUqNYAUQY1XwzpPOP1AFGdGUON9utYRgQ83DjIk+Dc9s5PDboWaey5IE3rAUhsDbX36T
 Z/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788714736; x=1789319536;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SsMhSbtRSXkWHvY3kgQhjRw8eHR7EkhYoTQXp6XiHwQ=;
 b=rEM1hg/apznP2L7ZfyydlJRdrJXz74f63n1l0zFZj8PIHKocE+/6C/802+I5RTDtnz
 T2Np3ZdM3zaDLXrfmaUnZYd/vV8hiUIa60z1ZXpf2W/XVsWZroCAELWhTJJWcVOK3kfC
 z8GoBrPesRpO89bJZ9jKt3uHq7loxW6Y0nW+lpHRWrBUpWy/kJ5v/oLc4KvxXeX4Ae4p
 gpzcUDh0IS2C0e+DrACuZrkPVPpr6IBiC/TV4EBlNqPqqwC8XVBDGvMtARIW8P6RumB8
 koL8ws9Tt7Lhc3VEvmJG/qWiEqIg0yq4mhzRV2WX2px5iC/yGIQf2r9s0D8OzEy29BUc
 poiA==
X-Gm-Message-State: AFuF++kH5FSaqewxVzqycikjdmHb/k5t5WD1Wk87TUFNH7SgMoVWZU9u
 /tChcHygD3RKU75PASTW/5hTUb9FtvSdHq7LJUpvoCxYUMyvwd1Lg4oHhh8xYK4k918xUqixsIL
 zpRlb
X-Gm-Gg: AYBFou1n21S7Jvtg4GohWHzH5birPFnoHiQniWWQAV1C8nX+v6XcYeWSsii/UgmGpqi
 PM7Wya71lxWiDPIuVHzOfsEnb0kwtVmCD8Mz7GPGH+MP0i0vYnvy6yY4JuZuQq1OL0CmKVbJbTC
 f+0vDApzYoaUBeaxos6VHuDxT3EFMuWB+4KrpsImnDc1oO1n6dPPSUWAG99bsoXpfdmNrlZGsx6
 +MHhaLIYgesRhKpSpGSZSgrQgEZLJ2aUdv/5mfd6KpI/P8oAHdvOe1Yr8UbMoJf0FD54TiYAyzP
 RTUfJVi6C01qNLB5ZqW89WS+DJKziRMG/TBs6y4d7t33um06BZx5IqRFJ/r7tLcNC5xOPzsmiTF
 /v9qNdyDelSq5IBd6lrIVr+GSE+2ZK6TCPxBap8MaS8QJMWPj9CJKORHSWQzNYSsvs9S6Ay5oub
 m6Ffo3g3LnrTMFy87ZYmBpfZU8faPJjnEuNKB0MmWHT1rjfIryi0Gf+aX2ETus3CS12JAkTNckn
 kLUXriMKt3jOW9zEdoPzw+HVFw=
X-Received: by 2002:a05:6a00:3398:b0:848:5f4f:289d with SMTP id
 d2e1a72fcca58-861662d5c7dmr26582987b3a.4.1788714735556; 
 Sun, 06 Sep 2026 10:12:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm3309910b3a.38.2026.09.06.10.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 10:12:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Scott Mitchell <scott.k.mitch1@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Ori Kam <orika@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Chenbo Xia <chenbox@nvidia.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 "Artem V. Andreev" <artem.andreev@oktetlabs.ru>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Jerin Jacob <jerinj@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, Anoob Joseph <anoobj@marvell.com>,
 Volodymyr Fialko <vfialko@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2 2/5] eal: RTE_PTR_ADD/SUB API improvements
Date: Sun,  6 Sep 2026 10:09:55 -0700
Message-ID: <20260906171142.3503868-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906171142.3503868-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260906171142.3503868-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patch deprecates support for integer types which allows
addressing each of the challenges above.

Examples:
1. Clang is able to optimize and improve __rte_raw_cksum
(which uses RTE_PTR_ADD) by ~40% (100 bytes) to ~8x (1.5k bytes)
TSC cycles/byte.
2. Refactoring discovered cases that dropped qualifiers (volatile)
that the new API exposes.

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test-pmd/cmdline_flow.c                 |   4 +-
 app/test/test_common.c                      | 507 +++++++++++++++++++-
 doc/guides/rel_notes/release_26_11.rst      |  14 +
 drivers/bus/cdx/cdx_vfio.c                  |  13 +-
 drivers/bus/pci/linux/pci.c                 |   6 +-
 drivers/bus/vmbus/linux/vmbus_uio.c         |   6 +-
 drivers/common/cnxk/roc_cpt_debug.c         |  12 +-
 drivers/common/cnxk/roc_ml.c                |   4 +-
 drivers/common/cnxk/roc_nix_bpf.c           |   2 +-
 drivers/common/cnxk/roc_nix_inl.h           |   4 +-
 drivers/common/cnxk/roc_nix_inl_dp.h        |   8 +-
 drivers/common/mlx5/mlx5_common_mr.c        |   2 +-
 drivers/dma/idxd/idxd_pci.c                 |   2 +-
 drivers/dma/odm/odm_dmadev.c                |   4 +-
 drivers/event/cnxk/cn10k_worker.c           |  32 +-
 drivers/event/cnxk/cn20k_worker.c           |  32 +-
 drivers/mempool/bucket/rte_mempool_bucket.c |   7 +-
 drivers/net/cxgbe/sge.c                     |   4 +-
 drivers/net/ena/ena_ethdev.c                |  10 +-
 drivers/net/mlx4/mlx4_txq.c                 |   3 +-
 lib/eal/common/eal_common_fbarray.c         |   2 +-
 lib/eal/common/eal_common_memory.c          |  29 +-
 lib/eal/common/eal_common_options.c         |   3 +-
 lib/eal/common/malloc_elem.h                |  34 +-
 lib/eal/freebsd/eal_memory.c                |   4 +
 lib/eal/include/rte_common.h                | 179 ++++++-
 lib/eal/linux/eal_memalloc.c                |   5 +
 lib/eal/linux/eal_memory.c                  |   7 +
 lib/eal/windows/eal_memalloc.c              |   5 +
 lib/graph/rte_graph.h                       |   4 +-
 lib/latencystats/rte_latencystats.c         |   3 +
 lib/mbuf/rte_mbuf.c                         |   2 +
 lib/mbuf/rte_mbuf.h                         |   3 +
 lib/member/rte_xxh64_avx512.h               |   6 +-
 lib/mempool/rte_mempool.h                   |   5 +
 lib/pdcp/pdcp_entity.h                      |   8 +-
 lib/vhost/vhost_user.c                      |  13 +-
 37 files changed, 853 insertions(+), 135 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index fbbe36233b..27b7b6eb8a 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -12501,7 +12501,7 @@ parse_meter_color(struct context *ctx, const struct token *token,
 
 		if (!arg)
 			return -1;
-		*(int *)RTE_PTR_ADD(action->conf, arg->offset) = i;
+		*(int *)RTE_PTR_ADD(RTE_PTR_UNQUAL(action->conf), arg->offset) = i;
 	} else {
 		((struct rte_flow_item_meter_color *)
 			ctx->object)->color = (enum rte_color)i;
@@ -13384,7 +13384,7 @@ indirect_action_flow_conf_create(const struct buffer *in)
 		indlst_conf = NULL;
 		goto end;
 	}
-	indlst_conf->conf = RTE_PTR_ADD(indlst_conf, base + len);
+	indlst_conf->conf = (const void **)RTE_PTR_ADD(indlst_conf, base + len);
 	for (i = 0; i < indlst_conf->conf_num; i++)
 		indlst_conf->conf[i] = indlst_conf->actions[i].conf;
 	SLIST_INSERT_HEAD(&indlst_conf_head, indlst_conf, next);
diff --git a/app/test/test_common.c b/app/test/test_common.c
index 3e1c7df0c1..980b4ae8d4 100644
--- a/app/test/test_common.c
+++ b/app/test/test_common.c
@@ -20,9 +20,471 @@
 	{printf(x "() test failed!\n");\
 	return -1;}
 
+/* test_ptr_add_sub_align independent test parameters */
+#define RTE_TEST_COMMON_MAX_ALIGNMENT RTE_CACHE_LINE_SIZE
+#define RTE_TEST_COMMON_MAX_OFFSET 256
+#define RTE_TEST_COMMON_MAX_INCREMENT 128
+/* test_ptr_add_sub_align dependent: computed based on test requirements */
+/* Extra RTE_TEST_COMMON_MAX_ALIGNMENT to ensure CEIL can round up without going out of bounds */
+#define TEST_BUFFER_SIZE (RTE_TEST_COMMON_MAX_OFFSET + RTE_TEST_COMMON_MAX_INCREMENT + \
+	(2 * RTE_TEST_COMMON_MAX_ALIGNMENT) + 16)
+
+/* test_ptr_align_edge_cases independent test parameters */
+#define RTE_COMMON_TEST_PAGE_SIZE 4096
+#define RTE_COMMON_TEST_CACHE_LINE_ALIGN RTE_CACHE_LINE_SIZE
+/* test_ptr_align_edge_cases dependent: computed based on test requirements */
+/* Must fit PAGE_SIZE alignment tests */
+#define RTE_COMMON_TEST_EDGE_CASE_BUFFER_SIZE (2 * RTE_COMMON_TEST_PAGE_SIZE)
+#define RTE_COMMON_TEST_DOUBLE_PAGE_SIZE (2 * RTE_COMMON_TEST_PAGE_SIZE)
+/* Must be >= CACHE_LINE_ALIGN to prevent overflow in CEIL boundary test */
+#define RTE_COMMON_TEST_BOUNDARY_TEST_OFFSET (2 * RTE_COMMON_TEST_CACHE_LINE_ALIGN)
+
+static int
+test_ptr_add_sub_align(void)
+{
+	/* Unaligned buffer for testing unaligned pointer types */
+	char unaligned_buffer[TEST_BUFFER_SIZE];
+	/* Aligned buffer for testing aligned pointer types */
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
+			if (offset % sizeof(uint16_t) == 0 &&
+					increment % sizeof(uint16_t) == 0) {
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
+			if (offset % sizeof(uint32_t) == 0 &&
+					increment % sizeof(uint32_t) == 0) {
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
+			if (offset % sizeof(uint64_t) == 0 &&
+					increment % sizeof(uint64_t) == 0) {
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
+	/* Ensure BOUNDARY_TEST_OFFSET is large enough to prevent overflow in CEIL test */
+	/* near_max + CACHE_LINE_ALIGN - 1 must not wrap, so
+	 * BOUNDARY_TEST_OFFSET >= CACHE_LINE_ALIGN.
+	 */
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
+		RTE_TEST_ASSERT(align <= RTE_COMMON_TEST_EDGE_CASE_BUFFER_SIZE,
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
@@ -37,10 +499,6 @@ test_macros(int __rte_unused unused_parm)
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
@@ -188,19 +646,11 @@ test_align(void)
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
@@ -209,10 +659,6 @@ test_align(void)
 			if (ERROR_CEIL(val, i, p))
 				FAIL_ALIGN("RTE_ALIGN_CEIL", i, p);
 
-			val = RTE_PTR_ALIGN_CEIL((uintptr_t)i, p);
-			if (ERROR_CEIL(val, i, p))
-				FAIL_ALIGN("RTE_PTR_ALIGN_CEIL", i, p);
-
 			/* by this point we know that val is aligned to p */
 			if (!rte_is_aligned((void*)(uintptr_t) val, p))
 				FAIL("rte_is_aligned");
@@ -340,18 +786,27 @@ test_fls(void)
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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..4cadfc1918 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -95,6 +95,20 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **eal: Improved pointer arithmetic macros.**
+
+  * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL``,
+    and ``RTE_PTR_ALIGN_FLOOR`` now preserve const/volatile qualifiers and use
+    pointer arithmetic instead of integer casts to enable compiler optimizations.
+    These macros do not nest infinitely and may require intermediate variables.
+  * Passing NULL to ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``,
+    ``RTE_PTR_ALIGN_CEIL``, or ``RTE_PTR_ALIGN_FLOOR`` clarified as undefined behavior.
+  * ``RTE_PTR_ADD`` and ``RTE_PTR_SUB`` no longer accept integer types as the
+    pointer argument; existing code should use native operators (e.g. + -).
+  * ``RTE_PTR_ALIGN``, ``RTE_PTR_ALIGN_CEIL`` and ``RTE_PTR_ALIGN_FLOOR`` still
+    compile with an integer argument, but this is deprecated usage: existing code
+    should use ``RTE_ALIGN``, ``RTE_ALIGN_CEIL`` or ``RTE_ALIGN_FLOOR`` instead.
+
 
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
index 9aae0a5d14..bcf0a409da 100644
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
index 3c1c052e50..8ad7d6bd98 100644
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
-	struct cpt_cn10k_frag_info_s *frag_info;
+	const struct cpt_cn10k_frag_info_s *frag_info;
 	uint32_t offset;
-	uint64_t *slot;
+	const uint64_t *slot;
 
 	cpt_dump(file, "CPT_PARSE \t0x%p:", cpth);
 
@@ -177,7 +177,7 @@ cpt_cn10k_parse_hdr_dump(FILE *file, const struct cpt_cn10k_parse_hdr_s *cpth)
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
index 2832ed7961..06ccb304a1 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -64,7 +64,7 @@ roc_nix_inl_on_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_ON_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline struct roc_ie_on_outb_sa *
@@ -72,7 +72,7 @@ roc_nix_inl_on_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_ON_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline void *
diff --git a/drivers/common/cnxk/roc_nix_inl_dp.h b/drivers/common/cnxk/roc_nix_inl_dp.h
index 6443770871..ee232ca886 100644
--- a/drivers/common/cnxk/roc_nix_inl_dp.h
+++ b/drivers/common/cnxk/roc_nix_inl_dp.h
@@ -52,7 +52,7 @@ roc_nix_inl_ot_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OT_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline struct roc_ot_ipsec_outb_sa *
@@ -60,7 +60,7 @@ roc_nix_inl_ot_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline void *
@@ -80,7 +80,7 @@ roc_nix_inl_ow_ipsec_inb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OW_IPSEC_INB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline struct roc_ow_ipsec_outb_sa *
@@ -88,7 +88,7 @@ roc_nix_inl_ow_ipsec_outb_sa(uintptr_t base, uint64_t idx)
 {
 	uint64_t off = idx << ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ_LOG2;
 
-	return PLT_PTR_ADD(base, off);
+	return (void *)(base + off);
 }
 
 static inline void *
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index aa2d5e88a4..e8d532d674 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -1443,7 +1443,7 @@ mlx5_mempool_get_extmem_cb(struct rte_mempool *mp, void *opaque,
 	seg = &heap[data->heap_size - 1];
 	msl = rte_mem_virt2memseg_list((void *)addr);
 	page_size = msl != NULL ? msl->page_sz : rte_mem_page_size();
-	page_start = RTE_PTR_ALIGN_FLOOR(addr, page_size);
+	page_start = RTE_ALIGN_FLOOR(addr, page_size);
 	seg->start = page_start;
 	seg->end = page_start + page_size;
 	/* Maintain the heap order. */
diff --git a/drivers/dma/idxd/idxd_pci.c b/drivers/dma/idxd/idxd_pci.c
index 214f6f22d5..bc4a584495 100644
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
diff --git a/drivers/dma/odm/odm_dmadev.c b/drivers/dma/odm/odm_dmadev.c
index 7488b960fd..b51c68ebf3 100644
--- a/drivers/dma/odm/odm_dmadev.c
+++ b/drivers/dma/odm/odm_dmadev.c
@@ -437,7 +437,7 @@ odm_dmadev_completed(void *dev_private, uint16_t vchan, const uint16_t nb_cpls,
 	int cnt;
 
 	vq = &odm->vq[vchan];
-	const uint32_t *base_addr = vq->cring_mz->addr;
+	uint32_t *base_addr = vq->cring_mz->addr;
 	const uint16_t cring_max_entry = vq->cring_max_entry;
 
 	cring_head = vq->cring_head;
@@ -497,7 +497,7 @@ odm_dmadev_completed_status(void *dev_private, uint16_t vchan, const uint16_t nb
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
index ad2ac6dbbf..9a4d26551f 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -2379,7 +2379,15 @@ static void *pci_bar_addr(struct rte_pci_device *dev, uint32_t bar)
 {
 	const struct rte_mem_resource *res = &dev->mem_resource[bar];
 	size_t offset = res->phys_addr % rte_mem_page_size();
-	void *vaddr = RTE_PTR_ADD(res->addr, offset);
+	void *vaddr;
+
+	/* Not an error: the memory BAR is absent on non LLQ supported devices */
+	if (res->addr == NULL) {
+		PMD_INIT_LOG_LINE(DEBUG, "PCI BAR [%u] address is NULL", bar);
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
index 8bdcefb717..834e3d7ef0 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -1048,7 +1048,7 @@ void *
 rte_fbarray_get(const struct rte_fbarray *arr, unsigned int idx)
 {
 	void *ret = NULL;
-	if (arr == NULL) {
+	if (arr == NULL || arr->data == NULL) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 91724d0732..33681e7a37 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -328,6 +328,9 @@ virt2memseg(const void *addr, const struct rte_memseg_list *msl)
 
 	/* a memseg list was specified, check if it's the right one */
 	start = msl->base_va;
+	if (start == NULL)
+		return NULL;
+
 	end = RTE_PTR_ADD(start, msl->len);
 
 	if (addr < start || addr >= end)
@@ -351,6 +354,8 @@ virt2memseg_list(const void *addr)
 		msl = &mcfg->memsegs[msl_idx];
 
 		start = msl->base_va;
+		if (start == NULL)
+			continue;
 		end = RTE_PTR_ADD(start, msl->len);
 		if (addr >= start && addr < end)
 			break;
@@ -699,10 +704,16 @@ RTE_EXPORT_SYMBOL(rte_mem_lock_page)
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
@@ -1467,7 +1478,7 @@ handle_eal_memseg_info_request(const char *cmd __rte_unused,
 
 	ms_iova = ms->iova;
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = ms_start_addr + ms->len;
 	ms_size = ms->len;
 	hugepage_size = ms->hugepage_sz;
 	ms_socket_id = ms->socket_id;
@@ -1539,7 +1550,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 	}
 
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = ms_start_addr + ms->len;
 	rte_mcfg_mem_read_unlock();
 
 	rte_tel_data_start_dict(d);
@@ -1550,8 +1561,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 	elem = heap->first;
 	while (elem) {
 		elem_start_addr = (uint64_t)elem;
-		elem_end_addr =
-			(uint64_t)RTE_PTR_ADD(elem_start_addr, elem->size);
+		elem_end_addr = elem_start_addr + elem->size;
 
 		if ((uint64_t)elem_start_addr >= ms_start_addr &&
 		    (uint64_t)elem_end_addr <= ms_end_addr)
@@ -1617,7 +1627,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 	}
 
 	ms_start_addr = ms->addr_64;
-	ms_end_addr = (uint64_t)RTE_PTR_ADD(ms_start_addr, ms->len);
+	ms_end_addr = ms_start_addr + ms->len;
 
 	rte_mcfg_mem_read_unlock();
 
@@ -1629,8 +1639,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 	elem = heap->first;
 	while (elem) {
 		elem_start_addr = (uint64_t)elem;
-		elem_end_addr =
-			(uint64_t)RTE_PTR_ADD(elem_start_addr, elem->size);
+		elem_end_addr = elem_start_addr + elem->size;
 
 		if (elem_start_addr < ms_start_addr ||
 				elem_end_addr > ms_end_addr) {
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 42cdef632f..aa91d76355 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1696,8 +1696,7 @@ eal_parse_base_virtaddr(const char *arg)
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
index a239b83420..d87e479863 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -206,6 +206,10 @@ rte_eal_hugepage_init(void)
 					"Could not find suitable space for memseg in existing memseg lists");
 				return -1;
 			}
+			if (msl->base_va == NULL) {
+				EAL_LOG(ERR, "Base VA is NULL for memseg list %d", msl_idx);
+				return -1;
+			}
 			arr = &msl->memseg_arr;
 			seg = rte_fbarray_get(arr, ms_idx);
 
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index f872d3eabb..ed037be399 100644
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
@@ -197,6 +225,16 @@ typedef uint16_t unaligned_uint16_t;
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
@@ -570,14 +608,72 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
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
@@ -623,13 +719,40 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 
 
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
+	__rte_auto_type __rte_ptr_floor_res = \
+		(typeof(__rte_ptr_floor))((char *)__rte_ptr_floor - __rte_ptr_floor_misalign); \
+	__rte_diagnostic_pop \
+	__rte_ptr_floor_res; \
+}))
+#else
+#define RTE_PTR_ALIGN_FLOOR(ptr, align) \
+	((typeof(ptr))RTE_ALIGN_FLOOR((uintptr_t) ((ptr) __rte_ptr_arith_add_zero), align))
+#endif
 
 /**
  * Macro to align a value to a given power-of-two. The resultant value
@@ -641,13 +764,43 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
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
+	__rte_auto_type __rte_ptr_ceil_res = \
+		(typeof(__rte_ptr_ceil))((char *)__rte_ptr_ceil + __rte_ptr_ceil_offset); \
+	__rte_diagnostic_pop \
+	__rte_ptr_ceil_res; \
+}))
+#else
 #define RTE_PTR_ALIGN_CEIL(ptr, align) \
 	RTE_PTR_ALIGN_FLOOR((typeof(ptr))RTE_PTR_ADD(ptr, (align) - 1), align)
+#endif
 
 /**
  * Macro to align a value to a given power-of-two. The resultant value
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index df4c602c54..8bfcbb1469 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -787,6 +787,11 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	msl_idx = msl - mcfg->memsegs;
 	cur_msl = &mcfg->memsegs[msl_idx];
 
+	if (cur_msl->base_va == NULL) {
+		EAL_LOG(ERR, "Base VA is NULL for memseg list");
+		return -1;
+	}
+
 	need = wa->n_segs;
 
 	/* try finding space in memseg list */
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index d9d505d865..614f31a308 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -771,6 +771,13 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
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
index 5db5a474cc..232749573a 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -195,6 +195,11 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	msl_idx = msl - mcfg->memsegs;
 	cur_msl = &mcfg->memsegs[msl_idx];
 
+	if (cur_msl->base_va == NULL) {
+		EAL_LOG(ERR, "Base VA is NULL for memseg list");
+		return -1;
+	}
+
 	need = wa->n_segs;
 
 	/* try finding space in memseg list */
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index a90d6bb377..b5eb5d820e 100644
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
index 005bfaa573..ac6f3e1a3a 100644
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
index 60ec8158cd..ad72328136 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -217,6 +217,7 @@ rte_mbuf_data_iova_default(const struct rte_mbuf *mb)
 static inline struct rte_mbuf *
 rte_mbuf_from_indirect(struct rte_mbuf *mi)
 {
+	RTE_ASSERT(mi != NULL);
 	return (struct rte_mbuf *)RTE_PTR_SUB(mi->buf_addr, sizeof(*mi) + mi->priv_size);
 }
 
@@ -289,6 +290,8 @@ rte_mbuf_to_baddr(struct rte_mbuf *md)
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
index 50d958c7c6..40c3f26087 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -378,6 +378,8 @@ struct __rte_cache_aligned rte_mempool {
 static inline struct rte_mempool_objhdr *
 rte_mempool_get_header(void *obj)
 {
+	RTE_ASSERT(obj != NULL);
+	__rte_assume(obj != NULL);
 	return (struct rte_mempool_objhdr *)RTE_PTR_SUB(obj,
 		sizeof(struct rte_mempool_objhdr));
 }
@@ -401,6 +403,7 @@ static inline struct rte_mempool *rte_mempool_from_obj(void *obj)
 static inline struct rte_mempool_objtlr *rte_mempool_get_trailer(void *obj)
 {
 	struct rte_mempool *mp = rte_mempool_from_obj(obj);
+	RTE_ASSERT(mp != NULL);
 	return (struct rte_mempool_objtlr *)RTE_PTR_ADD(obj, mp->elt_size);
 }
 
@@ -1865,6 +1868,8 @@ static inline rte_iova_t
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
index 020c993b29..0f14df0d4e 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -858,9 +858,16 @@ void
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
2.53.0

