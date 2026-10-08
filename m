Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA9FCA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9264740A6B;
	Fri,  9 Oct 2026 01:37:36 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 544C4402EF
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:35 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8897e83332fso592110b3a.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502654;
 x=1792107454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NzN5NFfCdF3jpmFWfIScsrauHxpMTMiTXbOx2sYHtiE=;
 b=mSyCOBA3WFiaC4ZceSlhh9IWaRiNANX4TrrV5wIKE+9kzWd0wbmQQ20UfLh2foWLfh
 o5rBul59fYS9HyPsADblC542E5sI3HqTsETEYaYjcgXOeENCCSXwdpQ3cUqpyoU/V4QP
 IUAMOCdRvgD4Myr66vd4pGTJD4ClQKWdui7BZTbvIl2nXMfqFFME07dCo/w23opt9+4/
 dGExdBcvqA6uiVx8QMB513MyYL5IbjKY+MZOuT8xDKBywpHIlTQn8Z9yEA1ZN0xpY3T2
 Kr7N2tHphemTHHqbB9/V5oU+G6jSvClGKc9PL0Sz9ZeYyvihVSE1l+DAMwGP0/1l9J1W
 H8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502654; x=1792107454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NzN5NFfCdF3jpmFWfIScsrauHxpMTMiTXbOx2sYHtiE=;
 b=bMbsiRSwkJz8q5ShiRxvvFPniZmNlt990iXi9/hlWlZaQhfRKZ8xqZruf9CY3ATNFk
 FduCLrA9TLkmFe5NXMqAtFEPl1Z1yozl/9oLdgxJq+zEGKqRNEEqacf+HtRmoaNXnBLs
 0h+OxnI/PEqBhHpcc3UEno5hguR9CjBVX5Ad6EAJwPoCUdhlYz+kmERSSvoBwgIOu6o8
 bjrQAgs5Eicv724ZNxdSGbqeQTXxrXahwZ00AyyNJEJGp0/KkTl6hy8aCyL0vpJQkJbD
 n9IuH3wP5pTm1z4gR1HBC+eHb8Mmq46IsddOAP6TAP+lEnQZ5M7eV8GsHwPgt4qm6WmA
 zXWg==
X-Gm-Message-State: AFq9FYJdaIrUWI2bQ6cBGPePUCzIEcPhAQ1Z07za8n97Q/awKzfV+IT9
 v7PTmO9yfMVqCTbyqFY+/6ASrV4iHgR4zSW51HXZbDW7A3qfElLRZf7NDVWhpA9ph7FpADG+ltm
 UFl8wrmk=
X-Gm-Gg: AYBFou2jAXtO1CA4EhJYSUMVwLzGn2sMnrW3A5guU/uXPMGISuQB5GImtCT33bTRR9Z
 TXS8BZ6Bm1IeazaRQ/x6YeLbjHprLKCsb/RPleNd6sTySoSxeuGCFouixR5sTi19WSDsiBexdHw
 jfPv3nYisQ5moiwZm1WcrZF5ZtiLmfh6bB52Jf+lfVtfiCjdj4gFoLxwdTZSRKjPVy0xdWwVR01
 lizc6CbkvFCRljlfn8a+Y2uMXWT1oKFvcJOFrz2F1J9Vwpkc6b3oVTsangO/xLn23wYiucTg6zB
 MSK1DCIJZLcDLRR7vUEAVy6OkbXrK9Rk59pQMMrl5ZTwcVf7B6wDVPmUqLi3uqwYmm/I3S0yEtP
 X2gNKEiwBwsq8pfDcrWVr2qq3hWOU136nO/e4BvBpHKqfT0r1PVBnpOv3pSKR7qu94MFcGA2EPp
 mRj6k5QAennsyZzPohcmHra6jxJoIRbVyqjhwtSsaKD6O9IYsYMxdbIFCBrZUuY3GK0E7M0FBHo
 kGpM/XzZYolZQ6dMoO9U529Ff1ANijR4G+0J/3NydIplhQa
X-Received: by 2002:a05:6a00:844:b0:874:72b6:7dac with SMTP id
 d2e1a72fcca58-896a45f0092mr510428b3a.39.1791502654473; 
 Thu, 08 Oct 2026 16:37:34 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH v3 17/29] event/sw: fix unlinks in progress counter races
Date: Thu,  8 Oct 2026 16:35:10 -0700
Message-ID: <20261008233649.1260843-18-stephen@networkplumber.org>
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

The counter is written by both the application thread (increment on
unlink) and the scheduler (clear on ack) as a plain uint8_t. An
increment is lost if it lands between the scheduler's test and clear,
making rte_event_port_unlinks_in_progress() report completion before
the scheduler has seen the unlink. On a weakly ordered CPU nothing
orders the scheduler's cq map reads against the counter test, nor the
application's reads against the counter reaching zero.

Make the counter atomic: release fetch-add on unlink, acquire load to
read, and an acquire-release exchange to clear. The exchange cannot
lose an increment that lands after the test, so the scheduler can
keep its relaxed load of the counter first and take the locked
read-modify-write only when there is an unlink to acknowledge.

Fixes: bd5ac24fea88 ("event/sw: implement unlinks in progress function")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/event/sw/sw_evdev.c           |  8 +++++---
 drivers/event/sw/sw_evdev.h           |  2 +-
 drivers/event/sw/sw_evdev_scheduler.c | 17 ++++++++++++++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index a2f760a98d..87a8996f9d 100644
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
+					rte_memory_order_acquire);
 }
 
 static int
diff --git a/drivers/event/sw/sw_evdev.h b/drivers/event/sw/sw_evdev.h
index 5e49b08030..22da5d1622 100644
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
index a5fdcf301b..207dee5854 100644
--- a/drivers/event/sw/sw_evdev_scheduler.c
+++ b/drivers/event/sw/sw_evdev_scheduler.c
@@ -523,9 +523,20 @@ sw_event_schedule(struct rte_eventdev *dev)
 		do {
 			in_pkts = 0;
 			for (i = 0; i < sw->port_count; i++) {
-				/* ack the unlinks in progress as done */
-				if (sw->ports[i].unlinks_in_progress)
-					sw->ports[i].unlinks_in_progress = 0;
+				struct sw_port *p = &sw->ports[i];
+
+				/* Ack the unlinks in progress as done.
+				 * The exchange cannot lose an increment that
+				 * lands after the test, and its acquire orders
+				 * the cq map reads below after the unlinker's
+				 * map update. Nothing to synchronize with when
+				 * the counter reads zero, so test first and
+				 * keep the locked op off the common path.
+				 */
+				if (rte_atomic_load_explicit(&p->unlinks_in_progress,
+						rte_memory_order_relaxed) != 0)
+					rte_atomic_exchange_explicit(&p->unlinks_in_progress,
+						0, rte_memory_order_acq_rel);
 
 				if (sw->ports[i].is_directed)
 					in_pkts += sw_schedule_pull_port_dir(sw, i);
-- 
2.53.0

