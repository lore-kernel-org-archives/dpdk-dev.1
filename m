Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E6C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFBA542EFD;
	Tue, 10 Jun 2025 16:14:08 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id CA5FD42EF3
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:14:07 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7cad6a4fae4so893340685a.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749564847;
 x=1750169647; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMr9isvz6q1VYcjzv4VwRtHeYAyBVJBFryxaEs3/M8I=;
 b=ybRgiAdBeScFQ3C3xw7pXX9bWjK+jT2T+xci/qvfr3HslM3MNZNvqiUa0AMWF+aTOU
 hywvzYEx7p/qbU04/v2pfJTZyqzhJ/5wrG2TdGHWbhKO5J7JlUhjimcmR1DCwJulRj5m
 37Mfs9g0YeBTd09tIglygvZytyjbNo1cBd871JPaPj3UbfZEgeYXb4KucMtNM6eglyVE
 abgr+pfIuerWM9TEHYM3OHhwiGIGLQdaF7pn31aDkbMQhLR3vTUCULU9QjtAuXt1RWNV
 aGGe3VWn8JmJDG5KYAJmCRA2aE8wh2yFROk0ZPISb1eiety07TCgaQ8oEsXKSn8PkuSs
 vY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564847; x=1750169647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMr9isvz6q1VYcjzv4VwRtHeYAyBVJBFryxaEs3/M8I=;
 b=tvq5YrwFpaQrQEYmFP0OCztORekqB8etXOZ8os4Z6KWdrnZd12dgEjZr2KpRuRmsCZ
 XnYyy6SO+3CVaFuk9c4qhPItI0b7C6MAfCjY7iWnKAi0X66Hnp18c+fT7CyRZTHZIKbH
 vt5ER8QfF9/SEIUF68cuLTk3+HvJbFNWwlAt//OQfE5K18rure6RLxfz1oWrOdXZ5JrI
 Ud0SQPoD8wI3aeDMEIq6O7bUSXz3sehnUACZvKpO81iYUVfxC2dSMLXl9GsUzyXDBO1c
 yrVx2G0hxIezpeGwP5USbhKhpKSI+7ze9nCG6+bO3GX1urAtQ26xlxYWEhpQowq4vavE
 aDBQ==
X-Gm-Message-State: AOJu0YwXSmtltilaANUNIOTd1JmlYTK39DpOup20n+62Z5BoiR7xMCAr
 9ecf8Qk3LyeKLzSWuiZTLXYgitDY9GXho3JThcwI02zlAB85AEpz2SVQDbLOue6AqY+cvlffT07
 8+VzS
X-Gm-Gg: ASbGnct/0Q8pikdXZoGr4DsKSeWeEDT4FKQPCdiwD6cxDwSoKzQdo92KzG3v43E076S
 F+1WAoQnDq7TgzFDeB0J5nmXi0cI2nWXAMMcUzpxSlH9MOxMzi03tzgMiED6opD71f3GMKdEe/z
 KY22SiALPsB6x5+cAfK/BFQ+YHLkhI6admzwW5ErMBVW/yAG2HLvsoHsmd70HVl/ZZ00GSxHY+c
 CqC+7hdN043PC6LjMRlL25gUPfhAjJfjjEv1vUTjf0XuPuoXtAJPrSwzKA4VH1r+AbqJ0uqCTUq
 MV+4duv8MxKfDlPM4Zgd0x+9NQ+b5/jMe8ZijtcXus5HWFYXkmGDge5UDF0eXXpfLIkR9vi+FZ7
 YRF5xx9YKNyb0xkGU4HsE41pydN32QrzqR/M0
X-Google-Smtp-Source: AGHT+IFmyG0ZUQQeZKki3hB1YldPcBqt7dPDslFfKr+WQf6vnOaDuXQgzLc5fgZ6pac24Gjquuj08g==
X-Received: by 2002:a05:620a:2894:b0:7d0:9909:ebe9 with SMTP id
 af79cd13be357-7d22987fdf0mr2454638985a.20.1749564846958; 
 Tue, 10 Jun 2025 07:14:06 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b573asm698525985a.110.2025.06.10.07.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:14:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 6/7] latencystats: add metric for number of samples
Date: Tue, 10 Jun 2025 07:12:45 -0700
Message-ID: <20250610141355.91759-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610141355.91759-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
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
index 46f1819082..6873a44a92 100644
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
 
@@ -174,7 +181,6 @@ calc_latency(uint16_t pid __rte_unused,
 	unsigned int i;
 	uint64_t now, latency;
 	static uint64_t prev_latency;
-	static bool first_sample = true;
 
 	now = rte_rdtsc();
 
@@ -185,9 +191,7 @@ calc_latency(uint16_t pid __rte_unused,
 
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

