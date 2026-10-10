Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3023ACA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:29:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D044C402E0;
	Sat, 10 Oct 2026 04:28:58 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 45C4F402D4
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:28:56 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3ab33730821so137975a91.3
 for <dev@dpdk.org>; Fri, 09 Oct 2026 19:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791599335;
 x=1792204135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R/lhUyQimn6TRU3kg7bKRONx72wxf75AUQ30pxOZujU=;
 b=FZor/Fch+YEqc4e/pJCyf7XXsXRL0Zt71oasSLWxT6Be/s4JDCae5fgG1jbXBIA+n7
 ar+SSLyrx+FfHNSPAVDt5zYKWMS+ggI1McWPeit72SK5p0WqF9tAuHB8AdI1/AWbWQLT
 PMfiVGDvGkqlzZIbCjSnOQM0p/oIuAUg3CJAZMxKyCL9QEGWk+QNYvBykGdLJsl2f9A5
 p96TYy5186a99BE6gRsBdgH+RfklTosIwTqakL/nKx3FR8wbztrMyGVsGghZkuZJ8rv9
 D3mG366pND85MiM7v+9npoA07ORTsbq0d2MtjLyu0Ip1JfRJJm6+WbN9I6x4GH/qdU8p
 eW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791599335; x=1792204135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R/lhUyQimn6TRU3kg7bKRONx72wxf75AUQ30pxOZujU=;
 b=UxOE/ycE03ldvaRsyjyrGo4ScaFGVxG0A703limLR6/1SSnbAmU7yaQbFcyIp6ZZdL
 Xe6bcm0BDcisvknIb/KGYrith5z+GIH94VZ3DF1uEQv9W5VziyXz1Tj3oZixbBlHO0tS
 7I32LZnYf6jcMPASvBEWXjqfydfaZPBe2LGuYhTyt2IvcjLUaiAGBiPkptnjH1ceZmnn
 tAwbz1rQZ2BpVIZGgb7lCKO2aGWtU0SlTeL3P0vQZqtvxqVwV/qRzSMNlFaLZAN1McZ3
 pMeMk9VUxh60nPu1+y3v46kNcPBsdLjM/93Aq2NXtcZ1H6tNck1gKSfGyekJ2wxZYeix
 gWhA==
X-Gm-Message-State: AFq9FYLR8pZ8fivliUjb7ji4QH1gFu3KSsT8hXzXG6KN1zyexsRWjwjc
 T+q41I2CmKdxRXz9pzjPRuKAXtXuZ4SrRWFBq1+tHNmYJKZz3pi4tLQaFA6MhpFL4DNjY17zXj2
 lBgsYxZ4=
X-Gm-Gg: AYBFou0Br5kjVPBTzofNi7xeGrLFBvEpSKXwuNwJ2YxA9UWIdYh9iMoSjzqVTQcv5g/
 rg7sAC4kuD092CgE80alrDqolGXdgW8jEt+QVnnhHANoHR1Ef9ggzePvXwgmFb0XOBCa4cqiC3T
 xj+08kbN1TG11kIta96k9/wwGOH5Y9PH7pbnzzbqyhGzPpw4vUgWHZdQxBY72R28F9cCesDuqkv
 Cn3H6XI9kBdy2kf1rpqHhmDvMlnRB0AVQak/W8gYoikkDfOQFQE/pW2JNJ/oAvu+QQ3vJ9l4PX1
 1DQ7oJPxDNrdP3ugovGyPFkfUCgq26FL8r9eKSelJwjL7XGA4SCJS2YRS3iqbtiVND7LenU4KWN
 bLgmv1CbFNYieUh1NS2ntVsvcV7ZShY+8HhCNKLYNbAmSsDqJ6duLJsBXU6nPARmTIFkTImY/Yb
 yaOgns7sTRn9W4//DI9S67fdf74vsrhMTyglybRazrwSLd6tJSxu01YbOCw371m00cPLZNtzHwJ
 zbRYdj0W26l1Al06L8CDnIooyfN1BD11x20SUdnZuHs1i+X
X-Received: by 2002:a17:90a:e7cb:b0:3aa:ee81:a62d with SMTP id
 98e67ed59e1d1-3ab3a7480f9mr3445144a91.35.1791599335312; 
 Fri, 09 Oct 2026 19:28:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3690474esm6202882a91.0.2026.10.09.19.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 19:28:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 3/5] random: use all 64 bits of the seed
Date: Fri,  9 Oct 2026 19:27:05 -0700
Message-ID: <20261010022851.1872825-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010022851.1872825-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261010022851.1872825-1-stephen@networkplumber.org>
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

The generator state is five 64 bit words, expanded from the seed by a
32 bit linear congruential generator. The two halves of the seed were
folded together first, so only 32 bits of it had any effect, and the
low order bits of such a generator are weak, leaving the five words
with correlated low bits.

Expand the seed with SplitMix64 instead, so every bit of the seed
affects every word of the state. It is described in "Fast Splittable
Pseudorandom Number Generators" by Steele, Lea and Flood,
https://doi.org/10.1145/2714064.2660195 and is what the authors of
the xoshiro and xoroshiro generators recommend for seeding.

The per-lcore seeds were formed by adding the lcore id to the seed,
leaving neighbouring lcores with nearly identical state. Pass that
sum through SplitMix64 as well.

Fixes: 3f002f069612 ("eal: replace libc-based random generation with LFSR")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++
 lib/eal/common/rte_random.c            | 74 +++++++++++++-------------
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9bef8b4774..2d12eb7949 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -161,6 +161,10 @@ New Features
 * **Updated random number generation.**
 
   * The initial seed is now always taken from ``getentropy()``.
+  * Improved the expansion of the seed into the generator state. All
+    64 bits of the value passed to ``rte_srand()`` now affect the state,
+    so a given seed produces a different sequence than in previous
+    releases.
 
 
 Removed Items
diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index b036c50349..3c5b36aa2c 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -35,55 +35,45 @@ static RTE_LCORE_VAR_HANDLE(struct rte_rand_state, rand_state);
 /* instance to be shared by all unregistered non-EAL threads */
 static struct rte_rand_state unregistered_rand_state;
 
-static uint32_t
-__rte_rand_lcg32(uint32_t *seed)
-{
-	*seed = 1103515245U * *seed + 12345U;
-
-	return *seed;
-}
-
+/* SplitMix64, used to expand the seed into the generator state.
+ * It has a full 64 bit period and good avalanche, so all the bits
+ * of the seed affect every word of the resulting state.
+ *
+ * See "Fast Splittable Pseudorandom Number Generators" by Steele,
+ * Lea and Flood, https://doi.org/10.1145/2714064.2660195
+ */
 static uint64_t
-__rte_rand_lcg64(uint32_t *seed)
+__rte_rand_splitmix64(uint64_t *state)
 {
-	uint64_t low;
-	uint64_t high;
-
-	/* A 64-bit LCG would have been much cleaner, but good
-	 * multiplier/increments for such seem hard to come by.
-	 */
+	uint64_t z;
 
-	low = __rte_rand_lcg32(seed);
-	high = __rte_rand_lcg32(seed);
+	z = (*state += 0x9E3779B97F4A7C15ULL);
+	z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9ULL;
+	z = (z ^ (z >> 27)) * 0x94D049BB133111EBULL;
 
-	return low | (high << 32);
+	return z ^ (z >> 31);
 }
 
 static uint64_t
-__rte_rand_lfsr258_gen_seed(uint32_t *seed, uint64_t min_value)
+__rte_rand_lfsr258_gen_seed(uint64_t *state, uint64_t min_value)
 {
-	uint64_t res;
-
-	res = __rte_rand_lcg64(seed);
-
-	if (res < min_value)
-		res += min_value;
-
-	return res;
+	/* LFSR258 degenerates unless each word exceeds its threshold.
+	 * All thresholds are powers of two, so a bitwise or is enough
+	 * and keeps the remaining bits untouched.
+	 */
+	return __rte_rand_splitmix64(state) | min_value;
 }
 
 static void
 __rte_srand_lfsr258(uint64_t seed, struct rte_rand_state *state)
 {
-	uint32_t lcg_seed;
-
-	lcg_seed = (uint32_t)(seed ^ (seed >> 32));
+	uint64_t mix_state = seed;
 
-	state->z1 = __rte_rand_lfsr258_gen_seed(&lcg_seed, 2UL);
-	state->z2 = __rte_rand_lfsr258_gen_seed(&lcg_seed, 512UL);
-	state->z3 = __rte_rand_lfsr258_gen_seed(&lcg_seed, 4096UL);
-	state->z4 = __rte_rand_lfsr258_gen_seed(&lcg_seed, 131072UL);
-	state->z5 = __rte_rand_lfsr258_gen_seed(&lcg_seed, 8388608UL);
+	state->z1 = __rte_rand_lfsr258_gen_seed(&mix_state, 2UL);
+	state->z2 = __rte_rand_lfsr258_gen_seed(&mix_state, 512UL);
+	state->z3 = __rte_rand_lfsr258_gen_seed(&mix_state, 4096UL);
+	state->z4 = __rte_rand_lfsr258_gen_seed(&mix_state, 131072UL);
+	state->z5 = __rte_rand_lfsr258_gen_seed(&mix_state, 8388608UL);
 }
 
 RTE_EXPORT_SYMBOL(rte_srand)
@@ -91,16 +81,24 @@ void
 rte_srand(uint64_t seed)
 {
 	unsigned int lcore_id;
+	uint64_t mix_state;
 
-	/* add lcore_id to seed to avoid having the same sequence */
+	/* Mix in the lcore id so that each lcore gets an unrelated
+	 * sequence. Adding it to the seed would leave neighbouring
+	 * lcores with nearly identical generator state.
+	 */
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		struct rte_rand_state *lcore_state =
 			RTE_LCORE_VAR_LCORE(lcore_id, rand_state);
 
-		__rte_srand_lfsr258(seed + lcore_id, lcore_state);
+		mix_state = seed + lcore_id;
+		__rte_srand_lfsr258(__rte_rand_splitmix64(&mix_state),
+				    lcore_state);
 	}
 
-	__rte_srand_lfsr258(seed + lcore_id, &unregistered_rand_state);
+	mix_state = seed + lcore_id;
+	__rte_srand_lfsr258(__rte_rand_splitmix64(&mix_state),
+			    &unregistered_rand_state);
 }
 
 static __rte_always_inline uint64_t
-- 
2.53.0

