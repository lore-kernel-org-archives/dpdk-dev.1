Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAFCCAC58E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 08:10:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EF234042C;
	Mon, 15 Sep 2025 10:10:50 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 8627E402DC
 for <dev@dpdk.org>; Mon, 15 Sep 2025 10:10:48 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-329b760080fso3809200a91.1
 for <dev@dpdk.org>; Mon, 15 Sep 2025 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757923848;
 x=1758528648; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ccv9HsLhGyjCFY6O6X5xKvnDdOYyRRFlJ+7F4izel64=;
 b=kh8EZU7F8uwN+dWrF/1JYkjIxsQDCGajEZBkQTi4r56w2gvbMoChWIb5GzNAyBCszK
 gCnbtnCDIT3KF7xHS6k5T9bB727Un62JObXOzYr7QybwYYx2NZd79RphoeRQCacPwKFi
 jNJ3GyKLRWQETpQmvx8HFiFJ7SHcQscM1cKavg+Uai1wBDfmj2iDAGyYulENZ/jmn5AT
 61Pubwku7uPYSVovrmjYSQtXtFSzQxQeVL3XZ77wm72c7F7JmELdL0i+oQ7Vtn8d3MH6
 Rt1DYp3LGuADr4SUdu+ta7soMuoPalAGL1EIQAWQvetlcXsCEjKgTd67Ili6ddeOcU5s
 4YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757923848; x=1758528648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ccv9HsLhGyjCFY6O6X5xKvnDdOYyRRFlJ+7F4izel64=;
 b=ITYQknpoaxagL54zV679IJ5yZ6CU4vmeb1oRqFlZhEnY/MlT4MPRiUg0glaUa/dKl2
 7TbIJdVXqLeQuzRScKx7+V+jJLjhUwheACWO+bgshcybMAd+39ritEy5+ukgKoNN5BrD
 owtS4aAkEug7NUenancO5UnxEqE88kpjk+FxFOLJBcTDd21pEtzt/FTUzPiw3LYwxUVO
 /5qWL7epCQorp4+n50cvaQfcul2Da3FgiYvk9ZLhp3Udk3h7qZEsllV219H2TdYE7Ohf
 OPSdqPWCGJiRWW85Ay8dJQJq66Ili6FlmUjU18YNYMAVutdf2BgC4A5aporixiM726W6
 fhmQ==
X-Gm-Message-State: AOJu0YyEgabBQ3gcQLar2r4V/qTXZKQcXKN9VzYN+NMNjiF0maip7voX
 UX0gMqrCB3cHFKLeiMkKIMIsqXzSng7mOJ6p3S6LYaTCUg45TWLdI2EVPC/+av1Q2gA=
X-Gm-Gg: ASbGncv2HepdCNgKZ7qble91Mf8Gm2UZy6n1VJYw8QJnUYXDGzX10JoOzBtYTDXqnMd
 e2Z/Ld9dlXDRIDay7f4EMbAhkg7UXi9DAPulCAIrvvpTIvT5q5Ow8EtQWgeAfvRJOClFE7jSF3k
 OSF6d8QoblANPNY//JkFkMr5FynmI3/zKex2n0gikKgWvtqMd2nrpZLiU87AQ2H8Up5eyXtbTsn
 Abu0KW8HVVPynDdNYUjLm1vQebs4/RQV6pVelcT2oKxIXLwW66dzPObwTyzR4rcOZK8ZhXt8dq+
 7h2G150vgeM7uKHsU4Sz/Pn0Wr7680GWqkste0M0AH3hAIw42gz29p/kQU43clXh32zQsDi0SBv
 aniyDsqEk4wyq3bG3iM1pFMABQWYZv8eIj+Erb5xeQ6EdOp/b/Lb/CVNu0KkrTJQtzj+Y8N0knP
 9/N5b2FWCJPk3qRKI2A3wd9x+PCUefFU55bHmff3odGytA8cYGHFVZkyM9bvpJ8/f2GQl/S4jNs
 zoINIK5+u0lNj2bgAbFwxjzX2clmWs7amw=
X-Google-Smtp-Source: AGHT+IE0vpAiBGsrR8MKD7HS3ZRgaaaiwWmHvg0PUgvdQwD+RJrlJ1xvkKyKfi5KKle0oxSF1kr+cg==
X-Received: by 2002:a17:90b:540c:b0:32e:f1c:e778 with SMTP id
 98e67ed59e1d1-32e0f1ce9ddmr8410731a91.3.1757923847592; 
 Mon, 15 Sep 2025 01:10:47 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607b18371sm12713414b3a.49.2025.09.15.01.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:10:47 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Lijun Ou <oulijun@huawei.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
Date: Mon, 15 Sep 2025 01:10:36 -0700
Message-Id: <20250915081037.489810-1-14pwcse1224@uetpeshawar.edu.pk>
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
 app/test-pmd/testpmd.c      | 19 ++++++++++++++++---
 lib/eal/common/hotplug_mp.c |  3 +++
 lib/eal/common/hotplug_mp.h |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..eda3a0264d 100644
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
@@ -2563,7 +2564,8 @@ stop_packet_forwarding(void)
 	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++)
 		fwd_lcores[lc_id]->stopped = 1;
 	printf("\nWaiting for lcores to finish...\n");
-	rte_eal_mp_wait_lcore();
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_eal_mp_wait_lcore();
 	port_fwd_end = cur_fwd_config.fwd_eng->port_fwd_end;
 	if (port_fwd_end != NULL) {
 		for (i = 0; i < cur_fwd_config.nb_fwd_ports; i++) {
@@ -3634,6 +3636,11 @@ pmd_test_exit(void)
 			printf("\nStopping port %d...\n", pt_id);
 			fflush(stdout);
 			stop_port(pt_id);
+			printf("Stopping secondary process...\n");
+			struct eal_dev_mp_req req;
+			memset(&req, 0, sizeof(req));
+			req.t = EAL_DEV_REQ_TYPE_STOP;
+			eal_dev_hotplug_request_to_secondary(&req);
 		}
 		RTE_ETH_FOREACH_DEV(pt_id) {
 			printf("\nShutting down port %d...\n", pt_id);
@@ -4371,7 +4378,13 @@ static void
 monitor_primary(void *arg __rte_unused)
 {
 	if (rte_eal_primary_proc_alive(NULL)) {
-		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+		if (f_exit) {
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
index 17089ca3db..538e6eaf4e 100644
--- a/lib/eal/common/hotplug_mp.c
+++ b/lib/eal/common/hotplug_mp.c
@@ -239,6 +239,9 @@ static void __handle_primary_request(void *param)
 	memset(&mp_resp, 0, sizeof(mp_resp));
 
 	switch (req->t) {
+	case EAL_DEV_REQ_TYPE_STOP:
+		f_exit = 1;
+		break;
 	case EAL_DEV_REQ_TYPE_ATTACH:
 	case EAL_DEV_REQ_TYPE_DETACH_ROLLBACK:
 		ret = local_dev_probe(req->devargs, &dev);
diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
index 7221284286..b0755bcf51 100644
--- a/lib/eal/common/hotplug_mp.h
+++ b/lib/eal/common/hotplug_mp.h
@@ -9,6 +9,7 @@
 
 #define EAL_DEV_MP_ACTION_REQUEST      "eal_dev_mp_request"
 #define EAL_DEV_MP_ACTION_RESPONSE     "eal_dev_mp_response"
+volatile uint8_t f_exit;
 
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

