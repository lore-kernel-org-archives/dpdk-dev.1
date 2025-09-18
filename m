Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A129CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 07:32:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E12494064F;
	Thu, 18 Sep 2025 09:32:12 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 7AA364042F
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:32:11 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 193BB140020F;
 Thu, 18 Sep 2025 03:32:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 18 Sep 2025 03:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1758180731; x=
 1758267131; bh=AC4dziR9fMXAbVHePRC2hHlydgiqEgb1rll7ksG1IvY=; b=e
 5tsegU4JJ2W8Pu6CGRG61GGaWUjIufxZPPXeulWNtU13HKOTInquHisL5MW0C2K4
 V3YFrXr/yZMe/JERgm9Dk1sMCZUJ/Hap2NpLVQya/rbrQ/O2uRs7nQpaxZvknrY5
 4/bvnG0KEYR5Ly3SpNUye1mevvyJqS6x/xuKo8SjDfG3uq2Y/fOxXGbsxowbsdyz
 skJLdUZCQCPzcR2G76OoJzEdY1Qe+XD8cCA1vba/ovemaQ34JrfLzJcN9DMCjpW7
 i35kgxReQhT+wGXsUHkzu0cw56NXguC+xccuZyHVrgoqJfWR7gOgOuR3ue5f6dfx
 mq33KjJsL4wqUNhlBBWoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1758180731; x=1758267131; bh=A
 C4dziR9fMXAbVHePRC2hHlydgiqEgb1rll7ksG1IvY=; b=JfPMIo9gLa5vR4KYw
 KWbep2AF2v0eXyjIfafJ0i3lanqT7BoA+emew9kuqcWujB7U/TM/LNxAbEWPyoiH
 sRb5mrkTi9nIXNtyZn1VUiDI4HI4aY86QNh1evVsNQ7UNgtZgZFiYT0F4ydJPpFW
 uhCxyPJa4xChBq77hN40keg+gZG+CjM+b2MUSXTG4u4WnEX49nQd4PixFjnL4UW0
 XjurA0BpOG9GF5HF7NpmxQd5yD9cvBA5fwj+eE8X1LzA72HbIzxVhc51GpNe8T0v
 VjDqtWc0se0L+9C0JjTdEGPwKOM6ZOELryVT5sxaPX+SYox/CPwq44YDH3cyBhpX
 +9reg==
X-ME-Sender: <xms:erXLaNSSS9-1EBu5-wwRFIbK4RqLChc5356xpJpDY3VZMqv930miGw>
 <xme:erXLaBoGW5oQpZztJJLnL9z3pBMCfm3Quf8Q8QA-zDyYTQRkaClybh0yl66XWxzCs
 mWA1sJGYiOVTLyxAQ>
X-ME-Received: <xmr:erXLaKq1Yw9zT4Zf3G35vsOyAxdnzr9p3U9kj9eqWbE4TJ-ESRgorQq4oLdivkQGFVXl09suLGP8yYWizhwqAujaNm-xkV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheejfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthht
 ohephihiphgvnhhguddrfigrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrmh
 gvhhdrghhosghrihgvlhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:erXLaDMjTXVJkBxX_A6s8MWtOoghG3NTV8ZRgV8zNBwmcPvymRGxqg>
 <xmx:erXLaLzcm8V-KoZQYXfRQRSbA1KrGjTCPiSz9JDqwpfahbgFfPED8Q>
 <xmx:erXLaMsZP14tS2xyZxDNcRs_fgINe6YgIdvdVKG3AAJlieUT2QIRRA>
 <xmx:erXLaE6rxPGTMFWWW_5xo7SnwUw_pN5qm9soK3a8JgjJBBD2w2gj9g>
 <xmx:e7XLaL4ruQT9X1MXw9vXHKxiVLbeCblSiPYiTAGXYftQndnWOdskBs1X>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 03:32:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH 2/3] member: remove AVX2 build-time checks
Date: Thu, 18 Sep 2025 09:28:04 +0200
Message-ID: <20250918073135.1273767-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918073135.1273767-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
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
no need to check for AVX2 support when x86 arch is already checked.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/member/rte_member_ht.c  | 14 +++++++-------
 lib/member/rte_member_x86.h |  3 ---
 2 files changed, 7 insertions(+), 10 deletions(-)

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
index 4de453485b..29cc2f0132 100644
--- a/lib/member/rte_member_x86.h
+++ b/lib/member/rte_member_x86.h
@@ -11,8 +11,6 @@
 extern "C" {
 #endif
 
-#if defined(__AVX2__)
-
 static inline int
 update_entry_search_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 		struct member_ht_bucket *buckets,
@@ -69,7 +67,6 @@ search_bucket_multi_avx(uint32_t bucket_id, member_sig_t tmp_sig,
 		hitmask &= ~(3U << ((hit_idx) << 1));
 	}
 }
-#endif
 
 #ifdef __cplusplus
 }
-- 
2.51.0

