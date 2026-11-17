Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C81606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vJHNiJnD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 034FF4060C;
	Tue, 17 Nov 2026 18:57:36 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 8683240374
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:57:31 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-91eb46044c4so80146396d6.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794938250; x=1795543050; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rpCvf/cAwEsSPseSJWW6891HhRF77hh8HtqHHwJAgak=;
 b=vJHNiJnDRkS9Knht1ThUn2e/2OFe+WXENLFb8Fcsc1QSQHeEug4NnI9pyRPOhsTcQZ
 HBkKwgjPYOYxQm/Yx+14x3GV0zYhoTVzCyoYuoX51ABFek9BC4kpLjqNcG8B8ZatDmAy
 k1cJrxoxXvIEk9w/BTLJ8JG5jmesd6pbqiWOPBkY0YrwaifJEz+VcyVdEGcBr5poknsJ
 L1qbb2u1il/xD2YF7Wb5Ge9XnQFV1xTDURrWHBEE132Hvu4BeNV7xfzV7iSWhe+ApP4L
 pf70IDQxWxuZWPg9JlfIP+Evkp2SwwplZLnWKh7uh08sE/Y2ZZ5g97MoP2IBFklAnoi2
 4Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938250; x=1795543050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rpCvf/cAwEsSPseSJWW6891HhRF77hh8HtqHHwJAgak=;
 b=welOC/ZbEuzMgJLu0eD98u+BE8/L37Xa0lgk8P4Gy37XmJlkQuozOb6Fl7STYJ9woJ
 ks6AceohBkWvZUFs+hUeScal1eKaNtg4WSPHIt93TkT0lYwAcWiTDxm4HrgkcQzHZeIn
 upvAPq15cW4ICPGyayN/36RfA5YWxvezfDi4p/gQDoSh9yl281bvDx6SD79BMz4aQN7j
 tOxrccI3el+knhOQSHPlgJg8OGGU6wGc2CZD0IFE1ZKVxXaOQ3/K/UKzLp5sSAB1LSey
 nmgZ6Id5Rjn/jVXpkdbUvZPtbfViNFeBssqo50XeKFfPkpVE5ERsgQWfNHOSrLGe5rPS
 I9xw==
X-Gm-Message-State: APuU4Z/Y8bn8TY07jXR1r9BZ9tLnC9MNjCQ/lDKoNXSCrE39yVLqYMb5
 pqLlse1IcHwpLF1/OVSAhvcwQzd0a1eaqHUvI3zMijSkU8ZEsXAGP/uPn+yvTOIN
X-Gm-Gg: AZFdTZf1/zvOix0uZdXa3lse+Jim/h5YsdFtPJPiOM/6t7kmlkVXDhvamYMep7pWP8c
 r5OYKf2/RsL9y/gjidr2pDUG8H78GFKkLLemmNFHWSx0HRSnNcQiBasSECpIyN2ludXh/b8uxH3
 xru6Hto5S4P6sUot6LCr0tA06kK/q77rGs2XHvBT7psMhmZ9jRnclf3EAWkiNsq+YKtX0HZEROz
 Hk343BObrsA5zjA6j1MKYA87r+hUZacRg2BSfwiPkdGA+PK6E2LYe8UXiSRFkbs1uouQKxz9c8L
 TkTUSObp5g92HDA3iw6dAe/RS6H81AKW0iWM6jn+APnUSUJRkqdRqXLkCGIo4hs1Mk5KyDArb9x
 L1bzW9SVFfQdDIxCI3rimhgZFSkTtebD20cg8a5TuzOKGqE+q+X+qlSj36RziNXRse+xLvb6GST
 y2GStqA7u+DnrXN82qp9duO5kBouKT04Qm+GmH4yT9ZzxCc68kJphxwSb3P0AsSR3AlZaCxxxyZ
 CLoKZTvPsHZSRvbLU9mbkk8+YcqkutPHRH7ZM1HJ88t5qZNajO+e2FLoebjX9qBrDmus+NVkxCv
 fQqZJ3wPZ72qnn3wyQ1iQEwiYZtyp28J6MNTAyWHNyLRrjuGZTY+Ih+w62/AFeg6b144LZP9bik
 rXV8jaTC0koRztgFQA/ScdlSwrXO9+73I3UpF9FqOhGM6YjeUgN4C
X-Received: by 2002:a05:6214:f09:b0:915:3066:2035 with SMTP id
 6a1803df08f44-91f2409d646mr222808906d6.7.1794938250065; 
 Tue, 17 Nov 2026 09:57:30 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c29f7.dyn.optonline.net. [148.76.41.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921148c261bsm327426d6.0.2026.11.17.09.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:57:29 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 david.marchand@redhat.com, nipun.gupta@amd.com, chenbox@nvidia.com,
 tirthendu.sarkar@intel.com, mattias.ronnblom@ericsson.com,
 stephen@networkplumber.org, Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v2 6/8] event/slb: add self-test and documentation
Date: Tue, 17 Nov 2026 12:57:06 -0500
Message-ID: <20261117175709.2346400-7-pravinpathakdev@gmail.com>
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

Add driver self-test coverage and documentation for the Software
Load Balancer PMD.

The self-test verifies parallel queues, atomic queue flow ordering,
ordered queues with forward sequence restoration, single-link queues,
and device stop/restart event draining. Register the self-test in
app/test as a fast test.

Add PMD user guide, feature matrix table, release notes entry for
DPDK 26.11, and update MAINTAINERS.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 MAINTAINERS                           |   2 +
 app/test/test_eventdev.c              |   7 +
 doc/guides/eventdevs/features/slb.ini |  26 ++
 doc/guides/eventdevs/index.rst        |   1 +
 doc/guides/eventdevs/slb.rst          |  68 ++++
 drivers/event/slb/meson.build         |   1 +
 drivers/event/slb/slb_evdev.c         |   1 +
 drivers/event/slb/slb_evdev.h         |   4 +
 drivers/event/slb/slb_selftest.c      | 522 ++++++++++++++++++++++++++
 9 files changed, 632 insertions(+)
 create mode 100644 doc/guides/eventdevs/features/slb.ini
 create mode 100644 doc/guides/eventdevs/slb.rst
 create mode 100644 drivers/event/slb/slb_selftest.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a0dd5505f..611794a8f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1537,6 +1537,8 @@ F: doc/guides/eventdevs/dsw.rst
 Software Load Balancer (SLB) Eventdev PMD
 M: Pravin Pathak <pravin.pathak.dev@gmail.com>
 F: drivers/event/slb/
+F: doc/guides/eventdevs/slb.rst
+F: doc/guides/eventdevs/features/slb.ini
 
 Software OPDL Eventdev PMD
 M: Liang Ma <liangma@liangbit.com>
diff --git a/app/test/test_eventdev.c b/app/test/test_eventdev.c
index 1241da38cb..58ec440674 100644
--- a/app/test/test_eventdev.c
+++ b/app/test/test_eventdev.c
@@ -1527,12 +1527,19 @@ test_eventdev_selftest_cn20k(void)
 	return test_eventdev_selftest_impl("event_cn20k", "");
 }
 
+static int
+test_eventdev_selftest_slb(void)
+{
+	return test_eventdev_selftest_impl("event_slb", "");
+}
+
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
 REGISTER_FAST_TEST(eventdev_common_autotest, NOHUGE_OK, ASAN_OK, test_eventdev_common);
 
 #ifndef RTE_EXEC_ENV_WINDOWS
 REGISTER_FAST_TEST(eventdev_selftest_sw, NOHUGE_OK, ASAN_OK, test_eventdev_selftest_sw);
+REGISTER_FAST_TEST(eventdev_selftest_slb, NOHUGE_OK, ASAN_OK, test_eventdev_selftest_slb);
 REGISTER_DRIVER_TEST(eventdev_selftest_octeontx, test_eventdev_selftest_octeontx);
 REGISTER_DRIVER_TEST(eventdev_selftest_dpaa2, test_eventdev_selftest_dpaa2);
 REGISTER_DRIVER_TEST(eventdev_selftest_dlb2, test_eventdev_selftest_dlb2);
diff --git a/doc/guides/eventdevs/features/slb.ini b/doc/guides/eventdevs/features/slb.ini
new file mode 100644
index 0000000000..0364840bc9
--- /dev/null
+++ b/doc/guides/eventdevs/features/slb.ini
@@ -0,0 +1,26 @@
+;
+; Supported features of the 'software load balancer' (event_slb) eventdev driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Scheduling Features]
+atomic_scheduling          = Y
+ordered_scheduling         = Y
+parallel_scheduling        = Y
+distributed_sched          = Y
+burst_mode                 = Y
+implicit_release_disable   = Y
+nonseq_mode                = Y
+runtime_port_link          = Y
+multiple_queue_port        = Y
+carry_flow_id              = Y
+maintenance_free           = Y
+independent_enq            = Y
+
+[Eth Rx adapter Features]
+
+[Eth Tx adapter Features]
+
+[Crypto adapter Features]
+
+[Timer adapter Features]
diff --git a/doc/guides/eventdevs/index.rst b/doc/guides/eventdevs/index.rst
index 69a5ebf812..fdaf846503 100644
--- a/doc/guides/eventdevs/index.rst
+++ b/doc/guides/eventdevs/index.rst
@@ -20,3 +20,4 @@ application through the eventdev API.
     sw
     octeontx
     opdl
+    slb
diff --git a/doc/guides/eventdevs/slb.rst b/doc/guides/eventdevs/slb.rst
new file mode 100644
index 0000000000..d319b94920
--- /dev/null
+++ b/doc/guides/eventdevs/slb.rst
@@ -0,0 +1,68 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
+
+Software Load Balancer (SLB) Eventdev Driver
+============================================
+
+The Software Load Balancer (SLB) event device is a poll-mode eventdev driver
+which distributes events among multiple worker ports and cores without requiring
+dedicated scheduling service cores or hardware coprocessors.
+
+Features
+--------
+
+Queues
+~~~~~~
+
+* **Parallel**: Lock-free multi-producer, multi-consumer ring-based queue allowing
+  concurrent dequeues across all serving worker ports.
+* **Atomic**: Flow-pinned scheduling guaranteeing strict per-flow packet ordering.
+  Includes dynamic load tracking and automatic flow migration to rebalance overloaded
+  ports while preserving in-flight sequence integrity.
+* **Ordered**: Ticket-based sequence tracking and reorder buffer providing end-to-end
+  packet order restoration across parallel processing workers.
+* **Single-Link**: Dedicated direct queue mapping from a producer port to a single
+  consumer port using optimized single-consumer rings.
+
+Ports & Scheduling Capabilities
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* **Distributed Scheduling**: No dedicated service core required; scheduling work is
+  performed inline during enqueue and dequeue operations.
+* **Prefix Sum Burst Enqueue**: Interleaved multi-queue bursts are grouped and scattered
+  via prefix-sum offsets, dispatching single batched bursts to queue rings to eliminate
+  atomic Compare-And-Swap contention on multi-producer rings.
+* **Dynamic Flow Migration**: Atomic queues monitor port dequeue loads and migrate
+  eligible victim flows from overloaded ports to underloaded ports with cooling cycles.
+* **Credit Pool Management**: Centralized event credit pool with per-port credit caching
+  to enforce device-wide in-flight event limits (``max_num_events``).
+* **Runtime Port Linking**: Supports dynamic linking and unlinking of ports and queues
+  both when stopped and at runtime.
+* **Maintenance Free**: Operates without requiring periodic maintenance calls
+  (``RTE_EVENT_DEV_CAP_MAINTENANCE_FREE``).
+
+Configuration and Options
+-------------------------
+
+The SLB event device is a virtual device (vdev) and can be initialized from the
+application code or from the EAL command line:
+
+* From application code:
+
+  .. code-block:: c
+
+      rte_vdev_init("event_slb0", NULL);
+
+* From EAL command-line options:
+
+  .. code-block:: console
+
+      ./your_dpdk_application --vdev="event_slb0"
+
+Limitations
+-----------
+
+* **Flow Hash Table Size**: Atomic queues use an internal flow mapping table
+  dimensioned to 2048 concurrent active flows per queue (``SLB_ATOMIC_FLOWS``).
+* **Maximum Ports and Queues**: Configured for up to 64 ports (``SLB_MAX_PORTS``)
+  and 64 queues (``SLB_MAX_QUEUES``).
diff --git a/drivers/event/slb/meson.build b/drivers/event/slb/meson.build
index d698a58f16..6caf48720f 100644
--- a/drivers/event/slb/meson.build
+++ b/drivers/event/slb/meson.build
@@ -11,6 +11,7 @@ sources = files(
         'slb_evdev.c',
         'slb_event.c',
         'slb_xstats.c',
+        'slb_selftest.c',
 )
 
 deps += ['bus_vdev', 'ring']
diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
index 04a2aba165..c86b934b03 100644
--- a/drivers/event/slb/slb_evdev.c
+++ b/drivers/event/slb/slb_evdev.c
@@ -758,6 +758,7 @@ static struct eventdev_ops slb_evdev_ops = {
 	.xstats_get = slb_xstats_get,
 	.xstats_get_names = slb_xstats_get_names,
 	.xstats_get_by_name = slb_xstats_get_by_name,
+	.dev_selftest = test_slb_eventdev,
 };
 
 static int
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
index 17f3154efa..f727a1b83c 100644
--- a/drivers/event/slb/slb_evdev.h
+++ b/drivers/event/slb/slb_evdev.h
@@ -242,6 +242,8 @@ int slb_xstats_get(const struct rte_eventdev *dev,
 uint64_t slb_xstats_get_by_name(const struct rte_eventdev *dev,
 				const char *name, uint64_t *id);
 
+int test_slb_eventdev(void);
+
 static inline struct slb_evdev *
 slb_pmd_priv(const struct rte_eventdev *eventdev)
 {
@@ -250,6 +252,8 @@ slb_pmd_priv(const struct rte_eventdev *eventdev)
 
 extern int event_slb_logtype;
 #define RTE_LOGTYPE_EVENT_SLB event_slb_logtype
+#define SLB_LOG_LINE(level, ...) \
+	RTE_LOG_LINE(level, EVENT_SLB, __VA_ARGS__)
 #define SLB_LOG_DP_LINE(level, fmt, ...)				\
 	RTE_LOG_DP_LINE(level, EVENT_SLB, "%s() line %u: " fmt,		\
 		   __func__, __LINE__, ## __VA_ARGS__)
diff --git a/drivers/event/slb/slb_selftest.c b/drivers/event/slb/slb_selftest.c
new file mode 100644
index 0000000000..4a072b811b
--- /dev/null
+++ b/drivers/event/slb/slb_selftest.c
@@ -0,0 +1,522 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <inttypes.h>
+
+#include <rte_bus_vdev.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_eventdev.h>
+
+#include "slb_evdev.h"
+
+#define NUM_PORTS 4
+#define NUM_QUEUES 4
+#define PORT_PROD 0
+#define PORT_W1   1
+#define PORT_W2   2
+#define PORT_CONS 3
+
+#define Q_PARALLEL 0
+#define Q_ATOMIC   1
+#define Q_ORDERED  2
+#define Q_SINGLE   3
+
+#define NUM_FLOWS 4
+#define EVENTS_PER_FLOW 16
+#define TOTAL_ATOMIC_EVENTS (NUM_FLOWS * EVENTS_PER_FLOW)
+
+static int g_dev_id = -1;
+
+static int
+init_selftest_device(void)
+{
+	struct rte_event_dev_config dev_conf = {
+		.dequeue_timeout_ns = 0,
+		.nb_event_queues = NUM_QUEUES,
+		.nb_event_ports = NUM_PORTS,
+		.nb_events_limit = 4096,
+		.nb_event_queue_flows = 1024,
+		.nb_event_port_dequeue_depth = 64,
+		.nb_event_port_enqueue_depth = 64,
+	};
+	struct rte_event_queue_conf q_conf;
+	struct rte_event_port_conf p_conf = {
+		.dequeue_depth = 64,
+		.enqueue_depth = 64,
+		.new_event_threshold = 2048,
+		.event_port_cfg = 0
+	};
+	struct rte_event_dev_info info;
+	uint8_t ldb_queues[] = { Q_PARALLEL, Q_ATOMIC, Q_ORDERED };
+	uint8_t single_q = Q_SINGLE;
+	int ret;
+	int p;
+
+	g_dev_id = rte_event_dev_get_dev_id(SLB_PMD_NAME);
+	if (g_dev_id < 0) {
+		ret = rte_vdev_init("event_slb_selftest", NULL);
+		if (ret < 0) {
+			SLB_LOG_LINE(ERR, "Failed to init vdev event_slb_selftest");
+			return -1;
+		}
+		g_dev_id = rte_event_dev_get_dev_id("event_slb_selftest");
+		if (g_dev_id < 0) {
+			SLB_LOG_LINE(ERR, "Cannot find initialized vdev");
+			return -1;
+		}
+	}
+
+	ret = rte_event_dev_info_get(g_dev_id, &info);
+	if (ret < 0) {
+		SLB_LOG_LINE(ERR, "Failed to get dev info");
+		return -1;
+	}
+
+	ret = rte_event_dev_configure(g_dev_id, &dev_conf);
+	if (ret < 0) {
+		SLB_LOG_LINE(ERR, "Failed to configure device, ret=%d", ret);
+		return -1;
+	}
+
+	/* Setup Queues */
+	memset(&q_conf, 0, sizeof(q_conf));
+	q_conf.nb_atomic_flows = 1024;
+	q_conf.nb_atomic_order_sequences = 1024;
+	q_conf.priority = RTE_EVENT_DEV_PRIORITY_NORMAL;
+
+	/* Q0: Parallel */
+	q_conf.schedule_type = RTE_SCHED_TYPE_PARALLEL;
+	q_conf.event_queue_cfg = 0;
+	ret = rte_event_queue_setup(g_dev_id, Q_PARALLEL, &q_conf);
+	if (ret < 0)
+		return -1;
+
+	/* Q1: Atomic */
+	q_conf.schedule_type = RTE_SCHED_TYPE_ATOMIC;
+	q_conf.event_queue_cfg = 0;
+	ret = rte_event_queue_setup(g_dev_id, Q_ATOMIC, &q_conf);
+	if (ret < 0)
+		return -1;
+
+	/* Q2: Ordered */
+	q_conf.schedule_type = RTE_SCHED_TYPE_ORDERED;
+	q_conf.event_queue_cfg = 0;
+	ret = rte_event_queue_setup(g_dev_id, Q_ORDERED, &q_conf);
+	if (ret < 0)
+		return -1;
+
+	/* Q3: Single-link */
+	q_conf.schedule_type = RTE_SCHED_TYPE_PARALLEL;
+	q_conf.event_queue_cfg = RTE_EVENT_QUEUE_CFG_SINGLE_LINK;
+	ret = rte_event_queue_setup(g_dev_id, Q_SINGLE, &q_conf);
+	if (ret < 0)
+		return -1;
+
+	/* Setup Ports */
+	for (p = 0; p < NUM_PORTS; p++) {
+		if (p == PORT_CONS)
+			p_conf.event_port_cfg = RTE_EVENT_PORT_CFG_SINGLE_LINK;
+		else
+			p_conf.event_port_cfg = 0;
+
+		ret = rte_event_port_setup(g_dev_id, p, &p_conf);
+		if (ret < 0)
+			return -1;
+	}
+
+	/* Link Queues */
+	ret = rte_event_port_link(g_dev_id, PORT_W1, ldb_queues, NULL, 3);
+	if (ret != 3)
+		return -1;
+
+	ret = rte_event_port_link(g_dev_id, PORT_W2, ldb_queues, NULL, 3);
+	if (ret != 3)
+		return -1;
+
+	ret = rte_event_port_link(g_dev_id, PORT_CONS, &single_q, NULL, 1);
+	if (ret != 1)
+		return -1;
+
+	ret = rte_event_dev_start(g_dev_id);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static void
+cleanup_selftest_device(void)
+{
+	if (g_dev_id >= 0) {
+		rte_event_dev_stop(g_dev_id);
+		rte_event_dev_close(g_dev_id);
+		g_dev_id = -1;
+	}
+}
+
+static int
+test_parallel_queue(void)
+{
+	struct rte_event rx_ev[32];
+	struct rte_event ev[32];
+	uint16_t enqd, deqd = 0;
+	uint16_t n = 0;
+	int tries = 0;
+	int i;
+
+	memset(ev, 0, sizeof(ev));
+
+	for (i = 0; i < 32; i++) {
+		ev[i].op = RTE_EVENT_OP_NEW;
+		ev[i].sched_type = RTE_SCHED_TYPE_PARALLEL;
+		ev[i].queue_id = Q_PARALLEL;
+		ev[i].u64 = 1000 + i;
+	}
+
+	enqd = rte_event_enqueue_burst(g_dev_id, PORT_PROD, ev, 32);
+	if (enqd != 32) {
+		SLB_LOG_LINE(ERR, "Parallel enqueue failed, expected 32, got %u", enqd);
+		return -1;
+	}
+
+	while (deqd < 32 && tries++ < 1000) {
+		n = rte_event_dequeue_burst(g_dev_id, PORT_W1, rx_ev + deqd,
+					    32 - deqd, 0);
+		deqd += n;
+		if (deqd < 32) {
+			n = rte_event_dequeue_burst(g_dev_id, PORT_W2,
+						    rx_ev + deqd, 32 - deqd, 0);
+			deqd += n;
+		}
+	}
+
+	if (deqd != 32) {
+		SLB_LOG_LINE(ERR, "Parallel dequeue failed, expected 32, got %u", deqd);
+		return -1;
+	}
+
+	/* Release events */
+	for (i = 0; i < 32; i++)
+		rx_ev[i].op = RTE_EVENT_OP_RELEASE;
+	rte_event_enqueue_burst(g_dev_id, PORT_W1, rx_ev, 32);
+
+	return 0;
+}
+
+static int
+test_atomic_queue(void)
+{
+	struct rte_event rx_ev[64];
+	struct rte_event ev[64];
+	int expected_seq[NUM_FLOWS];
+	uint16_t enqd = 0;
+	uint16_t deqd = 0;
+	int tries = 0;
+	int idx = 0;
+	int e, f;
+	uint16_t i, n;
+
+	memset(ev, 0, sizeof(ev));
+
+	for (e = 0; e < EVENTS_PER_FLOW; e++) {
+		for (f = 0; f < NUM_FLOWS; f++) {
+			ev[idx].op = RTE_EVENT_OP_NEW;
+			ev[idx].sched_type = RTE_SCHED_TYPE_ATOMIC;
+			ev[idx].queue_id = Q_ATOMIC;
+			ev[idx].flow_id = f;
+			ev[idx].u64 = e; /* sequence number */
+			idx++;
+		}
+	}
+
+	while (enqd < TOTAL_ATOMIC_EVENTS) {
+		n = rte_event_enqueue_burst(g_dev_id, PORT_PROD, ev + enqd,
+					    TOTAL_ATOMIC_EVENTS - enqd);
+		if (n == 0)
+			break;
+		enqd += n;
+	}
+	if (enqd != TOTAL_ATOMIC_EVENTS) {
+		SLB_LOG_LINE(ERR, "Atomic enqueue failed, expected %d, got %u",
+			     TOTAL_ATOMIC_EVENTS, enqd);
+		return -1;
+	}
+
+	for (f = 0; f < NUM_FLOWS; f++)
+		expected_seq[f] = 0;
+
+	while (deqd < TOTAL_ATOMIC_EVENTS && tries++ < 2000) {
+		n = rte_event_dequeue_burst(g_dev_id, PORT_W1, rx_ev, 16, 0);
+		for (i = 0; i < n; i++) {
+			int fid = rx_ev[i].flow_id;
+
+			if (rx_ev[i].u64 != (uint64_t)expected_seq[fid]) {
+				SLB_LOG_LINE(ERR,
+					     "Flow %d out of order! Expected %d got %" PRIu64,
+					     fid, expected_seq[fid], rx_ev[i].u64);
+				return -1;
+			}
+			expected_seq[fid]++;
+			rx_ev[i].op = RTE_EVENT_OP_RELEASE;
+		}
+		if (n > 0)
+			rte_event_enqueue_burst(g_dev_id, PORT_W1, rx_ev, n);
+		deqd += n;
+
+		n = rte_event_dequeue_burst(g_dev_id, PORT_W2, rx_ev, 16, 0);
+		for (i = 0; i < n; i++) {
+			int fid = rx_ev[i].flow_id;
+
+			if (rx_ev[i].u64 != (uint64_t)expected_seq[fid]) {
+				SLB_LOG_LINE(ERR,
+					     "Flow %d out of order! Expected %d got %" PRIu64,
+					     fid, expected_seq[fid], rx_ev[i].u64);
+				return -1;
+			}
+			expected_seq[fid]++;
+			rx_ev[i].op = RTE_EVENT_OP_RELEASE;
+		}
+		if (n > 0)
+			rte_event_enqueue_burst(g_dev_id, PORT_W2, rx_ev, n);
+		deqd += n;
+	}
+
+	if (deqd != TOTAL_ATOMIC_EVENTS) {
+		SLB_LOG_LINE(ERR, "Atomic dequeue failed, expected %d got %u",
+			     TOTAL_ATOMIC_EVENTS, deqd);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+test_ordered_forward(void)
+{
+	const int num_events = 32;
+	struct rte_event rx[16];
+	struct rte_event ev[32];
+	uint16_t enqd;
+	uint16_t fwd = 0;
+	uint16_t cons_rx = 0;
+	int tries = 0;
+	int i;
+	uint16_t n;
+
+	memset(ev, 0, sizeof(ev));
+
+	for (i = 0; i < num_events; i++) {
+		ev[i].op = RTE_EVENT_OP_NEW;
+		ev[i].sched_type = RTE_SCHED_TYPE_ORDERED;
+		ev[i].queue_id = Q_ORDERED;
+		ev[i].u64 = i;
+	}
+
+	enqd = rte_event_enqueue_burst(g_dev_id, PORT_PROD, ev, num_events);
+	if (enqd != num_events)
+		return -1;
+
+	/* Workers dequeue and forward to Q_SINGLE */
+	while (fwd < num_events && tries++ < 2000) {
+		n = rte_event_dequeue_burst(g_dev_id, PORT_W1, rx, 16, 0);
+		for (i = 0; i < n; i++) {
+			rx[i].op = RTE_EVENT_OP_FORWARD;
+			rx[i].queue_id = Q_SINGLE;
+			rx[i].sched_type = RTE_SCHED_TYPE_PARALLEL;
+		}
+		if (n > 0)
+			rte_event_enqueue_burst(g_dev_id, PORT_W1, rx, n);
+		fwd += n;
+
+		n = rte_event_dequeue_burst(g_dev_id, PORT_W2, rx, 16, 0);
+		for (i = 0; i < n; i++) {
+			rx[i].op = RTE_EVENT_OP_FORWARD;
+			rx[i].queue_id = Q_SINGLE;
+			rx[i].sched_type = RTE_SCHED_TYPE_PARALLEL;
+		}
+		if (n > 0)
+			rte_event_enqueue_burst(g_dev_id, PORT_W2, rx, n);
+		fwd += n;
+	}
+
+	if (fwd != num_events) {
+		SLB_LOG_LINE(ERR, "Ordered workers failed to forward all events (%u/%d)",
+			     fwd, num_events);
+		return -1;
+	}
+
+	/* Consumer on PORT_CONS must receive all events in exact sequence 0..num_events-1 */
+	tries = 0;
+	while (cons_rx < num_events && tries++ < 2000) {
+		n = rte_event_dequeue_burst(g_dev_id, PORT_CONS, rx, 16, 0);
+		for (i = 0; i < n; i++) {
+			if (rx[i].u64 != cons_rx) {
+				SLB_LOG_LINE(ERR,
+					     "Ordered seq violation! Expected %u got %" PRIu64,
+					     cons_rx, rx[i].u64);
+				return -1;
+			}
+			cons_rx++;
+			rx[i].op = RTE_EVENT_OP_RELEASE;
+		}
+		if (n > 0)
+			rte_event_enqueue_burst(g_dev_id, PORT_CONS, rx, n);
+	}
+
+	if (cons_rx != num_events) {
+		SLB_LOG_LINE(ERR, "Consumer received %u/%d ordered events",
+			     cons_rx, num_events);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+test_single_link(void)
+{
+	struct rte_event rx[16];
+	struct rte_event ev[16];
+	uint16_t enqd;
+	uint16_t deqd = 0;
+	int tries = 0;
+	int i;
+	uint16_t n;
+
+	memset(ev, 0, sizeof(ev));
+
+	for (i = 0; i < 16; i++) {
+		ev[i].op = RTE_EVENT_OP_NEW;
+		ev[i].sched_type = RTE_SCHED_TYPE_PARALLEL;
+		ev[i].queue_id = Q_SINGLE;
+		ev[i].u64 = 5000 + i;
+	}
+
+	enqd = rte_event_enqueue_burst(g_dev_id, PORT_PROD, ev, 16);
+	if (enqd != 16)
+		return -1;
+
+	while (deqd < 16 && tries++ < 1000) {
+		n = rte_event_dequeue_burst(g_dev_id, PORT_CONS,
+					    rx + deqd, 16 - deqd, 0);
+		deqd += n;
+	}
+
+	if (deqd != 16) {
+		SLB_LOG_LINE(ERR, "Single-link dequeue failed (%u/16)", deqd);
+		return -1;
+	}
+
+	for (i = 0; i < 16; i++) {
+		if (rx[i].u64 != (uint64_t)(5000 + i))
+			return -1;
+		rx[i].op = RTE_EVENT_OP_RELEASE;
+	}
+	rte_event_enqueue_burst(g_dev_id, PORT_CONS, rx, 16);
+
+	return 0;
+}
+
+static int
+test_stop_flush(void)
+{
+	struct rte_event rx[16];
+	struct rte_event ev[16];
+	uint16_t enqd;
+	uint16_t deqd;
+	int ret;
+	int i;
+
+	memset(ev, 0, sizeof(ev));
+
+	for (i = 0; i < 16; i++) {
+		ev[i].op = RTE_EVENT_OP_NEW;
+		ev[i].sched_type = RTE_SCHED_TYPE_PARALLEL;
+		ev[i].queue_id = Q_PARALLEL;
+		ev[i].u64 = 9000 + i;
+	}
+
+	enqd = rte_event_enqueue_burst(g_dev_id, PORT_PROD, ev, 16);
+	if (enqd != 16)
+		return -1;
+
+	/* Stop device flushes all queued events */
+	rte_event_dev_stop(g_dev_id);
+
+	/* Restart device */
+	ret = rte_event_dev_start(g_dev_id);
+	if (ret < 0)
+		return -1;
+
+	/* Verify no leftover events */
+	deqd = rte_event_dequeue_burst(g_dev_id, PORT_W1, rx, 16, 0);
+	if (deqd != 0) {
+		SLB_LOG_LINE(ERR, "Stop flush failed, received %u events after restart",
+			     deqd);
+		return -1;
+	}
+
+	return 0;
+}
+
+int
+test_slb_eventdev(void)
+{
+	SLB_LOG_LINE(INFO, "=== Running SLB Eventdev Selftest ===");
+
+	if (init_selftest_device() < 0) {
+		SLB_LOG_LINE(ERR, "Initialization failed");
+		cleanup_selftest_device();
+		return -1;
+	}
+
+	SLB_LOG_LINE(INFO, "  [1/5] Testing Parallel Queue...");
+	if (test_parallel_queue() < 0) {
+		SLB_LOG_LINE(ERR, "  FAILED: Parallel Queue test failed");
+		cleanup_selftest_device();
+		return -1;
+	}
+	SLB_LOG_LINE(INFO, "  [1/5] Parallel Queue: PASS");
+
+	SLB_LOG_LINE(INFO, "  [2/5] Testing Atomic Queue...");
+	if (test_atomic_queue() < 0) {
+		SLB_LOG_LINE(ERR, "  FAILED: Atomic Queue test failed");
+		cleanup_selftest_device();
+		return -1;
+	}
+	SLB_LOG_LINE(INFO, "  [2/5] Atomic Queue: PASS");
+
+	SLB_LOG_LINE(INFO, "  [3/5] Testing Ordered Queue...");
+	if (test_ordered_forward() < 0) {
+		SLB_LOG_LINE(ERR, "  FAILED: Ordered Queue test failed");
+		cleanup_selftest_device();
+		return -1;
+	}
+	SLB_LOG_LINE(INFO, "  [3/5] Ordered Queue: PASS");
+
+	SLB_LOG_LINE(INFO, "  [4/5] Testing Single-Link Queue...");
+	if (test_single_link() < 0) {
+		SLB_LOG_LINE(ERR, "  FAILED: Single-Link Queue test failed");
+		cleanup_selftest_device();
+		return -1;
+	}
+	SLB_LOG_LINE(INFO, "  [4/5] Single-Link Queue: PASS");
+
+	SLB_LOG_LINE(INFO, "  [5/5] Testing Device Stop & Flush...");
+	if (test_stop_flush() < 0) {
+		SLB_LOG_LINE(ERR, "  FAILED: Stop Flush test failed");
+		cleanup_selftest_device();
+		return -1;
+	}
+	SLB_LOG_LINE(INFO, "  [5/5] Device Stop & Flush: PASS");
+
+	cleanup_selftest_device();
+	SLB_LOG_LINE(INFO, "=== SLB Eventdev Selftest PASSED ===");
+	return 0;
+}
-- 
2.53.0

