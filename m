Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05543C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90A2740DCF;
	Wed, 29 Jul 2026 19:57:41 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 0054340A77
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:34 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso1514865a91.2
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347854;
 x=1785952654; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=itJu7z9VhR+JTTjH94afMzC5NopkgNPKksLSUQGu/60=;
 b=vwBbXEeKuNbHlHoDUI52KEnhDNXgaMmWXCHsIr0iXJ71UZO66ACvn5lKDxoQUosE6Y
 lwCi5PGZS915CUXGb0SfG28+Sw3QKMXwApXgKB6bGFHUYfwJICTNlO10m7SKoBRBIPTb
 lKXOTL6vOTgU3hIApk3H9mq1Jnlk3CxAtfwDVs1fiK8zz7xt7D7yrQ0ObSINam3tiApf
 I0clKQR6Cdq0p3U8xyI6joIq7rl1hnEpfZUIfHaPoJ7Jl+V3hNs3D6U5mbZ/e8rNjuKs
 pP9JL6kAoFGzJnsZ3RUZFmWWSjYRenmrG+WOHtHkCnL1/9PgIX6sB9QBnFeIoEuCYLad
 G4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347854; x=1785952654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=itJu7z9VhR+JTTjH94afMzC5NopkgNPKksLSUQGu/60=;
 b=Ch9pZiG2Z+SLbo+zI1ya57mhGdUFhPxUCUSGcvKgoYmXrXstmqJjw4a9e7RXmZmwkS
 +NYUCiKhfz16VBqchzhzQ2SKyVzwWYh/CrOLVAdiN/cbkzXri5CX7aIZJwZS30ZxtMyT
 hqvl4PBNr6ej4Z4E6yThS9cQbrKIH3EeURqDxsrn/XDvrLVWaQ848VMc6ZPpFVfwsb3j
 rpx3NEALsfco6LaXrC5FRDuJ1dVV5fD/xMuHII/EiRCRfhhWfHlQ1AvME1/Yrg4Jy5R2
 zrhMvfPpTUEOwIfsP9OYVyg3ypp8PmrC8G7jTG/bLUHpDBIF+KhQ2RNdRduPP41OhdkX
 cfyQ==
X-Gm-Message-State: AOJu0Yy0kvssPhKtU3Daj7ZxOqBNlwBEdKUPk5PZjTm2JWfyS4tC2G1r
 iuU1wkdTmVlJm5mrVWD8dvNT8r5DNN5WH6mIrz3TMrNTR+y2X5o0fC+og+gg1D+KoK/zGktSLtk
 i/AoC
X-Gm-Gg: AR+sD12RSZule0BCCcU+uSIW6gyyUTKrlY8+Wlk4DUbxRHjk99/5NVKwdyl6+ccX1Yo
 8Ig2BK9iCV0Zvoe91DPxrbPa0TYBRf1z18uoTW67cU62elHCJWuUt7r1heZNFKMsuYh7k6c/UNt
 VGHof7r9++/Fq2mDdo1TEBy0aoX+0cXP4jD20bHLlMwnYDpW904D6J884C8Oo+gadZ6Y3Tdpjg6
 1xABuWUbmZA8xIx0CyrRdwUjy7pyaovma3ZKGHShbbTPoGkckMVjA8bRuAVAHvB9c79XyWQAoLm
 tPwsGg9ZUst629zrR4uQKWN5/YKrfK38wka/AuGvmP5gLSypD5Loa20v6gJOofUh603TYQO0PIX
 xsAcifo5jGD3wcXtZAVEqHzEJ7WZo0VcnySocY46RD6EoxcEVUe2piC78kSfAWV4Lk5jU9OgqDd
 2oP3c0PYP8L/pJ1urkF5LkUpazozMkOEXNYXgLKWnu8VgMk8OBJzwvgY9gULdkp7Kkm7FVCQqJQ
 VvbZSSQBo4fcIuMGRmw1gniS14=
X-Received: by 2002:a17:90b:1645:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-38f6a3d55ffmr7271404a91.3.1785347854120; 
 Wed, 29 Jul 2026 10:57:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [RFC 15/32] event/sw: fix unlinks in progress counter races
Date: Wed, 29 Jul 2026 10:54:08 -0700
Message-ID: <20260729175715.165120-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

The counter is written by both the application thread (increment on
unlink) and the scheduler (clear on ack) as a plain uint8_t. An
increment is lost if it lands between the scheduler's test and clear,
making rte_event_port_unlinks_in_progress() report completion before
the scheduler has seen the unlink. Nothing orders the scheduler's
later cq map reads against the counter test on a weakly ordered CPU
either.

Make the counter atomic: release fetch-add on unlink, acquire
exchange to clear. The exchange cannot lose a concurrent increment,
and the acquire guarantees the scheduler only acks unlinks whose cq
map update it can observe, replacing the full barrier in unlink.

Fixes: bd5ac24fea88 ("event/sw: implement unlinks in progress function")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/sw/sw_evdev.c           |  8 +++++---
 drivers/event/sw/sw_evdev.h           |  2 +-
 drivers/event/sw/sw_evdev_scheduler.c | 13 ++++++++++---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index 3ad82e94ac..bb6f50e03b 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -119,8 +119,9 @@ sw_port_unlink(struct rte_eventdev *dev, void *port, uint8_t queues[],
 		}
 	}
 
-	p->unlinks_in_progress += unlinked;
-	rte_smp_mb();
+	/* Pairs with the acquire exchange in the scheduler */
+	rte_atomic_fetch_add_explicit(&p->unlinks_in_progress, unlinked,
+				      rte_memory_order_release);
 
 	return unlinked;
 }
@@ -130,7 +131,8 @@ sw_port_unlinks_in_progress(struct rte_eventdev *dev, void *port)
 {
 	RTE_SET_USED(dev);
 	struct sw_port *p = port;
-	return p->unlinks_in_progress;
+	return rte_atomic_load_explicit(&p->unlinks_in_progress,
+					rte_memory_order_relaxed);
 }
 
 static int
diff --git a/drivers/event/sw/sw_evdev.h b/drivers/event/sw/sw_evdev.h
index c159be21be..8b9118bf91 100644
--- a/drivers/event/sw/sw_evdev.h
+++ b/drivers/event/sw/sw_evdev.h
@@ -160,7 +160,7 @@ struct sw_port {
 	 * progress is read by the scheduler, no more events will be pushed to
 	 * the port - hence the scheduler core can just assign zero.
 	 */
-	uint8_t unlinks_in_progress;
+	RTE_ATOMIC(uint8_t) unlinks_in_progress;
 
 	int16_t is_directed; /** Takes from a single directed QID */
 	/**
diff --git a/drivers/event/sw/sw_evdev_scheduler.c b/drivers/event/sw/sw_evdev_scheduler.c
index a5fdcf301b..f4bce2cbb8 100644
--- a/drivers/event/sw/sw_evdev_scheduler.c
+++ b/drivers/event/sw/sw_evdev_scheduler.c
@@ -523,9 +523,16 @@ sw_event_schedule(struct rte_eventdev *dev)
 		do {
 			in_pkts = 0;
 			for (i = 0; i < sw->port_count; i++) {
-				/* ack the unlinks in progress as done */
-				if (sw->ports[i].unlinks_in_progress)
-					sw->ports[i].unlinks_in_progress = 0;
+				/* Ack the unlinks in progress as done. The
+				 * acquire exchange orders the cq map reads
+				 * below after the unlinker's map update.
+				 */
+				if (rte_atomic_load_explicit(
+						&sw->ports[i].unlinks_in_progress,
+						rte_memory_order_relaxed))
+					rte_atomic_exchange_explicit(
+						&sw->ports[i].unlinks_in_progress,
+						0, rte_memory_order_acquire);
 
 				if (sw->ports[i].is_directed)
 					in_pkts += sw_schedule_pull_port_dir(sw, i);
-- 
2.53.0

