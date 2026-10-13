Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB2CC6B15
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A36740DCD;
	Wed, 14 Oct 2026 00:35:18 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0500340B97
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:16 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e8b20a899fso13337665ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930915;
 x=1792535715; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pQYSQO2/xVX0dZ1/SLZYLTc3Lvbb6r9VTKL0cpOBV+w=;
 b=sUbQVNO76S4+7zIiwMv2uoUbi53lxo5gxQ4neabcqQGrckIJpxN6IPVv40F7ENOx4o
 sQrsqfC3YsEeFW3wszHbSOhSSlhf1WVllJge1g1FEBmHbOXi5EIJzYtizFkB61bfZ5EV
 lpU2GYUYZKLQMTymx/QwBuxk523TNs1IjXBLqktOaXQfGVIjkic3EvdbFzdI/5lH8lkO
 Nfn3oV2tDKRYWfWQTSu2YmLTf10WzjDEBeROYkkkWUiiIpa1uqGpBTWwWw/hYkQr/S3e
 CuaUdNjSWDfuMuB+8x+4QlaJojNFkMIXCK4W2dgPo8gquf5i+vTzKaI/mVfLdSlhAxmi
 NTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930915; x=1792535715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pQYSQO2/xVX0dZ1/SLZYLTc3Lvbb6r9VTKL0cpOBV+w=;
 b=XxTwzFp7SpXjK63DWDhjesdin2gfH7Jw+yhSjTG4GoBvgF/Cl0oQ125QQQ1gqPRQKr
 JV5Cic+SqUNB0xKzFTi5M5K3GmOcsfI6ghBFYF76kPK6MTsQMNKv9uBTG3Re70XMfuA6
 xdkSPXVobGA3uzeK+uOInBNpV96ggjvSh2SU3xn4z1nBXVCSVdxeT4MIAoKS1Dq2gQgK
 qfjVNCYRTEPCH4ZME1aq9rrJ/2v/CdqUICdWbKqD77mvvTAlscXlLKkhdtLNP9O7MiLv
 hDSjf6tPRfIunf+EqvDJc1osgL2nZU1lw+pDLqZXUVUhmZuZ/r4Xb4GxqSvrfgSbcsLK
 Linw==
X-Gm-Message-State: AFq9FYKstA2OzYgISZs3zLbn5JFpyvx6WiwAtTYe2uQI8Ke0veS4WDIO
 x643EylrYYTibVF36ZRT7l0cgXmCiTCJEH16IuCLXJSxpMwaDy5PuXQw5+6pbCGCHinoDvpzX/3
 6dW5Ad20=
X-Gm-Gg: AYBFou0re/zbktRUMt1xD+Oe04dfN4SGKTf6IlPXtoiMDVqdzftUtthtnHt2WzbP9yx
 w/T8teuDINQe3/oJKvYAS97l4uZMYmV3K81ALkdhbQCku0WXzoTubjlNM+Lof0Oy7110kJKofKz
 VItuXky/J4VVyMFAJcxt4DKEKT9XXZnczeL3KP9GijerCeP2v4Y7jhMQcl7BAeYdZBrFmk5RsFQ
 8Jcb6pLZRiUSkmydYLp5rYT/JqZCEK4dz0NAkn1Q0hFujmrjKlFOlBcT4wTVQkVh2N3g20ZvfK5
 7dwq1Edt6sTT40hcdH0U5/ZwxIWdjavWOKHbN3+56Os+cy3jY2pSeUWLdc02dgrYFDPZUclBreK
 lKZipEsh652uFfTWqcD/XkrFQdrxO5PewI+4XPvpI49Fla7sX8UOt19UIJAuiCJCzRJzr9oWjdr
 wT/ud/SUbvMt8Izg4ucMHIr7hLNEirFJdG5/EWJUBWMSKQ86iARVob+LrW5uQGB/UNyTldKfB+7
 BkYqvAnEMt+K4THc/egjCesciG5gCCqwtsHUQ==
X-Received: by 2002:a17:903:324d:b0:2e5:dce7:5c43 with SMTP id
 d9443c01a7336-2e84280a98bmr117916235ad.6.1791930915109; 
 Tue, 13 Oct 2026 15:35:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 18/29] event/sw: replace SMP barriers with C11 atomics
Date: Tue, 13 Oct 2026 15:22:31 -0700
Message-ID: <20261013222410.2257622-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

