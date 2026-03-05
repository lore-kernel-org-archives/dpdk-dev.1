Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC3F47CA3
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18662410E3;
	Thu,  5 Mar 2026 18:53:34 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 65E7741060
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:32 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-89a0ece9f14so44524146d6.3
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733212;
 x=1773338012; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eJuhiWWqC1V/QJY7iIabIFA6em2UhaYMwHjZukwhrs=;
 b=tJtLSE8RPzPnUQ0GyDtshDAJg322H9ZSZBq4Y89LcQZG/Z0Mf7aumZvOGHgKvLXVMS
 1gl5Pv3X+RX7rYSXWx5jSW4gNp9AEWa7LGr5roLlabNxoUla8R5ca+canVTaAxK2ZVkb
 DfZbrz8orhv4wcAfu/DRXoGSpZMPiTGBSHO10Mod/Q6rr0mAOOO2gqtEPTOl0f6ocFrU
 VxveuKpqhbNZXX0qffesE7MyGsxw593YVYotE8xyjdXcCoClr+bQJKUm/iZBO1OdmYBT
 iCj9jwJC1Hvjz/pU/YhmhxpA7MJu+64Q6aMLc0t3DmRSozTzRUobFljk8ra8toHi1Wd/
 aymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733212; x=1773338012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9eJuhiWWqC1V/QJY7iIabIFA6em2UhaYMwHjZukwhrs=;
 b=gu8GS7fdUuUzBGaHPmZrRhlJY33cJJOsf3CWWOZ3aB5mpm+g4srGtZBo+PCxdTaage
 ikHJy2FqgJbKP1wA1y5JB+ZoWoBtJF5l9J7OrD3CCqeE3ocPAf3+QyYKiqAe9bjofFoj
 1EZPyWedT6Gp66aMRT3vNDHl/V9uh8bJsqhE1lTbkPil/ows9JjMQtNU0HDIJs/I3DW4
 4INnN8RIj/x/t9A2sGfVRr4alOftR+/lktPU2q03IsnU9CTFzAH9GgvU1hprSPEcLM/M
 lbhJ9eQmqO7mXaxipxLz0EAX0mZ8U2kKMWIUTGu8pgiXfyvEnIE8OlHGgqBbf7gR/+DP
 Pkrg==
X-Gm-Message-State: AOJu0YztyaUWmZJxmK8YoEdMzIuOS2r8sIy0C/9sx1ep2IX1OcAY9KUT
 ZAvPzIF2aEVdOUy5MgYxFGFnB+cAChiyRPHah4Hb8dVaHJ0Di2xVSr9nspmX+2SMN18bSGzLEOz
 QIru8
X-Gm-Gg: ATEYQzzfD5+2IRvn3VJABgVw1n2T3lc5Oidzh1TM01UmEZnolOfrL1NjSE8H/wzOFSb
 Kyk8UHJDJa8Fuq+XNXTJaraaqa8yfcoK9V2/zb+y71NrFv2mFBagTrkXveUgRWVoe/HjplDus59
 FA55HBzqr72nMC2i6+Si9SFl7eoVhf0wPZgkL/CniUDR5xOn6Zr/A+EmanbBAWZVezxiTofqbKJ
 8LK/CeYcsc1dMtSB854OkzXHXdoC2mQYUCMGDYFQzzMklO1yB8IWEDkqGpaY/HdunIqf5RRndTy
 H/khiCZlHQjozhu2h4HQtb0W+LoNmyRwqw+NNAofXDf83sGQhiTzBoU1XC1qqhT758rZA1r7d9r
 6Xj5EhT7k+oxfmuXWNETieLEmz0m4XBukFZ+hUBpI19dxY9Y6E/UtO8XLOWXU8jNBGJpPA7YL7s
 XgYtKBCMin8UgWzRpkTeh9Mdzz2McZ74IP41jqnpvDNBapwAe3JAtAN4zKkOHtRA==
X-Received: by 2002:ad4:5ce6:0:b0:899:f0b1:7338 with SMTP id
 6a1803df08f44-89a2e000183mr11902816d6.37.1772733211607; 
 Thu, 05 Mar 2026 09:53:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 01/11] test: add pause to synchronization spinloops
Date: Thu,  5 Mar 2026 09:50:55 -0800
Message-ID: <20260305175326.279891-2-stephen@networkplumber.org>
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

The atomic and thread tests use tight spinloops to synchronize.
These spinloops lack rte_pause() which causes problems on high core
count systems, particularly AMD Zen architectures where:

- Tight spinloops without pause can starve SMT sibling threads
- Memory ordering and store-buffer forwarding behave differently
- Higher core counts amplify timing windows for race conditions

This manifests as sporadic test failures on systems with 32+ cores
that don't reproduce on smaller core count systems.

Add rte_pause() to all seven synchronization spinloops to allow
proper CPU resource sharing and improve memory ordering behavior.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_atomic.c  | 15 ++++++++-------
 app/test/test_threads.c | 17 +++++++++--------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index 8160a33e0e..b1a0d40ece 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -15,6 +15,7 @@
 #include <rte_atomic.h>
 #include <rte_eal.h>
 #include <rte_lcore.h>
+#include <rte_pause.h>
 #include <rte_random.h>
 #include <rte_hash_crc.h>
 
@@ -114,7 +115,7 @@ test_atomic_usual(__rte_unused void *arg)
 	unsigned i;
 
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	for (i = 0; i < N; i++)
 		rte_atomic16_inc(&a16);
@@ -150,7 +151,7 @@ static int
 test_atomic_tas(__rte_unused void *arg)
 {
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	if (rte_atomic16_test_and_set(&a16))
 		rte_atomic64_inc(&count);
@@ -171,7 +172,7 @@ test_atomic_addsub_and_return(__rte_unused void *arg)
 	unsigned i;
 
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	for (i = 0; i < N; i++) {
 		tmp16 = rte_atomic16_add_return(&a16, 1);
@@ -210,7 +211,7 @@ static int
 test_atomic_inc_and_test(__rte_unused void *arg)
 {
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	if (rte_atomic16_inc_and_test(&a16)) {
 		rte_atomic64_inc(&count);
@@ -237,7 +238,7 @@ static int
 test_atomic_dec_and_test(__rte_unused void *arg)
 {
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	if (rte_atomic16_dec_and_test(&a16))
 		rte_atomic64_inc(&count);
@@ -269,7 +270,7 @@ test_atomic128_cmp_exchange(__rte_unused void *arg)
 	unsigned int i;
 
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	expected = count128;
 
@@ -407,7 +408,7 @@ test_atomic_exchange(__rte_unused void *arg)
 
 	/* Wait until all of the other threads have been dispatched */
 	while (rte_atomic32_read(&synchro) == 0)
-		;
+		rte_pause();
 
 	/*
 	 * Let the battle begin! Every thread attempts to steal the current
diff --git a/app/test/test_threads.c b/app/test/test_threads.c
index 5cd8bd4559..e2700b4a92 100644
--- a/app/test/test_threads.c
+++ b/app/test/test_threads.c
@@ -7,6 +7,7 @@
 #include <rte_thread.h>
 #include <rte_debug.h>
 #include <rte_stdatomic.h>
+#include <rte_pause.h>
 
 #include "test.h"
 
@@ -23,7 +24,7 @@ thread_main(void *arg)
 	rte_atomic_store_explicit(&thread_id_ready, 1, rte_memory_order_release);
 
 	while (rte_atomic_load_explicit(&thread_id_ready, rte_memory_order_acquire) == 1)
-		;
+		rte_pause();
 
 	return 0;
 }
@@ -39,7 +40,7 @@ test_thread_create_join(void)
 		"Failed to create thread.");
 
 	while (rte_atomic_load_explicit(&thread_id_ready, rte_memory_order_acquire) == 0)
-		;
+		rte_pause();
 
 	RTE_TEST_ASSERT(rte_thread_equal(thread_id, thread_main_id) != 0,
 		"Unexpected thread id.");
@@ -63,7 +64,7 @@ test_thread_create_detach(void)
 		&thread_main_id) == 0, "Failed to create thread.");
 
 	while (rte_atomic_load_explicit(&thread_id_ready, rte_memory_order_acquire) == 0)
-		;
+		rte_pause();
 
 	RTE_TEST_ASSERT(rte_thread_equal(thread_id, thread_main_id) != 0,
 		"Unexpected thread id.");
@@ -87,7 +88,7 @@ test_thread_priority(void)
 		"Failed to create thread");
 
 	while (rte_atomic_load_explicit(&thread_id_ready, rte_memory_order_acquire) == 0)
-		;
+		rte_pause();
 
 	priority = RTE_THREAD_PRIORITY_NORMAL;
 	RTE_TEST_ASSERT(rte_thread_set_priority(thread_id, priority) == 0,
@@ -139,7 +140,7 @@ test_thread_affinity(void)
 		"Failed to create thread");
 
 	while (rte_atomic_load_explicit(&thread_id_ready, rte_memory_order_acquire) == 0)
-		;
+		rte_pause();
 
 	RTE_TEST_ASSERT(rte_thread_get_affinity_by_id(thread_id, &cpuset0) == 0,
 		"Failed to get thread affinity");
@@ -192,7 +193,7 @@ test_thread_attributes_affinity(void)
 		"Failed to create attributes affinity thread.");
 
 	while (rte_atomic_load_explicit(&thread_id_ready, rte_memory_order_acquire) == 0)
-		;
+		rte_pause();
 
 	RTE_TEST_ASSERT(rte_thread_get_affinity_by_id(thread_id, &cpuset1) == 0,
 		"Failed to get attributes thread affinity");
@@ -221,7 +222,7 @@ test_thread_attributes_priority(void)
 		"Failed to create attributes priority thread.");
 
 	while (rte_atomic_load_explicit(&thread_id_ready, rte_memory_order_acquire) == 0)
-		;
+		rte_pause();
 
 	RTE_TEST_ASSERT(rte_thread_get_priority(thread_id, &priority) == 0,
 		"Failed to get thread priority");
@@ -245,7 +246,7 @@ test_thread_control_create_join(void)
 		"Failed to create thread.");
 
 	while (rte_atomic_load_explicit(&thread_id_ready, rte_memory_order_acquire) == 0)
-		;
+		rte_pause();
 
 	RTE_TEST_ASSERT(rte_thread_equal(thread_id, thread_main_id) != 0,
 		"Unexpected thread id.");
-- 
2.51.0

