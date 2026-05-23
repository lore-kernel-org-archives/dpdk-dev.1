Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C70CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:56:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64660402EA;
	Sat, 23 May 2026 21:56:13 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id B06E440265
 for <dev@dpdk.org>; Sat, 23 May 2026 21:56:09 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so3663457eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566169;
 x=1780170969; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5661LA/IAAm9r1pPtGy+XyGXck7b7GlHwqmos+m5jls=;
 b=ddiNHLRG1uZI74nnasT3wiFpaaTP1blU0ugUVQpHplBZpTTk1zqFidui1p0V0WElyb
 Uk/kINm4QPdEBi3cES540P+zYoRsTTm8+Nv38+Y7W32NxjePa689sWjxy4mUCqvINmnB
 IDeJ3C6M/J8pCiQSce0ofFxvxrvZcwjs3vPA1KauLe0TxOYa+tt+uyBoqsCpfbHOd6l8
 neE3DLyVQGJb+0FSdTcdVJGaIwMi2LgSONjA8nPUnUIDodogEgnVhxprtFJO4HVWOzzy
 Bo9Pk8/YXE1qCZr2nIJNzBjAcVhySR7IXgYYx/ynJOY4D6TI945B69/dDTMUYr79aNkg
 z/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566169; x=1780170969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5661LA/IAAm9r1pPtGy+XyGXck7b7GlHwqmos+m5jls=;
 b=HMWOXfxWH/NgoyO0ANCSSHyN+95G7WuyEBtFOmBEmzZC3Y35BsS/159io8WMPF7+p6
 Pf7ZcsDRKo6TAw1Iz9Tjat619dNPauy+BsM/T01xEdWqETcxB6xIcefO9592OUKS8NWq
 QXZ4f7AcSymrcnfAqrqamiyDjm3gG7M7WC42/Hby5yWYcbGmIJmcj5/HGEZc2Pj/2+lp
 WhxOIk/InF9KM1m9I4yJlXSsHDmWOgZYJMdrjfLk/KucHRpM9b9VEZJyoch2AmzGxALz
 Xv6c8kWcB9IP9hcjIFwr7m+/o1p3z5ahNeYWKriQX1X1zmNtJ/Q2mUZ9faXB89zX11XP
 yrlA==
X-Gm-Message-State: AOJu0YzklNqWtLlMETrVSYBpLS0ftD+Yh93n0vBjrUM1LauNpE5d/vv2
 +E5PugGucYbfDkITM2B21j4RpLjNblQnZOc3/ipHyZUJhNg7gVQmFU/nQsAwMtyKfH+LEtlNPpG
 k4pLa
X-Gm-Gg: Acq92OHFzICRFEblBoRxBWrKKoS6GfmwMFABQVLWHqxsAjsWI4T+7Ayk+32Rco08tHS
 6C8ZFkkoqNDBC+WbrHqiLsd+i3E+0OuYbpxtsqUUEVRISHUJV5BKU1gSYVjkB79jLx7RYfljjWz
 r/74wWei3zfhNOiQDk8qIZtMJJyrQV/zvFuTQ11YrZh+lGQTuLHQ+Gt0q++eyMWrkVsNGsP2mHZ
 3HwiS87zRiy88a/suAD7LaVjI+sBg2tmfV2wgfN93I1L0uk9l3qRh87LOGHAuffr2tt9XC5P0VG
 ud+Ijk8Jt6hPnzBJyaPh/O44tM0SeieyvO8zwLfbauD7kF4YVfzyi1SJoa6zYkh0EG/tL/Lo+46
 4Q+JGufA9yllzYp0aJz3QI6n78/e6C/mcVou/CTfGF2w6Czs6l9uNaLPvmW+Gg6HwK4WFTQ7vrg
 4bBgBCozpjfQ18+mUVV3uWXRqfwWGs4UfUf22vh6eO3E6OrhT38/eRAsxQbJWVWtdJahxzgZDq
X-Received: by 2002:a05:7300:bb04:b0:304:acc:f086 with SMTP id
 5a478bee46e88-304491ebc64mr4567641eec.33.1779566168407; 
 Sat, 23 May 2026 12:56:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm5257271eec.13.2026.05.23.12.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:56:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 01/27] eal: use intrinsics for rte_atomic on all platforms
Date: Sat, 23 May 2026 12:16:03 -0700
Message-ID: <20260523195604.441947-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195604.441947-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
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

Next step is to deprecate the rte_atomicNN_*() family. Rather than
maintaining both the inline asm and intrinsic fallbacks, drop the
asm paths and use intrinsics everywhere.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/arm/include/rte_atomic_32.h    |   4 -
 lib/eal/arm/include/rte_atomic_64.h    |   4 -
 lib/eal/include/generic/rte_atomic.h   |  76 +---------
 lib/eal/loongarch/include/rte_atomic.h |   4 -
 lib/eal/ppc/include/rte_atomic.h       | 173 -----------------------
 lib/eal/riscv/include/rte_atomic.h     |   4 -
 lib/eal/x86/include/rte_atomic.h       | 172 ----------------------
 lib/eal/x86/include/rte_atomic_32.h    | 188 -------------------------
 lib/eal/x86/include/rte_atomic_64.h    | 157 ---------------------
 9 files changed, 6 insertions(+), 776 deletions(-)

diff --git a/lib/eal/arm/include/rte_atomic_32.h b/lib/eal/arm/include/rte_atomic_32.h
index 0b9a0dfa30..696a539fef 100644
--- a/lib/eal/arm/include/rte_atomic_32.h
+++ b/lib/eal/arm/include/rte_atomic_32.h
@@ -5,10 +5,6 @@
 #ifndef _RTE_ATOMIC_ARM32_H_
 #define _RTE_ATOMIC_ARM32_H_
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
-
 #include "generic/rte_atomic.h"
 
 #ifdef __cplusplus
diff --git a/lib/eal/arm/include/rte_atomic_64.h b/lib/eal/arm/include/rte_atomic_64.h
index 181bb60929..9f790238df 100644
--- a/lib/eal/arm/include/rte_atomic_64.h
+++ b/lib/eal/arm/include/rte_atomic_64.h
@@ -6,10 +6,6 @@
 #ifndef _RTE_ATOMIC_ARM64_H_
 #define _RTE_ATOMIC_ARM64_H_
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
-
 #include "generic/rte_atomic.h"
 #include <rte_branch_prediction.h>
 #include <rte_debug.h>
diff --git a/lib/eal/include/generic/rte_atomic.h b/lib/eal/include/generic/rte_atomic.h
index 0a4f3f8528..292e52fade 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -187,13 +187,11 @@ static inline void rte_atomic_thread_fence(rte_memory_order memorder);
 static inline int
 rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int
 rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
 }
-#endif
 
 /**
  * Atomic exchange.
@@ -211,15 +209,11 @@ rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
  *   The original value at that location
  */
 static inline uint16_t
-rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint16_t
 rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
 {
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
+	return rte_atomic_exchange_explicit((volatile __rte_atomic uint16_t *)dst,
+		val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -312,13 +306,11 @@ rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
 static inline void
 rte_atomic16_inc(rte_atomic16_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic16_inc(rte_atomic16_t *v)
 {
 	rte_atomic16_add(v, 1);
 }
-#endif
 
 /**
  * Atomically decrement a counter by one.
@@ -329,13 +321,11 @@ rte_atomic16_inc(rte_atomic16_t *v)
 static inline void
 rte_atomic16_dec(rte_atomic16_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic16_dec(rte_atomic16_t *v)
 {
 	rte_atomic16_sub(v, 1);
 }
-#endif
 
 /**
  * Atomically add a 16-bit value to a counter and return the result.
@@ -391,13 +381,11 @@ rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
  */
 static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) + 1 == 0;
 }
-#endif
 
 /**
  * Atomically decrement a 16-bit counter by one and test.
@@ -412,13 +400,11 @@ static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
  */
 static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) - 1 == 0;
 }
-#endif
 
 /**
  * Atomically test and set a 16-bit atomic counter.
@@ -433,12 +419,10 @@ static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
  */
 static inline int rte_atomic16_test_and_set(rte_atomic16_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
 {
 	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
 }
-#endif
 
 /**
  * Atomically set a 16-bit counter to 0.
@@ -472,13 +456,11 @@ static inline void rte_atomic16_clear(rte_atomic16_t *v)
 static inline int
 rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int
 rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
 }
-#endif
 
 /**
  * Atomic exchange.
@@ -496,15 +478,11 @@ rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
  *   The original value at that location
  */
 static inline uint32_t
-rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint32_t
 rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
 {
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
+	return rte_atomic_exchange_explicit((volatile __rte_atomic uint32_t *)dst,
+					    val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -597,13 +575,11 @@ rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
 static inline void
 rte_atomic32_inc(rte_atomic32_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic32_inc(rte_atomic32_t *v)
 {
 	rte_atomic32_add(v, 1);
 }
-#endif
 
 /**
  * Atomically decrement a counter by one.
@@ -614,13 +590,11 @@ rte_atomic32_inc(rte_atomic32_t *v)
 static inline void
 rte_atomic32_dec(rte_atomic32_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic32_dec(rte_atomic32_t *v)
 {
 	rte_atomic32_sub(v,1);
 }
-#endif
 
 /**
  * Atomically add a 32-bit value to a counter and return the result.
@@ -676,13 +650,11 @@ rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
  */
 static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) + 1 == 0;
 }
-#endif
 
 /**
  * Atomically decrement a 32-bit counter by one and test.
@@ -697,13 +669,11 @@ static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
  */
 static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) - 1 == 0;
 }
-#endif
 
 /**
  * Atomically test and set a 32-bit atomic counter.
@@ -718,12 +688,10 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
  */
 static inline int rte_atomic32_test_and_set(rte_atomic32_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
 {
 	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
 }
-#endif
 
 /**
  * Atomically set a 32-bit counter to 0.
@@ -756,13 +724,11 @@ static inline void rte_atomic32_clear(rte_atomic32_t *v)
 static inline int
 rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int
 rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
 }
-#endif
 
 /**
  * Atomic exchange.
@@ -780,15 +746,11 @@ rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
  *   The original value at that location
  */
 static inline uint64_t
-rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint64_t
 rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
 {
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
+	return rte_atomic_exchange_explicit((volatile __rte_atomic uint64_t *)dst,
+					    val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -811,7 +773,6 @@ typedef struct {
 static inline void
 rte_atomic64_init(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic64_init(rte_atomic64_t *v)
 {
@@ -828,7 +789,6 @@ rte_atomic64_init(rte_atomic64_t *v)
 	}
 #endif
 }
-#endif
 
 /**
  * Atomically read a 64-bit counter.
@@ -841,7 +801,6 @@ rte_atomic64_init(rte_atomic64_t *v)
 static inline int64_t
 rte_atomic64_read(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int64_t
 rte_atomic64_read(rte_atomic64_t *v)
 {
@@ -860,7 +819,6 @@ rte_atomic64_read(rte_atomic64_t *v)
 	return tmp;
 #endif
 }
-#endif
 
 /**
  * Atomically set a 64-bit counter.
@@ -873,7 +831,6 @@ rte_atomic64_read(rte_atomic64_t *v)
 static inline void
 rte_atomic64_set(rte_atomic64_t *v, int64_t new_value);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 {
@@ -890,7 +847,6 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 	}
 #endif
 }
-#endif
 
 /**
  * Atomically add a 64-bit value to a counter.
@@ -903,14 +859,12 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 static inline void
 rte_atomic64_add(rte_atomic64_t *v, int64_t inc);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
 		rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * Atomically subtract a 64-bit value from a counter.
@@ -923,14 +877,12 @@ rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
 static inline void
 rte_atomic64_sub(rte_atomic64_t *v, int64_t dec);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
 		rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * Atomically increment a 64-bit counter by one and test.
@@ -941,13 +893,11 @@ rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
 static inline void
 rte_atomic64_inc(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic64_inc(rte_atomic64_t *v)
 {
 	rte_atomic64_add(v, 1);
 }
-#endif
 
 /**
  * Atomically decrement a 64-bit counter by one and test.
@@ -958,13 +908,11 @@ rte_atomic64_inc(rte_atomic64_t *v)
 static inline void
 rte_atomic64_dec(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic64_dec(rte_atomic64_t *v)
 {
 	rte_atomic64_sub(v, 1);
 }
-#endif
 
 /**
  * Add a 64-bit value to an atomic counter and return the result.
@@ -982,14 +930,12 @@ rte_atomic64_dec(rte_atomic64_t *v)
 static inline int64_t
 rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int64_t
 rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
 		rte_memory_order_seq_cst) + inc;
 }
-#endif
 
 /**
  * Subtract a 64-bit value from an atomic counter and return the result.
@@ -1007,14 +953,12 @@ rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
 static inline int64_t
 rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int64_t
 rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
 		rte_memory_order_seq_cst) - dec;
 }
-#endif
 
 /**
  * Atomically increment a 64-bit counter by one and test.
@@ -1029,12 +973,10 @@ rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
  */
 static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_add_return(v, 1) == 0;
 }
-#endif
 
 /**
  * Atomically decrement a 64-bit counter by one and test.
@@ -1049,12 +991,10 @@ static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
  */
 static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_sub_return(v, 1) == 0;
 }
-#endif
 
 /**
  * Atomically test and set a 64-bit atomic counter.
@@ -1069,12 +1009,10 @@ static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
  */
 static inline int rte_atomic64_test_and_set(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
 {
 	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
 }
-#endif
 
 /**
  * Atomically set a 64-bit counter to 0.
@@ -1084,12 +1022,10 @@ static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
  */
 static inline void rte_atomic64_clear(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void rte_atomic64_clear(rte_atomic64_t *v)
 {
 	rte_atomic64_set(v, 0);
 }
-#endif
 
 #endif
 
diff --git a/lib/eal/loongarch/include/rte_atomic.h b/lib/eal/loongarch/include/rte_atomic.h
index c8066a4612..785a452c9e 100644
--- a/lib/eal/loongarch/include/rte_atomic.h
+++ b/lib/eal/loongarch/include/rte_atomic.h
@@ -5,10 +5,6 @@
 #ifndef RTE_ATOMIC_LOONGARCH_H
 #define RTE_ATOMIC_LOONGARCH_H
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
-
 #include <rte_common.h>
 #include "generic/rte_atomic.h"
 
diff --git a/lib/eal/ppc/include/rte_atomic.h b/lib/eal/ppc/include/rte_atomic.h
index 10acc238f9..64f4c3d670 100644
--- a/lib/eal/ppc/include/rte_atomic.h
+++ b/lib/eal/ppc/include/rte_atomic.h
@@ -43,179 +43,6 @@ rte_atomic_thread_fence(rte_memory_order memorder)
 }
 
 /*------------------------- 16 bit atomic operations -------------------------*/
-#ifndef RTE_FORCE_INTRINSICS
-static inline int
-rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
-{
-	return rte_atomic_compare_exchange_strong_explicit(dst, &exp, src, rte_memory_order_acquire,
-		rte_memory_order_acquire) ? 1 : 0;
-}
-
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
-{
-	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
-}
-
-static inline void
-rte_atomic16_inc(rte_atomic16_t *v)
-{
-	rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire);
-}
-
-static inline void
-rte_atomic16_dec(rte_atomic16_t *v)
-{
-	rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire);
-}
-
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
-{
-	return rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire) + 1 == 0;
-}
-
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
-{
-	return rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire) - 1 == 0;
-}
-
-static inline uint16_t
-rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
-{
-	return __atomic_exchange_2(dst, val, rte_memory_order_seq_cst);
-}
-
-/*------------------------- 32 bit atomic operations -------------------------*/
-
-static inline int
-rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
-{
-	return rte_atomic_compare_exchange_strong_explicit(dst, &exp, src, rte_memory_order_acquire,
-		rte_memory_order_acquire) ? 1 : 0;
-}
-
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
-{
-	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
-}
-
-static inline void
-rte_atomic32_inc(rte_atomic32_t *v)
-{
-	rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire);
-}
-
-static inline void
-rte_atomic32_dec(rte_atomic32_t *v)
-{
-	rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire);
-}
-
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
-{
-	return rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire) + 1 == 0;
-}
-
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
-{
-	return rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire) - 1 == 0;
-}
-
-static inline uint32_t
-rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
-{
-	return __atomic_exchange_4(dst, val, rte_memory_order_seq_cst);
-}
-
-/*------------------------- 64 bit atomic operations -------------------------*/
-
-static inline int
-rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
-{
-	return rte_atomic_compare_exchange_strong_explicit(dst, &exp, src, rte_memory_order_acquire,
-		rte_memory_order_acquire) ? 1 : 0;
-}
-
-static inline void
-rte_atomic64_init(rte_atomic64_t *v)
-{
-	v->cnt = 0;
-}
-
-static inline int64_t
-rte_atomic64_read(rte_atomic64_t *v)
-{
-	return v->cnt;
-}
-
-static inline void
-rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
-{
-	v->cnt = new_value;
-}
-
-static inline void
-rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
-{
-	rte_atomic_fetch_add_explicit(&v->cnt, inc, rte_memory_order_acquire);
-}
-
-static inline void
-rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
-{
-	rte_atomic_fetch_sub_explicit(&v->cnt, dec, rte_memory_order_acquire);
-}
-
-static inline void
-rte_atomic64_inc(rte_atomic64_t *v)
-{
-	rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire);
-}
-
-static inline void
-rte_atomic64_dec(rte_atomic64_t *v)
-{
-	rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire);
-}
-
-static inline int64_t
-rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
-{
-	return rte_atomic_fetch_add_explicit(&v->cnt, inc, rte_memory_order_acquire) + inc;
-}
-
-static inline int64_t
-rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
-{
-	return rte_atomic_fetch_sub_explicit(&v->cnt, dec, rte_memory_order_acquire) - dec;
-}
-
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
-{
-	return rte_atomic_fetch_add_explicit(&v->cnt, 1, rte_memory_order_acquire) + 1 == 0;
-}
-
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
-{
-	return rte_atomic_fetch_sub_explicit(&v->cnt, 1, rte_memory_order_acquire) - 1 == 0;
-}
-
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
-{
-	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
-}
-
-static inline void rte_atomic64_clear(rte_atomic64_t *v)
-{
-	v->cnt = 0;
-}
-
-static inline uint64_t
-rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
-{
-	return __atomic_exchange_8(dst, val, rte_memory_order_seq_cst);
-}
-
-#endif
 
 #ifdef __cplusplus
 }
diff --git a/lib/eal/riscv/include/rte_atomic.h b/lib/eal/riscv/include/rte_atomic.h
index 66346ad474..061b175f33 100644
--- a/lib/eal/riscv/include/rte_atomic.h
+++ b/lib/eal/riscv/include/rte_atomic.h
@@ -8,10 +8,6 @@
 #ifndef RTE_ATOMIC_RISCV_H
 #define RTE_ATOMIC_RISCV_H
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
-
 #include <stdint.h>
 #include <rte_common.h>
 #include <rte_config.h>
diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_atomic.h
index e071e4234e..4f05302c9f 100644
--- a/lib/eal/x86/include/rte_atomic.h
+++ b/lib/eal/x86/include/rte_atomic.h
@@ -111,178 +111,6 @@ rte_atomic_thread_fence(rte_memory_order memorder)
 extern "C" {
 #endif
 
-#ifndef RTE_FORCE_INTRINSICS
-static inline int
-rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
-{
-	uint8_t res;
-
-	asm volatile(
-			MPLOCKED
-			"cmpxchgw %[src], %[dst];"
-			"sete %[res];"
-			: [res] "=a" (res),     /* output */
-			  [dst] "=m" (*dst)
-			: [src] "r" (src),      /* input */
-			  "a" (exp),
-			  "m" (*dst)
-			: "memory");            /* no-clobber list */
-	return res;
-}
-
-static inline uint16_t
-rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
-{
-	asm volatile(
-			MPLOCKED
-			"xchgw %0, %1;"
-			: "=r" (val), "=m" (*dst)
-			: "0" (val),  "m" (*dst)
-			: "memory");         /* no-clobber list */
-	return val;
-}
-
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
-{
-	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
-}
-
-static inline void
-rte_atomic16_inc(rte_atomic16_t *v)
-{
-	asm volatile(
-			MPLOCKED
-			"incw %[cnt]"
-			: [cnt] "=m" (v->cnt)   /* output */
-			: "m" (v->cnt)          /* input */
-			);
-}
-
-static inline void
-rte_atomic16_dec(rte_atomic16_t *v)
-{
-	asm volatile(
-			MPLOCKED
-			"decw %[cnt]"
-			: [cnt] "=m" (v->cnt)   /* output */
-			: "m" (v->cnt)          /* input */
-			);
-}
-
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
-{
-	uint8_t ret;
-
-	asm volatile(
-			MPLOCKED
-			"incw %[cnt] ; "
-			"sete %[ret]"
-			: [cnt] "+m" (v->cnt),  /* output */
-			  [ret] "=qm" (ret)
-			);
-	return ret != 0;
-}
-
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
-{
-	uint8_t ret;
-
-	asm volatile(MPLOCKED
-			"decw %[cnt] ; "
-			"sete %[ret]"
-			: [cnt] "+m" (v->cnt),  /* output */
-			  [ret] "=qm" (ret)
-			);
-	return ret != 0;
-}
-
-/*------------------------- 32 bit atomic operations -------------------------*/
-
-static inline int
-rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
-{
-	uint8_t res;
-
-	asm volatile(
-			MPLOCKED
-			"cmpxchgl %[src], %[dst];"
-			"sete %[res];"
-			: [res] "=a" (res),     /* output */
-			  [dst] "=m" (*dst)
-			: [src] "r" (src),      /* input */
-			  "a" (exp),
-			  "m" (*dst)
-			: "memory");            /* no-clobber list */
-	return res;
-}
-
-static inline uint32_t
-rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
-{
-	asm volatile(
-			MPLOCKED
-			"xchgl %0, %1;"
-			: "=r" (val), "=m" (*dst)
-			: "0" (val),  "m" (*dst)
-			: "memory");         /* no-clobber list */
-	return val;
-}
-
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
-{
-	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
-}
-
-static inline void
-rte_atomic32_inc(rte_atomic32_t *v)
-{
-	asm volatile(
-			MPLOCKED
-			"incl %[cnt]"
-			: [cnt] "=m" (v->cnt)   /* output */
-			: "m" (v->cnt)          /* input */
-			);
-}
-
-static inline void
-rte_atomic32_dec(rte_atomic32_t *v)
-{
-	asm volatile(
-			MPLOCKED
-			"decl %[cnt]"
-			: [cnt] "=m" (v->cnt)   /* output */
-			: "m" (v->cnt)          /* input */
-			);
-}
-
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
-{
-	uint8_t ret;
-
-	asm volatile(
-			MPLOCKED
-			"incl %[cnt] ; "
-			"sete %[ret]"
-			: [cnt] "+m" (v->cnt),  /* output */
-			  [ret] "=qm" (ret)
-			);
-	return ret != 0;
-}
-
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
-{
-	uint8_t ret;
-
-	asm volatile(MPLOCKED
-			"decl %[cnt] ; "
-			"sete %[ret]"
-			: [cnt] "+m" (v->cnt),  /* output */
-			  [ret] "=qm" (ret)
-			);
-	return ret != 0;
-}
-
-#endif /* !RTE_FORCE_INTRINSICS */
 
 #ifdef __cplusplus
 }
diff --git a/lib/eal/x86/include/rte_atomic_32.h b/lib/eal/x86/include/rte_atomic_32.h
index 0f25863aa5..37d139f30d 100644
--- a/lib/eal/x86/include/rte_atomic_32.h
+++ b/lib/eal/x86/include/rte_atomic_32.h
@@ -20,193 +20,5 @@
 
 /*------------------------- 64 bit atomic operations -------------------------*/
 
-#ifndef RTE_FORCE_INTRINSICS
-static inline int
-rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
-{
-	uint8_t res;
-	union {
-		struct {
-			uint32_t l32;
-			uint32_t h32;
-		};
-		uint64_t u64;
-	} _exp, _src;
-
-	_exp.u64 = exp;
-	_src.u64 = src;
-
-#ifndef __PIC__
-    asm volatile (
-            MPLOCKED
-            "cmpxchg8b (%[dst]);"
-            "setz %[res];"
-            : [res] "=a" (res)      /* result in eax */
-            : [dst] "S" (dst),      /* esi */
-             "b" (_src.l32),       /* ebx */
-             "c" (_src.h32),       /* ecx */
-             "a" (_exp.l32),       /* eax */
-             "d" (_exp.h32)        /* edx */
-			: "memory" );           /* no-clobber list */
-#else
-	asm volatile (
-            "xchgl %%ebx, %%edi;\n"
-			MPLOCKED
-			"cmpxchg8b (%[dst]);"
-			"setz %[res];"
-            "xchgl %%ebx, %%edi;\n"
-			: [res] "=a" (res)      /* result in eax */
-			: [dst] "S" (dst),      /* esi */
-			  "D" (_src.l32),       /* ebx */
-			  "c" (_src.h32),       /* ecx */
-			  "a" (_exp.l32),       /* eax */
-			  "d" (_exp.h32)        /* edx */
-			: "memory" );           /* no-clobber list */
-#endif
-
-	return res;
-}
-
-static inline uint64_t
-rte_atomic64_exchange(volatile uint64_t *dest, uint64_t val)
-{
-	uint64_t old;
-
-	do {
-		old = *dest;
-	} while (rte_atomic64_cmpset(dest, old, val) == 0);
-
-	return old;
-}
-
-static inline void
-rte_atomic64_init(rte_atomic64_t *v)
-{
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, 0);
-	}
-}
-
-static inline int64_t
-rte_atomic64_read(rte_atomic64_t *v)
-{
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		/* replace the value by itself */
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, tmp);
-	}
-	return tmp;
-}
-
-static inline void
-rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
-{
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, new_value);
-	}
-}
-
-static inline void
-rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
-{
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, tmp + inc);
-	}
-}
-
-static inline void
-rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
-{
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, tmp - dec);
-	}
-}
-
-static inline void
-rte_atomic64_inc(rte_atomic64_t *v)
-{
-	rte_atomic64_add(v, 1);
-}
-
-static inline void
-rte_atomic64_dec(rte_atomic64_t *v)
-{
-	rte_atomic64_sub(v, 1);
-}
-
-static inline int64_t
-rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
-{
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, tmp + inc);
-	}
-
-	return tmp + inc;
-}
-
-static inline int64_t
-rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
-{
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, tmp - dec);
-	}
-
-	return tmp - dec;
-}
-
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
-{
-	return rte_atomic64_add_return(v, 1) == 0;
-}
-
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
-{
-	return rte_atomic64_sub_return(v, 1) == 0;
-}
-
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
-{
-	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
-}
-
-static inline void rte_atomic64_clear(rte_atomic64_t *v)
-{
-	rte_atomic64_set(v, 0);
-}
-#endif
 
 #endif /* _RTE_ATOMIC_I686_H_ */
diff --git a/lib/eal/x86/include/rte_atomic_64.h b/lib/eal/x86/include/rte_atomic_64.h
index 0a7a2131e0..1cd12695a2 100644
--- a/lib/eal/x86/include/rte_atomic_64.h
+++ b/lib/eal/x86/include/rte_atomic_64.h
@@ -22,163 +22,6 @@
 
 /*------------------------- 64 bit atomic operations -------------------------*/
 
-#ifndef RTE_FORCE_INTRINSICS
-static inline int
-rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
-{
-	uint8_t res;
-
-
-	asm volatile(
-			MPLOCKED
-			"cmpxchgq %[src], %[dst];"
-			"sete %[res];"
-			: [res] "=a" (res),     /* output */
-			  [dst] "=m" (*dst)
-			: [src] "r" (src),      /* input */
-			  "a" (exp),
-			  "m" (*dst)
-			: "memory");            /* no-clobber list */
-
-	return res;
-}
-
-static inline uint64_t
-rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
-{
-	asm volatile(
-			MPLOCKED
-			"xchgq %0, %1;"
-			: "=r" (val), "=m" (*dst)
-			: "0" (val),  "m" (*dst)
-			: "memory");         /* no-clobber list */
-	return val;
-}
-
-static inline void
-rte_atomic64_init(rte_atomic64_t *v)
-{
-	v->cnt = 0;
-}
-
-static inline int64_t
-rte_atomic64_read(rte_atomic64_t *v)
-{
-	return v->cnt;
-}
-
-static inline void
-rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
-{
-	v->cnt = new_value;
-}
-
-static inline void
-rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
-{
-	asm volatile(
-			MPLOCKED
-			"addq %[inc], %[cnt]"
-			: [cnt] "=m" (v->cnt)   /* output */
-			: [inc] "ir" (inc),     /* input */
-			  "m" (v->cnt)
-			);
-}
-
-static inline void
-rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
-{
-	asm volatile(
-			MPLOCKED
-			"subq %[dec], %[cnt]"
-			: [cnt] "=m" (v->cnt)   /* output */
-			: [dec] "ir" (dec),     /* input */
-			  "m" (v->cnt)
-			);
-}
-
-static inline void
-rte_atomic64_inc(rte_atomic64_t *v)
-{
-	asm volatile(
-			MPLOCKED
-			"incq %[cnt]"
-			: [cnt] "=m" (v->cnt)   /* output */
-			: "m" (v->cnt)          /* input */
-			);
-}
-
-static inline void
-rte_atomic64_dec(rte_atomic64_t *v)
-{
-	asm volatile(
-			MPLOCKED
-			"decq %[cnt]"
-			: [cnt] "=m" (v->cnt)   /* output */
-			: "m" (v->cnt)          /* input */
-			);
-}
-
-static inline int64_t
-rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
-{
-	int64_t prev = inc;
-
-	asm volatile(
-			MPLOCKED
-			"xaddq %[prev], %[cnt]"
-			: [prev] "+r" (prev),   /* output */
-			  [cnt] "=m" (v->cnt)
-			: "m" (v->cnt)          /* input */
-			);
-	return prev + inc;
-}
-
-static inline int64_t
-rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
-{
-	return rte_atomic64_add_return(v, -dec);
-}
-
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
-{
-	uint8_t ret;
-
-	asm volatile(
-			MPLOCKED
-			"incq %[cnt] ; "
-			"sete %[ret]"
-			: [cnt] "+m" (v->cnt), /* output */
-			  [ret] "=qm" (ret)
-			);
-
-	return ret != 0;
-}
-
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
-{
-	uint8_t ret;
-
-	asm volatile(
-			MPLOCKED
-			"decq %[cnt] ; "
-			"sete %[ret]"
-			: [cnt] "+m" (v->cnt),  /* output */
-			  [ret] "=qm" (ret)
-			);
-	return ret != 0;
-}
-
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
-{
-	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
-}
-
-static inline void rte_atomic64_clear(rte_atomic64_t *v)
-{
-	v->cnt = 0;
-}
-#endif
 
 /*------------------------ 128 bit atomic operations -------------------------*/
 
-- 
2.53.0

