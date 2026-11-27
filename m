Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3E606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MBuM6eGv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 492A24066C;
	Fri, 27 Nov 2026 20:42:19 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTPS id CCC6040609
 for <dev@dpdk.org>; Fri, 27 Nov 2026 20:42:15 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cde1479f76fso4504742a12.0
 for <dev@dpdk.org>; Fri, 27 Nov 2026 11:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795808534;
 x=1796413334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sXYLGFjbkTI0M9isHsUW1nAr3Si5+aX++awxFVKSqww=;
 b=MBuM6eGvvTSQtgBoen7V56lzmcmzVvdfWxHRAA7IeMhNzAIOhuYUSk4Udq5OV39mCB
 Q0GPzrfXyYMDAQ2AR+15Ze/70q4VhFtym4YXhpUocAdB0sXOmeNNov1+ebuzsMaui3Y7
 Y9P2RcwQ5vfjxk+Hx7rXl57WPQ7F3IurLTUEMTBvh0yzTepVxIW8t8Pldbn1agG3LOQf
 fH6IBCVwbRnZn1wnh1F41iaIgrx1sNH816ywQZFfHg4YalBvC7Cd//OMV+NJvYtnDoc/
 7gScOsJSWTEmFRpW3ABJnmmN3zSziHEhsBgRLRnxWnSvbUTANXdQtLD/k1qwrOs32xFb
 LZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808534; x=1796413334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sXYLGFjbkTI0M9isHsUW1nAr3Si5+aX++awxFVKSqww=;
 b=uBs3PeCVtroPafRxY0uAkcxAWSGCHUqQaaCZBNPA0yaUnLwfz5WDaLKwd5BtZ+h00q
 ME7k+N4ZeFN23z4kC2vtJzWgsXNoUqR3fEu1ppU5ZT3HgDNFG8eHl5h7tpGKGArYcLhx
 4fMST2LeNgMSW6R+ofL5ZDoH5zZYNbruC5dETsbBRmKeNrXslVDVTHTTKSiwbKTz/C5T
 uEOBJ8aJI0r5amnp1ymstTCQlxNXOkFNa//7u9iyEegTfsSSz6wG0cCfQK7xKVgIu+s4
 f4rgLXk1cJWFmU+L9YaetPhhOD92qVy1oUdKRb9vG1b+nZVam7vIoAuzghEiGkuIbyAl
 FXbA==
X-Gm-Message-State: APuU4Z/0UGLJmnDHEAWeTbEOQfTd1C+65ip47jDRFVBVwKVDbxx48/AH
 kXNfGHfuYGktLUZQOuBwRAC+434+1/MzIqM79CL0fJ6CKBPIJcgmjpscoJL0yAsiszXlzWVQa5+
 VafefwxM=
X-Gm-Gg: AZFdTZcEZ72S42QDGFFSFqdT+u5MVYR1FMT7BDjhyFvZYtEvJ45Cp904RMzxcCI5Zp6
 Han5+4pq0esSuUyost2xwNI70wekAuEeH6ix9hH2skgmSfrA/XRGczmhg3WfUEKygnZVpyCrGzU
 gupyegkv1ScGEq1lIcUnlMGnh3bEpJ62Qhw3KzkvauePefr6MDfbj9Uujh1R2a9D8UG4E/HLSab
 u+Agyn1poRncgr/R1jsSKB62qXCHYYIsQJHi5yQgIZahjTyabV4jqXSoMeLbVsH1W1nj30wyWkZ
 miFXpwMzfEauD1jB1bh6rg5YgFAxDgfEflpL6z43/E1K3khP1hMeUU0TfQP2aMLcUHbsNZKkP4O
 gsdzEavpYDcAcs2GcYgMTEtcb4BIlnWpxhOfREgGfugw/oNSs0zkC9AuWYgvYHikzjgGkZGSml6
 jo5br6PLZd/JjrgMivQaMrlNiZtNnKkOVG37sCu2MMdTEnSg38LTpYxdz5Glz8TbjfLYkevz31E
 1IRoI+PnKOqevxDgIFDw5/HLqBIwbdRBNm+q30lNr5Qp6zCXeFlBoGAdpg2adxrC5u3f7i3JW0i
 YCWiRkj645+8gUrFcmeklOx4Row//vnl63unlMlyGnWC/iyfvUS0N4otM3wBo+OLYJ/4
X-Received: by 2002:a05:6a20:748e:b0:3d3:aec2:4dcd with SMTP id
 adf61e73a8af0-4014c251613mr28882944637.25.1795808534146; 
 Fri, 27 Nov 2026 11:42:14 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872951febsm12881051b3a.14.2026.11.27.11.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:42:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 3/5] random: use all 64 bits of the seed
Date: Fri, 27 Nov 2026 11:39:35 -0800
Message-ID: <20261127194209.107396-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127194209.107396-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261127194209.107396-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 lib/eal/common/rte_random.c | 74 ++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

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

