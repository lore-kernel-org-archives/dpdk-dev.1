Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37004CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5828240687;
	Thu, 21 May 2026 06:20:57 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id EC00B40676
 for <dev@dpdk.org>; Thu, 21 May 2026 06:20:54 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30246cfd41aso4582833eec.1
 for <dev@dpdk.org>; Wed, 20 May 2026 21:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779337254;
 x=1779942054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyJ1uOdmjDKvtlXCZCdxKlYkwxpwxKjUMTfxIQkCukw=;
 b=Mo0cCCfe/LmF5wx9LogAyM7C4NSFl0vmdBSwFa49PoAaCvP8kVZDRG0IG7Qe/Fw6Pb
 XIPOhek/6z+hkdcF90qnTPYKN8wMLu9r+0UboykBcs0LDP+JkhxnDcbEnSKgQ1OmZJe3
 se9cL8ZSGXjhiSIu+2o9BALFWGsgGDc7o0pzMNZfLz4vOMg34zRl3fDUBzBwORt0lky1
 lgnaYxtvntGvGM2ETdolJ/zhVnun4Rjyu6ZdwJFwn9nOGVU08gJ+TGfYm0Jwphjg04PQ
 exkV3pPM/GV4P0vlO78CF6qrfm9oNS1UfXW83B9OLmxD3ROueSydpj7CM+tYLmYaMr5q
 qOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779337254; x=1779942054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uyJ1uOdmjDKvtlXCZCdxKlYkwxpwxKjUMTfxIQkCukw=;
 b=OTGBJF7s1KIE26HDdiq9GfEX3AU5i/6+gKUsLl/uJ4hb4qJMZAmvq9NvnMqghoJ5Qq
 xdICEi7j5SADRvRlOM9TfM88Z/8sdwVCbYvPGy4FJ9XLciAAeGmKuvFJrezL9GwKlrNS
 YF2POB3VZwt/w62Dqi+ftDhNnP4U9BvRnZa2T6oJ8J/0NSJ7/9LIwRh86332xiaooSaK
 GawazH5qIar7eGy4vARAKAaI74mWuvgiQUc0TcnJXMawH8CQpnZ9H/E6wcAwnYmGqfbb
 +yPbm9ZKIB9bC/vgFESIyJGMpSh5ou3b9yogT0+834bTPWnjq9rF07Y3BOmOu6mpYbeG
 bXdw==
X-Gm-Message-State: AOJu0YyXWFr9oUAvLKi7qTewscB6zT1jR3IaMQw4vDVvA6FtUl7npMz0
 z+56E+v2cNG7Ak7S5dM4s3BlKlLN35UEK3Kyxu9Vi117D1qMq1R8xlAjXoJC4IxqQYGR0oC9ODy
 fEI3W
X-Gm-Gg: Acq92OFWmrfVKmh40W2Y7xnzW4rSv4co5UwheLJ2BL6pofvNP2/IpNkRQceAvEWzSxW
 eJNPQMO83RmLCcEvzy3lwfPdnQr9uP/5zjnN4ggvjIo3Xnsr72LRQx1s4O8JIlNNj6uj6E6SXfx
 qkGfPyWPFuJPzNXuZ4mkJVD0c4JMesqCtpdGucdCcl2mEG6gdVVQ2k7owRtJSyiA868O22dXPiA
 K8uPoSMB22C7zpTzNMdtixxjkRzjfSMW7PNxYSnEYQylBEV9xk650MbZH5bCHXLoMACy+xEme49
 I2ksjyNs+k+0N3hZp/uyZA4ArQwwKXezm+8BsXfGgxTNklNxOVjYPZTBKc5IG0Urx4nNEv1ssCC
 4t5LgiRLK15OatZFh8gVz10qsoPOZpKEBzBrv4euD+ZBZ4fGnauosedQvagLyfFp/joOTnPR+X4
 RB2OfBqBSUJYOlR/lgX3JKEamA7bLbcUmSsilPgab9jIHiNKpz6amJBAF/5cTG4quQHIanb4cQ
X-Received: by 2002:a05:7300:6428:b0:304:2176:a871 with SMTP id
 5a478bee46e88-3042ed302cemr921682eec.0.1779337253837; 
 Wed, 20 May 2026 21:20:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm24347748eec.5.2026.05.20.21.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:20:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Bibo Mao <maobibo@loongson.cn>, Sun Yuechi <sunyuechi@iscas.ac.cn>,
 David Christensen <drc@linux.ibm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [RFC 7/7] config: use RTE_FORCE_INTRINSICS on all platforms
Date: Wed, 20 May 2026 21:17:07 -0700
Message-ID: <20260521042043.1590536-8-stephen@networkplumber.org>
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

Next step is to deprecate the rte_atomicNN_*() family. Rather than
maintaining both the inline asm and intrinsic fallbacks, drop the
asm paths and use intrinsics everywhere. The RTE_FORCE_INTRINSICS
config option is removed.

This also retires the asm-based byteorder bswap and spinlock
implementations, which were guarded by the same option.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/arm/meson.build                   |   1 -
 config/loongarch/meson.build             |   1 -
 config/meson.build                       |   3 -
 config/riscv/meson.build                 |   1 -
 doc/guides/rel_notes/release_26_07.rst   |   5 +
 lib/eal/arm/include/rte_atomic_32.h      |   3 -
 lib/eal/arm/include/rte_atomic_64.h      |   3 -
 lib/eal/arm/include/rte_byteorder.h      |   3 -
 lib/eal/arm/include/rte_spinlock.h       |   3 -
 lib/eal/include/generic/rte_atomic.h     |  58 -------
 lib/eal/include/generic/rte_byteorder.h  |   2 -
 lib/eal/include/generic/rte_spinlock.h   |  10 --
 lib/eal/loongarch/include/rte_atomic.h   |   3 -
 lib/eal/loongarch/include/rte_spinlock.h |   3 -
 lib/eal/ppc/include/rte_atomic.h         | 173 ---------------------
 lib/eal/ppc/include/rte_byteorder.h      |  13 --
 lib/eal/ppc/include/rte_spinlock.h       |  26 ----
 lib/eal/riscv/include/rte_atomic.h       |   3 -
 lib/eal/riscv/include/rte_spinlock.h     |   3 -
 lib/eal/x86/include/rte_atomic.h         | 172 ---------------------
 lib/eal/x86/include/rte_atomic_32.h      | 188 -----------------------
 lib/eal/x86/include/rte_atomic_64.h      | 157 -------------------
 lib/eal/x86/include/rte_byteorder.h      |  49 ------
 lib/eal/x86/include/rte_spinlock.h       |  49 ------
 24 files changed, 5 insertions(+), 927 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 5a9c16b9b1..08fff73599 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -837,7 +837,6 @@ socs = {
 }
 
 dpdk_conf.set('RTE_ARCH_ARM', 1)
-dpdk_conf.set('RTE_FORCE_INTRINSICS', 1)
 
 update_flags = false
 soc_flags = []
diff --git a/config/loongarch/meson.build b/config/loongarch/meson.build
index 99dabef203..1623cdb571 100644
--- a/config/loongarch/meson.build
+++ b/config/loongarch/meson.build
@@ -6,7 +6,6 @@ if not dpdk_conf.get('RTE_ARCH_64')
 endif
 dpdk_conf.set('RTE_ARCH', 'loongarch')
 dpdk_conf.set('RTE_ARCH_LOONGARCH', 1)
-dpdk_conf.set('RTE_FORCE_INTRINSICS', 1)
 
 machine_args_generic = [
     ['default', ['-march=loongarch64']],
diff --git a/config/meson.build b/config/meson.build
index 9ba7b9a338..934abf04f2 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -29,9 +29,6 @@ is_ms_compiler = is_windows and (cc.get_id() == 'msvc')
 is_ms_linker = is_windows and (cc.get_id() == 'clang' or is_ms_compiler)
 
 if is_ms_compiler
-    # force the use of intrinsics the MSVC compiler (except x86)
-    # does not support inline assembly
-    dpdk_conf.set('RTE_FORCE_INTRINSICS', 1)
 
     # force the use of C++11 memory model in lib/ring
     dpdk_conf.set('RTE_USE_C11_MEM_MODEL', true)
diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index a06429a1e2..5dba613973 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -16,7 +16,6 @@ endif
 
 dpdk_conf.set('RTE_ARCH', 'riscv')
 dpdk_conf.set('RTE_ARCH_RISCV', 1)
-dpdk_conf.set('RTE_FORCE_INTRINSICS', 1)
 
 # common flags to all riscv builds, with lowest priority
 flags_common = [
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..9378cf1d36 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -92,6 +92,11 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Changed to use stdatomic intrinsics on all platforms.**
+
+  The config option ``RTE_FORCE_INTRINSICS`` has been removed.
+  Architecture specific code has been replaced with stdatomic.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/arm/include/rte_atomic_32.h b/lib/eal/arm/include/rte_atomic_32.h
index 3809ddefb7..a5ee63a2c7 100644
--- a/lib/eal/arm/include/rte_atomic_32.h
+++ b/lib/eal/arm/include/rte_atomic_32.h
@@ -5,9 +5,6 @@
 #ifndef _RTE_ATOMIC_ARM32_H_
 #define _RTE_ATOMIC_ARM32_H_
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
 
 #include "generic/rte_atomic.h"
 
diff --git a/lib/eal/arm/include/rte_atomic_64.h b/lib/eal/arm/include/rte_atomic_64.h
index c9b41f6212..01412020e7 100644
--- a/lib/eal/arm/include/rte_atomic_64.h
+++ b/lib/eal/arm/include/rte_atomic_64.h
@@ -6,9 +6,6 @@
 #ifndef _RTE_ATOMIC_ARM64_H_
 #define _RTE_ATOMIC_ARM64_H_
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
 
 #include "generic/rte_atomic.h"
 #include <rte_branch_prediction.h>
diff --git a/lib/eal/arm/include/rte_byteorder.h b/lib/eal/arm/include/rte_byteorder.h
index a0aaff4a28..ffaaf726a4 100644
--- a/lib/eal/arm/include/rte_byteorder.h
+++ b/lib/eal/arm/include/rte_byteorder.h
@@ -5,9 +5,6 @@
 #ifndef _RTE_BYTEORDER_ARM_H_
 #define _RTE_BYTEORDER_ARM_H_
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
 
 #include <stdint.h>
 #include <rte_common.h>
diff --git a/lib/eal/arm/include/rte_spinlock.h b/lib/eal/arm/include/rte_spinlock.h
index a5d01b0d21..47820e5e1a 100644
--- a/lib/eal/arm/include/rte_spinlock.h
+++ b/lib/eal/arm/include/rte_spinlock.h
@@ -5,9 +5,6 @@
 #ifndef _RTE_SPINLOCK_ARM_H_
 #define _RTE_SPINLOCK_ARM_H_
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
 
 #include <rte_common.h>
 #include "generic/rte_spinlock.h"
diff --git a/lib/eal/include/generic/rte_atomic.h b/lib/eal/include/generic/rte_atomic.h
index 4e9d230f85..06b6acf9eb 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -171,13 +171,11 @@ rte_smp_rmb(void)
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
@@ -197,13 +195,11 @@ rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
 static inline uint16_t
 rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline uint16_t
 rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
 {
 	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -296,13 +292,11 @@ rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
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
@@ -313,13 +307,11 @@ rte_atomic16_inc(rte_atomic16_t *v)
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
@@ -375,13 +367,11 @@ rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
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
@@ -396,13 +386,11 @@ static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
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
@@ -417,12 +405,10 @@ static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
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
@@ -456,13 +442,11 @@ static inline void rte_atomic16_clear(rte_atomic16_t *v)
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
@@ -482,13 +466,11 @@ rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
 static inline uint32_t
 rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline uint32_t
 rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
 {
 	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -581,13 +563,11 @@ rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
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
@@ -598,13 +578,11 @@ rte_atomic32_inc(rte_atomic32_t *v)
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
@@ -660,13 +638,11 @@ rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
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
@@ -681,13 +657,11 @@ static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
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
@@ -702,12 +676,10 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
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
@@ -740,13 +712,11 @@ static inline void rte_atomic32_clear(rte_atomic32_t *v)
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
@@ -766,13 +736,11 @@ rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
 static inline uint64_t
 rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline uint64_t
 rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
 {
 	return rte_atomic_exchange_explicit(dst, val, rte_memory_order_seq_cst);
 }
-#endif
 
 /**
  * The atomic counter structure.
@@ -795,7 +763,6 @@ typedef struct {
 static inline void
 rte_atomic64_init(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic64_init(rte_atomic64_t *v)
 {
@@ -812,7 +779,6 @@ rte_atomic64_init(rte_atomic64_t *v)
 	}
 #endif
 }
-#endif
 
 /**
  * Atomically read a 64-bit counter.
@@ -825,7 +791,6 @@ rte_atomic64_init(rte_atomic64_t *v)
 static inline int64_t
 rte_atomic64_read(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int64_t
 rte_atomic64_read(rte_atomic64_t *v)
 {
@@ -844,7 +809,6 @@ rte_atomic64_read(rte_atomic64_t *v)
 	return tmp;
 #endif
 }
-#endif
 
 /**
  * Atomically set a 64-bit counter.
@@ -857,7 +821,6 @@ rte_atomic64_read(rte_atomic64_t *v)
 static inline void
 rte_atomic64_set(rte_atomic64_t *v, int64_t new_value);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 {
@@ -874,7 +837,6 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 	}
 #endif
 }
-#endif
 
 /**
  * Atomically add a 64-bit value to a counter.
@@ -887,14 +849,12 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
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
@@ -907,14 +867,12 @@ rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
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
@@ -925,13 +883,11 @@ rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
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
@@ -942,13 +898,11 @@ rte_atomic64_inc(rte_atomic64_t *v)
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
@@ -966,14 +920,12 @@ rte_atomic64_dec(rte_atomic64_t *v)
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
@@ -991,14 +943,12 @@ rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
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
@@ -1013,12 +963,10 @@ rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
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
@@ -1033,12 +981,10 @@ static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
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
@@ -1053,12 +999,10 @@ static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
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
@@ -1068,12 +1012,10 @@ static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
  */
 static inline void rte_atomic64_clear(rte_atomic64_t *v);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void rte_atomic64_clear(rte_atomic64_t *v)
 {
 	rte_atomic64_set(v, 0);
 }
-#endif
 
 #endif
 
diff --git a/lib/eal/include/generic/rte_byteorder.h b/lib/eal/include/generic/rte_byteorder.h
index 7973d6326f..e8b5f0ab86 100644
--- a/lib/eal/include/generic/rte_byteorder.h
+++ b/lib/eal/include/generic/rte_byteorder.h
@@ -239,7 +239,6 @@ static uint64_t rte_be_to_cpu_64(rte_be64_t x);
 
 #endif /* __DOXYGEN__ */
 
-#ifdef RTE_FORCE_INTRINSICS
 #ifndef RTE_TOOLCHAIN_MSVC
 #define rte_bswap16(x) __builtin_bswap16(x)
 
@@ -253,7 +252,6 @@ static uint64_t rte_be_to_cpu_64(rte_be64_t x);
 
 #define rte_bswap64(x) _byteswap_uint64(x)
 #endif
-#endif
 
 #ifdef __cplusplus
 }
diff --git a/lib/eal/include/generic/rte_spinlock.h b/lib/eal/include/generic/rte_spinlock.h
index dd3d2d046c..13916f88b3 100644
--- a/lib/eal/include/generic/rte_spinlock.h
+++ b/lib/eal/include/generic/rte_spinlock.h
@@ -13,8 +13,6 @@
  * This kind of lock simply waits in a loop
  * repeatedly checking until the lock becomes available.
  *
- * Some functions may have an architecture-specific implementation
- * if RTE_FORCE_INTRINSICS is disabled.
  * The hardware transactional memory (lock elision) functions have _tm suffix
  * and are implemented in architecture-specific files.
  *
@@ -22,9 +20,7 @@
  */
 
 #include <rte_lcore.h>
-#ifdef RTE_FORCE_INTRINSICS
 #include <rte_common.h>
-#endif
 #include <rte_debug.h>
 #include <rte_lock_annotations.h>
 #include <rte_pause.h>
@@ -68,7 +64,6 @@ static inline void
 rte_spinlock_lock(rte_spinlock_t *sl)
 	__rte_acquire_capability(sl);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_spinlock_lock(rte_spinlock_t *sl)
 	__rte_no_thread_safety_analysis
@@ -82,7 +77,6 @@ rte_spinlock_lock(rte_spinlock_t *sl)
 		exp = 0;
 	}
 }
-#endif
 
 /**
  * Release the spinlock.
@@ -94,14 +88,12 @@ static inline void
 rte_spinlock_unlock(rte_spinlock_t *sl)
 	__rte_release_capability(sl);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline void
 rte_spinlock_unlock(rte_spinlock_t *sl)
 	__rte_no_thread_safety_analysis
 {
 	rte_atomic_store_explicit(&sl->locked, 0, rte_memory_order_release);
 }
-#endif
 
 /**
  * Try to take the lock.
@@ -116,7 +108,6 @@ static inline int
 rte_spinlock_trylock(rte_spinlock_t *sl)
 	__rte_try_acquire_capability(true, sl);
 
-#ifdef RTE_FORCE_INTRINSICS
 static inline int
 rte_spinlock_trylock(rte_spinlock_t *sl)
 	__rte_no_thread_safety_analysis
@@ -125,7 +116,6 @@ rte_spinlock_trylock(rte_spinlock_t *sl)
 	return rte_atomic_compare_exchange_strong_explicit(&sl->locked, &exp, 1,
 				rte_memory_order_acquire, rte_memory_order_relaxed);
 }
-#endif
 
 /**
  * Test if the lock is taken.
diff --git a/lib/eal/loongarch/include/rte_atomic.h b/lib/eal/loongarch/include/rte_atomic.h
index 49e0c67020..ed42e36843 100644
--- a/lib/eal/loongarch/include/rte_atomic.h
+++ b/lib/eal/loongarch/include/rte_atomic.h
@@ -5,9 +5,6 @@
 #ifndef RTE_ATOMIC_LOONGARCH_H
 #define RTE_ATOMIC_LOONGARCH_H
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
 
 #include <rte_common.h>
 #include "generic/rte_atomic.h"
diff --git a/lib/eal/loongarch/include/rte_spinlock.h b/lib/eal/loongarch/include/rte_spinlock.h
index 38f00f631d..bc9569b8e3 100644
--- a/lib/eal/loongarch/include/rte_spinlock.h
+++ b/lib/eal/loongarch/include/rte_spinlock.h
@@ -12,9 +12,6 @@
 extern "C" {
 #endif
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
 
 static inline int rte_tm_supported(void)
 {
diff --git a/lib/eal/ppc/include/rte_atomic.h b/lib/eal/ppc/include/rte_atomic.h
index 1da5afccbf..0e64db2a35 100644
--- a/lib/eal/ppc/include/rte_atomic.h
+++ b/lib/eal/ppc/include/rte_atomic.h
@@ -37,179 +37,6 @@ rte_atomic_thread_fence(rte_memory_order memorder)
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
diff --git a/lib/eal/ppc/include/rte_byteorder.h b/lib/eal/ppc/include/rte_byteorder.h
index 6c11fce9dc..e1e74f83e8 100644
--- a/lib/eal/ppc/include/rte_byteorder.h
+++ b/lib/eal/ppc/include/rte_byteorder.h
@@ -49,19 +49,6 @@ static inline uint64_t rte_arch_bswap64(uint64_t _x)
 		((_x << 40) & (0xffULL << 48)) | ((_x << 56));
 }
 
-#ifndef RTE_FORCE_INTRINSICS
-#define rte_bswap16(x) ((uint16_t)(__builtin_constant_p(x) ?		\
-				   rte_constant_bswap16(x) :		\
-				   rte_arch_bswap16(x)))
-
-#define rte_bswap32(x) ((uint32_t)(__builtin_constant_p(x) ?		\
-				   rte_constant_bswap32(x) :		\
-				   rte_arch_bswap32(x)))
-
-#define rte_bswap64(x) ((uint64_t)(__builtin_constant_p(x) ?		\
-				   rte_constant_bswap64(x) :		\
-				   rte_arch_bswap64(x)))
-#endif
 
 /* Power 8 have both little endian and big endian mode
  * Power 7 only support big endian
diff --git a/lib/eal/ppc/include/rte_spinlock.h b/lib/eal/ppc/include/rte_spinlock.h
index 6d242db35d..76afa52413 100644
--- a/lib/eal/ppc/include/rte_spinlock.h
+++ b/lib/eal/ppc/include/rte_spinlock.h
@@ -15,32 +15,6 @@ extern "C" {
 
 /* Fixme: Use intrinsics to implement the spinlock on Power architecture */
 
-#ifndef RTE_FORCE_INTRINSICS
-
-static inline void
-rte_spinlock_lock(rte_spinlock_t *sl)
-	__rte_no_thread_safety_analysis
-{
-	while (__sync_lock_test_and_set(&sl->locked, 1))
-		while (sl->locked)
-			rte_pause();
-}
-
-static inline void
-rte_spinlock_unlock(rte_spinlock_t *sl)
-	__rte_no_thread_safety_analysis
-{
-	__sync_lock_release(&sl->locked);
-}
-
-static inline int
-rte_spinlock_trylock(rte_spinlock_t *sl)
-	__rte_no_thread_safety_analysis
-{
-	return __sync_lock_test_and_set(&sl->locked, 1) == 0;
-}
-
-#endif
 
 static inline int rte_tm_supported(void)
 {
diff --git a/lib/eal/riscv/include/rte_atomic.h b/lib/eal/riscv/include/rte_atomic.h
index dd10ad5127..bc7d446df5 100644
--- a/lib/eal/riscv/include/rte_atomic.h
+++ b/lib/eal/riscv/include/rte_atomic.h
@@ -8,9 +8,6 @@
 #ifndef RTE_ATOMIC_RISCV_H
 #define RTE_ATOMIC_RISCV_H
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
 
 #include <stdint.h>
 #include <rte_common.h>
diff --git a/lib/eal/riscv/include/rte_spinlock.h b/lib/eal/riscv/include/rte_spinlock.h
index 5fe4980e44..5df97ac5ca 100644
--- a/lib/eal/riscv/include/rte_spinlock.h
+++ b/lib/eal/riscv/include/rte_spinlock.h
@@ -8,9 +8,6 @@
 #ifndef RTE_SPINLOCK_RISCV_H
 #define RTE_SPINLOCK_RISCV_H
 
-#ifndef RTE_FORCE_INTRINSICS
-#  error Platform must be built with RTE_FORCE_INTRINSICS
-#endif
 
 #include <rte_common.h>
 #include "generic/rte_spinlock.h"
diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_atomic.h
index a850b0257c..f4d39ce4fe 100644
--- a/lib/eal/x86/include/rte_atomic.h
+++ b/lib/eal/x86/include/rte_atomic.h
@@ -102,178 +102,6 @@ rte_atomic_thread_fence(rte_memory_order memorder)
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
 
diff --git a/lib/eal/x86/include/rte_byteorder.h b/lib/eal/x86/include/rte_byteorder.h
index bcf4a02225..5a9e5f0762 100644
--- a/lib/eal/x86/include/rte_byteorder.h
+++ b/lib/eal/x86/include/rte_byteorder.h
@@ -18,55 +18,6 @@ extern "C" {
 #define RTE_BYTE_ORDER RTE_LITTLE_ENDIAN
 #endif
 
-#ifndef RTE_FORCE_INTRINSICS
-/*
- * An architecture-optimized byte swap for a 16-bit value.
- *
- * Do not use this function directly. The preferred function is rte_bswap16().
- */
-static inline uint16_t rte_arch_bswap16(uint16_t _x)
-{
-	uint16_t x = _x;
-	asm volatile ("xchgb %b[x1],%h[x2]"
-		      : [x1] "=Q" (x)
-		      : [x2] "0" (x)
-		      );
-	return x;
-}
-
-/*
- * An architecture-optimized byte swap for a 32-bit value.
- *
- * Do not use this function directly. The preferred function is rte_bswap32().
- */
-static inline uint32_t rte_arch_bswap32(uint32_t _x)
-{
-	uint32_t x = _x;
-	asm volatile ("bswap %[x]"
-		      : [x] "+r" (x)
-		      );
-	return x;
-}
-
-#define rte_bswap16(x) ((uint16_t)(__builtin_constant_p(x) ?		\
-				   rte_constant_bswap16(x) :		\
-				   rte_arch_bswap16(x)))
-
-#define rte_bswap32(x) ((uint32_t)(__builtin_constant_p(x) ?		\
-				   rte_constant_bswap32(x) :		\
-				   rte_arch_bswap32(x)))
-
-#define rte_bswap64(x) ((uint64_t)(__builtin_constant_p(x) ?		\
-				   rte_constant_bswap64(x) :		\
-				   rte_arch_bswap64(x)))
-
-#ifdef RTE_ARCH_I686
-#include "rte_byteorder_32.h"
-#else
-#include "rte_byteorder_64.h"
-#endif
-
-#endif /* !RTE_FORCE_INTRINSICS */
 
 #ifdef __cplusplus
 }
diff --git a/lib/eal/x86/include/rte_spinlock.h b/lib/eal/x86/include/rte_spinlock.h
index 273bbdc39c..104da6bd78 100644
--- a/lib/eal/x86/include/rte_spinlock.h
+++ b/lib/eal/x86/include/rte_spinlock.h
@@ -19,55 +19,6 @@ extern "C" {
 #define RTE_RTM_MAX_RETRIES (20)
 #define RTE_XABORT_LOCK_BUSY (0xff)
 
-#ifndef RTE_FORCE_INTRINSICS
-static inline void
-rte_spinlock_lock(rte_spinlock_t *sl)
-	__rte_no_thread_safety_analysis
-{
-	int lock_val = 1;
-	asm volatile (
-			"1:\n"
-			"xchg %[locked], %[lv]\n"
-			"test %[lv], %[lv]\n"
-			"jz 3f\n"
-			"2:\n"
-			"pause\n"
-			"cmpl $0, %[locked]\n"
-			"jnz 2b\n"
-			"jmp 1b\n"
-			"3:\n"
-			: [locked] "=m" (sl->locked), [lv] "=q" (lock_val)
-			: "[lv]" (lock_val)
-			: "memory");
-}
-
-static inline void
-rte_spinlock_unlock (rte_spinlock_t *sl)
-	__rte_no_thread_safety_analysis
-{
-	int unlock_val = 0;
-	asm volatile (
-			"xchg %[locked], %[ulv]\n"
-			: [locked] "=m" (sl->locked), [ulv] "=q" (unlock_val)
-			: "[ulv]" (unlock_val)
-			: "memory");
-}
-
-static inline int
-rte_spinlock_trylock (rte_spinlock_t *sl)
-	__rte_no_thread_safety_analysis
-{
-	int lockval = 1;
-
-	asm volatile (
-			"xchg %[locked], %[lockval]"
-			: [locked] "=m" (sl->locked), [lockval] "=q" (lockval)
-			: "[lockval]" (lockval)
-			: "memory");
-
-	return lockval == 0;
-}
-#endif
 
 extern uint8_t rte_rtm_supported;
 
-- 
2.53.0

