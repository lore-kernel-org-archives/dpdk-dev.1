Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0541606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v58qaZ10
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C88A42E12;
	Sat,  7 Nov 2026 02:30:25 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTPS id B9A3C42E0B
 for <dev@dpdk.org>; Sat,  7 Nov 2026 02:30:23 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-5364648ae07so11153941cf.1
 for <dev@dpdk.org>; Fri, 06 Nov 2026 17:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794015023; x=1794619823; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nlJptA5GYD0ovRmnpm48CswnLLaHJr6NxCjBwRl8vtg=;
 b=v58qaZ10VfIFXIdbYdohdXInOeSs3xPk+gGmmhlN3jn7JO/wiQZjx0B4orOtAGqZcr
 XfFlzwQtT4fa/o/CurrgFs6DPRTQzZEb2zp1vFozi9vOBjEpnNii7YmYOxBIpPS1yn3n
 XDgJB1XoLD2fKP2tFhhzK5sA4RjDyZQJs+Vl0Vm8WBXrPOUklE//4jLM7UTrEvLCuL6t
 tG1i2EeFYb+r0q3ZHrDI5aBbxnbs/ZA9hvL/+Tf7BpQen1+rsTU5PShf1o/gzP1juX3R
 KrnTMvlpDnqxg4+NecXwDOeHUdBnmSIXanadIXEUNKPLPHPrHT/cK3cAI2R6ebTUBSDV
 hKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794015023; x=1794619823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nlJptA5GYD0ovRmnpm48CswnLLaHJr6NxCjBwRl8vtg=;
 b=vvtMWH1Mwl/cjdSfQNWdZmZcUZrQM4oJC+Df2xNQpyRc34epvxt0Ers6F3I6tX9QQA
 g7ouDrykPSEmOJ7MRhFAfjRjPHucVh3l24mCGjFStkugGb527ZI1+rGvSn+gt2+Y6Qg8
 RJ+DAxsBggH9zRKzDfJ4lp3nQmADPJYsOz55mMRApFn5Nq4r5xAUms/zJK5jW/6rFd1z
 t4ZHoMyLdQLW2kpf5Zb1nU5MlmzpiAPWrZ4BYdSPC8tTHiiOxB74zrNktZ3fyNs/BckN
 h79Vze/P8/iMleits3WyssDyHm9vThYIZMB/RZKMif6PIeiAaLwwClcVSi3pHrfc7KdW
 GNzw==
X-Gm-Message-State: APuU4Z8prl1dl5musBJJtz+h7w36QHbAKY/JdraQ56YBpZ7iO5Noa8wV
 PtRDcN+fSjOvsay9ShkBiLNKmeuh2yo2uPPseVmrp64OP+Fr4dp9Otpz5u5AusZfH8659Q==
X-Gm-Gg: AYBFou3loqRwo+h+K369tzzmtilOKmzaM2wXkKNmIA0PQpKJZoSej+DaaetYTFaynwa
 5p1+oUr2ySStRM1Rg02DzfP3cNLDUoR4UVleQzDn6IB4WBm9pzAPLPrSrhAJDDxqmVlBPOfEYiV
 zCdxbmGGgtAB247YZsIjgZ6AkqPilwzmtXFJJrtxoNk60yqNaWQSf/cRkgR06hnUlcTyMGITkTa
 jf2bk/vPx0K+nBZNIhYFA2LJ7klpr0xUFCLcEPVa565nH7GG3lS7iSSchOK0FrlnVlzrBtLCewU
 CS1wMq8wrL61yziGiZd9FEOl82g034auFwgDcYLsIsJhU9NrIlsla3ayEHSJlqEQ+5RNB0Ri54b
 3YdnUZSgNaj3YLjTYthT5P60T6h7Af4X3xEcuFfZ8kzDShE6Hr6a7/jl3eKAdmeuCxrpe7FM8OP
 OZnp7FIjJpF9+B93ZUfthoBrxqenOV4/+xvCPJw/dgDQkah72ClBeovRbHO3bqL23+S1kdW9H2R
 bmhlprcRVFlKx0RCc5F/P365lqMxSxGISgKKwKNjRm3QTkqlOmJC2Qf2DCUVfoExfqiKu5FZ7uD
 V2Fk44BEx+sQ7sgSd50lcapFmfO4o5QV8tDMeHabXdXNROF6hw2pcbEP3eACR/sndJ3aeAcysKB
 k8y91FWslTvcmejEC
X-Received: by 2002:a05:622a:2593:b0:533:8f29:e5fd with SMTP id
 d75a77b69052e-54e13299edfmr62715821cf.18.1794015022532; 
 Fri, 06 Nov 2026 17:30:22 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c2ac1.dyn.optonline.net. [148.76.42.193])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e257862bfsm33746111cf.6.2026.11.06.17.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:30:22 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v1 3/8] event/slb: add support for atomic queues
Date: Fri,  6 Nov 2026 20:30:05 -0500
Message-ID: <20261107013011.2443138-4-pravinpathakdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
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

Add support for RTE_SCHED_TYPE_ATOMIC queues to provide per-flow event
serialization across worker ports.

Flow affinity is maintained using a 2048-entry flow map that pins each
flow ID to a serving worker port upon first observation. Events for each
atomic queue are held in a main ring and scheduled into dedicated per-port
rings via slb_atomic_refill using counting sort grouping.

A hold buffer retains events when destination port rings are temporarily
full to preserve flow FIFO ordering. Worker ports dequeue atomic events
from their private rings and record active flows in port history to track
returns on release or forward operations.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 drivers/event/slb/slb_evdev.c |  90 +++++++++-
 drivers/event/slb/slb_evdev.h |  37 ++++
 drivers/event/slb/slb_event.c | 312 +++++++++++++++++++++++++++++++---
 3 files changed, 411 insertions(+), 28 deletions(-)

diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
index 13be490636..be0b3630f6 100644
--- a/drivers/event/slb/slb_evdev.c
+++ b/drivers/event/slb/slb_evdev.c
@@ -121,6 +121,10 @@ slb_queue_release(struct rte_eventdev *dev, uint8_t queue_id)
 	struct slb_evdev *slb = slb_pmd_priv(dev);
 	struct slb_queue *queue = &slb->queues[queue_id];
 
+	if (queue->atomic_state) {
+		rte_free(queue->atomic_state);
+		queue->atomic_state = NULL;
+	}
 	if (queue->reorder_buffer) {
 		rte_free(queue->reorder_buffer);
 		queue->reorder_buffer = NULL;
@@ -129,6 +133,12 @@ slb_queue_release(struct rte_eventdev *dev, uint8_t queue_id)
 		rte_event_ring_free(queue->q_ring);
 		queue->q_ring = NULL;
 	}
+	for (int i = 0; i < SLB_MAX_PORTS; i++) {
+		if (queue->per_port_rings[i]) {
+			rte_event_ring_free(queue->per_port_rings[i]);
+			queue->per_port_rings[i] = NULL;
+		}
+	}
 }
 
 /* Setup Eventdev queue. Eventdev queues are implemented as DPDK rings */
@@ -154,9 +164,14 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 		queue->is_single_link = true;
 		ring = rte_event_ring_create(ring_name, q_size,
 			dev->data->socket_id, RING_F_SC_DEQ | RING_F_EXACT_SZ);
+	} else if (conf->schedule_type == RTE_SCHED_TYPE_ATOMIC) {
+		/* MP -> SC ring for atomic queues main ring */
+		queue->is_single_link = false;
+		ring = rte_event_ring_create(ring_name, q_size,
+			dev->data->socket_id, RING_F_SC_DEQ | RING_F_EXACT_SZ);
 	} else if (conf->schedule_type == RTE_SCHED_TYPE_PARALLEL ||
 		   conf->schedule_type == RTE_SCHED_TYPE_ORDERED) {
-		/* MP -> MC ring for parallel queues */
+		/* MP -> MC ring for parallel or ordered queues */
 		queue->is_single_link = false;
 		ring = rte_event_ring_create(ring_name, q_size,
 			dev->data->socket_id, RING_F_EXACT_SZ);
@@ -174,6 +189,31 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 	queue->serving_ports_mask = 0;
 	queue->num_serving_ports = 0;
 
+	/* Atomic queue allocation */
+	if (conf->schedule_type == RTE_SCHED_TYPE_ATOMIC) {
+		for (int i = 0; i < SLB_MAX_PORTS; i++)
+			queue->per_port_rings[i] = NULL;
+
+		queue->atomic_state = rte_zmalloc_socket("slb_atomic_state",
+			sizeof(struct slb_atomic_state),
+			RTE_CACHE_LINE_SIZE, dev->data->socket_id);
+		if (queue->atomic_state == NULL) {
+			rte_event_ring_free(ring);
+			return -ENOMEM;
+		}
+		for (int i = 0; i < SLB_ATOMIC_FLOWS; i++)
+			rte_atomic_store_explicit(
+				&queue->atomic_state->flow_map.flows[i].port_id,
+				-1, rte_memory_order_relaxed);
+		queue->atomic_state->next_port_rr = 0;
+		rte_spinlock_init(&queue->atomic_state->refill_lock);
+		queue->atomic_state->hold_count = 0;
+		memset(queue->atomic_state->port_stats, 0,
+		       sizeof(queue->atomic_state->port_stats));
+	} else {
+		queue->atomic_state = NULL;
+	}
+
 	/* Ordered queue reorder buffer allocation */
 	if (conf->schedule_type == RTE_SCHED_TYPE_ORDERED) {
 		queue->reorder_buffer = rte_zmalloc_socket("slb_reorder_buf",
@@ -244,6 +284,26 @@ slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
 		port->single_linked_q = queue;
 		port->single_linked_ring = queue->q_ring;
 	} else {
+		if (queue->schedule_type == RTE_SCHED_TYPE_ATOMIC &&
+		    queue->per_port_rings[port->id] == NULL) {
+			char ring_name[RTE_RING_NAMESIZE];
+			struct rte_event_ring *ring;
+
+			snprintf(ring_name, sizeof(ring_name),
+				 "slb%d_q%u_p%u", port->slb->data->dev_id,
+				 qid, port->id);
+			ring = rte_event_ring_create(
+				ring_name,
+				SLB_MAX_PORT_DEQUEUE_DEPTH * 4,
+				port->slb->data->socket_id,
+				RING_F_SP_ENQ | RING_F_SC_DEQ);
+			if (ring == NULL) {
+				rte_errno = ENOMEM;
+				return -ENOMEM;
+			}
+			queue->per_port_rings[port->id] = ring;
+		}
+
 		if (has_prio)
 			prio = (app_prio < RTE_EVENT_DEV_PRIORITY_NORMAL) ? 0 : 1;
 		else
@@ -262,12 +322,15 @@ slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
 		}
 		if (!found) {
 			uint16_t slot = port->num_q[prio];
+			struct rte_event_ring *dq_ring =
+				(queue->schedule_type == RTE_SCHED_TYPE_ATOMIC) ?
+				queue->per_port_rings[port->id] : queue->q_ring;
 
 			if (slot >= SLB_PORT_MAX_Q_MAP_PER_PRIO) {
 				rte_errno = ENOSPC;
 				return -ENOSPC;
 			}
-			port->q_entries[prio][slot].dq_ring = queue->q_ring;
+			port->q_entries[prio][slot].dq_ring = dq_ring;
 			port->q_entries[prio][slot].queue = queue;
 			port->q_entries[prio][slot].queue_id = qid;
 			port->q_entries[prio][slot].schedule_type =
@@ -311,6 +374,13 @@ slb_port_unlink_one(struct slb_port *port, struct slb_queue *queue, uint8_t qid)
 			rte_errno = EINVAL;
 			return -EINVAL;
 		}
+
+		if (queue->schedule_type == RTE_SCHED_TYPE_ATOMIC &&
+		    queue->per_port_rings[port->id] != NULL) {
+			rte_event_ring_free(queue->per_port_rings[port->id]);
+			queue->per_port_rings[port->id] = NULL;
+		}
+
 		rte_atomic_fetch_and_explicit(&port->active_queues,
 					      ~(1ULL << qid),
 					      rte_memory_order_release);
@@ -379,6 +449,7 @@ slb_info_get(struct rte_eventdev *dev __rte_unused,
 		.max_profiles_per_port = 1,
 		.event_dev_cap = RTE_EVENT_DEV_CAP_BURST_MODE |
 		RTE_EVENT_DEV_CAP_PARALLEL |
+		RTE_EVENT_DEV_CAP_ATOMIC |
 		RTE_EVENT_DEV_CAP_ORDERED |
 		RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED |
 		RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE |
@@ -474,6 +545,21 @@ slb_stop(struct rte_eventdev *dev)
 
 	for (uint8_t qid = 0; qid < slb->num_queues; qid++) {
 		struct slb_queue *q = &slb->queues[qid];
+
+		if (q->schedule_type == RTE_SCHED_TYPE_ATOMIC && q->atomic_state != NULL) {
+			for (int f = 0; f < SLB_ATOMIC_FLOWS; f++)
+				rte_atomic_store_explicit(
+					&q->atomic_state->flow_map.flows[f].port_id,
+					-1, rte_memory_order_relaxed);
+
+			for (uint16_t pid = 0; pid < slb->num_ports; pid++) {
+				if (q->per_port_rings[pid] != NULL)
+					slb_drain_ring(dev_id,
+						       q->per_port_rings[pid],
+						       flush, flush_arg);
+			}
+		}
+
 		if (q->q_ring != NULL)
 			slb_drain_ring(dev_id, q->q_ring, flush, flush_arg);
 	}
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
index b73127a739..7a70d5c94c 100644
--- a/drivers/event/slb/slb_evdev.h
+++ b/drivers/event/slb/slb_evdev.h
@@ -84,6 +84,39 @@ struct slb_reorder_entry {
 	RTE_ATOMIC(uint8_t) state;
 };
 
+#define SLB_ATOMIC_FLOWS 2048
+#define SLB_ATOMIC_FLOWS_MASK (SLB_ATOMIC_FLOWS - 1)
+#define SLB_HOLD_BUFFER_SIZE (SLB_MAX_PORT_DEQUEUE_DEPTH * 64)
+
+/* Per-flow entry for atomic scheduling affinity */
+struct slb_flow {
+	RTE_ATOMIC(int32_t) port_id; /* Port this flow is pinned to */
+};
+
+/* Flow-to-port affinity mapping table */
+struct slb_flow_map {
+	struct slb_flow flows[SLB_ATOMIC_FLOWS];
+};
+
+/* Per-port counters for an atomic queue */
+struct __rte_cache_aligned slb_atomic_port_stats {
+	uint32_t flow_count;   /* Number of active flows mapped to this port */
+	uint64_t q_enqueued;   /* Events scheduled into this port's atomic port-Q */
+	uint64_t q_returned;   /* Events returned (FORWARD/RELEASE) by this port */
+};
+
+/* Dynamically allocated state for atomic queues */
+struct slb_atomic_state {
+	struct slb_flow_map flow_map;
+	uint32_t next_port_rr;
+	rte_spinlock_t refill_lock;
+	uint16_t hold_count;
+	alignas(RTE_CACHE_LINE_SIZE)
+	struct slb_atomic_port_stats port_stats[SLB_MAX_PORTS];
+	uint8_t hold_ports[SLB_HOLD_BUFFER_SIZE];
+	struct rte_event hold_buffer[SLB_HOLD_BUFFER_SIZE];
+};
+
 struct __rte_cache_aligned slb_port {
 	/* --- Cacheline 0: Hot Rx & Tx scheduling control (64 bytes) --- */
 	uint16_t id;
@@ -134,6 +167,10 @@ struct slb_queue {
 	uint16_t num_serving_ports;
 	uint64_t serving_ports_mask;
 	alignas(RTE_CACHE_LINE_SIZE) struct rte_event_ring *q_ring;
+	/* Per-port rings for atomic queues */
+	struct rte_event_ring *per_port_rings[SLB_MAX_PORTS];
+	/* For atomic queues (dynamically allocated) */
+	struct slb_atomic_state *atomic_state;
 	/* For ordered queues (dynamically allocated) */
 	struct slb_reorder_entry *reorder_buffer;
 	uint32_t reorder_drain_idx;
diff --git a/drivers/event/slb/slb_event.c b/drivers/event/slb/slb_event.c
index b6c7a8a514..22f40d72d4 100644
--- a/drivers/event/slb/slb_event.c
+++ b/drivers/event/slb/slb_event.c
@@ -156,6 +156,216 @@ slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 	rte_spinlock_unlock(&queue->reorder_lock);
 }
 
+/* Hash flow ID to atomic flow slot index */
+static inline uint32_t
+slb_flow_hash(uint32_t flow_id)
+{
+	return (flow_id * 2654435761U) & SLB_ATOMIC_FLOWS_MASK;
+}
+
+/* If port queue is empty for an atomic queue, pull events from main atomic queue to fill
+ * up port queues.
+ */
+static void
+slb_atomic_refill(struct slb_port *port __rte_unused, struct slb_queue *queue)
+{
+	struct rte_event master_events[SLB_MAX_PORT_DEQUEUE_DEPTH];
+	uint16_t n_deq;
+	uint16_t i;
+	uint64_t full_ports_mask = 0;
+	struct slb_atomic_state *astate = queue->atomic_state;
+	uint64_t serving_mask;
+	uint16_t num_serving_ports;
+
+	if (unlikely(astate == NULL))
+		return;
+
+	if (!rte_spinlock_trylock(&astate->refill_lock))
+		return;
+
+	/* 1. Process Hold Buffer first */
+	if (astate->hold_count > 0) {
+		uint16_t retained = 0;
+		uint16_t count = astate->hold_count;
+
+		i = 0;
+		while (i < count) {
+			uint8_t dest_port_id = astate->hold_ports[i];
+			uint16_t burst_len = 1;
+
+			while ((i + burst_len) < count &&
+			       astate->hold_ports[i + burst_len] == dest_port_id)
+				burst_len++;
+
+			if (full_ports_mask & (1ULL << dest_port_id)) {
+				if (retained != i) {
+					memmove(&astate->hold_buffer[retained],
+						&astate->hold_buffer[i],
+						burst_len * sizeof(struct rte_event));
+					memmove(&astate->hold_ports[retained],
+						&astate->hold_ports[i],
+						burst_len);
+				}
+				retained += burst_len;
+				i += burst_len;
+				continue;
+			}
+
+			uint16_t enqueued = rte_event_ring_enqueue_burst(
+				queue->per_port_rings[dest_port_id],
+				&astate->hold_buffer[i], burst_len, NULL);
+			astate->port_stats[dest_port_id].q_enqueued += enqueued;
+
+			if (enqueued < burst_len) {
+				uint16_t rem = burst_len - enqueued;
+				uint16_t start_idx = i + enqueued;
+
+				full_ports_mask |= (1ULL << dest_port_id);
+				if (retained != start_idx) {
+					memmove(&astate->hold_buffer[retained],
+						&astate->hold_buffer[start_idx],
+						rem * sizeof(struct rte_event));
+					memmove(&astate->hold_ports[retained],
+						&astate->hold_ports[start_idx],
+						rem);
+				}
+				retained += rem;
+			}
+
+			i += burst_len;
+		}
+
+		astate->hold_count = retained;
+		if (astate->hold_count > 0) {
+			rte_spinlock_unlock(&astate->refill_lock);
+			return;
+		}
+	}
+
+	/* 2. Dequeue events from main atomic queue in batches */
+	serving_mask = queue->serving_ports_mask;
+	num_serving_ports = queue->num_serving_ports;
+
+	if (num_serving_ports == 0) {
+		rte_spinlock_unlock(&astate->refill_lock);
+		return;
+	}
+
+	for (int iter = 0; iter < 2; iter++) {
+		n_deq = rte_event_ring_dequeue_burst(
+			queue->q_ring, master_events, RTE_DIM(master_events), NULL);
+
+		if (n_deq == 0)
+			break;
+
+		uint8_t dest_ports[SLB_MAX_PORT_DEQUEUE_DEPTH];
+		uint16_t port_counts[SLB_MAX_PORTS];
+		uint16_t insert_pos[SLB_MAX_PORTS];
+		uint16_t port_offsets[SLB_MAX_PORTS];
+		struct rte_event sorted_events[SLB_MAX_PORT_DEQUEUE_DEPTH];
+		uint64_t batch_ports_mask = 0;
+
+		for (i = 0; i < n_deq; i++) {
+			struct rte_event *ev = &master_events[i];
+			uint32_t flow_idx = slb_flow_hash(ev->flow_id);
+			int32_t dest_port_id =
+				rte_atomic_load_explicit(
+					&astate->flow_map.flows[flow_idx].port_id,
+					rte_memory_order_acquire);
+
+			if (unlikely(dest_port_id == -1)) {
+				uint32_t rr_counter = astate->next_port_rr++;
+				int port_offset = rr_counter % num_serving_ports;
+				uint64_t temp_mask = serving_mask;
+				uint8_t assigned_port = 0;
+
+				for (int j = 0; j <= port_offset; j++) {
+					assigned_port = rte_ctz64(temp_mask);
+					temp_mask &= (temp_mask - 1);
+				}
+
+				dest_port_id = assigned_port;
+				rte_atomic_store_explicit(
+					&astate->flow_map.flows[flow_idx].port_id,
+					dest_port_id, rte_memory_order_release);
+				astate->port_stats[dest_port_id].flow_count++;
+			}
+
+			dest_ports[i] = (uint8_t)dest_port_id;
+			uint64_t p_bit = (1ULL << dest_port_id);
+
+			if (!(batch_ports_mask & p_bit)) {
+				batch_ports_mask |= p_bit;
+				port_counts[dest_port_id] = 1;
+			} else {
+				port_counts[dest_port_id]++;
+			}
+		}
+
+		uint16_t current_offset = 0;
+		uint64_t pmask = batch_ports_mask;
+
+		while (pmask != 0) {
+			uint8_t p = rte_ctz64(pmask);
+
+			pmask &= (pmask - 1);
+			port_offsets[p] = current_offset;
+			insert_pos[p] = current_offset;
+			current_offset += port_counts[p];
+		}
+
+		for (i = 0; i < n_deq; i++) {
+			uint8_t p = dest_ports[i];
+
+			sorted_events[insert_pos[p]++] = master_events[i];
+		}
+
+		pmask = batch_ports_mask;
+		while (pmask != 0) {
+			uint8_t p = rte_ctz64(pmask);
+			uint16_t p_count = port_counts[p];
+			uint16_t p_start = port_offsets[p];
+
+			pmask &= (pmask - 1);
+
+			if (full_ports_mask & (1ULL << p)) {
+				uint16_t space = SLB_HOLD_BUFFER_SIZE - astate->hold_count;
+				uint16_t to_copy = RTE_MIN(p_count, space);
+
+				if (to_copy > 0) {
+					rte_memcpy(&astate->hold_buffer[astate->hold_count],
+						   &sorted_events[p_start],
+						   to_copy * sizeof(struct rte_event));
+					memset(&astate->hold_ports[astate->hold_count], p, to_copy);
+					astate->hold_count += to_copy;
+				}
+				continue;
+			}
+
+			uint16_t enqueued = rte_event_ring_enqueue_burst(
+				queue->per_port_rings[p], &sorted_events[p_start], p_count, NULL);
+			astate->port_stats[p].q_enqueued += enqueued;
+
+			if (enqueued < p_count) {
+				uint16_t rem = p_count - enqueued;
+				uint16_t space = SLB_HOLD_BUFFER_SIZE - astate->hold_count;
+				uint16_t to_copy = RTE_MIN(rem, space);
+
+				full_ports_mask |= (1ULL << p);
+				if (to_copy > 0) {
+					rte_memcpy(&astate->hold_buffer[astate->hold_count],
+						   &sorted_events[p_start + enqueued],
+						   to_copy * sizeof(struct rte_event));
+					memset(&astate->hold_ports[astate->hold_count], p, to_copy);
+					astate->hold_count += to_copy;
+				}
+			}
+		}
+	}
+
+	rte_spinlock_unlock(&astate->refill_lock);
+}
+
 static inline uint16_t
 slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				const struct rte_event events[],
@@ -205,7 +415,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 
 	slb_port_enqueue_stats(source_port, num_new, num_forward, num_release);
 
-	/* Unified zero-copy fast path: when port has no in-flight ordered events
+	/* Unified zero-copy fast path: when port has no in-flight ordered/atomic events
 	 * and no release ops.
 	 */
 	if (likely(source_port->history_avail == SLB_PORT_HISTORY_MAX_TOKENS &&
@@ -288,7 +498,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 		return events_len;
 	}
 
-	/* General path for bursts with in-flight ordered events or releases */
+	/* General path for bursts with in-flight ordered/atomic events or releases */
 	uint64_t ordered_drain_mask = 0;
 	uint16_t freed_count = 0;
 	uint16_t head = source_port->history_head;
@@ -332,6 +542,14 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 			slb_port_queue_enqueue_stats(source_port, ev->queue_id);
 		} else if (ev->op == RTE_EVENT_OP_RELEASE) {
 			if (hist != NULL) {
+				if (hist->sched_type == RTE_SCHED_TYPE_ATOMIC) {
+					struct slb_queue *orig_q =
+						&slb->queues[hist->orig_queue_id];
+					if (orig_q->atomic_state) {
+						uint8_t ep = hist->enq_port_id;
+						orig_q->atomic_state->port_stats[ep].q_returned++;
+					}
+				}
 				hist->active = false;
 				hist->next_free = head;
 				head = h_idx;
@@ -340,6 +558,14 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 			slb_port_queue_enqueue_stats(source_port, ev->queue_id);
 		} else {
 			if (hist != NULL) {
+				if (hist->sched_type == RTE_SCHED_TYPE_ATOMIC) {
+					struct slb_queue *orig_q =
+						&slb->queues[hist->orig_queue_id];
+					if (orig_q->atomic_state) {
+						uint8_t ep = hist->enq_port_id;
+						orig_q->atomic_state->port_stats[ep].q_returned++;
+					}
+				}
 				hist->active = false;
 				hist->next_free = head;
 				head = h_idx;
@@ -484,6 +710,35 @@ slb_ordered_ring_dequeue_burst(struct rte_event_ring *r,
 	return n;
 }
 
+static inline void
+slb_port_record_dequeued_history(struct slb_port *port, struct rte_event events[],
+				 uint16_t dequeued, uint8_t queue_id,
+				 uint8_t sched_type, uint32_t start_slot,
+				 uint32_t ring_mask)
+{
+	uint16_t head = port->history_head;
+	bool is_ordered = (sched_type == RTE_SCHED_TYPE_ORDERED);
+
+	for (uint16_t j = 0; j < dequeued; j++) {
+		uint16_t h_idx = head;
+		struct slb_history_entry *h = &port->history[h_idx];
+
+		head = h->next_free;
+		h->orig_queue_id = queue_id;
+		h->sched_type = sched_type;
+		if (is_ordered) {
+			h->seq_slot = (start_slot + j) & ring_mask;
+		} else {
+			h->enq_port_id = (uint8_t)port->id;
+			h->flow_id = events[j].flow_id;
+		}
+		h->active = true;
+		events[j].impl_opaque = (uint8_t)h_idx;
+	}
+	port->history_head = head;
+	port->history_avail -= dequeued;
+}
+
 static inline uint16_t
 slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 		 uint16_t num)
@@ -535,8 +790,9 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 
 			uint8_t sched_type = qent->schedule_type;
 			bool is_ordered = (sched_type == RTE_SCHED_TYPE_ORDERED);
+			bool is_atomic = (sched_type == RTE_SCHED_TYPE_ATOMIC);
 
-			if (is_ordered) {
+			if (is_ordered || is_atomic) {
 				if (unlikely(port->history_avail == 0))
 					continue;
 
@@ -544,31 +800,27 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 							       port->history_avail);
 				uint32_t start_slot = 0;
 
-				dequeued = slb_ordered_ring_dequeue_burst(
-					ring_to_dq, events, dequeue_num,
-					&start_slot);
-
-				if (dequeued > 0) {
-					uint16_t head = port->history_head;
-					uint32_t ring_mask = ring_to_dq->r.mask;
-
-					for (uint16_t j = 0; j < dequeued; j++) {
-						uint16_t h_idx = head;
-						struct slb_history_entry *h =
-							&port->history[h_idx];
-
-						head = h->next_free;
-						h->orig_queue_id = queue_id;
-						h->sched_type = sched_type;
-						h->seq_slot = (start_slot + j) &
-							      ring_mask;
-						h->active = true;
-						events[j].impl_opaque =
-							(uint8_t)h_idx;
+				if (is_ordered) {
+					dequeued = slb_ordered_ring_dequeue_burst(
+						ring_to_dq, events, dequeue_num,
+						&start_slot);
+				} else {
+					dequeued = rte_event_ring_dequeue_burst(
+						ring_to_dq, events, dequeue_num,
+						NULL);
+					if (dequeued == 0) {
+						slb_atomic_refill(port, qent->queue);
+						dequeued = rte_event_ring_dequeue_burst(
+							ring_to_dq, events, dequeue_num,
+							NULL);
 					}
-					port->history_head = head;
-					port->history_avail -= dequeued;
 				}
+
+				if (dequeued > 0)
+					slb_port_record_dequeued_history(
+						port, events, dequeued, queue_id,
+						sched_type, start_slot,
+						ring_to_dq->r.mask);
 			} else {
 				dequeued = rte_event_ring_dequeue_burst(
 					ring_to_dq, events, num, NULL);
@@ -614,6 +866,14 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 					rte_memory_order_release);
 				ordered_drain_mask |= (1ULL << hist->orig_queue_id);
 			}
+		} else if (hist->sched_type == RTE_SCHED_TYPE_ATOMIC) {
+			struct slb_queue *oq = &slb->queues[hist->orig_queue_id];
+
+			if (oq->atomic_state) {
+				uint8_t ep = hist->enq_port_id;
+
+				oq->atomic_state->port_stats[ep].q_returned++;
+			}
 		}
 		hist->active = false;
 		hist->next_free = head;
-- 
2.53.0

