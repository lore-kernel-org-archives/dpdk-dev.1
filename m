Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A616C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:14:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72FB642EE0;
	Tue, 10 Jun 2025 16:14:02 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 03F0E4026D
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:14:01 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4a4323fe8caso38632001cf.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749564840;
 x=1750169640; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3vxT434Waw+WMbBv/2GeWAw7DGha2x3sAI8Tb1kcdA=;
 b=BnXtr1DfOKlLghtu8DnlSohLN1lgkX9P7TV9ODgH0YceJVVRZOaEKz+dZrbSpKISXq
 TlcIixidYg1WY+wyU4/QZ+JLQMHX6LhnKluHJ/MLiXeMP56go82D6dyBsR9EX56jl0X1
 iZ2rQeyxuVg53O1F2fitf/qchkF4vQq+RUzUUzrYkI09T3YNmcldaWOdNf6OLOsQDMcl
 wGBuf7wNsFOaM/1vwRDGhZPquqy6QuPpl2H+6Cve45mgeX0ffyMz/PA79f9Ng9YNNPfJ
 eUOA3g911sfI98JE7t4ljgGblLqJcbju5IFG4gb1spIWOSUANJXSgo6ZzMzqEAtjUWbD
 poIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564840; x=1750169640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3vxT434Waw+WMbBv/2GeWAw7DGha2x3sAI8Tb1kcdA=;
 b=C0ejce8GkTjcm8GD/IRBpmAUgXpxVtcbmDX1s5ixdCsjzErhSCvgl1j+edAQ+FD7mO
 wiZJq5NuiNbCoQvXsBUYjdd1yAk1xno/UvfcTpQDf0dxugxadZAGLRDa5LNNKYlwaBOp
 0XK6nRL+rHnvQPc9YutRTBhpAXFERt/4TbkUlW4H7PHAYLQKyJ89F4bg+46W1YTkurje
 ieSvW+pZ29xro5WJsofJ1Rzu1nLiU/g/GuMTzgS3/+mKWmq3Zd2MmXxmJomB0Kha9itr
 AGN5+ueYovcLl76yGiNuf2HL7xh83S8JmVAPPB4CXpfZNxk5uvdwlAqYauNPE3OYDy8s
 3zyw==
X-Gm-Message-State: AOJu0YxwZuTZg6Rap2QS4lVHNS+RMV8hEbk2Qq/J57l4PwQ+E7UkSVOG
 Ii+8ggwTiFYzQ2volIfHcodvqnaMHQ2LQRYU9KzFGFvhcbOu5R65Pfc/2EWRfOInqx2YRaHXvkl
 NmpD7
X-Gm-Gg: ASbGncvfTZqWECyprUfKBZm7nYoEQcMG7btReTscFRJFtADWkGIAjkMRAzLl0fxpJ+k
 kS28S4OilGgpLU9qBqIIc0wMqB4S1/Jb7owqrwTRsTvPRB7GI3PLrA9ALUX8Qg3DMBhPc5hi/Kb
 b2ycymM30to+APdWssP3xICQMhgaq/LceCg/cQroy9jez9wip7P5mnIpG2d4VJVX0cSXgmHZT65
 aZ1xjMTD7NUNQVc6SKGYcwYV5cUQhD+2f5YVssG13DgyKjty+SzRKDIp+IUN0Pz7zCrfPfcN95I
 d4wDi4Ez/yZofXhBrBC3dIm4U61I5G3gPFJYoRiqnthVWkMeljhEzMMG2aXe4hM0s2V0xxLGiAh
 jKc3WAeWwW0e4fMVLFxqO0xtnVoqgenfvaL9+
X-Google-Smtp-Source: AGHT+IEmmhtcam+CZ4AZO7UGJ2jPrvfS1uMlx03xD77+HdhzU1gASnAbS08FtEWZJ/kpmUy5G0tvNg==
X-Received: by 2002:a05:620a:2448:b0:7c5:9c12:fc8 with SMTP id
 af79cd13be357-7d2299b1806mr2341986285a.38.1749564840285; 
 Tue, 10 Jun 2025 07:14:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b573asm698525985a.110.2025.06.10.07.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:13:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 1/7] latencystats: handle fractional cycles per ns
Date: Tue, 10 Jun 2025 07:12:40 -0700
Message-ID: <20250610141355.91759-2-stephen@networkplumber.org>
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

The TSC frequency is not always an integral number of nanoseconds.
For examples, cycles per nanoseconds on my test system is 2.8.
Fix by using floating point where needed and calculate value once.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 19a6f580cd..949d3ff42c 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -19,12 +19,7 @@
 /** Nano seconds per second */
 #define NS_PER_SEC 1E9
 
-/** Clock cycles per nano second */
-static uint64_t
-latencystat_cycles_per_ns(void)
-{
-	return rte_get_timer_hz() / NS_PER_SEC;
-}
+static double cycles_per_ns;
 
 RTE_LOG_REGISTER_DEFAULT(latencystat_logtype, INFO);
 #define RTE_LOGTYPE_LATENCY_STATS latencystat_logtype
@@ -91,8 +86,7 @@ rte_latencystats_update(void)
 	for (i = 0; i < NUM_LATENCY_STATS; i++) {
 		stats_ptr = RTE_PTR_ADD(glob_stats,
 				lat_stats_strings[i].offset);
-		values[i] = (uint64_t)floor((*stats_ptr)/
-				latencystat_cycles_per_ns());
+		values[i] = floor(*stats_ptr / cycles_per_ns);
 	}
 
 	ret = rte_metrics_update_values(RTE_METRICS_GLOBAL,
@@ -114,8 +108,7 @@ rte_latencystats_fill_values(struct rte_metric_value *values)
 		stats_ptr = RTE_PTR_ADD(glob_stats,
 				lat_stats_strings[i].offset);
 		values[i].key = i;
-		values[i].value = (uint64_t)floor((*stats_ptr)/
-						latencystat_cycles_per_ns());
+		values[i].value = floor(*stats_ptr / cycles_per_ns);
 	}
 }
 
@@ -238,9 +231,11 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 		return -ENOMEM;
 	}
 
+	cycles_per_ns = (double)rte_get_tsc_hz() / NS_PER_SEC;
+
 	glob_stats = mz->addr;
 	rte_spinlock_init(&glob_stats->lock);
-	samp_intvl = app_samp_intvl * latencystat_cycles_per_ns();
+	samp_intvl = (uint64_t)(app_samp_intvl * cycles_per_ns);
 
 	/** Register latency stats with stats library */
 	for (i = 0; i < NUM_LATENCY_STATS; i++)
-- 
2.47.2

