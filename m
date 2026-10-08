Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E404ACA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADBCE40A89;
	Fri,  9 Oct 2026 01:37:37 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 315554060B
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:36 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-88aea027391so3115420b3a.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502655;
 x=1792107455; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pQYSQO2/xVX0dZ1/SLZYLTc3Lvbb6r9VTKL0cpOBV+w=;
 b=KhWzWV+tumxhTB7GVCWXd+YXjB+0uzEcRIP55/6OE/cCQDDQcdHxK5EMaZFCibioh5
 yw45UmiIvu/vLjoJ+lDtQ0kT4KV+qhjf/zmpd6KpcqgFy975pBX8bn/60HO7Pp0QI/Vw
 jwqwPxanWdUEEoMWCKqKnNoYPyz7wGpqYEM8KdiA0rwAET13odO0z/2cfbJORwkcVzpb
 I6DonWWKPIz9px05N9BMq/NlfiQzQsJ0bGpnk+gUOkvzd9McABbUz0dxiNINf38gjkYe
 HQUSsDqXSdEe+FUBR5wa+xDypdj7zDCU2LgYfiqHZ5cwn8d6uw9Vy242HvSY9cbmAjKg
 nnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502655; x=1792107455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pQYSQO2/xVX0dZ1/SLZYLTc3Lvbb6r9VTKL0cpOBV+w=;
 b=epgpKtzMCbCh2PyhaT3e79iiheA8KA/AeyCCfrVe1qcPpDDzXA5N8SetzCH2UhZtGm
 iku6VZGGHzf9I5cWCp8EToJ6OHyFHsBzV0qx8bpiUxvevTB2DCUQ34MLHuwzNHEqZVai
 Z0rNEg9b71ncPdeqMgYuQeHx4RVbDk6qzZf5Ne7Ol2uWnh7qvWBdG7rjIUALWv/2mVWR
 Iws7VfADATHFvC/maoaPXyFl4L/g8ol/q8clu/Piefi2KZqA48wo9YARfkm5whDe4O3m
 yErTioLQ4hukD6+hQDOHxYo4c2XqmysOl1wRdzpXQySdIDUGyUxl+N1XvuHwRIDZYlzX
 SxOA==
X-Gm-Message-State: AFq9FYIQRbgmPs8qp/VzJcJiqqMvfwaHs9n2VTXVcRmEnSPAKbPPJ5eE
 0S0D3HyO+EwQ+EIqOk7N4ECvstJLNZhyKUCsLgOMg0XbpneZo88gKsjHY0OsLQyKQpkFfUn8YSA
 2y1R+raU=
X-Gm-Gg: AYBFou0AzssboRyc7fM58spLHe00wQl4abLAYEVVPfY+7M3cTsyzYcHBGi5L9YwCZot
 uhwnr/vq4nm50iRqOjTlCe1xsJvDh0SucO+YAReTPv6Lmda2AQUpXIrwhm7eoIYcIclAH0n1CYx
 +DwBRmp3cGwF0dIMp0aNstOWLnr2efXraxyoFscVtcG/EyXtOl3Qg2z30VwnEcLQGqs8R9h1TSK
 L57d3gU7m8EtYWNosZITE5vNQnALFqjoJrQSBIYYVSM/n0ik7UZC1ngMhF66LXwh6TVOK7OE/rR
 FSCyoYrfATLZoCq3b4r1BsvLksPejLSZPFAKjZi6Qx2LME75TJ9QhNWRP6IJGWllESh6BQGbc3e
 Y8gKmidXO0WEExDw/NLIjC6J6kzb9+nzt91tZDqUdQQmqKY3jGFaURf2x98kPpMjLRZEgJKHlXg
 g7HR2Eu+zSC++PRrWmERppoP51fvZGtVE9qMuD5KbnrcU0UCVN3V8Ta0iv/Z3KRnqQFxAk/ZbgR
 sUVMMc4o0KtPZkTgNFgfwNUT/PBMU4qsXYeGkj7Fafiv7mN
X-Received: by 2002:a05:6a00:4299:b0:885:e2eb:23b6 with SMTP id
 d2e1a72fcca58-897c710687amr49672b3a.11.1791502655306; 
 Thu, 08 Oct 2026 16:37:35 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 18/29] event/sw: replace SMP barriers with C11 atomics
Date: Thu,  8 Oct 2026 16:35:11 -0700
Message-ID: <20261008233649.1260843-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

The write barrier plus plain store publish patterns (cq map count,
port initialized, device started) become release stores; the barrier
after clearing started in sw_stop() becomes a release fence. All are
control path.

The scheduler load of started is acquire, to complete the handshake
with the release store in sw_start(). It runs once per service call,
not per event.

Scheduler reads of cq_num_mapped_cqs stay plain loads: acquire loads
would land in the inner scheduling loops on weakly ordered CPUs. The
transient window where a new count is visible before the map entry
on such CPUs predates this change and is unchanged by it; unlink is
covered by the counter handshake.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/sw/sw_evdev.c           | 29 ++++++++++++++++++---------
 drivers/event/sw/sw_evdev_scheduler.c |  7 ++++++-
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index 87a8996f9d..165d8e3950 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -84,8 +84,10 @@ sw_port_link(struct rte_eventdev *dev, void *port, const uint8_t queues[],
 		}
 
 		q->cq_map[q->cq_num_mapped_cqs] = p->id;
-		rte_smp_wmb();
-		q->cq_num_mapped_cqs++;
+		/* Release publishes the map entry before the new count */
+		rte_atomic_store_explicit(
+			(uint32_t __rte_atomic *)&q->cq_num_mapped_cqs,
+			q->cq_num_mapped_cqs + 1, rte_memory_order_release);
 	}
 	return i;
 }
@@ -105,8 +107,14 @@ sw_port_unlink(struct rte_eventdev *dev, void *port, uint8_t queues[],
 			if (q->cq_map[j] == p->id) {
 				q->cq_map[j] =
 					q->cq_map[q->cq_num_mapped_cqs - 1];
-				rte_smp_wmb();
-				q->cq_num_mapped_cqs--;
+				/* Release publishes the map update
+				 * before the new count
+				 */
+				rte_atomic_store_explicit(
+					(uint32_t __rte_atomic *)
+						&q->cq_num_mapped_cqs,
+					q->cq_num_mapped_cqs - 1,
+					rte_memory_order_release);
 				unlinked++;
 
 				p->num_qids_mapped--;
@@ -210,8 +218,9 @@ sw_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	}
 	dev->data->ports[port_id] = p;
 
-	rte_smp_wmb();
-	p->initialized = 1;
+	/* Release publishes the port setup before initialized flag */
+	rte_atomic_store_explicit((uint8_t __rte_atomic *)&p->initialized, 1,
+				  rte_memory_order_release);
 	return 0;
 }
 
@@ -817,8 +826,9 @@ sw_start(struct rte_eventdev *dev)
 	if (sw_xstats_init(sw) < 0)
 		return -EINVAL;
 
-	rte_smp_wmb();
-	sw->started = 1;
+	/* Release publishes device state before the started flag */
+	rte_atomic_store_explicit((uint8_t __rte_atomic *)&sw->started, 1,
+				  rte_memory_order_release);
 
 	return 0;
 }
@@ -847,7 +857,8 @@ sw_stop(struct rte_eventdev *dev)
 	sw_clean_qid_iqs(dev);
 	sw_xstats_uninit(sw);
 	sw->started = 0;
-	rte_smp_wmb();
+	/* Order the started store before re-enabling the service */
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	if (runstate == 1)
 		rte_service_runstate_set(sw->service_id, 1);
diff --git a/drivers/event/sw/sw_evdev_scheduler.c b/drivers/event/sw/sw_evdev_scheduler.c
index 207dee5854..5b15c2a9ad 100644
--- a/drivers/event/sw/sw_evdev_scheduler.c
+++ b/drivers/event/sw/sw_evdev_scheduler.c
@@ -513,7 +513,12 @@ sw_event_schedule(struct rte_eventdev *dev)
 	uint32_t i;
 
 	sw->sched_called++;
-	if (unlikely(!sw->started))
+	/* Acquire pairs with the release store in sw_start(), so the device
+	 * state it published is visible before any of it is used here. Once
+	 * per service call, not per event.
+	 */
+	if (unlikely(!rte_atomic_load_explicit((uint8_t __rte_atomic *)&sw->started,
+					       rte_memory_order_acquire)))
 		return -EAGAIN;
 
 	do {
-- 
2.53.0

