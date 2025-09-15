Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8BDCAC593
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 11:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7056840659;
	Mon, 15 Sep 2025 13:25:32 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5DA6540656
 for <dev@dpdk.org>; Mon, 15 Sep 2025 13:25:31 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7761b83fd01so2317636b3a.3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 04:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757935530;
 x=1758540330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBkz+auOFatnPEtA6JJasjw3IAKG8STiNX4T9klP3nc=;
 b=YmfBTkG8xs8A+a4I8lnEbg4Y4wHaI0CSSmvu4wTL4MCf4rtJO6IX+ua746mlpxzvmH
 iN5arwUrgQUApSSO8wE0mUzkx+4TmMmsTeZvowKTsDm+UI/+9GlWu/mPCi8KeMI2HmaW
 rot+gM2maw5J1h5/zGmpLzlwSa4dPpQf/Xr0eNA1W+QR2qGfEslp/cWnx0jRS8xzsDtF
 54uzfUmJ8d9Vc5laNuckZNWCXZkywTOqkrptJImN52HIZ10Uu4mMAhxTe1EL64QN89GG
 7S78E1ZwyRjWLSVxXxAIukkyOk2YKZQPrM7woGZhne7klnjjpj3m7D4XnO4CTPcbeT/k
 /7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757935530; x=1758540330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBkz+auOFatnPEtA6JJasjw3IAKG8STiNX4T9klP3nc=;
 b=TwNmLC0QWTj4djxJA48O4PIjUA8hGFiUB18uqjKS9Ic4RGf1YW7RujDWHcJ+L7xAiE
 a6UWHGUfDq97IVj44reuITCBL65Xj8R1RFOeYRl/Gh2KWKpMggCIfv9ikn2ZtquE3eT8
 z6hSncDO+ohBKjsi6v8qtvfwzcZIaTmjWZ8Sm8oJ5NGxqpRqs50GjKu14QcB6ny/uso6
 RDWtZyXIokUW89CaLN551of0sRgEWV785jo2016nULJyxRHPRfcxSHRTbc3w6nJpEVpp
 XlaXuxTWtgfsPeHHWKqg2wEZNdndj5TO83ZgD9xD3Ih6B1BHYBJmhQxv+o3s1XeWAEm9
 nK4Q==
X-Gm-Message-State: AOJu0YxkF+U74FkGSO4ZCKYcd2m0HJA+ZWFI2hXOtrL8HEXFCyMfxZvR
 NwQIm1KFabvcJyRDwUvDWlHmV4RJj3ysQYVu48B9llBg1OBYrDNO+VqA+oIoBb2gjc8=
X-Gm-Gg: ASbGncsReZF9fCrBomSStm3uuLfJTnzRSSs5MPnIV/MtrZdSoJwOKNrxGmEKhu8FmZa
 9klAboIpg7bFxLrraUmthDjYV3Rd3uExXOe76E0p/gEx6AC+TfDkJwfLVk4pVlbxsREVVTo5uxO
 E/8uyTnzynKYTiu5aBrRiAP/boZ8Mo6Ulnty6JqXEeEmmjwd8T7b6WR6d54qYlxKYlS3swhCKa/
 f47iC+xgdtyGLZp8IytDdpx3Jf95vYpKlewzougaRxMQOJKG3/fL2/4H1U3xXMM6hZ2zFeeDcXa
 CP9X1b3FLllEpxNjPHLwLxh+aSWwbLRE8KADnwFQ/M1YY1xsFSQWZSWNyst1vO03tbv1ECdylEt
 FzNlMQqaO7mypCIQk+ExOnXq8P6CbM8T8ruInNU6AZHdQ8SzUaSLoeH2oueQmquenGnY/gU7XTo
 iNyPnysgyQxWAybjl9TPES3wCiiga8xgqTBamTABSg8/+2MWKE7k7xBI3CG94tnvjnJF8bvzvkw
 oWNMuEP18Whyrket5+u2aBiIFIlxRj9bA==
X-Google-Smtp-Source: AGHT+IG2vPXoge4n3A3t1vnb/UrUaZEzImTq9FvSsnVtsBJncEm6lsd1iWTsJxn44yp6x8eRl0t3KQ==
X-Received: by 2002:a05:6a00:982:b0:76b:d869:43fd with SMTP id
 d2e1a72fcca58-7761216815amr16086114b3a.18.1757935530347; 
 Mon, 15 Sep 2025 04:25:30 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-776224ddd9esm6985903b3a.21.2025.09.15.04.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 04:25:29 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Lijun Ou <oulijun@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
Date: Mon, 15 Sep 2025 04:25:13 -0700
Message-Id: <20250915112513.496136-1-14pwcse1224@uetpeshawar.edu.pk>
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
 app/test-pmd/testpmd.c      | 27 ++++++++++++++++++++++++---
 lib/eal/common/hotplug_mp.c |  4 ++++
 lib/eal/common/hotplug_mp.h |  2 ++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..bf2f578b80 100644
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
@@ -3634,6 +3640,15 @@ pmd_test_exit(void)
 			printf("\nStopping port %d...\n", pt_id);
 			fflush(stdout);
 			stop_port(pt_id);
+#ifndef RTE_EXEC_ENV_WINDOWS
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+			printf("Stopping secondary process...\n");
+			struct eal_dev_mp_req req;
+			memset(&req, 0, sizeof(req));
+			req.t = EAL_DEV_REQ_TYPE_STOP;
+			eal_dev_hotplug_request_to_secondary(&req);
+		}
+#endif
 		}
 		RTE_ETH_FOREACH_DEV(pt_id) {
 			printf("\nShutting down port %d...\n", pt_id);
@@ -4371,7 +4386,13 @@ static void
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

