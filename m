Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CCD116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB25240E0A;
	Mon,  1 Dec 2025 12:45:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7979340674
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589530; x=1796125530;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XkNZKXe5UxENqu53pZu6jONl7clVnXzlVnjm2dZr3TU=;
 b=m54WHEvJG5qk+8O4rWBGcBK03D0xgcljOaHS+zanHIRIo6BzWxn6twXR
 LbuMkTGnYBtTXZSspRizsY1dQjz7LOoVo5RMJMa57YQD8qN34KPcyVir3
 VJl1ql6LtlxYa2MRrGzcLLqfqmH5qqwW7iX9t+f7dZNo57Jb8qVoY9a0i
 Yxw8hQ2cwnfBkaG/p5ef5CwiO1sn4bcw4PSsrdNm92dg2KwsexoIt82a6
 PygF4+ow0EoZpeiK0mWljFK1gCTnszz/IfRnXjRSmYTq2hm2wWYbP50sO
 JzFNJR2iIYjFfnOO4mctEe4U3S9EM7osMt9BnIDJlnBT1HxTjKElrpX6+ Q==;
X-CSE-ConnectionGUID: nW56tIpWR1Sdhbjx3XCV3Q==
X-CSE-MsgGUID: BazAVQJ3SICrdc0CSxfZtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991765"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991765"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:29 -0800
X-CSE-ConnectionGUID: IAr8BqqCTp6fd92TButl7w==
X-CSE-MsgGUID: K3tISmfcRKaWEjqozjI0/w==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:28 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 24/31] app/test-eventdev: fix build with shadow warnings
 enabled
Date: Mon,  1 Dec 2025 11:44:41 +0000
Message-ID: <20251201114448.1441377-25-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

