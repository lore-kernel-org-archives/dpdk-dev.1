Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78ABC71136
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 00:35:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 274F042E44;
	Fri, 13 Jun 2025 02:35:55 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 86E6642796
 for <dev@dpdk.org>; Fri, 13 Jun 2025 02:35:53 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6f0ad74483fso17456046d6.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 17:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749774953;
 x=1750379753; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4RI3Hi+CDfklctP5Be2ck9aVrPXNQIin7JU9YiliR8=;
 b=WFyNK1oPcXROrJyEc/E4zy7+/tf/OaXaPPkOE0/cLAiUFYeil6c2OLlj+UQC2NPV2P
 SaZJ+z5cGTWt5bZoYYw1Ifax90X/kC1MjDc1XXVDaYU+O4r87SqDQxiUdo8Li6arr8W/
 hxXmrEYyaN8KsfIKNBdcNv0ju6Z6TEKAsAsYgqaqZaSD0LGZ8eRkrlXYdujbso7Uowc0
 41mNj7YQ7TzLf7nznXVTAdV0/JsszCixVynKTQhaiz2lzytsE38NdX1rrAE1dv90p+B5
 TzpnLZA1ul5ISd6YvLlhkRdWF2b6S6U/VBDQ2uIOE/kfSJW4H+J3in84X4nOi8rccyjT
 tHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749774953; x=1750379753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4RI3Hi+CDfklctP5Be2ck9aVrPXNQIin7JU9YiliR8=;
 b=j6KLhmcj0fvZ/WiH5BY9lqSvm3gZM6eK9o7toaDt5n/BvJtsw11AHMRmagABpGsFQk
 BO0ihxBoNpaaRWCCvhKJcNtbLExPIdYH+4XCKHH1l+iQTQN3xP5dWx8+y/WI7Z9+CuVf
 k757thH8B3J69Z4ZRd+uYDbuuaQEHn8LB/TIRc7fT/qzv+qd2Zat32AGQS7VyNUHCaJi
 ar9pIHSdFPpFAEfaNxu+BWp74kxNnJGEFprp45vDyTWSrpqg0SDqoNmORsASW+AL8/K/
 LYA3esj6k2+uocjtT4Zip0RamOkmFhyXqQ6LXDOjhCoWkW1ZEfN2FsoHr2uYR3dtNUjk
 c0fQ==
X-Gm-Message-State: AOJu0YwhmvVQhA0SfyUvDY5makejYOktrJQ7xGtp5PrHVwpc7gYuyW+Y
 aUzFrVcd3PASTTBlUMtqNrryTqr9yuYmCMc/QM1Y3FnTGwkNDlBmkFrDj/46I2ByhEdkfLoQLea
 xeYAQ
X-Gm-Gg: ASbGnctK0Fyy6YaGaDkg5ZzA8jx5kkcaB3M++Gei2N1Iepo93ak8Ixbuz1S3Fcbsn8E
 PCXujs5ZqSJcz42tZMVN6v+ZF+Pz2kKDmv4rduRE/VhsaUkLykNTVtSBkJ3MwYW4uhutKXMN0y9
 frgfme04MlXEoIKnYQF9Ie6bqkkbMoB47CblWC5HBMMSToqMEOqwJIlE70S2Rub9vMpGYxKN+85
 GxvXXdUNj6FfRLjgJt7EMNjLEBkYr+2793vUgMpdr7xe8CIBX9jN68o1wc4aRLyPKujKQVZrzTm
 L7f+f/VF1E1/wIG2cvgM1oxBUqkOISUWekdRDlVtMdfeeiw87GyJM9RRh0YX0D7bjTlV0znFkby
 QrSUym2WYV/pvOYqdYxmQiW9DtAJNfyb2EDAA
X-Google-Smtp-Source: AGHT+IGDNIubUuBMb4MuH3h6R9XbEpJeT9tITxQiWdcZd6v6p6cTs9gmzO7nyglUQRWK9IhYSZpSxw==
X-Received: by 2002:a05:6214:2588:b0:6f8:c2b9:b1f7 with SMTP id
 6a1803df08f44-6fb3e59d00bmr13552776d6.13.1749774952789; 
 Thu, 12 Jun 2025 17:35:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35c31566sm15691856d6.61.2025.06.12.17.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 17:35:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Remy Horton <remy.horton@intel.com>
Subject: [PATCH 1/2] latencystats: fix receive sample MP issues
Date: Thu, 12 Jun 2025 17:34:25 -0700
Message-ID: <20250613003547.39239-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250613003547.39239-1-stephen@networkplumber.org>
References: <20250613003547.39239-1-stephen@networkplumber.org>
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

Also, add code to handle TSC wraparound in comparison.
Perhaps this should move to rte_cycles.h?

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Fixes: 5cd3cac9ed22 ("latency: added new library for latency stats")
Cc: stable@dpdk.org
---
 lib/latencystats/rte_latencystats.c | 47 ++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 6873a44a92..181c53dd0e 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -45,10 +45,19 @@ timestamp_dynfield(struct rte_mbuf *mbuf)
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
 static uint64_t prev_tsc;
 
 #define LATENCY_AVG_SCALE     4
@@ -147,25 +156,27 @@ add_time_stamps(uint16_t pid __rte_unused,
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
+	if (likely(tsc_before(now, prev_tsc + samp_intvl)))
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
+			prev_tsc = now;
+			break;
 		}
-		prev_tsc = now;
-		now = rte_rdtsc();
+		rte_spinlock_unlock(&sample_lock);
 	}
 
 	return nb_pkts;
-- 
2.47.2

