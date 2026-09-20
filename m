Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9BEC982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19D7440EA5;
	Sun, 20 Sep 2026 20:14:19 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 819EB40E34
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:12 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso2331694a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928052;
 x=1790532852; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QDbNcAnGRmV2A7IgtlfpEXSMrUA3x738XAVoPcIN3Ss=;
 b=HmSo4x/Yld9QswbjIZb7d2tk6bfJ/9KVscVbrpnGAEowfAy3QGCPRwGkVJE0lY6FAK
 +QoF3Xv88mrmGNhKv5SxJPUdCv3OGXOTUGXLCaxLv54HAZfOtqC+ZkDoPyhgc+QrQsAA
 8NJqrzJ0Mg1LA0Y83cnH+BLBqEF8bNB4SQh9YzhISgUcizGT200EEhup8/Hwt3sF5U3f
 aogRVzIlYgmg/yRPChYvVRYUIFzPejo2YqZRhGwzMLo+ntYQS8C8Li+nJfjZ7Cj17xqW
 VqULL+pPFKz4J1rUpIJvyJdV0IsCr791xAWCXbdda2EPofT3MMMrWL3h0nLVskrXLsno
 dokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928052; x=1790532852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QDbNcAnGRmV2A7IgtlfpEXSMrUA3x738XAVoPcIN3Ss=;
 b=E/PJSbVgbOdunv+HJHUoYPaq6AVOwBhBMbMnpgab0gIYb+2KFH3mFEr2drgXg5vO38
 Tn7iaUmU58mHSG08sbUDSeRqw5YkH2jgsshyZjO+lBqqtTtD9ZlU9bSLicZEsydAly4F
 JpiwWSZRJOmsN4FexodhmM+rrxwantRO6FoaylxKx8StDIvAYsqu1j0RYHSBN0jTogHe
 LDjWHfA2cF/ENQcq87bcg0e0oFaSvSII3x0ms7QLdKWXxQ8R7fd+bPr84UfbMCgEy2p+
 FLfBUrmk8nL6f5YlUjMwxXcox6sFfWPWPaFvko+DZpIyujKAvFcpkVClLxLB4L++t1bH
 Ljyw==
X-Gm-Message-State: AFuF++mFme13a6Re47EDILbkQxCg+FIb56XR8au1uJ4YJ1g/0+sgYFvU
 VG789XHo+WHN9UsXFwzBy7xzNtvz91x6pVcYUFuJQWGUDPmK1SnQbe7Fchl37hQeM9lqABYT2Yo
 oA8Ke
X-Gm-Gg: AYBFou2A2kpw41cDMeEIA5tWMQYNucmkP0ecb/xer1l3lyxsivvm/lr5tZEFwnmJEYF
 nCWaRPy/HlFjYjeAPWW+nW9X0VuM5Ra5J7mhs/5BojoETP/XDmUSsKA9RmdLILw/v/sEBuaOJRU
 E2RXNBPOqZxz0xKeGv2rLBb4U3VyXifb6nHGa+bzUh+Br1gJ8RNb+mou5eeABUsCGOhGX2fr0u3
 sM9dAqv/T0WXR1GMYm5IP4Ea1CeYXohaiCu7jJT42fW6VkrFkYzsjQiuf0Rl3tVSnGsT3zFLB/4
 zu4TNNx1zuFcMGRXXXZOF83BxZQf/txtgRghjP32jonYP+KUvCVoYmnep8Piq3pCZ0qh26uyF+T
 CyAeclvXwveuoLcLszv1MiWUSYu8IHP2EuA57juAIwMTM99UtBOyjRsMa2zoRPgPudJ+B5tjXqQ
 mZROw6pHCTxnt0+L3t9U1hP3NdQnYsU71wpvTO20an9fdIysXt3wxbjmfawkmHUGCXKkHH27oAz
 xDMD2UPT3qzupnIDck3DVdZcfUpvK3zG04NYw==
X-Received: by 2002:a17:90b:4c07:b0:39e:6c69:7773 with SMTP id
 98e67ed59e1d1-39e6c69796cmr7756046a91.28.1789928051511; 
 Sun, 20 Sep 2026 11:14:11 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH v2 17/33] event/sw: fix unlinks in progress counter races
Date: Sun, 20 Sep 2026 11:10:09 -0700
Message-ID: <20260920181347.747210-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

Make the counter atomic: release fetch-add on unlink, unconditional
acquire-release exchange to clear, acquire load to read.

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
index 3ad82e94ac..fedf638c60 100644
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

