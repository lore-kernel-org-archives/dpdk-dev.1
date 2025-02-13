Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A04AC021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 21:22:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D1B6402F0;
	Thu, 13 Feb 2025 22:22:07 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 35A4C402C5
 for <dev@dpdk.org>; Thu, 13 Feb 2025 22:22:05 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-220ec47991aso2791995ad.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 13:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739481724;
 x=1740086524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0Fs7TdQ0CDqCtFz3XS2x5TmvWpmJDSQ8mBHwYclupg=;
 b=ZQmuIVuwhuHNRZ+uCJmU3l4uOk/h560qbHJZZsvzC3N8Xdm7FsI7yFBdDA00HY9qGh
 24oK/dg6LrwEbRgafmk/apgbFKTqtj+rfoRNjzVrsYIRBeAu5JXSGtlaGQIH0Zs8C8Vz
 NvAYJ6ryBM93t8u1cswb4AfvBtS1m20qSHTJu3RkenrgUYSgTLCL1unOcrIlHQ4ZyJwD
 N6FXu+RiaNQ0qPg/tTTp+z/x9nD9TLnpL7ZaKhIHRWMlYw/PFNB4J1fjZFq/d7mG1j1d
 t0Lms1r6GEifAzPmN4I2wm/mFroMbfIgiOGEXzdp4YJMLCt/pw5ri6Ijz41DvYw+4E0e
 8fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481724; x=1740086524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0Fs7TdQ0CDqCtFz3XS2x5TmvWpmJDSQ8mBHwYclupg=;
 b=Df3s40WAv6HVLtY3BwretpR12zsVnWOhRvc/qh90S8yhG2kd+4T9809RU9BF1lRnJG
 0PM9S/4UhMgFa7+/NTUhZ8eQ7AFol18t5Ug68lLAP8GYmO4Wc3TmTzC0xztgbf/dWD2M
 rsFczgYXaXOzGmouiDlwOrZO1y8+H3ijb4KU9xV/mgY3OJXseCzYRJiAuCjWcQ6AqVrv
 86wzrzjcd7jMdudlRVW700+BgwqQxOvTytv75z/j/DHUNelWXiGNsc87uHTYJZk+itST
 V+saQ5g0MpSfD4bNWZrOWTS/cUmNpdaXkEqUBuENno3LM4ZGZn5ADuxxhglGXEb252LD
 y1Eg==
X-Gm-Message-State: AOJu0YzoZmlR6ZSEIy0XcLaMxPK9rShtwBkXt3IBH3Ut2wYA2paksW/n
 6SdvHaRKEN3F93UKm20AokzQLfSzQQxVk3RxwYWyfx3L+Fk+bDD9/D5tg6wDVibdMZKyF1JRrO1
 v
X-Gm-Gg: ASbGnctc96uWpHoGPpAj/Cnw6JlyiZsUhGHXdcTFKeZieYfbMcYQ24NaFQYfXTrU1dv
 +VVIFeUY/lDVCpcwuoQVE5qboDZRqMAv5Ly2Ruk39jsbgDjw/4cc5oS5gCw6IVUO/STdsqVHh48
 HTv7+3g28Yi9sJJUjMKHchrLphpF2e3p/nL0BdPvEYMJb/LGEMqXglPI9BmOAMXFcsVaYS3mLuv
 DU5l5oSR0/5Vev3Ugk0eR1udjEck6TYgtFfvwzmZ7QrQxhCq6hVJjTlpSkjSiBegvNW9DuugaZd
 pXT1s1BOjM0CLi9eKMTvdp6Qdsym5ERgJyVj09Crp4OqgY/H4XMPP4NKblvPZHZtUWgG
X-Google-Smtp-Source: AGHT+IGmYXtQTpi1rLxtgMsWX0kHmybZ82fYtI6mWWrCWhvQfpz/lPygKFUpWzHRmhxXWbUbceWwaw==
X-Received: by 2002:a17:902:e84c:b0:21c:1140:136c with SMTP id
 d9443c01a7336-220bbaae91dmr121841945ad.3.1739481724185; 
 Thu, 13 Feb 2025 13:22:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5de85sm1615822a12.10.2025.02.13.13.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:22:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 2/7] latencystats: do not use floating point
Date: Thu, 13 Feb 2025 13:20:31 -0800
Message-ID: <20250213212151.1693506-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213212151.1693506-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250213212151.1693506-1-stephen@networkplumber.org>
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
---
 lib/latencystats/rte_latencystats.c | 128 ++++++++++++++++------------
 1 file changed, 73 insertions(+), 55 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 91eb0e4544..b7a4e313ad 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -4,6 +4,7 @@
 
 #include <math.h>
 
+#include <rte_common.h>
 #include <rte_string_fns.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_log.h>
@@ -41,11 +42,14 @@ static uint64_t samp_intvl;
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
 
@@ -61,31 +65,38 @@ static struct rxtx_cbs tx_cbs[RTE_MAX_ETHPORTS][RTE_MAX_QUEUES_PER_PORT];
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
 
-int32_t
-rte_latencystats_update(void)
+static void
+latencystats_collect(uint64_t values[])
 {
 	unsigned int i;
-	float *stats_ptr = NULL;
-	uint64_t values[NUM_LATENCY_STATS] = {0};
-	int ret;
+	const uint64_t *stats;
 
 	for (i = 0; i < NUM_LATENCY_STATS; i++) {
-		stats_ptr = RTE_PTR_ADD(glob_stats,
-				lat_stats_strings[i].offset);
-		values[i] = floor(*stats_ptr / cycles_per_ns);
+		stats = RTE_PTR_ADD(glob_stats, lat_stats_strings[i].offset);
+		values[i] = floor(*stats / (cycles_per_ns * lat_stats_strings[i].scale));
 	}
+}
+
+int32_t
+rte_latencystats_update(void)
+{
+	uint64_t values[NUM_LATENCY_STATS];
+	int ret;
+
+	latencystats_collect(values);
 
 	ret = rte_metrics_update_values(RTE_METRICS_GLOBAL,
 					latency_stats_index,
@@ -97,16 +108,16 @@ rte_latencystats_update(void)
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
 
@@ -151,15 +162,9 @@ calc_latency(uint16_t pid __rte_unused,
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
 
@@ -170,32 +175,45 @@ calc_latency(uint16_t pid __rte_unused,
 
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

