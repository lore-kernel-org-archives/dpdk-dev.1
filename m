Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42183D37E44
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E82A240ED4;
	Wed, 14 Jan 2026 16:45:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2A1F740E4F
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:45:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405542; x=1799941542;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XkNZKXe5UxENqu53pZu6jONl7clVnXzlVnjm2dZr3TU=;
 b=UDsGVE5tx1aZyDUJPqjRkioJ+FgqeZTkz79JKYn7LfdKb5bOlIgOqn91
 M75x/B+g/kbR8iGxa8N4HZ/UxYKJ1m7RXpHfcoCQzUAWW2/4mpJ5iQs/r
 ZGiDkS98FuAOfLVq6wVgB92B8yDSUK26KhXFtApJppi5lMa0EnrLcxPGF
 32mP2I29SHaLIYM3knBtDloAZ+sxAWV08kVkmLsRwy6StXoVIr1qXxMoC
 j6nN/NuGMn1WKVWQwq6QwooJFdxo0t5YgrahEKrGCFKj+dwWMXQnIf+j6
 /mpfdfEo1+Npw+zOWMJN+zwb47+GztoQL3ZLntF48wkg8gFZFZ2BE0rlN w==;
X-CSE-ConnectionGUID: iNnCdQn9Qee8Rm+3ciWB8Q==
X-CSE-MsgGUID: Q2GOdkgjS/OjBghOTjJqIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870933"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870933"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:41 -0800
X-CSE-ConnectionGUID: yP4Lg0lkQDuxU+SzDnQkug==
X-CSE-MsgGUID: 9UNDlO0ORSeG7CZ/Mb/klA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925058"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:39 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v4 24/31] app/test-eventdev: fix build with shadow warnings
 enabled
Date: Wed, 14 Jan 2026 15:44:38 +0000
Message-ID: <20260114154450.2969716-25-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

Rename or remove shadowed variables to give a clean build with -Wshadow.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-eventdev/evt_main.c          | 6 +++---
 app/test-eventdev/test_atomic_queue.c | 6 +++---
 app/test-eventdev/test_perf_common.c  | 4 +---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/app/test-eventdev/evt_main.c b/app/test-eventdev/evt_main.c
index 03114020f1..6f71c0a73d 100644
--- a/app/test-eventdev/evt_main.c
+++ b/app/test-eventdev/evt_main.c
@@ -30,11 +30,11 @@ signal_handler(int signum)
 }
 
 static inline void
-evt_options_dump_all(struct evt_test *test, struct evt_options *opts)
+evt_options_dump_all(struct evt_test *t, struct evt_options *opts)
 {
 	evt_options_dump(opts);
-	if (test->ops.opt_dump)
-		test->ops.opt_dump(opts);
+	if (t->ops.opt_dump)
+		t->ops.opt_dump(opts);
 }
 
 int
diff --git a/app/test-eventdev/test_atomic_queue.c b/app/test-eventdev/test_atomic_queue.c
index 8ce0849664..2b7bbeb370 100644
--- a/app/test-eventdev/test_atomic_queue.c
+++ b/app/test-eventdev/test_atomic_queue.c
@@ -34,7 +34,7 @@ static inline void
 atomic_queue_process_stage_1(struct test_order *const t,
 		struct rte_event *const ev,
 		uint32_t nb_flows,
-		rte_spinlock_t *atomic_locks,
+		rte_spinlock_t *atomic_lks,
 		uint32_t *const expected_flow_seq,
 		RTE_ATOMIC(uint64_t) * const outstand_pkts,
 		uint32_t port)
@@ -42,7 +42,7 @@ atomic_queue_process_stage_1(struct test_order *const t,
 	const uint32_t flow = *order_mbuf_flow_id(t, ev->mbuf);
 	const uint32_t seq = *order_mbuf_seqn(t, ev->mbuf);
 
-	atomic_lock_verify(atomic_locks, 1, flow, nb_flows, t, port);
+	atomic_lock_verify(atomic_lks, 1, flow, nb_flows, t, port);
 
 	/* compare the seqn against expected value */
 	if (seq != expected_flow_seq[flow]) {
@@ -58,7 +58,7 @@ atomic_queue_process_stage_1(struct test_order *const t,
 
 	ev->op = RTE_EVENT_OP_RELEASE;
 
-	atomic_spinlock_unlock(atomic_locks, 1, flow, nb_flows);
+	atomic_spinlock_unlock(atomic_lks, 1, flow, nb_flows);
 }
 
 static int
diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index 6b2ce61832..8201f2351a 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -2131,12 +2131,10 @@ perf_cryptodev_destroy(struct evt_test *test, struct evt_options *opt)
 		void *sess;
 		struct prod_data *p = &t->prod[port];
 		uint32_t flow_id;
-		uint8_t cdev_id;
 
 		for (flow_id = 0; flow_id < t->nb_flows; flow_id++) {
 			sess = p->ca.crypto_sess[flow_id];
-			cdev_id = p->ca.cdev_id;
-			rte_cryptodev_sym_session_free(cdev_id, sess);
+			rte_cryptodev_sym_session_free(p->ca.cdev_id, sess);
 		}
 
 		rte_event_crypto_adapter_queue_pair_del(
-- 
2.51.0

