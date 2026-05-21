Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8747CCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:20:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EEA240658;
	Thu, 21 May 2026 06:20:52 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 3D03A4042E
 for <dev@dpdk.org>; Thu, 21 May 2026 06:20:49 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30246cfd41aso4582575eec.1
 for <dev@dpdk.org>; Wed, 20 May 2026 21:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779337248;
 x=1779942048; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5hjyJwlHsetL7qlKOeumxRIE4XZzpr4C4/CMlwtnjM=;
 b=Sb9SD18qqXeAM/Iu0HzoU5hb+gR+4U6ve7zQ1/yxq+DCThC7WbXGpY0KCYIp78Q/79
 JEKUOtxysbO5Uz62dvOMoYHd3NswAU2f8JmVyE74x5abFis9aFJ4XqI6bPA4SX0OpJOD
 RitJAI/8DN42m3nuN2Msezk3jv2AVhNsjajiqE2tYX0pde88IvIF0F6YcAK1t4SkFPld
 PZ22e1C83GdtMI0XZKldBMLrk8Y5QD7qGItD9rDTOv/S1nIHbgWxioNoD9Ub7fnYEANQ
 MWLPZoRQZ4izenywXMQHRywbUNN864DpIT6hU7hskIXKkoR6FVjJIhSXWPn9G1LiSeOj
 LfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779337248; x=1779942048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j5hjyJwlHsetL7qlKOeumxRIE4XZzpr4C4/CMlwtnjM=;
 b=U1moEDagyWsivn2qTloiGlFxjiBpiriiaNx82nG62m7Hp59gIvTEmgep+dgLXko0H0
 MO5EgJGUKcJ0gBGCRnvfizty/n/oZpqpcIvfswQSEQ5pN3e9+bBZAXebqyAKW42vn/sE
 dB+sYoEQLfpCy/WfPTzlZiUeOfJkX69o/V9cl/sjeTyqpjrOrGUf+kQdJaTFjJF5x88m
 udXjf6jNakvhC3a0P0uswFXpJyAGMBbqnWDyIhKCGHEk6MeP5gjXicfS2eGYdLHIboyd
 Iyu/8xo4QsqKaPmXvHJxgw8hwNMiTBTP7eRqxA8BAjz01r8LEt9ARa/w2zhNDbKp/feu
 wkgA==
X-Gm-Message-State: AOJu0YzFuMBGNFKPZg7FBc/iQAqNIcb7WE43hSlpYVHjFy2HJIGAiOxH
 dmCMF54mwNzqC4L1OpiDMR+BbiLxwrt4oDRi7ogzFXd9PVRktRSrRKLLvOJRPDOT5TTWPllF5nO
 SflVJ
X-Gm-Gg: Acq92OHV5bqCJtQ7JZtavNuIRcn3n4zfNfbkfSyxSgbVaJv6ca+pKEQW3/G/VuwteOX
 pI4gs/oGS9pdL2T/DvUdJb1j/Pop1FDG2K1xRjEYZwV6zErczJrixMRra7ajWeNK8fe5Q/SZuWt
 Ae2QnpsBwROvPLqUZo8ler8H+ZJGJkllxOk/aw3/JQAXkhjZttGX9l2ybRcfjcgUh+yBkOiX6yT
 G2t/oBKg4kig+cP3rjEEDqu/zZ3kIF7M2jrWL6KA2YxBHyLNDj0uBmfGfJ6FieRaGwv63kaOfZF
 e0MZUR9wGBDxUxA6YooyThbLFC9jUrlJ7AANK7B3vJYKPtSAtglpRA6xm+AF/sIllCfgrFDBfk3
 T7lDHbmjZIGrrlIYaDPsqEZEeQ6nH/UFWtfOAmhdscgg4+KWwj0853sM6Dh9Xy9TqlwQIhs8HH3
 ziB1Llv47LxGWf8WeiFoeqEF/TNGfL39IKcEilKuKY5RIUewzwZoaqQgweOoU7VPRoUb6YcH4a
X-Received: by 2002:a05:7300:8b2b:b0:2dd:c066:bf7 with SMTP id
 5a478bee46e88-3042f7130afmr879173eec.11.1779337248193; 
 Wed, 20 May 2026 21:20:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm24347748eec.5.2026.05.20.21.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:20:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [RFC 2/7] eal: reimplement rte_smp_*mb with rte_atomic_thread_fence
Date: Wed, 20 May 2026 21:17:02 -0700
Message-ID: <20260521042043.1590536-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
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

The rte_smp_mb(), rte_smp_wmb() and rte_smp_rmb() functions were
flagged as deprecated by commit 3ec965b6de12 ("doc: update atomic
operation deprecation") in 2021 but nothing came of it.
Reimplement them as inline wrappers over rte_atomic_thread_fence()
and drop the deprecation notice.
The API is preserved; only the implementation changes.

Generated code is unchanged on x86 (seq_cst keeps the lock-addl
trick, release/acquire collapse to a compiler barrier under TSO).
On arm64, release/acquire emit dmb ish instead of dmb ishst/ishld;
the difference is below measurement noise.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/deprecation.rst   |   8 --
 lib/eal/arm/include/rte_atomic_32.h    |   6 --
 lib/eal/arm/include/rte_atomic_64.h    |   6 --
 lib/eal/include/generic/rte_atomic.h   | 106 +++++++++++--------------
 lib/eal/loongarch/include/rte_atomic.h |   6 --
 lib/eal/ppc/include/rte_atomic.h       |   6 --
 lib/eal/riscv/include/rte_atomic.h     |   6 --
 lib/eal/x86/include/rte_atomic.h       |  33 +++-----
 8 files changed, 57 insertions(+), 120 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 346c517623..03b763b472 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -47,14 +47,6 @@ Deprecation Notices
   operations must be used for patches that need to be merged in 20.08 onwards.
   This change will not introduce any performance degradation.
 
-* rte_smp_*mb: These APIs provide full barrier functionality. However, many
-  use cases do not require full barriers. To support such use cases, DPDK has
-  adopted atomic operations from
-  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html. These
-  operations and a new wrapper ``rte_atomic_thread_fence`` instead of
-  ``__atomic_thread_fence`` must be used for patches that need to be merged in
-  20.08 onwards. This change will not introduce any performance degradation.
-
 * lib: will fix extending some enum/define breaking the ABI. There are multiple
   samples in DPDK that enum/define terminated with a ``.*MAX.*`` value which is
   used by iterators, and arrays holding these values are sized with this
diff --git a/lib/eal/arm/include/rte_atomic_32.h b/lib/eal/arm/include/rte_atomic_32.h
index 0b9a0dfa30..3809ddefb7 100644
--- a/lib/eal/arm/include/rte_atomic_32.h
+++ b/lib/eal/arm/include/rte_atomic_32.h
@@ -21,12 +21,6 @@ extern "C" {
 
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
index 181bb60929..c9b41f6212 100644
--- a/lib/eal/arm/include/rte_atomic_64.h
+++ b/lib/eal/arm/include/rte_atomic_64.h
@@ -24,12 +24,6 @@ extern "C" {
 
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
index 0a4f3f8528..4e9d230f85 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -49,69 +49,8 @@ static inline void rte_wmb(void);
  * occur before the LOAD operations generated after.
  */
 static inline void rte_rmb(void);
-///@}
-
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
 ///@}
-
 /** @name I/O Memory Barrier
  */
 ///@{
@@ -164,6 +103,51 @@ static inline void rte_io_rmb(void);
  */
 static inline void rte_atomic_thread_fence(rte_memory_order memorder);
 
+
+/** @name SMP Memory Barrier
+ */
+///@{
+/**
+ * General memory barrier between lcores
+ *
+ * Guarantees that the LOAD and STORE operations that precede the
+ * rte_smp_mb() call are globally visible across the lcores
+ * before the LOAD and STORE operations that follows it.
+ */
+static __rte_always_inline void
+rte_smp_mb(void)
+{
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+}
+
+/**
+ * Write memory barrier between lcores
+ *
+ * Guarantees that the STORE operations that precede the
+ * rte_smp_wmb() call are globally visible across the lcores
+ * before the STORE operations that follows it.
+ */
+static __rte_always_inline void
+rte_smp_wmb(void)
+{
+	rte_atomic_thread_fence(rte_memory_order_release);
+}
+
+/**
+ * Read memory barrier between lcores
+ *
+ * Guarantees that the LOAD operations that precede the
+ * rte_smp_rmb() call are globally visible across the lcores
+ * before the LOAD operations that follows it.
+ */
+static __rte_always_inline void
+rte_smp_rmb(void)
+{
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+}
+
+///@}
+
 /*------------------------- 16 bit atomic operations -------------------------*/
 
 #ifndef RTE_TOOLCHAIN_MSVC
diff --git a/lib/eal/loongarch/include/rte_atomic.h b/lib/eal/loongarch/include/rte_atomic.h
index c8066a4612..49e0c67020 100644
--- a/lib/eal/loongarch/include/rte_atomic.h
+++ b/lib/eal/loongarch/include/rte_atomic.h
@@ -22,12 +22,6 @@ extern "C" {
 
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
index 10acc238f9..1da5afccbf 100644
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
index 66346ad474..dd10ad5127 100644
--- a/lib/eal/riscv/include/rte_atomic.h
+++ b/lib/eal/riscv/include/rte_atomic.h
@@ -27,12 +27,6 @@ extern "C" {
 
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
index e071e4234e..a850b0257c 100644
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
@@ -63,20 +59,6 @@ extern "C" {
  * So below we use that technique for rte_smp_mb() implementation.
  */
 
-static __rte_always_inline void
-rte_smp_mb(void)
-{
-#ifdef RTE_TOOLCHAIN_MSVC
-	_mm_mfence();
-#else
-#ifdef RTE_ARCH_I686
-	asm volatile("lock addl $0, -128(%%esp); " ::: "memory");
-#else
-	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
-#endif
-#endif
-}
-
 #define rte_io_mb() rte_mb()
 
 #define rte_io_wmb() rte_compiler_barrier()
@@ -93,10 +75,19 @@ rte_smp_mb(void)
 static __rte_always_inline void
 rte_atomic_thread_fence(rte_memory_order memorder)
 {
-	if (memorder == rte_memory_order_seq_cst)
-		rte_smp_mb();
-	else
+	if (memorder == rte_memory_order_seq_cst) {
+#ifdef RTE_TOOLCHAIN_MSVC
+		_mm_mfence();
+#else
+#ifdef RTE_ARCH_I686
+		asm volatile("lock addl $0, -128(%%esp); " ::: "memory");
+#else
+		asm volatile("lock addl $0, -128(%%rsp); " ::: "memory");
+#endif
+#endif
+	} else {
 		__rte_atomic_thread_fence(memorder);
+	}
 }
 
 #ifdef __cplusplus
-- 
2.53.0

