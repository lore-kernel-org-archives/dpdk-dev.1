Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2C606A331
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFTS8MXc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B3C14065A;
	Tue, 17 Nov 2026 18:57:35 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 22638402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:57:30 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-53644ab1f7bso665701cf.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794938249; x=1795543049; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YBDbWGeoTR89ooh6Cto8wEuAtDgEvPcRlcLnDgk5rYQ=;
 b=GFTS8MXc2DdAgdZPIXEKYGuwzR6uCbtaW5wj8ju+rBjgIA9RSTRId3rvt3Szjp+6aX
 J1wN/38kQwTytKPSAXv1+95wkcd4LUF77P0lV9JmbcFzn+PziSUjZmol6HyM0Qp5kjlY
 sfosIn9I4J74iACZMagZu6/4BtUFEPNdggy83L9uxVu+VPMilhV5LALD2o3VoA0YVCU4
 Uh+2JVMEIDD0LtsQTChQKmiu8tfeoKAiyg7q1YcgzD6bVHcO5Gn86vyQzInHuvzwa4CO
 ba4TOhWuuc9lsmGi/4p/LtTxkkuw7RXM2/gHqCzMzOeHWEKNHcm/DuuCRPOM/rscz7K8
 Z+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938249; x=1795543049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YBDbWGeoTR89ooh6Cto8wEuAtDgEvPcRlcLnDgk5rYQ=;
 b=gHEzWzcTdxwkqsiWCdOeKY8pNyNIZ7aGu+xOWhjZtwJONiueFYXppCU4CBjV8CTXby
 WBwaCXCOrlXnysGRCY+wfnbZbFnGXTsIQKhe06rUmHX0SEPdjM2RtlBNO8NDmuRf/4Fa
 Oih6rJo07j9ed1OPvqeHgXCXy5gDf7ZLtuRKnX/MwbIknmc4Z4g3/2VxIwKpQaTNujad
 zNBTItJtYiJG9uK8NRUjthTXLY8c7yAg3HIdgYf8xdnTRT08EdAmnzPKfjhJ90Jx8MZh
 cB4ph4bSrd5i93pTUB/XsDT6KfGpb6KJiGDrxoZe0hzS1P0mBx/qlsGATfMCupo+GRG+
 hSMQ==
X-Gm-Message-State: APuU4Z8z4EqTerMJ9aJ8U/BXqxLNcPwVya6AKqyP3VKO8cT2VfdrWqG5
 HLAaC63HyWaSnat/G5M1sXqOkQHsh+BEG+tpvfjnUdiTAG6rxCLdlfi6+oP/e0nN
X-Gm-Gg: AYBFou1mWVtmBbqBSdiaCh/toJSSf7y4e9ASJoKH0oRt2RXdinKDLNWsYCdDBJ6hQIc
 41DxJNcnHsT+BbORrrUHoWcz4Wvy0XcfI0ojrg9gRZ1TVzOwSidYGMn2pEOWnuK2k5jIUbwn+JH
 PCbxodWhJ7YPV1KsRlgB8nGAt/HEdTO9RLDFu1ozUMH8jcQofaUhB9xFKR+5dkjeUkt0Zpmgs8Y
 7kcTRLPfjtMcRZwh2s6V7FMEDhFbV38JN5gVPz7xePvSs3D1krdMojtM6n6nIVk2NFro3yZDn0j
 L3jhtLFDecGnNgqRJR3W9HDZSStMFdCdkG3dJd+iEUd5U3UFqr8rCTw4iQUBoOEPT3DbFrz92qH
 2EXSCF8wOTE5Lu8041DXk/9M2lRNHEWJiyivCRats631/ZVvY9ZTxIlR20EoasXWkKKpVtDtUdv
 gR1FRb7jQTsEvt20QOAjv36hDin0W9dFvjB0hkFJb33HCHGgQlTVSX3cbSbRfqPr9Sb/QyAicNm
 gaFLW8nznw9jAXHcHIemUzOYadAJ+1Zzu+3nvmL9gfrMK12lkHVzS75yWh/iYg+k+kxbhsDn+DC
 /PjTCmVl2J/2Od+TtCDYI1qzovAF34/0fui/U4O4L8Yp4gBcjt5LlagSzpVqTp+mzm2pmMWFxwv
 1l2tzJZ80DxqZjWZf3/KxGu/HioavhzGTTarUL3ja6JCkrYkqy3zw
X-Received: by 2002:a05:622a:1390:b0:536:b7a:2ce8 with SMTP id
 d75a77b69052e-55d5a62dd36mr582631cf.51.1794938248944; 
 Tue, 17 Nov 2026 09:57:28 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c29f7.dyn.optonline.net. [148.76.41.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921148c261bsm327426d6.0.2026.11.17.09.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:57:28 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, bruce.richardson@intel.com, thomas@monjalon.net,
 david.marchand@redhat.com, nipun.gupta@amd.com, chenbox@nvidia.com,
 tirthendu.sarkar@intel.com, mattias.ronnblom@ericsson.com,
 stephen@networkplumber.org, Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v2 5/8] event/slb: add extended statistics and diagnostics
Date: Tue, 17 Nov 2026 12:57:05 -0500
Message-ID: <20261117175709.2346400-6-pravinpathakdev@gmail.com>
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

Implement the eventdev extended statistics (xstats) interface and
enhance PMD diagnostics in the dump callback.

Device and per-port statistics are exposed through xstats callbacks,
including enqueue/dequeue counts, credit loan counts, and migration
tallies. The slb_dump callback is extended to display detailed per-port
and per-queue internal state, atomic migration status, and queue depth.

Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
---
 drivers/event/slb/meson.build  |   5 +
 drivers/event/slb/slb_evdev.c  |  94 ++++++++-
 drivers/event/slb/slb_evdev.h  |  11 ++
 drivers/event/slb/slb_xstats.c | 347 +++++++++++++++++++++++++++++++++
 4 files changed, 450 insertions(+), 7 deletions(-)
 create mode 100644 drivers/event/slb/slb_xstats.c

diff --git a/drivers/event/slb/meson.build b/drivers/event/slb/meson.build
index 9a1dff524f..d698a58f16 100644
--- a/drivers/event/slb/meson.build
+++ b/drivers/event/slb/meson.build
@@ -10,6 +10,11 @@ endif
 sources = files(
         'slb_evdev.c',
         'slb_event.c',
+        'slb_xstats.c',
 )
 
 deps += ['bus_vdev', 'ring']
+
+if cc.has_argument('-Wno-format-nonliteral')
+    cflags += '-Wno-format-nonliteral'
+endif
diff --git a/drivers/event/slb/slb_evdev.c b/drivers/event/slb/slb_evdev.c
index 1916b7faa4..04a2aba165 100644
--- a/drivers/event/slb/slb_evdev.c
+++ b/drivers/event/slb/slb_evdev.c
@@ -606,6 +606,8 @@ slb_dump(struct rte_eventdev *dev, FILE *f)
 {
 	struct slb_evdev *slb = slb_pmd_priv(dev);
 	int32_t pool_on_loan, pool_avail;
+	uint64_t total_mig_in = 0, total_mig_out = 0;
+	int i;
 
 	if (dev == NULL || f == NULL)
 		return;
@@ -617,20 +619,41 @@ slb_dump(struct rte_eventdev *dev, FILE *f)
 	fprintf(f, "\n[SLB EVENTDEV DEBUG STATS]\n");
 	fprintf(f, "  Device ID: %u, Driver: %s\n", dev->data->dev_id,
 		SLB_PMD_NAME);
-	fprintf(f, "  Credit Pool: %d on_loan / %d max_inflight (%d avail)\n",
+	fprintf(f, "  Credit Pool: %d on_loan / %d max_inflight (%d available)\n",
 		pool_on_loan, slb->max_inflight, pool_avail);
 
+	fprintf(f, "\n  PORT FLOW MIGRATION COUNTERS:\n");
+	for (i = 0; i < slb->num_ports; i++) {
+		struct slb_port *p = &slb->ports[i];
+
+		total_mig_in += p->migrations_in;
+		total_mig_out += p->migrations_out;
+		fprintf(f,
+			"    Port %2u: Migrated-In: %6" PRIu64
+			" | Migrated-Out: %6" PRIu64 " | Net: %+5" PRId64 "\n",
+			i, p->migrations_in, p->migrations_out,
+			(int64_t)p->migrations_in - (int64_t)p->migrations_out);
+	}
+	fprintf(f, "    Total Flow Migrations: IN=%" PRIu64 ", OUT=%" PRIu64 "\n",
+		total_mig_in, total_mig_out);
+
 	fprintf(f, "\n  PORT STATISTICS & QUEUE LINKAGES:\n");
-	for (int i = 0; i < slb->num_ports; i++) {
+	for (i = 0; i < slb->num_ports; i++) {
 		struct slb_port *p = &slb->ports[i];
 		uint64_t aq = rte_atomic_load_explicit(&p->active_queues,
 						       rte_memory_order_acquire);
-		fprintf(f, "    Port %2u (credits=%3d, active=0x%08" PRIx64 "): ",
-			i, p->inflight_credits, aq);
 		int linked_count = 0;
+
+		fprintf(f,
+			"    Port %2u (credits=%3d, active=0x%08" PRIx64
+			", loaded=%d, mig_in=%" PRIu64 ", mig_out=%" PRIu64 "): ",
+			i, p->inflight_credits, aq, p->is_loaded,
+			p->migrations_in, p->migrations_out);
+
 		if (p->is_single_linked) {
 			if (p->single_linked_q) {
 				int qid = p->single_linked_q - slb->queues;
+
 				fprintf(f, "Q%d (single-link)", qid);
 				linked_count++;
 			}
@@ -638,6 +661,7 @@ slb_dump(struct rte_eventdev *dev, FILE *f)
 			for (int pr = 0; pr < SLB_MAX_PRIORITIES; pr++) {
 				for (int s = 0; s < p->num_q[pr]; s++) {
 					int qid = p->q_entries[pr][s].queue_id;
+
 					if (linked_count > 0)
 						fprintf(f, ", ");
 					fprintf(f, "Q%d(p%d)", qid, pr);
@@ -648,16 +672,69 @@ slb_dump(struct rte_eventdev *dev, FILE *f)
 		if (linked_count == 0)
 			fprintf(f, "(no queues linked)");
 		fprintf(f, "\n");
+		fprintf(f,
+			"            stats: enq_calls=%" PRIu64
+			", new_enq=%" PRIu64 ", fwd_enq=%" PRIu64
+			", rel_enq=%" PRIu64 ", deq_calls=%" PRIu64
+			", deq=%" PRIu64 "\n",
+			p->enqueue_calls, p->new_enqueued,
+			p->forward_enqueued, p->release_enqueued,
+			p->dequeue_calls, p->dequeued);
 	}
 
 	fprintf(f, "\n  ALL QUEUES STATUS:\n");
-	for (int i = 0; i < slb->num_queues; i++) {
+	for (i = 0; i < slb->num_queues; i++) {
 		struct slb_queue *q = &slb->queues[i];
 		uint32_t count = rte_event_ring_count(q->q_ring);
 		uint32_t ring_size = rte_event_ring_get_capacity(q->q_ring);
-		fprintf(f, "    Queue %2u: %6u/%6u events, serving_ports=0x%016" PRIx64 ", sched=%u, single=%d\n",
+
+		fprintf(f,
+			"    Queue %2u: %6u/%6u events, serving_ports=0x%016" PRIx64
+			" (count=%u), sched_type=%u, single_link=%d\n",
 			i, count, ring_size, q->serving_ports_mask,
-			q->schedule_type, q->is_single_link);
+			q->num_serving_ports, q->schedule_type,
+			q->is_single_link);
+		if (q->schedule_type == RTE_SCHED_TYPE_ATOMIC) {
+			if (q->atomic_state) {
+				fprintf(f,
+					"      Atomic State: total_migrations=%" PRIu64
+					", hold_count=%u\n",
+					q->atomic_state->migrations_count,
+					q->atomic_state->hold_count);
+				if (q->atomic_state->migration.in_progress) {
+					fprintf(f,
+						"      MIGRATION IN PROGRESS: from port %u, flow_idx=%u\n",
+						q->atomic_state->migration.port_id,
+						q->atomic_state->migration.flow_idx);
+				}
+				for (int j = 0; j < slb->num_ports; j++) {
+					if (q->per_port_rings[j]) {
+						struct slb_atomic_port_stats *ps =
+							&q->atomic_state->port_stats[j];
+
+						fprintf(f,
+							"      Per-port ring %d: %u events"
+							" (load_counter=%u, flows=%u,"
+							" enq=%" PRIu64 ", ret=%" PRIu64 ")\n",
+							j,
+							rte_event_ring_count(q->per_port_rings[j]),
+							ps->load_counter,
+							ps->flow_count,
+							ps->q_enqueued,
+							ps->q_returned);
+					}
+				}
+			}
+		} else if (q->schedule_type == RTE_SCHED_TYPE_ORDERED) {
+			fprintf(f, "      Ordered reorder_drain_idx=%u\n",
+				q->reorder_drain_idx);
+		}
+		if (count > 0 && q->serving_ports_mask == 0)
+			fprintf(f,
+				"      ^^^ PROBLEM: Queue has %u events but serving_ports_mask=0!\n",
+				count);
+		if (count == 0 && q->serving_ports_mask == 0)
+			fprintf(f, "      (unused queue)\n");
 	}
 	fprintf(f, "[END DEBUG]\n\n");
 	fflush(f);
@@ -678,6 +755,9 @@ static struct eventdev_ops slb_evdev_ops = {
 	.dev_stop = slb_stop,
 	.dev_close = slb_close,
 	.dump = slb_dump,
+	.xstats_get = slb_xstats_get,
+	.xstats_get_names = slb_xstats_get_names,
+	.xstats_get_by_name = slb_xstats_get_by_name,
 };
 
 static int
diff --git a/drivers/event/slb/slb_evdev.h b/drivers/event/slb/slb_evdev.h
index b1a6de8606..17f3154efa 100644
--- a/drivers/event/slb/slb_evdev.h
+++ b/drivers/event/slb/slb_evdev.h
@@ -231,6 +231,17 @@ void slb_reorder_drain(struct slb_evdev *slb, struct slb_queue *queue);
 
 void slb_dump(struct rte_eventdev *dev, FILE *f);
 
+int slb_xstats_get_names(const struct rte_eventdev *dev,
+			 enum rte_event_dev_xstats_mode mode,
+			 uint8_t queue_port_id,
+			 struct rte_event_dev_xstats_name *xstats_names,
+			 uint64_t *ids, unsigned int capacity);
+int slb_xstats_get(const struct rte_eventdev *dev,
+		   enum rte_event_dev_xstats_mode mode, uint8_t queue_port_id,
+		   const uint64_t ids[], uint64_t values[], unsigned int n);
+uint64_t slb_xstats_get_by_name(const struct rte_eventdev *dev,
+				const char *name, uint64_t *id);
+
 static inline struct slb_evdev *
 slb_pmd_priv(const struct rte_eventdev *eventdev)
 {
diff --git a/drivers/event/slb/slb_xstats.c b/drivers/event/slb/slb_xstats.c
new file mode 100644
index 0000000000..fdb7dd6cc5
--- /dev/null
+++ b/drivers/event/slb/slb_xstats.c
@@ -0,0 +1,347 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Pravin Pathak <pravin.pathak.dev@gmail.com>
+ */
+
+#include "slb_evdev.h"
+
+#include <limits.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include <rte_debug.h>
+#include <rte_string_fns.h>
+
+/* The high bits in the xstats id is used to store an additional
+ * parameter (beyond the queue or port id already in the xstats
+ * interface).
+ */
+#define SLB_XSTATS_ID_PARAM_BITS (8)
+#define SLB_XSTATS_ID_STAT_BITS \
+	(sizeof(uint64_t) * CHAR_BIT - SLB_XSTATS_ID_PARAM_BITS)
+#define SLB_XSTATS_ID_STAT_MASK ((UINT64_C(1) << SLB_XSTATS_ID_STAT_BITS) - 1)
+
+#define SLB_XSTATS_ID_GET_PARAM(id) \
+	((id) >> SLB_XSTATS_ID_STAT_BITS)
+
+#define SLB_XSTATS_ID_GET_STAT(id) \
+	((id) & SLB_XSTATS_ID_STAT_MASK)
+
+#define SLB_XSTATS_ID_CREATE(id, param_value) \
+	((((uint64_t)(param_value)) << SLB_XSTATS_ID_STAT_BITS) | (id))
+
+typedef uint64_t (*slb_xstats_dev_get_value_fn)(struct slb_evdev *slb);
+
+struct slb_xstat_dev {
+	const char *name;
+	slb_xstats_dev_get_value_fn get_value_fn;
+};
+
+typedef uint64_t (*slb_xstats_port_get_value_fn)(struct slb_evdev *slb,
+						 uint8_t port_id,
+						 uint8_t queue_id);
+
+struct slb_xstats_port {
+	const char *name_fmt;
+	slb_xstats_port_get_value_fn get_value_fn;
+	bool per_queue;
+};
+
+static uint64_t
+slb_xstats_dev_credits_on_loan(struct slb_evdev *slb)
+{
+	return rte_atomic_load_explicit(&slb->credits_on_loan,
+					rte_memory_order_relaxed);
+}
+
+static struct slb_xstat_dev slb_dev_xstats[] = {
+	{ "dev_credits_on_loan", slb_xstats_dev_credits_on_loan }
+};
+
+#define SLB_GEN_PORT_ACCESS_FN(_variable) \
+	static uint64_t \
+	slb_xstats_port_get_ ## _variable(struct slb_evdev *slb, \
+					  uint8_t port_id, \
+					  uint8_t queue_id __rte_unused) \
+	{ \
+		return slb->ports[port_id]._variable; \
+	}
+
+SLB_GEN_PORT_ACCESS_FN(new_enqueued)
+SLB_GEN_PORT_ACCESS_FN(forward_enqueued)
+SLB_GEN_PORT_ACCESS_FN(release_enqueued)
+
+static uint64_t
+slb_xstats_port_get_queue_enqueued(struct slb_evdev *slb, uint8_t port_id,
+				   uint8_t queue_id)
+{
+	return slb->ports[port_id].queue_enqueued[queue_id];
+}
+
+SLB_GEN_PORT_ACCESS_FN(dequeued)
+
+static uint64_t
+slb_xstats_port_get_queue_dequeued(struct slb_evdev *slb, uint8_t port_id,
+				   uint8_t queue_id)
+{
+	return slb->ports[port_id].queue_dequeued[queue_id];
+}
+
+SLB_GEN_PORT_ACCESS_FN(inflight_credits)
+SLB_GEN_PORT_ACCESS_FN(pending_releases)
+SLB_GEN_PORT_ACCESS_FN(migrations_in)
+SLB_GEN_PORT_ACCESS_FN(migrations_out)
+
+static struct slb_xstats_port slb_port_xstats[] = {
+	{ "port_%u_new_enqueued", slb_xstats_port_get_new_enqueued,
+	  false },
+	{ "port_%u_forward_enqueued", slb_xstats_port_get_forward_enqueued,
+	  false },
+	{ "port_%u_release_enqueued", slb_xstats_port_get_release_enqueued,
+	  false },
+	{ "port_%u_queue_%u_enqueued", slb_xstats_port_get_queue_enqueued,
+	  true },
+	{ "port_%u_dequeued", slb_xstats_port_get_dequeued,
+	  false },
+	{ "port_%u_queue_%u_dequeued", slb_xstats_port_get_queue_dequeued,
+	  true },
+	{ "port_%u_inflight_credits", slb_xstats_port_get_inflight_credits,
+	  false },
+	{ "port_%u_pending_releases", slb_xstats_port_get_pending_releases,
+	  false },
+	{ "port_%u_migrations_in", slb_xstats_port_get_migrations_in,
+	  false },
+	{ "port_%u_migrations_out", slb_xstats_port_get_migrations_out,
+	  false },
+};
+
+typedef void (*slb_xstats_foreach_fn)(const char *xstats_name,
+				      enum rte_event_dev_xstats_mode mode,
+				      uint8_t queue_port_id,
+				      uint64_t xstats_id,
+				      void *data);
+
+static void
+slb_xstats_dev_foreach(slb_xstats_foreach_fn fn, void *fn_data)
+{
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(slb_dev_xstats); i++)
+		fn(slb_dev_xstats[i].name, RTE_EVENT_DEV_XSTATS_DEVICE, 0,
+		   i, fn_data);
+}
+
+static void
+slb_xstats_port_foreach(struct slb_evdev *slb, uint8_t port_id,
+			slb_xstats_foreach_fn fn, void *fn_data)
+{
+	uint8_t queue_id;
+	unsigned int stat_idx;
+
+	for (stat_idx = 0, queue_id = 0;
+	     stat_idx < RTE_DIM(slb_port_xstats);) {
+		struct slb_xstats_port *xstat = &slb_port_xstats[stat_idx];
+		char xstats_name[RTE_EVENT_DEV_XSTATS_NAME_SIZE];
+		uint64_t xstats_id;
+
+		if (xstat->per_queue) {
+			xstats_id = SLB_XSTATS_ID_CREATE(stat_idx, queue_id);
+			snprintf(xstats_name, sizeof(xstats_name),
+				 slb_port_xstats[stat_idx].name_fmt, port_id,
+				 queue_id);
+			queue_id++;
+		} else {
+			xstats_id = stat_idx;
+			snprintf(xstats_name, sizeof(xstats_name),
+				 slb_port_xstats[stat_idx].name_fmt, port_id);
+		}
+
+		fn(xstats_name, RTE_EVENT_DEV_XSTATS_PORT, port_id,
+		   xstats_id, fn_data);
+
+		if (!(xstat->per_queue && queue_id < slb->num_queues)) {
+			stat_idx++;
+			queue_id = 0;
+		}
+	}
+}
+
+struct store_ctx {
+	struct rte_event_dev_xstats_name *names;
+	uint64_t *ids;
+	unsigned int count;
+	unsigned int capacity;
+};
+
+static void
+slb_xstats_store_stat(const char *xstats_name,
+		      enum rte_event_dev_xstats_mode mode,
+		      uint8_t queue_port_id, uint64_t xstats_id,
+		      void *data)
+{
+	struct store_ctx *ctx = data;
+
+	RTE_SET_USED(mode);
+	RTE_SET_USED(queue_port_id);
+
+	if (ctx->count < ctx->capacity) {
+		if (ctx->names != NULL)
+			strlcpy(ctx->names[ctx->count].name, xstats_name,
+				RTE_EVENT_DEV_XSTATS_NAME_SIZE);
+		if (ctx->ids != NULL)
+			ctx->ids[ctx->count] = xstats_id;
+	}
+
+	ctx->count++;
+}
+
+int
+slb_xstats_get_names(const struct rte_eventdev *dev,
+		     enum rte_event_dev_xstats_mode mode,
+		     uint8_t queue_port_id,
+		     struct rte_event_dev_xstats_name *xstats_names,
+		     uint64_t *ids, unsigned int capacity)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	struct store_ctx ctx = {
+		.names = xstats_names,
+		.ids = ids,
+		.capacity = capacity
+	};
+
+	switch (mode) {
+	case RTE_EVENT_DEV_XSTATS_DEVICE:
+		slb_xstats_dev_foreach(slb_xstats_store_stat, &ctx);
+		return ctx.count;
+	case RTE_EVENT_DEV_XSTATS_PORT:
+		if (queue_port_id >= slb->num_ports)
+			return -EINVAL;
+		slb_xstats_port_foreach(slb, queue_port_id,
+					slb_xstats_store_stat, &ctx);
+		return ctx.count;
+	case RTE_EVENT_DEV_XSTATS_QUEUE:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+slb_xstats_dev_get(const struct rte_eventdev *dev,
+		   const uint64_t ids[], uint64_t values[], unsigned int n)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		uint64_t id = ids[i];
+		struct slb_xstat_dev *xstat;
+
+		if (id >= RTE_DIM(slb_dev_xstats))
+			return -EINVAL;
+
+		xstat = &slb_dev_xstats[id];
+		values[i] = xstat->get_value_fn(slb);
+	}
+	return n;
+}
+
+static int
+slb_xstats_port_get(const struct rte_eventdev *dev, uint8_t port_id,
+		    const uint64_t ids[], uint64_t values[], unsigned int n)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		uint64_t id = ids[i];
+		unsigned int stat_idx = SLB_XSTATS_ID_GET_STAT(id);
+		struct slb_xstats_port *xstat;
+		uint8_t queue_id = 0;
+
+		if (stat_idx >= RTE_DIM(slb_port_xstats))
+			return -EINVAL;
+
+		xstat = &slb_port_xstats[stat_idx];
+
+		if (xstat->per_queue) {
+			queue_id = SLB_XSTATS_ID_GET_PARAM(id);
+			if (queue_id >= slb->num_queues)
+				return -EINVAL;
+		}
+
+		values[i] = xstat->get_value_fn(slb, port_id, queue_id);
+	}
+	return n;
+}
+
+int
+slb_xstats_get(const struct rte_eventdev *dev,
+	       enum rte_event_dev_xstats_mode mode, uint8_t queue_port_id,
+	       const uint64_t ids[], uint64_t values[], unsigned int n)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+
+	switch (mode) {
+	case RTE_EVENT_DEV_XSTATS_DEVICE:
+		return slb_xstats_dev_get(dev, ids, values, n);
+	case RTE_EVENT_DEV_XSTATS_PORT:
+		if (queue_port_id >= slb->num_ports)
+			return -EINVAL;
+		return slb_xstats_port_get(dev, queue_port_id, ids, values, n);
+	case RTE_EVENT_DEV_XSTATS_QUEUE:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+struct find_ctx {
+	const struct rte_eventdev *dev;
+	const char *name;
+	uint64_t *id;
+	uint64_t value;
+};
+
+static void
+slb_xstats_find_stat(const char *xstats_name,
+		     enum rte_event_dev_xstats_mode mode,
+		     uint8_t queue_port_id, uint64_t xstats_id,
+		     void *data)
+{
+	struct find_ctx *ctx = data;
+
+	if (strcmp(ctx->name, xstats_name) == 0) {
+		if (ctx->id != NULL)
+			*ctx->id = xstats_id;
+		slb_xstats_get(ctx->dev, mode, queue_port_id, &xstats_id,
+			       &ctx->value, 1);
+	}
+}
+
+uint64_t
+slb_xstats_get_by_name(const struct rte_eventdev *dev, const char *name,
+		       uint64_t *id)
+{
+	struct slb_evdev *slb = slb_pmd_priv(dev);
+	struct find_ctx ctx = {
+		.dev = dev,
+		.name = name,
+		.id = id,
+		.value = -EINVAL
+	};
+	uint16_t port_id;
+
+	if (id != NULL)
+		*id = (uint64_t)-1;
+
+	if (name == NULL)
+		return -EINVAL;
+
+	slb_xstats_dev_foreach(slb_xstats_find_stat, &ctx);
+
+	for (port_id = 0; port_id < slb->num_ports; port_id++)
+		slb_xstats_port_foreach(slb, port_id, slb_xstats_find_stat,
+					&ctx);
+
+	return ctx.value;
+}
-- 
2.53.0

