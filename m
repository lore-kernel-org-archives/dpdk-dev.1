Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163F3CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:11:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B19740677;
	Thu, 18 Sep 2025 11:11:00 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 9E1FB4067A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 11:10:58 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 4AB1BEC0253;
 Thu, 18 Sep 2025 05:10:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 18 Sep 2025 05:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758186658; x=
 1758273058; bh=vXFiGV71/c3JnB3cX4xCVfhHfZhjOSmndRSz0rYLxOI=; b=S
 RoepW8Mjb7FttHEsNPe4192a1tnwhMi7v9FDHWY1PgKQXj4Ae+w3DAId0nXwKPE2
 5D00mw6EfCKsHzUIa89yMqPiCnQZSCl6j6nhj08/rve7dKZaax8w6zE7owdFru1F
 XM+o3xL+NNM7OilJ6aMEPD1xKzo85ek426iy9YjC8Cn3r+itBNpELsHrGtxy/Muh
 Tr4VyYXv15Ni4TgiwCHZdFdHMxnkt2ahcYhbUqZRZvI+Dky9EcwflmwP/ZaUfCzx
 Wp/QpVeQiezSo9Nf67tnv5zHNwPopWENL002VHwR5pN7dze/NeGqcdcF7n91i0oB
 U5P1T+bcMHFyMtfaVnZ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758186658; x=1758273058; bh=v
 XFiGV71/c3JnB3cX4xCVfhHfZhjOSmndRSz0rYLxOI=; b=QavhCFh27ZZGaCX+2
 dRTrrYevYfgVLi8LDOIC3iS/DWlArkTskcAOhRZHxNks4rvZ1jelnNMxlnNV8AQN
 ysyZQ7rD7sWIPl4lUymsZTxSPY35GJH85OTqcLlsF0ksQ9WDfcgbQM3OEM7G3/J7
 HsWCfrcMz1B+dEOOAlqbplCP6kNgCBw5s8e0hSUVG3BYYz60VicWBNCrfakvRkp2
 fsdhWHIAREZQM4mI9W3Eq1WDRGv81YNTzScmXTY0FB2xB4DIQqyXHHOJSDQol08B
 0XWDN/LHcBAIBzVlsELW0xF20QTPvHLyOli1T/G2MWBU2ORJhCoOdT5YfyAChFE+
 CRU7w==
X-ME-Sender: <xms:oszLaKLXVyJLfcd_0JjBetCnHfzvdFd43kPDF08X-50JK_ZdT4anog>
 <xme:oszLaHhvZViBQzB6UUckwaAvjN8tpX-J_cAkMOfphUI0d5YHUSHXXTmJ1yhtUfHN1
 mtql5BiSATeM1DVRA>
X-ME-Received: <xmr:oszLaK4sI7PSuZIb1vGh9JbizrTgZawyG3nIEC2LQHYmjf9tRMfy5KKatrcXvy1SMkRZ0IpaIWj9tnkCM5_494wXV6fiDUU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheelgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtph
 htthhopeihihhpvghnghdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehs
 rghmvghhrdhgohgsrhhivghlsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:oszLaPbsmJeTKu0K2ZqvFN_ADLy6zhE-oavs9cppQHi6RwyHRg-VEw>
 <xmx:oszLaP4Saz3Glw6GJSYrXutyWbKwt3GNKbXHjikSZGKlOipYacXzIQ>
 <xmx:oszLaCAH5VTMgLK68VBI7W65RfURAXHzA2hTqMdQyiRji1MZ_KkKPA>
 <xmx:oszLaFciZz9yyNeINTRpIOsplKPRv0p4MZZdE02OVHEAM0RVbP2c1w>
 <xmx:oszLaKxXsj0jurlIUhqC4Zp5RkMB_MXLpNGpQ6QafKL2HoGw2yXbAEK_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 05:10:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH v2 3/4] member: remove AVX2 build-time checks
Date: Thu, 18 Sep 2025 11:08:09 +0200
Message-ID: <20250918091039.1368875-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918091039.1368875-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250918091039.1368875-1-thomas@monjalon.net>
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

Since all supported compilers can generate AVX2 code,
it is possible to force AVX2 compilation on some specific functions
and remove the checks for AVX2 support when x86 arch is already checked.

The functions have to be moved in a .c file, losing inlining.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 .../{rte_member_x86.h => member_avx2.c}       | 23 ++-----
 lib/member/meson.build                        |  2 +-
 lib/member/rte_member_ht.c                    | 14 ++--
 lib/member/rte_member_x86.h                   | 68 ++-----------------
 4 files changed, 21 insertions(+), 86 deletions(-)
 copy lib/member/{rte_member_x86.h => member_avx2.c} (87%)

diff --git a/lib/member/rte_member_x86.h b/lib/member/member_avx2.c
similarity index 87%
copy from lib/member/rte_member_x86.h
copy to lib/member/member_avx2.c
index 4de453485b..4c909d5b48 100644
--- a/lib/member/rte_member_x86.h
+++ b/lib/member/member_avx2.c
@@ -2,18 +2,14 @@
  * Copyright(c) 2017 Intel Corporation
  */
 
-#ifndef _RTE_MEMBER_X86_H_
-#define _RTE_MEMBER_X86_H_
-
 #include <x86intrin.h>
 
-#ifdef __cplusplus
-extern "C" {
-#endif
+#include <rte_bitops.h>
 
-#if defined(__AVX2__)
+#include "rte_member.h"
+#include "rte_member_x86.h"
 
-static inline int
+int
 update_entry_search_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 		struct member_ht_bucket *buckets,
 		member_set_t set_id)
@@ -29,7 +25,7 @@ update_entry_search_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 	return 0;
 }
 
-static inline int
+int
 search_bucket_single_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 		struct member_ht_bucket *buckets,
 		member_set_t *set_id)
@@ -48,7 +44,7 @@ search_bucket_single_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 	return 0;
 }
 
-static inline void
+void
 search_bucket_multi_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 				struct member_ht_bucket *buckets,
 				uint32_t *counter,
@@ -69,10 +65,3 @@ search_bucket_multi_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 		hitmask &= ~(3U << ((hit_idx) << 1));
 	}
 }
-#endif
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* _RTE_MEMBER_X86_H_ */
diff --git a/lib/member/meson.build b/lib/member/meson.build
index 07f9afaed9..fc08b70019 100644
--- a/lib/member/meson.build
+++ b/lib/member/meson.build
@@ -20,7 +20,7 @@ sources = files(
 
 deps += ['hash', 'ring']
 
-# compile AVX512 version if we have avx512 on MSVC or the 'ifma' flag on GCC/Clang
+sources_avx2 += files('member_avx2.c')
 if dpdk_conf.has('RTE_ARCH_X86_64')
     if is_ms_compiler
         sources_avx512 += files('rte_member_sketch_avx512.c')
diff --git a/lib/member/rte_member_ht.c b/lib/member/rte_member_ht.c
index 738471b378..0a5b206778 100644
--- a/lib/member/rte_member_ht.c
+++ b/lib/member/rte_member_ht.c
@@ -13,7 +13,7 @@
 #include "rte_member.h"
 #include "rte_member_ht.h"
 
-#if defined(RTE_ARCH_X86)
+#ifdef RTE_ARCH_X86
 #include "rte_member_x86.h"
 #endif
 
@@ -113,7 +113,7 @@ rte_member_create_ht(struct rte_member_setsum *ss,
 		for (j = 0; j < RTE_MEMBER_BUCKET_ENTRIES; j++)
 			buckets[i].sets[j] = RTE_MEMBER_NO_MATCH;
 	}
-#if defined(RTE_ARCH_X86)
+#ifdef RTE_ARCH_X86
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) &&
 			RTE_MEMBER_BUCKET_ENTRIES == 16 &&
 			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
@@ -179,7 +179,7 @@ rte_member_lookup_ht(const struct rte_member_setsum *ss,
 	get_buckets_index(ss, key, &prim_bucket, &sec_bucket, &tmp_sig);
 
 	switch (ss->sig_cmp_fn) {
-#if defined(RTE_ARCH_X86) && defined(__AVX2__)
+#ifdef RTE_ARCH_X86
 	case RTE_MEMBER_COMPARE_AVX2:
 		if (search_bucket_single_avx(prim_bucket, tmp_sig, buckets,
 				set_id) ||
@@ -219,7 +219,7 @@ rte_member_lookup_bulk_ht(const struct rte_member_setsum *ss,
 
 	for (i = 0; i < num_keys; i++) {
 		switch (ss->sig_cmp_fn) {
-#if defined(RTE_ARCH_X86) && defined(__AVX2__)
+#ifdef RTE_ARCH_X86
 		case RTE_MEMBER_COMPARE_AVX2:
 			if (search_bucket_single_avx(prim_buckets[i],
 					tmp_sig[i], buckets, &set_id[i]) ||
@@ -256,7 +256,7 @@ rte_member_lookup_multi_ht(const struct rte_member_setsum *ss,
 	get_buckets_index(ss, key, &prim_bucket, &sec_bucket, &tmp_sig);
 
 	switch (ss->sig_cmp_fn) {
-#if defined(RTE_ARCH_X86) && defined(__AVX2__)
+#ifdef RTE_ARCH_X86
 	case RTE_MEMBER_COMPARE_AVX2:
 		search_bucket_multi_avx(prim_bucket, tmp_sig, buckets,
 			&num_matches, match_per_key, set_id);
@@ -299,7 +299,7 @@ rte_member_lookup_multi_bulk_ht(const struct rte_member_setsum *ss,
 		match_cnt_tmp = 0;
 
 		switch (ss->sig_cmp_fn) {
-#if defined(RTE_ARCH_X86) && defined(__AVX2__)
+#ifdef RTE_ARCH_X86
 		case RTE_MEMBER_COMPARE_AVX2:
 			search_bucket_multi_avx(prim_buckets[i], tmp_sig[i],
 				buckets, &match_cnt_tmp, match_per_key,
@@ -360,7 +360,7 @@ try_update(struct member_ht_bucket *buckets, uint32_t prim, uint32_t sec,
 		enum rte_member_sig_compare_function cmp_fn)
 {
 	switch (cmp_fn) {
-#if defined(RTE_ARCH_X86) && defined(__AVX2__)
+#ifdef RTE_ARCH_X86
 	case RTE_MEMBER_COMPARE_AVX2:
 		if (update_entry_search_avx(prim, sig, buckets, set_id) ||
 				update_entry_search_avx(sec, sig, buckets,
diff --git a/lib/member/rte_member_x86.h b/lib/member/rte_member_x86.h
index 4de453485b..dea2a9f7aa 100644
--- a/lib/member/rte_member_x86.h
+++ b/lib/member/rte_member_x86.h
@@ -5,74 +5,20 @@
 #ifndef _RTE_MEMBER_X86_H_
 #define _RTE_MEMBER_X86_H_
 
-#include <x86intrin.h>
+#include "rte_member_ht.h"
 
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#if defined(__AVX2__)
-
-static inline int
-update_entry_search_avx(uint32_t bucket_id, member_sig_t tmp_sig,
+int update_entry_search_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 		struct member_ht_bucket *buckets,
-		member_set_t set_id)
-{
-	uint32_t hitmask = _mm256_movemask_epi8((__m256i)_mm256_cmpeq_epi16(
-		_mm256_load_si256((__m256i const *)buckets[bucket_id].sigs),
-		_mm256_set1_epi16(tmp_sig)));
-	if (hitmask) {
-		uint32_t hit_idx = rte_ctz32(hitmask) >> 1;
-		buckets[bucket_id].sets[hit_idx] = set_id;
-		return 1;
-	}
-	return 0;
-}
+		member_set_t set_id);
 
-static inline int
-search_bucket_single_avx(uint32_t bucket_id, member_sig_t tmp_sig,
+int search_bucket_single_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 		struct member_ht_bucket *buckets,
-		member_set_t *set_id)
-{
-	uint32_t hitmask = _mm256_movemask_epi8((__m256i)_mm256_cmpeq_epi16(
-		_mm256_load_si256((__m256i const *)buckets[bucket_id].sigs),
-		_mm256_set1_epi16(tmp_sig)));
-	while (hitmask) {
-		uint32_t hit_idx = rte_ctz32(hitmask) >> 1;
-		if (buckets[bucket_id].sets[hit_idx] != RTE_MEMBER_NO_MATCH) {
-			*set_id = buckets[bucket_id].sets[hit_idx];
-			return 1;
-		}
-		hitmask &= ~(3U << ((hit_idx) << 1));
-	}
-	return 0;
-}
+		member_set_t *set_id);
 
-static inline void
-search_bucket_multi_avx(uint32_t bucket_id, member_sig_t tmp_sig,
+void search_bucket_multi_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 				struct member_ht_bucket *buckets,
 				uint32_t *counter,
 				uint32_t match_per_key,
-				member_set_t *set_id)
-{
-	uint32_t hitmask = _mm256_movemask_epi8((__m256i)_mm256_cmpeq_epi16(
-		_mm256_load_si256((__m256i const *)buckets[bucket_id].sigs),
-		_mm256_set1_epi16(tmp_sig)));
-	while (hitmask) {
-		uint32_t hit_idx = rte_ctz32(hitmask) >> 1;
-		if (buckets[bucket_id].sets[hit_idx] != RTE_MEMBER_NO_MATCH) {
-			set_id[*counter] = buckets[bucket_id].sets[hit_idx];
-			(*counter)++;
-			if (*counter >= match_per_key)
-				return;
-		}
-		hitmask &= ~(3U << ((hit_idx) << 1));
-	}
-}
-#endif
-
-#ifdef __cplusplus
-}
-#endif
+				member_set_t *set_id);
 
 #endif /* _RTE_MEMBER_X86_H_ */
-- 
2.51.0

