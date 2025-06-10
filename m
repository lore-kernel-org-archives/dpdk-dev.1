Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF53C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:14:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B4CD42EE9;
	Tue, 10 Jun 2025 16:14:03 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 86FC042EE4
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:14:02 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7d3939ecb7dso216474485a.3
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749564842;
 x=1750169642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuiemdpcJHhTY3JEEedNwwiaUPelO68Cu85LAtNYwEA=;
 b=WLGwTXBHAoJr1g1CyxtOSaeHqyVQ/UVgZWyG24Yw3gCQpJpLukcgIFIO8rgw+oskAd
 Y+vHJaiM7H1lWQfwno5dpa+n5LcFikUVWm+9T6U6BGf1Q41zpZI4U374iVroQHSmzwOc
 R2HxZtUGL1VLqgYBvJbe4m+2xCxiAY2hXSENXn5s3PQJHaeCx7VZE+JsWoljOiSXCFQt
 z1nw0Kj5NAKop3vQujjlnepnva0++R1uGGYYbEYkE6iTEUb2kYMS8DbqxImRZTYb62AV
 SmgogYAteFq3Wl2G0pTIwx1/37MS2dBP8/etC7KUo6rrHWow1fTDP12/aE+MD33rEpym
 eWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564842; x=1750169642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuiemdpcJHhTY3JEEedNwwiaUPelO68Cu85LAtNYwEA=;
 b=L6vGzf2MyWBttPfpnw8TN34wkbQt9TtIBaS4valKLhaUNhSdpajQ2ru3oP706EBxhd
 gSMESbjCc1gDb9A1uSonT/+Ff0gwiWBtisrjy5T1xffDcBCdyL9BonM3Apokr3GEompS
 8PSM0URCt7FB2CWTij+roQ4RUpoz5kH/hEIbXP0OwszoEvOxJ1gMaoV65kttyqZ0TBYY
 lbmqAP0Hlm+OGWTZVezSCDl26hJ1AbRME4jC93VutLhWp6j8EjQNB5GHPtAVbKND9LW7
 pF6O9Q5W6Jynxt5aA1o7ZgvaVsbTmHfsY/Tw8kJSIgXDj6JL2KRp8iicJbyklcpj/7CG
 SAVw==
X-Gm-Message-State: AOJu0Yxfi6RIo+ABAGqUDWsyHzV8XaqIy/JxNNsu2ulpwbJU1uvlsHOL
 J2hCxS2tlh/iDoYOMJjVl9kHgXVFOY3e9nOYcDzPcapjhfzglPED5l756Y9nnNVBGKSXEMNnptb
 NwoDz
X-Gm-Gg: ASbGncvUxV4Fk4N5yP+WuHXyterNAVfD4Ww+BFXm3QsskuGU1MFCAJ8c+dxei/itMTa
 JkzDNQ5yL3Z0k5uguvoV5xZjAZMJLEgLyqTl3s7m72xZDAj5i9k/ipiZMMQBj/P9keqKF7XsZjE
 YGZzEgp/DiHUKcLiIuPcbA8kvAvqotTVidY4slAYhhlZRZzCM7ftz3NLo/UktdxVcLanIBD5QDg
 fjt1PiO205HBxp2uIuF/NRHHeDmBanqH7eGVSajbfLw9C5emJSjreZPD1VXEp2Hmv72jGkF9+Mn
 5S5cyt6G4YcGw5RW/ddtQm/PAMm4HyChM1uBOQawV3lOZYSqvz/o8NbEh89wORp7IjpM2FTXFCz
 QBjY1NPmAN0zX5IdJKUpN8Od5phgpAg6uothj
X-Google-Smtp-Source: AGHT+IHP672apIgf+QVuSnZOLCuStQJB3c/5ZYPe+THCeroTi03+4UfwpoZ5rH4z9Zf4g1+oKqIMhg==
X-Received: by 2002:a05:620a:20c6:b0:7d0:9f1e:40dc with SMTP id
 af79cd13be357-7d2299339bdmr2111971685a.56.1749564841805; 
 Tue, 10 Jun 2025 07:14:01 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b573asm698525985a.110.2025.06.10.07.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:14:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 2/7] latencystats: do not use floating point
Date: Tue, 10 Jun 2025 07:12:41 -0700
Message-ID: <20250610141355.91759-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610141355.91759-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The cycle counts do not need to be stored as floating point.
Instead keep track of latency in cycles, and convert to
nanoseconds when read.

Use scaled math with exponential Weighted Moving Average weight
of .25 to avoid use of floating point for that.

The average latency took too long to "warm up".
Do what RFC 6298 suggests and initialize on first sample.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/latencystats/rte_latencystats.c | 127 ++++++++++++++++------------
 1 file changed, 72 insertions(+), 55 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 949d3ff42c..9345f8c4de 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -42,11 +42,14 @@ static uint64_t samp_intvl;
 static uint64_t timer_tsc;
 static uint64_t prev_tsc;
 
+#define LATENCY_AVG_SCALE     4
+#define LATENCY_JITTER_SCALE 16
+
 struct rte_latency_stats {
-	float min_latency; /**< Minimum latency in nano seconds */
-	float avg_latency; /**< Average latency in nano seconds */
-	float max_latency; /**< Maximum latency in nano seconds */
-	float jitter; /** Latency variation */
+	uint64_t min_latency; /**< Minimum latency */
+	uint64_t avg_latency; /**< Average latency */
+	uint64_t max_latency; /**< Maximum latency */
+	uint64_t jitter; /** Latency variation */
 	rte_spinlock_t lock; /** Latency calculation lock */
 };
 
@@ -62,32 +65,39 @@ static struct rxtx_cbs tx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
 struct latency_stats_nameoff {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
 	unsigned int offset;
+	unsigned int scale;
 };
 
 static const struct latency_stats_nameoff lat_stats_strings[] = {
-	{"min_latency_ns", offsetof(struct rte_latency_stats, min_latency)},
-	{"avg_latency_ns", offsetof(struct rte_latency_stats, avg_latency)},
-	{"max_latency_ns", offsetof(struct rte_latency_stats, max_latency)},
-	{"jitter_ns", offsetof(struct rte_latency_stats, jitter)},
+	{"min_latency_ns", offsetof(struct rte_latency_stats, min_latency), 1},
+	{"avg_latency_ns", offsetof(struct rte_latency_stats, avg_latency), LATENCY_AVG_SCALE},
+	{"max_latency_ns", offsetof(struct rte_latency_stats, max_latency), 1},
+	{"jitter_ns", offsetof(struct rte_latency_stats, jitter), LATENCY_JITTER_SCALE},
 };
 
 #define NUM_LATENCY_STATS (sizeof(lat_stats_strings) / \
 				sizeof(lat_stats_strings[0]))
 
+static void
+latencystats_collect(uint64_t values[])
+{
+	unsigned int i;
+	const uint64_t *stats;
+
+	for (i = 0; i < NUM_LATENCY_STATS; i++) {
+		stats = RTE_PTR_ADD(glob_stats, lat_stats_strings[i].offset);
+		values[i] = floor(*stats / (cycles_per_ns * lat_stats_strings[i].scale));
+	}
+}
+
 RTE_EXPORT_SYMBOL(rte_latencystats_update)
 int32_t
 rte_latencystats_update(void)
 {
-	unsigned int i;
-	float *stats_ptr = NULL;
-	uint64_t values[NUM_LATENCY_STATS] = {0};
+	uint64_t values[NUM_LATENCY_STATS];
 	int ret;
 
-	for (i = 0; i < NUM_LATENCY_STATS; i++) {
-		stats_ptr = RTE_PTR_ADD(glob_stats,
-				lat_stats_strings[i].offset);
-		values[i] = floor(*stats_ptr / cycles_per_ns);
-	}
+	latencystats_collect(values);
 
 	ret = rte_metrics_update_values(RTE_METRICS_GLOBAL,
 					latency_stats_index,
@@ -99,16 +109,16 @@ rte_latencystats_update(void)
 }
 
 static void
-rte_latencystats_fill_values(struct rte_metric_value *values)
+rte_latencystats_fill_values(struct rte_metric_value *metrics)
 {
+	uint64_t values[NUM_LATENCY_STATS];
 	unsigned int i;
-	float *stats_ptr = NULL;
+
+	latencystats_collect(values);
 
 	for (i = 0; i < NUM_LATENCY_STATS; i++) {
-		stats_ptr = RTE_PTR_ADD(glob_stats,
-				lat_stats_strings[i].offset);
-		values[i].key = i;
-		values[i].value = floor(*stats_ptr / cycles_per_ns);
+		metrics[i].key = i;
+		metrics[i].value = values[i];
 	}
 }
 
@@ -153,15 +163,9 @@ calc_latency(uint16_t pid __rte_unused,
 		void *_ __rte_unused)
 {
 	unsigned int i;
-	uint64_t now;
-	float latency;
-	static float prev_latency;
-	/*
-	 * Alpha represents degree of weighting decrease in EWMA,
-	 * a constant smoothing factor between 0 and 1. The value
-	 * is used below for measuring average latency.
-	 */
-	const float alpha = 0.2f;
+	uint64_t now, latency;
+	static uint64_t prev_latency;
+	static bool first_sample = true;
 
 	now = rte_rdtsc();
 
@@ -172,32 +176,45 @@ calc_latency(uint16_t pid __rte_unused,
 
 		latency = now - *timestamp_dynfield(pkts[i]);
 
-		/*
-		 * The jitter is calculated as statistical mean of interpacket
-		 * delay variation. The "jitter estimate" is computed by taking
-		 * the absolute values of the ipdv sequence and applying an
-		 * exponential filter with parameter 1/16 to generate the
-		 * estimate. i.e J=J+(|D(i-1,i)|-J)/16. Where J is jitter,
-		 * D(i-1,i) is difference in latency of two consecutive packets
-		 * i-1 and i.
-		 * Reference: Calculated as per RFC 5481, sec 4.1,
-		 * RFC 3393 sec 4.5, RFC 1889 sec.
-		 */
-		glob_stats->jitter +=  (fabsf(prev_latency - latency)
-					- glob_stats->jitter)/16;
-		if (glob_stats->min_latency == 0)
-			glob_stats->min_latency = latency;
-		else if (latency < glob_stats->min_latency)
+		if (unlikely(first_sample)) {
+			first_sample = false;
+
 			glob_stats->min_latency = latency;
-		else if (latency > glob_stats->max_latency)
 			glob_stats->max_latency = latency;
-		/*
-		 * The average latency is measured using exponential moving
-		 * average, i.e. using EWMA
-		 * https://en.wikipedia.org/wiki/Moving_average
-		 */
-		glob_stats->avg_latency +=
-			alpha * (latency - glob_stats->avg_latency);
+			glob_stats->avg_latency = latency * 4;
+			/* start ad if previous sample had 0 latency */
+			glob_stats->jitter = latency / LATENCY_JITTER_SCALE;
+		} else {
+			/*
+			 * The jitter is calculated as statistical mean of interpacket
+			 * delay variation. The "jitter estimate" is computed by taking
+			 * the absolute values of the ipdv sequence and applying an
+			 * exponential filter with parameter 1/16 to generate the
+			 * estimate. i.e J=J+(|D(i-1,i)|-J)/16. Where J is jitter,
+			 * D(i-1,i) is difference in latency of two consecutive packets
+			 * i-1 and i. Jitter is scaled by 16.
+			 * Reference: Calculated as per RFC 5481, sec 4.1,
+			 * RFC 3393 sec 4.5, RFC 1889 sec.
+			 */
+			long long delta = prev_latency - latency;
+			glob_stats->jitter += llabs(delta)
+				- glob_stats->jitter / LATENCY_JITTER_SCALE;
+
+			if (latency < glob_stats->min_latency)
+				glob_stats->min_latency = latency;
+			if (latency > glob_stats->max_latency)
+				glob_stats->max_latency = latency;
+			/*
+			 * The average latency is measured using exponential moving
+			 * average, i.e. using EWMA
+			 * https://en.wikipedia.org/wiki/Moving_average
+			 *
+			 * Alpha is .25, avg_latency is scaled by 4.
+			 */
+			glob_stats->avg_latency += latency
+				- glob_stats->avg_latency / LATENCY_AVG_SCALE;
+		}
+
 		prev_latency = latency;
 	}
 	rte_spinlock_unlock(&glob_stats->lock);
-- 
2.47.2

