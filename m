Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D637CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:07:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CB1342ECA;
	Tue, 29 Sep 2026 16:04:50 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id C570C42E7D
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:40 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 d2e1a72fcca58-86efece610cso2111002b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690680;
 x=1791295480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z5qLaJ9skceDp06rmpGS4bQmgmqHZWrEAaCmUaSxeig=;
 b=ijr/thYByeaDmiPdy95GH1+wjVHytMs9LiNuSXXbgzTqPshwUpfxkCW5j6/lVl4Qyf
 sswvHdUu1UpZjud39iyF1AILodjer9K63EleQlKu6yco5E5bv7RCH+TDcukL/yjVsxtC
 p8f8oPy/DyTHtKP3v6JPyKtEwb96l/+oHuorSjeSmqS3t5GUGJjAZ7KUSRKTuvznAUuK
 BOo+gBZceYWjF/ry/wrZg+85UbXM4nu9vtLqYOQM91ahrZsobECh/Xuo5Fr8xfB2JkKe
 ZzXd3RSNp3BBb8UyuBdRd1eA39rvfFgW5dT/90DlxO/1YbZ/nAgmp4R+EkoiYy4w2RQr
 iHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690680; x=1791295480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z5qLaJ9skceDp06rmpGS4bQmgmqHZWrEAaCmUaSxeig=;
 b=KPj8I3t3OIWGPeDXWmtwVBcoMnxKUK6GeZmFUA8CQtgWbTqBfxbeNfGtJkFLPyak/W
 HgZ40G31WL3SsK0qhrZt/z4baKQvhZ+s1/ai5Qp7KsqaVMxMemwXTAC+5rARTXuZjbkL
 8Dl93V/wXc0jSbhkFcPRxwc1ZhcU2UN+Zd4s2wTWtu8lNmeCDE68ro2o+09V+peRd0pS
 Eo7sANhyeGWQvl8o//R1vPJkvFtWa+4zwobfmpDAVKjRT/o3y6AI6g+PGCzV85azHrrT
 XZ2Hhtas+ptK65WjfcH1SGNkh9JqZPgGxM4uP4L47jqSJWSxBQTepy6plAXMHpm0o7NX
 od5Q==
X-Gm-Message-State: AFuF++nTEXRd9TaSp4p1Ks17TKmwCR4Gsk2ne8b5mA/UoWO1BNFyJHBC
 9lt+snnD1kAcMWOFEpwT+vkroeNjuQ/ydTBGK6kfmv6THwI//w0Eni7q48CY2QSW3jX+tsRFbW1
 wmwdcHLk=
X-Gm-Gg: AYBFou2vbAgAMctg7xmtIyRBYbuDHUJCbJL7BZZcj1ydOi8ovF637bhRmdygEqZAlH4
 nsVdyuCz02/TyNaPoaHvdYZk0m36EUbaInP+IuO/mS2mdQEtJ3gFxPwiVV7B7nUJqbGv29+EcEf
 RpzsyXmxD//kAj8GEdSarUQmxSDY2G2BGO4yqM4HvQj9lS0gCTNhsXjq7LpLzgS+HWj932wTP2h
 iuOq2TnUyiCrUq2v+6vHfFyuyNaXrgSuNQ/azuWtHHr7csuOz48UZo4QwtMUnmXhXzAzxsU9T44
 Rh3xmDgZhTSjnIUQOeRLDuCA9+VE1j1Yb2wBnIi+iohh/+hkc6EKQCidqnwYiHX9j0DICnJ8h/Y
 OW5icjS+vY5wXWySUhX8DM0l7uEvubt7fT6dKQmVztDXTaCZU9hVwf6RgfOMKsB2IvvQeiwTiby
 jABRlZVkB/UIZcUSkmwP1bUTt8rZJ1y2DkQcZZMdqyrrlDcNNna37d24G9rICoSTfOkvsI0c88e
 HiDUK0/HnGAp+OxZIJP1p4LUCGQEKoCw7W9bw==
X-Received: by 2002:a05:6a20:394c:b0:3de:76da:6b9 with SMTP id
 adf61e73a8af0-3de76da0d41mr4019941637.68.1790690679509; 
 Tue, 29 Sep 2026 07:04:39 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Riley Fletcher <rileyf@linux.ibm.com>, Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v9 25/25] eal: remove rte_atomicNN functions
Date: Tue, 29 Sep 2026 07:02:11 -0700
Message-ID: <20260929140409.234453-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

Now that all the drivers and other code have been converted
to use stdatomic, the functions for rte_atomic16, rte_atomic32,
and rte_atomic64 can be removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh                      |   8 -
 .../prog_guide/writing_efficient_code.rst     |   9 +-
 doc/guides/rel_notes/deprecation.rst          |   7 -
 doc/guides/rel_notes/release_26_11.rst        |   7 +
 lib/eal/arm/include/rte_atomic_32.h           |   4 -
 lib/eal/arm/include/rte_atomic_64.h           |   4 -
 lib/eal/include/generic/rte_atomic.h          | 928 ------------------
 lib/eal/loongarch/include/rte_atomic.h        |   4 -
 lib/eal/ppc/include/rte_atomic.h              | 175 ----
 lib/eal/riscv/include/rte_atomic.h            |   4 -
 lib/eal/x86/include/meson.build               |   1 -
 lib/eal/x86/include/rte_atomic.h              | 187 +---
 lib/eal/x86/include/rte_atomic_32.h           | 212 ----
 lib/eal/x86/include/rte_atomic_64.h           | 157 ---
 14 files changed, 9 insertions(+), 1698 deletions(-)
 delete mode 100644 lib/eal/x86/include/rte_atomic_32.h

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 18bd825372..466e06410a 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -121,14 +121,6 @@ check_forbidden_additions() { # <patch>
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
 		"$1" || res=1
 
-	# refrain from new additions of 16/32/64 bits rte_atomicNN_xxx()
-	awk -v FOLDERS="lib drivers app examples" \
-		-v EXPRESSIONS="rte_atomic[0-9][0-9]_.*\\\(" \
-		-v RET_ON_FAIL=1 \
-		-v MESSAGE='Using rte_atomicNN_xxx' \
-		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
-		"$1" || res=1
-
 	# refrain from new additions of rte_smp_[r/w]mb()
 	awk -v FOLDERS="lib drivers app examples" \
 		-v EXPRESSIONS="rte_smp_(r|w)?mb\\\(" \
diff --git a/doc/guides/prog_guide/writing_efficient_code.rst b/doc/guides/prog_guide/writing_efficient_code.rst
index 6fbdb57fa8..7b927408bf 100644
--- a/doc/guides/prog_guide/writing_efficient_code.rst
+++ b/doc/guides/prog_guide/writing_efficient_code.rst
@@ -186,15 +186,8 @@ For instance, the Read-Copy-Update (RCU) algorithm can frequently replace simple
 Atomic Operations: Use C11 Atomic Builtins
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-DPDK generic rte_atomic operations are implemented by __sync builtins. These
-__sync builtins result in full barriers on aarch64, which are unnecessary
-in many use cases. They can be replaced by __atomic builtins that conform to
-the C11 memory model and provide finer memory order control.
+DPDK has been converted to C11 memory model atomics.
 
-So replacing the rte_atomic operations with __atomic builtins might improve
-performance for aarch64 machines.
-
-Some typical optimization cases are listed below:
 
 Atomicity
 ^^^^^^^^^
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 81e90a699c..56a67c372e 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -39,13 +39,6 @@ Deprecation Notices
   as part of its internal API. All drivers will be adjusted
   to use the new unified VFIO container device assignment API.
 
-* rte_atomicNN_xxx: These APIs do not take memory order parameter. This does
-  not allow for writing optimized code for all the CPU architectures supported
-  in DPDK. DPDK has adopted the atomic operations from
-  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html. These
-  operations must be used for patches that need to be merged in 20.08 onwards.
-  This change will not introduce any performance degradation.
-
 * rte_smp_*mb: These APIs provide full barrier functionality. However, many
   use cases do not require full barriers. To support such use cases, DPDK has
   adopted atomic operations from
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e027c7a27f..4a0f2d35ce 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -190,6 +190,13 @@ Removed Items
   The only remaining method for detecting LLDP packets is by using
   the mbuf packet type in conjunction with the ``enable_lldp`` devarg.
 
+* Removed the ``rte_atomicNN_t`` types and the ``rte_atomicNN_*`` functions
+  (16, 32 and 64 bit variants of ``init``, ``read``, ``set``, ``add``,
+  ``sub``, ``inc``, ``dec``, ``add_return``, ``sub_return``,
+  ``inc_and_test``, ``dec_and_test``, ``test_and_set``, ``clear``,
+  ``cmpset`` and ``exchange``). Use the C11 ``rte_atomic_*_explicit``
+  operations instead.
+
 
 API Changes
 -----------
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
index 0a4f3f8528..23fc7a4d44 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -164,934 +164,6 @@ static inline void rte_io_rmb(void);
  */
 static inline void rte_atomic_thread_fence(rte_memory_order memorder);
 
-/*------------------------- 16 bit atomic operations -------------------------*/
-
-#ifndef RTE_TOOLCHAIN_MSVC
-
-/**
- * Atomic compare and set.
- *
- * (atomic) equivalent to:
- *   if (*dst == exp)
- *     *dst = src (all 16-bit words)
- *
- * @param dst
- *   The destination location into which the value will be written.
- * @param exp
- *   The expected value.
- * @param src
- *   The new value.
- * @return
- *   Non-zero on success; 0 on failure.
- */
-static inline int
-rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int
-rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
-{
-	return __sync_bool_compare_and_swap(dst, exp, src);
-}
-#endif
-
-/**
- * Atomic exchange.
- *
- * (atomic) equivalent to:
- *   ret = *dst
- *   *dst = val;
- *   return ret;
- *
- * @param dst
- *   The destination location into which the value will be written.
- * @param val
- *   The new value.
- * @return
- *   The original value at that location
- */
-static inline uint16_t
-rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint16_t
-rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
-{
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
-}
-#endif
-
-/**
- * The atomic counter structure.
- */
-typedef struct {
-	volatile int16_t cnt; /**< An internal counter value. */
-} rte_atomic16_t;
-
-/**
- * Static initializer for an atomic counter.
- */
-#define RTE_ATOMIC16_INIT(val) { (val) }
-
-/**
- * Initialize an atomic counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic16_init(rte_atomic16_t *v)
-{
-	v->cnt = 0;
-}
-
-/**
- * Atomically read a 16-bit value from a counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   The value of the counter.
- */
-static inline int16_t
-rte_atomic16_read(const rte_atomic16_t *v)
-{
-	return v->cnt;
-}
-
-/**
- * Atomically set a counter to a 16-bit value.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param new_value
- *   The new value for the counter.
- */
-static inline void
-rte_atomic16_set(rte_atomic16_t *v, int16_t new_value)
-{
-	v->cnt = new_value;
-}
-
-/**
- * Atomically add a 16-bit value to an atomic counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param inc
- *   The value to be added to the counter.
- */
-static inline void
-rte_atomic16_add(rte_atomic16_t *v, int16_t inc)
-{
-	rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, inc,
-		rte_memory_order_seq_cst);
-}
-
-/**
- * Atomically subtract a 16-bit value from an atomic counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param dec
- *   The value to be subtracted from the counter.
- */
-static inline void
-rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
-{
-	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, dec,
-		rte_memory_order_seq_cst);
-}
-
-/**
- * Atomically increment a counter by one.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic16_inc(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic16_inc(rte_atomic16_t *v)
-{
-	rte_atomic16_add(v, 1);
-}
-#endif
-
-/**
- * Atomically decrement a counter by one.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic16_dec(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic16_dec(rte_atomic16_t *v)
-{
-	rte_atomic16_sub(v, 1);
-}
-#endif
-
-/**
- * Atomically add a 16-bit value to a counter and return the result.
- *
- * Atomically adds the 16-bits value (inc) to the atomic counter (v) and
- * returns the value of v after addition.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param inc
- *   The value to be added to the counter.
- * @return
- *   The value of v after the addition.
- */
-static inline int16_t
-rte_atomic16_add_return(rte_atomic16_t *v, int16_t inc)
-{
-	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, inc,
-		rte_memory_order_seq_cst) + inc;
-}
-
-/**
- * Atomically subtract a 16-bit value from a counter and return
- * the result.
- *
- * Atomically subtracts the 16-bit value (inc) from the atomic counter
- * (v) and returns the value of v after the subtraction.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param dec
- *   The value to be subtracted from the counter.
- * @return
- *   The value of v after the subtraction.
- */
-static inline int16_t
-rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
-{
-	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, dec,
-		rte_memory_order_seq_cst) - dec;
-}
-
-/**
- * Atomically increment a 16-bit counter by one and test.
- *
- * Atomically increments the atomic counter (v) by one and returns true if
- * the result is 0, or false in all other cases.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   True if the result after the increment operation is 0; false otherwise.
- */
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
-{
-	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
-		rte_memory_order_seq_cst) + 1 == 0;
-}
-#endif
-
-/**
- * Atomically decrement a 16-bit counter by one and test.
- *
- * Atomically decrements the atomic counter (v) by one and returns true if
- * the result is 0, or false in all other cases.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   True if the result after the decrement operation is 0; false otherwise.
- */
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
-{
-	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
-		rte_memory_order_seq_cst) - 1 == 0;
-}
-#endif
-
-/**
- * Atomically test and set a 16-bit atomic counter.
- *
- * If the counter value is already set, return 0 (failed). Otherwise, set
- * the counter value to 1 and return 1 (success).
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   0 if failed; else 1, success.
- */
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
-{
-	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
-}
-#endif
-
-/**
- * Atomically set a 16-bit counter to 0.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void rte_atomic16_clear(rte_atomic16_t *v)
-{
-	v->cnt = 0;
-}
-
-/*------------------------- 32 bit atomic operations -------------------------*/
-
-/**
- * Atomic compare and set.
- *
- * (atomic) equivalent to:
- *   if (*dst == exp)
- *     *dst = src (all 32-bit words)
- *
- * @param dst
- *   The destination location into which the value will be written.
- * @param exp
- *   The expected value.
- * @param src
- *   The new value.
- * @return
- *   Non-zero on success; 0 on failure.
- */
-static inline int
-rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int
-rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
-{
-	return __sync_bool_compare_and_swap(dst, exp, src);
-}
-#endif
-
-/**
- * Atomic exchange.
- *
- * (atomic) equivalent to:
- *   ret = *dst
- *   *dst = val;
- *   return ret;
- *
- * @param dst
- *   The destination location into which the value will be written.
- * @param val
- *   The new value.
- * @return
- *   The original value at that location
- */
-static inline uint32_t
-rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint32_t
-rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
-{
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
-}
-#endif
-
-/**
- * The atomic counter structure.
- */
-typedef struct {
-	volatile int32_t cnt; /**< An internal counter value. */
-} rte_atomic32_t;
-
-/**
- * Static initializer for an atomic counter.
- */
-#define RTE_ATOMIC32_INIT(val) { (val) }
-
-/**
- * Initialize an atomic counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic32_init(rte_atomic32_t *v)
-{
-	v->cnt = 0;
-}
-
-/**
- * Atomically read a 32-bit value from a counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   The value of the counter.
- */
-static inline int32_t
-rte_atomic32_read(const rte_atomic32_t *v)
-{
-	return v->cnt;
-}
-
-/**
- * Atomically set a counter to a 32-bit value.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param new_value
- *   The new value for the counter.
- */
-static inline void
-rte_atomic32_set(rte_atomic32_t *v, int32_t new_value)
-{
-	v->cnt = new_value;
-}
-
-/**
- * Atomically add a 32-bit value to an atomic counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param inc
- *   The value to be added to the counter.
- */
-static inline void
-rte_atomic32_add(rte_atomic32_t *v, int32_t inc)
-{
-	rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, inc,
-		rte_memory_order_seq_cst);
-}
-
-/**
- * Atomically subtract a 32-bit value from an atomic counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param dec
- *   The value to be subtracted from the counter.
- */
-static inline void
-rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
-{
-	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, dec,
-		rte_memory_order_seq_cst);
-}
-
-/**
- * Atomically increment a counter by one.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic32_inc(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic32_inc(rte_atomic32_t *v)
-{
-	rte_atomic32_add(v, 1);
-}
-#endif
-
-/**
- * Atomically decrement a counter by one.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic32_dec(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic32_dec(rte_atomic32_t *v)
-{
-	rte_atomic32_sub(v,1);
-}
-#endif
-
-/**
- * Atomically add a 32-bit value to a counter and return the result.
- *
- * Atomically adds the 32-bits value (inc) to the atomic counter (v) and
- * returns the value of v after addition.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param inc
- *   The value to be added to the counter.
- * @return
- *   The value of v after the addition.
- */
-static inline int32_t
-rte_atomic32_add_return(rte_atomic32_t *v, int32_t inc)
-{
-	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, inc,
-		rte_memory_order_seq_cst) + inc;
-}
-
-/**
- * Atomically subtract a 32-bit value from a counter and return
- * the result.
- *
- * Atomically subtracts the 32-bit value (inc) from the atomic counter
- * (v) and returns the value of v after the subtraction.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param dec
- *   The value to be subtracted from the counter.
- * @return
- *   The value of v after the subtraction.
- */
-static inline int32_t
-rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
-{
-	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, dec,
-		rte_memory_order_seq_cst) - dec;
-}
-
-/**
- * Atomically increment a 32-bit counter by one and test.
- *
- * Atomically increments the atomic counter (v) by one and returns true if
- * the result is 0, or false in all other cases.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   True if the result after the increment operation is 0; false otherwise.
- */
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
-{
-	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
-		rte_memory_order_seq_cst) + 1 == 0;
-}
-#endif
-
-/**
- * Atomically decrement a 32-bit counter by one and test.
- *
- * Atomically decrements the atomic counter (v) by one and returns true if
- * the result is 0, or false in all other cases.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   True if the result after the decrement operation is 0; false otherwise.
- */
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
-{
-	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
-		rte_memory_order_seq_cst) - 1 == 0;
-}
-#endif
-
-/**
- * Atomically test and set a 32-bit atomic counter.
- *
- * If the counter value is already set, return 0 (failed). Otherwise, set
- * the counter value to 1 and return 1 (success).
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   0 if failed; else 1, success.
- */
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
-{
-	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
-}
-#endif
-
-/**
- * Atomically set a 32-bit counter to 0.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void rte_atomic32_clear(rte_atomic32_t *v)
-{
-	v->cnt = 0;
-}
-
-/*------------------------- 64 bit atomic operations -------------------------*/
-
-/**
- * An atomic compare and set function used by the mutex functions.
- * (atomic) equivalent to:
- *   if (*dst == exp)
- *     *dst = src (all 64-bit words)
- *
- * @param dst
- *   The destination into which the value will be written.
- * @param exp
- *   The expected value.
- * @param src
- *   The new value.
- * @return
- *   Non-zero on success; 0 on failure.
- */
-static inline int
-rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int
-rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
-{
-	return __sync_bool_compare_and_swap(dst, exp, src);
-}
-#endif
-
-/**
- * Atomic exchange.
- *
- * (atomic) equivalent to:
- *   ret = *dst
- *   *dst = val;
- *   return ret;
- *
- * @param dst
- *   The destination location into which the value will be written.
- * @param val
- *   The new value.
- * @return
- *   The original value at that location
- */
-static inline uint64_t
-rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint64_t
-rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
-{
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
-}
-#endif
-
-/**
- * The atomic counter structure.
- */
-typedef struct {
-	volatile int64_t cnt;  /**< Internal counter value. */
-} rte_atomic64_t;
-
-/**
- * Static initializer for an atomic counter.
- */
-#define RTE_ATOMIC64_INIT(val) { (val) }
-
-/**
- * Initialize the atomic counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic64_init(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic64_init(rte_atomic64_t *v)
-{
-#ifdef __LP64__
-	v->cnt = 0;
-#else
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, 0);
-	}
-#endif
-}
-#endif
-
-/**
- * Atomically read a 64-bit counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   The value of the counter.
- */
-static inline int64_t
-rte_atomic64_read(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int64_t
-rte_atomic64_read(rte_atomic64_t *v)
-{
-#ifdef __LP64__
-	return v->cnt;
-#else
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
-#endif
-}
-#endif
-
-/**
- * Atomically set a 64-bit counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param new_value
- *   The new value of the counter.
- */
-static inline void
-rte_atomic64_set(rte_atomic64_t *v, int64_t new_value);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
-{
-#ifdef __LP64__
-	v->cnt = new_value;
-#else
-	int success = 0;
-	uint64_t tmp;
-
-	while (success == 0) {
-		tmp = v->cnt;
-		success = rte_atomic64_cmpset((volatile uint64_t *)&v->cnt,
-		                              tmp, new_value);
-	}
-#endif
-}
-#endif
-
-/**
- * Atomically add a 64-bit value to a counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param inc
- *   The value to be added to the counter.
- */
-static inline void
-rte_atomic64_add(rte_atomic64_t *v, int64_t inc);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
-{
-	rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
-		rte_memory_order_seq_cst);
-}
-#endif
-
-/**
- * Atomically subtract a 64-bit value from a counter.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param dec
- *   The value to be subtracted from the counter.
- */
-static inline void
-rte_atomic64_sub(rte_atomic64_t *v, int64_t dec);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
-{
-	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
-		rte_memory_order_seq_cst);
-}
-#endif
-
-/**
- * Atomically increment a 64-bit counter by one and test.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic64_inc(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic64_inc(rte_atomic64_t *v)
-{
-	rte_atomic64_add(v, 1);
-}
-#endif
-
-/**
- * Atomically decrement a 64-bit counter by one and test.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void
-rte_atomic64_dec(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
-rte_atomic64_dec(rte_atomic64_t *v)
-{
-	rte_atomic64_sub(v, 1);
-}
-#endif
-
-/**
- * Add a 64-bit value to an atomic counter and return the result.
- *
- * Atomically adds the 64-bit value (inc) to the atomic counter (v) and
- * returns the value of v after the addition.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param inc
- *   The value to be added to the counter.
- * @return
- *   The value of v after the addition.
- */
-static inline int64_t
-rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int64_t
-rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
-{
-	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
-		rte_memory_order_seq_cst) + inc;
-}
-#endif
-
-/**
- * Subtract a 64-bit value from an atomic counter and return the result.
- *
- * Atomically subtracts the 64-bit value (dec) from the atomic counter (v)
- * and returns the value of v after the subtraction.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @param dec
- *   The value to be subtracted from the counter.
- * @return
- *   The value of v after the subtraction.
- */
-static inline int64_t
-rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int64_t
-rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
-{
-	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
-		rte_memory_order_seq_cst) - dec;
-}
-#endif
-
-/**
- * Atomically increment a 64-bit counter by one and test.
- *
- * Atomically increments the atomic counter (v) by one and returns
- * true if the result is 0, or false in all other cases.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   True if the result after the addition is 0; false otherwise.
- */
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
-{
-	return rte_atomic64_add_return(v, 1) == 0;
-}
-#endif
-
-/**
- * Atomically decrement a 64-bit counter by one and test.
- *
- * Atomically decrements the atomic counter (v) by one and returns true if
- * the result is 0, or false in all other cases.
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   True if the result after subtraction is 0; false otherwise.
- */
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
-{
-	return rte_atomic64_sub_return(v, 1) == 0;
-}
-#endif
-
-/**
- * Atomically test and set a 64-bit atomic counter.
- *
- * If the counter value is already set, return 0 (failed). Otherwise, set
- * the counter value to 1 and return 1 (success).
- *
- * @param v
- *   A pointer to the atomic counter.
- * @return
- *   0 if failed; else 1, success.
- */
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
-{
-	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
-}
-#endif
-
-/**
- * Atomically set a 64-bit counter to 0.
- *
- * @param v
- *   A pointer to the atomic counter.
- */
-static inline void rte_atomic64_clear(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void rte_atomic64_clear(rte_atomic64_t *v)
-{
-	rte_atomic64_set(v, 0);
-}
-#endif
-
-#endif
 
 /*------------------------ 128 bit atomic operations -------------------------*/
 
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
index 10acc238f9..d3bd50a11a 100644
--- a/lib/eal/ppc/include/rte_atomic.h
+++ b/lib/eal/ppc/include/rte_atomic.h
@@ -42,181 +42,6 @@ rte_atomic_thread_fence(rte_memory_order memorder)
 	__rte_atomic_thread_fence(memorder);
 }
 
-/*------------------------- 16 bit atomic operations -------------------------*/
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
-
 #ifdef __cplusplus
 }
 #endif
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
diff --git a/lib/eal/x86/include/meson.build b/lib/eal/x86/include/meson.build
index 71f149e821..58313127bb 100644
--- a/lib/eal/x86/include/meson.build
+++ b/lib/eal/x86/include/meson.build
@@ -17,7 +17,6 @@ dpdk_arch_headers += files(
         'rte_vect.h',
 )
 dpdk_arch_indirect_headers += files(
-        'rte_atomic_32.h',
         'rte_atomic_64.h',
         'rte_byteorder_32.h',
         'rte_byteorder_64.h',
diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_atomic.h
index e071e4234e..20a4baa575 100644
--- a/lib/eal/x86/include/rte_atomic.h
+++ b/lib/eal/x86/include/rte_atomic.h
@@ -105,192 +105,7 @@ rte_atomic_thread_fence(rte_memory_order memorder)
 
 #ifndef RTE_TOOLCHAIN_MSVC
 
-/*------------------------- 16 bit atomic operations -------------------------*/
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
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
-
-#ifdef __cplusplus
-}
-#endif
-
-#ifdef RTE_ARCH_I686
-#include "rte_atomic_32.h"
-#else
+#ifndef RTE_ARCH_I686
 #include "rte_atomic_64.h"
 #endif
 
diff --git a/lib/eal/x86/include/rte_atomic_32.h b/lib/eal/x86/include/rte_atomic_32.h
deleted file mode 100644
index 0f25863aa5..0000000000
--- a/lib/eal/x86/include/rte_atomic_32.h
+++ /dev/null
@@ -1,212 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2014 Intel Corporation.
- */
-
-/*
- * Inspired from FreeBSD src/sys/i386/include/atomic.h
- * Copyright (c) 1998 Doug Rabson
- * All rights reserved.
- */
-
-#ifndef _RTE_ATOMIC_X86_H_
-#error do not include this file directly, use <rte_atomic.h> instead
-#endif
-
-#ifndef _RTE_ATOMIC_I686_H_
-#define _RTE_ATOMIC_I686_H_
-
-#include <stdint.h>
-#include <rte_common.h>
-
-/*------------------------- 64 bit atomic operations -------------------------*/
-
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
-
-#endif /* _RTE_ATOMIC_I686_H_ */
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

