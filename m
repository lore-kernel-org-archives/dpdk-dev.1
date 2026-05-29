Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C39ACD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 17:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AAD040691;
	Fri, 29 May 2026 19:14:30 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id F13E44064A
 for <dev@dpdk.org>; Fri, 29 May 2026 19:14:26 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304545f5206so11193254eec.0
 for <dev@dpdk.org>; Fri, 29 May 2026 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780074866;
 x=1780679666; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lq5AzR+nGmlmfjScXx28H5a8G1qBpaAtfVjtXWbERgo=;
 b=toNFWo7tJ6yEbnQNip2yCqhlSkZ0X9Z1A7IsF3p6EG8MV+W6j7WOng70XpQsmHgT3P
 H+td18Tm6yTjy+d1CGyXYDbWklYwY91J2bU/CgqJz1FFNcA00I3R677hfPJHkwIdzbSG
 v/HWRs1lxY6KCkqYARU3sbCq5oyUyHofZyfOPjj3sIurE+Ex36QiZCscfwd/k/ZSfM97
 dXV0ghEq4r6wvLT3baiaNOwWZvaaM0Dka8ZP6lGZGVXNaCCrEc+RrydGHo85wdebkTul
 sMAD9mf5KrW3IpW9ZxYTU7kNgPJy03SSueIp9ga8L/avWV+3wfQNRzt2bbsplZIC7Un0
 Aylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074866; x=1780679666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lq5AzR+nGmlmfjScXx28H5a8G1qBpaAtfVjtXWbERgo=;
 b=Jk9n/VG7TV+bxAJEToNVfUCyPahTg/DKBTkKWhZwo/uHdku1Gff1y8pY/dc64sW1am
 4hXigWdtesFaX90XiBHRPgjFJZtUlXyP6VZ+wtJvSfHakzYJVG75GnsbS+WApDjacTSX
 QJ/GYHkQHsP/v438V47sYpnb50zj8pdjqvtQ2oJyRhZ/QuaVInjzF2JS3LLXP9VxhRIg
 lKwo30k8ZaOgSmyWn2CkEwG0x4zj/QZlGAngkupGE1FMAAjsnEa5qcjWUl7y7sK8fmeq
 mSKkaRJX7n2rmnsAlXntuHJDTDWl0UtLdswTTyLS/A9M9LQgxvX5JPQbwLO74Hmz4Isr
 X+MQ==
X-Gm-Message-State: AOJu0Yxozyt1RVMtRjha/uNbK1A/LyV6obTy/WmXHEHeveoGjpbcGtJs
 4I7AmNkyztZ5eOgni3BA7jJsm2yKaLFukKM0Yz4ixN8Ed4zb+i5P/f3EU943LQ6c/eu/T4/a1WJ
 nyTBr
X-Gm-Gg: Acq92OHpSd6YI6emqXnkIwYkuERmu94Vtoud6hTGHYkc7xiyeYDw4s3cv3Gkw7Q1q0i
 7WS5b+AXoLFON0LZoYkp/5dS8O4rhIbnakxq4b+8WWXnX1e5JWflbV4o9p7Zc3ularDOMtd48cS
 ohJgfLw2FQZfG8DPqG0XgEYWV+IMu8hD/oYwJHGh6xViLMK4CTxKcF8CFS3JLjqTuCZCDqUQc/S
 ChesCd2j7ZT5+X3x1muti+mduOLOxqs3q1Fd59x7eNZymAr1vC/0kS5D/Rj89O8WZzPp80tR6pO
 gwkXDL/bsvSESZKG5xEsfhnYnDb+AKwx3/z9J38DNLThfofd4jTe+5qCLq8FzagiBUimjk5iqSN
 HTlKqGIhRFboJAr0smeBZy+hGdk375iesCg3EC6rERSQpUto3UsCrdvGHS7hsLAoW+XtLBTsQ8r
 AIWyc4hoV6q/tW6zl/1xCOVOcWUCtkdCPyIn1LQlclM4UZZ3s+qNZkWI4m21x1GJeZaQ6HJ0P/
X-Received: by 2002:a05:7300:570c:b0:2d4:94cc:eebb with SMTP id
 5a478bee46e88-304fa4f0c80mr377906eec.13.1780074865821; 
 Fri, 29 May 2026 10:14:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm1880350eec.4.2026.05.29.10.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:14:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 5/7] app/test/mempool_perf: scale down for high core counts
Date: Fri, 29 May 2026 10:10:58 -0700
Message-ID: <20260529171417.526892-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529171417.526892-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
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

On a 32-core system the test matrix runs the cartesian product of
4 mempools, 3 core-count configurations and ~340 (n_keep, bulk)
points at TIME_S=1 second each: about 67 minutes total, well past
the 10 minute perf-test timeout.

Two reductions, no loss of meaningful signal:

1. Per-point duration: 1 second -> 200 ms.  Each point currently
   collects 10^5-10^6 mempool ops; 200 ms still yields >10^4
   samples, well above the noise floor for a cycles-per-op average.

2. Matrix trim: drop adjacent bulk and n_keep points that don't
   produce regime changes.  Retained set covers the boundaries
   that matter: 1, 4, cache-line burst (8), typical packet burst
   (32) and cache size (RTE_MEMPOOL_CACHE_MAX_SIZE = 512) for bulk;
   32 (fits in cache), 512 (= cache size) and 32768 (far exceeds
   cache) for n_keep.

Combined effect: ~10x runtime reduction.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mempool_perf.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index dd2f0bbaca..6801812a8d 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -61,26 +61,21 @@
  *
  *    - Pseudorandom max bulk size (*n_max_bulk*)
  *
- *      - Max bulk from CACHE_LINE_BURST to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE,
- *        where CACHE_LINE_BURST is the number of pointers fitting into one CPU cache line.
+ *      - Max bulk: CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE,
+ *        where CACHE_LINE_BURST is the number of pointers fitting into
+ *        one CPU cache line.
  *
  *    - Fixed bulk size (*n_get_bulk*, *n_put_bulk*)
  *
- *      - Bulk get from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
- *      - Bulk put from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
- *      - Bulk get and put from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE, compile time constant
+ *      - Bulk get: 1, 4, CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE
+ *      - Bulk put: 1, 4, CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE
  *
  *    - Number of kept objects (*n_keep*)
  *
- *      - 32
- *      - 128
- *      - 512
- *      - 2048
- *      - 8192
- *      - 32768
+ *      - 32, 512, 32768
  */
 
-#define TIME_S 1
+#define TIME_MS 200
 #define MEMPOOL_ELT_SIZE 2048
 #define MAX_KEEP 32768
 #define N (128 * MAX_KEEP)
@@ -257,7 +252,7 @@ per_lcore_mempool_test(void *arg)
 
 	start_cycles = rte_get_timer_cycles();
 
-	while (time_diff/hz < TIME_S) {
+	while (time_diff < hz * TIME_MS / 1000) {
 		if (n_max_bulk != 0)
 			ret = test_loop_random(mp, cache, n_keep, n_max_bulk);
 		else if (!use_constant_values)
@@ -376,13 +371,10 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 static int
 do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cache)
 {
-	unsigned int bulk_tab_max[] = { CACHE_LINE_BURST, 32, 64, 128, 256,
-			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
-	unsigned int bulk_tab_get[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
-			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
-	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
-			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
-	unsigned int keep_tab[] = { 32, 128, 512, 2048, 8192, 32768, 0 };
+	unsigned int bulk_tab_max[] = { CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
+	unsigned int bulk_tab_get[] = { 1, 4, CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
+	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
+	unsigned int keep_tab[] = { 32, 512, 32768, 0 };
 	unsigned int *max_bulk_ptr;
 	unsigned int *get_bulk_ptr;
 	unsigned int *put_bulk_ptr;
-- 
2.53.0

