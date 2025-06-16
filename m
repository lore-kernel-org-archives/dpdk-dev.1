Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45529C71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 16:07:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0BF44067D;
	Mon, 16 Jun 2025 18:07:30 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 42AF54066A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:07:29 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-748c3afd0dbso474963b3a.0
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750090048;
 x=1750694848; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uNTSUdMT39Bx9qV+/2J8A+V80kOw2d+sDqfCWDt/tg=;
 b=iAjwZQw+o+q6F/yptI+r7Smd8nJo53c+zjm0xtTH0fhQE7gpLBDeRTtcJztk2cHwXq
 NPizCowh9mh1AemyyL+6cRR37e3x8tF3kaiJCjlEKYlvV0cSd/CqSWpY0j+KmoQ1iTdR
 T/fNqfYS8oUTVmUuKWyMTXmZk96fDBpPdY9nk9QZ+VrP+tDEoeKYR8jXDC/Kxcs9MlQt
 WyZw4UZ+cTSV+UHBsFhfojpP6hRP+PV3s8VQPHtWEgcMTTsKAD9kJ+WplOR9LE6cSK+K
 UUW34yRNipx9nMlzhxGh7RGpHuvh9khMXfPwGtrNVIDNl/EFdmwAUnssRhPh8vevHl71
 V0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090048; x=1750694848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uNTSUdMT39Bx9qV+/2J8A+V80kOw2d+sDqfCWDt/tg=;
 b=ArioAWNcNj1QSaiujlvC68fj/kJ55rHvox3YZSzuy8vSbW9ixnDEY8kNfIVzWcIs7H
 5osdyqdrbhE/7idsE3yzczRZMcF6XE4TBq8LyhnOiuFS1TupW+HRzCEITedmvL1+bQEh
 Q7LObGXmZdZgZ99qoE56oKJyCQNJcBBPswEmVBvFyMIWVacBL4NS9MjKZxopk/89jBQ2
 LxTJHswK+pb0RMkdYGUs/JQsp9KRVVpRUv8bk5/GiByE2VZsZ9xDk95axyZKm0T1gpwc
 EmH9W4j5NzVKo/HLb+u4TDihTexeWKsIMklnw4/875VPUbP0glxQFWecI70DvNH4z1J8
 Vx/g==
X-Gm-Message-State: AOJu0Yw3TH/V3ZPkHs/xymyJJz/dO/SoCAGZLcO5mWohrvjLb2l/l9V0
 3MHcT4NTCeM7Bsstyl0SwPciRBdCTzcTHugEqxEVzTEnvUMPlR6YiSnyhwg3Y+3DjqAjX0K8MAk
 Wr12/
X-Gm-Gg: ASbGnctht2QFVqnowods7qtk/wxxuCnjxH0Wj/DvjoP0Y+bYh5yKVSZ1kcAmdAKsjFq
 d8VG1w7nvED0Ucx4jBdApJhcBAkOMWkBfpLDYlD9jSWnfW9ezy4YgRRAwaEuZ3VNeaD5J2s5j4K
 U+Jxx2lsjSZGWnNWD9AU40/xxlIDY32935WJHC9HnJLzv20uaXZMQts5EufZL2J+vRBjfrd2Vlo
 iphwOJAVSGcE4W9CDc1a3e/r7PbbqCwNRuQy5hKBBEEVEs3ve5+th+kpfNAVRRbPY+9CtLJIC3e
 RjmJmsAD+U2a30EEHFGXgCmGLz0FedQqCPuq7baGoN8dChNoC6NQqAYtIcXdWu7mMxlroTFQ+02
 Z7kvVAc7bTeawcze8iREaRZTlWIICwAw3n9vV
X-Google-Smtp-Source: AGHT+IEXRpVaWkBDuP3JnYHzW+LJKXpQXI5mImG1ZmSA/mIicIhEfW1g0O1uZ5DpnGfN8fwHoVrXHQ==
X-Received: by 2002:a05:6a00:399d:b0:736:33fd:f57d with SMTP id
 d2e1a72fcca58-7489cfc360dmr10087573b3a.17.1750090048256; 
 Mon, 16 Jun 2025 09:07:28 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748900d252esm6992623b3a.163.2025.06.16.09.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:07:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 1/2] latencystats: fix receive sample MP issues
Date: Mon, 16 Jun 2025 09:04:32 -0700
Message-ID: <20250616160718.49938-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250616160718.49938-1-stephen@networkplumber.org>
References: <20250613003547.39239-1-stephen@networkplumber.org>
 <20250616160718.49938-1-stephen@networkplumber.org>
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

The receive callback was not safe with multiple queues.
If one receive queue callback decides to take a sample it
needs to add that sample and do atomic update to the previous
TSC sample value. Add a new lock for that.

Optimize the check for when to take sample so that
it only needs to lock when likely to need a sample.

Also, add code to handle TSC wraparound in comparison.
Perhaps this should move to rte_cycles.h?

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Fixes: 5cd3cac9ed22 ("latency: added new library for latency stats")
Cc: stable@dpdk.org
---
 lib/latencystats/rte_latencystats.c | 51 ++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 6873a44a92..2b994656fb 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -22,6 +22,7 @@
 #include <rte_metrics.h>
 #include <rte_spinlock.h>
 #include <rte_string_fns.h>
+#include <rte_stdatomic.h>
 
 #include "rte_latencystats.h"
 
@@ -45,11 +46,20 @@ timestamp_dynfield(struct rte_mbuf *mbuf)
 			timestamp_dynfield_offset, rte_mbuf_timestamp_t *);
 }
 
+/* Compare two 64 bit timer counter but deal with wraparound correctly. */
+static inline bool tsc_after(uint64_t t0, uint64_t t1)
+{
+	return (int64_t)(t1 - t0) < 0;
+}
+
+#define tsc_before(a, b) tsc_after(b, a)
+
 static const char *MZ_RTE_LATENCY_STATS = "rte_latencystats";
 static int latency_stats_index;
+
+static rte_spinlock_t sample_lock = RTE_SPINLOCK_INITIALIZER;
 static uint64_t samp_intvl;
-static uint64_t timer_tsc;
-static uint64_t prev_tsc;
+static RTE_ATOMIC(uint64_t) next_tsc;
 
 #define LATENCY_AVG_SCALE     4
 #define LATENCY_JITTER_SCALE 16
@@ -147,25 +157,27 @@ add_time_stamps(uint16_t pid __rte_unused,
 		void *user_cb __rte_unused)
 {
 	unsigned int i;
-	uint64_t diff_tsc, now;
+	uint64_t now = rte_rdtsc();
 
-	/*
-	 * For every sample interval,
-	 * time stamp is marked on one received packet.
-	 */
-	now = rte_rdtsc();
-	for (i = 0; i < nb_pkts; i++) {
-		diff_tsc = now - prev_tsc;
-		timer_tsc += diff_tsc;
-
-		if ((pkts[i]->ol_flags & timestamp_dynflag) == 0
-				&& (timer_tsc >= samp_intvl)) {
-			*timestamp_dynfield(pkts[i]) = now;
-			pkts[i]->ol_flags |= timestamp_dynflag;
-			timer_tsc = 0;
+	/* Check without locking */
+	if (likely(tsc_before(now, rte_atomic_load_explicit(&next_tsc, rte_memory_order_relaxed))))
+		return nb_pkts;
+
+	/* Try and get sample, skip if sample is being done by other core. */
+	if (likely(rte_spinlock_trylock(&sample_lock))) {
+		for (i = 0; i < nb_pkts; i++) {
+			struct rte_mbuf *m = pkts[i];
+
+			/* skip if already timestamped */
+			if (unlikely(m->ol_flags & timestamp_dynflag))
+				continue;
+
+			m->ol_flags |= timestamp_dynflag;
+			*timestamp_dynfield(m) = now;
+			rte_atomic_store_explicit(&next_tsc, now + samp_intvl, rte_memory_order_relaxed);
+			break;
 		}
-		prev_tsc = now;
-		now = rte_rdtsc();
+		rte_spinlock_unlock(&sample_lock);
 	}
 
 	return nb_pkts;
@@ -270,6 +282,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 	glob_stats = mz->addr;
 	rte_spinlock_init(&glob_stats->lock);
 	samp_intvl = (uint64_t)(app_samp_intvl * cycles_per_ns);
+	next_tsc = rte_rdtsc();
 
 	/** Register latency stats with stats library */
 	for (i = 0; i < NUM_LATENCY_STATS; i++)
-- 
2.47.2

