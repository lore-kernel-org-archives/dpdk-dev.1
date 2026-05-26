Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14220CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B21B640685;
	Wed, 27 May 2026 01:26:09 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id C6ADC40A6C
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:03 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f7020a928eso16415307eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837963;
 x=1780442763; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=o8dg4RbaoG0ihzqZiqTt8WNEnMRMG05mhcgsxVLZJr27kTsixcXEa7xYklXHAI1B0i
 m3Lp8UYO6Q6bV15547mM1dcUO+eLNCpYTY2ZLQn2V7EMcV/4PWDys/lyEtj93F61kvZO
 kZscF/1IuVMQWjzardemCFNlR24bhbfeQzFHxGMARGeKINeXH6hvyzF6E2Y5pvpI4uZ0
 xwbhUFM10Zhf0anWaBug6h0LOHeT3tgE2jo2u8t+rYa3Pe9mJ7ox54djjS1+44l4sTXA
 Vi4t04XCBni00L4QNXsmoGBtI+7ciMuBUXzZOp84BGQdvn/ZCOXR0g1dGogLO4P8fP1E
 PBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837963; x=1780442763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=IxPOEH950MTKcMH9M3CfIP7ToH4A7utr80VAUirx1Rui8myZxDf6jfcOZO+GPG7luo
 xORKkwnOaFWS81vF+7qo/ArjQ2bG7s0o5gqysJMgDs/9Fzc040spgaUAyqbsoPWXGMj+
 XhtKnnSpNrtOqSc0bRcuH0EQ6FyXwlUsvwhO5xNz8z4VMZq51rcuN30tjaDEiuVea+nS
 MjP0pGtraUOVGTPUNPpraE3mvkVtgdCBzX1icSluDUJiLKgAP2PiWBMVeWuziXeWAjIN
 FHAtbIas7pVas6Xgz+lo6yX/xoLcE9ECaPtRwrpHvMNrV3GacYiuQ+//xQfmZzrEYagT
 uuWg==
X-Gm-Message-State: AOJu0Yzb8/crGLwGZzqa5IsGjV0Cvm6NTG7rG9xLbnOLERZA/jTQ/F+o
 K5cywGJQt+ClxsIkfliyoBL4jzJ3KYi/BzDWVUpvBun4eUOZnvQ71tstKGyaDXq5LF++XS09dW/
 cEIcT
X-Gm-Gg: Acq92OGniZmYL3R8A+zNFOTGmv9ekGcHQwjcOllawbx4ilfS0p8XIUDCKxQ1sbtruzK
 lFW2LX9WlGJNA2Mpv93dYmXgqMjxa7tgHC/aEsyb9qmrhQ9pe/Oy1yN4e6h+mbz5+7QpIBHm98c
 r7eMiCw59ZsH+9F/rBk25udCaOVjSC1DlSUVrXK/5vdYwnywSf7YM+bFjCl4JrnyEfurBIqo2q5
 dEskcaC2xoQus5+2+lCtbgG051LUZqEaEoLDOp8Nl+KEld6ygCGAzQdZTwY8AA8K5nlwdcq0pEW
 t+h5OkMqEcQRA+iHKfcQUy9T5R0DclGmBezB5TNZ/JjiOCgmYkBVrCTenTI5Uzg9sXE76lOvNTm
 capwug2UXBvUU/72unx7GL+PI3rWclRUltoLxulzYaCHHjhs5AFp0zkU5wo1wQR4dER4YdIj7oC
 GijKLl6+99aQ7y0DRe3woM5hohl2bRm5TKAaJjQ00CbdIsSQXBI85xH0fA0B09eBF5f7pKOlbU
X-Received: by 2002:a05:693c:20cc:20b0:304:4f23:542d with SMTP id
 5a478bee46e88-3044f2430b5mr4933102eec.11.1779837962798; 
 Tue, 26 May 2026 16:26:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 16/27] event/sw: convert from rte_atomic32 to stdatomic
Date: Tue, 26 May 2026 16:24:06 -0700
Message-ID: <20260526232542.620966-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Use stdatomic to keep track of inflights.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/sw/sw_evdev.c        |  8 +++++---
 drivers/event/sw/sw_evdev.h        |  4 ++--
 drivers/event/sw/sw_evdev_worker.c | 16 +++++++++++-----
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index 3ad82e94ac..a2f760a98d 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -153,7 +153,9 @@ sw_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 		 * the sum to no leak credits
 		 */
 		int possible_inflights = p->inflight_credits + p->inflights;
-		rte_atomic32_sub(&sw->inflights, possible_inflights);
+		rte_atomic_fetch_sub_explicit(&sw->inflights,
+					      possible_inflights,
+					      rte_memory_order_release);
 	}
 
 	*p = (struct sw_port){0}; /* zero entire structure */
@@ -512,7 +514,7 @@ sw_dev_configure(const struct rte_eventdev *dev)
 	sw->qid_count = conf->nb_event_queues;
 	sw->port_count = conf->nb_event_ports;
 	sw->nb_events_limit = conf->nb_events_limit;
-	rte_atomic32_set(&sw->inflights, 0);
+	sw->inflights = 0;
 
 	/* Number of chunks sized for worst-case spread of events across IQs */
 	num_chunks = ((SW_INFLIGHT_EVENTS_TOTAL/SW_EVS_PER_Q_CHUNK)+1) +
@@ -633,7 +635,7 @@ sw_dump(struct rte_eventdev *dev, FILE *f)
 	fprintf(f, "\tsched cq/qid call: %"PRIu64"\n", sw->sched_cq_qid_called);
 	fprintf(f, "\tsched no IQ enq: %"PRIu64"\n", sw->sched_no_iq_enqueues);
 	fprintf(f, "\tsched no CQ enq: %"PRIu64"\n", sw->sched_no_cq_enqueues);
-	uint32_t inflights = rte_atomic32_read(&sw->inflights);
+	uint32_t inflights = rte_atomic_load_explicit(&sw->inflights, rte_memory_order_relaxed);
 	uint32_t credits = sw->nb_events_limit - inflights;
 	fprintf(f, "\tinflight %d, credits: %d\n", inflights, credits);
 
diff --git a/drivers/event/sw/sw_evdev.h b/drivers/event/sw/sw_evdev.h
index c159be21be..5e49b08030 100644
--- a/drivers/event/sw/sw_evdev.h
+++ b/drivers/event/sw/sw_evdev.h
@@ -8,7 +8,7 @@
 #include "sw_evdev_log.h"
 #include <rte_eventdev.h>
 #include <eventdev_pmd_vdev.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 
 #define SW_DEFAULT_CREDIT_QUANTA 32
 #define SW_DEFAULT_SCHED_QUANTA 128
@@ -233,7 +233,7 @@ struct sw_evdev {
 	/* Contains all ports - load balanced and directed */
 	alignas(RTE_CACHE_LINE_SIZE) struct sw_port ports[SW_PORTS_MAX];
 
-	alignas(RTE_CACHE_LINE_SIZE) rte_atomic32_t inflights;
+	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t) inflights;
 
 	/*
 	 * max events in this instance. Cached here for performance.
diff --git a/drivers/event/sw/sw_evdev_worker.c b/drivers/event/sw/sw_evdev_worker.c
index 4215726513..0755def367 100644
--- a/drivers/event/sw/sw_evdev_worker.c
+++ b/drivers/event/sw/sw_evdev_worker.c
@@ -56,7 +56,7 @@ sw_event_enqueue_burst(void *port, const struct rte_event ev[], uint16_t num)
 	uint8_t new_ops[PORT_ENQUEUE_MAX_BURST_SIZE];
 	struct sw_port *p = port;
 	struct sw_evdev *sw = (void *)p->sw;
-	uint32_t sw_inflights = rte_atomic32_read(&sw->inflights);
+	uint32_t sw_inflights = rte_atomic_load_explicit(&sw->inflights, rte_memory_order_relaxed);
 	uint32_t credit_update_quanta = sw->credit_update_quanta;
 	int new = 0;
 
@@ -74,8 +74,10 @@ sw_event_enqueue_burst(void *port, const struct rte_event ev[], uint16_t num)
 		if (sw_inflights + credit_update_quanta > sw->nb_events_limit)
 			return 0;
 
-		rte_atomic32_add(&sw->inflights, credit_update_quanta);
-		p->inflight_credits += (credit_update_quanta);
+		rte_atomic_fetch_add_explicit(&sw->inflights,
+					      credit_update_quanta,
+					      rte_memory_order_acquire);
+		p->inflight_credits += credit_update_quanta;
 
 		/* If there are fewer inflight credits than new events, limit
 		 * the number of enqueued events.
@@ -124,7 +126,9 @@ sw_event_enqueue_burst(void *port, const struct rte_event ev[], uint16_t num)
 
 	/* Replenish credits if enough releases are performed */
 	if (p->inflight_credits >= credit_update_quanta * 2) {
-		rte_atomic32_sub(&sw->inflights, credit_update_quanta);
+		rte_atomic_fetch_sub_explicit(&sw->inflights,
+					      credit_update_quanta,
+					      rte_memory_order_release);
 		p->inflight_credits -= credit_update_quanta;
 	}
 
@@ -150,7 +154,9 @@ sw_event_dequeue_burst(void *port, struct rte_event *ev, uint16_t num,
 
 		/* Replenish credits if enough releases are performed */
 		if (p->inflight_credits >= credit_update_quanta * 2) {
-			rte_atomic32_sub(&sw->inflights, credit_update_quanta);
+			rte_atomic_fetch_sub_explicit(&sw->inflights,
+						      credit_update_quanta,
+						      rte_memory_order_release);
 			p->inflight_credits -= credit_update_quanta;
 		}
 	}
-- 
2.53.0

