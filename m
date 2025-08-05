Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353E9C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 20:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215D940E27;
	Tue,  5 Aug 2025 22:00:05 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4797A4042C
 for <dev@dpdk.org>; Tue,  5 Aug 2025 22:00:04 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7C0EA2112215; Tue,  5 Aug 2025 13:00:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C0EA2112215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754424003;
 bh=3xOFnbFVIFq2RGwhsoFXTKc8u6LWzeQMqEMt1Naz93A=;
 h=From:To:Cc:Subject:Date:From;
 b=kB3pYV3y2YCWveJSfwEecydq6NfD2+YrFIkT/JkTLCJqLnhBxR8X1uWlegaxYvD0+
 26UWlQYGSwpgMxfU0F1DX0j2El1wmqLwSxS9XseZDlVqtjqYmTo9uHO4dLtGZb6h1H
 PHB6rjQYoUyvU45XZI7pk/3rvaBW2FLX4zDlnPI0=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Wisam Jaddo <wisamm@nvidia.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] test-flow-perf: Enable to build on Windows
Date: Tue,  5 Aug 2025 12:59:52 -0700
Message-Id: <1754423992-24652-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

This patch fixes some issues which were preventing this test to be
built on Windows:

- Remove VLAs (not supported by msvc).
- Replace strsep() (which is not natively available on Windows)
  with strtok_r().
- Remove the "thousands" separator from printf() calls as it is
  not available on Windows.
- Include the test in the Windows build.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test-flow-perf/actions_gen.c | 17 +++++++++++++++--
 app/test-flow-perf/main.c        | 23 ++++++++++++-----------
 app/test-flow-perf/meson.build   |  6 ------
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/app/test-flow-perf/actions_gen.c b/app/test-flow-perf/actions_gen.c
index 54fcbacb98..9d102e3af4 100644
--- a/app/test-flow-perf/actions_gen.c
+++ b/app/test-flow-perf/actions_gen.c
@@ -15,6 +15,7 @@
 #include <rte_gtp.h>
 #include <rte_gre.h>
 #include <rte_geneve.h>
+#include <rte_os_shim.h>
 
 #include "actions_gen.h"
 #include "flow_gen.h"
@@ -921,10 +922,19 @@ fill_actions(struct rte_flow_action *actions, uint64_t *flow_actions,
 {
 	struct additional_para additional_para_data;
 	uint8_t actions_counter = 0;
-	uint16_t hairpin_queues[hairpinq];
-	uint16_t queues[rx_queues_count];
+	uint16_t *hairpin_queues;
+	uint16_t *queues;
 	uint16_t i, j;
 
+	hairpin_queues = calloc(hairpinq, sizeof(uint16_t));
+	if (hairpin_queues == NULL)
+		rte_exit(EXIT_FAILURE, "No Memory available!");
+	queues = calloc(rx_queues_count, sizeof(uint16_t));
+	if (queues == NULL) {
+		free(hairpin_queues);
+		rte_exit(EXIT_FAILURE, "No Memory available!");
+	}
+
 	for (i = 0; i < rx_queues_count; i++)
 		queues[i] = i;
 
@@ -1151,4 +1161,7 @@ fill_actions(struct rte_flow_action *actions, uint64_t *flow_actions,
 		}
 	}
 	actions[actions_counter].type = RTE_FLOW_ACTION_TYPE_END;
+
+	free(queues);
+	free(hairpin_queues);
 }
diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index 07ddfe0e46..226501caf9 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -26,7 +26,6 @@
 #include <errno.h>
 #include <getopt.h>
 #include <stdbool.h>
-#include <sys/time.h>
 #include <signal.h>
 #include <unistd.h>
 
@@ -36,6 +35,7 @@
 #include <rte_ethdev.h>
 #include <rte_flow.h>
 #include <rte_mtr.h>
+#include <rte_os_shim.h>
 
 #include "config.h"
 #include "actions_gen.h"
@@ -601,15 +601,16 @@ static void
 read_meter_policy(char *prog, char *arg)
 {
 	char *token;
+	char *saveptr = NULL;
 	size_t i, j, k;
 
 	j = 0;
 	k = 0;
 	policy_mtr = true;
-	token = strsep(&arg, ":\0");
+	token = arg ? strtok_r(arg, ":", &saveptr) : NULL;
 	while (token != NULL && j < RTE_COLORS) {
 		actions_str[j++] = token;
-		token = strsep(&arg, ":\0");
+		token = strtok_r(NULL, ":", &saveptr);
 	}
 	j = 0;
 	token = strtok(actions_str[0], ",\0");
@@ -733,7 +734,7 @@ args_parse(int argc, char **argv)
 	};
 
 	RTE_ETH_FOREACH_DEV(i)
-		ports_mask |= 1 << i;
+		ports_mask |= RTE_BIT64(i);
 
 	for (i = 0; i < RTE_MAX_ETHPORTS; i++)
 		dst_ports[i] = PORT_ID_DST;
@@ -961,15 +962,15 @@ args_parse(int argc, char **argv)
 			}
 			if (strcmp(lgopts[opt_idx].name, "policy-mtr") == 0)
 				read_meter_policy(argv[0], optarg);
-			if (strcmp(lgopts[opt_idx].name,
-						"meter-profile") == 0) {
+			if (strcmp(lgopts[opt_idx].name, "meter-profile") == 0) {
 				i = 0;
-				token = strsep(&optarg, ",\0");
+				char *saveptr = NULL;
+				token = strtok_r(optarg, ",", &saveptr);
 				while (token != NULL && i < sizeof(
 						meter_profile_values) /
 						sizeof(uint64_t)) {
 					meter_profile_values[i++] = atol(token);
-					token = strsep(&optarg, ",\0");
+					token = strtok_r(NULL, ",", &saveptr);
 				}
 			}
 			if (strcmp(lgopts[opt_idx].name, "packet-mode") == 0)
@@ -1759,7 +1760,7 @@ packet_per_second_stats(void)
 		uint64_t tx_delta, rx_delta, drops_delta;
 		int nr_valid_core = 0;
 
-		sleep(1);
+		rte_delay_us_sleep(US_PER_S);
 
 		if (nr_lines) {
 			char go_up_nr_lines[16];
@@ -1781,7 +1782,7 @@ packet_per_second_stats(void)
 			tx_delta    = li->tx_pkts  - oli->tx_pkts;
 			rx_delta    = li->rx_pkts  - oli->rx_pkts;
 			drops_delta = li->tx_drops - oli->tx_drops;
-			printf("%6d %'16"PRId64" %'16"PRId64" %'16"PRId64"\n",
+			printf("%6d %16" PRId64 " %16" PRId64 " %16" PRId64 "\n",
 				i, tx_delta, drops_delta, rx_delta);
 
 			total_tx_pkts  += tx_delta;
@@ -1793,7 +1794,7 @@ packet_per_second_stats(void)
 		}
 
 		if (nr_valid_core > 1) {
-			printf("%6s %'16"PRId64" %'16"PRId64" %'16"PRId64"\n",
+			printf("%6s %16" PRId64 " %16" PRId64 " %16" PRId64 "\n",
 				"total", total_tx_pkts, total_tx_drops,
 				total_rx_pkts);
 			nr_lines += 1;
diff --git a/app/test-flow-perf/meson.build b/app/test-flow-perf/meson.build
index 5758f8d9c6..e101449e32 100644
--- a/app/test-flow-perf/meson.build
+++ b/app/test-flow-perf/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2020 Mellanox Technologies, Ltd
 
-if is_windows
-    build = false
-    reason = 'not supported on Windows'
-    subdir_done()
-endif
-
 sources = files(
         'actions_gen.c',
         'flow_gen.c',
-- 
2.50.1.vfs.0.0

