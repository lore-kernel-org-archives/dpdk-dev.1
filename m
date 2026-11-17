Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC5606A899
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=efn/BDb+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D32D040430;
	Tue, 17 Nov 2026 18:57:31 +0100 (CET)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 3AFC6402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:57:29 +0100 (CET)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-55c48582654so865131cf.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794938248; x=1795543048; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xc1DabXBWCmRcrq/yx8umXekrfyJZWbliFP/ZChu16g=;
 b=efn/BDb+dRSpZBZhurs48n/CVmZrmwJ3hBqZU0UwrrHa6+EvqpeV/KlhtHxVy0EqBK
 Cw1mfq789W4vypcEgJTiOfxA7riBa7z4DfJjou6RGxD3BGMfZaC50Oc5Tl5y72SHVJ9Z
 K18gwFrt2e2nzCLuo65t+d687kwcYjEpHMkn6xNYyiYjibQ7BUvz9le11QUJz1Nays43
 D367Mlg0tRrI0FQeaOxw+ePSHSilfguopkBPXn5KobmIytSJoXIe0hDinEch9zoKq2hR
 O0LmZZjGTREVCnd1Hfsx3WbLIxfdSyF1+0vPc0EbW+wVTvmPAWF+ITKMKnFntBcwuz75
 zM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938248; x=1795543048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xc1DabXBWCmRcrq/yx8umXekrfyJZWbliFP/ZChu16g=;
 b=VonSQMuaUZZhjqwHi4rNM2HPewrNCMi5WEFcFdgpllq7y47nlLi0KKUQEQqIyYSjZC
 c/smtGUreW5f1wTJy9y1owIp0KY0hygsl0jhzTegFDXdqVxGHStyltdlB3zba53DcZvI
 bplt/A4t4npBQbeQpnXc6436PEb7LhoutXIGcgsBqtAqOK8jUaDcoPzeo18A0u2LGOud
 tj28ubDIeCTDHE6jQFDAyOVxWfgSkwb5Ma8mJH1VzCK61Kg/9tXxzpx4DWSDnQhEDRmQ
 8oIbzjbO4Ark/vvIH2JvQeQ42vxeFDf8yNZXTTs4MCbRmszSVYXT1rTA+hcvLgOTw1F3
 KqnQ==
X-Gm-Message-State: APuU4Z+nEC0yU3klq91bRzOAhVmA5M5KQQHWaq/r2DgCkgO4ZeHeywc1
 5RMaRY6PSAiJSb1t9DFFqaH0lXjgHRHPS3UCtcL/e4pnzfTSodDZG+fh8ZcMAXsQ
X-Gm-Gg: AYBFou0pGnBuSBvy99YgAO1opaIhc1pA8Kg23RjWiBzO9a+W57QoBkvuEny7lDcPqpT
 2lqeP8X/UZ038trtn8wwBqMC7AGA39Ci1pP4o2eksZu4uXrOKlN0jrmLo5Avhq6oLefTUW8IF90
 BD/nK8UPPuhxFHfIOqZR8/+2eROSauo1G9eOj+949hd+McT8f1mFXqgWzSkXtJU+eNfSgXBHVWU
 BNGSPf0iqroTJeebtuk+fkflljtr+8Quze1hZvE1iK2gOdN/WrlgJK7B08CI8ksDk2Vd6ptv89b
 wb0f3HZXOAbh+ejk9Bm+t5aCkmTQpT+S5oFxwILWsXqCSoyatk0gP1jqRBdftXXUISYSkukmoJk
 HU1Yfipo3q43TjSAEYmzMo5ys+yLxO4GqYhbGHgz+IjMaAEKjkmeXLSS9Yprq+H1TdYUY3hMHlG
 Yg95h6VnQny8UsWCpVmCKb1ACCHmFsAOdAZ3+P0ThODEPhgOw7GrWQlkQsZir5snbd7FEu6//ay
 oGLMLhVhAXLzXZdKs7MObVN37U4pUzOk7ZSjHz7FPMa/XkrOlnlYNGgRud7WYUG5YYZSQLfW5GI
 uIEGgHAPjjAuN0com4wLSaVu1n07qmfyAXRhphsDMAqt+mECNsM4DZCtuAjqqy7nnZIarPfzRph
 QD6K56hT2M+iirCejghPaTjlPEKT/VM9vJiqfga4O1M5isd4uU1PdVmXeF0IXbzlw+gy7WzKXKw
 ==
X-Received: by 2002:ac8:5f50:0:b0:535:23ee:eb7f with SMTP id
 d75a77b69052e-55d5a34dfdemr1478921cf.1.1794938247814; 
 Tue, 17 Nov 2026 09:57:27 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c29f7.dyn.optonline.net. [148.76.41.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921148c261bsm327426d6.0.2026.11.17.09.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:57:27 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 david.marchand@redhat.com, nipun.gupta@amd.com, chenbox@nvidia.com,
 tirthendu.sarkar@intel.com, mattias.ronnblom@ericsson.com,
 stephen@networkplumber.org, Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v2 4/8] event/slb: add dynamic flow migration for atomic queues
Date: Tue, 17 Nov 2026 12:57:04 -0500
Message-ID: <20261117175709.2346400-5-pravinpathakdev@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pravin Pathak <pravin.pathak.dev@gmail.com>

Add dynamic flow migration to automatically rebalance flows across
worker ports when an atomic queue's destination port becomes congested.

When consecutive enqueue attempts to a worker's private atomic ring fail
and exceed SLB_MIGRATION_LOAD_THRESHOLD, migration is initiated. The
PMD inspects the overloaded ring and selects the lightest active flow
not currently in migration cooldown.

To preserve strict per-flow event ordering, migration completes only
after all previously scheduled events for the source port have been
returned (q_enqueued == q_returned). The flow affinity is then remapped
to the least-loaded worker port, and any matching events retained in the
hold buffer are reassigned.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 drivers/event/slb/slb_evdev.c |  16 ++-
 drivers/event/slb/slb_evdev.h |  20 ++-
 drivers/event/slb/slb_event.c | 252 ++++++++++++++++++++++++++++++++--
 3 files changed, 273 insertions(+), 15 deletions(-)

diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
index be0b3630f6..1916b7faa4 100644
--- a/drivers/event/slb/slb_evdev.c
+++ b/drivers/event/slb/slb_evdev.c
@@ -74,8 +74,13 @@ slb_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 		.total_dequeues = 0,
 		.empty_dequeues = 0,
 		.pending_releases = 0,
+		.is_loaded = false,
 		.single_linked_q = NULL,
 		.single_linked_ring = NULL,
+		.flow_migrations = 0,
+		.migrations_in = 0,
+		.migrations_out = 0,
+		.last_migrated_time = 0,
 	};
 
 	port->remap_input_q = false;
@@ -208,8 +213,12 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 		queue->atomic_state->next_port_rr = 0;
 		rte_spinlock_init(&queue->atomic_state->refill_lock);
 		queue->atomic_state->hold_count = 0;
+		queue->atomic_state->migration.in_progress = false;
+		queue->atomic_state->migrations_count = 0;
 		memset(queue->atomic_state->port_stats, 0,
 		       sizeof(queue->atomic_state->port_stats));
+		memset(queue->atomic_state->flow_last_migrated, 0,
+		       sizeof(queue->atomic_state->flow_last_migrated));
 	} else {
 		queue->atomic_state = NULL;
 	}
@@ -547,12 +556,16 @@ slb_stop(struct rte_eventdev *dev)
 		struct slb_queue *q = &slb->queues[qid];
 
 		if (q->schedule_type == RTE_SCHED_TYPE_ATOMIC && q->atomic_state != NULL) {
-			for (int f = 0; f < SLB_ATOMIC_FLOWS; f++)
+			for (int f = 0; f < SLB_ATOMIC_FLOWS; f++) {
 				rte_atomic_store_explicit(
 					&q->atomic_state->flow_map.flows[f].port_id,
 					-1, rte_memory_order_relaxed);
+				q->atomic_state->flow_last_migrated[f] = 0;
+			}
+			q->atomic_state->migration.in_progress = false;
 
 			for (uint16_t pid = 0; pid < slb->num_ports; pid++) {
+				q->atomic_state->port_stats[pid].load_counter = 0;
 				if (q->per_port_rings[pid] != NULL)
 					slb_drain_ring(dev_id,
 						       q->per_port_rings[pid],
@@ -568,6 +581,7 @@ slb_stop(struct rte_eventdev *dev)
 		struct slb_port *port = &slb->ports[i];
 		port->inflight_credits = 0;
 		port->credits_drained = false;
+		port->is_loaded = false;
 		for (int p = 0; p < SLB_MAX_PRIORITIES; p++)
 			port->next_q[p] = 0;
 	}
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
index 7a70d5c94c..b1a6de8606 100644
--- a/drivers/event/slb/slb_evdev.h
+++ b/drivers/event/slb/slb_evdev.h
@@ -87,6 +87,8 @@ struct slb_reorder_entry {
 #define SLB_ATOMIC_FLOWS 2048
 #define SLB_ATOMIC_FLOWS_MASK (SLB_ATOMIC_FLOWS - 1)
 #define SLB_HOLD_BUFFER_SIZE (SLB_MAX_PORT_DEQUEUE_DEPTH * 64)
+#define SLB_MIGRATION_LOAD_THRESHOLD 16
+#define SLB_MIGRATION_COOLDOWN_MS 500
 
 /* Per-flow entry for atomic scheduling affinity */
 struct slb_flow {
@@ -100,17 +102,28 @@ struct slb_flow_map {
 
 /* Per-port counters for an atomic queue */
 struct __rte_cache_aligned slb_atomic_port_stats {
+	uint32_t load_counter; /* Incremented when full, decremented when space available */
 	uint32_t flow_count;   /* Number of active flows mapped to this port */
 	uint64_t q_enqueued;   /* Events scheduled into this port's atomic port-Q */
 	uint64_t q_returned;   /* Events returned (FORWARD/RELEASE) by this port */
 };
 
+/* Active migration state for an atomic queue */
+struct slb_migration_state {
+	bool in_progress;
+	uint8_t port_id;       /* Source port being drained */
+	uint32_t flow_idx;     /* Flow hash index being migrated */
+};
+
 /* Dynamically allocated state for atomic queues */
 struct slb_atomic_state {
 	struct slb_flow_map flow_map;
 	uint32_t next_port_rr;
 	rte_spinlock_t refill_lock;
 	uint16_t hold_count;
+	struct slb_migration_state migration;
+	uint64_t migrations_count;
+	uint64_t flow_last_migrated[SLB_ATOMIC_FLOWS];
 	alignas(RTE_CACHE_LINE_SIZE)
 	struct slb_atomic_port_stats port_stats[SLB_MAX_PORTS];
 	uint8_t hold_ports[SLB_HOLD_BUFFER_SIZE];
@@ -132,7 +145,8 @@ struct __rte_cache_aligned slb_port {
 	bool implicit_release;
 	bool credits_drained;
 	bool remap_input_q;
-	uint8_t pad_port[4];
+	bool is_loaded; /* Port marked loaded for atomic flow migration */
+	uint8_t pad_port[3];
 	struct rte_event_ring *single_linked_ring;
 	struct slb_evdev *slb;
 
@@ -149,6 +163,10 @@ struct __rte_cache_aligned slb_port {
 	uint16_t dequeue_depth;
 	uint16_t enqueue_depth;
 	struct slb_queue *single_linked_q;
+	uint64_t flow_migrations;
+	uint64_t migrations_in;
+	uint64_t migrations_out;
+	uint64_t last_migrated_time;
 	uint64_t enqueue_calls;
 	uint64_t new_enqueued;
 	uint64_t forward_enqueued;
diff --git a/drivers/event/slb/slb_event.c b/drivers/event/slb/slb_event.c
index 22f40d72d4..3a0f7f6fde 100644
--- a/drivers/event/slb/slb_event.c
+++ b/drivers/event/slb/slb_event.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdbool.h>
+#include <limits.h>
 #include <rte_bitops.h>
 #include <rte_cycles.h>
 #include <rte_ring_elem.h>
@@ -163,12 +164,204 @@ slb_flow_hash(uint32_t flow_id)
 	return (flow_id * 2654435761U) & SLB_ATOMIC_FLOWS_MASK;
 }
 
+static int32_t
+slb_find_lightest_flow_on_port(struct slb_queue *queue, uint8_t port_id,
+			       uint64_t now, uint64_t cooldown_cycles)
+{
+	struct rte_event_ring *ering = queue->per_port_rings[port_id];
+	struct slb_atomic_state *astate = queue->atomic_state;
+	struct rte_ring *r;
+	uint32_t cons;
+	uint32_t prod;
+	uint32_t count;
+	uint16_t counts[SLB_ATOMIC_FLOWS];
+	int32_t best_flow_idx = -1;
+	uint32_t min_events = UINT32_MAX;
+
+	if (unlikely(ering == NULL || astate == NULL))
+		return -1;
+
+	if (astate->port_stats[port_id].flow_count <= 1)
+		return -1;
+
+	r = &ering->r;
+	cons = rte_atomic_load_explicit(&r->cons.tail, rte_memory_order_relaxed);
+	prod = rte_atomic_load_explicit(&r->prod.tail, rte_memory_order_relaxed);
+	count = prod - cons;
+
+	memset(counts, 0, sizeof(counts));
+	if (count > 0) {
+		struct rte_event *ring_events = (struct rte_event *)(r + 1);
+
+		for (uint32_t i = 0; i < count; i++) {
+			uint32_t slot = (cons + i) & r->mask;
+			uint32_t f_idx = slb_flow_hash(ring_events[slot].flow_id);
+
+			counts[f_idx]++;
+		}
+	}
+
+	for (uint32_t f = 0; f < SLB_ATOMIC_FLOWS; f++) {
+		if (rte_atomic_load_explicit(&astate->flow_map.flows[f].port_id,
+					     rte_memory_order_relaxed) == (int32_t)port_id) {
+			if (astate->flow_last_migrated[f] != 0 &&
+			    (now - astate->flow_last_migrated[f]) < cooldown_cycles)
+				continue;
+
+			if (counts[f] < min_events) {
+				min_events = counts[f];
+				best_flow_idx = (int32_t)f;
+			}
+		}
+	}
+
+	return best_flow_idx;
+}
+
+static void
+slb_check_and_trigger_migration(struct slb_evdev *slb, struct slb_queue *queue,
+				struct slb_atomic_state *astate, uint8_t full_port_id)
+{
+	struct slb_atomic_port_stats *pstats = &astate->port_stats[full_port_id];
+	uint64_t now;
+	uint64_t hz;
+	uint64_t cooldown_cycles;
+	int32_t flow_to_migrate;
+
+	pstats->load_counter++;
+	if (pstats->load_counter < SLB_MIGRATION_LOAD_THRESHOLD)
+		return;
+
+	if (astate->migration.in_progress)
+		return;
+
+	if (slb->ports[full_port_id].is_loaded)
+		return;
+
+	if (pstats->flow_count <= 1)
+		return;
+
+	now = rte_get_timer_cycles();
+	hz = rte_get_timer_hz();
+	cooldown_cycles = (hz * SLB_MIGRATION_COOLDOWN_MS) / 1000;
+
+	if (slb->ports[full_port_id].last_migrated_time != 0 &&
+	    (now - slb->ports[full_port_id].last_migrated_time) < cooldown_cycles)
+		return;
+
+	flow_to_migrate = slb_find_lightest_flow_on_port(
+		queue, full_port_id, now, cooldown_cycles);
+	if (flow_to_migrate < 0)
+		return;
+
+	pstats->load_counter = 0;
+	slb->ports[full_port_id].is_loaded = true;
+	astate->migration.in_progress = true;
+	astate->migration.port_id = full_port_id;
+	astate->migration.flow_idx = (uint32_t)flow_to_migrate;
+}
+
+static inline int
+slb_find_migration_target_port(struct slb_evdev *slb, struct slb_queue *queue,
+			       struct slb_atomic_state *astate, uint8_t mig_port,
+			       uint64_t now, uint64_t cooldown_cycles)
+{
+	uint64_t temp_mask = queue->serving_ports_mask;
+	int target_port = -1;
+	int min_flows = INT_MAX;
+
+	while (temp_mask != 0) {
+		uint8_t cand_port = rte_ctz64(temp_mask);
+		struct slb_port *cp = &slb->ports[cand_port];
+
+		temp_mask &= ~(1ULL << cand_port);
+		if (cand_port == mig_port || cp->is_loaded)
+			continue;
+
+		if (cp->last_migrated_time == 0 ||
+		    (now - cp->last_migrated_time) >= cooldown_cycles) {
+			if ((int)astate->port_stats[cand_port].flow_count < min_flows) {
+				min_flows = (int)astate->port_stats[cand_port].flow_count;
+				target_port = cand_port;
+			}
+		} else if (target_port == -1) {
+			target_port = cand_port;
+		}
+	}
+	return target_port;
+}
+
+static inline void
+slb_complete_flow_migration(struct slb_evdev *slb, struct slb_atomic_state *astate,
+			    uint8_t mig_port, int target_port, uint64_t now)
+{
+	uint32_t f_idx = astate->migration.flow_idx;
+
+	rte_atomic_store_explicit(&astate->flow_map.flows[f_idx].port_id,
+				  target_port, rte_memory_order_release);
+
+	for (uint16_t h = 0; h < astate->hold_count; h++) {
+		if (astate->hold_ports[h] == mig_port &&
+		    slb_flow_hash(astate->hold_buffer[h].flow_id) == f_idx) {
+			astate->hold_ports[h] = (uint8_t)target_port;
+		}
+	}
+
+	astate->flow_last_migrated[f_idx] = now;
+	slb->ports[mig_port].last_migrated_time = now;
+	slb->ports[target_port].last_migrated_time = now;
+
+	if (astate->port_stats[mig_port].flow_count > 0)
+		astate->port_stats[mig_port].flow_count--;
+	astate->port_stats[target_port].flow_count++;
+	astate->migrations_count++;
+
+	slb->ports[mig_port].flow_migrations++;
+	slb->ports[mig_port].migrations_out++;
+	slb->ports[target_port].migrations_in++;
+
+	astate->port_stats[mig_port].load_counter = 0;
+	slb->ports[mig_port].is_loaded = false;
+	astate->migration.in_progress = false;
+}
+
+static inline uint8_t
+slb_assign_unmapped_flow_port(struct slb_evdev *slb, struct slb_atomic_state *astate,
+			      uint64_t serving_mask, uint16_t num_serving_ports)
+{
+	uint32_t rr_counter = astate->next_port_rr++;
+	int port_offset = rr_counter % num_serving_ports;
+	uint64_t temp_mask = serving_mask;
+	uint8_t assigned_port = 0;
+
+	for (int j = 0; j <= port_offset; j++) {
+		assigned_port = rte_ctz64(temp_mask);
+		temp_mask &= (temp_mask - 1);
+	}
+
+	if (slb->ports[assigned_port].is_loaded) {
+		uint64_t cand_mask = serving_mask;
+
+		while (cand_mask != 0) {
+			uint8_t cp = rte_ctz64(cand_mask);
+
+			cand_mask &= (cand_mask - 1);
+			if (!slb->ports[cp].is_loaded) {
+				assigned_port = cp;
+				break;
+			}
+		}
+	}
+	return assigned_port;
+}
+
 /* If port queue is empty for an atomic queue, pull events from main atomic queue to fill
  * up port queues.
  */
 static void
-slb_atomic_refill(struct slb_port *port __rte_unused, struct slb_queue *queue)
+slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 {
+	struct slb_evdev *slb = port->slb;
 	struct rte_event master_events[SLB_MAX_PORT_DEQUEUE_DEPTH];
 	uint16_t n_deq;
 	uint16_t i;
@@ -183,6 +376,35 @@ slb_atomic_refill(struct slb_port *port __rte_unused, struct slb_queue *queue)
 	if (!rte_spinlock_trylock(&astate->refill_lock))
 		return;
 
+	/* 0. Detect migration in progress before hold buffer processing */
+	if (astate->migration.in_progress) {
+		uint8_t mig_port = astate->migration.port_id;
+		uint64_t enq_cnt = astate->port_stats[mig_port].q_enqueued;
+		uint64_t ret_cnt = astate->port_stats[mig_port].q_returned;
+
+		if (enq_cnt == ret_cnt) {
+			uint64_t now = rte_get_timer_cycles();
+			uint64_t hz = rte_get_timer_hz();
+			uint64_t cooldown_cycles =
+				(hz * SLB_MIGRATION_COOLDOWN_MS) / 1000;
+			int target_port = slb_find_migration_target_port(
+				slb, queue, astate, mig_port, now,
+				cooldown_cycles);
+
+			if (target_port != -1)
+				slb_complete_flow_migration(
+					slb, astate, mig_port, target_port, now);
+			else {
+				astate->port_stats[mig_port].load_counter = 0;
+				slb->ports[mig_port].is_loaded = false;
+				astate->migration.in_progress = false;
+			}
+		}
+	}
+
+	if (astate->migration.in_progress)
+		full_ports_mask |= (1ULL << astate->migration.port_id);
+
 	/* 1. Process Hold Buffer first */
 	if (astate->hold_count > 0) {
 		uint16_t retained = 0;
@@ -216,6 +438,10 @@ slb_atomic_refill(struct slb_port *port __rte_unused, struct slb_queue *queue)
 				&astate->hold_buffer[i], burst_len, NULL);
 			astate->port_stats[dest_port_id].q_enqueued += enqueued;
 
+			if (enqueued > 0 &&
+			    astate->port_stats[dest_port_id].load_counter > 0)
+				astate->port_stats[dest_port_id].load_counter--;
+
 			if (enqueued < burst_len) {
 				uint16_t rem = burst_len - enqueued;
 				uint16_t start_idx = i + enqueued;
@@ -230,6 +456,9 @@ slb_atomic_refill(struct slb_port *port __rte_unused, struct slb_queue *queue)
 						rem);
 				}
 				retained += rem;
+				if (enqueued == 0)
+					slb_check_and_trigger_migration(
+						slb, queue, astate, dest_port_id);
 			}
 
 			i += burst_len;
@@ -274,17 +503,8 @@ slb_atomic_refill(struct slb_port *port __rte_unused, struct slb_queue *queue)
 					rte_memory_order_acquire);
 
 			if (unlikely(dest_port_id == -1)) {
-				uint32_t rr_counter = astate->next_port_rr++;
-				int port_offset = rr_counter % num_serving_ports;
-				uint64_t temp_mask = serving_mask;
-				uint8_t assigned_port = 0;
-
-				for (int j = 0; j <= port_offset; j++) {
-					assigned_port = rte_ctz64(temp_mask);
-					temp_mask &= (temp_mask - 1);
-				}
-
-				dest_port_id = assigned_port;
+				dest_port_id = slb_assign_unmapped_flow_port(
+					slb, astate, serving_mask, num_serving_ports);
 				rte_atomic_store_explicit(
 					&astate->flow_map.flows[flow_idx].port_id,
 					dest_port_id, rte_memory_order_release);
@@ -346,7 +566,10 @@ slb_atomic_refill(struct slb_port *port __rte_unused, struct slb_queue *queue)
 				queue->per_port_rings[p], &sorted_events[p_start], p_count, NULL);
 			astate->port_stats[p].q_enqueued += enqueued;
 
-			if (enqueued < p_count) {
+			if (enqueued == p_count) {
+				if (unlikely(astate->port_stats[p].load_counter > 0))
+					astate->port_stats[p].load_counter--;
+			} else {
 				uint16_t rem = p_count - enqueued;
 				uint16_t space = SLB_HOLD_BUFFER_SIZE - astate->hold_count;
 				uint16_t to_copy = RTE_MIN(rem, space);
@@ -359,6 +582,9 @@ slb_atomic_refill(struct slb_port *port __rte_unused, struct slb_queue *queue)
 					memset(&astate->hold_ports[astate->hold_count], p, to_copy);
 					astate->hold_count += to_copy;
 				}
+				if (enqueued == 0)
+					slb_check_and_trigger_migration(
+						slb, queue, astate, p);
 			}
 		}
 	}
-- 
2.53.0

