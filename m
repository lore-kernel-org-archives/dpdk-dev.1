Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8F7CAC58D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 10:25:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A43FE40652;
	Thu, 11 Sep 2025 12:25:15 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 5F47E402D3
 for <dev@dpdk.org>; Thu, 11 Sep 2025 12:25:14 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b4f7053cc38so364591a12.2
 for <dev@dpdk.org>; Thu, 11 Sep 2025 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1757586313;
 x=1758191113; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARK6XIFWd8xlJzKY2DX8phHAfQF16K5g8i3xZBeEHT8=;
 b=JyLifBd47UuSJli5aR33xFzETgt/bw0HmxL1dVDkGJJaHqcjkdPb+izulpZtjU5glc
 hffrV/9051RNFY2JB3zCqJUvooipfyb8N9KnFkFsozOys4o0g7wXGRpX+niKQOH+I+HG
 D7r/bmb0zSfZGv32mcqCYvd+k4t9xpcRoowgtUnCLkO4ttsCPBoDPWx4i1bXGTkg45n8
 5hL/uMXguxsZbd7BDbl9wvzPbZ8j/MLuhikNxgSqZgldmdRT28rT+/NIrv7eNQ+My3ob
 C+DhUauxvdnNKvvuozCY9G+BbbJSesrLOr8wxERzQeEo3wLPOc1i4BJ16XQZbblJ07EA
 Ql+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757586313; x=1758191113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ARK6XIFWd8xlJzKY2DX8phHAfQF16K5g8i3xZBeEHT8=;
 b=XYED2iQ42EqYwqTm0mCMXjs3VNIoCXEJQLenDtP9NVSe5a+t4DGqrQVnIJH/SVf4Y0
 lOBGoofUODN3LDHfn/VGYSCyOBYZjkvnF0l+gnSkfhsx8bij5G0k1Zrb1eyh0xmB0GCv
 /LLU1wb3n+mlZHpbXai2+ieztisvgKP4hMmgsn5MI7EDpCp5t9mEjoMcAQmUdH/6CFWT
 oyrNJEVilhZSdjdMoHclgTWPcDyg2fLc9bi8FF/RLUywcDskjv1GQMOdRLV/vkk8ZK3V
 qnFKrftgbobyyprKURPU2oxPoipqVdPuhsO4oYd7MxZDFjuYw2rtTcHTBBxTIK4aopfa
 ptbA==
X-Gm-Message-State: AOJu0YxvE0DmzXTKpiGItyCXAdSwJgH6VEnPBQL1qfJGr4fKssDv6k8V
 /K3/TPwcuqyB7XEiLRWVtZ/VfITTkDyvrAatAq164bc0Y/TzkLtsf7vVAdElGu+ooR4=
X-Gm-Gg: ASbGncvtjusYAvraD3L2sx7h+j+Nmg9SjiNq73Osy5u+S4EnZLjZhqEBOgdNRBhRnWV
 jF/dXJBcegKfAYOKb6C6YaYVAhxoVBaJ6XPEh98SnuUwHifE/Uoxt2bWU6xbRl8mq/z5euArVuE
 XpRgIokRgN4IQiNQpnDTgAAsHGA7CWjJ8lg4T9tIYA3KURnFUhnedrG6G5IGLMZY0AsTXuOzBVY
 Qa2DcpdX/h0MhWT50tEqtQRJIHSCnQOQMub922RgdjCfO5/s8PrJPPZTQ62maYoan9k5rsMu853
 GT2VJq6rgNFV6k/FcIe10frrnIQ/HaVuZ4ZraGmNKuhmR9drH3Re+LB5vF0CdzIHw9Q8LCqKs25
 Fk/b8SxfM1DZVfnXbl4F5/e+Voqonn3/RgUJ7oDph3PKsXDRCi1SRFi23cRN4Edz0m+hQZurJmW
 rpSS/XyA5Au62wZjK2ep/eSfz0UZD7BjuLzSdeztjurGFBFmM1GwSj06O4nmFZeY/VTBWmvS33R
 L4ojsT3Y63woWtF/Bkx5XX9GvOaybnkLulf4WCcg7VnqO8=
X-Google-Smtp-Source: AGHT+IHtF0P1F6ZcteGasm7EUFZckUYfuuOZ+hY9XExh5jvA2ugkA8iVHuYss9LjFlBp3/UUb7O49g==
X-Received: by 2002:a17:90b:578c:b0:32b:ca6f:1234 with SMTP id
 98e67ed59e1d1-32d43fca56cmr22390269a91.30.1757586313410; 
 Thu, 11 Sep 2025 03:25:13 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32dd6318debsm2170422a91.20.2025.09.11.03.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 03:25:13 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Lijun Ou <oulijun@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org
Subject: [PATCH v2] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
Date: Thu, 11 Sep 2025 03:25:01 -0700
Message-Id: <20250911102501.473167-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250910110237.460825-1-14pwcse1224@uetpeshawar.edu.pk>
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
 app/test-pmd/testpmd.c | 65 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..c325e3a7cb 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -102,9 +102,17 @@
 uint16_t verbose_level = 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
 
+#ifndef RTE_EXEC_ENV_WINDOWS
 /* Maximum delay for exiting after primary process. */
-#define MONITOR_INTERVAL (500 * 1000)
-
+#define MONITOR_INTERVAL (500)
+#define STR_SIZE 128
+static const char *_MSG_POOL = "MSG_POOL";
+static const char *_SEC_2_PRI = "SEC_2_PRI";
+static const char *_PRI_2_SEC = "PRI_2_SEC";
+
+struct rte_ring *send_ring, *recv_ring;
+struct rte_mempool *message_pool;
+#endif
 /* use main core for command line ? */
 uint8_t interactive = 0;
 uint8_t auto_start = 0;
@@ -2563,7 +2571,8 @@ stop_packet_forwarding(void)
 	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++)
 		fwd_lcores[lc_id]->stopped = 1;
 	printf("\nWaiting for lcores to finish...\n");
-	rte_eal_mp_wait_lcore();
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_eal_mp_wait_lcore();
 	port_fwd_end = cur_fwd_config.fwd_eng->port_fwd_end;
 	if (port_fwd_end != NULL) {
 		for (i = 0; i < cur_fwd_config.nb_fwd_ports; i++) {
@@ -3634,6 +3643,18 @@ pmd_test_exit(void)
 			printf("\nStopping port %d...\n", pt_id);
 			fflush(stdout);
 			stop_port(pt_id);
+
+#ifndef RTE_EXEC_ENV_WINDOWS
+			printf("Stopping secondary processes ...\n");
+			void *msg = NULL;
+			if (rte_mempool_get(message_pool, &msg) < 0)
+				rte_panic("Failed to get message buffer\n");
+			strlcpy((char *)msg, "stop", STR_SIZE);
+			if (rte_ring_enqueue(send_ring, msg) < 0) {
+				printf("Failed to send message - message discarded\n");
+				rte_mempool_put(message_pool, msg);
+			}
+#endif
 		}
 		RTE_ETH_FOREACH_DEV(pt_id) {
 			printf("\nShutting down port %d...\n", pt_id);
@@ -4370,8 +4391,19 @@ signal_handler(int signum __rte_unused)
 static void
 monitor_primary(void *arg __rte_unused)
 {
+	void *msg;
 	if (rte_eal_primary_proc_alive(NULL)) {
-		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+		if (rte_ring_dequeue(recv_ring, &msg) < 0) {
+			rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+		} else {
+			/* Stopping any number of secondary processes fwd_egines */
+			recv_ring->prod.head = 0;
+			recv_ring->prod.tail = 0;
+			rte_mempool_put(message_pool, msg);
+			stop_packet_forwarding();
+			fprintf(stderr, "\nPrimary process is no longer active exiting...\n");
+			exit(EXIT_FAILURE);
+		}
 	} else {
 		/*
 		 * If primary process exits, then all the device information
@@ -4429,9 +4461,34 @@ main(int argc, char** argv)
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
+				STR_SIZE, pool_cache, priv_data_sz,
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

