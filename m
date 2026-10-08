Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF709CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:39:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B387440DFB;
	Fri,  9 Oct 2026 01:37:51 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id CC96640DFB
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:49 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-88b5f43cb8aso2039223b3a.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502669;
 x=1792107469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3TBZx3VSY+dvM9r+DSQ2+UeUSHN2dqpRDD7fvdIq5bQ=;
 b=Wht8UD43SMjLKoXfmsm41JZr4jU4gtKAJ4xslwePWtuUWtkYhvMeCO2pkBHEM4FoXz
 Za1/Glis/W9MeQhjh8cDBSXz5mUWO+iDd3qITn22Uq65zi1Vu4brCQE58RKAjqHamK+J
 OvweLs1Dlkq817RzFzdYjrsgRmlCZSou1VmCyzYf037iWdkDk2E72tAn6S/ahjRzenyr
 Crz0w3wmV9sTClh57t6Kf+3Ry9SJqPRTTuLnWolxEp2bnERcHQ0UhSZYyAz5ufh3j/H7
 kMewOVpTqicBG+VZgEB2gF5jEJqK8dRUnVOeGKWiymAo2v+L5nWBDnkZpAgWksamNpYS
 IhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502669; x=1792107469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3TBZx3VSY+dvM9r+DSQ2+UeUSHN2dqpRDD7fvdIq5bQ=;
 b=y9BMtRTH93DgENKdj4kXqgH4td1uZ0UcefVLDKvJ5hUYk2o5Bw2QFRLb7vS5bwlLGG
 5Bycx7czuXdAZslY40o7NPi6skB1G3EVDL/Flk/leYygMeBVXIe+EciLWEe5nj/bLpRq
 0UpRJlr4L4EcMzN0PeLtCNq0oBEkcdWUo8XKXYg/xFxTiVxUeG6UitkaeUyrqxe4ep9m
 U1o1WcucnrFeiXV9u3t/tdCr16csoqbOd3d2qcA4SQBqYZeC0vhQwZxH2SJsSMIbXvBu
 sGFyvsDVktEHWgyZW2HGb7QGzeCr70PXd/Zc5JnzQ6e4lLK2K/Q4WXNIqLfMGRBuy8kF
 jcqA==
X-Gm-Message-State: AFuF++lLWzXufoBxcXSJMjfF3eKIAfLAOCQMZGCxojRcOXi9EuTEEQ8/
 0WWsOhrWSBsD3gHNOjbr6KqFAthNZAp/CcqNrQjEojRPpRgOu2DnTWUWnrBLbVJeLlIQyXa98/D
 QsCggkAw=
X-Gm-Gg: AYBFou1s5nfXbgwpZTM3URJNDGdRuEFhTE5NSHnpuIAhx0tv1HbVTOzGmZM1QghjZc7
 QlyRUuwksSnOCd1a+ikL/WLV6RS6Bdg9jMm/BkMp/DorVgVlDeq1r/hofE5LL83uztE6IU0TvPq
 2VBBDaq8eA5SKigPIG3Y7xu6vBoDsn6uXhGJ4z6iLn5MRltXMZjSp68apANG8yk5Ju4fzYrVcir
 27Db+SeKkDzw366pHMXDIZiTWx3n/nnAiYpKGCVza9pLKfN8Dp4jcliCJotyFS7fix2NaM4RtNg
 97dzdFzsLfuXO+7CRZzNCRnzlqQbrRovbQr3ZPgGoFyMpKhQvNrJPjxsC816ORfT131fZ8ElHZq
 tObYYUQfqK5eEcXwONnoKyWjvIgCjGwwBXD8rQ4bLtxyFhoCMDaksJxU9y53eIV5nbaYJo/GWDY
 A9tlRy7GTc0NDSeiZmdod5o0OmloqLbXY7/VM6NKYtk+e7PhgAKE5u5D3LrAC7zVICv6phVPz3y
 OuSUxr0FoIPIOkDWOUPoRyS0/+PPDpjbexlsg==
X-Received: by 2002:a05:6a00:181c:b0:88c:fa50:1a86 with SMTP id
 d2e1a72fcca58-897c78d5fddmr39401b3a.25.1791502668855; 
 Thu, 08 Oct 2026 16:37:48 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Riley Fletcher <rileyf@linux.ibm.com>, Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 29/29] eal: remove rte_smp_XX
Date: Thu,  8 Oct 2026 16:35:22 -0700
Message-ID: <20261008233649.1260843-30-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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
index 56a67c372e..600d789df8 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -39,14 +39,6 @@ Deprecation Notices
   as part of its internal API. All drivers will be adjusted
   to use the new unified VFIO container device assignment API.
 
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
index 16d3a90723..dd21c87afa 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -182,6 +182,17 @@ Removed Items
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
 * ethdev: Removed support for ethdev queue stats mapping.
 
   ``rte_eth_dev_set_tx_queue_stats_mapping`` and ``rte_eth_dev_set_rx_queue_stats_mapping``
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

