Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF0CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 19:49:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA998402EB;
	Sat, 17 Oct 2026 21:49:02 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id AE3F940276
 for <dev@dpdk.org>; Sat, 17 Oct 2026 21:49:00 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3ac677668a9so763118a91.2
 for <dev@dpdk.org>; Sat, 17 Oct 2026 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792266540;
 x=1792871340; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rcemjn3jO4vjDhPt+l30a1lZ4ek/fFYvKric6EBmp5Q=;
 b=ktdTTxgFbbIM1RVa5RJnvvKI21JYB94cPyt8YJH09dYfah0uwpjeM9k8ChIoKH2T6Z
 yF3m4IeTz1ExZwK2e25BBHLXKkL6oOUqhbxT7K6zGvxZIhx4EAofT6dUH1rF0aNDEf/h
 DtN7CeLjWic+rYI4pF9907Dh0fgFUKk0YIkvdtKL/Cn8dKIZhOa+G9ZY9eko0SL0dVEx
 bP/RtYpYdfsJ7bUz3QvuI5nHBLSCsrq+OuKyz5wywddt1qD60zr3HN/cN0TKPAPNhYTF
 OG+OeYeNfxOUOkSG4p5AEkx8CDjvN+SKEKk2zPYw8spPJxckDYVSx2kzh6Xf0T3wzhpI
 m+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792266540; x=1792871340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rcemjn3jO4vjDhPt+l30a1lZ4ek/fFYvKric6EBmp5Q=;
 b=v0h9ZHlH9FtQylYqvB41GewZAuAk4/nO88YxPuWkSSYH3xGuYrENsSTm6sDBPlVRu/
 ql171jBFwMkpXT8WpYUrQ8NYtggeboYvOG3IgTQ1HdyDz6d6uxfCigem0UqxMLLY/Md8
 fTrx/CpXbNZVHQ3jwKGHy5cvVPUzij8LOLYTAXcc/GthkM8G7d2IR7pte85X4yjlzxC5
 hGyH/fZBS0MM8y3rX7udNEzSQz6uXR2h5OuRxOlnS8Ntun04GieEYy5SHzOE6uO7pDgk
 zrw27LMqd0sh+WuAdD3CvWEcS+ooVPFxLnyIfKpe35gBCcSFg1UTZ5wHS5TmYjGVTAoQ
 PrIg==
X-Gm-Message-State: AFq9FYI8o+wbfb7G9y9Esu9QO3bFdi8kHPjYmlDrsX18VULsio20wOjN
 XjAsX2JAn8vBRl5bRN668xvLQJCN7UYWRwdvo8IBH58fBuoM/0cyQB/y9Vq+/CTmA8zi+Cz+BQ2
 dz//S
X-Gm-Gg: AYBFou2IitIceQIvFqltSihjpQm2Adri2axYl3ff6Ap/Vsg9nrevpzrCRIJYQbJMwmA
 cC7c/rsygkyGTX9LD7GAczAKO6lU+Q+QdIjdq1opDfT9omDD73q/Myf9Z/E1ogiOZR6cevPjKcV
 TPbG65XA7dbs0/VgTTkU23qYZWr4tvUNgk3mK9wsbpIdG5HR1HQY+dOe9WjD2IjX4WaMp2UHFxj
 kFhlaNlE8NO/pK4Csv5b5JqzH5b0dFxabryginGOmUcDp9nmuPUCwJb81nfmYREFdltIsH8J7WE
 kmlJsOddXLMbdhUSttkH5TFp9Oo0bJ7kTgM/eZA0hiQ9wVYfYiqFLy2qdKcXTqyfC2C3UjoDA3D
 Abjt9RO7MzuDqWbXRfr6eIPtxVnmiZi5kGfSfNCjWww4gPb5Ykf/5guJKLG8lnzKqTX/PXcGvTS
 drqD+qlDUMGEtYr/gnZvphuhmdo6GGjtrVofLmHwJB5Ngu2E+Q4dy5R8dJVg1xGnLuJjvIXRtWg
 OQePCLZi9QJ9tpShADJO1P5FsvUMgQi2mbMxQ==
X-Received: by 2002:a17:90b:2ec3:b0:3ac:80dc:f41d with SMTP id
 98e67ed59e1d1-3acef134d71mr3023761a91.32.1792266539775; 
 Sat, 17 Oct 2026 12:48:59 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc980a548sm4533655a91.0.2026.10.17.12.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:48:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC 2/2] app/testpmd: add option to limit run time
Date: Sat, 17 Oct 2026 12:48:55 -0700
Message-ID: <20261017194856.2950241-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017194856.2950241-1-stephen@networkplumber.org>
References: <20261017194856.2950241-1-stephen@networkplumber.org>
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

When benchmarking it is useful to be able to run testpmd for
a fixed amount of time.  In non-interactive mode testpmd runs
until a signal arrives or something is read from stdin.

Add --run-time=N to stop forwarding and exit after N seconds,
printing the final statistics as on a normal exit.
The stats period loop is folded into the same wait.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/parameters.c             | 18 ++++++++
 app/test-pmd/testpmd.c                | 61 ++++++++++++++++++---------
 app/test-pmd/testpmd.h                |  1 +
 doc/guides/testpmd_app_ug/run_app.rst |  6 +++
 4 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index f031dd7445..c852075dfb 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -61,6 +61,8 @@ enum {
 	TESTPMD_OPT_TX_FIRST_NUM,
 #define TESTPMD_OPT_STATS_PERIOD "stats-period"
 	TESTPMD_OPT_STATS_PERIOD_NUM,
+#define TESTPMD_OPT_RUN_TIME "run-time"
+	TESTPMD_OPT_RUN_TIME_NUM,
 #define TESTPMD_OPT_DISPLAY_XSTATS "display-xstats"
 	TESTPMD_OPT_DISPLAY_XSTATS_NUM,
 #define TESTPMD_OPT_NB_CORES "nb-cores"
@@ -282,6 +284,7 @@ static const struct option long_options[] = {
 	REQUIRED_ARG(TESTPMD_OPT_ETH_PEER),
 	NO_ARG(TESTPMD_OPT_TX_FIRST),
 	REQUIRED_ARG(TESTPMD_OPT_STATS_PERIOD),
+	REQUIRED_ARG(TESTPMD_OPT_RUN_TIME),
 	REQUIRED_ARG(TESTPMD_OPT_DISPLAY_XSTATS),
 	REQUIRED_ARG(TESTPMD_OPT_NB_CORES),
 	REQUIRED_ARG(TESTPMD_OPT_NB_PORTS),
@@ -408,6 +411,8 @@ usage(char* progname)
 	       "(only if interactive is disabled).\n");
 	printf("  --stats-period=PERIOD: statistics will be shown "
 	       "every PERIOD seconds (only if interactive is disabled).\n");
+	printf("  --run-time=N: stop forwarding and exit after N seconds "
+	       "(only if interactive is disabled).\n");
 	printf("  --display-xstats xstat_name1[,...]: comma-separated list of "
 	       "extended statistics to show. Used with --stats-period "
 	       "specified or interactive commands that show Rx/Tx statistics "
@@ -997,6 +1002,19 @@ launch_args_parse(int argc, char** argv)
 				"packets first\n");
 			tx_first = 1;
 			break;
+		case TESTPMD_OPT_RUN_TIME_NUM: {
+			char *end = NULL;
+			unsigned long secs;
+
+			errno = 0;
+			secs = strtoul(optarg, &end, 10);
+			if (optarg[0] == '\0' || *end != '\0' || errno != 0 ||
+					secs == 0 || secs > INT32_MAX)
+				rte_exit(EXIT_FAILURE, "Invalid run-time value\n");
+
+			run_time = secs;
+			break;
+		}
 		case TESTPMD_OPT_STATS_PERIOD_NUM: {
 			char *end = NULL;
 
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index e1766eec72..aaab1a83a6 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -242,6 +242,7 @@ uint16_t mbuf_data_size[MAX_SEGS_BUFFER_SPLIT] = {
 uint32_t param_total_num_mbufs = 0;  /**< number of mbufs in all pools - if
                                       * specified on command-line. */
 uint16_t stats_period; /**< Period to show statistics (disabled by default) */
+uint32_t run_time; /**< Seconds to forward before exit (0 = no limit) */
 
 /** Extended statistics to show. */
 struct rte_eth_xstat_name *xstats_display;
@@ -4556,6 +4557,41 @@ disable_primary_monitor(void)
 }
 #endif
 
+/*
+ * Non-interactive wait: print stats every stats_period seconds
+ * and stop after run_time seconds, or on signal.
+ */
+static void
+forward_wait(void)
+{
+	uint64_t hz = rte_get_timer_hz();
+	uint64_t now = rte_get_timer_cycles();
+	uint64_t end = now + (uint64_t)run_time * hz;
+	uint64_t next_stats = now;
+
+	while (f_quit == 0) {
+		uint64_t wake;
+
+		now = rte_get_timer_cycles();
+		if (run_time != 0 && now >= end)
+			break;
+
+		if (stats_period != 0 && now >= next_stats) {
+			print_stats();
+			next_stats = now + (uint64_t)stats_period * hz;
+		}
+
+		/* wake at least once a second to check for signal */
+		wake = now + hz;
+		if (stats_period != 0 && next_stats < wake)
+			wake = next_stats;
+		if (run_time != 0 && end < wake)
+			wake = end;
+
+		rte_delay_us_sleep((wake - now) * US_PER_S / hz);
+	}
+}
+
 int
 main(int argc, char** argv)
 {
@@ -4650,6 +4686,9 @@ main(int argc, char** argv)
 		rte_exit(EXIT_FAILURE, "--tx-first cannot be used on "
 				"interactive mode.\n");
 
+	if (run_time && interactive)
+		rte_exit(EXIT_FAILURE, "--run-time cannot be used on interactive mode.\n");
+
 	if (tx_first && lsc_interrupt) {
 		fprintf(stderr,
 			"Warning: lsc_interrupt needs to be off when using tx_first. Disabling.\n");
@@ -4755,26 +4794,8 @@ main(int argc, char** argv)
 	} else {
 		printf("No commandline core given, start packet forwarding\n");
 		start_packet_forwarding(tx_first);
-		if (stats_period != 0) {
-			uint64_t prev_time = 0, cur_time, diff_time = 0;
-			uint64_t timer_period;
-
-			/* Convert to number of cycles */
-			timer_period = stats_period * rte_get_timer_hz();
-
-			while (f_quit == 0) {
-				cur_time = rte_get_timer_cycles();
-				diff_time += cur_time - prev_time;
-
-				if (diff_time >= timer_period) {
-					print_stats();
-					/* Reset the timer */
-					diff_time = 0;
-				}
-				/* Sleep to avoid unnecessary checks */
-				prev_time = cur_time;
-				rte_delay_us_sleep(US_PER_S);
-			}
+		if (stats_period != 0 || run_time != 0) {
+			forward_wait();
 		} else {
 			char c;
 
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 6d4c3e8f84..3c9c78a59c 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -625,6 +625,7 @@ extern uint16_t mbuf_data_size[MAX_SEGS_BUFFER_SPLIT];
 extern uint32_t param_total_num_mbufs;
 
 extern uint16_t stats_period;
+extern uint32_t run_time;
 
 extern struct rte_eth_xstat_name *xstats_display;
 extern unsigned int xstats_display_num;
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index e678058b97..6c6da5319c 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -64,6 +64,12 @@ The command line options are:
     Display statistics every PERIOD seconds, if interactive mode is disabled.
     The default value is 0, which means that the statistics will not be displayed.
 
+*   ``--run-time N``
+
+    Stop forwarding and exit after N seconds, if interactive mode is disabled.
+    Final statistics are displayed as on a normal exit.
+    The default value is 0, which means run until interrupted.
+
 *   ``--display-xstats xstat_name1[,...]``
 
     Display comma-separated list of extended statistics every PERIOD seconds
-- 
2.53.0

