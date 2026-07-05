Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C7EC43458
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Jul 2026 08:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52DD84027B;
	Sun,  5 Jul 2026 10:48:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4E98640150;
 Sun,  5 Jul 2026 10:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783241335; x=1814777335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0SxutVqRSdHZJTRr9gLQq/L7EPXMTzOpnr1OngS8BQI=;
 b=gxaKok03iAsPal54hIqIILHRxekWUZT8yAkP6LtJNu/9LU3paHX4CvYS
 7jD6B0oU4Czbxc2mYC4CI15NXtBMLuSPdWKf3UrNkRYBkQuGF3CUiu2vy
 bpfbRXWP81ZLWb1y+LCYO7vIKokNAq2NpKmlWCEVaZVlLEdof6MQXRUVe
 gGjC9Og012rwJsb6aWeO3gDFc9d7KTbUrdVJwJU2F2y2Lt4YISy1IiKQU
 wuBPA7Xn3KhPP0CmG7SNgVc6sSgxoi/pokSiLmGa1LDGvES8kC1h7x4BH
 l1iAgyRKaSqhrRFLh2LxgeRZcK1yp/g8cLYy8ZWbUnXDNHlqwr+5Iq36y w==;
X-CSE-ConnectionGUID: 52E5flkFT5uN5avcUw6BVw==
X-CSE-MsgGUID: Y4IdOLVTRma3v0mv7fbFEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="84030795"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="84030795"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2026 01:48:53 -0700
X-CSE-ConnectionGUID: 5XIDXZ5WScK7RDqtwyv5pw==
X-CSE-MsgGUID: HAIriSo2SNi/4yBzIhe8UQ==
X-ExtLoop1: 1
Received: from smserver2row47.iind.intel.com ([10.138.138.56])
 by fmviesa003.fm.intel.com with ESMTP; 05 Jul 2026 01:48:49 -0700
From: Pushpendra Kumar <pushpendra1x.kumar@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, thomas@monjalon.net, reshma.pattan@intel.com,
 stephen@networkplumber.org, anatoly.burakov@intel.com,
 dmitry.kozliuk@gmail.com, bruce.richardson@intel.com,
 14pwcse1224@uetpeshawar.edu.pk, pushpendra.kumar@tieto.com,
 Pushpendra Kumar <pushpendra1x.kumar@intel.com>
Subject: [PATCH v2] pdump: fix teardown race with opt-in MP request mode
Date: Sun,  5 Jul 2026 14:14:02 +0530
Message-ID: <20260705084415.1389340-1-pushpendra1x.kumar@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
References: <20260701060257.562895-1-pushpendra1x.kumar@intel.com>
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
- The extra synchronization in the hot path did not show material
  overhead in this sample.

Fixes: c3ceb8742295 ("pdump: forward callback enable to secondary process")
Signed-off-by: Pushpendra Kumar <pushpendra1x.kumar@intel.com>

Cc: stable@dpdk.org
---
This V2 patch addresses two pdump teardown failure scenarios:

- A requester secondary can time out if a forwarded secondary is slow,
  unresponsive, or does not implement rte_pdump_init().
- A delayed DISABLE reply can race with requester-side teardown, which may
  lead to crashes if peer processes still access shared pdump resources.

To fix this end-to-end:
- EAL adds an opt-in MP request mode to ignore peers with no matching action,
  while preserving legacy rte_mp_request_sync() behavior.
- pdump uses that mode, tracks generation, and waits for in-flight callbacks
  to drain before completing disable.
- dumpcap and pdump app cleanup paths are fail-closed when disable does not
  complete successfully.

If this direction is accepted, I can split from the next revision into a
focused EAL patch followed by pdump and app-user updates.

 .mailmap                               |   1 +
 app/dumpcap/main.c                     |  23 ++-
 app/pdump/main.c                       |  32 +++-
 doc/guides/rel_notes/release_26_07.rst |   7 +
 lib/eal/common/eal_common_proc.c       |  37 +++-
 lib/eal/include/rte_eal.h              |  33 ++++
 lib/eal/windows/eal_mp.c               |   9 +
 lib/pdump/rte_pdump.c                  | 241 ++++++++++++++++++++++---
 lib/pdump/rte_pdump.h                  |  40 +++-
 9 files changed, 379 insertions(+), 44 deletions(-)

diff --git a/.mailmap b/.mailmap
index c5bc728fae..c1313c7148 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1332,6 +1332,7 @@ Przemyslaw Gierszynski <przemyslaw.gierszynski@intel.com>
 Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
 Przemyslaw Zegan <przemyslawx.zegan@intel.com>
 Pu Xu <583493798@qq.com>
+Pushpendra Kumar <pushpendra1x.kumar@intel.com>
 Qi Fu <qi.fu@intel.com>
 Qi Zhang <qi.z.zhang@intel.com>
 Qian Hao <qi_an_hao@126.com>
diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 46a6cb251e..f421a17034 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -521,14 +521,33 @@ static void
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
+		 * alive and do not uninit shared capture resources.
+		 */
+		fprintf(stderr,
+			"Skipping pdump uninit because disable did not complete on all interfaces\n");
+		return;
+	}
+
 	rte_pdump_uninit();
 }
 
diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1e62c8adc1..4cfb038395 100644
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
@@ -518,15 +521,30 @@ static void
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
+	if (disable_failed)
+		return;
+
+	/* free the pdump_tuple resources */
+	for (i = 0; i < num_tuples; i++) {
+		pt = &pdump_t[i];
 
 		/*
 		* transmit rest of the enqueued packets of the rings on to
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 4ca0a9ac77..1700a56bc7 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -177,6 +177,13 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
+* **Hardened pdump teardown on disable failure.**
+
+  Hardened pdump request completion and application cleanup behavior so timeout
+  or disable failure does not trigger premature pdump resource teardown.
+  pdump now uses an opt-in MP request mode that ignores peers without the
+  pdump action, while preserving legacy EAL MP behavior for all other users.
+
 
 Removed Items
 -------------
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 06f151818c..5a458c0417 100644
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
@@ -384,11 +385,11 @@ process_msg(struct mp_msg_internal *m, struct sockaddr_un *s)
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
 
@@ -936,7 +937,8 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 
 static int
 mp_request_sync(const char *dst, struct rte_mp_msg *req,
-	       struct rte_mp_reply *reply, const struct timespec *ts)
+	       struct rte_mp_reply *reply, const struct timespec *ts,
+	       enum mp_type req_type)
 {
 	int ret;
 	pthread_condattr_t attr;
@@ -959,7 +961,7 @@ mp_request_sync(const char *dst, struct rte_mp_msg *req,
 		return -1;
 	}
 
-	ret = send_msg(dst, req, MP_REQ);
+	ret = send_msg(dst, req, req_type);
 	if (ret < 0) {
 		EAL_LOG(ERR, "Fail to send request %s:%s",
 			dst, req->name);
@@ -1010,11 +1012,20 @@ RTE_EXPORT_SYMBOL(rte_mp_request_sync)
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
 
@@ -1027,6 +1038,14 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	if (check_input(req) != 0)
 		goto end;
 
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
@@ -1046,7 +1065,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	/* for secondary process, send request to the primary process only */
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		pthread_mutex_lock(&pending_requests.lock);
-		ret = mp_request_sync(eal_mp_socket_path(), req, reply, &end);
+		ret = mp_request_sync(eal_mp_socket_path(), req, reply, &end, req_type);
 		pthread_mutex_unlock(&pending_requests.lock);
 		goto end;
 	}
@@ -1086,7 +1105,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
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
index ac94efe7ff..3764aeb2d3 100644
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
@@ -68,6 +71,7 @@ struct pdump_request {
 
 	const struct rte_bpf_prm *prm;
 	uint32_t snaplen;
+	uint32_t generation;
 };
 
 struct pdump_response {
@@ -81,6 +85,11 @@ struct pdump_bundle {
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
@@ -88,11 +97,11 @@ static struct pdump_rxtx_cbs {
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
@@ -102,9 +111,59 @@ static const char MZ_RTE_PDUMP_STATS[] = "rte_pdump_stats";
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
+						       rte_memory_order_relaxed);
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
+	 * callback to drain and stale callbacks become no-op.
+	 */
+	generation = rte_atomic_load_explicit(&pdump_stats->generation,
+					     rte_memory_order_relaxed);
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
@@ -224,12 +283,17 @@ pdump_rx(uint16_t port, uint16_t queue,
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
@@ -239,12 +303,17 @@ pdump_tx(uint16_t port, uint16_t queue,
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
@@ -255,20 +324,43 @@ pdump_register_rx_callbacks(enum pdump_version ver,
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
@@ -276,6 +368,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 			cbs->mp = mp;
 			cbs->snaplen = snaplen;
 			cbs->filter = filter;
+			cbs->generation = generation;
 
 			cbs->cb = rte_eth_add_first_rx_callback(port, qid,
 								pdump_rx, cbs);
@@ -286,10 +379,15 @@ pdump_register_rx_callbacks(enum pdump_version ver,
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
@@ -298,6 +396,11 @@ pdump_register_rx_callbacks(enum pdump_version ver,
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
@@ -305,6 +408,10 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 			}
 			pdump_cb_wait(cbs);
 			cbs->cb = NULL;
+
+			ret = pdump_wait_inflight(ctl);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -316,7 +423,8 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 			    uint16_t end_q, uint16_t port, uint16_t queue,
 			    struct rte_ring *ring, struct rte_mempool *mp,
 			    struct rte_bpf *filter,
-			    uint16_t operation, uint32_t snaplen)
+			    uint16_t operation, uint32_t snaplen,
+			    uint32_t generation)
 {
 
 	uint16_t qid;
@@ -324,13 +432,36 @@ pdump_register_tx_callbacks(enum pdump_version ver,
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
@@ -338,6 +469,7 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 			cbs->mp = mp;
 			cbs->snaplen = snaplen;
 			cbs->filter = filter;
+			cbs->generation = generation;
 
 			cbs->cb = rte_eth_add_tx_callback(port, qid, pdump_tx,
 								cbs);
@@ -347,10 +479,15 @@ pdump_register_tx_callbacks(enum pdump_version ver,
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
@@ -359,6 +496,11 @@ pdump_register_tx_callbacks(enum pdump_version ver,
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
@@ -367,6 +509,10 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 
 			pdump_cb_wait(cbs);
 			cbs->cb = NULL;
+
+			ret = pdump_wait_inflight(ctl);
+			if (ret < 0)
+				return ret;
 		}
 	}
 
@@ -459,7 +605,8 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_rx_q : queue + 1;
 		ret = pdump_register_rx_callbacks(p->ver, end_q, port, queue,
 						  ring, mp, filter,
-						  operation, p->snaplen);
+						  operation, p->snaplen,
+						  p->generation);
 		if (ret < 0)
 			return ret;
 	}
@@ -469,7 +616,8 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_tx_q : queue + 1;
 		ret = pdump_register_tx_callbacks(p->ver, end_q, port, queue,
 						  ring, mp, filter,
-						  operation, p->snaplen);
+						  operation, p->snaplen,
+						  p->generation);
 		if (ret < 0)
 			return ret;
 	}
@@ -477,12 +625,14 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
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
 
@@ -490,14 +640,41 @@ pdump_request_to_secondary(const struct pdump_request *req)
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
+			if (ret == 0)
+				ret = resp->err_value;
+		}
+	}
 
 	free(mp_reply.msgs);
+	return ret;
 }
 
 /* Allocate temporary storage for passing state to the alarm thread for deferred handling */
@@ -556,7 +733,10 @@ pdump_handle_primary_request(const struct rte_mp_msg *mp_msg, const void *peer)
 		PDUMP_LOG_LINE(DEBUG, "secondary pdump %s", pdump_opname(req->op));
 
 		/* Can just do it now, no need for interrupt thread */
-		ret = set_pdump_rxtx_cbs(req);
+		if (req->op == ENABLE || req->op == DISABLE)
+			ret = set_pdump_rxtx_cbs(req);
+		else
+			ret = -EINVAL;
 	}
 
 	return pdump_send_response(req, ret, peer);
@@ -569,17 +749,29 @@ __pdump_request(void *param)
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
@@ -659,6 +851,9 @@ rte_pdump_init(void)
 
 	pdump_stats = mz->addr;
 	pdump_stats->mz = mz;
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_atomic_store_explicit(&pdump_stats->generation, 1,
+					  rte_memory_order_release);
 
 	return 0;
 }
diff --git a/lib/pdump/rte_pdump.h b/lib/pdump/rte_pdump.h
index 1e32d46097..77e5914420 100644
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
@@ -124,7 +134,14 @@ rte_pdump_enable_bpf(uint16_t port_id, uint16_t queue,
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
+ *  crashes in peer processes still accessing those resources.
  *
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
@@ -153,6 +170,11 @@ rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags);
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
@@ -186,6 +208,11 @@ rte_pdump_enable_by_deviceid(char *device_id, uint16_t queue,
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
@@ -210,7 +237,14 @@ rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue,
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
+ *  crashes in peer processes still accessing those resources.
  *
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
-- 
2.43.0

