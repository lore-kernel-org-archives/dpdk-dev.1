Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACA606A32C
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTNtQvzc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03EE542E15;
	Sat,  7 Nov 2026 02:30:31 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTPS id BC27142E69
 for <dev@dpdk.org>; Sat,  7 Nov 2026 02:30:29 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-53cd0c8614eso8967081cf.0
 for <dev@dpdk.org>; Fri, 06 Nov 2026 17:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794015029; x=1794619829; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/CRbWqgHprRofdjERIm7K9Cxoz1QY0XUkJHqcDoOoTU=;
 b=hTNtQvzccF7ypIFL8CCcRunXEEkrJ0NLbWCfhSUhgH4hnwTc7lMxDTpjm/GBz5JwCo
 Oq6jDY2vZV1jaYd5dQgrGNZc36CQjy2zvQRsLwubS14Ae2wD6v9iRArtiiA5EKFBTQMA
 US9oyajwBOFfeAinhoOCuxf6tRJ20EEeFIdMPygEL8zB7Oj6rrVQl3j1QEKXDUkzivBA
 4rzKzSoQYNgTqf8pRxUIT4lokR7ASKNZJmqHcfF3z82Jz6a4noVGSfazpR6j3bBVhPEW
 VU71LDKPo91Wu/LCsOIkkx/waJ7RqKWsRU0HF3r4ZntwGv3+GrtXaFX7W6Yh+el/MzPP
 DsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794015029; x=1794619829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/CRbWqgHprRofdjERIm7K9Cxoz1QY0XUkJHqcDoOoTU=;
 b=qh8YZQniVBN9iSCIp+IhPzg2XgTqTeJoBPioBO/QGlORNTu6q+q1NkZ1cgXaFuFVQ1
 C4lPboHy4qBUSCo4zW07umk28lDLbU5XETCUxZT921deGREzt76ukRHSDIyGUAX8Xmj/
 8KOnpSkjD6dhR/frSlRD5oi8pK91+WpOzd7bHSVNTYqujpn3v1yABRCUtPQIRE8XKu77
 wv2HmJCVSArGQCCL6NLQ6IuHi8ugKufUWrFq4D3OQ5AyZikxL8hbL5flCA6h7TR+fD1i
 to21fm07ge5OjYYymMfY7WLVtw1VOIltgMiitI2ot1NqxyHLOpNHsj2OINJwmY2oq2+w
 rYJA==
X-Gm-Message-State: APuU4Z83mW13LHjSF482HgDhljexTUnP3fTxG0Yq2qf1FmGXzM4NdrKx
 Wq4hKxU5yVJxW4i1wpOTXku3tF6r/6TT2q/4xCh+m+XowztyxVkkMCrm+REmo72R02M=
X-Gm-Gg: AYBFou2dCwPJnpHD4fvL/DxkJAjiHOH4dllQfSGN1EacT+vRc5nwoX/93933Cx4mbxn
 u9taXiEKSbKyvVbPi/VpL/p918jDV1htjscGC5gexZxewdU+WJQVl8kbKaPbtyjVrE7tnnwsvC/
 0Qp47rXQwxKP1t++f7WWFAe3/gueZLeNL3hD2W5xkYlVsVKuCdc0vi0bB5lKrdwYZP/dxQ//05X
 +FHGpPK+cwtk2yq5WDdO04QS0a/RuHSH1v7+3pPC/2br4mVL+wxh36XeONWf90XhSCiqixNeGrC
 zxoXz9ARik9KMzB1uQI0LKCd63d9YqJ+mwWW77UhH0pP/HLdr6HVJ1M01RFa5t3CTDDGINPlYLV
 s0Rh1YgkcbdYcVDz7/lILMI/ldr435a7SY9iz92ej5Xwv7GQzITA9lrr3W26qYsi3kxt60Skbs+
 +HT6Q4oRgSVjXtVDTQ8cOIIeWIqcShEq6WCgw29gpMnQRXPQ2yNmV8bvMpwkFdcI4gegBwPGbgS
 6nBddgFU/d1C5Kq/IMgL5MPQJLVQ/bFHjVSyw7gj2KftrIf0bIHYaEPNaVhHr/4A8DL5ZW8Il7B
 X+HhVo+1tnp3jnp0vnYTKH8gOpkmnZmqNVn6BYdy6eNMgEp9StNGlm7pIdUPt1tU4i34zZCIkoZ
 5BJZxaxa16kfYt/pZ
X-Received: by 2002:a05:622a:4c0a:b0:532:9b14:96c5 with SMTP id
 d75a77b69052e-54e15762f20mr64436951cf.60.1794015027820; 
 Fri, 06 Nov 2026 17:30:27 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c2ac1.dyn.optonline.net. [148.76.42.193])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e257862bfsm33746111cf.6.2026.11.06.17.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:30:27 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v1 7/8] event/slb: update resets and credit defaults
Date: Fri,  6 Nov 2026 20:30:09 -0500
Message-ID: <20261107013011.2443138-8-pravinpathakdev@gmail.com>
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

- Force RTE_SCHED_TYPE_ATOMIC on events dequeued from single-link queues
  and skip atomic/ordered state allocations for single-link queues.
- Remove RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK advertisement from driver
  info, feature matrix, and release notes.
- Reset atomic queue flow-to-port mappings, hold buffers, migration
  state, per-port stats, ordered reorder buffers, and port history when
  the device is stopped in slb_stop().
- Default port new_event_threshold in slb_port_def_conf() to 1/4 of
  SLB_IN_RING_SIZE (clamped to nb_events_limit when configured) and
  lower SLB_MIN_CREDIT_LOAN from 512 to 256 so more ports can borrow
  credits concurrently.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 doc/guides/eventdevs/features/slb.ini |  1 -
 doc/guides/eventdevs/slb.rst          | 31 ++++------
 drivers/event/slb/slb_evdev.c         | 81 +++++++++++++++++++++------
 drivers/event/slb/slb_evdev.h         |  5 +-
 drivers/event/slb/slb_event.c         | 23 ++++++--
 drivers/event/slb/slb_selftest.c      | 12 ++++
 6 files changed, 110 insertions(+), 43 deletions(-)

diff --git a/doc/guides/eventdevs/features/slb.ini b/doc/guides/eventdevs/features/slb.ini
index 0364840bc9..33036301a8 100644
--- a/doc/guides/eventdevs/features/slb.ini
+++ b/doc/guides/eventdevs/features/slb.ini
@@ -11,7 +11,6 @@ distributed_sched          = Y
 burst_mode                 = Y
 implicit_release_disable   = Y
 nonseq_mode                = Y
-runtime_port_link          = Y
 multiple_queue_port        = Y
 carry_flow_id              = Y
 maintenance_free           = Y
diff --git a/doc/guides/eventdevs/slb.rst b/doc/guides/eventdevs/slb.rst
index d319b94920..b109a1e2ca 100644
--- a/doc/guides/eventdevs/slb.rst
+++ b/doc/guides/eventdevs/slb.rst
@@ -4,9 +4,10 @@
 Software Load Balancer (SLB) Eventdev Driver
 ============================================
 
-The Software Load Balancer (SLB) event device is a poll-mode eventdev driver
-which distributes events among multiple worker ports and cores without requiring
-dedicated scheduling service cores or hardware coprocessors.
+The Software Load Balancer (SLB) is a software event device and a poll-mode Eventdev driver.
+It uses a distributed scheduler, allowing it to scale well. SLB does not require dedicated
+cores for scheduling. It supports Atomic, Parallel, and Ordered queues with dynamic atomic
+flow load balancing. SLB also requires no internal core communication and is maintenance-free.
 
 Features
 --------
@@ -19,25 +20,17 @@ Queues
 * **Atomic**: Flow-pinned scheduling guaranteeing strict per-flow packet ordering.
   Includes dynamic load tracking and automatic flow migration to rebalance overloaded
   ports while preserving in-flight sequence integrity.
-* **Ordered**: Ticket-based sequence tracking and reorder buffer providing end-to-end
-  packet order restoration across parallel processing workers.
-* **Single-Link**: Dedicated direct queue mapping from a producer port to a single
-  consumer port using optimized single-consumer rings.
+* **Ordered**: Sequence number-based tracking and reordering.
+* **Single-Link**: Implemented using optimized multi-producer single-consumer rings.
 
 Ports & Scheduling Capabilities
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-* **Distributed Scheduling**: No dedicated service core required; scheduling work is
-  performed inline during enqueue and dequeue operations.
-* **Prefix Sum Burst Enqueue**: Interleaved multi-queue bursts are grouped and scattered
-  via prefix-sum offsets, dispatching single batched bursts to queue rings to eliminate
-  atomic Compare-And-Swap contention on multi-producer rings.
+* **Distributed Scheduling**: No dedicated service core required.
 * **Dynamic Flow Migration**: Atomic queues monitor port dequeue loads and migrate
-  eligible victim flows from overloaded ports to underloaded ports with cooling cycles.
+  Eligible flows from overloaded ports to underloaded ports with cooling cycles.
 * **Credit Pool Management**: Centralized event credit pool with per-port credit caching
   to enforce device-wide in-flight event limits (``max_num_events``).
-* **Runtime Port Linking**: Supports dynamic linking and unlinking of ports and queues
-  both when stopped and at runtime.
 * **Maintenance Free**: Operates without requiring periodic maintenance calls
   (``RTE_EVENT_DEV_CAP_MAINTENANCE_FREE``).
 
@@ -62,7 +55,7 @@ application code or from the EAL command line:
 Limitations
 -----------
 
-* **Flow Hash Table Size**: Atomic queues use an internal flow mapping table
-  dimensioned to 2048 concurrent active flows per queue (``SLB_ATOMIC_FLOWS``).
-* **Maximum Ports and Queues**: Configured for up to 64 ports (``SLB_MAX_PORTS``)
-  and 64 queues (``SLB_MAX_QUEUES``).
+* **Maximum Ports and Queues**: Supports up to 64 ports and 64 queues.
+* **Priorities and linking**: Supports two levels of service priority to link up to
+  eight queues per port at each priority. SLB currently does not support event priority.
+* **Queues Types**: Does not support all-type queues.
diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
index c86b934b03..16bfefaa68 100644
--- a/drivers/event/slb/slb_evdev.c
+++ b/drivers/event/slb/slb_evdev.c
@@ -26,6 +26,7 @@ slb_port_reset_history(struct slb_port *port)
 {
 	port->history[0].active = false;
 	port->history[0].next_free = SLB_PORT_HISTORY_FREE_END;
+	/* 1 -> 2 -> 3 ..... 255 -> END */
 	for (int i = 1; i < SLB_PORT_HISTORY_SIZE; i++) {
 		port->history[i].active = false;
 		port->history[i].next_free = i + 1;
@@ -36,7 +37,7 @@ slb_port_reset_history(struct slb_port *port)
 	port->history_avail = SLB_PORT_HISTORY_MAX_TOKENS;
 }
 
-/* Setup Eventdev port. Reset all mapped queues */
+/* Setup Eventdev port. Reset all mapped queues and history tracking */
 static int
 slb_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	       const struct rte_event_port_conf *conf)
@@ -103,12 +104,18 @@ slb_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 
 /* Default Eventdev port configuration for SLB */
 static void
-slb_port_def_conf(struct rte_eventdev *dev __rte_unused,
+slb_port_def_conf(struct rte_eventdev *dev,
 		  uint8_t port_id __rte_unused,
 		  struct rte_event_port_conf *port_conf)
 {
+	int32_t threshold = SLB_IN_RING_SIZE / 4;
+
+	if (dev->data->dev_conf.nb_events_limit > 0 &&
+	    threshold > dev->data->dev_conf.nb_events_limit)
+		threshold = dev->data->dev_conf.nb_events_limit;
+
 	*port_conf = (struct rte_event_port_conf) {
-		.new_event_threshold = 1024,
+		.new_event_threshold = threshold,
 		.dequeue_depth = SLB_MAX_PORT_DEQUEUE_DEPTH / 4,
 		.enqueue_depth = SLB_MAX_PORT_ENQUEUE_DEPTH / 4
 	};
@@ -146,7 +153,9 @@ slb_queue_release(struct rte_eventdev *dev, uint8_t queue_id)
 	}
 }
 
-/* Setup Eventdev queue. Eventdev queues are implemented as DPDK rings */
+/* Setup Eventdev queue. Eventdev queues are implemented as DPDK rings.
+ *  SLB Supports single-link, atomic, parallel, and ordered queues.
+ */
 static int
 slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 		const struct rte_event_queue_conf *conf)
@@ -190,12 +199,15 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 		return -ENOMEM;
 
 	queue->q_ring = ring;
-	queue->schedule_type = conf->schedule_type;
+	/* Single-link queue uses atomic schedule type */
+	queue->schedule_type = queue->is_single_link ?
+			       RTE_SCHED_TYPE_ATOMIC : conf->schedule_type;
 	queue->serving_ports_mask = 0;
 	queue->num_serving_ports = 0;
 
-	/* Atomic queue allocation */
-	if (conf->schedule_type == RTE_SCHED_TYPE_ATOMIC) {
+	/* Atomic queue state allocation */
+	if (!queue->is_single_link &&
+	    conf->schedule_type == RTE_SCHED_TYPE_ATOMIC) {
 		for (int i = 0; i < SLB_MAX_PORTS; i++)
 			queue->per_port_rings[i] = NULL;
 
@@ -224,7 +236,8 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 	}
 
 	/* Ordered queue reorder buffer allocation */
-	if (conf->schedule_type == RTE_SCHED_TYPE_ORDERED) {
+	if (!queue->is_single_link &&
+	    conf->schedule_type == RTE_SCHED_TYPE_ORDERED) {
 		queue->reorder_buffer = rte_zmalloc_socket("slb_reorder_buf",
 			sizeof(struct slb_reorder_entry) * ring->r.size,
 			RTE_CACHE_LINE_SIZE, dev->data->socket_id);
@@ -293,7 +306,8 @@ slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
 		port->single_linked_q = queue;
 		port->single_linked_ring = queue->q_ring;
 	} else {
-		if (queue->schedule_type == RTE_SCHED_TYPE_ATOMIC &&
+		if (!queue->is_single_link &&
+		    queue->schedule_type == RTE_SCHED_TYPE_ATOMIC &&
 		    queue->per_port_rings[port->id] == NULL) {
 			char ring_name[RTE_RING_NAMESIZE];
 			struct rte_event_ring *ring;
@@ -332,7 +346,8 @@ slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
 		if (!found) {
 			uint16_t slot = port->num_q[prio];
 			struct rte_event_ring *dq_ring =
-				(queue->schedule_type == RTE_SCHED_TYPE_ATOMIC) ?
+				(!queue->is_single_link &&
+				 queue->schedule_type == RTE_SCHED_TYPE_ATOMIC) ?
 				queue->per_port_rings[port->id] : queue->q_ring;
 
 			if (slot >= SLB_PORT_MAX_Q_MAP_PER_PRIO) {
@@ -344,6 +359,8 @@ slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
 			port->q_entries[prio][slot].queue_id = qid;
 			port->q_entries[prio][slot].schedule_type =
 				queue->schedule_type;
+			port->q_entries[prio][slot].is_single_link =
+				queue->is_single_link;
 			port->num_q[prio]++;
 		}
 
@@ -464,7 +481,6 @@ slb_info_get(struct rte_eventdev *dev __rte_unused,
 		RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE |
 		RTE_EVENT_DEV_CAP_NONSEQ_MODE |
 		RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT |
-		RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK |
 		RTE_EVENT_DEV_CAP_CARRY_FLOW_ID |
 		RTE_EVENT_DEV_CAP_MAINTENANCE_FREE |
 		RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ
@@ -555,22 +571,52 @@ slb_stop(struct rte_eventdev *dev)
 	for (uint8_t qid = 0; qid < slb->num_queues; qid++) {
 		struct slb_queue *q = &slb->queues[qid];
 
-		if (q->schedule_type == RTE_SCHED_TYPE_ATOMIC && q->atomic_state != NULL) {
+		if (q->schedule_type == RTE_SCHED_TYPE_ATOMIC &&
+		    q->atomic_state != NULL) {
+			struct slb_atomic_state *astate = q->atomic_state;
+
+			for (uint16_t h = 0; h < astate->hold_count; h++) {
+				if (flush != NULL)
+					flush(dev_id, astate->hold_buffer[h],
+					      flush_arg);
+			}
+			astate->hold_count = 0;
+			astate->next_port_rr = 0;
+			astate->migration.in_progress = false;
+
 			for (int f = 0; f < SLB_ATOMIC_FLOWS; f++) {
 				rte_atomic_store_explicit(
-					&q->atomic_state->flow_map.flows[f].port_id,
+					&astate->flow_map.flows[f].port_id,
 					-1, rte_memory_order_relaxed);
-				q->atomic_state->flow_last_migrated[f] = 0;
+				astate->flow_last_migrated[f] = 0;
 			}
-			q->atomic_state->migration.in_progress = false;
+
+			memset(astate->port_stats, 0,
+			       sizeof(astate->port_stats));
 
 			for (uint16_t pid = 0; pid < slb->num_ports; pid++) {
-				q->atomic_state->port_stats[pid].load_counter = 0;
 				if (q->per_port_rings[pid] != NULL)
 					slb_drain_ring(dev_id,
 						       q->per_port_rings[pid],
 						       flush, flush_arg);
 			}
+		} else if (q->schedule_type == RTE_SCHED_TYPE_ORDERED &&
+			   q->reorder_buffer != NULL && q->q_ring != NULL) {
+			for (uint32_t s = 0; s < q->q_ring->r.size; s++) {
+				uint8_t st = rte_atomic_load_explicit(
+					&q->reorder_buffer[s].state,
+					rte_memory_order_relaxed);
+
+				if (st == SLB_REORDER_READY && flush != NULL)
+					flush(dev_id,
+					      q->reorder_buffer[s].event,
+					      flush_arg);
+				rte_atomic_store_explicit(
+					&q->reorder_buffer[s].state,
+					SLB_REORDER_EMPTY,
+					rte_memory_order_relaxed);
+			}
+			q->reorder_drain_idx = 0;
 		}
 
 		if (q->q_ring != NULL)
@@ -581,7 +627,10 @@ slb_stop(struct rte_eventdev *dev)
 		struct slb_port *port = &slb->ports[i];
 		port->inflight_credits = 0;
 		port->credits_drained = false;
+		port->pending_releases = 0;
 		port->is_loaded = false;
+		port->last_migrated_time = 0;
+		slb_port_reset_history(port);
 		for (int p = 0; p < SLB_MAX_PRIORITIES; p++)
 			port->next_q[p] = 0;
 	}
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
index f727a1b83c..bf262903cd 100644
--- a/drivers/event/slb/slb_evdev.h
+++ b/drivers/event/slb/slb_evdev.h
@@ -28,7 +28,7 @@
 #define SLB_MAX_FLOWS_MASK (SLB_MAX_FLOWS - 1)
 
 /* Avoid making small 'loans' from the central in-flight event credit pool */
-#define SLB_MIN_CREDIT_LOAN (512)
+#define SLB_MIN_CREDIT_LOAN (256)
 #define SLB_PORT_MAX_CREDITS (2 * SLB_MIN_CREDIT_LOAN)
 #define SLB_PORT_MIN_CREDITS (SLB_MIN_CREDIT_LOAN)
 
@@ -56,7 +56,8 @@ struct slb_port_q_entry {
 	struct slb_queue *queue;
 	uint8_t queue_id;
 	uint8_t schedule_type;
-	uint8_t pad[6];
+	bool is_single_link;
+	uint8_t pad[5];
 };
 
 #define SLB_PORT_HISTORY_SIZE 256
diff --git a/drivers/event/slb/slb_event.c b/drivers/event/slb/slb_event.c
index 3a0f7f6fde..c44deba905 100644
--- a/drivers/event/slb/slb_event.c
+++ b/drivers/event/slb/slb_event.c
@@ -976,8 +976,10 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 			return 0;
 		dequeued = rte_event_ring_dequeue_burst(port->single_linked_ring,
 							events, num, NULL);
-		for (uint16_t j = 0; j < dequeued; j++)
+		for (uint16_t j = 0; j < dequeued; j++) {
+			events[j].sched_type = RTE_SCHED_TYPE_ATOMIC;
 			events[j].impl_opaque = 0;
+		}
 		return dequeued;
 	}
 
@@ -1015,8 +1017,11 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 				continue;
 
 			uint8_t sched_type = qent->schedule_type;
-			bool is_ordered = (sched_type == RTE_SCHED_TYPE_ORDERED);
-			bool is_atomic = (sched_type == RTE_SCHED_TYPE_ATOMIC);
+			bool is_single_link = qent->is_single_link;
+			bool is_ordered = !is_single_link &&
+					  (sched_type == RTE_SCHED_TYPE_ORDERED);
+			bool is_atomic = !is_single_link &&
+					 (sched_type == RTE_SCHED_TYPE_ATOMIC);
 
 			if (is_ordered || is_atomic) {
 				if (unlikely(port->history_avail == 0))
@@ -1050,8 +1055,16 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 			} else {
 				dequeued = rte_event_ring_dequeue_burst(
 					ring_to_dq, events, num, NULL);
-				for (uint16_t j = 0; j < dequeued; j++)
-					events[j].impl_opaque = 0;
+				if (is_single_link) {
+					for (uint16_t j = 0; j < dequeued; j++) {
+						events[j].sched_type =
+							RTE_SCHED_TYPE_ATOMIC;
+						events[j].impl_opaque = 0;
+					}
+				} else {
+					for (uint16_t j = 0; j < dequeued; j++)
+						events[j].impl_opaque = 0;
+				}
 			}
 
 			if (dequeued > 0) {
diff --git a/drivers/event/slb/slb_selftest.c b/drivers/event/slb/slb_selftest.c
index 4a072b811b..776b6d6ab4 100644
--- a/drivers/event/slb/slb_selftest.c
+++ b/drivers/event/slb/slb_selftest.c
@@ -362,6 +362,12 @@ test_ordered_forward(void)
 					     cons_rx, rx[i].u64);
 				return -1;
 			}
+			if (rx[i].sched_type != RTE_SCHED_TYPE_ATOMIC) {
+				SLB_LOG_LINE(ERR,
+					     "Single-link dequeue sched_type expected %u, got %u",
+					     RTE_SCHED_TYPE_ATOMIC, rx[i].sched_type);
+				return -1;
+			}
 			cons_rx++;
 			rx[i].op = RTE_EVENT_OP_RELEASE;
 		}
@@ -416,6 +422,12 @@ test_single_link(void)
 	for (i = 0; i < 16; i++) {
 		if (rx[i].u64 != (uint64_t)(5000 + i))
 			return -1;
+		if (rx[i].sched_type != RTE_SCHED_TYPE_ATOMIC) {
+			SLB_LOG_LINE(ERR,
+				     "Single-link dequeue sched_type expected %u, got %u",
+				     RTE_SCHED_TYPE_ATOMIC, rx[i].sched_type);
+			return -1;
+		}
 		rx[i].op = RTE_EVENT_OP_RELEASE;
 	}
 	rte_event_enqueue_burst(g_dev_id, PORT_CONS, rx, 16);
-- 
2.53.0

