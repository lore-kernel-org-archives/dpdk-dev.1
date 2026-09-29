Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B1CC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90F2242E7C;
	Tue, 29 Sep 2026 16:04:40 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 77FF542E57
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:28 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 d2e1a72fcca58-86efece610cso2110745b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690667;
 x=1791295467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=xNO9E5/QHOf/2nPP67AYd3m/M6yiIVd/WjE8VCcbhH5gptbpKGIeozrnj4yKdJ6IWC
 OQ82evJt7xFOMA6k2NF1tvpj/7HqxXuzcRMK4J4K/WcXGJZLgQ/lucEjEV5mJb+Df5Nh
 hXuaD+NsoBcZz3dF/NoHlUHF9BB58O+eTl81OwkYaTfnoqdHGvVy2fcqMbWB7CKsR24m
 vl2GEPBRoWdBnbgJuqhOjyWPIvQQkNHLd4iihVTVm461JAt7U7yCJQVPW9ZTSLmDEBiz
 u3EQyELtto36UedyCw48I4lOayPSrFOCkMyNfIqMYqBa4l62jzemtAKIXubqubFnv7ZS
 6xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690667; x=1791295467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=fbafEetY26u/BrNpxw4RWxM4GpaBCV/YjkWuX3Kefl7U/Mf4WYLUFRQ4nLuMzY4J04
 Shs8LDMbRrvUjuImckLRrT8OotMkd1oB7CtDD0nZqJ2dfqBWTVZkvj76Fw1vaobDY68w
 meHyMBpDUeS4h2jC2J0L1ZSWBiolLJghpZj/kKKDZG9X8bz0xnOVyFWCtgdQzqCkjdys
 pXiEIxJcfvJAFSIwJQhHSYP22LhQ9dz/m+hkPus9mkxBUHhb5LuX+9H0Sj60fhE91vnw
 g8dbjqtadCr8JV+7B3Sa7YGCjfE2+mGaz1TflFBG6CnL4176HiBKo4+2nx1+hoqVdRpN
 iTBA==
X-Gm-Message-State: AFuF++l1fm4KqKVkIMM0YXDG8q/8uyWKvaMYklUBAHdMVyLleM4vKi9C
 oUJqgecAjnIREyqQdhuodZfXWAVYe35xMh33Ws//CkPEQDUGrAdDBQkRsdEliQEox9uMLlaGBr5
 AFAHc+IY=
X-Gm-Gg: AYBFou0IRM9pIOmpNcuWLTI04mVTWc3GR9weN03d9dQ7Hf4qBm02hcZdDqyPiFaVe7m
 RFTBnTBnwqcIHVhkpB2p+H/4wC/8H78VbH7MryGVkQlVLh/QtBDeaWHjQFfWI+tB8d51a+iGNfF
 3MuksXCYaoix7vCdD/5yVPxMaGCrfFkLpsQbCN+T7wM2O2M7u/fcbrMMK4BVH39ggWt4hZ03Pst
 p5zUe9kES5FiLl39wMvXZhfl0Bk7vx0WOHTlpAUq9GbSuf+EOTWHVnM3w5YM9oD+oYzSJPHcpEv
 3QnSK2wuvVO04hsFHzxz8EFpjxPPbmBykw2b5i+03UhxpcYU2FZ/MwDaNpMZeOersxNbNygUL+D
 0y7GEurZxh8YFdmz9ZcJ9v3bcSilxXUU9DwalspebVr848AOtwQ+pXApVQDPftOqhOGLp/+NFVB
 Q6qxWU916NoJ5A/EVuB/JkoSy3FUXPkbKkvMHd8Clpv9Hyka+6cs3hZMI3Y6IJ762suEuTBB4M1
 h5kmskSvDtqFMBnqJpQ9YmpW7jDI0aI4NQ9aQ==
X-Received: by 2002:a05:6a00:b70f:b0:87c:47ec:f3c with SMTP id
 d2e1a72fcca58-87e9dfaf9a6mr11114646b3a.47.1790690667473; 
 Tue, 29 Sep 2026 07:04:27 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 15/25] event/sw: convert from rte_atomic32 to stdatomic
Date: Tue, 29 Sep 2026 07:02:01 -0700
Message-ID: <20260929140409.234453-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

