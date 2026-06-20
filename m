Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39845CD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67C4B4066E;
	Sat, 20 Jun 2026 04:32:16 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id 32F4940E44
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:32:13 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7dfe7712572so27901017b3.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922732;
 x=1782527532; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1LgbfuEmSfXEizvb2H4eeAy++/jgnipEcx1lNtafGc=;
 b=qLPCFfzwWuzKrg4uJyb5TSsn/gnUvJD429RHUzzoyxJdG3d/h2VNYuQeNaaSA9kQwm
 tpAjGQpXOU/JxxQYEqVDrV9gr29xFuhIEqc5/XBp86+fqc5Lc9LEzbebPuqaSq00hmFP
 NgmCmk3b+DyiO89TyHO3RTOQIDaFDm+FyNms/yOuEHMmZpBEfTqXN5QmT9eAJ4cBoeiq
 KmlmcixZ9rWuhHPBd13EX8k79JywcoCduHpEJVUVZHdkhlNJj7qBFIMZDXiZxyAASOmQ
 myZH9/mk7BrZ+Ra5MvCrXbiSMtHj6R2YWYAbbm/WmX/bfnaouE38kWJQA6+H+kwoRjY4
 aSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922732; x=1782527532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x1LgbfuEmSfXEizvb2H4eeAy++/jgnipEcx1lNtafGc=;
 b=BYyk17YX0h/QrFowB4cQODbjod8ciVUueQBKXmE9/wkB13DG1pCjiU21r6yzGQkI5w
 CgcvKeBnJo3laKbM72m5iTK1+I8u2+4PC+6j4Mp8b394YLegBwydwr5WrNeT0nRj/E2Y
 jX01+gzlPBZz580t3utDBBunhSSlaHIcjdUGJporuOyHMZbYY9O1Lgy0JdPEk0qH7yGG
 YxI5mcck1qIePXs8JfkivmXYHDZUtvUwkf29QbIu6H8h65qIRInN3wTQ3yns/imCbyb3
 1anW6dEpFgbS2XLy3dRoGFcsRcu3HvMqbxrDwKY/J7VkCCFcIT8uUCBeI3E+PDpeM0KW
 +2Dw==
X-Gm-Message-State: AOJu0YyAey3S4T/L1vruT/wvW37DVQE2KpfnO/MT5p+D0rjtujPDCDhM
 kvfsqU7GUMCk/iYNkWbYuKQWcD2sibuDATnRZJpJNd5BxC4+1gbFIO6Msx7QU4r1hEotNtH1DIo
 e1qeD
X-Gm-Gg: AfdE7ckuzgvtLWLszcMRt12MGruZergceX7SG23hnegpLfSrenb2k5afsx9yAUF50qX
 WOfFwpvxX3ialLPT+9l0x3JKyWk/qMZphx1EHJ7fDS1iWBLJfilZbjJAzWxMUPlnNPeaMP48TMt
 EXoTQRmy7UebEvoPVR6Rgm3jGdoB6/om4Tffg5WAK51a58ylLfj6TfPeSM7uw764s3DVgSSz+B3
 E8EqtJPrrwR4decYvShnwlVo20ThsaP0IXnmbllIcza6DIhkYsV2lb29sP1ES1RE2jF50ogAUlA
 p5dQ4VFdn9je/K5INHH4iC3R9xuozo+Coz5+8XUoI0TPNmcory3THGJuW0tqUGiu4Hp9lRca8F9
 iII8q9QuL0sruZUi0WthaHivt1hYvsbIBbaMg8JBZN/6f8qnm8CEAyOT0Ak5gT680kwjMLiob7C
 OJE9zHUo5lmyrFLPcRLEjQ5RI6MjR1AqqkJszdB+7JyaqLxjQ2vbE=
X-Received: by 2002:a05:690c:dd3:b0:7fe:4808:6545 with SMTP id
 00721157ae682-8013469cd06mr68343897b3.47.1781922732073; 
 Fri, 19 Jun 2026 19:32:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:32:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 24/24] eal: deprecate rte_atomicNN functions
Date: Fri, 19 Jun 2026 19:28:49 -0700
Message-ID: <20260620023134.42877-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

This deprecates existing rte_atomic functions that are not used
anywhere after this patch series. Rather than keeping platform
specific versions; just use the interinsic versions.

Now the compiler checks for these functions, no longer need
the check in checkpatches.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 devtools/checkpatches.sh               |   8 -
 doc/guides/rel_notes/deprecation.rst   |   4 +-
 doc/guides/rel_notes/release_26_07.rst |   5 +
 lib/eal/arm/include/rte_atomic_32.h    |   4 -
 lib/eal/arm/include/rte_atomic_64.h    |   4 -
 lib/eal/include/generic/rte_atomic.h   | 243 ++++++-------------------
 lib/eal/include/rte_common.h           |   2 +
 lib/eal/loongarch/include/rte_atomic.h |   4 -
 lib/eal/ppc/include/rte_atomic.h       | 173 ------------------
 lib/eal/riscv/include/rte_atomic.h     |   4 -
 lib/eal/x86/include/rte_atomic.h       | 172 -----------------
 lib/eal/x86/include/rte_atomic_32.h    | 188 -------------------
 lib/eal/x86/include/rte_atomic_64.h    | 157 ----------------
 13 files changed, 68 insertions(+), 900 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index f5dd77443f..13a2247ad5 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -113,14 +113,6 @@ check_forbidden_additions() { # <patch>
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
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index c7f8230278..9a9870226f 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -43,9 +43,7 @@ Deprecation Notices
 * rte_atomicNN_xxx: These APIs do not take memory order parameter. This does
   not allow for writing optimized code for all the CPU architectures supported
   in DPDK. DPDK has adopted the atomic operations from
-  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html. These
-  operations must be used for patches that need to be merged in 20.08 onwards.
-  This change will not introduce any performance degradation.
+  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html.
 
 * rte_smp_*mb: These APIs provide full barrier functionality. However, many
   use cases do not require full barriers. To support such use cases, DPDK has
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..e8092fc87b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -204,6 +204,11 @@ API Changes
   - ``rte_pmd_mlx5_enable_steering``
   - ``rte_pmd_mlx5_disable_steering``
 
+* **atomic: Marked the ``rte_atomicNN`` functions as deprecated.**
+
+  As previously announced these functions were intended to be deprecated
+  but was not being enforced.
+
 
 ABI Changes
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
index 0a4f3f8528..07b262895f 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -164,6 +164,13 @@ static inline void rte_io_rmb(void);
  */
 static inline void rte_atomic_thread_fence(rte_memory_order memorder);
 
+/*
+ * The rte_atomicNN_* APIs defined below are deprecated in favour of C11 atomics.
+ * Suppress the deprecation warnings for the inlines to allow inter-related usage.
+ */
+__rte_diagnostic_push
+__rte_allow_deprecated
+
 /*------------------------- 16 bit atomic operations -------------------------*/
 
 #ifndef RTE_TOOLCHAIN_MSVC
@@ -184,16 +191,11 @@ static inline void rte_atomic_thread_fence(rte_memory_order memorder);
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
-rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int
+static __rte_deprecated inline int
 rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
 }
-#endif
 
 /**
  * Atomic exchange.
@@ -210,16 +212,12 @@ rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
  * @return
  *   The original value at that location
  */
-static inline uint16_t
-rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint16_t
+static __rte_deprecated inline uint16_t
 rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
 {
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
+	return rte_atomic_exchange_explicit((volatile __rte_atomic uint16_t *)dst,
+		val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -239,7 +237,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_init(rte_atomic16_t *v)
 {
 	v->cnt = 0;
@@ -253,7 +251,7 @@ rte_atomic16_init(rte_atomic16_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_read(const rte_atomic16_t *v)
 {
 	return v->cnt;
@@ -267,7 +265,7 @@ rte_atomic16_read(const rte_atomic16_t *v)
  * @param new_value
  *   The new value for the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_set(rte_atomic16_t *v, int16_t new_value)
 {
 	v->cnt = new_value;
@@ -281,7 +279,7 @@ rte_atomic16_set(rte_atomic16_t *v, int16_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_add(rte_atomic16_t *v, int16_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, inc,
@@ -296,7 +294,7 @@ rte_atomic16_add(rte_atomic16_t *v, int16_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, dec,
@@ -309,16 +307,11 @@ rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic16_inc(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_inc(rte_atomic16_t *v)
 {
 	rte_atomic16_add(v, 1);
 }
-#endif
 
 /**
  * Atomically decrement a counter by one.
@@ -326,16 +319,11 @@ rte_atomic16_inc(rte_atomic16_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic16_dec(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_dec(rte_atomic16_t *v)
 {
 	rte_atomic16_sub(v, 1);
 }
-#endif
 
 /**
  * Atomically add a 16-bit value to a counter and return the result.
@@ -350,7 +338,7 @@ rte_atomic16_dec(rte_atomic16_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_add_return(rte_atomic16_t *v, int16_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, inc,
@@ -371,7 +359,7 @@ rte_atomic16_add_return(rte_atomic16_t *v, int16_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, dec,
@@ -389,15 +377,11 @@ rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
  * @return
  *   True if the result after the increment operation is 0; false otherwise.
  */
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) + 1 == 0;
 }
-#endif
 
 /**
  * Atomically decrement a 16-bit counter by one and test.
@@ -410,15 +394,11 @@ static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
  * @return
  *   True if the result after the decrement operation is 0; false otherwise.
  */
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) - 1 == 0;
 }
-#endif
 
 /**
  * Atomically test and set a 16-bit atomic counter.
@@ -431,14 +411,10 @@ static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
 {
 	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
 }
-#endif
 
 /**
  * Atomically set a 16-bit counter to 0.
@@ -446,7 +422,7 @@ static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic16_clear(rte_atomic16_t *v)
+static __rte_deprecated inline void rte_atomic16_clear(rte_atomic16_t *v)
 {
 	v->cnt = 0;
 }
@@ -469,16 +445,11 @@ static inline void rte_atomic16_clear(rte_atomic16_t *v)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
-rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int
+static __rte_deprecated inline int
 rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
 }
-#endif
 
 /**
  * Atomic exchange.
@@ -495,16 +466,12 @@ rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
  * @return
  *   The original value at that location
  */
-static inline uint32_t
-rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint32_t
+static __rte_deprecated inline uint32_t
 rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
 {
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
+	return rte_atomic_exchange_explicit((volatile __rte_atomic uint32_t *)dst,
+					    val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -524,7 +491,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_init(rte_atomic32_t *v)
 {
 	v->cnt = 0;
@@ -538,7 +505,7 @@ rte_atomic32_init(rte_atomic32_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_read(const rte_atomic32_t *v)
 {
 	return v->cnt;
@@ -552,7 +519,7 @@ rte_atomic32_read(const rte_atomic32_t *v)
  * @param new_value
  *   The new value for the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_set(rte_atomic32_t *v, int32_t new_value)
 {
 	v->cnt = new_value;
@@ -566,7 +533,7 @@ rte_atomic32_set(rte_atomic32_t *v, int32_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_add(rte_atomic32_t *v, int32_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, inc,
@@ -581,7 +548,7 @@ rte_atomic32_add(rte_atomic32_t *v, int32_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, dec,
@@ -594,16 +561,11 @@ rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic32_inc(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_inc(rte_atomic32_t *v)
 {
 	rte_atomic32_add(v, 1);
 }
-#endif
 
 /**
  * Atomically decrement a counter by one.
@@ -611,16 +573,11 @@ rte_atomic32_inc(rte_atomic32_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic32_dec(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_dec(rte_atomic32_t *v)
 {
 	rte_atomic32_sub(v,1);
 }
-#endif
 
 /**
  * Atomically add a 32-bit value to a counter and return the result.
@@ -635,7 +592,7 @@ rte_atomic32_dec(rte_atomic32_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_add_return(rte_atomic32_t *v, int32_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, inc,
@@ -656,7 +613,7 @@ rte_atomic32_add_return(rte_atomic32_t *v, int32_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, dec,
@@ -674,15 +631,11 @@ rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
  * @return
  *   True if the result after the increment operation is 0; false otherwise.
  */
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) + 1 == 0;
 }
-#endif
 
 /**
  * Atomically decrement a 32-bit counter by one and test.
@@ -695,15 +648,11 @@ static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
  * @return
  *   True if the result after the decrement operation is 0; false otherwise.
  */
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) - 1 == 0;
 }
-#endif
 
 /**
  * Atomically test and set a 32-bit atomic counter.
@@ -716,14 +665,10 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
 {
 	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
 }
-#endif
 
 /**
  * Atomically set a 32-bit counter to 0.
@@ -731,7 +676,7 @@ static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic32_clear(rte_atomic32_t *v)
+static __rte_deprecated inline void rte_atomic32_clear(rte_atomic32_t *v)
 {
 	v->cnt = 0;
 }
@@ -753,16 +698,11 @@ static inline void rte_atomic32_clear(rte_atomic32_t *v)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
-rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int
+static __rte_deprecated inline int
 rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
 }
-#endif
 
 /**
  * Atomic exchange.
@@ -779,16 +719,12 @@ rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
  * @return
  *   The original value at that location
  */
-static inline uint64_t
-rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline uint64_t
+static __rte_deprecated inline uint64_t
 rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
 {
-	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
+	return rte_atomic_exchange_explicit((volatile __rte_atomic uint64_t *)dst,
+					    val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -808,11 +744,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic64_init(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_init(rte_atomic64_t *v)
 {
 #ifdef __LP64__
@@ -828,7 +760,6 @@ rte_atomic64_init(rte_atomic64_t *v)
 	}
 #endif
 }
-#endif
 
 /**
  * Atomically read a 64-bit counter.
@@ -838,11 +769,7 @@ rte_atomic64_init(rte_atomic64_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int64_t
-rte_atomic64_read(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_read(rte_atomic64_t *v)
 {
 #ifdef __LP64__
@@ -860,7 +787,6 @@ rte_atomic64_read(rte_atomic64_t *v)
 	return tmp;
 #endif
 }
-#endif
 
 /**
  * Atomically set a 64-bit counter.
@@ -870,11 +796,7 @@ rte_atomic64_read(rte_atomic64_t *v)
  * @param new_value
  *   The new value of the counter.
  */
-static inline void
-rte_atomic64_set(rte_atomic64_t *v, int64_t new_value);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 {
 #ifdef __LP64__
@@ -890,7 +812,6 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 	}
 #endif
 }
-#endif
 
 /**
  * Atomically add a 64-bit value to a counter.
@@ -900,17 +821,12 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
-rte_atomic64_add(rte_atomic64_t *v, int64_t inc);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
 		rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * Atomically subtract a 64-bit value from a counter.
@@ -920,17 +836,12 @@ rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
-rte_atomic64_sub(rte_atomic64_t *v, int64_t dec);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
 		rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * Atomically increment a 64-bit counter by one and test.
@@ -938,16 +849,11 @@ rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic64_inc(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_inc(rte_atomic64_t *v)
 {
 	rte_atomic64_add(v, 1);
 }
-#endif
 
 /**
  * Atomically decrement a 64-bit counter by one and test.
@@ -955,16 +861,11 @@ rte_atomic64_inc(rte_atomic64_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic64_dec(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_dec(rte_atomic64_t *v)
 {
 	rte_atomic64_sub(v, 1);
 }
-#endif
 
 /**
  * Add a 64-bit value to an atomic counter and return the result.
@@ -979,17 +880,12 @@ rte_atomic64_dec(rte_atomic64_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int64_t
-rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
 		rte_memory_order_seq_cst) + inc;
 }
-#endif
 
 /**
  * Subtract a 64-bit value from an atomic counter and return the result.
@@ -1004,17 +900,12 @@ rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int64_t
-rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
 		rte_memory_order_seq_cst) - dec;
 }
-#endif
 
 /**
  * Atomically increment a 64-bit counter by one and test.
@@ -1027,14 +918,10 @@ rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
  * @return
  *   True if the result after the addition is 0; false otherwise.
  */
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_add_return(v, 1) == 0;
 }
-#endif
 
 /**
  * Atomically decrement a 64-bit counter by one and test.
@@ -1047,14 +934,10 @@ static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
  * @return
  *   True if the result after subtraction is 0; false otherwise.
  */
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_sub_return(v, 1) == 0;
 }
-#endif
 
 /**
  * Atomically test and set a 64-bit atomic counter.
@@ -1067,14 +950,10 @@ static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
 {
 	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
 }
-#endif
 
 /**
  * Atomically set a 64-bit counter to 0.
@@ -1082,17 +961,15 @@ static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic64_clear(rte_atomic64_t *v);
-
-#ifdef RTE_FORCE_INTRINSICS
-static inline void rte_atomic64_clear(rte_atomic64_t *v)
+static __rte_deprecated inline void rte_atomic64_clear(rte_atomic64_t *v)
 {
 	rte_atomic64_set(v, 0);
 }
-#endif
 
 #endif
 
+__rte_diagnostic_pop
+
 /*------------------------ 128 bit atomic operations -------------------------*/
 
 /**
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 2eb21d74d1..e73dc83b88 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -172,9 +172,11 @@ typedef uint16_t unaligned_uint16_t;
 #ifdef RTE_TOOLCHAIN_MSVC
 #define __rte_deprecated
 #define __rte_deprecated_msg(msg)
+#define __rte_allow_deprecated
 #else
 #define __rte_deprecated	__attribute__((__deprecated__))
 #define __rte_deprecated_msg(msg)	__attribute__((__deprecated__(msg)))
+#define __rte_allow_deprecated _Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
 #endif
 
 /**
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

