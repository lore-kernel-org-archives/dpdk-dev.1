Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D432DC982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BA0540E17;
	Sun, 20 Sep 2026 20:14:20 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id B1B8A40E34
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:13 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso2434622a91.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928053;
 x=1790532853; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rx+unv6NXO2ufmN3UTyJx+OfS/e6mLvCzI3cubJx7Xo=;
 b=q1gxRmMlJyJBBsRBNb1TaAsXUmUWCYVk52Ut5t1pW4pFIX44eo/pS6ChZVFBeHUsJV
 AJ5dCK/+6O9vJpsellqgYS1rnwRAalKoWwkXQkyb5jXhqvaqAkj1vcTwLTTD0ZMUjYgx
 lTCXCdzq+mWFZG5vULUxWoAuhqx9vx+9PUKWXTtsrTOOUfbqwJxa6ioljdDMqMW+C+2g
 oljO8Bf0eW6r0IDdVPbms2IGp6TxlrgphEkExlMjGRjuZLT3xx6mPqdsVWwfkKu2+Alz
 aqZOI92DN88soVj8/0+pqYg4MNGXJbOcDrblcIBTmyHA1Y9Wy5Tj5kDU/EeUehMhbd9m
 3Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928053; x=1790532853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rx+unv6NXO2ufmN3UTyJx+OfS/e6mLvCzI3cubJx7Xo=;
 b=e/ApQ24+fp6mKNAX3lluiopXn+OTe1xVnGnLvWqgLFlfXyYruGgSLbOXX4mFssk6DQ
 hCq7BDugDzjwRfMjmEjKEcrxeW9+wxqm27As5gwPM0PwKJjFP/ceJhKq3+dka5b4SZ60
 ANnl0RvbX5FVaqH4RTCidADowNtPp55WjYMAtlMlZJMAN+rmG8MnnYa8O4t3MIGQ8tSX
 WA1at7/raLAQGZ5VHlydwzaka/bcvr8TJ50EKJVJufwJE419Ac4tX92yCFqfWJMEQos5
 VRxnrFBCQgACo1W6N5o5yRVGDAaLa/nZ8TzMEYAkHDLMhUy9OYAHtC18m+Gw/45u8C1j
 ZuBA==
X-Gm-Message-State: AFuF++nctI/kH3T9TjUNqOvQ4i93wxqfM5Z1dcQOM3ufBDCFQVWJpvjk
 ir8sGaEDvQgpaMganEjj0uGF+5/oqVz1vhPSq1bwRYY4at/Q5YE8AdBRUG1dHVA/QWRv/0RbVXB
 +zw8J
X-Gm-Gg: AYBFou1L8KSNRUdEavA3Bkt2JWkvl5EhP1p3B8qrmwX1X0id+5sssbTi/XsT6W6VfQS
 pB4XJ6q/hemq4hAqCX2pcDEM1XeySgivt9rK/FrTCMmmANBIqvAv5qwNf7TMm24l2KDacn04GNd
 6naLKjKggzIxseXIKoIbpELxgB/zcge3bXcu+7dRkyA3CseyIuHOjSPYrgP74UoObsLHgBbtpTV
 MVYexUeQfo4PSYUcrvV6EXQI2yZP6nVn/up+OEXVtsxkWvA5ejmYf1WQp7sDteq4y8sYl1H2e7/
 6kfqeXyRcPixxcTlPvR56LowkZbxheRoOM7ESDtdJO2t9Ep8Z3R3Ek0iLZ2vbc65D/GZWmMLLpb
 Nun3NPsMnENP6dpf6exSERm+q1nqHZ06Vr8J7TbPXrp4G4g8Z1ZIdojVc2Yv/LsFze7kHFi/Qep
 kQ0Rcft6UAflwqeNaU+5mxKBOsgDup7mQhooAOsardXqQV1XTP3eu/LEUQKeSlDy2i2tArZYqRM
 7U+KFn5lsKygsMRXQnjcHe0Cz4vvswCDLD1og==
X-Received: by 2002:a17:90b:50cb:b0:39b:370e:c807 with SMTP id
 98e67ed59e1d1-39e54ea68e7mr14871719a91.17.1789928052787; 
 Sun, 20 Sep 2026 11:14:12 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 18/33] event/sw: replace SMP barriers with C11 atomics
Date: Sun, 20 Sep 2026 11:10:10 -0700
Message-ID: <20260920181347.747210-19-stephen@networkplumber.org>
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

The write barrier plus plain store publish patterns (cq map count,
port initialized, device started) become release stores; the barrier
after clearing started in sw_stop() becomes a release fence. All are
control path.

Scheduler reads of cq_num_mapped_cqs stay plain loads: acquire loads
would land in the inner scheduling loops on weakly ordered CPUs. The
transient window where a new count is visible before the map entry
on such CPUs predates this change and is unchanged by it; unlink is
covered by the counter handshake.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/sw/sw_evdev.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index fedf638c60..6bd6b077fa 100644
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
@@ -208,8 +216,9 @@ sw_port_setup(struct rte_eventdev *dev, uint8_t port_id,
 	}
 	dev->data->ports[port_id] = p;
 
-	rte_smp_wmb();
-	p->initialized = 1;
+	/* Release publishes the port setup before initialized flag */
+	rte_atomic_store_explicit((uint8_t __rte_atomic *)&p->initialized, 1,
+				  rte_memory_order_release);
 	return 0;
 }
 
@@ -815,8 +824,9 @@ sw_start(struct rte_eventdev *dev)
 	if (sw_xstats_init(sw) < 0)
 		return -EINVAL;
 
-	rte_smp_wmb();
-	sw->started = 1;
+	/* Release publishes device state before the started flag */
+	rte_atomic_store_explicit((uint8_t __rte_atomic *)&sw->started, 1,
+				  rte_memory_order_release);
 
 	return 0;
 }
@@ -845,7 +855,8 @@ sw_stop(struct rte_eventdev *dev)
 	sw_clean_qid_iqs(dev);
 	sw_xstats_uninit(sw);
 	sw->started = 0;
-	rte_smp_wmb();
+	/* Order the started store before re-enabling the service */
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	if (runstate == 1)
 		rte_service_runstate_set(sw->service_id, 1);
-- 
2.53.0

