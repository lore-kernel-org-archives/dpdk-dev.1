Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2CC021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 21:22:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C86B4064C;
	Thu, 13 Feb 2025 22:22:10 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id DD77240608
 for <dev@dpdk.org>; Thu, 13 Feb 2025 22:22:07 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso23406195ad.3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 13:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739481727;
 x=1740086527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uV4ZLpATtL7ThVS5wKYNiH3TvFWVsITy/umpAzX6evc=;
 b=CzPUlUu8Jyev4bZcVeNnElWGBI8hPkksOflYy06pZlJ1Aui89vR4Ox17+uokhtDBkZ
 xtGHyT9GtTBBvVT6QeZdaWlrUxGtcbmKlIYwZ8FAdh+pN4JLFCjE8Tqj9UcEamCUNW2X
 gVLEi8OKVEKDmTShi41NPYdHEarH9IuvIaI7ofcs+tSFZDXReG59Av2cg8UuteFI0vZG
 P+zxY08jhE/4YBYkU0+mMunIodRKuHvnBQ1VzdkqkupseafXesYiGboDAeG8Gqy9BNGd
 UnzGg+JHSTCdDAHx3/JLnv2CGpAOf9uuGs4O8H7/2BqMG6ziW33r2sKdCVpGfRAlAnWj
 JdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481727; x=1740086527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uV4ZLpATtL7ThVS5wKYNiH3TvFWVsITy/umpAzX6evc=;
 b=FRyyg6LaiAtTbC85nV4goxzmMdViF3oVZ9jDefrxvde69ybh+CLNd1MG0Fj4HmW7rp
 +H/y0vsoyBmzlQQAl4OOLsY0exUwzzRBuRi1WRJmjk93LstZSwwjaSSN59di9d3/IwSZ
 Dm8qcNoZvkMWbvXXTQGMj1xVXq+0ivsyiPDlfYYrZ3I17xVgNHE3O+i3K48bdB4ITZR+
 uPrVrpFG3Atb8LgfczPPsGlRUpZtio65XK7AqHQdKOIifW2Zw/oW0lPkehQsUhP9ejmV
 6YMuawkzzBT9bj98eyaf7kHAIPqTDk2wCCxjkf37Ax7hRy04CTpxl/osSK1AuTVt1/ar
 kl0w==
X-Gm-Message-State: AOJu0YzGmXwd7uiZ/55C6oo0XzUEW6R8mXS11kskkyo/3ly2GOre/zWN
 ruqcT8eD0Y9OecmanvXRNAYaKlWwgBgrIG4fBzno4ZumozxmmWMlbGjFrh6//9t3Cw44S6plp7k
 m
X-Gm-Gg: ASbGncuadEpiciKr0ZXZmPDusrQq01fP/jzK8wpcMGLMg13NoyXJSuXqAfJL6DbOvXn
 bxNmM8R+MjOftqccYU2eACZbBDk6YcD4yAFX6iK5OPCKeblSbw6FZoH1UKLOImvu3GqnELwZhbU
 NBZc1ECMCbTndNngsyRZ4Utc1vo44cAeIxYbF/uPqOQtiWRiamvzAd19M/J74G4Wehl5V7JviUw
 I6eKGuiq9st8PuXFatY9e3Cq3xmgptWrp61twxSUW9noQknSbopeCwQNFFUzZ4PXNQMxuLvy9pv
 OoT9IgS3aNXBcbuEzIpsuYU/98snfy9r27rQJK7bt8JDQzOSb5ORlmPaN1CcX3K70d8u
X-Google-Smtp-Source: AGHT+IHqEPvOuPchlBOi0raoa5bhTWOJvGfItWr5clN7qkrzD5jMt/jIJttptATzkV1cNfYE52FEJw==
X-Received: by 2002:a17:902:dac6:b0:220:da88:2009 with SMTP id
 d9443c01a7336-220da8820d6mr50187345ad.45.1739481727082; 
 Thu, 13 Feb 2025 13:22:07 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5de85sm1615822a12.10.2025.02.13.13.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:22:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 5/7] latencystats: enforce that unused callback function is
 NULL
Date: Thu, 13 Feb 2025 13:20:34 -0800
Message-ID: <20250213212151.1693506-6-stephen@networkplumber.org>
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

ISO C does not allow casting function pointer to void *.
Resolve by enforcing the reserved argument.
The user_cb argument for rte_latencystats_init() was not
implemented, and had to be NULL anyway.

The log type is local to this function and therefore
can be local to this file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index b990e5760f..d2289df7f2 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -30,7 +30,7 @@
 
 static double cycles_per_ns;
 
-RTE_LOG_REGISTER_DEFAULT(latencystat_logtype, INFO);
+static RTE_LOG_REGISTER_DEFAULT(latencystat_logtype, INFO);
 #define RTE_LOGTYPE_LATENCY_STATS latencystat_logtype
 #define LATENCY_STATS_LOG(level, ...) \
 	RTE_LOG_LINE(level, LATENCY_STATS, "" __VA_ARGS__)
@@ -246,6 +246,10 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 	if (rte_memzone_lookup(MZ_RTE_LATENCY_STATS))
 		return -EEXIST;
 
+	/** Reserved for possible future use */
+	if (user_cb != NULL)
+		return -ENOTSUP;
+
 	/** Allocate stats in shared memory fo multi process support */
 	mz = rte_memzone_reserve(MZ_RTE_LATENCY_STATS, sizeof(*glob_stats),
 					rte_socket_id(), flags);
@@ -298,7 +302,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 		for (qid = 0; qid < dev_info.nb_rx_queues; qid++) {
 			cbs = &rx_cbs[pid][qid];
 			cbs->cb = rte_eth_add_first_rx_callback(pid, qid,
-					add_time_stamps, user_cb);
+					add_time_stamps, NULL);
 			if (!cbs->cb)
 				LATENCY_STATS_LOG(NOTICE,
 					"Failed to register Rx callback for pid=%u, qid=%u",
@@ -307,7 +311,7 @@ rte_latencystats_init(uint64_t app_samp_intvl,
 		for (qid = 0; qid < dev_info.nb_tx_queues; qid++) {
 			cbs = &tx_cbs[pid][qid];
 			cbs->cb =  rte_eth_add_tx_callback(pid, qid,
-					calc_latency, user_cb);
+					calc_latency, NULL);
 			if (!cbs->cb)
 				LATENCY_STATS_LOG(NOTICE,
 					"Failed to register Tx callback for pid=%u, qid=%u",
-- 
2.47.2

