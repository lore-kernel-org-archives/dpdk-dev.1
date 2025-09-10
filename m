Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21991CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 11:02:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 668A6402E8;
	Wed, 10 Sep 2025 13:02:53 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id D1D15402C4
 for <dev@dpdk.org>; Wed, 10 Sep 2025 13:02:51 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-77256200f1bso5815987b3a.3
 for <dev@dpdk.org>; Wed, 10 Sep 2025 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757502171;
 x=1758106971; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DmW47SUwrVFSHeO9Nkq88aP6z44ylMmWxP92k5J4XpM=;
 b=nsliG7qt6gBepjgpAVgSuWGrrRd497okm3VXMe6CRsfNbowvwqu+Ktl1iuJZlMT1cp
 hgM4mqQl1Z/u0OykGPmqkHDIV026m1U+NyHDBJuEuN1TsLiT8TBhdqT2LXpWEQ1t0gjB
 jnm0eBMRKAL95LTNJNck0v4lT+VNHXxvKvxZojUaYor8gF+r3zpBNYmJfUD046tnYys1
 VAwPHuse3PaKHoshVKeKKCOM84jEhvjtWjuN9wXA1WGf1iJN6Eg94bFle4ODAh8zUNEB
 iBv6TCflciUcSRfyI3mrF0yeP8EMdC6S60KzETCdlHz9YLwpr1KLpKAqtpIBGuEhtvL9
 +rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757502171; x=1758106971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DmW47SUwrVFSHeO9Nkq88aP6z44ylMmWxP92k5J4XpM=;
 b=qOl2fZXudWmgwEl4vxJauY4oTlSzyK38eBvq++CjuLss08VXC9gT7L69fwJm55AJJI
 tXJPGC2tHheO30wNh+rBZEE9acB8tPmzQlsFHse/pyxx3IYV0f6pFyURKedgrYl6sbV7
 W59L/fAi/wEbetdgvWCXnrK/1dzbuDBH6NHi7Ts3XdyumKCjKKI3whR6eIh/L7/Bhe5d
 JpXSp/beNvMn3+TNf82IfLTiK1rn/ZnPl1EyMca9mhHHz0SmrLOGUWP5nWi1v15Dxdw1
 ZyI1aVPD+uGcQ9KJZJpG6JKfboGuG3om6bLGRkfNksy7qrEk+r6dsbrzMvS+OvzwlA1N
 /71A==
X-Gm-Message-State: AOJu0Yza/MzgoVbLRSy5qqkpCr91B3TI3HCf39md4/caswqu97AM685Y
 L7YmRNOU1LBpwbN+1rN/xCAQn6B2EztwItD2+idBGspceymyL1oHaiAcVcPoz1QcTwA=
X-Gm-Gg: ASbGncsfqVeI/Yidmq3KDoK4HddmmL8cd3iwePFdsQ5l4KIF5qzH/hUtc4Y0GReKoJy
 RiCY0h+y6LaAPrE5oveHh+yyfSHO92tk7dutW0/C+k6IZPQ4RfSUXYSXgoST3EvtvzmiXPVq2f9
 TbVWZPQQiWGvDKEYOCONooVbFBWqrcxuuHcXghra7CM6fp/Fjrdpc18WBLGHxPyIk86PsrUqVRH
 CoHPeNvxB80oCh61IaPFfTuNmmA4j82zBnAlWdJ0vuu9p0LLwdrLw5YiutSirE8yxcK3pWmn7bM
 ldrmwmITqggtuO8Ipu6flgf5DmS5jR6VbOHN1j3xn5A6NbufznFCyplTLdLDX3z6yfy7bYFjAw4
 ZZRdrGP8UrS53RylmC4YiZ4qmwa9cUBerJDdTJbKthV9qfNfk981FN3GTjaR1DlfnLIxXVffLKg
 nR1Iw/oYpDHnMrb+yZNeCF5a3W3hIIEByYF7a7Es0GRswzOwSo5bSbK46w+CXy4nxRi3+o8eaZv
 vOjh7wqiDvu36TjH0c3yEhcYLyk6OpYPMl2t0IVIunbc1l8
X-Google-Smtp-Source: AGHT+IEVmSr+vcjAaLTqbQsaRIxPULMwROXXjsdIqO0ldwl9DDydgc3CwJH2gBPOVtHoWpUc2YCicg==
X-Received: by 2002:a05:6a00:2345:b0:771:ef50:34d with SMTP id
 d2e1a72fcca58-7742de84552mr16430149b3a.16.1757502170781; 
 Wed, 10 Sep 2025 04:02:50 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7746628ffbesm4859667b3a.66.2025.09.10.04.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 04:02:50 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org
Subject: [PATCH] app/testpmd: stop secondary process fwd_lcores during primary
 teardown
Date: Wed, 10 Sep 2025 04:02:37 -0700
Message-Id: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.27.0
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
---
 app/test-pmd/testpmd.c | 61 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..1642bdda27 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -103,8 +103,13 @@ uint16_t verbose_level = 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
 
 /* Maximum delay for exiting after primary process. */
-#define MONITOR_INTERVAL (500 * 1000)
+#define MONITOR_INTERVAL (500)
+static const char *_MSG_POOL = "MSG_POOL";
+static const char *_SEC_2_PRI = "SEC_2_PRI";
+static const char *_PRI_2_SEC = "PRI_2_SEC";
 
+struct rte_ring *send_ring, *recv_ring;
+struct rte_mempool *message_pool;
 /* use main core for command line ? */
 uint8_t interactive = 0;
 uint8_t auto_start = 0;
@@ -2563,7 +2568,8 @@ stop_packet_forwarding(void)
 	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++)
 		fwd_lcores[lc_id]->stopped = 1;
 	printf("\nWaiting for lcores to finish...\n");
-	rte_eal_mp_wait_lcore();
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_eal_mp_wait_lcore();
 	port_fwd_end = cur_fwd_config.fwd_eng->port_fwd_end;
 	if (port_fwd_end != NULL) {
 		for (i = 0; i < cur_fwd_config.nb_fwd_ports; i++) {
@@ -3634,6 +3640,17 @@ pmd_test_exit(void)
 			printf("\nStopping port %d...\n", pt_id);
 			fflush(stdout);
 			stop_port(pt_id);
+#ifndef RTE_EXEC_ENV_WINDOWS
+			printf("Stopping secondary process ...\n");
+			void *msg = NULL;
+			if (rte_mempool_get(message_pool, &msg) < 0)
+				rte_panic("Failed to get message buffer\n");
+			strlcpy((char *)msg, "stop", STR_TOKEN_SIZE);
+			if (rte_ring_enqueue(send_ring, msg) < 0) {
+				printf("Failed to send message - message discarded\n");
+				rte_mempool_put(message_pool, msg);
+			}
+#endif
 		}
 		RTE_ETH_FOREACH_DEV(pt_id) {
 			printf("\nShutting down port %d...\n", pt_id);
@@ -4370,8 +4387,21 @@ signal_handler(int signum __rte_unused)
 static void
 monitor_primary(void *arg __rte_unused)
 {
+	void *msg;
 	if (rte_eal_primary_proc_alive(NULL)) {
-		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+		if (rte_ring_dequeue(recv_ring, &msg) < 0) {
+			rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+		} else {
+			rte_mempool_put(message_pool, msg);
+			if (!strcmp((char *)msg, "stop")) {
+				printf("Received '%s'\n", (char *)msg);
+				stop_packet_forwarding();
+				fprintf(stderr, "\nPrimary process is no longer active,"
+					"exiting...\n");
+				exit(EXIT_FAILURE);
+			}
+		}
+
 	} else {
 		/*
 		 * If primary process exits, then all the device information
@@ -4429,9 +4459,34 @@ main(int argc, char** argv)
 			 rte_strerror(rte_errno));
 
 #ifndef RTE_EXEC_ENV_WINDOWS
+	unsigned int flags = 0;
+	unsigned int ring_size = 64;
+	unsigned int pool_size = 1024;
+	unsigned int pool_cache = 32;
+	unsigned int priv_data_sz = 0;
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
 	    enable_primary_monitor() < 0)
 		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+			/* Start of ring structure. 8< */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		send_ring = rte_ring_create(_PRI_2_SEC, ring_size, rte_socket_id(), flags);
+		recv_ring = rte_ring_create(_SEC_2_PRI, ring_size, rte_socket_id(), flags);
+		message_pool = rte_mempool_create(_MSG_POOL, pool_size,
+				STR_TOKEN_SIZE, pool_cache, priv_data_sz,
+				NULL, NULL, NULL, NULL,
+				rte_socket_id(), flags);
+	} else {
+		recv_ring = rte_ring_lookup(_PRI_2_SEC);
+		send_ring = rte_ring_lookup(_SEC_2_PRI);
+		message_pool = rte_mempool_lookup(_MSG_POOL);
+	}
+	/* >8 End of ring structure. */
+	if (send_ring == NULL)
+		rte_exit(EXIT_FAILURE, "Problem getting sending ring\n");
+	if (recv_ring == NULL)
+		rte_exit(EXIT_FAILURE, "Problem getting receiving ring\n");
+	if (message_pool == NULL)
+		rte_exit(EXIT_FAILURE, "Problem getting message pool\n");
 #endif
 
 	/* allocate port structures, and init them */
-- 
2.27.0

