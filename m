Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0600606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JZ8+YjQP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A326402DE;
	Tue, 17 Nov 2026 18:57:30 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by mails.dpdk.org (Postfix) with ESMTPS id D9A09402D2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:57:26 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-91ec396c93dso83080536d6.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794938246; x=1795543046; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/0rb3B5003kMPHgIjScM9d/uZXguZFBFI+ipqxlKOcI=;
 b=JZ8+YjQPQ4/iVdzu07vLfF20cVAzX5LDJvV4O/kEY/7ru/Pn8MLGMp4duJjL3dfodz
 S5Vpha6vq9XWr9eOdDubCBrwn/4txdS9/nCCCnqDeUU3/CMgvPuThAEdhh9O1H4kJb28
 6TtoaHZIZBCW4wialBDkomEm2yKPDkVditlAea+tv80hnjzJ6OSBhaPRmodDYMqydgnd
 RVqpk4WLuk+GAZ07iD5ytGoZSktkdDvSHcSIQSMX9BMdKMQ2+ky/jbX3YUrWmmCadt11
 fFrVO3f2OKhSFNXGq7K1YqY8ALyzX7zQCrIB0EsUXlJIwS6JXjgRkCpPIkDcBXkufouF
 lEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938246; x=1795543046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/0rb3B5003kMPHgIjScM9d/uZXguZFBFI+ipqxlKOcI=;
 b=W8XDzx7kGO9RRGhG0yylCSw6r0aF47nuxfZTzTXAyX+cfxvvd/Xx4eUxu2saXlaSkX
 /qbNUYlQokI5rwsuollZVnhk8rAZgmUG85A1WMOdEZSlhm6uTxCPqzGpEM+5cpi7uYxQ
 BfA3RoleERZJ5bIPZQSI04/dnOjKLaQInlzU016varpZoIn2YDlCluynkWdmc0Y4nxrB
 2h2f3bFUNKgIhr2dtnKv7MmUCXeua9+Izu6rQwltlRJOKCQcY8gyHG2eg2+PHuTV7tt7
 rSQiPV3AeNdfiYkyVPbyqiTYZ6g1VPZwjT6kMtbjApOgpC4v2fqYQfbyEwxjeo8uCtYI
 gQfA==
X-Gm-Message-State: APuU4Z8/3s5Ndbq87qdAC4yhjYkMvUO7SMqBCla+gbWCrKh3zYh/MHrK
 QIG3f1khmGzhiZBNDIdXLJzQNYR7r0JdLc7td6y+fJ6gTOKGAjwfZBOmjtHAmld6
X-Gm-Gg: AZFdTZeOnXhP1LVOgcoWNNlb7eJb5xIDyXUwGfLmBw/18lJM+XV/oGNQz1Y0u0C6hE6
 rN/5f9rfuS8RK406HIQdaVMC93gRwfTTnfZSjFfvRJ//IOwPDs4g+ckyYskErBrUwVuBY6fFsKU
 OvsO3Dcza2G/ERUuELTr25QQnC3iEO7YhnJfM5IYRhuptFVPt7FDZqTF7RMlzXZMAxMi4bONHFT
 8EZDBmdsTMTu1uEXkSCwTJBzqax9EAiLJsTWLfpp7uJL4wBbWBQMqOcORlGKNsms2AEbGy6ecQx
 5eZRg9qgKmuZPCvEW4jvtazyW5k0znkSUpYBGXkd9J3TgdjhCcZ0gYHmlG7V3B2mD2dSd6dNmYM
 o2Mvpu/3jEos3dqpKHbxk+EFyIul3ptdGgUrbeoKnsxfyZi6QYi6sfdBwZXtZBS6bCVG+YVkvEB
 9tsPxrejffnQbs0aVygfvIKDgg0RRy+J3prSUmY6MF+YvGG65w7MTIPgeBK8QjX3crXMqzsvHV/
 vHDxEWntTs6G75wGJFI7l0Fbb/MdPDRe9t90J0SKEW53vND/Rve2EcOArI5A1BEv/oeE9IDZD6s
 vKbLAVB5F4Gtw+m4UJCqyRt0n7IMtIp4o1EtdSsG8irZHtjsd59hSR/b3xvqVsVUsDG33eJSdIk
 ClqB2Ri77SPRQ6LAb4l/Y1HbzhdOt+Jkha4wq0XQou+NPx1+ot/7a
X-Received: by 2002:a05:6214:31a0:b0:91e:7ede:63fc with SMTP id
 6a1803df08f44-91f24240a04mr231222146d6.51.1794938245364; 
 Tue, 17 Nov 2026 09:57:25 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c29f7.dyn.optonline.net. [148.76.41.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921148c261bsm327426d6.0.2026.11.17.09.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:57:25 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 david.marchand@redhat.com, nipun.gupta@amd.com, chenbox@nvidia.com,
 tirthendu.sarkar@intel.com, mattias.ronnblom@ericsson.com,
 stephen@networkplumber.org, Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v2 2/8] event/slb: add support for ordered queues
Date: Tue, 17 Nov 2026 12:57:02 -0500
Message-ID: <20261117175709.2346400-3-pravinpathakdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117175709.2346400-1-pravinpathakdev@gmail.com>
References: <20261107013011.2443138-9-pravinpathakdev@gmail.com>
 <20261117175709.2346400-1-pravinpathakdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pravin Pathak <pravin.pathak.dev@gmail.com>

Add support for RTE_SCHED_TYPE_ORDERED queues to provide strict packet
reordering guarantees across worker ports.

A reorder buffer is allocated for each ordered queue to hold forwarded
events until preceding sequence slots have completed. On dequeue from an
ordered queue, sequence numbers are atomically reserved and recorded in
the port's history tracker.

When worker ports enqueue forwarded or released events, the corresponding
reorder buffer entries are marked ready or released. Contiguous ready
events are drained in order to destination queues via slb_reorder_drain.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 drivers/event/slb/slb_evdev.c |  45 ++-
 drivers/event/slb/slb_evdev.h |  39 +++
 drivers/event/slb/slb_event.c | 529 +++++++++++++++++++++++++++++-----
 3 files changed, 539 insertions(+), 74 deletions(-)

diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
index 53af113293..13be490636 100644
--- a/drivers/event/slb/slb_evdev.c
+++ b/drivers/event/slb/slb_evdev.c
@@ -17,6 +17,25 @@
 
 #define EVENTDEV_NAME_SLB_PMD event_slb
 
+/* Reset history tracking table for a port.
+ * Token 0 is reserved for parallel and single-link events without history.
+ * Tokens 1 to 255 (255 total) are available for ordered and atomic queue events.
+ */
+static void
+slb_port_reset_history(struct slb_port *port)
+{
+	port->history[0].active = false;
+	port->history[0].next_free = SLB_PORT_HISTORY_FREE_END;
+	for (int i = 1; i < SLB_PORT_HISTORY_SIZE; i++) {
+		port->history[i].active = false;
+		port->history[i].next_free = i + 1;
+	}
+	port->history[SLB_PORT_HISTORY_SIZE - 1].next_free =
+		SLB_PORT_HISTORY_FREE_END;
+	port->history_head = 1;
+	port->history_avail = SLB_PORT_HISTORY_MAX_TOKENS;
+}
+
 /* Setup Eventdev port. Reset all mapped queues */
 static int
 slb_port_setup(struct rte_eventdev *dev, uint8_t port_id,
@@ -54,6 +73,7 @@ slb_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 		.credits_drained = false,
 		.total_dequeues = 0,
 		.empty_dequeues = 0,
+		.pending_releases = 0,
 		.single_linked_q = NULL,
 		.single_linked_ring = NULL,
 	};
@@ -71,6 +91,8 @@ slb_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 		memset(port->q_entries[p], 0, sizeof(port->q_entries[p]));
 	}
 
+	slb_port_reset_history(port);
+
 	return 0;
 }
 
@@ -99,6 +121,10 @@ slb_queue_release(struct rte_eventdev *dev, uint8_t queue_id)
 	struct slb_evdev *slb = slb_pmd_priv(dev);
 	struct slb_queue *queue = &slb->queues[queue_id];
 
+	if (queue->reorder_buffer) {
+		rte_free(queue->reorder_buffer);
+		queue->reorder_buffer = NULL;
+	}
 	if (queue->q_ring) {
 		rte_event_ring_free(queue->q_ring);
 		queue->q_ring = NULL;
@@ -128,7 +154,8 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 		queue->is_single_link = true;
 		ring = rte_event_ring_create(ring_name, q_size,
 			dev->data->socket_id, RING_F_SC_DEQ | RING_F_EXACT_SZ);
-	} else if (conf->schedule_type == RTE_SCHED_TYPE_PARALLEL) {
+	} else if (conf->schedule_type == RTE_SCHED_TYPE_PARALLEL ||
+		   conf->schedule_type == RTE_SCHED_TYPE_ORDERED) {
 		/* MP -> MC ring for parallel queues */
 		queue->is_single_link = false;
 		ring = rte_event_ring_create(ring_name, q_size,
@@ -147,6 +174,21 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 	queue->serving_ports_mask = 0;
 	queue->num_serving_ports = 0;
 
+	/* Ordered queue reorder buffer allocation */
+	if (conf->schedule_type == RTE_SCHED_TYPE_ORDERED) {
+		queue->reorder_buffer = rte_zmalloc_socket("slb_reorder_buf",
+			sizeof(struct slb_reorder_entry) * ring->r.size,
+			RTE_CACHE_LINE_SIZE, dev->data->socket_id);
+		if (queue->reorder_buffer == NULL) {
+			rte_event_ring_free(ring);
+			return -ENOMEM;
+		}
+		queue->reorder_drain_idx = 0;
+		rte_spinlock_init(&queue->reorder_lock);
+	} else {
+		queue->reorder_buffer = NULL;
+	}
+
 	return 0;
 }
 
@@ -337,6 +379,7 @@ slb_info_get(struct rte_eventdev *dev __rte_unused,
 		.max_profiles_per_port = 1,
 		.event_dev_cap = RTE_EVENT_DEV_CAP_BURST_MODE |
 		RTE_EVENT_DEV_CAP_PARALLEL |
+		RTE_EVENT_DEV_CAP_ORDERED |
 		RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED |
 		RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE |
 		RTE_EVENT_DEV_CAP_NONSEQ_MODE |
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
index d7be6746ef..b73127a739 100644
--- a/drivers/event/slb/slb_evdev.h
+++ b/drivers/event/slb/slb_evdev.h
@@ -9,6 +9,7 @@
 #include <rte_bitset.h>
 #include <rte_event_ring.h>
 #include <rte_eventdev.h>
+#include <rte_spinlock.h>
 #include <rte_stdatomic.h>
 #include <eventdev_pmd.h>
 
@@ -58,9 +59,37 @@ struct slb_port_q_entry {
 	uint8_t pad[6];
 };
 
+#define SLB_PORT_HISTORY_SIZE 256
+#define SLB_PORT_HISTORY_MAX_TOKENS (SLB_PORT_HISTORY_SIZE - 1)
+#define SLB_PORT_HISTORY_FREE_END 0xFFFF
+
+struct slb_history_entry {
+	uint32_t flow_id;
+	uint16_t seq_slot;
+	uint16_t next_free;
+	uint8_t orig_queue_id;
+	uint8_t enq_port_id;
+	uint8_t sched_type;
+	bool active;
+};
+
+enum slb_reorder_state {
+	SLB_REORDER_EMPTY = 0,
+	SLB_REORDER_READY = 1,
+	SLB_REORDER_RELEASED = 2
+};
+
+struct slb_reorder_entry {
+	struct rte_event event;
+	RTE_ATOMIC(uint8_t) state;
+};
+
 struct __rte_cache_aligned slb_port {
 	/* --- Cacheline 0: Hot Rx & Tx scheduling control (64 bytes) --- */
 	uint16_t id;
+	uint16_t history_head;
+	uint16_t history_avail;
+	uint16_t pending_releases;
 	int32_t inflight_credits;
 	int32_t new_event_threshold;
 	RTE_ATOMIC(uint64_t) active_queues;
@@ -78,6 +107,10 @@ struct __rte_cache_aligned slb_port {
 	alignas(RTE_CACHE_LINE_SIZE)
 	struct slb_port_q_entry q_entries[SLB_MAX_PRIORITIES][SLB_PORT_MAX_Q_MAP_PER_PRIO];
 
+	/* --- Cachelines 7+: Per-port history buffer --- */
+	alignas(RTE_CACHE_LINE_SIZE)
+	struct slb_history_entry history[SLB_PORT_HISTORY_SIZE];
+
 	/* --- Cold Section: Statistics counters and config --- */
 	alignas(RTE_CACHE_LINE_SIZE)
 	uint16_t dequeue_depth;
@@ -101,6 +134,10 @@ struct slb_queue {
 	uint16_t num_serving_ports;
 	uint64_t serving_ports_mask;
 	alignas(RTE_CACHE_LINE_SIZE) struct rte_event_ring *q_ring;
+	/* For ordered queues (dynamically allocated) */
+	struct slb_reorder_entry *reorder_buffer;
+	uint32_t reorder_drain_idx;
+	rte_spinlock_t reorder_lock;
 };
 
 /* Limited by the size of 'serving_ports_mask' and 'active_queues' bitmasks */
@@ -135,6 +172,8 @@ uint16_t slb_event_dequeue_burst(void *port, struct rte_event *events,
 void slb_port_return_credits(struct slb_evdev *slb, struct slb_port *port,
 			     int32_t credits);
 
+void slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue);
+
 void slb_dump(struct rte_eventdev *dev, FILE *f);
 
 static inline struct slb_evdev *
diff --git a/drivers/event/slb/slb_event.c b/drivers/event/slb/slb_event.c
index f55262154e..b6c7a8a514 100644
--- a/drivers/event/slb/slb_event.c
+++ b/drivers/event/slb/slb_event.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdbool.h>
+#include <rte_bitops.h>
 #include <rte_cycles.h>
 #include <rte_ring_elem.h>
 #include <rte_stdatomic.h>
@@ -81,6 +82,12 @@ slb_port_enqueue_stats(struct slb_port *port, uint16_t num_new,
 	port->release_enqueued += num_release;
 }
 
+static void
+slb_port_queue_enqueue_stats(struct slb_port *source_port, uint8_t queue_id)
+{
+	source_port->queue_enqueued[queue_id]++;
+}
+
 static void
 slb_port_queue_enqueue_burst_stats(struct slb_port *source_port,
 				   uint8_t queue_id, uint16_t num)
@@ -88,6 +95,67 @@ slb_port_queue_enqueue_burst_stats(struct slb_port *source_port,
 	source_port->queue_enqueued[queue_id] += num;
 }
 
+#define REORDER_BURST_SZ 64
+
+/* Drain in-order contiguous ready events from ordered queue's reorder buffer */
+void
+slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
+{
+	if (queue == NULL || queue->reorder_buffer == NULL)
+		return;
+
+	/* Only one thread can drain the reorder buffer at a time */
+	if (!rte_spinlock_trylock(&queue->reorder_lock))
+		return;
+
+	uint32_t drain_idx = queue->reorder_drain_idx;
+	uint32_t mask = queue->q_ring->r.mask;
+	struct slb_reorder_entry *buf = queue->reorder_buffer;
+	uint8_t state;
+
+	/* Drain from current drain index till hitting an empty slot.
+	 * Released slots need no processing except marking them empty.
+	 */
+	while ((state = rte_atomic_load_explicit(&buf[drain_idx].state,
+						 rte_memory_order_acquire)) !=
+	       SLB_REORDER_EMPTY) {
+		if (state == SLB_REORDER_RELEASED) {
+			rte_atomic_store_explicit(&buf[drain_idx].state,
+						  SLB_REORDER_EMPTY,
+						  rte_memory_order_release);
+			drain_idx = (drain_idx + 1) & mask;
+			continue;
+		}
+
+		/* Gather contiguous READY events destined for same target_qid */
+		struct rte_event burst[REORDER_BURST_SZ];
+		uint16_t burst_size = 0;
+		uint8_t target_qid = buf[drain_idx].event.queue_id;
+
+		while (burst_size < REORDER_BURST_SZ &&
+		       rte_atomic_load_explicit(&buf[drain_idx].state,
+						rte_memory_order_acquire) ==
+		       SLB_REORDER_READY &&
+		       buf[drain_idx].event.queue_id == target_qid) {
+			burst[burst_size++] = buf[drain_idx].event;
+			rte_atomic_store_explicit(&buf[drain_idx].state,
+						  SLB_REORDER_EMPTY,
+						  rte_memory_order_release);
+			drain_idx = (drain_idx + 1) & mask;
+		}
+
+		if (burst_size == 0)
+			break;
+
+		/* Target queue is sized to max_inflight and can never be full */
+		rte_event_ring_enqueue_burst(slb->queues[target_qid].q_ring,
+					     burst, burst_size, NULL);
+	}
+
+	queue->reorder_drain_idx = drain_idx;
+	rte_spinlock_unlock(&queue->reorder_lock);
+}
+
 static inline uint16_t
 slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				const struct rte_event events[],
@@ -96,8 +164,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				uint16_t num_release)
 {
 	struct slb_evdev *slb = source_port->slb;
-	uint16_t enqueued = 0;
-	uint16_t idx = 0;
+	uint16_t cur_pending;
 
 	if (unlikely(events_len == 0))
 		return 0;
@@ -133,49 +200,233 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 	if (num_release > 0)
 		slb_port_return_credits(slb, source_port, num_release);
 
+	cur_pending = source_port->pending_releases;
+	RTE_VERIFY(num_forward + num_release <= cur_pending);
+
 	slb_port_enqueue_stats(source_port, num_new, num_forward, num_release);
 
-	/* Enqueue contiguous chunks targeting the same queue */
-	while (idx < events_len) {
-		if (events[idx].op == RTE_EVENT_OP_RELEASE) {
-			idx++;
-			enqueued++;
-			continue;
+	/* Unified zero-copy fast path: when port has no in-flight ordered events
+	 * and no release ops.
+	 */
+	if (likely(source_port->history_avail == SLB_PORT_HISTORY_MAX_TOKENS &&
+		   num_release == 0)) {
+		uint8_t q0 = events[0].queue_id;
+		uint16_t burst_size = 1;
+
+		while (burst_size < events_len &&
+		       events[burst_size].queue_id == q0)
+			burst_size++;
+
+		if (likely(burst_size == events_len)) {
+			rte_event_ring_enqueue_burst(slb->queues[q0].q_ring,
+						     events, events_len, NULL);
+			slb_port_queue_enqueue_burst_stats(source_port, q0,
+							   events_len);
+		} else {
+			uint8_t dest_queues[SLB_MAX_PORT_ENQUEUE_DEPTH];
+			uint16_t queue_counts[SLB_MAX_QUEUES];
+			uint16_t insert_pos[SLB_MAX_QUEUES];
+			uint16_t queue_offsets[SLB_MAX_QUEUES];
+			struct rte_event sorted_events[SLB_MAX_PORT_ENQUEUE_DEPTH];
+			uint64_t batch_queues_mask = (1ULL << q0);
+			uint64_t qmask;
+			uint16_t current_offset = 0;
+
+			queue_counts[q0] = burst_size;
+			for (uint16_t k = 0; k < burst_size; k++)
+				dest_queues[k] = q0;
+
+			for (uint16_t k = burst_size; k < events_len; k++) {
+				uint8_t qid = events[k].queue_id;
+				uint64_t q_bit = (1ULL << qid);
+
+				dest_queues[k] = qid;
+				if (!(batch_queues_mask & q_bit)) {
+					batch_queues_mask |= q_bit;
+					queue_counts[qid] = 1;
+				} else {
+					queue_counts[qid]++;
+				}
+			}
+
+			qmask = batch_queues_mask;
+			while (qmask != 0) {
+				uint8_t q = rte_ctz64(qmask);
+
+				qmask &= (qmask - 1);
+				queue_offsets[q] = current_offset;
+				insert_pos[q] = current_offset;
+				current_offset += queue_counts[q];
+			}
+
+			for (uint16_t k = 0; k < events_len; k++) {
+				uint8_t q = dest_queues[k];
+
+				sorted_events[insert_pos[q]++] = events[k];
+			}
+
+			qmask = batch_queues_mask;
+			while (qmask != 0) {
+				uint8_t q = rte_ctz64(qmask);
+				uint16_t count = queue_counts[q];
+				uint16_t offset = queue_offsets[q];
+
+				qmask &= (qmask - 1);
+				rte_event_ring_enqueue_burst(slb->queues[q].q_ring,
+							     &sorted_events[offset],
+							     count, NULL);
+				slb_port_queue_enqueue_burst_stats(source_port, q,
+								   count);
+			}
 		}
 
-		uint8_t qid = events[idx].queue_id;
-		uint16_t chunk_len = 1;
+		if (num_forward > 0)
+			source_port->pending_releases -= num_forward;
+
+		SLB_LOG_DP_PORT_LINE(DEBUG, source_port->id,
+				     "%d events accepted.", events_len);
+		return events_len;
+	}
 
-		while (idx + chunk_len < events_len &&
-		       events[idx + chunk_len].queue_id == qid &&
-		       events[idx + chunk_len].op != RTE_EVENT_OP_RELEASE) {
-			chunk_len++;
+	/* General path for bursts with in-flight ordered events or releases */
+	uint64_t ordered_drain_mask = 0;
+	uint16_t freed_count = 0;
+	uint16_t head = source_port->history_head;
+	uint16_t n_enq = 0;
+	uint8_t dest_queues[SLB_MAX_PORT_ENQUEUE_DEPTH];
+	const struct rte_event *enq_events[SLB_MAX_PORT_ENQUEUE_DEPTH];
+	uint16_t queue_counts[SLB_MAX_QUEUES];
+	uint64_t batch_queues_mask = 0;
+
+	for (uint16_t idx = 0; idx < events_len; idx++) {
+		const struct rte_event *ev = &events[idx];
+		uint8_t h_idx = (ev->op != RTE_EVENT_OP_NEW) ? ev->impl_opaque : 0;
+		struct slb_history_entry *hist =
+			(h_idx != 0 && source_port->history[h_idx].active) ?
+			&source_port->history[h_idx] : NULL;
+
+		if (hist != NULL && hist->sched_type == RTE_SCHED_TYPE_ORDERED) {
+			struct slb_queue *orig_q = &slb->queues[hist->orig_queue_id];
+
+			if (orig_q->reorder_buffer) {
+				uint16_t slot = hist->seq_slot;
+
+				if (ev->op == RTE_EVENT_OP_RELEASE) {
+					rte_atomic_store_explicit(
+						&orig_q->reorder_buffer[slot].state,
+						SLB_REORDER_RELEASED,
+						rte_memory_order_release);
+				} else {
+					orig_q->reorder_buffer[slot].event = *ev;
+					rte_atomic_store_explicit(
+						&orig_q->reorder_buffer[slot].state,
+						SLB_REORDER_READY,
+						rte_memory_order_release);
+				}
+				ordered_drain_mask |= (1ULL << hist->orig_queue_id);
+			}
+			hist->active = false;
+			hist->next_free = head;
+			head = h_idx;
+			freed_count++;
+			slb_port_queue_enqueue_stats(source_port, ev->queue_id);
+		} else if (ev->op == RTE_EVENT_OP_RELEASE) {
+			if (hist != NULL) {
+				hist->active = false;
+				hist->next_free = head;
+				head = h_idx;
+				freed_count++;
+			}
+			slb_port_queue_enqueue_stats(source_port, ev->queue_id);
+		} else {
+			if (hist != NULL) {
+				hist->active = false;
+				hist->next_free = head;
+				head = h_idx;
+				freed_count++;
+			}
+
+			uint8_t qid = ev->queue_id;
+			uint64_t q_bit = (1ULL << qid);
+
+			dest_queues[n_enq] = qid;
+			enq_events[n_enq] = ev;
+			n_enq++;
+
+			if (!(batch_queues_mask & q_bit)) {
+				batch_queues_mask |= q_bit;
+				queue_counts[qid] = 1;
+			} else {
+				queue_counts[qid]++;
+			}
 		}
+	}
 
-		struct slb_queue *queue = &slb->queues[qid];
-		uint16_t actual_enq = rte_event_ring_enqueue_burst(queue->q_ring,
-								  &events[idx],
-								  chunk_len,
-								  NULL);
-		slb_port_queue_enqueue_burst_stats(source_port, qid, actual_enq);
-		enqueued += actual_enq;
-
-		if (actual_enq < chunk_len) {
-			/* If queue ring is full, return unused credits for dropped NEW events */
-			uint16_t dropped_new = 0;
-			for (uint16_t d = actual_enq; d < chunk_len; d++) {
-				if (events[idx + d].op == RTE_EVENT_OP_NEW)
-					dropped_new++;
+	if (n_enq > 0) {
+		if (likely((batch_queues_mask & (batch_queues_mask - 1)) == 0 &&
+			   n_enq == events_len)) {
+			uint8_t q = rte_ctz64(batch_queues_mask);
+
+			rte_event_ring_enqueue_burst(slb->queues[q].q_ring,
+						     events, events_len, NULL);
+			slb_port_queue_enqueue_burst_stats(source_port, q,
+							   events_len);
+		} else {
+			uint16_t queue_offsets[SLB_MAX_QUEUES];
+			uint16_t insert_pos[SLB_MAX_QUEUES];
+			struct rte_event sorted_events[SLB_MAX_PORT_ENQUEUE_DEPTH];
+			uint16_t current_offset = 0;
+			uint64_t qmask = batch_queues_mask;
+
+			while (qmask != 0) {
+				uint8_t q = rte_ctz64(qmask);
+
+				qmask &= (qmask - 1);
+				queue_offsets[q] = current_offset;
+				insert_pos[q] = current_offset;
+				current_offset += queue_counts[q];
+			}
+
+			for (uint16_t k = 0; k < n_enq; k++) {
+				uint8_t q = dest_queues[k];
+
+				sorted_events[insert_pos[q]++] = *enq_events[k];
+			}
+
+			qmask = batch_queues_mask;
+			while (qmask != 0) {
+				uint8_t q = rte_ctz64(qmask);
+				uint16_t count = queue_counts[q];
+				uint16_t offset = queue_offsets[q];
+
+				qmask &= (qmask - 1);
+				rte_event_ring_enqueue_burst(slb->queues[q].q_ring,
+							     &sorted_events[offset],
+							     count, NULL);
+				slb_port_queue_enqueue_burst_stats(source_port, q,
+								   count);
 			}
-			if (dropped_new > 0)
-				slb_port_return_credits(slb, source_port, dropped_new);
-			break;
 		}
+	}
+
+	if (freed_count > 0) {
+		source_port->history_head = head;
+		source_port->history_avail += freed_count;
+	}
+
+	while (ordered_drain_mask != 0) {
+		uint8_t qid = rte_ctz64(ordered_drain_mask);
 
-		idx += chunk_len;
+		ordered_drain_mask &= ~(1ULL << qid);
+		slb_reorder_drain(slb, &slb->queues[qid]);
 	}
 
-	return enqueued;
+	if (num_forward + num_release > 0)
+		source_port->pending_releases -= (num_forward + num_release);
+
+	SLB_LOG_DP_PORT_LINE(DEBUG, source_port->id,
+			     "%d events accepted.", events_len);
+	return events_len;
 }
 
 uint16_t
@@ -183,6 +434,7 @@ slb_event_enqueue_burst(void *port, const struct rte_event events[],
 			uint16_t events_len)
 {
 	struct slb_port *source_port = port;
+
 	return slb_event_enqueue_burst_generic(source_port, events, events_len,
 					       false, 0, 0, 0);
 }
@@ -192,6 +444,7 @@ slb_event_enqueue_new_burst(void *port, const struct rte_event events[],
 			    uint16_t events_len)
 {
 	struct slb_port *source_port = port;
+
 	return slb_event_enqueue_burst_generic(source_port, events, events_len,
 					       true, events_len, 0, 0);
 }
@@ -201,65 +454,184 @@ slb_event_enqueue_forward_burst(void *port, const struct rte_event events[],
 				uint16_t events_len)
 {
 	struct slb_port *source_port = port;
+
 	return slb_event_enqueue_burst_generic(source_port, events, events_len,
 					       true, 0, events_len, 0);
 }
 
+static inline uint16_t
+slb_ordered_ring_dequeue_burst(struct rte_event_ring *r,
+			       struct rte_event *events,
+			       uint16_t num, uint32_t *start_slot)
+{
+	uint32_t cons_head, cons_next;
+	uint32_t entries;
+	uint16_t n;
+
+	n = __rte_ring_move_cons_head(&r->r, 0, num,
+				      RTE_RING_QUEUE_VARIABLE,
+				      &cons_head, &cons_next, &entries);
+	if (n == 0)
+		return 0;
+
+	*start_slot = cons_head & r->r.mask;
+
+	__rte_ring_dequeue_elems(&r->r, cons_head, events,
+				 sizeof(struct rte_event), n);
+
+	__rte_ring_update_tail(&r->r.cons, cons_head, cons_next, 0);
+
+	return n;
+}
+
 static inline uint16_t
 slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 		 uint16_t num)
 {
-	uint16_t total_deq = 0;
+	uint16_t dequeued = 0;
 
-	/* Single-link direct fast path */
 	if (port->is_single_linked) {
-		if (unlikely(!port->single_linked_ring))
+		if (unlikely(port->single_linked_ring == NULL))
 			return 0;
-
-		total_deq = rte_event_ring_dequeue_burst(port->single_linked_ring,
+		dequeued = rte_event_ring_dequeue_burst(port->single_linked_ring,
 							events, num, NULL);
-		if (total_deq > 0) {
-			port->total_dequeues += total_deq;
-			if (port->implicit_release)
-				slb_port_return_credits(port->slb, port,
-							total_deq);
-		}
-		return total_deq;
+		for (uint16_t j = 0; j < dequeued; j++)
+			events[j].impl_opaque = 0;
+		return dequeued;
 	}
 
-	/* Parallel queue dequeue across priority levels */
-	for (int p = 0; p < SLB_MAX_PRIORITIES; p++) {
-		uint16_t num_q = port->num_q[p];
-		if (num_q == 0)
+	uint64_t active_queues = rte_atomic_load_explicit(
+		&port->active_queues, rte_memory_order_acquire);
+	if (!active_queues)
+		return 0;
+
+	for (int pr = 0; pr < SLB_MAX_PRIORITIES; pr++) {
+		int slots = port->num_q[pr];
+
+		if (slots == 0)
 			continue;
 
-		uint16_t q_idx = port->next_q[p];
-		for (uint16_t i = 0; i < num_q; i++) {
-			struct slb_port_q_entry *entry = &port->q_entries[p][q_idx];
-			uint16_t req = num - total_deq;
-			uint16_t deq = rte_event_ring_dequeue_burst(entry->dq_ring,
-								   &events[total_deq],
-								   req, NULL);
-			if (deq > 0) {
-				port->queue_dequeued[entry->queue_id] += deq;
-				total_deq += deq;
+		int start = port->next_q[pr];
+
+		if (unlikely(start >= slots))
+			start = 0;
+
+		for (int s = 0; s < slots; s++) {
+			int idx = start + s;
+
+			if (idx >= slots)
+				idx -= slots;
+
+			struct slb_port_q_entry *qent = &port->q_entries[pr][idx];
+			uint8_t queue_id = qent->queue_id;
+
+			if (!((active_queues >> queue_id) & 1))
+				continue;
+
+			struct rte_event_ring *ring_to_dq = qent->dq_ring;
+
+			if (unlikely(ring_to_dq == NULL))
+				continue;
+
+			uint8_t sched_type = qent->schedule_type;
+			bool is_ordered = (sched_type == RTE_SCHED_TYPE_ORDERED);
+
+			if (is_ordered) {
+				if (unlikely(port->history_avail == 0))
+					continue;
+
+				uint16_t dequeue_num = RTE_MIN(num,
+							       port->history_avail);
+				uint32_t start_slot = 0;
+
+				dequeued = slb_ordered_ring_dequeue_burst(
+					ring_to_dq, events, dequeue_num,
+					&start_slot);
+
+				if (dequeued > 0) {
+					uint16_t head = port->history_head;
+					uint32_t ring_mask = ring_to_dq->r.mask;
+
+					for (uint16_t j = 0; j < dequeued; j++) {
+						uint16_t h_idx = head;
+						struct slb_history_entry *h =
+							&port->history[h_idx];
+
+						head = h->next_free;
+						h->orig_queue_id = queue_id;
+						h->sched_type = sched_type;
+						h->seq_slot = (start_slot + j) &
+							      ring_mask;
+						h->active = true;
+						events[j].impl_opaque =
+							(uint8_t)h_idx;
+					}
+					port->history_head = head;
+					port->history_avail -= dequeued;
+				}
+			} else {
+				dequeued = rte_event_ring_dequeue_burst(
+					ring_to_dq, events, num, NULL);
+				for (uint16_t j = 0; j < dequeued; j++)
+					events[j].impl_opaque = 0;
 			}
 
-			q_idx++;
-			if (q_idx >= num_q)
-				q_idx = 0;
+			if (dequeued > 0) {
+				idx++;
+				port->next_q[pr] = (idx >= slots) ? 0 : idx;
+				return dequeued;
+			}
+		}
+	}
+	return 0;
+}
 
-			if (total_deq == num)
-				break;
+static inline void
+slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
+				  uint16_t pending)
+{
+	uint16_t head;
+	uint64_t ordered_drain_mask = 0;
+
+	if (port->is_single_linked ||
+	    port->history_avail >= SLB_PORT_HISTORY_MAX_TOKENS)
+		goto done;
+
+	head = port->history_head;
+	for (int i = 1; i < SLB_PORT_HISTORY_SIZE; i++) {
+		struct slb_history_entry *hist = &port->history[i];
+
+		if (!hist->active)
+			continue;
+
+		if (hist->sched_type == RTE_SCHED_TYPE_ORDERED) {
+			struct slb_queue *oq = &slb->queues[hist->orig_queue_id];
+
+			if (oq->reorder_buffer) {
+				rte_atomic_store_explicit(
+					&oq->reorder_buffer[hist->seq_slot].state,
+					SLB_REORDER_RELEASED,
+					rte_memory_order_release);
+				ordered_drain_mask |= (1ULL << hist->orig_queue_id);
+			}
 		}
-		port->next_q[p] = q_idx;
+		hist->active = false;
+		hist->next_free = head;
+		head = (uint16_t)i;
+		port->history_avail++;
+	}
+	port->history_head = head;
 
-		if (total_deq > 0)
-			break;
+	while (ordered_drain_mask != 0) {
+		uint8_t qid = rte_ctz64(ordered_drain_mask);
+
+		ordered_drain_mask &= ~(1ULL << qid);
+		slb_reorder_drain(slb, &slb->queues[qid]);
 	}
 
-	port->total_dequeues += total_deq;
-	return total_deq;
+done:
+	slb_port_return_credits(slb, port, pending);
+	port->pending_releases = 0;
 }
 
 uint16_t
@@ -267,13 +639,24 @@ slb_event_dequeue_burst(void *p, struct rte_event events[], uint16_t num,
 			uint64_t wait __rte_unused)
 {
 	struct slb_port *port = p;
+	struct slb_evdev *slb = port->slb;
+	uint16_t pending = port->pending_releases;
+	uint16_t n;
+
+	if (port->implicit_release && pending > 0)
+		slb_port_process_implicit_release(port, slb, pending);
+
+	if (unlikely(num > port->dequeue_depth))
+		num = port->dequeue_depth;
 
 	port->dequeue_calls++;
-	uint16_t dequeued = slb_port_dequeue(port, events, num);
-	port->dequeued += dequeued;
+	n = slb_port_dequeue(port, events, num);
+	if (n > 0)
+		port->pending_releases += n;
+	port->dequeued += n;
 
-	if (dequeued == 0)
+	if (n == 0)
 		port->empty_dequeues++;
 
-	return dequeued;
+	return n;
 }
-- 
2.53.0

