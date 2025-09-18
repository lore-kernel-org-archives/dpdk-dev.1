Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B29CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:11:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B66240676;
	Thu, 18 Sep 2025 11:10:58 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 6CB8140288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 11:10:56 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0D09A1400268;
 Thu, 18 Sep 2025 05:10:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 18 Sep 2025 05:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758186656; x=
 1758273056; bh=3gwXzBHQVtyyblRiE/cX+j+zGKsjvzFA1biSb54O43w=; b=j
 qIZiYPq7+jyZ+DE9DRrTQ3IexEPSoMb1ZBLnHbWLINo0ovQScJn/v0TKIRoNZ4KP
 3ZiNDkh3QhH6KrFAxW/8dA+XY6jQErjGjS7EgJdI46AeykbqIg23hn08paaDx0uf
 dpzHoauO6CnIwVqm3Pe+GS1khiJqLVOTd8mj78BM65slmLi1ACQV5WV8rk1ODnfN
 uhdZSu5ZOubTZ6SnkEZqST86UJKseI+M/U5nhVNRwrbPCKM9nP4iNWA76sA+RpWf
 e60Mna1l910te7GbvnGpYZhyUYW4rhyC+L2eGKRBbGkYVzBbCNUDCXMvUb2Z8ikm
 RQieMtaya4gbMAeo/TrIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758186656; x=1758273056; bh=3
 gwXzBHQVtyyblRiE/cX+j+zGKsjvzFA1biSb54O43w=; b=drcRF+9bTp7oTO0n7
 zh4JzV5Y+75FJm3CHo4GZcc9eCCJCM8K4eqqRAVq8+Jv+DLWTCf7YmCany9jY/1Y
 q6KQ8F/lhopseYQW4b9KHBSKFs0OyUDZGx0aXtqLahuRy6Nhf5KdWA4TWUVOVUVs
 cqjegCqlOPCCpK7cGtIgQ4iSzWGtSXPe2NW3lCNRaMTC5aJ6kjpj8TlObyeICU29
 q08eVDrYnn4NxsqgOHGjjjEJrtzPJULOPlMFahf6x4QP6LJ2RUobIpBNeABsu/JN
 187m104X3YL9DP8On4D+Kxp/4oE1ZrAjScYjtJEwQVhQjUeZkti35c1MRuT185gW
 UtWmg==
X-ME-Sender: <xms:n8zLaPi02_4cTCvt3knjnYLe1CZKHuJpH5k6l5fWtWLsMh8UURSTUA>
 <xme:n8zLaBbxrVRWLdkbnsBYgO5-RpdSYWFz4nun41IWNMlccWcix68jwb4Oap3bVX98j
 IgIoB9scFnknVncXg>
X-ME-Received: <xmr:n8zLaPRQHsS3yxsG35C3Am990mLW2wpP5-XR6ZlBikPREpFyTvbM-JGavboa42mxoVE59OrQlTtizkzAkZSyJnTa9RJX3cM>
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
 htthhopegshihrohhnrdhmrghrohhhnhesihhnthgvlhdrtghomhdprhgtphhtthhopeih
 ihhpvghnghdurdifrghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:n8zLaMRCppnDcnKbfL-9GQsz_OvfLEstfj5b7doZMF6vk8hBFZ04iQ>
 <xmx:n8zLaLSvF9Y7s7UFC9y94SdTUHl5GmEpD43dzj5tu5uHSLrkjZocYg>
 <xmx:n8zLaJ5E97bf3tW3xqrjKmGVblQYEjVhkM04RdBZ0RvZNndLiHTsvg>
 <xmx:n8zLaP2EklimywH3veKoATBzSPHtllB4LxrCNeXNqs9nZuo6MIs0Qw>
 <xmx:oMzLaIqJs1XJHy9w8qLxxYkgl_8ogtOpaDEvrW5rWvHI2nY4JJZqVKOo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 05:10:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v2 2/4] efd: remove AVX2 build-time check
Date: Thu, 18 Sep 2025 11:08:08 +0200
Message-ID: <20250918091039.1368875-3-thomas@monjalon.net>
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
it is possible to force AVX2 compilation on the specific function
and remove the check for AVX2 support.

The function has to be moved in a .c file, losing inlining.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/efd/{rte_efd_x86.h => efd_avx2.c} | 18 ++-------
 lib/efd/meson.build                   |  1 +
 lib/efd/rte_efd_x86.h                 | 54 +--------------------------
 3 files changed, 7 insertions(+), 66 deletions(-)
 copy lib/efd/{rte_efd_x86.h => efd_avx2.c} (80%)

diff --git a/lib/efd/rte_efd_x86.h b/lib/efd/efd_avx2.c
similarity index 80%
copy from lib/efd/rte_efd_x86.h
copy to lib/efd/efd_avx2.c
index e2f9dcca88..653976e96b 100644
--- a/lib/efd/rte_efd_x86.h
+++ b/lib/efd/efd_avx2.c
@@ -2,11 +2,11 @@
  * Copyright(c) 2016-2017 Intel Corporation
  */
 
-/* rte_efd_x86.h
- * This file holds all x86 specific EFD functions
- */
 #include <immintrin.h>
 
+#include "rte_efd.h"
+#include "rte_efd_x86.h"
+
 #if (RTE_EFD_VALUE_NUM_BITS == 8 || RTE_EFD_VALUE_NUM_BITS == 16 || \
 	RTE_EFD_VALUE_NUM_BITS == 24 || RTE_EFD_VALUE_NUM_BITS == 32)
 #define EFD_LOAD_SI128(val) _mm_load_si128(val)
@@ -14,12 +14,11 @@
 #define EFD_LOAD_SI128(val) _mm_lddqu_si128(val)
 #endif
 
-static inline efd_value_t
+efd_value_t
 efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
 		const efd_lookuptbl_t *group_lookup_table,
 		const uint32_t hash_val_a, const uint32_t hash_val_b)
 {
-#ifdef __AVX2__
 	efd_value_t value = 0;
 	uint32_t i = 0;
 	__m256i vhash_val_a = _mm256_set1_epi32(hash_val_a);
@@ -45,13 +44,4 @@ efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
 	}
 
 	return value;
-#else
-	RTE_SET_USED(group_hash_idx);
-	RTE_SET_USED(group_lookup_table);
-	RTE_SET_USED(hash_val_a);
-	RTE_SET_USED(hash_val_b);
-	/* Return dummy value, only to avoid compilation breakage */
-	return 0;
-#endif
-
 }
diff --git a/lib/efd/meson.build b/lib/efd/meson.build
index 343f14e1f3..e5459f566d 100644
--- a/lib/efd/meson.build
+++ b/lib/efd/meson.build
@@ -8,5 +8,6 @@ if is_windows
 endif
 
 sources = files('rte_efd.c')
+sources_avx2 += files('efd_avx2.c')
 headers = files('rte_efd.h')
 deps += ['ring', 'hash']
diff --git a/lib/efd/rte_efd_x86.h b/lib/efd/rte_efd_x86.h
index e2f9dcca88..c67bc716e6 100644
--- a/lib/efd/rte_efd_x86.h
+++ b/lib/efd/rte_efd_x86.h
@@ -2,56 +2,6 @@
  * Copyright(c) 2016-2017 Intel Corporation
  */
 
-/* rte_efd_x86.h
- * This file holds all x86 specific EFD functions
- */
-#include <immintrin.h>
-
-#if (RTE_EFD_VALUE_NUM_BITS == 8 || RTE_EFD_VALUE_NUM_BITS == 16 || \
-	RTE_EFD_VALUE_NUM_BITS == 24 || RTE_EFD_VALUE_NUM_BITS == 32)
-#define EFD_LOAD_SI128(val) _mm_load_si128(val)
-#else
-#define EFD_LOAD_SI128(val) _mm_lddqu_si128(val)
-#endif
-
-static inline efd_value_t
-efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
+efd_value_t efd_lookup_internal_avx2(const efd_hashfunc_t *group_hash_idx,
 		const efd_lookuptbl_t *group_lookup_table,
-		const uint32_t hash_val_a, const uint32_t hash_val_b)
-{
-#ifdef __AVX2__
-	efd_value_t value = 0;
-	uint32_t i = 0;
-	__m256i vhash_val_a = _mm256_set1_epi32(hash_val_a);
-	__m256i vhash_val_b = _mm256_set1_epi32(hash_val_b);
-
-	for (; i < RTE_EFD_VALUE_NUM_BITS; i += 8) {
-		__m256i vhash_idx =
-				_mm256_cvtepu16_epi32(EFD_LOAD_SI128(
-				(__m128i const *) &group_hash_idx[i]));
-		__m256i vlookup_table = _mm256_cvtepu16_epi32(
-				EFD_LOAD_SI128((__m128i const *)
-				&group_lookup_table[i]));
-		__m256i vhash = _mm256_add_epi32(vhash_val_a,
-				_mm256_mullo_epi32(vhash_idx, vhash_val_b));
-		__m256i vbucket_idx = _mm256_srli_epi32(vhash,
-				EFD_LOOKUPTBL_SHIFT);
-		__m256i vresult = _mm256_srlv_epi32(vlookup_table,
-				vbucket_idx);
-
-		value |= (_mm256_movemask_ps(
-			(__m256) _mm256_slli_epi32(vresult, 31))
-			& ((1 << (RTE_EFD_VALUE_NUM_BITS - i)) - 1)) << i;
-	}
-
-	return value;
-#else
-	RTE_SET_USED(group_hash_idx);
-	RTE_SET_USED(group_lookup_table);
-	RTE_SET_USED(hash_val_a);
-	RTE_SET_USED(hash_val_b);
-	/* Return dummy value, only to avoid compilation breakage */
-	return 0;
-#endif
-
-}
+		const uint32_t hash_val_a, const uint32_t hash_val_b);
-- 
2.51.0

