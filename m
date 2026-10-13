Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB2ECC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:37:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F35140E2C;
	Wed, 14 Oct 2026 00:35:34 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 6C35D40B99
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:31 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e8b20a899fso13338265ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930930;
 x=1792535730; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mVzMjt8wqGeBmpHcBXwSi13u/EZtA6xpKPNOU3XTROo=;
 b=HBk9wbM0n6nvI7uPFBWzDDL8Meit0YotsgN6V5+lJh8JXcZVt+FQUct7HjDR/QUHod
 /vZtQ1RHOV6YAIPF6XEkEZbvmCXv1k3A0gtPQS05D5++T3ycdNZP9E1tpSy8JWj3k2q0
 kISLPFs1UflsYagu3uRaDU4do6R9wx6laHoR4cbPH+eS7nSJpaDVvFK18nYaA/qosuz9
 GZVPh0eGhKz+qCPR6cfpRbd7O1rxNY6lCCDQZws80vXSG2inkHGUq33OUfOtQ2v90nfU
 iIGVv0pGp4uLdawOP8Jye11FEg1ni0sBDrUuc8gstXsRvcATTICoXl4UaaUpHXaOPIln
 be/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930930; x=1792535730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mVzMjt8wqGeBmpHcBXwSi13u/EZtA6xpKPNOU3XTROo=;
 b=NxFnJA9Exx0ZQyVLDZjjx9EqN95XeC5OP/JQpLp6ahTgy7b7T5D3wdgGzq6nDfIPBf
 meBO5zWb5yxt5GuAaKeZmZ14gt1VXcYVt0Pe2uQHNgTgLR2pkfs/EIEwaFGqNpNcDUhX
 BMvrXSjJXG7XU0jLDYK5lyGMiSzTxJ+5hCrcRx3V5IeToJ2JLOhsu1/C/hex0qo8Lhbn
 lZUbbLdWEu9c9H7KH0tajBMMFKUuGG5P74wdF/Ygt5MUdyYdxPl0InxbvUKpSk2TeV9r
 0E8JoyjEF6q8FKT72l7iVBMo4TlqZc46xREZ4jDKUQKulq7lbzY/C/z6AWKqdjFzkIb/
 wjhw==
X-Gm-Message-State: AFq9FYJmQl0v0mMwMgpvekDzE3Txyf55/ZKA8oGgbOwhXgGh5cKxTr5i
 RmAw8T/LO9OL3ojmRCHGjVpI94t67i9wztxWtvCONY9d+pao+ksLPBrUURmRMicXM0ksoHbuHJ2
 CakN1Esw=
X-Gm-Gg: AYBFou2ACUtZZZKrS4jNN3jObJGceeHa1enJ7aYn4cYiu4nITlWjNBgThM3+oXnDxAs
 odu19fRm8vHjD3HwF6HQqfU5tqQsAuvLi8w2OwmcYS2tzek8GDD+MQ4wMy1zJFUHjhXS9Dm7jiE
 4CWZzIhv+yWBNmbfKOBy4He33rB8c2M67/olIstdITiG7SOHiMvoAmiP3LBBVQzogE1YGlajqRP
 pGA87EHVV/JgUu4PobPbbq5BDLAQRSW4Ekq4su7ypQCd2Kx2dTbQc+PWtJZmjQYObnQt8brv3SS
 KDL7Ul7qaLzwo4OepvWdD4IRgyvA+q5Kb8fUhv+FG6MCM/FmTvbPWnB+UOnT/QSRIxtcgxY6XET
 ue/JUsEgagkmnPipWmHlPrlyHtKckkHngbYbgvHst/S9ThvRaF1UjyJcHu+rayOP34j9Uwi/T5f
 V0yTAP6KMcnNZJLvINVlWv10ZletXEMoMjSAz2f9MzDEQ4K5yTEj8TGpUDL5HvwKMFU2BxRE6PN
 BQ5oPAeH/qZItIlU458CGVW/ZwBkou07CB7qA==
X-Received: by 2002:a17:903:41cf:b0:2dd:ad74:6d16 with SMTP id
 d9443c01a7336-2e842ab68efmr129751605ad.28.1791930930530; 
 Tue, 13 Oct 2026 15:35:30 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Riley Fletcher <rileyf@linux.ibm.com>, Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 29/29] eal: remove rte_smp_XX
Date: Tue, 13 Oct 2026 15:22:42 -0700
Message-ID: <20261013222410.2257622-30-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

These functions were marked for deprecation over five years ago and
have no users left in the tree. Drop them from EAL, along with the
deprecation notice, and record the replacements in the release notes.

Checkpatch no longer looks for them: now that the macros are gone,
any remaining use is a compile error.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh               |  8 ----
 doc/guides/rel_notes/deprecation.rst   |  8 ----
 doc/guides/rel_notes/release_26_11.rst | 11 +++++
 lib/eal/arm/include/rte_atomic_32.h    |  6 ---
 lib/eal/arm/include/rte_atomic_64.h    |  6 ---
 lib/eal/include/generic/rte_atomic.h   | 61 --------------------------
 lib/eal/loongarch/include/rte_atomic.h |  6 ---
 lib/eal/ppc/include/rte_atomic.h       |  6 ---
 lib/eal/riscv/include/rte_atomic.h     |  6 ---
 lib/eal/x86/include/rte_atomic.h       |  4 --
 10 files changed, 11 insertions(+), 111 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 466e06410a..c52fb5d1b6 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -121,14 +121,6 @@ check_forbidden_additions() { # <patch>
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
 		"$1" || res=1
 
-	# refrain from new additions of rte_smp_[r/w]mb()
-	awk -v FOLDERS="lib drivers app examples" \
-		-v EXPRESSIONS="rte_smp_(r|w)?mb\\\(" \
-		-v RET_ON_FAIL=1 \
-		-v MESSAGE='Using rte_smp_[r/w]mb' \
-		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
-		"$1" || res=1
-
 	# refrain from using compiler __sync_xxx builtins
 	awk -v FOLDERS="lib drivers app examples" \
 		-v EXPRESSIONS="__sync_.*\\\(" \
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 49ee85fa4e..5cc7cc12e6 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -29,14 +29,6 @@ Deprecation Notices
   Use the ``-S <service-corelist>`` parameter instead
   to specify the cores to be used for background services in DPDK.
 
-* rte_smp_*mb: These APIs provide full barrier functionality. However, many
-  use cases do not require full barriers. To support such use cases, DPDK has
-  adopted atomic operations from
-  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html. These
-  operations and a new wrapper ``rte_atomic_thread_fence`` instead of
-  ``__atomic_thread_fence`` must be used for patches that need to be merged in
-  20.08 onwards. This change will not introduce any performance degradation.
-
 * mempool: The ``flushthresh`` field in ``struct rte_mempool_cache`` is obsolete,
   and will be removed in DPDK 26.11.
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 25301088bf..d4a1333fa6 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -200,6 +200,17 @@ Removed Items
   ``cmpset`` and ``exchange``). Use the C11 ``rte_atomic_*_explicit``
   operations instead.
 
+* Removed SMP memory barriers:
+
+  * ``rte_smp_mb()`` replaced with ``rte_atomic_thread_fence(rte_memory_order_seq_cst)``
+  * ``rte_smp_rmb()`` replaced with ``rte_atomic_thread_fence(rte_memory_order_acquire)``
+  * ``rte_smp_wmb()`` replaced with ``rte_atomic_thread_fence(rte_memory_order_release)``
+
+  Some call sites became release stores or acquire loads instead of a
+  standalone fence. Barriers that order CPU accesses against a device,
+  rather than against another CPU, should use ``rte_io_wmb()`` and
+  ``rte_io_rmb()`` instead.
+
 * mempool: Removed the deprecated and obsolete ``flushthresh`` field
   from the ``rte_mempool_cache`` structure.
 
diff --git a/lib/eal/arm/include/rte_atomic_32.h b/lib/eal/arm/include/rte_atomic_32.h
index 696a539fef..4115271091 100644
--- a/lib/eal/arm/include/rte_atomic_32.h
+++ b/lib/eal/arm/include/rte_atomic_32.h
@@ -17,12 +17,6 @@ extern "C" {
 
 #define	rte_rmb() __sync_synchronize()
 
-#define rte_smp_mb() rte_mb()
-
-#define rte_smp_wmb() rte_wmb()
-
-#define rte_smp_rmb() rte_rmb()
-
 #define rte_io_mb() rte_mb()
 
 #define rte_io_wmb() rte_wmb()
diff --git a/lib/eal/arm/include/rte_atomic_64.h b/lib/eal/arm/include/rte_atomic_64.h
index 9f790238df..604e777bcd 100644
--- a/lib/eal/arm/include/rte_atomic_64.h
+++ b/lib/eal/arm/include/rte_atomic_64.h
@@ -20,12 +20,6 @@ extern "C" {
 
 #define rte_rmb() asm volatile("dmb oshld" : : : "memory")
 
-#define rte_smp_mb() asm volatile("dmb ish" : : : "memory")
-
-#define rte_smp_wmb() asm volatile("dmb ishst" : : : "memory")
-
-#define rte_smp_rmb() asm volatile("dmb ishld" : : : "memory")
-
 #define rte_io_mb() rte_mb()
 
 #define rte_io_wmb() rte_wmb()
diff --git a/lib/eal/include/generic/rte_atomic.h b/lib/eal/include/generic/rte_atomic.h
index 23fc7a4d44..d659691db4 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -51,67 +51,6 @@ static inline void rte_wmb(void);
 static inline void rte_rmb(void);
 ///@}
 
-/** @name SMP Memory Barrier
- */
-///@{
-/**
- * General memory barrier between lcores
- *
- * Guarantees that the LOAD and STORE operations that precede the
- * rte_smp_mb() call are globally visible across the lcores
- * before the LOAD and STORE operations that follows it.
- *
- * @note
- *  This function is deprecated.
- *  It provides similar synchronization primitive as atomic fence,
- *  but has different syntax and memory ordering semantic. Hence
- *  deprecated for the simplicity of memory ordering semantics in use.
- *
- *  rte_atomic_thread_fence(rte_memory_order_acq_rel) should be used instead.
- */
-static inline void rte_smp_mb(void);
-
-/**
- * Write memory barrier between lcores
- *
- * Guarantees that the STORE operations that precede the
- * rte_smp_wmb() call are globally visible across the lcores
- * before the STORE operations that follows it.
- *
- * @note
- *  This function is deprecated.
- *  It provides similar synchronization primitive as atomic fence,
- *  but has different syntax and memory ordering semantic. Hence
- *  deprecated for the simplicity of memory ordering semantics in use.
- *
- *  rte_atomic_thread_fence(rte_memory_order_release) should be used instead.
- *  The fence also guarantees LOAD operations that precede the call
- *  are globally visible across the lcores before the STORE operations
- *  that follows it.
- */
-static inline void rte_smp_wmb(void);
-
-/**
- * Read memory barrier between lcores
- *
- * Guarantees that the LOAD operations that precede the
- * rte_smp_rmb() call are globally visible across the lcores
- * before the LOAD operations that follows it.
- *
- * @note
- *  This function is deprecated.
- *  It provides similar synchronization primitive as atomic fence,
- *  but has different syntax and memory ordering semantic. Hence
- *  deprecated for the simplicity of memory ordering semantics in use.
- *
- *  rte_atomic_thread_fence(rte_memory_order_acquire) should be used instead.
- *  The fence also guarantees LOAD operations that precede the call
- *  are globally visible across the lcores before the STORE operations
- *  that follows it.
- */
-static inline void rte_smp_rmb(void);
-///@}
-
 /** @name I/O Memory Barrier
  */
 ///@{
diff --git a/lib/eal/loongarch/include/rte_atomic.h b/lib/eal/loongarch/include/rte_atomic.h
index 785a452c9e..a789e3ab4d 100644
--- a/lib/eal/loongarch/include/rte_atomic.h
+++ b/lib/eal/loongarch/include/rte_atomic.h
@@ -18,12 +18,6 @@ extern "C" {
 
 #define rte_rmb()	rte_mb()
 
-#define rte_smp_mb()	rte_mb()
-
-#define rte_smp_wmb()	rte_mb()
-
-#define rte_smp_rmb()	rte_mb()
-
 #define rte_io_mb()	rte_mb()
 
 #define rte_io_wmb()	rte_mb()
diff --git a/lib/eal/ppc/include/rte_atomic.h b/lib/eal/ppc/include/rte_atomic.h
index d3bd50a11a..1e5c1747e6 100644
--- a/lib/eal/ppc/include/rte_atomic.h
+++ b/lib/eal/ppc/include/rte_atomic.h
@@ -24,12 +24,6 @@ extern "C" {
 
 #define	rte_rmb() asm volatile("sync" : : : "memory")
 
-#define rte_smp_mb() rte_mb()
-
-#define rte_smp_wmb() rte_wmb()
-
-#define rte_smp_rmb() rte_rmb()
-
 #define rte_io_mb() rte_mb()
 
 #define rte_io_wmb() rte_wmb()
diff --git a/lib/eal/riscv/include/rte_atomic.h b/lib/eal/riscv/include/rte_atomic.h
index 061b175f33..04c40e4e9b 100644
--- a/lib/eal/riscv/include/rte_atomic.h
+++ b/lib/eal/riscv/include/rte_atomic.h
@@ -23,12 +23,6 @@ extern "C" {
 
 #define rte_rmb()	asm volatile("fence r, r" : : : "memory")
 
-#define rte_smp_mb()	rte_mb()
-
-#define rte_smp_wmb()	rte_wmb()
-
-#define rte_smp_rmb()	rte_rmb()
-
 #define rte_io_mb()	asm volatile("fence iorw, iorw" : : : "memory")
 
 #define rte_io_wmb()	asm volatile("fence orw, ow" : : : "memory")
diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_atomic.h
index a46bedb0f0..0ed9421055 100644
--- a/lib/eal/x86/include/rte_atomic.h
+++ b/lib/eal/x86/include/rte_atomic.h
@@ -23,10 +23,6 @@
 
 #define	rte_rmb() _mm_lfence()
 
-#define rte_smp_wmb() rte_compiler_barrier()
-
-#define rte_smp_rmb() rte_compiler_barrier()
-
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.53.0

