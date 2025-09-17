Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B4FCAC599
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 11:36:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 058DE402DA;
	Wed, 17 Sep 2025 13:36:16 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id EA879402CC
 for <dev@dpdk.org>; Wed, 17 Sep 2025 13:36:13 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7726c7ff7e5so5252571b3a.3
 for <dev@dpdk.org>; Wed, 17 Sep 2025 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1758108973;
 x=1758713773; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1fT73UL2odjtdVs4Ek3E6Q2uWvV6j6km0/WhCYrRPQ=;
 b=KsGN6KgGG1kMfAdrm+WA4IOBvXj7/egpNc/VPCHDgj7TU4P3f8YUw5nF6R4eTHhK8A
 SNyv08dDwEySS0uI1LAR4TigW8T/XvPfdJVFLFnd1GB0vDqQnSfiTwQl4PigSWrfVb4X
 7eVN4nw2nLSavOD1XXIjx1bOUNNAyzyGzZfiwpivkCDqJ7kTv62FtdGKLWw9nrYyj18r
 aM5F4WAYCmaHmVjiOb+NaC3JuZQUNTQ6GLiWf6vYwYYuYR6Eb4Ojx4Y8P5Lbh6Ry/U4F
 oIQPbfFi5SugGxo/00as+P4PohxT6QlS73CICz/ae5V2VL2pAvDCD3v7xyw0PJOPD0S1
 IJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758108973; x=1758713773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1fT73UL2odjtdVs4Ek3E6Q2uWvV6j6km0/WhCYrRPQ=;
 b=sq3hhF2u4pNhpeSKyyMOP3+q7CdoTpl6lmlJK/79DvzyDgbpAzl60wzZjN2woWVvPl
 EtOTlobWPIIddqjNQ8V2BnS+a3M163ltOoYplP69xsc1I45QKFwERnEVIHNixA5OEpUY
 R3ieN2iKwHp29Y8RTofl96GhsVo2ykvJX8wcx1N2TuRKz6v594aeZHGLpHk31ZmYYBE4
 Z8cq/YXU+Nch/tndi6yFoMde/pZ7rbMxH3Ycgre0VXODEH4ZDyEJqdoPWNztvmkaRio/
 Su6r0rAy0SsWiUQp/Cx4vVIqaQ5wZx09jhBNEW5m/NgbpPEKCmMPnLUfXyz38zOWu0fz
 PcRg==
X-Gm-Message-State: AOJu0Yy9UXCks7RgG3N1khml/0YZaqnoW6jq/GMGaCiI827Mja0f9kmR
 CfxW/YgW6kwQ2Lp8sYYBejyHz20jrGGSop4vM75ua7aQ/5X7pT4t8nYsUKUH6rvCxHc=
X-Gm-Gg: ASbGncsWO3CMJUEd90Em0LjhgejRLRNRsZNFvTvZQ7H3cRc1HXhHyQRJA0SHOjr1iXG
 7fXjjRELozrC1tXJz4U1cBLk+gZSPHdlV/n0hafSmDDlyEJ+UOfMCbVPeD7pA26A1khGAiAQXd8
 knD84WEH+L4+KlDyAW/E4up/CwEow8gqR/oGO7RljWLQP7BqFg5JW+O0MrN5GB/aByXLjePPZxC
 mriK54qr6cbvuSqV7ZXTSHnOncz+vWpRGbfWlBthdxRGEn3qMPfdKWQk55x20YXp3og27nHJDjD
 JUcsoeBIvX8pe1kSBRYvFio+lUkyi05sa9qWRqsKAwvmQHdRRKatOqHlZ+onKSOPM8DVHQYjmH/
 V/kgjz5eDOe9r7cxJ8TGq865e/yuG4vqIGIYVqNt6IBDhIC1xJgwHGDMGuwJjiK2Bdv+SZY3TXC
 +qzHUVw9G52Y85dleVQGS5BoBbgw7B8lzKHnvlSJGXYRQGFs5d0D0loKG/CD9+kjx0HkmyBeepW
 niPlQGPAPhjJIKDB3My2sNeVPn3xb4bTQ==
X-Google-Smtp-Source: AGHT+IEqdBHbSPgdXDK+IjUbKg62VJv2z54YU9dSHZ2A/SAsODC7432Nr2Y/SHI/PHV984YiCx2m5w==
X-Received: by 2002:a05:6a21:3292:b0:262:6310:3f9e with SMTP id
 adf61e73a8af0-27aaba4e1dbmr2515222637.52.1758108972865; 
 Wed, 17 Sep 2025 04:36:12 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607a47d7fsm18898875b3a.31.2025.09.17.04.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 04:36:12 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Xiaoyun Li <xiaoyun.li@intel.com>, Lijun Ou <oulijun@huawei.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
Date: Wed, 17 Sep 2025 04:36:01 -0700
Message-Id: <20250917113601.521308-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250915112513.496136-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250915112513.496136-1-14pwcse1224@uetpeshawar.edu.pk>
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

When the secondary process testpmd application running any fwd_engine
and after that primary has exited will cause a crash.

This patch forces secondary process forwarding lcores
in fwd_engine to stop before the primary process exits.

Fixes: a550baf24af90f ("app/testpmd: support multi-process")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c      | 57 ++++++++++++++++++++++++++++++++++---
 app/test-pmd/testpmd.h      |  1 -
 lib/eal/common/hotplug_mp.h |  1 +
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..474c97ed1c 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -75,6 +75,7 @@
 #endif
 
 #include "testpmd.h"
+#include "hotplug_mp.h"
 
 #ifndef MAP_HUGETLB
 /* FreeBSD may not have MAP_HUGETLB (in fact, it probably doesn't) */
@@ -103,7 +104,7 @@ uint16_t verbose_level = 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
 
 /* Maximum delay for exiting after primary process. */
-#define MONITOR_INTERVAL (500 * 1000)
+#define MONITOR_INTERVAL (500)
 
 /* use main core for command line ? */
 uint8_t interactive = 0;
@@ -238,6 +239,7 @@ unsigned int xstats_display_num; /**< Size of extended statistics to show */
  */
 volatile uint8_t f_quit;
 uint8_t cl_quit; /* Quit testpmd from cmdline. */
+volatile uint8_t f_exit_sec;
 
 /*
  * Max Rx frame size, set by '--max-pkt-len' parameter.
@@ -2563,7 +2565,12 @@ stop_packet_forwarding(void)
 	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++)
 		fwd_lcores[lc_id]->stopped = 1;
 	printf("\nWaiting for lcores to finish...\n");
-	rte_eal_mp_wait_lcore();
+#ifndef RTE_EXEC_ENV_WINDOWS
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_eal_mp_wait_lcore();
+#else
+		rte_eal_mp_wait_lcore();
+#endif
 	port_fwd_end = cur_fwd_config.fwd_eng->port_fwd_end;
 	if (port_fwd_end != NULL) {
 		for (i = 0; i < cur_fwd_config.nb_fwd_ports; i++) {
@@ -3630,6 +3637,19 @@ pmd_test_exit(void)
 #endif
 	if (ports != NULL) {
 		no_link_check = 1;
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+			struct eal_dev_mp_req req = { .t = EAL_DEV_REQ_TYPE_STOP,
+				.result = 0};
+			struct rte_mp_msg mp_req;
+			memset(&mp_req, 0, sizeof(mp_req));
+			snprintf(mp_req.name, sizeof(mp_req.name), "eal_dev_mp_stop_req");
+			memcpy(mp_req.param, &req, sizeof(req));
+			mp_req.len_param = sizeof(req);
+			struct rte_mp_reply reply;
+			struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+			printf("Primary: Sending 'stop_req' request to secondary...\n");
+			rte_mp_request_sync(&mp_req, &reply, &ts);
+		}
 		RTE_ETH_FOREACH_DEV(pt_id) {
 			printf("\nStopping port %d...\n", pt_id);
 			fflush(stdout);
@@ -4365,12 +4385,35 @@ signal_handler(int signum __rte_unused)
 	prompt_exit();
 }
 
+static int
+handle_eal_dev_request(const struct rte_mp_msg *request, const void *peer)
+{
+	const struct eal_dev_mp_req *req =
+		(const struct eal_dev_mp_req *)request->param;
+	struct eal_dev_mp_req reply_data;
+	struct rte_mp_msg reply_msg;
+
+	printf("Received message from primary\n");
+	if (req->t == EAL_DEV_REQ_TYPE_STOP) {
+		f_quit = 1;
+		reply_data.result = 0;
+	} else {
+		reply_data.result = -1;
+	}
+	memset(&reply_msg, 0, sizeof(reply_msg));
+	strlcpy(reply_msg.name, request->name, sizeof(reply_msg.name));
+	memcpy(reply_msg.param, &reply_data, sizeof(reply_data));
+	rte_mp_reply(&reply_msg, peer);
+	printf("Sent stop reply to primary\n");
+	return 0;
+}
+
 #ifndef RTE_EXEC_ENV_WINDOWS
 /* Alarm signal handler, used to check that primary process */
 static void
 monitor_primary(void *arg __rte_unused)
 {
-	if (rte_eal_primary_proc_alive(NULL)) {
+	if (rte_eal_primary_proc_alive(NULL) && (!f_quit)) {
 		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
 	} else {
 		/*
@@ -4378,6 +4421,7 @@ monitor_primary(void *arg __rte_unused)
 		 * is no longer valid. Calling any cleanup code is going to
 		 * run into use after free.
 		 */
+		stop_packet_forwarding();
 		fprintf(stderr, "\nPrimary process is no longer active, exiting...\n");
 		exit(EXIT_FAILURE);
 	}
@@ -4432,6 +4476,9 @@ main(int argc, char** argv)
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
 	    enable_primary_monitor() < 0)
 		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+	else if (rte_mp_action_register("eal_dev_mp_stop_req",
+				handle_eal_dev_request) != 0)
+		rte_exit(EXIT_FAILURE, "Failed to register message action\n");
 #endif
 
 	/* allocate port structures, and init them */
@@ -4628,8 +4675,10 @@ main(int argc, char** argv)
 	}
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		disable_primary_monitor();
+		rte_mp_action_unregister("eal_dev_mp_stop_req");
+	}
 #endif
 
 	pmd_test_exit();
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 96ac88a29c..79adb82f74 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -34,7 +34,6 @@
 #define RTE_PORT_HANDLING       (uint16_t)3
 
 extern uint8_t cl_quit;
-extern volatile uint8_t f_quit;
 
 /*
  * It is used to allocate the memory for hash key.
diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
index 7221284286..bfea2906c0 100644
--- a/lib/eal/common/hotplug_mp.h
+++ b/lib/eal/common/hotplug_mp.h
@@ -19,6 +19,7 @@ enum eal_dev_req_type {
 	EAL_DEV_REQ_TYPE_DETACH,
 	EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK,
 	EAL_DEV_REQ_TYPE_DETACH_ROLLBACK,
+	EAL_DEV_REQ_TYPE_STOP,
 };
 
 struct eal_dev_mp_req {
-- 
2.27.0

