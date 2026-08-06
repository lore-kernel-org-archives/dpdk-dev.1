Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD89C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ABEC40B91;
	Thu,  6 Aug 2026 05:26:05 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 986C040A6C
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:02 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c9ef3e1337fso1295498a12.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986762;
 x=1786591562; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=BvZu43tBGQk9aG9TA9mFAFNYp+C8JGKb3N7F4lStwVCOFexkDGclIUL5zk9dNQgUtY
 8WYi3I/tzjnNSBVTffxfCk2oc4Kq4Jk2KEWCcykoFwM5T/EnSaDg5RyPM6Rg2UsdCQWh
 40cPuYEBg4D/UgxcCx7jT5YSnENBgA4BjaMlLkbA7eIpf5EGo633EWHpKqms2fkkXauK
 VYxWHoUxP3lp+VLgpKPnKFjI29oxiWYz2mzfhfz7G/jIS2EnvSOAbTxs7RDQGlbMOeD8
 FQP99ipFi8oIUGfFGIKuYL4koB8Z1vAO7fzYdTbJiBOznv3Uxe0fw0/cslFFZZQSM6s7
 hESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986762; x=1786591562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=fiW/83ulQgSwhTyYfty0rptnaJrzJHrVTAhxtgWOm0Ap9EqJ8VJYGCwZ75KjohHzrM
 7c+X3sevegXrQIWh+ovuVgQ3kHyOFGEJgwTTm1miudqJAtssANyFvVs09WxspIJ2TPc3
 laszJoltD+SWTQFp2qOiT/cOUd1sEEG4G5P9wbkj0n7KYHWKtpzmU92foofiOi3hPqI4
 jQAWsbIU2NIt8gMKhCdbx5kJsSwrsOKYaZ/vgmZ173zaJJOAj/jN5vAHwK+Smtw20ABK
 UirpOrgyaSXmbMaLhLXkW8g+h6kj2Oq/Vro/34lYwlYehFk6lM5bgyfgJHb/ww6p2KHd
 j+6w==
X-Gm-Message-State: AOJu0YzIZNkmjuA54Hm9GoRzj40PCkOyhV3ZvWfPuu3YNNI1+OVErhiB
 n3zbYNvFg+CDVftLza9Izj3Z4Yd/hpUaE33VKdpObmE3xbPJGJKRxSBe0obEqYLf0kliuFVU0NK
 ZDxGP9uY=
X-Gm-Gg: AR+sD12ZEGAOGxMdBkfyqSHeuDGBxWY2fZug6X0p1ydf3W7XE4Hx+wcqiObNMlzmp95
 FrKKZNITmYwjIOJabkvKFNhkO4lzY907EtPXrf6wBYYwsfGoLdpSiHeOPmz9XmF3Xf/1isdRlJo
 1V2ARvPB3m61kfqbj+Smz0X9vIDassJJA12b/Qp9sNgPapI4ittv9BD+AV37hBrrcfqBJwSkRxb
 D93RRwlPs950whrGfUSba/hHKH51+HhhvZERuDobFuJ3BFWIzzwvUPpHOwMt5nPGR52fRdBGbwf
 iWnA5QYeARxnCiSLAGumWVcIfoJDsRtEYzZFIwAkURnWRdaV+Kd33qYWhOS7qeys6ziSIVi8fdL
 HyUoon1YON2CuxSt2/GED2QSAzVm2n9IA7hQoVgyqSsjODEAiS9OzM5BCY/ERTYoC99wk4cgEqD
 LKmraeE8OZQ17VQAehl9gRx1SR0hnTKYsHrChSnODYu27MUTMR3Iiu94LiCn2SBFFp6PYmWeOP9
 GqJ72bosHItNxLhp2TLs3mz13k=
X-Received: by 2002:a05:6a20:734c:b0:3b4:8ba9:4d8e with SMTP id
 adf61e73a8af0-3cb85e6c92emr12773177637.23.1785986761776; 
 Wed, 05 Aug 2026 20:26:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 13/24] event/sw: convert from rte_atomic32 to stdatomic
Date: Wed,  5 Aug 2026 20:23:05 -0700
Message-ID: <20260806032544.21337-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

