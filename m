Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94DCCAC597
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 10:23:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97FAB4064F;
	Mon, 15 Sep 2025 12:23:29 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id A895A40262
 for <dev@dpdk.org>; Mon, 15 Sep 2025 12:23:28 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-32b863ed6b6so3333705a91.2
 for <dev@dpdk.org>; Mon, 15 Sep 2025 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757931808;
 x=1758536608; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZAYaaQW6z5a37oKs6YY67/XQjP0ubG5rHOPh8ZU2B4=;
 b=WsPHqTHp2Gai1MvI0aT45WNJjsSUbEnZEavq1i4aGBB1PSir/7An/EioSawi8pDcFo
 jv/AYjcWjCt1nvtO+P0FAzaBFPCuMfcfH3Vzt1h6wgn4jlzBWYH9m43bWmzBtWk18Mxe
 1qyhT+htI6xcpY1QtBxonxyFb01nbSXIFsg9qaOQB77MpoRQyqYGp57N2V7R+WvrpsIf
 b3wW87shcOsV1WC0FI3M2xeQyKYnn3C2Ax9AJRpFzFQFIr3tpUt2hVTNi4p+LRJ/ijdk
 GV2aQ/aj33eUa0RlPh4YNT/JVd6esT1sUZQMdTB3+a/hSLGGLaAP8GMAHqK21fdndBsq
 ULqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757931808; x=1758536608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZAYaaQW6z5a37oKs6YY67/XQjP0ubG5rHOPh8ZU2B4=;
 b=TMuRNM+ntZHR/6pA8U5cC084RmiwT/cX8O5pAhIZMrQeigYrBFiGckZSSpi5Exrt+6
 8GBY3RCJLEDD2gpqnTu/4JhWllv4xLCuFgX7qGshc9Imdf8PDwj3T3GSIqs/3klsCqvW
 amXQSlE3FPMEeR4X8b1g38x9D4V3e+Sos/JRByQgXVVaCv2CAU/YhLI5cBICa49z5KsK
 pkg04riIB8AhRBRDHbE8OKAPxr5clt05dnm1I0m7WmNSUaoMOsbZdH5eiqNCubr79/A0
 4FXgD2TjgTohXhovcRPAR47M5jLS/wbtMsqRxv3/RafwTF0HoTVmPG6aSQ+KrBJHeCVP
 TtOg==
X-Gm-Message-State: AOJu0YwgwvS3uZ+EhSPWTJQ9cuaknULqkJTE2dt8bdlbCR6Wr3Zwo13a
 9b4dpk78zXN3X3P+8XKCW1dg5mLQyKLJo4c1UA1lSYrb1debeBF5zhqW7TL3v88KmtU=
X-Gm-Gg: ASbGncvLeAAZx2cHPtlK5wtvZYtiKswBEJKxrHQZoAnar8bwTvzKeJoHbszvUaJkP6b
 7b37cK6G5u5Yk0wNIXgypjZCmP+JDtcEdPS5WVpTVNzi2/q8uvRpXTkm8jUIyP/Ddz76lRDPmjB
 sUsY05plu5ILBGl3NtOnuwUH6FPjiWPx5kZbO+5GwSZRUufojgfErK+rCwyRRDnLPLL46TcFrSQ
 XrN3s6syVGZfs1U91zfjAWjVDGl6g3ROEdvzhMNROioGB41mqWC036h8hnlhp2Z/54vfKQsSUxJ
 Wi4QYS7YJ+N32Lzb5nig/0p4SFeMVq/OwTCTgygZTYJjrIlFhiYi+l94BfHDHT2gI7IxKvUCfEL
 uLN06Wt8XnyLzUWXZnghc3Wc4zQ0WYp/lonZKdIIJSRG86RtXnJDuVMDXeYqw42eqvQzXEmvZxY
 5j48zaEgTzVaizY1HA7c1Wyyz5DkpTHMGcaX4AU6glOHTkm37RDFRZ1PjaRaYDmiMcWhMNH5+OL
 IU4sza4o/wKtDhPca254Vp7c5ccadFYYIEAVPZ1jABs
X-Google-Smtp-Source: AGHT+IGWk4elazYppLWTMZ/6lteIjg0A6PJqUHRo4jhtrQ4fHzbhnhiVqv1bnzFD9v5V8He4XfC/EQ==
X-Received: by 2002:a17:90b:4cc9:b0:32e:59ef:f403 with SMTP id
 98e67ed59e1d1-32e59f01354mr4272996a91.17.1757931807662; 
 Mon, 15 Sep 2025 03:23:27 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32df14d224asm9908190a91.5.2025.09.15.03.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:23:27 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Xiaoyun Li <xiaoyun.li@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Lijun Ou <oulijun@huawei.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
Date: Mon, 15 Sep 2025 03:23:12 -0700
Message-Id: <20250915102312.495221-1-14pwcse1224@uetpeshawar.edu.pk>
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
 lib/eal/common/hotplug_mp.c |  4 ++++
 lib/eal/common/hotplug_mp.h |  2 ++
 3 files changed, 28 insertions(+), 3 deletions(-)

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
index 17089ca3db..d1913c50db 100644
--- a/lib/eal/common/hotplug_mp.c
+++ b/lib/eal/common/hotplug_mp.c
@@ -15,6 +15,7 @@
 #include "eal_private.h"
 
 #define MP_TIMEOUT_S 5 /**< 5 seconds timeouts */
+uint8_t f_exit_sec;
 
 struct mp_reply_bundle {
 	struct rte_mp_msg msg;
@@ -239,6 +240,9 @@ static void __handle_primary_request(void *param)
 	memset(&mp_resp, 0, sizeof(mp_resp));
 
 	switch (req->t) {
+	case EAL_DEV_REQ_TYPE_STOP:
+		f_exit_sec = 1;
+		break;
 	case EAL_DEV_REQ_TYPE_ATTACH:
 	case EAL_DEV_REQ_TYPE_DETACH_ROLLBACK:
 		ret = local_dev_probe(req->devargs, &dev);
diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
index 7221284286..a33e3cbcc5 100644
--- a/lib/eal/common/hotplug_mp.h
+++ b/lib/eal/common/hotplug_mp.h
@@ -9,6 +9,7 @@
 
 #define EAL_DEV_MP_ACTION_REQUEST      "eal_dev_mp_request"
 #define EAL_DEV_MP_ACTION_RESPONSE     "eal_dev_mp_response"
+extern uint8_t f_exit_sec;
 
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

