Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772A6F47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 296B341156;
	Thu,  5 Mar 2026 18:53:36 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 619A241060
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:33 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8cbad8e6610so900055885a.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733213;
 x=1773338013; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=os8FXUqCLGo0LeWEVv2nt+ybNzA5Mj3bHiqS0P1YgtI=;
 b=h3fVA7ssT9+DBCUdoY8sDQYlDIOYNULMqhEHJK+jwW7wQ1e4Dul2U+w9s1a0Uvkccx
 v3ndPkZs/6hGLM1cds7szRR9faY8BWU0+X2nAHIhQCS18ds9khYMK3jGvoWfjpbSNAYY
 KdYMroqjqZiaD51FatGlUe+W/uQ6et2jRCkyIGbxH72ONGVKgDY1lEab25J68Z0LscSU
 HD5LQ4WSMGIVaHutgzbtJ6hsMTctdgpWgKTriQs4gC0fYwObXOhTZm3Czs3XvJkPVeyF
 EQi/NSXiYLcl3Yf9LKSJDnd4AoZo5H/zTkzOjuZD1+JR9z+h9cEaxY1CY+L5luDeHd2V
 L4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733213; x=1773338013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=os8FXUqCLGo0LeWEVv2nt+ybNzA5Mj3bHiqS0P1YgtI=;
 b=s/9VUaOR4h8Zsc3z94pyQlJxLxKiusFWWUaNlS53jYC3q90d3SNp3yXAhPtTmRa6jx
 +4RszcG+Z/pEMpcFtE3gvdadlQwTm42UlcLfHrszydMipD1Xhi8WmYCPDTGB+wKvZ9ub
 FRC7BMYoZ37HBmgRk5DJ85iixxrDeLHOFH6Va5OkmYXYa1KtDQOrHtLTGziv/z8xjK0+
 CBbDzm2t8IUiftHt49jYJiXrMjjbsUzk+W+Jsqss8xSq7raO0EWN6ZeR84B5/6PaNPzo
 e3icekOBxNrA/1cAgHRnjFqUTl2IbR8FkV+bGl6BiTOjrNKeBqoHWHzONDrLct+r4/C8
 1rTg==
X-Gm-Message-State: AOJu0Yxech7AKiddgDcgJO/Q4wmpR3PRsKcj0NMQ3MnFf8oDXA/DJAcR
 ZRvRDoBiDc4Ru53T0mCzXd1AYoYo0X1HRuJbbU+7x6ZMhVt7SbNUhsC98FGBYScbZQyMYZPj38+
 udpo7
X-Gm-Gg: ATEYQzz4eQ034HZmWGW3bNYUP2fg3VndDsa05Uetc94xokl6H4BCgR5T2qCC28kgN3x
 R7vUXs3DLN1841ekZ1DlGe89E0Pqix5YnwSqukUwD1+SepuYQrN8BDfH7aXGcuiEo1b7muc+tTU
 rH5qtBrCLet1/Im6tRD1/afMlueMu9xd+GLvbTYS8U9fTDC8LCwkeDfiTxHTKOZDjLHMIgftZII
 sBlnqMknzTx51AZx1nci7apK8qzxU+UEqzp0c0CiY6kJuKQKIw8SsRrilvtoDPA+h3pQNVTgr2e
 ASRfPVzO9zIxm1kemqPMpXK+OQ6O5Plb0In1sVbLV4tQpStgwTHDqKWSOPdGKaJbABSmpC9HjQ2
 KC2qHRwd5KEL1j46QskQ6VMOJC8W6a71MYqcJSOgLFxQoaAUK5kbSTXj5sHtVmIfP/aFGHVe7SE
 Cw7o+Pak2v0bczEpC8jlOb9zDDcau+Cm+vo0R7bYK2CqQC2odTIS5e+NEf445SzQ==
X-Received: by 2002:a05:620a:1985:b0:8ca:4392:c20d with SMTP id
 af79cd13be357-8cd6b047ea0mr96994985a.80.1772733212635; 
 Thu, 05 Mar 2026 09:53:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 02/11] test/atomic: scale test based on core count
Date: Thu,  5 Mar 2026 09:50:56 -0800
Message-ID: <20260305175326.279891-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

The atomic test uses tight spinloops to synchronize worker threads
and performs a fixed 1,000,000 iterations per worker. This causes
two problems on high core count systems:

With many cores (e.g., 32), the massive contention on shared
atomic variables causes the test to exceed the 10 second timeout.

Scale iterations inversely with core count to maintain roughly
constant test duration regardless of system size

With 32 cores, iterations drop from 1,000,000 to 31,250 per worker,
which keeps the test well within the timeout while still providing
meaningful coverage.

Add helper function to test.h so that other similar problems
can be addressed in followon patches.

Bugzilla ID: 952
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test.h        | 19 ++++++++++++++++
 app/test/test_atomic.c | 51 +++++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/app/test/test.h b/app/test/test.h
index 10dc45f19d..1f12fc5397 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -12,6 +12,7 @@
 
 #include <rte_hexdump.h>
 #include <rte_common.h>
+#include <rte_lcore.h>
 #include <rte_os_shim.h>
 
 #define TEST_SUCCESS EXIT_SUCCESS
@@ -223,4 +224,22 @@ void add_test_command(struct test_command *t);
  */
 #define REGISTER_ATTIC_TEST REGISTER_TEST_COMMAND
 
+/**
+ * Scale test iterations inversely with core count.
+ *
+ * On high core count systems, tests with per-core work can exceed
+ * timeout limits due to increased lock contention and scheduling
+ * overhead. This helper scales iterations to keep total test time
+ * roughly constant regardless of core count.
+ *
+ * @param base  Base iteration count (used on single-core systems)
+ * @param min   Minimum iterations (floor to ensure meaningful testing)
+ * @return      Scaled iteration count
+ */
+static inline unsigned int
+test_scale_iterations(unsigned int base, unsigned int min)
+{
+	return RTE_MAX(base / rte_lcore_count(), min);
+}
+
 #endif
diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index b1a0d40ece..2a4531b833 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -10,6 +10,7 @@
 #include <sys/queue.h>
 
 #include <rte_memory.h>
+#include <rte_common.h>
 #include <rte_per_lcore.h>
 #include <rte_launch.h>
 #include <rte_atomic.h>
@@ -101,7 +102,15 @@
 
 #define NUM_ATOMIC_TYPES 3
 
-#define N 1000000
+#define N_BASE 1000000u
+#define N_MIN  10000u
+
+/*
+ * Number of iterations for each test, scaled inversely with core count.
+ * More cores means more contention which increases time per operation.
+ * Calculated once at test start to avoid repeated computation in workers.
+ */
+static unsigned int num_iterations;
 
 static rte_atomic16_t a16;
 static rte_atomic32_t a32;
@@ -112,36 +121,36 @@ static rte_atomic32_t synchro;
 static int
 test_atomic_usual(__rte_unused void *arg)
 {
-	unsigned i;
+	unsigned int i;
 
 	while (rte_atomic32_read(&synchro) == 0)
 		rte_pause();
 
-	for (i = 0; i < N; i++)
+	for (i = 0; i < num_iterations; i++)
 		rte_atomic16_inc(&a16);
-	for (i = 0; i < N; i++)
+	for (i = 0; i < num_iterations; i++)
 		rte_atomic16_dec(&a16);
-	for (i = 0; i < (N / 5); i++)
+	for (i = 0; i < (num_iterations / 5); i++)
 		rte_atomic16_add(&a16, 5);
-	for (i = 0; i < (N / 5); i++)
+	for (i = 0; i < (num_iterations / 5); i++)
 		rte_atomic16_sub(&a16, 5);
 
-	for (i = 0; i < N; i++)
+	for (i = 0; i < num_iterations; i++)
 		rte_atomic32_inc(&a32);
-	for (i = 0; i < N; i++)
+	for (i = 0; i < num_iterations; i++)
 		rte_atomic32_dec(&a32);
-	for (i = 0; i < (N / 5); i++)
+	for (i = 0; i < (num_iterations / 5); i++)
 		rte_atomic32_add(&a32, 5);
-	for (i = 0; i < (N / 5); i++)
+	for (i = 0; i < (num_iterations / 5); i++)
 		rte_atomic32_sub(&a32, 5);
 
-	for (i = 0; i < N; i++)
+	for (i = 0; i < num_iterations; i++)
 		rte_atomic64_inc(&a64);
-	for (i = 0; i < N; i++)
+	for (i = 0; i < num_iterations; i++)
 		rte_atomic64_dec(&a64);
-	for (i = 0; i < (N / 5); i++)
+	for (i = 0; i < (num_iterations / 5); i++)
 		rte_atomic64_add(&a64, 5);
-	for (i = 0; i < (N / 5); i++)
+	for (i = 0; i < (num_iterations / 5); i++)
 		rte_atomic64_sub(&a64, 5);
 
 	return 0;
@@ -169,12 +178,12 @@ test_atomic_addsub_and_return(__rte_unused void *arg)
 	uint32_t tmp16;
 	uint32_t tmp32;
 	uint64_t tmp64;
-	unsigned i;
+	unsigned int i;
 
 	while (rte_atomic32_read(&synchro) == 0)
 		rte_pause();
 
-	for (i = 0; i < N; i++) {
+	for (i = 0; i < num_iterations; i++) {
 		tmp16 = rte_atomic16_add_return(&a16, 1);
 		rte_atomic64_add(&count, tmp16);
 
@@ -274,7 +283,7 @@ test_atomic128_cmp_exchange(__rte_unused void *arg)
 
 	expected = count128;
 
-	for (i = 0; i < N; i++) {
+	for (i = 0; i < num_iterations; i++) {
 		do {
 			rte_int128_t desired;
 
@@ -401,7 +410,7 @@ get_crc8(uint8_t *message, int length)
 static int
 test_atomic_exchange(__rte_unused void *arg)
 {
-	int i;
+	unsigned int i;
 	test16_t nt16, ot16; /* new token, old token */
 	test32_t nt32, ot32;
 	test64_t nt64, ot64;
@@ -417,7 +426,7 @@ test_atomic_exchange(__rte_unused void *arg)
 	 * appropriate crc32 hash for the data) then the test iteration has
 	 * passed.  If the token is invalid, increment the counter.
 	 */
-	for (i = 0; i < N; i++) {
+	for (i = 0; i < num_iterations; i++) {
 
 		/* Test 64bit Atomic Exchange */
 		nt64.u64 = rte_rand();
@@ -446,6 +455,8 @@ test_atomic_exchange(__rte_unused void *arg)
 static int
 test_atomic(void)
 {
+	num_iterations = test_scale_iterations(N_BASE, N_MIN);
+
 	rte_atomic16_init(&a16);
 	rte_atomic32_init(&a32);
 	rte_atomic64_init(&a64);
@@ -593,7 +604,7 @@ test_atomic(void)
 	rte_atomic32_clear(&synchro);
 
 	iterations = count128.val[0] - count128.val[1];
-	if (iterations != (uint64_t)4*N*(rte_lcore_count()-1)) {
+	if (iterations != (uint64_t)4*num_iterations*(rte_lcore_count()-1)) {
 		printf("128-bit compare and swap failed\n");
 		return -1;
 	}
-- 
2.51.0

