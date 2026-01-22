Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45607C44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6EE5402ED;
	Thu, 22 Jan 2026 01:54:05 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 01BA6402BE
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:04 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so264184f8f.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043244;
 x=1769648044; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eJuhiWWqC1V/QJY7iIabIFA6em2UhaYMwHjZukwhrs=;
 b=bQHfIG8n8OJYotsiTkQjbFk5g0EiiMjkn/zaHx4DTooXaZgYiy9KkC3VzrPqVh3ttD
 DtYUAGzcfa8gp9zuWs6ACyCUlJthl7EjP5+YTMOoV3KLZ9x9DMNmCPbv1wHP3yYXV7OQ
 7E/6qaHifnjYav/kUaMRpkPJF67dbUX6BfUHIHwSqniQkIgssiYFAKGo5VCGK7G0MzzI
 ZP/JgkDieAjN7YSRgeDjwyFluhO6AWLSF2GYnxpUYGzu5qtYFit8wjIRQ+0GOWvD1TmU
 gbUoz2jiXTG8zwu+P8s9m67QxEiOE/QQegcslf1lC7c4E1mR18scpuObWdWDCS23j0Ko
 2FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043244; x=1769648044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9eJuhiWWqC1V/QJY7iIabIFA6em2UhaYMwHjZukwhrs=;
 b=Vv+rtuDPW3STuY0y5CavnayBJ4iDWbiS+rfZl4Jy0cWAFdYtPrcmpMl3ciq3GnpAll
 qzszPeY8BIeJkMUzHTUPvPDMreld7ysWnyiGbByKjyPvUWPh+oqKgGkxZhQQLEk52+8Z
 oftQ8B1X/sklMfBI6eoXpwbTLqka/h7IURHjkmrlteG3mGV01tObLMigIHjtzIvEusoA
 Zmmzd2IrqGpX2/slf8/q2xhKUp/BJvBOV9hv5mPJ/9mSIuqN21KXL67LU05iNStojP01
 l+r/hmTo+8oAWMmtVjNyTr50UKPHa73Y24ffrAelZ6p/LDd8qkAMfIIhNBlvaO+4KyFY
 iDOg==
X-Gm-Message-State: AOJu0YxgP9nfhNKd8URKlxTLiafSGF/+v/EON/bzVncc7dxL7aFQDMsq
 GIzHooTlmKHbIdiVohqZaWtmRni6CCT1AB6PYBE/R1buRPO4w5EwbANioGdqMoPZT8PCjnJlsH3
 AmHhG
X-Gm-Gg: AZuq6aIQsVzAGyJesnETfhQkrU8kLiHfFhYdIgAkFqIcC/A2rFqh61yF5Lf/P5GST1+
 jAyirDMKrRvtAxqLv6hlH6clJCEXxcz+XEhbbyMAH/YzueePp4MxG3oP6zgZH904CM96OrbjTXm
 MVpQHY2UCVt3QcemZG+aWXC+o/6+jgwnyEpZcIYMj+9aGT360QfbdUhM5raLqf0hfMwGP4R5OWr
 Bjyp30M0+FHZOJ2U1gvWui26VQiHmQ7LkRbzTxzwBkRuPK100rFwZ7oEXClGIVC6BhIjOBkJ6Mb
 7HaFdhmwcBjody4pUyEzIO2a0A/P+QNS00Uvcbr+J61ggfDslJ18aao23oaY944ZtZEMFopurfS
 RMkNjYZBIodT+7BU9ewzvPMMIXUABzmiwz36AXeVAtHRwr14thfOTfwIi7DcjVux+zKqQl5V3gL
 zX6MOjn+HRUmKwU8oA7dVl9eprsdV+zeLB26zMtU+GJXqc+K2bWA==
X-Received: by 2002:a05:6000:2901:b0:430:f5ab:dc8e with SMTP id
 ffacd0b85a97d-4358ff1c183mr12860454f8f.13.1769043244422; 
 Wed, 21 Jan 2026 16:54:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 01/14] test: add pause to synchronization spinloops
Date: Wed, 21 Jan 2026 16:50:17 -0800
Message-ID: <20260122005356.1168221-2-stephen@networkplumber.org>
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

