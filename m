Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F0C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 21:22:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FC05402E7;
	Thu, 13 Feb 2025 22:22:06 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id DCF0A40263
 for <dev@dpdk.org>; Thu, 13 Feb 2025 22:22:03 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-21f49837d36so17781685ad.3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 13:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739481723;
 x=1740086523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnVSAYAbQ2z/4cSeWqU+i2QAV8uRRSj293RCRmal4rk=;
 b=Ddu2tGm1NbqOw59lXqtE6Ns8pyQ2cyMYrKwGh3r04ud5fm5P+1BWCRUYTEq7oK77HI
 YTeRRMmVhecMfOktZuTbfobh4ZpIANuVG3Lyw+cUzTSIBFRw3Nec7vZ0G7R3kpF9XxYN
 y8O3GWMwwrMJLUNx56oKPw2LOVrdIeQRcyCboOTf5ndYW09x/8w5ct0jQX5ored/uoZT
 CUYj8GZuB/zjezWoAMJLiqASWNxO8Ta+AqAEBeD/pxJDSguXKojikVPKeuj9kDWfMuze
 AaDh+ZOxqF1wQZwNIQcnwxkEGH6MF3cTBrnARCGr7jdtRJFT3TNc/7Vnr6BLvmAMMKvq
 Yd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481723; x=1740086523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnVSAYAbQ2z/4cSeWqU+i2QAV8uRRSj293RCRmal4rk=;
 b=pqiP3QUBiCHSUaiDkvqkKw3uHJTKsNJfjFPV7kwC/Ff8u+PYvz8WKq78Kmh2u+0OYL
 7AXO1+6lnSqkw6U3RodcmKu5zwJ/POZL/h7R6NcoyynmDQZDK5gVj7P5nRyq8smHZh04
 Z/ISbRfowBzECMxkRl1QIxq8k7qt4F+H/uKh00FWwZ5BfQLZG3DsZYlRkYyNgq1EIuGO
 iIj0t5CiuGmFmsObcf7xJzrccltaSJsnlcX+nrf5ZOyMtZjRX9Nqu6hyoJqde4wqSDmz
 9CtFZPWCGAvVv3kavIFxOJX6HMtP2NtoKnSKCAW2wZVNz8lIJnKyjKnnTYgTw/9NBS5A
 Jcog==
X-Gm-Message-State: AOJu0YweUmAgDWDQ6sEvD/4eq1yEJE27twIl1hJmW0IKEg7wBuE5n7Mp
 F0ZJN5vHBLcJp6hEPWFxQG7W6TxNb3gIFHZjZ2pm5CEiXVDp1K49Vntjbqsolr6KTS3EqUup94F
 q
X-Gm-Gg: ASbGncsmTP6UBCpFjEzDeig3F2Sj1PfvV+erjRuoDf8zNGWCRXMnIpJfqhu/3ggxZ6l
 OEA6slF1zsnONhgT/ag8iUcdURyqCj6VM3frZQ+CmgEk51H+a5cxi2DE278y5Ra/DPXcekuAeW+
 kHFAYxRyGseGJlIWk/YFMKiyWMrLLR95JylqxLbgYMTtni1ojRrBP/xGV8jvm6LX1rMX2vwBCqq
 /jrLdGil3+4imyIQDxz+AYp6n25fefQABVNkbrrqvxFsGuJGtJkXacqbicr0LABmyXuWSCIrJ1e
 0re7Iwcmbl4fal1UpUGE0wfMb2W7U3NmHDQmLKzoJYYjK1Cf4ALD4z3ZjbjgMdIQIsk6
X-Google-Smtp-Source: AGHT+IF4A7Ssc1uvzczPke+Flyq8nSIdXz3Flfo1ZtB/SnDxeh0S5CwK6sTt8daVSSN5wGFlz3U0sw==
X-Received: by 2002:a05:6a21:d86:b0:1e1:b60c:5bdb with SMTP id
 adf61e73a8af0-1ee6b39bdc7mr8554506637.26.1739481723115; 
 Thu, 13 Feb 2025 13:22:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5de85sm1615822a12.10.2025.02.13.13.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:22:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 1/7] latencystats: handle fractional cycles per ns
Date: Thu, 13 Feb 2025 13:20:30 -0800
Message-ID: <20250213212151.1693506-2-stephen@networkplumber.org>
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

The TSC frequency is not always an integral number of nanoseconds.
For examples, cycles per nanoseconds on my test system is 2.8.
Fix by using floating point where needed and calculate value once.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 6a261309f9..91eb0e4544 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -18,12 +18,7 @@
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
@@ -89,8 +84,7 @@ rte_latencystats_update(void)
 	for (i = 0; i < NUM_LATENCY_STATS; i++) {
 		stats_ptr = RTE_PTR_ADD(glob_stats,
 				lat_stats_strings[i].offset);
-		values[i] = (uint64_t)floor((*stats_ptr)/
-				latencystat_cycles_per_ns());
+		values[i] = floor(*stats_ptr / cycles_per_ns);
 	}
 
 	ret = rte_metrics_update_values(RTE_METRICS_GLOBAL,
@@ -112,8 +106,7 @@ rte_latencystats_fill_values(struct rte_metric_value *values)
 		stats_ptr = RTE_PTR_ADD(glob_stats,
 				lat_stats_strings[i].offset);
 		values[i].key = i;
-		values[i].value = (uint64_t)floor((*stats_ptr)/
-						latencystat_cycles_per_ns());
+		values[i].value = floor(*stats_ptr / cycles_per_ns);
 	}
 }
 
@@ -235,9 +228,11 @@ rte_latencystats_init(uint64_t app_samp_intvl,
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

