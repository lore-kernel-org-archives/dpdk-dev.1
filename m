Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894ADC982D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDEF64326C;
	Thu, 17 Sep 2026 22:11:41 +0200 (CEST)
Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com
 [74.125.227.142])
 by mails.dpdk.org (Postfix) with ESMTP id CBB6D42FBD
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:36 +0200 (CEST)
Received: by mail-pj2-f14.google.com with SMTP id
 d9443c01a7336-2dd58e1e2c7so386595ad.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675896;
 x=1790280696; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=OyTgivaaLMcrwRYhNuNtAyA86a15nHrESRf0FVFy6PUMAgdWX98QYmLoOiE39GJ/Ua
 SOqG92ntO3VoEawlBLiuphesogGeHre3PO7BYN+a8YnLk38R7IYzeVNrHOmWJEs5MklU
 fSzFvgJCnLK+/BPlxpPiDQv7oAi9ADdpvmZFqXCza14gZTdDj/FtTTTRWJacVRTFDKMv
 gUFaA46VtlO7q96zPUhhr6fRGwbJf/3MQpG3W6Wz7NHCldKeqgcBeNARzK0OYy+v2qBL
 P9e1UgugyTDkEYj+SmCwQDdBl/YGL4XltqjfJZzemcZA4Xk0U3ntGxZdfNXaKwA+nCM5
 Odkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675896; x=1790280696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dgOfGdIrUWElVZ8RERrHIa5tu6DvybwadqOzpvd1HHM=;
 b=oN/cPsKPcp/3ouibcqo9X8dzi30MvduOiVqtt720KyHj8plfWc1/9I6JhwyNQ5/WdS
 RSnky3otQqAQ6daFek45MjKvTLLtSdRWYxSKdsI2FnPC+6KCGOnYnNs3KAj7IxNu4a3y
 1mWEofcxVkKrua17ms5VZpJyBYz3jSrZZkxCPG3EvVWy7rTgKdvyhEpEUM6V+S/SqbQ1
 XB8a45xg1bStpqagG/y7sc+zXx39kNWWMWGn6fSQOHtkRQ54ytub2Jm+Wfed4ndV/N56
 bM96j3D4u4wD0enP6COcU9WAFM00Z6rS84esj1A6AAbAb0zSjZAbjsw0PmFvVUowaLjb
 GVeg==
X-Gm-Message-State: AFuF++lxqzJYlhZxKFvjFxr3bbL00lXmJfIk3FHv/1PAsQL/E5ciKSI7
 DgdvoIPpdtFfKAXWmDefvf7a39l4aUCQDt0syEuNP+FBaFgR8KBJId6CDDvNqYYHIRPsA/d6rE7
 +MhQC
X-Gm-Gg: AYBFou18PG7F7OR5VUJa9yGJoGwM+0nycSelCs/B+WIU6TVwfIKmWdZP56n1ZO/GRQy
 lRB7DP+YDYUpi+rT5NeAAqDRDs5Fgg5Hu7LEadooPDy+7tRWorsj3yuHipuJF3jCfiPKdNnUEUT
 gL00kRcwbtrM7I3bR0mkmMD5NrfLTRoPe2+1F6xADvqF/Ip1wcKVHAwtgL6tG+mnUTot8DWCpE7
 FffN745jW/Jk6dfN2FZlhIkXzTPRxetcX79uos1PM4UXwNfyPPpm+YrYIoE1492YtzhpG36iwJM
 XGUBAqwTRBijkYn9Z0voxEoioX78Av8+BOwGiF2CKgeRruy6Be/XmcCioB9R/Ieauvn464HlMyk
 jJoljPrU5RibJjYj0vLdP37GQxyvOA4Qc9cfUuKkzl8wEOzSYENVDdBDKdjeoc4aHke0zdUzBJl
 7ng1wwAzuMZK/aPS08mdmaSoDgPAnqarCJK2v7HFhTmU3w42lGFf55SpeW2NKCyR1Q1TGf65cxE
 4h8cyWa5S+ASRPuN4r6JjYD6hhXII+RNu98VA==
X-Received: by 2002:a17:902:c944:b0:2db:39dc:48af with SMTP id
 d9443c01a7336-2ddb1b7a12fmr5717445ad.17.1789675895961; 
 Thu, 17 Sep 2026 13:11:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 15/25] event/sw: convert from rte_atomic32 to stdatomic
Date: Thu, 17 Sep 2026 13:10:19 -0700
Message-ID: <20260917201119.2168234-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

