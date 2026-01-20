Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A777D2ECFD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:58:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3182040685;
	Tue, 20 Jan 2026 02:58:09 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id A12894067E
 for <dev@dpdk.org>; Tue, 20 Jan 2026 02:58:07 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b86f81d8051so803612366b.1
 for <dev@dpdk.org>; Mon, 19 Jan 2026 17:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768874287;
 x=1769479087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVaKzTwPPhHqkMJcTiyy9Z6wyBn1vnFw5rP+PKKkxmw=;
 b=sgabdI2BRINq1GbAITVGbgJlwmaS8TOjHxr6DSJ5pYEyBpnHQNQL8/9uEjrexAxoM7
 5eM0i4QJTpUmGrGumhhouFRvRCVIASHEC6xtsvEEFGT7elkP6M8l2EToFPqLQBsa3Uw+
 HVC2A1RTy+QApk3brSk66d5d7HuZ+MziU7zER07BZt07jA8aACUO55E4+JE5HBfkp4JN
 V7dWW9EbmrwkuJ5mENFkOzU4q2Ch14Nblz1BSujKoj/pRLjeIGxmURSnTTZB8bMVAMUk
 4V1TAlFcrhDsjwa5fC20YyT03oDRRJnuhFvXGVI7iGM+LeLHt587d9K4sFpO0GGABMe1
 bUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768874287; x=1769479087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rVaKzTwPPhHqkMJcTiyy9Z6wyBn1vnFw5rP+PKKkxmw=;
 b=ChSrsr35INEeIVB64PvaA2LIz6TOl6nZ0e6ARW8sJpqHMDfPCGu8NaDbF85mlG8KOH
 W44mqvfQOB/dmu8xn6Quxwl4IyfojX34YtE1A9ti4lgOykzDBjmqLuC8DfP1F9ucJU+E
 uXIVQ4Hq6k69V3Z/yjeB6R0MJoXw7nB+s6nEcOFlD/v1eXBATfwjyOoJ3Rr2Yfsexis4
 JXPTFeVVIB967ipjCuyWzHJgJTAlWUPwM1YmZyi66fdVC3H5m91pbS2NKOCbMV87Rwil
 mBvwiJXvSC776bkqc8lNID8zqwtjbW0StFslAQ+2NuIgWcKkauBBUP82LsURKbjwYXIf
 5yag==
X-Gm-Message-State: AOJu0YxfwGX/E5+Psuw18v0CcjCFyAHhbtOyGWgJmJCFthoSUD8KcW9k
 9bmNIJIPN8S+S5LXrlSdnuwzJhuvVnPJ6Qy+EplsHdMT2QoHTKETtXltFfPYqIb4Y8hq7tNiGB4
 6xIUU
X-Gm-Gg: AY/fxX76RtqHqSC9QsK7va25bBN6MHGbjM7ocQ7kUFs9XuMVn24FIQ8/oDGg5+IIbu9
 pnraDGBDIZyOG1OivnZGLj6pY1jtqWklXELc0nvUxs0rF0ujucT2Qn3HiKAvLQznckkp8j5sL1Q
 NJllYA8uNKfXo7lIsqgeI8rrkuyJjbUfRZrkWtFoWUMXTicxx6CmQ8QekjkVLqrIPBpmDIAWz8c
 U7JKa9MeQJCZpKMR1rJ0BgPsfqysxHgY9cN3Nk6nCpopbju1li5GDnvj8+AOpqeEyv3uG66DgUr
 h0L72v5BF8aypjt/nM9jifaYaCGsKsl24INWYUj6Nz3ZDZOajUnI47AV5ZYiUys1wOfmP5hjlrF
 i/+qtKaueaB2BirJ/f8vcfng40XBge2XTNTgWk6t6EuZwSFg1RKULDcdhXnKq9FTcTGXvx/s+gs
 FhPpYcHStq2o5J9nkI4d7NVFi52mJgIN5EGJ3XgIATlvHn/B2UtCC/Fq/JJaCw
X-Received: by 2002:a17:907:c22:b0:b72:d577:11cc with SMTP id
 a640c23a62f3a-b879388dabfmr1299974966b.12.1768874287089; 
 Mon, 19 Jan 2026 17:58:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879516900csm1342225366b.23.2026.01.19.17.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 17:58:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 1/6] test: add pause to synchronization spinloops
Date: Mon, 19 Jan 2026 17:55:04 -0800
Message-ID: <20260120015759.301155-2-stephen@networkplumber.org>
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

