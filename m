Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A11AC982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D730C427A0;
	Sun, 20 Sep 2026 20:14:36 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 56EC9410D3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:26 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso2071485a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928065;
 x=1790532865; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7QnGSaGyl6x8n9ADCN/TSaIY+fe4o6GcdsZNvRUrQSQ=;
 b=RLY/x2Ch2HahshoB5ukx30jV7RMNggoHg0OG7BBPFGn+CzMF7fNt801q5auK5fXbrM
 QM4jNDHBj4Qrvvu+R7Fydp6eArPACn2rRgcgeNoEUcMQNmSCLA/5N75RlvXARwjC8BHK
 ReMTBkGd+fpHR0CSBH/xOICBYLoM90rcqbs6KOOlqDocmYgrCDzd9FrrgpAUNpFU8FHY
 0I/LsdefPTESpuYgRdBcJApwaMACa1niYl3aB0nXNLpAMz3oSs/hIBbrNEAA7iu9Zd1+
 CE3APCu0UR/FyeIik4xHX+MXizeraumBHxfO5cElnwWU7AFgdBgNg0Gy57mw1E0CUb0J
 5o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928065; x=1790532865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7QnGSaGyl6x8n9ADCN/TSaIY+fe4o6GcdsZNvRUrQSQ=;
 b=B6mnMLoMeM14scOv+MPaIuVJeZjnsp1liAN61vn41u8j793hyOgVgv/+gRsWZk8KYO
 +NTDSu5nBBgIcdDZiF7mIjNVf2ZoGlepLMe7RC5KMuH5oy482FtV8jc9qoaXH+lrsc7K
 Z5aAgT6+OykjdrWZti0ORT9udUZ4dNsFkCy7zO9RbxJi6GJCC9Ps32JjBcrl6VVqsSFQ
 7pbkXNv9+qVdTYTBFwsKETJikgRDh+QjYeWv4Aj3WGrFshyhYzApc414z9giYNCVxcGG
 iVjD//CkIkb/EKDKzyDJSpJ6ySiTBKVk/rtXvA49KWQe5eg93wYMHug3p23mWvyyKrNG
 vZdQ==
X-Gm-Message-State: AFuF++kGH909cfdW/3Yq755L8tFPiK71g4HOkj9TXcYu+gk/5MqualFd
 qLgYAdu98Rf/J/oRI7njGqnGZ1lvsSxi6ZAJRBLHp4/3c2oFJFxTbmjjrJ6wOpu7V1C7qRMDXZp
 8S4LU
X-Gm-Gg: AYBFou1Swxo0I4lnvyehRI10otjPuH0DRviUDw3Gaku/hJr4cfZq2CnIBATKdbi9y/7
 rkliAN0oS6StZFdo6hFPjdgYwxwyIODTiVlydWuqN079JaCY1wCmdP/petk/URfj971sFczWdZW
 xIJKAbeqVbv0Wxr05Nb2qDgXSAqnmNjvEtkwnNpsD8FCujV+8DU1ojZi7Q3q3w46RHWuLILSeip
 vai4TV3T3hbACPt4bVSNUAs3wBODS93zPY60h5CkBXAGxnA2JR9yUgUw9uLazOVlQNEzvRDCbYA
 8YZDYuqqdLQUlHuMECooFqcaHhwFEn03ZMVsF2/JYj4h7CNzq6HfVBKPaaYIMwmNoaxVWJhrjgJ
 vq3+Cht84gjishsZi1NbFfXbYws4WB8bOkdsdLspCAjFL4Fb9Z/+5qJ/io7VYVdcVB/ZN89Cuhh
 7kN9otCtjyoHHGD6uAYtPzDCYavQqJOSkE7oDSf54jfqzJGmAkpaiGhkZNQVYUGUyfF6cL0gzx9
 dCsZqFlCZbpx0TpUaQbICoMokgnWgOqB9HJO3GV/FBFqBuzZQ==
X-Received: by 2002:a17:90b:3c05:b0:39e:6c6a:657e with SMTP id
 98e67ed59e1d1-39e6c6a679dmr7729761a91.65.1789928065444; 
 Sun, 20 Sep 2026 11:14:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Riley Fletcher <rileyf@linux.ibm.com>, Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 31/33] eal: remove rte_smp_XX
Date: Sun, 20 Sep 2026 11:10:23 -0700
Message-ID: <20260920181347.747210-32-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

These functions were marked for deprecation and no longer used.
Drop from EAL.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/arm/include/rte_atomic_32.h    |  6 ---
 lib/eal/arm/include/rte_atomic_64.h    |  6 ---
 lib/eal/include/generic/rte_atomic.h   | 61 --------------------------
 lib/eal/loongarch/include/rte_atomic.h |  6 ---
 lib/eal/ppc/include/rte_atomic.h       |  6 ---
 lib/eal/riscv/include/rte_atomic.h     |  6 ---
 lib/eal/x86/include/rte_atomic.h       |  4 --
 7 files changed, 95 deletions(-)

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
index 0a4f3f8528..937d344c89 100644
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
index 780fdce871..826b5033d1 100644
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

