Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374FCD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:28:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8333140DFB;
	Wed, 27 May 2026 01:26:25 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 77E4440DC9
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:15 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso3066165eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837974;
 x=1780442774; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N47md55n6K+7tvxsGW9hnPHC/P3YNtMXZb3dpDopvwg=;
 b=uqqK5pT8h4uD4F26Lp7sJHsor13TdD9c6TRulLKORZvi12QQxXj/bhw3tQB6JA4AnS
 6a/rfg23xv62fTwu4s5c6P9aNehfGXrZVKkDKeozqexbgKQ57SEUoT/s6WTk39GoLB4s
 qPrWu11fd6LwHBj+RiftppHneLZ65B373ngSyjF+caPqdlrEnJc1FrfF/QApPDmZlEH8
 REc9mDgNzgk4UZOzyKJv0WdO/n23EF2yDmFbfsbk9Mff1I7Si/q9oPiobuLvgeB5z0hz
 1ndvZmj48SOmu881iw7q5VsTKKHobVruki6pkpzfR+c/hlLt4WBdspUt0BITp0OeJ/yH
 B+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837974; x=1780442774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N47md55n6K+7tvxsGW9hnPHC/P3YNtMXZb3dpDopvwg=;
 b=jQ6RPhgftUxdTYpK5oFEwtwV7O1LgI8+nALFcgBgAQYuxvy9MJ7NndAWpBa6WHlgLz
 bgfu2c6fYBYHI17FPUt+S0Z79VcgTAJ2/Bg0OVzWZmIsxByuyKuLgyQhs2AUgi8nYwUF
 qEWq78QRJVoGNTIF/fVdZaiycyrbq6FlD7skho6iX+n8QZTn1bim1oInsI5l2MBNF/7T
 XGV3fd5SA3n281iIfWa4bYPx1rW/KdpuzCij2seAG3PEh0IkedkARY7baIPl+vy1YnaU
 yObUsoEQ4BFtMoVZQWJmu2v+kcityzyu2CPhbo7CtVfLoJsr+bL4KtO2VkRJYLzeWrL6
 y1Qw==
X-Gm-Message-State: AOJu0YznxRhefsvFPOGxy0t7np9KHV4Fk9SiZzT3NFyKOzf6ekIcXz/g
 /6Jzogjqz37UEbXgubG5Acm1Dp8YwR1aKb0CjbGZl9d1nKjDRDwB9APHr2N3tC8bZMdeeyMKKBE
 7evM/
X-Gm-Gg: Acq92OGoGS7670HJuZiHneQOwAfCEmnHJGscsAxTXc6G2R7ZUaNUt4HTMDSVlChRWgs
 RByg95V1Gi1iI1/+9KDRl4tX8TZevonhMhuI7BW5seplkS9bccOS6eREtmV9FVk2cno9h5Nkk6G
 ZXacg46sOOBzU8W4sgR958ZWg2/29d/3ttaVwrhUCN9ok7W7FaVtCI9Dex5jnvSu1NXrJhzzzlL
 PbZgIiID6zCS+QAkSD0pJrcslLoAYJtSBRyYBhDzn7sXPtkLGyejSp3yqi5PIV8RBYLBBo/Z0eS
 vnbnuEAs8riZ1nd11Uw5yZ8XfP/Swnev0oYzWoPPit1QRcjgydgsXfBbGWkQssfA3ieQbe7hSVV
 0Tgo4vSH6qwCYNKoznjTpSTbd7TE/44wlVPG49bSKi3IU7w9FZUq2e9NR+TuWURJhIPRV23/5L3
 Df/ktR8qQN8WEtdclOnO2G6EW/9NwBV0ZG+NL1FvgO8lHYMBQOh3JqUkqsLqfZutLCLPL57RZl
X-Received: by 2002:a05:7300:cb86:b0:2ed:e16:6b4a with SMTP id
 5a478bee46e88-304491ebd02mr10147590eec.32.1779837974380; 
 Tue, 26 May 2026 16:26:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v4 27/27] eal: mark rte_atomicNN as deprecated
Date: Tue, 26 May 2026 16:24:17 -0700
Message-ID: <20260526232542.620966-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

The decision to deprecate the rte_atomicNN functions was made
back in 2021, but in-tree code continued to use them.
Now thatall in-tree callers have been converted to C11 stdatomic,
markthe functions with __rte_deprecated so any remaining user code
will see the deprecation warning.

Since any new use of rte_atomicNN will be caught by the compiler,
there is no longer any need to check for it in checkpatches.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh               |   8 --
 doc/guides/rel_notes/deprecation.rst   |   4 +-
 doc/guides/rel_notes/release_26_07.rst |   4 +
 lib/eal/include/generic/rte_atomic.h   | 100 ++++++++++++++-----------
 lib/eal/include/rte_common.h           |   2 +
 5 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 81bb0fe4e8..a0cbbf09db 100755
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
 	# refrain from using compiler __sync_xxx builtins
 	awk -v FOLDERS="lib drivers app examples" \
 		-v EXPRESSIONS="__sync_.*\\\(" \
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 2190419f79..5d9226d551 100644
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
 
 * lib: will fix extending some enum/define breaking the ABI. There are multiple
   samples in DPDK that enum/define terminated with a ``.*MAX.*`` value which is
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 58d782f77e..92c12c83a4 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -106,6 +106,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* atomic: Marked the ``rte_atomicNN`` functions as deprecated.
+  As previously announced these functions were intended to be deprecated
+  but was not being enforced.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/include/generic/rte_atomic.h b/lib/eal/include/generic/rte_atomic.h
index 1b04b43cbb..1a113c3df2 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -152,6 +152,14 @@ rte_smp_rmb(void)
 	rte_atomic_thread_fence(rte_memory_order_acquire);
 }
 
+
+/*
+ * The rte_atomicNN_* APIs defined below are deprecated in favour of C11 atomics.
+ * Suppress the deprecation warnings for the inlines to allow inter-related usage.
+ */
+__rte_diagnostic_push
+__rte_allow_deprecated
+
 /*------------------------- 16 bit atomic operations -------------------------*/
 
 #ifndef RTE_TOOLCHAIN_MSVC
@@ -172,7 +180,7 @@ rte_smp_rmb(void)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
+static __rte_deprecated inline int
 rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
@@ -193,7 +201,7 @@ rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
  * @return
  *   The original value at that location
  */
-static inline uint16_t
+static __rte_deprecated inline uint16_t
 rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
 {
 	return rte_atomic_exchange_explicit((volatile __rte_atomic uint16_t *)dst,
@@ -218,7 +226,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_init(rte_atomic16_t *v)
 {
 	v->cnt = 0;
@@ -232,7 +240,7 @@ rte_atomic16_init(rte_atomic16_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_read(const rte_atomic16_t *v)
 {
 	return v->cnt;
@@ -246,7 +254,7 @@ rte_atomic16_read(const rte_atomic16_t *v)
  * @param new_value
  *   The new value for the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_set(rte_atomic16_t *v, int16_t new_value)
 {
 	v->cnt = new_value;
@@ -260,7 +268,7 @@ rte_atomic16_set(rte_atomic16_t *v, int16_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_add(rte_atomic16_t *v, int16_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, inc,
@@ -275,7 +283,7 @@ rte_atomic16_add(rte_atomic16_t *v, int16_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, dec,
@@ -288,7 +296,7 @@ rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_inc(rte_atomic16_t *v)
 {
 	rte_atomic16_add(v, 1);
@@ -300,7 +308,7 @@ rte_atomic16_inc(rte_atomic16_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_dec(rte_atomic16_t *v)
 {
 	rte_atomic16_sub(v, 1);
@@ -319,7 +327,7 @@ rte_atomic16_dec(rte_atomic16_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_add_return(rte_atomic16_t *v, int16_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, inc,
@@ -340,7 +348,7 @@ rte_atomic16_add_return(rte_atomic16_t *v, int16_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, dec,
@@ -358,7 +366,7 @@ rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
  * @return
  *   True if the result after the increment operation is 0; false otherwise.
  */
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) + 1 == 0;
@@ -375,7 +383,7 @@ static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
  * @return
  *   True if the result after the decrement operation is 0; false otherwise.
  */
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) - 1 == 0;
@@ -392,7 +400,7 @@ static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
 {
 	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
 }
@@ -403,7 +411,7 @@ static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic16_clear(rte_atomic16_t *v)
+static __rte_deprecated inline void rte_atomic16_clear(rte_atomic16_t *v)
 {
 	v->cnt = 0;
 }
@@ -426,7 +434,7 @@ static inline void rte_atomic16_clear(rte_atomic16_t *v)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
+static __rte_deprecated inline int
 rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
@@ -447,7 +455,7 @@ rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
  * @return
  *   The original value at that location
  */
-static inline uint32_t
+static __rte_deprecated inline uint32_t
 rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
 {
 	return rte_atomic_exchange_explicit((volatile __rte_atomic uint32_t *)dst,
@@ -472,7 +480,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_init(rte_atomic32_t *v)
 {
 	v->cnt = 0;
@@ -486,7 +494,7 @@ rte_atomic32_init(rte_atomic32_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_read(const rte_atomic32_t *v)
 {
 	return v->cnt;
@@ -500,7 +508,7 @@ rte_atomic32_read(const rte_atomic32_t *v)
  * @param new_value
  *   The new value for the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_set(rte_atomic32_t *v, int32_t new_value)
 {
 	v->cnt = new_value;
@@ -514,7 +522,7 @@ rte_atomic32_set(rte_atomic32_t *v, int32_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_add(rte_atomic32_t *v, int32_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, inc,
@@ -529,7 +537,7 @@ rte_atomic32_add(rte_atomic32_t *v, int32_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, dec,
@@ -542,7 +550,7 @@ rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_inc(rte_atomic32_t *v)
 {
 	rte_atomic32_add(v, 1);
@@ -554,7 +562,7 @@ rte_atomic32_inc(rte_atomic32_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_dec(rte_atomic32_t *v)
 {
 	rte_atomic32_sub(v,1);
@@ -573,7 +581,7 @@ rte_atomic32_dec(rte_atomic32_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_add_return(rte_atomic32_t *v, int32_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, inc,
@@ -594,7 +602,7 @@ rte_atomic32_add_return(rte_atomic32_t *v, int32_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, dec,
@@ -612,7 +620,7 @@ rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
  * @return
  *   True if the result after the increment operation is 0; false otherwise.
  */
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) + 1 == 0;
@@ -629,7 +637,7 @@ static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
  * @return
  *   True if the result after the decrement operation is 0; false otherwise.
  */
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) - 1 == 0;
@@ -646,7 +654,7 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
 {
 	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
 }
@@ -657,7 +665,7 @@ static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic32_clear(rte_atomic32_t *v)
+static __rte_deprecated inline void rte_atomic32_clear(rte_atomic32_t *v)
 {
 	v->cnt = 0;
 }
@@ -679,7 +687,7 @@ static inline void rte_atomic32_clear(rte_atomic32_t *v)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
+static __rte_deprecated inline int
 rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
@@ -700,7 +708,7 @@ rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
  * @return
  *   The original value at that location
  */
-static inline uint64_t
+static __rte_deprecated inline uint64_t
 rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
 {
 	return rte_atomic_exchange_explicit((volatile __rte_atomic uint64_t *)dst,
@@ -725,7 +733,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_init(rte_atomic64_t *v)
 {
 #ifdef __LP64__
@@ -750,7 +758,7 @@ rte_atomic64_init(rte_atomic64_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_read(rte_atomic64_t *v)
 {
 #ifdef __LP64__
@@ -777,7 +785,7 @@ rte_atomic64_read(rte_atomic64_t *v)
  * @param new_value
  *   The new value of the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 {
 #ifdef __LP64__
@@ -802,7 +810,7 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
@@ -817,7 +825,7 @@ rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
@@ -830,7 +838,7 @@ rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_inc(rte_atomic64_t *v)
 {
 	rte_atomic64_add(v, 1);
@@ -842,7 +850,7 @@ rte_atomic64_inc(rte_atomic64_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_dec(rte_atomic64_t *v)
 {
 	rte_atomic64_sub(v, 1);
@@ -861,7 +869,7 @@ rte_atomic64_dec(rte_atomic64_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
@@ -881,7 +889,7 @@ rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
@@ -899,7 +907,7 @@ rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
  * @return
  *   True if the result after the addition is 0; false otherwise.
  */
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_add_return(v, 1) == 0;
 }
@@ -915,7 +923,7 @@ static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
  * @return
  *   True if the result after subtraction is 0; false otherwise.
  */
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_sub_return(v, 1) == 0;
 }
@@ -931,7 +939,7 @@ static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
 {
 	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
 }
@@ -942,13 +950,15 @@ static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic64_clear(rte_atomic64_t *v)
+static __rte_deprecated inline void rte_atomic64_clear(rte_atomic64_t *v)
 {
 	rte_atomic64_set(v, 0);
 }
 
 #endif
 
+__rte_diagnostic_pop
+
 /*------------------------ 128 bit atomic operations -------------------------*/
 
 /**
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 0a356abae2..aa56aa6a94 100644
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
-- 
2.53.0

