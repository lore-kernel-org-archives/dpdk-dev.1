Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5703C43458
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Jul 2026 17:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0B684027B;
	Sun,  5 Jul 2026 19:12:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9721D4021E;
 Sun,  5 Jul 2026 19:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783271548; x=1814807548;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IXxxMXYlIAAJJEcLXZI3DLlLOtz7J8pfOV6+XS1JKfI=;
 b=cfLFzcyNCb9SrjCAcwzbARCf5l4TfmqWrsX+pLKZE2+YjdpgfrVeCPAp
 kcBGZ5IzX4FNLt334E5MqClR+zwRiDOrIxmuhp2R0xeNr/GSyje+MEDx8
 YWB2Neo2+eHj6J7tgtcSteQ4t/DMIJGu2PDKCS7q3ZO22iL8+qnfrMAjH
 eM5tmqSd65KS9IKJRghX8ohY+1DXPVjAShsB1qnLtTQhEZYXEaQHSRoMo
 iqhc3VcaqG+uY0law1ZXRS+0DGzrMu90bY9V0kHd6VGcC6YgI5yGuWhFS
 O1ZBvAXAmy9C0Xnfx2aEOizRxPNJaml1bQW31Bvuh5AfdIJgG8qWIjKiN w==;
X-CSE-ConnectionGUID: AZRke94/RpKuIafe+tmwQw==
X-CSE-MsgGUID: KYLJXT9OSyGttR1IxaQU5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83788228"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="83788228"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2026 10:12:26 -0700
X-CSE-ConnectionGUID: Bd5SAjXKRA+wduqQE1s1ew==
X-CSE-MsgGUID: J2teMRsNQ5Ks4coUDqYRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="249067653"
Received: from smserver2row47.iind.intel.com ([10.138.138.56])
 by fmviesa006.fm.intel.com with ESMTP; 05 Jul 2026 10:12:23 -0700
From: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, reshma.pattan@intel.com, stephen@networkplumber.org,
 anatoly.burakov@intel.com, dmitry.kozliuk@gmail.com, thomas@monjalon.net,
 Pushpendra Kumar <pushpendra1x.kumar@intel.com>
Subject: [PATCH v3] pdump: fix teardown race with opt-in MP request mode
Date: Sun,  5 Jul 2026 22:37:37 +0530
Message-ID: <20260705170752.1433868-1-pushpendra1x.kumar@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705084415.1389340-1-pushpendra1x.kumar@intel.com>
References: <20260705084415.1389340-1-pushpendra1x.kumar@intel.com>
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

This change addresses two pdump teardown failure cases:

1. A requester secondary can time out if a forwarded secondary is slow,
   unresponsive, or does not implement rte_pdump_init().
2. After a DISABLE request times out, the requester secondary receives
   the reply and releases shared resources, which other slow or
   unresponsive secondaries may access, leading to a crash.

Add an opt-in EAL multiprocess request mode that allows a caller to
ignore peers that do not implement the requested action, while preserving
the existing rte_mp_request_sync() behavior for legacy users.

pdump uses this new mode when forwarding enable/disable requests and adds
the following behavior:
- track request generation so stale callbacks cannot act on a newer
  enable/disable cycle
- wait for in-flight callbacks to drain before completing disable
- prevent shared resource teardown from racing with delayed secondary
  processing
- keep pdump intent-driven without extra consumer-specific workaround
  logic

The EAL change is required because the current mp request path treats
a missing action as a failure, which cannot satisfy pdump's needs without
changing behavior for all existing users. The new API is opt-in, so
existing callers of rte_mp_request_sync() keep their current semantics.

Validation:
- Baseline-vs-changes benchmark used DPDK-native test-pmd as primary and
  dumpcap as secondary.
- Both runs captured 1024 packets with the same packet-count exit
  condition.
- A 5-second perf stat sample on the forwarding primary showed no
  meaningful regression: with changes recorded 12,402,055,320 cycles and
  17,391,769,084 instructions, versus 12,450,031,900 cycles and
  17,499,706,053 instructions on the parent baseline.
- This validates that the primary forwarding path is not materially
  affected.
- Secondary callback-path overhead for pdump_enter/pdump_exit was not
  separately microbenchmarked in this patch.

Fixes: c3ceb8742295 ("pdump: forward callback enable to secondary process")
Signed-off-by: Pushpendra Kumar <pushpendra1x.kumar@intel.com>

Cc: stable@dpdk.org

---
v3:
- strengthen `pdump_enter()` generation loads to use acquire ordering
- clarify why `pdump_enter()` re-checks generation after taking `inflight`
- document the distinct roles of `use_count` and `inflight`
- document bounded disable timeout and retry expectation
- document first-error return policy in `pdump_request_to_secondary_sync()`
- document that unknown `rte_mp_request_sync_ex()` flags are rejected intentionally
- document why generation starts at 1 on primary init
- clarify fail-closed cleanup behavior and same-process recovery limitation
- reword release notes to emphasize opt-in EAL API/flag semantics and unchanged legacy behavior
- clarify commit-message validation scope: perf numbers cover the forwarding primary path only

Not changed:
- no automatic RX/TX rollback on partial enable failure
  Current pdump enable intentionally remains partial-apply as documented in the public API. Adding rollback would change semantics toward transactional enable and introduce additional failure handling if rollback itself fails.
- no non-NULL `cb` after successful callback removal on timeout
  After successful `rte_eth_remove_*x_callback()`, `cb` must continue to reflect actual ethdev registration state. Leaving it non-NULL would make local state inconsistent and could trigger incorrect later remove/reconcile behavior.
- no RX/TX helper refactor in this correctness patch
  This area is concurrency-sensitive and RX/TX callback APIs are not identical, so keeping the logic local reduces regression risk.

If you want a shorter version for the email intro instead of the `---` block, use:

v3 updates mainly tighten documentation and clarify intent around the accepted fixes:
acquire ordering in `pdump_enter()`, explicit comments for generation re-check, `use_count` vs `inflight`, bounded timeout/retry, first-error aggregation, unknown-flag rejection, and generation initialization; fail-closed cleanup/recovery notes; release-note wording for the new opt-in EAL API; and commit-message clarification that current perf numbers cover the forwarding primary path only.

 .mailmap                               |   1 +
 app/dumpcap/main.c                     |  24 ++-
 app/pdump/main.c                       |  37 +++-
 doc/guides/rel_notes/release_26_07.rst |   9 +
 lib/eal/common/eal_common_proc.c       |  41 +++-
 lib/eal/include/rte_eal.h              |  33 +++
 lib/eal/windows/eal_mp.c               |   9 +
 lib/pdump/rte_pdump.c                  | 266 ++++++++++++++++++++++---
 lib/pdump/rte_pdump.h                  |  42 +++-
 9 files changed, 417 insertions(+), 45 deletions(-)

diff --git a/.mailmap b/.mailmap
index 05a55c0bd6..3bfe0c4df0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1338,6 +1338,7 @@ Przemyslaw Gierszynski <przemyslaw.gierszynski@intel.com>
 Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
 Przemyslaw Zegan <przemyslawx.zegan@intel.com>
 Pu Xu <583493798@qq.com>
+Pushpendra Kumar <pushpendra1x.kumar@intel.com>
 Qi Fu <qi.fu@intel.com>
 Qi Zhang <qi.z.zhang@intel.com>
 Qian Hao <qi_an_hao@126.com>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 46a6cb251e..c6ae916075 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -521,14 +521,34 @@ static void
 cleanup_pdump_resources(void)
 {
 	struct interface *intf;
+	int ret;
+	bool disable_failed = false;
 
 	TAILQ_FOREACH(intf, &interfaces, next) {
-		rte_pdump_disable(intf->port,
-				  RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);
+		ret = rte_pdump_disable(intf->port,
+					RTE_PDUMP_ALL_QUEUES, RTE_PDUMP_FLAG_RXTX);
+		if (ret < 0) {
+			disable_failed = true;
+			fprintf(stderr,
+				"Disable pdump failed on %u:%s: %s\n",
+				intf->port, intf->name,
+				rte_strerror(rte_errno));
+		}
 		if (intf->opts.promisc_mode)
 			rte_eth_promiscuous_disable(intf->port);
 	}
 
+	if (disable_failed) {
+		/*
+		 * Fail-closed: if disable did not complete, keep pdump action/state
+		 * alive and do not uninit shared capture resources. Recovery in the
+		 * same process instance is not guaranteed until disable succeeds.
+		 */
+		fprintf(stderr,
+			"Skipping pdump uninit because disable did not complete on all interfaces\n");
+		return;
+	}
+
 	rte_pdump_uninit();
 }
 
diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1e62c8adc1..8f33d2f603 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -451,14 +451,17 @@ print_pdump_stats(void)
 	}
 }
 
-static inline void
+static inline int
 disable_pdump(struct pdump_tuples *pt)
 {
 	if (pt->dump_by_type == DEVICE_ID)
-		rte_pdump_disable_by_deviceid(pt->device_id, pt->queue,
-						pt->dir);
+		return rte_pdump_disable_by_deviceid(pt->device_id, pt->queue,
+						     pt->dir);
 	else if (pt->dump_by_type == PORT_ID)
-		rte_pdump_disable(pt->port, pt->queue, pt->dir);
+		return rte_pdump_disable(pt->port, pt->queue, pt->dir);
+
+	rte_errno = EINVAL;
+	return -EINVAL;
 }
 
 static inline void
@@ -518,15 +521,35 @@ static void
 cleanup_pdump_resources(void)
 {
 	int i;
+	int ret;
+	bool disable_failed = false;
 	struct pdump_tuples *pt;
 	char name[RTE_ETH_NAME_MAX_LEN];
 
-	/* disable pdump and free the pdump_tuple resources */
+	/* Disable all callbacks first; freeing shared objects before this is unsafe. */
 	for (i = 0; i < num_tuples; i++) {
 		pt = &pdump_t[i];
 
-		/* remove callbacks */
-		disable_pdump(pt);
+		ret = disable_pdump(pt);
+		if (ret < 0) {
+			disable_failed = true;
+			printf("pdump disable failed (tuple=%d, errno=%d: %s); "
+			       "skip teardown to avoid stale callback access\n",
+			       i, rte_errno, rte_strerror(rte_errno));
+		}
+	}
+
+	/*
+	 * Fail-closed: do not uninit/free shared pdump resources after disable
+	 * failure. Recovery in the same process instance is not guaranteed until
+	 * disable succeeds.
+	 */
+	if (disable_failed)
+		return;
+
+	/* free the pdump_tuple resources */
+	for (i = 0; i < num_tuples; i++) {
+		pt = &pdump_t[i];
 
 		/*
 		* transmit rest of the enqueued packets of the rings on to
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8b1bdada1a..51fc74e7ef 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -250,6 +250,15 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
+* **Hardened pdump teardown on disable failure.**
+
+  Hardened pdump request completion and application cleanup behavior so timeout
+  or disable failure does not trigger premature pdump resource teardown.
+  EAL now provides ``rte_mp_request_sync_ex()`` with
+  ``RTE_MP_REQ_F_IGNORE_NO_ACTION`` to ignore peers that do not implement
+  the requested action. pdump uses this opt-in mode, while legacy
+  ``rte_mp_request_sync()`` behavior remains unchanged.
+
 
 Removed Items
 -------------
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 5133eaaa47..fbfecd82d3 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -56,6 +56,7 @@ static struct action_entry_list action_entry_list =
 enum mp_type {
 	MP_MSG, /* Share message with peers, will not block */
 	MP_REQ, /* Request for information, Will block for a reply */
+	MP_REQ_IGN, /* Request where missing action should return ignore */
 	MP_REP, /* Response to previously-received request */
 	MP_IGN, /* Response telling requester to ignore this response */
 };
@@ -399,11 +400,11 @@ process_msg(struct mp_msg_internal *m, struct sockaddr_un *s)
 	pthread_mutex_unlock(&mp_mutex_action);
 
 	if (!action) {
-		if (m->type == MP_REQ && !internal_conf->init_complete) {
-			/* if this is a request, and init is not yet complete,
-			 * and callback wasn't registered, we should tell the
-			 * requester to ignore our existence because we're not
-			 * yet ready to process this request.
+		if ((m->type == MP_REQ && !internal_conf->init_complete) ||
+		    m->type == MP_REQ_IGN) {
+			/*
+			 * Ask requester to ignore this peer when action is not
+			 * registered either due to early init or explicit request policy.
 			 */
 			struct rte_mp_msg dummy;
 
@@ -947,7 +948,8 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 
 static int
 mp_request_sync(const char *dst, struct rte_mp_msg *req,
-	       struct rte_mp_reply *reply, const struct timespec *ts)
+	       struct rte_mp_reply *reply, const struct timespec *ts,
+	       enum mp_type req_type)
 {
 	int ret;
 	pthread_condattr_t attr;
@@ -970,7 +972,7 @@ mp_request_sync(const char *dst, struct rte_mp_msg *req,
 		return -1;
 	}
 
-	ret = send_msg(dst, req, MP_REQ);
+	ret = send_msg(dst, req, req_type);
 	if (ret < 0) {
 		EAL_LOG(ERR, "Fail to send request %s:%s",
 			dst, req->name);
@@ -1021,11 +1023,20 @@ RTE_EXPORT_SYMBOL(rte_mp_request_sync)
 int
 rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 		const struct timespec *ts)
+{
+	return rte_mp_request_sync_ex(req, reply, ts, 0);
+}
+
+RTE_EXPORT_SYMBOL(rte_mp_request_sync_ex)
+int
+rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,
+		const struct timespec *ts, uint32_t flags)
 {
 	int dir_fd, ret = -1;
 	DIR *mp_dir;
 	struct dirent *ent;
 	struct timespec now, end;
+	enum mp_type req_type = MP_REQ;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -1038,6 +1049,18 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	if (check_input(req) != 0)
 		goto end;
 
+	/*
+	 * Reject unknown flags for safety instead of silently ignoring them.
+	 * Future flags require corresponding support in this implementation.
+	 */
+	if (flags & ~RTE_MP_REQ_F_IGNORE_NO_ACTION) {
+		rte_errno = EINVAL;
+		goto end;
+	}
+
+	if (flags & RTE_MP_REQ_F_IGNORE_NO_ACTION)
+		req_type = MP_REQ_IGN;
+
 	if (internal_conf->no_shconf) {
 		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
 		rte_errno = ENOTSUP;
@@ -1057,7 +1080,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	/* for secondary process, send request to the primary process only */
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		pthread_mutex_lock(&pending_requests.lock);
-		ret = mp_request_sync(eal_mp_socket_path(), req, reply, &end);
+		ret = mp_request_sync(eal_mp_socket_path(), req, reply, &end, req_type);
 		pthread_mutex_unlock(&pending_requests.lock);
 		goto end;
 	}
@@ -1097,7 +1120,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 		/* unlocks the mutex while waiting for response,
 		 * locks on receive
 		 */
-		if (mp_request_sync(path, req, reply, &end))
+		if (mp_request_sync(path, req, reply, &end, req_type))
 			goto unlock_end;
 	}
 	ret = 0;
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index 7241f3be5d..415b974945 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -173,6 +173,15 @@ struct rte_mp_reply {
 	struct rte_mp_msg *msgs; /* caller to free */
 };
 
+/** Request flags for rte_mp_request_sync_ex(). */
+enum rte_mp_request_flags {
+	/**
+	 * Ask peers that do not have a registered action to return MP_IGN
+	 * instead of causing timeout for this request.
+	 */
+	RTE_MP_REQ_F_IGNORE_NO_ACTION = 1u << 0,
+};
+
 /**
  * Action function typedef used by other components.
  *
@@ -292,6 +301,30 @@ int
 rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	       const struct timespec *ts);
 
+/**
+ * Send a request to peer processes with explicit request flags.
+ *
+ * This API is equivalent to rte_mp_request_sync() with opt-in behavior
+ * controls provided through @p flags.
+ *
+ * @param req
+ *   The req argument contains the customized request message.
+ * @param reply
+ *   The reply argument will be for storing all the replied messages;
+ *   the caller is responsible for free reply->msgs.
+ * @param ts
+ *   The ts argument specifies how long we can wait for the peer(s) to reply.
+ * @param flags
+ *   Bitmask of values from enum rte_mp_request_flags.
+ *
+ * @return
+ *  - On success, return 0.
+ *  - On failure, return -1, and the reason will be stored in rte_errno.
+ */
+int
+rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,
+		const struct timespec *ts, uint32_t flags);
+
 /**
  * Send a request to the peer process and expect a reply in a separate callback.
  *
diff --git a/lib/eal/windows/eal_mp.c b/lib/eal/windows/eal_mp.c
index 6703355318..1066a4d2bc 100644
--- a/lib/eal/windows/eal_mp.c
+++ b/lib/eal/windows/eal_mp.c
@@ -56,10 +56,19 @@ RTE_EXPORT_SYMBOL(rte_mp_request_sync)
 int
 rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	const struct timespec *ts)
+{
+	return rte_mp_request_sync_ex(req, reply, ts, 0);
+}
+
+RTE_EXPORT_SYMBOL(rte_mp_request_sync_ex)
+int
+rte_mp_request_sync_ex(struct rte_mp_msg *req, struct rte_mp_reply *reply,
+	const struct timespec *ts, uint32_t flags)
 {
 	RTE_SET_USED(req);
 	RTE_SET_USED(reply);
 	RTE_SET_USED(ts);
+	RTE_SET_USED(flags);
 	EAL_LOG_NOT_IMPLEMENTED();
 	return -1;
 }
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ac94efe7ff..f55f43774c 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -3,9 +3,12 @@
  */
 
 #include <stdlib.h>
+#include <errno.h>
 
 #include <eal_export.h>
+#include <rte_eal.h>
 #include <rte_alarm.h>
+#include <rte_cycles.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 #include <rte_lcore.h>
@@ -29,7 +32,10 @@ RTE_LOG_REGISTER_DEFAULT(pdump_logtype, NOTICE);
 
 #define PDUMP_BURST_SIZE	32u
 
-/* Overly generous timeout for secondary to respond */
+/*
+ * Shared timeout budget for both MP request/reply and inflight callback drain
+ * during disable. Kept fixed for now to avoid API/config scope changes.
+ */
 #define MP_TIMEOUT_S 5
 
 enum pdump_operation {
@@ -68,6 +74,7 @@ struct pdump_request {
 
 	const struct rte_bpf_prm *prm;
 	uint32_t snaplen;
+	uint32_t generation;
 };
 
 struct pdump_response {
@@ -81,6 +88,11 @@ struct pdump_bundle {
 	char peer[];
 };
 
+struct pdump_shared_ctl {
+	RTE_ATOMIC(uint32_t) enabled;
+	RTE_ATOMIC(uint32_t) inflight;
+};
+
 static struct pdump_rxtx_cbs {
 	struct rte_ring *ring;
 	struct rte_mempool *mp;
@@ -88,11 +100,11 @@ static struct pdump_rxtx_cbs {
 	const struct rte_bpf *filter;
 	enum pdump_version ver;
 	uint32_t snaplen;
+	uint32_t generation;
 	RTE_ATOMIC(uint32_t) use_count;
 } rx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT],
 tx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
 
-
 /*
  * The packet capture statistics keep track of packets
  * accepted, filtered and dropped. These are per-queue
@@ -102,12 +114,73 @@ static const char MZ_RTE_PDUMP_STATS[] = "rte_pdump_stats";
 static struct {
 	struct rte_pdump_stats rx[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
 	struct rte_pdump_stats tx[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
+	struct pdump_shared_ctl rx_ctl[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
+	struct pdump_shared_ctl tx_ctl[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
+	RTE_ATOMIC(uint32_t) generation;
 	const struct rte_memzone *mz;
 } *pdump_stats;
 
+static int
+pdump_enter(struct pdump_shared_ctl *ctl, const struct pdump_rxtx_cbs *cbs)
+{
+	uint32_t generation = rte_atomic_load_explicit(&pdump_stats->generation,
+					       rte_memory_order_acquire);
+
+	if (rte_atomic_load_explicit(&ctl->enabled, rte_memory_order_relaxed) == 0 ||
+	    cbs->generation != generation)
+		return 0;
+
+	rte_atomic_fetch_add_explicit(&ctl->inflight, 1, rte_memory_order_acquire);
+
+	/*
+	 * Disable/re-enable may race with callback entry. Re-check enabled and
+	 * generation after taking inflight reference so disable can wait for this
+	 * callback to drain and stale callbacks become no-op. The second generation
+	 * load is intentional: it detects an epoch change that happens between the
+	 * first check and inflight increment.
+	 */
+	generation = rte_atomic_load_explicit(&pdump_stats->generation,
+					     rte_memory_order_acquire);
+	if (rte_atomic_load_explicit(&ctl->enabled, rte_memory_order_relaxed) != 0 &&
+	    cbs->generation == generation)
+		return 1;
+
+	rte_atomic_fetch_sub_explicit(&ctl->inflight, 1, rte_memory_order_release);
+	return 0;
+}
+
+static __rte_always_inline void
+pdump_exit(struct pdump_shared_ctl *ctl)
+{
+	rte_atomic_fetch_sub_explicit(&ctl->inflight, 1, rte_memory_order_release);
+}
+
+static int
+pdump_wait_inflight(struct pdump_shared_ctl *ctl)
+{
+	uint64_t end_tsc = rte_get_timer_cycles() + MP_TIMEOUT_S * rte_get_timer_hz();
+
+	/*
+	 * Use the same timeout budget as MP sync requests. Under heavy load this
+	 * can time out and fail closed, requiring disable retry by the caller.
+	 */
+
+	while (rte_atomic_load_explicit(&ctl->inflight, rte_memory_order_acquire) != 0) {
+		if (rte_get_timer_cycles() > end_tsc)
+			return -ETIMEDOUT;
+		rte_pause();
+	}
+
+	return 0;
+}
+
 static void
 pdump_cb_wait(struct pdump_rxtx_cbs *cbs)
 {
+	/*
+	 * use_count protects callback-owned data (for example filter lifetime),
+	 * while ctl->inflight protects callback entry/teardown synchronization.
+	 */
 	/* make sure the data loads happens before the use count load */
 	rte_atomic_thread_fence(rte_memory_order_acquire);
 
@@ -224,12 +297,17 @@ pdump_rx(uint16_t port, uint16_t queue,
 	uint16_t max_pkts __rte_unused, void *user_params)
 {
 	struct pdump_rxtx_cbs *cbs = user_params;
+	struct pdump_shared_ctl *ctl = &pdump_stats->rx_ctl[port][queue];
 	struct rte_pdump_stats *stats = &pdump_stats->rx[port][queue];
 
+	if (!pdump_enter(ctl, cbs))
+		return nb_pkts;
+
 	pdump_cb_hold(cbs);
 	pdump_copy(port, queue, RTE_PCAPNG_DIRECTION_IN,
 		   pkts, nb_pkts, cbs, stats);
 	pdump_cb_release(cbs);
+	pdump_exit(ctl);
 
 	return nb_pkts;
 }
@@ -239,12 +317,17 @@ pdump_tx(uint16_t port, uint16_t queue,
 		struct rte_mbuf **pkts, uint16_t nb_pkts, void *user_params)
 {
 	struct pdump_rxtx_cbs *cbs = user_params;
+	struct pdump_shared_ctl *ctl = &pdump_stats->tx_ctl[port][queue];
 	struct rte_pdump_stats *stats = &pdump_stats->tx[port][queue];
 
+	if (!pdump_enter(ctl, cbs))
+		return nb_pkts;
+
 	pdump_cb_hold(cbs);
 	pdump_copy(port, queue, RTE_PCAPNG_DIRECTION_OUT,
 		   pkts, nb_pkts, cbs, stats);
 	pdump_cb_release(cbs);
+	pdump_exit(ctl);
 
 	return nb_pkts;
 }
@@ -255,20 +338,43 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 			    uint16_t end_q, uint16_t port, uint16_t queue,
 			    struct rte_ring *ring, struct rte_mempool *mp,
 			    struct rte_bpf *filter,
-			    uint16_t operation, uint32_t snaplen)
+			    uint16_t operation, uint32_t snaplen,
+			    uint32_t generation)
 {
 	uint16_t qid;
 
 	qid = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
 	for (; qid < end_q; qid++) {
 		struct pdump_rxtx_cbs *cbs = &rx_cbs[port][qid];
+		struct pdump_shared_ctl *ctl = &pdump_stats->rx_ctl[port][qid];
 
 		if (operation == ENABLE) {
+			int ret;
+
 			if (cbs->cb) {
-				PDUMP_LOG_LINE(ERR,
-					"rx callback for port=%d queue=%d, already exists",
-					port, qid);
-				return -EEXIST;
+				if (cbs->generation == generation &&
+				    rte_atomic_load_explicit(&ctl->enabled,
+					    rte_memory_order_relaxed) != 0) {
+					PDUMP_LOG_LINE(ERR,
+						"rx callback for port=%d queue=%d, already exists",
+						port, qid);
+					return -EEXIST;
+				}
+
+				PDUMP_LOG_LINE(DEBUG,
+					"reconciling stale rx callback for port=%d queue=%d"
+					" old_gen=%u new_gen=%u",
+					port, qid, cbs->generation, generation);
+
+				ret = rte_eth_remove_rx_callback(port, qid, cbs->cb);
+				if (ret < 0) {
+					PDUMP_LOG_LINE(ERR,
+						"failed to reconcile stale rx callback, errno=%d",
+						-ret);
+					return ret;
+				}
+				pdump_cb_wait(cbs);
+				cbs->cb = NULL;
 			}
 			cbs->use_count = 0;
 			cbs->ver = ver;
@@ -276,6 +382,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 			cbs->mp = mp;
 			cbs->snaplen = snaplen;
 			cbs->filter = filter;
+			cbs->generation = generation;
 
 			cbs->cb = rte_eth_add_first_rx_callback(port, qid,
 								pdump_rx, cbs);
@@ -286,10 +393,15 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 				return rte_errno;
 			}
 
+			rte_atomic_store_explicit(&ctl->inflight, 0, rte_memory_order_relaxed);
+			rte_atomic_store_explicit(&ctl->enabled, 1, rte_memory_order_release);
+
 			memset(&pdump_stats->rx[port][qid], 0, sizeof(struct rte_pdump_stats));
 		} else if (operation == DISABLE) {
 			int ret;
 
+			rte_atomic_store_explicit(&ctl->enabled, 0, rte_memory_order_release);
+
 			if (cbs->cb == NULL) {
 				PDUMP_LOG_LINE(ERR,
 					"no existing rx callback for port=%d queue=%d",
@@ -298,6 +410,11 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 			}
 			ret = rte_eth_remove_rx_callback(port, qid, cbs->cb);
 			if (ret < 0) {
+				/* Keep state coherent: callback is still registered,
+				 * so restore enabled.
+				 */
+				rte_atomic_store_explicit(&ctl->enabled, 1,
+						rte_memory_order_release);
 				PDUMP_LOG_LINE(ERR,
 					"failed to remove rx callback, errno=%d",
 					-ret);
@@ -305,6 +422,10 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 			}
 			pdump_cb_wait(cbs);
 			cbs->cb = NULL;
+
+			ret = pdump_wait_inflight(ctl);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -316,7 +437,8 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 			    uint16_t end_q, uint16_t port, uint16_t queue,
 			    struct rte_ring *ring, struct rte_mempool *mp,
 			    struct rte_bpf *filter,
-			    uint16_t operation, uint32_t snaplen)
+			    uint16_t operation, uint32_t snaplen,
+			    uint32_t generation)
 {
 
 	uint16_t qid;
@@ -324,13 +446,36 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 	qid = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
 	for (; qid < end_q; qid++) {
 		struct pdump_rxtx_cbs *cbs = &tx_cbs[port][qid];
+		struct pdump_shared_ctl *ctl = &pdump_stats->tx_ctl[port][qid];
 
 		if (operation == ENABLE) {
+			int ret;
+
 			if (cbs->cb) {
-				PDUMP_LOG_LINE(ERR,
-					"tx callback for port=%d queue=%d, already exists",
-					port, qid);
-				return -EEXIST;
+				if (cbs->generation == generation &&
+				    rte_atomic_load_explicit(&ctl->enabled,
+					    rte_memory_order_relaxed) != 0) {
+					PDUMP_LOG_LINE(ERR,
+						"tx callback for port=%d queue=%d, already exists",
+						port, qid);
+					return -EEXIST;
+				}
+
+				PDUMP_LOG_LINE(DEBUG,
+					"reconciling stale tx callback for port=%d queue=%d"
+					" old_gen=%u new_gen=%u",
+					port, qid, cbs->generation, generation);
+
+				ret = rte_eth_remove_tx_callback(port, qid, cbs->cb);
+				if (ret < 0) {
+					PDUMP_LOG_LINE(ERR,
+						"failed to reconcile stale tx callback, errno=%d",
+						-ret);
+					return ret;
+				}
+
+				pdump_cb_wait(cbs);
+				cbs->cb = NULL;
 			}
 			cbs->use_count = 0;
 			cbs->ver = ver;
@@ -338,6 +483,7 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 			cbs->mp = mp;
 			cbs->snaplen = snaplen;
 			cbs->filter = filter;
+			cbs->generation = generation;
 
 			cbs->cb = rte_eth_add_tx_callback(port, qid, pdump_tx,
 								cbs);
@@ -347,10 +493,15 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 					rte_errno);
 				return rte_errno;
 			}
+
+			rte_atomic_store_explicit(&ctl->inflight, 0, rte_memory_order_relaxed);
+			rte_atomic_store_explicit(&ctl->enabled, 1, rte_memory_order_release);
 			memset(&pdump_stats->tx[port][qid], 0, sizeof(struct rte_pdump_stats));
 		} else if (operation == DISABLE) {
 			int ret;
 
+			rte_atomic_store_explicit(&ctl->enabled, 0, rte_memory_order_release);
+
 			if (cbs->cb == NULL) {
 				PDUMP_LOG_LINE(ERR,
 					"no existing tx callback for port=%d queue=%d",
@@ -359,6 +510,11 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 			}
 			ret = rte_eth_remove_tx_callback(port, qid, cbs->cb);
 			if (ret < 0) {
+				/* Keep state coherent: callback is still registered,
+				 * so restore enabled.
+				 */
+				rte_atomic_store_explicit(&ctl->enabled, 1,
+						rte_memory_order_release);
 				PDUMP_LOG_LINE(ERR,
 					"failed to remove tx callback, errno=%d",
 					-ret);
@@ -367,6 +523,10 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 
 			pdump_cb_wait(cbs);
 			cbs->cb = NULL;
+
+			ret = pdump_wait_inflight(ctl);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -459,17 +619,23 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_rx_q : queue + 1;
 		ret = pdump_register_rx_callbacks(p->ver, end_q, port, queue,
 						  ring, mp, filter,
-						  operation, p->snaplen);
+						  operation, p->snaplen,
+						  p->generation);
 		if (ret < 0)
 			return ret;
 	}
 
+	/*
+	 * Intentional partial-apply behavior: if RX succeeds and TX fails,
+	 * RX remains enabled. API notes require caller-side unwind.
+	 */
 	/* register TX callback */
 	if (flags & RTE_PDUMP_FLAG_TX) {
 		end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_tx_q : queue + 1;
 		ret = pdump_register_tx_callbacks(p->ver, end_q, port, queue,
 						  ring, mp, filter,
-						  operation, p->snaplen);
+						  operation, p->snaplen,
+						  p->generation);
 		if (ret < 0)
 			return ret;
 	}
@@ -477,12 +643,14 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 	return ret;
 }
 
-static void
-pdump_request_to_secondary(const struct pdump_request *req)
+static int
+pdump_request_to_secondary_sync(const struct pdump_request *req)
 {
 	struct rte_mp_msg mp_req = { };
 	struct rte_mp_reply mp_reply;
 	struct timespec ts = {.tv_sec = MP_TIMEOUT_S, .tv_nsec = 0};
+	int ret = 0;
+	uint16_t i;
 
 	PDUMP_LOG_LINE(DEBUG, "forward req %s to secondary", pdump_opname(req->op));
 
@@ -490,14 +658,45 @@ pdump_request_to_secondary(const struct pdump_request *req)
 	strlcpy(mp_req.name, PDUMP_MP, sizeof(mp_req.name));
 	mp_req.len_param = sizeof(*req);
 
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) != 0)
-		PDUMP_LOG_LINE(ERR, "rte_mp_request_sync failed");
+	if (rte_mp_request_sync_ex(&mp_req, &mp_reply, &ts,
+				    RTE_MP_REQ_F_IGNORE_NO_ACTION) != 0) {
+		PDUMP_LOG_LINE(ERR, "rte_mp_request_sync failed: %s",
+			      strerror(rte_errno));
+		return -rte_errno;
+	}
 
-	else if (mp_reply.nb_sent != mp_reply.nb_received)
+	if (mp_reply.nb_sent != mp_reply.nb_received) {
 		PDUMP_LOG_LINE(ERR, "not all secondary's replied (sent %u recv %u)",
 			       mp_reply.nb_sent, mp_reply.nb_received);
+		ret = -ETIMEDOUT;
+	}
+
+	for (i = 0; i < mp_reply.nb_received; i++) {
+		struct rte_mp_msg *mp_rep = &mp_reply.msgs[i];
+		const struct pdump_response *resp;
+
+		if (mp_rep->len_param != sizeof(*resp)) {
+			PDUMP_LOG_LINE(ERR, "invalid secondary reply size %u", mp_rep->len_param);
+			if (ret == 0)
+				ret = -EINVAL;
+			continue;
+		}
+
+		resp = (const struct pdump_response *)mp_rep->param;
+		if (resp->err_value != 0) {
+			PDUMP_LOG_LINE(ERR, "secondary reply failed: op=%u err=%d",
+				       resp->res_op, resp->err_value);
+			/*
+			 * Return the first failure to keep a single representative
+			 * status; all per-secondary errors are still logged above.
+			 */
+			if (ret == 0)
+				ret = resp->err_value;
+		}
+	}
 
 	free(mp_reply.msgs);
+	return ret;
 }
 
 /* Allocate temporary storage for passing state to the alarm thread for deferred handling */
@@ -556,7 +755,10 @@ pdump_handle_primary_request(const struct rte_mp_msg *mp_msg, const void *peer)
 		PDUMP_LOG_LINE(DEBUG, "secondary pdump %s", pdump_opname(req->op));
 
 		/* Can just do it now, no need for interrupt thread */
-		ret = set_pdump_rxtx_cbs(req);
+		if (req->op == ENABLE || req->op == DISABLE)
+			ret = set_pdump_rxtx_cbs(req);
+		else
+			ret = -EINVAL;
 	}
 
 	return pdump_send_response(req, ret, peer);
@@ -569,17 +771,29 @@ __pdump_request(void *param)
 {
 	struct pdump_bundle *bundle = param;
 	struct rte_mp_msg *msg = &bundle->msg;
-	const struct pdump_request *req =
-		(const struct pdump_request *)msg->param;
+	struct pdump_request *req =
+		(struct pdump_request *)msg->param;
 	int ret;
 
 	PDUMP_LOG_LINE(DEBUG, "primary pdump %s", pdump_opname(req->op));
 
+	if (req->op == DISABLE) {
+		req->generation = rte_atomic_fetch_add_explicit(&pdump_stats->generation, 1,
+							   rte_memory_order_acq_rel) + 1;
+	} else if (req->op == ENABLE) {
+		req->generation = rte_atomic_load_explicit(&pdump_stats->generation,
+							   rte_memory_order_acquire);
+	}
+
 	ret = set_pdump_rxtx_cbs(req);
 
-	/* Primary process is responsible for broadcasting request to all secondaries */
+	/*
+	 * Primary process is responsible for broadcasting the request to all
+	 * secondaries. The sync request uses opt-in ignore-missing-action mode so
+	 * pdump does not depend on unrelated secondary processes.
+	 */
 	if (ret == 0)
-		pdump_request_to_secondary(req);
+		ret = pdump_request_to_secondary_sync(req);
 
 	pdump_send_response(req, ret, bundle->peer);
 	free(bundle);
@@ -659,6 +873,10 @@ rte_pdump_init(void)
 
 	pdump_stats = mz->addr;
 	pdump_stats->mz = mz;
+	/* Start at generation 1 so zero remains the default pre-init value. */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_atomic_store_explicit(&pdump_stats->generation, 1,
+					  rte_memory_order_release);
 
 	return 0;
 }
diff --git a/lib/pdump/rte_pdump.h b/lib/pdump/rte_pdump.h
index 1e32d46097..52d3c0ca93 100644
--- a/lib/pdump/rte_pdump.h
+++ b/lib/pdump/rte_pdump.h
@@ -64,7 +64,7 @@ rte_pdump_uninit(void);
  *  queues of a given port.
  * @param flags
  *  flags specifies RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUMP_FLAG_RXTX
- *  on which packet capturing should be enabled for a given port and queue.
+ *  on which packet capturing should be disabled for a given port and queue.
  * @param ring
  *  ring on which captured packets will be enqueued for user.
  * @param mp
@@ -72,6 +72,11 @@ rte_pdump_uninit(void);
  * @param filter
  *  Unused should be NULL.
  *
+ * @note
+ *  In applications that enable capture on multiple interfaces, enable may be
+ *  partially applied before an error is returned. Callers should explicitly
+ *  unwind partial enable state.
+ *
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
@@ -103,6 +108,11 @@ rte_pdump_enable(uint16_t port, uint16_t queue, uint32_t flags,
  * @param prm
  *  Use BPF program to run to filter packes (can be NULL)
  *
+ * @note
+ *  In applications that enable capture on multiple interfaces, enable may be
+ *  partially applied before an error is returned. Callers should explicitly
+ *  unwind partial enable state.
+ *
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
@@ -124,7 +134,15 @@ rte_pdump_enable_bpf(uint16_t port_id, uint16_t queue,
  *  queues of a given port.
  * @param flags
  *  flags specifies RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUMP_FLAG_RXTX
- *  on which packet capturing should be enabled for a given port and queue.
+ *  on which packet capturing should be disabled for a given port and queue.
+ *
+ * @note
+ *  A disable failure (including timeout/no response) means teardown is not
+ *  complete across pdump-enabled peers. The caller must not release shared
+ *  pdump resources and must not uninitialize pdump for that capture session
+ *  until disable succeeds. Releasing resources on disable failure can lead to
+ *  crashes in peer processes still accessing those resources. Timeout is
+ *  bounded; callers should retry disable before attempting teardown.
  *
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
@@ -153,6 +171,11 @@ rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags);
  * @param filter
  *  unused should be NULL
  *
+ * @note
+ *  In applications that enable capture on multiple interfaces, enable may be
+ *  partially applied before an error is returned. Callers should explicitly
+ *  unwind partial enable state.
+ *
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
@@ -186,6 +209,11 @@ rte_pdump_enable_by_deviceid(char *device_id, uint16_t queue,
  * @param filter
  *  Use BPF program to run to filter packes (can be NULL)
  *
+ * @note
+ *  In applications that enable capture on multiple interfaces, enable may be
+ *  partially applied before an error is returned. Callers should explicitly
+ *  unwind partial enable state.
+ *
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
@@ -210,7 +238,15 @@ rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue,
  *  queues of a given device id.
  * @param flags
  *  flags specifies RTE_PDUMP_FLAG_RX/RTE_PDUMP_FLAG_TX/RTE_PDUMP_FLAG_RXTX
- *  on which packet capturing should be enabled for a given port and queue.
+ *  on which packet capturing should be disabled for a given port and queue.
+ *
+ * @note
+ *  A disable failure (including timeout/no response) means teardown is not
+ *  complete across pdump-enabled peers. The caller must not release shared
+ *  pdump resources and must not uninitialize pdump for that capture session
+ *  until disable succeeds. Releasing resources on disable failure can lead to
+ *  crashes in peer processes still accessing those resources. Timeout is
+ *  bounded; callers should retry disable before attempting teardown.
  *
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
-- 
2.43.0

