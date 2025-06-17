Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD2CC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:03:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58C8341133;
	Tue, 17 Jun 2025 17:03:03 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2191A41109
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:03:02 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7c597760323so595254985a.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750172581;
 x=1750777381; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytBze7v0nvqs/hU5+ElOBmyhxS3NBjPnERpOK1I0qdU=;
 b=OZ/AytjCk0mN1G/RXsqRJIAGLrelsi1Ufw/HCHW6dHjuvhtnOQf6yuHElzYW+YL7w5
 IklvCJfFnMAaUnyUwZe2AWv4217vyWHd4ulSzo1TaM/S8F3SQgtHOzPRJxqUAXqV8YS+
 VXfXjxxYvlVUyaTu/57QwlMRsWlXHW3p2m7PEU8nx711ZVm5SngQ//Wj8KMeoXAMuDGe
 nchOzgodpQcRnNakCG/9cWEyFw6XIEjgksLf5bRkzClH2JaIzsZ/Cs143mAtSk4YAJ9c
 7LGhEy++rzWShit/eJCs+h9fCtFJV5WLH1Bn3vtVv2eutYV3dmBdHfrBh8XS/IHmHiL0
 4/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750172581; x=1750777381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytBze7v0nvqs/hU5+ElOBmyhxS3NBjPnERpOK1I0qdU=;
 b=n0O/N/NqSEXZ6pB95wT5Nniz3qLEJaX6DgGsov3GyCuc+mw6XxL4K6Vkswa3Mep3Ux
 LO2VdOHBDF8i/sg6wu9MILr2X6ZI2g82HUiyYLgCGOpXrN1nDG/7Z4E+G30qUOpOd1R6
 iwuj41ZdF5upRdDqbrJ/ppA6Q9wacM9XQwM/RoYL4VHN0Q/U9/M0F/U6oqzv6VGoZENQ
 7TuGkq92YWK848ySvQ928dLbdF4Jpo/1DheYIXc9AFVPLU0/4l6hIHBqMLMWKRHjuiZZ
 pWOPyQDpJdr00CDHlk+NKgCld90yCkqnQ+KQE6APQYCm5VtlSF3Csxxvb+Mm+tH+5EQM
 7/LQ==
X-Gm-Message-State: AOJu0YxYGn7vRUecWSHUpx9mVWOn22p+ymb/D1Qp2DK3ykB3JWjwc+xF
 a6182IeNH1PuXs7/Eha4aQwqX+iLdDg1q8ArXi1lQdeorBiRoW5XSVNDU0REEVuNGN/ApVyEKEU
 ASlC0
X-Gm-Gg: ASbGncuNx0kvCb6yWsiYL1dWO4Uo9F18lo/5YdL3sPVvhS1ylmTb56DbsyyQE2gubW7
 gdHj9J6kg03OAtrkbH27DWTq0l59/kSHEkaH2ATZygIdAv4t4w19JCIAvAKlYnq5qEDoKehQKbM
 +Y+IXajVVIw66Vg0JUdwJVxorR4xAXrkr23SCGXH8GAN+eLaMJAYHuHRi85mqFWqi1vQt7TuonH
 oswDHHRDouhVUvRK8ASN5CCgbi48Wg09nwQUSulpo7uPB1xjx9Fr2Bm2r8V0iaPPWeYsme5GLrX
 oRKSyXsbspP91CQ1+m/B9CsL7Ltlu16zKLECv6fx2KKB7YN1vsWvRIYr+zuWq8Df3KTgrL+1HbH
 fz+5U2hTKUvDMDQoHCDt9/RT1nqctRK1qdkI3
X-Google-Smtp-Source: AGHT+IHD4HY/j1d9ir9FpNE9cybhMWzV6mr8hCT/Oe4c0+PDfCyjRyykwy1fzaidrW2sLhTFPnKwSA==
X-Received: by 2002:a05:6214:d07:b0:6e8:ebc6:fd5f with SMTP id
 6a1803df08f44-6fb47758efamr216456416d6.20.1750172577158; 
 Tue, 17 Jun 2025 08:02:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb5a9dbf8csm13051046d6.106.2025.06.17.08.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 08:02:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 1/2] latencystats: fix receive sample MP issues
Date: Tue, 17 Jun 2025 08:00:16 -0700
Message-ID: <20250617150252.814215-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617150252.814215-1-stephen@networkplumber.org>
References: <20250613003547.39239-1-stephen@networkplumber.org>
 <20250617150252.814215-1-stephen@networkplumber.org>
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

Bugzilla ID: 1723
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Fixes: 5cd3cac9ed22 ("latency: added new library for latency stats")
Cc: stable@dpdk.org
---
 lib/latencystats/rte_latencystats.c | 55 ++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 6873a44a92..72a58d78d1 100644
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
@@ -147,25 +157,29 @@ add_time_stamps(uint16_t pid __rte_unused,
 		void *user_cb __rte_unused)
 {
 	unsigned int i;
-	uint64_t diff_tsc, now;
-
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
+	uint64_t now = rte_rdtsc();
+
+	/* Check without locking */
+	if (likely(tsc_before(now, rte_atomic_load_explicit(&next_tsc,
+							    rte_memory_order_relaxed))))
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
+			rte_atomic_store_explicit(&next_tsc, now + samp_intvl,
+						  rte_memory_order_relaxed);
+			break;
 		}
-		prev_tsc = now;
-		now = rte_rdtsc();
+		rte_spinlock_unlock(&sample_lock);
 	}
 
 	return nb_pkts;
@@ -270,6 +284,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 	glob_stats = mz->addr;
 	rte_spinlock_init(&glob_stats->lock);
 	samp_intvl = (uint64_t)(app_samp_intvl * cycles_per_ns);
+	next_tsc = rte_rdtsc();
 
 	/** Register latency stats with stats library */
 	for (i = 0; i < NUM_LATENCY_STATS; i++)
-- 
2.47.2

