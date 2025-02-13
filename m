Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB7C021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 21:22:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEFA24065F;
	Thu, 13 Feb 2025 22:22:12 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 1693440611
 for <dev@dpdk.org>; Thu, 13 Feb 2025 22:22:09 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-220e6028214so14090145ad.0
 for <dev@dpdk.org>; Thu, 13 Feb 2025 13:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739481728;
 x=1740086528; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JE7QkW64Wddm3KJJIswSSi7oP0fmo+bfzNvhU5m6WKM=;
 b=w5+O1Qi4HqAFwTIj6tm+yG1jAu6eMyEEth3AoBoZ860p6oyF3arMDBRmx2Bo1rBwTj
 xaqlqhb8MxEmAfzxIzwUCeiVJHUJemb7nj3bKk5pJOLcPp++p5ILuzdIifZFEei0vIV3
 eBSXcz8A6nCnykxhINMR/hgC/sozEG2Cs0HjIFyf18bCSLUmuDqPY15zHUqasKm7eyh7
 Rw2D1vaSIwXjcG/fTYNEG/63IXMcK4/2Hp/uok208UiQqI2bni2ICH829g36NfRVmU0X
 Y958t6D4fKF7Z9TTB7mw4cNCrhAA+yK1nu4jS4i77YpDkiNJ4NgMRHA1xINJGFy96giJ
 A23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481728; x=1740086528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JE7QkW64Wddm3KJJIswSSi7oP0fmo+bfzNvhU5m6WKM=;
 b=bToOF6vpXFTN4+0BIn9v6NMOtAiGaKn92AjnY3+eQX/rwlcKZBA2wUKwnpJEb2m65T
 PZkIGSkRBDT77gqDrwKMUHA5+7N3aE3Kf+f0p3RvE2084rHRtE5S9RejzeQ8dCFfXe2M
 Um7ww0avyJHPl+jkVADsr9xGWGTg3Zv+syz96QRP5nDJAUjafM76XHOIPZGC1HhdEjfb
 73pddybNDEQUDtL7MQr3W6FVtk5cpZ0Vdrv1UP4YoRtLzAETOaQVQbqzTkqfiaIZ6jlM
 rIzQVEA+p5yKJZLEtCTiA08drK0fWmSyhsgQ7YpYt/LlHGL1KGQqvxGYa1hfsFxR9L/Z
 S4Tw==
X-Gm-Message-State: AOJu0Yzh8bpZCLK+xyvdERkzdgP7EA04pOJp8akWfkzXaAO5mAwkax7/
 oi36VTSuPuHGEhT/oVMpHFyJNQpZxhuNuS+z2tsGhoKnLOhwjdg/vlWMy7Nk+YIwm2lmt/fkeMM
 A
X-Gm-Gg: ASbGncur7xNxkZJ2PUKp+fzQh3+4TY1p5dq4SKO5wVqTOLNxs4bvG6DUVlNabuWo2Fh
 t7hqJNDsUvbEc1WjD+avPrxqlIYtNZoydAbqzGSMCdo0uzsA/g8vZFnySWH1KEp8wtQD9rOqqD/
 GH2T+qbqUrUk4Ur4SyNKoAUAlu2QglPGwruKdzPsDssDSPH+5rcLNQg3ABT3JtkN88lKk7cZw3U
 BMSZhxEBl2x3RbwMkSdck1udHBiU9fYkUinAASHs1ImjyO34F1xflCP/FhXA5j5iMLaiNuEBj+J
 9hn8Rup3ErpdsWac8xcmDfc7vKGkScuETUb2WHPJKMpbCFc1jqz7iBfQiDNRM/rdnKiE
X-Google-Smtp-Source: AGHT+IEy3bHU/q902o1E+uo1P2Yz86Ioru93zSJgsBoDqFxrui6b+dj/n1gmng90MWZH8EEaTWQ44g==
X-Received: by 2002:a17:903:1cc:b0:21f:658b:8ee8 with SMTP id
 d9443c01a7336-220bdedc600mr135535295ad.2.1739481728359; 
 Thu, 13 Feb 2025 13:22:08 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5de85sm1615822a12.10.2025.02.13.13.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:22:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 6/7] latencystats: add metric for number of samples
Date: Thu, 13 Feb 2025 13:20:35 -0800
Message-ID: <20250213212151.1693506-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213212151.1693506-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250213212151.1693506-1-stephen@networkplumber.org>
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

Keeping track of the number of samples is useful when doing
debug and testing to make sure that samples are actually happening.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index d2289df7f2..dd3504996e 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -59,6 +59,7 @@ struct rte_latency_stats {
 	uint64_t avg_latency; /**< Average latency */
 	uint64_t max_latency; /**< Maximum latency */
 	uint64_t jitter; /** Latency variation */
+	uint64_t samples;    /** Number of latency samples */
 	rte_spinlock_t lock; /** Latency calculation lock */
 };
 
@@ -82,20 +83,26 @@ static const struct latency_stats_nameoff lat_stats_strings[] = {
 	{"avg_latency_ns", offsetof(struct rte_latency_stats, avg_latency), LATENCY_AVG_SCALE},
 	{"max_latency_ns", offsetof(struct rte_latency_stats, max_latency), 1},
 	{"jitter_ns", offsetof(struct rte_latency_stats, jitter), LATENCY_JITTER_SCALE},
+	{"samples", offsetof(struct rte_latency_stats, samples), 0},
 };
 
-#define NUM_LATENCY_STATS (sizeof(lat_stats_strings) / \
-				sizeof(lat_stats_strings[0]))
+#define NUM_LATENCY_STATS RTE_DIM(lat_stats_strings)
 
 static void
 latencystats_collect(uint64_t values[])
 {
-	unsigned int i;
+	unsigned int i, scale;
 	const uint64_t *stats;
 
 	for (i = 0; i < NUM_LATENCY_STATS; i++) {
 		stats = RTE_PTR_ADD(glob_stats, lat_stats_strings[i].offset);
-		values[i] = floor(*stats / (cycles_per_ns * lat_stats_strings[i].scale));
+		scale = lat_stats_strings[i].scale;
+
+		/* used to mark samples which are not a time interval */
+		if (scale == 0)
+			values[i] = *stats;
+		else
+			values[i] = floor(*stats / (cycles_per_ns * scale));
 	}
 }
 
@@ -173,7 +180,6 @@ calc_latency(uint16_t pid __rte_unused,
 	unsigned int i;
 	uint64_t now, latency;
 	static uint64_t prev_latency;
-	static bool first_sample = true;
 
 	now = rte_rdtsc();
 
@@ -184,9 +190,7 @@ calc_latency(uint16_t pid __rte_unused,
 
 		latency = now - *timestamp_dynfield(pkts[i]);
 
-		if (unlikely(first_sample)) {
-			first_sample = false;
-
+		if (glob_stats->samples++ == 0) {
 			glob_stats->min_latency = latency;
 			glob_stats->max_latency = latency;
 			glob_stats->avg_latency = latency * 4;
-- 
2.47.2

