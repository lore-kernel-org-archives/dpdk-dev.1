Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA1606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jNMuob6d
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38EC9402F0;
	Sat,  7 Nov 2026 02:30:22 +0100 (CET)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTPS id 5A70D402DD
 for <dev@dpdk.org>; Sat,  7 Nov 2026 02:30:21 +0100 (CET)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-53644b28706so17815521cf.3
 for <dev@dpdk.org>; Fri, 06 Nov 2026 17:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794015020; x=1794619820; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KRwiBDqTKETs0oHQBsefxGbaspxzmKyOCcmGAralGsw=;
 b=jNMuob6dQv0mRq4JY6VADLWt38unlxN30EdpQbYGg/rS0PPVV9CQv4C7zgCaHkpLJ6
 JFnGXumsnUsF8zJqQa+UdPYCHjgGllKsXCljCxXUf9bt3qc1QY3YLQE87IzPN+CvESPY
 swUZ7hOal27M/fAq/aI51Ydwn8/FZNNB3PIUB+euFw0+jSc87zx79YmO/14M8nZzPh2M
 4Mxfxo7+Ruw4JyubYriHKfh/PcktmpchEfOVf3u0/Vr7DVXevHnEOfv6OcsmBz7PupHJ
 kYL/f5ncHuYTHBDawidUjOtyM/SzQX9ruMmOkLhH5EJaBgQP/zeLAlxkG9NviSzu1mo2
 N/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794015020; x=1794619820;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KRwiBDqTKETs0oHQBsefxGbaspxzmKyOCcmGAralGsw=;
 b=VHnAikCkDMvzQ4wyKqpxioo7gN2TvrjmF1gHBPKetB3NRyKwQQ8D7S6x6pXfgjWRfB
 WbCqwk8tMR9alNEnY5qdGav+jbG83wcnoj4ob2ByfKVm4eDddt+zjwYMlXq+P03hk1tp
 LU4KORNX4o4Yz4brnnC7H6Hp02UrqEPBKjDotwQwrutO4soeMKU+3i3TBlOPq7wCfIoz
 Xr8I3ftMIl35LnkSm+oZgldafO7KU0QvWEl/vJa9iWAP5o297zdH/ghoCwjw9WIW5KzM
 lU0pLEba7Ay0LNyng3Nm1qd4XRi9Q6eqANuTT55nJeyfi7cG9raOQqJdvIcSPTtE9NrK
 il5g==
X-Gm-Message-State: APuU4Z8zd8r4UkZsgGRhkT0LZiruH0nz1bl3ZF5raxwDlEYwVyMdn9Qm
 nZdUD4MCWnIPWPmLfcb2aVR+5s8wlYa/VCRMxxShtZuKYkuBPB/O5G+pd0hUWSv5VjeSww==
X-Gm-Gg: AYBFou105Q3xsXfBoAVrMStKyUFmOhiEjbCMtvp0zDTmqb8cr5LRpwXnnv9zgAZ3Sv2
 SN3YqvTxmLFrbBV+fB/Wcy6Y/LXhSrIrDkMIRlppDCR6wRkGejHj4VwLeHf9uR3es5mKtL9mwIB
 SyTMJ58EhSHejEzn31psA26eb0Gw/iB2UdzSpzOCIA7aq0A2VTNuQE0+l9NwDlqzagThZykDkeD
 Dut83U9PdHIwxk42VJT87mMH7oDQlgbnl/1ibg9a+Br+7k3PHsTRdrgKXmzg8CoqZcwXABbHrfO
 MrJ3bQlMGFvvT6aMZalhNTOv4QBmx52FNNOUUIh0QPtHgG9eE1rNKV2E01uKQaSQWc3ipduLGYs
 cyU4VxO2b6SXu5n5nP+p4GX9NOt2zN/8QjED4FvisIkVicb9TddeKozHQckBPOXkJ0VWiGLGmPx
 bOYL78Crj7JgvU1ANaIdmfgEZM2mayQqBPPMSevXqwsumFERt9rJ/S/WqnHjY46VXokDa0RQNWn
 8+el+yPThm8e2Bh9Fs0XakwEaK041n0ENiI2bTEHlbqAqFQgxOV7XetEBGhiyuYwyWnQRsI3NYf
 OuY5kjLYQLoQQON2XopW1zFPnkqVs/S3P68TrB6ymtdyO/dGgy3NGlRaICD2pJkc0hK0btpSX06
 15zuT4ifZ9T9IDGUq
X-Received: by 2002:a05:622a:1e0a:b0:53e:35dc:9be6 with SMTP id
 d75a77b69052e-54e154705cemr61805731cf.62.1794015019784; 
 Fri, 06 Nov 2026 17:30:19 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c2ac1.dyn.optonline.net. [148.76.42.193])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e257862bfsm33746111cf.6.2026.11.06.17.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:30:19 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v1 1/8] event/slb: introduce software load balancer PMD
Date: Fri,  6 Nov 2026 20:30:03 -0500
Message-ID: <20261107013011.2443138-2-pravinpathakdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add basic skeleton and initial features for the Software Load Balancer
(SLB) eventdev PMD.

This initial commit provides:
- Virtual device driver registration (event_slb) and device probing.
- Device configuration and capability reporting for parallel queues,
  burst mode, multi-queue ports, and runtime port linking.
- Parallel queue support (multi-producer/multi-consumer rings) and
  single-link queue support (multi-producer/single-consumer rings).
- Event port configuration, linking/unlinking, and multi-priority
  queue scheduling.
- Central in-flight event credit management with batched loans
  (SLB_MIN_CREDIT_LOAN = 512).
- High-performance event enqueue and dequeue burst processing.
- Meson build system integration and MAINTAINERS entry.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 MAINTAINERS                   |   4 +
 drivers/event/meson.build     |   1 +
 drivers/event/slb/meson.build |  15 +
 drivers/event/slb/slb_evdev.c | 585 ++++++++++++++++++++++++++++++++++
 drivers/event/slb/slb_evdev.h | 176 ++++++++++
 drivers/event/slb/slb_event.c | 279 ++++++++++++++++
 6 files changed, 1060 insertions(+)
 create mode 100644 drivers/event/slb/meson.build
 create mode 100644 drivers/event/slb/slb_evdev.c
 create mode 100644 drivers/event/slb/slb_evdev.h
 create mode 100644 drivers/event/slb/slb_event.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 93ad53027d..89ea53695a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1533,6 +1533,10 @@ M: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
 F: drivers/event/dsw/
 F: doc/guides/eventdevs/dsw.rst
 
+Software Load Balancer (SLB) Eventdev PMD
+M: Pravin Pathak <pravin.pathak.dev@gmail.com>
+F: drivers/event/slb/
+
 Software OPDL Eventdev PMD
 M: Liang Ma <liangma@liangbit.com>
 M: Peter Mccarthy <peter.mccarthy@intel.com>
diff --git a/drivers/event/meson.build b/drivers/event/meson.build
index ddaa0300ac..ece490dfb5 100644
--- a/drivers/event/meson.build
+++ b/drivers/event/meson.build
@@ -15,5 +15,6 @@ drivers = [
         'opdl',
         'skeleton',
         'sw',
+        'slb',
 ]
 std_deps = ['eventdev', 'kvargs']
diff --git a/drivers/event/slb/meson.build b/drivers/event/slb/meson.build
new file mode 100644
index 0000000000..9a1dff524f
--- /dev/null
+++ b/drivers/event/slb/meson.build
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
+
+if is_windows
+    build = false
+    reason = 'not supported on Windows'
+    subdir_done()
+endif
+
+sources = files(
+        'slb_evdev.c',
+        'slb_event.c',
+)
+
+deps += ['bus_vdev', 'ring']
diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
new file mode 100644
index 0000000000..53af113293
--- /dev/null
+++ b/drivers/event/slb/slb_evdev.c
@@ -0,0 +1,585 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
+ */
+
+#include <stdbool.h>
+#include <inttypes.h>
+#include <rte_bitops.h>
+#include <rte_cycles.h>
+#include <rte_malloc.h>
+#include <rte_ring_elem.h>
+#include <rte_errno.h>
+#include <rte_stdatomic.h>
+#include <eventdev_pmd.h>
+#include <eventdev_pmd_vdev.h>
+
+#include "slb_evdev.h"
+
+#define EVENTDEV_NAME_SLB_PMD event_slb
+
+/* Setup Eventdev port. Reset all mapped queues */
+static int
+slb_port_setup(struct rte_eventdev *dev, uint8_t port_id,
+	       const struct rte_event_port_conf *conf)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	struct slb_port *port;
+	bool implicit_release;
+	uint16_t deq_depth;
+	uint16_t enq_depth;
+
+	port = &slb->ports[port_id];
+
+	implicit_release =
+	    !(conf->event_port_cfg & RTE_EVENT_PORT_CFG_DISABLE_IMPL_REL);
+
+	deq_depth = conf->dequeue_depth;
+	if (deq_depth == 0 || deq_depth > SLB_MAX_PORT_DEQUEUE_DEPTH)
+		deq_depth = SLB_MAX_PORT_DEQUEUE_DEPTH;
+
+	enq_depth = conf->enqueue_depth;
+	if (enq_depth == 0 || enq_depth > SLB_MAX_PORT_ENQUEUE_DEPTH)
+		enq_depth = SLB_MAX_PORT_ENQUEUE_DEPTH;
+
+	*port = (struct slb_port) {
+		.id = port_id,
+		.slb = slb,
+		.dequeue_depth = deq_depth,
+		.enqueue_depth = enq_depth,
+		.new_event_threshold = conf->new_event_threshold,
+		.implicit_release = implicit_release,
+		.is_single_linked = conf->event_port_cfg &
+				   RTE_EVENT_PORT_CFG_SINGLE_LINK,
+		.inflight_credits = 0,
+		.credits_drained = false,
+		.total_dequeues = 0,
+		.empty_dequeues = 0,
+		.single_linked_q = NULL,
+		.single_linked_ring = NULL,
+	};
+
+	port->remap_input_q = false;
+	rte_atomic_store_explicit(&port->active_queues, 0,
+				  rte_memory_order_relaxed);
+
+	dev->data->ports[port_id] = port;
+
+	/* Reset all queues mapped to this port */
+	for (int p = 0; p < SLB_MAX_PRIORITIES; p++) {
+		port->next_q[p] = 0;
+		port->num_q[p] = 0;
+		memset(port->q_entries[p], 0, sizeof(port->q_entries[p]));
+	}
+
+	return 0;
+}
+
+/* Default Eventdev port configuration for SLB */
+static void
+slb_port_def_conf(struct rte_eventdev *dev __rte_unused,
+		  uint8_t port_id __rte_unused,
+		  struct rte_event_port_conf *port_conf)
+{
+	*port_conf = (struct rte_event_port_conf) {
+		.new_event_threshold = 1024,
+		.dequeue_depth = SLB_MAX_PORT_DEQUEUE_DEPTH / 4,
+		.enqueue_depth = SLB_MAX_PORT_ENQUEUE_DEPTH / 4
+	};
+}
+
+static void
+slb_port_release(void *p __rte_unused)
+{
+}
+
+/* Called to free queue resources on device close or reconfiguration */
+static void
+slb_queue_release(struct rte_eventdev *dev, uint8_t queue_id)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	struct slb_queue *queue = &slb->queues[queue_id];
+
+	if (queue->q_ring) {
+		rte_event_ring_free(queue->q_ring);
+		queue->q_ring = NULL;
+	}
+}
+
+/* Setup Eventdev queue. Eventdev queues are implemented as DPDK rings */
+static int
+slb_queue_setup(struct rte_eventdev *dev, uint8_t queue_id,
+		const struct rte_event_queue_conf *conf)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	struct slb_queue *queue = &slb->queues[queue_id];
+	struct rte_event_ring *ring;
+	char ring_name[RTE_RING_NAMESIZE];
+	uint32_t q_size = (slb->max_inflight > 0) ?
+			  (uint32_t)slb->max_inflight : SLB_IN_RING_SIZE;
+
+	/* Release existing queue resources if reconfiguring */
+	slb_queue_release(dev, queue_id);
+
+	snprintf(ring_name, sizeof(ring_name), "slb%d_q%u", dev->data->dev_id,
+		 queue_id);
+
+	if (conf->event_queue_cfg & RTE_EVENT_QUEUE_CFG_SINGLE_LINK) {
+		/* MP -> SC ring for single-link queues */
+		queue->is_single_link = true;
+		ring = rte_event_ring_create(ring_name, q_size,
+			dev->data->socket_id, RING_F_SC_DEQ | RING_F_EXACT_SZ);
+	} else if (conf->schedule_type == RTE_SCHED_TYPE_PARALLEL) {
+		/* MP -> MC ring for parallel queues */
+		queue->is_single_link = false;
+		ring = rte_event_ring_create(ring_name, q_size,
+			dev->data->socket_id, RING_F_EXACT_SZ);
+	} else {
+		SLB_LOG_DP_LINE(ERR, "Unsupported schedule_type %u",
+				conf->schedule_type);
+		return -ENOTSUP;
+	}
+
+	if (ring == NULL)
+		return -ENOMEM;
+
+	queue->q_ring = ring;
+	queue->schedule_type = conf->schedule_type;
+	queue->serving_ports_mask = 0;
+	queue->num_serving_ports = 0;
+
+	return 0;
+}
+
+/* Settings for default Eventdev queue configuration */
+static void
+slb_queue_def_conf(struct rte_eventdev *dev __rte_unused,
+		   uint8_t queue_id __rte_unused,
+		   struct rte_event_queue_conf *queue_conf)
+{
+	*queue_conf = (struct rte_event_queue_conf) {
+		.nb_atomic_flows = 4096,
+		.schedule_type = RTE_SCHED_TYPE_PARALLEL,
+		.priority = RTE_EVENT_DEV_PRIORITY_NORMAL
+	};
+}
+
+static void
+slb_port_unlink_queue_from_prio(struct slb_port *port, int prio, int slot)
+{
+	for (int k = slot; k < port->num_q[prio] - 1; k++)
+		port->q_entries[prio][k] = port->q_entries[prio][k + 1];
+
+	port->num_q[prio]--;
+	memset(&port->q_entries[prio][port->num_q[prio]], 0,
+	       sizeof(struct slb_port_q_entry));
+	if (port->next_q[prio] >= port->num_q[prio])
+		port->next_q[prio] = 0;
+}
+
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
+static int
+slb_port_link_one(struct slb_port *port, struct slb_queue *queue,
+		  uint8_t qid, uint8_t app_prio, bool has_prio)
+{
+	int prio;
+	bool found = false;
+
+	if (port->is_single_linked) {
+		if (port->single_linked_q != NULL &&
+		    port->single_linked_q != queue) {
+			rte_errno = EINVAL;
+			return -EINVAL;
+		}
+		port->single_linked_q = queue;
+		port->single_linked_ring = queue->q_ring;
+	} else {
+		if (has_prio)
+			prio = (app_prio < RTE_EVENT_DEV_PRIORITY_NORMAL) ? 0 : 1;
+		else
+			prio = SLB_MAX_PRIORITIES - 1;
+
+		for (int pr = 0; pr < SLB_MAX_PRIORITIES; pr++) {
+			int s = slb_port_find_queue_slot(port, pr, qid);
+
+			if (s >= 0) {
+				if (pr == prio)
+					found = true;
+				else
+					slb_port_unlink_queue_from_prio(port, pr, s);
+				break;
+			}
+		}
+		if (!found) {
+			uint16_t slot = port->num_q[prio];
+
+			if (slot >= SLB_PORT_MAX_Q_MAP_PER_PRIO) {
+				rte_errno = ENOSPC;
+				return -ENOSPC;
+			}
+			port->q_entries[prio][slot].dq_ring = queue->q_ring;
+			port->q_entries[prio][slot].queue = queue;
+			port->q_entries[prio][slot].queue_id = qid;
+			port->q_entries[prio][slot].schedule_type =
+				queue->schedule_type;
+			port->num_q[prio]++;
+		}
+
+		rte_atomic_fetch_or_explicit(&port->active_queues,
+					     (1ULL << qid),
+					     rte_memory_order_release);
+	}
+
+	queue->serving_ports_mask |= (1ULL << port->id);
+	queue->num_serving_ports = rte_popcount64(queue->serving_ports_mask);
+	return 0;
+}
+
+static int
+slb_port_unlink_one(struct slb_port *port, struct slb_queue *queue, uint8_t qid)
+{
+	bool found = false;
+
+	if (port->is_single_linked) {
+		if (port->single_linked_q != queue) {
+			rte_errno = EINVAL;
+			return -EINVAL;
+		}
+		port->single_linked_q = NULL;
+		port->single_linked_ring = NULL;
+	} else {
+		for (int prio = 0; prio < SLB_MAX_PRIORITIES; prio++) {
+			int s = slb_port_find_queue_slot(port, prio, qid);
+
+			if (s >= 0) {
+				slb_port_unlink_queue_from_prio(port, prio, s);
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			rte_errno = EINVAL;
+			return -EINVAL;
+		}
+		rte_atomic_fetch_and_explicit(&port->active_queues,
+					      ~(1ULL << qid),
+					      rte_memory_order_release);
+		port->remap_input_q = true;
+	}
+
+	queue->serving_ports_mask &= ~(1ULL << port->id);
+	queue->num_serving_ports = rte_popcount64(queue->serving_ports_mask);
+	return 0;
+}
+
+static int
+slb_port_link(struct rte_eventdev *dev, void *p, const uint8_t queues[],
+	      const uint8_t priorities[], uint16_t num)
+{
+	struct slb_port *port = p;
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	uint16_t i;
+
+	for (i = 0; i < num; i++) {
+		uint8_t qid = queues[i];
+		struct slb_queue *queue = &slb->queues[qid];
+		uint8_t prio = (priorities != NULL) ? priorities[i] : 0;
+		int ret = slb_port_link_one(port, queue, qid, prio,
+					    priorities != NULL);
+
+		if (ret < 0)
+			return i;
+	}
+	return num;
+}
+
+static int
+slb_port_unlink(struct rte_eventdev *dev, void *p, uint8_t queues[],
+		uint16_t num)
+{
+	struct slb_port *port = p;
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	uint16_t i;
+
+	for (i = 0; i < num; i++) {
+		uint8_t qid = queues[i];
+		struct slb_queue *queue = &slb->queues[qid];
+		int ret = slb_port_unlink_one(port, queue, qid);
+
+		if (ret < 0)
+			return i;
+	}
+	return num;
+}
+
+static void
+slb_info_get(struct rte_eventdev *dev __rte_unused,
+	     struct rte_event_dev_info *info)
+{
+	*info = (struct rte_event_dev_info) {
+		.driver_name = SLB_PMD_NAME,
+		.max_event_queues = SLB_MAX_QUEUES,
+		.max_event_queue_flows = SLB_MAX_FLOWS,
+		.max_event_queue_priority_levels = SLB_MAX_PRIORITIES,
+		.max_event_priority_levels = SLB_MAX_PRIORITIES,
+		.max_event_ports = SLB_MAX_PORTS,
+		.max_event_port_dequeue_depth = SLB_MAX_PORT_DEQUEUE_DEPTH,
+		.max_event_port_enqueue_depth = SLB_MAX_PORT_ENQUEUE_DEPTH,
+		.max_num_events = SLB_MAX_EVENTS,
+		.max_profiles_per_port = 1,
+		.event_dev_cap = RTE_EVENT_DEV_CAP_BURST_MODE |
+		RTE_EVENT_DEV_CAP_PARALLEL |
+		RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED |
+		RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE |
+		RTE_EVENT_DEV_CAP_NONSEQ_MODE |
+		RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT |
+		RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK |
+		RTE_EVENT_DEV_CAP_CARRY_FLOW_ID |
+		RTE_EVENT_DEV_CAP_MAINTENANCE_FREE |
+		RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ
+	};
+}
+
+static int
+slb_configure(const struct rte_eventdev *dev)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	const struct rte_event_dev_config *conf = &dev->data->dev_conf;
+	int32_t min_max_in_flight;
+	uint32_t q_size;
+
+	if (conf->nb_events_limit <= 0 ||
+	    conf->nb_events_limit > SLB_MAX_EVENTS) {
+		SLB_LOG_DP_LINE(INFO,
+			"nb_events_limit (%d) invalid, max is %d",
+			conf->nb_events_limit, SLB_MAX_EVENTS);
+		return -EINVAL;
+	}
+
+	slb->num_ports = conf->nb_event_ports;
+	slb->num_queues = conf->nb_event_queues;
+
+	min_max_in_flight = conf->nb_event_ports * SLB_PORT_MAX_CREDITS;
+	if (min_max_in_flight > SLB_MAX_EVENTS)
+		min_max_in_flight = SLB_MAX_EVENTS;
+
+	q_size = rte_align32pow2((uint32_t)RTE_MAX(conf->nb_events_limit,
+						   min_max_in_flight));
+	if (q_size > SLB_MAX_EVENTS)
+		q_size = SLB_MAX_EVENTS;
+
+	slb->max_inflight = (int32_t)q_size;
+	return 0;
+}
+
+static int
+slb_start(struct rte_eventdev *dev)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+
+	for (int i = 0; i < slb->num_queues; i++) {
+		if (slb->queues[i].serving_ports_mask == 0)
+			SLB_LOG_DP_LINE(INFO,
+				"Queue %d has no linked ports on start", i);
+	}
+
+	rte_atomic_store_explicit(&slb->credits_on_loan, 0,
+				  rte_memory_order_relaxed);
+
+	for (int i = 0; i < slb->num_ports; i++) {
+		struct slb_port *port = &slb->ports[i];
+		port->inflight_credits = 0;
+		port->credits_drained = false;
+		for (int p = 0; p < SLB_MAX_PRIORITIES; p++)
+			port->next_q[p] = 0;
+	}
+
+	return 0;
+}
+
+static void
+slb_drain_ring(uint8_t dev_id, struct rte_event_ring *ring,
+	       eventdev_stop_flush_t flush, void *flush_arg)
+{
+	struct rte_event ev;
+
+	if (ring == NULL)
+		return;
+
+	while (rte_event_ring_dequeue_burst(ring, &ev, 1, NULL)) {
+		if (flush != NULL)
+			flush(dev_id, ev, flush_arg);
+	}
+	rte_ring_reset(&ring->r);
+}
+
+static void
+slb_stop(struct rte_eventdev *dev)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	uint8_t dev_id = dev->data->dev_id;
+	eventdev_stop_flush_t flush = dev->dev_ops->dev_stop_flush;
+	void *flush_arg = dev->data->dev_stop_flush_arg;
+
+	for (uint8_t qid = 0; qid < slb->num_queues; qid++) {
+		struct slb_queue *q = &slb->queues[qid];
+		if (q->q_ring != NULL)
+			slb_drain_ring(dev_id, q->q_ring, flush, flush_arg);
+	}
+
+	for (int i = 0; i < slb->num_ports; i++) {
+		struct slb_port *port = &slb->ports[i];
+		port->inflight_credits = 0;
+		port->credits_drained = false;
+		for (int p = 0; p < SLB_MAX_PRIORITIES; p++)
+			port->next_q[p] = 0;
+	}
+
+	rte_atomic_store_explicit(&slb->credits_on_loan, 0,
+				  rte_memory_order_relaxed);
+}
+
+static int
+slb_close(struct rte_eventdev *dev)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+
+	for (int i = 0; i < slb->num_queues; i++)
+		slb_queue_release(dev, i);
+
+	return 0;
+}
+
+void
+slb_dump(struct rte_eventdev *dev, FILE *f)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	int32_t pool_on_loan, pool_avail;
+
+	if (dev == NULL || f == NULL)
+		return;
+
+	pool_on_loan = rte_atomic_load_explicit(&slb->credits_on_loan,
+						rte_memory_order_relaxed);
+	pool_avail = slb->max_inflight - pool_on_loan;
+
+	fprintf(f, "\n[SLB EVENTDEV DEBUG STATS]\n");
+	fprintf(f, "  Device ID: %u, Driver: %s\n", dev->data->dev_id,
+		SLB_PMD_NAME);
+	fprintf(f, "  Credit Pool: %d on_loan / %d max_inflight (%d avail)\n",
+		pool_on_loan, slb->max_inflight, pool_avail);
+
+	fprintf(f, "\n  PORT STATISTICS & QUEUE LINKAGES:\n");
+	for (int i = 0; i < slb->num_ports; i++) {
+		struct slb_port *p = &slb->ports[i];
+		uint64_t aq = rte_atomic_load_explicit(&p->active_queues,
+						       rte_memory_order_acquire);
+		fprintf(f, "    Port %2u (credits=%3d, active=0x%08" PRIx64 "): ",
+			i, p->inflight_credits, aq);
+		int linked_count = 0;
+		if (p->is_single_linked) {
+			if (p->single_linked_q) {
+				int qid = p->single_linked_q - slb->queues;
+				fprintf(f, "Q%d (single-link)", qid);
+				linked_count++;
+			}
+		} else {
+			for (int pr = 0; pr < SLB_MAX_PRIORITIES; pr++) {
+				for (int s = 0; s < p->num_q[pr]; s++) {
+					int qid = p->q_entries[pr][s].queue_id;
+					if (linked_count > 0)
+						fprintf(f, ", ");
+					fprintf(f, "Q%d(p%d)", qid, pr);
+					linked_count++;
+				}
+			}
+		}
+		if (linked_count == 0)
+			fprintf(f, "(no queues linked)");
+		fprintf(f, "\n");
+	}
+
+	fprintf(f, "\n  ALL QUEUES STATUS:\n");
+	for (int i = 0; i < slb->num_queues; i++) {
+		struct slb_queue *q = &slb->queues[i];
+		uint32_t count = rte_event_ring_count(q->q_ring);
+		uint32_t ring_size = rte_event_ring_get_capacity(q->q_ring);
+		fprintf(f, "    Queue %2u: %6u/%6u events, serving_ports=0x%016" PRIx64 ", sched=%u, single=%d\n",
+			i, count, ring_size, q->serving_ports_mask,
+			q->schedule_type, q->is_single_link);
+	}
+	fprintf(f, "[END DEBUG]\n\n");
+	fflush(f);
+}
+
+static struct eventdev_ops slb_evdev_ops = {
+	.port_setup = slb_port_setup,
+	.port_def_conf = slb_port_def_conf,
+	.port_release = slb_port_release,
+	.queue_setup = slb_queue_setup,
+	.queue_def_conf = slb_queue_def_conf,
+	.queue_release = slb_queue_release,
+	.port_link = slb_port_link,
+	.port_unlink = slb_port_unlink,
+	.dev_infos_get = slb_info_get,
+	.dev_configure = slb_configure,
+	.dev_start = slb_start,
+	.dev_stop = slb_stop,
+	.dev_close = slb_close,
+	.dump = slb_dump,
+};
+
+static int
+slb_probe(struct rte_vdev_device *vdev)
+{
+	const char *name = rte_vdev_device_name(vdev);
+	struct rte_eventdev *dev;
+	struct slb_evdev *slb;
+
+	dev = rte_event_pmd_vdev_init(name, sizeof(struct slb_evdev),
+				      rte_socket_id(), vdev);
+	if (dev == NULL)
+		return -EFAULT;
+
+	dev->dev_ops = &slb_evdev_ops;
+	dev->enqueue_burst = slb_event_enqueue_burst;
+	dev->enqueue_new_burst = slb_event_enqueue_new_burst;
+	dev->enqueue_forward_burst = slb_event_enqueue_forward_burst;
+	dev->dequeue_burst = slb_event_dequeue_burst;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	slb = dev->data->dev_private;
+	slb->data = dev->data;
+
+	event_dev_probing_finish(dev);
+	return 0;
+}
+
+static int
+slb_remove(struct rte_vdev_device *vdev)
+{
+	const char *name = rte_vdev_device_name(vdev);
+
+	if (name == NULL)
+		return -EINVAL;
+
+	return rte_event_pmd_vdev_uninit(name);
+}
+
+static struct rte_vdev_driver evdev_slb_pmd_drv = {
+	.probe = slb_probe,
+	.remove = slb_remove
+};
+
+RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_SLB_PMD, evdev_slb_pmd_drv);
+RTE_LOG_REGISTER_DEFAULT(event_slb_logtype, NOTICE);
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
new file mode 100644
index 0000000000..d7be6746ef
--- /dev/null
+++ b/drivers/event/slb/slb_evdev.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
+ */
+
+#ifndef _SLB_EVDEV_H_
+#define _SLB_EVDEV_H_
+
+#include <rte_bitops.h>
+#include <rte_bitset.h>
+#include <rte_event_ring.h>
+#include <rte_eventdev.h>
+#include <rte_stdatomic.h>
+#include <eventdev_pmd.h>
+
+#define SLB_PMD_NAME RTE_STR(event_slb)
+
+#define SLB_MAX_PORTS (64)
+#define SLB_MAX_PORT_DEQUEUE_DEPTH (128)
+#define SLB_MAX_PORT_ENQUEUE_DEPTH (128)
+
+#define SLB_MAX_QUEUES (64)
+
+#define SLB_MAX_EVENTS (16384)
+
+#define SLB_MAX_FLOWS_BITS (16)
+#define SLB_MAX_FLOWS (1 << (SLB_MAX_FLOWS_BITS))
+#define SLB_MAX_FLOWS_MASK (SLB_MAX_FLOWS - 1)
+
+/* Avoid making small 'loans' from the central in-flight event credit pool */
+#define SLB_MIN_CREDIT_LOAN (512)
+#define SLB_PORT_MAX_CREDITS (2 * SLB_MIN_CREDIT_LOAN)
+#define SLB_PORT_MIN_CREDITS (SLB_MIN_CREDIT_LOAN)
+
+#define SLB_IN_RING_SIZE (SLB_MAX_EVENTS)
+
+/* Maximum number of queues that can be linked to a port per priority */
+#define SLB_PORT_MAX_Q_MAP_PER_PRIO (SLB_MAX_QUEUES)
+/* Number of priority levels supported by SLB. Configure 1..4. */
+#ifndef SLB_MAX_PRIORITIES
+#define SLB_MAX_PRIORITIES 2
+#endif
+
+#if (SLB_MAX_PRIORITIES < 1) || (SLB_MAX_PRIORITIES > 4)
+#error "SLB_MAX_PRIORITIES must be between 1 and 4"
+#endif
+
+/* Total max mapping slots (per-prio * priorities) */
+#define SLB_PORT_MAX_Q_MAP (SLB_PORT_MAX_Q_MAP_PER_PRIO * SLB_MAX_PRIORITIES)
+
+struct slb_queue;
+
+/* Pre-resolved queue dequeue entry for core-local port access */
+struct slb_port_q_entry {
+	struct rte_event_ring *dq_ring;
+	struct slb_queue *queue;
+	uint8_t queue_id;
+	uint8_t schedule_type;
+	uint8_t pad[6];
+};
+
+struct __rte_cache_aligned slb_port {
+	/* --- Cacheline 0: Hot Rx & Tx scheduling control (64 bytes) --- */
+	uint16_t id;
+	int32_t inflight_credits;
+	int32_t new_event_threshold;
+	RTE_ATOMIC(uint64_t) active_queues;
+	uint16_t num_q[SLB_MAX_PRIORITIES];
+	uint16_t next_q[SLB_MAX_PRIORITIES];
+	bool is_single_linked;
+	bool implicit_release;
+	bool credits_drained;
+	bool remap_input_q;
+	uint8_t pad_port[4];
+	struct rte_event_ring *single_linked_ring;
+	struct slb_evdev *slb;
+
+	/* --- Cachelines 1..6: Pre-resolved queue mappings for dequeue --- */
+	alignas(RTE_CACHE_LINE_SIZE)
+	struct slb_port_q_entry q_entries[SLB_MAX_PRIORITIES][SLB_PORT_MAX_Q_MAP_PER_PRIO];
+
+	/* --- Cold Section: Statistics counters and config --- */
+	alignas(RTE_CACHE_LINE_SIZE)
+	uint16_t dequeue_depth;
+	uint16_t enqueue_depth;
+	struct slb_queue *single_linked_q;
+	uint64_t enqueue_calls;
+	uint64_t new_enqueued;
+	uint64_t forward_enqueued;
+	uint64_t release_enqueued;
+	uint64_t dequeue_calls;
+	uint64_t dequeued;
+	uint64_t empty_dequeues;
+	uint64_t total_dequeues;
+	uint64_t queue_enqueued[SLB_MAX_QUEUES];
+	uint64_t queue_dequeued[SLB_MAX_QUEUES];
+};
+
+struct slb_queue {
+	uint8_t schedule_type;
+	bool is_single_link;
+	uint16_t num_serving_ports;
+	uint64_t serving_ports_mask;
+	alignas(RTE_CACHE_LINE_SIZE) struct rte_event_ring *q_ring;
+};
+
+/* Limited by the size of 'serving_ports_mask' and 'active_queues' bitmasks */
+static_assert(SLB_MAX_PORTS <= 64, "Max compile-time port count exceeded");
+static_assert(SLB_MAX_QUEUES <= 64, "Max compile-time queue count exceeded");
+
+struct slb_evdev {
+	struct rte_eventdev_data *data;
+
+	struct slb_port ports[SLB_MAX_PORTS];
+	uint16_t num_ports;
+	struct slb_queue queues[SLB_MAX_QUEUES];
+	uint8_t num_queues;
+	int32_t max_inflight;
+
+	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(int32_t) credits_on_loan;
+};
+
+uint16_t slb_event_enqueue_burst(void *port,
+				 const struct rte_event events[],
+				 uint16_t events_len);
+uint16_t slb_event_enqueue_new_burst(void *port,
+				     const struct rte_event events[],
+				     uint16_t events_len);
+uint16_t slb_event_enqueue_forward_burst(void *port,
+					 const struct rte_event events[],
+					 uint16_t events_len);
+
+uint16_t slb_event_dequeue_burst(void *port, struct rte_event *events,
+				 uint16_t num, uint64_t wait);
+
+void slb_port_return_credits(struct slb_evdev *slb, struct slb_port *port,
+			     int32_t credits);
+
+void slb_dump(struct rte_eventdev *dev, FILE *f);
+
+static inline struct slb_evdev *
+slb_pmd_priv(const struct rte_eventdev *eventdev)
+{
+	return eventdev->data->dev_private;
+}
+
+extern int event_slb_logtype;
+#define RTE_LOGTYPE_EVENT_SLB event_slb_logtype
+#define SLB_LOG_DP_LINE(level, fmt, ...)				\
+	RTE_LOG_DP_LINE(level, EVENT_SLB, "%s() line %u: " fmt,		\
+		   __func__, __LINE__, ## __VA_ARGS__)
+
+#define SLB_LOG_DP_PORT_LINE(level, port_id, fmt, ...)			\
+	SLB_LOG_DP_LINE(level, "<Port %d> " fmt, port_id, ## __VA_ARGS__)
+
+/* Obtain serving port masks for the specified queue and set corresponding
+ * active queue bits for all served ports.
+ */
+static inline void
+slb_port_wakeup_queues(struct slb_evdev *slb, struct slb_queue *queue)
+{
+	uint8_t queue_id = queue - slb->queues;
+	uint64_t port_mask = queue->serving_ports_mask;
+	struct slb_port *port;
+	uint8_t port_id;
+
+	while (port_mask) {
+		port_id = rte_ctz64(port_mask);
+		port = &slb->ports[port_id];
+		rte_atomic_fetch_or_explicit(&port->active_queues,
+					     (1ULL << queue_id),
+					     rte_memory_order_release);
+		port_mask &= ~(1ULL << port_id);
+	}
+}
+
+#endif /* _SLB_EVDEV_H_ */
diff --git a/drivers/event/slb/slb_event.c b/drivers/event/slb/slb_event.c
new file mode 100644
index 0000000000..f55262154e
--- /dev/null
+++ b/drivers/event/slb/slb_event.c
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
+ */
+
+#include <stdbool.h>
+#include <rte_cycles.h>
+#include <rte_ring_elem.h>
+#include <rte_stdatomic.h>
+
+#include "slb_evdev.h"
+
+/* Acquire credits for new events */
+static bool
+slb_port_acquire_credits(struct slb_evdev *slb, struct slb_port *port,
+			 int32_t credits)
+{
+	int32_t inflight_credits = port->inflight_credits;
+	int32_t remaining_credits = inflight_credits - credits;
+	int32_t total_inflight;
+	int32_t available;
+	int32_t required_credits;
+	int32_t new_total_inflight;
+
+	/* If port has enough credits, update and return true */
+	if (likely(remaining_credits >= 0)) {
+		port->inflight_credits = remaining_credits;
+		return true;
+	}
+
+	total_inflight = rte_atomic_load_explicit(&slb->credits_on_loan,
+						  rte_memory_order_relaxed);
+	available = slb->max_inflight - total_inflight;
+	required_credits = RTE_MAX(abs(remaining_credits), SLB_PORT_MIN_CREDITS);
+
+	if (available < required_credits)
+		return false;
+
+	new_total_inflight =
+		rte_atomic_fetch_add_explicit(&slb->credits_on_loan,
+					      required_credits,
+					      rte_memory_order_relaxed) +
+					      required_credits;
+
+	if (unlikely(new_total_inflight > slb->max_inflight)) {
+		rte_atomic_fetch_sub_explicit(&slb->credits_on_loan,
+					      required_credits,
+					      rte_memory_order_relaxed);
+		return false;
+	}
+
+	port->inflight_credits += required_credits;
+	port->inflight_credits -= credits;
+
+	return true;
+}
+
+/* Return accumulated credits (Terminated events) */
+void
+slb_port_return_credits(struct slb_evdev *slb, struct slb_port *port,
+			int32_t credits)
+{
+	port->inflight_credits += credits;
+
+	if (unlikely(port->inflight_credits >= SLB_PORT_MAX_CREDITS)) {
+		int32_t return_credits = port->inflight_credits -
+					 SLB_PORT_MIN_CREDITS;
+		port->inflight_credits = SLB_PORT_MIN_CREDITS;
+
+		rte_atomic_fetch_sub_explicit(&slb->credits_on_loan,
+					      return_credits,
+					      rte_memory_order_release);
+	}
+}
+
+static void
+slb_port_enqueue_stats(struct slb_port *port, uint16_t num_new,
+		       uint16_t num_forward, uint16_t num_release)
+{
+	port->new_enqueued += num_new;
+	port->forward_enqueued += num_forward;
+	port->release_enqueued += num_release;
+}
+
+static void
+slb_port_queue_enqueue_burst_stats(struct slb_port *source_port,
+				   uint8_t queue_id, uint16_t num)
+{
+	source_port->queue_enqueued[queue_id] += num;
+}
+
+static inline uint16_t
+slb_event_enqueue_burst_generic(struct slb_port *source_port,
+				const struct rte_event events[],
+				uint16_t events_len, bool op_types_known,
+				uint16_t num_new, uint16_t num_forward,
+				uint16_t num_release)
+{
+	struct slb_evdev *slb = source_port->slb;
+	uint16_t enqueued = 0;
+	uint16_t idx = 0;
+
+	if (unlikely(events_len == 0))
+		return 0;
+
+	if (!op_types_known) {
+		for (uint16_t i = 0; i < events_len; i++) {
+			switch (events[i].op) {
+			case RTE_EVENT_OP_NEW:
+				num_new++;
+				break;
+			case RTE_EVENT_OP_FORWARD:
+				num_forward++;
+				break;
+			case RTE_EVENT_OP_RELEASE:
+				num_release++;
+				break;
+			}
+		}
+	}
+
+	/* Check credit threshold for NEW events */
+	if (num_new > 0) {
+		if (unlikely(rte_atomic_load_explicit(&slb->credits_on_loan,
+						      rte_memory_order_relaxed) >
+			     source_port->new_event_threshold))
+			return 0;
+
+		if (unlikely(!slb_port_acquire_credits(slb, source_port,
+						       num_new)))
+			return 0;
+	}
+
+	if (num_release > 0)
+		slb_port_return_credits(slb, source_port, num_release);
+
+	slb_port_enqueue_stats(source_port, num_new, num_forward, num_release);
+
+	/* Enqueue contiguous chunks targeting the same queue */
+	while (idx < events_len) {
+		if (events[idx].op == RTE_EVENT_OP_RELEASE) {
+			idx++;
+			enqueued++;
+			continue;
+		}
+
+		uint8_t qid = events[idx].queue_id;
+		uint16_t chunk_len = 1;
+
+		while (idx + chunk_len < events_len &&
+		       events[idx + chunk_len].queue_id == qid &&
+		       events[idx + chunk_len].op != RTE_EVENT_OP_RELEASE) {
+			chunk_len++;
+		}
+
+		struct slb_queue *queue = &slb->queues[qid];
+		uint16_t actual_enq = rte_event_ring_enqueue_burst(queue->q_ring,
+								  &events[idx],
+								  chunk_len,
+								  NULL);
+		slb_port_queue_enqueue_burst_stats(source_port, qid, actual_enq);
+		enqueued += actual_enq;
+
+		if (actual_enq < chunk_len) {
+			/* If queue ring is full, return unused credits for dropped NEW events */
+			uint16_t dropped_new = 0;
+			for (uint16_t d = actual_enq; d < chunk_len; d++) {
+				if (events[idx + d].op == RTE_EVENT_OP_NEW)
+					dropped_new++;
+			}
+			if (dropped_new > 0)
+				slb_port_return_credits(slb, source_port, dropped_new);
+			break;
+		}
+
+		idx += chunk_len;
+	}
+
+	return enqueued;
+}
+
+uint16_t
+slb_event_enqueue_burst(void *port, const struct rte_event events[],
+			uint16_t events_len)
+{
+	struct slb_port *source_port = port;
+	return slb_event_enqueue_burst_generic(source_port, events, events_len,
+					       false, 0, 0, 0);
+}
+
+uint16_t
+slb_event_enqueue_new_burst(void *port, const struct rte_event events[],
+			    uint16_t events_len)
+{
+	struct slb_port *source_port = port;
+	return slb_event_enqueue_burst_generic(source_port, events, events_len,
+					       true, events_len, 0, 0);
+}
+
+uint16_t
+slb_event_enqueue_forward_burst(void *port, const struct rte_event events[],
+				uint16_t events_len)
+{
+	struct slb_port *source_port = port;
+	return slb_event_enqueue_burst_generic(source_port, events, events_len,
+					       true, 0, events_len, 0);
+}
+
+static inline uint16_t
+slb_port_dequeue(struct slb_port *port, struct rte_event events[],
+		 uint16_t num)
+{
+	uint16_t total_deq = 0;
+
+	/* Single-link direct fast path */
+	if (port->is_single_linked) {
+		if (unlikely(!port->single_linked_ring))
+			return 0;
+
+		total_deq = rte_event_ring_dequeue_burst(port->single_linked_ring,
+							events, num, NULL);
+		if (total_deq > 0) {
+			port->total_dequeues += total_deq;
+			if (port->implicit_release)
+				slb_port_return_credits(port->slb, port,
+							total_deq);
+		}
+		return total_deq;
+	}
+
+	/* Parallel queue dequeue across priority levels */
+	for (int p = 0; p < SLB_MAX_PRIORITIES; p++) {
+		uint16_t num_q = port->num_q[p];
+		if (num_q == 0)
+			continue;
+
+		uint16_t q_idx = port->next_q[p];
+		for (uint16_t i = 0; i < num_q; i++) {
+			struct slb_port_q_entry *entry = &port->q_entries[p][q_idx];
+			uint16_t req = num - total_deq;
+			uint16_t deq = rte_event_ring_dequeue_burst(entry->dq_ring,
+								   &events[total_deq],
+								   req, NULL);
+			if (deq > 0) {
+				port->queue_dequeued[entry->queue_id] += deq;
+				total_deq += deq;
+			}
+
+			q_idx++;
+			if (q_idx >= num_q)
+				q_idx = 0;
+
+			if (total_deq == num)
+				break;
+		}
+		port->next_q[p] = q_idx;
+
+		if (total_deq > 0)
+			break;
+	}
+
+	port->total_dequeues += total_deq;
+	return total_deq;
+}
+
+uint16_t
+slb_event_dequeue_burst(void *p, struct rte_event events[], uint16_t num,
+			uint64_t wait __rte_unused)
+{
+	struct slb_port *port = p;
+
+	port->dequeue_calls++;
+	uint16_t dequeued = slb_port_dequeue(port, events, num);
+	port->dequeued += dequeued;
+
+	if (dequeued == 0)
+		port->empty_dequeues++;
+
+	return dequeued;
+}
-- 
2.53.0

