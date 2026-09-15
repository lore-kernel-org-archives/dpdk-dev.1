Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18BAC88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0C1742E4C;
	Tue, 15 Sep 2026 21:22:58 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id D2CCC42E48
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:57 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4cacd3409so139070a12.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500176;
 x=1790104976; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BoDHqpUS85k00aExRALpqDs7bDZqLPE4O3C/FKXPiQE=;
 b=iEOduZzhdrSELSjCGgGpSPuI/Ty+HzCYEXvxSQMdoWsDxgP0qispsPOGtzMafPsJp2
 EIYaB6Jx8C8/w80LrAhpfWPbINulNzp6O5cP+RJO/fpupQnJYGwcrlQ0gao67A+XePtZ
 h7A7fLJ0rn7lylJsiy3ub6mJXqxqifxBnyj5dJujN8LHGvO+WVzPj2j4FXwRYCWFzNuu
 tMk7NJHdVJVIEdZxtd+MJWUZhI4NCQ1/m5pAN5QOFp4ndtQZYzZk+FAtyG2HoPxNUd8F
 5fljbvrbBWSYPSdcDD4D98W3YEUW0Kvs9LUn8ajxui1Kk6nOcHm0SPxQOExPnr3H8lSE
 KecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500176; x=1790104976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BoDHqpUS85k00aExRALpqDs7bDZqLPE4O3C/FKXPiQE=;
 b=ogz9CUYExt1q9PXlNB1WUajsSs0Td9IFtTy5LWOW+iDanXt30po0ClQ47sLfBOzrhE
 EifdnRetkx2y8BsF9mPPJVz3bRTUOMr3mIHeVUxTF2emdfxzjqjam1faH4ZL0ZgtJoFO
 6JLiI8R/Z8tTpmkVzoF0On+u8l2wu5FFn9ZU2HSDCT6+EwZfgOgLIcZsh/lrlPfegXQ+
 Vyb3BDo/8p9Prq/q0AxBNFKH+gnT/HzIe6HP6EJ+X4i383ja1inPJgLQIr54CMbcKx4F
 YLLXku/qFYPBp5bQRkg+N53I1SpexfqaDsHGSn5qKuvpEj48hAeMlD0POpgUWYAOJclz
 AHzg==
X-Gm-Message-State: AFuF++n3+uRhwfB/VshLGAwMdmnqO15CGnIoWJb9bou1GyylcaXzYrhE
 yk89O0P9p2HuZ2mmFIqT27SpjWGuVxinjr/rd2QrJabWC3YKN4ojQiIOKFvp0kGsU1H3G4cZLt+
 XUZJW
X-Gm-Gg: AYBFou1VgtjjFZxZ5d1w6ZmQ11Zl0tkMrMy9Nyhb2MxpLeNMSuezLoJVeB1IDBne6BU
 A9tZ+/w1Wypff6sZXSSh3Lo7suUqPX93DrnK1DZfrwKctxXz9nYBX8AGRjvMzAt87G8qjvBJ3t2
 Ofxmsy4j/apUiE4W7a4CKlhJl0gl6ldf1qb0x/km/H+D4BPGOgK62TB+hipi0tUCxNrdojz8vE5
 pveylfdNdVj5U95PzMQgh/Xr35iv0ckw4sNLtTW9QZMiRyAOj2GkeXXTZkYcUqDmq8urEr4a/ua
 BYHACM8TvpdLduaPHhYIPs9dlU6WPsXLu39p2YkQKAzvx6Ir0ZKy/tUBom+wbKnio1/bGRIWXC+
 rBbUxWozgMMso1euOxqwOLnWkSt1zKjWfqOgUVBkIgeePXGiLQRWPZz9N5zdj5gVUSBNOYxD9K+
 LxWkfJhgf5MJTU10ck8zTibUUfANsRMK7tgh6glnG3qpaA8gwiQCDiU7uJofe2g4v2szY0Jg3oS
 WtBbQCit7biQvzRsXrxw2W+Yyo/I8YLbnqLYg==
X-Received: by 2002:a17:90b:4a88:b0:39d:f024:c7ec with SMTP id
 98e67ed59e1d1-39e11041013mr4190227a91.16.1789500175935; 
 Tue, 15 Sep 2026 12:22:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 12/18] random: use all 64 bits of the seed
Date: Tue, 15 Sep 2026 12:21:10 -0700
Message-ID: <20260915192207.3926217-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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
index f25e497729..9d1238d6f3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -65,6 +65,10 @@ New Features
     values which must not be predictable, such as keys, hash seeds and
     MAC addresses, where the pseudo-random ``rte_rand()`` is not
     suitable.
+  * Improved the expansion of the seed into the generator state. All
+    64 bits of the value passed to ``rte_srand()`` now affect the state,
+    so a given seed produces a different sequence than in previous
+    releases.
 
 
 Removed Items
diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 4b777f69f4..db4e19b414 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -39,55 +39,45 @@ static RTE_LCORE_VAR_HANDLE(struct rte_rand_state, rand_state);
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
@@ -95,16 +85,24 @@ void
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

