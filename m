Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B690CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C96340E20;
	Sat, 23 May 2026 21:59:12 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id F3AF140E27
 for <dev@dpdk.org>; Sat, 23 May 2026 21:59:10 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso13946545eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566350;
 x=1780171150; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oIovUyh5bNfxmW/cuh7d8pzcdkBZ3NozPQWSE5JefA=;
 b=axQQHDFnqiKnH/a3CCwL6baeQUREyPo8dcCK3AtdYnDfLVpZk0mUYDpY6T5AxlBRI2
 CKFNynnNiLQvcLxq2Ma5mxHAJYcxNw6e4fyTO58IDYDnadux1D2N+Iqo++A77AGBZpFF
 T5m+AQwpUBXzP0si9Do+rvVPFLwkvBoEzi4tbudPuOmEkwskqm4KQMv0JycGzIqLl+eJ
 UTFEneBLvIPEuJ9bu7SxzpVt7Tk8cqcoZHCJw3/14QQHXn9JVzvwF4Z03sGRB5j6epwI
 uxGm9+GAIvW22Dd2Z2PuAwTXU5Wd3aGHvRmAB9BNf0YSuoXZh1mr/vbiTymibuKFflbx
 zp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566350; x=1780171150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9oIovUyh5bNfxmW/cuh7d8pzcdkBZ3NozPQWSE5JefA=;
 b=lSxrbKXIKV1Jymp6ykF5PbNkulTtYg0V7WYO8REuJFt0JpWbIK1kdXYjh6LHzcKTmH
 jrC9VwD/6WtZht3uo5TOZicz5jxPAHSzGgipWgHM6RmYlRrX3oVlNCzPe9MyjEjNP7jw
 MXzSpG5d1iSdaSKvGfPwWhlt5/rbsG+eO3haj9Ll9Lbm3jaR9P4MS5S4vXIyM1gNiKkA
 wZjAnGa3i5WESDH0SYMpi8JdvXor6T0gu1q4I/Qw2fEtwJamv17nyMeu+UIf88XnJoqH
 m4W3ZyT4O8/hzywnHWRUcKyQLoP/o5Dfx2V2cdpJ9+QvVOHhxdbpm+GWHJRzQdMp/IqL
 P4IQ==
X-Gm-Message-State: AOJu0YzryTGUD6UGhWTCMOmQY1EVnnqlQ2Vl+j7Gpj7ZyXTnNnWOwWi0
 uGMM6kTNKanFjSRj/nx/iWWTKnIJF05+KKtmm3T4PwkUQ0hNcOPB4XFnsaWdgS8mShhIcP8eOY1
 IbmXr
X-Gm-Gg: Acq92OHRLaf4oOZX0g4MUimvq+Vck/oYgGZjS6Z+Q/1aFzImRVRpT7vFruDkqXoii7c
 Y8Pxsb9/172gSbBjot5jUY16426zSWXnFRxf+cjEfUUguTkDhON1vx5OfIVCBAkCoWh1a53Z6O6
 tcW4lIZSy9XT8OCmzKLHWAxCPaxWAlmBbKShGdZ+SMYAxKOm5cxi1SAQlSaB5mR43qxbDPMf8LZ
 FBzhE3Cn1pr317Ek/e7E5wh1W9j6sygcSBhZXVlBhF3BEkuQr6f699/prc9pbDEhNNh7Z8T/B+C
 o0Kpl4u87/2wxssJPGGmM9B8ZbRq8FjN8TGoUe3fO5QrF8+5jKPaJpaLGk6J5KChLOGZCLFXXVP
 N8GW3vs+xiWtaeKl4qlqwP6C5ROclhxJ6UXxaE37ag7k5xu/OIu/ERUEyMHiywU6Gr5kDle5XEI
 ieC36DzxQRjJQlR5zjJthg8OLIDCz8jN6C+OdjyJ43XtBgwIHuNZvy9EqJjMQBOQ==
X-Received: by 2002:a05:7301:7c0e:b0:2bd:c285:2fe with SMTP id
 5a478bee46e88-3044905fcc3mr4768169eec.9.1779566349985; 
 Sat, 23 May 2026 12:59:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v3 27/27] eal: mark rte_atomicNN as deprecated
Date: Sat, 23 May 2026 12:56:41 -0700
Message-ID: <20260523195839.454952-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

The rte_atomicNN functions back in 2021 but code was still using these
functions. Now that all in tree code has been updated the functions
are marked with __rte_deprecated so that user code will get
see the deprecation.

Remove rte_atomicNN from checkpatches since usage is now
detected at compile time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh               |  8 ---
 doc/guides/rel_notes/deprecation.rst   |  4 +-
 doc/guides/rel_notes/release_26_07.rst |  4 ++
 lib/eal/include/generic/rte_atomic.h   | 99 ++++++++++++++------------
 4 files changed, 59 insertions(+), 56 deletions(-)

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
index f012d47a4b..2c8faffee9 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -92,6 +92,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* atomic: Marked the ``rte_atomicNN`` functions as deprecated.
+  As previously announced these functions were intended to be deprecated
+  but was not being enforced.
+
 
 ABI Changes
 -----------
diff --git a/lib/eal/include/generic/rte_atomic.h b/lib/eal/include/generic/rte_atomic.h
index 1b04b43cbb..b660f9fc1c 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -152,6 +152,13 @@ rte_smp_rmb(void)
 	rte_atomic_thread_fence(rte_memory_order_acquire);
 }
 
+/*
+ * The rte_atomicNN_* APIs defined below are deprecated in favour of C11 atomics.
+ * Suppress the deprecation warnings for the inlines to allow inter-related usage.
+ */
+__rte_diagnostic_push
+_Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
+
 /*------------------------- 16 bit atomic operations -------------------------*/
 
 #ifndef RTE_TOOLCHAIN_MSVC
@@ -172,7 +179,7 @@ rte_smp_rmb(void)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
+static __rte_deprecated inline int
 rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
@@ -193,7 +200,7 @@ rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
  * @return
  *   The original value at that location
  */
-static inline uint16_t
+static __rte_deprecated inline uint16_t
 rte_atomic16_exchange(volatile uint16_t *dst, uint16_t val)
 {
 	return rte_atomic_exchange_explicit((volatile __rte_atomic uint16_t *)dst,
@@ -218,7 +225,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_init(rte_atomic16_t *v)
 {
 	v->cnt = 0;
@@ -232,7 +239,7 @@ rte_atomic16_init(rte_atomic16_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_read(const rte_atomic16_t *v)
 {
 	return v->cnt;
@@ -246,7 +253,7 @@ rte_atomic16_read(const rte_atomic16_t *v)
  * @param new_value
  *   The new value for the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_set(rte_atomic16_t *v, int16_t new_value)
 {
 	v->cnt = new_value;
@@ -260,7 +267,7 @@ rte_atomic16_set(rte_atomic16_t *v, int16_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_add(rte_atomic16_t *v, int16_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, inc,
@@ -275,7 +282,7 @@ rte_atomic16_add(rte_atomic16_t *v, int16_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, dec,
@@ -288,7 +295,7 @@ rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_inc(rte_atomic16_t *v)
 {
 	rte_atomic16_add(v, 1);
@@ -300,7 +307,7 @@ rte_atomic16_inc(rte_atomic16_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic16_dec(rte_atomic16_t *v)
 {
 	rte_atomic16_sub(v, 1);
@@ -319,7 +326,7 @@ rte_atomic16_dec(rte_atomic16_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_add_return(rte_atomic16_t *v, int16_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, inc,
@@ -340,7 +347,7 @@ rte_atomic16_add_return(rte_atomic16_t *v, int16_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int16_t
+static __rte_deprecated inline int16_t
 rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, dec,
@@ -358,7 +365,7 @@ rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
  * @return
  *   True if the result after the increment operation is 0; false otherwise.
  */
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) + 1 == 0;
@@ -375,7 +382,7 @@ static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
  * @return
  *   True if the result after the decrement operation is 0; false otherwise.
  */
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) - 1 == 0;
@@ -392,7 +399,7 @@ static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
+static __rte_deprecated inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
 {
 	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
 }
@@ -403,7 +410,7 @@ static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic16_clear(rte_atomic16_t *v)
+static __rte_deprecated inline void rte_atomic16_clear(rte_atomic16_t *v)
 {
 	v->cnt = 0;
 }
@@ -426,7 +433,7 @@ static inline void rte_atomic16_clear(rte_atomic16_t *v)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
+static __rte_deprecated inline int
 rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
@@ -447,7 +454,7 @@ rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
  * @return
  *   The original value at that location
  */
-static inline uint32_t
+static __rte_deprecated inline uint32_t
 rte_atomic32_exchange(volatile uint32_t *dst, uint32_t val)
 {
 	return rte_atomic_exchange_explicit((volatile __rte_atomic uint32_t *)dst,
@@ -472,7 +479,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_init(rte_atomic32_t *v)
 {
 	v->cnt = 0;
@@ -486,7 +493,7 @@ rte_atomic32_init(rte_atomic32_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_read(const rte_atomic32_t *v)
 {
 	return v->cnt;
@@ -500,7 +507,7 @@ rte_atomic32_read(const rte_atomic32_t *v)
  * @param new_value
  *   The new value for the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_set(rte_atomic32_t *v, int32_t new_value)
 {
 	v->cnt = new_value;
@@ -514,7 +521,7 @@ rte_atomic32_set(rte_atomic32_t *v, int32_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_add(rte_atomic32_t *v, int32_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, inc,
@@ -529,7 +536,7 @@ rte_atomic32_add(rte_atomic32_t *v, int32_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, dec,
@@ -542,7 +549,7 @@ rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_inc(rte_atomic32_t *v)
 {
 	rte_atomic32_add(v, 1);
@@ -554,7 +561,7 @@ rte_atomic32_inc(rte_atomic32_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic32_dec(rte_atomic32_t *v)
 {
 	rte_atomic32_sub(v,1);
@@ -573,7 +580,7 @@ rte_atomic32_dec(rte_atomic32_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_add_return(rte_atomic32_t *v, int32_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, inc,
@@ -594,7 +601,7 @@ rte_atomic32_add_return(rte_atomic32_t *v, int32_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int32_t
+static __rte_deprecated inline int32_t
 rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, dec,
@@ -612,7 +619,7 @@ rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
  * @return
  *   True if the result after the increment operation is 0; false otherwise.
  */
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) + 1 == 0;
@@ -629,7 +636,7 @@ static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
  * @return
  *   True if the result after the decrement operation is 0; false otherwise.
  */
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
 		rte_memory_order_seq_cst) - 1 == 0;
@@ -646,7 +653,7 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
+static __rte_deprecated inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
 {
 	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
 }
@@ -657,7 +664,7 @@ static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic32_clear(rte_atomic32_t *v)
+static __rte_deprecated inline void rte_atomic32_clear(rte_atomic32_t *v)
 {
 	v->cnt = 0;
 }
@@ -679,7 +686,7 @@ static inline void rte_atomic32_clear(rte_atomic32_t *v)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
+static __rte_deprecated inline int
 rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
 {
 	return __sync_bool_compare_and_swap(dst, exp, src);
@@ -700,7 +707,7 @@ rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
  * @return
  *   The original value at that location
  */
-static inline uint64_t
+static __rte_deprecated inline uint64_t
 rte_atomic64_exchange(volatile uint64_t *dst, uint64_t val)
 {
 	return rte_atomic_exchange_explicit((volatile __rte_atomic uint64_t *)dst,
@@ -725,7 +732,7 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_init(rte_atomic64_t *v)
 {
 #ifdef __LP64__
@@ -750,7 +757,7 @@ rte_atomic64_init(rte_atomic64_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_read(rte_atomic64_t *v)
 {
 #ifdef __LP64__
@@ -777,7 +784,7 @@ rte_atomic64_read(rte_atomic64_t *v)
  * @param new_value
  *   The new value of the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 {
 #ifdef __LP64__
@@ -802,7 +809,7 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
 {
 	rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
@@ -817,7 +824,7 @@ rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
 {
 	rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
@@ -830,7 +837,7 @@ rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_inc(rte_atomic64_t *v)
 {
 	rte_atomic64_add(v, 1);
@@ -842,7 +849,7 @@ rte_atomic64_inc(rte_atomic64_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
+static __rte_deprecated inline void
 rte_atomic64_dec(rte_atomic64_t *v)
 {
 	rte_atomic64_sub(v, 1);
@@ -861,7 +868,7 @@ rte_atomic64_dec(rte_atomic64_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int64_t *)&v->cnt, inc,
@@ -881,7 +888,7 @@ rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int64_t
+static __rte_deprecated inline int64_t
 rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int64_t *)&v->cnt, dec,
@@ -899,7 +906,7 @@ rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
  * @return
  *   True if the result after the addition is 0; false otherwise.
  */
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_add_return(v, 1) == 0;
 }
@@ -915,7 +922,7 @@ static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
  * @return
  *   True if the result after subtraction is 0; false otherwise.
  */
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_sub_return(v, 1) == 0;
 }
@@ -931,7 +938,7 @@ static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
+static __rte_deprecated inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
 {
 	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
 }
@@ -942,13 +949,15 @@ static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
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
-- 
2.53.0

