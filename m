Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0356CAC598
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 09:29:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2C0240395;
	Mon, 15 Sep 2025 11:29:48 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 1D0C540395
 for <dev@dpdk.org>; Mon, 15 Sep 2025 11:29:48 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-24b13313b1bso26365445ad.2
 for <dev@dpdk.org>; Mon, 15 Sep 2025 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757928587;
 x=1758533387; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy5ET3VMEk9u1OLem6tPjCehyjOLXGc6H+jSgUY4DAQ=;
 b=I5EMhPwIr0TJvTjAfFuXojpUXI3v+hnKxCeyCFjmrr0usNwSRoVFGjOzgYLvi8Hmz6
 YQFtL3kURmZ4uodi1jjNo1SYy3VXgiuOOUAQ7Ot6e1Fn9Af7dRbhVm3bbCKRBgQttaVi
 9Pua4dcRgECovq/znUupgr4rupvW72QUMmd53LbZK5GJdVcqhkMx+YGJ0nMf5z88q/Aq
 cagSgbvqvyOOjcKEw2nbeiUqy78lo6vczrA+4dqgLwffpmepXB1TB6ZDSnUMl9liXUKr
 X8Argvxc7Apx3Ij0maWDtiRieLshlLbFoYo+FVWNgh0nPNdVZCXYLRgJwy+njpb8Mfcu
 Ab8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757928587; x=1758533387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy5ET3VMEk9u1OLem6tPjCehyjOLXGc6H+jSgUY4DAQ=;
 b=p5QSAWCIYy+MoL1tosua4Xpk4ymRbHhJy6LlIjn6rXvlNUntKvaNBhVLnMJMlIZEnb
 l6hyw+OonCtC9pp68i/akTyEetezYM8qR9+Ha+mt83lEyBPG01GZF4jKEAeHoY3csNTy
 4V9ua6XaiQPqvikdbYL2179914qtrkVf0zjUDw03MHyL3gfnT68qL3AFM+nbiiB43Ikd
 m97dxY9FI+nBB7/TA+zDCrGe3WK0N3jzsKOhy+WH3X1YZbfNBlBhBCs7iUxobDHgawCU
 PhVtuyVNix+JKwR6TeAazFIC9736M7X2OY1q6TgeWQA+pJsjILMr2cwC9g49wf4LegYO
 HDzw==
X-Gm-Message-State: AOJu0YxqyA4jLggC0++1A75BEgSEewFBw4OEHcMQinR+b2j1vXuzszhX
 bZ0QYJlGtiF2WY7iW3BQGaYOjExQjvuyyDtlPTtMUgfup2uUoxUKe5l1B+vN93GiTSk=
X-Gm-Gg: ASbGncsX2hmnb0IWUBxUgICOIhC4VplhXzHl+b2l+qkm+yb6N0Celb5CHPQ77bz60yN
 lAJp9ly145Ep4cl7+KvTySmU7IZsxf3U4xESSYzG4xme+Y/rZggoXHUN+MqXZa+l27fCIjQMi9T
 RwgQfPT99cb0M/6zeOQxJNyCyihjAs3QiZ7rU6BP2YPq/GbE6IvToUz+bdlFJiwEQGLGx4ioo5x
 jIvWN22fyirIz78D2hQBPUIyvRhptD0D0x8quUFK5LmPqUd8bJGB7Or06TTkCfUhVW1jOSZV+NO
 e5Jxz8bXcQ8hVL5kp8PPIDMuEcZddjfL+rGxV3Tnt5In4GWW6wNTg0Ct4GexxTAcJzgXGhB6abE
 KXuIgZ/WyWkQtUz/Z8F/LFFdMabCuWam+KkNhrpxV3tqm2z/nNljgX89mnNccvB1zx5Kk3YtxL6
 z56feUFFAg+a3Pmi1SvwF9hbbMEAGuQC0zUpa6jEhNM5kHWOIymqOm6wPHxMQqrMwaFW+hH6S3/
 TZpXgpWuggaUukqe50CXaa7y6qSHeeV7ZyNEK+R70d9
X-Google-Smtp-Source: AGHT+IFgn/Ku3cdPkI02VXJDt507jDPGj2o5C6b4X9rDZaCSd+R7cU/Ym1bZmoGmBpEYdw/zBUNLdw==
X-Received: by 2002:a17:903:238e:b0:25c:b1d6:c41a with SMTP id
 d9443c01a7336-25d23e10eafmr147191055ad.11.1757928587130; 
 Mon, 15 Sep 2025 02:29:47 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-265819a6212sm32553885ad.57.2025.09.15.02.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 02:29:46 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Lijun Ou <oulijun@huawei.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
Date: Mon, 15 Sep 2025 02:29:37 -0700
Message-Id: <20250915092937.491562-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
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
 app/test-pmd/testpmd.c      | 25 ++++++++++++++++++++++---
 lib/eal/common/hotplug_mp.c |  3 +++
 lib/eal/common/hotplug_mp.h |  2 ++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..f385bf920d 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <sys/mman.h>
+#include "hotplug_mp.h"
 #endif
 #include <sys/types.h>
 #include <errno.h>
@@ -103,7 +104,7 @@ uint16_t verbose_level = 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
 
 /* Maximum delay for exiting after primary process. */
-#define MONITOR_INTERVAL (500 * 1000)
+#define MONITOR_INTERVAL (500)
 
 /* use main core for command line ? */
 uint8_t interactive = 0;
@@ -2563,7 +2564,12 @@ stop_packet_forwarding(void)
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
@@ -3634,6 +3640,13 @@ pmd_test_exit(void)
 			printf("\nStopping port %d...\n", pt_id);
 			fflush(stdout);
 			stop_port(pt_id);
+#ifndef RTE_EXEC_ENV_WINDOWS
+			printf("Stopping secondary process...\n");
+			struct eal_dev_mp_req req;
+			memset(&req, 0, sizeof(req));
+			req.t = EAL_DEV_REQ_TYPE_STOP;
+			eal_dev_hotplug_request_to_secondary(&req);
+#endif
 		}
 		RTE_ETH_FOREACH_DEV(pt_id) {
 			printf("\nShutting down port %d...\n", pt_id);
@@ -4371,7 +4384,13 @@ static void
 monitor_primary(void *arg __rte_unused)
 {
 	if (rte_eal_primary_proc_alive(NULL)) {
-		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+		if (f_exit_sec) {
+			stop_packet_forwarding();
+			fprintf(stderr, "\nPrimary process is no longer active, exiting...\n");
+			exit(EXIT_FAILURE);
+		} else {
+			rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+		}
 	} else {
 		/*
 		 * If primary process exits, then all the device information
diff --git a/lib/eal/common/hotplug_mp.c b/lib/eal/common/hotplug_mp.c
index 17089ca3db..2574a95168 100644
--- a/lib/eal/common/hotplug_mp.c
+++ b/lib/eal/common/hotplug_mp.c
@@ -239,6 +239,9 @@ static void __handle_primary_request(void *param)
 	memset(&mp_resp, 0, sizeof(mp_resp));
 
 	switch (req->t) {
+	case EAL_DEV_REQ_TYPE_STOP:
+		f_exit_sec = 1;
+		break;
 	case EAL_DEV_REQ_TYPE_ATTACH:
 	case EAL_DEV_REQ_TYPE_DETACH_ROLLBACK:
 		ret = local_dev_probe(req->devargs, &dev);
diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
index 7221284286..4f7b6d8f58 100644
--- a/lib/eal/common/hotplug_mp.h
+++ b/lib/eal/common/hotplug_mp.h
@@ -9,6 +9,7 @@
 
 #define EAL_DEV_MP_ACTION_REQUEST      "eal_dev_mp_request"
 #define EAL_DEV_MP_ACTION_RESPONSE     "eal_dev_mp_response"
+volatile uint8_t f_exit_sec;
 
 #define EAL_DEV_MP_DEV_NAME_MAX_LEN RTE_DEV_NAME_MAX_LEN
 #define EAL_DEV_MP_BUS_NAME_MAX_LEN 32
@@ -19,6 +20,7 @@ enum eal_dev_req_type {
 	EAL_DEV_REQ_TYPE_DETACH,
 	EAL_DEV_REQ_TYPE_ATTACH_ROLLBACK,
 	EAL_DEV_REQ_TYPE_DETACH_ROLLBACK,
+	EAL_DEV_REQ_TYPE_STOP,
 };
 
 struct eal_dev_mp_req {
-- 
2.27.0

