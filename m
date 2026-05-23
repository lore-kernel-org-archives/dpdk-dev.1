Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A83CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:58:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7375440668;
	Sat, 23 May 2026 21:58:47 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 76A9740658
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:45 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so28302504eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566324;
 x=1780171124; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CI0f0CMCsSXWOSPRprOmaHTFc4GByb2eU1rV8mhgPuw=;
 b=FpkKdRUTG2Qs/lQMJASBo3INtHwIGT4PaWy3C5MOnWeSEKgpX9fUWAHD5METhrbMFm
 96R+KMjnGILjOx6y8O9aSiZr2g92CtddsIsUPFVrsmEgEntfmpJGMHmtz61h7tKeC9W7
 om95AVDI8FVkVE251kULJ9xNBAew77ouiK4U8kuoTTkFCgH91LFuC4G7orOBX94PP+H+
 8lYkU2AWKD1WTdF6oKwVONx6SeNpDRTjFoAyZfXID1JG0AfhL0x+08cgCcazHjgJnHr3
 LJz0Q87/ozkerQbAXth3GbNID4r4MIJfbtBV5pzcrRBbmWo2+9D1tTwR8MQAk1+diOzH
 zkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566324; x=1780171124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CI0f0CMCsSXWOSPRprOmaHTFc4GByb2eU1rV8mhgPuw=;
 b=OISaWnhiwbTzP4gKbcHz+9k/KOZIpdF6feMH5X2Zezz48m8Oa6gNbxTCxBKxK7+lIf
 r5s4OXXgs7VkDGE6M+EQgFuJgb3Bin4aRFghngZtSFxgFXZfm9bhfnhiM5DerSkOtM3U
 raqV36sjb0evF1HHok9eaW9KXbmx8MzHwlFO2u6T8zTcZukulGaxqboy9Euo0or2iC6s
 lCMVbwwfTa2cK9BT0H+dYrbdsCQUHdSuGn5QJyUXtaZHlDyO3AhGlj4YUHKsTJZDoF9C
 CcmLfgeOhSmB+cjmAQ2t1+pNh34eChocfynkTBUGvSiRUeOC64Qvff+2kyY0pHTih4rI
 nKyw==
X-Gm-Message-State: AOJu0YzDKDTiTIM8zVo0U15y3hh2kFvAFK2aVNEv9u0fQfE8d9qHGdDq
 PxQudc77pTHD0XbAlmoxIHyU4fR8SWvjdFthHQY+w7+HfxWctuD3VGi67P3eRK9fHjUmHpjYTAR
 gvqAl
X-Gm-Gg: Acq92OHxjq1j8fy/FsdOL6QuV96Lw+Q4/Z3F+Dnvg4nMIzxkS+wRonRYgk4/xgM89Dq
 3/kt5qm/KdvSaqz2cDsZpcr0L2LZtaDKAhEu7EIIrqeqOaCQzEJhaToMzeXPm6hpMnPdWCz1C87
 /WSkSTqwMjUfBtVh5bhr/X6yY25N1Hrc0psU5zrLBeR3mRAHtfcbadj1zoO/QXYMJYbu2U2ssRE
 xuGoS0u8874ykAX1L5OgOWiGg50x+1AzfbbbdirKQmyxAx8XNcaTJ/xqSmh3okCLL/cKnzguZxH
 3LyYVtt0OyYQWRwx6/H26XHXTPptn53vQlUgN8d4k0KFz2SJwLwqtZJR+6dkgd2zFLAFj/yIu+Q
 s/Fu0SnSQGrlDxQr8US8EmpRpLsF8f7g0duqerbF0qlfljmrQULLSSV1vmlFFYf6qiwFVkJAWHF
 fsmjPowT8tTWYeSA+c4BSWJO/FPB8fnRFVNBU/o2bpO5NjyzEgFxu+KUzrerdseQ==
X-Received: by 2002:a05:7300:434a:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30449101ddamr4535749eec.22.1779566324407; 
 Sat, 23 May 2026 12:58:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bibo Mao <maobibo@loongson.cn>, David Christensen <drc@linux.ibm.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 02/27] eal: reimplement rte_smp_*mb with
 rte_atomic_thread_fence
Date: Sat, 23 May 2026 12:56:16 -0700
Message-ID: <20260523195839.454952-3-stephen@networkplumber.org>
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

Drop restriction frm checkpatch since they are no longer
really on deprecation cycle.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh               |   8 --
 doc/guides/rel_notes/deprecation.rst   |   8 --
 lib/eal/arm/include/rte_atomic_32.h    |   6 --
 lib/eal/arm/include/rte_atomic_64.h    |   6 --
 lib/eal/include/generic/rte_atomic.h   | 130 +++++--------------------
 lib/eal/loongarch/include/rte_atomic.h |   6 --
 lib/eal/ppc/include/rte_atomic.h       |   6 --
 lib/eal/riscv/include/rte_atomic.h     |   6 --
 lib/eal/x86/include/rte_atomic.h       |  33 +++----
 9 files changed, 37 insertions(+), 172 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index f5dd77443f..81bb0fe4e8 100755
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
index 35c9b4e06c..2190419f79 100644
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
index 292e52fade..1b04b43cbb 100644
--- a/lib/eal/include/generic/rte_atomic.h
+++ b/lib/eal/include/generic/rte_atomic.h
@@ -59,55 +59,25 @@ static inline void rte_rmb(void);
  *
  * Guarantees that the LOAD and STORE operations that precede the
  * rte_smp_mb() call are globally visible across the lcores
- * before the LOAD and STORE operations that follows it.
- *
- * @note
- *  This function is deprecated.
- *  It provides similar synchronization primitive as atomic fence,
- *  but has different syntax and memory ordering semantic. Hence
- *  deprecated for the simplicity of memory ordering semantics in use.
- *
- *  rte_atomic_thread_fence(rte_memory_order_acq_rel) should be used instead.
+ * before the LOAD and STORE operations that follow it.
  */
 static inline void rte_smp_mb(void);
 
 /**
  * Write memory barrier between lcores
  *
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
+ * Guarantees that the LOAD and STORE operations that precede the
+ * rte_smp_wmb() call are globally visible across the lcores before
+ * any STORE operations that follow it.
  */
 static inline void rte_smp_wmb(void);
 
 /**
  * Read memory barrier between lcores
  *
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
+ * Guarantees that any LOAD operations that precede the rte_smp_rmb()
+ * call complete before LOAD and STORE operations that follow it
+ * become globally visible.
  */
 static inline void rte_smp_rmb(void);
 ///@}
@@ -164,6 +134,24 @@ static inline void rte_io_rmb(void);
  */
 static inline void rte_atomic_thread_fence(rte_memory_order memorder);
 
+static __rte_always_inline void
+rte_smp_mb(void)
+{
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+}
+
+static __rte_always_inline void
+rte_smp_wmb(void)
+{
+	rte_atomic_thread_fence(rte_memory_order_release);
+}
+
+static __rte_always_inline void
+rte_smp_rmb(void)
+{
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+}
+
 /*------------------------- 16 bit atomic operations -------------------------*/
 
 #ifndef RTE_TOOLCHAIN_MSVC
@@ -184,9 +172,6 @@ static inline void rte_atomic_thread_fence(rte_memory_order memorder);
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
-rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src);
-
 static inline int
 rte_atomic16_cmpset(volatile uint16_t *dst, uint16_t exp, uint16_t src)
 {
@@ -303,9 +288,6 @@ rte_atomic16_sub(rte_atomic16_t *v, int16_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic16_inc(rte_atomic16_t *v);
-
 static inline void
 rte_atomic16_inc(rte_atomic16_t *v)
 {
@@ -318,9 +300,6 @@ rte_atomic16_inc(rte_atomic16_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic16_dec(rte_atomic16_t *v);
-
 static inline void
 rte_atomic16_dec(rte_atomic16_t *v)
 {
@@ -379,8 +358,6 @@ rte_atomic16_sub_return(rte_atomic16_t *v, int16_t dec)
  * @return
  *   True if the result after the increment operation is 0; false otherwise.
  */
-static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v);
-
 static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
@@ -398,8 +375,6 @@ static inline int rte_atomic16_inc_and_test(rte_atomic16_t *v)
  * @return
  *   True if the result after the decrement operation is 0; false otherwise.
  */
-static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v);
-
 static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int16_t *)&v->cnt, 1,
@@ -417,8 +392,6 @@ static inline int rte_atomic16_dec_and_test(rte_atomic16_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic16_test_and_set(rte_atomic16_t *v);
-
 static inline int rte_atomic16_test_and_set(rte_atomic16_t *v)
 {
 	return rte_atomic16_cmpset((volatile uint16_t *)&v->cnt, 0, 1);
@@ -453,9 +426,6 @@ static inline void rte_atomic16_clear(rte_atomic16_t *v)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
-rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src);
-
 static inline int
 rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
 {
@@ -572,9 +542,6 @@ rte_atomic32_sub(rte_atomic32_t *v, int32_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic32_inc(rte_atomic32_t *v);
-
 static inline void
 rte_atomic32_inc(rte_atomic32_t *v)
 {
@@ -587,9 +554,6 @@ rte_atomic32_inc(rte_atomic32_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic32_dec(rte_atomic32_t *v);
-
 static inline void
 rte_atomic32_dec(rte_atomic32_t *v)
 {
@@ -648,8 +612,6 @@ rte_atomic32_sub_return(rte_atomic32_t *v, int32_t dec)
  * @return
  *   True if the result after the increment operation is 0; false otherwise.
  */
-static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v);
-
 static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_add_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
@@ -667,8 +629,6 @@ static inline int rte_atomic32_inc_and_test(rte_atomic32_t *v)
  * @return
  *   True if the result after the decrement operation is 0; false otherwise.
  */
-static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v);
-
 static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
 {
 	return rte_atomic_fetch_sub_explicit((volatile __rte_atomic int32_t *)&v->cnt, 1,
@@ -686,8 +646,6 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic32_test_and_set(rte_atomic32_t *v);
-
 static inline int rte_atomic32_test_and_set(rte_atomic32_t *v)
 {
 	return rte_atomic32_cmpset((volatile uint32_t *)&v->cnt, 0, 1);
@@ -721,9 +679,6 @@ static inline void rte_atomic32_clear(rte_atomic32_t *v)
  * @return
  *   Non-zero on success; 0 on failure.
  */
-static inline int
-rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src);
-
 static inline int
 rte_atomic64_cmpset(volatile uint64_t *dst, uint64_t exp, uint64_t src)
 {
@@ -770,9 +725,6 @@ typedef struct {
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic64_init(rte_atomic64_t *v);
-
 static inline void
 rte_atomic64_init(rte_atomic64_t *v)
 {
@@ -798,9 +750,6 @@ rte_atomic64_init(rte_atomic64_t *v)
  * @return
  *   The value of the counter.
  */
-static inline int64_t
-rte_atomic64_read(rte_atomic64_t *v);
-
 static inline int64_t
 rte_atomic64_read(rte_atomic64_t *v)
 {
@@ -828,9 +777,6 @@ rte_atomic64_read(rte_atomic64_t *v)
  * @param new_value
  *   The new value of the counter.
  */
-static inline void
-rte_atomic64_set(rte_atomic64_t *v, int64_t new_value);
-
 static inline void
 rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
 {
@@ -856,9 +802,6 @@ rte_atomic64_set(rte_atomic64_t *v, int64_t new_value)
  * @param inc
  *   The value to be added to the counter.
  */
-static inline void
-rte_atomic64_add(rte_atomic64_t *v, int64_t inc);
-
 static inline void
 rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
 {
@@ -874,9 +817,6 @@ rte_atomic64_add(rte_atomic64_t *v, int64_t inc)
  * @param dec
  *   The value to be subtracted from the counter.
  */
-static inline void
-rte_atomic64_sub(rte_atomic64_t *v, int64_t dec);
-
 static inline void
 rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
 {
@@ -890,9 +830,6 @@ rte_atomic64_sub(rte_atomic64_t *v, int64_t dec)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic64_inc(rte_atomic64_t *v);
-
 static inline void
 rte_atomic64_inc(rte_atomic64_t *v)
 {
@@ -905,9 +842,6 @@ rte_atomic64_inc(rte_atomic64_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void
-rte_atomic64_dec(rte_atomic64_t *v);
-
 static inline void
 rte_atomic64_dec(rte_atomic64_t *v)
 {
@@ -927,9 +861,6 @@ rte_atomic64_dec(rte_atomic64_t *v)
  * @return
  *   The value of v after the addition.
  */
-static inline int64_t
-rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc);
-
 static inline int64_t
 rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
 {
@@ -950,9 +881,6 @@ rte_atomic64_add_return(rte_atomic64_t *v, int64_t inc)
  * @return
  *   The value of v after the subtraction.
  */
-static inline int64_t
-rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec);
-
 static inline int64_t
 rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
 {
@@ -971,8 +899,6 @@ rte_atomic64_sub_return(rte_atomic64_t *v, int64_t dec)
  * @return
  *   True if the result after the addition is 0; false otherwise.
  */
-static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v);
-
 static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_add_return(v, 1) == 0;
@@ -989,8 +915,6 @@ static inline int rte_atomic64_inc_and_test(rte_atomic64_t *v)
  * @return
  *   True if the result after subtraction is 0; false otherwise.
  */
-static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v);
-
 static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
 {
 	return rte_atomic64_sub_return(v, 1) == 0;
@@ -1007,8 +931,6 @@ static inline int rte_atomic64_dec_and_test(rte_atomic64_t *v)
  * @return
  *   0 if failed; else 1, success.
  */
-static inline int rte_atomic64_test_and_set(rte_atomic64_t *v);
-
 static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
 {
 	return rte_atomic64_cmpset((volatile uint64_t *)&v->cnt, 0, 1);
@@ -1020,8 +942,6 @@ static inline int rte_atomic64_test_and_set(rte_atomic64_t *v)
  * @param v
  *   A pointer to the atomic counter.
  */
-static inline void rte_atomic64_clear(rte_atomic64_t *v);
-
 static inline void rte_atomic64_clear(rte_atomic64_t *v)
 {
 	rte_atomic64_set(v, 0);
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
index 64f4c3d670..0e64db2a35 100644
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
index 4f05302c9f..f4d39ce4fe 100644
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

