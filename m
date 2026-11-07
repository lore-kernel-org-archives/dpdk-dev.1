Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE2606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0rRkjpWV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5396F42E76;
	Sat,  7 Nov 2026 02:30:33 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A1DB42E69
 for <dev@dpdk.org>; Sat,  7 Nov 2026 02:30:31 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-533861a59b8so13075901cf.1
 for <dev@dpdk.org>; Fri, 06 Nov 2026 17:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794015030; x=1794619830; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nrb7h/7bO1epI9BxUz7necnMcAv+WrY9ASFsHBUf/es=;
 b=0rRkjpWVV6XkOyVvJmND05QyY1ZP8oKLsei0LN+Ajlqxh59jpV24qyVOX8B7Kkk2Bi
 fhtHPjTqpeTamh1SpvXDvg8xlCNQzTyXF97G1JP1J8cM4eGObm7FTITHmLWUnQLqSUfZ
 s8AG1rFxUS8ZGwPQv9uY3p/axtyJJhm9jNkVY9ZHn6aUhJ2mQlEj7GIWESRBkYle8ktm
 UmTpM3Y92lJhoMUCWNsdQbhE4/C1uomp1OLdKYdUgvgk65yn2UxUK3ERIAccS0WjoS/m
 JJMQFzaOLYTZWavYlE+I699Oat7eKhi3TEwRkiJxNWU9gpV/YWeQ2Qsf3Q9litndvbC9
 kHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794015030; x=1794619830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nrb7h/7bO1epI9BxUz7necnMcAv+WrY9ASFsHBUf/es=;
 b=TUxu0q/2DWnTVSMBvVAr43nTNm7k7D+KcIIPFckaeYZqaAk/cKbTVlZOWSeQlq3pbd
 mWbNQQUiV+3hQQ7EVyQ/MdUFX5Ixlq00GBozldcyEBzuajbaZotaEdRqYwq5szCBo7eu
 ZCncnJY+sl3FNC+jLnuS1fL2APIeyZXHxQNZ5Vtfi5Q94+H+PwM6FGVr3LsQPlbBzHty
 zMEonpCu+EI9PbuvWo7L0zu9VhbTNBoqBwS8tlFsZvhsfuLvAll89lZ8PvrR+AUZCUSZ
 JpcGFagPWq7zkelPbv1hnbPi5uBOVGgZywAZhbwYChj+rYbuC5Pski3HzsmWJfUOBmI3
 UFpw==
X-Gm-Message-State: APuU4Z8wf5HXkrjsQeplqT/Jac2rGlFiTtjrXk9EGD6p/+NXLuULutOK
 lh8poY3eQCCX65y3AydJt4xzVYNUr6f2XUbsr4NnnJZAprsF14N1tfPBYuThwuJa0Ec=
X-Gm-Gg: AYBFou02wIX0kqA07taOjDCIAiktSKwvm6x6O5h4MHfAkjgLLreOQFsgm1cNR3BTFvj
 rNwm2nN4o4Z7f2gNxOUdk77c/eT/dfwD7tih5HefkM5nq2Lklcl6P8lqH0f4giBNA6QRqx0Nkr9
 OVKI2UzT43o4cidFbxc3vOvILfvDUUdscTU/4DXHZCtUlXUBBKeDaM0RBbieMGSeFDUPP9+rms4
 kwMcsx/Bmd+KePSLrTu4kI8yM+0N9CcLxSyBF03wLeYadaZhtT8zEiNlUHa1XyqLrcdWQmF+k0M
 Dmnp9ZTr5hAf2I5LP38ZWNKzbEIDiYlCFJUwTxdCKUU463mlrerQM2QqWARX3rNSdLuWIPNvejR
 9Kwds+pWHI9o4FSpLvekKMlFoJ1bNaZ21WeRbg+pfr73T0DtbUoafN2wmjsLFudhFg49f20WMgE
 wV0jjvJbsFvbg7LXx1LF+gFo/TfgI9ed2VZZkPtMoWzrLh7jwTUsOC2evpSTsHwDduV0VDldBUc
 YStSnxqWtawchvidrV8L2Q5YiJXSpvFBSL36VMjn5n1c4NYEVHpSxOLRfr+/xGRSGaTk/FGt7YN
 e7h9oFeYizmPsLvYGTQUXTJl7e8YvnYnpr0ZLJzNH2DAeV3jYj3i1g6T1Uaf1a3uZl4K10lMV4Z
 77//549s4g+Xoffks
X-Received: by 2002:a05:622a:5a19:b0:54a:e748:9dea with SMTP id
 d75a77b69052e-54e15a65d16mr65404671cf.69.1794015029580; 
 Fri, 06 Nov 2026 17:30:29 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c2ac1.dyn.optonline.net. [148.76.42.193])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e257862bfsm33746111cf.6.2026.11.06.17.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:30:29 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v1 8/8] event/slb: improve port linking,
 config checks and atomic refill
Date: Fri,  6 Nov 2026 20:30:10 -0500
Message-ID: <20261107013011.2443138-9-pravinpathakdev@gmail.com>
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

- Validate duplicate/conflicting queue-port links and slot capacity at
  the start of slb_port_link_one(), and fix priority levels to 2.
- Validate nb_event_ports and nb_event_queues limits in slb_configure(),
  avoid rounding max_inflight to a power of 2, and precompute
  migration_cooldown_cycles once during configuration.
- Verify all queues are configured and linked to at least one port in
  slb_start().
- Use relaxed stores when clearing drained reorder buffer slots and
  avoid duplicate acquire load on the first burst element in
  slb_reorder_drain().
- Ensure hold buffer capacity before dequeuing in slb_atomic_refill()
  and continue refilling uncongested ports while hold buffer space
  remains.
- Enforce 1-to-1 single-link port and single-link queue pairing in
  slb_port_link_one(), disallowing linking a single-link queue to a
  regular port or a regular queue to a single-linked port.
- Preserve event sched_type on single-link dequeue and only clear
  impl_opaque to 0.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 drivers/event/slb/slb_evdev.c    | 200 +++++++++++++--------
 drivers/event/slb/slb_evdev.h    |  41 +----
 drivers/event/slb/slb_event.c    | 290 ++++++++++++++++++-------------
 drivers/event/slb/slb_selftest.c |  12 --
 4 files changed, 306 insertions(+), 237 deletions(-)

diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
index 16bfefaa68..346b4b38ed 100644
--- a/drivers/event/slb/slb_evdev.c
+++ b/drivers/event/slb/slb_evdev.c
@@ -84,10 +84,6 @@ slb_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 		.last_migrated_time = 0,
 	};
 
-	port->remap_input_q = false;
-	rte_atomic_store_explicit(&port->active_queues, 0,
-				  rte_memory_order_relaxed);
-
 	dev->data->ports[port_id] = port;
 
 	/* Reset all queues mapped to this port */
@@ -199,9 +195,7 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 		return -ENOMEM;
 
 	queue->q_ring = ring;
-	/* Single-link queue uses atomic schedule type */
-	queue->schedule_type = queue->is_single_link ?
-			       RTE_SCHED_TYPE_ATOMIC : conf->schedule_type;
+	queue->schedule_type = conf->schedule_type;
 	queue->serving_ports_mask = 0;
 	queue->num_serving_ports = 0;
 
@@ -270,16 +264,20 @@ slb_queue_def_conf(struct rte_eventdev *dev __rte_unused,
 static void
 slb_port_unlink_queue_from_prio(struct slb_port *port, int prio, int slot)
 {
+	/* Shift the queue entries to overwriting the unlinked queue slot */
 	for (int k = slot; k < port->num_q[prio] - 1; k++)
 		port->q_entries[prio][k] = port->q_entries[prio][k + 1];
 
+	/* Decrement mapped queue count and Clear the last slot after shifting */
 	port->num_q[prio]--;
 	memset(&port->q_entries[prio][port->num_q[prio]], 0,
 	       sizeof(struct slb_port_q_entry));
+	/* Adjust the next queue index if it points beyond the new count */
 	if (port->next_q[prio] >= port->num_q[prio])
 		port->next_q[prio] = 0;
 }
 
+/* Find the slot of a queue in a specific priority level, returning -1 if not found */
 static int
 slb_port_find_queue_slot(struct slb_port *port, int prio, uint8_t qid)
 {
@@ -290,24 +288,67 @@ slb_port_find_queue_slot(struct slb_port *port, int prio, uint8_t qid)
 	return -1;
 }
 
+/* Link a queue to a port at a specific priority level */
 static int
 slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
 		  uint8_t qid, uint8_t app_prio, bool has_prio)
 {
+	struct rte_event_ring *dq_ring;
+	uint16_t slot;
 	int prio;
-	bool found = false;
 
 	if (port->is_single_linked) {
-		if (port->single_linked_q != NULL &&
-		    port->single_linked_q != queue) {
+		/* Only a single-link queue can be linked to a single-linked port */
+		if (!queue->is_single_link) {
+			rte_errno = EINVAL;
+			return -EINVAL;
+		}
+		/* Only one queue can be linked to a single-linked port */
+		if (port->single_linked_q != NULL) {
+			if (port->single_linked_q == queue)
+				return 0;
+			rte_errno = EINVAL;
+			return -EINVAL;
+		}
+		/* A single-link queue can only be linked to one port */
+		if (queue->serving_ports_mask != 0) {
 			rte_errno = EINVAL;
 			return -EINVAL;
 		}
 		port->single_linked_q = queue;
 		port->single_linked_ring = queue->q_ring;
 	} else {
-		if (!queue->is_single_link &&
-		    queue->schedule_type == RTE_SCHED_TYPE_ATOMIC &&
+		/* A single-link queue cannot be linked to a regular port */
+		if (queue->is_single_link) {
+			rte_errno = EINVAL;
+			return -EINVAL;
+		}
+
+		/* Convert application priority to internal priority level (0 or 1) */
+		if (has_prio)
+			prio = (app_prio < RTE_EVENT_DEV_PRIORITY_NORMAL) ? 0 : 1;
+		else
+			prio = SLB_MAX_PRIORITIES - 1;
+
+		/* Check if queue is already mapped to this port at requested priority */
+		for (int pr = 0; pr < SLB_MAX_PRIORITIES; pr++) {
+			if (slb_port_find_queue_slot(port, pr, qid) >= 0) {
+				if (pr == prio)
+					return 0;
+				rte_errno = EINVAL;
+				return -EINVAL;
+			}
+		}
+
+		/* Ensure a free mapping slot is available at the requested priority */
+		slot = port->num_q[prio];
+		if (slot >= SLB_PORT_MAX_Q_MAP_PER_PRIO) {
+			rte_errno = ENOSPC;
+			return -ENOSPC;
+		}
+
+		/* Allocate per-port ring when linking an atomic queue */
+		if (queue->schedule_type == RTE_SCHED_TYPE_ATOMIC &&
 		    queue->per_port_rings[port->id] == NULL) {
 			char ring_name[RTE_RING_NAMESIZE];
 			struct rte_event_ring *ring;
@@ -327,53 +368,23 @@ slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
 			queue->per_port_rings[port->id] = ring;
 		}
 
-		if (has_prio)
-			prio = (app_prio < RTE_EVENT_DEV_PRIORITY_NORMAL) ? 0 : 1;
-		else
-			prio = SLB_MAX_PRIORITIES - 1;
-
-		for (int pr = 0; pr < SLB_MAX_PRIORITIES; pr++) {
-			int s = slb_port_find_queue_slot(port, pr, qid);
-
-			if (s >= 0) {
-				if (pr == prio)
-					found = true;
-				else
-					slb_port_unlink_queue_from_prio(port, pr, s);
-				break;
-			}
-		}
-		if (!found) {
-			uint16_t slot = port->num_q[prio];
-			struct rte_event_ring *dq_ring =
-				(!queue->is_single_link &&
-				 queue->schedule_type == RTE_SCHED_TYPE_ATOMIC) ?
-				queue->per_port_rings[port->id] : queue->q_ring;
-
-			if (slot >= SLB_PORT_MAX_Q_MAP_PER_PRIO) {
-				rte_errno = ENOSPC;
-				return -ENOSPC;
-			}
-			port->q_entries[prio][slot].dq_ring = dq_ring;
-			port->q_entries[prio][slot].queue = queue;
-			port->q_entries[prio][slot].queue_id = qid;
-			port->q_entries[prio][slot].schedule_type =
-				queue->schedule_type;
-			port->q_entries[prio][slot].is_single_link =
-				queue->is_single_link;
-			port->num_q[prio]++;
-		}
+		dq_ring = (queue->schedule_type == RTE_SCHED_TYPE_ATOMIC) ?
+			  queue->per_port_rings[port->id] : queue->q_ring;
 
-		rte_atomic_fetch_or_explicit(&port->active_queues,
-					     (1ULL << qid),
-					     rte_memory_order_release);
+		port->q_entries[prio][slot].dq_ring = dq_ring;
+		port->q_entries[prio][slot].queue = queue;
+		port->q_entries[prio][slot].queue_id = qid;
+		port->q_entries[prio][slot].schedule_type = queue->schedule_type;
+		port->num_q[prio]++;
 	}
 
+	/* Add newly linked port to the queue's serving ports mask */
 	queue->serving_ports_mask |= (1ULL << port->id);
 	queue->num_serving_ports = rte_popcount64(queue->serving_ports_mask);
 	return 0;
 }
 
+/* Unlink a queue from a port */
 static int
 slb_port_unlink_one(struct slb_port *port, struct slb_queue *queue, uint8_t qid)
 {
@@ -386,7 +397,7 @@ slb_port_unlink_one(struct slb_port *port, struct slb_queue *queue, uint8_t qid)
 		}
 		port->single_linked_q = NULL;
 		port->single_linked_ring = NULL;
-	} else {
+	} else { /* Unlink queue by finding its slot */
 		for (int prio = 0; prio < SLB_MAX_PRIORITIES; prio++) {
 			int s = slb_port_find_queue_slot(port, prio, qid);
 
@@ -396,21 +407,17 @@ slb_port_unlink_one(struct slb_port *port, struct slb_queue *queue, uint8_t qid)
 				break;
 			}
 		}
-		if (!found) {
+		if (!found) { /* No link found */
 			rte_errno = EINVAL;
 			return -EINVAL;
 		}
 
+		/* For atomic queues, free the per-port ring if it exists */
 		if (queue->schedule_type == RTE_SCHED_TYPE_ATOMIC &&
 		    queue->per_port_rings[port->id] != NULL) {
 			rte_event_ring_free(queue->per_port_rings[port->id]);
 			queue->per_port_rings[port->id] = NULL;
 		}
-
-		rte_atomic_fetch_and_explicit(&port->active_queues,
-					      ~(1ULL << qid),
-					      rte_memory_order_release);
-		port->remap_input_q = true;
 	}
 
 	queue->serving_ports_mask &= ~(1ULL << port->id);
@@ -418,6 +425,7 @@ slb_port_unlink_one(struct slb_port *port, struct slb_queue *queue, uint8_t qid)
 	return 0;
 }
 
+/* Link all queues to a port at specific priorities */
 static int
 slb_port_link(struct rte_eventdev *dev, void *p, const uint8_t queues[],
 	      const uint8_t priorities[], uint16_t num)
@@ -439,6 +447,7 @@ slb_port_link(struct rte_eventdev *dev, void *p, const uint8_t queues[],
 	return num;
 }
 
+/* Unlink all queues from a port */
 static int
 slb_port_unlink(struct rte_eventdev *dev, void *p, uint8_t queues[],
 		uint16_t num)
@@ -458,6 +467,7 @@ slb_port_unlink(struct rte_eventdev *dev, void *p, uint8_t queues[],
 	return num;
 }
 
+/* Get information about the event device */
 static void
 slb_info_get(struct rte_eventdev *dev __rte_unused,
 	     struct rte_event_dev_info *info)
@@ -467,7 +477,7 @@ slb_info_get(struct rte_eventdev *dev __rte_unused,
 		.max_event_queues = SLB_MAX_QUEUES,
 		.max_event_queue_flows = SLB_MAX_FLOWS,
 		.max_event_queue_priority_levels = SLB_MAX_PRIORITIES,
-		.max_event_priority_levels = SLB_MAX_PRIORITIES,
+		.max_event_priority_levels = 1,
 		.max_event_ports = SLB_MAX_PORTS,
 		.max_event_port_dequeue_depth = SLB_MAX_PORT_DEQUEUE_DEPTH,
 		.max_event_port_enqueue_depth = SLB_MAX_PORT_ENQUEUE_DEPTH,
@@ -487,13 +497,13 @@ slb_info_get(struct rte_eventdev *dev __rte_unused,
 	};
 }
 
+/* Configure the event device */
 static int
 slb_configure(const struct rte_eventdev *dev)
 {
 	struct slb_evdev *slb = slb_pmd_priv(dev);
 	const struct rte_event_dev_config *conf = &dev->data->dev_conf;
 	int32_t min_max_in_flight;
-	uint32_t q_size;
 
 	if (conf->nb_events_limit <= 0 ||
 	    conf->nb_events_limit > SLB_MAX_EVENTS) {
@@ -503,36 +513,60 @@ slb_configure(const struct rte_eventdev *dev)
 		return -EINVAL;
 	}
 
+	/* Validate max event ports and queues that SLB can support */
+	if (conf->nb_event_ports == 0 ||
+	    conf->nb_event_ports > SLB_MAX_PORTS) {
+		SLB_LOG_DP_LINE(INFO,
+			"nb_event_ports (%u) invalid, max is %d",
+			conf->nb_event_ports, SLB_MAX_PORTS);
+		return -EINVAL;
+	}
+
+	if (conf->nb_event_queues == 0 ||
+	    conf->nb_event_queues > SLB_MAX_QUEUES) {
+		SLB_LOG_DP_LINE(INFO,
+			"nb_event_queues (%u) invalid, max is %d",
+			conf->nb_event_queues, SLB_MAX_QUEUES);
+		return -EINVAL;
+	}
+
 	slb->num_ports = conf->nb_event_ports;
 	slb->num_queues = conf->nb_event_queues;
 
+	/* Compute minimum credits required to avoid deadlock */
 	min_max_in_flight = conf->nb_event_ports * SLB_PORT_MAX_CREDITS;
 	if (min_max_in_flight > SLB_MAX_EVENTS)
 		min_max_in_flight = SLB_MAX_EVENTS;
 
-	q_size = rte_align32pow2((uint32_t)RTE_MAX(conf->nb_events_limit,
-						   min_max_in_flight));
-	if (q_size > SLB_MAX_EVENTS)
-		q_size = SLB_MAX_EVENTS;
-
-	slb->max_inflight = (int32_t)q_size;
+	/* Set credit pool size to max of nb_events_limit and minimum required to avoid deadlock */
+	slb->max_inflight = RTE_MAX(conf->nb_events_limit, min_max_in_flight);
+	slb->migration_cooldown_cycles =
+		(rte_get_timer_hz() * SLB_MIGRATION_COOLDOWN_MS) / 1000;
 	return 0;
 }
 
+/* Start the event device */
 static int
 slb_start(struct rte_eventdev *dev)
 {
 	struct slb_evdev *slb = slb_pmd_priv(dev);
 
+	/* Make sure all queues are set up and have at least one linked port */
 	for (int i = 0; i < slb->num_queues; i++) {
-		if (slb->queues[i].serving_ports_mask == 0)
-			SLB_LOG_DP_LINE(INFO,
-				"Queue %d has no linked ports on start", i);
+		if (slb->queues[i].q_ring == NULL ||
+		    slb->queues[i].serving_ports_mask == 0) {
+			SLB_LOG_DP_LINE(ERR,
+				"Queue %d is not configured or has no linked ports",
+				i);
+			return -ENOLINK;
+		}
 	}
 
+	/* No events in flight */
 	rte_atomic_store_explicit(&slb->credits_on_loan, 0,
 				  rte_memory_order_relaxed);
 
+	/* Reset port states */
 	for (int i = 0; i < slb->num_ports; i++) {
 		struct slb_port *port = &slb->ports[i];
 		port->inflight_credits = 0;
@@ -544,6 +578,7 @@ slb_start(struct rte_eventdev *dev)
 	return 0;
 }
 
+/* Empty the event queue */
 static void
 slb_drain_ring(uint8_t dev_id, struct rte_event_ring *ring,
 	       eventdev_stop_flush_t flush, void *flush_arg)
@@ -553,6 +588,7 @@ slb_drain_ring(uint8_t dev_id, struct rte_event_ring *ring,
 	if (ring == NULL)
 		return;
 
+	/* Dequeue all events from the ring and call user callback if provided */
 	while (rte_event_ring_dequeue_burst(ring, &ev, 1, NULL)) {
 		if (flush != NULL)
 			flush(dev_id, ev, flush_arg);
@@ -560,6 +596,7 @@ slb_drain_ring(uint8_t dev_id, struct rte_event_ring *ring,
 	rte_ring_reset(&ring->r);
 }
 
+/* Stop the event device */
 static void
 slb_stop(struct rte_eventdev *dev)
 {
@@ -575,6 +612,7 @@ slb_stop(struct rte_eventdev *dev)
 		    q->atomic_state != NULL) {
 			struct slb_atomic_state *astate = q->atomic_state;
 
+			/* Call user callback for each held event */
 			for (uint16_t h = 0; h < astate->hold_count; h++) {
 				if (flush != NULL)
 					flush(dev_id, astate->hold_buffer[h],
@@ -584,6 +622,7 @@ slb_stop(struct rte_eventdev *dev)
 			astate->next_port_rr = 0;
 			astate->migration.in_progress = false;
 
+			/* Reset flow to port mapping */
 			for (int f = 0; f < SLB_ATOMIC_FLOWS; f++) {
 				rte_atomic_store_explicit(
 					&astate->flow_map.flows[f].port_id,
@@ -594,6 +633,7 @@ slb_stop(struct rte_eventdev *dev)
 			memset(astate->port_stats, 0,
 			       sizeof(astate->port_stats));
 
+			/* Drain all events from per-port rings */
 			for (uint16_t pid = 0; pid < slb->num_ports; pid++) {
 				if (q->per_port_rings[pid] != NULL)
 					slb_drain_ring(dev_id,
@@ -606,11 +646,12 @@ slb_stop(struct rte_eventdev *dev)
 				uint8_t st = rte_atomic_load_explicit(
 					&q->reorder_buffer[s].state,
 					rte_memory_order_relaxed);
-
+				/* Flush all ready events from the reorder buffer. */
 				if (st == SLB_REORDER_READY && flush != NULL)
 					flush(dev_id,
 					      q->reorder_buffer[s].event,
 					      flush_arg);
+				/* Mark freed slot as empty */
 				rte_atomic_store_explicit(
 					&q->reorder_buffer[s].state,
 					SLB_REORDER_EMPTY,
@@ -623,6 +664,7 @@ slb_stop(struct rte_eventdev *dev)
 			slb_drain_ring(dev_id, q->q_ring, flush, flush_arg);
 	}
 
+	/* Reset each port's state, history lists and queue mappings */
 	for (int i = 0; i < slb->num_ports; i++) {
 		struct slb_port *port = &slb->ports[i];
 		port->inflight_credits = 0;
@@ -635,21 +677,25 @@ slb_stop(struct rte_eventdev *dev)
 			port->next_q[p] = 0;
 	}
 
+	/* Reset the credit pool to all available */
 	rte_atomic_store_explicit(&slb->credits_on_loan, 0,
 				  rte_memory_order_relaxed);
 }
 
+/* Close the event device */
 static int
 slb_close(struct rte_eventdev *dev)
 {
 	struct slb_evdev *slb = slb_pmd_priv(dev);
 
+	/* Release all resources acquired by the queues */
 	for (int i = 0; i < slb->num_queues; i++)
 		slb_queue_release(dev, i);
 
 	return 0;
 }
 
+/* Dump the event device current state and statistics */
 void
 slb_dump(struct rte_eventdev *dev, FILE *f)
 {
@@ -689,14 +735,12 @@ slb_dump(struct rte_eventdev *dev, FILE *f)
 	fprintf(f, "\n  PORT STATISTICS & QUEUE LINKAGES:\n");
 	for (i = 0; i < slb->num_ports; i++) {
 		struct slb_port *p = &slb->ports[i];
-		uint64_t aq = rte_atomic_load_explicit(&p->active_queues,
-						       rte_memory_order_acquire);
 		int linked_count = 0;
 
 		fprintf(f,
-			"    Port %2u (credits=%3d, active=0x%08" PRIx64
-			", loaded=%d, mig_in=%" PRIu64 ", mig_out=%" PRIu64 "): ",
-			i, p->inflight_credits, aq, p->is_loaded,
+			"    Port %2u (credits=%3d, loaded=%d"
+			", mig_in=%" PRIu64 ", mig_out=%" PRIu64 "): ",
+			i, p->inflight_credits, p->is_loaded,
 			p->migrations_in, p->migrations_out);
 
 		if (p->is_single_linked) {
@@ -743,7 +787,8 @@ slb_dump(struct rte_eventdev *dev, FILE *f)
 			i, count, ring_size, q->serving_ports_mask,
 			q->num_serving_ports, q->schedule_type,
 			q->is_single_link);
-		if (q->schedule_type == RTE_SCHED_TYPE_ATOMIC) {
+		if (!q->is_single_link &&
+		    q->schedule_type == RTE_SCHED_TYPE_ATOMIC) {
 			if (q->atomic_state) {
 				fprintf(f,
 					"      Atomic State: total_migrations=%" PRIu64
@@ -774,7 +819,8 @@ slb_dump(struct rte_eventdev *dev, FILE *f)
 					}
 				}
 			}
-		} else if (q->schedule_type == RTE_SCHED_TYPE_ORDERED) {
+		} else if (!q->is_single_link &&
+			   q->schedule_type == RTE_SCHED_TYPE_ORDERED) {
 			fprintf(f, "      Ordered reorder_drain_idx=%u\n",
 				q->reorder_drain_idx);
 		}
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
index bf262903cd..c01290e539 100644
--- a/drivers/event/slb/slb_evdev.h
+++ b/drivers/event/slb/slb_evdev.h
@@ -16,8 +16,8 @@
 #define SLB_PMD_NAME RTE_STR(event_slb)
 
 #define SLB_MAX_PORTS (64)
-#define SLB_MAX_PORT_DEQUEUE_DEPTH (128)
-#define SLB_MAX_PORT_ENQUEUE_DEPTH (128)
+#define SLB_MAX_PORT_DEQUEUE_DEPTH (128u)
+#define SLB_MAX_PORT_ENQUEUE_DEPTH (128u)
 
 #define SLB_MAX_QUEUES (64)
 
@@ -36,13 +36,13 @@
 
 /* Maximum number of queues that can be linked to a port per priority */
 #define SLB_PORT_MAX_Q_MAP_PER_PRIO (SLB_MAX_QUEUES)
-/* Number of priority levels supported by SLB. Configure 1..4. */
+/* Number of priority levels supported by SLB. Currently fixed to 2 */
 #ifndef SLB_MAX_PRIORITIES
 #define SLB_MAX_PRIORITIES 2
 #endif
 
-#if (SLB_MAX_PRIORITIES < 1) || (SLB_MAX_PRIORITIES > 4)
-#error "SLB_MAX_PRIORITIES must be between 1 and 4"
+#if (SLB_MAX_PRIORITIES != 2)
+#error "SLB_MAX_PRIORITIES must be set to 2 for now"
 #endif
 
 /* Total max mapping slots (per-prio * priorities) */
@@ -56,8 +56,7 @@ struct slb_port_q_entry {
 	struct slb_queue *queue;
 	uint8_t queue_id;
 	uint8_t schedule_type;
-	bool is_single_link;
-	uint8_t pad[5];
+	uint8_t pad[6];
 };
 
 #define SLB_PORT_HISTORY_SIZE 256
@@ -139,15 +138,13 @@ struct __rte_cache_aligned slb_port {
 	uint16_t pending_releases;
 	int32_t inflight_credits;
 	int32_t new_event_threshold;
-	RTE_ATOMIC(uint64_t) active_queues;
 	uint16_t num_q[SLB_MAX_PRIORITIES];
 	uint16_t next_q[SLB_MAX_PRIORITIES];
 	bool is_single_linked;
 	bool implicit_release;
 	bool credits_drained;
-	bool remap_input_q;
 	bool is_loaded; /* Port marked loaded for atomic flow migration */
-	uint8_t pad_port[3];
+	uint8_t pad_port[4];
 	struct rte_event_ring *single_linked_ring;
 	struct slb_evdev *slb;
 
@@ -196,7 +193,7 @@ struct slb_queue {
 	rte_spinlock_t reorder_lock;
 };
 
-/* Limited by the size of 'serving_ports_mask' and 'active_queues' bitmasks */
+/* Limited by the size of 64-bit port and queue bitmasks */
 static_assert(SLB_MAX_PORTS <= 64, "Max compile-time port count exceeded");
 static_assert(SLB_MAX_QUEUES <= 64, "Max compile-time queue count exceeded");
 
@@ -208,6 +205,7 @@ struct slb_evdev {
 	struct slb_queue queues[SLB_MAX_QUEUES];
 	uint8_t num_queues;
 	int32_t max_inflight;
+	uint64_t migration_cooldown_cycles;
 
 	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(int32_t) credits_on_loan;
 };
@@ -262,25 +260,4 @@ extern int event_slb_logtype;
 #define SLB_LOG_DP_PORT_LINE(level, port_id, fmt, ...)			\
 	SLB_LOG_DP_LINE(level, "<Port %d> " fmt, port_id, ## __VA_ARGS__)
 
-/* Obtain serving port masks for the specified queue and set corresponding
- * active queue bits for all served ports.
- */
-static inline void
-slb_port_wakeup_queues(struct slb_evdev *slb, struct slb_queue *queue)
-{
-	uint8_t queue_id = queue - slb->queues;
-	uint64_t port_mask = queue->serving_ports_mask;
-	struct slb_port *port;
-	uint8_t port_id;
-
-	while (port_mask) {
-		port_id = rte_ctz64(port_mask);
-		port = &slb->ports[port_id];
-		rte_atomic_fetch_or_explicit(&port->active_queues,
-					     (1ULL << queue_id),
-					     rte_memory_order_release);
-		port_mask &= ~(1ULL << port_id);
-	}
-}
-
 #endif /* _SLB_EVDEV_H_ */
diff --git a/drivers/event/slb/slb_event.c b/drivers/event/slb/slb_event.c
index c44deba905..3d0436e4a0 100644
--- a/drivers/event/slb/slb_event.c
+++ b/drivers/event/slb/slb_event.c
@@ -11,7 +11,7 @@
 
 #include "slb_evdev.h"
 
-/* Acquire credits for new events */
+/* Port Acquiring credits for new events. Serve from local cache if possible. */
 static bool
 slb_port_acquire_credits(struct slb_evdev *slb, struct slb_port *port,
 			 int32_t credits)
@@ -34,34 +34,38 @@ slb_port_acquire_credits(struct slb_evdev *slb, struct slb_port *port,
 	available = slb->max_inflight - total_inflight;
 	required_credits = RTE_MAX(abs(remaining_credits), SLB_PORT_MIN_CREDITS);
 
+	/* Pool does not have enough credits */
 	if (available < required_credits)
 		return false;
 
+	/* Take credits from the pool */
 	new_total_inflight =
 		rte_atomic_fetch_add_explicit(&slb->credits_on_loan,
 					      required_credits,
 					      rte_memory_order_relaxed) +
 					      required_credits;
-
+	/* Check if the new total exceeds the maximum allowed */
 	if (unlikely(new_total_inflight > slb->max_inflight)) {
 		rte_atomic_fetch_sub_explicit(&slb->credits_on_loan,
 					      required_credits,
 					      rte_memory_order_relaxed);
 		return false;
 	}
-
+	/* Update the port's credit counts*/
 	port->inflight_credits += required_credits;
 	port->inflight_credits -= credits;
 
 	return true;
 }
 
-/* Return accumulated credits (Terminated events) */
+/* Port returning credits (Terminated events). Keep local cache.
+ * If local cache exceeds the threshold, return excess credits to the pool
+ */
 void
 slb_port_return_credits(struct slb_evdev *slb, struct slb_port *port,
 			int32_t credits)
 {
-	port->inflight_credits += credits;
+	port->inflight_credits += credits; /* Local credit cache */
 
 	if (unlikely(port->inflight_credits >= SLB_PORT_MAX_CREDITS)) {
 		int32_t return_credits = port->inflight_credits -
@@ -74,6 +78,7 @@ slb_port_return_credits(struct slb_evdev *slb, struct slb_port *port,
 	}
 }
 
+/* Port enqueue statistics */
 static void
 slb_port_enqueue_stats(struct slb_port *port, uint16_t num_new,
 		       uint16_t num_forward, uint16_t num_release)
@@ -98,7 +103,7 @@ slb_port_queue_enqueue_burst_stats(struct slb_port *source_port,
 
 #define REORDER_BURST_SZ 64
 
-/* Drain in-order contiguous ready events from ordered queue's reorder buffer */
+/* Drain contiguous ready events from ordered queue's reorder buffer */
 void
 slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 {
@@ -114,8 +119,8 @@ slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 	struct slb_reorder_entry *buf = queue->reorder_buffer;
 	uint8_t state;
 
-	/* Drain from current drain index till hitting an empty slot.
-	 * Released slots need no processing except marking them empty.
+	/* Drain events from the current drain index till an empty slot.
+	 * Released event slots need no processing except marking them as empty.
 	 */
 	while ((state = rte_atomic_load_explicit(&buf[drain_idx].state,
 						 rte_memory_order_acquire)) !=
@@ -123,30 +128,27 @@ slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 		if (state == SLB_REORDER_RELEASED) {
 			rte_atomic_store_explicit(&buf[drain_idx].state,
 						  SLB_REORDER_EMPTY,
-						  rte_memory_order_release);
+						  rte_memory_order_relaxed);
 			drain_idx = (drain_idx + 1) & mask;
 			continue;
 		}
 
-		/* Gather contiguous READY events destined for same target_qid */
+		/* Gather contiguous READY events destined to same target_qid */
 		struct rte_event burst[REORDER_BURST_SZ];
 		uint16_t burst_size = 0;
 		uint8_t target_qid = buf[drain_idx].event.queue_id;
 
-		while (burst_size < REORDER_BURST_SZ &&
-		       rte_atomic_load_explicit(&buf[drain_idx].state,
-						rte_memory_order_acquire) ==
-		       SLB_REORDER_READY &&
-		       buf[drain_idx].event.queue_id == target_qid) {
+		do {
 			burst[burst_size++] = buf[drain_idx].event;
 			rte_atomic_store_explicit(&buf[drain_idx].state,
 						  SLB_REORDER_EMPTY,
-						  rte_memory_order_release);
+						  rte_memory_order_relaxed);
 			drain_idx = (drain_idx + 1) & mask;
-		}
-
-		if (burst_size == 0)
-			break;
+		} while (burst_size < REORDER_BURST_SZ &&
+			 rte_atomic_load_explicit(&buf[drain_idx].state,
+						  rte_memory_order_acquire) ==
+			 SLB_REORDER_READY &&
+			 buf[drain_idx].event.queue_id == target_qid);
 
 		/* Target queue is sized to max_inflight and can never be full */
 		rte_event_ring_enqueue_burst(slb->queues[target_qid].q_ring,
@@ -157,13 +159,14 @@ slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 	rte_spinlock_unlock(&queue->reorder_lock);
 }
 
-/* Hash flow ID to atomic flow slot index */
+/* Hash 20-bit flow ID into atomic flow slot index (SLB_ATOMIC_FLOWS) */
 static inline uint32_t
 slb_flow_hash(uint32_t flow_id)
 {
 	return (flow_id * 2654435761U) & SLB_ATOMIC_FLOWS_MASK;
 }
 
+/* Find the lightest flow on a given port to migrate */
 static int32_t
 slb_find_lightest_flow_on_port(struct slb_queue *queue, uint8_t port_id,
 			       uint64_t now, uint64_t cooldown_cycles)
@@ -187,12 +190,14 @@ slb_find_lightest_flow_on_port(struct slb_queue *queue, uint8_t port_id,
 	r = &ering->r;
 	cons = rte_atomic_load_explicit(&r->cons.tail, rte_memory_order_relaxed);
 	prod = rte_atomic_load_explicit(&r->prod.tail, rte_memory_order_relaxed);
-	count = prod - cons;
+	count = prod - cons; /* Number of atomic events in the per port ring */
 
 	memset(counts, 0, sizeof(counts));
 	if (count > 0) {
+		/* Skip over the ring header and point to events */
 		struct rte_event *ring_events = (struct rte_event *)(r + 1);
 
+		/* Count events for each flow in per port queue */
 		for (uint32_t i = 0; i < count; i++) {
 			uint32_t slot = (cons + i) & r->mask;
 			uint32_t f_idx = slb_flow_hash(ring_events[slot].flow_id);
@@ -201,9 +206,11 @@ slb_find_lightest_flow_on_port(struct slb_queue *queue, uint8_t port_id,
 		}
 	}
 
+	/* Find the flow with the minimum number of events */
 	for (uint32_t f = 0; f < SLB_ATOMIC_FLOWS; f++) {
 		if (rte_atomic_load_explicit(&astate->flow_map.flows[f].port_id,
 					     rte_memory_order_relaxed) == (int32_t)port_id) {
+			/* Skip flows that have been migrated recently */
 			if (astate->flow_last_migrated[f] != 0 &&
 			    (now - astate->flow_last_migrated[f]) < cooldown_cycles)
 				continue;
@@ -218,16 +225,19 @@ slb_find_lightest_flow_on_port(struct slb_queue *queue, uint8_t port_id,
 	return best_flow_idx;
 }
 
+/* Check if port is loaded and migration is necessary. Start the flow
+ * migration processes if required.
+ */
 static void
 slb_check_and_trigger_migration(struct slb_evdev *slb, struct slb_queue *queue,
 				struct slb_atomic_state *astate, uint8_t full_port_id)
 {
 	struct slb_atomic_port_stats *pstats = &astate->port_stats[full_port_id];
+	uint64_t cooldown_cycles = slb->migration_cooldown_cycles;
 	uint64_t now;
-	uint64_t hz;
-	uint64_t cooldown_cycles;
 	int32_t flow_to_migrate;
 
+	/* Check if the port has crossed load threshold */
 	pstats->load_counter++;
 	if (pstats->load_counter < SLB_MIGRATION_LOAD_THRESHOLD)
 		return;
@@ -235,20 +245,21 @@ slb_check_and_trigger_migration(struct slb_evdev *slb, struct slb_queue *queue,
 	if (astate->migration.in_progress)
 		return;
 
+	/* Already marked for migration */
 	if (slb->ports[full_port_id].is_loaded)
 		return;
 
-	if (pstats->flow_count <= 1)
+	if (pstats->flow_count <= 1) /* Not enough flows to migrate */
 		return;
 
 	now = rte_get_timer_cycles();
-	hz = rte_get_timer_hz();
-	cooldown_cycles = (hz * SLB_MIGRATION_COOLDOWN_MS) / 1000;
 
+	/* Port is still in cooldown period */
 	if (slb->ports[full_port_id].last_migrated_time != 0 &&
 	    (now - slb->ports[full_port_id].last_migrated_time) < cooldown_cycles)
 		return;
 
+	/* Find flow to migrate*/
 	flow_to_migrate = slb_find_lightest_flow_on_port(
 		queue, full_port_id, now, cooldown_cycles);
 	if (flow_to_migrate < 0)
@@ -261,6 +272,7 @@ slb_check_and_trigger_migration(struct slb_evdev *slb, struct slb_queue *queue,
 	astate->migration.flow_idx = (uint32_t)flow_to_migrate;
 }
 
+/* Find the target port (one with minimum flows) for flow migration */
 static inline int
 slb_find_migration_target_port(struct slb_evdev *slb, struct slb_queue *queue,
 			       struct slb_atomic_state *astate, uint8_t mig_port,
@@ -291,15 +303,18 @@ slb_find_migration_target_port(struct slb_evdev *slb, struct slb_queue *queue,
 	return target_port;
 }
 
+/* Complete the flow migration process from original port to target port */
 static inline void
 slb_complete_flow_migration(struct slb_evdev *slb, struct slb_atomic_state *astate,
 			    uint8_t mig_port, int target_port, uint64_t now)
 {
 	uint32_t f_idx = astate->migration.flow_idx;
 
+	/* Switch the flow mapping to the target port */
 	rte_atomic_store_explicit(&astate->flow_map.flows[f_idx].port_id,
 				  target_port, rte_memory_order_release);
 
+	/* Switch all events in hold buffer to the target port */
 	for (uint16_t h = 0; h < astate->hold_count; h++) {
 		if (astate->hold_ports[h] == mig_port &&
 		    slb_flow_hash(astate->hold_buffer[h].flow_id) == f_idx) {
@@ -307,38 +322,45 @@ slb_complete_flow_migration(struct slb_evdev *slb, struct slb_atomic_state *asta
 		}
 	}
 
+	/* Update migration timestamps */
 	astate->flow_last_migrated[f_idx] = now;
 	slb->ports[mig_port].last_migrated_time = now;
 	slb->ports[target_port].last_migrated_time = now;
 
+	/* Update flow counts */
 	if (astate->port_stats[mig_port].flow_count > 0)
 		astate->port_stats[mig_port].flow_count--;
 	astate->port_stats[target_port].flow_count++;
 	astate->migrations_count++;
 
+	/* Update migration counters */
 	slb->ports[mig_port].flow_migrations++;
 	slb->ports[mig_port].migrations_out++;
 	slb->ports[target_port].migrations_in++;
 
+	/* Mark migration as complete */
 	astate->port_stats[mig_port].load_counter = 0;
 	slb->ports[mig_port].is_loaded = false;
 	astate->migration.in_progress = false;
 }
 
+/* Assign a port to unmapped flow */
 static inline uint8_t
 slb_assign_unmapped_flow_port(struct slb_evdev *slb, struct slb_atomic_state *astate,
 			      uint64_t serving_mask, uint16_t num_serving_ports)
 {
 	uint32_t rr_counter = astate->next_port_rr++;
-	int port_offset = rr_counter % num_serving_ports;
+	int port_offset = rr_counter % num_serving_ports; /* Pick next port */
 	uint64_t temp_mask = serving_mask;
 	uint8_t assigned_port = 0;
 
+	/* Convert offset to port ID */
 	for (int j = 0; j <= port_offset; j++) {
 		assigned_port = rte_ctz64(temp_mask);
 		temp_mask &= (temp_mask - 1);
 	}
 
+	/* If next port in RR selection is loaded then find an unloaded port */
 	if (slb->ports[assigned_port].is_loaded) {
 		uint64_t cand_mask = serving_mask;
 
@@ -355,14 +377,14 @@ slb_assign_unmapped_flow_port(struct slb_evdev *slb, struct slb_atomic_state *as
 	return assigned_port;
 }
 
-/* If port queue is empty for an atomic queue, pull events from main atomic queue to fill
- * up port queues.
+/* If per port atomic queue is empty, pull events from the main atomic queue to fill
+ * up all port queues. Handle migration and hold buffer processing.
  */
 static void
 slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 {
 	struct slb_evdev *slb = port->slb;
-	struct rte_event master_events[SLB_MAX_PORT_DEQUEUE_DEPTH];
+	struct rte_event rcv_events[SLB_MAX_PORT_DEQUEUE_DEPTH];
 	uint16_t n_deq;
 	uint16_t i;
 	uint64_t full_ports_mask = 0;
@@ -373,28 +395,27 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 	if (unlikely(astate == NULL))
 		return;
 
+	/* Only one thread can refill at a time */
 	if (!rte_spinlock_trylock(&astate->refill_lock))
 		return;
 
-	/* 0. Detect migration in progress before hold buffer processing */
+	/* 0. Handle migration in progress before hold buffer processing */
 	if (astate->migration.in_progress) {
 		uint8_t mig_port = astate->migration.port_id;
 		uint64_t enq_cnt = astate->port_stats[mig_port].q_enqueued;
 		uint64_t ret_cnt = astate->port_stats[mig_port].q_returned;
 
+		/* Check if it is safe to migrate. i.e. no pending events */
 		if (enq_cnt == ret_cnt) {
 			uint64_t now = rte_get_timer_cycles();
-			uint64_t hz = rte_get_timer_hz();
-			uint64_t cooldown_cycles =
-				(hz * SLB_MIGRATION_COOLDOWN_MS) / 1000;
 			int target_port = slb_find_migration_target_port(
 				slb, queue, astate, mig_port, now,
-				cooldown_cycles);
+				slb->migration_cooldown_cycles);
 
 			if (target_port != -1)
 				slb_complete_flow_migration(
 					slb, astate, mig_port, target_port, now);
-			else {
+			else { /* If no suitable target port found, cancel migration */
 				astate->port_stats[mig_port].load_counter = 0;
 				slb->ports[mig_port].is_loaded = false;
 				astate->migration.in_progress = false;
@@ -402,10 +423,11 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 		}
 	}
 
+	/* Add the migration port to the full ports mask to avoid scheduling events to it */
 	if (astate->migration.in_progress)
 		full_ports_mask |= (1ULL << astate->migration.port_id);
 
-	/* 1. Process Hold Buffer first */
+	/* 1. Process Hold Buffer events */
 	if (astate->hold_count > 0) {
 		uint16_t retained = 0;
 		uint16_t count = astate->hold_count;
@@ -415,10 +437,12 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 			uint8_t dest_port_id = astate->hold_ports[i];
 			uint16_t burst_len = 1;
 
+			/* Collect consecutive events for the same destination port */
 			while ((i + burst_len) < count &&
 			       astate->hold_ports[i + burst_len] == dest_port_id)
 				burst_len++;
 
+			/* If destination port is full, retain the event in hold buffer*/
 			if (full_ports_mask & (1ULL << dest_port_id)) {
 				if (retained != i) {
 					memmove(&astate->hold_buffer[retained],
@@ -433,15 +457,18 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 				continue;
 			}
 
+			/* Enqueue events to the destination port */
 			uint16_t enqueued = rte_event_ring_enqueue_burst(
 				queue->per_port_rings[dest_port_id],
 				&astate->hold_buffer[i], burst_len, NULL);
 			astate->port_stats[dest_port_id].q_enqueued += enqueued;
 
+			/* If enqueue was successful then decrement the load counter */
 			if (enqueued > 0 &&
 			    astate->port_stats[dest_port_id].load_counter > 0)
 				astate->port_stats[dest_port_id].load_counter--;
 
+			/* If enqueue was not successful, retain the event in hold buffer */
 			if (enqueued < burst_len) {
 				uint16_t rem = burst_len - enqueued;
 				uint16_t start_idx = i + enqueued;
@@ -456,6 +483,7 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 						rem);
 				}
 				retained += rem;
+				/* If no events were enqueued, trigger migration */
 				if (enqueued == 0)
 					slb_check_and_trigger_migration(
 						slb, queue, astate, dest_port_id);
@@ -465,7 +493,11 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 		}
 
 		astate->hold_count = retained;
-		if (astate->hold_count > 0) {
+		/* Return without pulling events from main atomic queue
+		 * if hold buffer does not have enough free space.
+		 */
+		if (SLB_HOLD_BUFFER_SIZE - astate->hold_count <
+		    3 * RTE_DIM(rcv_events)) {
 			rte_spinlock_unlock(&astate->refill_lock);
 			return;
 		}
@@ -475,14 +507,13 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 	serving_mask = queue->serving_ports_mask;
 	num_serving_ports = queue->num_serving_ports;
 
-	if (num_serving_ports == 0) {
-		rte_spinlock_unlock(&astate->refill_lock);
-		return;
-	}
-
 	for (int iter = 0; iter < 2; iter++) {
+		if (SLB_HOLD_BUFFER_SIZE - astate->hold_count <
+		    RTE_DIM(rcv_events))
+			break;
+
 		n_deq = rte_event_ring_dequeue_burst(
-			queue->q_ring, master_events, RTE_DIM(master_events), NULL);
+			queue->q_ring, rcv_events, RTE_DIM(rcv_events), NULL);
 
 		if (n_deq == 0)
 			break;
@@ -494,14 +525,19 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 		struct rte_event sorted_events[SLB_MAX_PORT_DEQUEUE_DEPTH];
 		uint64_t batch_ports_mask = 0;
 
+		/* Dequeue events from main atomic queue, sort events,
+		 * enqueue events to destination port queues. If destination port queue
+		 * is full, retain events in hold buffer
+		 */
 		for (i = 0; i < n_deq; i++) {
-			struct rte_event *ev = &master_events[i];
+			struct rte_event *ev = &rcv_events[i];
 			uint32_t flow_idx = slb_flow_hash(ev->flow_id);
 			int32_t dest_port_id =
 				rte_atomic_load_explicit(
 					&astate->flow_map.flows[flow_idx].port_id,
 					rte_memory_order_acquire);
 
+			/* If flow is unmapped, map it to a port */
 			if (unlikely(dest_port_id == -1)) {
 				dest_port_id = slb_assign_unmapped_flow_port(
 					slb, astate, serving_mask, num_serving_ports);
@@ -514,6 +550,7 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 			dest_ports[i] = (uint8_t)dest_port_id;
 			uint64_t p_bit = (1ULL << dest_port_id);
 
+			/* Count events for each destination port */
 			if (!(batch_ports_mask & p_bit)) {
 				batch_ports_mask |= p_bit;
 				port_counts[dest_port_id] = 1;
@@ -525,6 +562,7 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 		uint16_t current_offset = 0;
 		uint64_t pmask = batch_ports_mask;
 
+		/* Calculate offsets for each destination port */
 		while (pmask != 0) {
 			uint8_t p = rte_ctz64(pmask);
 
@@ -534,10 +572,11 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 			current_offset += port_counts[p];
 		}
 
+		/* Sort events by destination port */
 		for (i = 0; i < n_deq; i++) {
 			uint8_t p = dest_ports[i];
 
-			sorted_events[insert_pos[p]++] = master_events[i];
+			sorted_events[insert_pos[p]++] = rcv_events[i];
 		}
 
 		pmask = batch_ports_mask;
@@ -548,40 +587,35 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 
 			pmask &= (pmask - 1);
 
+			/* If destination port is full, retain events in hold buffer */
 			if (full_ports_mask & (1ULL << p)) {
-				uint16_t space = SLB_HOLD_BUFFER_SIZE - astate->hold_count;
-				uint16_t to_copy = RTE_MIN(p_count, space);
-
-				if (to_copy > 0) {
-					rte_memcpy(&astate->hold_buffer[astate->hold_count],
-						   &sorted_events[p_start],
-						   to_copy * sizeof(struct rte_event));
-					memset(&astate->hold_ports[astate->hold_count], p, to_copy);
-					astate->hold_count += to_copy;
-				}
+				rte_memcpy(&astate->hold_buffer[astate->hold_count],
+					   &sorted_events[p_start],
+					   p_count * sizeof(struct rte_event));
+				memset(&astate->hold_ports[astate->hold_count], p, p_count);
+				astate->hold_count += p_count;
 				continue;
 			}
 
+			/* Enqueue events to the destination port */
 			uint16_t enqueued = rte_event_ring_enqueue_burst(
 				queue->per_port_rings[p], &sorted_events[p_start], p_count, NULL);
 			astate->port_stats[p].q_enqueued += enqueued;
 
+			/* If all events were enqueued successfully, decrement load counter */
 			if (enqueued == p_count) {
 				if (unlikely(astate->port_stats[p].load_counter > 0))
 					astate->port_stats[p].load_counter--;
 			} else {
 				uint16_t rem = p_count - enqueued;
-				uint16_t space = SLB_HOLD_BUFFER_SIZE - astate->hold_count;
-				uint16_t to_copy = RTE_MIN(rem, space);
-
+				/* Mark the destination port as full and retain remaining events */
 				full_ports_mask |= (1ULL << p);
-				if (to_copy > 0) {
-					rte_memcpy(&astate->hold_buffer[astate->hold_count],
-						   &sorted_events[p_start + enqueued],
-						   to_copy * sizeof(struct rte_event));
-					memset(&astate->hold_ports[astate->hold_count], p, to_copy);
-					astate->hold_count += to_copy;
-				}
+				rte_memcpy(&astate->hold_buffer[astate->hold_count],
+					   &sorted_events[p_start + enqueued],
+					   rem * sizeof(struct rte_event));
+				memset(&astate->hold_ports[astate->hold_count], p, rem);
+				astate->hold_count += rem;
+				/* If not a single event was enqueued, check for migration */
 				if (enqueued == 0)
 					slb_check_and_trigger_migration(
 						slb, queue, astate, p);
@@ -605,6 +639,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 	if (unlikely(events_len == 0))
 		return 0;
 
+	/* If operation types are not known, count them */
 	if (!op_types_known) {
 		for (uint16_t i = 0; i < events_len; i++) {
 			switch (events[i].op) {
@@ -621,7 +656,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 		}
 	}
 
-	/* Check credit threshold for NEW events */
+	/* Check credit threshold if there are NEW events */
 	if (num_new > 0) {
 		if (unlikely(rte_atomic_load_explicit(&slb->credits_on_loan,
 						      rte_memory_order_relaxed) >
@@ -633,32 +668,38 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 			return 0;
 	}
 
+	/* Return credits for RELEASE events */
 	if (num_release > 0)
 		slb_port_return_credits(slb, source_port, num_release);
 
+	/* Check for release underflow and balance pending releases */
 	cur_pending = source_port->pending_releases;
 	RTE_VERIFY(num_forward + num_release <= cur_pending);
+	source_port->pending_releases = cur_pending - (num_forward + num_release);
 
 	slb_port_enqueue_stats(source_port, num_new, num_forward, num_release);
 
-	/* Unified zero-copy fast path: when port has no in-flight ordered/atomic events
-	 * and no release ops.
+	/* Unified zero-copy fast path: when burst does not have past ordered/atomic
+	 * events being forwarded and there are no RELEASE events. This means no
+	 * history list entries are present.
 	 */
 	if (likely(source_port->history_avail == SLB_PORT_HISTORY_MAX_TOKENS &&
 		   num_release == 0)) {
 		uint8_t q0 = events[0].queue_id;
 		uint16_t burst_size = 1;
 
+		/* Collect events going to the same queue in a burst */
 		while (burst_size < events_len &&
 		       events[burst_size].queue_id == q0)
 			burst_size++;
 
+		/* Enqueue the entire burst if going to the same queue */
 		if (likely(burst_size == events_len)) {
 			rte_event_ring_enqueue_burst(slb->queues[q0].q_ring,
 						     events, events_len, NULL);
 			slb_port_queue_enqueue_burst_stats(source_port, q0,
 							   events_len);
-		} else {
+		} else { /* Sort events by destination queue */
 			uint8_t dest_queues[SLB_MAX_PORT_ENQUEUE_DEPTH];
 			uint16_t queue_counts[SLB_MAX_QUEUES];
 			uint16_t insert_pos[SLB_MAX_QUEUES];
@@ -701,6 +742,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				sorted_events[insert_pos[q]++] = events[k];
 			}
 
+			/* Enqueue events to their respective queues */
 			qmask = batch_queues_mask;
 			while (qmask != 0) {
 				uint8_t q = rte_ctz64(qmask);
@@ -716,15 +758,12 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 			}
 		}
 
-		if (num_forward > 0)
-			source_port->pending_releases -= num_forward;
-
 		SLB_LOG_DP_PORT_LINE(DEBUG, source_port->id,
 				     "%d events accepted.", events_len);
 		return events_len;
 	}
 
-	/* General path for bursts with in-flight ordered/atomic events or releases */
+	/* General path for bursts with any mix of events */
 	uint64_t ordered_drain_mask = 0;
 	uint16_t freed_count = 0;
 	uint16_t head = source_port->history_head;
@@ -733,14 +772,19 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 	const struct rte_event *enq_events[SLB_MAX_PORT_ENQUEUE_DEPTH];
 	uint16_t queue_counts[SLB_MAX_QUEUES];
 	uint64_t batch_queues_mask = 0;
+	bool has_history = (source_port->history_avail <
+			    SLB_PORT_HISTORY_MAX_TOKENS);
 
 	for (uint16_t idx = 0; idx < events_len; idx++) {
 		const struct rte_event *ev = &events[idx];
-		uint8_t h_idx = (ev->op != RTE_EVENT_OP_NEW) ? ev->impl_opaque : 0;
+		/* History list index 0 is used by NEW, parallel, and single-link events */
+		uint8_t h_idx = (has_history && ev->op != RTE_EVENT_OP_NEW) ?
+				ev->impl_opaque : 0;
 		struct slb_history_entry *hist =
 			(h_idx != 0 && source_port->history[h_idx].active) ?
 			&source_port->history[h_idx] : NULL;
 
+		/* Ordered event is being forwarded/released. */
 		if (hist != NULL && hist->sched_type == RTE_SCHED_TYPE_ORDERED) {
 			struct slb_queue *orig_q = &slb->queues[hist->orig_queue_id];
 
@@ -748,26 +792,32 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				uint16_t slot = hist->seq_slot;
 
 				if (ev->op == RTE_EVENT_OP_RELEASE) {
+					/* Release the reorder buffer entry */
 					rte_atomic_store_explicit(
 						&orig_q->reorder_buffer[slot].state,
 						SLB_REORDER_RELEASED,
 						rte_memory_order_release);
 				} else {
+					/* Put event in reorder buffer */
 					orig_q->reorder_buffer[slot].event = *ev;
 					rte_atomic_store_explicit(
 						&orig_q->reorder_buffer[slot].state,
 						SLB_REORDER_READY,
 						rte_memory_order_release);
 				}
+				/* Mark the ordered queue for draining */
 				ordered_drain_mask |= (1ULL << hist->orig_queue_id);
 			}
+			/* Free the history entry */
 			hist->active = false;
 			hist->next_free = head;
 			head = h_idx;
 			freed_count++;
 			slb_port_queue_enqueue_stats(source_port, ev->queue_id);
 		} else if (ev->op == RTE_EVENT_OP_RELEASE) {
+			/* Atomic or parallel event being released */
 			if (hist != NULL) {
+				/* Count atomic events being returned */
 				if (hist->sched_type == RTE_SCHED_TYPE_ATOMIC) {
 					struct slb_queue *orig_q =
 						&slb->queues[hist->orig_queue_id];
@@ -776,6 +826,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 						orig_q->atomic_state->port_stats[ep].q_returned++;
 					}
 				}
+				/* Free the history entry */
 				hist->active = false;
 				hist->next_free = head;
 				head = h_idx;
@@ -783,7 +834,9 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 			}
 			slb_port_queue_enqueue_stats(source_port, ev->queue_id);
 		} else {
+			/* Atomic/Parallel event being forwarded*/
 			if (hist != NULL) {
+				/* Count atomic events being returned */
 				if (hist->sched_type == RTE_SCHED_TYPE_ATOMIC) {
 					struct slb_queue *orig_q =
 						&slb->queues[hist->orig_queue_id];
@@ -792,6 +845,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 						orig_q->atomic_state->port_stats[ep].q_returned++;
 					}
 				}
+				/* Free the history entry */
 				hist->active = false;
 				hist->next_free = head;
 				head = h_idx;
@@ -805,6 +859,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 			enq_events[n_enq] = ev;
 			n_enq++;
 
+			/* Count the number of events going to each queue */
 			if (!(batch_queues_mask & q_bit)) {
 				batch_queues_mask |= q_bit;
 				queue_counts[qid] = 1;
@@ -814,9 +869,10 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 		}
 	}
 
-	if (n_enq > 0) {
+	if (n_enq > 0) { /* There are events to enqueue */
 		if (likely((batch_queues_mask & (batch_queues_mask - 1)) == 0 &&
 			   n_enq == events_len)) {
+			/* Entire batch is going to a single queue */
 			uint8_t q = rte_ctz64(batch_queues_mask);
 
 			rte_event_ring_enqueue_burst(slb->queues[q].q_ring,
@@ -830,6 +886,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 			uint16_t current_offset = 0;
 			uint64_t qmask = batch_queues_mask;
 
+			/* Calculate the offset for each queue */
 			while (qmask != 0) {
 				uint8_t q = rte_ctz64(qmask);
 
@@ -839,12 +896,14 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				current_offset += queue_counts[q];
 			}
 
+			/* Sort events by queue */
 			for (uint16_t k = 0; k < n_enq; k++) {
 				uint8_t q = dest_queues[k];
 
 				sorted_events[insert_pos[q]++] = *enq_events[k];
 			}
 
+			/* Enqueue events for each queue */
 			qmask = batch_queues_mask;
 			while (qmask != 0) {
 				uint8_t q = rte_ctz64(qmask);
@@ -861,11 +920,13 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 		}
 	}
 
+	/* Update the history list head once after all frees*/
 	if (freed_count > 0) {
 		source_port->history_head = head;
 		source_port->history_avail += freed_count;
 	}
 
+	/* If events are added to reorder buffers, call the drain function */
 	while (ordered_drain_mask != 0) {
 		uint8_t qid = rte_ctz64(ordered_drain_mask);
 
@@ -873,14 +934,12 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 		slb_reorder_drain(slb, &slb->queues[qid]);
 	}
 
-	if (num_forward + num_release > 0)
-		source_port->pending_releases -= (num_forward + num_release);
-
 	SLB_LOG_DP_PORT_LINE(DEBUG, source_port->id,
 			     "%d events accepted.", events_len);
 	return events_len;
 }
 
+/* Enqueue burst of mix event type. (NEW, FORWARDED, RELEASED) */
 uint16_t
 slb_event_enqueue_burst(void *port, const struct rte_event events[],
 			uint16_t events_len)
@@ -891,6 +950,7 @@ slb_event_enqueue_burst(void *port, const struct rte_event events[],
 					       false, 0, 0, 0);
 }
 
+/* Enqueue burst of all new events */
 uint16_t
 slb_event_enqueue_new_burst(void *port, const struct rte_event events[],
 			    uint16_t events_len)
@@ -901,6 +961,7 @@ slb_event_enqueue_new_burst(void *port, const struct rte_event events[],
 					       true, events_len, 0, 0);
 }
 
+/* Enqueue burst of all forwarded events */
 uint16_t
 slb_event_enqueue_forward_burst(void *port, const struct rte_event events[],
 				uint16_t events_len)
@@ -911,6 +972,9 @@ slb_event_enqueue_forward_burst(void *port, const struct rte_event events[],
 					       true, 0, events_len, 0);
 }
 
+/* Dequeue events from an ordered queue. Event's slot in the ring is
+ * used as its sequence number
+ */
 static inline uint16_t
 slb_ordered_ring_dequeue_burst(struct rte_event_ring *r,
 			       struct rte_event *events,
@@ -936,6 +1000,7 @@ slb_ordered_ring_dequeue_burst(struct rte_event_ring *r,
 	return n;
 }
 
+/* Create history entries for events dequeued from a queue_id of type sched_type */
 static inline void
 slb_port_record_dequeued_history(struct slb_port *port, struct rte_event events[],
 				 uint16_t dequeued, uint8_t queue_id,
@@ -965,35 +1030,31 @@ slb_port_record_dequeued_history(struct slb_port *port, struct rte_event events[
 	port->history_avail -= dequeued;
 }
 
+/* Dequeue events from the port */
 static inline uint16_t
 slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 		 uint16_t num)
 {
 	uint16_t dequeued = 0;
 
+	/* If port is single-linked, it is simple dequeue from the linked queue */
 	if (port->is_single_linked) {
 		if (unlikely(port->single_linked_ring == NULL))
 			return 0;
 		dequeued = rte_event_ring_dequeue_burst(port->single_linked_ring,
 							events, num, NULL);
-		for (uint16_t j = 0; j < dequeued; j++) {
-			events[j].sched_type = RTE_SCHED_TYPE_ATOMIC;
+		for (uint16_t j = 0; j < dequeued; j++)
 			events[j].impl_opaque = 0;
-		}
 		return dequeued;
 	}
 
-	uint64_t active_queues = rte_atomic_load_explicit(
-		&port->active_queues, rte_memory_order_acquire);
-	if (!active_queues)
-		return 0;
-
 	for (int pr = 0; pr < SLB_MAX_PRIORITIES; pr++) {
 		int slots = port->num_q[pr];
 
 		if (slots == 0)
-			continue;
+			continue; /* No queues mapped at this priority */
 
+		/* Start from where we left off */
 		int start = port->next_q[pr];
 
 		if (unlikely(start >= slots))
@@ -1007,25 +1068,18 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 
 			struct slb_port_q_entry *qent = &port->q_entries[pr][idx];
 			uint8_t queue_id = qent->queue_id;
-
-			if (!((active_queues >> queue_id) & 1))
-				continue;
-
 			struct rte_event_ring *ring_to_dq = qent->dq_ring;
 
 			if (unlikely(ring_to_dq == NULL))
 				continue;
 
 			uint8_t sched_type = qent->schedule_type;
-			bool is_single_link = qent->is_single_link;
-			bool is_ordered = !is_single_link &&
-					  (sched_type == RTE_SCHED_TYPE_ORDERED);
-			bool is_atomic = !is_single_link &&
-					 (sched_type == RTE_SCHED_TYPE_ATOMIC);
+			bool is_ordered = (sched_type == RTE_SCHED_TYPE_ORDERED);
+			bool is_atomic = (sched_type == RTE_SCHED_TYPE_ATOMIC);
 
 			if (is_ordered || is_atomic) {
 				if (unlikely(port->history_avail == 0))
-					continue;
+					continue; /* No available history entries */
 
 				uint16_t dequeue_num = RTE_MIN(num,
 							       port->history_avail);
@@ -1035,11 +1089,12 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 					dequeued = slb_ordered_ring_dequeue_burst(
 						ring_to_dq, events, dequeue_num,
 						&start_slot);
-				} else {
+				} else { /* Atomic queue */
 					dequeued = rte_event_ring_dequeue_burst(
 						ring_to_dq, events, dequeue_num,
 						NULL);
 					if (dequeued == 0) {
+						/* Per port queue is empty, call for refill */
 						slb_atomic_refill(port, qent->queue);
 						dequeued = rte_event_ring_dequeue_burst(
 							ring_to_dq, events, dequeue_num,
@@ -1047,26 +1102,22 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 					}
 				}
 
+				/* Create history entries for dequeued events */
 				if (dequeued > 0)
 					slb_port_record_dequeued_history(
 						port, events, dequeued, queue_id,
 						sched_type, start_slot,
 						ring_to_dq->r.mask);
-			} else {
+			} else { /* Parallel queue */
 				dequeued = rte_event_ring_dequeue_burst(
 					ring_to_dq, events, num, NULL);
-				if (is_single_link) {
-					for (uint16_t j = 0; j < dequeued; j++) {
-						events[j].sched_type =
-							RTE_SCHED_TYPE_ATOMIC;
-						events[j].impl_opaque = 0;
-					}
-				} else {
-					for (uint16_t j = 0; j < dequeued; j++)
-						events[j].impl_opaque = 0;
-				}
+				for (uint16_t j = 0; j < dequeued; j++)
+					events[j].impl_opaque = 0;
 			}
 
+			/* If dequeued non-zero events successfully, move to the next queue
+			 * for the next dequeue call and return
+			 */
 			if (dequeued > 0) {
 				idx++;
 				port->next_q[pr] = (idx >= slots) ? 0 : idx;
@@ -1077,6 +1128,7 @@ slb_port_dequeue(struct slb_port *port, struct rte_event events[],
 	return 0;
 }
 
+/* Process pending releases for the port */
 static inline void
 slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 				  uint16_t pending)
@@ -1084,10 +1136,14 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 	uint16_t head;
 	uint64_t ordered_drain_mask = 0;
 
+	slb_port_return_credits(slb, port, pending);
+	port->pending_releases = 0;
+
 	if (port->is_single_linked ||
 	    port->history_avail >= SLB_PORT_HISTORY_MAX_TOKENS)
-		goto done;
+		return;
 
+	/* Process all history entries */
 	head = port->history_head;
 	for (int i = 1; i < SLB_PORT_HISTORY_SIZE; i++) {
 		struct slb_history_entry *hist = &port->history[i];
@@ -1095,6 +1151,7 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 		if (!hist->active)
 			continue;
 
+		/* Ordered releases will free the reorder buffer slot*/
 		if (hist->sched_type == RTE_SCHED_TYPE_ORDERED) {
 			struct slb_queue *oq = &slb->queues[hist->orig_queue_id];
 
@@ -1106,6 +1163,7 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 				ordered_drain_mask |= (1ULL << hist->orig_queue_id);
 			}
 		} else if (hist->sched_type == RTE_SCHED_TYPE_ATOMIC) {
+			/* Atomic releases are counted as returned events */
 			struct slb_queue *oq = &slb->queues[hist->orig_queue_id];
 
 			if (oq->atomic_state) {
@@ -1114,6 +1172,7 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 				oq->atomic_state->port_stats[ep].q_returned++;
 			}
 		}
+		/* Free the history entries */
 		hist->active = false;
 		hist->next_free = head;
 		head = (uint16_t)i;
@@ -1121,18 +1180,16 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 	}
 	port->history_head = head;
 
+	/* If there are ordered releases, call the reorder drain function */
 	while (ordered_drain_mask != 0) {
 		uint8_t qid = rte_ctz64(ordered_drain_mask);
 
 		ordered_drain_mask &= ~(1ULL << qid);
 		slb_reorder_drain(slb, &slb->queues[qid]);
 	}
-
-done:
-	slb_port_return_credits(slb, port, pending);
-	port->pending_releases = 0;
 }
 
+/* Eventdev dequeue burst function */
 uint16_t
 slb_event_dequeue_burst(void *p, struct rte_event events[], uint16_t num,
 			uint64_t wait __rte_unused)
@@ -1142,6 +1199,7 @@ slb_event_dequeue_burst(void *p, struct rte_event events[], uint16_t num,
 	uint16_t pending = port->pending_releases;
 	uint16_t n;
 
+	/* Handle pending releases */
 	if (port->implicit_release && pending > 0)
 		slb_port_process_implicit_release(port, slb, pending);
 
diff --git a/drivers/event/slb/slb_selftest.c b/drivers/event/slb/slb_selftest.c
index 776b6d6ab4..4a072b811b 100644
--- a/drivers/event/slb/slb_selftest.c
+++ b/drivers/event/slb/slb_selftest.c
@@ -362,12 +362,6 @@ test_ordered_forward(void)
 					     cons_rx, rx[i].u64);
 				return -1;
 			}
-			if (rx[i].sched_type != RTE_SCHED_TYPE_ATOMIC) {
-				SLB_LOG_LINE(ERR,
-					     "Single-link dequeue sched_type expected %u, got %u",
-					     RTE_SCHED_TYPE_ATOMIC, rx[i].sched_type);
-				return -1;
-			}
 			cons_rx++;
 			rx[i].op = RTE_EVENT_OP_RELEASE;
 		}
@@ -422,12 +416,6 @@ test_single_link(void)
 	for (i = 0; i < 16; i++) {
 		if (rx[i].u64 != (uint64_t)(5000 + i))
 			return -1;
-		if (rx[i].sched_type != RTE_SCHED_TYPE_ATOMIC) {
-			SLB_LOG_LINE(ERR,
-				     "Single-link dequeue sched_type expected %u, got %u",
-				     RTE_SCHED_TYPE_ATOMIC, rx[i].sched_type);
-			return -1;
-		}
 		rx[i].op = RTE_EVENT_OP_RELEASE;
 	}
 	rte_event_enqueue_burst(g_dev_id, PORT_CONS, rx, 16);
-- 
2.53.0

