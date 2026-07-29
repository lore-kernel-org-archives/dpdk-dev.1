Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D17C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD27440DD6;
	Wed, 29 Jul 2026 19:57:42 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 1626140A8B
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:36 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38e071ed6aeso1123060a91.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347855;
 x=1785952655; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lEifqqKOXgC1FY8p/gDzQU/6M/dVgLI58hl7+YVQlpQ=;
 b=tALljz8qFiYlZJLFJ7zwU7dVxNqBk3zkWDQ5L1DI5rKolrQ5Z3k7t+AWzgKUzgamjD
 74pLL47udSdvT3kSs6Fr7gvHRwcuuoIjlUzrp5EjyrwqFCrT1s4Zd34cruPUOJOkvMN6
 VHENqnSzSKAuDoriOf9+RRmUGh0yjmOIrwtXJgH54QVx1AOOjKvEm5kDK9BI4u4JFM+O
 OgScVQ+EyWOlVkZssnRDjuySP5CqLc8YcNEAg6lGhKLlp8j4hVrsfpbmJ67M4f8ORuu8
 PCdgu2Cw3Uhm0BmgNAOU8rf/BrcbmOCKib71HNTCOv+RfzDRiDvNYQ+3OwJ9roYh6IUK
 7V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347855; x=1785952655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lEifqqKOXgC1FY8p/gDzQU/6M/dVgLI58hl7+YVQlpQ=;
 b=g+oM3//adBlSm7IDQ82OHi5l5UZSmNW+BONehQkwegtxjR1DeixWHEMxwkEenzSex8
 KOVzAPlmWqTSsS96r/3nm8/rzZzixexRwPKL5GkeU7Fs98+q4b6GGXHKnUAGbp3JHg2k
 Ui7t7qLK5ESrlbF6TjHURRm//gzVeNMhMMTEZavqCI3s1SBOq0yFPAFlqrqhfoECoV+f
 Pkw/24tlbogaY9mJfgDYpfkS4Kke4g/PGVFvDMMdEfPc2OiKVz87Wce1Lq84uYeIetzG
 vvbNZCypvbKALCxoMqHrz7CZtdHA2epymg5Lp52kis74z1HoKsOM6FBXpW0pT7VCkF8Y
 tteA==
X-Gm-Message-State: AOJu0YznPPNOvYqZ7imDEJEQCPhyNuSMlhAJ+v2Y+67FpcXmUNbWmZTA
 /xhG4f/fLMpP//+QbqCASx8iakxwr3uVdyA8SWaNOfL9pqoGXUjnNrX8nhWB+wg0DsPUAvHNgIJ
 Zeleh
X-Gm-Gg: AR+sD13g2f5OGFuVKm6o8DEIazUWnd0r1RpFXIkmFHSJgYgxMmld/UeS1yUic+Aw/sr
 /nB+on0qZaL9a4M7XLXUMrNQ2O1qkdIoUDogfbrqSQ7V1HckreAKZ8WMZBTLCa/a3L52OVoHLAi
 7/cpieuKKO5AY9FOSQyU5BLWT9vwKhRlGmSWWm1YMTmvv6NNmS1VMQy0sV5KPbrZKFugUg44v/E
 1ORWMZ4jnoqkVPpo1LVC94nkG9Lo73cmCg9vyzcsSY/EiMS2gWnvnhbREh6EDVWr29z4XBWqb0d
 jNBhPbaTzmCXI3VWmGzojwxdCrHnm3MAXTa6d4WNl/t21cKhyKrtsIzTdZeDN4vNNlVKciL1gks
 61LBzUtdayVtxi1dmuHcfSmQ2JCpGNROH3v6Fwnr+mBwQ1CnhI0EuVZ10nSzAW9BvetkGzKVcXi
 xsMiYJswhsUG38R5zitoqNqP6XT139vwP1ayKs54Zkhd2LH5Al9xJdvtBPgORhLLLiDm/AAvLw8
 40IC4djRVzuSqhMa0qRgzRTXtM=
X-Received: by 2002:a17:90a:e7ce:b0:381:cef1:11b0 with SMTP id
 98e67ed59e1d1-38f6a54400bmr7165434a91.33.1785347855217; 
 Wed, 29 Jul 2026 10:57:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 16/32] event/sw: replace SMP barriers with C11 atomics
Date: Wed, 29 Jul 2026 10:54:09 -0700
Message-ID: <20260729175715.165120-17-stephen@networkplumber.org>
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
index bb6f50e03b..bdb3dff997 100644
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

