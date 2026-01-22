Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48192C44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08E95402BD;
	Thu, 22 Jan 2026 01:54:09 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 5B4A640671
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:07 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so295495f8f.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043247;
 x=1769648047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=os8FXUqCLGo0LeWEVv2nt+ybNzA5Mj3bHiqS0P1YgtI=;
 b=s+olmxnhdihmF6zKf9qNxbFLaMh+LjmtwQ5p+mtnHYCRgefunzJEEPJmuKasQWVGJF
 hZXLvYpYmN+S5IURTHjw0LbSXPBd2Xwkb/ZF5FdcBt4qgB1HI5vQQB9tl43A3AuxqfzJ
 uPVse/c4lSgj03tDKa7ZQa4BOgw5gAD+0+LTRUC/GjCamCquT+Q7Q/juCHCbrWB78Dm4
 Pwun17DEboH2T4WCwLAFXz3yQB32euxzBfexlldlOQQwzOe+vaaLCIzEwBz6V2ASP9ZJ
 NK58a8IBpOfEYiLFmoETGf0ap9kwAmta1nsrg30rJXYj0qZJpfj5seFR2sR4ewRgJmTq
 Ol9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043247; x=1769648047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=os8FXUqCLGo0LeWEVv2nt+ybNzA5Mj3bHiqS0P1YgtI=;
 b=STNAhW354kheKS1ctfN3Ofa4Bac9/E5lGRn89MhLQkHCw3ju+qxyORbqjFWhDmBSAt
 vGPKQeofIN/GjEpjjLbCTag2vP1Tq9OX2QnkrS74M7Dtn3y4zGvDbdj5absi7DvscLXr
 /Upd8UEU9g8Dtcd8XTCeT45c/SYtIN4bzJBzRYmLkTyPcZTtitD+3a1UuMHPfwAVYTGx
 p47R7w7WQKbyAYOOlUr+61U+zTntbdFC1DXXjO4I5jCK5oRchmD7Us67lq1okkfzp33H
 tn4c4q5DKY151duzW3Pd4V6lRT3uJ2sxhZg71PKTFQZE40GpGznJskdkDmULBtDdgrQG
 BBGw==
X-Gm-Message-State: AOJu0YyIyh7Z2cljZUShfaCHnqoKkEBJrSLuSVt8cwTxIfRvQq7cZgdc
 ABp1eIu9qEDxDm2TB/krRde3JTa5vUAl+hHXpR7EswBrI3fzrEIUGaisk8enc1485AVXTcZxeev
 ZCsA9
X-Gm-Gg: AZuq6aI/2E3K3eXGW2dG/VxrgfYiHHajkMuoEMNVLwNVJll5XumTz47GEwCqP7vsmah
 y363D+B/PacjN9OyoXceh6mMsvNG5+T+guS//SFqSIVo/LK6ILX7BxSxyOuIUMjcy1+EIv5NRS8
 BW9M8kBqTTgerGc7UohNQxEHagHDC/MuSl+y0QkQ7/90fGo3aVQjr05Eowy5E6GV9Ss5GPug6Sj
 fYlxmKQbBX2xO4OKMbjKmU5Yjff6iPfNmaH0Y45FFlNtPyYIU4Mmv6VKCK9T31IzfGQ61ki4qIH
 8cILt9jnZDHVAWWcCBbOXuKMGSUbeLgcUOI7x8GctC9SO3geX2ovkzEk9k5S3j3JNHQCKJS1dKg
 BPkMHBq4e/jiBwV6uKl93Ykuz5mPfdMCCuxgy4gs5AtZenG8F+ZIIjjU+MzM0hXSG6AAlSC/jhd
 CgBgjEYK0GjJzruzaIF2e6C17cIoPUCokCOwHkESAsCRnlAsB07w==
X-Received: by 2002:a5d:64e7:0:b0:432:857d:e42c with SMTP id
 ffacd0b85a97d-43569bc4a97mr24138915f8f.34.1769043246853; 
 Wed, 21 Jan 2026 16:54:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 02/14] test: scale atomic test based on core count
Date: Wed, 21 Jan 2026 16:50:18 -0800
Message-ID: <20260122005356.1168221-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

