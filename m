Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C38CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3734940DD8;
	Sat, 23 May 2026 21:59:05 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 3CCC2406BB
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:59 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso8585384eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566338;
 x=1780171138; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=gWdYOQlOEXy0bStJnYXx/aFEqhCjfOaM/4kKvxtQqqAHz+r7RFcq16JcmjW9lXDee2
 OTkU61Gp8ajMwGY46rpcze8xignUB3hEPB+1CBYHrjGp38PgmYEpuYQ/N9b39ol4T66V
 j7E0TQDNGpfzptt/ylGCTrVUiwoG91dxfZV07ELaqnivB4TzyYKWQSwljrJikvTeWTkc
 O6UC/5vyKpAiB0ZbLVYm0xul1KVfXeTb+snrkutuQg1xymN2pYQwPUXkNP3+GkPsIxnN
 lAFbZnd2hjhjcw6C8rlEIfmFPAOi15bR1Qb4Xr/jKGbrsmARqeFnJWioyu7ms1uEQAkP
 wxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566338; x=1780171138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=N/7sK+PoFv5olp2Pq5WTB/GkIbNsSIH3SUT2IvfWoofwobG2QhacIcJajOHghyi949
 rh+bL2rzWcrj2UAN8vwBPh/W7YV0PuqbPljQeRdcKm/Ar4EkdvoB3W5oLA5QSvqhIN5v
 7sdXGvXhIWiWCwkDFe6oolsm4couxmXac9p165KM7bDb1vi8gvW1PsPPA2hebW1sY4a0
 ZgKzqzItYT+AJZfD4K+fDJBbN8BK2THVW+5TGM+tqdnz71ej6trTRBs2MQoWXwQQxHvU
 1OpJ1XfzlFvmLngaWUQA40DZfTjeoI6KpPo5mjtOq+KPnL3zU5HqY5bAwgeh2rGrjJg7
 6oNQ==
X-Gm-Message-State: AOJu0YzVN0bylyOlOsLBJtcOpv2mR5PnSWlangQNys4MzpjU3NLPECyp
 5zUhHLos1T4SiR57vw3sfie3+HOVLWYkaAjLOSH3EskG69KBEjgOA76FHpVb5CBTFOEwvSt/jm1
 scH1l
X-Gm-Gg: Acq92OHQKowlSlfd1TJxNWoaZxF++Quc0uN034fKRaCyJ6R6q22C4rDgOhteXJ/H6Gp
 WqVsoTPsjZbzEAiX8OVDefsjXPqhLHjhb0y+WmDl+iIZNAxhseNK5MZrarq5THktiBA+8LPxHub
 n4zPKrt2Dj2rTrVapvmjwHHm6vAK1dc8VTXgMKFkv8RJH94EvKbp0lLSfHnCqUKNujU8ssWvDbs
 jCvR/Zsl6j0G5z10CTNrshoagnj2pGPvMgDctu/zNOYjOgsPQrWJ6QhA8YqpI+j73+f2OCV/q6K
 ZfkkSmeG5Ns/+eR3O0al5cpCiJYIZaCNEAfDEIP/wbEVNX9A1grmTWSi/gmeHiE2x4Px4QlzfRM
 /j+JLyOZm4UI6Tui22da7n13jwPK0HpEDQTfvqGo+hJlgXd5KC8LGNa7yhCupRj0zgnKUmgukI7
 zMQbc18C4bRcOgv2AH5no/iepqYSFKBBCXkQDtbh23nDYbsDbJlJZsoqeB7WOTGlM9orHyTk+J
X-Received: by 2002:a05:693c:63d1:b0:2f3:986d:2d01 with SMTP id
 5a478bee46e88-304490543damr2320644eec.19.1779566338281; 
 Sat, 23 May 2026 12:58:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 16/27] event/sw: convert from rte_atomic32 to stdatomic
Date: Sat, 23 May 2026 12:56:30 -0700
Message-ID: <20260523195839.454952-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

