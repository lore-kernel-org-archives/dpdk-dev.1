Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61A606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yIkdNOKB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D066F4067C;
	Tue, 17 Nov 2026 18:57:37 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 2F04D40655
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:57:34 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-91ec2d42231so63008286d6.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794938253; x=1795543053; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AjBN8n36VnYRFcQsyzgL5w3mlBZtMEG1gq5mOTw7uvw=;
 b=yIkdNOKBzri9TGX6JNL7ZE2geaf7RdT0ilNKOPs9NAHSwWpwpSBjSzMwL+FYjAIp5M
 twv+o32r0ljSRd9PygEFexNKRtpOlKaNp1GkyE6iWDeSaUpT+hGYhJIvk09F1R1Gk2hQ
 7VXO00AcgH6LZ9U3uOlWejyiIyJUe44tgWkOkjGULQb0yrmSAXcr+U2EpR7sRmLLu7Ow
 wOb4+rBc22VbTrjiFgT6xk3xcV7ocn5Tsr/Y/LXHbVBtb2mjRICkHG51uxYJjl6Epo/b
 vvJX7fJUzh0NBrdyCB3AFHvI89f17JVgmGh2emgEEvB3sh/kgWKvkOUE8epHxT6kQ9ml
 I1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938253; x=1795543053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AjBN8n36VnYRFcQsyzgL5w3mlBZtMEG1gq5mOTw7uvw=;
 b=Dm10sX02HV9Nt4GwKgZ9JjPFXRQfKPt1qp7qnCg1cbavW7DLJVZaJXETfltUf2qCCX
 NjUlprfZOUmh5Hx7UFzAs5UK5QNlkZIk9J8uIK7cwreqOIiBiQuv2vsPbxBSd2vDQaN0
 eaxP3hhOz9jNKm645ddPa3G5Y54pRvw6xlDj8L/upChgsNUqO89uiHzgjgnQNq1/e7/j
 YTu2NVoTpoFp9UoNKlrIsrENhOJV5zhYGJERRifppz0yzxxOWKVMzrqaeKnw74ZPCRXr
 B6VklE3uz7ZWN1aDCRtoGsJyHJc68TOLXgSpAM620E3B2wC3K+v2MKjH5z/UykC3WTPC
 Ve7Q==
X-Gm-Message-State: APuU4Z++7e7ndQDLv3sqRXnx3X2D++p8lTlbdSj8VtO3X84ySEkZX3Gq
 ZCFDQc9smvwT/k7DoSy803Dc2US12oyEkCK/NKS5TK8uXU4PEIueA2cdoud8tUYs
X-Gm-Gg: AZFdTZccJTorUJr6G3JqMshatrBjMhBV7dgi8WjGXAI1Vc28QwMguXGeYvC0rhAnIAg
 DKRhirWHoJd2VHIne0xkav7zLexLY0ofN1JcTHafeX/XWArT1xZTj0OkCeqjTZQwMof1epxfd41
 eGwjNZ4QuuEIRvXuxLf3OediwMZt3C4p7SVRIeCOOl5vTM9bvSKe7IIXlfRN+rXbym3DIwEYa88
 FJStdwB4yvd5OM4Pd/2AHTOJgWD6/KWtZY4fGte9A1E3GX0wxXtmDCrk/AkmXN5Hbvcr/6DmqqY
 nAXIiADvI0ykRDgQGa1eT/JlgAoyLDuyeZ6JiNYviNkVWk5ZVqozeTLgrasSpul72SD263z377K
 qYH+ZMj1HPdnnHkl5oIhD4/9c7wNrPzvsdbZE2Qe166ybGv3tmUwJKZDmaLTrfK04ahzKHtn0VR
 u3uR09maDDlp9uJ2AagtIWVc+KWOdPa9nlqOHjCZyFk0a9d1Kg5cja5Dik8j7gwpmHTuZ3OZBcO
 aJwJXf3P5/sMRe10bjf5cXL3z1BnMAB7/GlIJelG1oeDvzp8qn0SNU3yUWWr3xCj7upG2sSh1Pq
 AzqdYGhY8I5zhq/x8srkFyM8NzFCE4qMPPuWiUFHP3wW4B4Qht/jg2Ch3v0lYPdqMhKIICRwemt
 5S1xy2P4XUPDBomB6pD2j4I6dlJ7N8+okZ2NHofb4cg9nY/bi8GXX
X-Received: by 2002:a05:6214:4117:b0:921:47e:e053 with SMTP id
 6a1803df08f44-921047ee108mr35199206d6.53.1794938252647; 
 Tue, 17 Nov 2026 09:57:32 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c29f7.dyn.optonline.net. [148.76.41.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921148c261bsm327426d6.0.2026.11.17.09.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:57:32 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 david.marchand@redhat.com, nipun.gupta@amd.com, chenbox@nvidia.com,
 tirthendu.sarkar@intel.com, mattias.ronnblom@ericsson.com,
 stephen@networkplumber.org, Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v2 8/8] event/slb: address ARM64 build and all code reviews
Date: Tue, 17 Nov 2026 12:57:08 -0500
Message-ID: <20261117175709.2346400-9-pravinpathakdev@gmail.com>
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

- Add missing standard C headers (<stdio.h>, <stdlib.h>, <string.h>)
  to fix implicit declaration of abs() on ARM64 builds.
- Defer credit return for released ordered events until
  slb_reorder_drain() reclaims the reorder buffer slot so the ordered
  queue ring cannot wrap onto an undrained slot.
- Re-check buf[drain_idx].state after unlocking queue->reorder_lock in
  slb_reorder_drain() to prevent a lost wakeup when another port marks
  drain_idx READY/RELEASED and fails trylock just before unlock.
- Use release memory ordering when resetting reorder buffer slots to
  SLB_REORDER_EMPTY and assert queue ring enqueue burst counts.
- Set default new_event_threshold to 3/4 of SLB_IN_RING_SIZE and check
  new_event_threshold inside slb_port_acquire_credits() only when
  borrowing from the central pool after checking the port's local
  credit cache.
- Return 0 with rte_errno set to EINVAL/ENOSPC on release underflow or
  credit exhaustion instead of aborting with RTE_VERIFY().
- Widen hold_count to uint32_t, clamp hold buffer copy lengths, and
  define SLB_HOLD_BUFFER_REFILL_HEADROOM.
- Widen timer frequency multiplication for migration cooldown cycles
  and avoid unsigned subtraction underflow in cooldown checks.
- Clean up queue resources via slb_queue_release() on setup failure
  and unlink all port references (both single-link and q_entries) on
  queue release.
- Guard against NULL q->q_ring in slb_dump() when dumping unconfigured
  queues.
- Make internal functions (slb_dump, slb_reorder_drain,
  slb_port_return_credits) static and update SLB documentation and
  26.11 release notes.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 doc/guides/eventdevs/slb.rst           |  14 +-
 doc/guides/rel_notes/release_26_11.rst |   7 +
 drivers/event/slb/slb_evdev.c          | 129 +++++++++------
 drivers/event/slb/slb_evdev.h          |  19 +--
 drivers/event/slb/slb_event.c          | 219 +++++++++++++++++--------
 drivers/event/slb/slb_xstats.c         |   1 +
 6 files changed, 248 insertions(+), 141 deletions(-)

diff --git a/doc/guides/eventdevs/slb.rst b/doc/guides/eventdevs/slb.rst
index b109a1e2ca..73c0491045 100644
--- a/doc/guides/eventdevs/slb.rst
+++ b/doc/guides/eventdevs/slb.rst
@@ -56,6 +56,14 @@ Limitations
 -----------
 
 * **Maximum Ports and Queues**: Supports up to 64 ports and 64 queues.
-* **Priorities and linking**: Supports two levels of service priority to link up to
-  eight queues per port at each priority. SLB currently does not support event priority.
-* **Queues Types**: Does not support all-type queues.
+* **Priorities and linking**: Priority is configured per port-to-queue link via
+  ``rte_event_port_link()`` (supports two service priority levels, configured at compile time
+  via ``SLB_MAX_PRIORITIES``). SLB does not support per-queue priority
+  (``RTE_EVENT_DEV_CAP_QUEUE_QOS``), per-event priority (``RTE_EVENT_DEV_CAP_EVENT_QOS``),
+  or runtime port linking/unlinking after device start (``RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK``).
+* **Queues Types**: Does not support all-types queues (``RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPES``).
+* **In-Flight Event Limit**: Each port maintains a local cache of up to ``SLB_PORT_MAX_CREDITS``
+  credits. To avoid credit-cache starvation when ``nb_events_limit`` is configured smaller than
+  ``nb_event_ports * SLB_PORT_MAX_CREDITS``, SLB raises the internal credit pool size to
+  ``max(nb_events_limit, nb_event_ports * SLB_PORT_MAX_CREDITS)`` (capped at ``SLB_MAX_EVENTS``),
+  so the device may hold more in-flight events than the configured ``nb_events_limit``.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8ca8379cc6..1548ef0f15 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -312,6 +312,13 @@ New Features
   with AMD-specific hardware access, a primary/secondary topology
   and a packed scratchpad handshake.
 
+* **Added Software Load Balancer (SLB) eventdev PMD.**
+
+  Introduced a new poll-mode eventdev driver (``event_slb``) supporting
+  parallel, atomic, ordered, and single-link scheduling with dynamic
+  atomic flow migration and strict two-level port-queue service priorities.
+  Runtime port linking and unlinking after device start is not supported.
+
 * **Supported auto-detection of uncore power driver.**
 
   The uncore power library got automatic probing of multiple uncore drivers
diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
index 346b4b38ed..f47e08b3f9 100644
--- a/drivers/event/slb/slb_evdev.c
+++ b/drivers/event/slb/slb_evdev.c
@@ -3,6 +3,9 @@
  */
 
 #include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <inttypes.h>
 #include <rte_bitops.h>
 #include <rte_cycles.h>
@@ -104,7 +107,7 @@ slb_port_def_conf(struct rte_eventdev *dev,
 		  uint8_t port_id __rte_unused,
 		  struct rte_event_port_conf *port_conf)
 {
-	int32_t threshold = SLB_IN_RING_SIZE / 4;
+	int32_t threshold = (3 * SLB_IN_RING_SIZE) / 4;
 
 	if (dev->data->dev_conf.nb_events_limit > 0 &&
 	    threshold > dev->data->dev_conf.nb_events_limit)
@@ -122,6 +125,33 @@ slb_port_release(void *p __rte_unused)
 {
 }
 
+static void
+slb_port_unlink_queue_from_prio(struct slb_port *port, int prio, int slot)
+{
+	/* Shift the queue entries to overwriting the unlinked queue slot */
+	for (int k = slot; k < port->num_q[prio] - 1; k++)
+		port->q_entries[prio][k] = port->q_entries[prio][k + 1];
+
+	/* Decrement mapped queue count and Clear the last slot after shifting */
+	port->num_q[prio]--;
+	memset(&port->q_entries[prio][port->num_q[prio]], 0,
+	       sizeof(struct slb_port_q_entry));
+	/* Adjust the next queue index if it points beyond the new count */
+	if (port->next_q[prio] >= port->num_q[prio])
+		port->next_q[prio] = 0;
+}
+
+/* Find the slot of a queue in a specific priority level, returning -1 if not found */
+static int
+slb_port_find_queue_slot(struct slb_port *port, int prio, uint8_t qid)
+{
+	for (int s = 0; s < port->num_q[prio]; s++) {
+		if (port->q_entries[prio][s].queue_id == qid)
+			return s;
+	}
+	return -1;
+}
+
 /* Called to free queue resources on device close or reconfiguration */
 static void
 slb_queue_release(struct rte_eventdev *dev, uint8_t queue_id)
@@ -129,6 +159,26 @@ slb_queue_release(struct rte_eventdev *dev, uint8_t queue_id)
 	struct slb_evdev *slb = slb_pmd_priv(dev);
 	struct slb_queue *queue = &slb->queues[queue_id];
 
+	/* Unlink any port references before freeing queue rings */
+	for (int i = 0; i < slb->num_ports; i++) {
+		struct slb_port *port = &slb->ports[i];
+
+		if (port->single_linked_q == queue) {
+			port->single_linked_q = NULL;
+			port->single_linked_ring = NULL;
+		} else {
+			for (int pr = 0; pr < SLB_MAX_PRIORITIES; pr++) {
+				int slot = slb_port_find_queue_slot(
+					port, pr, queue_id);
+				if (slot >= 0)
+					slb_port_unlink_queue_from_prio(
+						port, pr, slot);
+			}
+		}
+	}
+	queue->serving_ports_mask = 0;
+	queue->num_serving_ports = 0;
+
 	if (queue->atomic_state) {
 		rte_free(queue->atomic_state);
 		queue->atomic_state = NULL;
@@ -160,6 +210,7 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 	struct slb_queue *queue = &slb->queues[queue_id];
 	struct rte_event_ring *ring;
 	char ring_name[RTE_RING_NAMESIZE];
+	unsigned int ring_flags = RING_F_EXACT_SZ;
 	uint32_t q_size = (slb->max_inflight > 0) ?
 			  (uint32_t)slb->max_inflight : SLB_IN_RING_SIZE;
 
@@ -172,25 +223,23 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 	if (conf->event_queue_cfg & RTE_EVENT_QUEUE_CFG_SINGLE_LINK) {
 		/* MP -> SC ring for single-link queues */
 		queue->is_single_link = true;
-		ring = rte_event_ring_create(ring_name, q_size,
-			dev->data->socket_id, RING_F_SC_DEQ | RING_F_EXACT_SZ);
+		ring_flags |= RING_F_SC_DEQ;
 	} else if (conf->schedule_type == RTE_SCHED_TYPE_ATOMIC) {
 		/* MP -> SC ring for atomic queues main ring */
 		queue->is_single_link = false;
-		ring = rte_event_ring_create(ring_name, q_size,
-			dev->data->socket_id, RING_F_SC_DEQ | RING_F_EXACT_SZ);
+		ring_flags |= RING_F_SC_DEQ;
 	} else if (conf->schedule_type == RTE_SCHED_TYPE_PARALLEL ||
 		   conf->schedule_type == RTE_SCHED_TYPE_ORDERED) {
 		/* MP -> MC ring for parallel or ordered queues */
 		queue->is_single_link = false;
-		ring = rte_event_ring_create(ring_name, q_size,
-			dev->data->socket_id, RING_F_EXACT_SZ);
 	} else {
 		SLB_LOG_DP_LINE(ERR, "Unsupported schedule_type %u",
 				conf->schedule_type);
 		return -ENOTSUP;
 	}
 
+	ring = rte_event_ring_create(ring_name, q_size, dev->data->socket_id,
+				     ring_flags);
 	if (ring == NULL)
 		return -ENOMEM;
 
@@ -209,7 +258,7 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 			sizeof(struct slb_atomic_state),
 			RTE_CACHE_LINE_SIZE, dev->data->socket_id);
 		if (queue->atomic_state == NULL) {
-			rte_event_ring_free(ring);
+			slb_queue_release(dev, queue_id);
 			return -ENOMEM;
 		}
 		for (int i = 0; i < SLB_ATOMIC_FLOWS; i++)
@@ -236,7 +285,7 @@ slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
 			sizeof(struct slb_reorder_entry) * ring->r.size,
 			RTE_CACHE_LINE_SIZE, dev->data->socket_id);
 		if (queue->reorder_buffer == NULL) {
-			rte_event_ring_free(ring);
+			slb_queue_release(dev, queue_id);
 			return -ENOMEM;
 		}
 		queue->reorder_drain_idx = 0;
@@ -261,33 +310,6 @@ slb_queue_def_conf(struct rte_eventdev *dev __rte_unused,
 	};
 }
 
-static void
-slb_port_unlink_queue_from_prio(struct slb_port *port, int prio, int slot)
-{
-	/* Shift the queue entries to overwriting the unlinked queue slot */
-	for (int k = slot; k < port->num_q[prio] - 1; k++)
-		port->q_entries[prio][k] = port->q_entries[prio][k + 1];
-
-	/* Decrement mapped queue count and Clear the last slot after shifting */
-	port->num_q[prio]--;
-	memset(&port->q_entries[prio][port->num_q[prio]], 0,
-	       sizeof(struct slb_port_q_entry));
-	/* Adjust the next queue index if it points beyond the new count */
-	if (port->next_q[prio] >= port->num_q[prio])
-		port->next_q[prio] = 0;
-}
-
-/* Find the slot of a queue in a specific priority level, returning -1 if not found */
-static int
-slb_port_find_queue_slot(struct slb_port *port, int prio, uint8_t qid)
-{
-	for (int s = 0; s < port->num_q[prio]; s++) {
-		if (port->q_entries[prio][s].queue_id == qid)
-			return s;
-	}
-	return -1;
-}
-
 /* Link a queue to a port at a specific priority level */
 static int
 slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
@@ -303,15 +325,14 @@ slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
 			rte_errno = EINVAL;
 			return -EINVAL;
 		}
-		/* Only one queue can be linked to a single-linked port */
-		if (port->single_linked_q != NULL) {
-			if (port->single_linked_q == queue)
-				return 0;
-			rte_errno = EINVAL;
-			return -EINVAL;
-		}
-		/* A single-link queue can only be linked to one port */
-		if (queue->serving_ports_mask != 0) {
+		/* Re-linking the same queue to the same port is a no-op */
+		if (port->single_linked_q == queue)
+			return 0;
+		/* Only one queue can be linked to a single-linked port, and a
+		 * single-link queue can only be linked to one port.
+		 */
+		if (port->single_linked_q != NULL ||
+		    queue->serving_ports_mask != 0) {
 			rte_errno = EINVAL;
 			return -EINVAL;
 		}
@@ -476,7 +497,7 @@ slb_info_get(struct rte_eventdev *dev __rte_unused,
 		.driver_name = SLB_PMD_NAME,
 		.max_event_queues = SLB_MAX_QUEUES,
 		.max_event_queue_flows = SLB_MAX_FLOWS,
-		.max_event_queue_priority_levels = SLB_MAX_PRIORITIES,
+		.max_event_queue_priority_levels = 1,
 		.max_event_priority_levels = 1,
 		.max_event_ports = SLB_MAX_PORTS,
 		.max_event_port_dequeue_depth = SLB_MAX_PORT_DEQUEUE_DEPTH,
@@ -534,14 +555,14 @@ slb_configure(const struct rte_eventdev *dev)
 	slb->num_queues = conf->nb_event_queues;
 
 	/* Compute minimum credits required to avoid deadlock */
-	min_max_in_flight = conf->nb_event_ports * SLB_PORT_MAX_CREDITS;
+	min_max_in_flight = (int32_t)conf->nb_event_ports * SLB_PORT_MAX_CREDITS;
 	if (min_max_in_flight > SLB_MAX_EVENTS)
 		min_max_in_flight = SLB_MAX_EVENTS;
 
 	/* Set credit pool size to max of nb_events_limit and minimum required to avoid deadlock */
 	slb->max_inflight = RTE_MAX(conf->nb_events_limit, min_max_in_flight);
 	slb->migration_cooldown_cycles =
-		(rte_get_timer_hz() * SLB_MIGRATION_COOLDOWN_MS) / 1000;
+		((uint64_t)rte_get_timer_hz() * SLB_MIGRATION_COOLDOWN_MS) / 1000;
 	return 0;
 }
 
@@ -613,7 +634,7 @@ slb_stop(struct rte_eventdev *dev)
 			struct slb_atomic_state *astate = q->atomic_state;
 
 			/* Call user callback for each held event */
-			for (uint16_t h = 0; h < astate->hold_count; h++) {
+			for (uint32_t h = 0; h < astate->hold_count; h++) {
 				if (flush != NULL)
 					flush(dev_id, astate->hold_buffer[h],
 					      flush_arg);
@@ -655,7 +676,7 @@ slb_stop(struct rte_eventdev *dev)
 				rte_atomic_store_explicit(
 					&q->reorder_buffer[s].state,
 					SLB_REORDER_EMPTY,
-					rte_memory_order_relaxed);
+					rte_memory_order_release);
 			}
 			q->reorder_drain_idx = 0;
 		}
@@ -696,7 +717,7 @@ slb_close(struct rte_eventdev *dev)
 }
 
 /* Dump the event device current state and statistics */
-void
+static void
 slb_dump(struct rte_eventdev *dev, FILE *f)
 {
 	struct slb_evdev *slb = slb_pmd_priv(dev);
@@ -778,6 +799,12 @@ slb_dump(struct rte_eventdev *dev, FILE *f)
 	fprintf(f, "\n  ALL QUEUES STATUS:\n");
 	for (i = 0; i < slb->num_queues; i++) {
 		struct slb_queue *q = &slb->queues[i];
+
+		if (q->q_ring == NULL) {
+			fprintf(f, "    Queue %2u: (not configured)\n", i);
+			continue;
+		}
+
 		uint32_t count = rte_event_ring_count(q->q_ring);
 		uint32_t ring_size = rte_event_ring_get_capacity(q->q_ring);
 
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
index c01290e539..457376d1d6 100644
--- a/drivers/event/slb/slb_evdev.h
+++ b/drivers/event/slb/slb_evdev.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2018 Ericsson AB
  * Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
  */
 
@@ -37,13 +38,7 @@
 /* Maximum number of queues that can be linked to a port per priority */
 #define SLB_PORT_MAX_Q_MAP_PER_PRIO (SLB_MAX_QUEUES)
 /* Number of priority levels supported by SLB. Currently fixed to 2 */
-#ifndef SLB_MAX_PRIORITIES
 #define SLB_MAX_PRIORITIES 2
-#endif
-
-#if (SLB_MAX_PRIORITIES != 2)
-#error "SLB_MAX_PRIORITIES must be set to 2 for now"
-#endif
 
 /* Total max mapping slots (per-prio * priorities) */
 #define SLB_PORT_MAX_Q_MAP (SLB_PORT_MAX_Q_MAP_PER_PRIO * SLB_MAX_PRIORITIES)
@@ -87,8 +82,9 @@ struct slb_reorder_entry {
 #define SLB_ATOMIC_FLOWS 2048
 #define SLB_ATOMIC_FLOWS_MASK (SLB_ATOMIC_FLOWS - 1)
 #define SLB_HOLD_BUFFER_SIZE (SLB_MAX_PORT_DEQUEUE_DEPTH * 64)
+#define SLB_HOLD_BUFFER_REFILL_HEADROOM 3
 #define SLB_MIGRATION_LOAD_THRESHOLD 16
-#define SLB_MIGRATION_COOLDOWN_MS 500
+#define SLB_MIGRATION_COOLDOWN_MS 500ULL
 
 /* Per-flow entry for atomic scheduling affinity */
 struct slb_flow {
@@ -120,7 +116,7 @@ struct slb_atomic_state {
 	struct slb_flow_map flow_map;
 	uint32_t next_port_rr;
 	rte_spinlock_t refill_lock;
-	uint16_t hold_count;
+	uint32_t hold_count;
 	struct slb_migration_state migration;
 	uint64_t migrations_count;
 	uint64_t flow_last_migrated[SLB_ATOMIC_FLOWS];
@@ -223,13 +219,6 @@ uint16_t slb_event_enqueue_forward_burst(void *port,
 uint16_t slb_event_dequeue_burst(void *port, struct rte_event *events,
 				 uint16_t num, uint64_t wait);
 
-void slb_port_return_credits(struct slb_evdev *slb, struct slb_port *port,
-			     int32_t credits);
-
-void slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue);
-
-void slb_dump(struct rte_eventdev *dev, FILE *f);
-
 int slb_xstats_get_names(const struct rte_eventdev *dev,
 			 enum rte_event_dev_xstats_mode mode,
 			 uint8_t queue_port_id,
diff --git a/drivers/event/slb/slb_event.c b/drivers/event/slb/slb_event.c
index 3d0436e4a0..f53e44b61b 100644
--- a/drivers/event/slb/slb_event.c
+++ b/drivers/event/slb/slb_event.c
@@ -1,11 +1,15 @@
 /* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2018 Ericsson AB
  * Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
  */
 
 #include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
 #include <limits.h>
 #include <rte_bitops.h>
 #include <rte_cycles.h>
+#include <rte_errno.h>
 #include <rte_ring_elem.h>
 #include <rte_stdatomic.h>
 
@@ -31,6 +35,9 @@ slb_port_acquire_credits(struct slb_evdev *slb, struct slb_port *port,
 
 	total_inflight = rte_atomic_load_explicit(&slb->credits_on_loan,
 						  rte_memory_order_relaxed);
+	if (unlikely(total_inflight > port->new_event_threshold))
+		return false;
+
 	available = slb->max_inflight - total_inflight;
 	required_credits = RTE_MAX(abs(remaining_credits), SLB_PORT_MIN_CREDITS);
 
@@ -61,7 +68,7 @@ slb_port_acquire_credits(struct slb_evdev *slb, struct slb_port *port,
 /* Port returning credits (Terminated events). Keep local cache.
  * If local cache exceeds the threshold, return excess credits to the pool
  */
-void
+static void
 slb_port_return_credits(struct slb_evdev *slb, struct slb_port *port,
 			int32_t credits)
 {
@@ -103,16 +110,25 @@ slb_port_queue_enqueue_burst_stats(struct slb_port *source_port,
 
 #define REORDER_BURST_SZ 64
 
-/* Drain contiguous ready events from ordered queue's reorder buffer */
-void
-slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
+/* Drain contiguous ready events from ordered queue's reorder buffer.
+ * Thread-safe: uses queue->reorder_lock internally.
+ */
+static void
+slb_reorder_drain(struct slb_evdev *slb, struct slb_port *port,
+		  struct slb_queue *queue)
 {
 	if (queue == NULL || queue->reorder_buffer == NULL)
 		return;
 
+	int32_t released_credits = 0;
+
+retry:
 	/* Only one thread can drain the reorder buffer at a time */
-	if (!rte_spinlock_trylock(&queue->reorder_lock))
+	if (!rte_spinlock_trylock(&queue->reorder_lock)) {
+		if (released_credits > 0)
+			slb_port_return_credits(slb, port, released_credits);
 		return;
+	}
 
 	uint32_t drain_idx = queue->reorder_drain_idx;
 	uint32_t mask = queue->q_ring->r.mask;
@@ -120,7 +136,7 @@ slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 	uint8_t state;
 
 	/* Drain events from the current drain index till an empty slot.
-	 * Released event slots need no processing except marking them as empty.
+	 * Released event slots return their held credit once drained.
 	 */
 	while ((state = rte_atomic_load_explicit(&buf[drain_idx].state,
 						 rte_memory_order_acquire)) !=
@@ -128,8 +144,9 @@ slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 		if (state == SLB_REORDER_RELEASED) {
 			rte_atomic_store_explicit(&buf[drain_idx].state,
 						  SLB_REORDER_EMPTY,
-						  rte_memory_order_relaxed);
+						  rte_memory_order_release);
 			drain_idx = (drain_idx + 1) & mask;
+			released_credits++;
 			continue;
 		}
 
@@ -142,7 +159,7 @@ slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 			burst[burst_size++] = buf[drain_idx].event;
 			rte_atomic_store_explicit(&buf[drain_idx].state,
 						  SLB_REORDER_EMPTY,
-						  rte_memory_order_relaxed);
+						  rte_memory_order_release);
 			drain_idx = (drain_idx + 1) & mask;
 		} while (burst_size < REORDER_BURST_SZ &&
 			 rte_atomic_load_explicit(&buf[drain_idx].state,
@@ -151,12 +168,25 @@ slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue)
 			 buf[drain_idx].event.queue_id == target_qid);
 
 		/* Target queue is sized to max_inflight and can never be full */
-		rte_event_ring_enqueue_burst(slb->queues[target_qid].q_ring,
-					     burst, burst_size, NULL);
+		uint16_t enq = rte_event_ring_enqueue_burst(
+			slb->queues[target_qid].q_ring, burst, burst_size, NULL);
+		RTE_ASSERT(enq == burst_size);
 	}
 
 	queue->reorder_drain_idx = drain_idx;
 	rte_spinlock_unlock(&queue->reorder_lock);
+
+	/* Re-check after unlock in case another port marked drain_idx
+	 * READY/RELEASED and failed trylock before we unlocked.
+	 */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	if (unlikely(rte_atomic_load_explicit(&buf[drain_idx].state,
+					      rte_memory_order_acquire) !=
+		     SLB_REORDER_EMPTY))
+		goto retry;
+
+	if (released_credits > 0)
+		slb_port_return_credits(slb, port, released_credits);
 }
 
 /* Hash 20-bit flow ID into atomic flow slot index (SLB_ATOMIC_FLOWS) */
@@ -212,7 +242,7 @@ slb_find_lightest_flow_on_port(struct slb_queue *queue, uint8_t port_id,
 					     rte_memory_order_relaxed) == (int32_t)port_id) {
 			/* Skip flows that have been migrated recently */
 			if (astate->flow_last_migrated[f] != 0 &&
-			    (now - astate->flow_last_migrated[f]) < cooldown_cycles)
+			    now < astate->flow_last_migrated[f] + cooldown_cycles)
 				continue;
 
 			if (counts[f] < min_events) {
@@ -256,7 +286,7 @@ slb_check_and_trigger_migration(struct slb_evdev *slb, struct slb_queue *queue,
 
 	/* Port is still in cooldown period */
 	if (slb->ports[full_port_id].last_migrated_time != 0 &&
-	    (now - slb->ports[full_port_id].last_migrated_time) < cooldown_cycles)
+	    now < slb->ports[full_port_id].last_migrated_time + cooldown_cycles)
 		return;
 
 	/* Find flow to migrate*/
@@ -291,7 +321,7 @@ slb_find_migration_target_port(struct slb_evdev *slb, struct slb_queue *queue,
 			continue;
 
 		if (cp->last_migrated_time == 0 ||
-		    (now - cp->last_migrated_time) >= cooldown_cycles) {
+		    now >= cp->last_migrated_time + cooldown_cycles) {
 			if ((int)astate->port_stats[cand_port].flow_count < min_flows) {
 				min_flows = (int)astate->port_stats[cand_port].flow_count;
 				target_port = cand_port;
@@ -315,7 +345,7 @@ slb_complete_flow_migration(struct slb_evdev *slb, struct slb_atomic_state *asta
 				  target_port, rte_memory_order_release);
 
 	/* Switch all events in hold buffer to the target port */
-	for (uint16_t h = 0; h < astate->hold_count; h++) {
+	for (uint32_t h = 0; h < astate->hold_count; h++) {
 		if (astate->hold_ports[h] == mig_port &&
 		    slb_flow_hash(astate->hold_buffer[h].flow_id) == f_idx) {
 			astate->hold_ports[h] = (uint8_t)target_port;
@@ -429,38 +459,38 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 
 	/* 1. Process Hold Buffer events */
 	if (astate->hold_count > 0) {
-		uint16_t retained = 0;
-		uint16_t count = astate->hold_count;
+		uint32_t retained = 0;
+		uint32_t count = astate->hold_count;
+		uint32_t h_idx = 0;
 
-		i = 0;
-		while (i < count) {
-			uint8_t dest_port_id = astate->hold_ports[i];
-			uint16_t burst_len = 1;
+		while (h_idx < count) {
+			uint8_t dest_port_id = astate->hold_ports[h_idx];
+			uint32_t burst_len = 1;
 
 			/* Collect consecutive events for the same destination port */
-			while ((i + burst_len) < count &&
-			       astate->hold_ports[i + burst_len] == dest_port_id)
+			while ((h_idx + burst_len) < count &&
+			       astate->hold_ports[h_idx + burst_len] == dest_port_id)
 				burst_len++;
 
 			/* If destination port is full, retain the event in hold buffer*/
 			if (full_ports_mask & (1ULL << dest_port_id)) {
-				if (retained != i) {
+				if (retained != h_idx) {
 					memmove(&astate->hold_buffer[retained],
-						&astate->hold_buffer[i],
+						&astate->hold_buffer[h_idx],
 						burst_len * sizeof(struct rte_event));
 					memmove(&astate->hold_ports[retained],
-						&astate->hold_ports[i],
+						&astate->hold_ports[h_idx],
 						burst_len);
 				}
 				retained += burst_len;
-				i += burst_len;
+				h_idx += burst_len;
 				continue;
 			}
 
 			/* Enqueue events to the destination port */
 			uint16_t enqueued = rte_event_ring_enqueue_burst(
 				queue->per_port_rings[dest_port_id],
-				&astate->hold_buffer[i], burst_len, NULL);
+				&astate->hold_buffer[h_idx], burst_len, NULL);
 			astate->port_stats[dest_port_id].q_enqueued += enqueued;
 
 			/* If enqueue was successful then decrement the load counter */
@@ -470,8 +500,8 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 
 			/* If enqueue was not successful, retain the event in hold buffer */
 			if (enqueued < burst_len) {
-				uint16_t rem = burst_len - enqueued;
-				uint16_t start_idx = i + enqueued;
+				uint32_t rem = burst_len - enqueued;
+				uint32_t start_idx = h_idx + enqueued;
 
 				full_ports_mask |= (1ULL << dest_port_id);
 				if (retained != start_idx) {
@@ -489,7 +519,7 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 						slb, queue, astate, dest_port_id);
 			}
 
-			i += burst_len;
+			h_idx += burst_len;
 		}
 
 		astate->hold_count = retained;
@@ -497,7 +527,7 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 		 * if hold buffer does not have enough free space.
 		 */
 		if (SLB_HOLD_BUFFER_SIZE - astate->hold_count <
-		    3 * RTE_DIM(rcv_events)) {
+		    SLB_HOLD_BUFFER_REFILL_HEADROOM * RTE_DIM(rcv_events)) {
 			rte_spinlock_unlock(&astate->refill_lock);
 			return;
 		}
@@ -589,11 +619,17 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 
 			/* If destination port is full, retain events in hold buffer */
 			if (full_ports_mask & (1ULL << p)) {
-				rte_memcpy(&astate->hold_buffer[astate->hold_count],
-					   &sorted_events[p_start],
-					   p_count * sizeof(struct rte_event));
-				memset(&astate->hold_ports[astate->hold_count], p, p_count);
-				astate->hold_count += p_count;
+				uint32_t to_copy = RTE_MIN(
+					(uint32_t)p_count,
+					SLB_HOLD_BUFFER_SIZE - astate->hold_count);
+				if (likely(to_copy > 0)) {
+					rte_memcpy(&astate->hold_buffer[astate->hold_count],
+						   &sorted_events[p_start],
+						   to_copy * sizeof(struct rte_event));
+					memset(&astate->hold_ports[astate->hold_count],
+					       p, to_copy);
+					astate->hold_count += to_copy;
+				}
 				continue;
 			}
 
@@ -607,14 +643,20 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 				if (unlikely(astate->port_stats[p].load_counter > 0))
 					astate->port_stats[p].load_counter--;
 			} else {
-				uint16_t rem = p_count - enqueued;
+				uint32_t rem = p_count - enqueued;
+				uint32_t to_copy = RTE_MIN(
+					rem,
+					SLB_HOLD_BUFFER_SIZE - astate->hold_count);
 				/* Mark the destination port as full and retain remaining events */
 				full_ports_mask |= (1ULL << p);
-				rte_memcpy(&astate->hold_buffer[astate->hold_count],
-					   &sorted_events[p_start + enqueued],
-					   rem * sizeof(struct rte_event));
-				memset(&astate->hold_ports[astate->hold_count], p, rem);
-				astate->hold_count += rem;
+				if (likely(to_copy > 0)) {
+					rte_memcpy(&astate->hold_buffer[astate->hold_count],
+						   &sorted_events[p_start + enqueued],
+						   to_copy * sizeof(struct rte_event));
+					memset(&astate->hold_ports[astate->hold_count],
+					       p, to_copy);
+					astate->hold_count += to_copy;
+				}
 				/* If not a single event was enqueued, check for migration */
 				if (enqueued == 0)
 					slb_check_and_trigger_migration(
@@ -626,6 +668,16 @@ slb_atomic_refill(struct slb_port *port, struct slb_queue *queue)
 	rte_spinlock_unlock(&astate->refill_lock);
 }
 
+/* Enqueue a burst of events from source_port.
+ *
+ * Design invariant: Every queue ring (q_ring) is created with RING_F_EXACT_SZ
+ * and capacity equal to slb->max_inflight. Because NEW events must acquire
+ * credits from slb->max_inflight upfront and FORWARD events are verified
+ * against source_port->pending_releases, the total number of in-flight events
+ * across the entire device can never exceed slb->max_inflight. Consequently,
+ * q_ring can never fill and rte_event_ring_enqueue_burst() onto q_ring is
+ * guaranteed to enqueue the full burst.
+ */
 static inline uint16_t
 slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				const struct rte_event events[],
@@ -656,25 +708,22 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 		}
 	}
 
-	/* Check credit threshold if there are NEW events */
-	if (num_new > 0) {
-		if (unlikely(rte_atomic_load_explicit(&slb->credits_on_loan,
-						      rte_memory_order_relaxed) >
-			     source_port->new_event_threshold))
-			return 0;
+	/* Check for release underflow before acquiring credits */
+	cur_pending = source_port->pending_releases;
+	if (unlikely(num_forward + num_release > cur_pending)) {
+		rte_errno = EINVAL;
+		return 0;
+	}
 
+	/* Acquire credits if there are NEW events */
+	if (num_new > 0) {
 		if (unlikely(!slb_port_acquire_credits(slb, source_port,
-						       num_new)))
+						       num_new))) {
+			rte_errno = ENOSPC;
 			return 0;
+		}
 	}
 
-	/* Return credits for RELEASE events */
-	if (num_release > 0)
-		slb_port_return_credits(slb, source_port, num_release);
-
-	/* Check for release underflow and balance pending releases */
-	cur_pending = source_port->pending_releases;
-	RTE_VERIFY(num_forward + num_release <= cur_pending);
 	source_port->pending_releases = cur_pending - (num_forward + num_release);
 
 	slb_port_enqueue_stats(source_port, num_new, num_forward, num_release);
@@ -695,8 +744,9 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 
 		/* Enqueue the entire burst if going to the same queue */
 		if (likely(burst_size == events_len)) {
-			rte_event_ring_enqueue_burst(slb->queues[q0].q_ring,
-						     events, events_len, NULL);
+			uint16_t enq = rte_event_ring_enqueue_burst(
+				slb->queues[q0].q_ring, events, events_len, NULL);
+			RTE_ASSERT(enq == events_len);
 			slb_port_queue_enqueue_burst_stats(source_port, q0,
 							   events_len);
 		} else { /* Sort events by destination queue */
@@ -748,11 +798,13 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				uint8_t q = rte_ctz64(qmask);
 				uint16_t count = queue_counts[q];
 				uint16_t offset = queue_offsets[q];
+				uint16_t enq;
 
 				qmask &= (qmask - 1);
-				rte_event_ring_enqueue_burst(slb->queues[q].q_ring,
-							     &sorted_events[offset],
-							     count, NULL);
+				enq = rte_event_ring_enqueue_burst(
+					slb->queues[q].q_ring,
+					&sorted_events[offset], count, NULL);
+				RTE_ASSERT(enq == count);
 				slb_port_queue_enqueue_burst_stats(source_port, q,
 								   count);
 			}
@@ -765,6 +817,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 
 	/* General path for bursts with any mix of events */
 	uint64_t ordered_drain_mask = 0;
+	uint16_t ordered_releases = 0;
 	uint16_t freed_count = 0;
 	uint16_t head = source_port->history_head;
 	uint16_t n_enq = 0;
@@ -792,11 +845,14 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				uint16_t slot = hist->seq_slot;
 
 				if (ev->op == RTE_EVENT_OP_RELEASE) {
-					/* Release the reorder buffer entry */
+					/* Release the reorder buffer entry; credit is
+					 * returned when slb_reorder_drain reclaims slot
+					 */
 					rte_atomic_store_explicit(
 						&orig_q->reorder_buffer[slot].state,
 						SLB_REORDER_RELEASED,
 						rte_memory_order_release);
+					ordered_releases++;
 				} else {
 					/* Put event in reorder buffer */
 					orig_q->reorder_buffer[slot].event = *ev;
@@ -874,9 +930,11 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 			   n_enq == events_len)) {
 			/* Entire batch is going to a single queue */
 			uint8_t q = rte_ctz64(batch_queues_mask);
+			uint16_t enq;
 
-			rte_event_ring_enqueue_burst(slb->queues[q].q_ring,
-						     events, events_len, NULL);
+			enq = rte_event_ring_enqueue_burst(
+				slb->queues[q].q_ring, events, events_len, NULL);
+			RTE_ASSERT(enq == events_len);
 			slb_port_queue_enqueue_burst_stats(source_port, q,
 							   events_len);
 		} else {
@@ -909,17 +967,26 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 				uint8_t q = rte_ctz64(qmask);
 				uint16_t count = queue_counts[q];
 				uint16_t offset = queue_offsets[q];
+				uint16_t enq;
 
 				qmask &= (qmask - 1);
-				rte_event_ring_enqueue_burst(slb->queues[q].q_ring,
-							     &sorted_events[offset],
-							     count, NULL);
+				enq = rte_event_ring_enqueue_burst(
+					slb->queues[q].q_ring,
+					&sorted_events[offset], count, NULL);
+				RTE_ASSERT(enq == count);
 				slb_port_queue_enqueue_burst_stats(source_port, q,
 								   count);
 			}
 		}
 	}
 
+	/* Return credits for non-ordered RELEASE events immediately; ordered
+	 * RELEASE credits are returned when slb_reorder_drain reclaims the slot.
+	 */
+	if (num_release > ordered_releases)
+		slb_port_return_credits(slb, source_port,
+					num_release - ordered_releases);
+
 	/* Update the history list head once after all frees*/
 	if (freed_count > 0) {
 		source_port->history_head = head;
@@ -931,7 +998,7 @@ slb_event_enqueue_burst_generic(struct slb_port *source_port,
 		uint8_t qid = rte_ctz64(ordered_drain_mask);
 
 		ordered_drain_mask &= ~(1ULL << qid);
-		slb_reorder_drain(slb, &slb->queues[qid]);
+		slb_reorder_drain(slb, source_port, &slb->queues[qid]);
 	}
 
 	SLB_LOG_DP_PORT_LINE(DEBUG, source_port->id,
@@ -1134,14 +1201,16 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 				  uint16_t pending)
 {
 	uint16_t head;
+	uint16_t ordered_releases = 0;
 	uint64_t ordered_drain_mask = 0;
 
-	slb_port_return_credits(slb, port, pending);
 	port->pending_releases = 0;
 
 	if (port->is_single_linked ||
-	    port->history_avail >= SLB_PORT_HISTORY_MAX_TOKENS)
+	    port->history_avail >= SLB_PORT_HISTORY_MAX_TOKENS) {
+		slb_port_return_credits(slb, port, pending);
 		return;
+	}
 
 	/* Process all history entries */
 	head = port->history_head;
@@ -1151,7 +1220,9 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 		if (!hist->active)
 			continue;
 
-		/* Ordered releases will free the reorder buffer slot*/
+		/* Ordered releases will free the reorder buffer slot; credit is
+		 * returned when slb_reorder_drain reclaims the slot.
+		 */
 		if (hist->sched_type == RTE_SCHED_TYPE_ORDERED) {
 			struct slb_queue *oq = &slb->queues[hist->orig_queue_id];
 
@@ -1161,6 +1232,7 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 					SLB_REORDER_RELEASED,
 					rte_memory_order_release);
 				ordered_drain_mask |= (1ULL << hist->orig_queue_id);
+				ordered_releases++;
 			}
 		} else if (hist->sched_type == RTE_SCHED_TYPE_ATOMIC) {
 			/* Atomic releases are counted as returned events */
@@ -1180,12 +1252,15 @@ slb_port_process_implicit_release(struct slb_port *port, struct slb_evdev *slb,
 	}
 	port->history_head = head;
 
+	if (pending > ordered_releases)
+		slb_port_return_credits(slb, port, pending - ordered_releases);
+
 	/* If there are ordered releases, call the reorder drain function */
 	while (ordered_drain_mask != 0) {
 		uint8_t qid = rte_ctz64(ordered_drain_mask);
 
 		ordered_drain_mask &= ~(1ULL << qid);
-		slb_reorder_drain(slb, &slb->queues[qid]);
+		slb_reorder_drain(slb, port, &slb->queues[qid]);
 	}
 }
 
diff --git a/drivers/event/slb/slb_xstats.c b/drivers/event/slb/slb_xstats.c
index fdb7dd6cc5..ff898a3ef2 100644
--- a/drivers/event/slb/slb_xstats.c
+++ b/drivers/event/slb/slb_xstats.c
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2018-2019 Ericsson AB
  * Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
  */
 
-- 
2.53.0

