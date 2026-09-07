Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C8EC79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9412740BA6;
	Mon,  7 Sep 2026 19:05:53 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 2D6F940BA6
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:53 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so3216773a91.0
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800752;
 x=1789405552; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J9wfKSkp6i1vFIN7r+07XJjOeNC2CEs12LlKErlSrco=;
 b=rnvxFcKQjD2clKsGZQqkIz3WhtFEuXtRaOwdo/S51iSmxmIoxJUAgiY6LxqUx6y6Hh
 ToFdPWWEZX+MvH2wQNmb8gIMxNt6tUIS27D1QzK3jXatiGTtGsfPvvBZ48gRT5Ft8Q/U
 hPj6/OyrVLjLRte5D052bd0MbtRhNoC0XXHnOxiFa76pJyc94ZJtTWQwMO/xVh8cx1X3
 USMpMN+K2criwQPwiz2gPJfYjETin8qSL+ASRxObGF2HSv7JpgA7kQRVkLgF1F/xD4ad
 3CVnG/O5PuUY9fw/S5X9UFQ+3nT4lPSd+QjbhbSeaL4xTjTjuoGSIXb38j81C0nFOlNv
 0B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800752; x=1789405552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J9wfKSkp6i1vFIN7r+07XJjOeNC2CEs12LlKErlSrco=;
 b=dPnUvbFGkHVQWrIrM1Znd7dZ2HMKROwUVVzJ5VYvo0KUp/Ccfdel0xdg2ooPW+Y/Kw
 AUQQjWzARPb2nIN+WZCPbKuefyZww7cPcG/HHOleFxdQLfOT+QgrSZieYFRqM9vw/lsm
 dEhdLI3tQfRXVQMTKzrezwDyPMeWjiwCsozwZzaFuDi8PkktD2CAomSf6O2in7g0Nxx3
 YWJrZ+mOOStIsv+7ZETX4mYcrd065XT1ZjabpQPSQLrnZwI7dlHukqAkZNAGaNfSlGeG
 ljO4MCADjE1snkkFfglXu0yS5Dg8F6/v80sKfcxuI/UpSIpgzgAPxhXTEkanG8yTeP2m
 zQzA==
X-Gm-Message-State: AFuF++lFFBR2AF5AZYCL6KyJLGdOgSr7bq9PYCL0oyYZ/u3PX7Rn1xsU
 1bpTrTdz6wBAK+6eyn+Nx9NBeLsaQUCYehit/AHYjD3c4S9RkPx5+GUDmAZqSoND+g0Euaa3Eie
 nbZE0
X-Gm-Gg: AYBFou3zgbJ6eoryX4MlaIiyeAMozEtkb/24LtIie4hTjeb7zOM/EFbBokbSEjpXTET
 NvePjngc+PtUbmwHVUCZi9Q5ENlOmWXtaJosxP0vqfRGIfOA6TH2CkBSqmxAZ4R0945AumtxH2A
 kMW678Hvzi/2bnjhYtDhp2mjqgpvt6EkCxRSDTUgWm7kiI7wZ8AS+9jnqfvPL1aT4TwwnqD0gdH
 WP59czSkEaLtKsWaXQfLwmKNNa56phk+SvX+ssOBKihuEH/9JFERNG66ZNxbvmzTbUsMtfEJ6vd
 L8PioWDKfh3KMZ4sd/+cm9Ums3Sks7IGLqqQiDKYPCNZMcpK+Qs+T4KDAkHLeGAfqhssmL5R/cQ
 90/s6sFkqWBir2vq9hwOz3IrsLftdbLP4YwgkX/a7xktf+UsfIjgjR7jtTrnlrL+sP2J+rJ01jq
 3pt3LYsA6k+GS1NDkF7bj8y311Xvsc2CHajyevRfpZy/yRtX+meZSDYL6DhAsxzbdCyWA/1a2cR
 cRgssYuhIehp8tcCvyYdziv5+NCzBH7d1FR4A==
X-Received: by 2002:a17:90b:2884:b0:398:e86b:ce14 with SMTP id
 98e67ed59e1d1-39b262ab44emr34736604a91.20.1788800752147; 
 Mon, 07 Sep 2026 10:05:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 13/13] examples/eventdev_pipeline: make signal handler safe
Date: Mon,  7 Sep 2026 10:03:31 -0700
Message-ID: <20260907170454.351647-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907170454.351647-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260907170454.351647-1-stephen@networkplumber.org>
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

This example was calling functions like rte_exit and printing from a
signal handler which is not async signal safe.

Revise to spit the two signal actions here:
- The handler for SIGINT and SIGTERM set a flag which causes main
  loop to exit and proceed with normal clean shutdown. If a second
  SIGINT is received the process will get default signal handler
  (i.e process exit).

- The dump flag handler is changed form SIGTSTP (^Z) to use SIGUSR1
  since that is more standard practice in Linux.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/eventdev_pipeline/main.c            | 39 ++++++++++++--------
 examples/eventdev_pipeline/pipeline_common.h | 13 ++++---
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/examples/eventdev_pipeline/main.c b/examples/eventdev_pipeline/main.c
index 65e0cd437c..00f409a07b 100644
--- a/examples/eventdev_pipeline/main.c
+++ b/examples/eventdev_pipeline/main.c
@@ -312,20 +312,16 @@ do_capability_setup(uint8_t eventdev_id)
 }
 
 static void
-signal_handler(int signum)
+signal_quit(int signum __rte_unused)
 {
-	static uint8_t once;
-
-	if (fdata->done)
-		rte_exit(1, "Exiting on signal %d\n", signum);
-	if ((signum == SIGINT || signum == SIGTERM) && !once) {
-		if (cdata.dump_dev)
-			rte_event_dev_dump(0, stdout);
-		once = 1;
+	if (fdata != NULL)
 		fdata->done = 1;
-	}
-	if (signum == SIGTSTP)
-		rte_event_dev_dump(0, stdout);
+}
+
+static void
+signal_dump(int signum __rte_unused)
+{
+	cdata.dump_dev_signal = 1;
 }
 
 static inline uint64_t
@@ -345,9 +341,19 @@ main(int argc, char **argv)
 	int lcore_id;
 	int err;
 
-	signal(SIGINT, signal_handler);
-	signal(SIGTERM, signal_handler);
-	signal(SIGTSTP, signal_handler);
+	/* second SIGINT/SIGTERM takes the default action */
+	struct sigaction sa = {
+		.sa_handler = signal_quit,
+		.sa_flags = SA_RESETHAND,
+	};
+	sigemptyset(&sa.sa_mask);
+	sigaction(SIGINT, &sa, NULL);
+	sigaction(SIGTERM, &sa, NULL);
+
+	/* allow repeated dump signals */
+	sa.sa_handler = signal_dump;
+	sa.sa_flags = 0;
+	sigaction(SIGUSR1, &sa, NULL);
 
 	err = rte_eal_init(argc, argv);
 	if (err < 0)
@@ -452,6 +458,9 @@ main(int argc, char **argv)
 
 	rte_eal_mp_wait_lcore();
 
+	if (cdata.dump_dev)
+		rte_event_dev_dump(0, stdout);
+
 	if (!cdata.quiet && (port_stat(dev_id, worker_data[0].port_id) !=
 			(uint64_t)-ENOTSUP)) {
 		printf("\nPort Workload distribution:\n");
diff --git a/examples/eventdev_pipeline/pipeline_common.h b/examples/eventdev_pipeline/pipeline_common.h
index 7b8eb50240..274c6942ca 100644
--- a/examples/eventdev_pipeline/pipeline_common.h
+++ b/examples/eventdev_pipeline/pipeline_common.h
@@ -3,6 +3,7 @@
  * Copyright 2017 Cavium, Inc.
  */
 
+#include <signal.h>
 #include <stdbool.h>
 
 #include <rte_eal.h>
@@ -43,7 +44,7 @@ struct setup_data {
 };
 
 struct __rte_cache_aligned fastpath_data {
-	volatile int done;
+	volatile sig_atomic_t done;
 	uint32_t evdev_service_id;
 	uint32_t rxadptr_service_id;
 	uint32_t txadptr_service_id;
@@ -68,7 +69,7 @@ struct config_data {
 	int enable_queue_priorities;
 	int quiet;
 	int dump_dev;
-	int dump_dev_signal;
+	volatile sig_atomic_t dump_dev_signal;
 	int all_type_queues;
 	unsigned int num_stages;
 	unsigned int worker_cq_depth;
@@ -127,16 +128,16 @@ schedule_devices(unsigned int lcore_id)
 	if (fdata->sched_core[lcore_id]) {
 		rte_service_run_iter_on_app_lcore(fdata->evdev_service_id,
 				!fdata->sched_single);
-		if (cdata.dump_dev_signal) {
-			rte_event_dev_dump(0, stdout);
-			cdata.dump_dev_signal = 0;
-		}
 	}
 
 	if (fdata->tx_core[lcore_id]) {
 		rte_service_run_iter_on_app_lcore(fdata->txadptr_service_id,
 				!fdata->tx_single);
 	}
+	if (cdata.dump_dev_signal) {
+		rte_event_dev_dump(0, stdout);
+		cdata.dump_dev_signal = 0;
+	}
 }
 
 static void
-- 
2.53.0

