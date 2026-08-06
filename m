Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A81C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E356740E09;
	Thu,  6 Aug 2026 05:26:18 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id CAF1140DD2
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:13 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so1522117a12.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986773;
 x=1786591573; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b274whFyAEUMBMxpaYc8eKYhVpb59yJoKqzreRdDsko=;
 b=vh12ln7A1ZD5XgcFqZP34dLqFe2KphTvKoWxalXMEHY/s+ufXx+ljpVESu6GspGKWg
 pyxNUP/7p6sPMRe/vmUPbuslOF7pY8Hs4CqozeLbqKSQrX2bJFYse/Abqjn3YQf8vXIL
 EdLDVqWuxn6ez9coVYmJGcxa18wP1/rDgpNTgBTbwHw8JOd2MNBhBlgm9omvlnDSx3Sh
 toYEL5R5+lC6qEBwn/YJmgP0UA2mOgV+4ID+0ugQcySsz872Fbv0VcqZ1lImrgsRtuAH
 WhEh7haDFDcZYpAXJXi0kVSVMuuw5oRb/66sGupB5kHkbG0qNy6ubpEyTqUM8G2FiTqI
 VXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986773; x=1786591573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b274whFyAEUMBMxpaYc8eKYhVpb59yJoKqzreRdDsko=;
 b=cbJ6uQrnZXNnyaYPa0E6NR1YD0idayZhqQglV0xiA29hwoY6Lgbz/9Ax2ZQNW98gtA
 V2LqKijGMIFBsa5cmM1fr1I2fQcLam1sZ45SpDNDlh3q8/jlNLgPmA1uS9zvQXQbDCKR
 A3+XYYK4HN2IE1joZqMsYDoYew8P+tVGMa+WjUBOwP6TLoRHNd3U7ple1QVSwsLER9cb
 qzWEbxTDjmrwsUtFRiHS3YlMP/dNXTvgXL2jhlJxQ/hoTr92aZf8SbWDlAm4kawZbPK7
 gDei0+nJRj8bk6Z+5RELaXS7UXlN9LdKU+8wAUoVFhwr5SaBegk5Nj9IiAdCM/nKwvYT
 Bn6Q==
X-Gm-Message-State: AOJu0YwpMCI1vNlb1VNJpgQO4vsT8S2veZuiYVjAOydDkpTdjPb0x9+a
 reqx7rbATv4Z3Dmv33Pm6N232Yig8kJhsaEAkJmGOLyz8vQiYP4LPPi/BKz45FAeSz3HeWDl4K9
 vw69u
X-Gm-Gg: AR+sD12PGswOPw8K+gcuIGXug+S42RHESm9KjKBqy7WHWvHzvK+cjgV+IlUmJWCiG48
 cpNokGYklISTL4mohxYgajhdncNoRaiIfT2P35nmn2DKGituBwEoT6VuWjV5mcZHy+hNBRvbadP
 X6+H60BB+peUah1qMeaiPuyKvOMvToDkYxcofpskAF/o7MbPjAlHeoAOQXKUbcz0MRReJAPlbMm
 AfZB+520jaes1lQzcsL4P/rVb9BCeNLer80l+AY8Abjl5chmeErHK1ydTvSTcfyYBa0Zg8YsDVW
 1QBfJfsBqge5BVpwBwaK1sIc+lsVXnHC+P1ga1HDAOEneye07q+vZmdfD5YaJYzL2tISpzZ8gNV
 GKF1UR8o1MJicdNQPMvLPN6267H0xN91XusynbhtYb+ALHxunqar5h6OD+8PmVqu7ZYHCUOX5zO
 AWJwkc9K/t6wE/WhMOT5FmLpXd8eKRWjT+DUNSp48sBgHglSpJVU3qx/4p6cZWLdCdvb/8fqP7I
 F39n7NkR6SPRvqS0gHbCEmsqwge5gr9ps91w1dQOyIec/gOIw==
X-Received: by 2002:a05:6a21:648e:b0:3c3:791e:5e0c with SMTP id
 adf61e73a8af0-3cb85e4defbmr13869032637.19.1785986772716; 
 Wed, 05 Aug 2026 20:26:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 23/24] test/atomic: drop old rte_atomicNN tests
Date: Wed,  5 Aug 2026 20:23:15 -0700
Message-ID: <20260806032544.21337-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

The rte_atomicNN_* APIs will be removed.
Only the 128 bit compare-and-swap case test remains.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_atomic.c | 523 +++--------------------------------------
 1 file changed, 29 insertions(+), 494 deletions(-)

diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index 2a4531b833..227ad6dab7 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -14,61 +14,23 @@
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
 #include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_eal.h>
 #include <rte_lcore.h>
 #include <rte_pause.h>
-#include <rte_random.h>
-#include <rte_hash_crc.h>
 
 #include "test.h"
 
 #ifndef RTE_TOOLCHAIN_MSVC
+/*
+ * The 128-bit compare and exchange is only implemented for
+ * x86_64 and aarch64 with GCC/Clang
+ */
+#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
 /*
  * Atomic Variables
  * ================
  *
- * - The main test function performs several subtests. The first
- *   checks that the usual inc/dec/add/sub functions are working
- *   correctly:
- *
- *   - Initialize 16-bit, 32-bit and 64-bit atomic variables to specific
- *     values.
- *
- *   - These variables are incremented and decremented on each core at
- *     the same time in ``test_atomic_usual()``.
- *
- *   - The function checks that once all lcores finish their function,
- *     the value of the atomic variables are still the same.
- *
- * - Test "test and set" functions.
- *
- *   - Initialize 16-bit, 32-bit and 64-bit atomic variables to zero.
- *
- *   - Invoke ``test_atomic_tas()`` on each lcore: before doing anything
- *     else. The cores are waiting a synchro using ``while
- *     (rte_atomic32_read(&val) == 0)`` which is triggered by the main test
- *     function. Then all cores do a
- *     ``rte_atomicXX_test_and_set()`` at the same time. If it is successful,
- *     it increments another atomic counter.
- *
- *   - The main function checks that the atomic counter was incremented
- *     twice only (one for 16-bit, one for 32-bit and one for 64-bit values).
- *
- * - Test "add/sub and return" functions
- *
- *   - Initialize 16-bit, 32-bit and 64-bit atomic variables to zero.
- *
- *   - Invoke ``test_atomic_addsub_return()`` on each lcore. Before doing
- *     anything else, the cores are waiting a synchro. Each lcore does
- *     this operation several times::
- *
- *       tmp = rte_atomicXX_add_return(&a, 1);
- *       atomic_add(&count, tmp);
- *       tmp = rte_atomicXX_sub_return(&a, 1);
- *       atomic_sub(&count, tmp+1);
- *
- *   - At the end of the test, the *count* value must be 0.
- *
  * - Test "128-bit compare and swap" (aarch64 and x86_64 only)
  *
  *   - Initialize 128-bit atomic variables to zero.
@@ -84,24 +46,8 @@
  *
  *   - At the end of the test, the *count128* first 64-bit value and
  *     second 64-bit value differ by the total iterations.
- *
- * - Test "atomic exchange" functions
- *
- *   - Create a 64 bit token that can be tested for data integrity
- *
- *   - Invoke ``test_atomic_exchange`` on each lcore.  Before doing
- *     anything else, the cores wait for a synchronization event.
- *     Each core then does the following for N iterations:
- *
- *       Generate a new token with a data integrity check
- *       Exchange the new token for previously generated token
- *       Increment a counter if a corrupt token was received
- *
- *   - At the end of the test, the number of corrupted tokens must be 0.
  */
 
-#define NUM_ATOMIC_TYPES 3
-
 #define N_BASE 1000000u
 #define N_MIN  10000u
 
@@ -112,156 +58,8 @@
  */
 static unsigned int num_iterations;
 
-static rte_atomic16_t a16;
-static rte_atomic32_t a32;
-static rte_atomic64_t a64;
-static rte_atomic64_t count;
-static rte_atomic32_t synchro;
-
-static int
-test_atomic_usual(__rte_unused void *arg)
-{
-	unsigned int i;
-
-	while (rte_atomic32_read(&synchro) == 0)
-		rte_pause();
-
-	for (i = 0; i < num_iterations; i++)
-		rte_atomic16_inc(&a16);
-	for (i = 0; i < num_iterations; i++)
-		rte_atomic16_dec(&a16);
-	for (i = 0; i < (num_iterations / 5); i++)
-		rte_atomic16_add(&a16, 5);
-	for (i = 0; i < (num_iterations / 5); i++)
-		rte_atomic16_sub(&a16, 5);
-
-	for (i = 0; i < num_iterations; i++)
-		rte_atomic32_inc(&a32);
-	for (i = 0; i < num_iterations; i++)
-		rte_atomic32_dec(&a32);
-	for (i = 0; i < (num_iterations / 5); i++)
-		rte_atomic32_add(&a32, 5);
-	for (i = 0; i < (num_iterations / 5); i++)
-		rte_atomic32_sub(&a32, 5);
-
-	for (i = 0; i < num_iterations; i++)
-		rte_atomic64_inc(&a64);
-	for (i = 0; i < num_iterations; i++)
-		rte_atomic64_dec(&a64);
-	for (i = 0; i < (num_iterations / 5); i++)
-		rte_atomic64_add(&a64, 5);
-	for (i = 0; i < (num_iterations / 5); i++)
-		rte_atomic64_sub(&a64, 5);
-
-	return 0;
-}
-
-static int
-test_atomic_tas(__rte_unused void *arg)
-{
-	while (rte_atomic32_read(&synchro) == 0)
-		rte_pause();
-
-	if (rte_atomic16_test_and_set(&a16))
-		rte_atomic64_inc(&count);
-	if (rte_atomic32_test_and_set(&a32))
-		rte_atomic64_inc(&count);
-	if (rte_atomic64_test_and_set(&a64))
-		rte_atomic64_inc(&count);
-
-	return 0;
-}
-
-static int
-test_atomic_addsub_and_return(__rte_unused void *arg)
-{
-	uint32_t tmp16;
-	uint32_t tmp32;
-	uint64_t tmp64;
-	unsigned int i;
-
-	while (rte_atomic32_read(&synchro) == 0)
-		rte_pause();
-
-	for (i = 0; i < num_iterations; i++) {
-		tmp16 = rte_atomic16_add_return(&a16, 1);
-		rte_atomic64_add(&count, tmp16);
-
-		tmp16 = rte_atomic16_sub_return(&a16, 1);
-		rte_atomic64_sub(&count, tmp16+1);
-
-		tmp32 = rte_atomic32_add_return(&a32, 1);
-		rte_atomic64_add(&count, tmp32);
-
-		tmp32 = rte_atomic32_sub_return(&a32, 1);
-		rte_atomic64_sub(&count, tmp32+1);
-
-		tmp64 = rte_atomic64_add_return(&a64, 1);
-		rte_atomic64_add(&count, tmp64);
-
-		tmp64 = rte_atomic64_sub_return(&a64, 1);
-		rte_atomic64_sub(&count, tmp64+1);
-	}
-
-	return 0;
-}
-
-/*
- * rte_atomic32_inc_and_test() would increase a 32 bits counter by one and then
- * test if that counter is equal to 0. It would return true if the counter is 0
- * and false if the counter is not 0. rte_atomic64_inc_and_test() could do the
- * same thing but for a 64 bits counter.
- * Here checks that if the 32/64 bits counter is equal to 0 after being atomically
- * increased by one. If it is, increase the variable of "count" by one which would
- * be checked as the result later.
- *
- */
-static int
-test_atomic_inc_and_test(__rte_unused void *arg)
-{
-	while (rte_atomic32_read(&synchro) == 0)
-		rte_pause();
-
-	if (rte_atomic16_inc_and_test(&a16)) {
-		rte_atomic64_inc(&count);
-	}
-	if (rte_atomic32_inc_and_test(&a32)) {
-		rte_atomic64_inc(&count);
-	}
-	if (rte_atomic64_inc_and_test(&a64)) {
-		rte_atomic64_inc(&count);
-	}
-
-	return 0;
-}
-
-/*
- * rte_atomicXX_dec_and_test() should decrease a 32 bits counter by one and then
- * test if that counter is equal to 0. It should return true if the counter is 0
- * and false if the counter is not 0.
- * This test checks if the counter is equal to 0 after being atomically
- * decreased by one. If it is, increase the value of "count" by one which is to
- * be checked as the result later.
- */
-static int
-test_atomic_dec_and_test(__rte_unused void *arg)
-{
-	while (rte_atomic32_read(&synchro) == 0)
-		rte_pause();
-
-	if (rte_atomic16_dec_and_test(&a16))
-		rte_atomic64_inc(&count);
-
-	if (rte_atomic32_dec_and_test(&a32))
-		rte_atomic64_inc(&count);
+static RTE_ATOMIC(uint32_t) synchro;
 
-	if (rte_atomic64_dec_and_test(&a64))
-		rte_atomic64_inc(&count);
-
-	return 0;
-}
-
-#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
 static rte_int128_t count128;
 
 /*
@@ -278,7 +76,7 @@ test_atomic128_cmp_exchange(__rte_unused void *arg)
 	int success;
 	unsigned int i;
 
-	while (rte_atomic32_read(&synchro) == 0)
+	while (rte_atomic_load_explicit(&synchro, rte_memory_order_relaxed) == 0)
 		rte_pause();
 
 	expected = count128;
@@ -292,7 +90,7 @@ test_atomic128_cmp_exchange(__rte_unused void *arg)
 
 			success = rte_atomic128_cmp_exchange(&count128,
 				&expected, &desired, 1,
-				__ATOMIC_ACQUIRE, __ATOMIC_RELAXED);
+				rte_memory_order_acquire, rte_memory_order_relaxed);
 		} while (success == 0);
 
 		do {
@@ -303,7 +101,7 @@ test_atomic128_cmp_exchange(__rte_unused void *arg)
 
 			success = rte_atomic128_cmp_exchange(&count128,
 					&expected, &desired, 1,
-					__ATOMIC_RELEASE, __ATOMIC_RELAXED);
+					rte_memory_order_release, rte_memory_order_relaxed);
 		} while (success == 0);
 
 		do {
@@ -314,7 +112,7 @@ test_atomic128_cmp_exchange(__rte_unused void *arg)
 
 			success = rte_atomic128_cmp_exchange(&count128,
 					&expected, &desired, 1,
-					__ATOMIC_ACQ_REL, __ATOMIC_RELAXED);
+					rte_memory_order_acq_rel, rte_memory_order_relaxed);
 		} while (success == 0);
 
 		do {
@@ -325,260 +123,20 @@ test_atomic128_cmp_exchange(__rte_unused void *arg)
 
 			success = rte_atomic128_cmp_exchange(&count128,
 					&expected, &desired, 1,
-					__ATOMIC_RELAXED, __ATOMIC_RELAXED);
+					rte_memory_order_relaxed, rte_memory_order_relaxed);
 		} while (success == 0);
 	}
 
 	return 0;
 }
-#endif
-
-/*
- * Helper definitions/variables/functions for
- * atomic exchange tests
- */
-typedef union {
-	uint16_t u16;
-	uint8_t  u8[2];
-} test16_t;
-
-typedef union {
-	uint32_t u32;
-	uint16_t u16[2];
-	uint8_t  u8[4];
-} test32_t;
-
-typedef union {
-	uint64_t u64;
-	uint32_t u32[2];
-	uint16_t u16[4];
-	uint8_t  u8[8];
-} test64_t;
-
-const uint8_t CRC8_POLY = 0x91;
-uint8_t crc8_table[256];
-
-volatile uint16_t token16;
-volatile uint32_t token32;
-volatile uint64_t token64;
-
-static void
-build_crc8_table(void)
-{
-	uint8_t val;
-	int i, j;
-
-	for (i = 0; i < 256; i++) {
-		val = i;
-		for (j = 0; j < 8; j++) {
-			if (val & 1)
-				val ^= CRC8_POLY;
-			val >>= 1;
-		}
-		crc8_table[i] = val;
-	}
-}
-
-static uint8_t
-get_crc8(uint8_t *message, int length)
-{
-	uint8_t crc = 0;
-	int i;
-
-	for (i = 0; i < length; i++)
-		crc = crc8_table[crc ^ message[i]];
-	return crc;
-}
-
-/*
- * The atomic exchange test sets up a token in memory and
- * then spins up multiple lcores whose job is to generate
- * new tokens, exchange that new token for the old one held
- * in memory, and then verify that the old token is still
- * valid (i.e. the exchange did not corrupt the token).
- *
- * A token is made up of random data and 8 bits of crc
- * covering that random data.  The following is an example
- * of a 64bit token.
- *
- * +------------+------------+
- * | 63      56 | 55       0 |
- * +------------+------------+
- * |    CRC8    |    Data    |
- * +------------+------------+
- */
-static int
-test_atomic_exchange(__rte_unused void *arg)
-{
-	unsigned int i;
-	test16_t nt16, ot16; /* new token, old token */
-	test32_t nt32, ot32;
-	test64_t nt64, ot64;
-
-	/* Wait until all of the other threads have been dispatched */
-	while (rte_atomic32_read(&synchro) == 0)
-		rte_pause();
-
-	/*
-	 * Let the battle begin! Every thread attempts to steal the current
-	 * token with an atomic exchange operation and install its own newly
-	 * generated token. If the old token is valid (i.e. it has the
-	 * appropriate crc32 hash for the data) then the test iteration has
-	 * passed.  If the token is invalid, increment the counter.
-	 */
-	for (i = 0; i < num_iterations; i++) {
 
-		/* Test 64bit Atomic Exchange */
-		nt64.u64 = rte_rand();
-		nt64.u8[7] = get_crc8(&nt64.u8[0], sizeof(nt64) - 1);
-		ot64.u64 = rte_atomic64_exchange(&token64, nt64.u64);
-		if (ot64.u8[7] != get_crc8(&ot64.u8[0], sizeof(ot64) - 1))
-			rte_atomic64_inc(&count);
-
-		/* Test 32bit Atomic Exchange */
-		nt32.u32 = (uint32_t)rte_rand();
-		nt32.u8[3] = get_crc8(&nt32.u8[0], sizeof(nt32) - 1);
-		ot32.u32 = rte_atomic32_exchange(&token32, nt32.u32);
-		if (ot32.u8[3] != get_crc8(&ot32.u8[0], sizeof(ot32) - 1))
-			rte_atomic64_inc(&count);
-
-		/* Test 16bit Atomic Exchange */
-		nt16.u16 = (uint16_t)rte_rand();
-		nt16.u8[1] = get_crc8(&nt16.u8[0], sizeof(nt16) - 1);
-		ot16.u16 = rte_atomic16_exchange(&token16, nt16.u16);
-		if (ot16.u8[1] != get_crc8(&ot16.u8[0], sizeof(ot16) - 1))
-			rte_atomic64_inc(&count);
-	}
-
-	return 0;
-}
 static int
 test_atomic(void)
 {
-	num_iterations = test_scale_iterations(N_BASE, N_MIN);
-
-	rte_atomic16_init(&a16);
-	rte_atomic32_init(&a32);
-	rte_atomic64_init(&a64);
-	rte_atomic64_init(&count);
-	rte_atomic32_init(&synchro);
-
-	rte_atomic16_set(&a16, 1UL << 10);
-	rte_atomic32_set(&a32, 1UL << 10);
-	rte_atomic64_set(&a64, 1ULL << 33);
-
-	printf("usual inc/dec/add/sub functions\n");
-
-	rte_eal_mp_remote_launch(test_atomic_usual, NULL, SKIP_MAIN);
-	rte_atomic32_set(&synchro, 1);
-	rte_eal_mp_wait_lcore();
-	rte_atomic32_set(&synchro, 0);
-
-	if (rte_atomic16_read(&a16) != 1UL << 10) {
-		printf("Atomic16 usual functions failed\n");
-		return -1;
-	}
-
-	if (rte_atomic32_read(&a32) != 1UL << 10) {
-		printf("Atomic32 usual functions failed\n");
-		return -1;
-	}
-
-	if (rte_atomic64_read(&a64) != 1ULL << 33) {
-		printf("Atomic64 usual functions failed\n");
-		return -1;
-	}
-
-	printf("test and set\n");
-
-	rte_atomic64_set(&a64, 0);
-	rte_atomic32_set(&a32, 0);
-	rte_atomic16_set(&a16, 0);
-	rte_atomic64_set(&count, 0);
-	rte_eal_mp_remote_launch(test_atomic_tas, NULL, SKIP_MAIN);
-	rte_atomic32_set(&synchro, 1);
-	rte_eal_mp_wait_lcore();
-	rte_atomic32_set(&synchro, 0);
+	uint64_t iterations;
 
-	if (rte_atomic64_read(&count) != NUM_ATOMIC_TYPES) {
-		printf("Atomic test and set failed\n");
-		return -1;
-	}
-
-	printf("add/sub and return\n");
-
-	rte_atomic64_set(&a64, 0);
-	rte_atomic32_set(&a32, 0);
-	rte_atomic16_set(&a16, 0);
-	rte_atomic64_set(&count, 0);
-	rte_eal_mp_remote_launch(test_atomic_addsub_and_return, NULL,
-				 SKIP_MAIN);
-	rte_atomic32_set(&synchro, 1);
-	rte_eal_mp_wait_lcore();
-	rte_atomic32_set(&synchro, 0);
-
-	if (rte_atomic64_read(&count) != 0) {
-		printf("Atomic add/sub+return failed\n");
-		return -1;
-	}
-
-	/*
-	 * Set a64, a32 and a16 with the same value of minus "number of worker
-	 * lcores", launch all worker lcores to atomically increase by one and
-	 * test them respectively.
-	 * Each lcore should have only one chance to increase a64 by one and
-	 * then check if it is equal to 0, but there should be only one lcore
-	 * that finds that it is 0. It is similar for a32 and a16.
-	 * Then a variable of "count", initialized to zero, is increased by
-	 * one if a64, a32 or a16 is 0 after being increased and tested
-	 * atomically.
-	 * We can check if "count" is finally equal to 3 to see if all worker
-	 * lcores performed "atomic inc and test" right.
-	 */
-	printf("inc and test\n");
-
-	rte_atomic64_clear(&a64);
-	rte_atomic32_clear(&a32);
-	rte_atomic16_clear(&a16);
-	rte_atomic32_clear(&synchro);
-	rte_atomic64_clear(&count);
-
-	rte_atomic64_set(&a64, (int64_t)(1 - (int64_t)rte_lcore_count()));
-	rte_atomic32_set(&a32, (int32_t)(1 - (int32_t)rte_lcore_count()));
-	rte_atomic16_set(&a16, (int16_t)(1 - (int16_t)rte_lcore_count()));
-	rte_eal_mp_remote_launch(test_atomic_inc_and_test, NULL, SKIP_MAIN);
-	rte_atomic32_set(&synchro, 1);
-	rte_eal_mp_wait_lcore();
-	rte_atomic32_clear(&synchro);
-
-	if (rte_atomic64_read(&count) != NUM_ATOMIC_TYPES) {
-		printf("Atomic inc and test failed %d\n", (int)count.cnt);
-		return -1;
-	}
-
-	/*
-	 * Same as above, but this time we set the values to "number of worker
-	 * lcores", and decrement instead of increment.
-	 */
-	printf("dec and test\n");
-
-	rte_atomic32_clear(&synchro);
-	rte_atomic64_clear(&count);
-
-	rte_atomic64_set(&a64, (int64_t)(rte_lcore_count() - 1));
-	rte_atomic32_set(&a32, (int32_t)(rte_lcore_count() - 1));
-	rte_atomic16_set(&a16, (int16_t)(rte_lcore_count() - 1));
-	rte_eal_mp_remote_launch(test_atomic_dec_and_test, NULL, SKIP_MAIN);
-	rte_atomic32_set(&synchro, 1);
-	rte_eal_mp_wait_lcore();
-	rte_atomic32_clear(&synchro);
-
-	if (rte_atomic64_read(&count) != NUM_ATOMIC_TYPES) {
-		printf("Atomic dec and test failed\n");
-		return -1;
-	}
+	num_iterations = test_scale_iterations(N_BASE, N_MIN);
 
-#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
 	/*
 	 * This case tests the functionality of rte_atomic128_cmp_exchange
 	 * API. It calls rte_atomic128_cmp_exchange with four kinds of memory
@@ -591,58 +149,35 @@ test_atomic(void)
 	 * it is, the test passes.
 	 */
 	printf("128-bit compare and swap test\n");
-	uint64_t iterations = 0;
 
-	rte_atomic32_clear(&synchro);
+	rte_atomic_store_explicit(&synchro, 0, rte_memory_order_relaxed);
 	count128.val[0] = 0;
 	count128.val[1] = 0;
 
-	rte_eal_mp_remote_launch(test_atomic128_cmp_exchange, NULL,
-				 SKIP_MAIN);
-	rte_atomic32_set(&synchro, 1);
+	rte_eal_mp_remote_launch(test_atomic128_cmp_exchange, NULL, SKIP_MAIN);
+	rte_atomic_store_explicit(&synchro, 1, rte_memory_order_relaxed);
 	rte_eal_mp_wait_lcore();
-	rte_atomic32_clear(&synchro);
+	rte_atomic_store_explicit(&synchro, 0, rte_memory_order_relaxed);
 
 	iterations = count128.val[0] - count128.val[1];
-	if (iterations != (uint64_t)4*num_iterations*(rte_lcore_count()-1)) {
+	if (iterations != (uint64_t)4 * num_iterations * (rte_lcore_count() - 1)) {
 		printf("128-bit compare and swap failed\n");
 		return -1;
 	}
-#endif
 
-	/*
-	 * Test 16/32/64bit atomic exchange.
-	 */
-	test64_t t;
-
-	printf("exchange test\n");
-
-	rte_atomic32_clear(&synchro);
-	rte_atomic64_clear(&count);
-
-	/* Generate the CRC8 lookup table */
-	build_crc8_table();
+	return 0;
+}
 
-	/* Create the initial tokens used by the test */
-	t.u64 = rte_rand();
-	token16 = (get_crc8(&t.u8[0], sizeof(token16) - 1) << 8)
-		| (t.u16[0] & 0x00ff);
-	token32 = ((uint32_t)get_crc8(&t.u8[0], sizeof(token32) - 1) << 24)
-		| (t.u32[0] & 0x00ffffff);
-	token64 = ((uint64_t)get_crc8(&t.u8[0], sizeof(token64) - 1) << 56)
-		| (t.u64 & 0x00ffffffffffffff);
+#else
 
-	rte_eal_mp_remote_launch(test_atomic_exchange, NULL, SKIP_MAIN);
-	rte_atomic32_set(&synchro, 1);
-	rte_eal_mp_wait_lcore();
-	rte_atomic32_clear(&synchro);
+static int
+test_atomic(void)
+{
+	printf("128 bit exchange not implemented\n");
+	return TEST_SKIPPED;
+}
 
-	if (rte_atomic64_read(&count) > 0) {
-		printf("Atomic exchange test failed\n");
-		return -1;
-	}
+#endif
 
-	return 0;
-}
 REGISTER_FAST_TEST(atomic_autotest, NOHUGE_SKIP, ASAN_OK, test_atomic);
 #endif /* RTE_TOOLCHAIN_MSVC */
-- 
2.53.0

