Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC02606A32C
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzWvG7gx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4386C42E4C;
	Sat,  7 Nov 2026 02:30:27 +0100 (CET)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 36B3D42E15
 for <dev@dpdk.org>; Sat,  7 Nov 2026 02:30:25 +0100 (CET)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-53653e30353so15998601cf.2
 for <dev@dpdk.org>; Fri, 06 Nov 2026 17:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794015024; x=1794619824; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xc1DabXBWCmRcrq/yx8umXekrfyJZWbliFP/ZChu16g=;
 b=zzWvG7gxMlFLAW5jwl88OjebKB1dkOgYeuiB9nQlFErUzLvwVWh3kmiAq71Z4gxNFu
 VKlfhsDguIHeSSBdkBECQgRYggwUFV0M34r3FvKRYj1M0OMMXFl4EI/9/c64BhdA1xc4
 jTmWA35DnioYhKUY0+aALjN7ziSmellIKzFv3AfDOp1tyUMJOjbhKCLcPi9TsoGdmGSv
 vrr4OPAMv6MYJ6VXcmRgTA9bpzn0l96CDkt3KOlOgNY0bZPrYgjDKZzvULQjMkPvD8tX
 12vMkACGearW1w6hyVbu0VGKhKlArNNhpJicZGeHQJVmkydRZj3udTvsoUwzsLShY37P
 R3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794015024; x=1794619824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xc1DabXBWCmRcrq/yx8umXekrfyJZWbliFP/ZChu16g=;
 b=hbxqH5vuP+hfGBAnWozWvE3NqpvFo7BzrHl6r0NHGPmys/7slFEGBzGVkXfCPqqdh8
 vTPteeaLgjGC4gpBrs3KBnzbr5EyuPZOTsF3e061mlXxz2pMViotm6cK13yyG5pnwdLJ
 FgaepWEgv1klog6+mZcxjdpHYqpeB1HT5SvY5za1+mHXGCNF9UpgqWfAFxbJ6IDkQd0W
 UTGMGwKq6zL0MToxTz9RK668llO5K1kfbYfHcUciOkPl1QnV9k1Z6xeqPSVSR0ecm8IG
 9xvAAQnsSb8qBz5rUkdrhERr255/AZ0m2X+RXuv+QqA3e6sOQ0nRJwgzK+A516t/I9fV
 zF+A==
X-Gm-Message-State: APuU4Z+lFWk3i8YLjIx9QTFboqcDpwBgeIOvsvo7jZs9WB+JK7zhCnIm
 Qy0RqtWZ6BQOhIyly5SLwv5GUoyrrY3tR4dUpZ5ixzVLwry9abftk2K/HK1Ff654gr0=
X-Gm-Gg: AYBFou33YbNYF+N2NiO5DuZsLQFa5B3OSf5Kebu0DzWnn06xe1/1XjuTNFVoc6B5bRN
 UfG/+cKkcKhBRlpiIcDeNOJ8E0l+JotoRTXXfHxfQ664PDTWAn/rl3c33f6QWBb+0niP1c6EtXi
 +8RzPx6U/mHsrV9SexbUqo1UJssw1YWd2fyyJ7u2G0vc8ccJ3s5caE+8IG8JJOzhZ5lvF8Gz1ar
 pZTbK+2BZ8+CL/gflxTpZ0F2QE+Oex3zIT1sz1T/e6AkWN6nzSjHY8LWmH2KYTfw+S908k6vwsL
 2SOCPBhuMMRgLryYe56ydszZioUab6prv/Ko80rvNCp+8Z6ywalLfkAljAfFDw8Jg+5ME9aUs4g
 pZu8L+byGkcWg1AcL4xsszRKzPWOyZyIvqNBilL6NvZPC0XGwb09KHifeeiWHD2P/W1osyyx+NW
 H96899Gd5zI7BE7ZtiYAQkjD24SNNTAzAg04E0/D6RYzMYhL8NrEi6Gtyrw3wck5GmKP3w0Q+M2
 LSDKoPYTnNVKiZIxYcFQsabqq9K5KD+OxeMg19DVoqLrf8HoZ154w/BXwKdmQK4rdF35k01Qch+
 AgyEKcVRp3CykbvVSyZVwzTpNrSihDilOaqK4x+TII0ekdlCXNwwwUSoOOjLlOHgMkNKkTQ+Dgg
 8rX1wg3bIFQsT1g1y1mwwlEERCXTntnQIvgy9jg==
X-Received: by 2002:a05:622a:428f:b0:537:d4b4:3617 with SMTP id
 d75a77b69052e-54e102eff8fmr71198941cf.6.1794015023877; 
 Fri, 06 Nov 2026 17:30:23 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c2ac1.dyn.optonline.net. [148.76.42.193])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e257862bfsm33746111cf.6.2026.11.06.17.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:30:23 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v1 4/8] event/slb: add dynamic flow migration for atomic queues
Date: Fri,  6 Nov 2026 20:30:06 -0500
Message-ID: <20261107013011.2443138-5-pravinpathakdev@gmail.com>
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

