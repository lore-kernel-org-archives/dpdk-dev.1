Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C17D2ECFE
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:58:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA0E8406BC;
	Tue, 20 Jan 2026 02:58:10 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 5FE1440693
 for <dev@dpdk.org>; Tue, 20 Jan 2026 02:58:09 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8710c9cddbso597596866b.2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 17:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768874289;
 x=1769479089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MWi/1K0bZ66PUGIAR7MKa1hBAzECtNAD2/Kuo+sn0I=;
 b=qbc3sBvuafVv+Q50rrQ1DN38pX5O7lMAn3q/8Vh1nfrLhTLwP/p6fqYe5dnO2fi0jZ
 uTPi5+OFJrhyn8iwfZdqlsWoNRUHMpim1qxCBVAt9U4CYaVq3TsIKqb2DPCWJ7uW3WYp
 UW+CAepo9Z2k7Z8zEPz4sR8z2c+ulhfSarGpF21t62crGEw7PuDoa9/IfAqSx/5R/L/2
 a3voi9Oz5VuvSpjMCs4c5yqyAYGDv0d/n2L/jKHKCTn/rg7tOLKeFku996fh53dEXnxu
 Ct77ee9ew7JDKrWrhm4wON/IAM1C2obo3IxS9gWSpLLlLCwX2AduIXyuF/ujRE8gAjpl
 ag5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768874289; x=1769479089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/MWi/1K0bZ66PUGIAR7MKa1hBAzECtNAD2/Kuo+sn0I=;
 b=s7fBSebN4vvDC3tDjhov3jAUq/hE/WG9N6EkoY6OEUiS32eBEPXa4yRSc1ByHOvbQq
 xiahkzhxzvQBX4GGyq7njZfqKjzpCYtGKher5bOXQ6476THgCBCYQsc9w55pvSHP8DsH
 GDqXLRQeYUKOyeY52CYErY0vqBCG/bVcIkH0MQfg01ujOwFFvUTCNTiU8kQ7DNkW91Gc
 w2avRw9uzT/2ZFnIFokdakJHNUdtgl6B7cezNRzy64Wvmm1FXrFSKERgfWAxamxGVbyi
 Oe0axTkjoXopIi70fe53ZLzs6rIILn0i34l0Zfb2KGF4hVnAnMZSYA2NrGplYIAb9CSV
 np3Q==
X-Gm-Message-State: AOJu0YwmdxvcpD1zWkV5Xy0pixu/68LGWXQn2fegS+OTqdh6t7L19PLe
 KS5E8FmWVrmSQ7IeKfk6G+yfiDNjRflk1eyI0G2maWHAQNmpVQ2PTkUopXuGNMfbSuK4B+kd7dr
 myIf9
X-Gm-Gg: AZuq6aJKDd2kHRAR/inMTXjudCMPn8THR2QiJtVhJ9g5+lb9X2/BxGRbU3aINabMmXh
 ljfvBUGWSHLjH1pAff13UWVVuUTuVei8f0403JkQts6rdTs13bIUgqnPPHrMTk+c4Jwj5/OyC26
 YmrJrg4AWDosRov4UwJ4nGSGfccl4HhW0kLolMNWahnNt7An9Pc5uC6E8xDPtePSOPHKSoGXcqW
 sRar9ZU6jpgto28HYosTlCpLGhkfhmmvfL3qtFT5qemTwT0bEYL01mX1cPxaJTzbwGUnrqcv1ei
 K/QX/Gt3zVYKKNnh/ojFGXkvm8YqNQCAFJbHuBLrE3cJqxnfKN0X4vKLcKAR7/Gqaya1824KKIL
 e3ilnFBKC/gGFG1/v863Nz2h1dtPismgG23AhIG4BdUdoyTT8RG2oPaO1HHPyQ3Nx+vSppBvG0C
 tQxiqMdviNadlLSpm1Iptww8/bta1JKErKnwg8EUo0TlJT67XOIg==
X-Received: by 2002:a17:907:7b85:b0:b76:f090:7779 with SMTP id
 a640c23a62f3a-b8796afd690mr1179743166b.33.1768874288767; 
 Mon, 19 Jan 2026 17:58:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879516900csm1342225366b.23.2026.01.19.17.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 17:58:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 2/6] test: fix timeout for atomic test on high core count
 systems
Date: Mon, 19 Jan 2026 17:55:05 -0800
Message-ID: <20260120015759.301155-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120015759.301155-1-stephen@networkplumber.org>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
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

Bugzilla ID: 952
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_atomic.c | 52 ++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index b1a0d40ece..ccd8e5d29b 100644
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
@@ -446,6 +455,9 @@ test_atomic_exchange(__rte_unused void *arg)
 static int
 test_atomic(void)
 {
+	/* Scale iterations by number of cores to keep test duration reasonable */
+	num_iterations = RTE_MAX(N_BASE / rte_lcore_count(), N_MIN);
+
 	rte_atomic16_init(&a16);
 	rte_atomic32_init(&a32);
 	rte_atomic64_init(&a64);
@@ -593,7 +605,7 @@ test_atomic(void)
 	rte_atomic32_clear(&synchro);
 
 	iterations = count128.val[0] - count128.val[1];
-	if (iterations != (uint64_t)4*N*(rte_lcore_count()-1)) {
+	if (iterations != (uint64_t)4*num_iterations*(rte_lcore_count()-1)) {
 		printf("128-bit compare and swap failed\n");
 		return -1;
 	}
-- 
2.51.0

