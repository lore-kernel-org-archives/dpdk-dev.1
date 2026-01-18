Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41124C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 20:12:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2946E40E36;
	Sun, 18 Jan 2026 21:12:34 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E58E5402B3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 21:12:32 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so25198075e9.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768767152;
 x=1769371952; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MWi/1K0bZ66PUGIAR7MKa1hBAzECtNAD2/Kuo+sn0I=;
 b=nHLm4dkMyUFqsKrqjTeYG7fVHf8xAfYc4HETzc3KI7Ny1zQ0fO+rbrTA87xrzhOtn6
 BNbNR8OgRiq6AcaoMW4svwnZYJeKUdMxq9i0Yf6NOTTT1RQHqI7yVgWyYiHghZ4CiiXh
 cuJWxTQlh8wHTuyfywwCk7C4vFI0KtwdB+R6APh0VGqjNvh41lY2fAJZE6+I12GBftkV
 tsY4JLbqUndYI1oncYIsb/ZzNXzZ5xcHvEBkT5cP5vj4SvTBQGA8z7/XChfNj7S89Pg4
 W1hwQJ5UVws8py7efskr7xqFMfFEIkl05BJl+h/YLoAp30p746+EoR3xRFlDnqPAPaLE
 +grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768767152; x=1769371952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/MWi/1K0bZ66PUGIAR7MKa1hBAzECtNAD2/Kuo+sn0I=;
 b=agxWXuVm6gFYQZiQ2WTVjU6OJUMwjX5q62k0yUfUPHqZLK6z5m9viIqfBQBnskMC/X
 /SxDF1RwiaL1rxdE5YNaMgkiX03JMrzogHYvb4qmmAoC9CyOYr03dh+R0nZCPSzuIgLE
 44ePfQpJwIguJbLrb07j2xuW2IRM35Azv9t2z94NFq4GZ4dCGLFYL9Wng1IKD8KrclvF
 dhKct3Qr7/lF0+V4QzXJKWYMSf3/Ra6azRJlljcATx+CrhJIlvZPmpJRinvUa2rMx66N
 QjyFbMIgorO4IuNKqO40UlRLP/1xMS5SGW5guKWtYQ2cC4fv4q06Dst1Vhd5UZjgoNz1
 7Vrg==
X-Gm-Message-State: AOJu0YwT6s4igBfXheuW7cI1IUKDP3uaZ3/VUrmTSzb5q1R6pmf48BbG
 tKmR41UxLccf8HAIPvoe4IJBkacuOg4IYfiw7L09WO5/IR24x7MWU4Zu5txllcAFB20Qkcnpns/
 rPnU5
X-Gm-Gg: AY/fxX6ghC2Sk8W7JYPTamV/2WUGFgphM1IPKzz3DqmCmsW4ZJLF6EbSVI9G8xZTThq
 dNoYreLcKCD6Cn0ZL3jNANRg/W1oikvFnWcfV23+7jwoNEjIOHLd89K/noSFl3KU3VynIni7xiP
 g+DDebBwwdV1nzZULzzcMHO8T5V61XmWsEwzlSxaS2AKDP7W4bIbqY8w/6w8Rm2Lx2ufoe3hyUZ
 vpxrgEVUSh2N6FDHxKYyD0F15zkQXY4wheKfbZbWYOZ6UxgG9hYrujf959rN+5MwxjlOvvgH3nE
 wG0yf3rpqcVZlRF8T6hdxA0wvTqfHLMG7Z24Ql8ISadrGmPVenX0iLp0fjo3E/lQ1KCdbbLxZov
 8u5y2gKw4nGxnD2xKXFAGW6eBtHLJ4jwFAbJ2oYJCDKHutb8bK1sNjwGkQN4L3GO74qwT7auyvq
 A1XRNq0ZwHjcC/n1CCSxiimDuyjKKZA/KZoMTujCvHyz3FILG+zQ==
X-Received: by 2002:a05:600c:528c:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-4801e2fdd1fmr92106165e9.3.1768767152464; 
 Sun, 18 Jan 2026 12:12:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6d9a7sm66364795e9.17.2026.01.18.12.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 12:12:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH 2/6] test: fix timeout for atomic test on high core count
 systems
Date: Sun, 18 Jan 2026 12:09:09 -0800
Message-ID: <20260118201223.323024-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118201223.323024-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
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

