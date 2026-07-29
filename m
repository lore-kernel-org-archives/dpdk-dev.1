Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E22C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 18:00:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5E8140E24;
	Wed, 29 Jul 2026 19:57:59 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6B3C440DCE
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:51 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so18392775ad.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347870;
 x=1785952670; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7QnGSaGyl6x8n9ADCN/TSaIY+fe4o6GcdsZNvRUrQSQ=;
 b=DaCLsIcsHquHgtkaiIYptn1l9nQQJjPM8rhYmVSmk+gxdwVhEjrZ0YGpN6rUCfDfEd
 /LS6wJsRFnP6ZPxh/x2fnDnTaa9/bfgk4FlE9baACZ9b3Wb3pCmKb5a43N2pEfWMZGiD
 285Ny29FLsD6DSTKC6liQlNr2pbUqsMU9DRiO/jWvzvkLpmS5z7bb5FOE3AoDD+ufDd0
 TMHxxHfBwhnLT+K1hPgyeMcO+B9ugW7xT4x6579U/V3VzmFmtT+rLDVwETHShKyft9RA
 r4cSCBcXSh1VOfaxaLhZGjYix//Ka+pLWcLUQ1COmNWkun09r1caR5wfG4CRsbjyAMMI
 BUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347870; x=1785952670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7QnGSaGyl6x8n9ADCN/TSaIY+fe4o6GcdsZNvRUrQSQ=;
 b=iLRls1etgMcNLuqzedFLLnfM6Tk6cILZuONw9yTJ2qlYyPdsxH+hsDrevj+j9gwzuT
 pHZY3RySYsypKnuVzZvBSy7mZNz+0UGrb6ra8kzxYXdhC0cSXnpXHQh0dkXAuNrV31fc
 pDygELiuypzWkx8UpoX+RxtzAM+lj57pucgTDu6qaKpIZuyqanChIN0RBsekMx6ThsLB
 3eFESAvBCQ7fnYLmliXeOEwZ72yn6gK2V6p/xpu+W0VjuSkqhqz2Q6EKyX5BHCayMXwo
 oTDjrYA0lHe2yrd5HCBYVuWnfbalI6c7aTDLgGp9IZEAhM6SFpSa6dsXOJuSU2UZV8ET
 OAiw==
X-Gm-Message-State: AOJu0YyBYAY7Ym7mQ8xnx2j5VbnqYtJPmVDw9DXoFP3f6QuRzycWVYTR
 NgTnFvS2t4ObwmAwrBx2JQQ8trGcHoHz40H+1QltliXkADayNFrfNESuj6nTZzUCOn6n8ZRVNMO
 xdGKw
X-Gm-Gg: AR+sD13f3SVqtyj+coE8NaGjw/jKdN1fOXjLbRWkhXd0LWjQxIQ2JTfvQ1uN6uz/T7W
 /YKMjE1cZ39lOtZAtdb0TBeO6iNLJUUenCYpo1GD23D6MTVL/SQr3XJhF71ErlOv0xX1x+3QPK8
 Dwo+4RMPE8njiWQ782Rpvkfue+QL89XgCLPju+BSOjObuZvEVIWEItZr73Xo8ysXh0YmTbqwYIM
 /KdksUoVMlGObj4IZ/OpijvUl9BiOcfiyLxnbWVUEhdvBkx9YrNGOVsbZQJiAM2mIDs+akOS3kK
 tjt81beoYSGmGJkdg7xQ6rZWdVPSSQTOsQbrv2usZLCyQp32gFLkxUeZf+gWbtCpBlm9gtl157Z
 jLrcXoTj7i+d0tUcWUghG78m/jew0AJXC58n4xC67nhDDNr+0F0D6AiTuh2UjJDoG27U6lmrEZm
 3qtgMuRYHkXvyor7bi8Tvnm88lrnWH5tYIKyR74/yys0D5dLB9nlG50NgpvHCBRTEQOhg6PPplw
 M1noSGYWKteIj9g2+lTon+Aboc=
X-Received: by 2002:a05:6a21:3398:b0:3c3:6c90:65b1 with SMTP id
 adf61e73a8af0-3c8b0ca960amr9312886637.25.1785347870593; 
 Wed, 29 Jul 2026 10:57:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [RFC 30/32] eal: remove rte_smp_XX
Date: Wed, 29 Jul 2026 10:54:23 -0700
Message-ID: <20260729175715.165120-31-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

